Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AEEC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HeN-0000m0-Uw; Fri, 25 Apr 2025 07:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8Hdp-0000FU-Tu
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8Hdm-0000Rc-TU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:49 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OMDC5E002614;
 Fri, 25 Apr 2025 04:54:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=T/Z9In6gXnmY9SNsrZmmhD/hJJptw/wuExen7uGaB
 Zs=; b=DRJncDrQ4M7cJn1GqTnZjw64oJ7hOrRLOx8wq+isejt9dgucm/rwxSJE2
 LYleqcmnjQdKOHhK5PiKtaSA2s5/yt31rvDJ/no9CvbIA4g5MMQhRfMxQc084CUg
 tXpwtDnL61aZXrKrZqB/jF6JQfe7zLN2YQS3K2bC2Dm5770OygIPNOGT4LxB9EDT
 emNeitcMFpcuSldBjaAgCmCfpKke89xX8a7MzI4/V8mhPrcFFfAEhSRyPJW+3yIF
 8mOFhQQIrWgn/9+Rlax0+5aUkwSuRj3zMHLcfXNFl/82z6H5ylbw7eKtJZJfm0Ie
 duvVsBtUSuSRdC5UlEVnHf5KnmXUQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww7s9v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIasdrVC6IKU6iwFWoRjao+Rvti5viZkdI0SCIbDb56Kc4ekONpehP1Dl8lLhuUmqiUGpHbAGm7u8rYhU6yaldGjMnp+VsQDrXTLUhuTU+ndLbXaLNCpulaKKH9o9lyXmx07cQOm12/1esiSuuB5wq7+MFydjusOdn9ggnF6sMKzXCcp5CJNnjzzoo3iZavgOliT3E6SqkivJBdYdKGMbwF+4o06qNWk+29WRNZTm3XILoscYDzXstbgkT3VzXTuU85tzLhU7iOyS+TAO1/oL0aXk1VaPm/CahLkrb9eotdHeNkeLvTjnZsKHi4sb7c0yNwoT1aeHAFdmRa61ZXIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/Z9In6gXnmY9SNsrZmmhD/hJJptw/wuExen7uGaBZs=;
 b=anfUwYK1gGMCBtqiHdNS81BxJBAVGgv+0gx0Yorg6JbejnAWaSh28UNzSzANMtshuC4U/3uf3FBANdoZz9f3ykvRZDvX1r3VRAe53xG5EJrfJCAKMIWNXe4KNMcP2bvPPuOdFI02miOisUWMzMW8ZyxcHtHdK2X00ib1gbTa9DeJ/YQig+FIizklUtxArs3oyZMpF56j2MF/yWnogIjbDzj/29SnlW5vL8zJ1bfC8aQSYg1ZoK86FF6R2pWaoZP17DEGeBNeFhfA9t8KnfJWvXJcZc/BG21JCCXB/3w/Ux2h0zML4QgU5hEBY5EktvVr24Vo0/+zR2rXgMThEJGnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/Z9In6gXnmY9SNsrZmmhD/hJJptw/wuExen7uGaBZs=;
 b=n2G7TyR2c6oDpcHz3YokAikDrfbEa5ap9mLpBC3KJHluJrw3CUWeFXRBzzg3+6zBoQMwBtvVwmvDiXoVMHJ8wVV/luNoAmUifQ4dvBim/OvFio1ietZiZYtXenKS5TFcWJ4C9dpss7yQXIWfjoQg9jHR+s8z86r40ncNR5yhjSU3LVSyaAQCmiitRtg+nP3AP/qLEU5sA8Fd3e5KHfc7jsVZ+KhDi0V1MscxqezX/yLDc/ZBfUAQh3cXOLs4cZR0+Su3+g4n7G0vWfS7UkCZ+vYFZGbQYiafwc2aoSFcsIWasLDcjypsHQOZ9EJwPfh3077JbTCiUV48vdESbmCzpg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:41 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 12/12] hw/i386: move isapc machine to separate isapc.c file
