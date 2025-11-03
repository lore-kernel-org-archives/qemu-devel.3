Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD41CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFz7I-0000wl-GJ; Mon, 03 Nov 2025 13:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vFz78-0000vQ-Rz
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:17:14 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vFz6z-0002IN-EE
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:17:10 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A3GuA1W1347526; Mon, 3 Nov 2025 10:16:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=dhWxQm+4+gCKb
 mG29iRVEnM2cO04vuENsMSH6joKB7Y=; b=XFbnvVWiR4MruJ6JoSG08R2jdZmYJ
 YgwBPgVIo17Dlw+GPgclXTO06TZFEjkQGRa2b7YcaDIn7+OgQ0g4SZDDm881O+kR
 8AtPgmE2NphJoXm7hALdkPO2OV4mrCJ18W8ouiAIZkrEL1agaGxjb+/5Nl485Iw5
 Ybzob5qvQ+if1knxJJMDohOFpHEuSj+rQfDJ5hFWKwquGIA5m/7gK7+gT5lTcVyb
 +cQwPLvxN+PiZobVNEguLiABW2QgJ9lA4Hs0eJBXXA1R1zpd0pDkmdAiWalUKi9k
 SvRjU08y0DpfN+HErH+O/AAJw2dZwtPvhJtVfI3T0NrkICA8tVhPqk6RA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020117.outbound.protection.outlook.com [52.101.85.117])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4a70bq86vx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 10:16:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osJHhLMWCRxGdBuEFVVSW/nXPvL8qR2c5sRhFoU5p9NfZWbwUtS+0OcLaN/tiD2Ry74mOe12nWu9dTXNmRgCe8ulTDcbWKPwNn+c9fDBvygG05TAFlxJwe6WRWsUWSCCKXdtFEMjEGg5TSkGGTPvs6tY1aG8I1PKkLgujUToZYZAkRrARhoP+pUxR5v6nmQcnPiSYmv9BPeHMWZGtjohbV2Do81yLvbdS+EPyFiik4DnT0ja6Vg8VDTOjg+yr/fbyCXvnjbwek2bhxEHUQk2im8+q+Imlb6nMdBf9VE/kUrw28b2l75WjTrCRe8W5W729l3nY7z08ARdJ62pdgBJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhWxQm+4+gCKbmG29iRVEnM2cO04vuENsMSH6joKB7Y=;
 b=AcWPBAYys0HpUb+IgJebJopbyAVM9mZp4XWjELfxo0isi7822Db9eMhq7ZWFaPi5wHZr3Jr/nmF4VRLNIi8B0QCD45/TltMFwIHre35dhXpOUHzlke1WqlLH2j/Bd0NpmYVtDPNHRDHq4XhtlsEY/fFlSuYqs6PJNWos+NpKUSUe93SHkZvzxmJaGokbYctHRdlE2+YiRkXMMUUtt7/z35xsn7ZWP1iuPKy8UdrMenr0WpdAn4pngPaLoiwoCwP63qdzpnV2LwxtnEZDSHFqrW9uKhW9ySCYHadNqCJwWqb6euUar/CIjA4dtzKwQYTBF8ruVFFjwlvHL6HmDtrQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhWxQm+4+gCKbmG29iRVEnM2cO04vuENsMSH6joKB7Y=;
 b=MY2ivxRX623H/EjEF0bpnWOUyVgsDrCW+UZynJaXSgmXp6WGy1MSt/OscAbda8djiXFXmLUF9TN0Ooaew+1gXCP/hCj6t9ii2wwFlt7F+PjsZJtvTTyqhQP+HTzviy2pz63YGl7geosQrol+N+jKItmSSqKN1wI5mX1gfbOyBw1gEciW8Y2bkmu4r3RQgZ6JdYZa+DPlckTf+S4mrhuZjT5aPJRbsoKMyBUN+yeOEbaFhlsR4yDynaimbluRWi+po/pdIsKseCdqMiwcFWsYiy/aixJy253OPiy0ibFvO+XDm+vgLbMUEprKXnii999KUC072E5EssUkRLjKEDNDIQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BL3PR02MB8202.namprd02.prod.outlook.com
 (2603:10b6:208:339::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:16:50 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 18:16:50 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH] util/oslib-posix: increase memprealloc thread count to 32
