Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD682C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqa6-0006vk-QG; Thu, 09 Jul 2026 11:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1whqa5-0006vQ-8e; Thu, 09 Jul 2026 11:22:29 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1whqa3-0007j3-DV; Thu, 09 Jul 2026 11:22:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABycQhbw1dPW8lS0mftX1MhwmtNbncQXeYSSkinfkXUXA5GjvlGCryih1u+y9tmkQCpXSZmPXhpxw0oLlQW1Ux/s2qHUObFSSOfzrI5jtQ48/MKxMx4vH4n184yVb7HgIvLzpxzWMmLrI7o1CvP7rjRZu86U/IctRhBUW5NAxOhGTfhYxzjLyZ8NmbfNfC4Q8FGVzbBWUB3B4hlzzbB3RMfLZonlCg354XkLUUTRL0hMZ9UdFM5zY1wi9JAu9Hz4ptdusY915RukEh3lpLFJVXsUlVsvqBHy66K0jld46VUE/CTFzrLy+i1NvnpOIw4OLGPXZBMEpK8NAwsfzrh/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpF+GyTJv0y+XkIp6wtMhtCPDtBba5zrvXOo6aKlrdY=;
 b=RmLGr+o5foUPvfkGgNGZTXOcpl4v+gNLaSzIckqzujxd2oIRdd95vfr9frd0jNV946JE+Pgu2E/zQigDY0yMyKVtZJ2qnXQvf6LJtuKo18v1lcOIcryB74cfHqIisUOwzYZVbxMRhovjwpp1Xaw69agB+Yup2xwE/Z6gbm1xfQJVMAjnLoBZLvOdvMqIctTmXiKN7rTZWQGtYELmxu0qfuh1lnQbaIlTzK3pb2XU0zUXcep9Aj/73cgpowuRC4KJpNtjy+7p/GfxTsIJjEnRbJKw1ID3r5FtOUwoWYw63HRayZJPWamfNyXEFebiU4mnd5fXDF5Mjh9csSjF4uUQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpF+GyTJv0y+XkIp6wtMhtCPDtBba5zrvXOo6aKlrdY=;
 b=KXfoSHNt9ZTWOKnWzJ2Y1ifks8hGA0xcuCl5MmQSZ8KFE6hcPmMgxuwK6HIKh+RyB4+nIulUUxLPrpW5LNkrN3I0LdNeCYELYBudf+mddIkHHv6qGfDMJ8gQRHB6RlCwfO9A7h7Wqcg7En43z5u/D6PlWOlMrOWXTmqgGCBaxgfrtgXlQJIpuzxVcEjaDTFdxkAx0ai2rK5HotA6igmBYAYCY0oSzvQs8FXrULHqmTPmOiSvLSYATzTA4kvh9hldVE5zDiqbFCMNki7VqevgShR+wr76UDWrOKX3i0/lCBOlyObQlnPPp5sVI6efv6P1t9DDy7/YPEd2ATehjpPyJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GVXPR08MB11320.eurprd08.prod.outlook.com (2603:10a6:150:2c2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 15:22:21 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 15:22:21 +0000
Message-ID: <8f3c11a9-64e6-44a3-bafb-9ac5d91d67a0@virtuozzo.com>
Date: Thu, 9 Jul 2026 17:22:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/ide: fix ATAPI CD reads racing port reset and drain
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260619112158.304782-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260619112158.304782-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0070.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35a::16) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GVXPR08MB11320:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d9f28d-9773-4b11-e278-08deddcddee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|376014|366016|18002099003|56012099006|22082099003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: WGeISl7ZPAXAmd8jU60ZGKn+8/496+ZgnrZDa7pdeaYrA3qhtw1qIyfWAhQxlqJYN/SwsFEeMphX3YRZfqZaUHZle12+tQRD8GvDqlpdcSqLX33MnmJ8ph1S5IbrWHPiIO2ggdq6EOxzLArkteI0yH7AgvJnVws9J+nDIKEgVmriJXZtZ9rGg/eOg6I78377AhoQt/3hhqXD3wUCnQ425wPj91QKkwKelOjsK5uYtsjki1v1LCUZ7z2kkq91v9X+O9MypPtROW5jPpVqVl25NbisijoMqhpISCoQ2ZDS+vzGtm+VMsx+wsohNmcfZsvTHhbjqCoYospAWB4j8qipMSo1nXC+z0pxdhLItq1xcSm/VQgVXksLBt+Rt8iDEt127qH7NKLNNvzDMgh7pnuC2luA3g+xGfr86BMPRctSwuRUQFEwRDROySJIlvQh2q2U3hupvtZEP5oYz4c9V23UQdzK9EcsRwML4BK0GckfXEgagqWFcLNEt94hYGN4xDQFVibctEge0mf7deu7GV+jrbFi3ozTDKmOS7q4mrSyNsBdWp66cF/zFXNubylQOCTBCeSIMV99WnyfwyBcHz6Yh999aW52pu9ugqbrQw5/rNGu+QFVZ5n2F67WdXAdkYaMCzrbcec79eiKJ1F0AW8C0qYLp7BxsE3EZxj9K1/6yBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(366016)(18002099003)(56012099006)(22082099003)(5023799004)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVJoMzF0UkNaeG5LYjhGTnpuMXdCY0JsTCtCNGhVUHYreXdGTWMzdlFkRWZs?=
 =?utf-8?B?MU9mTTlldmJTcnR1NmU1QytaU0xBMDFpZHRuR2FLQW11SzE0bmpWQkJxQ09Y?=
 =?utf-8?B?NW55eFIvWHVDRTM5TVdwWjhpMmNwZWttUVErd0VtRkV6bXhJY3pEZStWRHFO?=
 =?utf-8?B?S2tjS1F4NVlGa1hHdUNOcGdkT0o4K3ZYdVg0b1p6OVNORnp1RHp1djFZTWx2?=
 =?utf-8?B?QUh6c2Z5YXBldVhnSFptYXBvYWx1NW1zb05oRnBSMUIrN0ExdUJQMHhFZTZ0?=
 =?utf-8?B?bURpRXEzSmNWb255SE01NTVwU2NNaGVwZ3NicnFZa2xBY0FjSUlHUHdWT3B4?=
 =?utf-8?B?ZDF0SXVBV0JiSTRobGVoU3orSEF4U295cjV5cnd6U0tXL3JTREFGRkVlbnAz?=
 =?utf-8?B?MFQzRDF2Zy9IN2N3KzhqQWZQWGR2RS9kQUpnWXo2SmVsZEp1d3ZqRm9FYXE4?=
 =?utf-8?B?cVFGMVRmMDdMMlBzaXkrWEgvOXZEU0gxZXByZ25aT3lERzlHRklGRlg0YWZp?=
 =?utf-8?B?enE1Y1djOW9tOXZZanpTNS9YTHBqZ2FhK0Y1blNuQ2tmU0RoOUx6VWI5MUlZ?=
 =?utf-8?B?N0RlQ09ycnJ2QnF1K2hVeHhjUFNPcW9NRmxKV0VNKzViWnpnSFhWbkxoYXFv?=
 =?utf-8?B?QXhNUkd6Sit3Mm9IUzJra01Jc1poWXU4bittWjFVbEtSS01nbjREQUFNTjBT?=
 =?utf-8?B?OUdDMWp1bzZyMzdUNExWWnN6NGFadU1sdXNqR1ZUZjJsL3ZZYzg2dCtRRXZ1?=
 =?utf-8?B?NUVjdUpKVWoxdFJJUkRYN3pwUkovS0RmYU5JeWVEQlhCdnhneVZUeXNxZk9t?=
 =?utf-8?B?OFBKZlBERDRiZW1pZGFrZG1hT2c4ZVVEQklFZHp0blIrVVlmdTUyNmJlaUIv?=
 =?utf-8?B?Q0FYWU1wK1lZK2xpZGxLWlR5TkVQOEJwUUp2d1NpMTJNQU80d2pLWjdwRGpV?=
 =?utf-8?B?S2VpL0J0UEUyQktFcEdDUnB5RnRiMWUwQ0ZhUlkvOFhEN1VpYmx4aXFKTVBI?=
 =?utf-8?B?QmUxOVdCVU5mcHZGT3RNenVoK0RoUG5TOHg1MXBBSGx0Q0k1OFV6NVVmVDY1?=
 =?utf-8?B?SkVSTmZlRjZmV3BvdDZOKy9aWFI2TktkWndScHdVbk5MRXdGWE9SbTJKWEpz?=
 =?utf-8?B?Q0ZVSHRtRWhVekxqYU5BVGNEZ09nbVFnNzgyRzYyNUt2TUxzeFN1OGtRZ0Rw?=
 =?utf-8?B?TjR1c2lUN1ZFK3pxWGZHZjFmcitnUzAyWkM3TEQ2T1lZRFFwNCt1Mi9QWkpK?=
 =?utf-8?B?QmlpbWxIQmpwd3VpbllhYVZhZ0g3NEtDdU1GR3NMVHFtTUp4UkNjMjJTNzdN?=
 =?utf-8?B?YnNER3lHak96UER4YlNhRm04eHBob1dSNHVST0lVTUF2K3Y5WHEzTmkzYnI4?=
 =?utf-8?B?enlVSE9WOWlMVEREbjdoVTVmWVRuMEZyR1VnZ0c5QW9RcHlTOUZva3VMVGRO?=
 =?utf-8?B?L3lmSUx5R0ZTczA4MWZCRVdHTTRGb0grMDFyOUZqQy9IU3ZCNHhsamsrOFhr?=
 =?utf-8?B?RWpzRkhNRWoxM0RpRnl2S2g1dEFnbDFNT3R0SlJDRzB0OVhjV3IxalptT2kx?=
 =?utf-8?B?WVlKSktUSzVQNXQ0ZEltV1pmUUdCZHpqemhrWlFPZWdGcm5JaEZ4ZUQyUnEx?=
 =?utf-8?B?SXd5aE9DWEZacVRvTFJqNzlBc0UzZ1hFdHZGMlhXSm1kSzBkQkduVGNuT2I2?=
 =?utf-8?B?dDF5ZzRhelZIbGNPb1VvR2xLdE1Bdkt5SDBLK0ZGMXRQTWg1OFdxTGNNUC9U?=
 =?utf-8?B?cEtJdDdmMW1keWZIdHVtRUw0RVJ4RDdGQXI0S0UxY255Mlp4d0lpVzVBT2V0?=
 =?utf-8?B?enlnMHFNWnJQYzFOeDAweUxTOXU2WjIydDBiMTF5UkJDcXkwMm1PdGxSSS9F?=
 =?utf-8?B?aEhqcnlWMFpQZkNScWR2TnVMU3BlSlA5YXUwRVYvNXpJVmk4UjRXeHFucmto?=
 =?utf-8?B?VmlucmVhRFl1TXJmUzJHaFJsTDl2NUZTZ2plVXZLZ3IycEd3L2pMMTQ5TXNp?=
 =?utf-8?B?WldhTkVQc0k2ck1rTlgydW5DT3VoRFNJakR6U2hhVkJPZEdISjYxVWZSREZz?=
 =?utf-8?B?SWttUEVoWU8xUEpnMlR3Q0FuZzdKN1FuQWV6MjltblF1d2pDNXh4T3ExWXFQ?=
 =?utf-8?B?UnlIdW1PeVFWb093c1d3SzF6Yjdzc3JFdXFNVm1HZE9EUzJoaTZNS09vOEhq?=
 =?utf-8?B?NzF1c1FRN2Fib295c3Zrc1JGRE1udE91UHEzelBmUHpUTWxPN2gvSnhNUXNC?=
 =?utf-8?B?UkZlSFVDUmxwVFVFYmJNbUEzSFBUSkFnb2ZoVlFKR255QWFKVWxVNTBUMEVT?=
 =?utf-8?B?RURYalpKZDFOaXdBcTFJelVadVQ0RVlXc3hLZjR6QjgvMDNkZzNNUHk0ak9o?=
 =?utf-8?Q?rQQ0n/dmZ6NOxdWsR0JpnZ8tVQiNxmct32hsuKagYo7LS?=
