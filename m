Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1F3C3ABAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIS-0007sU-BH; Wed, 30 Apr 2025 15:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIK-0007oG-RC; Wed, 30 Apr 2025 15:40:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIH-0006BX-Vy; Wed, 30 Apr 2025 15:40:35 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UI1NNI022427;
 Wed, 30 Apr 2025 12:40:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=v/Xc9NYc5YfwDjheWnOv06hGZg8UB7ae+Ab+UjQs4
 6A=; b=GeMC+Q/D7CWOyTug3wBpT4xSPqcgkvP2QsYTmF4FvP/+LrchC3YevEnQS
 HOj3+WGfIO+SriBlBnzTsaEFjLaUhriexUBiEZ8js7gC/wD1SyeoHZE5Dnq95K86
 MafZ8E96LsLAE6W1IOgIMfjxtzcHA7tUYspg7reIJvl+E2w1JnHdMAuIgMg/66ND
 8C1M1fi0cfzKoTdzJjykCFBA+H8/f9n/pfdpHDGrQ7wlsfnqrRpeYHjX7IOAoo4b
 kYbV1fTH4C48/4ODoBqDRprEKPVq/K5CyD9MMOOamcSTWYGPGRe8ZK970MFqtLWS
 P/Nc78skkaZrCS0RwMAWsUIpyIkbA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468ud8hueu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCawU7CPI9QjwbCOnbxtcKEBXjXhO9eN2uN4woVYLmuNfTJRRzseASWjTuddfmdkfdXgmGPVME85bP3aVMMG+/jrWfzLdDKGp3IF0v7cjG7xqMBsLA/01hUrzHTjmv8d40ZX1FVWSKiBA5Jqp3YriPzOeRsNgTXhw8UlXMPCHNUurWTQkc2GyuNl4X1obobcSJH35QGB+GPI5MHWgfC3kdE177xrFflFkKUlz1JiQPIqF0okQXNPl07usfdkxwrIlDuT61CWVjfSbX0RCvRbSufCv77/4v//nNLY/m8UVsxmPa3anNudJ4JaC4JTGWhwrL4Zmwh8TSYsuALcI2xQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/Xc9NYc5YfwDjheWnOv06hGZg8UB7ae+Ab+UjQs46A=;
 b=MV57IehHFJNucB0SkbaCK77vRCrtdW7wCd+MDEt3kApJhCwos+Mqjf6CD701Xq8KwB5pUigpU4QfLV7saBPy+zfbB1mxCtkDN9pfzz4lofTKGTT8Yt/XX8fP75LPOLhN2vq+6pkCTCTTL5DyA4EwuiGIOQBB2pn7F6Ed/nkRNHrW6ZoZsYuMBFVvJECvrUweh0tb4bLK+uuRZ4df9JLszLJrnO4taJSG/waC6KMPU4baI8B5rzQNo5im1lTzxI5/KySasQ7dCLGC12xQUn6sVEpcIVs5xXeY5Csc0yAuhGcMyDCwg0JXXvAGRw/U+Lz225OG5jPgGaGITuKp8us5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/Xc9NYc5YfwDjheWnOv06hGZg8UB7ae+Ab+UjQs46A=;
 b=TxcIaty0yYOdlYgBy6mdyRlvCejZZTT3USgqfv3SvDPKsTBXOoLA4zU7a0WoCC0nA7EZUNr/cAT4MbuxrfJd+xQlAL1d7aX4Hz8D7KLJLIO4jgPOVw5107v7FVAFKBR8aV7NM52mLt5ZfTYeduEPhgkgZH7l/FDCBpleXziEw5dvcV/89lwW4QXNR6gsGYc1f666NWIXPwnqQHOUn9HcUI19lIZHZP3L8kFz0HxQ/FrTOumRrLy22Cc++UPYRIn5DYXbiKPmKOUhWtGOFCkogmf00OUJW/6juvin15GfLCMLNSvGxCwfNTIU4Z2Aw3loyJb9eX6nGQFCw9uUECTc/g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:26 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:26 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 05/15] vfio: consistently handle return value for helpers
