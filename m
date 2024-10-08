Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B229CEF150
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7sG-0001LA-Uh; Tue, 08 Oct 2024 06:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7sF-0001KL-7i
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7sD-0001eZ-Lo
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728384925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGLHZLJ0QeoA7f+QassN2W0pfX21pfZ8EKxhyJsshKQ=;
 b=RZWOhGDjI808jXliSO93qH0aLW6oEbUQ8UXSZNN7xcZOYyISng9HiyqaWcw9MVmAGK+3km
 r2BkCZZLtZe07jCVTrPbgzOUvYlt7tEx//AiLOs8SSrPWqM3YRhq2pW3+1OnIDjiIAfWgL
 ZisqUcC/EMNoBNFzEEz/OplNfYMw70c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-1bK25XIcMiygiwXEnpfAMw-1; Tue,
 08 Oct 2024 06:55:21 -0400
X-MC-Unique: 1bK25XIcMiygiwXEnpfAMw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C2E81955F29; Tue,  8 Oct 2024 10:55:20 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F11B19560A3; Tue,  8 Oct 2024 10:55:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 03/14] s390x/s390-virtio-hcall: prepare for more diag500
 hypercalls
Date: Tue,  8 Oct 2024 12:54:44 +0200
Message-ID: <20241008105455.2302628-4-david@redhat.com>
In-Reply-To: <20241008105455.2302628-1-david@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Let's generalize, abstracting the virtio bits. diag500 is now a generic
hypercall to handle QEMU/KVM specific things. Explicitly specify all
already defined subcodes, including legacy ones (so we know what we can
use for new hypercalls).

Move the PGM_SPECIFICATION injection into the renamed function
handle_diag_500(), so we can turn it into a void function.

We'll rename the files separately, so git properly detects the rename.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-hcall.c   | 15 ++++++++-------
 hw/s390x/s390-virtio-hcall.h   | 11 ++++++-----
 target/s390x/kvm/kvm.c         | 16 +---------------
 target/s390x/tcg/misc_helper.c |  5 +++--
 4 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
index ca49e3cd22..5fb78a719e 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-virtio-hcall.c
@@ -1,5 +1,5 @@
 /*
- * Support for virtio hypercalls on s390
+ * Support for QEMU/KVM hypercalls on s390
  *
  * Copyright 2012 IBM Corp.
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
@@ -57,18 +57,19 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
     return 0;
 }
 
-int s390_virtio_hypercall(CPUS390XState *env)
+void handle_diag_500(S390CPU *cpu, uintptr_t ra)
 {
+    CPUS390XState *env = &cpu->env;
     const uint64_t subcode = env->regs[1];
 
     switch (subcode) {
-    case KVM_S390_VIRTIO_NOTIFY:
+    case DIAG500_VIRTIO_NOTIFY:
         env->regs[2] = handle_virtio_notify(env->regs[2]);
-        return 0;
-    case KVM_S390_VIRTIO_CCW_NOTIFY:
+        break;
+    case DIAG500_VIRTIO_CCW_NOTIFY:
         env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
-        return 0;
+        break;
     default:
-        return -EINVAL;
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 }
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 3d9fe147d2..dca456b926 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -1,5 +1,5 @@
 /*
- * Support for virtio hypercalls on s390x
+ * Support for QEMU/KVM hypercalls on s390x
  *
  * Copyright IBM Corp. 2012, 2017
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
@@ -12,12 +12,13 @@
 #ifndef HW_S390_VIRTIO_HCALL_H
 #define HW_S390_VIRTIO_HCALL_H
 
-#include "standard-headers/asm-s390/virtio-ccw.h"
 #include "cpu.h"
 
-/* The only thing that we need from the old kvm_virtio.h file */
-#define KVM_S390_VIRTIO_NOTIFY 0
+#define DIAG500_VIRTIO_NOTIFY           0 /* legacy, implemented as a NOP */
+#define DIAG500_VIRTIO_RESET            1 /* legacy */
+#define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
+#define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
 
-int s390_virtio_hypercall(CPUS390XState *env);
+void handle_diag_500(S390CPU *cpu, uintptr_t ra);
 
 #endif /* HW_S390_VIRTIO_HCALL_H */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 8ffe0159d8..a8cbc0e2eb 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1491,20 +1491,6 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
     return r;
 }
 
-static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
-{
-    CPUS390XState *env = &cpu->env;
-    int ret;
-
-    ret = s390_virtio_hypercall(env);
-    if (ret == -EINVAL) {
-        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
-        return 0;
-    }
-
-    return ret;
-}
-
 static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
 {
     uint64_t r1, r3;
@@ -1601,7 +1587,7 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
         handle_diag_318(cpu, run);
         break;
     case DIAG_KVM_HYPERCALL:
-        r = handle_hypercall(cpu, run);
+        handle_diag_500(cpu, RA_IGNORED);
         break;
     case DIAG_KVM_BREAKPOINT:
         r = handle_sw_breakpoint(cpu, run);
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 303f86d363..0ab2bf36cf 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -117,10 +117,11 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
 
     switch (num) {
     case 0x500:
-        /* KVM hypercall */
+        /* QEMU/KVM hypercall */
         bql_lock();
-        r = s390_virtio_hypercall(env);
+        handle_diag_500(env_archcpu(env), GETPC());
         bql_unlock();
+        r = 0;
         break;
     case 0x44:
         /* yield */
-- 
2.46.1


