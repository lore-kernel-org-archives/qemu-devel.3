Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE0DE8783F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHxk-0000Z4-A9; Tue, 03 Feb 2026 10:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxg-0000Vv-Rw
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:05 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxe-0001OH-Jx
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:04 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43596062728so598412f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131099; x=1770735899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xUztfZTO9Bj5kI5u2im5cSP6/lokB3CDs+dbm5suLgc=;
 b=jiH/rR70Lk7RsbcC4zEEflP7BoD2fxl1Ts5Fq4/WfW7n6eYvgzRJRQbyxS2CH8iVad
 gGUCeabmjCXsVKKJkZKavm60bYqECs55ilWirtCdJ+zPPVZ67wpZ0if36+/NmAwtjflR
 gR//x5Z+0z3ZpvIsaiEg9zMkvDPWIh+bqF3K5mZFbRZf5YgsEQoK8emTg18guPuxkLI0
 u7jLtOzag6QLCiFKWFgzVMT90+9UbPXZfhsjjIhmk5GnUb7+6LmYuC8VVUPa0k3NW4+8
 c/8vaxBynK4nlRw1s3+WdU99Bf923tmPMiDj301wC/NvDZ3IWY/y0vwjdw1DhiE8cSCO
 QTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131099; x=1770735899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xUztfZTO9Bj5kI5u2im5cSP6/lokB3CDs+dbm5suLgc=;
 b=GjRmoeGCqXAEDug8H0ZdPwNUBLQPQcOEudaYx0yf6K5wjgI4LmWxTT2iwom4emkrmn
 XK5T+Wivh4igllkK739Cos06aScf/YoS3wGNOUi9ojD1OTl9WP1KR5+gQngd6fym08E3
 AADrxRwsNJF+JNBfcWnKsN+6YQSiQbQQUxd34jufjPmK1ORxYmKOF/W3TQqGie/tUQaw
 Q8rlCNf1h8xTDec/Nr151ppKyUn1dmAnQh2fO/5xqIN5nIsHjVEpNlN1oVIAElbcZSj+
 1IKt1zh4Bqx9BJQe2iTJxmliaK22FbtbJzRjs26EjQ0/TvGTjH2tDEMlV06W46tqYSFO
 tRLQ==
X-Gm-Message-State: AOJu0YyphRiLGx/aPbF2wcnRNZp5rLwmXoo6xf82EyOtwYiihsEflTGq
 Y14RoK/MnMxye/RYpYOFnwFcMB6MjkiOtwkk1U/s8/p+UIXBJPv/LDdO/J32gRPt/kGjNXJAMMe
 j3obxt0A=
X-Gm-Gg: AZuq6aKqA2XOHXh277FVzvuoZi7XBAvaoZu7iCRCe4dXy3FCQvW47rGFFhXZSTHlicy
 QrONqWgdARgYpzJgzjAFzMQ7+kozodjalTzK+YsPWoME+/197HN7iAjrBSOSPdQto+bmy9TJMyj
 GsPCrqDq21bUDrezmh0GQLH++VcWif8/UNLAr8HvCS+wgRjW+xeaNhoSnC6zsLb4e95GhZpJgiQ
 rN4vonQPKiQKa5mDX9BcTyjGW7j2+J4FEjKYrv28GSWeAxvTY+NtnKa47j5A4hEbpixWGmrMUkd
 b0dL7jUghSqmVUSCT8gbliEJb7ShD4fjZv88n75QCXod1Vs2EQTBPEc93xEvqCux/OVgDry5g/6
 PTuw25q8H0vQhObASh8fKm5h7OdqwJAu+tsmrTbgFVlYULam6xyIH7V7MS3Rao9shUzhg1VPZGf
 26BXllKy5raux9NfjyhMok1ihEwQ4VbbGYGkyx7fwSKMuTIUXgi/3leSPZBzej
