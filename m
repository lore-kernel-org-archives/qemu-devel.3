Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A826DC27C78
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 02:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHDMd-0000R6-Ff; Tue, 11 Jun 2024 22:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sHDMb-0000Qo-Tf
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 22:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sHDMZ-0001Zj-Or
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 22:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718157921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZYGgt1s8oUq2PmxVZcDwlDx7sHCIHmEGyML24WZ8UgA=;
 b=HhXmyEppSg39ikvJJbcgreFk8nP+NfD0loHVxe8oIG4DI6O/PLDG0ANPY733sYSFuqcgU5
 PQuTNb0wZHgeTBG4CGm8DRGdnmTRitRzFIMAlhwwyngDLDXpnzd+HSdGE2VQREFfKlYeuj
 P9nCVtuIjQORkXmJ0V9noFOX1RmcjY4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-MXK2s4LUPqudbRYsBbUPSA-1; Tue,
 11 Jun 2024 22:05:20 -0400
X-MC-Unique: MXK2s4LUPqudbRYsBbUPSA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0675719560AE; Wed, 12 Jun 2024 02:05:17 +0000 (UTC)
Received: from virt-mtsnow-02.lab.eng.rdu2.redhat.com
 (virt-mtsnow-02.lab.eng.rdu2.redhat.com [10.8.1.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6F5C1956053; Wed, 12 Jun 2024 02:05:12 +0000 (UTC)
From: Zhenyu Zhang <zhenyzha@redhat.com>
To: qemu-arm@nongnu.org
Cc: zhenyzha@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 robin.murphy@arm.com, Jonathan.Cameron@huawei.com, gshan@redhat.com,
 eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com,
 ddutile@redhat.com, shahuang@redhat.com
Subject: [PATCH v3] hw/arm/virt: Avoid unexpected warning from Linux guest on
 host with Fujitsu CPUs
Date: Tue, 11 Jun 2024 22:05:06 -0400
Message-ID: <20240612020506.307793-1-zhenyzha@redhat.com>
MIME-Version: 1.0\nContent-Type: text/plain;
 charset=UTF-8\nContent-Transfer-Encoding: 8bit
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=zhenyzha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 46
X-Spam_score: 4.6
X-Spam_bar: ++++
X-Spam_report: (4.6 / 5.0 requ) BAYES_00=-1.9, BOGUS_MIME_VERSION=3.499,
 DKIMWL_WL_HIGH=-0.141, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Multiple warning messages and corresponding backtraces are observed when Linux
guest is booted on the host with Fujitsu CPUs. One of them is shown as below.

[    0.032443] ------------[ cut here ]------------
[    0.032446] uart-pl011 9000000.pl011: ARCH_DMA_MINALIGN smaller than
CTR_EL0.CWG (128 < 256)
[    0.032454] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/dma-mapping.c:54
arch_setup_dma_ops+0xbc/0xcc
[    0.032470] Modules linked in:
[    0.032475] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-452.el9.aarch64
[    0.032481] Hardware name: linux,dummy-virt (DT)
[    0.032484] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.032490] pc : arch_setup_dma_ops+0xbc/0xcc
[    0.032496] lr : arch_setup_dma_ops+0xbc/0xcc
[    0.032501] sp : ffff80008003b860
[    0.032503] x29: ffff80008003b860 x28: 0000000000000000 x27: ffffaae4b949049c
[    0.032510] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[    0.032517] x23: 0000000000000100 x22: 0000000000000000 x21: 0000000000000000
[    0.032523] x20: 0000000100000000 x19: ffff2f06c02ea400 x18: ffffffffffffffff
[    0.032529] x17: 00000000208a5f76 x16: 000000006589dbcb x15: ffffaae4ba071c89
[    0.032535] x14: 0000000000000000 x13: ffffaae4ba071c84 x12: 455f525443206e61
[    0.032541] x11: 68742072656c6c61 x10: 0000000000000029 x9 : ffffaae4b7d21da4
[    0.032547] x8 : 0000000000000029 x7 : 4c414e494d5f414d x6 : 0000000000000029
[    0.032553] x5 : 000000000000000f x4 : ffffaae4b9617a00 x3 : 0000000000000001
[    0.032558] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff2f06c029be40
[    0.032564] Call trace:
[    0.032566]  arch_setup_dma_ops+0xbc/0xcc
[    0.032572]  of_dma_configure_id+0x138/0x300
[    0.032591]  amba_dma_configure+0x34/0xc0
[    0.032600]  really_probe+0x78/0x3dc
[    0.032614]  __driver_probe_device+0x108/0x160
[    0.032619]  driver_probe_device+0x44/0x114
[    0.032624]  __device_attach_driver+0xb8/0x14c
[    0.032629]  bus_for_each_drv+0x88/0xe4
[    0.032634]  __device_attach+0xb0/0x1e0
[    0.032638]  device_initial_probe+0x18/0x20
[    0.032643]  bus_probe_device+0xa8/0xb0
[    0.032648]  device_add+0x4b4/0x6c0
[    0.032652]  amba_device_try_add.part.0+0x48/0x360
[    0.032657]  amba_device_add+0x104/0x144
[    0.032662]  of_amba_device_create.isra.0+0x100/0x1c4
[    0.032666]  of_platform_bus_create+0x294/0x35c
[    0.032669]  of_platform_populate+0x5c/0x150
[    0.032672]  of_platform_default_populate_init+0xd0/0xec
[    0.032697]  do_one_initcall+0x4c/0x2e0
[    0.032701]  do_initcalls+0x100/0x13c
[    0.032707]  kernel_init_freeable+0x1c8/0x21c
[    0.032712]  kernel_init+0x28/0x140
[    0.032731]  ret_from_fork+0x10/0x20
[    0.032735] ---[ end trace 0000000000000000 ]---

In Linux, a check is applied to every device which is exposed through
device-tree node. The warning message is raised when the device isn't
DMA coherent and the cache line size is larger than ARCH_DMA_MINALIGN
(128 bytes). The cache line is sorted from CTR_EL0[CWG], which corresponds
to 256 bytes on the guest CPUs. The DMA coherent capability is claimed
through 'dma-coherent' in their device-tree nodes or parent nodes.

Fix the issue by adding 'dma-coherent' property to the device-tree root
node, meaning all devices are capable of DMA coherent by default.

Signed-off-by: Zhenyu Zhang <zhenyzha@redhat.com>
---
v3: Add comments explaining why we add 'dma-coherent' property (Peter)
---
 hw/arm/virt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a6..3cefac6d43 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -271,6 +271,17 @@ static void create_fdt(VirtMachineState *vms)
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_string(fdt, "/", "model", "linux,dummy-virt");
 
+    /*
+     * For QEMU, all DMA is coherent. Advertising this in the root node
+     * has two benefits:
+     *
+     * - It avoids potential bugs where we forget to mark a DMA
+     *   capable device as being dma-coherent
+     * - It avoids spurious warnings from the Linux kernel about
+     *   devices which can't do DMA at all
+     */
+    qemu_fdt_setprop(fdt, "/", "dma-coherent", NULL, 0);
+
     /* /chosen must exist for load_dtb to fill in necessary properties later */
     qemu_fdt_add_subnode(fdt, "/chosen");
     if (vms->dtb_randomness) {
-- 
2.43.0


