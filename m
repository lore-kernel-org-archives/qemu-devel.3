Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EE7F531E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRhc-0006rl-Ii; Mon, 13 Apr 2026 20:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhb-0006c3-78
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhY-0003OO-KW
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d01d6b50cso5066479f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126742; x=1776731542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yf0UOppZ5JAgjvZrWj0IpmyixhCJmn1cGuxvSP3WFgU=;
 b=p3H1mLNUPhuT4vzOw7pyTQpqcXf8kzI3nujN4Fda5Wp7hAGlQqldrFivXpAsTI/0nI
 WVJ+GOEzLFBH097I/N2SWkjZWAszor+sgsfCY7x5g5ZpEI4TBVqBgsKO/g6bvejYhjqG
 X5lQAIRyDivBMgUdvX3Ga7ATqsVq+ApptmHEywAOCJPNPgXN2Gu6lcnw8Uik/CvMHA9e
 s3/5cbOVLOI2onVdiUEWcutuq2B83i7LkbRod8JSWfio6ZiP/98vNdJ4pvKQ0ei29L3L
 tslXVSEgin8+dQGu+9gUtfW3UXzAbPpbGHsz6fP17+WAf18vdc9MGsCE6F6nRhCBEvII
 OJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126742; x=1776731542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yf0UOppZ5JAgjvZrWj0IpmyixhCJmn1cGuxvSP3WFgU=;
 b=Imk5xvjB3i8auBzEiMQPiWc1xhtf3/VC4BxZNs1DGbx4gnX7NE7pRaSmSSkEToLKS+
 ELffB89DH7IT/zpy6jW4FfhdeKYE0vfwJvFDR4S8IYGfDRScevFVk+TWrf5d8mIPxMIk
 5Cea+f9ZBVN4dciDBFKVj8j9Z1Iudp14afLHgEzv+TpYYmQUl5HLhvrdyl9JrVAOLTaK
 jZBEtcvcSE33thafL8IDvWZ1YeKCpZUCNgD1DsZWv0pvaG1u5fGNC8zUZPR4cOiK1LLB
 31YMOeXGM9B/daS87ZWE7CwTvyL1NXrRWe9e/uNG4RekKU+MyIerVJgK8HwgmMck2eY+
 P4hg==
X-Gm-Message-State: AOJu0YzQGkbr7EZMAW0XHwu+wAXIB1dXD9Qb7cZZBtxybzO2ZimrVIYD
 41TZJQREy0RIQtnb7twycKwnoc0gzyi+qedTJcTB0cNG346aEhHCUHJmkLYVcxqy2G2nDEUmiIN
 Da1yz6R8=
X-Gm-Gg: AeBDiesMKBkSis0IH3acAPxXaX05pTOgsYZ/wiGI8+nxKuC8PqYNKOWY6NVabovb+Gm
 kFsaoEcvqpHTy6KvLqQhFpzGV4bAY/7KTLcuDYbOunilgaM2NuMd8NRKuiJZpLE5Ga2BxfNx8Ka
 bv+Z/Bn9TXA2s/9BUnPJU3bpE0LmFXORG9zl6zeymh81UKdKjmdG/GdOkcb8IqCubxzZhBbFnHz
 fok+V1BH5Jjvsy+4uOYNQoWkXhD3H+5OzN6tkyTRHqyZRWcfFzbvy/QOdXGn1MGZZ5QGk4EGeRI
 cwlu5qVcjvZEtPDu/bgk+jfmSYevNwUo+YT3BlkLlfgq6XI1kL/g/ZO5n7FbtYQw1mi4OKZsEyK
 AnSv3NIKU5obBsfXKgGhjOxnmN3qiXnptojPyxzqMIM75un2nFXgM/JHfDvlsLPvUvSWzC2+6WO
 zh1wZVefioNV1c3SzYcAeNW+MBy+C9iX5SEPyviSPxFvHYafFKHA5KS74Efi5nOfKF0So/9FqR
X-Received: by 2002:a5d:64e9:0:b0:43d:76d8:5794 with SMTP id
 ffacd0b85a97d-43d76d8593emr10892707f8f.36.1776126742333; 
 Mon, 13 Apr 2026 17:32:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7b219576sm9619728f8f.19.2026.04.13.17.32.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:32:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 19/27] monitor: Reduce target-specific methods further
Date: Tue, 14 Apr 2026 02:29:51 +0200
Message-ID: <20260414003001.97571-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

get_monitor_def() doesn't use any target-specific declaration
anymore, move it to hmp.c to compile it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 monitor/monitor-internal.h |  1 -
 monitor/hmp-target.c       | 33 ---------------------------------
 monitor/hmp.c              | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index eaf9a607783..a5c4aba306e 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -191,7 +191,6 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index c2ddcd67e51..550a7178052 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -57,39 +57,6 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
     return info_command ? hmp_info_cmds : hmp_cmds;
 }
 
-/*
- * Set @pval to the value in the register identified by @name.
- * return 0 if OK, -1 if not found
- */
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
-{
-    const MonitorDef *md = target_monitor_defs();
-    CPUState *cs = mon_get_cpu(mon);
-    void *ptr;
-
-    if (cs == NULL || md == NULL) {
-        return -1;
-    }
-
-    for(; md->name != NULL; md++) {
-        if (hmp_compare_cmd(name, md->name)) {
-            if (md->get_value) {
-                *pval = md->get_value(mon, md, md->offset);
-            } else {
-                CPUArchState *env = mon_get_cpu_env(mon);
-                ptr = (uint8_t *)env + md->offset;
-                *pval = *(int32_t *)ptr;
-            }
-            return 0;
-        }
-    }
-
-    if (!cs->cc->sysemu_ops->monitor_get_register) {
-        return -1;
-    }
-    return cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
-}
-
 static int
 compare_mon_cmd(const void *a, const void *b)
 {
diff --git a/monitor/hmp.c b/monitor/hmp.c
index e881c26c305..618ded40207 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include <dirent.h>
 #include "hw/core/qdev.h"
+#include "hw/core/sysemu-cpu-ops.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
@@ -359,6 +360,8 @@ static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
 static const char *pch;
 static sigjmp_buf expr_env;
 
+static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
+
 static G_NORETURN G_GNUC_PRINTF(2, 3)
 void expr_error(Monitor *mon, const char *fmt, ...)
 {
@@ -1599,3 +1602,36 @@ void monitor_register_hmp_info_hrt(const char *name,
     }
     g_assert_not_reached();
 }
+
+/*
+ * Set @pval to the value in the register identified by @name.
+ * return 0 if OK, -1 if not found
+ */
+static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
+{
+    const MonitorDef *md = target_monitor_defs();
+    CPUState *cs = mon_get_cpu(mon);
+    void *ptr;
+
+    if (cs == NULL || md == NULL) {
+        return -1;
+    }
+
+    for(; md->name != NULL; md++) {
+        if (hmp_compare_cmd(name, md->name)) {
+            if (md->get_value) {
+                *pval = md->get_value(mon, md, md->offset);
+            } else {
+                CPUArchState *env = mon_get_cpu_env(mon);
+                ptr = (uint8_t *)env + md->offset;
+                *pval = *(int32_t *)ptr;
+            }
+            return 0;
+        }
+    }
+
+    if (!cs->cc->sysemu_ops->monitor_get_register) {
+        return -1;
+    }
+    return cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
+}
-- 
2.53.0


