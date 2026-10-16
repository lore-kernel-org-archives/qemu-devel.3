Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A48CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWN7-0001PP-Sp; Thu, 15 Oct 2026 21:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLo-0000Jj-5h
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLi-0004EL-Fd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:09 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2d71d1cc8b2so31956865ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112585; x=1792717385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Se/8NwHIL/oM2z+UeIiSfMT2la1VTJrbxJq6EnwflRc=;
 b=IYm+DkMCY8ezDgyo78eLm/28J4ZXDhOsPhxjYrlOabdbWCNB29aYV6ZjX6eStT/FFH
 q8PtIKXsDV2IMjuxvcKDcUNy/FNMx6j8a/QMayAC3RH4JoFHNG85eaDsBPmMMEcxyOWm
 8Qe90Vk0BcQioopyIAj9a+P21R0R72ncag+uzqK1nSgsrF8L7tunAYlZJU6zMwtG/N41
 SpeIjvdRiCQt02SPOsXuWn5CeGkBD+pfz6GsFRnpXt9O7w6BCeIGSVPEm412JzN5jeyr
 RBIjBlOXUOv8UY9ayqcYmXogTB9Hcbfx9rQ5jTNJ8N9MpzXxlO2VyrocjRTKFl1jsHx5
 WH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112585; x=1792717385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Se/8NwHIL/oM2z+UeIiSfMT2la1VTJrbxJq6EnwflRc=;
 b=rQet0TbpYlvmrZbjrU9x6c077WIYCrLQj/lCkAmtikiphe9vjZkPB2qMAf5wpbSoDH
 V+CKEr7cQFk9qiqSdiuUd0+/9SWQ92ewdArZQAI7wva4nwomdZbcjIRJF4LPSYLvyybe
 tzqkc3FBuCw1iLl7651v2uq3aw0RBvEopT5/lJSbet8mWbnl+FyumsPBSykDQX1vXvqY
 wtYjTTY0zyCbjxNG69XQJySrS7nerfSeE9lGn9OfVyLRgko2gtHVL+jcaiLuWmvFOpi9
 mFpwFFPeOJyjqncc2yydPTpG3PvIEw6g/Etyb405R3V8tKE/XVpMLPG+zvQ+7yRgp9i5
 YqQQ==
X-Gm-Message-State: AFq9FYI/8ioGCt3pXJdaPosfq8leoWUEi86ExH6sgDy9/vmD9sE9pWbw
 F8x80t7wvFeXZwBuitnjswK3fw1aOFabKfOSzt0UGyiGX7wlO8gZ1w5/95YYcQ==
X-Gm-Gg: AYBFou3FY1o+s9HhEzK1U/9phip6co7u9FrqVRxH3he3xaQrRH3iWWO0BPnmQcHBIxh
 4xliuOzyepGPxeode+saxywkG6iYdIZl/1IMkmY+eAbuspCq7O990YrS0cV01S9xgQUdmv3W9RU
 23E+X9uhvE7mUYn/T3Z05ce46ANvO7RzTT7HNFrNRlqmS+nnBO6Us5ntcT4C9a3OBL2nXMLbGRZ
 mKWl6PYStNyhZnCgLIL0abLhNh3owFq6LLh/DcP69m2w3dvL22+AD6bHi68KU3g+znSLnQ/XRPx
 epB+ioUOX97MeK8jsotliAB69r3dzH/kG8COTWnBWdtVvZ+c94q/6mi1NxhpSd6WlCuPvjr9phT
 qqadFuzOnD+1NJCsul6eovA0TuOM7dG20tvNSBeHb9NwgOIxH124nTBls1q0GjDghDqlyBD0pzJ
 ASDdGU6/azKJpqUS54e10tL5WKCDUPEcQ8Ii3bXeSN7C9Z/D/KcRBGwsPJCyDQasULZ5SQio8b7
 S7RT/U3DqzaOjwVDGbILfbtFN4=
