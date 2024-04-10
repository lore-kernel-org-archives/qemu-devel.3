Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D327ECD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSIy-0007xD-Vu; Wed, 10 Apr 2024 03:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIv-0007lE-Eh; Wed, 10 Apr 2024 03:23:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIp-0003v8-VT; Wed, 10 Apr 2024 03:23:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0176C5D678;
 Wed, 10 Apr 2024 10:25:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9AF6AB02B9;
 Wed, 10 Apr 2024 10:23:04 +0300 (MSK)
Received: (nullmailer pid 4191671 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dmitrii Gavrilov <ds-gavr@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 09/87] system/qdev-monitor: move drain_call_rcu call
 under if (!dev) in qmp_device_add()
Date: Wed, 10 Apr 2024 10:21:42 +0300
Message-Id: <20240410072303.4191455-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>

Original goal of addition of drain_call_rcu to qmp_device_add was to cover
the failure case of qdev_device_add. It seems call of drain_call_rcu was
misplaced in 7bed89958bfbf40df what led to waiting for pending RCU callbacks
under happy path too. What led to overall performance degradation of
qmp_device_add.

In this patch call of drain_call_rcu moved under handling of failure of
qdev_device_add.

Signed-off-by: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
Message-ID: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
Fixes: 7bed89958bf ("device_core: use drain_call_rcu in in qmp_device_add", 2020-10-12)
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 012b170173bcaa14b9bc26209e0813311ac78489)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5..874d65191c 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -858,19 +858,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         return;
     }
     dev = qdev_device_add(opts, errp);
-
-    /*
-     * Drain all pending RCU callbacks. This is done because
-     * some bus related operations can delay a device removal
-     * (in this case this can happen if device is added and then
-     * removed due to a configuration error)
-     * to a RCU callback, but user might expect that this interface
-     * will finish its job completely once qmp command returns result
-     * to the user
-     */
-    drain_call_rcu();
-
     if (!dev) {
+        /*
+         * Drain all pending RCU callbacks. This is done because
+         * some bus related operations can delay a device removal
+         * (in this case this can happen if device is added and then
+         * removed due to a configuration error)
+         * to a RCU callback, but user might expect that this interface
+         * will finish its job completely once qmp command returns result
+         * to the user
+         */
+        drain_call_rcu();
+
         qemu_opts_del(opts);
         return;
     }
-- 
2.39.2


