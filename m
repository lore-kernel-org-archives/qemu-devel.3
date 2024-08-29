Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE900C7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 02:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjURz-0007xY-Dc; Wed, 28 Aug 2024 21:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sjURx-0007vW-H6; Wed, 28 Aug 2024 21:59:49 -0400
Received: from mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::728]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1sjURt-0007Ke-S2; Wed, 28 Aug 2024 21:59:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFg1MLjReFMvqxsi9tE3ixBuiF+132sXhjHfPGU8DmpiC0UazWiVsRJX5eqeA0WPSKxWXvVN/25lhHI5viGnO+EhktZOWLqGyB1FSsoglPjLoKYE/3Wcn4XAdxQdXAp+SHEpvgHLANMUDaBxxpat+r8Z5oUZzNZkIUk6xgBfnl2272toSu7EBO8Q3bc8ZaVuIUzftS6OS2JBEHKlqvr5JHcK75Hm1EVZ8mY/wvqQrrvFXxTsUv2UadWE6SdqL9psy1bn4Go5Z3CEcQ8H/KlYiMeA+WwZ8J2pSUjs1aGZAJzjxowBs2g89gz9DcCzap7+zw4L3po76n+QyoBtU5DzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF0DtykSdpCGYUbqbJWwhRSe1eIqbIfCohYWbGtyMyc=;
 b=DQiV9M29wKM1cgAjqQK+Wu6HJRUHK3pf0Jcalk5hD/DPGpzn5ZxAGvtYPNSlfyju1vhgElBZz+Ktk2sYobJq2S8N2NYDPIBVIxisXeJNSXKuzQQSKt0+n+DuNsO8LDfeygVeftMyEM1JoC1SDKMHcRYQ605Bpb4jORiT8p1loWOu3enca842bgU0wowVKRHQXeKlClVr8pPl4owWN23Q3tx2owGRGW6v3CzwEPDRsh1I8OfwyLhsTUtkizPqfGter2NFxneQrZ4frM98BLK6jUK1tY3JlAhapbBA7+C+h6NV6YB6XEpo15vZTzKaTJEZR1f4oQhFQbL2NLosflr8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 01:59:30 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::affa:7fe4:57c8:11ce]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::affa:7fe4:57c8:11ce%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:59:30 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v5 0/3] Upgrade ACPI SPCR table to support SPCR table revision
 4 format
