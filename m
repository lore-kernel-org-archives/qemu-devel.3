Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BF2CD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVQ9o-00068c-Pf; Fri, 05 Jun 2026 04:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wVQ9m-00066C-DT; Fri, 05 Jun 2026 04:43:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wVQ9j-0002Zd-T0; Fri, 05 Jun 2026 04:43:58 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6556MRUJ1185382; Fri, 5 Jun 2026 01:43:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qpu/vUW5/4oKbS+N83wUCZeagPINvNsKs3mGdcVvk
 X8=; b=q2V4zHRvPStju8Jn272tgJF7BVvp/qzj0QcEHN6dL36gvSEddxnum5PBp
 eTFp4ekJD7S+pc8/+nGs3YxFaUHnMg+jlsB/RqihLy5PH6/gpi1JamK3c8hmIf69
 BkriNiJ1cdMaS+UfrDWGTj/ovO/8wVDIoyIgaIUEeEYU4Hum0PRPSM2Pqc9v6uLK
 BqFxArUCbpl+g97r27JuHDJx3uVjXShaC4ITcrE4W0hjot2o/gr8k6oJADaVFT2p
 9qB5LNnQxh4y+4Mfph2bZkagTTdxPvgvHdj8vNomPBpPlTK4+DIRkN3bIhwPSISj
 Mn5SfJCOtFXX8VlAc/W1/KF9XSV3Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020134.outbound.protection.outlook.com [52.101.201.134])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ejuupcm1f-5
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 01:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIdUC/Ca6VtHBpobV5ne7kqZ9mgU+qIjoMK1+6uCUWNxkfM/+ueaecONbBqLHM5ydh4CUgLJgWBaw3l4KPZ/fipA/NvIZUnlWv7DS6m0voh5q9dQGG/3t5tG95Sv8K3qO4LnIunIT1zkB78Au7N3jS1oAQxtUXct4DjnpObe4+8UOt1PNMiCX8aT/gRbbzo6AitAXM4aMcA/Oc367D5rhZK2AJba3/0c15/7BsOgmsbX6yvsdkfAVObopCYHQJ8pjoxOhkQ3i03ijA2gJULhY0veax+5OLW/UMxgSlycR1z3JT0bOuY/vkcr5LVNkZbjft2JkwKq1pesv9XOJbGsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpu/vUW5/4oKbS+N83wUCZeagPINvNsKs3mGdcVvkX8=;
 b=kelHyYF7lhEUX8bjNcHLzeK9KOiWA0EoEvD1ucjIx54Sw5svZ/jJmwO7p/OprJuPYLb1B6lR1ANKuedQnmYZvisAJcvCYum+Vb0q3pf0+8CcW9+8d5zRJjpW27T7iLQnbErRSLXZOWqsi8r+jvG1RkwYgyXIrWeKeUYAAE5POFNCjPaX05cbKam3MYcxkmN9PQyASmyiP69pe4w1WT0u9DrkaWMCItQIEcDiLoMWixA9o0HjlEaSr+qFQbaB9bGBP+mHIf+Xui2E7Kh+SROb4EerZwNQ0TvUokcVLK+H6PBMLJ0iSgDi1uWjVsnS/rs+o8QtQwFjxxh1ilvwjJN9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpu/vUW5/4oKbS+N83wUCZeagPINvNsKs3mGdcVvkX8=;
 b=goAwPlRfx70SIFmc6kWsHZfq6QSGA1QNthbsJxNoOsT8WsSQm43iGFYcQjmKPE0l0iStU6bS0OBsDPBNnnoX2MkYAd6x0UyDk7xGcRM6ZpjfzQ4un0N+aqDlt7OSjlzjqyrlqmTM3ezglSI7+N+x1Ek+ADSF0p2NpsJHs2a7xsdfp2BbQ04I4YuwEP7szB7VQjkBTEg8cuI80axQFbg6OfEWuEFzasXHT5Pkto4Rgfy7oxLFocG6yoGO4MFb6MetiVuEauBrlrDVjBWDx1Tz2aIKuURzISZN5Fcu3B2/JaPNHLtITeFY5pOb/44qhAJU2ALHOX5mrBDNAJwRRAKxzQ==
