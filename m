Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A840C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Vo6-0007C6-NS; Wed, 09 Apr 2025 09:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnV-0006Yz-T1; Wed, 09 Apr 2025 09:49:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnR-0005fd-Lx; Wed, 09 Apr 2025 09:48:56 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5396ShdK013354;
 Wed, 9 Apr 2025 06:48:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=nwmmnUnobENYkF8KYjPo7qqtQ42L2fuSLVTh2QfK/
 5s=; b=MLwADNq7mAlhQ/UhaUf577naDFSo1oueDh745lciWpn2aGOBK7t5EBksl
 4LjHBl/97WhRRMt54myhi3kmltQumZ6gY+zzQyiE0rkzzgxNK+/20YNQYblXRbGD
 Cl3tJXnrPO5vonHKJpSKOGHrMC1m9/B2hLCe8RScDenI9RYew7RDq+fjg/6iicB9
 strmST3gQfgZpw5N3FfKmBUcqfv84KZ4IqM5srvEuETv/OIqPIhV7z1etIEJK/uC
 GJBw0AOPQuhuNh4Y2pFtgGaPf9Qm4sbC00g6m8BS257YyqLh9Mt8gd34NXc9NRLK
 JOWIuB0nl2QHiRJ15nYHLlPo28CsQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45u420syja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mT6P3RLSiVWDjzXJEW/YqYxZrWsmtmxVqbAeGF+mLcJSEdOg6r7WjYwsWKiPwnRKGkkYkkOWY+oAMCZ9+XJv6vRq6U0PNIGYLENt3r7eoyGoS7dvXhpKXwGp62945o+x8qBXddQR1zB81SFqlI5CBUOQ1MmRbUDYTbEVRNSAXAPG5weh8U6HSdsCf1pVMiMfDmIV5IaahN6WuidxDKT0zU9P0IZ07HE8EkHQ/94gSwH0fHGtXCU8SjYs+vygJvARJX3caSHM1F+VWiMikex1UbNODI7t8W5llJrG8Q2ZScj6sPdjfAsXZ+22jMhMRcfQffanxa4PFhOw17lTN4exDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwmmnUnobENYkF8KYjPo7qqtQ42L2fuSLVTh2QfK/5s=;
 b=A1RBN8e38LaAKQJr9T3B1m0megbeURop46fd5ml8arhZ4QUwGJMtbdRdKRxuVuyQVufFcaq9b1EMEhGleu+9qiikh4GNYj93UlwziryFMm9DqHGfj/SGlD1w1foSPxe2Z6WfDSjp9x4r2aTvDyAO2ggvu9fyXrTf9qqkH6+tHLXQqH/9CQys27EmbKfXv3C0gaRzvafhle4nt7Acb9AucxRFWmmAVKPKSNMYmEddrdW3QI3zi9NL/P+pG6Lgxh/IZNSp7xjjH2ClOrDXLYtEQWIBtNWdZVmz+hC306d+jhLiFGTVN14GrwNAXJwf1f9vFWluK49xh01p6g8ZKizp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwmmnUnobENYkF8KYjPo7qqtQ42L2fuSLVTh2QfK/5s=;
 b=JIHMvIQjeCH/PWk04tEsA/bJVRy1f6J8lAZYq4Se3q5YqwnJQUwfHyS7+ucJG4NpoqVSHSrZeuE971rxfd3dIV6MTSwOV5dq5mxOn+2Wnxpfd7uzxKe2w6gket2kWBgXVTrR2tLVU2Wr54KIGM7QM1vGVHJtKpXo2YoZWXQHsyzjM7TvM+hwUdVQVjIHoxPgRi0HeXk1RjBE/oAYmGcJIZFhuFUgXI5lPEq/xu2ILysK7Fh3YVz0+bFJvu4g+w8+5VgKPK/R/+RbLEiq71mnn+IwanfBF0N1IlZvOmnGRj2knxg+dx/BYKzsYmtE6ycixF7CA8zGx+7FdLMosXA5tw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7486.namprd02.prod.outlook.com (2603:10b6:a03:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 13:48:48 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:48 +0000
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
Subject: [PATCH 10/14] vfio: consistently handle return value for helpers
Date: Wed,  9 Apr 2025 15:48:10 +0200
Message-Id: <20250409134814.478903-11-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dcffd7-f0ab-4b34-ccbe-08dd776d40b7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ISl6Uxr/KVP/jizMy9+fup5Ae6JnYl5NdQxI9rmZqTw0bBymiWkAmzCIMG20?=
 =?us-ascii?Q?lTKJcbnu91WEnUicHCEPAGK3Lcq7gNLN1yEmrVOST3o+TPF+bznwdLp6vFPM?=
 =?us-ascii?Q?rx/LXG1aU/DhtIimWsgwxRlO2z1tIrS2C+5DP0rKLxFEgH2NXof9idh7/IFw?=
 =?us-ascii?Q?IaAtE8+CmqfkH72KN2jZhbAhX0QmyRaDVkGXA2YZzBbgxCeaLinZgzuLbglN?=
 =?us-ascii?Q?daK6qoRxWe94v7+HgJFUY1ooSXXeZcV8QhaX3Rxih86z+xgmonoh5VunnM9y?=
 =?us-ascii?Q?l84zAcKuLKgsLekMlPPa5ZXtfF9Vv3oSQJWhS1UUuP3t+5qBYDFNNsQa/mw1?=
 =?us-ascii?Q?97VNbzSftzR+XzT3mNAGMJU9W5vtU/0pVal3B1RzdirhmwiG9hrmMskDmNnB?=
 =?us-ascii?Q?/8qZZaJWHCLCwabJinfJVXFcKbS7EsxCx7dJR89W97zpPUeHK1v2v3nrFu0v?=
 =?us-ascii?Q?Jvps0DDmVJkbF3qzrpRCoe0aLJ6eqM8HURCem5Slm8EX5s2k2U+1RWHssZtN?=
 =?us-ascii?Q?siyBnOqoZThRQb1wuV+smPUHJPltOsJdjlNN1xDc9Yu7H2K8ylXyyeNPwGHp?=
 =?us-ascii?Q?Iyc1rY3g94bq9qjmJTbwUDfAz4BtiCZ/bqM7B+Vm1vR99dfHPb8XnXsnyyLJ?=
 =?us-ascii?Q?+c+/m4td9+7gwJ9g+2E/MakMvtYR3nnaEf0KIDqQUyiUHeRwBii2Oiv33Jj3?=
 =?us-ascii?Q?+ik7tWBqWYV2gEcAmzp5h01FrkQHxwm0eL7Wkv61jNFqjGAnAJPglbmL0Z5s?=
 =?us-ascii?Q?IWaqcm9mPvaK4quEkIeqTQMrIeQsXnFBxGZuL6aqfdhOOK6dLrgpatyG9FXm?=
 =?us-ascii?Q?9CaTpyoPMXLJpxTA6DRd5Q9VMkK5cSGeEOKgWgouTFQrZSpP61c4UlfJ/IiL?=
 =?us-ascii?Q?NonPItBMRBGQafpEBlSahoygP20H8YPGKdZtzvIig8D/ZlzXpWNSTWXRAc6Y?=
 =?us-ascii?Q?pLHKHCiQ87SXhqhSH7Ln1MakZAuF/Hj16nQy1Jmt9N8DiqcZ1OoPhCzugeYv?=
 =?us-ascii?Q?NC9/Gd5qbF8pIGag58COiSxdVVVWN+31ZjDoHIZIU0eI2QH5KtIvT7SnHkqz?=
 =?us-ascii?Q?yo/iz/Fb553WHM9L6NiDgHs7wbnpVzDQnropjzbqQrx3KPm/HbIqAILZqWg0?=
 =?us-ascii?Q?FemnZ5ic74KFfNDDFYH/AfJilhSNBsHhsoe+K6B5TgqAH9Fb6XcoxfFD0WoG?=
 =?us-ascii?Q?I8oiuSltBjwoYr53HirumqZ3p0C6mSRlNnahwmuBmT02YBlrvvCiBdyMj59U?=
 =?us-ascii?Q?tLkMToOkZPstiUyN1rh/dLjSuMZxUdb8xbEEf/+PkeRWjMHFjfjUDF+3uLxN?=
 =?us-ascii?Q?Vh7zMddOKX08VICrLVzPFxbyAQ2Hycd/XIdC36+04/BDdn/oPmQ+BMdInM4o?=
 =?us-ascii?Q?MV4nPIYbo+Jae4wR14EggXRD3dLfWOqJhD768F5kS4LybVx1Yg4rpwGdJwMz?=
 =?us-ascii?Q?YNzmyk/x+4k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?23tuX3Pzk8aXIrz01ElEfWmPPjQrhNmHZR1JBz6jEbS0KIR/D9TjHa+lUGKi?=
 =?us-ascii?Q?1uvsj/Ay3HJs7VeCeaxWCZ0/5oov74VNfHx4xCowrQrTHJjizPnOH+qLCBCM?=
 =?us-ascii?Q?uvMeMQpBrPl6zCl7MoFTvGPsyjqPal7fQT5L6X7nSWnjsJnMiMGUevgmb260?=
 =?us-ascii?Q?GhVbvscVEme2R9q/vQ/o+4FxqM7gmgsOuIbZfiTlzl0Hkuv+Sc1aO1jeICsK?=
 =?us-ascii?Q?AcgzQQBZL50lSWcrU+t15eRILWSu54dsiJXw3miVBQHIwHs/0G2X+xlkHSBP?=
 =?us-ascii?Q?wjzAxzDmrDPiFtCfZ/G/DOMAb2CzzKO9pWBjkOj7Ynz666YJhmLf0xU3AOoo?=
 =?us-ascii?Q?NAZNOjk63hiEDgX6zTGe1h2BQ8B3bGZMzQfD7N28YZtAt4sBJtZdxOMtOTWM?=
 =?us-ascii?Q?PnFSsjAhENuJjMYJF8y0Kj3JORB99eF+mxqqwiQvJJL+9SRSRAJKp5L2Y4bq?=
 =?us-ascii?Q?UyaT+FDBcBt5jFaRPLt8opEvskmkAV1vN3aex7x8dYVKEtlmhj9DEV8dn24V?=
 =?us-ascii?Q?I4kbwTzN1XnWKqEgPFNHF4WnXooffpNEInGxdHN9+2RLnv0+gp5xwmukTaHg?=
 =?us-ascii?Q?4bLtCofhnWijcsBXi4lUWYyAEq/O3BwZWYz7ZfN+krhEOMc0iv+6G2Jbdip1?=
 =?us-ascii?Q?qvxbqnLxdTrVyiIAfikeOrqr84D5nHTon6hlAMtov+ZMAYICMtn3nifwv5rp?=
 =?us-ascii?Q?BY06qfEdhuZaHNwPdFEGLjZsYW8E9ZuniVv+rT3mfluIn4KEdlgpv15JAv52?=
 =?us-ascii?Q?084ZxVh4lzkOZYHJo3rxG8fvwjDYz9CGUtkBaGB+9oMxMWFQpXozurNyV6MK?=
 =?us-ascii?Q?jiI8P1sEW25SBshdcM4MYZPqqIXEnqMHnEpaA5UdwBv9zEaxE2BjtWtFT4OJ?=
 =?us-ascii?Q?Ho6UHadGeM7V4OSpCuEQtL82Rtiu5c2gMd1TbfKYaSPCUndxOh6O3sanb206?=
 =?us-ascii?Q?hHMhRBIlDRB6H+crd5qT/mZlCFaQC7T9pUOOgA+gVCGd2LN+iVG9n4sUDJlF?=
 =?us-ascii?Q?wzGdBuSaQDKZ+ieTFw5lT+Vr/AGpTak+y7+pT7HhGseVvQo5Ssx4BVHz710U?=
 =?us-ascii?Q?MslLSrz9YwDAoUEMpoLkcru9++4iI6r18tzhNltxCJGcoe82rDo7x8/FJruz?=
 =?us-ascii?Q?9KEwYBXHNOTXFVetQCnO39/RtdHQTbLNNUg/bk+dToh29ZxHrBJ/cLM/ZgFY?=
 =?us-ascii?Q?nzM46ll8HZX+8mGLKZUlhLP6uO2fIgXFE06ugvgb+9HgrYR1fpE0TAsi44IE?=
 =?us-ascii?Q?bv3GCUEZjnomOugJqx50HtiWL/vsRbQOktLzm65jO1BWrNSDU6EnzPEeAW+H?=
 =?us-ascii?Q?K8p2weWX+Ce/8wlZi9JSfx8lGiFVPYCHBrVzNqx99FNwMaloyhW71utXNUJe?=
 =?us-ascii?Q?b+Ahg4o5jK7hO4Iv1am03j1Z8AxQhzKBxIktkTeJUD9vzjS4SPmt+8ymwg0v?=
 =?us-ascii?Q?GSdoOXsNIq/cBe16BJ8mCLfJXgw/gTgtb8vqPzQ6B7d0my6P81yLCJVuu7Ip?=
 =?us-ascii?Q?xdBsAbMXRHaFd+5qY2Dh8xpev6tJbeHi6QKA+mULacClLYkbLQRLUSyfvvwu?=
 =?us-ascii?Q?egQmfJz7qFff+A3B5N5iC2vThUO48Jt0kIWD3YVX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dcffd7-f0ab-4b34-ccbe-08dd776d40b7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:48.0068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvVkqZPjd83VMYbE4QJxCFmxUqzbmxu9ET8zdJo5k31HxBSAnrIsCy/Hge45XoLFuFsJQvvSzwlg7hpxmMrYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7486
X-Proofpoint-ORIG-GUID: Mv3f3HDl2zCKDGwW74O2DKeogNCRyxMi
X-Authority-Analysis: v=2.4 cv=TeGWtQQh c=1 sm=1 tr=0 ts=67f67ac2 cx=c_pps
 a=+1/HLBYLL4tv2yjlBWnClw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=khE_JiE8E1OrqPP4vgkA:9
X-Proofpoint-GUID: Mv3f3HDl2zCKDGwW74O2DKeogNCRyxMi
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

Various bits of code that call vfio device APIs should consistently use
the "return -errno" approach for passing errors back, rather than
presuming errno is (still) set correctly.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ac53c43f2b..ddeee33aa9 100644
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
@@ -581,7 +581,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
             ret = vfio_enable_vectors(vdev, true);
             if (ret) {
-                error_report("vfio: failed to enable vectors, %d", ret);
+                error_report("vfio: failed to enable vectors, %d", -ret);
             }
         } else {
             Error *err = NULL;
@@ -695,7 +695,7 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
     if (vdev->nr_vectors) {
         ret = vfio_enable_vectors(vdev, true);
         if (ret) {
-            error_report("vfio: failed to enable vectors, %d", ret);
+            error_report("vfio: failed to enable vectors, %d", -ret);
         }
     } else {
         /*
@@ -712,7 +712,7 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
          */
         ret = vfio_enable_msix_no_vec(vdev);
         if (ret) {
-            error_report("vfio: failed to enable MSI-X, %d", ret);
+            error_report("vfio: failed to enable MSI-X, %d", -ret);
         }
     }
 
@@ -765,7 +765,8 @@ retry:
     ret = vfio_enable_vectors(vdev, false);
     if (ret) {
         if (ret < 0) {
-            error_report("vfio: Error: Failed to setup MSI fds: %m");
+            error_report("vfio: Error: Failed to setup MSI fds: %s",
+                         strerror(-ret));
         } else {
             error_report("vfio: Error: Failed to enable %d "
                          "MSI vectors, retry with %d", vdev->nr_vectors, ret);
@@ -882,17 +883,21 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
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
 
@@ -901,8 +906,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 
     if (!vdev->rom_size) {
         vdev->rom_read_failed = true;
-        error_report("vfio-pci: Cannot read device rom at "
-                    "%s", vdev->vbasedev.name);
+        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
         error_printf("Device option ROM contents are probably invalid "
                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
                     "or load from file with romfile=\n");
@@ -913,7 +917,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     memset(vdev->rom, 0xff, size);
 
     while (size) {
-        bytes = pread(vdev->vbasedev.fd, vdev->rom + off,
+        bytes = pread(vbasedev->fd, vdev->rom + off,
                       size, vdev->rom_offset + off);
         if (bytes == 0) {
             break;
-- 
2.34.1


