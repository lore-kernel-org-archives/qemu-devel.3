Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A46C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy42-0006no-PU; Tue, 13 Aug 2024 16:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3x-0006Nu-QX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3U-0006Iz-QP
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42808071810so44554285e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580623; x=1724185423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJDrbDJn+uxZ4kSaJT1plgi1AkOLONkYxSD/HxvgNEI=;
 b=Tzj9xooCI+SAJThGqk78gKzOaKBk6ejSSkJ3Jjim/helhmZx1EIneTGzEktQsgSIa2
 GN0mnfMzCv8bN2kcRmwEz+M3UZinWuTuTT/24aXT+EuvheGVnRgodF+53nJ+YILdQ+1q
 rYqzSe9Hi0x/uy+r/UOQaBKbYdcGScXonCyqEe3PJBrpuc33h74icKqQk6OSeUpvPTKg
 aXGBcjOZJZ9zmw7qbIcavygNkN/g8IKzNHCxQrCqhSptVT3IwzZQJv94JlA+kiOp843R
 QGZgsLuaQNO4gmf0kq9Xi00hkM6cxUrkMoED5olZhQkrLIbbc1jB7A+1Yfys6HA8vRGn
 M5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580623; x=1724185423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJDrbDJn+uxZ4kSaJT1plgi1AkOLONkYxSD/HxvgNEI=;
 b=HfWLBsFX39IzGlyiERKL4DsI/1kDaCgJkfaed9nI850VV98Iz9Cwk3QMDvEer1xjd+
 UC5u4Rh+AifdTSUkQvWdiHUoSuFkioAO2Tsm/pXUirQhLzd0TI+O1v1pWEfrsYmF7lmM
 c+vzL1WzmZGdWIJd6gMqyiMUzcKkaQ4swlYbu1MKrd+xtyYmCjjIIW2hRMoHxxO2aP4H
 ZPYh5+jR1G279pFzjj9ry8x6IXKaaPmSpM30TLCr1srhgSoG+2DkzVcCyVkKuLkAkpg9
 HaFp0fL0LLd++InsZbm+YnUnMqg08axeCuuLSEJxCZwsFfA8IdGWiqMoGwiUM6+on1Ml
 u+/A==
X-Gm-Message-State: AOJu0YwVidlqz+m0KuMeONluFAUmyOrM4OBr9rvNdbNiJkOBh1KHzOeS
 fZBLgi6GdwkTax90XQ2Pk9ia6+fwwiDVaQUebynhcFLFf6RsRohaexOjfEcNJyM=
X-Google-Smtp-Source: AGHT+IE0bAJrXAP/wzng1w8EdVVKlq48zIYtPYjaaslmfUZhAig5koLW3DEbidmAvy1EQYRHwh1JNg==
X-Received: by 2002:a05:600c:314e:b0:428:ec2a:8c94 with SMTP id
 5b1f17b1804b1-429dd2365f4mr4810425e9.10.1723580622829; 
 Tue, 13 Aug 2024 13:23:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77372dbsm149098465e9.38.2024.08.13.13.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D4BAF5FFC6;
 Tue, 13 Aug 2024 21:23:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 15/21] chardev: set record/replay on the base device of a
 muxed device
Date: Tue, 13 Aug 2024 21:23:23 +0100
Message-Id: <20240813202329.1237572-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

chardev events to a muxed device don't get recorded because e.g.,
qemu_chr_be_write() checks whether the base device has the record flag
set.

This can be seen when replaying a trace that has characters typed into
the console, an examination of the log shows they are not recorded.

Setting QEMU_CHAR_FEATURE_REPLAY on the base chardev fixes the problem.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-8-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 chardev/char.c | 71 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 3c43fb1278..ba847b6e9e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -615,11 +615,24 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
     return backend;
 }
 
-Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
-                                Error **errp)
+static void qemu_chardev_set_replay(Chardev *chr, Error **errp)
+{
+    if (replay_mode != REPLAY_MODE_NONE) {
+        if (CHARDEV_GET_CLASS(chr)->chr_ioctl) {
+            error_setg(errp, "Replay: ioctl is not supported "
+                             "for serial devices yet");
+            return;
+        }
+        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
+        replay_register_char_driver(chr);
+    }
+}
+
+static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
+                                         bool replay, Error **errp)
 {
     const ChardevClass *cc;
-    Chardev *chr = NULL;
+    Chardev *base = NULL, *chr = NULL;
     ChardevBackend *backend = NULL;
     const char *name = qemu_opt_get(opts, "backend");
     const char *id = qemu_opts_id(opts);
@@ -657,11 +670,11 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
     chr = qemu_chardev_new(bid ? bid : id,
                            object_class_get_name(OBJECT_CLASS(cc)),
                            backend, context, errp);
-
     if (chr == NULL) {
         goto out;
     }
 
+    base = chr;
     if (bid) {
         Chardev *mux;
         qapi_free_ChardevBackend(backend);
@@ -681,11 +694,25 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
 out:
     qapi_free_ChardevBackend(backend);
     g_free(bid);
+
+    if (replay && base) {
+        /* RR should be set on the base device, not the mux */
+        qemu_chardev_set_replay(base, errp);
+    }
+
     return chr;
 }
 
-Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
-                               bool permit_mux_mon, GMainContext *context)
+Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
+                                Error **errp)
+{
+    /* XXX: should this really not record/replay? */
+    return __qemu_chr_new_from_opts(opts, context, false, errp);
+}
+
+static Chardev *__qemu_chr_new(const char *label, const char *filename,
+                               bool permit_mux_mon, GMainContext *context,
+                               bool replay)
 {
     const char *p;
     Chardev *chr;
@@ -693,14 +720,22 @@ Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
     Error *err = NULL;
 
     if (strstart(filename, "chardev:", &p)) {
-        return qemu_chr_find(p);
+        chr = qemu_chr_find(p);
+        if (replay) {
+            qemu_chardev_set_replay(chr, &err);
+            if (err) {
+                error_report_err(err);
+                return NULL;
+            }
+        }
+        return chr;
     }
 
     opts = qemu_chr_parse_compat(label, filename, permit_mux_mon);
     if (!opts)
         return NULL;
 
-    chr = qemu_chr_new_from_opts(opts, context, &err);
+    chr = __qemu_chr_new_from_opts(opts, context, replay, &err);
     if (!chr) {
         error_report_err(err);
         goto out;
@@ -722,24 +757,18 @@ out:
     return chr;
 }
 
+Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
+                               bool permit_mux_mon, GMainContext *context)
+{
+    return __qemu_chr_new(label, filename, permit_mux_mon, context, false);
+}
+
 static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
                                           const char *filename,
                                           bool permit_mux_mon,
                                           GMainContext *context)
 {
-    Chardev *chr;
-    chr = qemu_chr_new_noreplay(label, filename, permit_mux_mon, context);
-    if (chr) {
-        if (replay_mode != REPLAY_MODE_NONE) {
-            qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
-        }
-        if (qemu_chr_replay(chr) && CHARDEV_GET_CLASS(chr)->chr_ioctl) {
-            error_report("Replay: ioctl is not supported "
-                         "for serial devices yet");
-        }
-        replay_register_char_driver(chr);
-    }
-    return chr;
+    return __qemu_chr_new(label, filename, permit_mux_mon, context, true);
 }
 
 Chardev *qemu_chr_new(const char *label, const char *filename,
-- 
2.39.2


