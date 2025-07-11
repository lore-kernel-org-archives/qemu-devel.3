Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA98C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua95B-0000KE-5C; Fri, 11 Jul 2025 04:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xM-0004EU-Mo; Fri, 11 Jul 2025 04:18:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xJ-0003y8-Lw; Fri, 11 Jul 2025 04:18:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3AD161356CD;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3286F23FA42;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 02/39] hw/arm/aspeed_ast27x0: Fix RAM size detection
 failure on BE hosts
Date: Fri, 11 Jul 2025 11:15:58 +0300
Message-ID: <20250711081745.1785806-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

On big-endian hosts, the aspeed_ram_capacity_write() function previously passed
the address of a 64-bit "data" variable directly to address_space_write(),
assuming host and guest endianness matched.

However, the data is expected to be written in little-endian format to DRAM.
On big-endian hosts, this led to incorrect data being written into DRAM,
which caused the guest firmware to misdetect the DRAM size.

As a result, U-Boot fails to boot and hangs.

- Replaces the "address_space_write()" call with "address_space_stl_le()",
  which performs an explicit 32-bit little-endian write.
- Updating the MemoryRegionOps to restrict access to exactly 4 bytes
  using .valid.{min,max}_access_size = 4 and .impl.min_access_size = 4.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Fixes: 7436db1 ("aspeed/soc: fix incorrect dram size for AST2700")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250522023305.2486536-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit e6941ac106190490d8b455eedc5b368e6d94d4cc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index dce7255a2c..b810891b16 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -325,8 +325,9 @@ static void aspeed_ram_capacity_write(void *opaque, hwaddr addr, uint64_t data,
      * If writes the data to the address which is beyond the ram size,
      * it would write the data to the "address % ram_size".
      */
-    result = address_space_write(&s->dram_as, addr % ram_size,
-                                 MEMTXATTRS_UNSPECIFIED, &data, 4);
+    address_space_stl_le(&s->dram_as, addr % ram_size, data,
+                         MEMTXATTRS_UNSPECIFIED, &result);
+
     if (result != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: DRAM write failed, addr:0x%" HWADDR_PRIx
@@ -339,9 +340,10 @@ static const MemoryRegionOps aspeed_ram_capacity_ops = {
     .read = aspeed_ram_capacity_read,
     .write = aspeed_ram_capacity_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
     .valid = {
-        .min_access_size = 1,
-        .max_access_size = 8,
+        .min_access_size = 4,
+        .max_access_size = 4,
     },
 };
 
-- 
2.47.2


