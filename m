Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EF9C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mAo-00083o-13; Wed, 02 Sep 2026 10:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAn-0007zq-7z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAl-0002CW-6j
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:44 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CXVon1205835; Wed, 2 Sep 2026 07:42:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MEcPr37hL9xpTAk7gwA+e0zb629UKWWsoMf10HFS5
 lI=; b=2KXfPtJyIfIUeXwd/0GIyrfVEm1JuCddAJ7MYBXT7EOtqDm2pdlVowAfg
 cqywXo8tC71r0MZjif4Hpl7YzjSQdOnHSwrb42+8Q60LInX0PRjBH0OLPNee5wY3
 Pf0bKc5IJT7Cy01S02mhFYN7WGFEg+ts/4WEijtprLq0vD4c+0ldhB0D2yLtRq0f
 cngRZMdZfUw8sPxZJjwpGULJSMzG2y0FX2M1OVCKFAkbPtdEEL+NAMTjO26ByBUR
 EtvWuR0Tcsi25pX2ChGQYB1pAGOLkxDaooWM9SJ2o7lLCRM6Sza5B9Sy8ZDEXZyc
 /IhOoLdn0OTYlq7YhLSrf5Szd2Nvw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023138.outbound.protection.outlook.com
 [40.93.201.138])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ge100u3xs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 07:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBjK2FV5iJXt27k/kOhq19uI9CIGbUdTp5MUUDxEvw92I3PVWnV+ZUkq9Ox3Jf80vzhfbrKvFYRUpHxDrddlE3+qOJdi7Km/op06iI18icYOaMl1H68UGq9JpUj1zHuyDvNb/IlmHPimwC/Okhdkyv1WJPOLCAB8V7iBtVTAuA9inyReZljTtYx1EzcefYwe8/2ugmv/sqj9SOQ1Ca/q/KCpYf75xrX6n/t66fmdT/OxTV9KTWrlxLgeXfuy+J2ToCXyxgfjsS6vKMS2hHgA8vHSnIMG7bthdP2J9WYTiDRFiYZVraDDt8mrJsOMme2VY+JzlMGEQIE55VgnxtsDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEcPr37hL9xpTAk7gwA+e0zb629UKWWsoMf10HFS5lI=;
 b=Psg9gCREbbxh8rgH1UgVMwE/wJRDPVsyiyuEKIns9+SDIJndau8ozkvCHIAmu80NFb8S7NiHz5a1//eOBiHZAYZO6M0rSDCQeM8XrYlZ+WeSFj2u0NytAeA8Se45n12DwUuI6JEKnEA2UL4YliL1WhLB753pccJXuAlf5cboqjV9QhXt2S9g+PExlJMQo32KO6Uh8bNymtyTpJzOSIkLGrNM9wurZHo3aSbW+rMOCg//Hzx1GzKikVEjv3Kv4JiifqpbpW4sjthAWnz0egrIKvWfymklRTAfv7/g1LYYYo+1dV+xVt0C6+Xj8ICUXVWgVlruyirbu5kIR8gis33gTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEcPr37hL9xpTAk7gwA+e0zb629UKWWsoMf10HFS5lI=;
 b=J7/uY5QsAVKrfAGEI0IEQzerKI6ZchsaDUebJP5atTjDGxt+owzWWdGide2p8ddFOmWoQ12J+JPEAO5YZRoL2CeFxyQnRRRaFfDxpf3+RqW8YOLkEwz7zzZzGRs9mrLeF5a6LJ+RdvoPEXGUP7xzi+Q/BZb5yVfv+59KPFcflJAXFPj68rsBfQLv5als4J7Lnljt6/AGayBPimTo1THjR4EKWi0PqeEdLQPLwEmSg13r5HBiuHQPG1sW4p0I2eWzORWKQGaRrce6UlzXgPpE4uP26diRDf3fCgML832ab6pX4yBE2L1SnltOtqtALWkFOGlYrWZSo/fZb5CkrbyM8Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6978.namprd02.prod.outlook.com (2603:10b6:a03:23f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:42:39 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:42:39 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 7/8] hw/i386/pc_sysfw.c: convert pflash0 and pflash1 object
 props to class props
