Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CF3C54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFane-0002kc-Iw; Thu, 15 May 2025 11:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFamt-0000Cn-PZ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:46:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFamq-0006Ym-Q6
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:46:22 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F8MCUH007995
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 08:46:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=o21zLGPnQfDg1MA
 30bNWlGMReK6JrTdC+cVYgCe2bqI=; b=GVdag2H8g5xdWW3CGcUhhT/5WFNfax0
 0+dWR9s9DR3VJmeZ6vgf7myA7Bf57WIMwdTnkXnwmVKVbYN3otEnGpDFtN5CRQZd
 fr4iqMECnZ3q20d3FGlOU84vMocm0BBgGCQgJ6gJTzU5ybYhj5CcUAEwI1o7rgR9
 M22CCWB9oOFgjIQXrThfYtzUzPujjo4vFiCul7t7HuR+JFZour7mD+ZIP0iRrEQs
 nutGR6sr9CzWjA7Ayp//QGDDm9qnUjZQvV58QwK6pbdX/CH/b/f4wmzdpVXjW95q
 dUVAyOYu/RfOpow3L+cypVCG4/ntRHsV4ADnJvEz7iaCg2LJOOdognA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbd0we5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 08:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wg2pjftg+7AYtf4PIkpNhCkJwWOrklZx7DWysn++4tFzhRqH4QHbewxJC1052SUo8JmUSScyijXd58asFMrS8AbV1BxxlCxFgVf47yjcia8Avn///YQsn5GYv0SbOqwngS8lpKy9rtidnlSgAgTsUAau1IJ/CIzIo7TYemnglY3KB0BUiGRjI3diWxHJK53yvgm4yTstR/JbS3P8bRt+yGQW2ybK8oJSNQDnG3CZGoit1Bm5nlPfzTpf68Abn4+BdXLDb6zCBHkZo77I/FDKxO2tTFoYO51HOquUf14wgj5uxco8KwEa6LTw3eQi9RUdwak/01wAZcWgdeyZToxGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o21zLGPnQfDg1MA30bNWlGMReK6JrTdC+cVYgCe2bqI=;
 b=mUVVbGq2xGwtU6J+pcEL9vsKN9XhrXaqg+8UUNt1AJbe46OAJbVv+DB/jiXH5Nhvsbbm2vsjkfLPi7vZC54PaqJkXeLm1mG1wLEkelWHDKvJUaX8HTF9HRdO1WIcM4PDTTuBTeXCMzwFv1o5Nl2lzSP6kpsbbkmXwiHxPLBujaBfSZqLLtUvJYKoi29P84ON/cuhRJev4XpyrJb/t0rWhMxrAPpN6wPviHQ3wXOVUHMPgC5xXRh/ArSd2zKT9pgHRnDjPZZqCK8hBzJ6Br4Aj+g23BzN/jKtrZ8dX2ZuMgwrYGT1Jskr5NYwOyjMfdLTa8gs6xIESixbRw8eq2bDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o21zLGPnQfDg1MA30bNWlGMReK6JrTdC+cVYgCe2bqI=;
 b=IOIrXINeMyJ6kfUMKVi6CPlBrbr2xRpyyRyv0qN+3/omASH6WRK8ixaeeBVA+3tJ2OxqyU1oVmrQarlrcAWas/iNiCkGP7n7BIu1/n7/zsnb4n/DZZSvubwVFbW7tApc3qRilNSy1XhWfb9RlSMo2D4Yglzamr/0lOho9249mFJD8ar39uAnWgJO/Tl/sII/FbgZOExYCGt3G071VPvJ7W0d8ebfBZK6AmXyKbg2GObYOtqa9aTixqkKoX7p7Z4r5p7EAJMZIsILnjZwjytuIn6cjb9UrGUA2rqORB0ojNEpremRpXpz0pajuFZCX2nAd+K1uXyboyCfM8ISad/Z2A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 15:46:16 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:46:16 +0000
