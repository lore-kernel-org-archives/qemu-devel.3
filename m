Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C67CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcxP-0002ZM-ML; Fri, 21 Nov 2025 21:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcAp-00072p-1k; Fri, 21 Nov 2025 20:12:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcAe-0004sN-7E; Fri, 21 Nov 2025 20:12:19 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A29A516CA67;
 Fri, 21 Nov 2025 21:44:25 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6204D321CA3;
 Fri, 21 Nov 2025 21:44:34 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 44/81] qemu-img: Fix amend option parse error handling
Date: Fri, 21 Nov 2025 21:43:43 +0300
Message-ID: <20251121184424.1137669-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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
index 2044c22a4c..d1d8242b02 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4369,9 +4369,9 @@ static int img_amend(int argc, char **argv)
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


