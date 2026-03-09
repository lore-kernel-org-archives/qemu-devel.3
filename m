Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD12FCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgCN-0005l4-8X; Mon, 09 Mar 2026 15:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBl-000552-BX; Mon, 09 Mar 2026 15:22:51 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBd-0003e9-Di; Mon, 09 Mar 2026 15:22:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWlFjHq4aow73I6O8sEHOvXbHS2YDXh9xnQ/NyEJTbaXXGylY0xlXcuKQZjnP8zqK8+A4tlN5zsgVuIrn7gxzCLVjzMVzCw3LeQC5SmqqOySNon7UTtnbCLcl4AX90TcrqzKEXkKWKQkmNnWollVGwZpTAVn7QydPFFygTYUj5PzjLk4cg0Mua2KWFePqIVHf/9AWWNUgs8/KMhhIQmFMVyMaHgsFWKJlYBTiXZTKZMMQiTVorQRH8HIG/JQuvrMTq3TIXrB/0FY8qi3hMhSKEF6GWTHS3jQWqI0geu4q5PNsd5Y9cUtkj5Q3D3LCgNEbFO4Hb9i2L1rnTQvptbhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64EHcB09TYGWE3zTSfLDBdylKOBgmmIQ1Dxn5VGXb7I=;
 b=NlaUmY4yvvk/KFdB+D68XLf09Bgc5MRzedsB17/rbyDioNsHH8K7H+tju1QZwKF7lejoy2MbGmShlrn15ulFGgJYll26jTLZyPko18E6hS4QCb2RSx1i6BRSxw2YQEeuMK1SoQmcsCBwDEfbruZmpkdI+y1xQ+LsWbXpikPjREEl17Ig3mg5aWddqIzldlRx+o9mA+lDVSkNsTvcCzECT0dt6p++OUwGhsGjIzyu3itRMntxI4KDgAtpeqyjxiCBEhgZ3y8gmNv3V9BRLqa58ob53OHguTpaAi+XOXZCyMkzWHvo7S6WT73q/sfGEa/obhTUek+J0S2dnk8w+YyGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64EHcB09TYGWE3zTSfLDBdylKOBgmmIQ1Dxn5VGXb7I=;
 b=luL8JvwWRwimaJChMQeI/GLnCxImN7jZ1OhADCBf1bKZjF3ctX/gCXCY9THciNG1Mh49NaDhfsJBLP14jyZOTTAqfQs04idwpjlY67d0ARdG2BJpoCOnm1C+OT6RTEir8cvD1bSc3thusNVAmQj0Ro+GQK4a5dYJ659hWvm63pmmLyg3uWlYvD2GvMv0pdT6VAtVJGL2fBlqOik9p5V4A2B7jCV10AoZBta0EJGyFVwFcyZLeBUR0UBhAWUIvpQ7np8GBAOM6yro7EoiL+zF+FzLGdynuCO34DvqCRmmLqam+JmQtkyo/CYmYnZhecpBxsxDRkc5JvgFNXDvA4jsmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 19:22:30 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 19:22:30 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [RFC PATCH 6/8] hw/arm/smmuv3-accel: Introduce _AUTO support for SSID
 size
