Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554A8D116F9
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0eK-0006FJ-2x; Mon, 01 Dec 2025 04:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0eE-0006DN-PK
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0eC-0001wb-C9
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:46 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B19r1Qf1346015; Mon, 1 Dec 2025 01:56:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=T9JsJr4PWKAwdbyrB82pCMqe61eHSt+XRuvamKuvH
 Zc=; b=NoFRi8J+DYOb/NDi8U/z+7Ml7T3aEMCH0eKADf+gfdeqgKnmHtqnb4ZMi
 7/wPY2mcnDy5MfgLSSJ5NczdreNSsWcpRwdYIXx8oFM6A5dFsUi7RKtBQD8vfgEF
 n0Ohon+Kv0/T0ERfTwSnVfQLqRvoSAt9jE1GL94XCPRMruIvPz3SRetVUedl9L2l
 2NukyTEJlXsphgCjFg8H7x3GEhZ/B33QAdH9rmiKwbcKZk1py3wgpV/AlBZ9f+NB
 wCYhT/1RlqlfFkmKoJ0zp1tz2K8IUi0fmTLQZxSepBWznqNHsgBH6FhWKPa+O7dz
 GfrAysFTF1NtWmvZa4ZN/C1hqciWw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022114.outbound.protection.outlook.com [52.101.53.114])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ar11e2hs5-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Dec 2025 01:56:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3nxk39MEIevYbRdO38czlpyN0MLHhv69Mi6OoLspPngU9cCBjCwJFqjGSYmePdF6uW+iA5Tb5aHCWuBdawEo++02pCdExQ7YryeUWusu3qRG606aCuY6NNhark0y2ykPP5wgQGM7JbHPGHNXuLgB+Mb+WcX18xiXKzksPCVULJRrReLQBHwfdhSW6q3xOxiXpOPXKt4N97xcf6f59jZ3x7HmluPTA6k2F5oMLfF0FZoPANh8IDFwbgcBJg1SxMIyq+8cmVGiZgrWFJkRhYjwAwf1QNRsrxIP70jR47fGJ1HEzJZstC+2YKVTUHBdPg7YQE55Js32YkXnN4mofZiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9JsJr4PWKAwdbyrB82pCMqe61eHSt+XRuvamKuvHZc=;
 b=X79dtt6pyV7UlX4WveXBqWdDDd4sRIcJSFkIfn8DxZzmlBgy+3+iL0c8zHT7vODXWubgLcZuTm9knbbpXym49qGYuMKNtjK/i4iPuaGawUAKKg3GaKLU0C7IccNTW8KwHM8889S4i2hm6dQQ2KSpe218i47g3BUkwi7Vo3qhAJJ2shT+PpKCrATlCWQRrrkFT4AQK0b0jUWVvutEU4cqviVcfMEycwvhTPQtu1+mebaGj7d8kAZt9vAu4IqvNYt+EX5b/zTBgVYAXMGQnaTkS4PCRl4dl8KyrYZimjO3/Nt6diM/2anXcnSb67PMpZsyOVaO93o3UfmmPBhbu64rog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9JsJr4PWKAwdbyrB82pCMqe61eHSt+XRuvamKuvHZc=;
 b=Z4GbJjmyPXEROd0gD5pPQ0nf8b1glH9yEQfnR3f2Jaq+/hMRJLGir28ZnSqYpCBvzHS1qXuwL90UdwO5O7QANhL93U93E7IqrThIXaQWoz/SN27t5+HSdyFtvTGcwPNs2XYs6E2wu+CDv09XUwmiFfRO2UxsKnV5VHX2JqMwJGXyuXgEQ1JfUcc6PU8hDKxVQ/tcSD+hyPuaI4CKfnjDa38oxspIRfzsvSn/1Z1seq7L9HOpf7DtTkeVR8+c3/OgNaY1klFCqKkkj798remKGD8KAWRtfojWNQp1yvpMoLD0u8i/aE5xfTt6NZqdaOm0bRYGB3BP9x5+h4zYJGJ5cw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB9865.namprd02.prod.outlook.com (2603:10b6:806:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:56:29 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:56:29 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 4/5] vfio-user: simplify vfio_user_recv_one()
