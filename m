Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B3D1061B1B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7HwW-0004cC-Dl; Mon, 30 Mar 2026 15:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7HvY-0003pM-EN
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7HvW-0005Dy-1w
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:32 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82bae83318bso2229487b3a.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774897528; x=1775502328; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2mYxx14F73G5Col0sHTzc8b/F7FosUZb5oC/eLDVHtM=;
 b=kTI0YU1sCj2nTAJ2BINKBVXbIEZa3iw2TnFDRz70pdvdUrz0LWMfAHGdvmQTkdKSaO
 GtDi6SzfWN3+BMpkqMRbiAvcCdhkkkntq2J0uRyUiL5BIPLXWTsD/pGAy3gsz+NUk0n7
 Aa2vdSledGihXrHFsW/j4XtLJ/SfVpYVXzKG0SmQsJnhiQW9TnwRTvXAVH7YKV+JXBbM
 aa+j4G80EFgnjJXs8IwIpPis+7FtULRefQ7bpfMdfKMuxpu9ya2Un3WW0XOVCv5+ZagP
 w7zzVpmlAbtUBRLVwQEfh5LvwXmFL3sLAL6yEFHiUfC7TrP+GeQHn1VvdVjQIzTB3lkn
 Pxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774897528; x=1775502328;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2mYxx14F73G5Col0sHTzc8b/F7FosUZb5oC/eLDVHtM=;
 b=AGson6+7q8oot0rnsh3egaHTVr22/uyk4To7i5efDIy8WD6mA2H/ZrHGokMdJviF62
 vn8cdcFjDND81Bu3WGFkoxw4TmSyKfKz4PbzKolwF8IjpU428ao2ych50eRS8bHSAMpU
 ITY/AVXaNta7M+r+DTbdJKQ+1Q9zj0gr6taYwIIkhUSqDmi51UKFz9H57WCee6bOV7mT
 BNmf0hVVTiCN9ZtIGEHPZioR31TsGijUcs5fcHR8yWg2fFydSZw7B6Hf4OizBQmMsbAg
 j49E6zTjQKZbxTStX/kbuAUEwzRE+hBj88uDGnLPb0j4v+29JGX4wwRLdlqmntyuT7/k
 Ek9w==
X-Gm-Message-State: AOJu0YxcUGTXIy4Tw0h3M2E/zC8h7FI6e8B4Kq8OAEIKx8HP/Y/xUlrU
 AZgjItN0fqco31WAu5ZtWajbD6W1+lwljIV8zG0beVmVe9ChgaQIhxfqI1i9Dw==
X-Gm-Gg: ATEYQzwDaKTUPM4+eGQOHpfMjF0UKbKI78G//ZParSoSQ3FvaG6K3pk+rVbqwYaStYj
 pHu60AyQbVEFVoAI6f6NaSCp0Wmui8bBe/qoYJSQno0Mqly9Mj68x82Emb+GwGZuTi7QVESkKm1
 fPUPLcRTQLIB+xNhC+8qyyrOz2QwcWUfgU3S2U7/mcPqARqEleNMkAH6geE897tGmnV2NhjwOCO
 Yc3r3vx+Pip5S9cfrZ06qNSqdWMjyLT3ic9uH4Mq+kFUBEHUt1NoRSU4EllKvcjnwbcNIdHsFp8
 3fLEmNi+tCg+JySC80mScoictXnZuMPYBwp06wplO+63JE3JDjThchp/1OopDQdceEhI3H+U4W/
 n3DF8SUmMSxT0tcnGeJtK3ME/njP1QJzBKXIP/GPZGfbPcq56qV53a8PfKw4GzSHJdCpFSNX8p7
 EUdEGcBN/iTluvcgMYecA193PX+hOHvQQn17G/iPkDp9mkswiTP7X/OaCiowrrhOcpV9D6bS698
 ttTGM/Mch1+9F/kbLvJht5mCmi8
X-Received: by 2002:a05:6a00:8d3:b0:7aa:a2a8:9808 with SMTP id
 d2e1a72fcca58-82c95e650a6mr13547225b3a.20.1774897528018; 
 Mon, 30 Mar 2026 12:05:28 -0700 (PDT)
