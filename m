Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E707C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKpb-0005Ec-SG; Sun, 09 Mar 2025 13:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpW-0005DH-GT
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpU-0004r3-RS
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso2906360f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542767; x=1742147567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CMUkgiylTgPg6Rg8E626l7jCXafLoryj7tcACx1jVGw=;
 b=UEcxdfsOuvUkXNvls43CL7XUk4Bn9MJofO7q0ICGW6GlqbqsnssjYrJMfHmOmlamW7
 YwXIhSGrXZfrUB6ICQKihT7wD+Bv4YqHyByo8DWWI0OyeIV89HV0GznwMuYiV8vaxWB3
 Z3SqNi7jd/2+oKCJ+WPeH/y8TQJgyXd0/GyFYa/fIkJonPoanSDPjRkf+IOi16j63CJR
 /42Gt/f6qVjyfbzuoGEW1AjuDn9KvlAlwvwnBis8T6nFhpsdqTm91darWoXLOrDMn9+q
 MdkLRGvwNJliDRUrCXRjjJ6J0uSro7yhp3TGMZu3Xni65qk27G3SqRMgcvwdbaGZZ92I
 LOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542767; x=1742147567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CMUkgiylTgPg6Rg8E626l7jCXafLoryj7tcACx1jVGw=;
 b=TmagvIkaT/lbWPuIh4tQbl1Sc1whmLZ+zciPKijxmXIUxnZFRRdV34TOm8AStNe60+
 VpZjnDlO2ufTkcGXB1weKocLbU/XrAqUHxEinq4PoEbWhpwjk1IM+88Vrrla5merg4ye
 ePlfSTvf6923cCR3zjWUKq/rToea1ESBKU01Atk72n6KaEeD9reJtDI8OGWGJyy5eXe9
 XD952VdGVle1bMxPiO9CSihTvdv0RCL2Y3HSKKBIy8Z70YQP7HcH68Vc2vWmDkVgpXoV
 yByprQ6/gEY4+lQokczlko7KQ8/LE0RmisYV1opEM4qHLZQ/uIUj4ezBcrmclJRXyrBO
 ovXA==
X-Gm-Message-State: AOJu0YyK4FF8Zk7KUvzrBXTj0vBt6UZocdw9lYdgW7BB/ytLf7QqwR7F
 FTN6LYA+iaVYYz/YdMspBQF4jfjmJdxzDPrHtQ4DjdjKREc/mi47AyKd1du6BO6xoNXX3s+UMP6
 Wfe0=
X-Gm-Gg: ASbGncte9S9kAyYQstAfQz3Yov+AJoJ0WYiw2iJs18GMpB6iF0o/enhQoo4GevWMTOt
 RmSOmIEi2iT4FYfrMU0VUrMBwCqq9ErfNuG6gYQAlI/mQTDcGfkHOuC4SpnLBmgFy3Hs9IdHD8c
 e3V7i6BljA3DvpQZoVyhrxilM29K7Rmg2z1OA2JrvOaX/o/UvlBF8SBI2lLLUX59r1hb76SixzJ
 wDurzJbkNIZYqAhHNDxwXOI1RSf3dYQxyEN3WtI2LUSxY9X0wCzsXupXDT8VurW0pC1vKXebwL0
 /wltSh+agQIH8hVlT2p3EEuLb5TQjfBvcXGI//jyu3H80F7eMkFoPV4HzGYfus1f1XJvCGXpZCs
 hrVvb2NLlInPc+IjRjck=
X-Google-Smtp-Source: AGHT+IFORJZhDGyKX5RaKKRL6jYxap2Szj0hfI8u0GfJVs6u8Jxk9Mq7BuUfNNUVSniW+w25+e9jKQ==
X-Received: by 2002:a05:6000:1a86:b0:38f:2a32:abbb with SMTP id
 ffacd0b85a97d-39132d325c1mr5169237f8f.4.1741542766967; 
 Sun, 09 Mar 2025 10:52:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf680f4cesm15442585e9.35.2025.03.09.10.52.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/38] accel: Prefer cached CpuClass over CPU_GET_CLASS() macro
Date: Sun,  9 Mar 2025 18:51:37 +0100
Message-ID: <20250309175207.43828-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250122093028.52416-6-philmd@linaro.org>
---
 accel/accel-target.c      | 12 +++++-------
 accel/tcg/tcg-accel-ops.c |  3 +--
 accel/tcg/translate-all.c |  2 +-
 accel/tcg/watchpoint.c    |  9 ++++-----
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/accel/accel-target.c b/accel/accel-target.c
index 83587274626..33a539b4cbb 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -113,22 +113,20 @@ void accel_init_interfaces(AccelClass *ac)
 
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
index 53e580d128b..d9b662efe3b 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -121,10 +121,9 @@ static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
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
index 0914d6e98b2..82bc16bd535 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -630,7 +630,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * to account for the re-execution of the branch.
      */
     n = 1;
-    cc = CPU_GET_CLASS(cpu);
+    cc = cpu->cc;
     if (cc->tcg_ops->io_recompile_replay_branch &&
         cc->tcg_ops->io_recompile_replay_branch(cpu, tb)) {
         cpu->neg.icount_decr.u16.low++;
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index ba8c9859cf4..65b21884cec 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -68,7 +68,6 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, int flags, uintptr_t ra)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUWatchpoint *wp;
 
     assert(tcg_enabled());
@@ -84,9 +83,9 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
         return;
     }
 
-    if (cc->tcg_ops->adjust_watchpoint_address) {
+    if (cpu->cc->tcg_ops->adjust_watchpoint_address) {
         /* this is currently used only by ARM BE32 */
-        addr = cc->tcg_ops->adjust_watchpoint_address(cpu, addr, len);
+        addr = cpu->cc->tcg_ops->adjust_watchpoint_address(cpu, addr, len);
     }
 
     assert((flags & ~BP_MEM_ACCESS) == 0);
@@ -118,8 +117,8 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
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


