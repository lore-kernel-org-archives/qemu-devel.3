Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C32C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3Gl-00084u-G3; Fri, 14 Jun 2024 05:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sI3Gh-00082q-Sj; Fri, 14 Jun 2024 05:30:47 -0400
Received: from mail-bn7nam10on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2009::61c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sI3Gf-0006vh-9D; Fri, 14 Jun 2024 05:30:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYu9caLWUEzszkpRzk8hVRTQ7wBCZcFFC1Wcu5mjW5iaFXih7a7dZYyFijhekShhzmTZViJ1c9IOquMW1tnqxclo0oIbwHdydL/a6lxMbEdhiv9318ZqCL9tZXbTtLDm8fnJRXsm+cS0ilhm6j8gDlCVpQMn2/Nn33a3sZmMNoLm25LXOiYjIAWIu3s3pAMlYKeIzA7PVVDlXqIEpqxl7PMga53yu5Mwc1LL31Uh8LW/SmCyv+iGXJyVfjO5WJNYlF9/2oGNoYaDk6zmS9UhV5z/1G8tPY/5qNwvlwj1Hg8oQ3opzo9sHc9CF4kg/8G1gnfSbc5IIk6JixSAICSdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEAkfvPlzjkVKDakRzgzWnQQxLEbZQZrOiysI4IvU5s=;
 b=VU666WYox70HmeOsUE1jQ39/RztadNHPXVgQnSkegoSENJxP9SXzw/DI7tD4kYxBH1phNHLhw1ms7XT1E038wVE0gJ+hm/+mVYc0en7CpyBNnoOhr9wXYJx30xSzJDP8H+L71dN2KM3XuS1AVjPw71r3BGty77HtDf5fqmj5gsqECFsuutuy/o2zSiAwhXwFboAh1mlGRS4nXBjEzobEx2D2h8mVDszoR3x9tG+9DB/ZktdwXfvAwLb6kOPbAgNYGnnFMuRVlradJke57m2TiZC6xhz8QBLs6cTIfaqcFfC/dyQe6qnWvD+eiM1jhVarGlIEhOk8JPYCvsKZEjAJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEAkfvPlzjkVKDakRzgzWnQQxLEbZQZrOiysI4IvU5s=;
 b=eIZyFDjK7w97qxTemfRQDSK0W9pXYfk2g5KFEJ0fSMDIxMUegqzrYvZZP2cdyuM4AynG/VRzDYwYxp2FSLWLikoXghkLKc228yZI5M70I25CJ6y9r2ur6Ne/d2H8UQEkYRIySfuCxHUh+1wbGKgTMxIF4zFiq1ewMbKytPW1geA=
