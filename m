Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCEAC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCKL-0007So-Bh; Wed, 26 Feb 2025 02:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCKE-0007QC-Vx
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:27 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCKC-0007hQ-MZ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:26 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abbdc4a0b5aso116855866b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740556763; x=1741161563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R99e/0pJ92SgYpcF19F0TSmaPaY9J1HBgHMMR0nIINY=;
 b=Y7DcZ2okuCfSmIoUNNP5+g8o/eQP/sxyyuc+duwdBbGviepC9iBOx1u6mWoQWPAST3
 tRRlRMvuWO6ykeRo3Acrotx6fNNjzKj7Shq6IAWy9Q0O0eCkbMLoCQqdzajEfhhka6id
 qALwRj/vGba5VrrqwWJgl2Hk9Vk3IeHWWmQY1KTkiPN0wp4dBShHPeKHhGQwRUtQjrnL
 cJmcjHKreVLZ4mzKG/EJ0zpB6O3jvrEuwQR8b9uYWMLd+l/yaKpv8jo/+CjsT5tE6auB
 NL6fceM417Y0h3+/AW5kFgiYGOwK+BjCZPdnNmaAYwnSTg1bIJcFw6vqH6ugNQTCbG6M
 +HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740556763; x=1741161563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R99e/0pJ92SgYpcF19F0TSmaPaY9J1HBgHMMR0nIINY=;
 b=O+Bn3c8Nf6QOqHtFbsHo32wc6tlGhTCXsEopuXEo/ZZQSPb8Yw2IoKib73UkaOAek8
 GnNPjtFi7jusMTer8sySCzPwr3pWHkF4YKAjaeS1Iwt0Qlkdk1M4ZBE1zc8IlDm54o6l
 EbL2fAOSy5qZNIMkUFXBKiO/OgRKy/R2seN7Jb104QauPGsVHeqWqQeEEGXl9LKc+CF7
 XlbCC/w4VpLgvZs84Ur8ySCkUnNSp9vxzYnQncsi8BSgCUBxCHgaGQYv42BYc6uoO7Nq
 QVlJkI2j6xtn2srpbUy7I/HcfL1QjwMLSsxN2eulXB7i46XaSLPxuU0X8DWq8czJYep4
 drrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXydyKUMVkfsIvNM6KdqNyykSRm/pNTJPN3IJyLvwjaRi05nK17pmYxkSbYAkOTv0nYGu8KGEmiA6kI@nongnu.org
X-Gm-Message-State: AOJu0YzQPfzjCyjTRzeLkVtJulXcZJAoCHLmi/SEbxk7sBa+GjVaQIFe
 jEX2VzYJQbdVG5MQf41Ebu4Us0Wc//unxrQFBM1bW3MwT6y2DlMX
X-Gm-Gg: ASbGncscsh58ayaU8AeOuYTi64kPIcHWoitvIwCgcopXZx3ADxqAloIOC+fI9J3WF/+
 gObCNmnbT6OsgZl9U89D+whYV+Bgah0kk0RUxG4PmgkCHrAM3CJDch8AA1XANsI5CougVJoxGIp
 6Nh8fSefQLrUda+9Y6+pjO0+QZx5e4TwyDvc0iBJY1QtjVCmJtAba1ge54uX4nRRQBGji/uzz3X
 u6JIBY50gYc4+pfCsHrkV4ltkOhMWAOHwzvnCkRrhmIw0K0melO7Prd9uonQQhxgW2Lt08AN9jy
 1mGXZdibcq9AJo26AGwX7KxBFiu1MJTvZVc=
X-Google-Smtp-Source: AGHT+IGFM1FIUi1Mfo5FjPwx5/l20abT9mdE3Xj6ZBiiN78gN6+yTivz+AwJ6T4K6//mlczr2Z/EBA==
X-Received: by 2002:a17:907:8b96:b0:abb:ebf8:72d9 with SMTP id
 a640c23a62f3a-abbeddc91a6mr2767081666b.15.1740556763177; 
 Tue, 25 Feb 2025 23:59:23 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:c48e:2efa:cdfc:e268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2013355sm280107866b.113.2025.02.25.23.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 23:59:22 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] ui/console-vc: implement DCH (delete) and ICH (insert)
 commands
