Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BF5C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cK4-0005dd-Aq; Mon, 21 Sep 2026 07:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cK0-0005av-1l
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cJt-0007tr-Eb
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:31 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAfVCr773954; Mon, 21 Sep 2026 04:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=C6g5NFpPAQbrNe5m7rreP4uflvZ5EV6iuW3IYYZzQ
 T4=; b=U1TIm477u3oirWpFylNsas2g5xL5nHH9jkTZAsrXU4of80COthLJcqy0n
 l8c4hLfMILhunckpQvxnxuUAz8lRiPjMq7AjMLx2XFBheITMOp2xw/Qi5aDewWhq
 ZI3Jo5kDbL7V8h28EVifbwiQfBe3MSpoWHTtLDTFwYWqJKXYOr1ccbR2e9uOSFKE
 uIi+tDBCNwehea1giURCaLdb2qQoT58xrUIX2z7yjj8rfEObI9aPWePl8nQHygc6
 69eW9nCLvq4byGUfrvV39Dq0xI7L/Mwx8Npco1TaWHpvVzxaTzIJMVkS20j/cMcR
 8HK4xfmuiNuxGlpTRVNGDT96Fp1NA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022091.outbound.protection.outlook.com
 [40.93.195.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gsqx82xan-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+z8ISqVl5NH29DDBN45XUWBnvMKTtHN8pzPuPyPKaL+e488MWTxcp9f+RdsfYadx+lOZCUWeFw7tlukSOx/hnJx5ab1cXlVF5CmbXy5Gs02TLCF910l1Z4UKZ0srp6s3iNSTzKyRBwzA5VoVSqqZyMJkO1UXADf3qM9OPKwXNfhZTm41zI/YGCa3vO2kQxQxw7jrEBx4kOIvfo1kE5J6eSpnoVHw0WNBcvAVHbD1PVwd6fmns6tFLjb5vrkrzN5YDNwIt4aoskUtNSPev6F3Pzw5Wjn7QSJcld+0lBHBUTDylt0N0Xa4LgH8deZOW5GazGwpwm0cNri5ec400qT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6g5NFpPAQbrNe5m7rreP4uflvZ5EV6iuW3IYYZzQT4=;
 b=LFTWvf667HYlOarVC3QKMksvfPINkPQpx+cJdOUkqxbnGCrNJnIpHQhER1h7SKstEVVOGXuwIKU/+PtNd4159kZv0V7X7uGfRsocUhLQHS/0sioZSJ8uc4z/6ClSYGtDW8iQ9Ol7TuCnpmiZGmVm9ppwi/5B6Q0CT4oouqYUfWy+QCV23KeFg0Dkj4CzQONOwlGj0RjMiYLAUL/QZVLKREDBvNa0Ef9DJ30mrEsn0qyBaiWBRmoPToYxN+BnWSrDO+FqZWFAd3X7QQsflXz5x4KhGYovzPhac3fc+FlXW3SfeFBcVPtWQ/r5XDJzrA9J4ub6SBWHC6GjX1Vc6oAG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6g5NFpPAQbrNe5m7rreP4uflvZ5EV6iuW3IYYZzQT4=;
 b=so8QS+pvt18RaW/bYIo/d9Ey/f1M2Oq8/NvJWSqBVKlJnYgPmcQdaXCbWikOWJpGFmcuFzk3PuR8OGyyV24HYgKRoK2rUjkMruJFKISUB1X3BpXii4VXxCcjDv0F+LYl6lApIb8+dKKyhynW5BtNMhf4gQAnk9IyjRy20y6wIbxoSp9q/HcUAdwsp2A+uLGYWwztdNIk85CUMmky3tGG+o5bDLFHf3OUbHbYbAdAvKOzW3POCqFWXx3M3xrfNHO71y65IC322mcap8/JN9XZZ+T/DyYNjdrDIfyNaGX7kmDFcqCyeuS+QMhoRs/bqZD5ANNx5Gx+bMrJ7T+P9GsUWg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9416.namprd02.prod.outlook.com (2603:10b6:a03:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:36:13 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:36:13 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 3/9] qom/object.c: introduce
 object_class_property_add_alias()
Date: Mon, 21 Sep 2026 12:35:09 +0100
Message-ID: <20260921113559.1299740-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
References: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0155.namprd05.prod.outlook.com
 (2603:10b6:a03:339::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f06b720-04e4-472d-6e00-08df17d48a75
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tYgBkzfp5OiNuJp6b6sDKArfrpY3r3hZePeosfs+N0YLWjDj2SZNOVNGek1CeYSlWYsNudX4gwaK7cG0B81fhBMGxWxnNILDyFwYWmiw9fmfBNU8b9QN8QbT2WzDkIUnbWW5khSOe3+MFVv5u5XTpg1IwO8G+crHLAFhyPLU1uIhx9NYqmWekmMyMR33EFgjYbZGxV/5oLe3lBSwjoMchiOCACFn+ShB94NmW8oIFBT/5qLi4FeO5ppRJ3m/Afqb95TM7NyfTBUXRukn0afNwDueOOAnzZDKl9E1sXBqaofmMYwPZub/bXqnA2VjBq6iYcmN54HgHh95elp15Wx2BM3ZPf2wTqGX0zKbVwCHSsFWLBgk0C5UAxUOavf+KOlE0Md2RMVGEKMOc0cK7oMJkIrj17KAPMzLRRLD6ONrXil5med6pvo0jm2HtjBx4J3uItSzOd0HJyGjJAos/5ydJoHZcrBeZWHUbDlc8HPItXi3Qo2UyfVgglHlSszXhJzjd36AdizxAdrS/2gZGTpvLtABxMUFzTLtowdDBRcW/QgiCDUeukYT7FDf7VDhv1AD++dHS1RaNxzJ6HXTHq7GAxHD+cLyOASteEPmmizRCTBuEjW9wkIaXRGDMzlUJuFrsFU14mL7Gu+/oW93JfVqOKmLZUK/DQZX0CZGt1cvorI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WpFENmed16JRInPcmdBfHYOhN7YEuhBXX0dm59HZwtWsDS8oE+WYkPufNfXN?=
 =?us-ascii?Q?TKvCd4Bl5NcAXjWG9bM0TuMrsfsxD8iBNe4sx5l3cyB7+tjq9dVJmnnzqDkg?=
 =?us-ascii?Q?nYx5p5OZH1mfOtrUGnV1DwSMPXhPUOJ6RWi0mfPExazcWVuhzmqepr2SGzYl?=
 =?us-ascii?Q?2Y2dqSR/sOyWwIyjdbep8E8CZ878PdQ//UaRhCs5Av3bDa/El/51nzAfeyRE?=
 =?us-ascii?Q?U049GjV3Te6rFJasWPLFeqj9eIAHsWZTCCA0ViSM5KtuX7QQi3x/BTNenB+B?=
 =?us-ascii?Q?HOrgjQvneC/D0riI+XXzP0RxoS8RfkqyaZ1Dvtm9m1Z1IsJuowVNW4Pqw0Wr?=
 =?us-ascii?Q?6OpNXkUqyWgGcn6dY1fRSmx00U+qkrlfwQyavGBUZ57UX33kHivjRYLt1VAt?=
 =?us-ascii?Q?a0iqs+RGPYR9WXrcNCeQeQL7c5WJuGfNcjzJ7oWiTEZAnT+AUU0aHXqahZlF?=
 =?us-ascii?Q?0YLbguRA5qsJ1v03Tpgz3FM+saJYsx0Bgq8v+/p2xOE2m/xg1py0PEMGJzbv?=
 =?us-ascii?Q?SbJWR90FZpYVhSmIH/rD7L1amW8LHHSCpjZ7zVamwVarmH+nIJZiNI0bAbKo?=
 =?us-ascii?Q?S8hI63lNkb2EultOQZgfvyiCJB069Pi8VQ3OMtDhbXox/wc91n1Z76jYdPPU?=
 =?us-ascii?Q?Uqv+8GUUdBXlE1vdn2NK8PsFQJOjQFdQYY4eq2pTx7xSR/fRd3TnRtVvVDor?=
 =?us-ascii?Q?pMz+cCWRVOtj0+2n3VDWi2jYHjgalb6afXycCr9Y040k/mtaj/Y+mZEIBj9z?=
 =?us-ascii?Q?0FtZpPeSp9CpKJRHah3AnrZIzzp8kqwR9NN8M+1BPPsElryeJ/9h0VQvz32d?=
 =?us-ascii?Q?lPT3OEI36P20/ER6J+uqwFIaj3OH4U+78zC5uu0hY6VTubLtE6PvYvItYhXt?=
 =?us-ascii?Q?SdwIQh2+kU9dPjpXaEh+kBp6z202Uc80KTcvNTRjFNiUb633qxIpStZb1T7B?=
 =?us-ascii?Q?Wun8LuLFZBZo7LxTuaSneUgAprHr5FZBtOYgDnid2+ScoHd37it6ZILhkj0j?=
 =?us-ascii?Q?JtcUYkArNuyeCDhtuGxDUfx+5gMhOorMdOdXgcgCH7kH7q+Y4UlrcJ+xNQjo?=
 =?us-ascii?Q?+lXO9UmAI1eouL5h9iVpZsx/bln8I5QJE3dpavkUaSoO6fWpcFM7hG2C8Wdd?=
 =?us-ascii?Q?7SjOT3qex+PjUQftRFEq1wZ2m4WvlCZNnE+8gvGY0lfE2lsMCSDFa770KWWf?=
 =?us-ascii?Q?1bjHqvgwBaLQuYINr9M+QmVu7wFDQ2g1tAIbPauh7EinCtxz4CG6UViqBkiA?=
 =?us-ascii?Q?Xc50Cc0vHN/ZnIa3alyzreF0AMDPrG5eh53YTkkxb6UCsnXOgw2/YTG0kXkw?=
 =?us-ascii?Q?ofXAAis+ERQuc2YNVkMeC10END9dpkuR7HLDPfo3vQNbq+WDWrOOFadc2prr?=
 =?us-ascii?Q?Y0ARWFILsIbPd/FjR2W3TQVHWz+UXHhoXhMfpo8Y+qUtOD07h0dMCUv/ke7K?=
 =?us-ascii?Q?Z1frBqpmm9jfNsou1DZ40WiO96h4LIcTzGmBHTOw+UAFhJNH4zP9q8jcwcvv?=
 =?us-ascii?Q?XHqyPSz5FHBLs4cFPP2zTZiLNQMe3YU1y773XJMdMVJQMKckLB4tsuR5zwBJ?=
 =?us-ascii?Q?CgAKhugDwY+zOTCo8cb63NbPUuDnlmxF6+ARoGaDCgw/CSE2xFDSrndHFq4S?=
 =?us-ascii?Q?4gCCr7H/3DPnlA52G2UwWbTynIKuJBeAli9EQ+nP+U2+XRxRAKt4wPxcbFlN?=
 =?us-ascii?Q?CjYFWJBizOv03o056LKAGNSi6LYFMsX14aYkFrFipr4l5aW9WmytlNeMwAJp?=
 =?us-ascii?Q?MdvZUHEZEDTyvcuNfBha2+RhNZ3aOqQ=3D?=
X-Exchange-RoutingPolicyChecked: 2WmpcK4yqzFV6TBpmnQbOXKVxtoK0fkUzwyLooQFV1pKQ1uI5OaiakeuLv7ylSTomkocYIQ9HmNGmEk9unZRZJIktChDf9Tl5PbuUku/2GRAaBxEz8JJqGI/ZFnF49pZ23kh08ZdPx/9q44oSlC8y39OyyRkRjbr0ytnyc/ftrbaHBZYUtPoK8GaFU7rUufIM9LMPP/+/bD2vK6qFJuMrdBvpNcfSi3rWMscAu0yC+9hWM/1H+pkKefS1W8HfO4V0Ygp0Mv2u5CPNN34EfVlPXEy/3m35Je3AHMa6ur8CzB2DIUH6wMTJLHM5qACBNQgi16lQnjDiZ3t0N9usXLhZA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f06b720-04e4-472d-6e00-08df17d48a75
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:36:13.5935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwsVW4dCO3eEkYUlsV1XRncwQdHYzVIB0ZNg6fseBhSHoMlX8OcrS97QURT2f/y5B5DyQ/y73x7qIiY8YaP4JJCw5StkCZAI8r4xj8BNTP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9416
X-Authority-Analysis: v=2.4 cv=KInPn1Fo c=1 sm=1 tr=0 ts=6ab116ae cx=c_pps
 a=LXaTTIJxFZ+1d5Pv2w7KFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=5qpsIK_AQi6EPHI5KBEA:9
X-Proofpoint-ORIG-GUID: sUAIQ6KjZzUke3oqAqlYTcaGSPcagMLy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX63P6+ApfwOUI
 tMpWNNJIMvNG6v89lZI9mkcMKFEEFceepMXqJOLICPPR3bPF6freJ0dOe7uy+uD5Y1Ps89V3JWp
 h5sJan9vpIRwjAVEs6C4cP+MmQoaWUo=
X-Proofpoint-GUID: sUAIQ6KjZzUke3oqAqlYTcaGSPcagMLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX9nhmGvr2b4Gc
 qVRDmV9baXwwrVem5/4xFc9T77d7dlDnTJfDi/SL8+z1qZ4EKmd+W9sFGzJK9Nw7OWdq28MPKwI
 PyGNUpUbeoKtbVGNmdUFtJpW1dF8H1CB7OkT7bBT7blBsTNym/uwHdQtkdJtujwUQViRYcQjBpZ
 6rQq4KPHtqbWUV43EeRkgMYJB6qRiG9FrtduP+Bz+Izglxlemtlpqmn0Oj2UThowHvf40w7hcKM
 Y2/XOX1i6zD6jGIZ898RD+BhMJddkgIDXNui0YB/jr7zbZWxqD8u7XkAhdKDLzO3fe30pZ6xPeu
 mg/JjM8WxtNxFlEIaPsLX0NW48NdJB8v4+466shH+QMNXnsr5OmAkmeQRKmjGnNOGgL1zgBp7WI
 NTeA/HeJOeUjcss+MQjKsX+aThfwjaTCsUMdifb11uv6IGIq8SIDbuSHzoQq9BhBTBYSLgcxqAV
 NYzxeybuP3odFR4XdqA==
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

This is eventually intended to be a replacement for object_property_add_alias()
which uses an object property instead of a class property.

With the advent of class properties, it is possible that QOM may attempt to
set or retrieve the value of an unset alias property. Update the existing
property_get_alias() function to use the null visitor if the alias target has
not been set, property_set_alias() to return an error, and
property_resolve_alias() to return NULL for the same case.

This ensures that unset class alias properties accessed e.g. via the monitor do
not cause QEMU to crash.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 25 ++++++++++++
 qom/object.c         | 97 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 110 insertions(+), 12 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 3285218664..73d72619b8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2279,6 +2279,11 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                           const uint64_t *v,
                                           ObjectPropertyFlags flags);
 
+typedef enum {
+    /* private */
+    OBJ_PROP_ALIAS_CLASS = 0x1,
+} ObjectPropertyAliasFlags;
+
 /**
  * object_property_add_alias:
  * @obj: the object to add a property to
@@ -2299,6 +2304,26 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
 ObjectProperty *object_property_add_alias(Object *obj, const char *name,
                                Object *target_obj, const char *target_name);
 
+/**
+ * object_class_property_add_alias:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the object alias is
+ *   stored
+ * @target_type: QOM type we expect the alias to resolve to
+ * @target_name: the name of the property on the forwarded object
+ *
+ * Add an alias for a property on an object.  This function will add a property
+ * of the same type as the forwarded property.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_class_property_add_alias(ObjectClass *klass, const char *name,
+                                ptrdiff_t offset,
+                                const char *target_type,
+                                const char *target_name);
+
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index eb5f74fc74..e4e8dc6886 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -35,6 +35,7 @@
 #include "qom/qom-qobject.h"
 #include "qobject/qbool.h"
 #include "qobject/qlist.h"
+#include "qobject/qnull.h"
 #include "qobject/qnum.h"
 #include "qobject/qstring.h"
 #include "qemu/error-report.h"
@@ -3052,14 +3053,22 @@ object_class_static_property_add_uint64_ptr(ObjectClass *klass,
 }
 
 typedef struct {
-    Object *target_obj;
+    union {
+        Object *target_obj; /* if !OBJ_PROP_ALIAS_CLASS */
+        ptrdiff_t offset;   /* if OBJ_PROP_ALIAS_CLASS */
+    };
     char *target_name;
