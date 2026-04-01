Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654F610F9315
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jyz-0007kQ-IJ; Tue, 31 Mar 2026 21:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jyu-0007i3-7H; Tue, 31 Mar 2026 21:02:52 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jyr-0007bB-4T; Tue, 31 Mar 2026 21:02:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upJb7gdVXbsi71ivDCP25Zdkvua6iuNhe5KKPAQM1EoUITFO1EcitKUpXOdL5aG2TC+tiPxWNAmQCyHurcSG5eE7dy/swWjaTmgOs/s0YkwsWNQ/KOdWX/qPHlgV9mxAEKIWef0lSMLjID/7joDOh7JFT+NaBB84Z6b/XsFO4BycWs4YgeZAoz1QqkkjzdQgYZTQ8/T5p7Nmhx+TPs4iC6FGtxEktdxr5fC9UkV2PmiBDZqaAi+v4g94xFrHwWorYx4b4niN9bJUM/G0HlA2DuBvBKmBO0qHIsVHY/047mJCztGB7iSNYzmiSYIu5mT03S0MOSKR1OefplOSw9Oy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ5M0spLOC7jaaaPGybjHhVhMsxlC1rDm3n/SvM4A40=;
 b=rpK8ZMfaTcEU8nU+hFNiV/kzwkuMlyAEVzaNDYCRe0lY5ZtF1c40VGjgflZoAJajWmEoja3VP4fYERaBoz66oodaT0Bqo9bZVvaKkcahVmSle6SFzAtItA+RNoUTo0rWMFgD+N7Hun3JqtOmVoJFQuSnyp8MEY94xQHa3yeRpHkUGJQm6+xo2ZWFGCNjsQNi/1KYJlHkOnvixq+X68i/6SWNCLRPLGfcMH4C9LA/L/rNb9/QSJYwtb6p6MmDzBmZXcS2PjN3fhU6hLdUYaI+obLf9mzhVJNc0eNxgfXX4cqGIX/7TYrWuNRUOch6kOtctlaNd+zFQqprFmiCun9tEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ5M0spLOC7jaaaPGybjHhVhMsxlC1rDm3n/SvM4A40=;
 b=ZU5m20UaS79oO7q4QwdS9ztr57ECda/Er/fbRX9iM+wVxjhqknA7fjzsROrlPeepvFVoDkNtAvzF1TRYgMrza47LBpFolP50Zls3aMRcR8U1kSaZXPT5mj7HSmEF2jWFkoYvsMmdsiRY3enaACTxx3x5h+3SBfxeAipEX4dIywK7cQpet1fNHON7WfnJKt9poTSetAOagnxCUiZVjoG/eTXwC6CaBZlickz/C0dkVGWQUEURYxZ2NM6yrsiq1Gsti+mSZWpEDWbs8WS/fjtMq4WC7eCVGHmeM4iaYVgiGap8XEzr9B78XxDOXjZXteIOPlqiTfZoyB1UR3gQAjwpZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 01:02:36 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:36 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH 01/11] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Date: Tue, 31 Mar 2026 18:02:21 -0700
