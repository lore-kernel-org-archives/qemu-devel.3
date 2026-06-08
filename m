Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC37CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe6e-0006jY-Kr; Mon, 08 Jun 2026 13:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6d-0006ij-4b; Mon, 08 Jun 2026 13:49:47 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6b-0007Bn-IH; Mon, 08 Jun 2026 13:49:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpE5IuR0/d//8d9IV6jlGQv7mhUMk1NZ7V6h31lnyevOPRWvmsAujzxpEHBwayWqm2B4HonBWuQSbYcfClJ5LLjvhg7wqEPxjtk2xmWR60jtYnAVhP8WrjMFAzvdMbRwIT4Kq+Hn72xrzsEL96LAxKdCYUcMMLfkU7VPhjsbaqhgQbwoz8+KMtnGimKO01pfQV+0Upyn9L2vPyWZQAeBz0R7Id04ZRi9yk1ano7pkA58vpuaQzUZACYLIknQXU4TexSdMRD2KpwBWj+7bHzur7/1KEh2g084zOPF01RMdZqBN5uP2wsWMHlfj6Ds7C0S0PV8ZHHsp1H7FEZpYqcNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry3V54RhWKt0Wa3EK/qh04WkzWkR6WM7Y1n/g1oCK7U=;
 b=HO4ciSG9wl6HZAs4Yk6psjBopOaNRnWRGwcx/FwLJKX0IBUsjOqRdNXcLsT0SGukHRM5Ns55glaMTwcFKDBRWEggK05Iu9nroUq3JiC3UXpjjkIi14x4AejOXfSK+QyHtMc0dkVcbr7PRsQuz8t4upLVsOLNacQTlAlPXPtKnajOzB5jAwQOvvE1630RtBBmP+oMFZtK7o335GF6qPSG/NDHYWEU9c3DIUQd6yiPGMIY9jC9FmBEM3PFphs2x2iYVKfpdlqlgAxP0bUVzUghZt/EV9ILW+5tToMj2ulxRx3YelSNQkrNHXbg+vpMcJcurJ5KHZI172OujmZFCJUOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry3V54RhWKt0Wa3EK/qh04WkzWkR6WM7Y1n/g1oCK7U=;
 b=oxM1YR+zA/3v047Z57KODJ0PArj3rmn1zYFZJptLGr0MMvhQdvc2HO5XIRRyzE5eSPmXT+TmIywZQqh3KGDsU7XfIN8HLYkeQ7YNUVxDiOEAa023+5vA6wFnsEMx4auouyRZt6lqB29RuBhOseCfIASiDUGkaRLAlAhTwi3bOxOzBVcAwwj661KGlTPt8CSJ75+lNaJH8w12F0A/TcOjDJBLD7yyBr05Abv7ReAd4Fq8hAsrZmlTYoixRBJXT9OvyK70DydoFi4e+qfeWKYN5ghG0VRhFMYCOFhPmR8GYjTTGhFfptjeRLN+pc1euLIxUz+CsoX2HsfYR+fR63wC8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 17:49:30 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:49:30 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v6 8/9] hw/arm/smmuv3: Set default ats, ril, ssidsize,
 oas to auto
