Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2F5C47258
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 02:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHBB-00065n-5J; Sun, 28 Jan 2024 21:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUHB8-00064z-24; Sun, 28 Jan 2024 21:15:18 -0500
Received: from mail-bjschn02on20617.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::617]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUHB5-0002cP-6h; Sun, 28 Jan 2024 21:15:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag2yiZE0gXGshN+6UyO1X6sBcpyumf+729dtwEHxcUQUaVj+l/NfPZCi2dmGPENopYDb3c51rk+A41ZtiWcRSEUJdYhPJr0WlRvQlxDCUAhPPEAphXM9Tj8qGaWEyBjksnOESnRL0vG8sX4+Yn4R6Ah8cqKTOX5toD37ZeGVa7Lx6ApC6VkpC7Ks8pegkYwKZjwzvvbjk0dK9MiVST2bx5ta28wTQqGPLgqE953ALWgC1AJQMf7b9JgrcRk8xEgpRGGjrfiF01GcBNg75jiGsJmgyICCMtpqI61K6n1CePNhIO7iG0BJCNfkLx2VhV7/NY3lsbvpDo1uUazu6Rt1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=493pUU49l9KD7HnBf5Ra222ZudvCFsIrdMRpjyeBkRs=;
 b=i01p5CE0+T+0xzTsrpSkPKQYqwkCWA57MMZlsk386FyWaN2gryhheVpB4uCSLGCBBJL0VWP9ZckhIbhLrzNPFQ6MQhYWSIzyjnRyE7mFhCK1/TLhUZMoryOrF64gS8Mz9ZbOyzzs9qcjl86GvuVpzefibpZ8euMr5I9qZVlSjYuD3+KydKatX3dp2ODbSrVR7QEuA/gapxzlJgE8Wp8IykgNNwEyM6hlOv3ZMKfyXI/BbrL2AAV7bgfOu1AdevVe6oIeAiD/Ami4j20PHPvB3ZKNMP4mq3jO5Dd+RxnOKGc1srdlanUcUjG15edSDKOkFBalgFBWwoaS+ouhcXlE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0852.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Mon, 29 Jan
 2024 02:14:55 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 02:14:55 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RESEND v2 0/2] RISC-V: ACPI: Enable SPCR
