Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940BFC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNg-0004GN-Dg; Thu, 19 Jun 2025 09:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNe-0004Ex-09
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNZ-0008EV-5k
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:37 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J7OixH013270;
 Thu, 19 Jun 2025 06:32:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uCzQmp+PBwY0Hsi3DZvIjqZzIdHgwj6eSlaUGkIYq
 mw=; b=QN3tYymxq1ql0mYIL+/BMPu/AVMtsUxlOC0Mexodxt91SX+hswxPAVYga
 /nkSSdKiDsyl0IJx6Rfpj5H930/tQEsYdm3ansOCtAdzXRVSNiyiyx4GhNl8+nEH
 ULUVEVcLuRafjpxkConDq9fuzte8oonKsiCFLekXG/awtznjw+c71bgBzH0+RpW1
 gu2iIoHDLu6HY6Gqg23pME6WGjILaO6RhjIrL9DzEzpJn0PH6kZuhfdWei2IIR/j
 63ZhihEbJUvgaulEgueZN8hFQSbl8MwjwW8r4KA84e3v0jUin0A7be6HnM9dDqNo
 SEPipjNBME1e/QfYoueAUr+DdhTfg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020091.outbound.protection.outlook.com [52.101.85.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mykwpg-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goSv09wDJxy2w7WwVg+cxdid21aPnejs6u7RHYEgMV4VZHRFcaTgmLvHvsGL+XOho6LlvJ6YHBtvMcb8Dwi2gTAEN4PB5Vwuvq4H7vaKKMd8e2ZYgqhcECGLKL4V5SepT8mbYU2Pj6BW+fmdvUqbV6acV8GE6iYMdljhq6aX1PGN7jiJuZyntEUigBIoeiBbaBtIE0EMwA0+aBoXKN2o+lccLVIe+LfnXoAsqXn9QiA3oaQhb3OcIBZJMcuMsR/lGLKFM+PquA0CLeUD2jyg0kir/yyPv7++Jd835moz9bh65T/IhAHcO5YumC9haDrAHgHRYshuPVF2/SpA2//jDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCzQmp+PBwY0Hsi3DZvIjqZzIdHgwj6eSlaUGkIYqmw=;
 b=QRdHcllydxv8OMo+1nRN67RysS1bilFa8FaC9yN7nRbBlQ5FQjZLx/cnySE0qB44ov6YNMi8wXY5kfezvwYcPOHq+kdHe3OEXihDDMZ/zCuZNWjx30HCCQTgTWIga+3R4+TW+f15ZqFNqHFI7M8jQrHlco0BwP11cMmkraxy0dWogUdS2CQIxrX+SjcBJO+hjcQ4n0Cv2D2OJjDUHb5KZjijzM+6Q1KJ0CPvS2j4i6IxPHqBMArB1xSSPU63sbq4sQvvZwJAK4go5y2Tdcmc1ZGaPZm3fHIDDFF45K+Toe4su2HuxNwkdPqymgwTAEWiwR5iYaqHU6Qs2AHmn4U1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCzQmp+PBwY0Hsi3DZvIjqZzIdHgwj6eSlaUGkIYqmw=;
 b=K7OvhBQvs7w8HjHD5FNE9j/ROrG+HZEx3IAIX5Y3lFDiqEi0nicoyBOudiQ0hS+0+h8IPoJ20RYqmoBIfWdpnS3TM0QojfZ7ayhA+MQ6KSBKjkGBIhHZ7QVABlWLe51UgM/iS2Qlvk9bDtAJh+OFopeXyRpPbPz3rjXjNNvxZo5b34K4VwKqe4SmmOKd1WzXzr7G0bzeHiJnMTkx7TmZgslriNbyXR9g395p21Qp+eHFCZV7LjbdTgbIeKbWfW4HmcGJa2lim0M5TIz/8vxl2lTNfvxCAmVuXQ5xVmezJvg1kEMDhjzSA0dvRR6qj/5q/h0hrKbovqWWvYFhspTjwA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:28 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:28 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 12/19] vfio-user: implement VFIO_USER_DEVICE_RESET
