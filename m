Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF50ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlOg-0007HJ-1Y; Sun, 02 Nov 2025 22:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOK-0006Bt-Mn
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:38:02 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOI-0000Fu-DJ
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:38:00 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-340564186e0so3388641a91.0
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 19:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762141076; x=1762745876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9g+yAXyYE8jkKU/7vIpMCdkhZpzVMRxiazXsSxgB+g4=;
 b=ZySqsuEU9LU5mXaOsErBvXnS3E3ViuEVaJuWe8BkkPOryrplkCvbAYfa999eEqX/gf
 O6UpcQxTq+GK2MOuUJeNpc6KVl70BANjhhq3Md7JlKsQG0WACPov2sGOWeYHj6ip3Dpn
 mAgRRt74vLYwXh+R1P0hRET8ZIltbrRqM/PUHL3DGgeiP2A1leyJjJioxzOmDhyd+GWv
 Tvd4+SgLrxs5yi+hvtZP2k/kBfQgtMohraG/b/Qq0fOq2C0xlhbOBklWFMDJS6ELhuLW
 mLQGQH9p8KgBKnqCDHooMqCM6I05GD0MI3AOmhzCO8i2qZQvirjo7kZyXZ2LDbvxKdTL
 Ax8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762141076; x=1762745876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9g+yAXyYE8jkKU/7vIpMCdkhZpzVMRxiazXsSxgB+g4=;
 b=MWyYUlym5SomAWwK4P4O//dQr6F/EFhEZlCMOnTvIQNhFmShCxZ3/bg1mOHEmi23/b
 9PpQvnxMZMvAdaQ/a+agUuKyv5Lrt0a+VjlbsEat6nqRyTt3WGIQ8S7zOxIyR2fuOHNZ
 Hfjdz+tuPNYiJmMt3QXfv7tVUzjBa8yKYJp8pPBL6NpUTWr2KXH+ehAptwCYIfcHPq8W
 af2afQIYKZoOlqnCl4DKMqBMUHEAl1XwpNS4J9CZYf/L7CI9HSPidrzvLiMn2sOKf9z5
 jsxrGERV7n1msV+C2QY2SKSVlYvumVkjjSXo8ZnISysXEGV0x4LH76Bz6jHO8ZOk5+Hg
 IvDQ==
X-Gm-Message-State: AOJu0YzZLCfRqqRwr3F+y/NuH8MaQSNDGmTIVsMGJQf70s6JLlHmPsaC
 Nbl9E14tfcslcWPWoNJ5xJa55Gjkm0ZXCPolleItM17atwtdCbqqdsUuHovymA==
X-Gm-Gg: ASbGncskcGliysgeh5J8zHyKTYCmHNq0yuGnUDE6VUjrdqmylODYG9iyCpA3GXU6R91
 J37SFmSJm5Gy8ZGILiErWK+UCXrveHBhurG+rTa0rYlaJxLzVzWdPJfl54qSYS2k6HDIwBIFOjO
 eYZM6g4ME3gkd+GkKVU5gcS3FxyhOtBJWq9bGkkHdDe8bT6Sw2EbECvzJqVgHMSHU5hhGiNhinL
 EeaeupaRvQbVcixVeY3gYnUdJmbWTyre+hJzN8YSM95y8GKfvGKLcluvsKx97B2laOfe0buan2a
 PwfxV94EoRRC8xLNP9LQA9NUjacIF9UVCjQixS1DNan9oN4/rpHP/T4+S6Hnaz4FYrEtUaadOXo
 fCCx2EyK+9cTOKV5Ij93anviKDcnxjPvGJ5dPj49Kc/nezMggvI1e0+Azg3C5bUeM2GYQvc1/SX
 MAvV2E9B74GjxQvLtCaC6HThgYq1+umeMwBXflxVJ3QC2gwYxao1rFYULlZYuP9ufg79IgI/u2F
 gIf7aER
