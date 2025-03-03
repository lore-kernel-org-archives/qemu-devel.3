Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621A5C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2in-0001FP-79; Mon, 03 Mar 2025 05:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp2iP-0001DJ-Pa; Mon, 03 Mar 2025 05:08:09 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp2iL-0003EX-Pq; Mon, 03 Mar 2025 05:08:01 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fe82414cf7so8258466a91.0; 
 Mon, 03 Mar 2025 02:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740996475; x=1741601275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/sa2uc6or1aHtVvQRaym8GaDvBwv+dby+++CN327KM=;
 b=UgvwSdnUR2PbbHx8UqK5hbmKyRTAyvbQwurcAxwPbPRcDLZYiIQPVQEaUgyJVsAaD0
 /aCYfnCY2A4/uFMSW87vLM6fioz5ItnjcpBJJTsw82whifdolbs3kB8h3iBFW3RrNnFK
 DpEkQrHdWcUK6LIH69ddHOELm0yvAy0hvq/i9n1TYML/ur8OXjh1NFqGpVb24Yqzqqti
 y5qi5sd4HG6b9qqUWc2/VnfVOLiDz6ginMcu7ukInBDXNw5l1PWW5VCuMHtai+R/yMdp
 Ho/A4TFahSSn+Hxtxv4T++O7ijYs05DNFWly6bPYZjt2qsbmEBH8XAvj2b+E9hIJ0lOo
 Y/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740996475; x=1741601275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/sa2uc6or1aHtVvQRaym8GaDvBwv+dby+++CN327KM=;
 b=lQ0gPEzRduniw1xjMFbW28XEDRll16aXsdPrKALmwaAEs8SJFczRIoSit1YWEE562B
 zS6lh0buFKC1TKKO0ui831bFauJ+N4VGgVGK1wSrCgEcDM7HeQIo0bDu5qHVN9RuHM7a
 9ubeNDmIHL39E0gtJg5IWr48NUXPRhvQEu9KTIKz1b+GAqIuy4w7BjbwWTxWxhMQreQb
 xW5wQ7qLex3z3dSjPoQMySFWgMGms6cZOTkSr/cgazMuvrAMfvtZ5fj5y+wK+KGaibRs
 wYCloGuGXXJGEYI4BMLI9whWcTpFo+SN/h6dzsQGH66NJWuhaZCcfA/IQnDQXkIlXfQp
 LaJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVSzUcqsvmMSnfO2p32rzg9iftVH3dl+Pm2NF3kDthqDh6yP5ILA8DlDqOU7XHNd2t4gVenKRRXCo9@nongnu.org
X-Gm-Message-State: AOJu0YwnBGsbCQgLYkz66l65PtdBpMBq3rQFdGKBVg4znFFqtpc1lVom
 nbS5rFarv7jH+lQvGUxq7GRhiHEY34lSeKlticYEXPh3+f0HsloHC2dXQg==
X-Gm-Gg: ASbGncuuE6QRZ6XMm6wCDS8mMFLGMwxGvZqhmzqed1MofHZdOJCQ6Uq5tRXXl518v5p
 3YAd+7MT2Jwd4sn4ptpM/TAHMAcRm01E8eLhStEBH7CFlZtZDhXmT6a4efwhoy227PrOft0pDWP
 cC5bP2n6CiHFfLw1lA6U5eQ47eTi+ECwK2iPq3oPrApSWaN6NJdW8TyQQkRXBF3IEYEcuMjwq4w
 HujBOHU5+wcZ8pnbG8DQAMtWb4z1MdyvH+mVj27uZu48l66JfLw1M9MDwwW+bkKoussNv5ZrbUn
 N+7k+IFH3Sr0R/JsMCaoakcGYKGVKuhWbIjRyHvhP9q7o6K4puk=
X-Google-Smtp-Source: AGHT+IFoACEcmG+tdYphPQmFkTUd4jDuwORcnI1sdYpXaHN8bcxvLxBXvARrul/ZsoVFawWvO9Po4Q==
X-Received: by 2002:a17:90b:2786:b0:2ee:ab11:fab2 with SMTP id
 98e67ed59e1d1-2febabedbd6mr16537625a91.22.1740996475369; 
 Mon, 03 Mar 2025 02:07:55 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a7ddesm8539779a91.27.2025.03.03.02.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:07:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 3/3] ppc/pnv: Enable sparse chip RAM memory addresses
