Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52452C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2ir-0001H0-IE; Mon, 03 Mar 2025 05:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp2iN-0001D5-W2; Mon, 03 Mar 2025 05:08:09 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp2iJ-0003Ds-Vx; Mon, 03 Mar 2025 05:07:58 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2feb91a25bdso5016967a91.1; 
 Mon, 03 Mar 2025 02:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740996471; x=1741601271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xd66omHNK7ev0/glEwTCxxD6meGDUkOt6mpT1wI9J5Q=;
 b=XcdzipGFcCJrMIxypNeGx44TniYfm4mO3nLi2cxgVSfkJo1nEQwi8gbqnQcQp5wvlT
 svXVwqTu2qkJ0Yk8JEJ4Q/jpCFuwwkSii9wGYf63RXuXAoJ6vpKM1nPJsXGf7DuFN0lX
 degQzegFsbbJMMvX2Fmctnc1dLyTLCz2+nQSM3ubev9Yqq/gLJ3qmAsami5rmP3C+lKN
 fASjW8hl9h6dp6by82cMn+KarIhKxN824iwAmuTh7mmGoXY3w5QMx4SVOMV0+IgVLrPf
 578sz9+GOE+hl+YUnBsL8dwvd5o94YrwGS6TEBUczgHKbk9VeZ87jVGojQI0j5Vpl4r3
 v3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740996471; x=1741601271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xd66omHNK7ev0/glEwTCxxD6meGDUkOt6mpT1wI9J5Q=;
 b=M5hCnUtJ2vCgozAJQHpApPFRdczuiNoJbdXpH+hUmhIBqvm+0UoVvP+0YwaObcdVH4
 SAVf7RThJ0Y7PyatbJf7e1tzxxVIBVA4J+j7IRM0eiF2QhBPyBTMZQufW+I2HzxcPtvu
 dQYLq6hKghl2pMBWQUqc+yMjbXTMERwlobEWlgXmKeeVz4HDGNV4tW5IaIvvlXm0PvO9
 fEeCPA5U+Ho52nJdBbohdqnYRmIGX3gPpXfwbuRCNT5HYZY9OG0ZjMKY7pgaxLk51Mb/
 qVhUbrSZyz/Bg2EE8KeZgQj3vXsTrZIicWCLudZJEL027psHLioxy4JbNAKEC3HovgqE
 GM9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdCwfalsSosji1J4eFxZ2JGxuodQaOciLh9DtIAJJngeuIPcDmhJvCBKQdXWHtY3zA1jgWxzfFsX4K@nongnu.org
X-Gm-Message-State: AOJu0YyeSHZnkTmTo//FBaaJx25Wit6b9Gd87FpgPgivnTSdxKhhuy27
 4oyeJCy+Sc49QDYBBySmrWQjc2C0RDNUv/lHAJYOTOiEi8dfVJyWJEyJXA==
X-Gm-Gg: ASbGncs6avAHaEcYL6eVET3qQXKRV+QYAZBtjVXZelSS67woCLEszDXYm2o3IPK6CYa
 OVsW/bFZ4ZVrptnsHjRdB/Rpnqu3YABCu3W+eZniyYj1mgFHQdOml06F8HwrgK6zEyTjCX7YT3f
 fjZQ9ADSke/+s7P1ygou1f/AMndt5AScAZv3LqaciMqysHzOCr9KOU65bFQ6jK9S0lJKmzmEaf5
 aQVN/uhayCYv1A6IsoFCuAXMur/DZy9bulAMrHBMo/osaXfQx2flyEO58psE/6U5FUJB5f6eJcu
 FeF70MNdXdgov9TqolCR3eIU8p2onDlVTzCfJ7PXDTYguzo1Klo=
X-Google-Smtp-Source: AGHT+IELzAgnAvqAYo95llqguI2UGD3I8UgV3N182MKM7uOOwlbkxCxHHV5hBjkEq9wv0ymg8qZ+GQ==
X-Received: by 2002:a17:90b:3a4c:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-2febaa861e5mr23275909a91.0.1740996470911; 
 Mon, 03 Mar 2025 02:07:50 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a7ddesm8539779a91.27.2025.03.03.02.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:07:50 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 2/3] hw/core/numa: add attribute to skip creation of
 MachineState.ram region
