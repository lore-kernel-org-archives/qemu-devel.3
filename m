Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B847ECCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHir2-0005cx-7j; Fri, 16 Oct 2026 10:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHipA-00035X-GN
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHip8-0006kp-SX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:20 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5DbC3215898; Fri, 16 Oct 2026 07:22:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WyA/oexDigpjp1MqIVZSX3oyJADfec6ddFmZwK/KF
 s4=; b=SBxmJgvx5xZXM3qjZUP5KnAN02qD8RBzw3oAeZHaq7E1Icr7c/Sndvj+c
 O6QU+pIPEH69DbM9JRbUnjcWPEYbY8E+tZL7swWVy9cP86RMI8DlUgsDG5n53tdr
 Q3SLeW5ncixnqym/jnelgNii03EU/bk7SeEm3FuH+yLABYFzVnIAYpmq9+7zYvXh
 Lm2EGWwdUanyabvx2zNE3koTCSdQzt2OYN/8C7DslpksLXRQUb9llQlKzE3VWrnk
 loLiEttlmvYwiom29lLCmGibTDeCjM94P+BoGPB0OgXERoYlc6srHqyf043EgrBD
 E+fnCFCZ//h1sL9fR64/nKhheYfNg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020083.outbound.protection.outlook.com
 [40.93.198.83])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hb045k1pf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVoPzWnpIdaOvUhn64na6QlOJ5cFty30Wmk98CA1tsurCXO+F1h8CXuHwTi3+YYfhXvQ3wo4SAotxxdBWFzOuqVx5g1h4FOKkm3l9QNAHt1S6wZRzlhEaQa4+4pNKMz925h7ZNbANCJH5NaljOpwQRl/W2Pa6GlwPHt7cPdZnsb4dA0pKoaxsQMUD5bhPhDjieAB/N/FnvA4AByZ4YZPiibhH1JnjsZ4i2magfN3FVm7cH0DlP9hIwznFrc5WP4vkmOD/5wh0ixFDBHcoP+arEfEJyyRkL86e6ks540BW5NferSlORzlFIvBqQE0dzImAtqGnBAMAT37A7r0dg+HOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyA/oexDigpjp1MqIVZSX3oyJADfec6ddFmZwK/KFs4=;
 b=zOQThd3PwuSkIvrmMlZSSVdvXWJFHrnsz+fHvdRKEZGaG5ZqoTeXlfK86qOU/wlwVyAlyXpY/rXhHIoIBEczN7IKuag6F2QjsJjUopHXB7GM/QgiG0IQ4cHJOLu2LBAQfKUeU4zgZB7YX7hTISzJKswg4JIV6EPonB3dF2ChA0k+L9hzvP4S7wSmxUDeZfJhRg4C3p/Up3mU4Sh4+ivsZ966GC2uscFAIw2V99ieL6R03aPKTQhV7PlCPt+gyko0cBCfExXTCqRWji0avHCpmWMZmE+XgLF1n6LBDpghY/AdGOmm+C0shFEDvmafIoC72M/xlTBoL9M9n0jkU/HLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyA/oexDigpjp1MqIVZSX3oyJADfec6ddFmZwK/KFs4=;
 b=QByADjrZzoqlF1WdJ+gdYu3//EKAiqMoOYLBtloBwXw5yKGMrc7CC8RWnlND3LCj7ZP0s1kM9veoa4JNnFnUrrGbFRn1DaVaW3I2JLBI/409HcwXCihx/avbT62LH9vNm9suci305AqC5l1SPdrvdBjTEDjPKSeGMau+rcmXLK07wOCYmsvtdKyh06DxO0BlN2DVfUHJWwCJUxuh5M+q7+l33jvtbRagPi9k3/S4EceVGgK6RuDwDNPNrzogm5Xssugq6tzqPhZKO347Q5mxXnOXo5qGZnKSo53urj7CMYNoHxFHh7oj/olV627SqL/UMzje/3Ls/rYnuDTVVklTOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9592.namprd02.prod.outlook.com (2603:10b6:208:3f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 14:22:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:22:11 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 23/27] i8259_common.c: remove unused i8259_init_chip()
 function
