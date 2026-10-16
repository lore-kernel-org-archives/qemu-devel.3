Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3538ECC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiq1-00048W-0X; Fri, 16 Oct 2026 10:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiox-0002tF-HA
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiov-0006k6-Pc
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:07 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5C533215871; Fri, 16 Oct 2026 07:22:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TT4vyz58C9R4m1U1e99yPlvlvXTFk0taf+u089Nfd
 is=; b=NJv1XV6vJECxQ0/uQ+5ofclWrBaxeWlCvWPmLCHxFig7sAxjqn9j4AXtn
 zWCtxqCsRawOD5kGCprBJmog5XNiiEPGub33kshg/edyAljwVY/fQg6X3LEmpYBp
 FlEHyOO14vItoPTUMdjPj1Y2EbrDffWmnC+rdxmzyqsQfo23pIAokZT6caE26G7P
 YO0GzOzu+578gZqeqz7hRDGb+LGff5LWBKG2dx9N/ogdvAyTyypdSb7RBpoV/jFA
 6rUZ7QNAt+/uYFaJJMjeFKdJoCElN4K8pQLQtOq0ZhsI1w6QlHRu/inWIj99YwC1
 LQiGvcrIVPYEZUBaR27IuJgNJ6srA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021122.outbound.protection.outlook.com [52.101.52.122])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hb045k1nt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGip2RzjYkp/7/FJfuQb63oSNWemj7bV7U8A8o0YMzhB2L3k/yhoJRCOtFDblZjklyJXaGEkj9TaG2wAMRERc3MMp7gezWxeLQFrx6FleyzIS02+0jsOZ8UWS3mdvEL/815HRyH1T4mo3+iHeZmjB6FceNaWD081QUGMWv0GbkCZk11Jud/oOvM0qPfx2NQpVd0+JoxpbPG8wRsyVkbk4+apu2IxhhUtJqYBwliCcx95+z2IdgkiuB5RRz2OOP71pu1BuHembpLvNEc+7z+Z+nVhwmVEhX2BTrRbNkJ65d42Hf0X2h8c6QMtzKi7G/1/8gLeAeW6hw0CJfyUnRKlew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT4vyz58C9R4m1U1e99yPlvlvXTFk0taf+u089Nfdis=;
 b=hGilYBgpzHkuduu8xMXMCTeIs2+h0a2w4VssgeNVykoGvye1MsBPPsecqYX+rYoLBAXRJmCiLjU5NqpmRUxxyVsNQJm79XVU0YkJPMoWJPv5BXq8AV2U7CMFXjhwLNyRou/xwzmlQUrscWfN3InUuKoN/y7JJXphZOnwdHLPdhiUSeViBYuzOEIrbhfCj+gmEuJlfP/OahWbWwEdTuf4mrJihBgB/Ud+0luYyMmVsPsBma5JslxF8lFzUbK8XohkzqTcicBL2lOeIxJRpZfUbJO+4GXKTYcdU92OjDcQ+KjQWjNaP0jBvNYr3iKpLr+4+v7WX6Dd1yLMAt/XpuSzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT4vyz58C9R4m1U1e99yPlvlvXTFk0taf+u089Nfdis=;
 b=k2q4UdFR8+PRLh+U3jw2pJ4Ze5RaOTA9t4Xk3DCY04oc4Fa3GngLNZLVzOlS9RxYtgW9pdUw+zaNS/+5rBLszp/M8ZE1nwzbxlIR5/TPYg06bzCgZzms7UcbwyC3KU2jX+ZzgYfvGk+AEch46+sAixQkn9rWKmzY/tFCEpo35cNG91Cm5veQuvCmeAsQglqIP6X2qAJiDca7OKBoa1+7ugo6ZEHTzxvSWK7oPO3h4Wc+RT+HIt77WyOUgAOx9i/b1azbYpkDKWl/gtMmaiBC7gwkTPhqEceYs5yEWz9JvpQ7Tw/FxUwaDaQ9oTv8jO74LS3X0REWR6G48c4f5cFVOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11424.namprd02.prod.outlook.com (2603:10b6:8:352::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:59 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 20/27] kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
