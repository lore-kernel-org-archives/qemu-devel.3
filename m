Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB480C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeNQ-0002db-JP; Fri, 03 Jul 2026 09:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNH-0002Zd-EQ; Fri, 03 Jul 2026 09:56:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNF-0006eB-Ji; Fri, 03 Jul 2026 09:56:10 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rL0C1943866; Fri, 3 Jul 2026 06:55:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=cISOEwA4LTj+uDMKKMFD6tOmHI6nZi8hJIYZlb3NX
 8Y=; b=iQG9QTBOpSiBeVD527vrnb7yIShTmlL1B7+clbvYdKuK1C+jUEgIGDRH0
 ednmxOOfRp8shwryl8DSDh7zu3M8NR3ZQ+A+3k9V09he4DsT6Bn4M67sXONlUPOq
 XjXQL9OJFwZXH8ZMe3Y7bBnnej+XTiPmkxXx3OVGXYKoJ6cfkEow4uQu6ev3GfmX
 tLbkykQCAycZr9BkDYGP0NuWAwpOAB9I1+eboggDkT/WS53BKyyJrQtpX9MWStr9
 yF+rJSRfrK7SDOUIVWeYE+FNIuzB59D79whi4Uyyi0skkxGPpSRjltBlKn344w+g
 rlCewGxX4urWdEBgMZo2rhMOjR2Tg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020133.outbound.protection.outlook.com [52.101.61.133])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f60bn9njc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho/hYN6njpXFbOalik72FSxMEsPYYgWtDVb0vOBNQXNiXXtRraHkMWErIfTfHsTndifWZyM2Z19I1kMVW+9JxLAEJPj4LyCmTWnNimShXKNWMt0In1+X9NlWIT+kzhNvXaMzbB2DHfwu6kjzQX1mm6L2YtTkAVZXnBmKri642EkIfIYiv2UqveT3W3buwlCW/guh8R20jfW9xde/skKQYL7wp6FhiQFCjxgDHYSMLx1JGt68nTCBWEO56hIhGb4339lqsPXd9a8B865yrIq/J2ap4d8N/cZboiTGgSdF7k9njm+4p7rLZ2hGE9eaBD6NFMB9KwABqe+S2Rq1mYRL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cISOEwA4LTj+uDMKKMFD6tOmHI6nZi8hJIYZlb3NX8Y=;
 b=VMmTY5539Ss4TEwSLEGm+YgNYWf02o3jexFOntFu9rdbct+nFFXEoOic3LpwtSBDjfUWKl/nyBjGt/LBh1pV9P7k2ywiw4ka8naTUmr/J4F3jdj589PpO11ePdSNKpz1mkBdGo0JPENzm0Dd44nmtcfmwdJinjmW7VaX5ygzXDp0wlFFvSWNueTFGJK7Ak3iK/I7D95mGa2hIg/D5fzUC1d1mXHQoJcc93n506WiM0QGmZhCjSEgghzl5YU//VRynbIfM/cCF1/ArUTL7lFPCjPbM1YYFXwATBhM3TVOlc8Zul4GvIW6K998TyT6D5wKZTv+afC/gAcHajWS1TrleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cISOEwA4LTj+uDMKKMFD6tOmHI6nZi8hJIYZlb3NX8Y=;
 b=iDGi2IO1QCC8bwMa5FAxUGa0miJa4MeCsIgXbynvOodc6WO5TjcjkcfmJt3O5GsP7BGHGOKetF4OhJOVNK2VR0q0W1mT4+3yUdktjI3V87ixUXpBqd7PrdUmqQMx0rxpatS7mfu/3zACnYK6iH46bReVH7iHNfmgWhH4j7ZucboTXLC+yDvnNsd6ioCUUfh1YXoX6/XGK+H3tOpFTQif0iew8vxsj9sNvu2pspbNVXLleEXtjmzi+6isMkzrAGD3pEGavlMVD118C1flxvO586HRz4PRRGIFA2yNKXu2P/4hEMVzq59s2YwV+8WaSIAxcUFFCmlnsg6DFXjAQ+0/tw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY5PR02MB9016.namprd02.prod.outlook.com (2603:10b6:930:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 13:55:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:57 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 12/12] hw/acpi/piix4.c: convert object props in PIIX4_PM to
 class props
