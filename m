Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848CEC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHmK-0006Kx-Rg; Tue, 18 Aug 2026 07:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHmJ-0006Kh-6b
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHmH-00054I-Me
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBJ7ecg3IKoBQz7Cp0OVJ2rCmSSayPdHFEZlTN1fmvs=;
 b=EkOfeQvG7wq9mjVoKWpR2+X537uJn6u+B3adV3wJoTMGx/hfMGCYmHnIpwbXweh8kGrBnd
 kTeasO0UX5HLLEJ1Rz6fSnQgM88pwoXAWYMmjN7BkOCszSINyTKDHxjDiWWIeW+417oALr
 W7w1hLuv8nWMv9XwrcsIoaNMxRRh3Pw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-Uq0nRu67PiC7pOmBnccIkg-1; Tue,
 18 Aug 2026 07:14:40 -0400
X-MC-Unique: Uq0nRu67PiC7pOmBnccIkg-1
X-Mimecast-MFC-AGG-ID: Uq0nRu67PiC7pOmBnccIkg_1787051679
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8848C18001E3; Tue, 18 Aug 2026 11:14:39 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D803A195608A; Tue, 18 Aug 2026 11:14:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:38 +0400
Subject: [PATCH v3 11/74] qom: add object_{class_}property_add_qapi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-11-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3919;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gii/hC7btqS6U6ZmKFMo/0UoglBZKcLAMcXlmfdep8Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD232X0xMZD0j3JIkrA12U+qzLfqKWrwDVLiE
 xmwVXVbxCOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9twAKCRDa6OEJdZac
 5SX0D/0TE/HvnOhW5iVwhncH32vWZc3tR5HghZHNNIGDaLWcI8Vg3tMxp7+R/3CTE89UzwBKB5W
 2Osjq9JUNM3VJMdDsJa5MyXUHJwssaaBEeWsZgWHycHBj5Vup1rAvlRmC+a1CMWdn5hOgizDeNs
 Rp5AyB/hLAYKC/5a2PUqdzKmBZGE/on4Krycr+5bkVY+HRVArHQHNcFxfqZP+HJubEZULuBDqfx
 9jR9TkXYCmUbnqLLvgvYQElHfTJPpbzE/PoR7VxElgmHZ16AUqv6JANsu7YpAvxR8hpdIINYzwZ
 neFiVlnv1uTZbhLx6ZHLOg7Q053qvZ3YWuKGHHf2mWmkHfVuVL5A/zZ83SqwWIEJcfVNYfMbD60
 q5QZmx6xUw/kRRF4K/7D3ynInKZOKapt0CH2nQb497sSdRnwfwdLKQkmy040ohyq0JfHIPGnpjC
 41FDE3FUI3BkKCf79UTSWgzC6rd1k0IqJ5w/h7k0IC+gZRruDmb+Hr58D3yXH3NQJmeVmBR2X3C
 k/H1z6Q4oAIvHnPgZ5XMnkBFkB1715itB6KFLmh93xPPNNqVrqCcQKdbjOG/owdnQrZwflS46fO
 6WVY0xW+Od1DTLgrN1+58tlctkEbNE4/9n9X2vuZoyiy3cjl9Ei5jvpu04U+xUUpWwLXUJkANUi
 4P+Kc8TScPtAcsQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 include/qom/object.h | 36 ++++++++++++++++++++++++++++++++++++
 qom/object.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 271d736956da..9684db935d23 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1990,6 +1990,42 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
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
index 93d44a9444ca..1bfb6b933339 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2595,6 +2595,38 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
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


