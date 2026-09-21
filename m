Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3168EC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cKA-0005fd-Kr; Mon, 21 Sep 2026 07:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cK5-0005eG-5M
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cK0-0007wz-8l
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:36 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAfNpG3340875; Mon, 21 Sep 2026 04:36:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qHj+C2VE+N+wpmTYKPESfOW17DUhSGGcuAJwa6rvx
 vo=; b=X/JfYX4iRR1RBLdgSCoyRVkxfd2nwCELvPdCCSnMn6AbZgKd61TYDOuBa
 jV9gcwzlqZVo3styRDF0kg5xMI27tqLyOU3EQcMvM/tbo8VjYgIRBCrqebEGiddj
 uX3dH28ZPqn3i6CHWQ5ZYVhMEY0FENF2691VGS8gzs7is66SKvl5ENw41tmJJER2
 mYiucij5S1jdjl7RHRv9OhxkhffS9znFZlaOkjnuc+3cYmXncwBINGA/qJ5X4Vfp
 D8fb1yv/VAq+ed5VqD2VZH7AiTqss2vOZLtdRVVoIqxBhlti3tRHCpNeZwOLAwOj
 PKR1H5zMPKfdpR5DpncRNx0XzKqGg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022103.outbound.protection.outlook.com
 [40.93.195.103])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gssqa2v28-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:36:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljSczeMHL3gvcWbOSFH8sx3Y13lZJKpLXc6mmHAgWzB+wSJ2+Phpv6SPsa5mhJhtEufSD7+NIMxY973nl5APja2XEeIin6tB6UAwaF8nKwKgevepM2URknTIgqh/eNarePRt9Ir1EiazJI3Y841aibRSvrbZ2SygRymvzaBMLeYLu72Y2iZbiQIdOL9lX73i552grxcT9riE7UHWZIiucgAZxpOq7WL86VYYIyCJ3gqhivo3e+lYTAh5sS0awx8Yj8o9dnDp+dDxJ1XyLAyl/6ZKd7CF9cSWXQUxx6tCw7xCofdj9O5E9mV8PaIFNbHMeLgknZZV85MR6ZdhBD37Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHj+C2VE+N+wpmTYKPESfOW17DUhSGGcuAJwa6rvxvo=;
 b=Mp4QrpHJ7ubb5tdnjhA8ndOZ8uGLo8NNkNfxycU0+PM1JWuSWY4D7IyHCKiInEsBV6zBob9SbSdTg7bj5zvakoRpDZCQuBomxf9ZGhjqz7PnAKz3Pif3Ii8dUHMM4/pzBS5qiRjMtnWfic7TYrW6xM29ZMHj/C5slxQ8ruOhjQAhsQcL1NrtbKeWPkOtv6RBLkIkhiohovmiLhlqubtL1wBnr3AG5FxA/F0NEzgTugKjjsMlPqxfgH1FqOJyiqFJYIVmBPe84E1WuV3LjNgBO36yVw14Ul7vu14N6hGRyJld3RZzJ5tYU+7+/Ii2oU/XhWwKGouzFQ/JZo+7qH4/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHj+C2VE+N+wpmTYKPESfOW17DUhSGGcuAJwa6rvxvo=;
 b=Xv+EVNNWOhpAtWwnqSkxfjEwjmR+40/La+e9ZYuxZ8Qq/2bXCxsTYtAunDK86d9oZIcyxm3JnGgpkoUjuoCULo8DZ2E8i7Z1YAJEtHMjaol314i/wweX6NDbKaMs5/c1tBKPIYMHcV9LxiHULOXu6YT7l7xN9Smf1+S8XtyR7VQuDj4w6c1Sh5yxErX1vWC/tcNXbPuBPUweNf9arg503+y04EoTm2SxGRGQ1lEcXP8JDhOktIn+SXy9nZz8r718ah2S63dhy8VWfDpARrXqRO7IThvwuBjT4Leddp61LsJngiFwzwxOm1bAfs5RUEQaMRzDXP3ipcHOZAuiboHJ1Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9416.namprd02.prod.outlook.com (2603:10b6:a03:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:36:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:36:29 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 7/9] hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP from
 object prop to class prop
