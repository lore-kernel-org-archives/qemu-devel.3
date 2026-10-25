Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD44C606A31F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 12:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKx7B-0005fB-VP; Sun, 25 Oct 2026 08:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xKx79-0005ew-7C; Sun, 25 Oct 2026 08:14:15 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xKx76-000527-FU; Sun, 25 Oct 2026 08:14:14 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-01 (Coremail) with SMTP id qwCowACHXfGD8t1qmUOwCw--.36297S2;
 Sun, 25 Oct 2026 20:13:57 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH] target/riscv/kvm: Translate MSI addresses through the IOMMU
Date: Sun, 25 Oct 2026 20:13:33 +0800
Message-ID: <20261025121334.40041-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHXfGD8t1qmUOwCw--.36297S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw17tr1xKF1rJw4xJF4fKrg_yoW5Xr4rpF
 ZxCrWakrWrtry3Za93X3Wktr15XFZ5WF15Gry7Awnavw4rJrW5Cr4DK3sFkry5GF18Gw1j
 q3WqyF45ursFqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
 rcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I
 8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
 xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
 AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
 cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
 1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUPfHUUUUUU=
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

KVM irqfd bypasses the PCI device's IOMMU AddressSpace, so MSI
addresses requiring translation may fail to reach the guest IMSIC.

Translate MSI addresses through the device's IOMMU AddressSpace
when setting up KVM routes. Only direct IMSIC mappings are
supported; Basic MSI PTE and MRIF remapping are not.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---

The AddressSpace translation follows the existing
kvm_arch_fixup_msi_route() implementation on ARM.

 target/riscv/kvm/kvm-cpu.c | 45 ++++++++++++++++++++++++++++++++++++++
 target/riscv/trace-events  |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 45ad5e1525..565cdec9d2 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1507,6 +1507,51 @@ int kvm_arch_release_virq_post(int virq)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
+    AddressSpace *as;
+    hwaddr xlat, len = sizeof(uint32_t), translated;
+    MemoryRegionSection section;
+    MemoryRegion *mr;
+    Object *owner;
+
+    if (!dev) {
+        return 0;
+    }
+
+    as = pci_device_iommu_address_space(dev);
+    if (as == &address_space_memory) {
+        return 0;
+    }
+
+    RCU_READ_LOCK_GUARD();
+
+    mr = address_space_translate(as, address, &xlat, &len, true,
+                                 MEMTXATTRS_UNSPECIFIED);
+
+    if (!mr) {
+        return 1;
+    }
+
+    /*
+     * Only direct IMSIC writes can be represented by a KVM MSI route.
+     * MSI page-table translations instead target the RISC-V IOMMU trap
+     * region, which requires further BASIC/MRIF processing.
+     */
+    owner = memory_region_owner(mr);
+    if (!owner || !object_dynamic_cast(owner, TYPE_RISCV_IMSIC)) {
+        return 1;
+    }
+
+    section = memory_region_find(mr, xlat, 1);
+    if (!section.mr) {
+        return 1;
+    }
+
+    translated = section.offset_within_address_space;
+    memory_region_unref(section.mr);
+
+    route->u.msi.address_lo = translated;
+    route->u.msi.address_hi = translated >> 32;
+    trace_kvm_riscv_fixup_msi_route(address, translated);
     return 0;
 }
 
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 93837f82a1..5766fbb457 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -12,3 +12,6 @@ mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": write msecc
 
 # op_helper.c
 riscv_exception(uint32_t exception, const char *desc, uint64_t epc) "%u (%s) on epc 0x%"PRIx64""
+
+# kvm-cpu.c
+kvm_riscv_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
-- 
2.53.0


