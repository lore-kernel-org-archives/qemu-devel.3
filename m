Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D202AD30CDB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 21:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfmKX-0004XE-MG; Tue, 13 Jan 2026 16:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vfmKX-0004Wu-2a
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 16:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vfmKV-0001vG-GC
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 16:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768341214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NqomSuT6/W740TEO6RcpdcYiO7U/ORLpsRNggJkj7E=;
 b=C2axVctbS1tSGxoCyPoDksJzt4DPsnP+p6kJH5qkTncfuPSHaEt2eqr/rf0bR50rU5L0er
 1fX6XcmpGYJmP0+ISMcROcGFpVYHE5ZBC6P8FLXC5zo9OC6VOHP3Vz8rEFqfYfrLT08gpT
 d7lE6z/n/J448bpmVMjnrnWjR1h6mK4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-Ss9Ulg9iMjaEEKQWhZFCTw-1; Tue,
 13 Jan 2026 16:53:31 -0500
X-MC-Unique: Ss9Ulg9iMjaEEKQWhZFCTw-1
X-Mimecast-MFC-AGG-ID: Ss9Ulg9iMjaEEKQWhZFCTw_1768341209
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78E331956080; Tue, 13 Jan 2026 21:53:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA85B30001A2; Tue, 13 Jan 2026 21:53:28 +0000 (UTC)
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
Subject: [RFC 3/4] scsi: add error reporting to scsi_SG_IO()
Date: Tue, 13 Jan 2026 16:53:18 -0500
Message-ID: <20260113215320.566595-4-stefanha@redhat.com>
In-Reply-To: <20260113215320.566595-1-stefanha@redhat.com>
References: <20260113215320.566595-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Report the details of the SG_IO ioctl failure if an Error pointer is
provided. This information aids troubleshooting and will be used by the
SCSI Persistent Reservations migration code.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/scsi/scsi.h |  2 +-
 hw/scsi/scsi-disk.c    |  2 +-
 hw/scsi/scsi-generic.c | 33 ++++++++++++++++++++++++++++-----
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 1a01842c28..c5ec58089b 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -247,7 +247,7 @@ void scsi_device_unit_attention_reported(SCSIDevice *dev);
 void scsi_generic_read_device_inquiry(SCSIDevice *dev);
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
 int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd, uint8_t cmd_size,
-               uint8_t *buf, uint8_t buf_size, uint32_t timeout);
+               uint8_t *buf, uint8_t buf_size, uint32_t timeout, Error **errp);
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
 SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 97ae535a27..76fe5f085b 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2749,7 +2749,7 @@ static int get_device_type(SCSIDiskState *s)
     cmd[4] = sizeof(buf);
 
     ret = scsi_SG_IO(s->qdev.conf.blk, SG_DXFER_FROM_DEV, cmd, sizeof(cmd),
-                     buf, sizeof(buf), s->qdev.io_timeout);
+                     buf, sizeof(buf), s->qdev.io_timeout, NULL);
     if (ret < 0) {
         return -1;
     }
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 6ef673aa4b..f22a38f725 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -686,10 +686,10 @@ static int read_naa_id(const uint8_t *p, uint64_t *p_wwn)
 
 int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd,
                uint8_t cmd_size, uint8_t *buf, uint8_t buf_size,
-               uint32_t timeout)
+               uint32_t timeout, Error **errp)
 {
     sg_io_hdr_t io_header;
-    uint8_t sensebuf[8];
+    uint8_t sensebuf[8] = {};
     int ret;
 
     memset(&io_header, 0, sizeof(io_header));
@@ -709,6 +709,29 @@ int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd,
         io_header.driver_status || io_header.host_status) {
         trace_scsi_generic_ioctl_sgio_done(cmd[0], ret, io_header.status,
                                            io_header.host_status);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "SG_IO ioctl failed");
+        } else {
+            g_autofree char *sensebuf_hex =
+                g_strdup_printf("%02x%02x%02x%02x%02x%02x%02x%02x",
+                                sensebuf[0],
+                                sensebuf[1],
+                                sensebuf[2],
+                                sensebuf[3],
+                                sensebuf[4],
+                                sensebuf[5],
+                                sensebuf[6],
+                                sensebuf[7]);
+
+            error_setg(errp, "SG_IO SCSI command failed with status=0x%x "
+                    "driver_status=0x%x host_status=0x%x sensebuf=%s "
+                    "sb_len_wr=%u",
+                    io_header.status,
+                    io_header.driver_status,
+                    io_header.host_status,
+                    sensebuf_hex,
+                    io_header.sb_len_wr);
+        }
         return -1;
     }
     return 0;
@@ -735,7 +758,7 @@ static void scsi_generic_set_vpd_bl_emulation(SCSIDevice *s)
     cmd[4] = sizeof(buf);
 
     ret = scsi_SG_IO(s->conf.blk, SG_DXFER_FROM_DEV, cmd, sizeof(cmd),
-                     buf, sizeof(buf), s->io_timeout);
+                     buf, sizeof(buf), s->io_timeout, NULL);
     if (ret < 0) {
         /*
          * Do not assume anything if we can't retrieve the
@@ -771,7 +794,7 @@ static void scsi_generic_read_device_identification(SCSIDevice *s)
     cmd[4] = sizeof(buf);
 
     ret = scsi_SG_IO(s->conf.blk, SG_DXFER_FROM_DEV, cmd, sizeof(cmd),
-                     buf, sizeof(buf), s->io_timeout);
+                     buf, sizeof(buf), s->io_timeout, NULL);
     if (ret < 0) {
         return;
     }
@@ -823,7 +846,7 @@ static int get_stream_blocksize(BlockBackend *blk)
     cmd[4] = sizeof(buf);
 
     ret = scsi_SG_IO(blk, SG_DXFER_FROM_DEV, cmd, sizeof(cmd),
-                     buf, sizeof(buf), 6);
+                     buf, sizeof(buf), 6, NULL);
     if (ret < 0) {
         return -1;
     }
-- 
2.52.0


