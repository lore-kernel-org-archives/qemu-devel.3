Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C053DCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxnD-0004lP-6a; Fri, 29 May 2026 10:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSxnA-0004eL-I9
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSxn8-0007PJ-OM
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780063346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ekz0twJaJm7BEwRS/guT4u7IP0hcVDfUtKPhe48WhIk=;
 b=b8sk43ErcO5MtTByo7uLMVJNOh78KlFI9jOJAIVz4RLC6gQtFiHuZpFE9MVJbf0qd9brdR
 jrAEHYF6ok+ByWoo8JuEBVkJlx5+alROwikZcft0j7EKJIYhihvY7gGnlPK9wYgarLpM2X
 hT0nXlv/VZPtMFCO21iKKrNtcsUrGv8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-RfAXXKMbPM6le8r0Gkicfg-1; Fri,
 29 May 2026 10:02:22 -0400
X-MC-Unique: RfAXXKMbPM6le8r0Gkicfg-1
X-Mimecast-MFC-AGG-ID: RfAXXKMbPM6le8r0Gkicfg_1780063341
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 883901956067; Fri, 29 May 2026 14:02:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22091176F; Fri, 29 May 2026 14:02:18 +0000 (UTC)
Date: Fri, 29 May 2026 16:02:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH] virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check
 (CVE-2026-48914)
Message-ID: <ahmcaMGgT0HfpK1Y@redhat.com>
References: <20260526154957.1741622-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526154957.1741622-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Am 26.05.2026 um 17:49 hat Stefan Hajnoczi geschrieben:
> Check that the iovec containing struct virtio_scsi_inhdr is large enough
> before storing an error value there.
> 
> Feifan Qian <bea1e@proton.me> pointed out that this can be used to
> corrupt heap memory when the descriptor uses an MMIO address and a
> length of 1, forcing QEMU to allocate a 1-byte heap bounce buffer.
> virtio_stl_p() stores 4 bytes and therefore corrupts whatever is beyond
> the bounce buffer.
> 
> Fixes: CVE-2026-48914
> Fixes: f34e73cd69bd ("virtio-blk: report non-zero status when failing SG_IO requests")
> Reported-by: Feifan Qian <bea1e@proton.me>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 9cb9f1fb2b..6b92066aff 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -199,10 +199,16 @@ static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
>  
>      /*
>       * The scsi inhdr is placed in the second-to-last input segment, just
> -     * before the regular inhdr.
> +     * before the regular inhdr. VIRTIO implementations normally do not rely on
> +     * the precise message framing, but legacy implementations did and so we do
> +     * too for the legacy virtio-blk SCSI request type.
>       *
>       * Just put anything nonzero so that the ioctl fails in the guest.
>       */
> +    if (elem->in_sg[elem->in_num - 2].iov_len != sizeof(*scsi)) {
> +        status = VIRTIO_BLK_S_IOERR;
> +        goto fail;
> +    }
>      scsi = (void *)elem->in_sg[elem->in_num - 2].iov_base;
>      virtio_stl_p(vdev, &scsi->errors, 255);
>      status = VIRTIO_BLK_S_UNSUPP;

What would the guest do if we didn't update scsi->errors, but just
return VIRTIO_BLK_S_UNSUPP (i.e. remove this whole function)? Shouldn't
that result in an error, too?

Kevin


