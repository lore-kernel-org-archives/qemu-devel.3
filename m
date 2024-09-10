Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE13ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snws2-0000Xj-2c; Tue, 10 Sep 2024 05:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwrX-00082T-Io
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snwrS-0004J2-Tl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:08:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8tX3p008899
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 corp-2023-11-20; bh=liLEVMlOxr9MKo9jga2VkXBGye4xwDKxHC6nl8W5hQ0=; b=
 dCzVGeWOOerQi+3d9Xljw+CMcd0A2yD+cBrA5emaqmgQ49bd6v6dLgn12hi7AHnU
 6+McOcYHUwbN8csKI/W1xuDiJm6hc7wJUEXzFVT89NnSdVOpmLmOjg+lslRjHPUp
 R2z+GQz5WqNgT36TAvtmtJDycGaP8I866uo89wFINFxOxuTalPsAwZ0jrGG6r6ZH
 cnHwSjqiOg9d+mm574aqFZ4HsofYl49t71HWe/aH25Yr53UWEDfkGhNqhqX+Vako
 /Y7T/uLVTYV2DPSb87Y1uMvIY5gdXOR4W4+pDzLDgQNCPBFkGmpf9/7ZJkib1tvj
 +Gxqg5kce5kYlty9aCdwqA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9n07s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A8ao8Q005070
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9898f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:08:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkYeC7kzX6T824Ydx/cBoQWe+xy6T/SIgzrmxxji64fdoaJLA78HE50i3XFzoZn6YIGZeD/UDXw5nSNY6df2K/8gFh+dXxlOeuX6WRDRICbR2gC3hJA2jNVOADH0D/iTHaoLu+YKs2gMfliu7QmNlyVB8mN5bdXaDDp9+x63P6BUAJoBTeR3M2cwTuB54zjCWtOqFmxvNzrYxTX88iDzYgaZNBZhS+VEKZ1yAtRAT/Duuk22duJOu8K1WRi9tluydq1bEKpkO9PcYR7wTLdHWGMoVKD5s4jzlV2g7KbxB9UNEg3NKppc1BeI/lxJRK4FVoueSJUcxXEWVxj3AqfLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liLEVMlOxr9MKo9jga2VkXBGye4xwDKxHC6nl8W5hQ0=;
 b=eB+VvMTODSEIbC2OSj8St9lVrrMhX239nXCRK7qTK7Zq1Zgq4AAVsh8+o6OA4d6KBMD4aTHV/qfVwVlJGPsUJK57l0MSgZ/+h/uXiUUM4Qr7Xoo+j+uuPI7RJnSrjyiC3gkoFpz49RuCBqmeUPSPqwldah6zBHgWIBG6IZLSEX0FLKytz33phWjyVlVoVLBlc5VXo6oTApBXxakvZE7doNghmmqbajeg68tXoaDfa0ZqpBW2XRkbahMjhCr15q6w8i1eN8pBrd2qxcC1396czrJNlcHm6f5UcXL3AzrS/vqWHPNh+jKjszoOD8w0dllqOc5WZZZ15YyEIW+MOHgP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liLEVMlOxr9MKo9jga2VkXBGye4xwDKxHC6nl8W5hQ0=;
 b=N12FsnwJi0G8G0vqj67W2bloEVXZuXRwCVxGpb0B1KTBIHsYXwTnABSQ4l9k6gR0+S83CjI2MN19JI/s1hU77/sJZcIFUhDa1zajE+6CvBC2erNLGU/lM1ILNFcWQ35EJCn6UaQEzth643eY0KRhLOyLqaWyoHCwlK+b9bRC57o=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 09:07:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 09:07:59 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [RFC 4/6] system: Introducing hugetlbfs largepage RAS feature
