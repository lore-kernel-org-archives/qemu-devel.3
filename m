Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94995F531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRi3-0000LL-TH; Mon, 13 Apr 2026 20:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRi2-0000KW-Rk
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRi1-0003Rf-9G
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso41172535e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126771; x=1776731571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxLEbMZsZkzsDTrSuMDqm5sZgfXseQNGksHS6C02fq4=;
 b=GnKbDW+VrUbCy8fUAEH+TPOo69e78WgfE9LBx5IjGxovN7j1SfJYXELIfjREVM6ghX
 mwWizmmzVVPtdT8CExjZ6fVD1NLuXR5eWqv2MQdJ7zMqezMMn7yl6ToI8VptT2yQxLl2
 gitBWzvS5UZA/o9c9Yn2IYqt5TNzI/mr0jelV1G7+ZO7DGkpJ42eNW5H9F9r3UqhyxrM
 qm6Y7GNXznoFL6T9FcO/FdiJpH5XkUcywyK14OB6j4n2ZtVrV1JPGoHoA9p//wf1my9O
 Hud+/kTmnpSrYxurw/dsKr//fdWQGQneORISnaD18+NkAj1/HZE+oc6T+t1d0KDk/wrQ
 R71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126771; x=1776731571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rxLEbMZsZkzsDTrSuMDqm5sZgfXseQNGksHS6C02fq4=;
 b=MKAjhNVgA/dwrwMzuerkBRHbCcVdYXRL75Fm7ywyuSjttR234sbiOQ+LICBwqqlAiJ
 GE1VtsRyJrjNqh8MVCVqqVG7/2zW2JN6p8BqXN4N5n789/bD1bNhsCf/Gg5iLELoPei3
 keFlad5RaEmSvP8NhMxXp08/9916WIBpwgAmxkQi+QOmAkXnNv0KYvkPD6XWRd1NRDKb
 Aq3q5lPt1CEHVolG+b1l8CgOfJHeLmdAqWW8BtU1I2f9iFRwSI3ogfTljZZZQanV/MIN
 GyvGnUmSevyXq0ka8hjDluwzlrGre+Zj2b+zdlyuOVR+JhjrFEQw2ruk04GcoKENYu1Z
 vc3g==
X-Gm-Message-State: AOJu0Yy1ZvAKD29W/XWGfTl0jdXkL/NL7WqfciKfT1VLBSxnoMBTeuPp
 98k3FXZ5tSwgNktSRqGx7wOwVidkBl8vSvKgL7PK2HExvif+LCeCUNAzjT1kwZ9VTQBm8+hhqDy
 GO843I+g=
X-Gm-Gg: AeBDievtS51p4Kher7hxrxqZsQUUAk8BdNTV/r+fKvaR6XwPQ7a++uWSLx1EsDFpbnl
 s7mcczqKqW6nnNmizJ5PXK4mqtLHgWbqz9FBREfLj8kcq4B/iawpcn69bJDH+BDilHEXhBQDhPu
 wMbGBVaNAsmNwwl67FnZpfZ5Lbk0NudPmDDTgQgAbyKSVsVun5opjsTrQYUxiMMVqctyTG4nKNz
 Ni4XRtjLi4Tqu+l6r++YjlanosQpPseO6eSfHmmrG/9FOFKE4D0jyIril/rS8ZUHioG79t+voja
 teLGJw7GC+UsHIQwCUXGK+8JVHhAuZxPbYERC2wZAuvEZruIUx8UAFnpCJ9HCdSRWeAR6+RpJ5C
 74naF0v23vwt3eHv42fb3mWMrK5B7ITkjTZMM9xKlDwlh/lBaVBiA98nQBWl/DfJHewlCEEckv3
 FdqSjS/8uiYxMETntM3wIxCOzjit9FIhdewbDtGzHk5XybCVyEckdN2ESGM6zUj2bQe8uAHL2v
X-Received: by 2002:a05:600c:8883:b0:488:b87b:3052 with SMTP id
 5b1f17b1804b1-488d689b400mr157810815e9.29.1776126771428; 
 Mon, 13 Apr 2026 17:32:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d681ecd5sm109676535e9.19.2026.04.13.17.32.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:32:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 23/27] target/i386: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Tue, 14 Apr 2026 02:29:55 +0200
Message-ID: <20260414003001.97571-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Restrict x86_monitor_defs[] to cpu.c, register it as
SysemuCPUOps::monitor_defs hook, allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.c     | 29 +++++++++++++++++++++++++++++
 target/i386/monitor.c | 30 ------------------------------
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6fd1dc00eb..4cb8c627295 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -39,6 +39,7 @@
 #include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "confidential-guest.h"
+#include "monitor/hmp.h"
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine.h"
 #include "system/address-spaces.h"
@@ -10685,6 +10686,33 @@ static const Property x86_cpu_properties[] = {
 };
 
 #ifndef CONFIG_USER_ONLY
+
+static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                              int offset)
+{
+    CPUArchState *env = mon_get_cpu_env(mon);
+    int64_t ret = env->eip + env->segs[R_CS].base;
+
+    if (!(env->hflags & HF_CS64_MASK)) {
+        ret = (int32_t)ret;
+    }
+    return ret;
+}
+
+static const MonitorDef x86_monitor_defs[] = {
+#define SEG(name, seg) \
+    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
+    SEG("cs", R_CS)
+    SEG("ds", R_DS)
+    SEG("es", R_ES)
+    SEG("ss", R_SS)
+    SEG("fs", R_FS)
+    SEG("gs", R_GS)
+    { "pc", 0, monitor_get_pc, },
+    { NULL },
+#undef SEG
+};
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
@@ -10698,6 +10726,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
+    .monitor_defs = x86_monitor_defs,
     .legacy_vmsd = &vmstate_x86_cpu,
 };
 #endif
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 1befb8ea824..a536712c755 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -591,33 +591,3 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
                            flags);
     }
 }
-
-static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                              int offset)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    int64_t ret = env->eip + env->segs[R_CS].base;
-
-    if (!(env->hflags & HF_CS64_MASK)) {
-        ret = (int32_t)ret;
-    }
-    return ret;
-}
-
-const MonitorDef monitor_defs[] = {
-#define SEG(name, seg) \
-    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
-    SEG("cs", R_CS)
-    SEG("ds", R_DS)
-    SEG("es", R_ES)
-    SEG("ss", R_SS)
-    SEG("fs", R_FS)
-    SEG("gs", R_GS)
-    { "pc", 0, monitor_get_pc, },
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0


