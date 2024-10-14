Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B8AD1624A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JUl-0006gW-65; Mon, 14 Oct 2024 07:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUY-0006dC-2f
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:44:02 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUU-00057W-Np
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:44:01 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539f2b95775so1101036e87.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728906231; x=1729511031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjYNJJ1dYrUmsDzEmUe+V7cRkzd0WDVuJMYgHV7VGG8=;
 b=MonTXul8KcgyhhVwu/4OHP1VyiFcMjA45cxHPtCemXbkV4a4MZ97qa4oWqQ8PDnl01
 GAaiqfdD6u1odpx+avtLrgWjc1GVQ5dx5s7xAzc20ZmTrL7QI3FFPEuygdciv5bWaKBd
 RfADloPZdZviMNsdBK1Fy+MRqkR2yoPy3YjeiM8hDy+usBLsCUdT5kg2X5ExwvkrC7eK
 J0STR3N2rQ/UlVkeKrM9+eetRn7MF4sY5EcE0wv74q/7aYOTaXDoFErE3jrO9jplD+ep
 GctqqMIkyYzDHVy8atIHmuoJqTnmm+By+lqMyiau4ycFwjs/15eseZUxIA8AVhAKvELJ
 tgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728906231; x=1729511031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjYNJJ1dYrUmsDzEmUe+V7cRkzd0WDVuJMYgHV7VGG8=;
 b=f1GmaqlDc4BCl07I1QfPRkgPe4kZveUSWDRXeONECBc8HDlw5P8/FIYA7inig08FfG
 fN1l5Ze7OI6gUYU3P3cN5KGH0JDGpecBQm6PXSxnYo5yfLtP2lYBgfGmsS+0iiEPIcAP
 TzaMjgRWH4M6bO+7gKqxZickIEG81O4nVchzmUsmIkCzUQBitDF3XdKF4cziopxJC/2A
 TDFOzBRFC5T5/A/A33Bn15/LcVjTFa7spdNJAdzwqb34X02u3GQXCHLTJETT5qtyHQqP
 Q75sSgoy/59I25wiyNNpHy4qjvWxmMDkFRSuOaFxEo50Q3Jjfv8Vtu1V1VAJ7IYvaQeB
 NY0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ3CcSGPwUAfL2t5NNxahLojjHlccPYZYtY8j1wekcGHm5ajTAwPiTgoNgJnRr+vKN1QTaeiBUNrZ1@nongnu.org
X-Gm-Message-State: AOJu0Yxb6cNUuwAw5cVYc7bGUHwGI+EI+mrOx2GhVAO/KXpC4UO0J6XE
 d55q170HlSn5GncabV7e9j1oDNR/G1vbjmsItyFLdxfxzm0nl0aw
X-Google-Smtp-Source: AGHT+IHJtJuvVhj6lvf5iIYuutgeA7fLoa6Z33wvidhJL8LGmxjPJRBfOxwafPBQSk9IMurG2SwCBA==
X-Received: by 2002:a05:6512:220d:b0:539:8a50:6ee8 with SMTP id
 2adb3069b0e04-539e57282b1mr3443460e87.57.1728906231089; 
 Mon, 14 Oct 2024 04:43:51 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99fcb2765asm247764666b.64.2024.10.14.04.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:43:49 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 7/8] chardev/mux: implement detach of frontends from mux
Date: Mon, 14 Oct 2024 13:41:34 +0200
Message-Id: <20241014114135.389766-8-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014114135.389766-1-r.peniaev@gmail.com>
References: <20241014114135.389766-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x136.google.com
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

With bitset management now it becomes feasible to implement
the logic of detaching frontends from multiplexer.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |  2 +-
 chardev/char-mux.c         | 20 +++++++++++++++++---
 chardev/chardev-internal.h |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 3b8771ca2ac4..8ac6bebb6f74 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -225,7 +225,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
         }
         if (CHARDEV_IS_MUX(b->chr)) {
             MuxChardev *d = MUX_CHARDEV(b->chr);
-            d->backends[b->tag] = NULL;
+            mux_chr_detach_frontend(d, b->tag);
         }
         if (del) {
             Object *obj = OBJECT(b->chr);
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 9c3cacb2fecd..649f8ff6ccbf 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -289,10 +289,10 @@ static void char_mux_finalize(Object *obj)
     bit = -1;
     while ((bit = find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) < MAX_MUX) {
         CharBackend *be = d->backends[bit];
-        if (be) {
-            be->chr = NULL;
-        }
+        be->chr = NULL;
+        d->backends[bit] = NULL;
     }
+    d->mux_bitset = 0;
     qemu_chr_fe_deinit(&d->chr, false);
 }
 
@@ -331,6 +331,21 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
     return true;
 }
 
+bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
+{
+    unsigned int bit;
+
+    bit = find_next_bit(&d->mux_bitset, MAX_MUX, tag);
+    if (bit >= MAX_MUX) {
+        return false;
+    }
+
+    d->mux_bitset &= ~(1 << bit);
+    d->backends[bit] = NULL;
+
+    return true;
+}
+
 void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index b89aada5413b..853807f3cb88 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -61,6 +61,7 @@ DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
 
 bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
                              unsigned int *tag, Error **errp);
+bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag);
 void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
-- 
2.34.1


