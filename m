Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63154D6E2DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIo7-0003x5-NF; Thu, 18 Dec 2025 13:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWImz-0003mY-3O
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:49 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWImx-0007LQ-6E
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:48 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-59577c4c7c1so1742053e87.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766082705; x=1766687505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvdG33TRWp8WNQPzYXmaerPpkmBvUESr5mSsOVtQ4Q8=;
 b=BuLzkFvwzDkO+rKme4VWoYYghrwHYh0nsrrwPp+YhneQ5Z86FTvg2FI+NYBBfykawS
 tM0gFN5ZIxHzOAMDqPapwbHNvBfr2QYdAhWOEaEc2YPWsIgPal/RQtsZijISpkM7Z//p
 OCt/xziRh4IEx7+MhfM7mysqS7y+TCtzDUqL8silsHtBG40ZW5MEhgtNUheB1BthMQYJ
 GhfNsJ5xAl3szc7EAzZXuHZtoXm2m74mPdEvMMCxpSdmGQm/zOism+tNZ3Y5dWuU9LIX
 dm26OmL7eO+/XrDeTxwfhaAcFazGbSRsqmySqmgBLep0hBEsSKH+Xo3EkY41UmqSDmsa
 F63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766082705; x=1766687505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bvdG33TRWp8WNQPzYXmaerPpkmBvUESr5mSsOVtQ4Q8=;
 b=pDC0huw1ssAvHwGEYNKZe/XT38y0tCNsamM6+gjbQMVPVyHZMbCd7bNKndoDSCRV+S
 bJv8KIO/U35vDjMJJaKBXZoZ6w2bLpBbaYNUly6Yn8ePIZCpEjNuqwFStAbET/4qric/
 RnNhlC50JW+5nTeD3QjDrjzma90KVzIx5KF6icGSF54eqKADCDxqmfeOFEo6gMcb0d9H
 et7R6y5kmEN9OSZkUtJ2yfz8l6Iuc51iSTlwu6wY/uGANceUKVKZY1ZuI2jXR8ew+hjm
 FcBZF4XZHDmTF8WZU4aXPUMY0dBwLekgqVqZopXd1eirWX7bYtXi9lzB2NaUisT8v9Sn
 kkwA==
X-Gm-Message-State: AOJu0Yx75gtKqsKK6S20070LlYowoR6SqHF64RsT7npEyfhyBO7J6z8t
 bFOnbJ125MeOE58pq4CkWFvAQcmBg22RmuHYKGITFSFAY62r/K4DM4jFD/uLaf9z
X-Gm-Gg: AY/fxX6uY8zCMT8xviYrT3AW3Lyy8lLMLI7X8E+Ya2Re1Oy4Y8m5rpFpCmtDEKhxc/X
 MTkTwKSO8tIgjkD758WUMIIcLZcTR3POFmD0wLdpqIwfUxFHauwi+MukKYBzp/X4pAR22c5HJ/P
 i6e9yeO1S1r4LajGApZhVeoSiC/Qhxmg81ZUva2opce/7MVCvwbH66KrqBz6kikmhsY+026jhJL
 aUyEO0yUtctp83cr4DCkbgVVGHGco8dTFjyL2G/ytJfe1O868IbfdburDGFvJT5pmTkukC9mcuX
 E2AipUhZDpRy6rdIwvM3fA+mdHPAgJNzIYTx4JUOg/m03RgHPP2+OzWj15EQKvycJF42L9ZJFHY
 0GuGkUcNY99kXUioP43TDZ76FrWe5RHuQu63rEIc7aoGukhubbXXh5kEitHOidwAdlmOeBMsu4k
 KBqUM22Aht36PL
X-Google-Smtp-Source: AGHT+IEBB/Rsoe4o74O4RaCcS/gINOdKEL5eskNgr6M0dfB3klPawtUMVkEz7op//XGHFJr55NW45g==
X-Received: by 2002:a05:6512:3d9e:b0:595:7d7c:59a9 with SMTP id
 2adb3069b0e04-59a17d6bb20mr161845e87.22.1766082704953; 
 Thu, 18 Dec 2025 10:31:44 -0800 (PST)
Received: from NB-8855.Dlink ([81.201.19.27]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59a185dd229sm46777e87.22.2025.12.18.10.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:31:44 -0800 (PST)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
To: qemu-devel@nongnu.org
Cc: halip0503@gmail.com,
	Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [RFC PATCH 2/6] target/riscv: Reimplement Smcdeleg/Ssccfg via read_*,
 write_* methods
Date: Thu, 18 Dec 2025 21:31:17 +0300
Message-ID: <20251218183122.408690-3-sergeev0xef@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218183122.408690-1-sergeev0xef@gmail.com>
References: <20251218183122.408690-1-sergeev0xef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=sergeev0xef@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:32:41 -0500
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

Methods rmw_cd_mhpmcounter(), rmw_cd_mhpmcounterh(),
rmw_cd_mhpmevent(), rmw_cd_mhpmeventh(), rmw_cd_ctr_cfg(),
rmw_cd_ctr_cfgh() contain the same code as read_hmpcounter(),
write_mhpmcounter(), etc. To avoid the same logic
being implemented twice, lets re-call methods from one another.

Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
Reviewed-by: Alexei Filippov <halip0503@gmail.com>
---
 target/riscv/csr.c | 80 +++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 58 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8bdbc71160..81475ec9a3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1419,9 +1419,9 @@ static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
     }
 
     if (!wr_mask && val) {
-        riscv_pmu_read_ctr(env, val, false, ctr_idx);
+        read_hpmcounter(env, CSR_MCYCLE + ctr_idx, val);
     } else if (wr_mask) {
-        riscv_pmu_write_ctr(env, new_val, ctr_idx);
+        write_mhpmcounter(env, CSR_MCYCLE + ctr_idx, new_val, 0);
     } else {
         return -EINVAL;
     }
