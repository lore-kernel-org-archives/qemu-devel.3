Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8861CEF150
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7tO-0002Dn-S2; Tue, 08 Oct 2024 06:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7sa-0001RI-Ho
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7sW-0001gM-K9
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728384942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cnFX49gGE3YJQwNcOJpdqmqR2DbawMaGFlaZXXGIP0=;
 b=aZnP0QXqlmWAXQa/6cKqNyIBdq5BEqztx+eXk69mkweXdU/Ucw4Vp5/kXe7ys028NRksHa
 qsUJrC7ZfQZMf58BEdRf6G/qDfyE+BV41uZIQsrUnlveLhew6H9YkYlSC04+hhXhUyxiAl
 6FianA8YW3Jmv815rFvQu1DGYdTYPkQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-3ETxc9L9PHWXGLYLMmR3bQ-1; Tue,
 08 Oct 2024 06:55:38 -0400
X-MC-Unique: 3ETxc9L9PHWXGLYLMmR3bQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A8D119560A2; Tue,  8 Oct 2024 10:55:36 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CD3B19560A3; Tue,  8 Oct 2024 10:55:31 +0000 (UTC)
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
Subject: [PATCH v2 06/14] s390x: introduce s390_get_memory_limit()
Date: Tue,  8 Oct 2024 12:54:47 +0200
Message-ID: <20241008105455.2302628-7-david@redhat.com>
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

Let's add s390_get_memory_limit(), to query what has been successfully
set via s390_set_memory_limit(). Allow setting the limit only once.

We'll remember the limit in the machine state. Move
s390_set_memory_limit() to machine code, merging it into
set_memory_limit(), because this really is a machine property.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++----
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 target/s390x/cpu-sysemu.c          |  8 --------
 target/s390x/cpu.h                 |  1 -
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f4c4433b23..749d46e700 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -45,6 +45,7 @@
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
 #include "hw/s390x/cpu-topology.h"
+#include "kvm/kvm_s390x.h"
 #include CONFIG_DEVICES
 
 static Error *pv_mig_blocker;
@@ -121,12 +122,16 @@ static void subsystem_reset(void)
     }
 }
 
-static void set_memory_limit(uint64_t new_limit)
+static void s390_set_memory_limit(S390CcwMachineState *s390ms,
+                                  uint64_t new_limit)
 {
     uint64_t hw_limit;
-    int ret;
+    int ret = 0;
 
-    ret = s390_set_memory_limit(new_limit, &hw_limit);
+    assert(!s390ms->memory_limit && new_limit);
+    if (kvm_enabled()) {
+        ret = kvm_s390_set_mem_limit(new_limit, &hw_limit);
+    }
     if (ret == -E2BIG) {
         error_report("host supports a maximum of %" PRIu64 " GB",
                      hw_limit / GiB);
@@ -135,10 +140,19 @@ static void set_memory_limit(uint64_t new_limit)
         error_report("setting the guest size failed");
         exit(EXIT_FAILURE);
     }
+    s390ms->memory_limit = new_limit;
+}
+
+uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
+{
+    /* We expect to be called only after the limit was set. */
+    assert(s390ms->memory_limit);
+    return s390ms->memory_limit;
 }
 
 static void s390_memory_init(MachineState *machine)
 {
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(machine);
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = machine->ram;
     uint64_t ram_size = memory_region_size(ram);
@@ -154,7 +168,7 @@ static void s390_memory_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    set_memory_limit(ram_size);
+    s390_set_memory_limit(s390ms, ram_size);
 
     /* Map the initial memory. Must happen after setting the memory limit. */
     memory_region_add_subregion(sysmem, 0, ram);
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 996864a34e..eb04542979 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -29,10 +29,13 @@ struct S390CcwMachineState {
     bool dea_key_wrap;
     bool pv;
     uint8_t loadparm[8];
+    uint64_t memory_limit;
 
     SCLPDevice *sclp;
 };
 
+uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms);
+
 #define S390_PTF_REASON_NONE (0x00 << 8)
 #define S390_PTF_REASON_DONE (0x01 << 8)
 #define S390_PTF_REASON_BUSY (0x02 << 8)
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 1cd30c1d84..3118a25fee 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -255,14 +255,6 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return s390_count_running_cpus();
 }
 
-int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_set_mem_limit(new_limit, hw_limit);
-    }
-    return 0;
-}
-
 void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
 {
     if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5ef61b1f75..b4506539f0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -881,7 +881,6 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
 
 /* cpu.c */
 void s390_crypto_reset(void);
-int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
 void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
-- 
2.46.1


