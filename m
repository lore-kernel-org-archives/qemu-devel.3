Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E98CC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39O5-00025x-Fs; Fri, 11 Apr 2025 04:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Nn-0001tk-Iz
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:05:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Nl-0004j2-Hm
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:05:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2243803b776so24622145ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358700; x=1744963500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1qQE4+KO+DjYecgNKHp1lKOfWtIwSyvifooKIpV6dg=;
 b=fyZoA9A/TH8V0YB0YNEJrPG5SpNRXSQGLI/gulZ6WXyDd6l4ogtN2f6Kg2UWEVatey
 eDCd/sp7zK04O0M4pFIwSBenyF9IewJxQY7BadiySS0IQ9qEEJz+UqSS+Zd0aiAHKtBW
 oG9bDZZD/tZBPxG9H+n6CKq+7kS+Brb68xv+lesevxoTv7d/EACXGSRAb88eY85bVHwg
 VQxeXHBAQDHZ7sZ7LS6EqG1HOk9gcLliEl7LrDiE+55CqKbZq4/v2PnCfNrN8QaqF4oy
 QZC9GEutBpevqTKz3k/a01xt09M9OPKpqx6/3d7cal1ZQV5NB6jAotOKyKmlSXCXpqIZ
 Ztgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358700; x=1744963500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1qQE4+KO+DjYecgNKHp1lKOfWtIwSyvifooKIpV6dg=;
 b=WdPKLk4NMZAneqdufMOIg5jfjZfv5WUHCA8zWO7q93/FbdlrFOzLxqzrL1EVsyrkvt
 tUWw+FZGPLfTMOZTiFMOvZpupT1cAPgwRf0unviY2g95xAmuvkNO+0BOOS72hbRoIuX5
 +YqjD+qP7R1CDayjrJWYpkpwMyCRMm+wC7+pgP7t1aMq4ScdUjMeBEy7+yd4gay1tVeT
 qKGYb2D+H9BvGS0elSbSWrQkk1ivLRWBG4nm+ZkppqTU2Js61mkp6hHujbQOgyu+RkZH
 DJaqVvVm3RMC1nvaMMjJmSirbXGdQYRiaWiSfLed2bbqRYBTVcJqivVEuqVzxsnwJLYv
 pPrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSbUXHXF5V29d2mBA1egiJfbtsShl0h5So9tSSPv83NhyOEMDHiQpAKJhwWrLZUca6ERDzEUjgnocb@nongnu.org
X-Gm-Message-State: AOJu0YzNsOXXouGYPxd8QJsohhJQoP5FWR/sdchJWT1b73IPclre1t9S
 0hfXntpkl3Ql77y6acYIjn84enkHRUjEh+F5ixQMVW+02lx7RGGHwex6HA==
X-Gm-Gg: ASbGncuebVKP6ttuoQ58v81Rw0XkgoIh6hkz0TjVeWBwSgFn9onKRrs5f+zyn2FOzmO
 tCElbKX70CTpuiVYAeCv+mBnQ2MPSFJ6KuJLOOtPMx5XZR0OLpzOodEDNKUfRMy+tUnK/XxBERy
 8dJbDhZjLAHKdoT78KhVy8SiCv7XXwWaUx5xHjERIhBHhCRDLiR4Xd3l33x3DjUgud2OkH8LlMW
 pJA9MoBunqP4hJhJYefRNBkde14ZWfKnIHpRnpOeeO0g0sQLxXDgCaqD9xHtRnMnus3bP/HINdy
 LkPtCzuCbdhgMUJTHZR09AbD0WFDu3WF8JxnR0tORbYvuoqNoQHLE9U=
X-Google-Smtp-Source: AGHT+IEBRbk9WfXhGyEdMB0wLxlZCpyoF/gjqyeFqzM9k58dXZ+iG2ZTfH+vmelmFaww90KfutyKQg==
X-Received: by 2002:a17:903:2bce:b0:224:a79:5fe9 with SMTP id
 d9443c01a7336-22bea4bd2cbmr26768835ad.30.1744358700028; 
 Fri, 11 Apr 2025 01:05:00 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:04:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 08/10] usb/msd: Rename mode to cbw_state, and tweak names
Date: Fri, 11 Apr 2025 18:04:29 +1000
Message-ID: <20250411080431.207579-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411080431.207579-1-npiggin@gmail.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/usb/msd.h | 12 +++++------
 hw/usb/dev-storage.c | 50 +++++++++++++++++++++++---------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
