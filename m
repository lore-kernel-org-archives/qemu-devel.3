Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AF3C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwIiH-0000ri-2t; Tue, 18 Aug 2026 08:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwIi8-0000py-Ej
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwIi5-0001LC-Al
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:31 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IA6Wti1191337; Tue, 18 Aug 2026 05:14:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lpeazmiRQB4C2j9w2ZAl3zyoJrQ/XqV/Rs8qb0SYf
 ck=; b=X9TX6ZxB9HbmpfSStyE9yG/605y20hTInr9j/qtOOecOi47C7ff2tVBOf
 Pd4O+4prETwq7+Keg52WP5i+emPqOkv66mAnAKxYwhauC6/MwLJ/3/GFiFzlZucB
 yj6igSmRlKYaHZHSgiKic6i6hoXRoS2wnjbDssiWvAHtcOXOdLXiJbD1oUKMTlEZ
 rGa6+LbSxjRpJEsYmgj+Nr83O/kZ/WiVUlR+Kcq5FeOvfxewcf9tVXoRqBtM4lqU
 M7qfIYVfPTPC+Q3l9yjwTqLZ/z/VAC90YlFk9POgjKJr0LXF3p0WC1XHztmBmsZr
 JjR111SjWxwE6R088mWZjIKXq2PbA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022091.outbound.protection.outlook.com [52.101.48.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2m156kg7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 05:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Um8hAL4U5sx3G9O7wXqE1Td4/IhnOuEuflvxiBGV6qGPoMKh2G851OkzokuJ7CHnz0xsjHzAd36Dr3reHTmUPfwBeslN1M5Ne2IBFfy5Kbf/bhSHNTM4ZcwGhg/CmnjkyWiVDHCsBDvFXQRgsRqxQ7OWbY0HGGiknxYuKBsNp8OVPVdJtArolLwAlsbvv7o4UbxqWOSHetuMIEorq/YeaECB3HcmsVaNRHJCHRPCBh9ukbLMUsTbbTDM5EDxaX8mmN1g9fvcPOzADmdTlaiIEBtH5SVQmx2tjy0fHMcLLh5KIVzxrAm4bDRolIC4+Iw1uquZCT0ys+EhwtwEobntFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpeazmiRQB4C2j9w2ZAl3zyoJrQ/XqV/Rs8qb0SYfck=;
 b=fsTeh0lD1mG5npRnQyy/92vgFfo9YwdsQtfi6WHKA3X6WoHiegSeZ+8M6Q2PupUxapDnnXQgD5uFbakwKD0Aoafa7cttPpSt/iMDMS+eV0g6YWwr5pG95kAGsyQVXkDCwFO2pq4vnsFWuwOvhcDTvdVmqsrsDeIYasRZ5Oym/9UXUsVZpaW+aQwv6liicY/T+Y/SLQqrIGAyKpYyzxhEr4E2VY3ckRIG26qA/1l+CnEiyurQ1kLDwpTOCKUyHqU5UXnRpS/gWC8JGw17L6ZrSC8YSn4SsUZoKXgtKc9CsGzT1FJ1JTfEaR7Xj3XEKEUDkm7Hwbxp02X1GG2FMGgvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpeazmiRQB4C2j9w2ZAl3zyoJrQ/XqV/Rs8qb0SYfck=;
 b=ovlV2Oer4yxoYb7S8EWRVr0eWqtsDCs+EzemO6WKvb+r88ADTnEMgU5FrZ6+cCXXchygFtQFsjwhfq0zPaiXosTA06fhs8OLF9tVK12w/pqFrKxPBVJLaJmAoGiSwZx2PS2T5bLJeZuXyl/gzHzbyIrNx54WxrIaGKjWy/BsV6bvGptCdBWRn6OkIcLFPml256OyDLW3cHRpU7ROUBkj0nVO3FSU105rwbf2qeWH9TYPqmGOvQg3pUueKI/QabLje3K6+fPE/gs7tGhH7yjtV72owzoxeQwp/CsDgj5iyMmXrhvkTd1edlosDhE+xlIYte3gBdj4jdtUep1jzvzgdw==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by LV3PR02MB10210.namprd02.prod.outlook.com (2603:10b6:408:21a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 12:14:21 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 12:14:21 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/4] ui/clipboard: add clipboard peer update notification
Date: Tue, 18 Aug 2026 14:14:10 +0200
Message-ID: <20260818121413.2660786-2-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
References: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0053.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::17) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|LV3PR02MB10210:EE_
X-MS-Office365-Filtering-Correlation-Id: 876d6a17-1fc8-45c6-8cd4-08defd223c13
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|3023799007|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FYor3neZY7AOJFYlxKYs7TURlJxwHBUlkVWCdk53l+TiQLICXtFlLAZyAftopu43LJpXlSt7FaPykicU2RwPm1adwiUhJW0FdkJqL/CjTpbUWR6s5S56Z0XWcc/Wf87kFQjGOukWgcEQve2MfZmyOwL89iCxSKCmyPxtJV/KHIFfxwIr2HgoqHCted5qpSQbvL0nuxPdpLrqcEEZuyIypURqWQz+eZ4Le+AGbIAh2oZggAGFB/XJcF1UrT+0ocqjQ0SVvxjXW1JePvG3aXUU0FK9iTRN9oFW29kH+OFljD6fJ6lpu7+x532ABL2XuY2REPHpydSakI1XzMJ3dvlfZseQp5fZUK674ui65jILKLKYsSO9kb9NfroQRlzdV3jVWQSYnvE8y0jvzobrlQUgJxYV7SoTuPjNPGfMUAswb8LR38T18E99BUrRcgmQ3zStoq7fQb9QyveL+kjM/I3dP5xqVXhsI10UkQTPDoTxKQMBwgX4/iY5U4hVWvmF/ju/Kw1ima9p74T05sojjaiz9pX7oFR26qyr/uoBWOhKimrUmz6Mw349sDPppILd90VeGEI7p+WHYC2r8hLyP6NTOlXz2f3JHfwX6kTX+UayA/+Esd+dma8sxrN09EXlO82i/7QppJWtc0+Iqg46rIc6DBtKyVCAsXgafsPxuggZHmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8fncZ+l0cMnfXtyovUGdgwzhkDbBlC3wnMSR3j9xyl7n8aRDy8DftNZuTKie?=
 =?us-ascii?Q?chMS02yXPtv2MP7JGjt9HoJ+DLv255JszbEbSyrogINpLVEJADaATtus9WcM?=
 =?us-ascii?Q?N7JcVLLVPbC62s6nOVlwkZ8FjMn5Lzsb2Jd6uAN8lTkyKe5DfaqcPIyxwGmm?=
 =?us-ascii?Q?siC5Bq4h97VBfRBOzvOtm+0wKIWbunR3/8YBpimgvXcnyzzd+y7OQCrRY12r?=
 =?us-ascii?Q?Z8ZZxwgqEm+t7wHPSScJ61vqK1tW0JLfXwlEzVkN6SSvzLMQWiVu2a/tPg7a?=
 =?us-ascii?Q?KihutSjf//xFII9e3chcY1FamniJ6ubuQ9qgnbTtsNMzfDIqPWDI9bDVgc3D?=
 =?us-ascii?Q?wwPGBU2wBCU7rxjNpP96MSNVCex5s9sN7Bd9K9FgYOibpMm0Q9swtcQ0fyBe?=
 =?us-ascii?Q?4dLtKtVNc+KAKJYeG+/VxzfYD7ZrLvfF5QVniHvVke5SYS8qDSVT1ya0XVAf?=
 =?us-ascii?Q?g1i4Kk66yLqu0ZVh8gcsSNo1rFUAUw99qcgBaWCTgfiimkv2ZFz5+CVaMuI4?=
 =?us-ascii?Q?d22OpiJZFF7bHsrw39MAje/ubAzX3QiTRjBPIxZBY7PsxwzKoV4wyY0quCpd?=
 =?us-ascii?Q?W5seZo+u7B32QDhcBoRU6/iyQYXOZW4E5w9WcR8aJKgYSWP5L2LYk52AUpQZ?=
 =?us-ascii?Q?l41iYBg9AIL2QH5OLLKBiTscSgn73YXu8kihkGS/dMXVClJo5G0+MIfZG+S2?=
 =?us-ascii?Q?uUIxhwzWZKr0zO+T0FZn/OZNE5KCRr5GEecIOS6J1Q/4yDJb+TWI1eJ5oKY1?=
 =?us-ascii?Q?v6Lycjph61h2LSQvWsnLdJYnWSli1zBIjdF5o4tXbpHN3pGQB3thO2qug3sn?=
 =?us-ascii?Q?Ucw49paIGooam9mGLKUfB7Mo9zy/rp3uf5bTlJKYbptk2dtYiF9Yv5ICOV0M?=
 =?us-ascii?Q?9gFNNNqk3rEe8++2+lL8Xrh4w18MbRTTCHqLBnpBqd71CAf5BgoDvSxW0d8T?=
 =?us-ascii?Q?5MTDCGfml0mgVg2FPz0rvYd8bX6Jd19PmmXQPc9pFF7EtwL9u/wf6/xUE8vB?=
 =?us-ascii?Q?Xat3h8TdNtB9bYguDqqFqr+UG1I0YKvCq14qJ8OvMZLIKUZYUG/7iQopXMit?=
 =?us-ascii?Q?NkZ6fz6Ja+ogbAnJBMTZu9ncR+A7CWlGK5n0wDSNrz7VhFIdsxSv8JC2V2ix?=
 =?us-ascii?Q?s0gOe4TeclAMZ9uUyqlzZUwFpYLKkQLIWgY7cS/4ZvvyhDy/uyEacd8elCjz?=
 =?us-ascii?Q?DmTSbSIftHkIDe3lF3s7M1h6cRvSKY2MEtMmsUKD6tQzvJz0qh/7ZcTXPm4R?=
 =?us-ascii?Q?EThCNCx9VxVT0siJdT2728Cu+3hHqneFKJ6qXVJslTsbVqwJfAezLoe6K6WQ?=
 =?us-ascii?Q?+l2N/jsi3ST2auuKmz6EYplfeK/oVMrvKDIbdDd7TKTanoYexBETPZu4kB0U?=
 =?us-ascii?Q?0zgBuL80wXrf2RkWfaI/fnG7HDlBP99w+c9dQDQtAu7W0qxx1usmlZWwyeX4?=
 =?us-ascii?Q?+kCOo34s6wSF9064AIsDm5u7kRUfo5dhTTlar+9duu5iJAMm/FqUxvwEmozE?=
 =?us-ascii?Q?ImdTc+nz83OeoGXKX3cXInwTa8U6ifUy/CjU4UA7lmT55acUjr/O8AjKKBsI?=
 =?us-ascii?Q?Fa183Hu62n1I00rKNNFTY9S63BrDg7MWq/mWAZuhqhLGShGqFNVHx1qfBPQ4?=
 =?us-ascii?Q?KDSLSNllaJJrBm2gR3I1y51ecOhYaGfMeb/AhTFEF9MOyAhzNhCOeSvDmZV3?=
 =?us-ascii?Q?l2eN1IS3V/afR+uPJD6MRIJqDUuNjd5AOgWwoDrSgVC3vn5pNY0bFqt3Rzmt?=
 =?us-ascii?Q?km8srU8Y7g=3D=3D?=