Date: Sun, 28 Jan 2024 18:14:38 -0800
Message-Id: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::27) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0852:EE_
X-MS-Office365-Filtering-Correlation-Id: eae5297e-ba2a-406a-8c5c-08dc20701581
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7dRq6Sn9sKWEjFbLXV9bz4eocVI8tugF9uDOsKOCfbOT/Y8D0wIk3evH+uJZaOhKyAzVJ1dZD5bQKFUCJqFvq7Sx8w/33+7RPQ3HY68DFct2GtJlcmpjIV0d1PsnAwwoC6tPrltS7+66xrLhjiIlhunEiGrqJ1zFtmQ5Ee2V7Tn+js4beLgtdFNhN5BsWNgwYJu8g8QLJqMrxpIQa0aBrMH1Hz4T/SMMs0GRx19MH31HB2yz5KCOG+KneaQRE7sHDvCpHD9qT2uJ4DL/RMg7OH+yjS0pG1Wx4lXocEEmWIzHomj8wodVMTRZ8vMSqw3D+G6ODxyKO9cCC5PPtvHjm7UhymNuPQqhCWdTdC9ZcDrpbeddR8iX77d+ePTYwnkx9AYXk7RkzBVpnJXT+zngcRj60RL23vVWRDxVor0i8nbOSY8uOLTV78RHTdN9zxhrD1YMfXc6SqT1xa51vVwHj0oqj2nGOVcTPIqCHRV42H8/RFZ4ZyHRWe8xRGFqlNKtPtRwqurdtPFh2IDOGkv6Cw8fHjfSu54bSB9atagcJkSYC8ZyWWoGsZ2J3P3vzzO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(136003)(39830400003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6666004)(36756003)(40180700001)(7416002)(5660300002)(2906002)(40160700002)(38100700002)(8936002)(8676002)(52116002)(4326008)(1076003)(83380400001)(508600001)(41300700001)(86362001)(66476007)(66946007)(26005)(2616005)(66556008)(41320700001)(966005)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4LVtglRR6o2NdeNQOM3VHvO9cU6xkFEDL5yq8eHTYTeRy/D5rj64avWim9VO?=
 =?us-ascii?Q?b0scwAyWo3rAeFcNb1iBGLeL9FFsUhLD1ehAs3InvsZtSk96Q7PmxDHN45uB?=
 =?us-ascii?Q?nzJoGngVFmtphQtE7/TkHijDq8M4T3IAPO+/2CWmyghGTQyL63TaWIYDv4PI?=
 =?us-ascii?Q?oQoaWChCBo8hzOQlJoNQkImlCOvhUsKPo/eKmFCCwaTV6SJzAo6kL5IzyRnz?=
 =?us-ascii?Q?2JfPlVaJiXAs7Y5aIegz+NDwZZ1uuoAqe7TFJ7bEaxYM99IJzYYssJ3LmdJV?=
 =?us-ascii?Q?X+wyqJ2xwsg3KQXSug/gr/EfBOsmNOLRBbVAtaV4jhm9C7GSH37Qd5L5VFnf?=
 =?us-ascii?Q?LTMhVxeSi9CsFoFGS++8wchhT8hgJSylVkLQVo8hU3gkJEM2gpA8C+0XQpwh?=
 =?us-ascii?Q?xO8lrM1rv+hVlHTaJD5MYpo9LLFxVKoSj+jkMNZmmSDtL54ZBkMkJBkbkuwm?=
 =?us-ascii?Q?8Gjh4lYYSH31T7Yl8hagLhnSl7Mq0KdgVNDqApYMyIH8zT/1d9YtujOnzved?=
 =?us-ascii?Q?o2H08P1SgnAJxuSGAdUFxC9ZZ07GIHBkagi8e5pYiyWrPeBbaa+vFswckptA?=
 =?us-ascii?Q?iRoBE1KX+GgTDLcG0de04WBHan/GBqSai077zOUWX+N6pzdf2b6tOt7dnbe1?=
 =?us-ascii?Q?7cHOftChTolmJfxjeK+TJL9nixJ3Wmx1+OTL8FVcdYjfHYt29S5z24VYpIwS?=
 =?us-ascii?Q?6qiSiAfMoAiyJgQbHUYRfxTtOi+X3by8r1jmKmH1zftCcUiAagI4FN9Uueyp?=
 =?us-ascii?Q?pglLWfB4I25p88ZYGbXeEu5HT4eKZvYby0YSQxBYIFZH4pXGbK9MnZ7LT7wr?=
 =?us-ascii?Q?X3KX1ubpxIAJjrJA4dRwoNqZRPx7qwVkZ+9ljA9dbvnG/heuF3NqhoGTu2UM?=
 =?us-ascii?Q?qiAMsrUAm8pRSdrJtN9xJSCW0FiM7qIvUKkjzcDYRGDp9shhbDkkdarsxs6i?=
 =?us-ascii?Q?o/v+MRPl+fJVYW+FfemwVT9+S0JalRUC1GxUTSE+rD4UUcq6evjJOvyhQowx?=
 =?us-ascii?Q?RnDDslR1NZd6lnpmI+DWV/WQsqvEHqVMH+wtZ7zABhoBoWHVJKc/Pqu71DQx?=
 =?us-ascii?Q?vVpxkhpu9waSPmLzeHf3zne6fe9qI+6ze2SGrVWaaBXHHp5Qyc5zmQaEsL4n?=
 =?us-ascii?Q?L5xQluNbh17bjNyUlXEEObRu4VRCXwF2zdoW1hIUXlVTPhI5kyyjXsiilw0K?=
 =?us-ascii?Q?WbQ9rmlXp99BDySc6LeH8v0uNex05w4MFNbTwOEgwV7t2fKEtiTY2bmEm358?=
 =?us-ascii?Q?lXu0UxW61v20aSFhDrekE1skW0I/eEYIY72XibEBLipjWd2+aRfoLSPzET3K?=
 =?us-ascii?Q?PPpXEp6gAzF2pYELHs3RSvKVbo8tRzXKMKYCBiTj03FShFE69v3xFryto3MS?=
 =?us-ascii?Q?wGFl5Ghuvsxypf+4juaqqKKOBDTwxpWdMK0/w++k1ksUAugg4xmOE198GqOE?=
 =?us-ascii?Q?yjjLTvCsJPsk6FocYTh4jFhVOFZC6V3ysvpQfVJfgseYzgpgsWbuL97ONE31?=
 =?us-ascii?Q?Td0v0XOqR6AbG68YzzSTaKqDgtt+OvrxP7q7VokCKlb1+YwBd5uGz/BRodVF?=
 =?us-ascii?Q?BgSUdX2yN4T/MSQb/saO9EhdWeLFToGSm0QX78KYcxZdYTIVtZBfqa95rfzt?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae5297e-ba2a-406a-8c5c-08dc20701581
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 02:14:55.2203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJcvIUMF2uisNxv1tJLVeUCk1HHChfrlQthcy4oLZgLo2sTbLbSOV5pVdwHcEkp+wsHtvQu4dZ7jbT8Hb1xPZO3Zz/mR/530TPPr7bq4+H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0852
Received-SPF: pass client-ip=2406:e500:4440:2::617;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series focuses on enabling the Serial Port Console Redirection (SPCR)
table for the RISC-V virt platform. Considering that ARM utilizes the same
function, the initial patch involves migrating the build_spcr function to
common code. This consolidation ensures that RISC-V avoids duplicating the
function.

The patch set is built upon Alistair's riscv-to-apply.next branch

Changes in v2:
- Renamed the build_spcr_rev2() function to spcr_setup().
- SPCR table version is passed from spcr_setup() to the common
  build_spcr() function.
- Added "Reviewed-by" from Daniel for patch 2.
- The term 'RFC' has been removed from this series, as the dependency code
  from [1] has been merged into Alistair's riscv-to-apply.next branch. The
  first series of this patch can be found at [2].

[1] https://lore.kernel.org/qemu-devel/20231218150247.466427-1-sunilvl@ventanamicro.com/
[2] https://lore.kernel.org/qemu-devel/20240105090608.5745-1-jeeheng.sia@starfivetech.com/

Sia Jee Heng (2):
  hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location
  hw/riscv/virt-acpi-build.c: Generate SPCR table

 hw/acpi/aml-build.c         | 51 ++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 68 +++++++++++++++----------------------
 hw/riscv/virt-acpi-build.c  | 39 +++++++++++++++++++++
 include/hw/acpi/acpi-defs.h | 33 ++++++++++++++++++
 include/hw/acpi/aml-build.h |  4 +++
 5 files changed, 154 insertions(+), 41 deletions(-)

-- 
2.34.1