Received: from BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44) by
 IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Fri, 14 Jun 2024 09:30:40 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::e6) by BYAPR01CA0031.outlook.office365.com
 (2603:10b6:a02:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 09:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 09:30:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 04:30:37 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 14 Jun 2024 04:30:35 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>
Subject: [PATCH RFC 1/3] target/arm: Add dcc uart support
Date: Fri, 14 Jun 2024 15:00:24 +0530
Message-ID: <20240614093026.328271-2-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
References: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe94256-eaf1-4dee-903c-08dc8c54a797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230035|36860700008|376009|82310400021|1800799019; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BIWFeajcSmc067v9ObP8xXwJaHIpcnbL2AKtGQLF1WA3LevphnT4YVzrBmy7?=
 =?us-ascii?Q?ejuI/ijmKWCfRBKUO3x/FvfLIKFrVQsHrxRoc109uyjVidQ2TJajDVh4Twfo?=
 =?us-ascii?Q?K4Sugk9H962ee3XUehm2b3gXDUFVT2FftEMvGZq7IFaOU5gTIq9XVrvxBHNv?=
 =?us-ascii?Q?/T9RoLpUh4B8CsosG0WVXQsN7EfV+aghTXAP6FODgd83UbI7Cc5adeHQUj3z?=
 =?us-ascii?Q?TNYsxxM8Da3lGttu2qGT4G2nuD+Xa64sT2leE+NslCMZ47Jy0i8ut8Q+O3/M?=
 =?us-ascii?Q?kJI3HAjXLPB7iES8RD/jp15P+UmCOkMlGd2pF/9SXbisjoX2hKVV4BYfGny/?=
 =?us-ascii?Q?zQuYndj9EkG1QO2yGpU+1NlFfhQmkF+9Z2RQG1MfOn/8NILn4+/H0yN4ac7J?=
 =?us-ascii?Q?UXVfRvQDenRK2nlMkza2PdjJUWzuL8HUsutjDiAA116nm8++lB1jaPDCGlS6?=
 =?us-ascii?Q?VuyQWIYcAhtXTyhmds/LZF/+zATXSg1R61rxITWhaKZkOke/SbZh+RI17Jbf?=
 =?us-ascii?Q?T43tQ04FuZ3UQIECAf8ENGg7peeyedJNx6spH8HiuoAOOKGy0E6XnvMUEjC+?=
 =?us-ascii?Q?Nc3YjTDtEOhubhpRIDu3LoZNMpXmqAQP/f7PrDKe1/UMvRi6DdXf7Gc39l/p?=
 =?us-ascii?Q?fAeSvLDn3lqlCn0VP5nReaQ1DdsxsPR0tS/VXtmEMRJRMcA9BwPitEo18hVJ?=
 =?us-ascii?Q?ADkSVMXgCTUwRS8DtymmnsvNC9/H6qkK+dtjWEKunvB7fTPBqH/iEH61fZFy?=
 =?us-ascii?Q?LST6jbU0WHR53a/1tp1j0aKbqbg11dRbTfPs87ljaQjKq8TL+dp62lSDyXtk?=
 =?us-ascii?Q?/5MXrT5LoTmTw+26T6O5nDXp7UkE1YziHlW6+eMjUzj7u8dC9jvKiP8F64sE?=
 =?us-ascii?Q?rR+vqv9V3adSiNkqHDtWmNmilCLSzt7dU3W5/RHLOctb9ktxMTG+ry+tT3QJ?=
 =?us-ascii?Q?FgNPf/EvDukTjRldfIXt6uFa2rbpF/FrEhgcNnvxGiVSVOVJ5VPdfA2zRa2A?=
 =?us-ascii?Q?r6sc/DHL9/KrCLT0VJoXgM8MdREMcP540oPwDaGymq6zcYooZIi79+NNW1rl?=
 =?us-ascii?Q?tkILcFyjsTkpNy0bUnS7GJZmL2FWHjsnEGv8nsIkMSCcUsX6Aa9WqE+1filh?=
 =?us-ascii?Q?pcvD18Wbm8hF4rSVsgNhGaHqlT5iVovgE31LZncWMiU0M7+uz+FDBBJNXJrH?=
 =?us-ascii?Q?ll10AGw2LDU1YGMdCbMzkydz1M0z23kXs7zPurMR6130u2NT4q6/Ng4K60Wt?=
 =?us-ascii?Q?4bx5McQr+CUP3kCfqYDgz08CGAL4a99wv3QT76mxj0M7Lxy6lMa2+jhByM+s?=
 =?us-ascii?Q?lSKckQC8vWrSJ6PBIRPMC418oevT3rHA4Q50XrCsuLTJhrOzETgFVo04PRoC?=
 =?us-ascii?Q?uFtLMS7QQJUTCwws77fDw5gw2WZJQXca656tN1Lsg5Gaflff8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230035)(36860700008)(376009)(82310400021)(1800799019); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:30:38.8824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe94256-eaf1-4dee-903c-08dc8c54a797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
Received-SPF: permerror client-ip=2a01:111:f403:2009::61c;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DCC is a debug port to transfer some data between debugger and
processor, we are using this feature to connect a chardev device.
Chardev frontends should be named as "dcc<cpu-index>" inorder to connect
to this interface.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
---
 target/arm/cpu.h       | 11 +++++
 target/arm/internals.h |  4 ++
 target/arm/debug-dcc.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c    |  3 ++
 target/arm/meson.build |  1 +
 5 files changed, 118 insertions(+)
 create mode 100644 target/arm/debug-dcc.c

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3841359d0f..6b3cb8e70e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -30,6 +30,8 @@
 #include "qapi/qapi-types-common.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
 
 #ifdef TARGET_AARCH64
 #define KVM_HAVE_MCE_INJECTION 1
