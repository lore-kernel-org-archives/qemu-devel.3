Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2991077608
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vxp-0006oe-Tx; Wed, 18 Mar 2026 14:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxo-0006o1-By; Wed, 18 Mar 2026 14:49:52 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxm-0004y3-Rl; Wed, 18 Mar 2026 14:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDKj8eF6O2AWLv7VMpE/L9Ll8fuk35u7vES4RWdOAo6mrYY9wFbzcgjuvR9CZbwJQZsDtOs5Quy7xrF/H5fqXdR7gtL0M4o52k7xaJ4T6q0qqvfxmYvwly4djpOQtdzv3ksyb+dSFsBaKjBH8SjJVBmCbvTgxQbhocEyvMGJh9cYXQExhaleZzUJc+OwkhywR/V5j4XUL1PbFpOW97ZxbeWO/mG/7yTWlCoSQ7cvORIBHDBrFQH/QwBz4LX07KEYcIKwmKRnPq1JtzNn1onmuU1isBoOeUesWMsDeXeMt2yEfNKpVCyvhqyFmoRcxlHzw8G5VneWjdC60ghH1W6c5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43R6OWOqFNBC1q52lLRypkKNoHL8egkoN2T0ShcJZ2w=;
 b=tR53Ppmk0RtHfJlNYiKtaw8CEm0nQP+s2yWuVDeQrf4ARTjUXuwpm5Q3pVo7L6RURoDp+lxkcQf/8Tz3t6dx5SGPjJdlDLGJa29T9h9YIRJces15AL6VM1kGQsMjbipTyYm4ZzReZxS+DmYxPWyr1qqyDrKyc8U42kKB0eiZ4Et2h9lpgDsH45ND2s9hmqS3W8cPZeQIudS7brPhnBCObT0dgcheAfJXEGkBgdcHQH/JJFr+2h6Cm/y2M+Ck5LZh6/m/iyHQtBEDn9u9hjG+367OJCI2mZBnhFNJ3POHA8zjSnvWXAdiUylyhmlVs+pF0eYJN5M0mnBPcgRTY+2Qeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43R6OWOqFNBC1q52lLRypkKNoHL8egkoN2T0ShcJZ2w=;
 b=k6REiBAP55BCX6ItLp0NbqXQBNfkSBOFq9/5FuA4SX/ynIVU1kpLqY7Kqdv8T96qQ8ohCo135ZdhsjGgDXLY3ODIgr1jZmEmIpJx1UFm6Vg680+85/8lBOrYHw0tLKVgrXhPD22XHcquCnxM5we6fQ+KAHZ31dbh7MkOZZr7t5rCSn7KhrIA3BzmDZvebvObmDp/ob6iF365ZNf1Cs2jD5N7STmhOQ4ZvGfaKSC11knmpwhZrlNJdig8mexYTvFgfoNS6nkzHoA0fnpTn4x9oOVdsUZur9vRtAniDQStrJvfzXaRvlV44l3Fsm7YaYlAGxp4zpUy38o1O0Zh8bJYzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 18:49:42 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:49:42 +0000
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
Subject: [PATCH v4 8/8] qemu-options.hx: Document arm-smmuv3 device's accel
 properties