Date: Fri, 16 Oct 2026 15:19:26 +0100
Message-ID: <20261016142031.1204281-21-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b33ccd0-7d4d-4712-3402-08df2b90d6af
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: st3Y09XUySP0rTGVtIE3kd4lyMb9QN4JbAun6ASEnooi3pLrdC5/h0Tb6tWTVqUy2gXKmLYU/eELEyi2WG2wUSGVu3CtB+6tNbFl83iqJ5lixcnLa/6zVeD6eOqYMXBWhrkbkbRgBSrVU7WYM0CpNhehK7zs6qgQnPLPNbvcdEjgMQIzacrLJ6zrLh5YeWkpO0r7M+InbJ68r05oQ09WVDgxj3v1QdVYa907Tx1N3LotFBBAO+O/ACAkM1yF6U+R5SMHsnmBb+zgsgSFihUC8rfVuaNuOv/eXqVXi6jYkh9k0RkoLX9/MWOBHP9KfhXQMavy6OMnikq8lj9JsqTs3oVWDBlBZS/w4Gvqd8aE+gTPCW+cuqqHH4O+1qx3jKs1YoKPVlD2w1zHCdHA9ldUAL9dU6mnjBcp8LnCYVrJ+Z/eQOr4U/wqNqvsIBt5npRo6sgsBmdRS+otL8PnJsPRk9S+XFc7shrPQaTh8Uf/7njJ1lPPXlcZapjWjZhsusGP81r5KqNw7u5mx3aj62egV3rNZ6VymMn3CbAxfnsw18cml+gAa9aKp+XkR/SJmj73LCTYgq87EYJdGt9JfPEpOY5ogqwG9kj2xbW6o2bmdj+OMjZynwPLfuiEFmXLAy+33AJcYRRY4abZOAaRZFMjec2yez3CrpKzpgr9lKpPKI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6nCdstLvjAiDqIXhzwXdlkFDWPMt2uSBrDddRSK4JvbipUR8IlG5T3h3Y6KI?=
 =?us-ascii?Q?cD2J5Oo1DcVhKhmGG6XhNDkos5K8esCz01cKWEfcBYMNZiIP53I75GHIlbMd?=
 =?us-ascii?Q?dhrnKTGWcE+b4UOOv4jAdIbhr5RMiiuoAzHXvEN9xb1nxYDlMrK2enzBJDC8?=
 =?us-ascii?Q?llMlhU60kgC/WnFggTErbg9/CGrCIkWZ2uWCfCkh3Fl9yUFkrObvikWHq6uf?=
 =?us-ascii?Q?Qt1X0KeQlcgRE/L6QnAd/W+Ydc0q0/RfckQECjBfPGDOVQQwM2SCay8M6bXs?=
 =?us-ascii?Q?um+K3ufmTMtqeLzCu/Na+rwEPzttyaLNlYAmwuVl1qLrnmyVtpE9RxghJOjW?=
 =?us-ascii?Q?a2zlbn68VxG7pZEgrPU3ns5zr+aWjaXzEuD9r9EFe9MYFmYSGvQdD2FOvoIg?=
 =?us-ascii?Q?CHjXjie5tnOH9g5cJMJkFzLNrOnbrqw76jJsWIbyZ7OFMbPc/1R2SnZdI8hn?=
 =?us-ascii?Q?Og7EUDdhMXOrzzVtr5p3T/l+yDFrRfDwuTHjEIcqRfhcLH32YyNXb7L6Z3CP?=
 =?us-ascii?Q?SyHagYI9wtVmGnqvBecjWtxFv4Yibc+O1eCmM8/3RJteTvQmp+t62mnQffSk?=
 =?us-ascii?Q?emOiQXtOcHsuHUaGa7kEHs7WLeWJAzb58yPbGMWvLEQGNoT7/ctxvue4NkRv?=
 =?us-ascii?Q?ZTPcuIHFM3ZIHtOwpZddxJVKD+esH1fgPFcmZ41MALzEavcfBZd5xZdTHYTQ?=
 =?us-ascii?Q?HfGui6yknldNvichw0gp2UU3QRS2V1yBZKo2ZuhbGnsljhaGr5kYlm/ftUBu?=
 =?us-ascii?Q?6ZVBz5fLz+9UrEvw6czSVNQRL42al284KKfvDjDGl/uu/6NDYA8FgzQvmWzO?=
 =?us-ascii?Q?pzvZ4fOQKb2HvNufJ5VcO4X8FJAH5CtD9A6ss5Fa0PV89S1nogMTDA5kGu2Y?=
 =?us-ascii?Q?5iwsdc14T7XUzWWc8bfaNs+nF8uNB+5g3UonWoOZ9q2GJg+9fttDDs1brPhi?=
 =?us-ascii?Q?tU90hMkIVUCNFt6xvbAY/DCmcG/z4CVtzmK7wPaCqrrffmMZVkhZG4NZdyYS?=
 =?us-ascii?Q?t4lhWJRjGEkVe9coHK8TUyMQZlOu9aSvf2Fmz63hDCX0cBZMOy/GhEZ4prGY?=
 =?us-ascii?Q?3E+hi9Plw1kwsTZmlPl2lpNIhiCdTRGcB3delEWKE6Zeax2zwn1e6yhZZ7s/?=
 =?us-ascii?Q?SFjPkvYQ0fo8nDkZer9/PnSf6MikX1X17RyGqzXwet//8vntsOUtcoBucLt0?=
 =?us-ascii?Q?EfKfuj5P7tEMRWMW8/Uf+Qzj7+4fo99hPU+G34wdirJheqinIe4WM1C7p3Wq?=
 =?us-ascii?Q?FdlIHMgV5ZNUnhlWdLLtw/T7Eo+VULX1nxIEQsNHPgf6wssr1CEKD5zJX4OP?=
 =?us-ascii?Q?pTalqUd+v4XAK3NWVNzHZDkrwT0lrl062VWWSVZL8D/QOJtspVrFO62TTlrE?=
 =?us-ascii?Q?eDRJO1tlsr6L0IAu3WXJfsL1qC7FXI/UalnklGahI/YWm9cDWKu49ZbH8oX1?=
 =?us-ascii?Q?yTcEyRHKSweNEk4Ce7GcC5rzgxwlGper0S6GfBHCSoLuINjIo2hgNgBAeU2e?=
 =?us-ascii?Q?paV//zFSqRFvrDsCjzSZhy/BcAQHGUJ6uhwAdDLGs/2GiqncFPh1kWeNsoVI?=
 =?us-ascii?Q?E//mzks2qyS/+16WIityz5FS2Mc+bSBPj9aw9EfQ/g55nxn2YrNjffVBFWUY?=
 =?us-ascii?Q?1cbA8k5M0284GQZiTtPxztnJPMyrdpQ7FQx6UI7eIsYMQtJ9hxBNwNGa8h+H?=
 =?us-ascii?Q?wJ0VLUIQlD4IQtEvHJHlggXaLf8uoouXZ3CDQRO1jmUyKtuC5E4vHccDGVJI?=
 =?us-ascii?Q?O1o7m0II2eOySLqmaOppPINmD95AGB0=3D?=
