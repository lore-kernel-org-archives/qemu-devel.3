Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08FDCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu8v-0004Kk-US; Tue, 12 May 2026 16:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu8c-00046W-Oy; Tue, 12 May 2026 16:55:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu8a-000384-8R; Tue, 12 May 2026 16:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619274; bh=lekVdSW+GZE5VxPi+wE6oP1a1indjyHR7rqj1m9TbZ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=U8S7X2Pf1YOCI/hv6io2LaUUfq+YgkzMqkrvBHp+9oIRULqonaW41ujkF5LPZ6Av5
 NfZZi1PBExmDC9KPOKi+LihjPvr8/27q7w1e9cHsuJdcymsIEDX8deOg7ao8L3LpQO
 mzKjslYL4U/3ilUlK5sjJixP5uTc8FQmE5+LZMJdM8QMhcSkvt8uAh0uqka1L2HbLq
 QK5l3E3Lv7VbOippAtr8gjHf3xPvMWSIxhNIfABvvXp9Yolw6RI8IfgM7rkCXSNqHd
 i1o1YItsxHso8spBQeIzSLu6aNkU9w9L6g1oV/xTU8YbJ4i6C02apH/Tpuh/gjM12h
 hNtVp9SbZwFbg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2625E1AA2D8;
 Tue, 12 May 2026 23:54:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 32F1A3ABC49;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 012/107] io: Fix TLS bye task leak
Date: Tue, 12 May 2026 23:52:59 +0300
Message-ID: <20260512205437.360850-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Fabiano Rosas <farosas@suse.de>

Recent fixes to TLS tasks memory handling have left the TLS bye task
uncovered. Fix by freeing the task in the same way the handshake task
is freed.

Direct leak of 704 byte(s) in 4 object(s) allocated from:
    #1 0x7f5909b1d6a0 in g_malloc0 ../glib/gmem.c:163
    #2 0x557650496d61 in qio_task_new ../io/task.c:58:12
    #3 0x557650475d7f in qio_channel_tls_bye ../io/channel-tls.c:352:12
    #4 0x55764f7a1bb4 in migration_tls_channel_end ../migration/tls.c:159:5
    #5 0x55764f709750 in migration_ioc_shutdown_gracefully ../migration/multifd.c:462:9
    #6 0x55764f6fcf53 in multifd_send_terminate_threads ../migration/multifd.c:493:13
    #7 0x55764f6fcafb in multifd_send_shutdown ../migration/multifd.c:580:5
    #8 0x55764f6e1b14 in migration_cleanup ../migration/migration.c:1323:9
    #9 0x55764f6f5bac in migration_cleanup_bh ../migration/migration.c:1350:5

Fixes: d39d0f3acd ("io: fix cleanup for TLS I/O source data on cancellation")
Fixes: 1b63062f57 ("io: fix cleanup for TLS I/O source data on cancellation") in 10.0.x series
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260311213418.16951-3-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit c20f143cc9fb9b1c79627d9f2ecb8daf771bdb4a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 329ef6759f..d25a55c107 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -347,7 +347,9 @@ void qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp)
     task = qio_task_new(OBJECT(ioc), propagate_error, errp, NULL);
 
     trace_qio_channel_tls_bye_start(ioc);
-    qio_channel_tls_bye_task(ioc, task, NULL);
+    if (qio_channel_tls_bye_task(ioc, task, NULL)) {
+        qio_task_free(task);
+    }
 }
 
 static void qio_channel_tls_init(Object *obj G_GNUC_UNUSED)
-- 
2.47.3


