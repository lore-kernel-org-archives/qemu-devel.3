Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094C9C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHf0E-00015n-AN; Wed, 21 May 2025 04:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHf0C-00015G-GS
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:40:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHf08-0003gt-1m
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:40:38 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L4aOaX004116;
 Wed, 21 May 2025 01:40:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=71knekRHrj0G4HAsbmth1YhkKhv4RF2uyOGyaQxjP
 V8=; b=mgmg8IncT4dbu2kmcHTiW9q0Dm70R9qqhWiwkoZdCq8jSN+hk9kUz5+n8
 XLtrQKehKUF7BtvW9itqPFepIEjU7kGMtZqImEYYlXMwrkOaJns203eNChRD7989
 3GBTt9yBOgSkyHQN7DPzJ05l6UxBilwKDDgKMoToTOhpaScAZu9+GoY4nCWLt+Zk
 0o2vUWsMiZRaWdfsKUhH4vQnOa6mWKXYIyf+vV06Bq0w2LdG9DgDLnRMLkTS4iao
 nLZayfk4fd1WvB/byKw6CdApgI+AzllV0KKgCBX2iAH86te7IF5l3TA4iNcdhUHA
 +EkkOwIdvPVq1mvPG8/m+Dr5pQbsw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46rwghswc6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 01:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxVDehInJJA+ABy9YDM3kiQ+qm2rzn8A6oqP58B6tLcV/FJJecWSI4Ms67EJG5LT4RBMriPINfUci5zbjdOXYD/2tdCBYw7IFsyXOmyE8y1mctRFd4RXeGBhrgKl5h5s14s5aHZiciYPo0G2eGtJkwpF6PevTn+mojP2R9bB0fgTQVByqNwjlo2WLE5wkw0ZiaMf51a+No33dn4yPgel3pXucO25Ctv0E0BB2sOybBfORPWXY2XbohUrzZxzG8JGTy844Dqw7TusIgjn1FqCHmMtjcAg/468cnTRinm9qO10URiWa6bptEcvLW8izHJuGGoSnw7H+BNycwo90NXVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlSNnuMmMUGsFb2QAbp7R/XXBKtgIsCJ+A9hKlj1ZD4=;
 b=pokNbevgSps/iw8P/C8VrqeZI1k0G4TzV6zNQC2tcq8I3EmwSzE0C8zIu6S0O2vrS+6bbYzcJJvMO70oXGsfLL5avL0ZlTxUDcBc4XB0W7leA2fEGj/+fsjcpVjROtBPG7agbOxQCKMufI9bsSInXyxQ5UN9hqX0Ao700dSZ2EkqZO2yg2UHlS6C1NtXon2usihvNX1OIAWQqnjLKFvseYZ6wIsLBF+fBa+gOCqIIccVGyJRvzGuXMqqYY+NIVIT63tPqyQhu/DfAeURgJfETJqxFDkHc5qOiShDAKBNcbI+YgR13PrKDwTG+YWmGi/CO743k8gHbj2nVj9Wjm4+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlSNnuMmMUGsFb2QAbp7R/XXBKtgIsCJ+A9hKlj1ZD4=;
 b=WH9GmF/NWj5I/ligfOlHOFUoYqiLecQE2a9bYOIymQJtJvlrI+Kg5IOzDSPOQtwmaRMWDnoCT2q+mZ9gBaN+YTDOH7sR/5KOPg6BFP8YDZWvxHTLvr8DC+8wSCCRJHLvzfM6r7N7f4o6Y7/00ak2D32DywzekEyZd5x88l5lT0e4UDhUlDOlVZJ9RrD1ZuqAiEoQmZPbvOE7XTOA6e0PJMUs9/TTMS4804Z0CZozWXhk3sXh8PbQtOiJskBEMDVSHnSrP/hFJx4wMSTrfJFgdmx3TsWFiuK3rDjhTJWGaFEICTaLNzrRRsZN1upiGQs8wCC26gy3AilHqkEBpAKg6Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB9675.namprd02.prod.outlook.com (2603:10b6:806:387::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Wed, 21 May
 2025 08:40:29 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Wed, 21 May 2025
 08:40:29 +0000
Date: Wed, 21 May 2025 09:40:24 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v2 05/29] vfio: export PCI helpers needed for vfio-user
Message-ID: <aC2ReEZkRl3K6Bfk@lent>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-6-john.levon@nutanix.com>
 <71d44d9c-63f2-4f71-a0bd-366762d816d1@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71d44d9c-63f2-4f71-a0bd-366762d816d1@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P189CA0061.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::10) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 06706b79-6ad0-45ab-619c-08dd98432396
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?2/6fDwt8M+6FEPEyigXp93vLvsgmn3zH/ddmSuoAC91ixxGtRW851PWqca?=
 =?iso-8859-1?Q?NBRggr/pugZinfdvkbzs36RiI9oVPjOhrbz5K0Lh9frjqpJbYq/+FU4uD0?=
 =?iso-8859-1?Q?JDB8NAvqxjeHiWycCOQL1N4y7Vs2FjD2vCcvPh56j+maXVlTSf/u487Dmc?=
 =?iso-8859-1?Q?tV3pBFhGnyvS2tfOsDf6K6MDZAiu6UjeBqqmQdibRsIBsrFyOYGVFtcUIm?=
 =?iso-8859-1?Q?qlzJCInyvgjLiOmjJCcLof8a+Dh9rPPPmRDjl0aj0xSZlGX+XbdKNK/qWq?=
 =?iso-8859-1?Q?bWGJ5uGXLGubWlptYIKOeGsnwFvm6nbdss20T3Mv/0WwCDZAGVaidWyEdA?=
 =?iso-8859-1?Q?zxWDqmg+GJ6IsauXi7r2LSPxVdobWeNlwkv9xG56zVn06peI/pPrg4mmT8?=
 =?iso-8859-1?Q?lRuCv3gFkdGEOOskGuVac1qIKAk4rHQSJ4OJOJX9q/LWkuE7xdEszm3Zxs?=
 =?iso-8859-1?Q?yF7sNCt115QnWiO9Rj4SA3aBU81DTRLVni3xnjp/xpHvlKx67emgwN4jAY?=
 =?iso-8859-1?Q?d4jo61PSz3N6Zi56XJ2ltHyI217bp1Vv3c1rUNL+GeG4QsZCyVKofIwwYm?=
 =?iso-8859-1?Q?sLPQQVqFYBP2Z2fO9rT8rFjgPRxcHXXKz/NPK03CDqPfogj2J95EnBdLuJ?=
 =?iso-8859-1?Q?hcUHtZSkVZhlc6245I9x8DZwzzVUqVhC77aV2Wy+HrTkTQKFW+Z75K3IOn?=
 =?iso-8859-1?Q?oAdkD66OMnAB/31dlip02ypmcnRnSVkuh3sEHwqNBAYYFelD1B8ZS5wKjt?=
 =?iso-8859-1?Q?CvHQ915tyRZFvzCstgrgwqmGIlcKpVYIE81maM/kiwsQiT4CWBO6o1Rptq?=
 =?iso-8859-1?Q?VIwXgfleII1ZeBvo5VmWLmxvCB+e7E6GMmu54x4FKtVAMlrstwfvg6dqYR?=
 =?iso-8859-1?Q?zj8wZoIfm9q1iEsWFTvAlRzRPfG5u48X/Nz3P2vv5NTz15LHpxVuc9mT3z?=
 =?iso-8859-1?Q?jHm5Zk2dm9D50siLzl+0c91QhSIovx9sKv3J95bBXJeAbpRXNkUOouko33?=
 =?iso-8859-1?Q?Xfx1LenO/OLtL1ODdH9kG1xVf5pxZoFnUeHHMAJz+juAJE5KkVsmK6VJoy?=
 =?iso-8859-1?Q?QjEbxFSG4mvPdipzoPBnBbcN3r2c35oYZpWOP9CrA6B2fIwI0LR2KglBCI?=
 =?iso-8859-1?Q?radJIH2GYXg7JDe97eHTQs8XrtiojeWqXMWHSkpIzKYtFxcNc7WhoFPT8s?=
 =?iso-8859-1?Q?RAiAk44ivEsAyay16dPr4DIbnxx5cAkUsS4j/fKLK0/RNhK5UX8QoJDfkH?=
 =?iso-8859-1?Q?5BqWZjsMZ4C/tBWPuuc+PWZ3LkTUWAGNmB18Nh+8LAe0KuwR3f8GRE9oRi?=
 =?iso-8859-1?Q?M+LNL5prdjwcj8oRUFjy7t1yavUdDveYsi980UlSk9zoEmsA6sHLtpTJJi?=
 =?iso-8859-1?Q?L1d9Km9n9WHmI8WD7UEBnKeEU52WtbyBUX8br4nuJ6OywW/DohcKrPUVZB?=
 =?iso-8859-1?Q?HewlBPahebvV19DDXiOd8GY5drCfQ+NHzKDqPKaTFjiET3w09TYEkIcMMu?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dxJaHE7Rsd7jPuWGv44hQgoh94h7VL5IVENRkyqLu06euWbiOQNzUkPAdO?=
 =?iso-8859-1?Q?dGdsaD/Cs/LfwtMV1sI17oaKVcbLcvssbdQ3FbmRZC+yDrCoyp0u+axNG1?=
 =?iso-8859-1?Q?FcRM9uwEaMOPAGLWxbJn7HMBiB0WiGmcVetT3KrVi51JxVo4+6mu3ybu9l?=
 =?iso-8859-1?Q?pLoIp/zYeMeKL0S8R4kBo3uixpI8WdK5O3Yggz/zsR7JryaP3hj+pySxQa?=
 =?iso-8859-1?Q?HQDMCAhSJP/S92DEs3/Q09LTHYjkPwwcbYPhlep9P6T/nzj+7C//QRX6Qb?=
 =?iso-8859-1?Q?GYZ2V4zgGNoiH8Fyf/ZIh8UKtwagfIkCDxAfri/qSw9y/wKzjClxtKxqTi?=
 =?iso-8859-1?Q?+7bPBF5vCDEUxoWfMVB85YmUBWbnUwon/+88GUHFygOog6cWzTQCgON7Di?=
 =?iso-8859-1?Q?/c5yHWmEZO6cHNTBiVJr/SPu76bXVMswS5+hkAPf6/fTWSqZc6x+32F8kt?=
 =?iso-8859-1?Q?XDUhvrelCAQRVeZjWHijcXi+eDb2+NHVoHbtraSg7ZCTZlIy8qX0nMok1N?=
 =?iso-8859-1?Q?NcgUq9Y4C00PJ/G0Y+pPgZYuEGoSwJbbpwInmPlxbalHjFCx8hm+pgq4VB?=
 =?iso-8859-1?Q?cY9n33+hrotaib2lt4zmW8l0p796mtjNurt5Nnx1a9USFjAPWWoSiUF5ff?=
 =?iso-8859-1?Q?j8qR5MxLaocTspUYNNr3XvrND9XT38dQt2oAlweXtN+fHf8/VY0tm862Cg?=
 =?iso-8859-1?Q?mC/7DGbbg74N4tLoQ64ldMtsTGE7wvJ/ZQxSmmBXT4k+4XH5K72sylmH5g?=
 =?iso-8859-1?Q?JROFGchtQRj+USQAxCzNetrSjUIPXo/WzmLc9L2RikEvKONFtrP2FZuxen?=
 =?iso-8859-1?Q?Mht8HhMBl6bb5Ha9mF5/InVZ7M9QdYlh+S4Vdbw1jl915+zX0I1CLVFx5A?=
 =?iso-8859-1?Q?/czGtwHXzjBRji9yC1T9VGGuMmJklN5wMRdBihIuCKtZhRlnV86/GgS4eY?=
 =?iso-8859-1?Q?5bfEt5EHn/k5qmE8B+Ytg2RjlaLLRl6qXZdGE+IVw2Svv6VT+iKdbB+SN7?=
 =?iso-8859-1?Q?zJOP2wcwRMTiCcrO0oinK92pHk7eRgkjvBXDIrUgbRJvzhPi0KIUkA/o2Q?=
 =?iso-8859-1?Q?v82lOKYbeTgp9CyRe/5EGL4eAsFOziAtC4/A6yVAOnP3pxkJ474e3muqXx?=
 =?iso-8859-1?Q?LVoN9LfVpBnzvRTDBxXJ7whQfQ33LplRVlz4FQfYwL8j2nNdIacpUlRzcS?=
 =?iso-8859-1?Q?HBuGXmmEDmcBI1IlsDTQq+iomAP8wpCElvv3qIn7eoua8mBLiaZUEKgbYw?=
 =?iso-8859-1?Q?1NIvIx15dnA6VUROUcwABNQVXWKuieyi/dPJB2MySn3CUSwvgZqXS1SfvF?=
 =?iso-8859-1?Q?zS0oHlrxgrdHlOw1ovLYv9QalejfIHExwOen59vcxs29JciJEOqLCR4YGt?=
 =?iso-8859-1?Q?cw1VkdlEpeDDNjsSMVsyI0hTiYD7TKdU/BX61rxwBj1Pxd7dS5199VF4QB?=
 =?iso-8859-1?Q?pRLEiqXcLerE7bugdnn+L/E9V//dqhQMNI2NKrB8XjdOJbx/q7fv2T/eog?=
 =?iso-8859-1?Q?HlrqbwyqSvg5Tn038u/RFkWH2qpPNYn0W70BZXWkx4jVHZmNox8QsLdyvx?=
 =?iso-8859-1?Q?lUNVhQ8ZYA2PdYHeICVky3F+3Mo2Kuij3QMTHyvu0OBbqa/ofkUNpAzxea?=
 =?iso-8859-1?Q?oowuR2wVggdfCY5MM60erIKnRPIVATEtkp?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06706b79-6ad0-45ab-619c-08dd98432396
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 08:40:29.1092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU3x7r2kcFxjxb5+156+nQkz0otdyn8G42wgjLhxBjfztNt8no4ImgAIFKS5NZTp8AS6+MTrWqzjKT9taT5+yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9675
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA4NCBTYWx0ZWRfX0+XmAj3sBvDW
 0GAOrs/UmpAJXx0KNby3LBgV2eBGVdB0LUL04WKJF3zvw23lJ7AbZZbOLaGCJ7yhotJCvVuboEJ
 erQ5oetXnvBL5ufh6znwdr6SNL4UBWYkUv0H1piJzXf8GxKFIyPQLLu5Q01DZ7SPYNOgKCMWeI/
 IMjTgSG/hQof4o0tefStCPBXoIVm32IVY478V368bs3BHBnJ4JdUwiUVURETsz6dy+Yge1A+/lf
 O8HvzYd3007HKgeXSfOwHJ2t26lG+f4f67c3ULTbN1LFcGpAdb5jpRL+euiCGqJb7RBw2s/oJsV
 RFhJJtilJQN9+G5x2WDmgEzu70bySUm5AdkbRuJK0Wr1XvC9lPtCSkq6uWhSMUWoKLFviPGxiYk
 gjFCr/0kTe/Ca8M56NoR/IN6Z/d+lBy5TzZCwtHaNgj6OWNcAPsW7r0HYdc8lMWLuXFfEuEi
