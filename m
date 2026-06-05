Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96359CD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIG3-0006V5-S4; Thu, 04 Jun 2026 20:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIG1-0006U5-VF; Thu, 04 Jun 2026 20:17:53 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFz-0007yG-Vm; Thu, 04 Jun 2026 20:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PatvaWCKAsYoI7XWWfRzc94DEI75/oyyt4es56vD+WEZpU5c8dAJHvHD39XeRh/sdbFSMnclyfJ/txucY/uL8p6S2S/niyGhnk4dfjsWicwqLJMmn+OV7rGZ1Z7gdQ1nD0r8/dezie8pdSE1xPbmLxiG5RyaICZw5d535DIvJ4mp9ILky3nWj/d3uKP0/RuTmN8VLMmyXgAgeWOuLsQ23mts/RB8jT2wQPVkKXpKieBZXnijJSbRk5oeAdQO7d7o9ftdGc9ABChA7q9UdQQb73QbYmnYZkf5n7S8kGa/6i4AsVIQGgiiHAajPgOt9KLfyBWZejKBu8Wz2MeKushFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyh/2cKSxMMb94/47XsFkpZluZ7BxV2yK8jkhVHZv04=;
 b=BxWK0MDUYv4MrjqjoKVkMsKh4w6/QlEIW2nM9LylCfFmnJA/F2tbJh+DiVx6FcYVsYB/Gl6W8FGkFMlHT2N9gGcKC8HZQ5E5GJVwnzz/XtTwC9LCzH7CJ7gt5RQZQ7yJj2mvkXE5KLKJirmlO71908v6SaK0hXQF6fpfiDorIHgBYZ2RaEsKLgeysAU9sx92PBJvWhQs0D4b7Q+L1hWTDQH0gkOku1Uuh3wNhNwy+4xHLwvzSfpg4FZFg80ZHgvLNkcM0YHDSRWOVasKQOY/o2/1xqF5UCMSzxV39lAEFJfg/2Uq2+SPNYt+ClLMeGxVbi9uT36gf0Po/U4drhx+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyh/2cKSxMMb94/47XsFkpZluZ7BxV2yK8jkhVHZv04=;
 b=JmiaJlAKprn0bqbOUInEvk38bfp2+Gq9ZmJ6S921jsJEe7m57XrdgN1XPtGEfgwfe/JfRCNnJRTQOA2DoMtzvLwi8+cMsx4vqhQDgiK1jJRzKwmr9KWkK6mdMQYdMV4YLYIQf9zV57BaMELB535VkY5aAE2XetyeAM/plXDGOsSlpPdt1CF2ZD45weBFwRRkNbCPDaYjRJdQSfsiCHAe7t8/SqmEuT2e2q3l9GtdFoGS6Pc3bczk8Kfmn8TyHHpofMEE0656o47VkDu0Hlv9uDD+fIQqhog9/p5q7B79+htjOAR83dYoJzovVaUogDvb9doQgBIyxpd0+M1G2XUMlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 00:17:31 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 00:17:31 +0000
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
Subject: [PATCH v5 8/9] hw/arm/smmuv3: Set default ats, ril, ssidsize,
 oas to auto
