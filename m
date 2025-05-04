Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3945C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgP2-0008Sf-M8; Sun, 04 May 2025 16:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOo-0008LT-Bq
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOl-0006w1-M8
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so33323475ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392238; x=1746997038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsdvHpchZn7w+VdOLQ7CzBJ1Jp1aOUnFam9iiXyOn7g=;
 b=yoErwMQIiiP/vNND36mfQn3JfwLhfPuM4W7LuOE0IeSfICkUcm5KMqrfXSXO97MInO
 pdPOoJMnZ5W+uugm4xSiOmhelUiWtamdkFkCQWAVaDGfQlMFmegKQXl44DKcLvghQo9V
 VkG4PHRLS1CzFr1CwkZpedD3NWWGqObzZMuiqf1Is2Mr5iBCp9aIqi4oldmgdZGQufXi
 LD8Y1ELcLGiM2KEZUYtFTr7k3BdZ4K/0YyrVVTFji77PxzTLb1KiEt37e7/dgM1s3yty
 EtijlnpcloKS6XXOmRMAUDXndT6c4gQkXbnYG9ilMk63EShcwaw/TYISNb/pUvzogZOd
 o/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392238; x=1746997038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsdvHpchZn7w+VdOLQ7CzBJ1Jp1aOUnFam9iiXyOn7g=;
 b=Ghs/nDFqxPfG+RIVIQv9y5SVjDyfEwFp1o27AICphJ1m8+ho6iseZuPGd7Sk12oC5L
 +1L2RXHBYuODGu+4l5LbOibU4F35F1bzSjsntxpIRew/t6FGBGfXqIsyPXKDn+xM8/Je
 CsCv/Kuw/9F4GpsBiC4A61DDL4UWc89swHhWMtIT3+VjeiyVTBlfSpMqlU3xvpY8loZ9
 cmhQA6K9Ibjo2r0PcBK9TVwn9rLj4rzwl8DaA256GgY59Xsnl1j8O/WpQDlp+eV6p6c2
 NBv0irBNNTHM1472uv2mRZNeTFOY3aGpPPpLAzOpqB9oe7AuutBlswKCVLw6ucgtbIP1
 037g==
X-Gm-Message-State: AOJu0Yx0+7uW/9zrTvehQ3ymPvJWzTerZyPpYpLSXwdc7ag42d1PmfmN
 XCwYHgJIxxwAPUWovb8v2GSO+frGxyiU63Vq9KrNd0P5HT7034SqsYAgCq/MrXtpQT5evJ2Dbxx
 F
X-Gm-Gg: ASbGnctmChcNrtE9omDULnTiJNyHfdctGHXSskwKUlpcpvhpgmmtsM9QzUlBYzpjtcA
 d6Zaal+2AU4MGmOSxOpM9c9N6uJzXw//kMUa+DlM7UnmdjFWH1xUth1zXPbiFGLZW5FCmfXbqlx
 qnewE1y45i/o9kuG/UT3IcSCJaxOlL8N/45cQh38RSr+85NOMZDbNg0guHwcPLV6KlVJwYKrn7A
 rfCoQH6wAZvOPNqmaYxkvaQAoaOqXhvX3nDszSFjJ0RiQWH8CkECXnjR8qpYnSGmnzRKSg8DHK+
 MybsDXBrDAprNRFCGHeHLCYznKCg3kHRxQ+xoccsx61q0H+Q9FASZIa/TLpP4ZSqsqmvzTbk2yY
 =
X-Google-Smtp-Source: AGHT+IG1rV+L7hTnDkD9euGmORKdSUNI2i8oFJCxAQVj0dEAJ6QYwBRPVdcNgvE6/CrFWNvMdcZvKw==
X-Received: by 2002:a17:903:98d:b0:226:3392:3704 with SMTP id
 d9443c01a7336-22e1007aa81mr169779475ad.12.1746392238175; 
 Sun, 04 May 2025 13:57:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com, Michael Rolnik <mrolnik@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 03/12] target: Use cpu_pointer_wrap_uint32 for 32-bit targets
Date: Sun,  4 May 2025 13:57:04 -0700
Message-ID: <20250504205714.3432096-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

M68K, MicroBlaze, OpenRISC, RX, TriCore and Xtensa are
all 32-bit targets.  AVR is more complicated, but using
a 32-bit wrap preserves current behaviour.

Cc: Michael Rolnik <mrolnik@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 1 +
 accel/tcg/cputlb.c          | 6 ++++++
 target/avr/cpu.c            | 6 ++++++
 target/m68k/cpu.c           | 1 +
 target/microblaze/cpu.c     | 1 +
 target/openrisc/cpu.c       | 1 +
 target/rx/cpu.c             | 1 +
 target/tricore/cpu.c        | 1 +
 target/xtensa/cpu.c         | 1 +
 9 files changed, 19 insertions(+)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 4f3b4fd3bc..dd8ea30016 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -326,6 +326,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
  * Common pointer_wrap implementations.
  */
 vaddr cpu_pointer_wrap_notreached(CPUState *, int, vaddr, vaddr);
+vaddr cpu_pointer_wrap_uint32(CPUState *, int, vaddr, vaddr);
 
 #endif
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 75cd875948..022d555f48 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2945,3 +2945,9 @@ vaddr cpu_pointer_wrap_notreached(CPUState *cs, int idx, vaddr res, vaddr base)
 {
     g_assert_not_reached();
 }
+
+/* To be used for strict 32-bit targets. */
+vaddr cpu_pointer_wrap_uint32(CPUState *cs, int idx, vaddr res, vaddr base)
+{
+    return (uint32_t)res;
+}
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 250241541b..6995de6a12 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -250,6 +250,12 @@ static const TCGCPUOps avr_tcg_ops = {
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
+    /*
+     * TODO: code and data wrapping are different, but for the most part
+     * AVR only references bytes or aligned code fetches.  But we use
+     * non-aligned MO_16 accesses for stack push/pop.
+     */
+    .pointer_wrap = cpu_pointer_wrap_uint32,
 };
 
 static void avr_cpu_class_init(ObjectClass *oc, const void *data)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index c5196a612e..6a09db3a6f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -619,6 +619,7 @@ static const TCGCPUOps m68k_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
     .cpu_exec_halt = m68k_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index d069e40e70..5eff1610c2 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -449,6 +449,7 @@ static const TCGCPUOps mb_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
     .cpu_exec_halt = mb_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 054ad33360..dfbb2df643 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -265,6 +265,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
     .cpu_exec_halt = openrisc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 36eba75545..c6dd5d6f83 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -225,6 +225,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .restore_state_to_opc = rx_restore_state_to_opc,
     .mmu_index = rx_cpu_mmu_index,
     .tlb_fill = rx_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
     .cpu_exec_halt = rx_cpu_has_work,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index e56f90fde9..4f035b6f76 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -190,6 +190,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .restore_state_to_opc = tricore_restore_state_to_opc,
     .mmu_index = tricore_cpu_mmu_index,
     .tlb_fill = tricore_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 91b71b6caa..ea9b6df3aa 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -318,6 +318,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
     .cpu_exec_halt = xtensa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


