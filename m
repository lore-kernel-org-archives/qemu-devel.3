Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88137606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJiW9-0001Fg-JN; Wed, 21 Oct 2026 22:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xJiW5-0001D2-R2; Wed, 21 Oct 2026 22:26:53 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xJiW3-0003S6-8s; Wed, 21 Oct 2026 22:26:53 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j995K5BPBz5B0qN;
 Thu, 22 Oct 2026 10:26:45 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 69M2QeLW024344;
 Thu, 22 Oct 2026 10:26:40 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Thu, 22 Oct 2026 10:26:42 +0800
X-Zmail-TransId: 3e816ad97461026-1c1d0
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH v2 1/3] target/riscv/kvm: Detect SBI STA extension support
Date: Thu, 22 Oct 2026 10:25:24 +0800
Message-ID: <20261022022535.437892-2-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261022022535.437892-1-wang.yechao255@zte.com.cn>
References: <20261022022535.437892-1-wang.yechao255@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69M2QeLW024344
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 22 Oct 2026 10:26:45 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD97465.001/4j995K5BPBz5B0qN
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Probe for the SBI STA extension by searching for a one-reg id built
from KVM_REG_RISCV_SBI_EXT and KVM_RISCV_SBI_EXT_STA in the register
list returned by KVM, following the existing SBI DBCN pattern, and
record the result in kvm_sbi_sta.supported.

This patch only adds capability detection; nothing consumes
kvm_sbi_sta.supported yet. The register synchronization that uses it
is added by a subsequent patch.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/kvm/kvm-cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c085b22b23..8ab43432dd 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -473,6 +473,12 @@ static KVMCPUConfig kvm_sbi_dbcn = {
                   KVM_REG_RISCV_SBI_EXT | KVM_RISCV_SBI_EXT_DBCN
 };
 
+static KVMCPUConfig kvm_sbi_sta = {
+    .name = "sbi_sta",
+    .kvm_reg_id = KVM_REG_RISCV | KVM_REG_SIZE_U64 |
+                  KVM_REG_RISCV_SBI_EXT | KVM_RISCV_SBI_EXT_STA
+};
+
 static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
 {
     uint64_t id, reg;
@@ -1233,6 +1239,19 @@ static void kvm_riscv_check_sbi_dbcn_support(RISCVCPU *cpu,
     }
 }
 
+static void kvm_riscv_check_sbi_sta_support(RISCVCPU *cpu,
+                                            struct kvm_reg_list *reglist)
+{
+    struct kvm_reg_list *reg_search;
+
+    reg_search = bsearch(&kvm_sbi_sta.kvm_reg_id, reglist->reg, reglist->n,
+                         sizeof(uint64_t), uint64_cmp);
+
+    if (reg_search) {
+        kvm_sbi_sta.supported = true;
+    }
+}
+
 static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
                                  struct kvm_reg_list *reglist)
 {
@@ -1365,6 +1384,7 @@ static void kvm_riscv_init_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     }
 
     kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
+    kvm_riscv_check_sbi_sta_support(cpu, reglist);
     kvm_riscv_read_csr_cfg(reglist);
 }
 
-- 
2.27.0


