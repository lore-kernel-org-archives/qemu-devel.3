Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C043C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVeo-0007oj-L0; Tue, 02 Jul 2024 01:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVem-0007nU-QF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:20 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVef-0007BS-Hm
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:20 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ee77db6f97so1352011fa.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896531; x=1720501331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGQns0yzqsl3OUGwx5bDl3r7+W830Rk2Y5bSGG1iekg=;
 b=ZC9GdKXbG1ugQYFhlxRs82lRfny7mkRcVDDDkaSjTUIgS9+FrliOaOT48Vth065fqt
 SKHcC4gQWjeZU4LaCOkkxN3YX0gKyrYAjfq2aBXjfgMbyMEArxjBgb+8yGdMtfV0jpHx
 VE2N3AEAwzUVOCGkzWsCQyzLhrW7ryz4myNCmMTI6Y12FlUG+m1jjjj53Lk+z7HtmiVF
 K+aqfWRDQmOEh45WaPPVYpftM1MHubpUPuBpoCwJrOyg5P/C02q/mobDV1kBCHmkJyPt
 4rTlkerb5DysIg6QSKhEnysJt6tGipotzE9GPJByvTNV2xVXsMa+8cvwIU59Vc4LUnev
 NQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896531; x=1720501331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGQns0yzqsl3OUGwx5bDl3r7+W830Rk2Y5bSGG1iekg=;
 b=ouRbJO71QWk4thHxq6h/NKTiYAzIZbSItzrVrt49C4/5hWc2cVO+dqGWS8P3r0/4cu
 ZTE8jk2RpJTa1by70DjTwqlOu1gLFke8SsJg0XJabFp6NeERFEAa8NrfWe2zqoM7CGc7
 2wgsZcyjTNMeobzRF4V/L1NvuY8wyr8sOb+x+bfPzoKvQ4fY40PIqc5/3GB1Y6G046Cb
 So+bV0oSYaO+akpFkbv5HLn29DIGd6zYZxgkCWAJlsBJGji5WVXHhYkS5NTQ8KZYPMU3
 eRsayraVzatTkjAcFVMLFRIIavS2w3Ev2O1yGIa/8rd3M/2hg4FMESQnDrzrtFmWkq9a
 E9WA==
X-Gm-Message-State: AOJu0YynvD6Hl843rpF0KXIC+DPaGc/OM79r9BIht1DlhAibcg36Mizl
 J0nWQjDvdE9MFlxG+l3at4LncOrFRYHsOETSdWT21SA48r6XfKCwtuMQkWz6r4qZRSUSVODc13u
 m
X-Google-Smtp-Source: AGHT+IE3/CgdPUa5tlyLaXaphwECIZA3F7Tl2f2vXPOmK/shBhoi5FWNo0AHQFMpIP+5K2ThzLCFwQ==
X-Received: by 2002:a2e:a418:0:b0:2ec:557b:f895 with SMTP id
 38308e7fff4ca-2ee5e4b91cdmr61056101fa.31.1719896530395; 
 Mon, 01 Jul 2024 22:02:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cdc5csm11984562f8f.18.2024.07.01.22.02.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:02:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/22] include/hw: add macros for deprecation & removal of
 versioned machines
Date: Tue,  2 Jul 2024 07:00:59 +0200
Message-ID: <20240702050112.35907-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Versioned machines live for a long time to provide back compat for
incoming migration and restore of saved images. To guide users away from
usage of old machines, however, we want to deprecate any older than 3
years (equiv of 9 releases), and delete any older than 6 years (equiva
of 18 releases).

To get a standardized deprecation message and avoid having to remember
to manually add it after three years, this introduces two macros to be
used by targets when defining versioned machines.

* MACHINE_VER_DEPRECATION(major, minor)

  Automates the task of setting the 'deprecation_reason' field on the
  machine, if-and-only-if the major/minor version is older than 3 years.

* MACHINE_VER_DELETION(major, minor)

  Simulates the deletion of by skipping registration of the QOM type
  for a versioned machine, if-and-only-if the major/minor version is
  older than 6 years.