+    ObjectPropertyAliasFlags flags;
 } AliasProperty;
 
 static Object **
-object_alias_get_targetp(Object *obj, AliasProperty *lprop)
+object_alias_get_targetp(Object *obj, AliasProperty *aprop)
 {
-    return &lprop->target_obj;
+    if (aprop->flags & OBJ_PROP_ALIAS_CLASS) {
+        return (void *)obj + aprop->offset;
+    } else {
+        return &aprop->target_obj;
+    }
 }
 
 static void property_get_alias(Object *obj, Visitor *v, const char *name,
@@ -3067,10 +3076,18 @@ static void property_get_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
-    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_get(*target_obj, prop->target_name, alias_v, errp);
-    visit_free(alias_v);
+    if (*target_obj) {
+        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
+
+        object_property_get(*target_obj, prop->target_name, alias_v, errp);
+        visit_free(alias_v);
+    } else {
+        QNull *null = NULL;
+
+        visit_type_null(v, NULL, &null, errp);
+        qnull_unref(null);
+    }
 }
 
 static void property_set_alias(Object *obj, Visitor *v, const char *name,
@@ -3078,10 +3095,15 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
-    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_set(*target_obj, prop->target_name, alias_v, errp);
-    visit_free(alias_v);
+    if (*target_obj) {
+        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
+
+        object_property_set(*target_obj, prop->target_name, alias_v, errp);
+        visit_free(alias_v);
+    } else {
+        error_setg(errp, "unable to resolve alias property target");
+    }
 }
 
 static Object *property_resolve_alias(Object *obj, void *opaque,
@@ -3090,15 +3112,21 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
 
-    return object_resolve_path_component(*target_obj, prop->target_name);
+    if (*target_obj) {
+        return object_resolve_path_component(*target_obj, prop->target_name);
+    } else {
+        return NULL;
+    }
 }
 
 static void property_release_alias(Object *obj, const char *name, void *opaque)
 {
     AliasProperty *prop = opaque;
 
-    g_free(prop->target_name);
-    g_free(prop);
+    if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
+        g_free(prop->target_name);
+        g_free(prop);
+    }
 }
 
 ObjectProperty *