Date: Mon,  1 Dec 2025 15:26:20 +0530
Message-ID: <20251201095621.2786318-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201095621.2786318-1-john.levon@nutanix.com>
References: <20251201095621.2786318-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0576.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::23) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: d832a025-b3b4-48ae-a1f7-08de30bfe66c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CZyCqWLIjfJ2j80LvdyEATI/hdb66fzPK00J0fCRP+l9FZKoKXQ9hpsV0hNY?=
 =?us-ascii?Q?+y9g6SsCQ535jqVV2QYcPDAiagX9vZSIEzCLDM1nYSQ7UTvxT46kOHHwI5uE?=
 =?us-ascii?Q?B+lo5yP6uJGV/y4x3GjdRmxa2vsD4v0F+XBLZoBnKB8VlNLlOsiuLXw+VFBR?=
 =?us-ascii?Q?AXuxviqBnhW8dhVEsQAofPbynOvf77LN5bglm4SsUoayfJH3XlVBIc6ePmxZ?=
 =?us-ascii?Q?L9OpQ/VGhzximDg2GAcWfGwDHWxPRBcKJ5FaKpQM+vZJeH8u+WcsAoOzmZRW?=
 =?us-ascii?Q?u/Q9lxY6B8oYU7hpUHQbAob3Twb7pDTHNRmd/a5B6lstqVgsbLl4bQhIHXme?=
 =?us-ascii?Q?jbljFY92OpMpiZn4a1tRKLnmE6nx4EvTXji87pyyObbJ718Si9IL8MRWFr7G?=
 =?us-ascii?Q?uKAIOvaifD2ZBX8qM4qwDj3D95mwakzJp+l02cgHxJbICixPOky/1IGuUhyD?=
 =?us-ascii?Q?YOJdscqEeARZPDJLF2A+Z1hJGkDR6K0NBGZiep9KVknKOiecmhTeVuqzpZ0k?=
 =?us-ascii?Q?Om8fjGRpofNqrJBBtoRMMXIGwjEk7cZ3JncJbMfR7vF2mC8BG44gsGIrf97T?=
 =?us-ascii?Q?ypqv2cWnQqNMRvVolgp4LKcprLt3krubVxYql25iTuTt0b9Nb7Ia0rtovuVs?=
 =?us-ascii?Q?q45MVtkFevzxSHsehvZLuEOLGzOjmbQU4EfGYiI8zX6v4x8WHEaaWI9p1ZJa?=
 =?us-ascii?Q?sU0HilfAsHnGnBbeYKQ8gKLlp0wqWxbYAkP+Y+9ZS2Kw4d9HLmYZtbp37zvP?=
 =?us-ascii?Q?7zOZCVcGl1U0/FR1M3dkPKyox6RixKSwU/9eF4e+8RUySCKTitZDZfCPWTsG?=
 =?us-ascii?Q?6+4z6MqGAo+y6UjN2uqKneCI1PiDwxOhjSM67xAUcDZFuyHQtv2JyI8bRNLs?=
 =?us-ascii?Q?AEGhQiagtJJkVcGF4gIiolbHWm54JOXHLu+i9jCz6qTaKIuKqkauAKb8SHlH?=
 =?us-ascii?Q?XIud1C8Fn8k5Pnq7ZjrP9acmFP++Z7cWaW4K/n/iNWy7TbvhA15Dxv4ketPS?=
 =?us-ascii?Q?W+YUChG5nK9XbFVPk5DyQ34+LcbYDiIMEubbNzxbw8aveYZrqY17jBd8IRzq?=
 =?us-ascii?Q?sWQvuZvdINjZu/ZTB5Tw7/7bwroN3tHAJVvuIeZ87BgWrebZY6AT1ix1x0qt?=
 =?us-ascii?Q?rOecaowEcT/lkkCGiP/OPBiDQECbeeYQy9pifZGntFef12TF+cjRfA8pR8SG?=
 =?us-ascii?Q?U8rMVyMECnNOuDJj9MhjbB176jfopyibu0DNPLydGwqkjxlvGlTewuQxVu8z?=
 =?us-ascii?Q?aZj3pGAVq/GDD/jRUmtVJ6Hr6a/wzSf8UxAG7iqp8Qa2Y7ACWq1FVrgdo4Y0?=
 =?us-ascii?Q?cFOVm5atV4QevRHvhgmHDF2xGbZ7OPq2xOON8/oXtBC8lK7+ehHbnchkuUSw?=
 =?us-ascii?Q?R4sJk0KHOJcbyYfSeW8IA1jOvsS462//CXtnqTDRraVckus6bCjrunMaqh0b?=
 =?us-ascii?Q?2g98uG/eosDMEXqxIXcHsWJx8/6TIDQG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S/JvugGjyf9QubWYEUPFNj3h+KCJAfbxsuhSmx11bdRx0OU+rUBmoa/nfzU+?=
 =?us-ascii?Q?zc1Dr+yj0AhpbJoGKBKF0XeZAqQVIlo3XJbJ0eyG2pnQHYuDd2i06/+6ezn3?=
 =?us-ascii?Q?KgF9Wt0+XuKiWFsgwyhlJCPsYkGK4RN752iq88yqvqpzCbsYThy5NLdhmzl1?=
 =?us-ascii?Q?WLjs7Whc4Ibsz+OVl23pnd/qTtpGlzuVkreyF6ohkl2kbvCrdhUxlVWVwpcD?=
 =?us-ascii?Q?0sq/UVkF1AHzIS+aLiI7AxapRrzxqGr57Ndrw/El733rOSaTxI1qHTHL2+yg?=
 =?us-ascii?Q?zYoyxLyaMhFUdRx4f7/mpCjOp/bXzW6XYx74TB+58x3sJx7UB33p0CqBBIzs?=
 =?us-ascii?Q?2zFnLUHkK9z0A8a27lzszTummQQeC8i7FFJGYhjLGOazGu0sPDT3cYF1jD3G?=
 =?us-ascii?Q?577sSS0Poa0dqnHRZTi71SjgZy+mrTgYMHdz4MmpwZ6mdg4OZPO3P5ya5yxt?=
 =?us-ascii?Q?l7RxL+6wF5FdcyixzAFH2xUQUJuNJJEmqA89OjKFSOAbuXHLuyB4A5kXgsG2?=
 =?us-ascii?Q?zRVb8PuOVeJFyOIJ7oZKOULqqLrgbcPT429qUKHAwiDdJZbGl9YFe5o5LDXn?=
 =?us-ascii?Q?8/s7brDFJSZRDGXSjOR3RkMZeX7s7x7c+l7vs+HxPMRPzhiQGSW/221xQxw8?=
 =?us-ascii?Q?nHqJ0FWN6p7jRgatIWm8J6E4bcEHWkXmOK6JY9bPq69xeyjieKZZjcnHW/s+?=
 =?us-ascii?Q?JaUDAzkc3oYTYuwrAsT7iKeuDUN0A3bQngBku4ZH4SnTDX42Wg503p7W+CSB?=
 =?us-ascii?Q?tzWCQ5Y3ONNlAX6kuXXbetgL+oaM4LnQrr+bU/WQEwY+XkHbsstejwU/POHR?=
 =?us-ascii?Q?hTSkStrLtNTJhtrdrO+/WM4IIvs49oD1/EmU93QQE8jMhZyem9mOVGaREsL9?=
 =?us-ascii?Q?p4MjFxPD4yUaSFA4ZqR+2owhT7uc4SKAHXroUNFFsCpZ/kYf3UeYSHwy16Hs?=
 =?us-ascii?Q?AS/xsc8UnWceOTLPJI5JG/RB/AztLHUXady7ZLY5T4Khsa1Jrat4OCwVcHcg?=
 =?us-ascii?Q?HWV3G8CkWZjnlYUez7qOAZ3HvRzxEw0iPgkmSFqcyi9tRzrz+DI5ukV13uKZ?=
 =?us-ascii?Q?WiflvZbQwOlyZpYL7xAoo9s4nvOyCF2fExikDzRTFFEW6ScvplBbVSeCCa6x?=
 =?us-ascii?Q?GuMv+QQhbvcLPV74nWVrC7GdlNhkuEFj5Xy6I0FVos4LFf2esABmIIiMlud/?=
 =?us-ascii?Q?FdLecKydxYIe7OvnL0fhpLk2IhCAtnFXZfRb+mx9kRyjWmi1g4xWXBJaxU5k?=
 =?us-ascii?Q?94W/8S5KWWD/ltUARIcwHJMIjgmje1ayLliq9eI2H6UwlaGWBO0n67QQjF9e?=
 =?us-ascii?Q?DlSSIeS6FFkrKmgUJSUlFG0bULYpZ7p3LtYttYADNBlc9vEZcXm5y6yyV7hz?=
 =?us-ascii?Q?B+WM0/ShxlD/LOHEAl0StLBXPJpvQUgd0vTwTk2HNFbpcAZkmAOk/fckesyp?=
 =?us-ascii?Q?Bsm5k/q3myOA4l2V/xwIihBc2j0ANE17+eFUVAGUFjEiaBUBo4d2tAtE9DmF?=
 =?us-ascii?Q?tNDZ05ntMubCSoGixWAx0DpELSBgmlAZuX7zAE+bMAXIAeiO+jVHKBEZlSXG?=
 =?us-ascii?Q?4NH53lNXdFqIIFTKfZaduHiAPKvGXOEYIlUj4h8m?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d832a025-b3b4-48ae-a1f7-08de30bfe66c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:56:29.6997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRQyk28JuUXixwIq+THWOF5fy7gxrbQf/7QxK7x7+hgfzR5SxiWQzYNFNf02tskCEXxnoakSPRfGSgfBFW0KuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9865
