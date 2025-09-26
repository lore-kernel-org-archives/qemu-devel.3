Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3F6CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23Yz-0007Xj-73; Fri, 26 Sep 2025 04:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Yt-0007Wq-QK; Fri, 26 Sep 2025 04:12:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Yf-0000Qc-Oy; Fri, 26 Sep 2025 04:12:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 99F5F157D54;
 Fri, 26 Sep 2025 11:10:31 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AB9F6290C38;
 Fri, 26 Sep 2025 11:10:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "minglei.liu" <minglei.liu@smartx.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 12/60] qga: Fix truncated output handling in
 guest-exec status reporting
Date: Fri, 26 Sep 2025 11:09:40 +0300
Message-ID: <20250926081031.2214971-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: "minglei.liu" <minglei.liu@smartx.com>

Signed-off-by: minglei.liu <minglei.liu@smartx.com>
Fixes: a1853dca743
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250711021714.91258-1-minglei.liu@smartx.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit 28c5d27dd4dc4100a96ff4c9e5871dd23c6b02ec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/commands.c b/qga/commands.c
index 5a5fad31f8..5f20af25d3 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -205,13 +205,15 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
 #endif
         if (gei->out.length > 0) {
             ges->out_data = g_base64_encode(gei->out.data, gei->out.length);
-            ges->has_out_truncated = gei->out.truncated;
+            ges->has_out_truncated = true;
+            ges->out_truncated = gei->out.truncated;
         }
         g_free(gei->out.data);
 
         if (gei->err.length > 0) {
             ges->err_data = g_base64_encode(gei->err.data, gei->err.length);
-            ges->has_err_truncated = gei->err.truncated;
+            ges->has_err_truncated = true;
+            ges->err_truncated = gei->err.truncated;
         }
         g_free(gei->err.data);
 
-- 
2.47.3


