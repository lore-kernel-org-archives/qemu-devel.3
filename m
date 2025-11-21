Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F00CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdWv-00021Y-Mb; Fri, 21 Nov 2025 21:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdWl-0001wV-3S; Fri, 21 Nov 2025 21:39:07 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdVl-00020X-9E; Fri, 21 Nov 2025 21:39:02 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BBACF16C6EF;
 Fri, 21 Nov 2025 16:51:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 20B0E32198C;
 Fri, 21 Nov 2025 16:52:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, peng guo <engguopeng@buaa.edu.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 23/76] hw/i386/pc: Avoid overlap between CXL window
 and PCI 64bit BARs in QEMU
Date: Fri, 21 Nov 2025 16:51:01 +0300
Message-ID: <20251121135201.1114964-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: peng guo <engguopeng@buaa.edu.cn>

When using a CXL Type 3 device together with a virtio 9p device in QEMU on a
physical server, the 9p device fails to initialize properly. The kernel reports
the following error:

    virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
    9pnet_virtio virtio0: probe with driver 9pnet_virtio failed with error -22

Further investigation revealed that the 64-bit BAR space assigned to the 9pnet
device was overlapped by the memory window allocated for the CXL devices. As a
result, the kernel could not correctly access the BAR region, causing the
virtio device to malfunction.

An excerpt from /proc/iomem shows:

    480010000-cffffffff : CXL Window 0
      480010000-4bfffffff : PCI Bus 0000:00
      4c0000000-4c01fffff : PCI Bus 0000:0c
        4c0000000-4c01fffff : PCI Bus 0000:0d
      4c0200000-cffffffff : PCI Bus 0000:00
        4c0200000-4c0203fff : 0000:00:03.0
          4c0200000-4c0203fff : virtio-pci-modern

To address this issue, this patch adds the reserved memory end calculation
for cxl devices to reserve sufficient address space and ensure that CXL memory
windows are allocated beyond all PCI 64-bit BARs. This prevents overlap with
64-bit BARs regions such as those used by virtio or other pcie devices,
resolving the conflict.

QEMU Build Configuration:

    ./configure --prefix=/home/work/qemu_master/build/ \
                --target-list=x86_64-softmmu \
                --enable-kvm \
                --enable-virtfs

QEMU Boot Command:

    sudo /home/work/qemu_master/qemu/build/qemu-system-x86_64 \
        -nographic -machine q35,cxl=on -enable-kvm -m 16G -smp 8 \
        -hda /home/work/gp_qemu/rootfs.img \
        -virtfs local,path=/home/work/gp_qemu/share,mount_tag=host0,security_model=passthrough,id=host0 \
        -kernel /home/work/linux_output/arch/x86/boot/bzImage \
        --append "console=ttyS0 crashkernel=256M root=/dev/sda rootfstype=ext4 rw loglevel=8" \
        -object memory-backend-ram,id=vmem0,share=on,size=4096M \
        -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
        -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
        -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,sn=0x123456789 \
        -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G

Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a machine parameter")
Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250805142300.15226-1-engguopeng@buaa.edu.cn>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit d1193481dee63442fc41e47ca6ebc4cd34f1f69c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0861e329b5..1bdd3a6e56 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -836,6 +836,7 @@ void pc_memory_init(PCMachineState *pcms,
     hwaddr maxphysaddr, maxusedaddr;
     hwaddr cxl_base, cxl_resv_end = 0;
     X86CPU *cpu = X86_CPU(first_cpu);
+    uint64_t res_mem_end;
 
     assert(machine->ram_size == x86ms->below_4g_mem_size +
                                 x86ms->above_4g_mem_size);
@@ -977,16 +978,17 @@ void pc_memory_init(PCMachineState *pcms,
 
     rom_set_fw(fw_cfg);
 
-    if (machine->device_memory) {
-        uint64_t *val = g_malloc(sizeof(*val));
-        uint64_t res_mem_end;
+    if (pcms->cxl_devices_state.is_enabled) {
+        res_mem_end = cxl_resv_end;
+    } else if (machine->device_memory) {
+        res_mem_end = machine->device_memory->base
+                      + memory_region_size(&machine->device_memory->mr);
+    } else {
+        res_mem_end = 0;
+    }
 
-        if (pcms->cxl_devices_state.is_enabled) {
-            res_mem_end = cxl_resv_end;
-        } else {
-            res_mem_end = machine->device_memory->base
-                          + memory_region_size(&machine->device_memory->mr);
-        }
+    if (res_mem_end) {
+        uint64_t *val = g_malloc(sizeof(*val));
         *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));
         fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*val));
     }
-- 
2.47.3


