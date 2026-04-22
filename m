Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB29FA1FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFeR4-0000Zi-Fg; Wed, 22 Apr 2026 16:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQn-0000Ty-H4; Wed, 22 Apr 2026 16:44:21 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQl-0006xi-Us; Wed, 22 Apr 2026 16:44:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkjG3uiq6Qlgv3gUAFRFh+NQ1cO3or52bLjCYOfIcGyjFZmAa+SvTGXB4Ec0fjiyJMjdyVMWwyJDnJmBosAA13+s8Z7BiCdvYa6lfyiGBNdLrAZAMXWFWUjmlgzsgG4+uAHy1Yb4bbmOIhtfO2BHQ/5hvsSScau1wxNjSNkkIqAQPsbZX773Jr31h9nCrIXLugpQ8/PZMunu51uSLbFaoMWfDX2GbZzduA27kQNaHoS68sHzAPTcZ9Pg1nl+eXD6zKfT12PNmPfxUvkifzbx6RFCz76ErmALbi3Vq+zS4Rt1AhQxjTL1M/6KGLJvMNTNnOMlSpttGEMupOqm7RecUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PgZDhLNAJ1sqFiaj4DAHfpXU8tlTv755bTEwWXqX6E=;
 b=FkQ++77DIf4eiHucpnDAXC2VaV3MZyf/5z8d8rxqGQ2HOZnJaX4CA/8n0iC1z+I37ToMLNVIox/9st8+Kf2DGlsYrtWwu/qhrd3h7XdC9dtnog6j6KvRUbpmgjli1ivtMYwoTc3clwdQuePcYrfOW37F/+v/t2OH9FpWpBpbVP3wrR7C8pOONA3nB9kt13MXz3wAHJJT4S6J5jqCx6eedRCIzy6kgcobfT8MncH8cFjpMh5m3bfUaKsyVvSr1DxDOFS49hBP7vJCVwvD5xINdoP9mcpskOT3I/tC4YSInMXGHtuQIeqxyQerpxLZp+bzxB6fjhvBPzL62dswIsSwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PgZDhLNAJ1sqFiaj4DAHfpXU8tlTv755bTEwWXqX6E=;
 b=hF/MIBlCFXqRhZDkNKCngzj4h8itOnj33gkMLekpd4v2YBfNLwMFcy3z7fYozgPUGBP3EpWfXASaveHD9o2pRCcASIrTmaFKt+RiM+teh4yn2nlUy3O+2gm/Csu4MlzFbZxzEPFvh4DQEm/JcluT/Q0VH024D376wrrR7k+ILeV3FWA9FOoNbu0gGFZIiMckPcM7tgT7zZpBIo7+5Aovs/4ZEVyVvWZENkwPJp9Zy3TfJz35aSnTus5mJIbKjkYFhWtm52NDAOPzSomWBMj5I1DtvrFWf6Pi2g5l4mSebP+uoPp4SFOeY5vG55inlmoej6GvnUCmGDuvpigGpV1WbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Wed, 22 Apr
 2026 20:44:00 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 20:44:00 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 6/7] hw/arm/smmuv3: Set default ats, ril, ssidsize,
 oas to auto
