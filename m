Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05C5C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6UUL-0002g9-1F; Tue, 15 Sep 2026 10:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6UUE-0002fq-Jl
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6UUB-0004kj-Mo
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789483812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nBr+J2UKK5GE2wxuMX+eVSKgU2kbfwama1gIPCWecc4=;
 b=Co9f9mlExZjtviTum9PmJD/PL3XLtssCBL/ztxjHzwrLcWvM5aErZIkKr4utPXHii+LsFc
 fe8BOMKrpYuor+deH1S5+73gEiZbXatkbYFiQ2brZjE+o+934IYEGMh6G5G3Cag8zVpa/K
 60GhoHUS4A3vAsJFny2bK5DGtMdj4PY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-B6mBW6R4OC2tmflDFk_Vag-1; Tue,
 15 Sep 2026 10:50:10 -0400
X-MC-Unique: B6mBW6R4OC2tmflDFk_Vag-1
X-Mimecast-MFC-AGG-ID: B6mBW6R4OC2tmflDFk_Vag_1789483810
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BE41955D6F; Tue, 15 Sep 2026 14:50:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 786BE3003EEE; Tue, 15 Sep 2026 14:50:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E968021E6A04; Tue, 15 Sep 2026 16:50:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] qemu-option: Cope with a missing QemuOptsList
In-Reply-To: <20260915134412.4187164-1-farosas@suse.de> (Fabiano Rosas's
 message of "Tue, 15 Sep 2026 10:44:12 -0300")
References: <20260915134412.4187164-1-farosas@suse.de>
Date: Tue, 15 Sep 2026 16:50:06 +0200
Message-ID: <87wlsmfu1t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> It's a common pattern in vl.c to chain the qemu_find_opts() output
> into the first argument of qemu_opts_parse_noisily():
>
> opts = qemu_opts_parse_noisily(qemu_find_opts("spice"), optarg, false);
> if (!opts) {
>     exit(1);
> }
>
> In cases such as spice that have the group defined in the module file,
> it's possible to reach qemu_opts_parse_noisily() with a NULL QemuOptsList if
> the module is not present in the host filesystem.
>
>   $ ../configure --enable-modules --enable-spice
>   $ make
>   $ mv qemu-bundle/usr/local/lib64/qemu/ui-spice-core.so{,.not}
>   $ ./qemu-system-x86_64 -spice a
>   qemu-system-x86_64: -spice a: There is no option group 'spice'
>   Segmentation fault (core dumped)
>
> Return NULL from qemu_opts_parse_noisily() if there is no list.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  util/qemu-option.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 9fbf425f86..0ec12d252c 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -945,6 +945,10 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
>      QemuOpts *opts;
>      bool help_wanted = false;
>  
> +    if (!list) {
> +        return NULL;
> +    }
> +
>      opts = opts_parse(list, params, permit_abbrev, true,
>                        opts_accepts_any(list) ? NULL : &help_wanted,
>                        &err);

Before the patch, qemu_opts_parse_noisily() either

* Succeeds and returns non-null

* Fails, reports an error, and returns null

* Prints help and returns null

Your patch adds a fourth case:

* Fails silently and returns null

I dislike this case.  Functions should either always print something
whent they fail, or never.

Are all callers prepared for silent failure?

The pattern you quoted in the commit message is, because
qemu_find_opts() reports an error.

Here's a cleaner solution for this pattern.  Replace

    opts = qemu_opts_parse_noisily(qemu_find_opts(...), ...)

by a call of a new helper function that does

    list = qemu_find_opts(...);
    if (!list) {
        return NULL;
    }
    return qemu_opts_parse_noisily(list, ...);

Thoughts?


