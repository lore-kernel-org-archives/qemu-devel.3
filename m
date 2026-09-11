Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6D3C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54IJ-0005Ro-6s; Fri, 11 Sep 2026 12:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54I7-0005AR-M5
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54I2-0006lB-HX
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjQUeWzB+URGNhy51pTY8kngaMPVjWJKxA5gkx975Fc=;
 b=FIKVNvMTUw1i/sufMKiWgoL1OUEkHr19N8X91XlKKxpIeZsNSK5Eet8erDyY73G3MOd/5j
 6yCAxdcueDzVcFWayP2GKIAIavEAoI7B9igxb4AMNEirrSLu4NTZspk3S5ObJnimqeVMRU
 UEpkLWVMihFpMFhxlsmqPmaOCTbZNvM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-DNNff0GvM0GF50dvFOsTCw-1; Fri,
 11 Sep 2026 12:39:48 -0400
X-MC-Unique: DNNff0GvM0GF50dvFOsTCw-1
X-Mimecast-MFC-AGG-ID: DNNff0GvM0GF50dvFOsTCw_1789144787
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA1AB195C267; Fri, 11 Sep 2026 16:39:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0582433; Fri, 11 Sep 2026 16:39:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:11 +0400
Subject: [PATCH v5 37/62] accel/hvf: convert OnOffSplit property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-37-7732a55b7760@redhat.com>
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
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2469;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oWCHQCOKOr/KE6g1VOAN6Z+R3g0iOTOZVDDieDqKREY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC26mpwbS3gGnsMfLRu+h6ruvN/tyewKwGnQ5
 X2sq7uRf7OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtugAKCRDa6OEJdZac
 5WECEACcwaIJtniOkboqXSEhS+mu7cn/BUcLFOfZOmv0GuF+4ns9sQgn75MDATFKKmb9cYg94ix
 ZQS6J2xXzBpNo/0b9I/2/bFJmbTMZdsCYecpMsP0IyvDAFEKVzkOMLMJjFNLttZZg2torcVvvcI
 cZeBmg2LMV4XevGpTebj7blbNAcKVLSMmywnA1A9ydCC5ZhWG0LFJGXe76R7QyfNJpRr2SImUxZ
 MvSi3PzBMOVXYg8kKY0lcjscn9ToZt6//xuz1A96jMe7NwgsseqqJmvOQP/VppNr7Q4c49rU3nG
 ZYqMpHYe3zCcua8uAx3hsAupoGqbn2dDgl73KX4XBeS4rz+G7lYwtL8hQGd0drw3vGN7iJrLzds
 KarExe4xpldWJks5HvEC17U98I5i8Be8aYPK1tliDmNKXdtFnfzLQe2fH5ZHfUvH23858wXa1ll
 nEG08qmqhoo5rPPs1StQPE2NXHnTJaBI7mFzLE952nCs1+6Lv7c1+mHMu74aRbNaf531I3hQwyO
 tZTw5yIaP0QH6mTofSHmLJ8Llc+1JZOzFdzCANpfyN5pMjNUk5Em56Y91Lod+nULLGSadGH0ifv
 ze+46JvQWS1DO/PiL/bO0QZr4nimJ0L/svocr69gEnDXDoz/tn0wRDgVq+PCIVQXLUhu5rjjRCK
 No1X3d4heNy/SaA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Convert the OnOffSplit property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/hvf/hvf-all.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 8bd9154a50b6..2fd594ad156f 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "accel/accel-ops.h"
 #include "exec/cpu-common.h"
@@ -230,18 +231,12 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     return hvf_arch_init();
 }
 
-static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
+static void hvf_set_kernel_irqchip(Object *obj, int value,
                                    Error **errp)
 {
-    OnOffSplit mode;
-
     hvf_kernel_irqchip_override = true;
-    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
-        return;
-    }
 
-    switch (mode) {
+    switch (value) {
     case ON_OFF_SPLIT_ON:
 #ifdef HOST_X86_64
         /* macOS 12 onwards exposes an HVF virtual APIC. */
@@ -261,11 +256,7 @@ static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
         break;
 
     default:
-        /*
-         * The value was checked in visit_type_OnOffSplit() above. If
-         * we get here, then something is wrong in QEMU.
-         */
-        abort();
+        g_assert_not_reached();
     }
 }
 
@@ -277,11 +268,13 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->allowed = &hvf_allowed;
     hvf_kernel_irqchip_override = false;
     hvf_kernel_irqchip = false;
-    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-        NULL, hvf_set_kernel_irqchip,
-        NULL, NULL);
-    object_class_property_set_description(oc, "kernel-irqchip",
-        "Configure HVF irqchip");
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "kernel-irqchip",
+        .qapi_type = &OnOffSplit_type_info,
+        .set = hvf_set_kernel_irqchip,
+        .description = "Configure HVF irqchip",
+    ));
 }
 
 static const TypeInfo hvf_accel_type = {

-- 
2.55.0.543.g5ebe2ebe4ea8


