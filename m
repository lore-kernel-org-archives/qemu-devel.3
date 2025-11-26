Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E0CD1118E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM4G-0006ZF-HI; Wed, 26 Nov 2025 15:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3w-00062H-El
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:33 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3o-0002fz-U3
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so689085e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188657; x=1764793457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/DOfQD31qkMald+3OmhYsWbl0ISNPTLiwY4/obsMvFY=;
 b=COgtRYBfv7z491r2NSqmvUKhT7cUkJVz6Y7R7F896tXjS83/AmGMHKGcScEiqfsrct
 iKEy4C+FIh6bRJY+OVMMnLUNMMoDsrtIh0JQ7SL2YIBjfxO8ld+5VGfyCTO3h6oCjRYm
 o0PSOCrYCc3/3Pvp6KQiJmldUIJi9oC79LNJ0T7DsVoKRaZ/Ka6Vk9lKQCCNVJCYgXFL
 yk6uSAGCZyjZf7SJ4N/IfCrLkWmSagm/022krGpsEVsgn2DPZ9AQMUFSTkRUJgjFtdpd
 EVWYGPgcf3q/GOnbt87MDSx3CRg262IMZVI39H9fw2AhgO7QYLKcDcZ/6A+hdADM7Ls5
 E05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188657; x=1764793457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/DOfQD31qkMald+3OmhYsWbl0ISNPTLiwY4/obsMvFY=;
 b=Q6iQJqsU94ziGBUzv0gMAIw2O4makXuCVAx1EN+5IAdA8/Bh1KhPkR88eyd7FKfhFK
 s6JhqlUIDjdb86zam9HpAO9/tpXyA+DW3UeGvH+GEPnd/OqaCXNL2hs2II7HXn74BiOQ
 wYeKgN8GOJ5ELBNQr0y+RISQQ4cENJxh83NjBZeqR9kE/J3JZEZTiyDtEh1zSBOCP44O
 t6Rk8hjjrgHt5EN7SovGc9K4hbCpYrcCNIFXg9B//wuRj2xE2aPr5Vee+8pvnP4wnvdc
 /WtWXO28mRYYtBiaeKJaitdkeYugX5U72Auuy3eI75mP1mueK6G+gJMzz1QKQkhsl8cW
 cjtg==
X-Gm-Message-State: AOJu0YxE6DaVBltutM9UlwuUdn9VJ1FD0rCo+ndYLuwrc3gdR1bAsdUJ
 2NqadzRktEkxh7MkpuF81IpDzmwaNVpQplLCqGuhtEfIVeiF1xOYpGZoqCzZ81y+fXjh1nktWr4
 t5MJDW+oMjzsa
X-Gm-Gg: ASbGncvVmsD/FWZaUi+eIwIdzzdVCwbrKG5LAoKMI1lt7GiSdfNcGXt77mG/ifzZUxQ
 ymOomaFKpCX9bQMoVWCsL0IS5k5xMkr5CFGHBHLTvd8zPFRpD+/74UkTfgA8GOkFGqI3PUfLhZZ
 G9ZS2g0EVs+ewt+venZoC7PbedTnff+8N5py0QNbJ5PRCw2/xzKikIiWzwVonqL8plMQ2akaxle
 DysL12ReMqeeBJnlD/0F7bHG+iWWOSMuLEhVhWNTSmlGcuJ1fwDA2y0WWolqXs+BDplWN9fZQGo
 zmHF9NXI0xK9eWB3KDgtEGyCdQoLod9tv2DsL8Zd0n5MryRquIb8ujqbec7E4jTncXm7XtlPUc9
 0SmkH3YRcfaDqyB4juJN4xkFhnyJJPyxMH2OjQmsaJP08vAuWKsF4R+o+zGe6LavEcM9IW5ai3c
 8N/SzLchYXA/i3T2iBHBSQaNQu3ldNYPmDZ3y8Ev6ZwJdg6hSXp7rBLj2NwbRl
