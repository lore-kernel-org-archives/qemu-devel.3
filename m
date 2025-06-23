Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E58BC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTcj7-0006jV-92; Mon, 23 Jun 2025 04:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uTcj5-0006jC-Q0
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:40:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uTcj3-0002bD-7g
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:40:27 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MKETG3005026;
 Mon, 23 Jun 2025 01:40:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vN7diz132rCl9arjZ0KnUQSP21cvayGy8bhIoKrPv
 R8=; b=xTlkg1wJkrDYNKZR5NHB1nJRF2oRI5bYewsqK+weuoFF7Gs1tTkDy1k+z
 IBLzAEya/5C4a9Ow71ie+QoeaNWphht/YMcEgLY7g6IgMviDTXN14P9FHal40lu7
 jd89Yd3+IpH9/GFE5VdRj8OvMysF1Hx+NuQZW1ZwuRHLYf6HTXXQMBp/jKXkwVra
 k61TyRorJa8noku8+7uqx3l1w5Jnr8P+WAyVxv1L/rc1H/ULTJHpJLoSKgDytsjZ
 qdVgfkkolDY3JPvQzrNbQsSbTEbb1Lk7WPjMRcYJiXxJ4WGI3Zk0IIffAP+6BhRn
 Vcmnp3YBulXnH9REijU3gTfd6CN6Q==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2128.outbound.protection.outlook.com [40.107.96.128])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47dv2btp7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 01:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKol8LtoyfyKjzui+MhBrid74UwT8K5wwXsXV0mmAoRxZkjakzYhBw6r4Walhj89bC7FMyxdKRgvNBrFpgCef4jVIETsRWGLpfk9q21QTQwNVa9M1y19gVj1wwkLLrIL/d24+N3xjKTmioNBlOjJ5DllRTAI2JCYhXJoLTldCVyxVYk208uD2rYmcfq0sHuxMX8W8r6ZBqqoPT0vH0HI/DV66b6WkwOshR0a7g3tQdKQAjUGLRoK3UoDKv7fQUJN6Ok0IAs/UyA+JNVdeTkJaWWYQ+queUoMtuox9BVKWEdD9acWJ5UKCR1g8PIg28eAP7x7TP/N35tjAaAFQLiLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVLxDcg+XyD0pJwuhNkCzhtQhcPhjTXEKaVLmib3mYk=;
 b=AqKOGSz3L/o9uTFT0TkTqYkxRR7FhifsZRe+MjuRSboFQCNRTndyBxYaB86f+O1q9w09XVpgohCHGQ75M934zlbyfCCrwMPWKuNJdvYAKX2aEpNIZPKdE6nChJ63xMoRNwcYYoM+7yft+jd0+KYYKLgSHFvBSKwBxT197oK5L/nv5I5coRQcESGvW8YWsj5IEADBJ4CIbTBvxr3Hs7RLm86m9SsVnhEL3xrOUZh8yfMIJpDJhMKOG81B+FcTObvd5vmKHTrzWFuLHImvT1izNLTyTzUqkdcaR8VGEZOef3y8poU3/wXK/xENGd6DALdFuB2yaNFujf8KdBdiLGaFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVLxDcg+XyD0pJwuhNkCzhtQhcPhjTXEKaVLmib3mYk=;
 b=RMxpYZakfLr3161FV53RUIp6h1sDsDQIJuLN2een6vMtQeIV32cratxd+ocUBZBMV9/M0GRgfxh22uU9FEJdKg2OMd3juWvaM2axICTXeDpNs1iwlHwPxef8VJGs66av+EUfLdlxutFtMlYkOuD8Cae+hJ11Buzxrlt+ia3aAuOL6Qd6rjrS2HTBfgwizns/As+2bxG7z5P8jxOh1TCAX1JJpgBw2u48DX195XIvhTGwH+cUOMzL6UaP/L/V9iB61dDtLIA8OWmN7kyDyZ8UtA52aqoyHc8qSrw/8YXaW9hhF63nFhFwj1Ote41EO71DkuOix2ul0t12YeGD78psaw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7296.namprd02.prod.outlook.com (2603:10b6:a03:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 08:40:17 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 08:40:17 +0000
Date: Mon, 23 Jun 2025 09:36:57 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/23] vfio-user client
Message-ID: <aFkSKX5Z_a_rND6_@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <b6be1ca0-0ba0-4691-8a2c-f7d3ddc2f85e@redhat.com>
 <aErh-v3SfFo-2Br0@lent>
 <c18de4a2-63d0-4ad2-9547-fe8bc221a887@redhat.com>
 <3b311f79-fc87-4b1b-8ba5-728d696a14b3@nutanix.com>
 <65274f7d-59ee-407e-a57f-dbf9e47890b5@redhat.com>
 <aFakD1PqE6Ew8whG@lent>
 <e27a3a2f-9277-490b-a8ba-22202bb57c70@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e27a3a2f-9277-490b-a8ba-22202bb57c70@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P251CA0013.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 54224531-c5d1-4d0c-5efa-08ddb231944f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4ZuDQVsnkHkzsASyGQFRmEc93nJkljGnc05CvvL6F8qWBhhc3Dte6nk/hA?=
 =?iso-8859-1?Q?1WngrdOK5QNCZdlPHqzZ0stzYqtGoX1nl/z84H4FYF4KTQxAgB0bv3akOD?=
 =?iso-8859-1?Q?oY2p0dy0v7XrHenCegr3jIa+NW/b/lU3mQaVNXa6OKDvv2Q9CXdxjvSY40?=
 =?iso-8859-1?Q?mQ0YEEZ+KmFIwMUAuJ06e3Yy9+yPQw1tLwYqYkzonGsjLh3UYAHn3pBUH+?=
 =?iso-8859-1?Q?Dx+1kx6dEd//QGoJhAzByLSu+gaYj8fUNNk50eNqs/4IeHFzq+6Uqn1ml8?=
 =?iso-8859-1?Q?VcWLv8irg+yKJPfxj3lrvW4Q2bcDZW3/oXfZkt73dGnd6rjz3PscSP0tt9?=
 =?iso-8859-1?Q?27vS2pgHK+g4CDJNK1UCojKgNC0CJlgziQQREBwHfjjFP1lZZhproYM7cH?=
 =?iso-8859-1?Q?pf/q9ahYKL8eJdl0u70ILQzWA5tOmnfo8okKJHQck7vltgyevR8VQehcCz?=
 =?iso-8859-1?Q?sGJcGZDFUIqCYW49k4WGqcLSwkaYXObU9cY/hFRDYwJyHqogUjvakZYQQ7?=
 =?iso-8859-1?Q?42eBza7ftH2X41sv3dDQQG69yUfhM7miHDAY/FULJbGLNTicSZrDmnskuK?=
 =?iso-8859-1?Q?iy+LnbvjPOSyFIDYwiSzgmHN7m19+MrKPu6/Lgu/AmscgoqnR2Lfj5SWk2?=
 =?iso-8859-1?Q?F/Z4SAiNT7/6D0RT5CAH6GkZriGN/yd/F2/Kx11M9FSi2JcfrXqDGkgChL?=
 =?iso-8859-1?Q?U/oNsRBz3mqoMXkFVKqMSdaYTHnhmXlPm1XiTaWJFUcSHwxRc0H/il071p?=
 =?iso-8859-1?Q?5wVjb/JbWCj2h8Nuffg1tLNojlB4LelS7UtCpH+dYt+W409QfvVp+Il8yy?=
 =?iso-8859-1?Q?gEGZwEF09eSYafcYgRweu/QBSmBaCoS5XqT/8LjMhQx/mE86ILS6Hnx14D?=
 =?iso-8859-1?Q?9+IPp7Az0FWEweypj8mpmGjBvMAP1iRshW9cC5OGgXhZnr2a5prkPrc2PQ?=
 =?iso-8859-1?Q?yMcvN2Xv1C3Ma93fOl0T9n0CIP2sR21tEm1nVDlK/Tdd6EeR34Q1kTOsUo?=
 =?iso-8859-1?Q?T+F10JJKkaQFipGqqInXlJ/mfheCthgDdffoQCSdBi14AX97OTJ9cPwnzZ?=
 =?iso-8859-1?Q?aTwLtmspthFxAra5pOB9T2geF6uHPRm/1YgK8EFWpxr2lbprXnYoiFm8/Q?=
 =?iso-8859-1?Q?TNM6pQybJyrCYz8rmV7aOu0mXQk2wGybQS5uWjwfCOs/55b97XbJhksJ/T?=
 =?iso-8859-1?Q?mx/iryMGd9Ji+fLCnVHqB3MQCEHdTWbES0WA74UMPzgcg2ZpR4bmwpUvO0?=
 =?iso-8859-1?Q?VU/9aF1uIff7dcnswn/9JNh1xx4eFCZbrWsSP3Rapb26rKXfVQ9/cMyPS7?=
 =?iso-8859-1?Q?zZuOnEV6SgncozPoEyKmY+mQEhxxi0lVRLFyNbDsLBJdtHUahCo73HH2CS?=
 =?iso-8859-1?Q?Gel/fdxalmVOhsZ6DJNxsftKJX6YfjRDJETjr+JhWLZlcxZ7P0kDEiDWCr?=
 =?iso-8859-1?Q?PJWhES6+MS94TR/VUbYH5GKZzeetXuKvT3PwRk89KDRr9cC6t3bRy7Vf3x?=
 =?iso-8859-1?Q?8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bgExrYhZKak/ohZ+kLt7qhThJs+0rtADP0zGnE8tIAGKWGEaTGYUBsAWRt?=
 =?iso-8859-1?Q?Y8UCn4fBFCAag5GWgUy5dlG49Joa7pSGULyQ027VGAKpbdPD5d9GtBCZ4s?=
 =?iso-8859-1?Q?hTVPzC4hhXL/WhYwImlmPbJIV+EMjhuLyr8swqQ0XR2iV7Z/XZ6wq6bSfX?=
 =?iso-8859-1?Q?xXOJrq/8iP0oMnAeFRqEG/KbyJkN6hmxhHMPekK409Osn+lGs5jpnDF6iF?=
 =?iso-8859-1?Q?6gLaSPK7GKEXC1f/GOklazBHaCQivmKnj0WT+7DujHc+dlE2nZq2Wck2Cs?=
 =?iso-8859-1?Q?D26zt/c/DzjpYMbwKUJxLhBXeYbcIKjqJkUN6QfFojpgvMqyhStqhgmsRq?=
 =?iso-8859-1?Q?WRDbWr2m9Aqy+eLXOPqE7Gt6agwd+Jy7aCjtEanYp45F7ME6tn1vJEWVNK?=
 =?iso-8859-1?Q?WO3pg4vMCuw8ucxAEn6VWS61HvmtUt9imZ1//OgHQW09ItqjcRmQg+92ZH?=
 =?iso-8859-1?Q?hW30XnjdbCWqwVNyBUr75r/lD61dJp9KVByzpiip8893ir72c0jRZeB3Xk?=
 =?iso-8859-1?Q?o7g1moaC3FADS9GhfuBIgcycJPsXfcbDH72CmJKmddoKYDhSgj1p7sZ5NB?=
 =?iso-8859-1?Q?JsF6cSgnwWzAcbSxIz770wbXlTIUNN0PT/5aseSVu+OudyWdZ8J0DPm1Tk?=
 =?iso-8859-1?Q?Lmlv5BRV14PxV4ZrwelMdx+0PtYbVKHzUIWdXQzBiUQHA8awQXXGwEyF6/?=
 =?iso-8859-1?Q?kljvaf/6Y5LRnAJxzfdHjoioxHBXIce1q8/o6APv+WhOVk6h/+WJroxuSv?=
 =?iso-8859-1?Q?BCrwTqyiEDIK6RTr2a4/MJ37hz8aqhQeUZMAcfSjWGDbzw/33KX6pYzHfi?=
 =?iso-8859-1?Q?n/wgk5ks4dloa2PmzfRGlsVuUB1CMD7r5HvssXc1ZgOTggZ3ghEeOfGo6k?=
 =?iso-8859-1?Q?3mvUKicFJVXz0b34CyC62f95vi6LzXmDKqjHlJJTYKoUbRrWjehRMYOEdq?=
 =?iso-8859-1?Q?mXf8Y7MBmZjULkBOxfz6D0icevfw7Um8jLHOpIg9QAQ3INMOLLcrDPacqm?=
 =?iso-8859-1?Q?pejk25NH9D403ajKAY1ojcXhTXl7HccSMec60CNqoXAd4DDypTRcfVo/34?=
 =?iso-8859-1?Q?B/Qowq/6ar8Hb/7EQLbMFjvw5XnVgoxHBKvq5T77zcNRwLOT4cl6VGruWj?=
 =?iso-8859-1?Q?kMlJ4yxKIJlQqaDOezivLQLmV2GjV7buQ4jMnizZZ6Y/n8L9ur65mOy0HH?=
 =?iso-8859-1?Q?Qm2w/e9SrlgGjD4XCbrjMo6W8e3q3hl6pFyLCsnjlNAlxhYUtkqwqeo9kv?=
 =?iso-8859-1?Q?eTfpEva6XypH8djU3Nb4vxbyE4bPVuScvDebCrgNsCVZPgXqpNDUb5T3Bn?=
 =?iso-8859-1?Q?ld71r4nGlJi9bigsHDfTVe8BBSoQUCaMRO5sqeHSiXDpblRsL6uluN93/u?=
 =?iso-8859-1?Q?7Jm1rNuE6TjM/IkmglRdgJbyAp8RcBj+rdMD4NShhoaFiPf+PSynFTHiVW?=
 =?iso-8859-1?Q?Q5pNlTN8QK/4FAu8JE6So5RavioFUtRQwRLe24f2w9pRLgeTtxdKpn0iWP?=
 =?iso-8859-1?Q?PWD0+xSjYH7MPat/lcrlEhfY+7nV1NWalFRualuGyxdx+KY0oQsM8ae4wV?=
 =?iso-8859-1?Q?O+g1fWiFZynk8XoFKzwccrUmpa4uRN+njQEhEBRUw5BwVQ8K35kgk9esQY?=
 =?iso-8859-1?Q?bhRLGW+AauNde8a6EwuBMc+DoRTppO+OGz?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54224531-c5d1-4d0c-5efa-08ddb231944f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 08:40:17.2743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvIOYYP10e/vY2rmHlDvh7HC7Id/T9l6BFCNMMzCCY/Wyll6cqo4VYoiGecPZz7/B+ONtbaDCjGZDp4Ak/Y7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7296
