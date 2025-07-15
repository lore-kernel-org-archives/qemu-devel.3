Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1125C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc38-00047O-GC; Tue, 15 Jul 2025 05:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1c-0001lZ-Us; Tue, 15 Jul 2025 05:32:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1Z-0005sQ-7U; Tue, 15 Jul 2025 05:32:36 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7i2oY028586;
 Tue, 15 Jul 2025 02:32:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=l6dvvcdJB9+mNg8UdOlEMrtcew09FgzhqW4tFFjxL
 Yg=; b=PSdt+qrAQi3hecUm+NzKf0dWiaJPfplhLEWHUoVuOxNE3ncmedKKlgeEu
 n5TbiigC8XhBf4pqYxN0cQVjDvFuhsc03WmTDf5LDGZAHD+1kOvPzXzdr5XkDMBA
 +SIBvr7luDJFzNYYhQxjRaB/QgHdrZIr9wT/rVTDjCujBI09vRH+49STGMyCaBrM
 fWSoBIKC49alOtX5d0f2NXUaEH/MW2n6qY27mjcMTQLYGrtNvVl09Q63EpOT73Ui
 fuavkCZ1FJqpbsJbj3547AfgDF5wfjf7zW3pjs9yVzE0OEGOgyLsJq3/c73d3msg
 +WFeU7AYdYtZ1RE4IZRKxLx1cepMQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47ukmanujf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKuA1RYS6ZDjGseeRRmwC2pjN7FkVxDQXkwDJExpgL9M1Xlhm94Q6hWtMDPB7cu4e4xD+cHI0Abcv8sG64S2bRiP3+1Jox/S8sEDAMCC4VZzSgMtuGIlmJb8Ju+g7iVC0l2zH59n3LdFOy34d0DED5BrKmPvwXuA0/H0NsqmJ6MeHdu8u69/pG6Zh6kc/yTJZRQ68gbSM944H3DAIi8pcpwhDwASW3AQGWGOZ3AmMZ48zryUYGm8XnMbv2HaBUOYMmlqKAH1Ngr8FjjxtLrSEzBSG9Swpk877mdf9PmukQ+E70c6ayuHsZX3xGAMeMn9GzMf2yNdSsHroWCs7KaGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6dvvcdJB9+mNg8UdOlEMrtcew09FgzhqW4tFFjxLYg=;
 b=nYUloWI0ag74wKFSKxVsPyC5OLXhShrbou15bnRy9LHgE/wruWhUAbDVM45XnDuemin5YshfrvrXiXXinYH0A9GY05CfzdlS8sLQmcAyeCTXTCNk23cFNqy3BwplpfEopl4ozNZhfnEWkEtE2IttLxOdjj9rjZdKp6NSEp1hAlzIVK1pFL3Y7iaa5JX0i3zHsT4JP0omqTDI+2S+uQW5A3Y6agtrh2Ke6DaBMw212n4eVSXT1eFNYhgbBwBl8FXSHbkDicgRqDAYHCED28OmFqr89PT3a1N3DWTk8oN6uZu3EJMKEIAnTlw1UKOAGE38SZIJXzrXkBBRn/ui8REE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6dvvcdJB9+mNg8UdOlEMrtcew09FgzhqW4tFFjxLYg=;
 b=XeBGnBUWRBF/nkXx5fm+ediNbMtHy9w2KX83iHpeUHY+Z06eHuYIb9nFVpJKXHohwmgxsuRXgtzzCAYFlddHfRcukE9LIKXDQUueJrfagZb0rYSBDXbRTlJHK4LAxU+Ytt8wbfzyrP9/OkLrL2aFg8Lri4kLLH+mEDiuyMaN+4ZXaYh5kZS26d/RY0mE0WesMdq467xqBjyv+Wmrm6GZvvWhcUiqG/+CZIwbp0gzscBIGifiESX8jZcb0TdTPNEoAuL4ouVywDRAhh+kVy3HpStbKDpHl1qMsrwGxWDtpUexiwc1kb2DzSYNdkYDhKxNRitZCXwWPdBH90g5+iO7mw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:32:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:32:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 19/22] vfio/igd.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:59 +0100
