Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED676CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eY-0001qY-9H; Fri, 12 Sep 2025 06:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cz-0007Pd-6k; Fri, 12 Sep 2025 06:03:37 -0400
Received: from mail-dm6nam12on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2417::618]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cb-0001MW-WA; Fri, 12 Sep 2025 06:03:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8PMdmlB94q4MF0jKV23QG/C4nQFZ/PAlLAzHtvxJn8TvlLzQU7/Qpq4nlnGVBeYmZoSK8qhHNwvBt7qIwTBjrDF3Xr+ODhjo4yuo6R+RgeML1jSaFpbdCnGj78DLHrnwCK+PAbnH7ehLy5HtCa7l5I+NmUsr+UpK2Abfk2WkCtuwo1f5B9cZa49nlKEYeXEjm2DMJlKn1cGitcSjYo1EFE5NRK0GigV61fseUrHTGh2sdbHJyNmG8MX4wQLeYfOKmCS/r9THIhQGmP1jrvA/zPcwGjM6Mvb+e81RQcoyi2VIeTw07nLVh5vISdETlvghG584JZQPkOR5QOHKMq/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaPwMaxYjsvuCLseexlKTnPDDWI4RS1hvw+UxcCNeRo=;
 b=QhnNQ5VRGgopVSslQMavFydwXWelaX4/IaLPJYXrT5jggiEKKiem9a9qBqHeUpCx0r4XrxQEnJewI07i17cf5Mr+s4diJ+Q28u12IS6JSQakZ+Odq02jvUie38U28u3S7GIfj/TgYoP2dT/ggWgrV6XwrubgR9FxtQEDaiNWFXwzEuQB3vbwS77VL6BmEGWT0BZjwDqdLKXVM8iLWTc6qNsGxkXnyr8Yszwj7u/8ZBgiKm/d8Hj9rt5Xcqge+PwGZRH2tNiBfIGcDYn5LaAtd4NX+tYfjXofTV6etkkok9uu9ZmmqMNJg2uafdDPGVU94ubxg33TBjjBxnnhVhQbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaPwMaxYjsvuCLseexlKTnPDDWI4RS1hvw+UxcCNeRo=;
 b=v1EKVEOv7S/04QAKD10CIIjWcguuJ2LyqDbcfaDlwwOsbqot56CaF66AFBIG2pEN6SBy/3nRVYMysB2JxG4ea4dp24yMYluYYWpF6NcJqGfyaQJbUGrPNiO0ebwMS/kMSiwxlOCvQoE7or2bQzLEKbbUpxpjrF1W2DAoO10ceKI=
Received: from DM6PR02CA0061.namprd02.prod.outlook.com (2603:10b6:5:177::38)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:08 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::46) by DM6PR02CA0061.outlook.office365.com
 (2603:10b6:5:177::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:18 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:18 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:17 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 32/47] hw/misc/xlnx-versal-crl: refactor device reset logic
