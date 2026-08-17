Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2473C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvurF-0002bZ-1x; Mon, 17 Aug 2026 06:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvurC-0002UO-Jk; Mon, 17 Aug 2026 06:46:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvurA-00044r-NG; Mon, 17 Aug 2026 06:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=dECS50UYWkzGL6+TmBTaHHU/+jJq6n59k7QIxvmZwCo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p5ntI1tdt3bDOStbidmNUGNX4noy3KW7rsKJLr7DRRdu/ekw99grlIPf/WotwojIC
 JP5cvf6WswUN+GeZvClOXNYbK6JggEooBwdy5pE6SEpSzusD2lEZVOAIpDrvziZWPO
 twrtyL3iKZKrw2iQjeEgnM6VQlpR3XjDRbiwBV8NQ/GAppcGGUB9NO1iPUEZhjqp7w
 MbwMcvGdjpzN12Fszmj5jYMkSz9xlSfWTpl4ukxnNMY2JKPC2FSe1AkmlI2L7XbbkC
 BwJwww8QL66ithWHfvFxxsUeH4Nww5F5Cux8zsEjB+B0B+aXWVmRUHFiiz2X9VGzdB
 Q9WB3MZXRIlyw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A7A61CBB77;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9BA1B40D208;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 23E5430E66; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 138/161] pc-bios/s390-ccw: bounds-check zipl menu
 entry index before array write
Date: Mon, 17 Aug 2026 13:42:52 +0300
Message-ID: <20260817104344.2047346-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
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

menu_get_zipl_boot_index() iterates NUL-separated strings from the
zipl stage-2 boot-menu block, passes each to zipl_print_entry() which
converts EBCDIC to ASCII and returns atoi(), then writes true into
valid_entries[entry]. valid_entries is a MAX_BOOT_ENTRIES element
stack array, but entry was never bounds-checked, so a crafted on-disk
value could index arbitrarily beyond the array.

Fix this in two places:

- zipl_print_entry() now validates that the first significant character
  (after an optional leading space) is a digit. Entries that fail this
  check return -1 without printing.

- menu_get_zipl_boot_index() skips any entry whose index is outside
  [0, MAX_BOOT_ENTRIES) before writing to valid_entries[].

Fixes: 7385e947fc65 ("pc-bios/s390-ccw: fix non-sequential boot entries (eckd)")
Cc: qemu-stable@nongnu.org
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260727115052.24289-5-borntraeger@linux.ibm.com
[farman@linux.ibm.com: Added qemu-stable]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 33909d4ebd5c197626c3142550ee11f4bdb1df48)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index eeaff78f870..b6a9a56d462 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -176,18 +176,24 @@ int menu_get_boot_index(bool *valid_entries)
     return boot_index;
 }
 
-/* Returns the entry number that was printed */
+/* Returns the entry number that was printed, or -1 on invalid entry */
 static int zipl_print_entry(const char *data, size_t len)
 {
     char buf[len + 2];
+    const char *p;
 
     ebcdic_to_ascii(data, buf, len);
     buf[len] = '\n';
     buf[len + 1] = '\0';
 
+    p = (buf[0] == ' ') ? buf + 1 : buf;
+    if (!isdigit((unsigned char)*p)) {
+        return -1;
+    }
+
     printf("%s", buf);
 
-    return buf[0] == ' ' ? atoi(buf + 1) : atoi(buf);
+    return atoi(p);
 }
 
 int menu_get_zipl_boot_index(const char *menu_data)
@@ -216,6 +222,9 @@ int menu_get_zipl_boot_index(const char *menu_data)
         entry = zipl_print_entry(menu_data, len);
         menu_data += len + 1;
 
+        if (entry < 0 || entry >= MAX_BOOT_ENTRIES) {
+            continue;
+        }
         valid_entries[entry] = true;
 
         if (entry == 0) {
-- 
2.47.3


