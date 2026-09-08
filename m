Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3879FC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIC-0000Ii-IF; Tue, 08 Sep 2026 06:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI8-0000BA-Bj; Tue, 08 Sep 2026 06:43:04 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI4-0006YC-TU; Tue, 08 Sep 2026 06:43:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF8ZJL/F0cY8g4FLeIiy0yYOiV5Z2HcoZ9CxSk2gUxy6T3Bz3x9xNAJEzcXulEvtjFgRyc3+W/e4l+E5WIiIn1EXpunLDbQfZbqIYmo4TweqYqc2ZmmXqnf948/BgBAHwFYZpOs4X64mfKvMcqUeKeLB+h4mQbBGlF2twaG/frHveRnJmwRR+luvu+3Rxc3MoH9lqFsq+YGCx1evLuXqabfdZFY1BmIzRxst9gabg4pxwB4uNIZX1ucPj5b7QHPRUVqrvteZ0ISLCAgj+Vzqu5YSYslOa09hA+EeFxDiyUA75z0/KgaC5GhCotFHs3+qedu8fN+e3iD40RHB8JIhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/8ojCsSlsqIaAbIS4DnLYxHiNvsPTINSulD+O6gw44=;
 b=dC1OBsXnwuEr6L+8IDjEHhHuGQTNdVDbANGbaPWwsa6B5yeHI+iWkeV4p0C6BDOfil094UWFs333R7qkt5Awwa1xF1ciDJ2cQ4xjWxvNn7YMEZiuyalAWAq7ewBceiZKAgW/xPYFKv2mg4deqKBS8zagWnquQYlZ4yKPMnUoFewZo6y9DkteBSDJJwgGPR+irdl+JhBICSSfMQf8msjnCyLiex+zrNPxjugtncLqi4MkmEr1WPJy4upEPSdUSXjZbY2iJ2+fxnfM+A0Loil0lwihYQ1L+DOZQQH9FOIud6wj/Z44QmBQeIdJIjuO2NUDplLVpgrBGzZ4UZLNKoIVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/8ojCsSlsqIaAbIS4DnLYxHiNvsPTINSulD+O6gw44=;
 b=ZUnCgnZVLJC6CWr+x0eCu7VFwPX0vFNrkryZCwLArcAXITxpwWm9t1hvchrC1d7T2WMObORDQRJT7iL86JZ8FtGWOc9bO8k6tlAmQD7Ks2rmzwtwE1JB6nDA6U9xYeA8q/PwUy/38paups1LZLOiAbznElndWMIlMPRjrRyk+n2esF/A5IQNf0mfKUNHkkAloTI73d2l6lfQZAKDMYMTyESTt+8FFHdWa0lRVURHFsPIGvE9iqYptB5DRGGbiIkP/mUpCYhCyOqEFI4WEAXHB1iN9ZXOudrZDwta7gNmYW6tNvXC4xpf+E+8/Pe+Cpf5/EzpDs6EzqoPfSn+K6tj5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:44 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:44 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 17/32] hw/misc: Support Phytium E2000 SCMI CPU power control