Date: Wed, 18 Mar 2026 11:49:07 -0700
Message-ID: <20260318184907.4060030-9-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318184907.4060030-1-nathanc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:a03:54::38) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f06742-96f3-4ec0-fa7c-08de851f1db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Rd0VmXWmpXJmMjPMtpNfrEmpbtcMlyxKSlhSBJE7aE1FDFujzFOFvyrZBtkifeO0rGvkkAVWmsa5ge8mHkK/Dts3DTatLm18JH5p8+19akX4/m9BxVLcnRRi0ZRyNNjbX7WHQvRvIs2UXtncJFE0UisJHsyHibaLZePy9U5ZZD9FTpRSbqVogUjZGKCkvZCXvz267eewjdqwvxPx21bJmDe5qQO+JD6uSI9rB1lHtpd52J7js5CdH3lo7+0+D579IjQrbJmZlceX4XWjfy/nqFB7kVIy19BbT24cpCt0niOHxsgpSD6xNSWhVhLucfprZZ2HRI9idlbokRiCgJid2ipAV6RgV63xY6b3JsCFv5Lmdp3HE/DAEYHpnpyPaY/BhKTeDBrqZ87wFHJVspUSAM5p1Rhnj/A5VoZXTgQhQb3TNYM94c9pk1a/RRuzBePe2bCGLOz/g/F/+vnPSTn+XP/ohMo5Be8r88jvfkVKebnPKR65vvgVw6ID4WCwIfOmWmq8I4b6OLAriGg7pgnXtXobzKW+mfcVRihLzGmsRR1gP5skOaZQ1dYmk3qHCMLZrfykKXu3QXZmtAlcqsNJHzJ8C32WYC+ScMnpfP2YHJPdx4TsExp1euLH9CF04wf/35ldmHxkRvkOpWeWg4MCHasyVMeQw9N/vD3kdRqFc1u45PmFGVSRJ1jy5oQjzR0Mlx0tgODxls/KsUtdeP9zSr7oDCMpTh6iRTJTkPa1Vvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IMJh8OPp9CZA8rmV74C7e6LckX3fdfDNxXE/dqIuNPKJEzeDA/OeVH7GdP18?=
 =?us-ascii?Q?iNT1Z7qwg1sHuRqnr+yJyIQ7XdwoE+cgbNeZeJVMIaXXjQ6aWZQm0GEKmMDa?=
 =?us-ascii?Q?h45IMzcAZ6BAPQKQE2uDpu4UnVq/PjvOCMIncp1CLu0D9fNcw8tU0zc4iv/x?=
 =?us-ascii?Q?QTMsztcHj/PHWjVnRY7Y/GDWUVTK35Nkn+5aMNLxH7PLsA2KJ+fmUArrI2+g?=
 =?us-ascii?Q?gIjo6TCuaMbV/wIu0dXxmswJK0jx8STd5SEC22TpkeRIFP3336vJnBayYnba?=
 =?us-ascii?Q?cXymjMleXzmnjU2PBZLeNBbR2UJsTtPjQJ746QjXP0qDhS0lQBPCNGZZLAEa?=
 =?us-ascii?Q?Rkshd8CU8SFskYt547OzYSR3ZmI6jkF4Ducy2T1tgjgB+DBiaAIDt/iqAiL+?=
 =?us-ascii?Q?hV9T3JqdEP14RR4VBKz+H1xH288nWiNluuZyN0Om4R46plbt/6WBwllblXmi?=
 =?us-ascii?Q?KdHaS72pEpikiDQOjRYWBXl8x1/iJdi29sVF2x0mbPZVSi1hu1xHweX8EEP4?=
 =?us-ascii?Q?RPhAw6bMvyfYa0qDS+MizlbAR8WEpcuz3MV6mAHsf7IXCiPigNZgVtBzsVoR?=
 =?us-ascii?Q?DsYfug/byD9eWXPyPs3gkVcN9TcBYZgeCZa4PpgMrqni9g7+x5XprLR3x1Zd?=
 =?us-ascii?Q?6qkCQMyKIqeT00S0J2+s1xLdBOLy/bPldYSXQ2b8vIU4LiaLtPUMQx2F+g60?=
 =?us-ascii?Q?IMTbzGuHUmHXHdh784HwvsIK5lfUN6bYf7pOrsIKNHg3SVdkWfU7Ck2d01CH?=
 =?us-ascii?Q?DbJxu2TqQwubcK9zWnLPJZToGTfOZna4B1tXMZjVSp53+q+MZGiZoq+cVCKP?=
 =?us-ascii?Q?+g+gDQcXM0JrxZNNsugJ/SkMIo/ZO11KB15qsH5PPHGA0r5HxultbL/UUXPO?=
 =?us-ascii?Q?KmtDcRGaEx/AhgXJrNJhVGmrEqslJXmL8WIOvcXUkFwjSjmREfimq6Ayho+q?=
 =?us-ascii?Q?NcWzAM+H7EzeY+WAnbo8r4O3xNiN+OiZ8LvcFsANEhXwcmDPzquW667wSljT?=
 =?us-ascii?Q?uNCYxQ6vnNiQKwpcmMIhdkFIQiQw1xrAfP1OhnmlJd9iIeSxleYKIrAPeYg9?=
 =?us-ascii?Q?Vbr7cWp3h1ASymkIiVIpxSPMKVinjEIS8hpslOEK40t87YaiEdInlAN9FLLD?=
 =?us-ascii?Q?22o3MT/tir6dDkkAa0K48GHfMEzrk44D5envhTixRrTLVSmnpgDy9cFKHBS/?=
 =?us-ascii?Q?x/Ot7LPDf9yRzdy/oBYAqCtwDW6QyJJ8aqHF24V3GocSjKyPXmxPtFnGAD5O?=
 =?us-ascii?Q?XOra23xY6OogKhvb6B+hpziVnHqheFKIHSfyy+BDWegwcRTqdHlBjS2yIeFe?=
 =?us-ascii?Q?wwYZEgfjCcdFpP3aR7ZewfO3ZP6TnI90RK/NRc3Q2jyACDAPipg9DoDRtWpV?=
 =?us-ascii?Q?mqyMp6MVVPB28DbdHskZ64xC3qOofQyyYj+Z4E9mme+WVaqDQTn9ASPZ7RR4?=
 =?us-ascii?Q?+5K/d87PGDwCpBH6/YvIpWKgyiVJbxJAmvrZq+GQMigcsnH4NlWLvHDmVZcp?=
 =?us-ascii?Q?CfvshLH6A/mZIYabV4F22hsu2q0aCJj2jgQyi39IpaF5a35dF7S8Ic5Ieog3?=
 =?us-ascii?Q?8vVp0MkbSIYCtaKQi1asadiFFxY1JDW/za+Jt/XhT4J4PTrGk55NGYYxi7b/?=
 =?us-ascii?Q?HRn/vkcI/I0cHlDiJJi7mE17ZYvesaAwCxHN7orA9PJINvuD5Q47jX6sKdku?=
 =?us-ascii?Q?JsPhlL7/fmGabaCJBX6jrnBlqYtOYfZY6Sn7661aChgECwM5ykD6O5P4Q8Pj?=
 =?us-ascii?Q?+j/T2zeLQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f06742-96f3-4ec0-fa7c-08de851f1db6
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:49:42.3264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DGwhctqLJ402UBZqHRLdZ5czeVRVuIOlvqsHOrWv1OrJkjAT9zdwOVsMo8o2gL9RzHCJxBIECrXYfLG5w/ydA==
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

Document arm-smmuv3 properties for setting HW-acceleration,
Range Invalidation, and Address Translation Services support, as
well as setting Output Address size and Substream ID size.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
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


