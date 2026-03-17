Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C1CFEDA06
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZJl-000462-T9; Tue, 17 Mar 2026 14:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJj-00044y-PN; Tue, 17 Mar 2026 14:38:59 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJg-0002se-Ka; Tue, 17 Mar 2026 14:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNqtcpQbm2tFH9xTJf59lWnSHokkUhjzDUjGrngzkNufrX0cFTLDmtUKJrz7Xopgv7La0oey7k1GKCJ3WjK1uVWDTjft3GzLPXcq0U6t6c9b0IlPQZVJvPEGMfu4ulXyE9MEoWXoXwt3ri320hlLIBfa6kR5zK7b43HTLunrtzDHdimgxP5XUQeAPLzC+coDt+wBaZRKzPgQPETCDfjuG/D+rTL/DTctnYy40QSpKw2ISsJcaUegpKPVa+/E1EIc3tfNZB17yFYt8VuRc8EipIVRPuZ+KNSKd5YHxwJwJuIyHNAmoRNniNitm1vayeFGz2FAhKoMuiUfYirusXcXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMTE5DO3vLis8+bWdnBr3fGcUfJHQ+Trm+OJn5b5FOU=;
 b=GpsUwG5/BjH22094/fvn5i3ONjLTZIWQpGVwM9oN6U3GONePlYVvMk1JZRGGC6fjli/HmoxHoHIrTQUWI1SVQEsXFDYBOXr4T6aL0s6xHww8r6srVpYxWtytxM0ZHPPVBcebXlci/WBXGKJADUGBQh/y3YyNIv/knS84Bhs7cSJcepz1vzJ9gY+cGDH3g8JP7wSomnzPCZnCipphkHGLrJCLN4PdF2SG4KPgCpSOW855ooSt2qxI2Bd1oEeaW7e+QBrHWzMeyTngvFWCnfAGKFc7OydjdLUNtxOrfL5vQiyTdvhnTL6/28SqLiRoW+kYfZqNj5j7tqX4StLPUIoKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMTE5DO3vLis8+bWdnBr3fGcUfJHQ+Trm+OJn5b5FOU=;
 b=E50pdQi5Gd1fIHdEO4/0iHgl7BWV+RaVhLdvNEjTyjfaNEppYxtDtWd8A/R+fqb7O1iADUox64hObiKRHyjjaHGYFGfq/QyAcOxa4is92gP+Fi6LSXb7boEtR8XSBz7iT2RrGNIwtqhlSykhQZkB+HGNdC3yCHx/Ld8BnWEk1IhA9FBlc8Nh0ZGWOJJvfBO0z+WCKfZDOQVC8o73xGEsZWNUXCps6J7l++k1tyAdUtKWoFGf9zWuWCpXUYUVlnanuJJGSqMjToRnxTCF2iv0N3w4JN2Em4MJd6vdEacogspwTGSbq1U46oq3EOM396CgG2CO9KA5Z81alTV5NCa/Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 18:38:34 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 18:38:34 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Date: Tue, 17 Mar 2026 11:37:52 -0700
