Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35972CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smROv-0007By-P4; Fri, 06 Sep 2024 01:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smROS-0004is-QD; Fri, 06 Sep 2024 01:20:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smROB-0008Na-Rd; Fri, 06 Sep 2024 01:20:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8FD0E8C13B;
 Fri,  6 Sep 2024 08:15:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3DA2F133380;
 Fri,  6 Sep 2024 08:16:36 +0300 (MSK)
Received: (nullmailer pid 10501 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Claudio Fontana <cfontana@suse.de>, "Denis V . Lunev" <den@openvz.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 38/40] module: Prevent crash by resetting local_err in
 module_load_qom_all()
Date: Fri,  6 Sep 2024 08:16:26 +0300
Message-Id: <20240906051633.10288-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

Set local_err to NULL after it has been freed in error_report_err(). This
avoids triggering assert(*errp == NULL) failure in error_setv() when
local_err is reused in the loop.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Link: https://lore.kernel.org/r/20240809121340.992049-2-alexander.ivanov@virtuozzo.com
[Do the same by moving the declaration instead. - Paolo]
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 940d802b24e63650e0eacad3714e2ce171cba17c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/module.c b/util/module.c
index 32e263163c..3eb0f06df1 100644
--- a/util/module.c
+++ b/util/module.c
@@ -354,13 +354,13 @@ int module_load_qom(const char *type, Error **errp)
 void module_load_qom_all(void)
 {
     const QemuModinfo *modinfo;
-    Error *local_err = NULL;
 
     if (module_loaded_qom_all) {
         return;
     }
 
     for (modinfo = module_info; modinfo->name != NULL; modinfo++) {
+        Error *local_err = NULL;
         if (!modinfo->objs) {
             continue;
         }
-- 
2.39.2


