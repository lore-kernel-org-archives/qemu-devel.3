Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B58CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FPg-0004LI-Pi; Fri, 10 Oct 2025 11:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FPd-0004KM-3O
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:52:09 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FPV-0002kQ-PZ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:52:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso16840915e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111512; x=1760716312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxfHrlTKdZT/TZoguzIgIG2+DkHFL/6gFEZ+Ayy2974=;
 b=O2rIhKnkTZCA9UcsWB0hmcrJ/dVKckH9jIP7V52UXYjbIdrB0/T3yI/9rAKP/L/UMI
 BiVXL3MHcD/zG3nSnDthzIY9AGL8sDIyMM5B36rrKXYIuz9pFuVyUvpHcjSZmbQQJfMe
 LBzE8cr4pvUyvS3wX0k0PTbAXF/xPLuU8HnVv7yiGGKaRS3PJ8qBjlev9iICf7qggA2P
 WBcWGvKuTax+ybJIj5W33435j6A38e/L+Py9gSjAp85sOI9GcxmXyLR+IkvvI+W+atiq
 YZAF6TTqvki+j3LCCQ4M18XEEGCejRyT07XiASPmz/38T9IvMiYldVVDXb+MqSG084kF
 SPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111512; x=1760716312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxfHrlTKdZT/TZoguzIgIG2+DkHFL/6gFEZ+Ayy2974=;
 b=iKyYBI40RvSCGnbjhx1Hi+M1P8piiZtL5iSpkNZIhPMaITK+WfwlgOIeIMJG1EDs6p
 P+UnHdSzZGgLIKdyhAVA/MALPvlbHyIj2vimzlsHhDju4nWJ10LjFIuVI3wLa7NmcQn9
 8Mt8dmMf8+Pg8bQeMm58WcsEqfYasyyXv2AiTKSEl/1oPsXwLiAb8bSJMqabco3c9fiv
 bxpVbxq1BNnzGlaeyBjn95IOj+wNb7K5bXr3MWtFJejkrouApLILXlSQYOSHwieZjDN5
 uJdgX12IotAtZIqGnsKABN1vuNVQu1qq1rJJm/5LytqA58rN9k0LyIolmuCnZAe6wrVW
 Na4Q==
X-Gm-Message-State: AOJu0YxkuZNf4oYJje3U6gkrWHubzh5pPnlWiXTW8lHbc+WACrXufWTL
 p1OXdMNgdeMP87JgBDithfXs9J2FMM/GCWT62vMyoZTX/yDLUcKPOMu7fDXlhgh0qfDFQ1D5i/q
 t5jhRohDqKw==
X-Gm-Gg: ASbGncshfzRwbE9KXsiFwkuyrPXF+NZxqK089FnXBVeFSN1PbzIDOxPTALpHuuFN7KN
 qpvcPGY/xsetou9/7khJiw8tDVcRLelAYR0T29vAm3OGXtHMz5nckGrmMG3Yg3N0aYMjI4PZBSf
 8yJCksox+B0oqq38iFDq0OaIt8HmGZlYkSs1HmNfZZK7QZZFtSuVu5T9cF1lS2eA4jczPIpMNCv
 2N4YHKNN0XdckHb25rEGl6JKjub+rVHGrjknnMCrzGXRZFCX9pu0phyNr/8erIcBic9gvMKgJ/6
 jZHHDJdODePY5tjc5gXLq1O3d5xv0tdKzrJjouaaIz9FOPeH95DvZa+97a9lRNKjvu+1Yv9zFpc
 B78nbb5xV1akpO2fzxyZsTTCCkr2Q/EkIKIEZbhyGur9F1yl/8FwECUXi4xDIvvEzX8gATgFNlN
 xnC8/f9AXtjS6Fty49fv4=
X-Google-Smtp-Source: AGHT+IG2ygMTJldPEGZnit0zKD9ls17w5wAzUIzVsRzGOGpR58WHjGp5WrHDxvGDSqjqHF8rZtZlIA==
X-Received: by 2002:a05:600c:a402:b0:46f:b43a:aef4 with SMTP id
 5b1f17b1804b1-46fb43aaf69mr25725435e9.38.1760111512371; 
 Fri, 10 Oct 2025 08:51:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab656554sm62021935e9.11.2025.10.10.08.51.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 08:51:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/13] target/riscv: Introduce mo_endian_env() helper
Date: Fri, 10 Oct 2025 17:50:44 +0200
Message-ID: <20251010155045.78220-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010155045.78220-1-philmd@linaro.org>
References: <20251010155045.78220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

mo_endian_env() returns the target endianness from CPUArchState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/op_helper.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index c486f771d35..9d048089e2a 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -28,6 +28,18 @@
 #include "exec/tlb-flags.h"
 #include "trace.h"
 
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
+
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       RISCVException exception,
@@ -633,7 +645,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
 
     return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -642,7 +654,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
 
     return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -651,7 +663,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UQ, mmu_idx);
 
     return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -669,7 +681,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
 
     cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -678,7 +690,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
 
     cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -687,7 +699,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UQ, mmu_idx);
 
     cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -703,7 +715,7 @@ target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, true, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
 
     return cpu_ldw_code_mmu(env, addr, oi, GETPC());
 }
@@ -712,7 +724,7 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, true, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
 
     return cpu_ldl_code_mmu(env, addr, oi, ra);
 }
-- 
2.51.0


