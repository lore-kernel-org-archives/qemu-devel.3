Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16394C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PSM-00016B-82; Mon, 13 May 2024 02:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6PSK-00014N-SK
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6PSH-0006Qt-Mu
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715582796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pxScFYb3oXIhvjEh8s6hm0zLJA/zdXbZdHZoeTVr18=;
 b=fkZE2yyVADcLx+NHkMi2qHP2vWMajfNd0zEcFQlm4l5+LoCcTiTb7Wquh+OswcP0pWfrZT
 vW6UEg/gkNhTNbLLcKhKjCUsBjo90LxqqUSFV2VXjqC1I28FhC1oktPVbpCT9w8QS74NxT
 hTTPnWWuITsO+ZIJ2OLz1uJJL0zM8EQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-c_UhaXzMOE-pbUYbU9uL7A-1; Mon,
 13 May 2024 02:46:32 -0400
X-MC-Unique: c_UhaXzMOE-pbUYbU9uL7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0400D29AA2C4;
 Mon, 13 May 2024 06:46:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C96BC41D;
 Mon, 13 May 2024 06:46:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A46EA21E66E5; Mon, 13 May 2024 08:46:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com,  f.gruenbichler@proxmox.com,  t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com,  xiechanglong.d@gmail.com,
 wencongyang2@huawei.com
Subject: Re: [PATCH v3 3/5] mirror: allow specifying working bitmap
In-Reply-To: <20240510131647.1256467-4-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Fri, 10 May 2024 15:16:45 +0200")
References: <20240510131647.1256467-1-f.ebner@proxmox.com>
 <20240510131647.1256467-4-f.ebner@proxmox.com>
Date: Mon, 13 May 2024 08:46:29 +0200
Message-ID: <87h6f2cipm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> From: John Snow <jsnow@redhat.com>
>
> for the mirror job. The bitmap's granularity is used as the job's
> granularity.
>
> The new @bitmap parameter is marked unstable in the QAPI and can
> currently only be used for @sync=3Dfull mode.
>
> Clusters initially dirty in the bitmap as well as new writes are
> copied to the target.
>
> Using block-dirty-bitmap-clear and block-dirty-bitmap-merge API,
> callers can simulate the three kinds of @BitmapSyncMode (which is used
> by backup):
> 1. always: default, just pass bitmap as working bitmap.
> 2. never: copy bitmap and pass copy to the mirror job.
> 3. on-success: copy bitmap and pass copy to the mirror job and if
>    successful, merge bitmap into original afterwards.
>
> When the target image is a non-COW "diff image", i.e. one that was not
> used as the target of a previous mirror and the target image's cluster
> size is larger than the bitmap's granularity, or when
> @copy-mode=3Dwrite-blocking is used, there is a pitfall, because the
> cluster in the target image will be allocated, but not contain all the
> data corresponding to the same region in the source image.
>
> An idea to avoid the limitation would be to mark clusters which are
> affected by unaligned writes and are not allocated in the target image
> dirty, so they would be copied fully later. However, for migration,
> the invariant that an actively synced mirror stays actively synced
> (unless an error happens) is useful, because without that invariant,
> migration might inactivate block devices when mirror still got work
> to do and run into an assertion failure [0].
>
> Another approach would be to read the missing data from the source
> upon unaligned writes to be able to write the full target cluster
> instead.
>
> But certain targets like NBD do not allow querying the cluster size.
> To avoid limiting/breaking the use case of syncing to an existing
> target, which is arguably more common than the diff image use case,
> document the limitation in QAPI.
>
> This patch was originally based on one by Ma Haocong, but it has since
> been modified pretty heavily, first by John and then again by Fiona.
>
> [0]: https://lore.kernel.org/qemu-devel/1db7f571-cb7f-c293-04cc-cd856e060=
c3f@proxmox.com/
>
> Suggested-by: Ma Haocong <mahaocong@didichuxing.com>
> Signed-off-by: Ma Haocong <mahaocong@didichuxing.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> [FG: switch to bdrv_dirty_bitmap_merge_internal]
> Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> [FE: rebase for 9.1
>      get rid of bitmap mode parameter
>      use caller-provided bitmap as working bitmap
>      turn bitmap parameter experimental]
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

[...]

