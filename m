Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C67D232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6QQ-0005AE-Mm; Fri, 09 Jan 2026 01:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Ph-00044j-V8
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:02 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Pg-0002rw-4D
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:01 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81dbc0a99d2so381826b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941757; x=1768546557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkrFTEiLemIfD4lfrK8zSoqhMztc5LwCsgR75zu82b4=;
 b=RiAUR0Tc5qvaY/OYnXmaaS7GM9pAvIaoeBhzC6ULxJccjHDICSd1UpmoxL0NuaguHU
 mkqaE0e9dMZNho+yvOI04mX7/Cg6pwew9APGwlfy/kwI3F/64fbuSMxLIr79sAlPCdxE
 ZlAT5Hdjj4YnHWF4C4xt9q4xaf7IBfXWZBGnlgg4lIGgTsk+Y7S9Oz63aCDW9tEIrX58
 7V1RsoxmdwLp+1rVUQRkfnvFjKTC+BcQrShxV0SMH6yWRLMAHbKA23JY+RQ5PP3i4a2/
 9cQ92MEFcQkNHpnMCgL+8OlYAECVyPTb0SSc1SZKMV2BtVIRDhhE4ufsXOlDGgS2l+pP
 iVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941757; x=1768546557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NkrFTEiLemIfD4lfrK8zSoqhMztc5LwCsgR75zu82b4=;
 b=fdagzOwr/Mn0bBn23UG27rEhlrJCBGMn5Zj6abBe526YV51H/MhDxE2BV2mGHLtt7m
 YxJsyjbq9UaC9dA9hzO06A91jBgdo+RvaIXAmT89PjFAjEu+WIrM2ssoBjRhKvwOumyD
 qiS45LS1yLKZt2nLuto/trpfYNspkL+WHadifvXuyIcqb+Rkme03HcoQPiDDHE612qzX
 I+aWVKrXbDtr8RRZB6fuzm670p/qkvv5LfPNktfVbWiEFe2mueJNAqMpMG2o1eroIgmP
 Mw68X7MpIMToW+mfd5AmPCr4GkJ72yB3WPzCaAqoKZRYD148pidq2az+O7EW450Kt1xk
 QiFg==
X-Gm-Message-State: AOJu0YxWC7c4mpzbdvmjq9K+cRpRoLvMXsEhbs9SMaFvC+hjzj+/Hgm8
 qMH0lJKweZUVv11WZ4+EtcGKq1uZZtrWcrmVhDWIIgx/iI9FlvKyhU37rjEZ7Q==
X-Gm-Gg: AY/fxX54fHGwv6wQISSFFFiJUQD+6cMrJYEFVgLBlij+p3xs5hAzB7D2kMAkX4RPdmf
 vGo1rGsf+uFqMYuqU5WXgz2vaI1ixbcznh/tL2Fl6181LQRh+WUzqrCYzr95tambLF8xPbvgUNr
 xjH0tlOlTQNkCWvmnC2NJ5rBlZoInseMpFQYskRoFHUGFzTloKHPGpdRQ5LI6eW/HILePpfKUtR
 gKOuWhUin9sgKQudSi9cqRKkYXKkboUhTPFhPRATAWULD8sCWYi8oW0icRDQnURshr0RJZ7uwph
 Q/8z57RDTQ1mXs/I/0fapwZfLrU+RB97IN16zesbN4r2f8bgQgibBU9VqrnJMxpVSQop6EaB3Zx
 ZFw7KuIW942aKwK5urtYRQHR5j7/TLaiOAmRbobNZ2Lt7TK7gJNmCgVwyNKELZE+4oD4n2ztxSC
 SQS4LXci4YaPY5J60bTIuX/L1MI7bsA1xRULXQxt9+m5vrYQ2uaA/jzwjeX7eidN6yq+tVA+EVV
 lvxjOWGRDSbFsMzc7M=
X-Google-Smtp-Source: AGHT+IHmZqtD0uBJhl9OE/1YEwJTnYHzlaVd+RdwHKxO39kMkh1v99s/heSk2DG0EqQWFsUBlRfZVQ==
X-Received: by 2002:a05:6a21:6d89:b0:37e:8eab:c05f with SMTP id
 adf61e73a8af0-3898f9e43d8mr9295129637.59.1767941757392; 
 Thu, 08 Jan 2026 22:55:57 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:56 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 15/34] target/riscv: Combine minstretcfg and minstretcfgh
Date: Fri,  9 Jan 2026 16:54:40 +1000
Message-ID: <20260109065459.19987-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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
Message-ID: <20251103033713.904455-7-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  3 +--
 target/riscv/csr.c | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2942fc1eda..b94c444678 100644
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
index e9e30384b4..894ae4d7bf 100644
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
2.52.0


