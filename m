Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10FDE8305D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnASB-0002Dt-9v; Tue, 03 Feb 2026 02:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARx-00020x-Vp; Tue, 03 Feb 2026 02:03:51 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARv-0003EA-IC; Tue, 03 Feb 2026 02:03:49 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F3A660141;
 Tue,  3 Feb 2026 07:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13F4C19425;
 Tue,  3 Feb 2026 07:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770102218;
 bh=g4wSj2V6c1HLF8bCaTH2AO2uiIhDCllAUUFILdOy3vI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=F03r8Xxc36vZp2i+Z+RbQcjfKNvYddJdqiA7/XLQkmu7+sfWjOLnCM7JNegnK042O
 rzVvPAzCQddiodxPuVNBJysztaUIroXUwJg/YZV5gCz2OVab6EVQR0MS62OgpWf03Z
 AOAenfmTc59pg6bb8AcXJfY2O0qQagS951oOzxZyzalfGukCSJ7z309DhU+uu8rVR6
 o5qQpnP+lU7HW7WkRRr/V190SOZbBBSPCpaGTN/btL+PEQ1vwuTVkAKdw1vOH1ybnX
 qB6Ht2+0sVifYHH/vHjL6jRk3pYhUnrzc00h42JPWt5sMbN3ZGKZddmQ9JvZPeGgoQ
 m+4A0YdzBK5tg==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 02 Feb 2026 23:01:22 -0800
Subject: [PATCH RFC 6/7] acpi: aml-build: Add Cache ID to PPTT table and
 set Cluster ID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-riscv-rqsc-v1-6-dcf448a3ed73@kernel.org>
References: <20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org>
In-Reply-To: <20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Sunil V L <sunilvl@ventanamicro.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6380; i=fustini@kernel.org;
 h=from:subject:message-id; bh=g4wSj2V6c1HLF8bCaTH2AO2uiIhDCllAUUFILdOy3vI=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ2zj3mfWbrtNVLZpYur3nftL87fN7LFXUb1tx9c459a
 rxFtmL83I5SFgYxLgZZMUWWTR/yLizxCv26YP6LbTBzWJlAhjBwcQrARJZ2MPwVNi99MWHhQY+u
 B6cuBslfuvJ/o2nCqvkNerWt36IctcodGRnuyivvnf3Z/PPcqwl1D68c5srj17sU8N658O16w/s
 HH27kAQA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Bump PPTT table revision to 3 which corresponds to ACPI 6.4. A new
field was added to the end of PPTT for the Cache ID. Ensure the Cache
ID Valid bit is set in the flags.

HACK: cluster_id is not set by the riscv arch so force setting it.
Divide the cores between the number of clusters. For the CBQRI example,
cores 0-3 are cluster 0 and cores 4-8 are cluster 1. The proper solution
is for the riscv code to set cluster_id the same way as the arm code.

HACK: cluster 0 uses the first L2 cache controller and cluster 1 uses
the second L2 cache controller. A more general solution is to make the
L2 cache private to the cluster and not private to the core.

