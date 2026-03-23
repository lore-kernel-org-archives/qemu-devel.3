Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694C2F483E1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jyL-000275-B7; Mon, 23 Mar 2026 14:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxr-0001r1-Cg; Mon, 23 Mar 2026 14:25:23 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxn-00043g-IU; Mon, 23 Mar 2026 14:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiqXZjgmD9ZOlKBpg1uLVItVsEFwn4WTs5N8WfMgLSZJJFQfexFFNY6oUkAZjtmpuJf1HIYoR309d6b2Vkyvy35rPdV84mW53N1fjUZCVZ8Rezx1pkjznAd1geZyRqGgcqhPd1p51QodvO1ZcrajKMsAxvHucG52kziBmoojmoNz8puwo1r0AsPFNCW3hrBxNgh4Py2Xh01BeEiheWiAnzye8i9HhsWob/7pHv8Cje187FfAQNARQva1ffcTN2C1ggYvFnjj19O0y/HvgHPpWSLCtvtKYF38nK3d9Dl1YtgC/SAU+GiyHoBNyuVlrDwRMSDkf/4Bqn6FSlBv7cKvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v77NCVw2HfT00qzKpUO9m/IhA/a42A8g6+grD0O5G7A=;
 b=PvcbaAHk5iCMc4uYbXUEADihfQaZIKV+3vw3K1D92uh3wEt+UJ4LST91Dv8tYxitSkEeumjMz/Qa9aH5bcvA9aSuXv215M2uS5K67uEjYzpO4B9pfzq2/j+D9yaoOitwhzQpsfbFRFS17hUpKzJE4R12s35tAmKLcbNZYXgpDmh2eoZXlPDwEuyOB6UTn0FGVNFviIQQFi4jROu61l9YAzCsANi1lb1NtPDNY76caaWPfUgbx5N4PRCZiOXq4gTWI0QULTFcb/VJg5uVC/8kfIOXtab6Z0EeTjKNQDQU0D+OBBRzbo27rhs9Ojtk9V0/yzWub432189faqwbeebNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v77NCVw2HfT00qzKpUO9m/IhA/a42A8g6+grD0O5G7A=;
 b=Ntq2FXIzRdlieHmb5a0E+ArCyDFwsQXUUEmiB5/vqzQuvgIYwENEFuJZtQ2KEJz09RimpSzfUkBSzOfbzmiE9mYa57LpIgMYdzxVtnFbtQ101xvbP5a08uJB8FWRZvwbFvdCtcNFyQL4fP75AMnwbNcCKOYfWmzqPeH7crUkagPAhMJFk/hOegAxf6WDqxCekjzvzSahnABAeZiHVCsSaS57Ey9QconWZtm5D07BBqDSXrxMeGq3cVfZQIkoB63Li96giE/tt6DxQkoskbteBaK3DD3kEdgt9+2uJP5L7+07QTq7Uh/pFANunuI5N6aJqwUpDjoiurAJkrr8K04gPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 18:25:09 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 18:25:09 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v5 4/8] qdev: Add a SsidSizeMode property type
