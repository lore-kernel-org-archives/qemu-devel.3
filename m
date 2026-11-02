Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A14606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PltGh0Xf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNrB5-0004Tk-E8; Mon, 02 Nov 2026 07:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNrB4-0004TR-6a
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNrB2-0002A6-GE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793622615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pw7FS9gvgScidl6XlFfudjD1WNKjwd9MvFV5H/eHNzw=;
 b=PltGh0XfuY91nbS4FSNWMU6WkyRWzB8iWkVGOjoxjDDuqe9VwvtScFuT59Y8DmEKkt/wd3
 u6gvm/AEH0sTZK4syneOKDYDGAEW7ubKJCBynWLMBw5hSZHFsdtmcu6YissotDH1nCEtjj
 tIHnhmTSqMEfrH4fKH2FiFVGhL4mzIM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-QKNX_xg4MxiphNTFno3PSg-1; Mon,
 02 Nov 2026 07:30:12 -0500
X-MC-Unique: QKNX_xg4MxiphNTFno3PSg-1
X-Mimecast-MFC-AGG-ID: QKNX_xg4MxiphNTFno3PSg_1793622611
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DE7A180AC6A; Mon,  2 Nov 2026 12:30:11 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.164])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7F0C18005B0; Mon,  2 Nov 2026 12:30:07 +0000 (UTC)
Date: Mon, 2 Nov 2026 13:30:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] virtio-blk: Add support for FUA write requests
Message-ID: <auiCTQZ669umVQgk@redhat.com>
References: <20261021062257.735757-1-afaria@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021062257.735757-1-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 21.10.2026 um 08:22 hat Alberto Faria geschrieben:
> virtio-blk FUA write support has been introduced to the virtio spec [1], and a
> kernel patch is under review [2]. This patch enables FUA on the virtio-blk
> device, so guests can submit FUA writes instead of the slower alternative of a
> regular write followed by a flush.
> 
> A simple randwrite fio workload on a RAM disk (bs=4k, iodepth=1, direct=1,
> sync=1) shows a throughput improvement of 17.1k IOPS to 27.7k IOPS (+62%).
> 
> [1] https://lore.kernel.org/virtio-comment/20251112055113.62207-1-afaria@redhat.com/
> [2] https://lore.kernel.org/linux-block/20261021055235.648957-1-afaria@redhat.com/
> 
> Alberto Faria (2):
>   include: Add virtio-blk request flag FUA definitions
>   virtio-blk: Add support for FUA write requests

As patch 1 can't be applied, I squashed in the below temporary
workaround that should be reverted after the Linux headers provide the
necessary definitions.

Thanks, applied to the block branch.

Kevin

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 345c9e07567..9b7c84fda6c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -38,6 +38,16 @@
 #include "hw/virtio/virtio-blk-common.h"
 #include "qemu/coroutine.h"

+/* TODO Remove once the Linux headers have caught up */
+#ifndef VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA
+#define VIRTIO_BLK_F_REQ_FLAGS         18      /* Request flags supported */
+#define VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA 19      /* FUA flag supported */
+
+#define VIRTIO_BLK_REQ_FLAG_OUT_FUA    0
+
+#define VIRTIO_BLK_OUTDHR_FLAGS(out) out.ioprio
+#endif
+
 /* Internal buffer size limit for zone report */
 #define VIRTIO_BLK_MAX_ZONES_PER_BATCH 4096

@@ -936,7 +946,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
                               &req->inhdr_undo);

     type = virtio_ldl_p(vdev, &req->out.type);
-    flags = virtio_ldl_p(vdev, &req->out.flags);
+    flags = virtio_ldl_p(vdev, &VIRTIO_BLK_OUTDHR_FLAGS(req->out));

     /* VIRTIO_BLK_T_OUT defines the command direction. VIRTIO_BLK_T_BARRIER
      * is an optional flag. Although a guest should not send this flag if
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index a15ec3685a3..af2f4b73dce 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -33,6 +33,12 @@
 #include "standard-headers/linux/virtio_vsock.h"
 #include "standard-headers/linux/virtio_gpio.h"

+/* TODO Remove once the Linux headers have caught up */
+#ifndef VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA
+#define VIRTIO_BLK_F_REQ_FLAGS         18      /* Request flags supported */
+#define VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA 19      /* FUA flag supported */
+#endif
+
 #define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
     { .virtio_bit = name, .feature_desc = desc }


