Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688BBC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc49-000607-Tk; Tue, 15 Jul 2025 05:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1u-00020x-Hk; Tue, 15 Jul 2025 05:32:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1Y-0005rR-Un; Tue, 15 Jul 2025 05:32:39 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8G1LG017472;
 Tue, 15 Jul 2025 02:32:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZXv7vGsXNjoaxumgi6MUnfeX4OkcK3Qb95lwEJMB7
 v4=; b=dKfZEMmlemm6bTbqHffxaruwiqhARC+J/giELXm+9mBFYqANIUJujEFH0
 GbDRSe3dVgVZMCTznxu9ShtRhPll88sPDy5AP2qdfwDieJTzdi+a1yZhRDEai/MM
 K7M/46o9Saqqi3vlRWLpj9pSv67udTs4AZJz/CHtyikhL3Z/3gCeIKSO+JeJyWQt
 wd+TgzU9P840syfyZd5OxbmvckHEfLTppi7yuNhJ467mA6LqPxn4eBijrYKwlj56
 NadAsToI8buszYfuWBtNcq4aysFpgdTvhzBAkD2ZWprVdI/6EhrJke1vYWb87RFq
 TB3FjCP3z6OVooTHtvrClsLvY0WdQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2138.outbound.protection.outlook.com [40.107.244.138])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47um1v5u50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1aLb3FHu2MMVfNCmqNofL+hmA3BqoEcDmnvfQtcxhJQ7O/MaoMcfXFgR0jwFsWixl6VNBZCs5lMGkY+ONjyW13pcXyCQh/k//xn7ho/6934dcAxuWNQFjqxeLIakKPxClbsNsfe+Q/6P7111dA43PrfGubfCMC6J3iWCDNcb4GihmTW8diAo/eIrVQnTn+CnDbNEf4kQoBULOzauaQyfSydmeEe0Ior/hjedRPaCz1JqEQhlpRygHBrBmBZ0Onwiu3KPi2a29ukNh2QXwLgJrXESdOzTN6mhQ8URN0+kXst+B5uDILJ9A2Zs+1aeoMZHdi5ZxHuSmD75oa1zd98UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXv7vGsXNjoaxumgi6MUnfeX4OkcK3Qb95lwEJMB7v4=;
 b=fmVoKLG7Nm0flDt+Zni1vdTjOrjeceaJo+ZfJqCkxLi2lzOQgY5AsrN537K9VV3x2G0i8BqELJMNGdg3skHJn+O4xodL7juJxOopzJMQu2KRBgzRjbJAzs7PhOyGFHwhJPe8FAD3gPbrrIKTzwqaQUmbe41mOIwZQq9f8I3lvtrPIlUK+J+6cav3iaoV0S025hLe8/KrwSPYA4OQHdh/quVxzN6A+kasG1YGZrrU7qxdEbYOQr9g3x6GZ36B1TCfvgHYjboTcuOFvwE4ojaEAtD1wUx/3sP19BoXuat2VAwjZkojtI+ipYe1vFd7zWOvcTYu/0y8PBJrO0e7sQ82Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXv7vGsXNjoaxumgi6MUnfeX4OkcK3Qb95lwEJMB7v4=;
 b=oc7jcS/7kuW1kZTQAYIH4kcxhjqKxgYrDFoB8umAzE//F2oGMBBs6MUDzAVwx2ggaghHESWqcadg/xE3hY0/zAO8x/h+7XweUjIgkPbyPoJVokzr5OfJAjZfqgwrRrh1vOyDPc8fmC3stWhU3eM9cq9amB5KbSq9FDc1VKwLGr8qotUfwF2WJ+HQc9gauFnduIa2fbyhULcGNndMLBX5RYuD/waea0QR1Qg+Oi/JDSUq9xf9uerZEXn/WokseOwoHGqgcIbgXy5sfY0qrDSA78zPl+G0k/Y98MOa4DK+WEoq6LugA4pf0gUzSSEgRCfCS//ASB/cGvh8q2+JU/6etw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:32:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:32:19 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 18/22] vfio/cpr.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:58 +0100
