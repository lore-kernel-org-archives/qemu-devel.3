Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66699C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFang-0002y5-R6; Thu, 15 May 2025 11:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFam9-0007VM-Ao
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalz-0006RK-Gg
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:36 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7p8s4009723;
 Thu, 15 May 2025 08:45:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9iyNzh7B2IZNZV3nwRHLF27AZsGzUwzs2PSyVUevi
 CQ=; b=J+pB4I/b46KakSyPzGYZfD1IIs6VvoqJNLS0w/nI7er413mud5kds8W3Z
 QBsZctwQsfZfQ7bmmhlWAJ9ZJTEY7w7O4EBFKsoeGQL2K5jNhjhcSFcyGuKs4el6
 O1DhSGiYlgH39XMAXx9yiALCEmln/tI2OLH9jhc2ndRqGpsqhECZ6nCmFbe03i8m
 DDvwD24eZLu6dj3/ZDkr5yW/lb2XmZ/O7NmD7gR5XI2x8gcdRq4IUXDJPhZ5hMsJ
 ggs76Mm8ngqZJFo7k+OIw7H6ZE0AwRok8wsqY3ZqAutFSFtijJtE731ZbxKumhwQ
 GB/s899eQSnieR9ywYX7x5vv4ioyQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbcwwdyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3a7rxBLnT9Cm2NyDD+C3nPBu0dk5iQ77SUNV0ix/Sic672gwn9zc/hBr12Z5OSto07obsvyaIaFs4RPlx/77hGZt1mYJCEeMPLI/0u7Jb/uDK+AJU8bKNti87zBpDI2/aOBvar7XFtpkKFHrRs+NotttoDCz/XPz0+DiCinXnSH+07GeptTzKQecB0YMvL5z9ErtjmdgKqCIZcNcQNFq3fmdbQWiQ94o+8qR8H2TxzagbRINtNhnYPjjVzErG8Mg/u48gPNJ/X8Oel7i4zx1i0GYE3NTW2M/Bxjiws8r+YS7bdOugUYPpHhbx2IHPn8kiY2fCPPrSVznvsotQY3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iyNzh7B2IZNZV3nwRHLF27AZsGzUwzs2PSyVUeviCQ=;
 b=jdGVZuSnk6hoGE19lWbieuZQ3dE696wJZOhq7ioRWSHxaVjbfTBjLfzkscB0vrr/guAR58eegABY9x6RTcebjHTWcD+dVOPopPjADY0jANw1hav2kNDooUsp408QtPREZfOaQAG52MhVN7/HEidyFTzlyUAoQzR6dZR/uOkDDXxPpijC6hdz0QxEWohKCPXlxdhpSp+vAky0RRBNoTIloEWg4W1W7fpKmGC009d0uLiOJrEtBrSZacrUJIUu7QyVDCjuBJ2e3NdTs3xxwjMegbDiBgbx13NXfin1Qdn1bzYa27qTFiHl5X1cJGsumd5lzmCljmXQG+aU0mnGTyLuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iyNzh7B2IZNZV3nwRHLF27AZsGzUwzs2PSyVUeviCQ=;
 b=QHWm5XxuLT2wJ+vSBvgoDwEpicz30JGK4Eg0ra4Wkob1afr0wZ3/h+40vSUEf6ILI9E1+U9T+NniZ7lDtKHde9zcGgl7sTTKITLGNXtBkZeaKl+or+n/M9pdbVrzSU6WCiEeVNUehMsN/CSFsUq1cLAxD+CmjGKD9L0wMcthOIL+30N8AjER3sZb2D7cJ8Ci408yug7hg/oWb6OHtoVMnuBsZ+An6HEyjPnCnWiXkvcLoeMGPNjNkEnO2eG7hKcS1BtwSNJ3Qtcd+pQCxjfgLTO7oTJebJFznUR9h6Vcb9+7w22QNzdVTraZ1IyM2XJSOIUiLZ7eMH+nMkNlu7acpw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 15:45:06 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:06 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 19/27] vfio-user: forward MSI-X PBA BAR accesses to server
