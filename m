Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E38C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWxM-0000OO-VM; Mon, 26 Feb 2024 04:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinglimin@cmss.chinamobile.com>)
 id 1reWxH-0000NZ-4t
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:07:23 -0500
Received: from cmccmta2.chinamobile.com ([111.22.67.135]
 helo=cmccmta1.chinamobile.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinglimin@cmss.chinamobile.com>) id 1reWxD-0003dC-AV
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:07:22 -0500
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee365dc54bd201-a59f3;
 Mon, 26 Feb 2024 17:07:10 +0800 (CST)
X-RM-TRANSID: 2ee365dc54bd201-a59f3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[10.54.5.252])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee565dc54bc312-7fa2f;
 Mon, 26 Feb 2024 17:07:10 +0800 (CST)
X-RM-TRANSID: 2ee565dc54bc312-7fa2f
From: dinglimin <dinglimin@cmss.chinamobile.com>
To: richard.henderson@linaro.org,
	philmd@linaro.org
Cc: qemu-devel@nongnu.org,
	dinglimin <dinglimin@cmss.chinamobile.com>
Subject: [PATCH] semihosting/uaccess.c: Replaced a malloc call with g_malloc
Date: Mon, 26 Feb 2024 17:06:28 +0800
Message-Id: <20240226090628.1986-1-dinglimin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=111.22.67.135;
 envelope-from=dinglimin@cmss.chinamobile.com; helo=cmccmta1.chinamobile.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
---
 semihosting/uaccess.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index dc587d73bc..7788ead9b2 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -14,10 +14,10 @@
 void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
                         target_ulong len, bool copy)
 {
-    void *p = malloc(len);
+    void *p = g_try_malloc(len);
     if (p && copy) {
         if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
-            free(p);
+            g_free(p);
             p = NULL;
         }
     }
@@ -87,5 +87,5 @@ void uaccess_unlock_user(CPUArchState *env, void *p,
     if (len) {
         cpu_memory_rw_debug(env_cpu(env), addr, p, len, 1);
     }
-    free(p);
+    g_free(p);
 }
-- 
2.30.0.windows.2




