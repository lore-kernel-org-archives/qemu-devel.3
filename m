Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90506D1AD43
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t11GV-0003ip-OV; Wed, 16 Oct 2024 06:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t11GS-0003hm-U0
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:28:24 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t11GQ-00048y-ME
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:28:24 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f0f9ee49so3968885e87.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 03:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729074501; x=1729679301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBhjMyaS7m28UKrmGr2wsVJl2lrhr5g7YG4lTUQ0QeA=;
 b=ayM1WTO1dCly4YZ4RdSrp4V24x5+JUt+qZhOUwf02PfKKtNTWEC+I65WwdxVuW+PDJ
 VkRyMlQzzDbASf/paTAdh2NXcBbYGtoOJgCyk8IV8KTPOUbCrUfqm5KOziCxVwZFRcbp
 UNNur3elR0fj2oDFrJJdIRE5MFEGoNqDRfhHh04iFCrxYlYwSiV5chEjNuoAu6sE/pr7
 dqp9FiMv7dD4BSx5zYpTIrOlkRje2v8bKLsRACOUMiGmsxurbuhW+4+RTyvVOh+sZq9q
 3VpI/74UkZAtCv8hvk8AMN98SJRWfpfo6WXitYKZ3dqKivsKxwijosGrYEgBDsuRt3WX
 DVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729074501; x=1729679301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qBhjMyaS7m28UKrmGr2wsVJl2lrhr5g7YG4lTUQ0QeA=;
 b=OKKRxOTuQY9eUvVd35wXPMkr2nLZQkinNeqtT2D04NdEA8rraJ9UPivZK2VF9coCS/
 InoVWm8b0ADSxKI9Zf7Jr68SvOsx5xZfykbecIGZAjfyYOHCSTeXUiMOWnh8/iRTbTAS
 RCUDHwMZyReP8vGpiTiq3k7Nq6apo1x11tqFhfAf9aWD3Y39kV5UBYNOizegtPoJv+21
 L++JG+yY06fubj0aQ+PuUvylGIjvmkhtVtKddTG12ulb3e6FQhOujCkpU/I2b223dMFF
 HZjB68Cna4xmGr8wDSVMThhGVHwTz40MjuNfSeFEjgDN+Ma8RApaUTWUNlpPNC/pCvT8
 AAFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwSJzmykssa6xQH3tdmIumHmqC2GoIoMCZl8NeMC11C4am87Sm1g9u2A+X19h7dYECi7MDJmyHL2O9@nongnu.org
X-Gm-Message-State: AOJu0Yz3DtVGriYgZYPUCArNGDBfDRnewQ5E2p5TD4emRWTpLjwboZaa
 d7ezFWLwQ8JyilQOEKWdD+jdxoLypwQ8hqaFgHNhSNKxnxaaUhpL
X-Google-Smtp-Source: AGHT+IGlJqsEODxYMPoj0SCj/kWFNA14FL0D/CDM93fwsXU6/6fuvTCbzwp9dbUMjDR96Qv7S+hqPg==
X-Received: by 2002:a05:6512:b1c:b0:539:9524:92bc with SMTP id
 2adb3069b0e04-53a03f826f9mr2195662e87.55.1729074500412; 
 Wed, 16 Oct 2024 03:28:20 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d4f85dcsm1566680a12.22.2024.10.16.03.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:28:20 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 3/8] chardev/char: move away mux suspend/resume calls
Date: Wed, 16 Oct 2024 12:26:00 +0200
Message-Id: <20241016102605.459395-4-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016102605.459395-1-r.peniaev@gmail.com>
References: <20241016102605.459395-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x12e.google.com
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

The suspend/resume open multiplexer calls are generic
and will be used for frontend (current mux) and backend
(will follow) implementations. Move them away from the
`char-mux-fe.c` to more generic `char.c` file. Also
for the sake of clarity these renames were made:

  s/suspend_mux_open/mux_suspend_open/g
  s/resume_mux_open/mux_resume_open/g

No functional changes are made.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux-fe.c      | 63 ++-------------------------------
 chardev/char.c             | 72 ++++++++++++++++++++++++++++++++++++++
 chardev/chardev-internal.h |  3 ++
 include/chardev/char.h     |  5 +--
 system/vl.c                |  4 +--
 5 files changed, 82 insertions(+), 65 deletions(-)

diff --git a/chardev/char-mux-fe.c b/chardev/char-mux-fe.c
index dfaea5aefac3..6a195390a3c9 100644
--- a/chardev/char-mux-fe.c
+++ b/chardev/char-mux-fe.c
@@ -34,13 +34,6 @@
 
 /* MUX driver for serial I/O splitting */
 
-/*
- * Set to false by suspend_mux_open.  Open events are delayed until
- * resume_mux_open.  Usually suspend_mux_open is called before
- * command line processing and resume_mux_open afterwards.
- */
-static bool muxes_opened = true;
-
 /* Called with chr_write_lock held.  */
 static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
@@ -248,15 +241,10 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
         }
 }
 