X-MS-Exchange-AntiSpam-MessageData-1: nuX2we2kNda9vA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d9f28d-9773-4b11-e278-08deddcddee8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:22:21.2850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAeImbw9//Fw3hEbwi97HxbrZUKOlU3NP6XQcxwnWo3BhObDQfvWvHFV0aaSzmEeLW5vYBEfPqVy3IYod3tpZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11320
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 6/19/26 13:21, Denis V. Lunev wrote:
> An in-flight ATAPI buffered CD read (ide_buffered_readv(), used by both
> the PIO and DMA reply paths in hw/ide/atapi.c) can collide with a
> concurrent port operation, and it breaks in two distinct ways. Both are
> guest-triggerable and reproduce on current master.
>
> Neither was found by inspection: both are real issues reported against
> the qemu-kvm 10.0 downstream -- the crash from production, and the
> deadlock from the downstream live-migration validation suite -- on
> CD-ROMs backed by high-latency network storage, where a backend read
> outlives the guest's SATA command timeout.
>
> 1. Command engine restart -> NULL-deref crash (patches 1-2)
>
>    A guest can stop and restart a port's command engine
>    (PxCMD.ST 1 -> 0 -> 1) while a read is in flight. The restart re-maps
>    the command list and clears AHCIDevice.cur_cmd, but nothing tears
>    down the outstanding read; its completion then dereferences the
>    cleared cur_cmd in ahci_pio_transfer() / ahci_dma_rw_buf(). This is
>    not the COMRESET path -- an engine restart does not run ide_reset(),
>    so the drive's transfer state is preserved and the read still runs.
>
>    Patch 1 cancels the outstanding I/O when the command list is
>    unmapped, reusing ide_cancel_dma_sync() exactly as ATAPI DEVICE
>    RESET already does from the same MMIO context. Patch 2 is a qtest
>    covering the PIO and DMA reply paths.
>
> 2. Concurrent drain -> main-loop deadlock (patch 8, repro in patch 9)
>
>    A multi-sector PIO read whose byte-count limit spans more than one
>    sector must fetch the later sectors of a DRQ burst from inside the
>    completion of the first, asynchronous read. cd_read_sector_sync()
>    did that with a synchronous blk_pread(), which queues behind any
>    drain in progress. When a guest reset reaches
>    virtio_blk_stop_ioeventfd() -> bdrv_drain_all_begin() while such a
>    read is in flight, the nested read is queued while the outer
>    completion still holds blk->in_flight, so the drain never finishes:
>    the main loop wedges in the drain with the BQL held and every
>    QMP/monitor operation blocks behind it.
>
>    Patch 8 reads the whole elementary transfer in a single asynchronous
>    request, so no read is ever issued mid-burst; cd_read_sector_sync()
>    is removed and the DMA path is unchanged. Patch 9 reproduces the
>    hang via x-blockdev-set-iothread, which takes the same
>    bdrv_drain_all_begin() path a guest reset does.
>
> Patches 3-7 are the test groundwork the deadlock fix needs: they fold
> the IDE CD-ROM read tests into one parametrized helper and add the
> previously missing coverage -- multi-sector DMA, and raw 2352-byte
> READ CD on both IDE and AHCI -- so the rewritten ATAPI read path
> (including its in-place 2352 unpack) is exercised on both consumers.
> The test patches pass with or without patch 8, keeping the series
> bisectable.
>
> Patches 1-2 stand alone as the engine-restart crash fix; they are
> included here because the deadlock work shares and extends the same
> ATAPI read path and its test scaffolding.
>
> checkpatch is clean on all nine patches; the new and existing IDE and
> AHCI qtests pass.
>
> Denis V. Lunev (9):
>   hw/ide/ahci: cancel in-flight buffered reads on command engine restart
>   tests/qtest/ahci: test ATAPI read completing after engine restart
>   tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
>   tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
>   tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
>   tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
>   tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
>   hw/ide/atapi: read the whole elementary transfer asynchronously
>   tests/qtest/ahci: regression test for ATAPI read vs. drain
>
>  hw/ide/ahci.c             |   3 +
>  hw/ide/atapi.c            | 180 +++++++++++++++-----------------
>  tests/qtest/ahci-test.c   | 201 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/ide-test.c    | 211 ++++++++++++++++++++++++--------------
>  tests/qtest/libqos/ahci.c |   8 ++
>  tests/qtest/libqos/ahci.h |   2 +
>  6 files changed, 433 insertions(+), 172 deletions(-)
>
patches 1-2 landed via Philippe, thanks a lot.

What about the rest?

This is real obscure problem observable in production.

Thank you in advance,
    Den