X-Exchange-RoutingPolicyChecked: oPKYfPn+QFz5mJ107ne1lNmasZWAeTH8AsijlBIN5yj+7wB2yV4+72OmNiqDBS1SUF3gbeKMXXTNbn7XthfEtKIBK5dWZ0FW33Mmdg5fi6daVxcgftUxjc2dXvMpLVWXds/lSg6WHDcd11tt0WlV9zKOOC6zp8bmUeQ3r5uoSAOSjztmDpEGxV5pY5KhGuS91nlx5GPLmEYHd3wvwWNJCukXZBgL+BUQOSQXkpVOS22vE3qfoqhqBlFDiJK8w21o0jPItKsF5NIA3v1nWH0Yh3k/T9wyD6JQzjtMIydri8j/Wq9HYZQ2CM9sZKVaG46iMMvP9VbGc1AJy1HNAG8xOw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876d6a17-1fc8-45c6-8cd4-08defd223c13
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:14:21.4360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjCxlSInDE6QVcOAxPZpTO6tr9RxWuOAO3oUcwA07MU/sihqrAK5P+LMdTUgrgD2QnxjDSElSDObCBtH6SLKezsgQ3C6z0WHopuXdwZnZWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10210
X-Proofpoint-ORIG-GUID: JuPbr15-xgffl7FPCV4KsWVzRq3jFMl0
X-Proofpoint-GUID: JuPbr15-xgffl7FPCV4KsWVzRq3jFMl0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfX7T43XlCPzshj
 q/Yo4BNU25H1VsHtgghNZs7OJs03KkLbtzXipC1tpMS6F/d1YXLwbvJWKMs9rl0yzKT7IzfeV4z
 FHl0UANuY1kECoeZnMQLfGtZFjUjQHEXCtqWIOCc954ehzStCHpGAKx+ATdEioi32KytTSccMvp
 lyYY7wun/XNZhlv5W9PjNbucmyB811pW7ngg4zXsUPf2f3Hp8eN6Ng0XubSo4pTbOOyvfGzjF+p
 QmFparYS3qUMVBTAEEmybWcmdl2chxWGaOO3iymAi5Wc/OPu3nx7CpAXZjDuPVoIHragil4Imul
 8G8tAbAULmW/m17VbLqLxwl1ynr2dS3j/ScsXhfaqD1NZbP+ct1qqh/nr7Ut1YR/IQtbX8rwp0I
 fCZyr8BUCCdFjziKZNO4EhHaB1F9B/cUV99zOM5l4vYL9rGCoD+IA7ZRgmbznoPWzJIwK/4+ZIz
 E/4FXDK3d/Ts66BgyJg==