Date: Thu,  4 Jun 2026 17:17:11 -0700
Message-ID: <20260605001712.1823737-9-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605001712.1823737-1-nathanc@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0190.namprd05.prod.outlook.com
 (2603:10b6:a03:330::15) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fad9c4-bc19-4afc-a082-08dec297d5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: d7pvwkyv2AaO6K69HycUlKR6b00fBjbj1XhLJLlc+iGQRz9OZrue9xIkVDM/YG65qB3PX7i8yAFql+3lh2wcFwbTd3A+vj3Wm4GwhBEy9XT3LEVjHpCtsypw6S4T2X+eSDNrJoS82ucy7LZ+OGM77/kZim/ejhd4VnZ4b6Ln/Td5wIYfi/ICf6M0Z77YMSMpkDl6jiNOOQdW8pKWAN4YqZ45SiMT+q8l3DHfEFdnOk4MEYAPBvH2IdAeKIYC5KwKpWwrKPKISsAOAH4PreHhei69CLGA5Ae1uwD8oYpSWLnzlS3aBWbkkh8JUCQTDtFCC18MOKvjaotpMKWwn5QiEQokvt90RiUeS0D0cpBiri3N3edFZA2jGOuLTFcHI5nqxSK9dw5fiyNsr5H4TsUk8C3pyLC4pG87oTJdQbAK3yka2Xb3wwOqr+h4IgJuUAXSm+LFB8yTwdoLizIYStfFBwgAcFvGX8xd0WZQOWgAZQZYVKJeS9drf6sCaUa6mnxumVm9sxSGBInv2zrMg4ksY0MKOWbck4hydGpSm4WObpJb2YQUEIN/jDddmq2Oyji7JiAPxhbCaPDhlHBbeB+xHSVwaASJh2y2g0prBydqHu5EtXUXoGukNAJ6/HUlStoJdizRdcdyIL1uPjsJqrrADeutShyNLeo71gxoJOWp9XjGcmSKYT2vdc3oL34NPr4I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zLHJmFrTAclVH/qTDHsrhoovtRqqd2IoBvcj2QtnhoRq1uuAwjnpuhCLDBqM?=
 =?us-ascii?Q?6wbxM/1vohByq0VQtmYejRbNqK/JQ0KsanWpqNfTVXf2n91i77rcrT9BTKwf?=
 =?us-ascii?Q?FCligllMWQ/PBy4mGVhHSo6s74xuFtXtpzcililcJd+jp9vcWE6EhKM72CNM?=
 =?us-ascii?Q?l35JJXsoJ+LTlJfuWhMWPMxl2Fo3nm5tmMCMuxvL9IOcbAYy6g27RPF54tBB?=
 =?us-ascii?Q?oXt/Kds0mDkCUcbfTyPbVPgqRdRo3lj1hXfWy/Hc5hqSVUWqAYe6RGpn7TBd?=
 =?us-ascii?Q?WRa6pccww6oHbf9iBYLRkQaPO8h2hoDGVAyO+YkxgZjmwWkfUQBd/GS8evLu?=
 =?us-ascii?Q?FLGEUAFm4hTHDOLRy+utPvRiny7PCz1l8ga/5TqicTvgjNU2OooS2//3k4vu?=
 =?us-ascii?Q?q/fd4TiEBnwCuxm5wsZzB5E4kSbf0AkgI7K8t5QJ/b9adu6f8wtxT3TVJYeX?=
 =?us-ascii?Q?AXXWTL/t58Kg5e3X7L7/0iUL25dCq58s0vqVg+OE+B+PSAI3XEKuFDi/yPfe?=
 =?us-ascii?Q?W2tlluPpUEBOQfBzENwykTpNRJp1AZ8uyEUsGrleIMHEyibGiXSJFZEADgET?=
 =?us-ascii?Q?/Q0mECimCG0bFtNcW0eZjeRofUS/yV2wpToB1zpgmfi3lHnpuPLIFz48iO6X?=
 =?us-ascii?Q?FSzPDSRufvXMHBcOazQKcomjqn4nvt61ennuh+/JBAbz9vHGpO+CIzoGznmP?=
 =?us-ascii?Q?h9Aop/UH05IEassxFsxWLxFzQ4Tp/MMCEBqSs1Az3SlXYLwJIc9LddnZ9/um?=
 =?us-ascii?Q?FmySlT8rRjh2bmTPd64e4PE5+YQQLvsLCrfEPQmalXUhYkfG595vo8ylRFm/?=
 =?us-ascii?Q?/ojv2JnyQcYskN/rZy0DQVOjzr7T7vK5szrGhmiXE6YZbmVaasowqB8Q9/z4?=
 =?us-ascii?Q?D0wsF68VarUysMFQvDcVd24o6txLPZfSnhVn8Csq450QxYwJUbhx8ramEkPZ?=
 =?us-ascii?Q?YbVa49nhqcPh/BXvbQ6ov/UJjQmzEGH4WHl3AuuymVmn92GB2GGPjVm3Zntv?=
 =?us-ascii?Q?Bs95Jvv+giG8wjYuzdxUG4EfQ8zAuxQfms4XG57LRhzsxY7FAy5c+BktIo6D?=
 =?us-ascii?Q?B55Na+P1svEq63aT3V8aX4inmy+nUJtgVQW5HusYrRZcu3mkVnMaLfzL39Km?=
 =?us-ascii?Q?FqC89Kou+YQ7PSYCi1mshONrcV3s3LdKEKhvvLZDU/WHvLKihL3BbsalzKI/?=
 =?us-ascii?Q?yMrAuc6bVkzCRcMngbqNTxdW3h5XQn19V9AhnpdZ2WQmT5o5zABwHsOr4GJF?=
 =?us-ascii?Q?C4RdcNw/bIaGRuv1i6o5x+Sx+4FxktUilPqyhRbF2phidI1Khvfa0V6sZJNf?=
 =?us-ascii?Q?cR6tSGdinzTAnMEMw1MzBzSX6+rLjORdbBiMgFyu6wxPz65LuJyNU5mhRGF8?=
 =?us-ascii?Q?+iA50QYruLh9rTPgifsAnNX+AKzHB3hudl/oLlCwQWykjwj+a7bzSmiDcnXP?=
 =?us-ascii?Q?Et85rxf6HHDI92ygdXWAO9Aah5ZIUbVRTbK+bj4LM4+9ODhj/CKoYuELJuWT?=
 =?us-ascii?Q?HFgC8hblrNeTmFF5BufUb7+3l45/KbUVtAcmII7eInxip6Zs7czLUadb/mGV?=
 =?us-ascii?Q?BrOl8fqStsHIj7jGcwmtvQfTdzDRBn0vZTm3ReGnffwWi3X7pTSGRT95Kg2z?=
 =?us-ascii?Q?BsSYKeAHVH0ybOOPiDIvmvHTzJWqMMVgoeQgZ4FTJLIQav3Y4owtu3C3CjCB?=
 =?us-ascii?Q?RwJNLxPu5x7VIbSYkzKbwbgHYF9809Pnn2Nu9hClB2d48sNUu2mRomhKGSf5?=
 =?us-ascii?Q?/NLp9n9lbg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fad9c4-bc19-4afc-a082-08dec297d5db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:17:31.7941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJHi7ACuz37xtUL1gpG0LlO9DoJbUCuDthUL4jeHauV923c8g3kH142xYzYHEPQSIruUl1TvYAqSDTzEPL///A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999159
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nathanc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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
index 63baff859f..3339da99ee 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,9 +38,14 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
+#include "hw/arm/smmuv3.h"
 
 GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
+    { TYPE_ARM_SMMUV3, "ats", "off" },
+    { TYPE_ARM_SMMUV3, "ril", "on" },
+    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
+    { TYPE_ARM_SMMUV3, "oas", "44" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
-- 
2.43.0