Date: Tue,  8 Sep 2026 18:41:26 +0800
Message-ID: <20260908104159.1621764-18-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|OSQPR02MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a797bd-0a52-41ea-27f6-08df0d95ea85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: Qt+n8kPxhEANx/URJxXv/HbdD4QKOkl0Kx98OovmXgPGP4hPuoGe7IBpjtHvudCvMpGQoeUdaa+aibLST3j0BZ169URtJBufgh+gwG969K1C+Cq//tJt+aMcxUxTsVX+nKvmGpqUsrBgyF8/tqIuAqm1gUon8a9JioaX8pq2Jv9HRI/Ntl9uBGK9YJrYYlpBSmKyfDwz/IDCdh77zLQvPMMCDnHZn6riQN+9GdBMC3vOLmJeHllP+QARxWYCVqgnueCUmnh1b1pkIh6jyOubm49cY3Y6sMa3mJ6iwNN1dbWyODyo3k9M2xqbuP+N+EAzZJpSI+7bGOkHYNVTIQTPbL9uWkd8ZvEnC91Qu87zAjWC0V/EdHEn1GPKD/LuBeI74KU+pUxpdCgO4e82gn2eMyFg9qbFwVzLAzXddfq+maB+wbtHXqHrKOg9F3AeA8+RZWAid25ujeuoWTW1/gjQZEMRoaJrTExqKnpIM+yH83oE65u8pleHstf28YFOPW2e2t1auLZPUTEndX8kn/s8XGwp9r1+Qvx4YFBvTUqM83rHWSQFWVM9rtm4pDe8vF4OVuNI6OaDHZF2ybB4/pS39+grICfh9jDx08NxR1UytMOD3pC7rRAj5rAJO3YY9HWq4355Mqxspe0uTI8nEFHQJnSK2lVkmWK4t/s1458PETA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?it82xBdQi24raSkaDs1cIFkV0aGSeP6n19BVxa3SI8xCxeDTQ6utpDTdPVgO?=
 =?us-ascii?Q?GoSxLitT0x1ljWWlC5htc4odA2XrWQk2UxPeNrfmUSud6In2gxtBCILhnxno?=
 =?us-ascii?Q?dZgiCH3ZvCawadMfvL22LDFxa5o/3KDbecoi7XtUTv57krRW/yIyqzlw5/1K?=
 =?us-ascii?Q?6Gog7MI/1AZAClWAJAReqjHDdeFWX5CkCTn2RA94Dw6ZjnUhOpjNBSCGPGkC?=
 =?us-ascii?Q?gRW5sKzpe8AykL93Kpu8wXrvdCNXl7TstYrVmq1tt2xuteQHdJR1nqDmFHvT?=
 =?us-ascii?Q?mKkb/O4RaLL97OQ5DK5V08+ApQjTeaLtFuC2wMg8DhZhqRpsi5e/u+eai2PT?=
 =?us-ascii?Q?ovJC1IAWo+n0PslwUmzieffhzv9cz2O6rYb2TyCluUAetu50EPi7biemSmEj?=
 =?us-ascii?Q?KYpzw91EFj9FTjWHNjs9qceyCRw0gwabZGhO6IELhg9lv96UmzUBEKfhJDw3?=
 =?us-ascii?Q?4GT383ja2IfrCYSHAT8sJXVeGrPUoa3Nt0Jr8b1qpMS9eDl0TUtu0BR8e0i6?=
 =?us-ascii?Q?zE5u9X8sTnRnS1QNzp6uM8PsfUt9CKzdykUYFGMNhMIJJfuMfB6vKlKG6rOZ?=
 =?us-ascii?Q?yMXNduwXLdOHUyDTRy2QSbLL2ITk25GGEuQ84/e7XAGc3N0On3DXoFMr+BrI?=
 =?us-ascii?Q?iqq02FoYkXFY3ZJgglD5PrPyRjCuIHb0Ir5drlQkS+QZA9TWzmhSFtiY1XHh?=
 =?us-ascii?Q?5dfHb7PjAFQxVdP9XkXhsgyumaujOyooWf5mLsLzZOaQlxnBiDqLk3gU0TSN?=
 =?us-ascii?Q?vO6k/FXmJLR81nAEZlGswidEDi3wJtNCTaFwVnom5qT77TTO5PPjlBPZBMwL?=
 =?us-ascii?Q?fA7RMavfHhYwdj2mTKoodAVTub33tbijFtcW6MS8b6Qgy277IKZs+xL+nVBy?=
 =?us-ascii?Q?g7+PFn3skUrLN7xyrfYMU8ctf5F6739NsLm0ebCFb0UHFvuhCRSZNou5dA+v?=
 =?us-ascii?Q?XzNy3KPpbE8n1QoxW5HmwJmunw8azLLuhZcF8UzMXgZx2RGB/g5DSgnOVqUV?=
 =?us-ascii?Q?gqHwB6crAcUPOzXYmuYFOU4b8GFc+zDY5F0NtrvJSkj3FAMmeoRvRPoLZ/cL?=
 =?us-ascii?Q?+4E5rb/uFHg+vU+Qp8LCeDWaPuZijhsTLALXJAGTeY2TuykmOc2sc0c8dMgX?=
 =?us-ascii?Q?4SZ173bSioz3DN0Q34aqeJ7Sto9y525TWZcpWy8ifhLhEkJNdhnGCljm/Uip?=
 =?us-ascii?Q?DfHIF1z3Jk3b+rOoltNwiiC40MTN5ndmeYzI2qOwmHjost8glCCYFHagvA4S?=
 =?us-ascii?Q?XMUCbGVAi66GA4Rigp6a/TAoKR4EzPA767p7SHWPRL24PUbn8OFLFEobJBS8?=
 =?us-ascii?Q?Mh4GNyJdafIA7UeO3dfLqPmrLMJSe0b3Z6po5oMQuw3fxpRNUzLjWixU2Jeu?=
 =?us-ascii?Q?aTg24f+EaE3pDYZqJT/UYrqlG9IYFGSHwGaI1IbWyKbMGt2Vg+H9VlsXRCIE?=
 =?us-ascii?Q?9Jcc/q8ETFAK9lrdEry+WuEIDTZ192D27tzOG+lWqg/q2av0AUZqPGnLrjTS?=
 =?us-ascii?Q?qn/zXKSqYgakuUXA50wXPpVsi2nHEtJGZb/AOnWWRuABYZPvkykNL6SSlkLP?=
 =?us-ascii?Q?sXohliZM82oCDSVxzrgOTNKPFeTs1f6DyzisgxAy1qf7WebVvnrR8SD61R1s?=
 =?us-ascii?Q?txWyHZM6ZZ9DjmC3b1EW/yq3qcXAaTeR8RZyvAOno8fGpNnHINPLqSAVYYQ+?=
 =?us-ascii?Q?1QUXg5UGLlhh2SwVdGd4KK1KiQrrPIwTQhjMGSvNc2UpWJ+fDL6bYHiLv0Dr?=
 =?us-ascii?Q?N2xigUhd+WiAUc5opLLwTnQDu4M+rLc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a797bd-0a52-41ea-27f6-08df0d95ea85
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:44.7242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUI1TtjVEdDq+hiwmHqppjXLhr2jM8TggO8pYChQpH54HJQj9+UUfZ1GRcirAeTlry/kqGlFGZiPQ8hFlK6vOO4VqcLRVliGJqig1mtoaVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The E2000 MHU previously acknowledged every SCMI message without
applying power-state changes. Consequently, BL31 reported successful
PSCI CPU_ON calls while all secondary CPUs remained powered off.

Implement the power-domain requests and the Phytium PSOSTAT query used
by the firmware. Follow the firmware-published runtime object graph,
complete its SCP handoff, and reset each target CPU at the resident
secondary entry published by BL1.

The secondary handoff is not described by the public PBF specifications.
Scan BL1 for invariant control-flow, MPIDR, and PBR-root anchors while
masking compiler-dependent branch displacements, then obtain the
firmware-owned vector-slot address from the adjacent literal. Reject
missing, ambiguous, unaligned, or null handoff records.

Pass the validated slot from PBR to MHU and dereference it for every
CPU_ON request because firmware may publish the entry after boot and
reuse the temporary BL1 image before Linux starts secondary CPUs.

With this change, booting from SDK firmware images can bring up all
four cores successfully.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Connect MHU to the SoC-owned CPU children
- Use the SoC CPU count when wiring SCMI power control

 include/hw/misc/phytium_e2000_mhu.h |   9 +
 include/hw/misc/phytium_e2000_pbr.h |   7 +
 hw/arm/phytium_e2000.c              |  18 ++
 hw/misc/phytium_e2000_mhu.c         | 384 ++++++++++++++++++++++++++--
 hw/misc/phytium_e2000_pbr.c         | 153 ++++++++++-
 5 files changed, 543 insertions(+), 28 deletions(-)

