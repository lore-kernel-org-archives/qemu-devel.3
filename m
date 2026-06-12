Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E6CCD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY0nS-0001VL-Qs; Fri, 12 Jun 2026 08:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvx7-0002Tr-0E; Fri, 12 Jun 2026 03:05:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvx0-0005yW-Eh; Fri, 12 Jun 2026 03:05:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y50Fko5lOX55EPq5KnVoCliHmtnO1Z4+xI+AztrnoDzYC+IXM9Tr1Z7EbDsUBfKsCq1cn3Y0ecZ0Zjw3q43PrNeDYfcdwx4RzM4NgMcHDf0mGleZ5dq5+8Oc0tIAO3wlKH4AhIIv4smIeja+BaDOZLaGtQ2wHbvMpv6ep7bZH9aAiYydISZKhA1a7LAb4qkGXTb9a2VYl75IzmaP1gYIi3N8c5b7nz16MpSNTSNNMP5YAhJeZFrfO7/STGbOo9BDsn7UX21XphF1ikdpngAQCOpmgI3kN3le0ESJ3ekisKDZoF0+xwhOVvaq+Mg0nnVibnRkAx3ZyVkoCTh1TYJXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQrap3sVwYDyBJO/0G1dMwoK7cZ9NW9PmuC8IGDqn1Y=;
 b=tSsI01a6B+JN2QwW2Y8WV0EXzhUxo2a9QOTaPr54Wb0UTXjudTRmOFT7MpYNWkS1RfayP+Ikl37PXSECE9vTHKQaCXh/QHtE5wR9JIyymbSs9h24wr+LIb7s3vFk5t5LuRaphKJyrWsBDvcPeOUyMUK+UeY55YwVHEEWS5fe/DnAcshjRNmpZCYD8LdWpHvADyHqATHuqbywQ+AgRfPtHlgNFzit76EDMyZuKLMopjrN3HejXN/2BYz4WQsmKaSXdwi8f4ZTkgVriiWS9fXCpZehNU6eWBI0BxBZYRtS1Kca3r4Tq6KbcsHYDG4UKGrnl3w3iyaLx6afae/+6YPMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQrap3sVwYDyBJO/0G1dMwoK7cZ9NW9PmuC8IGDqn1Y=;
 b=GddqFQKDJIXrupxBvvLV4HFObNw9rugEF3hYUhgZZp+p94oKeAV89B1uIciCsHRfjEXEPr2ejmkLoBhBBAxVN4KH7917zwUpwZAl9bnCYRsz+dbyl3TVTCCvlXMaBgKhjHZ/1qJ/yeo149KaaDG0aIenoWOk7vPjA0K39Dt7Iie1PZ//lXv8yd0CZ+R68y/QVxhwTQUzqtw4GnYt7mgetUljANDXHiDL+HakD954GnMCjMMSq6uy4DajUDhn+GKxQksMHZYtP1ifiBGrMwOtpncg9p+6XWyN6cGW9uivAxKbeMjj7GTQOIHiznKxP2fckMyfuZ7rpQ47WDEB5Oz11g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB6457.apcprd02.prod.outlook.com (2603:1096:101:13b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 07:05:00 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0092.017; Fri, 12 Jun 2026
 07:05:00 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v8 0/5] Add support for K230 board
