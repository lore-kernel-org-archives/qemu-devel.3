Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B026F483D7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jyK-00025s-Lu; Mon, 23 Mar 2026 14:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxs-0001vd-V7; Mon, 23 Mar 2026 14:25:27 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxp-0004GC-Pw; Mon, 23 Mar 2026 14:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mv+LkOxzjy3nE2B7Fem3m/ljlMyIGw3zOHIQy9svIpiuZ4YW19ZdjJNd9wwEwhqgHtJqm14RQx4F+dSZLw3HLYo2lYinCFGgCnc2prknHaDv+ikMYt/wHwZ0rGW8MhhgC0T9Jvr/FrZ0IrgP5iZVPZA5LsDwez+B2AqKzfdZJ/8UiQlhSYzsGIvMAGpRp+OURfqSFb63FiCyTYHK9fvAoPYIu1YziSRhfICJQo9+s2DW+opjqi9XKZ8HfhRrFdpI0gjVeq84wvgGkaXC9nDK1mbWcfeVLI1Neu1u4GTzB6c2vG/KgftB+0j3jS/ub9JTmPTQAmhXReBbY9eUcHYMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgsWL05e0lLKLZNf3USWh+C8WL7E9gD3Uj1DErbGrjg=;
 b=bbDxEX1PxZ5uuHFlIHPDCY4msH1D2h3Ls7Sj5qGTIYIXaRpzEg6Mjkj+nTAVUUw0sWsJfvj+FNtySUySUFBlSqfitTbYXGkQWyAx62BbHaHdCUVvdeP/U4voSbnNx13TL0azaAMyVMP0tTJ4Hxjtl43g5kzfXJS2vd9xkpGRkfuk6bXJ+ZXuLDVYvz/KOsjbrM2A3mW48LT3VmQR97VSwEn+IO2lsV3PbSSZk8+qSbBSbjgOkCm9++IX5vAVd5C9N0zQ3uWJcNbdxmEBO9i5xwVP5ItJgwXPckz6vGY80OecF1++SieAYchPrCGqT7W1yG+98CTCQm0hmyB4qMkEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgsWL05e0lLKLZNf3USWh+C8WL7E9gD3Uj1DErbGrjg=;
 b=CkWQqt9VA9F/nOmVnaTwHfk67kmH8CKwWBstUL3tiItb11ee6KhKn7uCd0UVYjsTFWJo5h9ecC9BuMwSYe5+9mJ3sZyxIMpE2pqC9kXQIjpTYFZFfHDXIDMFM++0yKvL3S/jgDT6/3pPwY/yj9c3YPz/2OZZmIwldZ/R2wiqH4TDR/tvL4Drf2AEQFADIY0+Sc+fJDnQs+bFf9zjCmI/iaWTtNi8SZu6cZ/XNq803kG4Bk9QaIgdFPDcxjr3mbTJ1tAfIrn27/3w85XrAJUEvWyCA9YtgWyJhwgRKxxf4tnPek0oieU7AnsR7Hmxj6ZlWMrhwuWIwGakwNP83Jmj/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PPF12042BF6F.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 23 Mar
 2026 18:25:12 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 18:25:12 +0000
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
Subject: [PATCH v5 5/8] hw/arm/smmuv3-accel: Change "ssidsize" property type
 to SsidSizeMode