Date: Fri, 25 Apr 2025 12:37:59 +0100
Message-ID: <20250425115401.59417-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0156.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::25) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: abe46679-001f-4093-991a-08dd83eff632
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VlCGvu8w1dc8rizugdCYP0CB+hQYj+wR+JBjKsOITQwzci6//6tmhUU3igvF?=
 =?us-ascii?Q?oQLyRtgt0poA3bVUvrzrYe0IkviG1klhUvddGHK0Cto1KaLrNPjOydgSvvTB?=
 =?us-ascii?Q?VTgD7hTyLRwhap4mkX5q2iEvJAXFvaNa4PYkGFKYPrFh8TMmlz3UFHl9Qn55?=
 =?us-ascii?Q?C6PNoBar0G9s9ZkjW6l5pTvapxys0MfvwGcxZlAMd+PjXVBndpO/aaUVN//5?=
 =?us-ascii?Q?u1k3ubSKBJoprxquxFMg4MbN4X/zR+jY6/arkel0rGYPXNlCs8s595agZhwi?=
 =?us-ascii?Q?IOwXkCiOJudeMimZskrK8YnoOFoYc9P/+gEF3cd7TW+PrKOlwHQDPJP1W1PH?=
 =?us-ascii?Q?kWO9nffhFxH3VTr0rcv5yF+PYkDWTG4MnAl/3l5Vqh9B9jcs2C7cO3G3SqtN?=
 =?us-ascii?Q?DJiTxrYFTNfiAYLG5ALDJQOxo3PQFIae3xhx3RAw9RYYlTUU6Fbkf5AU93lh?=
 =?us-ascii?Q?TX2vJlVUb07M7e3h52RhawnHcetCJ5Jywz0E+rEKRTu2oWdX5rvxvptmjMTG?=
 =?us-ascii?Q?oD+ey3haQlumv3qbBSBX5z5x6V5DZuSoGLyYeDlT2c8XYC6lUFYcCGzhAwpu?=
 =?us-ascii?Q?3AgG/hjnmW7CgSMvAuUBznb+rVtTCmqwhQPFUsqLFB7D/ZgyAZMX1vWOc9fc?=
 =?us-ascii?Q?U6XqpfJhQXL7bRLogl19FcjWXtQkCwnlZ1n3Fij8JLTJLxM5mBP2qAAkqdM5?=
 =?us-ascii?Q?xRyYlDSwBtTT6RlqiNId/OFZET4uX6qMI1RoVDo1Y7DWzDGH4F+yvDwR/coI?=
 =?us-ascii?Q?Le0bfZH768Da/XFY2AMxKHKEro7WTW0VnMAAlFC9+l41ln5ddy6rFKOojeYe?=
 =?us-ascii?Q?nVk8DKGSLkM5e06qZA++2Y+aO+SBrJx2o24oP1qyMxN48fbthIRPnqCW3ZYF?=
 =?us-ascii?Q?N6k9ONIqdqB9yriv+bLd9NqPvAMKLHzwGGaqpTHex+THY5Q3i+RtqnUmRvn/?=
 =?us-ascii?Q?polKNTwdXrcY3zrGbqwjOV6tr0u2XHFSjVRzdoypu649QoK6pTpwrVyI/58p?=
 =?us-ascii?Q?6tA/r+5/js3448MxzaAALF2cpby2aG3oYqwhhfC23otDCpUweF44vAkqOhxC?=
 =?us-ascii?Q?UAs0fUC7hipDFv8c2sG6VhfKuchXRE32JlgGDfxLIlSmUOZ60WwSZZ/rZHyy?=
 =?us-ascii?Q?5AuihQ99kUd/Yk7wjd+U0FlGOxRNXxE+mhclicQPo+0+I+i0zXy/xXGDalb+?=
 =?us-ascii?Q?yRgamYB6WONPciJc2BTWTc9bqc+0s7yApwVC458ggjLxbh3zTT36jiI9X1Fk?=
 =?us-ascii?Q?O8SMucOOy/itJbSomYkFyUtBJaG1DxwNisv8O9jB3nWS6GSM/4S6pXYcqIGc?=
 =?us-ascii?Q?UpH5r+um33JtGj3bjf6atsMJlhqecMrq2f32tjwFGgfjL0C/imEzQG50cMOd?=
 =?us-ascii?Q?pNvJNiwGoPLn6F2OMOms3sweCHqSUdcTfcGla6/45/OCt+XcLOtizYY/qeoR?=
 =?us-ascii?Q?nXPHFpU6dSE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0LN+ijqfUVas6Au1ioQb6BDJTEMKiqiFaumgthxyC2j8aGrl4G3gzQKhNHB?=
 =?us-ascii?Q?Wquvr/CvOxtTDx80Cbf5D+O+ui0L043PsPZb+ZqKcOftMT7qAobt7I1KY6YJ?=
 =?us-ascii?Q?KUJNU/2ky51B5Yms7ZBw1JWpxEUaTHowuY1fBW6GdRc9EQKKC4iPp4SjrGo9?=
 =?us-ascii?Q?J2PYz28Is+CYe+lBk+Q/UUbcWXoHbazDr3bHUsL7Ycdj4pzotZOVybV+YZsi?=
 =?us-ascii?Q?WdZZoegIBHVB3NzlMY0awzb/0QphGvuT63eA2N/hY40hnNz3lpSawA8jpTXd?=
 =?us-ascii?Q?W2vEIaqNY+FuErfwIcPEsZUFVLpLVVoUTnPe4OZ09JFj+EoYA+DIfy+bB+ET?=
 =?us-ascii?Q?zOpH1xr/DP5QuSW/yq024IejbOJjETkWzJyLfGN68SM5gEvwFHZp0+5dYpql?=
 =?us-ascii?Q?sjFyN0LpSkhfaL5nvkJAae9cFDBIw4fmDbMj3GS+j0rVKG0Bh/GT7EF0vVdt?=
 =?us-ascii?Q?CREowB0R/jsl0sZW8OlsGqoNX8kk/FZTbrk3zt/fyievOm5uFp7jAAfOyTjx?=
 =?us-ascii?Q?/IZJ4pUVk7H9RZBEFeFxGBXj2xDjS3Y3NyqAegxGm9sHy07bLDiFX8/7O5rS?=
 =?us-ascii?Q?kXK7eC2F53BCV6NuaWx6Wyn5lk4F4swApL0c3DqB4iZTKrNtTTuCHYoBxyCz?=
 =?us-ascii?Q?UKndVsyU5OMnvCkWTjENqhDYDa/nNxxrgwxGTaVun/2TJVFcIcQe74HS04sl?=
 =?us-ascii?Q?YryoRGMeaugX85R/lcPo08ifrWK4vhJX1Yg5sEYWOn/yQuKSAVM7Uuxti90y?=
 =?us-ascii?Q?RKXRr3Pu1ulG/JGBOU3QGoM7L0BzF1ucyngX8rXrex8zSAQGxu7I2C7XeZx/?=
 =?us-ascii?Q?1SUIAaUFfdW1Zpr6zIXtp/toClDtiOWGJuHSJ7VNhBGrpnKZE8ETcIX16zyw?=
 =?us-ascii?Q?l0GFpFUt0CAdDUf57cloCrAfUiAfZpWKjQosEXJW7MQvx17yTshNxeVhEpJl?=
 =?us-ascii?Q?OJwKAwn6xTeS3RYE3TLt/400DtmvEU+x1Hpy9WuMz2/xQxKhl4fkPoCzsYiq?=
 =?us-ascii?Q?lQvjyE/vyuBClXk1Roufs4SsJGVuIG8U/jnuybxylX9UHWF2eA5ELFfzIw7o?=
 =?us-ascii?Q?H4Wq6w+q7j4l4jWRX36g8V+jdHhRAm+nIrbLpVr/cfi6A8Trn57tjNUBZ9y3?=
 =?us-ascii?Q?R/BU+WkkISZnrbTTdSxFmtuV54Q760buwpKSZFi0d/6t+jOy0xH2EujCsi5h?=
 =?us-ascii?Q?UhNo8/YcazeVoW9surzG0jMtnnnYkztHUw52rpIWobvaDRfehk7muIGS1zap?=
 =?us-ascii?Q?PNh+dbtDYgUbKJNyR51HG1/UErIXcfU7nfKQwe38Y26Sy5MUCGImoOxgW1Ze?=
 =?us-ascii?Q?F+1cymgCEvLPl9L0hZMH5wfR2/C7hIhz+rCfvp1pce6hV8rgutGMvGX2e19l?=
 =?us-ascii?Q?IyCsUpuIsFjraKKrGZGpLPZ+08pz91/Q/XkJq9asMu48fVyz8KCT+9XNHV9v?=
 =?us-ascii?Q?Byh+HBjYtQeGYTxJtb1x4Ea8yf+qTwHT5IrDd08+NzAN1g3olYEysxGVGMvE?=
 =?us-ascii?Q?8kn/Bxo8RsuENZuXob2gt8h0CV6icw3OKJaDeUVPfDLivV0sbKwJT59yYura?=
 =?us-ascii?Q?9nWRcaWzcP7Oa6IuIQ7EWOn6NbgaHe+xf39WTcSuOLVRoAfmFamWJ9FqBZsG?=
 =?us-ascii?Q?TspYkXNb2ZB6oRDChde36JqUWD+z5jcmhmHjqwQxJMtMxYHLDlOVsLxDLzwn?=
 =?us-ascii?Q?SB49Bg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe46679-001f-4093-991a-08dd83eff632
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:40.9322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+VwHbuVE9IBruG6XWgmJDw3sU+BgJJdIYhkU1SoXnkNSyq0U74T4sKM2pVNq4ikFH4/6tZ8nLnmqVJuFEgK7vCvLtmtgQ0vD3Zbz2kwE7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfX7MiXiE7SjUXJ
 wc4bNtCZ4r7N5WScZKxAGttBYb4GnJVygZzHlq3/KVedJDCxsAvz+e7vNJpg8cJri2OQSe+hkXu
 aEGXo5joFYo1Sc2N+2Vrcv/v4FMtzJFcCNmaxm+8JDYklGJQfuGocwvhfhJnQzMixzfppf7/yqp
 VQbxLE/VyCM5kw7WhXxJmvctlm06lJqMYDNtyX3+edXjOM4H87+Hv/kMkRrPOA2JtEUyNqi2VQo
 UCrWlnJ7cy99ydTapboL+qRM78PkmYzbLY3kRLfGtr953Au5hQgEZSlPrdVZ3Ss4LOsdhXN3O/J
 Dj68Z+c9a1mAA1RHIIIVhy9t8ersfWwOa67s8Leu/jACb/Dq9Ecim2ei4R/Y6S1AlOhxsnm4ukK
 xZAta3XYnuuaH4l7g57x0o8TuJmt3WLu3xAv4aMaM1Nrt55tck+9mPxbgMH0IWgYsIaE8pF2
