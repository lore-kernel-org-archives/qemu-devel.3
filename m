Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4138CC7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 02:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjUS2-00089f-5n; Wed, 28 Aug 2024 21:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sjUS0-00081k-6C; Wed, 28 Aug 2024 21:59:52 -0400
Received: from mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::728]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sjURy-0007Ke-NA; Wed, 28 Aug 2024 21:59:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL081g66NLSkhQBlLpvrDcaUyd9cTXLrx6XYrvuhzeid63wgDWAfTrTOteFa5Zuks7kERFgmIPMh0zYUQOAwWJAPyVmKGlMpBhhCgy1Sj6XbG+wrMZ7M4a5m+T5rbcsozN/Qx+/dtKMpH6D6Z/ez+85TDR25J3vykR+iNhBNuVBD6WqQz5+m1APgOeLuWpn9EyMk4DjUGP6/S+yUrrOHtYmpcGmjuHkF7f5/u+9Gx7xx+HBMSR3QgG4yoF8fq9qCxehvYHM+Zg/YxVJjWLx8OWUmhqmuHYWpWy/ZLtH1FAnWyoEAatC7LyfRrwdEzeHl8JuNORCbkkn5T81jWp57LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeRz5/L8aYtf3OuIN1+QpArmeSmG1ZnVoXkFb5E6+yY=;
 b=IwXYicsyy1xG30QFpVTrrDrHbOl4F6/mUMWgVRK1S40hMea/sPK3KcsU9G/blDS6n8rXc675bAa9CQHzi662Xe9OXMS5m7i1Nykun7h75E8UrMjPwhQYHNXkWqREHfz7zWYdRQT3/GbSkm27dGWV+6Hozi0ZIWxCmgy5uKcgvSXPbKKDi5cIlZEYlbNTWBML/afrQfM/G4s3xmly8JsqL65qNT+sQCp9xeV79DQ2wx5BkbRNz3i2whvNw58yMqAi4GhSuk/erjXtaQrIVXk/+pr6CVPi1CVGLkYNzfQyLb28GEu+yZlMHa+kaG7LhVfzl1Coxuy/O1Jo4U7WrIe37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 01:59:33 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:59:33 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v5 1/3] qtest: allow SPCR acpi table changes
