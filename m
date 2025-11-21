Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEDCCFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd8P-000632-Hs; Fri, 21 Nov 2025 21:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd6K-0004EL-Lk; Fri, 21 Nov 2025 21:11:48 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd5i-0003u5-Sp; Fri, 21 Nov 2025 21:11:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F6BA16C703;
 Fri, 21 Nov 2025 16:51:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E8D093219A0;
 Fri, 21 Nov 2025 16:52:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 43/76] qemu-img: Fix amend option parse error handling
Date: Fri, 21 Nov 2025 16:51:21 +0300
Message-ID: <20251121135201.1114964-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

qemu_opts_del(opts) dereferences opts->list, which is the old amend_opts
pointer that can be dangling after executing
qemu_opts_append(amend_opts, bs->drv->create_opts) and cause
use-after-free.

Fix the potential use-after-free by moving the qemu_opts_del() call
before the qemu_opts_append() call.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20251023-iotests-v1-1-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit f00bcc833790c72c08bc5eed97845fdaa7542507)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-img.c b/qemu-img.c
index 7a162fdc08..63961e2b76 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4571,9 +4571,9 @@ static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
     amend_opts = qemu_opts_append(amend_opts, bs->drv->amend_opts);
     opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
     if (!qemu_opts_do_parse(opts, options, NULL, &err)) {
+        qemu_opts_del(opts);
         /* Try to parse options using the create options */
         amend_opts = qemu_opts_append(amend_opts, bs->drv->create_opts);
-        qemu_opts_del(opts);
         opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
         if (qemu_opts_do_parse(opts, options, NULL, NULL)) {
             error_append_hint(&err,
-- 
2.47.3


