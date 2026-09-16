Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB94C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nB6-0002p3-BY; Wed, 16 Sep 2026 06:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9E-0001XF-06
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9A-00034X-9n
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:49 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G89JCY579568; Wed, 16 Sep 2026 03:45:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PgMrs3YOWMsmiAprS015sI7/c0L9GRi3GbtRd7GYD
 RA=; b=vY36fqt5lxC6fuEwH1Zfa8vKp7pltFM0n9Iwg0F5iqm8eDQwmyGurOA+n
 fhvdXFSe3bDv2L69Uu0IteLjDTE7QVT1xePpWhy9RI5AQgrMG0EMEbY6/D2UhwHd
 cnBjXvSmQdlJKGUA/hCqbNUbiVu2g58AvCuWFqWJwPyMZ7v5cc0YIyVQnUiVo/gW
 SXxQ3PJn3B+9A/8eA0kRToUit2VuBRHh8sry9FI5NljzECjY3eOrl0zC7LTgNzp+
 oDlyvwk+flBuQ9q9S8PoTcDUJm/M4apEi0kRdgS1T9E//EGxfXwpDcjuzCFDIx4A
 lQANDauuTnb4C1uosUsTdtUhWDmtg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022099.outbound.protection.outlook.com
 [40.107.200.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqbtb9ybx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJYii4s4kl6rIWMm9RxkenXwqcrC9+DXdukoJZJVLA34g04luKbApx75oB+hTZQkp8p2aE0mmo93m0RyPcHbr04w2v+ddRsclUFplznyhR7jpBbU/rhBdATBU4jwRmsiiuAlz76a1V+51b2BCLxJ8FZtTPiusu1AV4MQr4UumJJ0JAk7CmB/4h1kMUBCSll0DizjgI+LMOL7Nk4VkLNUkAan64JO1XYdB+QQyFNezUPzTQHOADmAYiZ6F7oNZHKQS0rSg5QDgWsceH8AeDZQ6lZExvTzNeOaE6Qtw7Fym9KabpykP8/HwWVDbFKmoUMWKBeVYO568idRJeTwMdi3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgMrs3YOWMsmiAprS015sI7/c0L9GRi3GbtRd7GYDRA=;
 b=QoTkbPSvqzxBa+qXvsWfw/+VBt+M2DFAWGMrxwBKCFGIEWyuxQcSjXxjzCAbFkUc4fzvPqlVLcb5HTazcgIB3iq5WVLUMmWOal/ZMF4S5+OuhZMqzBnBdULWm6zWUO1SIs9MeH7HId1cl8WQVwpyyCkRLI6xFGAjYdDaGE6UcOHOAxPD/+6iIYQdbLcOTBXy2VrMn+bC1LJUKbxTMFBXUQ5u/hbqlO0eXVws7cfeaTwobB0CNSL8GRrY5zi0Ybhxb3bH9J4cbirRwqYkRwJH85iiUGXYyIPargAtVXGZRBj2ifbzY8+JTM8aygNPUXAf/wRvJp4r9X9kNxjDAH7r/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgMrs3YOWMsmiAprS015sI7/c0L9GRi3GbtRd7GYDRA=;
 b=ij7JQoAfBI0gHgWtmAlxQ0WtqYp1/slc5rY2WZbjSRdWEE2QpIFSVMMFaWjm7HLUyKhKhDwneGZWVU1xG9lEQ4pEtkXXYjEEaO6hjbV023anaPqNGydw9dS5jMymeWdI0OC5lmFMPwZXgxj2mD3d4R26QX3tDpq8s/jBWDVx1HDtRC5Vl721vmjK2svr1v0K/2YILL549VrJMPK0QFDG+lV+Vr/uWDgPleVSCMQ13FAjE21YCf78ZUIzX0l3TpJbTIR9LD4nKx51wL6DvL2h2+O7ebCZQK6hxMHyqA0+q7SwjZNxXYxnSEMOP7W1Hc5J5zu6/Qea1C18H6hDlZUSFw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 16/22] xen-hvm.c: rename xen_interrupt_controller_init() to
 xen_i8259_init()
