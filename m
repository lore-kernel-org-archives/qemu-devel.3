Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A922E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUeA-0007BT-7s; Wed, 08 Jan 2025 06:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdf-0006Vd-Dx
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:20 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdd-0002Hw-9b
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:19 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50881hho004556;
 Wed, 8 Jan 2025 03:54:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZnGB7j6yjuAFNZMfhz++dR+OD+RYXIWGIqPPWhnna
 8I=; b=Os6xWpXepdTUtzNMD+dlitHUoGWkbr2JN015uuxTZh4F/Cs+uRoBbfH7s
 3KFm/3BIVmgBjxAPn6c5GPQPU8sirroiq996lEluIjb6KZu7MllRJ0pBk+ddn1zl
 I0KKukYIah9Hnz69mfo8BpQA6tswbPF5Dp1rTX+E2+HANUbEalBuyhYl6PkxsanA
 4TsInSdKxhHW3oGbg7jgOGlB04PxLih0KCJzpDgxHhnB6wIasyNOpoef2/BCK9BQ
 /vZxKAnnqpUyqXVGt/BWnKJHP/BPjpMZpUpr8aQqhTls7s71lA1VDYn4UOYRLdMh
 uVi695CHttdZZy6RxqICCA/bZ25nw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y3ynrwf1-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:54:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbhobrSyCN/n1PmNl9tmHKyx1AZbeMhJR21LUwQjKgSPI+YOF7cmwiJTkRjWRQ5gXy1LKdkTzCSKIg6ZX0mqDe4WE/6fmcsvDIVfKth3dQ+hRG7BNsTynhfw7IYcwPAzLitBiKsXqek9j00BEoGlmz3IEP3Ij8kW17VJKyccpnmplGK/MzpekOH+ZInkJ3g7LybVFbbtoDPTpThfu4ZXwNbC/XLUcAgIl+T+sLXAYI5gYpNBSnwV8XPvp+Bqg1a/4TYvqL2LwznAhbf81ujPeAbG9OQ65K5Yw/IyXJdwtn5v1ATnexdR2c/ga7OZTTNl2ACBuCcyFWEV33KomaejqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnGB7j6yjuAFNZMfhz++dR+OD+RYXIWGIqPPWhnna8I=;
 b=J2s1b7s0noImallteVUZ843cSGUNhWnep8nmLawdMb1gCEKoLVFEMfIyLxQT4zKhPvNuSl7kONHtbxGjg7ifYofAgD+37hmnYmG77v03+/0/a3fn9Duyb1tu5KP1bX38/Hz2ARMime3uSi72/KHiOlrdwP5j8F042stTAGFZMPNllHXTZ+xzNgnTMAtC8ee14OTj97Z1moLszz+pLkklPg2OyX/pO1UAQEh8EdpBkAYRJbJMiMwmIvJod3688RZ8OpnqYJurA3itHr6H9reNg4ZxQ+0lBovmSjOZpzluhH+EdYoHHKT5uTGic6dod1OxZwoRjcvT9uEt4NO+eghyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnGB7j6yjuAFNZMfhz++dR+OD+RYXIWGIqPPWhnna8I=;
 b=UaV7hNqm1A4b3KNCXdZP4+m8wmP/eksleBCiSsj4cU30rB2opElabWTYsO6bcRO2fSX/anj6I+rcvSxu9GiovRd0ZVSwYJLBwwaQxPO1DU/hPj/Zd0oIpvkIbPfcEqjy1hBM3+xW2Mha0rFNv8oNdCuB7CGqYIkUycNVIBdLbLlgAGp4c21HbAj5k5SgCOewqXDt9LBVWOGmd4jPfGJDowC31UBb6N70Rd/lQrChSjLMUzJTEw0qZUsKZiYDl5CyuPlAE3bhUh/Ed+vIpSF205r19k6eDbScUPkHxgjZ7fI10JXPQqjkZagu2wNMH9u74UULJ4A4o+EzbILGQR2Wgg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:54:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:54:04 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 26/26] vfio-user: add coalesced posted writes
