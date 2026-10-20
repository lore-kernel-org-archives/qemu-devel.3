Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A2606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZlEibq6a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7Pq-0005Y1-Da; Tue, 20 Oct 2026 06:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ7Nw-0002Ky-91
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ7Ns-0005Pj-RX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792493276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VkXUlwrEvWdaFT7ZgPzD9XegjPTV54S9i+Wt7fwK38w=;
 b=ZlEibq6aTI7BPMH1qQm0FIN3Z7FM0bwQwWriMv8Vth9D8C+N+LlYD5rqaWFwgpp2Pe97oy
 VlV0/oXFCwSLgkh+bLpQ3+3sAcZXs0j/HjKRNaKNg3wcqgFeavkihTagnD1XYfDXFg1hUq
 d4vwajA16Q904plDSTRPrUyn+H9RLO8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-ofM9Jc0cNLCC9EhH-k12SQ-1; Tue,
 20 Oct 2026 10:47:51 +0000
X-MC-Unique: ofM9Jc0cNLCC9EhH-k12SQ-1
X-Mimecast-MFC-AGG-ID: ofM9Jc0cNLCC9EhH-k12SQ_1792493267
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10F8B19560B6; Tue, 20 Oct 2026 10:47:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05BB51800444; Tue, 20 Oct 2026 10:47:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:34 +0400
Subject: [PATCH v7 17/65] qom: add object_{class_}property_add_qapi_enum
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-qom-qapi-v7-17-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7651;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6wd/SoQY2q+EMLwTd/AeIQErpXbBILREXSh6bn43Lqo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZZB/jExQFvbdi+wU3hKVxpaaPc1XbpmkIhP
 WMqxmJ0I1aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWQAKCRDa6OEJdZac
 5dBmD/9iljR90PsVPSEMouwGTqd5u0I3uFFVeGE6aj8If5dMfAJeES/9tbvs9mRjLcapLLGllYU
 TQNIPpVo9+5Q6yWoXDup+0bZugqArDJn+E+oR5GWaIn14K0W/lTsFVa1fdorL5FJzcZt9nLwPbs
 qBkK2X0Tow/JAOq9beFe0nqvt9e3h8csBkY2OzylCKV8xgUUa/N7/jUd9n3xMAaklrEguKhws7p
 RB2EmxgN94MyEQXZtZhqjVrWq/vsUKgCcwLJ7z6Xyu8ikQIh00qHstMPJONSLnW5X32860y2JUn
 RdI6UxJof0RAZu18Ge3d8Qgv+eKmoIfivMtXvHmI0YJtHLFqrI6rXfocRQLrZTDmpURYQ6U9u1U
 9yB9eLpPbMa9W1bghYaq4IAEJtvVsjv1kKDYGVAIPSlYH4dCgI/2TzssabsosxuEN1Phkx1epKW
 nBgKSEf8pt2cQsFq4SKILCVz/lUAkaZIcqrcLdVjN41qVK33dbV9SETzfNzbcypT0qn3Uvh31bB
 cekeBayXn2khLf+x2Dyym0EbRSJPRvIWIuFiabEG6a8kpeAZgLkNy8ux2Hrid+xaEV/Q2NlRSrc
 gxaEBZ3gRSWWWvkLE9xRhqAlVrj2m9egPJPQhy1zP1+3Zkc94/+TwXdjvCND2ByqbflBsfGVWJ7
 eokXUJapDD7zDZg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 74 ++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 90 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 159 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index eb61d8842b80..e04be4caed57 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2027,6 +2027,80 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **));
 
