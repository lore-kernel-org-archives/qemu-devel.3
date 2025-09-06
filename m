Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B56CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 21:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv03G-0003l5-EZ; Sat, 06 Sep 2025 17:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv03D-0003jq-Og; Sat, 06 Sep 2025 17:02:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv032-0005x5-3K; Sat, 06 Sep 2025 17:02:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5373F150F84;
 Sun, 07 Sep 2025 00:00:55 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1778B27868F;
 Sun,  7 Sep 2025 00:00:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Xu <dxu@dxuuu.xyz>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 25/34] qga: Fix memory leak when output stream is
 unused
Date: Sun,  7 Sep 2025 00:00:45 +0300
Message-ID: <20250906210056.127031-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
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

From: Daniel Xu <dxu@dxuuu.xyz>

If capture-output is requested but one of the channels goes unused (eg.
we attempt to capture stderr but the command never writes to stderr), we
can leak memory.

guest_exec_output_watch() is (from what I understand) unconditionally
called for both streams if output capture is requested. The first call
will always pass the `p->size == p->length` check b/c both values are
0. Then GUEST_EXEC_IO_SIZE bytes will be allocated for the stream.

But when we reap the exited process there's a `gei->err.length > 0`
check to actually free the buffer. Which does not get run if the command
doesn't write to the stream.

Fix by making free() unconditional.

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit d6f67b83b81bf49b5c62e77143ed39c020e51830)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/commands.c b/qga/commands.c
index 6cf978322e..ca63fe6e15 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -207,16 +207,16 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
         if (gei->out.length > 0) {
             ges->has_out_data = true;
             ges->out_data = g_base64_encode(gei->out.data, gei->out.length);
-            g_free(gei->out.data);
             ges->has_out_truncated = gei->out.truncated;
         }
+        g_free(gei->out.data);
 
         if (gei->err.length > 0) {
             ges->has_err_data = true;
             ges->err_data = g_base64_encode(gei->err.data, gei->err.length);
-            g_free(gei->err.data);
             ges->has_err_truncated = gei->err.truncated;
         }
+        g_free(gei->err.data);
 
         QTAILQ_REMOVE(&guest_exec_state.processes, gei, next);
         g_free(gei);
-- 
2.47.3


