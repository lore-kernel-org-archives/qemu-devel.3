Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CD0C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a3y-0007HP-Cv; Fri, 04 Sep 2026 15:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3w-00079s-Pr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3u-0007ty-QE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dTCAe13s+/qe8OyKDq4J7CbBf2JbhGMcn6OfTOaJdM=;
 b=O8C7iPSVlgWJcSnpbvdB+qcFpZPHpkMlBJqkWT2hxAHaZiUYz4z12nF/gAsBtdpvr8H462
 q670laGkGjRvSglq6bwkV44PxTwhlpPF21ccQjt7MbjGVlvcY44l5nhkvWe6Gz4a9nYFNB
 pYissZnTgvM3Kg+eZqga0dK9dpkCnxw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-ur6pQIHFNT-wolPatfKYPg-1; Fri,
 04 Sep 2026 15:58:52 -0400
X-MC-Unique: ur6pQIHFNT-wolPatfKYPg-1
X-Mimecast-MFC-AGG-ID: ur6pQIHFNT-wolPatfKYPg_1788551931
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96FCB18E9B3D; Fri,  4 Sep 2026 19:58:51 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98D8618005B5; Fri,  4 Sep 2026 19:58:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:57:55 +0400
Subject: [PATCH v4 12/75] qom: add object_{class_}property_add_qapi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-12-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4793;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=l0UXqFVCyU+WDYWA330MIVYIMH08NK/BziNQ4fJo2Po=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJyYARi9qxEeyuWL+8muVBkj+srFJqCs9Kq
 ZZkeVCaXryJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5eqPD/wKJexpYsH0eHwYMTnvmLDv4h+7hHovS176pmoTHtHwnwi7EPj49hyGYsDvZibtLbn/6tn
 iajuMNI+wKBbfJ7j3uculoVlwjECkw830AYnsGpd4xKm7XyKCrCQLq+1tMUj3eW+oWxautPLCRl
 cadWIbwMnYwD/Gdrl51pOuLO5EwzbErd5axJoFW/+P2ccaN08McZf3XiVYj/yYJfwpP53CgSE26
 rvAvVQcqLovFUxo+H9N8Ccp6nC4hf29Z2YbznD04ejTkZsEzQlrDel2FF3dXwKPgVBLLlijR4Ok
 O1vAwJVEgQd3+dFnbHNwWH2CqrxMqvu0lUOyP/XJkNbxX0+6hVtlVrGaZZjAPwUVmZonsD0PfNO
 +Y+1WhNwoIR0HUSRauGKB+7I+JCwnhI7TghPDU+s5A8c/cyLW3febn4JyCl7bnKaHCfmv4Q5Vrd
 /C8XGLtoC79/rngQevuwunkUKyS53isUGPYV/h+EuRBF+fq2m2bwQIsyzeoBUvZNHxYbhB7UBIA
 k23xTz0F4Vb90fFgifTvxnk5BSGd3FAvg/XNV6LkCC09V48KzYbE0t5gcigqOEvRyWfxHmHaQ36
 yzWm3XJ4NcFyYBnEqofPk6RWklJY6qg+OdK3K2DpokHcM61e4RhozZYRh1zWNlPOJSl6/lvTNiR
 MFjYN+G2FPgZYPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 32 ++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index c9a5ea4a1bf8..083fe646c390 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1993,6 +1993,61 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
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
index bf9664b53b78..7082bc1c0510 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2599,6 +2599,38 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
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
2.55.0.543.g5ebe2ebe4ea8


