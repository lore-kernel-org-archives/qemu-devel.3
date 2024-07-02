Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E23C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVe7-0007Bg-BX; Tue, 02 Jul 2024 01:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVe1-0007A8-GE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:33 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVdy-00061m-JN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:33 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-36743abace4so3057973f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896487; x=1720501287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CImu6gnFSvQkVYqxGUzc3+u9J6fqWPW8HcbEc7YmhgM=;
 b=CJTa0iSDGZdbr2eRLioMveNG1wIhHZBw+fXQpGCXB8ZMr/CpFY9NBDQ+a2PIIGqHXz
 ePHBdsIi4OM2jj6QPQ+Bxy8XzZfMAnzgOYkUsr/otmnV+hfCLicnVsjCiQ2iOgjmcgQM
 bQqYRGp/BDqUBHxWdmyIWc1CGQrXsuGorwpE1sJdcC4v6nXE0LJlqgyykSlCDYfewXyQ
 Td228KtO2Oj2109pu0UE+bEnba7dg1d7w6A697Yve+7U0Y4bomumisc+r75aLBeTOEU8
 +iRhL/BtrbkKgP8JM0rM8Fc3KnXoSwTosWpnBSOnVXAJKv12vkCX8Ba2oNOpy0FLuRjW
 l/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896487; x=1720501287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CImu6gnFSvQkVYqxGUzc3+u9J6fqWPW8HcbEc7YmhgM=;
 b=pH6AU4egxBWwlgV8PzEOw4RLi01UCOMgCgOWm/t1dzMpR975Ia9H7JPAX3ErY/J+jz
 m6aSrcTLA7Z2so2lvXorO15hXR3JLRzCqTLtCcYRsKx6bs6ofpey2PNjwopoQdR4pQzL
 tQLSwwEVl6grlF/+XpA1oufpaOoANSU3NC3HQuvPKaUdIRAccniZ0xyT2/GPHGI/9nks
 xA7rw5luYaP27zM/Js+oJZXoctIHJd2or2684qAGxGYeolln+FulidX8Nu28y4xLkYWq
 iyLcAseL9QHRmqGBf1z4AO+EzDuAosSXI2ZUbItB8jetQdD7gRf2mbGOGSXAYcpcgvOW
 +MwA==
X-Gm-Message-State: AOJu0YxenM3geXVjCj0bNTpckP/A0HOf/b8Bb6lrUc14/AGaSERwPp9S
 H+dTi3ft2R6eLPW+BXyM78kYuBz6YoL3YDomK8eH1WRu5RgilzreAqS3mRQPnb1snxfjnv/DyPb
 k
X-Google-Smtp-Source: AGHT+IFzdjF2Sg7wZlX6hLnTi0vcBf6bfFte5OuBU7yqUSirMoYwgUp87UaN9Ft0MnXLC0wM78B7Nw==
X-Received: by 2002:a05:6000:1f8e:b0:366:e09c:56be with SMTP id
 ffacd0b85a97d-36760a63050mr11121075f8f.6.1719896487437; 
 Mon, 01 Jul 2024 22:01:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a112a54sm11958811f8f.115.2024.07.01.22.01.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:01:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/22] include/hw: add helpers for defining versioned machine
 types
Date: Tue,  2 Jul 2024 07:00:52 +0200
Message-ID: <20240702050112.35907-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

The various targets which define versioned machine types have
a bunch of obfuscated macro code for defining unique function
and variable names using string concatenation.

This adds a couple of helpers to improve the clarity of such
code macro.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240620165742.1711389-2-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 185 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 73ad319d7d..d5ad712585 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -413,6 +413,191 @@ struct MachineState {
     struct NumaState *numa_state;
 };
 
