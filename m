Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D2BCDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 23:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wctPY-0008AA-0K; Thu, 25 Jun 2026 19:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wctPV-00087g-Nm; Thu, 25 Jun 2026 19:23:05 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wctPT-0001fW-Od; Thu, 25 Jun 2026 19:23:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8lxkb+zHlPGxYHiaqs4w+BhvCs0wiGR+0AjZwXaj6oHYkM7rV5bx1liSzD8lPcRxOSsTLehaZuA/7M27OwJldRL/VyhoCtxh6yfnuBnj4qr6V21KiMNmA7+JtWTnMH36TzFidqF6nbErEMIgBo0NMjerfcMzSGsKMOUjC6SIG91H/pvDA/RhKxgaBzlVYscSP4rdMUGojYPX4toJzIQKf8nwXmg7+RmvTQqVidtIFweprfArVqN4gKDKpeicDsCkMqRLBjtrZ8efyPcvoxmaHEqi1b8YAHwGipcIxCU62GN6XMUhn/74LoPaXCOzjJrtyDLbWAq2XBUqpgmtTDjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Zc85MWHGeKNNPwBFWJ4RDM6qI753bPnF1BvcTUt4qg=;
 b=cPSomPoUYJ1Pjw6/iYoWcLQWVwHO36tbhjK6kYbfE0pIz7++vDyoXkyKrVFjzIObvNfOfErolU8bZ5LyHzH45cNCxhGlk8nosft4w6kIZ5h4xoiFst5+ebc60bTO0fWO1umx08M7Y66vQ9Et+LRKcg5AifrOjBZ5hH5Yj9GQ2jeIeLNQr5CGUJZC+PG4c5hqsCOpiFgi/SJDHoq8DUCWaLwj+O5WELeXYCEHqlsnvBfPKwqWVT3d+2x40eBmP8zlHXFxNn2pUDayxuCtkIVlPb1PJIMT8Z2C75rGDL1UTmQ2MDUny5EBqs5ttOp1pRp9ec5dHJfWSkysG80mWGXaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Zc85MWHGeKNNPwBFWJ4RDM6qI753bPnF1BvcTUt4qg=;
 b=eTd3R2OFxS2HxXXSey7ik34CWHZnYLO9qSefqDQc+mjNxOGjcEnvZLZzz+zW8w1Z7IcsBJafbczo254OullJ3KZYzDoftX5Lgkg6ENZ3GWQVcOdRGIxwegTfF/T2g7gJfFy7QZR6Q6WgGTl831LhB1ux+pIMv6OfVqcwihoVqzzUhLGbkM8MjSJ5anaWHUhcZb4wypCAyJYUXP4AV82IuWdgH/a/24wjZ9cnZESyq64VoMtMSduZ8w8/g7hJYx3W+LzuOKCLdLF04GGzV2Z5SzA1/3/PsEJU8+/RcKbu3HRKJmqgZPba5GaAlCXsX/DRiX0d4D85Rpvv8qAlNJhwAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB9528.eurprd08.prod.outlook.com (2603:10a6:20b:61c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 23:22:54 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 23:22:54 +0000
Message-ID: <6f428b9e-812b-4a6e-b27a-77fcf349e5da@virtuozzo.com>
Date: Fri, 26 Jun 2026 01:22:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/ide: fix ATAPI CD reads racing port reset and drain
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org
References: <20260619112158.304782-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260619112158.304782-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0201.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::22) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c828ca6-0a21-442c-647b-08ded310af1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|10070799003|1800799024|18002099003|22082099003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: QDlIbv6JzxiYLgHWs4ezbVsFY/jLNVHjNX78OnjpL+MS+3jfNNnkxRf7uPxhY/I+x70Mto72G4hhYr15e444myL+dr4pX/lI3/gszUVEH2dmm28b1jYfwtoj9pYFAy+mA+BQDVv5/epqnkRpt0tV6vWJ20/4yHCWzBbpOrWP1Y5mjZbdiS00NOgku/dRHbgjVKh1HJCSYgYhDm/Ij27zDiQbY51sS+s5KMY7UIr6aOKis09get5n5wRkNvhPuU+xVbCRgivYW+Tz+4oxMO/eNMnOvEbmEba/Rsqnk9YU9+vCYfYUdKsweF6+fb54J48o1FLNOpWgLGKsrUgADhB18xAp4yogpuBzr9rPmcn6yj2EBoYjt99uH/A2UowXYo/iudGs6ZY7g4ibGFDMreHcr/RByod762RonoE/+erCHpLokMBqTKtFQPjTBKs+V7m3QLwXHogfF3caR18RIJYGPboRtdQX5Db4aIYXqj28T+Vq3xE2u3Vf/ikEH5PvBNyrMuxpoRFVUgmXDrUU0RPSYmQYmK6LTc4TeWBaKQg24rEioyGt/AAcgN7lN51Veqmflq0jbtC6lRTVyYx3F9EK0PUSnDWKgEAituAhKxvSMgvZtXuW236KpM0SD3SYsYyFE8iAvhj4gE8rs1j46FQVuy1PAEJaPNVn8ynCg8BVA5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(10070799003)(1800799024)(18002099003)(22082099003)(5023799004)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnBKdU9udXZOemsyNjI0VkVKZ1RvbWxTQlcwanlsbFFia3JqTmoxY2R5QXRE?=
 =?utf-8?B?YUZIWnVKNVZhQms5QUhuWS9XVGJMOHpNR0V4QnlKTlpsbXdoOFEzbE13ZU05?=
 =?utf-8?B?MmUzSWd4TFIvVmphUW43ZFN5RUtjR0VBUGNNc0l6aXp6VWJ1YjhDdEVzbmxu?=
 =?utf-8?B?MjdoY2hrL2Z5bGowd3I4VFc5bk1GRWNOSytBTTVpRmRteUhBWVZmeEhUbGR3?=
 =?utf-8?B?ekowQ1Rla0N2VUgzdlRNeEo5M096b3c3U1FPMGxVZ1NNOUNDcEtUQk9hTkpk?=
 =?utf-8?B?MkY3Z3dGM2dHejJtN3RUK3VuTzV1RUdSVUhFSkRZSU42aUVjbk5hcFVsajJN?=
 =?utf-8?B?VXJVamwzeDdKWFdlaHNndXFBby9RcitMTFo1R2ZNUW9Id1hFR2xMMlQ5Q3Fi?=
 =?utf-8?B?VndjVXlyVTRFWkZiRmJIOTl3NzFrVEVzMEhqRXZCRnA4Z21VOUJjckFJVU0r?=
 =?utf-8?B?MHovWDVUaThvT3EwVHdtWmNhMnVySkVab3RCMTgwOCtROWlqSDRvU01nbnlJ?=
 =?utf-8?B?aUhoREFydnFhMU94Q0RlZm9UMEoxMWMwemRXMG1obk16OFR5TlJEbFZBMXBQ?=
 =?utf-8?B?ZzRHVDlsWkFjWWNkd0ZzcFQ5M2ovK0tRYzdlVDNGcFdGclhxRzVoZXU4eUhL?=
 =?utf-8?B?RUVEZllrWlRPVDRFenVOTDRtdmFab1JSU3hGVUdFWWQ4dFRLU3IwRDlvSkdO?=
 =?utf-8?B?dUoxUSs5SW9YL1l3WFJZbGYwTFd4WVh0Vm91bTAwQTFXaGFuandKWWExWGEw?=
 =?utf-8?B?MDFtWVlOYlJpK1hEak5ldGN1N1A3L0lFOWE3a1h3VmJPL3h2NkNzYkoxL0tC?=
 =?utf-8?B?dHVOa2FhNXNzWFZCQnRFYjBoNlVoNzBYSGNMeG1oZDdmRWZoZUhpMjhIeitB?=
 =?utf-8?B?Y2dobjVGTXdYTkRMbThGUnFQWC9kZ1pocSt2RU44cjFzVyt3anJNaXAwUW9Y?=
 =?utf-8?B?SHJxcUtudnppZm51RkhJUEw1eDZuNHc0RDRSbDBnL3F0S2w0NTJuQ3ZoOXJS?=
 =?utf-8?B?UkovWWJNYjNWYnpDSzV1Vzl2d3lXU2xjOVNPK3NMN0FudThNekpQOE9JU0tR?=
 =?utf-8?B?M2FkSDhma3JLK0FjbzdSUnhQUEd2Ry9ISUNLZGNMMURmNzdKZUtMZkFxTGg3?=
 =?utf-8?B?ek9NUCtjTXRCdEpId2cvQm1pYTNCMXE3N3UvdXNYaHN3TFV0VUxLSEdMdHN1?=
 =?utf-8?B?ak5qRFdOTnlMMS9YbDRXVmxKeTlBbCs2eXVNL0pMbVo5RU9KNGl3Vmd3dE9i?=
 =?utf-8?B?OHBueGhId0FibTE2NTlZS0x1eU5TN0luODF1UWVvNmpxdEEwOWoyR2h1WFdq?=
 =?utf-8?B?bjBrdXo2akJYbzlBdnV0emo3VWxaK0NoOFVBYk80bWplUmJQWlpKcUpEYkph?=
 =?utf-8?B?N0k2cHVXUEpEU1doU05iUE0zNldkMkFWSk5lRmFpbWdJUlBtNFFrS0szL3lZ?=
 =?utf-8?B?QzBRcHU4eVpRMytSeU4wcjg4eG1pS1lackxUSzQ4UjRsSW00ZWd1a3NnYVlv?=
 =?utf-8?B?azNrM0xSS2lOamZOaEs4YWdIMER3YnB3VUlJNGZINGM3b1VWUU1aWDFYSkdx?=
 =?utf-8?B?R3pPY3VaYUZyQVpWL2dsRlNFQ2Q0UzVzRzZHaDBlVVNHK0tHOUhFdFRka1VD?=
 =?utf-8?B?THd2UzFlQ0lBUW1kOHUwU2VOSklmY05kbVY2S3Exc3FXcm1JSlU2em1KdDZI?=
 =?utf-8?B?UW5CUEwzTlNQaHJWMVFGM3RTSnUwN3gyV2N5NnpjdkQwNUdZaTY1M2x2cG44?=
 =?utf-8?B?Y1RDdFNFdHpBL3ZOdzNsMW9keWxTU1cwcHNlRXpNQ3J4d3poVlpsVXdoUys0?=
 =?utf-8?B?N0E4M2dkVVJVemFyY2hTSElmNlBKSUczeDlUeFBiN0o0N1BGcG83cXNsVGVD?=
 =?utf-8?B?VE9lZjZzMUVrK0dMWVBSNTVialZOZVQ2ZGNTQnFQU1F5ZUkydk5FaEdJbTZv?=
 =?utf-8?B?VnB5MDVqeDFMTTlZRXVKeEp6Ly9xUC9jcnRYbExRQUpYdDJ2dGN5V3E4eFpG?=
 =?utf-8?B?OUQxU2Z6aCtpa3NKZFp5Z3VRTWU3QXVqcjR5RjVocXJ2bHFKTUNPckc0bTZ3?=
 =?utf-8?B?RGlHK3czbXd6eVJISGNaMURDaHpEZWJ4OFR5cXE3VzFUT2hEd25BenRQT0pz?=
 =?utf-8?B?dlpTbmlqK3o5QlBCWnVkb3QyVnlrWUlUbXgvTDhZd213NVpHVWFYMnA1cm5n?=
 =?utf-8?B?M1RDMXFQWnZTYkowU29tUU5aYVp0ZWRDUStmVGtkUW8vUTEyb3ZJb3I3VEdj?=
 =?utf-8?B?Q3FSSlduRGhBTjY3MDVSa1hkN1pvd0RqYU55ZEw1RkZkdnZoT1JubW5xa2FN?=
 =?utf-8?B?Y2o1dFFQZUxrMkJGS290UXg0aG5oVGxrVGtoVHZtYjBmYTdtWHlMK0lrSUZL?=
 =?utf-8?Q?CYtij3Aaa1dN3GXvr58v8GFbgbllOVuZ8hzUIr6t21wCs?=
X-MS-Exchange-AntiSpam-MessageData-1: zwGpxDTwm4bZog==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c828ca6-0a21-442c-647b-08ded310af1a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 23:22:54.5571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXKS6W6t13AJfkn8ohMMyxBxvYAt41wzNqXd7whgaosEiNcsNzUEhdKdbrtQ69wq/rXk0BysC7NmMVNNrNQTiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9528
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
ping

