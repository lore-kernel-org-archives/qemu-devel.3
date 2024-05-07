Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AB9C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 05:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4DIM-0004U3-Pm; Tue, 07 May 2024 01:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s4DIH-0004Jv-Ez; Tue, 07 May 2024 01:23:13 -0400
Received: from mail-sh0chn02on20711.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::711]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s4DIC-0005li-SB; Tue, 07 May 2024 01:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izs/leD+7EUZ9TYbZLY0N6CmxvtfydSd17xQbcU1wjhMQX6zbi/mIf6Xs9H/icZi81iXM0idv2tHwpZUviONAobyWunH4kDfBneVZn1gS/klKk1/y0ypxyapg5LtqYhxrbvHQtPrwIJ9wsrG/mMgHIX9/WTFxwnfJZoNKn0f5HsUaCNXCHkhghs+8Oy11cnYze/vkXdINt/pH/lxOtALcXCBaNs+kZBq7ml8GQVPHbCwchJihdJkXUgpIIYdfBkm0LYSPQ3z5tE970mKkCXeeGJ7WVlXrhP5cfjLCJcLffztkDt+ORXIM/fzMvTOe2F7khH2sAguAo4M8ZrXWJmPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nt6uin/vJWlTUfic1MlQz0pJWmgrFZIbRUaLK1XOVKs=;
 b=MOSI8UDQIov6oF2/zwnRIXfL+ov3A7o+l1pCUHNyQD44wvdz9zkjI3lSHPaRToKm3/uWehOjDEwgfNZ3RqjHrKtfzaoj4k90MBknl/zduffhV3R9a6xQLKqX8SnWSGU0EOZt4q0lArcAnY90IEu7EwdPMbTpZ3u5jTYcRdB8OzEQZj5gyA3+Kf5+cNaL6Cc/5G4NwMOC6Lm2d5Ib1OmA2ZDg1HGtro6YG8xC3b2cSd8CpObOgGVqAZsVw9N4cneSHZ5b5TrOkUTbwpQ6fF0YJmrWkvIjyvkINy0Rq2NGpaek4sgg/RoEFlb+8I54A/6iiNvDwiB25wzStn75g2yjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1072.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Tue, 7 May
 2024 05:22:30 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Tue, 7 May 2024 05:22:30 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v2 1/3] qtest: allow SPCR acpi table changes