Date: Wed, 16 Sep 2026 11:43:44 +0100
Message-ID: <20260916104435.600211-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: fef8331e-162c-48f7-de1c-08df13dfa30e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: Aez+eTmH7fj45IrYLDModWIH70IR7c2Z+1lYLTSLIp/9D8YBcEIZ4I+CQ7helSo13ieEem2EqdxSBNuVySdXIMVgg8FXYt03d7ZUa0XOhrxpfdmsYSe/uJORdJ/l0HCBZ+qtACnwDY9JV0w0UjouTj/WWVNFrITHvzt/UO1290t/iqb5TcPpF2sYfSUs7vC+8k97U7zYldLVyrzUeFa0s7CWYmBx8uhvaGI+r2YHskytFI+V926SfYx45VQbfI+T+6Q2FqRrcSI2wEE8Ivc7OriOvEhoaiB55CcKWIFqt2Cib/b5aiUrOGr/6TqStGjhpYe0vOO4wTIQ5NPi3dM+crDjx/H6uEd79AfxD7ZidUJed74e9qoDJthR7EVHWCYMxgGfyzqlg+FxHrdYyM4+TzGpHjFpatsBk1hMw1UHKr43blTNgxOuuz0YEDYQVF9wfxRYNMNvjff8ymDE9haetA8vVWDXEkuaTWyrhW7gLF+h2UYedyouV+0vnL+9zYm0fvZAO6khAm+kbL70YNoryBif/43ems+r5aG2w/1twNtVTL96u3Xh52Gz+35W0KSHXS96493Gj4KSQka2a++XUoCRWQHc0GjwLDvCKkeTLoQussZJ/f9G6BKlAsXo37Tf2kZDaBhUTFpHuX9QpVa5ZgAG8QiuHlqVx1A+LGBvJGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U+/UsDcJWmSbNmbYtqssDwDpCHhK017/7VVfUw+uGpU+MyxGx3mnYZCnDRxF?=
 =?us-ascii?Q?r7cgzhQjKydWUqwkEp8p9r+8MWW1+TyL/j4/LoV/lfpXf9vw/cTFggm9eNQ1?=
 =?us-ascii?Q?VGSPPrLHYFwTcl492cdVMUcTQozC42iPwyxC3ayin4GUsySn1sBf5SyNgmn+?=
 =?us-ascii?Q?uwMRwNOenGucrUBczlxDm/agxlVjjXkrbulfmSf1MHtSnBjScyfMeXr4FuJH?=
 =?us-ascii?Q?amlvUvkAQPJed5KDLyzqYrX8O/4ixVeoJqFY3m0pgQYTQFiN+9ItNb1n0CWd?=
 =?us-ascii?Q?+eySU2His+/JwloHaADr7b4HbSBC4N/v7w7Rn2SwL2VJ6x3mxzG3IIKFqy9c?=
 =?us-ascii?Q?eBVB4ySk8AJJVE1CImehYZfeU4Wa9J11f8T9W1IJzHspN2RoX70uG16WiVaC?=
 =?us-ascii?Q?5v1pKQKiLDPKu2G7H91gq40TImJ8hkDq5DJigkywsaGeSt7qiNu/XY0+ucwL?=
 =?us-ascii?Q?Q+Y29hWwijE1w6yAOCbE2zcjCVpfVkdTwkJRenPU9BSx3x2Xh9am0q9soojb?=
 =?us-ascii?Q?BVNI5w/kgw0LNnbptMeY+tzaBBE/555pQ+HSZa54MpgcVLEBYYqnVM7lMpgd?=
 =?us-ascii?Q?YQdGMZVSwd7V0mLB0Rt7wC/umnXWqSWWt1CeXDZGAQI5dXR+PckUUygKEvnW?=
 =?us-ascii?Q?US6mLXkvjGqzlW9F9jSwdFzq5DpSrlEyw+R2EhyBCAOH7ZxsKCPR6vX6MyUH?=
 =?us-ascii?Q?3wlkz/kKwCsoxCa31waviLMRstxLEpCPa20mrC2VmEKKjSBTJj2vxbcpXvfu?=
 =?us-ascii?Q?js2qJ0ijV1PLi4W186C4XC4Q8H0DsY/TcriQD+it24Q7mzAwWcuoI840sHpL?=
 =?us-ascii?Q?sQtMWhYT1KZhk2Bogo8t+ewCLgWba6dldLlYMVwhVWaZrh293ZRc1jDqTfaZ?=
 =?us-ascii?Q?bOwMZrNjLCntRleMVW0GaYrn7rMvAz1l1qu2wBU7ejoEbcjawRHukREOzch3?=
 =?us-ascii?Q?BXSPBHG+eOdYi+W8weAQAJzcfsriUtUvc7nntRHd398afoOWw5SHnXPZDGTp?=
 =?us-ascii?Q?f8RVDXZYQl9zzifhrDMU4Ce6ymut72HrUHwf96LwWICXv8AsFv6qsteqKepV?=
 =?us-ascii?Q?qUZI6GcEhRfSM7biucqtEYscPqcAiUU7p9uffQWxet55/E0aMEMz+1NnOXn3?=
 =?us-ascii?Q?7oVtLfFC63Mzm4T7+m+RJLhJSM4tJfkOt2K4SY0HC+okYJ1Gzb1BVH18jb6e?=
 =?us-ascii?Q?RuJsqmPYweV1fZe/36lhPqiAfVE/U+/8xopHWMXW0nMxG4RKUlohL8RGdn9b?=
 =?us-ascii?Q?Au2mGn6O/OajlDEOArZLlG4mpr/BAquEEs6GePXjCeUm7ygostPx7Oufcmgv?=
 =?us-ascii?Q?hw4R0diTvGBGe/0A7X06mKVtlYcE/hjdTo34FGZRHC7H9YYRkbq8dtAyN4z4?=
 =?us-ascii?Q?liyNojYCbVHEQwYqrdJb4Zsq3COjnR3VTOVYyDWdUHwlGBPm4ZR2B0awLbg7?=
 =?us-ascii?Q?DyjxWJnTo3LSWkBAG604Kit6NUrdQNkf4jF8cCVxRfaj+V80RhmIDiPllDsk?=
 =?us-ascii?Q?SN0Pc2e267VD7EJAqjjTwtbhlKPMzZiTL1izYN+HGmFk2pSTRbivLJ++lyOG?=
 =?us-ascii?Q?fKE561TT2DzeW98Az7qCF5MdV6X169f6XAe2DZtta6SFyKRuDRgv2lruSxwe?=
 =?us-ascii?Q?yHZq8i9ELhuUjLHTnvhGUU+yfQMs9arY7nqbEGMjMbEcA1w9bVi/P9xlbGyH?=
 =?us-ascii?Q?+1WuymkMtIUODbI03FUpx2Kxg+swxUa3ET+gmky+lY4txpsVV5+MFIS1QmZG?=
 =?us-ascii?Q?CKuOPmYdmFEjAtFTKScCeusmsBcHm2s=3D?=
