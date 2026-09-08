Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB96CC79FAD
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHb-0007yQ-D9; Tue, 08 Sep 2026 06:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHZ-0007xU-LX; Tue, 08 Sep 2026 06:42:29 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHX-0006Xy-Cu; Tue, 08 Sep 2026 06:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRGvnJ6Vskog5BoDLnVj/kQVVhlNHO1a4tAcsgJO9RwOLKojQVcBQpULsUqjcU/dFsLd9aOdxHZXSWMATVvV03Nli7TjAOHJ+5Ur4gZm6Ughc4gegLQ90IvuAKWyzxn8vSx4StUyL07RscZEPcCmL9t4vVexdCXxnwNBQk0fZLzsQcQa+uOQJi9z22IkA0r6hBPvcq5yOwnD0dtouXPSVwKUeZpuJiogq2mUbk5W7KBZAh6sep6G/S53JtYWzW5lewtcFiFYjHhgTX0pC+R7WsZ17sGRTrMjpeImGsLqyMIgmQUGfXQSnG0bJh0BikbA9/sCkATWRncOq36uQHI46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foGJkyLDTpCcvVJWwhCck5b/x3gfjMJOHNHazHOiXpk=;
 b=nDR/RKTkI8iprju0jyRMNEG4jp2yCBNwb0vnabBU01GChSPZJqvfw8VmYfIm+NDiliabGdd5HQMeB7SC5c+pa0pW4/gph+14zChN3n8PJWI2pcKunPzHErEXhPzIemj2ZEbmLt+Sy5gU1Ag2nX9d2Y7bVpRbDv9Sm8W+Ye7jBofUXtWL8SmN40MjbXMA+ATxiGsyjcyTelt2JSPLnHkx9DjV5fwoL3W4PNtecjsArImSwBlegv6rVQ7exv3r6bVFUPQNCK6uM69tt3R8htA2gvhHhz60C/g0Ls0+Xe5WbJOB3aWNWPa61wtWwPxJDeOE5GqrXcLv+pN+6I0XUUucWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foGJkyLDTpCcvVJWwhCck5b/x3gfjMJOHNHazHOiXpk=;
 b=M4hTRm2zRNbDD3eV6DX/IN2Wwv3REuujhE1OT64Shf3sy8gTo1AtE0v+l2G+eMHWzfPjHUgzEiEybqVBcVvBkbNuJaHmks9GdCN3tf6HNLYMlSgoyHzobwSZL0WGcPxl2GsvdHApTBdT7MSimtijjczx8qKpAJSqIrWWGi9JWhcWavBCrUVELRABw6zsaaHDQcKhh5R3htKvGuf6AkFf/fHPocy+qjTnIdu9QP3mBeIeAwHlS8f/+jKcrdzl+lznYs5Uumgnt3mMe9J2Y92ZiM6QxG9mYfqSxkynMfZ/BDs3bJ13/G9wgYlbqi0Lvpnvo+ObQhS4hlppe2bvH00uqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB8780.apcprd02.prod.outlook.com (2603:1096:101:2cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:18 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH v2 00/32] hw/arm: Add Phytium E2000Q SoC and board support