The series "[PATCH v8 0/6] Specifying cache topology on ARM" looks to be
the correct approach. RISC-V support could be based on this.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#cache-type-structure-table
Link: https://lore.kernel.org/all/20250310162337.844-1-alireza.sanaee@huawei.com/
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/acpi/aml-build.c | 57 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 742e7a6eb261..7c23b0413f5e 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2148,12 +2148,16 @@ static void build_cache_structure(GArray *tbl,
 {
     /* Cache type structure */
     build_append_byte(tbl, 1);
-    /* Length */
-    build_append_byte(tbl, 24);
+    /*
+     * Length - ACPI 6.4 table 5.140 shows size 28 which increased from
+     * previous version to include space for the new cache id property
+     * https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#cache-type-structure-table
+     */
+    build_append_byte(tbl, 28);
     /* Reserved */
     build_append_int_noprefix(tbl, 0, 2);
-    /* Flags */
-    build_append_int_noprefix(tbl, 0x7f, 4);
+    /* Flags - enable bit 7 for Cache ID Valid */
+    build_append_int_noprefix(tbl, 0xff, 4);
     /* Next level cache */
     build_append_int_noprefix(tbl, next_level, 4);
     /* Size */
@@ -2166,6 +2170,8 @@ static void build_cache_structure(GArray *tbl,
     build_append_byte(tbl, cache_info->attributes);
     /* Line size */
     build_append_int_noprefix(tbl, cache_info->line_size, 2);
+    /* Cache ID */
+    build_append_int_noprefix(tbl, cache_info->id, 4);
 }
 
 /*
@@ -2183,9 +2189,13 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
     uint32_t pptt_start = table_data->len;
     uint32_t root_offset;
     uint32_t l3_offset = 0, priv_num = 0;
-    uint32_t priv_rsrc[3] = {0};
+    uint32_t priv_rsrc[4] = {0};
     int n;
-    AcpiTable table = { .sig = "PPTT", .rev = 2,
+    /*
+     * rev should 3 not 2 based on
+     * https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#processor-properties-topology-table-pptt
+     */
+    AcpiTable table = { .sig = "PPTT", .rev = 3,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
@@ -2209,6 +2219,16 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
      * created.
      */
     for (n = 0; n < cpus->len; n++) {
+        /*
+         * HACK: cluster_id is not set by the riscv arch so force setting it.
+         * Divide the cores between the number of clusters. For the CBQRI
+         * example, cores 0-3 are cluster 0 and cores 4-8 are cluster 1.
+         * The correct solution is for the riscv code to set cluster_id the
+         * same way the arm code is doing it.
+         */
+        cpus->cpus[n].props.cluster_id = (n / (ms->smp.cores * ms->smp.threads))
+                                          % ms->smp.clusters;
+
         if (cpus->cpus[n].props.socket_id != socket_id) {
             assert(cpus->cpus[n].props.socket_id > socket_id);
             socket_id = cpus->cpus[n].props.socket_id;
@@ -2250,7 +2270,25 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
         if (CPUCaches) {
             /* L2 cache type structure */
             priv_rsrc[0] = table_data->len - pptt_start;
-            build_cache_structure(table_data, 0, CPUCaches->l2_cache);
+
+            /*
+             * HACK: cluster 0 uses the first L2 cache controller and
+             * cluster 1 uses the second L2 cache controller. A more
+             * general solution is to make the L2 cache private to
+             * the cluster and not private to the core.
+             *
+             * This series seems to be the correct direction:
+             * https://lore.kernel.org/all/20250310162337.844-1-alireza.sanaee@huawei.com/
+             * but it is only adding support for ARM so it needs to
+             * be broaden to support RISC-V too
+             */
+            if (cluster_id == 0) {
+                build_cache_structure(table_data, l3_offset,
+                                      CPUCaches->l2_cluster1_cache);
+            } else {
+                build_cache_structure(table_data, l3_offset,
+                                      CPUCaches->l2_cluster2_cache);
+            }
 
             /* L1d cache type structure */
             priv_rsrc[1] = table_data->len - pptt_start;
@@ -2261,14 +2299,13 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             priv_rsrc[2] = table_data->len - pptt_start;
             build_cache_structure(table_data, priv_rsrc[0],
                                   CPUCaches->l1i_cache);
-
-            priv_num = 3;
+            priv_num = 2;
         }
         if (ms->smp.threads == 1) {
             build_processor_hierarchy_node(table_data,
                 (1 << 1) | /* ACPI Processor ID valid */
                 (1 << 3),  /* Node is a Leaf */
-                cluster_offset, n, priv_rsrc, priv_num);
+                cluster_offset, n, &priv_rsrc[1], priv_num);
         } else {
             if (cpus->cpus[n].props.core_id != core_id) {
                 assert(cpus->cpus[n].props.core_id > core_id);

-- 
2.43.0


