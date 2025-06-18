Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49017C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyH-0001BM-0c; Wed, 18 Jun 2025 07:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyE-0001B4-IM
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqy9-0002TN-HO
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:45 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I4kHJp009560;
 Wed, 18 Jun 2025 04:28:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pyfMFTh0lc8B5JHIDXjH7NNnjrDlecuQZ/6deU47g
 Vg=; b=GIqvVTGMrwZySIPeJv7dc5fAyaKOpi5IlhrvfOs5ehfYhIGljVTWNdaEH
 xSREeu8iiJVZowc5bReXu80qH2FN6Ev4uvLFLhjLaKbFdyO66lfNu9XkzqGYT/n7
 HN+fDx1e6qDHG3GIVt+GwRTh6Ql9vqDR/Fd05mnqDNcz8KKTHvR7ECRM0MONnQkE
 C82UbbT15s0SI2gp/rVJ/az2T9b80Q1rbCpE3FdQ4CiAwBKsIGOPHdmRDjrdZEci
 1c/VRxE92bqe7u3MxspKUIuQ2SzzR4vLYnagK4cZIuRKoxOOqWSrkLVtg7pQsQ5R
 xjg2QoBrHaizXS/r0EQACcYlC+jmw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2130.outbound.protection.outlook.com [40.107.93.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47976j0kvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKyVB6TbIb5tOHhxnL7w8wyGSxQVIweVWUUQThRLqIm7JVpJWerO+j+p8OtppwWUpvdHG1XJCoQMXnNbpzyaFchvY38v9fOUhMaro/gjLvMfwAfodwx2R8mzoOQkaapt6mQ3ctRGhncU534u1igKoO+LYnhZ8s9ul8W3FfmIv8AxLPL9MozI6q9caKx0aOKK3mDH187fujZwLe1NRKwd8lbnmzM/uaszTiwXH5J2sok1dO7mLe6KfjNSeN+v3jHKB1F7KAEkoRkaAabpaD9p3yPRm7BMt8sGM2xJmeyzDeCAY1wyqTRa94kn869jrWgmcOXDciUbu01xW7zOHgFRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyfMFTh0lc8B5JHIDXjH7NNnjrDlecuQZ/6deU47gVg=;
 b=hnlAduxEKggb+FShJVslOJARjEBDjUTxJhDoNY+UeBV079HPkBK8fC4EKxJhYr3L/DlSc6qggiEEEBO1koViLpBaVWnrwwghlSiOv0J54ZQwjJYSF7rHkx6NuO9OPD6BlYtORI/YelWdg+yBHyw9zXe2pGsvLnViowqm1NopqIrj3W80JvNHjgKQYS9zwBqtyAeXEfVwfxGG/xVQoeO2jgidQBinJ7tUJTTL7juDiFLqmZD68sMzpUYpho/PORyfszPpL2HQmzyqIz+RTlLOISTeEUMIQiyiIIUs6aPPK2HcQsaa8VU7KWNcy/79dPhaSDQAXK3dEE3p8t6WILOB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyfMFTh0lc8B5JHIDXjH7NNnjrDlecuQZ/6deU47gVg=;
 b=nk9sIHwx1tQSplCr0Y9nWKAy9pstvR5pI752vN5ZGJNFaj30BWMz1LSAivuMsqyOmGmBoesF2yK1RvPLsca8q/nH5YppBNK6v5awuzxT4MZUTNrguvIz19rzsclwfqpBJabophpVHMHf/J/uaM5h4Ft08fpBq7yB55bP3gIM+GKwDuYCXfx7eTPvQ3pRLiuUDY579FeoD2wWdcbHzIzpicp7xUl8xMZSerpSZKNQf7AsxqCZuH/XjUku8kpaHrMPyWc1R/1Ve0UBPeE5VaM4mx0zEmrXi98kWKHUWvI8/J1Zys2qoXimsybhFZRQKKBFW4eySKMB5yjtMUVbTWsrUw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9632.namprd02.prod.outlook.com (2603:10b6:208:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:28:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:28:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 01/12] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
Date: Wed, 18 Jun 2025 12:27:06 +0100
Message-ID: <20250618112828.235087-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0175.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::44) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b007e8c-cbde-4a26-c1d4-08ddae5b4372
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LUUkX6/GoNkDDv00pE9rVAJK6LHg3lragVcErF5SCsa5mPNIZX1n4XgopmVL?=
 =?us-ascii?Q?3wwWFmlse2LkPGWWj/+ArlHzOeJPQBhFOOxMeFEzWKVVuu4WHCvxiSZdIjBV?=
 =?us-ascii?Q?MMvvS+J1PdMCqt1QiQ8n3uou5HPJLGkpRQDM4MOMZMzLJ95Lgl87swvOe1YR?=
 =?us-ascii?Q?74WdT+UWH2Ptfk04ZKf/h6mPQ6umAvs94USP5TllPUuNNki7+07TzNiAvwyb?=
 =?us-ascii?Q?iqkarV0cMCK3ksREeMevVE60B1xzIw3ab6IJLwIm8b5tTA4qjjY3NQwB8uqD?=
 =?us-ascii?Q?3itjtpbd4vjxTtV7hlbUROet6jA8Uqry2gXz6k1HLZ0bsWul4IkNZbT7ZHIQ?=
 =?us-ascii?Q?gtu54vsLvCxIpJXvzBKZTwnZBpd8fPTdQz3doyj0vze6rwVYrOPNe4Dq6vdZ?=
 =?us-ascii?Q?fzZ65Ubn0VbR7e9l+sf6sc/JRx39i78zeQ6FoAfxu6vK9tByW+p+AaSPBvlv?=
 =?us-ascii?Q?Vn59WJcr7dcuxcAQH/SJBuzsKvByzXa+8Jml3X6UK3qYfowGwHYrgX1mFPua?=
 =?us-ascii?Q?BOg15/jYRk35M2aTeqoehUeVv9EFVENbpNGX4tYzZXNok6BZ1qsZiymQBLBQ?=
 =?us-ascii?Q?poSz7WtICMifbjNWNQOdcZuSInvXIXoUfatZtMnrBBEtjf12jlZRWtj+Gprs?=
 =?us-ascii?Q?oEy4vEl7eOxmU+Rb/eGEksedpf0qGhka7r0v5M7yBI+LyuvYYb2ufyRF4DPz?=
 =?us-ascii?Q?/gmArCzAsYhBDkk5rYaHIr8BwnZEKlX+Nf/aKpWvHYVeTrCXpVac8VS8GjlA?=
 =?us-ascii?Q?1F7+lpfQT4U2SCWEgCKIVGbQL/t5Ff8Ej8Kvg/x046vZGNCkr5PKBmJvAz4V?=
 =?us-ascii?Q?tA+SgCvgf0SM0c0i1eUL/wprRx2652k5m+pl12s0MmreWNhDvX3Z0pcw566c?=
 =?us-ascii?Q?z+N7txecT9Asiq6gmFJkLnZICoNFFKPPdVaLIaeCvCY8furf01ta/5ZEoAw6?=
 =?us-ascii?Q?DGReE0OvUTDunrOStPGeZ6OuXPlbaXjgddeYgsauhNQeU7wel0aMQyXt/JUZ?=
 =?us-ascii?Q?XJ7SUfsBHgI5cKNMbnd0SzitmrbD9wS28pnWp0gGATOefriq6m3JlnYbym/v?=
 =?us-ascii?Q?bc9KT13tpIhmkm7+nMR+jt6aknsmSrZVHLio9f3qzyNQENhInyhK0nUu9jcP?=
 =?us-ascii?Q?nculTOmva4S2VxPY/vjle1JajKhALIqgBGdTv7I8M6MbbG0yfgzvKy2CBnOG?=
 =?us-ascii?Q?Ct+1is0XJsK3ciX4CXvK7cqQFEV2RmuFQAhB/7NebX+/ViSzc5M/ifYDmg1k?=
 =?us-ascii?Q?lSXngcNKKdJpI2q7SBDC7lYJJyBcOSiek7P/Bp0Gl5tZwGdqkyLJhyKUMUKV?=
 =?us-ascii?Q?ri3nyvSQnar8jEkmmDrNEzv7PIF+gyYMZ0qErIHmXNzRxGkUOwE8hLd/bKlY?=
 =?us-ascii?Q?Qg53Y+LwAD9w5FfeQCBHFMzwKeiRBcN4vDLCEDL4HQhvvNmvB5IH+U7BiRmH?=
 =?us-ascii?Q?AdPKlHvV6xY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3zhxDpHFUyeTAsVXLZaC3l8naH+tGs/pZgngZf+NmIi+13UjdTyyUROvZQpj?=
 =?us-ascii?Q?VqMB/r+3GDI2/U6YEH4VEZtWi759MbuTRHEXSibp3MbjVgQldff7rfADkWQs?=
 =?us-ascii?Q?bRT5OyJHdodhD8YU+B2uI96WE9rEWiF9Dj297b917Y/DWKpeGFycE1zaEag2?=
 =?us-ascii?Q?flsf05qlFYAgSe4tDQlYc2rGv7dtFxKUUrYArpQ32AySwI3N6do60xYOGkHN?=
 =?us-ascii?Q?2TDVBDg9RDdNie5mbViwiwueujXQCb7Q8uyxVTmy3z9fMx15Dbue+q1fqUEK?=
 =?us-ascii?Q?xjFjg1wdj6/NLuYqVKfxnTkYLXyY+x6Tok7/akEmwY225R361cO/B8Th9Bck?=
 =?us-ascii?Q?xp67MHZvBPhJYpz9o6jxkafTlbCX3l8O4Mg4BPxs1x3h4qdOV9UpfIo95qBT?=
 =?us-ascii?Q?MnYhIc2lRoRFuQfiKB3E/eW/YZ847bdo5QxcYx+r8GObmBKwNBULnZVg5aoZ?=
 =?us-ascii?Q?bVlNiMH/9YI8oqMKVD9ex8p3PM5upm3ClOBIUCShoaX9/d7bP5oVN/X537U3?=
 =?us-ascii?Q?oaBm4z/doW7v7HIN+XY+f3m1OR0fKwmD7PEiMrPiFl9zbEELZ6GBHTmOzXvf?=
 =?us-ascii?Q?p3/5DBpYUXUFOMPZgDiv9b/X7Ga1xZlIiHWw2/e1jS/8mcj3QwqRt72lUDj3?=
 =?us-ascii?Q?vFoEiwxPTEglbon7n838F5lTu9l6CiySs/Dybz2673eQupNEl8M6q752kXOZ?=
 =?us-ascii?Q?5fUK7HvhH7xe/ghBChauhX/Ct23yXjW1zUPzedbQFh4LKSQH87XT3hsTjpoZ?=
 =?us-ascii?Q?GcrcpyNbhmWq6kYn3UmM47qEmGV1vcebQMCovQbOFC9Ie3AkDlO9qLEGD6Ax?=
 =?us-ascii?Q?7vNHt568pTbawc2PmNZdKS91vg1C0CA3uR8AJEupZSorgX7qGoSmQrzZq1SF?=
 =?us-ascii?Q?/NDVHZebETN+6PZSwE2UaDQ/nzh8hzUqHOkYiKKCAkArgrmPUY1H7GACfwKO?=
 =?us-ascii?Q?+mhzysRCnC4TGEDCyspYWB+oytINRXZ3ogK74hYZodaU6hUBKlMiocCfzkdt?=
 =?us-ascii?Q?xTWe/0txusiqAQxL8UH5TVgmIJlfkOQS825zPpV4JuujhAWNIh11TzEjTG6N?=
 =?us-ascii?Q?FjurLRSxzJ4eFCdIB5gKTas+dwyQXJVT9/RlhFGv9aiqHefRPGXgkBN6Yqoy?=
 =?us-ascii?Q?+b5KG1qjjdvW1brzBCEW3QIlSmkSUwjUDdWnMCI8aWbkTbCU4ZvWSJdiHkt2?=
 =?us-ascii?Q?SoJWzaAuTTDOEA+8HGmqclmgP8LnDZa0Oeu1tDdwlG7Qtubp6NzsK0XoU58u?=
 =?us-ascii?Q?BcA4VDbgGzmOUL55tfvyvvY5kO5TrfixWH8zQxpWghEtTR6k8sMLQLZjguZd?=
 =?us-ascii?Q?nRKMK3RtirtVxdMl7iRyR+vDlDHFrQSTxukjtNKO4BzqYtxKqaJsMCBrU65j?=
 =?us-ascii?Q?4neZouH02pHK8vGgscwaQIUexXD0NRiuCAuGCtnN9OYlniI67n5Eei2J557E?=
 =?us-ascii?Q?lyr1YcSr/FPaexotsSAJ5l+KmII1hyiuMK6nqPW5DVixPH0Q6vpMbTqJPwE9?=
 =?us-ascii?Q?CskvHeb5e2On83+lOkPaEUWsj3LbUyPfeBkfe96Pf6ncTaqW9dtDQxF+WpMI?=
 =?us-ascii?Q?rP0c0vQCrfrfM7vxrIxCyv1lIqbQAloRhhiBz+TRNRPjq7mh+L0H2ZBy6Vl0?=
 =?us-ascii?Q?HyRB8JqplJXtC+4U0SCNJZE3+N5hjACutf4mI71wlyjsmX1JyOaPXv5oW/8v?=
 =?us-ascii?Q?GiUHmw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b007e8c-cbde-4a26-c1d4-08ddae5b4372
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:28:35.5384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uipjEEXoc+fkw9rfHtDv0SIh8LSBwAcrhW2KYpBIYYz+yNLmvOrdBvdq7WEPFN4MauAwSLWPv3HMCz0vKzt+N9zBeu7M0fFSqqPwwsj0dcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9632
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfX8bGnP5WfX9Vz
 EBFiOr7Q8/rc4KD7CZB4uEL+pmlG3Bh0+4AiF7lvXquvDglvMd3gAePecl7N/4Qz91DIjGy19bc
 7wXvUcdgXalzNf/IRd1NxXt7t4dUIbtc9jsMESsER23jIh9s4qfnoceVm9DzOlC4UhWgrBuHj8j
 XXThI6hBPDKG2etvxmZzBphXXjPzXtsvx2VIP4xz+5slhRDs1aLZpNOvLZlEdPBQFKSWFu0YFGY
 VKmFPpammmuIp05DCLTSWowjaLzq8jo1N0nw/V1zUfr1g36h9WTXyLfEQTziuU5hTuyjZcIPc8d
 /BFwFdFifIqni7Tbs6GDSczR3EqgjwvViPUDpZ5QhlnxZ8K2cgzMhPM2mwulNTnvnHNFDqwccwj
 ZXxBkuKTK5dKKaAjoqMygMVe6YBV79FvZ12qG6BriGHoJi4gF/hGrFvBuHU3kR6JHVKZ3+qG
