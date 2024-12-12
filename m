Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8E1E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfH1-0004V9-M4; Thu, 12 Dec 2024 04:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGy-0004Op-W5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:17 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGv-0000RV-SK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:16 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee8e8e29f6so287479a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994852; x=1734599652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37LVw+vHgUcPiUejiyK7XkngH4mx+WuVuLhZ2YEEAj0=;
 b=YWWcVzT4ZyCyMSVVZ5DUZkz88sDx0IHbl+JvaIn/pt1zNB0X1AOAyaoyZ//nhT0g9V
 xusyvz1ncKuSzbNZ89tH0w3f/0bLiC/plRlh5ZmZdcqrBBlFJA0vaqb44TilRm0xmzfD
 pL4p0EDHVgPv0iJl869KOpRrsBPjdzWJ28v6oCaSQm2O16C/0PZPDYuDq56qIq/yG/y8
 tF3SaYF0ZJfMiZFxXF5wUII3QzsxU5PF8Umamb/rGUS0lxERRr0exGfYw+vq6Mc51xIE
 9PDF7oBmUPWOt2CAGx7C4z93b2eY1s+UmF6BeWwgoXBMUuGzLAUnv+zM0o65bgUgRcvs
 Ztfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994852; x=1734599652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37LVw+vHgUcPiUejiyK7XkngH4mx+WuVuLhZ2YEEAj0=;
 b=jpE8e22n5ambLFeLK35J9eDUBV7GJIoQAJ8QBj1t7qJiabOsFR8ENUIK3MD5HJUljn
 Gq71H4b0Cg4g4iHuhOegGk+ovKYOfzvd0IVkPXoHb+WqLBkkJj40UOz3m+1fl2A4uAJZ
 skUpsO19B7d6yCCGt11vmwZxz0UIdP3cRLveVS46DmgkKzQmMTMaH9u6T6khI/CUl6IU
 aYoNXLFSSn87+jp7PhR32Gbejvj3aRI1rgLhivwSnwCVLAL0WfWiAMKIwijzEe6VteTd
 jyv/2tqGx07DGbivsdcJMQ1GfT6LkxjFwdJci+EqNZeyecz73oiCFHswQmKAiHIBo/7x
 XSUQ==
X-Gm-Message-State: AOJu0Yyd3t4J3D1wG1FORHdr0jVXj61/gBLpUzKEadlMn4usiL4sXKfM
 SekwBX4gp5OPKRTmm/wyzaxlgDmYk6atb6G4JrnfS0D9k2ZPhPrNmXiizg==
X-Gm-Gg: ASbGncuISNJUGKGEFMic8ivq5nab/ohGbMC6T2RwGjBgBycDrzIRb5LRx2tOfUzr7hn
 HPFibUNZZ1IXwI1wqCtxg7vNKpNdcc6PFip95tYj7eBwdsOEbRjH9PWKZWYbWonuSYT051PG050
 TZ/6xudCL61i9H9DgzojLKmuiBCA+sbv45nFsmXRzDb+jYPP6hSCSiKG8Q1SJi8LtDE0bGAQv7C
 knIQjfqiceX+dXSb6BYt8LY6lrgFwdN79wa/71xdWTRgMl6pThKaEcy99o=
X-Google-Smtp-Source: AGHT+IGjN3w5jWJrH09oy7RQQpY3nxz+dMZlq6+lGB8JWHV+WsBDcK8bX/s3oonWZDE8C/0Kpc0DDg==
X-Received: by 2002:a17:90b:3c0c:b0:2ea:63e8:f24 with SMTP id
 98e67ed59e1d1-2f128044c21mr8536957a91.36.1733994851803; 
 Thu, 12 Dec 2024 01:14:11 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:14:11 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 11/11] usb/msd: Add more tracing
Date: Thu, 12 Dec 2024 19:13:22 +1000
Message-ID: <20241212091323.1442995-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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
index bc7e007e4fa..ea3f885a10c 100644
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
2.45.2