Date: Wed, 30 Apr 2025 20:39:53 +0100
Message-ID: <20250430194003.2793823-6-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 973a80af-c87d-4731-971d-08dd881edab7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oti1Sm2/LxHfOMb2LpXntCJAfEi6T/Bxb0TbFX5bGaSOjVX1NeFvDemn4Wbt?=
 =?us-ascii?Q?qSUUaMqjawC/4U93acRNpqhfj/3eBShqDQf9y2cawY4ukU1a1T3yi8knnN3z?=
 =?us-ascii?Q?CRQyJ2oxeBu3vCgW9caeHCxKgGcJnHXpxqvx7BQ3L+sNfCphDMyQjRP3YVbB?=
 =?us-ascii?Q?bm4yhyK3kiwJcc0et1NmlG61cbjYgs9LyUudMXHwJpcKAhSyWE1NxLAbPt17?=
 =?us-ascii?Q?qF0kWP50DyZDWPGbRooq+cqt0t7Vca86cGbLtGEDvZf9v6CY5q7qGp/UHTtH?=
 =?us-ascii?Q?M9kRL7THUXwZn2uunLBwsNrMd4C3eMQ+RJmGFKmzno3iNfCD97FMIrh5qVgD?=
 =?us-ascii?Q?74HArrqdtQov8jlir/iN5MSvSmH4Efi3tZQQMM2rp1VAaiKtXC2m3r0QjRR6?=
 =?us-ascii?Q?X87Z4ftkc/ItSNBQ0fKc1fLBb3TT2/T6H6yQRGmzFtZe2uPVF1VyLTb2Zhen?=
 =?us-ascii?Q?jUAVBRzkfLiyGEis+J2sH/i7/Pe+JU4hqLGYpAgLPeYxFSbst4s2PWc7w1wT?=
 =?us-ascii?Q?n82zJAhGt54EsFyuAII0HfC/zJFQRamMADFGoVCydl1o39i23ON0g1RaneNm?=
 =?us-ascii?Q?J/V2yCR63yEXoX2CJsT8XhSxG8ooS4/eMEGvsID46E9ZPvd5HtxhddjyONpj?=
 =?us-ascii?Q?9CRJ1duMOI9rjXaK4EHlY8PYWQgOAT8rvXCZ8rj4DRecxDWj/3SK1UptCi8r?=
 =?us-ascii?Q?tx6fHf/132V3R5QBdaAOlD/N0Z78Acc9a4xL6rjprgeyZoZB/zgZUBnkNUC8?=
 =?us-ascii?Q?1ATl0Bz8MWmrJPU0HrzlMk8FLa+hqn6Z/L0+NmjSju/NwlVNEapIo6yDTfHp?=
 =?us-ascii?Q?gO6TZ2FpFg95UqrziaAx7r0SVC5zQpSQHQCRrd0LZn1tduWpeBZJ0EH2Gk7/?=
 =?us-ascii?Q?n+pCBgfqmMTYfmIuknWOba4w/siecMzs1XvyDvZHfKPuhj5zvPPCsoQUZDPT?=
 =?us-ascii?Q?/6PhrG/aFD38GUYv3Y2TI+FggaiMqR5usurnaT/Dxg+7I8StAMAbJZyWQQSS?=
 =?us-ascii?Q?BC0mvBXac6f0vboPnPF/cMJnCme5dkni0ZNTbLAnk/V0x9N716f3pMpkLmmH?=
 =?us-ascii?Q?SSwIYKiuMk4zhTKU1UOQ+PqydwRooX8+jYA99fSywJfCf0lM3fKGfHnvq0fC?=
 =?us-ascii?Q?Or/6L24uuFFaapLbcj1Frf6RpT9mSXyIZEWP7G614pBUz4EBk8T4ev7lfsY7?=
 =?us-ascii?Q?toTOuNLCVUIs5KrBoV0ATDbNwx3MkpdsmLKdG6un2RFBCXeApMkOnIUmjlYb?=
 =?us-ascii?Q?BS2bHSwpLeTsbs6o9ZEg8WGdv5MXjw2byV084bsyEduuSgROhtSuD4qfPsBy?=
 =?us-ascii?Q?0ImvahRaxWw/uqZUUqlmNL8BDc7iVTTn4FcpRpHXSvn2xZJQHq1H69tX9no2?=
 =?us-ascii?Q?h24I1AzGYXTWa/iGrcupiN1Jwszvs7V3sIRNclUzQ1342Nyh5EVRwCBtO3FM?=
 =?us-ascii?Q?SQhMXPeOjfM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q0HK7rt0IUwFy/EBzmi+RltGcd+ORJ2w56XeBa2HYYqKYm3QDuuvJ6k+AMis?=
 =?us-ascii?Q?UHQbP2TeDC6yQJYyi2Bp1UpHPUrX00G3czAPO7bZX3/ctjXEItJJ2RmKY/H9?=
 =?us-ascii?Q?USLbd6/0b9Vr+YDTL+1rQ26LrB4SITrUxLKT7oyNlHBkH+OreGQ+Pb82Q0ad?=
 =?us-ascii?Q?GBdi+H1RaxLTdKM/OwxuC+jpvpD7BQ7jB/RjGlUu+uk2ESjy84GCJC673upi?=
 =?us-ascii?Q?A8MNMY0bMGsYOVAyc9GAVVeMIJV89rk7BcDk7JbK2woNNsu8hS/Q5Jc63S65?=
 =?us-ascii?Q?fFXxjGY1f0LhxRhPwfL169JstytCiBJeTBvnzboOlVjMSSvEDmH8no4Fzcaw?=
 =?us-ascii?Q?L+XYYL4daGcTNf2x9MzINQYtIoAB6nmzctftRJXAqNWPaCOv+fdmk6XbQ4zA?=
 =?us-ascii?Q?M5awwGVqNf5si0J+OKcS+nqZyx8otAr9q7wZXdj98h0vIGumj+UMpv8gp+ck?=
 =?us-ascii?Q?SmTECHFUlP/vDiwL1zZDHWBheu431gFIHPUodIjHf4gwzMrPHWGxPQwUanOr?=
 =?us-ascii?Q?Ns+TinbR5fGeNDwN5PDjFp8HkMxAKYuX+qNuZxqTO62a1GSotbuatOVhiRPT?=
 =?us-ascii?Q?Jp1bMnb1PH5OJUVPkKD1MVPy8W1HmPcfzv/ubncAGLJ+65z62p2oVdtsrnWK?=
 =?us-ascii?Q?FaTsrF5F8xzLXzHJtkGMZMaJ8oBlMgjWna9yoMIomo8FdZSFEAeN+Fv/V/76?=
 =?us-ascii?Q?0N2rOQp13P0ovabXPAVq3l2LYzUaLYJbSCuc3fQY6mR/0XjPUWRK3Gwww0QE?=
 =?us-ascii?Q?GXzcL55J7RZnL6wZGsUy21Yas9uN7IfjB4/g5HAO8y/PNseILIKGwvAgUiZt?=
 =?us-ascii?Q?104FmqbMY4JKLMyAqDcarIdlE+kJYJO9ZVn/4p/jFYeZkevyk4a+agCV+4zQ?=
 =?us-ascii?Q?47cIYavRNLeQssD4cZzaXqn/cNzCYQYotSJGovxxOc4PK5YyBc53oamHbPJZ?=
 =?us-ascii?Q?fdbDgBngfbCXp79D0ed8JQC2KnzEtNnMvZ9vM0bAUpuSZ68GiOUGMhZ2S3OF?=
 =?us-ascii?Q?ACDk5FOBcUmeDDyCukhKCnWlTw3MXl4TM6nsFsjy1mhqgkQIGNbxHevsxk5J?=
 =?us-ascii?Q?faB9YkVNpaS3iiLJBCuJacn2tEB+3zzgF5aCsfwbfGZFkp3IIzmsBbT3C1+d?=
 =?us-ascii?Q?Ar5GCB3mkeLXiCmDn4Pfw/mQPwaOCRdgStwZUx/PrvOC0OlS9G6FwX/zg6Gn?=
 =?us-ascii?Q?DBb2IDwH1PKUcfDqtU285QqzPT6vgoqMY1Fcvi+0xv/Mrbv1JV1OBduf7/Sz?=
 =?us-ascii?Q?Xxqt3lzufiuK8GZ6vVee3TNQcdfRsLFVLAZfkx4jOHkwga0dbGL0AcPODKCD?=
 =?us-ascii?Q?NP3Mmv7jtrDFXGk5imJgqFUhPsqdZ2VPR+Ar2gOnTurLYu1DbgaQ6yfHMZJ4?=
 =?us-ascii?Q?bIELFUol8vJ6ybsZc39AuuDsXW3w+qeyBDbkb5TUkSRparHD4WY0vNlKjDkH?=
 =?us-ascii?Q?AhVzb7nnyGUYga2h43ALXvGf8oxjjEqoF52KC/nnAweW2RLS01X5/S7HPUQW?=
 =?us-ascii?Q?l7Ic+CHnjSn8DIQf6x/EvJh3uVSl1Xp5e2ocw6Xr3HMNIdKoxnPVZrGreBjq?=
 =?us-ascii?Q?qOvTNbeD5ggTVLVmgw69kYonNm5MLFepWqyQ+q9l?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973a80af-c87d-4731-971d-08dd881edab7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:25.8010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFI3X8/t7EZtW9fxdmFx/OLzylHMzy+8ItRfuhdtDdavU0NlhFqzNR6ljB4WJ4zhJvqJPQwYFz6G1TIWSSNj2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Proofpoint-GUID: WrIDY82h6B-NmebkAzlBkHzh2xGdaIFA
