Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DDBC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2ir-0001HS-Lj; Mon, 03 Mar 2025 05:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp2iL-0001Cv-53; Mon, 03 Mar 2025 05:08:05 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp2iI-0003D2-Ua; Mon, 03 Mar 2025 05:07:56 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fea8d8c322so7641141a91.2; 
 Mon, 03 Mar 2025 02:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740996466; x=1741601266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8t3J5ob90+FnP0JXzgWqmqxURfMzfIJFtjvOoa/kNo=;
 b=FFGjmf2wi7qAcH9Q4bqApZrvLL7F5cwZwgZQL1VRLWh68+KoINHP8lKSPO2Vg92v2p
 QDde7c/WO119tegCdiB4gDa2bpx5NSmuGWMRywh/vR878XAIHfoqLunA0JR/Mz1gxVsr
 jWx2VbfhzYZ0aoSyes6JYOpm1OT7sa2fmBDWyZ2PhTQ3ef7yx2IuAu+WE8k5h5BQfyk/
 +NSyCkZkXJZAqgr4jhBMqQ05jOCwhbtwhEaeqVTHejbYDoaIhvbsvJ3RqARZwN73Aovf
 8Ygfmp982OEEOx19CF3UrGscFA5/Xl4h7ywbAgygluPArZ97JT+nuiGFERVMxMFuwl/g
 PGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740996466; x=1741601266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8t3J5ob90+FnP0JXzgWqmqxURfMzfIJFtjvOoa/kNo=;
 b=c1Z0bjbUwAfYDAjj/TehhL0D0xytPK4DIApECvEclDXzQpfsOy4gXVQJUPGA1gZXJb
 dcI89gMxN90FIhE+bvXsYWlMCkZHvkfX7nRFweN7j5nngZSbRILJjyFyBGS+h1SP+xXj
 apP7RHU0WtNpDuGT7uiS0OzE9IFwhVrPHvlVK25WadSqY9+/HS9SKGLifrzGZJJ5oyFe
 fhShgFc7B/smJ9qoW2I6GxTRmcq00T+HvnF1pnP1wzBcEsNjEwAn9jdGYTtjcHrTXMLH
 U5wYHHDH6sFKDelvWe/oGN4PVxDS4ytjGcTUBDzvRMnSQ0inYwO6XpqI2y+DL5a+Nz5F
 jwZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyGIoMfha2A3ufcto7z0IhggvHcGedFnn0RtI6P1hqjM+dD3Lv5X6wG8GwTR/NnLT7Lfh+7TyY3a2D@nongnu.org
X-Gm-Message-State: AOJu0YzsttjpjNLuol+1ucNnhS49hbl7ZILhslr6biWDMc5nefRCE2dN
 6GLDksTprSKpC7oMxzdgGufxcmR7bcb132dSHFg2y9x1pB7ghaGOScSb6g==
X-Gm-Gg: ASbGncu+Kt09cabOf7rJ8KLswZrPeZa6n24G3zrNA7u6KPF6QvgqaX6NIvFGxVxEo3U
 JcTrpnv2iQ5/6/2ngTJmWuj55fGQ3Vi18JyJd0b6le7aKI3Xjoq6mHLhL+3OZzzaE2KXB0i/55n
 jR0i57WIpekHzG5YLoATAYoKJCqcHLfkTW7ffU9sr9tY50Z+IlVY/TM3A8Ia8wJqHVIlwCGGyDa
 yN9HBBBMePFWKYVrqhPLGnJnDvO5BX1+2pa/VMpkCazzFBqkf95uLT947xyEooaOi5c9rpTMvaj
 NqmjAgIV7QfodR+IT8pIW27IGUVWe70H1kxwP9/U6xMMb4UClP0=
X-Google-Smtp-Source: AGHT+IHzSfE4fE1zFdFCLLYQZdCDCbKbGhtmAT8NHZXG+LRg2mssOD6Uh2QAAL8Isj+QvEPypC90eA==
X-Received: by 2002:a17:90b:1cc6:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-2febaa92594mr24335979a91.0.1740996466478; 
 Mon, 03 Mar 2025 02:07:46 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a7ddesm8539779a91.27.2025.03.03.02.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:07:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 1/3] ppc/pnv: Add support for NUMA configuration
Date: Mon,  3 Mar 2025 20:07:30 +1000
Message-ID: <20250303100732.576457-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303100732.576457-1-npiggin@gmail.com>
References: <20250303100732.576457-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Enable NUMA topology configuration for the powernv machine by
filling the necessary attributes and methods.

