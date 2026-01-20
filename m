Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6932D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viDdz-0001VJ-CG; Tue, 20 Jan 2026 10:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDdf-0001Ps-6d
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:27:29 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDdc-0006ub-WD
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:27:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJG4h+Cv15g7a+u5I5CLV/DHd6OJlvbqdLH2rbh3O6SyIntOnOM0pOAPWygXhFQHzj6HMmPfSNmVkiAW8ii8FQ1I4S2sGeJ2wgk9n6QDyEOpxRwSrJWlZJIc0r/meJ9x36/Fc4g/sFWDWH3ElHtsMGnxB0AH1eQA2rWWv8K+wr0WIZcBglbGVHjDzLHRttDoI3+mgSa53iL4qCun5s7E6Aj0skSHN1h0rlN4+STmbUrQjDhM3kOpTlCefS/gbxh4y8iwtexxs4SpyLY1bQ6++1FlQij64dvNQg+/KVW7VCFdizZZ4zcx2GwcPWZV0OnoEvoRFMamh0QEpxN6uFG9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0edcBvGjZ+YS6r3pWZcdliWp9pw3jOXoL89HS5uk+0=;
 b=qwv7zZ1kqNGd9SS+gdHlJ4C3PQ/vhFGydgC47dKzNGeRGNlR3rDT6pUyXXTx6X1xqhAIZHva14FOjCmMBRUhAjombFO3HgX70vuQkmPsfgcFhTic9PbY5G63E+FzmWAuikFP3F4yeOQ2SZ91rZiX22mQo2KxiDVCqWOUVGRk8P+CFVNejlxOQqjzEOgJ+5o0QAewrZvZB3orvM7ccF4NeoJO3f2Vi6SkPV3zt+W6s9MOmtBVF4WAlD3TAyNPhTZomYJyyqgnlP1g89577yP4ysyB7p4LQDZn1OnEcD5T7b63yQnrP+MYpX6qlfz+zwisiyQ2heEBTzIIP9uBkUdexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0edcBvGjZ+YS6r3pWZcdliWp9pw3jOXoL89HS5uk+0=;
 b=YARdUZKX2KcIt35zVVJhJ9OlnxIj4Ts1K+/d4amYVNRDSJ8UU0KSujELIXcRX+QZlSOzjvpogtHE9g+gp9e78PzG7nT5/3AMtEOQdr5F39+zrGEnS4jDmpToInpGF0IiblY9VR/T8OwlAvOyNE7cWi/Go4DzIUI2THzkJdWsl80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR1PPFBC9E76CBE.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 15:27:12 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:27:12 +0000