Message-ID: <20260317183755.3721625-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317183755.3721625-1-nathanc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: a80ce673-883f-424c-7ee0-08de8454653a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: OalyPKU5fBnkyWlYQQ3d/R5ZuxUtwuHilZZc27Y2ZSVj6ZcKvTEilkO2n322VVIhZxnAT1FpAp0RqC4Ra1MLAIyyUembnBKWQZHnZ3Po9UTzgvOfvh000YRb7PjGvbj3T4YXwPfbgOpCE2PSWgpkgXtQMdkCQQwmryf1jq901f40OfBFGJl1pTQsTbxYbGicZ8qGo0lQN1xLGXFD2wARYfPRA3EhCWLbJw/J9oozxkzF0jAdVmnBlZM3Zm5RP3wO2TtMNCxbe686cwBYwmwlIg9Ug5eT7wvl8FdB/nDowZFeAyO27uSb+wUsxx93jCgM+ubb7/kGx1alubzr3eMi2ZCKM5PyhifZF28ROa/5GO2LHJRGEpj//XNtjihRSU7O99QS5CNCDewTusHlKc127ucJTqfcCEsltej8NpxaORHLkSl+CY1vtby5G4cJGwcycDyYfR3aURDPW3oqukhSFrAz27fLKH1kT11eqqlAs9293MZI2hNtRmCj/81IpiZgXioyEyOmXYOf6DQg6/mpcAXBHPjzY8/bjPbQEzIBQK8TmQaDDLpIO8ctLZPWuXEX7o4Sxs80+aeDcenY/co7JCwB6sZc/nVSq/PXFhhDJNT8aPnghi9rzfrkGaPfoKKU23oIvcBl4QMYFrP8LjdBtFMSeQ3HXaqvQy6RBRIQg6q8LMEb6RMUJYFvi10u1pQe5wcJL9Yl19cEnnuJJ/NUVLeB2s9q0jL0DcU0r0oPSG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59MkELvz7jYxSdEsamEFvCAuxpnBVm8cHYVlvX8TbF+Lr6kSjXU84/q80E4t?=
 =?us-ascii?Q?XI9c0Cu3F5L+sFlh+i6ayzr4YynECGjIEu5OH0qxtkISP2hjVJ6ux0LcDM89?=
 =?us-ascii?Q?PddpVzr/VEvMz5aeiQhTghendrNKxXu2iM9huiz1XVRVNz9PGSfPOB5D3FDP?=
 =?us-ascii?Q?aOleTj3UStELxk8UkJbV9/hNAnyFrkDujJQsmj89bGzT+bXAjfa+UaL1zozw?=
 =?us-ascii?Q?0P1kHyO+O0a9v1tkxfisan8DIqZyhugKdWaXfz6Z00SpSSBj6FiGy28RU3zv?=
 =?us-ascii?Q?CCVEW1VLYF90FxiwDHwANeqhz/RB0CdUFeVz/eDAoKJBVt9Pm96I+t32ntvP?=
 =?us-ascii?Q?VBI5L9N27awpBVi8snLVfqqxJLTMHOZER93qrUfVY5GF1PIAGgspiOVaOrS2?=
 =?us-ascii?Q?aYxIBqYpHdZm0XeCre6i8Ej8FmKiKIcOERjxxuy3mq/lD/kR1BYNPMk/9diB?=
 =?us-ascii?Q?FWZsaY29rWenkc6QnbYjJaSxPCpjJ1u+6OnmF/v94AUiPZKZjSYaXmKtc7Ui?=
 =?us-ascii?Q?MQeqRC1AOxSZuGgaaQH/76T7HxSN+bHbuoFKcqU5DUA1sY7OwhohaZlpTAv6?=
 =?us-ascii?Q?Bd/DCapBJ+DJwCUjzWWIjJ/xiusH1SZ0Zl7z0UX/iFQrAFUL/JOi67vI9vxN?=
 =?us-ascii?Q?zdBH39SDUBXKEe0zUCHGmAlD1Huv1IhBDf13x4Cq79oT1oMAuRgYvhgwkrFA?=
 =?us-ascii?Q?JjouDzk19deNiPVgizw7sWTPQD60Lvyq52p3sCzQhvTO6pS86BZDmEkmuUBd?=
 =?us-ascii?Q?1RBfrK4vUTxmBLsW40qaEOxUPTmOACMLgblEiTcNqt6dAUXmY2Mb2LEA5LTP?=
 =?us-ascii?Q?LCRXr7AsNRefSmeVqM+pv2DbcVW9g+UqB9SNv4IkQ+ar6R8iBEu6IqaaDmVP?=
 =?us-ascii?Q?HvhpzsWsFtnS8xJ25y4wZAiJY57EDOuoUKivDOVvBqlGfLxbp1trXSMdUj+y?=
 =?us-ascii?Q?/ZRr4SaH0NcfGgvhkmRFgGAoHkiyWRBZvY8QoCdC4uBbLFH72MN+x4whS50s?=
 =?us-ascii?Q?8/PfQOHfjYdRgzr1c7kRfgAfxQN1W8oTLy6yTAGpwL/TIQd+f1lIwF7m2qmN?=
 =?us-ascii?Q?kjNZFufoHHXKnvH6IAiDL1F2sAeJ6E2J+cXwz7vOjsZW2LyDfJRLbb0D6owU?=
 =?us-ascii?Q?3veCr9XZlxImBecEe1rb8xJRKgbDPFMltsH8+2R4Pl+Lke5W9UwffIJuf3cN?=
 =?us-ascii?Q?DPfqAG3W7l3knRoGFS8v4JK0naRm6DaW+WNwp7gEWhAv4DOa/tNnBC7VhaQm?=
 =?us-ascii?Q?c2F413STudgZhpiFsCeH1KUYDJ4b3PRalVM6Tx5sE6FpHhNjIGbg5pZGuIEz?=
 =?us-ascii?Q?PaGUUl0SUKBqMGlpBoPAmOc13/gYfeYNJWPZKtb//XlQIfTPb2EDkm1vxZdz?=
 =?us-ascii?Q?2ELVBKs/GZfbdyXZaopBF3veQbSujECEdOS+w7zVFzjs0+rdYWgmQArlVfUM?=
 =?us-ascii?Q?NMlA8Ic+XwPA4ddZTbS7/2fug4XRrXgg40CXAtr4EjtIQ+rejYHsCKpGQqt/?=
 =?us-ascii?Q?WTTSEH4PgCCYBor84IwzPJvFXVwFrAS+MUJOSMZOHM7kfsIjah7JFNgiusRF?=
 =?us-ascii?Q?WfTDe+0URDL/Lq2AzTmVa8YMY8gAo89b/OHGW/Qwxu8hxb7aH9geQ7LingIU?=
 =?us-ascii?Q?KqANgas5KpXva2Y9FtRrUBuBLxiuyMCm9PV7+ckqEYrgS7IlGddyEquT6qMF?=
 =?us-ascii?Q?TFAelkw0R0MhZcw+/i0WWOlpzXbH85xoaAoUt9KU/oOTu97muSWe3MCfOSJ2?=
 =?us-ascii?Q?JsYZI6sHSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80ce673-883f-424c-7ee0-08de8454653a
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:38:34.4981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vg9neZ6oz8E9jOthQR76p/i0LLyhJtwoHdVxNlJt4+p8fPoAUXuPxqeMEyVe5HBSICYhF/1Qu/H3XFipp5Lpog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nathanc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
The 'auto' value is not implemented, as this commit is meant to set the
property to the correct type and avoid breaking JSON/QMP when the auto
mode is introduced. A future patch will implement resolution of 'auto'
value to match the host SMMUv3 SSIDSIZE value.

