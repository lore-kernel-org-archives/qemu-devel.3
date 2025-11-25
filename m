Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33064D0EE14
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 18:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNxaU-0000mr-H3; Tue, 25 Nov 2025 13:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vNxaO-0000jr-El
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 13:16:22 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vNxaI-0008Hq-KU
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 13:16:18 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5APGi0dp4001984; Tue, 25 Nov 2025 10:16:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=dAEIDkKSfdrb1ER
 O9XpgThqt94loellavzQT/0o2xqw=; b=FsQCP5D3kkc8VGSm+s5fdHAoSTjZSui
 432/Q6YlWFpmM2uRBBgdP1MIlkqg2o8V7V1y9mJ3JbWuKpeXFWsUh70dLa5YzSpu
 evw42qVLkm4x1fgPKmD/o81pkBTNiePwc5mvhIXqgr2XgR+Ivk6mwnQYIlhLFLvr
 p2f4fDA5WLQLts57XmoWiiM+PJ/ppme9Kn4ZEndg9YYjsnNrp0+SkOa9JXweVSsz
 /f/V5u0tfhYM3Slqsx+IQG2oNEgUDw+7x3BG8viGzYpT8a/iwcDUy9qkKrUg1MS4
 FENUGgkLEGZsFb5uy0LTMmR3EOEPgLAyG8UWUbKSfZX1h3ccVG5gFug==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020106.outbound.protection.outlook.com [52.101.85.106])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4amvetanwm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Nov 2025 10:16:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPNBq7EQ9NNg47qH0fqusarvllVYKU3cy7Oun3GL41cPHpD+72QlfZog80QVYE4J0Pfyy72+9Efv+TdmlNh7Wk1UAM6Q/ByINEKLBksZHI7Xxo2ggWuzFIOA4jQ/cR9toYsvTrpAGtizmlgv1xZ64+dns6RbkIWb2wFUX2y7Uy+Dm+KqVUCZ9vO2KqklxGTXv624+0ab42FdL/ROAcqBIJ3NzJQz/YnBKkMW5QisopKeFp2GuamtUtiG6ShU7vJEXsFCePNSVDZW0pH2x3Zbu1RtviixRNpgzyEWYwHAI4rKCMpXZVXNg9bJhyzET4XfMoMHrbpcoyb+4ZKwQrMoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAEIDkKSfdrb1ERO9XpgThqt94loellavzQT/0o2xqw=;
 b=xwzRcIMw1+0Z22hsukkLS2xsfEs9ndXh5uXcHjssJ3x3j+gyzuN9GsSuF8QaVYL3LfAiYcUOpJVAiOhsfWoTr4fg9wFw3yMkO64N9IY2KdzEPNwT//ZK2lsY4qjscjgTT/DlO484d1TQpC6dVENSu8IAcfBQ+Zq3OD4ayg8upyoQDfx23ItAl9LbzYkPc/vnJL8Gge4tvFNE0nXE4E5/rxwqQgszF6OjlxANX0P5QuAtZwFGIBmmQ1FZleS3hzMBLbdawKa6KcscXvjm7X0c4Q8++WD5f6i6XAEgamsvsi6RbZbXoeWGtmakVnB14eMa5o4C9VWPSPWWazpE4NKoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAEIDkKSfdrb1ERO9XpgThqt94loellavzQT/0o2xqw=;
 b=CiV1sQL7+H5ETIU+joKtHtQ9SaaiTqvm7/hOgjEA57s+4K8F1Dy5PMul+06cDJIzCwID9FEvUOn8o0d/xpaexFFOw0VaVBZaIvdjGwgzw75Xzjqze0+5xWpEGUOkoKyBvt5Aig+zTN2tO6g7T24G96KEDs0/ryVEJiUiBcHVIez1vJXmF13KabWHiWMy7B0JMGwugh+lt2XN72AGgszpVTrYlLeueu9jYUAQ9c9FYkGEvGCzJ7Z6c+OiOP5BGG5oCZn7PNcrfBw8ExAw6jHiNptZRP8rZZECngbUSdg87XhfldOqlJ1/Po5B8o1PQdjkX4ROt8wjQZ1IJL0nRJguaw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY5PR02MB6769.namprd02.prod.outlook.com (2603:10b6:a03:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 18:16:06 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 18:16:06 +0000
Date: Tue, 25 Nov 2025 23:46:00 +0530
From: John Levon <john.levon@nutanix.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 4/5] vfio-user: simplify vfio_user_recv_one()
Message-ID: <aSXyYNzpuYAxAfAr@lent>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-5-john.levon@nutanix.com>
 <819f4595-b323-4dcb-96c5-09c52cb09380@redhat.com>
 <CAFEAcA8+3=ZErD=pxs8Ne9+D1ZXujBKh000XiQs4egXayw9tcg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8+3=ZErD=pxs8Ne9+D1ZXujBKh000XiQs4egXayw9tcg@mail.gmail.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO2P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::31) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY5PR02MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: c484bd60-b24d-4ab5-2600-08de2c4eb386
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iq/2pLCcyQUbGfXn1+4j2PJL8TEGu6QSajD2vm5lrAYXfLdZ7+24nHvF1M4Y?=
 =?us-ascii?Q?xZey9hHjpHjbSckJEDAbAlvVgAuBfJXmtCQ1eDtKQAQxbu6a/pRjwenpDHsA?=
 =?us-ascii?Q?+51T+fRuk0PvXbowC6wa+ezFrTe2cpzelSHZtF0+xxXvWUqZvVZhKmuP1qPJ?=
 =?us-ascii?Q?uTV7u5mnf48T2yZ9Wr6DU+Ef+rtcWZzPkebbuWKAcxXqK/nEV4NWrdW4OPls?=
 =?us-ascii?Q?tTXGD0Ni8mp6eqo6zjl4cubpGxHa2q09xpWyDgm6HlQ3fFRXwhbAkQEsC5Px?=
 =?us-ascii?Q?dIPOH+/mJEJbYzImmwl7R2iQ77giQjjAzuRG5IJsdvfXvWBlOiAVcOnnydao?=
 =?us-ascii?Q?uVyOFZhcnL8oHTn+uQGUCVbYSiDB0Klf/oQN6gkiZK9QwmV+SrxoFIaIcaOT?=
 =?us-ascii?Q?jo61lnyCIG8TZQz/gRCjSynvvxCLqUaS4VpjQJweapUkjOHuAgrFyZfi5Y3O?=
 =?us-ascii?Q?W6f8Oodt6nQLD0cI+sbt3oK9A+B7D9irS3GqPhke4QpekAhl5hoBmaG9tZsT?=
 =?us-ascii?Q?jqnfxlt/uZ5T0xfQzPreotAGc2MY89de7NNLHAjkHdz7//OxoCUU7+9tCT6h?=
 =?us-ascii?Q?MaTNpKPanmLhZYAXKijZ7vAMYRXJrXZAQ2/15RJU2i1kYDEQEsfGVwB2jHZj?=
 =?us-ascii?Q?D95mvD6xK+3FE59zxOsQAE1X35fspHnjdhgIbW4TL0d1q6T1UqIRKtzUGdR4?=
 =?us-ascii?Q?0i4X6khqhZ23xyVgedKB+YEwWNeFxz5/15A86pp+oiEFPzjOtI2xWAwQA/bf?=
 =?us-ascii?Q?nEgmlWifAkm0K7eVnsF7Pk290y8teWuLopcLw3I+LMccEBOk98LZ2pGtOul1?=
 =?us-ascii?Q?O6h96VR4UYZPC7CWjZhlRMlnfdxG0xEil9UoospmXLsFJwvqxH+t73xRkN1y?=
 =?us-ascii?Q?tUCd3gkMi9jkNtILVPlZs6ylxpv9GF2uoZ9RWPe+8jCI9PtYerMqTL2TVxev?=
 =?us-ascii?Q?mVtkm7C9wadkEnpNWnREzWQiYFjtZSCZ9X1F2P7r6TfTOXQky6qGHN3bF/qS?=
 =?us-ascii?Q?uC8kyyrJjdObWse/h3p4dyDv1XCp0/Natha4bJAaA6Ke6q2aF3C9ZB2FGSbU?=
 =?us-ascii?Q?+aNBjMTrTbVhQuApSBe+YTt19kk41YdAVxIGrI3G2biLoGhSkT1X0EKShxQ6?=
 =?us-ascii?Q?VIIwA0tziBIeVLLIpusLIT83Qljfu/d8lQ7FJ00gMZBgoRdqcC3I/AR3e01H?=
 =?us-ascii?Q?+xhUGMh+cJnIrtQDBlXltDrfcboEiqL7+W5h0zrDMI5KXYaWvB1sxCerlaBa?=
 =?us-ascii?Q?PpvvJasWOhp3gQ8c5UWDVcXhKkKb3tsyvonUaGxJMW1o1fDqeXsdCSDPwSg6?=
 =?us-ascii?Q?DgwDpLkuCEx4t9J+BNAWolOTR/Tmp8OWnrcB0t+ul0Nu8xWmstnIxeDY0fUw?=
 =?us-ascii?Q?0LMAFm/+ETDNjvWBFvxMI7T9fZpKoNyVDdA7PBfi5E6oqw2fkBGDSRmJih/q?=
 =?us-ascii?Q?I9TGpcyTlGro8+JfEmL/x6lwKCXMlPOX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+OEGCU6gErMlUqlBtJlEvwpvo3LHNShrb9sBu8FjgUjOpxwL4b861u8VvLS5?=
 =?us-ascii?Q?rVLX4GqtqySibilTHqn9XAlg02rQXqnXfGI33WMVbjyMJcAOW+IDDZ8sqAFm?=
 =?us-ascii?Q?xGmE0h4zfah0GYu+TSitKmhKhn7zWz7N82vdxikWVoVeq4lsvuHpPKeIvElB?=
 =?us-ascii?Q?kRLK2Dpk5ZIj0UaFugLhnFd/mXz0jq/H35bc6UflFLi7w3Ac92VoZUFDgFZH?=
 =?us-ascii?Q?NqXNkcGdCQxqV4ow9NxePAuoCqvonwvR4IP/Wq3if8HngxeP6LayPCqi5hy+?=
 =?us-ascii?Q?kB1600hOutJz5qw81gU4kspHXYF+ksQaH58+3t5AosBxLFTUtrloNB91nhq4?=
 =?us-ascii?Q?LAsfYO2tQPYdKhvU2acsrrWLFxJCyx4a7YdtlfIFQihMsMrBUZMn+xg9vMgS?=
 =?us-ascii?Q?WdCSeSZuh2FshKsmrSkB2JeNNxS/TySKXejL1nk7F7ggY0kJZs60jWK2gliu?=
 =?us-ascii?Q?TIcMfwLMtpTKKRmNUFsB+uqPhZNSMVJKNdjDdqZhbqYWcXsiwyw0UHQGm86W?=
 =?us-ascii?Q?c7HpMqFOMb8U7MIcPtbJQGeGp1IN2q9rsdApwt9j9B/AnIwVhIwjHgr/AdZp?=
 =?us-ascii?Q?GVzvzxHGv3nD+3VR44DbTC94ttGBBH9483D/5Z4I5qEwQXc0E+WEoLFLUfio?=
 =?us-ascii?Q?KwabPLtzyQlIVfZ82wqMl5ms+3Vm7s7n43ZR49pXLBJNeFcfGSOeS6rSpiDy?=
 =?us-ascii?Q?kSJQRiHSHiZoZDz0/E2b9EtmPCZgGWCU2U3pxAhub9hgI+0nSRTU1iwepF/Y?=
 =?us-ascii?Q?vrKhzPe5/2BoqPrWTf6HvreoX0uQGwPhSS62cXAuSJXcRob/N7gj8lGMI4SW?=
 =?us-ascii?Q?Rt8q6jm2YjXxtDFDKFouhcpm/TQyc2ZUakhg4O/aokzkaXk9Fe4wnGUR6oSL?=
 =?us-ascii?Q?c1jDQS6HQsNtMvzoazSWmS4f3AY4LIJj5JBHacfv/gqMgKNTNcz/FDQIxDmo?=
 =?us-ascii?Q?NnzhAXgebKC2BUyXi13d0+vNTOegCeRos0BFoi7D0dWEqcqMI7NuSEJyu7iB?=
 =?us-ascii?Q?zcuZwo28C4z7G5Q8f88ojgl/L9RpKJSaNGVsnN1AzsTQfzX/U/5TfjpDlaSO?=
 =?us-ascii?Q?4CPRJEfuLAJBXWhuj1NVHoZYEJMJPfTRVj5kG06fOqI9ZPMLQVKBJEiEjkCE?=
 =?us-ascii?Q?wzO4CberDRWFBpPOyQsUgCarBBLvqjDl5UT6slUo1S/H/huPWJevuiFLUqAv?=
 =?us-ascii?Q?MMTl6N8k7DpxGf62zcW4A2yirN0d54pyHylnrK3LVVJoNNk/kk2nyJguCG/K?=
 =?us-ascii?Q?9WcvhAFgmpGJzh87dq8GKdDo9z9yNIuvauuI0eo06QBay0Kb1dKE5+vNKM0q?=
 =?us-ascii?Q?E5h5z25TArKKJFZBG+reNuXrsrKta2vLyW5pGA14badwQ43xsymJpvugUe16?=
 =?us-ascii?Q?uUHZKeRcadu9rYA1/gRw5itnuIsAemiC69PmAuF0mXYxPNJY7uU/mjVXnoKC?=
 =?us-ascii?Q?/wwY08AM1FPXCA5h8MuxF70jiAYR6TAj9tU/ZzdHExCnKS78H5A3jr9h8T5R?=
 =?us-ascii?Q?gD8b1qTDqyrNxCBBz9E5EKnxoJ9EwL7x6rmI2V20KLJFsoYqwUDsub1ILkye?=
 =?us-ascii?Q?/VSUOy9vCVujWMkrmfyeyhcYYG+H6ZLnl5BvDGeL?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c484bd60-b24d-4ab5-2600-08de2c4eb386
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 18:16:06.6219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+OdW6q7RcwVzHgEYMJpu6yEFLF8/E9rHvT6oDReYLjNRp/U4UuUDs3vA9YNKY/IL12Z8v2H9VrnNrbHHLq1Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6769
X-Authority-Analysis: v=2.4 cv=OamVzxTY c=1 sm=1 tr=0 ts=6925f268 cx=c_pps
 a=cFfp9J6W/iLkiH+l/RQb5w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=oXYgHA0BUXs6zZWlCJoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: feWffXiUK5y-L7cCxjfHIUwy1KF7tRmS