Date: Fri, 12 Jun 2026 15:04:03 +0800
Message-ID: <cover.1781246408.git.chao.liu@processmission.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::24) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 31904f5c-4c84-465c-2bfe-08dec850eb2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|34096008|366016|7416014|586017|376014|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Gx7UGUHjpbsxU+JC3K+N4DPOFebbRAwAMALuLxCqIdziEp/pPSGCaDA4weqXt6GUDI56sMHhlUNEo2Ea0zCka0mCp4T6/GWghRGZUrkSG9BZ2zMAhMxeT97/Mamtk1qTWgDm9dq5KACI8nabHlyqiksebj1PrXGQpGyCq7lG0StWPwAMuNbQ+4O+icmu0aD7oU1e/ENot7NokA5YY+T9nIVIKibi/IN1jrIExckB2qN30ynQ1Z1dV1AfaLf7ivZH57dDY7ozRskQBM16XGGm5iQn8ZUItnNAHiFVBeUOK0G8qv7Dj/EQZXdcY1w/pavCsrk1LMwbNMBUbnCc3i490cSnb+Sog5OLHln419gz8t1lN1/Hvf8ZQAwORLjGsdNOfWbVC0681yDOnWrZrdQNlNjF1975KQIt2pDioc+zMsGoDEyf3Bh7ghkKws425KI4cdBG1S4aj8WDmmhpwN58PD9bVyRHqv/LTvdIs+4XDysBYFZGUR6/0eYYLyBRapeBSV9C76B/JvpX5kSpH/e6uMq7ObbfAxH2hhIeFyjY/YkF41aF8eWcjSzTW4k86OfY+NncrR8K6uTFj1NyrCLNulG+aXsDEHuL7QvqcaH5QSzUubmHK6dQmYqDdBqVc1cA2bb/1T408qpZAmvyrdi6Y2wkoVpLc5j/E3VVcfkz1W3S5T0wjGN5yfnaMoFh38MHahOD12LpUvHDJDog0hAuzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(34096008)(366016)(7416014)(586017)(376014)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ahsEToLM2zu2GLp08KCVo21HfGhlJGdvZW220L+MTc4GORoM6D8xlaff7B+s?=
 =?us-ascii?Q?UWSE+g/MDI0g9kWWzXkcMt8zH4quV2/I7g/lWQNnDHeVqla3ZdkA9gfW5Qz4?=
 =?us-ascii?Q?jUigQCYQVfbuhWXAIHWcUNkUGMyMzfKScTKUBKxAsHh58jr6rlrwP7zhnWMl?=
 =?us-ascii?Q?pOW2NlYgkd+fathIQLFJk7YE1n4eD069uIzoFGcsCcsiFIR6XY/Jt56VKS18?=
 =?us-ascii?Q?WBtF4aEd52aNwPGATw3rtbgY1PeyTkGGysvPaUgWNscykwJ9bpb661Z+1/lh?=
 =?us-ascii?Q?NjtrjB6BfYa6t2czC3O7KUC1E2LKSSnGtIhigaVHIPpuTeODS33jyVbZYrQn?=
 =?us-ascii?Q?+Y1HgQEKJT5d4OOWmWWo8cRPrzITSEP/nAH+C9/TvhoTLrKWDbHe+vdahPn4?=
 =?us-ascii?Q?ZxVXnc9pQ7/hRLhWmwTOznDhDqj3Hqqk3zvnIG9/m3iitqrn9cfznN0SoiU6?=
 =?us-ascii?Q?Q25QBUzcHcNutcQhcmlatPLvyEAw6EIZZEN4BA3i2PXIT1Zz2Edkm4WoPre9?=
 =?us-ascii?Q?/rnyKSyMstDd+ZMHEhfcoXD645i7CEQX2NdeozApuGLthIC/UXhGhXHQRppU?=
 =?us-ascii?Q?KdiUZz/PI+NzGgIa1eNaP1Ebkz40ZozUB7T/HtzBYSLr0DZEN+VJZ9K9bRoW?=
 =?us-ascii?Q?Fq6h/1HkoJop3UBI04tDI5svGGD9sMLJWfhXEmB/kbug8piar1WQqn8KiRmM?=
 =?us-ascii?Q?vmEHlsJFxg9i6YGrpTWy4Bu3g37weQCBrQFrf9hGc1FcjSioWQVFZKgxArPn?=
 =?us-ascii?Q?mCHXG4zFDiMLDpvYzrsP9leRe4wKmR0p8e9a6ZCWnRMxTn/GOvGwSFV92rX7?=
 =?us-ascii?Q?a5lQWHODCWqBb/ywL3ozhOrurQwDZ3lDmxOYzTZSZ3HgAdbHUmdaP4hEcwBI?=
 =?us-ascii?Q?hPYYlCNQr9tXMDMt5xRf/baFB7miWLSErHrhYhvYVewEJJc1bYxgSsimH71t?=
 =?us-ascii?Q?+TJSbJuv+MIfE80njbeueH+K7oELnYVyOnknHD//N0Waes5Eg9WmF8aL3waJ?=
 =?us-ascii?Q?Fjd+BcK23DzpHtQ9SZ/deOPOk+DsMtG8V922u8aJ5nkKvrXJ22t3O6DZSnZ8?=
 =?us-ascii?Q?ZxIRYOAnBxdsBmt2qj7+N71n6Sbi1guFxHko0cS8CeW4Xx4xOXTz2l52mYIE?=
 =?us-ascii?Q?JIoPl26f1cGk3XaKhUW3vLkci9fDjH4Yse37kHeU0LgaljcstiGaaXrtaUzA?=
 =?us-ascii?Q?HRiUtGLA8FcMYHwDu1Lot8ICvbESBlyYQHVlCfaivp1zintFhwqNLR+DndT6?=
 =?us-ascii?Q?bRk/buQb3MhzfLksLmlQewUzanBonpQfKmltxmXMvCO3po5BJceyxX5vK2EG?=
 =?us-ascii?Q?mgwxWrXGFF8z34MnPbBpj1UtOL6TQncbHd+EvzKmRodOu3DHei9r9hP8ObWU?=
 =?us-ascii?Q?Kd8Yl/9wHDSXDbjIVBHQYfXeTVGCkOSF8efaSwnDVjRJ9ljBOIVEY1EQYdJN?=
 =?us-ascii?Q?1nZs3V4OhjhcPxJ1RxkZ85550o/YmyN82b64KlyxCjHN/PnIEud0m9cXvpvX?=
 =?us-ascii?Q?tprK+92jAvAxwaoftCHGCYZsvUZc4DuCs6pC8OBG7zhVS9UQGS/MVPJh2FJ0?=
 =?us-ascii?Q?M+i+pzFm7rcvVfTfbg8isqFkRuY+gOndOU5vfSkE9QEwLnsZU842JdqdpN/H?=
 =?us-ascii?Q?+zdxextzjGyc7ByFWyiBnY/bWtMaghgXR2n8ELXM6fET3FykaNn4HCEO6JY/?=
 =?us-ascii?Q?jEBpHBvPR7kXVZvvakw6/0/9OmTPaw+lv9LvTwx261scZLSyoDgBAO6QXW3c?=
 =?us-ascii?Q?aParCSdi0JcrUQHt0EugjxR4Jcm/qXQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31904f5c-4c84-465c-2bfe-08dec850eb2c
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:05:00.2218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SCkuHuiae8rIuDQRLlnXdBzVkVQG6gYsdMYvlsM3UPeMBwj101FAz3e37/GQqLyl6tTWBK5qxWCgdKj+dkjXoc88mDoOY4r3fqPAuxMeVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6457
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Jun 2026 08:15:35 -0400
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

