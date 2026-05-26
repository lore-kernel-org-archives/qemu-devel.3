Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A174BCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnib-0000bN-DI; Tue, 26 May 2026 05:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wRniZ-0000at-Hd
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:04:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wRniW-0003fu-QT
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:04:55 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q8XZCm2644327; Tue, 26 May 2026 02:04:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=99fkzSOLqBY7e0s
 temgbCJlciyqCqKjJgThpCwcSfJk=; b=fF+yp0sUXTUVqKz1dfybGJXh6O4hwpv
 X+PO0FPdTNP6vv7gK/qw25eJipBxHqA9uMNQKAyFflTeTSTxqXh0GNW74I1Q3hoJ
 dI8zuHrBcC1u5NdUdPDF4HSfHkAf4cy8xK2KFOumqEGhjtgcUEajPZpZwL94BgPM
 s3NGUs1PDr0mJmNMpNonqsqvRjA2yvO6m8o6KjbiQ0djc2wK1mluB68E8U5Zjz4S
 ZWQffwtVP4ZwOOLTuVAqR/LgB3p9xf02PYupFa+dW/hsEzASRwlMPFMGJ/VrzGJj
 bktdvoukxfofsQKI9FlUCNFY5VqvSXYwjII6ypnDxSskM5JQWSjUp+A==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021088.outbound.protection.outlook.com [52.101.57.88])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4eb8jt6dmx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 02:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0c2OgjeGWaq/Tt5nFwDmy4J96rWzo7XJSsV+ieNO//RhvRNFY1c9PO5FPBx2d1hYHqOgk4hB6VgJk/twaksYrhYdLahM5nny/oOMjGvn2MePuPAez8kphE7bhgKhnq2K1ISD15nhXvLk0y91rm4jlIEc16wtOZ81TDkvM9zwCOUK/3a/qEN4Gh7rF7WqT1XoKkEOe4ZnFUodBAVmd6wEmensMrxnikEVXskNdaAHPrfbjPY2nD6C6W2gqWOAqgfJDnxBF97sZgSBROaXlaj2d8QWr9htQ5Wd4twt2M1TrGJwLT9DKTO8GjaOsp9MK7U/fJ7VhE/NhLyZduvfH2KrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99fkzSOLqBY7e0stemgbCJlciyqCqKjJgThpCwcSfJk=;
 b=SUZkdxb7vUU/x18igLPVm4I4ky2+EjmSI35lCFCIoIkrYBbDNFlSScMMlP38f0m6/Bx2XQwmo1vDomgpPaLseSttl38+YWJq33gNExPSz780+l27qTI3IHu2fu5KG0cAYQT4Ff5qDJQ9ik6E7KXNpup6J0s3kuzNS6H2boz5CdhPMrubgHp+HyCGiei27AlWASnQGo806YueS3eOZ8EiBBk6McqNHgr1dJNpDSksiemxZMvU9DvWj4PWrHHUNdB62WPsYtdnWZ/tvvUp+l10tow+WFSD0pBytqDQ7oY1P2cTeKzgANF27HUhpkIwaL89xSY2AqiGV8izNApg85ZnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99fkzSOLqBY7e0stemgbCJlciyqCqKjJgThpCwcSfJk=;
 b=S3N+18VqX6o//ymw1QKVq7U/rANTydZkD4NaaYv/e3GeE0HDaXdFhaRK1CLnij+bRabwXhCWgSjQCJI2t8vbYiDalnhpUuvb2rX2ItH4BeDIdwVv/QdVOY7j5/izNK8Kt91pP6BtxEHiKhaCMGMMXiYXJKKHsYGQQy3mWKHTvlcFad5YZA0AW1yFskkGyGXnSgI39MHR7vLV66IN09bHY4M56uJcU8Jytr3081EpQgzN100k1HVVxdrgigO4qLsJoaFYfMSULrmT3PIg7rj3TTL0PEx0xBVQDjl9lqPi7UDQ5S8RGmwtjJujl+dyol/wxYngWY6b1QYU9/VawbEP9w==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by DS7PR02MB10914.namprd02.prod.outlook.com (2603:10b6:8:263::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 09:04:46 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:04:46 +0000
Date: Tue, 26 May 2026 10:04:42 +0100
From: John Levon <john.levon@nutanix.com>
To: Jag Raman <jag.raman@oracle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Message-ID: <ahViKjbOqWrz7q11@lent>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent>
 <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
 <af3_CqQf1wSSWYYY@lent>
 <FFB3F5F9-4F32-4836-B71B-35899536E5A4@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FFB3F5F9-4F32-4836-B71B-35899536E5A4@oracle.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0665.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::16) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|DS7PR02MB10914:EE_