Message-ID: <20250715093110.107317-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0026.eurprd03.prod.outlook.com
 (2603:10a6:205:2::39) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3b825b-b5b0-4421-498e-08ddc3827ed3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RMw1Uuzz37LgawMgaHje5LGxvpudlfN9iE2zZHKQAHYJMRCJhsegLxCjaVJu?=
 =?us-ascii?Q?DKEjCN273xvPWuRk4vD3Y169jdPnDx1B5n2x6+1FSOiGGQDSGfidXzKLYpHE?=
 =?us-ascii?Q?xU42MfipOkxoWX++ZG1gb+iY3dcTowBwD1dtAt7cpp9w4j4mcUx/o1q5vY3A?=
 =?us-ascii?Q?y0OZ4is8NDIjWc0rNisPXnglM8HmI71zMfCPp4C8pXwjnRNwbm2rcP18kAwU?=
 =?us-ascii?Q?l14/gzATOtcaM5gDbLifDmfSUsLcnrH+SASMQyoCs2y+HT8xB+CVT/gDXJxr?=
 =?us-ascii?Q?RCU+CmBcCadBwIPLVrfYX5qRKnXKgXWuIv92jPGIsxpJJD7zQ3Je0VJnIX7L?=
 =?us-ascii?Q?QeSsK/S3uSZ6XLw1t4SvopyuiI/Bzo3gncF9bNcVHqwUrB2eagX0HyOy8zLe?=
 =?us-ascii?Q?5956MKJ/iDi/M0tqMAbuJYxKLnxxgvZVxWF2Ry0ata79oWBnOmr5cCHObQ0n?=
 =?us-ascii?Q?TcL3KYRp+azrvRLJT9Kli2hWWiY80UfUTzZUcrRw2yS6fKvv6Rh/OCZg+ZZ6?=
 =?us-ascii?Q?TAIN0yrFnefkzOi5L0Hon5kSHtSh4fFaZZKUYXjmWm9+dPG6RUvlEJVXdXCW?=
 =?us-ascii?Q?kCErDw9a8P43gaGLsWdlXniyJLtWkWsZUMlvXuepzMYVjhUdbRSEUVkGlEXl?=
 =?us-ascii?Q?ePArqD9Gq0cVR288VA6W8+FSlAxRV33r++xf414Y42FWpSxlZlF/Pwj5w9/s?=
 =?us-ascii?Q?1Vxsz8XE0Kh5oULB2j6/98duIKtHRflT4QEcY0rS/h8lKVDtiGp1gdU6WmIX?=
 =?us-ascii?Q?4KiVBc4QpJENmx83xpq5H7AGmLTYNdkFFS88yEyE0FvqZ7wgksnIGN7+cGRX?=
 =?us-ascii?Q?rZzUPjdhOAgDMmNkgn0zJQklmzEJu9rHnDDqkJB+jH5FIaB25HtoapSKgdAy?=
 =?us-ascii?Q?UObarbC083BQvJap1oBNJ98MyhhpuYYE6940HIZoHhT2FvulxX/aT/fUk2EE?=
 =?us-ascii?Q?r0+S8SF6H7Dc4qqL4Xq7k4HK895uDFxqYPRA9KCwTLNvZ30TrRGcLaM8TP3H?=
 =?us-ascii?Q?3T84qpeebTYe1c+IKCr1/UYm3V1vY1UYqV282TcSQLDBuOPx24U8C/Vi2DF/?=
 =?us-ascii?Q?oT/BwUzBPVWx3uYg/sO9NMnqweldRAeqRHrWMsgWQQpZAGeWIT95+8aaRf3T?=
 =?us-ascii?Q?1yuHIuTCem4/3H8epTv4KFRaaypIWyoPsK0N2wdM1eq7JEwW4OyGOLoiipE7?=
 =?us-ascii?Q?+Zh1vSoAGzS5eh6nj092SVnJrVVaNzaYziR4YgsAPGpzqSQ6yeVjjmQiPISk?=
 =?us-ascii?Q?5YElv3Gkw22xhPvvXCXLbdCOsLNCbfuZSIXZxHCdoUEUVTtjqMawZkB5ogGv?=
 =?us-ascii?Q?jOoFd5IspSre31mzFQxmxXhQ+hB4E6c0lZ4wLxOO2yiUFlWYAeTa1Ap62Qef?=
 =?us-ascii?Q?9Jd9wcRFQiKp3DqfzhMBqoS1nmHdE06jl6gG+/Ly+SFVy3nxz77y+ZHePVXq?=
 =?us-ascii?Q?I2fQurQzUi00plj5RTkp4cPEkuNA+R/e6m5DexRo0sfH7Qlhz9qTvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mY1h5J3LgN8BTrHpWwJF/0P+mMvfFc+wJWyUaG4BZED/j0XILeRWcxqP8Xyd?=
 =?us-ascii?Q?AQfdQkcCJ+3WQorHZDzHH7qxjoRQB9AjM4b1RNeXVTrCAbO+gxPLvSdjp6Ae?=
 =?us-ascii?Q?l3KlKHiP6OiNAlBT4nhGilmvmOzDS4AtYzFdOLzWVzniFTmD1FRoSkGvUzys?=
 =?us-ascii?Q?URl/MU06e4sWV4CM3peVYZbx0FXOhSpxImKV4NPs1L95Bv6HQShq9aRtxxZC?=
 =?us-ascii?Q?cugsz/XUg7M25n/2IDfReX4ouOpZOlMyJb/uWQMUghQ3dNGh3Q/Lxv6+2twj?=
 =?us-ascii?Q?QXDJz2L5soNCVFAX2CrtlxMwiMR5jrQYRcISY4g3832eCqoeOLAga9LPVTwE?=
 =?us-ascii?Q?VmhLdpeTZeqLWfdP8Fu+HqIGHtqjyDwazOZF6BjS6D3y4JWD1XgqWrgiXmou?=
 =?us-ascii?Q?jVloZIycUJM/nP6Uze6REFNRZvelQ8Qrgi3yA8jyUiCsfJXfRVfnSJL+gQMZ?=
 =?us-ascii?Q?DE8cvnMRNFD7cxAgIgAQFcvT5Eop0s75O3U9bdV8LdQ6yVkrllcKiXaYVYFu?=
 =?us-ascii?Q?4Yd+AtU28aEisShTNWSBUfnk2Lzl9smfv9kyOB3W8BxPmlLCItUDQ0K8iKYY?=
 =?us-ascii?Q?vmE42vywLYKMlKvdNXKYZvJSSsGFlFiAlClnhhAGH9m/c5SO3KyV8klWvzMd?=
 =?us-ascii?Q?fn5sqSbgmhNRVmEOe5+cntEX5To1V+LEN2vwcaIzCNZ3wqn0qc93TRD8YzCr?=
 =?us-ascii?Q?2UkgmshcUDcfHcVFlz2luNQPy5sOL+ZjtO9mfp7eB3FRXbuYNpGiBPhe8SbF?=
 =?us-ascii?Q?MKIdk4uuuA/BTv5CtILO5gGtGDD/b+znTOWP/38LUZJtgJnB4YRg7e1C6wES?=
 =?us-ascii?Q?Dof99pWFVcJSdDaBfHuiJMYNuuCBXd47K/jMbmkYGiUGJvNJfkchoTpIsGWp?=
 =?us-ascii?Q?hDD0IXOzS0KXavO5cCuvhlHgWgMaHGOJvl3mpEIQBK2GxuxCFsl9O7SpMr36?=
 =?us-ascii?Q?Y11wxcO6Guc0XkUm0llrLBUM+ywnk6GPbpkFhOfDZfvY1I1RKp7BFvPyOCqG?=
 =?us-ascii?Q?2VzFEB2VBLWHr6U7mGPcCaAXz8SF95Ow1qQwlF5rKLYf5Zu7xf6CyYAonLOX?=
 =?us-ascii?Q?bkmFx7ts5VpKOm+fdBU/omddhrQxDrFmRNuDdutN/a6VBp6NWI1onLrtDM6g?=
 =?us-ascii?Q?hRW9Gpgj5R3nwoFYUicr60rzj/rflKY9lXEVkbe3OAT5uLWmTBg6IuDgW5di?=
 =?us-ascii?Q?Ke5RWjjIeCO51mziJ0NdQG4s/ohM+g1B1c5/UPV+zit7aW/3/9EKhcS94Ef+?=
 =?us-ascii?Q?/H3m7F3NH8r6QvcQEaOdrdjVQqQdnn0CfilLb4H8y6VDgp9PvtEmG4drNwaR?=
 =?us-ascii?Q?L1X6BGA6Eqs4429PM2OhLk4wJNgATes24lzekmijF8ZoQHCYbV63CYBBUgvE?=
 =?us-ascii?Q?w7NoWwx8QmoV3y3Iq/EdmupzxahcO1fuEkNapOA1DBvADGtOeTK3ABfDcsxk?=
 =?us-ascii?Q?UwCM+jPKdIMe3xKmkNgqhch3IUpb6uU1qskw6YgFQkCBByD+K7k/UqG4ug3a?=
 =?us-ascii?Q?Xl3dxgIIfPMF7+AkvHepEocsVR0abbq9FNPUZo5UkQJTFVoUM7E/kwDl0qik?=
 =?us-ascii?Q?RB87sTbMEQOE8u2z7EAwc33/xV9hMmPK29j8WM4x+L5pzIQkIKL7e7Y84AlT?=
 =?us-ascii?Q?+/wYbjhc48Eux8MVMpWBXF6zXTWjOu/xi2izLqMa7d8UU6dw+phO0y4eJ87b?=
 =?us-ascii?Q?+UYiSg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3b825b-b5b0-4421-498e-08ddc3827ed3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:32:19.8355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZO4wBhLNZqXhrB8IhD15XnKBIKAxWOjqUiLXTMcwEYOak2Afwj8cUPbzQ6T711kFwO3BeSOOufmlgVha29LQ0laGRzP6IL20gMyfWMuXu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX4kBFI4qBpjte
 o1H1gXmCGMCyBNsI7C4fpmXBuQx73gtls+K1mH0waEq061O1HvMf6nAjfbtNaWdrNk31RcsEfz7
 BMEWwKWuVc1GLdQb1QqfKPmZuohdIwI+wytgHqol3HURT7f15c4/e5Q6Lc4xDLELm5sg9H16Z7J
 cwb5f7U1wYH/cKJVPlm/WXOp52q/oaLeVrHbxcxwyiDU/s0ATdUaPq7xJzmMTu5XmzTOtQbUaxd
 fAc2gfZIjv2YfIqk5K7RNj+Wk7uOSlqZzqQzmH2lqU1n/WWKwkrcsgLRGB5RNzMvQ52WrYnpo00
 rB9uCXkT7WrDmHkkm4hcQ8SavwRbN/8LE4mitgk4hsCw8YptJ50Po+XSKyRGtUSFtNw2478Mjfi
 5C4hRsJA+GpJltQhyeNMANuLizvh6LzHE6Gwqeo42OZ6gtMs0r8Rriz/QLC6I7eNlW4SxOsf
