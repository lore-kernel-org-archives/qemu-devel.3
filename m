Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4EDC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubh0z-0007nS-6l; Tue, 15 Jul 2025 10:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgPx-0000WX-Dn; Tue, 15 Jul 2025 10:14:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgPt-0000T0-7Y; Tue, 15 Jul 2025 10:14:00 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F94jc6013686;
 Tue, 15 Jul 2025 07:13:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=48TQYQuyj8GybL4
 ZliGubqr5E5g69THfK+gJGUCjmt8=; b=RZ+4WsuxKDRWqax1SHnaYj4RYszKumh
 VeadVf9VqHlWjEcOL2iWjnYPlaMECEZDv+7hgNLo4Q9kMQuA+FGr7mae1us4ACcP
 yB+C59N249SUYWQX0ZcBkMxGgKMq6K5gPixOirt5cqf96v2/1ub5QeNHoEwx+uJr
 ZaKZcA4WOdebCaRLNHARjH6/GKIx6rSmtUNlaqgl7IME1luQsaQj3/WKAn7CAhHe
 rnFulU2xpZo2oEmijDt1wuAqX2SSFxf7x2a52QO7D+fJtGn2vwWzZvPf8ZUjxVeF
 JgueAIi1jkkq90PLfUENj24WgSfWnMuW0f5dkPQAhJ4CY+AcgS+psKA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022136.outbound.protection.outlook.com [52.101.43.136])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47wm1s8rcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 07:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAz1UjYXXTdTSlWRnEBKoOUQEE9Hrt55Ey+6cjm3ZYlLulu7Ypcj+Zpwfwfw5eLK1SXamApiS1ET9CSed8vjKK5W6A5hAol0bFAF9l7qPXlaKRMErmb4FnTIIfuCIuxSqzS8bpzzxUq/2a7p5Nog7XpO9B1UZZek4RwIp+F2RXo12UMkGVz4kSFHGHGda2Jts/OGTumHMK756vz1Grv+DsBXykkfL9Q533QH6kwHO2cFVPcgSFIAYvgXQGARgx5Drt7NHKZP+PlC/UjPjVd3ZxMqzLfwybl4CKIhFLGyMxlWqDOO8aFjL2xux3Jw/br+lJjEcNVtl5fL23Mcd6nonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48TQYQuyj8GybL4ZliGubqr5E5g69THfK+gJGUCjmt8=;
 b=SNmyvIEzrPaaw4Bj0lta3DvpC5WAj3KBpLPvhotSM1JzduTi23jN0Z1QadnxUhsmSrvyyqVCIejlp57kb0rktR4oarUFGb9kBGI4NoPtxn0LR4BHYUu3bCHLzefdqwCQykG1kxWMBMIoAH4EGHPSOw9vaLg+YQ2fmR9COn+IZW4L8A/XbTQV4nOOLZPqbrXXXIAg8xljByOkmZEky6ZLgmusb7jdwKV0Yomy6U/Llv2nx4Ls5+Thsxec3Zj1/Qn/6mAfmYES2/BdCijagNvu9Ms5cNPF+4/A+QsVrCqi4zpIzGM4eTIYM5WA+fJTKIEHkmQUYPH+PRhKwZ0wMNlJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48TQYQuyj8GybL4ZliGubqr5E5g69THfK+gJGUCjmt8=;
 b=BkhNXDAQsteLBh3uNF8AWnJtLiLVtPgDRMq/cPkRnajV7YtN5nconmGRt/vrOOS8cXw2Pucyu9L1+SYkCokzle19NNiq/5XPgXOIpuKakdYFOD11leq3ugsnimmRTRy+kTwwhbdM+laj03xJq7C4z359nMXvQg6Kq7dbiYlB22cnp0Dv0juv2B2k6EHdxl73Mc0rulX36zlJ8j72omch1S+mjNGX1+RQb2/m83oiEIWy6F/EpmduoIfvMvLurSQwOcA10TIrBcR3jL9fYhBLjbSfE84gh5Yf9hiruo25742iGMITWrV5VFDS5JKY9Vy/Eq1BEUwvVfUh06yiwSsniA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10760.namprd02.prod.outlook.com (2603:10b6:8:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 14:13:43 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 14:13:43 +0000
Date: Tue, 15 Jul 2025 16:13:38 +0200
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com,
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 10/22] vfio-user/container.h: rename VFIOUserContainer
 bcontainer field to parent_obj