> diff --git a/include/block/block_int-global-state.h b/include/block/block=
_int-global-state.h
> index 54f8c8cbcb..8b93db017e 100644
> --- a/include/block/block_int-global-state.h
> +++ b/include/block/block_int-global-state.h
> @@ -138,6 +138,8 @@ BlockJob *commit_active_start(const char *job_id, Blo=
ckDriverState *bs,
>   * @granularity: The chosen granularity for the dirty bitmap.
>   * @buf_size: The amount of data that can be in flight at one time.
>   * @mode: Whether to collapse all images in the chain to the target.
> + * @bitmap: Use this bitmap as a working bitmap, i.e. non-dirty clusters=
 are
> +            only mirrored if written to later.
>   * @backing_mode: How to establish the target's backing chain after comp=
letion.
>   * @zero_target: Whether the target should be explicitly zero-initialized
>   * @on_source_error: The action to take upon error reading from the sour=
ce.
> @@ -158,7 +160,8 @@ void mirror_start(const char *job_id, BlockDriverStat=
e *bs,
>                    BlockDriverState *target, const char *replaces,
>                    int creation_flags, int64_t speed,
>                    uint32_t granularity, int64_t buf_size,
> -                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mo=
de,
> +                  MirrorSyncMode mode, BdrvDirtyBitmap *bitmap,
> +                  BlockMirrorBackingMode backing_mode,
>                    bool zero_target,
>                    BlockdevOnError on_source_error,
>                    BlockdevOnError on_target_error,
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 9d94129ea2..5ddebe71ee 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2191,6 +2191,18 @@
>  #     destination (all the disk, only the sectors allocated in the
>  #     topmost image, or only new I/O).
>  #
> +# @bitmap: The name of a bitmap to use as a working bitmap for
> +#     sync=3Dfull mode.  This argument must be not be present for other
> +#     sync modes and not at the same time as @granularity.  The
> +#     bitmap's granularity is used as the job's granularity.  When
> +#     the target does not support COW and is a diff image, i.e. one
> +#     that should only contain the delta and was not synced to
> +#     previously, the target's cluster size must not be larger than
> +#     the bitmap's granularity and copy-mode=3Dwrite-blocking should not

Comma before "and", please.

> +#     be used. That is, because unaligned writes will lead to

Two spaces between sentences for consistency, please.

Suggest "Otherwise, unaligned writes ..."

> +#     allocated clusters with partial data in the target image!
> +#     (Since 9.1)
> +#
>  # @granularity: granularity of the dirty bitmap, default is 64K if the
>  #     image format doesn't have clusters, 4K if the clusters are
>  #     smaller than that, else the cluster size.  Must be a power of 2
> @@ -2228,12 +2240,18 @@
>  #     disappear from the query list without user intervention.
>  #     Defaults to true.  (Since 3.1)
>  #
> +# Features:
> +#
> +# @unstable: Member @bitmap is experimental.
> +#
>  # Since: 1.3
>  ##
>  { 'struct': 'DriveMirror',
>    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>              '*format': 'str', '*node-name': 'str', '*replaces': 'str',
> -            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
> +            'sync': 'MirrorSyncMode',
> +            '*bitmap': { 'type': 'str', 'features': [ 'unstable' ] },
> +            '*mode': 'NewImageMode',
>              '*speed': 'int', '*granularity': 'uint32',
>              '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
>              '*on-target-error': 'BlockdevOnError',
> @@ -2513,6 +2531,18 @@
>  #     destination (all the disk, only the sectors allocated in the
>  #     topmost image, or only new I/O).
>  #
> +# @bitmap: The name of a bitmap to use as a working bitmap for
> +#     sync=3Dfull mode.  This argument must be not be present for other
> +#     sync modes and not at the same time as @granularity.  The
> +#     bitmap's granularity is used as the job's granularity.  When
> +#     the target does not support COW and is a diff image, i.e. one
> +#     that should only contain the delta and was not synced to
> +#     previously, the target's cluster size must not be larger than
> +#     the bitmap's granularity and copy-mode=3Dwrite-blocking should not
> +#     be used. That is, because unaligned writes will lead to
> +#     allocated clusters with partial data in the target image!
> +#     (Since 9.1)

Comments above apply.

> +#
>  # @granularity: granularity of the dirty bitmap, default is 64K if the
>  #     image format doesn't have clusters, 4K if the clusters are
>  #     smaller than that, else the cluster size.  Must be a power of 2
> @@ -2548,6 +2578,10 @@
>  #     disappear from the query list without user intervention.
>  #     Defaults to true.  (Since 3.1)
>  #
> +# Features:
> +#
> +# @unstable: Member @bitmap is experimental.
> +#
>  # Since: 2.6
>  #
>  # Example:
> @@ -2562,6 +2596,7 @@
>    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>              '*replaces': 'str',
>              'sync': 'MirrorSyncMode',
> +            '*bitmap': { 'type': 'str', 'features': [ 'unstable' ] },
>              '*speed': 'int', '*granularity': 'uint32',
>              '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
>              '*on-target-error': 'BlockdevOnError',

[...]

With my comments addressed,
Acked-by: Markus Armbruster <armbru@redhat.com>