X-Received: by 2002:a17:902:f54a:b0:2e9:628d:e9c1 with SMTP id
 d9443c01a7336-2e9628df363mr35212715ad.26.1792112585019; 
 Thu, 15 Oct 2026 18:03:05 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Xie Bo <xb@ultrarisc.com>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 06/50] target/riscv/kvm: Preserve FCSR across migration
Date: Fri, 16 Oct 2026 11:01:53 +1000
Message-ID: <20261016010237.1102834-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Xie Bo <xb@ultrarisc.com>

kvm_riscv_get_regs_fp() and kvm_riscv_put_regs_fp() handle f0-f31
but not FCSR.  KVM exposes FCSR as a separate 32-bit register in both
the F and D register groups, so frm and fflags are lost after migration.

Read and write FCSR together with the FP registers and save it in a
KVM-only subsection.  Older streams do not contain the subsection; in
that case the destination keeps its reset value.

Fixes: 937f0b45120b ("target/riscv: Implement kvm_arch_get_registers")
Fixes: 9997cc1e19d1 ("target/riscv: Implement kvm_arch_put_registers")
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260831074106.1798671-2-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  3 +++
 target/riscv/kvm/kvm-cpu.c | 20 ++++++++++++++++----
 target/riscv/machine.c     | 27 +++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c8ffe94cd..25f8ec00a9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -535,6 +535,9 @@ struct CPUArchState {
     hwaddr fdt_addr;
 
 #ifdef CONFIG_KVM
+    /* KVM floating-point state */
+    uint32_t kvm_fcsr;
+
     /* kvm timer */
     bool kvm_timer_dirty;
     uint64_t kvm_timer_time;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 68e1501b21..c8ccd9124e 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -111,6 +111,14 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
 
 #define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, idx)
 
+#define RISCV_FP_F_FCSR_REG \
+    KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_F, \
+                         KVM_REG_RISCV_FP_F_REG(fcsr))
+
+#define RISCV_FP_D_FCSR_REG \
+    KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_D, \
+                         KVM_REG_RISCV_FP_D_REG(fcsr))
+
 #define RISCV_VECTOR_CSR_REG(name) \
     KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
@@ -743,7 +751,8 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
             }
             env->fpr[i] = reg;
         }
-        return ret;
+        return kvm_get_one_reg(cs, RISCV_FP_D_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     if (riscv_has_ext(env, RVF)) {
@@ -755,7 +764,8 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
             }
             env->fpr[i] = reg;
         }
-        return ret;
+        return kvm_get_one_reg(cs, RISCV_FP_F_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     return ret;
@@ -776,7 +786,8 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
                 return ret;
             }
         }
-        return ret;
+        return kvm_set_one_reg(cs, RISCV_FP_D_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     if (riscv_has_ext(env, RVF)) {
@@ -788,7 +799,8 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
                 return ret;
             }
         }
-        return ret;
+        return kvm_set_one_reg(cs, RISCV_FP_F_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     return ret;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index bf203bffce..3238912b63 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -197,6 +197,32 @@ static const VMStateDescription vmstate_rv128 = {
 };
 
 #ifdef CONFIG_KVM
+static bool kvm_fcsr_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    return kvm_enabled() &&
+           (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD));
+}
+
+static int kvm_fcsr_post_load(void *opaque, int version_id)
+{
+    return kvm_enabled() ? 0 : -ENOTSUP;
+}
+
+static const VMStateDescription vmstate_kvm_fcsr = {
+    .name = "cpu/kvm-fcsr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvm_fcsr_needed,
+    .post_load = kvm_fcsr_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.kvm_fcsr, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool kvmtimer_needed(void *opaque)
 {
     return kvm_enabled();
@@ -564,6 +590,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_pointermasking,
         &vmstate_rv128,
 #ifdef CONFIG_KVM
+        &vmstate_kvm_fcsr,
         &vmstate_kvmtimer,
         &vmstate_kvm_mp_state,
 #endif
-- 
2.55.0