Date: Tue,  8 Sep 2026 18:41:09 +0800
Message-ID: <20260908104159.1621764-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbd510c-ba01-408a-f051-08df0d95daba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: oJNNN0b7r9+4OzlDKoOwAb9HaV4117GUqqYn6Wg4DaDCo1HvMUxrkbejYiL++5xtUmKa5kZxLyfXsakP0teYbtGn+Gj+RDnwvM+iqSBfwvCqJ+QLuRq0xFWf6JhW6l5/NfLdZUy/4b49yRnh2ZHtqZd0Hf9dd4W4mM9eoOaMawJNWB204XAY0KYg9UJd6GGuLNbHyiuNk4Iz3GgmJ76s+leBL1a23ifsvMwOC9NT7rydHOOAkfnXEm9MZm2SFaQtbVWWlbPqHsbMo1sMc5TnfxN6uA4231iWj3ZXjV+gCF+Z2S+RcGeQlDPTjgQBorpJ+bbFGEpHpkBHUz8wAzIR0zhtI6EDP0tT7vljePYmTTuQlZNzys8FIelA5AWZuHn/KU9DZ6rwpY3TTG9jh6VGTrexwGQZV6a5s3Ss0BDPtgEYL/+3foX7tK4XoWLENkqfj1u+t2Q9+/o4KUYY7LqV0nXreL8Pr2pwgRX0JB4sVDE7Xul9HqUORCdkdABCuc/9KtyoNZNFGmh0g4O6L3GfbrurqM+gRo1zVsMKSAS8UMb/NZlTpg4Vu3b4AL5qL+TTFHOJsPRP239kW3NgOkuB5mBI8nAlEMFNZHsSsFua6w3qLkLLMu03Px62rN/uvSC7yuvXOrcCtSIsPFIcwiKW6lyYmgVhrPb52jABxp+KUK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZxY1ZuRldERUxkZXZtdThKbzZtSGxHOStXMHk3dGtvV0o1WU84RTdjbGVZ?=
 =?utf-8?B?YnoxSU5uV1d5bDRmUnlSNmF5UXlRUnBFTVozRVhtVCtZU05vOFliK2kxMitj?=
 =?utf-8?B?WEpoZkJjeTJ3aHpkdUJrTzVLMldqV09rRjh0VHZMWHRORUhBYWx5TysyQjNm?=
 =?utf-8?B?YU9LWXpteGgybGlFNTFrbk5RUitLYzRDdVoxS05GcmU5b1V6Y0ZkeDlCY3E2?=
 =?utf-8?B?UFU2cVdWWExnZDIvakJMOTBLcUZDcDNvOWNacE8zcHJseEZtNnJwclJrT1ky?=
 =?utf-8?B?TWdROTQxR29KMTVGOTYxbGRPdldCSUdHTkZrcEllSXM1U1JFdkJiblVCdy8v?=
 =?utf-8?B?MGM5anlmdGR6NzdyUmhCYktpMjVTOFljU0toamQwMEl2RU90WnFLVWJLeEVQ?=
 =?utf-8?B?UkJpMlFKQitVSmxMdDNnWlZpdlVpNllHVlBPdmhHOW9UVFVKT0ZBb3JpaTR0?=
 =?utf-8?B?VWZZT2hURzRxd0xuYTFPQm9RUTdzYVlVZUh4ZHJsSm1admxLS016TXhkK1ly?=
 =?utf-8?B?SXpNMWl0Q1Z5cHdwSzNadndMbWFldU5oRHpZc21VWkZTYkpPeTJYRjVlRXg5?=
 =?utf-8?B?VkZ3MXRiK2tVYzQwem1hTGt5VWd2Y0tpdUpzaXF1bjFtR2tXRGN3elhnZERQ?=
 =?utf-8?B?eld4ZWhSSUlRQkRSSis4NmkvOGd2RkJLR0YxZVgyTUYwSlQ5b0NCVHl3Q2ZG?=
 =?utf-8?B?VXhvUnUwRmdYRzN2SzNSdkFXckk1Uk9vVVhJMnpLbm5TZXdlcUVKNHVGdkxI?=
 =?utf-8?B?bFYxdHJ0Sk9odjdkVEI5OFE5Ni9kWHBhV2puU2gvaytBSzljSDFSRWs3N1VJ?=
 =?utf-8?B?RkpZZkVDZEUwdmxLbE1qWVRwdm0vOThjMHFDRTZhS05vRnlsVnpIWVdVYm5G?=
 =?utf-8?B?c1NGUTFUWk9vMVp3a1FUQjRVbDRpMFZHMStEMElBYk4rOFVTeDB5VG8wS0R2?=
 =?utf-8?B?c1RKMEhnRTZuYzFKamFFd2cwOFJtam0rd1BhS2NXeHFMOXpHWlNWMHI5NEIz?=
 =?utf-8?B?clJScVlmOHM4elMzVGl5Y0VvYzdQYlZuZDNVT1ZDbDgvLzVycS9HcXlOcGFr?=
 =?utf-8?B?Sk1uWEluVUdUUmpScFNGSWJxbFZucnZQWWREMlNjUFdQbDRhbG9zUXFTRytj?=
 =?utf-8?B?bXpBYk8vNUxVVlJtbTczeUd5UXNKcURhZitjWHhTekVQUUlRNVlQRFlOa1p5?=
 =?utf-8?B?TTJKM1prbUVmb3dtdWZhT0daeEwvajZIQjJCcWtLTCsyNWljLzRHRXc2QXBQ?=
 =?utf-8?B?R0dDSkM4WGkrTXdRUjUwMkFGTGRMaldMQ1ZVNzlqS1QyQ2hseHpnUk1pVmFo?=
 =?utf-8?B?ZUo5a3c0NjZNS1RRNHNJYllJVExhMThoR3BPTGE3ajBhWTUzczFoV3duenlB?=
 =?utf-8?B?MlV3Rm9BcUM5NDhHa2R1N0Z0cTM5amJLN090RHUrNm1lYmVpNmpSeUhIUGFs?=
 =?utf-8?B?cGhsNXlwT1V3R2RvYnlXK2ZDbmU0TzUrNFJiTThBSzJGaTkvRmJkMGRJbTgy?=
 =?utf-8?B?Zk92WEFTRVhGS3BWc3lRT0pQQ3ZWcTVrMGpwWlF6RUNIZFRQbVBRbTR3ay9W?=
 =?utf-8?B?cTJLaXFGNWxBbTl2UEpwbHpxbnB6N3R1ZGppc0t2ZWhXdnk4Y3Noc3JsMDA5?=
 =?utf-8?B?QjVMR0NJdWVJeDlRZVQ1c012YlVjUmYyYm9WaTNiRTJvR2MyOEkrYm1uNWRV?=
 =?utf-8?B?bnVCYW9sZVRMWm5CbTgvOUtkNEJPZjdEQTJLNzlaNEpQYWZ5TXZmNmk2QWgy?=
 =?utf-8?B?QWNIYlRiaCtJUG9pYlN4eGtpVmQrUE1KbnErQjRiZS9Ucm11cXlyVEJNUXdj?=
 =?utf-8?B?a3BlYTVCTW5mLytUa0E3V3E4SVJFQm4zMzRIUXBIWlNXU3dlVjI1b1Q4cXBp?=
 =?utf-8?B?dzFXZHVwRWYyTnN5c3YxcDdzcHVKV2Q4VjBFaitQd3c2WHUzUHdHYlY3STBN?=
 =?utf-8?B?eE5iVEs1UmlYVTcwU1F0Ykh1VE13dXRldFNFZEx2N2p3VVB3UDgrUEhwWXhZ?=
 =?utf-8?B?b3NYR2lySllCTlJJWXVDcXQ0NDlRa0RXVWlQQ1QwWXhiYWJvVURJaERmRGt2?=
 =?utf-8?B?Q0lIeXZnKzU4YUUxRis1UitLNGpPOUR2N01pSnl6Yzk4WllQK0tXZldOYXJi?=
 =?utf-8?B?NzFtRXVjOFdxczE1NFVkNXFtamVaeENFS05uUmJxK1pSMzYvcGFGTzdUTTlm?=
 =?utf-8?B?NjBQTXMwTFZtSWJEZlMrS3NzeGQ5OWYrYVpraW9VZTRrMXBwN1hBVlBveHEw?=
 =?utf-8?B?MXZQcXVZQUJTd24zRG1KNmpPTzBzbHJGeEhvSGtGS2F6MGVCaUU2OUZ4SzJ6?=
 =?utf-8?B?QU9GdzlLVFA1RVNGclNzWDB5RnBNM21rTHZoR1FUQXV3ZCtCRUdiZGY5c2F2?=
 =?utf-8?Q?jSChJ7m/q0NyrHzc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbd510c-ba01-408a-f051-08df0d95daba
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:18.2844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hscj6RgbrrBEwMejN3Wo5bD28sh+2bi93MLiuo+e+63xEx4ToJCtiT/sl8FI0bF5QpRjCde3yycbiqrRYCMlh5gSCV70k4k851BCABBDdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB8780
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