X-Authority-Analysis: v=2.4 cv=IugecK/g c=1 sm=1 tr=0 ts=68127cad cx=c_pps
 a=X0MiYUndXFlT04tAhnTHEA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=khE_JiE8E1OrqPP4vgkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfX3IFo9C5z9On4
 0No+gt/eZV4oO6RyF7chEegMfLXR7kcqalK6ewFaw1vMzzpi65HudwEQJT/Ro3rgsX6pvG86DSG
 Up5uBx2Ca+tZVWb6yhllamCKJBXdtxMub+c+zq608oHj/4eGRZTMrYT3LkHjFwigslRBU8h7RjL
 2/0wgVQ5e4tO/uGh2G6r+GIp6KLmB60wvsHa9UvPAyFHsDuygiN4Uo01F8Eu3jGXw5bwwQjwcw6
 l1vLgHvQmki6blx9YEvlGm8dPpWEWxV3DcB1GbQWsWM0FrfmKZxA/ixt9FHVqmt+pkBSDZwkO3E
 WakhFwOgF6SgoAURRj/ewEANvRE3QkZ4278CcjjcANGmMVWt5TnW8CZeYTI21ccEbk5zhkVjAcU
 Oz3AvVLLkvrfUKz7vAhyA0lK0ajHnnzTtoh4fk+aWdFUv5OfmMPn+mKqrkhAnqgz99GOzN9e
