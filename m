Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424BEF483E1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jyL-00027b-Ru; Mon, 23 Mar 2026 14:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxz-0001zc-Q6; Mon, 23 Mar 2026 14:25:35 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxy-0004GC-A8; Mon, 23 Mar 2026 14:25:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xq4DqgwZ1wMUYRAV4esf/qDh1rE0bwS+dLGLBoDPMskytyuRa3p+Zzf2pEk5o51Mw1tJo3D80ypOIbt+P/3hSrY9LwCFOQ77FZxhpKxdf3xSzQ/Qh8IirDQ7jc1h3qI/VhWZtRcKpziOc/VZ/x21f/w2nUSJYj4KAPKAwo7ku7yudtKlEFsMi2iL/bAT2gwKNnMv+II9o6aSUhy7aWFaiV9WHtyO3Nzfrl+goHoD/cjXf8UjMZY8RmDeHmunZ/QKfchnqJvaLm+LtF5qyB1cNC2g99Mvwx2CSlXBnrB53eEmuRv5+e7PI/op7m5unOUjn77mkrfcQgZuD+3fdYLwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ0t812iDZXqpQXsKjTlM2IJiZ7R+vqpVFaKnI8Ph5U=;
 b=P/QmFYMq2jHXAb7Fz+kFV9BnZiCgcPbfiXS6ceY+ols5joSUrfuTbsNe05ueD7jac0EFh0OtoZ53Cp2mhtbb5sLZgVpRHVrJ2d5VuyTeYUDSo1m6AP44AetxY0VByzZpD1/ZS2TVDz9tpDcvGUZmhfHll9yOIhJGaHo2hs7ulklWUmxQSwimcnZeTtx5P+DwYZ182qjvkfuugdNy4l/KAft0NcjJkG9Bpfx+lGDZQkn41ve8IQpmu2VFdNEm8w7IJb7PfFWkJzpcXRkQdATVj/06jYHzc3M/w0Fyas7vFaiMmzhXJztyfBtrovhAEmUO8bQ91kUQ9EkPIUOG9tgl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ0t812iDZXqpQXsKjTlM2IJiZ7R+vqpVFaKnI8Ph5U=;
 b=cnmSMWo9QFGUL5mSjPREIcmDb0cRtcp27DL0aTMm4l40jJ7qUnDrtFevyzWDUg2ViGchKQYJbvh0yPcaMk/1D4+TRasNqsZB9+N+mNrkJQL9NKHNBt8wHgBKvrsexzgEQSlv6JVpl0va3ZA8zGltbLX9PZw14B7darOgJDW3WaI3MFrv5TNCOP11TML1ik6XntbDwbC+aWdOEJTVPhGvkjSiUjh5laM2OEmtKh1gkdQfZ49461ckK1dX1MgQeKbaVlKKOkozL6QxFztI6ztMpHqc0Fg34ldxryA+d9i8s2YPvyMAkLIfgpUE5Z52LFqII8jOhTDdXtodumQhH0FoiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PPF12042BF6F.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 23 Mar
 2026 18:25:19 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 18:25:19 +0000
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
Subject: [PATCH v5 8/8] qemu-options.hx: Document arm-smmuv3 device's accel
 properties
