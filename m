Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8584E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdI-0006Ro-MQ; Wed, 08 Jan 2025 06:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd7-0006PU-8i
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:49 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd1-0002D1-1O
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:42 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50885pFE021537;
 Wed, 8 Jan 2025 03:53:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gfZZgflabec01m7nn1Io2co+v8baC8sayzUsnESXz
 gY=; b=0ELCh8jHy1HArGlM5b4zOPMSFBFPvQa+NYuV3oRhF/E4STpoHV0mjqwzU
 S05eufz02s1ZRXQQZiRerC2fbBs8dhDexwJDjaUr6hEaBtx7M2m7g0BPAgaShxf/
 /1RSLtoLt/DWsTvWwmGgBlJRK04Nt8AKUgAwzCUUKb1KbSwbbtpRqP3OxzVCY/xP
 HXzYN8VgL9RDo6MbuQNa/a2Hy+ULJQsx7fSH1EE8ka74VP4uEE2ffEZI/wkc20ME
 tyr5FOda363jnbD8//QFan0fEQAi32thKFFQkvUU6tIwIaE4mX6N7/ikIVGD8NTP
 115Pu/uHpEmoQJfKC5202mxbuyqQw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y5d3rs7x-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRG41Q8lJ9OnX0Xd1JpwCfRzLtV6xihSFBQBD5KE7INCtGHk0QRZRzbqRvyqe3hb0014Lx0JVT463kltf9izuT51GckdOrk2OHuYb9hYQMpPwPLxQGJJUWQ8N5pxnKAzrgaWwbDGWbnaaYQdXP5uLnYK7PdOXCUcl2QlfN0k2cRrry89nVVDo2uB8pIVkjWg3uCREUTPE/xVMguJx69SoHuAFdUHfbcikdQz53RiEFN07C1Pgz/akRYXsPoxA0fqgNAHn2EWLB6DZxSdp/RTIj9f6zgi7367/Z4c5Ung/NeRIjHKIgqwQN7/cdZQNcguTWq6snPKbZ00cOX/XjAQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfZZgflabec01m7nn1Io2co+v8baC8sayzUsnESXzgY=;
 b=rB8Vxw3YzxedTm0HBT27H+JehfC9vvqk7WpdhJLPTQ0LGcyD1AaLcb1NqivuP0bzF+7EQUr/KvpLZES8QH5CfH+IWK5F7maeV9Go8sriIqgxdx389A4ns7z2KDk78eYNV0KzEgHBHbR/IKxtbIR//DcmucWJQJXaFkYluagevosJclBqe+l3SHYXYs+i9/Z9Rm+oj/ozLWJqisYQGVfpORcOusWzwLrZMMIQ7F2y9rOKzD4KLnpDqNSbuM1mY/QA8NMKsj8PTERFi4ENc9AKg5ICZEn7nu1JpXuqiWd/0WmGioGaclFlaPGwosBxL7sOiJAOK8wt49I/M7VEVbeaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfZZgflabec01m7nn1Io2co+v8baC8sayzUsnESXzgY=;
 b=JQShnw+VpTNC9zCr9HC5A77szv4rS1SPcNiaAwvJj85sYGzKMFaQEPOWtR2Z55hslhwZE8Qs9DmuI3bC0E4+LhkjT/R8S85A3nrGvOsMYtwsS5dJHZjz8YicBv9ABItF4ySuIC/w/pOmSIfg3C6wTwdBKv+Nt8mKln/XHQw5j9Hc//mS/5pdexdRgFRWeBOWV0y+KCrWg9KHeve60ULW53fsG27XdAP8ZIHUzxssvq/3mu48Wz3fNRW8f/UdXQwTyDmvTqPCKKAgHmp9RRyy2O0GaAysaqgn2dlJKdSB7SsHf48R8RwskEyw2FJgmzyPsRw+I46h2em60r4M+aZJLw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:33 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:33 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 03/26] vfio/container: support VFIO_DMA_UNMAP_FLAG_ALL
