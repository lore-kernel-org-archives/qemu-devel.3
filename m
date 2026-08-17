Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6841C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxVw-0003v6-20; Mon, 17 Aug 2026 09:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVv-0003uT-0B; Mon, 17 Aug 2026 09:36:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVs-0007Lk-Vb; Mon, 17 Aug 2026 09:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=6mk87ynHwhOR0387+e/GXDSI16HEtgwmle9s3c9/ZuM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HSIJWnngD9r4lewYQHkMDbDn3pHFFz0mv+B4dG4MIpjqOKTvE9A/6H5Nv/lStQlED
 OpLN3IBYjSSfhR8eykTf/5Wsd/r83rNqb8YWoktCjONh7QTB7p1FeoB6BrHUPK1vEj
 Ul4cP10duGW7+aTSEB4rsa9bApNUbGRk9RnWCjP062uehlwzRyOyGAOTD2L02AKV0c
 4LFhWBiUoK72+xfUw99V4BCGh2myIe62oqy0bhAioFhtxtAJp5iz7E74rBNnMedUkk
 qXvY/jh4/XnBApnCGNVSyqUgoaZixvWCDOD1OwPPOXVIc7l4rDvO6NYYWceYOG2ps5
 Y9IfXyFR6Djjg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 30EE71CBCC0;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6C10540D41D;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A723230F8A; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 113/135] pc-bios/s390-ccw: bounds-check zipl menu
 entry index before array write
Date: Mon, 17 Aug 2026 16:34:23 +0300
Message-ID: <20260817133451.2384630-11-mjt@tls.msk.ru>
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
index 84062e94af4..c400004f9a8 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -176,18 +176,24 @@ static int get_boot_index(bool *valid_entries)
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


