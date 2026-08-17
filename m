Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B2FC5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvurS-0003OW-HN; Mon, 17 Aug 2026 06:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvurO-0003A6-1e; Mon, 17 Aug 2026 06:46:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvurE-00049I-3K; Mon, 17 Aug 2026 06:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=YtVME0pUUQpSUKRhoDPF2WjGA40n7cWnaLuK0B6S/18=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H9nhae1Ix/1xHVeqeqawuv/5+SVBNEHb8YgUtHyjbcJSPbD1Y82UkYG+1S7cxF6lJ
 iPwiy7EJq9pB0eBBCRNWIBZ0J+rNeBGLWo4n6HUwRnjJuSQ1R655yaUSo8njpjveJG
 sDC7mne530L04QMGNWTEPbc9IqekK5CeUSm4DpLEHMbUh0QCysUIA7W3VYHDeAsHIw
 DC2MEacmM6PxZF2rxh0wQQDsNGY8GDiryNd7+9KXUt5ZNvaWTjwd1WwM5ZDw94exqB
 ypkgIw6wdSznCuDvzl6U3D2fFtugi9Y5XrXOlxr7VljdwN4IAWpIFZKULJ51eWGUJk
 1vjgS1FIKYSXQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A2E071CBB79;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A449140D20A;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2A2F830E6A; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 140/161] pc-bios/s390-ccw: Fix off-by-one errors
 with loadparm and boot entries
Date: Mon, 17 Aug 2026 13:42:54 +0300
Message-ID: <20260817104344.2047346-20-mjt@tls.msk.ru>
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

From: Jared Rossi <jrossi@linux.ibm.com>

The loadparm may optionally be used to select a boot entry, with the
intended range being 0 through 31 inclusive, for a total of 32 entries.
Previously, MAX_BOOT_ENTRIES was defined as 31, indicating that it was
intended to correspond to the index of the boot entry rather than the
count; however, some guards also used MAX_BOOT_ENTRIES as a count of the
maximum allowed entries, which resulted in a mismatch between the intended
and actual range such that index 31 could never be used in practice.

Move the definition of MAX_BOOT_ENTRIES to qipl.h so it is shared and
change the value to 32, representing a count of the maximum number of
allowed boot entries and allowing the loadparm to accept values 0 through
31 as intended.  Update some instances in the netboot code where
MAX_BOOT_ENTRIES was used as the max index so that all guards treat
MAX_BOOT_ENTRIES as a count across all boot methods.

Cc: qemu-stable@nongnu.org
Fixes: 806315279d5c ("pc-bios/s390-ccw: Remove panics from ECKD IPL path")
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260728223013.4047042-1-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit c4d9412cdd1c9d1b8b2fcb0e0dbf57ca6286afd7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 8d3c83a80bd..b390f2f1125 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -20,6 +20,8 @@
 #define LOADPARM_LEN    8
 #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 
+#define MAX_BOOT_ENTRIES  32
+
 enum S390IplType {
     S390_IPL_TYPE_FCP = 0x00,
     S390_IPL_TYPE_CCW = 0x02,
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 651cedf6efa..791854fce0c 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -40,6 +40,9 @@
 #define DEFAULT_BOOT_RETRIES 10
 #define DEFAULT_TFTP_RETRIES 20
 
+/* Index 0 is reserved for default alias, start PXE cfg indices at 1 */
+#define PXECFG_MAX              (MAX_BOOT_ENTRIES - 1)
+
 extern char _start[];
 
 #define KERNEL_ADDR             ((void *)0L)
@@ -381,13 +384,13 @@ static int net_select_and_load_kernel(filename_ip_t *fn_ip,
 
 static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
 {
-    struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
+    struct pl_cfg_entry entries[PXECFG_MAX];
     int num_ent, def_ent = 0;
 
     num_ent = pxelinux_load_parse_cfg(fn_ip, mac, get_uuid(),
                                       DEFAULT_TFTP_RETRIES,
                                       cfgbuf, sizeof(cfgbuf),
-                                      entries, MAX_BOOT_ENTRIES, &def_ent);
+                                      entries, PXECFG_MAX, &def_ent);
 
     return net_select_and_load_kernel(fn_ip, num_ent, def_ent, entries);
 }
@@ -470,11 +473,11 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
          * a magic comment string.
          */
         if (!strncasecmp("# pxelinux", cfgbuf, 10)) {
-            struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
+            struct pl_cfg_entry entries[PXECFG_MAX];
             int num_ent, def_ent = 0;
 
             num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), entries,
-                                         MAX_BOOT_ENTRIES, &def_ent);
+                                         PXECFG_MAX, &def_ent);
             return net_select_and_load_kernel(fn_ip, num_ent, def_ent,
                                               entries);
         }
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index f6030a60710..25aac91d452 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -82,8 +82,6 @@ int menu_get_enum_boot_index(bool *valid_entries);
 bool menu_is_enabled_enum(void);
 int menu_get_boot_index(bool *valid_entries);
 
-#define MAX_BOOT_ENTRIES  31
-
 __attribute__ ((__noreturn__))
 static inline void panic(const char *string)
 {
-- 
2.47.3


