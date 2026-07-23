Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFA5C531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvCp-0003pD-DQ; Thu, 23 Jul 2026 11:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCn-0003jK-OH; Thu, 23 Jul 2026 11:19:25 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCk-0007zZ-Sq; Thu, 23 Jul 2026 11:19:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mb0+ZqBetBSZ5mJIFuKv/8p4A1tJoiYto9N859KgPPnKHm/aJPSOSRWZ0kA6B4UYBxjhKNVGQpsXsQizTR3v/VjVFs5W7IEAfcFnhWOPd1Km3tWfmww+0rUOk9XqOsz/BFHS237zPXWKrUpuSGFpMaSGPJXc9OWrW2AoLQbRLirf7HJXVrSrcko08RHV5cIlgCBC7AZuJBi6ITw7A0YFBovLvSq9CzR23cR6KKuYvpHZtidYQz71PeWOVfhTPE1HSW2yHr+zcdxUnEhjYcjyM7rqS1EZawLJIjkQ1FTAxKPN43Of63sfojd48UXEEAfPB/MoexrcpvN2Hec9LPcvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qNIH9mLc2pe0uoiEDKzwDAGDooZ17WEv6CCFaipGiY=;
 b=P6w3+7NjeAX89Op1Hjyp2U7hh8XwGdHBPEi0tspyoCxz7qu4SKgrAxVP+ooeqUXT6KSdE3R3Y1/CmDgtSuBXWFuI+4c0CRwACjLz20NVWeqzhDXfhwFn51AZ85KC34KBIxpNEwSZZHr+BwHHmSBzHFCZQ+z40wIe+k67F7p0yyHrBR9ZD9E+5CVSTBZ3cOk2GoBH+w3YH9UJS0IVnC83o75ObvqTPvpZ67U1nk+h8oVYzBr5sm2iayhrR1/HJB7i7V31cqdXmOSqs4lHDwF1yquHuSHhii7W6GqMnc8dfboT+pxRhXQvKGGB4xrLgD6CAvUhY3brjnfwie7WyGJC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qNIH9mLc2pe0uoiEDKzwDAGDooZ17WEv6CCFaipGiY=;
 b=gCjUkHUHcADlS2Oay6EVEGxVWuJKJ9wEMXC9Ue4GYYuPe8V0b8pqFwAEgTE88lrIhBMyY7+Dg5RmkNo4N7HZeq3sX3ceEXrhCwlfwg7Qbx0Ocq/o8aNECuysnT/1y24DWsGU6Dw44Lree3rb7pbuH8RXd8HlB0zD4pBoFddDpfH9Thj8YkCnoqQWoS+b6Gnp1PMX99/gnoFAbP0rM4tO7CLhGD1EoCMYPmmC7VhXpH5HWudePY4TPASyHQ3i1hqLMKB7ezfVMzxy2QWDEyWjF4hqn+9NPf+8w+rSmVkDg9irc1JXKDMMbjGFzNVzlI6HAXwMBWyZr09XVHRaP/nElQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:12 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:11 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Thomas Huth <th.huth@posteo.eu>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH 00/26] hw/riscv: Restore Microchip PolarFire SoC Icicle Kit
 firmware boot