Date: Thu, 15 May 2025 16:46:14 +0100
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 01/27] vfio: return mr from vfio_get_xlat_addr
Message-ID: <aCYMRnE8D1VnVV-z@lent>
References: <20250515154413.210315-1-john.levon@nutanix.com>
 <20250515154413.210315-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515154413.210315-2-john.levon@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::28) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY1PR02MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: d81b001d-046f-496f-5b85-08dd93c7a116
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GeoWSS9mJbOS32zoHTCKvzasiZpYjVRhJoMfgFSs5CLR+FyfAtVPacICXEtt?=
 =?us-ascii?Q?vJMmb9gxnqfz1TGr6Vzv0gi4rB/k6urb+SspqSiRzSPHaZ1NHMMWnIM8i0/h?=
 =?us-ascii?Q?bvrbc1V3kFCHYW2/zL24QTCmBnOOVjz6mSLQN+5jxkhQressTYR9WPiOZ2M4?=
 =?us-ascii?Q?UyiaG/44VkXFdwHSxqHeWof9n93XKq0HAlcl1HoVKepQKxqHZ3WmteY7vxV+?=
 =?us-ascii?Q?mKqCxM0xXshQslX6wdmB1sdwgJX2rC4s4XsmtdRW1OoIFKQFvsrh+vaNPjBE?=
 =?us-ascii?Q?hj2Dv4j2gPHTjg1Iif82/YCFmPo94/y/Q8UB5h8Jf8UKGzOreQT+zmnbLOLN?=
 =?us-ascii?Q?GfOy8hhOqGx1+mGE2KGTLuR6bCl01MHpqhvMIvx0qmFOw1l7d6mV/qke4hdX?=
 =?us-ascii?Q?8rWaE5b2Qr/R8d7Z5RxrCr9xIGiSfq1kXhP1pFtIrcye/P/X1Kmhi9tspFXn?=
 =?us-ascii?Q?wHaIhVpY9PRhWYZgFqFoQtF426q24DHpJS0mfnujbJ9jWvJ0ehdzN0eIa+KN?=
 =?us-ascii?Q?FtXHj347bRdwK2bcEieyzA4sEqcmi4HwaY2LGXRi2SED73wVwGITVUVd86O/?=
 =?us-ascii?Q?1s3/KIj3RAVoDPmRkslHNhQRon7caP/DgewD+bGL4Hwmc5t6s1PhPf9ha2mB?=
 =?us-ascii?Q?RihjMMgR/BaAL9ifkfcT0oAB0irC2ogAhxd23wIxN+z+gKq2kPVMwNF6AfT4?=
 =?us-ascii?Q?CmEdUOLlGkljxDvAyQVrWkFzWy+IK/eJfPyA1Zuk/ArGNeI9PrHI4HVhxjpQ?=
 =?us-ascii?Q?hP29HrGkDkgc4LRfZcEj956goFMQ1iB+Q64SuVCvg8MTF8nakShxg6Jw+KnZ?=
 =?us-ascii?Q?IXElSzGivN6xGJs71EDjTbHJhjSJFfonXK7IN9IdGv0NPexLZ9HNKMS40Qta?=
 =?us-ascii?Q?TJEoLDcN/Jxdd6ZidWWWBz17pXvyb5sfYW4dlxr5gQ7vDHw46D4NR7F3eCNE?=
 =?us-ascii?Q?2f0U8jKUbMn/V1E2fx1kIWUtiJiuwdo0MM72DoiA3FSBTk/FlUG32l0aSOEl?=
 =?us-ascii?Q?J+Kkg0UuVA7rArO/rcQ1NAHuwAw2e2poW3zDSjllctxKmBhvsMY58rFepC0Y?=
 =?us-ascii?Q?tNgVrtrmCU1v1XG0Fdwud8bE0evBeP+MGylOTucPcXYW4kWfcp0sB2tCjmiH?=
 =?us-ascii?Q?CsHGE6Uv6Uhucn4qSwP6EsrtnnBAEu7tEgcAV374KZa/5YI/92mK6aoiKkgR?=
 =?us-ascii?Q?vwX0b5UeG0xSmwoX8/J8CsOW/YjC7OOBEeYomWQA/8deNxt0vH809FJyJCiC?=
 =?us-ascii?Q?A2ZhnShU8NZGvDmW8J0EGKl1a3rodT5crVe+BHNkeVhk3v5hwQhff7FnHlWe?=
 =?us-ascii?Q?T2qQ7hqlJ6+DSTfaKzdVKfAIY+ALr5Lu+g3V7wOoxgaIo3ZlOYwUIvH9MmRG?=
 =?us-ascii?Q?dFtOzYs2KqRQ6WtGZrAn8+VeTBEPO4zrLvz9yzgSaFJt1zznSV6j1GYXsYQV?=
 =?us-ascii?Q?GZaBAhQLNqA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rK6sC5ci9/8pLh0m/V6KxqrT+lyaaEZFMngGnPwluNtgzL47SRb+A29bHmRI?=
 =?us-ascii?Q?sBgb2S3wNVFbJk0n9rqcSleeBNUI81/BR5K5OMUsg5qCUMK9ywfizz7b7OGn?=
 =?us-ascii?Q?uvhXvoBU/zRKjdca5vrTYuvMZBg/O1jIefKYBt6/WbY77h7iVAnz6kpio12/?=
 =?us-ascii?Q?nzWTJVNBZa3bBCAMQhEu+0T9X2p64+D4FAk9mjaqcCWjGT3K24nevQ1lG2jK?=
 =?us-ascii?Q?l+68LNjpzabao5oXueCnnWQuQwmOM5CiDPPedOIKFYyWLX7/Ub3r+KAVTdKR?=
 =?us-ascii?Q?3+dzPIAmdoC9rXvIeUK26U5dbno90xa45VOwcT2mQ0mH3+JDNBdTZIXqMRxn?=
 =?us-ascii?Q?+PuxbRIOShyMiNlgJ6YtG5bpbs5GFHdmi9llSSURMS3zK3RO0A1OR9ok3dtI?=
 =?us-ascii?Q?n+Ik6hRBy3BlA2dXHCGn1Jj2kADElJ+U/IC3jPPRlCQxyVWm4a/2uEXQt18F?=
 =?us-ascii?Q?MINZvhH5e16cL2IjAmaqWa5yOeGfBjF95Ml2IhzE/esgLgRb//9ftBM0+hl/?=
 =?us-ascii?Q?GxtOMrCHFOUra8OynUFt5b/Bv18dYdx5vet7TsDYT20HUJdX1kgAwjf007up?=
 =?us-ascii?Q?zn8uFIFeMU17Sjq1K2jrdbIiaUEoerkCME+0FO7z8p6nhbqCajZhrb5ahTs8?=
 =?us-ascii?Q?13MsOcNUn4orqPRM0YuZg6kQgrZ6abmlut5ZUF068fedmJbiVzKwIM6vzxKw?=
 =?us-ascii?Q?zaDEO4C4m+QLD8THP7oa7KyEyUi5w4uq74sC0c0ArvBoQNmka79iNWOlFTEl?=
 =?us-ascii?Q?4HgjAGTEMQxj0ywpG/LroiGhuf5tUvGTe4Cn1BmHy6UAp8wuErGV5DhXbzhI?=
 =?us-ascii?Q?g3zW/+mNtDdhYvyakAyyBFTIIrzA1Xedp1Bj9igRlAAnorczMBznBDSsVFmy?=
 =?us-ascii?Q?FwK9s5e6+1isHxxCTNwrDPhyXeK4dNCCVetnUFWkapp5WeGcC+vPc/XwxNJG?=
 =?us-ascii?Q?1RaOR7uvsl7VohMbPM1gL2TPiWvFQs3yFuXyW4kb8C3yqYx0CHp0HRikDQ0p?=
 =?us-ascii?Q?emtLqUd8bnticZZTTXLVMgYQtnqTkfHjRz9VCkI8o06zE6skfPuOeKTrOgar?=
 =?us-ascii?Q?ZU8VnS0JU87gSiglemgDmIq3fmXkEFyTIkGNfHjK4iJK7FOonXoEQ6IyYwLz?=
 =?us-ascii?Q?xVdNATiS1NtZJVRMjwnc7CbRxsakRLH3uh/9OJANKAI8Xww5T//n8TjHRxPb?=
 =?us-ascii?Q?GuD+hYVbxLs7DKK7qToE1Fzf9L+BqLetCuXeEf4Yw/dyWJrQ9x87w0T7eqcR?=
 =?us-ascii?Q?roXoYdPhgkS76YfD+HAGs07PsWlZC0aII7WoU1/+lyHroanQ2V2DcvnBqNDW?=
 =?us-ascii?Q?ui9E9y7jYPXx/7bLEM623OLHkRqcePdkoSHpLauwIyFGgfets8qiGxbyJix0?=
 =?us-ascii?Q?ejNkE3G5X+mi81Py0Ra9k5ZMmFwU1sHxy03t4rHqKsWACsPfnRJ4t4bDDIqa?=
 =?us-ascii?Q?XkvwiwKVI/BxzuNCXdT7QDXbyDc+eLrLQ505tJ2MK2QVzITr0EaLkFXBi92J?=
 =?us-ascii?Q?PVgWdmsGKgbtD6LZcBk3lNRfXKfnEyBkSlxddwgBggQ9qSnNSvxGLr9elZsh?=
 =?us-ascii?Q?yFGIfNpPp3U5Hbirv0+nYKcmED51xxHplRWTKmF6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81b001d-046f-496f-5b85-08dd93c7a116
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:46:16.7959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMtvBzJBXcVFRNJcK94FpARQcKUncnqYByomZYjKAp14W7T5H9FJkXYltzugP8Yf+ZC7VUUNjmk5ieefN/CaxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Proofpoint-ORIG-GUID: Wo510lA0B3lr2dbM4KTep3ZRGzJw6kX_
X-Proofpoint-GUID: Wo510lA0B3lr2dbM4KTep3ZRGzJw6kX_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfXx3/JA8Km4zJs
 6jtOFXmcNbbgwg49aC0UWxB1vxVPntbRqL9Wgmf32E12GwlDEnGzjPdwl/6Qc14gvFyxt4I4rmD
 Ppe+WI49cX4iCEBGbkxM5jeSo9AZSGmzM/zp7oVzvpDAQ+pke5v81j/JA11zt9tCvzP3l/QKWWc
 2SXM/sMbosD4qjdxtfb+1a+uZcgDX/MXQmsyLKmqtWjfEXO+6DEriIq0QZWzGWa0kcqSdvQ+fPG
 G/YT7PlSjRBSbnJbKfNJlwPawulBm4XKCQ4AwyjUqh89qP4eIH0Mid1mMZ5rCAGIhH8+pVevQOB
 GB4DWErJOVi5vhP+0Zu5vYeTtlWH4NKpYSPbT20DEZ/sSuvX7bMHjT0ttRJfmGB+13XkvpDw7Hi
 hyTCbYQ/c3Hx3hgPbRQGBuoq9BdGzUZEbmkc3rha7qqa4rXF8cg74Pf0xoHLAd3m/CSgkwrA
X-Authority-Analysis: v=2.4 cv=KKlaDEFo c=1 sm=1 tr=0 ts=68260c4a cx=c_pps
 a=zbudaZmfUx0dwwhLSrpPog==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=vcURM8QVG6rO4YVKcBAA:9
 a=CjuIK1q_8ugA:10
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

On Thu, May 15, 2025 at 04:43:46PM +0100, John Levon wrote:

> From: Steve Sistare <steven.sistare@oracle.com>
> 
> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
> region that the translated address is found in.  This will be needed by
> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
> 
> Also return the xlat offset, so we can simplify the interface by removing
> the out parameters that can be trivially derived from mr and xlat.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

FWIW I'm aware there's recent discussion on this patch separately, but I've
needed to include it in this series for the subsequent changes.

thanks
john

