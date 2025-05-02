Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EC1C3ABA5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh9Q-0008Ko-Ov; Thu, 01 May 2025 23:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh93-0007k4-CD
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:33:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh90-0001P1-Sk
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:33:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so1427762b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156777; x=1746761577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AvJbFHq84bzdUxQ3+x8hU4VLddarGy3zAWWQFK08MCg=;
 b=djxqTyah3G5HEgNzSN0fNXA7GKoBwVraLZAnOtFUjM7g292nabHUhr9PBRPiwCRaTQ
 FK4GO7xNON292OQlkZrvpMJTP3DQKMS4rFGba1sMVe81itubjQG2GMAoPnYrlDLwV/td
 6RCk5yUVgGMaQK880cCT98mmCiKXGfs7CoozShEFGP0wfEFYO/2j4jwLhyaKeHldM5tc
 SABSiKZO3IyDxzaNQmWhwngV5aztygn0dSL22PGcrchjUFIXwUclR6uKVX2Mzyuf5mih
 xuiKVc7+96Ose0yDJjmlNWllmvO0ZXk2KMSjislvh05HJbHzMj7eozXghRFKdYKcSCKw
 BBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156777; x=1746761577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AvJbFHq84bzdUxQ3+x8hU4VLddarGy3zAWWQFK08MCg=;
 b=mU2I7UdqrA2MmBb+nL7emVHe8JzryOBDiLuGnZCpHMs/JI7xUKeNiIkuh7+wFV2dt9
 5Ss2Gl/Ynw3x4NH6lZ7NNIyQZjhWPV0AfzJ+XTK9IKD6NK7a2q5rremgkcGeGUZNHqs8
 n6wdwp7VRSmwM3Hf5dCmi7dIHFsbtgTBb9xzXiMFAvq0o9DLKk5uQuhcgppOJanfgK+d
 ijgqdp9Rzsea38xxpvWaffmx091OpDA/q67XTFLr7BZg1ZSwE6SCET/OjY3osShFhF9K
 shF4+I0qxAsFVP3fNkigyTG8APe0vuO2Y84SS0+F4fpNsN/9l/egD8Id6QC7udxQRVV5
 DObQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0uTAA5tCAs5Vfkp/Vu53OnRn2eT5mwdPjcBO+oNw5y1ty/oNHvNzLSiOb6uYBKE+Xqtx98nWqrxPv@nongnu.org
X-Gm-Message-State: AOJu0YxCv5dMnG5fd5isXMXYgsQWuk39cs7yQ6UCHu3KXfF7/fNA4gVK
 iv4eX/kfBixoLQZ00IlDGkYFLJpvf8DmgWJ20dqtZ7XN/63uuvuz
X-Gm-Gg: ASbGnctjl6TT3tKQ4mh2+nrvbSi6jC2SQCtQqXbNhuAwDRa4A1SBtBLzlzcxRppCbvQ
 Jt29bKCSSnlqcbsllBiKKvJrDXzfJfJpXQPpIJ+dJEhh6Vodht6NaBlCKz15lmY2aFBBi60DE1F
 wuZUFqwyVkpITGAdyrPKZECBWChrwIfcxg5Pgi3AHMNfbo/PGCyojTtwPFe9HenuGtR7d/T9STA
 BZe9YVLx8ELWXkydPRVVu57mTMueT1t4QEKRyytMcgqf8gBHPacMRmif6JY/EgYWfRZqVZK9vLK
 p66lL3qq1+/O+RLISLLQitS9KRXbuWA4WnJTm//IDPyT
X-Google-Smtp-Source: AGHT+IH+3Wpj1+PnaiBPvat4oi8JI/KtEFPaT+JvKYIsSuoYf/0sgEvX6NfPDsfNID52W5bz5R/Shg==
X-Received: by 2002:a05:6a00:3286:b0:739:4a30:b900 with SMTP id
 d2e1a72fcca58-74058a1aa27mr1904280b3a.7.1746156772563; 
 Thu, 01 May 2025 20:32:52 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:52 -0700 (PDT)
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
Subject: [PATCH v4 22/22] usb/msd: Add more tracing
Date: Fri,  2 May 2025 13:30:46 +1000
Message-ID: <20250502033047.102465-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 61 +++++++++++++++++++++++++++++++++-----------
 hw/usb/trace-events  | 11 +++++++-
 2 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index f421bd1f8dd..79f857de599 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -185,6 +185,21 @@ static const USBDesc desc = {
     .str   = desc_strings,
 };
 
