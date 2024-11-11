Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E3BD3ABC1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 15:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAWmL-00049O-En; Mon, 11 Nov 2024 10:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tAWmA-00046a-S5
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 10:56:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tAWm9-0000p2-GJ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 10:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731340584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qy4AB4KWB8aPAdup6FoPis+5aWDt4zpvY7FvBbNVwLw=;
 b=DaR3410NE4Hjvy8fgMQwGqG9nUqLHD/WOyrjXbwNfo1bHwhkvKab3pv7pwbN4DXHzPhAEk
 QTBOXX9w+0UkfZ2UID2YotwRAmbAqqUq23RM/sOJ8yIo3qvm00/Ff/Dx8AeKTCdys+hMLP
 WGpw6JuIQlZqCqZXXuTiYuADrTl3qII=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-nmc7KcjONJa-W_ySzhlx_A-1; Mon,
 11 Nov 2024 10:56:23 -0500
X-MC-Unique: nmc7KcjONJa-W_ySzhlx_A-1
X-Mimecast-MFC-AGG-ID: nmc7KcjONJa-W_ySzhlx_A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C201195609F
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 15:56:21 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.238])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57A4019560A3; Mon, 11 Nov 2024 15:56:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 8/8] hw: enforce use of static, const string with qdev_new()
Date: Mon, 11 Nov 2024 15:55:55 +0000
Message-ID: <20241111155555.90091-9-berrange@redhat.com>
In-Reply-To: <20241111155555.90091-1-berrange@redhat.com>
References: <20241111155555.90091-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

Since qdev_new() will assert(), it should only be used in scenarios
where the caller knows exactly what type it is asking to be created,
and can thus be confident in avoiding abstract types.

Enforce this by using a macro wrapper which types to paste "" to the
type name. This will generate a compile error if not passed a static
const string, forcing callers to use qdev_new_dynamic() instead.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/qdev.c         |  6 ++++--
 include/hw/qdev-core.h | 24 ++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 10a7b87c3d..d561478437 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -144,7 +144,8 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
     return true;
 }
 
-DeviceState *qdev_new(const char *name)
+/* Only to be called via the 'qdev_new' macro */
+DeviceState *qdev_new_internal(const char *name)
 {
     return DEVICE(object_new_dynamic(name, &error_abort));
 }
@@ -154,7 +155,8 @@ DeviceState *qdev_new_dynamic(const char *name, Error **errp)
     return DEVICE(object_new_dynamic(name, errp));
 }
 
-DeviceState *qdev_try_new(const char *name)
+/* Only to be called via the 'qdev_try_new' macro */
+DeviceState *qdev_try_new_internal(const char *name)
 {
     ObjectClass *oc = module_object_class_by_name(name);
     if (!oc) {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 68ebaec058..6d9f6ba805 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -448,7 +448,17 @@ compat_props_add(GPtrArray *arr,
  *
  * Return: a derived DeviceState object with a reference count of 1.
  */
-DeviceState *qdev_new(const char *name);
+
+/*
+ * NB, qdev_new_internal is just an internal helper, wrapped by
+ * the qdev_new() macro which prevents invokation unless given
+ * a static, const string.
+ *
+ * Code should call qdev_new(), or qdev_new_dynamic(), not
+ * qdev_new_internal().
+ */
+DeviceState *qdev_new_internal(const char *name);
+#define qdev_new(name) qdev_new_internal(name "")
 
 /**
  * qdev_new_dynamic: Create a device on the heap
@@ -487,7 +497,17 @@ DeviceState *qdev_new_dynamic(const char *name, Error **errp);
  * Return: a derived DeviceState object with a reference count of 1 or
  * NULL if type @name does not exist.
  */
-DeviceState *qdev_try_new(const char *name);
+
+/*
+ * NB, qdev_try_new_internal is just an internal helper, wrapped by
+ * the qdev_try_new() macro which prevents invokation unless given
+ * a static, const string.
+ *
+ * Code should call qdev_try_new(), or qdev_try_new_dynamic(), not
+ * qdev_try_new_internal().
+ */
+DeviceState *qdev_try_new_internal(const char *name);
+#define qdev_try_new(name) qdev_try_new_internal(name "")
 
 /**
  * qdev_try_new_dynamic: Try to create a device on the heap
-- 
2.46.0


