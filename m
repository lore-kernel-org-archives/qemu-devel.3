Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E03D13594
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 01:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5F1M-0002j9-9j; Sun, 27 Oct 2024 21:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1t5F1J-0002iW-K9; Sun, 27 Oct 2024 21:58:13 -0400
Received: from mail-bjschn02on20701.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::701]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1t5F1H-0007Ma-7m; Sun, 27 Oct 2024 21:58:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBjsj5x76qzxc4RXlu8v7SwNOyfGtVlW3nfZcdS92f8UjeIxTxaAFCPj4w35VfIWJsOC8Eg7P3sWzX+6LWGm0dpQJ2lo3eiOK511fBd8KJ93oSteL4VNxL47sdUmXh0pcKyO4VFhCQqoTptmLJxVK5rI5ReNIuaypan/abdzie1NbTp83/eAj2jN4/HBQ41GMP+dxOMzBuStqsDkDwWLVKHAnPo5YqA2Qon8RObWydvzZ/9mxuAJHgQIKQxX3mZVIrOuLCs6jiLVqgmJTKwtvrywCMLUy8+LwxAMcIJRB5kUjpHUb0evCiYF0Sd60ifSqtXTKs84KLMUjsrkWRYYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fPW30fFjE/k1eO/ph9yi3bh2Xv0XN2n6KIsgPeMtOM=;
 b=JrxBGwtrlEqSmt8Shal9hAkrHVDyzx3yqZ4m4tIRI0u2xrn8sm4ZWnufamAphgijUfB2DF1qudAUf4Hq1KiYCk42LhEywJ8R4ETl4zh3p/RUcBCKQy1CXSmUZLghRKfU5fm0AjmqG/zY9IA1wdMFGL9rSDwROxD9E/UxPYPE1jw9CrRyJ0jFGGPrUZPPUHn47Tjj+6YrbswzFRd+OF1/qHWRLPBQ3Ygfuj2pbSdCy8CLWhZG6WLXvQOXR8Sz5rmVyCmpHNmXD7vNrOaqFYW6n22hoFRJWY4jrx5LftI9YG5H4nzH/O4Z2lMQsVokR9HsS9OAYZA5O5vWq2vCns7leQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1263.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:58:06 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%6])
 with mapi id 15.20.8069.031; Mon, 28 Oct 2024 01:58:06 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, maobibo@loongson.cn
Subject: [PATCH v6 0/3] Upgrade ACPI SPCR table to support SPCR table revision
 4 format
