Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D71C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyO-0001D9-6e; Wed, 18 Jun 2025 07:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyM-0001Cp-AI
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyK-0002VA-96
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:53 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I7bhX0005685;
 Wed, 18 Jun 2025 04:28:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+nlGhnacqd9PrvZ4eDkZ5K7nZI+9vKXwBzEgx0OEV
 PU=; b=INE5+z0zOOcDV1QwXDPqgIC/PImJKJhPHMX/z8NCER6oiBWDIIsBmhcUx
 +Barq33CIpvMTi/bX1Ev4/fjLD3lyEMNNTtE9HE+jv2ozqPPT9NXfQccmtFlx5ZV
 CEj1HW3TjuD5RL0cPcnB61FDvzHtwgMfQYpS+d7npi4n9+sFIgfJq2hFwNzm78zG
 xhzR4l5GrTFj5hrp/zkoCvd5w2t3/gKd/f3aPFQ+Lp6rt4eDbg7nKB5VPp5UGy2Y
 CvXjpUwGx1TZvBUXAK69bSlGx45Ut8VG4X4PMxYHMb3fVsUaaTp8BwSknZhPWTZM
 tShiE73QthxxetmVQvPfAAlQMgOOA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2097.outbound.protection.outlook.com [40.107.92.97])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4795dus26x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCUWHdiPNXJOCtqssMyE/CiJWbEgemnciesJzG7HDJRu0xj+aifLcCtWDeIIvklrghXGQI4Lolun2JRfUtZK2NqyjKsWfeZAjbuC2rWoetEHX8PiQDxWKEMld7MVHo3e9zCP5d8rbsRZzyzh8CiZVjta/4DuumWy2hjUmph9qElAZXx4ILUFgLqOJ0aPPhPgM/NmWqDzV5TtMdHuWTCGaxHBFX1LsjkhbQDJEVNflvLggJ+s7EJP/So+GiLAi3hwoA5L0dCqevAyXeAJEy4BtY6JsMKWYditHKWMAUlwFDI83YYHQbVGVy1k57pjh4blwu2/YCCuM9pdjA5fl9tGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nlGhnacqd9PrvZ4eDkZ5K7nZI+9vKXwBzEgx0OEVPU=;
 b=bOyiqlscNlPSZ/1FvowSXGgDP7GH36pYxLFKFybYpvEluWWmTV07oQ3m8s36wB2F7OU4t7WZvzXTiWvypIt9cyvw/S/SRYTGBhtxWiYcaHtk2DGJt11CfYDXpG2tTiohFbyL+Zdc/ZbaYayAwMjJDoQNMwsqTh6PbYQHV+yRdr9Dkheut4g6OHYZ2jWIC8PZlcgaVuFStCe+oKTNL9wMrLN2jrJResxJOmJBI6AN51f5umD34M1D7Tlfl011sndLqJ78KB2i2rIcAk3Hv9M1h+wUrhQskv2XD13H4Kql6rbJsXaEiqze0WrVbRPsbW3dBz8jNGndWTgTmMutCOsU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nlGhnacqd9PrvZ4eDkZ5K7nZI+9vKXwBzEgx0OEVPU=;
 b=yiMDisk+VXEA8miwl3o75Uck1atOvSb/vxA27WfSV10fVqr/iZ6veUc1vMF1LZmGZKQLik624NTqt3dv2pOynU09GyA8TgP6LtfF/jrr7u9//ys1sRjy8jq1LAz7H/IM2vKxCZaukaY37K1OAHpmv9PWf/MhdxtudOmdHlt9NkpMQpVF8gyB+ab0ALpAp16+NcrKLnO37u0ZC7kzzns6kXISPB6xO2gghkOLv3yEhpp4lhvUhUqQC7oIdeyj+ToBOG+xqhCgS3NgT6P9T3cvp1HJGzSV5z7hnk4BHLnWqHWUh0SM1IRwUGX1Eeg53YEWRAZtzQTc5eA+BUhbDAWblQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9632.namprd02.prod.outlook.com (2603:10b6:208:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:28:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:28:43 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 03/12] hw/i386/pc_piix.c: remove SMI and piix4_pm
 initialisation from pc_init_isa()
