Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E731BC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2GWA-0000Zv-7B; Thu, 03 Sep 2026 19:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x2GW8-0000ZS-0O
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:06:48 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x2GW6-0003cy-7z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2BFkdD4U4s8TIzg6xxFBQEkuOEqna4biXf6BBx6+SWOO6yIQOqcuP+6IMwXHlLMed8+0T8qykO3t5n9i3jQz5OiQ/y/PCJa3683eAR5qWBqbtu5a7FM/xgESOTEVNaGoVnKMJI0cM6YLKuXSKvceD9VNttXdHn0sljGJbVBmVOnH+6EkoZwOG5EGNACK+id/fhjOEZXS3ofKRPTdhxfCWRB4sDWDSHEIO15LB8tphgulJtbWgM7ROHXUuoHVSG6HhAavSyzeq33iN3Y9y8szerqIuD0uPKRmuyWOM9zlud98xdel8Hm3QD7y/q088O7BB1a/btXxWAgYQcKVeWgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRBD6Kuit2jcTJUm7QytD/hDB+ZlbrmJzXsP2MBh0XM=;
 b=X5PXFgxLsxGXaosOanG8bVx7QCHkrgpLsz/Z100Jvx0XGzOrJBjdII6ES213KjtDUxCywFb9LrqlO+1TIaQcUTgGqW1a9nVCFX7/MIrFfGmekwj768Kyfs8nywKvoiYCqQNwavJSh2BOcH+VATYxs/GvcXL+ZjzZlUVP3tHwh2N64eybk76hzSKUmBghxhWavWByJzlN6Fbj9cyI2KkPJufo/LQP8xaGranEUMlyP0LwjlwOladOoQsGtnnqyxb6R8ZwcEZpr8RTA85mfogjHBq9uIWL+GmlQ48bCmXAQIpuaXDLCBaep2Ebwq4otj4bGnCJLqssJDSpGY5igiFkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRBD6Kuit2jcTJUm7QytD/hDB+ZlbrmJzXsP2MBh0XM=;
 b=tmIy2D7b+Pqz3Giz6XJQB+jsMhgfU2H7sfah3qtqHhf24TegscVfsecpV3gfvrGqvLVMZE+vj+N488FYOneBkKokwJKwYYykarfUcKvdSdgRqbkObUdXDY3BwpxoHkGX9m9U8ayW4uorLd7b5So8v+Ay6voeT36v/IduQ5Vat6U/Z6xuWnUJqrTLNL0fpqg9XJjMFzbIDt4LR0mDYPfY2jEK6vjCDxvyC2HqFafG2tblubxuRitbjXfCLskhEXX3XBvcu35TS92/fZTU2l0wqJkjGjLJRxHE0xmvrNrEqEyO2AOrMcHw5H6+tEfUY8/gkZmE0CxDqHzuUwEesrOhuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB8109.eurprd08.prod.outlook.com (2603:10a6:20b:54b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 23:06:41 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 23:06:41 +0000
Message-ID: <f0f36091-502d-4f55-b0e2-3e791b9c51db@virtuozzo.com>
Date: Fri, 4 Sep 2026 01:06:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ahci: Fix leak of IRQState
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>
References: <20260903220523.2849019-1-farosas@suse.de>
 <20260903220523.2849019-2-farosas@suse.de>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260903220523.2849019-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0017.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:354::10) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 7327e7fe-adea-4def-ce7e-08df0a1003c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|23010399003|366016|10067099003|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: cWuLlS5+ae9+Qwcni+FrimXBuVEEK3ASQIgM22KeYRfWcW89BcBSyAP17RcGwq6KLVNPTgVG5La6H9bU4sBoe2JAg8lsomEMgwX1nda+9aPE/X5Q7vBCvXX1oVlHWMlDv78LBZ19U8A+cJuWLviKL9zSYfvkoV0Ha/EO/sku8tPvGkl7LAohzwByGM3tHYrsYNDmDsfYRRl2zJLY8r8K52TaenEC4EO45BGCRL5uhbPXYTMDFurdQ2/Fw2fG/i8qB0jbRSJRNLBCFbp+sqXj5zH3wk3RD/yuw0a1j1nObbnEjpUp98ZcfsQAUX8kLzj44dHHovrp0mQSviTDLlTJjtO8RLZFSUl93j0Z9ed60NuESgbZA+5n21Cf4eQBx9JzIbpI9TSMCjkhlGaKjCbOUmrZdd99egJG6YDLE6m/AWCsm0u0DLqCbc1kgUcLHB+w2U6ShdJIXkJEWh1fRZk4rxxJjfFXXOhKwVaoIhXduQVe2BH9W3/JR18+D4cCKeSd+eY2/n4+XJ0+pn2NRWCneupDjs8KbI8CSedyBnUJbiCTSsJF4Y+4T9TlBtz9DFfH165vqKVeTq1OnfVY+B6zoZmpDcVM3RyhyXMWul0kPuwP4Qfrg7KM4PHQsCr00nqKdl6cQ7Yxt2izQmKrIMAbS0AvRbcCI2V7yCJSLOXfZDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(10067099003)(4143699003)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFhGTkpyN1ZVa25YRkl5UjFCSE43enV3WkFLeERYL2JxZnJHTWU5MGZQODhj?=
 =?utf-8?B?Q25WS2pxdDFpV25VUDI3NVRUNEozZXUrSVZnaE5lbUlOaXhscXBxTVZydlhx?=
 =?utf-8?B?S0lBTlpQRThFRVJTSlhLVjFEbldOMmpvZVpYRE5OeVhEcXg1UGtjL1FIMkE2?=
 =?utf-8?B?a2J5eUtqb0JIdkk3Vzc5MG44YXVqd21YNHc1SzlWSTNZbVBlWXVlQWEveHc4?=
 =?utf-8?B?dWt6VTNpYXIvbGlWaTR5YVZVNEs2cDZ3d0UwakpYSUZBTjl2UWpJMk1GZE1R?=
 =?utf-8?B?YkZ2eGNBOTlCRmR3SXRiVUxyaEI2Q2tHYWF0a2R6SUt2eURheVU1ZjdEYjZU?=
 =?utf-8?B?R1VHWTU3MVllSWtkSXE0TmVWVnZtL0I3ZEVOSlRyOUlpM3E5Vjc1QTJPREh2?=
 =?utf-8?B?NEhzQ1hkRjRWWk1VdW1sT2FiTkZnOTRJcEszK0dhVFVuV3JwRkhRREpQbmh3?=
 =?utf-8?B?V25zbmdJT0YwYnpQL2NmdWdqN3pRdlI3Rk5FemUyd0pCZWtKZTQwbmpHSW4w?=
 =?utf-8?B?YnVpZWw4ckNrK0hxeFYzeURWVE85VHJSL3hIbktOb0ZFQSsyR3puODAwL1pz?=
 =?utf-8?B?aTZobEtMZVRya05ZbWY0NG9OVHVIeEVVZ1V5My81bUdlUkp6V0oyaHdBdWY5?=
 =?utf-8?B?ZGRKSUxndlpqMS9yOWFZQzFkRHVGdWFxY21TQ0lnKzBjSWxFL2sxTU9yZnEw?=
 =?utf-8?B?TExLQkZhWURQclJkUmlyUDMzei9QQVJNTFZwQUM4dWZFcE53UytIMkoxRmVm?=
 =?utf-8?B?dGUrcGdUajZUV01kaExYcU5tckMrUUJ0c09iL2dhUXFCSVFwQ1RESy9aZmtq?=
 =?utf-8?B?eEQ0RDNXV2cvckdiR0RrN1gwdFJBekFNaVRCaEdsVmgwajQvS25uTnNWUU4x?=
 =?utf-8?B?THptcUZtREIrMUF3N3JSY1pDYTdzWkZoNVFlUTQ5WUppVTNTakFrMWF3Sm8y?=
 =?utf-8?B?SGNWckViTG53R3BjTkEyZFhkNy8wd3R3VGMrbTU0Z2FNM0JhZGhnamdDUU80?=
 =?utf-8?B?WW9oYlVIT2t2ZHZzZHlUTlFZKzJacTBoZHJkOEJoelpqdVNmaEFvY0VJVlgz?=
 =?utf-8?B?RGxRaG1QVk5yRG93T2NLc1N3d2UwUHZTSUZKVE9rM25aQ3BETHJZa3BuNHZB?=
 =?utf-8?B?T3gwS3BZMVl5V3hsSTdtY2tjUGZiVVI0eExObHFJWmpmTEZxK0lsRllFekJh?=
 =?utf-8?B?ZmRXUEN5TEN1MEQwNXFnU3hJVWIrakFEVzRXUEhOeTlHdURqbE5nejNpemZZ?=
 =?utf-8?B?MkZBM2N1RG5ScUVON2lQWjN3dVl2T2V1V3B5R2M3TDJRSVp0dFN1R25xSjRw?=
 =?utf-8?B?cXR1d2VSSml1Y0JXU095ZStlZUNFKzAyeHhmR1RSZUtWdGoxeUgvL3gvb1pk?=
 =?utf-8?B?VVhkaXYvdFJOQytjaG9EcGpSYzhPR1NNL0dsMVpCSlcrRzFKamMyRi9kZ3RS?=
 =?utf-8?B?L1dUUVU1WEpsaS9WZ3R0MnhCeHNCdlYwQ0Jra2lxYWtWU3FqL3RaUTJyODFS?=
 =?utf-8?B?OU0wOXF5bTRiY3JLbStaWkw2a3lzMUFELytkc0szK3FWKzk3ZDRSbkI1VHcx?=
 =?utf-8?B?dTlrSUU5ZzRmZlZWN1ZvZ3R1T3h1ZEp4UU4wUEtrOUpQMDRyd0RmcXFSYjd1?=
 =?utf-8?B?U0xhMWo3ZU43b3VBdDc0UWQ5UnRCVnY1a1FMZmRiQWxERHMvNlN2UU1IQzFl?=
 =?utf-8?B?YWVnQTNyR1I5d1E2QjdTd3E3TmpFSEh1NFpLN3lOZm9Dck1oQ1gwL204Wk9P?=
 =?utf-8?B?UnJwa2I1YnlDd1NMMU1TakFLRjhnNUpNTmIrL0NNR1RCT2ZqOWdlM2xNS2w3?=
 =?utf-8?B?dmxVbGFzOGN5UDJrc1BGbnM0aUJlZFkrdUlBTzVhNzNZck5iQ1YvMkhpQytC?=
 =?utf-8?B?ck8yQTArL2E4WVZxM2s2bU5ZS1MxQUxJa2NYRlVWMVJla21HNzhCOGRRaHJt?=
 =?utf-8?B?cm1GMUVDUVRCbDIrbFNVNWpBQysvVkpSekQ1ZWpFSm1BSlJLT0hYQU9PemlZ?=
 =?utf-8?B?cmxHWCtMMmtkejZqTXVkYjgwSm5tcG96K3QwbXN0dUFCVXdUTFRnYjJXSmY2?=
 =?utf-8?B?MEZBNlk3YlJaa0NURXJnaDAzUm1QaFluMHRpb3llcnM2MWI2WWp0WE5ML2s2?=
 =?utf-8?B?YS91bGg0RVFiRVpWRksxYjROYlUyMHVWU0graU9scUVRclY1eFk2aXdNb3dV?=
 =?utf-8?B?Z3hCdVM1VTNyV1hkckQ3Z1hBNjlGMnJFM3FRSG9HcUZwMlRTcXRmR0xJL2Fj?=
 =?utf-8?B?eW9ZODE1cm8wV3J0ci9KbGlKSnFVQitOK0pnU2dIeTNuZ3NNVm1VVVZFMlZx?=
 =?utf-8?B?cDc0MlA1WGxhbW1hU09sL0pzWnZhZHpVcEhYQm52K3B3dE1rTEtOV2RRbEgx?=
 =?utf-8?Q?r8j/W5bwQPYTMN+siNa2cCthPP4rNkHByYAmO+MQ8Aw4w?=
