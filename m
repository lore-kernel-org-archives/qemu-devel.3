Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23259C4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 08:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXGpU-00055T-Bm; Tue, 06 Feb 2024 03:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rXGpR-00053Y-DV; Tue, 06 Feb 2024 03:29:18 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rXGpP-000246-Jp; Tue, 06 Feb 2024 03:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707208156; x=1738744156;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xf/ORN5CWiGd0vMDOURLY33RBnkmoMVJDRh8Pp3ESGI=;
 b=Bce0f4g9irVNTGRCi72sLHmYut2nInPstgjppxH2zHsVIbL77zz2ONle
 FkqwId89b/uKg97scj8DFjemXojsCsleUKIwHpxGFnjAPPRhmjUEMIJrb
 gWjd0wyamPbBdD9PXa+ZNSTYvda+Iwyy8COAZ9phPAg0VxpVTkzH7CR3c
 vZDcqqteC03SRNZj/vhBropg+r1SsAAlAhIIOntXN7baahBzF2bqakSKL
 Aovb1lsjt5wVZ/pDlK+AvXZl47LjWDV0nQhl38ep7l5bjn1x7lk7rWwuq
 9qTJgiAMNvSwjnGzerYAChjCjMx+G4SJ5ksgt4HXZQofwIkux10L7Jx7v Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4578307"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="4578307"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2024 00:29:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824112769"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; d="scan'208";a="824112769"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga001.jf.intel.com with ESMTP; 06 Feb 2024 00:29:09 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [RFC PATCH 3/4] ppc/pef: switch to use
 confidential_guest_kvm_init/reset()
Date: Tue,  6 Feb 2024 03:28:51 -0500
Message-Id: <20240206082852.3333299-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206082852.3333299-1-xiaoyao.li@intel.com>
References: <20240206082852.3333299-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Use the unified interface to call confidential guest related kvm_init()
and kvm_reset(), to avoid exposing pef specific functions.

remove perf.h since it is now blank..

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/ppc/pef.c         |  9 ++++++---
 hw/ppc/spapr.c       |  6 +++---
 include/hw/ppc/pef.h | 17 -----------------
 3 files changed, 9 insertions(+), 23 deletions(-)
 delete mode 100644 include/hw/ppc/pef.h

diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
index d28ed3ba7333..47553348b1e7 100644
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
index 0d72d286d80f..d1459157e0cf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -74,6 +74,7 @@
 #include "hw/virtio/vhost-scsi-common.h"
 
 #include "exec/ram_addr.h"
+#include "exec/confidential-guest-support.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -86,7 +87,6 @@
 #include "hw/ppc/spapr_tpm_proxy.h"
 #include "hw/ppc/spapr_nvdimm.h"
 #include "hw/ppc/spapr_numa.h"
-#include "hw/ppc/pef.h"
 
 #include "monitor/monitor.h"
 
@@ -1687,7 +1687,7 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
         qemu_guest_getrandom_nofail(spapr->fdt_rng_seed, 32);
     }
 
-    pef_kvm_reset(machine->cgs, &error_fatal);
+    confidential_guest_kvm_reset(machine->cgs, &error_fatal);
     spapr_caps_apply(spapr);
 
     first_ppc_cpu = POWERPC_CPU(first_cpu);
@@ -2811,7 +2811,7 @@ static void spapr_machine_init(MachineState *machine)
     /*
      * if Secure VM (PEF) support is configured, then initialize it
      */
-    pef_kvm_init(machine->cgs, &error_fatal);
+    confidential_guest_kvm_init(machine->cgs, &error_fatal);
 
     msi_nonbroken = true;
 
diff --git a/include/hw/ppc/pef.h b/include/hw/ppc/pef.h
deleted file mode 100644
index 707dbe524c42..000000000000
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
-- 
2.34.1


