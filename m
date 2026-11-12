Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630B606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GR/hSCFQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtc-0005lo-Pl; Thu, 12 Nov 2026 08:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtS-0005hC-KM
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtQ-0000xr-Rw
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5tqEPnDpval/zjsjFv7UUZTZpNNNmOXJzS8goVRL+Q=;
 b=GR/hSCFQXwbU096o2Nk2ccCALCbvyOQ5bZbNH4ADXiJV2vAs1iC+gSoKrqxgaXgH3So66C
 8GtMFu0XTKfvkkciCVb+cTUxn8prcU0mlq86bhnyN0pLGBIdEtlWJInIEVNEoLPQQlfobe
 a0Iws9rbj1iLaoE8dBO2qy9FQipqE+k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-kqI2eBHZMQqtH0Paass_Bw-1; Thu,
 12 Nov 2026 08:31:04 -0500
X-MC-Unique: kqI2eBHZMQqtH0Paass_Bw-1
X-Mimecast-MFC-AGG-ID: kqI2eBHZMQqtH0Paass_Bw_1794490263
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5956818C3DFE; Thu, 12 Nov 2026 13:31:03 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEE401956089; Thu, 12 Nov 2026 13:31:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/48] qom: define a TargetSpecific interface
Date: Thu, 12 Nov 2026 13:30:09 +0000
Message-ID: <20261112133054.1977618-4-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This can be used to declare a type as being target specific.

Implementing the interface just records the target metadata,
applying the enforcement requires the object creation path to
call 'target_specific_class_check()' to validate the system
state.

This approach is intended to allow classes to be unconditionally
registered, which allows introspection at any time. The target
specific enforcement is applied at runtime in the object
creation codepaths that need to apply restrictions. This implies
that QOM class names must be globally unique across all targets
known to QEMU.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object_interfaces.h | 75 +++++++++++++++++++++++++++++++++
 qom/object_interfaces.c         | 31 ++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index afd0fb93b2b..d222a3d7481 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -16,6 +16,17 @@ DECLARE_CLASS_CHECKERS(UserCreatableClass, USER_CREATABLE,
 
 typedef struct UserCreatable UserCreatable;
 
+#define TYPE_TARGET_SPECIFIC "target-specific"
+
+typedef struct TargetSpecificClass TargetSpecificClass;
+DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
+                       TYPE_TARGET_SPECIFIC)
+#define TARGET_SPECIFIC(obj) \
+     INTERFACE_CHECK(TargetSpecific, (obj), \
+                     TYPE_TARGET_SPECIFIC)
+
+typedef struct TargetSpecific TargetSpecific;
+
 /**
  * UserCreatableClass:
  * @parent_class: the base class
@@ -167,4 +178,68 @@ bool user_creatable_del(const char *id, Error **errp);
  */
 void user_creatable_cleanup(void);
 
+/**
+ * TargetSpecificClass:
+ * @parent_class: the base class
+ *
+ * Interface for classes that want to declare they have target
+ * specific restrictions. This is intended to allow classes to
+ * be registered and introspected unconditionally, while
+ * preventing creation of instances unless a compatible target
+ * is selected.
+ */
+struct TargetSpecificClass {
+    InterfaceClass parent_class;
+
+    /*
+     * Leave as 0 to indicate no target specific creation restrictions,
+     * or set to a bitmask of QEMU_ARCH_nnn constants to limit what
+     * targets it can be created under.
+     */
+    int targets;
+};
+
+
+/**
+ * target_specific_class_creatable:
+ * @oc: the object class to check
+ *
+ * Determine whether @oc implements the TargetSpecific
+ * interface and if so, whether its declared targets
+ * allow creation in the current system state.
+ *
+ * If @oc does not implement the TargetSpecific interface
+ * it is assumed there are no creation restrictions.
+ *
+ * If @oc implements the TargetSpecific interface but leaves
+ * the 'targets' field as zero, it is assumed there are
+ * no creation restrictions.
+ *
+ * If @oc implements the TargetSpecific interface and the
+ * 'targets' field is non-zero, it is compared to
+ * target_mask_selected() to determine if it is valid to
+ * create an instance of @oc.
+ *
+ * Returns: true if it is valid to create an instance of @oc
+ * in the current system state, false otherwise.
+ */
+bool target_specific_class_creatable(ObjectClass *oc);
+
+
+/**
+ * target_specific_class_check:
+ * @oc: the object class to check
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Check whether it is permitted to create an instance
+ * of @oc in the current system target state.
+ *
+ * This validates @oc against target_specific_class_creatable
+ * and sets @errp if it is not creatable.
+ *
+ * Returns: @oc if it is creatable, NULL otherwise with @errp set.
+ */
+ObjectClass *target_specific_class_check(ObjectClass *oc,
+                                         Error **errp);
+
 #endif
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index d83c12744b7..f523a55b93a 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -20,6 +20,7 @@
 #include "qapi/opts-visitor.h"
 #include "qemu/config-file.h"
 #include "qemu/keyval.h"
+#include "qemu/target-info.h"
 #include "trace.h"
 
 bool user_creatable_complete(UserCreatable *uc, Error **errp)
@@ -280,6 +281,30 @@ void user_creatable_cleanup(void)
     object_unparent(object_get_objects_root());
 }
 
+
+bool target_specific_class_creatable(ObjectClass *oc)
+{
+    TargetSpecificClass *tsc =
+        (TargetSpecificClass *)object_class_dynamic_cast(
+            oc, TYPE_TARGET_SPECIFIC);
+
+    return !tsc || !tsc->targets || (tsc->targets & target_mask_selected());
+}
+
+
+ObjectClass *target_specific_class_check(ObjectClass *oc,
+                                         Error **errp)
+{
+    if (!target_specific_class_creatable(oc)) {
+        error_setg(errp, "Object '%s' not compatible with selected target",
+                   object_class_get_name(oc));
+        return NULL;
+    }
+
+    return oc;
+}
+
+
 static void register_types(void)
 {
     static const TypeInfo uc_interface_info = {
@@ -287,8 +312,14 @@ static void register_types(void)
         .parent        = TYPE_INTERFACE,
         .class_size = sizeof(UserCreatableClass),
     };
+    static const TypeInfo ts_interface_info = {
+        .name          = TYPE_TARGET_SPECIFIC,
+        .parent        = TYPE_INTERFACE,
+        .class_size = sizeof(TargetSpecificClass),
+    };
 
     type_register_static(&uc_interface_info);
+    type_register_static(&ts_interface_info);
 }
 
 type_init(register_types)
-- 
2.56.1


