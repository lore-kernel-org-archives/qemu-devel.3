Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C699C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5gV-0003D0-0F; Tue, 07 Jul 2026 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wh5gP-0002tq-N4; Tue, 07 Jul 2026 09:17:55 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wh5gN-00011w-Ay; Tue, 07 Jul 2026 09:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMHudKWp8Hrrx1m20omrReLsgzpV4P71Fe6j8X+Kn4cBR1S29+VRM8597bHFLf+IX50GRMUHoeB7Ep28MytlvNEBfS/GYRH3xIYa/Z1FtVfaNCEEDTWYQZ6mDEV5rjQH2w8Lkehet3y7HJXLfCtnwWPXfKou+uGP0dUEmty7ieism6nuI7ztIZ30azDeru63tnDZ1eiLxKBnen09B9r9a6o4PKARx/wwb5pnpA8NrTx7+minylj85JVyclauhDyhO8cI4EL3C8x8D+zSG/jAO3G7RH9+af12+J3KahW+ZHWYhZ8r+5fXS3NRMcpJNzEc917ZDX0xucU6XnzyRbTrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9lgVayDXh4iAAXnQh8bIx107SICTVus1qaOhP9VsCo=;
 b=M5UKV7bvlQmjz+EyiMaPDTYDONRjJYz27ygnE5dVPqoTB5MvRs1rP0eSg0NzxktXqniHDhG0oeOY0UQnjiby/F94oTFZ0q2ZIEPALMp/MplCF4NoWVUWIjp5rByIhyzYDYP+oIjVyU5kZvY7Ve0Si2nE3egdWzvYsZI+XGECap6GsqmZoEridbFUkU5KVA6bpPVtiytOI8GBpay0dUe4Nojwiaj/Oz8csePnYTIcTY2mslfTUkpuMR/ukqqEX07ouyf4P1EXnzB7SFUd/8Np8KrO73MiY3A0HJDQX/35OveIHYEWdHXrQoj0LAr/IzA2OBp2UK1y1XcXpZLO7u8+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9lgVayDXh4iAAXnQh8bIx107SICTVus1qaOhP9VsCo=;
 b=vUWkJp3hcGwOfkRo0RsfDIAFdAvzOXQEq8PHDRpfoMsyw/4eJTDZlIRjxH0pTqUy2jTlrpgQZ+HJur+k+1PHSRSfcoR8mu88We0dN7LvKZeViknCBuVC+lEguErXBOqtvCuNSxshZNnkhBnCj8LJ0iOqDrTKytr8G4HdsLN1h0DZXgL7c3GqPd6oLk7hTJCTxl5vaqT+7KQRY7Xn5CkmXjOmBAf5p75HVikwRl03scKg32tch/r9690gRYK4VKrQfy6daKRqNL0mRevBbqCLzoCpQkcJYGiU7M4OQoquMRLjf2DzIANKTU8hwFL5S6OKcAndQITog80vrtZuJQINtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU5PR08MB10561.eurprd08.prod.outlook.com (2603:10a6:10:51f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 13:17:45 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 13:17:45 +0000
Message-ID: <44e4a0a0-66c4-433d-9bb6-4183e4f83378@virtuozzo.com>
Date: Tue, 7 Jul 2026 15:17:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/ide/ahci: cancel in-flight buffered reads on
 command engine restart
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org
References: <20260619112158.304782-1-den@openvz.org>
 <20260619112158.304782-2-den@openvz.org>
 <ce8ebeb2-2509-48be-9ea1-afee614859a8@oss.qualcomm.com>
 <70fa6511-acbf-4b9b-95d3-1670fdca80b5@virtuozzo.com>
 <1f9dddf1-7d83-4365-996a-6cfd4a15ec46@oss.qualcomm.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <1f9dddf1-7d83-4365-996a-6cfd4a15ec46@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIXP296CA0032.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::15) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU5PR08MB10561:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9769fb-6026-4be3-79a2-08dedc2a2261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|366016|1800799024|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WFaGO08hkuPzffU3UfQfjvmpX4+3k5AvFamKhiW8bB/m0BqFMlOoKGNt4gQfyhmtobPbeoq8LQs/ZBUu9CCQ7KWP4jjxJmGcUCHtDBqqqYTLwljR2nDrFFN4bLlTC2I9U7mVnZjayfsCqpyk5jQYRzWGDw/BER5HWaScPLYeOD6swK3ShsN6n1Fx9gghlyfqSl1H6IyYMU9Wie+ZAN9+/GM1QScFk8zaQd4Fj8RrVY8YX7c5+WtiXVuZssTzEXCezE8Q3B+GFlGubH1UEjR16OLMgUPb4x+aLwIAVA8ToFUR/clCAn1KSvDA7xbSQS8xzC2ofPOtv/hEHer7pZfc/jZrXt1M1ov4SNYWxF/Mw3dfZR5n6RdPWtN2YLHFWJBWAusYlVQvuOi0MREsvSuDah31zeZ55antL6koxzRxQe1ehj/iBz3EE7RW4AmLmds91f0ZnCeAx9+y3Gd5u2u7mS+l6pkpVu67ugOBeB0IKyfNd9Ku4NJjUiV8vXth7ngyG0BTqPZHbwaHNKJKSNTxlEJP79S2zJRvQEEIlATRpT/9ZOljP0k6biR+R6YJ5uHuyiPkvs0JXo1xMIo0XspVlnsIC1qiFlnkxNSoJeCKbFLJkT2HSMrbaWEo0LUAvDpShBsQD5i7Is2cdAli9BpWhIklRREDGhs0gj9t9qW3mXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE1XWjJSaks1WVlJZkxBK2VRWTNid2hEWk5leEl1YXAxb2VHQlF4V2YzaGt2?=
 =?utf-8?B?eEI5T0g1YUV4WjltdFNXMUZtLzFUcDZaSUhVam44Rk4vRzZvRlRJblJ0UWhF?=
 =?utf-8?B?UUJKTDBJeUcyem1jdjVqOWY2Z2JJY2IwQkxpQ3dCUHdFSU1wMDF5cW9ISHN5?=
 =?utf-8?B?SCtGbHAyUlc4amQrd200QWV0eHhoV2E2Tk01ZGxQUmViTDhBbVhrcEFiV1Js?=
 =?utf-8?B?VFdXS1hCb0FkazdkSVVrL1JQOVJpNVNhaVFkQ0ZBdVZCT0RsZnhSc3ZzMnpK?=
 =?utf-8?B?dWlOTUJYbW9HOExrMTNiVHBFMjlTV3FuVTFRMmlYVXNoN2M1WkxUbG4wdmxn?=
 =?utf-8?B?MCs1RWhUcTVtaGs0RFhWSzF4R21VMVBUS0wxTDFCMDhMS01GRmxGNEdRTFBs?=
 =?utf-8?B?SmFTa0xxZXQzU0lkc3RWODI4Uk5sanNCZ2F3eWlVN2toeWRPUWk4cTduT2JD?=
 =?utf-8?B?RWMxMnFnNkcybmVBN0o4VW9EUENLNnkzNHBHYjRuLzR1eklBMFNqOUVNTkVF?=
 =?utf-8?B?Q0hPWDhZWnBNZGZzMk1mbEt4ZzBjQTZXOE5MTCtSaW4yTHd4OGc5UjVTSGdF?=
 =?utf-8?B?Y2ZPblpiZGFYYnN5ZDBoSUlFUDA1ZXVrMVRjVjN6dWgzbFM0SHVwZUtDQ1gy?=
 =?utf-8?B?R0plTXFYNDJSZS84cFpITHhqK1ZuTXVQNk5Zc2FycnlmS2FsZ1BtSjhtS0R5?=
 =?utf-8?B?eHVSMmF3T2FUZFovbW5aWFFUSW1mdEFuSnNQeHNRa2lJRU5uZE8vdnlMVVZn?=
 =?utf-8?B?N0E1cFZZRkthbzg4NUFKQSt4YU5rTWdydm9WUjZ5QXkra3luZU51NkdDV1BC?=
 =?utf-8?B?QVg0RWU1dXd3UWpCaUp4NnkvcFlqaTl5UUg1YjVOQlhaNzlYdlBYbHVNZERx?=
 =?utf-8?B?OVJsTUlmQzBhekNTUWEwaU50blYrSVFGZS90WjRpU0h3T0VvYmsxRk9UMk1Z?=
 =?utf-8?B?dW1BV2laSjRabzdpeXZZTk1zekdhNDdXRmFqOSs2dXpwbmQ3YnRUMTBSNVpk?=
 =?utf-8?B?azlDTnY2NkxSTno5dWtBTXZMOGxFU3V0eDFEMzZlc2RqazhVVDVLVTNjcC9Y?=
 =?utf-8?B?VmVhZWFKWEx3UldXMnc4TFl3S3gvUS8zRHoyamZUZENJamZNYzI4Q1FmU2FU?=
 =?utf-8?B?V3hIOUp6ZXRPV2VYN3RidFN6VFcwWUZza0FDWlFsUlUxWkMrUGF5UWdvajJU?=
 =?utf-8?B?MWNaZUZqRHdQb1N6L2VWZDZrUko2dUJNZzlQOVlGckhYWUdwbTlvYi9URTMw?=
 =?utf-8?B?bkZOVmQvRmxJdGptK0ZHM2NMNW5KWW9ocWRkdFZWTlRrQmhaaUlGT21KSkFk?=
 =?utf-8?B?N2k2SzNLNTdMakJPT0t0RkRuWXNOS3VkcGxDSmpWM0VvaUdqM25LeGxZZjk2?=
 =?utf-8?B?ZDVCQ0poZ3dkQjN6SzQvek9ha0ZCcTN3SVJLNjF4VDNGQ1J6R2dKTkx5MjFv?=
 =?utf-8?B?OFdvSDl4M25Dbm5MM1ZFL2ZOY0k0WXpsRk5YSitDdjlMbERHYXBSZ1NOWVJQ?=
 =?utf-8?B?UTI1d0Y4Kzl0RWtXWjMydzNtK1kxcmhVSis0elgzcGVKMlNnaGhGNlppMmVW?=
 =?utf-8?B?REdhTFRKTVROaVZ4VXlkcGx0M0FIODZHbkNRaEh3NmplLzJVSExtYlNTZk1m?=
 =?utf-8?B?dHVLclhqeWRMZVJsN2tpNm01bk5lZXh4TktzOWpzY05NbDZYVENuMmhETzBp?=
 =?utf-8?B?NnpTRlkycUxoc2UxUVJkVzhoa1hYRVNBWWpRcjFaYzdJQVV0bk5OK1EwQXdn?=
 =?utf-8?B?V2Q4RnRINzYxSGE4VEVaTlFEYWExbmpoalhoZVNVWFFIU0hIVFJnREZSeXlU?=
 =?utf-8?B?ZFhSYjlIWnpMNjJRU0NwUUVLeHphVkloRHE1bE1rbE5FZTlSTUF4S2dNbHh0?=
 =?utf-8?B?TlpneWdSenJxdndrZDlwY2gwY2d3VThITzJtRWNDd2ZGRjBWQ2w4NHJLY1hj?=
 =?utf-8?B?a3BzaXpOc1RkYWtDTGY2ajMyMTE3c3lZQld5ODJRZzRvOHZsdWttQXpCdFdB?=
 =?utf-8?B?OFBTMGRuVzhjck1LdzVaQUFRd1FCWVJwQTRWTzVSZXFNOGoxU0Z6bG9QRk91?=
 =?utf-8?B?bmtuZUI2YWg2TTBUbFBoUEk1ZU9qTTc0QW0rTlM2NzdwVjZUckVxN2podmVm?=
 =?utf-8?B?RXdKRDUvYVpScmFtTXVsTXkwWWVkQ0NScHAvbWFPVlBlczZZVFlZU0tHZCtR?=
 =?utf-8?B?Z1RtdkU1RDZoWjBQS3lMWEdvc3dtRkthVUdtNkZZZ2p0SmZxTE5KTGIxVi9q?=
 =?utf-8?B?T2thR3k1Vlk4OVFMWm56UjVEdXNWeXlsRllrSURLTE44c1ZJN0tySGFUNWpF?=
 =?utf-8?B?Yk9MOEh4U1JXQlZicHB0Z3UzTVpGOG1GQTFkSWVFTmFJZjduVk1vK2NTRFFm?=
 =?utf-8?Q?dXe73JPf58AwMNrRPfvru7BiyEhYilJ0B8OUboVDoL7RH?=