X-Authority-Analysis: v=2.4 cv=bddmkePB c=1 sm=1 tr=0 ts=692d665a cx=c_pps
 a=PPij9JC9dsFwf49xmEs+Gw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=jnA1zMGvAcXXG4Qj4jYA:9
X-Proofpoint-GUID: 1tpKLB-YeiaLSMUBOWuxLizJzbEetReH
X-Proofpoint-ORIG-GUID: 1tpKLB-YeiaLSMUBOWuxLizJzbEetReH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA4MCBTYWx0ZWRfX1Z8iwJVYGXMQ
 GSENbXudgbP8UAls2M6pcn7tmNl97MMvbaFXa9D5aO02vN7VGM0u01JPDzsmdtJxQmz/33H1pLH
 Dr9V+fcLqARI4+QgX7EmioOKBZnG0s8YR4sI0uSEpe1mbDlSe+wnl5tW2VKDKJlSEqQqCcwYAF3
 3osaPF5G1dlLzF5euWmSDC80tCd6vMDxO4TKhsbSKimZZJT9Fzlzk+OgxK+RfeTaImpjK3Qz6lT
 XZjVQk8j1kKDfGxgXjKfMnyxHpu4/o3PYmkawBynot+MXlv2rLUiGxQpSNiBNlQMjeolVSpE8Fr
 qCwcUNqWCGMmBWuzjUXQfwtEKK4xLFhJInqElEWuAm/NLvLbE/08U+vwQ3GkWqBVpGISFMw4Obc
 2biVQgud1EvC+QKQUIqd9GWMQ25g3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
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

