Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA492CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzbn-0008U5-H9; Tue, 09 Sep 2025 10:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uvzbj-0008TR-LG
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:46:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uvzbS-0004Fx-9n
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:46:06 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5896Zv8c2274935; Tue, 9 Sep 2025 07:45:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ewvMQK/l8CpYVoVTOENcOnHkJ968Kfqe5ILfCDYrG
 fY=; b=hKG81Y1cYZtOF9AmWINKt8WTP4oOuIJOj6gLVpRO5ws80KjkEnCP+Acfn
 W/P9kidkUg2vUmXPfyGMoOtT7OYMtMf8bK6DM2nE9nIFElj2WcjXkuRwTFGOwltG
 TZuaUmFCXKo2YoUoj0XtDDuNh0JI559bVw8wIyqB9l++QkDRuEJuo6QQGUBf+4Pg
 V8/RcUzmDtVKcSQ9DGEYDlbDQF6P5aCExNeMZqc6soF0VHnSfIr5xObg3Hl816/4
 dxbg63AFyq9vdy2qqs+ccMDTAxf2qUL5OsNXfuTe0R1LD+x2oqZVAqWIQFPUKhI9
 PCbt/tU1tji5j+uQqP3LiitU7b6Lg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2111.outbound.protection.outlook.com [40.107.244.111])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 492438jcfr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 09 Sep 2025 07:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql30Mhkkc/HEKRIC2KGujyE+RZERN8i+KFRGOlqpnAbDmTMBrJ+CWeYxAI+uLEo64dxxZLBBoCohDPR2U7TxapjIMBSQGJjaF68yYTv0pMab7gV8ddNQTPCCcHXKn5B8L5tiN7F2DQpXjtZQK5zyOf8Dc1YxgoGiys14lIIAwNBN/dRMyxi7iSaFg8tMOlVpEDe0UfkdqeUF6P3fFu6pSQT1knVIhRskSrKWtvA18oIQHWZJEdI8vovsLpJTGL/NCP9q+8bH2ogOl0dPpU/XBWSu5ZnC9E+0ht/saAdlOYceSEBWn1DNHy0K0GpoEUeTi5/UHGmADOCb9nrmb1lNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WgmQQfGtnQ3wu3obGgzdeRXt2rwbGFFPW30BQUxF48=;
 b=Z2JBlZPf3H45r8Z3zRl1fUzk9qa74XerXKeTQoT7s273pPaIT3mYTptpN6iNVW0PsaNcLJF3zFLiO7/MxfdLtHcOzMv6f4FUyRTcVjdoJlnt33Z/W+quNrsQZKQZ1xpTzy2aVCQH7WhNArzHyJgfEt330TY5emZ1j4kbV+d4xUm4RO9eqX3mkmu1wRaYVurEhSwLQQ1m9OmfQmw1MA46WJCup0seg+xcLm2R7qq4wIz74WI6XGlR4BNBXkaopDLZbFYfgl2Rp1rAxZ5jXAoAQs3uE69oZHIiv7QUO6vWWfxo6J/sxF3ooX9CTBYG2BXUTRLxFLhZqkb/AeZTkRX5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WgmQQfGtnQ3wu3obGgzdeRXt2rwbGFFPW30BQUxF48=;
 b=JndtzPhAkQWHafrJkPW66p86tNgPmSzfNDPe+dQXU2IRMiG0XMCBR89ReyLlRIR5RodpZf3K3mYDohai1WTFCDtwl7F4aNqCzZbgBdQfarOWIBQq1xZV2f8cabInTEWs3CKRC8s3AYFSAMNjVvRpT8r/l/YiiL8dO0NznZIgH5R4YF2JQRR3Dh1/UEnpWUjx2A6hoMhRyFtZLR/cpiALCvNw4ftnFRvITQtbmWEcngPSI8cXbrRmTsELzWqxdgUc4dCjyLRoIrJwbV983RNeeeOwYNpXYaonKjOWwxRz++JRi2hllamse7Few3kpWVX6Rmp2k7IXfBw8DAjjudlTGw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB9759.namprd02.prod.outlook.com (2603:10b6:806:37c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:44:58 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:44:58 +0000
Date: Tue, 9 Sep 2025 16:44:53 +0200
From: John Levon <john.levon@nutanix.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v4 3/3] tests/functional: add a vfio-user smoke test
Message-ID: <aMA9ZaxvzsTHR8se@lent>
References: <20250903201931.168317-1-john.levon@nutanix.com>
 <20250903201931.168317-4-john.levon@nutanix.com>
 <aL7rW6Tq9d-z8sGL@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aL7rW6Tq9d-z8sGL@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LNXP265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 632647d3-3897-4f1a-3836-08ddefaf727e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?i0u3u2PZWZXgyKajtZUHUlYU0t/UKHosx9Gk0QKNoUgiOO5bSddjTEaLZW?=
 =?iso-8859-1?Q?+b1/1Ex7mBVw3oUiGwZ9j4BLjukKkjWYF4Mq/hO+B800r2GuqdgptygSfT?=
 =?iso-8859-1?Q?OL4AEp4/wJwecbmMKIoRZNfXDxNksAkMralgmwNv7CORHOsVzH82h/yCKf?=
 =?iso-8859-1?Q?gUcga3hnvkEc/k63oJEOVm0Fejc9SILwDvLzdXrC1BA8D/aCqVISxhzjI3?=
 =?iso-8859-1?Q?y03ZCU586XwIwynhv8i07XLZlOzIXW6HZlb32q3mIjeLeyb2H+5tW7Kpjo?=
 =?iso-8859-1?Q?2lWAkvbntYXCUNdctuGChoJAcStmCGTwfBhPtIFvux1E1R3iux3tQ8GCj3?=
 =?iso-8859-1?Q?bxb7EmHplJzNgl+C5EEf66y7ArAKhxEzWdjfDQ+IV52YET7hUyyZZic4/n?=
 =?iso-8859-1?Q?7yGOkXoet+tUPfHBxjCpSbeIrjIUi5NzdmKk+6eNdfNhfdq+TBqg8GtDDY?=
 =?iso-8859-1?Q?Y++xU/pSka+LcGfwXYxgI++N7Aqsr+ag/DOTlWAYmv4uofWiKsCJcF8X4M?=
 =?iso-8859-1?Q?51nIkX+YmgxlNaB8b/OXm523c9OgASv2gzOa1KKnvz3QVhbsxGYjlP13Ug?=
 =?iso-8859-1?Q?sP8rrV8E/hr2eUnhXOJIfa9tDH2XeTpLtf19lkOdkeBXwDNjCs8oZyr3N2?=
 =?iso-8859-1?Q?kiM0mpBXFqio1Ihvcw+OC2kVYHRczwCAeIEwxGYk8WqOIyBYeFJEomGLzZ?=
 =?iso-8859-1?Q?DMhqJEOVvpcFEHuE2o1JKNTag+DtAzPyjqJ/1R7DdaG7D9oL7E3KjHHqVO?=
 =?iso-8859-1?Q?YtZrAS/Uoy/b6w2W0twmbtENlfJdjYLTt/9U1Ze+8ENX8T77MYQAsibA+4?=
 =?iso-8859-1?Q?AyXElBtSslbImrcQjY+QOxkBWg4/HH0mQ9yPsBCOHPh0WEIvc9ErQ8/19L?=
 =?iso-8859-1?Q?F36d8EGtLIj03SInSl1uyLXMutA2MRzV/h0+e0drTkLwSAUjSctZ1MWTxz?=
 =?iso-8859-1?Q?JfJeUJKAjMoByp0Qq/i9X6H2hR9cFG9pX1d6lP2HHF/I1Aa77FTMnORp9i?=
 =?iso-8859-1?Q?KYEWDxKVRpusYlie2COdpdAEDnxJ0HrDZZY7GfOCuMS6eg8Y0XCdeQNbUP?=
 =?iso-8859-1?Q?vdbeBxKVxh6RtTngJ4xSdxYZw57r3BHKsxaaEIsPq5qXA/cLFfhJQ3s/EL?=
 =?iso-8859-1?Q?xB6vtcJQOq7Bk8pXOL2ifdMBayKfMmUbNkF1g6TeWeGVGu6z2RelZDr23M?=
 =?iso-8859-1?Q?e0+zboPbSiqe5tEQWC96k/Bx1/u013CQWeTSK7ih95PHC0aNlgLval5JFF?=
 =?iso-8859-1?Q?5P6GIv9Fz4HDfpu1avcQly1ioa/bz5ltVPnOOaOta7qT6ZrqY/5SVgvhVK?=
 =?iso-8859-1?Q?7ySn4p7Qj4EWVDEAGalmGf5vCDrgOcQ2jb4u8bkiTpN9ydhgrPyKSj+rwV?=
 =?iso-8859-1?Q?d3u5PO8ncd/zEvMdfNVG1rJYn2GmyOtn21uZ1JV+yrKjcA/sRqURvJo/KX?=
 =?iso-8859-1?Q?sLyAqNnTxYZMzbAvRORor4z1nz2a3Aggo/6xzfJN/OhNjGs5Hnqgs5IH6d?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XCR+0xsV+Jq11rBJJTbaG+gMzgZW7bKNf9V9Nci2YOmjgEf7u6ilX3fNy3?=
 =?iso-8859-1?Q?f7UM9bhBLR8O+5RPtSCcf6i1V8vU2AHcRnJNAiIZmmqcTxMJx17idEunJQ?=
 =?iso-8859-1?Q?ZztixFiCGF9q6qvr5YlWXCZUzrn0L+bVogbc+zQrY2eOAgZe1fQpS7I1zr?=
 =?iso-8859-1?Q?PBFd6SB6GZEX8JQL3MU8oEOEsy9ArC650v0LZXJNctByHFtqLMeBLL20FF?=
 =?iso-8859-1?Q?qAZt7/+MycuiCK5a6DSo8jd6LHpIHbMRniYUttvQcgRx2it0oBIfLZXqEa?=
 =?iso-8859-1?Q?A0JS4RvGuWK6VacXWLnWOx6JPDSatlaDaaKftFFY2fVCTJ2F7kPkDy5wT+?=
 =?iso-8859-1?Q?MxF1zxW6ZISRxnUlo2ErYumkWqo9ZBBTuUZtqVd/nWWRqrgay7m+vTix/u?=
 =?iso-8859-1?Q?zojfsHkJ97pZ/ioJMUfEYNZqtcgCRsInvSxDmjEqAMab2M0u5qV6pg3It4?=
 =?iso-8859-1?Q?kvXYdOSY7TIHFfxcsJt0iotphAZ7CG1mYtNpESKJ31/vW2XY8sKD8FdUA1?=
 =?iso-8859-1?Q?s5+DTsPMYv3mKjUJ+cRMeJL3S3vF9HKOrzGBN+tLpzYss94nfSV/fCEjP2?=
 =?iso-8859-1?Q?slziycZcGpoIqqtDkVFIEm6+inIcMxsdDwex2kypDaAcaHgnbAn6MVYJmh?=
 =?iso-8859-1?Q?g1bU1eJX1RBpjj8UoQTvvsuEE2opqMxh3RW8ViaOOzxw4njsCQiLNuO7ye?=
 =?iso-8859-1?Q?+ZYDCVxPFmQ0cjCVcKm2Q3VlaMkd2eRD078J2ttY284hyl4ob2VDc+qhlb?=
 =?iso-8859-1?Q?zRwJ5mY64Ys6YdHN1zl4LiX3Co/Q+Cvccim2kcytcvTWqPYMr2NeGz9Upa?=
 =?iso-8859-1?Q?j2h+8lJj8sgWgKM4/TWJquEavOnH7GvyX2Ix8geiBl7AixREQFun8lPbu5?=
 =?iso-8859-1?Q?YJdgW+gSeD+uiwmL78X9qHjHPrQWE0m1M/yfAiPXp6HOPI6HxzVW1F6NsF?=
 =?iso-8859-1?Q?Koiu+Qo82k2QFQKXmOfqBkcfbL220kre/PGYodcRUk5r1VVRRNkrmEj6Dt?=
 =?iso-8859-1?Q?0rZOV0kJhybFa0vSFA4MYooVoR2Pe3UKMM3kjp8+hdOcUboxUOcGoOxtCw?=
 =?iso-8859-1?Q?q9RIVThy9qnqfEjuaZMpkv4It/Li+WhF7J9ZaSZYq4+GElfyCtoofU3AlI?=
 =?iso-8859-1?Q?ayElSp76+4mDlJdUbTO1v4OVk1w8kk+zkzWqBfXhw6Po+GNiolxOSo4B48?=
 =?iso-8859-1?Q?u6ApLRgxlUyPH8rUw8aP6r2KxJq7ILK4RjOC/5fQ+iTJ9eEJNA+KgETzsr?=
 =?iso-8859-1?Q?QRxrjMPCiSneQ/92WV9UitIcdFLd+LYv5HhLERTiXDYqJ8AOZ6LBzDIXW3?=
 =?iso-8859-1?Q?rpVFEvhQj03PHYyJ7C/cfRHAVRSDx6b7WHqXlz9K+YSVldF079kAjYT4lq?=
 =?iso-8859-1?Q?B1ITYhIhALJo7tI+s5v1b6h3uSfb0eJKP+XyocmBYzHrZ+pUyd6ACnSm+P?=
 =?iso-8859-1?Q?DhsWt4CHc1q7hue/pGWtzW5Ihx6VIpTOtX2a5sYaj/Q9XsYtxkO9WZMRCu?=
 =?iso-8859-1?Q?krmuhm9Fj0AcJ6tGuO5mIfMch3bAjo67+rSGuSDWm5uGr2DJflzJH1R4MA?=
 =?iso-8859-1?Q?TV9d63XI17jVn4KMQ00m93Ov/d8sEkY2ohH/mcuNwn0T82xnZOr/q/in7R?=
 =?iso-8859-1?Q?4STYh9Kvg8WZ1+Iw8jxNA4kuK7TPRic8P0?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632647d3-3897-4f1a-3836-08ddefaf727e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:44:57.8943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgy9+oE9nkr9h29b1EH2SCNr4GG+wuWJZWCfOQnNXbP/KBngFpCTSewTfshXqOsYuroMZYMua07TKJyJehM2YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9759