+/*
+ * The macros which follow are intended to facilitate the
+ * definition of versioned machine types, using a somewhat
+ * similar pattern across targets.
+ *
+ * For example, a macro that can be used to define versioned
+ * 'virt' machine types would look like:
+ *
+ *  #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
+ *      static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
+ *          ObjectClass *oc, \
+ *          void *data) \
+ *      { \
+ *          MachineClass *mc = MACHINE_CLASS(oc); \
+ *          MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
+ *          mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " Virtual Machine"; \
+ *          if (latest) { \
+ *              mc->alias = "virt"; \
+ *          } \
+ *      } \
+ *      static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = { \
+ *          .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+ *          .parent = TYPE_VIRT_MACHINE, \
+ *          .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+ *      }; \
+ *      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
+ *      { \
+ *          type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
+ *      } \
+ *      type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
+ *
+ * Following this, one (or more) helpers can be added for
+ * whichever scenarios need to be catered for with a machine:
+ *
+ *  // Normal 2 digit, marked as latest e.g. 'virt-9.0'
+ *  #define DEFINE_VIRT_MACHINE_LATEST(major, minor) \
+ *      DEFINE_VIRT_MACHINE_IMPL(true, major, minor)
+ *
+ *  // Normal 2 digit e.g. 'virt-9.0'
+ *  #define DEFINE_VIRT_MACHINE(major, minor) \
+ *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
+ *
+ *  // Bugfix 3 digit e.g. 'virt-9.0.1'
+ *  #define DEFINE_VIRT_MACHINE_BUGFIX(major, minor, micro) \
+ *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro)
+ *
+ *  // Tagged 2 digit e.g. 'virt-9.0-extra'
+ *  #define DEFINE_VIRT_MACHINE_TAGGED(major, minor, tag) \
+ *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, _, tag)
+ *
+ *  // Tagged bugfix 2 digit e.g. 'virt-9.0.1-extra'
+ *  #define DEFINE_VIRT_MACHINE_TAGGED(major, minor, micro, tag) \
+ *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro, _, tag)
+ */
+
+/*
+ * Helper for dispatching different macros based on how
+ * many __VA_ARGS__ are passed. Supports 1 to 5 variadic
+ * arguments, with the called target able to be prefixed
+ * with 0 or more fixed arguments too. To be called thus:
+ *
+ *  _MACHINE_VER_PICK(__VA_ARGS,
+ *                    MACRO_MATCHING_5_ARGS,
+ *                    MACRO_MATCHING_4_ARGS,
+ *                    MACRO_MATCHING_3_ARGS,
+ *                    MACRO_MATCHING_2_ARGS,
+ *                    MACRO_MATCHING_1_ARG) (FIXED-ARG-1,
+ *                                           ...,
+ *                                           FIXED-ARG-N,
+ *                                           __VA_ARGS__)
+ */
+#define _MACHINE_VER_PICK(x1, x2, x3, x4, x5, x6, ...) x6
+
+/*
+ * Construct a human targeted machine version string.
+ *
+ * Can be invoked with various signatures
+ *
+ *  MACHINE_VER_STR(sym, prefix, major, minor)
+ *  MACHINE_VER_STR(sym, prefix, major, minor, micro)
+ *  MACHINE_VER_STR(sym, prefix, major, minor, _, tag)
+ *  MACHINE_VER_STR(sym, prefix, major, minor, micro, _, tag)
+ *
+ * Respectively emitting symbols with the format
+ *
+ *   "{major}.{minor}"
+ *   "{major}.{minor}-{tag}"
+ *   "{major}.{minor}.{micro}"
+ *   "{major}.{minor}.{micro}-{tag}"
+ */
+#define _MACHINE_VER_STR2(major, minor) \
+    #major "." #minor
+
+#define _MACHINE_VER_STR3(major, minor, micro) \
+    #major "." #minor "." #micro
+
+#define _MACHINE_VER_STR4(major, minor, _unused_, tag) \
+    #major "." #minor "-" #tag
+
+#define _MACHINE_VER_STR5(major, minor, micro, _unused_, tag) \
+    #major "." #minor "." #micro "-" #tag
+
+#define MACHINE_VER_STR(...) \
+    _MACHINE_VER_PICK(__VA_ARGS__, \
+                      _MACHINE_VER_STR5, \
+                      _MACHINE_VER_STR4, \
+                      _MACHINE_VER_STR3, \
+                      _MACHINE_VER_STR2) (__VA_ARGS__)
+
+
+/*
+ * Construct a QAPI type name for a versioned machine
+ * type
+ *
+ * Can be invoked with various signatures
+ *
+ *  MACHINE_VER_TYPE_NAME(prefix, major, minor)
+ *  MACHINE_VER_TYPE_NAME(prefix, major, minor, micro)
+ *  MACHINE_VER_TYPE_NAME(prefix, major, minor, _, tag)
+ *  MACHINE_VER_TYPE_NAME(prefix, major, minor, micro, _, tag)
+ *
+ * Respectively emitting symbols with the format
+ *
+ *   "{prefix}-{major}.{minor}"
+ *   "{prefix}-{major}.{minor}.{micro}"
+ *   "{prefix}-{major}.{minor}-{tag}"
+ *   "{prefix}-{major}.{minor}.{micro}-{tag}"
+ */
+#define _MACHINE_VER_TYPE_NAME2(prefix, major, minor)   \
+    prefix "-" #major "." #minor TYPE_MACHINE_SUFFIX
+
+#define _MACHINE_VER_TYPE_NAME3(prefix, major, minor, micro) \
+    prefix "-" #major "." #minor "." #micro TYPE_MACHINE_SUFFIX
+
+#define _MACHINE_VER_TYPE_NAME4(prefix, major, minor, _unused_, tag) \
+    prefix "-" #major "." #minor "-" #tag TYPE_MACHINE_SUFFIX
+
+#define _MACHINE_VER_TYPE_NAME5(prefix, major, minor, micro, _unused_, tag) \
+    prefix "-" #major "." #minor "." #micro "-" #tag TYPE_MACHINE_SUFFIX
+
+#define MACHINE_VER_TYPE_NAME(prefix, ...) \
+    _MACHINE_VER_PICK(__VA_ARGS__, \
+                      _MACHINE_VER_TYPE_NAME5, \
+                      _MACHINE_VER_TYPE_NAME4, \
+                      _MACHINE_VER_TYPE_NAME3, \
+                      _MACHINE_VER_TYPE_NAME2) (prefix, __VA_ARGS__)
+
+/*
+ * Construct a name for a versioned machine type that is
+ * suitable for use as a C symbol (function/variable/etc).
+ *
+ * Can be invoked with various signatures
+ *
+ *  MACHINE_VER_SYM(sym, prefix, major, minor)
+ *  MACHINE_VER_SYM(sym, prefix, major, minor, micro)
+ *  MACHINE_VER_SYM(sym, prefix, major, minor, _, tag)
+ *  MACHINE_VER_SYM(sym, prefix, major, minor, micro, _, tag)
+ *
+ * Respectively emitting symbols with the format
+ *
+ *   {prefix}_machine_{major}_{minor}_{sym}
+ *   {prefix}_machine_{major}_{minor}_{micro}_{sym}
+ *   {prefix}_machine_{major}_{minor}_{tag}_{sym}
+ *   {prefix}_machine_{major}_{minor}_{micro}_{tag}_{sym}
+ */
+#define _MACHINE_VER_SYM2(sym, prefix, major, minor) \
+    prefix ## _machine_ ## major ## _ ## minor ## _ ## sym
+
+#define _MACHINE_VER_SYM3(sym, prefix, major, minor, micro) \
+    prefix ## _machine_ ## major ## _ ## minor ## _ ## micro ## _ ## sym
+
+#define _MACHINE_VER_SYM4(sym, prefix, major, minor, _unused_, tag) \
+    prefix ## _machine_ ## major ## _ ## minor ## _ ## tag ## _ ## sym
+
+#define _MACHINE_VER_SYM5(sym, prefix, major, minor, micro, _unused_, tag) \
+    prefix ## _machine_ ## major ## _ ## minor ## _ ## micro ## _ ## tag ## _ ## sym
+
+#define MACHINE_VER_SYM(sym, prefix, ...) \
+    _MACHINE_VER_PICK(__VA_ARGS__, \
+                      _MACHINE_VER_SYM5, \
+                      _MACHINE_VER_SYM4, \
+                      _MACHINE_VER_SYM3, \
+                      _MACHINE_VER_SYM2) (sym, prefix, __VA_ARGS__)
+
+
 #define DEFINE_MACHINE(namestr, machine_initfn) \
     static void machine_initfn##_class_init(ObjectClass *oc, void *data) \
     { \
-- 
2.41.0


