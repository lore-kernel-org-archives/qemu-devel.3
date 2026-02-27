Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46B6FEFB4D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyAr-0000qC-3I; Fri, 27 Feb 2026 08:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyAm-0000pb-Tx
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:29 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyAl-0004E3-2l
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:28 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61R9r4EL3563566; Fri, 27 Feb 2026 05:46:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=KauxA6sm/jSbrQXNJ6byFGhHrSAp+4sRRrgL9ZWxS
 hI=; b=nOs6brM3gZk7hldzuDOA1qs/vml2Wgnfg+IChbztQQGzEtg1DXQXcGNww
 GIXjIgY90GNfiE+P/IyvKpSFeyH8bR/gZc3LbA8UeRBNAuZgXcMUodOE3FykHxF7
 Zmz3ejFI3ISr+/mEE+X5l5MAtpjAuezIu9yy0LUT3lp6vDPE4/rDn0eJkZvS/Tq3
 kixczynMeO8OqC8Lep13d71TLvbBQxbXAu9Wd73SSND5JF8yXlGx1YPhvdT8pHo9
 vYBe+q/sy7fkSpg677CXICvZ1mk5OAaXjkwan8nHLfiMlvTvdUn3b6+8bhkhna03
 hPCDYJIC8d8/aDelMTdGnszJoqXKw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022091.outbound.protection.outlook.com [52.101.43.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ck915rdc6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 05:46:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0AxcT78g8q/QxiKhjijpz3j5crjMY9BmoBo4LUJQn4hMEmOhwpqeoklHBm4VubPs/YD2H/G2o95hNo3sxp21NXbdQk/BvOrN7iBT5YnC4DbrmVBaU0A0RoJZTyz8n4jap0p1+fkybp2i2NnzV1z7T64axjGF9tTM2zRcWPt5Q66HFvwpZNtqwQhLxnecmWZ+iW4Zgo0MwRJ6dPvxSHTgxT7FOG5hG3EWgKtgqYQeMaHODQnlGYNYNydtAKyFgU8qAAvAQ5aMr+Uq2dMGfmxq6Hvx/vF6GRl87f4KyOxSLoSqY74hY8tugXQ/JhZHhwIsJ1Ymwt7ESxRvybaxRtfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KauxA6sm/jSbrQXNJ6byFGhHrSAp+4sRRrgL9ZWxShI=;
 b=MrfqG5hLYEmzCPHDJhT2DNVTBv5OcSsqVNHCnuiw76bLflAMmZfSetktbCZGTgfwUSqMbwPhbbaxys6GzsmKfEDkLHglJJolZJLwUDSSZvV11lEeZ0D50EdSZJWHs242eDBxb5MrU4jKNJ9u7EJaf1yiKx03DmBrMY3tNbFY7gipbz5htb25EpReA02G1kxpBeeNMt0xv5vMA4n/fLmV5CJ2CLUn/ipcJZaUDfGW8W/s1U2YTT4LeLyOiN8p4tVST68/u3o75oegHzs60eZCISh3b490ooKORSihz7r0KrHyUkAZh0UVSIcBEgoTNEW6imBEiSxT/Cpe1b739vE+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KauxA6sm/jSbrQXNJ6byFGhHrSAp+4sRRrgL9ZWxShI=;
 b=eOmQQ4kpClQ+Fwn5YK4kYS86/uHTE5vTGC2bbnuvZ17tsxxw7FmPq4Ze3hwX496X1/yTp8odmWmPDoGuDX+B2v3BexjTioehoTD+gAfCX6c3ch5reETj8JL2nFxEr6LPgGaeY72ovMluKD6+Tk83Dxtxphxfgq6mdbCrV17E+fYig6hmJt1T4JkiPYD4VMGIa2ayc0WkjlB1TCzd4IcS32UIUtsmltUhvSL30cTXdk+exbrJw7H8p7ylldJFeWHbafpkgNGJecagxFpA4ZLEjLPR1cRCmNS2M5ZNLdIETAzyAKD8YNPsZY++r6mA3nhWjHOkG4bwoSbYDGJBQ0djIg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV2PR02MB11277.namprd02.prod.outlook.com (2603:10b6:408:354::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 13:46:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 13:46:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/acpi/aml-build.c: add aml_irq() representing the
 3-byte IRQ descriptor
Date: Fri, 27 Feb 2026 13:44:55 +0000
Message-ID: <20260227134611.1229390-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
References: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:610:52::40) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV2PR02MB11277:EE_
X-MS-Office365-Filtering-Correlation-Id: bad66e3c-a4b4-4f06-6081-08de76069851
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: valhrR9fpfAWBhjLuFcMv7YIqax0Wp3aaVUsxB6EJumEXZHcKpQIGxokOWouV/DVMXaoalo7a/aq8/IsHL3RWkOWViD5V4y049knB5tKZ1K/3VXWBFDgYiNRAgMinvbZAFC5FqtHf53u3n9FPstwWVEwTKtIHQ52joeoGC0sG521hZRv1+9kLAs5Zt6VD/dW2YEb25PkaKI2lmFlZDf1ZaWHVqnH7pc/Ohovtoq9ozM5efXJr0262oukJJVj+M+rxaTv0PGa5n6SBJ7XXWuHLm/s5ZVnJQFxLpnTCQ38MhUscfmsrXaRCqujvMBeNIecTcWHRBUKNx38D5PUeBiO9EgLZy/guBrNaqBPpXtY2nB15WtEtkrX4sMTqaXf2jYLlSVf/J/YCETma4HaNPIJRgJCIMhoKCVQO+z+eHY7S9Lwzsz8E4Zb0qt8q/STmyy+fJAGRBH5sj7HLmvJUcfVnBnYaBWQkQztREeHbF19AR0+zrx7QWkLHH5AJBjRR+oLmxAMzcVETyFT8B1q/4GMqnt9QynXzX6v4WN/HbaE8sqceY0ODqoroFeG94iYddArlGxKR0gPIjBjv3QIeXkkJjPDU4Zo+1HiaoNtArquzs/952MAY1BLLVArjCv/4JbXkWmsV6x0d2LCX6v/HwhEhVGihIgqAbXgTrN/DhJ60KrHeNxhraOsJJwHICx/rG4fwkoSKE4gZqP53OZd16nj44f5faeczKIqEdmXNho3PTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nMKhKYEYUJsuxBiAr/KF6g8i8oySuueuDhlILhs972uAsYXphmn2lSuKagHY?=
 =?us-ascii?Q?og7t7KLr/+M3l32R8EXODLQmQbl5i/usCIM2MoaNXcVB24fwB2VR5KcBm32Q?=
 =?us-ascii?Q?5iUioF3oUEqXgiUJxDMWIKj6yQIidkV09XwH9aLQ0bA6O8JvWoxiKxFXumbD?=
 =?us-ascii?Q?TNNxvSiSumRcN1bdu9jjCo1esFN41Q0utyTdbdDq4xjvv0bIcD1TDNxT+iXT?=
 =?us-ascii?Q?jO3jCWCS8HD3wLl1p7tJkOdJvbkKUZb47CgYlWBaFEADyp0481Q71BEl0MSr?=
 =?us-ascii?Q?Pqelr2217jnh3pVU2dEbaF+K1A6nFlM2pdJ9YFKJEkM6ZvBTqVprTSnATOGF?=
 =?us-ascii?Q?gIkFwfXBfK5ImqUxsjJMtjkOsk0sPDkpAO4GA9Z+MzOQb0CR2GDFECRzVsAe?=
 =?us-ascii?Q?O+PmzFmhnUxiTZtEE7+rFgVgu8UrbuR5IbslUNINghIjNk2JPFyW0UC4bn0z?=
 =?us-ascii?Q?CTG39ucKFCTQ1SqFWPCY6u6JmGyoaXkNUgyMX57VPRvDmy/fUXTllNymSZDQ?=
 =?us-ascii?Q?WGo5BRfL7EDd2fWdoIMaFpe83XFPlx5UmojrkLzz9Fp93GfG+VGtBxLFusYo?=
 =?us-ascii?Q?L0wbV28KAY4rhoHJ6aJMPMzF8TlJJs6kh9km9ZVivjKv43wjOfO1CirTec0u?=
 =?us-ascii?Q?De5sqq6qhgIJkKeY2/A363BgxHECni7E+Thx0T7HBo4/cGHKrpE+Bou6orBa?=
 =?us-ascii?Q?7U/D4aTey8k727lUPvN8uHJotZZhU1dARzdZ7r/LhNL6bUooT/ON49ZEDbrR?=
 =?us-ascii?Q?nQJwW4SihcK+jPmR/ltNbnjkBLbgokOjDBDVkB97BPbyPAe7ohNgm7THjKkT?=
 =?us-ascii?Q?8JTLBDSrZ6PNW9sl4Xn9OMQuhgcNj7YR0f2/82UdqmUvCh7+6tTODMSAdUfG?=
 =?us-ascii?Q?1NXSi5GwsRNCOG3bLdQ15dSLsHuTHgoqA2+Nu3tfmkPS5Zty4dAf8UiR0XYu?=
 =?us-ascii?Q?YUanHuApsrfFHdnxwU8NUgW+rFXP5iW/djrW/x7/cwQfxEEObMxl5ixG1LEq?=
 =?us-ascii?Q?//0sxGsT++xoByBaxKTVxGkA7ck4SFunOrnOZt/fAcrOFgTafvJAYK1laVGx?=
 =?us-ascii?Q?uwGoGLha86RKKxCLQad14lChWa8Y9RGND5lGgbHbWQ+AdjkP/+2Z8HhXPjit?=
 =?us-ascii?Q?53NmBdRJVd9wOgrkoOkRsmvot1FRDMPzgBeANVPWH5kLVE+w1W0yDDd27OiP?=
 =?us-ascii?Q?MX/YG7G3cDziRIJ8xM3io4GXkrgJY7m7yxGBvR43T0IFa6HrL5cCuAE0XSdZ?=
 =?us-ascii?Q?n6DnEg89W1iapzYkCOBEwxL0bBIcpoA1Na36HEmmapZTNoOPvvDgm7y+c0Rb?=
 =?us-ascii?Q?fhoEsRFL9HumM2nQcMdkQlSFXSuCd2rgUFhfV7xjxS6j0Taw3UD1Z9a0U6bq?=
 =?us-ascii?Q?ufzAr0TpCd4HpUw+NeRK5asnrOsiRi8mGXGGJAErPFJM8tzrW/4Vyr99aiAn?=
 =?us-ascii?Q?4Vf4S/yFOCbTpmm+vHExsluktZ1LlgWE8hY6F9yG5Nu2/Zgp+fX0YrZKyXro?=
 =?us-ascii?Q?WxsHVAEK7O9rhAKaw+QQoodkjVMu30EEPKmX5e94FgPmnZsz0oCUJZOvdERH?=
 =?us-ascii?Q?E8T029G3NR7QMJxdy6v3zwoDyeF1HNoEBOlp6QxVjzzARkjWKrDFCXSWd49Y?=
 =?us-ascii?Q?Vyt5KvLj32zASgx2WGvFDXYfJfIGu8IVpCMbBuoVxRi6qWAfBeql0jG1iXiG?=
 =?us-ascii?Q?tVnzIwUrbb6QlO8y09DyLnjJ9GbtfutKsk2YyPq87cZHKKlpdrd/2iDlbN0U?=
 =?us-ascii?Q?CHAwxMsS3WB89sDYXUHofjGsY6FzJiA=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad66e3c-a4b4-4f06-6081-08de76069851
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:46:23.2232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbwEz9r8/HX+P/7fk0Wc5SOtgf9+XDRgS201UbI5aQ+V6OheIU/epj2qT6kNm7+Li9EQ6aRMhNe4fuvGqc84UbFHR3sBKALnh+jkFwlUMVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11277
X-Proofpoint-GUID: BWMpVYBYiqXXjszmzet_emwx9l9P9QJY
X-Authority-Analysis: v=2.4 cv=Y6X1cxeN c=1 sm=1 tr=0 ts=69a1a030 cx=c_pps
 a=Dm0nEerhk2+Yr7xs+kkSBA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=1yB3SYwDT-OpB6Fa3bIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyMiBTYWx0ZWRfX3Be/ZUFjML4X
 x6gafXmrKvDKpXFi/I1BhZf0SgLTELbbH8OcfibJqBB1vsWCbDV4DqYRClswmvTA8LEnGOvZNEp
 0i+0DnvhBEfbVWOvsdTMB6nZk+1cSMWheD5S0EWYshg/3hf6huRmLnBB+NhcqNvhRB9rLsXMOCf
 G0pk+AkuA3v/UX0/t1Anc9KlAjZo2Excha2ihRm9MToKm35/eze06fNaNSJYDFJqMtXjQgxkQ7O
 ZDhhs6P7J+ivycNYZmXxIZqehXKxIz1njY8Eqn3dgXBO9xXfqDFqqWW15YnwT4YtuKZBGR98OyN
 VzdpU7FStfIvSVunSMGEIua2U6srwPst9QXw6Wbrsx1AfwtRaM1v3UCPZXe3bu5la6CgRteREQm
 r98D4NwL7ouJKzQ/6BKQ2UZtJxYePgSasf07jqHCLnjmwV+iDJLkIfMZy7kaoJXPlY38Ok4IlFR
 o/Mt8KQ2mVaTq1AZqBA==
X-Proofpoint-ORIG-GUID: BWMpVYBYiqXXjszmzet_emwx9l9P9QJY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The existing aml_interrupt() uses the Extended Interrupt Descriptor to store
the interrupt information, however newer Windows will only parse the
standard IRQ Descriptor when enumerating ISA serial ports.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build-stub.c    |  6 ++++++
 hw/acpi/aml-build.c         | 25 +++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index f38e129719..3394253b9e 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -342,6 +342,8 @@ Aml *aml_io(AmlIODecode dec, uint16_t min_base, uint16_t max_base,
 Aml *aml_operation_region(const char *name, AmlRegionSpace rs,
                           Aml *offset, uint32_t len);
 Aml *aml_irq_no_flags(uint8_t irq);
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared);
 Aml *aml_named_field(const char *name, unsigned length);
 Aml *aml_reserved_field(unsigned length);
 Aml *aml_local(int num);
diff --git a/hw/acpi/aml-build-stub.c b/hw/acpi/aml-build-stub.c
index 89a8fec4af..3180c7c962 100644
--- a/hw/acpi/aml-build-stub.c
+++ b/hw/acpi/aml-build-stub.c
@@ -67,6 +67,12 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return NULL;
 }
 
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared)
+{
+    return NULL;
+}
+
 Aml *aml_interrupt(AmlConsumerAndProducer con_and_pro,
                    AmlLevelAndEdge level_and_edge,
                    AmlActiveHighAndLow high_and_low, AmlShared shared,
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index ea1c415b21..b07b0133c2 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1058,6 +1058,31 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return var;
 }
 
+/*
+ * ACPI 1.0b: 6.4.2.1.1 ASL Macro for IRQ Descriptor
+ *
+ * More verbose description at:
+ * ACPI 5.0: 19.5.63 IRQ (Interrupt Resource Descriptor Macro)
+ *           6.4.2.1 IRQ Descriptor
+ */
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared)
+{
+    uint16_t irq_mask;
+    Aml *var = aml_alloc();
+    uint8_t irq_flags = level_and_edge | (high_and_low << 3) |
+                        (shared << 4);
+
+    assert(irq < 16);
+    build_append_byte(var->buf, 0x23); /* IRQ descriptor 3 byte form */
+
+    irq_mask = 1U << irq;
+    build_append_byte(var->buf, irq_mask & 0xFF); /* IRQ mask bits[7:0] */
+    build_append_byte(var->buf, irq_mask >> 8); /* IRQ mask bits[15:8] */
+    build_append_byte(var->buf, irq_flags); /* IRQ flags */
+    return var;
+}
+
 /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLNot */
 Aml *aml_lnot(Aml *arg)
 {
-- 
2.43.0


