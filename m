Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819D3CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoEP-0002yN-Im; Mon, 19 Oct 2026 10:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDK-0002EL-VJ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDI-0005Zq-3A
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPEiTnBf6Lo9R5WEcLDjkwxa7sUoRwT9PuweGjO5hJc=;
 b=D34Ma0DUgFUDi7G9AF9AAS/+smg2ZgTQZcH8Mm6wRHbYSjvnY+GljZ870ZiXOxYx+ndDdn
 0jNRbexlxQmM8gyNU9WnYMRogsZPpNsQw8kUfKxZOQAqzZ+VspIaxESk6C5bIZQ8TdEOId
 CLJ/sDT5MR08DeyThR634vf9d97yhSo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-U7M2qCUpMRSznKAqmS-hTQ-1; Mon,
 19 Oct 2026 14:19:39 +0000
X-MC-Unique: U7M2qCUpMRSznKAqmS-hTQ-1
X-Mimecast-MFC-AGG-ID: U7M2qCUpMRSznKAqmS-hTQ_1792419578
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7464C1954AD8; Mon, 19 Oct 2026 14:19:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC55730000E7; Mon, 19 Oct 2026 14:19:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B27AA21E6894; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 16/65] qom: add object_{class_}property_add_qapi
Date: Mon, 19 Oct 2026 16:18:40 +0200
Message-ID: <20261019141929.1594337-17-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h | 55 ++++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 32 ++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 28d3250de0..365d819d35 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2006,6 +2006,61 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **));
 
+/**
+ * object_property_add_qapi:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @qapi_type: QAPI type info descriptor
+ * @get: The getter to be called to read a property.  If this is NULL, then
+ *   the property cannot be read.
+ * @set: the setter to be called to write a property.  If this is NULL,
+ *   then the property cannot be written.
+ * @release: called when the property is removed from the object.  This is
+ *   meant to allow a property to free its opaque upon object
+ *   destruction.  This may be NULL.
+ * @opaque: an opaque pointer to pass to the callbacks for the property
+ *
+ * Add a property with a QAPI type association. The property type name
+ * is derived from @qapi_type->name.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_property_add_qapi(Object *obj, const char *name,
+                         const QAPITypeInfo *qapi_type,
+                         ObjectPropertyAccessor *get,
+                         ObjectPropertyAccessor *set,
+                         ObjectPropertyRelease *release,
+                         void *opaque);
+
+/**
+ * object_class_property_add_qapi:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @qapi_type: QAPI type info descriptor
+ * @get: The getter to be called to read a property.  If this is NULL, then
+ *   the property cannot be read.
+ * @set: the setter to be called to write a property.  If this is NULL,
+ *   then the property cannot be written.
+ * @release: called when the property is removed from the object.  This is
+ *   meant to allow a property to free its opaque upon object
+ *   destruction.  This may be NULL.
+ * @opaque: an opaque pointer to pass to the callbacks for the property
+ *
+ * Add a property with a QAPI type association. The property type name
+ * is derived from @qapi_type->name.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_class_property_add_qapi(ObjectClass *klass,
+                               const char *name,
+                               const QAPITypeInfo *qapi_type,
+                               ObjectPropertyAccessor *get,
+                               ObjectPropertyAccessor *set,
+                               ObjectPropertyRelease *release,
+                               void *opaque);
+
 /**
  * object_property_add_tm:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index 1d09315b32..bebbfc4355 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2609,6 +2609,38 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
                                      prop);
 }
 
+ObjectProperty *
+object_property_add_qapi(Object *obj, const char *name,
+                         const QAPITypeInfo *qapi_type,
+                         ObjectPropertyAccessor *get,
+                         ObjectPropertyAccessor *set,
+                         ObjectPropertyRelease *release,
+                         void *opaque)
+{
+    ObjectProperty *prop;
+
+    prop = object_property_add(obj, name, qapi_type->name,
+                               get, set, release, opaque);
+    prop->qapi_type = qapi_type;
+    return prop;
+}
+
+ObjectProperty *
+object_class_property_add_qapi(ObjectClass *klass, const char *name,
+                               const QAPITypeInfo *qapi_type,
+                               ObjectPropertyAccessor *get,
+                               ObjectPropertyAccessor *set,
+                               ObjectPropertyRelease *release,
+                               void *opaque)
+{
+    ObjectProperty *prop;
+
+    prop = object_class_property_add(klass, name, qapi_type->name,
+                                     get, set, release, opaque);
+    prop->qapi_type = qapi_type;
+    return prop;
+}
+
 typedef struct TMProperty {
     void (*get)(Object *, struct tm *, Error **);
 } TMProperty;
-- 
2.55.0