diff --git a/include/hw/misc/phytium_e2000_mhu.h b/include/hw/misc/phytium_e2000_mhu.h
index 0527d6fe8d..013f55a820 100644
--- a/include/hw/misc/phytium_e2000_mhu.h
+++ b/include/hw/misc/phytium_e2000_mhu.h
@@ -12,14 +12,23 @@
 #ifndef HW_MISC_PHYTIUM_E2000_MHU_H
 #define HW_MISC_PHYTIUM_E2000_MHU_H
 
+#include "hw/core/cpu.h"
 #include "hw/core/sysbus.h"
+#include "hw/misc/phytium_e2000_pbr.h"
 #include "qom/object.h"
 
 #define TYPE_PHYTIUM_E2000_MHU "phytium-e2000-mhu"
 OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000MHUState, PHYTIUM_E2000_MHU)
 
 #define PHYTIUM_E2000_MHU_MMIO_SIZE 0x1000
+#define PHYTIUM_E2000_MHU_MAX_CPUS  4
 
 void phytium_e2000_mhu_seed_mailbox(void);
+void phytium_e2000_mhu_connect_cpu(PhytiumE2000MHUState *s,
+                                   unsigned int index, uint64_t mpidr,
+                                   CPUState *cpu);
+/* Configure the PBR-validated, firmware-owned secondary-vector slot */
+void phytium_e2000_mhu_set_secondary_vector_slot(PhytiumE2000MHUState *s,
+                                                 hwaddr slot);
 
 #endif
diff --git a/include/hw/misc/phytium_e2000_pbr.h b/include/hw/misc/phytium_e2000_pbr.h
index 890d419254..03f055dcd0 100644
--- a/include/hw/misc/phytium_e2000_pbr.h
+++ b/include/hw/misc/phytium_e2000_pbr.h
@@ -35,6 +35,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000PBRState, PHYTIUM_E2000_PBR)
 #define PHYTIUM_E2000_PBR_BOOT_SRAM_SIZE    0x00100000
 #define PHYTIUM_E2000_PBR_IACC_SIZE         0x08000000
 #define PHYTIUM_E2000_PBR_MAX_CPUS          4
+#define PHYTIUM_E2000_PBR_ROOT              \
+    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x1000)
+#define PHYTIUM_E2000_PBR_CPU_CONTROL       \
+    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x2000)
+#define PHYTIUM_E2000_PBR_CPU_CONTROL_MAGIC 0xffaabbcc
 
 #define PHYTIUM_E2000_PBR_BOOT_MEDIA_QSPI   0x1
 #define PHYTIUM_E2000_PBR_BOOT_MEDIA_SD0    0x4
@@ -49,6 +54,8 @@ void phytium_e2000_pbr_configure(PhytiumE2000PBRState *s,
                                  unsigned int num_cpus);
 bool phytium_e2000_pbr_firmware_loaded(PhytiumE2000PBRState *s);
 int phytium_e2000_pbr_primary_cpu(PhytiumE2000PBRState *s);
+/* Return the firmware-owned slot address, not its runtime entry value */
+hwaddr phytium_e2000_pbr_secondary_vector_slot(PhytiumE2000PBRState *s);
 void phytium_e2000_pbr_connect_cpu(PhytiumE2000PBRState *s,
                                    unsigned int index, CPUState *cpu);
 
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 18d64aca69..e3fea5ada1 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -566,12 +566,30 @@ static void phytium_e2000_create_mhu(PhytiumE2000SoCState *s)
 {
     DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_MHU);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
 
     /*
      * MHU is the notification side of the SCMI transport. The message body
      * remains in SCP SRAM, so this device only owns the doorbell aperture.
      */
     object_property_add_child(OBJECT(s), "mhu", OBJECT(dev));
+    if (phytium_e2000_pbr_firmware_loaded(s->pbr)) {
+        /*
+         * PBR validates the firmware-specific BL1 handoff and owns all FIP
+         * interpretation.  Pass only the resulting slot address to MHU; the
+         * transport must not parse firmware or assume a PBF build layout.
+         * Direct Linux boot has no firmware SCMI CPU_ON path and therefore
+         * intentionally leaves the slot unset.
+         */
+        phytium_e2000_mhu_set_secondary_vector_slot(
+            PHYTIUM_E2000_MHU(dev),
+            phytium_e2000_pbr_secondary_vector_slot(s->pbr));
+    }
+    for (i = 0; i < s->num_cpus; i++) {
+        phytium_e2000_mhu_connect_cpu(PHYTIUM_E2000_MHU(dev), i,
+                                      phytium_e2000_cpu_mp_affinity(i),
+                                      CPU(&s->cpu[i]));
+    }
     sysbus_realize_and_unref(sbd, &error_fatal);
     sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_MHU_BASE, 2);
 }
diff --git a/hw/misc/phytium_e2000_mhu.c b/hw/misc/phytium_e2000_mhu.c
index 4ea23af900..554448398b 100644
--- a/hw/misc/phytium_e2000_mhu.c
+++ b/hw/misc/phytium_e2000_mhu.c
@@ -18,15 +18,40 @@
 
 #include "hw/core/register.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "system/address-spaces.h"
+#include "target/arm/arm-powerctl.h"
+#include "target/arm/cpu.h"
 
 #define PHYTIUM_E2000_PBF_SCMI_MBOX_BASE  0x32a10400
 #define PHYTIUM_E2000_SCMI_STATUS_OFFSET  0x04
 #define PHYTIUM_E2000_SCMI_LEN_OFFSET     0x14
+#define PHYTIUM_E2000_SCMI_HEADER_OFFSET  0x18
 #define PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET 0x1c
 #define PHYTIUM_E2000_SCMI_STATUS_FREE    BIT(0)
 
