Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90644E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1pp-00082h-TZ; Mon, 02 Mar 2026 06:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vx1pS-0007nj-Gs
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:52:53 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vx1pQ-0007ZV-LQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:52:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofy6KZHp3RS1SL/IcDtC+6SnTNwFcvDHCQtB41YDCbYvFmmWiZKd7uxmlyFWooyjz1xRS5LNDJb0fT+VzRx+TyejWMl2T5zI349mwJu00+pN6Kqox4eEp2C2Hykh9/IB5vQ2iBWNqn7ruRQRqJlbHn51wDSU2eN6fMne2a0lqLwT0swUSSM7gpYa2hK0JnfBrwzys/yilHAU3teG55W5KoGJDx/VoA8Z6eev2GwvJCcDwuGUCilke0VPS6ezYsqlAjG4XK7spiGwcfAdV/Ygxm9S527z9s9fTz+eKdipKa1QbLeHMbEPNopBCKgb8mbBVeRHRojEFfNRSC6mc0nS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htp94NmOB4I68kMYY0e4+EsD7iJgIY/vSSFfRZ1jxMc=;
 b=RJdMZoL2ntGFSYWrQDPhDm9Z93jvRdRAbGYePuETPWt1+PE29QHw9b2p0Wca4JeJ8fNMfJNWkY7vBKNK3WYzXIHbHri6FmypJ09K0KTNesxumvPydSc8CqggAQBmpdNCI4+zNoOcoFejo+TmvUhsXmRXLhdMMCcpTLOjpC5IHKv5+E+R0Ijnz7dPEExp05j46Y0/RqlWRiTBluHJYtG55O8gKhEpShBjqyWSy9dEYy5Wau5d8fJvAaYzX97yJ4jOJoqi4IU2l57ipq1cWBVTCr3AOZhZqKgBybhcDsDCucHKsqQvZVIA/xeQFhHdduSxvL5qSr5mOCWcHFR2uMpexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htp94NmOB4I68kMYY0e4+EsD7iJgIY/vSSFfRZ1jxMc=;
 b=ovVzLLFgt7HPNmOnmbBhw19ddmlQOhA7hjtPLAVK+04Daubxyh8Gnc8/SJV5H+5x4Q8KeTbslY8CtHg7HgkpE3LYz4hAba+I9wTryOYvLIiiAWAfUo+uoldiiSswgikcpuZJn2xEKleuNREZXJTRnQvnMtazB5FN/kOsTQF3TxM=
Received: from MN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:52d::17)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 11:52:42 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::73) by MN0PR04CA0026.outlook.office365.com
 (2603:10b6:208:52d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 11:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 11:52:42 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 05:52:38 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>,
 <clement.mathieu--drif@eviden.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v3 2/3] amd_iommu: Turn on XT support only when guest has
 enabled it
Date: Mon, 2 Mar 2026 17:21:29 +0530
Message-ID: <20260302115130.5903-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302115130.5903-1-sarunkod@amd.com>
References: <20260302115130.5903-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d8e35e-1216-4b95-14a8-08de78523629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: 6iYz0kPmm1QgQtfHc9XGLqX04nG94ttkhiFyyu18RIE75bUayt+UXxTOy+g/PI4C++VEtjSuC13InyckhkdpLVPeKwlz1mWtvCtS1HqebOADl5Jak8QfS6otOur7ESaGPZjfq4fZgbSXHlQBjvbms8zspZHQzIz+N3pQG0DSQedOGQen+witZpYxNAZU4wOEEFs5uwcHtiEsM1H5L6HkcZ9VzMMvAoKmT//Mk5QgPl2KqEqKelloZGXS+ZfE6LqA0G8U84KoQtouXKV1lCVKP81ZQfO91XXckgbCVh86Og+IhavqOmWX3U1mFkB/4080cmibex9C5Y2a8q1vJ/+rtjABEgOHgF8AhPHIBFmHKFvapRDMOyWqOnpjdHh0WSYK0osp8rIfRwx70GlVoF/7kVXMUMtiMd0pgeHmMQkwhT9oizUJEtFloZIqgoIvpVTZaN4qTLhaUWC5fM7u5GTa249G86WlY8LP02vW9ncmW8fpI2h8/16IkXBS7CqE2BnXI6Pa4FzhZ52vk8Qj87tGnEFclLkPuyfDKQfzJbL9rggsJ7Qm6KwLwv7WATdIli+1wflQhOdOOX94kAYxHZwNWCJuEFzrrl4WKVpxUzePyUHkWudTrjMp5bKkenoPaeTFUKSdPfthsGK/d/Qdp3MniZCpYOr3tpFF0cALaRNucoV7/BMjYv3avl5vTXfrT1Iky/GqdnJeNjxOWjU6fLABqOV2JGal3bOlFqQ4uyIcxX3DY/Ga2u2DZksJRiQtVZ9DpA7xyK2902iIcOJDLJ5x+MDmJ6QfDlFmXAH905CWS4Ooz2luUSGp73OylCEakvbj24GPPzr5bPY5unlHLgtPpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +aVBihGTXEZte/cRBGNHXgZU3DEC9StJYKxnIMAfl6nv2YymwKqaxbkDhsaIWOirhugu5fWUHJUlxzlL+w9GY84nzp9EvdjxQKWyfydCYvTdO4Jf2UTY9dASTanQXC83nJjUg3zkd73iJxumdkJNYiLwOm0GHrhV/Xxk7iWeVsNZSNbnIzoIvBwzlQ3MPczIF3CWyv2CLGsUYvp8kA7bbNL4drgcx5bJkXwBgEn0Z4KaHvREDWfnOKXU++0vUwi7w0JazhuzA+Q6ICZsQN02BTZOGtvedExA5k4w3mQPjYz8sLZEqih5nQoHZJbCqEJWeNjD+swl1uQzHVgszJG7btF/Be8QjlkHR9Yw0l0wQK3CX8nQ6BdKdNDWueENRiY/6zj7ql1GRwChzXkSJtZBkKBRivI5oD+KicLIPxdaDMo+8OiWzzL6A1+hcBkoLwZT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:52:42.4050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d8e35e-1216-4b95-14a8-08de78523629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Current code uses 32 bit destination ID irrespective of the fact that
guest has enabled x2APIC support through control register[XTEn] and
completely depends on command line parameter xtsup=on. This is not a
correct hardware behaviour and can cause problems in the guest which has
not enabled XT mode.