Message-ID: <aHZiEnFAJXI7gCUY@lent>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-11-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715093110.107317-11-mark.caveayland@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P189CA0049.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::27) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: ec255c1c-aa9e-48da-f7fc-08ddc3a9ce3f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sJkzF/vdZShjGclxkT4PATiYPXD9EDp5XI+TNxu1oK8p3T9cQtmmlcGzg2aL?=
 =?us-ascii?Q?7iCXObzyj7EDLORLTgAGn/iX2xtAAYzRzJKAHbIKaCCGAUoEf0oQfBclsotO?=
 =?us-ascii?Q?BPUuQ/S2TiQew8zNCAlObfoduXy+DlvzkAbSAr3trYpIYIg8HOZdw6HPSlRm?=
 =?us-ascii?Q?wQDnjLFVDOLWZMn08droEHI+S2snUjdGIeFmeyAjgVl2GiYzXAF7o/0KqrZu?=
 =?us-ascii?Q?S8FgM0hc9moLg33msU7VdWanOuVGzp7w2+NL8dJmYQZlqzKmWeRuqTVTrta7?=
 =?us-ascii?Q?0oJ2YFcmvKDcLhOP+6H/znJLwHGxde/du0fR6Vh25W++0a6LIaOwzi1tuNXq?=
 =?us-ascii?Q?w7blB5VD2Gbt7mUWfk2dTFjD7bfzKMY/kbKr7Is0iydId6NTcOcTMjxBMwaG?=
 =?us-ascii?Q?rgom7bc90N3btduC/L5+w/MEVLOLTjxZGT4o8K1SKO8Cw/nELSITLk77QUVs?=
 =?us-ascii?Q?7/2xbfL6Wn7mnSRS4vKylyVHyQbZMioL8c+FP93O3n11Axsp4mC30+MLGBpQ?=
 =?us-ascii?Q?x1PcS/wZs0ZBH+RYf5EsvShKufhk1q2aHEJYKANBXMVsR9FRGLT8x47DVGAC?=
 =?us-ascii?Q?N7tHPpiWm6LbA8lpKpa6c3wF26KcZR0jV9xIoO8DiSq+FTnOMu1h0qq72YvM?=
 =?us-ascii?Q?cQMHTRaitjEPMM2/jKpdMcPbVkXEqPUlsjI1ih9HeMMZxYhAG28zCEJ9iCD8?=
 =?us-ascii?Q?wJr1M9yvL62o7a4kEKooIsbrYDw5svCO7n5G7P49y7wioPOP/w5wN7POVbZl?=
 =?us-ascii?Q?d/1JEhq6HYpjnHY0PLCoFni8yVWeRWsDB9wOG5tfuz/MxDEXH/pUSrkSEOH2?=
 =?us-ascii?Q?myXRFh6wkhEv6b4qRlg+KYNJTRhMQIRZKJbhUhsCKQREPGRy9bbovIdAGUYC?=
 =?us-ascii?Q?K1iXUPngbDt8yKqBZpiZhURjhtE0+byIDX3EXazE0AOzTebDc54afwElZOwq?=
 =?us-ascii?Q?iAat4DAfqTuzgfPD3h/zBGknpH68/UUoVhXAKqez2uUpBkNS+AI5emgIpUDf?=
 =?us-ascii?Q?uMo2i+OgW6Esah1V1Kl6wkd4cb789lHVM+Q8vbJMgy8hMzJIJnVylogjGQXG?=
 =?us-ascii?Q?Iv9MPSkbc7tWo6Zt5Xl3XSB64c6ipIz4uv0CwdU/qrgJQ8dIOA1fx0V+/NwP?=
 =?us-ascii?Q?NBYLZxvlEi/TLVscpW8LnpAfJ/25x8xtEWJj6pQzdhbJJeIxFyE2k3SBryJ9?=
 =?us-ascii?Q?s7oUghoJIJPT6KG3bJVsj0XR0VDq2y5Wiv4wXfcGmJUDBFTW6z4wfNFILtdM?=
 =?us-ascii?Q?36/qlfUdc5SLR3CkyUSMQUKa2CvmoZekq2ZlwBRrUBGWfwUZy95TImObISQy?=
 =?us-ascii?Q?0+zd7jBzLr9iYU509ic1pCfEnWI/aD230gvlkESsKpjehtWd/uvEs06AI/Ck?=
 =?us-ascii?Q?oJ8RIQUQIfZVVb9Cl7cU/nCKpZ+DP39ZO1yIULsopzaT/4OVIgBVPlioqxbv?=
 =?us-ascii?Q?1aGx7lQB/TQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G9IkGmgD9ZLrSy2eU/jkVhLKtm6gPdIKP1jGyE7SlaKgnK48e1e4l5h34RM1?=
 =?us-ascii?Q?Y+olt9p219cqOMcpfN1Up3lCaveRI4zji4E06ohn1hRrlqJjSvqLwmppy+FE?=
 =?us-ascii?Q?ljj5StOLfelIAbrypPKrUApt+q9UoqwkorVIWl0cntwaFkFLNCik+nWb6nGL?=
 =?us-ascii?Q?MsQ0LLRnjnPBpW6bBddfteN0Km+ybgiL5VcTHUp19f6c2t5b5DyFniDvfutJ?=
 =?us-ascii?Q?E751LL5MLl5E5EJkPdASgVB4RJW7TjJ5ajNQZGfdj64ym02UcF7OpZ61/HOy?=
 =?us-ascii?Q?6kimyB0SaRBVIRMiBzlC+dy5BTwyD1Rv2bNM1RjkVfvTHxpyiB5P8GYGplU6?=
 =?us-ascii?Q?a8ZvIZ+rZFKUExdd8M4DwA1vzbeCHai0fo5zndlgIqDMyfzX5AVgSAgTVmgF?=
 =?us-ascii?Q?4I9QLpSb+LImMIt+0P7ecLHrpFuzUnuwT3sGw0LY70w0OuUG1JiyrPv0YK26?=
 =?us-ascii?Q?YJp/W8pE3M1lvwyDbJAR2nKT/YGBfukpDMaqeGVDX7GTER8j7u4KCDpxWTGO?=
 =?us-ascii?Q?ra1IfoEVZT2WB5L+KqLCzomHt0kgltzrbX8+vSJPhAmGqszwqmKN+ty4/xeH?=
 =?us-ascii?Q?/wBpo1c1gnK+FLp8N38qcagve2oSR+wn7F172resXFhTnBTHLQ/LQOwx7wtZ?=
 =?us-ascii?Q?wUj+MPPkulHnlYm+38qxRzRfYku7nTIEOSr+9MccSQ5kme6zb4mkiIqf3Ch5?=
 =?us-ascii?Q?w8TtzuiP0BXTW4EucvPQS76hZXk56neeP8SEV26s+40eXCM+DX4jrmcs438S?=
 =?us-ascii?Q?1zI9sG9nW7cTa6lp6z08KKwVUX8U0y0GXGvARhJHh/EQ6o++5j6ojJKUZPJj?=
 =?us-ascii?Q?+eL3oqSimjeXV0kdfu0Z6qDMlICIbauji5VDHKX7VRY1nfPmsyxl7xLyQcoj?=
 =?us-ascii?Q?JHQ3YfLfdvfX7hZwSgWyhLexLzzwCPMKiUCY9Y/ZqweJz/Nyx4xHDEjtMb/H?=
 =?us-ascii?Q?Xw7j2nu7fW/siLOfmhSqQWdHjpHN24tZAt+4hZ8xE5YRAESxwV1+kV+qbNqJ?=
 =?us-ascii?Q?Du1pZD1ff4MlVmScm/eZTKnKyXeqa6bJzo+q5M6lvFFjehY1imV7efR8yJ6b?=
 =?us-ascii?Q?cWqmY4/fijYMQa5Xfy6LDEEKZNimwfIiPEf7ySuMSE1H4cb9ZAaYCy1V5EbU?=
 =?us-ascii?Q?fZ54/FguRdngIQqGzYDXl4yyXYaetEtgnHpc7fREWYBfhpYM6HIlzr2NP0uK?=
 =?us-ascii?Q?iZup1X0F8NAD7Qe4rrFdmMANzZuiRf7SPZxcwXSCsGCV2xZX7hqMoYLLVMkE?=
 =?us-ascii?Q?v2SDLKn1Z53N1MkxLUjbwMFzUr8rUn1bIoAORTLQ1L8V2rbIT+LBdHuSaQeS?=
 =?us-ascii?Q?X8xHOa15YZPv7okaPkXfDqBXdmQ3eB7TxYLQdVGC9qEhOxI2FS9j+YAu+IwD?=
 =?us-ascii?Q?NHrbHscdrI0Nz2O6iWoFDEhp3LCM+w5zWrhKqqzWXbcoarr2cGVCqrQLoDe/?=
 =?us-ascii?Q?f/pxq78xfGeY6voECebwp2afEspmF/erKX8V840aasYHIOxkkvFLE3rXSgNy?=
 =?us-ascii?Q?nMaQcS4OGDimIPw1hyMweYZDM4IO9KL2VX1w0F3cwAptWIX9kK+EUAMwJLEZ?=
 =?us-ascii?Q?2geKKfEfKMpKkzO/zi/75ZblLcgey3pR4IbSPGVF6UHUcXuU+DILqHTGbKQg?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec255c1c-aa9e-48da-f7fc-08ddc3a9ce3f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:13:43.5182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UJb2y5/aNSH3YYdkI3BallKRB46BtambOvwe+ljQ1drFFt++ZIYIk/9ZwLOkeybOkEs21bosZPUyQHIKl8e1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10760
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMCBTYWx0ZWRfX3t9Y3OZus1NR
 1JpUxebjHAvSVP4klM33zMXW2uBgbtZhFY8jNrTaIrV1/pw1kz1dLpm5LsNeGO7jPlHft6842AY
 vdAghClVhfomWosSdsqatjEwgScst6H6QlH50dwKafJBCwladBo4OfveTYCW8qqOsljXofYlXxc
 8j6zEB79osVPA+QHPuPnLjab9hsnWKMxg2eRVf4UYOy3wXnj3TcEsCJ+kyeXiF8Z0UOed6bRRq/
 kJ/GFI4Sg7qunuZtXAzyHYwwGGBH2ERtYcRDRLx8noPUGe6mNUS+206bZUeSrqMfKWbKNrb0pUo
 4m0NOhFzJGJoYHZtXjKO85nk7oqnSYJkD1WfxqF2IXz7MAIP8yBG2P4Sz6Cq13s3C6Dfj2D5pgW
 4pAo/94IADRCClcpyn0Gu2TU3yYz+AK9CMb99o5w3o8E7PDsvzd3NpPkWm2cvBgaK0h/TSOa
X-Proofpoint-ORIG-GUID: 9QAHUSvQphfojCRooHKn42K-X38vHlCZ
X-Authority-Analysis: v=2.4 cv=fZity1QF c=1 sm=1 tr=0 ts=6876621a cx=c_pps
 a=/d/dYiFJ9j2vSnh1phFeww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=sqe0QwEsygDhhh5LOwkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 9QAHUSvQphfojCRooHKn42K-X38vHlCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On Tue, Jul 15, 2025 at 10:25:50AM +0100, Mark Cave-Ayland wrote:

> Now that nothing accesses the bcontainer field directly, rename bcontainer to
> parent_obj as per our current coding guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/vfio-user/container.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
> index d5d2275af7..96aa6785d9 100644
> --- a/hw/vfio-user/container.h
> +++ b/hw/vfio-user/container.h
> @@ -14,7 +14,7 @@
>  
>  /* MMU container sub-class for vfio-user. */
>  struct VFIOUserContainer {
> -    VFIOContainerBase bcontainer;
> +    VFIOContainerBase parent_obj;
>  
>      VFIOUserProxy *proxy;
>  };

Reviewed-by: John Levon <john.levon@nutanix.com>

