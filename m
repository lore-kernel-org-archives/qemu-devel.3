Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040DBC54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFCw-0003F5-Qo; Mon, 18 Mar 2024 11:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCt-0003CC-Dj
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:23 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCm-0007tR-K8
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:23 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e704078860so1812006b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776833; x=1711381633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYd02SLfgP/LCWG+Mrru0HvWw0TZYZU2hsjtTtlA/n0=;
 b=A3hpw+62g8JTeGjhd2syXQTIG5zkJqqHAhwQsrO27rM7WtFm51xZRQ1eHtFpwgVXpb
 ywwL3RMAfIz1WFhOFg5AlN4DGYjUEf5UkxhJoqfxAgTXQvH6+Qlw5HFuOCywoSJsXrUE
 8lg9YEAb4yINbvRbj4tTEgbKSGWG2qZ1ahPdI1VRu729Fs2BD3NtnK3KOkEe+r40sBdW
 UcIlSi5Sph/Y6165aN+8/0f+0AFnrpNPZM+wfyiYqtXIj/3AK6WjQbmuGWYMpKzlxNLJ
 obrZP99pOFhD0/HGKpIYm/v1BxJBsJiS+/DmBXHgoyx4F3ayj70LDwDRKaIRKFcCn/0g
 PaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776833; x=1711381633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYd02SLfgP/LCWG+Mrru0HvWw0TZYZU2hsjtTtlA/n0=;
 b=DxRjXjOnaBt+3l9tcuxx3uuUin3pdu8UjsZd9BbBYaGSJXDW+rYTzw92q+UTdLEhgW
 Caxi4Tlnv/wRLnzjGBAfjIU4qZXeThLdEe+fa+edcW28O1PSfDt3Lcyb4AUW7gsWPE4w
 NPezLojQMf6vg0VDJunE8r5oV217sQgg5V5f7DdCg7dkpKH4ay+9QSI5gDUrh9as+sT+
 hBBPalZe1DaYIP1C5LghJ9WwD4P748+tWLMnLvFS1WSMHEcd37U2z3rk9YRGP/Hoc4nq
 uCxAO2RJcioQqXK5n54//Kri27F6Bfjpgyz/LHt2adukt9IqJtDgV3CQnJTBW3NxaRcS
 tSWw==
X-Gm-Message-State: AOJu0YyzTlL2+OYjFABjX3aE1Ws5EStN1bUinbCtcS1BlV9L0Q8i10Hk
 JEom3qb5xvQ+6GLp8/jvCBOU8TmxQXlOA5qq/KfQM2RVthsunRTif+rAp/AoWZs=
X-Google-Smtp-Source: AGHT+IEKuRcuYR7c6NU7hrI0O/CSDi2bOSbcQ4DZEZW6z9T0qG3B+8JsuJliYd635ZlBOEVTEzvo7g==
X-Received: by 2002:a05:6a20:3d12:b0:1a3:63f4:104a with SMTP id
 y18-20020a056a203d1200b001a363f4104amr3484137pzi.13.1710776832897; 
 Mon, 18 Mar 2024 08:47:12 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:47:12 -0700 (PDT)
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
Subject: [PATCH v5 07/24] chardev: set record/replay on the base device of a
 muxed device
Date: Tue, 19 Mar 2024 01:46:04 +1000
Message-ID: <20240318154621.2361161-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


