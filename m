Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7590C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 11:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shSPD-0002sy-TR; Fri, 23 Aug 2024 07:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shSP5-0002pD-73; Fri, 23 Aug 2024 07:24:28 -0400
Received: from mail-sh0chn02on20720.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::720]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shSOz-000703-FH; Fri, 23 Aug 2024 07:24:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr4W3m9fgPbM28ytUlOw6zpQJIt0Lrs8u744F4aU20f9Wu9iSVvPTPPlrAQZ3pZaNP0CfyuSCBq5q1ZhGJemIfVK0Xk2IJcliMNSphHm7IIGySTOaiUeYhAP8+nMZ/K8HvPOlDIUMC09LhwEJ4R9nHnQTZuTH0rdoaI1S6Ix/koOqKzggY5i724CbPUoBjhntbFK1Yhl00hGKGRw3oKGX1JWHNL1j3v8sJKeYZAhuyNGcd9269EFD057GBLssbQv76gd0zAWO3bhoNlZtxU5QuGgYpqge6QBT0Ux55YIaof0Ri98TZJJbLis+K45Iscb7wI8Gbmaz688vL4Whei5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+xJV42xBcVIz9rDy3qxS/6cR8Y9sm1zk5vxLXw01qY=;
 b=Oq1/5O45LsJYFQxS0HCLM5dqRLE/3GAU0s/k2y3eJ4jZz5lnDSzbQkmFnqcgo3o4OY0dEiUs2iR/iP5gJPI6DVZnL1ihX+nXLTZY+KFTTwkKyv9kAZPxoiwtO7VjqQ8B1UE6wrszIcK5Z4vXMgTQRNqrC/KsLgkcWySkketiu+A1w+g7opa/Q+Oz1WvOHUGfNsrkD4RggSnDzHW3NS+s1gZFIf1iYVBlXmQ6hzGaPn0tqPEtGVYWpPxb3LdQu8makSENClpqs9RMlGAUfzUc2j/rjLbP42wBylpfszc0u7D7pmmjycY7FPTIRy2vVJVBUIP+t6vTlFYPxbzHcGfC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1327.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 11:03:23 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.014; Fri, 23 Aug 2024 11:03:23 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v4 0/3] Upgrade ACPI SPCR table to support SPCR table revision
 4 format