Date: Mon, 21 Sep 2026 12:35:13 +0100
Message-ID: <20260921113559.1299740-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
References: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d2baeb-953d-48f3-33c9-08df17d493c7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tKN+ni+8nDbiuc3522Pxr+TeXFYwpaYPc4en8s7lfoNTYqvGmFS1b56uTQHfiR3bxJxcxHjxvFhfBTsHQU2eATiEWz+Eo9hyzORJ99N+DCV6AMSXwdUbFP6OZoUjeu+SxP/ayhDD36DbbTUMJ6wFhMsZ0OwLwjf8SUjnW2xFsnpn8nBDLj2wZLySmo5ijC/YgHpbx8To+CSBrJHppDc/5CPoThedX91ZP924Fewh4au1kpZ+AyhZpFCsFMiyXuzGZn66YoMvk5h3BZceWOh7VdFw4AFyRohkEXXm3PY3zMiWxv0M680aL1GTttD7dRALICSUOhotqFmjmuLEvl3uzhMxN5vc4apSjpzkZ9FXqliU6xwhUzEpSvXsZyxd96s1sH5Tr+aE7MMgfT7D9X7QeaN7FGYa5ICIQH921cB9VFGmNp1t3wXGdHUf9p/Chbw9baqOgcu8dtvkvZkGLucsh0226NPSo3/7FB7usv/b5i2sd0Se7BjITr1r2Gh8/GLTzlfL3NSVUqNPEkxsv2r/+MXcJpT/9VGDhCXzykapYFIi01h3+8TvXinPxEtgxWwoUU2Kvsa/V+OkAp2Zs5x13o1HSBdBDPc83dvt3LHn2gE3RnYI7ytKp2utW09eMqmSaepgaV66obU74W88+vPGKYlmJwfll2BWM67se3MjF2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHN5Mmx4VEdZMGhDempkendzcTY0WkV0dldYWm9lQ2lYVGpnQlQ0Zkh4RDk4?=
 =?utf-8?B?RU4xM0lYaHB0K0ZKcHFtQjQzemlybDI0aGJqdlRYWEM3WGwvYTVvYTBGRXZJ?=
 =?utf-8?B?eFJ4OWN1MWpFUitTQXNoVnUzeEg4M2l4TnhNRjExL2VTRXNRQ3RqUWQ0VlZH?=
 =?utf-8?B?Zk9ubjh2bkcxUUltQzJLMVZkTlc0endXK0VKMVJMRHV6Ni94L2dlZUZwUzFF?=
 =?utf-8?B?UzR4dkVUK003YkhCaXVjcnRFeEd3QlgzblpUWWlCSDhwR1JaQWE0T3hCMmx2?=
 =?utf-8?B?d21IS2daV0tPb1VNZlFrWnhaR2U4RUY3ODFlcXlJL0Q4aWJZTkdNUm1kNUFV?=
 =?utf-8?B?MkpsandCMjFaVTIvSktwcWNPNVEyRCthQldVeG5pdjNLdU16RFV5NXBIeXVi?=
 =?utf-8?B?U1A1cWJxYWxhS0w4dUpFaXIrcm1BRkthUUpIcURRV3VQVzJQaURQTDIwUTUv?=
 =?utf-8?B?V1FiYlR6SkZYWVBiMlZWaFNGUG05U0EyNHZRZ24zU3R0NlJ0UFEraVBtd1Yr?=
 =?utf-8?B?SUZXbVNSSVpPR2dzUVJUUmptMlc3Wk1raTRhS2g4NXZHQldEZ0t0MnVsak9y?=
 =?utf-8?B?L2pld0d2RkFjMVJ2K1VpL0Y3ak1aRm9qU2JUclJwMm4xdUZrS0xCUitoSEhQ?=
 =?utf-8?B?a2xlWURVRnVrOFhZdUFSU3g0eTlqSk5lckdLSDdZcEE0SjhKalZjaHE3NlV0?=
 =?utf-8?B?S09GOXhDUGhuZmhSLzloSFlSNXFiSko2b083ZkpUWFgwM3ZLYjFYQXRGRFhl?=
 =?utf-8?B?ZzdNalR4cDhXSGV3SzdwS1RURUNrTjArUHY5OEVvcEt0VmFNWVlETUIrc0Q1?=
 =?utf-8?B?S29HS3lmR2hBWkVBSTdLelROdlppRzE2QWdCTzdackNIU3NackJzWnJBT0dP?=
 =?utf-8?B?R0J1aU5TZXFITm54NmIwdnhWcVZ3ekV6bVZtN2JCeVY5SDV1cUw5R0EvbXVD?=
 =?utf-8?B?SlN0emlZS3dnWXorZGZVem9XUVc2M0lMMFJVcVVqcVUxR3U4Rkdrb3E4VVRi?=
 =?utf-8?B?L0oya21nR2s1cDhySm9JN2NXOHJLVGpESldjVFlYL0xBZnduZTIvd3JadXAr?=
 =?utf-8?B?QTVmWkVBdUc0ckFwWHAvQTVZR1BFSWZyNGZjRmpMay9qZWtxaElDeTlXeUlr?=
 =?utf-8?B?NmFpQ0NYN3pXTzl5djZhdTI0cFNTa2hYU2FIOU03WU1XNGoxTjh1c1BpU01W?=
 =?utf-8?B?TFRiY2RLbWIrRlBqWVFhdUx1bXc1blUwRDYrNWlpVVB5c0JIelhxRjB5TVhn?=
 =?utf-8?B?UzRSZWtHaENWbTlTZUhkTnJqL3MrR1ZZeWR2OHRuUFB4T280N1ZqSzhqRFRh?=
 =?utf-8?B?NHJTeGpseUJ4NXhmQklkVGo4SHNLaXZRelRxZzRja2tZUDBoeHNRS3d5NVMx?=
 =?utf-8?B?N25YMzlqV3lka1NtVXhzVWp6R2R2dHo1TmsrM1dnamdnRDloUDhpa0hjcnk3?=
 =?utf-8?B?UkxHazkyejhqSkwyY2RGVDFTVWY2bG92eW5FaVlhSnFIaWY4RlYrQ3dIb1Bm?=
 =?utf-8?B?SGlYTkE3YkFVaWFmSTlUUkQ5ZjlvVklKWGpsNlM0V0pRaHVBOVM3TmFqQXZr?=
 =?utf-8?B?ZWtNREFIK0JKYUpHdXRxTEtza3BnRU4rNjNuekdGYTNHTDRRYURKSDYzay9l?=
 =?utf-8?B?ZGhNZnZONXQ5TkFGcnA1VjRSVVl5VlZLV1pUOXJyY1czNTVYRUlKQjJRanFM?=
 =?utf-8?B?Q1NuRmhoa3U4OUFIaU9PV1J2OFM1QWsrcUF2emhXZnh5RkFCVTRuNkRlVXBw?=
 =?utf-8?B?ekR6SUJVN1dNMGFqS0RXaWJleXI2ZFZaMnl0WTFCZksvUjFkb0h6ODhvK3pi?=
 =?utf-8?B?L0ZXejZpNFVybS9zR1l5ZUpOU0tUU1Z2MGNNZzRYU2VHcUJTQjZPcFZra1Fx?=
 =?utf-8?B?ODlWTU1kMEZZRkcweTI5bjBTMWwrR0FzdDFJWThqczVrZFVDYklYZFBZNFZu?=
 =?utf-8?B?ZUVOYXhIKy9jalFTOEVkNTU5aU1rM3EyaVFHOTYzdXVrQitOWjFLbndpeEdH?=
 =?utf-8?B?WGc5T1NoNVBIRTVvUFpBZ29PZzloQStJdlNybENxeW1PbVp5SGo5QUNhWTF4?=
 =?utf-8?B?eWFTLzBHODdac3drZk1qdGRrR2h1K1gxbzMxS1p2VTQvRHVlZTJIQThJMEV5?=
 =?utf-8?B?c25WUWxqay9neTBPV3BqRktsK3F5RkZVNEtXSUZScTVxam81RjhDcFRLSW5O?=
 =?utf-8?B?T1lrWjdaM1oyS2NlQUxIWHUyMzk0cUsxMjFwSTYrSWg3eHdQTVV4RnRXNzh4?=
 =?utf-8?B?U0U3enBNZHNxMk1sbndUMmhZcEo2Mk1UQ01yUFdzME5CYmRSRUhpOXhZQjgx?=
 =?utf-8?B?SmZXYUNSOVZTeFdTU3VhWHAvSjFDZDBlanZMUjAvYVJUaWVwZ0JpbXQzUEJM?=
 =?utf-8?Q?SVp32vHmAvB9JTQw=3D?=
