Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FF7C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39Nj-0001su-Ra; Fri, 11 Apr 2025 04:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Ni-0001sW-1S
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Ng-0004iZ-1c
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22622ddcc35so21875295ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358695; x=1744963495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJxSDZQYeqf8Hb2gA+do9aPzsB2e0PnqAicfOJ1mz2g=;
 b=XpcUQS4TjgkRWd8oy+EeZXNv5N44mltPLPxu53mX4dEFjb2D8kE2Rz+g1tj1X/EdQe
 vQNb6bRkT9XsGSzfklTPlOZgO2hmO7hE1mIE/Z5fyFDkF1Lrp6k7eS1a96pA6OqjX3yD
 JKm/f29ZY6tNGNouzbHrAuhTsi4k3lJsB/s930HUgmc1J4O/Q30oegj3YgGpE6M4AecE
 68AFqtHV7SKj1KwGgGF/1h5f1a3DTdwgCo416i3Ud7FdixQ5IO8BE4oE2f3Rh/Xybu6P
 vhYMXV3j4dFueMlOYC2L8zZWZjTdBJlaL9J/I2NSvzyqZtpGpILO7yV+lGhJ/mfx7mIz
 XOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358695; x=1744963495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJxSDZQYeqf8Hb2gA+do9aPzsB2e0PnqAicfOJ1mz2g=;
 b=aJFbmUgp1sUXAUW7HFKjBHJWviFsAXS2Uldxbi5qmt7LYUzIe31xSUcYp/NvN5PnYt
 shQVn7FBRDO33WlSK/fc58OVCD2RW9zc8+lWXLtaMdaMZSq3RGZqeASv1uwDWcAwn8pw
 bhKxKI+NRHtJcZrvO7hMtla2lnrjXEUYtG3Qv3F6+8FCd48qtyG06H1QNf/u46xwyMJy
 00GDqHDnNXgDTZcplFk7YJ5eudXJfvnVNwJ5loRAfDx9YKO8Mx2OYXE10oPHWMcoDscw
 Xt24J+NHQOuafokX/KYw3IF+931s7paFV/pbhjlpa0BYi2G5yBWtJPrFB0xsKdV77Zzi
 dBRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXblACVvhlJkZFJ7YszHdbUeFGA18hmv5EBVllKnU9Cz1zq2Tl2fMbeo/0PJ1bfNFQUF6QNnfYWXoJ9@nongnu.org
X-Gm-Message-State: AOJu0Yz8FdnG9p6W9PbkdpeBFccZTv+J5pm8T/eSSTA/7R0yyMe18N+r
 bbRoyyVHst3GkqW8tKRoZGn9gSI9wvl3ryP706xEnQY0P5DUCiEG
X-Gm-Gg: ASbGncs2clLh1pxv6Cb0uWZhN4P7E63OcfkOGbz+nx6VX9B0Ndka3DP4r1u9ReidVb5
 oQGKVe1v0thtbmnJSoIeyyYRpRX0f7xPB5DPmgv+32uyLnWr9vIqBsIlyKi71X2Lzm2LuCBjTD7
 Y1Y47s9S8ZGXcTASTYlKSce6VFD1EW7ThgqJHnKkLiiT8QRJgjbn3PpKiDItS7mtcMDjMivX/0c
 4NdnexT+AeWnxRvK7k1Bp0jpv8FHcjDwAxcSZM8pWJwWGFFymbsGwS9A6B9Wq+drLnid9WInMTE
 fkPXD2QA7uuQjwSWKpRuO0lz/73+FmoogyBOaS36Cuux
X-Google-Smtp-Source: AGHT+IHdj+ANygVk6NjBzqvNQK5dSqVj2smJo90La0sfni+9J768wCfNyLOY/m08acpnath6KzkFyw==
X-Received: by 2002:a17:903:2392:b0:223:6744:bfb9 with SMTP id
 d9443c01a7336-22bea4efae4mr30831195ad.41.1744358694477; 
 Fri, 11 Apr 2025 01:04:54 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:04:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 06/10] usb/msd: Split async packet tracking into data and
 csw
Date: Fri, 11 Apr 2025 18:04:27 +1000
Message-ID: <20250411080431.207579-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411080431.207579-1-npiggin@gmail.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

