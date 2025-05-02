Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58F7C3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8o-0006Ks-8o; Thu, 01 May 2025 23:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8e-0005ly-0a
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:37 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8c-0001M0-3c
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso1605189b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156752; x=1746761552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCpaksK2rzu3/LnJzfXlQ4odbcCWyWpTcklgGK0MoZU=;
 b=DtxpL1Fu62wXk+C4grmrXTk7nO9wLf760Nv+QLtmrRzb9uSltPumhG4t0mJmHad2St
 TWOSKCZPL7T2Kx1opIZsi3y9Vne2QgTdjJTd4PEz7jFWFrAYvnH9XFT9cL6tZ1qhVqv2
 y3tnhQeIi34qlcbGcDIhzfjwdYz/RcqCkhXmhHU8CqZ8aVAWSN+cm449ZowWWaDw7Tv+
 IZ6/wHkaVapfBfJHssy+QmXjmXIGFRTXYIb+2rU/U/+fwUd1iKa5BbhlYWVk/Igo+QgL
 s1N87oBkBI4yd/knrlfVkXhMg9OBfivDmAfTnYnOprM/nmq7A9+EryPYPql6T/+2i0CG
 IuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156752; x=1746761552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCpaksK2rzu3/LnJzfXlQ4odbcCWyWpTcklgGK0MoZU=;
 b=eUqRN+BLgb6VbTXODYzHCHHs/gf9xbUFE7iPO0Lyp3jVdzEWWBau3Klv7a9Uua7cIG
 iJAv25G7HBclO0yL2Z3bvMeTVqJhQ0cH3hpE5awXADazZUxqDasuwFjD70IFUD0ZoYAB
 Wi9+tc6WpTx+G3nLfCbql0YQGgm88oVlE9TDzhYBOfTtBWs9eFhwfjvG56V3mZcDCBQF
 qwZl74rBwM/7fSKTQX31Wy7WdVp3UoVYRgfnBB49A8x0k4CYUxeKLYnRNyhJ0PIXUFM/
 KKsxDKXoM0CBnTvx2OblqIDu+/B7vO4b0ehw2sPcOXOpUvWXvU+Wi/3AIQQDRK3klNsx
 Na/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiC6emr7z0vI+Oj5Xyj/Nxm0o5LVYQHC8b5oYuhZyRQIdBLTipPrtIZpVLaJlsmBTUvLsLzGoAEsQM@nongnu.org
X-Gm-Message-State: AOJu0YxDD9qdEpLqoi65dX1aMdbmVwVLCuiYeeGRQFXY/fpS6fS+XdP7
 qgH9bV7+2M5QxgHOjGrqMMmV/cabDo3hvNXGMXbIaHFGrcqOjKnHmrrFLw==
X-Gm-Gg: ASbGnctao5MBhjFFk9+nDZCcMgkjFKy9pXuW1c0sOSjO1+KT11exNQsVaTWTDRiLNeH
 yXJp7tb7I6bWPTK2eKDGz1UkG/c0dnlfQ2dk+hUO0702NouLgjYpYQRwOT8URZRgkkpzDiD/cHo
 4mQTM2OcDX4ej0dcc/IFV3zD/o6bU2FtjDS1nIutoDTDcfNSVaEKRFpLjils9/nUN3DNa2Bt6uN
 NE8r1KsERUxMUi/D5zpwWE5xCzk1nMj/BIaOGbhmL2571yaaJR3UNWgcRXVsI/KWSaTAUVvDTbe
 IahSFQxugsnfrVCq7sS9d6wn6mk14+pJoomQppCVR5Ol
X-Google-Smtp-Source: AGHT+IGs5vssIE+1umDaLVUZpeZZ1yW8JNe9lZuwH4x7fAn02XIGFiw97Ml2hjYH5lYkqbKIAGtyiw==
X-Received: by 2002:a05:6a00:4143:b0:736:755b:8317 with SMTP id
 d2e1a72fcca58-74058b345d5mr1937524b3a.21.1746156751769; 
 Thu, 01 May 2025 20:32:31 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 18/22] usb/msd: Rename mode to cbw_state, and tweak names
Date: Fri,  2 May 2025 13:30:42 +1000
Message-ID: <20250502033047.102465-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

