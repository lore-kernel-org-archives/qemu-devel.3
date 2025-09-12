Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76972CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwuh6-00071s-L3; Thu, 11 Sep 2025 23:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwuh0-0006zh-1k
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugq-0007wZ-QF
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:21 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45dd7b15a64so12206935e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648591; x=1758253391; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UWAG2nYcB9+NQk8o/WlZdPLMQXNxjnTYcPCkh5OBnwc=;
 b=nm0/cufn347/m0QEl6tmuTy0Ptsm1a+UbgYOmwczAwDCq9V6zdQwzuEsBVsMTgPGgf
 KB0D8nMgYLe1BIrZKBWBH5mCNb225iWQ4iVEYEmhHH65J6Ghx4+6ac3dj4D+d/qxxf46
 fABm9aracYqVW6f+1u30ZQGwy5oTJfA5DyYX3o0bna8NoyrIfiV9joJYiGB+kEDfgWCR
 8T/QH27ynfmoHYadaQS3K7Y18asHfn6UnSyalh7op0jDhse1OiHS30LJ2xzBiEmYcnjE
 +OGuUmbbSECjV6msHmeo9kPjhli+6sn+HLukHce0bTwhq0ZNB4QY3BLhzyxN2vpTza4E
 g/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648591; x=1758253391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWAG2nYcB9+NQk8o/WlZdPLMQXNxjnTYcPCkh5OBnwc=;
 b=H8PJemB4g/S9KyzUhcWmJ7UIx53XsAmM0AjLm0tZ2B6jcC2Qvk8en378auCHN0sUia
 CCXN5VjBDaFUK1QDHdEKsrjHOgbHRLx+6Wl6C+/npktK+W0IiDIYG0z9dva9qTnPROEw
 tcfxosb3DXsNfJOeQ0TEKOEk6vqIroLe4cfpgpq+iPSDmKMjdGwFObYQyD5sAWQP1Wmo
 5L6phVHzVAXeh55TPYn2U54B2711gZnCc8QbYOpN2VJIP/xyMcntroEgPjeYBU+ACmDW
 8wVq98rtHWcfdxwoEiyXlCbtXuGeucYqAtLKQeaOSORzAYarrkB6lMMVdJq5XWS7rkgV
 UPrA==
X-Gm-Message-State: AOJu0Yz5JhZibhxxjX5wyJc/gWBvNg8wwgwWFQzfyK3sr1qEQLQyTIMY
 JyKMV9rkQvvikBn9NSvkeyYtgWkLBc7dfLWrmAbfd+KbrNDoa3sDLTyi
X-Gm-Gg: ASbGncumR780iqK9YvKrYr2guFCnRpu8xEXiZos9RXcaB0rv1wI6CRD0r6WlW33B/nZ
 enednWF4ORHY0fPG6fMNgHijMku/Jc2/Pn1UpqzY7jdtLT+ihqFmd7krTtMX++bZ2+EYxBuV4fm
 3EE03zLV/x+xcQff922ryZMEOdPON4qiUt4ocrdEKF2NTuzakuKFaK6lWpvVog8YMWudIlV6R5j
 KKYDXRoUpOlP008zWRicnxsoLc7PnxA5PYGVAIotIlVbO+unqtUUe1XpO1PmXZRBvLLsRiChhdP
 TuTNBmA7tOwn3S2rBQReuHByXOjsAqMnUqnPHjNx2AgD5F+93aRBHEWKVe2314nZtfWoLvsmkD1
 TtdpFxI1pi/ec7Da9PNA1/4id0KRCOAQ/lBwh/Adap0oBavFMGkkQnlqj5jyp+OxwTghDEIYHeg
 ==
X-Google-Smtp-Source: AGHT+IFWOHYpfqaAODFZGtVNBSlPMYAip2DEsg+9+PyT9BOoPXlDzKhqWDrZSw1LuoggUEEF5jrZyA==
X-Received: by 2002:a5d:64e9:0:b0:3e2:3717:cce5 with SMTP id
 ffacd0b85a97d-3e75e16b341mr4557411f8f.30.1757648590660; 
 Thu, 11 Sep 2025 20:43:10 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3e7607e1400sm4829739f8f.55.2025.09.11.20.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:43:09 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Fri, 12 Sep 2025 05:39:54 +0200