Date: Thu, 23 Jul 2026 23:18:27 +0800
Message-Id: <20260723151853.2143177-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KL1PR02MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 6301196d-1782-4566-195e-08dee8cdbf89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|7416014|366016|56012099006|10067099003|18002099003|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info: 5T8Ki9pNcKDVB7EJXnNHnsqTJ4FzbQzXps4R2pkc2JY2WjSmsSksMCFAinaoxAdRs4qkRm1KzlFvDQWtu/af2Yl3/zHgtL2yiNwYknyDVQ//A96AlX+0aLDS/VoyGVJwA8ISBiDJnzqiO8yGV7sDPX7jFROYsIO6PDn19DYG81FaQh7onMw0KIn4qzBceuTPJR9yWwWhUso5RFOuQz9QR0dZebFLQqNHUGXolBPxTdoKXy4qRVqbRnEtoAUZLFxOOoryaI7AC2RBVoAavALrWkY9DFHNZJ1lMGKCibeCCpuX8+v25bap6LKGCVZzk5UbEBpux/bbdPDI7qhxD+lPgx9LsW5XfRd5sxCFFWxnbXtN6yDlRYOJckp+Ga0EFV0zh+fhLlv8ksKfZoaoVAenaq9jroGufRSMV7w5E8+yYP3cMwDCfLdP7uewmhvYfv4QsHxLOQhJ8fMkuf0yGe8Qkc2KTFctezCmL/CWrYRfz8caUbl+NCzIUqL9Dz1nGIZmT3Oqc7xC5JD0XRTueerQN1rwhd2nqQ2QztzovBQOT/4tL0hJCx+78vIqSOxtqhpspGfQORQg4KlEx3Oll3IHIk/lHvUzmUPwT2OfxMB/VOOmUYk3IJ0KLqhV/6fFxsApQzvJsO6m1kdyyjTXkFFA6Ip1yzlgahHkKjmRY/Gz7es=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(10067099003)(18002099003)(6133799003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f18cH0JzREiGoANgXxMBMmbTQpumJ4NGArJE2liKG7GcqAZNFxA/gvG4Fbmo?=
 =?us-ascii?Q?bjbUzOTloAPIRFU1Vbxv0WBjYA8Vusdbam/et1cAMB1rkdT6JNzPZjLJ980b?=
 =?us-ascii?Q?BDDjD2r2zNpb/UxPenTup+dcUf9aHd+SAYjIBe6NGJNrMh1EsrLygcSFmRj6?=
 =?us-ascii?Q?lQPXe/MkQnCWmyKQ6DSb6wZtkgJOswqIdBd/CU7Zu1cDnlzjSQ4NsBX885+z?=
 =?us-ascii?Q?mRfH6m9ilqKdztg3q5eZ/5ZUX/APBwg4XUyS43qB5g83GOTbKzNuxs7Y8LoE?=
 =?us-ascii?Q?3nbuLg5tPTQVJSSkLaZ1vtF2e1dgJ5tN8YaZSo+rMULLtevMTCp5QJc6T0Nb?=
 =?us-ascii?Q?qT8ROtpYzJt1USPsTB56xlYn1DHfI5YwD5DV+CclcLcHYKZTXl1J0hU6WpHh?=
 =?us-ascii?Q?TuwfhEWXnqhly/3Ui3Pkv86FQR6HWIsh3YFDQc2pmbNYwWj48JW1evHFmHTd?=
 =?us-ascii?Q?6t0iPA9MuRH6YBreQlfkFTFbS4oINuBPz4PXVbIC3xanilEI+MKk6Dxm81fX?=
 =?us-ascii?Q?ABfOJSyd52HNQWIgKjPrUQUtI0ybu5w8eflO7WCBGzszmL9zUMqvIiLeTQ8n?=
 =?us-ascii?Q?ATfUCu6Nlg5s1SUBwBIB/gS9sJO1VULnXmTekkyJ2XM1ye6pcQQzrQsd9lJ3?=
 =?us-ascii?Q?XY3cXWvC70fu9wOcIUMWlcF23xyuiof/TLmferLx53OzXG8gTjwo9PRLbHd4?=
 =?us-ascii?Q?F7yKttdANgZFNooIVGPEjRjS7yKKkjVSb/OONmLTOjrG6hX1mqdiDs/QFqrF?=
 =?us-ascii?Q?qIUyadlqpwRHyYHcgpeqQT6lo65YRIGn3mUlHnwN52AacVkzwhsVG83787UF?=
 =?us-ascii?Q?YGee6QGicnPTc1UXUzAehd+cx1rm01QA5gmVvZWe7BrUt59PqpsZJ8gt0d/k?=
 =?us-ascii?Q?p6fkrQ+i/KHQp+OHO8S9eRj/8x335d9MsXve0qaFaVt6L/HV9vq5ryiDhVKe?=
 =?us-ascii?Q?8HuIyqGFZLWBjoHh89t4DEPsfs0/JFu+RLYzhnXiINvzGmoPN8Jcwm5JSMd2?=
 =?us-ascii?Q?2+Dfoej0DRDnYBf4mKaUTBOH/fzgcclHIwJZyIygFZ9EPKXlZSrlsL4MFbxg?=
 =?us-ascii?Q?IiI8tYRMsoLKLpcB83fyQLrHtzmnRkHhrrbp04y1Ipin6h08cFg6uOa55trM?=
 =?us-ascii?Q?fTSnuS4OK4t4N8NNgVxsLtBW2rM/tjXbZPOiR3zCW0seb2b0tZhUiVvvMnJW?=
 =?us-ascii?Q?q2IycT0U3R+PHq2lopbDrX/1l1wkhU13lJg9i4Rb/ImLQkPaQ7h204jBilut?=
 =?us-ascii?Q?YHRom9IUZ4J6ojWsWUXX6qn5sTu+eUxJRQy1/s0mX6rZaHJLTbpjrw6EUG+n?=
 =?us-ascii?Q?ISRW2r6U0yaZtPed+QesP4KlkqSk12SWC1B1jqgsGB9D4Fkb2HBdV0X8Z2qJ?=
 =?us-ascii?Q?3XHiG48LP3/gKWZToun+gNjtG1uMXOBkykA3oO18jCqVcto4iolCjKNs1Gpw?=
 =?us-ascii?Q?X15hNH/XA5n9TPihC8sdbLAXnFfWwoTLeEG0Mrw0Xq7OZmSzh3pGrWnjXW4o?=
 =?us-ascii?Q?FOK4iWVFldpwGYdIq/d9vMEWQ9itI6THUIRlKDSYwjGGj/Q+3AhnoCdWVWaW?=
 =?us-ascii?Q?fMp2mcZFzkcvVccWeBV50I52QQj5N6waO/tmk2aE7PGSM8yNgTsFAqahWDCT?=
 =?us-ascii?Q?51urV/aYmTSww97dq4FtXTDLous0d7tYjShpNpU2qd3oqx9Qe1mEFOr5IC1c?=
 =?us-ascii?Q?wSeTYlNFsaPshF2xmvYnr/whgRrJDUb3GyvLlIk0FLnLHPS+ZUGbGVvgXOSO?=
 =?us-ascii?Q?yrRjiS0Q6BJzikopOdWIVqLyuKB4OP8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6301196d-1782-4566-195e-08dee8cdbf89
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:11.6067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKPyQXequF+Ht5L0oVTuT7+fGgDDPoIoCPmXUtnNwUxZ9PYkGSA6/QmNjtkKsybvjZSC5OSjAUIz/gGl4ajZul+9xgPUVow91SJw5HmfEYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6215
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


