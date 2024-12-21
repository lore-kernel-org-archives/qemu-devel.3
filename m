Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D484E7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53d-0002PG-IC; Sat, 21 Dec 2024 14:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53c-0002P1-Fb
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53a-0000Ch-V4
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ix5+P2+O/8/1G7e8VURHN6Qpsguw8mKubl01oxtB8Go=;
 b=QKcuZI/eS+6jgVI6ZcPYRNtw5sV1F1HU1W6RC2VPmjakP196HRKFYoSO4JsVegs2GiMcEf
 2ZJgw9lz3EH/eQJq22UqxnXzJml3csY80Gc1aXe90h+weqnXVFXeCJx+Zvvl90FxqNO/jf
 3Ia7OepdW2hnoRSncR6PQ8pn2rWT100=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-Q0ZdrfWoORmZe3oxH_RcwQ-1; Sat, 21 Dec 2024 14:22:30 -0500
X-MC-Unique: Q0ZdrfWoORmZe3oxH_RcwQ-1
X-Mimecast-MFC-AGG-ID: Q0ZdrfWoORmZe3oxH_RcwQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385df115288so1411033f8f.2
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808949; x=1735413749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ix5+P2+O/8/1G7e8VURHN6Qpsguw8mKubl01oxtB8Go=;
 b=Ae5VLXeNBMyiJVhdFcWn5fxxOukvSl3q5sJRCznQOdV3ryskAwW3CfKmENiEE2i6AQ
 okHQ0Q7xBU1krVmZr9P82ynKWS5wjZe1SQHtPp4wTcFBWdGVgczE1nZNXVjexscXFBNR
 8QzxVu1Hdv9cIl1Y1MAf6KddEFB5tHW/J1rh52PzBCfx0Z4kbgqS+hc0e7RBv7rvRuSV
 1xRRMsdPZeFA+ndrU/mzPuQq3ErhTrXksM2njZiBiQkWySk/htVfu+dfSYBpqQcbwv0D
 4kk3tH8dMScXV3riynZHEaJx/O9PserF3JuwsZD8TT3iANBQVbVQUthIefcdPwt3rfKe
 NaLQ==
X-Gm-Message-State: AOJu0Yzbg4DQ701agnrpg8/WE6wSRBrEU0WQta72AHGRoRpJq9j9tPUy
 1kh6YhBVAPdekfkEsJbACcFgOtp98lrzqVvY0FvyAhDteSiap4fuXlTY1jrhla3yNMdTE6h/Ecp
 wMxA2RTGB1SqvvhtZzV8Ha9u3oWftsESiHfTrfo3qIkJORie0xikYEAAXsSG7LlpMcPpHalRxdf
 psu+yr9YIHUXYkhM6LaXGCD+VsSFIETYUG
X-Gm-Gg: ASbGnctgaRo4dvPcgwDWCKYpF9cqL07tHYgkz6FwsTqcduDf5PkmTpFYzfN+ONQ/ZEM
 GlaCSsSdv6o0u7nbG7t5dKAgGM8bv1PhD1HsIq6p1ZAnjRsMU/zqL/OjaBea2+U69QDQpAUaWfC
 bIQz2Bm1f/dUv94n+tI6cR7XImOzGqztafj93CpM85itxwCSntqt180z6NdXPEh9uR995V6tTRq
 Mq8pAZ9MWi4OXHw6GmE1GZHeEATlw6VOJ4QLkk3qyJudn0Lba5Qsxurz00QCQGvXvaVbKqHfum8
 mHLlUcJbD+umin+afc0SsX2KMzqc6nMFoRpfL0o=
X-Received: by 2002:a5d:5f4f:0:b0:386:391e:bc75 with SMTP id
 ffacd0b85a97d-38a221fa986mr5966806f8f.16.1734808949260; 
 Sat, 21 Dec 2024 11:22:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEl5W9lgAiXWZ6dKwCSh+jjhDP/OEEi+VRKig3aNjXEkqBHiYT2xdCpOBjqVYkPLi47AbopeA==
X-Received: by 2002:a5d:5f4f:0:b0:386:391e:bc75 with SMTP id
 ffacd0b85a97d-38a221fa986mr5966787f8f.16.1734808948814; 
 Sat, 21 Dec 2024 11:22:28 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38a1c89e375sm7247774f8f.73.2024.12.21.11.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:28 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 06/15] s390x/s390-virtio-ccw: move setting the maximum guest
 size from sclp to machine code
Date: Sat, 21 Dec 2024 20:22:00 +0100
Message-ID: <20241221192209.3979595-7-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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

Message-ID: <20241219144115.2820241-6-david@redhat.com>
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


