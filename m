Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9A4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DqI-0004Qw-1K; Thu, 02 Oct 2025 03:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4DqD-0004N5-Qv; Thu, 02 Oct 2025 03:35:06 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4Dq3-0008Gj-Rc; Thu, 02 Oct 2025 03:35:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+e8/ygZnhJ18C66Uv/AT3ACazcYMyi4jw+KFKR4fzoDq+yxrJ5ovTfr6DHxpXhgbTMKCIJbLWLHStjMhv7I+NtbKf/AptGpiKgGqwahVx5hgy6s9njriZTcD3E/2obPyKK2/bZMFjcdAKFXttLYIsSkIS+G2Oo5rkBDTxfS/injW10Tze+DyO8v4wFWEr/fJjByJPKgDKyZWj2CrJPzVjUcoOnqGKZwL3+JhNm3R5VZ6hj1npb09o8ps7hl6vC+Bz6nRpxXPvRdwkWZYQ4RHack37VHdYrJJvpVMKhbt7lBkKWGpR536wgWwoluCdMrSglcPMkdsPS09YShYmvXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjnsFIsjoVxuCTrBHodTtI0zsedfvB9gNvNTJjhepug=;
 b=LyEscXzJ4QfV+5N9rf9J6Y51GDlLWdYgNXeJNkL04zBigapqPbop4tkspEMeLCvWxoGT3hav5jTpBi1rt8FYKnRQdVVj97cYyWAI6fhedJBR8KpzaPs/QBtCov997szxM8HI9gfS3tINjaRFosrmeba0ZWFUCiPRvPrKkiPeplA+k3cg1D/qsjSuRduLa3Q4Kp4Ej+eLcvnezN3l6o91XLO9zlKBf9AAjDumW7n73Y2i9p/NoVkeTt+RuK2H1aL3+c5UR7/Qdl1H8jx/a8T8kmQ154bsA6qtXHrnSqKLYp1ed+6J56EOsNUijuRYyavkc7r6CP6YDrwbiCrnSnygQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjnsFIsjoVxuCTrBHodTtI0zsedfvB9gNvNTJjhepug=;
 b=hSFDemmCZuARyBziuAu8e5znc7GCrctze38WPN3HvffZuO4XGRfC2vbHe7lYtrynQoqlqDEHM3aGQF24NNoFPGA9Yn8ASOUuVzODNhcH/iwuABkq4CsxzKf4lqMotUyni4sk6z6ZE+lMaKU/9mp4orFQHjC3nJOMyg3UPseIqBs=
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by IA0PPF04DCE520E.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 2 Oct
 2025 07:34:37 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::dd) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 07:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 07:34:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 00:34:35 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Oct
 2025 02:34:35 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 2 Oct 2025 00:34:34 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Vikram
 Garhwal" <vikram.garhwal@bytedance.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v2 2/7] hw/core/register: add the REGISTER_ARRAY type
Date: Thu, 2 Oct 2025 09:34:11 +0200
Message-ID: <20251002073418.109375-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002073418.109375-1-luc.michel@amd.com>
References: <20251002073418.109375-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b7f9ce-b914-4799-d6fb-08de01862388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l7ZueLPwmPZ62IG9ypuzZ2o7pGe0x1+7maiwYOT1zcqHqg3lYaTkJPvOFPp7?=
 =?us-ascii?Q?uaNTfp6ZEqTA0EsaCMgFoWFr1gtjnXb4beQTexBA/P9++RDxEJyR0gFxNaRh?=
 =?us-ascii?Q?Znhyg1+HUvVz7WoOq3mMc7PDQS1T+4FgoxfwhSRNDmedMl4Q/z1/CZJtREQR?=
 =?us-ascii?Q?ORR3sgpy83MihhosMafULRfbdougs1/nqe/oIXUr2iC5utGVI/dnYkindNYL?=
 =?us-ascii?Q?54U7vlBjnRMv+sh8jgFn1fRc5dzWNWxwEZlZqfguGawv6XxThYFtbJqK2zDW?=
 =?us-ascii?Q?obSuiE+J9+KVaezikzQQR5+CEuuzHJIQ909AovhfsqF53dBkZ796HDd7+a4c?=
 =?us-ascii?Q?JeVMGd+pyDqox6OwZyyc3YSITmfYu7PCdQTcBtx7Ri2bKcRKV/3ieBhBlFnl?=
 =?us-ascii?Q?Nbm6gEDn65hUBLd0YS6+m9WekkeAiEEsfm6sQpAgIg8dXNqHIU8zHQ56YpJZ?=
 =?us-ascii?Q?42KcNnZBCrgB3atuOwURmT917pC+OKXtfdGrknB/vnjPqBfqX/xuXRYkbytv?=
 =?us-ascii?Q?5dPhUrE+Bf1nA7cqDHPHaynPJ5rZrituwv09HHq3TOFEH0CNQhYdMhgcZ3uX?=
 =?us-ascii?Q?hLNvECepd1OJ8ibsu1/gDNHbgDCsFopVzzgVrnRE5TetYs7/WAd49JIfKNJw?=
 =?us-ascii?Q?J5FDSDpUiBrk+OlVngE9CdiEpNLNGoEIsmEhn1zld728Cd3p/Cy2i6XRUXha?=
 =?us-ascii?Q?YWGgcG5sbjZpneaz2Ava/DGk9qR3tjD1pqLvngtZM+b+/e3Nzwryz9eJcEPd?=
 =?us-ascii?Q?/bqAidu/xJpDaW1krcDkX0F8wFSkcBWRKvJlfJHPnSdJZYPX/yfCJKa74kgY?=
 =?us-ascii?Q?0Zwt+Z1wz38ZdtAlIUnR3Pa/ZyeeNajUHH9ZSiWUMjQB61W+J9GYUBdek7sc?=
 =?us-ascii?Q?S/yzsMwzueveQDsADtysZ/Mnm4SpCdabMJUgrI98MWw8HiZ1ShJLeSuG8mO/?=
 =?us-ascii?Q?ma22pIeU/ESEFK7l7ZwMVIHVMX+rw2gvdqnxFjoyQjxWBdhtSlnFbz7o1Ls1?=
 =?us-ascii?Q?eCzcA6zOB+dzmUaj7MH0HC0gr3DVpUSilWbBCa2DiVxtaOxu+DxVQIR+7w+G?=
 =?us-ascii?Q?yDL3oPsbEwhZaabmv+Pfmd+HioYtpq9vNXlbsrOAGCiTR/X2mXEg3enCZ4em?=
 =?us-ascii?Q?cs4SLhZ3POOf7XGNsARiPUpvgEmWe/NKDRQ9Iw3XXkFbIR6lEcq8DQozFpEp?=
 =?us-ascii?Q?Z+YffSoz8eBggyH13+rxAvK8JVi/nZuH5KJC8LkaFTKGeOLUVB8rJRbbAwRt?=
 =?us-ascii?Q?JYKFFDEXEY0iHZwNBQUnzB3XyWz2QZLtNE09T2HZ+a2LSVKaXvO7VUXkKbO/?=
 =?us-ascii?Q?lwjFtMD5U5J9lbMTNK0QqWgZUODELwScixwv8odn1AUacBxRzhxW3dQ/NBlx?=
 =?us-ascii?Q?RPV5Kz6yBTAzibMaPdIOV0fy1qEhS27tVubwAb+7jXl5Lzpf3jd643nLy5Ut?=
 =?us-ascii?Q?e1Z/8L3EWPKGnfK6lBGW4Zt3YXcGrFOo+3uobOBmIdBBp95XiwHPv3Thl117?=
 =?us-ascii?Q?drUt8ePcKNxrHxozRKnK9tzBRytLfofDPXN/aqIgj+Lap70WcInPEdFNw5XH?=
 =?us-ascii?Q?z71Hlp9aVuo1wBedvg8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:34:36.5239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b7f9ce-b914-4799-d6fb-08de01862388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Luc.Michel@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Introduce the REGISTER_ARRAY QOM type. This type reuses the existing
