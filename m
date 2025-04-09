Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AABC369A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VnM-0006RY-Rt; Wed, 09 Apr 2025 09:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnK-0006Ix-7c; Wed, 09 Apr 2025 09:48:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnI-0005eJ-DX; Wed, 09 Apr 2025 09:48:45 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539DY9VE023160;
 Wed, 9 Apr 2025 06:48:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=tGX6AyRJDv3d+7JhmMGrrdabwexhRPRK8nrYOtFLn
 Xg=; b=m9kiMY3+b/4q/jsEI2DsziOnfcWvApLQPLjKnkUNUaM2iw6yKfR1LpmBU
 5ytg2swckcUWv+4DoYOg79Ruqp04tPbMeHhCO+RuNmQWwF+eJuMKoJPYlzE9rSVC
 uWPj53pSGqri69ZKb87vIK5+lR/ic7yhQZnbkqlSR++c0I5cJjkelB2TRiT5jEJH
 nOh0O5t7hGxrOlFEKeHZMxFD95gDgEnm1rwiyKSeHR9Mljn/78A2rrfMEXHnGCUo
 R672jI2GvzmybzFpG1Kok5/QlKCLCJ0hbz54LO6QUfajZugYYQcX+1z1VnwTqL0B
 zwhVUP1i7sNrkynC8d35WYWLmnHBw==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazlp17012053.outbound.protection.outlook.com
 [40.93.20.53])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45u2mhj3jg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIg60FUtQiYxLWd547YJH2I3rcZ9/8kQBm65NHY+IG62wbJYAzkLkFCKX/J2v0CRklw0JrmZals6COLRmwSpDrNr/J5mnbMeGh8nxRo45tEY1Aux+o6rdVU+ItwMZSKivqjVy2KKpwdMYIV9sFOHkcxVF+XPXlLha0QLr9FA12rCCbQ1izQBhhK7syzP5NQqP3PtrlEDFQIuP9UUZtZsP6EAT9Bg4rsV+TyVxih0RH/zNpi/VGUcKr0pT5Ri3fK1RewpiJpIomT3xQ70+UQIVlRZGw30NHl4qwz37XY1a42E75KkwOFnwWCfQ3/+nD5IL1RwXldGcGw7kCUAnRkPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGX6AyRJDv3d+7JhmMGrrdabwexhRPRK8nrYOtFLnXg=;
 b=tOENgOFgUF9v8XtU5UZzOaTR0G4wZLVckJRAX0GbtK47gAyrdKnIlQe40biZEuZounrChcfNEBmJhqiG8yVi/PQ2rwN3gPQAVdGFFoAwg2bbon5ZoLUwCa2wLaf/mMA41u0f5wuhlctUdkkwreCiMzByrM2OSME7tKMHT134dOHo/d1BU7C/mgGz05xkl9yVhQQxk1/lYst/WJ2QDMkTFCej4PvdTkv8HRGS4uHT9VIPZDfxr3A5Uf/DjcH6mFqtY+cAeazb8aH3iCVa0Midou/D5J7us6YfQ50RCLzNjtiU+jzgAN3CP29Dw/NRUfl9JWKmfAFEET8i5oDOYDqWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGX6AyRJDv3d+7JhmMGrrdabwexhRPRK8nrYOtFLnXg=;
 b=dyeBxcyFesMOXYs7o4PjkNYaiuFkWDOCiCQ8A7CSpHxevEaXM1tXqvLOJmpHbXSrdzJHiDDr9N+8nahGbREIkwu0Yg+8gH8jnVeF55WKZrkBQZqyk3r9U+WqwNP2TiSBB4QpQtKRgFn3VpkXsO9+HacgKRAW1QqOBAqywnvTapvPkbj6C5OzuV3zCGG1pl0nI9LMm7MstuPl3MFwhpXBvFzqKEvHLEUn7bNIkoNeERDANfioaAz/lPYQnfGI/VFfycfmnUC+t6SIb1hiOFnN4dKDtk5/JkMZ5QKKgixU5+Hw35BC6y3GUNCxJKxIbYkQkQKrLk6rya6yJkBxR7LBGA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10356.namprd02.prod.outlook.com (2603:10b6:303:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 13:48:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:38 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 07/14] vfio: specify VFIO_DMA_UNMAP_FLAG_ALL to callback
