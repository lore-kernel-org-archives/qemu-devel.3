Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990DCC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWw-0003Pq-EJ; Tue, 20 May 2025 11:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWv-0003Pc-1D
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:21 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWt-0002iq-0F
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:20 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7HZOE032326;
 Tue, 20 May 2025 08:05:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gLSKAir9CownbVZp50Jw3pkCn369NuhHnd0TmbNav
 zo=; b=B4HgyPbk8HfkIG1PFpT3vX3zaVv5X12b/VhPQObOpe5JTA/3KlbQave5v
 Z4neIElMC5uba+t7vEHk/RBH181LDCoIVyyCx3YzqeteGxRbEbzs4zbz2UAqKQlY
 puLcU8mhwOHfjJ5w3Tl3Dq3xCgGWAp2P/Y/uFXrFADVoDq9y4U72p1ViyHqr7O1B
 xp7E+qi+bYizgReLN3QhzfmontvxWlz0HfZqZdvb58i5gDlaGep2kRZK9u5crRNH
 mjXkfBW25iiFbZ3XoSMrtfcbYsY/3axiDdR7JCD9h82XKkNEqPko3js9sdfuQXUU
 RyWg8E67rFh0eKcKqjJ3ZJHjTwo+w==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjheae9-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUMOzksa4iYcZiG2QPeUzztAW2JWcA+VuAjo0Y55x/IyzBqvLxu/Uerc1dtY4JuVNavVIYvUk2iyiY1iGVywfbAiZI78xFUrse07ekKImA0JYwbcwZTmt+TR/z8Gwaholv9wM7UkoQfseBjPbqSXzedmcDcJznwNjyt3Z0WH+cQYMP6oM0521nddBJ5gJpThAe4/YjlY5Os0heBz9BIuew7M9pOBA44EbALPtt0kHeycuMYUPv8O0/xPm5K4WFn9Uf1AiP50K2/TQkVDabI9ThTrRp4mEB4chUfYDNLh+NjKd5awXmjF06c5bmC9ydMWPe60DcSsrZVM3qV0CTSW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLSKAir9CownbVZp50Jw3pkCn369NuhHnd0TmbNavzo=;
 b=VYeCafx6srkqIcXjMO5u44q8tGTJ0D9/3uyDmLLsnbcubO9Vxzgu3ov7hpT7iaTOd0nkVxcOcGgGBVNcHdXXvn2pcegCF0hNqK13lrzcsIEjQ6o3Wzfdz6VjNf9BhYGV90JR2URCgKXZLXTFWAZiB5GLku5XO7lSR2vSANLFBrgwDW5SQt9A7sEKQRQ9LUIbvhXzLDIQBesJNo2eMN+CDlNms7/J7rpLzz2vzpmQcJwpJ2uuBNNyElA1n88ucNoV1Bo8jNECeqLtcflGa+aRIhfBEVQ6x+W78Hk7YlMA6OqHyLww0olojhUimi7aRFey5RZzVTAQZL0u1Wr+3XoKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLSKAir9CownbVZp50Jw3pkCn369NuhHnd0TmbNavzo=;
 b=xXjQwDbspKU8fHpzj3i3aFqlRyB6POoXVLW5H1X1Uc94wXn5dNYOPv559lYjTxmNDI12ZAPedwV12R8fCyXL4XO4FwXcqmsIsvEcQzYSPQBo5McH5BPjCwA0V5dyFfyee9+Xs2zV+iNskZdU3p+ixtVVzXxxdzvTP6wwpdlps+1t2MjKMndPFkwwm/RJzsiOk8myYRw1IaW2hZQ7VZ5ARrOFN/9rPxKEhcynBVebiRjTkbOhpw/K9k5n3LSvbsvGk0/kkcypAOc/aA1t5lNChPfLGNq2U/bGRhiTL7Z2n1103TCRwONGTossL6XFKhcMovC0xOYIxYEGpGl8PRzsEw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:15 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:15 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 20/29] vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
