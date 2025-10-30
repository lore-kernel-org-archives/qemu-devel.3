Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F905CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 18:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEX7G-0008Fp-4s; Thu, 30 Oct 2025 14:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vEX79-0008Bg-SH; Thu, 30 Oct 2025 14:11:11 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vEX6y-00087V-Tj; Thu, 30 Oct 2025 14:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhmC+fZMfX9ub7pqAgMy0+VpPGTQ/YyuZ3H2+3U0E34IF+JolMJMykZ7UziUf6MF5HKgYsa78iHKf+ihVILs+dvSWx/XHWyG7T34UeDNdJfBDDSXgqoFXfMNgQo71ee1tkxFIJagx2Wun+Spv7dskIgdc6qpl4XF2X3sDQnfv4zTUuUEYluZMRcnttSEWAAZIpd/1Fq7ff8YSb2XZuxfqTvUPGNRLQDGfCOBr83HToVsEnb852vVwkFFSAxzvZsnw3FRWT1wRkZbkRpoDNlHZASHY2TVJ6OsTtwOndntbxZdOlwkS/SbG0jZL+bTNSLiRNUCs2id0sfibUw1ty7wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vyd8NG/4VNP/s4Ghl3LqxKDRJBjX8HlnnLjBUPiIFN8=;
 b=pphcyymnMVUUfVhcZjZAF1YgZ/NuDcqF5Cp5+NITNys2Yg3BicIRy+MGEFsJsGa8HefrimBEaSI3XMOocDedt/lOjmq3uZBcAr3zdEf13nWwehKiScsCYiHqxssikK5f2kkLM5XTXFN+tYnbrc2uIZTF85lB06UXHSEbFGmKmEqEos3s95BP4Y8N5EoATFiZ4xhCVk+23IweAWJJjsDI2EqldntJtrc/XsiqhUaTHo2KBg9pa0Cs8jbh3Gau0hq/xlYsab4+s7iVnmJCl8vKBGhRXlN41VpABqR5Nu4gm8gQIpgJeO7lOfnl28vnLJPx5Cl0TdOatbdg4lvWCLc1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vyd8NG/4VNP/s4Ghl3LqxKDRJBjX8HlnnLjBUPiIFN8=;
 b=hkwBBeD3GGMgU7jb9kYflIYRvv8NrCcEBrNJsXuqinDGxfK/gex1EFOkoMISC5RcPDV9T4gCk8H9GUoGtWtaNq9E1mwneHxICrplNpOl945wAkyu6qx7IDjitZ/5hXfFgqHmydaQ60NL+FgFXfCfGZPntpxxNtgEum6J5a5ItKyt9T17MQv/Er5vqdQr2avBaG6HmVFUWZSHQfSuGLFyQ9TgJnNyE1vuoFPmmL70ZqBCXBFb5gpju6iu1ruzviFHjyRnBENMF1TnKkk8PznIx9yAxj7jeW565+yDMISG4eVQNFhwphBB4OsymcInTmPp2IOWK8MIbAADM7kChW9bsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7369.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 18:10:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 18:10:50 +0000