Date: Mon,  3 Mar 2025 20:07:32 +1000
Message-ID: <20250303100732.576457-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303100732.576457-1-npiggin@gmail.com>
References: <20250303100732.576457-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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

Power CPUs place RAM memory regions for each chip (NUMA node) at
fixed locations in the real address space, resulting in a sparse
(disjoint) RAM address layout.

Use the new NUMA machine class attribute numa_skip_ram_container to
allow pnv machine init to lay out NUMA node memory regions into the
system address space in the proper location rather than packing them
densely from address 0.

With the following options:

  -smp 2,sockets=2 -m 4g
  -object memory-backend-ram,size=2G,id=mem0
  -object memory-backend-ram,size=2G,id=mem1
  -numa node,nodeid=0,memdev=mem0,cpus=0
  -numa node,nodeid=1,memdev=mem1,cpus=1

Linux (PowerNV) now boots with:

  node   0: [mem 0x0000000000000000-0x000000007fffffff]
  node   1: [mem 0x0000100000000000-0x000010007fffffff]

Prior to this change:

  node   0: [mem 0x0000000000000000-0x000000007fffffff]
  node   1: [mem 0x0000000000000000-0x00000000ffffffff]

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5f2041f7f9d..b6308593335 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -966,7 +966,24 @@ static void pnv_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
+    if (machine->ram) {
+        memory_region_add_subregion(get_system_memory(), 0, machine->ram);
+    } else if (machine->numa_state) {
+        for (i = 0; i < machine->numa_state->num_nodes; i++) {
+            MemoryRegion *mr = machine->numa_state->nodes[i].node_mr;
+
+            /*
+             * powernv uses numa_mem_align_shift to derive the base RAM address
+             * for each chip addr = Chip Number << shift.
+             */
+            chip_ram_start = (uint64_t)i << mc->numa_mem_align_shift;
+            if (!mr) {
+                continue;
+            }
+            memory_region_add_subregion(get_system_memory(), chip_ram_start,
+                                        mr);
+        }
+    }
 
     /*
      * Create our simple PNOR device
@@ -1100,20 +1117,30 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
+    chip_ram_start = 0;
     pnv->chips = g_new0(PnvChip *, pnv->num_chips);
     for (i = 0; i < pnv->num_chips; i++) {
         char chip_name[32];
         Object *chip = OBJECT(qdev_new(chip_typename));
-        uint64_t chip_ram_size =  pnv_chip_get_ram_size(pnv, i);
+        uint64_t chip_ram_size;
 
         pnv->chips[i] = PNV_CHIP(chip);
 
+        if (machine->numa_state) {
+            chip_ram_start = (uint64_t)i << mc->numa_mem_align_shift;
+            chip_ram_size = machine->numa_state->nodes[i].node_mem;
+        } else {
+            chip_ram_size =  pnv_chip_get_ram_size(pnv, i);
+        }
+
         /* Distribute RAM among the chips  */
         object_property_set_int(chip, "ram-start", chip_ram_start,
                                 &error_fatal);
         object_property_set_int(chip, "ram-size", chip_ram_size,
                                 &error_fatal);
-        chip_ram_start += chip_ram_size;
+        if (!machine->numa_state) {
+            chip_ram_start += chip_ram_size;
+        }
 
         snprintf(chip_name, sizeof(chip_name), "chip[%d]", i);
         object_property_add_child(OBJECT(pnv), chip_name, chip);
@@ -2680,6 +2707,7 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER8";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
+    mc->numa_mem_align_shift = 42;
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
     xic->icp_get = pnv_icp_get;
@@ -2709,6 +2737,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER9";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
+    mc->numa_mem_align_shift = 42;
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
     xfc->match_nvt = pnv_match_nvt;
@@ -2747,6 +2776,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
     };
 
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
+    mc->numa_mem_align_shift = 44;
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
     mc->alias = "powernv";
@@ -2951,6 +2981,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
 
     mc->numa_mem_supported = true;
     mc->auto_enable_numa = true;
+    mc->numa_skip_ram_container = true;
 
     mc->cpu_index_to_instance_props = pnv_cpu_index_to_props;
     mc->get_default_cpu_node_id = pnv_get_default_cpu_node_id;
-- 
2.47.1


