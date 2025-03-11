Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B30C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 12:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tryO6-0002pz-0b; Tue, 11 Mar 2025 08:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tryNa-0002k9-1P
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 08:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tryNW-0005MC-V0
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 08:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741694785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/TvujmW+owmZUvJlLCw2BXUkVDIaCKPW+t9XyxZaZN8=;
 b=CrqcdZ9VL79wx95njk+V3pkw8mlrXT1sZL7N13Gyi8SX1jCzJp1n8Hgvl2h5NDGkAJSNdC
 B4lkEWYrNPuJVLQRJ8iBMfpqAIVjp/E75U8GzhR0w5eMMEiJDtCJKBYSaiQ7fyzwAbOs9b
 nz6FRlJiS6hanqrTrcxSNoNl6c0lXKM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-5QYdCxNLO4mmX_7CGkKKQQ-1; Tue,
 11 Mar 2025 08:06:20 -0400
X-MC-Unique: 5QYdCxNLO4mmX_7CGkKKQQ-1
X-Mimecast-MFC-AGG-ID: 5QYdCxNLO4mmX_7CGkKKQQ_1741694779
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9E35180AF52; Tue, 11 Mar 2025 12:06:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1580518001E9; Tue, 11 Mar 2025 12:06:13 +0000 (UTC)
Date: Tue, 11 Mar 2025 13:06:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, pkrempa@redhat.com,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 11/13] virtio-scsi: add iothread-vq-mapping parameter
Message-ID: <Z9AnM4D6KZqHTakM@redhat.com>
References: <20250311101145.1037388-1-stefanha@redhat.com>
 <20250311101145.1037388-12-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311101145.1037388-12-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 11.03.2025 um 11:11 hat Stefan Hajnoczi geschrieben:
> Allow virtio-scsi virtqueues to be assigned to different IOThreads. This
> makes it possible to take advantage of host multi-queue block layer
> scalability by assigning virtqueues that have affinity with vCPUs to
> different IOThreads that have affinity with host CPUs. The same feature
> was introduced for virtio-blk in the past:
> https://developers.redhat.com/articles/2024/09/05/scaling-virtio-blk-disk-io-iothread-virtqueue-mapping
> 
> Here are fio randread 4k iodepth=64 results from a 4 vCPU guest with an
> Intel P4800X SSD:
> iothreads IOPS
> ------------------------------
> 1         189576
> 2         312698
> 4         346744
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> @@ -1218,14 +1224,16 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(hotplug_dev);
>      VirtIOSCSI *s = VIRTIO_SCSI(vdev);
> +    AioContext *ctx = s->vq_aio_context[0];

At the end of the series, this is always qemu_aio_context...

>      SCSIDevice *sd = SCSI_DEVICE(dev);
> -    int ret;
>  
> -    if (s->ctx && !s->dataplane_fenced) {
> -        ret = blk_set_aio_context(sd->conf.blk, s->ctx, errp);
> -        if (ret < 0) {
> -            return;
> -        }
> +    if (ctx != qemu_get_aio_context() && !s->dataplane_fenced) {
> +        /*
> +         * Try to make the BlockBackend's AioContext match ours. Ignore failure
> +         * because I/O will still work although block jobs and other users
> +         * might be slower when multiple AioContexts use a BlockBackend.
> +         */
> +        blk_set_aio_context(sd->conf.blk, ctx, errp);
>      }

...so this becomes dead code. With multiple AioContexts, it's not clear
which one should be used. virtio-blk just takes the first one. The
equivalent thing here would be to use the one of the first command
queue.

>      if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
> @@ -1260,7 +1268,7 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  
>      qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
>  
> -    if (s->ctx) {
> +    if (s->vq_aio_context[0] != qemu_get_aio_context()) {

Same problem here.

>          /* If other users keep the BlockBackend in the iothread, that's ok */
>          blk_set_aio_context(sd->conf.blk, qemu_get_aio_context(), NULL);
>      }

As you wanted to avoid squashing patches anyway, I think this can be
fixed on top of this series.

Kevin