Date: Mon,  6 May 2024 22:22:10 -0700
Message-Id: <20240507052212.291137-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507052212.291137-1-jeeheng.sia@starfivetech.com>
References: <20240507052212.291137-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1072:EE_
X-MS-Office365-Filtering-Correlation-Id: 122b17d1-ebb5-4859-f750-08dc6e55b0f7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q69iftimE0VPSEAcWAvhr7xyyvFFGJfvuibwgoJcE94N6/lHkbPwxAQ10e17MDsqyI7a4NJBWQzzZBHyn32fI2Aoa28hnPG0bi550pibwGJw9JDBP7nuDqW2wlVmiO7EvtbL9CIx33zkiVrAvJbMOKTL2MfSd71cBs3Cbj35B96eGZQ94Ssrjh370kDvf0x3O0Ow0yF3TVlMGMM601IFFFK0VuQ+6wF1trsaXt50Un+NeI21ZNKMemy81OtQuQgXsvWapI6SrHAGVi4rlvZ1oUz3/jfiQCVnICOcKQ5gVLao7cvaaFztKj/7M3KuBsYeQ919Qs/v62WExVSJ5JXEsJ2+fZGMLR3JRjqDbwnxRfFlj35hF6bbdrCpOMLjCGxjuQEHEoUHExxYJgwnPC3fsNZXgVyJuYv6EvJiZh0grpdmLj7tywlPbpomuYjYvH3XHrs+eYm2H1FdL157BVMYeNU0OSNRzWxAWSGbrzsi1WKoOSf19B+zp86O4kpEw3WXjQWhTEuFSdczoBZCd3Vlj5tPOOuLIIjICYrmxVwlJb6Fi2AGexYeAHaSN9kQXd4/zQvD7nEU1RZaYt9VRun5Kz3+BRoYU/Qxx4nMo14LBA3asJ2Z+2rQWj7hiRjlAWUf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(52116005)(41320700004)(7416005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1u4J+Kklq5dHI50Wlm/j6MYbIkORR65oHLttPDchWv32+vBtmuWyuKpwjbFt?=
 =?us-ascii?Q?i7KcFWNKjcri6zG1mY+VonqAbGE/qyTKrEhvjugoDSRswheJVfinnFDph7XG?=
 =?us-ascii?Q?2mCtfn2FNjqJxwNdd2AposEmm+h26w6a4VfcG9/EGYdqAmxzb+Ql4AbxSGW+?=
 =?us-ascii?Q?M+fUchHt/Txf3DHlawGuymY0MJf0I3ASe7A0ri9mfMxWNMbnFzT0Zq8ZlxR6?=
 =?us-ascii?Q?jDzlKssttBjt1tCSHvVrZJMV5rpinLftXevDBDhypv/jBkVtC5gmvu2nLZCB?=
 =?us-ascii?Q?5/tjTXAw3doFw7x4vFA3tyaWKvOLEdpu0XdxqbjvpTUa0SYzzcay8Vw2w5WN?=
 =?us-ascii?Q?6gV62x5vt9+eQ/wfHejrryysL2MMdHb6sYvjVRqSMH/ruhczmCTL6lcHDtJa?=
 =?us-ascii?Q?chqESW8rJD8pBD1zTpPKdt8qXcETp/Ru0Klksns81QwueQ6vsg5/4zNhd1HC?=
 =?us-ascii?Q?TqtsHbprAPzJRL7mU2OrDf2Gd75GlUavbDKyCXS8RLMCO4WC5ULOfoyu96Wm?=
 =?us-ascii?Q?31NUBng+09QltD5JaDT/pysFxgrYufdlaN5And/xeFWSWAe9m5926frATpqZ?=
 =?us-ascii?Q?9419pXICbmA0VzPSx865D2LpOsnSOJIXLJjaxpkhYOUzQxzDtYFn1kt7fH+L?=
 =?us-ascii?Q?fr1lDsAq9ekpblLC2cYLomO9SfmfUuMSKeTyvSF7GhJQYTPt8SzLsqpmNCbb?=
 =?us-ascii?Q?r4psQXzUuY3Z9M3LtaRkt2tScstvooDYD0MIq6Tvrz35kRh4XzJ261cu/lDe?=
 =?us-ascii?Q?Pso+Ul+T16broPFpMelVhkOie4J8K3/zdxJ5A+8opkyeQ1Hr5LNQGx66Oq0w?=
 =?us-ascii?Q?yPCqh+AxdZY3ojdEe5OW61j1myMbKGsENqvVfW0bPS7kDmnY/iiEIM5i7ywD?=
 =?us-ascii?Q?s/B51t2N5nloOVMhNapQZDDFy6snBGhLLd2FSRYGmrh+j25h99mNoOY/qpg6?=
 =?us-ascii?Q?xtrpgb33vWgg+r0XJKSCc6feGY+IokpzCa4wNTcPbmw3qWCX/9+yE6962j+0?=
 =?us-ascii?Q?I0LGFkUvI00BrmJL6QvJ28Qzc2mvJsna8xV6Yidx1TMS40SEekXsZrMjvhiP?=
 =?us-ascii?Q?FbPMLYlx6kZ8IL6UymKDsv5f1w8nbWttDg3A3nyzUix2nTOGzmelMv4oTLY6?=
 =?us-ascii?Q?Bpi5JHkralWiALnNxMrKjvKmIsmLPO63xsktTMvpXBfXr3GKTgmEmTXksELu?=
 =?us-ascii?Q?NjkX2R+6ziQVfUKyMkl+v94N3ooMmiH2/qdIYYE1GJ0dabMYWt7fYzJzSHdK?=
 =?us-ascii?Q?Ytsidh2ck2nAMqZjWBOR1S56yyN5rMNMAatrA2qNwVBBSBO3Y2G42mniuC7x?=
 =?us-ascii?Q?f9itpI/yFgp5Uh4C5ZpWktJtvFgy51jnqai9f+Du01fgjE2dQT0nRuAN9Pgm?=
 =?us-ascii?Q?8dtjKuVOj9oE9yQWVTHC6MYfzPxS+hCCYJ62PtXY7u1melTZQaLeg1/X8Z3j?=
 =?us-ascii?Q?MzA1Or5mO4NrRAJZy6Kop6gSaOqyfklWyIM0meVulTJFfe126PmoL7weGqP3?=
 =?us-ascii?Q?tfdhQGaNZkYWDWIAPc99LsSEHv0J0ZBoUiYVtW7jTvqmpFc/EdziJTtRDypk?=
 =?us-ascii?Q?MM0OMAHa2hCRrOySxXR6hpLVLb3extSA1W/BzYQqwbFLXheDum5gk6UO/6Jy?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122b17d1-ebb5-4859-f750-08dc6e55b0f7
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 05:22:30.3285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IB5PuVUTKxYj1N1ixcM4hqE5e/W1GTIt10H8EKrzEuxok4E8kVxhsc9uPrWKUQeYIs2RWQlF8DRLFJ5JEGlsAl2XnQ7zIoxOvg0I9+TFsFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1072
Received-SPF: pass client-ip=2406:e500:4420:2::711;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..3f12ca546b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/riscv64/SPCR",
+"tests/data/acpi/virt/aarch64/SPCR",
-- 
2.34.1