Date: Mon, 23 Mar 2026 11:24:54 -0700
Message-ID: <20260323182454.1416110-9-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323182454.1416110-1-nathanc@nvidia.com>
References: <20260323182454.1416110-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: d879875b-1c2f-48c0-0f10-08de89098a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: QYtuNNYoERymPBRF9zhgVmmwo4hoJj5SfZEfmwVEZtE7AgFmY1O8xDAFx4RQ/4FhA3MwQ7qEltiL/ZOWhxh0UtXJlhykAm+OtLu9q8ncz1GamM9my/k4yRdANMr+L32npif/eAsA5K34gZAOqtx/0DSRrG3HSJvM6umBwjiXMrTVBdr4VdPM9v+4gojOGZSNndFvl6da0jjnGlc9+DA8j6TTzQc4JlQ1S4AE4R8WLFk5fvvRdbtKjKoWshM5Bh/fZuCM4JpsCIfbeosL5Y/PTNflmgfF24hb/iIbUHj0NuZpnxp5w19SxB74W98/IRhw9pUTkkUWZdSPiSi3G4HwNlpeG/pAfDf5mzyFe8rwoWJP6xJGBAuZfcgcbSpSlIJ2jC5aMjxmF1ineCIr4LlnugPsOKgpqVUTDDOdQEmHQm72Tf9UD4AnfTcxwSDtSO9dmixnpkWNlUyFlIdTPC5AY217cPn/fldp+K9cYpNfTqepClG0IiLCtjFrdvGvCEASD8vk2KxIrEstpP54VdEiE7VzkhrfgTl87Us6zQG9G2Mmea2K77SpkN02wj0Pi4pU9Xq2/WuA+tF9ZOoIvdBe3LNzgY9l1wVX3fcoT51J+bHTIzscZu5qvr3GbfTfiMIfaBjnG125Efbs6xthM2TMl5L2c+G3TFuUDhCI2ZwWN/KRtVSZ73q1Qu7iRw7xz2Z5usE+5iEXTXmIn++6MigaG2GKMCm8+GOD48LqZawNLDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OOyqUJO45n9vJlWqoIR/E6VS5pC5JUwr8g+TZAf7y2Wdy+3YYgk0YXvlTmL9?=
 =?us-ascii?Q?SuaZkHD1fX3CPZd/lm368UnHbw33zGFMdAU5kN0PcaIaqJq2fh0rk1jb4LCQ?=
 =?us-ascii?Q?F7oOi2u/AQomdU0vFfExi/Qz58y4sOJZcXmWLEXw5C1QWtIqvVbfRWx9oSHO?=
 =?us-ascii?Q?pK5btxIAlEpog1CZRR9u0x7R6Dos0Oe9GSrqJDgY7NpiVnHuAxmx57ahM2Kw?=
 =?us-ascii?Q?f1Z3uK1R/q/2YOwuLXiNiJdQwW2Z1PTiRzJ9hpVWJoxD0HTdc5c5LV8zb2Zo?=
 =?us-ascii?Q?A+6jAzvDKJVeEKXNv0kovodL+r7eC/F3Qt0LLrq6BDXxSkBQnWSYkWGR/+s9?=
 =?us-ascii?Q?rwHrM2jK+Ed39GZ2IhU2NiBvBurm2YSsAFnV63vJXQOmlp8olOBf5CQiL+9H?=
 =?us-ascii?Q?wht8/aRvXNTd1T/LjlymgiTprRgD3/Xfg1GqVjiSwjYzz7D0KFyeCBAKbh2t?=
 =?us-ascii?Q?7CIFFQjBEp9BYcs36GATN0LrEEZHAW0HNjHlF5gH5lIy+66+eo1Z8HjGzoUR?=
 =?us-ascii?Q?IgGnG4CDA28Yxg2ZnEZYU/ygPJNTLPN1jdkCXDiseJvuie1ScE14/Dm9psmy?=
 =?us-ascii?Q?zjghsFiHYp/g5QNwGWENDGNUTvlW4l25Rzzz7lgltWpIDcDlOrMOXzTOAWWU?=
 =?us-ascii?Q?LHsS/20myrd15hqgHVM7nEIR0+m9a8nSdu63REsAEhB4FTJh06I7oyajhxW3?=
 =?us-ascii?Q?s1IzY6NNe0XTZ6gdWi1uDBciTmgZ7OAQ8F4u5DJrCVrWlrHadX5bZyyrvqsD?=
 =?us-ascii?Q?d4nSUbj9B4rDmnjra76I/tnjkc+7kTgaQGgETMH1RC8YmluklI/yZaJj2CGO?=
 =?us-ascii?Q?5RKRpj5riSX7rLswCgtGSC3HzmIYDBjRz6tpARbrTPGbGYHZnQQgARQvoRqg?=
 =?us-ascii?Q?42/wfDGu85gXA6ixFT41DHTK6pG3qEquVA6Td+bNpQy/YZxNLOvOaoB2tFwk?=
 =?us-ascii?Q?19KkgCbJUDg7hNe9Zt0wn/oimqMdyzMKjSBYw10sYt7Ev35DsOWWm/qUQ6Zt?=
 =?us-ascii?Q?K56HiWKK4fdqq6GQ4wD2hQ8QFOcTg+ng939iXDhQsRWLlgXm9p9OaZGB9LZP?=
 =?us-ascii?Q?f95R2UTCa95h4SKT5BU7zRpqJz+nfYOGW1V2jml1eTYxi40nkW++eG4MvM0E?=
 =?us-ascii?Q?MnJz7gcGRiEV/HsREtqj2RA7xH/xgYmanBWLe+ZnJ/CGSBtSkAv8HtuabulD?=
 =?us-ascii?Q?uMA9ECopbWIAbbneN7jN7vNUQSA7D63U34Jkt4b8Bed9aci8qlldsYsGtiZT?=
 =?us-ascii?Q?b7ZVX9y2AMsl/Kg9GCT7U+iL+EfYXmuqsj/nfYqwdXfYFViQKNiEED2MyOmW?=
 =?us-ascii?Q?rvkPTAAznmrmga7CmMVTqiunAAgk/9ybRdzbTlzxyG7jBP6bTcbNmGssx32+?=
 =?us-ascii?Q?3Tl6R3X1b/TpgIHakufBb5x8ILy4T4sn8Z9hsVyTuJS/WJ6jcm1Hk2nSjzlm?=
 =?us-ascii?Q?jDJgQbdOkg/gj/s/W121bERCHV9/V8gU8u4YrWA4ITxmQZDgMgkW4Az2/5on?=
 =?us-ascii?Q?M5EGmBCPXc3Bvrvlfg48AZFugwNYvywcRkvncEbPyTlZUIQcDOpokUsu4lEu?=
 =?us-ascii?Q?HgjwftxM6x17fc+4+RAEPsiMkXRzbPQjyfnr67LG8WHyWbZeEKQTYWSr4xpi?=
 =?us-ascii?Q?7aQ1StI9Sj0SX8g858MfNVTREVoV+/RNkr7pdsW12H0/RK5QlOWZMPpghd+W?=
 =?us-ascii?Q?AWNth2tjh5vNy0BviDADlXbOr4lBRJ27Ljx4bmjkBkWFHgzNKgy+lUxwOjEI?=
 =?us-ascii?Q?qk0APw6+8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d879875b-1c2f-48c0-0f10-08de89098a03
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:25:19.7427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IULCdGu5gPg5xW/NKZsfi557dqLVtVf/X2ikfeNmj4bitUOPVf3uauybCnJ9OOHGje1bs1vKsurqLE4fsUZIsA==
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

Document arm-smmuv3 properties for setting HW-acceleration,
Range Invalidation, and Address Translation Services support, as
well as setting Output Address size and Substream ID size.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 qemu-options.hx | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 69e5a874c1..f8da35513a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1279,13 +1279,43 @@ SRST
     ``aw-bits=val`` (val between 32 and 64, default depends on machine)
         This decides the address width of the IOVA address space.
 
-``-device arm-smmuv3,primary-bus=id``
+``-device arm-smmuv3,primary-bus=id[,option=...]``
     This is only supported by ``-machine virt`` (ARM).
 
     ``primary-bus=id``
         Accepts either the default root complex (pcie.0) or a
         pxb-pcie based root complex.
 
+    ``accel=on|off`` (default: off)
+        Enables guest to leverage host SMMUv3 features for acceleration.
+        Enabling accel configures the host SMMUv3 in nested mode to support
+        vfio-pci passthrough.
+
+     The following options are available when accel=on.
+     Note: 'auto' mode is not currently supported.
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