Date: Fri,  3 Jul 2026 14:53:14 +0100
Message-ID: <20260703135512.3213964-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0318.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 200ef6e3-8ae4-4639-874e-08ded90ace5c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: lUnNdV0NjtV5LBmc6nYib+MLjPgnug1A49GabmKO2wD2GAP6DRnO0Fs0rYGSzxQrOo7glcFBjnYuUGDuCG/eeQVXS6WzSWp/y1sk3k5riSaT8z+PGuzQ2sv3CAFZwF8nUlv5wNSghYWRWGQ/CLN2Y8ghUXjQ5nixftIdocIeN+fksntem5sN+AOPad+bRp41AdkYQEnAHgikhXU5dsLOFBzDcAHZqONR5ti88doxz+KEAFWvboCQHCSnsFVvKlyrPd5X3VY+6zpXkk1L4QKkBMzUzuo+DpyQAlml5Z/sG/JMUNC1b/iHSUNBliKxtiKloB0LFbg2Evrn4BylktABh5uJPoJi/rD4/73VV5K1n+51PAXZvJaDyhDDaCqykp6DiH4Fm9xwXl2BooWBvmYvbGkEUZ0f4K9hS3eTDQKyiXWaLEdzX+dAqcUxOv2IIBFOBVG0CRql3klJdrDVmw2d+0lhEIBTRYeLfV91LBsHTfpaBvp72ROAytSWJAgiAHxxXRReIXbYHSvSPbVHR5H5ZinyOdRUULZLOFaEVnFhYTjD1pkClGoeYprcpT1UCOjnYXtUx7v3Gu+TCGFdUhMurBYdJFGULv013lMkzNK/L75M19uyAQPkLtMvAICz3x4n8W46JIfPxVg24FX3USQoPq2yUEL0KhxDPGXJR4tgdAPK7ErCcVqpzcuA9Yj4jn7KkPHdQb58ESCdCtfj0NRYGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HQBgr6gYKnTN4QlAGj+23ce8wHUvGyQTxfSdU45eHPH1vOKPm9Et47alMlmG?=
 =?us-ascii?Q?HVuyiP0B+q4/qcblTywiHdaGhOTQBpLH2HmgafUvE1oEaXf9K8/i/R0vtaO5?=
 =?us-ascii?Q?QD8nGpp703SbpU7Gvs59+fDtYFGbw1FFdPuUEgc5ssf/BQ6dioB7+009EDTA?=
 =?us-ascii?Q?iZqeQIkb4FB+tSbsoZwgMOqU79ruBoFWUsLY7rs8DhyZ7d1SPkKNtLT8m/8t?=
 =?us-ascii?Q?6aRMoFxbliJGlWFsOKFPmsE70Gi0cfOB60IjlEOst10KvOwKkUuuQmh3bY8m?=
 =?us-ascii?Q?FFKo+JyIANVP//o1Q+Du1wnvuSSCTo5h0QsraaK2L0sdTvM1TCkZyUcdkpLF?=
 =?us-ascii?Q?Sj3FQC+7qDfnMERBNt5MQJz85UgwBqanABuDr17rs7GYQn+FPVgSKy1tfN6t?=
 =?us-ascii?Q?BJNAA+vRexdV3F3RMOHRRMy9nL4oY0hbRKVb8ggkB9VHHBkIIJSGYjxpKo7I?=
 =?us-ascii?Q?vfd1HAXOx0/IH7Dj9KIiyOb+PECrxEBsnUdmypKrS6NmIISgtdL+IX5Yt0AT?=
 =?us-ascii?Q?/GThlBBpIWcfllCB4fr3V/bzoewdM6sp7Ng0vHyMGTY1aB0iEqQVYlT0anj3?=
 =?us-ascii?Q?4zBu6agdvjm2RfYXse6lGdcNYbCLGcaPAtcDlJVhdYItieUXXKfAXu2Ukcn9?=
 =?us-ascii?Q?UUIznJ4MKUrYBtgpz9+FLho/GqFZsfgVXMZyC2ZebCBZTCVoNDlSW/IbnDq2?=
 =?us-ascii?Q?XuX9c5nE9xmucv2A5pY8kTa7f6/SlISkEHnpuF6dg/S4PwmQwBG4Oc7ZeagF?=
 =?us-ascii?Q?i2AL4cL8IalCkjOT1Ebypcg9PvGOmSGjnuERha8QuNvO2J04fbEgRqpbL7CR?=
 =?us-ascii?Q?WItVaZopjBm+omouaTEQ1rDPfoVs7pfD0di1iOajLXx3g7310gF1FPBTebBM?=
 =?us-ascii?Q?zLlMi0TwDvxHUcPymXpKrZVDhrneYzB3Oa8ByW1T662i4BuYe2mEiH2MaUoa?=
 =?us-ascii?Q?usAVkGnps2ySbdylyuKS1Tb/APcMKExWAPOgGoQ3gp/XIHkaU+SlQNvVdUHI?=
 =?us-ascii?Q?f7ARSz0jsoZIoeU43kw7plu49GhCVqiCTTnYoLsvsi34DcpeZQ8rAsqKoBNJ?=
 =?us-ascii?Q?ob7y1qXQ6Wq1GNuGb5B8vwB2NL9wOo6HoZQnOpHSajjBpa2afWJf5/2CL8rf?=
 =?us-ascii?Q?zbzGapYMecAq53XH1rS0uNo4WGQ/MLISbGh3KNNiHQKBFNB8sqJYf2KJKcv3?=
 =?us-ascii?Q?40VLop8QqnI24SgYksgchfD4R/pwaZnQgnkQDiDEId7HfD3o7kuC02f+9Jgl?=
 =?us-ascii?Q?QpD2vJg/6j1mEA8/ta8myXjsC8YXqWZo/LfeNqGNZ9c96PvX6iS05iDQhIEf?=
 =?us-ascii?Q?6osf0lRmCe6kLHoakCtej7zSqPgCkTWbty/KgEEOGSZ/gm5ygDLbOazFujBO?=
 =?us-ascii?Q?twYU+ozxxNm818zdsZpOlRetNlj8Nja7GVFD7T/P+ZdDspLLwnDDk34nNv3j?=
 =?us-ascii?Q?XohQ4VtB07A8x7tapzocgcc/hfjViO9ffRLzFLMCA2Ma4OrgqqWfy+e3F6nD?=
 =?us-ascii?Q?Mvc2If5fbRUgyWMpu3hOyG1gUO4ytnniYuWwtADkU1wWJPcTfryi0E7zfqT0?=
 =?us-ascii?Q?gX4BoZpMbl2edObKgHWL5QN4nGscpfn4WsIjRnKH/r3F16vypFRTQT/LvsWZ?=
 =?us-ascii?Q?pmcDIeW0wXYVJe87bMMMgANIxNiHJjsIFtNjOLEKgqMWb7z4LEnhMxK4FnrV?=
 =?us-ascii?Q?y6dm2oTpf0Ng9ldGDJcdWJ3KLultPGuyuilbJkvbyjgADqs7kxZqUZp7Tne0?=
 =?us-ascii?Q?qGbSd9FjvJzeE9PDLWMFWjsL0RWjXeM=3D?=