Date: Wed, 22 Apr 2026 13:43:34 -0700
Message-ID: <20260422204335.23116-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422204335.23116-1-nathanc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b29f64b-dd7a-4bdf-b0eb-08dea0afe198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Lh8cq8neAGXahBdjOQGioEeWtATJszLEopztswxdx5ElxgV1XEsMvfMdV3DvC6AJV5nTom9fiRP+DSxfSglO6usVDAtHg+lRQ6q4lJ0cF9jKv9qK4WEX2tWURqcP3Nv41K9fmCxXlw8rregRW8N1GF10poZpYTrMhJjhzSrGWiSRYx2j09lLCmobWduzxF1urJdUWPADwhh40dePVQ6AD4/qBxbXIV+H9JoCWu9HhcKq44+Lo+QHitv/4UWrMckpKCLXMgm9mZz6liz/jtQhiadkvn2d+ZXA8FcZPGgJEsOSDHyYPIKLgWBJj715u0rEgqNbRSt85eTAAA/fVTR/qvbvM0c2IO+7onMc7YDuQQACuAexpUcadfAS3DHQc0k3XG4soJYQXab6exaCdLSTNzrUxrHst/zQwhfMjUg/mPMBfAAG2JNOq4GZvAKhvJd2pgS5/TdJzGkVAiMgxilaBlr7pfJ8X6qw9+O3u/2R2LmdUer+ZkwUkNKc6BBeiZnfn1F3kiN+25Sn2jLjoz7juXcUNVi3qtkOQ4Jm7XsfuL7wkwh4U+82w0aqScE3P+nariokV4GFkSCc+ebBarQ8XI5Es81BZpMPeHQWQS7qz3+QCdWj3e1iNqMqSywXyJ+MHjyrOqbxzloCNuQzqRIkeIpzCzTxgY411Ssuv+MPR1fA9auZV0DbWFPoxY1YdQK5FaXs07WmFAcXfGLUa9zEFGsZA6Q/GtMgE1vxmFsnFkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+u+mez+u4aw55aDbYzhfX0NsXEXF/A07I0YFZvDJ2+078r35pM7vkXktzow?=
 =?us-ascii?Q?UAxNAO9/YQuSPi/0Ws9nua+h9ODLK8NSKkNix8pCIfQs3JqdSKr0N9XySuXt?=
 =?us-ascii?Q?GDZyw4s425amVVwNyoKW+JmMvQP0yQagKu9gt0H89S6JyACVmOUruAQGlx6U?=
 =?us-ascii?Q?7NRmGApOM/tD4+WmCi569+ujBEYuqsMtbO+b2jFmuFaRzofkthQLAv0ZILaX?=
 =?us-ascii?Q?2fru+Ozg1YDEkueqemzDo4l8iGUYeLD9D2520tWW+cn90KNrPFcwmTiSYEwp?=
 =?us-ascii?Q?IHyQ2VyTCZPq/BZyq4gOpZ6zwh2MfDbIAZHoEPX8IM7EocTzkOawVmbJN9wB?=
 =?us-ascii?Q?J+ee+RBORc0PAiKjNkkMHI5cZXxfJcN8QBlYKuJ0FwI2VcbjFXTdr5/51RMQ?=
 =?us-ascii?Q?ych4xAovS1/u+m5gyKhvnavrxdnoCedJNy3WR+WBz45dJC1ID6BsJo3hv2N2?=
 =?us-ascii?Q?+j18MhHNx9U5o2V78ztc6KcXeADalm4Q5yFt5RIli9PqzZzbirgjgn4ubhRW?=
 =?us-ascii?Q?SU9H/hTA+2ng2oac4a81PXFCvfTd08c5Jdz+WVnCV74U439COnVF+tzhMWf9?=
 =?us-ascii?Q?2YtIOdZjP/gQt6y+5KEvdSPD7nTcJ8MI5EK+dA7EiGwrCdypkeUjLaY3a9ip?=
 =?us-ascii?Q?I+bVw97GS4jU0nu/3224AAIQ0ryycHJurLoxHxyYFuq7H4t9hH90zgKiffxZ?=
 =?us-ascii?Q?qA4uK3mivaaV1wvFtfUmj4CfmhKFdrhce1sInI6Rsq4xL60VcVIQTU+bMgk6?=
 =?us-ascii?Q?AcyulFqoeqXZfwaLHGRAIgX0UwUeS2M8DtL8FV5M2YnY5YoofXDMemm8x3iW?=
 =?us-ascii?Q?SDAJGoamNSp1t8TxhfkgZgJDjnmrSEPX18I67M9di3rlknRfFiNByNlgvloV?=
 =?us-ascii?Q?b1AVitQ2OG1pBozc37sBsQXZo7nhzMO3twnkIR/imlON8p7cbDcttpWwVOgW?=
 =?us-ascii?Q?BkhgjXCDJWvvzRzrURX1BQoR2GotqgNG0G+g79vGDZE7FFJF1tBdWwoPvGbk?=
 =?us-ascii?Q?KdO1QHVdE7N2BUp5vyCxlkgqsCqeCwGqYlpU0K9PLz5cu/yDEIvudhoYBDNQ?=
 =?us-ascii?Q?uIUGipbLIo93f+XwYVmvxxDx/zhff0lJ8eXWj1L+ubNTLR82SJ/XoO2APVfp?=
 =?us-ascii?Q?V2vS7nRDZG9hLNY9S+GOFpyL4lFzDgFt1e2TzeogKdyY989cWVY2ZE03tprk?=
 =?us-ascii?Q?kWdgoTZzN4kOd8b1vISoLdauSvA1cE3T2/nYETNmlVBNWxuL0/CoYJox5b3z?=
 =?us-ascii?Q?sPFCqvalX/prR9KmlNaR8Rq1/ulVDZjp7VE5qhe1jKUnkp4Dml73Lr8eMuG8?=
 =?us-ascii?Q?NCTAkH4LguePP23+eF+kzOkv6kznMP11Qf+hFU0EDqPVnBfSqh/dGr9e4eQl?=
 =?us-ascii?Q?fMczva2x3NXUBUXRQqeIDcKUud8dYLEtkNP3vOkrSDoyHLH2msw6NudRDGIr?=
 =?us-ascii?Q?9saRl2pe9rO2Q+6AZ1IvXOmwVnvrFlOm5XNThTJatbPUw105hiO5/nyY1iry?=
 =?us-ascii?Q?zOQZ3NVqTuc1ZzYg52rp3On+T45UEICI6ZXaQbd/ClKirYDRiMXV3k8YQ66e?=
 =?us-ascii?Q?+6PMxULk3rGsd/lpZvKGJvj+q3mQHDKKBQzmu2Euo5WAj80y3O9lE8otWawG?=
 =?us-ascii?Q?KPNs9xSR+k1KzLNlDDsUnn5bap1fm6xKUF6XJjwEu8ibYahPECwMg0qu2WH7?=
 =?us-ascii?Q?fOriV96Pi+6A61qYsiU4CjypDp842an20zYjZKdziiV/Ttz+yRBZL5hpTsdy?=
 =?us-ascii?Q?4MSaSwSZGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b29f64b-dd7a-4bdf-b0eb-08dea0afe198
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 20:43:59.8887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GswAjToIZwfLqUz+PoqdgYnDDcV2+8s3Jhgcdveyf+hi81rI1Jv4QcGxzJTwpqfayPEo03zIv51qVtijoHZEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nathanc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
to match the host IOMMU properties when accel=on.

