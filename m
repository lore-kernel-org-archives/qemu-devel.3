Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542A606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 02:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLAfj-0006fU-2f; Sun, 25 Oct 2026 22:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLAfa-0006bd-0B; Sun, 25 Oct 2026 22:42:42 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLAfW-0002Np-Bt; Sun, 25 Oct 2026 22:42:41 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4jCdFb3Bq1z55y2H;
 Mon, 26 Oct 2026 10:42:27 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl2.zte.com.cn with SMTP id 69Q2gJuZ040589;
 Mon, 26 Oct 2026 10:42:19 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Mon, 26 Oct 2026 10:42:20 +0800
X-Zmail-TransId: 3e816adebe0b027-00c6d
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
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
Subject: [PATCH v5 1/4] target/riscv/kvm: create kvm_riscv_aia_access_reg
Date: Mon, 26 Oct 2026 10:40:40 +0800
Message-ID: <20261026024048.630015-2-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
References: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69Q2gJuZ040589
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 26 Oct 2026 10:42:27 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ADEBE13.000/4jCdFb3Bq1z55y2H
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Create common function kvm_riscv_aia_access_reg to access APLIC
and IMSIC regs

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/kvm/kvm-cpu.c   | 7 ++++++-
 target/riscv/kvm/kvm_riscv.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c085b22b23..3ed94f7586 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -58,6 +58,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 
 static bool cap_has_mp_state;
 static bool mp_state_reset;
+static int aia_fd = -1;
 
 #define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
                                          type | idx)
@@ -1924,13 +1925,17 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                     "auto");
 }
 
+void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool write)
+{
+    kvm_device_access(aia_fd, group, addr, val, write, &error_abort);
+}
+
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num)
 {
     int ret, i;
-    int aia_fd = -1;
     uint64_t default_aia_mode;
     uint64_t socket_count = riscv_socket_count(machine);
     uint64_t max_hart_per_socket = 0;
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index aef681f0a2..8649219e0e 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -29,6 +29,7 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
  * @level: %0 to clear the interrupt, non-zero to set it.
  */
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
+void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool write);
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
-- 
2.27.0


