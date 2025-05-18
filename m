Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422D7C3ABD8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 May 2025 17:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGhNh-0001fT-Gf; Sun, 18 May 2025 13:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uGhNY-0001fA-UF
 for qemu-devel@nongnu.org; Sun, 18 May 2025 13:00:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uGhNW-0000hr-Um
 for qemu-devel@nongnu.org; Sun, 18 May 2025 13:00:48 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IAlYDs005141;
 Sun, 18 May 2025 10:00:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pcwOH0gQ2rkYRtorCJY4W5ACWDlhJBXMVVZMok21q
 Kk=; b=D1J3RVDn03gkcZ0MAFcRBPzmAR7NKB0jfhzpSTAfirCueJq2buIHETmNR
 FJZXnVouEZacGVPQEQvqK3ECBANkZmd/+sdSkJP2RyEpW/mM9vgs8od1PPeZPB9c
 bp+Z8dhnnHGSknRpw793bKSOm4u6PAXm4RxUR+ws0bpcaUKQRdBoCfjj0/RoAv7j
 PXACbZAJrG5/07Cf96w/f808CuyVIG+iqO0BW0LNZ7dmTZjWagJPnZnToVImna7a
 B/8qQ1/Px6vtYATZIcuL/LEKdpxxke+h+bHpOBLByuC1+zHQqPzzn5XYEsLcSUrf
 VQ4y7ZeylJGZGOC9QTwIIN62Iz2Rw==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshh9jhb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 18 May 2025 10:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXqAp0dRzrDfAyDNokdEgC5Orqb31Rk6DK/1a3YOvaj2Lwe8R+1LVj+3U9x3lmcx27Lzs6hS9lfL1irwU8Fan0ap4AZN/AX9tr4mUBJUg1AIdrazIm25DrhHVRi0v5LXrsEifOyYJGK4jGwy8RlriMgr5feJGS4I145Z+p9Y2OS14bw/oYt110/KP6y+KoW0u+iG0nLScnoGAEL0OcdxEf1iEfztSV9AFKYfTf5xhnkgYFsJTPIBtmPDTg+0X/RZMJQ3DUn7T7eec6aXx9ALF/ZV5J1UjVgp67HHWJJulPoOCZCM/wZZTIbokLdIgncHHOSzmycjaXSPCjuLkZzbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yty59/uqQUJe6gLfrVeJHy970mN3IheDvbXrzSA2ypI=;
 b=fONCt2ka9QAU2RlVkM8rfs7bW1xpZJGzJGIWwCnMVwD+nSJC9SUc7MgetfxELXfJZiz/AxuuVGzjNP4Cs9q58gUTRs8+L5kxVLRaQueN4HN1DVQVHY4ei35jfudCquQN3wMflvlwwHRkREX9YEA4O6dxtdeMl0LkolZ4ALEmMkf4WWx/o8Mf3Ih2ADkUdPoYf2MLGyzocCixYupQ+kNT/erHDpgoOd7ES5H5KfLvn6AnTXISFV3Z985JXop+u+SiYa1gaWVdoXiLN2tLu4IO4yFKjxJQ/1xmvGES42HVUljHjneVSh+IrEkK4/ZlXJu2IiMNIdh67ngym2Ji3qJGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yty59/uqQUJe6gLfrVeJHy970mN3IheDvbXrzSA2ypI=;
 b=gStnwpcCxEJUopRn7oLOqlMs2RyioxaOGwzuuOIinZi89HhbiT0oVZihzLruGFS3oBUq+Ce3gLtcTispFdnM812FmsmyP0rB2BrynNNLa6c3KhVAYLuoLzLwVCa1SEajWDmvGKrJm95XIrIBPnF6yjWMRvJbvmVqvOMxkJQ2io5VSplBCpy467y6SGuJnXogeaH6MHImQUdC6fzN/61MLl/AWKHeOe/cCkBJf6Uv2a4UFF6QtetHT/u689rMDgbJsM9oUJExfAfZAEQXbCth5AKiEj7KDx7RfQ28VgURSKiC2JGnlusE8awnHhjzivKSEovt6S2MHCqsZhwfHH6vsA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB9023.namprd02.prod.outlook.com (2603:10b6:8:c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Sun, 18 May
 2025 17:00:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Sun, 18 May 2025
 17:00:37 +0000
Date: Sun, 18 May 2025 18:00:30 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH 02/27] vfio/container: pass MemoryRegion to DMA operations
Message-ID: <aCoSLubCgXM7PQ3F@lent>
References: <20250515154413.210315-1-john.levon@nutanix.com>
 <20250515154413.210315-3-john.levon@nutanix.com>
 <56b2945a-3406-4d32-b391-d8d1ae49f7ee@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56b2945a-3406-4d32-b391-d8d1ae49f7ee@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO0P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::13) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: edd6b4ca-e852-484b-fa19-08dd962d8347
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Fuy99wVUeAnJT+QSb8hRTqNKQX/2d49tSjOm9bj2tU3XB6iX7s07OUCdWA?=
 =?iso-8859-1?Q?R232/fYenE8igDF7OH83OxeoFmiiR1264Tq/sYafcyeSa3AuUBtPUSsQid?=
 =?iso-8859-1?Q?YSY7eeD0Kz2I64gToFcnzUh286yB4HvWyABxhE65G8bh3IIDU/cagMSVCU?=
 =?iso-8859-1?Q?+Y85uCeCB8+V1jszW1hL2Pjtyi5JxVhK/N8huVkd87RPsan5Yh+xxaZokb?=
 =?iso-8859-1?Q?uM24k71BEbL3ZR9NrmlNJoUBDW/G+k9G/ejAHc/lUg8cATxLHGnXdUAZbo?=
 =?iso-8859-1?Q?4eibT0DcCZoloUaAMNy4TG8+ggcoNvnZGtlHZDRozsKe+jEKD4W0meEtiR?=
 =?iso-8859-1?Q?w8YCIR4jT1AeeyVHtI4IqYC1izQWpvBQcvGBcxrPPatN3iEcfYwnQZjeif?=
 =?iso-8859-1?Q?ZbYB5ns7OSZhbdEsOSz3MMs1C8HD9wKgpGNGBWTNWedd202chOyqWxnQq/?=
 =?iso-8859-1?Q?ScDlx4nqOSqNzY5araxNEdqPK0woY7Fh/Jt2RmIukjD0ETLjSDZoe8It2h?=
 =?iso-8859-1?Q?MMGWyXX3zj1oiGh4bEb4cPI+CfQRL1T46VUfjYxrSVET9Q54XNA2iMkXU6?=
 =?iso-8859-1?Q?rJw4V0Fs3GOpdQfKA54QSCer3oSPte70mw0bOcZip8hnkptadvFuhBMdTA?=
 =?iso-8859-1?Q?l44e1xQXjZyBCI3jr22hCXej21JvGu2F4qEz2MOYP/8bg9dh85W0nl79aH?=
 =?iso-8859-1?Q?OTgu1qeih0pCDZfQ4JTtdC7bsMba0bs+I/L1DN3gqeyZwU/mNV0A/s7HhZ?=
 =?iso-8859-1?Q?o2b836M/XTSf5QWoM6skVx8oyA7NLLDUexZd1vKV84BJoUeIqF89mIiJ5k?=
 =?iso-8859-1?Q?bF35AbmcboBOcSSMFXS3KcCwrgQb9SiaD8OtplIWplKZDEVsrSDNqSLMRE?=
 =?iso-8859-1?Q?XuXUVJU1jZZBM2ovHWpgxODYAEz3SfSVAeJsLaGbGqI3LuZCAAB90/Cb/K?=
 =?iso-8859-1?Q?VoCOCaAKlfJwBn+2RGZOlaI669lmIa/1jFIJ5rQcw/HZkBNs8HTfi+SnCU?=
 =?iso-8859-1?Q?a3zbQ87fkS6m2ub9Uyet1FjeSCFn0fnTv4MKrc5RbI/jISSqdhkbhUKwxY?=
 =?iso-8859-1?Q?qV2Ut1Kgg8vU+tmHplBV3uO5MsTG/yVYkNxbNSl7/TM90lDnkF6Os/BfSM?=
 =?iso-8859-1?Q?x+rjxy7yOpppVVHw7tyeauhs/LELyrqPqdFbahN4FgLOZUoJsCHTpQMxR4?=
 =?iso-8859-1?Q?0maoU44vhF91nfoxWW47SCFlOYIQpqtWN8aTQ5/ge+wPp7fByX6BWS+C/1?=
 =?iso-8859-1?Q?TCG1XfG49V4fCJI0I7V2leI6+m8wwLa+xiRYj4UZ8eX/E33RvCRkCstY58?=
 =?iso-8859-1?Q?Ym1t3DHtqRNvdLkMrw3tiAm1KPrSrDJgnkYiS0c0Z10heDaWrJ3gAqjAvd?=
 =?iso-8859-1?Q?6749eYUWWPZVRz9DB0O51iG7wcvD4Gg6gJEI0VqZYU7XhvdRBpq5TzgHXf?=
 =?iso-8859-1?Q?tWDmsjyQ6jes7s9RBhZWLjoYEEy1SNZWUYBLLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kSSH3z7brb/0BIzMS3iuaEV3tyNAjF3e79+sLY2/FjTQ8tGQwv7dwqvzFd?=
 =?iso-8859-1?Q?7ZzHvxyGPUysic8XTAmGz2rtvZsYqjXPt9L6A+LJmSdmK9KiKgyeFC8SDb?=
 =?iso-8859-1?Q?SCO/caSDYTQcXj6c4vtPyICHKLFV/91T6wHir/8D8WRADMI31f064bEdI9?=
 =?iso-8859-1?Q?x4fmGGkulBDZ5x3zp9unll1sczy8nvCBXsQX+xt/CupRRlm+aM03XyLnUL?=
 =?iso-8859-1?Q?7bSDTk0Gt2//p1burdI7rUJrmGKqzk+O5bjufAnJMiWr979ks1Ey6UlUkJ?=
 =?iso-8859-1?Q?XkCazuHNPtwZIp1os8pXG61zZtC33tJI3qFeCx+DaNkvu95HxadUaJaTjV?=
 =?iso-8859-1?Q?JqRPwgVwjOLN3tbwZp2zdhk2XEvO61fg2IY1pz7EVMozskUsY26GJzH6EP?=
 =?iso-8859-1?Q?CS3Tblj6+JAEgYsMBiM0L4MHs5Vhp9OJ0FqPzga4snoOwXlbsTe7Hyg9Wk?=
 =?iso-8859-1?Q?6eL8RlYT8aXqUfsGF/KpClqz2r5sJ/5Mr4j2QmuEQ8wMMmRwVOqh+LYzhB?=
 =?iso-8859-1?Q?AB5dtxtGXgIZATgvwzUFmZqckFOzdGdJW2TR6Y2IOEKaLkUfz/ayB0uEaX?=
 =?iso-8859-1?Q?o4rYB8Ofn9Sz6Wc4OpE3m+o95zUBIqqMwuofmx27WJ351oy2NCAKMxgQDJ?=
 =?iso-8859-1?Q?i1XTI9r8OaYZN4PlMvODBArW8zELZ+itKiGuR58wdxKgtBOyBWcwsYrAQG?=
 =?iso-8859-1?Q?ONX56nLDDTuCS7kojpCw8MQgta/YlFGxx0F4NbBdWZ9GeIBizryvm3jYS2?=
 =?iso-8859-1?Q?sySpSS0Dpz1ns4mAUvRWjW4REUxMatBKBsVhmQ/ugviZX18O55KFmJcEJE?=
 =?iso-8859-1?Q?Wfut1vhxyKLlEjTQGGdQ3xbTTlfvRdK9nkJ0FcdHuhZhlfIBCRoWY+yqTP?=
 =?iso-8859-1?Q?cPtW/OblYDoUCfRBOTJfxtKJ3Xk7EKlpZnI25myJtC0UTe/u5Awh48bKpX?=
 =?iso-8859-1?Q?orSs61alw1sTxMm338exELNKPsn2K5SmvbZxz65+08WNDN1WkHeNMTjvP5?=
 =?iso-8859-1?Q?9euMw76GFTAPXakzsEqN7LNAstFbLky77GleRCmNoH5HW02JoG4+PvoW2j?=
 =?iso-8859-1?Q?5xxiuKVbyhZeCShc75xBQVMBO3/DRUDTgY2TAGeEP/icmpct2hXJh5wsbT?=
 =?iso-8859-1?Q?/3aR6/v81kWWuqf4cfdp71TsvAQBuhfoc02g6KSe2aBgP5a5VZaOBowRsU?=
 =?iso-8859-1?Q?EodfRobJv9KsqgRmeN5Q2cMjwytVhcjc5YiJ+A5vz6YZ3Jko7GcU5/KT2e?=
 =?iso-8859-1?Q?NsEcAx4kZ9/Z3sL4SvblK4LTZXZt1yuuVbkXpexTya+9g7tz4t4c0orWTU?=
 =?iso-8859-1?Q?7xeG6U3u+GbtxVp8WahHH2FC5VX8zvytKz6iosI1MhPgi24uwjIVqUFIWl?=
 =?iso-8859-1?Q?1rY2/5izKon3Djbmgx96yxGFoVa8SFTEW4WmQZweCXnwVaKxLnZ9CUOTW9?=
 =?iso-8859-1?Q?5DUrgIh0lWbt0Mav1zkQPvv6+Js18jye2mEDKQvILAYE0fwGQO/RQEaEBe?=
 =?iso-8859-1?Q?XR8vJvfUToqP42apHvLKg//F5RAUiZTIliQ26mAf06EiDFJV6lbAyO2le3?=
 =?iso-8859-1?Q?Q7ANpXbACjI4QmzJKDdVC06QkL/i8g8XpsSkqdm96UvIlLreC1calIjY8a?=
 =?iso-8859-1?Q?j0R3YcxAE/i/lOAqT4bewZL/YWDIFBTZy6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd6b4ca-e852-484b-fa19-08dd962d8347
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 17:00:37.8771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hih4K8cwJrkJBwe8GlFe+RD6rwngSUTNnpwN93p/UA58n+wABd9uG0uPiRgWAMpmCd+bPTmdIZDVHF/CaAgL5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9023
X-Proofpoint-GUID: ee7A6kgmcgGh7w0dCZR17_fKR-3coqpk
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682a1239 cx=c_pps
 a=yF+kfS/uWKtSACHbTM5LMQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=OHDcUe7OqoLl1OeZd2IA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=Qzt0FRFQUfIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDE2NiBTYWx0ZWRfX3VjNpW+aTgY3
 z7/Z1qlR0fbsL7UFiT2vxUvJ5EIMScl7gVBXmP1emP7qU2IsKkoU6xf3MvpYVTsHpFhDJu21K7l
 QgznWmUOgxio0E++VKsdJYCuRSItZgviaI77hi7XiIUAqj5puq3nd3jzPKe6L7AUXurZfX2v3iP
 qHowKrBfYJrj9E0JrBdvv9odclSctpPpZHc4ztI2vEO+NQKMP1WmiZhki9gFcpw2qTilE9sgtVp
 O/UJVkH2GeKKPxAlush+l/r2aGxn7TEse6Vl9k+jxUPI+vwlS+/4eePcNCcLN8/ZqlI6vJXxiyT
 AhJB0dLZGbZdvXK1kuq6hIuqsZT1mKjUI1Z2Xjur1y3myQPtk2mFWxr6k2bRSKvCo+ZftNrleuK
 FQgb0XralDpZ6n27mHn87nqIfIUR/6eucc18OMiQeSL4//KN6Z7hvNjcKxI/1dLnGW7neHbr
X-Proofpoint-ORIG-GUID: ee7A6kgmcgGh7w0dCZR17_fKR-3coqpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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

On Fri, May 16, 2025 at 05:11:27PM +0200, Cédric Le Goater wrote:

> > @@ -121,7 +121,7 @@ struct VFIOIOMMUClass {
> >       void (*listener_commit)(VFIOContainerBase *bcontainer);
> 
> We forgot to document the listener_commit() and listener_begin() handlers.

Apologies, I will send a separate patch for those (and also add a dma_map
comment).

regards
john