The async packet handling logic has places that infer whether the
async packet is data or CSW, based on context. This is not wrong,
it just makes the logic easier to follow if they are categorised
when they are accepted.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/usb/msd.h |   5 +-
 hw/usb/dev-storage.c | 121 +++++++++++++++++++++++++++----------------
 2 files changed, 79 insertions(+), 47 deletions(-)

diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
index f9fd862b529..a40d15f5def 100644
--- a/include/hw/usb/msd.h
+++ b/include/hw/usb/msd.h
@@ -33,8 +33,11 @@ struct MSDState {
     struct usb_msd_csw csw;
     SCSIRequest *req;
     SCSIBus bus;
+
     /* For async completion.  */
-    USBPacket *packet;
+    USBPacket *data_packet;
+    USBPacket *csw_in_packet;
+
     /* usb-storage only */
     BlockConf conf;
     bool removable;
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 27093de5c84..a9d8d4e8618 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -178,18 +178,33 @@ static const USBDesc desc = {
     .str   = desc_strings,
 };
 
-static void usb_msd_packet_complete(MSDState *s, int status)
+static void usb_msd_data_packet_complete(MSDState *s, int status)
 {
-    USBPacket *p = s->packet;
+    USBPacket *p = s->data_packet;
 
     /*
-     * Set s->packet to NULL before calling usb_packet_complete
-     * because another request may be issued before
-     * usb_packet_complete returns.
+     * Set s->data_packet to NULL before calling usb_packet_complete
+     * because another request may be issued before usb_packet_complete
+     * returns.
      */
     trace_usb_msd_packet_complete();
+    s->data_packet = NULL;
+    p->status = status;
+    usb_packet_complete(&s->dev, p);
+}
+
+static void usb_msd_csw_packet_complete(MSDState *s, int status)
+{
+    USBPacket *p = s->csw_in_packet;
+
+    /*
+     * Set s->csw_in_packet to NULL before calling usb_packet_complete
+     * because another request may be issued before usb_packet_complete
+     * returns.
+     */
+    trace_usb_msd_packet_complete();
+    s->csw_in_packet = NULL;
     p->status = status;
-    s->packet = NULL;
     usb_packet_complete(&s->dev, p);
 }
 
@@ -197,8 +212,12 @@ static void usb_msd_fatal_error(MSDState *s)
 {
     trace_usb_msd_fatal_error();
 
-    if (s->packet) {
-        usb_msd_packet_complete(s, USB_RET_STALL);
+    if (s->data_packet) {
+        usb_msd_data_packet_complete(s, USB_RET_STALL);
+    }
+
+    if (s->csw_in_packet) {
+        usb_msd_csw_packet_complete(s, USB_RET_STALL);
     }
 
     /*
@@ -243,7 +262,7 @@ static void usb_msd_send_status(MSDState *s, USBPacket *p)
 void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
 {
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
-    USBPacket *p = s->packet;
+    USBPacket *p = s->data_packet;
 
     if ((s->mode == USB_MSDM_DATAOUT) != (req->cmd.mode == SCSI_XFER_TO_DEV)) {
         usb_msd_fatal_error(s);
@@ -254,10 +273,10 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
     s->scsi_off = 0;
     if (p) {
         usb_msd_copy_data(s, p);
-        p = s->packet;
+        p = s->data_packet;
         if (p && p->actual_length == p->iov.size) {
             /* USB_RET_SUCCESS status clears previous ASYNC status */
-            usb_msd_packet_complete(s, USB_RET_SUCCESS);
+            usb_msd_data_packet_complete(s, USB_RET_SUCCESS);
         }
     }
 }
