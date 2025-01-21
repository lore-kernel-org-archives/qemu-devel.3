Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4FBC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdC-0004y9-SO; Tue, 21 Jan 2025 06:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdA-0004xW-Mq
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:16 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCd8-0003MX-N0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so38219165e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459672; x=1738064472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+sqenivOKOaIj/HGMbrfNMWNgVlPE7OSpRM12hfj2M=;
 b=tTVdLzTKZmAbxkkEyQRTJd180XusWURGXeTV9v1oQF3nzcQe/9ayODKiBLtup74tFH
 PGJsHaC/EAytYXrLegp0xBCNT+stc8i5tSPY2kW8lTe9rkntbBA2fQjkNCb+CCSgL5Om
 k0H6LbkBcOzdqPfy1YQDRoy9AK6GMlRFE8N579vrAdD/xKcs/c72xcaTO9YqbBIGjjhv
 JEfNZkud9BtZbV8epRLjhoRp4ySTEH2DSubYSPZ5DJH0d1BMR4sSc4Irb4nRNmUCu/o/
 sZfiX9dcGOOuxnvrV3qs2L5kGJSoOej1Lbr6Be7WMvPMO8Kj31UY+LQjXzsMf+EF9pwY
 DtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459672; x=1738064472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+sqenivOKOaIj/HGMbrfNMWNgVlPE7OSpRM12hfj2M=;
 b=UwQSL9qBJi1Ta4cfhcmS+hQ/7Cmzhb4PckW9XpPtkFg9BWdJZtHxs+LlX3+6x/J/8F
 t4u7pzBNVPKXKUEjGQFOHBGNiyEYThAfCJBJbBchVABDhMJvwctczuQ4QZUr/rVoAgQe
 zHc9LyGfdksLhUhY7uGUq4vOOdxfhwHQCYWCdSNA8DIKkai2tIQ6ZGS7kN/kMvNWpDKs
 XVH9HKSQmenku2lRQanN+50HNRLf5Pvc6qUkG0mDhJn8cNeRx6kswb6glP0MifAFKA9f
 Umt7lfp90hWI3lkJX3iWeZScHpkTmS+KVnWgK9yFC6v1kkRVb0TB8MVhGy5oiv8BmuIS
 0ewQ==
X-Gm-Message-State: AOJu0YzBpuv3/r2RRl7wHKdHtCUHyy/31EuFMSuJq5SwuPsWFRybCPw9
 GjqOjV8YXxiItvEWbZYWJyys47D/pydAbQobEsfT8q/sp+npBu/FsnAZSU/NrWiecFLoXgKnzNa
 nhsU=
X-Gm-Gg: ASbGncv0WFCgBbfzcVKiv5t8BuaLd8U6JCZ8cqRVTPHsxgi4ksWneb/FFwrKw69pyeA
 Hyvpf+r97iNav2/4n9ujMRm3uhB9WGK1fdudzFv10vOwVZ2e0rCQu8SxFaKi/T7hP7V6LTx/oU9
 V+d+/T9FiZyrOcZegv3c4hXA+Pwa2PzXmiY77U1SIp0ghogzxBhar4BAD2yUBPFkDT9YrcwGnNP
 gkDlPQVE2VEXSc41q/MjOXKMjhIo+INWyLjHYi9WEurbVsxcISnpfIGhEkK4EudwBd4ELNP6NLw
 vmr38xJAYc3cJImlSK0QVpJ4Bt4Nh0Y0p+PlLjt5TQGr
X-Google-Smtp-Source: AGHT+IFAV++RtKn1KotX+3ii/fxqKc/fb8NWI3UzdXKs0eo21SJuKzQB4kr02Ht3HAyC4Lmg9PLMTg==
X-Received: by 2002:a05:600c:138f:b0:436:ed50:4f8a with SMTP id
 5b1f17b1804b1-438913caeb9mr178310015e9.10.1737459672025; 
 Tue, 21 Jan 2025 03:41:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c1664e8dsm179961565e9.1.2025.01.21.03.41.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:41:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/11] accel: Prefer cached CpuClass over CPU_GET_CLASS() macro
Date: Tue, 21 Jan 2025 12:40:48 +0100
Message-ID: <20250121114056.53949-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121114056.53949-1-philmd@linaro.org>
References: <20250121114056.53949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/accel-target.c      | 12 +++++-------
 accel/tcg/tcg-accel-ops.c |  3 +--
 accel/tcg/translate-all.c |  2 +-
 accel/tcg/watchpoint.c    |  9 ++++-----
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/accel/accel-target.c b/accel/accel-target.c
index 08626c00c2d..8a16c0c3ae0 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -112,22 +112,20 @@ void accel_init_interfaces(AccelClass *ac)
 
 void accel_cpu_instance_init(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->accel_cpu && cc->accel_cpu->cpu_instance_init) {
-        cc->accel_cpu->cpu_instance_init(cpu);
+    if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
+        cpu->cc->accel_cpu->cpu_instance_init(cpu);
     }
 }
 
 bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     /* target specific realization */
-    if (cc->accel_cpu && cc->accel_cpu->cpu_target_realize
-        && !cc->accel_cpu->cpu_target_realize(cpu, errp)) {
+    if (cpu->cc->accel_cpu
+        && cpu->cc->accel_cpu->cpu_target_realize
+        && !cpu->cc->accel_cpu->cpu_target_realize(cpu, errp)) {
         return false;
     }
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6e3f1fa92b2..299d6176cfb 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -120,10 +120,9 @@ static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
         [GDB_WATCHPOINT_ACCESS] = BP_GDB | BP_MEM_ACCESS,
     };
 
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     int cputype = xlat[gdbtype];
 
-    if (cc->gdb_stop_before_watchpoint) {
+    if (cpu->cc->gdb_stop_before_watchpoint) {
         cputype |= BP_STOP_BEFORE_ACCESS;
     }
     return cputype;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d56ca13cddf..5a378cb0281 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -622,7 +622,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * to account for the re-execution of the branch.
      */
     n = 1;
-    cc = CPU_GET_CLASS(cpu);
+    cc = cpu->cc;
     if (cc->tcg_ops->io_recompile_replay_branch &&
         cc->tcg_ops->io_recompile_replay_branch(cpu, tb)) {
         cpu->neg.icount_decr.u16.low++;
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index af57d182d5b..52e550dec6b 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -69,7 +69,6 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, int flags, uintptr_t ra)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUWatchpoint *wp;
 
     assert(tcg_enabled());
@@ -85,9 +84,9 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
         return;
     }
 
-    if (cc->tcg_ops->adjust_watchpoint_address) {
+    if (cpu->cc->tcg_ops->adjust_watchpoint_address) {
         /* this is currently used only by ARM BE32 */
-        addr = cc->tcg_ops->adjust_watchpoint_address(cpu, addr, len);
+        addr = cpu->cc->tcg_ops->adjust_watchpoint_address(cpu, addr, len);
     }
 
     assert((flags & ~BP_MEM_ACCESS) == 0);
@@ -119,8 +118,8 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
             wp->hitattrs = attrs;
 
             if (wp->flags & BP_CPU
-                && cc->tcg_ops->debug_check_watchpoint
-                && !cc->tcg_ops->debug_check_watchpoint(cpu, wp)) {
+                && cpu->cc->tcg_ops->debug_check_watchpoint
+                && !cpu->cc->tcg_ops->debug_check_watchpoint(cpu, wp)) {
                 wp->flags &= ~BP_WATCHPOINT_HIT;
                 continue;
             }
-- 
2.47.1


