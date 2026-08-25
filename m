Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6FBC61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRd-0003iy-SX; Tue, 25 Aug 2026 09:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRP-0003ei-9Y; Tue, 25 Aug 2026 09:43:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRM-0002SU-R0; Tue, 25 Aug 2026 09:43:50 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PAwERS1743174; Tue, 25 Aug 2026 06:43:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eWI0MDxWfkFmDsvBIaDYysPAgYaNFYa5caM5EWRwr
 zU=; b=rSI9ytDROoZ4G/6zmS8Ya8R8Oav29FsMr7IGDf5r7mDL+VaUlSVGd+YSl
 /FqxAF0IOtF1TTUeKuZlfIV3iN0VQg72uwxB8fVqBWAcXJsiFNu+coE5+Lcis6n+
 w9vnZCR9rrwrZyflzZr6UjAJqSNf3ozTK2z3QYJC9/jepBPrqIwa+wNtrczoyM0+
 OooIViBtMExN4d+tN4alsaS4jtWVi65LWZU8lP8xa+r6mZ5xvm2sTOSucIl45fYz
 Ir30S+7hAh0JSS991wq8FVUWnvUhF0TZOas++6hbTo2wx1hS6cfL7KEu9qgSus0f
 AQrgr7kOyAIm6dlKT4TY1DStU5B0w==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020077.outbound.protection.outlook.com [52.101.85.77])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sy0jgma-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM6s/PxtVASxUxbf9BbjAkYL8PgTB/lOgnG0LrX8s57r3xYiTC1LxvfwEVDI8yikZ1pMAMjK9TDKN3V9W1bCk8rxZEsxM9WkBeBTfOvEbb3h0E6Qs41cIvTyDmFbqsbFV8wozOgmrkJ3A+9I7BLkU/suWmN5ycwpWt9vrT0bRW3vGTIR1Gfiq3tDJwQXhx6yBpO/kf4w8EAfhFO52wbk3R4aMrbuLKwZ2kQ4hiKlHwVymOVCDyFcjHDpWyqYR5GgMejlQ57dTey7PGP2y8a+i3Cpa0ngpb0HhslYmc5GA7S4sU6cvZd4lMYZkPy0bSGzQ4Laco5/24r78saGxro5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWI0MDxWfkFmDsvBIaDYysPAgYaNFYa5caM5EWRwrzU=;
 b=UlYBau+uB/mcUeqGias/B0vkjNwykI4F+48a7XXW/fn31t9mLoBiKjT0plprYhxy88LEzX4G9tEG6tQHTuNVvpOUi9frvEZBes3fsBP90ygWQt9YK5wAX0rqQVaZXa8rKY1MtE7DJ5qs2s1VhDcbkU/8urUpVwjjlMe7c5icFBSUlONtedWoT3gBqw6Zj7n/f7lLZZAIkIKDq2INZgO/damZPiucjNZwoBGgnTmJTdid/WpkZ1XFi1sQe11Hjw4wNeukeJFYaWSqleQWsJXX50cN2pTAbRlhafRBXJWqY8ygd2pVnhCaalVPkziODxMuLkz3naOjelNp9u0z6qdXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWI0MDxWfkFmDsvBIaDYysPAgYaNFYa5caM5EWRwrzU=;
 b=gim2IknSxyY0PHSikb7LKHo+s6fg8dKYp94t0Ogf6zmcxWMAdf0uYUbZ6BhstfCSZ4D4ddrc3KivSZ4LiMRYXm15zI8m4sT2pJeMYBurnxrIFAFi8q07j6+R2ITpW/cmbSqRizRThno+rrC3trrpHh2p7FFeKaAT6N599y/E8UZVOhtI2EqgAoAKo16CN1+X89gsaCqC4LUGTEiq264Qn//S6AMmzNiuhRftSxD829Z5/EkpHbHLzataWGV7ccRKHIMO5ZEjmjxFk6Cmp15SHWQZRbUW7ih3N2fwydgUYqfuu/Op9t2ja09nVqi4XL2sKnxXEFVrI0nRiCWrCB4svw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7681.namprd02.prod.outlook.com (2603:10b6:303:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:43:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:32 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 03/16] qom/object.c: introduce
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() macro
Date: Tue, 25 Aug 2026 14:41:24 +0100
Message-ID: <20260825134320.1039012-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: c6db92a1-a4c3-4f91-6550-08df02aeda57
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|18002099003|22082099003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: FusL6Imf383WTI6I+AyVpzlp/dyHYPWGsNDjii6ozAr6GxAXWi+FenTjVLnqk3cTimc2T/Ukdz+xPI3C7tYPyBhyMLsKjRxK6sx9/EGnQ3v44Z2wl9eYrPZ5DmmOdqxDHw1szbkmEN63SLO9xQyNJNOrroazglmYNTmqC8d2L9fv1pWl86PDC186erHyRVX08ESqIVqpKMaJTayouYTT7kMd8+LD2gtEr08Gp+QX9Edsieoso1ud9ptOyIaJUbldk8Y9Go/3pUZHcOTxe9SbLsUtnHuJbv2vJ+NXwMcQagKk+vAdBObPqWKB63X2/M0MsbAB/7MBT7ItXfh7X/XDmw1sBM0eBYKBYmwIiLoHrYBPq2Qpq4e/RjlnUnz5xWRkR/6v6QgolzQZi3ez+df63O48bCLWUbX1QFq6AY+VTyq/snNQxKX2Sz1bUYCEl6b6axg+AEhAjFrTU2GbpC2nYaVDGv/9NBxwBmV0eM7dbRoPx9TEis3ny2Dvu6ov0K3cJR92hV6uWeYM3BE53+O2z+Xj+KdVWRjFmeAmQQNFhud40ib+SXGlrb3HtoN54xCjeAVqlU/hyibKD8pir0ouL5Hfm37etG+JV/kTLerarmvaHwut+At08+6ChIUV1aqr5glmEeS3raFfglXCdF48J2n6CJBfTdA/1r6j/Crap0fMM6mFHz67KYekd0FmtAQF5PuG6tIChqStwxylDNUkiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VThkWTE4K3gya2RPU0FRL3oweEFhQkVsdm9WQ1diOEkvbWxqUEtXUVVQMURj?=
 =?utf-8?B?dHhiTlZsR055MGhsU3k3RWo0R1BwL3lrUTdJRlhuTFRLS1o5bkNnOG9CTUJp?=
 =?utf-8?B?clVtMGNSWVVhKzh5QkZ1czdyM3dQWUduMzR4WGR6TkJ4VldCUXhEOHNoUnZW?=
 =?utf-8?B?OWhldTgzOE02N0ZsZzVCUHRwa1ZneE5aZGd0eXpsYTZUTXl4bHFIUFdiSEVO?=
 =?utf-8?B?ZW44bnpqRTU3R2w3NGNYSVgybmQ5RUloVXo5WGhhUXp0STB5RTVDQW1iL0p5?=
 =?utf-8?B?VHF1Z1BNNkFWeCt3WVdBWW9aanZER3Y4ZVZnRjZkbEp5UGx4QWo0U1Zya3E0?=
 =?utf-8?B?bFpDQUxxaUcxTU5PME1HWFR3bFY0blREajA0RnBvdjBZci9rNWlWMzRTSGlM?=
 =?utf-8?B?ckZWOVYwdGR3a3h5MURoVmtoQTBsenZBbStUYitCUWQrSUdDZllKREpUemI3?=
 =?utf-8?B?YWMyVElXczI5bXlFQjBMY2QwVGRibVJLWU0rUzRVKzlqUS9iWlFxTlJtMmRN?=
 =?utf-8?B?U2dWSVRwZHRvdTBmZ3RVdk41VTUrck9TNUVqU0twY0VJd2J2czJBR0NNRm5a?=
 =?utf-8?B?dWs1UmRUT01YS25ZWm1nY1pmV3NmS2xXb2t4OXBINVp0ekdvTFVGeDdweDdK?=
 =?utf-8?B?UzduVllKMU1Ia0VjMmlqZ1k5cVhqZld0SWNYMmhGb1FZU3pJV3pvYkdMUzNw?=
 =?utf-8?B?dUFKM0hmeEovS0NCTzc0NVMwVEVDd2ZlVDQzZ1hBUFFnUm1EU1dyQ21LUCtT?=
 =?utf-8?B?V3VWbUtjaDZYTjRsdHZnNzc0eEJBaDgyZUFON05YNnExSWlGZlR1cnNlTjJr?=
 =?utf-8?B?M0tqVi92MjFxbzF6TzM2bTB2N1luMEJjemkrbkg2OXFDL1JLTGtGeWpSUW5l?=
 =?utf-8?B?Q2N6V2l0Qm95RE9wZjMwZG5MTGZ0WloxTGtwM1Zsajc2ZkU0cm9MdkdLRWhu?=
 =?utf-8?B?WXp2dnRSa0ZjcnFSLzkzeEpONzQ4YnRZblNaMDQyZnN0QU91NXhpSVlWV1NO?=
 =?utf-8?B?L2M2cVNqNGtoME1UY2dFbjFReitoTVNFcDJaa0R5dWVCM3c2QnZTeXA3SURt?=
 =?utf-8?B?L3BNUSttNmREVEt0Q29BS3RZSStRSTZmTDFrc0plT1I1YTZRTTRrWTIyZnJX?=
 =?utf-8?B?ZlYxeCtSV0lsbE0rL20yWGhtWVdmTnJTcExmUXh3OHhIUFdVQnNwRlJhbmtm?=
 =?utf-8?B?TnFxVnVEMDJFQzJzK3A3L1JFaVdqNzJIeHBUTDI5b09Hd05yc21jNnZQRUtI?=
 =?utf-8?B?V1BrOURvejZSV3BGa2o0QUljZkRGaTlhZGh5bDBHdjBrai9LU2ZzQlVsSlFX?=
 =?utf-8?B?UjRRZjAyTCtPQ0J0cGtyZDgwRUZaZnpsbWo5MWtGWnozRmtienpFemtHeklJ?=
 =?utf-8?B?NWFLMHh2citxcHBTNmEvWW9jSElhaDMyM2x4NlM2UUdVTlRPUWhGcklNUTk3?=
 =?utf-8?B?RFFLeVJxOFNJNE5vWnVpdlpqdUFVbnNnNG8wMUVNcE9iTG13UHl4bk9UYTd4?=
 =?utf-8?B?OS83OGRSTXk5bDFZOGxZaVBHOC9LN2QraVo2YWlKUnQ0U0FhRldYRVJzQ3ZN?=
 =?utf-8?B?TnpsRkI1OWZJV0l2N3c2SXBzcjZPTUkrY05tMC9sL0Q2OEw1MGdVSVR0b2dq?=
 =?utf-8?B?REM2b1NkWkxuYitZZHh3YnB1OUZpTHcrRGdud3NNTEMvRmpPRXJnQ1ZHVm85?=
 =?utf-8?B?SEpoU0d5YldnQWliMzB1MEtjckg5YlpMYWtObkQrVGVQS0N1UllwMHhTazJh?=
 =?utf-8?B?MWNSWnloamdQVy9GWk1yZEdROU44OWhGV1NhZHFwSjMrNldRUERmVHZMMnBR?=
 =?utf-8?B?c21VbXNwazRJemZzT0pHNFRHZ2cwZUVuSTE2SjhtcFFmbFhRbVlFdnJGdGxn?=
 =?utf-8?B?VERwdGpKYTNhRTdubzM2Y2dKUkVuem4xV05ZSkJSckRQbkZ1cWdKbjVtdGtt?=
 =?utf-8?B?bzFRSjBWb244Mnd2YUY3YjN4THYxUHRJekx4STF1eUxnQ1ZhTDZrVlVoSmV3?=
 =?utf-8?B?Z3V0aEJzUFRDNVI2VCtUWWwxa1dwK3RKUDdzWldsQlJxT0ZONDJMdTlvTDBZ?=
 =?utf-8?B?cGF6RUkvdzVzWVVsQVJ3MWpSdG9JYlUweVVmYlpVYVcwMVFsNm9UNnA4Z1U3?=
 =?utf-8?B?R2g3V3N5OFlMQkNsZDl6MjBkY05ZQmxuUzhEZTZZaEZ6bkR6K09ad2IyNDlm?=
 =?utf-8?B?ZndwL2JRMzZnVC9MU285ejBzK0JXRWVTV3BFOW9HOGtxa0puYzE4eXBOMXRo?=
 =?utf-8?B?UCtBN2ZlNU9kc1gycy9QVVg0LythQjlOWDlWVkNXM0RUNWN2dlZwSFovYjRn?=
 =?utf-8?B?TGQ2QytJVS90OVBQOS9BL2FheUkyOFhjZ3ZHcHlMVjU4dmVybTFtVTExQU5J?=
 =?utf-8?Q?lxJDdDHkCQgY6wa8=3D?=
