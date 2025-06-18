Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F662C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqya-0001GB-FY; Wed, 18 Jun 2025 07:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyY-0001Fz-Py
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyW-0002X2-VG
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:06 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I7pYx6002539;
 Wed, 18 Jun 2025 04:29:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UnUz9vkn5v/ojD/ecEjKdXlYLJCOuFr1pSR+Vvzbo
 BQ=; b=nt2YsBb2kk+GgbNLtWK9PNDAS4S2AF9l3los7V5ZtxS9fJOmEJRPTICYb
 p1WE5O/Kg0SPFWZ3EqbllXG8p7cgCJs6Igu2NTdmEkJonjtsARUopwEFU81kxwd6
 +PWIWf2u60K1tmwQ/c4OrF2ytV6tQP+er1h7PNM1mD7FUSBvPrzXWT3HrEN6peDB
 UM1IrZcBIIpJywfw5osmVju6qKr5+YFMGunfjIJezXk3XUuuUmTXF1QnrBikuOTi
 lMUZdDBLzN+5xoyorSNN40u325KaCPPY0TrzT/pcAeCkRiDs4ok89WCmO+RHjlyy
 RHVC4UX+jVeBRID1SdeLKCOObQG6w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2114.outbound.protection.outlook.com [40.107.92.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47b63wb6c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQr5IXmApUuxg21HllrSLhfr2L+2jBH6ERwK7L6H1T6InGDUbTW47PGr4snxi8naGPjVlDZ76DwegInrts+jh/1DFR8KGcVlCYrwPYFGllCDjVqGjgNfwVsAqep3LTWAn5lySts0bzTXdQK838NGsIJEakQKDosTI6WXmJU2DU7xtZnNza+3A+s7zG5D7ZypUF4DrU0RWsBSYX9hzUeQ2o/ZBOIYFAcUTTCHGbRAJJIWsJhdY3f48n9mXAISc3A4zsxwVsTjH/WeoOotaDfCK/yEsf3kgJf4Ul0QxUH+P3L9BtCmRNjq/nxhJR4RBn+o3gEn3EY1MIAnlIF5OANn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnUz9vkn5v/ojD/ecEjKdXlYLJCOuFr1pSR+VvzboBQ=;
 b=ULjqIeOiIo8xfjuJ+pwojzPFwsrNcX5JhmpgmXBJA45KBTwOdzTub7ZGbyYJHI+fL4JJqZTwmC9jK+pWySG8LDlFTsqv0W4XwlIp5pzD5sqQTEKgQBJKKM4kzmRDIHEmEKgybBmUbxoS80BJGDMCN9snIq13Qr/KXI9mErmZ23cHsfv6GUFNKnHYeF+f8RPOpcKYazUxnIXBosap3pGafRBWMczWJMbSbSRnCTo8hXQyQOieQYA//hQ5/nqB4+NaQMr9V43mFj00uCCaTKQTQMnJnR6ul81byBLJRxKosmJSl2HVhlyG0toSuvxEpAGVIj65ZvBpfLqwHlwVwY7S7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnUz9vkn5v/ojD/ecEjKdXlYLJCOuFr1pSR+VvzboBQ=;
 b=Jemz+XMgAPNO4gpyLZ7kRuSRohkSZp9eb3poe1GetCe/JWzPcEFxkGU2X4hqJTaNnC2qkcpp98zKcqfIsAt9LRAQnRtP9djoPHXMmGE9E7dW203YvengBVEDRTzUa35Ui1SK3AVmPo5pLWHDFiS3LL1y7kb3q7mP8fN2eVw7nN/83FstlvtIRfKUsdCWehdqL2T0DgDscP8q79S8V2oYzB5TC2twQrBK+9VLGsE5sK7pSsz/iwwNNBfzOCHm9Fjro/KHf4k/h5YSSkREt4N37U6PlAQI1F/dSNcuan4wzt2WZMd+XFVv3xZvXpdfLIyJ4uyJ9M3qVmxBOBrPIgGUCg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9632.namprd02.prod.outlook.com (2603:10b6:208:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:28:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:28:57 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 07/12] hw/i386/pc_piix.c: hardcode hole64_size to 0 in
 pc_init_isa()
Date: Wed, 18 Jun 2025 12:27:12 +0100
Message-ID: <20250618112828.235087-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0017.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: a00621c4-2033-4127-41e3-08ddae5b508b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MUm68OzDx9WEjVYMZcwStlI1Qn3btvknjIxcm6IctqvsyjIaUGryHd7tV5NC?=
 =?us-ascii?Q?oWpsjQUUJj7uGUgACZaBxClbXQANOZ3iEPMtf7jhwbGVd4g5ZCWKmxm3Ku/k?=
 =?us-ascii?Q?oliUotW6s6fgMeXOiNOC40vSUGeSyk2AQEAS8cxXrF5yd8Zkx6TkWYJjg5kR?=
 =?us-ascii?Q?zdNdigdJy7dNxU2QBA4fYOow0n1ETWCZTQB2t3S5i9wUu4bt1rsUU94Vtr9y?=
 =?us-ascii?Q?VFjYM/GpA3ZS2LBIQlYUfsU+2BilT+BnMvq2WMnR3CxYq4WBJJ8QqjhIkKar?=
 =?us-ascii?Q?0RCTClStZOWp3nazibsXLs79fZ/w8m9dBxtyWAJBWOto6E5NnRFHjnMkqXvu?=
 =?us-ascii?Q?fPArzkubWsFXqEtmZ/4O3o1yIqjZVm3AK5Ubb8AD2VZLKgvGbCp3e82AGN6B?=
 =?us-ascii?Q?6F1KlHX906c+mOO0BkENviBDqUknClbHHZ4msf2kNKvlqqYt3idLsdf1Vofw?=
 =?us-ascii?Q?WsU45JrvLgfOlvpyyLKPdMZsFee/lrpcXjSFw173jB9blz/B7G9wd+TeIfTr?=
 =?us-ascii?Q?wHNZCHnGriAtgWjEXwTdz2LINVuZG4b5iU80c8LRw7MsETi6sdLKp2WqAYWg?=
 =?us-ascii?Q?lLfR7uSD0ykCW7C3IJjEvgWPU/yeEajMBFhoGJ5j5a1PPa29pypxYzurh+21?=
 =?us-ascii?Q?SE4P7fE/K16DUUhzeukWqDI7u7EHXOadXlrPfbv1auoVKd4wclXyd9n4Dt22?=
 =?us-ascii?Q?4hiSHOofNFXG16tI18qnRT8ITjDifMT/NJjWiB02mKtNWp2sPIt8ZbrNm/AK?=
 =?us-ascii?Q?enPio3P613AoCLwbfSjudmkZgXhuNsQJ0vkY2OPzOHK6A4NdC7XvVoRavNeR?=
 =?us-ascii?Q?8qukn4GgFIRuCIaQDbraanvOSqJF6fR6TKtc4QuC8FyPRr3dduD9lIFKhSPx?=
 =?us-ascii?Q?AYQ1eW2WIY/dHEmUNTfyvOD4CL4P8qbx9NBFivBe1m7ISEshmok+ecCEPw+Q?=
 =?us-ascii?Q?bWzGW/6/kNkftU1F0Nd2wB9uYPrTks1vlPo/sX7lwhrCQFTSTWFvdPgPqbga?=
 =?us-ascii?Q?22rjVPSmoFevfx7Zq7r9GjKLwsvwo7G7vvXWtVy4uWd9D8k3l+Vhs2BHck3/?=
 =?us-ascii?Q?efMlpLX8DQ8dsj7k5bE8Kh/Vv0NKxGrUbx3UD+gVY56e8f/1CfhQWZZcdltP?=
 =?us-ascii?Q?EZx/28E7aLMKDIPcNfkjYAuWmWH72BqJi4z1V3cOCSogDIxEfGxXp6dLBvRu?=
 =?us-ascii?Q?94n5KRmwFXaAYcuLL+qm+Ws57geaNApj2Z/hdMDix6LiXt6BigTzSnlqFvp4?=
 =?us-ascii?Q?sETAjCuCe07873oNPKwup11+5ARGBA/EPUQAw3Bekh5NK/xgBs375tV0Uvg0?=
 =?us-ascii?Q?Efpt3qZgyEkfNvfxqZUw7uV3JO3cOD1C0BePiL9mo54TzUkoIVr/8c/BbmXO?=
 =?us-ascii?Q?ARZXDtloA+UOruwi2/pP2vNpvLBNj+ZPIhO9T7Mr6l0lNmtvkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ll9jXXDkMUe4oMJUtgJI1rFdOfdyK9oUJWcuqxTwwYCkJWbu81Vb1wmlfX/V?=
 =?us-ascii?Q?dM29grgZZMKcKaaTr1MfYtwBi4bzQB170tKzUTGpm3VAAvgfifBqgkkePtZk?=
 =?us-ascii?Q?wHaG6JT+i679a/pmiWb+Kap7b/aXV/cfYzH2Cp3taJVpkHI6FIwUKfu4Jpd/?=
 =?us-ascii?Q?q+vxc2aQUhM+EDLiU916Ip+V5dckcfRJzYPqI1uVN/DPYCMihAbNzLU/u0Wq?=
 =?us-ascii?Q?ETOuGHnMCFt4R5kP6STYQYqzNS6BGB9baLO6ORZD5i3I7ZRCwPYSBTTJ0FBT?=
 =?us-ascii?Q?a0i1N6Ih88ExrqL4DfJ9oGYOvEeUMarHYsPKf2hDECrJjoeawx/k0tRFVhwc?=
 =?us-ascii?Q?nzp6tew1b0crLkQBEIr6VIovGNTov/sPHsgUi3SPEnui5I1i7MaBHRhEeyvY?=
 =?us-ascii?Q?+v6bXoPczcja7LPlDMduNtCrHyy69zOWyPg4BjChxCzPyOKdlUxbzj8oDov8?=
 =?us-ascii?Q?VHLqKesvTONDyLzqj3WF+MBrOu139+J5XVjX2naKhz61Xa8KBKBsPC4q1y97?=
 =?us-ascii?Q?xSWbvfaF76nAe40Zb/5QYTQMTAZeJas8aVohn1aHWiZ5NW0vgRupNOJBmxX3?=
 =?us-ascii?Q?kyVL7hDiUruiGDMdI4FsY3W8QG5Gv3rJ6wxp/d4aUR/L4SOG9lveYcGOacaQ?=
 =?us-ascii?Q?hqgvKW3WZrdYNRpWyVBXk0nhDBhdi3LYUAPk8yPj+h3WRpCrFDDSl6Y6iI9w?=
 =?us-ascii?Q?HKTQQ+BOboBeGm80kP0/tIQVJHFNpCT20gIQoQnUfdehzMxLsageg64IQayv?=
 =?us-ascii?Q?IRbdQ2kKbMrcCzyAeaPc/N7KJj9mfUZgDIA7ijEkCjEexD6K/8R3ORjXdbI8?=
 =?us-ascii?Q?d4abSoBbe81UiGFPF/OPhlby6lPEFSxI03mJ6N3sOPFNYGoeXkUwW1CE7KYg?=
 =?us-ascii?Q?KUNvsOSgDA5DfwYNIJE5T53j+X/CqMyqL8YkRqAS+vYYgJPPFmxioETcNe6/?=
 =?us-ascii?Q?6vK0eu9XaAdPV64y+De1kV0I2+dMDyHXYY1WzzGblA+gYJgly40WOMof/F85?=
 =?us-ascii?Q?3riEoCv1z1hMSARAxcJLMV08tjtawWzF43k9u+xjLcus4CgHu5kwazXvTinc?=
 =?us-ascii?Q?g7mu/4IxDgsAFZE8ib311GsX/BFbl/46jI+qFAjo+Xy38MPrWUJVA6YRc2xG?=
 =?us-ascii?Q?apMZEAfKU3El5IhJDqCAEdZsgABvaar+JXAf7Th6M0d+yvSpI03x6sL3h0Jt?=
 =?us-ascii?Q?8RkZig5sbdO2qv7wyX33qgXEVeW3oFLTeNgxddhHhjNTNJy2FUyx3zDYMBk+?=
 =?us-ascii?Q?1V/KFEi9Y/d4/TK1te+WwAeD60hGxkKXkaXgo3cjOC7l8Qln6EyZx6utnZ0b?=
 =?us-ascii?Q?ZhKBKk7pYfd7WEl2QknDWzlt7uOO66MgyslOPGTF01WUMl7mnGuaO1IDkiKi?=
 =?us-ascii?Q?NGvf51xz2VdtLtuNrl0MZuA+AbC/bFXsrmeQE8A/gZyaJtcAvUyrgUd6U65P?=
 =?us-ascii?Q?HgHdqCgSuYR4jDxFVleT2YySdt3k4ZJuH6dyxtfsPPwP3/VOYk9XfBMmRlJx?=
 =?us-ascii?Q?M6F4KetbsOsoDv8O8BkK8OYIGxb9Owu2yqFhBafiP9p4hp8cOHX5eMuwYxL+?=
 =?us-ascii?Q?RgJITxOQvQGgZwoJO9vY+tZUK3FGsrXNzTvp1SjpqM7I0Nq+vOuyeXGUweTI?=
 =?us-ascii?Q?QlhEvDpZTlghOi50e1Y2m5mjux2lhgCxCL8wEIAo7k/1Ay6MoQa1aGrB1Xry?=
 =?us-ascii?Q?KBBUeQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00621c4-2033-4127-41e3-08ddae5b508b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:28:57.5233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il9ANEG0LsDyXKX92mjk1ViDEaS9IXkrrUW5ZPaicEMWMJeHnVlPAek/hhqnSfMelGoS6RSC1GNZy5UxaJChP+EX/sOdP7EVMA5ULZ9WODI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9632
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfX90TqAj7Cnm4U
 EKZj4lCtGjTlg3AHEm1ws75I/oafN5nQmKzn89LFdhhb4NUs4sAmAtNe2aD2QiDPYIcCc9T/XHj
 +itHZO1u3PFJpAf+YCLOuXtNxr0gGvN06rf5EMSmVBNo58FSUIq3q1finclbk4q++dtBTfCSW9X
 F98Na5bFBvlIe3Senx7bbV4PNVv5oa7zRqdjM5BPAL7/aKOgOHE/SBbnUOiMgdmr+ENJq3iOvoo
 CyL1dz1rFCLkqiXtlTSZ9QrbVJ//qXSr+40mRQWrf6H29DgBS3+8TLIEEOmKILbZ89iqmymZbK1
 GL7SSnEufNBKfTaGJkNHr3aYWRoBBTL1be9rVB05N/1CL//w3ItXhlFpYXdRN+3JsYuO4+XobFm
 IDLAIC/oiqGpm48KKzghCDaN4j5biXNxH1dpbfFh4tRGnwyS5a+ojH3oJophosyUsOS8C4sE
X-Authority-Analysis: v=2.4 cv=EurSrTcA c=1 sm=1 tr=0 ts=6852a2fd cx=c_pps
 a=1agHWDAk2Ff3ek/eqE8klw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=cJTHVYagl2foYDAtDiYA:9
X-Proofpoint-GUID: WJ1MvtJhoVXULVUNO_AtiWPf3lJpoW8n
X-Proofpoint-ORIG-GUID: WJ1MvtJhoVXULVUNO_AtiWPf3lJpoW8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

All isapc machines must have 32-bit CPUs and have no PCI 64-bit hole so it can be
hardcoded to 0.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 168469457e..cd9a89f7ff 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -427,7 +427,6 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    uint64_t hole64_size = 0;
 
     /*
      * There is no RAM split for the isapc machine
@@ -450,7 +449,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