X-Google-Smtp-Source: AGHT+IGVWUUiNMW7pJOylCF9smISTtDTswNHOCnJDEuZfm/wciW1LSXF1atJVSBt8NmvOo3x3w4V8g==
X-Received: by 2002:a17:90b:3903:b0:341:34eb:1be6 with SMTP id
 98e67ed59e1d1-34134eb1d81mr1703395a91.27.1762141075695; 
 Sun, 02 Nov 2025 19:37:55 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-340a460ed24sm7939641a91.16.2025.11.02.19.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 19:37:54 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, anjo@rev.ng, philmd@linaro.org, palmer@dabbelt.com,
 dbarboza@ventanamicro.com, atishp@rivosinc.com
Cc: alistair23@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 5/8] target/riscv: Combine mcyclecfg and mcyclecfgh
Date: Mon,  3 Nov 2025 13:37:10 +1000
Message-ID: <20251103033713.904455-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103033713.904455-1-alistair.francis@wdc.com>
References: <20251103033713.904455-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anton Johansson <anjo@rev.ng>

According to version 20250508 of the privileged specification, mcyclecfg
is a 64-bit register and mcyclecfgh refers to the top 32 bits of this
register when XLEN == 32.  No real advantage is gained by keeping
them separate, and combining them allows for slight simplification.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251027181831.27016-7-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  3 +--
 target/riscv/csr.c | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0791959fcd..e15439dab7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -420,8 +420,7 @@ struct CPUArchState {
     uint32_t mcountinhibit;
 
     /* PMU cycle & instret privilege mode filtering */
-    target_ulong mcyclecfg;
-    target_ulong mcyclecfgh;
+    uint64_t mcyclecfg;
     target_ulong minstretcfg;
     target_ulong minstretcfgh;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6b53a61c5b..838e50d813 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1061,7 +1061,8 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
 static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
-    *val = env->mcyclecfg;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    *val = extract64(env->mcyclecfg, 0, rv32 ? 32 : 64);
     return RISCV_EXCP_NONE;
 }
 
@@ -1071,7 +1072,7 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
     uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->mcyclecfg = val;
+        env->mcyclecfg = deposit64(env->mcyclecfg, 0, 32, val);
     } else {
         /* Set xINH fields if priv mode supported */
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MCYCLECFG_BIT_MINH;
@@ -1090,7 +1091,7 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
 static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
-    *val = env->mcyclecfgh;
+    *val = extract64(env->mcyclecfg, 32, 32);
     return RISCV_EXCP_NONE;
 }
 
@@ -1108,7 +1109,7 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH : 0;
 
-    env->mcyclecfgh = val & inh_avail_mask;
+    env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, val & inh_avail_mask);
     return RISCV_EXCP_NONE;
 }
 
@@ -1244,8 +1245,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     uint64_t cfg_val = 0;
 
     if (counter_idx == 0) {
-        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
-                  env->mcyclecfg;
+        cfg_val = env->mcyclecfg;
     } else if (counter_idx == 2) {
         cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
                   env->minstretcfg;
@@ -1525,8 +1525,12 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
 }
 
 static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
-                            target_ulong new_val, target_ulong wr_mask)
+                          target_ulong new_val, uint64_t wr_mask)
 {
+    /*
+     * wr_mask is 64-bit so upper 32 bits of mcyclecfg and minstretcfg
+     * are retained.
+     */
     switch (cfg_index) {
     case 0:             /* CYCLECFG */
         if (wr_mask) {
@@ -1552,8 +1556,9 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
 }
 
 static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
-                            target_ulong new_val, target_ulong wr_mask)
+                           target_ulong new_val, target_ulong wr_mask)
 {
+    uint64_t cfgh;
 
     if (riscv_cpu_mxl(env) != MXL_RV32) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -1561,12 +1566,13 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
 
     switch (cfg_index) {
     case 0:         /* CYCLECFGH */
+        cfgh = extract64(env->mcyclecfg, 32, 32);
         if (wr_mask) {
             wr_mask &= ~MCYCLECFGH_BIT_MINH;
-            env->mcyclecfgh = (new_val & wr_mask) |
-                              (env->mcyclecfgh & ~wr_mask);
+            cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
+            env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, cfgh);
         } else {
-            *val = env->mcyclecfgh;
+            *val = cfgh;
         }
         break;
     case 2:          /* INSTRETCFGH */
-- 
2.51.1


