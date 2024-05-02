Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8FDC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Okm-0000lX-CX; Thu, 02 May 2024 01:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s2Okh-0000jK-9L; Thu, 02 May 2024 01:13:03 -0400
Received: from mail-bjschn02on2070a.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::70a]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s2Okd-0005U9-PY; Thu, 02 May 2024 01:13:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBAze7vF/rH7/QSD9PiQLhrE+gOZ3lyUwYes27K9pJQmcqJOwc1BRUqObMhsRBZuyEaytFAiUzcRxX/xuaoCw91pVFvfVz/H8HKZxS8GtN6hp91C9vx1ARMpZhhnAucVS+zqvZO/VUi8F4QyhulO1nrl3mLwG2eAKB8XCOniPxNkGGoAQb6tVvRcyJ0CaBFJto4DR5B+RRBuOAdIK2u7SAo9FZCQIZPvK8eXHtx7/pJupEHJDWtXGMzzcvL6jiOQAK+NxUZG/ZA6TbkppiLUSX6bk/DvkAhkkbC9TLKCFeLXSYPe7HgHUUq0z3QFA0Ldyi5XDodrqkbLtQEa+ZiDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q54FDq+8bs+b114HtEAaw7nfwzff5x34MXrTihyiRk8=;
 b=aFecPfcEKA0Fk15yzsh6qnfAk5/KOPfJNXBvfXxHHepmPjdn51hXEHxJEXxv8twmzhsoMhB6RC/+RLi47Wgt9AOjpZ3wZzNp8QkN5Enpicvz7H/+08tM8Jt2ciPFh4wzUtD+yRG27Igtai3CUwlsHzAiGgl4Ojwp+ljtS2z1Ay/7nhR0tVXgpJsRfbCltU28629HcfJX9uw+8vAYKz4oihECs44DaRNqS0Ruma8S9XgrF1EIt48UrPMsi01RgfzICi/QNa0LLgHJ9wHfFnzNRB/3GII7n12UxTSd4w7Q9J6J6PkdqmIy3uuaxW6T07zlgE9257dA68wzUSmXq5FGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB0973.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Thu, 2 May
 2024 05:12:47 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Thu, 2 May 2024 05:12:47 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v1 0/2] Upgrade ACPI SPCR table to support SPCR table version
 4 format
