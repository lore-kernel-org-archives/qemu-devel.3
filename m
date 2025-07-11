Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9794C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDAj-00032z-2g; Fri, 11 Jul 2025 08:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uaD7q-0001vS-Tb
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:45:14 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uaD7n-0007ZU-DG
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:45:14 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7wvh6032172
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 05:45:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=Um/dx0Q0GGE54
 BqBCwT/RSqBMc0VrnQC3U0giGl3KfY=; b=ncEKcEIOdggDw3Fn6izgzDAevNqrf
 IsmTEKNp/nMAS/aG6m2JX/LnQr3Urz4llFjUBehxRvoDQjXP7AJwR5qTgrL+h7ym
 ZXmsnJzZQKprVr9jmtDAy+0RjF1oH4yHBndqRWlaed2MHNv+q4sD1T9rAlf4eI+X
 u36JXQIfeSFq6Xkz+GJ7pGXd/Koyv/u8yXj0IwUnWw6Bq9kmm/rLxOayBvAoko9V
 1cwTCCcUT0vmRsiDUGDzje16Mv8A4dj86J91VxB2fuzLfFVrCkqV5fHoYggUgwny
 NNc/i248snMcmqBCOYqxLRS62mlM7DXe5TzFs0DudOzXPOPN7LUW2nxqQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2101.outbound.protection.outlook.com [40.107.243.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q1kas38h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 05:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/wAwa7iY1ymhQQJdD6vrPdv3AylWAZYMih0vn8KIjhcRiUdbKHbkFDK2fg7+H6lg2U7rd7YCVoLajDEZ9aRJr8EG9T+ts31nEll513/IvQA4ImNNH6kJZzuEqwQeQ6n8Dpcm8O71m3gv6SRpHTvOzVjYRt7hhOk5WY0TAohZtELmoeWe4TOC0o731sNPjuj7ANqOJJbzRUJav6JnLxolZy+/VCfEAbQ1wqPucMHkTI+AJzu+/FSDwGFrUkveujlEok8BKb+9Ys+NwmQbmPbTwXrqPYmk8MEAel/lUVnnvAjphWVT/dsruRQPK+bzytBMYB+zBY8BX247/Hc76/vEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Um/dx0Q0GGE54BqBCwT/RSqBMc0VrnQC3U0giGl3KfY=;
 b=pUAaVdMLVMBfpo4ECbM0sn09zIPeGLQGhFrdKVzJCJbe3kObZLtVyvdqShEbNbPVp6yBwRmfcItW1lEmFnHz9/grSzEicTT00oN5Q6Tyj3PUyORbZlyYV5V6e0jzjQ5oYodLoJZ3ntP4oOP2cbGndbK6mkrrWjdvxaduzGwlimYmqDsaAGuZ+kQwecA2BmegMTCPti2zGm9UF03yKkIsZ/1oZgjtOecJynBrQZMc5FQoqhr9/c5LJvC2UkkINpiH0sKDEtSJdYB094mtVglZ8kD0nf/fOL4qbYsgB9qSZTsJAqgwc8sFHXhIBlVVnVi4D1NNK0W8o8yF7LEtGJHswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um/dx0Q0GGE54BqBCwT/RSqBMc0VrnQC3U0giGl3KfY=;
 b=tXVChAOpPa+eYXH9M4QCnzEiJi6H4MLSuImNhA78I4OmqvTF+WBASRbH6XeQ/7rCwea7KeOU1dJvizIz5ddWWw3ginf81OjGoafIOQmBgO1eh4EyaH1K0YGTy1EdseBHlD6mVfcvUXaxluv6QXtC5I+zj77mkHBR7hJ0RQUvYwq11EOXukJYC7dDxOijCS8BCkHRDXMj/GbW/aIpYPg6CCLcYmgZktGMh7f9EbnN8PRBCOQsQCHLtrGMnsn/tkv4dVDKEiN9omkkz2WWyAnhyX4OZMfajbklsj6Mdp7EhJI3vRADYnKLQRFhdE4OCPdz+m8kLZC1ivw9L1fxRWcKug==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ2PR02MB9849.namprd02.prod.outlook.com (2603:10b6:a03:538::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 12:45:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 12:45:03 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v2] hw/vfio-user: wait for proxy close correctly
Date: Fri, 11 Jul 2025 13:45:00 +0100
Message-ID: <20250711124500.1611628-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0030.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::35) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ2PR02MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af607e0-cda6-434a-19b3-08ddc078c1b0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C73wLMq4l0K2tzsr0LJVLluDCgJyO5hzwvPsFxLrjX6Oy0EQpmG2vIQdivHD?=
 =?us-ascii?Q?Mq8lYtNN/Tt9NwzHv7v7vX1QeACD8fFcD7hRK/e3gyYs5xKgk3fqwoXXcqaA?=
 =?us-ascii?Q?XoQXDUWMMcesVE+ggniIiTWx6TwGPMSO1OB7Ol67OJnGrGeraItLoDudSSgr?=
 =?us-ascii?Q?+tqAQA8ekR0igM+YgiLegSOpc+T83PaQAxeaq+xyb2SFUzmn6DGQ4u1OSuNG?=
 =?us-ascii?Q?+aSO0h8izJ/SEWUc9OwcJsYL/hxe9eu5mQXW7LZgmr24Sm7CBmxy4yPGt15D?=
 =?us-ascii?Q?LrfxDpjO9g68rycZFO7MrD/xCccZDy/Nk8HMSL9WyWVf28KhaY85jCwzsooS?=
 =?us-ascii?Q?WITeLSPmqXNGG6Vc76fo5ve1LWp8kRDLZegYMg3wNR3jqlWVcqxTmRB21mqC?=
 =?us-ascii?Q?wbhbB2FjHdfi6911rO7VeI8HQjUcv7fRwt3TIW3mb9qs2dkFPuNqRAHT46sz?=
 =?us-ascii?Q?SDirjGXoidMNDYn6ajF+DuxlFu5RllZdZggIq4s+O23JJq+SwCEk7e/3mAFW?=
 =?us-ascii?Q?ggm0ESoDHnB3Cyc/Rw5zAfUCkF8DiSpf068ESTaO4JI1yn5NmnVips/+5+oH?=
 =?us-ascii?Q?jpSiVy7Jj0SpPMZEQ6W0FLv+0OBbGBmsC8Lj41Ukow70D2EDamaU6xTL3/fn?=
 =?us-ascii?Q?w72ksO+b/VZco9Qjzx9kNFGO++mHQ8Ut72ZtUvtxFaTVBR8T58KVPMfEFnHB?=
 =?us-ascii?Q?x1REm5EGnaMv50nSgirjTVeII4Efm+MoFph+TDp/7oZute7opEqYVEbHzNEE?=
 =?us-ascii?Q?qU+sXnQMEirS44sb+hwAoT6tWo8JKF/qIdLlrdyF2k0S+b3x2mNXvuL1j+3J?=
 =?us-ascii?Q?4Om+3sIGJojvk28JD5LkOXDL+OIW2EzSCcfNf0v55QjWyaeYTe0B1gYbSMb4?=
 =?us-ascii?Q?SGnTV1nm9QR4LBKI59Wt4n5PYimZvac80SMRRyZ8B1vnhzdoSirx4TpI8nek?=
 =?us-ascii?Q?Efm1H4Tg+/z9D5S7ehdM42++krXcbaqJQJCsQINb/gUw2GEQoliIMCCBDiMi?=
 =?us-ascii?Q?j0EJDy3ecfb59nvK5ORaO2qhAjrW0WjMM6Zzv8Tet3yT6fdIfqAec6TTXa5z?=
 =?us-ascii?Q?NFHtG76ZzIoD/OEBBkqKPN62rVUtTvsDstDWVOm1O7hyyCx756RBLIizDz0R?=
 =?us-ascii?Q?M0mA9PC2x/zPs5i0B0koyjWg7EuCG2tx7Y4AqcKpYPey3VtQIXcmsEeY6BHx?=
 =?us-ascii?Q?Cpcld1Dc8F6PvnRI/CnGp+9Lmrevqgo/z5rha1ifhC7hPfCizQWCyK6SWDyQ?=
 =?us-ascii?Q?ZyvyErkJO6IbOmeP8HdTHLPwydBs42hgUxpZ8lgK7c82+y7IA31hPamN1eng?=
 =?us-ascii?Q?6e0xabzx3nFE0GVIckEs9Zg97iykMHDDX+0tNDCYLV3LJh0drXwXU64gnwW1?=
 =?us-ascii?Q?hsDk0ZmHDUEuogVf9Bad2ON0ODBZ57uNBSCZKS37JSk7DgMA3OIe/cm74LTx?=
 =?us-ascii?Q?vjM7UUCleuI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GgRVY5wtSuyKj1icu3+AQoWZEuFXp1PBGLHcBYbwDQjF0gGn7xSlr0XMj5fu?=
 =?us-ascii?Q?uDPvBUnfTwNV97DrSNmfF61XIico8Uo9Z0FmN8VbEas+K1gTdnZqR+O0u12J?=
 =?us-ascii?Q?fiP64VaVC7+IUeV3BP/v9feOn2uzZ1VgD76Gn4XoyOJUPY6NXd4SO8yuMLcz?=
 =?us-ascii?Q?cIUw304Gz3kCXuNf8l6IhPy2mZY8FcTqCdMAsc6mrLfQTla5LAhL/jFLRdtG?=
 =?us-ascii?Q?lbxT2CLqRisGjkyWClQtYLXmp5RQKjiloaVoqPWYLQwhC8SDOEUJ1jChSaoP?=
 =?us-ascii?Q?PI8ckrgIgxgtDIET31YqluQipgsXkAQVHzAJyGRYm39LIrld2y7Y5tCr685W?=
 =?us-ascii?Q?9ecfCGpJcpeRX3rEzNTVQFbtJsezsXIVL1VjXCpV5DnhL8rI3GSNpfinUkPs?=
 =?us-ascii?Q?8G8mq7T+yvS6cJDOPXCyqCA/R6s1+cpqBeshvbCAisG0H9/d6A13/sPsNwil?=
 =?us-ascii?Q?2G1BkhFqdD/G18rgWG9t6uiO448xxy1CJOznZIZ4xoBw2sT8cZtqzvOOmASV?=
 =?us-ascii?Q?cTCdEy5tmlkRQE5Yu2RHZ6VQBXOxz+Ewbmizg1nTlofbq3lOxFqTrRzRqWRg?=
 =?us-ascii?Q?TUeypga272dnJRqPQ8pPM7F32aB487cNOk9ec37FkbgA3fLevLKlqvcB97AL?=
 =?us-ascii?Q?eU83aiPtZMgtoFXQFrechUvoiDXNMm4QQHuQ5VVGlISUVeqOswdl/9vgvmTk?=
 =?us-ascii?Q?1LG4kmZFRcdZi4U6LLxb4SJdFM2uQ6Vmg/4/SqjvTppdWYBGB7Ba3kXcrc2k?=
 =?us-ascii?Q?zd9YBcECS7pEOHm6lmVdutNehVGd4An0JkNKdqikkL0mkoJ0PhWa1BkPmkaX?=
 =?us-ascii?Q?w7FoM5klqTfcACoQsK5IuV60O1JeiMQtibDSKwfjN0cukTnfquYc/Il9a3Rz?=
 =?us-ascii?Q?/uX6WHPLotyiUAyVBEzZOlroO+g0nTPk4Z89JqUoHwoxw9fvzbutFMf+nmtq?=
 =?us-ascii?Q?8p/7WiFH9kSM0oTIjD3QuYMg/cN23uAwBzl+Kzl7ub67w5mLdKuF2Vj/8Vub?=
 =?us-ascii?Q?SumdTS72DTe0KaUdIMUm48dYkNRkVYtRMtCjdWQ5UJRpgAPkNeg4+0mWD/Fg?=
 =?us-ascii?Q?Z5Z0fjIDg5uTjQPt23EPAi17BcKmUHxPRVSp1Es++JKwUGgt55Uqt43CHLeR?=
 =?us-ascii?Q?kYkLKOsERbxP6dT88c/j7b0hXEqTMFzaddkvtJ8wtII2Utcflg2yKa8S8tl4?=
 =?us-ascii?Q?ztNNErjJIKuTN9OfNZ8ibESfB1LurYiVq1BpE9bpVR5KjXL1day8zu+N9a/x?=
 =?us-ascii?Q?aQJtEkNkPRFuyHLgo9nkFgEllHU+PIiqutl6VxyCjPOwTWCrbLBWLsPocJqz?=
 =?us-ascii?Q?bgSCv+BxSBhk1Q2bCHzIV81fSdepP4GAN4JCncE6R1fXPfeADd2zvOeNpuBs?=
 =?us-ascii?Q?aTukdvBBXSHUT4j32V2Iin5iPU50wOR1g6h7vCmC2AQIHF8OIHwqgxIfIWDo?=
 =?us-ascii?Q?b9kRZPaY38X1SNB78gkIGGarWLJMnakxDqQdDhsyJYeibcc/LmcZnCuCf8to?=
 =?us-ascii?Q?0QFXtBiNI/lNEPn/Ba57xlOQ3M+1+Q9sxGgio3bhXsi0WDSNn3GlufTyHW6m?=
 =?us-ascii?Q?HxWVbyFXDB+uo22hCMZlalHk/6otZUoLDd0iS78t?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af607e0-cda6-434a-19b3-08ddc078c1b0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:45:03.6908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6abLsd/pDwQxqCgG019Ts8GLe1PggMum5cXgmuablINimGHHGT502Oi8UnmWLrYVWxVIYZjvQ/odfiBTKoKow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9849
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5MCBTYWx0ZWRfX0KstWrwLoN6l
 r0qJFAJf3Fz+FVMuElI3fogAsVXR2xVLioUKTA7soax13eFwnhr3SLdIVCWwIK8NjXwGJ+xC9WW
 gyTFiu/I+uOuT7RmJRIbJI3fKNsHWdNCkrSb1FQlrM6A0gdzAAjhqXx2EhxFKXKw/mtOpfOejU4
 svCE8MmTCcFd/bgNyRgmj1h8Yxt4S1nJtI0B/fJIJKEVGFt34qbPxEcRumjy/2fweSSiCseZT6t
 Zpjer6Mx1VCK9ismgDrlil9IeoIh5S8wdM8bOky8idytabUNbS0BHJPEdzO4i7KzNvlHeL/r9qP
 gMOymWo4UjNyHOT9BfLGn402VyloO4iv+6Wz5N8Jc9nKmlKMxly+jWAid9Z6pJsDB2vc3mPssRB
 I4NJPqlnYjWjWqTRZcffS1JfD4f/JLCl3gZe+6EqCEIEvbaY9wGAopGzArgCqKMBh0CfyfT/
