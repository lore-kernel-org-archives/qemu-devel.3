Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2014C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uixZ5-0000Nv-9B; Mon, 04 Aug 2025 11:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <engguopeng@buaa.edu.cn>)
 id 1uiw7Q-00071v-09
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:24:53 -0400
Received: from azure-sdnproxy.icoremail.net ([13.76.142.27])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <engguopeng@buaa.edu.cn>) id 1uiw7J-0000b9-K3
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=2dHtnOao28
 utMIUD3/E7Yuhocp6VjBZ5enxgcQtoGf0=; b=n5PwrludH/D5jVUcTstcc/sdz7
 RxRTuBsgmW/cSElfW95e+kLqqhPxLvKmYJAbjESgpBPU9O+IkWMt1Cz4FybQnS8G
 0xHkwVkf7Iwy9/YKjF65Z+FNZ9NQZDtDCUC4IBjSj1Ne0oZA9gCh3qyakNO9BiZM
 RkCj1q5bgm2mfoKrI=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown
 [139.227.252.237])
 by coremail-app2 (Coremail) with SMTP id Nyz+CgCXX2SXwpBogsslAA--.45796S2;
 Mon, 04 Aug 2025 22:24:25 +0800 (CST)
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org
Cc: wyguopeng@163.com, Jonathan.Cameron@huawei.com,
 peng guo <engguopeng@buaa.edu.cn>
Subject: [PATCH v2] hw/i386/pc: Avoid overlap between CXL window and PCI 64bit
 BARs in QEMU
Date: Mon,  4 Aug 2025 22:24:21 +0800
Message-ID: <20250804142421.153126-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Nyz+CgCXX2SXwpBogsslAA--.45796S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1DCF4DGrWktry8ArW7twb_yoW5Kr1UpF
 93JFy5GF4rKF1xGrn7Zayv93W8GF4vk3W7CF92kw1v9FnxGrn8A34vy34Yv348Zrs3XF17
 XF98JF95tw1DuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
 87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
 8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
 Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
 xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
 aVAv8VW7tr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/
Received-SPF: pass client-ip=13.76.142.27; envelope-from=engguopeng@buaa.edu.cn;
 helo=azure-sdnproxy.icoremail.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  peng guo <engguopeng@buaa.edu.cn>
From:  peng guo via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 v1 -> v2: Make the patch clearer and add fixes

 hw/i386/pc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2f58e73d3347..0f10f6edd23e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -975,16 +975,16 @@ void pc_memory_init(PCMachineState *pcms,
 
     rom_set_fw(fw_cfg);
 
-    if (machine->device_memory) {
-        uint64_t *val = g_malloc(sizeof(*val));
-        uint64_t res_mem_end;
+    uint64_t res_mem_end = 0;
+    if (pcms->cxl_devices_state.is_enabled) {
+        res_mem_end = cxl_resv_end;
+    } else if (machine->device_memory) {
+        res_mem_end = machine->device_memory->base
+                        + memory_region_size(&machine->device_memory->mr);
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
2.43.0