Date: Fri, 16 Oct 2026 15:19:29 +0100
Message-ID: <20261016142031.1204281-24-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 96844c28-9ad4-4018-37fe-08df2b90de44
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q7COnebCsg3z83kVbwkzUKGDwsBFAcL3mJ/kaxmaWCJr3V9Simo4bEk1egT6rFoOqviGSHfy9gHtlHrsJrOnKSllimq9wx4w9YQxL60zTQFbVh17627fU5QcFyKjmc+DuuTQLPFzgSrq10PaUgeZWmY/dk6zTgY49+Av6lDH5aGO4HMmnBCytKyJf9KqhEuty/IZm0cc1TsQHLFcgg+MO2fs89CM8f0Qhy287Ie4PDz0GMHoDK7lM3s8uqIk94De37zhMADm0+D3Vrynhw1aunZAlxQtGxapg8mVsvFfTx4MHUGjkicttX9WNhLcN15AzrrS8LrwwtyR3rRWAOBgRV5QPtLm2bfwUmN1HztJ+lMmHkCVrTLv6xY0saqpqVnT/xNDbR/tinAuQRUehgb9sd3ba6RNZ9fvWKVCC1KBgM1LwhRi82SkXjUPrNTMM9lx4xohxqJr+e/k7k3I+CR9wDRAtMNxOIMcdvuwZjSL6K05qsvOXZ8GgAT+1IHd5QnsW7b3rZDAWx58ZBRaJJIwZMhE4dnyfcspPFUtZ3VgNCDfSWcejeHnN5fw0kEWp2fhAaF7DhJG5Tj6GwI1ojKXOUzwsnHXw097xu4z2b9UKhQiTR5IpKc1Ao94sonjqeh1hS6qFep8Z2yMHzJNNsAnVZ5OVcsX0pAemKSjmG/Sku8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1r9g4g7/cBPL0WZlWW7OBB5FXXlA0THp1xxRcO6hZ7B8IdcLp3gpfWOcLnz8?=
 =?us-ascii?Q?ngqibE4sFm4rwLO2sBukq8SURqB2Wy6n9MHWObvH+apvhoT64qmKeOtBMfpS?=
 =?us-ascii?Q?t9pUEj8DC46PNrCXM1d2V2PRWJLTM0o7xFp5qbXT9eiyhcvnK8c/vmUi4ZJO?=
 =?us-ascii?Q?PGl5bVUXaa4Er5/UhCxl5FKzporPG1UUqKSP90LBJeW+rdQGRspOO9jUmIsU?=
 =?us-ascii?Q?sA1JrOQvaRjD7BUin6At8WOsBfZ8s5bgOAJb0plLVvXRsBULAF2OXQI6tCCX?=
 =?us-ascii?Q?8Xm36TF//AIFtUwYiPaNJpENDWDVsTElKN2+zroFafRCo+RGu/ei3nNq6cAu?=
 =?us-ascii?Q?sZfu6DYSoZm/CD8x1QtdRipHg/AV/2524X1umqpKZcTRuCZqMKnDqVXdXDPR?=
 =?us-ascii?Q?4vNWERVxULeJPdLoAskx8nKvq9hKFntCC3kcSNwLwaAAXcfKK9WMwDLwwKUw?=
 =?us-ascii?Q?9cug8fErEClOperNsqYEw/vuq+P3iIDDuDLbhXxtlovaeyGeqhSRIim0UXpn?=
 =?us-ascii?Q?I2oVbd+c0bgrT4qXRh7zH12NjiN6Who30kSYYTSEIZDILHQvfPVsA8+MNokb?=
 =?us-ascii?Q?OdAS7b6e24vAUHhap5Feendm0lXha1eGB/K0gtYUtkN2rPEewsv1TQtf7rVs?=
 =?us-ascii?Q?xTbWj1//EECcLao+y1yZ1Wihi7Q/573Dq8OGUZAskCuzx5RBphiPXm4LOM2x?=
 =?us-ascii?Q?ZkLqVT7Sxv3IwMQ005cTqdh+bm9zjq8i2ytEVqYr8WaJqI0b5xDCYHsMbrXF?=
 =?us-ascii?Q?XSbMH5IMaXhyvwogySRNnqAliVEJO83Kw8uSZPVOep3sv5fPOksMz8O6SBOi?=
 =?us-ascii?Q?va/iOyMo5uvE2y/1ogl2MVBfjYNRbOVzMDONrJKLEyuV/BI+aUtBDfEfYwCs?=
 =?us-ascii?Q?aFOkVr0JYoAx6pKW1f6EqDRLnyU95dLAx/s+EA+Vy3kAlo4+rwdSN7BNoNg1?=
 =?us-ascii?Q?BZtr8Hx9wwIlKNYXJIloxdX6EDOaeZwmYP8ZJwIVkRynLIR6twer6ZS3rHE7?=
 =?us-ascii?Q?r9EC2Y4L06SduUzfXMmt7q2G1oERONoqehWWdrQslJ7SFhGwBmObkEyOczZJ?=
 =?us-ascii?Q?Ps69sLYXJRrv64XyRPJss+HwQthMcpI3st0cycg3RXRSG2x5pZ2eiT/U5wzc?=
 =?us-ascii?Q?3JMkQawXmdLTBLguJoRWfp0oq7AO7RG936+ZdIQvmhNnERXXLYQc37qkUFDu?=
 =?us-ascii?Q?S7OHDss1xhXamxGqFkce183au3bw/i60eb4zhwDTZoays1QMsZ2Xrxh3W1Ix?=
 =?us-ascii?Q?5knRYCwAgvOfTlX5kkjQxxRmY5wvENyIXJ7loutIXlkDLirFEAB7w1K+Ntco?=
 =?us-ascii?Q?HK8i/TRio4HXDePVPRX3C5tauXStJY3I+3BYasnFSKO9TtcVzXCu3aNJGYYN?=
 =?us-ascii?Q?5BjIl1n2Uz6G2pTWdi/b9qiGDCoiQXnI8kiPzdYHpsle4iuus49TvzMtMZuY?=
 =?us-ascii?Q?MfrSvaZFoE4f4oFMB0pX1/mcdNdu7btxSBneNIZqNHmNvVFA4bPMDo4Cq8C/?=
 =?us-ascii?Q?OdeSGli/FyDkgoLBEoauMLCeOaKGnbE8nUu9oi2xweFj12R19cnrcPgbRfAB?=
 =?us-ascii?Q?T9GLHJ/8Gbh2h8DCbiS4IShW3F6mduMFKy84gHTdMJYtOcHo2i/GBk44vV6f?=
 =?us-ascii?Q?MwYFtOKwLhGC/mwpZ3xqKWFDX8rIn+hnY/V60eiXO7HFjjR8yVR6bv3vc5wp?=
 =?us-ascii?Q?O5IlQJGGHDVVnOUCmCFxM79XuUlo01hsG+yVwEHUBCTJv2NIo1p85Ul82DVM?=
 =?us-ascii?Q?3JS/hk413vHQ4wMmIs9vmlMYHkQLHtI=3D?=
