Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958E1CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3Dq-00083m-V5; Mon, 01 Sep 2025 08:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ut3DS-0007Yj-99; Mon, 01 Sep 2025 08:00:59 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ut3DF-0004H5-Lf; Mon, 01 Sep 2025 08:00:53 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 581C0CVL013478
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Sep 2025 21:00:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=D+nZEAotU7RSIcgMm43EklAPwfbjaT+CdW78+OLt6sc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1756728022; v=1;
 b=hSD19wHohaNJlLyAD/o8kwplzyecgzgTsC6OUMnlybKI90fZXe6YcN1NAgNN74T6
 oipyh9G4wMBlKW55rVRjgyNeqOrXn6i193ZRssOOCFG+bSwyqJXS32UG2GqPiFze
 bN578ZK3krM5uxnsVZj6a1xIuOw5uOELyPWKqFGp/15zFbbZZSWnDDrXgoCufriP
 lrDg1KHH4sthAtf0IDq21RATV2mc6NShM1ZqqcuI1uGkRibteJjoovVX3AHTClB9
 WV31P7ytHtsmLIbPMvKfAUFnzTCaVTW4bSzWs9Wqj4gRsHGa08PUObKSmUSdGE0S
 EjQRoCrrU3FvCZjdm0HeJA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 01 Sep 2025 21:00:04 +0900
Subject: [PATCH v2] hw/arm/virt: Remove the lower bound of HighMem IO Regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-virt-v2-1-ac2379402c80@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAMOKtWgC/12NwQ6CMBAFf4Xs2Ta0RKye/A/DoZQCqwnFbWkkp
 P9uxYOJx5m8zNvAW0Lr4VJsQDaiRzdlkIcCzKinwTLsMoMs5bE8ScUiUmCqqjrd69oI0UKezmR
 7fO2ZW/Nlss8l18JPjuiDo3W/iuJj/6pRMMFK3Z5rJWUtjbqSH7hBjnxhwT1Wx7Xh9xmalNIbY
 4bZ6roAAAA=
X-Change-ID: 20250728-virt-833dafa6c11b
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Remove the lower bound of the Highmem IO Regions' addresses for the
latest machine version to increase the chance to fit the regions in the
PA space.

The lower bound was especially problematic when using virt-install on
Apple M2. virt-install 5.0.0 adds multiple pcie-root-port devices that
require sufficient space in the ECAM region. However, the Highmem ECAM
region did not fit in the limited PA space on the hardware, and the ECAM
region size was limited to 16 MiB. If virt-install had added more than
16 devices to the root bridge, the region overflowed, which prevented
edk2-stable202505 from scanning PCI devices, including the boot disk,
causing boot failures.

Ideally, a virtual machine with more than 16 devices added to the root
bridge should just work so that users and management layers do not have
to care whether they use constrained hardware.

The base address of the Highmem IO Regions was fixed when commit
f90747c4e8fb ("hw/arm/virt: GICv3 DT node with one or two redistributor
regions") added the first Highmem IO Region. Later, commit 957e32cffa57
("hw/arm/virt: Dynamic memory map depending on RAM requirements")
allowed moving the Highmem IO Regions to higher addresses to accommodate
RAM more than 255 GiB, but the lower bound remained to keep the legacy
memory map.

Remove the lower bound for the latest machine version to accommodate more
devices with the root bridge. Keeping the lower bound for the old
machine versions ensures the compatibility is still maintained.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Rebased.
- Link to v1: https://lore.kernel.org/qemu-devel/20250728-virt-v1-1-0ab9682262c8@rsg.ci.i.u-tokyo.ac.jp
---
 include/hw/arm/virt.h |  1 +
 hw/arm/virt.c         | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 365a28b082cae36321ed906d9a13242997fa543a..341eb171d084b911e05b9861b9f4ba516fa2888e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -120,6 +120,7 @@ typedef enum VirtGICType {
 
 struct VirtMachineClass {
     MachineClass parent;
+    hwaddr min_highmem_base;
     bool no_tcg_its;
     bool no_highmem_compact;
     bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1e63f40fbece3997dedc8aa953957471f930d44c..3cb978dae2ec0cdd9e7b902b3b427dac8a27bebf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1887,6 +1887,7 @@ static void virt_set_high_memmap(VirtMachineState *vms,
 static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
 {
     MachineState *ms = MACHINE(vms);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     hwaddr base, device_memory_base, device_memory_size, memtop;
     int i;
 
@@ -1913,8 +1914,7 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     /*
      * We compute the base of the high IO region depending on the
      * amount of initial and device memory. The device memory start/size
-     * is aligned on 1GiB. We never put the high IO region below 256GiB
-     * so that if maxram_size is < 255GiB we keep the legacy memory map.
+     * is aligned on 1GiB.
      * The device region size assumes 1GiB page max alignment per slot.
      */
     device_memory_base =
@@ -1932,8 +1932,8 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
         error_report("maxmem/slots too huge");
         exit(EXIT_FAILURE);
     }
-    if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
-        base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
+    if (base < vmc->min_highmem_base) {
+        base = vmc->min_highmem_base;
     }
 
     /* We know for sure that at least the memory fits in the PA space */
@@ -3464,8 +3464,16 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
 
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_10_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+
+    /*
+     * Do not put the high IO region below 256GiB so that if maxram_size is
+     * < 255GiB we keep the legacy memory map.
+     */
+    vmc->min_highmem_base = base_memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
 }
 DEFINE_VIRT_MACHINE(10, 1)
 

---
base-commit: e101d33792530093fa0b0a6e5f43e4d8cfe4581e
change-id: 20250728-virt-833dafa6c11b

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


