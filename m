Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390DED68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC052-0004P9-T5; Fri, 15 Nov 2024 12:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04p-0004D1-AY
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04n-0001XY-OW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n5te+I35ljUxz/CFLWZVSbhZ0wWO/u4MF+EMMpULpxA=;
 b=Et/xCu1ouLxtX74vHO8A2h0t/6Xpfcj7RTo/QVeII6OZoKklapL/mSAjDEOO5jdE9pChSu
 VZFMYh/HFCnGPWVUimxngl3YdzAqytphnCMS2CBYsT0qY6JtYDqI4jL2M28qN7oHpjgHwJ
 k8ZyrlNXwpJU5PmRQfbleMkNgh9agHc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-mKMbOOZFPGipbOp0Xbbq0w-1; Fri,
 15 Nov 2024 12:25:43 -0500
X-MC-Unique: mKMbOOZFPGipbOp0Xbbq0w-1
X-Mimecast-MFC-AGG-ID: mKMbOOZFPGipbOp0Xbbq0w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E5771955F25
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:25:43 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB3C83003B71; Fri, 15 Nov 2024 17:25:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 7/9] qom: introduce qdev_new_dynamic()
Date: Fri, 15 Nov 2024 17:25:19 +0000
Message-ID: <20241115172521.504102-8-berrange@redhat.com>
In-Reply-To: <20241115172521.504102-1-berrange@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qdev_new() has a failure scenario where it will assert() if given
an abstract type. Callers which are creating qdevs based on user
input, or unknown/untrusted type names, must manually check the
result of qdev_class_is_abstract() before calling qdev_new()
to propagate an Error, instead of asserting.

Introduce a qdev_new_dynamic() method which is a counterpart to
qdev_new() that directly returns an Error, instead of asserting.
This new method is to be used where the typename is specified
dynamically by code separate from the immediate caller.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/qdev.c         |  5 +++++
 include/hw/qdev-core.h | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 7fcbbe431b..eceba33222 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -149,6 +149,11 @@ DeviceState *qdev_new(const char *name)
     return DEVICE(object_new_dynamic(name, &error_abort));
 }
 
+DeviceState *qdev_new_dynamic(const char *name, Error **errp)
+{
+    return DEVICE(object_new_dynamic(name, errp));
+}
+
 static QTAILQ_HEAD(, DeviceListener) device_listeners
     = QTAILQ_HEAD_INITIALIZER(device_listeners);
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 020417d027..566c5ef277 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -435,14 +435,41 @@ compat_props_add(GPtrArray *arr,
  * qdev_new: Create a device on the heap
  * @name: device type to create (we assert() that this type exists)
  *
+ * This method should be used where @name is statically specified
+ * from a const string at build time, where the caller does not expect
+ * failure to be possible.
+ *
  * This only allocates the memory and initializes the device state
  * structure, ready for the caller to set properties if they wish.
  * The device still needs to be realized.
  *
+ * If an instance of @name is not permitted to be instantiated, an
+ * assert will be raised. This can happen if @name is abstract.
+ *
  * Return: a derived DeviceState object with a reference count of 1.
  */
 DeviceState *qdev_new(const char *name);
 
+/**
+ * qdev_new_dynamic: Create a device on the heap
+ * @name: device type to create (we assert() that this type exists)
+ * @errp: pointer to be filled with error details on failure
+ *
+ * This method must be used where @name is dynamically chosen
+ * at runtime, which has the possibility of unexpected choices leading
+ * to failures.
+ *
+ * This only allocates the memory and initializes the device state
+ * structure, ready for the caller to set properties if they wish.
+ * The device still needs to be realized.
+ *
+ * If an instance of @name is not permitted to be instantiated, an
+ * error will be reported. This can happen if @name is abstract.
+ *
+ * Return: a derived DeviceState object with a reference count of 1.
+ */
+DeviceState *qdev_new_dynamic(const char *name, Error **errp);
+
 /**
  * qdev_is_realized() - check if device is realized
  * @dev: The device to check.
-- 
2.46.0