X-Exchange-RoutingPolicyChecked: 2K9/yUrrDwmP+mPI2UuTQITLmL1KV3A1zhiVxa16OUdzVxOr/9OjQoAlL52m/C8UQwBjto6JxLsBkDFynguyl0i2n7mhlXXHAFtjsqne1+QHnsUYpSOH69Qtxi69oYBcunI3I6MrA1QViFJkPGGhXeAaLULScw9GnCiBB1yNzMh34g7HnT4xuZWUQ3RmPortGyAGy4ofQhxMmPm3mFQ7KcXPjiffnQRfXOHa4tt+YopZL2kg9lY3J4eNPro/3XfNGi45wo9Edk/D42DUT7ksCJXhSUkVYSPC5P4CFm4pJl3idyWrP/wHFdf4nieyZYW8g+tUwuPSaQDSPnLk8tKYAA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96844c28-9ad4-4018-37fe-08df2b90de44
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:22:11.6876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvuMI4TcOTeJlGZ6HIK47l0hEBMv2k0KafEWGZIaGMhOpi7GvWAJKd3c+l0cDvC+gQhioPVSxkPDexMfsPd++Mc0eCXeFL8pDp5D5uMWPgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9592
X-Proofpoint-ORIG-GUID: ZlJq7WZujRoX8SyiT5TdjBPyIii0Ju6W
X-Proofpoint-GUID: ZlJq7WZujRoX8SyiT5TdjBPyIii0Ju6W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX1roMPiOyHGdr
 O9iHYwYLy4F7IwiRCrbcCJYmmeiyI+aMzmFoDpgB3Y0c9gAIoHQ9/G8Myi/DSEewqNMWn9yjvW2
 SjFA7jESMSjiaire3UQUe2tVlYUs7/fUHIFQF+QsFDjvfA28jBVcEU5xvb8rTXxtROVDYqbrBro
 Tlqt2vF3HuxZeCrWPWyJGm8rVNUI/1FSGLVuQngzu6PbbDxiVk8YH7WVNFSP/MJlPQQHlI5Tvqj
 8lxgWGyd1R649A6ypjEfJx8iycEDgp1JgMLsWLwqEq9gnlcv9EGhlkDppzEnXT38nZ3mYFXwCoe
 a6BniUiEpRNMC/StsjRflaXXSkm9/Pmj1epcDOljpb/fRW4umU+IOoMDk01OKi5oMH4qtT9Eas2
 k7hFD6ussMrN2IkNNXEPrXcmHr4Ga8V0C8kb1SIk+l5hMVnEhm7+WVuNXW83BrW8T6wPOYdoW7z
 gicH6EuJ5rasYxrbc4w==