Date: Wed,  2 Sep 2026 15:40:54 +0100
Message-ID: <20260902144207.2553037-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:a03:255::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f42c15c-333a-427e-0ee9-08df09006fbe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: g8qw6/StdHPNntUGT9KrCMKULQjmYKoM44ssWOmdt4IrbTC5D4UMivbud1ydLNMFkxagjlbOnlBhwNgexuq1ZyLddyW+kywWGfuLCAb7e5qBYNN/buOM7GDc6G5KLn6Vue9N9P5VTB2GV/i7XEILNnVlCw0X9a8o6R6wEH31E0EbD3KS45PVjqYFdtVRI8JXDCRvOkrd2jYjbDL1KphX04jhi5kp8r74dooys5dYUGGUZp/Abt28JBcplEa8wDUERCD7klemitfcKBxAMEml2n+aBiRy6oeX8MEyYEOcpgag4jE2QCBOUWM7si2R/FK+Dvq0pFLbSTm/6vnVgKx5FwkvP60bVwxPoirWqz/3UwBOfUiVKQ6EzQSBQgOwTDwtEcZmV6cNHjD3yMAVzqLRCpPRW2LJ4plzImgw30w/BkemLCJUk4CPjb+/ReF1VaI+jxXA9xq6+AUbgXO+4KIwGnRhuSjhmQF59ve3rDGSiGchxOMB277/yrmKIdjYZiCgNyYDJ1LojZY1Z0VP8ZWmOYZKHS+gwpdTCZm5rzzhR3FY7yJv6q+S75oW/eywRUN/EjGjQOiEeidtM/uqR9VUAWnJxKkp5S2YoePzT7aRA/pafW3wPCc7tchOJsyqPi3F1qkm0vEGk8FszcasK1MxdCKeXvBrlK8NSxt6VvyIW6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWJOZ0RCQkRwSmRGZ1dlaHExRCtocENadm5TdWs4K21LaHY3ejhrVUtSNDMv?=
 =?utf-8?B?Uk5kaHdVb0d1TlVDL0ZiRVpab1FRUDNnQkwrRUV0b25GNmhMMkVZRWJpZWla?=
 =?utf-8?B?bVdSYXF0VUdrZURHdTk4OXNDYnQzZVJ5YldFV2pJMnhqZE95REpOd2dLOThi?=
 =?utf-8?B?clkyYjZqNTJLaWNBWkwvL255dFJqblZjQk5tL3pMYnlMZ29WNnB3emFuR3p6?=
 =?utf-8?B?c0JuY1d2UWVTSno2ZWdSQXFtNGt2Q1Y0WTRxazV5R3NRcFF5VnhJWmJLTmlz?=
 =?utf-8?B?V1NjS1lGblAzeHFFS2dEdW5SVHlGeCs1QkUwYy9WODNGVWR3cTBXa2lkMHNt?=
 =?utf-8?B?ODZQd3FpRGJNNTFBcFkyYmZxOXpPNjRnMk94UTVsdmRickhmejExWVR3YStu?=
 =?utf-8?B?bUF6ZHF3cE8xYkQ5OWRHcndNWWY0ajhZOFRta1RjMnIvcGJDMGwyUkI0bGs3?=
 =?utf-8?B?NkhWaVV4UXZDa0VpUy81c1Yvanh3QjFjUTR6NlVIb2k5QXV1YWgwOEpSTkRE?=
 =?utf-8?B?NHI4WUNVYW1JQ3dmNGR0UXhGd1JQNXIwZkNNYXVtVHFyaXBVd3JCdERoR05p?=
 =?utf-8?B?MVRSbEprNkZPVzRrMjFWK0xyenNMcjRTUXRhcmJXM0V1bGt2bFJuZjE1a2Vu?=
 =?utf-8?B?c2gxZDZ6dnZXb1NzcTJ5WGxhdlA1OFBxeUVnS1p6UDZXM0g4RVBHcjBpaHhX?=
 =?utf-8?B?WkZSejZMa0tHcjQ5M2FVNFJuVVZLbFFGOWFlS21pS1dnblY1TGlQdGgwc3JK?=
 =?utf-8?B?cFJzWk5acGZ6cnVUbUYzenBZNGFBaEl2d05GcVE4T1NRb2ZyRFRXRjJSSWJW?=
 =?utf-8?B?aHlNRE5FT1lmVW5vSWNaa2ZYRTFENnNiM2RNVjZ0VmtNaXJWUXFLaEdqVFVX?=
 =?utf-8?B?NjNQSFN5Y2tnVHVqOVY3ekdrUVBsWlNBZEFLN1hUVmVxUkE3ai9qMUFRQitI?=
 =?utf-8?B?R3JBTU9CWVZRcVlDajhUQjU0WXJvWTcyK1ZoZnpzMDhkeldXMnpqN1lONksv?=
 =?utf-8?B?bU5icHkxalNub2FwWUpMYjhVRno3VjlNRkFqdUpPUkNUMDVKYjI1YXNpRjBz?=
 =?utf-8?B?YmQrMDJYekpFeWhsRVIyVFdnaWpPV2dsWkdOaXluZ2NGSHdZQVJ6dDJHdlR5?=
 =?utf-8?B?VGxyNjNRL2hMZFRxa1NlaFZaamhYUGRYeTM0dnp4SWlCMUVzYmt2cVViNjlH?=
 =?utf-8?B?TkxoNzExSjBYZnc0NldGS3IzTW5mczdjVFhLbXhLTDkxZ21CbFZhb3pvYlF2?=
 =?utf-8?B?K25DMGM1S2t6UEVGR0dXSXZjR1V3Ukw1NUxkNXRsL0tPdUp2eW9SdmdWWlhO?=
 =?utf-8?B?RDNuZWRVd2RsWVhvbkEvQ1NubFBoMzBTQlNjelZUTFVReWVXVjh2blc0ZE9L?=
 =?utf-8?B?Z0JPQkZ2dmpDWm5UVUc3S1U2VVFURXFTeXNCQWd3WEZJelZoRGVqYkRlVnVW?=
 =?utf-8?B?YXpVNTE0QkowSWVpY2ZrUjJSNzZKSys5UkNlMytSdXVlWXFMajB6OHdWQUU2?=
 =?utf-8?B?RS9uaDNLMHBiditDcEt0WllxemtzeVBTWDM5T1VCa2VPQktnWDZEbFFkNlE0?=
 =?utf-8?B?TmFubUJhYml3RU50dWJSWHNwTVcrS3F6V2tCRjRWMGY4QjBjcDhuUEUvdFRm?=
 =?utf-8?B?WjZBdmt6OHNvZ1JoSkJSaERwT0lQQXE0Q1BnYldyMjJDT2s1R2k2cnFwYzVz?=
 =?utf-8?B?ZVBDV09PQm01ZzgvWmhMZkNmSU41WmxUV3hxWmtVS0pQRWU1dnIzYUMvWTJs?=
 =?utf-8?B?WmhQRG9IVnhnQ1FZdWduZWtiV0FrVkw1VjB0OGsydkpnVVdRbmRXSmUwVzBs?=
 =?utf-8?B?NlNSWW1tYTRwc3VlYTI4Tk1qeUpWWFVBdFdlU3A4eW92ZnRrQndBMEJLZnYr?=
 =?utf-8?B?L3hCdHVRekwwYlMvc0xYcHUwNnJTM1p0U3huU2Nxb2kvVVBzY21EMjBWQkxp?=
 =?utf-8?B?TzFVbUg4RnVaeHVwL2ZxSDdGd1FPVnByd2lwQWl3elZuUFhIUjJmR2I3aC93?=
 =?utf-8?B?U3plYXBzNUhNRjRBckVHNXpaOU9neVFTWXR4RzkyVVYrSTJOVVBTS1lzUjFL?=
 =?utf-8?B?OVh1Q0laUmdkRDI3TUI4Zzltc2JZTkFWaEh6WkRDOEkzYSszZDZlMUhad3F2?=
 =?utf-8?B?blBNb0dSM2FablNZZzl6SWJqaS92RkJla1RpM3g3NVRIMjVNREttck85c1Ur?=
 =?utf-8?B?aHNsSGpNTHZ1dUgvbDkxa0d0N2tILzZDNmFKb1FxUy9FTUkycnZTRFBEbk1X?=
 =?utf-8?B?SG52NnVrcS9LaC9OS3BHdXFheFdrMVVtMWIzZTNkc096OGliL3ZCZ3JaZ0pn?=
 =?utf-8?B?REw5MWZ4MU8wSnpGTGpzYi9xL20xbE9jeXB0N20rZldyWWlES0NVdk1BM0FU?=
 =?utf-8?Q?txuWmqdgJ4CU4ZD4=3D?=
