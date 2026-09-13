Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C451EC88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 19:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5qKi-0001dh-N8; Sun, 13 Sep 2026 15:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x5qKg-0001dR-B0
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 15:57:46 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x5qKe-00074R-Dt
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 15:57:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3Jh1phTsU+T9SZ5FtUgoXddByx+wOv3oeiedFtJXam6AN5PmDK+O5dTeRWmBnZmqIV7Xv2KFG4ec+hz/Lvlb3Wf2lhzm/7iFwtUaRij1ypJ0zRLsrULyTZ+8Uhdrhx38s/s1FOQz/CDpRXWNxBLNrox1BFVsfK6EwVl4i10DexUoy6ZNQTihmaOvBCm7GFxWuoy1ZFSjmS2mmp+0CfZhYfZ9hQN61n+0+v6OWpRj9kxr+vBjwvgTVVFAiqqEoRivXUHnCYlH0gqTwI5gAIhnt9H1rWTUgayZ26NT714cR2O+4HEcT9G3AEwS1E6NA40T37ZVK0lgOVAWjQNwXJ9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIFFtvtAd2K+VqJKs58TyWkWjTfV2ckNkdvLG1wd1n4=;
 b=O6sbLn3ys4XA9k20WW8TfZbUjdezFYRiKaRLuxDSnjuPGJed07N/5YgQFN84pEbId6xR5ssqGYA6XC18agTAutxq0QWDbx05azWpsUTcchyxJ+/9i4J0gML+IPvVM5HLh/+AIlQk6O42miNN38LtSha6ifjb9gY1KddhZ+Kxl1DnrfCnYYhmNPSpEXNC1+Kje3KknjptiruYd2SeKvweJ9CYoLe7S/jyulx6vChLM4MmRsKFHVHhUr7xKbOc85JFxJNIs9MFBKysTHCb3jDI27USJf6T/cpXdLxrX6u7qdNdeqLP9axUmrkFCOff72dGniRFeK5VnurHGdoIjdsZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIFFtvtAd2K+VqJKs58TyWkWjTfV2ckNkdvLG1wd1n4=;
 b=h0etY61meyjUhUCOchL4KNO9ygIGeDcrSp5uFhaLynJqFm2E3ANC/b1F6Ye9oAocqD+FaNa80dMB6uROqGGfKWv7ihX+6V7uq3oDMawwV3qHwcEQU76QZPAwTdS2mAtiZbdKwsDIclGb+uS6139f5rTEAly2pf9SI4rz2sii1J1ghvoVgrkNSUN/0K4yngBaEsT+1CwXoVpkj4eOsIH2C7BjzUsyXhnqzSJNOaX6ZmbVY+HFp+hj81Mj/XTbLhaGqyhHkeUgHG3uIZfyHCN2THcZmqT93Ya3qf2QvLo24Yen9uSVe/CzRaO3zNoHaBtHYbIBQzNDm9/wyO/cMX9d3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by MI9PR08MB940098.eurprd08.prod.outlook.com (2603:10a6:290:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Sun, 13 Sep
 2026 19:57:41 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0428.004; Sun, 13 Sep 2026
 19:57:41 +0000
Message-ID: <dbfd28b4-8beb-4af5-a9e2-72a296ce41cc@virtuozzo.com>
Date: Sun, 13 Sep 2026 21:57:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ui/cursor: fix two races that free a cursor early
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260903192647.2677279-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260903192647.2677279-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0016.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::18) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|MI9PR08MB940098:EE_
X-MS-Office365-Filtering-Correlation-Id: 66445fdb-7f05-406d-f32c-08df11d144c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|23010399003|56012099006|5023799004|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NCP7rtFakGThmuktMN/nl+WfrpyuwXeV1AAFK6KaB/K+1sCMfpAHb28X3ZUg15AVL4RfO8w7jj9BF0/IXb28eD6GMQzxkdywLtH3xu/1Of+c5N5Edh37rulj3n78238OLQGBxBTQUu9twA4d1q4bGZrMW0Ez+W6WpjQg6YKSSzhThonPZ9FzyooqOvzfemDodK1YWx+sH2VrrLJJLyTdEvz7hzxIHJp4BRUEbtOKCIy968ifq/vOiEOm3jNj3t6gdVX07bmz+oaTCb92wtA22nBt9+P5am9lis4MLhNY7lSUq39qdKMbkW3gakwuUJgNhOQgalVGS83HKg9hbYrfkafHeUzKy9fhSaIizOwwUyIn43nvt2XzFPP2tinMP36G6p2ERbtxriskc1+TpjlxD0c7AHo+91y0oy5Tn8L3RO2jiuy4z6AG4bYm+afVOVGRiDlYQvCTaJogyQbAk1/Ors1aV+I75ud4zN96diLWU0Yv4XpLFKqMzqAu6NOCxsAAYDoB+ja8fK2AYXE7wnz+wtp6thfxVVZ1Gvu5qHlMKi0gT6btJztRuYhOHTKd9vO7WPihao6YblQCdugUx0Kh55QNH8EEhnmX/IUf1f2AXx2EKa/iQT71V60wF22DbpDyGZpFZX7nX+lfnBpUHaYRKEQDF8ixY9V7XbfANa2rUAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(23010399003)(56012099006)(5023799004)(3023799007)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFvMmtBM3dMQkhiRjcwRUZ5Q0NDSmdYdG94V09aT1QwK0FGbWo4RURPUjly?=
 =?utf-8?B?aVJ6WTEvdXJCcHR1TDFRYW9QNnhWenlQSHR2Q2NreFE5eDZnNG1qMHJsb1FY?=
 =?utf-8?B?UnlvZ0lsU095VFRYMUdqSTJPV1B3K0hMMlJMbEZzTmRTYjVDU0JFbGNKT2w4?=
 =?utf-8?B?NDcreWsxSjZsT1FVSHhqNXF5WEZ3K1REdWZINjV4MDViOC9zK1JzVVorR29h?=
 =?utf-8?B?cEE3UWpHRmlQS1JxR1VzMHlmU3RQRC9kK1FXekNuNXJNcThNQjk2RGxHMjVa?=
 =?utf-8?B?ZGg1MnltelZsQnpyc2V2RGxLS1BWSk9acWRHNXU3dWtDTWpheElSRi9WQXhu?=
 =?utf-8?B?bGE0TUdMVHh6U3hWOTFla0pOL1dXVkxTejZLRGZxVXR1cU9ZbzBkNTZRbGVQ?=
 =?utf-8?B?a0VzN1NZK3B5am95NkxBaUhUS1hzRDErbHBKTEtnRWpoZjdmZkdmUVJiZWRy?=
 =?utf-8?B?OWl4ZEpxZmgyUmRzM2NZMm1xb1drK3g4Snh1VlZhc01nb0l2Um9EZXhKY0RS?=
 =?utf-8?B?UFY4SWpEOFVxNjBnSzF1Q1E1cFRIbnNxVndaTWQvNkNTWTBxdXR0aE5ubHhn?=
 =?utf-8?B?YjVLT3dRU2EwRnd0YkpSYUs0Tm91c3lROEh6S1ZPS0lBQjNFdUFDZjZGejg0?=
 =?utf-8?B?RGpSek5vb0VLdkdBUXphd1AwS1RWalFzd2gyZzlXQTMwbzZtZ0ZzYXpYM2cy?=
 =?utf-8?B?eUV3UENXUnNOenNNNkJyZ0p1OUlxTUhScnRpVnl3TmRyb2JSbm1QMHRQb1pN?=
 =?utf-8?B?RjNjMU5abmFkUytyRFZwSmhaemZXNC8vTFZSZlMvZDNCRDJ2ZW9vZ0tHQnZI?=
 =?utf-8?B?czVlN0NJUFJoeGc5eEJUNTJEM05KY2g1aG0rVlJKYmVJaWg0cFprZnBWZXhp?=
 =?utf-8?B?eXE2RHhXMGxMOXVUdUVyMExLb2dlUHF2RE80a25rVmJmUDRKcndiKzd6eHFq?=
 =?utf-8?B?WXNzblpFb2lSN0lNVVZGRU5NQjVjdStrVmJsZzBiYUFVR0RSN2h2MEp1dlh2?=
 =?utf-8?B?ZTZOVFVDdklvbFQ2YVlaa2RCYlREdThEMUxMTVVKaDdQRWc0aFlqWUFmVkcx?=
 =?utf-8?B?bmZUQUd4V1hRemxSS082WEh2SDRMb0Q3Yk5hTDlMSWhRS0I2U3Y3eGZESEtL?=
 =?utf-8?B?anlaSGsyOHM0SUVOTFFIMWFKRitHUUdSSDZkbjRsL0dwNEl3UncybWV5eXdX?=
 =?utf-8?B?ck12UlJ0L2hQcWpmcDZoY2t0SXNjLys1d2REU2Rud3dvMDFHTkR6aUg3aVpB?=
 =?utf-8?B?Y0FTR0Z4Rm1IbE1NMVg3Z0F5SHhwL3pVOE9sTUhlVEt4czgyL3d1Z2lFOWJB?=
 =?utf-8?B?K1hrblRQazBPeEZobERCS2lvSUFxaEUrdjV6dnQyVkN4dlUzUEpmV1p0bnF0?=
 =?utf-8?B?RmVrOVZUcGFjd0V2VlhMK3N2RHkxczd2UmJtUFpvWTB5T1JwRUNKbnkzM3Rm?=
 =?utf-8?B?L2JUMkVKbSsyS2p1UEF4ZHJmemtCUEFTc2tVQ2VxWHdSSFN2ZGJTMHRha1oz?=
 =?utf-8?B?Rlg2NnFYYjN5am9sOERqNU5iaEt1RVpWdEV3NWdVS2dOUGVGMzBVaFU3Wm1h?=
 =?utf-8?B?Yjk3bUxETmRrVnhHanRCWlF0aTZjTTB5bEJwclBVc2V3dnBzYUlJd0MzZkEw?=
 =?utf-8?B?UXNkdkJCYjBuNW1jU0syQ2I2V1Uxd281R0Z5K3BRd3ZPdWpjb00yREUrY0Vv?=
 =?utf-8?B?TEVxZ3hyTkhuRHZ1WEdVaXAwQ09velZqYW5TUXIveVFkenhwcFJpVEJDa1NI?=
 =?utf-8?B?aVRGaVR5azBBaEhKUlpZWE44Z2FRclhBMExLUVdpb1FJb0YyeEk1WmlEUVNG?=
 =?utf-8?B?VG9lZ1k2N082L1VqVHVaWEthenRod0hHejVPQng5RmxjM2pEQXB5Q1NPQ29q?=
 =?utf-8?B?Z1pMR0ljY0l5TWt6d3VZRHExNm5OaW1aaGtoYUFEMk55eG1YWTdsbU9pMWRU?=
 =?utf-8?B?a0U4dEFRcXBzVkZPNDB1V0JOWVE4SU14M2YxU1NUYmI1UGlCSTNYN0pnSE1m?=
 =?utf-8?B?bTBoeGxCWkJDL211MjhGTWVtNUhQcTl4OWlHRllFTGluSDZmYVRha3d1N0Jo?=
 =?utf-8?B?T1RXN3JQbERIelJpd2QwSFVsYW5yek1HSTJIbC94bngyUWJKZzlQVXRKVEVR?=
 =?utf-8?B?OXVhdncyMDhraXRaU0dvYkJLaS9DQ1JYZS9oNVZ3SXpJd3hDVXRHa2pYbHp4?=
 =?utf-8?B?TWNFcU9VSmo2QmVHdGRxM3poUDYrRVpRVTAxM0JUQXFjZE1OMzJQS1BMSGUz?=
 =?utf-8?B?SVRsWmNIZW9VZ294ekFGVTA3d1pCamN6L0c2LzlqdlF2NWtBbUtva3hMaWx6?=
 =?utf-8?B?Z3JRd2JWQm9ObDFCZksydkxtYWR5TVJ0T1g5bEZxRFBkSjY0ei9SOVVONTF2?=
 =?utf-8?Q?h3Ct2TLqtxcj7Gw1rf0GgPS767c/1hccZirpbBrTxnydM?=
