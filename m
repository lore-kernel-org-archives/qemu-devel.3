Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C52C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc1Y-0001cE-Ce; Tue, 15 Jul 2025 05:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0v-0000WO-0b; Tue, 15 Jul 2025 05:31:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0r-0005k8-10; Tue, 15 Jul 2025 05:31:52 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F95GlM014076;
 Tue, 15 Jul 2025 02:31:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=m/tuR47Jm2jNn6B0qAPxGOhT/JVnhKkLifcaYBW0W
 WI=; b=qGcLenG6tKocS7s0Vx5lGzzbSciIbRqbkzfBnUaU9DSHaEyc4j2R0J1GS
 RAN9D1P3KwPPNtjzs0wpf2ZzFeDgMuhpLWt1ZuTtEleMZF/UlT0p6Pr6E+NI0Rt9
 YeyOnUHPhS9MjVp3XmDDkXCuRUVsFAav6Z9o08yxs9Spbe55zEOqQ2dVV6oZXSQd
 BN18NN+Binem7Q5VMtFq2wk8FagT2DQIyxpT5X4lkbq/0fxPnRFQ6Mfvekv4wm6/
 qmra0V0MfPVegKj2kylwiiNYGLMZGXzgRZZW4RHiByqD4vmDWFKhF1VpoI8jieVo
 +mWrpGYwNzoD1N3GXmigUPs0sctZA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2099.outbound.protection.outlook.com [40.107.237.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47wm1s823h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8PO7eaD4AKg5pb/gEi4mvENb3INAsRmu/uUUL2Hoj6m2tFxp28XZjXVwvjTzPI92/OWT0oqzY0UBObgrUwsJTgPGZELDndDRR5dNcZcpG0JNH2OO8W/jvX9qK214mHHa9go6u9Grcl3VwahlEUA9a0htsiyb4cKhNpB7Z3TjvL9v3UItKqh0RMGlIH7aGqOsx1K0QwaHY0f7ufnOYmC3Cn4GsGlGTW/mUReLppYPOsXPlNB/XviK4iIq+lq2MNLW4qR/BeyximqfsNnEB7jYEn65JB9/0rGAPrDoCAElbf3GMqofJDFmNUoc+3L8AnML1iZZe8e/CTlWd64WUAxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/tuR47Jm2jNn6B0qAPxGOhT/JVnhKkLifcaYBW0WWI=;
 b=TRZuohkmvx4rA10uPb/Co49nJDHslNoUdSk8PI3nHPDiRepT4FVnnH0isq/PKpNg4gTJKFJVrMA3FI8ZdlcQtnpqXYloJF2GhhiEXEV2LpV9WkJAhquYcDfw8YE6H/YoFLUYCwNiRJ9tP2hOgHPGv9BnQBsvcQgvwY//E1BDhsIyfpTVq6eGzgk0pMd3TlSpUZdlpOR+HCuqFZMElkm4dThEsN57O07F2E2/u+wwS+DDjTdI1riKHYvtvgSMPRXykZmWgOGiPOVgeWjqSd9WhU/1Ska+ePL2ZXnwa1dNdpbGSJ5JUrlSBqSrt9iVxajqSG8bAwleKDg+Xe5FaPp26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/tuR47Jm2jNn6B0qAPxGOhT/JVnhKkLifcaYBW0WWI=;
 b=ckidaL14sjhn64f+OHWjKsf4zTAD33ZQ8cNXHOJ9gTGPoEOlb7UhuxD0+c00ohleRo9HOjY67pskJs4g6jOxFzanAj44VIeWT1tILwv6WUoOTY8dh2Jxqx5TIQB18QoPPPQ1CCASdmrV+PwSXbUGW8j2NtCx8hpORpJtskmN32GWS2vGRCiABHWgthotDzAs7uMzV5w/dEOyllGWgd79mk0QBAMyTPyYeSNEuqSnz9tVfih0bkkPunmUK+84MgU8iWL+KZCXN0V0IxwNKrKnUQPmmq7XWBx3bht1kxMAQ3wxgLLFm/KNIGsxcNPV6sdUwztqXFF03lPIN1ES39tBdQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:31:39 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:39 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 07/22] vfio/vfio-container.h: rename VFIOContainer bcontainer
 field to parent_obj
