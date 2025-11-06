Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F29CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 17:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH3QS-0002zv-3S; Thu, 06 Nov 2025 12:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QQ-0002xQ-Tc
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:30 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QN-0000sy-Tm
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:30 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A6FqJC61500139; Thu, 6 Nov 2025 09:05:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=14cdACMeayaBf
 vLF/Sqr6UfFkMPWfXjTG2lTzyY0L2s=; b=tASNig4ncZDOif9yEMHjToICW4nem
 k3MKgxRiJbhY4VJ3LuQx8UlS7rMps9ZgZaMetp2GNhlvTJHivrWIqABoqf3xCYdS
 IyuUC45dSc/XQW78nsnMSHtzzOuxio+JJZKZzzVMPT7KP57moO6QyCIgvYNaH9+U
 R6eb/U4FJyeVqel8VV9dIp9C3TwKvMFGEZGZ9pTOXfrywrJMcRuT17OPWbUz2bzX
 rYLu1AZKWaLycgdvSYRsd+w33iDBzdgL4of5rKTAVAm8u1NekHooTM/nizPtXW+9
 dc0pvCFeWQdZH7t6yI96Q7Z4AKhQU6hvyfmRrgt4U3y0/sNns1eUzuz0A==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022134.outbound.protection.outlook.com [40.107.209.134])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4a8bcfty6n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 06 Nov 2025 09:05:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJtq4W8wlu8SbFoQWfSNOMpJi3+E3UqSPWAWUltP+2N2PTYn+F/7z/Z02dB4SoI8Hc2y63GY7SA3Q6+5alqhpouMptNoStxlS4ieVS3/F5SgMfS1JciYZqtadEZ9MsC8LWQ+sYH2U4RneVvL7MKivtbsljbJtLJsjWhh2qHcXGY7eSmwVKX1baOPvQQfXhCi0U3BR9V7P6+i7tR7P1whGGRL6X2reC041wL0gWRZ3UdNmnQkfINUs3k2Lx6I/QwFNwNnb9Pshi7hMctThuGoW7cjslHTajTldecPDVG4ZjGRHysYZFFP+8HIa18Qu/dtRIV2LFru5jKPqcNSlFLnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14cdACMeayaBfvLF/Sqr6UfFkMPWfXjTG2lTzyY0L2s=;
 b=LchEpnc3r9FSmrn0elWgqKf3BSYCf1tkcUEd8zAm1BJWSkig3h01AX1R4OyYbHIdPVOEyz0Uc427vJykBcAO1IYTg1kRZRBK4DELLHr5CeduFUvWzgCOtL/O3Vcut+YeqFb6IM7PBzVmQitqMQ+4ECKg8s1aRQDX/J726MWAobzxQCG36XatLudsOAgN/SolAJNLKGVIlV0zvRhTWbxE7EEhuGZyYSykxvmbQP60nWV1psA6cJwoENFue2MYoZrOgiOX9EnsQ58RLaqezjI6SiMmxmGvmr+zaxaX4eEUdAtXq3B3oARq5YQGTyRlWQ0e82WRCqsa0vWMwAeUKJELWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14cdACMeayaBfvLF/Sqr6UfFkMPWfXjTG2lTzyY0L2s=;
 b=SMN4uIMyUmhwXt6X49q9yXKMLJMmszy/Vr8Ca80pfHNtF76v41SfvU1wt/Hgi9KiKIeMRqSNADKl+XvJhIr9RxPh89oJ+iy2ncaYnWlDiUIpV8eAu94v5TQLQdVgN1RLfavPla4BEQcJrbqZut4+6X8/iPzwtRBrcDC6U5PIf4hJIbHyD3+HeKY3Ga1cnmD119G0xzWMYK4Mx7vDkauURus9jPqLpEK+AliltAyVZHB92z2bQRub+4Bu1QFoW9o8lku/Qecc8bs2oPDdUAMKhUoyUQsUSP/OHAVMvysZOMSW5/vd8rkATdhakWcJ8CZrM9LiWhmlooS7335fTFFyhg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BY5PR02MB6627.namprd02.prod.outlook.com
 (2603:10b6:a03:203::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 17:05:17 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 17:05:16 +0000
From: Jon Kohler <jon@nutanix.com>
To: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 pawan.kumar.gupta@linux.intel.com
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH 0/5] target/i386: introduce ITS_NO to several models
Date: Thu,  6 Nov 2025 10:46:20 -0700
Message-ID: <20251106174626.49930-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:510:174::9) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|BY5PR02MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e3d219-177b-4041-f700-08de1d56a88c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|3122999009; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pKBM4U7ZVJYFoL8nbl+Sva78jHQsy7H5/dNRbEJ5+Nd0Dm8JhS0ps/9rkxHZ?=
 =?us-ascii?Q?rQqjgNr/vZ+kVphkd5obKrZ93aKDjmajVQR+JCyOxXwqwy+HxK8mOigCf6HN?=
 =?us-ascii?Q?7FUBKM3t+goBRgNLS6PAxaK97GpP3/EQBU2Qg/LJkY3Ook1vWb6Vr7ZJf+SR?=
 =?us-ascii?Q?yJGaGl5nwpIRFCsOAY92L3fIw2sY/losCPnrRaCVJJG2QzflG96vPk7WdKEq?=
 =?us-ascii?Q?FJDF4D+Mn07P0pzDGaEhjIe3rgXWH1pB1kw4QC/xcvGZsdI8ZjMKodZGna+t?=
 =?us-ascii?Q?XwaT38gGgcw/Wr9Qeb9HJHh1GeSCsj6RA3PjwINnQpltX3ibwIlQ/k5XLTEs?=
 =?us-ascii?Q?UYkXreIdDHw3ffchyLWnfN5C6X4b9eQMMrqsyPR3fag6YUmb61sDFzdetuqm?=
 =?us-ascii?Q?VWH0ITCwq9/Luuk3wPuROMq4w1xbvwEJmNZSzksA10yVcvMmqZ8xmi4QMWw5?=
 =?us-ascii?Q?V3UEhl7cqOT6+iIvh21dBb4swO05iy5AQlL9h3nhdjZzu10tKsgO7rR5Ut40?=
 =?us-ascii?Q?w/qTW37EXE0JltSeDVtp2m/x709L+1QXHl0POMBfAiy62chm+fv9h1EugqG6?=
 =?us-ascii?Q?vaIpE8OqfWbd7LNTVaPnp7RZCbFKLCRksbzUcp45Em+md5Fp+nTLDwXfbc7f?=
 =?us-ascii?Q?cT6Z8zN+30FmlSbtafaKUadN+ZZiSpd9mhHyqod+1PdTJquTOWrHk79XL0WY?=
 =?us-ascii?Q?0jryFBYR+tAjDd7MP3MQesMsjC4BC28wx6NYFrJt7XomLUpmm/30Om667VLH?=
 =?us-ascii?Q?JzAxmYOHGcdfwB/49YvTPLUZKMMqbZgphmfUlHZ4Mvwy1ySPyOlEu1QCHKTK?=
 =?us-ascii?Q?hHC5P5EgtQEcejMBWn6xXa98ddLSwlJtG3tn5xrzWpqzH5TJATrNJ132i6+B?=
 =?us-ascii?Q?ADJLttzf0q/FSuFjXSLsh1gUONebWeb7xOuPhLTN8a7ZrPdKlH5bS27AEKlM?=
 =?us-ascii?Q?4rRcwCRb2D95hJ4t1LD8+MQN5uWIdnehPhdYGv3LfSdA/i53GeVzs6oABhBe?=
 =?us-ascii?Q?YEDKMS/AilkOM/WViH+h9PvSrwnlEZrZZ4sWJpaBi6qWrDE0Ug3Ma90zsxEF?=
 =?us-ascii?Q?BhTUOTwg4ZdqC0csFivMIZzDIp+0eSL6cq0ym/s8VltXO1dcVTOMIX25e/9E?=
 =?us-ascii?Q?GZUuRiq4iD7ABfclje9/T3vkxVMzNS/AA1Xp4iNmTgkVZV/i+XfboDRPv5lk?=
 =?us-ascii?Q?Bq30esBJ8Q3ji8xBKnd/JEwZcbyIMsMDjWZ4++uHwwZyQZpCZHgdzmZYshLx?=
 =?us-ascii?Q?aVbyaPimy7L4ceYN1WGCBI4RVWqOFVAIs/85MvIYqYhDYFNzftc75FNMhmrZ?=
 =?us-ascii?Q?OtD5Eoh/nsmoR5BJ6Wj0+bd61zReEzQ6x0iQttQ9OACm3SBdhSf+qeAbugEJ?=
 =?us-ascii?Q?NwDzVO+vF1rymXmd6wkehAJe8caTTS+kFkwEMrnHjO7HW573lSqHw19KXo0A?=
 =?us-ascii?Q?A+e8FBk0JxM51t0BcuGtzEDyRYizu3iF1AjLqwNyBtrKwkTXNEGfZYgd3li4?=
 =?us-ascii?Q?a5WIjNTQ4BXNvCaCVj8IeSvykWxolB77BhJv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(3122999009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hx76+KZL+5sDXo8pb84Rn57AWMosf+zdduh1AfFYmFq4vY3RBxS5HGUtLajl?=
 =?us-ascii?Q?zcBVyzcF4sHZssLuAcOdMnfZwC9OTPEJHqoy3MOwGpsWIFQYOqh1F7eq4RqH?=
 =?us-ascii?Q?blClu4XndxSzJCKfxHwrq2rIxseiFDxJHW/bNlO4+wLWoDXOSAuTdohkTElU?=
 =?us-ascii?Q?IhN27665ZpXm1DbT3ZMv/yvpYe2fj5GonlORP/mTm11RVX5NGrlkLlCGaPbx?=
 =?us-ascii?Q?mcWQjZ8uaiFh3zHyu0xbMyOWszMO7GG56MLFdSIC4IK9qDlSKazxkFNJFUMN?=
 =?us-ascii?Q?klNvYWhmHCpltSvUMbpVMWs0gi+lOS2ABW1v5TKa4/cA2kSOvlQjoGyxSflp?=
 =?us-ascii?Q?UqAjDM34oFlkneyEIxJk+QXeZ88aEzUNygDGH4Ae5xrTv0gzttXd4tsf7F9Q?=
 =?us-ascii?Q?5RMpJXndhUUoWqt4+JWpir2IMq7OAazFjchXxRAhiO5tacLkw+kRn3ZobjMc?=
 =?us-ascii?Q?G56KI9BLSKQANcgaxN+J53zaN9P5Y0gl9oXSCSlShs4yB5eZ23l6rkXSjHUN?=
 =?us-ascii?Q?ISECG1QeDt2TaIR8YDj2jCnM62L1NGRjyGdWKbZnXVVQB79smIIQ3cbDekOR?=
 =?us-ascii?Q?zM0kXf1Z8G+xAJ2mjReH8LblsoI0D4WO3HonH9iwfpolNlsoJdt9031XkOfg?=
 =?us-ascii?Q?4nXe4pE0LEJd5vgkxlzUSGZbVKUU5jnZl7b409ksVJgy1l33YFO4aFDZqMmp?=
 =?us-ascii?Q?Ct2KvKf91YS//SynBql5wWaP6EcSEqr4cQJLZshDWSXybBe0CcX83eobBFwC?=
 =?us-ascii?Q?fkUxDdZ9XKoAk98hI9gfWf8E2v4A+5yU+BUvahcNOWY0DNnP5566OrwrPbjM?=
 =?us-ascii?Q?m4vF8mcY/8pYE/5LkiERSlLi1DHf2S4Dx9uDVUqIN2aidnih7zZbleNw1TDN?=
 =?us-ascii?Q?tlHFU+pYZYCsWzPoHVUh9z0D6GWAzmHuQEjTBf315/ixLkwAsv05DLqYlpZe?=
 =?us-ascii?Q?Pb+h+1TB5Q2aE1sXcYNxbfiSCV4dIGJ3MxCLkhz+Zu8x65sD7gUuIfO1VQt8?=
 =?us-ascii?Q?U1Bm3kzsgYRQAlo46BVO8n35JymjRhB5C95xNR9+5//9dbUzCd6840O/OoNK?=
 =?us-ascii?Q?hl1lQmpTZ5KXjbutcyFt3FSXLuw3g/Daq3sQVE1n52rhftC7qe3xRW0G/ScW?=
 =?us-ascii?Q?rrfx0l6ArH44PaBQJXGUCP3heFc9h+DVzh4BMG35z/4l5LMBFdHY2Axeu2Ye?=
 =?us-ascii?Q?aX+/khF/Pg8/a4vA2h7X27+aUV0mVfaOMhAH+vN302XlFg6fy19h71z1CyOX?=
 =?us-ascii?Q?G41GwnKhkmQbo/EofpJXDqFB0xeMVzye4PibfCbWmrQohFDtfYmLEPgXthiM?=
 =?us-ascii?Q?9VT5oDHD4bh1lU82dWghZQHbqFhaeEGsFXZev9V7DJZ8PJUdvcco9Q3gHWHW?=
 =?us-ascii?Q?pVHo2/nS2n0NfTcy2TZy6GQMb9raf0DdMAiX075tN2SNvTooSFwcAc5Fpkd5?=
 =?us-ascii?Q?TYQjx6vpH0hvMBoLwvNZ2d+kfoJJmbGajwlppKMKfPevQn9XRv3fOXQ0Ohr1?=
 =?us-ascii?Q?Itu5rUFap2r0rdEIFEUj1ovN7V6fbqVh5eHjnZSp5TwV/YOYNKRGjDKMEH00?=
 =?us-ascii?Q?5RRMnuAgDwe3hklxS3T4j4yG6ihSfMAM/ArIg2hgSp0ytrxby3T7ShNsNc0c?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e3d219-177b-4041-f700-08de1d56a88c
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:05:16.6883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ww11zAi9E0rym6Vnxx9bSWutTQbLaG3l7lzfqFKdGRzg77szt4lzBh9tRYBXHj+TS/FKXPHZ8nEI3Qj22FSNWZcdQORe24oS5XfALIhvnSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6627
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNiBTYWx0ZWRfXyUONkaLUzbAf
 U4d1UCEpNlhDT3rjmwHxQxNX5/B0pBHEtEFZbhYj+Kp0cpVmq4Y/JAoKhbfTpOnKojMNDos8y34
 MUQxd5PnAY9QY7/XqAB49yKKek+5oFiLoUKfZzf6V59DEtlZVD2MYFLUDESb3MRLIMIQ12bUpcW
 N/bQx/55peUhtLardKyA4nbocy3ZXn3r/kYD17mkzWyeL1/jwMyHsfsPv7mtXcXfQOC3jcRre2P
 u48hE/PkiNRLGr7t0eP4KAtq+RBMadQu7q3KwwElg7yNLUtq9TeubhunVHBLDjym++zkXvw7dyY
 P+oFHV66sBwRngCt+UzKzgvLjLsYPPSXj+eLzeYMFZhKuJPbSFEP22XLOUXIKAlalqygKLQ+xE4
 gjJtFd1Bn6b2e2h452WZcQes1GnOcQ==
X-Authority-Analysis: v=2.4 cv=PMMCOPqC c=1 sm=1 tr=0 ts=690cd54f cx=c_pps
 a=RSKkSjVyZ2Ta+HBtYZh2RQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jq8RHUjMPwWjShvSnX0A:9
X-Proofpoint-GUID: xCBTT-WRPlWNyJnN3sYypQu09gteMiO8
X-Proofpoint-ORIG-GUID: xCBTT-WRPlWNyJnN3sYypQu09gteMiO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ITS_NO is a synthetic bit that indicates to a guest VM that it is
running on hardware that A) is not vulnerable to ITS vulnerability and
B) will not be migrated to a host that is vulnerable to ITS.

Guests will use ITS_NO to opt out of mitigating against ITS.

Intel Sapphire Rapids and higher are all invulnerable to ITS.

Note: for posterity, add MSR_ARCH_CAP_ITS_NO bit definition, such that
future CPU models can add ITS_NO without needing a sub version for
its-no.

Jon Kohler (5):
  target/i386: Add MSR_IA32_ARCH_CAPABILITIES ITS_NO
  target/i386: introduce SapphireRapids-v5 to expose ITS_NO
  target/i386: introduce GraniteRapids-v4 to expose ITS_NO
  target/i386: introduce SierraForest-v4 to expose ITS_NO
  target/i386: introduce ClearwaterForest-v2 to expose ITS_NO

 target/i386/cpu.c | 35 +++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |  1 +
 2 files changed, 36 insertions(+)

-- 
2.43.0


