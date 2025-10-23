Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53661CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54d-0004T0-7H; Thu, 23 Oct 2025 19:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54c-0004R1-4F
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54a-0007Q3-6Z
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:25 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-27c369f8986so12020425ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263422; x=1761868222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qx6kJuJ+y2uonSR6j062ZvpEMgL6rrm991VyMn6kDgk=;
 b=fuLiuYHapuO8eLjxlAG6SXHql5Pnb+ATjpGqR4hPWXIYf84z90UfsRRQ5L6MhxwoG3
 LSiB4PsIz34s+ehEP2CV7IVbSfq3vM1BDFKyiPNL72zt4hC4jiz5HFImlO+z4rt2xwaK
 MyYZBPwqaKVtl8DeeB/KWAr+1vIAllDMIpgxC7vNuaOgfwInEyBLZ7ExYMRk8zzhrlUu
 NHFCNSlGOpjF24ymfY0yjnxQn3ILCHoSX7HLrD60MAwS8fZugw9e+JlMLPuYrjb9E5vD
 vq4p8Ks7NokFLFCFJMjonHOJecMVzPM0UQlVpxMQpK8VWTXGDqkbj4cvsYA490Rb4dzK
 nmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263422; x=1761868222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qx6kJuJ+y2uonSR6j062ZvpEMgL6rrm991VyMn6kDgk=;
 b=pYHxQ2Wmyxou9e0ofq+FQs9G0VPXIsOSlRHdgEhHzzzD2vbKjba7fbnkV31hYZ7DTu
 Jocxyl/QOgeFHvT0opKj+mnGR/1o1dYFKEyvFR59aapqyqoCcIh0qIwI673qx0N7/5A4
 yM9UaYBDzxiWV+v6TxdqtZL88WXvUMh0zLcLEvy8BW6BZTPDveu+G2rkGJ7eg6GYSJ8q
 uIi5W8EyKh6gBGenfEbxI75s9TUb0vFZM/x03N8B1fNzngvV9hP5mtn/DdDq6vBHRKHz
 4HZBR5ydcV26hGLRqHKgJIohqoYJ6ydHUemb6nS0Kh3RNDK+jrbzCe+VDMVQ1nRZS2pL
 4a4Q==
X-Gm-Message-State: AOJu0Yzh4jo9YEtYbExbpfYAA5qhrprwM0VH1XkTCSXG48jmBj3z3NOo
 eHQzvqzJrDXSAbM42qQe/G2VIRTnOEBtA+/DRsAlVu7SwdG/WJ/G3AfslJrUNA==
X-Gm-Gg: ASbGnctXAK8ilPWD/5umo+xegjKGbsPaXcFgyeTov9XqTsXdl9ntrBh6GoDgBMOjBjF
 4MD6PAb7kRf8FVBrumVPiLPDyFDG1p7xCSmI9OFSM0XDo189oCwcMfMpoqHzcSql33+1apHbIzc
 oLNDe3WuBA65F4blNvB7ZecQj6JpEd/ultWLMId58RAIK5k8H49fR/qxSc2J6tZrQWr0m1NFuOz
 1VKn8pqKt8wvlvSS3l0UCxlanII1EM4DM4c0sbGZ0ilyf83qGXIH4LrTBPFpBpSQLmxOh+uTyqu
 zX7KjkBGlqRrtYBE3UwUJXieyOeFwy1EAD7GSbWqsolVRdPguPZx7eJMqh87c5yAjN3FlGHvAXc
 1+GO3KSGnEi/x/sDd1ktMg/tdhkaj8SimBmg22r0mOiyosm0V+3hpD2N+F0PVrzsBxy74v7eMHm
 sMO7xBw6CHZLGYxZWArSvojdUInPkKNCLgcGUJ/Q69knpG8nlUTP6TkhbJz2mNiRWET24iLMkCY
 P+ZrahlKvmZX8ebdMUOwUFZzo15Kw==
X-Google-Smtp-Source: AGHT+IF/6A+epECSgfIcRYwSjARdK8rizBI2VsJKx5Cug9c6vKtgESd8gaOZuwnnCS7LHxRSpebL/Q==
X-Received: by 2002:a17:903:41c9:b0:282:eea8:764d with SMTP id
 d9443c01a7336-2948ba3c635mr2762625ad.35.1761263422172; 
 Thu, 23 Oct 2025 16:50:22 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 13/25] target/riscv: Introduce mo_endian_env() helper
Date: Fri, 24 Oct 2025 09:49:15 +1000
Message-ID: <20251023234927.1864284-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

mo_endian_env() returns the target endianness from CPUArchState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-14-philmd@linaro.org>
[ Changes by AF:
 - Only define mo_endian_env() for softmmu
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index c486f771d3..6ccc127c30 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -28,6 +28,20 @@
 #include "exec/tlb-flags.h"
 #include "trace.h"
 
+#ifndef CONFIG_USER_ONLY
+static inline MemOp mo_endian_env(CPURISCVState *env)
+{
+    /*
+     * A couple of bits in MSTATUS set the endianness:
+     *  - MSTATUS_UBE (User-mode),
+     *  - MSTATUS_SBE (Supervisor-mode),
+     *  - MSTATUS_MBE (Machine-mode)
+     * but we don't implement that yet.
+     */
+    return MO_TE;
+}
+#endif
+
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       RISCVException exception,
@@ -633,7 +647,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
 
     return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -642,7 +656,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
 
     return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -651,7 +665,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UQ, mmu_idx);
 
     return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -669,7 +683,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
 
     cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -678,7 +692,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
 
     cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -687,7 +701,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UQ, mmu_idx);
 
     cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -703,7 +717,7 @@ target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, true, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
 
     return cpu_ldw_code_mmu(env, addr, oi, GETPC());
 }
@@ -712,7 +726,7 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, true, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
 
     return cpu_ldl_code_mmu(env, addr, oi, ra);
 }
-- 
2.51.0


