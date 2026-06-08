Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77279CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe6c-0006ih-UH; Mon, 08 Jun 2026 13:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6a-0006i8-Su; Mon, 08 Jun 2026 13:49:44 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6Z-0007Bn-EC; Mon, 08 Jun 2026 13:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI4PH41InUn85FOlqddYeUDZ0S5CAaVD5t3GFL2s5b8fqp+xIq4KniJthTg7yqtjS3EjF/hTcwicNk1XYLNuybvf6KdNxec+ouTKR0puKUr7OZpFVdFVmUsjUFeRsOJAkKZRx0p4n4HUzTP2qZXun6A1zXYuLdHbvAn7jc5BMrWstfiRhuHPX3PoHL2MxqXzmeBnokT1CNzCKlVPbeB6OSK0LQsGD/8UAMrVeafTxuzlVtkA7lVGKUHM7773YmjCPx6r70EKHr9BadFqOwPWvN4GQzXjJCNAjqQGX+dlytG2+kTL5YHAGBesdpZxJYzJx/COxJhqKsDsmdjr2rca0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LN9y3UmHhu+Vgf9Z/EiJgog+wqzZ1aLY5vXqKRI93X8=;
 b=IDD+9AdZ7Ja5xDpLvg4JhnvryYrrN6ZXbkBbe62XQmF0aksBgV5zRCfPdIKEgNI5vnx4moZazDlqy09mKdxISxiOnLRPoSNjyK+Bl8ues0H+/jkyah0nqNbmyD61xAkH6rgzvb/aDi6enjP3+382I3pOpUYizJpuSzvmBA7jYWj56zkdtKvYUGFSJtNBnSFnHL0tJbIl9jhKCQlhlomtrloO1199AWOw2T8gxoTpqJuaEk+B8Lt31AnQamJ8167j7Lyu67ScfUKUID+ry5tlU1FFvv0gVJ1P9mF7hf7AKJUOIz4j0E3pPpnHmu4Qa2fxhDNK3OXQvumkEGAzwD00jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN9y3UmHhu+Vgf9Z/EiJgog+wqzZ1aLY5vXqKRI93X8=;
 b=sW5ckBF0wjLLn3y+Oo3JGSvY0zF20MbX77QOnpAPktDjYflh4Gbg/TzQ9sa3e37/e7Pu/QM+etI59QYHjrjYaJzuxC++/4xr7uUJf3+/uCo4/llj3ZAvxp/sBWE9HgvtF0KRwku2KWga+BgskTldPydCdn9uCbpp3NzByRSY14PKcScZbse4isAheUdEPmTO1r7CubmMLVFSD+YFor4dmm1V5jlYhpW/r3KnappGhCzXKUQZ5RG89EYPNkDQLSYU7JYCc4UYNANYBCSZ82DU+lWSTd8CEzeqVVEywa5T8acVNQkOhSOH6IMUNJGtBOUEv0OeE3/qR2DqcW5+zSEb/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 17:49:32 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:49:32 +0000
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
Subject: [PATCH v6 9/9] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Date: Mon,  8 Jun 2026 10:49:00 -0700
Message-ID: <20260608174900.2227340-10-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608174900.2227340-1-nathanc@nvidia.com>
References: <20260608174900.2227340-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7f8275-bbf3-4a21-e52d-08dec5864bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: N542luuYMl+3OB1qlEW472n1cOXJmHoJHc+n9/49wx9BYjWqWcK72V2xnAb6IZbcWD8YpLAgisycRTZKd7eEtV5nsLDERk3Bm2t4DamMYRlHq8hqqVp4TF4zpld7Yi+14eNxaAv5Taweutx3Wxt+nJZ2JP2Y85hrjKBvZ+hZ3iKMMK6R1T0/vbV6lfs/gJqZbuTj3ZXguGYzmNtkxREe5JlXY9sPnGoyImbQ8c7KuKv7PKgdJKy+JXGEatx8Qb0K2cvmGbo+n27raeil1Y8WsxvdnOUI31jSnJHqGPTiodEkm6zGqvJOT3H0XcWRFmXleTel1eYEuxD6KFhh0qRrvpTRcha40joKynJ0vXxs2lupgG6lAwB0H9Q97zoY0r/0U7QCq17hpXhM8n+078uu4Bh4bEfdrPcreBKm5d3Yin0I4LrED2rTepP9BbqGsBLzDPd4p7HIqAZm5NHy+3uzfb3l5QnEJV0L17dsq7Ya2qDBtuwe7bL7bakBR7GkFubWMqSbbjcuwMFFUhc0guWDXtSY9IUfRz3oNK/z2FixbWG8MvRd6UtYowBXkXg3kca8KMKhW5e/TOg002zhDt1eepKumdeS+GZl6vRayZhYanTLvotI5mRFnvOCuKpuZg7BLAoyhrawUvrEwc4mBrLZf0rxZ+vvAMgWn6S+DPRK5t/EjFzGIghRjeCo9rul54c8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdeWnvIP+k9yLVXOw58JpURIjF0RifY1qyFR33guOzGG0yKQxXXZ0WYXA1/z?=
 =?us-ascii?Q?vR/1WuIhu6XyhqqOX3YQExfXKXZkex3IKHUJrUQFsd7qMXNCx5yoQ8HY9FKU?=
 =?us-ascii?Q?iktEed8hnzSQricEs+uxZSTMLN5bF0GI18uCmHS/EOdSNzrZlLE9i/DNGF2J?=
 =?us-ascii?Q?Pgl9il5TFu/713xo/N0WlwXfFus9/sM+BU/j6lPWMmGIvmd6peh5/w+sjeIm?=
 =?us-ascii?Q?T1rLDAT5HbLtuQINp37Tv6TKex4/i/vl8rY4BIGPOCyb7WYNM/922WZAIRiA?=
 =?us-ascii?Q?TBCBSXP4SOprTmK4G3sbEUZx8k0DlyaP1Gk80oZXBf3wcwAHr9HyoB2RghwH?=
 =?us-ascii?Q?zLDYXK6vOBVNxLd+MgiPzN+kqgkZtGmKwQVQsoJZi8TJJQfydAUJuFxj4s3g?=
 =?us-ascii?Q?9+P4klKVa2DMCx04dSypEpspD9lKVpjHpyDNgmnbf2aRw0eKgxtz8RLKUtQb?=
 =?us-ascii?Q?1TmB9Htjf7qtIR3Og5mtPLqzlnLAyhZn8MGQ4hbGmPhKOM6bQoxg08tmWkbd?=
 =?us-ascii?Q?acij0PkTSaw2M+alYteUUzhqKiTMbpstVJo2Yhb1qnn79zbbixUzESPeuQvu?=
 =?us-ascii?Q?z8tq6M0REfQrdnOXbyAhth6Q9hrnHGoL+GvDurwvh7gSE4mwA3N/uhGcFET6?=
 =?us-ascii?Q?nvOEmSqHQH8Ucw4nZFRmgKP9ZLmRau26V7uChqE3hHSOdJvKSGeTlqNKKszr?=
 =?us-ascii?Q?caOlzn+FVKbHXZFlRERztuS86NGFnlxSXp7AdkLKOuN9MyfxPbsXIN0rewrN?=
 =?us-ascii?Q?9C/dO2FJBlIy7OlUG6Py3k/Nnvg9RexVSu/J4cP1vknD1ELRfVVpSPmG2i3Y?=
 =?us-ascii?Q?32lplYuL9bfaSn/skhVHdKQocW7DXNGARRD3bEk4rc/CGRkJeceHYO1Ymsrg?=
 =?us-ascii?Q?vsUQ2VG/Fo+yNEFIXlF6uxaAKwIBbFMXyvyWbuBb7APDLpjUrZj4F1JKLcyE?=
 =?us-ascii?Q?8zWYwn60tthin42RTw+TRmnd0YMmtbtdIOfBQ9sji+W4dIX/ZMnAKoiuL34K?=
 =?us-ascii?Q?tWYG/vm/qhYkTskeK+isp7fzwhl3xpNYrpwjVek/k0yrP+gu7eWTqci4A/eC?=
 =?us-ascii?Q?YFk0c62K1YlBCajp1C2XutcUass9zv5SvMcCOH+R3H+skBKVPIJAHp5Azdm4?=
 =?us-ascii?Q?475BhQ0YAvUAC3HE5hhwnDYb7IEeQyvV9nlp3v9l2blhvinSTzb53uXV4fb5?=
 =?us-ascii?Q?63BNseMw01hya8EJYZKd3s8JOJMiXhulRixsHYmCAGjVX0SqT7rJZK1YmK7l?=
 =?us-ascii?Q?P5+dmKUavkBmON0kVNOxtuvyCEIVQorpzFDnzk2jNZEGIafEXzwGrc0wWCmd?=
 =?us-ascii?Q?myJC8wL36Qfe+WEicz/UUpkT+EiSeMIqWLCdcWDxdkkPdRTMNt1/1r9WnsIG?=
 =?us-ascii?Q?dmTj25dcFWMYrV78KVC70E4mJX3UKATw7CH9o38BAFu800jl0IrmppSuaK+a?=
 =?us-ascii?Q?tYmDm2AZGkBGJ47uERGHSD9FyslA0aNjr54rYn+aexgVR5ftvAkKcJF4Punt?=
 =?us-ascii?Q?BtVEItGVYN8d7zNhGPoYvqolAr/p0AnOu4+knFXNeyPNoJh4iMnwUONPQk2T?=
 =?us-ascii?Q?mJN5SEpk4CNG7Wzr9v4xvRkD/JNSw9DBSjCRNhSI5ciWCVQzWBx4WCKDAdKL?=
 =?us-ascii?Q?b+07Hf74j++Fk/nl/o85dYSCLnl/EF7eUnPGVGHJrn3yND7l4Ch+QqrpRVNH?=
 =?us-ascii?Q?0dZZvGY/G5u9uK9DY4Akn2YX/4l5KW9lf4+UJtGxBmEB4mke+Raj0JgWO7Ly?=
 =?us-ascii?Q?6CQp0/cPCg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7f8275-bbf3-4a21-e52d-08dec5864bf8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:49:32.4967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuYMcz6PqriRiMQi2aIYto9EXLAkEV3TmWmXdn8ztsHC2ju9oVzmESzbEUWiOqQRrRFDmm375rhkLeTb3ClOFg==
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

