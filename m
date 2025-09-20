Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD71CAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07Hk-00051c-NG; Sat, 20 Sep 2025 19:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07Hb-0004z2-QC
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:24 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HW-0006gO-Mo
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so1312304f8f.0
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411977; x=1759016777; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5RfNA/UI6597mJEnJ8Hzb+uK6nQOg41kNO772K4Zofc=;
 b=FyxoBdeJ1kKg+/Y7qElTkOKk7s7y3AFM/+vVn1K1SyEUk0vqpJftk6kz9AC+wdys6c
 Xgg2+b5W6aIYwXBmcLtIxNfHQt2FlXZxJMF+RidVrUefk7hxBh6Sv3a+LLfrmBW/zkfD
 KHHMoCYwI2iaUNdRbPn1Ol9jaH/0iwTNZvT6mqUnDHqPJMi6T6lGwQISDW/0jvBj7B2Q
 DbdgcFiB1uw7QXkWpV4ZSnQbDRIzM8OrdHO/o8gEC6scNd/Ax/cM/pHjfynIC3Vv8Sfp
 /HXmUJ4cfHvgS3D8DcWiGXos5+hTuv7plsm5rHA7wJrhm3WpLqClNp7EX6VTaK8wFXl9
 QqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411977; x=1759016777;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RfNA/UI6597mJEnJ8Hzb+uK6nQOg41kNO772K4Zofc=;
 b=PJJ2ZQ6L+FazLGl6Vb8W2+yAoLsLZqX9zXCam/kKovX5GPogWHgiG7uJ9K8GhrsbVS
 G8JqeUPzyqjSNyxWkdXV36Uvn8vHdZmCsjgAHrWy1peoPkhRfuvFwOmFg+hYm59vHuVU
 7tT3NN7qhQ8YZ6JuGWRfgMAY3vGW9QB3vjeHuzYSif6HKsIRCuK1lI80fhJcPVeCodMX
 J1naZACONKykuO4hfu9U4p6LPT5esnUlEw2NRzMm657snQ6P17ttTFaYqU0C3nkLK5Fa
 PCjMZIum6W4a76cjBacOraBHkgIz9Ab8r/Eud7jFar3s6Vsu9+0N5w64nikpAuEPjuCx
 BOBg==
X-Gm-Message-State: AOJu0YyqzH1FHOow85baDSVKlS/00pCMZevaq/irbhXw+syDVqzgb6p6
 8rcJ/iMIsUoglZZJvnWNkeSp3eP7TqUM1Td4HBl4uc5hEQAIgkl0zm9X
X-Gm-Gg: ASbGnct2RzNrDHR5lwTots2pzlrLy0wJkUOibmbzAIgwTzFyS0u3TWYzt58olsqj7ui
 bg6oYe77t+C04rsRjaBZb9sYTLlVw/DcvErX73r6dYUbxNIP+OkwSOtmRuzegSr4nhhsZK5NEjm
 /ZkNVIQH2vO/jYnZSFrskszRT0sEecZ+4LMJChvVBQGNWQ5htcW65BS0BJjgmqEKaNeWFAXkTRk
 2CFsve0r9t2vC+60k2W56oK2+RfYyErnr/FK48REHhKzUDnDODC2otyeeW7dD7Qak1hPf6I7Db7
 /cCgVeGlBAjSduur5mLZYyVaI/nvJM3kiQCuJwYQR3Svo3Co6DVCNJwtiQMzR8NCGIDW/z5R4YG
 2+sRLKWeeeYmICFsqKeHQ6OG9VTB6oDFbAkmdIRISIVGxFh12/rBb
X-Google-Smtp-Source: AGHT+IEg4Fy1OBZANbhoyldjahl+nTt08RPbUe98GGBCX+f9/a+qqu0wfFlbbY0lEovxM1fl837oIg==
X-Received: by 2002:a05:6000:18a8:b0:3e8:e7a6:e5a9 with SMTP id
 ffacd0b85a97d-3ee85769a82mr7196935f8f.48.1758411976948; 
 Sat, 20 Sep 2025 16:46:16 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3ee073f3d73sm13523246f8f.8.2025.09.20.16.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:16 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:39 +0200
Subject: [PATCH RFC v5 09/12] virtio-console: notify the guest about
 terminal resizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-console-resize-v5-9-89e3c6727060@gmail.com>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
In-Reply-To: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=4792;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=Nk20ENwwWckhS03qIIV6kRhTJeXoM/V/o9wpxze5Xow=;
 b=mpPFEQQu1AwEPkyN6AwBqep9IiNDQ1LWGKTg/Lhe+s3qV2X7XA3LJ6v5Fak3iSLj/oWbVpbbK
 eF8mqlsUW3ADInZhODHXM6WfIK9oyu5wqbO5U1mgSk6FYrG5mUSkZED
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42c.google.com
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

If a virtio serial port is a console port, forward terminal resize
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


