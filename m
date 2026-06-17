Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65CDCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZntw-0006Qj-Bb; Wed, 17 Jun 2026 06:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZntu-0006QK-LX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:53:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZnts-0000di-Iu
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:53:42 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8YKxB1079061; Wed, 17 Jun 2026 03:53:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DFsy99IrMxOe8HEwgZdrZUbeqvB8sybd14zRsO3CD
 5M=; b=WlTd8VGlEtexa1BQ0GpSDC9LhOvQ2dgmAxl3TJFjHBYQakY/854Axo4sQ
 YeI72gsT0mpowvRHhrxV8IPbrvgL38TKWJ1vtu6np62ApIAFUVOhLJDSs1BF3iHE
 clykNlE4q+sycRFeOx62j8YN76xcNXtHEi6n2cRaaDy3alKFykkwZ27RoKU+D7+9
 xVD7wJeRoMQgg5mzZ45nksInuPX8EL1W4kzyDLDG0G4DQGLYBmR2SJMOEkzoSg+h
 28BqrDAekWAcp0FmQVHFrlgQIZI5fq20ipT0rMFdtU37CYqySdTuiFlz45DUpAhS
 IR44wQbepesr9hx9bFPmGX2Aag8hw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021112.outbound.protection.outlook.com [52.101.57.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4eueg6sgqq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 03:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXj7iDL4TuP9mQfM5fPammYfkBbhXapJcOburU9q3/Bewg4pYp0Fys+MAoWcDxBb/c9qDtIAQGO/Klfmpfx9TF5N9UOYoJ4kNL+lrisUoV0a2C7XJ7fVxr8gPZ2emue5Fnddh7IzLn0HvVbY7n6jGTvXujWD7cuyrEJd9CdMMsBs4Vnni1woRFDDiZGK5AxvZzOLF+pBiBkIAvLClAJTOCpOb8RnHo9i74E6pnt2/MGW4vrC9ktO126TQks3uRYTw4eb1hHkHwRJXuWcy680dxKcAUMe4uLeQBgOscucI6IvQHJ/eSfX/xjKIHc+vIl7dyv4UNq51ZkLWgHmXpXgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFsy99IrMxOe8HEwgZdrZUbeqvB8sybd14zRsO3CD5M=;
 b=UTumjSYODgVo7+DG5BDZIiaGZAhWWyL+yCeR3jmSVgIiDxEJ1b174mlm11IW+ndnNDM/S/U38GFJs3LBC6fVsT6nSlAwLvXYti9H9IJk92JQQuhk73GjIpQd2FPbqYoDVSKUsNGFcGQccbjsiITykU+wfjzysk687gaxTF7oSSWIuM6fnQn5z4Jye3+sZtkAswMW0DnBmnQi5g49CbtAT6fjKX9pHQcrUN0tIUexd2Pkk8BhG7YAvXMON02HA1S5nFk7k6ikQKqjP87iF/xfUVP3284V0Aeu3HLoCkswYX9bx4qtpVSNG+/+LrROK34J8+xkdNe/tqvqtN9kmpyTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFsy99IrMxOe8HEwgZdrZUbeqvB8sybd14zRsO3CD5M=;
 b=NBbVl+q2mhy2JR4hZxAIvDuNGVGWJZc8jfoz/2knoMUNhSBGs5x/TC46PnbNENOkhn/i+GD6jwzrCpUXL0DWT21FmkLTmzkI0NGf1J6oBP/3B7pA4HM8Zw2ACvE/cc49ET4J7yvPOoXRFiLcdR6PHeHhtGq/kkh8y9RqrK08kxHyfDLziVA1KqK7hENkHYyRDvYpDh8NsQWGVPzv3pc1VNA6hvIT4a8Y15gxwVWk0RagEqTz8o4QmJGbkAy82qMtATJKisopCS5NEZvolXpMFeVkn+NanVXXbMI5QgC+UHIzVyQ6JlUOE5Jm+b9g+sEt69dUwAaYceq8qQHoGmmzlQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB10625.namprd02.prod.outlook.com (2603:10b6:208:512::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 10:53:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 10:53:15 +0000
Message-ID: <a3654fa2-ea0b-4256-ba40-97a7ece2ea2d@nutanix.com>
Date: Wed, 17 Jun 2026 11:53:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] qom: deprecate embedded objects and instance properties
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <CAFEAcA-Mmt8=1iPOCbF=XsghFzfNN-=GHyLr70iUNDFFN0OKcg@mail.gmail.com>
 <ajF8da2GLWkUZQpb@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <ajF8da2GLWkUZQpb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0139.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB10625:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a7cdc5-9bbf-46b6-73d7-08decc5ea221
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: pw8JBPHoP80AvprpcHH/NqaX4MKOux1Xd+RgshxnJyVsv9AXEGLg9PJ1oeatdJHByzGiRFcgq1An4imRoRGcT5zV7GS3PcUhkplcLqxh2SOokhb+RE32IJq00B8c/eN2nuucPzAt54SxqsxGL7MVnE617rP3negv9GBjad8fdCQqHixSLaH0kA6FpC+1eeLokfbd83gcKAa8EvMXAeJgpW5kzk5VDv+FVX1Q9zZEXxm3+t3kQHG8dOqkh76VQyZZMcYVZtUy/YNB1ZQTeFZbZqAadrpBA4pO8RV/Zkl3bBE+78i/6xyCE3T7BmopB+uXWvTDx2zulcqa/9qLCo1vZ0CrdzS597sBKuJdC1Zrex1/TuaByV7VO+3JfInoUmOm13pkzdK/nXcCNen4CBoEKSXM81O7ya4rFiIknGjMM8nhpYXjqdT9GvkCXEbhPkvIotEX9Lnvy3WmB8kRJylH5ZTSVx2K8Mxk+vJ5mpw+J/tD/iUzH8DZM0qYP6FCWU9bjqHyRLTxJ6s6yV8KWxKXnuLo5X/XCL5W9HveRST23eMNenHwChoDOM5KMt/Ki7E1kRSnPr8RPy9x8uGrAl0n9k9KtqGoYAkfrmeKZhr4TB3WtZmh2900tOsQubSu2mxjgfuRWlT0Ju88nHASCa6f3Vpdyy4d3leBUQQVy4751BdDZ0ZpEFxLYSN2jcBDmg0U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXpVS3J3S0tUWDRLTDlzQ3hOYnhwREgwRUJhN3ZVOW9oWEIzQ2JYWFRtNFpn?=
 =?utf-8?B?MjFkTTJLU01jTGpYWUxFZnRsYTRleTl6NFRVMWR4NkN4UEcrZlVCR2VUeVJ6?=
 =?utf-8?B?OFRJQTNQZnlDeFhwQVlHbWR5eWdweXZGV1oxbWRrcDBqcEg2d1hBSzVnMTZV?=
 =?utf-8?B?bno1Tllya1VKTTZGSlJ5TTNkTWZLdTludEV6YjRnbmxGaUdBN2lmb1pab3Y2?=
 =?utf-8?B?cC84YkNkWTMxYXVmdDNwWkhVSndXc2h0b084SzlKUE1MWlFOQ0c3U3c2dVN3?=
 =?utf-8?B?UnJGZG5PcUllVUxBcDVHSUFkT2Q1dWcvSzdGSVpqb3V2QnZ6MFowK1FTMXhr?=
 =?utf-8?B?SFlQSGhYRUNmb1ZrZU1QbnVJNXNnVzZnM1Vrc29TZ01JZktMclJ4cXFSRlBJ?=
 =?utf-8?B?dGFEYnB3WGU2Q3JVQytVRFp0ZlhBMk1TVHVlam1mQkZodnhiYjdoYmh5d054?=
 =?utf-8?B?cjlMME1wOWhvWWwxc3JwYndEN2d6NklLY0VIMDJGajg0LzlSdkZsMkwrdGxB?=
 =?utf-8?B?QXJIejdhVGZnOWNrUXdpKytGeEN6aGxXRHY5b1NNWHhYZS9aTDVUZGFwVHBD?=
 =?utf-8?B?eGIxOXhmRTZhR0lTZFFqN1JSaEF4SnJHc0tuWFdZNzl3WURHcUJwMUIyenIy?=
 =?utf-8?B?U1krdUVPR050OUxKbnpjcytucEIwMUdNTXVtMUFyVVBjbUw3ZHRadUdvb1hJ?=
 =?utf-8?B?YVNWcFMvcnMzWEY3MnppYXpsbVVWUGRobXo5RjFsdkU3S1U4V1BKY2lVelpn?=
 =?utf-8?B?T25wV0JXT3pMaEpibm9jVzZia3RtSXRDWWhHRmFhQlBHS2twUE0rcGZvNmV0?=
 =?utf-8?B?bGlMSm1GK05nK0p6cFI4NVVNVytnMzZZUUR6d2l4TzhwK0N4UXBUT1I4V2lW?=
 =?utf-8?B?TzB1MlJBdWZOTXhEWnQ0bWZVUGhPKzUvRzZpMHRNYzhyWlRhVmltTjIrK2lp?=
 =?utf-8?B?WjBxMXVyREJCSGhhcFg2bkpMYlRBMjBuTExTdktpNE01RU1wQ2cxMnJ4eWtt?=
 =?utf-8?B?TVJOZUxBV2hXTHpQMDhzVUMxN2Z6L21kVHo2ekQrZythOFdPK1YrbUo5QnNK?=
 =?utf-8?B?QWxlQzlWYm9jR0VnT2JMSVF3RXVycE51TS9NRFpzUmN4R1dNdzh0a1hMNmtj?=
 =?utf-8?B?aThjamVBeXdWNk51bTdwbE5qNzlYV2hROFNZNHdNZy9XVUNTUXRLblpIcFFU?=
 =?utf-8?B?RmhJWkgweW1nNVg4Mzg2OXVqZTVMS2V3M0gxRkppdHl5bFlBd1U3RE5uUjFa?=
 =?utf-8?B?NWpPUjhGMDcwUm9UcEtRQXhiUDYzVzhLTGpqcUk0MFBHdUloQjllU1JrU0ls?=
 =?utf-8?B?SWdGOG5JS3FTMjNGOFlSdDFESEd2dmVaTDh6bys4Q25sbitXOXhsVUNzWFpv?=
 =?utf-8?B?Um9TYldiYlpSZjFLcFAxWjhPdjZ0OWFoTm9HV3MrN1pDc095Q3dNcTlsT2ZZ?=
 =?utf-8?B?TDJDaGE5YXJSV1hZNHJkWUtvYVhMRHZpSGFhS0NoLzhCWjMrVWRvZi9XUWcv?=
 =?utf-8?B?ZVJsMU10Wi9ObXlydS96d2tLa09oUWw3bStOZCtaUkR3bU85aTZtanR0bGtM?=
 =?utf-8?B?djJ2QTdkbytnZStuY1hNTXZrZGNNSUNCWmNOdUZISVY4SnZBV0RMd0xoUlc1?=
 =?utf-8?B?eENpQSttOG9jV3NCbGJZZ3lzUS9GTng2Mkk3RkluTDk5Z1ArM3hSYzZrZFpX?=
 =?utf-8?B?Vnk4ZzdBd3FoNm95Nkp5N2xrNkdlV2cwQVptVFNuUjJVZnpiV1pQUU9QM2l1?=
 =?utf-8?B?ZUp5VDVaUHkxYkdFNnlEOTFlaTF4SmRmUVAyUnNLSExZR3hBVUpZQ1JiYlM1?=
 =?utf-8?B?OUhTdG9QazVEUEdqZUpmRGlSYTRXZ29ER3BadU52M3dta3NTcXFveDdYT0h1?=
 =?utf-8?B?bzhLYlZZL3EwTWlkK3ZzR2ZOaEgrQkNNYzVkTVRiSWtmOWg0NEh2b0hSb0Yy?=
 =?utf-8?B?dVdDVXJjMERocGpVZ25Mbm96NUZISDZXZkJWeDNaMnhnanViaVAzSm5OK1hU?=
 =?utf-8?B?T09icUFyQXIvZ3B2Mkw5LyszWlllS0RwS2tFc2JkR2VoMXQ3a0grYTd0ckRh?=
 =?utf-8?B?V2tHMVJhOVEybDNsZjZvTnV3Y3d6R01LMEo5UmE1MHdDd1pldmd4MlFnR3Rz?=
 =?utf-8?B?aDE5aXpXaFZ5ZnNRZzd4UTRQblV6WFBRV0lXaTJQZEdOMkllUFBLWm9qTFpX?=
 =?utf-8?B?cFdVL3RzcjVpOHB6b1RaS0J0N3Z1RmFuYzIrVm1ZS1NwdWU0TzhmTUpaL0Ew?=
 =?utf-8?B?TDNaZjhNRkRFQnZpS1VyK0V4UlVrdmZtMVNncHJDczJTdUE2Rm8ya0I3aU16?=
 =?utf-8?B?dkNuOWczd0RzTXpJL2xaeFFSdS9ybFZNL2hCZEt0T0R4V0hwaFhlWG1MWXN4?=
 =?utf-8?Q?qvg12mA1tMDyg+S8=3D?=
X-Exchange-RoutingPolicyChecked: ilfRkob18zxAMJYCalieoCmvgJylxFD2inMfyIQMsUEJr36owp7kAHTG/oDqxxKLoAVyiqeeJZQS6qnlqMF89YzoP/um1FmilLZ17ihY9ZJiMQjNZWlY2RFixdy/cwL9T33La9U6k83tRVEjgUoOF9SEhFvHPZnGV10Rd91oPCVpnkKISXBsNOR7ZnBT/YpFVknXP4DCT1tz3jlsU1+2Bs0dKjJ0jW7k+DqsICd7ZxwW9yZcWq4O7/Hhuk25wKFalO9JxqnRI2MgNqLEhQ4gEKjV/LwGoHqjZ0cMaEpK9har/KXnSgpGTKXTteDnQ3eMeH/5GmQpI9s2E+tBXoh9lw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a7cdc5-9bbf-46b6-73d7-08decc5ea221
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:53:15.7438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTS7tKh0eMi/A6VcDGD/AEigWrxeB6Cp8tEfbkqm97I1bdRm6NinUwFLeoVTXfJFqISi+iphyRzapmh5XVByuF/mu9GzW0qG7dAjGRgiqg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10625
X-Authority-Analysis: v=2.4 cv=CL8amxrD c=1 sm=1 tr=0 ts=6a327c9e cx=c_pps
 a=Tfh5kxD+BHZRkXOJdNqs0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=20KFwNOVAAAA:8 a=IPV-s1B5tYAjVDHwIxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMiBTYWx0ZWRfXyxWWCXz+oR/D
 53vZ+t3qHD+eQxE5QWwXE+ZlfKa/zKgv5lAN5h4Ftcc6TUld1f7GOKtyJ8DEJuVqRvy7rlUTwcy
 4iGlo6aMusIa+O9itG0Squ+P1B+yQq9CIZd4rdAGtLPJj+FSamK/jsLF/l9O7J4MjROfjItqiiy
 +XgpT8vjfawCrwzyeQwGd5ukBuheXa+IhlP1m2gXEoEKRRX9VuXtM1iPaP5Evq7zpdcLoJlagQi
 Kg6dgP1TmSUI5R99zD9eEPaS2NktcjryTc/BMfadVokeqiCVgELlVPNCuIOFjVM7DZBgxscm22h
 4o+Ru7HXDqNJ0YUSc29CXSoeTco0R5iyDIurgkXD5V/p8ZwftO/kUm1joyrSZ9+I3PVBZEeY/W+
 4UCkSyhDFSUGXfm8ov71meBnj3XW/bqerv/UUCRYe0hYxzPR81k11KE8cnNX16NXlPj/EIVlLyO
 J1cBwFJKID1MkjqJepw==
X-Proofpoint-ORIG-GUID: Ik95018Xkp8IlqG49G2CkRGKiyfuD2XK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMiBTYWx0ZWRfXxL3vI5nPWhEo
 14ZqX1J55uz/sHCMa0zxeSbtHrkOEalBmbsq5FxoZfq+bQ7YDEQQdhFgAhsilAK6aKEN80E2g3I
 ThVPxdl4HSHIC0GvBE0gM92PTy+IzWE=
X-Proofpoint-GUID: Ik95018Xkp8IlqG49G2CkRGKiyfuD2XK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 16/06/2026 17:40, Daniel P. Berrangé wrote:

> On Tue, Jun 16, 2026 at 05:12:27PM +0100, Peter Maydell wrote:
>> On Tue, 16 Jun 2026 at 16:56, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>
>>> QOM has two rather unusual / surprising features historicall
>>>
>>>   * The ability to embed a QOM instance's memory inside another
>>>     struct
>>>   * The ability to register properties against the instnce
>>>     instead of struct
>>>
>>> While they both look convenient on the surface, they also
>>> have significant undesirable side effects (see the commit
>>> message for each patch for details).
>>>
>>> The premise of this series is that their convenience does
>>> not outweigh their downsides, and we would be better off
>>> long term by eliminating their usage, rather than trying
>>> to add more hacks on top to mitigate their downsides.
>>
>> The thing I would like to see before we mark object_initialize_child
>> and friends as deprecated is clear documentation of "this is how
>> we would like you to write 'container/SoC' style devices, here is
>> an device written to the approved style you can look at".
> 
> Do we have any documentation currently that touches on
> this area that we can start from / adapt to best
> practices ?  I can do adaptation, but I'm not an expert
> on Device code, so probably not best placed to write a
> new doc fro mscratch.
> 
>> Currently we have in the codebase a pretty wide range of
>> different ways to write devices:
>>   - really ancient, not QOM/qdev at all
>>   - qdev style (lots of Device* pointers)
>>   - embedded-struct style
>> and I'm not sure if this would be adding a fourth style, or
>> rolling back to qdev style.
> 
> Per my commit message in the PIIX patch, I'm not convinced
> we need to store any device pointers in the instance
> structs at all in many (possibly most) cases. The instance
> struct fields are mostly only referenced during creation
> time and then never again, with the QOM 'child' property
> holding the permanent reference.

I think it depends: we do already have hot paths where people use a 
direct pointer reference instead of an object property lookup, but these 
cases are generally in the minority. And there's no reason why for those 
cases the pointer couldn't be cached within the device state during 
device realize or similar, along with a suitable comment of course.

The other case in which I've found device pointers in the device state 
useful is during low-level debugging sessions i.e. where state is 
corrupted enough that calling object functions in gdb may fail.

>> I'm not opposed to the idea of making a design decision that this
>> struct-embedding is no longer what we want to do, and defining
>> that something else is our new best practice for how to write devices.
>> But I think we would need to start by reaching a consensus that that
>> *is* what we want to do, and documenting that "best practice" somewhere
>> in docs/devel/. Then we can all be on the same page about the design
>> patterns we want and it will be clearer to reviewers whether new
>> code and new APIs and conversions of old code fit into those
>> patterns or not.
>>
>> I think we're getting closer on the "consensus" part but
>> the "document the new best practice" part is important I think.
> 
> Yep, best practice docs must be a key part of the story.


ATB,

Mark.


