Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1316C79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a4m-0001E1-Ui; Fri, 04 Sep 2026 15:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4k-0001Cg-Vc
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4j-0007zw-Bc
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=774JTQE9fhFJYG5Yl825DuZO/ePui9QPF2Hyr3EDJC0=;
 b=B8q4N1Xkqdycu3Jgr577y9GRJyk6eCXQfL1NpKGd0jz/7tQkYR2eonGBs9n8C8C3OFSHO9
 dzRR7tavrUKQnxNmKG0qWsfuMHVpilgf+krbNy+PCiUf12bfr9Y5gIpFAyBkVHe0IzDm27
 WatP2GxmvD1guBfyDfHkT1rXN9XdXyU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-GKfpf2pXNtGHTkqHkDc73Q-1; Fri,
 04 Sep 2026 15:59:42 -0400
X-MC-Unique: GKfpf2pXNtGHTkqHkDc73Q-1
X-Mimecast-MFC-AGG-ID: GKfpf2pXNtGHTkqHkDc73Q_1788551981
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2164218E9B1F; Fri,  4 Sep 2026 19:59:41 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0FC9D18005B5; Fri,  4 Sep 2026 19:59:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:08 +0400
Subject: [PATCH v4 25/75] sev: convert OnOffAuto legacy-vm-type property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-25-a985f168e938@redhat.com>
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
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pBhxWaKYyHBx9ZkVP2bH1ohKdCKTnUGjTGeRf5Z8Jaw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJWYqOlOzUsa+tkot3difFdzObGXEd7adbW
 I6Fk1mLvqeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5YRMD/9DXtHutOu6gOoZwXIyIFx1xL19mRPJ1ca6TItIaUXKFteKjmz9GNqI9ZXYv1T4CXKClVH
 dm9ir9WT2NxpfBxk3UwvPHHn7YCYrtffx3qdAPPfz82aOprdPDZzzl6jDltOvJB2PKJ0yJ//wSm
 Fc4GJKzovbjPzgAblKcSMAJkcPTIUSGbexQMsVdY2CmF+1HvJh9iUEitdz7LeEsZGZEipzGrK06
 wZZ83aVIrxQMG8b6fh/bdD01Y3JG+Rd4xLw9rfSXSofKTA/q/vKOyn4ycqkyjXcPaYHHM9lWPzO
 1SUbM77fd/8KLBhcfXtUN9FlGuYVgFb6+z4k7171XSxtrERagKMDK8eyazLCY2Z2xwpIajUTsW2
 BIb0n82Cy3CZMqqAfxxRyw/TdcXPecmMDkPu6HAYH4Qhn+tiUPXs6Eqdlyc74is86ksHSXmnHjc
 aZNTIBM0rLD2wr4jTHr9K68ig8+u1B+pPVVEkaZLOwJj9o+uRzYhu4WfBbY9qC63WyW/piUaUWp
 wXvehkBvq4Yu9rAOxT9nIBTYq3ZDs3fNZnkikVpH7xkywmX3W6e6QpUIUgmUoLwcddHh3omv984
 WDIgcq2Qv85rwhoX+RNfVctIYCfccrtPmVw9HzwMr4qe+AzohR7s4m+I7ArdRmhjGi1eRPXoZKf
 I7IrISiFTiQT64A==
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

Convert the legacy-vm-type OnOffAuto property from manual
visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/sev.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index cc16c6b07123..b2c7260c80a4 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -20,6 +20,7 @@
 #include <sys/ioctl.h>
 
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
 #include "qemu/module.h"
@@ -2939,23 +2940,16 @@ sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
     SEV_GUEST(obj)->session_file = g_strdup(value);
 }
 
-static void sev_guest_get_legacy_vm_type(Object *obj, Visitor *v,
-                                         const char *name, void *opaque,
-                                         Error **errp)
+static int sev_guest_get_legacy_vm_type(Object *obj, Error **errp)
 {
     SevGuestState *sev_guest = SEV_GUEST(obj);
-    OnOffAuto legacy_vm_type = sev_guest->legacy_vm_type;
-
-    visit_type_OnOffAuto(v, name, &legacy_vm_type, errp);
+    return sev_guest->legacy_vm_type;
 }
 
-static void sev_guest_set_legacy_vm_type(Object *obj, Visitor *v,
-                                         const char *name, void *opaque,
-                                         Error **errp)
+static void sev_guest_set_legacy_vm_type(Object *obj, int value, Error **errp)
 {
     SevGuestState *sev_guest = SEV_GUEST(obj);
-
-    visit_type_OnOffAuto(v, name, &sev_guest->legacy_vm_type, errp);
+    sev_guest->legacy_vm_type = value;
 }
 
 static void
@@ -2981,11 +2975,14 @@ sev_guest_class_init(ObjectClass *oc, const void *data)
                                   sev_guest_set_session_file);
     object_class_property_set_description(oc, "session-file",
             "guest owners session parameters (encoded with base64)");
-    object_class_property_add(oc, "legacy-vm-type", "OnOffAuto",
-                              sev_guest_get_legacy_vm_type,
-                              sev_guest_set_legacy_vm_type, NULL, NULL);
-    object_class_property_set_description(oc, "legacy-vm-type",
-            "use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "legacy-vm-type",
+        .description = "use legacy VM type to maintain measurement "
+                       "compatibility with older QEMU or kernel versions.",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = sev_guest_get_legacy_vm_type,
+        .set = sev_guest_set_legacy_vm_type,
+    ));
 }
 
 static void

-- 
2.55.0.543.g5ebe2ebe4ea8


