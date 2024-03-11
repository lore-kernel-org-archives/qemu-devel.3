Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D22BC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjeE-0002V4-Qi; Mon, 11 Mar 2024 13:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeC-0002UK-Ly
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:12 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeA-0007LL-Oj
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e5a50d91b4so3152525b3a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178869; x=1710783669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYd02SLfgP/LCWG+Mrru0HvWw0TZYZU2hsjtTtlA/n0=;
 b=gJFtBBXkulb8RBZMXYFemYICx4m0WVqcvgzw5x9zHiO6X9/qyLtGTff0hw3x/iaVg3
 SO7lLp/zSC3f0nxbY+T5oT6m7nIXxKhkp19Ls2haNyxKfd7apNFSlakLofGtPxQR+4et
 qkl2zluO0QgaFtduSAsCJBQV0xiYlQCFAFBl5YhK3VplgjyEAjBMwxQCfilmA407F7B0
 2/3Rhi4nQQ3XMXxg6L4mK5AkbwlvSzkvfWAzRlB2/cTBFUZPpcUtCRC+Bg+vPvERnqu3
 T1SV5DJ6Y5TfbK4mEpZn0KQ6Qo2E/FvGOBlTgnFfci/va8HhTffxXRZb2c1rHt1FKB/j
 iDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178869; x=1710783669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYd02SLfgP/LCWG+Mrru0HvWw0TZYZU2hsjtTtlA/n0=;
 b=jgLq6lmro235JX+3CiAf3/be4aS+cnwvN1cZiRt0L+uzN62V2YABlhg/a+YCQdvhKj
 70H4cvPfef/vsvle/HzD/ABH95tUYIKnTR48Ei4UJn1ekP9NJoJMPMbN/86WjzPrD1c3
 QqnwrK/T9hrvcPy9LEQs2yQpb8MVCgM8Zoo4Kiow4rVEefDG0I477uPXOb7qqM8eSpP3
 fkBachu+eI/yPplv8s2OloIkye533C9MSwr7kVGGhA1XD2F3gNyCbX9WU//63lb+jTwE
 txllJte7Wh8ghf9f7MsGxQzvGHKWcb5WxeN4+6bix37H2QQaXc0zITT6q1+1enbDgpru
 20Mw==
X-Gm-Message-State: AOJu0YyARegjDMjjObnZ0ryfJkWdnd7ho7ld+YGFZuW/XLwryFZ14he6
 dRdTjWFYfdv4Gff46bqmATeWhU7CId4crSN4vQ4G1MyEaJgn8VH/IAnZBBjwKPc=
X-Google-Smtp-Source: AGHT+IFEW4kHNws9S75IZ2FSIr5IIrHrUjMISTYkQyCh5bMdiJVDKOJdfPElSeMvp/3/FIl1qbcYLA==
X-Received: by 2002:a05:6a20:6a23:b0:1a1:4e68:30db with SMTP id
 p35-20020a056a206a2300b001a14e6830dbmr9792704pzk.12.1710178869131; 
 Mon, 11 Mar 2024 10:41:09 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:08 -0700 (PDT)
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
Subject: [PATCH v4 06/24] chardev: set record/replay on the base device of a
 muxed device
Date: Tue, 12 Mar 2024 03:40:08 +1000
Message-ID: <20240311174026.2177152-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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
2.42.0


