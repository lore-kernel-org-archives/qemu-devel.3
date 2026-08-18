Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50CEC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwIiC-0000qi-3i; Tue, 18 Aug 2026 08:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwIi6-0000pn-V3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwIi5-0001LF-7h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:30 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IA6Wtj1191337; Tue, 18 Aug 2026 05:14:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rFCO2Yhy84q8PKdVQ296nxdlgf9jlSmIFYW0x+EpB
 vk=; b=2lqWfFiV/quMpBb2GKtrytYqNE5bxSlEk+O1eoIkXqzvYFP7FOdiMFD4j
 W/hM7aCfDrNq5DQI7+LE3bx/YYfGXM8JTDD0rpc+hmbDEryT8txRtZaakQ+sONw/
 c25WikMLtdoquGS+BKJqdNkZxZqg9ANtQQrR1zP7HdUv3zBnbcMz/txknziiBvJ+
 qt0BocB7Al+DfLvAekZ322zo7avudexsSXbUOP4hMx+EaoHOswRhASDPjxA/A64/
 7mRPLrrM9lWONNQ87TOqs+/Nnww5L4FkAxcXLAtT8awRzhaDL/IETQymxGt0W0PF
 bzKpS19EiSji2/cVs9JZ5hkE+LzdQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022091.outbound.protection.outlook.com [52.101.48.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2m156kg7-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 05:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXzzvSRBUIZEEAGEEcFkZwm6KlDGsWRFWGQuUiKGLHcN+g7ff1VzpotIOk+QimMKcEC0aH1HWMQxTUjzLGtu47A+5FwKowRSV+u/qIjMqmQ9rpnvGzSNwwdDx43FPYD9sDoigFaQoge0jfTVUUmCoNCcQTNrHk+zfWQ6GgJ4QsVPqOYbY5qq1/8W+luIG/NDyjNpF7RbEABuE26ov8FCjBtvjba+UmwCyHSO+MMc77gPK768GwZnlcSIH1CI+lp7QUjYBieAG+/sv/UVVu+r9Figu7K4M7+FQ2hpyiUKAoBCTs2cbtyoGnhtXhpqOZXddYCU73ighc43H4Eb2X/fFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFCO2Yhy84q8PKdVQ296nxdlgf9jlSmIFYW0x+EpBvk=;
 b=PabEvSquanl9/FotfaVSprRrRednqolb/asRH6UbHm7qYt41kKs8lAqcOntZOY91TiN1m7A2q8fieRPGY2jbXrnyoGZ9LcXX17HRoHVxo824AlIuDs3VWd6u5lTRu71EO6VfsIT9kQco0o7dZntfB/gd9iemKhpKQq7wKjekbbVw1YVK8FCktmLdOWV3l5Z881MYLrkKQSsCIjFCDf+S2JvRSbyJ0MjNnz/U3y0CKmHgBQII1n17uuipZUEuzWIXeCfUQixWQ0OsYVfsBgFCy2HUL9lPYJRbL5kOh6BaMX9FZe8xSQ0k7VinEGxwR8RGSH8z+L4iURaxVL8MArk04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFCO2Yhy84q8PKdVQ296nxdlgf9jlSmIFYW0x+EpBvk=;
 b=X8utnHPJIr7gSviaOC6qojmuGU+94lYPoQjvzfIoXlo6z/kKBeAG33UZGmYxfCrRTJEFrBHgPYt3Wq9WeeVrIB+JeHQZXKQCkf4CRT2gANaWItUkXa6+C6vmSka27FXlolhx3mHq9vziEhZAqrlr5TOX+lZXPimidD6VpzsIYRXtmwP6EqQxPP2F15gLvnwulbIIC2/7ettcS5309fOWGF9VxxhoIbu1pUcobwpLpIx/z90611ft73TupKNcm1qLDLJ4OtkH/OG8kYr//ucCiSYyCvlZ3P7YzNjlkwhgZ5zh2PqLtmrbL5BcPvfBSbDqnf6pg5wcNs7HMJiVCvxlbg==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by LV3PR02MB10210.namprd02.prod.outlook.com (2603:10b6:408:21a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 12:14:25 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 12:14:25 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/4] ui/clipboard: keep track of clipboard peer side
Date: Tue, 18 Aug 2026 14:14:11 +0200
Message-ID: <20260818121413.2660786-3-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
References: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|LV3PR02MB10210:EE_
X-MS-Office365-Filtering-Correlation-Id: 173530e0-3c27-4530-39a3-08defd223e60
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IZZBtZnWAeasjwAYf3c9htDDPLljOxI5jLtr4JN1SKcUanASqH9NkbsvAHAWaRsaF9xrWlMKiBMLIaVvAh1JfGVfxwH6Vkh5L2+iWXzflwq2KgMzFqxyCVwGcVl5fZafWGJUTGmzUqEDPrm+n6og67sEddSlC2Vzi/zoeH+2EWVfvw7CYiNV1yi93nvuO4gveE9z+2kEriFRFjBEmQ0UClFN8cQ2mXlZEPyXKs176eV2kYewOxo/rVBioUBubqB5FWrlO9T1kY3loPbNN3tS/Kg/G8fKkCWfMt6Sc0572XcOhTXIs3OxCdgRyljzXtTsa8T/YSMjNyhCCYGmot9bCs9BDxqU9Ii7Ai22SHTbcPAqUhx2FaFKjsrhBRwoMlQgcDKt2vuSd1mh4swo8GofPtPG2b1vSWuAKMW0mzJtb8VoSbQZe12gxR3x3xuMMmksCg0pTwGYu8IcSJ0xeGqo4YXdyk3PRGwMtNXngXA12R5ss1JPgk8xTO4Fix7EYNcADfGiI9n6XQ96o7QIQ4UhlgOuZTAwDoa+Nj09PE+ZMRNR/0dpF0nqcpsX4uaGvYTNvM/rAZjht6S7zsEJaQ2OgXTB8mTucXPkUlbwK266ySjJw/aWH0KN5UiwJfjx9qeviNu6S0Q+H8OSj3oqCBlEOOd1NgLzDTNoN2D/BumTXbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QrZmwpL8R6V7qqvyRv6zhkZ0w/0D2kbsQEE+7c7PabLNh4S5rEO+P+2LLHKf?=
 =?us-ascii?Q?FlhPZGvSZQXcpYXGaPneodiRrA8RuwyVByy96ZXogYcklkCKJgdjeHajfDZz?=
 =?us-ascii?Q?jcfxOOX51XZ6C+xYixwL3fgSNI5Zv4lq+VFVBNktEEf8Lw2E0SDDYczxnDso?=
 =?us-ascii?Q?yc8ZfqnFJP54M0bmIFPiOqxhMQeoiGuo1KNYqZIUjyCuUjCKUBwav3o+S9Ao?=
 =?us-ascii?Q?3DGg6flrvqocwtqqN8/j70a8CCiZP7biTSRlXRWGNRGSghK6+7vZNRvspolo?=
 =?us-ascii?Q?X6Vhvq67KErhAdBB8h7DK5q9sWke/jANuymLWAoLHvZjImyOx6Pi4t4gbFwo?=
 =?us-ascii?Q?rsWLagpIIETksjBMnYxOJ2MILPIb3smwkDdsoq6eD7VIrVgjLL86LbawDJfw?=
 =?us-ascii?Q?nElrFSCHl52/RShP++91g3s1G7GB5wOI3tyqKxeQ281L/66/1Ah0HquWFW8n?=
 =?us-ascii?Q?9JZxiFCzmV5MIW3Hr3ykhYT3+YU8u8NMLoxiYveGRo7AtbbqpxdyW7jixFBv?=
 =?us-ascii?Q?UIs1jBqAROtMglUSQvTJ1hVl5oN9opjtyF2ZW1ZuED8cZkBQmNjMs/l+s6d1?=
 =?us-ascii?Q?G8HRHoAFwXpOC6tlnNjzt6ZeQ2j+CiOfTcHUshMyz6M9mOYB4nvgq95vzcQi?=
 =?us-ascii?Q?P/ZQt7mQi0SqG5TOkqnzJ7o4CLBnMS/+Clti77ClD2R16PKT2CbVfphSFQZs?=
 =?us-ascii?Q?AgLyhxRbYZdBIRTiMotUmhPdO3v2qxe7ZUjaUG28Sf1K+HkvNUIVO+lJ1wEJ?=
 =?us-ascii?Q?zfs5E8ioxGRQYOlP2oDmfvmgDv9afYixb0ruB2EheJ/iFRzeacDRZE8EgqS0?=
 =?us-ascii?Q?JKUjLrAlP0bUQN/J4eKMfci7qZLJfGF1NjesjZvSSZ4Gc9KUt4P7LoLxRJhp?=
 =?us-ascii?Q?kC9ZEXDVqk74TK6mCYNcZ15D3LZEhYN0xOGLQ1nUN3irtzf0nwXI1Y+QMBLh?=
 =?us-ascii?Q?7mmqlgHUe6WUWDY28nKDVEmTddyATb7H2UHD/k1QOovYeA29ibyuydqIlN8g?=
 =?us-ascii?Q?uJMVwve7G4NQsX/qSiHk8oyaehjrnxaC9j2Zvdm7/zKA9JBKlo8iOTJnB0mI?=
 =?us-ascii?Q?UAUmEVGiGLhYkrN3BCbHFdzZNk9tkkqyVp4Bz+/SoEfLhAWj2ObAIzgh6MnG?=
 =?us-ascii?Q?ihVMTajiKBk9G4b8SXifEsrKMpXDVNqIif1LR02a+m7wKu5mGkPaLlcS0Jnn?=
 =?us-ascii?Q?5FR/EODQwz+fAn6siKiCuUdhFnviHSdZKtYwIZgaKiUlUpe6CgT0z1U66bxk?=
 =?us-ascii?Q?fuOG/ZLIpZUlkEsScXy0UHBPbbF4RBm4tTFQgyaxc0tkSOIC/T2LLJkX9NCu?=
 =?us-ascii?Q?/j0QNwYAZzQQaPX7+w1u2fACLG9FSQsBqeC+TkuhsVUKs3QMMQ+ALUfEHSm+?=
 =?us-ascii?Q?UuOsX6t7Xwpj9cC7oI1J/PmgKZZp8gY0QQ34TqGyqgzS0MKXyOksDm2DhM9k?=
 =?us-ascii?Q?IjDuSE1Hwj/TPAaZ8D0G3ibBXIx4afRZo+DhTeNz+HzfWEnphyzCpfK15RgZ?=
 =?us-ascii?Q?UsnVf6irxproUhpvNmbFMTFfzDVN76skdtqtsRyOJlkDBWcVddWtK1zcYReW?=
 =?us-ascii?Q?1oWQGm+TAn4H9qmowO9GUhDIeJDqFLT/3TbJ7lQw3DuNkxdwFAUwHS+zdJcz?=
 =?us-ascii?Q?wQWPhnLOLEtVbGZ9dP4D9WkUpflJ1vJLjZs5T9plgedmbDL9RpY4xZmPVN8H?=
 =?us-ascii?Q?0zkT6IK8K531+hro9WwQKy0dFk3QKraBwMcGN7vUSMCq8FgHYR0y1aHy7rIO?=
 =?us-ascii?Q?mwQZqqjaeQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: mExEIP/CUxLmQDI61HCLHWhgQFPKz18+AkM/UndONQ9oZy2vwk+THZE2dZQLQnpZy7hkgq3ZnN+9n1aOxxgYHfjiOo+aPMM4BO+WNHuZgBhC4wlBmzqF56apLTAuKAjdvq8GZMYcUDbyfNhZbNlLrlKMtBTeCpDJ6WDEBMPUzIdefKm2zAmVRb0V5aPwhVDE0xMVWJr9aHeY256nXsYRAXIE7Z08qfeBOWUctuconAMn+70oip1nShIFAGKpG11fyUUx9nzUjdolZzt0sSx5LRW9aaqPunQIwVwvDxsqL3td0uQY7NMGhRQ5duY4EHHiXLqDLFzhU7ymjhRK2n3V/Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173530e0-3c27-4530-39a3-08defd223e60
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:14:25.2040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+97HX5iJEUnDwdjiHcPT7NxUrO3v9rfU7oU/azPuiEYwL/qYDi88p3952+lQVWxx027yZB/xSVeyo1icRNPYA/dT4CMJ58L/cv9ZYNxJ7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10210
X-Proofpoint-ORIG-GUID: eqbPn-cw4Enzt6lBWAPSjYOl571HMNXv
X-Proofpoint-GUID: eqbPn-cw4Enzt6lBWAPSjYOl571HMNXv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfX0YWBxIR97RWE
 XjgXaBrm6TkT2bXiO8aJt7TO1xPKQ6vQun8UoR7nADlrC0dIyfYbK6+WF13DLZpOV+6IA945Dtq
 y2mHUhb/LQnozzs++fS5XHwiT4++xLZfa/Q+/w3F7WyJd4ADK2zc7Ltaq/ajzfbY8Yy8oQC4vD2
 fA8yXeU5ZBzaUfEQDWTxCYVAPrvxNsoCNPwlOXY0gOpqsn7MEwOBYKw/+KfYMwxaneOnd5XZArQ
 FUYAuCUU816KAavgIW3/mFeX0ACeOQQKM0bsfL8vmdciBf77QnkIssVnIuxr4u0Re65nVDRHmcS
 xSMrsfVnfRt5zPoIJVGBazpW4k+kSPbU1DZ6NyTXI4IrIBj3A8+tqVCEwACIq9Q+mMFXr8Kw0js
 ++2iHTE4RZ7BcvJ/YNUHPezhPMC12pbFnNpHS9cqylEUA3Uar3Di6irMYIKEQeXrbCqJJNSljIG
 MquGXd8NLiAecm/wWwQ==
X-Authority-Analysis: v=2.4 cv=RImD2Yi+ c=1 sm=1 tr=0 ts=6a844ca3 cx=c_pps
 a=gqqRaR/JtIFMplGXl4YyTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=TOO3SWKWT5g-K1EAlYwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfX/vpLru6Ei6zp
 h3xkD+NLBT6ljelVtwuHBQ2PBGdpeME/X/hWtOw49WizyM+x37r7c/aJ1GGQNU885T3u8IZ4JYr
 kspZr6OLXkykLkHg2At73g6k8ht+Xsw=
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

Add a "guest" flag to QemuClipboardPeer and set it on vdagent peer.

Use the flag to keep track of number of registered guest peers and
allow to query for their presence with
qemu_clipboard_guest_peer_present().

This change makes it possible for a clipboard peer to determine if
any guest side peers are present so they can tell whether a guest is
actually able to participate in clipboard exchange.

Change-Id: I6f39b846fb560ea52f19e14cbee34267ba404453
Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 include/ui/clipboard.h |  8 ++++++++
 ui/clipboard.c         | 16 ++++++++++++++++
 ui/vdagent.c           |  1 +
 3 files changed, 25 insertions(+)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 6166af5139..df7fa5e491 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -69,6 +69,7 @@ enum QemuClipboardSelection {
  */
 struct QemuClipboardPeer {
     const char *name;
+    bool guest;
     Notifier notifier;
     void (*request)(QemuClipboardInfo *info,
                     QemuClipboardType type);
@@ -179,6 +180,13 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer);
  */
 void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer);
 
+/**
+ * qemu_clipboard_guest_peer_present
+ *
+ * Return TRUE if a guest side clipboard peer is currently registered.
+ */
+bool qemu_clipboard_guest_peer_present(void);
+
 /**
  * qemu_clipboard_peer_owns
  *
diff --git a/ui/clipboard.c b/ui/clipboard.c
index beecb40e6f..928aa435e0 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -12,6 +12,8 @@ static VMChangeStateEntry *cb_change_state_entry = NULL;
 
 static bool cb_reset_serial_on_resume = false;
 
+static int guest_peer_count;
+
 static const VMStateDescription vmstate_cbcontent = {
     .name = "clipboard/content",
     .version_id = 0,
@@ -80,6 +82,10 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
         cb_change_state_entry = qemu_add_vm_change_state_handler(qemu_clipboard_change_state, NULL);
     }
 
+    if (peer->guest) {
+        guest_peer_count++;
+    }
+
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
     qemu_clipboard_notify_peer_update(peer, true);
 }
@@ -92,9 +98,19 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
+
+    if (peer->guest) {
+        guest_peer_count--;
+    }
+
     qemu_clipboard_notify_peer_update(peer, false);
 }
 
+bool qemu_clipboard_guest_peer_present(void)
+{
+    return guest_peer_count > 0;
+}
+
 bool qemu_clipboard_peer_owns(QemuClipboardPeer *peer,
                               QemuClipboardSelection selection)
 {
diff --git a/ui/vdagent.c b/ui/vdagent.c
index cc32a94fb9..cdd4cedad2 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -695,6 +695,7 @@ static void vdagent_clipboard_peer_register(VDAgentChardev *vd)
     }
 
     vd->cbpeer.name = "vdagent";
+    vd->cbpeer.guest = true;
     vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
     vd->cbpeer.request = vdagent_clipboard_request;
     qemu_clipboard_peer_register(&vd->cbpeer);
-- 
2.43.0