X-Exchange-RoutingPolicyChecked: BOV52+Ef5mPKmsfVsddPlPQoD0vA4Jlyjt8vRX6R5X0AAGQspMpiujCyZCB1pD160S2uE0oZj1lRt2wGkM93QWS/P2/0T+PzE+wwWRYTQq+IgVXPlXhz/MG8P5pcZ2KhNz4Dy51HY/Q8tnex2g1fmidm9dbOQU4LY9GTupzlUou6nZEFHZmnqd4oSJLnMcxj7RiYP5WdKVZu6DexRWWmqd6Jxk6apPbAu65+k6Cwg6k/oL0sO8ydQcUxMvfA6llzXqMrDrStJdU4QNdowUJzD7ODYecKAItMlCFYsbQL+T4cumIYPCW4zgETvSaRTU0XizXodbQLB7nZ1fj9484WSQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef8331e-162c-48f7-de1c-08df13dfa30e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:34.7302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZqr55UeLIFu2ny3nlzEnvDyJnfmkOw9xsbG3rUve3xdBpZKcsyNyeJ6pf0ieA1xxC8ig9XnMu/0n0RxSV/bzD/4Nj3AQ9YZFYDE45d4ga4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX6ZuAEDy4+gw4
 6z3p6hJ6iApxnrjMHFCYTc/+E6DZwvEJEeeSf37UZQVilruLMZ8LPKRrIUMm0lKZWXtFl74jrnB
 PDzfWcIXxsMC5J1ZNZ92BD+rxp2O/QI=
