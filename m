Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72A606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Utkw8/1w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbzu-00055i-5q; Sun, 01 Nov 2026 15:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzf-0004rP-SP
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzc-0007AX-Qn
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RBSl5fkD/mbeX6aAczbUd3DDxgneNeikka007B8VZE=;
 b=Utkw8/1wNpSjUuufEoP5VvCoDK7UUGK4dkqh90xJiT7Xg17XhFWggl1y2pRFhpG3ARcsNd
 1zjCXxjY6IkVVOYp3CjY5/CleiCjuhnF3gYLrIec61Jyy4pCf1qh3fMwva6I3Io9LlMu7z
 5VJcEHzKKmT5Jo6pxr2U9mAR98r2hj0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-_r1WV2qTPsOrdl8K-Gt3oQ-1; Sun,
 01 Nov 2026 15:17:26 -0500
X-MC-Unique: _r1WV2qTPsOrdl8K-Gt3oQ-1
X-Mimecast-MFC-AGG-ID: _r1WV2qTPsOrdl8K-Gt3oQ_1793564246
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D8271955F6F
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1F2C180057F
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0171521E689A; Sun, 01 Nov 2026 21:17:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 22/56] pc: convert OnOffAuto vmport property to QAPI-aware
 registration
Date: Sun,  1 Nov 2026 21:16:43 +0100
Message-ID: <20261101201717.3911097-23-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Convert the vmport OnOffAuto property from manual visitor-based
callbacks to object_class_property_add_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/pc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1fce96f5ec..649ae27156 100644
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
@@ -1417,21 +1418,16 @@ static const HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
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
@@ -1729,9 +1725,11 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
         "Maximum ram below the 4G boundary (32bit boundary)");
 
-    object_class_property_add(oc, PC_MACHINE_VMPORT, "OnOffAuto", NULL,
-                              pc_machine_get_vmport, pc_machine_set_vmport,
-                              NULL, NULL);
+    object_class_property_add_enum(oc, PC_MACHINE_VMPORT,
+                                   "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   pc_machine_get_vmport,
+                                   pc_machine_set_vmport);
     object_class_property_set_description(oc, PC_MACHINE_VMPORT,
         "Enable vmport (pc & q35)");
 
-- 
2.55.0