Date: Mon,  9 Mar 2026 12:21:17 -0700
Message-ID: <20260309192119.870186-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309192119.870186-1-nathanc@nvidia.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b215735-abdf-4a29-42e4-08de7e1134c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 81S8EUX8E3uVOgKGNfCWOpdXa6fEBuUch57ExkvxB6e5MFBhRZjWCeG7uK/gGzmsZxW+aWNIQfVT8QwHHBkmDq9I1Ay4w723/23ZFSNP3L/KMrTQ3g4OefQJ4rru8k8G+tVhapq2dCCsQkKnkm/F+Djr9IQRerD8aVV63dlV+KiSA9XFIH94yZMmd6xmhaIYBXB+T0ZFthgFLYU14VOI3JhuJJ66iAcCc+n6seSfMkqmlPQxhHhzThPmEJhlKWZVToU4aQgER4/kBHHYYKUNhaaFnRNE8sEIgP3vwWOogsV4uY/c3RwdfaAltwTr7mwQizshaXIHiJpu2oUEavtamxeznDVUW4/d8N+fOnQLEPl69IhsHN935vg9TMz3qF0SYznpAsoGAbsqPKIp0/+z7afPzfIABJs17E1pn62TuDIOjDvCD+5rnEvj4Bkm6guomvjbopp8cfwImo0qnD/s6cYm8JidOaWLDCkHNgsN+mwEJKGgDnv7wIIYKrVDrTXJ4N1YASlAhGnJH5tPsV8bo0aOJ3X7b7i8RvWbMEO7Tyn8a4Eq3zLqSPr6iktBp8SDvp35N6wOg6dG3zCva/S3AITqmZux0MFDFGhTtpmKoSRApPrMo02eAKntMEdSnAVDcjZ0uYUVGY0lHr1TGrw8N79Xy3ljIRo3a6vLF4Cjdw9oSpWHZrmjJgmFjCK5kzabZ4q5khKOYQytTKUIDnbHeBafw2LZi2e80FpxK739UmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+3enpVfNw//4ppy1aejpn2Z43VCYqv4af549I8Dr1Xr2u3YXlSnW4Wy5wBEg?=
 =?us-ascii?Q?80BAylqHsROT/AhXz+Unju4UgheKHUcRW1Rz+lLEPQI/vr1LJvVWOS1CvTHT?=
 =?us-ascii?Q?fukqEPsWd+dAlomDFep34lSnEKjpJuMY6MpaqqJN0gY59mkqBU/fpeW3HTxk?=
 =?us-ascii?Q?bLk8eSadJb7ej2rW9lp3KccGoS5sw32xM83ODgQpbtQioF7VsHMUVnascahn?=
 =?us-ascii?Q?V6Dm81Gs5grhdbj8T9PUyQG+FztHxfoUDhxIp9JQY9N1/ZKFSw84YfaoGFlV?=
 =?us-ascii?Q?cjoH5Aw8+TnLxqYhps5sUKKob1PPIBMkJ6QGq7B9jjJXHM6eI6JzMOn98Zui?=
 =?us-ascii?Q?d0YJHdIonTunHZ5CFlUJG733d6oll2ErIzNbhoIYeBib4L8HJ/nsedUnQF78?=
 =?us-ascii?Q?1E7uGXfDn+I28pL6KWYQRQUoVjdc5mLipdiqbdLhKnhlaqBu21riJJNHBmk1?=
 =?us-ascii?Q?fvuuC0EX6CtBup2QIDDCXgSi29sBepXvZXhguJFPiJEWSqxBMbujDgXbsWJs?=
 =?us-ascii?Q?Mxlv0gtH51C3V8Rn4UnSYmgBzPpjfS3JMgXIDUmlEdy3XCSMPUkHK1b5D3kq?=
 =?us-ascii?Q?3EcYVsyqI5gFzgRq3HLncgddU4qUzt+AsaW4LkdtDN5TmrAiQByQG1SC/00t?=
 =?us-ascii?Q?au7JNNVlhAQXVulVVfNEI2Fm3/0CiQxaIysu5DPBMqHrr8AptFShpmrHz292?=
 =?us-ascii?Q?nO+gumiFGSk1uHP6le1R/HDxBFPIhg7eu2VC2tJUwV7ow/6fVE+79q19EtFI?=
 =?us-ascii?Q?Gj0QrkJVqCUPp3GFUDZ2oop7H4C+dShOQ/6xjgLjdhcAZB6m3Fsl/EaNjWb5?=
 =?us-ascii?Q?I29QAAO1Ri2/m1A/Iu6pPxBhl/Vz2eOQ6BLRCY55ow/Dvv/nOqeELWCtXoPO?=
 =?us-ascii?Q?2hxLWT9SrN26fiyHJWi3aCW/5b2PhLRjzrXyOR1rQz4Lo6L/TMbqcGfo02on?=
 =?us-ascii?Q?0EMkBeS97ciwsXZO98aVemRvJWx6ezf7+zxXvnZGvSV0/C9iFwnVzASagg+w?=
 =?us-ascii?Q?XrzchWYtAQi5CmpRhRYYcUvg41unT7YMc+ZNRcCXVEnFxz13MCnWX7i9rSPe?=
 =?us-ascii?Q?hEO/v0pV/Lwe1pbO/5zfm0AIS7JzhMi3TivPc/Q7nM0qsq8WDwBm5BJggotX?=
 =?us-ascii?Q?ggrAUmsytNdIV7/ZRR8H6vCkKzEzBZbxgOXQBZ2e50YLoRcMWynRhYVPlS8f?=
 =?us-ascii?Q?pfuIGxRtvzs3jzW9Z0RNhDJxnprPhndJzH1wBAVS5/0Scg5IeCLML+gY/yRZ?=
 =?us-ascii?Q?XnEzHpEvstv/IbgPxkU7cou+wsyxJl63WqNPuH9+jKPlLI2sffKRwWKCNQpq?=
 =?us-ascii?Q?S7NKjloz2C5oDEfu8St8rRkagu4s8qqeEvHFBKuM5GXB24RFEgc+iS9tvVCf?=
 =?us-ascii?Q?+jWJRNeg1IeIN46r3FQwTdCgWSn7KiSaiE82cnP9yraeoFQ+0WDU3jsBhZtG?=
 =?us-ascii?Q?Va8Zrj7/nhG6Mi233/saw00RGkpUkr9vGPnt0/hDjVoSIxBp2iBlGoztenfv?=
 =?us-ascii?Q?okxgLGIYZlJjofBTAZ1WpZwljuSYWEkQSLltAAyITnT2seSEjG5r52I8WgR6?=
 =?us-ascii?Q?nPCw2YinhajIdeaHX2RZ+R3OuDtf594sdzB8rf1OdfhmS49baHcqrlhZ89uj?=
 =?us-ascii?Q?0cG9qDFZ2O6FYC4/38M+f8Roh0FIUFOn2UUtoknCtc680Q/ywRA6dyY9Q13x?=
 =?us-ascii?Q?Bb5wgyyU91VWjxsYzAumWN0ZXbbh5rqHUOTdXgV52eN4CLbqZcnlTjLOs2QH?=
 =?us-ascii?Q?A5skkpEKKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b215735-abdf-4a29-42e4-08de7e1134c1
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:22:29.9513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4jDHKszS58rVl3rcrC9Sx0CHE9f8x83KXZ2jMq2gJkUdDP2aVK1pf4wmgAFsgNI9xagvizr9PCqDS75RxQNxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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

