Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5048E10D14B1
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Cdd-0005rU-Kd; Mon, 30 Mar 2026 09:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stepan.Popov@kaspersky.com>)
 id 1w7CFN-0008GJ-Aw; Mon, 30 Mar 2026 09:01:40 -0400
Received: from mx9.kaspersky-labs.com ([195.122.169.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stepan.Popov@kaspersky.com>)
 id 1w7CFL-0002H3-Fk; Mon, 30 Mar 2026 09:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1774875681;
 bh=z/RHKpSmPkqQxuqWYQaF/0vmieLwibbWTvsHIKsi/GE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=qJhTgkZZA3F9rVKyahnmRJ9/rS6yjWL5Tt0m4ZO14Gxf2kfvyj4eHOs+s+7YEwsMN
 aZak8k5zHvlY5izw3+juanAEGKYib+uc7wG6E0DFA0L2zTmjcF1A54rr3hwDvHJOFK
 QCj/7L8vXydjwBIC07X8OtPjUVN/Z7m36STiwGQPve0R5UOxiamE9CWmNIyIaUORMW
 msJseSdk1yuQMJZh3fnfDO4szh+u2/3H6j4/wqcomx5MZWIEe1DuoVu2E0WsanL2qO
 /+GGN5y3TYOkkg873FOlMQkJEHRM0xC05SEBtJGLiLoGNDmCS8tbsXIZ6blRYR4gBh
 p2xu73IrjC+vQ==
Received: from relay9.kaspersky-labs.com (localhost [127.0.0.1])
 by relay9.kaspersky-labs.com (Postfix) with ESMTP id B0D488A07DF;
 Mon, 30 Mar 2026 16:01:21 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub9.kaspersky-labs.com (Postfix) with ESMTPS id 85F4F8A32BB;
 Mon, 30 Mar 2026 16:01:21 +0300 (MSK)
Received: from stepan-vm.localdomain (10.16.90.37) by HQMAILSRV1.avp.ru
 (10.64.57.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 30 Mar
 2026 16:01:14 +0300
From: Stepan Popov <Stepan.Popov@kaspersky.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stepan
 Popov <Stepan.Popov@kaspersky.com>
Subject: [PATCH] thread-pool: signal condition variable while holding lock
Date: Mon, 30 Mar 2026 16:01:04 +0300
Message-ID: <20260330130104.85200-1-Stepan.Popov@kaspersky.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.16.90.37]
X-ClientProxiedBy: HQMAILSRV4.avp.ru (10.64.57.54) To HQMAILSRV1.avp.ru
 (10.64.57.51)
X-KSE-ServerInfo: HQMAILSRV1.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 03/30/2026 12:38:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 201777 [Mar 30 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: Stepan.Popov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 95 0.3.95
 0e4b6d4f1992c354ebd6a5cc3c5624a3b0aa8cbc
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kaspersky.com:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/30/2026 12:39:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/30/2026 12:28:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2026/03/30 05:24:00 #28352470
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
Received-SPF: pass client-ip=195.122.169.44;
 envelope-from=Stepan.Popov@kaspersky.com; helo=mx9.kaspersky-labs.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Mar 2026 09:26:41 -0400
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

Move qemu_cond_signal() inside the critical section protected by pool->lock.
Signaling while holding the lock imposes more predictable scheduling behavior.

Signed-off-by: Stepan Popov <Stepan.Popov@kaspersky.com>
---
 util/thread-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index 8f8cb38d5c..8e55aefd07 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -265,8 +265,8 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
         spawn_thread(pool);
     }
     QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
-    qemu_mutex_unlock(&pool->lock);
     qemu_cond_signal(&pool->request_cond);
+    qemu_mutex_unlock(&pool->lock);
     return &req->common;
 }
 
-- 
2.34.1


