Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB7CEA8105
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmjI-0002M3-V0; Tue, 10 Feb 2026 07:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmjD-0001yg-LW; Tue, 10 Feb 2026 07:20:27 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmjB-0002u6-Nl; Tue, 10 Feb 2026 07:20:27 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7D367187DE9;
 Tue, 10 Feb 2026 15:16:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1B68C360CFD;
 Tue, 10 Feb 2026 15:17:14 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 85/85] scripts/qemugdb: timers: Fix KeyError in 'qemu
 timers' command
Date: Tue, 10 Feb 2026 15:16:49 +0300
Message-ID: <20260210121657.69363-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260210151548@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260210151548@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Currently invoking 'qemu timers' command results into: "gdb.error: There
is no member named last".  Let's remove the legacy 'last' field from
QEMUClock, as it was removed in v4.2.0 by the commit 3c2d4c8aa6a
("timer: last, remove last bits of last").

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20251204105019.455060-3-andrey.drobyshev@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 80c97930a93c32e2e666f5420af2d5734021a135)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 46537b27cf..0538677288 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -37,10 +37,9 @@ def dump_timers(self, timer):
 
     def process_timerlist(self, tlist, ttype):
         gdb.write("Processing %s timers\n" % (ttype))
-        gdb.write("  clock %s is enabled:%s, last:%s\n" % (
+        gdb.write("  clock %s is enabled:%s\n" % (
             tlist['clock']['type'],
-            tlist['clock']['enabled'],
-            tlist['clock']['last']))
+            tlist['clock']['enabled']))
         if int(tlist['active_timers']) > 0:
             self.dump_timers(tlist['active_timers'])
 
-- 
2.47.3


