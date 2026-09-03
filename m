Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A2DC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25a2-0005S5-Vg; Thu, 03 Sep 2026 07:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25a1-0005RX-CF; Thu, 03 Sep 2026 07:26:05 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25Zz-0006f9-C7; Thu, 03 Sep 2026 07:26:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pocKVfXaoPlFr8CeqrWrhQZ3ZFk+ho7Z4rshmI29UJ57mWsbvFEfR1iho34sLJw8jaGFTIsqkPvwlg634w9XyGKRwzg7a/1kkS83mOnLzpeW/7TrVgmL++hPprw2k7afzsdCrf6L+WOCZOfpRVnN3hlvoodTJ/hZLv89vFI7v839cBN8Bz9d98o4dMZ2kPUO5JlRS6gTBhimQU6zutPyxo2FVWWF8UNfpT3349FCWZZp0ooMJ3qPnzllPyapFJnbD/cLUGVJlBZHvw19fE6r7osy8laTiLjO9u/m+bvm39hvNWqx8WpMkAUxtzx4jEYrj6i456FwBtvIEfmNqzVQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGl0nFEtB4Hv2akxR3miNbaQfL1ReN+n0H8SrA2wp5I=;
 b=baPS3qU7zDb6mBLyeYFcGiglaQ2P3uB3DQ9Y2+FLX4+i/3ZSoqrrRKsmzZYyw5GOCb3/h41H4nWWO3zlA2I2zaxhjtijaIxm4Cn7fiZtSh90ukLSE2i+5+iReX1RjfTvCy51Q5E9U36RYG82KTj94EundUnRRcp1glJMhdorIdOHJKIb5hW2sBlzCY8RwKo96KX1HdBV4MXNQPVdys4sItuGy/IOuVOFRcYwDRKd1OwPUqWCHXWjoZX+2iqEPFprYlm55kmQsWb+r1ZbKqI7Cwj2GP5RtdO2dMqh1tz5ticbhvzFwOK+8AKQrxXPyHgy35D7mK9D1KzMk//jPG3cow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGl0nFEtB4Hv2akxR3miNbaQfL1ReN+n0H8SrA2wp5I=;
 b=JGoDlpNUuz7pojagk8iB9fXZLC+bMFf+QxoVGdpsSVFbPsdcrAJSQP0H1lccoDa5Y5pKhheE26paXog1QbyNLtWOLvQR4yMRB58aen93gHlJJyR7jHCfX4Fxec5SLoxbKZotOEBgi1jXZESiRDkBSG08PL4NWGudhfb6rHQ6tnzuUabf2zBNM8WKMo1+MfPbZhcFCgrntkRfiv4wz9UYBd35KwYJYu3L2tDNg6EhprOsLiHAm1ACTs81S/Mj9Vth7TpQlDyQ/eM9pxQLcWIRohVIXeSJ2+pOKt1qnQirINvqndUv/wMAeloNYPrtbwunZw1LGn3MzB71U8MWAJjxVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:25:52 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:25:51 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>, qemu-arm@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH 00/33] hw/arm: Add Phytium E2000Q SoC and board support