+#define SCMI_MESSAGE_ID(header)    extract32((header), 0, 8)
+#define SCMI_PROTOCOL_ID(header)   extract32((header), 10, 8)
+#define SCMI_PROTOCOL_POWER_DOMAIN 0x11
+#define SCMI_PROTOCOL_PHYTIUM      0x81
+#define SCMI_POWER_STATE_SET       0x4
+#define SCMI_PHYTIUM_GET_PSOSTAT   0x3
+#define SCMI_POWER_STATE_TYPE      BIT(30)
+#define SCMI_POWER_STATE_ID_MASK   (SCMI_POWER_STATE_TYPE - 1)
+
+#define SCMI_SUCCESS            0
+#define SCMI_INVALID_PARAMETERS (-2)
+#define SCMI_GENERIC_ERROR      (-8)
+
+#define PHYTIUM_E2000_PBF_ROOT_ANCHOR       \
+    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0xf00)
+#define PHYTIUM_E2000_CPU_TARGET_OFFSET     0x08
+#define PHYTIUM_E2000_CPU_LOCK_DEPTH_OFFSET 0x28
+#define PHYTIUM_E2000_CPU_LOCK_OWNER_OFFSET 0x30
+#define PHYTIUM_E2000_CPU_ON_COMPLETE       0xabcdef98
+
 /*
  * The SDK defines AP OS status/set/clear at 0x100/0x108/0x110 within a
  * channel. PBF selects the channel at MHU offset 0x200, producing the global
@@ -44,42 +69,308 @@ struct PhytiumE2000MHUState {
 
     uint32_t regs[PHYTIUM_E2000_MHU_R_MAX];
     RegisterInfo regs_info[PHYTIUM_E2000_MHU_R_MAX];
+    uint64_t cpu_mpidrs[PHYTIUM_E2000_MHU_MAX_CPUS];
+    CPUState *cpus[PHYTIUM_E2000_MHU_MAX_CPUS];
+    /* Firmware-owned slot address supplied by the PBR before realization */
+    hwaddr secondary_vector_slot;
+    unsigned int num_cpus;
 };
 