Date: Wed,  9 Apr 2025 15:48:07 +0200
Message-Id: <20250409134814.478903-8-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409134814.478903-1-john.levon@nutanix.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MWHPR02MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: 545e7489-c253-487e-7a78-08dd776d3b44
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qj4Mxjtv+rF+knU10uYbBkbYBkntTDDtzqrLLR9M8Biaw7IDDEXQaz2u9per?=
 =?us-ascii?Q?yQ9eE4GtulO3Xf//J8q8mF+i6IDaGTaBPNo+KESovFF4vZZ64lX4wF05xT7G?=
 =?us-ascii?Q?FiFqVeT2l50wt2RUg9dYQJ9bqEgDjQnJVwlly4ksOAJIiAMbgi7UoWsI7vfY?=
 =?us-ascii?Q?0ZYy57KVZ6cxnwlooY2ThGZAsOitGaeXQGF6GY7rO8MSK9iS4UaCCSw2e00w?=
 =?us-ascii?Q?ze5Kj1gvPg50sHiDkyqiBwVEGLcKx3KVHCy+XLmsZ5fslt0wByVh4rNktpxy?=
 =?us-ascii?Q?eTWrdkguH19uwPACoBsrd9D+j46yoA443lh8hdw6nAnxVtaONJI33Wdb5f2t?=
 =?us-ascii?Q?+poXCYv/e52j3b44cNDzionmnZfVcRUK988/GJYOgVzl/4LPag3GVl6gAmB6?=
 =?us-ascii?Q?J3lzLaqr/O1kesiRAw23duWXhC3GAX28V94ZF9mYjjKW1xyOarFD+V0xiqVv?=
 =?us-ascii?Q?Vmhz6zqf5jnO0+aAXRVFG3p/Xa+tk4A1SkSbj68feCy4r9izTDua64RPB2nL?=
 =?us-ascii?Q?Qap1o4BmxMUMkmaeWJs9VsaSzaNRaP5p6EkjyZA+P97ICSgUZh00SjU99PZo?=
 =?us-ascii?Q?oQKPTRzpwRik2keIdDD0hx+CJ1CwxVFpjLuYQ4kLTM3QJteBwxbY4XzT3uFH?=
 =?us-ascii?Q?8b/DfWOiejSuEf1ecIKTgCRRp8lJCbi87SVCvTY+OD5iaHHKHbOUT93I4zmg?=
 =?us-ascii?Q?CPtY7gpNMmjxse6qze6AOCXHdYhU4g89VoRBA8mv/L1r1NHEGf7xrBVfrUrU?=
 =?us-ascii?Q?1j0IaS0NhBtiE254Mo8U0YMsYxi/9xJBeJy1SSkrBzuhjLNUp6Ir3a8ObEvd?=
 =?us-ascii?Q?B9nya4urZifNgQJYrxRTOvPE/dGQ2new7yFZB6jbH9xFmo14db4QmnGD0fE/?=
 =?us-ascii?Q?TszU2PZQXxyqAyPjaxX7nWa9Rs5kG8hkl7UR5gQz2roZPeToT/CR7KGIdPhl?=
 =?us-ascii?Q?NV72YdgqqB3/kaSmsGclQ34yjCCabXK1BjAJiAsaqmaOczFZidwtgd33aDR7?=
 =?us-ascii?Q?OB4kHg7fKjs12lxbcUh6u4Sh3JwI9B8/YKxTCLoFZhNV7Po+AThkNyKQnqpp?=
 =?us-ascii?Q?CvSfCGUJrucEEnCsv+UFgRHi/CpvjKuUI/q2xz0s5nzM1RMcaiumlCUAWLPh?=
 =?us-ascii?Q?85PRGtnAphcmltDl0uk2DnYAss5DpxJRtBq29m5+2fM6iMPvP73bQgAbmvzP?=
 =?us-ascii?Q?m84xNjzniia0b/olRFXZs2qn/pw3xbgRPCDCewvxRos2L21qu5Jyeh0/wHYw?=
 =?us-ascii?Q?/rxC3ciIwVsa7wRAcR/LEA2YF4dyVaeFMTvOscDunbnlH8z655hhfwdTTR6I?=
 =?us-ascii?Q?SIzZ/HyRAINiyGV58UpOypWjfHZ2p79y6MumCIxulCowLH4JxvxA8PI/zQAb?=
 =?us-ascii?Q?KSLNX/DJbQE4Dd4aZL5r5dxJiikE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aBk18F5kOwrfkXuWOMHvyT09LKT0rE2onJKhfwfu90F8IJ2YT4HapgBeBFaq?=
 =?us-ascii?Q?QuC5hpulX7ZyA6sdYedPEQhuGPln7tVpLo0lrkr3rnKVwbeZNpz/hbIcC4wZ?=
 =?us-ascii?Q?dAFho7BfSpQFq4gDcD6N2M+x8Qo6CfHENAIjRTv8jMXZ2QYkGrr7oJ5guJDB?=
 =?us-ascii?Q?fYIFHoCRk5vvd4q59MdBebNcOJD+l+HAXK03y6hokYnQwiPjzhNXnRfGopyt?=
 =?us-ascii?Q?Y1aXPsRBboCgbDjMqVaZ0gBS7IG22khp82JZg1m6kUT1VT1rqdQWdxXw1TWH?=
 =?us-ascii?Q?at1eTYnI31aPZ6T/YvzNoQBsoNjQXGdCoQImg0CDUgZ2jgit/g67//XBwqNx?=
 =?us-ascii?Q?06SfgrBI3u0X5OZQnQfQImQXW2Keig21ekJJYcIyDciG3JL+xhkko20MaZ3k?=
 =?us-ascii?Q?/e/fcyr71BX3JfUo2RhNMhmAH26PRhsaC8R93thgmLjPBjWkxqJenjwQtCsE?=
 =?us-ascii?Q?RtPRIo2JgFIKne5qY34l+BkmxVnhCCS3ALzOEdHRjaaQgn+myDTyBc0Qjz60?=
 =?us-ascii?Q?td0BoYRVkyhduFW5PPSd72unc+Zmnq8OnECtWr22r4I/ZFJE8YUAw+if9cir?=
 =?us-ascii?Q?1bwYpf9Cv7YyMuqKyELbyjqgeIuMrj/4IMPHxx3t85X7VulZXibJatDoRhNj?=
 =?us-ascii?Q?GTfBH+2/nQ7/BqGMKioEAmMUT65xK8QEHWlcK+SzYLNB7PIRrjwvLwLc9vIO?=
 =?us-ascii?Q?/1x16BeUPRBBxETetNDcnviRkY0C0sisL03U773mFZ41rJEiX8dduTHC9fF7?=
 =?us-ascii?Q?PijQDK0NbCNWv/pazJwJBQh2t7jBUWWuqcQPMP/OJGqBgaju63neon5lgF8M?=
 =?us-ascii?Q?e8QHR5oqIBk6192O/0eBzYNxM5WS4CAP7n4BtZzzkhITyIqqloXjnVNaBRZ2?=
 =?us-ascii?Q?c2OXfEWgIP/1vhm69xfBxnn3GJT7xYwNReC+BdWPkDT8XK0xERhigB5gQ+LJ?=
 =?us-ascii?Q?dyYwqXP9W9I72BNPqiqXAHgF5+zudw2ZYVMCWeryHugqgJYlt0GBuCckCVcp?=
 =?us-ascii?Q?geqtEzNrItiQaoKFrFEBuNtIcuEMOVxfJSK+7KG/o1lMxV84cKJyAqje3nW7?=
 =?us-ascii?Q?EpxOXyblQNnTnIl8oIxUXRB7Xi+h1ttf/KbTCIz1f852TW1Yrqm+YHSDhHtH?=
 =?us-ascii?Q?DVXNllmfebKE1DQqoMZ3M8HRXx5n8FwVZo+URcmXS3iULmwFFwJOfVPHshdT?=
 =?us-ascii?Q?0kDeaFFFfLGkOaY5OvNZVk9IoUEVronUmgc7HK99H/97shrzBFz48vWiY42R?=
 =?us-ascii?Q?qkjaLof+9Vx78snIgvPdyLBs56II7cq+wHUKxwVE1/nKElnkj4/hL0qyki4D?=
 =?us-ascii?Q?nGSiyuFxra0M0YktIPjFCMo7sGDoJOhlmQ4BiBPGkZAJ3/wTAFJhupu1VmrJ?=
 =?us-ascii?Q?zEh5chdggVjrhyX4b/+JivNVOIjvF+C+Isde8Yr1skID4oL5osJUtLFmFzsF?=
 =?us-ascii?Q?wnU+gV+QK34wBTjmft4YuCoFENd9xjcCWSbrIEYrzxZBC0kltDutKqcrrKFu?=
 =?us-ascii?Q?ai6mpZVygvbJFo9P+vinxtyMFICF5TCDM5OusKFoKlKvDC+i3XyotohiR6GF?=
 =?us-ascii?Q?OCpYMcsgHgu2Mi05VcAC9rDIOLoW58ObnIOQ59Oo?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545e7489-c253-487e-7a78-08dd776d3b44
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:38.7288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vnaqt3cqz0KcQZwm6ePquQ2z0XXljaplQCXDdJ12d5+GgqyFeiHSsEijc3RNGhHIGZmWVo5NJECE10xER2r/6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10356
X-Proofpoint-ORIG-GUID: YDVhwqmK5Iv8Lh8Yzdd-kIwSFgi8KzLc
X-Proofpoint-GUID: YDVhwqmK5Iv8Lh8Yzdd-kIwSFgi8KzLc
X-Authority-Analysis: v=2.4 cv=JPI7s9Kb c=1 sm=1 tr=0 ts=67f67ab8 cx=c_pps
 a=sf1zYAMyThzbrKU8SMWnlQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=4WNC9uKCzI0CgEDnVfAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use the new flags parameter to indicate when we want to unmap
