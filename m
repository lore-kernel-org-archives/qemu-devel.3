Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EB4CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1d4-00089O-MO; Mon, 17 Nov 2025 10:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1d3-00088u-7P
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:58:57 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1d1-00012A-Nw
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:58:56 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AHBM5Ui1475642; Mon, 17 Nov 2025 07:58:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=argFErk9+BG6UXt
 PBYMHMNiVErUGV5cOEkozkHItZ/Y=; b=aBlaWMRnO8Htpl0R0ooQ8u3OJXjAKjs
 jV7sUK9jaVsK+/o+vMsBrNj5xePbafDuLC/SwJP5FYhW2Gpvj9XLqVxFwQTl+Py4
 j4xqO7LEz+HhfRVZsZBcHVIWyNUawDCKLuvIq6EBLkPbjqf3V9qnWIbu712c04ax
 tHBGu5raH1FyJPvmaorB3X+vOcOBAQ5hZKbp1weMAJ++i8kV2/hIB2BuoAbJN3uY
 e4b1ausRh3jcYvek4YbjmNrgFnsr2fcPjDW3FqUSm1V6Rg16rA+R9g+wQ6FX8kRx
 Jotv+OqECQrGZ4VXJ6FkwF9PoNNmhUbmXhZlgEdT7E3k6OrzqLOZBRQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022108.outbound.protection.outlook.com [52.101.53.108])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4aepa8kq79-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 07:58:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJkY9KR6S5O/eqcvDRG8KHz7ny2ZoxJD0w+sBxkQe/IHkB0gYPbiy0K/2fcja+ggBKE0dA9CUPqVCRrUznQMAo5wd9mmTFrIsF8v9SPtqJX5GK/H0VDFaaV5ASxjp0JK+oE1PJDaANn/VAONoKzLJG4TsIkqmez4u+TnWtMnnlUhKlCJl6M/V232dx0bQrpTEGxiBW6njs78D3sHNb12kQaTpQk2vtQk5ueIZRAQM11S92qmFu8rZDx5xJNM7LEh9iCrgWG5+J3Rl30wYERLSM2JQcWH0+w+oGqxXIkMAVoX9JSp5nV1nHv0G2wAJDv5ejMf90hy2xEGeTVRaYTE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=argFErk9+BG6UXtPBYMHMNiVErUGV5cOEkozkHItZ/Y=;
 b=lOjOU/kIlaekFDXgHxt+Ci/nT4rXncMcdXA8p0W9hFEO8we/W+j4vghB1iS0ty+dWww6z8aTbfJegW/+LLQHFL49W55ES9JZ5yktKhKGz5Ggjj+M8Xwgj3Fm/eIDMgTCtu+XQn+JKr6gQW9oFIUtiUu8QSvL7m28GpCDQYyGdhDYQ3GI51KIXApY61Fm1dN+OO8dYKXRl7yIBwQERZ1e41JWE5SSINQx5YD4SR8nfpVAvH80X9CxZpSY79ZpVZt1RrECHFJ5Bqhy4Yl+aMln1MRe2899gUtBN3fR92y5ys3Mbtid+Nq+9uWycb0Wr2H69/ZDihAzO8gzqC9F0D7v5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=argFErk9+BG6UXtPBYMHMNiVErUGV5cOEkozkHItZ/Y=;
 b=ukywm5sTCFAqTU2iA+rU1iJE2qy45XAKyZJgtXyUEIyBZU94w5YuFpeGx1vzY5BQbWmUA9vv2f1ESwvQQabeAa3WSjVUcFrNnRKXZRGKW7zvD0jUbsHqzuJfRgY59NKr5J+qIL6xFsd9uEeC4QIigJjAs3r7wPPOCfmx4jfWz7J1TUFUMSPActIkDtNudOiJbhjH5ZG7e6+hKVIAtuwqIztTjYUMQscDmImTZm5ir8dAl7kMV+FN9C0BUKWyPtkV7kCaiFJvaODeCibaDu5t/fUiKq78B1a+67qspEeCscV4mP2UJYIBdB0qJolqNm6p3Sfl8NvX1u2nTM4g4R0Ejg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SN7PR02MB9379.namprd02.prod.outlook.com (2603:10b6:806:349::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 15:58:50 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:58:50 +0000
Date: Mon, 17 Nov 2025 21:28:47 +0530
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 5/5] vfio-user: recycle msg on failure
Message-ID: <aRtGN_Ji-HJDcXAC@lent>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-6-john.levon@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117155656.2060336-6-john.levon@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO6P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SN7PR02MB9379:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f020a1-de38-43ef-237b-08de25f2335d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5xRD+knSoDqj/WiqWsv5/Z4U1uuZw6lvXPGQ8qnXreNnZEvBZUzuc/SCYTax?=
 =?us-ascii?Q?kUVbkdZ8ULGdj9E25z1hYd6zdfmurBGVUv08Os8keEwolk42tPqZtYxOd7rX?=
 =?us-ascii?Q?5MxlExFt3dTF1f7XKWSweiHGt8pynl+TUyui89pyvJNXoR3Jk/emO3KTLfbn?=
 =?us-ascii?Q?jmJc57OIPTA2XDLHvrz/ZMCHtxtlNJxbMQj0Yfyva7OM7APlWN4lDSXJpH+M?=
 =?us-ascii?Q?/P78COnI4Wdyl3diC96hCRdwQVhqIjvtxpig2dcPNIpbP+ePZ4fAxIgaGVG9?=
 =?us-ascii?Q?2i+Tk5+PQTQeO8mCd0bFvPPbPV1KTkirTFa+2wV84cskTnQDNmqAZowd7KeF?=
 =?us-ascii?Q?jbKnHMjTj/S7dbE++ER+Z+Tg7atmaYdBGHwI6pXt7JNq32f7hJJcj6vc8WlF?=
 =?us-ascii?Q?8R+2em1UzeXZvd213ozbZkP5BbwAyy13b59fUSRhsaDNKMmuLGmOMejNkDzW?=
 =?us-ascii?Q?H7L+DY/7r01vOV2MDJ32uHgufImwiTyftW5b5H1l/rU5r3DRyiohtoQvqnJ9?=
 =?us-ascii?Q?1m1GMtH5XDwGmqTBm7WmyuQIf2u3ufSIFHsnZg2AYAFXIyW3W3YDrHXVPu/Z?=
 =?us-ascii?Q?Zav8JfEZ27EzhAQoAK9lsfEIk2LUqv47JlW5JGA7bCOOcEuqjgnFlHDgHbTq?=
 =?us-ascii?Q?gZg4mvYN7Vupnsqv1q5FrogMPWuPmP8stql0F3HJaojfj/Pb+kXVf1FfZpj+?=
 =?us-ascii?Q?U6khgboR+Sqb9f2xy608M+YfGlJB0+fQyf6DE7YJ97Vg84uEBgsvhLzCKDlr?=
 =?us-ascii?Q?AisAs0hZnoofUEfZMfXHu/sJ/0heT0Icj7VgEQq20t9WLRLXdm7XfgvUAPph?=
 =?us-ascii?Q?68ZZlK7EizZT6MZ6aZWMisi3JsYtGod/+qtXaJWU3DJiKyK0TKvnN+PiWBKe?=
 =?us-ascii?Q?+qtXQr+nG5P7TQdtdn8P3oiec+4gVF5QSN1rlCeGGxMBYd1/vbSYtfl4tUX8?=
 =?us-ascii?Q?LPK7guUhiLvggZvIkhnk+Ra8A6Dou8KT0qUL/tzSCV2njnt9zmZWRaWJrOvJ?=
 =?us-ascii?Q?jgU2e9ZSO32gZq/FrmuZheLVnUW9u0pOkKCGB4fcjHYigT6hOC1kwCy8H6I7?=
 =?us-ascii?Q?xmo0qu6AE9+1E4682PuNzu1c8HNahSh9NUESqWjGVLqBZvs8tjphfx3poeB7?=
 =?us-ascii?Q?6e0Jqs0aSC20WHIrwAtfAdxoYYd0PF/fhA3pBinwLZVgG7bbLTg3tSUlmgfI?=
 =?us-ascii?Q?aJKnDvy/G9LGtIAMYZ3/LG3nrJGBRKWnD5wD5W0rshF6da0MK2CuiO1pWibo?=
 =?us-ascii?Q?Us1W49GbI9Hqtpm+B1GuwcIgGewjMNOjoTYbcJr7MVDnxOBc7zG9Qra2aX2H?=
 =?us-ascii?Q?Z/kdzTWlvLKHja3B+a3HZ0OixaJazVS5hXyRDZTMBouGGNqzJhBGclEjUGBf?=
 =?us-ascii?Q?yVgAVjzQPK+IKytyuPtVlJJY+YDrzIY1t8ArCQw8aW3DkLx+aut0LjwB7BB5?=
 =?us-ascii?Q?vcqP9YQmdw67xWudsdfdF/v8kcfcLoE4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u5XpT0LwpRT0TvDUJkm9CWvDAwHbuX4l0hc+DSPnMoId5st43j7jcsPGJzOE?=
 =?us-ascii?Q?6xtr5RNP7UYItjQZr5bochfVJVCsZOB+BA1bgmiGMeSmPFFl/Hqf6f6RS5VB?=
 =?us-ascii?Q?/Ry4+2Bi6iL429zus8ObxnncLgGd+oPTYZXyiZJEhGK4E8+YCDfmKvSPp6xD?=
 =?us-ascii?Q?VqHo3kZiHjrCjB8Scmgms0lLta3K1Wsolonqw5eA+q6CeIojz0WOjdt63QyB?=
 =?us-ascii?Q?K6Fqxnuw67/Cq+fdTyPH65ZYTpJzuW5A5o5jxMJOiF4BFFzUN03jKCV54Y9A?=
 =?us-ascii?Q?fpJKFAVQy8NLi4Sg4Mgv5000xmmf3JCSHH0VD6gxn4ZuB36PyuqzZWLG19TA?=
 =?us-ascii?Q?TZgtuq5G8LEvx/oqoY41QYxhPNkC0r0OL4IM6+R07kZBsaFFL4omVn5iXByu?=
 =?us-ascii?Q?4DolrYSI4ISNRw2Y7FMFthm2lVTWdvJx7rCS04RzbOJEECOVu7GO4Wn7rrbZ?=
 =?us-ascii?Q?/QWv48KkcfU12NrZdNV/n+RIjTe9oaHgg/A2ykNKCoTCPfAbHIlqn0uzDBrQ?=
 =?us-ascii?Q?qgNWer/FUGFqsndvXA0x7gS7thM5H728e+PgDXHDAy6izmjwk70rOaPPrlgR?=
 =?us-ascii?Q?uB33+NXB767gV3P/A/mmERIFPuyC1Pm+5AVK9iSD/Rlkkm9bTPPazz1x7hTo?=
 =?us-ascii?Q?9WfjYUe/ETyBLmprkAzoQNs9F4pE4d1MycutzGSbOKPIkjMZFM1ggGFs0FvK?=
 =?us-ascii?Q?KPKU2wPgS1rgjd/5qQnZyzVW8eDcMdgpZT7E3zYTRi0OKvIHrSa5Pw3AOUZo?=
 =?us-ascii?Q?eaZHPLbUaIUD13GsB7CjGMwUmnPv4V3LoZ066dL/vUBvF9dYqDpE2PbXNvzh?=
 =?us-ascii?Q?q7iXxnm9qhKnHa4dERMcvdRiIrQFfzHAGQElaI1y2UKT6FHrtb2U9tMwgcmw?=
 =?us-ascii?Q?nbG7fNMK2P2S058Y3lkfsKrOP6+4a8AokJyFVqpMyh7zgeNQ8r/dhBYFdOpr?=
 =?us-ascii?Q?OAuk6RYCd2xGBrCRQ+5KNiHYitzAh0KhGjEx4whIGPCr8VE96mo7zTkgrp00?=
 =?us-ascii?Q?rNqUkiI/zwlburcBcVNnIciynUu4E/hUZT4OTuUVfM50NNnGJvUmIKqmsAQC?=
 =?us-ascii?Q?CQYf6Y1Kn2cexRYXUuWIE2PktasdRwmBH62ppxEe6L3ZmMi4+DodGzWmLNES?=
 =?us-ascii?Q?saTbQjAbenGgxAiAm7aapQWvuXiR8GrCFOPbAitTIDQIJe2zfb1yZnVwQHmB?=
 =?us-ascii?Q?eV6Seu7ExNZ74psGXgIrAodNS/mVcMZr2Lm/ZMKiQe8V1K8TYR3Tf3vGDxho?=
 =?us-ascii?Q?HqVNmSc0P6LSmlWANn3ki32wmX0qvfmc2/uhre/SN/DPkvS4bAJD1OI/NZRM?=
 =?us-ascii?Q?RsGC6aw3VnDceSiI7qyQ/f4lGBu67PjsiJsYDwoGf5CUdS4WxOYUewpgrjsr?=
 =?us-ascii?Q?yJjcM7PaWOeX0IukpKa7nQFNAwTofdgoQs7voOxZHnygKwJSWMunP2zXGKhZ?=
 =?us-ascii?Q?zuwgffu+/PyxFBb/8+blgQLrmf9LLIrR/MrMAZglM6EceWbq2ZZA4pAdaz0U?=
 =?us-ascii?Q?hiXcrd/0YdPlQIayr2yio012eOLq9ESdkdfsnzaXaRQzKrobLhU24cV3N4rP?=
 =?us-ascii?Q?O94jl6sFVpfWNk4n/ZbYmgCWGg9a78VAHPisfXdD?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f020a1-de38-43ef-237b-08de25f2335d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:58:50.8668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Afoe5/EgmFDlVC8Me0Dnq/E0l/T7BCXnASOcfodfieCMhVT+P652X82rtsExFQIBIQE8SsePY1GByFDjAsfJ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9379
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEzNSBTYWx0ZWRfX8JWEW7h1WNBI
 jJCpnVDxToe3Z1jmIjtglRrd0tMwdMWyUnT68MR7FPh03cJFwkRu9kvxFUD8ktB5vimDS+O7ycj
 RCWaY1jTnhJAexRG/iQDp1AdeMnKbgbquqKwfEarCXTUEhYdpYo2CMOloVj9XUxCnnUu5vH1KoP
 GDlQ66q4GsMHDZZKC9id1IyY4iOZxw41noZpvZndcgCPo90b9V4ojQQBogX/vqZ8d2ATrU3gs1O
 mKhMEpw0508TSykAIjekFT9TKDH9p5hr6gXKOx6QyHcFKr3flQGWJtbqMdUbzprhNhO8rVO/Rru
 6RK05YVtI2k1qyRQjemT16Fj2u9WlC2zoeBDw1hdf2nKkOitH636o3TSZk0a92hcKVcTbI5NoL9
 ppAxFsW157sGMZiV+WHnbsG0HfWrsQ==
X-Proofpoint-ORIG-GUID: lDmUuLTZV994zAsRaoTgbm77qA2dFEye
X-Authority-Analysis: v=2.4 cv=PaPyRyhd c=1 sm=1 tr=0 ts=691b463d cx=c_pps
 a=MxHkyKj2cFYSCUcUIFQv8Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=3LPY1pyjn_wOC51dSZMA:9
 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: lDmUuLTZV994zAsRaoTgbm77qA2dFEye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 17, 2025 at 09:26:56PM +0530, John Levon wrote:

> If we fail to read an incoming request, recycle the message.
> 
> Resolves: Coverity CID 1611807
> Resolves: Coverity CID 1611808
> Signed-off-by: John Levon <john.levon@nutanix.com>

Peter, I did not hear back about a coverity account so was unable to directly
test this; could you please help out?

thanks
john