X-Proofpoint-GUID: amGTCSfi4CGFw39j0mFZKzwl-GjsaGv9
X-Proofpoint-ORIG-GUID: amGTCSfi4CGFw39j0mFZKzwl-GjsaGv9
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=682d917f cx=c_pps
 a=ztkV8ooph0rfw1Th5QLTnw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=aeOVX965xWMI7SUMHeUA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On Wed, May 21, 2025 at 09:39:42AM +0200, Cédric Le Goater wrote:

> These routines :
> 
>   Object *vfio_pci_get_object(VFIODevice *vbasedev);
>   void vfio_pci_intx_eoi(VFIODevice *vbasedev);
>   int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
>   int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
> 
> are exported to simply define the VFIODeviceOps vfio_user_pci_ops struct
> (and they don't take a VFIOPCIDevice as first argument). I wonder if we
> could find a way to keep them private.

+static Object *vfio_user_pci_get_object(VFIODevice *vbasedev)
+{
+    VFIOUserPCIDevice *vdev = container_of(vbasedev, VFIOUserPCIDevice,
+                                           device.vbasedev);
+
+    return OBJECT(vdev);
+}

seems to work.

> export vfio_pci_intx_eoi()

This is definitely required.

> Also, does vfio-user support migration ?

Not yet: we dropped support during the v2 changeover. Happy to drop the
save/load config in the meantime.

regards
john

