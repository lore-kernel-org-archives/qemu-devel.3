Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFB3C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhkB-0003qP-4T; Wed, 21 May 2025 07:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhk7-0003ml-82
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhk2-00018P-Qb
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZpCLgvWatSfPeBcPKsV0twpfMUST5XFoEJrjxQz8ks=;
 b=doroJnRRg/BWirc4IWeFoABmd3aFrx0EIYyybgaxVMoWlqCtilK5e5A8THIePOwy/c1hQh
 RlBbU32JcQEBqr0yFSWMZUfpuXCJ4Nf0RN6qWvRkMdz/tbFJ6/Xhwes4Agw9IFsm5sz4Wb
 NPk9vjN38dzBypu6LNI/LZohefkI6Jw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-9cUalADxOlml1Pa-w_8PZQ-1; Wed,
 21 May 2025 07:36:06 -0400
X-MC-Unique: 9cUalADxOlml1Pa-w_8PZQ-1
X-Mimecast-MFC-AGG-ID: 9cUalADxOlml1Pa-w_8PZQ_1747827365
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5C661956088; Wed, 21 May 2025 11:36:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7218D19560B7; Wed, 21 May 2025 11:35:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH RFC 11/16] qdev-properties: add property for extended virtio
 features
Date: Wed, 21 May 2025 13:34:05 +0200
Message-ID: <a6e4033e5890afb43552e9e38645dcaf7b0dc86c.1747825544.git.pabeni@redhat.com>
In-Reply-To: <cover.1747825544.git.pabeni@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Virtio features extend above the 64 bit space, and GSO over
UDP tunnels support is going to use some bits in the extended
space.

Introduce a new Property type to handle the extended feature
defined in the previous patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/core/qdev-properties.c    | 46 ++++++++++++++++++++++++++++++++++++
 include/hw/qdev-properties.h | 13 ++++++++++
 2 files changed, 59 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 147b3ffd16..2a0182479c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -225,6 +225,52 @@ const PropertyInfo qdev_prop_bit64 = {
     .set_default_value = set_default_value_bool,
 };
 
+/* Bit virtio features __int128_t */
+#ifdef CONFIG_INT128
+static void vf_prop_set(Object *obj, const Property *props, bool val)
+{
+    __int128_t *vf = object_field_prop_ptr(obj, props);
+    assert(props->info == &qdev_prop_bitvf);
+    if (val) {
+        *vf |= (__int128_t)1 << props->bitnr;
+    } else {
+        *vf &= ~((__int128_t)1 << props->bitnr);
+    }
+}
+
+static void prop_get_bitvf(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    const Property *prop = opaque;
+    __int128_t *vf = object_field_prop_ptr(obj, prop);
+    bool value;
+
+    assert(prop->info == &qdev_prop_bitvf);
+    value = *vf & ((__int128_t)1 << prop->bitnr);
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void prop_set_bitvf(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    const Property *prop = opaque;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+    vf_prop_set(obj, prop, value);
+}
+
+const PropertyInfo qdev_prop_bitvf = {
+    .type  = "bool",
+    .description = "on/off",
+    .get   = prop_get_bitvf,
+    .set   = prop_set_bitvf,
+    .set_default_value = set_default_value_bool,
+};
+#endif
+
 /* --- bool --- */
 
 static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 2c99856caa..7760dd6dbd 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -100,6 +100,19 @@ extern const PropertyInfo qdev_prop_link;
                 .set_default = true,                              \
                 .defval.u  = (bool)_defval)
 
+#ifdef CONFIG_INT128
+extern const PropertyInfo qdev_prop_bitvf;
+
+#define DEFINE_PROP_BITVF(_name, _state, _field, _bit, _defval)   \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_bitvf,           \
+                 virtio_features_t,                               \
+                .bitnr    = (_bit),                               \
+                .set_default = true,                              \
+                .defval.u  = (bool)_defval)
+#else
+#define qdev_prop_bitvf qdev_prop_bit64
+#endif
+
 #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
     DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
                 .set_default = true,                         \
-- 
2.49.0