X-Exchange-RoutingPolicyChecked: MU+/QYOdZkjJ/eBJU7Rk5Gg7KbyqUBH5y+LdT1LcQkxMI7dngBqbwJDExe/F1ULSWFoupzMhUDgqPw1I9Sp8NZkseQpCEAfg9Z85ooJ07Ue5UJcbUC4dgSfqK+FJQ2ae6XRUsYTPIZCLaQwTsDVjuG+kSMNX/qGxGei5HeIeKpcUWpx7w8oT92aj6q2vUKiNbe9Gf3NiHpy9RQtRVPjj3caiNMkGm03v0WAoQrkXt55aovYnmrBztNC6EDHfrwVV/30G7ERRCJ2ujWvs2z8NOMaFSfWFz2U69pELC4ud6pTDj+9A2UCiRx/3lLNMy88i6GyfBAuqr8dmHNXKf7A0AQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200ef6e3-8ae4-4639-874e-08ded90ace5c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:57.0052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4g3lkp16tvJbtuOXIvd99K2cnBkmSbHx4YRBmhWyDtbRLnp50PQV2FKGvVktIOhuQ5jUACic7ETIImdIoiVRTqYe4X45BNfkRa+c/dRJlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9016
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX/NoE6zPTlR1n
 LH6U+VS7pCMoAqrDEX9jXCybhiEBFMjRPfMPby+apibow960BeeGDPlwkGBl1A4uzcilMxpYIDf
 XuahSPG8uBcizCaktze1dLh4ThNDyLw=
