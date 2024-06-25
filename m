Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2DFC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM58m-0003Ii-RH; Tue, 25 Jun 2024 08:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM58g-0003Gx-Ic; Tue, 25 Jun 2024 08:19:10 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM58c-0006eE-Af; Tue, 25 Jun 2024 08:19:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id ECE0C6115E;
 Tue, 25 Jun 2024 15:19:00 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jIOnbJ0r9iE0-AcZRsO4j; Tue, 25 Jun 2024 15:19:00 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719317940;
 bh=y0ZY0HL89ZQM1woEITh6SpFjHxY5Et82QworM2Q3QcM=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Q24wLSGFL/BFbodf/yuk1elj6yk//urVGaLMQ9yygneRutdJ9eCdEr+FOzdSN+Ntx
 iVdhAdkvjP/gedWdQCczbsyOxn2c7Lp3960Z1UDXQrYZNauvSmdjiH/lre0EI/x3DG
 XpE7GkwcADFoGrsBtmyU8Lm/t0Hff4PwSvQcvb8I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
Subject: [PATCH v5 1/3] qdev-monitor: add option to report GenericError from
 find_device_state
Date: Tue, 25 Jun 2024 15:18:41 +0300
Message-Id: <20240625121843.120035-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121843.120035-1-vsementsov@yandex-team.ru>
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Here we just prepare for the following patch, making possible to report
GenericError as recommended.

This patch doesn't aim to prevent further use of DeviceNotFound by
future interfaces:

 - find_device_state() is used in blk_by_qdev_id() and qmp_get_blk()
   functions, which may lead to spread of DeviceNotFound anyway
 - also, nothing prevent simply copy-pasting find_device_state() calls
   with false argument

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 system/qdev-monitor.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 6af6ef7d66..264978aa40 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -879,13 +879,20 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
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
@@ -950,7 +957,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
 
 void qmp_device_del(const char *id, Error **errp)
 {
-    DeviceState *dev = find_device_state(id, errp);
+    DeviceState *dev = find_device_state(id, false, errp);
     if (dev != NULL) {
         if (dev->pending_deleted_event &&
             (dev->pending_deleted_expires_ms == 0 ||
@@ -1070,7 +1077,7 @@ BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
 
     GLOBAL_STATE_CODE();
 
-    dev = find_device_state(id, errp);
+    dev = find_device_state(id, false, errp);
     if (dev == NULL) {
         return NULL;
     }
-- 
2.34.1


