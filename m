Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68497C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 11:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shSXF-0001Ci-GY; Fri, 23 Aug 2024 07:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shSX9-00017n-FR; Fri, 23 Aug 2024 07:32:49 -0400
Received: from mail-sh0chn02on20706.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::706]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shSWg-00086J-EL; Fri, 23 Aug 2024 07:32:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E30YCPtYDwelKG1T9/GUhNQ5QB/kqm++XNcbE5IUcz8tHxtWlfItTOcmW0yKYISzKeuYjGRqSBtqXXEOAOyzr7OTU9xsbNdJYDtudPfw0HCp/6iP/RBplV4U9KpcZoUvKqFE0fGUDgW8FwcXP7dm/QJM7GfVwbdpu+Mudvop5DbTR3uCzsPwsTjyaCGD0mtRylwQS4NbcpzGkvMAWdx5LNT19UavZpiok6WZF89foCF2aw8gTb9gIkWLgasPmw8ChpqqsaS1kDe/u1i7mBP1s5OMwtFNkyv6aDtW74GHldbwjBwxPHP/nJYVRgImAp4VW4qX2usrJYR+2pgXYrWO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzxH5X+32xRrw4I4+OLF9DJdKtLOWNhJB41gb/C45Gc=;
 b=eFu09cSVTy8xxUnHrZyZRyS5b9zKkm+ir4pvJHzPthhcu4wjh4K9cL0juzTNpvKA3QVj8SqRyibiM9VXhMZqnwehjBN0lKX2IcfZTv3lBW2mz6LL2U64OrlA3wCFGR08GA2cyz6cj57/SKoZTEfp+TTwzm7uUpV4hLj6BpA2IHA81oZlkxTGXi/8YBe0dRIHdoZzVxRaArGQ063hxPBwVUb19O4ECJDSoRiytXH7+5vECOvK4rbzlapBtqo7G+szrdTj+8/3vpT58wITOfFXsyvrNFk9PnwUQk2kpaYFvUFju9WthOUB+wYeoYTZuaGc0pyArGOS2tsrEhbR8JvUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0973.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Fri, 23 Aug
 2024 11:32:07 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.014; Fri, 23 Aug 2024 11:32:07 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH RESEND v4 1/3] qtest: allow SPCR acpi table changes
