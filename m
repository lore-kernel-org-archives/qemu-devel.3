Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2C3C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8g-0005iz-Fh; Thu, 01 May 2025 23:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8U-0005VL-6W
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8Q-0001LQ-UF
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:25 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso2422365b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156741; x=1746761541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8tiJsmXmh7ujz+DQwMqz4CAbXuxxW7Y55FvEeVv1vo=;
 b=T7MfQzMdf29FUG2K5su68PtPmIctgpGpkhIbW6+IXyJwXMjJj44oe72Ct2hcGfYaHN
 EgtmJuVqo4F9Zq5aLs4dHMrOjCbnnoex8WHMR0xfUfnRo0CTxDrQiOfMAygC7ranTqkI
 8fI1xwc1uNku5wscl4NzcFTtyru4aKQtMCLJl7qJ5W0dy2YVtndU72olY12KuS9Qm4Wh
 wxL25ZAMDfKZ0wF/BmQ8ij/Xg2APcpB6Y1C4TFFro88pFI1M2+cOph9vT/Z7tTajhY5c
 PeLrq7qpsHV5bVIRYb8ASyn9GsJQE5i+zhKE4dA9bFafa3I8aPGLDToS9XiuJsKqPoWs
 Q9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156741; x=1746761541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8tiJsmXmh7ujz+DQwMqz4CAbXuxxW7Y55FvEeVv1vo=;
 b=LhNySGlnlIcLxqZd8O6IslsxjTIULrywQTN+Vz3OfB0/owUCniqRv3vCYv6TourWdF
 U6MgOLLTyVTyNuhmlJ5ao1yyXWDqq7x+BiqIXfoDDojmm4uich5i7FcmpFWtUoedXL1b
 phTOJLbGHrA2qER5WgovkzLGokuZWb4o6PbNoBjl6meoQxqVahLlHicpNwkzVbzQTJ9o
 A2qPP2EXnAIT56N5qyUCBlpcvRZZ3LGfaBto/c3hHKKn4gSUhZwsOD0zt/sHrgtYI6T+
 5Pp8nMb+xUMi15t0lMX7Cq/lB0mUvaya8gOUOobFdfr5XOHydLJ5hk2lvOflbWYNaNiy
 Qnhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAKwysDQF6DLdznWj8W/piXxEProkMPO1VbdRvH8oKKT60CGIJubVQVonY6sv6Nl+KwD2+h9vQ5p3e@nongnu.org
X-Gm-Message-State: AOJu0YxQbuDNvGmBd56Tyce1TcHX4FAOZXjVLIkem1dHcj6/nE7wIfDM
 hzr+69i6qwprLI00yJFLOCW3St2I44hnp5aqjImpQ4ig3BhPoCO+
X-Gm-Gg: ASbGncsIHdV+ZGBAVZ+jKdntm1NyN00eg1kPpGWyVMjHsbvZ31qbDtwXvLMZNwxPCbP
 gdRTZpKEZWNTHxMEZtEiA4iwr0MiEEzcKFd7xswXgArXfY668HX8DWmXfjDi5cJybIL5w/6tD9c
 9A8PxB//69OB+bA3XAAGSPI/7r5JNmY5tKZB99e64EcFaqXFVN3sS0KxQQZBPqddT39AebBsB3a
 +7BihEOpGbKWQ4nfWPEi7vMZBLlgXbqGwTPoehHuv1P/Dikw6W/5bq6VwLutgIFkVXVROjLVy8d
 VH43yqHyObkyuywLGX5kRrbBstjpzv0Hp5NuqjHehUzQ
X-Google-Smtp-Source: AGHT+IHHF6hsA3Q6P8LNTJuBIVfyPAPy4Ys2pteSMpn1iDUMVXZnZpEy3KPe3JAZGErZwZEA68quWg==
X-Received: by 2002:a05:6a21:108c:b0:1fe:61a4:71d8 with SMTP id
 adf61e73a8af0-20cdee3ae3emr1975044637.22.1746156741504; 
 Thu, 01 May 2025 20:32:21 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:21 -0700 (PDT)
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
Subject: [PATCH v4 16/22] usb/msd: Split async packet tracking into data and
 csw
Date: Fri,  2 May 2025 13:30:40 +1000
Message-ID: <20250502033047.102465-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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
index fe8955bf212..66fffda3713 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -185,18 +185,33 @@ static const USBDesc desc = {
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
 
@@ -204,8 +219,12 @@ static void usb_msd_fatal_error(MSDState *s)
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
@@ -250,7 +269,7 @@ static void usb_msd_send_status(MSDState *s, USBPacket *p)
 void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
 {
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
-    USBPacket *p = s->packet;
+    USBPacket *p = s->data_packet;
 
     if ((s->mode == USB_MSDM_DATAOUT) != (req->cmd.mode == SCSI_XFER_TO_DEV)) {
         usb_msd_fatal_error(s);
@@ -261,10 +280,10 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
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
@@ -272,7 +291,7 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
 void usb_msd_command_complete(SCSIRequest *req, size_t resid)
 {
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
-    USBPacket *p = s->packet;
+    USBPacket *p = s->data_packet;
 
     trace_usb_msd_cmd_complete(req->status, req->tag);
 
@@ -281,35 +300,37 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
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
@@ -339,8 +360,12 @@ void usb_msd_handle_reset(USBDevice *dev)
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
@@ -395,11 +420,15 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
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
 
@@ -500,7 +529,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         }
         if (p->actual_length < p->iov.size) {
             trace_usb_msd_packet_async();
-            s->packet = p;
+            s->data_packet = p;
             p->status = USB_RET_ASYNC;
         }
         break;
@@ -532,7 +561,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
 
         /* Waiting for SCSI write to complete.  */
         trace_usb_msd_packet_async();
-        s->packet = p;
+        s->csw_in_packet = p;
         p->status = USB_RET_ASYNC;
         break;
 
@@ -544,7 +573,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         if (s->req) {
             /* still in flight */
             trace_usb_msd_packet_async();
-            s->packet = p;
+            s->csw_in_packet = p;
             p->status = USB_RET_ASYNC;
         } else {
             usb_msd_send_status(s, p);
@@ -572,7 +601,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
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