Date: Tue, 20 May 2025 16:04:09 +0100
Message-ID: <20250520150419.2172078-21-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e35ed78-0905-4b09-ada0-08dd97afb9f3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aWYdFvedFeik3V8ysjqJYMe11F2wd82i3oe07WdJIlQh09jQVuGtUsZB33Dd?=
 =?us-ascii?Q?BUfZ8HnJJ+wVM+D8PqQVCDUssONJiOU40ka8GUhm26XlzwagYI1T3VfBNUsz?=
 =?us-ascii?Q?fQ7YqzQU4aI+C+vaKov0H6UKVeqEHzJSH3K2BrZdA5YedIoDsyz4OzKMzbR7?=
 =?us-ascii?Q?XyvDZBqmM5oQrmFmxNiANBTtbn3+hpNGH3Zo8PAqHl8SxGZ7ufxLqBuD8+Cy?=
 =?us-ascii?Q?vjzAVUQemC6GZQyg8gga6rqPju/1ulraWFUJ4LmJtqCnFRqGmOm5Cgyzg50x?=
 =?us-ascii?Q?8vMvxSlarJ2myb9I/6Own0diUxtEP51OXpmO05mhfNWoDXAXmy2xSW9Hc4l0?=
 =?us-ascii?Q?4tepo1Mgy2IFyZU6y0M+qhzz1jPHIdU+SIWcXBm/Yt93FCZ3BWuBhqftjRW8?=
 =?us-ascii?Q?NYy7KJ6FG0aAe3CNiTpPX3UAT7UC/mcDcePnsrx6O1giaDZiDzkAlN6orppx?=
 =?us-ascii?Q?2Ou7r7ba9ryyXXe/wPzllOha7xADveoda2CWtERYnXM/IHnPRfhMi6maQy4/?=
 =?us-ascii?Q?6i9EEzMRcGmpO7dOKe7EJXdJaFDfai3UiEs86QBgXVTMtKANNPkoGCrBfThY?=
 =?us-ascii?Q?mJ5+erm6G8+DU/NVy3fHc2IVt+DWpPi1dLiZDD9D/V1+PL1EgShXnbJ6rtya?=
 =?us-ascii?Q?uW11wiv1zDMk5nmdCFXH8DHBsv6BSZfziN+rm5PWOVCYy0q+xRl1Lg0D4cta?=
 =?us-ascii?Q?4wPf/ozjiPh/8uzZaqaaz9RUVrnjlpr9kYwKwCgqtrnpYZK9LPRa68b4EeKA?=
 =?us-ascii?Q?XJ4KM82J6SKSII4VAgiJpQwKtYtSwdsZ1P/Gc/h2R/SOHcHFNWsQk6XCbI2T?=
 =?us-ascii?Q?ORXiSZ5iiupRG2d4oTjdGske8HvgppvCQFKboLEsZ7cYZXlikpzTM8YYGst/?=
 =?us-ascii?Q?9P0NuKIo15NEDKFAHniP3ByARV2gloLWnKOaZr6qNs/a1tN6ZDXE4C7G433t?=
 =?us-ascii?Q?rnYOEVOAq49OSeNvGfDAsG+55jOZs32Y6FcklIfJIMfPnqwvFrSlJDwRjoGG?=
 =?us-ascii?Q?cQwVeDdBi4Akll/98Ditapj87B8vQPHOhXeKBWPkwasQtNRYHp43Eh8ros90?=
 =?us-ascii?Q?+dZUj8f41ERoYh4aaJ/7w5CcU91lQCHjtlE/ttWxvxKZTdlIxBYbFIoq7qJp?=
 =?us-ascii?Q?j0trV0we5MsbxWWo0nbF9Cv+mJoMXXdkoQ6gpEY3VxEqU3kKHLiSCk9wVNz4?=
 =?us-ascii?Q?zkTl00/r8crUMa6wsf5L3IQglXdpXE2DqvJ5ldDqD8oCIY0HlSzlIypR5QuQ?=
 =?us-ascii?Q?8B0iYphYNbztQYGhy2DgMdvAhaMC8mhDLXc/MYsulgeBLcpe+l1wINhq++YD?=
 =?us-ascii?Q?DSCifBTBSM6vhv/ZrMjt049FIho2qaoKjZOhHSgzCwTm/KM5XM0GpmDvBolh?=
 =?us-ascii?Q?OP18Tav9Qfq0qmLRb4qgACo+9Rly6dwZOZ4Ii0NpJ1iW/ZYDYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EV5J6iyJkjJ8junbpnhGYIsi8Mp7QwhRZzpEQOwk0VuokF2w/SBulNn+GQMC?=
 =?us-ascii?Q?Dhi+3H18A/0dpc3sGKP/Aqw6AWfMf5dL3GAMakHdunoDuhFHUsERxc3j9+ZQ?=
 =?us-ascii?Q?EHgFeOLAQjZy74784boZnf9jNbVsJK+bV6hcjOmbiv9R5qlO846yBGTJJuNZ?=
 =?us-ascii?Q?ZoXR8uDE7wjC+vjLW+OPH/2ZWKMnVCoXK2Xr5KVP1IdxwIeDsW/lyB2rqfgK?=
 =?us-ascii?Q?lC+LmdK4hvj0dWJwy2NOxpnIJoJS7dWMxLFEbxq0UNqo/IfXBQAF1KsQA2ZA?=
 =?us-ascii?Q?VwxS1cQzyn4uTxS73xOOEMir8XPwS5XwKaZLLHGG545p0beImgZy+HcCyl0n?=
 =?us-ascii?Q?KKtHk+0UDio/TAyGevs8PJ3V7FcycEnBgRmDRx3TgHfJT/nLsJft/jMCUnl4?=
 =?us-ascii?Q?7xAgWdYIC6kASrmw+RivzetGgBnfZh6WYpl1sLuadwqTMWKoHEt6dSRW20iz?=
 =?us-ascii?Q?G+I2bLKH89Uy2jpn6emW+8HajNlTQJXM9pK8xwlxPVYM9byHwBZoTOoaPb1U?=
 =?us-ascii?Q?5Umvn/mtz1/z0OMomuxcp/hquZMJ8XsPWhj17IPwuuPIOIGONZwtcg5s7NYh?=
 =?us-ascii?Q?zd0UvRU3qGqOnZaSHr4xHGyqCF2VF4t7/V/6SifegJ7+m1QOGd8o9fohcGkV?=
 =?us-ascii?Q?NN9DPmu4CriSkj3OiBw4MOrZCHH5M7YVcojFYHlbuu9/jt1/1laTbJXmV6mY?=
 =?us-ascii?Q?SNNOD4krQxAyO4MCMxFwi4T17wu97WgBI98lJ9NVzfyYl4AqXOVaEZpXp9Yj?=
 =?us-ascii?Q?gExlCUjySoQoACsn8FGiNqB59BLFxWDg22PlDVmzTz4ni1e3EPSacs2BmppF?=
 =?us-ascii?Q?6MhOmhmW7YPxGHyU3UKyZf/DiGJ9wF17RWER7amcnuEZH49yxBqB7Gn3nE84?=
 =?us-ascii?Q?4fysmp9zE2ljIbQWyjiTdEOYMiFE2F5dj64EavY/wvMH0op2ZGISRFosrHZZ?=
 =?us-ascii?Q?0VfXoQjshPZHsu9Ygl9nRx4mLY+YXZZA4c6eqb5HzxT+IfcJZFOS4YhBgdL1?=
 =?us-ascii?Q?AewYUruQWaDbfQF7fH46vkvqeE24Nu4wU0QJhuOhnkoKg0PME4Mi9k5xzHeY?=
 =?us-ascii?Q?nTyjSQ45ZCttMnATduDur+dYoonnvSd69PHHg0qPLFrBJ6HYdt4LmWCB6iVk?=
 =?us-ascii?Q?j4lcgztDOajdYeI7dEp8BZWoz8I2vuSakgg5RwB7vYu2aWoTXryYgCVGA2Qu?=
 =?us-ascii?Q?5PgAiZStDzZnfqX+F/oSOYK+s8xwIcULZ6mxYCuZFL5RbjaHZ4PfbUFTczif?=
 =?us-ascii?Q?lVTYiivPWJCxENZSTG3ddQY0r7PWbOTZW3XmkA+pvgQ0kYBpmla6+1ROGf4E?=
 =?us-ascii?Q?ijRbSXH7r6COK/g+w54Uzz75dSNEDmplWiIQHpn9UOZTvF4u1ETxtl+jTiXh?=
 =?us-ascii?Q?PH0ZmEXuOA6+f5iUn8qkaA5O5mI9bKo04/Z01hY2xAwQUIwymQhZBob/UOmV?=
 =?us-ascii?Q?p8zsXJlo6vUdWiXgeckEJwBNwhegpJcANq6B163pGwkj2DIVzhJ7v1ohBG6P?=
 =?us-ascii?Q?0LAq5ktuPrmInwumLZNs8Z/KEpWIpeHJWdmOvASMA10/qymDuBg8H7hKYATI?=
 =?us-ascii?Q?dzcIjZwRIej20F6BKTyY4uWdwkxWHByuNINhsaSZ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e35ed78-0905-4b09-ada0-08dd97afb9f3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:15.2696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YpEYF4s9J3zIXa1WPLaKSjTnlwleL1kis3WsRuy2QtczgIw2fgd6b+YrKh5lcY+Pkjry+SmhL21THPvKy2+pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfXyCu6N87th1+v
 2UwoemayosMyF/uTqfrmaR/huA0BZYfZo39yfdE1fv8bp4GOt1JeAMS+lt4cR3ZyUi1sMkataHv
 2ES2nAxO925ZbNy4BsqWx2aIWbVFxB9W4dA21Wqp8J0sY3In1vLFwS6EA+8GkVm8zFy6cLMY1If
 kGsALiWm5F1+pgqdd15+MOzWa6vE9eDSRHbfEIfx3ZYMSaskj0Wx73vA9d/qPhT+qGer5YV/9iA
 fn7wEj1E44yRQAdmoi4kAOo7RP21G9qiUfHc76WZ91I8W5wt2h4cgIHnRoXVay4z/Y3rHDclHoY
 5KPh2EgR3L0vhcrGWkMb9YBcJGxJ1SQ9lAc1LJqW2bUQiXKJhyvyREfEcp50qD7O0nvGqbOYPIh
 +HZp1r6/juLQ9iYBPt69Srwnx5osMPUrpO+nWetgMfgmy87UIMbXaUiEwjea9Coc3PdHWjdm
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682c9a2d cx=c_pps
 a=hHPfuxNGWHHq0fQgDGst2w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=03k_OfxykpieI8sgW_IA:9