Date: Wed,  8 Jan 2025 11:50:09 +0000
Message-Id: <20250108115032.1677686-4-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfb7bf5-bf42-4d2b-6b17-08dd2fdb13db
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kImuYKMCVD+PJxYVJplnXDoXh6g9WDvuALlrc9xu8DqLTwxq11ZTGC8OeDyU?=
 =?us-ascii?Q?GEVAtxhJW3TS0WnV67nUt/98fxXMASmSFflP3ERkIBG0uQsKdko/BEaa9U8U?=
 =?us-ascii?Q?pD72IhBMWPiQjjVbE7llCqmg2yI1eQd6hOSFsnRu07tjFrxadWdOBke9x/am?=
 =?us-ascii?Q?m6QI/pcGu1jV1CJQXKoNYCvU2+XLApQjNilwqnefN1xxqsTk0X1mVHTu7F9k?=
 =?us-ascii?Q?u7OXYqKigAU35jUhCATUt65ytp77XboRJU8RZiMDVrTXIsNOTgApaAtKzhoR?=
 =?us-ascii?Q?CPRwN1U9RbeXD/MBWRGjJdKKXHfD38vpwUECGMS6CQNKlzTEs780uPlW6iPV?=
 =?us-ascii?Q?NPKnB5KYXjOlpxvMUaN1qU4sAI1wmui/cd+Z3vzlmlJcPmyD6vMzKKXsLMWJ?=
 =?us-ascii?Q?iFViehOQJD93Qk8VDvf/Y2EiXscQoccT/HUPi0W4hPx+/l+Vttw0axwnmUgc?=
 =?us-ascii?Q?TK4pvWlQWiVL4sYjoJvSmVOiNQNbF0OB60oFj41NsWDNcPIWwXCn31udK/SJ?=
 =?us-ascii?Q?6XYuJ/oCft6Jn4Tn0HDxpgBEPLZs1yTpgeUvS1ItB3CE2bctm7x3JAhdXKb5?=
 =?us-ascii?Q?z/eyCOWUNTXkxeiT0TrINfgut6dVRKb1Ey2fKub1T88zEf/7TWXT4mhT3yDK?=
 =?us-ascii?Q?ZbaQiJFsAwx9iBVMHoymNYLfEkjOg2WftfEHdYuv2761vALc8PIzk8UrcSmq?=
 =?us-ascii?Q?w5uYhPiFbnHWg41w4GoJmlcdtSFPUq9UI55i+OUkvtZnm/mWmNU6ib8X2RXt?=
 =?us-ascii?Q?m/KRXsa81ZXNOMZiE30NgieMklYjJN35KPEbWCGSvk3jpNl60iF24SfLQTx2?=
 =?us-ascii?Q?52hAt1dWjgfWQBOaeqxb/M+ufAO9t7QqbYWl493t4BX3rlI3tWKXyjctwb/t?=
 =?us-ascii?Q?FYteLMeKO4OaybbwxYp96+YTqrKy56yEv2uiwEtD5/mBSGxSkhRni1/WjnOE?=
 =?us-ascii?Q?w3c7xwuw1Mxx3cfd8D+cKczBEbk9i84BAH8S8l5bEg3s04tddZb8jiAjk5+G?=
 =?us-ascii?Q?f1mVH0RfQrF8iAjafIRKSHWJCsjx3ZdJTgPCONYvgAe59qRAZqOI3R67AMdu?=
 =?us-ascii?Q?dxswL2EVGFs/UVyTPx7LXJ6MUv3XNK5NXSOdGJZoTkQo9y+g1IZqR7NgXmL1?=
 =?us-ascii?Q?uwfuNo146Vy8kL9sT6kYz8EeqMsu5JOWkZAVjjzZUdLHXkeoWnOgIJM2Gy8E?=
 =?us-ascii?Q?B+Wwn6NrbgJE+6F4rZdp3x+5fX0UM+hjRV6W7hvWT20U2yAI3FiF8RYHAehX?=
 =?us-ascii?Q?SruWpP1ijMGmkhV+o5WhfanPisxY6XV6fJWTTr4m+MgOC2cMoVjtVNMl1RUh?=
 =?us-ascii?Q?yvvqQVObuBmkKe0ulM3fcvIhHrUGLzokMDcnH9Xn63gpoRZn6M6gL0g2hg/k?=
 =?us-ascii?Q?k/3jlK1PyfgjLN++t9CVnf3J52z7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2OjZe0udY+QVv6wzjdNQnFcJj9/bgTlQrFltvbyQNsGviCJR6Fcnm5Bq+iXC?=
 =?us-ascii?Q?MoAB2diEhVOH7iUMBj9lAA4f2+l1hZpJ9vt7o9LREf58l+4skJ3dGTlNOeoJ?=
 =?us-ascii?Q?ShtSZ3MxvqfI17NYlcZkuev55+aswV8FhrWzPajzymFrF+Ec98CvktW6KaEU?=
 =?us-ascii?Q?xUtn3nHcsY0Q0BabVoPnvpDMFnNZftXwW5OU0jpoT/GjEuKbfFhC4uNnBxzD?=
 =?us-ascii?Q?BWew+XqUUm2LIwwUQab9Tmcc+Ws9WeUSHIzC/i4OJbuNjQWUjvwyNWpzIYF+?=
 =?us-ascii?Q?+F/SEpu6kcnOJAondwg1td21to+i+1AMW/fhBZTJDZKztDkBDStVG09MbGPP?=
 =?us-ascii?Q?yJaV4cLSHWpPbk0aQx65TuB35kjVgkrNjptjDmc6RSPr+f6NGaI60qKQQARg?=
 =?us-ascii?Q?WQHE/cGIM+H87A8NZb5JtG2NqKQzO6WCpru6D1hUpsRfOZftvIXUA1pbhqAG?=
 =?us-ascii?Q?FSjHyCsquuY9ANFZTaCnFaCkeFCoRDXXDkUMy6mvxqv/k8LBOQ2iV0x7zR2S?=
 =?us-ascii?Q?RqaPkH2n4pOwxRxswL8oEESn7n1jvJbAd8AD65SG7EnYhWXLasY5bY0ZvHFa?=
 =?us-ascii?Q?L2aHRwneUbPRGenJM6/rD8KJl1tF5+EEhBlB0KIKpxcUE4tUMqPhU6QkzBRV?=
 =?us-ascii?Q?xS50YMILF1y90wTqw9YkazNUzrclhttvFAKsOACo5L/AJ6zQrHnPQ8qdrGJD?=
 =?us-ascii?Q?DRbszINoaiqTZAH+4LuVatWC9J2FeetQSA8h0+7MYcGBa6/BUhA6EVVAY0t5?=
 =?us-ascii?Q?uqd3NvUVeUvjBRsUc91iF6Ge1Sx7h5+KWnj+AUQMlVa+ZnUrp/FxyLvg/GpB?=
 =?us-ascii?Q?TLt3pjBLCyGnkw/3JkQUxpiMXihQj5PKOl1PQiQS0CpgQR2ipdC3j3R04F40?=
 =?us-ascii?Q?6TuIb8duBj1HDfajmJU5caA2jsXw3HPN4kMUiE3YHq2+/+EvO1tNo0LWn+4h?=
 =?us-ascii?Q?kP/o50a/5HOOqvsGQV6p27XfvyhXRtFVBr5xk8Tnn4m8sNwOWYN1ctoLGHih?=
 =?us-ascii?Q?qgJzMOQlUW6Jz+PqOLeWEq1qkd1SGuZUgXaIvzhYC6R1U70kYlEXmo41swG/?=
 =?us-ascii?Q?ehEh966bPcOrK5oMEtSGApYoPk7M4NkovWypb/VtCIvUIT006SLh1OC9xGuy?=
 =?us-ascii?Q?fUQCF1mGtEl8WJqPKzkZpp59cIdlvdYdGhaVCA07Iji2zTuIJwfNZlMKllIZ?=
 =?us-ascii?Q?NvJ9/dko1ac30sY2NStPhF/5bwLuDSoC7q9+VrwoBy2MLcL3j0GCQp4ghNmr?=
 =?us-ascii?Q?15nYyzwIWzvEK9o7rptBoA09olOCDoOxrbPd7irxWibP90m3yIjECiOFfm2d?=
 =?us-ascii?Q?+wJPAHZb4Mz3kpM6bfEjoSD3OsFVD4YPyABxQT5UImHklEmZkIN/OmmfDEcQ?=
 =?us-ascii?Q?GD2BnXrY7oAa8GDixXAiO30Gg2M88jQckNdQL5ozkXhphIQJwUVN9H7z3STy?=
 =?us-ascii?Q?cvNuYqPDSLr1omyjVAJ81q5mWSJVlQumw2jVgUsyv3D3BYHFscbRHK1w6ZNH?=
 =?us-ascii?Q?FEwsBKBKD623G/m9Quip7gNil+oYSH7ddHDTLcYJ/LbUVQX015/uhEfAhwOn?=
 =?us-ascii?Q?p1fTA/FCmG0gAxsBaFEcEEEo079Oc72aoVL6i/9f?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfb7bf5-bf42-4d2b-6b17-08dd2fdb13db
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:33.5280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exXNDP0fcEol4dT118Ala7h6kdfD6ZhrCAPAU7nuULjFCYEdPbaPTz/w25bt6VCWhXO3FQgRnICpQ21US3Fa+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Proofpoint-ORIG-GUID: irTS21spnVJZpBmibtObn412zkfALtJv
X-Proofpoint-GUID: irTS21spnVJZpBmibtObn412zkfALtJv
X-Authority-Analysis: v=2.4 cv=YLtlyQGx c=1 sm=1 tr=0 ts=677e6740 cx=c_pps
 a=ZeveGGZnxkNpWlA7A6AaFA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=rAkVWd3RjT2K1M8sKjoA:9
 a=14NRyaPF5x3gF6G45PvQ:22
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

