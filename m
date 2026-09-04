Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D9DC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a4N-0008CS-PE; Fri, 04 Sep 2026 15:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4M-0008C9-QD
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4L-0007x5-8P
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jpy8BYiyeQ1/xM+bCFKZLs5qW5++vmmopKZQaqcqzvg=;
 b=HWMJf3hsIbRtyqRs6NM2QIng3u8U98QzCMX26xEkSqu3PW3qr66G4QBOWE5fMSY4R1nxn/
 OyWaoE5OR9Q3mEbC482pI9G+POITPrGKUTuoQfyKOhZMnfGJM2GLBqwe0Wn4+MeSa6rDGV
 aWq4+IfvDUqQMr5FUTwi7aO6/JrBhaA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-cZVId3KqMKe4Iqewz6LYHw-1; Fri,
 04 Sep 2026 15:59:23 -0400
X-MC-Unique: cZVId3KqMKe4Iqewz6LYHw-1
X-Mimecast-MFC-AGG-ID: cZVId3KqMKe4Iqewz6LYHw_1788551962
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13C921893ED4; Fri,  4 Sep 2026 19:59:22 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAB2C5BC; Fri,  4 Sep 2026 19:59:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:03 +0400
Subject: [PATCH v4 20/75] pc: convert OnOffAuto vmport property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-20-a985f168e938@redhat.com>
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
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2492;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=p6+EX45jD1DvPE7aHMiqR5ww7Y9deovLVheC6sjhUUY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJO7XgwdF+tY/VBB+vSZkSkH7TPQCgY1F1I
 /mn7+VW5wiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5R0WD/9zFtEYd7ZAqLBIPDev5Tyl7lxLehWqW1dht7AsbVfVLE90tEYmUKjBYExqFHRDYAhsNGb
 Tdg7JUhuqwwuIztVgGEykQD6+aaBADGhgUiWW2MjwRsWwgTKPV/zTwybtrvIGBZ0AuG2TxRkxy1
 5jUqqaYU4Fsu+lktEeRMNOywSkBjgw/e2OiI7adqoTlpqFLrZ8hqSA6g0mob8gkq++xmx7CXgrp
 3VxhhfFOkj+OLdFITwCm9L2riX1jiVwbCK3zmjtgRzoToyxZ/jmilUf+qKHW+1LWRST5Srzpq3t
 6kAdEe5IFiDjV5JYEWR+qnyuv5L6FRGxZ2Q3A6fnOCnnBaST/KD1NGCfgmAuPIDrwP5TnhciyaG
 isUS4xtXrW2BAQpoNURyCbx3GMNvG0hUJF55tc4Z+3TOjpUj7lDjhwX2dNPphbzpa1IDYT+zvCg
 GY2LOe4ew7aNLDICqtkSte2zl2IL0OzVSdNQ8rOOKdrpRvteLPxSp1u4JQrJS6T4sIG0Uh/Y3ET
 woZKyWom0Gjl6kHzSbMM+/fU/MYoJ2+6u7n/3OTmD5ALT5QvYQnuUq64QdlNTvZHG88Tsevl1pn
 bplcSsXuy+84DYuF0QDfn4SQhxKRmXFNc7xB//xo6z/w9gay0a9Ypqs+L5K9fEvA5Z0tcHw7/tX
 4R9yIEeJ5D7Ai9Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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