RegisterInfoArray struct. When `register_init_block' is called, it creates
a REGISTER_ARRAY object and parents it to the calling device. This way
it gets finalized when the device is.

The finalize function of the REGISTER_ARRAY type performs the necessary
cleaning that used to be done by `register_finalize_block'. The latter
is left empty and will be removed when all the register API users have
been refactored.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/register.h |  4 ++++
 hw/core/register.c    | 24 +++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index 4d13ea183c7..65c82600e06 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -81,10 +81,12 @@ struct RegisterInfo {
     const RegisterAccessInfo *access;
 
     void *opaque;
 };
 
+#define TYPE_REGISTER_ARRAY "qemu-register-array"
+OBJECT_DECLARE_SIMPLE_TYPE(RegisterInfoArray, REGISTER_ARRAY)
 
 /**
  * This structure is used to group all of the individual registers which are
  * modeled using the RegisterInfo structure.
  *
@@ -94,10 +96,12 @@ struct RegisterInfo {
  *
  * @mem: optional Memory region for the register
  */
 
 struct RegisterInfoArray {
+    Object parent_obj;
+
     MemoryRegion mem;
 
     int num_elements;
     RegisterInfo **r;
 
diff --git a/hw/core/register.c b/hw/core/register.c
index 2553cb15aba..70c33d97d8b 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -243,14 +243,20 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
                                               bool debug_enabled,
                                               uint64_t memory_size,
                                               size_t data_size_bits)
 {
     const char *device_prefix = object_get_typename(OBJECT(owner));
-    RegisterInfoArray *r_array = g_new0(RegisterInfoArray, 1);
+    Object *obj;
+    RegisterInfoArray *r_array;
     int data_size = data_size_bits >> 3;
     int i;
 
+    obj = object_new(TYPE_REGISTER_ARRAY);
+    object_property_add_child(OBJECT(owner), "reg-array[*]", obj);
+    object_unref(obj);
+
+    r_array = REGISTER_ARRAY(obj);
     r_array->r = g_new0(RegisterInfo *, num);
     r_array->num_elements = num;
     r_array->debug = debug_enabled;
     r_array->prefix = device_prefix;
 
@@ -307,17 +313,29 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
 {
     return register_init_block(owner, rae, num, ri, (void *)
                                data, ops, debug_enabled, memory_size, 64);
 }
 
-void register_finalize_block(RegisterInfoArray *r_array)
+static void register_array_finalize(Object *obj)
 {
+    RegisterInfoArray *r_array = REGISTER_ARRAY(obj);
+
     g_free(r_array->r);
-    g_free(r_array);
 }
 
+void register_finalize_block(RegisterInfoArray *r_array)
+{
+}
+
+static const TypeInfo register_array_info = {
+    .name  = TYPE_REGISTER_ARRAY,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(RegisterInfoArray),
+    .instance_finalize = register_array_finalize,
+};
 
 static void register_register_types(void)
 {
+    type_register_static(&register_array_info);
 }
 
 type_init(register_register_types)
-- 
2.51.0