Date: Wed,  1 May 2024 22:12:31 -0700
Message-Id: <20240502051233.50749-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0051.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::18) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB0973:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f1d692-c7ec-4d5a-85c5-08dc6a6681b1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euLL5ZDJ6zC08cKWP2gxpmUNTEG5NAC7ld03won4btD36bk8+BgjWPtdkmG4dmVvp2oOu+xR/mjxIaK/hF5Vat2+7z+lKW8GvUvGA6bpm8PoK9CZjng4NTs8+B5JLHKbj9ci044/1hgV9u1+9VYwZsmyIrcs2vcR7dojYMeGtCgltXFVOWJs9hyeINFFN1UBWUCIyIZZf3qO07h8W0p50TrAnwCiKUg6daT3SMi9lHJ1axxzK6VhOWLTxXo44QiGu6KhfCFYjCGZW+mzeLdT9Za1rBxUUyqab/itFNxWyZn4N0L7j3ZXqCi4724Y4oXp10Rdf14vXHt7wGKHaaBnTzSrN24b3ZtExhDqW3yncLdap3QwC28AWyYxOl36etzumoKZcoCd+TAPWDlKG9p44S5aKhCGgPNPeUUy1R5QUWX+er2X0uuqCexrpoW/fMMjC5JErLY0tQdHMPQOYhrfGRUwDTPPoBWI5yctqjSomKaNk042mv7DBzloFGzfxRNTjjahwBFzCvMH7lbWi/TXpdnoBUelwgMadMn0Z5DwgKYLmnL1GthbWRi1t1QaciLIU8g/b5lb2V1n2Q8KlpelYMoW6Cfibic4Ys5kb5U52wcvNvsKT92f3MxIu5dHFGC/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(7416005)(41320700004)(366007)(52116005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NySLDAjr1r7MgrcNxB4vHmNKzPIGfOAlBYXSwz9W6WgNd3qLDQ1OspHXiJQR?=
 =?us-ascii?Q?QtiElPb0+1bHAYjuVZU5kny6Zb3VjGfEs0h/YIB7ABp3sSCohS3rynN5xtGy?=
 =?us-ascii?Q?e4rQ61weq0Hh3Z7wbiEFcJAZLWZfC60ReW31Yj8ObatI4s4aFumIP69UT4hj?=
 =?us-ascii?Q?LxqWvgiGZ9ALhe+dXUy251SVrD1KSPVEggz62W+3+QBU00wA8BwRzVsRT37u?=
 =?us-ascii?Q?zs1C8XWzALunYcZm3li32uPHNStPtcjF4yeRoc9stu77lGv+i4ORDOLIwALB?=
 =?us-ascii?Q?DDucKNSYWvfl/ojV17xMkqlJU/0OwTaW2u93OSxblf5A1G9omw5Amp4o1gHb?=
 =?us-ascii?Q?57FRGt6dm+vXxZpz9nZ7qFXnyj46tqo+bfDSOg2ki0S4B40JSETnftCcv/qv?=
 =?us-ascii?Q?IYGowjokD8R0R8Uz7ehPBQas0V6wk+5ugmpkkhC89QvjQllY4+mVC0vvxR0T?=
 =?us-ascii?Q?Q8RioDfp28s4ecZTiVy/nV3XnrckKw/VYfCsT1itahW278HwNjxlGg7Sw+4q?=
 =?us-ascii?Q?wwTFAukXVo6Umso4EjLBNbuLb6VB+zu3K7Yi81BFRay1Xa42xfAQpI5PQUJi?=
 =?us-ascii?Q?JI0F3xv1A0qd8VFLaMjL3rrHAr4Hoc9+IYjGw0Sv51ZqDbSWkiMGcgoZdioO?=
 =?us-ascii?Q?NbqHE/IqsXxOdi9KNCkvutNOqGfGIPO1wbhoidXXoUD9g6PPrlGsBL5dbqE/?=
 =?us-ascii?Q?G5X37ZDySUkfELhNAjLRP/lxE5rf0JC50+4JFH8N3X96GNHid0D82WRUJMWa?=
 =?us-ascii?Q?lVpXW7CMqp8y1c235zDOExmxUQaV0qNe8mtqlg3CDEEdGdPdt8rtES8Imlnj?=
 =?us-ascii?Q?syP09/hVBNxCQkUwLe6Pvh3DGtosF3+xpu/FqazeUFgMvAgFR7Kh4G+Po2iH?=
 =?us-ascii?Q?4NwusL7LJ7tooiOle+nxK7yLyRgHkIs2Ag/YUNrXVHK4JU+c7etTjF4/1Mxi?=
 =?us-ascii?Q?HMgIwmCO8eUazoR6bPOLPM2qVqWeSunQ4hIBnMvnQ+bdIQgvGul4aswFMGGb?=
 =?us-ascii?Q?goXhax56RcmcVXwHTimOxEw21pLT9cdLpkxq+vA56gotG6PzAzYjrc3QnRV+?=
 =?us-ascii?Q?D978499+akyi8Fz6dAbynebIJmSVnqfy0lqiY416Jn0BnatwxrNl5bIB0GSE?=
 =?us-ascii?Q?ZQjiC4F8REjChHRitUfaKGtO0FTjwM4rfuPbwRhAFczZt9lt145DrY8dTAXh?=
 =?us-ascii?Q?LYq6mOJnHtX6sR/lg29LAFT1wHpvtz5OaQ5bFzRRr57cBdtI6ACeY5AkphTj?=
 =?us-ascii?Q?wswX6NA6IhXtnQLYj8ieN9rsdFHKKfeUW3zK70LafVsmjhfLbQVR6k1znf/u?=
 =?us-ascii?Q?lrP85VBX46qxRl+THTBC2GCEKOMdwilWsujxbtzbL0fLciKTnJqvnzSOpZL3?=
 =?us-ascii?Q?mJqSqIMApi10DoS3g667tXgekeQkZBgFtIyTURa7DtSeJgmsuV9Myzw4clud?=
 =?us-ascii?Q?UEF7XHdUoRECr1rHj+ksh17DuydL7RDKk7RZzHivqgy5g3h3EgUE2eYYeqlJ?=
 =?us-ascii?Q?8v+n60eUlcn5xXUFoA49r+izfhn7Yfe9hDjXQIR3ur37y2WHSCdM4jhv/QM8?=
 =?us-ascii?Q?6MGnTVImZHTX4U9AMrb8mc+TvO/IGqnoLoO2w81xlk84zoASkZ6rQQNKmgyS?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f1d692-c7ec-4d5a-85c5-08dc6a6681b1
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 05:12:47.6185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2fAWPnqdmgZxN9PNRF4IH8cZtqFiQnpdnAChXmbcRHF/Pks+DkudzBrUs6+mQ/5w8pdPRZqstxZl/5h8a06yn1TUIuYMzDJKZpebPR+FjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0973
Received-SPF: pass client-ip=2406:e500:4440:2::70a;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URI_TRY_3LD=1.997 autolearn=no autolearn_force=no
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

Sia Jee Heng (2):
  tests/qtest/bios-tables-test: Update virt SPCR golden references
  hw/acpi: Upgrade ACPI SPCR table to support SPCR table version 4
    format

 hw/acpi/aml-build.c         |  14 +++++++++++---
 hw/arm/virt-acpi-build.c    |  10 ++++++++--
 hw/riscv/virt-acpi-build.c  |  10 ++++++++--
 include/hw/acpi/acpi-defs.h |   7 +++++--
 include/hw/acpi/aml-build.h |   2 +-
 tests/data/acpi/virt/SPCR   | Bin 80 -> 90 bytes
 6 files changed, 33 insertions(+), 10 deletions(-)


base-commit: 4977ce198d2390bff8c71ad5cb1a5f6aa24b56fb
-- 
2.34.1