X-Authority-Analysis: v=2.4 cv=RImD2Yi+ c=1 sm=1 tr=0 ts=6a844ca2 cx=c_pps
 a=gqqRaR/JtIFMplGXl4YyTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=1FjsvbZJLK8A:10 a=0kUYKlekyDsA:10
 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22
 a=Ap8k9tRZuQ82DLYWQqG7:22 a=64Cc0HZtAAAA:8 a=F_oEj4eJVQyrcAUegb4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfX03f98sdFXKCQ
 mTLkHwNIqcVxoY34XrbXF2yDWSH3n2atuCMIl/6WdzuyS4YWCL02xsLzaTDjX2OK8AUu7Es5gzZ
 /++HrTrWdXzml8odewn397aj7zbW350=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Add a new QEMU_CLIPBOARD_PEER_UPDATE notify type which carries
a payload with affected peer and whether it just registered or
unregistered.

All existing notifier handlers are updated to explicitly ignore
the new event so that the enum switch remains exhaustive.

Change-Id: I4b90f50a9b6355bbddb53d21dd6498fc01c0e095
Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 include/ui/clipboard.h     | 19 +++++++++++++++++++
 tools/qemu-vnc/clipboard.c |  3 +++
 ui/clipboard.c             | 17 +++++++++++++++++
 ui/cocoa.m                 |  3 +++
 ui/dbus-clipboard.c        |  3 +++
 ui/gtk-clipboard.c         |  3 +++
 ui/trace-events            |  1 +
 ui/vdagent.c               |  3 +++
 ui/vnc-clipboard.c         |  3 +++
 9 files changed, 55 insertions(+)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 62a96ce9ff..6166af5139 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -25,6 +25,7 @@ typedef enum QemuClipboardNotifyType QemuClipboardNotifyType;
 typedef enum QemuClipboardSelection QemuClipboardSelection;
 typedef struct QemuClipboardPeer QemuClipboardPeer;
 typedef struct QemuClipboardNotify QemuClipboardNotify;
