Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8229CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYPc-0001tx-QO; Wed, 22 Oct 2025 08:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBYPU-0001tK-3L
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBYPS-0002sk-7z
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761137865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tpNPdL+lNIXRHblYYA9xG3AeWImXTYJxVd0Y6BliQRg=;
 b=huhPdULQmeuQM0rBsWEdWt7LJRGwcMs0sG+AIJnVh1bIQANsPX0WajKGJA74Io1XhbvmJw
 rJ0/Kcj4bBIqZYFIm9+hM2i70090UpVtNpEY2+OGk5RkNxs4MM5i4CnpOBOt2g3ChwmRfY
 GuK7SUZDpvJ/eiL9QJyLoKxYpFO1h9k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-XRbvTQwHPMexSVfMH0ajMg-1; Wed,
 22 Oct 2025 08:57:42 -0400
X-MC-Unique: XRbvTQwHPMexSVfMH0ajMg-1
X-Mimecast-MFC-AGG-ID: XRbvTQwHPMexSVfMH0ajMg_1761137861
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB0B51800C36; Wed, 22 Oct 2025 12:57:40 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.168])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C31B19560A2; Wed, 22 Oct 2025 12:57:38 +0000 (UTC)
Date: Wed, 22 Oct 2025 14:57:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 16/21] block/export: Add multi-threading interface
Message-ID: <aPjUv2YHrw_Hac0o@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-17-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701114437.207419-17-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
> Make BlockExportType.iothread an alternate between a single-thread
> variant 'str' and a multi-threading variant '[str]'.
> 
> In contrast to the single-thread setting, the multi-threading setting
> will not change the BDS's context (and so is incompatible with the
> fixed-iothread setting), but instead just pass a list to the export
> driver, with which it can do whatever it wants.
> 
> Currently no export driver supports multi-threading, so they all return
> an error when receiving such a list.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

> diff --git a/include/block/export.h b/include/block/export.h
> index 4bd9531d4d..ca45da928c 100644
> --- a/include/block/export.h
> +++ b/include/block/export.h
> @@ -32,8 +32,16 @@ typedef struct BlockExportDriver {
>      /* True if the export type supports running on an inactive node */
>      bool supports_inactive;
>  
> -    /* Creates and starts a new block export */
> -    int (*create)(BlockExport *, BlockExportOptions *, Error **);
> +    /*
> +     * Creates and starts a new block export.
> +     *
> +     * If the user passed a set of I/O threads for multi-threading, @multithread
> +     * is a list of the @multithread_count corresponding contexts (freed by the
> +     * caller).  Note that @exp->ctx has no relation to that list.

Maybe worth stating that it's NULL in the single threaded case?

> +     */
> +    int (*create)(BlockExport *exp, BlockExportOptions *opts,
> +                  AioContext *const *multithread, size_t multithread_count,
> +                  Error **errp);
>  
>      /*
>       * Frees a removed block export. This function is only called after all
> diff --git a/block/export/export.c b/block/export/export.c
> index f3bbf11070..b733f269f3 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c
> @@ -76,16 +76,26 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
>  {
>      bool fixed_iothread = export->has_fixed_iothread && export->fixed_iothread;
>      bool allow_inactive = export->has_allow_inactive && export->allow_inactive;
> +    bool multithread = export->iothread &&
> +        export->iothread->type == QTYPE_QLIST;
>      const BlockExportDriver *drv;
>      BlockExport *exp = NULL;
>      BlockDriverState *bs;
>      BlockBackend *blk = NULL;
>      AioContext *ctx;
> +    AioContext **multithread_ctxs = NULL;

g_autofree?

Kevin