Message-ID: <20250715093110.107317-20-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b48a11d-d6a2-461b-641e-08ddc38280ef
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2NOFrxD+wHCkrVz/+ibbFaFMGWc6rnILDxEtMrzAdMPlz1YQwvDOLB42BUNi?=
 =?us-ascii?Q?z0zYB19rpyHwWR346LeyQx9l9YWE3LDAcIA1/TzYiV0n7RQ0sIBP4GS0bFiu?=
 =?us-ascii?Q?IIuL02KQ9D5uNWrGFcJhprTNPjIjiMLEtN811gN8oiNBzdVbTRZ01kaWYtdZ?=
 =?us-ascii?Q?4hMV850BVp0VHRnMJ+MmuSlOG1+RFEz8qvqULkHSC9k/R40qgLetyko1ZRvX?=
 =?us-ascii?Q?xHHSIgGvUTfCHehYme4iZ7VMCMrxX1lfc6bXy0MNXtwi0+iJNHPCRtB6eCQR?=
 =?us-ascii?Q?znzUECqaso0nHv2R/fqgWuQ1nrQ9PIZMgl6Oab/U2TWt9YHcW1lCsybWXQn9?=
 =?us-ascii?Q?jmXuWHbiihSXMLZyo66av8BJDPltUz1N189zRNmDtmtlBOx+ZYRt3kwwYHKk?=
 =?us-ascii?Q?V1kHMCgmIIRSXz2fwdDZ5qKJAJy2m0Q2EY7UyZ1BekqKO11lvxEUxjK5bpxj?=
 =?us-ascii?Q?p3Hh43MC2q9pCeIg5v9vpqRFjBvs8DkokA08dzOkF/8xUqqzjy8HJo0ukvTP?=
 =?us-ascii?Q?G8hIilGZbfww7xYRR60U6ZiQb30uirm0AoSx6tjBsoL5z4rdGfiuo+EuRXLO?=
 =?us-ascii?Q?dx2dbljpXglSBzLEu8ZyRbPA7yQXYXjfd0Elu/PT2SjGfoEJmVTaNj17fCrQ?=
 =?us-ascii?Q?titv7yXiPT0yMawSu8jZmouqxpg84/uuLiH8ahz2uF1vFvYqZyBRjJhczbzm?=
 =?us-ascii?Q?Md1AB9tCZvO/9JHDxAoYLVblutR7JAOWn2m/GJPWoN3hQIQZPrD/6P/HxDJX?=
 =?us-ascii?Q?NWiB/OttAfDcU8xLjwVlrL7tM+93aq6i2zcLZHSnXOIzLx3qZzRtYlOdo1XZ?=
 =?us-ascii?Q?VmUghzFXghKxDv945FPyyexf2UV+TEs7f1N2JooM1outJgmurAY2SYpC6u2v?=
 =?us-ascii?Q?xm6SPPSNLW9D/tK2FfBgPJIw2PPpaI7pRSIPRZZPkQ77zIe6KWA/IzWIrXFK?=
 =?us-ascii?Q?F898lE7LVxdSs8WdFyVxCSjmx3qn68NUIFDYUv/RIX7Zt379GO2DONIkqaWh?=
 =?us-ascii?Q?prLdO35RBJ1VQiXFBSwekm0MhoORUX8pGEmeXEy21+9LPuEphpXhqGGX3YI4?=
 =?us-ascii?Q?8kCt1no8Amx/h/R6ZYqGXyadqwKzcgxb95zPZjfBlh+XnRICTLo+FlWXzhAe?=
 =?us-ascii?Q?W7J7l9PWECERKX4/9tt2aZBQ2omXy0075E5laNanBWhJyVhdh+wvCTOpHFjK?=
 =?us-ascii?Q?KLS7Qjd2JhVxYw0EQA3es9GUthLjo1c/V1jMJZV0MsqxFj5PuS1K81FhCQC3?=
 =?us-ascii?Q?/A0HA2uXd2p00rVlcyfI03GOYd2ogB6htCb54BHRcAk3ARUPL6f/GmMkS2yA?=
 =?us-ascii?Q?XISw7elzRxnlic7f449a18eq/mPEFA+m7Df5/QpEOCRizS5cszwO6HtQVrHS?=
 =?us-ascii?Q?edUBlLKCvrSb8EZrL8HnGwLzHiwXp+iXKHh3LxpZ2SKpGVsjcsPo5G98m0nU?=
 =?us-ascii?Q?7DDm6NJrBHEG9UUHGEYWp5iAQA96QsbbeO2UKc67ZEY5nARoU6f0tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yq+TebXAlgT9TJXMQCsAtiLs49A34EasHY0+wfglrk5N/62nNBtRWlFdGnwo?=
 =?us-ascii?Q?vWsWmK1Vk35kXi0jrF0V1kZF90XxhVnjHA3VmbJwcRqOPlKx8ExfyqWCnPwR?=
 =?us-ascii?Q?y06j5NoPS71c/Aew+aPuQSf6c3iEMYrOZW67qk2jsGfPubjupfu+teUeJZF0?=
 =?us-ascii?Q?ZHTXbnRTQj1DjC1bEjSXzJj5EDP+LpUOjzTXx0su2SJNKe9FMS4db7OErr9k?=
 =?us-ascii?Q?Tnv2gOGQFcbmqn+BL3vTmeAvLVZnjvavVzkgjPGmHWydnFKFKKc9j3rbmSh5?=
 =?us-ascii?Q?ilLYlZzju+e9nfgpKMx0zlDSandbse7GJ9Wo420IODr5N+3/9K7c5+DzzJKX?=
 =?us-ascii?Q?doSAkcOobYWB8V4U5xvDyD9YzxEdXhy18Ae50rQMuGafYs+Ca14ZkOIQAD/t?=
 =?us-ascii?Q?vNhZXQbbTaT5b6ALGWYXQN17F7y6dUmMtw6MIdgNdxFHgPZuL9eVXy8g1xuq?=
 =?us-ascii?Q?3sBDExoatNLWNvyikJpaCQm0M6+llFcccsB9t1RvQ7r+Ur+1wXN0hAWSBbIq?=
 =?us-ascii?Q?Ilr+zayLw+0cUFOQrEvYEoo6cz+qWmgs/9A5YUtOSS/IVhgakhjtF+Nfpm79?=
 =?us-ascii?Q?IydsfwXzyc6fTcgM8bzlgFokX/Qw5/YZfDU64wh/IoRJH9utF1HUP5npXwrB?=
 =?us-ascii?Q?iH4kwU658MX0+Qrgjm3bo/8TaWPiSBXY7HsZF8/q8Kgz3oZvfstYTvBN3qFC?=
 =?us-ascii?Q?a0n5kRYtO+KGCSdoOrAJL2Hbpyd3oJ0zfaZZ8+z6Yq7RPks2eiMAk7AlzzB3?=
 =?us-ascii?Q?1kb8NQoK0rd6uhDlBEfSVnVccwR0Hdlss47Mymx9yg5MNHVWR6T347hJ/3lh?=
 =?us-ascii?Q?GS4zMw6JRjy3MPW0dREP2Vmtyi+seyFBtQLtB26ttpmoDJDq5x1L+4P/V62k?=
 =?us-ascii?Q?EUijzktHXotyMTltcwVUThQp1CRdC+bPUDMDF7ihni2s2yrPo7WC02yAnbpJ?=
 =?us-ascii?Q?QR6MRbUAnCXjML6XVD96qGWXZE+TTUp0zOeIihpMF0IDmLhtXBdB9KyE2TBi?=
 =?us-ascii?Q?24nwJWt9AZ9t2Vn7IgN7CjjoQGMrGgDRVHImQbVcVSMcKo1SdsMs5LEiQ4q4?=
 =?us-ascii?Q?EAnCbmgMEwsSC+A6fAA7i7RoPGiblNXCw+FDyoMSDs15AN8pauPpDk3muI6b?=
 =?us-ascii?Q?+qsHW8SAdfO7/BTkQA3ZpFbRitAGOcc6gW0egZKbdhLGH8g9tOFG3B3Y05c/?=
 =?us-ascii?Q?UM/BZ9Zfnl0ljh7r0Ms0hLxQEwDKHg9uJZ8U6Xnz84dTmh1edfWJr2qq3txe?=
 =?us-ascii?Q?KGsu0PEWSinpD4jIVIagavQpfEqQl8zoPN6WxPkq6O1eexag8y9mmIdFgIHO?=
 =?us-ascii?Q?UF60srq/x+Rzi+1d2VRuQcsk7TW4/7HLiaSsr0kHR4LPljoAq7tmcD6HrZ/h?=
 =?us-ascii?Q?Vo3YXTlIB1OTpaDYraZYkN9Mez2mwilooxB+RaRsHtzjYZVADfUPggDfK7j5?=
 =?us-ascii?Q?jQFzvIDoZGXFR1XXmaPgHEyvdJMIylGmxBQSrcKX3DvRH2hmtOU03LpkVxGj?=
 =?us-ascii?Q?riP/5OnTyLEnyGnNHIYqykmApS/4Yr/+duFE7Jkhn8TYk51S55H5PjMG7BBj?=
 =?us-ascii?Q?lbnzoF1dQg9TDI3MjeJu9Q6VrQfL4ACX0+flr7VrP57jMSzHSq5771wjSOcF?=
 =?us-ascii?Q?FzZBBBAM18QloP+OOG9sh0sB53pNxuer1IWx1aA+zV9trQWexPEMRzOKg43z?=
 =?us-ascii?Q?H7CG0Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b48a11d-d6a2-461b-641e-08ddc38280ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:32:23.5014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuGTAWQlUQZ7c6Nc8Nul9ZyuIq+zJPZLfsPaAUUUEnBz9k/zdHP24PdU5uYJGl1swHTZbOKAIy/prR5K1Pvla+zIRRSDOu/DH/LWS6Ye96c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-ORIG-GUID: XD9GRLs7cLOGSiApIu77SZFfAjv03OTZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX8QXdLPcGHDSs
 c2TxG4ilIL+RKRvhltvf1ckJ5jpIp/oT55pG5C8V9NIMMGKFdQnqZoR6P5yKBOtjC4fuYJCkXcj
 RMnetpmTj5VU7yvsfqlm5XPiKogaSBr4iBc6ClzxDZ0iKWxfUp+gB2etvWWXd+Mk6/dqjAQyVqd
 WcNz7PoV7vDlEorSCmR8AzMIS1QDDrtgpJnATVc4wzV1kAfyIXcncinLF0F4yttES6HvAX2qfxV
 0HosG5Rh17f9c5vqYvhyazhOxSS02rktv86sz6B7jZzfDGa4kbfcVsGTSK7vlfmHt9ktD+RECt0
 WCC+PY19M7GKhNtJowHuqr8+4ZcjRExHZzSX+k+t5uPpjRnVh/jrDS0SSOfkfZa0nqQQTWlU5+D
 vTif8T9GQr0WBVcKW/1RsORU1ryWZItiSLL7I0jeGbfpI5+OIX9YpJJEp0MTMooZIFR6qYzF
