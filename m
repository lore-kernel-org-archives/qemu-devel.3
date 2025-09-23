Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2A1CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UN-0007ta-Er; Tue, 23 Sep 2025 09:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tr-0006XY-1B; Tue, 23 Sep 2025 09:55:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tl-00042K-7c; Tue, 23 Sep 2025 09:54:52 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N5FSev3995720; Tue, 23 Sep 2025 06:54:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=bYS7o7+L1NDhMOhkeHyPT0NOYVhsTfRHV5HM95OLp
 HI=; b=jePa7/ssuHMg7CCjiaV0YuJx+fcnV0PiPpKhJMK5MigE+tmDk3hYN6+O1
 eUtjlWsXbsqx1I9/2OydpPBmYy51z9VGmNKroAcmB6xtwrE3dUAhjpYqGxdeBugf
 sJEoNfIlvq8eViuGI817mHWBZZYccPVaQgFpeY6R6zFqLdzpC+SC+7BpRlsjFsIL
 ZChuzlsq00qDOV8Gkg4OEGgVPXO+qNsNrt3x/5+8bnjzZaAd7N1/ggCvpNvZ9luZ
 iL8Fr5aAOptk8K0bEiiQwTbREaToskZt8/Um8flToUypHwukO2IDh2g6FAVJ3ZSl
 PbbnXQXFnUV61eO8zXweqZf5xmHIw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022124.outbound.protection.outlook.com [52.101.53.124])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b9pjjfbs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTK8yuIbPjLqbbdiV9xM58/QfS6F16JgGODjawRAVfJpRy13Io+t0+PavCiBfYz57BBBfhS9tvcaRoD38VDJzARKq6dC/t7szNoohRM7vQK0084DPBC3i/q2jxIFj3/Ss6EWzBGgmPxIKrOGV04xJQGh34MLgTlUgCziifff92SDAwA5usTx04D8OyTjJpt/cQV6VlyJtY00HzsFKD8T6HCcMt31ukxVcEa9fYOHpDWEQWCQLbjLQBv1oXW2qjsiYCr+fdb2mq3Faro7TKxMczMORvbZQWqp8pjF1MY9D9t1RA3JaRfSpd6npV5gfiKeNnZB2dl+9l43cwcAOVOitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYS7o7+L1NDhMOhkeHyPT0NOYVhsTfRHV5HM95OLpHI=;
 b=LuIpHjN/5kmoVUKU5xKc6noPIybnzaNaSde9R5k0+KfyFEm1I8rZc9bEqTqxksyZ+7EBioHX8YP6m8YGiMucUz257P2NkLm945wsfes1r9sy8kr+dKVAqXB8E8HjFXecduG2hwVwIq3yx2CpGQVdStVa9diNM9+9HdaD+9Cc7DD9NKxE6R8ocpFhTZ8r0QOvsJfOAeJGfXLxGE+jCD7LC2cOgPGiT8Psp1hmzetbRJK6badrB+uCFDbvbqItfmMYz46t0k6dFgQVGM7uPpnoPRS3EuId24TRMpDom0+9M3IvUe9dIAM2BC47XdaXR8p82UxXsfGtSRj3deQ1T06gBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYS7o7+L1NDhMOhkeHyPT0NOYVhsTfRHV5HM95OLpHI=;
 b=VsSRgpXTwoY29aTknRLanPWiaPM+7ToDSq0NkMBa6rQb7QJYbLwAA6Qo6sqKlPXvvJPSG0UlNKKZFwlK0imfwJBad8k8N+5ZmaqKfC1pPV6vdzegSLl2O5GYjN8sJetbsGLXNJ7c0mWYl87w2ABrcX5mghOVUtUYjqllpClggj50x4Rgc8a9qdEpcT0byhl/Q200pRe2q0jazbUFTo/SdqgkefLZ8xVakHmvmgjij9bANmKZw1PW+RLS9uaoseD7KTtSJqRC0sHrpQVBqPpk5tlC2rvJH9q9D0JQCN4Dde0yKxw/xvL0vVLSPWxweKWEOdK9chBWgL/YkfgvtgrRsQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:54:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 12/27] vfio/pci.c: rename vfio_instance_init() to
 vfio_pci_init()
