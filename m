Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E320C678DC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 09:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sraI1-0007bg-VO; Fri, 20 Sep 2024 05:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sraHx-0007OF-1q; Fri, 20 Sep 2024 05:50:57 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sraHr-0000w2-Bz; Fri, 20 Sep 2024 05:50:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a13:0:640:f32:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4948F60A82;
 Fri, 20 Sep 2024 12:50:46 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b599::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LoLjH00IlKo0-RisFyUE2; Fri, 20 Sep 2024 12:50:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1726825845;
 bh=AmZ43T8iNI/ABaXS7mCZR9psl2c/9HCptRm4qNA6b3A=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XrAQwcd4PO7gBj/CsrncrymI0rHozl63uT8LX6fGtjdwmF1sDZH8J4SHhaR7oKNYz
 m1ms1ZoFKm7N0Fm6RvxAo30W3vGCDutOoQ6sU98EWesB18Di2t7HNZhXVFzWenLgo9
 VHrfKH+pd0wgBiVWH5hoqUAYZTUBSftrVJWRWKK8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: sgarzare@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH v6 1/3] qdev-monitor: add option to report GenericError from
 find_device_state
Date: Fri, 20 Sep 2024 12:49:34 +0300
Message-Id: <20240920094936.450987-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240920094936.450987-1-vsementsov@yandex-team.ru>
References: <20240920094936.450987-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Here we just prepare for the following patch, making possible to report
GenericError as recommended.

This patch doesn't aim to prevent further use of DeviceNotFound by
future interfaces:

 - find_device_state() is used in blk_by_qdev_id() and qmp_get_blk()
   functions, which may lead to spread of DeviceNotFound anyway
 - also, nothing prevent simply copy-pasting find_device_state() calls
   with false argument

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Raphael Norwitz <raphael@enfabrica.net>
---
 system/qdev-monitor.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 44994ea0e1..6671137a91 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -885,13 +885,20 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
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
@@ -956,7 +963,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
 
 void qmp_device_del(const char *id, Error **errp)
 {
-    DeviceState *dev = find_device_state(id, errp);
+    DeviceState *dev = find_device_state(id, false, errp);
     if (dev != NULL) {
         if (dev->pending_deleted_event &&
             (dev->pending_deleted_expires_ms == 0 ||
@@ -1076,7 +1083,7 @@ BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
 
     GLOBAL_STATE_CODE();
 
-    dev = find_device_state(id, errp);
+    dev = find_device_state(id, false, errp);
     if (dev == NULL) {
         return NULL;
     }
-- 
2.34.1


