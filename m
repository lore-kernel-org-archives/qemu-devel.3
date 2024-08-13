Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D1DC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjl1-0001zr-H1; Tue, 13 Aug 2024 01:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkr-0001Vo-8T
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:33 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkm-0007p1-Sm
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:30 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3db504ab5f3so3053908b6e.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723525647; x=1724130447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJJumfrXrjJ8ux4qFP7Y/fSmMeJLiaM2sfhvI2RTUVI=;
 b=T2JjSWTGmlrS8uxUJ5v3Nw0KATzKuGriBoiB7IMH2olIZV1EWkE+TOtGI/lEyLkOQA
 9hb3KbM24HSbpCQ9Bd7PUcm45/CU6/XDzEWDvfqJkzaGwSwDT8+28cfp4NMVHhnn0gS2
 T1fjlMKJXN4gRwawHk2bXjZvBLCnt8ARpd1ZYjSUOVH7+1Ewsfkko0sbGoqtilkp1aWv
 Keh/r6/yy5X+7bJcAhVk3TvREVVqexcAV2YjnYtLlRD26pkn517ReedgwOUBQKSXhnsm
 anYW1JhfWYmp2eypZRwjrDocLGGHLg/KJ3OTxyCZ2N/tmxg4/VrAVq0ZIB851Qml778M
 8OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723525647; x=1724130447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJJumfrXrjJ8ux4qFP7Y/fSmMeJLiaM2sfhvI2RTUVI=;
 b=cYA39cndexLfKHNPPMdxhhZbWEQIqXVQbyndoDdl7A109fZaexQzF1K17wJGcqxtHN
 /iLxLfVmfmvmlUaACgBgdvCIzI+nU4bmpFKMkjyAAe/zAXRySCvzCpEec0UIBX/fejjo
 aggOZr66rVd9vidh5nlplvUSwF/4QxZ+4WoEakkXuea0Hiw2YZyvQ91izjQ02Gmwr0gV
 tqKPpMyWNJGdCkVJGzOSYe5t9ctK8MBXvxnJ6aVinxidLQpe0zlriRLgkUOTqMQWd1jF
 22x3ZK22ZbkYOGVc+n2SvlLL20q1PtM8NxHI4aRjej91/mNgYTDw/S1nkz1D0QAK/MKz
 EvgQ==
X-Gm-Message-State: AOJu0YwQBOM5tNuE92W+ugmkhDJ6eciZe5fh3KDaaDI6XoUnDZ49HTUG
 dPBe8BaLZZzayaQUDcqi3PlblpqrQ4bfRKJBy8biUHIrC2Na40ZkFZiaH21O
X-Google-Smtp-Source: AGHT+IHJ/ilX8G/V8Ne/PTkJsAUljcaFSo11Hlds6WXW2uE8ekMAGsLe9MOAzLuPoDmp7NfaeU3wZg==
X-Received: by 2002:a05:6830:7182:b0:703:68d0:a267 with SMTP id
 46e09a7af769-70c93863fd8mr2695935a34.3.1723525646710; 
 Mon, 12 Aug 2024 22:07:26 -0700 (PDT)
Received: from wheely.local0.net ([1.145.66.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874ddcsm4846449b3a.28.2024.08.12.22.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 22:07:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v6 07/10] chardev: set record/replay on the base device of a
 muxed device
Date: Tue, 13 Aug 2024 15:06:34 +1000
Message-ID: <20240813050638.446172-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813050638.446172-1-npiggin@gmail.com>
References: <20240813050638.446172-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

chardev events to a muxed device don't get recorded because e.g.,
qemu_chr_be_write() checks whether the base device has the record flag
set.

This can be seen when replaying a trace that has characters typed into
the console, an examination of the log shows they are not recorded.

Setting QEMU_CHAR_FEATURE_REPLAY on the base chardev fixes the problem.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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
2.45.2


