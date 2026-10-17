Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C020CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5n7-0004si-Ii; Sat, 17 Oct 2026 10:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xI5ma-0004qm-9x; Sat, 17 Oct 2026 10:53:13 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xI5mX-0006fa-3b; Sat, 17 Oct 2026 10:53:12 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4j6PtW75Gpz5B7RN;
 Sat, 17 Oct 2026 22:52:51 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl2.zte.com.cn with SMTP id 69HEqove033829;
 Sat, 17 Oct 2026 22:52:50 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Sat, 17 Oct 2026 22:52:53 +0800
X-Zmail-TransId: 3e816ad38bc5024-fb150
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH 1/3] target/riscv/kvm: Detect SBI STA extension support
Date: Sat, 17 Oct 2026 22:51:45 +0800
Message-ID: <20261017145211.219258-2-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261017145211.219258-1-wang.yechao255@zte.com.cn>
References: <20261017145211.219258-1-wang.yechao255@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69HEqove033829
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 17 Oct 2026 22:52:52 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD38BC3.001/4j6PtW75Gpz5B7RN
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Probe for the SBI STA extension by searching for a one-reg id built
from KVM_REG_RISCV_SBI_EXT and KVM_RISCV_SBI_EXT_STA in the register
list returned by KVM, following the existing SBI DBCN pattern, and
record the result in kvm_sbi_sta.supported.

This patch only adds capability detection; nothing consumes
kvm_sbi_sta.supported yet. The register synchronization that uses it
is added by a subsequent patch.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
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


