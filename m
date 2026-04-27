Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C412FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH3N-0000bT-IC; Mon, 27 Apr 2026 04:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3J-0000RU-9K
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:49 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3H-0002ku-0m
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:48 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d73422431so9153233f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277445; x=1777882245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5IB1vvAJbcMlRA4A8vxRuUp8fkqXSVJfJBJpe4/kUNg=;
 b=ufqed5MRXbNEvkbLcavnZJHWqEeNoCUVkqtnVsV/7ku3Oa9JYDMzcDJnGw+QOiJdHa
 ItfG8xm8MJkEJmJ898lIn/W87A+3r2LNokHGhQsXyrgXXtCwg1Bg9eDr3UpvF7GsnE9a
 FVKeUjP1j9o3d/ZyEShoBZ3sjZXNseBotZpr6Bqa6YG3JjqFmYMP4yNNqtfDKWbzgZ6Q
 KFJMn8SYr0p6ExDO+WHxU/yFBfXN1u2AY9fBHQEixjFHgETlw1jjnioNdmYYXAf7WrBB
 RKbHoAfPmWni61bTqvaFp7uQHSVLQN8pOiBRlL8dEXakT2FPlfticS0fDQFci2VzrZN2
 ZdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277445; x=1777882245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5IB1vvAJbcMlRA4A8vxRuUp8fkqXSVJfJBJpe4/kUNg=;
 b=X2GKYSXfo2Gx+DJji4GzCK3/Ih82n8zM2iZN5i9sWddBpOl695aWgNuOpv35nKPTtX
 sXfN9nZlRc/Ai5/EHTxMm/xkdifMjmvT4McMMT/KJyQ5TzSPAEerDOWZ46ea68d0IhjS
 KMvzcjD9gOWR94iOZ1XVANl2fwQkjs/6D/NW82mvw7kHQgfYcT1XdRAOzuikEu+G8xi/
 c3OKn3Yg7RXudggWuVyx2ZqcyhWvqcmuX1L8nc8w4jJ0rqKOaB/4RUhVyeGS18kulGwh
 rAu2QADvdO/Q6IJU9hSHnl/pi5KVUrWTvs+Aiw0vp5/CL+Z6il8+HlopZTELzzOFtfps
 VYMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7CC70GOn1HpRRBRE9wal3N0NCpTNe0SW7tILu+Ush1mO3gzlPLj2hgOlyoZoP1GQ3DSEAeE5Hg0Kq@nongnu.org
X-Gm-Message-State: AOJu0YyxRJDxgOnqJsZvxId9qdPzYmK3G0kQcfAH2NxWAOb7wN9bcaf4
 7d8WaU1WWV0a8xwBlY60nv4MjDla6uwS5E4CbLSbozD8Hx6Zav+/p+dv0/MdB7qaGtDMoI7D8JH
 4S+PdG7I=
X-Gm-Gg: AeBDievpyfJAOjRs1TwXquIqYOM4vPTsJ/otrITQNjk9Pw+amJrA0ecfR6akAhQwQyv
 Vx3hfd+7pTlch/DZGDw27faLhR5OtnI0qq6pnhYkzoAuaNYPD87ebBd94EFjZ8IhJWrmK81+AgU
 32zLlF4VfjW9RGGkZoa9/2I1hcdEzX1uQfIIRY20RcfDWDLulGs/XNWY+859bYfy5V3VqaWY5s2
 yDdAe+xYKTQcpZ42ei0p5YxEFXG0RHuIA3DflHPYz5/u07Ig/OqFDnmHmSMC8jse0LiP5Px9z+k
 PE3ysY1TXeaXjnQN81icI57VZ4ApADjWTbAHl7W29H3AbNwcV6n1qwfm3fBJ4ZagcCORDrVBPOC
 tt6hZj5lvASUkMzEo5Vdb2Dtc4Nav23sRgNGZdNz8MjvvEfUtTs34vI5NP/LUZKxwZ13vIARIlw
 mNhIYw0MTKMlTQ3isIYApqMQ91xwdycmRM7HSmbTPiu3c5MBDwPpA1jWKWMJSr/OW/83Rvx2yi/
 Ldtf++wGiI=
X-Received: by 2002:a05:6000:18a5:b0:43c:ff58:35c3 with SMTP id
 ffacd0b85a97d-43fe3dc818fmr65953027f8f.10.1777277445162; 
 Mon, 27 Apr 2026 01:10:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412e36ff8bsm29899843f8f.26.2026.04.27.01.10.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:10:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 27/32] target/i386: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Mon, 27 Apr 2026 10:07:33 +0200
Message-ID: <20260427080738.77138-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
index 9d126600c05..d8e102dd1b9 100644
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
@@ -10686,6 +10687,33 @@ static const Property x86_cpu_properties[] = {
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
@@ -10699,6 +10727,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
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