Some containers can directly implement unmapping all regions;
add a new flag to support this.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c                      | 24 +++++++----------
 hw/vfio/container-base.c              |  4 +--
 hw/vfio/container.c                   | 38 +++++++++++++++++++++++++--
 hw/vfio/iommufd.c                     | 19 +++++++++++++-
 include/hw/vfio/vfio-common.h         |  1 +
 include/hw/vfio/vfio-container-base.h |  4 +--
 6 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0cacc66c85..49e3543c89 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -324,7 +324,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         }
     } else {
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       iotlb->addr_mask + 1, iotlb);
+                                       iotlb->addr_mask + 1, iotlb, 0);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
@@ -348,7 +348,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
+    ret = vfio_container_dma_unmap(bcontainer, iova, size, NULL, 0);
     if (ret) {
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
@@ -789,21 +789,15 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        int flags = 0;
+
         if (int128_eq(llsize, int128_2_64())) {
-            /* The unmap ioctl doesn't accept a full 64-bit span. */
-            llsize = int128_rshift(llsize, 1);
-            ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL);
-            if (ret) {
-                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-                             "0x%"HWADDR_PRIx") = %d (%s)",
-                             bcontainer, iova, int128_get64(llsize), ret,
-                             strerror(-ret));
-            }
-            iova += int128_get64(llsize);
+            flags = VFIO_DMA_UNMAP_FLAG_ALL;
         }