Date: Mon,  3 Nov 2025 11:57:50 -0700
Message-ID: <20251103185750.1394036-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0144.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::22) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|BL3PR02MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: bac2173e-2692-47c0-c07a-08de1b052877
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T4ASACS1+Ht/Tb+kz/R+lq1yEPcHw/IL3BlzbFpCOAJtX9bSX0GtB/UkRq7s?=
 =?us-ascii?Q?kuffxdFOuy1MAghgS5B7ZdgS98KzizN+GdcI/Mh0lOwWdpddzvsYT4kMNY4u?=
 =?us-ascii?Q?FA+lNRlol0LkN6YMKtlQa8ZX5ViiqsFywgmH5z1yZ62lr4iLIQe+iv8bkcT5?=
 =?us-ascii?Q?LMp19FLKAk/A1bDH1l4lBeJuFIXCf3mdugmNxgn9GMr88jiElDMcjwyOOgf4?=
 =?us-ascii?Q?pf9/MCFMkmP8fPT0HT4Er+comIDuPNgRIbj8qFJHlc+hvRz/MccxGOAUWcJr?=
 =?us-ascii?Q?IgYkqgeO7wbAt714oXxLmtnRsTn8nYr+ZVAqhfU6tigFQ1FOvuR7iH2aIAmi?=
 =?us-ascii?Q?l5+WBtOz/zQCFRoCtLI2pcsFfhhNhFeGinupPS6aPDOI7Jpcz0cMOdczPCQK?=
 =?us-ascii?Q?2moybf+D5CqNXtSpuVW8sd3+iXZSGN2cpqdA2VgyqhXeFMrSU1/gjCDrLEoN?=
 =?us-ascii?Q?IjwNDWUCdPqmG1mROJzFJmQ11j/qLC9ASbZEuYdNo2YlBPHrv3rt+9YpjMwh?=
 =?us-ascii?Q?1gt2mRk9RwXJRe/RI4CQUBGUasJhvEaIBjZgv21tbuHu6YkJ5N16myRhnLpq?=
 =?us-ascii?Q?PtIxENONQ4nUcGVIxwOu0fx0WbXDeWE+7N3DzpfFwky1Smi2Vy3qq2KRljNe?=
 =?us-ascii?Q?XaRmyqBlHLd4NWBMuRb+PiGLBQ+NiGuoOmscKaETXKrEcSjR8ERAzZrWZoph?=
 =?us-ascii?Q?0wKyCabQsPMzzc95x4/9zRJTDhwuMk2uZmJibCSwoiXT2D7gdKDDDOub2UKM?=
 =?us-ascii?Q?BPMuZcFsHTf7QVH/VrrthdAJpQkqNhHACt9kyEdBZcEy2Kf9lmYlHqiagQy+?=
 =?us-ascii?Q?WrGkNXQiDI7qTUxDfX3YgLgW68VxKUUuab/rAyAlbXFcIUXZ/tqF+z8NG1gl?=
 =?us-ascii?Q?Rlnc38/nY9tFtxaUUI6fZx7Wjj3lKuVVABpwQ45ltF55HofeCfn0zHMkYTni?=
 =?us-ascii?Q?fQTIYelsB1JGkATYKY2D5mHYCuq4k9DLK1nLOkvK9K1+hpsjfIdFmDN6tsbQ?=
 =?us-ascii?Q?zchRkcgXXgNCQiU6+mx/uERbr06GAkCBqregL9XdkKBx0jsJIJQnWeXKxSX5?=
 =?us-ascii?Q?FaYjvJeG54PJJ4LG8c92wK5nM5hNKN8XXitqcXWATwH48+fy8oBXdp1NoS+h?=
 =?us-ascii?Q?HltPzVdBGaQk/I3qiRzUAv9t3VS2CGk1nAGm64FQQIcP3fJx5G/sPr7tGLtG?=
 =?us-ascii?Q?NrszOJKXdVATBeJ1vh6K5oifzrB5HUreLkxJ+ZOrRzZH5fi8ECNaTDv5y+mH?=
 =?us-ascii?Q?r8CjL9ZZX12J1Q0mFiqZUhUYLcMTWxzc4LAF6I9tFvPjmw4derf5cOsvxwHK?=
 =?us-ascii?Q?uFXThwhn7wc2i8NaF/bKxBksMfas9Ni9L9WQlehSuvryLUWFrunP8GPiAbm2?=
 =?us-ascii?Q?n/Uz0RRtUnk+u6oq9XUtbLBcW+MB5uj79wTeljb2LjwELcbPyja9HJdC3C7W?=
 =?us-ascii?Q?/sP97KH1MVruJ5DaWqla6nCJzy5nzZSU+lvpokiLTYt6crVlfTY58d29Lqrb?=
 =?us-ascii?Q?gIow3N3lkM+PkhdMq2hcoxXyMrH/OMwKJpyM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AO/KlABze8fvNAzIjLEC0ikcYIUhvj13r93RAuZLZcGL53HkMqWlDgT50gSy?=
 =?us-ascii?Q?j1KZoMX98sauth34Q9Y5kKJYAr8oQjrogovgV0oV6SQkamP1zU+5dq2+iG8t?=
 =?us-ascii?Q?WyrsEIAE/HxpDckD0gms30nvF5+wgoM8tQu7mxj5gfm5NDYGiD9BHuTISxoS?=
 =?us-ascii?Q?7Q+NOLyYePCYUlTy1dwZ9eWq7Ii6acLbaKZ+q2MXLMagpABxw1XuAPs5zipG?=
 =?us-ascii?Q?z+2Ac90vIArdv2ql7lzSH9L+Zm1weFwUJF9uFzWimTacNx5ry1H7nizblRQA?=
 =?us-ascii?Q?5My95IqHz+C2ARXmzS65Yftic/IWuz2jKZzfUpJ1Uf18K0Vh8+LfQhe4GZoH?=
 =?us-ascii?Q?uh6hN5kZA5E30C6bEckt0tUrFUEuq+6gZIeQzyhA3EZxmS1/udhOVih5KtAK?=
 =?us-ascii?Q?kbH9YQW/945RNLCpUinBKhzt7e7Cj9Mfy9QfXQZCi81670myKMyYL8aGBazW?=
 =?us-ascii?Q?TrVAD426JkJmcVU5tEZP06L228lVHMTxaO75gz4W3jHHKhXHJGa5PnNwshU3?=
 =?us-ascii?Q?yPdc8txE8IN8vQ6TY3NoDD1y7BCBA9SZ5z+YrgKRcgD9ZtA1tF8trVh7Ga/v?=
 =?us-ascii?Q?l3z8aUIVqWDywqklG/Qols8gQWEiJO6nqsWgw/ZaHzfwYL93PLG5FMrOe923?=
 =?us-ascii?Q?1WN9QDh30UAurtii9vN0zhpo/4anzL+ni2QXwUPpTklSd5dGl3W9SrgDaRdP?=
 =?us-ascii?Q?E6DWQL7qzPgEdr50pqK76SMeCIdsf1C9mUjuPtbx2ois2HefEIGMMcrVslNU?=
 =?us-ascii?Q?SxVA3jXt+EZDMHi5qp3+2xYSTg+FIhAvqwpDaUY1F4rEhcnNNPD6gRmz6reH?=
 =?us-ascii?Q?KbVew3fhT16Lx7HFlJdBqe74DMUn9cA6GZI15LrtVhcF375KQIPwZJOGOx4L?=
 =?us-ascii?Q?MwcESyYT2azdM4G2H9RBXmHx/4+e0Vrudi57gQIGcqN+83LL8NeUXMl3EB4R?=
 =?us-ascii?Q?EOlrVxi89fS/6Bon2GALF3h2sHBGbN06ZgP9F8YnWI9Agx1BXlYNe/sJXKxc?=
 =?us-ascii?Q?pT/VOv4R0+G7t20myOAPnR6elifWYE1TPouPbjLwq2mMi0Q0dCEk9mzkeapa?=
 =?us-ascii?Q?UJqqk4w9j78TlhlKJwpGdKrsGFacCzsL/WHwPc+R38S9CfoDogp2hXr2Ror7?=
 =?us-ascii?Q?DN3HdQGBcfIKSSuoSei5Ma0ZQaJggeLAq9aOssAT2WHQq30x7kqbkVqwoHo2?=
 =?us-ascii?Q?xkjk1TpobQ9zQ2Zf64vRou9uRLHUTA5t5++ql1zCkKKSDO4nxnXhA1e8EmMP?=
 =?us-ascii?Q?hSsdyNUSEILtuR2ocSrWhiXL/JP1cu56K6Wiz5TXfaIsYNkyavJA8Qj6kyrK?=
 =?us-ascii?Q?ibKwpEn8IRglLA3JlNN6xD5PSf1/wJDSKGNinLYgaBKIj0PJ51w5OY3WHvgA?=
 =?us-ascii?Q?zb5e0biOjRylpA/XUtAGaHkbLzHCxiagLHG8Mv577LL+0rPvfZIsI0KzQacg?=
 =?us-ascii?Q?ZnvR59cFIXenjpdiau2rsZ+nORgq2Kt5zUGulavLqCkqfOhEuLBPYecs16Kj?=
 =?us-ascii?Q?zQACxgoxR8P2+fym1Oj70KsrJGxgH3Ko+R15XGj3vA0DtSIW94X6tcIwHpvJ?=
 =?us-ascii?Q?1U9mt6+ScBL9Qun+1Nvdfq71aZdGnhlLNLgRpKD53Bp6vM0hp5qlIIn3xE2r?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac2173e-2692-47c0-c07a-08de1b052877
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:16:50.1740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6AtRS9lg4qHNwhd1zRhjis3QK32jE2GjvgYNm7brqM9OiJvEtcXzpsjFzHGUmsfOzWXLRQfyCWG2QzM8EdowJS0IeL3dZ5k7ZwksuJ8D88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8202
X-Authority-Analysis: v=2.4 cv=TKVIilla c=1 sm=1 tr=0 ts=6908f194 cx=c_pps
 a=bH+lGM7ukYmG6LzVfPy9ng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=xR5HiEcENsq_FHwd6DIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE2MyBTYWx0ZWRfX4xx1AOIRgMbd
 QwV0Dssluo/kBgfuTpn2k5IkUHclc8r4JL/PXSEECK7HoWGzgMch8/iXwCwPEcDKjxpj0+qeQUH
 5c9M2IfnuT7qycJ+9AQtRUa0hD/HYPKRQMdGrJ/30pOr96jS6PG7tY9vx7EI3oUZqs3sjWUjRai
 3qsgxqaNw8P2LAmdlx5yMxkfJXT0Fuo/hzSWZe9o9c+Ax/upNm4a4jtoLkKgAjZ9HA8Jfq9WvF4
 /SVfbk7FbYfPI/aaxHvTrKm0efzWHSAhoLJv3P+3K537LlhO9c+sbchRCKEkMwcS5v0FktZGx/7
 zjMFKvdKbeSomVPqZiFQcgmJUw3ww7svTp33nZFFBo/sH3zKXugXoX+UCnoTedoSImz6rcfyFkJ
 cnawjRSDznq8cDEHDiyOx3vJzyhAuw==
