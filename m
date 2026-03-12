Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA17106ACEA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nCc-0000yd-38; Thu, 12 Mar 2026 17:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCY-0000xz-VJ; Thu, 12 Mar 2026 17:04:14 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCX-0002qm-CJ; Thu, 12 Mar 2026 17:04:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQjrlIfBqL8zeC60Y+uczx+IJduVBBD0tzS7jqSfQlcPq8OsQA4zCUcN9rd27nwEbwmJbMlpqfJR/S8dDMyypLjXFAhXghpCu58v+YkrmIXWiEa1hd1FHmSYBz/1BT7DOEKpGSqrD+xNSIrUhcjHAjP6ztdMvJanXpUV62hjgrgzJaRaZRvEHvCyCoSHG5cvg7uhTJHd4K7f3JafnLzczIlWAK7oi3iLBVQQB/k4rs6sU5fUslcrpmDg53HLICqQwn/fCC6CAtbk1O7PTBrcYvY8qun/fYkN2oNXm4ommjdx77CXgySybMzgByffj6w8w4gVCzS9Q5rAu/K70VlzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCQTrtWW7TJv1xRsO7tkyuV13MpnqcCRAJ3wcftcX5g=;
 b=j08TUYU5pFISkkSxr1ghqcv9F0oaOS6GdwtUUzIXIAoT7l2c7isNY3srmXquJ3o8s114aksUCKPYnzegweK00F91Va2nurUoWzsc6UeYYeX0p56cR7Klej0WG1YxgJfbtVa1Cs+txVP5m2RepAhzuc1fJaTKoXZzXz8n43KHQfiPBqgl4q/5ZLvkO3DvvgSHxTgJPH1tA8kFI+BkYlqqxI/1czgrn7WCL3/8hXAbxKs8GK8Y0Rcx//FEWEvN2kX5VmNH7s2eAnZ4WOIrzia9nKckQN/oWnqrILFgQYuT1QsjL6a3c82KcFtxt2gE9/Ag+HAfiaFx+NNerJLY5+/DHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCQTrtWW7TJv1xRsO7tkyuV13MpnqcCRAJ3wcftcX5g=;
 b=UYjjcNHlaubZRyTZ8eY/tUc5LkuCjh6LyveF6D0tltC81P/TDGD/GbuWANWjl7/nBkbdcAcYoFSL3oY87x/GIgPUjMbTmVOwDNIztRAgRoyhStQVi+qH0CiHgyteBYh6MjYkMIxzOz9hr29wNmZ0tvb/z6vcrGj3YvWAznVI3PeFaDAJD38Oj4IsRGrwVJeO5QsY6hiiOe4gWNMi9ErHYsk/1MhfywBAPeeGmXKyBWjAdpaaKa/RO+gXbXQ7/jXLzjcIn2QB09HNjDTsqqF3TKFKzaGFpKX3BBNVgQUTKzz4BlrMqEW2IlYWIKoE6OROMPXDtB2ahHzK1HBhFNNBCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 21:04:02 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 21:04:02 +0000
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
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 8/8] qemu-options.hx: Document arm-smmuv3 device's accel
 properties
