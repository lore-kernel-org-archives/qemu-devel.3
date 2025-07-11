Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143A5C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAXq-0007Zh-Ld; Fri, 11 Jul 2025 05:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXP-0006Zv-DZ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXH-0004vr-7u
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:23 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B8HRNt032175;
 Fri, 11 Jul 2025 02:59:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UGdcSVjocv9bLTfxZzfvzXdzeE0RtD149z8Mk2TOV
 vk=; b=f95jVaF2ZjsJlJlOWwz1VjIGA+B9ftRFTpbNRf5usJhZ+DuqBqLf3DQyW
 omFlb8Gt4lp+ipuNJi1wFfUg1RLIYyHz6AHcH37B3remypBB0oVaQin+j+IU1uHC
 UIrz9TDrlz18bd7rJfhE7iYYAA3kqpG8LkXmaIokLdMDfqbsnVj7t8rkhIJx+ZAv
 Gr7gYSjwnesFEqGjNTTANrlQi9R5LpvGQ5jHzucDy/rmSFjiPio2YpHnNUoGJBz/
 S01fY/QnRoWFX9IqUrDGA2DtOJS2/GjhDDfY4//cGCwiQQOniT/fXR49WwgghvO+
 TChDyOe3xO+qFBjCAEPBH7eSzkJlQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2098.outbound.protection.outlook.com [40.107.101.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q1karqp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFf0G6oXRF9+dFs6hLfoqsPHredzWVxd/SAl9I9X0dGc8xtIG9seIX/SIXTSsq7mZRu5Y/mx63BwNHrlzctBTnWfkRSchOrFrP57LLmf+qFUGhrNZPtoqlyUycrBNhrUz5FMsK3CdqCcJiJ08VfHDCtTIx+ryaacMGvDkKXgJa0YmYed24qAE4/z3T1qXjFLgsYfGcmSA2dXnYEQv9Mm3UstDv58Izs5TLP5ywg4yfgtJkHaw6v8ObORXe1iSCMvMxLCJJcS3qtYO8RU2Ze+uM0AX38eocUZOYVOPVyYD9VXqYvkjLL5mx3kRNdX/8TaXKp1/5OsnEcuXdTp1nhWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGdcSVjocv9bLTfxZzfvzXdzeE0RtD149z8Mk2TOVvk=;
 b=VOCZR+MV86001jwPT3a9WC421lkdvfbTuxYseTDHERLr+UbNwjmbkboTyci5Cm53tzNp/bhPQQyIL01Ag1Fv+yq5x0xXOCOog7naXzTGg/o0kMXSggBMVyl3RThirkC3mqwqMJ1vl3PVk1Gcg/R15uhbcmn0VY7qVE8qF3cW3RMMglAYWYEGmMS1bPocBuDggkB+1IVQdeTXkS2aNPyNdNaPrFwJUyHxcIKxmpAEzWtcUkXvymc6CdUI6175xp+GjsbYpCQCc1Xu8fFRRoEIf4kFuilq9jM1OAgbUbdCD7k2F9qkHz5INWunhaOjuD4pn4ezX6s1vx1gAfJh7L3wAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGdcSVjocv9bLTfxZzfvzXdzeE0RtD149z8Mk2TOVvk=;
 b=lS4SuB6WYgHKRGfEG3+gQd2hfYimP7UWdxkYm1nmzd/RNsLdg7TKLGh2bpuANbXrZNtLSjYt7J/CJhapgLwtBOloaVSD820KwSnjY2KUDPlOqAIcF/5xkc9YOak1mPBs9tmii6KS+p27AIPVJw/omSiHEw9ys2aqVJtkjrFp5XNcTVKjn3uOhnn0tcgo1xt4naaCbeUVs7LsA9PKpbo6TK3FQc71rDZqVvy7+GDc+4LRyivgvkOCYDqhXZosrSU4kOJq6EIjziWehqly5N0dNqRRXLsY42DcbLHUyBv3oKk6u/FMxB7n+lHN72f3/C4ZtDZstK/0BdCqyAXCnoYyAg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7918.namprd02.prod.outlook.com (2603:10b6:408:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:59:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:59:11 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 16/19] hw/i386: move isapc machine to separate isapc.c file
Date: Fri, 11 Jul 2025 10:57:18 +0100
Message-ID: <20250711095812.543857-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0382.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::34) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f44e05-90e9-4a34-76a7-08ddc06195f5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z5Hqmhww1SKiXPRqqf2txmTG101fCe+UmGYHSNFD9jU1AB41tV+lOlZ6QVlw?=
 =?us-ascii?Q?Kv2mlqHAJXMEYIs8qr/OwJcjJGsuhGdRasOSzSVCh/zn1VNKNY09LnFbKpjb?=
 =?us-ascii?Q?+kxR05+ClHBuie5ZyIho5T9lB0ZuXBDPcjqoWTnX5dcSRQRoAZwYbCK/lF42?=
 =?us-ascii?Q?ZOugqHy6U7LYuhS/1ZZwFJYLboA4K7cX3hZT8RJUWcKCDgqnOHgkvl+xOitB?=
 =?us-ascii?Q?+HWFupazUZlJnbmLqbXMRP6XW/XuiOqlg018OCiqWk6m5DJ/Zmoi0jXQWQGt?=
 =?us-ascii?Q?1CP+FHnm7V9HBnUznFT3uQfohQzo0oEwH4wBzThZgaeqLviynqnkGY/gAubk?=
 =?us-ascii?Q?DhpIVk45b3EVzAV4bMCoEx0TMzFauC/2gZz4q7IhuAtvnIM/JnzZfEaucByH?=
 =?us-ascii?Q?v6Cwc7wyjWoPSLCqHd4Saxkp2s9LY0tHtPE/2XzHLU9gW365kFlql7M21YFq?=
 =?us-ascii?Q?lOkPEPWnZDdvVj+BexDb8Xzl3q0zEjwjN1kL3XzS6ZrWTnh2QsFWddCzygRV?=
 =?us-ascii?Q?MeXLAdj8fNoodOM2+pxzix4fR47M5YDh65IZq93mT78ToDmTXiHpkSVgpRSo?=
 =?us-ascii?Q?+JXObY6XE+sT+txe0KFEiebmqyY2yPw+kbgfCcEPB47L3xWAhuWqq7JnhkMC?=
 =?us-ascii?Q?GJdcxEC1iPgLUo3N5q4HJFMpU2MHMoxA1nOOBTEuVgvx1ID6ZtiK4sc6ks/a?=
 =?us-ascii?Q?m5P33yc2ArbT7fkMUHmTwx2MaG0Tdn2D/scXlcuUweirF9EvIe5jQaVzAI7c?=
 =?us-ascii?Q?xykw16BJZ8XET9KVSN8vI3AO2CGd37UIMml5IoRXDPvsPi0zI/mEPivl4clf?=
 =?us-ascii?Q?jozvRTkyC+LitNuRXyVQ0KonqEud9xlJXpx1zQri0XwziFhZLatJh2A5Qsy6?=
 =?us-ascii?Q?2X7FuXhAb5zNl4IJrXu44QGW0UQUAtR0VBK7I+SslEVM7fnC+lHDMeKoF+4X?=
 =?us-ascii?Q?QkDNv4d4TPB00ss5gNB30FK3oRc3sGTrYB5+2v7hc6obWnTyNEGlM7nKlArq?=
 =?us-ascii?Q?Wy5hbqhG3TgwRTstC/7unHRAFX1vX5wflDUj/WFlRKl7txPoySmaDz71XP4n?=
 =?us-ascii?Q?s/k9uaDJROpjLiDSxYDCj4vgjaz0MwzpOhbdRwffbYb7KwHrZcEfsdB2pUSR?=
 =?us-ascii?Q?w04pFyZKMjcxp7G5J/7IuFyE2gNCUZATIqZRIxiFTXhkht2VjKEI2VubC8x6?=
 =?us-ascii?Q?iiIAPXmOnUhDqyvThvuu8+CAfwMF0pa6gKlUSW4HI871CW2YUzWvkQ2eUfR+?=
 =?us-ascii?Q?pNz84girGupuBlSOy+mtDBR1pAiNFPflFDTxESz4wli1BJlVS2dU4J53KMwV?=
 =?us-ascii?Q?SUPHBNjDlQ4AFUVyz2YIVeU3jNoCafbN094yfumBzU1IXQsZuEW6kHa2wVjm?=
 =?us-ascii?Q?bEDwgalKFiL2sg8xFfk/goeI3Gp6kVMwN5CQrQdH9MrMea/7PDwhmptgHF4j?=
 =?us-ascii?Q?gzOw3m7SWHE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Bo7SUtSStORBJw9g9L1IM1+fe21fQQFsh988TX1vO/ttOi921dVMvvSnpcd?=
 =?us-ascii?Q?V2nFTbC6Z1iiQNzd4le31zNRTyomz6Qdg4ul8gemdHiSJzhQjHEmsx42TCfO?=
 =?us-ascii?Q?UBQ/IWY9mtP2iFKsh0qxYdjiO7I0jKpmMqpRM4hcvJZxmDmMNBm3TXyCExYu?=
 =?us-ascii?Q?6b969oY3S0rPo72l48gYbiuwUHY/z0EBS4542E1pKJgvkFItG5JyhiZ0RA2N?=
 =?us-ascii?Q?GcwaaP4pLrQAZH3EW2sYSXaq0HMEhuDkJSP9qOqE7LISFqMv8O3FL451vhbx?=
 =?us-ascii?Q?tuULyBmiw6ExisIdoKrEnDxa0DKLiKbWthA4FvYFpdW6YWZKz0VGHm3+K/5x?=
 =?us-ascii?Q?roXiirWU+HIAC8YJwmioXrHD9WQpIz175OVxdLglrEuBVRBpRvud9YAsKPYG?=
 =?us-ascii?Q?Y/k3W+WFewX9AHKqhIcprFm6488d1gV3EkqJosYl4Rur0mqM5HzJHNcSMj+g?=
 =?us-ascii?Q?eAH8KB0GIf45fpkkurRsGjE5Xv9sJYgBBDxZpzAYULlIwHkCazMglcbszh+B?=
 =?us-ascii?Q?2rpw1xEKRQFo+VKN93sC3kR80XL5J94qYqLAG2xFx+5VEM0OfPqkLobnEHAk?=
 =?us-ascii?Q?IPZ6bjORFRS5J7GoGHcCYcupf8AZknRMqznFhdAzm1T04P7inl42ub74TBGJ?=
 =?us-ascii?Q?swvijBTEyvr+oDu9yakgFWyCIe84sA7KQs8kTm4hsdtKhIgMXCPNuhIDZ/03?=
 =?us-ascii?Q?iGRmsEnsPjaRCWKTc3IxLBPKs+pdDhJA5/Fu4fFnckuXHf2nKq7AA50DEUGV?=
 =?us-ascii?Q?rklCLRUpR54Jgs7tpaJHBvZ2EvP65ys6P4jtDQX1vozVVgOJVz8FKIkzf58b?=
 =?us-ascii?Q?6xS4Uwy4WXKEW1YsD6SqfKRmyo8xxmnRtO46IHNg3vzD0GsgSKa1zY2WlEIG?=
 =?us-ascii?Q?EnrHYPdAZvsE3FxclNaLXmSGgUSOq+U7JAb9dEDnoEAmFEtQZer6GAffA4Tx?=
 =?us-ascii?Q?WEt0PvfITkiokmgZPoRzlcuNILmkbEn03ysr18FIvTn0IqMvUFUHhsidEBIH?=
 =?us-ascii?Q?0ntZ8U45PsCJEDE7uX/PKucOQ7ssCNOnyt5ThlX8smZY3gVZZ/xIM9A7qF0l?=
 =?us-ascii?Q?nQx4JJF+O/QGCbuDcAWa9hP0WaRnro/SoiiglX0MveBpgJA1MkkyGqNi4RLk?=
 =?us-ascii?Q?1txsIimmD7NHWIPP4P6Y85Hh9IOt7tK6JaXKLtxfy4eWQnPrxwSpbohJxrqU?=
 =?us-ascii?Q?gaRYPlTVGEz6O0hgDYxZVRTc7xwA6GiWiEzfnS2nr4bwIPEmAYdh/cqd8bvZ?=
 =?us-ascii?Q?II1R+b0TgrRI4hIOgh8Nuf7/oj1G/nh3xHzTMMtaNVKnaocWnZnikpdbzQTL?=
 =?us-ascii?Q?OF7woHlccd5iJhlO+2Srt7IOFk4oUlJ+ceV1wBIuiktiCPZ2clzhxHYGeXSg?=
 =?us-ascii?Q?fLZN3gbiwrXLWhnPwHkIusuk6UW1rj9x5rE+n6Qhdbsj3ZVA/5fwVsuGOB1N?=
 =?us-ascii?Q?14iJfEHRSm924MlCrcq8VVfQz1iTyUeeK6U9piwOr7l3z/rDd1g4zF7VTluq?=
 =?us-ascii?Q?zDgh4j9I+OGjLY1dO2UK6tdLxtNE0Ub0HRYNXSVBbHUPKkIvfXhPfEUm6VKq?=
 =?us-ascii?Q?pSLhI+A25yMAfykZVShQJLlVvbmvl7ZnKi03IJEgf2/qqoG5KlTO4QS5jaRu?=
 =?us-ascii?Q?ysabylt9hrso/KzJntphTEdzdLOqFqmmj4rDRurN1loL1mXNSFJnH50BXm+6?=
 =?us-ascii?Q?CTHoNw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f44e05-90e9-4a34-76a7-08ddc06195f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:59:11.7583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzE2z44i+XijLPBa5otv/b2NExP3ect5xlvNE5V+Ov6akwG3b0C4+YsSsyGLtj8WzwloE9ADHEIqyE9hcEIT9EqtEsVE8uP1QLTMAqdRQQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7918
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX5SyAkW0MBjRG
 DwHxR97AMqvJQ4wn7m1F28eL/xXm70Km3G5a+9a3BUPdiQLYL6+p2enyvRTs+xp8UMX6we9RzIh
 TcUn8RprpNUp+UnH9amJS2obl0N+KRuTOXmW9i/1pLtPhskHJTol+KoGf3iRVrfrZnn1OjaSDgl
 GVJ+idWFkbXJkja3kRDgAaqnfT57oVi2GXHVMX2tjF3KJH6JmrTkrji3ZhL1bweADEHRdR2/G6G
 V3HvlSm7l6SRGgFoHKOLUcN1oOlZkDDNRIlkgOl1Y65qMJTKhIdqbaRGupLGu302vOp/mdmHqGw
 Ft7S2ypFExy8xus5JUpwBe98Q5FshRdX/ar/nSMKl2En9Len2LACwT7aNqdvMNtAd0DTSsHzZV3
 HHdkYJxi9I5bDHgNj5FHLTWRSwfw9JBxMB7CKq+dju8oJvYNia2vmAfIWzzLWXHhVLLe0KCB
