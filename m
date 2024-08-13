Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFCEC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdkKJ-0008Bm-Dr; Tue, 13 Aug 2024 01:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sdkKF-00087z-7g; Tue, 13 Aug 2024 01:44:07 -0400
Received: from mail-bjschn02on20731.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::731]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sdkK9-0006WH-K5; Tue, 13 Aug 2024 01:44:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+GK0aLkfeV6RcqGRF3qtkBNsIGsFkmLBq5n7x63B3JerMsppw4L2SC5btcGNwyJQD5j/qZcTctRYXCYn/g5ShleF6AkPV4evVLDdRU1bLZZ3dBkrJu6/wmT3I4+WJeoU/IqVr/n03gxW5MlUEEL74ZOFFYAnYjpu86qeiRCeTNMpFPKlLD+98bjQUBHX1t/jMgLTKs06IgeXebB28pSiRim3I0T8s4X+HvmEeXkVrQ9uk3JN/mOBULoyi6mrcQw+UTBWDY93ErPbhEIXpmw0NeOVYFAy3o7Jioxjv0Yhnh/FSHuWdWdpLDmhOstcJj2KLxktxqhRS3zH39jGsc1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGLDihIgn8rfpJHv6ll7NJzzJK9tM9LPMNtghOwpZIA=;
 b=jzwFqnwKQx1y4EU5mMakclJaJA3K1bXoelYnsuDo3crvfRbK83LoiSSlvjhnS7Tzvjb3QpJ8FjudmnDo+Rn/hDIMDju/32tFj36Juw4vXfMKMVcOMcFAHrNSTWUmd8ixdGdlN0ck/zBSq4FyvaUm3ZO4hWcf31URAqmOH/b7OrddSDsJZwIR4o43A082Jws85VXIpYj9ggV8JiSYYXPbMZ/MrXBSamF1l/hYKyuwsCZBsS/pFZHsP8MF9CuoRovVenSxoG2O3GcDa2HWtS8TDgc3XateE9sbjRSrboyjCW0GdnJGiwcOw63hzsH/+LaZZ+KASycg/Rtkf8ODblhK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0976.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 05:22:45 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b4:577:ed05:9abc]) by NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b4:577:ed05:9abc%6]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 05:22:45 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v3 0/3] Upgrade ACPI SPCR table to support SPCR table version
 4 format
