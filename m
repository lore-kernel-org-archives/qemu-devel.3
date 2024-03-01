Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E6EC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6Qd-0007AC-2Z; Fri, 01 Mar 2024 12:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg6QX-000765-VS; Fri, 01 Mar 2024 12:12:07 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg6QS-0003LF-KE; Fri, 01 Mar 2024 12:12:04 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:621c:0:640:f00b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 9074C60DA8;
 Fri,  1 Mar 2024 20:11:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jBfRBH2IW0U0-G9HZWP5W; Fri, 01 Mar 2024 20:11:57 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709313117;
 bh=pB6t/+jZASQ3ARswgKJ/gB6M/aZ+fsBI/3SbBB0gME8=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Hm4eYFY2TJSRfahoakQm1iWizoiq4l4JCtWxCQ/HCMN0ALKiUH824l0O8qwh9rA7q
 juPjBuIggeJ1AqOEnvVWPPKQPWxAywhQ0ft6kTcF/TXP/IQhUEIkeCZUp7dgj03n93
 Kk2vTpgAQWI44CYb7aQKPz/14iLal/PB9CIbpLO8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v2 3/6] qdev-monitor: add option to report GenericError from
 find_device_state
Date: Fri,  1 Mar 2024 20:11:40 +0300
Message-Id: <20240301171143.809835-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301171143.809835-1-vsementsov@yandex-team.ru>
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 system/qdev-monitor.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 9febb743f1..cf7481e416 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -877,13 +877,20 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     object_unref(OBJECT(dev));
 }
 
-static DeviceState *find_device_state(const char *id, Error **errp)
+/*
+ * Note that creating new APIs using error classes other than GenericError is
+ * not recommended. Set use_generic_error=true for new interfaces.
+ */
+static DeviceState *find_device_state(const char *id, bool use_generic_error,
+                                      Error **errp)
 {
     Object *obj = object_resolve_path_at(qdev_get_peripheral(), id);
     DeviceState *dev;
 
     if (!obj) {
-        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+        error_set(errp,
+                  (use_generic_error ?
+                   ERROR_CLASS_GENERIC_ERROR : ERROR_CLASS_DEVICE_NOT_FOUND),
                   "Device '%s' not found", id);
         return NULL;
     }
@@ -947,7 +954,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
 
 void qmp_device_del(const char *id, Error **errp)
 {
-    DeviceState *dev = find_device_state(id, errp);
+    DeviceState *dev = find_device_state(id, false, errp);
     if (dev != NULL) {
         if (dev->pending_deleted_event &&
             (dev->pending_deleted_expires_ms == 0 ||
@@ -1067,7 +1074,7 @@ BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
 
     GLOBAL_STATE_CODE();
 
-    dev = find_device_state(id, errp);
+    dev = find_device_state(id, false, errp);
     if (dev == NULL) {
         return NULL;
     }
-- 
2.34.1