X-MS-Exchange-AntiSpam-MessageData-1: COfd7oGJ3rAUcA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66445fdb-7f05-406d-f32c-08df11d144c6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 19:57:41.0628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7l7d+veaywlw981BaFIy9+NzWIVqB7c3RnBZF3x1E7GptGdvulq3JP5jpiSwaHbXGpW8/uo1aS3FN5HVyX+VOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB940098
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/3/26 21:26, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> A guest with a qxl display can make QEMU drop more references to a
> QEMUCursor than were taken. The cursor is freed while another owner
> still points at it, and that owner's later cursor_unref() decrements
> four bytes of a chunk the allocator has handed out again. Nothing
> aborts and nothing is logged; QEMU dies later in an unrelated
> allocation, in another thread.
>
> Two defects get there, and neither fix is sufficient alone:
>
>  - qxl_spice_reset_cursor() replaces qxl->ssd.cursor with no lock held,
>    while every other writer of that field takes ssd.lock. It runs on a
>    vCPU thread from QXL_IO_DESTROY_PRIMARY and, unlike qxl_hard_reset(),
>    leaves the SPICE display worker running.
>
>  - QEMUCursor.refcount is a plain int, taken and dropped from the main
>    loop, the SPICE worker, ui/cocoa.m and ui/dbus-listener.c, with no
>    lock common to all of them, so an increment can be lost.
>
> A qxl device starts a spice-server instance for local rendering even
> with no -spice, so this is not limited to SPICE console setups.
>
> Patch 2 also asserts that the refcount was positive. Only qxl was
> exercised here, so if another display backend drops a reference it
> never took, that assert turns a silent leak into an abort.
>
> Reproducer: a libdrm program in the guest queues cursor SET commands,
> then disables the CRTC so the driver issues QXL_IO_DESTROY_PRIMARY.
> Unpatched QEMU dies within seconds; with the series it does not. Happy
> to post it.
>
> This is independent of the pending "ui/console: fix use-after-free in
> qemu_console_set_cursor", which fixes a self-assignment ordering bug at
> the same line. With that applied the crash here is unchanged.
>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
>
> Denis V. Lunev (2):
>   hw/display/qxl: hold ssd.lock while replacing ssd.cursor
>   ui/cursor: make the cursor refcount atomic
>
>  hw/display/qxl.c     |  2 ++
>  include/ui/console.h |  9 +++++++++
>  ui/cursor.c          | 17 +++++++++++------
>  3 files changed, 22 insertions(+), 6 deletions(-)
>
Hi, Marc-Andre!

You have not posted the notification that patches
have been queued. Are you going to accept them?
Unfortunately I see your review without any further
actions and patches were not landed yet.

Sorry for bothering,
    Den

