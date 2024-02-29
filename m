Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE20FC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZUT-00016I-Mq; Thu, 29 Feb 2024 01:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfZTj-0000Xi-DE; Thu, 29 Feb 2024 01:01:11 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfZTh-0001Od-SQ; Thu, 29 Feb 2024 01:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709186470; x=1740722470;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PdtkwSuslEbm0BAB7uu91wKG2iEtF4n8LcLzLpoKvUo=;
 b=jBXeMqCRq8ddWzMzh63BROUD6XNXzgEs1CAAYFkS3nvd2CcXbqOMl1CA
 WQEiuqyEhUSdXsgZIJziUWdpx6ZBD6eD/CKEc4wKAN4V7Y4KHmngHebGi
 z2TnqaPKaJNJ+ViDgglPr/z9XdZxO3d29WRc0ipuRstMfyx0VJTwWzsYy
 iAxThLA6HM6qFYKwXBysixjHrWLFrCo6QqSAAXn+IMGqRWsR2yvyIxBRQ
 24y5hiV3zsmLbbl5gc6SR/iwczYpgxHn8vScuKxw96Uevb6Cf5kLGz7Bt
 yqZA1ULNwCcLVBVZE8P6BpNi57vR/Dj0Xh2dzmNhm+d/ePmd2XNtk+o34 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14274189"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; d="scan'208";a="14274189"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:01:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8266173"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa008.jf.intel.com with ESMTP; 28 Feb 2024 22:01:02 -0800
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
Cc: xiaoyao.li@intel.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 4/4] s390: Switch to use confidential_guest_kvm_init()
Date: Thu, 29 Feb 2024 01:00:38 -0500
Message-Id: <20240229060038.606591-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229060038.606591-1-xiaoyao.li@intel.com>
References: <20240229060038.606591-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.596, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
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

Use unified confidential_guest_kvm_init(), to avoid exposing specific
functions.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes from rfc v1:
 - check machine->cgs not NULL before calling confidential_guest_kvm_init();
---
 hw/s390x/s390-virtio-ccw.c |  5 ++++-
 target/s390x/kvm/pv.c      |  8 ++++++++
 target/s390x/kvm/pv.h      | 14 --------------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 62804cc2281d..9b7564bbd4d2 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/ram_addr.h"
+#include "exec/confidential-guest-support.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
@@ -260,7 +261,9 @@ static void ccw_init(MachineState *machine)
     s390_init_cpus(machine);
 
     /* Need CPU model to be determined before we can set up PV */
-    s390_pv_init(machine->cgs, &error_fatal);
+    if (machine->cgs) {
+        confidential_guest_kvm_init(machine->cgs, &error_fatal);
+    }
 
     s390_flic_init();
 
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 7ca7faec73e9..c04d53753bfa 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -340,6 +340,11 @@ int s390_pv_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return 0;
     }
 
+    if (!kvm_enabled()) {
+        error_setg(errp, "Protected Virtualization requires KVM");
+        return -1;
+    }
+
     if (!s390_has_feat(S390_FEAT_UNPACK)) {
         error_setg(errp,
                    "CPU model does not support Protected Virtualization");
@@ -364,6 +369,9 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(S390PVGuest,
 
 static void s390_pv_guest_class_init(ObjectClass *oc, void *data)
 {
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+
+    klass->kvm_init = s390_pv_kvm_init;
 }
 
 static void s390_pv_guest_init(Object *obj)
diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index 5877d28ff10a..4b408174391a 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -80,18 +80,4 @@ static inline int kvm_s390_dump_mem_state(uint64_t addr, size_t len,
 static inline int kvm_s390_dump_completion_data(void *buff) { return 0; }
 #endif /* CONFIG_KVM */
 
-int s390_pv_kvm_init(ConfidentialGuestSupport *cgs, Error **errp);
-static inline int s390_pv_init(ConfidentialGuestSupport *cgs, Error **errp)
-{
-    if (!cgs) {
-        return 0;
-    }
-    if (kvm_enabled()) {
-        return s390_pv_kvm_init(cgs, errp);
-    }
-
-    error_setg(errp, "Protected Virtualization requires KVM");
-    return -1;
-}
-
 #endif /* HW_S390_PV_H */
-- 
2.34.1


