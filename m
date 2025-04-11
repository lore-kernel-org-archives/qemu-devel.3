Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC255C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39OL-0002Sv-KY; Fri, 11 Apr 2025 04:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Nu-0001xp-7V
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:05:11 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Nr-0004uY-7b
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:05:09 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso1763321a91.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358705; x=1744963505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bakV1Nw41aQ2qXglXOF8Xs81TCloe9+HZ+gP072wOBQ=;
 b=CmkzWPCQvoCVUGx/gldFqZnjcAWsjowYsM/LcL2g8ehaEtPHN50k707M5TEYoOaN/O
 BplnhNU8CLvYaJVl8XX9XG9D5ujiDRhiG/GoTGOaOthozdPNaQVgjdVRvUsBGCt+12YM
 FkCi6ylKUk8PlGHeOeX+9jIU4U0Rh5CX1HaVNGl+xAAni/JIRF3BrmP/DRKs/kTRu38y
 prNIzNIhAPgyu/F28342pnTgLUrueGv6l5xpQydtl53LIctWImTn0CFtOLQhpLCMw5Zs
 tOP2o9MwxPUrAemC5KlwDyGkzLd6ocqTDauoZR5Di+NeQy+gCNRTKc/U7JgvpLtJHhUJ
 d09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358705; x=1744963505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bakV1Nw41aQ2qXglXOF8Xs81TCloe9+HZ+gP072wOBQ=;
 b=edZ0K5RjHXkztKpbxaT2fk55VTesKH2OlxNTzOtCUJnEFaWgkQFxk1yTXp6yMnHyV8
 IWRAEiw6XunbYP06061dmTCp516c3+xGoRw2cG5xnqK8e91K1SM+i7XqqSSKfDWqWI7w
 /JW6luGczN2kiBzM3a3/yzp8WzDKgEmgT7BkCluz8RymNXoudR0VanLzbLqmD5EASvOC
 IsE6wuHJJpOR47y6c1OULZ5cmut3H0R0UPVLPODeyWwvBrx3rpWpMZqrzyqPHCIW5p7/
 obhSDh04LxlR21iargkx40ZmNT3f5PxKR2wljM7SVNrDcj3PXAkzTyXukNHXv+jRimlr
 oAdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVodIskQ2aF7wt9pR0ZjOK4QXL6V/ms5/7PcKm2lAsfXsDzEl0nA/4iL4zbWC8cPiuCF7ulO07bBN+u@nongnu.org
X-Gm-Message-State: AOJu0YygXRlCje27VmgiHV0b2UcLPTvvr4wnth3PTYmkDx3UeTtPM4h4
 NmQoFqp8Gdsur/dEGCllqpqCAH+Q/A/v7cvIfeHZX5LI8Mxqn/0hVspUpw==
X-Gm-Gg: ASbGnct83ePGNrQ7cYWmSi9+D5AkWu/Lq5Ae2/rCqehhkSnOcWw9WdvyQFE+z3+WGil
 g51oL3t5nwihFIIGiVFQT9F+7Go8rCZxqeymJ/Mgs3LzbQeriKH+xKaVTIZtsN1F3Y6nwevbOKS
 fnug5UuPRiGWrlqczmTlA6mndz4YISKQl69GGYL3kHWf6t60rAMAJPNbPHjrYNOHTCZVsU35TzV
 M+a2lVyROm9sQQiDiI3lX32+a3qxwNaBFlv8I5KUIulVUnyNA0O7AeBLNao+M5nSdN5Dyuc4Z3Y
 aFTpHOJUxc2CYdkvbsVKS+TnquybY01/h80EZG5FuqY6AdOgaSE7Oss=
X-Google-Smtp-Source: AGHT+IE3C+EWZzK3AtgZt3ePpWZLTKOy0D3uhMKDhaXC331q5agUzLd/9DQCSF1gEDSOIjZWr+Fyhw==
X-Received: by 2002:a17:90b:2f0b:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-30823639726mr3218534a91.11.1744358705563; 
 Fri, 11 Apr 2025 01:05:05 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:05:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 10/10] usb/msd: Add more tracing
Date: Fri, 11 Apr 2025 18:04:31 +1000
Message-ID: <20250411080431.207579-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411080431.207579-1-npiggin@gmail.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add tracing for more received packet types, cbw_state changes, and
some more SCSI callbacks. These were useful in debugging relaxed
packet ordering support.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 23 +++++++++++++++++++++--
 hw/usb/trace-events  |  9 ++++++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 654b9071d33..0ed39de189d 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -187,7 +187,7 @@ static void usb_msd_data_packet_complete(MSDState *s, int status)
      * because another request may be issued before usb_packet_complete
      * returns.
      */
-    trace_usb_msd_packet_complete();
+    trace_usb_msd_data_packet_complete();
     s->data_packet = NULL;
     p->status = status;
     usb_packet_complete(&s->dev, p);
@@ -202,7 +202,7 @@ static void usb_msd_csw_packet_complete(MSDState *s, int status)
      * because another request may be issued before usb_packet_complete
      * returns.
      */
-    trace_usb_msd_packet_complete();
+    trace_usb_msd_csw_packet_complete();
     s->csw_in_packet = NULL;
     p->status = status;
     usb_packet_complete(&s->dev, p);
