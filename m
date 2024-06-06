Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB3DC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFE8N-0000zm-J1; Thu, 06 Jun 2024 10:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sFE8G-0000nw-I3
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sFE8E-0000dm-Vi
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717684222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDPgf6aEIIwBxTyK1XZbu26GI1zbXPnF25d6ETE9IBk=;
 b=Ndb2p4h+I3ufqR0cVXu2e4j6kZ17x96tc1+IW75RxV25gNcNHKAwq+sFC7R7pPuy7JJ2MP
 cN3cNeg0ccJTLsbOp8lXHIkjzd8hBkmev0BV/zaxJzZzSJIMcVFQ08oEsibVIltv5XiLYR
 vLQ+l/NISumL4T0XqLy4ilLGY99GABY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-cdMmpptCM0Ojy8tAlhO9ZA-1; Thu, 06 Jun 2024 10:30:16 -0400
X-MC-Unique: cdMmpptCM0Ojy8tAlhO9ZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACB1B800074;
 Thu,  6 Jun 2024 14:30:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49AF8492C27;
 Thu,  6 Jun 2024 14:30:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1BA801800D65; Thu,  6 Jun 2024 16:30:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 4/4] qdev: add device policy [RfC]
Date: Thu,  6 Jun 2024 16:30:10 +0200
Message-ID: <20240606143010.1318226-5-kraxel@redhat.com>
In-Reply-To: <20240606143010.1318226-1-kraxel@redhat.com>
References: <20240606143010.1318226-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add policies for devices which are deprecated or not secure.
There are three options: allow, warn and deny.

It's implemented for devices only.  Devices will probably be the main
user of this.  Also object_new() can't fail as of today so it's a bit
hard to implement policy checking at object level, especially the 'deny'
part of it.

TODO: add a command line option to actually set these policies.

Comments are welcome.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/core/qdev.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f3a996f57dee..0c4e5cec743c 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -43,6 +43,15 @@
 static bool qdev_hot_added = false;
 bool qdev_hot_removed = false;
 
+enum qdev_policy {
+    QDEV_ALLOW = 0,
+    QDEV_WARN  = 1,
+    QDEV_DENY  = 2,
+};
+
+static enum qdev_policy qdev_deprecated_policy;
+static enum qdev_policy qdev_not_secure_policy;
+
 const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
 {
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
@@ -144,6 +153,43 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
     return true;
 }
 
+static bool qdev_class_check(const char *name, ObjectClass *oc)
+{
+    bool allow = true;
+
+    if (oc->deprecated) {
+        switch (qdev_deprecated_policy) {
+        case QDEV_WARN:
+            warn_report("device \"%s\" is deprecated", name);
+            break;
+        case QDEV_DENY:
+            error_report("device \"%s\" is deprecated", name);
+            allow = false;
+            break;
+        default:
+            /* nothing */
+            break;
+        }
+    }
+
+    if (oc->not_secure) {
+        switch (qdev_not_secure_policy) {
+        case QDEV_WARN:
+            warn_report("device \"%s\" is not secure", name);
+            break;
+        case QDEV_DENY:
+            error_report("device \"%s\" is not secure", name);
+            allow = false;
+            break;
+        default:
+            /* nothing */
+            break;
+        }
+    }
+
+    return allow;
+}
+
 DeviceState *qdev_new(const char *name)
 {
     ObjectClass *oc = object_class_by_name(name);
@@ -162,14 +208,26 @@ DeviceState *qdev_new(const char *name)
         error_report("unknown type '%s'", name);
         abort();
     }
+
+    if (!qdev_class_check(name, oc)) {
+        exit(1);
+    }
+
     return DEVICE(object_new(name));
 }
 
 DeviceState *qdev_try_new(const char *name)
 {
-    if (!module_object_class_by_name(name)) {
+    ObjectClass *oc = module_object_class_by_name(name);
+
+    if (!oc) {
         return NULL;
     }
+
+    if (!qdev_class_check(name, oc)) {
+        return NULL;
+    }
+
     return DEVICE(object_new(name));
 }
 
-- 
2.45.2