Date: Tue, 10 Sep 2024 09:07:45 +0000
Message-ID: <20240910090747.2741475-5-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910090747.2741475-1-william.roche@oracle.com>
References: <20240910090747.2741475-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 5413426b-1433-4693-3529-08dcd17810e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sjv7ZSEn/PK9i3s08k/qiIw0d1M2nEIoJ9Ynl3vjaD8LZBW0etIboOcwVdPS?=
 =?us-ascii?Q?jSMPgapmP8Oe80nLJ61/azuu9iteOW3KCDIXO8TMBxwu80rVzpXASCAehbpa?=
 =?us-ascii?Q?O1Na85Vc14fsnrH8TRYE0XiKUiILRtb7IJMmPIi7Y9/3lrYJayKWMzCUOtAs?=
 =?us-ascii?Q?3gOT6mZuf4j2mgB6lM+fGX/l0VuQ13q6lYFct786pwjXZF/X37gD95Drx5F9?=
 =?us-ascii?Q?5K0rPvZxWRZEle0uvmX9kbtRTWFBPn3hkwECiZxvGROlAHdCRFK0L0knlciW?=
 =?us-ascii?Q?Osam5cog7ECwSWId+pSJOvp/l0tJXyfLLhgnP8Qw53p1jLajAgNtGcsIJcKV?=
 =?us-ascii?Q?SfUGe96BZ6bzQl6nj1t7nvaEZNh0m2gj6bLbRUvsF+i9mQ0ywocTCSZl289d?=
 =?us-ascii?Q?YfmT/1FHlXEh7c5/euuUyjEJDaOMGWp54unWDVd16tbLSnj8ymTvHkf8n/94?=
 =?us-ascii?Q?QS8pXok3S95MqxtFNXfKd6lQJ9KQ8siiWQYO0PbdtNIeW9LpZ2IBll+rUHFE?=
 =?us-ascii?Q?wxbZ2fWOjsNoKBJkII3LWpUBiWg+NnrzCYA/Pfl+e47RIVuySx3QEUIpZoiY?=
 =?us-ascii?Q?4+e9YEyAelvkxMxSEEslSfNAdCxKI5Qi309BLLjQhcRV2bmYCu7avlKy2Ccj?=
 =?us-ascii?Q?Jgt4gvw4K9MbGU0I+jvxFxxKKZ0R3H2GcHd85uH/+1aYG33Za0yoN8kOHfL2?=
 =?us-ascii?Q?TwM0uB4HlRjUBrucdTl6kIyZ94a9gTMX8xD2hXyTCFm6Icg/rNkvP/FYsvIx?=
 =?us-ascii?Q?pYARWz07n5s+U0HQrnxQttmb6e9KNgvk2ySW6JuCVTH2foajKptIqXtykfgm?=
 =?us-ascii?Q?WpqsCi+GD/b5eHS6y/MxpXLUfkV68Kp0ginKfQ4nZvOg/KMF1jx1cnwotwoK?=
 =?us-ascii?Q?z6MnFq0zOl05FitA5Vu1Ga40SZiwc7i41t+ZynFo9GSE26HksdxtOTbsGcP1?=
 =?us-ascii?Q?Vt8zvK76ALolkWJVN/2N0FlHa2rdXcdKlAOLIRkUM/w24LCInEjZQCsKMNuz?=
 =?us-ascii?Q?zq2o4H5LcYpPL5CGWVa5y3sMrWJ/9f61lEisPJC/InhxMFqClmHA+1c9u995?=
 =?us-ascii?Q?ghlxaYi3NLcfuTPaFcnbiLLB55O0qX6g6MldC0vc321hytNt2Wq63XzdORni?=
 =?us-ascii?Q?1BFWzeUtO0nBtoCgUs/yBJO+/4RMJxvX0YSQvaUVriIK4pN+kE355EfY60Au?=
 =?us-ascii?Q?tyEB8QkaY5aR9cAMZ9jzslZY/SNbYPGNqzB13B92FdJUaYwKmq0oljKlxPGe?=
 =?us-ascii?Q?AF60tpyBtpBHDmhyh1mW+MZWEjHcR6NmuEyNnoj5nlpqDfrAS7dHPMtj/wVV?=
 =?us-ascii?Q?gcMk1r5iEW8GvRYvRbL5V7dM3Zb5CXph/2qmtbv058VEIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHFk7eC56sHQU3MhEsV8HTFICi2QPVDJPppZjqiSEI+SkRjxFWB8TfNPU4Zk?=
 =?us-ascii?Q?KcneXkDTZGSz6veXuwIIEQTfHRw/LP8V0z2RtGeCNCYyV8miWDkzLKlm8uzV?=
 =?us-ascii?Q?kIXzVhfiMitBVPMNIKQAWD6ylDvP+cP+ZcJOPzUISs4fDkfyjFVm14ffDPGh?=
 =?us-ascii?Q?wRpIRj3BpLXKpUM/Bh9O+dh1MGDTEIFPOjHW0oq7ZibWtNcEsGooBhMixA5u?=
 =?us-ascii?Q?C+5FKTrjqwD16drHYJlRzvW6qO5dtUjgBqzDWzLvC2ZcdpsoxMgI2+1DfpMc?=
 =?us-ascii?Q?f/6m3TMNBVh02+KDMToY09XabbFJAcZnRsOgA09TWMMf6tXu98hfT3DzfE89?=
 =?us-ascii?Q?d1kARA4kGGFYN+IZ25fAqOmoweqHTSvHEpV/TutXVpDdg9Swjevq8//M4jgf?=
 =?us-ascii?Q?EiKzv5VV7WDkEfzdlyUqZYlZps/V/VriHH90IikXi9FicGCMWI7PYZNlmaW7?=
 =?us-ascii?Q?WqaTUlh5i6QZrysxk08jt9qUBinjjjNUAZJdE/fTpeEXwllhendvs/5ue6Vi?=
 =?us-ascii?Q?mibbdMe46+CO9KZ0p4uGaqAV1FFQPnHOXiFjDwTwNq8WrUUw72iK0WKyCM1e?=
 =?us-ascii?Q?02snOEcCb3Cbg5mISXvA+V6HzpfFsBj1dgDSPYYV6NVXJMAcIS8ayU68CO9c?=
 =?us-ascii?Q?1RueYZ3VRnaKJdhWi8GZZyqrFTbfbEdL3Ryhxq/z2MgzfJU2kKtcgRPojhaI?=
 =?us-ascii?Q?95MACgcmnV1a8LcVGpNUAQEtsfa7kBIKDem9W3n3ISQnVwYMlbEDVn7divl7?=
 =?us-ascii?Q?s6Iijd5bkcpkBh+1HLrdjHTytu+fdWjyXZx4xfInNY0kkEhgc6Ztfsgx3GZU?=
 =?us-ascii?Q?eRkmip3PG7GpMMI8TMd7uGFEdZAoSSr5AOAtIct1qW8vlBb658vhW+ESHyRM?=
 =?us-ascii?Q?wGSJuCslf3hXXZrR/xjWaVoh/egruGpmZMTMtWU9U4lLI01QewzyEz27/B3Z?=
 =?us-ascii?Q?aQfszdDZrDFX5rEw9PxQy/wwe3HdgRWhjFPwt/tCZZaNIBDklOQbUpYaI9fH?=
 =?us-ascii?Q?T7EcYo6sgcij/5cu2EHqySL0oUcQbEehKLcoUAuNBgYeniQbozCliivivcQ8?=
 =?us-ascii?Q?BpRijR1XWMEsM1RxLafQpgRahFgTK8zuAge38LFEI0IflomVFvevBfTnZW3y?=
 =?us-ascii?Q?WMD9D0Hx/M+zIOqaNxd7Qdy49wTuXkzDpOWDmDrptLAgS0gr2qxKeT10/uYa?=
 =?us-ascii?Q?K67/Bt+4/k1TS61OHlVXvEqyxxy/gu/HKF95t6MiUzXVfAqM0+w9Gb5VW9za?=
 =?us-ascii?Q?y8fxhI7RxpuMM/srBEQdSDPXSvsvZtdcTmv16Z+hY2IW1YAxsRNn6bapHjiJ?=
 =?us-ascii?Q?9sLaOSrDhlDZGH035yVtK/05bxaKiLdll5IjetYnhTTbjYGIvUF2lfMOYlYJ?=
 =?us-ascii?Q?8czcyqG0NcaeaI5Xu+Kp4RKAghpCWlpyl6R9c951KOAywHTlj137I33HhIyd?=
 =?us-ascii?Q?Zpt3EGt4hkURJ0ADCzSTD6aQ/FQ1mBok+tk58uolEglyL8rXsp5iIew50LZM?=
 =?us-ascii?Q?rZRHcNr7TEseAsFJH4S2NTN1mg6UOZZUr4Cr6ClZdklI+e1uJHAPznsm5P6N?=
 =?us-ascii?Q?EIzI4JQcJgcT5voHovdygApIB9Dsh4C9/DdIU6kjH53UfayV7EH7Gx/pXq23?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a6EnIIEQdC52tj5b5h95jcqafrzhusY8twKge3tKO0id+olJNi/WaCf5QsikmxF1PFvbpvmQXykUxpda/JQoQRetxn3tYAjjQVVCKCi/Nj0tio2WoOXCYhI5RZGTNUIajRxP0RUvbQait4M8lFezu610v/aZUrXJl5tqblEjCXhv6X3+Rbdzpr0C53Ovf05cCkwdFdnd0zjruhK4XJAVR1xId0U3+uv5bgRRzC8oKc5C/RmvtrPlP6Hxrc+eSUSFJDJHjIDzukocbAiYl0qtMquxfd7b3DBQBf3ALHcTiiU7MYZWmKPli2y9RGYLRy/MNoXa57hzuetrR/M0U/9zXI8xkX1uniCF0lLPZtm25eeZjLzQRDyePzlJsmwzZIozKcr87w5I7g/bmrVfoSOiuokdtTgsFPprH6qNt/EETZPfnpEcgv1LQpHAHVtJb7r6L/DNE8JEPsMFu6iES2JFJv6tnsaLQyOG0AP5oOseZFQslexFs1zBIXP9sLQyJ7fLQws1/eRVPSX6P8xGZDyTx8plNeTOwC2E2HP7HqMQoWf+izZvMsewVAHQiSn1TaaQp75gZxrqkYobCYX2njXLUHq91i61DM3yygiwUauVgtg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5413426b-1433-4693-3529-08dcd17810e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:07:59.1141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw253IoQYyN9ib2J1IVej/qkFkbTmnNXQgp1CAyonrnb1PKQ0JnQmsLodr0k9WSLZzt4m5py8ozHYSCI+OLNy8byHVvWHi8qxVlf+3lc0gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100069