This function was unnecessarily difficult to understand due to the
separate handling of request and reply messages. Use common code for
both where we can.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 68 +++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 87e50501af..d1d63816b3 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -281,15 +281,14 @@ static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
  */
 static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
 {
-    VFIOUserMsg *msg = NULL;
     g_autofree int *fdp = NULL;
-    VFIOUserFDs *reqfds;
-    VFIOUserHdr hdr;
+    VFIOUserMsg *msg = NULL;
     bool isreply = false;
-    int i, ret;
-    size_t msgleft, numfds = 0;
+    size_t msgleft = 0;
+    size_t numfds = 0;
     char *data = NULL;
-    char *buf = NULL;
+    VFIOUserHdr hdr;
+    int i, ret;
 
     /*
      * Complete any partial reads
@@ -317,8 +316,8 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     }
 
     /*
-     * For replies, find the matching pending request.
-     * For requests, reap incoming FDs.
+     * Find the matching request if this is a reply, or initialize a new
+     * server->client request.
      */
     if (isreply) {
         QTAILQ_FOREACH(msg, &proxy->pending, next) {
@@ -332,51 +331,44 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         }
         QTAILQ_REMOVE(&proxy->pending, msg, next);
 
-        /*
-         * Process any received FDs
-         */
-        if (numfds != 0) {
-            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
-                error_setg(errp, "unexpected FDs");
-                goto err;
-            }
-            msg->fds->recv_fds = numfds;
-            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
-        }
-    } else {
-        if (numfds != 0) {
-            reqfds = vfio_user_getfds(numfds);
-            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
-        } else {
-            reqfds = NULL;
-        }
-    }
-
-    /*
-     * Put the whole message into a single buffer.
-     */
-    if (isreply) {
         if (hdr.size > msg->rsize) {
             error_setg(errp, "reply larger than recv buffer");
             goto err;
         }
-        *msg->hdr = hdr;
-        data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        void *buf;
+
         if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
             error_setg(errp, "vfio_user_recv request larger than max");
             goto err;
         }
+
         buf = g_malloc0(hdr.size);
-        memcpy(buf, &hdr, sizeof(hdr));
-        data = buf + sizeof(hdr);
-        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg = vfio_user_getmsg(proxy, buf, NULL);
         msg->type = VFIO_MSG_REQ;
     }
 
+    *msg->hdr = hdr;
+    data = (char *)msg->hdr + sizeof(hdr);
+
+    if (numfds != 0) {
+        if (msg->type == VFIO_MSG_REQ) {
+            msg->fds = vfio_user_getfds(numfds);
+        } else {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(errp, "unexpected FDs in reply");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+        }
+
+        memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+    }
+
     /*
-     * Read rest of message.
+     * Read rest of message into the data buffer.
      */
+
     msgleft = hdr.size - sizeof(hdr);
     while (msgleft > 0) {
         ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
-- 
2.43.0