X-MS-Exchange-AntiSpam-MessageData-1: 2LVWkhFlYMwZaA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9769fb-6026-4be3-79a2-08dedc2a2261
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:17:45.7743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3afpCLr9BJ/9g6VURfpolsgpIgzmdVMWUduYYQAPwtF+03O0GOntXTYmBOmvAI6gUGiTyaz5ZGGYKL4oR40ldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10561
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

On 7/7/26 15:15, Philippe Mathieu-Daudé wrote:
> Hi Denis,
>
> On 7/7/26 15:02, Denis V. Lunev wrote:
>> On 7/6/26 09:21, Philippe Mathieu-Daudé wrote:
>>> Hi Denis,
>>>
>>> On 19/6/26 13:21, Denis V. Lunev via qemu development wrote:
>>>> ATAPI CD reads are issued through ide_buffered_readv()
>>>> (cd_read_sector() and ide_atapi_cmd_read_dma_cb() in hw/ide/atapi.c).
>>>> The PIO path discards the returned aiocb; the DMA path stores it in
>>>> s->bus->dma->aiocb.
>>>>
>>>> A guest can stop and restart a port's command engine
>>>> (PxCMD.ST 1 -> 0 -> 1) while such a read is still in flight. Stopping
>>>> the engine unmaps the command list (ahci_unmap_clb_address()) and
>>>> restarting it re-maps the list and clears AHCIDevice.cur_cmd to NULL,
>>>> but nothing tears down the outstanding read. This path does not run
>>>> ide_reset(), so the drive's transfer state is preserved and the read
>>>> still completes. Its callbacks then dereference the stale or NULL
>>>> cur_cmd in the AHCI transfer helpers:
>>>>
>>>>     PIO: cd_read_sector_cb() -> ide_atapi_cmd_reply_end() ->
>>>>          ide_transfer_start_norecurse() -> ahci_pio_transfer()
>>>>
>>>>     DMA: ide_atapi_cmd_read_dma_cb() -> ahci_dma_rw_buf() ->
>>>>          ahci_populate_sglist()
>>>>
>>>> Both crash with a NULL cur_cmd; the PIO variant has been seen in the
>>>> field.
>>>>
>>>> Cancel the outstanding I/O when the command list is unmapped, reusing
>>>> ide_cancel_dma_sync() as the ATAPI DEVICE RESET command does. It runs
>>>> the completion callback with -ECANCELED (which tears down
>>>> s->bus->dma->aiocb for the DMA case) and orphans the buffered request,
>>>> so the eventual asynchronous completion is a no-op. Merely setting the
>>>> orphaned flag is not enough: it would leave s->bus->dma->aiocb pointing
>>>> at a freed aiocb that a later reset would cancel.
>>>>
>>>> Fixes: 1d8c11d63154 ("ide: add support for IDEBufferedRequest")
>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>> ---
>>>>    hw/ide/ahci.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>>>> index c2b4432b94..8e3684cd3c 100644
>>>> --- a/hw/ide/ahci.c
>>>> +++ b/hw/ide/ahci.c
>>>> @@ -740,6 +740,9 @@ static bool ahci_map_clb_address(AHCIDevice *ad)
>>>>    
>>>>    static void ahci_unmap_clb_address(AHCIDevice *ad)
>>>>    {
>>>> +    /* Cancel in-flight reads that would complete against a cleared cur_cmd. */
>>>> +    ide_cancel_dma_sync(&ad->port.ifs[0]);
>>> ide_bus_active_if(&ad->port.ifs) would be safer, otherwise the
>>> patch looks reasonable.
>> Anything else for the series?
>>
>> Should I respin or this change could be cooked at merge?
> I took this patch via my hw-misc tree (using ide_bus_active_if) because
> it I could understand it and it looked trivial enough to me; however I
> don't have enough knowledge (don't feel confident at all) to look at the
> rest, I'm sorry :|
>
> Regards,
>
> Phil.
In that case you should also take next one - this is unit test
for the fix.

Den