If accel=off and these property values are set to auto, the default
property values defined in smmuv3_init_id_regs() for OAS and RIL will
remain unchanged, while SSIDSIZE and ATS values will remain initialized
at 0.

Introduce a new compat for the changed defaults.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c   | 14 +++++++-------
 hw/core/machine.c |  8 ++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 39a6f72938..e8ca6be34a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2135,11 +2135,11 @@ static const Property smmuv3_properties[] = {
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
-    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
-    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
+    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
-                              SSID_SIZE_MODE_0),
+                              SSID_SIZE_MODE_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2167,7 +2167,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "configured in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
         "Enable/disable range invalidation support (for accel=on). "
-        "Valid values are on, off, and auto. Defaults to on. "
+        "Valid values are on, off, and auto. Defaults to auto. "
         "Please enable if host platform supports RIL, and disable if "
         "host platform does not support RIL.");
     object_class_property_set_description(klass, "ats",
@@ -2176,10 +2176,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Please ensure host platform supports ATS before enabling.");
     object_class_property_set_description(klass, "oas",
         "Set Output Address Size in bits (for accel=on). "
-        "Valid values are 44, 48, and auto. Defaults to 44 bits.");
+        "Valid values are 44, 48, and auto. Defaults to auto.");
     object_class_property_set_description(klass, "ssidsize",
         "Set number of bits used to represent SubstreamIDs (SSIDs). "
-        "Valid values are 0-20 and auto. Defaults to 0. "
+        "Valid values are 0-20 and auto. Defaults to auto. "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "A value of 0 disables SubstreamID support. A value greater "
         "than 0 is required to enable PASID support.");
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e9..a668bb2ec3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,6 +37,14 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
+#include "hw/arm/smmuv3.h"
+
+GlobalProperty hw_compat_11_0[] = {
+    { TYPE_ARM_SMMUV3, "ats", "off" },
+    { TYPE_ARM_SMMUV3, "ril", "on" },
+    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
+    { TYPE_ARM_SMMUV3, "oas", "44" },
+};
 
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
-- 
2.43.0


