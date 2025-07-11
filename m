Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29C4C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua97j-0006DJ-Pt; Fri, 11 Jul 2025 04:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8z1-0007Ny-66; Fri, 11 Jul 2025 04:19:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8yz-0004JB-BL; Fri, 11 Jul 2025 04:19:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A52D11356E1;
 Fri, 11 Jul 2025 11:17:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9C9CA23FA56;
 Fri, 11 Jul 2025 11:17:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 22/39] hw/loongarch/virt: Fix big endian support with
 MCFG table
Date: Fri, 11 Jul 2025 11:16:18 +0300
Message-ID: <20250711081745.1785806-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

With API build_mcfg(), it is not necessary with parameter structure
AcpiMcfgInfo to convert to little endian since it is directly used
with host native endian.

Here remove endian conversion before calling function build_mcfg().
With this patch, bios-tables-test passes to run on big endian host
machine S390.

Fixes: 735143f10d3e ("hw/loongarch: Add acpi ged support")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250604065502.1114098-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit 9c55c03c05c1899521ff0c991b9296633d759890)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index fced6c445a..24ccb580bd 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -575,8 +575,8 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
-           .base = cpu_to_le64(VIRT_PCI_CFG_BASE),
-           .size = cpu_to_le64(VIRT_PCI_CFG_SIZE),
+           .base = VIRT_PCI_CFG_BASE,
+           .size = VIRT_PCI_CFG_SIZE,
         };
         build_mcfg(tables_blob, tables->linker, &mcfg, lvms->oem_id,
                    lvms->oem_table_id);
-- 
2.47.2


