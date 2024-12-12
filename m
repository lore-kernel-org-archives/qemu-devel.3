Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265DAE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGk-0004Cs-Mn; Thu, 12 Dec 2024 04:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGi-0004AI-Uu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:00 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGg-0008RY-Ua
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:00 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee74291415so235145a91.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994837; x=1734599637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruI2VEm52N1m+U4TsADLxrOxUekJ4XCSufFXN4VqY+o=;
 b=P0TWr59xlOg6DI6VDV3bIT5MtKPlvsDixXFveJ/NNX4maMbbAlNlv14b+XuwmCWcz2
 8cfzGviaPjXJJAySDZZxhuE0sn7CaultacKjb6Z1yP9OCBGIX9Tar8w9xGwWyB8ZdZN6
 3C4pwd+89/EYxvy9huT1elo2/Jz453mu5KxK2GnqKHHBjQnbmudoqjrH1rw55EoFVI48
 ZFvQDAubjb0Nk6KHQWGFXZMCBuoiVuGDJCEx3lBv6TWo3tuH13wRTV/K1toTnuWi13x+
 C7oobB0oSSJgXtFAgV5HO9sdSBsxTL6ZO4iFpcNbihbgPNtgUHlYp8nSwJxy8NT4SS5F
 y3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994837; x=1734599637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ruI2VEm52N1m+U4TsADLxrOxUekJ4XCSufFXN4VqY+o=;
 b=htGQn0cPDSEHxbyal+xBnVuoKif5b28ARZE6Ny+WPmUG5gWJ30hZsc/9mpcDPsZy6m
 zTa1+DJKV3Gpl4VGcAfzYHbxahH5UyQQ/5e44u0FyGAvDAsNEuFlLO3I096XOxvnBtoo
 HOzhBgPwKwroIv/C1McRmIE/gaH3R1xcSUsA+E2YhDlfC+bltmAcMto5Pvan9OCOxjy1
 kA1LynNgiexV9JvTgSQYTc/fa0lXMwjpgv4nKoXfCPH8TT+gwZLddmXZc7Ll12LN7z9R
 PgmPrk/0ggLvCjUZBoe0JzMdkpvED2q7kC4ZJ4bUVKX4tlryyq1kWfFDPvY3sqk/O2jr
 dlDg==
X-Gm-Message-State: AOJu0Ywk3ToimEm1N7ZSz0IJTf4LMmlJozdcI+VbqvoC41HAxLJTE6Dm
 /68NrfZbn+7b8GneDzu7YXxdxxMwFAOoe2hthPzl4RUFywJF1mWsX9Q5NQ==
X-Gm-Gg: ASbGncsNqAk55zUK+caDO4sXAbGv97nW+mPzIOFuXwbIKdnDH4Z6c80WI9SMiSvU7Ja
 tcHxMszSGpxTRIVLPlwDyQoksrVih3ZxvO3SOZS76lNdmw2V5Dw3fNt9puAq492gVYb3vaHEkLK
 0NEhkZ8ZU0mhqYQGOOhGIn9WfApW17CHwbGCocONZ1pWfbJS5tvK+7VxFkOzrwkJkcLWWNWC+HM
 fqJYEv2QLSYkKvtOYGW3dGk4sCWcCgIYK+RGkI2E2qEyR/4c8imwvM141k=
X-Google-Smtp-Source: AGHT+IEJu+I9QoecG2NkTNlLhwkGIWEdgXRubn8Ku/pP9wUfm3yOXPL6xkLiqfj+z24YIW6gI/l4ig==
X-Received: by 2002:a17:90b:17cc:b0:2ee:7c02:8ef1 with SMTP id
 98e67ed59e1d1-2f127fbcec5mr8792724a91.11.1733994837258; 
 Thu, 12 Dec 2024 01:13:57 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:13:56 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 07/11] usb/msd: Split async packet tracking into data and csw
Date: Thu, 12 Dec 2024 19:13:18 +1000
Message-ID: <20241212091323.1442995-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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
index 064bb700cbc..4e23537cd75 100644
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
2.45.2


