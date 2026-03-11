Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451C1112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LDJ-0003ah-7L; Wed, 11 Mar 2026 11:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LBI-0007cy-D5; Wed, 11 Mar 2026 11:09:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LBG-0005dr-2l; Wed, 11 Mar 2026 11:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241482; bh=ehjHPasUuekmBpODA5II2+xVPRfhwkoUi23mVAH+18U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g/dWcJy8gHk2SJGoL2bTa9fHuMI1CR3DkX2EU+vwM/GPwDw0IF+ed2L70JaomqUZa
 XpkZb+h1+TnZdLm/4cpMHVBeMg2dLtYstmaBlSTHow0X/5HFW2WAzH1B5Pq3f2Pasz
 XTJR0qpQLOFVx4upWx/Tmu9n/v7FwgqcFb4neFdOYrY9SQTZAtAj06gv01ql/m5hJq
 vyqOAA5NYtYReyrROUOqSvD0dUO10uOAHjVtXYKmW/ULPCgCtCxLZ4QjoeHO3NCu/Y
 XMA6dtBYURPnMcOIZqU68La0fVsgkZeIaNHcLfGUkdh3FEhyV/PQMh7ByNzYjYJ2ML
 oux/mdP7XiYpw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A3B38191E9A;
 Wed, 11 Mar 2026 18:04:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9271037C2DB;
 Wed, 11 Mar 2026 18:05:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richie Buturla <richie@linux.ibm.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 23/46] hw/9pfs: fix data race in
 v9fs_mark_fids_unreclaim()
Date: Wed, 11 Mar 2026 18:02:59 +0300
Message-ID: <20260311150327.1084669-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Richie Buturla <richie@linux.ibm.com>

A data race between v9fs_mark_fids_unreclaim() and v9fs_path_copy()
causes an inconsistent read of fidp->path. In v9fs_path_copy(), the
path size is set before the data pointer is allocated, creating a
window where size is non-zero but data is NULL.

v9fs_co_open2() holds a write lock during path modifications,
but v9fs_mark_fids_unreclaim() was not acquiring a read
lock, allowing it to race.

Fix by holding the path read lock during FID table iteration.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3300
Signed-off-by: Richie Buturla <richie@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260211154450.254338-1-richie@linux.ibm.com/
Fixes: 7a46274529 ("hw/9pfs: Add file descriptor reclaim support")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit c96f6d2398a9dc068fa82088ea43020a52e2b26d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index acfa7db4e1..c70096e6be 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -558,6 +558,7 @@ static int coroutine_fn v9fs_mark_fids_unreclaim(V9fsPDU *pdu, V9fsPath *path)
             sizeof(V9fsFidState *), 1);
     gint i;
 
+    v9fs_path_read_lock(s);
     g_hash_table_iter_init(&iter, s->fids);
 
     /*
@@ -578,6 +579,7 @@ static int coroutine_fn v9fs_mark_fids_unreclaim(V9fsPDU *pdu, V9fsPath *path)
             g_array_append_val(to_reopen, fidp);
         }
     }
+    v9fs_path_unlock(s);
 
     for (i = 0; i < to_reopen->len; i++) {
         fidp = g_array_index(to_reopen, V9fsFidState*, i);
-- 
2.47.3