Date: Fri, 12 Sep 2025 12:00:41 +0200
Message-ID: <20250912100059.103997-33-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: d7cef44c-b119-43a3-ef56-08ddf1e392da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t4KSkSQ7CNkAu36nfEiz9DSrAl0gdc+12B1on3Asvkjq/o+7NAu6Wtxq3I+H?=
 =?us-ascii?Q?Y0FkVEqxkjMmfaWmefFoYAwAmWK+KBSEpLOJViR/wWwwIVOCs5JOCWyfdqFK?=
 =?us-ascii?Q?Wa5b54k9ZmEPeIrezU89RVxRZ6OWucKgjCUbjCgFh/aXsdllUwG5unhYVPtv?=
 =?us-ascii?Q?Fqu0VMkvvayNQMseqXwIwAolHEpiKmMCwJ1pPd9+Tp5FhTJub713MHzBcfh4?=
 =?us-ascii?Q?Vsg/Gbq0QmEqhORZAPD7tyr5CORnCxzpzXYtjkOyK/Qmzp+fkIy7VsnloJ5Q?=
 =?us-ascii?Q?Ev+lkTBNnm0ZHgcDkYmgaNN32+IAWzGb8mZ8+Dt0lnBwRGACMa1h+7oHrhca?=
 =?us-ascii?Q?6gXGw7kiFygSsJLMTl5Qzb1MAAgIyZU+t4K9vVcKiCIC/rakzq/IDTUwTkzQ?=
 =?us-ascii?Q?iv/iYv6XGXL+pd3wFGVV7cSXNL+T8s8OLvm1H0lAfmOe5CrWtoUP+52iq0E+?=
 =?us-ascii?Q?t3y3j90zxcRN0RGvIuC7GQ5Sx6YosXsAiWnPb3iE1RoG8Sx8iNRTD5hGfLdM?=
 =?us-ascii?Q?TBfSTuQMzEOsgtXuJZCgnSmW28u+UW4BcZ4ACopc5Df5NCAISI+v+04IEsXr?=
 =?us-ascii?Q?TgWL8ZWrEsxVaZYv+Hsxw4oApqrjIn6A60fMK5jU/oRNoxgGyS9yxOi/jI0C?=
 =?us-ascii?Q?NhNecezKYvkaVxurGYD4ZNqSpv/Rvhqw33XHlm+lnewZESzPRfM/rh3fzh9m?=
 =?us-ascii?Q?lGbY/6pQVK4MSu70QQcH14pLOePqpNDQFnvof7+9PILad2t52yYN8HKbcirn?=
 =?us-ascii?Q?0u2C5bjlFgtOoPSMx9hbprpQ7KxnEjOJG8jJyEqHXp7kuw+UPLOPMqEnOR41?=
 =?us-ascii?Q?zn+WT/9iDprhnb8kgs7cM/0z8a08hzpUr7xS8fcuey91evXn3mbO5hII4ye7?=
 =?us-ascii?Q?vv0LcN+YMTVmzbGg9RIoRx3t5e3Kx8MPZvTfpYqFFwCWWuM0C9nddJ4JM/jp?=
 =?us-ascii?Q?zWqqZm40MXJiOxR0E8iF88GYw4MVx98v6hGa5PHQ594rP9hbGqVGNO/OGbQl?=
 =?us-ascii?Q?MKETu8dNBjuh6mQSBJ5SzxIFg4G83x1+sbIHK4yaenhGISodk9OU/CbdTAzC?=
 =?us-ascii?Q?OTqtR+5JGACq+TXij7STdbn99Eu5D9zIILeRmBnt2jpaou34vo4YB3V50G9I?=
 =?us-ascii?Q?XEMzzc9uXX7m11JzopxQdjrl8mjgu4DTIftnVj1pVlcoJpgBqwTy2+J+D1CI?=
 =?us-ascii?Q?kMjUuGjtXK/L3Pe4sVMR9e5xJlUX24BoWk0Nr9UiXqlUoMxhM84GuzJGIzQh?=
 =?us-ascii?Q?SLVo/AHhmNlLKf8kqCIp6MhYPCeNbZQLrZ1zhBZa9dfH+eMDTFPtMxhjcST6?=
 =?us-ascii?Q?mqG4q1OJNMBhs89q8UtdUUcI//R5xiR2P/gKDL/PGWzZtkcPdTr+3wCsO10r?=
 =?us-ascii?Q?MGdyOEexS9o/0qog5VUCIbBbNKMTovrgkYcIoYB1vasEippwYIfW3e9fnmAn?=
 =?us-ascii?Q?J+ofbDfxZUp213GME/XEpwLCpDunbvhMXjf9Scr8StWG3+n09ay+PixBIsxV?=
 =?us-ascii?Q?7TmkDqm0EaTorOJTBZMbj/iRUm5KgxPSUfl9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:07.9359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cef44c-b119-43a3-ef56-08ddf1e392da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
