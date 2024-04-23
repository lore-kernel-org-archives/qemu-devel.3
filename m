Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC46C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnj-0007e0-5h; Tue, 23 Apr 2024 11:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn6-0004dv-5X
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn0-0000Gb-Ic
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47V3oaPt23MbVmGEQPCO7LaPQQrDD/VRYl+nTb/ne1k=;
 b=cJGGueJe1MJmI+W93XGNrp36DhQSpCR5+jxgwzBFcbM7DpttOT/6B1v/WDGAyLube8Q+qU
 8e4WpE5qNUxCgYf4oOmtlGHKb6d44jVwT/CPXoIxn/UyScB1c0QcunexhFiROGEByqTXUY
 PI6zkBFeUXkU+z1/bss7DLeDkU6wA58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-6qW50igZNtaI0w_3oVCHQA-1; Tue, 23 Apr 2024 11:10:29 -0400
X-MC-Unique: 6qW50igZNtaI0w_3oVCHQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96A16834FBB;
 Tue, 23 Apr 2024 15:10:29 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AA47200E290;
 Tue, 23 Apr 2024 15:10:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 35/63] s390: Switch to use confidential_guest_kvm_init()
Date: Tue, 23 Apr 2024 17:09:23 +0200
Message-ID: <20240423150951.41600-36-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Use unified confidential_guest_kvm_init() for consistency with
other architectures.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20240229060038.606591-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/s390x/kvm/pv.h      | 14 --------------
 hw/s390x/s390-virtio-ccw.c |  5 ++++-
 target/s390x/kvm/pv.c      | 10 +++++++++-
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index 5877d28ff10..4b408174391 100644
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
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7cebbf6c02a..4dcc2138200 100644
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
index 7ca7faec73e..dde836d21ae 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -334,12 +334,17 @@ static bool s390_pv_guest_check(ConfidentialGuestSupport *cgs, Error **errp)
     return s390_pv_check_cpus(errp);
 }
 
-int s390_pv_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+static int s390_pv_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     if (!object_dynamic_cast(OBJECT(cgs), TYPE_S390_PV_GUEST)) {
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
-- 
2.44.0



