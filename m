Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C8ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBULL-0001Wk-JP; Tue, 29 Sep 2026 05:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zakinko@snowrabbit.org>)
 id 1xBULJ-0001WY-NX; Tue, 29 Sep 2026 05:41:45 -0400
Received: from bambi.snowrabbit.org ([182.48.54.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zakinko@snowrabbit.org>)
 id 1xBULH-00037R-5t; Tue, 29 Sep 2026 05:41:45 -0400
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
 id 16A18C92A0; Tue, 29 Sep 2026 18:41:38 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Showta Ishizaki <zakinko@snowrabbit.org>
Date: Tue, 29 Sep 2026 18:04:42 +0900
Subject: [PATCH] hw/ppc/spapr: Add the "rtas-version" property to /rtas
Message-Id: <20260929094138.16A18C92A0@bambi.snowrabbit.org>
Received-SPF: pass client-ip=182.48.54.220;
 envelope-from=zakinko@snowrabbit.org; helo=bambi.snowrabbit.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

LoPAR requires every property listed in its table of /rtas device tree
properties to be present before the OS is booted (R1-7.2.6-3 and Table
7.4 in LoPAR 2.9; the same requirement is in LoPAPR 1.1). One of them
is "rtas-version", an integer encoding of the RTAS interface version,
and LoPAR says it describes version 1 of that interface.

spapr_dt_rtas() sets "rtas-size", "rtas-error-log-max" and
"rtas-event-scan-rate" but never "rtas-version", so a client that reads
it finds no RTAS: NetBSD's RTAS driver fails to attach when the
property is absent.

Set it to 1, the version LoPAR describes.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 hw/ppc/spapr.c         | 1 +
 include/hw/ppc/spapr.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6d99464486..8a1b5b37b6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1068,6 +1068,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
                           RTAS_ERROR_LOG_MAX));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
                           RTAS_EVENT_SCAN_RATE));
+    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-version", RTAS_VERSION));
 
     g_assert(msi_nonbroken);
     _FDT(fdt_setprop(fdt, rtas, "ibm,change-msix-capable", NULL, 0));
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9acda15d4f..676d3b4ea1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -830,6 +830,9 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr);
 
 #define RTAS_EVENT_SCAN_RATE    1
 
+/* The interface version LoPAR 2.9 Table 7.4 describes */
+#define RTAS_VERSION            1
+
 /* This helper should be used to encode interrupt specifiers when the related
  * "interrupt-controller" node has its "#interrupt-cells" property set to 2 (ie,
  * VIO devices, RTAS event sources and PHBs).
-- 
2.54.0 (Apple Git-157)