Received-SPF: permerror client-ip=2a01:111:f403:2417::618;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor the device reset logic to have a common register write callback
for all the devices. This uses a decode function to map the register
address to the actual peripheral to reset. This refactoring changes the
CPU property name from cpu_r5[*] to rpu[*] to ease with the connections
in the Versal SoC. It also fixes a bug where the gem device pointer
was mapped to the usb link property.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/misc/xlnx-versal-crl.h |   8 +-
 hw/misc/xlnx-versal-crl.c         | 163 ++++++++++++++++--------------
 2 files changed, 92 insertions(+), 79 deletions(-)

diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index 2b39d203a67..7e50a95ad3c 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -218,33 +218,33 @@ REG32(PSM_RST_MODE, 0x370)
     FIELD(PSM_RST_MODE, WAKEUP, 2, 1)
     FIELD(PSM_RST_MODE, RST_MODE, 0, 2)
 
 #define CRL_R_MAX (R_PSM_RST_MODE + 1)
 
-#define RPU_MAX_CPU 2
-
 struct XlnxVersalCRLBase {
     SysBusDevice parent_obj;
 
     RegisterInfoArray *reg_array;
     uint32_t *regs;
 };
 
 struct XlnxVersalCRLBaseClass {
     SysBusDeviceClass parent_class;
+
+    DeviceState ** (*decode_periph_rst)(XlnxVersalCRLBase *s, hwaddr, size_t *);
 };
 
 struct XlnxVersalCRL {
     XlnxVersalCRLBase parent_obj;
     qemu_irq irq;
 
     struct {
-        ARMCPU *cpu_r5[RPU_MAX_CPU];
+        DeviceState *rpu[2];
         DeviceState *adma[8];
         DeviceState *uart[2];
         DeviceState *gem[2];
-        DeviceState *usb;
+        DeviceState *usb[1];
     } cfg;
 
     uint32_t regs[CRL_R_MAX];
     RegisterInfo regs_info[CRL_R_MAX];
 };
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index be89e0da40d..6225a92e0bd 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -53,94 +53,103 @@ static uint64_t crl_disable_prew(RegisterInfo *reg, uint64_t val64)
     s->regs[R_IR_MASK] |= val;
     crl_update_irq(s);
     return 0;
 }
 
-static void crl_reset_dev(XlnxVersalCRL *s, DeviceState *dev,
-                          bool rst_old, bool rst_new)
+static DeviceState **versal_decode_periph_rst(XlnxVersalCRLBase *s,
+                                              hwaddr addr, size_t *count)
 {
-    device_cold_reset(dev);
-}
+    size_t idx;
+    XlnxVersalCRL *xvc = XLNX_VERSAL_CRL(s);
 
-static void crl_reset_cpu(XlnxVersalCRL *s, ARMCPU *armcpu,
-                          bool rst_old, bool rst_new)
-{
-    if (rst_new) {
-        arm_set_cpu_off(arm_cpu_mp_affinity(armcpu));
-    } else {
-        arm_set_cpu_on_and_reset(arm_cpu_mp_affinity(armcpu));
-    }
-}
+    *count = 1;
 
-#define REGFIELD_RESET(type, s, reg, f, new_val, dev) {     \
-    bool old_f = ARRAY_FIELD_EX32((s)->regs, reg, f);       \
-    bool new_f = FIELD_EX32(new_val, reg, f);               \
-                                                            \
-    /* Detect edges.  */                                    \
-    if (dev && old_f != new_f) {                            \
-        crl_reset_ ## type(s, dev, old_f, new_f);           \
-    }                                                       \
-}
+    switch (addr) {
+    case A_RST_CPU_R5:
+        return xvc->cfg.rpu;
 
-static uint64_t crl_rst_r5_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    case A_RST_ADMA:
+        /* A single register fans out to all DMA reset inputs */
+        *count = ARRAY_SIZE(xvc->cfg.adma);
+        return xvc->cfg.adma;
 
-    REGFIELD_RESET(cpu, s, RST_CPU_R5, RESET_CPU0, val64, s->cfg.cpu_r5[0]);
-    REGFIELD_RESET(cpu, s, RST_CPU_R5, RESET_CPU1, val64, s->cfg.cpu_r5[1]);
-    return val64;
-}
+    case A_RST_UART0 ... A_RST_UART1:
+        idx = (addr - A_RST_UART0) / sizeof(uint32_t);
+        return xvc->cfg.uart + idx;
 