Date: Wed,  8 Jan 2025 11:50:32 +0000
Message-Id: <20250108115032.1677686-27-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 073f55f8-3c9d-49e5-6961-08dd2fdb25fc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WpwHoAC06ex/XRxMg7SmVjjX7ykOAEYlVhvBn/ILgkTD2bBkh2GuWEdTuPtU?=
 =?us-ascii?Q?klsBgqSEC/NAmzQUi0VmQVICgTvw6okLRB6fwtASFRseUoSNE6+wrzCijg7J?=
 =?us-ascii?Q?X7Kv0kRdfcQjAEbqEyUjohewMlgAi1WYPVTLXQUVwu1pX61NNy5JZjTTJPgF?=
 =?us-ascii?Q?A58txdB55DM0XyvdfdOpB9fEIY+aBMhq08mUXX+Vp8SnjQmXlUQbttsLZDga?=
 =?us-ascii?Q?GiEjW0mlnAE1W5BjTwdN1tlHczP92ESJuin5yJxRWuam/1hxCFM/gVTnLDsp?=
 =?us-ascii?Q?vy+Toi4NOQ/qcNFyNQfNNjs8g+QkQw8qlqLINHjSevTWbmdeFH4G2w1z18Rm?=
 =?us-ascii?Q?DzZLCA/sGoq/pn01jaO+c85UoN0wKjxrpwhrYsvw20ziAuFMFKGw15pB7Ot3?=
 =?us-ascii?Q?0DMuKrs5lZFrovNLh5RQPWNOJ9PfMUItdJKbsfo8so6C2gW9Gm641MWu7Q0I?=
 =?us-ascii?Q?dEvLJDFEY8svU/COgl/fzo0/pYTGt2nyZXLh0bC17tQEfb6dTWfTJ4Y4tX9I?=
 =?us-ascii?Q?gvp+XjehfcyuZ+2iGrMUUerYHZUV/lbDWpxRzIEJe3ydky1wUWsRA+Iv7fXX?=
 =?us-ascii?Q?qPmy2ZraMfHAc5jCp62U+RDpKnLxuhotPZcnDm1MNDAUBT+jMPD999chtfwN?=
 =?us-ascii?Q?aQE1hpdMsmW4doVZ79ilwjO8uL8B8S8uANIvj6iE+4ZJhP8YlOJWMHJ4v39U?=
 =?us-ascii?Q?e5xOaYdw0xXkTyW1BFDYTVNVaZ6PhpjnwGM6dZp6l78YrB8JHZuMiKw1YeQd?=
 =?us-ascii?Q?8ivC7fNcTqnpn1Xy0aQ18F5oVwkNSto201e6wfJqLdDopBJcVd27cvf51jLD?=
 =?us-ascii?Q?mCPfsIFo9PfAZLypdAx+F6H+abcJu/XVrfhTAWH/lBLiLiNRrfgxwUlC+BuJ?=
 =?us-ascii?Q?l/SufQgXZAy3S6KTBN96pRlQcpafYg7AEcSGGFsrfqPhCvBAqlCQDv5f6SSN?=
 =?us-ascii?Q?KNB3rY2ncc9/WNlj2/YQrGCAiGjRfw/YJDJ9M7oFDjfpZ4k26B0hIvz4kEAs?=
 =?us-ascii?Q?nDu/KUIeCd8u5/CUwhiPDKwi5pP16zvF6KhOjNamPqZfM+yJXNJMtpuw+JLX?=
 =?us-ascii?Q?xitDRweL2zaKgN/ZiLHmeR0WVMsStFhM+D2Ke5GwKIUxbzBUqGJ1FVpo2T/5?=
 =?us-ascii?Q?MLzKhf5GTCzAwQfi5cIDVuca7VAFNj4Yt7Wp//VMnf4AjL4yqWWTPuGfiPvA?=
 =?us-ascii?Q?DpccWx5cLvvLG1WDIHTd0q7iRvdDMLaXwg6lJd6mMT3HuxoQtM/9mWareg7v?=
 =?us-ascii?Q?wbnR4bwoF6RSFQN2YPkoO8mU2LXuXJooyEmwG9xVcxtWyKsasYCus/p+PiEY?=
 =?us-ascii?Q?XWYlvLdwgValDIiGanNamF+DhxilnWkrEgIPJ5+cJKu9Rx5Z5VOulOgV8Rau?=
 =?us-ascii?Q?M4WoCbOPRDFTIRf2xGmFJ4yEIZsE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?za9X+5LOxxAuBOInrv2RDjtPmEFocTcASvsik/Rd/LUYZIg89DbCWOgEI6xN?=
 =?us-ascii?Q?cnXIabugpzL6iXoftJIUAUihFgEYQT/bwMnbQQ5jOU3yNOLl1medcTV56CX6?=
 =?us-ascii?Q?dfpbrpNr/aV5HEI6aL76pfjunaJnXEnJX2UiCE0ZczAY3A7y6NNwOlr6otKk?=
 =?us-ascii?Q?laE7qcreNdqXQ3ogFyMFr8n5Zmi1lX0JXNF2VVe2veNPA2aaGNAiq8DtC8Gn?=
 =?us-ascii?Q?vBweJv6YKxj3mrRhMk7ap7dO/hoVrIvsnCThzKbJb72Gh7jSqe2yU2YQFQHM?=
 =?us-ascii?Q?6Uc7wbo8f4kmZMxM5qQbaFdD5DOjmqAPOtGYHPWwOYKaKGezOtzLi8OXjtNP?=
 =?us-ascii?Q?pphLkK/3XhfbSxJT/LLnY7Tg19ch2nKmKnZmXcohMqeqBRTU6QQEA5kMTsGG?=
 =?us-ascii?Q?EMWqv2F0daLVym1R2uL0iiAqYiw3G5Px2CBx9T0cA9zT4mF9cNMso79hKEGY?=
 =?us-ascii?Q?nVt8trJ6sBSbtVnyVS71cHj+JMfpwfB+2LXBpqwIvCD3upHGg1dwXjbX8ulB?=
 =?us-ascii?Q?i98FEpeTmbXgGChfZRqTldSkxyJcbkP2dC+LbZOu5B5Jlw2Y+GoZ6Rq48j4G?=
 =?us-ascii?Q?De/kF2oI6HlPQ4v0y0g2L7siXL6aKpXmDftWYluB/NTLhQDiZSO+Dd1NEWaL?=
 =?us-ascii?Q?eDdAl5tjAeBX/Sto1TsVMCyGKyLMv6P5UDhbX+V/wojx8cKOmDNWam2Kj+SA?=
 =?us-ascii?Q?Cty4ZJJsBZqcPvp0gcR9mU0mapsbnY8MVP2hAp/CsXyp3PkKZDCZVkxJsxN+?=
 =?us-ascii?Q?g5WeEAGf20Aw7SUwAiy9vct6IynnUHJQL2HnMSgkUTKCAVOm4Zuv2OGrPSXT?=
 =?us-ascii?Q?FbKthfbI2K9M9vh1qLTPNDK8651iGwGXfYhk8/cLo4SvFlUAidrY83h3aJta?=
 =?us-ascii?Q?WDc/BN+cvnaketUuAKqmApNtMhdQtzkMA+f7JpSvlS282dZxWB+zyu8N3mr1?=
 =?us-ascii?Q?fNXZg1WVxidOTnANNrPp9zmMvaHvhoIuEG79yvxCorM48DesrPDKaXh17Piw?=
 =?us-ascii?Q?V1zZ0UZhRsJosdq3XrkS0KZQ/uHyXNeDuGYPfc304Dj4OPDMl0ry2lWmv38f?=
 =?us-ascii?Q?Mfb8hQF04sv2a7jCcjLjktMpGyGr6mMFxhOe4xLAMKY00bu3SMuUOfzsUxEL?=
 =?us-ascii?Q?b02r1tlqIwyMqyXnxPTJbv8pxxaD7hTzD+kEJPqSSPhfboTy9Y+JZEcygraf?=
 =?us-ascii?Q?91YtFXRTH6+0FfbWghB3wQwz2ag2Dx0gMUslGJe4F/VI6+U0eluyWjG3wdVw?=
 =?us-ascii?Q?xoaw1bs2sJLCTvgwECKE26x+5+LTPEBWrlJJ0nv3Kcdrm0+Y9CLiMItd7EO9?=
 =?us-ascii?Q?EKvkbkEHgkK3y9XRCf24Q2kDoR+WyH1BbIlCP3xRbLGGFoMMJoj1ZjLp14TH?=
 =?us-ascii?Q?TGH0sj0Ii9tuFRMJSyQIcSFh/YA+OWCCWqAcjyrnskFZEd0IHSSAYu4+WrZ0?=
 =?us-ascii?Q?2AmKk+ogKFMMqvVvVQvyUCFlGSz1D0utetMKDr27Ihwa6D9xe+1A908PQifP?=
 =?us-ascii?Q?L1iRq0EfWAqurRZcOQtJh0IpDlE2Cpeqe0u6VYE0b2sfc85gtitetbDq4lII?=
 =?us-ascii?Q?IOi7ut7DKK7yvULHxUWSOSE5ZPW8kyhyE32IDs7R?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073f55f8-3c9d-49e5-6961-08dd2fdb25fc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:54:03.9478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwKZDt2XPLVSCw6e/wEveygWbMrlRO3FzRK8tFsb1aPddeGVkk5s4VBwd3yIPjWkWg6UV0XUl1u2rxmZaOMwjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Proofpoint-GUID: QiSurhCSaSPczzfheMSal95rZBSVTxUe