Date: Thu, 15 May 2025 16:44:04 +0100
Message-ID: <20250515154413.210315-20-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY1PR02MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 04dc9342-f991-4025-9cee-08dd93c7774d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7u3R1LQoHH8+pnhL7d3ch9pyZelMrplWpVJorzB5wTyrWGJIhH7NN2t76jra?=
 =?us-ascii?Q?oZp98TePMDGb/GyQ0Aq2t8Z9sMlxGpBhjGHW5kgbOKFyke9vBapMgXflKWzf?=
 =?us-ascii?Q?9RpprAye42/9GQBjK+vTp4eSH6xwbxtawSY+5X03lQwUAVNNQeq1A1wgxwdM?=
 =?us-ascii?Q?mb7Eb8wOa+QEKjBmgt0p5vArCBM1g0SmGfnizBd82HxhdoxvGjnvWG4v8Mt+?=
 =?us-ascii?Q?hu4ZIxuMZJajgWxUzaSUHWttUrl4ZsBuI1d36q2Jwo+K9ERwispvqqgi2Q8V?=
 =?us-ascii?Q?rzPxGAD8852/v0xJMkl7Bb8Ie9vwOdctWvsVQWv8ayAS3h6wTYhfT6zht348?=
 =?us-ascii?Q?3TA9lMarM1j2+1z+hFuk4+23s0WgY+EPqXK8G8cQgFKCnSZmShvGkkeNvOqO?=
 =?us-ascii?Q?F6l9Dx5Vytli5ItUxbP8MHplmH7toYqJvwsDKgCaF5LDDKzguRryMspLOLCU?=
 =?us-ascii?Q?GYhkIE9A85Wcf0rq0LW3fSMeaGUSrSEc6LymKFLd9A6rxF6pGX6Ne61hQG1T?=
 =?us-ascii?Q?hzbBtnI5A/HmkTbsfcQOhZ1xVcdNQjQOcH9tUb5iX6uGww8v2xmeLVbV951l?=
 =?us-ascii?Q?Dzr+rs3Ce8uuChcCSRYeizDDeP56cnciMCxxekmoaTVhfPkHowARxjOP2qfL?=
 =?us-ascii?Q?5069mcgfiTPAVS+6YuTj27eu6euWWN6PisE+6ZYblKwFRCFHb1u74xulPlGp?=
 =?us-ascii?Q?ga/3Y+NSv0Xp3Tw0sLbeog7pZcR5d9pjWyLjgUHrlM1E1pkNm5BhYc1tT4cW?=
 =?us-ascii?Q?Kej85+0J1oeeKqZmijyQ7xsYSSsX7I+StQzyC862jDenYK0K75BOKa5k0jdn?=
 =?us-ascii?Q?8YExteNYlDKPcOVv7Gifk67ZijCLwnDs4MZwjzAoZfQF+q8qlFwPMtro5bDT?=
 =?us-ascii?Q?zIdyD2teh3H8jfPNbQABy+d669E39+bW9GTXsHC0vcAZ5EawjWiJtujrVSz5?=
 =?us-ascii?Q?Ni1WEfe07BhatLFoYL3RazD8bKM54PD1z4443R4rJWPLi0zp9wJako2BUTcQ?=
 =?us-ascii?Q?o8F9jkG+KUlbNgUFMHy4V/NxwTjAAeW4/2YqEJu5pPlWMuW8CvOJMJkHw3O2?=
 =?us-ascii?Q?oXvn8+ZH3PfSvHulzRcMOH12R7xQuIBQCAptRUOill7a+ZQbY9Ag6H4tL3nn?=
 =?us-ascii?Q?BKdXYtdMx2R5xmO1Vp/cKu2oNhXYR7J2nf0Df1GfIFXz1aFz/mtr67pRlmki?=
 =?us-ascii?Q?88P5mYTkE3UFpY/JgmpL6swsAzC057K0NjQml2wIRRnUWXsmR66plpXemKfU?=
 =?us-ascii?Q?mvsbgxr85amqmhbB4BSME8UTZKO7v/qXhcVzSZb823v1jvevARNmWAu+b5Yo?=
 =?us-ascii?Q?k+ZdVFsLoe+g3PBw3npqvTI73OXI3szYTxuPtc10cZgWOZ5xMvXrkK30N4pU?=
 =?us-ascii?Q?Ivh7ZWMM5Ny3Xz90Fb2Q0EOwUT85+PaceqgSVyZfGwq1iihQG0oYho27nonY?=
 =?us-ascii?Q?cG7GR1fx9yk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E5bap1N9IBvosQ0xWv3r+N7hN77dc5+sre1rAsgwh6nChlxtjjAAp4I4XJ69?=
 =?us-ascii?Q?6THEFbumlkYzUyYtLv5H92D99gJag8Yz51B4MTxR1Ld1U0BnpuKylVLvOm7Q?=
 =?us-ascii?Q?bECeSSaeM/PBtc/Ew1yy5Yw40RiyJV6lcRUeC/dyWaUUvyRshBhJGvK+vpLp?=
 =?us-ascii?Q?njzv/LJj8EUzL7Mn+Im4nSCT4YTnkuul/539rXd9ROmqDkhrBgxH9gPYOSZn?=
 =?us-ascii?Q?SNGQAqC2n3PFSteDhbNrja1HDbeYvpkZ1Dzdzxh3Fy0uPpa+/x+DyrO9b59K?=
 =?us-ascii?Q?Qipgp7cPheDD/2Rk3xEBzp2xqiLytsSAESw9VtIHv1yWgAk027W9tzwJlEnO?=
 =?us-ascii?Q?Nyz3Y+1nvOH4oH+veWtdRH6/SO50NAr0yphduY/ii+smxphHBrjXmJEnlsvb?=
 =?us-ascii?Q?quSJBLLFfhkJJGbGF9Lft59L/jQj8CNMdKK3A72Je8tDUNOQ2d9fHRN+rViL?=
 =?us-ascii?Q?228UUaufQ2/4JPWTV2aqCHmtcEVXc9I4iRj/HPICyO/4C0SiShUN39gvyrx1?=
 =?us-ascii?Q?aQqW3h9+BEuvtvZ2mqNT9LHR4LVwlcA01nprClawjI9wqFYDw9Vcw1C+Iios?=
 =?us-ascii?Q?TaQ4/iAXOEUYBWn8x1qtM5fLJf3pLoNOMdb1gpKOkOfYhOyI/5HsC2azyG2l?=
 =?us-ascii?Q?ASnH5pCDlpnauAAwFpqFNK4hLvTOfQY+bRbkt/TQqKVwiRc5QXfB0/mwLGTL?=
 =?us-ascii?Q?ceDqkVPXd6WFZxdKyIpPzGEy3rKpIGJmaBQ8LU1Yps3cyqgjveUV42at8kEp?=
 =?us-ascii?Q?Ei5b7DkoP9mKl5wFon9moPFQziuEFqZoACJL095GqTd6mxkCuufwcfDejZmS?=
 =?us-ascii?Q?Ty7QPIFyfUVFAPfu0/UYrqa8FbMOzNLmK0o96I8wXRZ6UllgbYRCOwjrdX+O?=
 =?us-ascii?Q?CtdP198njddxknc2z23zi3qHkOSeP80UTZ/A+Z+9nMylHjCtRCxE+eTgR3n1?=
 =?us-ascii?Q?LsntgsMXF5kObXvRPBjgWksYoCW5q+OtxP4qeeAOmR26OOmo4BYZXAQzLf3r?=
 =?us-ascii?Q?TEABHT1OyAIBDh4gRr1MaGx/OLNQGoecv/fD2Lh/3cGuOeowLjkdTL0iwvJP?=
 =?us-ascii?Q?sNXJ/0rAcPSxOhl0UUDbOO80HGtI1iRlqkFKBcZoBEN5fsTcL25V8X0mIBVs?=
 =?us-ascii?Q?Rnkljn8hLZ9jvmTiO/RsZihv3H1zytaet8D1cZAEoaIO3gGRxnWOJYWCwEuJ?=
 =?us-ascii?Q?AIr/eDwqfd0oOSNQLDtD/1c/FKCLIswWNxgW8684HhpM9wrrNgrNcsPOOKTS?=
 =?us-ascii?Q?oM+ZQ0+Ao8tru3OVuLlok87MdReSY8X604fz/4pbgySK93llPmZU7zuuzkoK?=
 =?us-ascii?Q?gUTH058qrVkVnJe2+PM7QjPxsIkQG0t12H7D2fdnsmL/5MlLe9Ii9HaIDdmE?=
 =?us-ascii?Q?Pj6Qi3pzz77+0MyfF3krOUASBOt646jUWUOB46tc+pzzoDzO38H/hAem1EXE?=
 =?us-ascii?Q?3H1IxyUFSNV9svluH0jOomlydp0hCmkoS1+ykyVu/R7fmwCv5QCV7Hwap9NA?=
 =?us-ascii?Q?P/E2oZUR0qoTdxMjR9FrFnBnb7JbY/zm2qj7XaJMHdPaAaH95P8TAz7U1uK0?=
 =?us-ascii?Q?N19UBVbVsUHdlCCqp9NoUhysAg/+0kbN0FPZ4g7j?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dc9342-f991-4025-9cee-08dd93c7774d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:06.7372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNDXUHz8144pKtaYqKZ8qxQGEIhPRxr8mdgq+Fsk63X8JMPnekhjoPEtvOmnzJ1nChs6VG1T0k/pG1VPNssWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Proofpoint-GUID: rELKMHEX_VUY5foCBBf0OmNOFCX6HttV
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=68260c06 cx=c_pps
 a=CbxOEkXH4sIw/lcH++vrDQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=P96-NN1LHiVJMZ2xip4A:9
