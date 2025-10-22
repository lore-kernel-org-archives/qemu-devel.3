Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983F8CCF9E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXz4-0001HO-Ew; Wed, 22 Oct 2025 08:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXz0-0001G9-If
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXyy-0008OF-5v
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kB28TO+73+LeDdZTZD3TGVweCe+TgzwQ/tG9XCfyIjw=;
 b=dqDPO4ztdMHGHuJzJmNxis8H+dttdUCHrIUgzQh2PHMeD96zxaxXgq6HP9aL+RM7R/gRHN
 yuYnTsD6BZetaxnFEpH935V+brIPI6nTQo4iYb18q6lF3QKA1o9Y+2OI2PjLHAppCe2byp
 vm2x0OCQff9fOJWWBdn2pkfnhs6q9y4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-1neqlS2fOtyROEuuzDVpwQ-1; Wed,
 22 Oct 2025 08:30:19 -0400
X-MC-Unique: 1neqlS2fOtyROEuuzDVpwQ-1
X-Mimecast-MFC-AGG-ID: 1neqlS2fOtyROEuuzDVpwQ_1761136218
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 581191801312; Wed, 22 Oct 2025 12:30:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92315180057E; Wed, 22 Oct 2025 12:30:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/16] hw/arm/aspeed_ast27x0-fc: Map FMC0 flash contents into
 CA35 boot ROM
Date: Wed, 22 Oct 2025 14:29:44 +0200
Message-ID: <20251022122953.877335-8-clg@redhat.com>
In-Reply-To: <20251022122953.877335-1-clg@redhat.com>
References: <20251022122953.877335-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

This patch introduces a dedicated ca35_boot_rom memory region and
copies the FMC0 flash data into it.

The motivation is to support the upcoming vbootrom. The vbootrom
replaces the existing BOOTMCU (RISC-V 32 SPL) flow, which currently reads
the "image-bmc" from FMC_CS0 and loads the following components
into DRAM:

- Trusted Firmware-A
- OP-TEE OS
- u-boot-nodtb.bin
- u-boot.dtb

After loading, BOOTMCU releases the CA35 reset so that CA35 can start
executing Trusted Firmware-A.

The vbootrom follows the same sequence: CA35 fetches "image-bmc" from FMC0
flash at the SPI boot ROM base address (0x100000000), parses the FIT image,
loads each component into its designated DRAM location, and then jumps to
Trusted Firmware-A.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251015062210.3128710-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 99af87dbd7bd..99c0b3415990 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -35,6 +35,7 @@ struct Ast2700FCState {
 
     MemoryRegion ca35_memory;
     MemoryRegion ca35_dram;
+    MemoryRegion ca35_boot_rom;
     MemoryRegion ssp_memory;
     MemoryRegion tsp_memory;
 
@@ -44,8 +45,6 @@ struct Ast2700FCState {
     Aspeed27x0SoCState ca35;
     Aspeed27x0CoprocessorState ssp;
     Aspeed27x0CoprocessorState tsp;
-
-    bool mmio_exec;
 };
 
 #define AST2700FC_BMC_RAM_SIZE (1 * GiB)
@@ -61,6 +60,9 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     Ast2700FCState *s = AST2700A1FC(machine);
     AspeedSoCState *soc;
     AspeedSoCClass *sc;
+    BlockBackend *fmc0 = NULL;
+    DeviceState *dev = NULL;
+    uint64_t rom_size;
 
     object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
     soc = ASPEED_SOC(&s->ca35);
@@ -112,6 +114,14 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     ast2700fc_board_info.ram_size = machine->ram_size;
     ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
 
+    dev = ssi_get_cs(soc->fmc.spi, 0);
+    fmc0 = dev ? m25p80_get_blk(dev) : NULL;
+
+    if (fmc0) {
+        rom_size = memory_region_size(&soc->spi_boot);
+        aspeed_install_boot_rom(soc, fmc0, &s->ca35_boot_rom, rom_size);
+    }
+
     arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
 
     return true;
-- 
2.51.0


