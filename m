Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC9ACCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZDg-00063z-TI; Tue, 30 Sep 2025 08:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v3ZDe-00063n-Eg
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v3ZDX-0005wb-0n
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759234340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QaB+m8O/JD6AEX9SHr424OiQCj0Qcogq6vcT3GVhV1w=;
 b=IDRUlmCuxWg3gjf7vw9Q+NyO5QuQ4+E3pRjo91Wp11Q7yy9pyw6ByccKcZN1GABsriikpR
 kMVGoQMnj7XHiypw+2PptY6n2DefnGnwARQVr5e5INAybzG5bVayxT5FPV1/7mn8Va51oQ
 rGig4/k0ziZQmbknv+D0mLkJQPB+08Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-4cuQ5XxZOyeTLcIcDSs3Ew-1; Tue,
 30 Sep 2025 08:12:17 -0400
X-MC-Unique: 4cuQ5XxZOyeTLcIcDSs3Ew-1
X-Mimecast-MFC-AGG-ID: 4cuQ5XxZOyeTLcIcDSs3Ew_1759234336
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C2571800562; Tue, 30 Sep 2025 12:12:15 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1837B1956056; Tue, 30 Sep 2025 12:12:11 +0000 (UTC)
Date: Tue, 30 Sep 2025 14:12:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Chandan <csomani@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH] block: enable stats-intervals for virtio-blk devs with
 -blockdev
Message-ID: <aNvJGWApjqZTJFpV@redhat.com>
References: <20250929235244.686567-1-csomani@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929235244.686567-1-csomani@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 30.09.2025 um 01:52 hat Chandan geschrieben:
> This patch allows the stats-intervals.* flag to be used with
> -blockdev. Stats collection is initialized for virtio-blk devices
> at their time of creation. However, it is limited to just virtio-blk
> devices for now.
> 
> Signed-off-by: Chandan <csomani@redhat.com>

Is it intentional that this  (and the From: header) says only "Chandan"
and not "Chandan Somani"?

One fundamental question I have with this patch is if statistics should
be collected on the BlockBackend level (which is what we're doing today)
or on the node level. This patch can't seem to decide, so you configure
things on the node level, but then the actual collection happens on the
BlockBackend level and setting on the node are ignored if it isn't
directly used by a device.

If we keep things on the BlockBackend level, then intervals shouldn't be
defined with -blockdev (which configures block nodes), but with -device
(which configures the device that owns the BlockBackend). And
conversely, if we think that things should be done on the node level,
then we need to make sure that accounting actually works on the node
level and is mostly done by the functions in block/io.c instead of the
devices.

> ---
>  block.c                          | 50 ++++++++++++++++++++++++++++++++
>  hw/block/virtio-blk.c            |  6 ++++
>  include/block/block_int-common.h |  4 +++
>  qapi/block-core.json             |  6 +++-
>  4 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/block.c b/block.c
> index 8848e9a7ed..e455d04e97 100644
> --- a/block.c
> +++ b/block.c
> @@ -38,7 +38,9 @@
>  #include "qapi/error.h"
>  #include "qobject/qdict.h"
>  #include "qobject/qjson.h"
> +#include "qobject/qlist.h"
>  #include "qobject/qnull.h"
> +#include "qobject/qnum.h"
>  #include "qobject/qstring.h"
>  #include "qapi/qobject-output-visitor.h"
>  #include "qapi/qapi-visit-block-core.h"
> @@ -3956,6 +3958,35 @@ out:
>      return bs_snapshot;
>  }
>  
> +static bool bdrv_parse_stats_intervals(BlockDriverState *bs, QList *intervals,
> +                                  Error **errp)
> +{
> +    unsigned i = 0;
> +    const QListEntry *entry;
> +    bs->num_stats_intervals = qlist_size(intervals);
> +
> +    if (bs->num_stats_intervals > 0) {
> +        bs->stats_intervals = g_new(uint64_t, bs->num_stats_intervals);
> +    }
> +
> +    for (entry = qlist_first(intervals); entry; entry = qlist_next(entry)) {
> +        if (qobject_type(entry->value) == QTYPE_QNUM) {
> +            uint64_t length = qnum_get_int(qobject_to(QNum, entry->value));
> +
> +            if (length > 0 && length <= UINT_MAX) {
> +                bs->stats_intervals[i++] = length;
> +            } else {
> +                error_setg(errp, "Invalid interval length: %" PRId64, length);
> +                return false;
> +            }
> +        } else {
> +            error_setg(errp, "The specification of stats-intervals is invalid");
> +            return false;
> +        }
> +    }
> +    return true;
> +}

