Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48306C5321E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 11:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shSX2-0000rM-Dm; Fri, 23 Aug 2024 07:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shSWf-0000jd-9v; Fri, 23 Aug 2024 07:32:17 -0400
Received: from mail-sh0chn02on20706.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::706]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1shSWb-00086J-RT; Fri, 23 Aug 2024 07:32:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb0tLohzHDdlpnvSuuwmv4zXzBDlCaevk1Vj9tgtBtVITFGIs8a2WpYRBfOu/5oAIofelNRpl2Isyt4QvsmCsRFyK/w27EbKiYEyIGkW3V9UHOKGNasI3DBcRGbR56JkmyBc7nDNksCC/Eugvx6Mlq5GHP7fSyBGjPClYT9sQahTLBLDpulurg/qNqm3mUmqeiIuLKDosZPDDhGuCjmSfRZT1X9Y59LHZ3hzJMq7GH4mSlK1FM8AFyuvl/gEPzXjmLN2naMeXfNQw8rtoBBXQcWKJGYhfBUMbdwn3gGsRmjOe7MnBsVIOT82zhvHNa07Wo11+C0IUfSpgHKmcNrO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+xJV42xBcVIz9rDy3qxS/6cR8Y9sm1zk5vxLXw01qY=;
 b=F1VC/LrIcFFGKL0KpBXGzl0SRpu2mYvvnxdboTeciv1FwfnynjVQOMy2Z/GbfQOvrSbI3K7DuaZc1nRyEyav47UoGt2+a2evapF1kMT6sQ6uTawVVzMAosurZY39zPF03MWBkLkJscEIzxBQnJ0OuY9b//gbjVgzeI23KVmgtotBWLoN/F7iIm9XrkLCekXRFe1JSkldzy1L27w4oU0aRo+8ivk6m1GfRvs4v+k112Fc8Xbr8DCACvk8djNu9YLlHiT7O69+aBlbigFnjDb8ZBj9Egvq2Bac8Fs4Hu1O++X4Wlcwmko9ShROHzCUqePZcSjj9y5xQQ2xnSP/1o6Fng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0973.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Fri, 23 Aug
 2024 11:32:03 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.014; Fri, 23 Aug 2024 11:32:03 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH RESEND v4 0/3] Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
