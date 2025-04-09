Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79672C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 15:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2XlT-0000Vs-AX; Wed, 09 Apr 2025 11:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2XlR-0000Va-EB; Wed, 09 Apr 2025 11:54:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2XlP-0000HP-C8; Wed, 09 Apr 2025 11:54:57 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539FCfLV026039;
 Wed, 9 Apr 2025 08:54:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=Njmn0D3MCYgvNt0
 p5SIxOLSdDSAE7fEvWAt4ty7kXno=; b=FsZOUGtc4co1ARu7t3rx+ijlBAB+DZl
 E8skhvSOZy31e7tiVgeebDry8mSvKkNupll2GQ1jBCqSBtxPxHOKziIb2LIHO0zJ
 FDvdrE1w/ZoU2b6fdZxZUECIUPJf8mduUtDy/IkgUPeot12QvgmBBO76nt167VJl
 dNpu7tLVbZUE5co8tegOOilksSfx1p4qQ10jv+gTfFS4zc6kUepT6bhCzGOc8aSp
 VkTDP0YN9kltOcKwMEV9lZaUNvBgeiqhgCrUy+aPdUukSob6z5kFzAMUUJMu7K4K
 fs3cQzLHMV3N8kYxbDW83+DtyijU2nR90Zk61CdWIEB4Xk8kLHfggbQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17011027.outbound.protection.outlook.com
 [40.93.14.27])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45u42xhn7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 08:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W79qJA0wY9k3F26KyYX0zP5eoHqzJoXlCTB4vaBqkT6sKeKWTpIqa8ASXu+BDDWYUkD902Av2mzBvnr2DzrQaasbp/XoOCXAkEXvyw4qF+4I5ptepxfdhM3fFz3womsvwDuDPpM+GPEVJO3VywywxmAXWe0SSuxXLWX5yqWxs0/h6c90C+fcR7lZxSPII5FJFz+BzVBbWialucw2sF7Gvnl7pnlPTgQFotNlz0rVne1dmva9ww573lTAHZe4N1vllpeQhStEAWaVrx4FUACtepAm0iIMaAM3axw8S1MkshdB2pnnfVuDkxuX+nIU0QmIzLCIhkXxZLuk7yHarL9eyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njmn0D3MCYgvNt0p5SIxOLSdDSAE7fEvWAt4ty7kXno=;
 b=zTbYFWpY8bUf2A7Oru3QFgRVmPKqU/VGzI0L95eoyXCEuAf3JtCAwfY28Q3if0w5eL3amoJU+ZqrRjF88J1Y5835yfgVpgFillAMqyysT3CCo6qjeX0Z3a3Zs/VO9HOfVupstd7F8Ea/4kjzpEhPerZuvB00OXltD1sZt1Znjppsyp6+5oBh7gdJMIjvTvhn/aW/UvT18x3bnqKj/cE0Cxa2LiES5sP0GsJJdH90DUebvmNbrFmmnmxdf0ia1aSHf7a3r5qbAS4PFBJfubSdGA+jmR8an7UzqPvi7t3//jLYKFeWwxCni/Ew9BOxlydd7Z3XkgY6rfb69M2lhup47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njmn0D3MCYgvNt0p5SIxOLSdDSAE7fEvWAt4ty7kXno=;
 b=MZzTnBw8oDNvbCYovnC7jelw2tpdXhxQP2CYR6UzmK6z2waE1rPgS55kpjbn02faMn4stjFVexYKkcabXxiGJTzUpg0ykdhYlQzihQj4mmptiIPIAeAPa7QNlhe2klN1hqwqN84Vpo8cJS+tsN2/ZgDPZHh+sb0E3WZgTROoxSSodrRLb5Z2S1UNnFtAURxugiaEQ51uJ+/UHX/pwrfPW8a/QCnftNCI6f9ifogf/ELlBqvkVUWiSWtZzwXcewLkhglBSvR3RXpn5FZ4D6K6YsM+6qXdVG1hyyQfIOLxSyRGiLwucA6LM9+aY+IZ4RxoD/nyiklGe4usH+PtvEW1FA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by IA1PR02MB9419.namprd02.prod.outlook.com (2603:10b6:208:3f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Wed, 9 Apr
 2025 15:54:43 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 15:54:43 +0000
Date: Wed, 9 Apr 2025 17:54:38 +0200
From: John Levon <john.levon@nutanix.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 11/14] vfio: add vfio_pci_config_space_read/write()
Message-ID: <Z/aYPiAhqSaIrc/u@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-12-john.levon@nutanix.com>
 <ed4d5a1e-61dc-4041-a24d-c1a0bd49fa3e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed4d5a1e-61dc-4041-a24d-c1a0bd49fa3e@gmail.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::7) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|IA1PR02MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a759d74-47a4-4651-b7e1-08dd777ed801
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QIIV4IC6w37ZAaeoTma34wuvdS1OQpiCxozVleGWlrwmTqAoH0gEevF7o0QW?=
 =?us-ascii?Q?NWD+orXdWqQDIHeG3loQaDdRudOzuESstXf+4cZ2GC09hCEoJgRtjhkf61T+?=
 =?us-ascii?Q?E5pbEAjzjI5ut9b5SjwomT/IFRnq1Rz6dUV/EIH1yMtzJD2WiqXumyN0eY7l?=
 =?us-ascii?Q?N/FcVWFrUXHg3pLDz4dG4WGsJBeAFDHxFwZClcPYBDuLrgHS51G+BH+MAAnv?=
 =?us-ascii?Q?rEzz2jop0s9+rceYySZdEBbc7tPKRywI8Qk3WhL9psC/NRIb5c0p/dIejC57?=
 =?us-ascii?Q?iTUYjkvjd7awxDxkqvwNH4gNTGr8LAoe88d6ptn49xphWPyQOivl13RtE4q4?=
 =?us-ascii?Q?Kj6Q1/aEvns9U15h7zeJ/U0ikKx6XsWQMRKqKkK5/dFKMPNN38uQa9zgWh7Z?=
 =?us-ascii?Q?JTcUwLoAZ5yevOYA6nKffM+4OgsA6Aaz+GeoUKxoeVuUNBQK/i1YGGf166/y?=
 =?us-ascii?Q?Yywmo4FCxKUh9dthq2kz4+iJslUHkQhS1IaY3WzsiEqD+/7Bo4BYfUrkuIlC?=
 =?us-ascii?Q?MN5ovCblAGt69hELKHM0s15k+fKrCrAvgBsO+7zkgRfejSbMv4oRtF6cbvX3?=
 =?us-ascii?Q?94BdPIV25lTf3pkE/C/WUmmtb+On7VLijK6ZljgzTyPNdqCv65o4iChRvNR8?=
 =?us-ascii?Q?TlgcK+ZBX+wXhym0Of4qh3uew+tNEEf9/bsvZ6nHaFFi0ITuLt4AS1ne3EfD?=
 =?us-ascii?Q?bgg9r9cgtePCC1BWQ9tt2rdFV8VeqjJvy/Ne4KHqRaazyE5MbUAMBIXlCTCk?=
 =?us-ascii?Q?ucq57ZuWeIqHNloOxbJdk4Eo0A9GsPzPT2Nq8qkDFAKDVGlQ4jTICWUtjYBl?=
 =?us-ascii?Q?Lcmn4xVhRn/92p41S2n2ILkllPRrjSDazwCQiOiY+sbx7m2+rV2BD8WK5qI6?=
 =?us-ascii?Q?we1Sl30DAFu/rVDBGBKbbrMYuiKsS144gwh5z6FfpHarFTJ+XGK+Fqjlwf07?=
 =?us-ascii?Q?3mIe4j2OlHMxBiEgifgDGVHYi4UREKxJj67MYI7CPM0qYawITMwOzv/6jjKi?=
 =?us-ascii?Q?ZU3QoEh1oh/hxrLT9j4CqSC/oYH85OzlEVo/k+LuxQS9Ec+Nx+z6M1x05p3M?=
 =?us-ascii?Q?Ohl+X+/HqWlu3Y8AuFk3xqiJnVlilUee6J5VgCepqZWL1nAtNz5ActsZ/CQu?=
 =?us-ascii?Q?nPOh13+X32ghCTe/ZlICYnkQUN2NuJRS6458m/QQl0K+vTXw3kgUeK8fR7my?=
 =?us-ascii?Q?L4YzOYGnhztle25pSTsnY9b1TKRjkac55EOp3QBkPsKTpDykCzis0c7P3PnR?=
 =?us-ascii?Q?pB3yMcBo/7vAkh318DSmkuavpHofPPmhHujSgHLhatNYHXaLd3RBKpJBzile?=
 =?us-ascii?Q?q6SzwCD2lcO52OLRfI24Au28nY8lr0wIFK0uull2Zppj8FPaS2UKHbP7teC9?=
 =?us-ascii?Q?AwK3fkua2b7ZXcx2KX69THbzVE9z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uQcKm9K/iceKzM25CZQqdeHI40xbuSLfbEUgB4mAR909Mluqka+hYdYzWzbR?=
 =?us-ascii?Q?YAWaKXUhyZJuXUVuzWqUofT5T7ZzU9vdN21PK2JWOvmk9wZPprZcouWzmud4?=
 =?us-ascii?Q?2FE0pg0doePe1Q6xzkKPSaePw+fJtn/FUlPRQe41XrVEyAGaOHT7SlNk5hnR?=
 =?us-ascii?Q?HOSLzxDEZFlu4+CeP+PtyOV65+vNUnJfR9zHgSAtSto+sNgkrnGWo7bDuoMz?=
 =?us-ascii?Q?qos1AEbIC88G7adJdkAbnnZw8RiexAi/bbxE7qanA7AcSf1btARVEDJZjmIF?=
 =?us-ascii?Q?teibD8LJGqFmfdf9CJmstL61Mfv0gmy1vy+kHXNkbvd/78cH1fuKCLzBGvTB?=
 =?us-ascii?Q?dEVXuxODx9yh2bcSPShOFDJxtGReUjnGODdP7YcILJn/gd+t82p8PlaQpFwb?=
 =?us-ascii?Q?QtxSQWESoHMaJJbiUsbXtfjygQ930xm68oDHUqLpa9RXvFggP5quymSQa6yy?=
 =?us-ascii?Q?ZZdyWY8EEDZv127X4P6H7tagLMFR18JfLUT05dAyTmE221JRsf2F304NC8pr?=
 =?us-ascii?Q?qo1knUiYLvJ+QnMRaRQCP4JPlIyY9Jb44eiR3EpwcmuqjTWD+BoWRGWDxfeW?=
 =?us-ascii?Q?ioT65uVw0lRDICbamIpAjdieVfqCOZWWmDfMYj/JpxSkrZUPv6EWuzfAzy3N?=
 =?us-ascii?Q?nnhXVI7N+lVZ+Ts0nimoUBTyVJudZCuKNGiHubf442kyOptoOMrGkgVUFSzl?=
 =?us-ascii?Q?XaLUesxJ5CDC75tsw/FQklxswwshy50D0I/lT4sku133wQa387ZUr6y8hDGG?=
 =?us-ascii?Q?Q4i6i/Z0QbDG7pJIW43Iu0Lx3bAFaNDuAR+aqkaPIpr7cBpTFFmjPXpvQy5u?=
 =?us-ascii?Q?7tV1XcHTSnKWtm5dtHzdGNd2QZ7BpjlGkPBx8GesKR7DgrmUw9yN/sBfIzus?=
 =?us-ascii?Q?nSVSSy76ey7RWMgE+2SJijKq6w1zOE3pWml8kR3DAgd94lV3VD1jizvQ3eOG?=
 =?us-ascii?Q?ijXSp2v4m/EPo/uDDok35bK3KNVw875K65Ty5FsCZxk0W77YIoHyuNxbD24m?=
 =?us-ascii?Q?bDedk2PkCR2yU+Auz88Yha/hKGyvRo4yEcIbRnx4/DB62k1gMQOjeTfL4njH?=
 =?us-ascii?Q?3KNV5rp0xte+L0yFf63BCkPHPM0HI1xUmopZ0GdAN/dIdrV/XF+mZU6ae1W4?=
 =?us-ascii?Q?G5/F7V14MU2uZ/MMtu9LIHztJz2G8xLNoAZvbVDCDCEr7PxvDyKmvuZGUeDr?=
 =?us-ascii?Q?CC3zHE+lcqBpJczKgL0JdWXgeTzGqdV0HnAiBbxYp15S1WpEUEzm/FnrMA3N?=
 =?us-ascii?Q?NZ1TYSxM4Lbofl+FMGNt5IZnZqtCfJ116WGonUtvThrAd57JUur2BFkyFkWR?=
 =?us-ascii?Q?kvwjf7C17mJSkZ6nwwZL5LnPxKgyGEMpiVJ2KtZiNe2DQymTAaMdUiLdDNY3?=
 =?us-ascii?Q?hxD5/qdxhqlTjMRDIx5QNfh+RSwSXwvb3hNwjW9aK98SDngOeIm3RAekphNT?=
 =?us-ascii?Q?plfLzWqZtH4lTG7gMJHxXnoaWDlcw9XRWVzF2ggWJ9OGUoXwiX0JajRHOQIr?=
 =?us-ascii?Q?anULPpaGSw1c6Cb1DiySMcBxhGrZBFqhec+eTUfGuM0hMbV9aUOqZtWhPHPk?=
 =?us-ascii?Q?r2WGjtmVbFs4lgWGvmNx4xPazc44YPFTjJYxelK3?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a759d74-47a4-4651-b7e1-08dd777ed801
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:54:43.1365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFK/KpRgiOyokgqkzTBbVtoDpE0V5t1E2xTT7NZ/zs4iTz4llePx6/KHGsWnC71dSaL2E6Theitv6YqJGuyljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9419
X-Proofpoint-GUID: wdik-_QPFUW-zNJbkZ2SB2a_iDg9_BYx
X-Proofpoint-ORIG-GUID: wdik-_QPFUW-zNJbkZ2SB2a_iDg9_BYx
X-Authority-Analysis: v=2.4 cv=LMxmQIW9 c=1 sm=1 tr=0 ts=67f6984a cx=c_pps
 a=B/o3nIjBIeux7E2B8s4M4A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=HUtIVMVQOywXkrjS5J0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Wed, Apr 09, 2025 at 11:51:09PM +0800, Tomita Moeko wrote:

> On 4/9/25 21:48, John Levon wrote:
> > Add these helpers that access config space and return an -errno style
> > return.
> > 
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> > ---
> >  hw/vfio/pci.c | 134 ++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 91 insertions(+), 43 deletions(-)
> > 
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index ddeee33aa9..c3842d2f8d 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -964,6 +964,28 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
> >      }
> >  }
> >  
> > +/* "Raw" read of underlying config space. */
> > +static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
> > +                                      uint32_t size, void *data)
> 
> Returning ssize_t here might be better here to avoid casting issues,
> though we would never read/write something exceeds INT32_MAX.

I considered this (and the later helpers in the patch), but most of the existing
code already uses int. Happy to look at fixing the callers too (e.g.
vfio_msi_setup()) if that's everyone's preference.

regards
john