X-Authority-Analysis: v=2.4 cv=CrlFcm4D c=1 sm=1 tr=0 ts=677e675e cx=c_pps
 a=98TgpmV4a5moxWevO5qy4g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=oAmoKkZGSHXUR1tpXt0A:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: QiSurhCSaSPczzfheMSal95rZBSVTxUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Add new message to send multiple writes to server.
Prevents the outgoing queue from overflowing when
a long latency operation is followed by a series
of posted writes.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/trace-events    |   1 +
 hw/vfio/user-protocol.h |  21 +++++++
 hw/vfio/user.c          | 131 +++++++++++++++++++++++++++++++++++++++-
 hw/vfio/user.h          |   7 +++
 4 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e3a7f82550..fe9d797af7 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -192,6 +192,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
 
 # user-container.c
 vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
index 607e0f4b7f..22e3265f58 100644
--- a/hw/vfio/user-protocol.h
+++ b/hw/vfio/user-protocol.h
@@ -42,6 +42,7 @@ enum vfio_user_command {
     VFIO_USER_DMA_WRITE                 = 12,
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_REGION_WRITE_MULTI        = 15,
     VFIO_USER_MAX,
 };
 
@@ -75,6 +76,7 @@ typedef struct {
 #define VFIO_USER_CAP_PGSIZES   "pgsizes"
 #define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
 #define VFIO_USER_CAP_MIGR      "migration"
+#define VFIO_USER_CAP_MULTI     "write_multiple"
 
 /* "migration" members */
 #define VFIO_USER_CAP_PGSIZE            "pgsize"
@@ -221,4 +223,23 @@ typedef struct {
     char data[];
 } VFIOUserBitmap;
 
+/*
+ * VFIO_USER_REGION_WRITE_MULTI
+ */
+#define VFIO_USER_MULTI_DATA  8
+#define VFIO_USER_MULTI_MAX   200
+
+typedef struct {
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[VFIO_USER_MULTI_DATA];
+} VFIOUserWROne;
+
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t wr_cnt;
+    VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
+} VFIOUserWRMulti;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 217d0e9ea4..128a65a3e7 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -26,6 +26,7 @@
 #include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "system/iothread.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