X-Proofpoint-ORIG-GUID: rELKMHEX_VUY5foCBBf0OmNOFCX6HttV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX58d7uKa8mncP
 0QyXXyzUZUD4nAWCPhI5EzMYkq8cOzUBdex15uH3SWi4kFbuWWGQ2NdfCjiE6LvePicWZBOEmQT
 TsIp83AswC5ljcaAYZDw26ccA5D2NcEJd5SM5s8FsAJ0zgSa0jLAtqCVzi9nkEppm5V/lv98r64
 os7OHCuPCedwRcsUF9H+B29WvT70J0lXwDlx0OQNNX3voNQi0ciVYlz37smXsr+XFqGxUL32Nig
 8uI4DpWFqm2YJ3fv4z1TBtkvu+xe4rSEtKGm1SZoEWqJ93HwnsXDfBNQVEFz2TWlVZ0sQiwV5Vk
 jlIRQ2MzQkpUxD7VB8/L6Oq8MZoKKynGYjHiuLuuJ5Q4Qte9kqYYbEtIRSKUqfb+jqLSIzHcAMv
 4xF8p8rN2GTwY88uYvfNLmiTaH8w3jIiZ1a6O+MaPWLNDemcUByDuVXX6mCVLcUjx0OPKody
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

For vfio-user, the server holds the pending IRQ state; set up an I/O
region for the MSI-X PBA so we can ask the server for this state on a
PBA read.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h      |  1 +
 hw/vfio-user/pci.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index f6524cffb5..80599454d4 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,6 +116,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t pba_offset;
     unsigned long *pending;
     bool noresize;
