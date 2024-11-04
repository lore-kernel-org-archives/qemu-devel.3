Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1DCD111BB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 08:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7s9t-0000OO-B1; Mon, 04 Nov 2024 03:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t7s9s-0000OF-2m
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:09:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t7s9p-0002GC-VB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730707791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/XL3lw3qsFQJ8VAc6o6bUhMUsG5uYSpG5HNXjkLHa4=;
 b=G/WhcrYO+wtPpbr0FUeQqzow4bFB136zHVEyxNJLx9SEfWaiLfVitdpPr6/q15GVmU4LIA
 Uuvik0P3RIFH5FgN+Z9e/AwTopLvPlmKrnzPRhTJvdP2nPgrXWzKdMXHK1+twlilfFUjce
 LGL9iY5CHqtaWq2PJJyoS2DDfuwPj6U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-cP_5aAmBPPe2D6ln8A0rzw-1; Mon,
 04 Nov 2024 03:09:50 -0500
X-MC-Unique: cP_5aAmBPPe2D6ln8A0rzw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D208195609F
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2024 08:09:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CA5F1956056
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2024 08:09:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A5AF521E6A28; Mon,  4 Nov 2024 09:09:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH] crypto: purge 'loaded' property that was documented as
 already removed
In-Reply-To: <20241030084718.2980247-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 30 Oct 2024 08:47:18
 +0000")
References: <20241030084718.2980247-1-berrange@redhat.com>
Date: Mon, 04 Nov 2024 09:09:40 +0100
Message-ID: <874j4nzagr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The 'loaded' property on TLS creds and secret objects was marked as
> deprected in 6.0.0 and then marked as removed in 7.1.0.

deprecated

Regarding "marked as removed": not quite.  Its entry was moved from
docs/about/deprecated.rst to docs/about/removed-features.rst, but the
text there is "should simply be removed."

>
> Except it wasn't actually removed, it was just made read-only, while
> claiming it was removed. Finish the long overdue removal job.
>
> Fixes: 0310641c06dd5f7ea031b2b6170cb2edc63e4cea

I'm not sure it fixes something that was broken.  Commit 0310641c06d
(crypto: make loaded property read-only) did what it said on the tin.
What it did was unusual, and maybe a bad idea.

Anyway, not important now.

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