X-Proofpoint-GUID: IPcewKgFqqnHELYkyd2sIXWmCcncNSHm
X-Proofpoint-ORIG-GUID: IPcewKgFqqnHELYkyd2sIXWmCcncNSHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

IRQ setup uses the same semantics as the traditional vfio path, but we
need to share the corresponding file descriptors with the server as
necessary.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  25 ++++++++
 hw/vfio-user/device.c     | 121 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   2 +
 3 files changed, 148 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 8e6ccbe9e8..920b9c44ec 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -141,6 +141,31 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_IRQ_INFO
+ * imported from struct vfio_irq_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t count;
+} VFIOUserIRQInfo;
+
+/*
+ * VFIO_USER_DEVICE_SET_IRQS
+ * imported from struct vfio_irq_set
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t start;
+    uint32_t count;
+} VFIOUserIRQSet;
+
 /*
  * VFIO_USER_REGION_READ
  * VFIO_USER_REGION_WRITE
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index a767e4fb01..45b91d22f0 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -110,6 +110,125 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_device_io_get_irq_info(VFIODevice *vbasedev,
+                                            struct vfio_irq_info *info)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    VFIOUserIRQInfo msg;
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_IRQ_INFO,
+                          sizeof(msg), 0);
+    msg.argsz = info->argsz;
+    msg.index = info->index;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_irq_info(msg.index, msg.flags, msg.count);
+
+    memcpy(info, &msg.argsz, sizeof(*info));
+    return 0;
+}
+
+static int irq_howmany(int *fdp, uint32_t cur, uint32_t max)
+{
+    int n = 0;
+
+    if (fdp[cur] != -1) {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] != -1);
+    } else {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] == -1);
+    }
+
+    return n;
+}
+
+static int vfio_user_device_io_set_irqs(VFIODevice *vbasedev,
+                                        struct vfio_irq_set *irq)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    g_autofree VFIOUserIRQSet *msgp = NULL;
+    uint32_t size, nfds, send_fds, sent_fds, max;
+
+    if (irq->argsz < sizeof(*irq)) {
+        error_printf("vfio_user_set_irqs argsz too small\n");
+        return -EINVAL;
+    }
+
+    /*
+     * Handle simple case
+     */
+    if ((irq->flags & VFIO_IRQ_SET_DATA_EVENTFD) == 0) {
+        size = sizeof(VFIOUserHdr) + irq->argsz;
+        msgp = g_malloc0(size);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS, size, 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start;
+        msgp->count = irq->count;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+
+        return 0;
+    }
+
+    /*
+     * Calculate the number of FDs to send
+     * and adjust argsz
+     */
+    nfds = (irq->argsz - sizeof(*irq)) / sizeof(int);
+    irq->argsz = sizeof(*irq);
+    msgp = g_malloc0(sizeof(*msgp));
+    /*
+     * Send in chunks if over max_send_fds
+     */
+    for (sent_fds = 0; nfds > sent_fds; sent_fds += send_fds) {
+        VFIOUserFDs *arg_fds, loop_fds;
+
+        /* must send all valid FDs or all invalid FDs in single msg */
+        max = nfds - sent_fds;
+        if (max > proxy->max_send_fds) {
+            max = proxy->max_send_fds;
+        }
+        send_fds = irq_howmany((int *)irq->data, sent_fds, max);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS,
+                              sizeof(*msgp), 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start + sent_fds;
+        msgp->count = send_fds;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        loop_fds.send_fds = send_fds;
+        loop_fds.recv_fds = 0;
+        loop_fds.fds = (int *)irq->data + sent_fds;
+        arg_fds = loop_fds.fds[0] != -1 ? &loop_fds : NULL;
+
+        vfio_user_send_wait(proxy, &msgp->hdr, arg_fds, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+    }
+
+    return 0;
+}
+
 static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
                                            off_t off, uint32_t count,
                                            void *data)
@@ -179,6 +298,8 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .get_region_info = vfio_user_device_io_get_region_info,
+    .get_irq_info = vfio_user_device_io_get_irq_info,
+    .set_irqs = vfio_user_device_io_set_irqs,
     .region_read = vfio_user_device_io_region_read,
     .region_write = vfio_user_device_io_region_write,
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 3f5aebe7ac..053f5932eb 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -9,3 +9,5 @@ vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d m
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
+vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
+vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
-- 
2.43.0