-static void phytium_e2000_mhu_complete_scmi(void)
+static bool phytium_e2000_phys_readl(hwaddr addr, uint32_t *value)
+{
+    uint8_t buf[sizeof(*value)];
+
+    if (address_space_read(&address_space_memory, addr,
+                           MEMTXATTRS_UNSPECIFIED, buf,
+                           sizeof(buf)) != MEMTX_OK) {
+        return false;
+    }
+    *value = ldl_le_p(buf);
+    return true;
+}
+
+static bool phytium_e2000_phys_readq(hwaddr addr, uint64_t *value)
+{
+    uint8_t buf[sizeof(*value)];
+
+    if (address_space_read(&address_space_memory, addr,
+                           MEMTXATTRS_UNSPECIFIED, buf,
+                           sizeof(buf)) != MEMTX_OK) {
+        return false;
+    }
+    *value = ldq_le_p(buf);
+    return true;
+}
+
+static bool phytium_e2000_phys_writel(hwaddr addr, uint32_t value)
+{
+    uint8_t buf[sizeof(value)];
+
+    stl_le_p(buf, value);
+    return address_space_write(&address_space_memory, addr,
+                               MEMTXATTRS_UNSPECIFIED, buf,
+                               sizeof(buf)) == MEMTX_OK;
+}
+
+static bool phytium_e2000_phys_writeq(hwaddr addr, uint64_t value)
+{
+    uint8_t buf[sizeof(value)];
+
+    stq_le_p(buf, value);
+    return address_space_write(&address_space_memory, addr,
+                               MEMTXATTRS_UNSPECIFIED, buf,
+                               sizeof(buf)) == MEMTX_OK;
+}
+
+static uint32_t phytium_e2000_scmi_readl(hwaddr offset)
 {
     uint8_t buf[sizeof(uint32_t)];
-    uint32_t len;
 
-    /*
-     * Preserve the caller's message length, but reserve one status word for
-     * the minimal success response returned in the payload.
-     */
     address_space_read(&address_space_memory,
-                       PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
-                       PHYTIUM_E2000_SCMI_LEN_OFFSET,
+                       PHYTIUM_E2000_PBF_SCMI_MBOX_BASE + offset,
                        MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
-    len = MAX(ldl_le_p(buf), (uint32_t)sizeof(uint32_t));
+    return ldl_le_p(buf);
+}
 
-    stl_le_p(buf, 0);
-    address_space_write(&address_space_memory,
-                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
-                        PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET,
-                        MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
-    stl_le_p(buf, len);
+static void phytium_e2000_scmi_writel(hwaddr offset, uint32_t value)
+{
+    uint8_t buf[sizeof(uint32_t)];
+
+    stl_le_p(buf, value);
     address_space_write(&address_space_memory,
-                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
-                        PHYTIUM_E2000_SCMI_LEN_OFFSET,
+                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE + offset,
                         MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
-    stl_le_p(buf, PHYTIUM_E2000_SCMI_STATUS_FREE);
+}
+
+static void phytium_e2000_scmi_publish(uint32_t len)
+{
+    phytium_e2000_scmi_writel(PHYTIUM_E2000_SCMI_LEN_OFFSET, len);
     /*
      * Publish the free bit last. PBF polls this field as the ownership handoff
      * and may consume the response immediately after observing it.
      */
-    address_space_write(&address_space_memory,
-                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
-                        PHYTIUM_E2000_SCMI_STATUS_OFFSET,
-                        MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
+    phytium_e2000_scmi_writel(PHYTIUM_E2000_SCMI_STATUS_OFFSET,
+                              PHYTIUM_E2000_SCMI_STATUS_FREE);
+}
+
+static bool phytium_e2000_mhu_cpu_is_on(PhytiumE2000MHUState *s,
+                                        uint64_t mpidr)
+{
+    unsigned int i;
+
+    for (i = 0; i < s->num_cpus; i++) {
+        if ((s->cpu_mpidrs[i] & 0xffff) == (mpidr & 0xffff)) {
+            return ARM_CPU(s->cpus[i])->power_state == PSCI_ON;
+        }
+    }
+
+    return false;
+}
+
+static bool phytium_e2000_mhu_prepare_cpu_on(PhytiumE2000MHUState *s,
+                                             uint64_t mpidr,
+                                             uint64_t *runtime_cpu_control,
+                                             uint64_t *secondary_entry)
+{
+    uint64_t pbr_cpu_control;
+    uint64_t runtime_root;
+    uint64_t target;
+    uint64_t magic;
+    uint32_t first_instruction;
+    uint32_t lock_depth;
+    uint32_t lock_owner;
+
+    /*
+     * BL1 and EL3 deliberately use different roots after PBF relocates the
+     * runtime object graph. BL1's reset trampoline follows the PBR-owned root
+     * at 0x30c01000, while EL3 follows the relocatable anchor at 0x30c00f00.
+     * The emulated SCP therefore copies the requested MPIDR into BL1's
+     * control block before releasing the secondary CPU.
+     *
+     * The secondary-vector slot itself was recovered and validated while PBR
+     * parsed BL1.  Read the slot for every CPU_ON request rather than caching
+     * its contents: BL1 first publishes the resident EL3 entry at runtime and
+     * the temporary BL1 mapping may subsequently be overwritten.
+     */
+    if (!phytium_e2000_phys_readq(PHYTIUM_E2000_PBR_ROOT,
+                                  &pbr_cpu_control) ||
+        pbr_cpu_control != PHYTIUM_E2000_PBR_CPU_CONTROL ||
+        !phytium_e2000_phys_readq(pbr_cpu_control, &magic) ||
+        magic != PHYTIUM_E2000_PBR_CPU_CONTROL_MAGIC ||
+        !phytium_e2000_phys_readq(PHYTIUM_E2000_PBF_ROOT_ANCHOR,
+                                  &runtime_root) ||
+        runtime_root == PHYTIUM_E2000_PBR_ROOT ||
+        !QEMU_IS_ALIGNED(runtime_root, sizeof(uint64_t)) ||
+        !phytium_e2000_phys_readq(runtime_root, runtime_cpu_control) ||
+        !QEMU_IS_ALIGNED(*runtime_cpu_control, sizeof(uint64_t)) ||
+        *runtime_cpu_control < PHYTIUM_E2000_PBR_BOOT_SRAM_BASE ||
+        *runtime_cpu_control > PHYTIUM_E2000_PBR_BOOT_SRAM_BASE +
+                               PHYTIUM_E2000_PBR_BOOT_SRAM_SIZE -
+                               (PHYTIUM_E2000_CPU_LOCK_OWNER_OFFSET +
+                                sizeof(uint32_t)) ||
+        !phytium_e2000_phys_readq(*runtime_cpu_control +
+                                  PHYTIUM_E2000_CPU_TARGET_OFFSET,
+                                  &target) ||
+        (target & 0xffff) != (mpidr & 0xffff) ||
+        !phytium_e2000_phys_readl(*runtime_cpu_control +
+                                  PHYTIUM_E2000_CPU_LOCK_DEPTH_OFFSET,
+                                  &lock_depth) ||
+        !phytium_e2000_phys_readl(*runtime_cpu_control +
+                                  PHYTIUM_E2000_CPU_LOCK_OWNER_OFFSET,
+                                  &lock_owner) ||
+        !s->secondary_vector_slot ||
+        !phytium_e2000_phys_readq(s->secondary_vector_slot,
+                                  secondary_entry) ||
+        !QEMU_IS_ALIGNED(*secondary_entry, sizeof(uint32_t)) ||
+        !phytium_e2000_phys_readl(*secondary_entry, &first_instruction) ||
+        first_instruction == 0 || first_instruction == UINT32_MAX) {
+        return false;
+    }
+
+    /*
+     * EL3 records three nested power-domain lock levels for the first CPU_ON.
+     * Later requests observe the already retired zero state. The lock owner
+     * must name a CPU which is currently powered on.
+     */
+    if (!((lock_depth == 3 &&
+           phytium_e2000_mhu_cpu_is_on(s, lock_owner)) ||
+          (lock_depth == 0 && lock_owner == 0))) {
+        return false;
+    }
+
+    return phytium_e2000_phys_writeq(
+        pbr_cpu_control + PHYTIUM_E2000_CPU_TARGET_OFFSET, mpidr & 0xffff);
+}
+
+static bool phytium_e2000_mhu_complete_cpu_on(uint64_t runtime_cpu_control)
+{
+    /*
+     * EL3 polls its relocated control block for 0xabcdef98 after issuing the
+     * SCMI request. The secondary's on-finish hook begins by acquiring the
+     * same reentrant lock and writes the completion value only afterwards.
+     * The power-controller handoff must therefore retire the primary's lock
+     * state before publishing completion, or both CPUs wait on each other.
+     *
+     * This ordering and the offsets were recovered from the Phytium Pi and
+     * COMe SDK BL1/EL3 binaries; they are not described by the published PBF
+     * ABI.
+     */
+    return phytium_e2000_phys_writel(
+               runtime_cpu_control + PHYTIUM_E2000_CPU_LOCK_DEPTH_OFFSET, 0) &&
+           phytium_e2000_phys_writel(
+               runtime_cpu_control + PHYTIUM_E2000_CPU_LOCK_OWNER_OFFSET, 0) &&
+           phytium_e2000_phys_writeq(
+               runtime_cpu_control + PHYTIUM_E2000_CPU_TARGET_OFFSET,
+               PHYTIUM_E2000_CPU_ON_COMPLETE);
+}
+
+static uint32_t phytium_e2000_mhu_psostat(PhytiumE2000MHUState *s)
+{
+    uint32_t status = 0;
+    unsigned int i;
+
+    /*
+     * Phytium PBF's vendor SCMI query returns two bits per E2000 core in the
+     * SoC's physical CPU order. A value of 2 denotes powered off and 0
+     * denotes powered on. This produces the 0x8a reset value observed on
+     * hardware when MPIDR 0x200 is the only running core.
+     */
+    for (i = 0; i < s->num_cpus; i++) {
+        if (ARM_CPU(s->cpus[i])->power_state != PSCI_ON) {
+            status |= 2U << (2 * i);
+        }
+    }
+
+    return status;
+}
+
+static int32_t phytium_e2000_mhu_set_power_state(PhytiumE2000MHUState *s)
+{
+    uint32_t domain_id = phytium_e2000_scmi_readl(
+        PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET + 4);
+    uint32_t power_state = phytium_e2000_scmi_readl(
+        PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET + 8);
+    uint32_t core_mask = power_state & SCMI_POWER_STATE_ID_MASK;
+    bool power_on = power_state & SCMI_POWER_STATE_TYPE;
+    uint64_t runtime_cpu_control;
+    uint64_t secondary_entry;
+    unsigned int i;
+    int ret;
+
+    /*
+     * The E2000 firmware encodes Aff1 as the SCMI power domain and a single
+     * Aff0 bit in the vendor power-state ID. This relation is visible in the
+     * PBF request builder: MPIDR 0x201 becomes domain 2, state 0x40000002;
+     * MPIDR 0x100 becomes domain 1, state 0x40000001.
+     */
+    if (!is_power_of_2(core_mask)) {
+        return SCMI_INVALID_PARAMETERS;
+    }
+
+    for (i = 0; i < s->num_cpus; i++) {
+        uint64_t mpidr = s->cpu_mpidrs[i];
+        unsigned int aff0 = extract64(mpidr, 0, 8);
+        unsigned int aff1 = extract64(mpidr, 8, 8);
+
+        if (aff0 >= 30 || aff1 != domain_id || BIT(aff0) != core_mask) {
+            continue;
+        }
+
+        if (power_on) {
+            if (!phytium_e2000_mhu_prepare_cpu_on(
+                    s, mpidr, &runtime_cpu_control, &secondary_entry)) {
+                return SCMI_GENERIC_ERROR;
+            }
+            /*
+             * BL1 publishes the resident EL3 secondary entry in a fixed
+             * vector slot. Some firmware reuses the temporary BL1 image
+             * before Linux requests CPU_ON, so reset directly into the
+             * published resident entry rather than a BL1 flash offset.
+             */
+            object_property_set_int(OBJECT(s->cpus[i]), "rvbar",
+                                    secondary_entry, &error_abort);
+            ret = arm_set_cpu_on_and_reset(mpidr);
+            if (ret == QEMU_ARM_POWERCTL_RET_SUCCESS &&
+                !phytium_e2000_mhu_complete_cpu_on(runtime_cpu_control)) {
+                return SCMI_GENERIC_ERROR;
+            }
+        } else {
+            ret = arm_set_cpu_off(mpidr);
+        }
+        return ret == QEMU_ARM_POWERCTL_RET_SUCCESS ?
+               SCMI_SUCCESS : SCMI_GENERIC_ERROR;
+    }
+
+    return SCMI_INVALID_PARAMETERS;
+}
+
+static void phytium_e2000_mhu_complete_scmi(PhytiumE2000MHUState *s)
+{
+    uint32_t header = phytium_e2000_scmi_readl(
+        PHYTIUM_E2000_SCMI_HEADER_OFFSET);
+    uint32_t len = MAX(phytium_e2000_scmi_readl(
+        PHYTIUM_E2000_SCMI_LEN_OFFSET), (uint32_t)sizeof(uint32_t));
+    int32_t scmi_status = SCMI_SUCCESS;
+
+    /*
+     * PBF issues clock and platform setup commands whose side effects do not
+     * affect modeled devices. Preserve their payload length and acknowledge
+     * them; only messages that change modeled CPU state need special handling.
+     */
+    if (SCMI_PROTOCOL_ID(header) == SCMI_PROTOCOL_PHYTIUM &&
+        SCMI_MESSAGE_ID(header) == SCMI_PHYTIUM_GET_PSOSTAT) {
+        phytium_e2000_scmi_writel(PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET + 4,
+                                  phytium_e2000_mhu_psostat(s));
+        len = 3 * sizeof(uint32_t);
+    } else if (SCMI_PROTOCOL_ID(header) == SCMI_PROTOCOL_POWER_DOMAIN &&
+               SCMI_MESSAGE_ID(header) == SCMI_POWER_STATE_SET) {
+        scmi_status = phytium_e2000_mhu_set_power_state(s);
+        len = 2 * sizeof(uint32_t);
+    }
+
+    phytium_e2000_scmi_writel(PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET,
+                              scmi_status);
+    phytium_e2000_scmi_publish(len);
 }
 
 void phytium_e2000_mhu_seed_mailbox(void)
@@ -88,18 +379,22 @@ void phytium_e2000_mhu_seed_mailbox(void)
      * PBR leaves the shared channel available before releasing PBF. Seed the
      * same ownership and success state even before the first doorbell write.
      */
-    phytium_e2000_mhu_complete_scmi();
+    phytium_e2000_scmi_writel(PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET,
+                              SCMI_SUCCESS);
+    phytium_e2000_scmi_publish(sizeof(uint32_t));
 }
 
 static void phytium_e2000_mhu_doorbell_post_write(RegisterInfo *reg,
                                                   uint64_t value)
 {
+    PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(reg->opaque);
+
     /*
      * Complete requests synchronously because no separate SCP CPU executes in
      * this model. Zero writes only update doorbell storage.
      */
     if (value) {
-        phytium_e2000_mhu_complete_scmi();
+        phytium_e2000_mhu_complete_scmi(s);
     }
 }
 
@@ -138,6 +433,36 @@ static void phytium_e2000_mhu_reset(DeviceState *dev)
     }
 }
 
+void phytium_e2000_mhu_connect_cpu(PhytiumE2000MHUState *s,
+                                   unsigned int index, uint64_t mpidr,
+                                   CPUState *cpu)
+{
+    g_assert(!DEVICE(s)->realized);
+    g_assert(index < PHYTIUM_E2000_MHU_MAX_CPUS);
+    g_assert(index == s->num_cpus);
+    g_assert(cpu);
+
+    object_ref(OBJECT(cpu));
+    s->cpus[index] = cpu;
+    s->cpu_mpidrs[index] = mpidr;
+    s->num_cpus++;
+}
+
+void phytium_e2000_mhu_set_secondary_vector_slot(PhytiumE2000MHUState *s,
+                                                 hwaddr slot)
+{
+    /*
+     * This is immutable firmware configuration, not guest-programmable MHU
+     * state.  Requiring it before realization prevents CPU_ON from observing
+     * a partially configured transport.
+     */
+    g_assert(!DEVICE(s)->realized);
+    g_assert(!s->secondary_vector_slot);
+    g_assert(slot && QEMU_IS_ALIGNED(slot, sizeof(uint64_t)));
+
+    s->secondary_vector_slot = slot;
+}
+
 static void phytium_e2000_mhu_init(Object *obj)
 {
     PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(obj);
@@ -150,6 +475,16 @@ static void phytium_e2000_mhu_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
 }
 
+static void phytium_e2000_mhu_finalize(Object *obj)
+{
+    PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(obj);
+    unsigned int i;
+
+    for (i = 0; i < s->num_cpus; i++) {
+        object_unref(OBJECT(s->cpus[i]));
+    }
+}
+
 static const VMStateDescription phytium_e2000_mhu_vmsd = {
     .name = TYPE_PHYTIUM_E2000_MHU,
     .version_id = 1,
@@ -174,6 +509,7 @@ static const TypeInfo phytium_e2000_mhu_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PhytiumE2000MHUState),
     .instance_init = phytium_e2000_mhu_init,
+    .instance_finalize = phytium_e2000_mhu_finalize,
     .class_init = phytium_e2000_mhu_class_init,
 };
 