Message-ID: <db8ab47c-bab1-469e-8941-75c8e98db168@siemens.com>
Date: Thu, 30 Oct 2025 19:10:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
To: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <90fc6201696fcf0e5fd0493365bc32b217aa9d6e.1760702638.git.jan.kiszka@siemens.com>
 <e609ef19aa3d3ed9d7d9c105052f5d8550de5cab.camel@pengutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e609ef19aa3d3ed9d7d9c105052f5d8550de5cab.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: a94f8e40-2698-45ed-f02f-08de17dfa838
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEkvNC95WHBBTHBKTG1Zclk5V0t3VjdJeEJZSUdSNmIwNHQ0SFJQMTc0TmtQ?=
 =?utf-8?B?RjNoUzFRMG1nQWtNMUhMdy9DdDVBaC9JQnM0SDBpbHc5UndTcjkwMHc1MmFs?=
 =?utf-8?B?TUJuL0JZWUQ4YTVMZzlZQjhSa3ZxcEdjZlVvYWhoT2ZEL1JDWWx2a1JQU2Qy?=
 =?utf-8?B?UHppejFZbVl0REZOTUpHQzdUalZ4c0pXcGRBVlpRaXRFTVA0elFKY3N4bVJO?=
 =?utf-8?B?ZzJMQ1FoUXJEZnlBaWlqcEJpVTBUQ0l1UzN2bUJOaUpsTExGTHZhVFR0T3RY?=
 =?utf-8?B?azlrbGVISnFVdHZRckdZRC9tUk9MZmpSaUZZT2RsNXV6SXFsOFF6MGhLREI4?=
 =?utf-8?B?b2h0UEJvdUl1MXVFbC81MU4rci9teWVLMDQrdTJMbndNSmorUWpTZnZXdlY3?=
 =?utf-8?B?Ykk5ZWlQU2kvTVZERlh0L24vcGJQM2FEeFA5UWZ1bFdRK3liUzE3TFhES09X?=
 =?utf-8?B?c3AwNExudUFDdEhxOHBERE5KMWkvUWJ0cnJXZ0d0K0QvSVdodlI4engzall0?=
 =?utf-8?B?VThaMTVFVWNhbWJlR1J6a3lFR1dWczRXZmRNQnpvaWZpSU12c3N5aWRnSXUv?=
 =?utf-8?B?V2lHRTJMN3QyZmRRcGxoejJDTHVmUmh2L2xoZGxra0xHbEFCY3o0N3JDUXRk?=
 =?utf-8?B?ZUtwU0p3SHlva0tBZWtEVTl2VkRlRlhGZnB2Q01Ha3N0TUIyMEQxUWFUSENS?=
 =?utf-8?B?RzJzTzRsdVRxNkRLR0puRUtHWGp2ZmNxbWhhRjhzRHhURkVZSVAwaDJIODFK?=
 =?utf-8?B?d3lDZFVLVG1lV1RLYUE4cG9tWDk2bUxWaWRDSUtYQmZRVFVDbytrSWtCVk1a?=
 =?utf-8?B?RWlXWExjUlAxZWR1Q3Zwd3hpNkRBMm1lNmowZmhlUG9JR1lzTDVObVVmaURy?=
 =?utf-8?B?QW1FS3Q3UmN6T0IzNEk3WFpjWVpZQTBPbHpma0pyemFjNFk3NEh0N25DWEs5?=
 =?utf-8?B?RWRXcWZHaEVJVTU0MkcwKzN0T29ZTnp5YTFaa29TVS9BbXhleFNRVXh2VFpY?=
 =?utf-8?B?Wk1IVGsxMU1pMHVEcWJ0Q2JJZ2tOMU1UcVNENk1NYk5kbnFyOVMycGQ1V05q?=
 =?utf-8?B?VDlPbjBhU21uNTFCZmZRbXFXMjJpYTVLOFdMWDBUQ1RSYmpmV0pmSVA5ZTZp?=
 =?utf-8?B?UjF0Zko4bzBqbEVZalRhaDlVMmVzakFQK3d0dDluRDN5eno5am11MUJVVjVB?=
 =?utf-8?B?M052TXlBdDFlZ053dmgrWHRHS3d2STlkUDRkVk10NHFxcFVHdnFOQXVLTHQ1?=
 =?utf-8?B?N1cyZmN1OGg3ZTErbGpObGM5MHA1blQ0VEIzWThSbFkyTVMzRFQyRTlBeVhp?=
 =?utf-8?B?UWd6b3RXL1FCVmRzTllxSHRYbWoyeVRibWtIOGVTakpsQk04T2tGQjJqcnhz?=
 =?utf-8?B?dEpXQ0NVZ1k0YW5JalZKZ01hY2paNmd5cU80UXZ6NjBlZW8vb0tibUc2VDNs?=
 =?utf-8?B?c0sxSmpUWVlKNTQ0STdOVGdqaHh0U2t3MG5pM2xndnIzUFpSRC9YcGVsd1Bx?=
 =?utf-8?B?N0grY0NRekhZMTRpUGJZWEc2QVdJM2huaFRHbDFTVGdaaitvR0hzMHBCOGF5?=
 =?utf-8?B?djh5U0hWb3J6cnhWaGlKMTk0b0lQRDZGeGZCY0JDSUN2TjV3amp5T2txM1Nt?=
 =?utf-8?B?M05NNnYrOEZncHZDbEFXdXkwa3BIM2hXRVdaWWJUeTJtZ2pEN0VJWjhwYXJ3?=
 =?utf-8?B?bEVWVnVQUStjUDBZMFpGTzQ2Y2xUMDh5bjhpTVBRemU5MlVLYlFyZmNVemhz?=
 =?utf-8?B?dmV2WmJPNFhBbHBGOURtRG54UXhrcGpDMXhrR0J3NFhBZzErcGxQMDgyNXgz?=
 =?utf-8?B?UXhTUkx4bmxyaHYwcWFUQ0pKNjl2TGZWQmJkMWZ1bWpzQ2orNlRPbjQ4V1VS?=
 =?utf-8?B?c2pBOWJ4ajhqaTVTaXBYbnB0WmpZaWdrM20zYlh1d3h0dmxjYnJpcklNbE4w?=
 =?utf-8?Q?lxVYcH1kB3Fgm11LEErxrXqZ8/YH5d2K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akVaWUdSMEQ2YWFJSFpuVSs2RktLa3dQUTZ3NXBONUZYT2cxcnFubXh3V1Rs?=
 =?utf-8?B?cUNUOGhKOFdiNERuWlc5SjFicUt4cDdUeUlMYUYyam9Eb0E5eHVQSC83SG41?=
 =?utf-8?B?cWNjRW9pK1lGZG9QU0dyMXlMTm92YUVJR3hEZWdnanNFclFoYm85Yk5jNno2?=
 =?utf-8?B?Tlg3ZnpjWmhyMWdPYmdiYjJuVm9OTnpMciszSkZFTnowVFVXTFRFVzlQaDJZ?=
 =?utf-8?B?VmZ4cTlhYTZxQkt4b1VMZ3krUUhYRTQ1SE1hTTQyQk40VEV2bXc3aXZEZ1I1?=
 =?utf-8?B?eERYbS8vYmNLbXNtM1RLOEp0SGN6YW9xWmhnTnJYRUZsSUtwUURQTXdiMUdI?=
 =?utf-8?B?L2NwaXE0NDF0OVBXcmZySDFZMDVieWduZzExcUNPQUtIdkNqWTBPWklCWXJB?=
 =?utf-8?B?RmRYZXJOREhKTTU2cWhYQ0RSN0FBRTBtbzRzZFJTVDB1bXRnbmpoVmxaS1A5?=
 =?utf-8?B?NUg1NkplUG10Z0F5TDVPOUVabmVHT1o2cWpGUGlpb1NoNDkxYzFZQXRpUm9t?=
 =?utf-8?B?eHpxRmF4dEd6Y2dxSzBNeGdjNWNyVW9iMkJaeEtKSFhWZmNwdUpvdjlzbVgw?=
 =?utf-8?B?L0Q2cXM3Q0g2bStzTUtzWU5xbUZpSXR5dDZJUjVObzJhcWxDdGVPb3RQbjJo?=
 =?utf-8?B?YUMvbXpGTW5zN0Fja3M4TFdOT3ZUaXphb1h1b28rajY0ejFJYllFMlFaV01U?=
 =?utf-8?B?VTJHSVhSb2EwSXBOU1NlWktETXNaMXhFVjQzVGU4NWp1Uk9lRXRXQUoxSG9m?=
 =?utf-8?B?SU9ua1Zoc3BSLzMxR05PNnBvTW85YjBmNmc5RjBvbWw5bXdLc1ZMZmJieGta?=
 =?utf-8?B?QjRJOVhrbkdFZGJlZUQva2RSNnpBYWFKaTlhRmpSbU5oWHhXVHZ5QlVaUDgr?=
 =?utf-8?B?MCs4ek8rODl6ZWNkN0RiTWVucVphWG5DRHRtM0RxTzYzcTZnc3c3VlZSWjcy?=
 =?utf-8?B?TW9yMnVoRnJvL1RFekFLNkg4SEJOdlZLd3ViYVdGZk1ybUFhd1FNUkI5eWE0?=
 =?utf-8?B?Q2JLS2xuWjRobGR5V09neVVkMGZHWlRadWNPbkxyOEk0VGhFaVJrcXVBUGlN?=
 =?utf-8?B?R3pDcVlKbFB5WW5HWGtnejNLdEtGek9ST0N1bzNLTll3Y2dJVXR0aVZqdkxG?=
 =?utf-8?B?cVUxZEt2UjhXSmVhMklTYStZL1k4Y3V4UDV3T1ZvZlNNbHhmVVd4QXZpTFlT?=
 =?utf-8?B?eHFic1owU2Ntd2RjMVVlbmxaOXJra2ZTYStyYjBhb1JxeUVPbXF1TnBLT01s?=
 =?utf-8?B?ME5WWXdRV0RSOXJQTlJrSXE4SjhOcEhTU3FkQlhtcWtuZlNndDVBMmp3U2VD?=
 =?utf-8?B?VlBkTTdXUElJMkE0eXpFZC96cS95akpkMVdBZzdpVnNKSEMwY2g5SjFIdUxB?=
 =?utf-8?B?aitQVHdBWGFDblo3QVdnOTNhRU84UGxUdk80RGJycThNeTlaWnJEQjlQY1lo?=
 =?utf-8?B?Y1ptK0h4ZFhQTWNmbHBQb0htQjJMSXFNWS9aQzdBQjYxcDlLbUNWRmE5ZlVk?=
 =?utf-8?B?T1VMVjZ5c0xzNlBLcXZNQUJHL3Z1MmdRZkVRcHZHS2hFVnhHcW5OeFJKZUt2?=
 =?utf-8?B?ZkJmUDNRTVFIK3NUaWhOK3FMeWx3eG1qVDBPRFpITkh6L1JIQTgvQ01NbHhE?=
 =?utf-8?B?d3lLWDhKdlVaRmlqRjNrb085bUcyZTZmZXRhaE9sRldtZkxCR0ZwRmt4Tnlm?=
 =?utf-8?B?N2Z5QXpBaWxpYTRrN01YdEpzQkQ2NGptVVlLcFpORVlEV1U1cDFOaDFLTzJq?=
 =?utf-8?B?SVlUYjJRejBIT1hiM2U0MTk1dlpSL01FT3RRNjI1SFdaVi9oS1laWHJmM1FO?=
 =?utf-8?B?RlRPOWZhaXh2ekRIK1hsbGd4YzlEcm5ZK01MZndzaUhqNlJiaGpqNW8vRlJ6?=
 =?utf-8?B?Qlc3dHBMYnZmVi9nMHc1TjZ5OWlveVhTN0RremwvcHlqck55SitLUnFlNk9u?=
 =?utf-8?B?Q1pDeHNQS3Q1MTRWcDJvUkdGWTVBQk14YlRmRncrRUJpZlRSQ29jRzRYYTJa?=
 =?utf-8?B?QkR4Y0JnS2VFaW54cGlQa0xERHpTczF4SXpTR2NsaUFzaGNYcmJ0enJmV05C?=
 =?utf-8?B?STBPc0hmSUQyb3FBSzhielZQMng4OHhzWVRSQnBDTXFqU01UeEROclp4UmRF?=
 =?utf-8?B?NkN0cEo1eGVwZTNHaGsybXR4eXo0d2dhYm84N1Z6K25TeDB5U1ZNZzcxdExB?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94f8e40-2698-45ed-f02f-08de17dfa838
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 18:10:50.2549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wWITujc4hWPaov5F/lMinoHN3T4+GNYaWG/yJBUHjcvK4O91fTeRiUjTvBZqmpVGJjiBcDoEBsmKOaYkBZNOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7369
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=jan.kiszka@siemens.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 30.10.25 17:50, Jan Lübbe wrote:
> On Fri, 2025-10-17 at 14:03 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Enable user-instantiation so that PCI-attached eMMCs can be created for
>> virt machines, for QA purposes for the eMMC model itself and for complex
>> firmware/OS integrations using the upcoming RPMB partition support.
> 
> Perhaps reword to "Enable user-instantiation so that eMMCs can be created for
> PCI-attached SD/MMC host controllers (such as sdhci-pci) on virt machines, ..."
> to match the actual bus hierarchy?
> 

Sounds better to me as well. Can update this patch if desired, but I
don't want to repost everything just for that now. Or Philippe just
folds this in while merging if that is all.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

