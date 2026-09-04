Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EC8C79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a6O-000097-31; Fri, 04 Sep 2026 16:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6M-0008Oy-Mo
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6K-0008Rf-U7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q1pBm4JIf/lwRiA1/QfhUtOlQUt1nuvI50NpLc2soGA=;
 b=ag7TFVxQ6Yh1abS8ax3f6hHG150VMmS+cO1Ur1ZC6PpZeo+E8fpqlAgpsiw3XjQwt7z3NO
 iDt/DBxpHchoAMk24tww/UaliYg01hNsSStMOpV/lly6pr0EWn10LgadVc8Oef1X0QIVY0
 QUjV1E8pUaacBsGdZrKlYaNzckvGZXg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-r_jXkbDxNPC5eeRW5uq-0g-1; Fri,
 04 Sep 2026 16:01:25 -0400
X-MC-Unique: r_jXkbDxNPC5eeRW5uq-0g-1
X-Mimecast-MFC-AGG-ID: r_jXkbDxNPC5eeRW5uq-0g_1788552083
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A9CA18E9B26; Fri,  4 Sep 2026 20:01:23 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70EF31800577; Fri,  4 Sep 2026 20:01:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:35 +0400
Subject: [PATCH v4 52/75] hw/nvdimm: convert UUID property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-52-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Fam Zheng <fam@euphon.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2344;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wdkmnzVqdE+H1nVJim++EcOuJVmDwXZEbt7GE3F4KZ8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLL03CKTYxsuAK0h/HSidhe8MDFTeCdHgYCc
 qvOgyeQIsOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiywAKCRDa6OEJdZac
 5YpoD/0RPrWL1zvoD+BDhUfnAHQFUUoBa61vtO+iq/S+Nz/WHWKoyqdH5oWF4NccmVVPJ9soAfH
 qyh1h052BbVss5Whkh2VTmOfwRnRhxB9DCVn3Nyx4aWbbSo+S1M+wMsuWKwYl46OETo6U9a3p6u
 ZnC45IufzWzNJ+7cgIp9h4rRxGeQ1//lJKeab/QKY23Q80YU3WOE/VaJeDyHILV4i/eFKFNT8E1
 IKSOEBH9WQDHhpLvLForADdkT+0TJU6WpVarls83JZ3Bw7F/3vGRZN5BMqt3roGKYiXK85yVnbN
 CyKJVDh+NtfBQUDgCqV+hfBv73tTfXT5cJZN4xkmdVeGW+RHOfUNmllLi+QdTImKtH3ow6giDbr
 2ZoPJXf//Kryr6gpulaYOU9aemdrkoAVJ+UYynGfUxcdnPIeaLTqMryxkI1gtWcj+Gv23eUBdTf
 UJxk0GHOFpU0xEqTDGdH8Aptmzs9RoOUZ+IGdDSrY77fGcJoEg5uFP2dbrvC2FTCrjC9IMzol0f
 h3gKnTTUNBtgmFyzWB6hlSO2o/BlS0hsUWf3M+4LVB8sqiHL2GAdPVOS6bP1SP/oiyBAlOJu28V
 /kIE+1shvNJ4szo/sYZjcNWXDAYNsaqnWlCAwLy2K3c5Q0KGLcRAx6sOOFIcmQOL5RinFOSpydx
 oVBOvjxPoytDiSw==
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
 hw/mem/nvdimm.c     | 4 ++--
 include/qemu/uuid.h | 4 ++++
 util/uuid.c         | 5 +++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 123ddc938546..b7ccb5c93678 100644
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
diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 869f84af09dd..ed0c62327d4d 100644
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
diff --git a/util/uuid.c b/util/uuid.c
index 234619dd5e69..363a03051aba 100644
--- a/util/uuid.c
+++ b/util/uuid.c
@@ -17,6 +17,11 @@
 #include "qemu/uuid.h"
 #include "qemu/bswap.h"
 
+const QAPITypeInfo QemuUUID_type_info = {
+    .name = "QemuUUID",
+    .masked_name = "str",
+};
+
 void qemu_uuid_generate(QemuUUID *uuid)
 {
     int i;

-- 
2.55.0.543.g5ebe2ebe4ea8