X-Proofpoint-ORIG-GUID: mMfbCl4hoxfsoOwTllFvLcZY_CkaGyFy
X-Proofpoint-GUID: mMfbCl4hoxfsoOwTllFvLcZY_CkaGyFy
X-Authority-Analysis: v=2.4 cv=ZvrtK87G c=1 sm=1 tr=0 ts=680b7803 cx=c_pps
 a=BALyy5icRfvvzfOMzojctg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=PTNn1_KP_szlgaPjY5cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

Now that pc_init_isa() is independent of any PCI initialisation, move it into a
separate isapc.c file. This enables us to finally fix the dependency of ISAPC on
I440FX in hw/i386/Kconfig.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 156 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 117 ---------------------------------
 4 files changed, 157 insertions(+), 120 deletions(-)
 create mode 100644 hw/i386/isapc.c

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d34ce07b21..8cdb1fc414 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -90,9 +90,6 @@ config ISAPC
     select ISA_BUS
     select PC
     select IDE_ISA
-    # FIXME: it is in the same file as i440fx, and does not compile
-    # if separated
-    depends on I440FX
 
 config Q35
     bool
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
new file mode 100644
index 0000000000..e6f261fdcb
--- /dev/null
+++ b/hw/i386/isapc.c
@@ -0,0 +1,156 @@
+/*
+ * QEMU PC System Emulator
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/char/parallel-isa.h"
+#include "hw/dma/i8257.h"
+#include "hw/loader.h"
+#include "hw/i386/pc.h"
+#include "hw/ide/isa.h"
+#include "hw/ide/ide-bus.h"
+#include "system/kvm.h"
+#include "hw/i386/kvm/clock.h"
+#include "hw/xen/xen-x86.h"
+#include "system/xen.h"
+#include "hw/rtc/mc146818rtc.h"
+#include "target/i386/cpu.h"
+
+static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
+static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
+static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
+
+
+static void pc_init_isa(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    ISABus *isa_bus;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
+
+    /*
+     * There is no RAM split for the isapc machine
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+
+        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
+    }
+
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
+
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, NULL);
+
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                           ide_irq[i],
+                           hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+    }
+}
+
+static void isapc_machine_options(MachineClass *m)
+{
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    m->desc = "ISA-only PC";
+    m->max_cpus = 1;
+    m->option_rom_has_mr = true;
+    m->rom_file_has_mr = false;
+    pcmc->pci_enabled = false;
+    pcmc->has_acpi_build = false;
+    pcmc->smbios_defaults = false;
+    pcmc->gigabyte_align = false;
+    pcmc->smbios_legacy_mode = true;
+    pcmc->has_reserved_memory = false;
+    m->default_nic = "ne2k_isa";
+    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+}
+
+DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
+                  isapc_machine_options);
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 10bdfde27c..2f9315a10a 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -14,6 +14,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
+i386_ss.add(when: 'CONFIG_ISAPC', if_true: files('isapc.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
 i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d165cc9427..1eae11609b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -410,99 +410,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
     pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
 }
 
-#ifdef CONFIG_ISAPC
-static void pc_init_isa(MachineState *machine)
-{
-    PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms = X86_MACHINE(machine);
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *system_io = get_system_io();
-    ISABus *isa_bus;
-    GSIState *gsi_state;
-    MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    int i;
-
-    /*
-     * There is no RAM split for the isapc machine
-     */
-    if (xen_enabled()) {
-        xen_hvm_init_pc(pcms, &ram_memory);
-    } else {
-        ram_memory = machine->ram;
-
-        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        x86ms->above_4g_mem_size = 0;
-        x86ms->below_4g_mem_size = machine->ram_size;
-    }
-
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
-
-    if (kvm_enabled()) {
-        kvmclock_create(pcmc->kvmclock_create_always);
-    }
-
-    /* allocate ram and load rom/bios */
-    if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
-    } else {
-        assert(machine->ram_size == x86ms->below_4g_mem_size +
-                                    x86ms->above_4g_mem_size);
-
-        if (machine->kernel_filename != NULL) {
-            /* For xen HVM direct kernel boot, load linux here */
-            xen_load_linux(pcms);
-        }
-    }
-
-    gsi_state = pc_gsi_create(&x86ms->gsi, false);
-
-    isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                            &error_abort);
-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
-
-    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-
-    i8257_dma_init(OBJECT(machine), isa_bus, 0);
-    pcms->hpet_enabled = false;
-
-    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
-    }
-
-    if (tcg_enabled()) {
-        x86_register_ferr_irq(x86ms->gsi[13]);
-    }
-
-    pc_vga_init(isa_bus, NULL);
-
-    /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
-
-    pc_nic_init(pcmc, isa_bus, NULL);
-
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < MAX_IDE_BUS; i++) {
-        ISADevice *dev;
-        char busname[] = "ide.0";
-        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                            ide_irq[i],
-                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-        /*
-         * The ide bus name is ide.0 for the first bus and ide.1 for the
-         * second one.
-         */
-        busname[4] = '0' + i;
-        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-    }
-}
-#endif
-
 #ifdef CONFIG_XEN
 static void pc_xen_hvm_init_pci(MachineState *machine)
 {
@@ -890,30 +797,6 @@ static void pc_i440fx_machine_2_4_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 4);
 
-#ifdef CONFIG_ISAPC
-static void isapc_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    m->desc = "ISA-only PC";
-    m->max_cpus = 1;
-    m->option_rom_has_mr = true;
-    m->rom_file_has_mr = false;
-    pcmc->pci_enabled = false;
-    pcmc->has_acpi_build = false;
-    pcmc->smbios_defaults = false;
-    pcmc->gigabyte_align = false;
-    pcmc->smbios_legacy_mode = true;
-    pcmc->has_reserved_memory = false;
-    m->default_nic = "ne2k_isa";
-    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
-    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-}
-
-DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-                  isapc_machine_options);
-#endif
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
-- 
2.43.0