X-Proofpoint-ORIG-GUID: E2_iNHiGW3RVAaFubwtsc1SCbIetjXCw
X-Authority-Analysis: v=2.4 cv=Vfb3PEp9 c=1 sm=1 tr=0 ts=685912f4 cx=c_pps
 a=cJeHLmQtI7nx8R7U+hfLXQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=GU_cu-7jXU9T86ntGRUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=QYH75iMubAgA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1MCBTYWx0ZWRfX9wZqeYeJQHkw
 TCoVU1du0hmOzh3evu2nEmosVwNvihhprWMeeH9wsVFXMSk2RPH7YQWTnF6ac6I0DkMP4pW/IOx
 Ha5mk7zxyXfMZWUWjDXanzrV08eZVDN/zO0skQ7vEP8byoPdVK5DgyzJcIuvubeNHr2E7GhX3jN
 q7il5yGsrKXu3Q3N5CP8fQP7/AH/Z0Tak5jDeBqWPc8CbDgJ6MAqijm5KXVAJoQu4yy8Of+nNL4
 dXDIk7EUZh12MfZDWS1ntsE0OmrxChltGpnyXRzkBrcT651+YSkcv26xVgnm7Oedgyf5qte2MJH
 OFUUPXrGwElXVVfUJJwhlJjug3nsLtsTDsITG6Am6Ry7m1RmiyBsFjxP71OUA41Wo9bkal4Fv05
 oeEEYSPtwe2YVzk+n8d5bS+LYlKGkeVpU+F1VXSe1eXEyeSazmqbsYwSJ4AXgF/08wPX6q9d
X-Proofpoint-GUID: E2_iNHiGW3RVAaFubwtsc1SCbIetjXCw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sun, Jun 22, 2025 at 02:57:57PM +0200, Cédric Le Goater wrote:

> PCI enumeration work but the kernel module won't load on ubuntu 24.04

Sorry, I forgot - there's a kernel bug in the Ubuntu LTS kernel for this driver.
Mark has a fix - Mark, can you share?

regards
john

