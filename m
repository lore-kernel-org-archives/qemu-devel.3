Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A7D10F9315
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jzE-0007xM-7g; Tue, 31 Mar 2026 21:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz1-0007lD-Jk; Tue, 31 Mar 2026 21:03:01 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz0-0007bB-5r; Tue, 31 Mar 2026 21:02:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVKZV6TgKIqWaxVg7AWxwG+peLsYtD69HF1vnXhbKFG+5ad1rak2XxY9Fy1LDyS25akQvGgHW26KuQW0pRhf+/ex2ZEB3CtbDmn49w99PsY8bef4S87MS0l2jI0p8vkcYnKTtMmjkaaLD5+N9g1cP1kkWSuAJUHcvMl4YomMKBtKHvwoFW2LDxvRSgBVhQzO1Nl9w2smNKAz07kDJIC+ddzeqxI0/7M4AWJ0kk1hUjWqAh+GQwkJ4aDsMf7+Vvh/YaiBnNUzhmEsE70NvIXATFbYKyUH3Y1AiqJ0QJnGdbzRQFANFbRLLfzTJ0TWw6XjI8/lPtgF8i2WgHE1kkaYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aySk0OJTchi+yg9EwJ87Trx5A1gAhiHymmBSpQO1j8=;
 b=P5pQYkM5prMQ7HLXuyYwxFtC3DpZIOsg7KmGjXFS4PdP79xsZaHGHAHvAXgpgT9+8zCRvQhTfD0Bk13b+3ef8dS/DbyHhnBvLPdwHfWfzUlI/SNDIFqyYbZpoJKpHnZhbiWxVZGL6hKV8p0DF4b8tvWGr7oCb9jJYx5+/GXgvEUsKEG9esaU8g/QuQYKFzGn8QbPAMAVKCRh0xMoxheUwS9Tfpb7KlH7f+dN8OrupXDBLwVYman7+jKy5ZlIflkI+97pD+1I7MwVKJSLPUEtkiJ34Anfk1cGD2Tny+ymaF2aM5yhZP16PXlFjS941vIMaMG1ZlLsvf8XRodl986vow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aySk0OJTchi+yg9EwJ87Trx5A1gAhiHymmBSpQO1j8=;
 b=TK3mivj3LLs2ce0DucuyX+hDJyClfZRI22ca/OPzTdkF4wWszCEMuIni5eBwhoMNSKwuEU9qG+yijgoTwKAa4QtAhVsbee8scy8PFz/8G1wvozhr53LGctp8nFmI8zBwpJ/SFaeAsl8qyWmWz6ZtIBHCCkFjE8kQXzLRpvrRDtz9o7fQhv269MWNwLabtKhbc44FDlczdQvOdi/WxnUyGhJz7KBEujct37LtX06zxSKjnn0aWbV2odFfONmfzwnz48AgVMu/CF96JDMFRGuGfOvAnucdQ4Z0nqytVMKwP2eUNVufYUP1JehVxr2oIMDbD9mvli3TQzNbFkf69kDErQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 01:02:44 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:44 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH 05/11] hw/arm/smmuv3-accel: Implement "auto" value for "ril"