Date: Wed, 28 Aug 2024 18:59:17 -0700
Message-Id: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1021:EE_
X-MS-Office365-Filtering-Correlation-Id: cd67b7fc-cf4a-46de-35da-08dcc7ce3843
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: VUPv0DZ6NfnRNp9uTtPG2OX7Evh4OHnCx6lNetKlNP4DGjM6tYsivltwkhCBlj59G33p/VhDZ5dOrrG5koSfASZ5YnZZ72Joy9N++2PlqBwtZkbMaPmCbRFjP9T9Iko3KOzVIuVGlUk+LReykJwTh4QCjhHqoFcRzImIuQEYWQnOUELjdwWmkfLBXeFfe99uniMl1a9XQTDiLRLmr2X/VpRP2kv8djvHspqNc9AcFG9eh16hoAmaf8aUGIxTjRKRHcpiiYoWF0cmsSAn+I4Aug6aTR4hen7Q6sp9oUwSYNqS9iap4hpI+SgQQHzpn0bthDRN2sJhqWu5JtCCALGRgoMfLL4OGcmOzZb8BSwIYikeZr0qbkg6oSESWJ68N+egftAHMp23p0njHDYRq8G2Du0e1FHzjqCGCiErOty8Qj3aOcXWhVy0yJU8LWGbGczcqqX2DfQayxNqsIh85hYb5SaJB1byWbyByObTl1cFVJ7emmAd07OL7Lpwfp+wdY/HQ3PDa9e3VaU2Rsu6wTM7Xy9AQQmhrEnldFhdnp5osiCS+TprHSYVCiphlhOpabJauWEfQ/GeY3TGzgVnmY7cKORUXWwohAk1QEYJBInsERIKKVwymyuFElB8dbSzKt8r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1wNMH7stsm/jIPm6O1u8kxEHqgDZYro15aQtktik7YT/UAm/YvmrfJPuGa9?=
 =?us-ascii?Q?Nmpe/6kVGfKE8U5XqAN6M4RnFmwpVgmZlrS22Qdp+3dlzDSWnH5uv2+hGqDS?=
 =?us-ascii?Q?yh5gZuvyy70D/4hAp36N6ZyVE21kGiAO5kXDivbUKyW3m2ajixuwE4/1q30F?=
 =?us-ascii?Q?ldi1IxmCnFjZ01Gewh9HFVAc/ioDXSz7AkIA9TxlzIzko/8EuagxuHY7MA1d?=
 =?us-ascii?Q?btUuJ96he62dssaV1I2PpuyaXdpndCrM5L+M1SHb9LBnWv1XeBvg1Ni0LzjJ?=
 =?us-ascii?Q?qSZNDfODffw/yYRH9Ip9vah0N4x6stYbdDxsrn6hS4lI6psrRNXotWCEUGrc?=
 =?us-ascii?Q?fbx1OZrV4KWMAGTAlcCtIb8KJ/IRXfb1G11Krp7krODUoKEdyCtgqz2Q/Of3?=
 =?us-ascii?Q?WR5DqqynWPCs9EBjN16WGglVW0hrA/X3eH0+uDC86yzgiPUS8p09lGmlcACw?=
 =?us-ascii?Q?WvHD8mvZZns0WM+TlsbjiqlTU/gBtCbgMryGw0+HURJYRrQGwNFTUnG3zVP1?=
 =?us-ascii?Q?qreUjwsyZlt0DQ67rJHrIT7niGqa3gGkvLJFHmc+kiO9TJZ79ja3by8zaAtm?=
 =?us-ascii?Q?vIoVB3evpvDZD32mWGggnhfCT76bozWlrwWITSi3XeXH5skaXGCebK7ndE7O?=
 =?us-ascii?Q?4N/cw0DgrUc76qJmunBXsERIyyWLcx1v1EMvWXo+QQlZnOw9zQfna0Vz38uS?=
 =?us-ascii?Q?kd4LrBj1RD1RR2WTZz3ljALlBORzl6s1Iu/murk50AJiOgDcpFwdK8AfhAmy?=
 =?us-ascii?Q?J7fb3VmJ/Hpaocy1EngrUF0Jtau1r7awfeuSI5QrYmhkSK0aWNjT/JIsywLB?=
 =?us-ascii?Q?lsP++PENpQ2KQYFYMDv1V1FMez4aB2y44jksfWoO3HBFtgPb1MqfQpXJDLBr?=
 =?us-ascii?Q?DPr8K1XSIeGiyhhmsh5RzOs8x5H4RBpU1xhbzo0KUexrIeVg5nRFbufIENFf?=
 =?us-ascii?Q?PdiEhW8J/3TGs3wCarDdrIShsD6NR2zqCCbftyixedeADcR1sE5TcEgYHsm8?=
 =?us-ascii?Q?LZ+Miu9jD0G2XBWdX7YY+sLavLkaE075emUDL4lypQw0svyYBn8yxAkrIeo/?=
 =?us-ascii?Q?JzSKPMBWpBVcN8Bv6TrVMtyYoW5WMUi1GOnpWVmxv/+C+Elh2Ti2WohIADZH?=
 =?us-ascii?Q?n7Jf4W5IfZ93nwDdrCLrc9aLaaPD63omSSJXqlQ1J06GG2R3gutELi7idxsZ?=
 =?us-ascii?Q?lSLutmv/WCgqKv51rzJ0JGcSFUrUnar7jNRaZQYv79vJ7BOLuikf8C+egAiq?=
 =?us-ascii?Q?j374XRJpjYO4Yrv+Yr+2JPqV+M2We8XeDfdUNlEWRRdNuScdmgVl0mg22HyM?=
 =?us-ascii?Q?Obw4XZYGJV6wAIdfiH9Iz2RAu/3wGeC1wx+6mBcusReSrO+zldIDFRJbpXCT?=
 =?us-ascii?Q?t+gdyDaZQSflBpq/Z3pjhzCJaIfS9YYlaPBYo8gqZGhnyce8ZGPJ9Erdpo/y?=
 =?us-ascii?Q?0qJaxVmp1+Ct3fAZfGi9U25ptfq/K0BjUMzcnOoELcuZ9pr974BP6dvGz5Vu?=
 =?us-ascii?Q?N/727jYZ5p4NP782/E0VkZcO2ufExKezXZspBQdo3PPTdCY2evCfNhkArtAl?=
 =?us-ascii?Q?oHfUUIaL7g0Jyg/XpPNvmeZpVpPlW8JnUQV8WVO0L2OiuJGb9lB2vC4zYQPJ?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd67b7fc-cf4a-46de-35da-08dcc7ce3843
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:59:30.2560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrrdJNV+4mfplYdpGB2Mwsxv4UiEDo3RoeTuzwPNkHhc4hV4vACvrJtqBPFTw2aefkNPApsexocRM/OukFZ5R5ErB3YgXdn29U5CC0ZZMW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1021
Received-SPF: pass client-ip=2406:e500:4440:2::728;
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

Update the SPCR table to accommodate the SPCR Table revision 4 [1].
The SPCR table has been modified to adhere to the revision 4 format [2].

Meanwhile, the virt SPCR golden reference file for RISC-V have been updated to
accommodate the SPCR Table revision 4.

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

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
 hw/riscv/virt-acpi-build.c        |  12 +++++++++---
 include/hw/acpi/acpi-defs.h       |   7 +++++--
 include/hw/acpi/aml-build.h       |   2 +-
 tests/data/acpi/riscv64/virt/SPCR | Bin 80 -> 90 bytes
 6 files changed, 37 insertions(+), 12 deletions(-)


base-commit: cec99171931ea79215c79661d33423ac84e63b6e
-- 
2.34.1


