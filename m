Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0440606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vmexit.de header.i=@vmexit.de header.a=rsa-sha256 header.s=mail header.b=ikABUuVD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzJ2-0006xt-Qn; Thu, 22 Oct 2026 16:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJzIx-0006vl-Dw; Thu, 22 Oct 2026 16:22:27 -0400
Received: from vmexit.de ([159.195.53.62] helo=gizmo.vmexit.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJzIv-0006zO-AG; Thu, 22 Oct 2026 16:22:26 -0400
From: Ralf Ramsauer <ralf@vmexit.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmexit.de; s=mail;
 t=1792700542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r+mpMDVCNtI0vFaDlSQA7QXB7K/EOFIthhvvATom6gs=;
 b=ikABUuVD2U331c+Uj1JYmZgO2jXFke0A0pK4oMI8njr0QDKi0i1+rxv+A1lGpUn9lOC/kr
 l1CdBVqkuO8Yh3liIIowB+m7kBO6iZyDAtsewULam7U8lN0bTPrLwGYIkDZtD+K9P9/kW6
 M2FurjJ198nIgOdYWz3dzcuhgHW8L5s=
To: qemu-devel@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Ralf Ramsauer <ralf@vmexit.de>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
Subject: [PATCH v3 1/4] target/riscv: add riscv_cpu_has_supervisor_mode()
Date: Thu, 22 Oct 2026 22:22:15 +0200
Message-ID: <7ce612fe810e410dcac32b9da863182b1f6d2c5e.1792700406.git.ralf@vmexit.de>
In-Reply-To: <cover.1792700406.git.ralf@vmexit.de>
References: <cover.1792700406.git.ralf@vmexit.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=159.195.53.62; envelope-from=ralf@vmexit.de;
 helo=gizmo.vmexit.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>

Whether a hart has supervisor mode is decided in two places: KVM harts
always have it, and for TCG it follows from RVS in the ISA string.
riscv_plic_hart_config_string() already spells out both cases.

Board code needs the same answer to describe the interrupt controller,
but it should not have to reach into CPURISCVState for it.  Add a helper
next to riscv_cpu_is_vendor() so the next patches can ask the CPU
instead of inspecting its internals.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 14 ++++++++++++++
 target/riscv/cpu.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08a4d14ea1..7be1c65902 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -338,6 +338,20 @@ bool riscv_cpu_is_vendor(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_VENDOR_CPU) != NULL;
 }
 
+bool riscv_cpu_has_supervisor_mode(RISCVCPU *cpu)
+{
+#ifndef CONFIG_USER_ONLY
+    /* KVM always provides supervisor mode, regardless of the ISA string */
+    if (kvm_enabled()) {
+        return true;
+    }
+
+    return riscv_has_ext(&cpu->env, RVS);
+#else
+    return false;
+#endif
+}
+
 const char * const riscv_int_regnames[] = {
     "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
     "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b65d631994..a7509b0114 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -995,6 +995,7 @@ void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
 void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
 bool riscv_cpu_is_vendor(Object *cpu_obj);
+bool riscv_cpu_has_supervisor_mode(RISCVCPU *cpu);
 
 typedef struct isa_ext_data {
     const char *name;
-- 
2.54.0