@@ -3123,6 +3151,7 @@ object_property_add_alias(Object *obj, const char *name,
     prop = g_malloc(sizeof(*prop));
     prop->target_obj = target_obj;
     prop->target_name = g_strdup(target_name);
+    prop->flags = 0;
 
     op = object_property_add(obj, name, prop_type,
                              property_get_alias,
@@ -3139,6 +3168,50 @@ object_property_add_alias(Object *obj, const char *name,
     return op;
 }
 
+ObjectProperty *
+object_class_property_add_alias(ObjectClass *klass, const char *name,
+                                ptrdiff_t offset,
+                                const char *target_type,
+                                const char *target_name)
+{
+    AliasProperty *prop;
+    ObjectProperty *op;
+    ObjectProperty *target_prop;
+    ObjectClass *target_class;
+    g_autofree char *prop_type = NULL;
+
+    target_class = object_class_by_name(target_type);
+    assert(target_class);
+    target_prop = object_class_property_find(target_class, target_name);
+    assert(target_prop);
+
+    if (object_property_is_child(target_prop)) {
+        prop_type = g_strdup_printf("link%s",
+                                    target_prop->type + strlen("child"));
+    } else {
+        prop_type = g_strdup(target_prop->type);
+    }
+
+    prop = g_malloc(sizeof(*prop));
+    prop->offset = offset;
+    prop->target_name = g_strdup(target_name);
+    prop->flags = OBJ_PROP_ALIAS_CLASS;
+
+    op = object_class_property_add(klass, name, prop_type,
+                                   property_get_alias,
+                                   property_set_alias,
+                                   property_release_alias,
+                                   prop);
+    op->resolve = property_resolve_alias;
+    if (target_prop->defval) {
+        op->defval = qobject_ref(target_prop->defval);
+    }
+
+    object_class_property_set_description(klass, op->name,
+                                          target_prop->description);
+    return op;
+}
+
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description)
 {
-- 
2.43.0


