Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B1CC36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UKq-0002Fx-4Y; Thu, 03 Apr 2025 19:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKS-0001lA-1q
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:40 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKP-0000k0-Tt
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so1047868f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724232; x=1744329032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjLhp4LZOvkpDq4jQIYUOR+57wmLdvndO6f3N6bUc2k=;
 b=T3N3FYBC8v8lz0bcjwSeKUBsDHTwoLHz27f4XLXoVdRrowUPEx45fyU2pYn/zyAzF9
 5HyHm/Oz3xWxQE2ANMeV8fUFT3TmnZVlHUkO2EgKPT07ymJqf2EHlCcRY/T9nzgS1q9M
 yN2Qibn2svcG6a2SqPlmUu4mkOspU4exwQ3kvd08Pk0pxW8OAc5ESafdElU0XHwgFdWy
 zdVvKfDuKnsLU2WThD/5Os7Ns0qUrTVhLclbUCz923jLIR9uvg2kFzqkrKbk4XWoJG5X
 feiTIqk3IE1ESX3IEw/jQYhtYP34KnDLxSVkXqcSYjdluTgtN0KCkgvyrtAAaJV5gH/x
 GVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724232; x=1744329032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PjLhp4LZOvkpDq4jQIYUOR+57wmLdvndO6f3N6bUc2k=;
 b=o21CVDmZOr928ro9xrxyOl1Khlhfe1qJTuXB5ZxAkzwSKKgxgxSDUIkjymsDGJPhMQ
 omcGuDuIIF6reQnIbhm3LOz/8M30V6P/nLrzL3Psy2mkCS9XOCZetyyiYX+IayObIvlk
 6ql1wYEQA8geB5nBL+4l5MKuiSmtNVY+ybJjTX9IpCAwTy52n7JeVWSLZnk7eorXYpyz
 XAU2kXat/CjgwYKYFIsKDGJnSbLJaCjSowUiMTuFyVVZq2y4fMoiG1OeCNzBtQvcPHYz
 Oj33albN8MWC8zlFpgyN/7YEUa2nsXNnjUBMxk8/i9mCSmeOA+wNqgl4qDyUcXKzgvCL
 Dhkw==
X-Gm-Message-State: AOJu0YwZH/Vm44K/tFVs+fSYI+v1iRx3s/m0DiHRQX9+a9scsGDdVpGk
 iUdrax0tqjSTEJHJ2pUs9akVLE+KnJyhQSmazLFqltspUzTqofM6bcRAk0G+CmtsoPCDXXKsqle
 a
X-Gm-Gg: ASbGncui4UqnoH+eb6aHzQbtSHvvGLBU+of4o7Gf7BILOftWW2PglVukyVJ7B1gLzLE
 SzdnFGfjTeffxcdItm1DWZ+zlzRk4ee6RFgmMl0ly/j8p30p4kiNoD8gvHVpzyS4Fy2ShWbeQNZ
 5p+Xl6LyTF+hyaInOBSqYu6hBkTkeisb+is9Zp5a7RV5gQiv2ahcxvcOx3e0d5CR/6uHkQYAmWH
 BO2uGXT6kiUvbUuI3aTw/1sqCg4GHTPFH4TVhACvM2CQ34BpjNJYsB02xpR53sziktfmeR23L4N
 XnolPrBJAjAClIMo9ZPkFwaG7z7poQLeTOQ6Y4PWkDvnhGvtZKOszSXu7JQqhqJF9it9P3dCahl
 o3a4hru2wlCatRWoiphM=
X-Google-Smtp-Source: AGHT+IEhDmIXlSSU4qni49h/F5hbufBNGdD4meJb1tkY+fSvV2h3tueGAzbi2uDh0Px9KuP7byNiUw==
X-Received: by 2002:a05:6000:2481:b0:39c:f0d:9146 with SMTP id
 ffacd0b85a97d-39cba9368b5mr855120f8f.45.1743724231967; 
 Thu, 03 Apr 2025 16:50:31 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7225sm2963060f8f.26.2025.04.03.16.50.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:50:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 12/19] cpus: Move target-agnostic methods out of
 cpu-target.c
Date: Fri,  4 Apr 2025 01:49:07 +0200
Message-ID: <20250403234914.9154-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c         | 78 +-------------------------------------------
 hw/core/cpu-common.c | 74 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 77 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 01b0064b91f..20db5ff3108 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -19,94 +19,18 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "qapi/error.h"
-#include "qemu/error-report.h"
-#include "qemu/qemu-print.h"
-#include "qemu/target_info.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
-#include "exec/tswap.h"
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


