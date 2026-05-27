Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300A1CD6E48
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMYb-0004iY-DY; Wed, 27 May 2026 18:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYZ-0004hM-6X; Wed, 27 May 2026 18:16:55 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYX-0002I5-SM; Wed, 27 May 2026 18:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1oYaETAOwFeMsB3rtVfxz/35fQz6X2qhcZndcGfl6QhTcXw2iMOpKgh9eXtZikdkqK97tsrPFQ5lWZWmgfxLhBSfnmmuWhG5TVk2HwiuX6tNayiD0io31hxeTDxevqWbTtJcB9F+vhWFP+6JMbQBOhSOr24j6regnKzYhP+gTSyNJ5erLPlG3uYNXc/PtEu3EEiIj1S/SZWXnzYCUokYKzry1eQSwq7CVzV4uyfIvWSCMjGN3kt4hZTuklzUs1e7RPnkzbWyEKvUAIiLqK+uYn24qJgZpIx8xt18yRWJpYvLWrCalF9xz0/+9LfI3dxMgnjcenaFaXX5NLsMePVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL8fKD1SEBY+fIH2fYWpzod7RVaIfzpJoTdTkdIrRp4=;
 b=QN1V2cyOU0Tv99r1AP8ANp4C1dNbRXM18ofWKPYeoRXLIvx6RZnLzuK7e1Z2dGKahnPqs95MyuyOrk8a3jzhkSf9D72VVJR7RhznBgCormNoNmNNhXjXH9Hb8efw9uExT8OPJC3T7yZU/lEqvmCgZLYwiZ2xjnxIpwScZ8DOoR2lDBWUSWxPMmr+m+34atMJzYlvkyBuTb0c8spTX1BgRe+1r+PpsJofGqwX9j1gzqABZDR1cGKYm5B77fBcD5yZgRktSKPOSZhsqrITzLUL4BNC9+CnEBMSKVEZ4yj+di5A0G8s/lcduwQqGZASdHkRsxf7Inu5Ea7OvYT9k2a/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL8fKD1SEBY+fIH2fYWpzod7RVaIfzpJoTdTkdIrRp4=;
 b=AhqsE+2pfI2Y0fNsd2jdYajQX/gtAUiwQjBhcJNU+xdpAcqEXSfIai2llTYSIGczUYhhWaBhQOF/Hpq/R8eF5qvvFo0Qsjcs3UlS88B7EzpPnIXI0lYjSonfycUf1NB1DQch+hB63m5OUJW/r0HoWWLWCEAaV435vW80ETpvhEtQeppZ+gp2670va9/kLxkX7P8db9gSSkLGfKsrLs0YwaeNeHE3nODIB8vk0tVniRWiE7ooAzmOjp9VcdpNxDAWWUwnggZrA6yneIUDiL/CFykNP0zWolGJFkhv1IavXYBBfgRUKvzUC5ssBrzGexAcS6XFzz7+6v9poM6yqXjjKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:16:46 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:16:46 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage documentation