This reflects a little better what it does, particularly with a
subsequent change to relax the order packets are seen in. This
field is not the general state of the MSD state machine, rather
it follows packets that are completed as part of a CBW command.

The difference is a bit subtle, so for a concrete example, the
next change will permit the host to send a CSW packet before it
sends the associated CBW packet. In that case the CSW packet
will be tracked and the MSD state machine will move, but this
mode / cbw_state field would remain unchanged (in the "expecting
CBW" state), until the CBW packet arrives.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/usb/msd.h | 14 ++++++-------
 hw/usb/dev-storage.c | 50 +++++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
index a40d15f5def..af12a16c35f 100644
--- a/include/hw/usb/msd.h
+++ b/include/hw/usb/msd.h
@@ -10,12 +10,12 @@
 #include "hw/usb.h"
 #include "hw/scsi/scsi.h"
 
-enum USBMSDMode {
-    USB_MSDM_CBW, /* Command Block.  */
-    USB_MSDM_DATAOUT, /* Transfer data to device.  */
-    USB_MSDM_DATAIN, /* Transfer data from device.  */
-    USB_MSDM_CSW /* Command Status.  */
-};
+typedef enum USBMSDCBWState {
+    USB_MSD_CBW_NONE,    /* Ready, waiting for CBW packet. */
+    USB_MSD_CBW_DATAOUT, /* Expecting DATA-OUT (to device) packet */
+    USB_MSD_CBW_DATAIN,  /* Expecting DATA-IN (from device) packet */
+    USB_MSD_CBW_CSW      /* No more data, expecting CSW packet.  */
+} USBMSDCBWState;
 
 struct QEMU_PACKED usb_msd_csw {
     uint32_t sig;
@@ -26,7 +26,7 @@ struct QEMU_PACKED usb_msd_csw {
 
 struct MSDState {
     USBDevice dev;
-    enum USBMSDMode mode;
+    USBMSDCBWState cbw_state;
     uint32_t scsi_off;
     uint32_t scsi_len;
     uint32_t data_len;
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 81bfdf08992..5b773a22e60 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -271,12 +271,12 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
     USBPacket *p = s->data_packet;
 
-    if (s->mode == USB_MSDM_DATAIN) {
+    if (s->cbw_state == USB_MSD_CBW_DATAIN) {
         if (req->cmd.mode == SCSI_XFER_TO_DEV) {
             usb_msd_fatal_error(s);
             return;
         }
-    } else if (s->mode == USB_MSDM_DATAOUT) {
+    } else if (s->cbw_state == USB_MSD_CBW_DATAOUT) {
         if (req->cmd.mode != SCSI_XFER_TO_DEV) {
             usb_msd_fatal_error(s);
             return;
@@ -308,7 +308,7 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
 
     g_assert(s->req);
     /* The CBW is what starts the SCSI request */
-    g_assert(s->mode != USB_MSDM_CBW);
+    g_assert(s->cbw_state != USB_MSD_CBW_NONE);
 
     s->csw.sig = cpu_to_le32(0x53425355);
     s->csw.tag = cpu_to_le32(req->tag);
@@ -319,7 +319,8 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
     s->req = NULL;
 
     if (p) {
-        g_assert(s->mode == USB_MSDM_DATAIN || s->mode == USB_MSDM_DATAOUT);
+        g_assert(s->cbw_state == USB_MSD_CBW_DATAIN ||
+                 s->cbw_state == USB_MSD_CBW_DATAOUT);
         if (s->data_len) {
             int len = (p->iov.size - p->actual_length);
             usb_packet_skip(p, len);
@@ -329,19 +330,19 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
             s->data_len -= len;
         }
         if (s->data_len == 0) {
-            s->mode = USB_MSDM_CSW;
+            s->cbw_state = USB_MSD_CBW_CSW;
         }
         /* USB_RET_SUCCESS status clears previous ASYNC status */
         usb_msd_data_packet_complete(s, USB_RET_SUCCESS);
     } else if (s->data_len == 0) {
-        s->mode = USB_MSDM_CSW;
+        s->cbw_state = USB_MSD_CBW_CSW;
     }
 
-    if (s->mode == USB_MSDM_CSW) {
+    if (s->cbw_state == USB_MSD_CBW_CSW) {
         p = s->csw_in_packet;
         if (p) {
             usb_msd_send_status(s, p);
-            s->mode = USB_MSDM_CBW;
+            s->cbw_state = USB_MSD_CBW_NONE;
             /* USB_RET_SUCCESS status clears previous ASYNC status */
             usb_msd_csw_packet_complete(s, USB_RET_SUCCESS);
         }
@@ -384,7 +385,7 @@ void usb_msd_handle_reset(USBDevice *dev)
     }
 
     memset(&s->csw, 0, sizeof(s->csw));
-    s->mode = USB_MSDM_CBW;
+    s->cbw_state = USB_MSD_CBW_NONE;
 
     s->needs_reset = false;
 }
@@ -485,8 +486,8 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
     SCSIDevice *scsi_dev;
     int len;
 
-    switch (s->mode) {
-    case USB_MSDM_CBW:
+    switch (s->cbw_state) {
+    case USB_MSD_CBW_NONE:
         if (!try_get_valid_cbw(p, &cbw)) {
             goto fail;
         }
@@ -499,11 +500,11 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         tag = le32_to_cpu(cbw.tag);
         s->data_len = le32_to_cpu(cbw.data_len);
         if (s->data_len == 0) {
-            s->mode = USB_MSDM_CSW;
+            s->cbw_state = USB_MSD_CBW_CSW;
         } else if (cbw.flags & 0x80) {
-            s->mode = USB_MSDM_DATAIN;
+            s->cbw_state = USB_MSD_CBW_DATAIN;
         } else {
-            s->mode = USB_MSDM_DATAOUT;
+            s->cbw_state = USB_MSD_CBW_DATAOUT;
         }
         trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
                                  cbw.cmd_len, s->data_len);
@@ -520,7 +521,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         }
         break;
 
-    case USB_MSDM_DATAOUT:
+    case USB_MSD_CBW_DATAOUT:
         trace_usb_msd_data_out(p->iov.size, s->data_len);
         if (p->iov.size > s->data_len) {
             goto fail;
@@ -538,7 +539,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
                 }
                 s->data_len -= len;
                 if (s->data_len == 0) {
-                    s->mode = USB_MSDM_CSW;
+                    s->cbw_state = USB_MSD_CBW_CSW;
                 }
             }
         }
@@ -563,8 +564,8 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
     MSDState *s = (MSDState *)dev;
     int len;
 
-    switch (s->mode) {
-    case USB_MSDM_DATAOUT:
+    switch (s->cbw_state) {
+    case USB_MSD_CBW_DATAOUT:
         if (!check_valid_csw(p)) {
             goto fail;
         }
@@ -580,7 +581,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         p->status = USB_RET_ASYNC;
         break;
 
-    case USB_MSDM_CSW:
+    case USB_MSD_CBW_CSW:
         if (!check_valid_csw(p)) {
             goto fail;
         }
@@ -592,11 +593,11 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
             p->status = USB_RET_ASYNC;
         } else {
             usb_msd_send_status(s, p);
-            s->mode = USB_MSDM_CBW;
+            s->cbw_state = USB_MSD_CBW_NONE;
         }
         break;
 
-    case USB_MSDM_DATAIN:
+    case USB_MSD_CBW_DATAIN:
         trace_usb_msd_data_in(p->iov.size, s->data_len, s->scsi_len);
         if (s->scsi_len) {
             usb_msd_copy_data(s, p);
@@ -610,11 +611,12 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
                 }
                 s->data_len -= len;
                 if (s->data_len == 0) {
-                    s->mode = USB_MSDM_CSW;
+                    s->cbw_state = USB_MSD_CBW_CSW;
                 }
             }
         }
-        if (p->actual_length < p->iov.size && s->mode == USB_MSDM_DATAIN) {
+        if (p->actual_length < p->iov.size &&
+                s->cbw_state == USB_MSD_CBW_DATAIN) {
             trace_usb_msd_packet_async();
             s->data_packet = p;
             p->status = USB_RET_ASYNC;
@@ -679,7 +681,7 @@ static const VMStateDescription vmstate_usb_msd = {
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, MSDState),
-        VMSTATE_UINT32(mode, MSDState),
+        VMSTATE_UINT32(cbw_state, MSDState),
         VMSTATE_UINT32(scsi_len, MSDState),
         VMSTATE_UINT32(scsi_off, MSDState),
         VMSTATE_UINT32(data_len, MSDState),
-- 
2.47.1