@@ -523,6 +525,11 @@ typedef struct CPUArchState {
 
         /* NV2 register */
         uint64_t vncr_el2;
+        /*
+         * Debug Trace regsiters
+         */
+        uint32_t dbgdtr_tx;
+        uint32_t dbgdtr_rx;
     } cp15;
 
     struct {
@@ -1097,6 +1104,9 @@ struct ArchCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* dcc chardev */
+    CharBackend dcc;
 };
 
 typedef struct ARMCPUInfo {
@@ -2388,6 +2398,7 @@ enum arm_features {
      * CPU types added in future.
      */
     ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
+    ARM_FEATURE_DCC,
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 11b5da2562..2fa797c5df 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1778,4 +1778,8 @@ uint64_t gt_get_countervalue(CPUARMState *env);
  * and CNTVCT_EL0 (this will be either 0 or the value of CNTVOFF_EL2).
  */
 uint64_t gt_virt_cnt_offset(CPUARMState *env);
+/*
+ * Initialise Coresight Debug interface
+ */
+void arm_dcc_init(ARMCPU *cpu);
 #endif
diff --git a/target/arm/debug-dcc.c b/target/arm/debug-dcc.c
new file mode 100644
index 0000000000..9144b54994
--- /dev/null
+++ b/target/arm/debug-dcc.c
@@ -0,0 +1,99 @@
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "cpregs.h"
+#include "chardev/char-fe.h"
+
+#define MDCCSR_EL0_RXFULL_MASK (1 << 30)
+#define MDCCSR_EL0_TXFULL_MASK (1 << 29)
+
+static void debug_dcc_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    ARMCPU *cpu = ri->opaque;
+    env->cp15.dbgdtr_tx = value;
+
+    if (qemu_chr_fe_get_driver(&cpu->dcc)) {
+        /*
+         * Usually dcc is used for putc/getc calls which expect only
+         * 1 byte from external debugger.
+         * TODO: This needs to be generalized for other use-cases.
+         */
+        qemu_chr_fe_write_all(&cpu->dcc, (uint8_t *)&env->cp15.dbgdtr_tx, 1);
+    }
+}
+
+static uint64_t debug_dcc_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint32_t ret = 0;
+    ARMCPU *cpu = ri->opaque;
+
+    if (env->cp15.mdscr_el1 & MDCCSR_EL0_RXFULL_MASK) {
+        ret = env->cp15.dbgdtr_rx;
+        env->cp15.dbgdtr_rx = 0;
+        env->cp15.mdscr_el1 &= ~MDCCSR_EL0_RXFULL_MASK;
+        qemu_chr_fe_accept_input(&cpu->dcc);
+    }
+    return ret;
+}
+
+static const ARMCPRegInfo dcc_cp_reginfo[] = {
+    /* DBGDTRTX_EL0/DBGDTRRX_EL0 depend on direction */
+    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
+      .access = PL0_RW, .writefn = debug_dcc_write,
+      .readfn = debug_dcc_read,
+      .type = ARM_CP_OVERRIDE, .resetvalue = 0 },
+    /* DBGDTRTXint/DBGDTRRXint depend on direction */
+    { .name = "DBGDTRint", .state = ARM_CP_STATE_AA32, .cp = 14,
+      .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
+      .access = PL0_RW, .writefn = debug_dcc_write,
+      .readfn = debug_dcc_read,
+      .type = ARM_CP_OVERRIDE, .resetvalue = 0 },
+};
+
+
+static int dcc_chr_can_read(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    if (!(env->cp15.mdscr_el1 & MDCCSR_EL0_RXFULL_MASK)) {
+        /*
+         * Usually dcc is used for putc/getc calls which expect only
+         * 1 byte from external debugger.
+         * TODO: This needs to be generalized for other use-cases.
+         */
+        return 1;
+    }
+
+    return 0;
+}
+
+static void dcc_chr_read(void *opaque, const uint8_t *buf, int size)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    env->cp15.dbgdtr_rx = *buf;
+    env->cp15.mdscr_el1 |= MDCCSR_EL0_RXFULL_MASK;
+}
+
+void arm_dcc_init(ARMCPU *cpu)
+{
+    Chardev *chr;
+    char *dcc_name;
+    CPUState *p = CPU(cpu);
+
+    dcc_name = g_strdup_printf("dcc%d", p->cpu_index);
+    chr = qemu_chr_find(dcc_name);
+    define_arm_cp_regs_with_opaque(cpu, dcc_cp_reginfo, cpu);
+    if (chr) {
+        qemu_chr_fe_init(&cpu->dcc, chr, NULL);
+        qemu_chr_fe_set_handlers(&cpu->dcc,
+                      dcc_chr_can_read,
+                      dcc_chr_read,
+                      NULL, NULL, cpu, NULL, true);
+    }
+    g_free(dcc_name);
+}
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ce31957235..2b594f91cb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9268,6 +9268,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         }
     }
 
+    if (arm_feature(&cpu->env, ARM_FEATURE_DCC)) {
+        arm_dcc_init(cpu);
+    }
     /*
      * Register the base EL2 cpregs.
      * Pre v8, these registers are implemented only as part of the
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 2e10464dbb..3ee38c6b45 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -5,6 +5,7 @@ arm_ss.add(files(
   'gdbstub.c',
   'helper.c',
   'vfp_helper.c',
+  'debug-dcc.c',
 ))
 arm_ss.add(zlib)
 
-- 
2.34.1


