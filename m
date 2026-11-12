Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72E606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D+WGRgGP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUth-0005q2-Al; Thu, 12 Nov 2026 08:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtU-0005hP-J8
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtS-000173-TZ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+pIzL/WSrmMfTXw89n2ufJWD7L4b5O+pHiMvq4kaeQE=;
 b=D+WGRgGPcNqoYa9w51RUjQccKJ+pvpIpYdMu70UNjdVBNDSww/VabjfxYEWVQI2boG1+UR
 EndPIHf7bzQcs2rvFRzbmskXnE47cmBkpmtxM1LnUFX5tjyngvekxWSoU3XCNUBMORwTBF
 XAm3G1sRfc7M+9cVfShxtYP/D+T0PDw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-XztZ-TWTNlKgm0oQCY_bPA-1; Thu,
 12 Nov 2026 08:31:06 -0500
X-MC-Unique: XztZ-TWTNlKgm0oQCY_bPA-1
X-Mimecast-MFC-AGG-ID: XztZ-TWTNlKgm0oQCY_bPA_1794490265
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 535AF18974F7; Thu, 12 Nov 2026 13:31:05 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB05B195608A; Thu, 12 Nov 2026 13:31:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/48] qom: define an Aliased interface
Date: Thu, 12 Nov 2026 13:30:10 +0000
Message-ID: <20261112133054.1977618-5-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All QOM types must have a globally unique typename, however, for
user convenience, some might also want to have aliases which are
permitted to be ambiguous. Define an "Aliased" interface which
can be implemented by types which want to support aliases.

When resolving an alias, if there are multiple QOM types with a
matching alias this is considered an error. Ambiguity can be
resolved by matching system state, with the selected target
being the currently implemented filter.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object_interfaces.h | 77 +++++++++++++++++++++++++++++++++
 qom/object_interfaces.c         | 57 ++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index d222a3d7481..010e37d63f7 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -27,6 +27,17 @@ DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
 
 typedef struct TargetSpecific TargetSpecific;
 
+#define TYPE_ALIASED "aliased"
+
+typedef struct AliasedClass AliasedClass;
+DECLARE_CLASS_CHECKERS(AliasedClass, ALIASED,
+                       TYPE_ALIASED)
+#define ALIASED(obj) \
+     INTERFACE_CHECK(Aliased, (obj), \
+                     TYPE_ALIASED)
+
+typedef struct Aliased Aliased;
+
 /**
  * UserCreatableClass:
  * @parent_class: the base class
@@ -242,4 +253,70 @@ bool target_specific_class_creatable(ObjectClass *oc);
 ObjectClass *target_specific_class_check(ObjectClass *oc,
                                          Error **errp);
 
+/**
+ * AliasedClass
+ * @parent_class: the base class
+ *
+ * Interface for classes that want to declare they have aliases
+ * for their primary type name.
+ *
+ * While QOM type names are required to be unique, aliases allow
+ * for ambiguity across classes. The ambiguity is resolved at
+ * runtime based on system state, typically by the selection of
+ * a specific target. If ambiguity cannot be resolved, the user
+ * will need to use the unique QOM type name instead.
+ */
+struct AliasedClass {
+    InterfaceClass parent_class;
+
+    const char *const *aliases; /* NULL terminated list of typenames */
+};
+
+
+/**
+ * aliased_class_matches:
+ * @oc: the class object to check
+ * @typename: the possible type name alias to check
+ *
+ * Determine whether @oc implements the Aliased interface
+ * and has declared an alias that matches @typename.
+ *
+ * Returns: true if @oc implements Aliased and has an
+ * alias named @typename, false otherwise
+ */
+bool aliased_class_matches(ObjectClass *oc,
+                           const char *typename);
+
+
+/**
+ * aliased_class_resolve:
+ * @implements: a parent type to validate
+ * @typename: a type name to search for
+ * @errp: pointer to a NULL initialized error object
+ *
+ * Search all registered QOM types that implement
+ * both @implements and the Aliased interface for
+ * one that declares an alias @typename.
+ *
+ * If there is a single QOM class with a matching alias
+ * it will be returned.
+ *
+ * If there are multiple QOM classes with a matching
+ * alias an error will be raised about the ambiguous
+ * match.
+ *
+ * If the QOM class also implements the TargetSpecific
+ * interface and the current system target does not
+ * match the declared supported targets, aliases for
+ * that QOM class will be ignored. This is usually
+ * sufficient to resolve ambiguity between types.
+ *
+ * Returns: a unique QOM class with an alias @typename,
+ * or NULL if zero or multiple aliases match, with @errp
+ * set.
+ */
+ ObjectClass *aliased_class_resolve(const char *implements,
+                                    const char *typename,
+                                    Error **errp);
+
 #endif
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index f523a55b93a..136629f88b2 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -305,6 +305,57 @@ ObjectClass *target_specific_class_check(ObjectClass *oc,
 }
 
 
+bool aliased_class_matches(ObjectClass *oc, const char *typename)
+{
+    AliasedClass *alc =
+        (AliasedClass *)object_class_dynamic_cast(
+            oc, TYPE_ALIASED);
+
+    return alc && alc->aliases && g_strv_contains(alc->aliases, typename);
+}
+
+
+ObjectClass *aliased_class_resolve(const char *implements,
+                                   const char *typename,
+                                   Error **errp)
+{
+    g_autoptr(GSList) objs = object_class_get_list(implements, false);
+    GSList *el;
+    ObjectClass *ret = NULL;
+    g_autofree const char **matches = NULL;
+    size_t nmatches = 0;
+
+    for (el = objs; el; el = el->next) {
+        ObjectClass *oc = el->data;
+
+        if (aliased_class_matches(oc, typename) &&
+            target_specific_class_creatable(oc)) {
+            matches = g_renew(const char *, matches, nmatches + 2);
+            matches[nmatches] = object_class_get_name(oc);
+            matches[nmatches + 1] = NULL;
+
+            ret = oc;
+        }
+    }
+
+    if (nmatches > 1) {
+        g_autofree char *matchesstr = g_strjoinv(", ", (char **)matches);
+        error_setg(errp,
+                   "Object alias '%s' is not unique, matches %s",
+                   typename, matchesstr);
+        return NULL;
+    }
+
+    if (!ret) {
+        error_setg(errp, "Object '%s' not found, no child of '%s' registered",
+                   typename, implements);
+        return NULL;
+    }
+
+    return ret;
+}
+
+
 static void register_types(void)
 {
     static const TypeInfo uc_interface_info = {
@@ -317,9 +368,15 @@ static void register_types(void)
         .parent        = TYPE_INTERFACE,
         .class_size = sizeof(TargetSpecificClass),
     };
+    static const TypeInfo al_interface_info = {
+        .name          = TYPE_ALIASED,
+        .parent        = TYPE_INTERFACE,
+        .class_size = sizeof(AliasedClass),
+    };
 
     type_register_static(&uc_interface_info);
     type_register_static(&ts_interface_info);
+    type_register_static(&al_interface_info);
 }
 
 type_init(register_types)
-- 
2.56.1