X-Proofpoint-ORIG-GUID: esnLY6orywVAZ2wcO01N3OUYV4kDZQ3N
X-Proofpoint-GUID: esnLY6orywVAZ2wcO01N3OUYV4kDZQ3N
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: William Roche <william.roche@oracle.com>

We need to deal with hugetlbfs memory large pages facing HW errors,
to increase the probability to survive a memory poisoning.
When an error is detected, the platform kernel marks the entire
hugetlbfs large page as "poisoned" and reports the event to all
potential users using SIGBUS.

This change introduces 2 aspects:
. trying to recover not HWPOISON data from the error impacted large page
. splitting this large page into standard sized pages

When Qemu receives this SIGBUS, it will try to recover as much data
as possible from the hugepage backend file (which has to be a MAP_SHARED
mapping) with the help of the following kernel feature:
 linux commit 38c1ddbde6c6 ("hugetlbfs: improve read HWPOISON hugepage")

The impacted hugetlbfs large page is replaced by a set of standard pages
populated with the content of the recovered area or a poison for the
unrecoverable locations, reading the backend file.
Any error reading this file results in the corresponding standard
sized page to be poisoned. And if this file mapping is not set with
"share=on", the entire replacing set of pages is poisoned.

We pause the VM to perfom the memory replacement. To do so we have
to get out of the SIGBUS handler(s). But the signal will be
reraised on VM resume.