X-Google-Smtp-Source: AGHT+IHZes14TtQn6B8LEcV8X5jAQgJZsgVodpzUWRU6wfgpyVEbBbl4AJUysv/dBoUEgynYfrkRRA==
X-Received: by 2002:a05:600c:4f83:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-477c01b23b1mr238553875e9.16.1764188657440; 
 Wed, 26 Nov 2025 12:24:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479040a9cf4sm53856835e9.1.2025.11.26.12.24.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:24:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH-for-11.0 v3 19/22] target/ppc: Inline cpu_ld/st_mmuidx_ra()
 calls in memory helpers
Date: Wed, 26 Nov 2025 21:21:55 +0100
Message-ID: <20251126202200.23100-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of removing the cpu_ld*_mmuidx_ra() and
cpu_st*_mmuidx_ra() calls, inline them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mem_helper.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 6ab71a6fcb4..a43726d4223 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -97,8 +97,10 @@ void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
         }
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_UNALN, mmu_idx);
+
         for (; reg < 32; reg++) {
-            env->gpr[reg] = cpu_ldl_mmuidx_ra(env, addr, mmu_idx, raddr);
+            env->gpr[reg] = cpu_ldl_mmu(env, addr, oi, raddr);
             addr = addr_add(env, addr, 4);
         }
     }
@@ -120,7 +122,9 @@ void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
         for (; reg < 32; reg++) {
-            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
+            MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_UNALN, mmu_idx);
+
+            cpu_stl_mmu(env, addr, env->gpr[reg], oi, raddr);
             addr = addr_add(env, addr, 4);
         }
     }
@@ -161,9 +165,11 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_UNALN, mmu_idx);
+
         /* Slow path -- at least some of the operation requires i/o.  */
         for (; nb > 3; nb -= 4) {
-            env->gpr[reg] = cpu_ldl_mmuidx_ra(env, addr, mmu_idx, raddr);
+            env->gpr[reg] = cpu_ldl_mmu(env, addr, oi, raddr);
             reg = (reg + 1) % 32;
             addr = addr_add(env, addr, 4);
         }
@@ -174,10 +180,12 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             val = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 24;
             break;
         case 2:
-            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            oi = make_memop_idx(MO_TE | MO_UW | MO_UNALN, mmu_idx);
+            val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             break;
         case 3:
-            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            oi = make_memop_idx(MO_TE | MO_UW | MO_UNALN, mmu_idx);
+            val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             addr = addr_add(env, addr, 2);
             val |= cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 8;
             break;
@@ -250,8 +258,11 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
+        MemOpIdx oi;
+
+        oi = make_memop_idx(MO_TE | MO_UL | MO_UNALN, mmu_idx);
         for (; nb > 3; nb -= 4) {
-            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
+            cpu_stl_mmu(env, addr, env->gpr[reg], oi, raddr);
             reg = (reg + 1) % 32;
             addr = addr_add(env, addr, 4);
         }
@@ -261,10 +272,12 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
             break;
         case 2:
-            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            oi = make_memop_idx(MO_TE | MO_UW | MO_UNALN, mmu_idx);
+            cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             break;
         case 3:
-            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            oi = make_memop_idx(MO_TE | MO_UW | MO_UNALN, mmu_idx);
+            cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             addr = addr_add(env, addr, 2);
             cpu_stb_mmuidx_ra(env, addr, val >> 8, mmu_idx, raddr);
             break;
@@ -293,8 +306,10 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
     if (unlikely(!haddr)) {
         /* Slow path */
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ | MO_UNALN, mmu_idx);
+
         for (int i = 0; i < dcbz_size; i += 8) {
-            cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
+            cpu_stq_mmu(env, addr + i, 0, oi, retaddr);
         }
         return;
     }
@@ -342,9 +357,10 @@ void helper_icbi(CPUPPCState *env, target_ulong addr)
 void helper_icbiep(CPUPPCState *env, target_ulong addr)
 {
 #if !defined(CONFIG_USER_ONLY)
+    MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, PPC_TLB_EPID_LOAD);
     /* See comments above */
     addr &= ~(env->dcache_line_size - 1);
-    cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
+    cpu_ldl_mmu(env, addr, oi, GETPC());
 #endif
 }
 
-- 
2.51.0


