Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327FCC531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDn-0005K6-UC; Thu, 23 Jul 2026 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDO-0004OI-Et; Thu, 23 Jul 2026 11:20:02 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDM-00085x-23; Thu, 23 Jul 2026 11:20:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwdUl4rxQxqLmdUJnMlV0fK1FKPDTZb4yB3ULSDVDbl3f1x/lxxhJDdZimqVfKCNzhzwupnp8xawE6ocwk1T32yCMGDp8zBWrB1eKgt+CC/v0Ui66pNl91yCUo4utyXnYwBmJYt+hl+AgwLK00ekaQgO+r62lMZXX1brpQzoHEWmTZTP1rooOuii0WWqb8mEiNfQOeYrhrvgPGmmh73UOTyVYMye3AOozMDuXgMkxT/gbLQZBJKIIsgddkSEV6DBEGdS65B3urJ3myG3p7UN0wBIP/Vfevn1tOYQSN9gBeAvPUDP4e3F3Adk2k+wPi2N4avUVvRwJLvpYP3J5fJPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvJKkwfpqWBr8v6Kx/2XNdM5ogAtMQQ/ADt+Sk40TnU=;
 b=dzDTjgdaC9Z34chnGZdQdTBL3+5Qo+YufqVh20+zU8wn3YSEUFFbo1tDf24Ymw0YgtvqLHqmb3FqXdUGhTEk1FzSw6XOp0ob9MEo3NtdBfgdUAy+fslURMhZstaPbKkpZU8nf8nhA7+Prw/kjzBvrbC3wjS7vjIc+MUSQ5Tc/0lNUjS3GHuKQeFWUvEfm9xCBgrGv7Tq9qjjSB4tCUO58vXIZMr7IMdcNoVnIewqr6XrAlS/O6Y2MY/oxMH50JULzwcnzLPbHGL9FUca2Ss0niZbEHNk2pMzy+LbS2kyD5/ZPl0hPpgdBEO2AdPWpiDZwqMHbx2EsQOwv0boN7aF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvJKkwfpqWBr8v6Kx/2XNdM5ogAtMQQ/ADt+Sk40TnU=;
 b=mVUxyYcGkmMSXDcgbuZTdys0v4HxvPKHo5sj5uFrUiEho8tG9RQp1um5aW3t3zeI1ovyCgqOwtxtqH/jiTvbZtxJbAPXu+dMtutTWHlbKnAMyZalNOEDjrLfvqco7+nD7xhETqDfsOuOkU7uiA4t7cW3aCGkSVc9ZB2N4kNc1QUUyCHfhdKY+E3MJTc2mk/HzH3WbC1TYACE1zVLa5QH6xnJdlUj19b2780Ava3Kbz3iHi1BkuSV4aaRmgdzaglBs9zMsoShZy30Fxr7qLs6ipgzrpNp19OK7yyv2G/pRB8cj2il5c0lNcrZxvW3zABNNUdxcOE6ZpsJfKaUM22UoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:44 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:44 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH 22/26] hw/riscv: pfsoc: Fix Icicle Kit hart count at five