X-Proofpoint-ORIG-GUID: WrIDY82h6B-NmebkAzlBkHzh2xGdaIFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Various bits of code that call vfio device APIs should consistently use
the "return -errno" approach for passing errors back, rather than
presuming errno is (still) set correctly.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 407cf43387..768c48d7ad 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -398,7 +398,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
 
-    return ret;
+    return ret < 0 ? -errno : ret;
 }
 
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
@@ -459,7 +459,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 
     g_free(irq_set);
 
-    return ret;
+    return ret < 0 ? -errno : ret;
 }
 
 static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
@@ -581,7 +581,8 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
             ret = vfio_enable_vectors(vdev, true);
             if (ret) {
-                error_report("vfio: failed to enable vectors, %d", ret);
+                error_report("vfio: failed to enable vectors, %s",
+                             strerror(-ret));
             }
         } else {
             Error *err = NULL;
@@ -695,7 +696,8 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
     if (vdev->nr_vectors) {
         ret = vfio_enable_vectors(vdev, true);
         if (ret) {
-            error_report("vfio: failed to enable vectors, %d", ret);
+            error_report("vfio: failed to enable vectors, %s",
+                         strerror(-ret));
         }
     } else {
         /*
@@ -712,7 +714,8 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
          */
         ret = vfio_enable_msix_no_vec(vdev);
         if (ret) {
-            error_report("vfio: failed to enable MSI-X, %d", ret);
+            error_report("vfio: failed to enable MSI-X, %s",
+                         strerror(-ret));
         }
     }
 
@@ -765,7 +768,8 @@ retry:
     ret = vfio_enable_vectors(vdev, false);
     if (ret) {
         if (ret < 0) {
-            error_report("vfio: Error: Failed to setup MSI fds: %m");
+            error_report("vfio: Error: Failed to setup MSI fds: %s",
+                         strerror(-ret));
         } else {
             error_report("vfio: Error: Failed to enable %d "
                          "MSI vectors, retry with %d", vdev->nr_vectors, ret);
@@ -882,17 +886,21 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
     g_autofree struct vfio_region_info *reg_info = NULL;
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
+    int ret;
+
+    ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_ROM_REGION_INDEX,
+                                      &reg_info);
 
-    if (vfio_device_get_region_info(&vdev->vbasedev,
-                                    VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
-        error_report("vfio: Error getting ROM info: %m");
+    if (ret != 0) {
+        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
         return;
     }
 
-    trace_vfio_pci_load_rom(vdev->vbasedev.name, (unsigned long)reg_info->size,
+    trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
                             (unsigned long)reg_info->offset,
                             (unsigned long)reg_info->flags);
 
@@ -901,8 +909,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 
     if (!vdev->rom_size) {
         vdev->rom_read_failed = true;
-        error_report("vfio-pci: Cannot read device rom at "
-                    "%s", vdev->vbasedev.name);
+        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
         error_printf("Device option ROM contents are probably invalid "
                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
                     "or load from file with romfile=\n");
@@ -913,7 +920,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     memset(vdev->rom, 0xff, size);
 
     while (size) {
-        bytes = pread(vdev->vbasedev.fd, vdev->rom + off,
+        bytes = pread(vbasedev->fd, vdev->rom + off,
                       size, vdev->rom_offset + off);
         if (bytes == 0) {
             break;
-- 
2.43.0


