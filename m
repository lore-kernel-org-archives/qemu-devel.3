Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831E6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMpZ-0001no-1r; Mon, 29 Jul 2024 05:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sYMpW-0001co-Qo; Mon, 29 Jul 2024 05:38:10 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sYMpU-000337-Tx; Mon, 29 Jul 2024 05:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHdnBxvylS4atUZ1q5dnMEgAgFdWBZE9wl1N+YaZOGZC/h9ggb/ldLHAU7/ISLKc/2USuIgQYNrqNgQOJQiz99A6BsgrFjJxLCl+JkNNXa3/DDPye9BXCp8P7VJXJJ4ggcC3vQpquMtSvWU4RKAiYJqIgstX+etM1KntMnT95AkDQ7aFJ4P0oUC54grvfTdYkIVYvZthEKkqwz2qGtA/wzDmq7xs8v4CP3RK/c4Qmf/nV0BXSOgxliQHS/kQjWZra/7xKAUVSznWuBAHRqkymCiO9krKo7ZNnciEO9e2PVEszZyXXDkQ/DlKW1/SdNXzthBK/pXL9bbPYkHgz2wIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+87MIDy/8chP04Ig3c7W2Nl7jmxMLFRukwKmApHWD4=;
 b=Sv7h+qOrAf5g2pZxInBFq8pItCB/MmNE9C0xqPfS0OumC84qX3xYbc3zJz62OEsdAlBwhts6j67ZN//JaDE9wZRPCuaXMUivJr4hHtlZV+PiLb5VPPT9NN/eSRNJtY50UOeeiEzs9B6EWC1Aw+iqtZkCphV6eNDTLhCc3S2Oe6OJvdHJxfRjr2t776qUTA16WzD+hs1VR26jP4t+tqD1u8VSqFR5FKFEmGtvGlPrseLgqB558du4I51Bo+tEAgtm8z9Ps6iomBlKE82T4XBlz+9ELG6P23VC50rp5z8OCbDKkaJGf7yeemFokIugApIS9Y8E471EHzfdxA19r8Zp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+87MIDy/8chP04Ig3c7W2Nl7jmxMLFRukwKmApHWD4=;
 b=CQ8TP9cGEsa3Fs19OdsP08LfadW2Fou74pts0cZ2toB6Z7+O7Xibei8v9Li+oJYO6t136p5GPrTgGmFPqr2EWcmwfTazC8xLkmRh6WA3O+RrrpxybM6cejnWc8JDVMVju9pPbQTUzsn1HvSdf7EkAUzHAl8ifksgRTuufYH8/OM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ0PR01MB8153.prod.exchangelabs.com (2603:10b6:a03:4e5::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Mon, 29 Jul 2024 09:37:59 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 09:37:59 +0000
Message-ID: <0c171de4-a8ea-4859-b78c-272244267bb3@os.amperecomputing.com>
Date: Mon, 29 Jul 2024 15:07:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/kvm: add support for MTE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 darren@os.amperecomputing.com
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
 <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::7) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ0PR01MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 44344603-e119-4e0a-633f-08dcafb22255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmlZakF3ZmozM3ZVc2ZqSEJWUlladWNNMnlWT0FuOE11dlduMHVvTmh2eGxR?=
 =?utf-8?B?NmZUOTFEL3IwbDdJOTBGRTMrdUlkZlpuVTRWbXA5WnV0UXlNMGk4SEZyYk5t?=
 =?utf-8?B?RTQvN1VxZHNPLy9hVXhERnBYc3hYY1FpdmYrNVJ3bURIelVmWUNOb2xIZGdj?=
 =?utf-8?B?S1BwVjNWRkRPSDJGcFUrUk5TOFZDN3ZVQmhreUhiMlgrZC8vbmRoK3NWUUJq?=
 =?utf-8?B?czVEamJEREpyNVlCbVBmR0tOVnFGTWZtTmZ0Uk8vL1NrYXhKY09DdkZNQ2l6?=
 =?utf-8?B?RVRlYXRzVFhJWlg0SFdaZzNCeVUvVVZlWndsL05yS09GaFZyR2o0Wjd3YjEz?=
 =?utf-8?B?UjFiRzBZQndJNmhaSnB6VmVHaU85U1dWQ2V5UW5LZzdBOEd0cTQ5bkM3UGho?=
 =?utf-8?B?WG1uQkprRFZUKzRuK2FNZG1YL1RucnhuUk9VbmpOOCtnelpSblRXNmE0RjlP?=
 =?utf-8?B?MjRhbERDcWJwNTZvdC9oTDllV0JRZ21FWkxxc2NWbFJibWk2T01JcXZlaFJi?=
 =?utf-8?B?VndrRWpqeVZmK3ZlZVNqbFVscExsSXZrNURoYVpTYThieG16K0psUlcyVGk1?=
 =?utf-8?B?aXJIZGtyR1hmbkVZUElUejNLWjREYjB4cHZ5cG5PMUpFR05INElIbWk0cGNn?=
 =?utf-8?B?NWU3Nk9GMHhQajlqRjlrUitJZ28wM2h4c0ZMKy92T2FKUHJuSEVqR1NGOUp3?=
 =?utf-8?B?SW9GcnpIeGtjTWpiQng4SkdyY0h4SDE1TW9OcjZkdUFiVU91Sm5yTnEyTm1D?=
 =?utf-8?B?bWpleFNNUFJodkpLeDVycDhmQmd4TFF6cjFDc1FIQzJZb2JwQk9udFBTSW1U?=
 =?utf-8?B?TDcyQzZGWDNUY0pIclY0Ni9xdTlOb2hpK2l3MnZBZi9lSUFMOE83RkJnaHZK?=
 =?utf-8?B?blFCS2dSY1FxTjlYeUhRTUlLa3ZXQ041UDJId0RFV3UxQUNLS2hFMm9COWxX?=
 =?utf-8?B?eXpUZEgyZDB3TEozNUdqaWFqNGdBaXAzRHpKSldodGhkUk1lcjg0SGtRbTg1?=
 =?utf-8?B?UFJKMUwvd1ZlMXBLc25nUlNvNUtJYXlkZ1FRQlhpVTJBNjZQVlhNR0RrNWN0?=
 =?utf-8?B?RVY4bnh2UlBRMmliUzhCZlR2cjhPeEhJMTNZS1JDNjAwcG1wV1dvRXNmZjZp?=
 =?utf-8?B?WFBlazhpY285UGpQYmdieUNPbXhham1pZGxwaU05N0VvWVBZS3pPUWU1OW9M?=
 =?utf-8?B?M3NDK1FDSS9rWWhuOXo2eU9kSXBFd2Y1bGYyWXUwamJBT3pGWUtBNkxUK3c1?=
 =?utf-8?B?d2xIYk9vK2hqQUpnM0dWVHJZTkI1SWZtVVVPd1BWQkQrY1R5V1krZjFxamFW?=
 =?utf-8?B?THVYc3dPMWJIdDBBTlByNHZVY1orL3dGYkl0TjJoR2dINVlKcEpPelhpNEpS?=
 =?utf-8?B?Q3FZdzJUY3Vzd2VPR293Y3MxQkoyU3MxV0Z1cVVKOXliOTJEQXV3UW0wb1Rt?=
 =?utf-8?B?V2dUdnlEeElJL0NrYnZDbHVSVHNwMGFrNDFrOVh0bmNwUnVXSlJLaTMvRFVr?=
 =?utf-8?B?R1NJcEtwYm8zREtYcnVRaVpSUkxFODVMUkYxd05IUGRSMjU5cjNsNEQ0OGdH?=
 =?utf-8?B?K05iNjdEdk5NbmhzNWlwc1p1R242STM3NVJvUlpzU1NoMSt4RUxHbjV5RXhh?=
 =?utf-8?B?Tk9oYlBsREFsSkdGNTY4SXA5b1hhQjY2bktPOG5QOE96bUlnUFVvNkhkZTR2?=
 =?utf-8?B?Lzl3NGpaN2x4Z0xjSE5vU29sZCtJZEt4RU9ITzBLV0ppbXFkbFYweW5aZyt4?=
 =?utf-8?B?VEUyVm1RdDJ5dUpTb1YyaGpRZkk0VTdlZWVKRzcwQ214RVI3Rm9jbU5EeXdC?=
 =?utf-8?B?aVl2S1haemJIZzVSN3FsQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEtvV2grQWFoNlZ2bUtTMHFCTEphdkpUTlhob3F6MGRJZEdzL1RwKzdCb3ov?=
 =?utf-8?B?N3Vna3VvdjB3K1l6SS9xV09oazkrazk2ZDgzV3VnVEV4S0lGM0daWWJqL1hi?=
 =?utf-8?B?V0lRVUtDYmc0L25qbFYvYTRxWHpYMjlRMVg1VlozeHA4T2tCOGhVSmg4TDNT?=
 =?utf-8?B?NmloT1dWeWJBc1Z4YlVhWTB0VVdZaStBSzk0a3RNN0kwaFRkaGVBSGIyMVoz?=
 =?utf-8?B?WW5oYXB3ZWR6Z0U0RG1kZDgxT1k0cG4rYlY5UjFLYVBGZ3pWb0NBRnFQWEt5?=
 =?utf-8?B?dThJb0ZydzJIb0RBT0d3bTRoUkN3N0xodW9NcmV3R05vV1NSL3hQajNQS3k3?=
 =?utf-8?B?UlJZZlAwbFhzeVdzV1hnak1ZTWxvMjl0aFllamF5NWprd3FwVndPeUZTWlNK?=
 =?utf-8?B?YTJaTzFhOTdrSXFuN2VHN3BzWUFEbFVONnM2S0F1YUxYQXdyRUNpd1NoQUc5?=
 =?utf-8?B?bmlMU2d4Z2UrSnBKK01ZdHc4aHNNNEl4dU8yZ0JuK1VjOHVPNnRDT2pmbERw?=
 =?utf-8?B?bEsySG5UaVB6RWFvVWI0Y3pvMEd4amJrTXRXUGF1QzRBVUlrdFhJclU2Z3NU?=
 =?utf-8?B?aXJxZkg1aVNkQlNWT3loZ24rd2J0OVVBUXJVZUIwQlN3cFAxUkptMktlRFAy?=
 =?utf-8?B?Ry9SYTFSbHYyTWxXbmZEcHJ6eTUwR3o3bzc0TTZGOVVZb1VLbzZsZysveDht?=
 =?utf-8?B?OGNaUE54MHN3YmVhMWd6Rk0wZFEwTTFDbkpxZWl6VkFLakYvRE40VW44U0g4?=
 =?utf-8?B?dk8zck9YKzNFMS9IVkFnVkp1angyNWltRE5udHA3eFlGU09XZkJGQXUvcXdG?=
 =?utf-8?B?Z3JqcDh6VG9BVGpQckNUU0pmR0tiQjNiMVJ0M1VhbHZGQVgyYzhLUEgwYmJo?=
 =?utf-8?B?LzloNHlIeWlpbTJzT1QvYno4UXNDTWFuSmtWRVR0M09CNzBHdHdWUWVxV1R4?=
 =?utf-8?B?UTBjQ0RCYTRVaHo4ZWw0cDAvMWNPR0FkZkk1VlJpOVpSQU1sM1VBY2JjeXI0?=
 =?utf-8?B?SUR0aXZPVC9SVHlLM3c5Rkw1Yys2N0dETUV5Q2dPZDNJM2ZUL0wxVHZSVkFH?=
 =?utf-8?B?ejVWWmZhSXBnaHdxb0hIK3FuUmtsUm9keTF2TXZ5N2FUbUxiV01MN3IzNEYy?=
 =?utf-8?B?WE1tRk9NSjM5SmNZdkVFVEdyZWt0dVZReHB6MnR0SUJyQ25sQW9obmljNzJ5?=
 =?utf-8?B?TGJaWmVBcTFxWnppTU1BUEZ2a2thNWEzY000NElZZTZXZHEwQmRCN3lmOWNQ?=
 =?utf-8?B?by9wdy9PbWhtR2lURUZRT00rL2VySTY2YVlqdHZTN2ZuOGJqZ3ZQR1pvN2Vo?=
 =?utf-8?B?eXRzZjJHZ2V5UEtORTRmL1FUQ1V1L1Fydy96Y1VIcDQvMzlNWnZNck9nUXA3?=
 =?utf-8?B?ZVdvaGZQYUE0MU11RG9DU3RGbGowSVpYaHM0QzhnVDN6dy9PSUREU0RTUHUz?=
 =?utf-8?B?ZTk4cElsSCtxdGJ0V2lxY3hOVzhjS1RoZ0pZQnBJUEFGOWxYeGdDNzMvYUlZ?=
 =?utf-8?B?dnZUdjN0RkxBUU13V0lkcnFzaVFOSDJTaW56M2k1MFUxdDQ2d2VPTGNlRmdl?=
 =?utf-8?B?L2dmMnNhVHhrUm51am82UExVWHVnb2hySTdLcGt3T3VJa1RMQkVUNUJPanRY?=
 =?utf-8?B?RElpUFlRTnlFMEVIZGFtMnYwOTgyWUJJSCsrbzZNZys0a01QMWdVOC80ZHBq?=
 =?utf-8?B?NFlBeElMRW91Vnp0SHlUZmhzSGtpRlRzUnJDSzBoRDFSUjJsYVZpQjB1RWVJ?=
 =?utf-8?B?blRjTXdqM1lualRpcFVxVUhTekNRTFZKQWoyZ0xxem1pTFpVbWg2cEJoRHda?=
 =?utf-8?B?RGFVTWs1b3g2bGUwM0FTVTJ4VlZOMEhjWWlHc2FhQzhTNVgrOTBzdll0THlN?=
 =?utf-8?B?cUhmMS9Ub0NJUTd6Z2pTNFNnTCswcTR3ZHovOThZams0YzVySDBnMjFaUm9v?=
 =?utf-8?B?TDR2ck1NcFNLQU10Q1lCYzJ1dEllTkpTRG1NMGFjRHI5TG1aQU1STEdoeWVW?=
 =?utf-8?B?MVpIZnB0S1AwRVBsdmJyRHlUSm5KQXVlUmlkRlZqQjNmY3hRSDZOYXJxSDVV?=
 =?utf-8?B?c0NoTnMxNDdjS25kTFRScGtNMWtlNStqQ3czK1o4WmZFY0VlZnJCMFZjL3BV?=
 =?utf-8?B?SjJMemhqd0QxSm01NGYyUG03eDVXWU12bE9oSHVIQks2a2xMdlIyc2VaZjJh?=
 =?utf-8?Q?Nb7b28k9iGMTp4PgtSlQxlw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44344603-e119-4e0a-633f-08dcafb22255
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 09:37:59.6092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4FY0GUePrqj7AiT/seKKHDoWIxTBzQ085viNfdhK2K2zGz5uxPFSkR7hFQGA2zQFMDla9dYV3adDBDNcehg8uUzi1fU3wRZ14CV6X/F1GBAuMKcfVmNunDdeYTaHfPq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB8153
Received-SPF: pass client-ip=2a01:111:f403:c000::1;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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


