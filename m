Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA3DC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xC3-00064Z-LS; Tue, 08 Sep 2026 10:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3xC1-00063I-M4; Tue, 08 Sep 2026 10:53:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3xBz-0005QE-H8; Tue, 08 Sep 2026 10:53:01 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688EgWFJ3513497; Tue, 8 Sep 2026 07:52:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=1XaYEmkaFFGojd7
 UzIb8om8AWvm+W4/My9EaEqRs5EE=; b=w6zG8JN0DRFmd/4Sr9avebz1k2UE9Zm
 fOPuHmAyUg3b5YeSaQSD1kHH2GnB/ylbsepypPDmI3oSO17Ac17PUlO4rYhTR7ix
 rSI30dtVxNem4C3apOszbA8YxADTJgaf4Ic+8oLx2576tXkxEpWuIMF76839h978
 OV8gyCp+xi7WDiwPWKO+XuDnG3m5/0h96bGECcFo19o5EV+FRp0CEOBCgGZszttd
 GfZX52xP6nF1mr72ksuS+nKauODYSgmF9lKmGW76o62HWUtPIbtiUjdbGWTr3Tom
 JiuH6SBP94xbs/Xd2sdUPl7O/Q2SwAb1HbLS8NaA2mmuq/NShlowyyA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022090.outbound.protection.outlook.com [40.107.209.90])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggh6ewtyq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 07:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBvLvr9ZkKzLD8VaouXyVUsB3CygDEsin7PFoJExQ8xNazVpZQVUJwpjt4KCpwSCHS0vx5Cg/q32c8vFVKwm1wloGS/qqND6BKh01PD5HC7VoCSOqHeEBZDn1+7Y7GbxdjEZp1Ne9xRI/H/jjQ30doSIzs1X/ue+9yT3MZ+oML2nNVjFFVI3F2BULb4+ff7kuNEwLvwMTed1fuAtSEvrVvfn7Yy9mz5+2KFMTBOZ1HmJzKqygmN/BthEH01FBAq8r3BSH8evP0feYtlUsZOUp9uD6I0U0FfwCnc9I+mOVgxFAfT4Jf4PSSn1xKNjVjYWCO1M4WD928gQIoMjRKHiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XaYEmkaFFGojd7UzIb8om8AWvm+W4/My9EaEqRs5EE=;
 b=aOVoULWfRD6Pzzd3S6MxtyaBUPRQylNvdCPsqbI0rdZ4bGXnzP7hhaZiaSk85pWYBA1mD8xg/0Zb54xtIyANg789S8zcKqMPmTP2zqih/O/q27PnwXZXxBbQzrNEWDpvCF8blAnz/Jj3Qe3+O7zf2rsJ16+zp31gaLo4XMsnaS6O1A7z1t4i6xpbQMbSMxRATYLxUHNdrbaeB9xmYtl16xIi7VhYPkwJ2JnZpf1RubT798GE+95yByzcJ3+tDoTShoAnf+7AcIKt2/jwK53NtCJehSkXH9J+fXi7YDopnC1WGXJndu1ynboeotLQBYJOApSqV7C+8WXppju9LkNkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XaYEmkaFFGojd7UzIb8om8AWvm+W4/My9EaEqRs5EE=;
 b=qh9kjdZ+BHZixG8vA/JbZwGf67r1kXHmB4X9novMOZiGTn2hBFnIo5SDl+erOhJNcgFVr72C0sTwdT4BgNVCPqLCwA37OfkDPD6Bl6KXhGC/4sN1t96hObIskYHYPTM9j+Rg3+el0V5nHgTnaoGTGqNf/licwo2sJfhvbG/JhX0vr03c5yYvevR69513x58AL3gbzTxrv8cz+N4R5VdrkY0LFEbWOelagBOhRe7hAIJ6r2HYqn+6gdaqFNSg7ZCvbu5Qv8/E9bT58Q9K9U3k1QMJvncefv9DM6MrXB6W66qwlectt7q8C+7oMwotvWIYsU57hskkAWhnCvd0z2wlGA==