-        ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL);
+
+        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
+                                       NULL, flags);
+
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 5e0c9700d9..db27e9c31d 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -27,12 +27,12 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb)
+                             IOMMUTLBEntry *iotlb, int flags)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_unmap);
-    return vioc->dma_unmap(bcontainer, iova, size, iotlb);
+    return vioc->dma_unmap(bcontainer, iova, size, iotlb, flags);
 }
 
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index fe193ac7da..39c77d402c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -117,7 +117,7 @@ unmap_exit:
  */
 static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
                                  hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb)
+                                 IOMMUTLBEntry *iotlb, int flags)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -140,6 +140,34 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
         need_dirty_sync = true;
     }
 
+    /* use unmap all if supported */
+    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
+        unmap.iova = 0;
+        unmap.size = 0;
+        if (container->unmap_all_supported) {
+            ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+        } else {
+            /* unmap in halves */
+            Int128 llsize = int128_rshift(int128_2_64(), 1);
+
+            unmap.size = int128_get64(llsize);
+
+            ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+
+            if (ret == 0) {
+                unmap.iova += int128_get64(llsize);
+
+                ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+            }
+        }
+
+        if (ret != 0) {
+            return -errno;
+        }
+
+        goto out;
+    }
+
     while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
         /*
          * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
@@ -163,6 +191,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
         return -errno;
     }
 
+out:
     if (need_dirty_sync) {
         ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
                                     iotlb->translated_addr, &local_err);
@@ -200,7 +229,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
         (errno == EBUSY &&
-         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
+         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL, 0) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
@@ -535,6 +564,11 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     vfio_get_info_iova_range(info, bcontainer);
 
     vfio_get_iommu_info_migration(container, info);
+
+    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
+
+    container->unmap_all_supported = (ret != 0);
+
     return true;
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f541b00785..39c2b802b0 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -41,11 +41,28 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
-                              IOMMUTLBEntry *iotlb)
+                              IOMMUTLBEntry *iotlb, int flags)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
+    /* unmap in halves */
+    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+        int ret;
+
+        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                        iova, int128_get64(llsize));
+        iova += int128_get64(llsize);
+
+        if (ret == 0) {
+            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                            iova, int128_get64(llsize));
+        }
+
+        return ret;
+    }
+
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
     return iommufd_backend_unmap_dma(container->be,
                                      container->ioas_id, iova, size);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0c60be5b15..13c67d25cb 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -84,6 +84,7 @@ typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
+    bool unmap_all_supported;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 0a863df0dc..24e48e3a07 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -76,7 +76,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            void *vaddr, bool readonly, MemoryRegion *mrp);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb);
+                             IOMMUTLBEntry *iotlb, int flags);
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp);
@@ -118,7 +118,7 @@ struct VFIOIOMMUClass {
                    void *vaddr, bool readonly, MemoryRegion *mrp);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
-                     IOMMUTLBEntry *iotlb);
+                     IOMMUTLBEntry *iotlb, int flags);
     bool (*attach_device)(const char *name, VFIODevice *vbasedev,
                           AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
-- 
2.34.1


