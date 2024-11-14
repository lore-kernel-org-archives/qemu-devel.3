Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D5AD68B3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBd9x-00009R-Vn; Thu, 14 Nov 2024 11:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBd9n-0008T3-TX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBd9m-0002c1-3W
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731603440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLF0n6qglRIqtUkQqyx7RdSXVKBg4tQ932ju2zdvhJU=;
 b=bR3qmOCYv5xGfYY027wZbRJCJbxaTU0Wum0zq1b6VLDh1D5IhH/rbeoJKb50APjnOgFfC9
 U8KOeoSAHU1Wq3BZ7zoBimx1MTXzS/8TcCEOdBuJtmBX0MZVmCzOlsT3P5wGrCNvwllJEH
 osycUlXDIH5Jq12i+Xp5y3mOzd0pXEE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-TbRcXxjuM52LUMlLjUmddg-1; Thu,
 14 Nov 2024 11:57:18 -0500
X-MC-Unique: TbRcXxjuM52LUMlLjUmddg-1
X-Mimecast-MFC-AGG-ID: TbRcXxjuM52LUMlLjUmddg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2601A1956083; Thu, 14 Nov 2024 16:57:17 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 866611955F21; Thu, 14 Nov 2024 16:57:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 7/8] qdev-monitor: avoid QemuOpts in QMP device_add
Date: Thu, 14 Nov 2024 17:56:56 +0100
Message-ID: <20241114165657.254256-8-kwolf@redhat.com>
In-Reply-To: <20241114165657.254256-1-kwolf@redhat.com>
References: <20241114165657.254256-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The QMP device_add monitor command converts the QDict arguments to
QemuOpts and then back again to QDict. This process only supports scalar
types. Device properties like virtio-blk-pci's iothread-vq-mapping (an
array of objects) are silently dropped by qemu_opts_from_qdict() during
the QemuOpts conversion even though QAPI is capable of validating them.
As a result, hotplugging virtio-blk-pci devices with the
iothread-vq-mapping property does not work as expected (the property is
ignored).

Get rid of the QemuOpts conversion in qmp_device_add() and call
qdev_device_add_from_qdict() with from_json=true. Using the QMP
command's QDict arguments directly allows non-scalar properties.

The HMP is also adjusted since qmp_device_add()'s now expects properly
typed JSON arguments and cannot be used from HMP anymore. Move the code
that was previously in qmp_device_add() (with QemuOpts conversion and
from_json=false) into hmp_device_add() so that its behavior is
unchanged.

This patch changes the behavior of QMP device_add but not HMP
device_add. QMP clients that sent incorrectly typed device_add QMP
commands no longer work. This is a breaking change but clients should be
using the correct types already. See the netdev_add QAPIfication in
commit db2a380c8457 for similar reasoning and object-add in commit
9151e59a8b6e. Unlike those commits, we continue to rely on 'gen': false
for the time being.

Markus helped me figure this out and even provided a draft patch. The
code ended up very close to what he suggested.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240827192751.948633-2-stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 system/qdev-monitor.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 4c09b38ffb..03ae610649 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -856,18 +856,9 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
 
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
 {
-    QemuOpts *opts;
     DeviceState *dev;
 
-    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, errp);
-    if (!opts) {
-        return;
-    }
-    if (!monitor_cur_is_qmp() && qdev_device_help(opts)) {
-        qemu_opts_del(opts);
-        return;
-    }
-    dev = qdev_device_add(opts, errp);
+    dev = qdev_device_add_from_qdict(qdict, true, errp);
     if (!dev) {
         /*
          * Drain all pending RCU callbacks. This is done because
@@ -879,9 +870,6 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
          * to the user
          */
         drain_call_rcu();
-
-        qemu_opts_del(opts);
-        return;
     }
     object_unref(OBJECT(dev));
 }
@@ -1018,8 +1006,34 @@ void qmp_device_sync_config(const char *id, Error **errp)
 void hmp_device_add(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
+    QemuOpts *opts;
+    DeviceState *dev;
 
-    qmp_device_add((QDict *)qdict, NULL, &err);
+    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &err);
+    if (!opts) {
+        goto out;
+    }
+    if (qdev_device_help(opts)) {
+        qemu_opts_del(opts);
+        return;
+    }
+    dev = qdev_device_add(opts, &err);
+    if (!dev) {
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
+        qemu_opts_del(opts);
+    }
+    object_unref(dev);
+out:
     hmp_handle_error(mon, err);
 }
 
-- 
2.47.0