Date: Mon, 23 Mar 2026 11:24:50 -0700
Message-ID: <20260323182454.1416110-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323182454.1416110-1-nathanc@nvidia.com>
References: <20260323182454.1416110-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 7729830f-b098-48b2-28d4-08de890983b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7G4aqVPRczNyn47HQ6HToC1oAEjpUhpM8vdRU4OhGBZ3JD5nd7ABUEdb0RVkdOHk5GN0ou13uShkKeqoI/oxwMqWdxQdWJDTD0Iyzqu1pwYWLXYluLFeGYU+wp5E/6CW36D7SQ3GxbV7qr5Yu1dGK5jGoTBTGxqdfqZLtT0huu+1T3j2AyGUpYw5VA5WeSOkdA9TrO+I3yZU8MGWHXLWTtWN56YNKDWkkNGxQwV/lb7V4zJkXwGViCr3pT2MJ/Gvcy1tVhnCEEBvA/lQf69IgohN90K3PJz6KnTK3kB4m4OYenodfIiawGviOpIQqvuVVPbcm1nRsDiJoM+6Qe2YyJgdB0JgyiY+7c/43k65xOYAysodvRD/pCOaPk8w7mUjVCMpJObX0paG9pwceoK0zUTadG6WMOMg/dBa7tQDgXrifIC8vxkVRrKycce/mFw1ECUMGs9ZBmIqVat9+0oe2OEIsI5uBDnFCnP1C70uipcEtu1SoPJ3wNaQww6d98/dyGLLYkycJ8r2XMx6/4VDDFzdscDGcAkfeOiHwD6nu5IzxDITHXy/SZzHaXfsDCNkVZ5E9GdBwKm3tFhQw/Y+3Lw7tnFRwBA9dTRxh4U/94KIeun2sxnwwAUsPjcYdM7sRn8hdfdcRLNmeuwuaPWxOVdgZJFNLstddZrzGP5QvrTC5TAv6d8PHsfnw0hlCs8WGcnAOw6a2rhtrSKcBxbeutnp6OLChej1+xgTaSV1Q6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?94O4QzUv+kPswQNcCIGUgL2R6fINCmpWVSw/CMlaQzkjcvJowU0Mcx2tZxQ5?=
 =?us-ascii?Q?m5RRJROTi1WfvwQ7zuX2w/9zgEWPpzenLpXtphZcFrYKoUnOOD2JHPmcA6pR?=
 =?us-ascii?Q?W2ClO/Htw+4MSJC+6uZYNSxg2GuF41DqKf1ttJ0GyaCXBu15/q/rFSBGn5Pz?=
 =?us-ascii?Q?inKc9ShPsBmMRd3suqjMLLj31qEt59qSsLN+n+80HUnFdU4cGAW9DawyU9WU?=
 =?us-ascii?Q?YfFBrOrIARZeMG7o5M+IOzNUC1wXki4DZreMKh2PZ293qpKHrBdhAitjMakf?=
 =?us-ascii?Q?BlgHwP8FKl84pzuK0g2OaucZpygpQfI/8a5GptM3Ee0vtppjNNTNQni8Tz0Y?=
 =?us-ascii?Q?383iD9Jiw8u79fnbuxg9gtlIvL1oDyNRE0vDivCD4lRXO5pEnDbQGFR09z1x?=
 =?us-ascii?Q?dq0OAEP6bGsugz1wip7gRDiwce2Qvo8vrNrEmbLFTx8QhcyY9yDqGuYio2Ux?=
 =?us-ascii?Q?DJtfPW3uTKzeCd4+heVHL7Mw3mrPK3YZjlWxDkoRCUU+L0Kpctzn8M7c3bQv?=
 =?us-ascii?Q?iCd1P6Y6gyEdRyHaL6Anc7yXfELbBUFYWmX2PD/yido5NWYU7mNPniuEcQaR?=
 =?us-ascii?Q?YerMtyUOPQA+xQ4tmnTIAAjudPQZcvOjbHoNPEEKlisGkTjHGX+0LAY2I+lY?=
 =?us-ascii?Q?qByI2i8/NTqMVJIKpiJooaiIaq9V0dMfyu58NR7kc7jcC+zmEf+qrY/LvTRw?=
 =?us-ascii?Q?EZaNtzxjDRWzBzGXdlGi9cL2o74bh81DdCqtUD7icM1yHGFSRqUcuhXtLT5Q?=
 =?us-ascii?Q?U1jffJHFtrnDfGDbPrEMLzYx/ISW6mHgzcwdLK2BF/gAWlweH/6/PiW2qq95?=
 =?us-ascii?Q?SAIsiu2fZ2tBhkGPV+He9Pb1Zb5tPNxeBYPQOpqzX16St8JeE4AVIa9QQO1V?=
 =?us-ascii?Q?xy6HAjdgoT1tazo3CaMtIpnOoE3JdRl8+WMoRO3dcsb2sIgPQG+54Fq3fTCo?=
 =?us-ascii?Q?upy10xBfRA/4wYb/U6ALrwy+37u1hhtksdq2dmqPY51yiLaTghnmonQ8cvNz?=
 =?us-ascii?Q?ZwNfIdxqq7K3NtaiGivr/w54OBjrBMf94D/JwmDyD+R3wP4RH/LxYlZawnOn?=
 =?us-ascii?Q?ZBO0/Yj+6nYvtHOAMS5Px6irCiYXm0eUFbSYINY44eUoWt1GvSr6uj2iiNhk?=
 =?us-ascii?Q?G5RoLKN+ndIriE7UNKbAgN0AbUIGilkqk3DTP1mIqNv0P/nReHaGSPNH+m6v?=
 =?us-ascii?Q?dU9wu5Yr74BVlGkeenE76iQLOmx97KPyPIQssReUC5uwmgMRB/x/lLRJQQAh?=
 =?us-ascii?Q?Sw5+47EcWG2WoknAP4QA6kOXM1ueFP7SEk9i5NuX4xPThSMUI72bSPwY9xG5?=
 =?us-ascii?Q?b4u933qLMNo83EhXlzUsYczO1dlI68UU3vw+nhYozQ1gJQM/0mQ2VghldJUe?=
 =?us-ascii?Q?T2OPDSHB4PAxMyX2DLFnkOA7LOfeUKZxtHy1+xibEHUokIa52/y+34rY6Bon?=
 =?us-ascii?Q?cYXEc8yMDcvu/Z719gnNZiufA3JCnTg3HYop7szVT3CfP/5FmRBQTh6jZZP9?=
 =?us-ascii?Q?32PiuzQaAWhj5IhJV9CDbJi07ozza0cYci0mqKGpVGdqDEGZ0c5YYBRc9chL?=
 =?us-ascii?Q?lXLFR1GAUW32HEPlacibpI9+4LlFpy+qPS05f1kJtloAFuWa6N6vNOv6Hr4i?=
 =?us-ascii?Q?pREer7eRp8vkje3IKw1oGTNYcbDGBpVLa9zyjin6DAMtmqN4JabN4bu587rn?=
 =?us-ascii?Q?ZHFOXq0ZIXW1A5S70N56QuWs07z6FnIt5raHPxr+8DdllabZT2ypAZi8Rb0G?=
 =?us-ascii?Q?aAQF7pAZ/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7729830f-b098-48b2-28d4-08de890983b6
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:25:09.3934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeiG4+HuxwSVhGOZFpEedOfbZ2bE3S/LciNaBVLy3xNLEZh+c0YAFK08E3AvFeBhQNiY6BhJFGTlyXcpBKuPHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nathanc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Introduce a new enum type property allowing to set a Substream ID size
for HW-accelerated smmuv3. Values are auto and 0..20. The auto value
allows SSID size property to be derived from host IOMMU capabilities.
A value of 0 disables SubstreamID, while non-zero values specify the
SSID size in bits.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/core/qdev-properties-system.c         | 14 ++++++++++++++
 include/hw/core/qdev-properties-system.h |  3 +++
 qapi/misc-arm.json                       | 16 ++++++++++++++++
 qapi/pragma.json                         |  1 +
 4 files changed, 34 insertions(+)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a402321f42..4aca1d4326 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -18,6 +18,7 @@
 #include "qapi/qapi-types-block.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-migration.h"
