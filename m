Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA88C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnL-0005KM-17; Tue, 23 Apr 2024 11:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn6-0004dt-42
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmy-0000G0-Il
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hq8XYXGaInvX7KB6BRg5A7kCiWC3hjv/40JkR4yO+6o=;
 b=QaV3c5iqP4LNL5I6+m9VM3cIe2N29Tfb4jHbre5eK0rqeHV0trab89rYLXMT71zctUTtJK
 7kcEdAuvcdTYCJB3kbSdUDX2H4fgaIKZ34VO87VmmP4oX/Qoy9jOLK2TF7Zzd9O8qH8pue
 W/b4VpolX81VSsj+Vq/yG0PMDLtR6k0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-Y66SMCy3PQmFnnia5di_PA-1; Tue,
 23 Apr 2024 11:10:29 -0400
X-MC-Unique: Y66SMCy3PQmFnnia5di_PA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF0DD38116F0;
 Tue, 23 Apr 2024 15:10:28 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39251200E290;
 Tue, 23 Apr 2024 15:10:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 34/63] ppc/pef: switch to use
 confidential_guest_kvm_init/reset()
Date: Tue, 23 Apr 2024 17:09:22 +0200
Message-ID: <20240423150951.41600-35-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Use the unified interface to call confidential guest related kvm_init()
and kvm_reset(), to avoid exposing pef specific functions.

As a bonus, pef.h goes away since there is no direct call from sPAPR
board code to PEF code anymore.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/ppc/pef.h | 17 -----------------
 hw/ppc/pef.c         |  9 ++++++---
 hw/ppc/spapr.c       | 10 +++++++---
 3 files changed, 13 insertions(+), 23 deletions(-)
 delete mode 100644 include/hw/ppc/pef.h

diff --git a/include/hw/ppc/pef.h b/include/hw/ppc/pef.h
deleted file mode 100644
index 707dbe524c4..00000000000
--- a/include/hw/ppc/pef.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * PEF (Protected Execution Facility) for POWER support
- *
- * Copyright Red Hat.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#ifndef HW_PPC_PEF_H
-#define HW_PPC_PEF_H
-
-int pef_kvm_init(ConfidentialGuestSupport *cgs, Error **errp);
-int pef_kvm_reset(ConfidentialGuestSupport *cgs, Error **errp);
-
-#endif /* HW_PPC_PEF_H */
diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
index d28ed3ba733..47553348b1e 100644
--- a/hw/ppc/pef.c
+++ b/hw/ppc/pef.c
@@ -15,7 +15,6 @@
 #include "sysemu/kvm.h"
 #include "migration/blocker.h"
 #include "exec/confidential-guest-support.h"
-#include "hw/ppc/pef.h"
 
 #define TYPE_PEF_GUEST "pef-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(PefGuest, PEF_GUEST)
@@ -93,7 +92,7 @@ static int kvmppc_svm_off(Error **errp)
 #endif
 }
 
-int pef_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+static int pef_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     if (!object_dynamic_cast(OBJECT(cgs), TYPE_PEF_GUEST)) {
         return 0;
@@ -107,7 +106,7 @@ int pef_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     return kvmppc_svm_init(cgs, errp);
 }
 
-int pef_kvm_reset(ConfidentialGuestSupport *cgs, Error **errp)
+static int pef_kvm_reset(ConfidentialGuestSupport *cgs, Error **errp)
 {
     if (!object_dynamic_cast(OBJECT(cgs), TYPE_PEF_GUEST)) {
         return 0;
@@ -131,6 +130,10 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(PefGuest,
 
 static void pef_guest_class_init(ObjectClass *oc, void *data)
 {
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+
+    klass->kvm_init = pef_kvm_init;
+    klass->kvm_reset = pef_kvm_reset;
 }
 
 static void pef_guest_init(Object *obj)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 36ada4d0baf..533ea0f9142 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -75,6 +75,7 @@
 #include "hw/virtio/vhost-scsi-common.h"
 
 #include "exec/ram_addr.h"
+#include "exec/confidential-guest-support.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -87,7 +88,6 @@
 #include "hw/ppc/spapr_tpm_proxy.h"
 #include "hw/ppc/spapr_nvdimm.h"
 #include "hw/ppc/spapr_numa.h"
-#include "hw/ppc/pef.h"
 
 #include "monitor/monitor.h"
 
@@ -1715,7 +1715,9 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
         qemu_guest_getrandom_nofail(spapr->fdt_rng_seed, 32);
     }
 
-    pef_kvm_reset(machine->cgs, &error_fatal);
+    if (machine->cgs) {
+        confidential_guest_kvm_reset(machine->cgs, &error_fatal);
+    }
     spapr_caps_apply(spapr);
     spapr_nested_reset(spapr);
 
@@ -2841,7 +2843,9 @@ static void spapr_machine_init(MachineState *machine)
     /*
      * if Secure VM (PEF) support is configured, then initialize it
      */
-    pef_kvm_init(machine->cgs, &error_fatal);
+    if (machine->cgs) {
+        confidential_guest_kvm_init(machine->cgs, &error_fatal);
+    }
 
     msi_nonbroken = true;
 
-- 
2.44.0



