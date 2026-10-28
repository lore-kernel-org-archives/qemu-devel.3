Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFEF606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4EE-0006Mf-2I; Wed, 28 Oct 2026 10:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xM4E6-0006ML-Lf; Wed, 28 Oct 2026 10:02:02 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xM4E3-0001aB-O3; Wed, 28 Oct 2026 10:02:02 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-01 (Coremail) with SMTP id qwCowACHW+80AOJqYJHjCw--.4832S2;
 Wed, 28 Oct 2026 22:01:46 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 nutty.liu@hotmail.com, Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH v3] target/riscv/kvm: Translate MSI addresses through the IOMMU
Date: Wed, 28 Oct 2026 22:01:22 +0800
Message-ID: <20261028140122.1560-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHW+80AOJqYJHjCw--.4832S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw13tF1rKF17tF45Xry8AFb_yoWrAr13pr
 ZxC3y3CrWrtrZIva9aqF1kJr15XFZ5Wa45Gw47Zwnavw4rXrW3urs7K3srtry5J3W8Gw1Y
 ga1UAFW5ur12qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
 rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
 v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
 xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
 kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
 6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
 CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUTuWQUUUUU
 =
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

Translate MSI addresses through the device's IOMMU AddressSpace when
setting up KVM routes. Only direct mappings to an IMSIC MemoryRegion
are installed in KVM routes.

Other IOMMU MSI remapping forms are not converted to KVM routes and
continue to use the existing userspace MSI delivery path.

Select PCI for RISCV64 KVM builds, as QEMU currently enables the
RISC-V KVM target only for riscv64-softmmu builds and the MSI route
fixup requires PCI support. Also trace translation failures to help
diagnose route setup failures.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---

Changes in v3:
- Remove the unused length variable and pass NULL to
  address_space_translate(), following Nutty Liu's review.

Changes in v2 (based on Alistair Francis's review):
- Select PCI for RISCV64 KVM builds.
- Add trace events for MSI translation failures.

 target/riscv/Kconfig       |  2 ++
 target/riscv/kvm/kvm-cpu.c | 54 ++++++++++++++++++++++++++++++++++++++
 target/riscv/trace-events  |  4 +++
 3 files changed, 60 insertions(+)

diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index 11bc09b414..0cf2c8e1c4 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -7,3 +7,5 @@ config RISCV64
     bool
     select ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
+    # kvm_arch_fixup_msi_route() needs to access PCIDevice
+    select PCI if KVM
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 45ad5e1525..a1eecd72b7 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1507,6 +1507,60 @@ int kvm_arch_release_virq_post(int virq)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
+    AddressSpace *as;
+    hwaddr xlat, translated;
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
+    mr = address_space_translate(as, address, &xlat, NULL, true,
+                                 MEMTXATTRS_UNSPECIFIED);
+
+    if (!mr) {
+        trace_kvm_riscv_fixup_msi_route_failed(address,
+                                               "address translation failed",
+                                               "none");
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
+        trace_kvm_riscv_fixup_msi_route_failed(address,
+                                               "non-IMSIC target",
+                                               memory_region_name(mr));
+        return 1;
+    }
+
+    section = memory_region_find(mr, xlat, 1);
+    if (!section.mr) {
+        trace_kvm_riscv_fixup_msi_route_failed(address,
+                                               "memory region lookup failed",
+                                               memory_region_name(mr));
+        return 1;
+    }
+
+    translated = section.offset_within_address_space;
+    memory_region_unref(section.mr);
+
+    route->u.msi.address_lo = translated;
+    route->u.msi.address_hi = translated >> 32;
+    trace_kvm_riscv_fixup_msi_route_translated(address, translated);
     return 0;
 }
 
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 93837f82a1..50980c031d 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -12,3 +12,7 @@ mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": write msecc
 
 # op_helper.c
 riscv_exception(uint32_t exception, const char *desc, uint64_t epc) "%u (%s) on epc 0x%"PRIx64""
+
+# kvm-cpu.c
+kvm_riscv_fixup_msi_route_translated(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
+kvm_riscv_fixup_msi_route_failed(uint64_t iova, const char *reason, const char *region) "MSI iova = 0x%"PRIx64" failed: %s (region=%s)"
-- 
2.53.0


