Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929DEC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L3o-0003Wd-1i; Fri, 25 Apr 2025 11:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L36-0002Up-VU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L34-0004Fs-Vt
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:08 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so2344476f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595185; x=1746199985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqk7e3dGx7CJXFSaqvVkA1/+tCz7O32ERJEBzKdBZF4=;
 b=CKodLjK5o3NbXUzCx2CVVEwDSc/NW8O+oNLpJenbalOprF+AF31YbJRYQJDF638l6u
 j340oTvdnByAEIE4OW7PwpqlF1nYICgJYu+MEthJ9geFtdjCYiHLzIx9tamtn/UGHJHH
 brYjGgLRnBWV0fUNdHT51jtnhVMXuiEbWnKaEs4DIiZ7j2AYcWSV/VLJw56LcbCIBZbz
 454jZG5bQncaPz6L4LPe7v7hRUrD4aY5cFl5g15ATHELvkFYZ2LrW9MTC7nJ64L8PXIp
 5JRhAPBaQvCtKovRxejlEsS0VGCpgn9glGrvelLKLI7b5ygHCsQyUvG+xoQQH9hj/Wkx
 lqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595185; x=1746199985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqk7e3dGx7CJXFSaqvVkA1/+tCz7O32ERJEBzKdBZF4=;
 b=ou/GWUKq6Vyg13SJ+v84CPG4LOFJHa85mQlDWb3bh9V7/4xennkzqN/XKG/i8hC8Jn
 9Ic6U2fE2hZMzRS8Y6LpCUK4ruZttOsFKcZPC8Wpmx5DCu2USUf6FWk8uJ7yEnIIoWge
 fRWYezmPqSBAot/eekSf0v67ahC7Mimjdg3dUM1UI3sWDA/3EKEOv7tljNswEJrD98Ud
 P0wfm9cPdErXUTFE2L2pixExwqudtrjKAe9iKL39O7QqZrPxy9JxMDZ1izC2v+Usc6PN
 rapN4wMpx72a/VoS/2lxt7I0RxCImruizVyULY1nMpfl862Nca+mhRzsf4KcOGkgg/BL
 DaJg==
X-Gm-Message-State: AOJu0YwpqNHQY0nsAxrDGSUfQdN79JbKeKOQPLzVXC9268BqmtEtXhLI
 Aa/KJsTg36j/RUi2CDYLBzEArjG3+uB9dhqUHhof+ChEGt9Fbi4kxJz2fd6Lz10U7+qav+Tclkz
 1
X-Gm-Gg: ASbGncsSb48+YLyke/QR5hLW+8+AkFgEVMVMYkwGLOvEPoWF9d6lB6SmO0jwf8k2DHA
 4m7Db3+H+EYdKWI6x6v3elQD36DXY+lyC3J9ZZ8IHIh7UufTY8lSW70G3zxh/ozHEZOOsA/5ji3
 C6EswDbzufzyxkNsv/X3QHfUQ3UlG6yESCkmTJHLPOS/O0/R+19bqqXFcXIKH/esUtSXbYt/OKw
 vq626N5eY+qjMgWhyajlN04lsx2Em4kjJgEzrJU/y/PN+Ura93RaR63oTbVNVkEqmYB/hvR1J9r
 8B3r7mr6ZrWh4qCKWnyVs9M7SKhYVb6rBBEN4OqgpWWPdXHobHTjZ16rftgGjQAprrs+NGSWqT7
 V7N5+wGF7pBOt7Ww=
X-Google-Smtp-Source: AGHT+IEy32pHnY6WfjyACYZvGapVH6DVXR50TOaDPLmeuEY6OsAik/TeWla/IEiCPYcPhm0V9dbTMw==
X-Received: by 2002:adf:e0c5:0:b0:39e:cbcf:9dad with SMTP id
 ffacd0b85a97d-3a074e1eb8emr2086938f8f.20.1745595185165; 
 Fri, 25 Apr 2025 08:33:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5debsm2716105f8f.38.2025.04.25.08.33.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:33:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 53/58] cpus: Move target-agnostic methods out of cpu-target.c
Date: Fri, 25 Apr 2025 17:28:37 +0200
Message-ID: <20250425152843.69638-54-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Various methods of cpu-target.c don't use any target-specific
knowledge at all and can be built once in the target-agnostic
cpu-common.c file.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250417165430.58213-4-philmd@linaro.org>
---
 cpu-target.c         | 77 +-------------------------------------------
 hw/core/cpu-common.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 76 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index c2dd590d48a..b5645ff0dbb 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -19,94 +19,19 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "qapi/error.h"
-#include "qemu/error-report.h"
-#include "qemu/qemu-print.h"
-#include "qemu/target-info.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
 #include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/log.h"