X-Proofpoint-GUID: 6i_hmK_5YQUHH75raVcJHZeFzDHdjlFg
X-Proofpoint-ORIG-GUID: 6i_hmK_5YQUHH75raVcJHZeFzDHdjlFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Increase MAX_MEM_PREALLOC_THREAD_COUNT from 16 to 32. This was last
touched in 2017 [1] and, since then, physical machine sizes and VMs
therein have continue to get even bigger, both on average and on the
extremes.

For very large VMs, using 16 threads to preallocate memory can be a
non-trivial bottleneck during VM start-up and migration. Increasing
this limit to 32 threads reduces the time taken for these operations.

Test results from quad socket Intel 8490H (4x 60 cores) show a fairly
linear gain of 50% with the 2x thread count increase.

---------------------------------------------
Idle Guest w/ 2M HugePages   | Start-up time
---------------------------------------------
240 vCPU, 7.5TB (16 threads) | 2m41.955s
---------------------------------------------
240 vCPU, 7.5TB (32 threads) | 1m19.404s
---------------------------------------------

[1] 1e356fc14bea ("mem-prealloc: reduce large guest start-up and migration time.")

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 util/oslib-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 3c14b72665..dc001da66d 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -61,7 +61,7 @@
 #include "qemu/memalign.h"
 #include "qemu/mmap-alloc.h"
 
-#define MAX_MEM_PREALLOC_THREAD_COUNT 16
+#define MAX_MEM_PREALLOC_THREAD_COUNT 32
 
 struct MemsetThread;
 
-- 
2.43.0


