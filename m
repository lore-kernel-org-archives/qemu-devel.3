Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD50C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYy1-0003Eo-NG; Wed, 24 Apr 2024 05:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzYxy-0003E8-Fm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzYxw-0003ag-6Q
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713951059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6xN+vy0fvQc0E/kHQZutmwjk4nnBaaPoeO0gL5ILsLc=;
 b=er7a27m9XHajBmZmv4ITnB9+mChQOalTz0HEGR7CCklJ0iAzL6QRNlkJj8aIcYhKNoF82T
 SMHCSPwt46wIZVQKE3rfPieiI+MtZrQIqLUmU/K0F5H7TajZxO1IDyEE6n1IvdtRThcfMu
 UJJ9DFpg/B1GhtSXzgCjG01U4hA/beA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-gr38CS-ANEuf-GgSEZRRZQ-1; Wed, 24 Apr 2024 05:30:52 -0400
X-MC-Unique: gr38CS-ANEuf-GgSEZRRZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6ABD92F0A5;
 Wed, 24 Apr 2024 09:30:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.195.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABDB5490EE;
 Wed, 24 Apr 2024 09:30:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] ppc/pnv: Introduce pnv_chip_foreach_cpu()
Date: Wed, 24 Apr 2024 11:30:48 +0200
Message-ID: <20240424093048.180966-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This helper routine uses the machine definition, sockets, cores and
threads, to loop on all CPUs of the machine. Replace CPU_FOREACH()
with it.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ppc/pnv.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec764c8f6cbd076e27f59c7082e64876..5f400ed127921c4c3a45bc54863b2cafa53e7030 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2264,6 +2264,21 @@ PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir)
     return NULL;
 }
 
+static void pnv_chip_foreach_cpu(PnvChip *chip,
+                   void (*fn)(PnvChip *chip, PowerPCCPU *cpu, void *opaque),
+                   void *opaque)
+{
+    int i, j;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+
+        for (j = 0; j < CPU_CORE(pc)->nr_threads; j++) {
+            fn(chip, pc->threads[j], opaque);
+        }
+    }
+}
+
 static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
 {
     PnvMachineState *pnv = PNV_MACHINE(xi);
@@ -2332,23 +2347,26 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
     return cpu ? ICP(pnv_cpu_state(cpu)->intc) : NULL;
 }
 
+static void pnv_pic_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
+                                    void *opaque)
+{
+    PNV_CHIP_GET_CLASS(chip)->intc_print_info(chip, cpu, opaque);
+}
+
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
                                Monitor *mon)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
     int i;
-    CPUState *cs;
 
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
+    for (i = 0; i < pnv->num_chips; i++) {
+        PnvChip *chip = pnv->chips[i];
 
-        /* XXX: loop on each chip/core/thread instead of CPU_FOREACH() */
-        PNV_CHIP_GET_CLASS(pnv->chips[0])->intc_print_info(pnv->chips[0], cpu,
-                                                           mon);
-    }
+        /* First CPU presenters */
+        pnv_chip_foreach_cpu(chip, pnv_pic_intc_print_info, mon);
 
-    for (i = 0; i < pnv->num_chips; i++) {
-        PNV_CHIP_GET_CLASS(pnv->chips[i])->pic_print_info(pnv->chips[i], mon);
+        /* Then other devices, PHB, PSI, XIVE */
+        PNV_CHIP_GET_CLASS(chip)->pic_print_info(chip, mon);
     }
 }
 
@@ -2549,12 +2567,18 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
+static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
+{
+    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+}
+
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
 {
-    CPUState *cs;
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
 
-    CPU_FOREACH(cs) {
-        async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+    for (i = 0; i < pnv->num_chips; i++) {
+        pnv_chip_foreach_cpu(pnv->chips[i], pnv_cpu_do_nmi, NULL);
     }
 }
 
-- 
2.44.0