-#include "accel/accel-cpu-target.h"
+#include "hw/core/cpu.h"
 #include "trace/trace-root.h"
 
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
-char *cpu_model_from_type(const char *typename)
-{
-    g_autofree char *suffix = g_strdup_printf("-%s", target_cpu_type());
-
-    if (!object_class_by_name(typename)) {
-        return NULL;
-    }
-
-    if (g_str_has_suffix(typename, suffix)) {
-        return g_strndup(typename, strlen(typename) - strlen(suffix));
-    }
-
-    return g_strdup(typename);
-}
-
-const char *parse_cpu_option(const char *cpu_option)
-{
-    ObjectClass *oc;
-    CPUClass *cc;
-    gchar **model_pieces;
-    const char *cpu_type;
-
-    model_pieces = g_strsplit(cpu_option, ",", 2);
-    if (!model_pieces[0]) {
-        error_report("-cpu option cannot be empty");
-        exit(1);
-    }
-
-    oc = cpu_class_by_name(target_cpu_type(), model_pieces[0]);
-    if (oc == NULL) {
-        error_report("unable to find CPU model '%s'", model_pieces[0]);
-        g_strfreev(model_pieces);
-        exit(EXIT_FAILURE);
-    }
-
-    cpu_type = object_class_get_name(oc);
-    cc = CPU_CLASS(oc);
-    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
-    g_strfreev(model_pieces);
-    return cpu_type;
-}
-
-static void cpu_list_entry(gpointer data, gpointer user_data)
-{
-    CPUClass *cc = CPU_CLASS(OBJECT_CLASS(data));
-    const char *typename = object_class_get_name(OBJECT_CLASS(data));
-    g_autofree char *model = cpu_model_from_type(typename);
-
-    if (cc->deprecation_note) {
-        qemu_printf("  %s (deprecated)\n", model);
-    } else {
-        qemu_printf("  %s\n", model);
-    }
-}
-
-void list_cpus(void)
-{
-    CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
-
-    if (cc->list_cpus) {
-        cc->list_cpus();
-    } else {
-        GSList *list;
-
-        list = object_class_get_list_sorted(TYPE_CPU, false);
-        qemu_printf("Available CPUs:\n");
-        g_slist_foreach(list, cpu_list_entry, NULL);
-        g_slist_free(list);
-    }
-}
-
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
    CPU loop after each instruction */
 void cpu_single_step(CPUState *cpu, int enabled)
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 1fb6ea38922..92c40b6bf83 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -25,6 +25,9 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/lockcnt.h"
+#include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
+#include "qemu/target-info.h"
 #include "exec/log.h"
 #include "exec/gdbstub.h"
 #include "system/tcg.h"
@@ -152,6 +155,21 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
     return NULL;
 }
 
+char *cpu_model_from_type(const char *typename)
+{
+    g_autofree char *suffix = g_strdup_printf("-%s", target_cpu_type());
+
+    if (!object_class_by_name(typename)) {
+        return NULL;
+    }
+
+    if (g_str_has_suffix(typename, suffix)) {
+        return g_strndup(typename, strlen(typename) - strlen(suffix));
+    }
+
+    return g_strdup(typename);
+}
+
 static void cpu_common_parse_features(const char *typename, char *features,
                                       Error **errp)
 {
@@ -183,6 +201,33 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
 }
 
+const char *parse_cpu_option(const char *cpu_option)
+{
+    ObjectClass *oc;
+    CPUClass *cc;
+    gchar **model_pieces;
+    const char *cpu_type;
+
+    model_pieces = g_strsplit(cpu_option, ",", 2);
+    if (!model_pieces[0]) {
+        error_report("-cpu option cannot be empty");
+        exit(1);
+    }
+
+    oc = cpu_class_by_name(target_cpu_type(), model_pieces[0]);
+    if (oc == NULL) {
+        error_report("unable to find CPU model '%s'", model_pieces[0]);
+        g_strfreev(model_pieces);
+        exit(EXIT_FAILURE);
+    }
+
+    cpu_type = object_class_get_name(oc);
+    cc = CPU_CLASS(oc);
+    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
+    g_strfreev(model_pieces);
+    return cpu_type;
+}
+
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
 {
     if (!accel_cpu_common_realize(cpu, errp)) {
@@ -359,3 +404,32 @@ static void cpu_register_types(void)
 }
 
 type_init(cpu_register_types)
+
+static void cpu_list_entry(gpointer data, gpointer user_data)
+{
+    CPUClass *cc = CPU_CLASS(OBJECT_CLASS(data));
+    const char *typename = object_class_get_name(OBJECT_CLASS(data));
+    g_autofree char *model = cpu_model_from_type(typename);
+
+    if (cc->deprecation_note) {
+        qemu_printf("  %s (deprecated)\n", model);
+    } else {
+        qemu_printf("  %s\n", model);
+    }
+}
+
+void list_cpus(void)
+{
+    CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
+
+    if (cc->list_cpus) {
+        cc->list_cpus();
+    } else {
+        GSList *list;
+
+        list = object_class_get_list_sorted(TYPE_CPU, false);
+        qemu_printf("Available CPUs:\n");
+        g_slist_foreach(list, cpu_list_entry, NULL);
+        g_slist_free(list);
+    }
+}
-- 
2.47.1