+typedef struct QemuClipboardPeerUpdate QemuClipboardPeerUpdate;
 typedef struct QemuClipboardInfo QemuClipboardInfo;
 typedef struct QemuClipboardContent QemuClipboardContent;
 
@@ -78,12 +79,27 @@ struct QemuClipboardPeer {
  *
  * @QEMU_CLIPBOARD_UPDATE_INFO: clipboard info update
  * @QEMU_CLIPBOARD_RESET_SERIAL: reset clipboard serial
+ * @QEMU_CLIPBOARD_PEER_UPDATE: peer registered/unregistered
  *
  * Clipboard notify type.
  */
 enum QemuClipboardNotifyType {
     QEMU_CLIPBOARD_UPDATE_INFO,
     QEMU_CLIPBOARD_RESET_SERIAL,
+    QEMU_CLIPBOARD_PEER_UPDATE,
+};
+
+/**
+ * struct QemuClipboardPeerUpdate
+ *
+ * @peer: the peer affected by this event
+ * @registered: whether @peer registered or unregistered.
+ *
+ * Clipboard peer update event data.
+ */
+struct QemuClipboardPeerUpdate {
+    QemuClipboardPeer *peer;
+    bool registered;
 };
 
 /**
@@ -91,6 +107,8 @@ enum QemuClipboardNotifyType {
  *
  * @type: the type of event.
  * @info: a QemuClipboardInfo event.
+ * @peer_update: a peer register/unregister event
+ *               (valid for QEMU_CLIPBOARD_PEER_UPDATE).
  *
  * Clipboard notify data.
  */
@@ -98,6 +116,7 @@ struct QemuClipboardNotify {
     QemuClipboardNotifyType type;
     union {
         QemuClipboardInfo *info;
+        QemuClipboardPeerUpdate peer_update;
     };
 };
 
diff --git a/tools/qemu-vnc/clipboard.c b/tools/qemu-vnc/clipboard.c
index f62b2f2949..b85a2d8b55 100644
--- a/tools/qemu-vnc/clipboard.c
+++ b/tools/qemu-vnc/clipboard.c
@@ -174,6 +174,9 @@ vnc_dbus_clipboard_notify(Notifier *notifier, void *data)
                 -1, NULL, NULL, NULL);
         }
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/clipboard.c b/ui/clipboard.c
index e3d8a31ba9..beecb40e6f 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -59,6 +59,21 @@ static void qemu_clipboard_change_state(void *opaque, bool running, RunState sta
 
 }
 