The platform kernel may report the beginning of the error impacted
large page in the SIGBUS siginfo data, so we may have to adjust this
poison address information to point to the finer grain actual
poison location based on the replacing standard sized pages.
Aiming at a more precise poison information reported to the VM
gives the possibility to better react to this situation, improving
the overall RAS of hugetlbfs VMs.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c    |   7 +
 meson.build            |   2 +
 system/hugetlbfs_ras.c | 546 +++++++++++++++++++++++++++++++++++++++++
 system/hugetlbfs_ras.h |   3 +
 system/meson.build     |   1 +
 system/physmem.c       |  17 ++
 target/arm/kvm.c       |  10 +
 target/i386/kvm/kvm.c  |  10 +
 8 files changed, 596 insertions(+)
 create mode 100644 system/hugetlbfs_ras.c
 create mode 100644 system/hugetlbfs_ras.h

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index bcccf80bd7..6c6841f935 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -57,6 +57,10 @@
 #include <sys/eventfd.h>
 #endif
 
+#ifdef CONFIG_HUGETLBFS_RAS
+#include "system/hugetlbfs_ras.h"
+#endif
+
 /* KVM uses PAGE_SIZE in its definition of KVM_COALESCED_MMIO_MAX. We
  * need to use the real host PAGE_SIZE, as that's what KVM will use.
  */
