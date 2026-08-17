Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F231EC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxVg-0003Gz-3m; Mon, 17 Aug 2026 09:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVb-0003Cf-0P; Mon, 17 Aug 2026 09:36:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVY-0007Lm-Sm; Mon, 17 Aug 2026 09:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=6LfzuFNyYS4myhSrAFLT6TAgK9rAyL8ijG40tHtoxcQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FswGAf6oLxu7LiL4gUMc24+JgsC+1vO3BegqNwuApwakXuLGso6TEb19ZEGsdyvTx
 1kiX/aWSlX47Na8lGIeNB4O3hZG7oIxiLKrnfgTHVgfKa3EZMyBufFH0w41wDI2Fk5
 7DGCPLL6cdcg+i8DYXcFBiKrErGs2tMwPmDJ+FYayn/5Y6W/7PU364aFJIsAMOhGUm
 haXP+DH/YAHMdBLLeeyR7dvoGfTAnoG64sXUuTaDxioCV1Y5CM4ta7H2ymsySfC7ey
 rXl6PX9ddBPeN5jp4R68QRAd/kX4moWFoKjLOGRiGoQRE3Ab9KGv+iDOlAsJR5/9XE
 J9JhzmwTXnNQg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3581B1CBCC1;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 70E0940D41E;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AA1D730F8C; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 114/135] pc-bios/s390-ccw: bound zipl menu strlen
 and replace VLA in zipl_print_entry
Date: Mon, 17 Aug 2026 16:34:24 +0300
Message-ID: <20260817133451.2384630-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Joshua Daley <jdaley@linux.ibm.com>

menu_get_zipl_boot_index() calls strlen() on a pointer into the middle
of _s2 with no upper bound, so a stage-2 image whose blocks contain no
NUL bytes causes strlen() to walk beyond _s2. The resulting length
is then used to size a stack VLA in zipl_print_entry(), risking a stack
overflow.

Fix by:

- Implementing strnlen(), a bounded version of strlen(). s390-ccw uses
  libc from SLOF, which includes strlen() but does not have an
  implementation of strnlen(), so we must implement our own.

- Adding a menu_data_end parameter to menu_get_zipl_boot_index() and
  replacing both strlen() calls with strnlen() bounded by the remaining
  buffer space. The loop guard also checks that the pointer has not
  reached menu_data_end. The function returns 0 (boot default) if
  somehow menu_data reaches menu_data_end before printing any entries.

- Replacing the VLA char buf[len + 2] in zipl_print_entry() with a fixed
  ZIPL_ENTRY_MAX + 2 (82-byte) buffer and truncating len before use.

- Passing s2_end (_s2 + sizeof(_s2)) as menu_data_end at the one call
  site in eckd_get_boot_menu_index(), so the bound is exactly the end of
  the buffer.

Fixes: f7178910845a ("s390-ccw: print zipl boot menu")
Cc: qemu-stable@nongnu.org
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260728134704.2924005-2-jdaley@linux.ibm.com
[farman@linux.ibm.com: Per list, add strnlen rationale to commit message
 and added cc stable]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit a3856a7ba44ba1b740eee7759b03079e2f5f637b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 0286b2e5245..020bc3b583c 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -61,6 +61,7 @@ static uint8_t _s2[MAX_SECTOR_SIZE * 3] __attribute__((__aligned__(PAGE_SIZE)));
 static void *s2_prev_blk = _s2;
 static void *s2_cur_blk = _s2 + MAX_SECTOR_SIZE;
 static void *s2_next_blk = _s2 + MAX_SECTOR_SIZE * 2;
+static void *s2_end = _s2 + sizeof(_s2);
 
 static inline int verify_boot_info(BootInfo *bip)
 {
@@ -308,7 +309,8 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
                 }
             }
 
-            return menu_get_zipl_boot_index(s2_cur_blk + banner_offset);
+            return menu_get_zipl_boot_index(s2_cur_blk + banner_offset,
+                                            s2_end);
         }
 
         prev_block_nr = cur_block_nr;
diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
index 8e3dfcb6d6c..d9b7da444a5 100644
--- a/pc-bios/s390-ccw/helper.h
+++ b/pc-bios/s390-ccw/helper.h
@@ -45,4 +45,14 @@ static inline void sleep(unsigned int seconds)
     }
 }
 
+static inline size_t strnlen(const char *s, size_t maxlen)
+{
+    size_t len = 0;
+
+    while (len < maxlen && s[len]) {
+        len++;
+    }
+    return len;
+}
+
 #endif
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index c400004f9a8..6bcd7085c0a 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -16,6 +16,7 @@
 #include "s390-ccw.h"
 #include "sclp.h"
 #include "s390-time.h"
+#include "helper.h"
 
 #define KEYCODE_NO_INP '\0'
 #define KEYCODE_ESCAPE '\033'
@@ -26,6 +27,9 @@
 #define ZIPL_TIMEOUT_OFFSET 138
 #define ZIPL_FLAG_OFFSET    140
 
+/* Max printable chars for a zipl boot menu entry */
+#define ZIPL_ENTRY_MAX 80
+
 #define TOD_CLOCK_MILLISECOND   0x3e8000
 
 #define LOW_CORE_EXTERNAL_INT_ADDR   0x86
@@ -179,9 +183,13 @@ static int get_boot_index(bool *valid_entries)
 /* Returns the entry number that was printed, or -1 on invalid entry */
 static int zipl_print_entry(const char *data, size_t len)
 {
-    char buf[len + 2];
+    char buf[ZIPL_ENTRY_MAX + 2];
     const char *p;
 
+    if (len > ZIPL_ENTRY_MAX) {
+        len = ZIPL_ENTRY_MAX;
+    }
+
     ebcdic_to_ascii(data, buf, len);
     buf[len] = '\n';
     buf[len + 1] = '\0';
@@ -196,7 +204,7 @@ static int zipl_print_entry(const char *data, size_t len)
     return atoi(p);
 }
 
-int menu_get_zipl_boot_index(const char *menu_data)
+int menu_get_zipl_boot_index(const char *menu_data, const char *menu_data_end)
 {
     size_t len;
     int entry;
@@ -212,13 +220,22 @@ int menu_get_zipl_boot_index(const char *menu_data)
         timeout = zipl_timeout * 1000;
     }
 
-    /* Print banner */
+    if (menu_data >= menu_data_end) {
+        return 0; /* Boot default */
+    }
+
+    /* Skip banner */
+    len = strnlen(menu_data, menu_data_end - menu_data);
+    menu_data += len + 1;
+    if (menu_data >= menu_data_end || !(*menu_data)) {
+        return 0; /* No entries, boot default */
+    }
+
     puts("s390-ccw zIPL Boot Menu\n");
-    menu_data += strlen(menu_data) + 1;
 
     /* Print entries */
-    while (*menu_data) {
-        len = strlen(menu_data);
+    while (menu_data < menu_data_end && *menu_data) {
+        len = strnlen(menu_data, menu_data_end - menu_data);
         entry = zipl_print_entry(menu_data, len);
         menu_data += len + 1;
 
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 6cdce3e5e5b..b78921295d7 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -83,7 +83,7 @@ void jump_to_low_kernel(void);
 
 /* menu.c */
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
-int menu_get_zipl_boot_index(const char *menu_data);
+int menu_get_zipl_boot_index(const char *menu_data, const char *menu_data_end);
 bool menu_is_enabled_zipl(void);
 int menu_get_enum_boot_index(bool *valid_entries);
 bool menu_is_enabled_enum(void);
-- 
2.47.3