everything; no functional change is intended.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container.c | 49 ++++++++++++++++++++++++++++++++++++---------
 hw/vfio/iommufd.c   | 19 +++++++++++++++++-
 hw/vfio/listener.c  | 19 ++++++------------
 3 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 625bbe82a7..37b1217fd8 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -119,12 +119,9 @@ unmap_exit:
     return ret;
 }
 
-/*
- * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
- */
-static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
-                                 hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb, int flags)
+static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
+                                     hwaddr iova, ram_addr_t size,
+                                     IOMMUTLBEntry *iotlb)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -138,10 +135,6 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (flags != 0) {
-        return -ENOTSUP;
-    }
-
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -185,6 +178,42 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     return 0;
 }
 
+/*
+ * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
+ */
+static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
+                                 hwaddr iova, ram_addr_t size,
+                                 IOMMUTLBEntry *iotlb, int flags)
+{
+    int ret;
+
+    if ((flags & ~(VFIO_DMA_UNMAP_FLAG_ALL)) != 0) {
+        return -ENOTSUP;
+    }
+
+    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
+        /* The unmap ioctl doesn't accept a full 64-bit span. */
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+
+        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
+                                        iotlb);
+
+        if (ret == 0) {
+            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
+                                            int128_get64(llsize), iotlb);
+        }
+
+    } else {
+        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
+    }
+
+    if (ret != 0) {
+        return -errno;
+    }
+
+    return 0;
+}
+
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly)
 {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 07334e65b5..22e5b16967 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -51,10 +51,27 @@ static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
-    if (flags != 0) {
+    if ((flags & ~(VFIO_DMA_UNMAP_FLAG_ALL)) != 0) {
         return -ENOTSUP;
     }
 
+    /* unmap in halves */
+    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+        int ret;
+
+        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                        0, int128_get64(llsize));
+
+        if (ret == 0) {
+            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                            int128_get64(llsize),
+                                            int128_get64(llsize));
+        }
+
+        return ret;
+    }
+
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
     return iommufd_backend_unmap_dma(container->be,
                                      container->ioas_id, iova, size);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c52d4a52ef..bcf2b98e79 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -661,21 +661,14 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        int flags = 0;
+
         if (int128_eq(llsize, int128_2_64())) {
-            /* The unmap ioctl doesn't accept a full 64-bit span. */
-            llsize = int128_rshift(llsize, 1);
-            ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL, 0);
-            if (ret) {
-                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-                             "0x%"HWADDR_PRIx") = %d (%s)",
-                             bcontainer, iova, int128_get64(llsize), ret,
-                             strerror(-ret));
-            }
-            iova += int128_get64(llsize);
+            flags = VFIO_DMA_UNMAP_FLAG_ALL;
+            llsize = 0;
         }
-        ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL, 0);
+        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
+                                       NULL, flags);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-- 
2.34.1