X-Exchange-RoutingPolicyChecked: k7iYWuCvByNBvRBpRQ5450KrZ4TSnoqpvX34h9LJKrUrEX94SG4S+jkyRapb+PLN8uUseQOyQXYhfNjPI207SA75XWQTT1oP+xUf9L4cZEoKmpFUkoZ4tCmnVSNTgk3GW0l+qCGFNise66Heffi7bvLRXn905tYN29nZWxLksBahbT/3yUNROTMa4j6JOyOwyOla/trDza7iYx1aWnmV+iB+Lt0bPfFUGSiiuYrdyRjs2RZT1l1ogY6HXiPlzP+YqhW5i2NxKaFP62o0RCcnTVXxK7VzqIgruJsaSRzlo9Vvgu2xG5Xq6a+BD5Hkb+qPVwkagqDGw6sco8jTaFlcaw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f42c15c-333a-427e-0ee9-08df09006fbe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:42:39.1501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxhJBusayY+U3Ds8WjEzljQYypdI8tgyx4OKIS5jZUJsAYn4k5AE3ke0k05mwq3GSYmDN22dmPctk7aJqOs+K94dbgkyBNQqOIsGhTXb0s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6978
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX8B5RO1GFEqXH
 PaqoL26aHzBs3aEVkc++35uUpTK4vwRwMD8mnL/pW9qbgY20q5NTFOelICxQqOYkuWmJU4i8iBj
 AwNN7kF5s63FFv7YZEdSUUkhEyzlDck=
