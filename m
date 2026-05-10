Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79600CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4VX-0004CW-8j; Sun, 10 May 2026 09:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Uv-0003UZ-0Z
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Us-00054r-Nx
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nF/cntTLQgSDNskyD9TtxEb9BydSOVYtLSszBBpe5GI=;
 b=QTcawLyS9j/UFZLYn1HMERFfzghmSUOKjltUADy7m4KjYIdSXxgWfjWPNbIqNVyHwnWTuk
 c7ZSYN/Gny28t3ykCdXrxEXibLfwL27XKnHALwGbhSsI8MJpP9to3lKPBNIk207DSUJLTe
 oCy2JMnLcOwq+P9dtL3SDkVumetSNVQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-OovMOV3DOgieNcRsdp39BA-1; Sun,
 10 May 2026 09:47:04 -0400
X-MC-Unique: OovMOV3DOgieNcRsdp39BA-1
X-Mimecast-MFC-AGG-ID: OovMOV3DOgieNcRsdp39BA_1778420824
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF5FA1956080
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:47:03 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEF531800240; Sun, 10 May 2026 13:46:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:15 +0400
Subject: [PATCH 18/54] pc: convert OnOffAuto vmport property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-18-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TZ9resH5GV3T2agEDTnUC7y/xCP2iY9Bvn5Xykd3Gpo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItvhaEU3mulFozRucTm4K+XMMr75eI+ynk5I
 5hZsUQNeKuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbwAKCRDa6OEJdZac
 5VuAD/4p6bltS1ieGF0reGetxhtyLns+//ghNshrBj755ncbS+iFjm5bGCLAkFV7l4hbHB+wX20
 opPlE+cMhZ18Q78OkoeOLvvdxPNp3ufczqF0+eS/VwU9jJS4vFctOArCb3c3hlZ5WTiabFOJnJs
 3xzBpGYsuOMBfOW6Ht7BV8SpnrDsaQzpEFayp91k8oUGs12KXC1dPmfmeNzBS4RvyIzMOzQIpju
 /bNx6In3gvLN2DONETy9WgFbZasZjmr8kH6AfTA2k+ia1jasbhEMha7StuYuCKBUjn/mH7pqp4k
 yZ6zNMegTwedx0oHXeraWdz8+C8Rkb23ULqa8uqCHFbGhdjoidgJ4eKcIw3kHzx+rhb8l42/hlY
 vYrOA+UtcyIqTSc5AGmVGRAp8ESh386S38dNB9XWHBAEblmo2ZMFk1kuCFXGZaOleSsRGYvgDrv
 /4oDwlVDcoKgOW1nuK4CSWnV4WhMUU+89NH4gek9w43wjSAe32+EWhGxIseKH1BI3QWpYp3cVlJ
 WJP6b+X2/6x9o0gHJEam2hZaeyqd+f5Vu/GUWOoQlQkvaSQe7fAWdW/Iyh4VjLu4dmnLX07ELsC
 W2InSdb/b+P5QiXJdWvXOFjqnQ3pDKrnzRwwWRWxz9qr4+KxZhvtfzfiepW0bhSVgbZhOQ1kQJX
 nWrfgpsu/fgXlfg==
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Convert the vmport OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ecad3c503f..6a4fe126bc0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -46,6 +46,7 @@
 #include "kvm/kvm_i386.h"
 #include "kvm/tdx.h"
 #include "hw/xen/xen.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/acpi.h"
@@ -1379,21 +1380,16 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void pc_machine_get_vmport(Object *obj, Visitor *v, const char *name,
-                                  void *opaque, Error **errp)
+static int pc_machine_get_vmport(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-    OnOffAuto vmport = pcms->vmport;
-
-    visit_type_OnOffAuto(v, name, &vmport, errp);
+    return pcms->vmport;
 }
 
-static void pc_machine_set_vmport(Object *obj, Visitor *v, const char *name,
-                                  void *opaque, Error **errp)
+static void pc_machine_set_vmport(Object *obj, int value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &pcms->vmport, errp);
+    pcms->vmport = value;
 }
 
 static bool pc_machine_get_fd_bootchk(Object *obj, Error **errp)
@@ -1681,11 +1677,13 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
         "Maximum ram below the 4G boundary (32bit boundary)");
 
-    object_class_property_add(oc, PC_MACHINE_VMPORT, "OnOffAuto",
-        pc_machine_get_vmport, pc_machine_set_vmport,
-        NULL, NULL);
-    object_class_property_set_description(oc, PC_MACHINE_VMPORT,
-        "Enable vmport (pc & q35)");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = PC_MACHINE_VMPORT,
+        .description = "Enable vmport (pc & q35)",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = pc_machine_get_vmport,
+        .set = pc_machine_set_vmport,
+    ));
 
     object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
         pc_machine_get_smbus, pc_machine_set_smbus);

-- 
2.54.0


