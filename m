Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB75CC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 16:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD406-0006Fx-7Q; Thu, 08 May 2025 12:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uD404-00068h-9N
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uD402-0008GE-Oe
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746721290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1DYCnxI5zsuno/R8zHzLRAzIAnJoX4ey2f9yC3L6gY=;
 b=H2RZn2I1PRFFdGU94KvH64oT6Eo3G4CLHjolYlugVRGUA5fAbooFXGWLcTTSZBHQXBDrZ+
 07MKvrah10tFVGCFvbhkI8VcoTDNQcRtQ8j1JtrQGDx3pB8C4IaIXITCHxDVZaB+oQMpu0
 NRuNCOVY/JYJJqeNLuci6lPevqptV98=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-SMoDB420OUam3IJFXCwJZQ-1; Thu,
 08 May 2025 12:21:27 -0400
X-MC-Unique: SMoDB420OUam3IJFXCwJZQ-1
X-Mimecast-MFC-AGG-ID: SMoDB420OUam3IJFXCwJZQ_1746721285
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1273D1954B1D; Thu,  8 May 2025 16:21:25 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.225.1])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12EA118004A7; Thu,  8 May 2025 16:21:17 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael@enfabrica.net>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>, Alberto Faria <afaria@redhat.com>
Subject: [RFC v2 4/4] vduse-blk: Add VIRTIO_BLK_T_OUT_FUA command support
Date: Thu,  8 May 2025 17:20:44 +0100
Message-ID: <20250508162044.857655-5-afaria@redhat.com>
In-Reply-To: <20250508162044.857655-1-afaria@redhat.com>
References: <20250508162044.857655-1-afaria@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 block/export/vduse-blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
index bd852e538dc..36c3c0a56e6 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -329,7 +329,8 @@ static int vduse_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
                (1ULL << VIRTIO_BLK_F_BLK_SIZE) |
                (1ULL << VIRTIO_BLK_F_FLUSH) |
                (1ULL << VIRTIO_BLK_F_DISCARD) |
-               (1ULL << VIRTIO_BLK_F_WRITE_ZEROES);
+               (1ULL << VIRTIO_BLK_F_WRITE_ZEROES) |
+               (1ULL << VIRTIO_BLK_F_OUT_FUA);
 
     if (num_queues > 1) {
         features |= 1ULL << VIRTIO_BLK_F_MQ;
-- 
2.49.0