Message-ID: <20260401010231.4166776-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 090e9568-1615-49db-583f-08de8f8a5cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2GoDOoidtvSAZSsB1JZ46qjqkauC9s8j2uuSJFlrDHWQCCJ0LQWxjGM2ZKANlUF3B8q6vIIO3ovfB2rXFt3uIqDXeQ6M4CzTMQwlJM/yVmz0e6vK48y2eZ/7xwNWLm8VO9wceOFAExcWfci9YWHnyM1+5lVN2tp6qGyYFcfFEtf6orbeRF2lYp4TWVWnranOlsTE6keQQd8O5YyjGaVH5L5dW+1/eq8IBzSHDpRKkmAY6x/E85wkryLSgVnQJBZB/YmUyWqWu8T8LI5jrEWnGOBDS2b9x4xoH0LK+tP6myJfU82R8yuo/5SGvvR3Fc2CvIBx2T1qcJzkEa0p1VJauR813DnTv2tRE3q6/Yv8DE+FDARUAntVnqNRNM+fVZTKHylw2fj0VTn1uyMUUrTUBjptmTh1K2kb/I6pypGEjrne46+XA8ZiWm9YqwqyAyhZiPY44oJHVMYwpiWKJ09gfJZvJp7rZWyq26gRcBQWwXzB9Av2GmZRzzBS2fQfIUpAje12bMRNsWV2BfDjv8keCKev8eK9TEIgW+2qADBCC+4jn6lXm2LPWTLzdC1ryOzfTgCPoVjZUdoS02z5/eW8lYN5SjwxDx/X2wIUn4oykD1aWgW2NXKk2tEZCjIyXzuudAsfYS47tCaKhhcpQvaiIFyWQbfaB3AKbu14o5l2cy0Z1ICa4HtWtrHXUu8welxznqafahV6QLVcSM7i95TmL/qP4FQ2bASqmK5Ab3bNLqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQEq9IjN+Njts9gb1QdnBWkb7IBVAqKCN8RFn30+0XHDpbdtpa/Wc1+QjPLw?=
 =?us-ascii?Q?pVRx3UYatrA/DvlwAhqnrMrJy8Ogapho25sA8n7Zag6QE+r+5zAdB/DVE5IK?=
 =?us-ascii?Q?5/LtzLFaEh7P0mvLb3VBjiYLhlUovDSyUfS4PxK5J75Tsh4IvqpP//P9Cfjl?=
 =?us-ascii?Q?IC3mLAN/MNR0m4FZmVaP+2oAmmlB1Rzfdz0KiEzlSamC0nEUMaTU9WTvRUJO?=
 =?us-ascii?Q?KRFH9yIZWp3d4Fyr6iLaCqJ4gve6TQOD7ushSty5vAr8rJL3KDtpWZ4NOUNZ?=
 =?us-ascii?Q?ls3VZwfFfcYbDPkLjWdbO1oL0m9yxmpjhOlFq14AmMMnSDxmlhbLf3nSmShc?=
 =?us-ascii?Q?aeahsLXWs3kjyaZbEQPxUSzA6JTvRs4Qm0YE8ftDP1it7yLhJbNyBBdFUgnU?=
 =?us-ascii?Q?7XQ2ZwgBgLNINuoTPHbu5fKF4y5fDd4KPduWtrbhXjhfAcyApMRP1Gh+AujB?=
 =?us-ascii?Q?Fmu2NnJVngDkyZnvtCRheuRR4GgjI49REFPUtyFURt9Vl6DwP4og7S5pgz6H?=
 =?us-ascii?Q?YQLjVQkEIPckhni2VwdWGR1QXLbxBuJDLtwDDZd5qaNcfWIG8BXbJxlW4cLS?=
 =?us-ascii?Q?w7RQf98O617tMLUl0mfRgBp8kTX7KSa7QNlqOi7asZabVJgJHCqlEYgwFS11?=
 =?us-ascii?Q?iLjbJHgTApvTnk/NK/9rJqUREEOCvNKq57wS2NU938Q4UPrcdG6j5BGIWZgf?=
 =?us-ascii?Q?XUvHTNS4+HEmLj+Z76Avdwv98R/P7UNMmAAEnUuoszMtzJh9CcfFY8xShBuy?=
 =?us-ascii?Q?t9jVEaUBVGhy13Kmz3zUFjEUgqNa7vjILC0Qq0HUPF+IboqbPzfOegXxwIPA?=
 =?us-ascii?Q?2p7NF3J2GwQ9LaA5RkumFYNY5T1tOaI+dlOghuiORZGh/3yDnJ8M0VeCryym?=
 =?us-ascii?Q?EDY036C74dVxQSR+M2rE8Ae0rsE4gqnsMH6EDSNbPBEgp4lYyWtV2iDv3ISL?=
 =?us-ascii?Q?/SkqtoYTpoyK3b6BrW554yj2/YzOpOhLx0SzDBKeXFYbkho1x24PrTyM48lr?=
 =?us-ascii?Q?antNaK/TP/nGDwbFLOI78pQ2qfm8TSWZt9dmVq6aO0Cug3QLo9C6WE8Eh312?=
 =?us-ascii?Q?Y0DWtTUs2lSGjmdq2iKK+eMuKgt+vdxuha/VTF/SVKl73UzxO2TagRrLhtZZ?=
 =?us-ascii?Q?loITfgnSpip8aYmTGN6zLDUfnYChqY9bzDPYfnOLcf64ws2GQj3ezQfAClb0?=
 =?us-ascii?Q?w6dXdfQZ7yVmKCUgg32egktkWqH/5qECqFhUF0aDVSa8kUyZsxbUxLp6UhMf?=
 =?us-ascii?Q?E4mBGDt1VD0dHMn/Dfp8fM8x50y3nDgOHfLaZHBYrI00X43p35AUDTEd+Oum?=
 =?us-ascii?Q?rc1wBfFaoC2yHXyxZUxFstoBlSQLZLM5h7fjB+RML3jKSPVn/PTTJcRiwS/Z?=
 =?us-ascii?Q?Z852sO9ml8badtbhWXxgM1BPrW1GTpXBLuGXEZZnkSz8I19QLzgZRCzpTiJx?=
 =?us-ascii?Q?EeZDh/1xZ3MTYMi1dF6u3eKsSvGyMASArR7i3zHrgKMUYz/dIM0ggimX8zt7?=
 =?us-ascii?Q?eKZw2TyO8vIxu8sWrUIbGkTaDufuftd+jaCjQdl3O3H9YeHNeX73vCN5C/xp?=
 =?us-ascii?Q?Riv7h1q2dMRUlg4TQZMWTadcjpxYTA1i/+x98P65G4Jmaq2yrl5Y7uHmj2if?=
 =?us-ascii?Q?IrVrr4cCjbUE9x7M/qN+2s+VxfCQ+mMyJ78f2Ed9Vy3wGWLuIQ7sqjKJN1Bc?=
 =?us-ascii?Q?kqfhDQIbuD8gOdqpoSPJkTRz9Pp1LzRpN6kH+Yowb3pZXushU7Y6pS1/5++o?=
 =?us-ascii?Q?Z7fiRzA2sQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090e9568-1615-49db-583f-08de8f8a5cf4
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:36.2487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt61Mh4tH+Dn3kuMDn4c7bXgF0UAeWN/0/AY0LxOM57m0eDiaUwpUNdyPlkN+qJ7+Kz+qoxRc8tK3ceUKEDkkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nathanc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Introduce smmuv3_accel_auto_finalise() to resolve properties that are
set to 'auto' for accelerated SMMUv3. This helper function allows
properties such as ats, ril, ssidsize, and oas support to be resolved
from host IOMMU capabilities via IOMMU_GET_HW_INFO.

