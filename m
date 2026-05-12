Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E35CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMstY-0004QU-VS; Tue, 12 May 2026 15:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstV-0004Ph-9f; Tue, 12 May 2026 15:35:53 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstT-0005nm-Kr; Tue, 12 May 2026 15:35:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNgcg/kzEnrnE6kbMnGQOzT9mwXa3K2vQzPG3VZG9uHAQPzQ+DfT/3U32funzdESkoFnKO3NGfnBSb9JtbRvOK7f6WDwD+1FHKtOiKaagquzZOAFSZC/kDCIc0pkyaPMj32Sk5RcgDhsYKTbnnWdVYWyWWsnnoK+olqIvZduONuAk33bCFUpGlEp+cxNZNnJcevpSDdj7Teyx4kEMwflBHqQ0lLQNCF9yHePCDONIl3cM9h4OCJYlt4madzYqD/BMjrH9R+891byjphliZsVC7xwX7xKj092Hi3KZUI75QtCQV/im3/dloWjbguMhcj27h95Ii6xKf2MnU5ArFNrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZrUieR850jO6Vbu4iueXwgHL7P1/0rQXBV/dc4DN+E=;
 b=wz1CvNpAwbYBzKzoMXMJW6DVoqBIzwLCceehUtP4RD/4TE8tL2TS1JemwVd5xvoZuha/Wrg7BPaapl5xIWhDH3BLmRBg/cAF2xG6iiJJy712H0HM4bq9DDvKIVgCGoUN3TLYYW62vNDKtHxiFxeOi5+VJTax1y2AGNrPGyocY6LR+nvF3OB8A0WEGBnWRxEKh+D60FOcAtm8KZaXAU+JZuZn0UdQeVMx6AQdYSYE21Rk8lLOGIjiPEs2mSoFqLAOErJEEGwkvAF46s/H7ER5A3Pz4iOlr7UlcVDluHDYRszGX9EULsqvNQ43LoRaJGhiUcMgr07sc2VBg00Or9ehXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZrUieR850jO6Vbu4iueXwgHL7P1/0rQXBV/dc4DN+E=;
 b=qCI+gO7s+nqN2ozQPlyI61Br39GoL9101Wwe0vGwKIoPUytyojbyptInv8md0bxh20qtvz4BUag5iEOjJ4PoOYOf2K9QbiGo8Oohws72lCl0KgzZAvMbvIaVDfGi58lCnozlebvj04PXNHQuqOs8F80zFHAf6W+zAgDGkRKmOPMyhn5m1Q+N9PSFYcNlcqD8hba24MhwrZAGDqOIa5N5gnCgJrIO8hASfy77DnxwJ9BTtl3bDUF0t9Y26VDrmzC0HRHSsKzzCmT88LqoJ84y5s42Odcp9mkXJmHJUwPtG0UEu/ZA8se4C7Ekwc/ZZmbyUIfEpllbPmLQLDfXC5Jc+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 19:35:42 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 19:35:42 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 1/7] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Date: Tue, 12 May 2026 12:35:14 -0700
