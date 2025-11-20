Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B387CF649C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 01:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLt4y-0000Eu-RG; Wed, 19 Nov 2025 20:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vLskk-0004HI-58; Wed, 19 Nov 2025 19:42:26 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vLskg-0002SV-Ss; Wed, 19 Nov 2025 19:42:25 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 458376019D;
 Thu, 20 Nov 2025 00:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD191C116B1;
 Thu, 20 Nov 2025 00:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763599341;
 bh=OZkhn5pjjQ2Q3QlWagDHaKGU9UJL0kw5S10Ux3BRkZE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QHmYXdnWaoJpXVy/6uq27xxsF+ia6BoEd9aaLaQS1/ooDOMBhmoPSeYaSZ2RUTXh1
 b8UB74ZR3WWq/Qq6S/YVVBhOCJ0rePOdLUNLS667BbOtID72jCjTqzC88sA77K5FJD
 XmaJzJrrMTqmDj2ZCkAB0mQYiBfxQBtU2/UFu694jajxGsMZF5Z6LUw8BLrGU8W7YP
 ec0wu+2R0lYLuhbZLhnJKRb480dA1GqWAFH26Zkv2oyq+Fuki5xQJML3X+f3frmzHs
 AIyvMOf0+UIedl27Hoq9t6qCA7WSmzpgma0uJnJ2LS1gev8YYD4Biybx5/qqmJbi0B
 wPlDaG00m1SSw==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 19 Nov 2025 16:42:23 -0800
Subject: [PATCH 7/7] hw/riscv: add CBQRI controllers to virt machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-riscv-ssqosid-cbqri-v1-7-3392fc760e48@kernel.org>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Nov 2025 20:03:18 -0500
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

From: Nicolas Pitre <npitre@baylibre.com>

Add CBQRI controllers to the RISC-V virt machine. The device properties
can be fully configured from the command line:

  $ qemu-system-riscv64 -M virt ... \
      -device riscv.cbqri.capacity,mmio_base=0x04828000[,...]
      -device riscv.cbqri.bandwidth,mmio_base=0x04829000[,...]

The mmio_base option is mandatory, the others are optional.

Many -device arguments as wanted can be provided as long as their
mmio regions don't conflict.

To see all possible options:

  $ qemu-system-riscv64 -device riscv.cbqri.capacity,help
  riscv.cbqri.capacity options:
    alloc_op_config_limit=<bool> -  (default: true)
    alloc_op_flush_rcid=<bool> -  (default: true)
    alloc_op_read_limit=<bool> -  (default: true)
    at_code=<bool>         -  (default: true)
    at_data=<bool>         -  (default: true)
    max_mcids=<uint16>     -  (default: 256)
    max_rcids=<uint16>     -  (default: 64)
    mmio_base=<uint64>     -  (default: 0)
    mon_evt_id_none=<bool> -  (default: true)
    mon_evt_id_occupancy=<bool> -  (default: true)
    mon_op_config_event=<bool> -  (default: true)
    mon_op_read_counter=<bool> -  (default: true)
    ncblks=<uint16>        -  (default: 16)
    target=<str>

  $ qemu-system-riscv64 -device riscv.cbqri.bandwidth,help
  riscv.cbqri.bandwidth options:
    alloc_op_config_limit=<bool> -  (default: true)
    alloc_op_read_limit=<bool> -  (default: true)
    at_code=<bool>         -  (default: true)
    at_data=<bool>         -  (default: true)
    max_mcids=<uint16>     -  (default: 256)
    max_rcids=<uint16>     -  (default: 64)
    mmio_base=<uint64>     -  (default: 0)
    mon_evt_id_none=<bool> -  (default: true)
    mon_evt_id_rdonly_count=<bool> -  (default: true)
    mon_evt_id_rdwr_count=<bool> -  (default: true)
    mon_evt_id_wronly_count=<bool> -  (default: true)
    mon_op_config_event=<bool> -  (default: true)
    mon_op_read_counter=<bool> -  (default: true)
    nbwblks=<uint16>       -  (default: 1024)
    target=<str>

Boolean options correspond to hardware capabilities that can be disabled

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/riscv/virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 17909206c7ef..498f606d33b1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -55,6 +55,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/riscv/cbqri.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
@@ -1941,6 +1942,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RISCV_CBQRI_BC);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RISCV_CBQRI_CC);
 
     object_class_property_add_bool(oc, "aclint", virt_get_aclint,
                                    virt_set_aclint);

-- 
2.43.0