Received: from DM4SPRMB0047.namprd02.prod.outlook.com (2603:10b6:8:6f::16) by
 BY5PR02MB7027.namprd02.prod.outlook.com (2603:10b6:a03:23e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Tue, 8 Sep 2026 14:52:51 +0000
Received: from DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73]) by DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:52:51 +0000
Date: Tue, 8 Sep 2026 15:52:46 +0100
From: John Levon <john.levon@nutanix.com>
To: Hugo Komatsu <hugo.komatsu@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 6/8] vfio-user: enable DMA logging for dirty page tracking
Message-ID: <aqAhPpMOoYERK0WM@lent>
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
 <20260903130833.1437632-7-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903130833.1437632-7-hugo.komatsu@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::13) To DM4SPRMB0047.namprd02.prod.outlook.com
 (2603:10b6:8:6f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0047:EE_|BY5PR02MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bd2035-9ba6-4d87-60f5-08df0db8db1b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9l+C5fZgbw0vmxR/6i5p3praC5UtZ6Q7sybLmi9/u3mSzGml6UC7c/Dec2y1jPnom8eXrK934TtGLOTF068V5FcfvDEl1PwUl+U+QQbhFDcNjKwXvRtCmix3oi+pOCGpCkwRStWYP7pzOaE6L73Y4h4OqlmkiTKHv9b6pakQYDrUe8p5+UVV63njHmzZdQtCrUJS9+djl2ylbRsW12JYjsQg5/L3JcitfvhhrQ0PZuLvluLq9MnZwZ+OaA4RtS/DI/4ZsnHyUjDbL9c+HBe18Fn96qhyBau40y9dtGWIfnMYxfKO2Am9UsxzAeV4n/MWssg+jsmnzIvRcTXRBXW6XNxBKIbIlLgG06gD5shs94lWTz4LSLVVU5J75EAcsSZoVGKxn9SHlSF7am0jz9f18Bqib6onfY+rgtWpzc4lMyU9bhGj/5G//bPp35w4hlvBURMOANEnX2xqeZp+U2kDJZhaSZ3JN18Yi1XA8FnwFg5rXKYSvlwTfIeqHjCt2k9G9SPrPjZrRx0ou77NJTTzXiC4ywHI0KOeOVn+uG4P9Ef7uyql/dTHKU1pU0nMx+1stFxgEBxS89o9ANmopFoEGPsRHoXwfSKTmVBOpd0aN6LXCKcSERLJRk3LdQA406yuNl3VeTLEii1dTh0sssov8t6Sqlx0mFf9PQkHjbXr8RQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4SPRMB0047.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YkLL+S8JD/fx409zK2Q1M6FfvjHMy3S6H5VWV88cHJPRSfUCsuIygDqQ/6Ba?=
 =?us-ascii?Q?aNbMDMNmrPk8TTLENwJw7HtAIfYjvhcZGkYCqViHwGs3FOPuMTuPN5kQY7AA?=
 =?us-ascii?Q?4NX5oKiLrP83g78co//v+ajyNQZu7cmbBJTQh2fGh2eqnSkJern156RpZXyI?=
 =?us-ascii?Q?cLXbCtef+iUxa1daAUahJqPbSNIKKZrVONu96d7RSNrdrHRP9WlMGSlR4fbN?=
 =?us-ascii?Q?S3TZOwycldAdW7g4EiX8Rswfsmx5KCRr4zSD0BDP3i8SpBpQAIwPQB2pLE1O?=
 =?us-ascii?Q?zqD8zZEOSqUy8SKn+quQ6Zbd6dmBQZnqNPKlJCDtt7IWotFYe6We87qktHjS?=
 =?us-ascii?Q?QMk5hIUtn0IIbT5j+d8MHMVh+3lVHep9+u0bD0wDmvBCAZojUpC5uqt8VCO3?=
 =?us-ascii?Q?2CQ/r2ZqY6+/4ZhSnV7hMcKZSz8wQnDVAXWyGb63jGEqgn7Oe8xNg0wgC1jL?=
 =?us-ascii?Q?dg40hEQl1OIc5lsKi0BVqgtcd7Q8p6g15XmgzTwOXx8VGmhnBhcXavxzW7jk?=
 =?us-ascii?Q?eKale6gYWMunaj7ylwihTwFaiQ/kM/UXUhdFm2tjlSVZ5GOfTpie+DOWD+7C?=
 =?us-ascii?Q?1jF8u6dQTu5ozFBcHTkkiiHWMay2559v4l2pGkv228Ojv86fyGZyuGDpAZbp?=
 =?us-ascii?Q?EPxkdcuAL7a39VAxgCvi1Qgv/XlxR0KK53npBMTTOc5vXM3Ah9pkLXbe3Jc2?=
 =?us-ascii?Q?xJg9vPZhgB1iP9NmOqjEOAwHrSqBdOGh9i6f2R/sRHMi1xDzNKMb6KjmzkVd?=
 =?us-ascii?Q?2xR5pUx5NTmCAQjLc19mD5BB3xyYGj9MIRht0jlH8dXVoV67ZOaF8n7Cz6rx?=
 =?us-ascii?Q?EOg6LKIga2Dy1QkIDu5nmK2JuRYN7KYoLSSJhciqd8y3F2pOQ4V0U2zguF1w?=
 =?us-ascii?Q?gZw7/eMByGBfnignymxWCLCO9q0p1SvB4L3KUbfxmHKXZ64rsVSR2h/GjFxx?=
 =?us-ascii?Q?RbHBc5kY9Vu5M+o7ZbAirNJI2KETQc+h+MJQWqLtohegFTAOYltKahs8VzP9?=
 =?us-ascii?Q?614HY/e0OXLX+H08NZvb0W+9joQPLq7wkHo6W2WFU+0zkOjMwBcI7Q5Zobu1?=
 =?us-ascii?Q?iTFeUoX/lr29O8CVVTBm4qsXNswGHmicMIJh3L3TkPhefDrymBH6Cl3Aq0pl?=
 =?us-ascii?Q?6HL3u8YM3E6qj0HoBPgnPZyWic8JPiGw394Kok6r31DCNOCIzJNXmxHwU30y?=
 =?us-ascii?Q?+eqS2kfFAs0/zqYus/QRlo2lwxq20WsEgCi10oNmg9DRbEnNXrFh/mxNMC4b?=
 =?us-ascii?Q?UHIHYS3WCD5pLOZg643V9KvfS1tJr7rRCtf9OSzDg6Pj7TRYEHzgo76SJcak?=
 =?us-ascii?Q?EBAMtISWKSmuMjluN+CI6k5Wfuew2oK4NpTJrQf31Rx1dWmdeZWIl2r6hkvK?=
 =?us-ascii?Q?Wo3SeVut298p4eJp/Rm+oFAe/2VmZ2GyraRH8trm63wv9AZEs1iLIClrZRc9?=
 =?us-ascii?Q?Qxxc0kKzxv1xwrPXh4nbdw3dCkpxhCGSRUMsv22AsvmIOK9jpJmHEoGSp3a5?=
 =?us-ascii?Q?4gBWcAox68ZTao7ldJXpDcAd3rwEz1vEwL7FXNcXH1YfGGtVyoe8q4iDVDoR?=
 =?us-ascii?Q?2VrQoHFPuk76oLW/oDDuobCU+MdNLCy2J4SW6VMFFs/ZBdAmyXl/EMKXFxqg?=
 =?us-ascii?Q?d2e/DGy9eFVh92TwlQr8RZhdK3QtV8PsTIVoIpGb/F8wbnuBV1YNBNvkiGLt?=
 =?us-ascii?Q?wHDWlGCFmutcikqFhbTAxd0XwknNYlrh1NMVnsj3sct5n9ZNdymPUJAwaCZi?=
 =?us-ascii?Q?YVJyKB1qrw=3D=3D?=
X-Exchange-RoutingPolicyChecked: tjDhcE5k3Ik1/RrinW+SfWJi/h04tA7FNDG6ZzQ999NxT+7yrmq0GRa05+suvFQA3K1FAT+jwVgFWvNGfK0nFSiZzPsX4mQ5kg/UpCIoV/0Lh08ADhYT0iux4iMkqRyB7m322JALpYL67JyHHFTHrVHbD9vVsVCbL+7HC6ALs6T37BZh/S2TcYUb0g15mMDxRTTFnfHo+fXI91wYLzhKB9xIY94Po8BHDv6glizVbzEaaZsahqP6L+iEkoMvdfb/geY7Cw4qNLqpc/EH8G/qzrra539zY3tmtHzQyenGOd+1xxFxKLgfyNSrdrLTEuk31BXL53WMckYbO5PFx1dEWg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bd2035-9ba6-4d87-60f5-08df0db8db1b
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0047.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:52:51.2296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnHCkDYcxFNYOmaZXV3Y6Fd/2t/kWfhjjc/uQo2FbN5WgM8kqqxDW+jhthTsCBML5g9xoJlFrL2eDQ7MsbFNHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7027
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2MCBTYWx0ZWRfX7E8hM8sbjueF
 tZkBE+XD2kc9Dh0buk2glqlVgyVOR2YuHc/aLtD2wZ0ljx9baxnEisFc5K86VUZPXbLiKG1Uvrl
 tT3oAgp+TtNXlBVj5aepf2VcpD67qwW6zYJuK1dqdfSu8Mnu5P9zRfN8nGwXERGgQswOxTLXAn4
 x7zl8RerhTe2Hwp3sM/Al5c1XZ3wUpeZ3ZRz1vFPUlEvhpfjHQUn1r72hLcZAegoYnS3ASKHwR+
 TkqUAOIDGhf483NrnMOGCxuC7G56CsCvCQWYvnkg/kPFCH+5L4+O3YUMPryGzH7F3nw79gDS2LL
 CwlbQ/rk5Z6wQCgCL4MrnfMfzR4kALk63fnOirT6vdPlOI0tINtLIkV9kCBJSQctRPia6qOt/07
 +jPFdnisjRS7SmSj4XQL+E4LtwcnIP1gy2HjFtn8Us+Ggzhil6WYK3oUljV+0n9Whbpe4FMVh/H
 0hKbFhk0FzaGAHy+l6Q==
X-Authority-Analysis: v=2.4 cv=I4hVgtgg c=1 sm=1 tr=0 ts=6aa02144 cx=c_pps
 a=1PqGgNtJULpArpxDQTgF9A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=CWzP9rhU5QGja8h2gWwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ALpZ42Ljgn86wEIkRmDXl3qjvUMFXsmf
X-Proofpoint-GUID: ALpZ42Ljgn86wEIkRmDXl3qjvUMFXsmf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2MCBTYWx0ZWRfXwg+aKT8j9knx
 EayzP6q86L5p/2wrCy7oMJV9qXhVn6r+tpce5LiS0QwBqqLabOJqVVWfO914IXRSfdaqChLdoc4
 gH7ZNyynhzswl3PJujq+9EkzyDw4BCA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 03, 2026 at 02:08:49PM +0100, Hugo Komatsu wrote:

> Forward the DMA logging features to the server so QEMU can perform
> device dirty page tracking. START/STOP and the feature probe map onto
> the existing device_feature message path.
> 
> REPORT needs bespoke handling: the kernel struct
> vfio_device_feature_dma_logging_report carries the dirty bitmap by
> pointer, whereas over vfio-user the bitmap travels inline after the
> report header. Translate to the wire layout, size argsz to include
> the bitmap, and copy the returned bitmap back into the caller buffer.
> 
> The server only tracks dirty pages for ranges it has DMA-mapped. A
> range it cannot translate (e.g. firmware/MMIO regions never mapped to
> the device) cannot have been dirtied by device DMA, so such a report
> is treated as clean rather than failing the migration.
> 
> Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>

Reviewed-by: John Levon <john.levon@nutanix.com>

