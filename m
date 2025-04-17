Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF44C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SVo-0008Q8-Tl; Thu, 17 Apr 2025 12:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVm-0008Pq-Pp
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:54:50 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVk-0003ea-Nf
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:54:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so7523865e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744908887; x=1745513687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gV7lZ9LvpVHHnLSxUzbfdoyaXXwA7dhZN1N6bxGXYI=;
 b=gSgxSsRgo9UUji3B+hUL/4Q6ogRmW5YHsL0PuRjFvRfbQo7eAhYHeUzHiTkWlzBrpS
 ZYEt1XUODu8her62Bzf95XYMpD0dP7LSLKNaDIuhLOMi6nZxrTbHqBP8Hy9ZrPl736Of
 1JQf0lFE6FIGnQUOAIBBAiunHHKTaoghA7qoO110M6JCYj4ZtROEE3ZuqX1q5UmAu4yc
 KVY8lBv0jX4mM0+2SarF1iSr2a92EoWJJSqbycFqrHRdDpswHXDFWSVkJxrzRzKyyiJR
 4HmZwl4pf2umL9i7z3XQfPnRY1d8LQlQ9nSFgOc2zVYuFOh4eYKxPTvcg+FIAoBPCwOi
 aidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744908887; x=1745513687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gV7lZ9LvpVHHnLSxUzbfdoyaXXwA7dhZN1N6bxGXYI=;
 b=Hrfrt4fcvt1HsBZkaEtT2DHgsUhDmPz+hxHWEq7d9r2WLQVZEE3OOAK0TVGlOJlyys
 ahVtGfAIMxs6zf/tp6g9Pqd/BN/TbeYimNurnkE1XNEPFEQhYqc5HDWKkcL42LSPmr8o
 RaXBtiAVCsNdTcQTazBRUutWHTezW9jWV+4iotoMQtZMIyg8Sis34zU3HJS8b2U0Rx9k
 /wARRy9v1+3ovE9tyyimeZpngYcW19SNrqaV8bSyACJbBy0Ucqeq7DvwWBwsPePYpsqJ
 ZSSOZyHDK+TU8Zevfnwu+QZdLaHxza62qjfYhp9cxRBBWmk0QFl4rkIlULiYPYrH+ZY9
 pq/Q==
X-Gm-Message-State: AOJu0YymyUZRM5imMs2VUvdw8NZeG2HJhWdYJ1Dt3W+WWqCD4Nub5C8v
 HhlE/kTYGHP9wsLsCYKX/FUEndb+cCZGYxbjgbiO4g2iVoah4BD+ERupVl3clh5k7Pf8YIbuD5G
 a
X-Gm-Gg: ASbGncsl5gm7yoLrdOOpODLnCxc8xopDW7fzTjj1dh/hNc9QLRw7JeQDbVxuGW33rhT
 KqsH744xk6y3Jj9hknRQ89flvGD08PAyfDmkGVChF1F+0ITTWhlZZJ3zUQUFVE8GJ3aa9Cv9yKD
 Ul7FGC27mREeacu+LeLLuM5KCl20AzihBN8q5eTnrQDxtuEjgKezkMvRvZ0wWjkOvKGgdhCBr7j
 MJHeoQcovmPIZeZcn4fLKctdRf35/t/FCyd9mVndy2DASsDpb26uA1rt2ARfvLL+UktqXuvdFiU
 JxMOJ1C2FRVKPomV5P+pg4gdd12YFVjx532XaMqgu7cOlS/shJBDKmtJE/aQOB7dE7V3d5KYxK9
 FjgbEnNh5dtxCiTA=
X-Google-Smtp-Source: AGHT+IE+KUaTsN3G+W80LGQijplCT/PigNz6TIjDqS2ugf1OiPwus0CKx8JXZUCrJksU4WFELDl2mQ==
X-Received: by 2002:a05:600c:4fd0:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-44069640aa3mr6464695e9.0.1744908886724; 
 Thu, 17 Apr 2025 09:54:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406994a362sm4801995e9.16.2025.04.17.09.54.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 09:54:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 3/7] cpus: Move target-agnostic methods out of cpu-target.c
Date: Thu, 17 Apr 2025 18:54:26 +0200
Message-ID: <20250417165430.58213-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417165430.58213-1-philmd@linaro.org>
References: <20250417165430.58213-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
---
 cpu-target.c         | 77 +-------------------------------------------
 hw/core/cpu-common.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 76 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 1779bb5337d..e018acbf71a 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -19,94 +19,19 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "qapi/error.h"
-#include "qemu/error-report.h"
-#include "qemu/qemu-print.h"
-#include "qemu/target_info.h"
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
index 9064dd24f82..6d0788331c7 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -25,6 +25,9 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/lockcnt.h"
+#include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
+#include "qemu/target_info.h"
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