The Phytium E2000Q is a heterogeneous Armv8 SoC with two FTC664 cores
and two FTC310 cores. This series adds a reusable E2000Q SoC QOM
device which owns Cortex-A72 CPU children and applies the FTC core
configuration locally. Two board machines embed the SoC:

  - phytium-pi, with firmware and Linux on SD0
  - phytium-e2000-come, with firmware in QSPI NOR and Linux on an
    AHCI1 SATA disk

The machines support the vendor firmware path from the on-chip
Phytium Boot ROM (PBR) handoff through Processor Base Firmware (PBF),
TF-A, OP-TEE, U-Boot, and Linux. They can also directly boot SDK Linux
kernels when supplied with matching board device trees.

The PBR model does not execute undocumented ROM code. It parses the
selected fip-all.bin, validates the PBF, TF-A FIP, and platform
parameter records, and reconstructs the observed handoff state. The
MHU model handles the private SCMI power-domain requests needed to
release secondary CPUs and exposes a separate Base-protocol channel
to Linux.

The E2000Q SoC provides GICv3/ITS, UARTs, GPEX PCIe, SMMUv3, four
Cadence GEM controllers, two DesignWare-derived MCI controllers, QSPI,
I2C, xHCI, AHCI, a random generator, and the firmware-facing DDR and
control regions. Board machines retain RAM, firmware media, and
storage backend attachment. Unimplemented register windows remain
visible to firmware without claiming unsupported behavior.