Hi Peter,


[Apologies for the delayed response]

On 16-07-2024 09:15 pm, Peter Maydell wrote:
> On Tue, 9 Jul 2024 at 07:05, Ganapatrao Kulkarni
> <gankulkarni@os.amperecomputing.com> wrote:
>>
>> Extend the 'mte' property for the virt machine to cover KVM as
>> well. For KVM, we don't allocate tag memory, but instead enable
>> the capability.
>>
>> If MTE has been enabled, we need to disable migration, as we do not
>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>> off with KVM unless requested explicitly.
>>
>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>> which broke TCG since it made the TCG -cpu max
>> report the presence of MTE to the guest even if the board hadn't
>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>> then tried to use MTE QEMU would segfault accessing the
>> non-existent tag RAM.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
> 
> In target/arm/cpu.c:arm_cpu_realizefn() there is this code:
> 
>      if (cpu_isar_feature(aa64_mte, cpu)) {
>          /*
>           * The architectural range of GM blocksize is 2-6, however qemu
>           * doesn't support blocksize of 2 (see HELPER(ldgm)).
>           */
>          if (tcg_enabled()) {
>              assert(cpu->gm_blocksize >= 3 && cpu->gm_blocksize <= 6);
>          }
> 
> #ifndef CONFIG_USER_ONLY
>          /*
>           * If we do not have tag-memory provided by the machine,
>           * reduce MTE support to instructions enabled at EL0.
>           * This matches Cortex-A710 BROADCASTMTE input being LOW.
>           */
>          if (cpu->tag_memory == NULL) {
>              cpu->isar.id_aa64pfr1 =
>                  FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>          }
> #endif
>      }
> 
> With this patch, for KVM we will end up going through the
> "squash ID_AA64PFR1_EL1.MTE to 1" codepath, because KVM doesn't
> set cpu->tag_memory and this is still using that as its check.
> 

I looked at this function and it seems we are not entering this function 
for KVM boot. I do see -DCONFIG_USER_ONLY added to make files.

Also Linux kernel wont detect/enable MTE until unless the 
ID_AA64PFR1_EL1.MTE value is 2(b0010) and above.

> More generally, how does the enabling of the MTE KVM cap
> interact with the ID_AA64PFR1_EL1 value that we read from
> the host in kvm_arm_get_host_cpu_features() ? We care that we
> have the right ID register values because we use ID field
> checks to determine whether the vcpu has a feature or not,
> even in the KVM case.
> 
> Since Cornelia first wrote the patch this is based on, we've
> landed gdbstub support for MTE (so gdb can find out which
> addresses in the memory map have tags and read and write
> those tags). So I think the KVM MTE support now also needs to
> handle that. (See aarch64_cpu_register_gdb_commands() in
> target/arm/gdbstub64.c.)

Ok sure, I will go through this file to add/update MTE part


Thanks,
Ganapat

