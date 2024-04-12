Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401F0C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 15:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvIms-00071u-G0; Fri, 12 Apr 2024 11:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rvImp-000700-G1
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 11:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rvImm-00057o-Hg
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 11:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712935550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qlfx2lsK5nwDUy06hM+gv+x2aDjjoyTFA7s69nX9e7k=;
 b=JnIV3yAvask+2K0MAgSwLM5JbW7DVPGelMI5LM9W1g746QyBVQzaYn79qZGfaPYBCnigVE
 lwXJ4kjGJSUSN1RJl+N5sJKMRMrNVJN0R6MZv/x9rkUsZbXtunvqyeQYK3Roc6ng/+oABI
 5VjkSssf6mqF7LpnlLie9AiLTMsuW4Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-HaNGqprKOymV4PpUekysgg-1; Fri,
 12 Apr 2024 11:25:47 -0400
X-MC-Unique: HaNGqprKOymV4PpUekysgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B3961C0432A;
 Fri, 12 Apr 2024 15:25:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0C921121306;
 Fri, 12 Apr 2024 15:25:44 +0000 (UTC)
Date: Fri, 12 Apr 2024 10:25:39 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Fritsch <sf@sfritsch.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] dma-helpers: Fix iovec alignment
Message-ID: <dnqsifhslb7mtidrzadsz6254ykmb4bjz2cenzryonz7wbjz4g@vj56wcuwgx25>
References: <20240412080617.1299883-1-sf@sfritsch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412080617.1299883-1-sf@sfritsch.de>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 12, 2024 at 10:06:17AM +0200, Stefan Fritsch wrote:
> Commit 99868af3d0 changed the hardcoded constant BDRV_SECTOR_SIZE to a
> dynamic field 'align' but introduced a bug. qemu_iovec_discard_back()
> is now passed the wanted iov length instead of the actually required
> amount that should be removed from the end of the iov.
> 
> The bug can likely only be hit in uncommon configurations, e.g. with
> icount enabled or when reading from disk directly to device memory.
> 
> Fixes: 99868af3d0a75cf6 ("dma-helpers: explicitly pass alignment into DMA helpers")
> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> ---
>  system/dma-helpers.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Wow, that bug has been latent for a while (2016, v2.8.0).  As such, I
don't think it's worth holding up 9.0 for, but it is definitely worth
cc'ing qemu-stable (done now).

> 
> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> index 9b221cf94e..c9677fd39b 100644
> --- a/system/dma-helpers.c
> +++ b/system/dma-helpers.c
> @@ -174,8 +174,7 @@ static void dma_blk_cb(void *opaque, int ret)
>      }
>  
>      if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
> -        qemu_iovec_discard_back(&dbs->iov,
> -                                QEMU_ALIGN_DOWN(dbs->iov.size, dbs->align));
> +        qemu_iovec_discard_back(&dbs->iov, dbs->iov.size % dbs->align);

Before the regression, it was:

-    if (dbs->iov.size & ~BDRV_SECTOR_MASK) {
-        qemu_iovec_discard_back(&dbs->iov, dbs->iov.size & ~BDRV_SECTOR_MASK);
+    if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
+        qemu_iovec_discard_back(&dbs->iov,

If dbs->align is always a power of two, we can use '& (dbs->align -
1)' to avoid a hardware division, to match the original code; bug
QEMU_IS_ALIGNED does not require a power of two, so your choice of '%
dbs->align' seems reasonable.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