X-Proofpoint-GUID: _qX7YCZxPbIpWG4xu_fO-kleBF4sEDqb
X-Proofpoint-ORIG-GUID: _qX7YCZxPbIpWG4xu_fO-kleBF4sEDqb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXy76eX2/wKuNt
 wgmEsbD0tRabALCmoOCKxHIVZ6A5kamHL8Qn2J7lQUiG7mWfYsupgKpJCnZNQbhlfdmrlq8wxlO
 6JFW2J7S7UqhU9jdpmQA2hf3ds/3mIuUecwUbdjq2YV3xgaZg+lkd8IQK7haywxLL6OcUh3Vkv9
 ek5c/a4k5K9MNZAvpLYA5arZtgt6Nx2cool8DhGn8rnjaouogKxa8x6Yiiis7f6siYP01dxHjTO
 X3IOD2Llxfmlux8QWt5vKb9CJNGlGx9XGkhX2CKWC6ESO4nMYKO+4eMznecCm17NcNjM7PraIFj
 J1iqKxsQhdgEDvHPeOlohmftTP/vMLsh95N7HIDOHu4PwF84lETzgF1y1UG4VMepD2wBwjzaYkM
 6C0hwUW2FAuR2rbaigGRyvY/HXZOqryQADgQVz6d9OpXkU4/lk/X+xDudbGr26SomdoNBp0cdqf
 ObHykmBwjpw2qf4dJwg==
X-Authority-Analysis: v=2.4 cv=E/v9Y6dl c=1 sm=1 tr=0 ts=6a47bf6e cx=c_pps
 a=3l++41Tsbfu3Vy6U+n14cA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=B7CNqg7Ooo26QmkFXu8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/acpi/piix4.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1d209ac96d..52bd61667f 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -405,7 +405,7 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
         (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
 }
 
-static void piix4_pm_add_properties(PIIX4PMState *s)
+static void piix4_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ACPI_DISABLE;
@@ -413,18 +413,30 @@ static void piix4_pm_add_properties(PIIX4PMState *s)
     static const uint32_t gpe0_blk_len = GPE_LEN;
     static const uint16_t sci_int = 9;
 
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
-                                  &gpe0_blk, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
-                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
-                                  &sci_int, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                  &s->io_base, OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(oc,
+                                               ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                               &acpi_enable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(oc,
+                                               ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                               &acpi_disable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK,
+                                                &gpe0_blk,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK_LEN,
+                                                &gpe0_blk_len,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint16_ptr(oc,
+                                                ACPI_PM_PROP_SCI_INT,
+                                                &sci_int,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc,
+                                         ACPI_PM_PROP_PM_IO_BASE,
+                                         offsetof(PIIX4PMState, io_base),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -480,8 +492,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
 
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-
-    piix4_pm_add_properties(s);
 }
 
 static void piix4_pm_init(Object *obj)
@@ -616,6 +626,8 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
                                          offsetof(PIIX4PMState,
                                                   acpi_pci_hotplug.io_len),
                                          OBJ_PROP_FLAG_READ);
+
+    piix4_pm_add_class_properties(klass);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


