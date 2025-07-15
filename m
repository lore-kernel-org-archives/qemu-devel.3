Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10A7C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc3L-0004fz-Nx; Tue, 15 Jul 2025 05:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1T-0001RO-B0; Tue, 15 Jul 2025 05:32:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1M-0005qV-IC; Tue, 15 Jul 2025 05:32:27 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F94iUP013681;
 Tue, 15 Jul 2025 02:32:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jgUcv7FdDpPJfsDAfAIvzd0Yu7zIC8mz7DxvJAB/H
 Dk=; b=x4vg6wn6P1lgXRzp5O2fFoZw1QNO4ejS2wz0VAYugmJl25jUcMULrTxwC
 RoogmeBN4LDwIFkDV5yunYGgZbdN0vqlM9AuoElFVSICTfV24/FQ8jXqO3fobb+l
 6mK/Z+a3EyQyyq6RRTwDpBlauOt5e9BN4ZrhxWmRLgRYAsAG9UIHX4rdRjFvXfkb
 +it80UuoB3wntknJm2I1fQeLLmvyXK06CDybYbtd9Uw4DUIEF1RZ4Cje2x0F0Cwf
 0HkscySWy8mrWVoCxCg4cjOejaZVG8kMTfFjHlNL9a75fPHO90b73MOuv3t6Qag1
 yitS3/LgQky5Lf20zysbObachhUJA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2123.outbound.protection.outlook.com [40.107.244.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47wm1s8243-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSfjisHQCVY3pDkhZkD6s2X+pUtEJI4dekiIFSr9YwrQ4rCnT2B2uTt7friYNSzmkGM4hmUwU/GmFt2Scn3n5RYsAs0LLL3NEu8II7d1fW0CZRqTaG7LTTHgRZH/OKd8cqfEd/p1hqLQVIgMYouf4AVKLK9DhAr6CrSYnafhWbq+4As0isG/pwOwjpu5r8jx6rLBmFLAwhHM5jax+F20crQ7SPFTgW0PvXyYDwsDNsX3X/19UOf1u88Q2FNIyY7C2LM7wIhhCd0p9yCA1KtMQo5aucKU0E/ihklM39Ql9TotXlEr1rZP/bEjI9VtAk6NGsPjACGhl03DqFMp2Tokew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgUcv7FdDpPJfsDAfAIvzd0Yu7zIC8mz7DxvJAB/HDk=;
 b=yLG40tb26cAUiz1//spcQrUMo3gHZWugkKnohmxS52HsvEqTXrfKIc/Z1dGc2JcOWYwiYJPsimsiOcsOuY4NyN+liBZ/51CT6W5fmNLPFs4MsG3Tcu8Wg+FTIjhw3Ypvk2OxS3YfgV7h8ulUs9nLzMzIp7A7QsY2utmWXnBLPkdH5rQG1xZQw+ucRTCSt2Ttpo9eJtrK3u1wBeEpFlOSm2QB88sd2GX/Qya5KZ8IEefCT/7eek4nCqTdYtH8QKUzdc1evSY3XSMPjyqIYXWUPVvifdIwPwmn/4TKRp0pZrvM7xSOxX2C1GdSyvyiCEfvnyfgQ9akwPnoh8WcwsuKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgUcv7FdDpPJfsDAfAIvzd0Yu7zIC8mz7DxvJAB/HDk=;
 b=Mts4xWgCQ+qdYC4I1LqlaNbtqRlbTrGWcqSIF/fk8z70Lm0nqX3Cl2kqFMihi/EBd6NIZtjrFO05sAyxTQACL1WBnvG7/Dd78QbxDZkZ1LhOiSVEiN6OLu/dJZW8iK3ubU6tKx0ySqhp6aDJxi59VtKAA2E4h1uKHb1Fyweakp9BSiDhQ5ZGIcyQHljTDcBVgi+0qffBmt59Zs4jmlSt21nH6e575uRHVGtkdL77YtDePY7A5V/A+aJrBqgRG0XAx6BVn36iLT2ArhTbIE9deORE3MrjrM4oR9rz0ReZLpgHzXv3hZmfozml4wFsmXzQ0ryvRmkfKDeT535krHjwBw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:32:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:32:04 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 14/22] vfio/pci.h: update VFIOPCIDevice declaration