Date: Tue, 15 Jul 2025 10:25:47 +0100
Message-ID: <20250715093110.107317-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 154bc0fd-9121-4735-83db-08ddc3826685
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oFWk4eY993CNZHC8ZIZUbaoie+ieqagRz00Jc7zciGD1joYNl+B/8HmAi8F9?=
 =?us-ascii?Q?oDtqqbvieon75Q8+5DaBWpgugjgiGQ8h8HBiOWrxP0CNC7yRrGgACo5iRy2o?=
 =?us-ascii?Q?lXJ6UwAJpAzCn9sfvpv2RALpl4CSyw+16YX0ULCweThv2h431bos74RNJUo/?=
 =?us-ascii?Q?UZZYQLqpTTEsmK5kbDVkWQwtUQ5/u09Zt8IDBTUOq2TgLsHKCdXRCByxc7f2?=
 =?us-ascii?Q?G3bbza/1OA+o0CdiWfyzpQTK8GCsaZ2HNbATKsniTXPDao3JIjH46X+jZZ24?=
 =?us-ascii?Q?pKokC6xbORsZnx9QkcNGx5xmHmlZsIQ9sD2DTgAXS6PlW8XgON1/xSCNdhus?=
 =?us-ascii?Q?W45Yo8DlLk2HdTHfAc1d3yTbQqCVyjojnPGa2CvckK2xrqPFIck0hW1PDn6d?=
 =?us-ascii?Q?+dpZoUygwuvJwCfM2IfB8PhmnO5LNKtyc+hhtFw4DTN9xXgZuni7oOnxgxIn?=
 =?us-ascii?Q?8q8pA7EuyGROlNZRSS77cYSOdCuGe55lyni0BLWSO0vK3UzdE+ohu2rLc0l6?=
 =?us-ascii?Q?VzGhvt7VlGt7lDTocNHlfXJcmARenVFpeYGs3UOXmKKaJsl3l1dA6dNzTPEu?=
 =?us-ascii?Q?IVCHrJ86Aq1SO34kuK7iYY/3VitjBJkdrD743H5UUdSEdcfc5MS101EKOOw3?=
 =?us-ascii?Q?3OENfn1Jzk5BZ881+puqB/2JNXf29x0QheOVCTCSSNon3qN5IOCRZhWKkDuH?=
 =?us-ascii?Q?PWaEBqxOiBVwa7dFhQb09TY9M3TAMmvf/jtkWubaHF5wULN+KRJhri0DskYE?=
 =?us-ascii?Q?gIA2weQdGCN5e8FsB/iGyc3JagA53M8UmV3SM9bam+QJYo3/ruXvtrCKlcK1?=
 =?us-ascii?Q?RPn7mXxtT4aZmJ78Wn2XW1EQlJ9aeGto5Ww4qkACrSQhARhfeDHube3cK6Xf?=
 =?us-ascii?Q?e2kODSVy6pfJ1/I12D9Qpg7AzNTc6BfI+h7HSaFfQcy2h3gicWrUeSfH8p8z?=
 =?us-ascii?Q?m20JchKBuLIcHT34nhRVzvTqSZ/QYqFL9RYln22R1MXiWSvHQLmue2w5IY+B?=
 =?us-ascii?Q?0eb2C5nnKoWFgWWpJuCKO76f4P0OkaGi6QyblH56NKj+NJWclFtNAzgRFwKn?=
 =?us-ascii?Q?zOz8lgeaXp1JOnayI9HKKbc7txtP15oYRIGn7lQK7w6ewbGYolUgldKgOzGz?=
 =?us-ascii?Q?GOMw3SvQ0jrsbJQLr0/iTIcoJ0+UpjRgGQZVOUCmOYS1DqIf3AxXoTu929Ze?=
 =?us-ascii?Q?Si7x+EiXkYN7bxiVmf4V8Tpkj2qkcoxVIUOyWW3TGZaBhQxH6zoLy0oGBOOk?=
 =?us-ascii?Q?FcIO8iodTDF6PDmQ7JAMJPQm7y8IHzCjkpx5+qvxOF5o+sNsgyorpshXXGgP?=
 =?us-ascii?Q?oYGzCv20ftkEkCnHTuc5ARXhCH1ffmettRsV2dzkvgVafRgZcIrjuuTk14vG?=
 =?us-ascii?Q?Qy4VaTNSnCapiKCWzoTWWKkeldTIdhLgEOtO2OhYxvbvK9l+5T8yypE/uGT0?=
 =?us-ascii?Q?HelsZuK6vjnrNtdojJNqCp74jO7MGptFieJxCLi3L6t6JYl+AKvPjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/brPGGgubbSRgy+vbDhBtXDHQiyaXSUndfL52HoZ8hT2Y/zW9DLmpE5B9ni3?=
 =?us-ascii?Q?jX/I+U7L9OYS+nwaLwBYlPHRyoJWhY5t2DL467nrEQE9/G/c00KMKDUsve6L?=
 =?us-ascii?Q?nqdcQAa1Je+PIQlM6uCFgjLYWqzYoojI5i3NVmrniYRBHBSnwmU/T507+BZX?=
 =?us-ascii?Q?3z8Z3AD3eZnWqLvTqe5e+2aENzi02T6Oy7hwy8oEkliUNUAZUbCSA9xuLBrH?=
 =?us-ascii?Q?2N2XM4jif6q0OM3tesyT2NVtX7ceasd1rk3WNWyVsbVm/HmCXEV0ujALjoBp?=
 =?us-ascii?Q?DSJUT8eclyz/nGYDsF6LTKAZLgaw45uETtnFwXaxxHk5GnYH/FuEYsOL8ezn?=
 =?us-ascii?Q?JLIxOgafsSSaK+uMbA5bhu9ynBLaZlKkhovYavxuzia/62GhKwenrP30AsiO?=
 =?us-ascii?Q?f1KvgQpxHtEC9zsFdVVoPJOMzDfCRKyrzJHtrsswXpfUAYESuWmw4jk4hEza?=
 =?us-ascii?Q?OijF7Q72WrrE4qWR3xsWVKXFfuTP07yQo5XMTlC2sKNGnOQOpYgGSwgowiKP?=
 =?us-ascii?Q?hRbeHVK16icPdGBeMTJnHn7bNP76sqRLzA3zaMHe0WgT4RuI1GVwANXKkg/S?=
 =?us-ascii?Q?Py//ICTEmQHXPTRZDySldiPK6Dh8cDY5D9tmTuwS9fRVAucuq4zUP3rWTOlb?=
 =?us-ascii?Q?tvGATeN4qZdLXKvrUtqJifyFaFrqV0ND3m4fh5XtDt0q8QkdeOWjIphJy8Vs?=
 =?us-ascii?Q?vcBotFfctVogi1dmpk8BluzhKW26Vr8xl5F6KSxLzkvo8CAx9RvlQLSHhfIs?=
 =?us-ascii?Q?uBemF3gT/WKgr+W8p34OllIonnAUDtAGaNz3AxnLEtnTLOI3SzugWZtiV0P1?=
 =?us-ascii?Q?9axMFDc2UmHvPD4brQsz67i0m9BG0qTQPGh/e8W0QjFJIoUxrXHrcE2PtxC6?=
 =?us-ascii?Q?56TiTCrgu8bIr1HWE+2zpLFDquUhbtj2ZhsWZzP997tIG06UOlGr4iAdJMMW?=
 =?us-ascii?Q?6HLJAuyXkUFGhBF3Flc44vuE6us07Jg0zWvNzlN3zbE9q7hnqO2uUVnJ6UaP?=
 =?us-ascii?Q?Hr3+FZQi4LF8HUieYacwuL1VC/X94Ba/ifF0MGW7SrpTupRxvgmhLB4eCdfJ?=
 =?us-ascii?Q?ckTBHSFGHuOzKq01kPy36+idqOn07kPfWv8lIjg+sVbVpz7fDjw4MmyRMrLe?=
 =?us-ascii?Q?ZhOnxv0qZkf3X4yzVIMZ+ViEBhERlsQveYOVX0WLSyWfsMwIsp4dXIxG0BcZ?=
 =?us-ascii?Q?NuDsyNBm2AhmjBZaipapDvLV2xgTUcWA5phEI6dC8ktqpgSMLxd0yN4Ils1e?=
 =?us-ascii?Q?qFm1Yqjck5PNH3N6XiivA8Nosy2Ns5dCywbpd/8QasM3TuSdN8gZ2K46msaP?=
 =?us-ascii?Q?OhXDxAI6GzbV0RG1py+kXACDXw5XUm4k3ZTiRgQ3iDvau50yUP0Mav8/oDrD?=
 =?us-ascii?Q?JMZla4PZK/CsNrtHR6ZRyktDSFmxWcfAd+FlnRsdHXi4OKJ3A2y9GdkGPIgg?=
 =?us-ascii?Q?N02Xt1EUoB55bHqIWCGvZ4lRwwmSDdeUNomS5py0y5clyj9wCdHVre0hXRps?=
 =?us-ascii?Q?il6b6WwOfa1ZbJL4ZQ+1ieOXPy6bZgl19EdFnQSEaLX0f3aCh4a0DFtctpMU?=
 =?us-ascii?Q?vzzcmHCdWB4HIqeuxj8KS4P8nH5h0itAKv0jaIHbosYGjJgf5zb/7qnB0z9+?=
 =?us-ascii?Q?5WJvByUOpCBIT6WLrKERKRf/NwN0OqOFo0aO8b7KJGM6jLZbOQcYyd9ADNua?=
 =?us-ascii?Q?w7RYaA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154bc0fd-9121-4735-83db-08ddc3826685
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:39.1803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yD/fGdJRycumPLeTLmvWZJBejiV0qPeZGx61sbpyG7f5e7U/X7Aajcd9AKkT3A9xZb7h1KnylYTWHPiVWrSk61LgY33HRUOCnIs3zrCdIxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfXy1qEGcfTUUQM
 B3s0A+1uSOzoU0VLDwTc7Tu8IzOZSSAfG547Q3XANJMA7Vl+Oe1yyNs9+BLB2nMucOaVKTykQzs
 0NJ0yprIGUAWYocweCfvK/3WiUa6W3CJg58UiGj3ZsiF2yLHnuoLlTy6UJAImno3K/ioH2TdXAq
 SnqICdRSb68/AW7kNamDEdYimydRIPkGaUFmVfQ18nbYoDg29YY0INbiDcINgv/f17artkH6no/
 kGbJ+2rXBA7JuT8bw4KJOhU4V/dzwK9htr2LTxh8VkJkVGrKXinqw2gSiZ4mjstQRv/6sZdHXle
 n/U8+Wn4+CiNvzTZmI6xJ1kzRjkZnN1qC1YL9Im1e6E8izwGSyl8LJhyjpecPOITEBYTgS2SRky
 JbnItlQlF2KozcT0jzAq41T1gWpkIR2SzOgJqxtx6SzhbwkwebOX3djvFAwKhfPPZyl/Rj/N
X-Proofpoint-ORIG-GUID: WrJe5iUr1wn6euEGANyGIwEtnQ00ktYu
X-Authority-Analysis: v=2.4 cv=fZity1QF c=1 sm=1 tr=0 ts=68761ffd cx=c_pps
 a=jXf4nmV5bj/qAQq9M6c7cQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=8L7MK6Kl4ER3plC8pQ0A:9
X-Proofpoint-GUID: WrJe5iUr1wn6euEGANyGIwEtnQ00ktYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now that nothing accesses the bcontainer field directly, rename bcontainer to
parent_obj as per our current coding guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/vfio/vfio-container.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 50c91788d5..240f566993 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -26,7 +26,7 @@ typedef struct VFIOGroup {
 } VFIOGroup;
 
 struct VFIOContainer {
-    VFIOContainerBase bcontainer;
+    VFIOContainerBase parent_obj;
 
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
-- 
2.43.0


