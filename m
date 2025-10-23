Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25DACCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwKK-00012K-Ld; Thu, 23 Oct 2025 10:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vBwJy-0000oj-5E
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:29:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vBwJv-0001Kv-P4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:29:41 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59N6ZYff2068090; Thu, 23 Oct 2025 07:29:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Zjs0Syn/UrJovdeWFKNcG8HKpbplSgZHa5wPtPt27
 Ho=; b=fg2+iql37tTmcNaU4nqm2E6EenERP2Y5vYzsqNikz/0QG2Tw4iL8fo+h8
 T5kYxNczSGG+9B6U8Yzw0DLZ0G/y+DpIJiRE0Legj7CdVfd5ii04wsBkVrRC84QZ
 oROfdUvxUwhujdwWydDpyxnmNyu0zHd8UZaPP6n1q5yUyXadhZk8Ss2rUcXOIfsS
 YVTFONGDFghb2/NgVk17ltf7pEfU6upvSFLBc5dXAnxcWPXfuBIfjCfQL6hE/yRF
 2Yq/BQwUqf9hlKovOJC9SXaPlzAtsbuhtY6qMKS3425I8TlpyNAxriuIGrsNqlW+
 I1lcBD7rYYf1+Rl7sDnqY4Pn9og4w==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021084.outbound.protection.outlook.com [52.101.62.84])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49xw3gbg3x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 07:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7YjzZSFFSL5RVmPbDvv/wrpU1rtGee4ym7lpFfNiIKLiUbkdehF65DGKaUUSlemHyUiw9Dll7CtDjc/GE9WDZ2cRJLVGyUNx3nQKoLt7+9j2MnOasIBCNVMKcXvkWD5qr0UahRKqQiaTeeulsNFuLkixCMNxNzabRlo81k1rqIclz29+So23Oz8pbloLz6dh75URWKurlKzetMfLaXyVy8n6dEZSX3ebxr4eqN+IkBsVqSbzpV2PpKpUCbTKg8hRm6Po+AFjOmETJpaBx6t+vf38rccaFkJO9G0ihel0s/lWtmkd7W/SHFxJt6egPVDqRsIRziNOPWxq008eNlJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjs0Syn/UrJovdeWFKNcG8HKpbplSgZHa5wPtPt27Ho=;
 b=n9crGAdU9t0XmJKlwG0SYTz2J+AsEPrrUSZ+YDtFyPm62dK58vDzeHITQSQbcNfWmWVq//QelOnvXvnlB6QCUS+C8edyRhYgFyY1ju2iHh+rmW9V2kTD3ht7S5L0JJvP/PVoaFBDYs+ClCj733ZLArAueBcWdWYZpRrl9kD88otYhm3yeimcUaEttqItbeFcZSEfpCqVKtqeT69DQ4/xMrGBVvv55BbohIw01fqlpY3I0B19POZ6YM4wNUU9HkGvo1OiVREW7l1GWNe8/x2IZwSBpZG6OkWtH1xRHxmf2wJVubQURaAijk/kehcra3TDtP2nf0B/VX/CbFviN+is1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjs0Syn/UrJovdeWFKNcG8HKpbplSgZHa5wPtPt27Ho=;
 b=J+Nf8WY+MH2KLTAGLuFhlTFLIUhmCi9n/fKe5BwiUYai8bQzcg8g2lZtCSDxnE8XthjqYmpDfL4di/yi1KWAD9vU94SzgzdwEavdkMwbRQMLDA8/Aadeoy2iNIQ/wR+Jq/kwwBdAPcgz5CVURvtx+Ns7oPZOuhMdAGVYpdGSbO/iwjhGXS/QPapile3Z6WAXap20+6fj6IE48yJWJ9k1EmEVaeA2oZgIopkMPZcpSXMAVbOARpzkg0QIhTYcJhED3S6lk/nt+DXHBvzHMZxt6WcbzvVWFFYlGEGd12p4KzyrB5jxjKqDKYul/eaTuP01/mW56CesEQTL1xaCBV39rQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SN7PR02MB9331.namprd02.prod.outlook.com (2603:10b6:806:329::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 14:29:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9228.016; Thu, 23 Oct 2025
 14:29:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: imammedo@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/i386/isapc.c: warn rather than reject modern x86 CPU
 models
Date: Thu, 23 Oct 2025 15:28:09 +0100
Message-ID: <20251023142926.964718-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023142926.964718-1-mark.caveayland@nutanix.com>
References: <20251023142926.964718-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:806:f3::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SN7PR02MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: e64df169-860d-411c-b5e5-08de1240961f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9beWADOtOjZg6k31M5dIWCMsFAVBrpyN059OT23PB07n/EeoHQDy8yeGQVic?=
 =?us-ascii?Q?/5MF97n17q+8To71pZePd+rFHpv9AZ1gTSlyvRXEqk3EikaP0tAZfg5Jbs+S?=
 =?us-ascii?Q?v6rhf1uOs0uiwQFac1ouHFkRuodgJAGuG+1dmtO02kjsvK5KkwlURak0Zjfb?=
 =?us-ascii?Q?GYQJbsCMQhPyoj9gIwF2bgCRNrzT5OHWUvTcYUrZWBp0U+gaK34iYh+o256D?=
 =?us-ascii?Q?4ljZw+AYbPLWdl0r5xXan1cdzYQu/QP4vUM+pZb0wa3cq4thwbX5kxWNkCIs?=
 =?us-ascii?Q?I1Yv1nK0oA0/WanVq+yLlBQgoteDgBJLjAUzgpgq+gxxSYrv6plCMd3qOJ0k?=
 =?us-ascii?Q?NNfwdFnfp98zCygZ/9bm3Haqx9e85P6YdgSldJhR5c1aa41y0FDnKsh9HQ5k?=
 =?us-ascii?Q?hZI8IHXu8vJu0f9vQWX9U8BZfaKyxsbYZhos8V1QygOwlKk2eaJPK6PqJ0be?=
 =?us-ascii?Q?WLjxC7xy2q2c/iaUeHzNRT0MaeZsD2JegZKm01hiEbfsPESdl3OfTdcfF8Ub?=
 =?us-ascii?Q?xNrYJDDtHJdFZzI+tusLWqnxyLt6pVcUVzC9/i95VZPcslSC7N1BIYFEKpQ4?=
 =?us-ascii?Q?DdaSKCtK++iv+d+gRWVeEXAuXdlzoa95WQT8AkV1OscJlfEm11UhfmmGPpiW?=
 =?us-ascii?Q?XH0zlppv9jyf/3gcj8sgemTKYZdZu+Zt3ff9ypID0ILluzbaTExPLZK266SP?=
 =?us-ascii?Q?iD/u36UrIE8bayp+ePvXx2iIAXquj0e+wmBXsX1jVBwl8Bucio8gaQ/X7rYA?=
 =?us-ascii?Q?rfnrPId+YGkpAZItc/FuDl1o06EoCzSJK0y/aUG+xqTieBGvqGCWz473FhF2?=
 =?us-ascii?Q?yTyqsyTcRV8yvWjNj+NT50rGF3Bu5isKJLui9yi+G4cL/G/e3klA0gXvwdho?=
 =?us-ascii?Q?b+YnPL7Ep7PSidM1rSrKCCv9befuHv1Rn9lKOTfe47G70CPegF5y2GAi6nW9?=
 =?us-ascii?Q?+Fm/osRAhu39HnXL/Dj8r7eI4fIAE5vsiJKSh+r5REVHcSwGDhvDnJQWQjEZ?=
 =?us-ascii?Q?8Hytq7OGtvKgOm2YXbvz4gaXuuxIoBmsABmqY0gFmb3DCo39v2ltTfFkmDb6?=
 =?us-ascii?Q?2RF2NcA0S06tmz/5PTL/ueugjy9bUDiyNk3A8dKbLCN3uQ7r/RjfIX2CueO/?=
 =?us-ascii?Q?QFZFDwnnCW+ye8oiLfmlh8+Crz8hwUOa7dn6zVIybie0iSrNUOArFjlKSiBb?=
 =?us-ascii?Q?Jt/R+Y4JCwzCs3EPUWkihsvD1qjeeZ77CiHBkK9yz33inL1hOZydmNQC2FIl?=
 =?us-ascii?Q?gIgjJTu57f6VUlteMDRG1i/Ct52zMAcLZXTcUUBNTVZwhLzgyAzfGvoR8OBg?=
 =?us-ascii?Q?KA5uvJUQpmt4S+rE6C5GDHFBdINkufK+6QtnBXuuD5BhVi90ff81BQBEjxRs?=
 =?us-ascii?Q?bZG3+eIJ9VwMOK2pvFaDE294KmkTjZbtDtw9/8ohnzE3F6boXE2oSfTgKz09?=
 =?us-ascii?Q?+LMwardfS1gAtEDJDAWaIHzeaaw/UWAb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lq2heoPLXB1FjMb/cvtY4K3I3C7l6yXloXJJLJtrReptYj1dPDpXFwFfs1yG?=
 =?us-ascii?Q?HLpNzX37vziCoOKR8AvoXIe2P1wOj3WH3wRWp8bD42xkMxI0ynKjpQl82047?=
 =?us-ascii?Q?eAuVMF30DrNyVENc3aubp5MXlnJykU9hu72Z8RHVA9ZQPu0BukAPVYmxCKSX?=
 =?us-ascii?Q?Yp0nMQ8bIwzu7m7qwGRCv6ryTZNBF3CNZ9Ssvu36DvoFf58kMgZQVxSEIU8u?=
 =?us-ascii?Q?Ph28cHwcdNhSIN2bASI/3K2n0ceQwb5lFfGfp5es+gCpw067h45DNb1CUKmg?=
 =?us-ascii?Q?zZqdI+dgw1iIBuaPv/z/ZDTV5b8yRAaUenX6DRofC4OhSOVZtEEJols2cLn2?=
 =?us-ascii?Q?SMbWItN5nx4PXuhj7hWverp6Al6Qaaon5Xnp2Sa/6DbU/Xd6x2jxuH+UozSp?=
 =?us-ascii?Q?21T+fO5RGAdv+KU8f6Co6WAuoF7EvRhAe3HZYKxcbv32RLN6PIe0WR1WfGdN?=
 =?us-ascii?Q?ehN5ppTxvAqDresOp98ER8Y+Y9HHF3fDMRfedmhmPeYgStSdz3Qm+rUnVlyC?=
 =?us-ascii?Q?hRD0qFFDOuU6YtYVbOyYnePH940JCK+qhM9W+Ud7XfIzpbITJ4k5qkz4TRfd?=
 =?us-ascii?Q?DtB484jjj6xQL4qXA9sOf4jaDg+71hT3hDgrbQ3QhWkWAkZJqrXppUqIj+qV?=
 =?us-ascii?Q?n7yzvQoQ2teU1BLpf1ziAfgQxD3QNKMSlRSYi7idFN/6UJb639MSL7fZGhcr?=
 =?us-ascii?Q?skiEC/k1USRZyl2uf6l2Y66ab1gElBWiztMVQp14BXJosj0D22zL6v6+/icp?=
 =?us-ascii?Q?qC3hBwoRk6yI7b4FSiUpaag66c68cmcUa/4TTaFb8nrocGzHSKBPW//Y9Dit?=
 =?us-ascii?Q?gVywNCc2Iwp3/1rkBW6AMtqFi6XTx11Le79VK1pOoM5FGi2nGe8maSArJ7EE?=
 =?us-ascii?Q?DGRaGjUPrIDuRebO8hSamfn/HDTWEnL1vlrXUsfBLUXoppolH7W5EdlyvAku?=
 =?us-ascii?Q?y+5p6t/b9LV1WX6olOBEcW1csj9FJg0xnCJzy6fWoPlJGlNQoHnFr8KfZlU7?=
 =?us-ascii?Q?wl2fiasj871JRV3P0mJchpbz1jz3EOHAaqUs9NkwknhGU0wmkLG/F9RLUdBS?=
 =?us-ascii?Q?CK/ThWwuj+HSoz9Lct2aF7BH8Lkl4dXK0huVeSfAf766rsKlRyFzkFSke56z?=
 =?us-ascii?Q?42adfHfrLLMEWjnHmsLZcdJDGtGTn/zzL3hS0UhA9e/dc7rcrXtuqEydMwKi?=
 =?us-ascii?Q?M71FJbfxzV9ObPYmd5j+bqQdXtW/qZMTRnrEB8pU88+BYqDICkWoRjOeXjyq?=
 =?us-ascii?Q?Snns5rs2PpfcqqKyesBj7uuMT3fLY7Bp7y+2SOKLPBMGaVnrmuRdTxo79/mM?=
 =?us-ascii?Q?04pzR4U1Spsx0epmL6w2fxaB9sd4QdDDNQAGnXMSLGmsX+OvaHM61TL3A96y?=
 =?us-ascii?Q?w4E1DvK1wqwH38bov7uBkhEG9OLmm/giZZslzxSgkK6uIALWHsF6nCwUHouu?=
 =?us-ascii?Q?y7qBBuBFnnAbMcCnYFsydAeeFFsUMepRsO214aMB08fSAphr9TgcAeK4dAU2?=
 =?us-ascii?Q?1DydtqFTFDYPCJBoy86tSms1PpxzjJuKAD/KMlGM7NbJxobXk5t22PGXrVhU?=
 =?us-ascii?Q?nNQtc+Io1qzY8K5te297UFmlAdILK9YiyN3zqQZg0UxzDEe+5jg8vytVwhYr?=
 =?us-ascii?Q?++BUq69MgbDG4y7M947ovFTRNTMKnFdQ+iO0QXixHaYRdi507PF7jYtSy4Oa?=
 =?us-ascii?Q?HsVGrA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64df169-860d-411c-b5e5-08de1240961f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:29:34.2836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeTANqClahtaYMZ9dF/y28kI9df75HsjeGX/TqlxB9T889mr81/NeEp/SsTqvCmnKTRFPNkdj8sEmnZy/zRB2+7NrkWrVWvjsiJ5A49mXqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9331
X-Proofpoint-ORIG-GUID: UTFy8I1GyHmi2JBUqP7BaGmLStGSMJC6
X-Authority-Analysis: v=2.4 cv=GsZPO01C c=1 sm=1 tr=0 ts=68fa3bd0 cx=c_pps
 a=0yFM1XxYkakKyygSKIuBYA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=kkQtzGaKwxxQygf5nOgA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEzMiBTYWx0ZWRfX8xbgAyCxnQie
 QFBC05WNwxucxT83rt0ewKFiv72KsdDPWlIfKQXskjRPUr5S28U/U/w/VvaZk2yzA5osDU7I8rN
 ZqBjUDr81JkAX0C4jC3mNocp4OJzVGLh6PLR8GXYaYlQiTQ0sTwC3UEvMD/VthhbK0coHLGItNq
 EPtgVVosC904M61dfu3aWQcywVh62940lyMDPYLgY2YBksAZZDSfuAMPI4SmLv3DE8Fv+wPLpkK
 nvsbx/Adlsi6M1JwVSUmM4GoNmqb90nIbJt22IDyNqteUv1bA78fXtysIMGfA2t4qu1XgikzH2U
 GdpX3duFg0w9Xv8K276ZdosX6G8xpY0uKDyy5tN1ASqnCka2Q1cyVqmO9VS9fIySs7n36hkGil+
 SZ9dn2fkFflExRDgLTNxxk3i+Zbtow==
X-Proofpoint-GUID: UTFy8I1GyHmi2JBUqP7BaGmLStGSMJC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Commit e1e2909f8e ("hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs")
restricted the isapc machine to 32-bit CPUs, but subsequent concern has been
expressed as to the effect this could have on users.

The outcome of the latest discussion is that we should exercise more caution
and follow the official deprecation route, so instead of rejecting modern x86
CPUs issue a deprecation warning but allow the user to continue.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/isapc.c | 53 ++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 44f4a44672..1ba9ae22cc 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -41,29 +41,31 @@ static void pc_init_isa(MachineState *machine)
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int i;
 
+    bool valid_cpu_type = false;
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+    };
+
     /*
-     * There is a small chance that someone unintentionally passes "-cpu max"
-     * for the isapc machine, which will provide a much more modern 32-bit
-     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
-     * been specified, choose the "best" 32-bit cpu possible which we consider
-     * be the pentium3 (deliberately choosing an Intel CPU given that the
-     * default 486 CPU for the isapc machine is also an Intel CPU).
+     * The isapc machine is supposed to represent a legacy ISA-only PC with a
+     * 32-bit processor. For historical reasons the machine can still accept
+     * almost any valid processor, but this is now deprecated in 10.2. Emit
+     * a warning if anyone tries to use a deprecated CPU.
      */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu max is invalid for isapc machine, using pentium3");
+    for (i = 0; i < ARRAY_SIZE(valid_cpu_types); i++) {
+        if (!strcmp(machine->cpu_type, valid_cpu_types[i])) {
+            valid_cpu_type = true;
+        }
     }
 
-    /*
-     * Similarly if someone unintentionally passes "-cpu host" for the isapc
-     * machine then display a warning and also switch to the "best" 32-bit
-     * cpu possible which we consider to be the pentium3. This is because any
-     * host CPU will already be modern than this, but it also ensures any
-     * newer CPU flags/features are filtered out for older guests.
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu host is invalid for isapc machine, using pentium3");
+    if (!valid_cpu_type) {
+        warn_report("cpu type %s is deprecated for isapc machine", machine->cpu_type);
     }
 
     if (machine->ram_size > 3.5 * GiB) {
@@ -154,18 +156,6 @@ static void pc_init_isa(MachineState *machine)
 
 static void isapc_machine_options(MachineClass *m)
 {
-    static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
-        X86_CPU_TYPE_NAME("max"),
-        X86_CPU_TYPE_NAME("host"),
-        NULL
-    };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     m->desc = "ISA-only PC";
@@ -180,7 +170,6 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-    m->valid_cpu_types = valid_cpu_types;
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
-- 
2.43.0