X-Authority-Analysis: v=2.4 cv=JZuMa0KV c=1 sm=1 tr=0 ts=6a9835e0 cx=c_pps
 a=S0nsQJN0x0NZxitFF6bqdA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=8Hp0nKSQPNhna13KrZwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gNe2tsGkfiZqDuBNJ82iT8c426dwl4VW
X-Proofpoint-ORIG-GUID: gNe2tsGkfiZqDuBNJ82iT8c426dwl4VW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfXwNPZdfJV0b6c
 pOS3mXPNGWd20jFoaLSiKzi9lOQd7EhO3a0uH8IfBMxhnykf0QgMfj5FCj/BxEClsJ5u8JyhEaM
 0vz1mPcqkiAXX2kVl7k8l2bk7w8PL4LK1ZiWtriMfQZaIHmsXW48kEEF9L6SsAdlKI4QmTrl5Aw
 vxoG9jUGXYkGzZ9DDUPb4xRBQCJoXmuqSGFV7VqEnvuGJ82ad6JLwPVf1VzPLe+j26cUwby2Cyl
 kSe8sNvb83qfM/o9JH/RigqnPO8xRyBtMwoV8NHCQK3cEUmXvk31Auo9XprCY3ViICi+k035cQE
 HB4wCRUYGD2BlDRiwV7gZ7smFHmO8RRkJebO/G8B061sJATwLyCmi9/i4lq+PTATR0WfSbY26G+
 XsOp3tXW6moqyHy9cNkYueSXNmsXYt8rXlbfrx0PrNfUp+lsbEJGgirTSpQz520XGu7PRnXb5o4
 /Jgbtp4LO4Jmofs7TJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Now that the pflash0 and pflash1 machine properties are class properties, if
they are unspecified then QOM returns an empty string as opposed to returning
a property not found error.

Before this patch:

$ ./build/qemu-system-x86_64 -M q35 -monitor stdio
QEMU 11.1.50 monitor - type 'help' for more information
(qemu) qom-get /machine pflash0
Error: Property 'pc-q35-11.1-machine.pflash0' not found

After this patch:

$ ./build/qemu-system-x86_64 -M q35 -monitor stdio
QEMU 11.1.50 monitor - type 'help' for more information
(qemu) qom-get /machine pflash0
""

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 8 ++++++++
 hw/i386/pc_sysfw.c   | 7 +------
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0b925ccd8f..8369263691 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -40,6 +40,8 @@ typedef struct PCMachineState {
 
     Object *alias_pcspk;
     Object *alias_rtc_time;
+    Object *alias_pflash0;
+    Object *alias_pflash1;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 876ebaadb8..ddb75a2ec0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1800,6 +1800,14 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                    offsetof(X86MachineState, acpi_dev),
                                    object_property_allow_set_link,
                                    OBJ_PROP_LINK_STRONG);
+    object_class_property_add_alias(oc, "pflash0",
+                                    offsetof(PCMachineState, alias_pflash0),
+                                    TYPE_PFLASH_CFI01,
+                                    "drive");
+    object_class_property_add_alias(oc, "pflash1",
+                                    offsetof(PCMachineState, alias_pflash1),
+                                    TYPE_PFLASH_CFI01,
+                                    "drive");
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1a41a5972b..441e777191 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -85,8 +85,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     qdev_prop_set_uint8(dev, "width", 1);
     qdev_prop_set_string(dev, "name", name);
     object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
-    object_property_add_alias(OBJECT(pcms), alias_prop_name,
-                              OBJECT(dev), "drive");
+    object_property_set_alias(OBJECT(pcms), alias_prop_name, OBJECT(dev));
     /*
      * The returned reference is tied to the child property and
      * will be removed with object_unparent.
@@ -109,16 +108,12 @@ void pc_system_flash_create(PCMachineState *pcms)
 
 void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
-    char *prop_name;
     int i;
 
     assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
 
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         if (!qdev_is_realized(DEVICE(pcms->flash[i]))) {
-            prop_name = g_strdup_printf("pflash%d", i);
-            object_property_del(OBJECT(pcms), prop_name);
-            g_free(prop_name);
             object_unparent(OBJECT(pcms->flash[i]));
             pcms->flash[i] = NULL;
         }
-- 
2.43.0