Date: Fri, 23 Aug 2024 04:31:39 -0700
Message-Id: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::7) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0973:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f92fd3-be6a-449f-43ff-08dcc36735e2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: SYh2oZ40YupnJWBbKqyJxIQ03qcqwW1vF49YezcJ2fz+sqRmfwK/ciGMpWFex2lkAihp13cayO/h8ucz9btaQjAEo2mgx5qmbLL34n59lBcwb9RFdv77p3MU4qrCqrMojYw6PJqZhAPvcdN5GvcFpHPlZtGOvR+o5Y0XR7HuWSdYgBj6Rkg+J7GfKyLniJbkwa+I3fqFwkhgmfx0hzlmNQuSG+fiHOk9RlP/GSNn9QYMUhdEQYJmivGH6/ipf6fgWm2dF/iXAx1LK8DlsmNnDmgEvnUpk+hpJ3m6Gw5KKAmC167zAjsxtGtfS60aesLKhcHKuOFYSrWU+0FsE97msqoqBQGpgwH7Oee770ufVkAMA8V2ZBWkTG8MTorwInaj+jLpkVX/RzcYycuLQ7Q+MM4CkTWhiaNZpMtXJe3cGoWhRPnfF1lj66TNPcz9c7+jt1j8RuaBbFJESzMZm1Avy8FcFNd3CKrVhALa/sq5VgnWLvkFOWcvpxTD2zjvwn8oKCvQFtlFM2h5y54SYi0igefy7B9q/uziArze574pbTSaeL1M1q1LU1oQDUGAD/3JGU9cuzWwz1GCY7pWQ87DwqeY7YgixLVNZ5VD3yOXempFuThEvfp79XUZr/5yDSDo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cOlaGU/E05UfSU2ONmmKE6m9t/tv6eZB8IbGMlCFI3LLq6aGggouxjhQlA/?=
 =?us-ascii?Q?Dq9Oket37mKsiH/QFQUCFxrbz2hFcy/qJVX9QamBack8WT8cq1YmpXhvX1VA?=
 =?us-ascii?Q?pejd+N+7IAFcxbT29HFS4zNUfl9s6xlXGLUMDZ3x60yUkXhu9IcnzWssMDOO?=
 =?us-ascii?Q?L7jgfV/o/d+YjIvwvga6MxFZNVO+IjvmyxpTzrWBcIjkuzbcAFcvjFdhVJ2f?=
 =?us-ascii?Q?Q8zCbBn1kXMRDIO7ZejfoUNYsi0V5utno8sekRE2/N5K9VIoqTxUpb9Q765m?=
 =?us-ascii?Q?SSmhV3ItAfr8UI5TeNYBQazTBUx4HjI3Sb4GCxoE9lXt2UzE8UOmEGeYo8fX?=
 =?us-ascii?Q?yjgtI/0b6lVbdpqYwUds4JiN1cE1aH3suu0cKl9d9ufvNVvkKJimHsNY6DPb?=
 =?us-ascii?Q?e/TOTd8m5mXISr20C7vSAuNaYQh6IQGdzZo937sNY8U8poQ9RQPIU8wQwCCP?=
 =?us-ascii?Q?zILWJHYG2B36KKcmR2HrZkhTjd+iaThJfhQH8l4xnAmJVoB9FHR4M60Krrir?=
 =?us-ascii?Q?9iLy8l5tJkWzZz1To8wZ3DaBPtVK3ZHq44TQhVe+AHhtYg8aExJ3HZBhmjMh?=
 =?us-ascii?Q?sSZkOJnQA3Ft8O1RZ9b1MMuDrOLuTgq82Qpv6G9YOy8Nrjy1itBQifeuFYxs?=
 =?us-ascii?Q?HzXJVhfgZOMaUhPhinh9VwvZD8Tty4dl3fwN/l1RVlZyR9uAzcmGQrVQeZQ8?=
 =?us-ascii?Q?d+Wc1chm6pYCUp5phyGrvcuyn8y99l2DtgTnRQYWmsj/RqLaCf2xN0ctZIGO?=
 =?us-ascii?Q?4HEm1a34MPjK0NyaA4hrWaMziRT5HWDSAgY/sVHFD1spPtueaXhS2c9l10sl?=
 =?us-ascii?Q?xymfZ0BusIVoce5a3vaDWdD1KC35H++oS6tUpZGCDnUS8E+tKJxUsIsAUJkF?=
 =?us-ascii?Q?hxzRDyPcjbushh4A1biF/B/EeEs6msRHdwDwmGM++abUFRXmY3y4mh1oknFQ?=
 =?us-ascii?Q?IdX3HjNXVoR3I43YxYHqXyaAeJI2aVxGRQx5WPUlGuNMVPh8L+oh8ocLimCj?=
 =?us-ascii?Q?UlNhKVha+fVHE63M55BwQs+/oT6Rq+N83EbaxwOP95zcH30YtjHboQ9MoRqY?=
 =?us-ascii?Q?8LNKROpAlXEGUFQJ2ziaSrpVCTtmH8xLVMwRb/NEEXk8Le6LvFQOaZ/6Lj3j?=
 =?us-ascii?Q?smbgSXDOxDMDtdcDSOVRRatH7pwHF9Ogb1MEz5VJGUR6fc5uPACfqQrG1IvZ?=
 =?us-ascii?Q?cEoTg8ABKd52F5o6OACNsxR2bGzKAA81b6Y6RccK7bVjVPRe9NIRzosN49CP?=
 =?us-ascii?Q?66r3GBfK03A3LvpxgkkxkdEmWzIeiBgTplXkjEpvgF5sHO74mjIci7tb09sO?=
 =?us-ascii?Q?wedQ/+xH/M2yWQhyeYzi4afXJgpkU6qRZf5teUDUS2/RHv8YPwr/CghprCDc?=
 =?us-ascii?Q?7cKbm8BEJrv4ACD6eE5Fw6RPQ2uUX08H+U6CW0SMsb7Fu/lOW1baJwfN4G2Z?=
 =?us-ascii?Q?VmWwMUgWgNoM5UfFWKUp9r1efmOGCrA9Km0K+LQMCoEQzOFSMKojrRJMivsJ?=
 =?us-ascii?Q?uQd8lL1Fp2OUoJf9pXvrH/1lsSqPsMPeY7sfALahsreHnewSJ2nWgmdA+Orv?=
 =?us-ascii?Q?uELwT/UNl1zzLoX0gsUKIDqeRXOojUJ+gWratVXh+nN06HS/ZhIKEqXN1tiG?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f92fd3-be6a-449f-43ff-08dcc36735e2
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:32:03.3682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUz4/8pkMG0HpmoRwci9R0QG9/oYoLwWvckuMgTwMp/qjb9xdbxfhHQiCB8QSHbbwUIm22yMLdlqSFp/dzc1fZXAWwtJrKX2i1Lny99YZBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0973
Received-SPF: pass client-ip=2406:e500:4420:2::706;
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