Date: Thu, 12 Mar 2026 14:03:27 -0700
Message-ID: <20260312210328.2016191-9-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312210328.2016191-1-nathanc@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::44) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: fa879ebf-76b4-48ba-6f0b-08de807ae325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FC1QPNLDDfcj/aK/2dgqC9YERogZbvy8M/JE9ebyOdYcT7NwbsnwR47q5EFLqNidPRF1pT4walYXVD9VnjyicoxpZnoZLJEiW8g3ZqQWzg8aq15P1O5R5lILHuyMbNCDIoD7y/ZncVoE87T9gdlskVOR8C2moz+McrsAYH3AdNuj/2zumG7nHdX5YY+tzWR0KXjIBX73S3wM5emPR8Q8+QSyAhijSSFEJ4wSY7JaAuygdP+aYxUD33AmHVuKyHcgywxhykzFg+0pOs6ogoYeG/7w9uqzEhnxcWLj5o+47WFXUPt5lDPPDaXdWUAP2YTOuySvbvaTyW8pSAjG6yAopOmdkYzE951xChXYWtdi7Bu8wXhhQzwVKOb9guSB+1s4cSpy6+bjERjGdQhpy4EOIVTL+TtGzVkDz99grCih7zNjccj7ORjjDqkzEy9tV3OB4FF9gzo8tu9oKUsuPXlZv6Jl/sKqi+bVAZwP1f+mMyPxOXs9k2uB2aA5IL1foSPvAtBEtJoAArxd6StoHY9jqAwlewn9y5A/9IQACfVFUDDnO5qHG7StJ3wVny0PuRM/4CAXJ5TMa4OSa4Jfmhms/T39HqL4a/niwGb0P7bSfH1uzPdz0lUP5Mfd8/HcStufrtw7xeumKKIdNhT3bphaw1n/e/SFc+FXNYOWYnGSD7owEW13cHRidB5iSwqahc4P9BoG3De30iMJbuc4O7mVtsVs7FH91Ut9UXG+B5HL0Rs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NAvLL5gTq1/Pu7BnReqGpTYmqGCauzXsEo/wMCpC+c4f4LEPn251VhBuXu2F?=
 =?us-ascii?Q?ofF7HTzx5J6JFE0Xmg3lBgccPZrzq5eKc6iVn8Qz/76hi8b20NhiOg438EbM?=
 =?us-ascii?Q?jlcnGjqNsnfshPMze/0Eh9H727N4ePDan0iHMb2L+/w1Q1r6D/7kWxNHY6GX?=
 =?us-ascii?Q?D4RWLmobRe0N7f/BugAVjy3Sv85iI/I3y5e8gfc3BqaKRHWos0EntsjJmhKa?=
 =?us-ascii?Q?oBncWjLmGiL0umiSEYo4pNDK9Kes/R7AWjDZRG/M5EDXjKK7rqSiFAX+OUzo?=
 =?us-ascii?Q?NV0hY5YMrJ+Z/x/tFDpN+5CH8CpJKRSFNleQ9lk+vOtMgGkg2ioQ6lNDokBK?=
 =?us-ascii?Q?+aNPeZrEVgdJkgLHoCtl7xPuFqglADWGu6s+AlZFwZxbzvWgjZxY4s17k3EN?=
 =?us-ascii?Q?5fgpIYlRLDAPp68avZ9o9WBX+bHB1s8TyjQDyQp7w8biGa5Xt0Zslmf5w51f?=
 =?us-ascii?Q?6KVdM8R2m+dkNrIJJNLUdeQWJugcUT0pGRQypcbAJZ3AGMJiJ8ffHIEpD20M?=
 =?us-ascii?Q?91iuJNIre2DBrGIr0x6uoPmP2lUM7/DABy58g99ySME5gsG1/HaaIyVD6LGn?=
 =?us-ascii?Q?/oJ1K6aH1WXC9/oQb3e4H2rYhxy8tK5Yq4Z5H4wdFN99n76QrW5QyKIH5hU8?=
 =?us-ascii?Q?F98V1McYdzt7umI/y3IOjOPrCpL6V7NFWaYzcp8edlBGZFqapoXCseJMpYSt?=
 =?us-ascii?Q?J00X8RzenVedDP57QkmTSnYJwExQVqgAoeGdRzF3UJM4H3GjNcDkJXodBEv0?=
 =?us-ascii?Q?DI2KpZTgaAdNKahicxyV4wz1LBahVgPbPEUECS7JTnDunZ4glnkcFKjNQNd3?=
 =?us-ascii?Q?1VipEwFlKcoUVARabeMP1kn6h23+FXJ6b1ZrnzE3ZXn5vsZPQral8zckMkXl?=
 =?us-ascii?Q?8ptXMP5uKjFPN6HdFMptVtRMI8MWF4PuQASWi+h2xSbTEEC/b9POLsZR592T?=
 =?us-ascii?Q?yZMYn3n6pJITPgkgjcsbIwpxxlQsENNGTNBqGxj1QrRi9K/7C+tWh+b79Ze4?=
 =?us-ascii?Q?31dASwV/U/tYvZihRlt3wFTShjv4AAh12nyoPjuEXXBaajCziRRZYdz/HwjK?=
 =?us-ascii?Q?9+vgWtD8wZyYF8YCGtDx8O+TKeX8uaWtDkXHSw+Bt3myxno7cXndGKDu+6LJ?=
 =?us-ascii?Q?6lfSLsqwIMqDw1Vyng65wHSB4G7x0P0o6TdRi8K0dSS2xPzqrXYZzg16+e1t?=
 =?us-ascii?Q?Ym1QJ6dTxROatuf5sFClYo8JDsDIhlj02d7dn66euZm3wkVEIpIsSHt1gZR6?=
 =?us-ascii?Q?04fbPDoPcd23uaqajmttdXvcbLe1ZD0R8eVXtISBKMQ7WG7j3b+1ukjAKsxA?=
 =?us-ascii?Q?eqaoWn/Kcp7LaX9vgwJj8EhCKn7u0Husoy/i5LZWKjN8zT+2KY0Bo5VFKKVO?=
 =?us-ascii?Q?PgtpPfSifVHCFyo+DcXC5VtA71ho6kBeRYglftBIIyGRK5YLMMLRmFTf6AGj?=
 =?us-ascii?Q?LJ0mZoedokGWR57GHes6/U1UMYE4yxmzIQgfdxVZFXECyin3KM98OQZI3VcF?=
 =?us-ascii?Q?3iqXMs1LeO0efoo4ZASlRYe168WVDwLvrzL3M6XX44+h7bdBqx52mcsWhraV?=
 =?us-ascii?Q?tJyz2LVb6KhHwz3eHdtV7n8UTzPjCP4E8LLXSiclGw27y6+acNnxKY04Wb27?=
 =?us-ascii?Q?wFHC3oAzZ24dAecnQB2mK7G9CN5OFB/+9JrlHSbKED8O8exnYRb2YGc1JGsm?=
 =?us-ascii?Q?3XRk4ModVrEK6LS9u7ttX92y+LojfKlh4hoI348ifSMKejHBR8mTDZ/nRLiI?=
 =?us-ascii?Q?qMF/rVUxbA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa879ebf-76b4-48ba-6f0b-08de807ae325
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:04:01.9433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUzYqu5ztuzgub7cTuU6Wx+5kGnxgoln6koVOK5cJj8svWD2xBR5BDP0fVIh6kirIP9DBwiK0M4zwoTC6glduQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156
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