@@ -58,6 +59,7 @@ static void vfio_user_request(void *opaque);
 static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                  VFIOUserFDs *fds);
+static void vfio_user_flush_multi(VFIOUserProxy *proxy);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -462,6 +464,11 @@ static void vfio_user_send(void *opaque)
         }
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, NULL, NULL, proxy);
+
+        /* queue empty - send any pending multi write msgs */
+        if (proxy->wr_multi != NULL) {
+            vfio_user_flush_multi(proxy);
+        }
     }
 }
 
@@ -482,6 +489,7 @@ static int vfio_user_send_one(VFIOUserProxy *proxy)
     }
 
     QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    proxy->num_outgoing--;
     if (msg->type == VFIO_MSG_ASYNC) {
         vfio_user_recycle(proxy, msg);
     } else {
@@ -589,11 +597,18 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
 {
     int ret;
 
+    /* older coalesced writes go first */
+    if (proxy->wr_multi != NULL &&
+        ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REQUEST)) {
+        vfio_user_flush_multi(proxy);
+    }
+
     /*
      * Unsent outgoing msgs - add to tail
      */
     if (!QTAILQ_EMPTY(&proxy->outgoing)) {
         QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        proxy->num_outgoing++;
         return 0;
     }
 
@@ -607,6 +622,7 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     }
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
         QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        proxy->num_outgoing = 1;
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, proxy->ctx,
                                        vfio_user_send, proxy);