@@ -231,7 +231,11 @@ static void usb_msd_fatal_error(MSDState *s)
 static void usb_msd_copy_data(MSDState *s, USBPacket *p)
 {
     uint32_t len;
+
     len = p->iov.size - p->actual_length;
+
+    trace_usb_msd_copy_data(s->req->tag, len);
+
     if (len > s->scsi_len)
         len = s->scsi_len;
     usb_packet_copy(p, scsi_req_get_buf(s->req) + s->scsi_off, len);
@@ -264,6 +268,8 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
     USBPacket *p = s->data_packet;
 
+    trace_usb_msd_transfer_data(req->tag, len);
+
     if (s->cbw_state == USB_MSD_CBW_DATAIN) {
         if (req->cmd.mode == SCSI_XFER_TO_DEV) {
             usb_msd_fatal_error(s);
@@ -324,11 +330,13 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
         }
         if (s->data_len == 0) {
             s->cbw_state = USB_MSD_CBW_CSW;
+            trace_usb_msd_cbw_state(s->cbw_state);
         }
         /* USB_RET_SUCCESS status clears previous ASYNC status */
         usb_msd_data_packet_complete(s, USB_RET_SUCCESS);
     } else if (s->data_len == 0) {
         s->cbw_state = USB_MSD_CBW_CSW;
+        trace_usb_msd_cbw_state(s->cbw_state);
     }
 
     if (s->cbw_state == USB_MSD_CBW_CSW) {
@@ -336,6 +344,7 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
         if (p) {
             usb_msd_send_status(s, p);
             s->cbw_state = USB_MSD_CBW_NONE;
+            trace_usb_msd_cbw_state(s->cbw_state);
             /* USB_RET_SUCCESS status clears previous ASYNC status */
             usb_msd_csw_packet_complete(s, USB_RET_SUCCESS);
         }
@@ -379,6 +388,7 @@ void usb_msd_handle_reset(USBDevice *dev)
 
     memset(&s->csw, 0, sizeof(s->csw));
     s->cbw_state = USB_MSD_CBW_NONE;
+    trace_usb_msd_cbw_state(s->cbw_state);
 
     s->needs_reset = false;
 }
@@ -429,6 +439,8 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
 {
     MSDState *s = USB_STORAGE_DEV(dev);
 
+    trace_usb_msd_cancel_io();
+
     if (p == s->data_packet) {
         s->data_packet = NULL;
         if (s->req) {
@@ -516,6 +528,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         }
         trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
                                  cbw.cmd_len, s->data_len);
+        trace_usb_msd_cbw_state(s->cbw_state);
         assert(le32_to_cpu(s->csw.residue) == 0);
         assert(s->scsi_len == 0);
         s->req = scsi_req_new(scsi_dev, tag, cbw.lun,
@@ -553,6 +566,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
                 s->data_len -= len;
                 if (s->data_len == 0) {
                     s->cbw_state = USB_MSD_CBW_CSW;
+                    trace_usb_msd_cbw_state(s->cbw_state);
                 }
             }
         }
@@ -579,6 +593,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
 
     switch (s->cbw_state) {
     case USB_MSD_CBW_NONE:
+        trace_usb_msd_unknown_in(p->iov.size);
         if (s->unknown_in_packet) {
             qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: second IN packet was"
                                            "received before CBW\n");
@@ -590,6 +605,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         break;
 
     case USB_MSD_CBW_DATAOUT:
+        trace_usb_msd_csw_in();
         if (s->unknown_in_packet) {
             error_report("usb-msd: unknown_in_packet in DATAOUT state");
             goto fail;
@@ -610,6 +626,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         break;
 
     case USB_MSD_CBW_CSW:
+        trace_usb_msd_csw_in();
         if (s->unknown_in_packet) {
             error_report("usb-msd: unknown_in_packet in DATAOUT state");
             goto fail;
@@ -626,6 +643,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         } else {
             usb_msd_send_status(s, p);
             s->cbw_state = USB_MSD_CBW_NONE;
+            trace_usb_msd_cbw_state(s->cbw_state);
         }
         break;
 
@@ -648,6 +666,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
                 s->data_len -= len;
                 if (s->data_len == 0) {
                     s->cbw_state = USB_MSD_CBW_CSW;
+                    trace_usb_msd_cbw_state(s->cbw_state);
                 }
             }
         }
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index dd04f14add1..688f7ba0b3d 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -264,12 +264,19 @@ usb_msd_maxlun(unsigned maxlun) "%d"
 usb_msd_send_status(unsigned status, unsigned tag, size_t size) "status %d, tag 0x%x, len %zd"
 usb_msd_data_in(unsigned packet, unsigned remaining, unsigned total) "%d/%d (scsi %d)"
 usb_msd_data_out(unsigned packet, unsigned remaining) "%d/%d"
+usb_msd_unknown_in(unsigned packet) "%d"
+usb_msd_csw_in(void) ""
 usb_msd_packet_async(void) ""
-usb_msd_packet_complete(void) ""
+usb_msd_data_packet_complete(void) ""
+usb_msd_csw_packet_complete(void) ""
 usb_msd_cmd_submit(unsigned lun, unsigned tag, unsigned flags, unsigned len, unsigned data_len) "lun %u, tag 0x%x, flags 0x%08x, len %d, data-len %d"
 usb_msd_cmd_complete(unsigned status, unsigned tag) "status %d, tag 0x%x"
+usb_msd_copy_data(unsigned tag, unsigned len) "tag 0x%x len %d"
+usb_msd_transfer_data(unsigned tag, unsigned len) "tag 0x%x len %d"
 usb_msd_cmd_cancel(unsigned tag) "tag 0x%x"
+usb_msd_cancel_io(void) ""
 usb_msd_fatal_error(void) ""
+usb_msd_cbw_state(unsigned cbw_state) "cbw-state %d"
 
 # dev-uas.c
 usb_uas_reset(int addr) "dev %d"
-- 
2.47.1


