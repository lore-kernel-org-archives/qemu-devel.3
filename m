Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1490C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxP7-0002os-Am; Wed, 02 Jul 2025 09:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uWxOy-0002lM-Pl
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:21:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uWxOt-0007BD-Ar
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:21:28 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562CKJvp024094;
 Wed, 2 Jul 2025 06:21:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EVyubB+DVKOBa5SExs3/Vl3SBmAs/0pZnKxdv2Q0j
 Jw=; b=kijLwPrULp7GTZCF5kkamF9Q99Z35QKiLIAOTkuOC3nFkYvXffN+0O6bO
 H7c/9M0JNxmdJ/sr81b8MjlhDbgHRSQO/1f2ykpRIa9XOe1vedW21LYeD7KmD91B
 tq44MlXRhmF2UzLVW3lEeIhOa1PF6cgm8qn713buCwhEBuqjFY79Z37C2bfibMEq
 Sh3GUAqfE2/EF21urIev7IeEsNM6saNBspQ1OW16TDtE4ZSquolXxVBEV1em53ZA
 qF4aFI6W9/9gqh4EZ0LhcV+P8Qt5SD8PNdwRumgGPqOPaCFwkWPRdOuLLI6zcrUy
 EtyigXaSzotFqRs8oBEiXAv84397A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47m3agcra1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Jul 2025 06:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mv0SniY3gveU+oXFEuGYSjzQ9bqdG80kfO2vhWWrh8UMZjH89Yi7etzEn7EhVktj7UT8bi89maMMVkiIh93XhclBGYPFg+O7e8YR4gbjylICqa212aJwfX7luvHVnaqQ0gBNXKxAYogCrJ5t8gW58UtV3QbVncsMDsF3UBsZWReu/lmQ4D5+ine4BNeK1IB46yjzzz18aYUNEBWsZW5Yrxz7hfElUfg/dtBeKUvDiWmAa+q9r80FwUPW71uztUbkPOod+LJnGljN1klOmZLXIeWbANmR0/PyySikMaZp//2RZcK4Mv9elLaCqAgqtERl/gizFJeZi38Go2cGEbloKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVyubB+DVKOBa5SExs3/Vl3SBmAs/0pZnKxdv2Q0jJw=;
 b=Dpoz4S/guH2n0R5yQut23P7USqCeEkDbWV+2u59Vmjevy/3tETjz4Ed7sndCqnqc8sdJ27fMhTSbptmAX7MTfruLachxmxJGRXP7THpbju3fi3LxAN5ulGb7RKLO47TTG1YbUAg7F5YyTFQrTA2ZFid/kIzBuVck091E75s47HNFoFQc4yO4Ji/bmG9VSO5shfNodUVQfTaH0OQUk/w600K3MlDIJkdj8jPdSv6wkUyGDbgqPJ8yZlS3x0L9WQzmJd3epitwt4ng0mGIsVCaHCDYeP8D1SrB02G6SPdPFEAYVkogYt1eRMCIj89iMqPYuc+w9mMbl6+cxw8FfLh5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVyubB+DVKOBa5SExs3/Vl3SBmAs/0pZnKxdv2Q0jJw=;
 b=CgOJREAa4V3zCJBA1xfejF5qPPeDV5cZswm5Y7r9b1pVD85G8krp5uuvcqem/B7F3aSFPQhPnT/IZai0VPEsDfX6GwSOogivmNTQnwH+dHTsjAfmfMkAD2TGFRyAA6DGXcuG/lfzRsJxkEnswdmkmM2oDyyq97u1lvJ8vhWvUpF8zk+jMMX/w6u+rUhXYCzacI9jahaodXhZiCOWY1s9gI/Qr+Y/AiVMw6du+jPqP8+9YQgpRf42WW9i19oFlrXxUBCKl4zvtOAFidrP3ghe07mRHnOvsb6uGJzanc+tYzmYlCyfOgw252PuYAC4H1jPA9QZd4axriQ+a5biKFdeMg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB9492.namprd02.prod.outlook.com (2603:10b6:610:123::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 13:21:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 13:21:15 +0000
Message-ID: <b2bb792b-183c-439b-90b5-9a2f6bcfe864@nutanix.com>
Date: Wed, 2 Jul 2025 14:21:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: do not register vfio-user container with cpr
To: Steven Sistare <steven.sistare@oracle.com>, clg@redhat.com,
 john.levon@nutanix.com, qemu-devel@nongnu.org
References: <20250702120043.267634-1-mark.caveayland@nutanix.com>
 <4543142d-de4c-42fa-9309-3f00ad44110f@oracle.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <4543142d-de4c-42fa-9309-3f00ad44110f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 6222fc09-132f-497f-dbb0-08ddb96b5262
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXp5VEgrK2VicklCbk5lRmFXMDVySVpFcWc1Qm10UU5idCsydGw1My9LNjgx?=
 =?utf-8?B?bm1zdGJ1aVVBM0pLRUF5eDlXa01QR0c3Z05qMm9jSHVTOWV5cTZYODFBYWlz?=
 =?utf-8?B?UjM0c2lqNDd1QkI4UnkxbVp1NGpJc2doYmZkb25BQlFibTFHQVVreXpDZWJW?=
 =?utf-8?B?Q0F2S2VQc3RJaGZncS9JSHNvYlNzYXNmbzU1bjRtVEh3aGNqSW1IUFhTNkRB?=
 =?utf-8?B?OW0yT1VuMTd4aUV1VHNiQnhGR2Q4TlBzZXoxb3hyR2pvQ3RlYU02R3dONmVX?=
 =?utf-8?B?b2RMbFNDRzJDQ3IvUWtqRmtOYXNJOUUybmowNDAwRlg4dUMrbmNZSHkvcjI3?=
 =?utf-8?B?VWpTeDMwUmxOdG9GOGZqRTlWU0tvaGpQcCtHeElndE4yeTQ1N0YrKzVJMkY3?=
 =?utf-8?B?RUlSSlJUS3pWQmRmVlB3aGh5ZWl5QTdjaStsVVJ0dC84czhqcmYwaHlIYzkz?=
 =?utf-8?B?ODRTN0Q2a0pTT2xNcEpGMnFxcFRZNjFZYUIzZVBDYWxGMHFoY3NqNXFqV296?=
 =?utf-8?B?YXllR2ZEN3B4U003MkN0dlZPN1Awd0RwelBETk92dXMxMnhWUDIvQlh2c21M?=
 =?utf-8?B?THFrOEswMHJJaDBRbEhvay9vNGhrZGE3V3htY1pnM0pTUFd2a0d5SktSV1dV?=
 =?utf-8?B?enVicVg0bnRBNjZpbWRGaTM2OS9SZ0xrQUc3RWNNZjI3cUVpRjdyRFJIcHMy?=
 =?utf-8?B?ZEl3enpQMTFzS2VzWnNKZ1U3ekFqNXRhRGNVbmcrdlAzbWwwWE1Sak0yYThH?=
 =?utf-8?B?blRtME9lejgrSUZSc3JONmMwaW4yNGw4UmtIUGUxZHdVUysrWlNhRHk2eDFU?=
 =?utf-8?B?N2IxbC91ZXM3U0VZeXcwOUpDU0M2cXRIbTdlNUxrL0MwaFh3NmtCZG1UeU9N?=
 =?utf-8?B?Y3FmVy9BUkRFZjh4Wmo2UGNEWjdKWTVSWTRtOVdnY0JOTG56eTRNeGNMMEtu?=
 =?utf-8?B?aVNXeTI1UUc2NkpleW5UTUhrN3dkamtZQmhEbjJIcGVmRmpFdmZraVJOcUtq?=
 =?utf-8?B?NzkwTXBSV05CV1BGTHZTVWZ5YlVGbEdFY2VPaTh6VzFSYldTUlBReXU5Q29R?=
 =?utf-8?B?RmFpRnU0aXI1TklDSTBvMEZSaDYrQ08rWUo4YUMxbGNWcjhxVFEwbEJOZFN2?=
 =?utf-8?B?N3N3WEQwelZYc21DU0E2dVVaTHpaMXhNbTNsc1ovRURLSnF1OFpQTzRDbGE5?=
 =?utf-8?B?ajdudXZSaVBZclcvZlVaV2pWRlUyV1BkbDQwNVNBNHh6YXRXVzhabW5PNHlZ?=
 =?utf-8?B?ZVF2SW5BTWswL0h1WFhFbU1mWnNvU2RIYnJlQTVxZlRhT0RJY2pNSEYrMlov?=
 =?utf-8?B?V3VKdThRd2l1c2Fqd0xNWS92K1c4RjlkNlV5bHJVYnB5THlPSWtnOG9ROVV5?=
 =?utf-8?B?NkJlQWlGSnBqaDlrVVpCQ3FjOXEyQnJKQ3gyV1o3YW10dm9jcDJIdk5FYTY0?=
 =?utf-8?B?bSt4MTc5Y29HcHI3K1U5K1FwYjRNamlXRlVkSTU2SGxGZ25Rc1hMMElacER4?=
 =?utf-8?B?bmU5czFnU2x1bCtyVW1KMkJFNFdVc3JoQmhjOGZtSTJyY1c5QWFQMGN4ZFIw?=
 =?utf-8?B?UU5TaUtTWmV6U3N3VkhEWWVvZTYvanVaV1plM3NXLzFSOC9qYytINjhEemJP?=
 =?utf-8?B?WVNoeUIzMWh3aGVCVHoxalROZDluRTEvZmtRL3FzMHhneW82bVZiVVdzTisv?=
 =?utf-8?B?ZHBManJqQXprRVJHbkl6U2dnT3RCRWJvVGthUldIMkZ4czRqU0lOOEQzTGI5?=
 =?utf-8?B?YnFRd3VZdDV4OXdNR3NXelFFdEVoTHJqQnNqN09mZkF2MFBBWmg5VEFFUUZt?=
 =?utf-8?B?UEo2Z2FlWnVRQ250dEVKVmFNU1QvOTBjQmh5dVFwaFljWWZTU20va1BERzkr?=
 =?utf-8?B?bUZBRVUrUUtMOXhiaGJkeWRFdnhQMWdNOWJoSUxBNUFpK1lka1VvZ3FuUUFL?=
 =?utf-8?Q?YWem7KkdEio=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajRJTm1teEoyTVQ5NEF6R1BDK1Q1Mk41UTVhcys1ZGppOEI4K3BuelArc1Zq?=
 =?utf-8?B?cHRvQW92Z0Fsb1dpSWREb052NEJZYUloUzV2UndCY00vRVdJWEl6ekNYcHc4?=
 =?utf-8?B?dXBnTURCV1VvRnlKK25tMlBXTTVHMVU0aDBlamxhbVM4TzRSeGZ4TlVtQTF2?=
 =?utf-8?B?V0xpTFVJa3dZK2kzN0VWSi9wb0t4NUZab3ZSTlFzWUxrZEtsUityTUdGNWcy?=
 =?utf-8?B?SlZud2RnaEJtVEdDa1I1ZVV0cVZOMVZtSWVPakMzbE44ZHNCZUc1UTlGVG9q?=
 =?utf-8?B?N0JGbGhyRUZrUVNhS0cxTHFPLzdwdXdQWWRsMkpQWEd1Q0JVVzBvZXJyeklY?=
 =?utf-8?B?WThVa2dZL24vN1dlTTk2aU05d3VSZFFVcnNQeHBJRDNVQ0JLemh3QWZwV1RH?=
 =?utf-8?B?cEJVSHJvTHphMmR1T2V0c1hxU2Q3T3hPN0lxd2xJOG5MWVpyV0w1M05aOVhT?=
 =?utf-8?B?OHJMOWl5Q2JCMVVkbmk0RlUvdUFoNytxWlVZakloMHVpMEFveElsalZnSGdP?=
 =?utf-8?B?bVF3WGRneXpmb2JPc0tCR0YvcGdCTWVhb014N01nV1liQnZWc055cU5hQzVI?=
 =?utf-8?B?SjhpRWEwS3p6WEFRRFNjUENNb2RaWlhhamtPNGJpMG1lOWNxMVEybHBvSXZa?=
 =?utf-8?B?b1JhamIvQ3MxeDdSOVc1YTZuK1BjS3IyZFNVYzJWUGV0QmlGT1RIK3lhajJD?=
 =?utf-8?B?cjEvQktaSmVIREpONHh0bWMzYkdLQ1hVcGxieXNpczF3VGZYYStBMk9MZVVN?=
 =?utf-8?B?VzVYM3I1enJqSzcyUVFRWTZzOXZLOXkwVUJ2bmdEelA5MS9aQ3htcWVic3Vm?=
 =?utf-8?B?TkpDcVVBMnVwaXY0MFZmbTAxMUVnWlRhMnJLbTRZOC9BeTNmZXV2U25PRkw4?=
 =?utf-8?B?UDJIczQyd1p4VC9LS2R4RGVDUENmTEQ3QzlKdXpXV2hmT3FmaGFWQUpXUnJ5?=
 =?utf-8?B?UGEvQkFnUmNqampIS0FFTSs3YWhlYktSSEpnNlZaTmNIbCttZWNraVVteFU4?=
 =?utf-8?B?TDhERzEwQlNJVnBlbHVIMzFnaS9mSmI5cmNSd3RqTGE1cFRsS1pBU1J2TzBK?=
 =?utf-8?B?bDdjQXlQcUR1MTdBaisyTGxCWlBzVTJIU1liL0RIZ0VIbmlwZ25jMVQ0VGcz?=
 =?utf-8?B?bTdrYlBaemcrdWxEOFZ2dWJwRmRET09nRUpyQnhscUZBUzRQNC81SmdvKzZ6?=
 =?utf-8?B?TmtoamMyeGpWOTVUTDhGZkJ2c3ROVVVTa1V6UmxxcksrMGdhNGxLRFJBZFc1?=
 =?utf-8?B?bFN6aTROWDFFd0c0OFBDRTZEemxaVHdyRmlrdlFiaDc2Nkl0S3RQblhwNDQw?=
 =?utf-8?B?VzlMZk9ENi8vcTdoVFRGc1c5NDlLeE1uMjRFZ3JLaVltSVI3TlYyNDdCV254?=
 =?utf-8?B?TlBFcStqZGhBOFI2MXFoa3dPRjFXY0FXNWNBRmhGNXVmNnRLVkk3TzYzdmJJ?=
 =?utf-8?B?Z3BYNXpjeSs4RFQxZ2F5cXF5QzdNTVdnbFhIWDlUTk8reTg5eEhBaGdkRGpN?=
 =?utf-8?B?YmR3STZFNnplUDFwMDcya0I5eHc1b3JDUTF4T2Z5di92S1hBTE1sUDJadlhG?=
 =?utf-8?B?dmdXZWFuenkyaVBZUEl0RVR1aHBuVDFaWW81ckRGUCtOc2dSNEUxY1lVRytI?=
 =?utf-8?B?L2dGV1ZxZFFvOEF4K1ZyeEF4N1BhL3RKMDFOSWM2aytBZmwvSlhUT1IxQVVs?=
 =?utf-8?B?d3FJK2FJVk0wdUQ5ZVA1cEpqKzNQVWZTVnpHbGRPYjV4Q3k4SXFGaFVncEtl?=
 =?utf-8?B?WXN0bHhLZW0zNndUUjNGOEdkRllIMW53M1plenlDK1NXek93dWhYTUJDMmFP?=
 =?utf-8?B?Z3lLT3hTY1NPSGU4eTk0Ky9BZWtOU1hkWDZ5RXBpUUx0b0s5d3hucGhNaDhh?=
 =?utf-8?B?NGNObkJncGlwYjhRWkxqTlBMbzlZRGN5UUE1RnFmVGlXZE1pVW11eGMra0xC?=
 =?utf-8?B?ZUxQckoyTHcxWWxkZlh2YkdFeHZ5UVVONEE4QklrNUlqUDJINHBTNkZXUVVx?=
 =?utf-8?B?L1ltWU1GUmhHWEtGWVRBckNtcmdXK1BxVXV0K3VyelZMdzNCZ290S1pxTGFO?=
 =?utf-8?B?cW5HNE02akFXSnplZjRvem5hMkVPbE5YMGNsU1liK3dpNkZWMFhCNG81QkJH?=
 =?utf-8?B?MmRzSmJoSXVLNFVXU29JK1BzOFExRVNmL0hWOTQ3eno4S3ZnOStOS29Cbk8w?=
 =?utf-8?B?M3dGSDRjSjN1OE1SKytqOFNFQ05adXFCSi82YVdRbnN3RGM2QUNFcjE1RnBE?=
 =?utf-8?B?TUtDOStQdWlReEpwOGptdUVJcmpnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6222fc09-132f-497f-dbb0-08ddb96b5262
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:21:15.3886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4r8NrqTuoinITeFx05Omy/HqOQPuNTMfQPdoLPHMwOrj3amSqdz0iOahIC6UA0+fxbr3pj/gobYqBAmKcHb8jqMRRcVUVA46qFbe55D5mSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9492
X-Proofpoint-ORIG-GUID: JzQhw0twTINtZjsy5GEQY9TCT6PMH2-7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwOCBTYWx0ZWRfX9v+HmX6ih/yk
 tPJ2rPt5wiCvLQchOFJsvXEzjuFhq4wAhvFJ5JUEa56BFz0EWD/x2i+iMkQX0Eg4RAAJ2127Vir
 a5oE8FGRs1+sqsrVVGTHEhba+2DVk4PiYpFqZcu3NMahX77c2BKemoyaWDHlYmY+J1vwaloowWn
 2ZSJaaWWq/LHl0NKnmc++xtAYYKnTljQB7C2r7swQo7c1Gi1uD9or3TgK7y1ovK26w9r476eaUB
 RQn90me0hjHTgWf/O4P2rHud2Om6Vd2F/gJs/NcV/f7N6InEM8125flFVGaeklSeNdXZOE63oSl
 ow1WezGWp+nxi0QjPFEwV6VaYeNmwq+tyOm+s1bePfspxSxppRrPRB21HLHB/QfAJC4sqDICYh6
 YKBqQ1+j/Y67BG/y6yLlciq8dORDdLPESt878ZZZ5aPUyCx1MP0hKQuqAHBmSxCMEhjZkI2n
X-Proofpoint-GUID: JzQhw0twTINtZjsy5GEQY9TCT6PMH2-7
X-Authority-Analysis: v=2.4 cv=DJ+P4zNb c=1 sm=1 tr=0 ts=6865324e cx=c_pps
 a=F0+d6aSsnXJg5hNSnXykjw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=Y8chGRQXWInmmOxqWc0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 02/07/2025 13:07, Steven Sistare wrote:

> On 7/2/2025 7:59 AM, Mark Cave-Ayland wrote:
>> As the full cpr implementation is yet to be merged upstream, do not 
>> register
>> the vfio-user container with cpr. Full vfio-user support for cpr can be
>> merged later as a follow-up series.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> This is fine, or I could drop my pending patch "vfio/container: delete 
> old cpr register".
> Thus the vfio-user container would be registered for cpr-reboot mode, 
> which is fine
> at this time.

Have you got a pointer to a commit showing how the registration should 
be done without using the old register/unregister functions? We are 
certainly interested in looking at cpr here at Nutanix, but since any 
work is in its early stages I don't think it matters too much if the old 
functions were to disappear.


ATB,

Mark.