diff --git a/hw/misc/phytium_e2000_pbr.c b/hw/misc/phytium_e2000_pbr.c
index 4485f073e1..d6f7b3b26e 100644
--- a/hw/misc/phytium_e2000_pbr.c
+++ b/hw/misc/phytium_e2000_pbr.c
@@ -55,9 +55,38 @@ REG32(ETH_TRAINING_STATUS, 0x60)
 #define PHYTIUM_E2000_BL1_SIZE                      0x00090000
 #define PHYTIUM_E2000_PBR_BL1_RUNTIME_BASE          0xf8c40000
 
+/*
+ * This is not a published PBF structure.  It is the smallest instruction and
+ * literal window that identifies the secondary-CPU handoff in each inspected
+ * BL1 image.  Keep the offsets named so the checks below document which parts
+ * of the recovered sequence are treated as its compatibility contract.
+ *
+ *   +0x00  BL  <select/check primary CPU>
+ *   +0x04  CBZ W0, <primary path>
+ *   +0x10  MRS X0, MPIDR_EL1
+ *   +0x48  literal: PHYTIUM_E2000_PBR_ROOT
+ *   +0x50  literal: address of the runtime secondary-vector slot
+ *
+ * Instructions between these anchors may change between compiler builds and
+ * are deliberately not matched.
+ */
+#define PHYTIUM_E2000_BL1_HANDOFF_SIZE              0x58
+#define PHYTIUM_E2000_BL1_HANDOFF_BL_OFFSET         0x00
+#define PHYTIUM_E2000_BL1_HANDOFF_CBZ_OFFSET        0x04
+#define PHYTIUM_E2000_BL1_HANDOFF_MPIDR_OFFSET      0x10
+#define PHYTIUM_E2000_BL1_HANDOFF_ROOT_OFFSET       0x48
+#define PHYTIUM_E2000_BL1_HANDOFF_SLOT_OFFSET       0x50
+
+/* AArch64 BL has a six-bit opcode and a build-dependent imm26 displacement */
+#define PHYTIUM_E2000_BL1_HANDOFF_BRANCH_MASK       0xfc000000
+#define PHYTIUM_E2000_BL1_HANDOFF_BRANCH            0x94000000
+
+/* Match CBZ W0 while ignoring its build-dependent imm19 displacement */
+#define PHYTIUM_E2000_BL1_HANDOFF_CBZ_W0_MASK       0xff00001f
+#define PHYTIUM_E2000_BL1_HANDOFF_CBZ_W0            0x34000000
+#define PHYTIUM_E2000_BL1_SECONDARY_ENTRY_MPIDR     0xd53800a0
+
 #define PHYTIUM_E2000_PBR_ROOT_OFFSET 0x00000f00