X-Proofpoint-ORIG-GUID: jK5o1p_SL4E57XqhumE2mBEbUx0VaxrD
X-Authority-Analysis: v=2.4 cv=Do9W+H/+ c=1 sm=1 tr=0 ts=68710752 cx=c_pps
 a=JSo9Bu03w5K1EWcm171O7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=6aF94XPOkflKZwprq4EA:9
X-Proofpoint-GUID: jK5o1p_SL4E57XqhumE2mBEbUx0VaxrD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Coverity reported:

CID 1611806: Concurrent data access violations (BAD_CHECK_OF_WAIT_COND)

A wait is performed without a loop. If there is a spurious wakeup, the
condition may not be satisfied.

Fix this by checking ->state for VFIO_PROXY_CLOSED in a loop.

Also rename the callback for clarity.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index c418954440..2275d3fe39 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -32,7 +32,6 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
 static void vfio_user_send(void *opaque);
-static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 
@@ -492,7 +491,7 @@ static void vfio_user_send(void *opaque)
     }
 }
 
-static void vfio_user_cb(void *opaque)
+static void vfio_user_close_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
 
@@ -984,8 +983,11 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
      * handler to run after the proxy fd handlers were
      * deleted above.
      */
-    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
-    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_close_cb, proxy);
+
+    while (proxy->state != VFIO_PROXY_CLOSED) {
+        qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+    }
 
     /* we now hold the only ref to proxy */
     qemu_mutex_unlock(&proxy->lock);
-- 
2.43.0


