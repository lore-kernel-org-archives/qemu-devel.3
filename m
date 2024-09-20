Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC470C78829
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 11:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srbxO-0003AV-Pg; Fri, 20 Sep 2024 07:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1srbxM-00036X-Cr
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 07:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1srbxK-0005hK-Sb
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 07:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726832263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s0wUYhjHcz8ouBrCbnWMVRu7sKK7GW2MToPrNPgbau0=;
 b=BJe3UXhuzwYTaKTMkKa6ptkPYZF7JXpxGMYjeV2BA0XMxP93MG/prYzp0sKB+cwC4Q/pCu
 VqfmTC8/J3LO+cKYMwWQWguK+D0Hb75+Ym4BUaf76UwJdGX81PMB+DClWrosymrXPcDlp8
 WjGGWOtYBAOIhgj8obi64h4yUrmBW/c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-cVIP2_IuOwiV9oNAyo9dtw-1; Fri,
 20 Sep 2024 07:37:40 -0400
X-MC-Unique: cVIP2_IuOwiV9oNAyo9dtw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4F0019371D6; Fri, 20 Sep 2024 11:37:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27FB81956052; Fri, 20 Sep 2024 11:37:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A3DCF21E6A28; Fri, 20 Sep 2024 13:37:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,  qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org,  palmer@dabbelt.com,  alistair.francis@wdc.com,
 liwei1518@gmail.com,  bmeng.cn@gmail.com,  richard.henderson@linaro.org,
 Swung0x48 <swung0x48@outlook.com>,  TANG Tiancheng
 <tangtiancheng.ttc@alibaba-inc.com>
Subject: Re: [PATCH v4 02/12] tcg/riscv: Add basic support for vector
In-Reply-To: <e1ecceab-084e-4864-a361-e5f06fa4b57d@ventanamicro.com> (Daniel
 Henrique Barboza's message of "Fri, 20 Sep 2024 08:26:52 -0300")
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-3-zhiwei_liu@linux.alibaba.com>
 <e1ecceab-084e-4864-a361-e5f06fa4b57d@ventanamicro.com>
Date: Fri, 20 Sep 2024 13:37:34 +0200
Message-ID: <87a5g2imip.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> Hi Zhiwei,
>
> As Rixchard already pointed out, we must have a "Signed-off-by" tag with the "author" of
> the patch, and it must be the exact spelling. So in this case:
>
> Signed-off-by: Swung0x48 <swung0x48@outlook.com>

I'm afraid we need a legal name here, not a nickname.

> More info here:
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html

[...]