Date: Wed, 27 May 2026 15:16:24 -0700
Message-ID: <20260527221631.612026-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527221631.612026-1-nathanc@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:334::21) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: de88483c-6fbd-413c-f3fd-08debc3da3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ustRs1SLBBMYwkwEGOQetcVb8Vri7dsck8xVvLM0qCA+v9EGiuQC0y1uCvlcMpFovAYDwmCcy/P00y7iXs+VoDb6maq7wH8KdqRfH+59C5QYWuNp35o7mNkIeHsGS2+aKgFx1Nd3ucfYsHvy1qXPJH1B+ZuXol1nzim8x/TOdBg1qo7W3huQQvfSedGyA3+xJhkrQ7j2l2d5N5YY2L+FzpK72XaOA7Ssyjom+9aeH05ZiyzDILpuA4HTIK2I4aaqWzgOzYgipSTdl/+M0VpirAxjsl5hsl9TDrmq81NeTk3h/S74emnKzUa2dDkMoTLIfxttJdH9S6dAawuLwBIeBMyM4s4M+KAf045URtaK44J8H/hJMRjVXVovWbLC9lVJtqR6B9d02LInVU+ePmM20S21E04XDMsOSZIJHtOgyg9k7uMs8dUyQxtnbBRkVuzzun0jhhIRi7wMJIRQQRGrFjLwaeZQhHEA91Z6a3eULoSy/sTf/fIbr0kvCXIaeAkpY0xXFACDzR1Uff740f2/pL2ElhdBEi8gA1PWIbAxb/X5lx9oGGEKloVeWOk0pTD/y9QRgAG7Pj4bd4XrlueIR3PkSYECom4EBYKIoytPnRxFl8ghtpd3rFPe02HjrJY037oepYYi0avF9ooyGOO8TKoNObddxvjFDhYW1oossglPjGAtMdrxzaf0gAz9kVaa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?19JNSj8F87afneb9wT+mZtnvX8ehsQTWnv0rokK7AtWVopLlnfNO2a5LZUcK?=
 =?us-ascii?Q?UO1GbKgtjZZu9aadvM+RE6jgwKLUFPgpXNlC3x3ZIIhLAXrjckofHnJdNHR/?=
 =?us-ascii?Q?5ymlmz/f2WkC9dFb1bAAi/KxiCSM3f8FK6brMdTHq/lbrKEosllRfyLeLa0E?=
 =?us-ascii?Q?4W3/0Oz2BzS2gngowyghDjjJ23HXE3QTMdfDOMIYVXo6buYSy8c0YARqVGd2?=
 =?us-ascii?Q?fiXbR+k1WHw/eyMXaAz5wMfTswOITuBE0H9XZrsd5VHjOkrxW0OfI2sOmQeH?=
 =?us-ascii?Q?a6Ah9uyH2eYb3PR5TjdyACD3eSrvtyEk8R4LPLkqMRI+UncYUCCoKMPMHbzv?=
 =?us-ascii?Q?W6LPCoKpHf6AUIgOJhZD80SvvKN/KqbjmAlzuRXB5eFYOyp25Q0x5cSmeALp?=
 =?us-ascii?Q?tEAbH9pnNoyyTpbKUwciX+77Tuvkwk+Xlo8eVXKnku3rn5wojE0ElZ9O3zFx?=
 =?us-ascii?Q?oH4dtVwL1YA/nhFmIh6PmR7t8TRgsCgdUfTmwIf3fa+ZMYv4LZ1X+GeQ2Y2+?=
 =?us-ascii?Q?28a2rJgYFbVpN2GvO2OsJxmgFVIUli7MxS6/LQ4zgSiiwJShq/7D5DiwMq4A?=
 =?us-ascii?Q?CP8tmE190DhQe+FHGraEcstMcat4wmc3dWLXUGanzJ5nHVa7dPwppbo9ynux?=
 =?us-ascii?Q?Osb6WQG4Nkcy0HwMkE7TbDPBc2RTlgXCVVs9pbZkv1AQJ4SEYoGQIGYOzZEz?=
 =?us-ascii?Q?A/My4RVxczEAnnrFGJ9xmFoSE4s8iEX77mmuAxPl9FNbAIyiXIBss1U5mquv?=
 =?us-ascii?Q?G1xy4QJQlN/8BDtmH68q44IIOHS5yPiQlxdsB0TlHrpfnenA4WvTidxYy/um?=
 =?us-ascii?Q?ukD8vGVYB7Za96GwOlLleZpddjRxxRpzd1IfITIk0pzUVg/FV9B13QTbcP2K?=
 =?us-ascii?Q?h5TBEEidgmZeW1EKIf4Uahtrj1nvdeIAlnBtYp7kgNATOzF7pvttx1yVzGuM?=
 =?us-ascii?Q?3bbNyidF4m4zcQ73VeMw4bkDoRjPuU7IK3RTCj9Gt8R3B6t/t0Bt1Qk0sIcM?=
 =?us-ascii?Q?R38CIJ+2jxxc1HvY1JYHYO6nJNyo5H8LNQgjPHCAD46qegQkexobPftTH4IN?=
 =?us-ascii?Q?a16d0uBW1j+deN4vnjhf7NNYwMK8msBAlFypNlwXKgDycw6FFafauwOTmsLJ?=
 =?us-ascii?Q?7dZSfKxHQ417BCt2Mz0sxWiAY6Uwr6I+Rssh5uLTjfXP9IFHdc+MemHZLBmp?=
 =?us-ascii?Q?W3m/qe6U/bHwNudoj8Jl8uJo0Othw8NKIHL3dKTjy1TglIqYYkMWMRvXmwad?=
 =?us-ascii?Q?bEaQuPWDE8hocn/Hc+TnfukPSxGGyAo7I3bJBSYHOhs16TiI3GUej1uYHKNT?=
 =?us-ascii?Q?d3ikS44wkufBZPM2IVN7fy7co1Bvnqub16RvOnS1/DkcxRwB2sCFsr7rwvRX?=
 =?us-ascii?Q?+P/4yz0rqEQeUfWyg6elB5GL4mmQd/oQszGeulF6hVIuqfHZvoS7X/t9jiHO?=
 =?us-ascii?Q?35on+hlvlsjVdxODzBR8FKvEUQmY3TT3lNpcv/TBb4jzq7h5gCPrcfHVJ6HU?=
 =?us-ascii?Q?L0YDnnXWqumsMSKEXRkfJw/qoV0zweUzTFS+dsU0w04ix446Uokn0D/Xm4ju?=
 =?us-ascii?Q?ZuuaY5Nc93fgsW12H5Mf6E1G4RY01pMjZvOLd9p4Nk1Uvya9JS54KWaAJZpD?=
 =?us-ascii?Q?bTKITQ99h7xXw4OkwZFJmd+HtfSw3Z6YoCcr1h/eBz3SeKu/RClQLSWqneib?=
 =?us-ascii?Q?KIORlnNWCl0Is+cm4wwGV9p0MAMW9tvI4xzKlmZfMY8PDnPZhjtdfICJWbDy?=
 =?us-ascii?Q?ce2/sbfiGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de88483c-6fbd-413c-f3fd-08debc3da3c5
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:16:46.1012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ST4WoIB2MCAO3Y7mk4BbFHLihaIIp3ZSX1mroS6ozI7Tj+xd1oTjPTDSDi+VbMRCQGUw9tq7GA9E7zpryJEqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nathanc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

Add a statement to clarify that the host SMMUv3 must support HW-accelerated
vfio-pci device assignment when setting accel=on.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0c65dc8c91..a8c49a48ac 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2165,7 +2165,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
 
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
-        "configured in nested mode for vfio-pci dev assignment");
+        "configured in nested mode for vfio-pci dev assignment. Please "
+        "ensure the host SMMUv3 supports hardware-accelerated VFIO-PCI "
+        "device assignment before enabling.");
     object_class_property_set_description(klass, "ril",
         "Disable range invalidation support (for accel=on). ril=auto "
         "is not supported.");
-- 
2.43.0


