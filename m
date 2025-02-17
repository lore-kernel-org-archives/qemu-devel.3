Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F43C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwKC-0001ya-2x; Mon, 17 Feb 2025 03:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwK9-0001y8-Rq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:17:54 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwK8-0000zX-5n
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:17:53 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6e672a21b9dso15955896d6.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780271; x=1740385071; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XmLG5UQJV7cOfmKz1oOTzmfuK6M6OFxQ8TpTbwfoB7Q=;
 b=YCVQ8iP0F37aXlVVeCjjSPzzg6x9/fvFF0NC8Hm7KcuJ3a1/dA9kYygxcYdLdObN3M
 q+qBqTvjhiDpKR97k2wpXDCUkdSvLojO1ty8K9ezf1vO1YEZsABPP7MicjGvV4i2va/y
 Hnza+IcC6sx93USrai1iiDjEHm9XoFw+PCt9XSkYd7Rw7ltuC7anFkYuJVv5gXI2TZLd
 B3hf23t1EtEMlegXWUM5GSkHfAQwV2hDrAiGbr/Dd6e/x2LQtDdouNmWkBjK2hAiPMvT
 f0BCUYUabTXZBTmBnQ+AJpHyq4mKuGxGQ5tYb6n0ar6lrPi6UK9kMY97JADtNZhruRAH
 9s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780271; x=1740385071;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XmLG5UQJV7cOfmKz1oOTzmfuK6M6OFxQ8TpTbwfoB7Q=;
 b=ahbkUTVdXHLRWEcRxks7IgVlpMVoB8S0Vn5XH4YHVPzozzzpTDF0NONPUtDbOedAb0
 D9C6PjDy9kBiuXjwZU1u2w4Z1rwYxJZf1yMBdreabSEAkXMwXvnSl6z7WG499GF5Dnz4
 Xji24+hTbyTWVMoxv7CiLSMeGNJhT5lhKaPB1ytSr6Wa8o8Zkc4G80bIDuPo2UtjTYJf
 iDwbPsZhBEIykyrAZyVGGlF07OOAMOLqYe2G8sG5gcW8CH4S3ua5XK9TBJgNVPOd1E9W
 nO8WfLdXetirqbG1QfAPhxxZegB3P+IDOghtgBaoxzNQEobi4tqfSXQQbVcRY3jQ02v2
 tS2g==
X-Gm-Message-State: AOJu0YxYPNoNuHIs3luWhtglwieFjnBSVQIEVOMw7ouMnR0VBM06Styv
 ukASyaN9fUsQvTtM3NKVQz4fWCGHIuSwvVJGSTNNcwv433o1WCUQRNnOVYlzPg2GkGjB0xRyJTL
 9DMB5Pqw3LWHNhyqhPlJQd/KCOs9EoShWAZVGJHOzt8fKJ1KZ2ZRbBTEzmxtbWdjViuAyuMBT88
 fK2bb637Ud2Kz+x3tnLy477SMXpA+Tu4QOv4T6sznlFA==
X-Gm-Gg: ASbGncsXpD7z8t2kxzB+6gAQxcUQfhqWAcmSo6XJC6kTCtQGmrwGt4Ra1q1nQmzm+d8
 hAAIi24BRElNw+qj7HOO/6N/dX+w3Gu5XPTHIZVa9AgMGR5+NFbAyr8WUTjVc2HIZ+d3i5N/KCQ
 cbYU1zlZC4jytt2/PFDxJuVqd61+zPBrsNamhKVmrY0wPVTi+4TDrZTqEWfzDTR8AmBeaQNpe7G
 4B4AgwQ5zkXyx/v73oP7151cLz13Y/XCxvEVo5LOXiFumfc8bUrUEBvbe+Tl5CC47YdN4gwFfFL
 V6fcBYv6BoyVxnSZebhSb3MHx8dWUYRTrOHieqELvy4BZA==
X-Google-Smtp-Source: AGHT+IFce0ent2uBbLukL8x0M56RKYBaZm4XiBGTPGtm2Dhp9QYczsv+ZkZni+JuM4bKnQyoKziQ5Q==
X-Received: by 2002:ad4:5de8:0:b0:6e6:61f1:457f with SMTP id
 6a1803df08f44-6e66ccc1198mr139344766d6.18.1739780270540; 
 Mon, 17 Feb 2025 00:17:50 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65d9f38absm49673346d6.88.2025.02.17.00.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:17:50 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] target/riscv/kvm: rewrite get/set for KVM_REG_RISCV_CSR
Date: Mon, 17 Feb 2025 16:17:21 +0800
Message-Id: <20250217081730.9000-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217081730.9000-1-yongxuan.wang@sifive.com>
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qv1-xf30.google.com
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

As KVM_REG_RISCV_CSR includes several subtypes of CSR, rewrite the
related macros and functions to prepare for other subtypes.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 target/riscv/kvm/kvm-cpu.c | 70 +++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 23ce77935940..e315fea46973 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -111,9 +111,8 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, \
                            KVM_REG_RISCV_CORE_REG(name))
 
-#define RISCV_CSR_REG(env, name) \
-    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CSR, \
-                           KVM_REG_RISCV_CSR_REG(name))
+#define RISCV_CSR_REG(env, idx) \
+    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CSR, idx)
 
 #define RISCV_CONFIG_REG(env, name) \
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
@@ -130,17 +129,20 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
 
-#define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
+#define RISCV_GENERAL_CSR_REG(name) \
+    (KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(name))
+
+#define KVM_RISCV_GET_CSR(cs, env, idx, reg) \
     do { \
-        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
+        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, idx), &reg); \
         if (_ret) { \
             return _ret; \
         } \
     } while (0)
 
-#define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
+#define KVM_RISCV_SET_CSR(cs, env, idx, reg) \
     do { \
-        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
+        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, idx), &reg); \
         if (_ret) { \
             return _ret; \
         } \
@@ -605,36 +607,50 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     return ret;
 }
 
-static int kvm_riscv_get_regs_csr(CPUState *cs)
+static int kvm_riscv_get_regs_general_csr(CPUState *cs)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
-    KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
-    KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
-    KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
-    KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
-    KVM_RISCV_GET_CSR(cs, env, scause, env->scause);
-    KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
-    KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
-    KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sstatus), env->mstatus);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sie), env->mie);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stvec), env->stvec);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sscratch), env->sscratch);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sepc), env->sepc);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(scause), env->scause);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stval), env->stval);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sip), env->mip);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(satp), env->satp);
 
     return 0;
 }
 
-static int kvm_riscv_put_regs_csr(CPUState *cs)
+static int kvm_riscv_put_regs_general_csr(CPUState *cs)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
-    KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
-    KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
-    KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
-    KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
-    KVM_RISCV_SET_CSR(cs, env, scause, env->scause);
-    KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
-    KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
-    KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sstatus), env->mstatus);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sie), env->mie);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stvec), env->stvec);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sscratch), env->sscratch);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sepc), env->sepc);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(scause), env->scause);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stval), env->stval);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sip), env->mip);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(satp), env->satp);
+
+    return 0;
+}
+
+static int kvm_riscv_get_regs_csr(CPUState *cs)
+{
+    kvm_riscv_get_regs_general_csr(cs);
+
+    return 0;
+}
+
+static int kvm_riscv_put_regs_csr(CPUState *cs)
+{
+    kvm_riscv_put_regs_general_csr(cs);
 
     return 0;
 }
-- 
2.17.1