Subject: [PATCH v4 09/10] virtio-console: notify the guest about terminal
 resizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-console-resize-v4-9-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648577; l=4791;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=wxnBg2LKBs7LewgLtCfoFnfZ2ION7/6mMou9gYdOTMY=;
 b=9nb+UZodi926wtvi9aGmbSnxLOFOTeeECo8NU116h4RYV6xyyRnb7VUJ5D3btkvDDdrkJfJcP
 QHEDzEM/j4bB7F3iGDvEFxMX4oi1OzgbzOl/cOoB5PFzCyxV3LxPJJT
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x334.google.com
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

From: Szymon Lukasz <noh4hss@gmail.com>

If a virtio serial port is a console port forward terminal resize
messages from the chardev backend to the guest.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 hw/char/virtio-console.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 881c862ce9d12027f392031bdea7dbe280ec5493..0dd10a81f151b0606f6060ab2b4936117d81dd83 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -32,6 +32,7 @@ struct VirtConsole {
 
     CharBackend chr;
     guint watch;
+    uint16_t cols, rows;
 };
 
 /*
@@ -107,6 +108,33 @@ static ssize_t flush_buf(VirtIOSerialPort *port,
     return ret;
 }
 
+static void virtconsole_send_resize(VirtIOSerialPort *port)
+{
+    uint16_t cols, rows;
+    VirtConsole *vcon = VIRTIO_CONSOLE(port);
+
+    /*
+     * We probably shouldn't send these messages before
+     * we told the guest it is a console port (which we do
+     * by sending VIRTIO_CONSOLE_CONSOLE_PORT message).
+     * Instead of adding a new field to the device state
+     * lets just use the guest_connected field for that purpose
+     * since the guest should not care about the terminal size
+     * before opening the port.
+     */
+    if (!port->guest_connected) {
+        return;
+    }
+
+    qemu_chr_fe_get_winsize(&vcon->chr, &cols, &rows);
+
+    if (cols != vcon->cols || rows != vcon->rows) {
+        vcon->cols = cols;
+        vcon->rows = rows;
+        virtio_serial_send_console_resize(port, cols, rows);
+    }
+}
+
 /* Callback function that's called when the guest opens/closes the port */
 static void set_guest_connected(VirtIOSerialPort *port, int guest_connected)
 {
@@ -114,7 +142,9 @@ static void set_guest_connected(VirtIOSerialPort *port, int guest_connected)
     DeviceState *dev = DEVICE(port);
     VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
 
-    if (!k->is_console) {
+    if (k->is_console) {
+        virtconsole_send_resize(port);
+    } else {
         qemu_chr_fe_set_open(&vcon->chr, guest_connected);
     }
 
@@ -174,6 +204,23 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+static void chr_event_console(void *opaque, QEMUChrEvent event)
+{
+    VirtConsole *vcon = opaque;
+    VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(vcon);
+
+    trace_virtio_console_chr_event(port->id, event);
+    switch (event) {
+    case CHR_EVENT_OPENED:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_RESIZE:
+        virtconsole_send_resize(port);
+        break;
+    default:
+        break;
+    }
+}
+
 static int chr_be_change(void *opaque)
 {
     VirtConsole *vcon = opaque;
@@ -182,7 +229,9 @@ static int chr_be_change(void *opaque)
 
     if (k->is_console) {
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                 NULL, chr_be_change, vcon, NULL, true);
+                                 chr_event_console, chr_be_change,
+                                 vcon, NULL, true);
+        virtconsole_send_resize(port);
     } else {
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
                                  chr_event, chr_be_change, vcon, NULL, false);
@@ -210,7 +259,7 @@ static void virtconsole_enable_backend(VirtIOSerialPort *port, bool enable)
         VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
 
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                 k->is_console ? NULL : chr_event,
+                                 k->is_console ? chr_event_console : chr_event,
                                  chr_be_change, vcon, NULL, false);
     } else {
         qemu_chr_fe_set_handlers(&vcon->chr, NULL, NULL, NULL,
@@ -230,6 +279,11 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (k->is_console) {
+        vcon->cols = (uint16_t) -1;
+        vcon->rows = (uint16_t) -1;
+    }
+
     if (qemu_chr_fe_backend_connected(&vcon->chr)) {
         /*
          * For consoles we don't block guest data transfer just
@@ -242,7 +296,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
          */
         if (k->is_console) {
             qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                     NULL, chr_be_change,
+                                     chr_event_console, chr_be_change,
                                      vcon, NULL, true);
             virtio_serial_open(port);
         } else {

-- 
2.51.0