Hi Alistair,

I rebased the K230 patchset on your latest riscv-to-apply.next branch and
made some adjustments.

Please review the patchset when you have time. Thanks!

---

This patch series adds support for U-Boot + OpenSBI + standard Linux kernel on
K230 board. Thanks to Peng Jiang, Mig Yang, Renzao Ren, Yao Zi for their help.

Test command with the direct Linux boot:

```
$QEMU -M k230 \
      -kernel [Image] \
      -dtb [k230-qemu.dtb] \
      -initrd [rootfs.cpio.gz] \
      -nographic
```

The k230-boot-assets repo [1] provides K230 Linux kernel images built with
k230-sdk and Yocto.

For more information, see docs/system/riscv/k230.rst.

---

PATCH v8 changelog:
- Patches: Rebased on Alistair's riscv-to-apply.next branch.
- Patch 1: Fixed mmode() check bug, see Milk-v Duo patchset thread [2].
- Patch 2: Registered riscv64_machine_interfaces for K230 machine.

PATCH v7 changelog:
- Patches: Removed invalid tags for patchset.
- Patches: Updated the K230 datasheet link in the patchset comment header.
- Patch 2: Removed the unnecessary changes to MAINTAINERS.
- Patch 2: Fixed an Oops caused by accesses to an unimpl UART MMIO address.
- Patch 2: Adjusted the K230 machine hart count to 1.
- Patch 2: Supported direct boot linux with `-kernel`.
- Patch 3: Aligned the WDT interrupt number with the K230 datasheet.
- Patch 5: Updated k230.rst Linux boot docs.