@@ -1438,9 +1438,9 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
     }
 
     if (!wr_mask && val) {
-        riscv_pmu_read_ctr(env, val, true, ctr_idx);
+        read_hpmcounterh(env, CSR_MCYCLEH + ctr_idx, val);
     } else if (wr_mask) {
-        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
+        write_mhpmcounterh(env, CSR_MCYCLEH + ctr_idx, new_val, 0);
     } else {
         return -EINVAL;
     }
@@ -1448,31 +1448,18 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
     return 0;
 }
 
-static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
+static int rmw_cd_mhpmevent(CPURISCVState *env, int ctr_idx,
                             target_ulong *val, target_ulong new_val,
                             target_ulong wr_mask)
 {
-    uint64_t mhpmevt_val = new_val;
-
     if (wr_mask != 0 && wr_mask != -1) {
         return -EINVAL;
     }
 
     if (!wr_mask && val) {
-        *val = env->mhpmevent_val[evt_index];
-        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
-            *val &= ~MHPMEVENT_BIT_MINH;
-        }
+        read_mhpmevent(env, ctr_idx - 3 + CSR_MHPMEVENT3, val);
     } else if (wr_mask) {
-        wr_mask &= ~MHPMEVENT_BIT_MINH;
-        mhpmevt_val = (new_val & wr_mask) |
-                      (env->mhpmevent_val[evt_index] & ~wr_mask);
-        if (riscv_cpu_mxl(env) == MXL_RV32) {
-            mhpmevt_val = mhpmevt_val |
-                          ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
-        }
-        env->mhpmevent_val[evt_index] = mhpmevt_val;
-        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+        write_mhpmevent(env, ctr_idx - 3 + CSR_MHPMEVENT3, new_val, 0);
     } else {
         return -EINVAL;
     }
@@ -1480,29 +1467,18 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
     return 0;
 }
 
-static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
+static int rmw_cd_mhpmeventh(CPURISCVState *env, int ctr_idx,
                              target_ulong *val, target_ulong new_val,
                              target_ulong wr_mask)
 {
-    uint64_t mhpmevth_val;
-    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
-
     if (wr_mask != 0 && wr_mask != -1) {
         return -EINVAL;
     }
 
     if (!wr_mask && val) {
-        *val = env->mhpmeventh_val[evt_index];
-        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
-            *val &= ~MHPMEVENTH_BIT_MINH;
-        }
+        read_mhpmeventh(env, ctr_idx - 3 + CSR_MHPMEVENT3H, val);
     } else if (wr_mask) {
-        wr_mask &= ~MHPMEVENTH_BIT_MINH;
-        env->mhpmeventh_val[evt_index] =
-            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~wr_mask);
-        mhpmevth_val = env->mhpmeventh_val[evt_index];
-        mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
-        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+        write_mhpmeventh(env, ctr_idx - 3 + CSR_MHPMEVENT3H, new_val, 0);
     } else {
         return -EINVAL;
     }
@@ -1514,21 +1490,18 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
                             target_ulong new_val, target_ulong wr_mask)
 {
     switch (cfg_index) {
-    case 0:             /* CYCLECFG */
+    case HPM_MCYCLE_IDX:
         if (wr_mask) {
-            wr_mask &= ~MCYCLECFG_BIT_MINH;
-            env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
+            write_mcyclecfg(env, CSR_MCYCLE, new_val, 0);
         } else {
-            *val = env->mcyclecfg &= ~MHPMEVENTH_BIT_MINH;
+            read_mcyclecfg(env, CSR_MCYCLE, val);
         }
         break;
-    case 2:             /* INSTRETCFG */
+    case HPM_MINSTRET_IDX:
         if (wr_mask) {
-            wr_mask &= ~MINSTRETCFG_BIT_MINH;
-            env->minstretcfg = (new_val & wr_mask) |
-                               (env->minstretcfg & ~wr_mask);
+            write_minstretcfg(env, CSR_MINSTRET, new_val, 0);
         } else {
-            *val = env->minstretcfg &= ~MHPMEVENTH_BIT_MINH;
+            read_minstretcfg(env, CSR_MINSTRET, val);
         }
         break;
     default:
@@ -1540,28 +1513,19 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
 static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
                             target_ulong new_val, target_ulong wr_mask)
 {
-
-    if (riscv_cpu_mxl(env) != MXL_RV32) {
-        return RISCV_EXCP_ILLEGAL_INST;
-    }
-
     switch (cfg_index) {
-    case 0:         /* CYCLECFGH */
+    case HPM_MCYCLE_IDX:
         if (wr_mask) {
-            wr_mask &= ~MCYCLECFGH_BIT_MINH;
-            env->mcyclecfgh = (new_val & wr_mask) |
-                              (env->mcyclecfgh & ~wr_mask);
+            write_mcyclecfgh(env, CSR_MCYCLEH, new_val, 0);
         } else {
-            *val = env->mcyclecfgh;
+            read_mcyclecfgh(env, CSR_MCYCLEH, val);
         }
         break;
-    case 2:          /* INSTRETCFGH */
+    case HPM_MINSTRET_IDX:
         if (wr_mask) {
-            wr_mask &= ~MINSTRETCFGH_BIT_MINH;
-            env->minstretcfgh = (new_val & wr_mask) |
-                                (env->minstretcfgh & ~wr_mask);
+            write_minstretcfgh(env, CSR_MINSTRETH, new_val, 0);
         } else {
-            *val = env->minstretcfgh;
+            read_minstretcfgh(env, CSR_MINSTRETH, val);
         }
         break;
     default:
-- 
2.51.0