-#define PHYTIUM_E2000_PBR_ROOT        \
-    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x1000)
 #define PHYTIUM_E2000_PBR_PARAM_NODE  \
     (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x10a0)
 #define PHYTIUM_E2000_PBR_PARAM_SLOT  \
@@ -249,6 +278,8 @@ struct PhytiumE2000PBRState {
     unsigned int num_cpus;
     bool firmware_loaded;
     int32_t primary_cpu;
+    /* Physical address of the vector slot recovered from the BL1 handoff */
+    hwaddr secondary_vector_slot;
     uint32_t parameter_sizes[PHYTIUM_E2000_PBF_PARAM_COUNT];
     PhytiumE2000TfaIoHandoff tfa_io;
     uint8_t *iacc_image;
@@ -752,6 +783,89 @@ static bool phytium_e2000_pbr_tfa_io_handoff_valid(
     return true;
 }
 
+static bool phytium_e2000_pbr_secondary_handoff(const uint8_t *bl1,
+                                                hwaddr *vector_slot,
+                                                Error **errp)
+{
+    /* Zero is also the invalid-slot value, so it can represent no match */
+    hwaddr match = 0;
+    size_t offset;
+
+    /*
+     * The 2 GiB and 4 GiB Phytium Pi SDK images and the COMe SDK image all
+     * expose the same BL1 secondary reset ABI. It checks whether this CPU is
+     * the PBF-selected primary, matches the requested MPIDR through the PBR
+     * CPU-control block, and branches through a runtime entry pointer.
+     *
+     * Compiler placement and branch displacements are not part of that ABI.
+     * Scan BL1 for its invariant instruction and PBR-root anchors, ignoring
+     * the immediate fields of BL and CBZ, then obtain the vector-slot address
+     * from the adjacent literal. This permits another compatible PBF build to
+     * move the trampoline or its published entry slot without adding a QEMU
+     * constant. The interface specifications do not publish this sequence,
+     * so reject missing, ambiguous, or malformed matches.
+     */
+    /* AArch64 instructions are four-byte aligned throughout the BL1 image */
+    for (offset = 0; offset <= PHYTIUM_E2000_BL1_SIZE -
+                                   PHYTIUM_E2000_BL1_HANDOFF_SIZE;
+         offset += 4) {
+        const uint8_t *candidate = bl1 + offset;
+        hwaddr slot;
+
+        /*
+         * BL and CBZ establish the control-flow shape but their relative
+         * targets move with the code.  The exact MRS instruction establishes
+         * that the path is selecting a physical CPU.  Finally, the PBR root
+         * literal ties the otherwise generic instruction sequence to this
+         * firmware handoff rather than to an unrelated BL1 routine.
+         */
+        if ((ldl_le_p(candidate +
+                      PHYTIUM_E2000_BL1_HANDOFF_BL_OFFSET) &
+             PHYTIUM_E2000_BL1_HANDOFF_BRANCH_MASK) !=
+                PHYTIUM_E2000_BL1_HANDOFF_BRANCH ||
+            (ldl_le_p(candidate +
+                      PHYTIUM_E2000_BL1_HANDOFF_CBZ_OFFSET) &
+             PHYTIUM_E2000_BL1_HANDOFF_CBZ_W0_MASK) !=
+                PHYTIUM_E2000_BL1_HANDOFF_CBZ_W0 ||
+            ldl_le_p(candidate +
+                     PHYTIUM_E2000_BL1_HANDOFF_MPIDR_OFFSET) !=
+                PHYTIUM_E2000_BL1_SECONDARY_ENTRY_MPIDR ||
+            ldq_le_p(candidate +
+                     PHYTIUM_E2000_BL1_HANDOFF_ROOT_OFFSET) !=
+                PHYTIUM_E2000_PBR_ROOT) {
+            continue;
+        }
+
+        /*
+         * The literal contains the slot address, not the secondary entry.
+         * BL1 publishes the resident entry into that slot later at runtime.
+         */
+        slot = ldq_le_p(candidate +
+                        PHYTIUM_E2000_BL1_HANDOFF_SLOT_OFFSET);
+        if (!slot || !QEMU_IS_ALIGNED(slot, sizeof(uint64_t))) {
+            error_setg(errp, "PBR firmware BL1 secondary vector slot is "
+                       "invalid");
+            return false;
+        }
+        /* Multiple candidates would make the inferred ABI unsafe to use */
+        if (match) {
+            error_setg(errp, "PBR firmware BL1 secondary reset ABI is "
+                       "ambiguous");
+            return false;
+        }
+        match = slot;
+    }
+
+    if (!match) {
+        error_setg(errp, "PBR firmware BL1 secondary reset ABI is not "
+                   "recognized");
+        return false;
+    }
+
+    *vector_slot = match;
+    return true;
+}
+
 static bool phytium_e2000_pbr_parse_firmware(PhytiumE2000PBRState *s,
                                              const uint8_t *data,
                                              size_t size, Error **errp)
@@ -767,6 +881,18 @@ static bool phytium_e2000_pbr_parse_firmware(PhytiumE2000PBRState *s,
         return false;
     }
 
+    /*
+     * Discover the handoff while the complete FIP image is available.  Only
+     * its validated slot address is retained; the runtime entry is
+     * intentionally not cached because firmware does not publish it until
+     * after BL1 starts.
+     */
+    if (!phytium_e2000_pbr_secondary_handoff(
+            data + PHYTIUM_E2000_BL1_FLASH_OFFSET,
+            &s->secondary_vector_slot, errp)) {
+        return false;
+    }
+
     if (!phytium_e2000_pbr_parameter_valid(data, size,
                                            &phytium_e2000_pbf_summary,
                                            NULL, errp)) {
@@ -803,8 +929,7 @@ static bool phytium_e2000_pbr_parse_firmware(PhytiumE2000PBRState *s,
         return false;
     }
 
-    bl1_end = PHYTIUM_E2000_PBR_BL1_RUNTIME_BASE +
-              PHYTIUM_E2000_BL1_SIZE;
+    bl1_end = PHYTIUM_E2000_PBR_BL1_RUNTIME_BASE + PHYTIUM_E2000_BL1_SIZE;
     if (s->ram_size < bl1_end - s->ram_base) {
         error_setg(errp, "PBR firmware requires RAM to cover PBF runtime "
                    "address 0x%" HWADDR_PRIx "; use -m 2G",
@@ -927,6 +1052,19 @@ static void phytium_e2000_pbr_seed_shared(PhytiumE2000PBRState *s)
      */
     stq_le_p(sram + PHYTIUM_E2000_PBR_ROOT_OFFSET,
              PHYTIUM_E2000_PBR_ROOT);
+    /*
+     * This PBR-owned CPU-control block remains private to the BL1 reset
+     * trampoline after PBF relocates the EL3 object graph. The SCP copies a
+     * POWER_STATE_SET target to +0x08 before releasing a secondary. The
+     * leading 0xffaabbcc value is the reset-state sentinel polled by BL1.
+     * These pointer and sentinel values are present in all three inspected
+     * firmware families and independently in the earlier external Phytium Pi
+     * model.
+     */
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_ROOT - sram_base),
+             PHYTIUM_E2000_PBR_CPU_CONTROL);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_CPU_CONTROL - sram_base),
+             PHYTIUM_E2000_PBR_CPU_CONTROL_MAGIC);
     stq_le_p(sram + (PHYTIUM_E2000_PBR_ROOT - sram_base) + 0x10,
              PHYTIUM_E2000_PBR_PARAM_NODE);
     stq_le_p(sram + (PHYTIUM_E2000_PBR_PARAM_NODE - sram_base) + 0x18,
@@ -1095,6 +1233,13 @@ int phytium_e2000_pbr_primary_cpu(PhytiumE2000PBRState *s)
     return s->primary_cpu;
 }
 
+hwaddr phytium_e2000_pbr_secondary_vector_slot(PhytiumE2000PBRState *s)
+{
+    g_assert(s->firmware_loaded);
+    g_assert(s->secondary_vector_slot);
+    return s->secondary_vector_slot;
+}
+
 void phytium_e2000_pbr_connect_cpu(PhytiumE2000PBRState *s,
                                    unsigned int index, CPUState *cpu)
 {
-- 
2.53.0