Fixes: b8c6f8a69d27 ("hw/arm/smmuv3-accel: Make SubstreamID support configurable")
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 23 +++++++++++++++++++++--
 hw/arm/smmuv3.c         | 18 ++++++++++--------
 include/hw/arm/smmuv3.h |  3 ++-
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index ddd927fa80..c90fa9f5bb 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -802,7 +802,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
-    if (s->ssidsize) {
+    if (s->ssidsize > SSID_SIZE_MODE_0) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
     return flags;
@@ -817,6 +817,22 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
+/*
+ * This returns the value of a SsidSizeMode value offset by 1 to
+ * account for the enum values offset by 1 from actual values.
+ *
+ * SSID_SIZE_MODE_0 = 1, SSID_SIZE_MODE_1 = 2, etc. so return 0
+ * if SSID_SIZE_MODE_0 is passed as input, return 1 if
+ * SSID_SIZE_MODE_1 is passed as input, etc.
+ */
+static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
+{
+    if (mode == SSID_SIZE_MODE_AUTO) {
+        return 0;
+    }
+    return mode - 1;
+}
+
 void smmuv3_accel_idr_override(SMMUv3State *s)
 {
     if (!s->accel) {
@@ -842,7 +858,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
      * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
      * has enabled it.
      */
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
+    if (s->ssidsize > SSID_SIZE_MODE_0) {
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               ssidsize_mode_to_value(s->ssidsize));
+    }
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 40d6aca83e..e7fec7a69e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
@@ -625,7 +626,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     }
 
     /* Multiple context descriptors require SubstreamID support */
-    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
+    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
                 "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
                 "Configure ssidsize > 0 (requires accel=on)\n");
@@ -1984,7 +1985,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
-        if (s->ssidsize) {
+        if (s->ssidsize > SSID_SIZE_MODE_0) {
             error_setg(errp, "ssidsize can only be set if accel=on");
             return false;
         }
@@ -2008,13 +2009,13 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
-    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
-        error_setg(errp, "OAS can only be set to 44 or 48 bits");
+    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        error_setg(errp, "ssidsize cannot be set to auto");
         return false;
     }
-    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
-        error_setg(errp, "ssidsize must be in the range 0 to %d",
-                   SMMU_SSID_MAX_BITS);
+
+    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
+        error_setg(errp, "OAS can only be set to 44 or 48 bits");
         return false;
     }
 
@@ -2145,7 +2146,8 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
-    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
+    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
+                              SSID_SIZE_MODE_0),
 };
 
 static void smmuv3_instance_init(Object *obj)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index c35e599bbc..ddf472493d 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -21,6 +21,7 @@
 
 #include "hw/arm/smmu-common.h"
 #include "qom/object.h"
+#include "qapi/qapi-types-misc-arm.h"
 
 #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
 
@@ -72,7 +73,7 @@ struct SMMUv3State {
     OnOffAuto ril;
     OnOffAuto ats;
     uint8_t oas;
-    uint8_t ssidsize;
+    SsidSizeMode ssidsize;
 };
 
 typedef enum {
-- 
2.43.0


