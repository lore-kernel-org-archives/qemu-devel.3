Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8707BD1624B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JUc-0006el-KF; Mon, 14 Oct 2024 07:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUW-0006cp-O0
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:44:00 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUU-00057C-Q2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:44:00 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a0084f703so217664066b.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728906229; x=1729511029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D9lTfUtZ9ffHIdlW/Te4mim8Q2HJoGfSrfyIQQdPKJM=;
 b=NzgsyX5dLUwYCmcYw2E0Q1WeBN+earf08JAvjmYtsH/zRH9rxdNuHgs3w2AHaX1fYD
 8YS77X7LYKu7fq+lGvDbbunxKjo4uXXMvd+Q7/anT2BBIPSaXuj7WA3eoypFHNjxkw/l
 p6Iqvh4dEPPJHY+6jtMVZALrPcUJkCkKD9Zza0AosXniTxF+V9v+LzWm86jsSJ1Ew9wS
 eMRC/2Ucl3G3CVoqPVO2CiRGlqZRmZ1y7sqSEdLoFhAIrt5cw6UXsRo6iay1fEy9j+0M
 TGx1DkiCvyf8fdUC3+eOQrQOnTQD5ODxmurhXojja46K00uYQZpwnqMEjyHr49g2jwVy
 YKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728906229; x=1729511029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D9lTfUtZ9ffHIdlW/Te4mim8Q2HJoGfSrfyIQQdPKJM=;
 b=FDuhLTvy9N8zCTf1m2YAPmJ14o9O9+plpkSAheJcRHHL/L1WwuUiJ3A7fZk155ZL17
 Lg0DccuEn86lojOgLZHfScdlRQP6d+7ELzwUXarokcodY70WHMsist/d1s3xnrA7SVw4
 u80dTJW7SxAlq4e7NgSu2LLP0EWhbRnhy7aNa0XZ2SzhaDfSlsnytlK+4MRIroA4gd6A
 xBDctklYUQgrjInlkS8iT7nJPsezb74IDrZLMNH13cZgRbU3Li8MtKecjSiRGm3RQXsQ
 XqEkdIXA88YLiQL9alipBymUWKwcRALyNJZZjdYwgEWm4tDg1uRFIoSO+TIOw8rYAUSs
 UlIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsDOpAyne6vK4JTdcKTss3OQeYYOzmTJCjLRcdme4jdwo1qFK1/skJlW5uC/mwRENGIbA4F7LJJ+Jc@nongnu.org
X-Gm-Message-State: AOJu0Yy3QYTLEtdS7SBEINmClTtqGUd9lv1cnBYhrEtIG3obLMKB2zv+
 JMm8RU3nJHdgYxUpXAd77kuSNf3qZGhyF5lsonoVBzwirzHvf2AZ
X-Google-Smtp-Source: AGHT+IFEIsY2OzlhWBWtNgrzm2vSr4x+7qG2KiOu5J+IHU7lw77MndlM5b+23i7vlASUXfEAuq6pEw==
X-Received: by 2002:a17:907:6e89:b0:a9a:6d7:9c4 with SMTP id
 a640c23a62f3a-a9a06d70be9mr398799066b.12.1728906228690; 
 Mon, 14 Oct 2024 04:43:48 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99fcb2765asm247764666b.64.2024.10.14.04.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:43:47 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 5/8] chardev/mux: introduce `mux_chr_attach_frontend() call
Date: Mon, 14 Oct 2024 13:41:32 +0200
Message-Id: <20241014114135.389766-6-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014114135.389766-1-r.peniaev@gmail.com>
References: <20241014114135.389766-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x631.google.com
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

Move away logic which attaches frontend device to a mux
from `char-fe.c` to actual `char-mux.c` implementation
and make it a separate function.

No logic changes are made.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |  9 +--------
 chardev/char-mux.c         | 17 +++++++++++++++++
 chardev/chardev-internal.h |  2 ++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 69b47d16bdfa..3b8771ca2ac4 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -197,16 +197,9 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
         if (CHARDEV_IS_MUX(s)) {
             MuxChardev *d = MUX_CHARDEV(s);
 
-            if (d->mux_cnt >= MAX_MUX) {
-                error_setg(errp,
-                           "too many uses of multiplexed chardev '%s'"
-                           " (maximum is " stringify(MAX_MUX) ")",
-                           s->label);
+            if (!mux_chr_attach_frontend(d, b, &tag, errp)) {
                 return false;
             }
-
-            d->backends[d->mux_cnt] = b;
-            tag = d->mux_cnt++;
         } else if (s->be) {
             error_setg(errp, "chardev '%s' is already in use", s->label);
             return false;
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index b2d7abf2fc01..9294f955462e 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -301,6 +301,23 @@ static void mux_chr_update_read_handlers(Chardev *chr)
                                   chr->gcontext, true, false);
 }
 
+bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
+                             unsigned int *tag, Error **errp)
+{
+    if (d->mux_cnt >= MAX_MUX) {
+        error_setg(errp,
+                   "too many uses of multiplexed chardev '%s'"
+                   " (maximum is " stringify(MAX_MUX) ")",
+                   d->parent.label);
+        return false;
+    }
+
+    d->backends[d->mux_cnt] = b;
+    *tag = d->mux_cnt++;
+
+    return true;
+}
+
 void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index ab93f6ea1720..8126ce180690 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -59,6 +59,8 @@ DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
 #define CHARDEV_IS_MUX(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
 
+bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
+                             unsigned int *tag, Error **errp);
 void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
-- 
2.34.1


