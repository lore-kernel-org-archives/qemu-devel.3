Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE692C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRk-0003nq-Th; Tue, 25 Aug 2026 09:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRh-0003mg-UN; Tue, 25 Aug 2026 09:44:09 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRg-0002WJ-2c; Tue, 25 Aug 2026 09:44:09 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB1AlS1846113; Tue, 25 Aug 2026 06:43:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vLDTosv8TzniIOmM2XWKAH7j5CMeEqANclhC1lUsm
 to=; b=vel7QGchv/zKjeZrvqujuj8/KBMBFwV6mG1UOmgsEClhC4QiOsMQQYhYT
 fSkx/v8RXnGGnAVteoTq1hs4ixmbK4wV88BOXMOXtDlxIZ+vNiunBKQSCSToQ3yd
 BNIJt7YG6EQCiJbWAiJAQRk2Mb9s5T8M1xg+yY34yeqt+BmKhJECHaqzzGMdEl1Q
 lVWjExqKx/q1NMsH1wunyJ39yyv5Qp2KuLeHCe7rpXgGTBXI4iuMBPcPE28K7ADF
 F1JB/Ya3xqmTLyq/KuqtYA+f52Zu11v+Objt+Y5A+qhURnZik1+ItOr1ExWBpanc
 bTRYPHyQy1AcPtnBW8nOoRLs68WUA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022135.outbound.protection.outlook.com
 [40.93.195.135])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7baved8p-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrTxnz7uQExtehBrUiMoyXRoIs66ZyX6TR2MyyB28c37B29fxmzIzCJGUSB1BJkcTvJmSA0Eyr7w1qZfu7mF/WOhGYEi7Tnj+SHybqW6axFvOxagt5TaN9PqnP8qf+c+UKfeSqZiSjG6KMMc9kp7J/JNlLbwWpEdp8W3RZdITXr9siZs8H1j8OpWAVb2FM2jxb31pW2QO1A0qkGl90sO73LlfeNZ5ypsqJO89sPClMetLn//aBRyHGFhGODY2J0uRqnNFI8xEKe7/kMPNtcuRqBcMHpAnlYXu9iwGxQPsVMveDqo125NywJXElG+bGcJTu+rZRX6TzZuIWKZyeN8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLDTosv8TzniIOmM2XWKAH7j5CMeEqANclhC1lUsmto=;
 b=DzgZoDKrbVf6MC/Scd+VeAUZkHv0UhManlH8YFoBipKtX5lYQk8kuEXLxkDpAJUzEX1DRLuqiK9ctu1kOyiBPBLcPqwGNophVX5TyK5K+QxlveKdZ9QTYvj8NDt5LypRTBOlDPrMrw+C++klsYp1Kd3Hj0vm7h+6E7BpOfLgnXzf4IQS/3Gfu+xrV0tiYZf6sjyhI0jcYgZlw8rwWbAZ0imNTX81vQNUIyoktxyuObBeAzTN/6J9gpywWDftf4C9iSmD26E60SSGOe++P3g2OQ8stXLwuq1WmnbU5SFXz2IyRGnOU5mpDW/nCIq1BgxYs2JWdVavWhx1K1N1DJG4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLDTosv8TzniIOmM2XWKAH7j5CMeEqANclhC1lUsmto=;
 b=TGZtGe79+/PpdJovdJO1uXU89Mam49JdIDPYOrJGvBeB9nuQHTK8VvpsWsCh8bGMngoRZQcj8bdE5NmtoS3GhhIK++8kj1Z5Iw4Y9NgXWMD7jeUmw/Gy0iJkTnRUePw5Fe3PpgeHvFWXuAKTOMZVzZ9/lW6BoyLLHPjpVNKlr4drezcCiUFDuelLYIRYqvtb+jXLCpmUENB8GCUOGxHHmCDnCnAejjQTJkmNmMiBzUBS1gy+xUy4mbW1SmKTfxH/fR22Ax7kZMlP6USYHCK9lhLgDhhjuCQ7pvGLp31Nhi/oeSRhxxHiGjt+NksXlj9ozFg4yUObLcX7D6rsYY4e4Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7681.namprd02.prod.outlook.com (2603:10b6:303:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:43:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:54 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 10/16] qom/object.c: add
 object_class_property_add_bool_ptr()