X-Exchange-RoutingPolicyChecked: NHIemIuyO9Mq99FfFeZXO2zdM+SBz+8iiLA5j//UxcvVihq2P7cnltZgbs6o1Iip4rqkgSq7e+/0JkTp05yUPNQCOfpUE9TWyHqvMwLxRLvRlMiIWsmbanVct6VWFcRu4Rjolh+T1AdYPbJqJrJS21Rog7BzsANJPkJiWpTNPuBJOqao4yiSup+TiIVQv250o1r+cwqDKFka2iz7Y7hzujhLU+WSDdbUzmYt1Pur3KXUqKjtsf2M5MAlnaH2hSGGa2ifbQdACNsCuZImV19vHqmv4H/T+NJsiQ1WxamPsm8IEZDjKR46nihVBReEdX5cy/uLJdUeqy+IcIZ7cWDuSg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d2baeb-953d-48f3-33c9-08df17d493c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:36:29.0859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qrvpqd60enQBORVG4NFAo7uE6tt6T3eiZ1bltqBSkAEEZwKB18YfY81/14ZF+/MFGijZLrCtQfwRsMhtFXdgwnyFNxKhwDSDBa57EgbaR/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9416
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfXwdV95TVmdb7b
 TaxW5noLGGm2CBMJHoeumcVGG+2v/v2L1AsEhARtIrqXMOKbrywhRsD0lPRU4lGRH/eGcxSl81J
 FeXU4LkbD8PGLh/b1FdksYZDEsTbpl4gL6rOL/3+151RsHiF2XyTQRCbkTrHPIMMnS/N14Ya0a6
 EB54z4Gn0mhzZdRsW3JAbSXBX3GSU0j7GVS66putfiIBMF1k85acr4ZYrkQC7q/wsDthAP7DItv
 GCkQ0GDqcibYs3bQflEbg670QkrGXupC8JKL2u3JIpXnmFOaY8W7T5Hr6o2n45GMN9DHIBLFGIF
 jsR+/h2nYBiKrwjNNexh8byilQMUPKc/ioDddfoh22i1BbcTP4iES4nX+gFTv+vyuI6BRSqf9l0
 eeNuaeDzHBBE+vRyMaf/akCKezW7BlXsDBoNezUi8JBCTtWnbJwlRHPVRD+qbJTmtlK4bU2uSv+
 kk2eK+UCWZ/cVJSwU7Q==