The microchip-icicle-kit machine was originally validated with an older
Hart Software Services (HSS) firmware stack. HSS v2024.06 cannot boot
through U-Boot to Linux because several firmware-visible parts of the
PolarFire SoC are missing or incomplete.

The first failure occurs before the UART is initialized because the L2
zero window is not mapped. HSS then needs additional L2 cache controller
and DDR training behavior. Later boot stages exercise system services,
the RTC, SDHC version 4 DMA, and high-capacity SD card block sizing,
along with the complete DDR aliases. The existing models ither reject
these accesses or expose behavior that does not match the hardware
specifications.

This series restores the complete firmware boot flow. With these changes,
QEMU boots the HSS v2024.06 eNVM image, loads its U-Boot payload from an
SD card, and reaches the Buildroot 2026.05 Linux login prompt.

The changes are organized around the firmware boot sequence:

* Correct the L2-LIM size, map the L2 zero window, and provide the DMC
  status transitions required by HSS DDR initialization.
* Model the documented L2CC Config, WayEnable, and WayMask registers,
  and resize L2-LIM as cache ways are enabled.
* Complete SDHCI version 4 support used by the Cadence controller,
  including Host Control 2, SDMA system addressing, 64-bit ADMA2
  descriptors, and SDMA boundary continuation.
* Run ADMA from a bounded timer-driven engine instead of performing work
  from command or unrelated MMIO accesses.  This keeps DMA progress
  independent of guest register traffic and avoids consuming a polling
  deadline inside the command write.
* Keep SDHC and SDXC memory transfers at their fixed 512-byte block
  size, and advertise the Cadence controller's 64-bit system bus
  support.
* Add the PolarFire SoC serial-number system service and RTC, and honor
  the system-service notification control bit.
* Correct the DDR aliases and fix the board topology at its physical
  configuration of 2 GiB of RAM and five harts.
* Document direct and HSS boot, add focused qtests and a full firmware
  functional test, and restore the machine's Supported maintainer
  status.

This series assumes that the following generic SDHCI prerequisite series
has already been applied:

- Message ID <20260715160731.29969-2-dingtao0430@163.com>

Testing performed:

* Built qemu-system-riscv64 and the documentation.
* Passed various newly added qtests.
* Booted HSS v2024.06, U-Boot, and Buildroot 2026.05 Linux to the login
  prompt using the functional-test image.

The functional test downloads this versioned image archive:

https://github.com/processmission/qemu-machine-images/releases/download/
v1.0.0/riscv64-microchip-icicle-kit-v1.0.0.tar.zst