+
+static void usb_msd_change_cbw_state(MSDState *s, USBMSDCBWState cbw_state)
+{
+    g_assert(s->cbw_state != cbw_state);
+    s->cbw_state = cbw_state;
+    trace_usb_msd_cbw_state(s->cbw_state);
+}
+
+static void usb_msd_set_cbw_state(MSDState *s, USBMSDCBWState cbw_state)
+{
+    if (s->cbw_state != cbw_state) {
+        usb_msd_change_cbw_state(s, cbw_state);
+    }
+}
+
 static void usb_msd_data_packet_complete(MSDState *s, int status)
 {
     USBPacket *p = s->data_packet;
@@ -194,7 +209,7 @@ static void usb_msd_data_packet_complete(MSDState *s, int status)
      * because another request may be issued before usb_packet_complete
      * returns.
      */
-    trace_usb_msd_packet_complete();
+    trace_usb_msd_data_packet_complete();
     s->data_packet = NULL;
     p->status = status;
     usb_packet_complete(&s->dev, p);
@@ -209,7 +224,7 @@ static void usb_msd_csw_packet_complete(MSDState *s, int status)
      * because another request may be issued before usb_packet_complete
      * returns.
      */
-    trace_usb_msd_packet_complete();
+    trace_usb_msd_csw_packet_complete();
     s->csw_in_packet = NULL;
     p->status = status;
     usb_packet_complete(&s->dev, p);
@@ -238,7 +253,11 @@ static void usb_msd_fatal_error(MSDState *s)
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
@@ -271,6 +290,8 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
     USBPacket *p = s->data_packet;
 
+    trace_usb_msd_transfer_data(req->tag, len);
+
     if (s->cbw_state == USB_MSD_CBW_DATAIN) {
         if (req->cmd.mode == SCSI_XFER_TO_DEV) {
             usb_msd_fatal_error(s);
@@ -333,19 +354,19 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
             s->data_len -= len;
         }
         if (s->data_len == 0) {
-            s->cbw_state = USB_MSD_CBW_CSW;
+            usb_msd_change_cbw_state(s, USB_MSD_CBW_CSW);
         }
         /* USB_RET_SUCCESS status clears previous ASYNC status */
         usb_msd_data_packet_complete(s, USB_RET_SUCCESS);
     } else if (s->data_len == 0) {
-        s->cbw_state = USB_MSD_CBW_CSW;
+        usb_msd_change_cbw_state(s, USB_MSD_CBW_CSW);
     }
 
     if (s->cbw_state == USB_MSD_CBW_CSW) {
         p = s->csw_in_packet;
         if (p) {
             usb_msd_send_status(s, p);
-            s->cbw_state = USB_MSD_CBW_NONE;
+            usb_msd_change_cbw_state(s, USB_MSD_CBW_NONE);
             /* USB_RET_SUCCESS status clears previous ASYNC status */
             usb_msd_csw_packet_complete(s, USB_RET_SUCCESS);
         }
@@ -388,7 +409,7 @@ void usb_msd_handle_reset(USBDevice *dev)
     }
 
     memset(&s->csw, 0, sizeof(s->csw));
-    s->cbw_state = USB_MSD_CBW_NONE;
+    usb_msd_set_cbw_state(s, USB_MSD_CBW_NONE);
 
     s->needs_reset = false;
 }
