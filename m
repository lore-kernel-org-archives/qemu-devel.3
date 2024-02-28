Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EDFC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfG4Q-0002N0-Cy; Wed, 28 Feb 2024 04:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfG4N-0002Lp-T3
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:17:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfG4M-0002k4-Gj
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709111861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ljxYO9zkFv3rjCkGwgPT120Y6DvwIv2Nzc+Adzd6Pw=;
 b=FzqaSthxT+WTRBb1Pwa/ZvK8se2XsrZ7okkbxx2yCi8WszmlO6CXLAPe7ZDDUA8y5ucuSv
 GUpsTsxLtV/G1UBic3sNcABoac1XkULTO2AA4G5O4b+pTJ2vSFpuObE1V5vhhIRdvA6KS6
 IQlHMjMoYGkNnqGGlCObwNgxhpnQxzA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-jm-Ld2OZP2mqjcjukqgLdA-1; Wed, 28 Feb 2024 04:17:36 -0500
X-MC-Unique: jm-Ld2OZP2mqjcjukqgLdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C9DB88F9E6;
 Wed, 28 Feb 2024 09:17:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE5441C060AF;
 Wed, 28 Feb 2024 09:17:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7D3621E66F9; Wed, 28 Feb 2024 10:17:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Michael
 S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,  Jason Wang
 <jasowang@redhat.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH v7 12/16] hw/pci: Replace -1 with UINT32_MAX for romsize
In-Reply-To: <20240224-reuse-v7-12-29c14bcb952e@daynix.com> (Akihiko Odaki's
 message of "Sat, 24 Feb 2024 18:24:44 +0900")
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
 <20240224-reuse-v7-12-29c14bcb952e@daynix.com>
Date: Wed, 28 Feb 2024 10:17:34 +0100
Message-ID: <874jdt2bip.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> romsize is an uint32_t variable. Specifying -1 as an uint32_t value is
> obscure way to denote UINT32_MAX.
>
> Worse, if int is wider than 32-bit, it will change the behavior of a
> construct like the following:
> romsize = -1;
> if (romsize != -1) {
>     ...
> }
>
> When -1 is assigned to romsize, -1 will be implicitly casted into
> uint32_t, resulting in UINT32_MAX. On contrary, when evaluating
> romsize != -1, romsize will be casted into int, and it will be a
> comparison of UINT32_MAX and -1, and result in false.
>
> Fix these issues by replacing -1 with UINT32_MAX for statements
> involving the variable.

Could be viewed as cleanup instead of fix, given how unlikely int wider
than 32 bits is.  Observation, not a demand :)

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