X-Proofpoint-ORIG-GUID: feWffXiUK5y-L7cCxjfHIUwy1KF7tRmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE1MiBTYWx0ZWRfX0Khbf+qH1jHi
 pvHuFWznGbptJyQgtXIXEGXcyZw+jsE8nwMnoejJU+wzy5sGqIGZVxj+7qWQKqLBX9W0GR/5ndk
 cKOj2vkYfbkbbHnXNDEfOuc410t6eJPk++aeqHVtnnc04gXMvtAx9+2EBe4aDwBvtdp2337deqW
 f9hW8p96/oDUCQTv4N6uJvdT6ZCubs79cDJka4DCVZFcMNwSBFuwhFuPKcsJ0ycobx+UbnhHdYA
 ktAYXgv7S2TtHKV1Q+3dXv0sBs4k0Ct9eqniyL3L6/VweDnleFy0N0Yx4a0FSI5MMBayGwHoUGJ
 bxtA8J53z0XSH/ZHFW5w9JI5KTvSXjogwHvDuxKEHYCWOvaW3OTd2L/t/gA4vOFVZgyV/3p4xVz
 Cp3NaL2XMcV/vZNVKRTQ/N3IoKFOHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

On Tue, Nov 25, 2025 at 05:13:14PM +0000, Peter Maydell wrote:

> static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
> {
>     /* common prep, header read, etc code here */
> 
>     switch (hdr.flags & VFIO_USER_TYPE) {
>     case VFIO_USER_REQUEST:
>         return vfio_user_handle_request(...stuff...);
>         break;
>     case VFIO_USER_REPLY:
>         return vfio_user_handle_request(...stuff...);
>         break;
>     default:
>         error_setg(errp, "unknown message type");
>         goto fatal;
>     }
> }

I did look at this variant, but it really wasn't that much nicer, and still had
a non-trivial amount of duplication.

If you feel super strongly I can present that version.

regards
john