When restoring the HSS boot support, 3 potential bugs were identified in
the upstream HSS source codes that either blocks the DDR training from
succeed or traps in a multi-core race at the very beginning or after
a succesfully DDR training but stuck at OpenSBI/U-Boot hand-off. There
are already bug reports filed aginst various upstream projects.


Bin Meng (26):
  hw/riscv: pfsoc: Correct the L2LIM maximum mapped size
  hw/riscv: pfsoc: Map the L2 zero device window
  hw/misc: pfsoc: Support PolarFire SoC DDR training with newer version
    HSS
  hw/misc: pfsoc: Model L2 cache controller registers
  hw/riscv: pfsoc: Couple L2CC to L2-LIM
  tests/qtest: Add PolarFire SoC L2CC coverage
  hw/sd: sdhci: Migrate the Host Control 2 register
  hw/sd: sdhci: Accept version 4 enable without UHS-I
  hw/sd: sdhci: Use version 4 system address for SDMA
  hw/sd: sdhci: Support version 4 ADMA 64-bit addressing
  hw/sd: sdhci: Resume version 4 SDMA at buffer boundaries
  hw/sd: sdhci: Run ADMA independently of MMIO
  hw/sd: sd: Keep high-capacity memory blocks at 512 bytes
  hw/sd: cadence: Advertise 64-bit system bus support
  hw/misc: pfsoc: Model PolarFire SoC serial number service
  hw/rtc: Add PolarFire SoC RTC model
  hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
  tests/qtest: Add PolarFire SoC RTC coverage
  hw/misc: pfsoc: Honor PolarFire service notification requests
  hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
  hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
  hw/riscv: pfsoc: Fix Icicle Kit hart count at five
  docs/system/riscv: Document Icicle Kit HSS boot
  docs/system/riscv: pfsoc: Document CLINT topology for direct Linux
    boot
  tests/functional/riscv64: Add Icicle Kit firmware boot test
  MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer

 MAINTAINERS                                   |  10 +-
 docs/system/riscv/microchip-icicle-kit.rst    | 129 ++++-
 hw/sd/sdhci-internal.h                        |   1 +
 include/hw/misc/mchp_pfsoc_dmc.h              |   6 +
 include/hw/misc/mchp_pfsoc_ioscb.h            |   8 +
 include/hw/misc/mchp_pfsoc_l2cc.h             |  31 ++
 include/hw/riscv/microchip_pfsoc.h            |   7 +
 include/hw/rtc/mchp_pfsoc_rtc.h               |  46 ++
 hw/misc/mchp_pfsoc_dmc.c                      | 272 +++++++++-
 hw/misc/mchp_pfsoc_ioscb.c                    | 174 ++++++-
 hw/misc/mchp_pfsoc_l2cc.c                     | 230 +++++++++
 hw/misc/mchp_pfsoc_sysreg.c                   |   9 +-
 hw/riscv/microchip_pfsoc.c                    |  92 ++--
 hw/rtc/mchp_pfsoc_rtc.c                       | 479 ++++++++++++++++++
 hw/sd/cadence_sdhci.c                         |   3 +
 hw/sd/sd.c                                    |  43 +-
 hw/sd/sdhci.c                                 | 292 ++++++++---
 tests/qtest/mchp_pfsoc_l2cc_test.c            | 221 ++++++++
 tests/qtest/mchp_pfsoc_rtc_test.c             | 317 ++++++++++++
 hw/misc/Kconfig                               |   3 +
 hw/misc/meson.build                           |   1 +
 hw/riscv/Kconfig                              |   2 +
 hw/rtc/Kconfig                                |   3 +
 hw/rtc/meson.build                            |   1 +
 tests/functional/riscv64/meson.build          |   2 +
 .../riscv64/test_microchip_icicle_kit.py      |  52 ++
 tests/qtest/meson.build                       |   5 +
 27 files changed, 2264 insertions(+), 175 deletions(-)
 create mode 100644 include/hw/misc/mchp_pfsoc_l2cc.h
 create mode 100644 include/hw/rtc/mchp_pfsoc_rtc.h
 create mode 100644 hw/misc/mchp_pfsoc_l2cc.c
 create mode 100644 hw/rtc/mchp_pfsoc_rtc.c
 create mode 100644 tests/qtest/mchp_pfsoc_l2cc_test.c
 create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c
 create mode 100644 tests/functional/riscv64/test_microchip_icicle_kit.py

-- 
2.34.1


