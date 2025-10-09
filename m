Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DB4CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ngF-0002FI-68; Thu, 09 Oct 2025 06:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v6nfy-00024s-EP
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:15:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v6nfi-0007hb-Cb
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:15:10 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5998VSLW414272
 for <qemu-devel@nongnu.org>; Thu, 9 Oct 2025 03:14:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=k7Sovs1Ls0fPQ
 yts8UN93UYSiqjmAnBkgCLuhypgrtg=; b=H1mHzTAQjUBncUw43mNIIMvZ442Ls
 u05V2KipSPwY30G3cxN9Kem0hybZDQkQra8129v6PcmhMaxCjUEWZk595vaAhLPX
 kctVVmBtNs+wRh0uFF0wS18lOQmrGZVzoLyVkVGMEyZLRuhsVGW38efcX/bQaRI7
 xUz+J3wiEFxFUMDqzOzclnprpdT7e69iEMsUc3at9pOMdlRuRBZA/S449gL+tsLl
 tybX5sWL61Eh8M522YLbAJEVc0hNWIob7k1E45gwYtf33Y6Q6g2JmMEkA5Si9a+p
 BDd2W5YwZt0X3Y2AbCbTrPeC0x3snMaWYLEUea1xBLeRg4rrO33KmCOtQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022124.outbound.protection.outlook.com [52.101.43.124])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49nx1qskc4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3mJj5OaucAZnbPt8X15pPdfi81VotkkpR6CljK+WL2NUqyKVM+t+4Ej32l+6cunSjWMggxAsp2YCQBoFYJRd9nnXEedBOh5bypuHA8+d76PnJPRXdAKm9hXV9K0/lFh0dJkLGce7wK62ir2357ip/iP0B7JBnAwjriqQYOGy8Cr57E+8F9kBKpFoIUXCGY2DktOqNm/3fFEmEx8WRZ5zXQWc9jw83LP1F/ICJhR+z87hpQtmYUTUTBRuhOeXzTMHITJot1F7bnOKNb9nVSil8giEaKn7d+eBHEj21yDCOXGzOMwP42g+6AaRDFHLVgvkJTOHdab5cec02W76ktdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7Sovs1Ls0fPQyts8UN93UYSiqjmAnBkgCLuhypgrtg=;
 b=PVwGfgLhejTFvnzwsvDfoTT6Krd1hERuWIvsKcICz8FOKS2tVK/3ZZPk0mNN0LNPvwm41IL2sGuk5EZxuNB7ZLFXoYei0hOhnNTK9VqvYXz53oxPi+LECGyDf4nsG8V+vnXybHqE1/DIzcnbF83Mo8aKCHbJiU1JjUu9u9fIvKCMmzd4/Q6tHeJba6e+nyFCW+nCuax8MkZQGnNVooYJKLCtT91Aclyk6GBf7Apz7grahQouTCeBZWYRaQSjzfFojubkLPtC6H8uoyEneF3XvzhP5nf8BetH1cl9cZjPJGCExWPHZSEcBIHokXICVrKHe73WIHGOr+zF//QmL2dbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7Sovs1Ls0fPQyts8UN93UYSiqjmAnBkgCLuhypgrtg=;
 b=QOqdIuwExwFjlzAqVqsCI4l4lRzsEBRnF59o2SsyQBrPEFqzbl7Osu1n9XDc1TG0QYxbtlbmEiYD91+9u/iF/i+TfJnNis2jQ5sesYuXQC4tXLscY+FxRigcnN+9tVsNPjbL5NQ3V0aVQEaFdmDPXhqv/9Lczv0WydYt5sHIPUQKmpJW0QvmhCtMKRynm+I+HVGP9bLcHhFb93b2YtEvVKYqw5cEd3AKB7UoMlwICptA3fbV/OhGlHqJY0G/MTAF+4rpV4k5exYM5KqKqQQ+8PHDdgUTlDJoXiAwKjJL1bSlVobwRCq8yjCPxtXBCeH/odIW9YWfab0FwgsiYRc3hg==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by MN2PR02MB6973.namprd02.prod.outlook.com (2603:10b6:208:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 10:14:42 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%7]) with mapi id 15.20.9160.017; Thu, 9 Oct 2025
 10:14:42 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v5 0/3] Add zerocopy partial flush support for live migrations