Date: Mon,  3 Mar 2025 20:07:31 +1000
Message-ID: <20250303100732.576457-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303100732.576457-1-npiggin@gmail.com>
References: <20250303100732.576457-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

NUMA machines with sparse address topologies do not want all NUMA
regions packed densely inside the MachineState.ram container region.
Add a machine class attribute that skips creating this container
region. Individual NUMA memory device regions are recorded in NodeInfo
where the machine init can add them to the system address space itself.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/boards.h   |  6 ++++++
 include/system/numa.h |  1 +
 hw/core/numa.c        | 44 +++++++++++++++++++++++++++++++++++--------
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 9360d1ce394..9e6654ee9ca 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -233,6 +233,11 @@ typedef struct {
  *    is not needed.
  * @numa_mem_supported:
  *    true if '--numa node.mem' option is supported and false otherwise
+ * @numa_skip_ram_container:
+ *    If false, numa memory init creates the MachineState.ram memory region
+ *    with all numa node regions packed densely within it. If true, the .ram
+ *    region is not created. Machines can use this e.g., to place NUMA
+ *    regions sparsely within the address space.
  * @hotplug_allowed:
  *    If the hook is provided, then it'll be called for each device
  *    hotplug to check whether the device hotplug is allowed.  Return
@@ -311,6 +316,7 @@ struct MachineClass {
     bool nvdimm_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
+    bool numa_skip_ram_container;
     bool cpu_cluster_has_numa_boundary;
     SMPCompatProps smp_props;
     const char *default_ram_id;
diff --git a/include/system/numa.h b/include/system/numa.h
index 1044b0eb6e9..001e872d33e 100644
--- a/include/system/numa.h
+++ b/include/system/numa.h
@@ -38,6 +38,7 @@ enum {
 typedef struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
+    MemoryRegion *node_mr;
     bool present;
     bool has_cpu;
     bool has_gi;
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 218576f7455..d84b2d70849 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -623,19 +623,46 @@ static void complete_init_numa_distance(MachineState *ms)
     }
 }
 
-static void numa_init_memdev_container(MachineState *ms, MemoryRegion *ram)
+/*
+ * Consume all NUMA memory backends and store the regions in NodeInfo.node_mr.
+ */
+static void numa_init_memdev(MachineState *ms)
 {
     int i;
-    uint64_t addr = 0;
 
     for (i = 0; i < ms->numa_state->num_nodes; i++) {
-        uint64_t size = ms->numa_state->nodes[i].node_mem;
         HostMemoryBackend *backend = ms->numa_state->nodes[i].node_memdev;
         if (!backend) {
             continue;
         }
         MemoryRegion *seg = machine_consume_memdev(ms, backend);
-        memory_region_add_subregion(ram, addr, seg);
+        ms->numa_state->nodes[i].node_mr = seg;
+    }
+}
+
+/*
+ * Consume all NUMA memory backends as with numa_init_memdev, packing them
+ * densely into a MachineState.ram "container" region.
+ */
+static void numa_init_memdev_container(MachineState *ms)
+{
+    int i;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    uint64_t addr = 0;
+
+    ms->ram = g_new(MemoryRegion, 1);
+    memory_region_init(ms->ram, OBJECT(ms), mc->default_ram_id,
+                       ms->ram_size);
+
+    numa_init_memdev(ms);
+
+    for (i = 0; i < ms->numa_state->num_nodes; i++) {
+        uint64_t size = ms->numa_state->nodes[i].node_mem;
+        MemoryRegion *seg = ms->numa_state->nodes[i].node_mr;
+        if (!seg) {
+            continue;
+        }
+        memory_region_add_subregion(ms->ram, addr, seg);
         addr += size;
     }
 }
@@ -706,10 +733,11 @@ void numa_complete_configuration(MachineState *ms)
                              " properties are mutually exclusive");
                 exit(1);
             }
-            ms->ram = g_new(MemoryRegion, 1);
-            memory_region_init(ms->ram, OBJECT(ms), mc->default_ram_id,
-                               ms->ram_size);
-            numa_init_memdev_container(ms, ms->ram);
+            if (mc->numa_skip_ram_container) {
+                numa_init_memdev(ms);
+            } else {
+                numa_init_memdev_container(ms);
+            }
         }
         /* QEMU needs at least all unique node pair distances to build
          * the whole NUMA distance table. QEMU treats the distance table
-- 
2.47.1