Document arm-smmuv3 properties for setting HW-acceleration,
Range Invalidation, and Address Translation Services support, as
well as setting Output Address size and Substream ID size.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 qemu-options.hx | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 890c4f1d23..836de4532c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1274,13 +1274,40 @@ SRST
     ``aw-bits=val`` (val between 32 and 64, default depends on machine)
         This decides the address width of the IOVA address space.
 
-``-device arm-smmuv3,primary-bus=id``
+``-device arm-smmuv3,primary-bus=id[,option=...]``
     This is only supported by ``-machine virt`` (ARM).
 
     ``primary-bus=id``
         Accepts either the default root complex (pcie.0) or a
         pxb-pcie based root complex.
 
+    ``accel=on|off`` (default: off)
+        Enables guest to try to leverage host SMMUv3 features for acceleration.
+        By default, enabling accel configures the host SMMUv3 in nested mode to
+        support vfio-pci pass-through.
+
+    ``ril=on|off`` (default: on)
+        Support for Range Invalidation, which allows the SMMUv3 driver to
+        invalidate TLB entries for a range of IOVAs at once instead of issuing
+        separate commands to invalidate each page. Must match with host SMMUv3
+        Range Invalidation support.
+
+    ``ats=on|off`` (default: off)
+        Support for Address Translation Services, which enables PCIe devices to
+        cache address translations in their local TLB and reduce latency. Host
+        SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
+
+    ``oas=val`` (supported values are 44 and 48. default: 44)
+        Sets the Output Address Size in bits. The value set here must be less
+        than or equal to the host SMMUv3's supported OAS, so that the
+        intermediate physical addresses (IPA) consumed by host SMMU for stage-2
+        translation do not exceed the host's max supported IPA size.
+
+    ``ssidsize=val`` (val between 0 and 20. default: 0)
+        Sets the Substream ID size in bits. When set to a non-zero value,
+        PASID capability is advertised to the vIOMMU and accelerated use cases
+        such as Shared Virtual Addressing (SVA) are supported.
+
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
     Only available with ``-machine q35``, it supports the following options:
-- 
2.43.0