+/**
+ * struct QapiEnumProp: Descriptor for a property backed by a QAPI enum type
+ *
+ * Binds a QOM object property to a QAPI enum, providing automatic
+ * string<->int conversion through QAPI visitors and optional
+ * default-value initialization during object instance init.
+ *
+ * Use the QAPI_ENUM_PROP() macro to construct instances inline.
+ *
+ * @name: property name exposed on the QOM object
+ * @description: human-readable description (shown in ``-device help``, etc.)
+ * @default_value: initial enum value applied via @set during instance init,
+ *                 or -1 (the QAPI_ENUM_PROP default) to skip initialization
+ * @qapi_type: pointer to the generated QAPITypeInfo for the enum
+ *             (provides the string<->int lookup table)
+ * @get: getter that returns the current enum value as int, or -1 on error
+ * @set: setter that receives the enum value as int; %NULL for read-only props
+ */
+typedef struct QapiEnumProp {
+    const char *name;
+    const char *description;
+    const int default_value;
+    const QAPITypeInfo *qapi_type;
+    int (*get)(Object *, Error **);
+    void (*set)(Object *, int, Error **);
+} QapiEnumProp;
+
+#define QAPI_ENUM_PROP(...) ({                                           \
+    static const QapiEnumProp _prop = {                                  \
+        .default_value = -1, __VA_ARGS__                                 \
+    };                                                                   \
+    &_prop; })
+
+/**
+ * object_property_add_qapi_enum:
+ * @obj: the object to add a property to
+ * @prop: property descriptor
+ *
+ * Add an enum property with QAPI type association.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
+
+/**
+ * object_class_property_add_qapi_enum:
+ * @klass: the class object to add a property to
+ * @prop: property descriptor
+ *
+ * Add an enum property with QAPI type association.
+ *
+ * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
+ * inline. If .default_value is not set, the property is not initialized
+ * (default_value is -1). Otherwise, the setter is called with
+ * default_value during object instance init.
+ *
+ * Example::
+ *
+ *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+ *       .name = "policy",
+ *       .description = "Set the NUMA policy",
+ *       .default_value = HOST_MEM_POLICY_DEFAULT,
+ *       .qapi_type = &HostMemPolicy_type_info,
+ *       .get = my_get_policy,
+ *       .set = my_set_policy,
+ *   ));
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_class_property_add_qapi_enum(ObjectClass *klass,
+                                    const QapiEnumProp *prop);
+
 /**
  * object_property_add_qapi:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index bebbfc43556d..cc113c0810e7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1219,7 +1219,7 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
         return;
     }
 
-    if (data->implements_type && 
+    if (data->implements_type &&
         !object_class_dynamic_cast(k, data->implements_type)) {
         return;
     }
@@ -1786,7 +1786,6 @@ int object_property_get_enum(Object *obj, const char *name,
     char *str;
     int ret;
     ObjectProperty *prop = object_property_find_err(obj, name, errp);
-    EnumProperty *enumprop;
 
     if (prop == NULL) {
         return -1;
@@ -1799,14 +1798,17 @@ int object_property_get_enum(Object *obj, const char *name,
         return -1;
     }
 
-    enumprop = prop->opaque;
-
     str = object_property_get_str(obj, name, errp);
     if (!str) {
         return -1;
     }
 
-    ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
+    if (prop->qapi_type) {
+        ret = qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp);
+    } else {
+        EnumProperty *enumprop = prop->opaque;
+        ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
+    }
     g_free(str);
 
     return ret;
@@ -2609,6 +2611,84 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
                                      prop);
 }
 
+static void get_qapi_enum(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    const QapiEnumProp *prop = opaque;
+    int value;
+    Error *err = NULL;
+
+    value = prop->get(obj, &err);
+    assert(value >= 0 || err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp);
+}
+
+static void set_qapi_enum(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    const QapiEnumProp *prop = opaque;
+    int value;
+
+    if (!visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp)) {
+        return;
+    }
+    prop->set(obj, value, errp);
+}
+
+static void init_qapi_enum(Object *obj, ObjectProperty *prop)
+{
+    const QapiEnumProp *e = prop->opaque;
+
+    if (e->set && e->default_value >= 0) {
+        e->set(obj, e->default_value, &error_abort);
+    }
+}
+
+ObjectProperty *
+object_property_add_qapi_enum(Object *obj, const QapiEnumProp *e)
+{
+    ObjectProperty *prop;
+
+    assert(e && e->qapi_type && e->qapi_type->lookup);
+
+    prop = object_property_add_qapi(obj, e->name, e->qapi_type,
+                                    e->get ? get_qapi_enum : NULL,
+                                    e->set ? set_qapi_enum : NULL,
+                                    NULL,
+                                    (void *)e);
+    prop->description = g_strdup(e->description);
+    if (e->default_value >= 0) {
+        prop->init = init_qapi_enum;
+    }
+
+    return prop;
+}
+
+ObjectProperty *
+object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnumProp *e)
+{
+    ObjectProperty *prop;
+
+    assert(e && e->qapi_type && e->qapi_type->lookup);
+
+    prop = object_class_property_add_qapi(klass, e->name, e->qapi_type,
+                                          e->get ? get_qapi_enum : NULL,
+                                          e->set ? set_qapi_enum : NULL,
+                                          NULL,
+                                          (void *)e);
+    prop->description = g_strdup(e->description);
+    if (e->default_value >= 0) {
+        prop->init = init_qapi_enum;
+    }
+
+    return prop;
+}
+
 ObjectProperty *
 object_property_add_qapi(Object *obj, const char *name,
                          const QAPITypeInfo *qapi_type,

-- 
2.56.0.116.g6de20f6092dc