Date: Thu,  9 Oct 2025 10:14:15 +0000
Message-ID: <20251009101420.3048487-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::20) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|MN2PR02MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: be545d0e-f671-4be9-b080-08de071ca9d9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tl0B9LEFKZB06ab3dCmYVTQfuzSdLW5g63ydpmRgtLlWY36ft4WVvnCaTrt5?=
 =?us-ascii?Q?Mes9CEDLCI9WI8SfPQRQlBhjX9pLpWEsnTk0BwYr1y+6bYFWmjeEvwAg7N/H?=
 =?us-ascii?Q?puHPK/wIMvdPfZGRP8M7uSBrGgSMOoaJWu1h/ros3hhlZs6cfqUAh9VT+2Ys?=
 =?us-ascii?Q?u7u6R8MlzzAqXzOyXIdjQ4wgYmsglQJ41aG1qPz8s5fBgKEAlUO2R+Ipv/r9?=
 =?us-ascii?Q?lBpG+INgymsCQ30YeSvdEASUio+XjWt9pAUuCy7/KyaFMjOR650yT81zgEnq?=
 =?us-ascii?Q?bZCBZ5hK953DVAzR0U2T58qtcjYoB47DzkW5Hl0B7nSV7S7RAtcJZh3q8s9k?=
 =?us-ascii?Q?iWTSL7VOdA6d9VZMTS9uE0k5Cah/l1ozaPsYdwDvjJGJYcEoXK+XvthgaFc8?=
 =?us-ascii?Q?hQeFbH8lwQHCiLKn9xArjM/2GX4s+EYcHJvHSnSZwgoo3pTaJrOoXJBm6R5f?=
 =?us-ascii?Q?BeIcV4gjassbWdhoYEMyQdTYHUht7AqdyLL+exsPyl5uC+UNhhlEWWiSS9Qv?=
 =?us-ascii?Q?/RgxU8RC4yHgElnTN7oYJG2c3dZXRNFgbDWODaMg9gtUMhXNBlGVc9MFVKpn?=
 =?us-ascii?Q?yFp28t86dhXfyBzs1nzrZL6QOmzGElE4nAvHJ7vG2VdjbgEGPMA3swk3y3vr?=
 =?us-ascii?Q?GvWj0w2aDa36S+mmxLelFo8WLABEoV2HDoHw7Dful+m0nZVJ/nN2o+rrngWM?=
 =?us-ascii?Q?m9Q1l0bREM427t6uc1xS5mtqJSiFFw5OjSRhI0xl7RIK0MFlzKMF6suALh4t?=
 =?us-ascii?Q?wuMN4/QW8feaRwPjIMQVTGF4FF4cOvRVFSrlaNmv8qPmDLe7UJeAeCbDVp+V?=
 =?us-ascii?Q?Cg2f//SB53PM1JXRTdG9S49qouUv9Z9lqxU1bLzAspotbfEQuevK6VTPp9T9?=
 =?us-ascii?Q?cVkItbzTE1Plp2xZzkbOtKdzwtar29JvK527/pguqrKn7W4GSm6RDDunIiAe?=
 =?us-ascii?Q?dplEIwmPKjZD8z8xG8VEnUeex9ChVZIx8ji4z05WYE3zDxjOnf0yt9dvKwaP?=
 =?us-ascii?Q?2KygfLOuNEEnSEBitRCSKG2dJDU/2579cK4a+0D4i84f+tp0vmyBccGQLSgE?=
 =?us-ascii?Q?BgB8EPwok8bPxK7EBI2XAbhi8qELVYK+/arQIUPru3lAW0AhwQgc0ri4OUAh?=
 =?us-ascii?Q?SGQ52Rmyj2WsFugQ26otows7FjDBAcMcv0CPUetbiGToAt9M8uRYDYFGbxxT?=
 =?us-ascii?Q?fEgf8ouNYZcKKoMRQPhJEwSyRbftLJ4BatTqVbg+v6xBeExCOKtUKwnKu9pT?=
 =?us-ascii?Q?bRLXzU126T4LC5K6NxQ26LyTjuiSyrZq88hTDFmi2f7N9A34nklRkNv8UTgv?=
 =?us-ascii?Q?5giBhcbRrOH3TRq6XyWLVKwjK8EjmY8Y6fvp+0kv+0WbTUE2VhnaBYeSejtt?=
 =?us-ascii?Q?MB+mCWVXbFHQImAg600pDxdLFh+QJQ66wncBhne6XPD27Hj5CvAPLVW9vs60?=
 =?us-ascii?Q?7eCLjLj+UlChzTT3U1ZsOIdSmV1Y0dC6dc8KrVJcQq6xwEaPFJ0NghDC0z4z?=
 =?us-ascii?Q?5Wp2oUhv8a0o7HY+ekGYUQENRL4rAaDbL0JF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?52d9EtOSAfOOtmG22Iu+0ME0tU80FrYneg7DD+JGWzDdHyCxEQY+EeIFtGaU?=
 =?us-ascii?Q?eqxi45yrMmR7aE3+weKFJGCdXHySqNGbWKtt3edtgj4poUGEtEPtEBq+Y6W3?=
 =?us-ascii?Q?/c73lJCpD27uEwgpOW73bU3Ojp+JmXyqjkL32QUmIGhlxRcnlvI+n87kUc8h?=
 =?us-ascii?Q?zslpxFwoyQ4xzleiu5TxxqQtJ0b2XxcdhmbAdszGKuCxY/jEFaPGRqbHPos1?=
 =?us-ascii?Q?YNvO3pn6AcujhJl+RUEtra8g7mAOZ/+J6UzUunpZPgsH0g/rglsfyun2vCXK?=
 =?us-ascii?Q?oT3IHThqGctS8Ww3KEIojR320XV4khr7HjQXukWxWS4N9XdEY5MZMtUOQGi6?=
 =?us-ascii?Q?VGbW3GDMZkqeBSyZI0bQiPqvWTjI1ngFYqjyK4FC/32uGPlmt2ndf1Pxdusm?=
 =?us-ascii?Q?lBi7FWAKYfgnxsLhj1fQ0P1b3HB0pxYMFMwfedz6gk1cNL+rOA7BYSee7X03?=
 =?us-ascii?Q?bho9K6EV2fqs4v9UlTHhYxsdYrHYI5QJ7sZMPaP4xngroFPA7qcHleMnCqMO?=
 =?us-ascii?Q?cJZ/+F3MULekBhLg1YUjAT7UMt9TPV+28G1f94L1WfFlgQntHqaV1cI0StGk?=
 =?us-ascii?Q?+yGRqWJTReVSIQ+TyvfK15yhvHX5dzDffeV4LG3975Xkuy3AZUM9KMJu5Rhy?=
 =?us-ascii?Q?sAv8AB0bARbvU8TfqvI5r7949hZmkXbOg6o8T9MDaMhIWBUG1MnzhVuV38BK?=
 =?us-ascii?Q?u81FJgccNw92biDDOOjI+cg8zDDaRhhQiJkxQNO/v+pDj1gAFEOq6WUsh1cO?=
 =?us-ascii?Q?u8rhYF2IRbs50xTpN1MDqAWFAKXGP6405VARQTtzQM7H+4LNWxY8QlnTVf84?=
 =?us-ascii?Q?52QlDVs4rpfAVGsgAevLROfJUB8gms/jkPPmyLDzFGGUUg5mT9okRMQ69JGH?=
 =?us-ascii?Q?mh0HY3aJ5joa2pRU0G1tq6AoHF8RS7/0gyQdcMLVAINGfLo6ZBUqIM0Puwov?=
 =?us-ascii?Q?D/SuCLO8y/JIMqStYoJI62xw2jaLo1ZsuAJY8Xo7AHIIYeTgcCMMdX+x0iXY?=
 =?us-ascii?Q?NMz1nw1Qir4VYYTQfa8ZNLOzt1vgwV8ZCRXyMm+/kRzemCYmi/ayphVP6bBI?=
 =?us-ascii?Q?1RvLoD2k736Pb96CgMOhXNz8mX4P6JrwP2JIbYCyB80VhDB1zhgIlKu4I5el?=
 =?us-ascii?Q?FtdEHCD/+nW7HqlJln0QJ1ZYptHSPXLvWNNlXOGzxbedb3lLueym+i7tTUyH?=
 =?us-ascii?Q?2K6uzwVYhgyn9q2EwUsDIYPnz36r4gD1EPPjbCFYQ9JO8xx9aa95ntFIFRCc?=
 =?us-ascii?Q?kzQlZCZwUEgm2HhGqW9cY5yBz6LNP0+pui1FCYpgVQH9pJG6wQu9gEvE72gQ?=
 =?us-ascii?Q?y94YmMyxTJaRCjz4Mjsi575egFXBTbF3tCuv2mZcvKyeOKHCQEQYmwA8kSZc?=
 =?us-ascii?Q?vvl8Cse8aF+8WO/dTZYdr8+GXWuZ34DBq4ZrFwc9FCi13DCSgRRoOcp+2Dbc?=
 =?us-ascii?Q?Gq2g+PCaVpUU4FU17fjljuhdUrDjCaDzzYejxfQzQus3zrfO8+W4P6hBKDmb?=
 =?us-ascii?Q?okL/c6ne5d8AIOX1a2RM0X7yJ2euPS1/MeprAr9FU2GGs5hWZ85LAsGbHG25?=
 =?us-ascii?Q?wEeD4UcF/OPwsI0fbJZasAYO82dryPQSTyb8KKev?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be545d0e-f671-4be9-b080-08de071ca9d9
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 10:14:42.4389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9FJL5SZWlU//4A3QtbGC5KtkXE84DnhZeULM4K+MlDoSM1ukg2CR7Zyxy/TZCsqNS+N82KWhBZu2DF/mJQ6VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6973
X-Proofpoint-GUID: H-dLDEhzECgEcHtBpCmBYFoHriDr-kJh
X-Proofpoint-ORIG-GUID: H-dLDEhzECgEcHtBpCmBYFoHriDr-kJh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA1OCBTYWx0ZWRfX/RJFWhFx/0wF
 1VksrA9ZI94m3SdIZQlMcy9wKbOv8vfBkkJGOct8NkgzlAoprTr3Lwqmu/vbmgES3PHVRiFqGb0
 s9NJNcP4/4Q+DDW8fPPTiWukbAc35RLbEeMmt8PGW9KTDfcl7PRPjIJzn+3uy0+ri/9aGE4FXeR
 46C0mSMrv8RQdFl2H4Gs7y829HnXAP5SitrApcZB5HheX208fX1Y7Ap1EDmsUP0EkTD6V8TWMo6
 Z0gQnlQWiMPJWiG0DFVyTj5JhxbuFiT5rL0aKIzNSeJnR3+8yQ1zwZClCLP2jWT3Y/71T8uTTBs
 rG4g2Q3quvge/AFUZD1Cg2Zb1kqJoQgmzlJJlFZXIKVYn62zr7bipKLpxMvOVWDyUaqUdQH9ZLL
 z9M++hXjXkYnhAsnwFkJ5uaXVCysZw==
