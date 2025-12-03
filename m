Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140B2D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhoC-0003Lh-4G; Wed, 03 Dec 2025 03:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQho8-0002zC-Pz; Wed, 03 Dec 2025 03:01:52 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQho5-00076T-Bg; Wed, 03 Dec 2025 03:01:52 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E6EB5170779;
 Wed, 03 Dec 2025 10:59:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B420032B4A0;
 Wed, 03 Dec 2025 10:59:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "AlanoSong@163.com" <AlanoSong@163.com>,
 =?UTF-8?q?Marc-Andr=C3=A9Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 108/116] ui/vnc: Fix qemu abort when query vnc info
Date: Wed,  3 Dec 2025 10:59:28 +0300
Message-ID: <20251203075939.2366131-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: "AlanoSong@163.com" <AlanoSong@163.com>

When there is no display device on qemu machine,
and user only access qemu by remote vnc.
At the same time user input `info vnc` by QMP,
the qemu will abort.

To avoid the abort above, I add display device check,
when query vnc info in qmp_query_vnc_servers().

Reviewed-by: Marc-AndréLureau <marcandre.lureau@redhat.com>
Signed-off-by: Alano Song <AlanoSong@163.com>
[ Marc-André - removed useless Error *err ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20251125131955.7024-1-AlanoSong@163.com>
(cherry picked from commit 4c1646e23f761e3dc6d88c8995f13be8f668a012)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index 6a26f05daa..ff683ba196 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -562,9 +562,12 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
         qmp_query_auth(vd->auth, vd->subauth, &info->auth,
                        &info->vencrypt, &info->has_vencrypt);
         if (vd->dcl.con) {
-            dev = DEVICE(object_property_get_link(OBJECT(vd->dcl.con),
-                                                  "device", &error_abort));
-            info->display = g_strdup(dev->id);
+            Object *obj = object_property_get_link(OBJECT(vd->dcl.con),
+                                                   "device", NULL);
+            if (obj) {
+                dev = DEVICE(obj);
+                info->display = g_strdup(dev->id);
+            }
         }
         for (i = 0; vd->listener != NULL && i < vd->listener->nsioc; i++) {
             info->server = qmp_query_server_entry(
-- 
2.47.3