Date: Fri, 23 Aug 2024 04:31:40 -0700
Message-Id: <20240823113142.161727-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::7) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0973:EE_
X-MS-Office365-Filtering-Correlation-Id: 382391ad-5092-42e3-4849-08dcc3673812
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: MEOEiRPsjfMQkeQOazioizwzE+Cpva2I1kn3JU0dp06svqZI+aBuUDfpZMLoZkbB1hyfG/hrdYZirPf8hnUiJ2eAGBlnaRckIapLvELw/rafRT1MD5ZnU5ApYMlVGdPBH5WUPfXENeiBpH27fumo2JXqkuHctHIeLr4+uWPPP5Ykgg7hZpINhwu4POjPf/AL48YwX0bllXlXorRc3usYop93ASZtIbpZhFpGZCFMnGFZT8+HbN6T71ekV/82w2y+SRu1pHLx/Tx3oEbuMgn41B1g7UvNeJVTTpDnIm8Vk+qf4aYVkPfZcGZkOVLyAkidc4dFfjKER6zyATjXe7nJSLZeTPQoLTayfx8SWqRBW1/4KkMKxIMeOa66m5CAV1C5cf2DtiDOAKJihnHNfC3AeQgGViJpMWV2R5y0tW1957DT6jg3RN7UaYQB3Qa96mEheATCXkqRs36wbMkTYMVy36LkqeoI6+RDOc12KKAwBmysO4mZUgL7cxIWjXivUPgiSw3y0b6vwyFYgplBUMaUARuzezyzu0CfTzwbAJHXIrN9a4sdw7DXmWifQ0nFcqZgSqwX8sqCFvFORq2k7hit32eqHgVHZfzeGwLGVYLZaBO+SbY8ci33ye6Yi4Nx4fQ+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1X8U25ye40lShL43cezvXZgxns/Ahom+i7OmhoyP7K+cEPeort/g6GaGd0Bc?=
 =?us-ascii?Q?NNT7G4JrqbhmzC6dlCGf6ERXeS0PtVMBFGa9r5wNzEZYrG7h3rvh5Nn1r3Zj?=
 =?us-ascii?Q?qlm9Z+T3M6SMIQyGUfTd7EOF0vWPl4KVpAqj5B48mG7NRJaJHfFcJ7jEofkj?=
 =?us-ascii?Q?XjKTUO2MUJVKqPCdOphj40w2qcZKow6ZtkhURKWXhM3CWFd07xRRbGrbpuzG?=
 =?us-ascii?Q?LxxWth8uKD4e5g2qhphbV0pDDoZkcmrrA10oqhrE9O/2s1mp2PYguf1vK1pS?=
 =?us-ascii?Q?sKz6IxhIcDXVPMqMVozgXHwTpa43SaY/VZV9m81YokKVUD2ThtNDfiDBnIpN?=
 =?us-ascii?Q?fEMaqTEZdhGeRcV0N1wWa82oU6Oe0APvxIEEC1XhDalH0UdVCXppeTKzUgMr?=
 =?us-ascii?Q?C2CsTZscpLlsc0QFonO8O5mSdZaYTmfG2m0rSv2c6VzoN01UO7m9gJ9j8dWS?=
 =?us-ascii?Q?kfhZrcNDi1xBDbsxLc90xZAtSCvZBozbhaBwx7BZ6ok25rQyWBiKeKB9qx80?=
 =?us-ascii?Q?FpSRnewQ5XlQNiE9+1NmIM2kEYIY1qv3G6u3ySXkGKI0d5ivBbh3gFBvqtYL?=
 =?us-ascii?Q?JIjV/NQCHFCZIe2+b2eqA26Fsia12VXjYL0mDv2TMbJNLaa/djhipflN50IW?=
 =?us-ascii?Q?kjYwA6NnvVjrVdIua8HDDNmBHXOjjBYOrNYh2uhSnHkuAx0FsQM/RSi29SPJ?=
 =?us-ascii?Q?OKrKQBTCUGlqCtwZgLiVcjhSHfTZCjHZ24wvkCg3bi3GGaz1b0X79utp3PtY?=
 =?us-ascii?Q?8mGdtgf5oTHJH6khW5CtORYVZ99/6fblCUazc3USixkqrRVGR45KTNl4S0UJ?=
 =?us-ascii?Q?3tGeq7p29O0UP9lr1U2pXOjEQc4zP+daIvyBKB/XcukJc0cHkwyOthiieCNd?=
 =?us-ascii?Q?pbqNsnGjInImIS7IGbxtDJJfpsxxYBrx0yB1Q5i2bLqd/jqiRtyxAJOTcgNn?=
 =?us-ascii?Q?v5jqD1u1pp3s7h98R12oAXVUOQ8KAf4ACOljSQNnqmHVBjbaPb9NU0VofQDV?=
 =?us-ascii?Q?VvqH9gi4jxWQm9RY8EfmRPjlGROHLYOt0pYItQgQ2ZilAegp4LWpiX4ieYvA?=
 =?us-ascii?Q?B3ZynBybgoxGfwVQhEXdsExIziTi37/DOCnvF3MA3EDTA4/w2DsstAHd66L6?=
 =?us-ascii?Q?JQsSNPFwq8F3T6xibjR6PNLBVU1wLLLvjFGD88x0clqaaaUUpV0h3S2/fyCL?=
 =?us-ascii?Q?6q5X8xcYOFopGzcRyJVy01VnwmX0B9CRQlgmjOs4orrMdMF13iCqD6qJuyva?=
 =?us-ascii?Q?H0iDohBMW6eBiqPDVE7NUZaJy5szZz/NIQXQDtqIcICTI/Hr7Wd+F8eAqWPv?=
 =?us-ascii?Q?5vboCL8B3Nr/rBK7TdYCnp/8L/KONpMRZe9GmJoC4VwihE8xjI39fu2fZlki?=
 =?us-ascii?Q?7L9rOODTPMBKzlIb9k8aG//yccXN5hlYN5ZiAwlcAJzJTG7gA452Dj7YuVd5?=
 =?us-ascii?Q?e6cf9WddGs7WTOnsGRP5eQo9sobCE1sPd7JI7y7abHiJo52OlIJtGv8OjLT/?=
 =?us-ascii?Q?CJ1bess282KbKMQnH+XI/D8AU8iMZDBNupiTd+GUZBtM0pxg4l01qjYpFb5L?=
 =?us-ascii?Q?HtGe7jjnLCSI/dQgZmZystkA1GcEvWAH+FKBhugtmzo6QV7+YwF8ZPjzC7LK?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382391ad-5092-42e3-4849-08dcc3673812
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:32:07.1710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFIhjdFAnDsbDYbaoN/ObJBEs8QZxhn/at6Pn5oDSIJJQRq9G+k9yt+1JGrPY+FRhjT6SCw/HhU7Y1n1pWBG3ZcxMdmDbU/wtZHNJ8LgSg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0973
Received-SPF: pass client-ip=2406:e500:4420:2::706;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