X-Authority-Analysis: v=2.4 cv=V/ToQuni c=1 sm=1 tr=0 ts=6ad23315 cx=c_pps
 a=N2BSJ/IBjBq6ipLGDtrT5w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=fn9E0C1quIHmE1dKZfwA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX1bsxiAzDK1+J
 /G2VXPlINswXk0+wq0e/enWmDQO1yvfogtMVdu75wFHXJR1y8dm2Ul0qgIy+VIJmC3Rv5WA/FB6
 FFXeRVtpOyVuTDlWHTLMN4YpTHZqVdg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

This function is now unused and can be removed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h |  1 -
 hw/intc/i8259_common.c          | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 644508a44e..dd255fac24 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -71,7 +71,6 @@ struct I8259CommonState {
 };
 
 void i8259_common_reset(I8259CommonState *cs);
-ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void i8259_stat_update_irq(int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 09b761321a..5fa38fbc5f 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -89,22 +89,6 @@ static void i8259_common_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, cs->iobase, 1);
 }
 
-ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
-{
-    DeviceState *dev;
-    ISADevice *isadev;
-
-    isadev = isa_new(name);
-    dev = DEVICE(isadev);
-    qdev_prop_set_uint32(dev, "iobase", master ? 0x20 : 0xa0);
-    qdev_prop_set_uint32(dev, "elcr_addr", master ? 0x4d0 : 0x4d1);
-    qdev_prop_set_uint8(dev, "elcr_mask", master ? 0xf8 : 0xde);
-    qdev_prop_set_bit(dev, "master", master);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
-
-    return isadev;
-}
-
 void i8259_stat_update_irq(int irq, int level)
 {
     if (level != irq_level[irq]) {
-- 
2.43.0