X-MS-Exchange-AntiSpam-MessageData-1: N8vCFF4ZOaObUg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7327e7fe-adea-4def-ce7e-08df0a1003c6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 23:06:41.2053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fmh2jC+/8xjI2vqTPu1+g74KZMvsw1ZoSBAGIQG2Mgux/QhM0LREZMgoRC/dGNyvZ7TLZi55BB35ypoeMrj3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8109
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 9/4/26 00:05, Fabiano Rosas wrote:
> ASAN spotted an indirect leak in ahci-test:
>
> Indirect leak of 576 byte(s) in 6 object(s) allocated from:
>     #0 0x556112a08ca0 in malloc
>     #1 0x7f21591e595d in g_malloc
>     #2 0x7f21591ffe38 in g_slice_alloc
>     #3 0x7f21591c988d in g_hash_table_new_full
>     #4 0x556114d756f1 in object_initialize_with_type ../qom/object.c:506:23
>     #5 0x556114d77590 in object_new_with_type ../qom/object.c:706:5
>     #6 0x556114d777e8 in object_new ../qom/object.c:722:12
>     #7 0x556114d6d2be in qemu_allocate_irq ../hw/core/irq.c:94:25
>     #8 0x556114d6d1bc in qemu_extend_irqs ../hw/core/irq.c:82:16
>     #9 0x556114d6d329 in qemu_allocate_irqs ../hw/core/irq.c:89:12
>     #10 0x5561135da9bd in ahci_realize ../hw/ide/ahci.c:1644:12
>     #11 0x55611360156a in pci_ich9_ahci_realize ../hw/ide/ich.c:132:5
>
> Although ahci_realize() frees the return of qemu_allocate_irqs() right
> away, the individual IRQStates are still left around.
>
> Issue qemu_free_irq() at ahci_uninit().
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  hw/ide/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 6b04762c4a..86f6297dc9 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1688,6 +1688,7 @@ void ahci_uninit(AHCIState *s)
>              }
>              ide_exit(ide_state);
>          }
> +        qemu_free_irq(ad->port.irq);
>          object_unparent(OBJECT(&ad->port));
>      }
>  
Reviewed-by: Denis V. Lunev <den@openvz.org>

Thanks!