X-Proofpoint-ORIG-GUID: iUlrwloSOys1VFz-bkIfEKAw7RbYn4O_
X-Authority-Analysis: v=2.4 cv=Do9W+H/+ c=1 sm=1 tr=0 ts=6870e071 cx=c_pps
 a=bAxSNnLMfqpvnT1L+FcFCg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=pGLkceISAAAA:8 a=Pbl5c31VFoorxvNN0s8A:9
X-Proofpoint-GUID: iUlrwloSOys1VFz-bkIfEKAw7RbYn4O_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now that pc_init_isa() is independent of any PCI initialisation, move it into a
separate isapc.c file. This enables us to finally fix the dependency of ISAPC on
I440FX in hw/i386/Kconfig.

Note that as part of the move to a separate file we can see that the licence text
is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
("VL license of the day is MIT/BSD") so we can be sure that this was the original
intent. As a consequence we can update the file header to use a SPDX tag as per
the current project contribution guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 170 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 149 --------------------------------------
 4 files changed, 171 insertions(+), 152 deletions(-)
 create mode 100644 hw/i386/isapc.c

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 14d23e27b5..8ffcc9f7aa 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -96,9 +96,6 @@ config ISAPC
     select ISA_BUS
     select PC
     select IDE_ISA
-    # FIXME: it is in the same file as i440fx, and does not compile
-    # if separated
-    depends on I440FX
 
 config Q35
     bool
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
new file mode 100644
index 0000000000..b24cbf41ea
--- /dev/null
+++ b/hw/i386/isapc.c
@@ -0,0 +1,170 @@
+/*
+ * QEMU PC System Emulator
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/error-report.h"
+#include "hw/char/parallel-isa.h"
+#include "hw/dma/i8257.h"
+#include "hw/i386/pc.h"
+#include "hw/ide/isa.h"
+#include "hw/ide/ide-bus.h"
+#include "system/kvm.h"
+#include "hw/i386/kvm/clock.h"
+#include "hw/xen/xen-x86.h"
+#include "system/xen.h"
+#include "hw/rtc/mc146818rtc.h"
+#include "target/i386/cpu.h"
+
+static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
+static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
+static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
+
+
+static void pc_init_isa(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    ISABus *isa_bus;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    uint32_t irq;
+    int i;
+
+    /*
+     * There is no RAM split for the isapc machine
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+
+        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
+    }
+
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu max is invalid for isapc machine, using pentium3");
+    }
+
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
+
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                   &error_fatal);
+    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, NULL);
+
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                           ide_irq[i],
+                           hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+    }
+}
+
+static void isapc_machine_options(MachineClass *m)
+{
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        NULL
+    };
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
+    m->desc = "ISA-only PC";
+    m->max_cpus = 1;
+    m->option_rom_has_mr = true;
+    m->rom_file_has_mr = false;
+    pcmc->pci_enabled = false;
+    pcmc->has_acpi_build = false;
+    pcmc->smbios_defaults = false;
+    pcmc->gigabyte_align = false;
+    pcmc->smbios_legacy_mode = true;
+    pcmc->has_reserved_memory = false;
+    m->default_nic = "ne2k_isa";
+    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+}
+
+DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
+                  isapc_machine_options);
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 7896f348cf..436b3ce52d 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -14,6 +14,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
+i386_ss.add(when: 'CONFIG_ISAPC', if_true: files('isapc.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
 i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fa63659113..4c7da53943 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -70,12 +70,6 @@
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
-#ifdef CONFIG_ISAPC
-static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
-static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
-static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
-#endif
-
 /*
  * Return the global irq number corresponding to a given device irq
  * pin. We could also use the bus number to have a more precise mapping.
@@ -372,112 +366,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
     pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
 }
 
-#ifdef CONFIG_ISAPC
-static void pc_init_isa(MachineState *machine)
-{
-    PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms = X86_MACHINE(machine);
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *system_io = get_system_io();
-    ISABus *isa_bus;
-    GSIState *gsi_state;
-    MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    int i;
-
-    /*
-     * There is no RAM split for the isapc machine
-     */
-    if (xen_enabled()) {
-        xen_hvm_init_pc(pcms, &ram_memory);
-    } else {
-        ram_memory = machine->ram;
-
-        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        x86ms->above_4g_mem_size = 0;
-        x86ms->below_4g_mem_size = machine->ram_size;
-    }
-
-    /*
-     * There is a small chance that someone unintentionally passes "-cpu max"
-     * for the isapc machine, which will provide a much more modern 32-bit
-     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
-     * been specified, choose the "best" 32-bit cpu possible which we consider
-     * be the pentium3 (deliberately choosing an Intel CPU given that the
-     * default 486 CPU for the isapc machine is also an Intel CPU).
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu max is invalid for isapc machine, using pentium3");
-    }
-
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
-
-    if (kvm_enabled()) {
-        kvmclock_create(pcmc->kvmclock_create_always);
-    }
-
-    /* allocate ram and load rom/bios */
-    if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
-    } else {
-        assert(machine->ram_size == x86ms->below_4g_mem_size +
-                                    x86ms->above_4g_mem_size);
-
-        if (machine->kernel_filename != NULL) {
-            /* For xen HVM direct kernel boot, load linux here */
-            xen_load_linux(pcms);
-        }
-    }
-
-    gsi_state = pc_gsi_create(&x86ms->gsi, false);
-
-    isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                            &error_abort);
-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
-
-    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-
-    i8257_dma_init(OBJECT(machine), isa_bus, 0);
-    pcms->hpet_enabled = false;
-
-    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
-    }
-
-    if (tcg_enabled()) {
-        x86_register_ferr_irq(x86ms->gsi[13]);
-    }
-
-    pc_vga_init(isa_bus, NULL);
-
-    /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
-
-    pc_nic_init(pcmc, isa_bus, NULL);
-
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < MAX_IDE_BUS; i++) {
-        ISADevice *dev;
-        char busname[] = "ide.0";
-        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                            ide_irq[i],
-                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-        /*
-         * The ide bus name is ide.0 for the first bus and ide.1 for the
-         * second one.
-         */
-        busname[4] = '0' + i;
-        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-    }
-}
-#endif
-
 #ifdef CONFIG_XEN
 static void pc_xen_hvm_init(MachineState *machine)
 {
@@ -834,43 +722,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 6);
 
-#ifdef CONFIG_ISAPC
-static void isapc_machine_options(MachineClass *m)
-{
-    static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
-        X86_CPU_TYPE_NAME("max"),
-        NULL
-    };
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    m->desc = "ISA-only PC";
-    m->max_cpus = 1;
-    m->option_rom_has_mr = true;
-    m->rom_file_has_mr = false;
-    pcmc->pci_enabled = false;
-    pcmc->has_acpi_build = false;
-    pcmc->smbios_defaults = false;
-    pcmc->gigabyte_align = false;
-    pcmc->smbios_legacy_mode = true;
-    pcmc->has_reserved_memory = false;
-    m->default_nic = "ne2k_isa";
-    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-    m->valid_cpu_types = valid_cpu_types;
-    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
-    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-}
-
-DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-                  isapc_machine_options);
-#endif
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
-- 
2.43.0


