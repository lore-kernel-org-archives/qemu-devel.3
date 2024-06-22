Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F13C2BD05
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWJ-0007yW-Al; Sat, 22 Jun 2024 08:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzWC-0007pj-DY
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW9-0000L6-Kj
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:56 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3621ac606e1so2295435f8f.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058012; x=1719662812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TDROnXRZm4HJC9JeBRZrJ0oXuZuLpT1NFzYgwIqZIyc=;
 b=qsywLHptiZPIMrx5aOcuE5zEyAXkOqCmZyplmINlHRXnl5IhI5w5AtpmtgtpkmbptH
 DtsisbWHAXIwq8sx3kXVRruj/jwvZN0GotJ1gclxsB769OMaJx7mJAOBgoYjLR40aD6X
 9lT8WPf0GFNr8V9pswma8wSX6UCKFj4IRiqPv+GgBGlpGUGte/xhIAz3yqsXSI2bEdAe
 PuKfK3fMQqrIMQGL1Igdq/dVlDNBus5fjw7Wx6WozkA5GDscreeSpAbTLd0luhgWPHFn
 51q1BvLrzeMdHauv2dpSZUFYP3tUElJK3u/Q9PAeBfR1evbRxeg3sN+kYnyez9ofTF/n
 gQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058012; x=1719662812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDROnXRZm4HJC9JeBRZrJ0oXuZuLpT1NFzYgwIqZIyc=;
 b=cyzLSXtT7rqx6TzeQ5Rqw7AvMsydrRd9nSrHxStJ+yvr96UW47PZgxt22dji5hW8NH
 IWnL+vFIjyvu+UaPJQ2oj7w+cMUxFtcY2KDjiFUOilF2Af/poG+qe7PYSBcUruEeqK8Q
 7ctR9dPBfVRIj8ZEFTlqA/Z+htO277OmwsQS+hxpxu8DbtVy1KVA4btnucHTFqnRQW0F
 YtyBZ8ef7IbbMENUMDbHrCIJUi5usgufmxkHidWwywDHvZPuo3AEySJcJrxKBEU8+3i8
 udWmrVFBCvpUAJ8p+NcB9F9KTTd3q2HH62oE76cWD4PV3zDT1i3eqB2Kd9GLmfqB82Nu
 IJUQ==
X-Gm-Message-State: AOJu0YzwO8z7P/cpEgVfcXSq8LCfhOBWPGKotasoJeo9vtbd+Y3rnyry
 Mm3Vz/Y7A/BvINS+xzR1GXVUekuUx6rIb4nD1hKQbiLIE4Pjp+hTq/k0wISXlxYWfhIpIyPyEfO
 tm3g=
X-Google-Smtp-Source: AGHT+IEPV/FMnvpm2m3zzc5vvt71nl6AtSxR9OHd+4dcFQeGJvVX6/kCqiFPFnFH/ubOclAuBWr7Dw==
X-Received: by 2002:adf:e789:0:b0:360:8281:71ef with SMTP id
 ffacd0b85a97d-366e3649591mr1037910f8f.4.1719058012270; 
 Sat, 22 Jun 2024 05:06:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] hw/arm/virt: Avoid unexpected warning from Linux guest
 on host with Fujitsu CPUs
Date: Sat, 22 Jun 2024 13:06:40 +0100
Message-Id: <20240622120643.3797539-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenyu Zhang <zhenyzha@redhat.com>

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
This happens even when the device doesn't implement or use DMA at all,
for legacy reasons.

Fix the issue by adding 'dma-coherent' property to the device-tree root
node, meaning all devices are capable of DMA coherent by default.
This both suppresses the spurious kernel warnings and also guards
against possible future QEMU bugs where we add a DMA-capable device
and forget to mark it as dma-coherent.

Signed-off-by: Zhenyu Zhang <zhenyzha@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-id: 20240612020506.307793-1-zhenyzha@redhat.com
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 85556152563..0784ee7f466 100644
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
2.34.1