X-Exchange-RoutingPolicyChecked: hABSQYWtJh1lCx/+D8P7Pe6IWmTa6EEUsh8vy2cezbvHZ0e+oKBioO52DYF55iL1B7uaI9uZqr9RL433/1mRwUUmnVIOZ2RgXhhisrnmI8/y6JKmviAw2d7B9jEKhQ+roXmGK8uyymRei/I0XJECYpMontyJaDL2cMH/MG4QwrwNFBCWZBov3y42udHmCZoQOb2xjj9YjEUz+QeInC3qm0AruuDIaUpiVYiEnSiTV3UEll7XVCL2Dg0Y8F5/kOyTRuCEYvjYZj/jjKSBPUfYynqwAKsd6SBO0Xu7mVslHXNCLKbH/tFRBr6BAlkQloMCfcTb1fKpwl1oc2LNBcj25Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6db92a1-a4c3-4f91-6550-08df02aeda57
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:32.1230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6DwnkKmm1WKdSRK8b/KXkR1tNMvhdrB+NjgMZH4YJa/VroWBK4Iv/wp7/Gd/gV6lgZauTFea7aalnnl4nIVHIlStFeoA5UxJqSZlJ2grYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7681
X-Proofpoint-GUID: P3Vs6HCXi2AE4wnZKR72iP45trHiPzcU
X-Proofpoint-ORIG-GUID: P3Vs6HCXi2AE4wnZKR72iP45trHiPzcU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX8ArEuAnMoErD
 M5di4IEVD8y1q6XsvdKD2JBBhh5BKPPi2Q7HyfCiPu1+5RJRWjATGNUI8YTary1C/N6ycTs1n0s
 ZQ+TbZSWwkM5HDDP2s1mBvYxM3BXTX2KkOYmT3zQI0eQCdGNeG+IyAVkI83Pea/UIiKcMHWfail
 NFF156q+miKlEOjNy3okwDgw+YcT6Qjo9ca6KaN8R2VIlP/QwryWE6xifxkKYMiX3fCfbzvr+Eb
 inXMd4Gj86DaHwzUYCOn2VhJitFZqizzEoHjrgT2+xx+mvn+4JhIRTl8098dz+6RXXuJxNSHAwq
 6weg3Xj2jlJn04/ypmdAgkx7PicT2eKkPa0A4/WI1uYZIY0Yh4vENpMtSwQJDeQQV5O+B0wdmnc
 NuGiNZ64ec64uJz+2pq47zDZdvwybN2iFvUjhv16A0HI0VOUgk8KbOtkNu7jQ9RYCeEozZNgGLI
 PPhLmf/frf1raNl9f7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX1BndsfgGwr42
 km5IIILy1lrQgiwsOXQHFFUAkPJrJkGN9lE+k3rxuxswe4ofzWN/5Jlo1dAxgA5gFqTYPP5IKR9
 hL6YJm0eP7oRBJwNKSA5+HoVFRMgdHU=
X-Authority-Analysis: v=2.4 cv=EZ34hvmC c=1 sm=1 tr=0 ts=6a8d9c05 cx=c_pps
 a=bbl9BA5qyFAQDT3iAuOISA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=UWV-rqafSl4XcmA-RNwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
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

This macro defines both the QOM get and set functions for the given scaler
type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index fe4e552928..9cb2cae4a7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2738,8 +2738,13 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
         *field = value; \
     }
 
+#define DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(type) \
+    OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
+    OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
+#undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
 
 
 ObjectProperty *
-- 
2.43.0


