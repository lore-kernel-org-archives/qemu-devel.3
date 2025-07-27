Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D74C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwMa-0000yQ-3W; Sun, 27 Jul 2025 04:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLt-0005LO-Qo
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLs-00047g-4V
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2363616a1a6so27449275ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603402; x=1754208202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYZh6fiTUe+0EQpcXU4sHMxQ8Ins9Igi8YtaAq4VDew=;
 b=NvIHBjhG7FbRW/zEcIJpE1GOnwUk50TOt8cyWb+pRCNP/ZfbrhkAhUUkUSzs4JTdaO
 PE68a3fbxyI+e1V7iu3BhY8PF0YPc6A2d9NIXK8LFd7+hEcB4nJHXZe1jujGEGHicYDA
 xnqFP3757r8aSBzvbY/OSLyfvxLfw8kGmX9veuRwVRqdQef6O4IWRNE4gRJG04pt3Jri
 SClhmh17GltR1yua7sD69bSboziJhuEky9MZ9XnZACTq+uOTVYfJMCKAMIO3WR53s6Vg
 eYb8dEVD3WRK8WKDRWX1rN1n3D2c/4pkfXmdnvHvLYpCMhBGuVu7x6a6nCZE4oA4MyLz
 OsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603402; x=1754208202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYZh6fiTUe+0EQpcXU4sHMxQ8Ins9Igi8YtaAq4VDew=;
 b=fjyWQtQKShy5h51+wnKM3L2sjTZCpFryhC3C3E0vF7kt55fkqcbV3EJugSdY0Dalux
 Nv/t/wYMOMlpMVQD/ifBxc7tCLBvz5ABw0YIcMkwwKE53VVnhULIg495Tr5oegcabezB
 oqmUGy93ux2squwr5DfAA9H7Uw4Rj2S/NT4vaWPBhAHXtPfAo5688lMNPpvWnykjV8n5
 7zfvbtTaDvUOGkpmzgYYzyKAmxmzwfEZHwvPy4ijYjimUjzqlsN0ZvsOMyRGus07tjCj
 W4lN14DZJbZPbZnylLf+yzYc0zK4Zxl/xUG8lmAT0QVNz8Gc7g3qrY59YIYX7xv500z6
 CjoA==
X-Gm-Message-State: AOJu0YxrXW+qP+9yZOMnTKqrqfELa5p6EBA1MKhhl8d5WentoYgxytlG
 eGMy1EIS5PAIlysaXtcP46vfn4OvYBrWmUWD9QAANOyJSpN0Mdzvizj2x2yzzekGNv7caNDqHgg
 vibAg
X-Gm-Gg: ASbGnctZSM4fBxfgg8p/nr61jkBSEe1y5PIDtRhxK+etwUac6zvjZZozp6gWrXLVg5l
 JYY9QXh/h+mvpmccC3l3YhHcZiH9Yi90vfytTt8R2Bo0nlwWY/ZzDKFUk3/LozfRZG9/S+r4kgc
 aAlubI8DsisvceuE1X+kMgbMWc9FEgPa9lDDuiReJezFE/J6qHp9q5IbgMh4v2CpFeBGUh8vUVL
 9K+3oc0fcw3wejkaR4rnEQk2ZV6CW9E5Rc7WI8jTPthwnyRRbkCKaui1e5qOP6TZzYVWuWcGmvj
 USAJkpPaJvIw5PEGnnigP6lMxqoo+S4oJrRwjanC95iHOZxxHvGBs+uzanVLCDMGBJDoEKZr+LW
 FafyJHwdLTvQoLDeJ6ofxNP45Vfy/4T8SNVlD9mDPWUWEVdiqzTnow90yqQOFBGDJ39+6URwYMk
 kEGHrqgtxbDw==
X-Google-Smtp-Source: AGHT+IH1eeAT8s6Oqma5zyC8EDC3TH1shCkQQPCskWKrxdp5WvgGWV1a7lYDQKl1J7lCQGcB9dT2sA==
X-Received: by 2002:a17:902:d4d2:b0:240:11cd:8502 with SMTP id
 d9443c01a7336-24011cd8924mr7638015ad.13.1753603401960; 
 Sun, 27 Jul 2025 01:03:21 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 21/82] target/arm: Implement dirtybit check for PIE
Date: Sat, 26 Jul 2025 22:01:53 -1000
Message-ID: <20250727080254.83840-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Both S1PIE and S2PIE have a bit to make software tracking
of dirty pages easier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  1 +
 target/arm/ptw.c            | 16 ++++++++++++++++
 target/arm/tcg/tlb_helper.c | 12 +++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fc82dd65e8..b6499683cc 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -754,6 +754,7 @@ struct ARMMMUFaultInfo {
     bool s1ptw;
     bool s1ns;
     bool ea;
+    bool dirtybit;  /* FEAT_S1PIE, FEAT_S2PIE */
 };
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 323fc8052d..820d5e65a0 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2306,6 +2306,22 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         goto do_fault;
     }
 
+    /* S1PIE and S2PIE both have a bit for software dirty page tracking. */
+    if (access_type == MMU_DATA_STORE && param.pie) {
+        /*
+         * For S1PIE, bit 7 is nDirty and both HA and HD are checked.
+         * For S2PIE, bit 7 is Dirty and only HD is checked.
+         */
+        bool bit7 = extract64(attrs, 7, 1);
+        if (regime_is_stage2(mmu_idx)
+            ? !bit7 && !param.hd
+            : bit7 && !(param.ha && param.hd)) {
+            fi->type = ARMFault_Permission;
+            fi->dirtybit = true;
+            goto do_fault;
+        }
+    }
+
     /* If FEAT_HAFDBS has made changes, update the PTE. */
     if (new_descriptor != descriptor) {
         new_descriptor = arm_casq_ptw(env, descriptor, new_descriptor, ptw, fi);
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 23c72a99f5..ae2acd6727 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -24,13 +24,13 @@ bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
     return regime_using_lpae_format(env, mmu_idx);
 }
 
-static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
+static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
                                             ARMMMUFaultInfo *fi,
                                             unsigned int target_el,
                                             bool same_el, bool is_write,
                                             int fsc)
 {
-    uint32_t syn;
+    uint64_t syn;
 
     /*
      * ISV is only set for stage-2 data aborts routed to EL2 and
@@ -75,6 +75,10 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
         /* Merge the runtime syndrome with the template syndrome.  */
         syn |= template_syn;
     }
+
+    /* Form ISS2 at the top of the syndrome. */
+    syn |= (uint64_t)fi->dirtybit << 37;
+
     return syn;
 }
 
@@ -176,7 +180,9 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
     int target_el = exception_target_el(env);
     int current_el = arm_current_el(env);
     bool same_el;
-    uint32_t syn, exc, fsr, fsc;
+    uint32_t exc, fsr, fsc;
+    uint64_t syn;
+
     /*
      * We know this must be a data or insn abort, and that
      * env->exception.syndrome contains the template syndrome set
-- 
2.43.0


