Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9319D0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNtvz-0007RF-Gh; Tue, 25 Nov 2025 09:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vNtuu-0007FH-AN
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:29 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vNtun-0002Gq-LE
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=yu8rxNLiMjUJ+cDvQqRD4uD4vrNkGyw0BtvapPeffJg=; b=Dr1j9ytgwWEq
 SwPbbLxn6QYxu4ZT9/+GyoR9IcmOsV56lPUUDjoe3+CLMJntJ76vCUWxqxnO5nE8NHIzduLXaq3Ez
 apiSw+eZftEIurna1c4vzI0RQKS7JZ8dOtj3Vx5AjL/vLfFsE64NVCW4ekCwdSg3l55kHEPXdEZpE
 UoGUqTYXzZ2xPPpQviMerjSBIqCdPoOZrFPv1L56IjFwMfYHP5rCE5mz2yCUk/k1lJ6qUN5b/g71o
 Txex9r9t7fhUYds5dmItEW2ZPK0ImfF0cb4SEZwv5KkxroZrii/0jK68jFJjWKZyUr9LbYJWszLxo
 YTZ1jKj9kyy2xg7UwrPyDA==;
Received: from [130.117.225.5] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1vNtsz-003IJo-0I;
 Tue, 25 Nov 2025 15:20:56 +0100
From: andrey.drobyshev@virtuozzo.com
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 2/4] scripts/qemugdb: timers: Fix KeyError in 'qemu timers'
 command
Date: Tue, 25 Nov 2025 16:21:03 +0200
Message-ID: <20251125142105.448289-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Currently invoking 'qemu timers' command results into: "gdb.error: There
is no member named last".  Let's remove the legacy 'last' field from
QEMUClock, as it was removed in v4.2.0 by the commit 3c2d4c8aa6a
("timer: last, remove last bits of last").

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/timers.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 5714f92cc2..1219a96b32 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -36,10 +36,9 @@ def dump_timers(self, timer):
 
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
2.43.5