Date: Sun, 27 Oct 2024 18:57:41 -0700
Message-ID: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1263:EE_
X-MS-Office365-Filtering-Correlation-Id: 6662a863-74af-4b95-6be6-08dcf6f3f723
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: r/YpCqdZgpCz03nFNpr4o1hM2O/Rhwgh3+Uh6V1RDHhaZC3gyHj/sOYvUwhVJL2FiugsNnWx8kJ5clXBh5CguO1vaTTWzLHpOtJ08/bsGNuR2QbDxrR5b5LWScxazeHLQfM/gg1oLuXyexqz2cc5APNUMu0suoVCJ1Y0sB4bKvBBCByLe9+3iQUC00zM1Cke6DrJQPfR9Kv13Q8oORgrUv+keJjs2k5YRPSPMsM9Y0jx8sakUCDau998gd2f35uy04rx/xtRAqxP42q9egaDblsq4PhbzEN/jzdPh11WUNi88jFLMpqEBRTOm2FBvazZm50IaBgV42i/ZewSr+oJuCe+bBiJSgQ1I30Plt50xaiyMxL9Xmuqnb6WA43fdR5jj6rMMGwxpmaumPXWO1g7GjsGudZ9vuCm7W48mBosz4dZjg42VbfwjQKyYbDsD1CF/NOKC7i5tiyHYLqaTr8CCG0k3CZflk9eVGTjTLGFjZtbAq9I1G5lERXky5I8RmHdBh/WVT10mV11ED5U+JaIBCeTblgY4GT49ECjbCo5YUiJDYOJRKo0K8oSCZm3jc25cDVlBblvHVLKT1Y6xUE0TzljHUDLRarYAcvmKiZJs4P9Cz0Y87YSNpK0xyZYa+C0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I2+XwClAp+jvjoiW7IbCweUk8h7zvS17UWA2AS4L1LejmQ2Gm4tpkIUC8Ht2?=
 =?us-ascii?Q?BOweLKMiCf+gtrEfDo0bTmHR+bLupm1LhG/Oy8ngBTOlUiBdUx5D0K6LDkhZ?=
 =?us-ascii?Q?AkBb6KqhF0fJXPVjRrl1DUgI48VgPAO1vv7nu7KJeGXUYmCDRZQjH8vCyfg8?=
 =?us-ascii?Q?zgZqQLuWeSvVcjxUn+1PGLHHDa0zKs7/IiJFqXUzkoQxaILYeu43YXItf66T?=
 =?us-ascii?Q?zjFIBuj+/D1nuoeqsltxU99qHVavtwUeCdbA8RnAJ84omdkdc78H2qBqw8E5?=
 =?us-ascii?Q?BCFk88SidqcDtjbIgwGO0/x2qNrrE9Rf73do6C+oszU/JPoiK5k4eVraY7sc?=
 =?us-ascii?Q?zzukSS25Tjp6hMSm9UacLJzPnCou4G/Ok4bkgRTk2q2ihtXFInBV9cGpc2fy?=
 =?us-ascii?Q?yqUbXTjSCEF3+/RZe69naAdj/doKVFdC0QRITCRfULH+xMqIiqu2M8i0y7jF?=
 =?us-ascii?Q?ozH8KfZUsOzAxkNdOOikaQUqCJQ8kE5nDvfmDte0z0JQrVX33lBba4XMUdp5?=
 =?us-ascii?Q?jDfejtIHwisL+mbIwp/RqsmrmSVCRrB236oxSdBPL0qep4fy7xKS2TDRdrZD?=
 =?us-ascii?Q?sby3P/pRqK8aQ7e72R3Q/8+6oR15eZkj9xkL+57XlchEl/hyvHfksAGZqTN1?=
 =?us-ascii?Q?Z6Y6N7yUduIhBoJzSGi07xcgg4RizhNkhFPY7LNerkq5V5XkQlo3+kbYQ9yQ?=
 =?us-ascii?Q?Gmuv7zwcApPPLzBbfavEniO64btlOhPpZohGE08haJ6iPD5P8nVJLqAa/z4S?=
 =?us-ascii?Q?UbJjNPoDDFE10iFanWTSmRtKlaK5TWw4RLHytZACi31aq68glPSVsUj6Lqfp?=
 =?us-ascii?Q?cOa2Ucnqumd1MUx+5KwqCJrG7puVMosPr5yfWvuAKbyv0mT9Duj3T4QPugfZ?=
 =?us-ascii?Q?7zihVxUIvjku1fsoZ8pJPP1rlyL6zomX1mtDpg5o4O4a3w5+r8vZDJQTkbKD?=
 =?us-ascii?Q?/G6dHMhZMSvYLChYdDQnhSU0i9ln/XQYwnaGfmZlknIWIJvzg2zL9kqLoBoW?=
 =?us-ascii?Q?VwoX0RfYz/7LwPjB3tn5Qi00vh/c8ycof9MzOIngU5nByzd9/Z4DT+PkO+rX?=
 =?us-ascii?Q?9YOr0toZSkZFzLZeVjPZkCmOHZNQHqpQu9+RT37n6UEvzABMBeKME+rHJiC5?=
 =?us-ascii?Q?qNnY7hiKWpCF202WAHvQfWdAihMHMT31hsGujx7N1RsgZCip6bcKkj60PLdr?=
 =?us-ascii?Q?xq6HZyZ8/wSBFErthmqGveJEdXeTkSbLip+R0HqXqsu3LAStDlQHOxG1riVk?=
 =?us-ascii?Q?O/qR7mx8+agnaGy+vrBbxA3OXtjuOsfSb9N+MZjEZCEOpTAJ39nAKbRl8AHY?=
 =?us-ascii?Q?fQnk/vOHbFWCPYzM//wucBAzI/bFcWOzNW1i0D8qw9HuFXJRkUWviXjZlgvP?=
 =?us-ascii?Q?f41Zt8JvTzf+U71Vqmqz1ndaqPQhoc/k9qsklNHtUG6yEDmUOeV9K5W+1ysb?=
 =?us-ascii?Q?5Kobh+cB5i/ur1sPjh52qRAXHthbxWsgulHPXV8QQBNUgdW0AZKnEuepdM/p?=
 =?us-ascii?Q?FBDDorMU36vibN262w28iH9Iop9xzNwH1E5XGExBjgBtps9WGdQzRmcbcMkj?=
 =?us-ascii?Q?dtl7nAe+PXC3JUEGlV6NHRGpRbraZIbpFzrRJ82l5Ae5rgw5iTOw++wj1+Hw?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6662a863-74af-4b95-6be6-08dcf6f3f723
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:58:06.5472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6vIMLWnWFW8MKM/9gtzqqsAk7Yp3MUffMaDPFAxhq1O/JBHaP5XZRAyRI+dGBrHgcpsteS2FdItRiWtIqGc6Rns31l01liDMT5Ir5Ee4WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1263
Received-SPF: pass client-ip=2406:e500:4440:2::701;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
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

Changes in v6:
- Added Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
- Rebase and update the build_spcr() function for the LoongArch virt machine.

Changes in v5:
- Reverted the SPCR table revision history for the ARM architecture.
- Corrected the output of the SPCR Table diff.

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
 hw/arm/virt-acpi-build.c          |   8 ++++++--
 hw/loongarch/acpi-build.c         |   6 +++++-
 hw/riscv/virt-acpi-build.c        |  12 +++++++++---
 include/hw/acpi/acpi-defs.h       |   7 +++++--
 include/hw/acpi/aml-build.h       |   2 +-
 tests/data/acpi/riscv64/virt/SPCR | Bin 80 -> 90 bytes
 7 files changed, 42 insertions(+), 13 deletions(-)


base-commit: cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2
-- 
2.43.0