Received: from [127.0.1.1] (191.68.231.218.rev.ocx2915.net. [218.231.68.191])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca84644d9sm8496989b3a.13.2026.03.30.12.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 12:05:27 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Mon, 30 Mar 2026 19:04:43 +0000
Subject: [PATCH 3/3] migration/ram: Split mapped-ram header and page
 loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-fast-snapshot-refactor-v1-3-22143e70c467@gmail.com>
References: <20260330-fast-snapshot-refactor-v1-0-22143e70c467@gmail.com>
In-Reply-To: <20260330-fast-snapshot-refactor-v1-0-22143e70c467@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Takeru Hayasaka <hayatake396@gmail.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=hayatake396@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Split parse_ramblock_mapped_ram() into two stages:

- parse_ramblock_mapped_ram_header(): reads the MappedRamHeader and
  dirty bitmap, storing pages_offset and file_bmap on the RAMBlock
  for later use.

- parse_ramblock_mapped_ram_pages(): reads all page data using the
  bitmap and pages_offset populated by the header stage.

The original parse_ramblock_mapped_ram() becomes a thin wrapper that
calls both in sequence, preserving the existing behavior.

The bitmap is now stored in block->file_bmap (which already exists
on RAMBlock for the save side) instead of a function-local variable.
The pages function frees the bitmap after loading is complete.

This separation prepares for fast snapshot load, which will call
only the header stage at load time and defer page loading to a
userfaultfd-based demand paging mechanism.

No functional change.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
 migration/ram.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 979751f61b30..301ef9758e25 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4152,10 +4152,15 @@ err:
     return false;
 }
 
-static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
-                                      ram_addr_t length, Error **errp)
+/*
+ * Read the mapped-ram header and dirty bitmap for a RAM block.
+ *
+ * Populates block->pages_offset and block->file_bmap so that page
+ * data can be loaded later (either eagerly or on demand).
+ */
+static void parse_ramblock_mapped_ram_header(QEMUFile *f, RAMBlock *block,
+                                             ram_addr_t length, Error **errp)
 {
-    g_autofree unsigned long *bitmap = NULL;
     MappedRamHeader header;
     size_t bitmap_size;
     long num_pages;
@@ -4187,19 +4192,54 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
     num_pages = length / header.page_size;
     bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
 
-    bitmap = g_malloc0(bitmap_size);
-    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
+    block->file_bmap = g_malloc0(bitmap_size);
+    if (qemu_get_buffer_at(f, (uint8_t *)block->file_bmap, bitmap_size,
                            header.bitmap_offset) != bitmap_size) {
         error_setg(errp, "Error reading dirty bitmap");
+        g_free(block->file_bmap);
+        block->file_bmap = NULL;
         return;
     }
+}
+
+/*
+ * Read all page data for a mapped-ram RAM block using the bitmap
+ * and pages_offset previously populated by parse_ramblock_mapped_ram_header().
+ */
+static void parse_ramblock_mapped_ram_pages(QEMUFile *f, RAMBlock *block,
+                                            ram_addr_t length, Error **errp)
+{
+    long num_pages;
 
-    if (!read_ramblock_mapped_ram(f, block, num_pages, bitmap, errp)) {
+    if (!block->file_bmap) {
+        /* Shared block that was skipped during header parsing */
         return;
     }
 
+    num_pages = length / TARGET_PAGE_SIZE;
+
+    if (!read_ramblock_mapped_ram(f, block, num_pages,
+                                  block->file_bmap, errp)) {
+        goto out;
+    }
+
     /* Skip pages array */
     qemu_set_offset(f, block->pages_offset + length, SEEK_SET);
+
+out:
+    g_free(block->file_bmap);
+    block->file_bmap = NULL;
+}
+
+static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
+                                      ram_addr_t length, Error **errp)
+{
+    parse_ramblock_mapped_ram_header(f, block, length, errp);
+    if (*errp) {
+        return;
+    }
+
+    parse_ramblock_mapped_ram_pages(f, block, length, errp);
 }
 
 static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)

-- 
2.43.0