X-Authority-Analysis: v=2.4 cv=Y5L4sgeN c=1 sm=1 tr=0 ts=68762025 cx=c_pps
 a=8zEn50EW7sokACXIljcC9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=Kc9TmPF6FbSwc0xhZi0A:9
X-Proofpoint-GUID: hSE1SKN-QGoRoYlQ6sV0JEgvvzOr-Ruo
X-Proofpoint-ORIG-GUID: hSE1SKN-QGoRoYlQ6sV0JEgvvzOr-Ruo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/cpr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index af0f12a7ad..3e3f4035ab 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -56,7 +56,7 @@ static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
 {
     int i, fd;
     bool pending = false;
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     vdev->nr_vectors = nr_vectors;
     vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
@@ -99,7 +99,7 @@ static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
 static int vfio_cpr_pci_pre_load(void *opaque)
 {
     VFIOPCIDevice *vdev = opaque;
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int size = MIN(pci_config_size(pdev), vdev->config_size);
     int i;
 
@@ -113,7 +113,7 @@ static int vfio_cpr_pci_pre_load(void *opaque)
 static int vfio_cpr_pci_post_load(void *opaque, int version_id)
 {
     VFIOPCIDevice *vdev = opaque;
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int nr_vectors;
 
     if (msix_enabled(pdev)) {
-- 
2.43.0