Date: Tue, 31 Mar 2026 18:02:25 -0700
Message-ID: <20260401010231.4166776-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: fa383eba-d1ab-429f-a337-08de8f8a61a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: dsaI0HjAuVEmqDRmDoi5PcI0SPy9ZkJ/uDJgbLwA81i6s5MuTQ0JISAGp0uewHcq02It7v0zHlq/Rwfd4HR3WANgJyJRwEaBvfYcPGfvt/7pQFTZ7onK6GKwyrlSjw0aL3pqbHXi4X3RP2f/ArsYY9pYQ4PIsTCQV5s9tJ+XfjINp9WtWgW4RbdzdBMY2Hx8FZM4/8lXL9Q1F0WsbnD/cPZg7MH2lZMt4g5r3icTIuxWdcMH4cY52UNo9Y7aLswgVgOrA551XxZpbNNJEAwe8NNUFpCpsZqfkqGEoSU3USBZp6dn/CSR3/LGqHIy34izJfVpigDbmJI5x2x2jawVLePaLRDyhXkwtlTFmsSmB/mifbc935yhtbzs+yG/brkI+nHJCN99Gh2WuSWtFLiwSN8jrZwZY20WIJrWX1AO0N9Je9nt1AMqb1UUTSIt2Jul6ozOziGVk/z39zh2dzUsSBlSALz0Tbc0cVyxnWxwjlvJzZDp/eLW6WyTvMSIez9Fr49r4uxwZinKkk4NGsif+Y5tIKlH9l/2+v8LlYKZwHR8cAXdOOGoxPaJY5Dp2pgsyMy3SgJFg+9uTAke6gVaZ/pgcEm8NQvOUxHDL+6XCmZ/tjz1athMlptTlA2ppL+mJh50UcaPvbjiRB7ClQjfCzXUWC7yj+kREH89Mx3bzXLWVx9mlqAaFlU14WLSsF4boZ5S0/zXANNbvNjNaiNu3FJcox34y3mjxEtNBXbbSXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eucIKHkaJVMGFklsf1uVoVoockCepIDvEya/M9yGDX6KHyy5efAP5UKNCW1L?=
 =?us-ascii?Q?fjbPVL0EjK8DMhsej1vsoJ9pQFSb2bt83lpWbDz1JjNmfwzukao6y1NMIs41?=
 =?us-ascii?Q?Oq9XGl+K8Ld7uIyx3GjHaGooAcFonhsN9xEC/KpV9hOgWk+2lDOC+dkn9/+5?=
 =?us-ascii?Q?5pPKaOFNKMR7Tx2KnO9hPMXZr+deefTtLPIZJFDTVOFGba20GWR9Q1tsAMFO?=
 =?us-ascii?Q?F9860c3twz/SMt0O0+t9zWH8aKRLq0dmlZbSphzlno8qZtR+4rt49DZaNhpZ?=
 =?us-ascii?Q?tvHmmKfraueM9WkmMBK0lWCpHaxOU3JPxJws+gv7nRKWo4/Sc6HU47wly2VB?=
 =?us-ascii?Q?uwK/oZASpV4KMIrGvgxxqv314izsZcq20JzECU2MqyN7ZRz25923QYSZQEf7?=
 =?us-ascii?Q?H+MNHN8/8C1ZRk+UTOgTCP7KWTtkwa2DUIwXKXG8VkqACiSR+CrkYTQZVMMR?=
 =?us-ascii?Q?kFY9nV2i4YR4fKXPAmoF0392yjrla3F0RjToiziaHKZWknXcf3zfHOExt0pJ?=
 =?us-ascii?Q?LTpGzEdh9MTHtoT6JhiAmZibrnbypvHpJbg5QUGZ40tl4z68EbSEE5QRnScf?=
 =?us-ascii?Q?DgnlJHIxAjI6f8zLkhjMlAjdd0x3ccqepgT80MEYAIJmIVKm0C67gW3aYcEt?=
 =?us-ascii?Q?v46Sgfq+u+lSBje1q3EF395VBOf/NmEVBPFz75fsNSZKPnOysfY11aEdVHnd?=
 =?us-ascii?Q?lwufRV1pB+Mt1rAltqMS8HWKO0koMx5NokmeT/LylYduH39G9/XVApZPUhCw?=
 =?us-ascii?Q?vIAOB+2BfLW3DGNvrhcbMu23R/o2kJmdmpfLFTv23t+v/mjkrffXPIDEqd5N?=
 =?us-ascii?Q?VBdbDwppZg2Ac2SYezvsXkUA+5Z5iKcwAs1JB2WEc/sdWAl2q7RJEbKQY6Lf?=
 =?us-ascii?Q?ef7ePWYRgNyDunnLijlpzIzgGtQYNDua6ePn4ObuPAltyBNse440MgdAwm7U?=
 =?us-ascii?Q?hwmzxk4cJDiEqdexu52Rrfdb+yewI7LTDutw/B/nvKc2l1y1ZsxCldx1ymMJ?=
 =?us-ascii?Q?04eyEsHP93lttbrwq0803BjAx1Vg1rBsVAE/KSfFp1YX9gv+QIgDDHQZobVE?=
 =?us-ascii?Q?TdTypzPhMrRF8WmlG1SDKyMSesT7xe62xLAclizyfnXolPLf9G+7ENgjMt4w?=
 =?us-ascii?Q?aN6Auj9Ki9TJ5pZ28i7gvFTCg3xPhUdsKWQ8EPt+GmHzwscGPFGqb9VtytMp?=
 =?us-ascii?Q?rpi6FLFQYMhJfB5w2OEVeeZxeq6W6E5cCuVih2k/CtHSUYCjiNgLL91zCPqJ?=
 =?us-ascii?Q?rT/gxoUBfZBX68CnONmMInyeW+Xf8NaWeFoty8MnqTw7F0d+JlrKoRIe2aSx?=
 =?us-ascii?Q?oMyXpepgSh7JKcTDhAkglHvFz0E35hdY4TMXAbTpSVw6m/v5t5x8tcvepBUt?=
 =?us-ascii?Q?+/ASCvFuofQlyKjkUh8RG7j6yrfXeK6ZhUemNsQqAe+QJfLQR6XMnKEHJ7Yq?=
 =?us-ascii?Q?xoSbCMpKhgh1NAW4sMPtlNdmkeirNKECyu7AAfnJLkbgKXZ5hRehUpcISo2G?=
 =?us-ascii?Q?97UMbpio0uuuxWkGR0TN62jiPrzKc3PfsDOWr8c9ARmJby2hQPl76OrV3CSH?=
 =?us-ascii?Q?WXLar57GsYEbKYZjz4KN0ckqT3x8IqPYxKs8bKnXVn6PLVMZ4e+XCDhdfh5+?=
 =?us-ascii?Q?JN1CKUk3Rrbb62IjtS2gYxrepkhDOVKi2P44H6Sqbfb0fjV0WIP7mv3Sjd5N?=
 =?us-ascii?Q?cb6gn5RNqZnsI6+qttMBhF8Mg0z2md/ukFfag74mEKKlVz7BHpBvHkoth7+k?=
 =?us-ascii?Q?7WDNIjh9hA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa383eba-d1ab-429f-a337-08de8f8a61a5
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:44.1084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4aKnrRRb4q141w5npAkKHkYzIuvVHcy6xlGgM18RYzC1fRLdjbbpd8bnwX47y0zjCKrLnl03XyADYsej5OqIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nathanc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Allow accelerated SMMUv3 Range Invalidation support property to be
derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 9 ++++++++-
 hw/arm/smmuv3.c       | 7 +------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a835c8f220..9e7ec6a930 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -50,6 +50,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[0], IDR0, ATS));
     }
 
+    /* Update RIL if auto from info */
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
+                               FIELD_EX32(info->idr[3], IDR3, RIL));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -945,7 +951,8 @@ void smmuv3_accel_init(SMMUv3State *s)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
-    if (s->ats == ON_OFF_AUTO_AUTO) {
+    if (s->ats == ON_OFF_AUTO_AUTO ||
+        s->ril == ON_OFF_AUTO_AUTO) {
         s->s_accel->auto_mode = true;
     }
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f353865187..a2d2f0e3bc 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1973,10 +1973,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
-    if (s->ril == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ril auto mode is not supported");
-        return false;
-    }
     if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
         error_setg(errp, "ssidsize auto mode is not supported");
         return false;
@@ -2188,8 +2184,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
         "configured in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
-        "Disable range invalidation support (for accel=on). ril=auto "
-        "is not supported.");
+        "Disable range invalidation support (for accel=on).");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
         "platform has ATS support before enabling this.");
-- 
2.43.0


