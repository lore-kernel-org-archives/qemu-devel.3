Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84D21077608
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vxj-0006m4-Fu; Wed, 18 Mar 2026 14:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxi-0006l1-4N; Wed, 18 Mar 2026 14:49:46 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxg-0004y3-Fe; Wed, 18 Mar 2026 14:49:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujJ+dGz0EfZoVVwmVubJzgAexooTxtuddGXIC6Ak8+cMVZNFEveBagIb3Xcuj3DYMGZ+MA7/OxuDHzB1xa9EP8WN0MlTSAXxktmasIpUAHrKXEmsyJpTET9HjpZcjVHiGKLVXLWVT99Tq1x28lAyaexsvbGcNSZBnzKgrEgoNDlbmIkpyo/znvFHq5XN2+KXSWvOF4UdDvmzZRae7XRUPJrJeQ2Tz8SN+aILf5r+WmXKugKfPYsYNFCCOD1RZZQn2X97nBZrx/bFzmyo9D2HPeiij4vgFbIU8wL1YKDp9OjjlXYxPxp7aAtEuDKIh/liDtV19RLS0qih2DyVQ0gScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp5gN9D3ODUVkNNi3JgZbeERLwxPItghXhzcoYpwAHc=;
 b=REnPwuLvF4JMqPzkudjbAVEOjPOKh8THHz8wImFQ/89juf/zZsaBiPOxLV6F7TIkSPuwuKMXAZb5bqeh074xVo2tMATW8F8A/2SE37lB9lj4qEzbnqvxxlV2+HuWvC6Bpub4J/FaBqxnoCioMmBrHFX55EK/Kri/jgYAm1pxaks0n7MnJV3O9w0hQNwyO/Xe3yYYXTm+JENlEUsMywY0Q0YGkaPhn/ui52VE7cFwd4D1cYDRfsl+NXexIzU+LW6HI0HJVvyD9POjA6Y5vW7yMSctNTxcuQhKrmarKNEg4ONtZFuUvGRNoTZZZ3JPkYltMMkyCTtOoCO5qcf6Y/Z2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp5gN9D3ODUVkNNi3JgZbeERLwxPItghXhzcoYpwAHc=;
 b=fKJWgICgiAqSRMKtG1pqc09DFXfBd8mbdSw47Z2zRW1Be5iNsdqmQermY1wZc7Hs7IcZxFy5n+Op3jk326AFdV3t4ibBi/VMkm6ck7Tf7+87xzdIBCNuslV0pHxCJEqmRS8XCkxKG0a+AgHULsOgYCHc2xrWWR4H12NJGmWNrxE0h4CEHbOVMOLBHfVTEuNdfpQicY+TUcr01BG8UhAXTnzXxl1G0bcfqDuyLJ2dpzyOuoprqIyWow6gAbfU5QpXhKFz1gAhFlIkq701sCzDsA60QkOdatlM7nPDnp8LUl3y9tVrdZUuCTaj+iuel4mfzZWwlfkpMWAHkVlptKqCpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 18:49:38 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:49:38 +0000
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
Subject: [PATCH v4 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Date: Wed, 18 Mar 2026 11:49:04 -0700
Message-ID: <20260318184907.4060030-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318184907.4060030-1-nathanc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 1134e775-cfce-4b9d-8016-08de851f1b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: aoVKd/BoBHpKOg5Ysj442+g9BIU0N+xdhr7p1wRpbWmOJ9/nQnAjLH2If7Dvmooyxc+AmwHrTkauhbseLwX48CRTOOdW77D4rCC1rV7GJ0Kzu+N/wQjQgsKNCMFnKVp8QpJRPzJQa6eP0lZhcQtbLhiOJPcnSlPYVJU1ur2Xe+znQEs8CFRXI87NT45LlqvCHvpWq++FphfnzKWzeLDOp5m15V0hzLDliPi+vbmt2ph04qkU+OF7aGhIvFcpoxbMK/epwv30YTMWmWbNatD8wwNQUUe3vwpCxZg1A1ssyJu+7CUq6iivCENBzBSKrAG+FUXP6M88RY+AMyUcJwYvMRaAKXJZuEScdJ6M4JhSndoiPLqh1kn0bAxHsozdHGs+j6FV7R0eH9jySouVLOZZTcqK/z+/8oklDTowCHKvbE5/nPPMIRhybgbsQevoK4YjZZlFwA1v6E6WhW4D6GvdBO4JmxYWg4UNZUaJ0y5aCXZDpu05kCiipAx2LEaXbu8tQh1M9gl62meT6cobRFX4Izqjlg3AHmGk2TVAWn5Fats3TfUqPr1RmGyvNUhLC1n0R/ez13yFwo7n23IgsSk9jtZvTotwns1L4D3iKGLmyxBaB1y5Yf2uaUJl09q73sDqneVDBfFHggK7S6AeZTbn75NCJZ8m8P47V3Jej677/YkFUeYQRArV2zz0x2NF3o5bp06qWX06y/8fljuPHusEWU5Uoh4iBnLnaFJcFw3mZz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aV7aqBZMWT8B+OQfZoli93U8njuOwh6kAA84SqoISbayvPr8O548B0vH6M/0?=
 =?us-ascii?Q?uIrdSDkAoV2BvUnWt07oachj3noOfg3227+fXCMzKrvy8TrmzaY0rs5zRWRY?=
 =?us-ascii?Q?xtlMeET+ppdLRubnaZ+niNUNoSmmDIsrAiTiwIz7pBnC2bVw4mQrSNvkjTml?=
 =?us-ascii?Q?MFlw7mDlWTWLhJ+Bv63ZOk6yFlMkuBquPcFNTc7mrV9FeVJHEDVoQgRnW/MI?=
 =?us-ascii?Q?X0rnGHqIm3F62AzNhekcMAlrHX6bMxSwyOc8cIeb6X6pOLQIR+E5Vz3t8pUZ?=
 =?us-ascii?Q?y7rJJ5verYL+5dosrzfk/yB1N3oD2K64qMFu241ZMEKMiv/s2eJFiLrnbLht?=
 =?us-ascii?Q?bOOiA2AAof/GyLX99smJ1zZ9CV1QkNgyaDk4TXqpZcUoUWrP8iYMrXiMNOoY?=
 =?us-ascii?Q?y5fpoCE3GYybULtbBSx88p5LRrNdbxDkyMZCBi5TFAHbr12QMI5PY4HjNF+1?=
 =?us-ascii?Q?odCejkwqIxKLNkjgCiAx6n20QSKyVIKUgLz2mAGOYqEmo4Zs9HXomSC0ebo7?=
 =?us-ascii?Q?S+NUFJYRaJmJeX04Kj4r0I1vWUaeu2xrx/9QACAPcDo7h4tjxRp/RhEJ/o1v?=
 =?us-ascii?Q?sI0g2RE7mt4XRP1GVx682egk9384oX5O55xsl9/sONGUwmJvnGxQRgt1ZYmw?=
 =?us-ascii?Q?M+WwqQIs05y/H5ZGbUEoh/xjDrU2VM8/zvmikDgpC0X8bczTLuQBjMpjLoQB?=
 =?us-ascii?Q?Dege59EaC9sPLZ7sF4rP+xXNs5t6ea4LYdGW/zczKENhwOnDhQMU+CUhT7iy?=
 =?us-ascii?Q?NrAJNcq9HsXxtpHDBIYQVpPf08A2Lr/uCtJKtkXFaj+CLpHjK4kfvybXMHL3?=
 =?us-ascii?Q?sFZKKJXcydqpG5g2aib0vuv8GfJ4kMikN587SGenMxghRKubavcxf9JWkoAV?=
 =?us-ascii?Q?OxESXmU3bvdlSbRC0yycbkTtbU8kyUTY89NigAlMF/Hnihx3VRb/mlPFPrpx?=
 =?us-ascii?Q?Fgdv4CGQzpOi7OZwr3we6sFiihUgKZthvkPQ+kUK7myJgDYW4rXjbnKiDqNy?=
 =?us-ascii?Q?68GBZ17B40p/m4vZOuf9Up4vdEMLv4KqxAiD8vsV0xDlXZBqQgSYkSqOs8Xe?=
 =?us-ascii?Q?DDNdJ5APXh5NLFaLRozCzLWCM9nrNAX8pW3uCLDpoL2u90QgH5ng19Mk6sAf?=
 =?us-ascii?Q?/8NcbIfV9vofihuSAcZQuupjpetPaAuZBhC7W3K2UrnPsXH4C8GU/PPfKNB9?=
 =?us-ascii?Q?OBueK1DG3sZamejO4eIijVFCN/DLEt2ZfHcK5YHSCi24HsrhgJpR06VD6mv4?=
 =?us-ascii?Q?QL06DidjxPxrhxXnS+SviSjJiIhbwYvcEim3kFE0VAev7l1j22co644Lw0IR?=
 =?us-ascii?Q?3iOILn5sV0yzZLZWjJbyn2pJUZVhj2H/M7zITj9Nzo97ofWCmj0h8nAuKEbC?=
 =?us-ascii?Q?iIaVnptmhqC0CvN8Z7KZTlLHhVicGhuyrvz5fL9vSCGOuR2t/rXegwp4d2eC?=
 =?us-ascii?Q?omRz9KxwZNGQgPrUv+DHnLmL+/Dibw6VoJefGYtKTBV5dTnQeh+ONTgaXAtN?=
 =?us-ascii?Q?crF6OwltYD9H7Y29DTSB7VKFqlMmxUd+4fy9r59+7s3rpAMC9Svz3US8UrLL?=
 =?us-ascii?Q?hNGTi1yt6f5TEyR+nAnBVQQLqB4SlcddyrdMjfebjP0G1Mswq2k/gSqai6mo?=
 =?us-ascii?Q?pVDZ+JfKf6KJ4/L9o5+YFIQBtZ5Im+OviaFNb/KOOdrs5ljZjKtUkD6o0Nox?=
 =?us-ascii?Q?1D89gcb8GI2J0fimqoBG3xdiJ3SaS+ecE3u2RZfvjCL0MkSHEYdp1nRQy82T?=
 =?us-ascii?Q?g2nKMJTGrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1134e775-cfce-4b9d-8016-08de851f1b14
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:49:37.9144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULeXbmR+1PwzVUS3QJb7JdD2JdTtkSDGmZnAl8z/HsjulY8NutBoj7PlbuiuiQdAViA8nlNC7dwaMvJHCwZqxw==
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

Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
The 'auto' value is not implemented, as this commit is meant to set the
property to the correct type and avoid breaking JSON/QMP when the auto
mode is introduced. A future patch will implement resolution of 'auto'
value to match the host SMMUv3 SSIDSIZE value.

Fixes: b8c6f8a69d27 ("hw/arm/smmuv3-accel: Make SubstreamID support configurable")
Tested-by: Eric Auger <eric.auger@redhat.com>
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


