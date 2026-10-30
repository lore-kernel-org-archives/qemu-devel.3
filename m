Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE0606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JoUaaD3y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrwT-00044h-WD; Fri, 30 Oct 2026 15:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMrwS-00044Q-II
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMrwQ-0005ZL-3h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793387221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d24tjOjYQ5d9zJidYEDDnM8XQZK7B0R2+BKBltondwg=;
 b=JoUaaD3yGhyAfb81kmMq7DeAdX59vdLCj42vMZXv9Efju0moCCzim9mxzJFvwZwWaHiLkT
 G27/WRuEFo/z6w7Sz4HyEB/p4WjkJ7w5q2c6vH2ADu/vLoiCsz25znO9IghZI0rweo2KKQ
 6vkHAawQXMtkBIPTD9dX8rHdod4rbeM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-oLqtOte3MHayKS6qGt73iQ-1; Fri,
 30 Oct 2026 15:06:58 -0400
X-MC-Unique: oLqtOte3MHayKS6qGt73iQ-1
X-Mimecast-MFC-AGG-ID: oLqtOte3MHayKS6qGt73iQ_1793387217
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52C5C1955D98; Fri, 30 Oct 2026 19:06:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.76])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FDB01800347; Fri, 30 Oct 2026 19:06:52 +0000 (UTC)
Date: Fri, 30 Oct 2026 20:06:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/3] block: support measure for commit
Message-ID: <auTqyiE15f9XdGOP@redhat.com>
References: <20260915140444.1223798-1-jean-louis@dupond.be>
 <20260915140444.1223798-3-jean-louis@dupond.be>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915140444.1223798-3-jean-louis@dupond.be>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 15.09.2026 um 16:04 hat Jean-Louis Dupond geschrieben:
> Add a new option to qemu-img measure to specify the base node you want
> to merge the image into.
> This will open all the images between top and base, and calculate the
> size required for merging this layer into the base image.
> 
> Also modify the calculation so it takes into account the
> discard-no-unref setting of the base image.
> If discard-no-unref is enabled on the base, discarded blocks in the
> layers above the base will not free clusters in the base image, but will
> only mark them ZERO.
> 
> [1]: https://gitlab.com/qemu-project/qemu/-/issues/2369
> 
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>

I think we need to make it clearer what this interface is for, because
specifying a base file doesn't immediately make me think of committing
to that base file. 'qemu-img convert' has a -B option that specifies a
base file, and the meaning there would be that any data that can already
be read from the base file is _not_ written to the output file.

> diff --git a/block.c b/block.c
> index 9763137d8c..acc77777ed 100644
> --- a/block.c
> +++ b/block.c
> @@ -6091,7 +6091,8 @@ int64_t coroutine_fn bdrv_co_get_allocated_file_size(BlockDriverState *bs)
>   * If an error occurs the @errp pointer is set.
>   */
>  BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
> -                               BlockDriverState *in_bs, Error **errp)
> +                               BlockDriverState *in_bs,
> +                               BlockDriverState *base_bs, Error **errp)
>  {
>      IO_CODE();
>      if (!drv->bdrv_measure) {
> @@ -6100,7 +6101,7 @@ BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
>          return NULL;
>      }
>  
> -    return drv->bdrv_measure(opts, in_bs, errp);
> +    return drv->bdrv_measure(opts, in_bs, base_bs, errp);
>  }
>  
>  /**
> diff --git a/block/crypto.c b/block/crypto.c
> index 36abb7af46..e0236b3382 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -634,6 +634,7 @@ block_crypto_co_getlength(BlockDriverState *bs)
>  
>  static BlockMeasureInfo *block_crypto_measure(QemuOpts *opts,
>                                                BlockDriverState *in_bs,
> +                                              BlockDriverState *base_bs,
>                                                Error **errp)
>  {
>      g_autoptr(QCryptoBlockCreateOptions) create_opts = NULL;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7292dd036c..ee9c815830 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5225,7 +5225,7 @@ static coroutine_fn GRAPH_RDLOCK int qcow2_co_flush_to_os(BlockDriverState *bs)
>  }
>  
>  static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
> -                                       Error **errp)
> +                                       BlockDriverState *base_bs, Error **errp)
>  {
>      Error *local_err = NULL;
>      BlockMeasureInfo *info;
> @@ -5241,6 +5241,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>      bool has_backing_file;
>      bool has_luks;
>      bool extended_l2;
> +    bool base_discard_no_unref = false;
>      size_t l2e_size;
>  
>      /* Parse image creation options */
> @@ -5321,6 +5322,13 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>              goto err;
>          }
>  
> +        if (base_bs && base_bs->drv &&
> +            !strcmp(base_bs->drv->format_name, "qcow2")) {
> +            BDRVQcow2State *base_s = base_bs->opaque;
> +
> +            base_discard_no_unref = base_s->discard_no_unref;
> +        }

The driver check should be base_bs->drv == &bdrv_qcow2.

But more importantly, this is the only case that actually makes sense
because the output file _is_ the base image. If the base image actually
has a different format than the driver than runs bdrv_measuer(), the
result is garbage.