By using these two macros there is no longer any manual work required
per-release to deprecate old machines. By preventing the use of machines
that have reached their deletion date, it is also not necessary to
manually delete machines per-release. Deletion can be batched up once a
year or whenever makes most sense.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240620165742.1711389-9-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 96 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index d5ad712585..187ed76646 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -429,6 +429,7 @@ struct MachineState {
  *          MachineClass *mc = MACHINE_CLASS(oc); \
  *          MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
  *          mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " Virtual Machine"; \
+ *          MACHINE_VER_DEPRECATION(__VA_ARGS__); \
  *          if (latest) { \
  *              mc->alias = "virt"; \
  *          } \
@@ -440,6 +441,7 @@ struct MachineState {
  *      }; \
  *      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
  *      { \
+ *          MACHINE_VER_DELETION(__VA_ARGS__); \
  *          type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
  *      } \
  *      type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
@@ -598,6 +600,100 @@ struct MachineState {
                       _MACHINE_VER_SYM2) (sym, prefix, __VA_ARGS__)
 
 
+/*
+ * How many years/major releases for each phase
+ * of the life cycle. Assumes use of versioning
+ * scheme where major is bumped each year
+ */
+#define MACHINE_VER_DELETION_MAJOR 6
+#define MACHINE_VER_DEPRECATION_MAJOR 3
+
+/*
+ * Expands to a static string containing a deprecation
+ * message for a versioned machine type
+ */
+#define MACHINE_VER_DEPRECATION_MSG \
+    "machines more than " stringify(MACHINE_VER_DEPRECATION_MAJOR) \
+    " years old are subject to deletion after " \
+    stringify(MACHINE_VER_DELETION_MAJOR) " years"
+
+#define _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor) \
+    (((QEMU_VERSION_MAJOR - major) > cutoff) || \
+     (((QEMU_VERSION_MAJOR - major) == cutoff) && \
+      (QEMU_VERSION_MINOR - minor) >= 0))
+
+#define _MACHINE_VER_IS_EXPIRED2(cutoff, major, minor) \
+    _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor)
+#define _MACHINE_VER_IS_EXPIRED3(cutoff, major, minor, micro) \
+    _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor)
+#define _MACHINE_VER_IS_EXPIRED4(cutoff, major, minor, _unused, tag) \
+    _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor)
+#define _MACHINE_VER_IS_EXPIRED5(cutoff, major, minor, micro, _unused, tag)   \
+    _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor)
+
+#define _MACHINE_IS_EXPIRED(cutoff, ...) \
+    _MACHINE_VER_PICK(__VA_ARGS__, \
+                      _MACHINE_VER_IS_EXPIRED5, \
+                      _MACHINE_VER_IS_EXPIRED4, \
+                      _MACHINE_VER_IS_EXPIRED3, \
+                      _MACHINE_VER_IS_EXPIRED2) (cutoff, __VA_ARGS__)
+
+/*
+ * Evaluates true when a machine type with (major, minor)
+ * or (major, minor, micro) version should be considered
+ * deprecated based on the current versioned machine type
+ * lifecycle rules
+ */
+#define MACHINE_VER_IS_DEPRECATED(...) \
+    _MACHINE_IS_EXPIRED(MACHINE_VER_DEPRECATION_MAJOR, __VA_ARGS__)
+
+/*
+ * Evaluates true when a machine type with (major, minor)
+ * or (major, minor, micro) version should be considered
+ * for deletion based on the current versioned machine type
+ * lifecycle rules
+ */
+#define MACHINE_VER_SHOULD_DELETE(...) \
+    _MACHINE_IS_EXPIRED(MACHINE_VER_DELETION_MAJOR, __VA_ARGS__)
+
+/*
+ * Sets the deprecation reason for a versioned machine based
+ * on its age
+ *
+ * This must be unconditionally used in the _class_init
+ * function for all machine types which support versioning.
+ *
+ * Initially it will effectively be a no-op, but after a
+ * suitable period of time has passed, it will set the
+ * 'deprecation_reason' field on the machine, to warn users
+ * about forthcoming removal.
+ */
+#define MACHINE_VER_DEPRECATION(...) \
+    do { \
+        if (MACHINE_VER_IS_DEPRECATED(__VA_ARGS__)) { \
+            mc->deprecation_reason = MACHINE_VER_DEPRECATION_MSG; \
+        } \
+    } while (0)
+
+/*
+ * Prevents registration of a versioned machined based on
+ * its age
+ *
+ * This must be unconditionally used in the register
+ * method for all machine types which support versioning.
+ *
+ * Inijtially it will effectively be a no-op, but after a
+ * suitable period of time has passed, it will cause
+ * execution of the method to return, avoiding registration
+ * of the machine
+ */
+#define MACHINE_VER_DELETION(...) \
+    do { \
+        if (MACHINE_VER_SHOULD_DELETE(__VA_ARGS__)) { \
+            return; \
+        } \
+    } while (0)
+
 #define DEFINE_MACHINE(namestr, machine_initfn) \
     static void machine_initfn##_class_init(ObjectClass *oc, void *data) \
     { \
-- 
2.41.0