Date: Wed, 18 Jun 2025 12:27:08 +0100
Message-ID: <20250618112828.235087-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 773f9cb1-a4fd-4002-8ae6-08ddae5b47f7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MpuNnC8KDiUPA4Oz7nhI4eafR/jpWj0a50g/UUwZLaeCCzBKj+dEIfB9D1Rc?=
 =?us-ascii?Q?xblR3xI+xtqnHFF6O0XDaYGNFEG4GLraUelGJYXt3ld0xxUQAf6qK0zOOxxF?=
 =?us-ascii?Q?Eu5ePMkXcImteCfLetmUqgC5mVTCI50EMz2N5Sprl2Qwzlr5MqskDgMlWRQy?=
 =?us-ascii?Q?6GAl2vKS8Cublghh3NKRjtm948MAdkUMpJaiYwYQnU7frPtjcTaurAVK6hb2?=
 =?us-ascii?Q?WgQtN5fTnuSlcUS5Idp2ZlHl3DQVkyNZ4aTy8l1NZ0fhI1FSNRfc1sskHcXb?=
 =?us-ascii?Q?YBjotdC/KvTWyYqOa0uep8pi3jwtbXfKmyo5JPrGh/djPphL+fPqvR08oRBm?=
 =?us-ascii?Q?hMB3PQyGffwVmQ40isaT6h9TTEl+Owz9mrdxnITohjdCsT2MRRmbTCnZuv3f?=
 =?us-ascii?Q?ZTiGy68hspxG3BwM7bJt60LeyWXpOBklGqxraFaUi8HR4KGazYSuoGy3+KSI?=
 =?us-ascii?Q?TuNaH3wYZvf2YGGAN1D1CepSKySWCgQebD12ySGIVWxhC6CP2Cyr+O9Wcwms?=
 =?us-ascii?Q?5ZfvMIhvhL8t4F8nOKWxihU3XdAzSyoJA9ha7MQkHriuEKObPDdE4JO9tfGI?=
 =?us-ascii?Q?HGBf/Nh/l7thBEQpkenUvWQasrYogfze6UpSVsz5mgkzZV5cyRQ2+pIk0A/h?=
 =?us-ascii?Q?vjPpQ0bq9uuh+GgUZnmlTivCnS1JYYCarwA7gBtMfXImI7iyPYBBE3to5AVl?=
 =?us-ascii?Q?mkyE1lDMJs6JNaB0c+TfhFqHNTi3gM38CUiAz8OLOxYLEHG7QQerTXGf8Khp?=
 =?us-ascii?Q?DIsYdPNkvPnXDKCgWxZ6WroedgkAwtCLEKTDh3y8SxYbXtH/UAThalu0Gww0?=
 =?us-ascii?Q?BbNAox3/2AHUTQ3pzUF/aLw7h1uGzXYblU3WwPurj9AVpU7Ig/mhp5aGu/yy?=
 =?us-ascii?Q?D5mvQ5s60WebIaFYVT31ihTEDMjsT/7ct9BeNc9BoILwb48ORxi6Ed1McfH4?=
 =?us-ascii?Q?fAf0ORmT5n0h9I2mv2oxgcAPYbsTLwe9F4OckSNEwSupOhfe8qa9GyworxYy?=
 =?us-ascii?Q?cqdxhfTSNbUX6vQy4ARkJiYn2+47IC4C+ZxFMXAuMxNKLUhYGmLF1E0IZPJg?=
 =?us-ascii?Q?M2HqihPxO3c9ODkrKSoSpe67arGbsdQRO+zefhlUEhi0fWxnugca0pzOba0B?=
 =?us-ascii?Q?o8CGnBb8ovWV7SSyJS2uaGpetMGRgDZyQZSZ6Unuu0zSr9tC36newA4miqVc?=
 =?us-ascii?Q?X3waHcQGdKRJTrr0a4FsKPVnbSFmjYNv/8vOJ9V/HNmuxaJbV3rUwLJbKpAU?=
 =?us-ascii?Q?8W3nUeKaktUIUOshbRcu8FG07Jq7sEroL888EBZDY6Wsl+pJDynr6wkzpuR2?=
 =?us-ascii?Q?EVVNl5fopyXZnSGPFaTHNcyE9XGTp+WcZd6PhMTkdXI4Ju3N4qOkWG4mLUyp?=
 =?us-ascii?Q?VXJFUSlb4lg8Sh9CubJszvI8Us25qudGDl2vRNr3w3yLF3HjtG36mhY695Oj?=
 =?us-ascii?Q?KHLGRO4pEnk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wiARccoqULB1GDl5SoAkT5p3WiZTkFjt0A6KQuY2E4OkPoavjWVnSybnv8yE?=
 =?us-ascii?Q?SInG+vq/435pYSdP3okVG1LvnxKzANgdR9Cc1egQsJ4wY/Rk+5QUPookXWdk?=
 =?us-ascii?Q?1XSlDznaW089aqMH620y3UpgzUKpFu+cO0rS9ymrKIPwPGJIFiOgOona7QIZ?=
 =?us-ascii?Q?wBsGMQiqfOvKmgxwnkfFaWZhiSyXlAMne9l2eIEPnYg1RSPuKdtAeEGkciru?=
 =?us-ascii?Q?pX5cQnCbpLSndvchnrPW5rkX9lwEHTb4cdmxWltrekQKk6eglsE9TYc0yvxp?=
 =?us-ascii?Q?yMapX0nHC7euG0B+4kjzjVe4T5vJuhruh7RLaUqX+XXTCqXLmA2/oNjKwq/h?=
 =?us-ascii?Q?Ah5a/Wtg7v9AbVA+nijZhfJ/bNqQwpxe5G50BaqiUHsi9/ZUFHgPgTzm201v?=
 =?us-ascii?Q?fxNw8m9WEDRYHxpssuWn59BnfdwayNkI5Ue2bAjLwGvv3Wgp7Dz3UBsxoL47?=
 =?us-ascii?Q?ZQ34/0SA4S5UwiSdA5ZaC6qFgwQeLBVZhT5BI/MoG4qyAwI5pNohXEqEiy1k?=
 =?us-ascii?Q?TpPA1JZ1Nl7nPUlOTIKvdWZHquPTdvO5YduSPtiLsqjDgqLA7KCmcwgD60WE?=
 =?us-ascii?Q?QNlWa+FRG1W65zE4Avarz+CLnCwSgj4v6uea+cCMnpKx8i4SFdehEYx/21Cz?=
 =?us-ascii?Q?0drkdT879tug0p3MUgaD2aDXKE9s/OSZ7RzZsF8eOfHtG0pZTYusUlbdUnHN?=
 =?us-ascii?Q?tn7BcaEZ07BYBIjgmiESqPj3aFbSWiuSF7TLnnwFygOiVnhwZLkxhx+ygZFi?=
 =?us-ascii?Q?2pGmH/ProI6GKZU/5PzcWuxsPdD91lZ+VvtnSmLDqZ3ETy3WURq3spqEWj4T?=
 =?us-ascii?Q?G4+2U0RCnzPwkLfegTVbE2dqRTZd0ZCzQh8ARJfIMY0B/hYH7iMcYlUv3LgD?=
 =?us-ascii?Q?ryPlyQOol2wYrkZJCdoi0qt1ZuVJqdxTHoJY2atjUGtrV2GqtUyMpVGtn40M?=
 =?us-ascii?Q?dcqhg/16nLtqeoX5PKFer1izvmA8OQNRqUk/jy369o2GDTMof+vBNPfIrDX3?=
 =?us-ascii?Q?9ReX26DaJkEpXpMe2U1TR4d/GBhHHLBvJWylXUSiyrEYPIGXKloUx6co95Ri?=
 =?us-ascii?Q?nP1RVC+wnXcxxfW5SvGAn+OG2SpcJWO9led3Vm9C62tUT5tmXca7RTnQt38s?=
 =?us-ascii?Q?CsENv6ts98nQNpp22rDxsRyz9+hNMVsPHDrjZoOKyzieQD1r3jzE8Jl8d0Is?=
 =?us-ascii?Q?jzPL6D7uuh6H/eXu+skd+6ja+NIeZZ9gr+weV6+SctzOC0sCbbnyVv57jFxk?=
 =?us-ascii?Q?GTzxgJIqoFGETH6biWts5v3taJVa/mg7Mv4cr+uYHJ7JylsZTenhqxJoJ43s?=
 =?us-ascii?Q?6bKNLtuxK/uJg5TUhP36cZCtCAvpcBGkCkDfbOGC+DgqpXwLh5SMTuUyuXsA?=
 =?us-ascii?Q?rV4kE1xBs6QJC4Lxm+deXotrpkvashnJcYzqCbFTtuyD/vVvPK3kk+NXPNCE?=
 =?us-ascii?Q?vFh9x8jcd1ARIjQbJVyGdQZY1NXmr5efVtm67Pp6FSQ7VumNDbq/E5PPM3Nf?=
 =?us-ascii?Q?BraEyx4hB+7qgtuwy+0f+ehzOUMErTolGJJRxs1+tN4rKC3TVkjUhvs+nHvP?=
 =?us-ascii?Q?YxGN7k+v7J4WpGQMo5t1sFMS6c6bNUq6PtPTKgEVYhA3bdkVuXlKnl94kiC4?=
 =?us-ascii?Q?ImJQ1UmAww0iINbbybvjU7d00X852IaoCtCSt0i8/T0KE6tuCBmQjyLDZSgj?=
 =?us-ascii?Q?VBAwsg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773f9cb1-a4fd-4002-8ae6-08ddae5b47f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:28:43.0005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JmYWWRKFpGxfVouDKZlqWmFjA3CygS1Ilv3uExXlwBYj9KF4NA81s20NcPeNJtAoCS72rQUctaZ4Ikkl6ezeFxttXpYOmcqWDCSeWlzlC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9632