+    MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
 /*
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 08edb611ff..a6921a8f2e 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -26,6 +26,62 @@ struct VFIOUserPCIDevice {
     bool send_queued;   /* all sends are queued */
 };
 
+/*
+ * The server maintains the device's pending interrupts,
+ * via its MSIX table and PBA, so we treat these accesses
+ * like PCI config space and forward them.
+ */
+static uint64_t vfio_user_pba_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIORegion *region = &vdev->bars[vdev->msix->pba_bar].region;
+    uint64_t data;
+
+    /* server copy is what matters */
+    data = vfio_region_read(region, addr + vdev->msix->pba_offset, size);
+    return data;
+}
+
+static void vfio_user_pba_write(void *opaque, hwaddr addr,
+                                  uint64_t data, unsigned size)
+{
+    /* dropped */
+}
+
+static const MemoryRegionOps vfio_user_pba_ops = {
+    .read = vfio_user_pba_read,
+    .write = vfio_user_pba_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *vfio_reg, *msix_reg, *pba_reg;
+
+    pba_reg = g_new0(MemoryRegion, 1);
+    vdev->msix->pba_region = pba_reg;
+
+    vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
+    msix_reg = &vdev->pdev.msix_pba_mmio;
+    memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
+                          "VFIO MSIX PBA", int128_get64(msix_reg->size));
+    memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
+                                        pba_reg, 1);
+}
+
+static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *mr, *sub;
+
+    mr = vdev->bars[vdev->msix->pba_bar].mr;
+    sub = vdev->msix->pba_region;
+    memory_region_del_subregion(mr, sub);
+
+    g_free(vdev->msix->pba_region);
+    vdev->msix->pba_region = NULL;
+}
+
 /*
  * Incoming request message callback.
  *
@@ -133,6 +189,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_setup(vdev);
+    }
+
     if (!vfio_interrupt_setup(vdev, errp)) {
         goto out_teardown;
     }
@@ -180,6 +240,10 @@ static void vfio_user_instance_finalize(Object *obj)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_teardown(vdev);
+    }
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
-- 
2.43.0


