Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082FBC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 13:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uclGs-0004xu-TY; Fri, 18 Jul 2025 09:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <engguopeng@buaa.edu.cn>)
 id 1uclGp-0004u9-NA
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:37:03 -0400
Received: from l-sdnproxy.icoremail.net ([20.188.111.126]
 helo=azure-sdnproxy.icoremail.net)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <engguopeng@buaa.edu.cn>) id 1uclGl-0004wQ-CU
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=XPkEBDNisX
 Q0AjoTAXlD7TIcavVVweP0kvy5/P95cf4=; b=bL8pMsgQ59jFJCYrtuGBG90ChC
 z68SS5YDe8So53tW/tym8iQpexsao4GDbjghqk5XoVkMO/2biOWppbf6GIxbKjtS
 MIAjXJjOB+aojGnelYpoDh83JHF0Ddfo4zoBKk5rkZgJ6sd/5iQkSFoR5B7g6zl/
 OssH8VH6KvHvxiqjk=
Received: from gp-VMware-Virtual-Platform.com (unknown [139.227.252.237])
 by coremail-app2 (Coremail) with SMTP id Nyz+CgAXM5mzTXpoDL2qBQ--.55176S2;
 Fri, 18 Jul 2025 21:35:47 +0800 (CST)
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: wyguopeng@163.com,
	peng guo <engguopeng@buaa.edu.cn>
Subject: [PATCH] hw/i386/pc: Avoid overlap between CXL window and PCI 64bit
 BARs in QEMU
Date: Fri, 18 Jul 2025 21:35:45 +0800
Message-ID: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Nyz+CgAXM5mzTXpoDL2qBQ--.55176S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4xKFW8AF1UXrWrCr1xXwb_yoW5XFW5p3
 sxtay5GFWFgr13GFZ7Xas5Ca18uFs5u3W7CFs2gwn29rnxKr15ZasFy3yYv340qrn3Jry7
 XF98JrySqw4DuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
 z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
 Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
 6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
 vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxG
 rwCF04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
 02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
 GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
 CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
 6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
 UkHUDUUUUU=
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/
Received-SPF: pass client-ip=20.188.111.126;
 envelope-from=engguopeng@buaa.edu.cn; helo=azure-sdnproxy.icoremail.net
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

When using a CXL Type 3 device together with a virtio 9p device in QEMU, the
9p device fails to initialize properly. The kernel reports the following:

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

To address this issue, this patch uses the value of `cxl_resv_end` to reserve
sufficient address space and ensure that CXL memory windows are allocated
beyond all PCI 64-bit BARs. This prevents overlap with 64-bit BARs regions such 
as those used by virtio or other pcie devices, resolving the conflict.

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

Tested in a QEMU setup with a CXL Type 3 device and a 9pnet virtio device.

Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2f58e73d3347..180bc615f3f0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -975,7 +975,7 @@ void pc_memory_init(PCMachineState *pcms,
 
     rom_set_fw(fw_cfg);
 
-    if (machine->device_memory) {
+    if (machine->device_memory || cxl_resv_end) {
         uint64_t *val = g_malloc(sizeof(*val));
         uint64_t res_mem_end;
 
-- 
2.43.0


