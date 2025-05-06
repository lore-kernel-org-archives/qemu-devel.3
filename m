Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0B8C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 16:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCLcG-0007qE-PV; Tue, 06 May 2025 12:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCLcE-0007q2-FI
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCLcC-000541-LK
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746550674;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HNYKar3vW2DpHyoGXSUqrSE39ldWu9YWlou3Q6Fp8IA=;
 b=ASpFPHqSyGvpdTtaV99Vtvwg6P1z4ynhD9ava2QguuFp5ojk5uQ5nKM8Oy1TxEwDJc9c25
 QTwyGcJ2ZlDYx8FSjRuPGY4pEhIUbjrAZi53l3LWCPBwfw/WIzubRNviM4HDiSyZCZUo38
 Aze9vP+nBvWkmBVE8kiYJWtybpRZybM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-PNi7-g-YP0SRGR7Im06ToA-1; Tue,
 06 May 2025 12:57:51 -0400
X-MC-Unique: PNi7-g-YP0SRGR7Im06ToA-1
X-Mimecast-MFC-AGG-ID: PNi7-g-YP0SRGR7Im06ToA_1746550670
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B6721955D52; Tue,  6 May 2025 16:57:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B94A01956096; Tue,  6 May 2025 16:57:48 +0000 (UTC)
Date: Tue, 6 May 2025 17:57:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: WorksButNotTested <jonwilson030981@googlemail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] Support madvise(MADV_DONTDUMP) when creating core
 dumps for qemu-user
Message-ID: <aBo_HWA4nuY7FGul@redhat.com>
References: <20250506164602.1292446-1-62701594+WorksButNotTested@users.noreply.github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506164602.1292446-1-62701594+WorksButNotTested@users.noreply.github.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 06, 2025 at 05:46:02PM +0100, WorksButNotTested wrote:
> When running applications which make large (sparsely populated) address ranges
> (e.g. when using address sanitizer with LibAFL) the inability to exclude these
> regions from any core dump can result in very large files which fill the disk.
> A coredump is obvously very useful for performing a post-mortem when fuzzing.
> 
> Whilst the man pages state that madvise provides only a hint (and hence can be
> ignored), this patch adds support to handle MADV_DONTDUMP and set a
> corresponding flag in the page flags, thus allowing QEMU to exclude these
> regions from the core file.
> 
> Signed-off-by: WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>

Any reason you've not used your "jonwilson030981@googlemail.com"
address for this.

This github alias rejects any mail delivery, so also should not
be CC'd on the patch either, as that triggers failures when
reviewers reply to this submission.

> ---
>  include/exec/page-protection.h |  6 ++++++
>  linux-user/elfload.c           |  4 ++++
>  linux-user/mmap.c              | 18 ++++++++++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
> index c43231af8b..f8826d917e 100644
> --- a/include/exec/page-protection.h
> +++ b/include/exec/page-protection.h
> @@ -38,4 +38,10 @@
>   */
>  #define PAGE_PASSTHROUGH 0x0800
>  
> +/*
> + * For linux-user, indicates that the page should not be included in a core 
> + * dump.
> + */
> +#define PAGE_DONTDUMP   0x1000
> +
>  #endif
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index fbfdec2f17..41c46da055 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -4067,6 +4067,10 @@ static size_t vma_dump_size(target_ulong start, target_ulong end,
>          return 0;
>      }
>  
> +    if (flags & PAGE_DONTDUMP) {
> +        return 0;
> +    }
> +
>      /*
>       * Usually we don't dump executable pages as they contain
>       * non-writable code that debugger can read directly from
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index f88a80c31e..016063a8cf 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1247,6 +1247,24 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
>       */
>      mmap_lock();
>      switch (advice) {
> +    case MADV_DONTDUMP:
> +        if (len > 0) {
> +            /*
> +             * To set the page permissons, we must OR our new flags with the
> +             * existing flags. Only mark the pages as PAGE_DONTDUMP if the
> +             * entire range has the same flags. If any part of the range
> +             * differs, we would need to process it one page at a time which
> +             * might not be very performant. Since we are not obliged to respect
> +             * this flag, we will support it for the most likely usage scenario.
> +             * Note that we don't set PAGE_ANON, since this can only be set with
> +             * new mappings.
> +             */
> +            int flg = page_get_flags(start);
> +            if (page_check_range(start, len, flg)) {
> +                page_set_flags(start, start + len - 1, PAGE_DONTDUMP | (flg & ~PAGE_ANON) );
> +            }
> +        }
> +        break;
>      case MADV_WIPEONFORK:
>      case MADV_KEEPONFORK:
>          ret = -EINVAL;
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