Date: Wed, 26 Feb 2025 08:59:11 +0100
Message-ID: <20250226075913.353676-6-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226075913.353676-1-r.peniaev@gmail.com>
References: <20250226075913.353676-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62c.google.com
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

This patch implements DCH (delete character) and ICH (insert
character) commands.

DCH - Delete Character:
   "As characters are deleted, the remaining characters between the
    cursor and right margin move to the left. Character attributes move
    with the characters. The terminal adds blank spaces with no visual
    character attributes at the right margin. DCH has no effect outside
    the scrolling margins" [1].

ICH - Insert Character:
   "The ICH sequence inserts Pn blank characters with the normal
    character attribute. The cursor remains at the beginning of the
    blank characters. Text between the cursor and right margin moves to
    the right. Characters scrolled past the right margin are lost. ICH
    has no effect outside the scrolling margins" [2].

Without these commands console is barely usable.

[1] https://vt100.net/docs/vt510-rm/DCH.html
[1] https://vt100.net/docs/vt510-rm/ICH.html

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 ui/console-vc.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 522adc2806c8..df1341513d53 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -645,6 +645,88 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
     s->y = y;
 }
 
+/**
+ * vc_csi_P() - (DCH) deletes one or more characters from the cursor
+ * position to the right. As characters are deleted, the remaining
+ * characters between the cursor and right margin move to the
+ * left. Character attributes move with the characters.
+ */
+static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
+{
+    QemuTextConsole *s = vc->console;
+    TextCell *c1, *c2;
+    unsigned int x1, x2, y;
+    unsigned int end, len;
+
+    if (!nr) {
+        nr = 1;
+    }
+    if (nr > s->width - s->x) {
+        nr = s->width - s->x;
+        if (!nr) {
+            return;
+        }
+    }
+
+    x1 = s->x;
+    x2 = s->x + nr;
+    len = s->width - x2;
+    if (len) {
+        y = (s->y_base + s->y) % s->total_height;
+        c1 = &s->cells[y * s->width + x1];
+        c2 = &s->cells[y * s->width + x2];
+        memmove(c1, c2, len * sizeof(*c1));
+        for (end = x1 + len; x1 < end; x1++) {
+            vc_update_xy(vc, x1, s->y);
+        }
+    }
+    /* Clear the rest */
+    for (; x1 < s->width; x1++) {
+        vc_clear_xy(vc, x1, s->y);
+    }
+}
+
+/**
+ * vc_csi_at() - (ICH) inserts `nr` blank characters with the default
+ * character attribute. The cursor remains at the beginning of the
+ * blank characters. Text between the cursor and right margin moves to
+ * the right. Characters scrolled past the right margin are lost.
+ */
+static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
+{
+    QemuTextConsole *s = vc->console;
+    TextCell *c1, *c2;
+    unsigned int x1, x2, y;
+    unsigned int end, len;
+
+    if (!nr) {
+        nr = 1;
+    }
+    if (nr > s->width - s->x) {
+        nr = s->width - s->x;
+        if (!nr) {
+            return;
+        }
+    }
+
+    x1 = s->x + nr;
+    x2 = s->x;
+    len = s->width - x1;
+    if (len) {
+        y = (s->y_base + s->y) % s->total_height;
+        c1 = &s->cells[y * s->width + x1];
+        c2 = &s->cells[y * s->width + x2];
+        memmove(c1, c2, len * sizeof(*c1));
+        for (end = x1 + len; x1 < end; x1++) {
+            vc_update_xy(vc, x1, s->y);
+        }
+    }
+    /* Insert blanks */
+    for (x1 = s->x; x1 < s->x + nr; x1++) {
+        vc_clear_xy(vc, x1, s->y);
+    }
+}
+
 /**
  * vc_save_cursor() - saves cursor position and character attributes.
  */
@@ -847,6 +929,9 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 }
                 break;
+            case 'P':
+                vc_csi_P(vc, vc->esc_params[0]);
+                break;
             case 'm':
                 vc_handle_escape(vc);
                 break;
@@ -870,6 +955,9 @@ static void vc_putchar(VCChardev *vc, int ch)
             case 'u':
                 vc_restore_cursor(vc);
                 break;
+            case '@':
+                vc_csi_at(vc, vc->esc_params[0]);
+                break;
             default:
                 trace_console_putchar_unhandled(ch);
                 break;
-- 
2.43.0