@@ -265,7 +284,7 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
 void usb_msd_command_complete(SCSIRequest *req, size_t resid)
 {
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
-    USBPacket *p = s->packet;
+    USBPacket *p = s->data_packet;
 
     trace_usb_msd_cmd_complete(req->status, req->tag);
 
@@ -274,35 +293,37 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
     s->csw.residue = cpu_to_le32(s->data_len);
     s->csw.status = req->status != 0;
 
-    if (s->packet) {
-        if (s->data_len == 0 && s->mode == USB_MSDM_DATAOUT) {
-            /* A deferred packet with no write data remaining must be
-               the status read packet.  */
-            usb_msd_send_status(s, p);
-            s->mode = USB_MSDM_CBW;
-        } else if (s->mode == USB_MSDM_CSW) {
-            usb_msd_send_status(s, p);
-            s->mode = USB_MSDM_CBW;
-        } else {
-            if (s->data_len) {
-                int len = (p->iov.size - p->actual_length);
-                usb_packet_skip(p, len);
-                if (len > s->data_len) {
-                    len = s->data_len;
-                }
-                s->data_len -= len;
-            }
-            if (s->data_len == 0) {
-                s->mode = USB_MSDM_CSW;
+    scsi_req_unref(req);
+    s->req = NULL;
+
+    if (p) {
+        g_assert(s->mode == USB_MSDM_DATAIN || s->mode == USB_MSDM_DATAOUT);
+        if (s->data_len) {
+            int len = (p->iov.size - p->actual_length);
+            usb_packet_skip(p, len);
+            if (len > s->data_len) {
+                len = s->data_len;
             }
+            s->data_len -= len;
+        }
+        if (s->data_len == 0) {
+            s->mode = USB_MSDM_CSW;
         }
         /* USB_RET_SUCCESS status clears previous ASYNC status */
-        usb_msd_packet_complete(s, USB_RET_SUCCESS);
+        usb_msd_data_packet_complete(s, USB_RET_SUCCESS);
     } else if (s->data_len == 0) {
         s->mode = USB_MSDM_CSW;
     }
-    scsi_req_unref(req);
-    s->req = NULL;
+
+    if (s->mode == USB_MSDM_CSW) {
+        p = s->csw_in_packet;
+        if (p) {
+            usb_msd_send_status(s, p);
+            s->mode = USB_MSDM_CBW;
+            /* USB_RET_SUCCESS status clears previous ASYNC status */
+            usb_msd_csw_packet_complete(s, USB_RET_SUCCESS);
+        }
+    }
 }
 
 void usb_msd_request_cancelled(SCSIRequest *req)
@@ -332,8 +353,12 @@ void usb_msd_handle_reset(USBDevice *dev)
     }
     assert(s->req == NULL);
 
-    if (s->packet) {
-        usb_msd_packet_complete(s, USB_RET_STALL);
+    if (s->data_packet) {
+        usb_msd_data_packet_complete(s, USB_RET_STALL);
+    }
+
+    if (s->csw_in_packet) {
+        usb_msd_csw_packet_complete(s, USB_RET_STALL);
     }
 
     memset(&s->csw, 0, sizeof(s->csw));
@@ -388,11 +413,15 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
 {
     MSDState *s = USB_STORAGE_DEV(dev);
 
-    assert(s->packet == p);
-    s->packet = NULL;
-
-    if (s->req) {
-        scsi_req_cancel(s->req);
+    if (p == s->data_packet) {
+        s->data_packet = NULL;
+        if (s->req) {
+            scsi_req_cancel(s->req);
+        }
+    } else if (p == s->csw_in_packet) {
+        s->csw_in_packet = NULL;
+    } else {
+        g_assert_not_reached();
     }
 }
 
@@ -493,7 +522,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         }
         if (p->actual_length < p->iov.size) {
             trace_usb_msd_packet_async();
-            s->packet = p;
+            s->data_packet = p;
             p->status = USB_RET_ASYNC;
         }
         break;
@@ -525,7 +554,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
 
         /* Waiting for SCSI write to complete.  */
         trace_usb_msd_packet_async();
-        s->packet = p;
+        s->csw_in_packet = p;
         p->status = USB_RET_ASYNC;
         break;
 
@@ -537,7 +566,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         if (s->req) {
             /* still in flight */
             trace_usb_msd_packet_async();
-            s->packet = p;
+            s->csw_in_packet = p;
             p->status = USB_RET_ASYNC;
         } else {
             usb_msd_send_status(s, p);
@@ -565,7 +594,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         }
         if (p->actual_length < p->iov.size && s->mode == USB_MSDM_DATAIN) {
             trace_usb_msd_packet_async();
-            s->packet = p;
+            s->data_packet = p;
             p->status = USB_RET_ASYNC;
         }
         break;
-- 
2.47.1


