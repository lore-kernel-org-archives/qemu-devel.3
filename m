Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B17C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2PcE-00048C-O3; Fri, 04 Sep 2026 04:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2Pc6-00047D-7H
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2Pc4-0006bu-7T
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788511771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zL4MyFphZFPM2WMuuApzjuGDquH2Y8Q2heJAF2H3S3A=;
 b=c0kvRwWwcwjLxYyPTuzMyRoIRpnBG36rvMmxlMopbEdU11VljL1redOWAZxMIQktnGqPQ3
 sKcQmoQx8iolYrSzoC1diIs9zbx3TbDJJl5NSjtJoj1bcoHQdYbNCsHeTufPLFovskjuNI
 1AVqggdb9GV33gy2HNCndqALpTTM1HY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-g9ZnyfBLNlmUXNx87V88_A-1; Fri,
 04 Sep 2026 04:49:29 -0400
X-MC-Unique: g9ZnyfBLNlmUXNx87V88_A-1
X-Mimecast-MFC-AGG-ID: g9ZnyfBLNlmUXNx87V88_A_1788511768
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 756B1188699C; Fri,  4 Sep 2026 08:49:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B66301800598; Fri,  4 Sep 2026 08:49:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3043B21E6A04; Fri, 04 Sep 2026 10:49:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v7 19/25] parallels: report the stored dirty bitmaps in
 qemu-img info
In-Reply-To: <20260903144143.2328870-20-den@openvz.org> (Denis V. Lunev's
 message of "Thu, 3 Sep 2026 16:41:37 +0200")
References: <20260903144143.2328870-1-den@openvz.org>
 <20260903144143.2328870-20-den@openvz.org>
Date: Fri, 04 Sep 2026 10:49:25 +0200
Message-ID: <87mrtx9zai.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"Denis V. Lunev" <den@openvz.org> writes:

> From: Denis V. Lunev <den@openvz.org>
>
> Nothing tells which persistent bitmaps an image carries. qemu-img info
> says nothing about them, and the only other way to see one is to export
> the image over NBD and ask for a bitmap by name, which needs the name
> beforehand.
>
> Add ImageInfoSpecificParallels with the bitmaps and their granularity,
> in the same way as qcow2 reports the contents of its bitmap directory:
>
>     Format specific information:
>         bitmaps:
>             [0]:
>                 name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
>                 granularity: 65536
>
> For running VM process the list is built on the fly from in-memory
> list. This is the best we can do. FormatExtension could be dead in
> the image while VMs are running as all bitmaps are cleared on
> non-clean VM stop.

What's "FormatExtension"?
>
> A bitmap of an image which was not closed correctly is inconsistent
> and can not be used. Report that as well, the way qcow2 reports its
> in-use flag, so such a bitmap is not listed as a valid one.

This is helpful, thanks!

> The section is left empty for an image with no persistent dirty
> bitmaps, and an empty section is not printed, so the human readable
> output of "qemu-img info" and "info block" is unchanged.

Perfectly clear now.

> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  block/parallels-ext.c                         | 26 +++++++++++
>  block/parallels.c                             | 20 ++++++++
>  block/parallels.h                             |  3 ++
>  qapi/block-core.json                          | 46 ++++++++++++++++++-
>  tests/qemu-iotests/tests/parallels-checks     |  6 +++
>  tests/qemu-iotests/tests/parallels-checks.out | 19 ++++++++
>  6 files changed, 118 insertions(+), 2 deletions(-)
>
> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
> index f687f2da7c..8b8035af91 100644
> --- a/block/parallels-ext.c
> +++ b/block/parallels-ext.c
> @@ -736,3 +736,29 @@ parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>  
>      return ret;
>  }
> +
> +void parallels_get_bitmap_info_list(BlockDriverState *bs,
> +                                    ParallelsBitmapInfoList **info_list)
> +{
> +    BdrvDirtyBitmap *bitmap;
> +    ParallelsBitmapInfoList **tail = info_list;
> +
> +    *info_list = NULL;
> +
> +    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
> +        ParallelsBitmapInfo *info;
> +
> +        if (!bdrv_dirty_bitmap_get_persistence(bitmap)) {
> +            continue;
> +        }
> +
> +        info = g_new0(ParallelsBitmapInfo, 1);
> +        info->name = g_strdup(bdrv_dirty_bitmap_name(bitmap));
> +        info->granularity = bdrv_dirty_bitmap_granularity(bitmap);
> +        if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
> +            info->has_inconsistent = true;
> +            info->inconsistent = true;
> +        }
> +        QAPI_LIST_APPEND(tail, info);
> +    }
> +}
> diff --git a/block/parallels.c b/block/parallels.c
> index 2a5ceb8978..e7d65d0458 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1624,6 +1624,25 @@ static bool parallels_is_support_dirty_bitmaps(BlockDriverState *bs)
>      return 1;
>  }
>  
> +static ImageInfoSpecific * GRAPH_RDLOCK
> +parallels_get_specific_info(BlockDriverState *bs, Error **errp)
> +{
> +    ImageInfoSpecificParallels *parallels_info;
> +    ImageInfoSpecific *spec_info;
> +
> +    parallels_info = g_new0(ImageInfoSpecificParallels, 1);
> +    parallels_get_bitmap_info_list(bs, &parallels_info->bitmaps);
> +    parallels_info->has_bitmaps = !!parallels_info->bitmaps;
> +
> +    spec_info = g_new(ImageInfoSpecific, 1);
> +    *spec_info = (ImageInfoSpecific){
> +        .type = IMAGE_INFO_SPECIFIC_KIND_PARALLELS,
> +        .u.parallels.data = parallels_info,
> +    };
> +
> +    return spec_info;
> +}
> +
>  static BlockDriver bdrv_parallels = {
>      .format_name                = "parallels",
>      .instance_size              = sizeof(BDRVParallelsState),
> @@ -1653,6 +1672,7 @@ static BlockDriver bdrv_parallels = {
>                                    parallels_co_can_store_new_dirty_bitmap,
>      .bdrv_co_remove_persistent_dirty_bitmap =
>                                    parallels_co_remove_persistent_dirty_bitmap,
> +    .bdrv_get_specific_info     = parallels_get_specific_info,
>  };
>  
>  static void bdrv_parallels_init(void)
> diff --git a/block/parallels.h b/block/parallels.h
> index 27d8c3ac83..012f47320b 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -32,6 +32,7 @@
>  #ifndef BLOCK_PARALLELS_H
>  #define BLOCK_PARALLELS_H
>  #include "qemu/coroutine.h"
> +#include "qapi/qapi-types-block-core.h"
>  
>  #define HEADS_NUMBER 16
>  #define SEC_IN_CYL 32
> @@ -111,5 +112,7 @@ parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
>  int coroutine_fn GRAPH_RDLOCK
>  parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>                                              const char *name, Error **errp);
> +void parallels_get_bitmap_info_list(BlockDriverState *bs,
> +                                    ParallelsBitmapInfoList **info_list);
>  
>  #endif
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 199efc1e00..7499aea641 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -188,6 +188,35 @@
>        '*extent-size-hint': 'size'
>    } }
>  
> +##
> +# @ParallelsBitmapInfo:
> +#
> +# Parallels dirty bitmap information.
> +#
> +# @name: the name of the bitmap
> +#
> +# @granularity: granularity of the bitmap in bytes
> +#
> +# @inconsistent: true if the bitmap was improperly stored and cannot
> +#     be used

I'd recommend "if the bitmap is in an inconsistent state and".

> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'ParallelsBitmapInfo',
> +  'data': { 'name': 'str', 'granularity': 'uint32',
> +            '*inconsistent': 'bool' } }
> +
> +##
> +# @ImageInfoSpecificParallels:
> +#
> +# @bitmaps: A list of the persistent dirty bitmaps of the image,
> +#     including the ones which are not written out yet

In review of v6, I asked whether "not written out yet" relevant to a
user / management application.  You explained what it means, but didn't
actually answer my question.  I failed to point that out then, sorry.
Can you answer it now?

I also inquired about the relation to ImageInfoSpecificQCow2's @bitmaps,
and you told me they're basically the same (correct me if I
misunderstood).  I then replied that the documentation should be
basically the same, and you agreed.  Did you forget?

> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'ImageInfoSpecificParallels',
> +  'data': { '*bitmaps': ['ParallelsBitmapInfo'] } }
> +
>  ##
>  # @ImageInfoSpecificKind:
>  #
> @@ -197,10 +226,12 @@
>  #
>  # @file: Since 8.0
>  #
> +# @parallels: Since 11.2
> +#
>  # Since: 1.7
>  ##
>  { 'enum': 'ImageInfoSpecificKind',
> -  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file' ] }
> +  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file', 'parallels' ] }
>  
>  ##
>  # @ImageInfoSpecificQCow2Wrapper:
> @@ -255,6 +286,16 @@
>  { 'struct': 'ImageInfoSpecificFileWrapper',
>    'data': { 'data': 'ImageInfoSpecificFile' } }
>  
> +##
> +# @ImageInfoSpecificParallelsWrapper:
> +#
> +# @data: image information specific to Parallels
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'ImageInfoSpecificParallelsWrapper',
> +  'data': { 'data': 'ImageInfoSpecificParallels' } }
> +
>  ##
>  # @ImageInfoSpecific:
>  #
> @@ -273,7 +314,8 @@
>        'vmdk': 'ImageInfoSpecificVmdkWrapper',
>        'luks': 'ImageInfoSpecificLUKSWrapper',
>        'rbd': 'ImageInfoSpecificRbdWrapper',
> -      'file': 'ImageInfoSpecificFileWrapper'
> +      'file': 'ImageInfoSpecificFileWrapper',
> +      'parallels': 'ImageInfoSpecificParallelsWrapper'
>    } }
>  
>  ##

[...]


