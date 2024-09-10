Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BACEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so58h-00066E-Dt; Tue, 10 Sep 2024 13:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58U-00056w-Rz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58S-0006Od-MN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725991118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gj7pMsESKiT1jlj7/EZJlHg9RWytVe+kVEU61ibsaPw=;
 b=ZiyYjF17aQEYIgD9fQvhpueCMkNpeA/PGDc+CAL/a+2WyW6WgzgDUN2XeV4kjQyYUrg85v
 KO6Nal6BtFoW9DT3uLw4eaBsd4qZe/r0TijCkSi8HB61lDJ/miX2WvfedyXINYJlosvkKz
 shonB0ElMJKhepVE4yHMYP7yBlP+q4c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-NH-qMA6KML2mqi-SNXPbDA-1; Tue,
 10 Sep 2024 13:58:34 -0400
X-MC-Unique: NH-qMA6KML2mqi-SNXPbDA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B81D71953955; Tue, 10 Sep 2024 17:58:31 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.32.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 295D71955D4E; Tue, 10 Sep 2024 17:58:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 03/14] s390x/s390-virtio-hcall: prepare for more diag500
 hypercalls
Date: Tue, 10 Sep 2024 19:57:58 +0200
Message-ID: <20240910175809.2135596-4-david@redhat.com>
In-Reply-To: <20240910175809.2135596-1-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We'll rename the files separately, so git properly detects the rename.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-hcall.c   |  8 ++++----
 hw/s390x/s390-virtio-hcall.h   | 11 ++++++-----
 target/s390x/kvm/kvm.c         | 10 ++--------
 target/s390x/tcg/misc_helper.c |  4 ++--
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
index ca49e3cd22..4cddf69fbb 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-virtio-hcall.c
@@ -1,5 +1,5 @@
 /*
- * Support for virtio hypercalls on s390
+ * Support for QEMU/KVM hypercalls on s390
  *
  * Copyright 2012 IBM Corp.
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
@@ -57,15 +57,15 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
     return 0;
 }
 
-int s390_virtio_hypercall(CPUS390XState *env)
+int handle_diag_500(CPUS390XState *env)
 {
     const uint64_t subcode = env->regs[1];
 
     switch (subcode) {
-    case KVM_S390_VIRTIO_NOTIFY:
+    case DIAG500_VIRTIO_NOTIFY:
         env->regs[2] = handle_virtio_notify(env->regs[2]);
         return 0;
-    case KVM_S390_VIRTIO_CCW_NOTIFY:
+    case DIAG500_VIRTIO_CCW_NOTIFY:
         env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
         return 0;
     default:
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 3d9fe147d2..e4f76aca82 100644
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
+int handle_diag_500(CPUS390XState *env);
 
 #endif /* HW_S390_VIRTIO_HCALL_H */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 94181d9281..ac292b184a 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1493,16 +1493,10 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
 
 static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
 {
-    CPUS390XState *env = &cpu->env;
-    int ret;
-
-    ret = s390_virtio_hypercall(env);
-    if (ret == -EINVAL) {
+    if (handle_diag_500(&cpu->env)) {
         kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
-        return 0;
     }
-
-    return ret;
+    return 0;
 }
 
 static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 303f86d363..58757585a2 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -117,9 +117,9 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
 
     switch (num) {
     case 0x500:
-        /* KVM hypercall */
+        /* QEMU/KVM hypercall */
         bql_lock();
-        r = s390_virtio_hypercall(env);
+        r = handle_diag_500(env);
         bql_unlock();
         break;
     case 0x44:
-- 
2.46.0


