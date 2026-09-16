Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27899C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6m8G-00048y-CY; Wed, 16 Sep 2026 05:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x6m8E-00048j-9Q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:40:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x6m8B-0002ya-Me
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:40:45 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8F814639335; Wed, 16 Sep 2026 02:40:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=C3R0HmbVs3pK3jZDnQ7d6OM6Tcs6tqbzN+s5ja2MK
 II=; b=MYBq+lQTQHvXEPSRNWjJrMmk84Xu1hbPBxiMcbi9laIcxvH5zbLZOiWiV
 uTu57HCicIQmFbxjv9r4DX6EUOgp7ZujGeydZUXl2HnW64RnNSt7XW4Kv3R35s5L
 5h5lXfL4g3PrWb2fD7cprdKmIKPeoE9M80GXcQTjo/96YJZUZ+LNGg0NVL4HODMG
 E7yANs/OdX/SU6M8qLxQVQwou3mLBcOgf+oAm0G7ae7LUmfz9SguSGDZQB2gx17X
 +DsmZvaNHuxw0q79POS5Ot5cTEJ9SuAccTWNPn59/OuHvfnmF5dCyfP7sdT90hzY
 dHW0Jva75FoSm2zgI4TXsu/+shlWQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023126.outbound.protection.outlook.com
 [40.107.201.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqbx0styc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 02:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL0WlTFNRILt6GdpJHIwX4qlLng+Jp8/3pQxwgUa4BGOvkztQRoFPfw7PypCzYnt9J/6cGZ6F0Doh0v56e+oeuHlICgmI1sdi9BrwhUkATZ0+aAaRPWkNf5JovZ72RuZSTIV74YqhdsxJAQAHY0SaXCXZT5xh0W+MpZQ0VksQI2meUswscue/h55axXWC/Sxqn9DYV67hg9ARWuOV/QoLNgQViajiCJd3zqAnKvpmR2j5aN+rWRSfZcavdxWFrpRCuICdLrJ/JS4QpVdqZWhqA5enE71POerbNG6qaxV4ID3piqMgGMtw+pywQ3ZzeHxdnUPHRd91iKciS5O5xgYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3R0HmbVs3pK3jZDnQ7d6OM6Tcs6tqbzN+s5ja2MKII=;
 b=FSoVV+SE+3op2Ij39P3UeNmhV9Etn/Si+VAODqrrFDKMsxKmOYQCRp73VRQDPRvGLB12Kcg2DEeF3snOLotsfQUmtFZ/VOQ8NEeDjeGdrFTSIHegbENrRt96mhy3pBlrt39qC0VzVn17+H9wyDCnoz9R5fDh6tzK9zi8PV4Z3178BMZDCUK7HlHdBNrNbadzYFJvQDdJNS+z84+1+gFuVvG4rVb1UKBxcmMeACTkhFcfaHs2r3xr6o4z4O6cXecXpy3HABAW5pQpX43fGcvrzzIvCCvrDd57chPiI3HLbPQ/XMAwT09RosJ6GC+jn5CC3oNBs3dnGWNA0gEvhIehWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3R0HmbVs3pK3jZDnQ7d6OM6Tcs6tqbzN+s5ja2MKII=;
 b=LORpKnk5UtnTZyIOvQGbgoW05KL9GoyKZ/RtlkdEIPJ36BXaYxzaw7aXdqRjH1loJkjzv5mtU1Aay2FHn9+CNO+mFpmaNUHobQNTzdJjj8f1RYQ1vipL/y673YOJocsQVsuvJKSCNSzRKD6KWLwHlA0sxUwtoewaRa9cJPTBoCMyKWC7cMdFiCBewyHOJQ91pI3zP1sp+WrY0uJLY/Fs9pXtclRTIImXk5A8H/kZGVLy05TtleS+oFczvjG1FmGXO0Yu1l3o32aiCMVyxz613Uzyc17AGi6boMWqG5p0UJBesuQBwbbC/XjMm0CGvQg+EAeK+A2dKsffulAg4lBnxw==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by CH8PR02MB10898.namprd02.prod.outlook.com (2603:10b6:610:2c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 09:40:36 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 09:40:36 +0000
Message-ID: <8f0c58f0-3a22-4a66-9100-41e8accbf338@nutanix.com>
Date: Wed, 16 Sep 2026 10:40:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/pci-bridge: Add x-speed and x-width properties to
 xio3130 ports
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260915072507.1230187-1-clg@redhat.com>
 <20260915060015-mutt-send-email-mst@kernel.org>
 <81c899d9-a9fb-4eb2-ad85-7dde2f626646@nutanix.com>
 <20260915102221-mutt-send-email-mst@kernel.org>
 <1ef3b146-88b6-4c34-96f1-a272cf9b52d9@redhat.com>
 <20260915121404-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
From: David Vrabel <david.vrabel@nutanix.com>
In-Reply-To: <20260915121404-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To SA1PR02MB8368.namprd02.prod.outlook.com
 (2603:10b6:806:1f3::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR02MB8368:EE_|CH8PR02MB10898:EE_
X-MS-Office365-Filtering-Correlation-Id: 9199de00-e295-484a-eee8-08df13d68f8b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: UOCM+aeFkwCZO3U0HUHfEZ3HjONrblyrlVxKw+Ntc0MKEXYZnLvO28xIDtIZ2xL/o9zbbpdAoYpzA3hzYPZ+pm94U0krxH8vW8Q0Wvc98gXrTyQZROR13thTAv3lpQQASHB3Jaoe1iGSfuOqpiwAPtcl88td9G4C+zTLnfPs1P0TyyTKhWY+g4CYTAfBCHAZWb0MzZ/Q3BN/QkIoiLhnc/zkQSEQS4xKzndH5/uzQW5Z2wsjt81ofyiB0UiPv3+RngkrsCRVho9Agn7Ky9Wg3H1MJvqyOpaUtGoSJwlt/oHL768SBo8jgMbiqYxNF0JekvbFdA+UAMnET0sgdKU1D4DkcOJwzwk7iXF1gzeBGAaYie2ql+SVLQsTmC2OdcNRqgatDz3Owxkmcb8BASYQ1RKyNJksnO6fTLZg1gAklzjF/HvHCurNI834/x0eYD4PZDJChKSdtY280rswEXvmZJ2WxKWFGvltcAwXsljSX1FRGj7ZSyItqjlF6pB7zzowXzYAgHMFu8OVemMyq+VHwc/Qsmf85z48xlV0Wy9iRwBzVPa3o7aL1ZQXoYUd51G96Gqs5QMB1TyjflK9zmC7lTO1wVXdlWOyaaUvD3sna2HSuvDiqDGSle/AHyuWFo4Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEdndEl0THQrQVRjODVNUWRVd3pBRHowd05Pcnk5ZVFEL2phaVR5OHpWSHVv?=
 =?utf-8?B?L2V2OCtmcXoxRUR5STFleTRPeWo2SWVyOU1Zbi80SWVGS1NiTi9yNVRiOTUw?=
 =?utf-8?B?TmV2Z2JxbFNJRlR2MDBpVWJRUFVNRkwzZU1FZVFJZ1BiM0IrVFJZOEppQWpU?=
 =?utf-8?B?b2NRQ3hmWVlEQ3hkZzJSNjBicWg4MFlVS3puY3FOV1BiamdMOTJ3NnBBTTky?=
 =?utf-8?B?aThQa1l3N1BwYTNyYi9ndXBLa3c1TmMwODJtVHFMMDFlenVqTDlrUk5rS1Rt?=
 =?utf-8?B?N01qdnp1QW1WNUlWYnNhRFRRR1V0NWJsK0NIM3grK1FmbklRaWZHMkJXWGh0?=
 =?utf-8?B?eE5EUGkwZm5sOGkwYnNNZFZUdTlPZ0djMDhxcWVLT1YzNUFtTGRYWWFjbHBB?=
 =?utf-8?B?d1EwbHdoTndpRGx0cDdaOUszK0VIT2V0RXk3WXVPS08xZ1ZHMTh5LzdtZzJV?=
 =?utf-8?B?dnBLbGs4WXJ5NjFYS2VpS0V5elYxRVFZeVIySWltRnFaaWVud0I4bjJ6WGtl?=
 =?utf-8?B?ZExpdUtKZmRzUnUxR2dFRWdIbXJxcjkvTVZET2Y1TGtWTHNndm1tc3U0Sits?=
 =?utf-8?B?VjlmdndyeS9XRmgwL0dTbHZQell1Qm83UzU1OTQ2QmpmcGpaaHJsTEFVY2N4?=
 =?utf-8?B?YVZTdmVqd244aW5rM1M0Y2FHeXM1NkNCM1Qra25kakVVcjFCWFIxcnJxeDhh?=
 =?utf-8?B?Z3JmOFd1QWg0SHVHMi9LSEdndlF4WmN1S25HbHZGdUtrRzBLWGcwVlRHV1Q4?=
 =?utf-8?B?dExMRVY1Zm9VUC83Z3ZUWlErNnA1WkdpeTFNVkhyNktGQ1BRWkpwcnhDSlpH?=
 =?utf-8?B?NnV3cjg3SVlzQ0MzYkNKelVjcGFzOXRsVHJvcmZXWlBlVFNiT3Nyb2xpOFdw?=
 =?utf-8?B?VGFQODdyaWFMc1dQeDF1dzJZbVZmdHk3SHRoV09TTHZMaWd0aHlPWFNIb0p0?=
 =?utf-8?B?VmNaNlQ3ZCtLYUpkRXZ2amRudjhWMVpHUDVYc3loR1prTHdzOXZiT1EwU2RK?=
 =?utf-8?B?bE5ZeERDYzIxODRjeXpqd3M2enlLcXlBd090cVIyZndjQUNrbkRrZ2R0ajZz?=
 =?utf-8?B?Umd0cTBDTmUwYzFlWTBoM0h5OWRaY0N2ZXc5c2V1TE9WMmNzMlJBSExPMU12?=
 =?utf-8?B?N0N6WWdpeW1iT1h3dDMvdWNoVVdjQWg0dks0QVlFcGVzTXR4SVlIQ2JEZ1Zr?=
 =?utf-8?B?eTU3azc4S1dMazdpdm5kZlcwayttTE5MSmNxcTJwUU1LbjdVT2JHOXNQeFRy?=
 =?utf-8?B?V0tibUFmdWV5OHVrbGFZclBkZkRWZm94NFl2bXBQZFlqNE02VzZ6QURHVnZ0?=
 =?utf-8?B?OERKMjIzZFJHKzZHdTFOcVFnblhsL250UXlPT2JpSWtrVTkxS1hxYnAwTGFn?=
 =?utf-8?B?Q25qZmd4TGt2bmZzUFRuOVJ3cVZ4clF6VkZSQ3BuZzNXL3ZDMGs5SDJ1YjFN?=
 =?utf-8?B?b0tTZWZvNnFnaUR5Tms2Vy9tVGd2WTZIU2pQbmpNMThtQm82V0lrbXEzUFlr?=
 =?utf-8?B?WnB1dy9IK0RPMzhveU5FY0dyUjJxYzFXbUlQNFpZZEJKdjhOUXpYYldtYS9N?=
 =?utf-8?B?NGFMcFFQdjJtdVVTUGhNRWVhbEdDL3pzVUgxQUtXL3BZRjN2b3B1K2hPVFhN?=
 =?utf-8?B?YnQ2TVdHZHdYWVh6UzVMMWhXUWc4ZzdJMUJ3cGU5SjV3eFJvemVvdkdxZkpP?=
 =?utf-8?B?WHA5Mm1ZK0JPVGxCSkN5UFF3TTl0WFhVMS9xbUQyc1ZWWE9tYjNLcE4wRW12?=
 =?utf-8?B?S251V09KOWh3SUJJR29zSGR0d1ZjdjVZNmgxcnNCL2JablNPTjRVcm9PMS9K?=
 =?utf-8?B?ZzMrY3gxUGJRL3RRYm4xdDZYRlVWUWxKQ1lQSnV4WmhlVHg0dUp2WXA2dVRS?=
 =?utf-8?B?WnZLdmVKM2xySm5Xb3RWd0FrZXR4YmpOZHd6QjNyYWNQdUdHbU0vYnBTWnBH?=
 =?utf-8?B?dXlYN2NnOUV3MlM1Mis1aXcrRlBmakFmODBmOHErckNuby9aUElwV1MyRVJx?=
 =?utf-8?B?eFpoR0IwTHR6NFdZS3JkOUxscDl2Wi8vNnNEVnBzT1ArWEVwY1VRcW1sKzZP?=
 =?utf-8?B?cndyc0RwZkhCTjZhUTlVL1RSTU56dmtCSHRheEF6MWlOZVp5VmlJN1JxU0Q5?=
 =?utf-8?B?RWN1Q3VjTVlIK0FMQ0VmNzd6NFNkUDd6bGJJVTBScGJMZXNucjdUVHVqN1Bj?=
 =?utf-8?B?eElGalM5WkJMSjNsSDMrbi8xNHNmcDQyRmt6YlRkOE40RzR2R0xvOXlHRmFq?=
 =?utf-8?B?bnp6R1lhbDdpUzJENUwzOUZ1aVdLZ0tReDdyakRqVG5HaWpOa29yckh1LzNn?=
 =?utf-8?B?Tkx0YTI3eDF4a0ptWXdUSzJBUi9HNDA2ZW81bVBBVmZKbE1RNkhpUT09?=
X-Exchange-RoutingPolicyChecked: BglIQdALwsP1Og4mydRSiv8OZxOYaZEEY7VDJf3MqvDjv8O8mbo2cluuCEP7AWuo//pB82ZBq28fefnBM6QWgd818NLOwYIZUNszU1P60j0ObHgvEYBdkN7PushmFFDTyGoCrimN0Q5ZDl98Rq1qUASNnBDmR4Z+sIDYS83Z0eI4ZxuiDjkriHYcZGhgW0n/31wqImI2lrQUMvcmb1m2iggcOMyq2oWeFlb+JFCPGHVpXmSP7fwAas2OxHw+s4YXFHq/dyzRMCrcF+biUqZpr6SmNinfT2ldgWx2WJSCjKB6uo4+LZbrM9HNFynuEl7cEeeZzvkflhh0Z7bD3CMixg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9199de00-e295-484a-eee8-08df13d68f8b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 09:40:36.4872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BCgOwFdPs7Xu4ahi5wK2AGzTincsfQ0UV6nPTCMpcALE/QD8mXR2/urG2km0aaXH24GcxV+z0nPt8m9jrLlzC3lee6DlGcgv3AF7cE2Ihk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB10898
X-Authority-Analysis: v=2.4 cv=Xq5vqlF9 c=1 sm=1 tr=0 ts=6aaa6417 cx=c_pps
 a=F+uFsNuNoBNH7XrxSTh6Og==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=GaQpPoNlAAAA:8 a=64Cc0HZtAAAA:8 a=ldPPrBBefLSOJ2cuaHIA:9 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-ORIG-GUID: FexmQK-exKI-c-_iSp0aRAANaW7r0r_M
X-Proofpoint-GUID: FexmQK-exKI-c-_iSp0aRAANaW7r0r_M
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEyNSBTYWx0ZWRfXxXVBkAsXIeYK
 GTU9W6pgr5rPaqYdkkhnptMlgMbattviMhJlOsugPGnxWbYTDo2iX1rT9u1rvCFYB8I26PadPtx
 SCm3AiAn7Jtb6MriZqTW7BRr8aD6t04=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEyNSBTYWx0ZWRfX9te+gVxipjsp
 Rb082mkezIGXKNo2ou4WIWXrlMF6khs4YQSdkyroT3OUDA5TbyekKw18mhEpBV9QAq1a9UlulWL
 Cb//T0A2J2WOKJIeVSnVvVhzb4Ck/yEhyt+v2C6JzxXXq876ohmXAYXK9gJIX27p29oZrAQ3XMH
 CyzXp+FL2CbXY4McAFM0cPnK7nJlQ/i5cZPcYcMESmx8Op/aStoILNEvK83kt9IikjQHDtjGBqn
 0FGyUZXK7zxySdok0dSF7A9xXfzIRrsc0OLoYJMIKLPr5k6y9AxE6v4/ZmvIeaE/tVVhu8SUgi1
 IpMU54FaMP+aT1bnPltKsmaM9VdJh+MwGZ2DW0YTQoplSuu2IleYlH4oWmeutO5lI/Qe2FaMSme
 4jHd70Mpq2JD0K7NJutY3qtTH1qxfgbBKWWPVePSM1bFFdYIckSyWpdBx8uwQGhcOsW+bRdKWnK
 JSIVaqcV35e3Eopiagw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=david.vrabel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 15/09/2026 17:40, Michael S. Tsirkin wrote:
> 
> I don't know what the big deal is. new hardware is easy to add to
> libvirt. I just coded it up quickly it's like 30LOC, excluding tests.
> Pls check that option.
>

I do have a libvirt series as well.

https://patchew.org/Libvirt/20260915134615.2262856-1-david.vrabel@nutanix.com/

David