PATCH v6 changelog:
- Patches: Rebased on the latest Alistair's riscv-to-apply.next branch.
- Patch 4: Picked up Fabiano's Acked-by.

PATCH v5 changelog:
- Patches: Rebased on Alistair's riscv-to-apply.next branch.
- Patch 2: Fixed reset vector ROM jump to trap-handler bug.

PATCH v4 changelog:
- Patches: Rebased on the latest master branch.
- Patches: No functional changes from v3.

PATCH v3 changelog:
- Patch 1: Align T-Head C908 CPU's RISC-V extension with XUANTIE-QEMU.
- Patch 2: Adjust PLIC and CLINT addresses to match K230 datasheet.

PATCH v2 changelog:
- Patch 1: Add Svpbmt extension support for the T-Head C908 CPU.
- Patch 2: Move the k230.rst definition from MAINTAINERS to Patch 5.
- Patch 5: Apply Daniel's bugfix to build the k230 documentation successfully.

PATCH v1 changelog:
- Patch 1: Add T-Head C908 and C908v CPU support.
- Patch 2: Add K230 board initial support(big core is not supported yet).
- Patch 3: Add Programmable Watchdog Timer (WDT) peripheral support.
- Patch 4: Add QEMU test for K230 watchdog.
- Patch 5: Add documentation for K230 machine.

---

Link:
[1] https://github.com/zevorn/k230-boot-assets
[2] https://lore.kernel.org/qemu-devel/agZFchak-jsc2moK@ZEVORN-PC.localdomain/

Thanks,
Chao

Chao Liu (5):
  target/riscv: add thead-c908 cpu support
  hw/riscv: add k230 board initial support
  hw/watchdog: add k230 watchdog initial support
  tests/qtest: add test for K230 watchdog
  docs/system/riscv: add documentation for k230 machine

 MAINTAINERS                    |  11 +
 docs/system/riscv/k230.rst     | 113 +++++++
 docs/system/target-riscv.rst   |   1 +
 hw/riscv/Kconfig               |  11 +
 hw/riscv/k230.c                | 526 +++++++++++++++++++++++++++++++++
 hw/riscv/meson.build           |   2 +-
 hw/watchdog/Kconfig            |   4 +
 hw/watchdog/k230_wdt.c         | 296 +++++++++++++++++++
 hw/watchdog/meson.build        |   1 +
 hw/watchdog/trace-events       |   9 +
 include/hw/riscv/k230.h        | 149 ++++++++++
 include/hw/watchdog/k230_wdt.h | 121 ++++++++
 target/riscv/cpu-qom.h         |   2 +
 target/riscv/cpu.c             |  51 ++++
 target/riscv/th_csr.c          | 376 ++++++++++++++++++++++-
 tests/qtest/k230-wdt-test.c    | 189 ++++++++++++
 tests/qtest/meson.build        |   3 +-
 17 files changed, 1862 insertions(+), 3 deletions(-)
 create mode 100644 docs/system/riscv/k230.rst
 create mode 100644 hw/riscv/k230.c
 create mode 100644 hw/watchdog/k230_wdt.c
 create mode 100644 include/hw/riscv/k230.h
 create mode 100644 include/hw/watchdog/k230_wdt.h
 create mode 100644 tests/qtest/k230-wdt-test.c

-- 
2.54.0