Allow accelerated SMMUv3 SSID size property to be derived from host
IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
retrieving SSID size from IDR1.

Set the default ssidsize value to auto. The default SSID size used
to be 0, but we change it to match what the host IOMMU properties
report so that users do not have to introspect host IDR1 for the
Substream ID support. When the auto SSID size is resolved to a
non-zero value, PASID capability is advertised to the vIOMMU and
accelerated use cases such as Shared Virtual Addressing (SVA) are
supported.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 30 +++++++++++++++++++++++++++---
 hw/arm/smmuv3.c         | 16 ++++++----------
 include/hw/arm/smmuv3.h |  3 ++-
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 02e3f7a9f3..bd27b0da7c 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -64,6 +64,13 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
                                FIELD_EX32(info->idr[3], IDR3, RIL));
     }
 
+    /* Update SSIDSIZE if auto from info */
+    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        /* Store for get_viommu_flags() to determine PASID support */
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -839,7 +846,10 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
-    if (s->ssidsize) {
+    if ((s->ssidsize != SSID_SIZE_MODE_0 &&
+         s->ssidsize != SSID_SIZE_MODE_AUTO) ||
+        (s->ssidsize == SSID_SIZE_MODE_AUTO &&
+         FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
     return flags;
@@ -854,6 +864,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
+static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
+{
+    /* SSID_SIZE_MODE_0 = 1, SSID_SIZE_MODE_1 = 2, etc. */
+    /* SSID_SIZE_MODE_AUTO = 0 */
+    if (mode == SSID_SIZE_MODE_AUTO) {
+        return 0;
+    }
+    return mode - 1;  /* Enum values are offset by 1 from actual values */
+}
+
 void smmuv3_accel_idr_override(SMMUv3State *s)
 {
     if (!s->accel) {
@@ -886,7 +906,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
      * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
      * has enabled it.
      */
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
+    if (s->ssidsize != SSID_SIZE_MODE_AUTO) {
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               ssidsize_mode_to_value(s->ssidsize));
+    }
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
@@ -955,7 +978,8 @@ void smmuv3_accel_init(SMMUv3State *s)
     smmuv3_accel_as_init(s);
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
-        s->ril == ON_OFF_AUTO_AUTO) {
+        s->ril == ON_OFF_AUTO_AUTO ||
+        s->ssidsize == SSID_SIZE_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7791e5294d..bc03353759 100644
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
@@ -626,7 +627,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     }
 
     /* Multiple context descriptors require SubstreamID support */
-    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
+    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
                 "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
                 "Configure ssidsize > 0 (requires accel=on)\n");
@@ -1985,7 +1986,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
-        if (s->ssidsize) {
+        if (s->ssidsize > SSID_SIZE_MODE_0) {
             error_setg(errp, "ssidsize can only be set if accel=on");
             return false;
         }
@@ -2003,11 +2004,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
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
@@ -2136,7 +2132,8 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
-    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
+    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
+                              SSID_SIZE_MODE_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2176,8 +2173,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Number of bits used to represent SubstreamIDs (SSIDs). "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "Valid range is 0-20, where 0 disables SubstreamID support. "
-        "Defaults to 0. A value greater than 0 is required to enable "
-        "PASID support.");
+        "A value greater than 0 is required to enable PASID support.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 9124bfe751..ae8158a5c3 100644
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