Date: Mon, 23 Mar 2026 11:24:51 -0700
Message-ID: <20260323182454.1416110-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323182454.1416110-1-nathanc@nvidia.com>
References: <20260323182454.1416110-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0209.namprd05.prod.outlook.com
 (2603:10b6:a03:330::34) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: a66b9cfb-a4f3-4279-8918-08de89098513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CH2VpICTsEUXZnli7I10M6Qv8O+QHnEc8T+a1mnhlvX3e6K39Z5BgY0BhomrmUhke21QTtGRuo12FxKYPUJDNMEqv84XPcgBynXcWF/Pc3UZsYO01NsZwdApKjWDlMoyHD5NiwyJXGd7ri9lP37uN09pm/8s9t54a+vR0ewzR3ZxQXOyN2zMOhBMeFNss7LoLNMyxt4XDKtAal8FJznsp06kY6kpsqv0sBOq+QBgxjrWr8pSHifHTlWKex8Fth5qNyqx1AjAQG0LV+YhqsspJtSQWEtrVOxHy4o7t2T05S30DL3E3HV9l3j4VnCyKfiUPcmMQNeODmT0geAw8pTWL5WAMses79DZUnnewc+8SSo0ZX1FU8QmhiEQH72lbSFy9fQceBaoIe0yEcttc19nO16A9zxl20GE9isOacnGSttssGfnr6jrCa9zf0TezQiNspWk5V8H+xQrqqemyE29FqGDrNCKQsddN7N8AGalFUPcrc7Xh15JlSOmdv3bt/fxMlt0BKc+eRlG98ZUgUZTBJfyyIRCFs5vAqutv72H0aBp3H+SoGKSU4+zeDUpRvIkD6IORAfYqiSMNAmVajfFtp/ezrcKrwe11f1bgscvihdYTt8orJZ4pqUacdxUzCtB7v+TlPb8OxGKDOr2taIJ97yUbuZiTLwxFxYNderbst72R8VFcOOlGbAIJMKDzdmsRMs0/AHo08BYgBJqp0g15EnGRMsWZgfwedyL4P57j/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9c4Ivg0oK1g1+Q0sg+766Pkzq2x4DPZc2aKuq93QRGubYbxZYtVtKzQPXzLe?=
 =?us-ascii?Q?p1ZjyzWw1YXMNYK0jJxnnHt8CJnPNdQe90t2lU5qZfloW8vu0pbv4a9vcnCf?=
 =?us-ascii?Q?x8thxjBQtqqlqWiE5yKq3Pfz7Zsl9WmpWgewoqG7hbY06yVrGJd0zkMrKgHQ?=
 =?us-ascii?Q?oEVV+Npsjsx9k6mR3qzR08i+8PHM1nJa6tP870+ud9oDfW45APIzbA/d7JNU?=
 =?us-ascii?Q?pQDr18Ia94sS6IkabdIc96bnoW5aWMJK8y2iHGNzEoViPdmVHetM/Pqgr7lm?=
 =?us-ascii?Q?8pW/cCeLnYuo14Xgcyc8vqt5RK3JyR7qwptKe7wHm1tIDUs+zFz2I8vTkKD2?=
 =?us-ascii?Q?ObKWJWr1LCaeWsl0kO238MXrmH3O58O23/WkmtfB7KGz93X/SZMteLF8FCPT?=
 =?us-ascii?Q?38S7KOXaT9bf9KWjy7k0+FVwj41ZQ0c9WzKwjEFNb3kNDujn4SiATN2FOnl+?=
 =?us-ascii?Q?BEUYCzowhIWmhEOO1+BCnUPZq58K2Lmell2N4TL6p36XnqXAM45ChQkcoT8g?=
 =?us-ascii?Q?E8zgp+zziVMen84MoBqDjdLpvp5En0ngLkFVoOg0LAFtkJFMVljm1Sr0FqgM?=
 =?us-ascii?Q?9WzVXvngZ6IXGI481pzHzcO2iFeGKquQHYYpM4sk+c+1es2nN7G3IhyRp1WF?=
 =?us-ascii?Q?LC+DthIpGNItMEmHZNgqw1RN49UckRCU6IYJGgrKHLk52gx1UllKsVPMeiPq?=
 =?us-ascii?Q?AdXv7w9hqTuB8syRxHKEdYnHirygf86WOBfSq/Ua2+8FtBA78RHbXO/vk06K?=
 =?us-ascii?Q?0KQk3QPczg1xeV/ymvT5RIgzPj/UTy1LODG9RGXuvxRwdu5k55aJW56IZdPW?=
 =?us-ascii?Q?ZXLEg/sPXy6Y5oxoEF1wXA7KrAYXKjmcNFq9nBgCoWBFb5SMZ6GFy9Rx9OhU?=
 =?us-ascii?Q?4HmUbb24AjFiD2lZMcabBVDsjeMdUUY1Z8nEYsGNZhp6UCLqt9hIl1pkQpEg?=
 =?us-ascii?Q?DwfSm/M1cbl7RwG+SMqmUbHyVIxXckEo8gDz2HDXRNaWdbbPd2aE+XA/aYcB?=
 =?us-ascii?Q?n94cq/AM3zSILt+2eMzM7aeMNgYG3BJ27GYrUNRpkEkCOWoHcmgyTCD1OCNF?=
 =?us-ascii?Q?DdSYmrzbU2iS/n3viA5lvlMxJE5DxS71ACqJb6NLOUJ0UbiapyGR7jN5+KvR?=
 =?us-ascii?Q?3uUwwpv8wgUBNmEmSJXwflJXIcKMJ5oNkKi3pRMNgXBnaGcfUGw97yx4Nxr1?=
 =?us-ascii?Q?HA5tRte3D0RMTrlpaiRigQmYZUdAgIgSYSmK0eczjfENUg/r+ORzsgcliH5e?=
 =?us-ascii?Q?usd906WtMCjcKX8zSgjC8rLrGLkZUWdXT/AI7biN8cjEY1N4JAYvrgidJLTk?=
 =?us-ascii?Q?NW9p/Dm8qTcOPQmEl9Ok6XS2JnrkMU+RPLoiyqUwgKnygHhU7SunjpD7XBcZ?=
 =?us-ascii?Q?ZbWjy6uWrJy09eWtHFT9yivsu/jpRLvZbzwa+LYMW4wlPr/HL75kSa+ybGtf?=
 =?us-ascii?Q?WJ8dxR6A6uOf2jHPJphZeUKqE/4Te0J6VWqtonFp1LJCbVWUN87Z8m+JlBa2?=
 =?us-ascii?Q?+ZIfJ/i9RV4sWc8QNYAQQYHsrlrceXPQrEBqZ7OpZhO38dUDN0lonih0j0wX?=
 =?us-ascii?Q?VmZkBz9mQtdXG3Mt0ZfIePDpDrZHRQtkXUhI+O1b676w3bCKeqBvxcg5Y3Rg?=
 =?us-ascii?Q?6kNcz8ml9G7qXTnjFhT7Ms/qiEGvdwdmClvOcwXm+FppAd6Otp/DspUF0qEB?=
 =?us-ascii?Q?gDP1eYeYRioYz2RiQOjUTF7TH8rzeczZWmY/0Q1uixXIqFa7DLhzrozu30By?=
 =?us-ascii?Q?E7twmSMzHg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66b9cfb-a4f3-4279-8918-08de89098513
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:25:12.1434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oiK1SkwvssY35u5fRd+QrGuNHrqst6oeDpE5yyC+yuN+8bQD6+hJNDewa7R2PoC/Pver9Ii9YBd5ZJqEXQpNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=nathanc@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