Date: Tue, 25 Aug 2026 14:41:31 +0100
Message-ID: <20260825134320.1039012-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0165.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: a5885b92-f195-47f1-8c62-08df02aee782
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: nhN3dPq9adn9j9Ovxk0uTQS46fNfkitWCrK7Ao7faj5RpC1ne8NjoQBR/wIH3Lb8AeX1vgaCWv95P3MhV7/lH6RELf2ZAcfZVQ8rQXgJj063zZq6iE7hhLfYpl3F4b7VHAnOqucINS8QjtBgMKY7A8lGOEdP3vrXQwaR7MvIlNasXMNqlS0Vtx3ojc2CSTq9ffNPWJ1EIaX0vimO1pL/LrDEuotaehuAwWBxiFuDFamfQqES/L3UgBFxfxthhhEPbxwLKvSviS06In7Ub1gyq3ytk3EZVjx7pgW9Xz04gWRgDuTcVwUtlJpXNn1HJkxcVW6bIzJ4JMItG5qH6+IkbjztE5wjG0Ago1gU9pGzFnvVTaNa2FypywF4Z663POyrggcRBva++yrKM/HGAKIG0qRX4YWiwPm5Q3etLmSxIohGdgar4MomAudbBcI7Us3aV/l8eQiocWHRNbOFJkBhA56ai6cQGQ75lidFzUb2zb3gpRhyN0RNU42LNmHu244Ha36zHwM1PqnOYLCCkp/wdBmy1TvkU2onzOZhI9WiuGFNcmoTp8/NNNetIVj6E99fFWn3yn1oiKZS5r3EIeFjfz+WyE7LlCu6/O+yT1oJSzhKDoyf2RdSc3U3tRmpF4AZRRE1vCZWM+frhkkLiP14H9fW0z5nIKvbFAmieG16tMu6Httv88r47uETTeATZD2hvNPR/4MNyWVTygFZCt70/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZ2cFlVcTBFWXd4N1JDNHYxS0c0bWdIaFREZTY1eUtKbUtXTkt6YW80TDNY?=
 =?utf-8?B?bGM2QTErSTNtOEd2bGVXNkxwZ1pUSklIckNkRnNaWHV4eUlXYnpFWjlrOXYv?=
 =?utf-8?B?SHd6V0NDbFZPVERPS2lySDVKM1h4K29wRVQ2VTNZQWNOWmxPbENJUVlOSG5M?=
 =?utf-8?B?YmUwYXFKQWJtc3kwM1FwcHRIZkJGZUsrTjYwV0RkbWNhT2x3NUQ1UklKZFUw?=
 =?utf-8?B?WFQ5M0dWQVdBWDdXUU84SENIY1VXWmJVajVmZXdOcmJBT3Vld201eGFabXBY?=
 =?utf-8?B?V3BpdzJEMU9vV0FSVEtZZlJKZGZ0dEZmeGg4Y0Y5U2t2dHdwdXc2YnQrVEdj?=
 =?utf-8?B?em5rVHorL0N1bys2OEJkcDBPd3lMSUU4a012U2pWRUhyZmF1OWdqVkFSMnJ4?=
 =?utf-8?B?SU9DMVc2THJlc1pBdHU2UXBvbUM5SHB5dFFLelR6Tkp0bGJXenNnV2ZnVWdK?=
 =?utf-8?B?cGNabWduRCs2cDFicUZncmlkYkVrOWR3Ym13NU90UjBQdEJCNHZkMmFoSXV5?=
 =?utf-8?B?YTNRSGdaaCtsdXgydTAzeXNMYjRqeno4a0t6YjRNRFoxOVJnelhBczhqRWNP?=
 =?utf-8?B?MVkzbHk4RW81cWE0NHAwa09reEdrTHVHZ2FDSjVLY3ZwU2VWSW1ZKzhaWGVL?=
 =?utf-8?B?dWVZNGt5U0JyWElGSnBlcmQ0WStYdjFXVVFPc0oyWjZZa3k0NHlLcTNKN2xI?=
 =?utf-8?B?MmRBSC83OGJkd0xCUEthemJZQnIvOXJQQTZ3R3Uvci9LSVRvYkZqT3psNmpq?=
 =?utf-8?B?MXcya05QbWNBeHFhMWUvTXdVUkxXa1NicEdmTUxQcmt5ekRiS29SNmxXK3JE?=
 =?utf-8?B?T0VyMlFZSHJOTWUvRnZ1cWF6U09meXk4M21mRjVLNnl2YlBDWVFOT3NyTFBS?=
 =?utf-8?B?d0QrVzlFMFlnR3pzN3hOZGFIdmxzSi9xaVhTanl5K04xVnM4bFQyZWpTMHBs?=
 =?utf-8?B?ZWZUNnp2N1R5YXIvMUFmZG1sVWVsN1FZcTczSXR2S3ByamlyNmZOeWNHeW8v?=
 =?utf-8?B?UEsvaDR3UW9XajUxM3NMWVNsS3NiOTRzeWo3MmtwdVVYTTVJZk5HY0xLNU5F?=
 =?utf-8?B?WDFRY1JNR25NeENDSEtEWjRaUUdMcnA1dmhUeENSanozNzRrbWdmSmxKamtL?=
 =?utf-8?B?WXhSUDUwRFV1cThFZTBCbFU1RmFCcVVHOWxNM3VzR2FKOGdIc1g2ZjNOSk10?=
 =?utf-8?B?S3E3NlZJZzkxVWlQUUt2WUlZand1RXNGTVpmTXJlZ3E5Sm5hVGRpMG91MHdO?=
 =?utf-8?B?ODdTMjNITU9yS1l1Z3NYb1pCTUw4NTdVeGxsNGhWanAxMElzTHpvSDR5Nm9l?=
 =?utf-8?B?ODU3VjNIa1hFcXI4dUFTQnlTQzEvOGl4L3Jua1QrYTJ3NnFqQStzWWJZOWdI?=
 =?utf-8?B?QlRNNDF0ejdvQVJRS3hjT3dFSVhPMGJydkE5bkYwYU9Ra3ZLczJlY2hSa1hP?=
 =?utf-8?B?aG8yKzN3T0ZmbnZxdUZpenpxM2U1YU9EWVg4VTNhS3hCNzBwTVJOMWNwUlQ2?=
 =?utf-8?B?UjdRck9VOXlxdlNrek84YWo5MXlsOUh1aDhlVE5McElLTk1KMGZRODA5TDBy?=
 =?utf-8?B?TDZFU0VtcXFwVXRpbFF4RHUzYWFPTURWQnBlQ2VDdys1bU9vNGI0QXdGVGpZ?=
 =?utf-8?B?U3FoakZwcVBPczhYNlBoM0JHT1V4SHkzbWpWd0ZrQ1FDcnM0UWJUdTBLem9C?=
 =?utf-8?B?UzJFTFpDYUFMUnhCeGMvY2Mwc2VXTlJEWHZIb3FOdTZnZ1RQeTFmNk9SNGJT?=
 =?utf-8?B?WDArMExiTUV6SmZPUnhmSitXOW16b2VQQWQrbTFwM0xLOHBuMURBaDVWVXRO?=
 =?utf-8?B?Q3ZSSVNPZ0N6S3IrRG9HL1pldFlYK010QS9YV0VIWUNzVHZHS1pkZ2JMaGhY?=
 =?utf-8?B?VnFOb2o4NFgxS2xZVWNjbkN0Z2FOQ3F6ZzdkdjhLbTVJNExrTUk4UVkwd01W?=
 =?utf-8?B?aEd5ODF5cXlybDJlTWIrMm9JdXIzMEV6Zk5yVC9JWkNKT2E4VlRGUzJuMHJS?=
 =?utf-8?B?clZyb2FqUmtYa1BnYjVuZmZPUXZWakRBQ05UZ1RVZElKZjhBMlp1dzlaU0Nm?=
 =?utf-8?B?azdzMFpzcEVHNTA0OHIxUmFDYlhGUmJKRFlRQmpEeTQ5cEF6Rmptdi94bmVJ?=
 =?utf-8?B?a3BobGZ6aVdOOTdMVm4xYTdNNys4TXptTTFoZjZySnhjZGMwYnVGYTdqdFZo?=
 =?utf-8?B?OWE4ZGxoUEQ2eExkTXk4Tm1UWENtbHlkcGdGRXJTME9ucHd3Y2MrMDJMdVBx?=
 =?utf-8?B?d1g2d3NCa3NBdnl4MGFCeWpQa0tUb0VzQ2ZZa1hOVGM0Q0tRRlVxaG9zU2I0?=
 =?utf-8?B?RDNUbTdCZ3I2eFZLWjJFL3RuOVlNM2tqVkhVUUFhOEFuQWJhakl0bGVyRXRL?=
 =?utf-8?Q?GYVmsMu9zztsq+bw=3D?=
