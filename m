Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CDBE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 17:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vslCj-0005UO-Fr; Wed, 18 Feb 2026 12:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vslCS-0005Q6-Vm
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:19:01 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vslCO-0005bj-6M
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=LnNbdLp6lQkk91nnwZLN8LDmCRe89n2NmaZDvq59+QA=; b=C/gJ8DR3bhcrFV5
 keA9iPRwGad6D5iQaYFxDsA1NsTRDOzfqyhegk/4Qgw5fH/Cs3namKa9wnWwWR3VyI96nywOGBDMQ
 pqx1gk9X9YNmOjjfGAqZ77L2u7MMJgeY8GWdGZAxqdwWCaXrMJeBZjZq+limyBcNRLmiUZhXAu64n
 ec=;
Date: Wed, 18 Feb 2026 18:21:32 +0100
Subject: [PATCH v6 6/7] hw/riscv: Set IOMMU PAS via property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-phys_addr-v6-6-a603bf363218@rev.ng>
References: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
In-Reply-To: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771435335; l=4281;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=dlOqt+TTtplPC4FQ9ACzr9DxXad4u3ktCRVuu39x550=;
 b=THl3UN1A24W+CHvt1EgKc3BBOF0+bvJ1Mexi59eQOiaHaglsPzcRIiACJWHnyF+rVzH0Rso2f
 dI8C9OSBFMVBIpUarYR63houZRDezdgma+vpiktNiulLGqf+UA4x0VU
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replaces the only remaining use of TARGET_PHYS_ADDR_SPACE_BITS for RISCV
with a property RISCVIOMMUState::pas_bits that gets written to the
capabilities field upon device realization.  This write needs to happen
at realize-time to ensure the property has been set.

For the virt machine and sysbus device, pas_bits is set by
virt_machine_init() to either 34 or 56 bits, retaining previous behaviour.
However, for the PCI device we do not have access to the CPU state, and
instead use the maximum riscv64 value of 56 bits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 hw/riscv/riscv-iommu.h     | 1 +
 hw/riscv/riscv-iommu-pci.c | 3 +++
 hw/riscv/riscv-iommu.c     | 8 ++++----
 hw/riscv/virt.c            | 7 +++++++
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 2dabd86941..2a9f6fccd5 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -34,6 +34,7 @@ struct RISCVIOMMUState {
     /*< public >*/
     uint32_t version;     /* Reported interface version number */
     uint32_t pid_bits;    /* process identifier width */
+    uint32_t pas_bits;    /* physical address bits */
     uint32_t bus;         /* PCI bus mapping for non-root endpoints */
 
     uint64_t cap;         /* IOMMU supported capabilities */
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 5f7d359204..14dd5f3857 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -158,6 +158,9 @@ static void riscv_iommu_pci_init(Object *obj)
 
     iommu->icvec_avail_vectors = RISCV_IOMMU_PCI_ICVEC_VECTORS;
     riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_MSI);
+
+    /* Report maximum physical address size of riscv64 */
+    iommu->pas_bits = 56;
 }
 
 static const Property riscv_iommu_pci_properties[] = {
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b46b337375..98345b1280 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2453,10 +2453,6 @@ static void riscv_iommu_instance_init(Object *obj)
     /* Enable translation debug interface */
     s->cap = RISCV_IOMMU_CAP_DBG;
 
-    /* Report QEMU target physical address space limits */
-    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
-                       TARGET_PHYS_ADDR_SPACE_BITS);
-
     /* TODO: method to report supported PID bits */
     s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */
     s->cap |= RISCV_IOMMU_CAP_PD8;
@@ -2487,6 +2483,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
+    /* Report QEMU target physical address space limits. */
+    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS, s->pas_bits);
+
     s->cap |= s->version & RISCV_IOMMU_CAP_VERSION;
     if (s->enable_msi) {
         s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
@@ -2645,6 +2644,7 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
 static const Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
+    DEFINE_PROP_UINT32("pas-bits", RISCVIOMMUState, pas_bits, 0),
     DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
     DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
         LIMIT_CACHE_IOT),
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 07e66b3936..bbce2fb667 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1739,6 +1739,13 @@ static void virt_machine_init(MachineState *machine)
         object_property_set_link(OBJECT(iommu_sys), "irqchip",
                                  OBJECT(mmio_irqchip),
                                  &error_fatal);
+        /*
+         * For riscv64 use a physical address size of 56 bits (44 bit PPN),
+         * and for riscv32 use 34 bits (22 bit PPN).
+         */
+        object_property_set_uint(OBJECT(iommu_sys), "pas-bits",
+                                 riscv_is_32bit(&s->soc[0]) ? 34 : 56,
+                                 &error_fatal);
 
         sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
     }

-- 
2.52.0