This is essentially a duplication of parse_stats_intervals() in
blockdev.c. Can't we just call the existing function? Or in fact move it
here and remove the existing call from blockdev_init() because -drive
should be able to just use the per-node option that you're introducing
here, too?

>  /*
>   * Opens a disk image (raw, qcow2, vmdk, ...)
>   *
> @@ -3987,6 +4018,8 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
>      Error *local_err = NULL;
>      QDict *snapshot_options = NULL;
>      int snapshot_flags = 0;
> +    QDict *interval_dict = NULL;
> +    QList *interval_list = NULL;
>  
>      assert(!child_class || !flags);
>      assert(!child_class == !parent);
> @@ -4205,6 +4238,19 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
>          g_free(child_key_dot);
>      }
>  
> +    qdict_extract_subqdict(options, &interval_dict, "stats-intervals.");
> +    qdict_array_split(interval_dict, &interval_list);
> +
> +    if (qdict_size(interval_dict) != 0) {
> +        error_setg(errp, "Invalid option stats-intervals.%s",
> +                   qdict_first(interval_dict)->key);
> +        goto close_and_fail;
> +    }

I think I would move the above lines into bdrv_parse_stats_intervals().

> +    if (!bdrv_parse_stats_intervals(bs, interval_list, errp)) {
> +        goto close_and_fail;
> +    }
> +
>      /* Check if any unknown options were used */
>      if (qdict_size(options) != 0) {
>          const QDictEntry *entry = qdict_first(options);
> @@ -4261,6 +4307,8 @@ close_and_fail:
>      bdrv_unref(bs);
>      qobject_unref(snapshot_options);
>      qobject_unref(options);
> +    qobject_unref(interval_dict);
> +    qobject_unref(interval_list);
>      error_propagate(errp, local_err);
>      return NULL;
>  }
> @@ -5190,6 +5238,8 @@ static void GRAPH_UNLOCKED bdrv_close(BlockDriverState *bs)
>      bs->full_open_options = NULL;
>      g_free(bs->block_status_cache);
>      bs->block_status_cache = NULL;
> +    g_free(bs->stats_intervals);
> +    bs->stats_intervals = NULL;

Does this fix a preexisting memory leak for -drive?

>      bdrv_release_named_dirty_bitmaps(bs);
>      assert(QLIST_EMPTY(&bs->dirty_bitmaps));
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 9bab2716c1..b730c67940 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1814,6 +1814,12 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>                           conf->conf.lcyls,
>                           conf->conf.lheads,
>                           conf->conf.lsecs);
> +
> +    if (bs->stats_intervals) {
> +        for (i = 0; i < bs->num_stats_intervals; i++) {
> +            block_acct_add_interval(blk_get_stats(s->blk), bs->stats_intervals[i]);
> +        }
> +    }
>  }

This could be part of block_acct_setup(), which is called by
blkconf_apply_backend_options(). Then it would be available for more
devices than just virtio-blk.

>  static void virtio_blk_device_unrealize(DeviceState *dev)
> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
> index 034c0634c8..1b4b7c636d 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -1277,6 +1277,10 @@ struct BlockDriverState {
>  
>      /* array of write pointers' location of each zone in the zoned device. */
>      BlockZoneWps *wps;
> +
> +    /* Array of intervals for collecting IO stats */
> +    uint64_t *stats_intervals;
> +    unsigned int num_stats_intervals;
>  };
>  
>  struct BlockBackendRootState {
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index dc6eb4ae23..dbb53296b1 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4771,6 +4771,9 @@
>  # @force-share: force share all permission on added nodes.  Requires
>  #     read-only=true.  (Since 2.10)
>  #
> +# @stats-intervals: #optional list of intervals for collecting I/O
> +#                   statistics, in seconds (default: none)

#optional is not a marker that is used anywhere else.

Can we document why there are multiple intervals and what effect they
have on the statistics that you can query later?

We also need a '(Since 10.2)' note.

> +#
>  # Since: 2.9
>  ##
>  { 'union': 'BlockdevOptions',
> @@ -4782,7 +4785,8 @@
>              '*read-only': 'bool',
>              '*auto-read-only': 'bool',
>              '*force-share': 'bool',
> -            '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
> +            '*detect-zeroes': 'BlockdevDetectZeroesOptions',
> +            '*stats-intervals': ['int'] },
>    'discriminator': 'driver',
>    'data': {
>        'blkdebug':   'BlockdevOptionsBlkdebug',

Kevin