Update documentation now that "auto" is supported for accelerated SMMUv3
properties.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 qemu-options.hx | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..d7e48688b5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1291,31 +1291,44 @@ SRST
         Enabling accel configures the host SMMUv3 in nested mode to support
         vfio-pci passthrough.
 
-     The following options are available when accel=on.
-     Note: 'auto' mode is not currently supported.
+    The following options will be set to auto by default if not manually
+    set. When accel=on and these properties are set to auto, the value is
+    derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
+    accel=on, this requires at least one cold-plugged vfio-pci device; if
+    none is present at machine init, QEMU will abort.
 
-    ``ril=on|off`` (default: on)
+    If accel=off, auto values resolve to the non-accel defaults given below.
+
+    ``ril=on|off|auto`` (default: auto)
         Support for Range Invalidation, which allows the SMMUv3 driver to
         invalidate TLB entries for a range of IOVAs at once instead of issuing
         separate commands to invalidate each page. Must match with host SMMUv3
         Range Invalidation support.
 
-    ``ats=on|off`` (default: off)
+        - With accel=off, auto is resolved to 'on'.
+
+    ``ats=on|off|auto`` (default: auto)
         Support for Address Translation Services, which enables PCIe devices to
         cache address translations in their local TLB and reduce latency. Host
         SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
 
-    ``oas=val`` (supported values are 44 and 48. default: 44)
+        - With accel=off, auto is resolved to 'off'.
+
+    ``oas=val|auto`` (supported values are 44 and 48. default: auto)
         Sets the Output Address Size in bits. The value set here must be less
         than or equal to the host SMMUv3's supported OAS, so that the
         intermediate physical addresses (IPA) consumed by host SMMU for stage-2
         translation do not exceed the host's max supported IPA size.
 
-    ``ssidsize=val`` (val between 0 and 20. default: 0)
+        - With accel=off, auto is resolved to 44.
+
+    ``ssidsize=val|auto`` (val between 0 and 20. default: auto)
         Sets the Substream ID size in bits. When set to a non-zero value,
         PASID capability is advertised to the vIOMMU and accelerated use cases
         such as Shared Virtual Addressing (SVA) are supported.
 
+        - With accel=off, auto is resolved to 0.
+
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
     Only available with ``-machine q35``, it supports the following options:
-- 
2.43.0


