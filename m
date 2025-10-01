Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AF5CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zZL-0006KE-Jk; Wed, 01 Oct 2025 12:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v3zZI-0006IY-Ax
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:20:40 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v3zZ6-0005O1-2F
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1759335628; x=1790871628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QLjSIk06yAGxSvmxLmvAi4FQqrO5012aXven58zdKQw=;
 b=PSKG5EC3y/I7ORKq8PbcXkE6+3QkoWYTgz3Eue9uBAhCKN/clzVORscm
 TvryYx8GYu9Acqr4wH4hwNfXsCGwppMYAFHE32lzMmthwU0xF8w8u8USZ
 cRSIK51tcxbCxQRjlcJPg80GDALPMUdSs/lFrZhOdWATZmMNDFvq88n6i s=;
X-CSE-ConnectionGUID: EzRP6tvSQB6a7Mm8K60amg==
X-CSE-MsgGUID: uambPVkjSp6ILRhiOOU7Tw==
X-IronPort-AV: E=Sophos;i="6.18,307,1751234400"; 
   d="scan'208";a="3123364"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
 by drago1i.eurecom.fr with ESMTP; 01 Oct 2025 18:20:21 +0200
Received: from marco-eurecom-desktop.s3.eurecom.fr (unknown [193.55.114.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtps.eurecom.fr (Postfix) with ESMTPSA id 546552ED7;
 Wed,  1 Oct 2025 18:20:21 +0200 (CEST)
From: Marco Cavenati <Marco.Cavenati@eurecom.fr>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, ppandit@redhat.com,
 berrange@redhat.com, Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH 3/3] migration: mapped-ram: handle zero pages
Date: Wed,  1 Oct 2025 18:18:23 +0200
Message-ID: <20251001161823.2032399-4-Marco.Cavenati@eurecom.fr>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
References: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Make mapped-ram compatible with loadvm snapshot restoring by explicitly
zeroing memory pages in this case.
Skip zeroing for -incoming and -loadvm migrations to preserve performance.

Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
---
 migration/ram.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index e238c9233f..597d5ffe9e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3958,12 +3958,55 @@ static size_t ram_load_multifd_pages(void *host_addr, size_t size,
     return size;
 }
 
+/**
+ * handle_zero_mapped_ram: Zero out a range of RAM pages if required during
+ * mapped-ram load
+ *
+ * Zeroing is only performed when restoring from a snapshot (HMP loadvm).
+ * During incoming migration or -loadvm cli snapshot load, the function is a
+ * no-op and returns true as in those cases the pages are already guaranteed to
+ * be zeroed.
+ *
+ * Returns: true on success, false on error (with @errp set).
+ * @from_bit_idx: Starting index relative to the map of the page (inclusive)
+ * @to_bit_idx:   Ending index relative to the map of the page (exclusive)
+ */
+static bool handle_zero_mapped_ram(RAMBlock *block, unsigned long from_bit_idx,
+                                   unsigned long to_bit_idx, Error **errp)
+{
+    ERRP_GUARD();
+    ram_addr_t offset;
+    size_t size;
+    void *host;
+
+    if (runstate_check(RUN_STATE_INMIGRATE) ||
+        runstate_check(RUN_STATE_PRELAUNCH)) {
+        return true;
+    }
+
+    if (from_bit_idx == to_bit_idx) {
+        return true;
+    }
+
+    size = TARGET_PAGE_SIZE * (to_bit_idx - from_bit_idx);
+    offset = from_bit_idx << TARGET_PAGE_BITS;
+    host = host_from_ram_block_offset(block, offset);
+    if (!host) {
+        error_setg(errp, "zero page outside of ramblock %s range",
+                   block->idstr);
+        return false;
+    }
+    ram_handle_zero(host, size);
+
+    return true;
+}
+
 static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
                                      long num_pages, unsigned long *bitmap,
                                      Error **errp)
 {
     ERRP_GUARD();
-    unsigned long set_bit_idx, clear_bit_idx;
+    unsigned long set_bit_idx, clear_bit_idx = 0;
     ram_addr_t offset;
     void *host;
     size_t read, unread, size;
@@ -3972,6 +4015,12 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
          set_bit_idx < num_pages;
          set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
 
+        /* Zero pages */
+        if (!handle_zero_mapped_ram(block, set_bit_idx, clear_bit_idx, errp)) {
+            return false;
+        }
+
+        /* Non-zero pages */
         clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
 
         unread = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
@@ -4003,6 +4052,11 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
         }
     }
 
+    /* Handle trailing 0 pages */
+    if (!handle_zero_mapped_ram(block, num_pages, clear_bit_idx, errp)) {
+        return false;
+    }
+
     return true;
 
 err:
-- 
2.48.1


