Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55CDCEF14D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7ss-0001WZ-Ky; Tue, 08 Oct 2024 06:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7sT-0001Qa-Os
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7sM-0001fZ-9o
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728384933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nbvv/EzKjF6TygpGepePY6Bd6hGXC8yUwfGazr6G6c=;
 b=cvQ+W6haue1y5sTwpeRm5mOgzjayEJLEwEBeVMHPIuphe1kenK2Ha4D3yO3FRf2kHf2Rt+
 Hg4W6vgEUx4Y1Jp/qQK/watVYNyL4YfYPu4QJLF5wtl8UyzgEzjE53MGv+cbxxfu3V/tHS
 IQ3fcDIIo8ADmJayOn4JWcJ4hvz/e8E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-by4KUbElNHyN5e_QT2IEWw-1; Tue,
 08 Oct 2024 06:55:32 -0400
X-MC-Unique: by4KUbElNHyN5e_QT2IEWw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D105A1956064; Tue,  8 Oct 2024 10:55:30 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4860F19560A3; Tue,  8 Oct 2024 10:55:26 +0000 (UTC)
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
Subject: [PATCH v2 05/14] s390x/s390-virtio-ccw: move setting the maximum
 guest size from sclp to machine code
Date: Tue,  8 Oct 2024 12:54:46 +0200
Message-ID: <20241008105455.2302628-6-david@redhat.com>
In-Reply-To: <20241008105455.2302628-1-david@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

Nowadays, it feels more natural to have that code located in
s390_memory_init(), where we also have direct access to the machine
object.

While at it, use the actual RAM size, not the maximum RAM size which
cannot currently be reached without support for any memory devices.
Consequently update s390_pv_vm_try_disable_async() to rely on the RAM size
as well, to avoid temporary issues while we further rework that
handling.

set_memory_limit() is temporary, we'll merge it with
s390_set_memory_limit() next.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 28 ++++++++++++++++++++++++----
 hw/s390x/sclp.c            | 11 -----------
 target/s390x/kvm/pv.c      |  2 +-
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 77f5d22203..f4c4433b23 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -121,11 +121,29 @@ static void subsystem_reset(void)
     }
 }
 
-static void s390_memory_init(MemoryRegion *ram)
+static void set_memory_limit(uint64_t new_limit)
+{
+    uint64_t hw_limit;
+    int ret;
+
+    ret = s390_set_memory_limit(new_limit, &hw_limit);
+    if (ret == -E2BIG) {
+        error_report("host supports a maximum of %" PRIu64 " GB",
+                     hw_limit / GiB);
+        exit(EXIT_FAILURE);
+    } else if (ret) {
+        error_report("setting the guest size failed");
+        exit(EXIT_FAILURE);
+    }
+}
+
+static void s390_memory_init(MachineState *machine)
 {
     MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *ram = machine->ram;
+    uint64_t ram_size = memory_region_size(ram);
 
-    if (!QEMU_IS_ALIGNED(memory_region_size(ram), 1 * MiB)) {
+    if (!QEMU_IS_ALIGNED(ram_size, 1 * MiB)) {
         /*
          * SCLP cannot possibly expose smaller granularity right now and KVM
          * cannot handle smaller granularity. As we don't support NUMA, the
@@ -136,7 +154,9 @@ static void s390_memory_init(MemoryRegion *ram)
         exit(EXIT_FAILURE);
     }
 
-    /* allocate RAM for core */
+    set_memory_limit(ram_size);
+
+    /* Map the initial memory. Must happen after setting the memory limit. */
     memory_region_add_subregion(sysmem, 0, ram);
 
     /*
@@ -217,7 +237,7 @@ static void ccw_init(MachineState *machine)
     qdev_realize_and_unref(DEVICE(ms->sclp), NULL, &error_fatal);
 
     /* init memory + setup max page size. Required for the CPU model */
-    s390_memory_init(machine->ram);
+    s390_memory_init(machine);
 
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index e725dcd5fd..fac09816bf 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -381,10 +381,7 @@ void sclp_service_interrupt(uint32_t sccb)
 /* qemu object creation and initialization functions */
 static void sclp_realize(DeviceState *dev, Error **errp)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
     SCLPDevice *sclp = SCLP(dev);
-    uint64_t hw_limit;
-    int ret;
 
     /*
      * qdev_device_add searches the sysbus for TYPE_SCLP_EVENTS_BUS. As long
@@ -394,14 +391,6 @@ static void sclp_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(sclp->event_facility), errp)) {
         return;
     }
-
-    ret = s390_set_memory_limit(machine->maxram_size, &hw_limit);
-    if (ret == -E2BIG) {
-        error_setg(errp, "host supports a maximum of %" PRIu64 " GB",
-                   hw_limit / GiB);
-    } else if (ret) {
-        error_setg(errp, "setting the guest size failed");
-    }
 }
 
 static void sclp_memory_init(SCLPDevice *sclp)
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index dde836d21a..424cce75ca 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -133,7 +133,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
      * If the feature is not present or if the VM is not larger than 2 GiB,
      * KVM_PV_ASYNC_CLEANUP_PREPARE fill fail; no point in attempting it.
      */
-    if ((MACHINE(ms)->maxram_size <= 2 * GiB) ||
+    if ((MACHINE(ms)->ram_size <= 2 * GiB) ||
         !kvm_check_extension(kvm_state, KVM_CAP_S390_PROTECTED_ASYNC_DISABLE)) {
         return false;
     }
-- 
2.46.1


