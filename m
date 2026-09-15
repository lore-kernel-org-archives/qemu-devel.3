Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF43DC88E7B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Ra9-0000tq-6p; Tue, 15 Sep 2026 07:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x6RZy-0000l2-OX; Tue, 15 Sep 2026 07:44:02 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x6RZw-0005d5-8i; Tue, 15 Sep 2026 07:44:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIOi2/8YYYx9IxuHydESvH1NLaxHFUot4UA5hsrkO5Xu3UdUuLjvjNQ91t9v4bdW01TOzoGp8kRZAkpIdU2maPCAZFwhuQcuQ1+p+ttPnv7C7O25XdhGEyl12aq1Xklwl7aaOO0Pd+s7XqbW23o7f3un4sZPJeysUyquxn39+QGU8yuH1ES4//lY6JoEv6xTdnkVe15U9x4Uth/6IRyQho4P20GSvqLgaoxUQr5OlM7kZQiCDArUg8nQfaQqVVGD1Zar9JY1NDm1L8dEH52f5sTEoF35vz02RxfG6y/dzcVQ2RqsUQs9hGessVuqz1rEfVh1NFhq4FIHHt9zEBL0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ckEs0vr99ceo9SyyQzWFbidRXvzYea1IXBZZpBfpL4=;
 b=GijT8e/tah/SnVf5S29bk2jgkV6fSLtrD+Xd3ca5NQ6eBuI6IGSFG7lk5pIWRu6YOZJ7koc+UYlseJFpby1s5iyvCVeE2Wng1Y/yN69XZNfKu5ovKUQ2UlOxjsY0zQg/HewNGx12d0YUInM8NnnUmcz2N8HyBThAciccjCYMkSZLMJNUKj6pkhEslYHiylSaaaqIL7YwPHEWkljGXCnkAbc/zK9nBFYWkJ+HTyar6oGDpUTvDXudmwbX8nTssNhiGCv3twMtbXwIwhE0oavPoql221Q2IBQrYqChiQbjNKaQsgAyw7uFtHZO+yWFRB+Rm2LL+tXW2OAPbzd90avr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ckEs0vr99ceo9SyyQzWFbidRXvzYea1IXBZZpBfpL4=;
 b=Vja3XvPsLbS3b4fnybZx9wsH0pCtK+VgpnCL1gegioKHuwj592pdwKu/kdva+GpRtGBbDtVxHXMSop6XLPsgOghkfrWLtYN/evJ+Ht13qm3/Rh8878RIOFeUDLrV27/EV8QKkIOmLE1OyAP0t3FTnIflZZcHNALjH5dS8C9Z6AksSp0dpkdjx6GcfrhyKkTXjusZNmm8hRuiS89GSYvqgrAGPINhv8Gru8zRrxldtxAbQ6fggyXVBXbwAiscqR4VR1XSL9G8guz+jBedoSSWDXpzvIh8i7w5MOaX1lA55LiQ2c81l2ofZK+7xg3O6vLqVF77udAEjqBqRKi15L5eUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB6713.eurprd08.prod.outlook.com (2603:10a6:10:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 11:43:55 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 11:43:55 +0000
Message-ID: <818f755e-40b8-443b-b9ab-9fb223a0d24d@virtuozzo.com>
Date: Tue, 15 Sep 2026 13:43:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix bdrv_next() skipping monitor-owned nodes
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260828222005.2888213-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260828222005.2888213-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0101.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::18) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: c275020e-f0ce-4c01-baf9-08df131e9f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|23010399003|1800799024|6133799003|10067099003|56012099006|5023799004|18002099003|22082099003|18056099003;
X-Microsoft-Antispam-Message-Info: zetO7plCfOSP6FRCbgJwf/oQwsYBMTfHrpVC2rdADJ0veVa0b1pMpnccaLn1S2eQNWuS800YCtEhtvP136ndGVvtVUfcf6wWW9/KU5cS+0LqFHf9JISiqNMCJ6JthyWQyoR96huXzYUpXRG/SDE4yhbO9f8JA0KUMPCbXJdyA2qL8sjz56kuk2zBgZaUtjc+4JYynhU/x4psoxECreasPUjO0QUiD28FVGBWGv213eZmuibTlMuoaFfBglXPah36ag6IfRJZj4XZEuAyPp5j/aOlKlV+yK3mL3wK754spyQBSyIH7Fyrg+wpVSauMLn88xygScxv276Bmu+Bw3jy+3e+WWUdKtmIAWiXaAtr/QhNz17EAwrfhUxFmke4pOr+0c9Rqn68hxwYQ/PsbKV/6yVKAdYd8Muw7HrVD7Awqg2mC9th/rO1eAZmWZCOh1UvzrM8YL7khQDxdZg0l1Z91N/4xJZaNswTBMKPISURf8JKcm5Odz/8YSLZ6O4J5VmYWilQmpmzCa1iezhBgV3JCBCayZmev45jWmk9HURChjBDWMGmsOG6jra5ysPySVSFEjjL3RJthTjT+DsGpHaBwsh42BCldL0sauzLjN6CtQtXgo5IUsC/ltrIb0C17eYyVKz5Oq74VAHKIAFN8bnVQ1lflGih/1vhNz/K38fySPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003)(18056099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZExDcXRjRm0wRmJ3MXFuamNlK3F2YmdZRTJsSHpuS3dlMjFUWEJXNzU5anBD?=
 =?utf-8?B?M2lvVk93RVY2bDJWTXZBWjQxTUE0aGlBcUpEMkZmSjF4VGF0NWErcDMvZ3hY?=
 =?utf-8?B?MmRLS0V3ODdZZmhpR0hwUnF2cCtVT04vTEZPSnkxcUdsUmNxMWwwKys0RVJG?=
 =?utf-8?B?b2t3TGF4K3Z6MWYrcFdRb2xSbXdwR291VVh1RlZob09mcWVYY0dqbFRTbG1G?=
 =?utf-8?B?dFlhcEZWbU5WVzJJano5aW5NOVdKZUorZWtwWXUxYURuWWpYemw4U29kS1RL?=
 =?utf-8?B?amRmbGUzSTZneVdPdTdkNDFiTnBjUllqdEVaaDNUd0dxdFpzUDJod1hRNkk3?=
 =?utf-8?B?U2hQcStxcEhkQmF0S3FMTTNuYUJzQmVyNG9HZk5OVHNFMG02RTZvYTlOZGx0?=
 =?utf-8?B?emhzMkZVWFpvc0NRVlBkVmJGNDhqejM4SUVSZHU2ZEdoMGFySzF4UTlBWm1L?=
 =?utf-8?B?R0JCYW5JaEZ2WXNvTzhFRDAyTTRJWVdhcUwvVGlTMlFyUDllZy9RazBvRlo4?=
 =?utf-8?B?K3pCOTlXRGx2SERtZG8vNXk1aktVT2Mvb0MxUEtxN0F4ZkJaMFZSYmlSaER2?=
 =?utf-8?B?RFVMWDNWRUN5VDY1RERwYm16VldOVXNySkRxNFhtT3hnd0tPTStCMUdVV0dz?=
 =?utf-8?B?Q1RKTWY2VEI2QngrNEtuRTlCVXhRWVR2akE4ckwvZ3FiYi9TWVJyMDBLMlpQ?=
 =?utf-8?B?WUZJSGMya0JMbWFHcnMyNHFZNDRCWWlzQ3FULzZaaFdmQVN4WkZ3Z1Bvcmds?=
 =?utf-8?B?bjBuNWhGL0pBczdrazRWVlhvNGU5dDhvdklVZThOUVB2M0ZrTWhic0ZBNkJ2?=
 =?utf-8?B?RmRjTnAwN3UzSmhwY2VaUnA0MVNONktEQjdQdmJhc2xEUm96TnlGQld6MGV5?=
 =?utf-8?B?ZWREU0RDN0VQSEl2d2QzY1FnN2xuZWRsSXZDelQzRHhMVTFPR1ZZWXBoVkNR?=
 =?utf-8?B?QU1OZHJuemxZclV3MEMwSXlRaHdvTEJCOWFQa0ZxRWVmbW5GRTE1L3ZRcGxw?=
 =?utf-8?B?VVlmeUtrLzNldmVoM0lTL3kzTlpodUgzWXhTUURWUmlIL3ZkUmpzS2txRmJK?=
 =?utf-8?B?N2NwenVvbHBFa3hNQ3NFek1aa09SVWtYQTRxWHQyTlRObDhTdWx5aDlBTzk2?=
 =?utf-8?B?RHRJcytZYTRlaENCNUxFSW9PUmhlR213N1E1dmEyL2FHUmZxdk9CSGZSbU03?=
 =?utf-8?B?TDZ2UkQ0NDhlUllaaHZsOEFmUHU5RnMvNjUrV2VJL3kvV0ExeXdaUFVMQTB5?=
 =?utf-8?B?Vy9rZHJ2aWE3L1h6Nzd4cytTcnNLSEs1NWxGNjMxQml5Zjd4L0p4R2c5WVll?=
 =?utf-8?B?T3pzYUVGQks3dVQzaTZyNEtSTWdXc0xwYUg5NnRCT0RGVE1jN2tQeUlLblFQ?=
 =?utf-8?B?NDhhV1NONVFIbnJQWnphZ3hQeHF2WHQ3QkhvOUxEekxIOTZGcVZmZFVWOFhx?=
 =?utf-8?B?QlNHdS9RczdPMFg1Wktva0NIUHF6RWxDMHcyeDlPc2ZXSHhqajlpWUhSZXZX?=
 =?utf-8?B?MnNNZGdCbkd1YjhwVjA4V2tWSEdVbmpUeHp6MzhnUjBmekgxL3VtdElDZ0ZR?=
 =?utf-8?B?YlNhRVdyQ21xNjE4Y1Y0L3FLY0d1c3IzQkpmYUJIZjhadWI1aUJWWUV6N2d0?=
 =?utf-8?B?Sk1QZ3Mxa2thcnZHQ1JsLzRzdkRIZ2s5enFucWhIaW9jc0t4Q2YxQURPSWxL?=
 =?utf-8?B?bTlPNmdQUUNYbmVTd3BsSHpCbzRCcHpLNTl1YjNjZG1XaGEyOG0zVlBtSi8x?=
 =?utf-8?B?OU9XbUNXVHhQMGpyUEhYait0dVl6Wnk5Qkw5ZEhGV3R4MG5VcWlZN202dWdW?=
 =?utf-8?B?K3l0ZkRTdWxjelFEMzY1WGNkZDlGVWJjc3lwOTFacG93dWRLNkt1MDMvSTJU?=
 =?utf-8?B?L21Ra2YzVGdRTTlFNFpjTnFxQXZyTllydnZpT3B0d2tyc3VLQUordTNPMlE2?=
 =?utf-8?B?Uk1VSTZjaGNXeFdIQ1VDMWxRMmVObGw4Umd6YUtkSFMyK0s1aGlncXdRcEph?=
 =?utf-8?B?b2JKV3FweWNtbUxPcm1FRDE1NGZIUktqUUM3WmNLZzBPT25oMFBETDFCSFpN?=
 =?utf-8?B?a1IwTHZrN2lMVnRhWkxFdmJ0SERXNVNETW16Y1ZZUndTOG40TDJkWHQ0b0RX?=
 =?utf-8?B?NTc4MzBQK2hSY0tBRlRDamV3ZDFLelc3Nnk1U3R1NEk2L2YzRVp5ZkNpMGNm?=
 =?utf-8?B?U0tZMWJreVdiYW5BTWxGMXExcWxOMjMxQTVLNnhBK0RrR2NEb1NKd3JTTCt4?=
 =?utf-8?B?L0lxZ1BGMDFBMWI0L1F2d1RzM0J2WllZWVl0Mmx3UVBUdHJMRW11RWV2My9G?=
 =?utf-8?B?K01ZbmxBSDRZTnR3djUrQUlFb0JUNGU3WE5La25MdTVwVmowRklPYzdsTzI4?=
 =?utf-8?Q?nzEMKo/y9Gnsb7EXWGWS72Vb9Hfch+Ew0QOC/WXKtABuN?=
X-MS-Exchange-AntiSpam-MessageData-1: qr1a2pnM4qx0Mw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c275020e-f0ce-4c01-baf9-08df131e9f50
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:43:55.4769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uhjUWaAnIEjnY4IqVimiAbxit8DCxAt47Q/OSxCucCPgD/kVqBy8GvucqS2W4MJ8ES4BH5hyYpFsMNPyMD0dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6713
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 8/29/26 00:20, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> From: Denis V. Lunev <den@openvz.org>
>
> it->bs is the cursor into monitor_bdrv_states for the second phase of
> bdrv_next(), so it has to be NULL when that phase starts. Commit
> f6d38c9f6d made the first phase store the node it returns there, to
> unreference the right one when the graph changes underneath. The cursor
> is now left pointing at the last BlockBackend root, so the second phase
> resumes from there instead of from the head of the list and never
> returns a node added before it.
>
> A skipped node drops out of the vm_stop and migration handover paths:
> not flushed, not inactivated, not snapshotted. bdrv_inactivate_all()
> still reports success, so the node keeps its image lock and the
> migration target cannot open the image. Only detached nodes are hit in
> practice, as these callers also recurse into children.
>
> Reset the cursor when the second phase starts. old_bs is taken at the
> top of the function, so f6d38c9f6d keeps working.
>
> Fixes: f6d38c9f6d ("block-backend: fix edge case in bdrv_next() where BDS associated to BB changes")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Fiona Ebner <f.ebner@proxmox.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> ---
>
> Notes:
>     The iterator was correct from its introduction in 2016 until 2024:
>     it->bs was written only by the second phase, and the node to unreference
>     came from the BlockBackend instead.
>
>     f6d38c9f6d's own reproducer does not fire for me, 240 runs across 8
>     timings, even with its fix reverted. Tried hard.
>
>  block/block-backend.c                          |  1 +
>  tests/qemu-iotests/tests/inactive-node-nbd     | 16 ++++++++++++++++
>  tests/qemu-iotests/tests/inactive-node-nbd.out |  8 ++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 37ba7e9fc4..55497c4551 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -625,6 +625,7 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it)
>              return bs;
>          }
>          it->phase = BDRV_NEXT_MONITOR_OWNED;
> +        it->bs = NULL;
>      }
>  
>      /* Then return the monitor-owned BDSes without a BB attached. Ignore all
> diff --git a/tests/qemu-iotests/tests/inactive-node-nbd b/tests/qemu-iotests/tests/inactive-node-nbd
> index 664157bfd0..ef876ae6be 100755
> --- a/tests/qemu-iotests/tests/inactive-node-nbd
> +++ b/tests/qemu-iotests/tests/inactive-node-nbd
> @@ -47,6 +47,7 @@ def node_is_active(_vm, node_name):
>      return node['active']
>  
>  with iotests.FilePath('disk.img') as path, \
> +     iotests.FilePath('detached.img') as detached_path, \
>       iotests.FilePath('snap.qcow2') as snap_path, \
>       iotests.FilePath('snap2.qcow2') as snap2_path, \
>       iotests.FilePath('target.img') as target_path, \
> @@ -58,6 +59,7 @@ with iotests.FilePath('disk.img') as path, \
>      iotests.log('Preparing disk...')
>      iotests.qemu_img_create('-f', iotests.imgfmt, path, img_size)
>      iotests.qemu_img_create('-f', iotests.imgfmt, target_path, img_size)
> +    iotests.qemu_img_create('-f', iotests.imgfmt, detached_path, img_size)
>  
>      iotests.qemu_img_create('-f', 'qcow2', '-b', path, '-F', iotests.imgfmt,
>                              snap_path)
> @@ -68,6 +70,9 @@ with iotests.FilePath('disk.img') as path, \
>      vm.add_blockdev(f'file,node-name=disk-file,filename={path}')
>      vm.add_blockdev(f'{iotests.imgfmt},file=disk-file,node-name=disk-fmt,'
>                       'active=off')
> +    vm.add_blockdev(f'file,node-name=detached-file,filename={detached_path}')
> +    vm.add_blockdev(f'{iotests.imgfmt},file=detached-file,'
> +                     'node-name=detached-fmt')
>      vm.add_blockdev(f'file,node-name=target-file,filename={target_path}')
>      vm.add_blockdev(f'{iotests.imgfmt},file=target-file,node-name=target-fmt')
>      vm.add_blockdev(f'file,node-name=snap-file,filename={snap_path}')
> @@ -297,6 +302,17 @@ with iotests.FilePath('disk.img') as path, \
>      iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
>      iotests.log('target-fmt active: %s' % node_is_active(vm, 'target-fmt'))
>  
> +    iotests.log('\n=== Inactivating all nodes at once ===')
> +
> +    # detached-fmt has no parent and no BlockBackend, so nothing can reach it
> +    # by recursion. It is only inactivated if bdrv_next() actually returns it.
> +    vm.qmp_log('stop')
> +    vm.qmp_log('blockdev-set-active', active=False)
> +
> +    iotests.log('detached-fmt active: %s' % node_is_active(vm, 'detached-fmt'))
> +    iotests.log('detached-file active: %s'
> +                % node_is_active(vm, 'detached-file'))
> +
>      iotests.log('\nShutting down...')
>      vm.shutdown()
>      log = vm.get_log()
> diff --git a/tests/qemu-iotests/tests/inactive-node-nbd.out b/tests/qemu-iotests/tests/inactive-node-nbd.out
> index a458b4fc05..48451dc0c5 100644
> --- a/tests/qemu-iotests/tests/inactive-node-nbd.out
> +++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
> @@ -235,5 +235,13 @@ snap-fmt active: True
>  snap2-fmt active: True
>  target-fmt active: True
>  
> +=== Inactivating all nodes at once ===
> +{"execute": "stop", "arguments": {}}
> +{"return": {}}
> +{"execute": "blockdev-set-active", "arguments": {"active": false}}
> +{"return": {}}
> +detached-fmt active: False
> +detached-file active: False
> +
>  Shutting down...
>  
ping

