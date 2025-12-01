Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95217D111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0e4-000697-Vc; Mon, 01 Dec 2025 04:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0e2-00067v-6w
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:34 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0dz-0001vh-Ms
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:33 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AUNdBbW2263336; Mon, 1 Dec 2025 01:56:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hUg8MCOdkRKztLz01jIic76so/Ql/SYafk+7hRerE
 /c=; b=x88YPOiYjFpyW73RP94xctWm+tnABFZQaW60kbVloiLI3fTsQMtwGFHxG
 qs+HK6YhxC3ByzLBpU1aljwemdLtHJtqbsx1bL/pinVQMv0x0HCyuJV5iAMxBKZz
 qeRkwE4f6e8qTvF2H8YQY6Xse6g+Svk98PP8p7Ch124IkwnXvQMBgSZ8iF25KOJM
 Wu6+0bwhEc3g9YczGFcqGSRkSF0ydpVdvtAaaa8qyA7qlFwn67bUEYN4UEv1Jhl2
 v3Wi9H5sGCcSXeB+oixESlQiWQYmgqODhMEo/PCT9eoOHrxUe+D83P5a36qilYtg
 KTleBHWRM3I5iCiUPTChR+eAljY8Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022081.outbound.protection.outlook.com [52.101.53.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4aqytnjkna-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Dec 2025 01:56:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS3U4bmhlspMXU/GXezJOvy+7lvqj7VUOAByybbSuP0CxDl67PnqKhyX9yUhIECFMP7VQeLG/OkXaKlCD59rwoi13Zr6c3Yxp+QxHK0KGZwbx2bUiKsamt841fnKPYtFdujM/CLhJgioPToe5u9gMPe/YCIAD+jolNDPKsxxQjF6gWKJAlnYzYsqlSg/bDNiouXYNGgz1a/XnxIGajgEG4edDx+46iroTw6wED4ZaODQBt1Edf8zAiuHIwKIVjT0CZiyTCnlvAiazPG68ZfdgRxl7tufaMmQhf4mpBMsVFoACGxzUumkxerdszHreZ3c8aJ709QSR+vBKWQGd//knw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUg8MCOdkRKztLz01jIic76so/Ql/SYafk+7hRerE/c=;
 b=EKFBMbc/92OLgUExXR1CqsflFUYMgheap4vgbu6VlAyKieN3YE+k7gTLkO2CdDESuSuVi5yz1fkSQpkO9bbr7ZfQL9pv2B/KjyDHJTiN3KcwFjHFGvUD2vnbYlwnj76gAmClhk6lCtTfDKgfqiBprGJRWwhb77j3HeBFZ2uWqiPQHJmrX0NCxlgFRnkOA92SamgE8CRqcU1Uyd69snQ9+nVmZgAVhtyQFqCTzcZ578Hg2Y5AQXVcyO5bPLTR7lWlVv4TWg2kojoZmx36MnFENR76B8X8fZtHJEePGvRx+yLFUuw0gsxhQvrmabYQ9dyIJINGAuMPutaYq4BVfDFyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUg8MCOdkRKztLz01jIic76so/Ql/SYafk+7hRerE/c=;
 b=TjKrHPQT7APy0Ar5jU4X27ItGBGcbu+CPHgBFIUXPa71x4323JO8SW++aX8MyMRhzPK4lvmEjW972Cs6lvAVBk8PDFSKajYg/JzkHXMshjMSuFTFSLHBR1VtNWX0Ttea29/sBcQOVpMywm2O9BlrW76VWdQ9vJZQcvQ7VwPqNQUPNtAFkHQBBJjYfBtbuNAJPbMHwlse5Gl+NCV1t4+k2JAZf/SW/xtZUoeOLHMQkjkiSqEtV0uR2VJAcyO35cH+zC2OXaOa4AHmSxSD4kLSq/v26O6+qIQBK660fm6mG6uKlFtMw3zdu43FRVnRbWtBH03Q5w6/5ML6XPuSXrYE5A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB9865.namprd02.prod.outlook.com (2603:10b6:806:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:56:27 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:56:27 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 2/5] vfio-user: clarify partial message handling
Date: Mon,  1 Dec 2025 15:26:18 +0530
Message-ID: <20251201095621.2786318-3-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: bcb80a06-0fec-49f3-ae80-08de30bfe513
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FhqxQLkXzr6iVoXxFXG4JsQt5LjFfcRGpDZgn38RRdoT1x+YnBhUVgUjfud1?=
 =?us-ascii?Q?Baset1XIsnUqY3QSQy60x8ZHJrYnaWpDzU3mAGvDCTUKny0CC2phKycNciQs?=
 =?us-ascii?Q?7AblEL7JN3IW7HddrZS474Vn8ELOliWuw1UTxaRBus4Dt0RjTxM70BBnZiur?=
 =?us-ascii?Q?n9GSvJxmT7TZrFwabmLOBq/9t0Wl/KyGa1njXAgWjETU5EV9XFd8UklflIAO?=
 =?us-ascii?Q?GbcpqcRyKHzA2MgOcGUU4R4uWIuw/ZAvJw4YEczJHOB9hB/hdRqDen735DHs?=
 =?us-ascii?Q?RmyopWSxcJbPrhc4i/DhXBlbZcpRz8hIqxCvsF8U+fqDkGoPynyHaUcPi00N?=
 =?us-ascii?Q?1rPwdSr9ugVb4ZaZfyxBsgh+rUQMZVtsKY2HZhLBKbxB9KR7re4LshWAmXVc?=
 =?us-ascii?Q?oeHNe8TcSysV2ccx0Z9Ytlbuz1TmVgasXH/kTqGs61ScwfQnkl0JI/cxhzax?=
 =?us-ascii?Q?QqdAKDMiZwXRsznioxrkBFYXMZWx3iL1fpsADPTn5lkqbuOeGDXHxIQvty7W?=
 =?us-ascii?Q?HUYje15sN5wk13eGGBA+qAooqNnLquMJupph/C/Cge8nyn7GLkhXCvmpsDej?=
 =?us-ascii?Q?+iS7wd1qmP+5fwLda2YmRnQ/G5pikC7q3hVQpbX7asT0u2SV1jIUGZcS/rPL?=
 =?us-ascii?Q?8PCTZEp+X4/+01wrDiK3qmOLRXgGxd+Te248G9fBCusFwkdhylK/KmsmW94W?=
 =?us-ascii?Q?qAHrK9qxn24c/qny/n4VKoLfe8+ZlxEnVNWKN+uRM7GS5wisUvm96kMLTjkJ?=
 =?us-ascii?Q?+dbjs7mdMg3RoiAzl/S+T8o6WRJUD3NV5M6iz5ws8aCEuRCBIDPUS8bxqzQM?=
 =?us-ascii?Q?7x9Nb6wFbZdeNNjy2Nhl94ZT5Be9fWbZgyx101c6QOHY1WbB+lB1u6YYj3Mi?=
 =?us-ascii?Q?RQAApMibIRaoxgihKqtHeUYO0a0t8CBZnEMIfMIQK2mMWrVF/1JIg9ExAEqr?=
 =?us-ascii?Q?ip/Kh7j6L1e9p/DCTASoNWt78jCJJiSWpP9J6nwUI43ir0MYZxHaUQSiJFZS?=
 =?us-ascii?Q?WRohIP7gXioBs16nwjkfH7VvkGtLF2AlK5eq7aLgaBQQdofgYOwLMXXOdCXS?=
 =?us-ascii?Q?ob9m38/JNpMDd1ipHXxqRGuMtwxQQgX4cefuQsWM7Uldeg6iy3ANZJzuN98I?=
 =?us-ascii?Q?hBbVZ1/7+pT4lseZC3hO56CzxsA5q7I45mdJWx5/p3yP0cEYVKmrI0SuDOZt?=
 =?us-ascii?Q?B7uCQUwF5LQ+Y6o177+EWfQeQosDMXG7xw46qzY6JmcDpLBF5ylGUOoB7/tV?=
 =?us-ascii?Q?/EmO/5WMCCPgFDpmOeNAQT2YefcoHhlf4Ljynvbf+ejtSxWF7w8ijGN35mc0?=
 =?us-ascii?Q?0zvPvbEHGVJADUTqKyb49bg8pa66mE8j3ZcYR895/mLA7ZuARts4LwnAbmzV?=
 =?us-ascii?Q?Ip4mLZOZQc4e9GGLmH59zYJmKQ02aqUH0o3T7v+ajBfZ3bfSD/QrBcGOiJ1W?=
 =?us-ascii?Q?hheczVGoCiuDsJsu/jrVyt3NiaAorXuU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?atf6xhNA1XtCq9cQLhIFYs0lHMBAe/xhMq6bi1Nke8BOAIeCq5CY/cL+RGrk?=
 =?us-ascii?Q?5QYS+D2f1tcq3i+4QEc6SdWKWhDom7pChsUZQy/GEkiI/nh1gQZZM2/LdQnT?=
 =?us-ascii?Q?L0i4P3qN9eDLRW9PZhkdfvITCyGnX8q0A46JjKxrAFA+fE8iZr96xdoVDauo?=
 =?us-ascii?Q?yahhrxQ4UMaPmu0CczvUfhedJACyl/ITy4P2MW4V2/LmDLOG2mf5f3UHuonD?=
 =?us-ascii?Q?MRV+zO7F/EOAswMod/gWCxXyxrV63j2a1hFTmMHzt479BtRnhkg+JnIg17QT?=
 =?us-ascii?Q?JpAw6wVMdWguT/BOypzW/RTj1op4T9wpGvnUIUZiFb9SJaQHZ2TqpOm5dgkD?=
 =?us-ascii?Q?J3UVEaJkqjCKEsmcYu+UZMkgE8dc2mFwfAkshOSr6KsE3Oq8eMa+xGLLKKKz?=
 =?us-ascii?Q?+NRHpxqHb9Li5A7sH79JMx/UnqRYhzw26XWbxH8aAe5beQYGMOuXRlr2vfez?=
 =?us-ascii?Q?s9XugWGHoAmNc9S/n/n8pqgUwQfD/bl82vmLKvyLpMyWOyKzq+lJ88cOIDli?=
 =?us-ascii?Q?tRQ1xTDBvs1x6s+AMe6S+aFbvU/SCny7/8Osrv+KsCqYBcxlV+2/9zah4mI3?=
 =?us-ascii?Q?A3GQQYHBS1Buu3zEYQ1JPOTSkXqIy2azK9H48JkKQUvL46qIOahI+7aP+8k0?=
 =?us-ascii?Q?OTwnpGrr7O8kc1J3pWpxmkCOqx9C6w9IdlNAVcyvJYbfAFrMVvXpCX0PJIVj?=
 =?us-ascii?Q?2bHP+OruFx+q3ZvqV2aEkajHaGvYlVTst5CtE3rUBunwN/34CM8EXpIXc4D0?=
 =?us-ascii?Q?Wn8P5eIPlYQ9ZCFtFg/zta+pF4blbSgGBHlQw6VHDCcLbhVVlVTMFM08Bydr?=
 =?us-ascii?Q?TXNd0/c2TC81Ia+s8iV/1kLwaGRGPx1QBzeNfxT3yzB0X2/aa7gIQGr+rk+N?=
 =?us-ascii?Q?xj0p9stZN7QcEwv0luRANMESIQKLmV9n2egrnBb/c5yaqq+wHlS4D699Cxlc?=
 =?us-ascii?Q?gy+1SPbSiV8OucNSKgwsqWt1uHO5aIxJSfW2BSKtc2SzzIOan1tOBZP7H9wg?=
 =?us-ascii?Q?//BPNaf0JcQVSn9+CxptL+6C+d7g/DPMxD005k3v6H7NgYQulHW01rRawrtC?=
 =?us-ascii?Q?oV+FsNewDlNQj83/aqT+bz7bQwgEg3XCnms4LWAXjKfewAggFpIbjjh/nH9/?=
 =?us-ascii?Q?rmwt6eYdPIBv4Y2s97Z6o22uL1YdEW+CMcbZDj6TJjRF9Gt5vIdcbBA3dUVR?=
 =?us-ascii?Q?pdVUSfU8xGVQifRIHGXwq0oSq+QSCsC4QzfM/XNcHUg/lGXU60WWQSTsMFic?=
 =?us-ascii?Q?FAFi85WWf/3P9ysDfMoWafL3Yk3Y0aSACXrVNb9ywzMfwSf8fdTI0KRq1QBq?=
 =?us-ascii?Q?xh0Kh8bseVS9XYyUYjAPGfENlxcvygnKlv4bnZG9McVkAlv8rSzA0K2bY4bB?=
 =?us-ascii?Q?Ggi5HO/w/6kgIYT3o1FLCFt7N8epYnAFY84tPo2z8cINMlUYxTL5NhYP+87p?=
 =?us-ascii?Q?M/5T4+QtUhKN+icIKRRjBL9s4FoGWQqnaiLk907FaIiZKJG3VGlQKuHiikkK?=
 =?us-ascii?Q?PBwIuQ1KAtEtx8Aeyl+q78svAkp0eeyvidvScKBchQ3jH1TbWzw5UmfTEDtg?=
 =?us-ascii?Q?nAgamU3cUI5Khbiaa+x2zbCzBiu7l3RP4JB9QzIM?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb80a06-0fec-49f3-ae80-08de30bfe513
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:56:27.5580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrWdcaM8Ge8q4ce8ww2I9yiLCw/8+sIfUnuSoJBd37Mbd3Mchxpikzxbw8rc/PiQUkDhjKCjH9N0zSRaRjIbxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9865
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA4MCBTYWx0ZWRfX9yc2LWHxK6+4
 mNENw0BET6Dp9ov+6DRi17fNsX0lnmLCbrPIpUp6oCSuOZw68DjwsKAIlccXf3NeUIHdvMOmtaw
 Ahzi7IEcetIk5H/cLSKrRpiuoK7D/2m7VNZjlUhvaTg6aizgjP94xoET6t7qyjMmANNGMKLrSq6
 rh4O8y05IIekF4Z5YBKFj/DHQY/tylp5nQYCqmaarR2IqycsK1rJDMXxrI1k0qG3xat1NODsk8W
 DbuBZ92Qh6La+bpqN9y+lTuOlDwE8wQZYiPtAPbv9nGAy69irhsECEBwdmEQft0oHkPuwyCXp/A
 5vxb67U/b+HcG0afQdSYG5KSV+tgvSr3wWiFrbHGmUxYGHHUoW0oUQBnAHhXnE1bUbeT+jT3Tdq
 AYiKMdo9eLEyuOkt1RWwfGwOntv4zQ==
X-Authority-Analysis: v=2.4 cv=TvjrRTXh c=1 sm=1 tr=0 ts=692d664c cx=c_pps
 a=MVTdNaybHAW3nHwJGrV5wQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=UsTzQZW-myzRIYlug1wA:9
X-Proofpoint-ORIG-GUID: totH1I4oc4DMeIsgQBTWhHfkb01Hf_6y
X-Proofpoint-GUID: totH1I4oc4DMeIsgQBTWhHfkb01Hf_6y
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

Improve a comment for this.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 75845d7c89..82c76c6665 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -362,7 +362,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     while (msgleft > 0) {
         ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
 
-        /* prepare to complete read on next iternation */
+        /*
+         * We'll complete this read on the next go around; keep track of the
+         * partial message until then.
+         */
         if (ret == QIO_CHANNEL_ERR_BLOCK) {
             proxy->part_recv = msg;
             proxy->recv_left = msgleft;
-- 
2.43.0


