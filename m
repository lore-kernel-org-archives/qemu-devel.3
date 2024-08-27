Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3EFC54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 19:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj1rH-00024G-4i; Tue, 27 Aug 2024 15:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sj1rF-0001yj-PM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sj1rD-0003AP-Uc
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724786878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNFfZdKGMbFRIUwMkcQdQCT89GTY2bf5HgQGgtPBBuA=;
 b=KkKLZz9qFBFJMFf/KeLKhrEnV00xFTilXROBIh06FSjThk1LcWNQSAX8UPG3q6foRBUY18
 W/g6R6YYUty/qiORu5UZRMl1TLP6tWr4X78sZfu/AufQMelLEnbC6sAZFiLEzHMNcfnxyK
 YDBggk76TOJg3X/uUijAh307zbZv4bk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-1ygq1TttMByEtwNMGoRJ1w-1; Tue,
 27 Aug 2024 15:27:57 -0400
X-MC-Unique: 1ygq1TttMByEtwNMGoRJ1w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B7F81955D57; Tue, 27 Aug 2024 19:27:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.119])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 210F31955D89; Tue, 27 Aug 2024 19:27:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, pkrempa@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 1/2] qdev-monitor: avoid QemuOpts in QMP device_add
Date: Tue, 27 Aug 2024 15:27:50 -0400
Message-ID: <20240827192751.948633-2-stefanha@redhat.com>
In-Reply-To: <20240827192751.948633-1-stefanha@redhat.com>
References: <20240827192751.948633-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 system/qdev-monitor.c | 44 ++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 6af6ef7d66..26404f314d 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -849,18 +849,9 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
 
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
@@ -872,11 +863,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
          * to the user
          */
         drain_call_rcu();
-
-        qemu_opts_del(opts);
-        return;
     }
-    object_unref(OBJECT(dev));
+    object_unref(dev);
 }
 
 static DeviceState *find_device_state(const char *id, Error **errp)
@@ -967,8 +955,34 @@ void qmp_device_del(const char *id, Error **errp)
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
2.46.0


