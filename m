Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987EAC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgdC-0000HF-7V; Tue, 28 Jan 2025 03:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgbI-0003T1-E4; Tue, 28 Jan 2025 03:05:36 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgbG-00033R-3I; Tue, 28 Jan 2025 03:05:35 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3D68DE1B74;
 Tue, 28 Jan 2025 10:57:09 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AD6F61A6327;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 341DE520DF; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 45/58] migration: Rename vmstate_info_nullptr
Date: Mon, 27 Jan 2025 23:25:31 +0300
Message-Id: <20250127202547.3723716-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rename vmstate_info_nullptr from "uint64_t" to "nullptr". This vmstate
actually reads and writes just a byte, so the proper name would be
uint8. However, since this is a marker for a NULL pointer, it's
convenient to have a more explicit name that can be identified by the
consumers of the JSON part of the stream.

Change the name to "nullptr" and add support for it in the
analyze-migration.py script. Arbitrarily use the name of the type as
the value of the field to avoid the script showing 0x30 or '0', which
could be confusing for readers.

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250109185249.23952-5-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit f52965bf0eeee28e89933264f1a9dbdcdaa76a7e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index e83bfccb9e..d70d573dbd 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -338,7 +338,7 @@ static int put_nullptr(QEMUFile *f, void *pv, size_t size,
 }
 
 const VMStateInfo vmstate_info_nullptr = {
-    .name = "uint64",
+    .name = "nullptr",
     .get  = get_nullptr,
     .put  = put_nullptr,
 };
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index fcda11f31d..923f174f1b 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -417,6 +417,28 @@ def __init__(self, desc, file):
         super(VMSDFieldIntLE, self).__init__(desc, file)
         self.dtype = '<i%d' % self.size
 
+class VMSDFieldNull(VMSDFieldGeneric):
+    NULL_PTR_MARKER = b'0'
+
+    def __init__(self, desc, file):
+        super(VMSDFieldNull, self).__init__(desc, file)
+
+    def __repr__(self):
+        # A NULL pointer is encoded in the stream as a '0' to
+        # disambiguate from a mere 0x0 value and avoid consumers
+        # trying to follow the NULL pointer. Displaying '0', 0x30 or
+        # 0x0 when analyzing the JSON debug stream could become
+        # confusing, so use an explicit term instead.
+        return "nullptr"
+
+    def __str__(self):
+        return self.__repr__()
+
+    def read(self):
+        super(VMSDFieldNull, self).read()
+        assert(self.data == self.NULL_PTR_MARKER)
+        return self.data
+
 class VMSDFieldBool(VMSDFieldGeneric):
     def __init__(self, desc, file):
         super(VMSDFieldBool, self).__init__(desc, file)
@@ -558,6 +580,7 @@ def getDict(self):
     "bitmap" : VMSDFieldGeneric,
     "struct" : VMSDFieldStruct,
     "capability": VMSDFieldCap,
+    "nullptr": VMSDFieldNull,
     "unknown" : VMSDFieldGeneric,
 }
 
-- 
2.39.5


