Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A0606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=g7a3/shr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCmT-0007ZW-R6; Wed, 25 Nov 2026 08:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xWCmR-0007YZ-1j
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:11:23 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xWCmP-0003Qv-Es
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:11:22 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.58])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6B97E20B7170;
 Wed, 25 Nov 2026 05:11:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B97E20B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795612274;
 bh=/2KyBNkOKpYmWv8FYPnjkGrI7+mTBRq/JBjacH6VcbA=;
 h=From:To:Cc:Subject:Date:From;
 b=g7a3/shrzLtYi64IWZK+r8tkD1W1v5VWfrA9KOWRQhyGlZ3lxNvrYbC9TIRiHQOf/
 A+N5w9wdnfhE6wqy3BLNUu8taO7pwWvsb8caoWfKf8VFvvlRY3Fi1JKM90bzdhcs5/
 bwwP3WTOCvQ3S4oCtvM3SNDF+r2k1gt72d22j1dI=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Wei Liu <liuwe@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH] accel/mshv: mark VGA mem as dirty in mshv_log_sync
Date: Wed, 25 Nov 2026 14:11:14 +0100
Message-Id: <20261125131114.49490-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The accelerator needs to report changed video memory for the VGA display
update (e.g. for a VNC backend). We currently report the full section as
dirty. MSHV enables hypervisor dirty tracking only during migration, so
a VGA-only refresh is not able to query that bitmap.

During migrations we will use the migration dirty-log.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mem.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index 00d69fca8d..98db7bf117 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -428,11 +428,24 @@ void mshv_log_sync(MemoryListener *listener, MemoryRegionSection *section)
     ram_addr_t ram_addr;
     int ret;
     MemoryRegion *mr = section->mr;
+    bool vga_logging, migration_logging;
 
     if (!memory_region_is_ram(mr) || memory_region_is_rom(mr)) {
         return;
     }
 
+    /* mark VGA always dirty, but keep bitmap tracking during migration */
+    vga_logging = memory_region_get_dirty_log_mask(mr) & BIT(DIRTY_MEMORY_VGA);
+    migration_logging = memory_region_get_dirty_log_mask(mr) &
+                        BIT(DIRTY_MEMORY_MIGRATION);
+    if (vga_logging && !migration_logging) {
+        mr_offset = section->offset_within_region;
+        size = int128_get64(section->size);
+
+        memory_region_set_dirty(mr, mr_offset, size);
+        return;
+    }
+
     size = align_section(section, &start_addr);
     if (!size) {
         return;
-- 
2.34.1


