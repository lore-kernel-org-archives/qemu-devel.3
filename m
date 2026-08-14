Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57127C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuneC-0001q3-8B; Fri, 14 Aug 2026 04:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wune8-0001pn-4S
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 04:52:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wune6-0004iH-DS
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 04:52:11 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E7h0l91204336; Fri, 14 Aug 2026 01:52:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=e8eDyiiPrIgDEp+6F7DzItLWOlS1PadsSfOQeB5ot
 kA=; b=Js0Him+e9QofLRlPlxhwvSSnPRjOftGrS3Y4NXmkXmDChXeKtr59/XBmm
 KqP4MlZFKo/x4/dd9Q0P/6ZDuFeIF48z7kYsKIDuwZ8KnRZ0yw80dbxp21/gNDuv
 He7uqy/4mimlboQffwn0PNdfiAMBo4asenRNR+P5dQ645q2UA7DLvzVJxWiUKdHj
 GwLSlKDcTP7ZOfH8t2F62WCqUki2an04NhKnveMCAKOhl9NV3sW91i98PPOsMPzu
 WqTYv191yzwA/JG8T7WHOovmaZ/BXxLCkoDCqf/Sp2pCUAt+CuVZ7W0HzSCmoNCz
 D1eIATG0TpNy0BPG2Fo0+DB48QPgw==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020102.outbound.protection.outlook.com [52.101.61.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1nygs4qh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 01:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCtNw0Ahy200T7ZUtHsplP4WTr2ijF/LOFxNYmXmEOwwljIQ8WWiXX5evSwmzu2kNzEObPxvVnoQJQc8ytLFSELfDK842bONNx9sbh/T8HeItx8HeI1rdbQzydVf1HKntFMdlp5KGwdKIXY5U6de/4viYmGkNk241uHpq1d9CSZI1rikB9eOJrbHuhG0mm2/LimoWtxUxGlbwAS3wWmV3apMdtbUjT5UulMr5PdbWTh0tJNkP6U5sxfi+t/y5058f/nH6npiwdGeKKQKCDsWXaBd/t3WScd9dCKmuekT+vP9DuWiNxBxcyrGaBKivr4Ka9XBupqTcgXhbM9LaUHjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04saYxt9Bboi9Fy49jJrPjdEQFzMMtmCrb13FjbucgA=;
 b=MzUgawyDvkEhoeadRB2F/YogX7CPh1ZCJW9aTTQm/Nedb9JBqpGEKW1yAH5rCwuuYf0PyNVb8KEjxGiiG5xXYupqWbxTcYyQc+muy1UlxN3mpA4pyulPxRdTxtKO2kajjIAnIB9SSQGLzsftL3UTsV6lGmVtrWrwIzHsTxkip8A3P/89BWXrBAZBxdg53cenKmHcgeKdsxBiQOHnuoO3MbtJqG6dMLQX0ZeyckJuB84UUSwuAwgW2B8yFHLDcMaOEsb0DyMBByO/A8t5HQmlQCD/jQejt6a/I4p3HqN+toNZ3RRUzLxPF4jw+XYKQIv+xqyWnymG8xePBVnt33A1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04saYxt9Bboi9Fy49jJrPjdEQFzMMtmCrb13FjbucgA=;
 b=j/2NBNf2WEJJ+wneW/fAogjD/4Z9aZCKopAFzphwkxHGlFDPXQZUk8YbMkLMtxEmmlkfvBfsHnGKT3Rdd9QbTsr9RQle3POYSsHM/dmaf6+FwabHHpFPmZpEZNmTDsGq6Ca/dpQe9saBc3I9klcVfkrySRpdeFsTJnqhm3NseQfdN7MTujCdq0cOD80A1flhV3jF2JwK4b/Wdc+NSJ0lINRLIy3mJIPmDyUTGS3lkrU0r8hLau3usGqVbkk+F9ZmUYx70tWMXRfjXgLf9ZZ/et3TXQvjaFoQdJheoR+CKqflq4S0VTNPtzF92j9qg6BVbGyFi/iq1qXYf3NzbJsACw==
Received: from BY5PR02MB6180.namprd02.prod.outlook.com (2603:10b6:a03:1fd::16)
 by SA3PR02MB10973.namprd02.prod.outlook.com (2603:10b6:806:45f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 08:52:05 +0000
Received: from BY5PR02MB6180.namprd02.prod.outlook.com
 ([fe80::5bab:a96b:f604:d7e1]) by BY5PR02MB6180.namprd02.prod.outlook.com
 ([fe80::5bab:a96b:f604:d7e1%6]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 08:52:05 +0000
Date: Fri, 14 Aug 2026 09:52:00 +0100
From: John Levon <john.levon@nutanix.com>
To: Naman Gulati <namangulati@google.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
Subject: Re: [RFC PATCH 2/3] vfio: mmap sparse regions backed by multiple FDs
Message-ID: <an7XMMoApuo3ye1d@lent>
References: <20260811233930.401797-1-namangulati@google.com>
 <20260811233930.401797-3-namangulati@google.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811233930.401797-3-namangulati@google.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P302CA0029.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::20) To BY5PR02MB6180.namprd02.prod.outlook.com
 (2603:10b6:a03:1fd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6180:EE_|SA3PR02MB10973:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a175115-830f-40f4-56ae-08def9e150aa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: oWpz+BR8ke4sg57GSD608/KUDb4aERRQFwZaN3wIBSnUBpfjf+wnIjfazZu8rCDIr837BWnf9Wwx/DI7Mj0EfbR8TM2WjLZXnJw7ho+eqwS06fz56QswbKJnm/vLOtLbD0AxEcqscsMDaw2OarBZH480IEgECQPPs2m49OJ2h/cgpJxARg+nF6qbUrBG0xBXw1+e8KtiH24hCv8o7Xty/HgQurQwt3JfF994yseiZn+9dNhQQiRl+O+Ni6itihe6xluoVwSQOo/6MUrA8AQ1DuPe0cKh2cZ72IukjefNNGTudkTfchYCylf2yq0ib178IVLGFWYAUjnvNmhwTUmNsxL/pPSh9j+WkfRK7MrmPmj9yHj8VbvNfnso/emukwjGCQ7RWKk4Vbp1ESs8qOBCEXnl+M9mAhCf1pKgucShqQYWjpwWdTShhzFtR6oa5GNZywk4g8SjCkuKEHRMeEVVXDZkajojGLAEQhL8MKpDqAYeVacH83aoWI85HULDWy5x2YlGWSBSn4nt4y8hxUxzHluM3JjsvA7BYP2vbm0cBJlfcDghN1NOy0MNPkAof5niYxRWYfjzLfNomH+qFPF5naxqLn74pSIreYR0TkgPVZRJfnLav++A787STI/lHJOFDWskaO1GH5vDEmJt+UcaJKdfIUMQF9RJpYJUUNUc38g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6180.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?j2HXq8KmyHh/EtaESGw7mrzm2MYp92+hIZpNFgtm1caRkiPYZscenJ3iqe?=
 =?iso-8859-1?Q?wmJLDSOHtgRWRCP1jXGa6zfBaix5Sm079EVvCUj7C5+co/XRUeJQItPpqF?=
 =?iso-8859-1?Q?eOOzqwEKJEF7l8kT4nVdIKgl0t3ECugV6Y1mMi2Q4y+qBVUe4LMGgloaOd?=
 =?iso-8859-1?Q?MOzjBXID5YpB5G+KFi7sYfWEen7wo4w9VWUYptD+ihQos2+B2jYKQhggxl?=
 =?iso-8859-1?Q?8pkP+EowfDaW81GwLFaZtr+ZH1750s+mWb53XaTc0OcTbKjdA3bHN5tFVx?=
 =?iso-8859-1?Q?it4rE4FISumwhGgeHKbqU95K9IAZ9t4YE6QDfdq/r5pkRhsqmMdau8I3js?=
 =?iso-8859-1?Q?pHQXVgEq1g6bG+hEHLCu05tRNfL5ZfczJBkWNoiyCojEEuoEonN8XUcXs4?=
 =?iso-8859-1?Q?3RYV3gMFqCT/WLqVf9Go7RFWopWg6w3Pur7c9jAOLVEol/htKzAvcSQQYP?=
 =?iso-8859-1?Q?wgPKR+YgQJkVVWxRKwfSVFcTeY7G+Jz9R4GENyi52xG55mhCXnEG5/bG/T?=
 =?iso-8859-1?Q?XolBuMeWkwHqnkqFsnfz9ZUbPosSet2q+6JSKaCM5Nwk4kCcXQ8wyolVbJ?=
 =?iso-8859-1?Q?Q+G2QwmbT+HYHyaJomGCsp+MCHV8VYkhiX/baf0tWW/TynsraHv0pGMnqH?=
 =?iso-8859-1?Q?55+c1ZjToba0+fQ4c1fgmjlw4S2b4xt8LV0BBxrijZCci6B+5SY6f7Ra1c?=
 =?iso-8859-1?Q?mT+m0gnquLXUFdsrQorMIG7H8i1xmYxSdZn/88stxsRpJxnnR8JNLqD8Nu?=
 =?iso-8859-1?Q?HsPqpjGmjo+4Y13AFJ/nkj9OK5/GVJS0+OWVHlVpXSdbTUw2wW48owefLm?=
 =?iso-8859-1?Q?s6hvc3hgMSKSl6lwnnT1XShj6bNYoTknrrcMWcVnXRZk4KLBXz0xFIZyBb?=
 =?iso-8859-1?Q?C2v598vEHBiHijZe+EQRmEqO+CE9BSc6LpVU/GRfwt8hPHao11sVSEVTKc?=
 =?iso-8859-1?Q?BsKPOoB3deoQ3BMm2aXXFCe+rt8Y/ZTTFOYj8325BUIZkRk8R8geFLoEFD?=
 =?iso-8859-1?Q?R8jmDVouIUIS7tVGuFqpmM7lQ5WeFhAZU/Ucl99Wa0kyrhKFu8zeucl4+2?=
 =?iso-8859-1?Q?FBraVpWkcEO/b/D2NEt2hzVsOwQ8c8saGayCuBNPXiJ+3CmZYlHXEXL5zS?=
 =?iso-8859-1?Q?IK7dS0sSRuChEQe7WpgB9Vt8CAkHhqFnE3BInNM4cZQaFEvIW2FvNL/Vyr?=
 =?iso-8859-1?Q?4QmKHINb8ymYTQRbrxKRzoL3Dr54gLaOABU8ccCu8n5Ecgo3P0HymaZ+/t?=
 =?iso-8859-1?Q?q8lLiQMBZQ6lRMTLgIgaVhNJhnhPVzki28e/aXxayEQy+EQvcRYwTnNbaK?=
 =?iso-8859-1?Q?BYybv1KLbgKfu47PGzlW+sFox0waQp7U54NDyd8JwrlP1PJCD4Za8tyQMU?=
 =?iso-8859-1?Q?0/H2o4FLi+8ZaewTs4RE/3YQIM6AHUVUy1WMVmR/gGHKHj3PBSd3RGsG0m?=
 =?iso-8859-1?Q?3ev4r4DFl+ryzrK9tvjtV7RRGhEQfwHRneB6/HXrCi+2MfbbuQ5Js3eBJV?=
 =?iso-8859-1?Q?ASWv6eI7VjjXvfjDGcAhs94iWjbc17OpHfzoySgkll97zp9Pnz/+MeW605?=
 =?iso-8859-1?Q?m61c59jWyl2joleiFU7Vh7ZcCBCZz9cKOuM2wwTu4EtLWZU+YCwwxGaPTH?=
 =?iso-8859-1?Q?3rcjbYFQAquTsyWvfifU3pZ9s9eOAVGMYgH6jxUA81r6rJHpsyF8pEOAq1?=
 =?iso-8859-1?Q?dLT4iR/AN2Am6S8KEeswVrf5T1s2Cb2hpnRZAF0hSY83RZSr+1kmqXWpOJ?=
 =?iso-8859-1?Q?aVjovkR57Q0mZy3kvICH4AdJbJqgtSUrU5jMuLDFEctUvBdEPMnAqeUnce?=
 =?iso-8859-1?Q?icgsw2keyQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: a9dDkKwE1stVX1EzhxJ31t7tNRCW58KqHHn1BANAyfcgEsSp/z/oHJXi1NBEukqPUJeWfEnheKmfD3PFRQJrRsRRDUbBQblo4FscMJHyDY71MlYUiajPZ9M7vlp4fbH5MPN4YAcPUZtY/uiUfgvJsWA/cYT9UuLVGFPvlXKs5fLn3DTTzk6YGIvsVJ+gNKXZw0k8X63OecHfk3RHhBIRHNLfrUE9WM5POHa4mee11afHzyIMRlAHJ3A8swLhUcuIKdfxizoKtKtjKaWZYfhSvvTFPNA7GCwsz5uL6N/sRzYn15Fr3Htxo2iSek6pI6mAaxo8YfRKdnpAJgh2HuPBfg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a175115-830f-40f4-56ae-08def9e150aa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6180.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 08:52:05.1235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwRxKYLgHdm0DUEyEzvxLESrjRep5V/tdiXIUbo2WdwyFSnzU1HvgENTZM653LGqZrr/AGGEtEvhtc3H1mqHUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10973
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2NyBTYWx0ZWRfX+42mXF9cAv8z
 RRjYn0T7BwXbyBf+F3K5euNZwjxlaNyCIbr4ABAOCidDEkTCZs+Qt82KpbqYCsjj3lxFJjFopnc
 FdN4jtNktSGPGuf7aOx2oeJBZpV0hPY=
X-Proofpoint-GUID: 2XcT6WvBuXqv7Jp-ib9JX3BXhiLlsoVb
X-Proofpoint-ORIG-GUID: 2XcT6WvBuXqv7Jp-ib9JX3BXhiLlsoVb
X-Authority-Analysis: v=2.4 cv=BPeDalQG c=1 sm=1 tr=0 ts=6a7ed737 cx=c_pps
 a=M2+OpPQAT0SLGkNgjpGDNg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=KIBNCuwn9UVIqJGXsAsA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2NyBTYWx0ZWRfX8HNBmOluaHhB
 xE/tqz2WAR/2R4H0Wh1ZTNJPjg3kW0EJczTpAueEawLiwbExYmLJfcXRnxFUhmKnLOiepApYeKb
 SjdjJkIdaFUaym8rhKLZhveqynwCHud4O/G2MyOCDTzYWP72aPj5AGBYYw18XSso9DNTHbwjOlQ
 wusC04R1+nfnxl/t5aF8W3ht/+7ziWJOn5LVRhKLMwrOHXgXmP4Gjba1EYp7v0r3zY32NHLrhil
 rN9qYf4e3bRFp3PJJ9I6j7bd8ie49TXRWFN268N6fthDWSIlBAcbGYsRw0q3FBIrdCAbbm5+xol
 DdMDjXO43TaKPgEriNQozeYS7IIkhS7+1EKGEJWBo2Z18h13AGNIHaORlfxKteK0Ya0dLiFtYpu
 d6XQLyhhKp/yh74hFUNNyzKfcoKhuFuK+FSeJfMEB9+rWb2nFEKckidLjKO9C8W+MlhrcGWJrk5
 mYxs3sNgdPk40IJF+hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
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

On Tue, Aug 11, 2026 at 11:39:29PM +0000, Naman Gulati wrote:

> Generalize QEMU's VFIO core layer to support mapping sparse memory
> subregions from distinct file descriptors within a single device
> region.
> 
> Replace list of region_fds in VFIODevice with a collection of struct
> VFIORegionFDs that internally holds a collection of FDs to mmap per
> region.

This is getting a bit non-obvious to me, we now have a region_fds array where
each member is also an array.

Given that you've introduced a dependency on VFIORegion in the
include/hw/vfio/vfio-device.h for the other callback, I'm wondering why we don't
just store an array of VFIORegions in VFIODevice instead of reginfo+region_fds ?

And I'm wondering if we really have to have two separate callbacks for getting
region info.
 

> @@ -184,6 +184,12 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
>          return ret;
>      }
>  
> +    if (fds.recv_fds > 0 && info->index < vbasedev->num_initial_regions) {
> +        vbasedev->region_fds[info->index].fds = g_new0(int, 1);
> +        vbasedev->region_fds[info->index].nr_fds = 1;
> +        vbasedev->region_fds[info->index].fds[0] = fd;
> +    }
> +

This seems quite surprising behaviour in particular - if we happen to be asking
about a "standard" region, then we'll store its fd info in vbasedev. But we
might not be setting device->reginfo[index] at the same time.

I'd expect vbasedev to be const in these callbacks.

And what about the special regions > num_initial_regions?

I feel like this callback should be passing in a VFIORegion to be filled in,
then the caller can do as they wish with it. We could even embed the
vfio_region_info into VFIORegion for convenience for the callers that want caps
etc.

Alternatively, if we don't want to do this, then at least get_region_info()
should take a VFIORegionFds out parameter, that the caller can then do what they
like with.

Thoughts Cédric ?

I'm also not sure why we have a sparse mmaps callback - why can't that be
generic code that handles both capabilities? Are you concerned about the cap
number clashing in future vfio kernel versions perhaps?

regards
john