X-Proofpoint-GUID: cgHOg28pIGfvpf_dAsYk0IWgAIM1ZTbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDE0NSBTYWx0ZWRfX/Ovg09XjqkIq
 ZoSL9MtG8IHOUIYsQzoz0JPfVRjMNf3R3V4J2x7DceuSrmh7cHl1PBgoCx0b6sb/FmruPEvdRsg
 WRzt7uGZdvDSQn0J4/73NiGdoybwsGiqo3rX3m0cC0U5DX09syUWqO0F9TJBMHHeLrlyqtIzwUL
 wcM4rwau4rCRCMPtOu0tQkQ+zp4IszAo8P9kpUbBqBniSruQc0SzUuyhPb4Ll8t6opOj1d2vKXc
 zsI5pwNz6b+Ni/41G5kbUnVa86CcpCToSXjSnLI3VdnlqFDgwP49UJBeKi70jxpVzVflW7R/cpT
 7QzhA8afsc7t/n2EIkYtDRbsZImXnbI3iW2fdkcZVB/pcXD72KeX7C3y9T/8D8=
X-Authority-Analysis: v=2.4 cv=WM5/XmsR c=1 sm=1 tr=0 ts=68c03d6c cx=c_pps
 a=f3W5XOz7tIKFJfa9Mwj+Sw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=pXccCY8k5AQrOcgdcyYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: cgHOg28pIGfvpf_dAsYk0IWgAIM1ZTbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On Mon, Sep 08, 2025 at 03:42:35PM +0100, Daniel P. Berrangé wrote:

> ...but  no using of -snapshot here, so copying the asset would be
> required?
> 
> Can we just use -snapshot in both cases & avoid the copying ?

Yes; thanks.

> > +    def setup_vfio_user_pci_server(self, server_vm):
> > +        for data to shuttle between its socket and the virtio serial port.
> > +        """
> > +        wait_for_console_pattern(self, 'login:', None, server_vm)
> > +        exec_command_and_wait_for_pattern(self, 'root', '#', None, server_vm)
> > +
> > +        exec_command_and_wait_for_pattern(self,
> > +            'gpio-pci-idio-16 -v /tmp/vfio-user.sock >/var/tmp/gpio.out 2>&1 &',
> > +            '#', None, server_vm)
> > +        # wait for libvfio-user to initialize properly
> > +        exec_command_and_wait_for_pattern(self, 'sleep 5', '#', None, server_vm)
> > +        exec_command_and_wait_for_pattern(self,
> > +            'socat UNIX-CONNECT:/tmp/vfio-user.sock /dev/vport0p1,ignoreeof ' +
> > +            ' &', '#', None, server_vm)
> 
> Hardcoded socket paths in /tmp ...

This is fine: we're inside the server VM at this point, so can't affect anything
else.

> > +        sock_dir = self.socket_dir()
> > +        socket_path = sock_dir.name + '/vfio-user.sock'
> > +        socket_path = '/tmp/vfio-user.sock'
> 
> This isn't honouring the temporary dir for the socket files.

Stray debug line left in, sorry.

> This temp dir needs to be passed into setup_vfio_user_pci_server

See above, this is a different socket to the one inside the VM.

> > +        pattern = re.compile(r'^gpio:')
> 
> Use of 're' is overkill here...

Sure, thanks.

regards
john

