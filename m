Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE01D4A5EB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfx9-00076G-1Q; Sun, 18 Jan 2026 22:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwm-000746-0q
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:59 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwf-0004Bt-VS
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:53 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64b9dfc146fso6702586a12.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793327; x=1769398127; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+hcIvsm19O7NRhgdd4H1QI2pcN+x2HRYIcp2/OHgPhA=;
 b=YalZzgSVtR6eMEglLrZP/RAWtXjkqj3u87EajPn93A6ylO/KCvgjinHK6W0b1nhTt3
 pj2QgCggSToBHNKaBwUBjERJ/IzPAUZGWwnfoy1Lwdmw+rscDKT+cimoAgSvKGsy2gLw
 L+WfetKvbAupwEaiec6MeyqOY0GpZ6qEol7iufS4yXacUIY58FHrTlFglRWwWMI9tGCz
 vEqm2p8yMfKjDEwTjU+cKFgyAMdaPKXX9X22IxFZOnEN3Hgf0K3KDmG78Qn5yq2fL9az
 KEmzaw3o88+h1HwZtKLhogQTsFmwqxrwifOTWV6BMnyugdqV54J2eJBLpJ8EK2nP6Gwg
 p/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793327; x=1769398127;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+hcIvsm19O7NRhgdd4H1QI2pcN+x2HRYIcp2/OHgPhA=;
 b=twWfG7eNktJrSd2JEv0PuLDhuVIEyMmqWOADh4lMg8aVQIJbMtBbxM5wpJTnv7OUAg
 9/jRC5EXTj3aiufsR4CvwgG9JCP25N/w6KU6nao21/HOunR7wDu+xZyeFmftOc7z3Eaq
 b4Vz4D83KaZOUcT0TSVaEJOfrbMOkVOvSrHraIX7+bl7xPJmxUoEd7jOUCCGoTJfRISg
 C/fx6RAeuRsyVXUo67g+EXlDXGYg4S5DYuw+w3Q3j7mdSvvcWu+nrhNFO7ZO+oBIS0Or
 f2Fp+VibZ/cIMmzkAQBsyUW5OTBGc9lKrltnZz9xjePXSwUcV15/ZdpoUEaVA6PHPf2E
 2oSg==
X-Gm-Message-State: AOJu0Yy0RgrUGeWuHNtKCEkDpoCYmixbHJGVpPrPsZgZIvjd0OI7XOQh
 AW8ts7FPcSopYDt3ojc8NSwlo6LaolBvbiz7r0x32pMHhDKOQwIUlGaB
X-Gm-Gg: AY/fxX5JMI1R8trzl1gtsSlJ20ThqF7jxhuyXqnjjMnXrtTvutUdh/Dh3KvHpUe/znU
 ZBbTIEMWEHB4pkJsqqlFXC34BsDmcdgZnNCwcON9Pw0N3YSKBO5LoKi/31z8l+IrdDDAgP19CjD
 ACjMNHOX7d5dKvNW3THoYMmbv4YM+Xqw4bTbVYPAEVtdv7l4jMakgcIXm8jsWxHts6WVk1WHQQB
 Jq8d+zMEz6DJWfMfK8oCK3koBiwVL3Bhq8vbMcAqCelv/Itp+syfbrOBsv5T9aShkiHwQ0Cc5QN
 YrHinSAjSiRPAzb9/UsktMkRLGcLHCdFrqQeG8w1mmvunJvSh0K3Vk+D23JuBPglz4l7BMpouFI
 UNLsoCHjL9b9wQ0R6TocCeg3q++Kn4Ca/E5z1qZi9dtnswhNPAuHmGPwme6XLKs8w2OBE0BbS84
 NgusNSG4d3USLlResCQJF51TglLqCWPH8JE00sq1Cw
X-Received: by 2002:a05:6402:95a:b0:640:abb1:5eff with SMTP id
 4fb4d7f45d1cf-65412f26c76mr8453512a12.8.1768793326860; 
 Sun, 18 Jan 2026 19:28:46 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c52afsm9076235a12.33.2026.01.18.19.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:46 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:52 +0100
Subject: [PATCH v6 09/12] virtio-console: notify the guest about terminal
 resizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-console-resize-v6-9-33a7b0330a7a@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
In-Reply-To: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
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
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=3302;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=ZzKneST3CEGU8zC4XP2YPWswsNvk2tWadVWgPvDK+sY=;
 b=36RE9gnmbO/S8PNNGtEK8UNYWq4fTaJC5IDAS1yrJ7bt1wAtbEQUVwzEnOp2RwVIGh8QLEIWi
 e6mmdu6MUZ3BqWGZgsYNIsX0I0KRgBtsmVNseHNtMbWuCrxKprymm/F
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ed1-x533.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
[Filip: rename things, remove logic that is now handled in virtio-serial-bus.c]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 hw/char/virtio-console.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index dcfe5830f9..de7979c2d3 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -107,6 +107,15 @@ static ssize_t flush_buf(VirtIOSerialPort *port,
     return ret;
 }
 
+static void virtconsole_update_size(VirtIOSerialPort *port)
+{
+    uint16_t cols, rows;
+    VirtConsole *vcon = VIRTIO_CONSOLE(port);
+
+    qemu_chr_fe_get_winsize(&vcon->chr, &cols, &rows);
+    virtio_serial_resize_console(port, cols, rows);
+}
+
 /* Callback function that's called when the guest opens/closes the port */
 static void set_guest_connected(VirtIOSerialPort *port, int guest_connected)
 {
@@ -174,6 +183,23 @@ static void chr_event(void *opaque, QEMUChrEvent event)
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
+        virtconsole_update_size(port);
+        break;
+    default:
+        break;
+    }
+}
+
 static int chr_be_change(void *opaque)
 {
     VirtConsole *vcon = opaque;
@@ -182,7 +208,9 @@ static int chr_be_change(void *opaque)
 
     if (k->is_console) {
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                 NULL, chr_be_change, vcon, NULL, true);
+                                 chr_event_console, chr_be_change,
+                                 vcon, NULL, true);
+        virtconsole_update_size(port);
     } else {
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
                                  chr_event, chr_be_change, vcon, NULL, false);
@@ -210,7 +238,7 @@ static void virtconsole_enable_backend(VirtIOSerialPort *port, bool enable)
         VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
 
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                 k->is_console ? NULL : chr_event,
+                                 k->is_console ? chr_event_console : chr_event,
                                  chr_be_change, vcon, NULL, false);
     } else {
         qemu_chr_fe_set_handlers(&vcon->chr, NULL, NULL, NULL,
@@ -242,7 +270,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
          */
         if (k->is_console) {
             qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                     NULL, chr_be_change,
+                                     chr_event_console, chr_be_change,
                                      vcon, NULL, true);
             virtio_serial_open(port);
         } else {

-- 
2.52.0