X-Authority-Analysis: v=2.4 cv=DfeCOftW c=1 sm=1 tr=0 ts=6ab116be cx=c_pps
 a=dTL/NSpv458ZJk1fBD1pSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ByzZujTaoW8sYEn9Xg8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX3D11nFTuCMRH
 wT8hPuIpJUQpwDe7S4kfvwtMgbWuOa/KYS3Y07HUBg2V1bQIi8NNz5SMQU2hydSYPkQZzucfE5e
 TLEI9/8xUDUBCLgWCsYpOT9YjystrPI=
X-Proofpoint-GUID: opf4PmBzA8sKh-vOd43RAmn1iZZeqaaG
X-Proofpoint-ORIG-GUID: opf4PmBzA8sKh-vOd43RAmn1iZZeqaaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/i386/pc.c      | 5 +++++
 hw/i386/pc_piix.c | 5 -----
 hw/i386/pc_q35.c  | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 70677786bf..37d199f2dc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1795,6 +1795,11 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                     offsetof(PCMachineState, alias_rtc_time),
                                     TYPE_MC146818_RTC,
                                     "date");
+    object_class_property_add_link(oc, PC_MACHINE_ACPI_DEVICE_PROP,
+                                   TYPE_HOTPLUG_HANDLER,
+                                   offsetof(X86MachineState, acpi_dev),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a929cc4dec..63c4667ea3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -306,11 +306,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         /* TODO: Populate SPD eeprom data.  */
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
 
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
         object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                                  piix4_pm, &error_abort);
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 94cd71124b..c3ce9c5649 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -247,11 +247,6 @@ static void pc_q35_init(MachineState *machine)
 
     x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
-    object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                             TYPE_HOTPLUG_HANDLER,
-                             (Object **)&x86ms->acpi_dev,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              OBJECT(lpc), &error_abort);
 
-- 
2.43.0


