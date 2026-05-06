Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C38CCD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcvT-0003KI-Au; Wed, 06 May 2026 10:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvK-0002hj-Rc
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvH-00025k-6u
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so61664005e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076500; x=1778681300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9RICF6DM7j3DDPVVqH7dOlS6B3hpcugv7s9C+BNqulg=;
 b=huk8nzuR7fqGPQU+oXcNqt8ivg/qm3YRSWqu6+bc9dP2Y8IDCxhCmedp0DL+W5HXZe
 Lp2iNRJeEopWxWXcxvCxXXorrQKnGqTMkzpu7/rxxSPi5tH0bEdKfwLVEfGM/make/65
 vnqRXJd7QqzN6r9OTBfk8x7OIh1SGXnxBvUeQ4RszdZXxmrkOXqKaQPqkUESuzsUMiju
 8nzGPbfxgJrR5UwqEfCEp9YA250vx/Bbp8MkooXQvFlUKT5vvfsO2dF9fdbG6oIRpJ+R
 ZhuPLvdHysdqglKiRv4XYfkfroOPU5q7yY4JJ+xo6rHzQ7UktCCA3zt7Mc4Hmw8YNCHm
 FtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076500; x=1778681300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9RICF6DM7j3DDPVVqH7dOlS6B3hpcugv7s9C+BNqulg=;
 b=kY26ihqQGX67kus/zLIfLBZJMMzwt0Eml2Qvc66Z2eJK/1WuFV6IGTPCLHAe8XQuvs
 lmK4vbTvXJpWkLGpoUvDAtUh8wv7RvcK6LWJ+9qzsTMxAWBR6Dpn28c7aCWOCFLiCe3K
 DlhkdGuVpmJKpLOMIpvZxKAuxyel60Advg6oNkJqqjtb6D06jk1uZA6GIZ4E4fx2tyMH
 sypXewpCX0oPxUb4iGQVzdL8eovvBW0TCDRYjI/ttu7Opp0pNiN10O93Mv3IGb0Wf4iv
 plUgrynnRw3PQR7uHOq69B4gBx1iv2aUAnst2jkNT+NV7cdHBuXGoVQXu+Rk7/m++ZGP
 9yGw==
X-Gm-Message-State: AOJu0YwWIQTlyBKH1pt7045QYCDzYQW/ooMalqDiRt8D/m83buAMlmqB
 Z2xNE1OU4z9mbcxHhxV+m+esy1sn03imCDP/9+5x/7RlKBZnKQOfvDM35Qx0KimH6ZnBwVlZ02x
 hB+24LDY=
X-Gm-Gg: AeBDievOiVx2rA6uVRilcSy5DRmj7vZHYgF510774ykeziVBlq51nAX//BB/D5SFlW5
 B/SzOiLAZKCtFNgVCOLBfTnndS2FjeDyJJlIeE6x+xtsB+5uQ7rYNevxFBu/9CfXDEMBMHkIbkj
 r+wCifsaH3lbMZdKBrKgictA2mAw3uCj+Gb8Rqc6WJYUiH9AT9nSdVmPgIpYQChHfsZap3FRtgl
 BBVrK2LALucPa2+ULLPl0LQnvyeWGidfeCh1eXeYs0VzFH/itmCoNvaV/3qxJo9HsAoH+MJGjOs
 d8/rQJgH3bYJkLfVhe5wDWDCKGajcgNm60p2Zv7OGMiu0u0AqC+kzE2yJ4Lp/eDV0WYL0U7Pcec
 b1Bec+0HUeKMmllHX/kpMow1pumgEccAqnptTO1dPGTOPEQB8X5OpJieeCrUtXZsov1Q50WEJbS
 D+I15l2RzLrZcaiy9RJz2kXANrC3UawOBCbr3YAm9dywG/6B5IpASJj4SEhYZ24sSpmLx5+j7/X
 7uYxSOuCdM=
