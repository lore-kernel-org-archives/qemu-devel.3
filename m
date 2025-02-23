Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BDFC021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 14:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmDNJ-0007r1-24; Sun, 23 Feb 2025 09:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDNA-0007p3-Go
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:25 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDN7-0007e3-5L
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:23 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dec817f453so5934209a12.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 06:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740322459; x=1740927259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zN68A3m1xFZRBA4Wy0sLe9nvVRbka+7jawUW1pKYdX0=;
 b=MLZhqjw5ou7fc4Uh67QEIytHbBaBBjm82EaSm/R7xFMaEFNtD/hMlO0MSscYkVEE/5
 07+ICkMRGBoa25fhR9WLOwAwyVb+fUW41RFFZTtJdIfy0A1loxk1pSPKLhfq/1/wNccW
 GQnxx6FTHI4bO6A8XVw2VdIr6wI4fxpnLodU5QYNMD1mw7NtH1F+xlTtvoW0yxBm1YFY
 79MjlSyulZgLUGPz5wkx+fg5yp2YoOYLu+uIKdqhyeHYrZnnCVSH52qGA/YOn52ZAS/5
 C2BazySfx1yZEcuTMuQQOlIaCGdVQUSd7Ud5RzvFjAPwq3/k1e/MwrBbKcKPoBQl7hM2
 aq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740322459; x=1740927259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zN68A3m1xFZRBA4Wy0sLe9nvVRbka+7jawUW1pKYdX0=;
 b=R8f9lFpAhRQKA4NeR3DARMdApw2Yj+Ti6EgUgMW0Tq+Qs3HJY9IGXICreBpaGVxz36
 cFdhyoeCCIF/ReQbEOwm/ZzyuiXIlFv+37w2RgjIVanZp45vRiVSqLhuaacMBdJjFddk
 bvUMoWQ+WsbPniTcOw7bImp8woex8w2ZZL/PVu865OHw7w2HXOGmuyhlbXZ9EkPF5ZS0
 XnTMeQV3nWojRuhLnIB+OPwObdFIykmqTjBriDrN3f8IUDnXmQXsgixJBjLfvuIcdFUO
 b2X8gOOmzUAT83giSB83kjP6GUtbI5XnkVZVkg7MRJuixBKDhNKNDpitzS3AAba1B2VB
 12Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOnYgf0cIupF42xJnD9iv4fxUD6KS0OL+JmeemYZduMvOQYCATzqK26xG/Hzgh2CIvgfVYXaft3eH1@nongnu.org
X-Gm-Message-State: AOJu0Yy4+OixXCD82DoZBuZ2BDg8GTgqs/3xRLz4Z257T12hfbpWISrP
 yr2xjY3aOX5IFyPqnaKrCl9ZmOqpOC0og6RaXBemYJxTRn9SSBLzaV+B3A==
X-Gm-Gg: ASbGncvw0jgz3p+jn2e6yYwvy8Q6pqWOV1o/DMM15sp5Igd3YFsFcMLHit6+FOshZnJ
 qHRzJJGQtFQXjjNBotzPCduIpCSnNZSjIepCllsc1zztbF+s+gLa5sFLG4c5a2zlBMMcCRJueZm
 YKnfmh2ebzL5AD9D8VTmVOT75hlHtGT+7I4PElcnmR7LqUs7tGpKwiJuJHSGmQ3J0AUThWhugin
 NUqw4PU78VSTeEmAnFDJvkwl1/+AHHqhqvKAtT1bdC6CWzkP2FTomrqlZO483KelUn9rn/gY3w6
 Lb6vIYSwv9g8ptjD/8c4HsfNiRyWSx+RoeM=
X-Google-Smtp-Source: AGHT+IEhb3P5TISi4jM0t2IF26KxuQA8/p+hDBNHm+mOujRQg3Cvb0SFOO+wwuXJ4WvQ7csUffnCFw==
X-Received: by 2002:a05:6402:3488:b0:5e0:51a9:d425 with SMTP id
 4fb4d7f45d1cf-5e0b724ecfcmr9455896a12.29.1740322459390; 
 Sun, 23 Feb 2025 06:54:19 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:1283:abda:b08f:72e4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e0a0310f66sm6431580a12.81.2025.02.23.06.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 06:54:18 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 4/5] ui/console-vc: add support for cursor DECSC and DECRC
 commands
Date: Sun, 23 Feb 2025 15:54:01 +0100
Message-ID: <20250223145407.259924-5-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223145407.259924-1-r.peniaev@gmail.com>
References: <20250223145407.259924-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x529.google.com
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