Message-ID: <20260512193520.3109172-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512193520.3109172-1-nathanc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3809c1-87df-45e3-0746-08deb05da77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ggZmtRU7c1bmOpEmvizqt89/e/QtjvLuYKjoU6qYU/8/atrpm3PKIAtp8cIQbYBsyWG8Z9C4inrR2sIOsd8aMeT6H/ig9HoWtvBL2dUOer5EhGj6RqGea8PspujAd0PFhEx+UNcFwdfY+DjJOaF953wQtrDUB0+g73qgq4RBWoLhvmv4MefWSawaefq4yDAT39TBGMn8MQ6iuXNbRxj7d84jxaScYwQgJUl5M6Jmrqw3Zg5Mq62xrxtGg2slmmSzcSQMgLBg/kJZ/Xn6HdSC1qFfyiui16NS/z1dWYoYAERN+zsN3/tyr3M2NcCBaCFzRWRh19TeS3CmTkgfPyk55zBIyLkUuGnGllG/CgYt33qVWZZxw99VO2OrYz/ukjZ5ur7P6TUDpM8yNaIy29SI/qbQvBx2yUsOjaiLqAi+GHlQEwcloqKiV5QOnLBD287xu2Xm37hZXk4tFmDLrcE3Owsp4qcSE7kWfOeakIVC7UUQi9pXk7c+HYdALhf5R9OM1LpU0AzcBrHzpBuTkyoQf23Q3med2bnakG6pB4yoNStLy3C+KH29BB84/Nybu5tnlEeP+is5RikVKm4jN/dCGidNLz4Gag5MmPjrLVFloHd5G5L2OfqeetWTYbIY9P/fPv61wr9Om5mOYR8BIQlqDdkM/MeefmPjZsRdJI8OwLjPOAwjthu4wHeV5VhZNdMk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oFWCv/AUPYPFjy+Ru2S/mEyHQuccCPzibp97D8u0Vx0X5DayifLRwblLScJ6?=
 =?us-ascii?Q?eb1wDmNsVXNMc9WZ48hboV1OXut5eOgeDCyX/PN+txfeLUI/ZNPqEzfzQhr6?=
 =?us-ascii?Q?19mZkp/INtFZbfwIKkYPbc8FE5GlcANl72C+RymKABnxiv6Ebv4MbmkHhFg1?=
 =?us-ascii?Q?xoqvpbbjtesrVmk72XseRwS1WCQH6hxmWMw2pY4W5WSfDT1oyq0uYOq/cH1O?=
 =?us-ascii?Q?AXaWazfDIo+JBFDi45+YyVt9Q9dDT+9lcubRaTzlcCdqRYXNcraJyiyeYwF/?=
 =?us-ascii?Q?/7gkYTZon01wsiBgn3ZMwLxsiAl1FWLJKrAUgtHm49zFYFI3RAozBlCp6OQG?=
 =?us-ascii?Q?dlfyAmaefH8T4msFWW5EbL6IL3zAwPGmzAlrqpTBWBH9eU8Q3xJtf14YbRw7?=
 =?us-ascii?Q?88iETG1WnQrxrX82eOD2liCd1ZUKNuIDbrLL6oruQi4AIksNdE/deAXWwhyJ?=
 =?us-ascii?Q?ACSOkTKkTAFpGfA9apqLH8Um5aVwG8F/jMtNnMUpnzJ4UR5IF86OjpBr9kxr?=
 =?us-ascii?Q?tPTeyWgb0pEEv2ihzT+3j+MqoaE4vbCag7ZwZay5J22DPfuu6q4p0VUMvg3Q?=
 =?us-ascii?Q?eugJs8mIQU6u3XFpI+PDoIa8V5I3gqGfhZbPJbhagnHygyJJNXFB2XMAt/Eu?=
 =?us-ascii?Q?uqTWeDqGr39eH3EXGOxae3hLnQiK5jtRK6s/X5i22iDgYDM0tltDZ57DPnc6?=
 =?us-ascii?Q?PgGGCl9FJEGdi6yvcqPJVLc1LX90oy44XTsS6xh3O2xMSo2fkx1y8SUK9sPe?=
 =?us-ascii?Q?vjTjGSbbsYj4U47hFYGuh3QRkuyV7UrUPneYbdy18wLalb4UyyQy0yGQUxWR?=
 =?us-ascii?Q?k9lUleCyTr7kHVzi1cfEJDY57U14nMmHDMeJ5f1Zl24DigI77uD76QsoAAPo?=
 =?us-ascii?Q?M2bnY+gKf2ZE10xUjcnF02CWTZCGBe/4Eh2HzOlzj5mreDaozh+UyNaasGh+?=
 =?us-ascii?Q?ghAUAHOvNOGdkGattmAB5pZ6S/khh9jiGLvj6qukHt/z0Ibg8/H7XA+UVQDl?=
 =?us-ascii?Q?rbmLG5ablYLflQlmExlv6l4t6Bz4LAQ35dljeivdGHIohPn+4NBu/0tVtLcB?=
 =?us-ascii?Q?kxs+IfzLzgmDbRY8Tw45VQ7SdQ6BIV9zJ4HWjTzIiAwinXZtMuOS+MzR2Tdz?=
 =?us-ascii?Q?zkL3V7SJUgvoOLb3re+oihtb4AiAZ8GcL15oFEphNinC2ANh6J385r1Z0rjh?=
 =?us-ascii?Q?hQ3AlgHeXuEGv3lh/RFBGLGpXQffzggNfuoIGDHaN0HUo34KVImMBOgr/xN0?=
 =?us-ascii?Q?/h8h01ZHLFgFxxB4jCHRvVkcRIn6SLn9FeteKfpdkWykmDBSu2tfaEfwvIRT?=
 =?us-ascii?Q?Qx/7zU1dy/B5pH+M14IfqiunO2K7avP4U9ChXVOUunnCQyT+/vD/HGrE69xz?=
 =?us-ascii?Q?Tmd6UnVa/z8hC6Y91kQk0o2SHSAWw65KqmSrEKoY6E4wmk7fJ9wJSYlaNSkc?=
 =?us-ascii?Q?gmwYjnMmssqc9VZdEj2DF9kw021k0jwOCp1gHm0DF3D4kkcKhlRj0vsb9omo?=
 =?us-ascii?Q?y63Tfwl//VHAFMgkuy8L0zJNmN/Dg0/xZAybKBFm7mHERnMHN5QF6SczCHKe?=
 =?us-ascii?Q?7OIAEpO83wF2YhOrjC+USwLb1Q63Z16jyccOgMU4wBLoquzVua7EEz2V8uDm?=
 =?us-ascii?Q?aIZcNIqM0/LCQka7Kk6E8aClE3ZtZ9CjbNgc6CBQV1KSqIEoUdhm4oj3T6Ur?=
 =?us-ascii?Q?ENMR3x0SOhmC4WZSteusSF3y+qjuIc+q8RHZlXfmbWOZfHHtwmA6aDuTkuZr?=
 =?us-ascii?Q?Ss8z0zUXFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3809c1-87df-45e3-0746-08deb05da77f
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:35:42.4214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CQAl3orJZDChuV8TDodUk1PCYtLyighPwc9U5hf7VLRPimKHiaOd3Fk+QvoHYDEVwxQuqiNXl9lV5eeJ2q8UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