Functional tests exercise both firmware and direct Linux boot on the
Phytium Pi with an SDK Buildroot image. Manual testing covers Phytium
Pi SD boot, COMe QSPI-to-SATA boot, all four CPUs, and network access.

Known limitations are documented. In particular, the PBR handoff is
a behavioral model validated against the available SDK firmware
samples.

Changes in v2:
- Use scripts/git.orderfile when generating the series
- Configure FTC cores as SoC-owned Cortex-A72 CPU children
- Keep Phytium CPU configuration out of the global ARM CPU list
- Explain why the Phytium machines are restricted to TCG
- Reduce the DesignWare MCI register migration state to 96 words

Bin Meng (32):
  hw/arm: Add Phytium E2000 SoC and Phytium Pi machine
  hw/arm: phytium: Add Phytium E2000 PCIe host
  hw/sd: Add Synopsys DesignWare MCI controller
  hw/sd: Add Phytium E2000 MCI controller
  hw/arm: phytium: Connect Phytium E2000 MCI controllers
  tests/qtest: Add Synopsys DesignWare MCI coverage
  hw/arm: phytium: Connect Phytium E2000 GEM controllers
  hw/misc: Add Phytium E2000 DDR controller
  hw/arm: phytium: Connect the Phytium E2000 DDR controller
  hw/misc: Add Phytium E2000 MHU doorbell
  hw/arm: phytium: Connect the Phytium E2000 MHU
  hw/ssi: Add Phytium E2000 QSPI controller
  hw/arm: phytium: Connect the Phytium E2000 QSPI controller
  hw/misc: Add Phytium E2000 PBR model
  hw/arm: phytium: Integrate the Phytium E2000 PBR
  hw/arm: phytium: Add Phytium E2000 control region placeholders
  hw/misc: Support Phytium E2000 SCMI CPU power control
  hw/arm: phytium: Select the Phytium E2000 PBR boot medium
  hw/arm: phytium: Connect the Phytium E2000 I2C controller
  hw/arm: phytium: Add Phytium E2000 xHCI controllers
  hw/misc: Model the Phytium E2000 random generator
  hw/arm: phytium: Connect the Phytium E2000 random generator
  hw/arm: phytium: Support Phytium E2000 direct Linux boot
  hw/arm: phytium: Add Phytium E2000Q COMe machine
  hw/block: m25p80: Add GigaDevice GD25Q128 flash
  hw/arm: phytium: Connect the Phytium E2000Q COMe QSPI flash
  hw/arm: phytium: Add Phytium E2000 AHCI controllers
  hw/arm: Add Phytium E2000 Linux SCMI channel
  hw/arm: phytium: Connect the Phytium E2000 SMMUv3
  docs/system/arm: Document Phytium E2000 machines
  tests/functional/aarch64: Add Phytium Pi boot tests
  MAINTAINERS: Add Phytium E2000Q machines

 MAINTAINERS                                 |   18 +
 docs/system/arm/phytium_e2000.rst           |  422 ++++++
 docs/system/target-arm.rst                  |    1 +
 include/hw/arm/phytium_e2000.h              |  120 ++
 include/hw/misc/phytium_e2000_ddr.h         |   23 +
 include/hw/misc/phytium_e2000_mhu.h         |   34 +
 include/hw/misc/phytium_e2000_pbr.h         |   62 +
 include/hw/misc/phytium_e2000_rng.h         |   23 +
 include/hw/sd/dw_mci.h                      |   75 +
 include/hw/sd/phytium_e2000_mci.h           |   21 +
 include/hw/ssi/phytium_qspi.h               |   23 +
 hw/arm/phytium_e2000.c                      |  958 +++++++++++++
 hw/arm/phytium_e2000_machine.c              |  388 ++++++
 hw/block/m25p80.c                           |    1 +
 hw/misc/phytium_e2000_ddr.c                 |  197 +++
 hw/misc/phytium_e2000_mhu.c                 |  818 +++++++++++
 hw/misc/phytium_e2000_pbr.c                 | 1366 ++++++++++++++++++
 hw/misc/phytium_e2000_rng.c                 |  182 +++
 hw/sd/dw_mci.c                              | 1382 +++++++++++++++++++
 hw/sd/phytium_e2000_mci.c                   |   95 ++
 hw/ssi/phytium_qspi.c                       |  398 ++++++
 tests/qtest/dw_mci-test.c                   |  417 ++++++
 hw/arm/Kconfig                              |   22 +
 hw/arm/meson.build                          |    4 +
 hw/misc/meson.build                         |    4 +
 hw/sd/Kconfig                               |    5 +
 hw/sd/meson.build                           |    2 +
 hw/ssi/Kconfig                              |    5 +
 hw/ssi/meson.build                          |    1 +
 tests/functional/aarch64/meson.build        |    2 +
 tests/functional/aarch64/test_phytium_pi.py |   77 ++
 tests/qtest/meson.build                     |    1 +
 32 files changed, 7147 insertions(+)
 create mode 100644 docs/system/arm/phytium_e2000.rst
 create mode 100644 include/hw/arm/phytium_e2000.h
 create mode 100644 include/hw/misc/phytium_e2000_ddr.h
 create mode 100644 include/hw/misc/phytium_e2000_mhu.h
 create mode 100644 include/hw/misc/phytium_e2000_pbr.h
 create mode 100644 include/hw/misc/phytium_e2000_rng.h
 create mode 100644 include/hw/sd/dw_mci.h
 create mode 100644 include/hw/sd/phytium_e2000_mci.h
 create mode 100644 include/hw/ssi/phytium_qspi.h
 create mode 100644 hw/arm/phytium_e2000.c
 create mode 100644 hw/arm/phytium_e2000_machine.c
 create mode 100644 hw/misc/phytium_e2000_ddr.c
 create mode 100644 hw/misc/phytium_e2000_mhu.c
 create mode 100644 hw/misc/phytium_e2000_pbr.c
 create mode 100644 hw/misc/phytium_e2000_rng.c
 create mode 100644 hw/sd/dw_mci.c
 create mode 100644 hw/sd/phytium_e2000_mci.c
 create mode 100644 hw/ssi/phytium_qspi.c
 create mode 100644 tests/qtest/dw_mci-test.c
 create mode 100644 tests/functional/aarch64/test_phytium_pi.py

---
base-commit: 35500e5c41aec76cde59befe750600dac7a9e37a
branch: phytium

-- 
2.53.0