Date: Thu, 19 Jun 2025 06:31:46 -0700
Message-ID: <20250619133154.264786-13-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: b85614c3-e8fa-49e4-3883-08ddaf35bc37
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9FfZhFOTxTwquYW3Mc8zKd1h5NEvUoFRNtG4qGWygOZkVLPxd5O4u5e5cx5p?=
 =?us-ascii?Q?J0xvFGpv+TBIFvr6oixDaHyV//6X8f3wk558LSoFcvYFhC/WUUsVHa+Ai5s0?=
 =?us-ascii?Q?IxaPP4yNNcWPzOTLojpF0cx3bHzepIu9GvZwlGD9WMcv5V6cH/MBRsJTZ8ro?=
 =?us-ascii?Q?9os7oaQEyJCmcc63xQJmjX0aEeTKvYPvTHwd+Q28PNsYRIamxel6u78JTX26?=
 =?us-ascii?Q?jq9rPKxzHDXi/8MW71cw70IcEPPhcyHy4QOTUehgb/te3z2xK/XCmwiBcLLJ?=
 =?us-ascii?Q?9c25zeYe28Qz8BsHHB8IxF2AelmOpvA9iFwpDHkC/vL0kjevVjVuAXsXm7CG?=
 =?us-ascii?Q?Mcl5dmZLTqTqOyYmWMr8m6YbrGR5Hy56ZgZi8qZdY8MEG3dfDZdBbWE9JRqQ?=
 =?us-ascii?Q?ASq765qTR9jSIqAPbDbDCGldLHYFcRrpDMsQ0d5BD2Jfh/hdtvnP+KdRTn9l?=
 =?us-ascii?Q?tlcWv1thpL0o+6egjKU7CrU8iDWvq4fy+mJgSXL/PIdbXn1smgB/N6itLwuM?=
 =?us-ascii?Q?w0D5c67f3zDlZzZAuExCqopC9eqVAooFyYdStxTgc8k1j4Xj7sQTzu6lFD4X?=
 =?us-ascii?Q?HD0iVKfIMEwZpIDui6pS2wmfSrulMG/uVM9YguCyYQt48kIKnEJNvRkMYfHH?=
 =?us-ascii?Q?e6i7FV4gIGlfCTXg6HOHsCzoMMK9qtb89URFyfxHRZsP9epWG2KzK4U1SCxU?=
 =?us-ascii?Q?o+GJIvJC+UTxhfQDeDCjADNidPS9WA7En2WaxUGWXOTBAYHjeAjunzgzt09d?=
 =?us-ascii?Q?B8kJLAFE+jprSy0rDbTNjzl639x3aiw+R0FQ/CoxFoZ4Dlokt4JaI8gqy5kQ?=
 =?us-ascii?Q?CfZMdHBipe9rYjWnU1Ec02ikZUmOBXfxA/GGzFwoV+li+ogC1anhB0q8Ui69?=
 =?us-ascii?Q?yu2rednYhRZO2828uFqOPH/AQdMXt2fXCaIGoGXWl9SQpS0p4Y4lR66HBZxR?=
 =?us-ascii?Q?LjSqC7EkfCGpL5b2c9M8GQ7tpANsGOisgWGyW3GPfKib7eN2h/sGOmXQogyE?=
 =?us-ascii?Q?Dpz3h278jvZ6zD08IG3IZN+uOBoUvtrKj+EL45mfBHKawA1H+KdvdkuWX3Ff?=
 =?us-ascii?Q?WtbsQaPz50oUnwDYV/UjNWf9jvnKYUm4Jih7Mn7rwVIkQcW5rEfWAMxw9+Bc?=
 =?us-ascii?Q?brcdLJ/rMgCFohU1GqXmeF7pLvF7lnT2tRDqFwA+QDwiJgWRKu/NDtKdgYHS?=
 =?us-ascii?Q?6RVlw1mCeNIIvpIMNZriMGpnu1vBu8rY4MgMBRZ8ldFiCaNlJ0qHwOgNNI84?=
 =?us-ascii?Q?0NqSkxgO2Ja7ipi0pa2MvqU9hi18xg71mLaeF7enX3WWLbvh6LcSI4AIwS5Z?=
 =?us-ascii?Q?oKOOB79NYPANgYnUEemG6vO/qe9WnCk/oXp4fKLI7Pt0UzKCtRt99g3x0wjM?=
 =?us-ascii?Q?oqKxp9XX4cmWiJLV8gaV1DW2LT+q1oFMkSgm39ne32SZUKi2rdxkR9BbKA8w?=
 =?us-ascii?Q?EwCnnPLxZjk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/UV9fpy6u/vDbiT706DO/2kA60Osvndpig1oAqs4aME68VpoDc4E1bFceP7?=
 =?us-ascii?Q?iSHbxV/sm0mSD/DuXkCEwZofvtz4HCeDqhy9+HXRHD8lxXwZCytoQ3vYT76z?=
 =?us-ascii?Q?4kH01YzS893WEP9Z03JYjfohxkvZ1FCuavfZ8AboQoSSTHALv239vpwSkoX6?=
 =?us-ascii?Q?K/bIRMuBVFX7zFA+XSN8iLwNHkHU4cBlAu1zNmmDhq3Bb9E7cKC1DmjdZHD4?=
 =?us-ascii?Q?MpVHPyEK1ENtZLs6rFsbN2+QkR3qvdAsAM1WQ37dOd3nujg6uv2jzVz37C3w?=
 =?us-ascii?Q?smO+J4uq916HjvuqYyypTU2HpRseYMivrfSIblYpxUrmQ/ryPkTBXqe7W8/a?=
 =?us-ascii?Q?YfwDBEj/DB7Y4Uac+hkj/lMPcoABnJJRhDbutxeXcC98hpQIfva8ZXPuWjYt?=
 =?us-ascii?Q?h2OO7/ud7Clewk1a6VPz2YA/Uq8p0IC7cf+gdCD7O67x3Szr7qspxWNeE0kk?=
 =?us-ascii?Q?uhcqSuaomG0V+NqqDo42Dt5dJU2uziF3UPnSmQvsUeygd/hBbF5699xG2e23?=
 =?us-ascii?Q?d5d8NQg51kSuDf/xFCGCzWQwEUBTQ1UmDxpkIRFimg2NnWRb5gJPdhdB2I8z?=
 =?us-ascii?Q?iLmpzUZwRHsFML1AdJPOt+uZf4a6G+si/+wnO/jvdl26Wh7KdAmPhbD6RA/N?=
 =?us-ascii?Q?WrL87FIhWUDT8t+lSyqpqg3t8tjW+NpwB4DK8TjYC1cJBl/SaMn4x8XFcUur?=
 =?us-ascii?Q?S+q05G1fCO4JKiYyejD/4BXm9ih5i70K8XC7VvvjPklbohIW5K8GDA7VtfYO?=
 =?us-ascii?Q?j7fcTd91QGxNd+3VRRdoCHAfM9wEBLdAd0uoPY6iQwrVn7/UPhGNp5/GMAfu?=
 =?us-ascii?Q?uohtRLbeoZ6DhXbevLs2WpdFDFKf/FReNX3VVI8qKaXr6nx58aB6Rjlqv0Do?=
 =?us-ascii?Q?U04sYMNYfMK4y18jzqLHuITfNQ0KZhjA53qA34cjd+5P+oWghgBnMcv6Wa2r?=
 =?us-ascii?Q?IX1VMCo4Ivx/VCDOftXX3gGnnXrpV1R0zVvuCKDLiKoYjDSTKgL+XSm78EMZ?=
 =?us-ascii?Q?x7YtMV+6mldLtgteUQBVbWkrQ2owv7hxi0bs8Ae1wAzwxdZi54oaBdoN7xCG?=
 =?us-ascii?Q?+3eLQhzlnYmMO5+R+6IUqrUG+ZQCfYaEmpogxRWNs3u4hrd8MCR2dwait5jo?=
 =?us-ascii?Q?kX3SnygWTWwel/4pExIfnc1W3MHbK3UKKzQF+NMH393SDBPbFE3t7L5EEO+z?=
 =?us-ascii?Q?Cv2k0SDXwpPK9cixTJKZpBXGKtTjVb5AW36DySzOPjUupOy5bDEcH1TsmCBD?=
 =?us-ascii?Q?YWN8s/CfJ0X+M7tSOV3gPJ74uTXgydv5YtcfeOIEhv+l6wJ18/QUfw+KazPk?=
 =?us-ascii?Q?2bjymgdjVkJ0xUh4gRc/0/DfiofyC0PJnUXM8vH/9gnu0OgnSqqMlA5OQhyP?=
 =?us-ascii?Q?Y3DsinQ8wO3UEiXShbZ6vDytn9D9eyuLSoMIZFPIOxh1TDIqAwiRdXJZKHSk?=
 =?us-ascii?Q?j6bSBdAL4ZrxVfphthEBVbkaLz7elJAXuNuDrtZgwcKEJlUCA6DUOGjU5y8F?=
 =?us-ascii?Q?sI/PWhflOIs63br7cffRUvMrmYfxnm/cRx/IYzfOS89Q6YXbfciWkQENEumA?=
 =?us-ascii?Q?OvbRsx4hL/0HQoTmM87lPLQojXevtgbK7/5qR++6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85614c3-e8fa-49e4-3883-08ddaf35bc37
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:28.5667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWmFrdt8Un6yACfL9n7AtOy6S10NBJ+S/JPfRAw1hx5aUUAsHD60VrOSVC4HwRnfSSozBPjO1IfFx8h0A+V8cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMiBTYWx0ZWRfX+jFdHnBnGzFX
 /ppoJGbV0pMASEHP+Ng3bqLMC1dQxVFCEVT7mXtUsXXtbzL2vvWMXA+5v7lLZd8NXJB5qNBXJiG
 IcdEUPT51jK1meEO+YVTLPJnUc6ZW4ztSyCEfC4FE1HA1g9rcs0hiDQCAxRohjNf++pjEVUTq1H
 tKTMwZY5FO8xjtq5Hv/wfqisxAr98Mpf8VuCbRY9HQa7QQTLg0aSEaYgAvWwg8wp0paS1Bw5hSu
 QUxnlyELrN6y4LoTYtduvAzZ+plnLcuD52bHYdkWdbepdmfqsgBB+egpQfnHNvVDRdL6tvEVQp8
 IEZ8WimyYe8GOVfK9XhszUEWaZoU26Kn21xYpUkmnb9BEkIiIuvjyJrAdpeCuWxu4w0FDvRUZBN
 tDxCF76bZToN+lyNOS2IEj7BZ8lWzeMjtbgVPdKVYySsQD927ye6g3ENJGfxHZLuXufHLeGe
