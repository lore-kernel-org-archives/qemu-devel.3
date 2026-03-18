Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF531077608
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vxh-0006kP-IO; Wed, 18 Mar 2026 14:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxf-0006jr-UC; Wed, 18 Mar 2026 14:49:43 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxe-0004y3-CR; Wed, 18 Mar 2026 14:49:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDtyE59h4zgkWuNQzyonYgrJLtH5TymGjhEa1NqxcJ1LWYln8SWY0/1CmcHTNqOd3Z9q3p3EQElDj0fYz/8yqAF7+o5EGglOCeeFcMPVuX5j6bhxMBQSpgByJQn6ehIER6G6OmWgCMB8MICzAkqItrURsiGNeXMnpkaiL4fdD3iQNJS0zzDG0k5fSDNAob/iqFlx/48RU35uIEWvVUuPkPISIhY85Z1ck81PaNc/WfaZYZWgK6Bx8YDbjlzmDbUOoEb6T/O9DWkqWFc7PuIQ9v1XAvyVMIW6TKnv1ljPwOodX30HLz01a2hfMOajsNiS51aLitu6LUuDE41ZjkCjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S7kKm39mS3VsI3lNow8nqVzhlDRuGxGpB+T0M7Xhn4=;
 b=nWktNuk2HwpNTU8FP0IyOXctzibH0SRKWx1096KpvhNEnZv6PbeIv2WGA8DuBjUOhC8SYqIg10lwoXXT71GVfD1mW7VrbYm2rq31cXaPkMM4HTdGxKO+s0yOH4cq/q9x3yvZKngdV4Sb6Kodfr4/j7EpPNpw1/cqB231wTFu6kyJIJgXroDIZ4PPwNev1BrfeIig2vpNxguGcefWteNZhT9hLOMtBcCUCHDZq50eqSPPFGkPSxDTvk9drlrzZnnpnT/qvjjwLb89nRb/rqZePJub9Dgo2YRd41G49ZZCyselKter6gp06I2/YipobYMZmsgqWr/tCs1DOEyltbae0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S7kKm39mS3VsI3lNow8nqVzhlDRuGxGpB+T0M7Xhn4=;
 b=Zlnh/rgee3RJD3MJS/O6AgZaF1xCB0m+VR6fKkCszi9UFoUJz0jeuUj2NdSC5IDwU7XLSOSiTHDqVuf356OBbC/hJ+SiBqf0Frumd22bkiVz7M9lrXzHoUutbcwjrNzGLUJ8WxLEeadouwfpaWTg+r8TGCCKCoaI5mn0XVYskHTSWF/pRxqu0DsWyscxHXNK6HqjD3yMe016VClui6m6zI51rm+dzUGME5wxgrNyk24mtX1ULpugOCpltOe2yiYdcGBlr61d8A3meT0HT24qcQSS5F5p1hRhJkRc6W6OoG+jLSr3uGgN3xF+1yON/h+qxxi8WvaYrzW0jdpa8PzJsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 18:49:36 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:49:36 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
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
Subject: [PATCH v4 4/8] qdev: Add a SsidSizeMode property
Date: Wed, 18 Mar 2026 11:49:03 -0700
Message-ID: <20260318184907.4060030-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318184907.4060030-1-nathanc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c93927-2c77-43f1-36be-08de851f1a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: j3tZgQNYPlXz61GZnR75H2E7JJnmy0siESBuyGUsOwmy8Qt/BjCvdaaAcDyGzq0oWH1T6KPtkwCz4UsFaRvRq70qdYahsFuJi+Pf6MPmtg+HsT3Af8Yt19fxZND9HmZJIEu8DO5E1AnZ72b3dHXgqZyM8qbj2hW2ij5RJ+4YvUQvYO3HTM6sOV5tRzeBDDwU+eLu/JD4flmRvOvkA31AcLNS1AR71gB0K6qJqM2aQLxV1qS++Ps6wK7dDnXcvzPPiee12+ZCiVdJLPbRYcVAj2ROyeQuyiFCegX6UIzuHZ6XGsjJSRb8B8LwFFp06Ya/YmsRJc0NQTkWdmKSQGkEKDXt7ublTrVMRb1u0LEeYMILgVbwMXJsthUNKrTj2axfmOuCQburtNvkJqTlhaPLxprHqWjhQvO5gWcIH66z32ryzfAoRUzN079sW2DzP87VYHMppzT2Nzu3o/M1xn3A5GAueTjCc1CX4JYGjWKyB/P9T5MfG1REhSBUVcvrYoMPBuhl1EzxL2LRQUUkBjcsN4TlqSKm2l3NOAA4Z7vui8rkQ1cNJZpeSHfIfj9mwcaQt4U8/HrHAnvZvSnmqt9lh1wdbJXybM2QN99K7kkAE7LzbtfzsJG1dY4M5PuvVVBHFoY9C+C3gjp7oSHM9Y88JROmNVpDWgxdyr0LVvsZHjlokQ5DE7hDsAg61mNXPVp0CduNj/gO/HfM2/5M5FwugAFcuIAtLe+oSy4XHg/7wxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aW/wXlIaIKekLV7+w2oUTiF3KEQapTYo64yBdoUHA3GCoJfQJuP75vpRyDh7?=
 =?us-ascii?Q?HlTTHdltzUKMKKIc8e1iG8JgMkKTpjA2k4o53N6mt9QZDPbmn+Yonm8QhMQU?=
 =?us-ascii?Q?FWx/TheOhCoom1qX+ATplFk7/U/piukIM4SmwFpUGfJyxKSP0SVUyfCG2i2V?=
 =?us-ascii?Q?bmCWafJE2dFf9ev32jzMXSFGWoFUnSWzpd1DT0CuUSqcD8wA4IYL/5y1o77D?=
 =?us-ascii?Q?fmgr9EWkpUZi7yfZ4XLq/CywFcBAkWs2WorpUz+kBOVLjCNonxs6MztHZ4Gl?=
 =?us-ascii?Q?1fzt5yWuvbxUprkza+j5PSCh0FDrvdHwuf2i0LU8PiD1ReLrnQYbWftA3zpW?=
 =?us-ascii?Q?r+IDxzM3V4lJKTe0mp0sqIx80Y7OHRo58jSqRahito3pmdS3BfZxTsjmg9RI?=
 =?us-ascii?Q?zSLHs50PEz5C4BsmtVqSkvNPmR+SErm6C82+uGQJ1RobW2JPZozm6UpHPL1x?=
 =?us-ascii?Q?1gHNvWbx7TaUCU/qIv7+l3ZGwrScwdD6tM/1ot9hpfrihgVIfc668soK7zrh?=
 =?us-ascii?Q?x7B+nDb2xCMmS9vLpIbnetgUZ1p+gO0DRv8/lTYkq1A+EqFYQscmOOZIIsnv?=
 =?us-ascii?Q?iMkdhxNLpy4+U9V+3vDySccjpLEqHbeCHxlRhFWgDqVsPTcED/z6RyBZh089?=
 =?us-ascii?Q?kkkv8eYbGthHZ+6UpHJ/VqDE0/6TPtnP51YBuuJpUVHBWtfmR/IOJrdczl0/?=
 =?us-ascii?Q?2z9IeGXncpZox41IVnqlmzzpyLzBkgypFkXyDUnAZx72H8/GuQz3pOFR9chS?=
 =?us-ascii?Q?qykXFXaqaHS+J52VAKoEUQoYotMbl2WT3RYvCTzQhfg8sVVCDJSxlyKs4JWp?=
 =?us-ascii?Q?lHUDDum5Il76i1ttBQA7Dk0/wWA94LyLsbYvX/kTtRUtxMzn1vc9hbawocvb?=
 =?us-ascii?Q?hhaUGCVix3ArZfsa+//AHtrAe/DXSiVkeerZEkI0QdmGUfS4fK4XRNG5HK82?=
 =?us-ascii?Q?oPBJr6U4ViTKXMmEkthl+x/YhI2pFr40chprfveqHdh6/j05sO3pUJNYg7jC?=
 =?us-ascii?Q?3HaX5lasUJMdmvI4TNNzokA/34OCR6k7XzNRa4Q6l0GsyvNDE0i7O/Ee9HvJ?=
 =?us-ascii?Q?3iHoQwqBGc7Yltn/z4zqO39sPQ8obcpyaPljELm4EExLYFEj7wBKDxkoKaEX?=
 =?us-ascii?Q?XtF3jN/Y0bca646KPTaAmxEIpUsrPhrvttUIuAh15XIKfgt6QLULszMVD1aV?=
 =?us-ascii?Q?y3wcSll7MhhYcy4SPTl3B6OjgY3LCik2nsGbBTVFDnPwS9dxDuJm7di0/ZX2?=
 =?us-ascii?Q?HDMxyOUbnAeKdK1ICTMLO2HOVtwqpIcvtJ0++6DvCKhk3wxqiP22I+aLKCG/?=
 =?us-ascii?Q?E83gKwIyvxEb1JVsvWV3WAsM4dTAMYyTQfhx9+qSZQCtd3ZUivIhHn9miUco?=
 =?us-ascii?Q?9os1QyMB9PTbSd82pkNfioNAjGjUgE6N/zlTgmy0UXyFFTSe1C5+C2u3+A/7?=
 =?us-ascii?Q?WjAnqagKj9GnCoKNhyElcqsMmUoUERKocM+U07phnLZZFsIfNKWWUKLx5gd5?=
 =?us-ascii?Q?697ogNeQvadBqV+31deBt8SOFMrlILV0y/Mxi+tLSP5gRR3H5vhWmEzLh8OO?=
 =?us-ascii?Q?o/W+cnxiepFfyRbx5AId55FJih6cnqgeH+Dkjbnc+drQkf6+NDvC/gCsaWlo?=
 =?us-ascii?Q?2TM5dHirSGJPEV6XafYQHsYwoWeqCJ77LOHo9fnZi5X/nObkyhKLwAvwJge0?=
 =?us-ascii?Q?5LvViI8qHTwHNDyVVbDnzaJfpDHuUuX3zVTXYInsEnOeJtKa9c/NXoEIjaYm?=
 =?us-ascii?Q?O4JWy+jK8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c93927-2c77-43f1-36be-08de851f1a39
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:49:36.4847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW4efXlIcb6ozCGl/y4UwpgFzgFJFqf2rfYq5RyilnD1urDP7MssrSslH/SQZ1KemEEh6RYI3dUbG8EMgTtEVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nathanc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Introduce a new enum type property allowing to set a Substream ID size
for HW-accelerated smmuv3. Values are auto and 0..20. The auto value
allows SSID size property to be derived from host IOMMU capabilities.
A value of 0 disables SubstreamID, while non-zero values specify the
SSID size in bits.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
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
index f921d740f1..76ea0a09fa 100644
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
+            '19', '20' ] } # order matters, see ssid_size_mode_auto()
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