X-Authority-Analysis: v=2.4 cv=ecswvrEH c=1 sm=1 tr=0 ts=68e78b15 cx=c_pps
 a=c6dg65S2wtm7yx+exz2oDQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=oDbL7gjR8uCct6WExN0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi all,

This series introduces support for partial flushing of the socket error
queue during a zerocopy enabled live migration. This will help reduce
live migration errors due to ENOBUFS in scenarios where a lot of
out-of-order processing may happen.

V5:
  1. Introduced a new write flag
     QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE, which will let callers
     decide if they want to do a partial flush on an ENOBUFS.
  2. Added a "blocking" field to QIOChannelSocket, which indicates if
     the socket is in blocking mode or not.

V4:
  1. Minor nit to rename s/zero_copy_flush_pending/zerocopy_flushed_once.

V3:
  1. Add the dirty_sync_missed_zero_copy migration stat again.

V2:
  1. Removed the dirty_sync_missed_zero_copy migration stat.
  2. Made the call to qio_channel_socket_flush_internal() from
     qio_channel_socket_writev() non-blocking

regards,
tejus

Manish Mishra (1):
  QIOChannelSocket: flush zerocopy socket error queue on sendmsg failure
    due to ENOBUF

Tejus GK (2):
  QIOChannelSocket: add a "blocking" field to QIOChannelSocket
  io: add a write flag for partial flushing during a zerocopy write

 include/io/channel-socket.h |  6 +++
 include/io/channel.h        |  1 +
 io/channel-socket.c         | 80 ++++++++++++++++++++++++++++++-------
 migration/multifd-nocomp.c  |  3 +-
 migration/multifd.c         |  3 +-
 5 files changed, 76 insertions(+), 17 deletions(-)

-- 
2.43.7


