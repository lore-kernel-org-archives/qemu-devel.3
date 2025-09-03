Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE01BCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiPf-0001Of-Sw; Wed, 03 Sep 2025 04:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1utiPO-0001BJ-Dq; Wed, 03 Sep 2025 04:00:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1utiPM-0005zC-H0; Wed, 03 Sep 2025 03:59:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D7D3914F53A;
 Wed, 03 Sep 2025 10:59:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 45A6B26E185;
 Wed,  3 Sep 2025 10:59:53 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Stefan Weil via <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/5] chardev/baum: Fix compiler warning for Windows builds
Date: Wed,  3 Sep 2025 10:59:46 +0300
Message-ID: <20250903075952.481585-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250903075952.481585-1-mjt@tls.msk.ru>
References: <20250903075952.481585-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Weil via <qemu-trivial@nongnu.org>

Compiler warning:

../chardev/baum.c:657:25: warning: comparison between pointer and integer

Use brlapi_fileDescriptor instead of int for brlapi_fd and
BRLAPI_INVALID_FILE_DESCRIPTOR instead of -1.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 chardev/baum.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index f3e8cd27f0..ad68321504 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -94,7 +94,7 @@ struct BaumChardev {
     Chardev parent;
 
     brlapi_handle_t *brlapi;
-    int brlapi_fd;
+    brlapi_fileDescriptor brlapi_fd;
     unsigned int x, y;
     bool deferred_init;
 
@@ -654,7 +654,7 @@ static void baum_chr_open(Chardev *chr,
     baum->brlapi = handle;
 
     baum->brlapi_fd = brlapi__openConnection(handle, NULL, NULL);
-    if (baum->brlapi_fd == -1) {
+    if (baum->brlapi_fd == BRLAPI_INVALID_FILE_DESCRIPTOR) {
         error_setg(errp, "brlapi__openConnection: %s",
                    brlapi_strerror(brlapi_error_location()));
         g_free(handle);
@@ -665,6 +665,10 @@ static void baum_chr_open(Chardev *chr,
 
     baum->cellCount_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, baum_cellCount_timer_cb, baum);
 
+    /*
+     * On Windows, brlapi_fd is a pointer, which is being used here
+     * as an integer, but in practice it seems to work
+     */
     qemu_set_fd_handler(baum->brlapi_fd, baum_chr_read, NULL, baum);
 }
 
-- 
2.47.2


