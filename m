Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F64E7FDDF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn142-0003j9-5x; Mon, 02 Feb 2026 16:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn130-0001Hx-9b
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:26 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn12y-0004R2-Gz
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:26 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso21117975e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066083; x=1770670883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRxgArMdqLQj6qKcyVCQNmjANm/oClOwBNcjeuzxsd8=;
 b=GrG9ghA5XzTTo8mM2jgCiaZrDZ71wEtLFeJYpUEDigySO5T+3SwZFzYOrj9xoLslWR
 ZW/rwUQBLEdAqazZk6j8osAfro03rt64k6XKAP06U6RE1a/A9i653VCkgPi4fNAi6flm
 ifrZUbIalkX79nKPSGeFK6dUDOagLyTvygykCguOYNbExc3Yl4y/hsbXruwT10B7t/OV
 k5G/YrHAWlCAdmG4xETPwd46izmbt4H6OmyiFZIKB3aZG4owwPLSHpM6+3tX6/9vOvJe
 aylQAu5RHawfZ7UigKbBcPfSyF+xP8jT7E+s+z1APRicarra899dszNH6YM94kPYrP5m
 jUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066083; x=1770670883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IRxgArMdqLQj6qKcyVCQNmjANm/oClOwBNcjeuzxsd8=;
 b=E8jSlUl1+/ZvJ7xfmdxMq9/CjL2v1svfUc+/BaYSgBXHwRNZL8RO+Ov4f5s2XEsyKn
 5bNIukU8FjKVAXeyigYyTgZ5QvwS6R+dYZu+XBmWSN8JEfro0NhVTL5pogffI0uABFPa
 YyguK95hhroHo5c60GkIlwff8YpIbi3U7PT420oE7IHlOUlQ48KDBgh53R827POnYR+j
 jURzqzmeG+PihWMVQv/PYHOpLP1F9/UZLS/WiTPuN6mpg+xW6k2LdaVy3E0pcQorQa/k
 meK5g1Pd+GWaefBmWiQhbWrpVwORrIAIoiNRw8n+HZr5c6hwMIlw9rU8Nv6QFGvpATwd
 yKlA==
X-Gm-Message-State: AOJu0YzKwXb9Qbreb4tFrlwht2d2G+3SVYntyKTGp9Bs+aDhx3oGeqbR
 2u9SC70voKDbCC06Xz0sIAWUbUEeD9BSd4zlKJ+SVT+amM0kWO9OEhLsX6P8twQLO3jdcGlY6nR
 6JvBFubU=
X-Gm-Gg: AZuq6aKxpGiTI7UWQHl8jsLJ/3XtQGFb5DQoznWZXsDgz+Il+sanF8I6PkCdPjaw5nL
 b2uQ4o0xr4Em4eoF8LpRpUuTsOK1iW3c9UZulJgHeUkqzd2kw/ouwbSARAx13IuExKAmkQ4MFGU
 g7DqxnMY+ySkbD0gaJzwbXlWgY5N/Q2d7tUQ3r4PpLS5PCvedzjRJvDb5NVqmdPIDoGjZKFXIa6
 H45RUHXkmQXczO5yQqwMKYMnP/+IlA4s3wDKZIG/uyJ+CHpf0sBXVQ2R0XVWr5iv/pFmglidENN
 Ocf19tJ94N9gFJlFv0AXLhmJqhvjoeRdR6DeGhbBoi93YZnyZDWD+QNRqT5gapdqAmaygpwzCp9
 HY9iO3jPo1Z+EtU0BZrz6SZTwCD2Uq3Ji5IZDt7+xFTLjvM1L7QPBGJlYhQHJxpa5GyVdt4alaf
 mm8tC8iNw/dcQ7HZ9UBxE8pfJ0QB5RlpkXJBaDYDUnccX3wWNBN1Ez3OBDoJPj
X-Received: by 2002:a05:600c:8716:b0:480:4c20:6a06 with SMTP id
 5b1f17b1804b1-482db48c61emr176406785e9.17.1770066082512; 
 Mon, 02 Feb 2026 13:01:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e2973d57sm98386985e9.18.2026.02.02.13.01.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:01:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 02/11] target/ppc: Inline cpu_ld/st_mmuidx_ra() calls in
 memory helpers
Date: Mon,  2 Feb 2026 22:00:56 +0100
Message-ID: <20260202210106.93257-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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