X-Proofpoint-ORIG-GUID: UavbkyGv_febwgguLzMk2PySixRf5kvn
X-Proofpoint-GUID: UavbkyGv_febwgguLzMk2PySixRf5kvn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXyA6sM3JL0Tm7
 rISwHFx3lPHdVE9kmIZlQ4xRXeoFf8nT4ghrkzF8EGfIE8Js5RaJS95ZBqO1ql0HdCNgcf3yp49
 OoxyensCSKXcVekicdPPO/uhyZz57dYd3I8DzeEbCMadNAjYzdGzvJrmcSwxiUD+2vSEn4ASz2C
 wuSAYmfqvlZQuUqO1wSJ/++VA7JpPZyQ+KJzV5VRBidmmaI58Dn2nKVb+bxw7UwaAw6K3CGrFed
 dRvsVPtmtSDziaAYTSovVDyzqVyTmibwNbJm82R6Z6ZzTekbEXDivJWzzP00WGOjr3JZUhTGDrM
 fsmKxPtyPmsmn3Q4h9VK/yuKk4WaqdevAWEUuVTw4kiGzrFF1KDpFiVmVVKbn2eMiJab1OUuggt
 9VAwdsyaXhHis9H0N9WS0i689FMaRoUr8Skdw1J5Wy+lc5qdMVBiraT0OVXzRAmCEEuZsEkEYt0
 GrZ1kepKllJf5nFdqtg==
X-Authority-Analysis: v=2.4 cv=QYvzLcbv c=1 sm=1 tr=0 ts=6aaa734f cx=c_pps
 a=PwPAvtB/AbIKdmTKg7In6w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=ufYRZG4kn_nPcl-B8swA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
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

This clarifies that the interrupt controller being modelled is an emulated
i8259 implementation, and brings the naming convention in line with the
in-built i8259 and KVM i8259 implementations.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/xen/xen.h  | 2 +-
 hw/i386/pc.c          | 2 +-
 hw/i386/xen/xen-hvm.c | 2 +-
 stubs/xen-hw-stub.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index e94c6e5a31..ee4ed4f11b 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -42,7 +42,7 @@ void xen_intx_set_irq(void *opaque, int irq_num, int level);
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
 int xen_is_pirq_msi(uint32_t msi_data);
 
-qemu_irq *xen_interrupt_controller_init(void);
+qemu_irq *xen_i8259_init(void);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9006e7c29e..4ad6b81816 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1169,7 +1169,7 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
     if (kvm_pic_in_kernel()) {
         i8259 = kvm_i8259_init(isa_bus);
     } else if (xen_enabled()) {
-        i8259 = xen_interrupt_controller_init();
+        i8259 = xen_i8259_init();
     } else {
         i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
     }
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d3ce082e07..af3a90987c 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -112,7 +112,7 @@ static void xen_set_irq(void *opaque, int irq, int level)
     xen_set_isa_irq_level(xen_domid, irq, level);
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
+qemu_irq *xen_i8259_init(void)
 {
     return qemu_allocate_irqs(xen_set_irq, NULL, 16);
 }
diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index 6cf0e9a4c1..b3e27f0292 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -29,7 +29,7 @@ int xen_is_pirq_msi(uint32_t msi_data)
     return 0;
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
+qemu_irq *xen_i8259_init(void)
 {
     return NULL;
 }
-- 
2.43.0