X-Proofpoint-GUID: XD9GRLs7cLOGSiApIu77SZFfAjv03OTZ
X-Authority-Analysis: v=2.4 cv=UcVRSLSN c=1 sm=1 tr=0 ts=68762029 cx=c_pps
 a=4OQEInZ1ojcYQa5QMlKIhA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=BpnkbtYPyemCnBV3ikEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/igd.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e7a9d1ffc1..d3ffbe7db6 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -199,7 +199,7 @@ static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
     }
 
     /* Hotplugging is not supported for opregion access */
-    if (vdev->pdev.qdev.hotplugged) {
+    if (DEVICE(vdev)->hotplugged) {
         warn_report("IGD device detected, but OpRegion is not supported "
                     "on hotplugged device.");
         return false;
@@ -259,11 +259,12 @@ static int vfio_pci_igd_copy(VFIOPCIDevice *vdev, PCIDevice *pdev,
 static int vfio_pci_igd_host_init(VFIOPCIDevice *vdev,
                                   struct vfio_region_info *info)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     PCIBus *bus;
     PCIDevice *host_bridge;
     int ret;
 
-    bus = pci_device_root_bus(&vdev->pdev);
+    bus = pci_device_root_bus(pdev);
     host_bridge = pci_find_device(bus, 0, PCI_DEVFN(0, 0));
 
     if (!host_bridge) {
@@ -326,13 +327,14 @@ type_init(vfio_pci_igd_register_types)
 static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
                                  struct vfio_region_info *info)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     PCIDevice *lpc_bridge;
     int ret;
 
-    lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
+    lpc_bridge = pci_find_device(pci_device_root_bus(pdev),
                                  0, PCI_DEVFN(0x1f, 0));
     if (!lpc_bridge) {
-        lpc_bridge = pci_create_simple(pci_device_root_bus(&vdev->pdev),
+        lpc_bridge = pci_create_simple(pci_device_root_bus(pdev),
                                  PCI_DEVFN(0x1f, 0), "vfio-pci-igd-lpc-bridge");
     }
 
@@ -349,13 +351,14 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
 {
     struct vfio_region_info *host = NULL;
     struct vfio_region_info *lpc = NULL;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     PCIDevice *lpc_bridge;
     int ret;
 
     /*
      * Copying IDs or creating new devices are not supported on hotplug
      */
-    if (vdev->pdev.qdev.hotplugged) {
+    if (DEVICE(vdev)->hotplugged) {
         error_setg(errp, "IGD LPC is not supported on hotplugged device");
         return false;
     }
@@ -365,7 +368,7 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
      * can stuff host values into, so if there's already one there and it's not
      * one we can hack on, this quirk is no-go.  Sorry Q35.
      */
-    lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
+    lpc_bridge = pci_find_device(pci_device_root_bus(pdev),
                                  0, PCI_DEVFN(0x1f, 0));
     if (lpc_bridge && !object_dynamic_cast(OBJECT(lpc_bridge),
                                            "vfio-pci-igd-lpc-bridge")) {
@@ -509,6 +512,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     struct vfio_region_info *opregion = NULL;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret, gen;
     uint64_t gms_size = 0;
     uint64_t *bdsm_size;
@@ -528,7 +532,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     info_report("OpRegion detected on Intel display %x.", vdev->device_id);
 
     gen = igd_gen(vdev);
-    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
+    gmch = vfio_pci_read_config(pdev, IGD_GMCH, 4);
 
     /*
      * For backward compatibility, enable legacy mode when
@@ -540,7 +544,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
         (gen >= 6 && gen <= 9) &&
         !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
-        (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
+        (pdev == pci_find_device(pci_device_root_bus(pdev),
         0, PCI_DEVFN(0x2, 0)))) {
         /*
          * IGD legacy mode requires:
@@ -562,7 +566,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          */
         ret = vfio_device_get_region_info(&vdev->vbasedev,
                                           VFIO_PCI_ROM_REGION_INDEX, &rom);
-        if ((ret || !rom->size) && !vdev->pdev.romfile) {
+        if ((ret || !rom->size) && !pdev->romfile) {
             error_setg(&err, "Device has no ROM");
             goto error;
         }
@@ -605,8 +609,8 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
      * ASLS (OpRegion address) is read-only, emulated
      * It contains HPA, guest firmware need to reprogram it with GPA.
      */
-    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
-    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
+    pci_set_long(pdev->config + IGD_ASLS, 0);
+    pci_set_long(pdev->wmask + IGD_ASLS, ~0);
     pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
 
     /*
@@ -620,8 +624,8 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         }
 
         /* GMCH is read-only, emulated */
-        pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
-        pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
+        pci_set_long(pdev->config + IGD_GMCH, gmch);
+        pci_set_long(pdev->wmask + IGD_GMCH, 0);
         pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
     }
 
@@ -630,12 +634,12 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
         /* BDSM is read-write, emulated. BIOS needs to be able to write it */
         if (gen < 11) {
-            pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
-            pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
+            pci_set_long(pdev->config + IGD_BDSM, 0);
+            pci_set_long(pdev->wmask + IGD_BDSM, ~0);
             pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
         } else {
-            pci_set_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
-            pci_set_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
+            pci_set_quad(pdev->config + IGD_BDSM_GEN11, 0);
+            pci_set_quad(pdev->wmask + IGD_BDSM_GEN11, ~0);
             pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
         }
     }
-- 
2.43.0