Date: Mon, 12 Aug 2024 22:22:20 -0700
Message-Id: <20240813052223.1033420-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0976:EE_
X-MS-Office365-Filtering-Correlation-Id: a7842b47-8ef1-4442-8934-08dcbb57f679
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: UFQeK/biJgz6v3BK8BlZ5VBnFvjjAg9/GE3T2G9EsfRJjYlVVMMpl2G6sXCNL6P32EOfF4xEUDvl/smsG1jN7jdepSMs5+Noq0pMvC7mcNLlR16WKDTRz49yzhfVRhBIKePAMkSlxWe4SfaZ7uIAa/ZWwLYlTNQFZw7lNc9XqSRm0pCKVT9itfidDvgrq4YyxAvXx8WEIqOdproyj0eF/KAusO2LRKc/4nvt1x9Y/1fHK3TfzJgaWH72dYhgelTBIXA99t4pOgHL3ckb3QGtpltxXHj0Cqq2/gaq5LE7l/R9uZKe14O8714ErG1A+5HxwVQ4eV5cAaNBPcYFi/VegM1lYQqRBJ4wvLpf0R4wWYiiE24fWeuBM4BuvX9sqpHpJN4vcjcj3zO+/IHTcBVDSn9KmoMLanM53hp7Kgmb0/rvh8VVSTqQfjLv0f6epEWByBCEySaylgJw4mME0F5ygWlck+5RCWsvsJHQ1XxxoNOCS5ivbB1gpVFn//UBf24DNtDSSj5KGaS52gLt4rJ/CjNhdF3H3nCaORlwoZuU10iGHF55sW+i3CdugZvR5SxtsbTQDUHgNIeDEIdO9UJXrMB7hP4GwS+6jk74UvDkFrEgTOK+CnvyyMGEEBiOPsCR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gnaMi8BNJinl0ohZ3Q98LD//DuEtNbLx7/tNxXaRhY8Y5ygWGmV8aKLqvPQF?=
 =?us-ascii?Q?WpjLWXp42/RfVIR63xiIvtPViFGqz3MT+M+8NJCdKxkw12O4NWE6EouvVbHJ?=
 =?us-ascii?Q?pwGwvB5z72ub+DTo8XCx3gttnsdUeUkD4910B8slYpKgg1/GGEgorGlzHNDq?=
 =?us-ascii?Q?D4vLq4ZPc3zVCb3Fv3+0CF699VL4NSBmHYhW8FbsiaJCkabAUHcEsvc217Qf?=
 =?us-ascii?Q?Rk77p//Msyn+JeDCSFVhQQQ6FVfBzA9xQjucBhu8ZLLahejKmkdTobP9KJsi?=
 =?us-ascii?Q?jLpS+OlWZAvIwNVDL/IXEX2bumSKtmj6hY+hnzIXSVY/biV8eZRTHmto6G5T?=
 =?us-ascii?Q?L2pjw8AURW7hpFmAsHSvT1P3RCyG4m9zR1E+xepqAb8khzTDSfxQE6AewBEh?=
 =?us-ascii?Q?Iy54OpovKq1K+J9HJTU5w3h/S/e+T+EZtoQ80x+2IEudhz7TfDs9fCzIYPK/?=
 =?us-ascii?Q?01cyE1wZqhHU5hYFHYyPquNSWXnJpno3ussnYdXXsq/I0Ee11CtRwWlMNxVT?=
 =?us-ascii?Q?v3kbcl5ogI47QCtqxjKhHfiM0AMBVhLhh3YWkXUatDQfPNgeZZjA8/8k89Yc?=
 =?us-ascii?Q?eWYKU7/JPj1xDRmKEyOfA0EfGEHIEhbtuHZYlb24wY73dCi9DcpVUDn9wPdF?=
 =?us-ascii?Q?hDMObtPzWFnxjEbe13qOOjvC27LA9X171FobTpaLAY+vN2rVcBmWSagmB6qR?=
 =?us-ascii?Q?+GRcbL8T33EiIbq7PAXJEd96d6StL2TmCVwGhw99g2bETDj25Lj8OKx7k87L?=
 =?us-ascii?Q?t0ISeX7ikLC1KNbj8Uvlwp7w62GfwX8t+lolw3S2XUGWNyOGDAdkcthFJ7DV?=
 =?us-ascii?Q?EREvyuRM8Pq89B4RQ1OiDLIUOmZRkF/R+fUPs6Y2rynMagJOqhzzwui1BYEz?=
 =?us-ascii?Q?SPC96WGfDULoPyWOQCUoqxvpi0mlj5SYS9lZ+z77V4LXbt+gWlaPp4ATjmun?=
 =?us-ascii?Q?kBLs/xuyYdYMQ/vf/Tu6eX51eV246WB//MH0l04lo622sIBv4RJQr0gd/bIG?=
 =?us-ascii?Q?ARIBZALZYcRQTRRijGv6VVAxeKAjT/yeVyHPagWiJhXaYiSrHl53ISl4DHdC?=
 =?us-ascii?Q?gpLXdBLUzJY3f97cNV4Z0ALMpWtHKfYiKe2J8PEkqLbrkTUrLj9JkXFVGKuO?=
 =?us-ascii?Q?oDC5b/8183+2CSUA/tyEcdxjIvU0iBRCQYEYjXvXVu9Fh6blB8MXdtwXZOif?=
 =?us-ascii?Q?CFPuPIdT/NklIhBQ1OA1KtQO1esb/pfcqfTaSdVnvD+uv3XEEqol0atCCELd?=
 =?us-ascii?Q?CXoSd4LwiXM3TjIERFmwe2VqiyWjke7Ae7UrHc3s8NCMWsLjiU513JUHDLYt?=
 =?us-ascii?Q?ZQpBb6KAlqrPUHl8Y4uBtr2l1pS57uiE+jMHLbkL7JXuRnO5LEseqh3488ZL?=
 =?us-ascii?Q?9igxjdUscjIxkSP+M1IbpV3/Gp66Jxy1YXmZVJ53YCFgMQvwhjH3VmeRc+5C?=
 =?us-ascii?Q?xhGzE7bs+/ghuCFuz4WEyXs4uWTEe6EV0MPq69ktgSHFVmbU7BeJ8XjqRgAA?=
 =?us-ascii?Q?tZXa1/0oCPjsV08un1oX9TsVu3s3bRdTsaqtjLMeAOm/+CO8gNAUhMj+uL8e?=
 =?us-ascii?Q?+TSYVNvkGH39ALXF/s0leH0iJtsWAnUDd4xizuYaKJk4TynEyOIcDT7QcERz?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7842b47-8ef1-4442-8934-08dcbb57f679
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 05:22:45.3416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BrfXoFxWir9gKMSAmrGjZlgN/AT3ibF5aCDcIVDlposAVvBBS+kFwlH0oM95MtTj4sxeEts6hBkgQY/6rAqMLdU7J1Sxg4rYk3DGP41+gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0976
Received-SPF: pass client-ip=2406:e500:4440:2::731;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
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

Update the SPCR table to accommodate the SPCR Table version 4 [1].
The SPCR table has been modified to adhere to the version 4 format [2].

Meanwhile, the virt SPCR golden reference files have been updated to
accommodate the SPCR Table version 4.

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

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
  hw/acpi: Upgrade ACPI SPCR table to support SPCR table version 4
    format
  tests/qtest/bios-tables-test: Update virt SPCR golden references

 hw/acpi/aml-build.c               |  14 +++++++++++---
 hw/arm/virt-acpi-build.c          |  10 ++++++++--
 hw/riscv/virt-acpi-build.c        |  12 +++++++++---
 include/hw/acpi/acpi-defs.h       |   7 +++++--
 include/hw/acpi/aml-build.h       |   2 +-
 tests/data/acpi/aarch64/virt/SPCR | Bin 80 -> 90 bytes
 tests/data/acpi/riscv64/virt/SPCR | Bin 80 -> 90 bytes
 7 files changed, 34 insertions(+), 11 deletions(-)


base-commit: 0f397dcfecc9211d12c2c720c01eb32f0eaa7d23
-- 
2.34.1


