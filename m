Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3BAE7FDC7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmztf-0000Vn-Sg; Mon, 02 Feb 2026 14:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztV-0000QN-WE; Mon, 02 Feb 2026 14:47:34 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztT-0003Fp-Gv; Mon, 02 Feb 2026 14:47:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C1EF1850A0;
 Mon, 02 Feb 2026 22:46:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3DC2435B282;
 Mon, 02 Feb 2026 22:46:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 14/69] qga: Fix ubsan warning
Date: Mon,  2 Feb 2026 22:45:37 +0300
Message-ID: <20260202194638.939438-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When compiling QEMU with --enable-ubsan there is a undefined behavior
warning when running "make check":

 .../qga/commands-linux.c:452:15: runtime error: applying non-zero offset 5 to null pointer
 #0 0x55ea7b89450c in build_guest_fsinfo_for_pci_dev ..../qga/commands-linux.c:452:15

Fix it by avoiding the additional pointer variable here and use an
"offset" integer variable instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250730072709.27077-1-thuth@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit 83f6dceb8f5c0a1efe806a9a4905cbc743a8a378)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 9dc0c82503..4a09ddc760 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -400,10 +400,10 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
                                            Error **errp)
 {
     unsigned int pci[4], host, hosts[8], tgt[3];
-    int i, nhosts = 0, pcilen;
+    int i, offset, nhosts = 0, pcilen;
     GuestPCIAddress *pciaddr = disk->pci_controller;
     bool has_ata = false, has_host = false, has_tgt = false;
-    char *p, *q, *driver = NULL;
+    char *p, *driver = NULL;
     bool ret = false;
 
     p = strstr(syspath, "/devices/pci");
@@ -445,13 +445,13 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
 
     p = strstr(syspath, "/ata");
     if (p) {
-        q = p + 4;
+        offset = 4;
         has_ata = true;
     } else {
         p = strstr(syspath, "/host");
-        q = p + 5;
+        offset = 5;
     }
-    if (p && sscanf(q, "%u", &host) == 1) {
+    if (p && sscanf(p + offset, "%u", &host) == 1) {
         has_host = true;
         nhosts = build_hosts(syspath, p, has_ata, hosts,
                              ARRAY_SIZE(hosts), errp);
-- 
2.47.3


