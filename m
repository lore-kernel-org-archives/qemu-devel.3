Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F6EFA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFeQs-0000Uz-Pt; Wed, 22 Apr 2026 16:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQk-0000SQ-Fs; Wed, 22 Apr 2026 16:44:18 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQi-0006xi-Aj; Wed, 22 Apr 2026 16:44:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwbuIW3Es7/fzHgHrgAjQ+jTC2mJBkIqh4ZWdNHqabOsESXE1qjsAOGBfKuHmWGd6/KyghF7W+8XcFf2J7wHzcm8YE+Q3r0x7QKaug+KIgc6Jr0PrToBub2BPIpYDL1PNR/+JnQtz41V4BRu0HEVPi4eyA9z+vNEVWpBfDUsmcB2ai9qeD9kyOFvSzcKKLAjlv0Pdfikt56alAGz3X4qO2jVmc4HvlwxW6H9mllJXBSc2ut4X7YOXQmCZrFqMlcA0LRO+ACgQ/c8ETdUOM9TqUsaRcrJSZm2NnBxvZvQWL6vsUUyzOVQX1rt/E+/V7dON69q1cWv6Tdw7h9Xi2ItzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6II0V/ud9FsVOLFHcitMDxxX7hBgvG10QumQ4ju5kBc=;
 b=rNesCzP5OzeLVCVAPgP3s2PNynOpWRw4dTCxmpeYPSd1ue9dQ8SZcw0ALJeSHQR+WeW1k1Do96/1jM+aozyikyw1vo/njxwMiLgNtX+NPFyg/kSuwOPF2ua5anDk37sCdFGRXUXcetKpZS8+TTaYxoaDHEeD/U/TA3AZcrgdUlJxS3gUzT+WPargSPrU6iX28GIvb7jso7+lTw2t7vSDYHfx1sDyng8WyOToninQI8aPN1K0EQGYTXQRfbAyoCmhZhg3kZoq8zmGqKtsThWaYYhiY9sIKcoIYKFzVSA5unS0FB4BqpJtlCv/9Vrf8YcO1Q44IUH04muoiUpZmeE5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6II0V/ud9FsVOLFHcitMDxxX7hBgvG10QumQ4ju5kBc=;
 b=TghO4neKpkl5b8OMdF43j756BYLbtpQteqdmBYKqhFf3cFDCwwap7nfvL/iCQ+OOJuU1kkkDI8tnbaeoAPEkAapRbqvrTOTbzbDbzhazvRlp3iRDYCpFERhRWtDtfu6t0Ud9bX5l03VAyR8jgJpEcskWUuzqnMaEYF9Ooc8C8tlQb4NaZVF1KJ52yhw7+7p4EH4bjXhdQzGoU44Ra2H3m8/+YX/PoTx/hz2a56VXz/YpbcIZnyGQ4QXUxqsJkYv0h1HIbfCU+5NuqKTIkTFUWKD+qw/bWuYUVeCHesFj55DpteMymrYgNBk6xjz7HuXrWLtDJE+OgN3rz+rAcVwuhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Wed, 22 Apr
 2026 20:43:50 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 20:43:50 +0000
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
Subject: [PATCH v2 3/7] hw/arm/smmuv3-accel: Implement "auto" value for "ril"
Date: Wed, 22 Apr 2026 13:43:31 -0700
Message-ID: <20260422204335.23116-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422204335.23116-1-nathanc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: d533467b-1c30-42c4-e499-08dea0afdbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: If1qPlOF4ISJYZaHwfDXGnfPz+vVgxrR/e6yMmFoQ7TtMOY017wmToibrKNBIz7wQq0QZJYwaIIl1pYudKh1pcccov1vg5kFonOa6S8POQ7Pnau8g0ipQUL3sc3XJLRh44KuesPgZ+Z41EQ7SOtXGYCXghDG4TvTF0Wmthhj/8hTuLJ/Xfyk1EH4G9V09kEQoW+oW7G9vqX2NvbZ3fPqcwClEd5WjDbs2bqBLs1JscleBVTIxAmPchKFYkTvOEI3EBeCL7M/5e1ZL+4tap4TRR7ge0U7MFNhDDkfwZmc0qJh4qLl5FPW8Z9dLm8KVyIBfUUYGiUzH3QRL+5dajBHhrH/O3I45wKzfgyOrK2ZYXJQYfweCfeFfgS2YaI3scEvHp7JPeqitrxfV2qeN/PrUq11qE1nSgz9PO6sgpZyBKuqFWmTMKEr39T+xgdmRAiWX+IQkivfb9Ot0OoyD9MRql+jUyiR4y1HhXHgvOCz+jS5wK3U9R4SlwmZumMMdTu6wXGZ7T1iZPFU0ECSt6i8jMwLMXO5abT+AXvkf18Y4nAFPmvDu9nGQXDkXB0y62vyekkAInwWQUfaWyQNGIgmh8ejIH+4Dv7jLu6eF1rwgGn02lwEKlIJIx7cC+1jIOoHt1HPGnxKXPJKb3mCoOdzndyW2+O4m2AK3yw7NIYuLdYBugLTHFrXIFh/8Sve8dRvVuElCiWlbZtj7pEZe0EgWFzZTWlfhe8/6x6pBoHKzN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?//k/sNkrNOl9AM7Abbg43EG2rXhHtGte3ZdJcNr9aCvtDgDT/Eik0NAq09wt?=
 =?us-ascii?Q?feZFydxF2WRupWj59+7M/frLbjUitJ/XsESCBp/ZXuRCHz96q+g0bwfSORK/?=
 =?us-ascii?Q?yZwC4q6z52l7iHcVSg1EleZG0n2y5utW01pM6RIyJ/enuK5oPNYXo7pBxzGV?=
 =?us-ascii?Q?4qDX3OJrkY6H1V2ALPh1VMIBTUuJ8iwkWA4W2iET7+NoejsG0c/Mv5LvhWoK?=
 =?us-ascii?Q?tOrZVLcz2HkHiTJ5zbzkhsKHbFTv5hwP0bfHVfBRMmmOiYzJslvztrC6o2Hm?=
 =?us-ascii?Q?Cg22PI191PmJn0vBrQHIR4BRW2wI2d/LIL1ccohSXYEpO9AF3sY/GL8dWOg/?=
 =?us-ascii?Q?fyIYTd5gd7nAMBUU8Rkx6nkih7r9zaQbdGIf9YoMzamNF/ItUacTuRM+pbXH?=
 =?us-ascii?Q?JGLz7X/9TjnwnVTRIkej9uh+IPgV5vAMwVBx+Ah8UNsjOTcV4t2Xgu6ZY6iL?=
 =?us-ascii?Q?5VNMrVjnSXZ84dB2MivDc0e7P9fdpdAmO5Eu0yMWAaUDqJR7+yDwM2YHCFnV?=
 =?us-ascii?Q?1WFxmMLlnM2i1f/iLwYsaXiLgCjT8amI1eIAVP/e0eUsZ1xbS3D3njhBJN2J?=
 =?us-ascii?Q?xihrOhIiMi4rG1KmyRZttT00ZweIqBIFnl3ofzoCPjpC1VjGKFJHlAUJqOfN?=
 =?us-ascii?Q?wanEsKmxFx75s8nqakyxKhD+6Fxk6SSrp7w/hO3FtFLnsarbVoBHnlImvN6m?=
 =?us-ascii?Q?tjXD2O9pQpiwTMwlmsmg+26U6EJF+XTiU2/OhmMohlLWRxcyu8FjLJuREa9W?=
 =?us-ascii?Q?tZszmGkh0r2thKHy/Za7AHbufw8PXOJqcabpzBCB9yBsx7tNTA/fvh2zUHb+?=
 =?us-ascii?Q?ERTbP7Z2bXSYRJ3pbKRBFykEr6U7hrE7I6YowXHkxabm4fdOKD1AviTbpbv6?=
 =?us-ascii?Q?AkSwG9lCyYcmvobgzGn+zaK9N3wffStKmwyzOJ7y2iBnJM0lttg9NYf10kpt?=
 =?us-ascii?Q?21JdgO24IKhI9elQcF6gYuqWboAdyNdeYtws//nLkazBzjLJSDiDDVZ0yFGA?=
 =?us-ascii?Q?d34yk1ATAYSc84RuV9v4uUTtkF6Tkc1UCVHdTuUBe/5leiqFvfrbLuo4bBZp?=
 =?us-ascii?Q?WTAaurvn8upmVXBiTvToBqLsmkqL2YFG1IR7ELAccIz19hEehQU+1D/6wo22?=
 =?us-ascii?Q?vFLYWsg5O/T+hIW4Scf2CRqmzhGtIaF+Nj1OJF88OZTrn67Lpdx80JQbPREF?=
 =?us-ascii?Q?Q0HfRh80g/411ZxP25F4wDguTdI8tVH76bdbcNOwAo2aahRBwR5BFf2eYkEl?=
 =?us-ascii?Q?BtEW4yUBfvc1P+1FsOgojRXpsgN8fd8yLDD3KKZhK+Fe79T0XqTv4wu4DVkT?=
 =?us-ascii?Q?wneDtpE9hUUjNqiOCl/U/4QRyTb6z8L4Bg8ru/q6rPFjLWpzC2iwhiY9lcZn?=
 =?us-ascii?Q?dy15il6R8hxhgMp/z28KayDVk8Iu1SwBGRplBPykGog9G2N47SrbE6iQU5QH?=
 =?us-ascii?Q?mJAm5DpbT1WgKzHVz1qhVUS3k3lE7ZZO21poq/ku6FuIRoiRWhtXeL5gj9Kk?=
 =?us-ascii?Q?gzzj247SDlV5CsGqNRKllbUmhmL0qU1IrF3r3pSTbVYPf7rQSeew8ClcPKCA?=
 =?us-ascii?Q?MJICSTTrQJHjaW+WHOqDeQZgkUk/8A7JqGIIdtepIDMJduvMnVoB9oOfrApe?=
 =?us-ascii?Q?2I3eMdfm4MTlpaKeCqpuSj61LHNKuj1gZhHEMIZ5e8/E9cl276WF8BkVcZ68?=
 =?us-ascii?Q?LVK8hxAX8xOxAzYjZAZl2EmR7AETf0CPsVdKQ7Uke86sXPA1uE5LFao2jzEw?=
 =?us-ascii?Q?mB67rBGpyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d533467b-1c30-42c4-e499-08dea0afdbc4
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 20:43:50.0808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSpshI1VLkE7W+dSVxTPIFVLVzdfQuOw/AzW7yrFNbxkSyGI/2MZ2oklTXBDRUHHps9DHb1wTHBXTlshYJTf4Q==
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

Allow accelerated SMMUv3 Range Invalidation support property to be
derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 10 ++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index b42d189d29..98c2cdcb5e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -57,6 +57,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[0], IDR0, ATS));
     }
 
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
+                               FIELD_EX32(info->idr[3], IDR3, RIL));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -968,7 +973,8 @@ void smmuv3_accel_init(SMMUv3State *s)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
-    if (s->ats == ON_OFF_AUTO_AUTO) {
+    if (s->ats == ON_OFF_AUTO_AUTO ||
+        s->ril == ON_OFF_AUTO_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5671649fee..b7aa4122eb 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1972,10 +1972,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
-    if (s->ril == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ril auto mode is not supported");
-        return false;
-    }
     if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
         error_setg(errp, "ssidsize auto mode is not supported");
         return false;
@@ -2168,8 +2164,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
         "configured in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
-        "Disable range invalidation support (for accel=on). ril=auto "
-        "is not supported.");
+        "Enable/disable range invalidation support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to on. "
+        "Please enable if host platform supports RIL, and disable if "
+        "host platform does not support RIL.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). "
         "Valid values are on, off, and auto. Defaults to off. "
-- 
2.43.0