-void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
+void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUChrEvent event)
 {
-    MuxFeChardev *d = MUX_FE_CHARDEV(chr);
     int bit;
 
-    if (!muxes_opened) {
-        return;
-    }
-
     /* Send the event to all registered listeners */
     bit = -1;
     while ((bit = find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) < MAX_MUX) {
@@ -381,7 +369,7 @@ static void qemu_chr_open_mux(Chardev *chr,
     /* only default to opened state if we've realized the initial
      * set of muxes
      */
-    *be_opened = muxes_opened;
+    *be_opened = mux_is_opened();
     qemu_chr_fe_init(&d->chr, drv, errp);
 }
 
@@ -401,53 +389,6 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
     mux->chardev = g_strdup(chardev);
 }
 
-/**
- * Called after processing of default and command-line-specified
- * chardevs to deliver CHR_EVENT_OPENED events to any FEs attached
- * to a mux chardev. This is done here to ensure that
- * output/prompts/banners are only displayed for the FE that has
- * focus when initial command-line processing/machine init is
- * completed.
- *
- * After this point, any new FE attached to any new or existing
- * mux will receive CHR_EVENT_OPENED notifications for the BE
- * immediately.
- */
-static void open_muxes(Chardev *chr)
-{
-    /* send OPENED to all already-attached FEs */
-    mux_chr_send_all_event(chr, CHR_EVENT_OPENED);
-
-    /*
-     * mark mux as OPENED so any new FEs will immediately receive
-     * OPENED event
-     */
-    chr->be_open = 1;
-}
-
-void suspend_mux_open(void)
-{
-    muxes_opened = false;
-}
-
-static int chardev_options_parsed_cb(Object *child, void *opaque)
-{
-    Chardev *chr = (Chardev *)child;
-
-    if (!chr->be_open && CHARDEV_IS_MUX_FE(chr)) {
-        open_muxes(chr);
-    }
-
-    return 0;
-}
-
-void resume_mux_open(void)
-{
-    muxes_opened = true;
-    object_child_foreach(get_chardevs_root(),
-                         chardev_options_parsed_cb, NULL);
-}
-
 static void char_mux_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
diff --git a/chardev/char.c b/chardev/char.c
index e077773cdece..d8dbdb6f84f1 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -43,6 +43,13 @@
 
 #include "chardev-internal.h"
 
+/*
+ * Set to false by mux_suspend_open().  Open events are delayed until
+ * mux_resume_open().  Usually mux_suspend_open() is called before
+ * command line processing and mux_resume_open() afterwards.
+ */
+static bool muxes_opened = true;
+
 /***********************************************************/
 /* character device */
 
@@ -1259,6 +1266,71 @@ void qemu_chr_cleanup(void)
     object_unparent(get_chardevs_root());
 }
 
+/**
+ * Called after processing of default and command-line-specified
+ * chardevs to deliver CHR_EVENT_OPENED events to any FEs attached
+ * to a mux chardev. This is done here to ensure that
+ * output/prompts/banners are only displayed for the FE that has
+ * focus when initial command-line processing/machine init is
+ * completed.
+ *
+ * After this point, any new FE attached to any new or existing
+ * mux will receive CHR_EVENT_OPENED notifications for the BE
+ * immediately.
+ */
+static void open_muxes(Chardev *chr)
+{
+    /* send OPENED to all already-attached FEs */
+    mux_chr_send_all_event(chr, CHR_EVENT_OPENED);
+
+    /*
+     * mark mux as OPENED so any new FEs will immediately receive
+     * OPENED event
+     */
+    chr->be_open = 1;
+}
+
+void mux_suspend_open(void)
+{
+    muxes_opened = false;
+}
+
+static int chardev_options_parsed_cb(Object *child, void *opaque)
+{
+    Chardev *chr = (Chardev *)child;
+
+    if (!chr->be_open && CHARDEV_IS_MUX_FE(chr)) {
+        open_muxes(chr);
+    }
+
+    return 0;
+}
+
+void mux_resume_open(void)
+{
+    muxes_opened = true;
+    object_child_foreach(get_chardevs_root(),
+                         chardev_options_parsed_cb, NULL);
+}
+
+bool mux_is_opened(void)
+{
+    return muxes_opened;
+}
+
+void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
+{
+    if (!mux_is_opened()) {
+        return;
+    }
+
+    if (CHARDEV_IS_MUX_FE(chr)) {
+        MuxFeChardev *d = MUX_FE_CHARDEV(chr);
+
+        mux_fe_chr_send_all_event(d, event);
+    }
+}
+
 static void register_types(void)
 {
     type_register_static(&char_type_info);
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 321051bb9cc5..c874850a41ad 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -65,6 +65,9 @@ bool mux_chr_detach_frontend(MuxFeChardev *d, unsigned int tag);
 void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
+/* Mux type dependent calls */
+void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUChrEvent event);
+
 Object *get_chardevs_root(void);
 
 #endif /* CHARDEV_INTERNAL_H */
diff --git a/include/chardev/char.h b/include/chardev/char.h
index d9d23b6232db..0bec974f9d73 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -317,7 +317,8 @@ extern int term_escape_char;
 GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
                                  GSourceFunc func, void *private);
 
-void suspend_mux_open(void);
-void resume_mux_open(void);
+bool mux_is_opened(void);
+void mux_suspend_open(void);
+void mux_resume_open(void);
 
 #endif
diff --git a/system/vl.c b/system/vl.c
index e83b3b2608bf..b3cbfe2c0f84 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3679,7 +3679,7 @@ void qemu_init(int argc, char **argv)
 
     qemu_create_machine(machine_opts_dict);
 
-    suspend_mux_open();
+    mux_suspend_open();
 
     qemu_disable_default_devices();
     qemu_setup_display();
@@ -3757,5 +3757,5 @@ void qemu_init(int argc, char **argv)
     qemu_init_displays();
     accel_setup_post(current_machine);
     os_setup_post();
-    resume_mux_open();
+    mux_resume_open();
 }
-- 
2.34.1


