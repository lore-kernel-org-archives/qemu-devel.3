Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4164109B485
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7adZ-0003Iv-7p; Tue, 31 Mar 2026 11:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7adX-0003Fe-Cf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7adW-0002Z9-2T
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774969449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7l7nol1SzwFYWkkAmybwaQvn6WrYq0DfYyxo8Bu/rc=;
 b=dEDlsmUo35G3VkdAmbUlHit+B4qFc73i4kl0COgIssRZ1VSDTmB7u9KujxciW8emNhL3UC
 KOkbxSvM/AMaQ9igfijRFzlaWdK7R1zBHa0KlhlDTWW1aaqCYceXCmlxwmoFysX2Zdp89X
 mu+Xit253CoJc8t0IizakX/MWFVH0Qo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-rmiI-oJDNdKshv0HcyWhTA-1; Tue,
 31 Mar 2026 11:04:08 -0400
X-MC-Unique: rmiI-oJDNdKshv0HcyWhTA-1
X-Mimecast-MFC-AGG-ID: rmiI-oJDNdKshv0HcyWhTA_1774969447
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 102B61800624; Tue, 31 Mar 2026 15:04:07 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.50.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA86919540C4; Tue, 31 Mar 2026 15:04:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 5/6] vhost-user-blk-server: fix opt_io_size=1 causing severe
 Windows I/O degradation
Date: Tue, 31 Mar 2026 17:03:51 +0200
Message-ID: <20260331150352.256332-6-kwolf@redhat.com>
In-Reply-To: <20260331150352.256332-1-kwolf@redhat.com>
References: <20260331150352.256332-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Max Makarov <maxpain177@gmail.com>

The QSD vhost-user-blk export sets opt_io_size=1 and min_io_size=1 in
the virtio config. These values are reported to the guest through the
VPD Block Limits page as OptimalTransferLength=1 block (512 bytes)
and OptimalTransferLengthGranularity=1 block.

Windows respects these hints and splits all I/O into ~512-byte
requests, causing ~100x sequential throughput degradation (150 MB/s
instead of 15+ GB/s). Linux is unaffected as its block layer ignores
these values.

Set both to 0 which means "not reported" per the SCSI Block Limits
VPD spec, allowing Windows to use its own optimal I/O size defaults.

Signed-off-by: Max Makarov <maxpain@linux.com>
Message-ID: <20260330193451.76037-1-maxpain@linux.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/vhost-user-blk-server.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index e89422bb85a..67912a3e170 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -242,8 +242,8 @@ vu_blk_initialize_config(BlockDriverState *bs,
     config->blk_size = cpu_to_le32(blk_size);
     config->size_max = cpu_to_le32(0);
     config->seg_max = cpu_to_le32(128 - 2);
-    config->min_io_size = cpu_to_le16(1);
-    config->opt_io_size = cpu_to_le32(1);
+    config->min_io_size = cpu_to_le16(0);
+    config->opt_io_size = cpu_to_le32(0);
     config->num_queues = cpu_to_le16(num_queues);
     config->max_discard_sectors =
         cpu_to_le32(VIRTIO_BLK_MAX_DISCARD_SECTORS);
-- 
2.53.0