The later commits in this series set the auto_mode flag to true when
an accel SMMUv3 property value is explicitly set to 'auto', or if the
property value is not set and defaults to auto mode.

Setting these property values to 'auto' requires at least one
cold-plugged device to retrieve and finalise these properties. If the
auto_mode flag is true, register a machine_init_done notifier to
verify this requirement and fail boot if it is not met.

Hot-plugged devices into an accel SMMUv3-associated bus will re-use
the resolved host values from the initial cold-plug.

Subsequent patches will make use of this helper to resolve 'auto' to
what is reported by host IOMMU capabilities.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 44 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h   |  2 ++
 include/hw/arm/smmuv3.h |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 862be814a0..82c0800f4d 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "system/system.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -35,11 +36,32 @@ static int smmuv3_oas_bits(uint32_t oas)
     return map[oas];
 }
 
+static void smmuv3_accel_auto_finalise(SMMUv3State *s,
+                                       struct iommu_hw_info_arm_smmuv3 *info) {
+    SMMUv3AccelState *accel = s->s_accel;
+
+    /*
+     * Return if 'auto' was not set for any accel SMMUv3 property, or
+     * if property values were already resolved from a previous call
+     * to this function (e.g. if this function was called again after
+     * VM boot during device hot plug). We do not accept new property
+     * values in this case where auto_finalised == true, and we re-use
+     * the values determined from the initial cold plug.
+     */
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
@@ -918,6 +940,22 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
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
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -925,5 +963,11 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     s->s_accel = g_new0(SMMUv3AccelState, 1);
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
+
+    if (s->s_accel->auto_mode) {
+        s->machine_done.notify = smmuv3_machine_done;
+        qemu_add_machine_init_done_notifier(&s->machine_done);
+    }
+
     return true;
 }
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 407940616c..87fecb5c68 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -25,6 +25,8 @@ typedef struct SMMUv3AccelState {
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+    bool auto_mode;
+    bool auto_finalised;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
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


