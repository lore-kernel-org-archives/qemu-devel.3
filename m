Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B0DC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLVG-0003pf-HC; Thu, 02 Jul 2026 13:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wfLVF-0003pM-Q6; Thu, 02 Jul 2026 13:47:09 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wfLVD-0004kJ-P7; Thu, 02 Jul 2026 13:47:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heq6vq3CCY35BmNs6bujgrqOjm4dUQJj4OT3gqaLVuEB5n6CprEcI4E0X3+vpDMX8lDjX2dYO6Wqz2MZ+wDjsBee9NfjCrNiBit87LtgZtxCQvQf7Bt7SgpXlJK18hzTJUy5VqDUfg5lupprcZFHNLXwBNF7/L0kefiQSf97Lp38o7iPXYn0neduYyVZlpge9DBiI3fx6KCiYaMoPl3pjgQPlwr/q1B2+5h/YPspP7nauBAxgFboL8zA0E5p6U768Ky1tbSfZkLjkjU7/l1PVTp9Fr+4MMk8d73K7vAfsRrZI29YWYNMMACB8TzEiei/fYBK82e5su7rf3Ct1HfJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc3bmRXOCfF14s+PBOFPlNXpH6aaaoV+t5BWXqxVJPI=;
 b=UTetpYix5JlSUGpqKQOiUhUyhk4nNWPdkfM/DuujpyQYkGIIQVMIntBJO8EiOEQbU7asohONDDnAVVACro7jfLcdT3kmcg4dlgxyKh/vGdrtT9H5nOxBJWF/uEu4v3HC7RB1D523fPL+zLeeZrDgyJffyB84VC/zoUKWVRzeqoPi78jKdWge/2AOhqHGFM74Rh2hFU+N2W/UMA0bIKrDd4CKCt5JvUUl383EwJviBT3HPN955YYQKP/HtfmubHQj3ZahJ20RGJrwMqQMN5a/wLAEzLchkSm+TEqE5crLzUBLZGNXwfEklRO5rD4oE5xpKKL7nu9c/asMuYWD5lXaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc3bmRXOCfF14s+PBOFPlNXpH6aaaoV+t5BWXqxVJPI=;
 b=u5WkWuy8YdFnLWd9aYGRlWE7AVa12WpXRTrcTgMQOkHQ54V8wQJKZURwIYxC9CGh6yoG935BJaF+0bRdrkdLDxhISyI8CF6Cgvt/nqpB/ax5DP5tXumQ3Pu0pryj+ONIXOTKMvi4hVvO3mlsy+xDfJ8qWxFUtHQiydHsgiUSjjw3xoo0nD67yqbarRMoGpnZoX76Ocmx5fo2KKu+HkIvvnd6qQIhuTj14SwALTT77+AQ9xcaCXnrPGEBcJhLEgyv07LLj2HXTVRS114lukEBd8rF2elbm6Vive/D9JeqF1/RTD5sQrPLOqz4QHCPyZlDtXA06cSYSEFN1gsrdRmv0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GVXPR08MB10431.eurprd08.prod.outlook.com (2603:10a6:150:15c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 17:46:58 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0181.010; Thu, 2 Jul 2026
 17:46:58 +0000
Message-ID: <f076a5e4-2ae4-4322-857f-d8224522dced@virtuozzo.com>
Date: Thu, 2 Jul 2026 19:46:56 +0200
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
X-ClientProxiedBy: VI1PR0102CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::42) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GVXPR08MB10431:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf2366b-51b1-4364-1b94-08ded861e9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|23010399003|376014|1800799024|5023799004|56012099006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: hgk/SZ/HPjpKo0ib5vPPUTnnaoZB/Ckb6g4aj71fOA6CRCMVhNFH5CXMBfqwAn9qTOaPYyLRLqJlFGirrwULlXgeeAzcoVQXZMqgegBMQp1lv4/E9uNHsSVt7Zy7v++4fgBUi7KZdO04Ykczstsrgn4Wl8hChTnxQvjsKS1O3s/HVofse2w3JSZGkLTw32NFUUQCvTxzZLMhy1hYExM3R8fIqSXEwzBtbGahYbagjm4gOyP6ThIk5LV09z7p0dTfAcGQ8eJTreUNdPhQSvtLHRxknpuzPn1mIEE9LeA6KtuNf0W8Nsi3okvcn4H6TpuE1VlMb6zKjOwlOJRYW1nacU5w0i1ZgOj61gw4MLX5B3knfQ4sUxVPwW9oeNV7cGfJ2cB8TbZotZdDzIXH0/nV8jGQFUPVQsFFbF9BUhiDUWZ0bXUn82fthD9oO48gbWL2VJDbvl9KbcpPADyr8pKuM1aVyrU+YquNGE2vfcWVCg7ZZoWS0gttHncZUZgpWxMPDIzbeKHfn/fmRHDwHrXpvoZ7UzwGDYvU1o/QpsLYt5fINikRl56451hzjz/drQcyDkIdk4B2ADvWWaq3UyVcoNxd9UPM5GzdvYuoHsU80n+Vbv6cbeTxogSrZqVWhjhCadRvcj8vOxvnQ1k3BgnBaLduO5cltlP1qGKcwDUM+W4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(1800799024)(5023799004)(56012099006)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVNTbm90dkdiQVo5RCtWM0hCRHFDOWNwbCtHdHU5ZkhXaHkyeWhtb3VXZGYw?=
 =?utf-8?B?ZUtoYXVFWDY2QW43SVVOTGVDVHUxM1lsM1dTMmZQOXFVUVZPSU02NEQzd0Ja?=
 =?utf-8?B?TzJIR1dXQldIbkJkYzEvaTFUcXp0NzdiMlE5bGpDaXFmV0EzR2FhdzRvSEIz?=
 =?utf-8?B?b29CN1VRMnRjUUdqQXpid291WkVCbGk1RFZ1RVgydzFiQXp2MnpzcDA2MXIx?=
 =?utf-8?B?WVJVcmNncFBCK3lZamk2Q0NFdThFRXlRckpHTnltZlhZcHllSW9acnJNUzg1?=
 =?utf-8?B?RWxOYkFTakRZUHN1akp5SUs0azBlWlg0eGhsWkhqWENHSVJ4TUxBK0cyMmp2?=
 =?utf-8?B?Z01mVlIzM2Y0YUJJdWpYSjRsZnZiU0NlaXErS3RUbnUwYXNaVVBZaTVRMVpV?=
 =?utf-8?B?NE0reWtiZktwY3IvUTgxWnZ6cENnRzhpZnRHN0RYcWpYRkk3QjVZWXdMcTVX?=
 =?utf-8?B?NEYvVE9ldU85VzI3VXlkeUNRWnp6RTYrRXpnRWx1SFM5SnVlZlpMRldVc3Ey?=
 =?utf-8?B?TXlKNExYekxxMFB4LzllaUpDNi9nVDMxOURZbEF2amJCM1VRbGduY3JGRlkx?=
 =?utf-8?B?alhRWjJnYWdkTzhWQnJEUkREb2xlc0tUMjE1eVB5NXpPa3lRdnJ0eXR0TTkv?=
 =?utf-8?B?UlVMU054SjdNcW9ydzNBWDBOZmxHZG9zLzVhZGlBc3M5bTdwR3BBZnM5Z3BL?=
 =?utf-8?B?R1AvdHE5Mmg0UmN3dEsyTHNKaGZ6dEZGc01Wa2I4K2kxb2czc3V2dzFCRzhF?=
 =?utf-8?B?RTdaM3pzbVBMNzBEbkF6RnRxNnNPK0IwTllieFpVbzJjczZNeHpyNTE2dWFj?=
 =?utf-8?B?TGE5T1VGZHdzTjlJMU5vUzgzZ3MyRDZxMGFSY29FVWZhbDZ5ZEdoL3Bac0tZ?=
 =?utf-8?B?R2h2U1RTU0RPL0RWZEdpTE9IMVZNWFdRRmRINXdhNXY2TWtXcXJ6SkpmSllm?=
 =?utf-8?B?VEpUNEs2U1pmdW1YSzRwQ0Mra3paYmEvaWlDSE1rZUorWUVsSlJRL1NMZ0k4?=
 =?utf-8?B?NTYvRGFLejdNaXdON0gwQU5SLy9TZmdweVR4UjMwNXVLNmxFTjhOQnM5clBa?=
 =?utf-8?B?M0N2WFdUV0FXTHV6OVVYS1hqUlkyQjdTU0dMam50a1hncHErRVUvOVVGNjlZ?=
 =?utf-8?B?Y3JOSzdzVWxUK0pHNFFZYjlqN0pDY3lScDhFRU5DaXU2U2gzWlgzS2taeENX?=
 =?utf-8?B?ZkxkdVBoWURaZkVoUERKb2RXdS91czE4VjJlVnZqT3hYaDdWVFZnODE2bHM0?=
 =?utf-8?B?ZGpoVXVJeWNtaVAyT0Ezems4VVVDWWtaZW8rWWF2TWhKZUY5czUrZUowNnp4?=
 =?utf-8?B?SE9hYnE1YklucksrN3JFYmNxQ2RlZ0VoOGxFSnN0L3ZsSkw2d0Z3NDM1d3VT?=
 =?utf-8?B?aDJVdDlGWklhK2tyYkJxMGtNbkg4bmMyazBlYUFxamlaU1AzVXFGN0dIYmo0?=
 =?utf-8?B?bm5aU001NHRwZGZIUlZoajIrcGlXeG1tRWcyNXF2WkE2NGxDMmo1WFpPY21w?=
 =?utf-8?B?RDAzTUF1UkRmWHBWOXd0NFA1TitEdEEyZEFSZzB3YnR1c2tzcGtZeG5oaGRN?=
 =?utf-8?B?WHAxME1sUy9DbUt6cEVPZ1VTNXpzSnlPUW1Dc25IaDZST0VkOTZ4TzJiYzRt?=
 =?utf-8?B?eDQ5YkphdXNjdGRjQm9ybGN3WDhWUGczaXdmTUZxYzg5ZVF6NzZvT3pzc2dV?=
 =?utf-8?B?eFVHRjJpTjk3bWViazlhb0ZvWXY1TjBYZGEvcnE2T3JUaU04cVMxb2lWTXZR?=
 =?utf-8?B?b2w5WUNQUU4zOUhYa0htRFNjaENZYzZlRzhoMXQ5OGY3ekNDMUZ4Y0tRSEZv?=
 =?utf-8?B?SVFWNWFHVGJ5RFAwb0xyVGs5RWRXN0JlSS85MUdadjJJb2ZFY3Nma1lGUC9o?=
 =?utf-8?B?V3A3aExja1hlb1RxdHJHL0dUL3I2eDBNK1FkRC9RTzNHMmNSaUN3N29CdCs3?=
 =?utf-8?B?dlhzdFZXbEVGYkV5TTl6S3Ara20vek8vanI4S1E4cHZSUlJrYWxvSjIxcTJW?=
 =?utf-8?B?V1Z6Qk1XSURvc0RvcitCRmo3YVNxdStuWCs2YmRXcldTbmo3K1ZNNzdrcWhz?=
 =?utf-8?B?b0xvdlFZK2hKTVV4NUY4OUxTaGNpcndZYm5iM1IxZy9vSXUyNThzWFBwZ1Q5?=
 =?utf-8?B?TUJGZFI4YXU2WVNCdUF2S0htNVpMR0FHbk4xTmthSndrSC83dU1Zend4WVB3?=
 =?utf-8?B?c0ZiRUtiYWNNdXp0c2xZYlU2RzlvaU8wM2daajRUdG1SYzZTMmNJQUk1YW5G?=
 =?utf-8?B?NFZBQjdyNHd0RVBFRFlhQS9BU1UrQk1FeHdhZEswQzh6RENNb0UzWDMxNGhR?=
 =?utf-8?B?bHF1V25lZis0WW9pdnA0YzZ3MVY0bHlWbWt3QVR3bTh0Y0FJU20rLzU4eUQy?=
 =?utf-8?Q?4WpLmzQUyYrkMDfUqhxoOaDQnJHXZCHDXe/RlU7ds1Fir?=
X-MS-Exchange-AntiSpam-MessageData-1: pOjImnYnAgh1Og==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf2366b-51b1-4364-1b94-08ded861e9c9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:46:58.0954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCxtApyMX+4SCCPgDd8RJ0yM/R08A1logLc+vUOMydsN3yMTIbgy7CsDQBn/HHp8+xvyFlKvMaQug/BJUg/uPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10431
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=den@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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
ping v2

