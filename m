Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E08CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrE-0000ZS-NF; Wed, 06 May 2026 10:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqF-0007rF-Jt
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqC-0000zw-PU
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso55422855e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076186; x=1778680986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z1Lz3snRDZps6xEPaL3FOpR5bACe7einw41sePh+gEE=;
 b=bKwMqzSvp5PDWRB/DoCqBkRo9AAkD2q6d2nLicfqVEz1LRkVewPZdU2vd+bqbvhE8X
 SUo8IFRMr681ZS6t1wl0iWM9aV3LWI79/ZbQEVn1JQoL3z/6o51WZ181wyTc5pQwXLWS
 l92RGG3uq73PSTDpWiLTKOVU7fFhq2mFLQUnil1yi0HsGeDeIT4v113DiOEk9vXon87w
 NuAmt6ua9fvgxKqt1yTlbvRFPefDp6F9Y4U1V5bD1vxa+sPlawdCfJ926Bk4iPPa7Q5F
 HPD6NqOlNAr4sXogwHT+ZTyA9XCilT5HE/R5+uPNo12XAedTilgjYs8v9F2Mt+Pj5vDn
 ukqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076186; x=1778680986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z1Lz3snRDZps6xEPaL3FOpR5bACe7einw41sePh+gEE=;
 b=pEmUBu0LCPgd8H5qFMtHMI7GPFAtZi4H12fIp4EaQQYfLMqdaBoudFg1hf6CeXafNG
 jkdmkUccB7X0JRbAgKF3MvBXMGpjKalRd44HNyIt9nXhLYFJF5IW6DqvR5hqmfmcqafq
 O9HpwjpvNtDrTiP7Fwt1hVy+YguTsI1nLEQhP+ZXpGjERwp9h42PtnGPlXA9NHCofSJ2
 Kc5+4rLrZLC4svUsKadx8r69wiEAQ6EzCk8H+llpNaTqaGGiZMlTgF3PTx76W7ATG72T
 dWuMRzUH1/rD/zZ8DyVjVFH4NlcwrQJm+cNCZLwdw1V1rHc/dzkWPIgg0COlChrOgwks
 CDHA==
X-Gm-Message-State: AOJu0YxsjND9hbnHJjoezG4ZNGGURJrX8W6C818FvWQ5tfl6ZKfzGBKw
 2qAom1R6mIsf4EdouTyVU0CVM0In5N/wAbliPME+P2KCFX5hcy+/XohE+EAO0YoSnfw3DP5hHjT
 zfIqdtlA=
X-Gm-Gg: AeBDiesIrUrRqIexeOlUfym5HNU3m+EzRBk94FTZwe2K1wPsTaTFs9K8t109Xw88umW
 Nrxfkgt64iTjAcRXhm8aJM7vwzWtEc5roBSlLuHypqzNz/f11nYxe96dRl/m8Jtmtw2eFYNkpWo
 9qne1fqt8/OBKrqQVGoRBuCBnAM+M0Vv8BfzLjHpHBKQtiNEcrf5xn4xgXUMjZ6RLJENbFBZ7sQ
 XVme4ZY3Rv7P94iwC+O3FE1vRq9U2Xde8bs02PghhtE5icpBYMQDf+BlrV7AercxNdOIwUsQ0Fr
 5iRSRlW9DwkUaYWxZKpvF4oCU4yKe2TuJ+J4YVCa6IdOFwQKFzjYFkbp19R9wGLuybgldkqqO8F
 L3os4NCmKQh52AyYrebY9dVl0EyoMkDIfJVgdoZJIsTxxTT3MRAgbDul9dgnFRfAs4Ck56p85tt
 FjxFxO9nir0CFGZS0RJwyYweiFtb7CkJU8QcCwn8D618t/vVDqiVF5brdFdHoTuqP6V4TDCyiqo
 ZYRZ31qTS8=
X-Received: by 2002:a05:600c:8485:b0:489:ecee:c4ef with SMTP id
 5b1f17b1804b1-48e51f2f874mr66555805e9.13.1778076185935; 
 Wed, 06 May 2026 07:03:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530c1e84sm18231685e9.10.2026.05.06.07.03.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:03:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 059/110] monitor: Reduce target-specific methods further
Date: Wed,  6 May 2026 15:54:31 +0200
Message-ID: <20260506135524.20617-60-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260427080738.77138-24-philmd@linaro.org>
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
index e881c26c305..fe2f5560013 100644
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
+    for (; md->name != NULL; md++) {
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


