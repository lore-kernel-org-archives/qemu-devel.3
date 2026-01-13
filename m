Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86B6D30CC2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 21:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfmKY-0004Xu-Fl; Tue, 13 Jan 2026 16:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vfmKV-0004Vj-FL
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 16:53:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vfmKT-0001sn-Qe
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 16:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768341213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0dcZXhBjmLLQUTeeJFsKlsh82Kr8vxODUFR62980Qk=;
 b=e3RKdVoKPxa2oKX5rK7KqQmkNmYe4gNj1pZrn8J4DsLa7UWYXYb4vdBCNeDmESx54k2K2N
 7s9bSIG+7CWTXR0v7SqlntOn6vgtNLKsQBOnEQynWLOXRK5ZBZjLEeZdJTKJbiF10k5r13
 d7EmeK4ClZIJo5YW43UZbmvmYpmmhu8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-qj4vBpk9OB-YaSQLzt3gnQ-1; Tue,
 13 Jan 2026 16:53:29 -0500
X-MC-Unique: qj4vBpk9OB-YaSQLzt3gnQ-1
X-Mimecast-MFC-AGG-ID: qj4vBpk9OB-YaSQLzt3gnQ_1768341208
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F1B31956050; Tue, 13 Jan 2026 21:53:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.89])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DFCD1800285; Tue, 13 Jan 2026 21:53:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pkrempa@redhat.com, Hannes Reinecke <hare@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alberto Faria <afaria@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 2/4] scsi: generalize scsi_SG_IO_FROM_DEV() to scsi_SG_IO()
Date: Tue, 13 Jan 2026 16:53:17 -0500
Message-ID: <20260113215320.566595-3-stefanha@redhat.com>
In-Reply-To: <20260113215320.566595-1-stefanha@redhat.com>
References: <20260113215320.566595-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a direction argument so that scsi_SG_IO() can be used for
SG_DXFER_FROM_DEV and SG_DXFER_TO_DEV transfers.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/scsi/scsi.h |  4 ++--
 hw/scsi/scsi-disk.c    |  4 ++--
 hw/scsi/scsi-generic.c | 18 ++++++++++--------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 23bd5b4b5e..1a01842c28 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -246,8 +246,8 @@ void scsi_device_report_change(SCSIDevice *dev, SCSISense sense);
 void scsi_device_unit_attention_reported(SCSIDevice *dev);
 void scsi_generic_read_device_inquiry(SCSIDevice *dev);
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
-int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
-                        uint8_t *buf, uint8_t buf_size, uint32_t timeout);
+int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd, uint8_t cmd_size,
+               uint8_t *buf, uint8_t buf_size, uint32_t timeout);
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
 SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0f896c27f4..97ae535a27 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2748,8 +2748,8 @@ static int get_device_type(SCSIDiskState *s)
     cmd[0] = INQUIRY;
     cmd[4] = sizeof(buf);
 
-    ret = scsi_SG_IO_FROM_DEV(s->qdev.conf.blk, cmd, sizeof(cmd),
-                              buf, sizeof(buf), s->qdev.io_timeout);
+    ret = scsi_SG_IO(s->qdev.conf.blk, SG_DXFER_FROM_DEV, cmd, sizeof(cmd),
+                     buf, sizeof(buf), s->qdev.io_timeout);
     if (ret < 0) {
         return -1;
     }
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 2ddd435856..6ef673aa4b 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -684,8 +684,9 @@ static int read_naa_id(const uint8_t *p, uint64_t *p_wwn)
     return -EINVAL;
 }
 
-int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
-                        uint8_t *buf, uint8_t buf_size, uint32_t timeout)
+int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd,
+               uint8_t cmd_size, uint8_t *buf, uint8_t buf_size,
+               uint32_t timeout)
 {
     sg_io_hdr_t io_header;
     uint8_t sensebuf[8];
@@ -693,7 +694,7 @@ int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
 
     memset(&io_header, 0, sizeof(io_header));
     io_header.interface_id = 'S';
-    io_header.dxfer_direction = SG_DXFER_FROM_DEV;
+    io_header.dxfer_direction = direction;
     io_header.dxfer_len = buf_size;
     io_header.dxferp = buf;
     io_header.cmdp = cmd;
@@ -733,8 +734,8 @@ static void scsi_generic_set_vpd_bl_emulation(SCSIDevice *s)
     cmd[2] = 0x00;
     cmd[4] = sizeof(buf);
 
-    ret = scsi_SG_IO_FROM_DEV(s->conf.blk, cmd, sizeof(cmd),
-                              buf, sizeof(buf), s->io_timeout);
+    ret = scsi_SG_IO(s->conf.blk, SG_DXFER_FROM_DEV, cmd, sizeof(cmd),
+                     buf, sizeof(buf), s->io_timeout);
     if (ret < 0) {
         /*
          * Do not assume anything if we can't retrieve the
@@ -769,8 +770,8 @@ static void scsi_generic_read_device_identification(SCSIDevice *s)
     cmd[2] = 0x83;
     cmd[4] = sizeof(buf);
 
-    ret = scsi_SG_IO_FROM_DEV(s->conf.blk, cmd, sizeof(cmd),
-                              buf, sizeof(buf), s->io_timeout);
+    ret = scsi_SG_IO(s->conf.blk, SG_DXFER_FROM_DEV, cmd, sizeof(cmd),
+                     buf, sizeof(buf), s->io_timeout);
     if (ret < 0) {
         return;
     }
@@ -821,7 +822,8 @@ static int get_stream_blocksize(BlockBackend *blk)
     cmd[0] = MODE_SENSE;
     cmd[4] = sizeof(buf);
 
-    ret = scsi_SG_IO_FROM_DEV(blk, cmd, sizeof(cmd), buf, sizeof(buf), 6);
+    ret = scsi_SG_IO(blk, SG_DXFER_FROM_DEV, cmd, sizeof(cmd),
+                     buf, sizeof(buf), 6);
     if (ret < 0) {
         return -1;
     }
-- 
2.52.0


