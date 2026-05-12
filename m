Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3ACCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuk2-00063J-32; Tue, 12 May 2026 17:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuio-0004gY-RK; Tue, 12 May 2026 17:32:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuim-0002jY-Uc; Tue, 12 May 2026 17:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619500; bh=v6CLEle3Y76GVTrXMau5TR4bHiXzQQR2E4WOqrllpiU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M1/3YUVV5vXbvCsYqvaftcV0q9/TS0QAhWTUqWu5IMpLEYmaQ6UNw9fgp41XKEvlx
 zMbfsJjqcwHTRovpxnqqWNyRD7Y2U43/LWYQB8ymgXe9+dHR+2xdCFsCnru6VRQWFZ
 cviIJy+JlqtShTJsOzHS57sR+XIoj3ff9BAvbzwa0ntvg3drA3helQhDvfjE5Qjw6O
 NxVTWwZM+3iOR2xUkMSkoPt65pTmzCSiiJyOrhziHX43ZDfeVxHSDvHJ5trUBQEdcj
 ppjGxKwg98BWPOP4B1/jTO+Jd55mMAwLpnXkl53KML2N+ax3f3Hofitm/eC9vvnHLs
 eHZyCzqTOmrxw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B77F1AA3FB;
 Tue, 12 May 2026 23:58:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 493453ABD53;
 Tue, 12 May 2026 23:58:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 48/58] migration: Fix low possibility downtime
 violation
Date: Tue, 12 May 2026 23:58:09 +0300
Message-ID: <20260512205820.361821-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
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

From: Peter Xu <peterx@redhat.com>

When QEMU queried the estimated version of pending data and thinks it's
ready to converge, it'll send another accurate query to make sure of it.
It is needed to make sure we collect the latest reports and that equation
still holds true.

However we missed one tiny little difference here on "<" v.s. "<=" when
comparing pending_size (A) to threshold_size (B)..

QEMU src only re-query if A<B, but will kickoff switchover if A<=B.

I think it means it is possible to happen if A (as an estimate only so far)
accidentally equals to B, then re-query won't happen and switchover will
proceed without considering new dirtied data.

It turns out it was an accident in my commit 7aaa1fc072 when refactoring
the code around.  Fix this by using the same equation in both places.

Fixes: 7aaa1fc072 ("migration: Rewrite the migration complete detect logic")
Cc: qemu-stable@nongnu.org
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20260421202110.306051-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 455a6167f25416ce97ea966d6e8301df9fda9a47)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index 5c9aaa6e58..dfc60372cf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3242,7 +3242,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * postcopy started, so ESTIMATE should always match with EXACT
          * during postcopy phase.
          */
-        if (pending_size < s->threshold_size) {
+        if (pending_size <= s->threshold_size) {
             qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
             pending_size = must_precopy + can_postcopy;
             trace_migrate_pending_exact(pending_size, must_precopy,
-- 
2.47.3


