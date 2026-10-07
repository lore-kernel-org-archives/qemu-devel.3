Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D7ECA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xETQg-0004qi-5j; Wed, 07 Oct 2026 11:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xETQe-0004qZ-EU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 11:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xETQc-000762-AL
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 11:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791386373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=seVxlGkttiaK8uCT+wl1Qxj5maRR6ZZs6gB425/uzmQ=;
 b=B1lB+FQd+9wekG2Q0Td0CRl/DJgSCc53oW2hE1+UYNFeBn9HBXdjXV2JitDOTsR8Hbkeue
 FZPnTwqCQpUSnzE4mxW5Ie5DnmA2SgIkoulZAqEEl+vQqtMyPIopvUuHZqKtvZ6aIO/d9K
 d5v+aueKby3pt0gGi6xjKhaZ537pPNs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-RUcOCQUJP6iOwqPO9E_-Gg-1; Wed,
 7 Oct 2026 15:19:30 +0000
X-MC-Unique: RUcOCQUJP6iOwqPO9E_-Gg-1
X-Mimecast-MFC-AGG-ID: RUcOCQUJP6iOwqPO9E_-Gg_1791386369
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7F4A1955F25; Wed,  7 Oct 2026 15:19:29 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.219])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E5035BC; Wed,  7 Oct 2026 15:19:27 +0000 (UTC)
Date: Wed, 7 Oct 2026 17:19:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sanne Raymaekers <sraymaek@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, fam@euphon.net
Subject: Re: [PATCH 3/3] block/vmdk: add eos marker for stream optimized disks
Message-ID: <asZi_VPPDsq9Jx_q@redhat.com>
References: <20261005133316.198087-1-sraymaek@redhat.com>
 <20261005133316.198087-3-sraymaek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005133316.198087-3-sraymaek@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Am 05.10.2026 um 15:33 hat Sanne Raymaekers geschrieben:
> The end of stream marker should be at the very end of a stream optimized
> disk. It consists of a regular marker struct with `val`, `size` and
> `type` set to 0. It is then padded with more 0s to fill out a
> sector. This effectively results in 512 zero bytes.[^1]
> 
> [^1] Virtual Disk Format 5.0 Technical Note.
> 
> Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
> ---
>  block/vmdk.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 040f38cd1d..c10321146e 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -195,6 +195,13 @@ typedef struct VmdkGrainMarker {
>      uint8_t  data[];
>  } QEMU_PACKED VmdkGrainMarker;
>  
> +typedef struct EosMarker {
> +   uint64_t val;
> +   uint32_t size;
> +   uint32_t type;
> +   uint8_t pad[512 - 16];
> +} QEMU_PACKED EosMarker;
> +
>  enum {
>      MARKER_END_OF_STREAM    = 0,
>      MARKER_GRAIN_TABLE      = 1,
> @@ -987,12 +994,7 @@ vmdk_open_vmdk4(BlockDriverState *bs, BdrvChild *file, int flags,
>              VMDK4Header header;
>              uint8_t pad[512 - 4 - sizeof(VMDK4Header)];
>  
> -            struct {
> -                uint64_t val;
> -                uint32_t size;
> -                uint32_t type;
> -                uint8_t pad[512 - 16];
> -            } QEMU_PACKED eos_marker;
> +            EosMarker eos_marker;
>          } QEMU_PACKED footer;
>  
>          ret = bdrv_pread(file, bs->file->bs->total_sectors * 512 - 1536,
> @@ -2180,6 +2182,7 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
>          BDRVVmdkState *s = bs->opaque;
>          int i, ret;
>          int64_t length;
> +        EosMarker *eos_marker = NULL;
>  
>          for (i = 0; i < s->num_extents; i++) {
>              length = bdrv_co_getlength(s->extents[i].file->bs);
> @@ -2193,6 +2196,20 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
>                  return ret;
>              }
>          }

Is there any way s->num_extents could not be 1 for streamOptimized
images?

If not, I think you can delete the whole existing for loop (which will
execute only once). bdrv_co_truncate() extends the file size, but then
you write at a higher offset below, which will extend it a second time,
so the bdrv_co_truncate() call didn't do anything useful.

> +        /* Stream optimized disks end with an EOS marker, consisting of 512 null bytes. */
> +        if (strcmp(s->create_type, "streamOptimized") == 0) {

This is vmdk_co_pwritev_compressed(). If we're here, we already know
that this is a streamOptimized image.

> +            eos_marker = g_malloc(sizeof(EosMarker));
> +            memset(eos_marker, 0, sizeof(EosMarker));

This can be combined into g_malloc0().

In fact, using qemu_blockalign0() and declaring eos_marker as
QEMU_AUTO_VFREE would be even better because it makes sure that the
buffer has the required memory alignment; otherwise, a lower layer may
have to copy the data into a bounce buffer.

> +            length = bdrv_co_getlength(s->extents[s->num_extents - 1].file->bs);

Unless I'm mistaken above, this is always s->extents[0].

bdrv_co_getlength() errors must be handled, like in the for loop above.

> +            ret = bdrv_co_pwrite(s->extents[s->num_extents - 1].file, length,
> +                                 sizeof(EosMarker), eos_marker, 0);

When removing the truncate, length would become QEMU_ALIGN_UP(length,
512) here instead.

> +            g_free(eos_marker);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
> +
>          return 0;
>      }
>      return vmdk_co_pwritev(bs, offset, bytes, qiov, 0);

Kevin