+static void qemu_clipboard_notify_peer_update(QemuClipboardPeer *peer,
+                                              bool registered)
+{
+    QemuClipboardNotify notify = {
+        .type = QEMU_CLIPBOARD_PEER_UPDATE,
+        .peer_update = {
+            .peer = peer,
+            .registered = registered,
+        },
+    };
+
+    trace_clipboard_peer_update(peer->name, registered);
+    notifier_list_notify(&clipboard_notifiers, &notify);
+}
+
 void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
 {
     if (cb_change_state_entry == NULL) {
@@ -66,6 +81,7 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
     }
 
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
+    qemu_clipboard_notify_peer_update(peer, true);
 }
 
 void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
@@ -76,6 +92,7 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
+    qemu_clipboard_notify_peer_update(peer, false);
 }
 
 bool qemu_clipboard_peer_owns(QemuClipboardPeer *peer,
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 3751be3792..4587547c98 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1860,6 +1860,9 @@ static void cocoa_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index 90318384ee..6940f719ff 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -125,6 +125,9 @@ dbus_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         dbus_clipboard_reset_serial(dpy);
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 476e6b8303..6bb3d7f3fc 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -133,6 +133,9 @@ static void gd_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/trace-events b/ui/trace-events
index 339a61f341..917d116d90 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -171,6 +171,7 @@ xkeymap_keymap(const char *name) "keymap '%s'"
 # clipboard.c
 clipboard_check_serial(int cur, int recv, bool ok) "cur:%d recv:%d %d"
 clipboard_reset_serial(void) ""
+clipboard_peer_update(const char *name, bool registered) "peer '%s' registered=%d"
 
 # vdagent.c
 vdagent_fe_open(bool fe_open) "fe_open=%d"
diff --git a/ui/vdagent.c b/ui/vdagent.c
index b9784d4d9b..cc32a94fb9 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -477,6 +477,9 @@ static void vdagent_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         vdagent_clipboard_reset_serial(vd);
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index fa05d86f42..dfe830f819 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -236,6 +236,9 @@ static void vnc_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
-- 
2.43.0


