Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764D2CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lQ-0000wK-0n; Mon, 03 Nov 2025 16:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lM-0000vc-D2
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lA-0005Cc-RX
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762203998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlB0Kc90UPr6D+7Ti5JxxglMdrXTiBSo67o+zFkEX2E=;
 b=bd4wCj/InZpJZPpRVn6S9haaZioDyCkj0bO5G0xVKu3OdRdivMO73Us/LlhvgBKudbRrUj
 9CuF5DKvRdewgqwhve7W7vZboYjyCjw5sj+nb7Q8W6NeM4CcRdY3Sz6PnUyfNYvc12WgWd
 0JqmmaXztu9QIHZmsRnGNuXj/it6VCg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-047AfHUANxCiqMCty8lQtQ-1; Mon, 03 Nov 2025 16:06:36 -0500
X-MC-Unique: 047AfHUANxCiqMCty8lQtQ-1
X-Mimecast-MFC-AGG-ID: 047AfHUANxCiqMCty8lQtQ_1762203996
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8904a9e94ebso1230283885a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762203996; x=1762808796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlB0Kc90UPr6D+7Ti5JxxglMdrXTiBSo67o+zFkEX2E=;
 b=aYaFGDIHOjJf0CpoPjKGP2bZZNS8ylV96Myip2dYKFr+Z8sxI6RyKIoavtSJlQyVph
 PVDdauj3/wA8FK9npr0Em7m4wDDKH0Et0hIAM8J4fAq1nMf5lyCZYMx2LVKceHQ3ltKo
 /KR1FCTd013wxDUg9L9jI8RqKB3uVASA6Skb2bA2LjToI6C05Q/4SKnM6ImMp6c9TQFy
 nO5QAYIGPiZbMsD5jKG88gL7hJeOOTukzKQrCOxEAtCUQp0jUiKzIDnf0sYsokNdMeEU
 2SYmN5zXwDdUFofGcpjUUkSNgWIRaMTkbX865+D/ZRxHjEdumHYI6VGnS2wgQkp1jOAS
 11YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203996; x=1762808796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlB0Kc90UPr6D+7Ti5JxxglMdrXTiBSo67o+zFkEX2E=;
 b=BaTS2kfuHb8FvTsZMJdknL/f5UqCvGv/412QM47Wi6mT7BMNZhfdn/1RQMr7nhVDhe
 TdmD/uXea/yEEdYSYGi9cILoroiKkjvy5/uCcgm1Y0BVbgp59X8rI3SsABoALqR0gOFb
 lPZc/mbqKlP9eX6d6UaPu211s/zKvdqx0qy6RMd2Bt//DZ9QsXl1x4Bg72mdN3pRpavB
 OAlOuanXy2OTnmweKJ1+dVK56/qsUsDyWHnmrjmlq6rBjvMlzfNgqjmIM6aTczbFpTNy
 5lMIbrylWmM3TwZ8faRITBoMYY1bhlnTVFWUL/tlh5kGTVoyvt3FPsBnyBirfK7u/y7c
 KhZQ==
X-Gm-Message-State: AOJu0Yw+CUGNHh64lD2iQLhpZLQwGMVRwJbpqJrQvHvhTx6J+rHjpj01
 GFfil7oow+sD7yecuxZ09ujn1Shn/MsmGqyXwVZc1X6Fa70SlBX2CV6W+1UKRHVLYzj0ZBUy8jR
 eHdlkRni+8m8rbG+oZzrhV7wCL6Wa5GS2fNZlgVK4sih7o6tXlbbAtLZbaZpGz54SR8psMxVWKm
 CMgKpeE6zPvq/StN+SuzKrDtzSc5YA5tnQ/hCuBQ==
X-Gm-Gg: ASbGncskVoEOCbyqAgu+G+KXgyRtaUH0gAZcaQuMcZ6JMvbMHTsJIXQZ+kQsoA+XT/W
 9PoHfUyrPGVy/etbnfvXAmAVNukKfBX9KBXexqHzL8NBkucQ0V9NM4eNeyqZ9OExBB4Ck8WRTwS
 JZkCiaL9EmClWJgQqDdDHrCnG0hqUCKknfNU0zAurRhDT705XCXWocjmMYIQdkPgZhf9KJOzffO
 QzgEVrmQ/uUOUPvWi/C3fhooIpoF5FKX/xIB9UcI4KI4Q+qf5o9rvS47fZv0Pv+i3RBxuSEaczT
 xK81sRkYvjlGGLPC8r7Yxcau7uWMUxIqkIN2RsGGtyUkhVkhzam89+P6Y4X7Q+Pb
X-Received: by 2002:a05:620a:4410:b0:89a:2d9b:74ea with SMTP id
 af79cd13be357-8ab9afd428cmr1658511685a.42.1762203995563; 
 Mon, 03 Nov 2025 13:06:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEBccPJ2ZtzRCk96hACALrtMDOoWpI6fDmTxDKgAOLO9u8FoW2mA5LVsCIE6WvRVk92ZxL6Q==
X-Received: by 2002:a05:620a:4410:b0:89a:2d9b:74ea with SMTP id
 af79cd13be357-8ab9afd428cmr1658504685a.42.1762203994894; 
 Mon, 03 Nov 2025 13:06:34 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:33 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PULL 05/36] migration: mapped-ram: handle zero pages
Date: Mon,  3 Nov 2025 16:05:54 -0500
Message-ID: <20251103210625.3689448-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marco Cavenati <Marco.Cavenati@eurecom.fr>

Make mapped-ram compatible with loadvm snapshot restoring by explicitly
zeroing memory pages in this case.
Skip zeroing for -incoming and -loadvm migrations to preserve performance.

Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Link: https://lore.kernel.org/r/20251010115954.1995298-3-Marco.Cavenati@eurecom.fr
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c |  1 -
 migration/ram.c     | 59 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index d9227809d7..e78324b80c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -449,7 +449,6 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
 static const
 INITIALIZE_MIGRATE_CAPS_SET(check_caps_savevm,
                             MIGRATION_CAPABILITY_MULTIFD,
-                            MIGRATION_CAPABILITY_MAPPED_RAM,
 );
 
 static bool migrate_incoming_started(void)
diff --git a/migration/ram.c b/migration/ram.c
index 1384748193..29f016cb25 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4038,12 +4038,58 @@ static size_t ram_load_multifd_pages(void *host_addr, size_t size,
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
+    /*
+     * Zeroing is not needed for either -loadvm (RUN_STATE_PRELAUNCH), or
+     * -incoming (RUN_STATE_INMIGRATE).
+     */
+    if (!runstate_check(RUN_STATE_RESTORE_VM)) {
+        return true;
+    }
+
+    if (from_bit_idx >= to_bit_idx) {
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
@@ -4052,6 +4098,12 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
          set_bit_idx < num_pages;
          set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
 
+        /* Zero pages */
+        if (!handle_zero_mapped_ram(block, clear_bit_idx, set_bit_idx, errp)) {
+            return false;
+        }
+
+        /* Non-zero pages */
         clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
 
         unread = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
@@ -4083,6 +4135,11 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
         }
     }
 
+    /* Handle trailing 0 pages */
+    if (!handle_zero_mapped_ram(block, clear_bit_idx, num_pages, errp)) {
+        return false;
+    }
+
     return true;
 
 err:
-- 
2.50.1