Date: Mon,  8 Jun 2026 10:48:59 -0700
Message-ID: <20260608174900.2227340-9-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608174900.2227340-1-nathanc@nvidia.com>
References: <20260608174900.2227340-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee05fdd-123e-45b0-50f5-08dec5864ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: P3Wp4lwbkoVm20BCNshpQhijNLNHZfNBiwndmmIyoCQGmVy5r5dOkKwaYAAZcQaYwwzL+KDlE1v4xZKXUakIx5Q0D4h9XdttIFT0/R4oKC1FAggyhkzWg+oAnyE0aL6N8knNHHefk4oW7H+JbKLwnWLEVY56gHgqxruTQ9xGZZZcSDMuQf9BsSowZzb4jA3SzdWWU+aXbR6CkipLpq1lIbn0V1b0xB9MemuUP4U+YFInzGVbMai2a8KULX1CzRq/LtVqW/lOiPhTXTISYHldNn93oK0KN/T28lsV96qPIIF1K5T706o3H2te55BMEUS14Z+UQDLf82BhU49tvaoUA9hlTQfQsxALruEq/M/WyiTgxsnU39Xc5TUTYcOc9QzYoeGRez/EOOuSu6Vl2PUUtMKop1tDPkDldYf22ZqmZwrNdJr7CIoCI3yOk3vl0JaNKm3UwSLopQZQtdYvfszqaH9QfOviSCQiw1C35w5BOC62tynjz0QNBUJ+/R6+HL4wJ1xm0W8hnG5tJ71gHdUWwOPNxqm/VywvZESL3Wf1dskvfIKPeMBa0uc+CVa1b0d3O5IarxtVQHaGL3NJF1Qesn/zRlg4zdAxwLW20NbrU7I1HNNbB0G31PLYN48i56fc9pYTZNDZvNdwnTDuY8MHK9Dx6tqDh/MhsVFwqbZkX5oPwaYW+P4ksacC1qKMCoOm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S6DCxRbR10COR7lcbS9ODRZ2mJEi+I6/XZkwRlVIW0/qXQCDZQvrPofEXKRM?=
 =?us-ascii?Q?hl9R0t0B1cNYAaXwd7cVdOhmhcPKoN0k0NkDHWpT3GbuEu5I2vWfMmgxtl0H?=
 =?us-ascii?Q?UZqgORZB5XEd2Z88MBsgs1ivQd90dzcmcCWGX6VNZDOwi3TtYzPIjUCsVdi7?=
 =?us-ascii?Q?WWZ55F0pstjSiXL5AtEf1fofTV267ZkZaqKDXrrPy5sfev2h6/Qv3M1byiL5?=
 =?us-ascii?Q?BtAN53ugDBpr/YinHehRABxEFZPB5FuTgGFiSUYn4Zxy+hX1oKNBGeBq8mpI?=
 =?us-ascii?Q?4dKiNhY0ksLUc37jYewfzLlGB/yhrLS/tUFnq7Ote/xf+061g9PJcDVi3kJu?=
 =?us-ascii?Q?3IRXf+wrvXzTnkb2pe31fxGacZ32v87P3wq7Ai3nYvUeZh9m8vPbslHcHTKc?=
 =?us-ascii?Q?TysqTstsHk1gR4neCIAQWLEG6Zpx89KTfB5X36XdBq5clMWmuW0mQAqTNEbW?=
 =?us-ascii?Q?BpAbY6/lnUc2dclEvJu+dTK8apbRqnguORK3nq/Rk47UghT437lPDvugyxUG?=
 =?us-ascii?Q?Ch303r5NSEMSp4e9wdbiXzvnsUi/RQiw94FtVTw2SDVeSbNDLiEuSJYAePpI?=
 =?us-ascii?Q?PtDD2cm8QVs+hmxnK2AsFGgr7/zQcLTac6KwgHzz96NxsRmciJlvR+1sk858?=
 =?us-ascii?Q?/yFV0ZT0Qspz6W5Ek0OSbRANajPKwJCPcqNOE2jO09BcmZf2mCh9vEd9TY+r?=
 =?us-ascii?Q?WfTrd7UgQqhaO9tDTCd2Y44oapab1wY4gC23HW6ReU4jjs/B2rbhG82c1Mh4?=
 =?us-ascii?Q?8HZg+N7x1K9YllruJbujSjZcfDCKh+0S+TcQeujM3J9CgqsF/PdzMp8ngagK?=
 =?us-ascii?Q?DdzBzBtDh7eauLIzvEZbNnmI0LpxzYntYzRzJbeLR41uKOzZPLTjFAPwCnST?=
 =?us-ascii?Q?fJtALJgW5/3odWo+BBv3i+qJMdp9snw/eQ5AqVj/bW6IdY79WpmilkOaxjIZ?=
 =?us-ascii?Q?haupAglcIPBZhHjdnoxvVjYe9yr35FKnoxtYdK6vWrQX3Ue+1CHSposL3KG0?=
 =?us-ascii?Q?1+HDQ3ud+lzKQe8EfgghKikDt++/ZtUn3FuFuYaZExURsCFa3lLLIZ1HJDP9?=
 =?us-ascii?Q?1yAsqBg6HIoP/FNDercgJoe7fI8Ctv4UBb6Dr9IuzA2YJ1CWqXJ+mbPnQyBl?=
 =?us-ascii?Q?QsVXQEIIpPLIlAFwMUuolU3zueVP8SRGhuFTKHlzlsw0VJWh7O9RJ5aTNso+?=
 =?us-ascii?Q?j0rI9mm0MklhTk3vF+4DAFGUmnEAzneFDmUvRVEgena/44itG8JPDN0/Ymq3?=
 =?us-ascii?Q?BoNn/RTVjIv6eHl+mfDH0CiSWivsfpm+VcB2CVQvKEMWo/KJV5WSGq15xZP5?=
 =?us-ascii?Q?xItt7qz/lpLAg59wUGIkJSRWU4ays2o50Mvz/bzhmwDQspnhu91YxgmPiFTU?=
 =?us-ascii?Q?udgQFi/tgKcB002lXdxSNwu4v3E6gxIMKY9Dvm0B+XXx3pta4xVj9GzbW3bN?=
 =?us-ascii?Q?oanFKQVCIHm8DrQwFbEftaNMs+QOfJEZrzwHKerAJZCgJGrUJpEquVVm4RRg?=
 =?us-ascii?Q?ZhKRGzSjIUCyGFMTun0+pbae7c4ckrFt2dGMXR+ebiHMCMjhpEYoIZ1x4krN?=
 =?us-ascii?Q?rkxCQw2dDx2iBQ12ocW1WGEHLv7GOzAoP0L6gC+qPqaaqOphCbuT/wPAO++o?=
 =?us-ascii?Q?Wke3fEx3KMGJ3gnTuphq0ow1FcTDbJa1Hdba96A6yMJ9M4FoirdvVrqN2zTN?=
 =?us-ascii?Q?FfgS4G24lVt6XTgkMnUaoS6xLSvBkGR/6OA7WLnLhmjIoJMeNG3DgIlADQsV?=
 =?us-ascii?Q?YkUs3LEquw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee05fdd-123e-45b0-50f5-08dec5864ade
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:49:30.6483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lim8EQ2bdTV96r2YbUacNqVf325uhnsKs6bilftESTloNSuI5SeckQnbGQeRpUHLYBBz9hMiNqwuHpZJENQZ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
to match the host IOMMU properties when accel=on.

