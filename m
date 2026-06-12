Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9B9CD98D9
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY5FW-0005Qd-Cu; Fri, 12 Jun 2026 13:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Es-00054d-Hm; Fri, 12 Jun 2026 13:00:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Eq-0005vc-Iz; Fri, 12 Jun 2026 13:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781283582; bh=gFKr/H9SOcM/QTiHEp6PPei+Z9A4s5bUhNKp/y/6VkY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RWFDhAMMg0lj2pNvyucYTst7MHNQXP9d+qipmDlT9cw+Mi+N1/arSBylUx3J5+jLZ
 PzCm4zIRIPm3juXblVQ5ks9gP/R3dvGZAPDapmMdMHMZzgacyR5wMXVWh/UYoej45F
 K5Rvap7jRdh2OTRyufOHGdbVSszK1/UxPHhwwPW4HcK7pLpruUCmioMtk1JC8PQi2t
 +ahKxNyyTjMABF0AprGjV1xrScyTzX01Jp4WN49a/TJp3cOq/fFk5XJJ7SWawR09sT
 xJn43joFoULy8fEGEy0Dk/et67HPtjFdFEzeEGDB5QckxiFbCSGZCJFw7z7lwvFP6/
 8o13LWEVhps9Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 13B821B6BC9;
 Fri, 12 Jun 2026 19:59:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BB9E23CE166;
 Fri, 12 Jun 2026 19:59:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Evgeny Kolmakov <randomjack94dev@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 4/8] net/colo-compare: Use QEMU_LOCK_GUARD to simplify mutex
 handling
Date: Fri, 12 Jun 2026 19:59:48 +0300
Message-ID: <20260612165957.1779082-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165957.1779082-1-mjt@tls.msk.ru>
References: <20260612165957.1779082-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Evgeny Kolmakov <randomjack94dev@gmail.com>

Replace qemu_mutex_(un)lock() calls with the QEMU_LOCK_GUARD().

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 net/colo-compare.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 823b8aa323..5986fb1e88 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -902,14 +902,13 @@ static void check_old_packet_regular(void *opaque)
 void colo_notify_compares_event(void *opaque, int event, Error **errp)
 {
     CompareState *s;
-    qemu_mutex_lock(&colo_compare_mutex);
+    QEMU_LOCK_GUARD(&colo_compare_mutex);
 
     if (!colo_compare_active) {
-        qemu_mutex_unlock(&colo_compare_mutex);
         return;
     }
 
-    qemu_mutex_lock(&event_mtx);
+    QEMU_LOCK_GUARD(&event_mtx);
     QTAILQ_FOREACH(s, &net_compares, next) {
         s->event = event;
         qemu_bh_schedule(s->event_bh);
@@ -919,9 +918,6 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
     while (event_unhandled_count > 0) {
         qemu_cond_wait(&event_complete_cond, &event_mtx);
     }
-
-    qemu_mutex_unlock(&event_mtx);
-    qemu_mutex_unlock(&colo_compare_mutex);
 }
 
 static void colo_compare_timer_init(CompareState *s)
-- 
2.47.3


