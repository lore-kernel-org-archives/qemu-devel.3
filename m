Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEA7C5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHpP-0000zF-0Q; Tue, 18 Aug 2026 07:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHpN-0000wF-4G
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHpL-0005kR-6x
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jpy8BYiyeQ1/xM+bCFKZLs5qW5++vmmopKZQaqcqzvg=;
 b=S8WXgF2Lz93gj1DUIMl3Js4LTz4DiR/6zscl9xbOAw54lsJKRvWIFEDNidMQIp1PusCt8u
 6ZlDBxndtr0FWmYDZcDo4pynVV0bbVEElRt9i1knEKnEt60JnVK6mIKsXCB1aaq8m6fw3k
 OMcfrE62OcSZ71Ew+FEylfCCAgoUr7U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-RVZsg778PLSCebFl5eyEZQ-1; Tue,
 18 Aug 2026 07:17:49 -0400
X-MC-Unique: RVZsg778PLSCebFl5eyEZQ-1
X-Mimecast-MFC-AGG-ID: RVZsg778PLSCebFl5eyEZQ_1787051868
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8952C180074B; Tue, 18 Aug 2026 11:17:48 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 882EB1953944; Tue, 18 Aug 2026 11:17:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:46 +0400
Subject: [PATCH v3 19/74] pc: convert OnOffAuto vmport property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-19-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2492;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=p6+EX45jD1DvPE7aHMiqR5ww7Y9deovLVheC6sjhUUY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD240Lmq3q5CB0zDyukr2NcD2yPssiG29Loms
 hyptd0Cv4+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uAAKCRDa6OEJdZac
 5fpID/oDOzh9JB/ZR0pgP7EiSbkGiXzTqp/cpWUW2U2zbG8S6Rdwu+skEQ/v1rzZIb8L1QyUq78
 64A1A8Ue/MTm5Cu2I7ulq4FkUcOBdbUTfoudN0GaAItzbQu6+K7zH7GkoXkbLOHmPtf8RS/QhcW
 rMeowgcyeHeLV+6I+eLzycPf663LTLbtLUcO5bEs4NvBFSF0mGkXB/twhTsyZQo9VwAUjW9Raah
 Iyqq9ZeyKtJHCInpDBQX+UWa6Z87EDW3rCReOKY+v4wiC3rszZKS52Zt4VonGtDJ5Id6DBBxRKs
 tqsmGoL/cKyDEgcCD5pTM7QA/G54KFJ02r2SktXUy4rON/e30ODi6lbXZlWCLzZOiyFWmeCFLT+
 hNlZX3UEIu9aCftsjEpbq2uejmbpOs5y6p5XCKhGZAB8SchkN0SLGLb+TSI6CQjFHKHeccgTn0d
 LYdoYyMd+7POvHL5LTZvYb+NzkjXyph+pZ27d+2yZCzId4lgf3V34nCpmyzBod1/qDHe8YsTzkI
 5y4U3T7GUrCPtyP7brNCZnwL0kuZzOwYuzIh+4VyuWVOmdenEfykfGR2EVIa/ic6pwvn6L7nHVq
 Tp8qZS7OA4EK0n8w3TEJAI7fmHeOpJ+aSPTNj00HNs4T0iemVqxdnntbPOHgRQ+rh6JoR3t/TvE
 0q8HoOhGMJM6tOw==
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

Convert the vmport OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e9e4fc262b83..18b5dc169ab7 100644
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
@@ -1419,21 +1420,16 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
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
@@ -1730,11 +1726,13 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
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
2.55.0.543.g5ebe2ebe4ea8


