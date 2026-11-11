Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515D606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTC7dk5v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRHuf-0006rM-B8; Wed, 11 Nov 2026 18:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xRHuP-0006g9-P3; Wed, 11 Nov 2026 18:39:18 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xRHuM-0004ae-FU; Wed, 11 Nov 2026 18:39:17 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 27D504237C;
 Wed, 11 Nov 2026 23:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA57E1F00A07;
 Wed, 11 Nov 2026 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794440353;
 bh=PcBBdGrhQ5R3k7uxP1aJX5g9JkIhQhZcRu0rYeN8t5Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mTC7dk5vDNuAopwcIfjfBf/tlqgzhdyOGZhssdBUION/ggjQ7bnk3Q7E6iVNQT1BC
 vsNKDCShfwbnn5waxKPVWz6lFOaSaV3c4CKm+xUBNuvUoPnDD7ABn6Pq0LZ7JxcSYZ
 6LCCmZbcSA/LGPRZb/RRBDQj7NykAsmpNytpSHFtiLC6SwiHWwEyEWNZtepYL5XHFs
 X+nk0nqanHO0lHfNokXC98dAeozn9OK3KIqwkaMPTzMY1sC42iQATmbo4n/1ntQvfI
 ii22cs8y5MSD/Y+IYt36UaS/VHg4gBUtpWCNKlQdgqg2EXM1Ks7+3J7SB4I4cOXHmU
 3WtOTTudZIOxA==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 11 Nov 2026 15:38:47 -0800
Subject: [PATCH v8 6/6] hw/riscv: add CBQRI controllers to virt machine
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-riscv-ssqosid-cbqri-v8-6-121f6dcfb573@kernel.org>
References: <20261111-riscv-ssqosid-cbqri-v8-0-121f6dcfb573@kernel.org>
In-Reply-To: <20261111-riscv-ssqosid-cbqri-v8-0-121f6dcfb573@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4125; i=fustini@kernel.org;
 h=from:subject:message-id; bh=l/yh8VexZmgfq4b3fIdOgYS3aF0Cz7D26icjss1lUH0=;
 b=kA0DAAoW2+wsw9kosQwByyZiAGr0/J6gKTmFfiR9Qn8jsRkHQPL18EQYPev69s6kXWUrJIuYK
 oh1BAAWCgAdFiEEsvBu0KRKVfWgn+i22+wsw9kosQwFAmr0/J4ACgkQ2+wsw9kosQw3FwEA8lbA
 6/AKqD4SQjy+nKpjqvGHik6ctbgx1sL0kUkVexcA/Ra5sngwRVA6mr3/Gsph60A46mPFf0lg/Pg
 SAv7k8d0B
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nicolas Pitre <npitre@baylibre.com>

Add CBQRI controllers to the RISC-V virt machine. The device properties
can be fully configured from the command line:

  $ qemu-system-riscv64 -M virt ... \
      -device riscv.cbqri.capacity,mmio_base=0x04820000[,...] \
      -device riscv.cbqri.bandwidth,mmio_base=0x04829000[,...]

The mmio_base option is mandatory. The others are optional.

As many -device arguments as wanted can be provided as long as their
mmio regions don't conflict.

To see all possible options:

  $ qemu-system-riscv64 -device riscv.cbqri.capacity,help
  riscv.cbqri.capacity options:
    alloc_op_config_limit=<bool> - on/off (default: on)
    alloc_op_flush_rcid=<bool> - on/off (default: on)
    alloc_op_read_limit=<bool> - on/off (default: on)
    at_code=<bool>         - on/off (default: on)
    max_mcids=<uint16>     -  (default: 256)
    max_rcids=<uint16>     -  (default: 64)
    mmio_base=<uint64>     -  (default: 0)
    mon_evt_id_none=<bool> - on/off (default: on)
    mon_evt_id_occupancy=<bool> - on/off (default: on)
    mon_op_config_event=<bool> - on/off (default: on)
    mon_op_read_counter=<bool> - on/off (default: on)
    ncblks=<uint16>        -  (default: 16)

  $ qemu-system-riscv64 -device riscv.cbqri.bandwidth,help
  riscv.cbqri.bandwidth options:
    alloc_op_config_limit=<bool> - on/off (default: on)
    alloc_op_read_limit=<bool> - on/off (default: on)
    at_code=<bool>         - on/off (default: on)
    max_mcids=<uint16>     -  (default: 256)
    max_rcids=<uint16>     -  (default: 64)
    mmio_base=<uint64>     -  (default: 0)
    mon_evt_id_none=<bool> - on/off (default: on)
    mon_evt_id_rdonly_count=<bool> - on/off (default: on)
    mon_evt_id_rdwr_count=<bool> - on/off (default: on)
    mon_evt_id_wronly_count=<bool> - on/off (default: on)
    mon_op_config_event=<bool> - on/off (default: on)
    mon_op_read_counter=<bool> - on/off (default: on)
    mrbwb=<uint16>         -  (default: 819)
    nbwblks=<uint16>       -  (default: 1024)

Boolean options correspond to hardware capabilities that can be
disabled.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
[fustini: rebase on riscv-to-apply.next]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/core/sysbus-fdt.c | 4 ++++
 hw/riscv/virt.c      | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index 12238570b5e1..265917ef573e 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -35,6 +35,7 @@
 #include "hw/core/platform-bus.h"
 #include "hw/display/ramfb.h"
 #include "hw/uefi/var-service-api.h"
+#include "hw/riscv/cbqri.h"
 #include "hw/arm/fdt.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 
@@ -142,6 +143,9 @@ static const BindingEntry bindings[] = {
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
     TYPE_BINDING(TYPE_WDT_SBSA, no_fdt_node),
+    /* RISC-V CBQRI controllers have no generic device tree node */
+    TYPE_BINDING(TYPE_RISCV_CBQRI_BC, no_fdt_node),
+    TYPE_BINDING(TYPE_RISCV_CBQRI_CC, no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
 };
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f60..dbc0f8cfc8d7 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -57,6 +57,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/riscv/cbqri.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
@@ -1157,6 +1158,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RISCV_CBQRI_BC);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RISCV_CBQRI_CC);
 
     object_class_property_add_bool(oc, "aclint", virt_get_aclint,
                                    virt_set_aclint);

-- 
2.43.0