index a40d15f5def..c109544f632 100644
--- a/include/hw/usb/msd.h
+++ b/include/hw/usb/msd.h
@@ -10,11 +10,11 @@
 #include "hw/usb.h"
 #include "hw/scsi/scsi.h"
 
-enum USBMSDMode {
-    USB_MSDM_CBW, /* Command Block.  */
-    USB_MSDM_DATAOUT, /* Transfer data to device.  */
-    USB_MSDM_DATAIN, /* Transfer data from device.  */
-    USB_MSDM_CSW /* Command Status.  */
+enum USBMSDCBWState {
+    USB_MSD_CBW_NONE,    /* Ready, waiting for CBW packet. */
+    USB_MSD_CBW_DATAOUT, /* Expecting DATA-OUT (to device) packet */
+    USB_MSD_CBW_DATAIN,  /* Expecting DATA-IN (from device) packet */
+    USB_MSD_CBW_CSW      /* No more data, expecting CSW packet.  */
 };
 
 struct QEMU_PACKED usb_msd_csw {
@@ -26,7 +26,7 @@ struct QEMU_PACKED usb_msd_csw {
 
 struct MSDState {
     USBDevice dev;
-    enum USBMSDMode mode;
+    enum USBMSDCBWState cbw_state;
     uint32_t scsi_off;
     uint32_t scsi_len;
     uint32_t data_len;
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 3b806872587..ed6d9b70b96 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -264,12 +264,12 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
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
@@ -301,7 +301,7 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
 
     g_assert(s->req);
     /* The CBW is what starts the SCSI request */
-    g_assert(s->mode != USB_MSDM_CBW);
+    g_assert(s->cbw_state != USB_MSD_CBW_NONE);
 
     s->csw.sig = cpu_to_le32(0x53425355);
     s->csw.tag = cpu_to_le32(req->tag);
@@ -312,7 +312,8 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
     s->req = NULL;
 
     if (p) {
-        g_assert(s->mode == USB_MSDM_DATAIN || s->mode == USB_MSDM_DATAOUT);
+        g_assert(s->cbw_state == USB_MSD_CBW_DATAIN ||
+                 s->cbw_state == USB_MSD_CBW_DATAOUT);
         if (s->data_len) {
             int len = (p->iov.size - p->actual_length);
             usb_packet_skip(p, len);
@@ -322,19 +323,19 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
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
@@ -377,7 +378,7 @@ void usb_msd_handle_reset(USBDevice *dev)
     }
 
     memset(&s->csw, 0, sizeof(s->csw));
-    s->mode = USB_MSDM_CBW;
+    s->cbw_state = USB_MSD_CBW_NONE;
 
     s->needs_reset = false;
 }
@@ -478,8 +479,8 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
     SCSIDevice *scsi_dev;
     int len;
 
-    switch (s->mode) {
-    case USB_MSDM_CBW:
+    switch (s->cbw_state) {
+    case USB_MSD_CBW_NONE:
         if (!try_get_valid_cbw(p, &cbw)) {
             goto fail;
         }
@@ -492,11 +493,11 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
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
@@ -513,7 +514,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         }
         break;
 
-    case USB_MSDM_DATAOUT:
+    case USB_MSD_CBW_DATAOUT:
         trace_usb_msd_data_out(p->iov.size, s->data_len);
         if (p->iov.size > s->data_len) {
             goto fail;
@@ -531,7 +532,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
                 }
                 s->data_len -= len;
                 if (s->data_len == 0) {
-                    s->mode = USB_MSDM_CSW;
+                    s->cbw_state = USB_MSD_CBW_CSW;
                 }
             }
         }
@@ -556,8 +557,8 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
     MSDState *s = (MSDState *)dev;
     int len;
 
-    switch (s->mode) {
-    case USB_MSDM_DATAOUT:
+    switch (s->cbw_state) {
+    case USB_MSD_CBW_DATAOUT:
         if (!check_valid_csw(p)) {
             goto fail;
         }
@@ -573,7 +574,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         p->status = USB_RET_ASYNC;
         break;
 
-    case USB_MSDM_CSW:
+    case USB_MSD_CBW_CSW:
         if (!check_valid_csw(p)) {
             goto fail;
         }
@@ -585,11 +586,11 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
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
@@ -603,11 +604,12 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
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
@@ -672,7 +674,7 @@ static const VMStateDescription vmstate_usb_msd = {
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