@@ -1211,6 +1215,9 @@ static void kvm_unpoison_all(void *param)
 {
     HWPoisonPage *page, *next_page;
 
+#ifdef CONFIG_HUGETLBFS_RAS
+    hugetlbfs_ras_empty();
+#endif
     QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
         QLIST_REMOVE(page, list);
         qemu_ram_remap(page->ram_addr, page->page_size);
diff --git a/meson.build b/meson.build
index fbda17c987..03214586c4 100644
--- a/meson.build
+++ b/meson.build
@@ -3029,6 +3029,8 @@ if host_os == 'windows'
   endif
 endif
 
+config_host_data.set('CONFIG_HUGETLBFS_RAS', host_os == 'linux')
+
 ########################
 # Target configuration #
 ########################
diff --git a/system/hugetlbfs_ras.c b/system/hugetlbfs_ras.c
new file mode 100644
index 0000000000..2f7e550f56
--- /dev/null
+++ b/system/hugetlbfs_ras.c
@@ -0,0 +1,546 @@
+/*
+ * Deal with memory hugetlbfs largepage errors in userland.
+ *
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <poll.h>
+#include <errno.h>
+#include <string.h>
+
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "exec/ramblock.h"
+#include "qemu/thread.h"
+#include "qemu/queue.h"
+#include "qemu/error-report.h"
+#include "block/thread-pool.h"
+#include "sysemu/runstate.h"
+#include "sysemu/kvm.h"
+#include "qemu/main-loop.h"
+#include "block/aio-wait.h"
+
+#include "hugetlbfs_ras.h"
+
+/* #define DEBUG_HUGETLBFS_RAS */
+
+#ifdef DEBUG_HUGETLBFS_RAS
+#define DPRINTF(fmt, ...) \
+    do { fprintf(stderr, "lpg_ras[%s]: " fmt, __func__, ## __VA_ARGS__); \
+    } while (0)
+#else
+#define DPRINTF(fmt, ...) do {} while (0)
+#endif
+
+/*
+ * We track the Large Poisoned Pages to be able to:
+ * - Identify if a faulting page is already under replacement
+ * - Trigger a replacement for new pages
+ * - Inform the suspended signal handlers that they can continue
+ */
+typedef enum LPP_state {
+    LPP_SUBMITTED = 1,
+    LPP_PREPARING,
+    LPP_DONE,
+    LPP_FAILED,
+} LPP_state;
+
+typedef struct LargeHWPoisonPage {
+    void     *page_addr; /* hva of the poisoned large page */
+    size_t    page_size;
+    LPP_state page_state;
+    void     *first_poison; /* location of the first poison found */
+    struct timespec creation_time;
+    QLIST_ENTRY(LargeHWPoisonPage) list;
+} LargeHWPoisonPage;
+
+static QLIST_HEAD(, LargeHWPoisonPage) large_hwpoison_page_list =
+    QLIST_HEAD_INITIALIZER(large_hwpoison_page_list);
+static int large_hwpoison_vm_stop; /* indicate that VM is stopping */
+static QemuCond large_hwpoison_cv;
+static QemuCond large_hwpoison_new;
+static QemuCond large_hwpoison_vm_running;
+static QemuMutex large_hwpoison_mtx;
+static QemuThread thread;
+static void *hugetlbfs_ras_listener(void *arg);
+static int vm_running;
+static bool hugetlbfs_ras_initialized;
+static int _PAGE_SIZE = 4096;
+static int _PAGE_SHIFT = 12;
+
+/* size should be a power of 2 */
+static int
+shift(int sz)
+{
+    int e, s = 0;
+
+    for (e = 0; (s < sz) && (e < 31); e++) {
+        s = (1 << e);
+        if (s == sz) {
+            return e;
+        }
+    }
+    return -1;
+}
+
+static int
+hugetlbfs_ras_init(void)
+{
+    _PAGE_SIZE = qemu_real_host_page_size();
+    _PAGE_SHIFT = shift(_PAGE_SIZE);
+    if (_PAGE_SHIFT < 0) {
+        warn_report("No support for hugetlbfs largepage errors: "
+                    "Bad page size (%d)", _PAGE_SIZE);
+        return -EIO;
+    }
+    qemu_cond_init(&large_hwpoison_cv);
+    qemu_cond_init(&large_hwpoison_new);
+    qemu_cond_init(&large_hwpoison_vm_running);
+    qemu_mutex_init(&large_hwpoison_mtx);
+
+    qemu_thread_create(&thread, "hugetlbfs_error", hugetlbfs_ras_listener,
+                       NULL, QEMU_THREAD_DETACHED);
+
+    hugetlbfs_ras_initialized = true;
+    return 0;
+}
+
+bool
+hugetlbfs_ras_use(void)
+{
+    static bool answered;
+
+    if (answered) {
+        return hugetlbfs_ras_initialized;
+    }
+
+    /* XXX we could verify if ras feature should be used or not (on ARM) */
+
+    /* CAP_SYS_ADMIN capability needed for madvise(MADV_HWPOISON) */
+    if (getuid() != 0) {
+        warn_report("Priviledges needed to deal with hugetlbfs memory poison");
+    } else {
+        hugetlbfs_ras_init();
+    }
+
+    answered = true;
+    return hugetlbfs_ras_initialized;
+}
+
+/* return the backend real page size used for the given address */
+static size_t
+hugetlbfs_ras_backend_sz(void *addr)
+{
+    ram_addr_t offset;
+    RAMBlock *rb;
+
+    rb = qemu_ram_block_from_host(addr, false, &offset);
+    if (!rb) {
+        warn_report("No associated RAMBlock to addr: %p", addr);
+        return _PAGE_SIZE;
+    }
+    return rb->page_size;
+}
+
+/*
+ * Report if this std page address of the given faulted large page should be
+ * retried or if the current signal handler should continue to deal with it.
+ * Once the mapping is replaced, we retry the errors appeared before the
+ * 'page struct' creation, to deal with previous errors that haven't been
+ * taken into account yet.
+ * But the 4k pages of the mapping can also experience HW errors in their
+ * lifetime.
+ */
+static int
+hugetlbfs_ras_retry(void *addr, LargeHWPoisonPage *page,
+                    struct timespec *entry_time)
+{
+    if (addr == page->first_poison) {
+        return 0;
+    }
+    if (entry_time->tv_sec < page->creation_time.tv_sec) {
+        return 1;
+    }
+    if ((entry_time->tv_sec == page->creation_time.tv_sec) &&
+        (entry_time->tv_nsec <= page->creation_time.tv_nsec)) {
+        return 1;
+    }
+    return 0;
+}
+
+/*
+ * If the given address is a large page, we try to replace it
+ * with a set of standard sized pages where we copy what remains
+ * valid from the failed large page.
+ * We reset the two values pointed by paddr and psz to point
+ * to the first poisoned page in the new set, and the size
+ * of this poisoned page.
+ * Return True when it's done. The handler continues with the
+ * possibly corrected values.
+ * Returning False means that there is no signal handler further
+ * action to be taken, the handler should exit.
+ */
+bool
+hugetlbfs_ras_correct(void **paddr, size_t *psz, int code)
+{
+    void *p, *reported_addr;
+    size_t reported_sz, real_sz;
+    LargeHWPoisonPage *page;
+    int found = 0;
+    struct timespec et;
+
+    assert(psz != NULL && paddr != NULL);
+
+    DPRINTF("SIGBUS (%s) at %p (size: %lu)\n",
+        (code == BUS_MCEERR_AR ? "AR" : "AO"), *paddr, *psz);
+
+    if (!hugetlbfs_ras_initialized) {
+        return true;
+    }
+
+    /*
+     * XXX kernel provided size is not reliable...
+     * As kvm_send_hwpoison_signal() uses a hard-coded PAGE_SHIFT
+     * signal value on hwpoison signal.
+     * So in the case of a std page size, we must identify the actual
+     * size to consider (from the mapping block size, or if we
+     * already reduced the page to 4k chunks)
+     */
+    reported_sz = *psz;
+
+    p = *paddr;
+    reported_addr = p;
+
+    if (clock_gettime(CLOCK_MONOTONIC, &et) != 0) {
+        et.tv_sec = 0;
+        et.tv_nsec = 1;
+    }
+    qemu_mutex_lock(&large_hwpoison_mtx);
+
+    if (large_hwpoison_vm_stop) {
+        qemu_mutex_unlock(&large_hwpoison_mtx);
+        return false;
+    }
+
+    QLIST_FOREACH(page, &large_hwpoison_page_list, list) {
+        if (page->page_addr <= p &&
+            page->page_addr + page->page_size > p) {
+            found = 1;
+            break;
+        }
+    }
+
+    if (!found) {
+        if (reported_sz > _PAGE_SIZE) {
+            /* we trust the kernel in this case */
+            real_sz = reported_sz;
+        } else {
+            real_sz = hugetlbfs_ras_backend_sz(p);
+            if (real_sz <= _PAGE_SIZE) {
+                /* not part of a large page */
+                qemu_mutex_unlock(&large_hwpoison_mtx);
+                return true;
+            }
+        }
+        page = g_new0(LargeHWPoisonPage, 1);
+        p = (void *)ROUND_DOWN((unsigned long long)p, real_sz);
+        page->page_addr = p;
+        page->page_size = real_sz;
+        page->page_state = LPP_SUBMITTED;
+        QLIST_INSERT_HEAD(&large_hwpoison_page_list, page, list);
+        qemu_cond_signal(&large_hwpoison_new);
+    } else {
+        if ((code == BUS_MCEERR_AR) && (reported_sz <= _PAGE_SIZE) &&
+            hugetlbfs_ras_retry(p, page, &et)) {
+            *paddr = NULL;
+        }
+    }
+
+    while (page->page_state < LPP_DONE && !large_hwpoison_vm_stop) {
+        qemu_cond_wait(&large_hwpoison_cv, &large_hwpoison_mtx);
+    }
+
+    if (large_hwpoison_vm_stop) {
+        DPRINTF("Handler exit requested as on page %p\n", page->page_addr);
+        *paddr = NULL;
+    }
+    qemu_mutex_unlock(&large_hwpoison_mtx);
+
+    if (page->page_state == LPP_FAILED) {
+        warn_report("Failed recovery for page: %p (error at %p)",
+                    page->page_addr, reported_addr);
+        return (*paddr == NULL ? false : true);
+    }
+
+    *psz = (size_t)_PAGE_SIZE;
+
+    DPRINTF("SIGBUS (%s) corrected from %p to %p (size %ld to %ld)\n",
+            (code == BUS_MCEERR_AR ? "AR" : "AO"),
+            reported_addr, *paddr, reported_sz, *psz);
+
+    return (*paddr == NULL ? false : true);
+}
+
+/*
+ * Sequentially read the valid data from the failed large page (shared) backend
+ * file and copy that into our set of standard sized pages.
+ * Any error reading this file (not only EIO) means that we don't retrieve
+ * valid data for the read location, so it results in the corresponding
+ * standard page to be marked as poisoned.
+ * And if this file mapping is not set with "share=on", we can't rely on the
+ * content on the backend file, so the entire replacing set of pages
+ * is poisoned in this case.
+ */
+static int take_valid_data_lpg(LargeHWPoisonPage *page, const char **err)
+{
+    int fd, i, ps = _PAGE_SIZE, slot_num, poison_count = 0;
+    ram_addr_t offset;
+    RAMBlock *rb;
+    uint64_t fd_offset;
+    ssize_t count, retrieved;
+
+    /* find the backend to get the associated fd and offset */
+    rb = qemu_ram_block_from_host(page->page_addr, false, &offset);
+    if (!rb) {
+        if (err) {
+            *err = "No associated RAMBlock";
+        }
+        return -1;
+    }
+    fd = qemu_ram_get_fd(rb);
+    fd_offset = rb->fd_offset;
+    offset += fd_offset;
+    assert(page->page_size == qemu_ram_pagesize(rb));
+    slot_num = page->page_size / ps;
+
+    if (!qemu_ram_is_shared(rb)) { /* we can't use the backend file */
+        if (madvise(page->page_addr, page->page_size, MADV_HWPOISON) == 0) {
+            page->first_poison = page->page_addr;
+            warn_report("Large memory error, unrecoverable section "
+                "(unshared hugetlbfs): start:%p length: %ld",
+                page->page_addr, page->page_size);
+            return 0;
+        } else {
+            if (err) {
+                *err = "large poison injection failed";
+            }
+            return -1;
+        }
+    }
+
+    for (i = 0; i < slot_num; i++) {
+        retrieved = 0;
+        while (retrieved < ps) {
+            count = pread(fd, page->page_addr + i * ps + retrieved,
+                ps - retrieved, offset + i * ps + retrieved);
+            if (count == 0) {
+                DPRINTF("read reach end of the file\n");
+                break;
+            } else if (count < 0) {
+                DPRINTF("read backend failed: %s\n", strerror(errno));
+                break;
+            }
+            retrieved += count;
+        }
+        if (retrieved < ps) { /* consider this page as poisoned */
+            if (madvise(page->page_addr + i * ps, ps, MADV_HWPOISON)) {
+                if (err) {
+                    *err = "poison injection failed";
+                }
+                return -1;
+            }
+            if (page->first_poison == NULL) {
+                page->first_poison = page->page_addr + i * ps;
+            }
+            poison_count++;
+            DPRINTF("Found a poison at index %d = addr %p\n",
+                i, page->page_addr + i * ps);
+        }
+    }
+
+    /*
+     * A large page without at least a 4k poison will not have an
+     * entry into hwpoison_page_list, so won't be correctly replaced
+     * with a new large page on VM reset with qemu_ram_remap().
+     * Any new error on this area will fail to be handled.
+     */
+    if (poison_count == 0) {
+        if (err) {
+            *err = "No Poison found";
+        }
+        return -1;
+    }
+
+    DPRINTF("Num poison for page %p : %d / %d\n",
+            page->page_addr, poison_count, i);
+    return 0;
+}
+
+/*
+ * Empty the large_hwpoison_page_list -- to be called on address space
+ * poison cleanup outside of concurrent memory access.
+ */
+void hugetlbfs_ras_empty(void)
+{
+    LargeHWPoisonPage *page, *next_page;
+
+    if (!hugetlbfs_ras_initialized) {
+        return;
+    }
+    qemu_mutex_lock(&large_hwpoison_mtx);
+    QLIST_FOREACH_SAFE(page, &large_hwpoison_page_list, list, next_page) {
+        QLIST_REMOVE(page, list);
+        g_free(page);
+    }
+    qemu_mutex_unlock(&large_hwpoison_mtx);
+}
+
+/*
+ * Deal with the given page, initializing its data.
+ */
+static void
+hugetlbfs_ras_transform_page(LargeHWPoisonPage *page, const char **err_info)
+{
+    const char *err_msg;
+    int fd;
+    ram_addr_t offset;
+    RAMBlock *rb;
+
+    /* find the backend to get the associated fd and offset */
+    rb = qemu_ram_block_from_host(page->page_addr, false, &offset);
+    if (!rb) {
+        DPRINTF("No associated RAMBlock to %p\n", page->page_addr);
+        err_msg = "qemu_ram_block_from_host error";
+        goto err;
+    }
+    fd = qemu_ram_get_fd(rb);
+
+    if (sync_file_range(fd, offset, page->page_size,
+                        SYNC_FILE_RANGE_WAIT_AFTER) != 0) {
+        err_msg = "sync_file_range error on the backend";
+        perror("sync_file_range");
+        goto err;
+    }
+    if (fsync(fd) != 0) {
+        err_msg = "fsync error on the backend";
+        perror("fsync");
+        goto err;
+    }
+    if (msync(page->page_addr, page->page_size, MS_SYNC) != 0) {
+        err_msg = "msync error on the backend";
+        perror("msync");
+        goto err;
+    }
+    page->page_state = LPP_PREPARING;
+
+    if (munmap(page->page_addr, page->page_size) != 0) {
+        err_msg = "Failed to unmap";
+        perror("munmap");
+        goto err;
+    }
+
+    /* replace the large page with standard pages */
+    if (mmap(page->page_addr, page->page_size, PROT_READ | PROT_WRITE,
+            MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0)
+            == MAP_FAILED) {
+        err_msg = "Failed to map std page";
+        perror("mmap");
+        goto err;
+    }
+
+    /* take a copy of still valid data and mark the failed pages as poisoned */
+    if (take_valid_data_lpg(page, &err_msg) != 0) {
+        goto err;
+    }
+
+    if (clock_gettime(CLOCK_MONOTONIC, &page->creation_time) != 0) {
+        err_msg = "Failed to set creation time";
+        perror("clock_gettime");
+        goto err;
+    }
+
+    page->page_state = LPP_DONE;
+    return;
+
+err:
+    if (err_info) {
+        *err_info = err_msg;
+    }
+    page->page_state = LPP_FAILED;
+}
+
+/* attempt to vm_stop the entire VM in the IOthread */
+static void coroutine_hugetlbfs_ras_vmstop_bh(void *opaque)
+{
+    vm_stop(RUN_STATE_PAUSED);
+    DPRINTF("VM STOPPED\n");
+    qemu_mutex_lock(&large_hwpoison_mtx);
+    vm_running = 0;
+    qemu_cond_signal(&large_hwpoison_vm_running);
+    qemu_mutex_unlock(&large_hwpoison_mtx);
+}
+
+static void coroutine_hugetlbfs_ras_vmstart_bh(void *opaque)
+{
+    vm_start();
+}
+
+static void *
+hugetlbfs_ras_listener(void *arg)
+{
+    LargeHWPoisonPage *page;
+    int new;
+    const char *err;
+
+    /* monitor any newly submitted element in the list */
+    qemu_mutex_lock(&large_hwpoison_mtx);
+    while (1) {
+        new = 0;
+        QLIST_FOREACH(page, &large_hwpoison_page_list, list) {
+            if (page->page_state == LPP_SUBMITTED) {
+                new++;
+                vm_running = 1;
+                DPRINTF("Stopping the VM\n");
+                aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                coroutine_hugetlbfs_ras_vmstop_bh, NULL);
+                /* inform all SIGBUS threads that they have to return */
+                large_hwpoison_vm_stop++;
+                qemu_cond_broadcast(&large_hwpoison_cv);
+
+                /* wait until VM is stopped */
+                while (vm_running) {
+                    DPRINTF("waiting for vm to stop\n");
+                    qemu_cond_wait(&large_hwpoison_vm_running,
+                                   &large_hwpoison_mtx);
+                }
+
+                hugetlbfs_ras_transform_page(page, &err);
+                if (page->page_state == LPP_FAILED) {
+                    error_report("fatal: unrecoverable hugepage memory error"
+                                 " at %p (%s)", page->page_addr, err);
+                    exit(1);
+                }
+
+                large_hwpoison_vm_stop--;
+
+                DPRINTF("Restarting the VM\n");
+                aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                coroutine_hugetlbfs_ras_vmstart_bh, NULL);
+            }
+        }
+        if (new) {
+            qemu_cond_broadcast(&large_hwpoison_cv);
+        }
+
+        qemu_cond_wait(&large_hwpoison_new, &large_hwpoison_mtx);
+    }
+    qemu_mutex_unlock(&large_hwpoison_mtx);
+    return NULL;
+}
diff --git a/system/hugetlbfs_ras.h b/system/hugetlbfs_ras.h
new file mode 100644
index 0000000000..324228bda3
--- /dev/null
+++ b/system/hugetlbfs_ras.h
@@ -0,0 +1,3 @@
+bool hugetlbfs_ras_use(void);
+bool hugetlbfs_ras_correct(void **paddr, size_t *psz, int code);
+void hugetlbfs_ras_empty(void);
diff --git a/system/meson.build b/system/meson.build
index a296270cb0..eda92f55a9 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -37,4 +37,5 @@ system_ss.add(when: 'CONFIG_DEVICE_TREE',
               if_false: files('device_tree-stub.c'))
 if host_os == 'linux'
   system_ss.add(files('async-teardown.c'))
