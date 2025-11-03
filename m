Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F81CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlOn-0007Vt-NG; Sun, 02 Nov 2025 22:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOS-0006QD-4K
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:38:08 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOP-0000Gg-Ed
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:38:07 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b6ce696c18bso3593096a12.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 19:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762141081; x=1762745881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlBZcEouD+6nvBEEjYr9HD2FnFm084hRWGtmStjYqCI=;
 b=jEwIUeXHe2vGmgfVTTXxYmVQiPnoTWrUH1VOj4jnIXCe7jwLDDafvRBqXeZZZtl3l8
 cNRX6fiavCoTiwfgFst5RuYMgIIi1TXrfNhzxvUapbVOjX58eQYkkznlD/nkE0BaWRCQ
 11DzWILY5l3GYNr5PHBY3uVNTHsRGoF45UJje8eGZxSXDL4kAF5nsEql8wh68izO55IW
 +R966khI99l8ZN64KwrZipzwQj1fmOQPC/ENS8EhkcK1ZXXt8qJvScGOtg472SMbM2tW
 r+z2DH5MDOmLqw9djDegkVx/lwg9kC88n4h5BJMd/BSsWPl+/9uUdWKnPNqJ14+IoJ3P
 6X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762141081; x=1762745881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlBZcEouD+6nvBEEjYr9HD2FnFm084hRWGtmStjYqCI=;
 b=MLslXgAJzUvjLq559YxSG/MsrRt9RYw39Inqsbmdrw7tpp4rYSq3ax9a/rR7K6nnDB
 So8dfpIXpQ+yC/CCVZL/tT2mfkkLWMeTVlqqyNYoSRNPZ0ot805tbJ4OyPJHJNoMfic3
 pmglDFLhfrVzLLoMGBJBQLBFjNJaAhe3ju+TMdjV0d3pguAovoneTtRz/WZrQ9HKYhDP
 yyGeTYBKI/uYJXNPypg7KefraR30g/toPBxJruF9q8H4L5rUg6Ua1HED4XgdxVVx9Vqh
 BtvFZezLf4985VstE4JQyHpzaInOnYMOcuXIcsCZrrGTCIMJjMPhNtm/aXTlzWgGWDu/
 FBPw==
X-Gm-Message-State: AOJu0YznrySBIMAq3e+ZpiZvbt6BrbPAp9yNBVOoQCqscFsVRnD9j36N
 X3PXZgUPwvDmaxVrN4OMblDMiTBmFJrWqHdisAjKDeCuWJWzudzFuWHqgtExcQ==
X-Gm-Gg: ASbGncsdr+eUzrfzcM4JjR/lFArZbTN9NPKNABxzSrTcga/5nRJtAeS5pMwHOryZxzW
 1ZTDFwVRkOZxKJH5IcQC9SC0hmz9I98A6vSSWA2F/0QvhceqUOZZ1ndPO6e2x5vM0e1JvXA42Ou
 QrTy/x9/xs9k3Jx6J+Xxcv+kxjMrK4sxEcjBQu8C1acVK4URUMJvG6Ne9jSiGGgHd47k09ID0+k
 /0ePoqloIY87g/QsZPTBP8MUYc+/hdq+nOHw3e5rzf33e6U4z5IO4aWrkbCdbD1lxikh+pAKams
 yHeqZmQeXRHEgM4V4Uo4U6G4SNJJaKOo05yUbf188FTm0waAWMdJ8w9AIGWkrfwtLCYkxdLPcuf
 nXOjdTxLWAcNKYzWG9LMnpqevUDFRJw3Q1x+FeqhHlFujifDTZN5L6iggKWqpKT2A95D727QcJn
 Z1I2cZyxvynJLGIwM9il74ENmIkTaPVxzp7ZqrBJALKjIZGRgKoDCNr8zAt2JkDfwsnA5+fcZO1
 CA4Ru5ths6lmlIiLzI=
X-Google-Smtp-Source: AGHT+IHSiax2oQlwgIvMGS6zRcPhfx3AlSn0G0EIVgqPUtHsApNxGAn9W3SJdYX++b6bNvnbSsxXaA==
X-Received: by 2002:a17:902:d505:b0:290:c0ed:de42 with SMTP id
 d9443c01a7336-2951a4dfc4fmr153869805ad.36.1762141081021; 
 Sun, 02 Nov 2025 19:38:01 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-340a460ed24sm7939641a91.16.2025.11.02.19.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 19:38:00 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, anjo@rev.ng, philmd@linaro.org, palmer@dabbelt.com,
 dbarboza@ventanamicro.com, atishp@rivosinc.com
Cc: alistair23@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 6/8] target/riscv: Combine minstretcfg and minstretcfgh
Date: Mon,  3 Nov 2025 13:37:11 +1000
Message-ID: <20251103033713.904455-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103033713.904455-1-alistair.francis@wdc.com>
References: <20251103033713.904455-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

According to version 20250508 of the privileged specification,
minstretcfg is a 64-bit register and minstretcfgh refers to the top
32 bits of this register when XLEN == 32.  No real advantage is
gained by keeping them separate, and combining them allows for slight
simplification.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251027181831.27016-8-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  3 +--
 target/riscv/csr.c | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e15439dab7..2d41105ca5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -421,8 +421,7 @@ struct CPUArchState {
 
     /* PMU cycle & instret privilege mode filtering */
     uint64_t mcyclecfg;
-    target_ulong minstretcfg;
-    target_ulong minstretcfgh;
+    uint64_t minstretcfg;
 
     /* PMU counter state */
     PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 838e50d813..9bff118e2c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1116,7 +1116,8 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
 static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
                                        target_ulong *val)
 {
-    *val = env->minstretcfg;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    *val = extract64(env->minstretcfg, 0, rv32 ? 32 : 64);
     return RISCV_EXCP_NONE;
 }
 
@@ -1143,7 +1144,7 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
 static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
                                         target_ulong *val)
 {
-    *val = env->minstretcfgh;
+    *val = extract64(env->minstretcfg, 32, 32);
     return RISCV_EXCP_NONE;
 }
 
@@ -1160,7 +1161,8 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MINSTRETCFGH_BIT_VSINH : 0;
 
-    env->minstretcfgh = val & inh_avail_mask;
+    env->minstretcfg = deposit64(env->minstretcfg, 32, 32,
+                                 val & inh_avail_mask);
     return RISCV_EXCP_NONE;
 }
 
@@ -1247,8 +1249,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     if (counter_idx == 0) {
         cfg_val = env->mcyclecfg;
     } else if (counter_idx == 2) {
-        cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
-                  env->minstretcfg;
+        cfg_val = env->minstretcfg;
     } else {
         cfg_val = env->mhpmevent_val[counter_idx];
         cfg_val &= MHPMEVENT_FILTER_MASK;
@@ -1576,12 +1577,13 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
         }
         break;
     case 2:          /* INSTRETCFGH */
+        cfgh = extract64(env->minstretcfg, 32, 32);
         if (wr_mask) {
             wr_mask &= ~MINSTRETCFGH_BIT_MINH;
-            env->minstretcfgh = (new_val & wr_mask) |
-                                (env->minstretcfgh & ~wr_mask);
+            cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
+            env->minstretcfg = deposit64(env->minstretcfg, 32, 32, cfgh);
         } else {
-            *val = env->minstretcfgh;
+            *val = cfgh;
         }
         break;
     default:
-- 
2.51.1