Date: Fri, 23 Aug 2024 04:02:58 -0700
Message-Id: <20240823110301.161588-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::33) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1327:EE_
X-MS-Office365-Filtering-Correlation-Id: bd58a0c1-ec03-431e-4674-08dcc36334cb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7416014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: URlypXdsVRmcQHImCpBMSedD/zve/YiNP35RMUslZ6ZGNE94IyNyIOwVo7FH/eo/H7nNtDG0RShATkh/YUzwvelgh9hBA+Qmf2O/ddQ5b3MbgrP5ogd/1ekkLtuOf2tR3ynZToTzVLgYEFxFU0MVHdIjK6r+cc/eiNW9qHYbPb2aXpzgPrPsVhMWSppEZxl38DYDmvw+fTHaib3ALNpCTNg4mlNAfPiEb236NBu9TvKzBPhDMODnXkdt1KJtw3nPiFsrTluhuEFI3j9KjId/tKxISv43kTAJmMStdXOrcPEky/c2skWmRfo0bPGrrRTBWJHyN+Ff1dRnNdTWXuyq2mqTG9w8fJcEOa64pDPf99NkiteOQnsmUlVevNwEKJfiU99Q9PU9uoESvubccG3RhlOK3WZT26iOf/LjIXC0/OR/ljPUuh23Q2+vFVHvvkTXpcpP1rHDm5MZjcZPiLcRjj9eRSrak3mNkv+4rW4iXqesyFyOBAYNqyXIabP2juhQbEoTnNXvOI9RJDr30Ln5jStgDmYOLDfpioBVU9SUPa+tasbValTaT11vrK3M67Zep0ApQQmezfkuaZzNdFzl/HSE8uNbaCddXTXgqE8do3DyfxRVP6Q+SV6xIeuWq30M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?07GyijGhFtHnmXMhviXgIweNEeZstS/DnJ4GB4f0+Db2Qof5qDZm6CHR2lna?=
 =?us-ascii?Q?0a4+jWPbDeJjDD7JIZuJb/vJ0UNtwL6PIN7wAdBjYpNghQndtggMD99GwI89?=
 =?us-ascii?Q?9sfxtq85VR6HG0ht3xDw8E4sAtdKUyzRhZwH+fTBRRaBQm7rdvVJR8rCCGo+?=
 =?us-ascii?Q?m1PdM6GOs/52kx2hQPlW0fR+M33ycG3ZZJOvuDdIiGIdD1/8P0OLX9bl+kov?=
 =?us-ascii?Q?mdmagVb/ejvNcxYr4FL7j3aFl5nAFtnqFcB9U7a+qou0yFOAa9dN2TbrEQu+?=
 =?us-ascii?Q?Cq2thcgDQB3XPqTFRsIlejkUOqkcVEth23sfzo7aLQDueMYsR8+IwJ1mPsN5?=
 =?us-ascii?Q?y7wwb7ZW20eqwI0gy+lSOoaGi5WZFz6bkUfR23oR7Z0iFzZVZlMDT3Wo4y4H?=
 =?us-ascii?Q?AMGVoHZlP2TNCi6iCNQJdnSK5eyk2h2c2opVEs6IprtqDQfvR3QrGKa9hWRW?=
 =?us-ascii?Q?uhKQh3/C12PebLeXM9uuqbJUIiHjGhiDsKEBxoof2CRg54nyEVVCkxlDhZGQ?=
 =?us-ascii?Q?ta4NhNRad5qogkJ1v9Zow7vyeyIqcEWFgEEzkWN52lfG7fQvTIQCWSGpjY9f?=
 =?us-ascii?Q?CK2ICgiEra5IZu+n1h4QW9D54eovi3nnQyFhiXaPKdJ4zHTt1JFgDEZTXd1X?=
 =?us-ascii?Q?Uv3flHQxlzDA2loI8CWXhLYrvkJFjpgnYLMXuDzyQYZBskoVA7bCFGNCGM1g?=
 =?us-ascii?Q?FCTowJroUiEEm5n3+HXbdylLUW/omy6YCnFSmdvIpOv/WlUils5HhH5ZI/YZ?=
 =?us-ascii?Q?sstGp6/y7FUyPLiA6Q63qcdtduIQohxE1RrSpmcVV/jVKTD3StJO81h4bsWt?=
 =?us-ascii?Q?+TPNJyTWYwvOZiD3HTk6+JLvGFCk1kCQvWb0vTy23IU8ZSRmGk+HAmcvEnI2?=
 =?us-ascii?Q?jlQrWrBp4CxbGcpYdTTi4BK+Ghi7UU1IEUXbc+4urt8sHtmoZP6vvKtQF73L?=
 =?us-ascii?Q?MXzT3npwFq3vA4oOzw1Rl7nJ791NbuGFTHr+8lPzwdinO+eyGNYp70yUa/kd?=
 =?us-ascii?Q?29I24T5UqTFU0F6vzviwphgiROP8hXLs79hU2YSqU0YWndnOh7T0Q2upysSP?=
 =?us-ascii?Q?SPFf19if3pIluEbDHzaiIlH7Kc8dKXeX1hWR4BLRlzliinljx+QE2mx9X6yp?=
 =?us-ascii?Q?O/Fjy84jlc3WbgmJRXHnCyl9QFYrX/FRENJWtyfSd4Y+DDOwQfDaTFbD0lTU?=
 =?us-ascii?Q?zttV3BANeQDkymbB9be8y1nVWMSsAU+m6rkZ1qkRG0adXO5Ihn9tKnFw474X?=
 =?us-ascii?Q?yYObyS1FA00E52lYqLYFK2H89kwUK8DsEROj5tXGRxwofACQz0YpEnITdQ2b?=
 =?us-ascii?Q?sBHZ2kQiV4yyRy6Bj4n6Qt99MC6X8s/n4xiLoybwPY3wXXezEidWGRw/uotc?=
 =?us-ascii?Q?WjSMAnIV9rj3JJwP8aexPvOhIhvnsaQhEIFINaewiTC1TcToq2QtGxE0aCyr?=
 =?us-ascii?Q?40Wswkq8rAbbq3fv+i3pX+fyz4XrGqbcuVfkAHMvozYDY+lvJROmkNomdemN?=
 =?us-ascii?Q?eETHIv1MeXtuB16nXFnNajN+I6aC7KBUs1Tvyf69PEG4StU9V7nH0/N9Q3uT?=
 =?us-ascii?Q?vVKpU9ynVLW5+cdNm77FxasqWb9FZUD6AUbRskiTPIAt+ZqPtqMARMfbIJTW?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd58a0c1-ec03-431e-4674-08dcc36334cb
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:03:23.6759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlXswyo2Ez2N9e3x3YFc6TLhSi9CK3sne3MqrOP3QDC3DVKOvWxFSs+j2uCJ/xlAuZ9o0ka7958Z9L7mk7ImMqNGIniYmk+2xrPtxFDjuF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1327
Received-SPF: pass client-ip=2406:e500:4420:2::720;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
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

Update the SPCR table to accommodate the SPCR Table revision 4 [1].
The SPCR table has been modified to adhere to the revision 4 format [2].

Meanwhile, the virt SPCR golden reference file for RISC-V have been updated to
accommodate the SPCR Table revision 4.

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Changes in v4:
- Remove the SPCR table revision 4 update for the ARM architecture.

Changes in v3:
- Rebased on the latest QEMU.
- Added Acked-by: Alistair Francis <alistair.francis@wdc.com>

Changes in v2:
- Utilizes a three-patch approach to modify the ACPI pre-built binary
  files required by the Bios-Table-Test.
- Rebases and incorporates changes to support both ARM and RISC-V ACPI
  pre-built binary files.

Sia Jee Heng (3):
  qtest: allow SPCR acpi table changes
  hw/acpi: Upgrade ACPI SPCR table to support SPCR table revision 4
    format
  tests/qtest/bios-tables-test: Update virt SPCR golden reference for
    RISC-V

 hw/acpi/aml-build.c               |  20 ++++++++++++++++----
 hw/arm/virt-acpi-build.c          |  10 +++++++---
 hw/riscv/virt-acpi-build.c        |  12 +++++++++---
 include/hw/acpi/acpi-defs.h       |   7 +++++--
 include/hw/acpi/aml-build.h       |   2 +-
 tests/data/acpi/riscv64/virt/SPCR | Bin 80 -> 90 bytes
 6 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.34.1


