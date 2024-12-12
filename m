Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BA7E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGs-0004G3-08; Thu, 12 Dec 2024 04:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGq-0004Fl-Cu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:08 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGo-0000Ht-KM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:08 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7fdc6e04411so224784a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994844; x=1734599644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOlrH6ZLpCP3n/tz6Nc3xjpVDR5OJln8PIzoRU0dHNg=;
 b=clc/kBSorKzRk6Ee1MyhmwUuRSIsAmEGIzFJO/594ErBF4es6qBiZYAaiors4VBMfB
 zQuOk707CW3kRb8fYenMi6ZtvXZl3qMC0GHLpqIKsB/2YxSEUZGT48Kwonz4sjK87RiC
 FV78gWVOoHEeupSrWO/O8BPscTe7Zxs4KQJ2j3tlZ6MPS/1oB/fuEFTMeBpqTSDQvMN1
 sFMG4c15dQBTF8rJ0BLRPTnVxXCE9dKzav8zQQpEmpQBE7eGEzJfzaV5tZ0FK+nwCvru
 VInkw/nNVPZYCXP9mCTduulWFbciYyiTA/2aazX+SEpH9ycwG28WvOs6Vu7eN8/G01x3
 3Z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994844; x=1734599644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BOlrH6ZLpCP3n/tz6Nc3xjpVDR5OJln8PIzoRU0dHNg=;
 b=L1qeDFzu9m6l+KJo4bjKTHfRLkDulnY3byxtm5YkG8YhSMVVZShbu44MLaanf5kL0I
 vnfT16LGUbwFeC/l0Rg8IQ6Tk7TNGWyTzkzxUlHXyakk8LOD+2qjvjUuCUN4kAaJa7iZ
 gxng/5snqXz7OmOQlqgzDOrAjU1338iNARls0WTz8k21q+1MjoVKyhZLbSK472m49j5/
 dDLzoL71mKLm6DCHoRjtda+qocfO6AV1AteXbchwbg3o3Uu9LmyG+53nQbnsrxh4g0wq
 eUGg//yb63SMN1eOHFGwjhLdae0r4a81DFGwxed0Aevj+Bz1h66xZqixU5hWIr3uKaQN
 x/PQ==
X-Gm-Message-State: AOJu0YzcvAC3otkOL+mDR8J8Y4NBn2V+H57DwzMVZtCe/YF5w55O3Vel
 Lc9PNMcYQmN+9MiPCTavkvhZ72cO5/lTvSijX6IVe0aH6m8AUNYFQELsfg==
X-Gm-Gg: ASbGncsh8gYGfwL8jpPOCG1Tojb3LO/Lf1xrVoZpH1QhiodwwutGe1feB9OBQwoPnVG
 u/D8zjIWbMsR4QVyWCsLfFFAvt1w5f9/Oa6IKzD64Cd4t24UalrqcY6Zn7A+aFam4nuufvtNFPq
 MlnNRBz7tbNJHLjrNtIAlGjziV56K7oPImWXIhlvhYdSzhXryjbaUH+HI7QYRCxNx4dQ/yZM+Nm
 uIa9N5Z55sv9C6D3OspSi8mECK4SHc/ewk+ikMzNJ8ZaHOTb/3vFU4WJP8=
X-Google-Smtp-Source: AGHT+IEGWe1gSrOiQtxzXfbJcAMtGjgUmWxFUQ7L5PoZvEDFtSyE7CqmvW1Mq62Xf6iAdROo8QndvA==
X-Received: by 2002:a17:90b:4d06:b0:2ee:c2df:5d30 with SMTP id
 98e67ed59e1d1-2f12808c011mr8459895a91.26.1733994844338; 
 Thu, 12 Dec 2024 01:14:04 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:14:03 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 09/11] usb/msd: Rename mode to cbw_state, and tweak names
Date: Thu, 12 Dec 2024 19:13:20 +1000
Message-ID: <20241212091323.1442995-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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
index c04cee0041b..801a5d0c680 100644
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
2.45.2