X-Received: by 2002:a05:6000:22c8:b0:42f:b555:5274 with SMTP id
 ffacd0b85a97d-43611447d87mr4981834f8f.20.1770131098830; 
 Tue, 03 Feb 2026 07:04:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322f40sm50752759f8f.34.2026.02.03.07.04.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:04:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/30] target/ppc: Inline cpu_ld/st_mmuidx_ra() calls in memory
 helpers
Date: Tue,  3 Feb 2026 16:04:08 +0100
Message-ID: <20260203150436.71907-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

In preparation of removing the cpu_ld*_mmuidx_ra() and
cpu_st*_mmuidx_ra() calls, inline them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260202210106.93257-3-philmd@linaro.org>
---
 target/ppc/mem_helper.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 636ad769a93..90546967593 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -88,8 +88,11 @@ void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
         }
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
+        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOpIdx oi = make_memop_idx(op, mmu_idx);
+
         for (; reg < 32; reg++) {
-            env->gpr[reg] = cpu_ldl_mmuidx_ra(env, addr, mmu_idx, raddr);
+            env->gpr[reg] = cpu_ldl_mmu(env, addr, oi, raddr);
             addr = addr_add(env, addr, 4);
         }
     }
@@ -111,7 +114,10 @@ void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
         for (; reg < 32; reg++) {
-            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
+            MemOp op = MO_TE | MO_UL | MO_UNALN;
+            MemOpIdx oi = make_memop_idx(op, mmu_idx);
+
+            cpu_stl_mmu(env, addr, env->gpr[reg], oi, raddr);
             addr = addr_add(env, addr, 4);
         }
     }
@@ -152,9 +158,12 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
+        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOpIdx oi = make_memop_idx(op, mmu_idx);
+
         /* Slow path -- at least some of the operation requires i/o.  */
         for (; nb > 3; nb -= 4) {
-            env->gpr[reg] = cpu_ldl_mmuidx_ra(env, addr, mmu_idx, raddr);
+            env->gpr[reg] = cpu_ldl_mmu(env, addr, oi, raddr);
             reg = (reg + 1) % 32;
             addr = addr_add(env, addr, 4);
         }
@@ -165,10 +174,14 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             val = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 24;
             break;
         case 2:
-            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            op = MO_TE | MO_UW | MO_UNALN;
+            oi = make_memop_idx(op, mmu_idx);
+            val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             break;
         case 3:
-            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            op = MO_TE | MO_UW | MO_UNALN;
+            oi = make_memop_idx(op, mmu_idx);
+            val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             addr = addr_add(env, addr, 2);
             val |= cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 8;
             break;
@@ -241,8 +254,11 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
+        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOpIdx oi = make_memop_idx(op, mmu_idx);
+
         for (; nb > 3; nb -= 4) {
-            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
+            cpu_stl_mmu(env, addr, env->gpr[reg], oi, raddr);
             reg = (reg + 1) % 32;
             addr = addr_add(env, addr, 4);
         }
@@ -252,10 +268,14 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
             break;
         case 2:
-            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            op = MO_TE | MO_UW | MO_UNALN;
+            oi = make_memop_idx(op, mmu_idx);
+            cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             break;
         case 3:
-            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            op = MO_TE | MO_UW | MO_UNALN;
+            oi = make_memop_idx(op, mmu_idx);
+            cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             addr = addr_add(env, addr, 2);
             cpu_stb_mmuidx_ra(env, addr, val >> 8, mmu_idx, raddr);
             break;
@@ -284,8 +304,11 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
     if (unlikely(!haddr)) {
         /* Slow path */
+        MemOp op = MO_TE | MO_UQ | MO_UNALN;
+        MemOpIdx oi = make_memop_idx(op, mmu_idx);
+
         for (int i = 0; i < dcbz_size; i += 8) {
-            cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
+            cpu_stq_mmu(env, addr + i, 0, oi, retaddr);
         }
         return;
     }
-- 
2.52.0


