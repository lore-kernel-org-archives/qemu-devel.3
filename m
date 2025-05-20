Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E6CC54E65
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOX9-0003ja-6W; Tue, 20 May 2025 11:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOX7-0003fo-0m
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOX3-0002kn-7y
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:32 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCUIcB006673;
 Tue, 20 May 2025 08:05:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IQLbshIKGGPj2z1Iv3e/LimoSuGnuEKgY1cekfKet
 Wk=; b=tLC10Pd0+ZtgxD4TkYEFbkFDOhhzwL8uIP7DscsdgfZ4FXTpbImXUWGQX
 vr0EjdSjjJsgUvL4dasYLOqgi94uf8DiRfapb7EHmNFm7TBbVvoXBk57550U63NH
 VaeKEoVlKUBjPi/OUWfk9KSXGSkY+dSqm3kYS2d6XiPI9Km0CEfiIgc7YvSU8hLp
 xhuB9UwMdKJcM0ccEF56iCkDpEjQDVgNzvzCjOoPyHnK3Qo6Hpo1pAEhzcQbFuYz
 irR/+ZyNU0VvWwBwKFY1NzuQPsToAJq4yMdR8GjKCf3oQE3LjpO/aQtQ1LWfHQSd
 H2JEASx2lGLU+o3NKgsxWVnkP+Z+Q==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46ppsuehk1-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVFslGAYBrCi0jZ9cSiB5UmOiIBwbCmUibuF0ULNz4JwvXziZWS9P9fdOVTMBb8OtvqLSam7nj/DI5xXgUAgkjBvdvUHpwh7cQiVZsaT+wWnIm2WzOO2frVgKEOk/J0akQ8iaUu6Tn08moMzYDuUR+IH0spVT1U237G/yn0vZWn0qL3KPrssw7rJWmlOg/HLdlGvm9kaOaZ6DEuUlkw8UvkRT60qrR+k/8KQ8KgzhsMtKzEDU3o2bIB/k8p0kU5Z+/5na4GbWDanPF34BFTogzFyDH1PwAet2qW3CVzOGO+fiMiDN6ekOObP1eRMvWeWoMNM761YvIBlSdS7phzhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQLbshIKGGPj2z1Iv3e/LimoSuGnuEKgY1cekfKetWk=;
 b=Ox45uJtbZGJhHHGqY1GYCvygpB177JHV+zfvTVfmnPU0m6EDq38QJ/odefslOva/KHwcBX5YdyHrL3qdwrK9tb5AsZP8BtYTlU/AQeQw5De5nvp1lgleX7UNUQe2MC/2RITo2tFlbgN/GZYnU1UckJrNDsrkIuZuvbWRCym6NKKbP92dsrtKZU9VjSzAp7opRHucYt3P0Aj8Jr5nPys+ja2kKlax66by6SJPnG1tgnhhwRACivRFtQFlKzuhe/jltUoMHWhdbFSn3fsrfGcRXmLq8PCJpnsV/0JcsqbO+TDdthO9BYY0nJXrjLWmk9wsK7sYdtbvIXGEJ9929u8I/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQLbshIKGGPj2z1Iv3e/LimoSuGnuEKgY1cekfKetWk=;
 b=i00p3xWfLs8OXBK6+/CoHFY7Ez4b/659W4ASzs9FUTG685pKAdmBblhUnqTUCZblZLWBRNyFrYFYJRB8pSqkrbp8YCthGcjsrQezXLTHxmfSMQdht2r6nJ1THNh69fZ+sE5Cnjge48T+qjQdUMWtp/FPIJQnNgKhSfBXWAXQDt9z7GnneY+0JEjYmUwzH2xNVNNrNo4JbNtNEIM8/uwQSj8UW19VFwwGy+FjDJ4is16x9wdcwhBQJ6E4nTGAHQ3IEhMF4QS0onYVGOwjfShnRcGwbrHO7RPcCvA/ZfI41/LHtsUna0/1DJ5qQMhQJZFTHe2pqYk5saq1TKTzyqV1AA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8582.namprd02.prod.outlook.com (2603:10b6:510:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:24 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:23 +0000
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
Subject: [PATCH v2 23/29] vfio-user: implement VFIO_USER_DEVICE_RESET
Date: Tue, 20 May 2025 16:04:12 +0100
Message-ID: <20250520150419.2172078-24-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 666107d5-66a1-42de-c809-08dd97afbe90
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pDyXyC2a7X+cLyvjr5bD/5AmOdLJ/xReuovO0BqCmgI5zC48n8Md1iQGRWCu?=
 =?us-ascii?Q?tKPRmsJec1bFnrvIRJrHNGe+VlGJ9cNPU3FbeiNJ3xQgCaWbj+Ld33E5J1oK?=
 =?us-ascii?Q?vHjJoViQCzd86m10sujla96sANNycpLcTGCB+c6b0crdS9n1AUkVrL92aa4r?=
 =?us-ascii?Q?R3epmvy1jlScKzkXuj6G0lxRdyqs4xQdSnnz1RmDsVIe0HJWpryzk9PhmKfD?=
 =?us-ascii?Q?IoBn1xckAfdIdVLBEiLvcEHsMbNiq7/Qrl1PKVIeFyW2pugP7LYcqsH6Vxn7?=
 =?us-ascii?Q?3H6/4RzS5vqo6Kpx6kSXdDBvTaNSOvFLWhL2HcxmRwLAPW9b11Cg0UHB0sdy?=
 =?us-ascii?Q?KuXO5McKVYr2gHZEp8qkOSZlthEBoK4xjjiSX5ULG8i7hFrt7fpoycuv5b6y?=
 =?us-ascii?Q?DXC9HjKhnR4bYlwChbQ6xy6hj/kWTzz3skGvRQmLGEgQ0fUsBx8fWxs/SpNP?=
 =?us-ascii?Q?DeU/lTtBKHBUEVSUuJGmFFj8hfR5eRCd2wBqRZ0KsBSwDWMKb++qRgxp6PyQ?=
 =?us-ascii?Q?cmXGSlk1tTGuh0/vAD15zQ2xTMIqc7irsubcWCq7nazYzPSNHe6PvISfOcID?=
 =?us-ascii?Q?OcP5qdBoki8XCEuZZQ9AuTidapaIIevg6NWBYUodYj6na8mZjSsUzG2GuQgk?=
 =?us-ascii?Q?1WAh+qjDtN87U95zOSGOOdYPrb1m1ci7IYIw1DOUuNdgBNQx+xV014F0cQwt?=
 =?us-ascii?Q?YyeOi8/UDcakIS3n25rQojn2/wqc8U9urF63o5bWUWrveaFjXMBdhq4xf30E?=
 =?us-ascii?Q?R1f41s9VTMgZnspttlYFnm3vDBsVMeDmxxs1i6+QudQyXTibmWa/46eXb/n6?=
 =?us-ascii?Q?MriP/qEjBmBfwCHHt2mHl+MxqfNXUK//aZH4yunmABGXWNBYlf2OTgrC1ZwC?=
 =?us-ascii?Q?pHWXV5Y2gfF0kmuuQDulRhGT1xL8X4CWFalEbgpuhcxmxE/upZtHLuwCQmZD?=
 =?us-ascii?Q?lwdH1JYzebqCwEG3GF9uSDqjZ4wFpcXCo3lKo7aDnepOI0QTaobSowjtLhTs?=
 =?us-ascii?Q?UZbJxz7lf/9mVnDngi3qsMd56y9d/gliCB5phwGa1j4zPsqrKHBd9ANlYZzl?=
 =?us-ascii?Q?baewGVxXd9dmjogkWxpkxAZOC780SwZeCFvIYf8T7QabLg2u8Bp+InlvDWnC?=
 =?us-ascii?Q?nG907LTdCSZPr4h9mFT+j5IZAb7y7lLdZjz4Hns3HZZRR9HM9gVFnU+5P0TE?=
 =?us-ascii?Q?J4Wba0W3RanymB4G7KeOhVY4mtkV0t02SUmCaX0u5pVE4KyXvz2jRA9NYDUD?=
 =?us-ascii?Q?syEWMbGMyjqcxvUcc5sZjM8URb7DCM4/ZG3dTb7sFPOFOr3z15Tgru4XnSax?=
 =?us-ascii?Q?/b0Ye5BE495XAXKz3IU0aH/jQWhsHDjli8Eyx+npQxFslKhFGA4zzi4Iuk7/?=
 =?us-ascii?Q?/RHAIBGbsz5PC3ENGxNV/h6bNmuv8EjStnMmi+2hjNKSAFI0lq18F2OHlDVv?=
 =?us-ascii?Q?N0SI4ZckEqA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?odRtdTIBGQdVRkw4GTh0kVOvlSoRysjTS6tn0Dslz5hZ8hVHDM5+djHP/OQh?=
 =?us-ascii?Q?E+Rfjit2MZF7MXupInm3hNUe3wX19Ls8n7T3/VDJQB1oXXUFxghlp6n+42ks?=
 =?us-ascii?Q?UzT4XUkSeNy2MlOyk8su5bIe5jRY4Km7Lrg0MS87H5/cTFp7mSyiSS6QFITs?=
 =?us-ascii?Q?VEMnb3cst3Akq3hDE0UNlkFoBo7x849b2EttBQ40Ic9M14WN8hg2Y3mx/P4c?=
 =?us-ascii?Q?XM+8c4qe7XA3w4ocHJpS9xbjqUMhrAq2snA0V5ty5q7KORyw7FYOCtHYt1Ly?=
 =?us-ascii?Q?qm0H8h1FanQGQtiyVTmAET2AKaCv3kMaARHBa14HP/yUnb8ecPPz/oShNWLi?=
 =?us-ascii?Q?d0qJj3ilcVizfVr6N5JxnxkUvhjPowLOGyt7aGeeVDa9MM3P0RcXwLjlsmHj?=
 =?us-ascii?Q?UcnoVLBxQEVvEuvjFf6W+JfiycWKSYpoBXK7DyWBVUz7bfK0iIZHnhrBgmxk?=
 =?us-ascii?Q?6x9rpmRV0rjlQH0VfqxzMdYMPt3cn3Nuu1kSrNf3V2238OAnXL9eQwvg1Ful?=
 =?us-ascii?Q?ByRU12YUuIOPgp9Uy4PVQxnGCQVN8v+3QHIP1uYlGmkh+pjEeB8nuQNf0+qB?=
 =?us-ascii?Q?ePjsz0Ce1gi8LmnrMQrkfxBeDlF2tyedkMhC70/rYPokqkbCsEUncEgWlPdQ?=
 =?us-ascii?Q?c6RDeY2jxGw9t34SSbR9KJm9Ab2k3bc2D6iN4QPzxhBAa3xf/HQzAWVebO/6?=
 =?us-ascii?Q?9LHPFd0aF9pPYr8ULUQBoTTzXPokpDou+1qS6zo8VFVsXM7PytX14BnCwMBQ?=
 =?us-ascii?Q?rl/kmGuHd7ZuMydbbFbIL59GToZHSEDW/vxJ2F9idkYdGdZcEwdLoLvTvFHh?=
 =?us-ascii?Q?fxhI7Oqz0UCI+wKodiV5eUrKZyxCBtP/PHpWRGYvqOO2X6z9BMzXn0de5WFY?=
 =?us-ascii?Q?ZKxpw+49721+h6a+o2uZ6qtoejMikiCUkobtPvdEnEfpwDapaVDgZAdnu6ne?=
 =?us-ascii?Q?Gi9WYrVEMRYlmthhy+wF/b+8E4SbpWLlhqZdQ11TsTqHt1VMqJROUVva+0zy?=
 =?us-ascii?Q?UEvY31vtnhd7z0S9l4M8UKKZzlMGio7s2E/E/mmDFbDxwfHBacvbzlJSHUVk?=
 =?us-ascii?Q?IGR5n2OF/TaiKBAHQqlXEiftgxNIS/pXMoZ/BjYRVLk4Mof2qfJ2I5XeJjF2?=
 =?us-ascii?Q?tWSL41TXEYPCZ/9AZf6pKjT3rtDbmhymgiYnzJTTCNldp7ZngsAo8Zoxvz5d?=
 =?us-ascii?Q?ijetFSvvZxHVWoSl4jd2L6Lq/Y49pWFVBcXXYU52YTK7dc2pLrEGQ+lGTRIy?=
 =?us-ascii?Q?er8Hnn2QaELDx3yheIjgUkHThR/bZPvWHtHmFum1GTyWVuZ5xbHdM6EJAxeT?=
 =?us-ascii?Q?WxiFWEyfQ7prCad7zC+yrSI/7zk8SUOMnsm9OUUn4DK9Sno5WiGkifRSsRKN?=
 =?us-ascii?Q?C6SwwQrspL0QSXSx1YG8UJ/qNPag2ywYERYuWIIer+c1lHdam4f0LCVkL2+Q?=
 =?us-ascii?Q?en5EKY4LRUYlVX+C+PoSxeGUjoZpKFn0jEGZTpZFDfey3ek8ghlUw4gFAXsf?=
 =?us-ascii?Q?61ikHoLVoAwG2uOJ8sp1Wxe7nkphUuyJJccWyEkKsco4gMz4WITIB2NQoKhe?=
 =?us-ascii?Q?3eQYBVciMijmfIG+NtbNZ9svtrZteIPHQfklqsiL?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666107d5-66a1-42de-c809-08dd97afbe90
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:23.0456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfwWhEVDZYCDBrWvEz8vrpf2JvFjZ/phY9pHvy2OfgCGTisvXwsJ7EzRuZRVuR/SMMDbN+hFu0JXkDTieMRt8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8582
X-Proofpoint-ORIG-GUID: 1qoKds8WDyA_8QExJheVVetyO0pjxsKA
X-Authority-Analysis: v=2.4 cv=Y9v4sgeN c=1 sm=1 tr=0 ts=682c9a36 cx=c_pps
 a=TJva2t+EO/r6NhP7QVz7tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=70NfNXkHNs9el5T2m-kA:9
X-Proofpoint-GUID: 1qoKds8WDyA_8QExJheVVetyO0pjxsKA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX5MJ5+dDZk25J
 6qgzfCQgC20oRa+/6Elsx0M45BYtjccWtr+7t64mCXAsuWVch7qSp2Iu7wOxf0IdIJeZIk4Dycz
 FA5acTdgee/NjGrGrBjl58cQAYAqDi2o3vTmRxe02T3Q+edkJp5t/4h6qTSq+dEanPTC6hyAegW
 ZLrw1i7/o1ZKP6PrkavUMv849gl7ahxukearhiqXKxjl57tl8gfFLCXcsMeqJpvSlbXReeR46py
 olNF8UHg2BNbTq+6JVX/uhSK2GDv/KD2qkoBF2Kr73q1kau6GORXf0iqTmbL8j2pLmRk/1lUHhW
 QUgpd+7BIa49J+ibjLbeFNGIh67yz9oVVnpw36wsOkqzkDORCUn7KCQ520Ygy5k5W1w8WLZIS3C
 VQtB9O4tneq5e1fP8aTNAmQ4GXBp6z3+etG8eRrQFVKjTrZ+0DgrSE/ej24QGgf60x02Mvlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Hook this call up to the legacy reset handler for vfio-user-pci.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h |  2 ++
 hw/vfio-user/device.c | 12 ++++++++++++
 hw/vfio-user/pci.c    | 15 +++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index a5a2aa9ba6..25cd4c8a00 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -20,6 +20,8 @@
 int vfio_user_get_device_info(VFIOUserProxy *proxy,
                               struct vfio_device_info *info);
 
+void vfio_user_device_reset(VFIOUserProxy *proxy);
+
 extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
 
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 45b91d22f0..b37f7329a1 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -49,6 +49,18 @@ int vfio_user_get_device_info(VFIOUserProxy *proxy,
     return 0;
 }
 
+void vfio_user_device_reset(VFIOUserProxy *proxy)
+{
+    VFIOUserHdr msg;
+
+    vfio_user_request_msg(&msg, VFIO_USER_DEVICE_RESET, sizeof(msg), 0);
+
+    vfio_user_send_wait(proxy, &msg, NULL, 0);
+    if (msg.flags & VFIO_USER_ERROR) {
+        error_printf("reset reply error %d\n", msg.error_reply);
+    }
+}
+
 static int vfio_user_get_region_info(VFIOUserProxy *proxy,
                                      struct vfio_region_info *info,
                                      VFIOUserFDs *fds)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 5904e7ebc5..2c3edb7378 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -251,6 +251,20 @@ static void vfio_user_instance_finalize(Object *obj)
     }
 }
 
+static void vfio_user_pci_reset(DeviceState *dev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    vfio_pci_pre_reset(vdev);
+
+    if (vbasedev->reset_works) {
+        vfio_user_device_reset(vbasedev->proxy);
+    }
+
+    vfio_pci_post_reset(vdev);
+}
+
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
                        vendor_id, PCI_ANY_ID),
@@ -269,6 +283,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
+    device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_dev_properties);
     dc->desc = "VFIO over socket PCI device assignment";
     pdc->realize = vfio_user_pci_realize;
-- 
2.43.0


