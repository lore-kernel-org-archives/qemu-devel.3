Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9437C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Kr-0007y2-VM; Fri, 15 Mar 2024 09:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7K1-0006NK-Gq
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:07 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Jy-0007rc-Kp
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:04 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56845954fffso1900392a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508200; x=1711113000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQB6SJNy6yiy7zdv0lmI6ciVyOB2Uy024AmMoGafIwE=;
 b=D5Yow0ZKecc+XgV8kl3Fxp2klHV9pOvF/G2+ZI/Djby9UEMTStT24gk1yvGump1MJl
 MKkrD+pkP5pgDTJKhudDNevRLhRgSs8PL4pZTd9G2sUePI8EJeOlCBlHwT3IYYF4ZRs6
 JhCpKZMNSbP+/r3huUOKAf4M65t39X3AXyvKeobTfq26PlElFA8WMhLT78gKOOx6o8f6
 +bOlu3ydmRnzoSTUxtJZ5ZxmQukqNdodiuZZr1d3hf09n1YlCzoUgbAErfivYRvpS0Ry
 AFY6o61+Hnh5gRH9HeSGysOrs0zqx8bQd3t/Yar2vGrzZh5JGovLdA6puQxfIqt+cJNy
 9t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508200; x=1711113000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQB6SJNy6yiy7zdv0lmI6ciVyOB2Uy024AmMoGafIwE=;
 b=wA1Q06FQydF8JKpdbbJbtDNth5nHHsAEPR6LxXv2+0KdnJtQXJIYmeZjZc9ANkPhdh
 IAcnML/fnAKkzzJ7RicTogA7oHVMH+kmolD0QZE1gexSQlIkQFnSHKqwuY1+z0pZrefE
 v1uUDRZQb4PQ2otGN4aXcw+7yKb7MN5DadKLV3XLENfPhth/EdS502Pn2dETK+FrCSks
 eXmLEA21i4v7bb9Ecd/rDejIIMQPxeBFiYQ1HZNclYh64CDztqcMSX1QPOK+l1lsDbZV
 NukM4eUR7W43HxFhYbX7GNLqlhkKwvSGD0ohI0tHlIZjRdD4gaiM9I6gWs0FiUoa+OCL
 F85Q==
X-Gm-Message-State: AOJu0YwRshe073NO21WeonKAJ5m7Th7pwTIrjqHFmQtkTuOJMPN9zIYa
 sF559hWTs+LkcO0gzpvuD7G1lIxpd/gnsxU3X1oEn12Ti5YvdidJauAfo1wlS1lABrrZbNpdIAD
 c
X-Google-Smtp-Source: AGHT+IERNJD9BeD1ZTNKcgjKR1YrxbrTZMT90NVR2wKIdl/tZTRzhcTVHamLl8tpd/LjDM8xLQUvNQ==
X-Received: by 2002:aa7:dd0f:0:b0:565:b456:435d with SMTP id
 i15-20020aa7dd0f000000b00565b456435dmr2931558edv.17.1710508200588; 
 Fri, 15 Mar 2024 06:10:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 q10-20020aa7d44a000000b005689d0a97d1sm1657891edr.24.2024.03.15.06.09.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:10:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH-for-9.1 07/21] target/mips: Make MIPS_CPU common to new
 MIPS32_CPU / MIPS64_CPU types
Date: Fri, 15 Mar 2024 14:08:55 +0100
Message-ID: <20240315130910.15750-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

"target/foo/cpu-qom.h" can not use any target specific definitions.

Currently "target/mips/cpu-qom.h" defines TYPE_MIPS_CPU depending
on the mips(32)/mips64 build type. This doesn't scale in a
heterogeneous context where we need to access both types concurrently.

In order to do that, introduce the new MIPS32_CPU / MIPS64_CPU types,
both inheriting a common TYPE_MIPS_CPU base type.

Keep the current CPU types registered in mips_register_cpudef_type()
as 32 or 64-bit, but instead of depending on the binary built being
targeting 32/64-bit, check whether the CPU is 64-bit by looking at
the CPU_MIPS64 bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu-qom.h              | 13 +++++++------
 target/mips/cpu.c                  | 11 ++++++++++-
 target/mips/sysemu/mips-qmp-cmds.c | 26 ++------------------------
 3 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
index 0eea2a2598..bf464f16b6 100644
--- a/target/mips/cpu-qom.h
+++ b/target/mips/cpu-qom.h
@@ -1,5 +1,5 @@
 /*
- * QEMU MIPS CPU
+ * QEMU MIPS CPU QOM header (target agnostic)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -22,14 +22,15 @@
 
 #include "hw/core/cpu.h"
 
-#ifdef TARGET_MIPS64
-#define TYPE_MIPS_CPU "mips64-cpu"
-#else
-#define TYPE_MIPS_CPU "mips-cpu"
-#endif
+#define TYPE_MIPS_CPU   "mips-cpu"
+#define TYPE_MIPS32_CPU "mips32-cpu"
+#define TYPE_MIPS64_CPU "mips64-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
 
+OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
+OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
+
 #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
 #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c096d97fe3..f3ea6175f2 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -604,6 +604,14 @@ static const TypeInfo mips_cpu_types[] = {
         .abstract       = true,
         .class_size     = sizeof(MIPSCPUClass),
         .class_init     = mips_cpu_class_init,
+    }, {
+        .name           = TYPE_MIPS32_CPU,
+        .parent         = TYPE_MIPS_CPU,
+        .abstract       = true,
+    }, {
+        .name           = TYPE_MIPS64_CPU,
+        .parent         = TYPE_MIPS_CPU,
+        .abstract       = true,
     }
 };
 
@@ -620,7 +628,8 @@ static void mips_register_cpudef_type(const struct mips_def_t *def)
     char *typename = mips_cpu_type_name(def->name);
     TypeInfo ti = {
         .name = typename,
-        .parent = TYPE_MIPS_CPU,
+        .parent = def->insn_flags & CPU_MIPS64
+                  ? TYPE_MIPS64_CPU : TYPE_MIPS32_CPU,
         .class_init = mips_cpu_cpudef_class_init,
         .class_data = (void *)def,
     };
diff --git a/target/mips/sysemu/mips-qmp-cmds.c b/target/mips/sysemu/mips-qmp-cmds.c
index 7340ac70ba..329db3a028 100644
--- a/target/mips/sysemu/mips-qmp-cmds.c
+++ b/target/mips/sysemu/mips-qmp-cmds.c
@@ -8,31 +8,9 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qapi-commands-machine-target.h"
-#include "cpu.h"
-
-static void mips_cpu_add_definition(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc = data;
-    CpuDefinitionInfoList **cpu_list = user_data;
-    CpuDefinitionInfo *info;
-    const char *typename;
-
-    typename = object_class_get_name(oc);
-    info = g_malloc0(sizeof(*info));
-    info->name = cpu_model_from_type(typename);
-    info->q_typename = g_strdup(typename);
-
-    QAPI_LIST_PREPEND(*cpu_list, info);
-}
+#include "qapi/commands-target-compat.h"
 
 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
-    CpuDefinitionInfoList *cpu_list = NULL;
-    GSList *list;
-
-    list = object_class_get_list(TYPE_MIPS_CPU, false);
-    g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
-    g_slist_free(list);
-
-    return cpu_list;
+    return generic_query_cpu_definitions(errp);
 }
-- 
2.41.0


