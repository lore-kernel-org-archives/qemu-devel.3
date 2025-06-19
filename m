Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AFDC7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNg-0004GI-1R; Thu, 19 Jun 2025 09:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNc-0004E5-5I
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNY-0008E1-C2
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:35 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8A05x013187;
 Thu, 19 Jun 2025 06:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=h3H3fxLIImpA3+uMFRcbHSmeNviC4QoeybtFHFgYg
 qI=; b=iVXSuQH7fTMG+uSo5TVUUnfDI7OUTEJ5k0tMrWzkpz9RB6BRtCWp+fcI6
 Y0Kq3YC75Yl7/qvoxUPf/J/OKIxgUw/sIs9bEnZ0opTy2vuzHg0r22YqzMeCHmGg
 YxN5E9qcwiy/+Ub4idSdnd00aCb6ieUXlutKGJC/z4CNc0Yo5gL8cQY/hBFJ4cN9
 qifwRMdK+iJBo+ntygfmT2d3beqH/nBQpPcwKnq+Dy6N+Hlye7dHJUEpsnJDBcvJ
 P2wE7Fe+gee9alkGN3wvJz8XAamlAVCC5cND4NVakXlXaQF8YbGpekInE8fI9ZXX
 LpbIJsZ3Cnp5ePs3RQFe7XdxgPA1w==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020121.outbound.protection.outlook.com [52.101.85.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mykwq7-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuE9xKUWY+IIdJ/fIL4nyPuMaGhyqHvNs4F5/QT7WFnkDd2ZTRRVN+MUqnNvNosJk+/T/fi+XiozToAcjwfHwFBxICvYPYkEwWwS4MSEZORc6E04phcR+lJGLWyKSOEhr6/5wemVA1w2H4PLbZB3fNKk4AVdfuyxzQmyeX5yaRQHrNw02+2N1xOw3wNKNvFX5ihstMoIC0oatbeKYO5yuDuty20KIxOqQgE+Hx8vbZVNzujMlHf+z8K9XpyPH3kcqzARsEs8+O6H+iir1pNt0kA27c5Ass59C0hd2uchjHDbOvAtvT2ZldmG3pBq7/ts/uAmZSosbIldKLFd4A9h/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3H3fxLIImpA3+uMFRcbHSmeNviC4QoeybtFHFgYgqI=;
 b=jaCPplYvLRmKU0MYrIugFEwknZG1yFDjaE6+LVTe1QOQ2yl759MdzMZdUgftu2X21ENIAnUaNO21qJ6IxVJjRuLCH9TE9WNOAlRhXlqYOKRZzp7NVecWauK8nzDMlf4loOiLdGFZUK/+lNnNSQ54msXxVQGOqbkXY1EIxO4AJkQ1m53pGl9HV8itwvf1VfEJiuuNyxikwPTnoxgYjVhiMTfpc0wKs1nA/YAHOpyXHOC0ed4RgU71bRn+M8clPFi4nEO4gNV18LEaeSiZSd/16/ag6lJJJMEgZSE1+CL4TLges/gvkcLDed++dcn9UuNbIroG9UDpzkV/JtCfqmJaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3H3fxLIImpA3+uMFRcbHSmeNviC4QoeybtFHFgYgqI=;
 b=T+eLd5EWfzQGjKZtJkbYNtjRF3BgNiGwV9HLo0PP1DJS1fV8lYM+rOPz7NjQgsI4BcHGq4dxmjNIt8E0vomhSho1xOtGfwaIk2FYBU5cF+MT5FmcKfHbZDdUIjwISNDqY0DMoMhIlBG5R1gWdeRTGW8/cZUc/zbuPc8Lht28fCTLslS0WrUXi//xNVaSdcT57/sAGAOZl3bz0gJME0dDVCiGMJWOvXF2ZqEzP+/GkGIW5GLgtRbMTB5oAiaOTOnz2yauCxQId9QdQZuMnZkkDGlT8DGxoCSDeuGvf1k1gbBO5TrNa2Q6I/SaVpBQSg2VWwqtH+UuD7rnyIzGm+XT5Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:19 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:19 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 08/19] vfio-user: set up PCI in vfio_user_pci_realize()
Date: Thu, 19 Jun 2025 06:31:42 -0700
Message-ID: <20250619133154.264786-9-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f0b573-99e3-4af4-b81c-08ddaf35b6b1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DNFdlVQQJ5V4Sqoa0jp1JQ/HTV1Y+Y2ufcWE730bFrVVYl6oibvkduWh1pVV?=
 =?us-ascii?Q?fUq0oRUiBmhqfX52pON95N4OquvsT5xolF86xIRZvDfGP/r6itFUHL3f/MHD?=
 =?us-ascii?Q?JJEGE3ZpTofqb8KuXLBwlIWEBmVp15g9/jGaPxlFPu5inzGM9EyiZg4sICkj?=
 =?us-ascii?Q?BlOcOmyZGkRMSaPHKrtan8D0kriUtim7qtIfKhwlSlTizpfOw+8cAf/sbRA4?=
 =?us-ascii?Q?reKSjltMbNMMbS7zhMdNK7nogYAEJmwzMwhu/yKgDqYdurJx6m/P5S2b+RaB?=
 =?us-ascii?Q?Kxz/nrez1xDZL8TbzrjaTXstcKDbbRqt3AIcr8qXmYsTfeofbYE6j61mbw/K?=
 =?us-ascii?Q?pUeVu3VcbjmvoyTHkdY+A9czfF0MyzOTBbLkd3x+/NXFXKQloy7SBpjbRHDp?=
 =?us-ascii?Q?494xALvgkd6ZFxa0iQjxjnlCIeCbNBSMcgbFlO2O/td0e1tjqNUFFBYpMJSs?=
 =?us-ascii?Q?QeAbbZB1dU5g2yj84sN+Q89V6ynrLgFgeAxhaTsu5g2SHfFv3BK+hRVT/GeJ?=
 =?us-ascii?Q?2IPIVD9zCjLRtiutheP88YrtGaUq+07q0yyhN9cLm1XQJj2xAR5u+amXECXc?=
 =?us-ascii?Q?vGUSV4z5nhnUkpPGS4WaAh0GxA3mXKjFltCzR/61b8JYRQtaucJ6eS8Md8ZP?=
 =?us-ascii?Q?9GHLeyTtGF1L8F08BXE38Lup342G97MQPoJaFyK8UCr0TVHERt4DwKTQ9xr2?=
 =?us-ascii?Q?eoCvBx3UTAuktnlJs56slG+xm5A0978MocqX4ordT7IpLY7/Y46KUm0mn5Mc?=
 =?us-ascii?Q?lpgKYKaDUcbw4i1Jf19bBVw6pdJT8OhAMbOaoXadsd8vzKo4S8qC983TRXnN?=
 =?us-ascii?Q?mHo+gHrGClfOYgzwDO2PLtTFHezc8bqACFC9U62G5AsMede2ImCUKqD0IkqH?=
 =?us-ascii?Q?DX49pGs8fO4/3hH7+od/Y8T4jTYDgK/UcXgzTmK74jByzauPgDh3//rU4S1L?=
 =?us-ascii?Q?kGXwMipcRACXKxZkGAU4vzRyydxAaQwLMwmF9+DUDDH09cQqWAxTluonW+a3?=
 =?us-ascii?Q?CcTCtnNZfZer43PJB1p1SdZ7nMY3142skJLr47D6EPUwX1KsYGnwhyEQGoLR?=
 =?us-ascii?Q?MCDeWhxo6CjLhW68nP5a++0/py8RgQiaSPHt1dhJuxolzECPBtqwj6G5/FeO?=
 =?us-ascii?Q?L+pEYwGkua8v6gUObcz4b7NJq4BZqSeCP2SqyjEbuy/JVolt76GN/EHcxUpU?=
 =?us-ascii?Q?1HqIkL7DJhDZx2GuHxFlRSf9yTJEgf4mw2byMZFKMZK9ZxSBIYwCf+CU0m5g?=
 =?us-ascii?Q?A2FLs17kk3rg5NlE7SkiEjaZKYvuASoYxViZX7230YG3Qw86s8EVpPQHugoo?=
 =?us-ascii?Q?spMtkcMMBmhUgBgNZqS60mA9c0bGUbIuU0VkbDxF19js2bgAeH15sbhwjWXK?=
 =?us-ascii?Q?5DS6aQ4IOl0JxyB/khOcOycIJjspCvp8ziKAPldLofjB1g+CLCy0advM2kkN?=
 =?us-ascii?Q?YpQhTeUX0UQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kXAJNPMG2uDL/HU1kUCRBKPq2Es7mhQrCRD/9ITdQaJpRf1cjcMffmppDWkC?=
 =?us-ascii?Q?zqwj+Y9TMs+eemxB0NZA7TxEMVGsUfts/EZ9ZivJDxuLp02IQR+NjUx5UIHp?=
 =?us-ascii?Q?N/R3yNWMSIIHtnmwhi29XgmwMayUOFhLf9gW3IbhmsXJxRoBrJ19GfPCPTVX?=
 =?us-ascii?Q?SmhVgU3kLdagJX8+LIJqtJLTQVsw5+Rmnm+XvLArFD6Hsu7MHtW3682YMKgX?=
 =?us-ascii?Q?4p/w6id31b+JHW5mLKvP1QdJz6j8iL5pJ2WyBa7YUSnJpj99Mrbj9FSAFLOV?=
 =?us-ascii?Q?P3w8BF74gIObVnV5r6BQwAmvbVtk5awJ4c310AV+rVh2lhSEvCG1mbygkIH+?=
 =?us-ascii?Q?dKbmaO+5+UO3nPZ/XB0c4sXOD/LPzb/wv53QhAeeAYpjEeSyUYjOihSCghct?=
 =?us-ascii?Q?kGMNlsq06vaXclW9GR0jaATJL45kaJ3gT7L9UGqTWPQOlKswpFWqrUlW2XmS?=
 =?us-ascii?Q?DiuPgEFJt3qlQlQk3P3jwQlTDLl+/zdJg0mztqGAy/9pGyy0/T+7/MaD7DT9?=
 =?us-ascii?Q?0mmEF3rqlKTxOQyGjFG3uhEEZAom5JPFDw5deoUTo355+SH5FCGe5G9uBb4z?=
 =?us-ascii?Q?dlERocBPbXhocn0Y0WJ0mHrvZtEG3tl4CPoWAraKTgywn+6vMuWPLozuQwQJ?=
 =?us-ascii?Q?dqREv5wuVvBhySiNiIpFPh2D5A24rZ+aqCo39nRy8+lCeSslXJVswFw5OMZV?=
 =?us-ascii?Q?gNQ5rMkWn+pfmvVmlbePDq5am2kxWIvAoAZ/2K68WyoQyCXdcZ9X/83BMf89?=
 =?us-ascii?Q?H56CntxLzpB6IdMCdXLDqDfNT7nrSmiFHo3UY6W8z8Gs3Tx0Hk/F3UGkbJCR?=
 =?us-ascii?Q?pSknKT3StaG6Vi2h5UHpGKS/PICv1R/SBzQH+OOnSZetKtezzD/4BjOU2Syt?=
 =?us-ascii?Q?qxl5hcKkHVWpcQmPuiWsaqE9uIrulDF4gSDMsWd/1qKldaasTgqAj0z9KtoI?=
 =?us-ascii?Q?BtMOxjmYLFz4TonrSxlZzXc2ov6pAtlLOF44esfMTB9sYkEPHLv3qlX1kgIf?=
 =?us-ascii?Q?pco6OPVF/QdQqOTxl5rZ7DbX6s9JD0sZLSAu8eR02fSBHIMbAWAE7K1oibHp?=
 =?us-ascii?Q?FWlu7D/WSdR0FmeRrLsAiMVYGIeN0KvZzUzczuiocREFG+vlpUF8Z3XxdM8x?=
 =?us-ascii?Q?hX1zeGnTIaod4pb9syr0CSbF7LB2feYBf4OS5taIKB6sR7i4tZw0thj5w5aq?=
 =?us-ascii?Q?rPCSFvaqz0J0JJvISU/GV3A3P/uKUVbi7kT/CKT4UZ3yu8FiyQ2LKrP4WX/X?=
 =?us-ascii?Q?S7Vr2QbLwBWZxkj8M6QKllB8f3SnzwWkCAFv8+S7MXRgA8W0/OqGwzsCD8Mm?=
 =?us-ascii?Q?6yqk2wYkOTjKGemLYYG01WaE+RdDmH712SOwz4w02QBjDcwaI6b4goVCSXd4?=
 =?us-ascii?Q?SWqxumEBm42VKEWl4QwF5lCd38nXjBO8yfyKL/fmZUdAnW1QuGvP//aeC2Gy?=
 =?us-ascii?Q?69mJBer2udM7EN2hbaUrIM9bI4Ch8gMnXFzdbFiDNhasSJJKlvvPoZhi9S69?=
 =?us-ascii?Q?sf4V9ltqkCyjm8jnAitupM+GYTfw7Mc7C1VI1BrNRTW2kocNswQw6nqBhEI2?=
 =?us-ascii?Q?B4Kev14Vsv4s4jMJifqVG+d1Yc9+jFxZnzWxhzcN?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f0b573-99e3-4af4-b81c-08ddaf35b6b1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:19.3144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyqW5T2daY3+PqvNwjXggmEb4oK9Kz7FCazeWktHQdVGF9/THiJ3fejXYVgbfCV8LaHHrHxZWw2ZDyOBjo7w+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMiBTYWx0ZWRfX/uc8wsaLazVN
 Im+rNFF/+qZYuZlxywWJR/yOgS2cm/rkSJVQzPQ+SV0Se53Y5SRQN/OROcVnbTzbL5XaIRb8ksC
 7i9438bW2fWLMCDEqpXm60cfB1nlwL9tFzy1EX4U5vZ1hegBtgGUDq1RhOrsWVwwgn33bOisaRd
 8HLNhhUEeAI9LxtnFrtECjgOqUkfBcSKX5zgHOTxp+kn2iMOLSc9icdUGCxiQ3JfIEaS6wxQbmt
 3PViAOnPZXN9yShvGbMv6JO99ZimVnoIUXJb2o319VJsMEjcprzUaBxQUkyhplgmo8AZkK2G76Q
 vc9+lP8dEL1+AVht9LgmWxK4GOJcju7vJ+FPf3M5/s2K0uShfmDJuQJ6Zy8XCMtEk0IU2rLMtDo
 Q4BhkujDo6qdDrFqxUGMaIDIsZHKEnMmXDxmnyDo9pnDkdOcJKsp6AmSfTBflJm9ZD8LgDW8
X-Proofpoint-ORIG-GUID: CUonwYwkAeBRoKWIQTi-jdUZZD2P-SxN
X-Proofpoint-GUID: CUonwYwkAeBRoKWIQTi-jdUZZD2P-SxN
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6854116d cx=c_pps
 a=Yi5XoY1Pvk1/bV4Hj+lk7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=uN1uQ0dK97G9gywtELIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Re-use PCI setup functions from hw/vfio/pci.c to realize the vfio-user
PCI device.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/pci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index d704e3d390..b49f42b980 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -126,10 +126,39 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    if (!vfio_pci_populate_device(vdev, errp)) {
+        goto error;
+    }
+
+    if (!vfio_pci_config_setup(vdev, errp)) {
+        goto error;
+    }
+
+    /*
+     * vfio_pci_config_setup will have registered the device's BARs
+     * and setup any MSIX BARs, so errors after it succeeds must
+     * use out_teardown
+     */
+
+    if (!vfio_pci_add_capabilities(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    if (!vfio_pci_interrupt_setup(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    vfio_pci_register_err_notifier(vdev);
+    vfio_pci_register_req_notifier(vdev);
+
     return;
 
+out_teardown:
+    vfio_pci_teardown_msi(vdev);
+    vfio_pci_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+    vfio_pci_put_device(vdev);
 }
 
 static void vfio_user_instance_init(Object *obj)
-- 
2.43.0