Date: Thu,  3 Sep 2026 19:24:40 +0800
Message-ID: <20260903112532.3276678-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: e7aea3b6-734a-4de3-423d-08df09ae1bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: luBTQwvWIh7oB4hVFomEIT7sWd0cPTjMQtFWVcQVZSAmzATJxJd/j4jNM/1SM/I576k+SDoVLmUzrtctBVm+BnwOEW66s+V/2Hug2V+A8Yb60V39NXdjXzpHRAd0X9w4+MsR7YfdlmY8msB7YF5AMJ3iTmp2uurkF6YN6hJ4EHLQUNFsAKDi0qUowlYbwulHGUDZfJ27Qns3a/t/V74QJN82RDMIZFZP5SZDozYlAWWtQ8QeYfJVw5xkA7f8Gg4iIUa+DQKIIfceyGhrb89tsTmc2iKvnDy6FOklu/CaTPpNNdwYBW76NtbIzBsAPgfb+Fu4k65ehodDjROCINtAnY5scBT6ij1DkiJuRnhQ543OWfzFtQverGuRBDVs8qsro7DRGC3xAA+49Np6E3aRMC3VXvvQaOINc3YbBvYys9ZY+xJuk/H07GBt7eTDdNg/OjyC5myLQnWxiYix3EcdXuxBqG9PEGemxCtAu0PvDS5i9xdduXannsGNjc1S3fruTX/am/o3a3GaA+0X4UNzWvmGmUyp2Mg+RTAqIjKDFELSvSjjsHDjsQTQwND61iaKfPWpKMSIxI7AEyLKfO+QpDUlB65TK0+6bNrDUhtCjQeRVcPtO3fsQdPQ5+5v03dyVYk4BzbEf3TfyferF4fidzD79I+PlCFf7kQ25iNVwaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(56012099006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?McUoAKLjmHf3lAgZkghwYw/ngk3C1FDtPzTrnO+47rW/Qf816X0gFzTpFy9h?=
 =?us-ascii?Q?GdiZkyZfiyqjqrmeWO+Aaqoxw5nj51ASe7O4eVSXeOvJ2euQ9MbsSBNXNgpw?=
 =?us-ascii?Q?4coj6PdLYKn/jGUJYU5GPKGFGTWXoo32KaAunuFfxsQefxlx+oetJG0Kkje4?=
 =?us-ascii?Q?JhJ66io9m8E3bxfisvgNqA97bABbwfZZGRHRbi4A/S5Xs3xdDFgbOziXYnXB?=
 =?us-ascii?Q?yOGDShrv0ALPC+6Gt155/sWTeU9gbMDsLv8rv4J6rp6wsT6qVwT6yenBgR1e?=
 =?us-ascii?Q?BdLvLxHTvmPPc8eZKsq3nZESD2jWzwUZfYRQn18DH6IcC6zwAlvPP2ckwUbN?=
 =?us-ascii?Q?tMY0e0y7AY3KGVh1VmZq5EE3HGiUuNdoe4jQzX7K8z1GW3k7lUMDiOPNvA81?=
 =?us-ascii?Q?gLjC904eE+i2+j/NGb1PR18MX1VL42re12EUknOEzShQKmVJhzmrMnQ7tvv6?=
 =?us-ascii?Q?SK/TShSPA+iH5P+iMjcili9H72Ql1jzgrNryHl5gAUl2ca5jHXjPxesZDcia?=
 =?us-ascii?Q?WO9Zbavtw6o6JKTT/LwcB2JXJQzwYNEQ/tB4KmONjqqSPF7EJciYs9B6Dzao?=
 =?us-ascii?Q?ayP740Afj4F148dcV4dwkzHKDqMaC3g+A+H8weVNnxrOFUtr/hwBMjVc79iN?=
 =?us-ascii?Q?0QZKEKSP105UCTedgeLDN6HcjyDvKQD1aq7wapHoMAnhw+0amjFBhLlBxMzM?=
 =?us-ascii?Q?gj55UtyLP0GwuuMF4Y6fgJcbhgH2VtYWwcENs1dUGneCv+VGfuag4flnOaKJ?=
 =?us-ascii?Q?Ir2HFez1Z2a7ocn5gZUB9WFIIwTDi1t0i7tYmkESIzqC5jCnyyWVmAYl7vE4?=
 =?us-ascii?Q?YqkQlXWf5Z1r1DBRxNUXOe7qFw75YbW1IrrHqxRKoqeAFT9LxsvRDJ+T5kwx?=
 =?us-ascii?Q?63bhRazZWyzFQpkZoQrDHu5x9gXipS4GO+wwHRrUU2AyZnJ2vXhuBiAIbHuX?=
 =?us-ascii?Q?1Yq3UcqfV/wM/79FPx4iyF+hz0KGzNVLAUFECDw+e76smELoibkTVaZU8sQP?=
 =?us-ascii?Q?pmjOda3Y9a9xxj77HKGRgcxnnI8zpx5Sei7mJQJ8nlHre6AFL4TaIpNCTJ/8?=
 =?us-ascii?Q?SrSV4waP9Duq+Q6k4PdIdO5/g2POWjzeiz+lV6empMkDqbFiVrXwhkp1MpJP?=
 =?us-ascii?Q?DQWCnP6DCxh5NTyEpIyYKTEP+KO/4pakZRGcAd8FZPVeRa/MAasSlsIEEiZ8?=
 =?us-ascii?Q?ntcvewEM9Ng51lfZjTD5dIGyoDdVLsFN5e8z0qn6y5j5l0q+9Sd/sCjBFqcF?=
 =?us-ascii?Q?fL89U0ZaRNSPF0dFiCCIfUCHXRmNq/uy9UmdMa2pEuN7UtOHz0lMHXE6CRSZ?=
 =?us-ascii?Q?hLqAJzqunaCLlJ1ACDn9NwY3qNoIo2fSvd4IdAL0AkLJT8QDVrY03bus/CWA?=
 =?us-ascii?Q?c8kB2Jx0gZGylKckkyeBFckMyEJqocGSRjrOxrNMmDGRrmWiFZKY6Js53OKL?=
 =?us-ascii?Q?oQs2ky31DniGd8WUKW62ldGYE/Da5wCWcB883EjOirZAkXvgVAcfWSeJoQw2?=
 =?us-ascii?Q?eJi8jrauq1cmhaYaeNRHH31FzdWvoYmOoYy/nTP9kBKTlSMmCfkvCjakW8Tl?=
 =?us-ascii?Q?6AG1qvrBVtnGV6mv4lJmVOTGKH61Lj5WsoaoZzs4gUowXrEKec9/QX6b0Url?=
 =?us-ascii?Q?F5XJy3PbAQlRsB9sHSdyrCOpmgfNj6IdGgrcjFB92Pq3t50/lrluDOCp48fe?=
 =?us-ascii?Q?dixXDrxggB/pavoSzMZrc9m42NgDCRTKSC+B76/YojpcOOp8X4IAH4dszcxS?=
 =?us-ascii?Q?4S3RyinpQN/uYK9J6x+0PNwTPSmIuuQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7aea3b6-734a-4de3-423d-08df09ae1bba
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:25:51.3025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kvEVCdP1VijwKImg6K9jx6IJ5zYt8EIt1N2vYEcQ6c9swF+HpwHseYteKSWYUVQFNoEAzpF4MxUpMAPitUWyylYG1ujZNsSci6mM58xmAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6358
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
and two FTC310 cores. This series adds CPU definitions and a shared
SoC model, then uses it for two machines:

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

The shared E2000Q machine provides GICv3/ITS, UARTs, GPEX PCIe,
SMMUv3, four Cadence GEM controllers, two DesignWare-derived MCI
controllers, QSPI, I2C, xHCI, AHCI, a random generator, and the
firmware-facing DDR and control regions. Unimplemented register
windows remain visible to firmware without claiming unsupported
behavior.

Functional tests exercise both firmware and direct Linux boot on the
Phytium Pi with an SDK Buildroot image. Manual testing covers Phytium
Pi SD boot, COMe QSPI-to-SATA boot, all four CPUs, and network access.

Known limitations are documented. In particular, the PBR handoff is
a behavioral model validated against the available SDK firmware
samples.


Bin Meng (33):
  target/arm: Add Phytium FTC310 and FTC664 CPU models
  hw/arm: Add basic Phytium Pi machine
  hw/arm: phytium: Add Phytium E2000 PCIe host
  hw/sd: Add Synopsys DesignWare MCI controller
  hw/sd: Add Phytium E2000 MCI controller
  hw/arm: phytium: Connect Phytium E2000 MCI controllers
  tests/qtest: Add Synopsys DesignWare MCI coverage
  hw/arm: phytium: Connect Phytium E2000 GEM controllers
  hw/misc: Add Phytium E2000 DDR status
  hw/arm: phytium: Connect the Phytium E2000 DDR status
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

 MAINTAINERS                                 |   17 +
 docs/system/arm/phytium_e2000.rst           |  412 ++++++
 docs/system/target-arm.rst                  |    1 +
 hw/arm/Kconfig                              |   22 +
 hw/arm/meson.build                          |    1 +
 hw/arm/phytium_e2000.c                      | 1181 ++++++++++++++++
 hw/block/m25p80.c                           |    1 +
 hw/misc/meson.build                         |    4 +
 hw/misc/phytium_e2000_ddr.c                 |  197 +++
 hw/misc/phytium_e2000_mhu.c                 |  818 +++++++++++
 hw/misc/phytium_e2000_pbr.c                 | 1366 ++++++++++++++++++
 hw/misc/phytium_e2000_rng.c                 |  182 +++
 hw/sd/Kconfig                               |    5 +
 hw/sd/dw_mci.c                              | 1382 +++++++++++++++++++
 hw/sd/meson.build                           |    2 +
 hw/sd/phytium_e2000_mci.c                   |   95 ++
 hw/ssi/Kconfig                              |    5 +
 hw/ssi/meson.build                          |    1 +
 hw/ssi/phytium_qspi.c                       |  398 ++++++
 include/hw/misc/phytium_e2000_ddr.h         |   23 +
 include/hw/misc/phytium_e2000_mhu.h         |   34 +
 include/hw/misc/phytium_e2000_pbr.h         |   62 +
 include/hw/misc/phytium_e2000_rng.h         |   23 +
 include/hw/sd/dw_mci.h                      |   74 +
 include/hw/sd/phytium_e2000_mci.h           |   21 +
 include/hw/ssi/phytium_qspi.h               |   23 +
 target/arm/tcg/cpu64.c                      |   81 ++
 tests/functional/aarch64/meson.build        |    2 +
 tests/functional/aarch64/test_phytium_pi.py |   77 ++
 tests/qtest/dw_mci-test.c                   |  417 ++++++
 tests/qtest/meson.build                     |    1 +
 31 files changed, 6928 insertions(+)
 create mode 100644 docs/system/arm/phytium_e2000.rst
 create mode 100644 hw/arm/phytium_e2000.c
 create mode 100644 hw/misc/phytium_e2000_ddr.c
 create mode 100644 hw/misc/phytium_e2000_mhu.c
 create mode 100644 hw/misc/phytium_e2000_pbr.c
 create mode 100644 hw/misc/phytium_e2000_rng.c
 create mode 100644 hw/sd/dw_mci.c
 create mode 100644 hw/sd/phytium_e2000_mci.c
 create mode 100644 hw/ssi/phytium_qspi.c
 create mode 100644 include/hw/misc/phytium_e2000_ddr.h
 create mode 100644 include/hw/misc/phytium_e2000_mhu.h
 create mode 100644 include/hw/misc/phytium_e2000_pbr.h
 create mode 100644 include/hw/misc/phytium_e2000_rng.h
 create mode 100644 include/hw/sd/dw_mci.h
 create mode 100644 include/hw/sd/phytium_e2000_mci.h
 create mode 100644 include/hw/ssi/phytium_qspi.h
 create mode 100644 tests/functional/aarch64/test_phytium_pi.py
 create mode 100644 tests/qtest/dw_mci-test.c

---
base-commit: 61d82640e03f5fdbeb70c455e2b3cbff539600ec
branch: phytium

-- 
2.53.0


