Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E82DC021A7
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwKg-0002ME-Ny; Mon, 17 Feb 2025 03:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwKf-0002KT-D7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:18:25 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwKd-00012c-IR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:18:25 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6e66a7e2754so17547996d6.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780302; x=1740385102; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EDqmSZADlm9MRwQGQNXH9b0njTbR5RxIBA++PzJx4XE=;
 b=SCegvbxGPn+z4yp/S05TQxZWu262f6lIa0RmVpbuP6+S3RntDR7fN6ccmeBVALzWQ5
 TAGdP3ltlP9r6ZlczPtVdXAuyAtNLOmBnmiC6djpBKfEENFshELVU8JpJaJdzkY488DO
 f2O30+iNaeSZw8btc0qVQ5jeySVKrQPTUQo8egyv1yEnvOkNxoyTicFxzwbYjEu/qPZS
 BWa100B9Ok1jxSQFJP57eE2eUL6eQMnMPc7FHyLMj3vc/+kpVFs7466AhZSWrnxnEse7
 GzezpLnmYK5u3Hz+ZTshNXO3h+AD+/D+oD3jRiG3rnjK45zwMl/5jo3FrebWtCiExIvi
 ghtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780302; x=1740385102;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EDqmSZADlm9MRwQGQNXH9b0njTbR5RxIBA++PzJx4XE=;
 b=ZwBOmeiIC9FiBVHVzX5V/prk2XpKdYAPiXIp/sCPoSB3I+RIpY9qjpdgFo2jvVoXP3
 cCTkfnMtoUt0tHGoxEcltzfVJ1DUuPjCGJ6IHsc2JimbyXc3lashSMUUETr7DeOZqlTb
 0gZSCsrBchT9hCEbbTu8brz+iKBqQ8RSFO7lBT5Y/VzdG611xJtNjILzIJAtuYGiyY07
 GQvCSXnUcAfMremTj+J3cQqY9yYrv+SH5qiropXJln1elxWht8mAInAcIG8wWvdRUouW
 /dygEB/IqFuMK1mlWgV4VsN6mA4UI9Q3ZPM2d8FSLVedLkNEfqTILt5KdC2FYnNQ3NMx
 QchQ==
X-Gm-Message-State: AOJu0Yz8+o1EL64ffLNtyL5/znvNO+arNoROvyfXCX2PG4Ulu6spJm/N
 Kh+JqUOaIxDIhs+7Z4chG5hsxQ3w/e8JJWB1SF1XnjE/ZYRq0KBPXQ0n+/RHCk03uhsfoWteJPk
 IIxAbYuI2R8GnFst0vA72yi7+HxJ2WvXAxkN9zMkKhzqVtcXZpEWBlFUbBMoNJHw+AvvjNTB1/z
 DDX0cA7pL5eiUTNiCjZ+9ekmXhoHxpWpByq+Ave1Bylg==
X-Gm-Gg: ASbGncuUJGaztSZ4af54O7PEGDO9Hk/FJLdgqjZ5MFjYA5OkKu1483hpoNuYx1AwVl2
 Y42I7gZrJLLLLOFt8mQAH9AjLj+zyHy9m8Pb5jAamEvO8zTLmIdluYBq5Fw2OfTtfD0M0Cqo3RD
 ScQJcz8bqi4aEkKwHQTGg4HWmF4a/SwYXoStSv4WvIOm1CYt8D9CR5GJyZclI7LgFrQy92HJdJi
 NHwKW2PxtYldkkfmH2BqRqGCJj/o7UyaTGHquLaw3xNdf1nPguuxqVPl/GAttTrE+3x/W5iRD6R
 tBFbIik0QKbUM4JSjKpYl25VIsnUG6VK+3Tf5o2zW9Uz6Q==
X-Google-Smtp-Source: AGHT+IG71vS1Fax0pu9PH1lFY5laXyQXYeBvySClwVF+W1PQ054tyXmd3Y3rWR63HFZY/n1xf9jgJQ==
X-Received: by 2002:a05:6214:27c7:b0:6e1:700e:487a with SMTP id
 6a1803df08f44-6e66cf3db3dmr120145506d6.40.1739780302200; 
 Mon, 17 Feb 2025 00:18:22 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65d9f38absm49673346d6.88.2025.02.17.00.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:18:21 -0800 (PST)
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
Subject: [PATCH 6/8] target/riscv/kvm: add CSR_SIREG and CSR_STOPEI emulation
Date: Mon, 17 Feb 2025 16:17:26 +0800
Message-Id: <20250217081730.9000-7-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217081730.9000-1-yongxuan.wang@sifive.com>
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qv1-xf2e.google.com
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

Support user-space emulation of SIREG and STOPEI CSR with KVM
acceleration. For SIREG emulation, the SISELECT CSR value and iprio
array must be loaded before handling, and since the iprio array might
be modified, it must be written back after the emulation.

When running with KVM acceleration, the machine lacks M-mode CSRs and
does not report S-mode support in its environment configuration, even
though some S-mode CSRs are accessible. This patch adds kvm_enabled()
checks in relevant predicates to ensure proper handling and validation.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 target/riscv/csr.c         | 12 +++++++++---
 target/riscv/kvm/kvm-cpu.c | 27 +++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index df724575a5a0..95841ce65730 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -27,6 +27,7 @@
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
 #include "system/cpu-timers.h"
+#include "system/kvm.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include <stdbool.h>
@@ -42,6 +43,11 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
     csr_ops[csrno & (CSR_TABLE_SIZE - 1)] = *ops;
 }
 
+static bool riscv_has_ext_s(CPURISCVState *env)
+{
+    return riscv_has_ext(env, RVS) || kvm_enabled();
+}
+
 /* Predicates */
 #if !defined(CONFIG_USER_ONLY)
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
@@ -52,7 +58,7 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
         return RISCV_EXCP_NONE;
     }
 
-    if (!(env->mstateen[index] & bit)) {
+    if (!kvm_enabled() && !(env->mstateen[index] & bit)) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -66,7 +72,7 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
         }
     }
 
-    if (env->priv == PRV_U && riscv_has_ext(env, RVS)) {
+    if (env->priv == PRV_U && riscv_has_ext_s(env)) {
         if (!(env->sstateen[index] & bit)) {
             return RISCV_EXCP_ILLEGAL_INST;
         }
@@ -326,7 +332,7 @@ static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
 
 static RISCVException smode(CPURISCVState *env, int csrno)
 {
-    if (riscv_has_ext(env, RVS)) {
+    if (riscv_has_ext_s(env)) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index bcd28a355a66..c047d5f36951 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1624,6 +1624,31 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
 }
 
 /* User-space CSR emulation */
+static int kvm_riscv_emu_sireg_ctx_load(CPUState *cs)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(siselect), env->siselect);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
+
+    return 0;
+}
+
+static int kvm_riscv_emu_sireg_ctx_put(CPUState *cs)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
+
+    return 0;
+}
+
 struct kvm_riscv_emu_csr_data {
     target_ulong csr_num;
     int (*context_load)(CPUState *cs);
@@ -1632,6 +1657,8 @@ struct kvm_riscv_emu_csr_data {
 
 struct kvm_riscv_emu_csr_data kvm_riscv_emu_csr_data[] = {
     { CSR_SEED, NULL, NULL },
+    { CSR_SIREG, kvm_riscv_emu_sireg_ctx_load, kvm_riscv_emu_sireg_ctx_put },
+    { CSR_STOPEI, NULL, NULL },
 };
 
 static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
-- 
2.17.1