-static uint64_t crl_rst_adma_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
-    int i;
+    case A_RST_GEM0 ... A_RST_GEM1:
+        idx = (addr - A_RST_GEM0) / sizeof(uint32_t);
+        return xvc->cfg.gem + idx;
+
+    case A_RST_USB0:
+        return xvc->cfg.usb;
 
-    /* A single register fans out to all ADMA reset inputs.  */
-    for (i = 0; i < ARRAY_SIZE(s->cfg.adma); i++) {
-        REGFIELD_RESET(dev, s, RST_ADMA, RESET, val64, s->cfg.adma[i]);
+    default:
+        /* invalid or unimplemented */
+        return NULL;
     }
-    return val64;
 }
 
-static uint64_t crl_rst_uart0_prew(RegisterInfo *reg, uint64_t val64)
+static uint64_t crl_rst_cpu_prew(RegisterInfo *reg, uint64_t val64)
 {
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(reg->opaque);
+    XlnxVersalCRLBaseClass *xvcbc = XLNX_VERSAL_CRL_BASE_GET_CLASS(s);
+    DeviceState **dev;
+    size_t i, count;
 
-    REGFIELD_RESET(dev, s, RST_UART0, RESET, val64, s->cfg.uart[0]);
-    return val64;
-}
+    dev = xvcbc->decode_periph_rst(s, reg->access->addr, &count);
 
-static uint64_t crl_rst_uart1_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    for (i = 0; i < 2; i++) {
+        bool prev, new;
+        uint64_t aff;
 
-    REGFIELD_RESET(dev, s, RST_UART1, RESET, val64, s->cfg.uart[1]);
-    return val64;
-}
+        prev = extract32(s->regs[reg->access->addr / 4], i, 1);
+        new = extract32(val64, i, 1);
 
-static uint64_t crl_rst_gem0_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+        if (prev == new) {
+            continue;
+        }
 
-    REGFIELD_RESET(dev, s, RST_GEM0, RESET, val64, s->cfg.gem[0]);
-    return val64;
-}
+        aff = arm_cpu_mp_affinity(ARM_CPU(dev[i]));
 
-static uint64_t crl_rst_gem1_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+        if (new) {
+            arm_set_cpu_off(aff);
+        } else {
+            arm_set_cpu_on_and_reset(aff);
+        }
+    }
 
-    REGFIELD_RESET(dev, s, RST_GEM1, RESET, val64, s->cfg.gem[1]);
     return val64;
 }
 
