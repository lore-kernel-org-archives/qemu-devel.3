Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F27CCD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE7H-0004Et-RQ; Mon, 15 Jun 2026 16:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7G-000482-H3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7F-000313-1B
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iK6p34NeRCxzvFd3/PxdfEqrfFR+rupWElGG0xvLF+M=;
 b=RQ78+68nreHBizpA4WLyc6J+/VdqF47WqMPTyVRCLamFWtIY9L1U9PUmRKTITOnEjyix97
 5+0wYAb2WhhTI9BZIveOhy6sWQQlK8Juckg3e3aHMg+ejUSUMnF+3WuTtg0pTUG5Nkl4gG
 tcroJPdFr7ZsOpdmt08EnjoT4ITArTU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-c_2yxKOgOKKx18auCeWlPA-1; Mon,
 15 Jun 2026 16:41:00 -0400
X-MC-Unique: c_2yxKOgOKKx18auCeWlPA-1
X-Mimecast-MFC-AGG-ID: c_2yxKOgOKKx18auCeWlPA_1781556059
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECA351800350; Mon, 15 Jun 2026 20:40:58 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCC321800347; Mon, 15 Jun 2026 20:40:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:03 +0400
Subject: [PATCH v2 37/53] hw/nvdimm: convert UUID property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-37-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2291;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fjqQ6W0fz1f2OTCsCzNtLVDoI46ZtMBL144FqIZ8uxQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKPFLDMxrAkxtSWda8csDteRsEai2Gr6mM+0
 bn0BGHRQ/6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5VewD/0cfnXBQdr2gidDt2F1WRZZdT1YsbNayWFJK1NDAFYl8LxZvQs60M8TXdE4pRrPBmGxVKM
 axn1HCB9Ikyk8a8W/Tst2HoEiNmGuha0cpmkJtsWJ6Wva2vWRIatxPjPXDje72Nhu9xr1tFVYvx
 1bf6J/3NqyNWXD4IJVfmocH1QRFdkISjkXynfUTkb8V54+sV7RSqrSd+pMI1I2QG0Dcua/rkCwu
 mJlclqaUPpgXT+84ZCOdxeoIivH5TSdWLuBY6KphY35a74D44hdlGgaS1cYXmdIoyL3OgOo7+zo
 PLYOlTqnh7pbuUN8QyUDjMDryYL5rlBOp3V1Wp2m02JIqLZCVRm1tU8EuWgVWNvQrs8oe2Ag0lU
 /IZPdq5bXEODpK+7fwrEm+8mvtHgXCFw7drnkgRQ3IOadkgpaLB1ghVGE0XfTZ9lC2KIsyk4Egs
 7K123xXhpq6LEDq49SMO84zcTZQjQq1Mv7HnYS4CEeE0bwMEHx62hOQK05MJCOIqNG833ca55MO
 XO6xxDSdtUYwTK04vvB3jbA06P0+QQgmlQQHVjaC+L7S2ZL5Ex7a4+DaP2Ue4UJTjF1fhgBoxOy
 q3ywutEt+39OaVuQHtDZEqsW8yEMHiwHAn/2aXAQmkC3vu+YfSkGGG55NL9YjPItHq5JbOlqKbb
 EK6HSKx1H9tL2SQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add a QemuUUID_type_info and use object_property_add_qapi() instead of
object_property_add() for the nvdimm UUID property.

The type info is defined manually in uuid.c rather than generated,
since QAPI does not yet support string typedefs. An alternative would
be to extend the QAPI schema language with a 'typedef' construct
(e.g. { 'typedef': 'UUID', 'data': 'str' }), which would let the
generator produce the type info, C typedef, and introspection entry
automatically.

Alternatively, the exposed type being a string, we could change the
property to be str_type_info.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/uuid.h | 4 ++++
 hw/mem/nvdimm.c     | 4 ++--
 util/uuid.c         | 4 ++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 869f84af09d..ed0c62327d4 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -16,6 +16,8 @@
 #ifndef QEMU_UUID_H
 #define QEMU_UUID_H
 
+#include "qapi/qapi-type-info.h"
+
 
 /* Version 4 UUID (pseudo random numbers), RFC4122 4.4. */
 
@@ -99,4 +101,6 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid);
 
 uint32_t qemu_uuid_hash(const void *uuid);
 
+extern const QAPITypeInfo QemuUUID_type_info;
+
 #endif
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 123ddc93854..b7ccb5c9367 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -104,8 +104,8 @@ static void nvdimm_init(Object *obj)
                              nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                              NULL);
 
-    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
-                        nvdimm_set_uuid, NULL, NULL);
+    object_property_add_qapi(obj, NVDIMM_UUID_PROP, &QemuUUID_type_info,
+                             nvdimm_get_uuid, nvdimm_set_uuid, NULL, NULL);
 }
 
 static void nvdimm_finalize(Object *obj)
diff --git a/util/uuid.c b/util/uuid.c
index 234619dd5e6..4468520c414 100644
--- a/util/uuid.c
+++ b/util/uuid.c
@@ -17,6 +17,10 @@
 #include "qemu/uuid.h"
 #include "qemu/bswap.h"
 
+const QAPITypeInfo QemuUUID_type_info = {
+    .name = "QemuUUID",
+};
+
 void qemu_uuid_generate(QemuUUID *uuid)
 {
     int i;

-- 
2.54.0