From: Nathan Chen <nathanc@nvidia.com>

Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
The 'auto' value is not implemented, as this commit is meant to set the
property to the correct type and avoid breaking JSON/QMP when the auto
mode is introduced. A future patch will implement resolution of 'auto'
value to match the host SMMUv3 SSIDSIZE value.

The conversion of the "ssidsize" property type to OnOffAuto is an
incompatible change for JSON/QMP when a uint8_t value is expected for
"ssidsize", but this property is new in 11.0 and this patch is
submitted as a fix to the property type.

Fixes: b8c6f8a69d27 ("hw/arm/smmuv3-accel: Make SubstreamID support configurable")
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c          | 23 +++++++++++++++++++++--
 hw/arm/smmuv3.c                | 19 ++++++++++---------
 include/hw/arm/smmuv3-common.h |  1 -
 include/hw/arm/smmuv3.h        |  3 ++-
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c31b64295e..bc6cbfebc2 100644
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
index ea285bdf64..79018f8d66 100644
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
@@ -1979,6 +1980,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "ril auto mode is not supported");
         return false;
     }
+    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        error_setg(errp, "ssidsize auto mode is not supported");
+        return false;
+    }
 
     if (!s->accel) {
         if (s->ril == ON_OFF_AUTO_OFF) {
@@ -1993,7 +1998,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
-        if (s->ssidsize) {
+        if (s->ssidsize > SSID_SIZE_MODE_0) {
             error_setg(errp, "ssidsize can only be set if accel=on");
             return false;
         }
@@ -2011,11 +2016,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "OAS can only be set to 44 or 48 bits");
         return false;
     }
-    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
-        error_setg(errp, "ssidsize must be in the range 0 to %d",
-                   SMMU_SSID_MAX_BITS);
-        return false;
-    }
 
     return true;
 }
@@ -2144,7 +2144,8 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
-    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
+    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
+                              SSID_SIZE_MODE_0),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2185,7 +2186,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "Valid range is 0-20, where 0 disables SubstreamID support. "
         "Defaults to 0. A value greater than 0 is required to enable "
-        "PASID support.");
+        "PASID support. ssidsize=auto is not supported.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 9f78bbe89e..7f0f992dfd 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -311,7 +311,6 @@ REG32(IDR1,                0x4)
     FIELD(IDR1, TABLES_PRESET, 30, 1)
     FIELD(IDR1, ECMDQ,        31, 1)
 
-#define SMMU_SSID_MAX_BITS 20
 #define SMMU_IDR1_SIDSIZE 16
 #define SMMU_CMDQS   19
 #define SMMU_EVENTQS 19
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


