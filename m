Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C388C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54IM-0005gE-W9; Fri, 11 Sep 2026 12:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54IJ-0005UU-Nm
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54II-00071F-1f
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q1pBm4JIf/lwRiA1/QfhUtOlQUt1nuvI50NpLc2soGA=;
 b=Wol0klMPH754k/mxKGyM0D7ct/RVrPtWTNG16KUlfGyGHWN3tJxRTfIymEmx4ixxWKwbOP
 8kzWhjPBI6Y4NvtGSrsDsasW3TwuoNDduHqZvWVinPXfcU6gUsKz6KESIynqOXJ+QRIK/O
 tD9cXUgBNZctp9i1POCKY3lu71V3u0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-chgpMnD9Pl-s8axk8vd-Sg-1; Fri,
 11 Sep 2026 12:40:02 -0400
X-MC-Unique: chgpMnD9Pl-s8axk8vd-Sg-1
X-Mimecast-MFC-AGG-ID: chgpMnD9Pl-s8axk8vd-Sg_1789144800
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF05C18011E7; Fri, 11 Sep 2026 16:40:00 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5CFD180034C; Fri, 11 Sep 2026 16:39:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:15 +0400
Subject: [PATCH v5 41/62] hw/nvdimm: convert UUID property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-41-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC27eu+LbvGum5hSXTSauztivm8X4ySQjE9VJ
 Qt3pVCUA9iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuwAKCRDa6OEJdZac
 5QvdD/wOvr0i2+yGzDHcEkTWXSuRHCMTCU1k2J9CHttsvnDei1XXGyAoC91WMjDpDYlMhWy0ndY
 eMOB5O/Lj0+f0EXztsAwQqS5bA7OYt9CX/a0VbC0a6lUKveXcjFxCSroVuQbfam/zAv8Py4SZF2
 zOo01cKIr8jIMOtRhioRrTgpeiy0OUZLvMuWh/Ht5eEQ0L+E4EaoURvkKxcb2UyZ8I0MzeNWUof
 kqdZ5FIW0i06ar0DMAA1uxcsGT7WmFlFPl6IcEpQ6Pfl7zqLm6V52OBdnI8SOTD8guNAezbHV2j
 QQRG5l0FLugrKPXPovdGkY4o3SzcNVjEApo/dpScU09TXr9C6/IyPeciCMXACPlcurX1+1xG++z
 rjzbNtS9h8+++SAp91PM4ILxve68Bn/DDjsQaelkGjeSuAmX5w4zf4jFmrIsoM5PWCt7BlhsMwq
 vX+vT3+2BGRJL70LbyBoWID3i/eHT3h7btrGh/GmV/D/M7umXVn63uin+m6Qhvi6jwnqUo0PcNL
 YOrGufUCyRU7PwXwAavQyNnll0BkOHi1tb8QX2YorAo/nLr3aJZfEEJs5lqJkmJzJ7daNkDr87R
 4Hbg4Mnt0knFy3uxgvVQLIsY3Z2hmpOfDr3ktojBVDkgEe1OpoCvtQt3Od3R5Ha9p7xdtQJAZOA
 qTmcDiWIF9Q1TxQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