X-MS-Office365-Filtering-Correlation-Id: 8355b710-906c-46e7-0c0d-08debb05d583
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: vpO3dQwbVrMscM931yj2+BwaWfVW+jN/X4HIFTQ0o4+Z2/xPcUxYvkNvyEh9ShI86KYYS/qPGU38Wb0ziimZSQskNNa21CXHws80ypLXkqcQJcsvHOzdAhMAUcYEoCWZ3jRgx/F+MZ9N/65H3jUWpe9jXZdKi5e4xFSLDa9xQJHSLc35DCfEJ9ZqCzglt9GuLKccHXsZvo/hQjbkb8R8rOitLsKWaN4R+lLMA3/FTYELheed3+chNZiS63th9tS3I75krJ+VlMPbkdDLW1IniC5piIeo1QWwmeRyYnBziWSA3ssNqKEMPrZZNzxKg7y0L0bi0uxdLsOVU8qvOTMrKKbgDor0FlS+zL13CmC2ta6L6HHPG8DPmtXU85B8/lK/tm/BDlj4YDd2+y8osRy4bpOP6dmGnWwOmt2uesxDNvMzFT1PNdFP/k4Lz3lK+HdkN6Br1QcrC4JYgmTDypF40f4/7XHI99v+taO2hzJbA3IDPoZORSKgY2bbYgY/yGoQZCN9OpSxqwU5D3AhLoHIdnKnnUdpevx2uwtd4kdTXUN4ocMMzK5RLt/znUufppcFP/+aJ75yxg+9VX7q4GATPBouBDvRBtMOPIedV5uYoT2oW4cLhGyucqjXX06Uu6mBX4lbpj2uBB8STk+qfaZRLqsA/77uT1/Pae8titRWfoDYSW35hFW9JfNr8N4Xe2hV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nUY4uR9bcqiAks2BwkkFoejp+88qih9/qNthF0G3V+zQxC3Yu8iV4trRTEdv?=
 =?us-ascii?Q?y5EWAkiapt8zhj5UIVs5imEZbuSkncB25UHD1eGPRRhepQ+g/oS2Cs9KMylz?=
 =?us-ascii?Q?cxC9eZA5Hqi3HtELqvJVbJvUlmV9K8OJFeAfDUrAZA22UDxiZZpzB6BqB/7v?=
 =?us-ascii?Q?EArI25FVhaNV0vBB677GoF1ASgkqF3mXE3nDkKTL+uRyZ+HYr/BK0qoss4hQ?=
 =?us-ascii?Q?fduwg04+W+gIac6Fj/EswjeXjRp+Ljx1k/6IjeHsmCi4pvU/wNjm4/x4plTY?=
 =?us-ascii?Q?C0Mq6v7chMoFGPSPpFnCmUON7L6Re2CvMax3JURIWvXFMDJQn/4N8Xld/mOJ?=
 =?us-ascii?Q?j3zOGhTv65kfYUd0m3v2UTj0hQ0IYlUzZCYzNuuZqdumZShDhAJeMZ0+i6wm?=
 =?us-ascii?Q?T9oDqxjpFRCI/jTY+/Mc1Z8zGAlcGlN5CuVJHJh4HbdnUFWDODZqqk2zv918?=
 =?us-ascii?Q?YjLkZ1w56BDmDeiOr/LvXxMfgnbGekbzcPZ+vCO0YXmYhn4/hWzynNtSvQIj?=
 =?us-ascii?Q?xSfoyaN69WUyqP4KNi7Z6/vqHhgh9xRpnP0THTe7B/OYbimfSsv4IncWmB3c?=
 =?us-ascii?Q?Zl/yQ4+hC9TmKBPNUkSz3iy+xxiHwIOFSuo3O3ml8NHWBJvnC5TFiJtDnDXO?=
 =?us-ascii?Q?ktYA8fCjaS8FIswvxQKEkDEApPx5IAMyQGcRTkSmjPgp9yjS/gBltuf1B1G7?=
 =?us-ascii?Q?VnmdlzlLgsKKGT/izeY87c6dhrUVpDpU8QOnTSJZA0CKwqV/4v/WcigqFbYL?=
 =?us-ascii?Q?82nEztebIWw8CzVvr/eSCIhUTPJ0z8z3dZobNDO9buePg3msY8rlZh1iRO71?=
 =?us-ascii?Q?WBqxbSvru+KWErHL6uSWjoX2uHJsl/NcEuDhcnSLywJL3bPJaggGZ09PqN4i?=
 =?us-ascii?Q?hdQlBVc1PQPKRB5WPucF/2yDQRyGsXYBWUN/BL5zjnWWbFaeFSESIqwSfVZN?=
 =?us-ascii?Q?66RCqxg3rCtWLHTd8+iqGtopLU/g5+627N5k8QdBvj56Z00So7N1FEtTLZ4W?=
 =?us-ascii?Q?0Lc/nmQ2ZlNg7sMw2rEFzSaUOVzrXDwGd/oRAB6GrHiLOat6Hq1JQRKTOew8?=
 =?us-ascii?Q?+6AZR5RVrAoxZ4cr0DZ+j+5rMhw03wO2483HSiokcdgfBFgSZbtyZdStWta8?=
 =?us-ascii?Q?ca4yfNdV2EbhLFClTIealyQy+flqOt4Q9w3LdJZH9HE5QQp4korSIg2smRZi?=
 =?us-ascii?Q?TjfjvkWIewjTxHW0nJm8Po2xYuzM+vaBkeu76e0PNJVZZ9upSqzmk0rkn9N4?=
 =?us-ascii?Q?c0Zi309dfZyguFX2kB4il9T3TSmKw33Eo/M1teNRIxS+IbuNm+nEiQQdEPiQ?=
 =?us-ascii?Q?eq7N/ypZ72MgEuvdYSx+xBF4Yjb06IVVPNR3l9DtEUOg9tSQACx3WvAIG9Ox?=
 =?us-ascii?Q?svll2ZMB5MDi0pfXXAtLdIL0HCKrr8tkpNr7OZOMVjmhLve2rzaWY634EjzD?=
 =?us-ascii?Q?Acu+3oPF3lht0kbEFElfXh2OytnHID/6v8goGsFlgw1PBx80Q5Te9bD4Gotn?=
 =?us-ascii?Q?GM2yuklcI3c/jrUK/A2zvkmKYnn6bfjVPTckjOSNnsPKuVoalSiIwBJXOrH1?=
 =?us-ascii?Q?u2NaWUE6IRBGYSAkM9hwcP86kJIG2pVePeAnrFX6kBCpxK2vZ6iSxjgZ2Oqg?=
 =?us-ascii?Q?YJzm276Elxr4mb4fGDJAhI7RchsTmOQfKJtYqKA1ZK7dBPM/6g9cwYmcDBMY?=
 =?us-ascii?Q?YTiqlCPP5oVKnoACxzwZHeSnYjJLVfU45god6DXYuj9rPRupZGFNoUduk9Mo?=
 =?us-ascii?Q?Ki3HovDitA=3D=3D?=