@@ -1122,12 +1138,27 @@ static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
     return caps_parse(proxy, qdict, caps_migr, errp);
 }
 
+static bool check_multi(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QBool *qb = qobject_to(QBool, qobj);
+
+    if (qb == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MULTI);
+        return false;
+    }
+    if (qbool_get_bool(qb)) {
+        proxy->flags |= VFIO_PROXY_USE_MULTI;
+    }
+    return true;
+}
+
 static struct cap_entry caps_cap[] = {
     { VFIO_USER_CAP_MAX_FDS, check_max_fds },
     { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
     { VFIO_USER_CAP_PGSIZES, check_pgsizes },
     { VFIO_USER_CAP_MAP_MAX, check_max_dma },
     { VFIO_USER_CAP_MIGR, check_migr },
+    { VFIO_USER_CAP_MULTI, check_multi },
     { NULL }
 };
 
@@ -1186,6 +1217,7 @@ static GString *caps_json(void)
     qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
     qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
     qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+    qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
 
     qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
 
@@ -1454,19 +1486,114 @@ static int vfio_user_region_read(VFIOUserProxy *proxy, uint8_t index,
     return msgp->count;
 }
 
+static void vfio_user_flush_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    int ret;
+
+    proxy->wr_multi = NULL;
+
+    /* adjust size for actual # of writes */
+    wm->hdr.size -= (VFIO_USER_MULTI_MAX - wm->wr_cnt) * sizeof(VFIOUserWROne);
+
+    msg = vfio_user_getmsg(proxy, &wm->hdr, NULL);
+    msg->id = wm->hdr.id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+    trace_vfio_user_wrmulti("flush", wm->wr_cnt);
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
+static void vfio_user_create_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserWRMulti *wm;
+
+    wm = g_malloc0(sizeof(*wm));
+    vfio_user_request_msg(&wm->hdr, VFIO_USER_REGION_WRITE_MULTI,
+                          sizeof(*wm), VFIO_USER_NO_REPLY);
+    proxy->wr_multi = wm;
+}
+
+static void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                                off_t offset, uint32_t count, void *data)
+{
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    VFIOUserWROne *w1 = &wm->wrs[wm->wr_cnt];
+
+    w1->offset = offset;
+    w1->region = index;
+    w1->count = count;
+    memcpy(&w1->data, data, count);
+
+    wm->wr_cnt++;
+    trace_vfio_user_wrmulti("add", wm->wr_cnt);
+    if (wm->wr_cnt == VFIO_USER_MULTI_MAX ||
+        proxy->num_outgoing < VFIO_USER_OUT_LOW) {
+        vfio_user_flush_multi(proxy);
+    }
+}
+
 static int vfio_user_region_write(VFIOUserProxy *proxy, uint8_t index,
                                   off_t offset, uint32_t count, void *data,
                                   bool post)
 {
     VFIOUserRegionRW *msgp = NULL;
-    int flags = post ? VFIO_USER_NO_REPLY : 0;
+    int flags;
     int size = sizeof(*msgp) + count;
+    bool can_multi;
     int ret;
 
     if (count > proxy->max_xfer_size) {
         return -EINVAL;
     }
 
+    if (proxy->flags & VFIO_PROXY_NO_POST) {
+        post = false;
+    }
+
+    /* write eligible to be in a WRITE_MULTI msg ? */
+    can_multi = (proxy->flags & VFIO_PROXY_USE_MULTI) && post &&
+        count <= VFIO_USER_MULTI_DATA;
+
+    /*
+     * This should be a rare case, so first check without the lock,
+     * if we're wrong, vfio_send_queued() will flush any posted writes
+     * we missed here
+     */
+    if (proxy->wr_multi != NULL ||
+        (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi)) {
+
+        /*
+         * re-check with lock
+         *
+         * if already building a WRITE_MULTI msg,
+         *  add this one if possible else flush pending before
+         *  sending the current one
+         *
+         * else if outgoing queue is over the highwater,
+         *  start a new WRITE_MULTI message
+         */
+        WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+            if (proxy->wr_multi != NULL) {
+                if (can_multi) {
+                    vfio_user_add_multi(proxy, index, offset, count, data);
+                    return count;
+                }
+                vfio_user_flush_multi(proxy);
+            } else if (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi) {
+                vfio_user_create_multi(proxy);
+                vfio_user_add_multi(proxy, index, offset, count, data);
+                return count;
+            }
+        }
+    }
+
+    flags = post ? VFIO_USER_NO_REPLY : 0;
     msgp = g_malloc0(size);
     vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = offset;
@@ -1476,7 +1603,7 @@ static int vfio_user_region_write(VFIOUserProxy *proxy, uint8_t index,
     trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
 
     /* async send will free msg after it's sent */
-    if (post && !(proxy->flags & VFIO_PROXY_NO_POST)) {
+    if (post) {
         vfio_user_send_async(proxy, &msgp->hdr, NULL);
         return count;
     }
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index ff2aa005eb..dc4d41cc0e 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -90,6 +90,8 @@ typedef struct VFIOUserProxy {
     VFIOUserMsg *last_nowait;
     VFIOUserMsg *part_recv;
     size_t recv_left;
+    VFIOUserWRMulti *wr_multi;
+    int num_outgoing;
     enum proxy_state state;
 } VFIOUserProxy;
 
@@ -98,6 +100,11 @@ typedef struct VFIOUserProxy {
 #define VFIO_PROXY_NO_MMAP       0x2
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
+#define VFIO_PROXY_USE_MULTI     0x10
+
+/* coalescing high and low water marks for VFIOProxy num_outgoing */
+#define VFIO_USER_OUT_HIGH       1024
+#define VFIO_USER_OUT_LOW        128
 
 typedef struct VFIODevice VFIODevice;
 
-- 
2.34.1