Auto mode requires at least one cold-plugged device to retrieve and
finalise these properties. Register a machine_init_done notifier to
verify this requirement and fail boot if it is not met.

Hot-plugged devices into an accel SMMUv3-associated bus will re-use
the resolved host values from the initial cold-plug.

Subsequent patches will make use of this helper to resolve 'auto' to
what is reported by host IOMMU capabilities.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 14 ++++++++++++++
 hw/arm/smmuv3-accel.h   |  2 ++
 hw/arm/smmuv3.c         | 20 ++++++++++++++++++++
 include/hw/arm/smmuv3.h |  2 ++
 4 files changed, 38 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 65c2f44880..a0146c8d31 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -35,11 +35,25 @@ static int smmuv3_oas_bits(uint32_t oas)
     return map[oas];
 }
 
+static void smmuv3_accel_auto_finalise(SMMUv3State *s,
+                                       struct iommu_hw_info_arm_smmuv3 *info) {
+    SMMUv3AccelState *accel = s->s_accel;
+
+    /* Return if no auto for any or finalised already */
+    if (!accel->auto_mode || accel->auto_finalised) {
+        return;
+    }
+
+    accel->auto_finalised = true;
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
                                  Error **errp)
 {
+    smmuv3_accel_auto_finalise(s, info);
+
     /* QEMU SMMUv3 supports both linear and 2-level stream tables */
     if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
                 FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index dba6c71de5..3c1cd55714 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -26,6 +26,8 @@ typedef struct SMMUv3AccelState {
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+    bool auto_mode;
+    bool auto_finalised;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7fead1c3cf..09ea08eb18 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -37,6 +37,7 @@
 #include "smmuv3-accel.h"
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
+#include "system/system.h"
 
 #define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
                                         (cfg)->record_faults) || \
@@ -2020,6 +2021,22 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     return true;
 }
 
+static void smmuv3_machine_done(Notifier *notifier, void *data)
+{
+    SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (!s->accel) {
+        return;
+    }
+
+    if (accel->auto_mode && !accel->auto_finalised) {
+        error_report("arm-smmuv3 accel=on with 'auto' properties requires "
+                     "at least one cold-plugged VFIO device");
+        exit(1);
+    }
+}
+
 static void smmu_realize(DeviceState *d, Error **errp)
 {
     SMMUState *sys = ARM_SMMU(d);
@@ -2058,6 +2075,9 @@ static void smmu_realize(DeviceState *d, Error **errp)
 
     smmu_init_irq(s, dev);
     smmuv3_init_id_regs(s);
+
+    s->machine_done.notify = smmuv3_machine_done;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
 }
 
 static const VMStateDescription vmstate_smmuv3_queue = {
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 82f18eb090..fe0493c1aa 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -74,6 +74,8 @@ struct SMMUv3State {
     OnOffAuto ats;
     OasMode oas;
     SsidSizeMode ssidsize;
+
+    Notifier machine_done;
 };
 
 typedef enum {
-- 
2.43.0