Date: Wed, 28 Aug 2024 18:59:18 -0700
Message-Id: <20240829015920.95778-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
References: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1021:EE_
X-MS-Office365-Filtering-Correlation-Id: 707aef32-dda7-4022-1af0-08dcc7ce3a1f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: KOSLfrzVe7UqKAFT7GvRKFV07Jtm45RQLCJ2i3JTWSYltVeEUoa/NHqcZyCr+RjRl7/vRzUYQdl/Kg9pHRpOsPKR/DcGZOfpbTyjIuZ18nezcVBpVqLJzKWzHPiVsMBZ1tS51Z80h+sYC4t17QB32zagQ3ufTGV71Z15lKDs3j4RUn9f61bdflfjmB7Al2etQtjVNu2hLzvtVqltKMGOTth39bS2+rlAX9rxA2nz9TDRKE5SJrCpy2zf3co6uSJLR8Q1wBkQmPVT2Ua6X4foluZ0PlS2Ipb94HV+TS2zyn05twgPchv/Tv25BY8deWiftp3hTWrUyFKPnWacPKdci6kDTk5Jcjxii/zAphk1PkbLiSXQ1PfiYr3d5cN1rNacWRQ6kMdeRb8AaWkGASJhUqOrMGzHILqSW/OnscDQKCJzvaPH3+jAnQH2GwK3yCgzrGUbQ692DTl2hT2CETGmUnDI30zEBCrnOf0cfvNSMQKh+HLuTZz2+xblh0a0mjvmeFEm5X2hY/QX2sAv02MsICoU40Qvt9jSVZG1+8Jjk/F5QfraWFK2SzDP39GmXAEG0VPtsiCKs3fL+Zq7IU9Y1dOPuf5JJuU9Xi/pf5hjFq1b4SJWiRl8pNhawXf3IxvK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDSkX0QHmPXXZDOLEwMdqypFilDcTnTo1frYAzxRyEBU8IWrEICxhYmV1rTb?=
 =?us-ascii?Q?9f/wvK/dRs3v+pIZfDoWXJUpaJQ/Y2MXG/wQwEJ7bgxo5J2d658QG8CnQ5Rb?=
 =?us-ascii?Q?7WzAZ9bwdSbMCEDfx6dxEY+u6ObKulZu1/TPBQVmF63FtcoGdfsRqFQhywi2?=
 =?us-ascii?Q?qoKxVaO6bK7K/XH91D4mskdq5TXgx7dzFuQDBORTkjGP+BVSYJAhZ+GZCF6y?=
 =?us-ascii?Q?WlqoX42I/QOx7xP9NomJVodUNsQjBms7C4GsD2AiQ2w30+GaTwPVsiPs5L9+?=
 =?us-ascii?Q?V98KLeNniRFpXd6JcZY6RCmuin4gM2otlCxMk+gER7vdJIdaGCBmE4JVQjig?=
 =?us-ascii?Q?HzrvAOAjmRdxFU1k9/reDkl97Uq6GrwDcrOvRbJ/VW8WSsWymXKMHwD4B15J?=
 =?us-ascii?Q?4r9HHfk2/8+R7QhIJ3R1ydNwwQMVjV1/q54H9E8rk5gp1uJfGMe3x/orEsdX?=
 =?us-ascii?Q?J2JggmDW1iQbWIyj+G2kjf32Lf2J07oLfZ8X7e1Gcjsd76lNI9rC6nqK1Vo1?=
 =?us-ascii?Q?KFJcPoRXeCP+vp3wad3t/MC6XlKivcWz5gl5mT3S7WM/iFaowGTDt8hc0H/1?=
 =?us-ascii?Q?l112UHRgCjd0MdJqF5nXMAIjDYs9e4EA0L7q2jCZPmARdn+duPoGLklHxvk+?=
 =?us-ascii?Q?ntALJmOEWjzXLrtB+Akp1QbuOB6mlsgwKHvHRbDQYxCl3O2ABr0Bfocafz94?=
 =?us-ascii?Q?UEUn89cXGMCizW/Hg8NQameXlRRdquq4pHfkEcwiWH0QyhBaHQT5bkBaSx8K?=
 =?us-ascii?Q?4YdN4c7cdTKUHl4GoJA4nFFBnq9wRDeeDSDVOvJCntM/6MYasVI9ODooju0a?=
 =?us-ascii?Q?ZLWWVikV9dmtvFTdgv6nLlckPomAslpn5Ns3SrrL2uLtzIQO+e6MYLo1Gljp?=
 =?us-ascii?Q?E9O9GAWtr6ev/0G/ddRgmBEbj+RzQm7uy9pM7jS5l40P08tM7kcRcSV8pc+a?=
 =?us-ascii?Q?pW0q26QU6sKh9zoN9mdy18tZj6qDlghuqUpj9aDFadvoSlvT8F95jmUyxOQd?=
 =?us-ascii?Q?DHdvNSAiD9X2aJPm7PWjXKx4VI4ehh5EukbtiggMuvBNFl1SR4dzQXJ725+t?=
 =?us-ascii?Q?bgwlDsJe4qiHJFcqTjnjwoA4kIc+VJUarIvLZ7gC7PbTNDasM5krTt/EjroW?=
 =?us-ascii?Q?lM2Xui3XSTALII6VO+u0w9Nx83fJu6Dmb437FSUu2aQ4TZIPQHwDo0wVCCdL?=
 =?us-ascii?Q?FoeY4iXArlkrNgkUV1bC91uRVbpRfNvkPJRpIInPgA53JD4J6OXP6zjpGTon?=
 =?us-ascii?Q?m95INwV5Rxe9MIDCPc+QeMo4NdugQX22BdrourqWTRD8p3SLLgbv2Z3AXVwg?=
 =?us-ascii?Q?dPcF6QSNih/qWsorqjX3OLwNcfEonhrUK0npyVqsvjaSMUPvcLTD1T76qL7W?=
 =?us-ascii?Q?oSi2fKdcO6TVve/Zgv67u2dberVw/PvvsyTmri9E1g5oM4osanXXkSLag8IP?=
 =?us-ascii?Q?wEMK94YsqhDzYP+l60uGIR9yAontjbbfhQspCeouXoQXj+mkYPwGgM1ZHAW1?=
 =?us-ascii?Q?xSqLV24GyKOGQ0Mh0hDf/j3L2h4DZBuS/PoIeEtNuzZwPJtVUwoylYyyU+Qt?=
 =?us-ascii?Q?KWkmnuzYGnxORotpShiVoQbtsmb7iz5HRpzEyNpeVe2+GO5rTvl9k9kbnTni?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707aef32-dda7-4022-1af0-08dcc7ce3a1f
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:59:33.3920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsDnwgSuoj3vaSsZBSmtkX5lN5npagPwiBFUqYupXsmxlojlEereXWIU4s4aVs9a+1q2zA1mQorgc/MCDxA6XcTqB8m8jL+6hLbPSrDV4N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1021
Received-SPF: pass client-ip=2406:e500:4440:2::728;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..aae973048a 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.34.1