So how about fixing 'qemu-img measure' to forbid this case (i.e.
specifying the base automatically takes the driver from the base and
it's incompatible with specifying an output format) and just asserting
it here like this:

    if (base_bs) {
        BDRVQcow2State *base_s = base_bs->opaque;
        assert(base_bs->drv == &bdrv_qcow2);

        base_discard_no_unref = base_s->discard_no_unref;
    }

>          virtual_size = ROUND_UP(ssize, cluster_size);
>  
>          if (has_backing_file) {
> @@ -5336,8 +5344,10 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>  
>              for (offset = 0; offset < ssize; offset += pnum) {
>                  int ret;
> +                int retp = 0;
> +                bool count = false;
>  
> -                ret = bdrv_block_status_above(in_bs, NULL, offset,
> +                ret = bdrv_block_status_above(in_bs, base_bs, offset,
>                                                ssize - offset, &pnum, NULL,
>                                                NULL);
>                  if (ret < 0) {
> @@ -5346,15 +5356,67 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>                      goto err;
>                  }
>  
> -                if (ret & BDRV_BLOCK_ZERO) {
> +                if (ret & BDRV_BLOCK_ZERO && !base_bs) {
>                      /* Skip zero regions (safe with no backing file) */
> -                } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
> -                           (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
> -                    /* Extend pnum to end of cluster for next iteration */
> -                    pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
> -
> -                    /* Count clusters we've seen */
> -                    required += offset % cluster_size + pnum;
> +                } else {
> +                    /*
> +                     * If there is a base image in the chain, query its
> +                     * allocation status for this region so we can decide
> +                     * whether the cluster survives a commit into the base.
> +                     */
> +                    if (base_bs) {
> +                        int64_t pnum_base = 0;
> +                        retp = bdrv_block_status(base_bs, offset,
> +                                            ssize - offset, &pnum_base, NULL,
> +                                            NULL);
> +                        if (retp < 0) {
> +                            error_setg_errno(&local_err, -retp,
> +                                    "Unable to get block status of the base");
> +                            goto err;
> +                        }
> +                        /*
> +                         * If the base contiguous block is smaller,
> +                         * use that pnum, so the next iteration starts with
> +                         * the smallest offset.
> +                         */
> +                        if (pnum_base > 0 && pnum_base < pnum) {
> +                            pnum = pnum_base;
> +                        }
> +                    }
> +
> +                    if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
> +                        (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {

Doesn't BDRV_BLOCK_DATA automatically imply BDRV_BLOCK_ALLOCATED?

> +                        /* The overlay has its own data here; it is written. */
> +                        count = true;
> +                    } else if (base_discard_no_unref) {
> +                        /*
> +                         * With discard-no-unref enabled on the base, clusters
> +                         * allocated in the base keep their reference when the
> +                         * overlay is committed (discarded clusters are only
> +                         * marked zero), so count any cluster that has a valid
> +                         * offset in the base.
> +                         */
> +                        count = (retp & BDRV_BLOCK_OFFSET_VALID) != 0;

This condition seems wrong. Encrypted clusters don't have a valid
offset, but they still need to be counted.

Isn't the correct condition BDRV_BLOCK_DATA like above, just for retp
instead of ret?

> +                    } else {
> +                        /*
> +                         * Without discard-no-unref, committing the overlay
> +                         * frees the base clusters that the overlay discards
> +                         * (the overlay marks them zero). Every other cluster
> +                         * that is allocated in the base is retained, so count
> +                         * it unless the overlay zeroes it out.
> +                         */
> +                        count = (retp & BDRV_BLOCK_ALLOCATED) &&
> +                                !((ret & BDRV_BLOCK_ALLOCATED) &&
> +                                  (ret & BDRV_BLOCK_ZERO));

BDRV_BLOCK_ALLOCATED doesn't mean that it uses space, it could already
be a zero cluster. I think you want to check BDRV_BLOCK_DATA here again.

For the second half of the condition, BDRV_BLOCK_ZERO should imply
BDRV_BLOCK_ALLOCATED.

> +                    }
> +
> +                    if (count) {
> +                        /* Extend pnum to end of cluster for next iteration */
> +                        pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
> +
> +                        /* Count clusters we've seen */
> +                        required += offset % cluster_size + pnum;
> +                    }
>                  }
>              }
>          }
> diff --git a/block/raw-format.c b/block/raw-format.c
> index a57c2922d5..8efa86c8b0 100644
> --- a/block/raw-format.c
> +++ b/block/raw-format.c
> @@ -369,7 +369,7 @@ raw_co_getlength(BlockDriverState *bs)
>  }
>  
>  static BlockMeasureInfo *raw_measure(QemuOpts *opts, BlockDriverState *in_bs,
> -                                     Error **errp)
> +                                     BlockDriverState *base_bs, Error **errp)
>  {
>      BlockMeasureInfo *info;
>      int64_t required;
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index b0c798b77a..3d9052c4bb 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -632,7 +632,7 @@ Command description:
>    For more information, consult ``include/block/block.h`` in QEMU's
>    source code.
>  
> -.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
> +.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [-b BASE] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
>  
>    Calculate the file size required for a new image.  This information
>    can be used to size logical volumes or SAN LUNs appropriately for
> @@ -649,6 +649,13 @@ Command description:
>  
>    A snapshot in an existing image can be specified using *SNAPSHOT_PARAM*.
>  
> +  If *BASE* is given, open the backing chain of *FILENAME* up to and
> +  including the image *BASE*, and calculate the file size that *BASE*
> +  will occupy after *FILENAME* is committed into it (i.e. the size of
> +  the merged image).  This is different from the default behaviour,
> +  which calculates the size of a standalone copy of *FILENAME*.
> +  *BASE* has to be part of the backing chain of *FILENAME*.
> +
>    The following fields are reported:
>  
>    ::
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index d34d846bb2..c0abd646d0 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -92,7 +92,8 @@ int64_t co_wrapper_bdrv_rdlock
>  bdrv_get_allocated_file_size(BlockDriverState *bs);
>  
>  BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
> -                               BlockDriverState *in_bs, Error **errp);
> +                               BlockDriverState *in_bs,
> +                               BlockDriverState *base_bs, Error **errp);
>  
>  int coroutine_fn GRAPH_RDLOCK
>  bdrv_co_delete_file(BlockDriverState *bs, Error **errp);
> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
> index 147c08155f..b99b1a7d7d 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -731,7 +731,7 @@ struct BlockDriver {
>          BlockDriverState *bs);
>  
>      BlockMeasureInfo *(*bdrv_measure)(QemuOpts *opts, BlockDriverState *in_bs,
> -                                      Error **errp);
> +                                      BlockDriverState *base_bs, Error **errp);
>  
>      int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_pwritev_compressed)(
>          BlockDriverState *bs, int64_t offset, int64_t bytes,
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 6bc8265cfb..f3f5c63773 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -78,9 +78,9 @@ SRST
>  ERST
>  
>  DEF("measure", img_measure,
> -"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
> +"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] [-b base] filename]")
>  SRST
> -.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
> +.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] [-b BASE] FILENAME]
>  ERST
>  
>  DEF("snapshot", img_snapshot,
> diff --git a/qemu-img.c b/qemu-img.c
> index 2f63d31141..0567067ec2 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -5694,6 +5694,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>      BlockBackend *in_blk = NULL;
>      BlockDriver *drv;
>      const char *filename = NULL;
> +    const char *base_filename = NULL;
>      const char *fmt = NULL;
>      const char *out_fmt = "raw";
>      char *options = NULL;
> @@ -5705,6 +5706,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>      QemuOptsList *create_opts = NULL;
>      bool image_opts = false;
>      int64_t img_size = -1;
> +    BlockDriverState *base_bs = NULL;
>      BlockMeasureInfo *info = NULL;
>      Error *local_err = NULL;
>      int ret = 1;
> @@ -5717,6 +5719,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>          {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>          {"source-image-opts", no_argument, 0, OPTION_IMAGE_OPTS}, /* img_convert */
>          {"snapshot", required_argument, 0, 'l'},
> +        {"base", required_argument, 0, 'b'},
>          {"target-format", required_argument, 0, 'O'},
>          {"target-format-options", required_argument, 0, 'o'}, /* img_convert */
>          {"options", required_argument, 0, 'o'},
> @@ -5727,11 +5730,11 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>          {0, 0, 0, 0}
>      };
>  
> -    while ((c = getopt_long(argc, argv, "hf:l:O:o:Us:",
> +    while ((c = getopt_long(argc, argv, "hf:l:b:O:o:Us:",
>                              long_options, NULL)) != -1) {
>          switch (c) {
>          case 'h':
> -            cmd_help(ccmd, "[-f FMT|--image-opts] [-l SNAPSHOT]\n"
> +            cmd_help(ccmd, "[-f FMT|--image-opts] [-l SNAPSHOT] [-b BASE]\n"
>  "       [-O TARGET_FMT] [-o TARGET_FMT_OPTS] [--output human|json]\n"
>  "       [--object OBJDEF] (--size SIZE | FILE)\n"
>  ,
> @@ -5742,6 +5745,8 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>  "     instead of a file name (incompatible with --format)\n"
>  "  -l, --snapshot SNAPSHOT\n"
>  "     use this snapshot in FILE as source\n"
> +"  -b, --base BASE\n"
> +"     open FILE backing chain up to BASE (inclusive)\n"

This is technically true in the common case (it isn't for --image-opts),
but an irrelevant implementation detail that doesn't tell anything about
what you'd use it for.

This should say something about measuring the size of BASE after
committing FILE to it.

As I said above, --base could also have a different meaning, so we might
think of a more descriptive name like --commit-base. Not sure what a
good short option name for it would be - maybe it doesn't even need one.

>  "  -O, --target-format TARGET_FMT\n"
>  "     desired target/output image format (default: raw)\n"
>  "  -o TARGET_FMT_OPTS\n"

Kevin


