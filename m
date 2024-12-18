Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3B0E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNri9-0001Ba-Du; Wed, 18 Dec 2024 05:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrht-0000o4-D6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrho-00072X-W8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96QA+3QUnhA5HLSyZnMcgqoHbzkb3vZ+SomK19wOjd8=;
 b=U1xD9eW0zmqbu/V/S402/DcLhDsAFG5tOkvo5o/hxgvHTgBVfCoSTwr4SepGL6R+jrSWNN
 CGdWzQYKve0aUU1Hc8ZksSbTQfoJl/sghheUZi7FIy4hPzlfXshwxP7iYbJzwZ+318h8N6
 amtk5VCMinimFc9ObgxRfBdNDi/yYyo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-G-JOUg3LMBOu4H46irXEXw-1; Wed, 18 Dec 2024 05:53:24 -0500
X-MC-Unique: G-JOUg3LMBOu4H46irXEXw-1
X-Mimecast-MFC-AGG-ID: G-JOUg3LMBOu4H46irXEXw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso18777415e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519203; x=1735124003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96QA+3QUnhA5HLSyZnMcgqoHbzkb3vZ+SomK19wOjd8=;
 b=D6iSCUWRmpuUvOvKBCLXUODMDOuyarhDEQ4q25HTt6ScVLSxDm6BHN34Thcf7IWksd
 5h2jFGBcHZyiOBmeyYPI3VApshgw2+Q7V/VePS7ODfy8DnzIQQgkyXDmwopsd2g03ftj
 hYt3MWTUuVXLaEL24I7xcEOTHg7DzMB+8gDfm+qY2hG8cITyNEJoB/ue+DCHR/lWMZjN
 uNeQVbJyYBB9Wu9fPPwymJdZ8AtDNGxiDbj93tmLAPuXhScfOuqSr3khdakJL35mA+j/
 gPp98Bvrhh7kD3dtI9s5LsbhTYbkielHC142E64o+30UuyghHIdj1g8fQ+aNPuXbAcTz
 vgzw==
X-Gm-Message-State: AOJu0YySZtN9naQLeyDBg1grYdH9Uka5Am06MiCylSA2ngy7ByraB4iK
 xG6EhfGNh7gk8UIau1mV9aAl6uc2NMDyX5qFRY9IcgnbWYGdpQemYqsHiFjLlZAhag0rXDf5mIX
 iwF48kXeWtGN8D7zlQ/xiP5fc3tBUghW52N/3Ysrn/Sg4zL8KL2c3laDs4atwMo/ks+RfpOjzLC
 lXSmVZztV0lSKuZB4gr//98lCvXW7ucpivps4=
X-Gm-Gg: ASbGncsChXmnBs4l9dEpAiJL/68qXw/Z8HqLuYIRw2PeGj/y4XMmRHeZrmM59uHg4yo
 zxzuJ0s3otr9bygCq/abwWd7b6mn8Fpkmw3R0f0aLqUqrgzYIJ2LJ9tluOlmPcBmu8ZoL7TV0kR
 lawC5391mcysQWKcJOvplzaKpvY3olDEDbTD8ZseTVNbSySVzTqFkN7gYC0TdH37Dlqf0WRfH4h
 bm5ISyeFU3mXjX1mXYrheK8EXE5v/aVEDo+gSy9eUdR0GgGzppNlRtFrbSJ1vo+RbuqpYFNXC9N
 txDdyMR8JpKjvvFTN31av8ewwpA/f5E2kWw3zyIfOw==
X-Received: by 2002:a05:600c:4709:b0:434:a1d3:a331 with SMTP id
 5b1f17b1804b1-436553f69d3mr16509605e9.22.1734519202783; 
 Wed, 18 Dec 2024 02:53:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvbcNQmU26ZX9roj7iZeQAQiydNF4z8Xv3VrfnSeTBvb+C6hkuHhZFIn6257i3zaR4zD8HCQ==
X-Received: by 2002:a05:600c:4709:b0:434:a1d3:a331 with SMTP id
 5b1f17b1804b1-436553f69d3mr16509325e9.22.1734519202304; 
 Wed, 18 Dec 2024 02:53:22 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656af6d02sm16987005e9.1.2024.12.18.02.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:21 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 06/15] s390x/s390-virtio-ccw: move setting the maximum guest
 size from sclp to machine code
Date: Wed, 18 Dec 2024 11:52:54 +0100
Message-ID: <20241218105303.1966303-7-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Message-ID: <20241008105455.2302628-6-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 28 ++++++++++++++++++++++++----
 hw/s390x/sclp.c            | 11 -----------
 target/s390x/kvm/pv.c      |  2 +-
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b0edaa0872..a28e615c5a 100644
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
@@ -211,7 +231,7 @@ static void ccw_init(MachineState *machine)
     qdev_realize_and_unref(DEVICE(ms->sclp), NULL, &error_fatal);
 
     /* init memory + setup max page size. Required for the CPU model */
-    s390_memory_init(machine->ram);
+    s390_memory_init(machine);
 
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 8757626b5c..73e88ab4eb 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -376,10 +376,7 @@ void sclp_service_interrupt(uint32_t sccb)
 /* qemu object creation and initialization functions */
 static void sclp_realize(DeviceState *dev, Error **errp)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
     SCLPDevice *sclp = SCLP(dev);
-    uint64_t hw_limit;
-    int ret;
 
     /*
      * qdev_device_add searches the sysbus for TYPE_SCLP_EVENTS_BUS. As long
@@ -389,14 +386,6 @@ static void sclp_realize(DeviceState *dev, Error **errp)
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
2.47.1