Date: Thu, 23 Jul 2026 23:18:49 +0800
Message-Id: <20260723151853.2143177-23-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd70847-6bb7-4518-7e31-08dee8cdd362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|34096008|376014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: xq7fujII3LFC6ytay1ZiS8fD1PivZZ+4pw/UPbnPIIUHLhlVVWMwzwhqUI/86aZqQFg+i891Y/h3LkX59FjxDAlcA9XXJUSbG4JlEGpDnTt+2yt790dgNwtYI/8UBN46i7lbOqNjOAmnna2cucZx8F0UyBCaplpqBHFFV0K/NDGRUN3hN1DnDDy6JKpfinvYTooKrRa1hCTK2v0DKkYL07PRMpr230zYdQMxp8DLc5phT1KuJojGmKtXda2wiGn+2b2xAJH7R4dPkf0q95DCVspUUfZr5BSNZJGVsAzUuMi9lA6QR0ZK3TK5y2IN5bCAtSc4ahPdgLxLjA8h030oJniTqr0I1Tc1MldLmCobk/zhRrrgvsR+8732tyw47hkRcheeGvgT5e+NGhvPtUsjxUffbgHF90aRzukYBDnGw9EGn3ciJoVAxt2H66hkVP+k4czZdUzgo3Rx+X15lQ9AeqH0zJ6iqKQlKnvjy/4I8CZd0nFp0b8jjT86p5KPw2WYcQ6NC5iAzR5HeISajgw2K4noN+f2hajb7jTFALP3y5F2S80+fNw5Q+uqbINUmNswZtUiSJC+7zbUsTfNPxFqmOZo21RucbZwd6Hu5rlOA5LU/6VvKtpxT7/hxg6eFX9/mzPznYh5dbtZ+eId13a27LGHr2GbWggzil0XYF5+diw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(34096008)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0OZkFCE3qYepI3EKF+sWNs4VfTwrf9WJLiWomXYrJeLeMfU5/UjZEA2zIqi7?=
 =?us-ascii?Q?HvGJU53y+R64fnZPOPaIAjrkpFleAb15ymto1purmYgfVemwHys078LJwgP0?=
 =?us-ascii?Q?K4BVFMqNN1abXQjEm8LdlTivgX8Yh4+N5gpVA17HNr5PqV4PlgITw2sdAdry?=
 =?us-ascii?Q?ftAjxEppyN1Vp1qIVwTZYDO71f/qhDdIYKCKdDhpqyYIwxy4MrZ+vtAkm/a9?=
 =?us-ascii?Q?2omgdI5HY6NXwitOSAp2mBtdyytyWn7yyBgNAVD6yKI37yscgHLqUTMo1sID?=
 =?us-ascii?Q?KiZjgslBSzffT02gTA6Isja6yOXOO9V5MFFaxVNFu7sHr3TE8Wj/AAtHAXTH?=
 =?us-ascii?Q?WIstKZHFdtuENwTKYc2KHvtAlCKqmDnAux2pBzNGpSa8eLOyZuw010NSuN6I?=
 =?us-ascii?Q?wjNLaYxSfP+3ZR0og+753Tnen8iO8iX9HktWL2v7GGpzbVucVQdhs0mnEqa2?=
 =?us-ascii?Q?xjNUSiESjnIQEdaq8myfJABr0FYUKWoPhAdyA53N7uSbIjPcoycPVPXdb12W?=
 =?us-ascii?Q?0etp0I0/FPkNQn3xR/8e8gJxSO6lK38BioMwpFxv4isFSyiAZAnX+Ks6okFD?=
 =?us-ascii?Q?eJ2nnOYzvudZVs9JF4nI/d35g8OACAlEZO12tpG8KOSYxsLxUmwgu1IvPR9B?=
 =?us-ascii?Q?EeyAh08kXEH1w/wfdvB2pR7IUkf7cFRl4/nE38aHEv1RX0D2ZG/Gum0BOLUq?=
 =?us-ascii?Q?fbEcsnr2ANki3Kq1rw/sVpbrOsG2NsvE5uMgMdwgSi+jWdyAlIt3dqEOBmPE?=
 =?us-ascii?Q?7/+WDplBs8JwLtzhoWxHw5JbBypqjxoYm4sd//o0PonFORa1II7Tkex5nUh7?=
 =?us-ascii?Q?kPK8O2PuJQ88BaBnnHU+UdzWIcDZYJymAeKkkcLRqbGajzp9XUx1flsmt0nK?=
 =?us-ascii?Q?NAgbwuMsjX6ytjbfvLKSvYH42rS7Qmdj5TekaWfnpFXpTsi/CWZHxb6gxDmR?=
 =?us-ascii?Q?AVhxiP61Y0X8WKqTRzQTUHFmPdX0RM7dNCpIFWBJuZ8bin2gvDwWTi1I91XP?=
 =?us-ascii?Q?ENods0p6liC9n7owTIxW1UKyDurjz3isiGLvzMGAXL10VqAfRHB+1g6U0cZK?=
 =?us-ascii?Q?aBCqbPM4c7TeUPCSE+/cYFlMqTqk1n+i1fsX7DpznZlNco5CP42POXQXgj+v?=
 =?us-ascii?Q?lY8k2wfj1zMZsxkkDlgRjzE3vWiybTnZ36ddMT3SP9kU7PMkORwPvQ1siPXb?=
 =?us-ascii?Q?8pnADe1vNcbzWA/IluCxrXwUrYyCu4+kVmwFiJZ4cRCfd/B9ryTCeUf2iSd8?=
 =?us-ascii?Q?CZ/Y/AnA8r5ocv4qdhHdFBcJAJNF8O7w7+RMuakuEnpI+uiZ6roVdwtoc9rS?=
 =?us-ascii?Q?AQl4/+enyENsohaoahaDsulUGI4Sp9tLmD436nBUsDBwIvj9FaWcidOhfEGu?=
 =?us-ascii?Q?fRyGGVBP1fGzVLnUgRZQgRiSg5n6B37g4EsTmJnJ54u8yN7hu14BLdGdinhp?=
 =?us-ascii?Q?GUoWmJWQvKxbzkB/9h3e9JpLwcmgMztIHUJ+s24MCQUkK9oyHtsrql6DShl5?=
 =?us-ascii?Q?8pnx6CPZA/OP+hFaOYWik7AbGOhrQs0NVUHq4NuuJoCixFNZPTQDSykznjPg?=
 =?us-ascii?Q?xSYQsbj3vt+Ddzgum7HpcVoBPfUP52vlXWpuzsdhhOaYt+rLliTIrFA/x0eH?=
 =?us-ascii?Q?stEm9JyrEQjvGyRDaN/W9Q/hcrMj+nkjvBTLgUGvoVv7INDT/3chaIERi5xD?=
 =?us-ascii?Q?DZ0z8qK8NnUI19opPIFDOEl9OrH9aycUaA9OK88S9GDVqmj5T8nuACIkeakl?=
 =?us-ascii?Q?84ULwxlVDVGNST/OQsuMtmflijEZSDU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd70847-6bb7-4518-7e31-08dee8cdd362
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:44.7181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQRk6sVew/45p4WBCfnRsC0Kb3Axahj0rscJBGDEXiTar3z8JEQ0khelBfDD7B4OxTwXUumPMLq7c6vGVB7q9Z6FmPZfKmD5RoeoO176E0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
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

The Icicle Kit always contains one E51 management hart and four U54
application harts. The model currently accepts two to five harts and
defaults to two, allowing configurations that cannot match the board.

Set the minimum and default CPU counts to the five-hart maximum.
Update the documentation to state that other hart counts are rejected.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 docs/system/riscv/microchip-icicle-kit.rst | 1 +
 hw/riscv/microchip_pfsoc.c                 | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 3db2b3c7e3..38352cc62b 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -27,6 +27,7 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 1 SDHC storage controller
 
 The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
+The machine always exposes all five harts. Other CPU counts are rejected.
 
 Boot options
 ------------
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index b604f7008b..1562423930 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -765,8 +765,8 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
     mc->init = microchip_icicle_kit_machine_init;
     mc->max_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT +
                    MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
-    mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpus = mc->min_cpus;
+    mc->min_cpus = mc->max_cpus;
+    mc->default_cpus = mc->max_cpus;
     mc->default_ram_id = "microchip.icicle.kit.ram";
     mc->auto_create_sdcard = true;
 
-- 
2.34.1