-static uint64_t crl_rst_usb_prew(RegisterInfo *reg, uint64_t val64)
+static uint64_t crl_rst_dev_prew(RegisterInfo *reg, uint64_t val64)
 {
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(reg->opaque);
+    XlnxVersalCRLBaseClass *xvcbc = XLNX_VERSAL_CRL_BASE_GET_CLASS(s);
+    DeviceState **dev;
+    bool prev, new;
+    size_t i, count;
+
+    dev = xvcbc->decode_periph_rst(s, reg->access->addr, &count);
+
+    if (dev == NULL) {
+        return val64;
+    }
+
+    prev = s->regs[reg->access->addr / 4] & 0x1;
+    new = val64 & 0x1;
+
+    if (prev == new) {
+        return val64;
+    }
+
+    for (i = 0; i < count; i++) {
+        if (dev[i]) {
+            device_cold_reset(dev[i]);
+        }
+    }
 
-    REGFIELD_RESET(dev, s, RST_USB0, RESET, val64, s->cfg.usb);
     return val64;
 }
 
 static const RegisterAccessInfo crl_regs_info[] = {
     {   .name = "ERR_CTRL",  .addr = A_ERR_CTRL,
@@ -242,31 +251,31 @@ static const RegisterAccessInfo crl_regs_info[] = {
         .reset = 0x3c00,
         .rsvd = 0xfdfc00f8,
     },{ .name = "RST_CPU_R5",  .addr = A_RST_CPU_R5,
         .reset = 0x17,
         .rsvd = 0x8,
-        .pre_write = crl_rst_r5_prew,
+        .pre_write = crl_rst_cpu_prew,
     },{ .name = "RST_ADMA",  .addr = A_RST_ADMA,
         .reset = 0x1,
-        .pre_write = crl_rst_adma_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_GEM0",  .addr = A_RST_GEM0,
         .reset = 0x1,
-        .pre_write = crl_rst_gem0_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_GEM1",  .addr = A_RST_GEM1,
         .reset = 0x1,
-        .pre_write = crl_rst_gem1_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_SPARE",  .addr = A_RST_SPARE,
         .reset = 0x1,
     },{ .name = "RST_USB0",  .addr = A_RST_USB0,
         .reset = 0x1,
-        .pre_write = crl_rst_usb_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_UART0",  .addr = A_RST_UART0,
         .reset = 0x1,
-        .pre_write = crl_rst_uart0_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_UART1",  .addr = A_RST_UART1,
         .reset = 0x1,
-        .pre_write = crl_rst_uart1_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_SPI0",  .addr = A_RST_SPI0,
         .reset = 0x1,
     },{ .name = "RST_SPI1",  .addr = A_RST_SPI1,
         .reset = 0x1,
     },{ .name = "RST_CAN0",  .addr = A_RST_CAN0,
@@ -341,13 +350,13 @@ static void versal_crl_init(Object *obj)
                               CRL_R_MAX * 4);
     xvcb->regs = s->regs;
     sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 
-    for (i = 0; i < ARRAY_SIZE(s->cfg.cpu_r5); ++i) {
-        object_property_add_link(obj, "cpu_r5[*]", TYPE_ARM_CPU,
-                                 (Object **)&s->cfg.cpu_r5[i],
+    for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
+        object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
+                                 (Object **)&s->cfg.rpu[i],
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_STRONG);
     }
 
     for (i = 0; i < ARRAY_SIZE(s->cfg.adma); ++i) {
@@ -369,14 +378,16 @@ static void versal_crl_init(Object *obj)
                                  (Object **)&s->cfg.gem[i],
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_STRONG);
     }
 
-    object_property_add_link(obj, "usb", TYPE_DEVICE,
-                             (Object **)&s->cfg.gem[i],
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG);
+    for (i = 0; i < ARRAY_SIZE(s->cfg.usb); ++i) {
+        object_property_add_link(obj, "usb[*]", TYPE_DEVICE,
+                                 (Object **)&s->cfg.usb[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+    }
 }
 
 static void crl_finalize(Object *obj)
 {
     XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
@@ -394,15 +405,17 @@ static const VMStateDescription vmstate_versal_crl = {
 };
 
 static void versal_crl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    XlnxVersalCRLBaseClass *xvcc = XLNX_VERSAL_CRL_BASE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_versal_crl;
     rc->phases.enter = versal_crl_reset_enter;
     rc->phases.hold = versal_crl_reset_hold;
+    xvcc->decode_periph_rst = versal_decode_periph_rst;
 }
 
 static const TypeInfo crl_base_info = {
     .name          = TYPE_XLNX_VERSAL_CRL_BASE,
     .parent        = TYPE_SYS_BUS_DEVICE,
-- 
2.50.1