X-Proofpoint-ORIG-GUID: o_Q1UlzxCfFvUpZZPNTkq5dw_8Txilal
X-Authority-Analysis: v=2.4 cv=VfT3PEp9 c=1 sm=1 tr=0 ts=6852a2f0 cx=c_pps
 a=AtfF7QnjuUZK6qv3K7ssFw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=34rjppMlHknrnf9OHTcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfX0u8va4UHkFaM
 UXGMnQOEl2a2zvrL6JCp8kS82Lw1LIWxAFkpoy5apjxsKWIfpNmbvK4BlfWYbHGvXmbDgf8sxoM
 3DcCmeS6FIfbqfCjMtZl3dzmGYVn4SEh2oH8zlz6a1Q/RntMlg8yNPQryPCoxdqHPr98EfpasLS
 hMCoCheLfCNK6Os8K6B/INn3Jj7fXlA25oZdHhkRCaRnx3qhpTB6FTit46Vr934R3EGUwSGIFdy
 VM9P9KGz11OcJPNLMQM8E5EnTCYnKi3S2rKJKF3Xa8BT44wgUVZW6yxBybrfBUaJPWftb68JPde
 ZJEfziTyLn/kg+NTVqhFMZCH7pxbExtA/A05TAJXysmi1Le9PNspcfrs9RdbkoqVn8BP5uydVaJ
 0LZD6Lx4cIWSYV9EV2QtsGNbY3CGLSJgjzP3RCTmLSf5QqttHDJZiFUhjOtwymB+UM3J3bRI
X-Proofpoint-GUID: o_Q1UlzxCfFvUpZZPNTkq5dw_8Txilal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

These are based upon the PIIX4 PCI chipset and so can never be used on an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 102e785d27..2ce3a3463f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -424,8 +424,6 @@ static void pc_init_isa(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     ISABus *isa_bus;
-    Object *piix4_pm = NULL;
-    qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
@@ -566,23 +564,6 @@ static void pc_init_isa(MachineState *machine)
     }
 #endif
 
-    if (piix4_pm) {
-        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
-
-        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
-        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
-        /* TODO: Populate SPD eeprom data.  */
-        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
-
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
-        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 piix4_pm, &error_abort);
-    }
-
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                x86_nvdimm_acpi_dsmio,
-- 
2.43.0