pnv_possible_cpu_arch_ids() runs before pnv_init(), so the hacky
big-core topology adjustment has to be moved there.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 101 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 11fd477b71b..5f2041f7f9d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1082,18 +1082,6 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
-    if (pnv->big_core) {
-        /*
-         * powernv models PnvCore as a SMT4 core. Big-core requires 2xPnvCore
-         * per core, so adjust topology here. pnv_dt_core() processor
-         * device-tree and TCG SMT code make the 2 cores appear as one big core
-         * from software point of view. pnv pervasive models and xscoms tend to
-         * see the big core as 2 small core halves.
-         */
-        machine->smp.cores *= 2;
-        machine->smp.threads /= 2;
-    }
-
     if (!is_power_of_2(machine->smp.threads)) {
         error_report("Cannot support %d threads/core on a powernv "
                      "machine because it must be a power of 2",
@@ -2865,6 +2853,87 @@ static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+/* find cpu slot in machine->possible_cpus by core_id */
+static CPUArchId *pnv_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
+{
+    int index = id / ms->smp.threads;
+
+    if (index >= ms->possible_cpus->len) {
+        return NULL;
+    }
+    if (idx) {
+        *idx = index;
+    }
+    return &ms->possible_cpus->cpus[index];
+}
+
+static CpuInstanceProperties
+pnv_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
+{
+    CPUArchId *core_slot;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    /* make sure possible_cpu are intialized */
+    mc->possible_cpu_arch_ids(machine);
+    /* get CPU core slot containing thread that matches cpu_index */
+    core_slot = pnv_find_cpu_slot(machine, cpu_index, NULL);
+    assert(core_slot);
+    return core_slot->props;
+}
+
+static const CPUArchIdList *pnv_possible_cpu_arch_ids(MachineState *machine)
+{
+    PnvMachineState *pnv = PNV_MACHINE(machine);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    unsigned int smp_cpus = machine->smp.cpus;
+    unsigned int smp_threads;
+    int max_cores;
+    int i;
+
+    if (pnv->big_core && !machine->possible_cpus) {
+        /*
+         * powernv models PnvCore as a SMT4 core. Big-core requires 2xPnvCore
+         * per core, so adjust topology here the first time it is called.
+         * pnv_dt_core() processor device-tree and TCG SMT code make the 2
+         * cores appear as one big core from software point of view. pnv
+         * pervasive models and xscoms tend to see the big core as 2 small core
+         * halves.
+         */
+        machine->smp.cores *= 2;
+        machine->smp.threads /= 2;
+    }
+
+    smp_threads = machine->smp.threads;
+    max_cores = machine->smp.max_cpus / smp_threads;
+
+    if (!mc->has_hotpluggable_cpus) {
+        max_cores = QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_threads;
+    }
+    if (machine->possible_cpus) {
+        assert(machine->possible_cpus->len == max_cores);
+        return machine->possible_cpus;
+    }
+
+    machine->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                             sizeof(CPUArchId) * max_cores);
+    machine->possible_cpus->len = max_cores;
+    for (i = 0; i < machine->possible_cpus->len; i++) {
+        int core_id = i * smp_threads;
+
+        machine->possible_cpus->cpus[i].type = machine->cpu_type;
+        machine->possible_cpus->cpus[i].vcpus_count = smp_threads;
+        machine->possible_cpus->cpus[i].arch_id = core_id;
+        machine->possible_cpus->cpus[i].props.has_core_id = true;
+        machine->possible_cpus->cpus[i].props.core_id = core_id;
+    }
+    return machine->possible_cpus;
+}
+
+static int64_t pnv_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    return idx / ms->smp.cores % ms->numa_state->num_nodes;
+}
+
 static void pnv_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2879,6 +2948,14 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->no_parallel = 1;
     mc->default_boot_order = NULL;
+
+    mc->numa_mem_supported = true;
+    mc->auto_enable_numa = true;
+
+    mc->cpu_index_to_instance_props = pnv_cpu_index_to_props;
+    mc->get_default_cpu_node_id = pnv_get_default_cpu_node_id;
+    mc->possible_cpu_arch_ids = pnv_possible_cpu_arch_ids;
+
     /*
      * RAM defaults to less than 2048 for 32-bit hosts, and large
      * enough to fit the maximum initrd size at it's load address
-- 
2.47.1