X-Exchange-RoutingPolicyChecked: plOU72PLkQTm8IPZQ5ajnKGg+kubxYkS2GCPXXuHLwUHnPsdnVZTnuJB9GJJvqK0L3hvRrkcmygUk89Q3kp9g7Jn3L+OzQF2Wjwmd/8W6aqu5qCNLabtJ37XCnWIY2PPrK4dx+ZCErXs4xfBPcKitOrtxOghw3L7iXR0vXiLghb53YMIBhkl7fswjD1/GziLs9iE1aWUgkK7qRDvJxB6+eM3bZj8X5FznlYiKfQg35KJGXKJwGMLEvTUgL1S10hFgvRNPxgsPqGAUn9NbSvmmIeRKGyC6jqYPebsVh9UE19KdJWf4Qe2URJOtBIOb7JKm86bWXlNhe+Ew3ijgQtwXg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b33ccd0-7d4d-4712-3402-08df2b90d6af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:59.0394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NR1V+MWUDCFiEQSbYafF8wt1R8lPh7D4pukupB58dxyOf6WKNyH//Pas3Io+D6jqN9/j/Ce8n/UtkTSdMD8NS6CMsgnLK7zlNBLDcaS9hhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11424
X-Proofpoint-ORIG-GUID: viLeBcd4OMsDYg2Im6P29P1BHlplfyKA
X-Proofpoint-GUID: viLeBcd4OMsDYg2Im6P29P1BHlplfyKA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX/Hn4HD6mYvbp
 35X333LTbTag4XOHZ2JbhTxWnD7TrH0jy8B1GVfMyCcG/ZZ97/fposnjclllN8RWwIIaQ35gDxT
 5lj2GRUzl4pG4tOzyspR0HO0CYhW3IiJgeizuMHCql6tydf1C001UPcUbD+HTgZWRqqNgg3cF16
 skICr50IvIlimqPAhZuAdmSFuCrFUygwYIDpMuKUEku6zd0TBeFPWE8WsWtbGBJ0pEGWD3jgoUr
 7pGu4H+83Xm0yzfo5edCIPQBSpyv+J3Vu4FQqK3omyve5R35oHtRxmkgTZ0W+efD2Sy9CAh75eS
 HhZNli9dvjsUGFqVuujzGd3V4shcNvqOzDPn1wUeto9mjNxEK7cI6ItLTxugPpusbvrxeTYt7qC
 IE0xQzyzYLqlP4o/UhT1TH4iRTOGGoHjVBV+2A7AOiXvFM4L+NKa/ILLNHxs31vgCfRHzkbspdw
 ivBrEQEKCin5vT5XezQ==
