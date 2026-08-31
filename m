Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BF1C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x104s-0004yj-Me; Mon, 31 Aug 2026 07:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x104q-0004yR-AK
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:21:24 -0400
Received: from mail-norwayeastazon11023090.outbound.protection.outlook.com
 ([40.107.159.90] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x104o-0004vg-83
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gckDd9tW+JTibE+lMkhoGt4BOHPGOKenV4fHcHDgggMlD3PVQ7s+QwzJ7zx3UqVTIxdlRz2ZR+eJAaYS7Y/PXfKSKaIFWfLXS9BIJ2ZZ/7Y3uA3XLnhpi+YT27yWJFdN/vHTwlcjV4l/kFHxCZEUMTQVWne0Cj43Lgl3JEdV4ubMrGNB4juh84nip5LG3iY2i5w7zGyVRgGtMSvs4o01KF1wzNmwCkiEhM7DovOw1oKxUcbHxXevQPOLLEpGSMXNP8gXc6eJoy2NBd0oYCSTYW8qf25I2bXly/GVIo6G1/GmilWNTspg3/gVg2oHDP8cBWULY2FEi/AwiX5gMDUBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjbYNBLRHNPTQdrRhnijqUAcnlW9FyLOvGmOG3CSWxI=;
 b=fD2cuPVS8rfpRRUZwjUA38jh/mqHY9licXXgU0/ZEb3x287PM8qXqaQiphBKOSbiMgy1yKXu9qCsZRGn3u4hRNKtzlVvQS4s/4FokEnq6RH2G8synzn/xGe5GnL6bN5ZODL12jSZlPqMliKU42hflNQCC0+ieIGWTgPKgOBEpILYhnWiATLjnYa+l9LDuLpwT1YbsXUK6AwnOfdUZsMFaAWka/bLwdzaSQB93T2i+Y1Q8EqGeZnObXiqfu0U4pWH3ESmwbJGMltBuDX0/XXl36HUynsoQEC9lA6qgC68TUJxu8H69i+DGUW4yGi3HlJmLvvLxV+BMyK5tfV0IXNy+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjbYNBLRHNPTQdrRhnijqUAcnlW9FyLOvGmOG3CSWxI=;
 b=GuiP2Vd2hZ7tp+iDb+A0kOa9xq6GXJBqLn0t839QjkVBO1DJCHWvMI8criyNhBS6OasJVj8NpCrV9x8m1vuSWP/S6tXDO+t2S6YnSJivoz2SiMS9KMmKwaX3cD/IWXGyedhjh36pQt4ilUj1UXC0t7QVV0hh9MwWVrTVOFtYgtyv+9sxL1PpTxzg52NkcQ96B9R/lkOCcaMi4/f1E3QP1pMhjRO0SggF8dSIw0fhkkru3nx8NlevsnIMt2nDnaxlrV/pkzEaqCYPt6g8SCuzvi6cu64+klQAPmfHMAioDm0dBlII0sFB9C/e/SHPoRp7KetfWjdMsTw91ZMkP7vrYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI0PR08MB10425.eurprd08.prod.outlook.com
 (2603:10a6:800:20e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 11:16:15 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 11:16:14 +0000
Message-ID: <c656126b-fa5f-48e9-b841-665f1f097b6c@virtuozzo.com>
Date: Mon, 31 Aug 2026 14:16:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] migration/cpr: support vhost-vsock devices
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0068.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VI0PR08MB10425:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee58825-86f9-463b-7e94-08df07514540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: OpXskIaQOgXnTsWrZThPSS2yPhjik7w4mYu8/Xk+iZcrDWLUQXlEiIaL7k9/gXMUSmOx0dtuQK1H3S9aCs3KCjSTXISf5lkQEpwZHYGzYWNzVirilo4+i5ZHc69TmU9sToy8JZ4tOyGJIvOrSNHyh6tIOIzg56xDBZiu5RzXhOoiQTzOq6xwVetqtH4a3RUQ/5BfuVfC0uXkoPhTCO3XKGRuHBGaNPIR6fkUrbTHA6ErnAHiEZVfxdl7kpujIy1HGlx8jY1bBH1U1YalHLUduK7C//G9rO2Z5teB1HWqy5V6JssaWEKaFnOceLnq58qSWP4FvWAidusFKTk2iz7TMnIw5NDi0OxOwSgeX49f3BBegPDD/TN6g/ReC720MsEPkrW8PfsfvSRcCHOnceVQahXNDs2oBtA0h3u6wpxoOWTEwmn6am1a6BVyQQfSC6QhQdGL3yYwKXB6GYkIoRYPqrlZD7HwJqU9L0x04sYVeIUYUz5mNVt4V1VY7q715cWSiXk1k7Hb0lro6o4u1CrLdSto85rqCG3nQBrkpBA5QiGsiGhXr0RBnFA1KK4SAmsOp0mEed1D/YaKDKvpR/H92BDUtJghPQFGP6VaQbI4zpuNf/UKPZwhoIQKCPodC7jRwQdAbSOEO+3MHAlANBPvMcnPBQZ2NuyuZpiMy6NvLMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZTWVl0aktDY2x5c1lHNFZjUVROMlBDT2ZHd0hiMW9vaSs4a252NSswTUw0?=
 =?utf-8?B?VldFQUo0Z203NjdZTnZVZUI5UlRFZ3EvNi9lUWNuc1h0TWlGaUZ2Wkp0ZnpU?=
 =?utf-8?B?ZVdvV1dyK0lZR2kvVm8wektTZXNYOWhubnI5THdieUtxVW80a1duTW9HRVVD?=
 =?utf-8?B?Vk5yc2tHc1EybFMzS0d4cWdOR3M5Q1RMSkVVeVFNcUQ2aTdydWZ6WG5adCtt?=
 =?utf-8?B?K0dVNGRMdzZTUWFGWGRxM0VSVEI2TkV2UmtOUmZ2UkZ5YmdxQ1RGQ2llWFRV?=
 =?utf-8?B?YkFhVjBPeGduYlhGWnQ5QWgzWk9SdTQxRDhJKzJPOHFGVTZYTnZWd2JEZFdV?=
 =?utf-8?B?azRsRDJVdHVNTlU0cEdic1BONGdwRGdES0hSNFFHSFA3SGhIYkhtS25oOFlj?=
 =?utf-8?B?dFdkQXMxTTByS2lZZDlNdFhMdW51Q0l5dU9lZjVjZ3hBMU5oTGUrMnZxUlBH?=
 =?utf-8?B?N0NhSE0rMnFLTjhsRDg3b2FtTWF3R3pBMzhXWEZQem42eWZYMnllb1Bta0Iw?=
 =?utf-8?B?VmszVjdwdGhRWjI1THljWXV6OGNkVTdWTHJSMEtQMFlkRzlwUTlzM1RtTVZY?=
 =?utf-8?B?ZXBrOWYyaWc4YTluMDhRc0RZT0lHb2VRVGI3TDIxRWxVSDFCcUpXUFRLUjVZ?=
 =?utf-8?B?STJHK2t3WU1iVENFeGxXMFN1RDV3WHVWWGNwV0NMVzNzeERyamI5S2w5SGF1?=
 =?utf-8?B?NEY0TyttaEVpcCtkdDJ0bTRxWW1vZ29mUjdGc002OXNJYVlMd0hRT1E3WHpk?=
 =?utf-8?B?SlVmcE5NcTNUcVE2T2VlZ0hPdUlmZUJ5cCtsVVVpc0t3N3BUR0FzK05Zd3lw?=
 =?utf-8?B?aDZCdG44YnA1OXlkWDFOYlNieitYblhUR0FUS1hHQnR3VU84b3hEbmtQSXhH?=
 =?utf-8?B?dDREcWsxOHB5ZmRROEtteGpIQkM1aUxjdVhWNjdKdFdJQlhMR0RLbzNWRC94?=
 =?utf-8?B?OHY1UEdWS3R6T1h6RE5ESlYvamRWcVdPSG9yRTZJazV4bnhnbmZKelhLZXAz?=
 =?utf-8?B?RFdaSlpaWk0yclBtRzRCNFlzaVIzdWJBViswbENzREE0T3pVdytvajVnRTRp?=
 =?utf-8?B?UkdrdkZ3M2FLRXpma3hQaGcwaklvSkhDR3VTUG1YSlczUGZIeDEwSHA5Q1g4?=
 =?utf-8?B?VVhKYWlFbFlPa3VMZVRqRHZkZWIzUVByMk0xejgvZWxjWlBUQm1nOS93eWdp?=
 =?utf-8?B?OWhKVm9SdW9wVEhwYit4bnVYT3BJbi9UVDBPaHNIZXdvNzdZaTd0bGtCeGhV?=
 =?utf-8?B?anRKdkg0TDF0Tk9sQlNmcis1SnVsL1YwYWprOVlNY0ZMbEZuKzNtdlp4bkQx?=
 =?utf-8?B?cTd1cWpocGRST1hUNkRGUWFyeDJwV0Z0aldnT294dnhIcVZ0VHptS3BzQkxO?=
 =?utf-8?B?bG0zVHY0U2VuVWp1ZzUrTlk3dUNUbW1xUXNONm5uTTF3YkRvZi81Zm5RdHp4?=
 =?utf-8?B?UjJOcDlBOW0xOGRMRTF2SHE4QVVPNHd4eVFXVDNHTzFQejM1ck5NcXhPY0lF?=
 =?utf-8?B?RXFqK24wWDE0L1FzZUpGM3o2UStNL3VrTFlZTy82bE5HWWRJRXgwVGNXRHRz?=
 =?utf-8?B?c3BYVG1oVXl0WitudDQvNHlYQUlNSENVVkxNMkJNN1c0TTJjdllKZWQwTUZJ?=
 =?utf-8?B?cXlaVTM0MnZaY0w2VTQxZDhyQStqQ3VVaFJUak9NR3dUTFRydXJJbFVoRUFI?=
 =?utf-8?B?M0REaEVhQTNscjJYTVY4L29vWGhYTHkxYnFvYUxCekdOU0hKVno4VGRGNnl1?=
 =?utf-8?B?ZjJiWFpzaDVEWmcydUw2a1hxeGRHaHh5RndnYVR6a3lrVjN0c21DQWJaNU9O?=
 =?utf-8?B?WlpmdTFFN0ZwcTlpeHpmOGU2Q2xQWlhSVHRRWHRldDRNZmpmVHBCaWRwbFpM?=
 =?utf-8?B?cVcyUDIwbHNnV2U1SzRtRXQ0ZUdsWnJXek9kb2dsN2tPRnJTTENGRTYycWVv?=
 =?utf-8?B?QnNtd2dqdEhGb3BVU2sxWlB1OEdJNHFScWlNeGhhdmNveThzVzZOQStpU3ly?=
 =?utf-8?B?Q2ZyU2JPdWhJZWExYTVycG13cmZlNExTazRvWTE5VnRXZVBTakd3U2NFd05S?=
 =?utf-8?B?aDdBcnYrZjh4R29LbWdPZEVRS284ZjhxYkZaQVJydlYrYnFXczBNQmQrQ3d1?=
 =?utf-8?B?THgzVkFoS1BJNmtmNllIZkJ5WUFPaUY5ZXRaWktWd3BKdDRlei91U2lzRGRP?=
 =?utf-8?B?SDhmUHhDT0xkVmx6Y0xjSm1JUUluRUJ1R1JjT2M0Z2ZHMy9XVXlweEdNa2Y5?=
 =?utf-8?B?WmhTcm9zWmlRMFoyVkdRR0dSb3hVRVBka2d1NWZmZm8ra2hTUlYxT2pMY0FJ?=
 =?utf-8?B?Z2lmNmdlbkQvVllnQmI5UlBmVlJ6MnozZEs1M2t1MlZLU2pydWRhc2NQdDVw?=
 =?utf-8?Q?i7S1N1GjpDrtOZMc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee58825-86f9-463b-7e94-08df07514540
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:16:14.8209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkM1KnSfiVxEAAIuduiz3Scv+pBgQmWKVL5g8VvQkyHrZwnzhMuLNQhP5aq9w4Fj8a94aLjBzyLFoS2lTsro5iK/o8iTg8mEiyoNFrLgJyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10425
Received-SPF: pass client-ip=40.107.159.90;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On 8/20/26 2:39 PM, Andrey Drobyshev wrote:
> v4 is mostly fixes suggested by Stefano.
> 
> v3 -> v4:
> 
>   * Patch 1 (NEW) ("vhost-vsock: block CPR migration modes"): block the
>     CPR modes until the support is fully in place.  Make mid-series CPR
>     attempts fail early and gracefully instead of crashing;
>   * Patch 2 -> 3 ("vhost-vsock: don't reset connections during CPR"):
>     write vhost_vsock_post_load() in its final shape, not defer to the
>     last patch;
>   * Patch 4 -> 5 ("vhost-vsock: preserve vhost FD during CPR"): reword
>     commit message;
>   * Patch 5 -> 6 ("vhost: factor out vhost_dev_init_backend()"):
>     document vhost_dev_cleanup() on error;
>   * Patch 7 (NEW) ("vhost: make vhost_dev_cleanup() safe on a partially
>     initialized device"): split the vq->dev NULL check out of the
>     ownership handoff patch;
>   * Patch 9 (NEW) ("vhost: add vhost_dev_is_initialized() helper"): add
>     an explicit 'initialized' field to struct vhost_dev instead of
>     relying on hdev->mem;
>   * Patch 7 -> 10 ("vhost-vsock: hand off device ownership across CPR"):
>     - make the start guard in vhost_vsock_set_status() check
>       vhost_dev_is_initialized() and vsock->owner_reset instead of
>       vhost_dev.mem;
>     - call vhost_dev_cleanup() if setting the guest cid fails in
>       post_load;
>     - lift the CPR blocker (narrow it to the ID-less case);
>     - reword commit message.
> 
> v3: https://lore.kernel.org/qemu-devel/20260626164643.2526-1-andrey.drobyshev@virtuozzo.com
> 
> Andrey Drobyshev (10):
>   vhost-vsock: block CPR migration modes
>   vhost: add vhost_reset_owner op
>   vhost-vsock: don't reset connections during CPR
>   vhost-vsock: fix FD leak in realize()
>   vhost-vsock: preserve vhost FD during CPR
>   vhost: factor out vhost_dev_init_backend()
>   vhost: make vhost_dev_cleanup() safe on a partially initialized device
>   vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>   vhost: add vhost_dev_is_initialized() helper
>   vhost-vsock: hand off device ownership across CPR
> 
>  hw/virtio/vhost-kernel.c          |   6 +
>  hw/virtio/vhost-vsock.c           | 220 +++++++++++++++++++++++++++---
>  hw/virtio/vhost.c                 |  57 ++++++--
>  include/hw/virtio/vhost-backend.h |   1 +
>  include/hw/virtio/vhost-vsock.h   |   4 +
>  include/hw/virtio/vhost.h         |  49 +++++++
>  6 files changed, 307 insertions(+), 30 deletions(-)
> 

Friendly ping