Message-ID: <81cc0e63-3215-4e82-ae09-e6aa8195111b@epfl.ch>
Date: Tue, 20 Jan 2026 16:26:12 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 5/5] tests/tcg/plugins: test register readonly feature
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::27) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR1PPFBC9E76CBE:EE_
X-MS-Office365-Filtering-Correlation-Id: 20785857-668e-48d7-2d15-08de58386222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|786006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0RRdk5JWWJsd3dKMUoyVWJVSnVQLzRVdm52NG1xQXIxK1NFZ2dxSmFkaFFV?=
 =?utf-8?B?MzFLWkc5cmFVemtQNmhZRlVBMDZGLzc3V1BWRDkvQXZRRE52cVZkejZtbTE1?=
 =?utf-8?B?aDIvUEg5R3pjUDZ6UXNISmZNMFVFcWU4U2hrMlJ0SCs0K3NzaDlyczRQUmdC?=
 =?utf-8?B?K2poRWxhMU1kTVkwTU5UWDh2ekZDNnBEQndYTVFQNmtUQ09jMzhwTnY2dmdj?=
 =?utf-8?B?MTA1cklzS25tUDhMU2NLcmFJNXRZcHhzYnpWU1JUbU5reUZZcXJINkdLSnUz?=
 =?utf-8?B?Wks5ZFlwcVFkUFkwWHBPMzB2TXhFWlJ3WjB2YmJGblNpVGQ5dUFzQk9saXpB?=
 =?utf-8?B?emlxWkFqOHRLUHVaZ1NJVzZNYUNYOEpiTExLOVpWSTZjNjdMWi9TdnlkdzNN?=
 =?utf-8?B?RU5qSXdRV3YwYVBVeXJkS3F4eEhTTExnUSt0NnAvdUI4OHNpdmtFVEE3Y0lI?=
 =?utf-8?B?NFlaNUJIYko0VERWd1RBd1dXT2lJOXIzMGNyY01iWjFGOHk3V3lRTUdCbjhl?=
 =?utf-8?B?TVFZVHg5ZXlHZ2htNWIwM3FBZis1WHFPYkYzNEtteit0Q2wwUWRDTXMzVWxU?=
 =?utf-8?B?OERnaE5xTjdWZUVTeWpUbVFOSENVM0w0VDNXTjhKNFJxZStlSUMxejhZTW5k?=
 =?utf-8?B?d2lKQlp2ZkgwYlpFMmZicDAxd2lsNkR5Q1pUWm9WUUpVSVF1eWYyU0lya081?=
 =?utf-8?B?SXdjd2QrTWhoNXNVMzFjWEdiWkxVclJ3UHpmTzNUSWo1NjN1M2J4NHlpNzF5?=
 =?utf-8?B?MHN5b0d3c3dNQTZQN2lVOTlWMEp6U0todHEyU3doOGdnNW9JM3BHSURYNlh2?=
 =?utf-8?B?b1g3WDBGMWI1bHY4dzlNZkhuSUdxdDlEMmtwbzhmcUxpNXQvOVZ5cHU1Smd5?=
 =?utf-8?B?OWdidXVRbVpIREFWTnVCVjQ0bDhMTCtmZU4xamY1NzNHMHpRUTdsQU1tS08w?=
 =?utf-8?B?SVpKaktUYkI2V2R2Z1J4YWRRRGJ1enVCdlpaRDUyNmtGUG9ZZlEyOFlBRmxJ?=
 =?utf-8?B?UmtSdkFCVHZPRG5TR1IyWEhFbitLbVBpL2dpSU12NjF2K3Qya0xhYkg3c0Uy?=
 =?utf-8?B?c0pVSHBqL3Q5WENNT0srYmxReGJFRjU0S0VJRC9WUEh2clEwL0IwU1ZMUmpN?=
 =?utf-8?B?NkY3SjlhdE52TEttN1daY213amtOcG8xRS9NdXpOTFY5RnB0c1RLYVBBUSs0?=
 =?utf-8?B?OTdhMHZrdzVBZjIxVEV3U2NneVJqVkpXeEU4NVlCb1BRakk1c2tZRTNTRXN3?=
 =?utf-8?B?cTRjcGVUSkRuUFhyYmR6SzBoZGxudndRSXB4MVdQZENzaElsbGgrRzl3Q21T?=
 =?utf-8?B?dHZsSUNRV3Y3eEhXOE1xY1FDbWZXd2syNGgvZjVSVDF6U1dYUm13M0hISEhW?=
 =?utf-8?B?a1hJdFl2MmN2OU1ER0pRY0dBVXMxbndrc0RwTG55TGZQNVpQUkZjR01NcFN3?=
 =?utf-8?B?MmlrUW8wbE1McnhYeUljRmlFYVJZT1EwVFQ5NnlmL3ZkNDl4MkpKbEtYdE1o?=
 =?utf-8?B?VDc3UnNLSVh6TUxLaWtVQnhPbmRna1VvN3dVcjN0Zk84ZEsrcGM2bGZVbDR6?=
 =?utf-8?B?OUNHbVB4SU1rQ0UrQzA1WlltUVdSUms4NVpHMitVNm81UDd5aHIyMnFkUE5t?=
 =?utf-8?B?WVExM1ZDdHVmRHd3K1RsSnJ2Smh1MzNyYW5xRTUwYndWOUJMdlFTdmpkeU9j?=
 =?utf-8?B?RjZKVUl5NWRxV0NSM1ROaTZEZjl4U0R4UEk4SFF4OVJsa1d4b2NBMEp6MS84?=
 =?utf-8?B?R2FrWnpMVVI2dXpLWnprNHZtdUsvNXc2bDQrNzhueWpkRklBTzhmQ2hNSTlW?=
 =?utf-8?B?djVCc0wyVGJWWnhKaWVtUXFMcGNmMWNFZEVmajhNdlVxbnlHZlcydDgvWXhs?=
 =?utf-8?B?ais4K2NQOVI0MWhub3hxcVRWTkh2QkRhTk0rY2xaRUNQblBXK0pWSUZTZzdi?=
 =?utf-8?B?OXI2Sk9ZOGwvaTdKeFlQakFYNkJSZmxqVmZkb1FQUklGQkM0L1R4Wit1OTRB?=
 =?utf-8?B?WGphVitUNXk5K01KZ3QxQldFUVBkQ2ZsTzlGTE0vNitZYnVQeW5ubWhjeHEr?=
 =?utf-8?B?RmtpcUFaMkVpS2NVL1RMTytnRTJFa3lJd2swWDBHdXhEVVMwL1EvelFEWVdS?=
 =?utf-8?Q?rrhs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(786006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdOWUIxS1dpcnNRQVFhMXlNSnhPTHIwUDhOa0hLSmdkdm10dXFlNWpUR3du?=
 =?utf-8?B?aGptZXJtRXUveCtxUENsM2RQQmZoUlF6OVlUdnZ0ZkpYaHNZUW55dDV6QlRC?=
 =?utf-8?B?RVpWTlZQTUtLbmVPZGM5aXNTZStMZUJZN0liTTZiNFJWeHl1T0tCYWxxMDM4?=
 =?utf-8?B?dUdVTExweFZZbng4N1NXcUFLZHJJeTdXbUxpek9wK2RWTWUwNTNwMVdQbm45?=
 =?utf-8?B?dkNPUHFRWkhIMjJaTzZZZFViYjBOTVhGUkoyZzFHMktXL3krdHpEM0g2elp0?=
 =?utf-8?B?aWEzdUErdSsyMXRVbCtycEY1eEYwZnFHK2xPTmx2a0Y0ejNnL0Q5UmVIdkRl?=
 =?utf-8?B?RnQyYTIxTk9oTmhRQW80L0RaclM4K2NxZGJWL3VBcFNqcVYzN0lrcldiblRj?=
 =?utf-8?B?T0Z0aW56VDdiQnlnaHBxSkFqaUNjWUR3cllyRFlTMWZpbkdLSDlLNUw5OTRT?=
 =?utf-8?B?dU9LVUpaVlFZcnR2cDFyTE40Nys0cHF3clpac29SU1JHa2o4d3lMcDlwbE9i?=
 =?utf-8?B?OVRQUGVudFZzMGcrdUJneFlPdHRkUDAyN0lCT0tmMFRncW5UL2ZTbEZwQ0wz?=
 =?utf-8?B?aFRER0FPVzY0OHRXRThoUmR2d2ZFL1N1OTBnUVpJQzZMcDlwVUcyQ1Z1SnJq?=
 =?utf-8?B?VVcxeVVXZHRKeE9oR095NEZPRmNsdUc4Tm1NcldaSC93L0VoTkZ5c2lKQ3o5?=
 =?utf-8?B?c0JFa3NEOHBuSlpEbHYxUzRXY21uaWVJWXZlc2JKek50UXB3NHE3SExyeDVs?=
 =?utf-8?B?a2Q2aWh0Z0tvYWpYMmdyalFHOUROZENBdWozQ0YreHhlZWtzWGdQTjQ5Uzh6?=
 =?utf-8?B?SGUvVXV2MDRGSEJZQWZsSll0d2FiazUzZk1RSUdhWUhVazEwUkNHcnRjNGFn?=
 =?utf-8?B?eUpBZVh0K2R0d1phVEVNZmZrOHg0VkNPTFFQeGdUdGtscTBseTZuajZTaUxC?=
 =?utf-8?B?L3pNT1ZlbXZTbnljMlRaQW9NNmVSOUtYdWdMK1krVm0rSjBDOGp6angza2Qx?=
 =?utf-8?B?aGZ6M08xTExIZWVmRWlRTEdkZURLVWlTUEdiTGg0WkwrTlcxRzl4dFI4VEgr?=
 =?utf-8?B?dmJZMG1BODU2ci9OdzR3UHhPeU41Y0d3MDIyY0lObXVTVllqMVBSWVdjd0wr?=
 =?utf-8?B?SXZSVHoxcktTNUd0ZEErVHFFQjlwSE8zUFdyMGRiQTJJNDA4VC85YmIybWd0?=
 =?utf-8?B?TkY3WjhiQ3VxQmFwanpJVWlzcjMzWU13VEdEWEdVbDlQWExuRmlyNzNxbFhM?=
 =?utf-8?B?RVBXQXdmWEQrRnZHd1pGVnkrMyt6MFh6WGJINGZ6SS9EY09PcW94VEZLWVVU?=
 =?utf-8?B?am94Y1ZFbENZayt2cC9aVC9hVGxNVlllOXhpVmZXQ1dwVkNnd0owdGgraFdu?=
 =?utf-8?B?a3pHQTJmZkh1dHQyTGJFc2tQYUZ4UzdxUUllTXQva3Q3SGNNekcxQlNnYWx3?=
 =?utf-8?B?clByNmFSdzh4RXVOODJvcHNOaFRFc3RRQnJJemtwdUdEWFFPejRDeTBFYzJL?=
 =?utf-8?B?VklPeitVOUxkSHJmNlBGbTRSRU9DNUJzcnZISVFQRHQ0czRlMEZlSzg1cXFr?=
 =?utf-8?B?bWtFYzc5VDNQeUdxYU4vcVFZL2NUN28yQkZJa0JYK0dqWHI3VzJxVXM5a0pq?=
 =?utf-8?B?K0FoTHhGZXdBK3BSZmF6bjFPUlQ5bHl2MlFxbG1IRjIzQ3d4dkhPKy9jUmpS?=
 =?utf-8?B?RWJrdDlYWUEyNGNqeDFtRmRzNlZHTW1IYTdRMjUxeGdDM0RoMDl3enN1aE05?=
 =?utf-8?B?Q2ZWejAyQU80ZlR1RzM2YnlQbFVzUHovcUdTVHJucUp6UkRJY0NyY1F0akpu?=
 =?utf-8?B?eUQ1TlJIVFJ6Q1JzVis5ZnhnYkh1eGVUM0tSM1o3MEFVNE9UTWpYNGp2MDcx?=
 =?utf-8?B?WGU0M2lXVFBrc1IzS2FEbmJvajZHOG1aWjJKaTVoeUZqOWF5a1RNQWVnajdl?=
 =?utf-8?B?Y0RZRWNSY0dRVnFwWXJ0eW42Umh4RXdSKzlDMXBuL1FNNlFWMldFRGVNUHd2?=
 =?utf-8?B?OUtNZnJDRGYzcS9nc0ZFTUFsSjFuNHA4OUdDT1JmcXo3SzFreUVpTDljaHpQ?=
 =?utf-8?B?WHB0U1ZWMWN0aDJSQ2ZMZEtXNDBQWWJlRkpuK0R3RUpieXNHbjc5NXFnWWkv?=
 =?utf-8?B?eWF1WFpLVURmd2M0eFdnYTI4R2p2RSs2aGZ0RmM1bkVlbUdURkNqQXRwNWZM?=
 =?utf-8?B?VTliOVVjaENPejVZMEhGTU8zVit1eHp3YWViVVZKZ2pJVkY1MWdsUVZ3RGZ4?=
 =?utf-8?B?clZyUG1GNGkyOW5zR0pmd1RZeTU0azZZdG51VndaNGJsR2gyUVUwTVh5WGt3?=
 =?utf-8?B?N1Rma0R6T08ydDB2ZHJ3dkxPTWx1WXVxdmZ1amRkQ2EvWVExcUprT0t5MkFL?=
 =?utf-8?Q?VKpy2iDkUrdxz+Dc=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 20785857-668e-48d7-2d15-08de58386222
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:27:12.2290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubIHTS9NVS8vYwyPt3RQajNEOmqjrgUPlHnyoGSeCQb1E6GYqpnrT5YcbrAQuLaS7JPkQ62oVVPf+T6V6XDLZRbSdKEcYxp4jAGbUsAh85c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPFBC9E76CBE
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This commit tests the readonly feature for registers exposed via the
plugin API introduced earlier in the patch series.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 tests/tcg/plugins/meson.build |  2 +-
 tests/tcg/plugins/registers.c | 71 +++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/plugins/registers.c

diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 561584159e..52831a75d4 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
+  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch', 'registers']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
new file mode 100644
index 0000000000..b738971551
--- /dev/null
+++ b/tests/tcg/plugins/registers.c
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include "glib.h"
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/*
+ * This callback is called when a vCPU is initialized. It tests whether we
+ * successfully read from a register and write value back to it. It also tests
+ * that read-only registers cannot be written to, i.e., we can read a read-only
+ * register but writing to it fails.
+ */
+static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+    g_autoptr(GByteArray) buf = g_byte_array_sized_new(0);
+    int sz = 0;
+
+    /* Make sure we can read and write an arbitrary register */
+    qemu_plugin_reg_descriptor *reg_desc = &g_array_index(regs,
+            qemu_plugin_reg_descriptor, 0);
+    g_assert(reg_desc->is_readonly == false);
+    sz = qemu_plugin_read_register(reg_desc->handle, buf);
+    g_assert(sz > 0);
+    g_assert(sz == buf->len);
+    sz = qemu_plugin_write_register(reg_desc->handle, buf);
+    g_assert(sz > 0);
+    g_assert(sz == buf->len);
+
+    /*
+     * Reset the buffer and find a read-only register. On each architecture, at
+     * least the PC should be read-only because it's only supposed to be
+     * modified via the qemu_plugin_set_pc() function.
+     */
+    g_byte_array_set_size(buf, 0);
+    for (size_t i = 0; i < regs->len; i++) {
+        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (reg_desc->is_readonly) {
+            sz = qemu_plugin_read_register(reg_desc->handle, buf);
+            g_assert(sz > 0);
+            g_assert(sz == buf->len);
+            break;
+        } else {
+            reg_desc = NULL;
+        }
+    }
+    /* Make sure there is a read-only register and we cannot write to it */
+    g_assert(reg_desc != NULL);
+    sz = qemu_plugin_write_register(reg_desc->handle, buf);
+    g_assert(sz == -1);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
+    return 0;
+}
-- 
2.52.0


