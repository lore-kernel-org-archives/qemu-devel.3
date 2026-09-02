Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F745C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mAW-0007jx-S2; Wed, 02 Sep 2026 10:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAQ-0007hX-Mz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAN-0002A1-0G
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:22 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CXH0r1388201; Wed, 2 Sep 2026 07:42:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EaY69DkDJTBzHvj+eup9NF+JOS9n/aZottvBb0haL
 qg=; b=jd80ByLk5n5XZb5opZki0aUV9I63G/Y34SSz+0hEz6iNkYqoQ7b8gAUhh
 Z8L8Ap4e0keVT+wVqa2AodDe2g8biELPhwf/D8KCzozapqdSWer8c3Zl2KAMNY3k
 GE36tOZ74P0AlnpGLKZ63rxYHiCbVY+Q8/IqEp1zmkutWcAKavL3roUKrjsBa7zY
 M5YFH71/f4kH+NZE6DVgonMuNVzyATnFmgh/A59FWt9Uj6aozno2vRSyX07Btruq
 uZd4BcZ+OxgzIFhQmiA/mTzGOeNn40igztnYP9SIQ1toq+Y1LRYVQmmyA1+nK+Jy
 OIoXqrlCC5bA+J6pC8OTfaUhvCCMA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022128.outbound.protection.outlook.com [52.101.43.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ge0sg35da-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 07:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9JJelypqGk18nsx3cN14KpBOslB55nz5NRopscG8AMk8+LTVOgpNHr519oBWZRcLsn0xD2jGLiuyXwB8AjBr9mCn7+fF0CDdv36gd059A0tOfiE/J2etxx3VGE/dJFFJkKkeL9WRNw2fMI+rceFNGzMpg98DTeGIQOiWhL8ZG6eVlUkpBp3fpwkF/KHPhRdICUj4Gmxk95i49TO1McCIpOAnfP9Gdt9hDM3IH1MiBVCATO+inPfFhC4Tzh7O/B04v3YYLdya7Lr848dzk16M/RhuQD03DXECy06fnZnM9zBM4tyyQBalb7iAFYzaLJa3yuq7kjhg3JQSzBD8z6cNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaY69DkDJTBzHvj+eup9NF+JOS9n/aZottvBb0haLqg=;
 b=WLsSrY4qqL1KP2g2mzFSvMxkSWVpqs6G0S08Ier7AqHx+cOdMd9z8WX+wm+C5/yP1dTJBOqCyM++Lbpl0pY7dtbjlnSIty+SnB82/fGi+KF5CqFDsCdHrs3jSRvVFEVDxzfiFJbF/06yiI5+mV98Jy5DgjbwqKmLQ822ebVLyUYARvmiOjl3RaEUU0ZYKENDibScNx/oPEA+UKslpddZkLO//NQDoJB2GWBF13oY1BZF640pXlb1EfvBFyVCxf2XJXYu5zjE6F/Vj3xowwgqlD6X79zTPLT70dH4iJ0Aj7ZG1q/pDg4DlyUezWZRcjjyolkGkcb2W7pKzB2BG/y3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaY69DkDJTBzHvj+eup9NF+JOS9n/aZottvBb0haLqg=;
 b=GnR1KzqWGYExxTVLkKJlETQXhBPrTmgfEE1MdM/5vfGBfzs4am2z9/gdzN85u4RVATbsBalzHC03Okcal76PCn5vgNP2RarIGNFroMCGzJdGJ9Ogc7bpeLr4t2ZV46IyiCw1Bxf/GSAOnhOFmeiDkHw4dTK+ufzHZcQ3Yl6R9gjYCZdUF9Z2fYcUUBl597Hthy3Q0cAzQw+G3YXcbJRXYri0l9iZrrYTo08HahZKDZywffG0DiJFVEUmjTjnSZCL7stFYK8dCzucY/UtSXLDS0KbvqjCGiJ6EYB9+5IhwvjUZvsLqskfuKTq/l9ClSDRZ6fnnVmh/GiQbKUbVSAgHQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CHXPR02MB11331.namprd02.prod.outlook.com (2603:10b6:610:2f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:42:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:42:15 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/8] qom/object.c: introduce object_alias_get_targetp()
 lookup function
Date: Wed,  2 Sep 2026 15:40:48 +0100
Message-ID: <20260902144207.2553037-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0189.namprd05.prod.outlook.com
 (2603:10b6:a03:330::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CHXPR02MB11331:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e1ff5b-66f0-4846-f1b5-08df09006180
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FrXIbUCXNtO+9/uri6iuHrfJkvr+AmRgD/4aSa3aNyYh8IXmRP5xt9x/bcnlWTqYA6bxQdIvmIefoAlF/ODuEA3jIWDjVZ0U1/4aU+vm2zVd6W6WLRFFXbxO7RphKMpyUydrT0aUgSVYmpkT+as87guDo1guOKB7NIaaR2MySVt2/sO1ntLpVBNtBLoX3iNBG24U52j7KCxFdO1tZ+rkX56N9WHmXe9yOcfREukLNoYI651CWuiopjo1BXwvyA/aNptJDtFaE+RHMI52xKfpF8b9uLPqNVuBRK8Ut2QuCCX/bbqN8JOMoJVnvjAHvUp0VOouZ8aHJcAKQ4EwkPHVnZWjFdS6GW06y4GY+0FShYlq674ZqhSXx/9nGYHR0rJOOn8/kE+WpxznTn9Ntq+4yPh7amBStNcXm1m7SnDzMUwQ7QEjeCq/SJ+Ks/lLwd2Z7gz6BuVJ0hzTIGtRo7z/gq6fA5CC8QKJyU8mwsJdBGLj/I3riaVIxcjWvZTfEI1fR79QUceDX6pLDZmWf4Oukb4rE6CAQoLRZ+OfcQ2UZbvEvpKmNKirs2fuSVEzU2QQJBuy9eGItkI8dwgEfllUWFLQZ30dWX9O5gCzUyAqb2pVsUWelh3URixIMoT/YdkYEMq6igAGL07U3zD1zelwpI2nRF/7NX6EzgQwvq8Q71M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?at0GR2as/7EzX3GoqGDxzT4StZp3VB2sazZH4V9PRfV8w86ymo1YrmNccgIV?=
 =?us-ascii?Q?N3V0a9YWoV2mTYbDOrOkhAUgC98vyUiJEht/OaX/Jns6k1NNd9OmPnhMFFMU?=
 =?us-ascii?Q?AlV4zTWmJs6O/0snACvH76qhcsQVejdePmH9YriH5ZB+kX9U7siJW949Hv6o?=
 =?us-ascii?Q?vsjzVNbp0m1oAtMDoK4mZ4HATuylKWC1wB+JF80lR5ZW+1mAeeMwWpKr3bYp?=
 =?us-ascii?Q?IQKuvH3HtoA5hZ3gT8MhdHiMMGtlTorVh37HkQkoe+QYVuEhvxzlgWHtrHEJ?=
 =?us-ascii?Q?eY/HsYQ0cmyFoiP2eoMv0nicgyokY2VCNXwGcr5Cprv/yrE7MY92wCu0bKEC?=
 =?us-ascii?Q?SEfKWJMiD1nzARj1OGWUnfGa3kT0Ckf2zqWyLqoKc1PoTPjTvaf9qfIABCqy?=
 =?us-ascii?Q?hEFkDDy5prqmZ668dmUqAGVHRwYd40MoZFMtiWvlx6hAV+VKHBW+9FAze6RS?=
 =?us-ascii?Q?eOI+G5rXJ3IF8G3JdH2fdkzr4BSq1mUwIHYlHMHTcvL920k+toMbG7hHki8L?=
 =?us-ascii?Q?0aW2y4S8WpyP7zvJo46Dbe2dFt7YevoDNf8VaeGqc5qXfX04KUbI2qLNNwap?=
 =?us-ascii?Q?VY9Yibkgi2RTrxBxuDE+xqd1TlUDaFppNGDLSEchqObni1Mt4dL9+cV/lRlN?=
 =?us-ascii?Q?Ccz5lDkQgRySxaTN61w8+K5IGujAsQKXUReAZONncFb5CjxGL9IBlgylvqkk?=
 =?us-ascii?Q?o9h84fqL0Oc7GPLHaLREN6oYQoQJQ/iPa2zPj7JNR+jhesB4GjCxrOxH0JHG?=
 =?us-ascii?Q?rIzXHVvhiMLpbEv39Z/+RyrClLICKRK36Q4xZvglNggNBP3NsLsqXpDVhSap?=
 =?us-ascii?Q?Th0JhKy6rAEwwOevHYTyaCth4f7vlcBEBAxZhTq/n5agOSAt4aGIMifhPr9S?=
 =?us-ascii?Q?pu6ucYtZfbeCYEL9redbZNivFHXus86JEnqbYf+XEP+G46360JKhqS1n6+2r?=
 =?us-ascii?Q?VufFuW7wexy+rDtYoUz0ebeUNu8R1ZfxMbb4lE9YNRg/79JpELHGf8K13vPf?=
 =?us-ascii?Q?06nqnczkbv3wSJZ3on7Xf74zFXZWaMLJAM+OyodqNIaM8cbDanhvdNHh1hW7?=
 =?us-ascii?Q?49yUFeKsvcKtDVsLdtF6WlTo0tEsIT9giTqcnQsts5WhcZPTln6nIQsaIH2d?=
 =?us-ascii?Q?8hyWBPTkOMl0p2aZO/Z7rdEs76EhDMrmtJADvOcdzhnJbcq6Xf8n/vfj+SOE?=
 =?us-ascii?Q?AVztkvTW9Xx7SqqViE8PfVKZ7Ed3ajdc4Rd9NEVRIlM/Gp0Jl67W4hJUGtmL?=
 =?us-ascii?Q?gXoLXpEGw4B/pmPsNfhRU7u9qk5xA49lVFVECkTYbXaIJtzXc7sqMZ3iEqjn?=
 =?us-ascii?Q?1IowjeXXZC2e2hE5gRQcZQeyz8nA0QXN7hGIQPYSf76xRbLOJ4IxYT2TpqCI?=
 =?us-ascii?Q?m77zJicAe2xzhCsP4ZZ4esVdQcleYaf0GQHBlgwu4LLxaWTNzudT0OLjyE6N?=
 =?us-ascii?Q?hWWSTnUQZpDPuZwM6ig1v/jMvg8NRuE6T4J0BsKZNKnkEVotp3Mx/f1ISsNv?=
 =?us-ascii?Q?Xs9/6Li9pDeuPISoY5r3clwa2wY+5GJw9AojY8VIoiTYvbAfM80qVyfOXaxT?=
 =?us-ascii?Q?mD6JvOqCyueLWzlcbc+JRWaUzdRzDTuLeIzEmcEMh4qJjOlj4HC1M3QhN2+Z?=
 =?us-ascii?Q?d8GmQ0oh3EV/SLkHdN/ac8mCpG+qYkomCscN4+ctUxsQ23jIL6zqsjOaEyMN?=
 =?us-ascii?Q?c6EYGk6TE3VIAkB4IxqSdiSDPdCgtHjxqejCF5ZtMTTNj43k5wrqhfmHQxao?=
 =?us-ascii?Q?RuV2DkzWohMmDsSTVHoS0saxTxZkW/A=3D?=
X-Exchange-RoutingPolicyChecked: YiNjQGfvog6HF4IveQ7+b3KPOFm1sTfgMrJEwXEYFFBJfZEjVVdPbdT3bi5ZYh9n2tgKXc5X803+jiejQdHeC9I+DsIZwkK8ljhhmmMrTZoQN0vDYDRqUIRYazXYjA54vR/y+DBV59zWI+d8fSYWXNVUUboDyAVLx6lhqTEFeC1otIO/DQMGh2A5vhl1jlWl0Uqb7uEx0cirIqWdgYw+Opb2mjEOZEqsdjfRitbK79+HyEjSzZFia0VDyxZbscQdC1S3KQyoliVBHl+9BUKZgdq2tiCsv+lSMo9GF58AIE3k02O7ed4nqtzvCftHQxYWpn+E6AWz0DVSxQt/IM9nMw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e1ff5b-66f0-4846-f1b5-08df09006180
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:42:15.1198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0eAC5ggLM8IsVeXcAXzDlp+x6M/04Jop93nfAEtiJ6v37N0lMvgHA95AoupYKKFUJfKNACTyZwqsK/zjbFhlQzLlS8LXU6HvuPiS/tEwc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR02MB11331
X-Proofpoint-GUID: V26zycrxiJgt-9uxMYVAEA_bpB6XtNNJ
X-Authority-Analysis: v=2.4 cv=SvqgLvO0 c=1 sm=1 tr=0 ts=6a9835c8 cx=c_pps
 a=1KZAvIgiCpDO1TOdvW9+aQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=H8dXxoQVm5bDt5vjS9MA:9
X-Proofpoint-ORIG-GUID: V26zycrxiJgt-9uxMYVAEA_bpB6XtNNJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX6iw4djCxcYXU
 BQ2bVQ/+fd/YUQBiwtG49aX1xXpZfFUxHjH+ke44LyuDaad8r7gNuHNs42rvjB6yAhu/IuWZ6sO
 V0kVH3Wq6cYbYTKJwYl8Obemn2ZTOisz4hBkpcfxXYxL+9TSnVZbLewzs38KQlvAHQ0ONmo9QqT
 dx/ZbG3ncZ3XlMW/GbswVdz6b3M333zBQJC7WDkrxwtz9W+T2+OVEGXBH3md+RJ6x2LN0X/CPiz
 aPNWp3Cx4MkPEglT82S2RuhgGp1n2fuYSmEXkhB4Is33BHTuszHSRCCqB9Kb3jevX68yIHudiJ8
 CiCEB8HVIYVyzKJEuRPjw3mHbFsVwTUd00U4mG5TOlk9pk5M++w25+mnV4rMG6gzhOc1E/Yl0hB
 Lwhg19FJXYhXTDHHqfbO7Rgy3cjSLgIv3nK9Cqb4pHehDLIkB41KskjhompWq5C/Vbl2uU/S73a
 AHedzGCzMtTnt87Uq0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX3Fpv9ETE+vtX
 EJ+Uhz3BK82TGM3s8Q0IznK0MEOhFMFYtcWj2pEnOjNXlJ9OlJ+7DD5o4ImnQYzyrr9o1sgUibS
 ZVBWNSHIbjMGNbdANwq434Np3D45QsQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This will be used later to add support for alias class properties.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 85bbd7f9fe..a904f53ed6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3043,13 +3043,20 @@ typedef struct {
     char *target_name;
 } AliasProperty;
 
+static Object **
+object_alias_get_targetp(Object *obj, AliasProperty *lprop)
+{
+    return &lprop->target_obj;
+}
+
 static void property_get_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
     Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_get(prop->target_obj, prop->target_name, alias_v, errp);
+    object_property_get(*target_obj, prop->target_name, alias_v, errp);
     visit_free(alias_v);
 }
 
@@ -3057,9 +3064,10 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
     Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_set(prop->target_obj, prop->target_name, alias_v, errp);
+    object_property_set(*target_obj, prop->target_name, alias_v, errp);
     visit_free(alias_v);
 }
 
@@ -3067,8 +3075,9 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
                                       const char *part)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
 
-    return object_resolve_path_component(prop->target_obj, prop->target_name);
+    return object_resolve_path_component(*target_obj, prop->target_name);
 }
 
 static void property_release_alias(Object *obj, const char *name, void *opaque)
-- 
2.43.0