+  system_ss.add(files('hugetlbfs_ras.c'))
 endif
diff --git a/system/physmem.c b/system/physmem.c
index 5c176146c0..78de507bd0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -82,6 +82,10 @@
 #include <daxctl/libdaxctl.h>
 #endif
 
+#ifdef CONFIG_HUGETLBFS_RAS
+#include "system/hugetlbfs_ras.h"
+#endif
+
 //#define DEBUG_SUBPAGE
 
 /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
@@ -2061,6 +2065,19 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
+#ifdef CONFIG_HUGETLBFS_RAS
+    {
+        QemuFsType ftyp = qemu_fd_getfs(fd);
+
+        if (ftyp == QEMU_FS_TYPE_HUGETLBFS) {
+            if (hugetlbfs_ras_use() && !(ram_flags & RAM_SHARED)) {
+                warn_report("'share=on' option must be set to support "
+                            "hugetlbfs memory error handling");
+            }
+        }
+    }
+#endif
+
     block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset, errp);
     if (!block) {
         if (created) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f62e53e423..6215d1acb5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -40,6 +40,10 @@
 #include "hw/acpi/ghes.h"
 #include "target/arm/gtimer.h"
 
+#ifdef CONFIG_HUGETLBFS_RAS
+#include "system/hugetlbfs_ras.h"
+#endif
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
@@ -2356,6 +2360,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr, short addr_lsb)
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
+#ifdef CONFIG_HUGETLBFS_RAS
+    if (!hugetlbfs_ras_correct(&addr, &sz, code)) {
+        return;
+    }
+#endif
+
     if (acpi_ghes_present() && addr) {
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 99b87140cc..c99095cb1f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -69,6 +69,10 @@
 #include "exec/memattrs.h"
 #include "trace.h"
 
+#ifdef CONFIG_HUGETLBFS_RAS
+#include "system/hugetlbfs_ras.h"
+#endif
+
 #include CONFIG_DEVICES
 
 //#define DEBUG_KVM
@@ -729,6 +733,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr, short addr_lsb)
      */
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
+#ifdef CONFIG_HUGETLBFS_RAS
+    if (!hugetlbfs_ras_correct(&addr, &sz, code)) {
+        return;
+    }
+#endif
+
     if ((env->mcg_cap & MCG_SER_P) && addr) {
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
-- 
2.43.5


