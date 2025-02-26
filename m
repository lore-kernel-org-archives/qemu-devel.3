Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34926C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCKG-0007Qv-0g; Wed, 26 Feb 2025 02:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCKD-0007N4-Rz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:25 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCKC-0007h0-0f
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:25 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-abbdc4a0b5aso116850266b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740556762; x=1741161562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zN68A3m1xFZRBA4Wy0sLe9nvVRbka+7jawUW1pKYdX0=;
 b=mb+Lc8pP9QiB/I/lCIje0dor1HXI/I2LsOt+x9cXS+GRbdSYJNvKaNKua7OXsF0xOm
 aqIdV24DbTuU3BjdbJGbt4OIUOyYK74sHelfxW8LX5Z3rVueZZ7p7bQ4t47rm5HoAnzM
 9CuBS1VNiPhpwYwyK+7O3OVbwociJsB5aWgGLgHpV8nGHO6LYH4lIl/iH9EQt3BFqARP
 zQBufNmoRItCZk7ffJADyDS+8LZXMXTYnw4ob5nUwAwa8oOPMC0mnkRZ7nlSA1vGthqq
 kT5UVwjvDWfipVUNkTvfLITMp6IYxzEAX9usHp0ommD+Bz0SAgH887P7UuZVa6Nerqsa
 QOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740556762; x=1741161562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zN68A3m1xFZRBA4Wy0sLe9nvVRbka+7jawUW1pKYdX0=;
 b=E9kG28w2+w8gD3VlEt1N61n7iv0z0BZ7TSR4U8UHInnT06ILM/Z0jeZGIFuxpVpczs
 gsXvHTNSodoXxn1ug3kwicHRj5owqufsANCpD9D+8qbf1ue6yv0/XB+DfGTzplz1n58T
 oiUqLHHkpZ8Jz1qOBnNvReM1cH8G4oZ8yErPghWd93yB2Q+HNHcoE8qjZJNMSu2JbDry
 nJyEzn9yOMFy0NFtXkmNcftS8tSN5QS8nHPOm7ThNi45e8HzzAZbca6ipOcOPOtOGUK0
 wrL31OR5jVKUAFLekUIfQWMPpjTMjVzHYbuAEX+pZv3lkkIteUjZUvDrNK2HyjF+7S7f
 TLwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb2BVCWvhR1lyHDE5PXZ769AR0MnajzZxjx/B+r6l1EXzRxyX9xxQowVtYs7X79g3voiJYGm6I2yn+@nongnu.org
X-Gm-Message-State: AOJu0YyOhCNAbYUhEyDQpY03oX7RFC4dJMqfeU4dmmqrFqZGi81fRVYT
 jyDywkH1FAcSn4wSrwXZ/7bVDblKIF3H9Jop8LMeWrC6fMyGcR00
X-Gm-Gg: ASbGncvb90SzdpTMMzv5a+HPgg6IEl0csFSlOgxwU4ZN7HMVnehdop/ijquzINP8WK6
 DfUoR9nQ4Y5ihqI/zuobNCqf9PC71yPo4Dde+rOXKaHFdfD+4N4e6044iogxdCRL3qk3bgzBFeB
 LoKEqKd9Oa41667/ba8RVIEGdiDc5r4kKg8Ap5lbckYeOVat26kKykSVCT/cDVGy7iDADIn2JjN
 +Ycn4DTrPc+gYyABAzFBF2STQxFUaEpGr2y+y2o+1mu7x0py4EkcZpHFNu0gLBhLLSErdF0fWAY
 ZCb2zRYAXPFq2DJcNwSlhntWPJVmBRX111s=
X-Google-Smtp-Source: AGHT+IG+PcTx2bjs3mr38WTm8CepdGFQI+yeyx9p4zbFCrUdjHnpkDj+Ezj7uh4E/ZAQKixRlA08Aw==
X-Received: by 2002:a17:907:180a:b0:abb:b533:3e82 with SMTP id
 a640c23a62f3a-abbeded95ccmr2142470266b.20.1740556762016; 
 Tue, 25 Feb 2025 23:59:22 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:c48e:2efa:cdfc:e268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2013355sm280107866b.113.2025.02.25.23.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 23:59:21 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] ui/console-vc: add support for cursor DECSC and DECRC
 commands
Date: Wed, 26 Feb 2025 08:59:10 +0100
Message-ID: <20250226075913.353676-5-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226075913.353676-1-r.peniaev@gmail.com>
References: <20250226075913.353676-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62d.google.com
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

There are aliases for save and restore cursor commands:

* save cursor
    `ESC 7`     (DEC Save Cursor [1], older VT100)
    `ESC [ s`   (CSI Save Cursor, standard ANSI)

* load cursor
    `ESC 8`     (DEC Restore Cursor [2], older VT100)
    `ESC [ u`   (CSI Restore Cursor, standard ANSI)

This change introduces older DEC sequencies for compatibility with
some scripts (for example [3]) and tools.

This change also adds saving and restoring of character attributes,
which is according to the VT spec [1][2]

[1] https://vt100.net/docs/vt510-rm/DECSC.html
[2] https://vt100.net/docs/vt510-rm/DECRC.html
[3] https://wiki.archlinux.org/title/Working_with_the_serial_console#Resizing_a_terminal

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 ui/console-vc.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 87f57f1c52c6..522adc2806c8 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -90,6 +90,7 @@ struct VCChardev {
     int esc_params[MAX_ESC_PARAMS];
     int nb_esc_params;
     TextAttributes t_attrib; /* currently active text attributes */
+    TextAttributes t_attrib_saved;
     int x_saved, y_saved;
 };
 typedef struct VCChardev VCChardev;
@@ -644,6 +645,31 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
     s->y = y;
 }
 
+/**
+ * vc_save_cursor() - saves cursor position and character attributes.
+ */
+static void vc_save_cursor(VCChardev *vc)
+{
+    QemuTextConsole *s = vc->console;
+
+    vc->x_saved = s->x;
+    vc->y_saved = s->y;
+    vc->t_attrib_saved = vc->t_attrib;
+}
+
+/**
+ * vc_restore_cursor() - restores cursor position and character
+ * attributes from saved state.
+ */
+static void vc_restore_cursor(VCChardev *vc)
+{
+    QemuTextConsole *s = vc->console;
+
+    s->x = vc->x_saved;
+    s->y = vc->y_saved;
+    vc->t_attrib = vc->t_attrib_saved;
+}
+
 static void vc_putchar(VCChardev *vc, int ch)
 {
     QemuTextConsole *s = vc->console;
@@ -699,6 +725,12 @@ static void vc_putchar(VCChardev *vc, int ch)
             vc->state = TTY_STATE_G0;
         } else if (ch == ')') {
             vc->state = TTY_STATE_G1;
+        } else if (ch == '7') {
+            vc_save_cursor(vc);
+            vc->state = TTY_STATE_NORM;
+        } else if (ch == '8') {
+            vc_restore_cursor(vc);
+            vc->state = TTY_STATE_NORM;
         } else {
             vc->state = TTY_STATE_NORM;
         }
@@ -833,14 +865,10 @@ static void vc_putchar(VCChardev *vc, int ch)
                 }
                 break;
             case 's':
-                /* save cursor position */
-                vc->x_saved = s->x;
-                vc->y_saved = s->y;
+                vc_save_cursor(vc);
                 break;
             case 'u':
-                /* restore cursor position */
-                s->x = vc->x_saved;
-                s->y = vc->y_saved;
+                vc_restore_cursor(vc);
                 break;
             default:
                 trace_console_putchar_unhandled(ch);
-- 
2.43.0