@@ -439,6 +460,8 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
 {
     MSDState *s = USB_STORAGE_DEV(dev);
 
+    trace_usb_msd_cancel_io();
+
     if (p == s->data_packet) {
         s->data_packet = NULL;
         if (s->req) {
@@ -491,11 +514,14 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
     SCSIDevice *scsi_dev;
     int len;
 
+    trace_usb_msd_data_out(p->iov.size, s->data_len);
+
     switch (s->cbw_state) {
     case USB_MSD_CBW_NONE:
         if (!try_get_valid_cbw(p, &cbw)) {
             goto fail;
         }
+        trace_usb_msd_cbw_out();
         scsi_dev = scsi_device_find(&s->bus, 0, 0, cbw.lun);
         if (scsi_dev == NULL) {
             qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CBW LUN %d\n",
@@ -505,11 +531,11 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         tag = le32_to_cpu(cbw.tag);
         s->data_len = le32_to_cpu(cbw.data_len);
         if (s->data_len == 0) {
-            s->cbw_state = USB_MSD_CBW_NODATA;
+            usb_msd_change_cbw_state(s, USB_MSD_CBW_NODATA);
         } else if (cbw.flags & 0x80) {
-            s->cbw_state = USB_MSD_CBW_DATAIN;
+            usb_msd_change_cbw_state(s, USB_MSD_CBW_DATAIN);
         } else {
-            s->cbw_state = USB_MSD_CBW_DATAOUT;
+            usb_msd_change_cbw_state(s, USB_MSD_CBW_DATAOUT);
         }
         if (s->unknown_in_packet) {
             if (s->cbw_state == USB_MSD_CBW_DATAIN) {
@@ -540,7 +566,6 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         break;
 
     case USB_MSD_CBW_DATAOUT:
-        trace_usb_msd_data_out(p->iov.size, s->data_len);
         if (s->unknown_in_packet) {
             error_report("usb-msd: unknown_in_packet in DATAOUT state");
             goto fail;
@@ -562,7 +587,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
                 }
                 s->data_len -= len;
                 if (s->data_len == 0) {
-                    s->cbw_state = USB_MSD_CBW_CSW;
+                    usb_msd_change_cbw_state(s, USB_MSD_CBW_CSW);
                 }
             }
         }
@@ -579,6 +604,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
     return;
 
 fail:
+    trace_usb_msd_bad_packet();
     p->status = USB_RET_STALL;
 }
 
@@ -587,8 +613,11 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
     MSDState *s = (MSDState *)dev;
     int len;
 
+    trace_usb_msd_data_in(p->iov.size, s->data_len, s->scsi_len);
+
     switch (s->cbw_state) {
     case USB_MSD_CBW_NONE:
+        trace_usb_msd_unknown_in(p->iov.size);
         if (s->unknown_in_packet) {
             qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: second IN packet was"
                                            "received before CBW\n");
@@ -602,12 +631,13 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
     case USB_MSD_CBW_NODATA:
     case USB_MSD_CBW_DATAOUT:
         if (s->unknown_in_packet) {
-            error_report("usb-msd: unknown_in_packet in DATAOUT state");
+            error_report("usb-msd: unknown_in_packet in DATAOUT/NODATA state");
             goto fail;
         }
         if (!check_valid_csw(p)) {
             goto fail;
         }
+        trace_usb_msd_csw_in();
         if (s->data_len != 0) {
             qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: CSW received before "
                                            "all data was sent\n");
@@ -621,6 +651,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         break;
 
     case USB_MSD_CBW_CSW:
+        trace_usb_msd_csw_in();
         if (s->unknown_in_packet) {
             error_report("usb-msd: unknown_in_packet in CSW state");
             goto fail;
@@ -636,12 +667,11 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
             p->status = USB_RET_ASYNC;
         } else {
             usb_msd_send_status(s, p);
-            s->cbw_state = USB_MSD_CBW_NONE;
+            usb_msd_change_cbw_state(s, USB_MSD_CBW_NONE);
         }
         break;
 
     case USB_MSD_CBW_DATAIN:
-        trace_usb_msd_data_in(p->iov.size, s->data_len, s->scsi_len);
         if (s->unknown_in_packet) {
             error_report("usb-msd: unknown_in_packet in DATAIN state");
             goto fail;
@@ -658,7 +688,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
                 }
                 s->data_len -= len;
                 if (s->data_len == 0) {
-                    s->cbw_state = USB_MSD_CBW_CSW;
+                    usb_msd_change_cbw_state(s, USB_MSD_CBW_CSW);
                 }
             }
         }
@@ -676,6 +706,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
     return;
 
 fail:
+    trace_usb_msd_bad_packet();
     p->status = USB_RET_STALL;
 }
 
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index dd04f14add1..851ba9986c3 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -264,12 +264,21 @@ usb_msd_maxlun(unsigned maxlun) "%d"
 usb_msd_send_status(unsigned status, unsigned tag, size_t size) "status %d, tag 0x%x, len %zd"
 usb_msd_data_in(unsigned packet, unsigned remaining, unsigned total) "%d/%d (scsi %d)"
 usb_msd_data_out(unsigned packet, unsigned remaining) "%d/%d"
+usb_msd_unknown_in(unsigned packet) "%d"
+usb_msd_cbw_out(void) ""
+usb_msd_csw_in(void) ""
 usb_msd_packet_async(void) ""
-usb_msd_packet_complete(void) ""
+usb_msd_data_packet_complete(void) ""
+usb_msd_csw_packet_complete(void) ""
+usb_msd_bad_packet(void) ""
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


