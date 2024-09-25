Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32682CF9C71
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 04:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stJHN-0006pF-RK; Wed, 25 Sep 2024 00:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJGo-0005bp-M9; Wed, 25 Sep 2024 00:04:55 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJGl-0001xF-CE; Wed, 25 Sep 2024 00:04:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5148EA43B0E;
 Wed, 25 Sep 2024 04:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F3FC4CECD;
 Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727237088;
 bh=nBKJN8HnPZNNP4hYZrf3OFUxClvSEboHXAz3CwHADyk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WEsdXcydUg8hMicE2Jskh4hIbo0vjmGEWzyDKWEvYLZXkJoxJh5XRKZ81icvEoToM
 FgRMGwh6affiTmZ46KTBhmNe+bYuB0X/Rv2TQRWIkj4rH08e5GqqFetFfBfCL84Mdu
 LSVLAGMmmjTLmd+qdmOgyCIuUjmzCA9UQhNGCt4fjol8+dT2R/oihjRfQiKW9UcwJl
 AGCosDjve+pnfeUWpwZPx0DEGKAMSDpJeHLLVYCPRMX6Zpat4roxw+DPvjg7EWLSrH
 QNIB6eRmCWkebo2+TrU+y/gznJsdWNO5valjr6gR6+EFb2Jm0WjhPTueP8OHhME1fL
 BzbwjYwW4RQHQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJGg-0000000827k-0RNk; Wed, 25 Sep 2024 06:04:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 02/15] acpi/ghes: simplify acpi_ghes_record_errors() code
Date: Wed, 25 Sep 2024 06:04:07 +0200
Message-ID: <45dcc7644e2b2a04645a37e561ed7294482b0744.1727236561.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reduce the ident of the function and prepares it for
the next changes.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c | 56 ++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index dc217694deb9..dacbd4d0c093 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -402,40 +402,42 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 
     start_addr = le64_to_cpu(ags->ghes_addr_le);
 
-    if (physical_address) {
+    if (!physical_address) {
+        return -1;
+    }
 
-        if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
-            start_addr += source_id * sizeof(uint64_t);
-        }
+    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
+        start_addr += source_id * sizeof(uint64_t);
+    }
 
-        cpu_physical_memory_read(start_addr, &error_block_addr,
-                                 sizeof(error_block_addr));
+    cpu_physical_memory_read(start_addr, &error_block_addr,
+                                sizeof(error_block_addr));
 
-        error_block_addr = le64_to_cpu(error_block_addr);
+    error_block_addr = le64_to_cpu(error_block_addr);
 
-        read_ack_register_addr = start_addr +
-            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
+    read_ack_register_addr = start_addr +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
 
-        cpu_physical_memory_read(read_ack_register_addr,
-                                 &read_ack_register, sizeof(read_ack_register));
+    cpu_physical_memory_read(read_ack_register_addr,
+                                &read_ack_register, sizeof(read_ack_register));
 
-        /* zero means OSPM does not acknowledge the error */
-        if (!read_ack_register) {
-            error_report("OSPM does not acknowledge previous error,"
-                " so can not record CPER for current error anymore");
-        } else if (error_block_addr) {
-            read_ack_register = cpu_to_le64(0);
-            /*
-             * Clear the Read Ack Register, OSPM will write it to 1 when
-             * it acknowledges this error.
-             */
-            cpu_physical_memory_write(read_ack_register_addr,
-                &read_ack_register, sizeof(uint64_t));
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack_register) {
+        error_report("OSPM does not acknowledge previous error,"
+            " so can not record CPER for current error anymore");
+    } else if (error_block_addr) {
+        read_ack_register = cpu_to_le64(0);
+        /*
+         * Clear the Read Ack Register, OSPM will write it to 1 when
+         * it acknowledges this error.
+         */
+        cpu_physical_memory_write(read_ack_register_addr,
+            &read_ack_register, sizeof(uint64_t));
 
-            ret = acpi_ghes_record_mem_error(error_block_addr,
-                                             physical_address);
-        } else
-            error_report("can not find Generic Error Status Block");
+        ret = acpi_ghes_record_mem_error(error_block_addr,
+                                            physical_address);
+    } else {
+        error_report("can not find Generic Error Status Block");
     }
 
     return ret;
-- 
2.46.1


