Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD538CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqni-0004oT-5k; Wed, 30 Sep 2026 05:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xBqng-0004oC-RS; Wed, 30 Sep 2026 05:40:32 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xBqne-0008Gf-CS; Wed, 30 Sep 2026 05:40:32 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hvqlm1M1Sz5B0xh;
 Wed, 30 Sep 2026 17:40:20 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl1.zte.com.cn with SMTP id 68U9e08d021870;
 Wed, 30 Sep 2026 17:40:00 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Wed, 30 Sep 2026 17:40:03 +0800
X-Zmail-TransId: 3e816abcd8f2021-59554
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
Subject: [PATCH] target/riscv/kvm: Reset vCPU on VM reset via
 MP_STATE_INIT_RECEIVED
Date: Wed, 30 Sep 2026 17:39:37 +0800
Message-ID: <20260930093940.117729-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 68U9e08d021870
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 30 Sep 2026 17:40:20 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ABCD904.000/4hvqlm1M1Sz5B0xh
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When a VM reset is requested, KVM needs to reset the register state of
the vCPUs. Without this, stale KVM-internal vCPU state (such as the SBI
STA shared memory address) is preserved across the reset, which can
cause KVM to keep writing steal-time data to an address that now belongs
to firmware code, corrupting it.

Add support for the KVM_CAP_RISCV_MP_STATE_RESET capability. When
enabled, QEMU resets the vCPU by setting MP_STATE_INIT_RECEIVED through
the KVM_SET_MP_STATE ioctl during the KVM_PUT_RESET_STATE phase of
kvm_arch_put_registers(). KVM performs the register reset while
preserving the original MP_STATE, so no state restoration is needed on
the QEMU side.

This reset path is reached both when the guest initiates an SBI system
reset and when userspace (e.g. the QEMU monitor) requests a VM reset,
covering both reboot scenarios.

The capability is optional and only activated if the host kernel
advertises KVM_CAP_RISCV_MP_STATE_RESET, ensuring backward compatibility
with older kernels.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 target/riscv/kvm/kvm-cpu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 68e1501b21..30cea19dea 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -58,6 +58,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 }
 
 static bool cap_has_mp_state;
+static bool mp_state_reset;
 
 #define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
                                          type | idx)
@@ -1405,10 +1406,31 @@ static int kvm_riscv_put_mp_state(CPUState *cs)
     return kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
 }
 
+static int kvm_riscv_mp_state_init_received(CPUState *cs)
+{
+    struct kvm_mp_state mp_state = {
+        .mp_state = KVM_MP_STATE_INIT_RECEIVED,
+    };
+
+    if (!cap_has_mp_state || !mp_state_reset) {
+        return 0;
+    }
+
+    /* Let KVM resets the VCPU, The original MP_STATE is preserved*/
+    return kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
+}
+
 int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     int ret = 0;
 
+    if (KVM_PUT_RESET_STATE == level) {
+        ret = kvm_riscv_mp_state_init_received(cs);
+        if (ret) {
+            return ret;
+        }
+    }
+
     ret = kvm_riscv_put_regs_core(cs);
     if (ret) {
         return ret;
@@ -1585,6 +1607,11 @@ int kvm_arch_get_default_type(MachineState *ms)
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
+
+    if (cap_has_mp_state) {
+        mp_state_reset = !kvm_vm_enable_cap(s, KVM_CAP_RISCV_MP_STATE_RESET, 0);
+    }
+
     return 0;
 }
 
-- 
2.27.0