X-Received: by 2002:a05:600c:8485:b0:488:af7f:775f with SMTP id
 5b1f17b1804b1-48e51f32a64mr67493085e9.18.1778076500488; 
 Wed, 06 May 2026 07:08:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5313b023sm28452585e9.5.2026.05.06.07.08.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:08:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 098/110] target/mips: Do not initialize variable used by
 CPU_FOREACH macro
Date: Wed,  6 May 2026 15:55:10 +0200
Message-ID: <20260506135524.20617-99-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The CPU_FOREACH() macro, defined in "hw/core/cpu.h",
ends up calling QTAILQ_FOREACH_RCU() which always
assigns its iterator variable when entering the loop.
Remove the pointless and possibly misleading assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260415215539.92629-7-philmd@linaro.org>
---
 target/mips/internal.h              | 2 +-
 hw/misc/mips_cpc.c                  | 4 ++--
 target/mips/tcg/system/cp0_helper.c | 8 ++++----
 target/mips/tcg/system/tlb_helper.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 2fd5ffa304a..23e1ada1852 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -280,7 +280,7 @@ static inline int mips_vpe_active(CPUMIPSState *env)
 
 static inline int mips_vp_active(CPUMIPSState *env)
 {
-    CPUState *cs = first_cpu;
+    CPUState *cs;
 
     /* Check if the VP disabled other VPs (which means the VP is enabled) */
     if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 9d9c8bf6ec8..9ce37514d5b 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -45,7 +45,7 @@ static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
 
 static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_run)
 {
-    CPUState *cs = first_cpu;
+    CPUState *cs;
 
     CPU_FOREACH(cs) {
         uint64_t i = 1ULL << cs->cpu_index;
@@ -63,7 +63,7 @@ static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_run)
 
 static void cpc_stop_vp(MIPSCPCState *cpc, uint64_t vp_stop)
 {
-    CPUState *cs = first_cpu;
+    CPUState *cs;
 
     CPU_FOREACH(cs) {
         uint64_t i = 1ULL << cs->cpu_index;
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 8b83ba16399..ba6b487b751 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -1570,7 +1570,7 @@ target_ulong helper_dvpe(CPUMIPSState *env)
     target_ulong prev = cpu->mvp->CP0_MVPControl;
 
     if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
-        CPUState *cs = first_cpu;
+        CPUState *cs;
 
         CPU_FOREACH(cs) {
             MIPSCPU *other_cpu = MIPS_CPU(cs);
@@ -1590,7 +1590,7 @@ target_ulong helper_evpe(CPUMIPSState *env)
     target_ulong prev = cpu->mvp->CP0_MVPControl;
 
     if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
-        CPUState *cs = first_cpu;
+        CPUState *cs;
 
         CPU_FOREACH(cs) {
             MIPSCPU *other_cpu = MIPS_CPU(cs);
@@ -1613,7 +1613,7 @@ target_ulong helper_dvp(CPUMIPSState *env)
     target_ulong prev = env->CP0_VPControl;
 
     if (!((env->CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
-        CPUState *cpu = first_cpu;
+        CPUState *cpu;
 
         CPU_FOREACH(cpu) {
             MIPSCPU *other_cpu = MIPS_CPU(cpu);
@@ -1632,7 +1632,7 @@ target_ulong helper_evp(CPUMIPSState *env)
     target_ulong prev = env->CP0_VPControl;
 
     if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
-        CPUState *cpu = first_cpu;
+        CPUState *cpu;
 
         CPU_FOREACH(cpu) {
             MIPSCPU *other_cpu = MIPS_CPU(cpu);
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 45cbeb40a2d..c850ddd9650 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -346,7 +346,7 @@ void helper_ginvt(CPUMIPSState *env, target_ulong arg, uint32_t type)
     uint32_t invMsgVPN2 = arg & (TARGET_PAGE_MASK << 1);
     uint8_t invMsgR = 0;
     uint32_t invMsgMMid = env->CP0_MemoryMapID;
-    CPUState *cpu = first_cpu;
+    CPUState *cpu;
 
 #ifdef TARGET_MIPS64
     invMsgR = extract64(arg, 62, 2);
-- 
2.53.0