X-Authority-Analysis: v=2.4 cv=RcqQC0tv c=1 sm=1 tr=0 ts=6852a2e6 cx=c_pps
 a=0CBzKAtbur25xjsvgbLWCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=tUpV8ruPn8K-tSSEYGwA:9
X-Proofpoint-ORIG-GUID: 7mWxVgJRkiAV_hRm_GNeTzE4vD-A1C0e
X-Proofpoint-GUID: 7mWxVgJRkiAV_hRm_GNeTzE4vD-A1C0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is to prepare for splitting the isapc machine into its own separate file.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 260 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ea7572e783..9842d2152b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -418,7 +418,265 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    pc_init1(machine, NULL);
+    const char *pci_type = NULL;
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    Object *phb = NULL;
+    ISABus *isa_bus;
+    Object *piix4_pm = NULL;
+    qemu_irq smi_irq;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *pci_memory = NULL;
+    MemoryRegion *rom_memory = system_memory;
+    ram_addr_t lowmem;
+    uint64_t hole64_size = 0;
+
+    /*
+     * Calculate ram split, for memory below and above 4G.  It's a bit
+     * complicated for backward compatibility reasons ...
+     *
+     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
+     *    default value for max_ram_below_4g now.
+     *
+     *  - Then, to gigabyte align the memory, we move the split to 3G
+     *    (lowmem = 0xc0000000).  But only in case we have to split in
+     *    the first place, i.e. ram_size is larger than (traditional)
+     *    lowmem.  And for new machine types (gigabyte_align = true)
+     *    only, for live migration compatibility reasons.
+     *
+     *  - Next the max-ram-below-4g option was added, which allowed to
+     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
+     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
+     *    but prints a warning.
+     *
+     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
+     *    so legacy non-PAE guests can get as much memory as possible in
+     *    the 32bit address space below 4G.
+     *
+     *  - Note that Xen has its own ram setup code in xen_ram_init(),
+     *    called via xen_hvm_init_pc().
+     *
+     * Examples:
+     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
+     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
+     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
+     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+        if (!pcms->max_ram_below_4g) {
+            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        }
+        lowmem = pcms->max_ram_below_4g;
+        if (machine->ram_size >= pcms->max_ram_below_4g) {
+            if (pcmc->gigabyte_align) {
+                if (lowmem > 0xc0000000) {
+                    lowmem = 0xc0000000;
+                }
+                if (lowmem & (1 * GiB - 1)) {
+                    warn_report("Large machine and max_ram_below_4g "
+                                "(%" PRIu64 ") not a multiple of 1G; "
+                                "possible bad performance.",
+                                pcms->max_ram_below_4g);
+                }
+            }
+        }
+
+        if (machine->ram_size >= lowmem) {
+            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
+            x86ms->below_4g_mem_size = lowmem;
+        } else {
+            x86ms->above_4g_mem_size = 0;
+            x86ms->below_4g_mem_size = machine->ram_size;
+        }
+    }
+
+    pc_machine_init_sgx_epc(pcms);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    if (pcmc->pci_enabled) {
+        pci_memory = g_new(MemoryRegion, 1);
+        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+        rom_memory = pci_memory;
+
+        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+        object_property_add_child(OBJECT(machine), "i440fx", phb);
+        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                 OBJECT(ram_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                 OBJECT(pci_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                 OBJECT(system_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                 OBJECT(system_io), &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                 x86ms->below_4g_mem_size, &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                 x86ms->above_4g_mem_size, &error_fatal);
+        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                                &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+        pci_bus_map_irqs(pcms->pcibus,
+                         xen_enabled() ? xen_pci_slot_get_pirq
+                                       : pc_pci_slot_get_pirq);
+
+        hole64_size = object_property_get_uint(phb,
+                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                               &error_abort);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        pc_system_flash_cleanup_unused(pcms);
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+
+    if (pcmc->pci_enabled) {
+        PCIDevice *pci_dev;
+        DeviceState *dev;
+        size_t i;
+
+        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+        object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                 machine_usb(machine), &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                 x86_machine_is_acpi_enabled(x86ms),
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                 &error_abort);
+        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                 x86_machine_is_smm_enabled(x86ms),
+                                 &error_abort);
+        dev = DEVICE(pci_dev);
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+        }
+        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
+
+        if (xen_enabled()) {
+            pci_device_set_intx_routing_notifier(
+                        pci_dev, piix_intx_routing_notifier_xen);
+
+            /*
+             * Xen supports additional interrupt routes from the PCI devices to
+             * the IOAPIC: the four pins of each PCI device on the bus are also
+             * connected to the IOAPIC directly.
+             * These additional routes can be discovered through ACPI.
+             */
+            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                         XEN_IOAPIC_NUM_PIRQS);
+        }
+
+        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                              "rtc"));
+        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+        pci_ide_create_devs(PCI_DEVICE(dev));
+        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
+    } else {
+        isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                              &error_abort);
+        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+
+        i8257_dma_init(OBJECT(machine), isa_bus, 0);
+        pcms->hpet_enabled = false;
+    }
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (phb) {
+        ioapic_init_gsi(gsi_state, phb);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+
+#ifdef CONFIG_IDE_ISA
+    if (!pcmc->pci_enabled) {
+        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+        int i;
+
+        ide_drive_get(hd, ARRAY_SIZE(hd));
+        for (i = 0; i < MAX_IDE_BUS; i++) {
+            ISADevice *dev;
+            char busname[] = "ide.0";
+            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                               ide_irq[i],
+                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+            /*
+             * The ide bus name is ide.0 for the first bus and ide.1 for the
+             * second one.
+             */
+            busname[4] = '0' + i;
+            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+        }
+    }
+#endif
+
+    if (piix4_pm) {
+        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
+
+        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
+        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
+        /* TODO: Populate SPD eeprom data.  */
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
+
+        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 TYPE_HOTPLUG_HANDLER,
+                                 (Object **)&x86ms->acpi_dev,
+                                 object_property_allow_set_link,
+                                 OBJ_PROP_LINK_STRONG);
+        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 piix4_pm, &error_abort);
+    }
+
+    if (machine->nvdimms_state->is_enabled) {
+        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
+                               x86ms->fw_cfg, OBJECT(pcms));
+    }
 }
 #endif
 
-- 
2.43.0