X-Authority-Analysis: v=2.4 cv=V/ToQuni c=1 sm=1 tr=0 ts=6ad23308 cx=c_pps
 a=83jsKCSeZiZisq1MDa3xoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=CV9Lyex1vB-al1NDbmIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX4/zgKiMZZSU3
 ahNLmbBk4PfT0oIT0DlfbJ4U5zACHpT0KvJ3ucuwLNhBTsvSTwttkYLpcQhYVUXiPmf5/LnTP2h
 lnfiinCDUE0r82m965oJPNjxNuQ7Bpw=
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

This device represents the KVM in-kernel PIC for an x86 machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 91 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 9ee23b5695..c51738dd44 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -16,7 +16,9 @@
 #include "qemu/module.h"
 #include "hw/intc/kvm_irqcount.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
+#include "qapi/error.h"
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
@@ -36,6 +38,18 @@ struct KVMI8259Class {
     DeviceRealize parent_realize;
 };
 
+#define TYPE_KVM_I8259_PIC "kvm-i8259-pic"
+
+struct KVMI8259PICState {
+    DeviceState parent_obj;
+
+    ISABus *isabus;
+    KVMI8259State i8259[2];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(KVMI8259PICState, KVM_I8259_PIC)
+
+
 static void kvm_i8259_get(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
@@ -135,10 +149,21 @@ static void kvm_i8259_realize(DeviceState *dev, Error **errp)
 
 qemu_irq *kvm_i8259_init(ISABus *bus)
 {
-    i8259_init_chip(TYPE_KVM_I8259, bus, true);
-    i8259_init_chip(TYPE_KVM_I8259, bus, false);
+    qemu_irq *irq_set;
+    DeviceState *dev;
+    int i;
+
+    irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
+
+    dev = qdev_new(TYPE_KVM_I8259_PIC);
+    object_property_set_link(OBJECT(dev), "bus", OBJECT(bus), &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
-    return qemu_allocate_irqs(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
+    for (i = 0 ; i < ISA_NUM_IRQS; i++) {
+        irq_set[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    return irq_set;
 }
 
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
@@ -154,6 +179,59 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     k->post_load  = kvm_i8259_put;
 }
 
+
+static void kvm_i8259_pic_init(Object *obj)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(obj);
+
+    object_initialize_child(obj, "primary", &s->i8259[0], TYPE_KVM_I8259);
+    object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_KVM_I8259);
+
+    qdev_init_gpio_in(DEVICE(obj), kvm_pic_set_irq, ISA_NUM_IRQS);
+}
+
+static void kvm_i8259_pic_realize(DeviceState *dev, Error **errp)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(dev);
+    DeviceState *pri_dev, *sec_dev;
+
+    /* Primary */
+    pri_dev = DEVICE(&s->i8259[0]);
+    qdev_prop_set_uint32(pri_dev, "iobase", 0x20);
+    qdev_prop_set_uint32(pri_dev, "elcr_addr", 0x4d0);
+    qdev_prop_set_uint8(pri_dev, "elcr_mask", 0xf8);
+    qdev_prop_set_bit(pri_dev, "master", 1);
+    if (!isa_realize_and_unref(ISA_DEVICE(pri_dev), s->isabus, errp)) {
+        return;
+    }
+
+    /* Secondary */
+    sec_dev = DEVICE(&s->i8259[1]);
+    qdev_prop_set_uint32(sec_dev, "iobase", 0xa0);
+    qdev_prop_set_uint32(sec_dev, "elcr_addr", 0x4d1);
+    qdev_prop_set_uint8(sec_dev, "elcr_mask", 0xde);
+    if (!isa_realize_and_unref(ISA_DEVICE(sec_dev), s->isabus, errp)) {
+        return;
+    }
+}
+
+static const Property kvm_i8259_pic_properties[] = {
+    DEFINE_PROP_LINK("bus", KVMI8259PICState, isabus, TYPE_ISA_BUS,
+                     ISABus *),
+};
+
+static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = kvm_i8259_pic_realize;
+    device_class_set_props(dc, kvm_i8259_pic_properties);
+    /*
+     * Reason: must be wired to the ISA bus via the "bus" property
+     */
+    dc->user_creatable = false;
+}
+
 static const TypeInfo kvm_i8259_type_infos[] = {
     {
         .name = TYPE_KVM_I8259,
@@ -162,6 +240,13 @@ static const TypeInfo kvm_i8259_type_infos[] = {
         .class_init = kvm_i8259_class_init,
         .class_size = sizeof(KVMI8259Class),
     },
+    {
+        .name = TYPE_KVM_I8259_PIC,
+        .parent = TYPE_DEVICE,
+        .class_init = kvm_i8259_pic_class_init,
+        .instance_init = kvm_i8259_pic_init,
+        .instance_size = sizeof(KVMI8259PICState),
+    },
 };
 
 DEFINE_TYPES(kvm_i8259_type_infos)
-- 
2.43.0