Date: Tue, 23 Sep 2025 14:53:18 +0100
Message-ID: <20250923135352.1157250-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: e9030e18-5710-4a14-83c8-08ddfaa8be45
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UCGokEVftE+Qbr5Vd79o1ghwFbiIXR9Yunvcii8Vx31LnoVdJp5zgeSrtKFW?=
 =?us-ascii?Q?erB9RuxmUc/0qcwsTGjkK8+DnLDqqbvznCgqxSREQhUQR4/e2RynbfLQyulb?=
 =?us-ascii?Q?b2BUWaixTARYxo6Q/jjJm8BA3s+fl+Dr6rZSppfzMRaHbgG4JQu7TL+03dcb?=
 =?us-ascii?Q?BDgOdN0GzkVixox7DYrDaRH+euqpKot8nU6yN4M7+P0ZZenCNqZn+8mqptlc?=
 =?us-ascii?Q?I8GqcBRKNubL5fSEAf04DVwFatVNPqpSBuvysXCp9VY0G5xFzyr6k3+zVLQJ?=
 =?us-ascii?Q?hvFBshBcJgHuzrkvocggU0zHmn7YoWxAVxIeW0+TlYww4nzQFHUF37LS4xcj?=
 =?us-ascii?Q?0B9q0UOtyi1nlNMneIho75DzydOzp8zsirrq+lr3FGcaoZ92EhnmcdXuAm/2?=
 =?us-ascii?Q?En7KLmwOLs+ljVmnGRwsOwZ5upOo/3zlYs+G0/Jgwmx5WrZaUxkPnFMKKkGi?=
 =?us-ascii?Q?LzFY/stFAZumd2SHEljhr9CLforVcxUV8bn5IvMCGuX1VUMJspLzyINIa6og?=
 =?us-ascii?Q?WcahzX2yNlmIMz51FFjlC/JW/SXwYpDyqlhfKhnyo35EKr6lyr1zOfetGDrQ?=
 =?us-ascii?Q?W8BqhFvqUsDkNWlmIWQCt7Uci+EL9e4/ZHhOBjtt8Iev/OfODhQAjBw1UC+c?=
 =?us-ascii?Q?WAF9tl/u++D4bP1B1jmES855rOXrLvwBANYBAj6fTJJ9Z9QqzoTStHcStJWK?=
 =?us-ascii?Q?Or0pISc8i00zEw+VeWZrrPYFA0A1qC4raQa95p7RPZU4vn2hRPMACCHq5t6T?=
 =?us-ascii?Q?mNfzMe6osS29doRWrb8mJHFnPeOV7aWPtKJGev2iIjfFOuzAzwdpAawaqW3C?=
 =?us-ascii?Q?dYxPUo2445leptrOnG8ZSVbfMI2sTaviTj2JK9mtY5Yw2yHbRaxHX7NICKDH?=
 =?us-ascii?Q?zyrZBu2jR/R5Ot9/yVMuS1PyHdblNUG3Mn5Fc3dGnxLckbLFf8xwThzXp7K/?=
 =?us-ascii?Q?9gzNFtlArNk+XvSrvwkUue+wF7eZDMZbwTkBndc35vSmnNQ32xCshXWuCShD?=
 =?us-ascii?Q?pkARVOlOB6FzcbjE1iewcOX1XsdjOM6aErzq9yCRrpyGAK8fzB3lMZpHW+wp?=
 =?us-ascii?Q?kNmb2m1WKAw7SEZ89HYq9d+DcAybrsV0e4Rx+4xaAFHh1QAMwJ6wj2PbycsV?=
 =?us-ascii?Q?iWwaUlaRXev0ySz4rKKQ7f9khez4loL0pu3o5ek0z2RT1Q6bPFl9d3aJzzQz?=
 =?us-ascii?Q?8ndFDCe3iTh0JueiVbQ8tkeihoOVx9bQGhu1K36zQBG9lhG93K4RHATrKo82?=
 =?us-ascii?Q?Q/oyCRPrVQugwkdIoChOKNHBcKW0MGZNyo2+xiPtjjZAG3yLTkdntd/uqbbJ?=
 =?us-ascii?Q?GPnGq7al85BNFZb78QWto58oNACWSzXY9PXriX+/HUhPcbBBeoxhUUAwNdzV?=
 =?us-ascii?Q?WRKO7UAtAt2oTw1uEIKb/OA2yC4J+cz/eMj77zOvO4QQwo3KelqyQd9mFNxB?=
 =?us-ascii?Q?54GPLUIzYKgbK10IrQoqK+Xs1J2nohoS0q7dEq11w7gRe1cw0xS/zw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RDjIR89fCqVDjkZ4B1Z7WM08UelH83bGlQLH3Nmp3GdxOAEUWJaGcrjwhMlT?=
 =?us-ascii?Q?G/0XRDGpPKlWhy+BQ/WvYCz2eaNAy2f/i4OxidzeFZ9nSStTuNMzrNi9Liws?=
 =?us-ascii?Q?cR6uGNn4uUMScN/DZc52SBxJiLP6IEm2kwkHPRsw6H3ignUu/9LdRsKmudtx?=
 =?us-ascii?Q?NJqh3A5b1h4pGaW69YHgqerdby1NGQkVw5gGYhz2Nt/uQZf4tIesDoB6uq8u?=
 =?us-ascii?Q?RXfiBP5GzrOpdymFKg5GqcSaXBb1y8s2n8uE073rKh4HOHtnFn1KZVkarDjn?=
 =?us-ascii?Q?mfwF+qqz9iu5SHE/lJV1x2qx72k4WXzXDBUAn2G6w3g8Ktdn9OC14oRDBM88?=
 =?us-ascii?Q?S71sIAm29zQdcQXh6MOqwxKFkBoj/502jiPnTVO6r6KPEk7PItgA1BT2ZYZe?=
 =?us-ascii?Q?R38IU0psi4PJRyGUFwM4alDdcmtHeD4TuXJvPHIN/0HQCEFO1oyDXBrQE7Ad?=
 =?us-ascii?Q?PqtsAQp9c2AH/hoFV2l9l+6Gcd7DKXxiu2ixgJPKgMSvHm/4WXLbQ7cXoSeP?=
 =?us-ascii?Q?BsUVETAxSrbhcIvf1CtxxHimla6reSxwxo9UlDLDV2NdF28o+buxFb05BiK5?=
 =?us-ascii?Q?AHy7nUMF9uE0xQPfUzOBr1SU/UBP8JF8y/tfa/yM7NL6qwq3EsDbzpTACDlr?=
 =?us-ascii?Q?jjYIP5QHOsRuv7GQbKafvGblNOgjvM731a3lzNCzQz4975SnwmtlDj1bNu/m?=
 =?us-ascii?Q?WfXx55zPnk7Bzyt4y2KbN/l+IYiobqkGkwWiLaozTY852JKEkIcP3536sYTZ?=
 =?us-ascii?Q?IWwjS6OJsOZdByc8QjhcPMCplbBoZO+7s1GEBZnnXIg9JB6m50D/eDW51R2u?=
 =?us-ascii?Q?gYZ/Y+AhSlWY0o+5Ma+fsEFxWntxdxIfZUFdAB7Hkb6TSp7gzT5IRKHltzzD?=
 =?us-ascii?Q?uysngIVZI8z7wSmr8WEWJn6lX8ze/6LUINfJi2eDyzxp2AG3lEctg9yo2gxe?=
 =?us-ascii?Q?9TwKRQJuUOCtO3TVk4Us8b9ozH1eF/LCFykeh22WXoAmTUUEDpt0TLkz+KgH?=
 =?us-ascii?Q?QFiGn89PLwkZbnbdGbZttd3CoXfz0goXrPRB8UQSyMRHhf3Y+FvUK3qBz/Hi?=
 =?us-ascii?Q?IXwnIUBUmdTJmcoAgv5h/hU6lWGGheQr9BFwVAEntW5/RXS7TaUu9AJiCCxz?=
 =?us-ascii?Q?aMvrb/1t1/8yJVukox4O/XbFGu+o69ukSC1dkr/JVksoVXKea5VVQklN2a0W?=
 =?us-ascii?Q?TTsk7m/252YHdnDIpIckSZhYhd9VGZj8Sur2bhDio0GcE0AKqaXR4la/NbzR?=
 =?us-ascii?Q?WoZjAg3iD0wsT3b1lzGDtGFmRs2uWUXz9J0iPdudCUigJIbSpKVjRscqpYI/?=
 =?us-ascii?Q?EQ56CXcfyKo522ewNIxOozVVKfA5i+4jnXToLK9jjwcggY4D7U+t8QKnTEXS?=
 =?us-ascii?Q?EuUjaQ2Ua81+bJXUiOo5brLnaR2u480DAQdo7UT4C0OH+mPoelgLcn7viz5r?=
 =?us-ascii?Q?sMvAF88Rw4bsH+gjQFYch9pCC41fAocIx7k/BdLEHWfDLX+2VkV4QzO3tW/f?=
 =?us-ascii?Q?KCp+7iZs7KSPMXAM3TQVfJWsEP+fINdEzDHjTxHE1QvyZhuRe6TYgeGx+fMg?=
 =?us-ascii?Q?xyOS/GBzrK1GpXOkO/fQ4CosgkYqApHBLtea8XUPrisJpiKsAZ8k0eK90cpB?=
 =?us-ascii?Q?AyXkbSsSJXAvyk2/SUKr8eg7vBfutorjDmDM45iL6kgaqG/gpyNkD+BIlpE+?=
 =?us-ascii?Q?3BijxA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9030e18-5710-4a14-83c8-08ddfaa8be45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:41.1326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fSlLy+N1MdJrUGYHeQrlOjKYaskXbFk4fQF2gzuZ/SXE7Ha4tmGD0KtA3GyJW88o5REQ21kK8OoB1tYen92h0cWHG6jpp2bhzj6ltzEEjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfXySMTtKdNQDMr
 jgTHWP1+xy6r5N3chXdGJYZrcHo4Q/5tCi354DHh91rmTT0uzcpH5H/kGncU5KPE9NxUXvWWuVW
 XJNRkPqXtgBGWxGs1+Yq1mMXYOMzj2zt91dSC4dNPEaVPCbsEDc0z3+TqdbAP7pWPGLp2pjvCEi
 jYRu7/aNiDtEIG2m/rpBHMR2itwMrciDotJCum+HJuuHkglG5DgbUTcDpOBGFc31mkrUJwwtUnU
 X5W4A/xYI6tibfUxb4KOecPkZBZe/aVGFZg7DXgHMFqk1QcD4JhXBSZ6NA5pwRjJkv5m6vU/o+n
 ZImYSDi57u7mzCuekjV37alY5xp3wStlThDsGrAVsy6rLy8XYsohC1w6Xnt+5A=
X-Proofpoint-GUID: NZZ90SgbbHWIBpQZ8rcO2PYBEcsfaDRa
X-Proofpoint-ORIG-GUID: NZZ90SgbbHWIBpQZ8rcO2PYBEcsfaDRa
X-Authority-Analysis: v=2.4 cv=LOBmQIW9 c=1 sm=1 tr=0 ts=68d2a6a3 cx=c_pps
 a=Z+wCPMcgC1Y9moSb1l8pUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=Dh56xV8-9bS9yBysVCYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is the more typical naming convention for QOM init() functions, in
particular it changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d14e96b2f8..9046244e7f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3629,7 +3629,7 @@ post_reset:
     vfio_pci_post_reset(vdev);
 }
 
-static void vfio_instance_init(Object *obj)
+static void vfio_pci_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
@@ -3920,7 +3920,7 @@ static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
     .parent = TYPE_VFIO_PCI_BASE,
     .class_init = vfio_pci_dev_class_init,
-    .instance_init = vfio_instance_init,
+    .instance_init = vfio_pci_init,
     .instance_finalize = vfio_instance_finalize,
 };
 
-- 
2.43.0