Introduce new flag "xten", which is enabled when guest writes 1 to the
control register bit 50 (XTEn). Also, add a new subsection in
`VMStateDescription` for backward compatibility during vm migration.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 21 +++++++++++++++++++--
 hw/i386/amd_iommu.h |  4 +++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index f5aa9c763d02..4a86e62a3b92 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1523,6 +1523,8 @@ static void amdvi_handle_control_write(AMDVIState *s)
     s->cmdbuf_enabled = s->enabled && !!(control &
                         AMDVI_MMIO_CONTROL_CMDBUFLEN);
     s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
+    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
+              s->ga_enabled;
 
     /* update the flags depending on the control register */
     if (s->cmdbuf_enabled) {
@@ -1996,7 +1998,7 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
     irq->vector = irte.hi.fields.vector;
     irq->dest_mode = irte.lo.fields_remap.dm;
     irq->redir_hint = irte.lo.fields_remap.rq_eoi;
-    if (iommu->xtsup) {
+    if (iommu->xten) {
         irq->dest = irte.lo.fields_remap.destination |
                     (irte.hi.fields.destination_hi << 24);
     } else {
@@ -2379,6 +2381,7 @@ static void amdvi_init(AMDVIState *s)
     s->mmio_enabled = false;
     s->enabled = false;
     s->cmdbuf_enabled = false;
+    s->xten = false;
 
     /* reset MMIO */
     memset(s->mmior, 0, AMDVI_MMIO_SIZE);
@@ -2443,6 +2446,16 @@ static void amdvi_sysbus_reset(DeviceState *dev)
     amdvi_reset_address_translation_all(s);
 }
 
+static const VMStateDescription vmstate_xt = {
+       .name = "amd-iommu-xt",
+       .version_id = 1,
+       .minimum_version_id = 1,
+       .fields = (VMStateField[]) {
+           VMSTATE_BOOL(xten, AMDVIState),
+           VMSTATE_END_OF_LIST()
+       }
+};
+
 static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
     .name = "amd-iommu",
     .version_id = 1,
@@ -2487,7 +2500,11 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
       VMSTATE_UINT8_ARRAY(romask, AMDVIState, AMDVI_MMIO_SIZE),
       VMSTATE_UINT8_ARRAY(w1cmask, AMDVIState, AMDVI_MMIO_SIZE),
       VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription *const []) {
+                    &vmstate_xt,
+                    NULL
+     }
 };
 
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index ca4ff9fffee3..d39019b216af 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -102,6 +102,7 @@
 #define AMDVI_MMIO_CONTROL_COMWAITINTEN   (1ULL << 4)
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
 #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
+#define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
@@ -414,7 +415,8 @@ struct AMDVIState {
 
     /* Interrupt remapping */
     bool ga_enabled;
-    bool xtsup;
+    bool xtsup;     /* xtsup=on command line */
+    bool xten;      /* guest controlled, x2apic mode enabled */
 
     /* DMA address translation */
     bool dma_remap;
-- 
2.34.1