X-Exchange-RoutingPolicyChecked: dXtbhWhOns6sxQcf8WFtBtrO+XX67sruwRO37baWh3Sl8ful3MOwDXFeS0z2qE0V1DPpeUOEAy9IujVvyi8pfMYYzXs1RDE0TxYvdNi0viXDjmcKwDjBY/vuSMyNYcX7sk7NUwjkI0aDKGJXWIOM8rn5jpsCHUIXwswVrej6HLAc/zSIXxaEGrfJc6Jrt4TYDgA4z6SabPsb0uu2IlaAhwbMj5AKoen9PWVAbK0BDzlu+pOuIryLyjKoxxQt6wpPd+ImBXKDHDOVTrlwAZBU9/vM8uDAiLywAMf5tiej1F6VO62G4qtE47LNdJf7i7uxMa22oJpw8ZIGouk8GDgNTw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5885b92-f195-47f1-8c62-08df02aee782
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:54.3381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwNZ4jYX1PoQFOeOdB6C84gAO7XXlzZuVIC1ukxJGcnd4kHWvK9742MskQzkh6/0FLruChtJ04fQas1dDnFJQgXotWlw9VFm19vn6A2yYFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7681
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX9+hRS+apiZKG
 1+sr79M+WPqxUNA4eUCVxwqL/7fH5xuRhOoi9ebn1KkN5WocKQSJ0PslC1QhQrvSoXtVW5o5dcZ
 j1J+9bXYpWdjjroU5jGIA7tmg6eJqhE=
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=6a8d9c1b cx=c_pps
 a=j8jEPmhjjLnYR6B6k97zMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=kDmwn9SJQQ73BrzAQp4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q8KXG4dMwPd3BHz-aiouENXXArvTK_-S