Date: Tue, 15 Jul 2025 10:25:54 +0100
Message-ID: <20250715093110.107317-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: b7338f0c-1c30-4fd6-f3d2-08ddc38275c4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EfbxfgXfNBk25AYvBgmKow/k7ff9MmhDPiuLxsDUDYrax+AbsLLbXL+Ti8FC?=
 =?us-ascii?Q?zw6b4mCDFni9augYslkq+u/G1JwqqB6pPk62uWDEgY/ZmB7GOSPEUrA4EzyZ?=
 =?us-ascii?Q?2pI8WuAmsIceaM8sPCSzvxRrZdAE4Y3eUH54l5lPNVSfoBoq2gBuy/MTM0cS?=
 =?us-ascii?Q?/n6RWW98rI287Fmez33MIb8buo7hKL1HxhjuaeS0cfhgqDQcBGR5wenqG2N1?=
 =?us-ascii?Q?KDHANnH1O06FAkKb7gvsJ/gXG28lP7C1QgDYczUSngkj4frAt9WR0taIhfEy?=
 =?us-ascii?Q?USUr+8yFnhnPay4UGjr8iVkW6eTuuTJ+v3dN87VYN+WciJvRnhUa5jrjzBa2?=
 =?us-ascii?Q?6gsnZ9xuqGqLLC2NOv40kf7o4nU6W/4qd+Rzgow+VDtPoZOTiryq+1hVqtRH?=
 =?us-ascii?Q?sy3nLn5Omr45PdA3stWQ9vb0Q/gKvHEKlqIqMp1wNTHpSIpSuVBc68OzjOQx?=
 =?us-ascii?Q?I5hRp/xfrlqtJ3PqD9pO+hkTdqSsS2REVzjuxYe9A6vz0KYQsK9wGVoZmmD1?=
 =?us-ascii?Q?TLkeYXRaMaKQrew3vzJRhc8zqNqY9UDgR/CjKo1IqcWg1ST+ZzmgENq7nVZO?=
 =?us-ascii?Q?I4ld+HyumZc/fxzlyIwHiVivmI4WJ1qt+xIPtvKmgw6ufBNJwBKSLieFnExR?=
 =?us-ascii?Q?HB5+qE3krVqRPS/EmFOTICchz3f7jhccRdeKNTZHHXz8rDHyrf7yHxOqDSAX?=
 =?us-ascii?Q?x5uPmpuecjVHl0t51aNSo8maSgpt+4VN1YL871lW6AKvNTNZtOZa6cLE3Ewy?=
 =?us-ascii?Q?dptXQ0YsKgMT5knP2H3iW9XwVOgTKmhpLoD64N8UCbG/Beu7x+/H41/B4gTS?=
 =?us-ascii?Q?/W6l1Z3qsBTnMtM0J4jLuyxGVmnJG98r04UGZgwLGJd2QcRoIhFFdFtJD8Yz?=
 =?us-ascii?Q?dSDHIU6r//G/LVmNF7dlaTiw9j+y3FqJ11JmNpuMJkEtqD5DMSDl9OR4/7/8?=
 =?us-ascii?Q?MBXZz7i6Cpi2Dm8o2//N6DPGS78BCXoWezVMtDfaoAr0/4Glr1+wzXgBmti0?=
 =?us-ascii?Q?Os0N/IwEPfhn392v9QhdyDknA3vXfWVtL1/wBkg9SpnX93kmZiORQSBLMPFS?=
 =?us-ascii?Q?b5WXIQ9bYt2PQACRSbteXNImeI1PDmQPGXfvM40WhNi08fPE/VtuceYm/SN2?=
 =?us-ascii?Q?r2v78f3ftfCb2ddx4bGNlT33AXw95M7jhdrkmmyAcjdChxCkwdtFOUpQBpKj?=
 =?us-ascii?Q?GIn4zOFK7H3//2qYJeL/OtFXQ5D3gYa/Hi3FholjXf8xYWZGZO1IHrjfDfcV?=
 =?us-ascii?Q?IDBj7fsePV3PbFxSnYlzJqcL3dWXtZ9ZGSQCLsWw+GQihvKWf1qkqNGl1t86?=
 =?us-ascii?Q?hOoa4YVLtE1VTAyn9mRmtmmGuVGBjeD5BFW8PNSA39k41CiGRy7Aof10h0/X?=
 =?us-ascii?Q?Y3nVJhV8xHyxjy3HcOXReI2TdNOTpqtil0PDm2GnvmdwMhHKpaJPKLx6oiEi?=
 =?us-ascii?Q?rkcJsqhPx8bshimHsPR2WTRoqrZ5hLeu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0zs+2VXI0QWzStJA4MiL6wRk6eW0J4UVygxJbmtP1gtMKw5j7Sd+Rc6neyXN?=
 =?us-ascii?Q?KR8c6hviowwW/jKdjIUc3nkdYFjim8Ng/dAjN1xReENxXOJFBXJTcSTr9+pC?=
 =?us-ascii?Q?F5OkHYrv8sy6P7xQomtNyEqwWbtHOJIn3u5Ioo7ObG9SxM+laq0zFfTT4M2o?=
 =?us-ascii?Q?7bOjNQAepG8rZGdvPqMuzRU3201cJMBThxTykUwopKSpb39peEAn/jXuJyhl?=
 =?us-ascii?Q?g4zXifBW+s8xwNQfZWHN3CSVN/3+Sf0xeHObOnEI3rU2cBBUhNq4TsE8DMnv?=
 =?us-ascii?Q?J13WVSJRg9rrGa7+1WtJXloRbMZt1baW2Iub1NHlIZBx+NYZupSqi7OO4kta?=
 =?us-ascii?Q?rHP1wHkkURxPnuXB8mbG16IIeGiCKlB9Wte/HNovz8zBwy4se1eCwLBWEq02?=
 =?us-ascii?Q?JRFExCOwR4Z4mrHtZvYZaTeV/G+dn8lDlcVf/Rrah4tK5rzjV4FHljdKc65v?=
 =?us-ascii?Q?70kpAabD8Slvs0Do/CBdKRRIkXTwj4rg7AaqlNYWEI0ozVWhCxeo2bsRqEa+?=
 =?us-ascii?Q?m69krGCXjqmYVAfQiutKzPoY73Bt1NmWYYsXuFOeb9/IQDBFYbwRH5IozGVY?=
 =?us-ascii?Q?JZW17EJi7BLvHK0chBvIhIXuhEws2qQXGylbO9EaoHfmTqzNRyJEY2R5WMZS?=
 =?us-ascii?Q?NC0+8tLZRkZd90XdNhL75NG5bJZpcHPl2Aa2FlerD6Vu3lcwOVd2fmHwb+F6?=
 =?us-ascii?Q?m7+e3gjvJpO2uQkzaKTsgTKNVb8N2EypvfeaU6elu1/HI4ApUNrgpvj6wTPx?=
 =?us-ascii?Q?Ho9hkEo/mCGxFebDdLuy3e0/NBxuiENxthavGFQjNLg+bDAwIhn0Lj5OP99o?=
 =?us-ascii?Q?H+cCYLg/T+nhj0IohxP/NYAyNHppDVxgaNczd/k1Dgk2JVhQXDn0W0KoVk5R?=
 =?us-ascii?Q?2WlvE83QKc8FSDLnjFCF6S8zmGk/AqSM7Dd6BT0KyKtgwzoaBcWeFDolM+Pt?=
 =?us-ascii?Q?Yy9OFBE+FPV5GWcaCaR1mSTUawVgWUHNHGI8zrZ8Kk+VTA/cTcD/7AcF3JgL?=
 =?us-ascii?Q?k93ynSJG/4/m/v8SN9ROgCe3BPOu+dNzjXJkvdp7ooAptjOO1vAS1vBmoek0?=
 =?us-ascii?Q?lHD1Lxja5Xd5eZi1LklsHg0nOsjlwTzQMVDrX8G8zKO5ZdVp8aZbvlFe2ut/?=
 =?us-ascii?Q?94MG1gMs/wYoOTYcasT5DncFQmWdpHNdl+88hSiUlQS1bgRITVRZ+zbTnhHl?=
 =?us-ascii?Q?ezG5rQmKfuOrkjWHpwcNYL3X5Bbtpm+IktR3sXvtzDEai9c9RXuy4ztkYFnD?=
 =?us-ascii?Q?Lz/tJ95/hDkiTOdlQaR/7J93n47ViH08KMpc2+QDOhEpczmieeSpCfuihOG9?=
 =?us-ascii?Q?NsHcvxpWaZS6lzPKZgWuzIfUaCFfSn5WLZjCJEXnfVWRIxHMZ8EPjMkr56zj?=
 =?us-ascii?Q?miI+g2YqgB/pVcbpQzobzxcMv/ChLxc2N5ETbWy+8Mm2uIUySKmllTUCsdnu?=
 =?us-ascii?Q?TNadjY0+uSMtAo5E5SbSqXvcHT1U99FxJfyxhY6oMGEdHIK07pRBbj8+OvKy?=
 =?us-ascii?Q?ayWL6thnd1x6Sbwp7eAGb1gQoMfqu7KCXPgvzWlesllm1uYjXBwm3ZxMMCG6?=
 =?us-ascii?Q?i7kORlWMurrdejZvEBZvT5XnMwt9JEotpFng6oU3t1yqVaQrwbC/HKjTyHoz?=
 =?us-ascii?Q?O95LyWAQ3Kc50TZ1clWq8qPSwNt4dIJm661l9Ahn4uRX5nz0DJY2HF9Afz6R?=
 =?us-ascii?Q?H6U1Xw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7338f0c-1c30-4fd6-f3d2-08ddc38275c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:32:04.6894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+ZaGNmPN/uYhUrnSi8e4S9ujreox0PgJXediTJSbiwcpz1PjzU35Y1nYuJRFY5wAONomXyJrOgsNVZrY5Ymi/4gCGa/T7RAjhbcjUo4LRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfXyErgj72qf9TD
 nOaYRjthSxmufwN0qxymLrl2IWY0SZd2w/5+hjI599X6qBCmh6ejvghKeNuVMio+Dm0U0yoJBhw
 iuJcIl3uMY+cmgefzo63NyWL8V8EYgyq8EQmy+nWtXHl6qYwpFnO1YoMmfumjyj8ahPkaTNYXRX
 +UrW6vrr2n7rco19uGxeQu3a86h9lncyp9om2QMfPl6otA9hsgPfKOhiTaNEbL8dlsOcVZwB17o
 GP2mEygyAY1nrQ+RJ1W0KTh7+L9p3izFQ3rkSvKl0CXrAN5P7mqUZxshO+PVpDym8IoAOaMQMFf
 pXW8lwOYsW4cZUEvJ90nLatyBEOJRjkDlHPTbuJ2XOHzO9nGSQR97WXLNeGksJiz0+MobstHZbt
 5fbKdUWkkl1/tOoKxfLMgr1vI3c5PKBTz7f57dLE/eY3Hb2+rupP3GXg1ogO/VxpqdkIMiMF
X-Proofpoint-ORIG-GUID: lOnTZPQ12diNGJlQBQ0oSBWadf0RwV8G
X-Authority-Analysis: v=2.4 cv=fZity1QF c=1 sm=1 tr=0 ts=6876201e cx=c_pps
 a=iT0IPLB/rXRz/LGl7erAeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=O4QFABfiTHIwT9Ek5cMA:9
X-Proofpoint-GUID: lOnTZPQ12diNGJlQBQ0oSBWadf0RwV8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Update the VFIOPCIDevice declaration so that it is closer to our coding
guidelines: add a blank line after the parent object.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 495fae737d..16f092a0c6 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -132,6 +132,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
 
 struct VFIOPCIDevice {
     PCIDevice pdev;
+
     VFIODevice vbasedev;
     VFIOINTx intx;
     unsigned int config_size;
-- 
2.43.0