X-Exchange-RoutingPolicyChecked: puENZBXvsocmMiMPHCgbb1NizcL459Ozvp727xRZcM9cEhs6m2GRFVjLXyD5lUHhIPC5hG/gxM5LE50kH3mKMU1u3gPR0BNVQDKMuSQnw9EHDdIzXMwC48bM5gEW/trfycn8bXD8l+5DEu6VDgd/tEzOkiYVFeOOonMvc13puAFJjYLEAWuNn6hXDKNUCttkTyDMNlEone1Ks54S2p55rCqiyggpOwKhkMHBpNON7kfKoyCxYZZpNKN41UW4d2cU5axvoiaF5QNC3CK1SN+CynEvO1vcDaqC7E+T1D25hFzDc1ohpV5AwfhdoJNFGJqF63c0YpKhij0zjeNr+FXkEA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8355b710-906c-46e7-0c0d-08debb05d583
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:04:46.8442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11pZTktULqTCqIADga+lwX9t+FARjxkdl0hUUxe0cVS0tkHNUqRzwmzIERFdNp8Z7Ex0LmHaIUHt+lxpQ5hlUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10914
X-Authority-Analysis: v=2.4 cv=P60KQCAu c=1 sm=1 tr=0 ts=6a156231 cx=c_pps
 a=cORLsCLt5K7u5uR9RT1HqQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=MVkRc9fsuofrvq1jxrUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: s5d9m7UlNwUSL3U5NvbMl6lXgcxyxDnF
X-Proofpoint-GUID: s5d9m7UlNwUSL3U5NvbMl6lXgcxyxDnF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3OSBTYWx0ZWRfX/7WrL42ftRc9
 ApvyDb5x87+bCRRcDFHrN5+ytNLN7DsDCNosjZX+tPdyGv8uETU3cf04gwGUPtePcK5oJJ1lCz1
 bDFKdCsmZwOqIqBBWnS85vi1oQljUmX1xcBHzAO7++XWWpyZHlOIKabXqJcGqIipVmdqo1E4XhZ
 Qz9Y2OlykS58BCLHmFQLBsHL0rqyNaC62O791jEK93XkMub0BzB1NNXYtUhOWIN7nELwuanG039
 2fgjzvbR0AHNICBRzYtYSGCbAt3BOpspk9B/IGnILPk+f+Dku2RQTdmcpZ3hbx6HTFEQmFxMFA6
 dZBXWsEty7gkHVG9hRnyUEvdKCht1UAa6Ymrw31O+q5M+yEr8BKZQegCSYSCcOVRsNPTFOl/Q3U
 65knx/5e4fo+ixbQyaP6D3m2Fpe4rHWxtI4Vld7y//wjGrJIX93cTm14QoXwjo5OFbp/3oCP9hb
 MMoE3edec/ljMUqlwHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 22, 2026 at 08:48:03PM +0000, Jag Raman wrote:

> > 3) if we don't see any further work on converting mpqemu over to vfio-user
> > properly over, say, the next calendar year, then remove the whole feature.
> 
> To switch the functional test to use vfio-user, we need to enable the
> x-vfio-user-server object by default using --enable-vfio-user-server. Is that
> OK?

Presumably you can enable it by default if --enable-multiprocess is set?

regards
john