Received: from PH0PR02MB7557.namprd02.prod.outlook.com (2603:10b6:510:54::17)
 by MN6PR02MB10630.namprd02.prod.outlook.com (2603:10b6:208:4f4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 08:43:18 +0000
Received: from PH0PR02MB7557.namprd02.prod.outlook.com
 ([fe80::4917:bc05:4373:6bef]) by PH0PR02MB7557.namprd02.prod.outlook.com
 ([fe80::4917:bc05:4373:6bef%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:43:18 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 Eric Auger <eric.auger@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Sebastian Ott <sebott@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jinqian Yang <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Khushit Shah <khushit.shah@nutanix.com>
Subject: [RFC PATCH v2 22/29] target/arm/kvm: introduce kvm_arm_get_host_isar
 helper
Date: Fri,  5 Jun 2026 08:33:51 +0000
Message-ID: <20260605083358.1320563-23-khushit.shah@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605083358.1320563-1-khushit.shah@nutanix.com>
References: <20260605083358.1320563-1-khushit.shah@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:510:324::18) To PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7557:EE_|MN6PR02MB10630:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb77708-2cc1-41b2-46f7-08dec2de7d1c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DCD7o9r4ybfNxonHwJMVfXBULXpPrncOhjSARibbslu8DbadRmh/n4GNLSm/re676w95xa2MUBTLiLQkifmmzYTPcr1xug04CgE1ssIN40TgmMR9Q2EvMk9zCt3seZui1rDAG0LPLwtyFiIfsWYf9l6aFvHZd3QrdVm9AyNo+Rw5Yz0rLSaVUAR+YLO5lnz0uTieMY1uGuXeXt+jRO2WQC0dSBG0kHV3/c00OlIRaFnzdSjRnkJ5xf2jXgRbCbGaRnQ+eBDXdmx2mM+7MYznRTrIM8Blz7JTFip1maA+7XQkMnrW5AjCIYHMq+f+nVmDDAwVuf1Z+A+HMWTEMtjWNplW5UsJmWvP1fwPCZ2LcSpPMf6ZWrPLEhw1HB9sR0A1wYAczKj2FP+p8z+/LEG7oFel1daxdYTiUuvfxfiRoJkJmyPwka99m1j5/qa3A3NJdzP3cKmjKTbkpzyMZJv5xIoTu6urXKSUaqvZoqGLrP87N9btXITHQHgiSt1xWObCU6UrcLf175Ce7OCeb4gtWTYwEiCzV0Duydii6IOQjvKqaDJGSutQrPnRb6COzSVCrrl2CIDt8cNJXJswpisbBDU8NmVf32BJ1EAaU6Z67OZyy3YiWuZlTE4qrDtSmM0hSaMQKqEz6RzZ/EIKp7AFIqzripIqXwufWYd9jbn+Sz/M8UbCGOUEOaWsxb3ckal3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7557.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WevtszweUWG0HMzF3bmQRjTYvrBqQ7xNaMH17hbuZWucBS+3fZ8m7ayDNmtI?=
 =?us-ascii?Q?J+Ui9aEltnUesFNMMAId19F4YS5pDDfPnROJ0aOgWG6uIOJ0h+DVrQj04h41?=
 =?us-ascii?Q?U363wJH5B1WL+Lzv8NT52cgQXm19DoLXgoen7uC8zEdPXB2DHXTJ/z3t2VRI?=
 =?us-ascii?Q?zZDGJollYBGQwkoD1Xu8x9DV36JxwGpNBtPnY6knXy/JEN+hTPqrkgYHMBjy?=
 =?us-ascii?Q?MSyuBVJ5jwNhd8cL80M8ymdyKpsuE5SN3b06srbD+FuhDG5Hmu7vadfSnrPb?=
 =?us-ascii?Q?maMVv+iEkTnq1jfzid120nSkJBBBVNeOIwxI8YQnJ0V9jdHigouAKeoRhoUu?=
 =?us-ascii?Q?su9PUUTNI9qJQEEMGTquAxHyyCb8gPXCz/wZ4iP3mHZJknIDtEmwi2T5uCyv?=
 =?us-ascii?Q?RJUfrTNcB/vlxYd8Tio0gRSABcCAjhO7wgueOe5uhbykEGjMKpP88c/+hCbI?=
 =?us-ascii?Q?tjs1hnOEqgyyWop1b1QxrEh95tQQGb+7006FHz/TXBsp0PXRwPgPbpUjh97i?=
 =?us-ascii?Q?KJVP09gQf0mYdEgH+X0kfRctqc2ZLnSEcw6Rcxyuxw6KKFQ3EbXAIILzzOPZ?=
 =?us-ascii?Q?rUWmHG2/e6Rlt0eXW5jnwjBQX8EvziIU0TR23a8H1nhl+YCp9560jlM0bzIX?=
 =?us-ascii?Q?DsaqfUndAoj1M55KiAWE8vYlcMDsISk37NbHD8boM+0NDYE4T7u2EyDCrpLW?=
 =?us-ascii?Q?sFBwDse/hTLhd4zLqrGZHYU4ElA3eNB3jPci1RAa666qoSSs8aC9adJe/vBd?=
 =?us-ascii?Q?/99BIZxMelBUaq3pxm6upySlzznZ4kP/ymV2pj/cR+6NNbXOeMmpEBfNo6Sn?=
 =?us-ascii?Q?mLtHyQxHDU9TVB1zqKEKnNwHJL2CjddV0+OeGiVc7LMc2iD9YbARoh9qWPOV?=
 =?us-ascii?Q?UpW7hKQdn9V8F+AC7eSRUwOKQKHvSIDGzjPpmMzN/j+ZXO1495n5uz3oRfSo?=
 =?us-ascii?Q?zrnfthXrSuH1Yp2mbmmZdS9spUvI3chHq0SU1kriygMXV4EPtjXJD+q/1nQt?=
 =?us-ascii?Q?dzS5cGedWP7QH+VikQR6ILi++3BsADRfes/sXLGdN1ufjMpdeIEfS9PkuBhy?=
 =?us-ascii?Q?/rBUa6iuDqujIC/fef0K+ydMkgZWEyYBcbKluNdrO12Zz7Ofwj8tPyEBKN96?=
 =?us-ascii?Q?MCgmLYa5vu5NU7KZVtaumSduH7wBrK4ZOe5E0OXzopdgthupRqBAyGG64dRN?=
 =?us-ascii?Q?6S0VyQd4uRdeTZI/3WqVypZlbfpLfhg4LcYmRowz49rCNE/LNVQl936/q+3s?=
 =?us-ascii?Q?+/5b8KG07MPNKA9gbL7Mt4dSaAJbysHYdO7CCMHbcHK0cddWT1fVvi/vAKp5?=
 =?us-ascii?Q?32JrTqURdTBfmSpuo7XgibsbmqsvQA1vBmRh23KC1EAweSxcPw4Wiy2JI+1Z?=
 =?us-ascii?Q?hQ8oCSUwdyZylOKPzZzqOTb9ouQEzXgMpg9YaqD8MHxF/KgLad3qy1MpK077?=
 =?us-ascii?Q?C1MQaSbRneFG0KyFhHTHN+adRVx87hR8rbZRV6ndxQ+uO7nY9Cwbeoe39OxL?=
 =?us-ascii?Q?iJ+oBRfJZwDwb+6Tg4LKKf6ONn2sXD2tlR6LiqHPyTBGh+/FMz11jS4wP+Ww?=
 =?us-ascii?Q?T/cbcNdzZ/VudAS1Y2wKUtLaPHsWJzjZieIqh5klW1TCO+bii75sZKlB1grP?=
 =?us-ascii?Q?rl3a9UGJ6dkVnsUmZw9WF1MMpmxaAS3IUCDOx/NyLuNrqEJHzgS4347rjd8D?=
 =?us-ascii?Q?ERNeXK0lzCp7DeM9VixbrVYyZpXrNV0mNAXsosMegm9D3bCN8T/UYR7qETWe?=
 =?us-ascii?Q?uWE2xsHMkOqavgrrrtmj64rVOb835Yo=3D?=
X-Exchange-RoutingPolicyChecked: huSbS/rPk8bbsXEwS1wP0S0gYCqPHwqbfV87BrJAI8vPZ23iWNJJduj26zJvjc5vQ6TQvkR9gKGl1wo+ByCEGiIlMHiwpQfMKSvJpEFmO8nJ8GvhDS2jM6xYym6UarsMWGNcQLxUKTpQJ5g440V3hkz7KNlNSxJnMPLWTWxWGJgdEV/j3/cYvQAm/X3qpvOUBgf/Lg7LDSTdu2V5owuJMBer/7goXagL/A6AtOE7m/1Tv2kBfRWEr00PTFRwiKiXT+CGut+qjAvki9QDPywqhkSCSs5JBxBp0hUhnfBwxMSgii5WmcHrRLetikEPTmay4fOWRREQuw3F2Nq5Q/8POg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb77708-2cc1-41b2-46f7-08dec2de7d1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7557.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:43:17.2316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nn4GPQQQJNBMhqmjRgkKzqPw8RO0sMtookCwHuzadw3BE7cX2ExkkPzEvfVhODAcdJhsazaztZNKk4e3CbaiKYFGSKCL++CB1qEWOenfuJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10630
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA4MyBTYWx0ZWRfX198V/7XFeZvn
 N3Qew29w9ZoMXsNuCIoTjzgi6a0bGIcM0Ktr8g6cB70BBI/XxCldfRiTzRasq//Jj3H1s1BAZnJ
 GPUwPSwDFXt6yQ9UEkdkE2ixojF/SZd8dHyyJjoAHuOuXxDwuJa/tjw9LhGefSGGUHrj/gbahyP
 CL+7e6tyvf79DlI9WVwg7WQGhKBwx3ggisV4l7j8MlVNExzqaYCRlUhBchkTYBPKZnYnsqGg46C
 r+QNl5acU9N5ogNKHthv+EGUS0jxlsMdHgsJm+JTll4NmSFF7MbzD2JY4Vvrm17Evv2GEMev9C0
 qqdW3OO2B43BRcZvU9h/B64gqzlXQ4LAqr/aVQXx2ZM81amRTS+hCV6yqefwAApjfU9HV4WR2Xy
 dW34NDeMKW8yVTInbev6KTqp1MysoXfPKx2XtWr8iSquBqoVNrjb/qp27TYSyOzmEx0JZ3AnvJm
 xMGu/cegLcdObSxsOAQ==
X-Proofpoint-ORIG-GUID: 5fvd1mFnOsv1ISoZ7jG2_o-99vo2pce6
X-Authority-Analysis: v=2.4 cv=V6FNF+ni c=1 sm=1 tr=0 ts=6a228c2b cx=c_pps
 a=h3Jk+6XEKCuoUZR+ZnWw9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=vS_ObyiCXZHXlSlc3J4A:9
X-Proofpoint-GUID: 5fvd1mFnOsv1ISoZ7jG2_o-99vo2pce6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=khushit.shah@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Introduce kvm_arm_get_host_isar() to provide scratch vCPU probed host
isar. Will be used in future commits.

Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
---
 target/arm/kvm-stub.c | 5 +++++
 target/arm/kvm.c      | 5 +++++
 target/arm/kvm_arm.h  | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88cbe8d85c..dd683beaaf 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
 {
     g_assert_not_reached();
 }
+
+const ARMISARegisters *kvm_arm_get_host_isar(void)
+{
+    return NULL;
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index cf6087d337..b4544f3514 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -597,6 +597,11 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     env->features = arm_host_cpu_features.features;
 }
 
+const ARMISARegisters *kvm_arm_get_host_isar(void)
+{
+    return &arm_host_cpu_features.isar;
+}
+
 static bool kvm_no_adjvtime_get(Object *obj, Error **errp)
 {
     return !ARM_CPU(obj)->kvm_adjvtime;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c40fb003..750dbe1ef4 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -15,6 +15,8 @@
 #include "system/kvm.h"
 #include "target/arm/cpu-qom.h"
 
+typedef struct ARMISARegisters ARMISARegisters;
+
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
@@ -229,6 +231,8 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
 void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
 
+const ARMISARegisters *kvm_arm_get_host_isar(void);
+
 void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
 
 /*
-- 
2.52.0


