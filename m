Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A955C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUm2-0006GH-2F; Mon, 29 Jan 2024 11:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUlQ-0005yF-EV
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:45:42 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUlM-0003ca-V2
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:45:39 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so39652225e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546732; x=1707151532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2hw1LeDHPXoA09+Z2wFdjf4GaaZ4oIVM8gsKnpZLbQ=;
 b=gwoiazBHhZMVC4So9zi88B80lq+tj2B+Hg+BDQGHoU2SA70OpRJYX0T5Nuz98/B+By
 b/ImwaLRaGdTkL4KupS2+KEQKaMcd2d//Vb6MtmxFFtRVieHEB1cpucrR4aEAsiOHaWx
 ucn4c16yIG3IcUOlT+7wYLy75UvbJu5efD86uF3mYgqFX1eTRNikdkayq//LH/H3Kahh
 uimHvnT4A2t7A09XKsouby7sGQlwo6IpqBkh2v1/qPFuvnFMWAD+lr+n111q/kHc5XCH
 4mMLZjZmtR3LPimuGyNkRUMSp9W8Q+6N4qpIywYwq+VYswEjGI3YF8njQLTUIS1h8dzd
 X4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546732; x=1707151532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2hw1LeDHPXoA09+Z2wFdjf4GaaZ4oIVM8gsKnpZLbQ=;
 b=BaU6mf4zfrdevqCXD4/VZJcfGFOYPnVCB53RYT4IaOaFSgL3MqKTTkCih0o8vWFf7L
 Yqv8rtzXD4HM2qoH0uXQdjn9pDQv7ZYulev4bZ207RkRBsfZNMi9Q2ai9JXjebvY5KhH
 yIwS4+iALfyAeTksxSczp9iZ97Z6Nn37DtUi/vsV9jcKd+f7ZlWbKuCSTdSf6H9KRBef
 K/p3y2BAAieRZgV/0UONew+cQop62ApAO5VeCO9xUeT4+v67w6o7a6owIInYdze6caXr
 /25u7NuFbQXdSCQH667DJQZPXQQqlM8bjVaP1xk3P8pvfBtNZnSczLf93INxhYc0W0nE
 L76A==
X-Gm-Message-State: AOJu0Yw2eZ8aNFTzOEEugHPQ3vQHBB8jXDxkXRIPVrdg2x+ZK3AE5uwn
 lVcFryg7Hwjcj8LUy6AZCl0u6EBSdjWLbM+JOaxylN30qTIkEwJC+RBBF3kPhfXxt68aOO8B1+C
 v
X-Google-Smtp-Source: AGHT+IFVrS1YJ9J2dLNRn+st1RiqDBXNn5RMuFWm57xrM1I/AzlVfdLqJZcKs7joGZxBzXAoy74ufw==
X-Received: by 2002:a05:600c:4e8c:b0:40e:e25c:41cf with SMTP id
 f12-20020a05600c4e8c00b0040ee25c41cfmr5163477wmq.12.1706546732132; 
 Mon, 29 Jan 2024 08:45:32 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 bs3-20020a056000070300b0033aeb7d4537sm3951432wrb.7.2024.01.29.08.45.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:45:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 02/29] hw/core: Declare CPUArchId::cpu as CPUState instead
 of Object
Date: Mon, 29 Jan 2024 17:44:44 +0100
Message-ID: <20240129164514.73104-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Do not accept any Object for CPUArchId::cpu field,
restrict it to CPUState type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h        | 2 +-
 hw/core/machine.c          | 4 ++--
 hw/i386/x86.c              | 2 +-
 hw/loongarch/virt.c        | 2 +-
 hw/ppc/spapr.c             | 5 ++---
 hw/s390x/s390-virtio-ccw.c | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index bcfde8a84d..8b8f6d5c00 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -120,7 +120,7 @@ typedef struct CPUArchId {
     uint64_t arch_id;
     int64_t vcpus_count;
     CpuInstanceProperties props;
-    Object *cpu;
+    CPUState *cpu;
     const char *type;
 } CPUArchId;
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index fb5afdcae4..854cf00a9b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -716,7 +716,7 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
     mc->possible_cpu_arch_ids(machine);
 
     for (i = 0; i < machine->possible_cpus->len; i++) {
-        Object *cpu;
+        CPUState *cpu;
         HotpluggableCPU *cpu_item = g_new0(typeof(*cpu_item), 1);
 
         cpu_item->type = g_strdup(machine->possible_cpus->cpus[i].type);
@@ -726,7 +726,7 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
 
         cpu = machine->possible_cpus->cpus[i].cpu;
         if (cpu) {
-            cpu_item->qom_path = object_get_canonical_path(cpu);
+            cpu_item->qom_path = object_get_canonical_path(OBJECT(cpu));
         }
         QAPI_LIST_PREPEND(head, cpu_item);
     }
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2b6291ad8d..19464ea971 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -221,7 +221,7 @@ void x86_cpu_plug(HotplugHandler *hotplug_dev,
     }
 
     found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
-    found_cpu->cpu = OBJECT(dev);
+    found_cpu->cpu = CPU(dev);
 out:
     error_propagate(errp, local_err);
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c9a680e61a..524a53de06 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -811,7 +811,7 @@ static void loongarch_init(MachineState *machine)
     for (i = 0; i < possible_cpus->len; i++) {
         cpu = cpu_create(machine->cpu_type);
         cpu->cpu_index = i;
-        machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
+        machine->possible_cpus->cpus[i].cpu = cpu;
         lacpu = LOONGARCH_CPU(cpu);
         lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e8dabc8614..0b77aa5514 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3985,7 +3985,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
     SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     SpaprCpuCore *core = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(dev);
-    CPUState *cs;
     SpaprDrc *drc;
     CPUArchId *core_slot;
     int index;
@@ -4019,7 +4018,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
         }
     }
 
-    core_slot->cpu = OBJECT(dev);
+    core_slot->cpu = CPU(dev);
 
     /*
      * Set compatibility mode to match the boot CPU, which was either set
@@ -4035,7 +4034,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
 
     if (smc->pre_2_10_has_unused_icps) {
         for (i = 0; i < cc->nr_threads; i++) {
-            cs = CPU(core->threads[i]);
+            CPUState *cs = CPU(core->threads[i]);
             pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
         }
     }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c99682b07d..69e39e13ff 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -324,7 +324,7 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
     ERRP_GUARD();
 
     g_assert(!ms->possible_cpus->cpus[cpu->env.core_id].cpu);
-    ms->possible_cpus->cpus[cpu->env.core_id].cpu = OBJECT(dev);
+    ms->possible_cpus->cpus[cpu->env.core_id].cpu = CPU(dev);
 
     if (s390_has_topology()) {
         s390_topology_setup_cpu(ms, cpu, errp);
-- 
2.41.0