X-Proofpoint-ORIG-GUID: q8KXG4dMwPd3BHz-aiouENXXArvTK_-S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX8ult5Z8sFIvA
 bGUfdBpTUIwFRcodF5uj4hL5Dda4u4P1LdB4L74q5tqJCGzJba2O0XmTzVsw7vL/9ZS3gibnvwF
 dHVsZzij2FSmUyDhdY3ags0a10HeEIHQ5WaRZMZUUoqU3yR2/ZB1AA6ccp9fWR7EbJcu4jmAq9b
 STCGp/hvV8FePKLdpbeLuR8VpwJg9B8xLff9CLpxWbZrjubVYKKOpbIprkLUDd0JmytlB6Ft/68
 TQdaZfn56zR47CFRG/kzs6595xlzUZvWhBsfy7wUKFR0IfVTU6M8M1WWg/+Ne2EZAV5kbYK708U
 Lt6QmclvnQBNhlKrH6a4xWKCN3WUG6AYANXam4vOJ8R5BXREHyKlbdyDdQgVkYMF5ODcXFyRn7l
 H7ldG04bfJElbQXUFmGVSUx2k85RIHX8w2jNgfy4tKkCwJ8uZJcnBX13oVu5mr8HtcrclTvRKLQ
 we2Z0iHRQaZWlgur8UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
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

This adds a class property that references a bool within the object instance
and is intended to be used as a replacement for object_class_property_add_bool()
where possible. Since bool is a macro then it is necessary to implement
property_class_get_bool_ptr() and property_class_set_bool_ptr() manually instead
of using the existing OBJECT_CLASS_PROPERTY_SCALAR_GETTER() and
OBJECT_CLASS_PROPERTY_SCALAR_SETTER() macros.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 8dead29284..de37016ba8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2017,6 +2017,24 @@ typedef enum {
     OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
 } ObjectPropertyFlags;
 
+/**
+ * object_class_property_add_bool_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the bool value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an boolean property in memory.  This function will add a
+ * property of type 'bool'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_bool_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_property_add_uint8_ptr:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index f91764aaa7..635eeeac77 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2750,6 +2750,49 @@ DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
 
 
+static void property_class_get_bool_ptr(Object *obj, Visitor *v,
+                                        const char *name,
+                                        void *opaque, Error **errp)
+{
+    bool value = *(bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void property_class_set_bool_ptr(Object *obj, Visitor *v,
+                                        const char *name,
+                                        void *opaque, Error **errp)
+{
+    bool *field = (bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
+ObjectProperty *
+object_class_property_add_bool_ptr(ObjectClass *klass, const char *name,
+                                   ptrdiff_t offset,
+                                   ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_bool_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_bool_ptr;
+    }
+
+    return object_class_property_add(klass, name, "bool",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-- 
2.43.0


