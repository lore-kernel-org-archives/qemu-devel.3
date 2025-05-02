Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148A6C3ABB0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyEN-0003D1-7t; Fri, 02 May 2025 17:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uAyEK-00033s-AP
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:47:36 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uAyEH-0003lo-Og
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=doS4gMmYrhc5VVvsttyzcmsL5az3evY2NwGS9XHL+ZM=; b=G5mug/gjDkuZ
 /W4Ic4gePSpdwBRR9E3sQB9+ME/fFvf2ULPUR0ie6kij99QIzLbX59qZPOWSa31yV2/xAaEpqFgfW
 RikszJQfgaiq1/U53KVEI3YFWOkI1scrKPIXiThiImk3AHJ6MPr7R8VweqGzwI3tGDJuvFxhlxHo8
 aJlY/KAB2GFTUMR/C9krWt3ObUoxYEkUbIsHZnTY0ou9EKL2g764npg0sfxZL8QR+BXpaXByx86zu
 /zJD3dVNeeriLa8v8/zYJed+rPGl/fHrBIWuBqu3cBnc0LjwG3cn0sxZeAHIQrevKS8aPc62x3QNA
 WKcB4e57WYLX5yiZVSILnQ==;
Received: from [130.117.225.5] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1uAyAV-00C5mJ-0Z;
 Fri, 02 May 2025 23:47:25 +0200
From: andrey.drobyshev@virtuozzo.com
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH 1/1] monitor: don't wake up qmp_dispatcher_co coroutine upon
 cleanup
Date: Sat,  3 May 2025 00:47:29 +0300
Message-ID: <20250502214729.928380-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250502214729.928380-1-andrey.drobyshev@virtuozzo.com>
References: <20250502214729.928380-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Since the commit 3e6bed61 ("monitor: cleanup detection of qmp_dispatcher_co
shutting down"), coroutine pointer qmp_dispatcher_co is set to NULL upon
cleanup.  If a QMP command is sent after monitor_cleanup() (e.g. after
shutdown), this may lead to SEGFAULT on aio_co_wake(NULL).

As mentioned in the comment inside monitor_cleanup(), the intention is to
allow incoming requests while shutting down, but simply leave them
without any response.  Let's do exactly that, and if qmp_dispatcher_co
coroutine pointer has already been set to NULL, let's simply skip the
aio_co_wake() part.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 monitor/qmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 2f46cf9e49..cb99a12d94 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -356,7 +356,8 @@ void qmp_dispatcher_co_wake(void)
     /* Write request before reading qmp_dispatcher_co_busy.  */
     smp_mb__before_rmw();
 
-    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true)) {
+    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true) &&
+            qatomic_read(&qmp_dispatcher_co)) {
         aio_co_wake(qmp_dispatcher_co);
     }
 }
-- 
2.43.5