If accel=off and these property values are set to auto, the default
property values defined in smmuv3_init_id_regs() for OAS and RIL will
remain unchanged, while SSIDSIZE and ATS values will remain initialized
at 0.

Introduce a new compat for the changed defaults.

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c   | 23 +++++++++++++++--------
 hw/core/machine.c |  5 +++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 89289ab6d2..83fa6468fd 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2129,12 +2129,19 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
+    /*
+     * AUTO values for accel=off will resolve to:
+     * ril: on
+     * ats: off
+     * oas: 44
+     * ssidsize: 0
+     */
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
@@ -2164,22 +2171,22 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "enabling.");
     object_class_property_set_description(klass, "ril",
         "Enable/disable range invalidation support (for accel=on). "
-        "Valid values are on, off, and auto. Defaults to on. "
+        "Valid values are on, off, and auto. Defaults to auto. "
         "Any attempt to turn it 'on' while the host does not support "
         "it would fail.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). "
-        "Valid values are on, off, and auto. Defaults to off. "
+        "Valid values are on, off, and auto. Defaults to auto. "
         "Please ensure host platform supports ATS before setting it "
         "to on.");
     object_class_property_set_description(klass, "oas",
         "Set Output Address Size in bits (for accel=on). "
-        "Valid values are 44, 48, and auto. Defaults to 44 bits."
+        "Valid values are 44, 48, and auto. Defaults to auto."
         "Please ensure the value does not exceed the maximum "
         "Output Address Size supported by the host platform.");
     object_class_property_set_description(klass, "ssidsize",
         "Set number of bits used to represent SubstreamIDs (SSIDs). "
-        "Valid values are 0-20 and auto. Defaults to 0. "
+        "Valid values are 0-20 and auto. Defaults to auto. "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "A value of 0 disables SubstreamID support. A value greater "
         "than 0 is required to enable PASID support."
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4d8b15d99e..9a10e45aab 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,11 +38,16 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
+#include "hw/arm/smmuv3.h"
 
 GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
+    { TYPE_ARM_SMMUV3, "ats", "off" },
+    { TYPE_ARM_SMMUV3, "ril", "on" },
+    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
+    { TYPE_ARM_SMMUV3, "oas", "44" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
-- 
2.43.0