+#include "qapi/qapi-types-misc-arm.h"
 #include "qapi/qapi-visit-virtio.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
@@ -723,6 +724,19 @@ const PropertyInfo qdev_prop_zero_page_detection = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- SsidSizeMode --- */
+
+QEMU_BUILD_BUG_ON(sizeof(SsidSizeMode) != sizeof(int));
+
+const PropertyInfo qdev_prop_ssidsize_mode = {
+    .type = "SsidSizeMode",
+    .description = "ssidsize mode: auto, 0-20",
+    .enum_table = &SsidSizeMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
index ec21732ce5..4708885164 100644
--- a/include/hw/core/qdev-properties-system.h
+++ b/include/hw/core/qdev-properties-system.h
@@ -14,6 +14,7 @@ extern const PropertyInfo qdev_prop_multifd_compression;
 extern const PropertyInfo qdev_prop_mig_mode;
 extern const PropertyInfo qdev_prop_granule_mode;
 extern const PropertyInfo qdev_prop_zero_page_detection;
+extern const PropertyInfo qdev_prop_ssidsize_mode;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -61,6 +62,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
 #define DEFINE_PROP_ZERO_PAGE_DETECTION(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_zero_page_detection, \
                        ZeroPageDetection)
+#define DEFINE_PROP_SSIDSIZE_MODE(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_ssidsize_mode, SsidSizeMode)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index f921d740f1..416b4240e2 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -45,3 +45,19 @@
 #                     { "version": 3, "emulated": false, "kernel": true } ] }
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
+
+##
+# @SsidSizeMode:
+#
+# SMMUv3 SubstreamID size configuration mode.
+#
+# @auto: derive from host IOMMU capabilities
+#
+# Values 0-20: SSIDSIZE value in bits.  0 disables SubstreamID.
+#
+# Since: 11.0
+##
+{ 'enum': 'SsidSizeMode',
+  'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
+            '10', '11', '12', '13', '14', '15', '16', '17', '18',
+            '19', '20' ] } # order matters, see ssidsize_mode_to_value()
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 193bc39059..24aebbe8f5 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -68,6 +68,7 @@
         'S390CpuEntitlement',
         'S390CpuPolarization',
         'S390CpuState',
+        'SsidSizeMode',
         'String',
         'StringWrapper',
         'SysEmuTarget',
-- 
2.43.0