X-Proofpoint-ORIG-GUID: 1EVRZTGF2NZu4FJhROHfBwVKxmkQ0157
X-Proofpoint-GUID: 1EVRZTGF2NZu4FJhROHfBwVKxmkQ0157
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6854116e cx=c_pps
 a=kkQK6hjpUACXm7ua2zl0Pg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=70NfNXkHNs9el5T2m-kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Hook this call up to the legacy reset handler for vfio-user-pci.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h |  2 ++
 hw/vfio-user/device.c | 12 ++++++++++++
 hw/vfio-user/pci.c    | 15 +++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index 5fc226fd58..86fbc33650 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -17,6 +17,8 @@
 int vfio_user_get_device_info(VFIOUserProxy *proxy,
                               struct vfio_device_info *info);
 
+void vfio_user_device_reset(VFIOUserProxy *proxy);
+
 extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
 
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 0d7ed9c5ba..5e67cd56e3 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -47,6 +47,18 @@ int vfio_user_get_device_info(VFIOUserProxy *proxy,
     return 0;
 }
 
+void vfio_user_device_reset(VFIOUserProxy *proxy)
+{
+    VFIOUserHdr msg;
+
+    vfio_user_request_msg(&msg, VFIO_USER_DEVICE_RESET, sizeof(msg), 0);
+
+    vfio_user_send_wait(proxy, &msg, NULL, 0);
+    if (msg.flags & VFIO_USER_ERROR) {
+        error_printf("reset reply error %d\n", msg.error_reply);
+    }
+}
+
 static int vfio_user_get_region_info(VFIOUserProxy *proxy,
                                      struct vfio_region_info *info,
                                      VFIOUserFDs *fds)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index c0f00f15b1..49d12763ab 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -263,6 +263,20 @@ static void vfio_user_instance_finalize(Object *obj)
     }
 }
 
+static void vfio_user_pci_reset(DeviceState *dev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    vfio_pci_pre_reset(vdev);
+
+    if (vbasedev->reset_works) {
+        vfio_user_device_reset(vbasedev->proxy);
+    }
+
+    vfio_pci_post_reset(vdev);
+}
+
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
                        vendor_id, PCI_ANY_ID),
@@ -310,6 +324,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
+    device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_dev_properties);
 
     object_class_property_add(klass, "socket", "SocketAddress", NULL,
-- 
2.43.0


