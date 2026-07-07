Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D60C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5S6-0004d9-F2; Tue, 07 Jul 2026 09:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wh5Rh-0004I3-Tb; Tue, 07 Jul 2026 09:02:43 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wh5Rf-0007tV-Kh; Tue, 07 Jul 2026 09:02:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPDusNEVaMZrkR8e37Sd6w5sIyTHQeEEcPDRfVREhPlqezweDKQpIwqHASOcAHwgWUtDSHKIlDVLcp/XCBFdiSXEFU3NyeZxaFXh3NEpvJpNfv6DC528pK/Qxu6PrRXrngHzIiI0RcR/6aqsyh8GJ3PzuSHZSQiYlcggrc8vi4E1jUojWT+CuxpZmK8Izl215QmR0jKrejM68MH174JXm5jTWG9om5rbDudD1oaAlhp9eAToYtpoFnDBrxqyeXAA4Q+S2UE2gmAO+Odsl5Fgzi43/pR4mOhgfZrwd4TYpcxv3aVKcNVxm1gtUhfFqk6dKVUJvvAs8USk3KEK5KzeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2+M6SY0JFPQ3fxq2PcTfHwqjoaWAy3/TnuVLujsz+k=;
 b=G8Pm3cSw0EC2JuSePfUPCjY1qnjyPgqQfJbATQSvfg0ZHDQa665QsCODdvHtnlTX8G7aiGwV07qTXO1GAV5EuCcjoQGpgKFOglptm6J9E3tYvnpvfhJdLdpxFIFIykFL+YZXhzMt9I2Y4ERWdg5gx1qAOAQ2Bc3FWZaVICFgOKqntUZYHSheo9B2JsGsereNV3KoOD9KrTh1GHmZnwF4bJqdmL/Ei3/3KfHWE4aK3MjRomAKdNdfDp8ymK2HOK8TBJrF12eWDbPe2Eu5g9Ns8ugp1lDB5TnaLsxsXKEH6I4VONV5XSAMwo2adWPPjr59a14g1ybvNaR75DreZ8t6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2+M6SY0JFPQ3fxq2PcTfHwqjoaWAy3/TnuVLujsz+k=;
 b=XktoqB0kKvjiyVBu1/PRU7zVdRxAhA5R9qLm/yM8edEtJftZQl4P4YdugxPJukzlL4wTZ+8TVzfWnpd0AWvKZ4MnkVWQ0pnVBX/T/OXDuPVBMUiBt0MdGrYLJwUZoYrEMjUU2qOVQXvsYwB5h6gcIXxIZxhT8aTcVI/i9vxToI1x59TxQXp6y3N0MWV7jonsQmjNtQtbU4vhSZkKqXRGLgWlcXimmJ7Bp0lcf4e9adRHiNJtDC088vsDW8S4TBaCYk5RrIyu4+vPIBLxAGHxnihOhIJnCGL4IdnBXPS32qqraeJlvjLyU0MZi6BRLnHoCNdYhFZA6DB+UrvzGOWZ2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS2PR08MB8309.eurprd08.prod.outlook.com (2603:10a6:20b:554::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 13:02:32 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 13:02:32 +0000
Message-ID: <70fa6511-acbf-4b9b-95d3-1670fdca80b5@virtuozzo.com>
Date: Tue, 7 Jul 2026 15:02:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/ide/ahci: cancel in-flight buffered reads on
 command engine restart
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org
References: <20260619112158.304782-1-den@openvz.org>
 <20260619112158.304782-2-den@openvz.org>
 <ce8ebeb2-2509-48be-9ea1-afee614859a8@oss.qualcomm.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <ce8ebeb2-2509-48be-9ea1-afee614859a8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0100.eurprd04.prod.outlook.com
 (2603:10a6:803:64::35) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS2PR08MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 66457fa9-1625-4e58-d155-08dedc2801cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|4143699003|56012099006|18002099003|22082099003|5023799004;
X-Microsoft-Antispam-Message-Info: vkyrNTIi11CDtLRdZduYz9fUWN0K3hhfdjtWqzmvGJbr3guTchLU7JrzC5xcIJSLAm1BCKfLzqNlzS5g4epjwFa/0VpMgK660PVgjU1YwiRm3YHsOFirCFxP/fV0BEg+GoOvo7Okgv5l3UPnZ5Kj+ode1o02hxakICGMtMsL+8kemxv+TlbY8ua2vnokMasnx1vVzftCx5UOXnR7rLkVmFQd6od7oXXs0LyvlkcNmrMlwl3jSXQgnmgtFoHt6tZju+1EZ7Yt8nen6qTI8Xd/nuYR6kcrVI8zWq6VWmptq5qH/Gi/USAjM80FL37dp42X0+9E3JuTFc3y4WvenIlWE1eIQfNnjMfz/hvG7pKXK1Mb0KLeM+hY2obBv/Y0ypIdQwNBJBwu6qk1JBTbqDOmsPv2QYHPq4Wf030Q5h8ybK/R11ZKT6ukRrPMTMS3fqtOuVA9cvz3ZxV8N1BHIA6r8B7vwB7tJ3wT0F4EJ62S10j+cv91KHuvGg6a5IjKmaOkiJZSi6QzR3UrQ+HpoTIk0qdDpEDB1bhpnR3F77yq70T1ugc7spwLcwHbnfnmq0WC8hcCPQBv5B1dWvHZdX53PNlKSWnMspjXqqWovtLjBMHVrzWPqFi+TbBMJCSEDNhtY0l8tvynjvh0Hj66pWoT/exzMyX3anv3fPN56xJay3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(4143699003)(56012099006)(18002099003)(22082099003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUsyQWdBaVIwY0FpWEQ3dHZOMXJtaGM3RGZNT3gyTXJBbWwrT3FsVHZPb1dH?=
 =?utf-8?B?dXU0WnB1c1dIOHhRU2RvQi90MGlkR2hzQzdwbk1vNmdRaXM2K2Y4ZkRwR2cv?=
 =?utf-8?B?NklHb052WnY3Z0RrYzBNNFFpbkM4WmxGSjZvdmRreWpyRFJ2eGZ6blFtVTBh?=
 =?utf-8?B?eUZFYzNFalVPYWJmNjlKSzQ4SWxOY3NxbHV2Q1VHME0xQXU3SnJFR0hGSC9j?=
 =?utf-8?B?eUx0d2pYMXo5OXZrbXBoTDZVNlBQUVkvN0MwK0h0THEwL1cwODBQVXFweGd6?=
 =?utf-8?B?MjVvZS9xT3VNZ1B5TWdNUkd3RVd0R2RKZEgrZ2hjR1Z3Qkpzd0syczNhNkhx?=
 =?utf-8?B?cC91YTEwbzM1YXpaU0g2ekdNR2NoeTd3aXFZTjdPdlcwMHU3L2pWNnJ2OTF1?=
 =?utf-8?B?clM0VFZzRS9OaUwrcStqN3RLT0lCWXIrVGlxcUpzSU1mUnp5dUc4M3czWW1P?=
 =?utf-8?B?dnZRYytDdlBsTUpFTmxFT213ODkvMWFBMFpkaGphaEdsL004VXc3WHE5MDEw?=
 =?utf-8?B?TFdpK1BROGNLTHBIcHRDZldaNnllUW10cjR6aERYTDNoVFlDaXc2MUc1aFlm?=
 =?utf-8?B?Vm9FR0JPYUtGV2hrMGFTT2pBOXk2STF5YjRGMkNienRORVRLSm9yK09NY0wv?=
 =?utf-8?B?RDRVeG43ZElDemJBaDdtL0FLWmo4Q1FnSDY3bHFrNDlCeE5BWkFKRVV6RWoz?=
 =?utf-8?B?eEQvQ0RmOGRzaHJnOVl6VzJzdVFKaUh4aUNKOVVQOUdWTHBpeSs2MUZ6ZTR1?=
 =?utf-8?B?dGtHanlKZlQ2TWkxMkt5d2pSak9sWHZta25hS2tTZzBZbWtUeFFUWlZTdXNQ?=
 =?utf-8?B?U0hrNCt1eVpNbUJiL2luZGZMUlNBZWZkSnRGOXExTStsbjhsODNZaEduMytz?=
 =?utf-8?B?TVRpZjNLdk5naGNBdTF4aFZyZjFFakFvRWw0SjB5TklDQ0RtTUNFY0R2OEJh?=
 =?utf-8?B?MThvNks0OXRMcE14Z0llYlBlZWpBeGVhRmFGZkU1aVJ0QmVDd2FmTEdJNjB2?=
 =?utf-8?B?RlRFMnNsVEtHWUd3YnpkZ0ZJb2p5c295SUpGMEFoc2VDOENpc0NReVVmTm83?=
 =?utf-8?B?ZjF0TjJDN095OHFYWWlvRm1WazR2dDlFclFYSFRuS3pIUWV2aVNMT3ZxUUtV?=
 =?utf-8?B?RDcydkpjVkpHUXk4bWpCMkoxWFVPZEtiVlZwYTdBbm1weVRjMENHSEZIcnVa?=
 =?utf-8?B?NWpTSDBiMER5SERWbk4wUHhDeEhmY2RsYUZ6NHBtUTk3VEdMZWRsUjQ4NTVm?=
 =?utf-8?B?NVprcldZUFk1aUhDSkVuSUJ2U214NG05T3pvbE9wWERKZHJTUUlPNXlsckN6?=
 =?utf-8?B?ZDhsM2NZTEo4WENNNUZwUEEreG1VTVB1Y245ZVkrQWFaYy9IMWY1TEUvUWN6?=
 =?utf-8?B?eE1EOTRzTEplVEhsWnNINmdkQjdaZXUrUHNPa3ZsekdMSWV5YWFzT1pnWVo1?=
 =?utf-8?B?bXNWU3J3bUdBYjUyQlZKbmUxci9OMDVzU21WVFlrRFROWFVuK21JY0FuNGdo?=
 =?utf-8?B?ZHFPRytENzJnREFJMTV0YnhqTW5OU0pla2JhRkRlMkdSeXlxTXdSRVlodjVu?=
 =?utf-8?B?Mktvd2FkSEhBTFZwa3F0N0dPVkhPR3VoM3hSbWZmVi9aSCtHQ3BjWGxwUjdh?=
 =?utf-8?B?Y21WSnJvOHdocDBZcGNIbkF2TEl6dWpJOUF1eGliTDE4RThJQ04vMGd4OVBW?=
 =?utf-8?B?OElUc2dPOGpuelN4RjVDdUJ4VWZuaENhQ2xrMVpSTmlMZFo0cjdlK0hZZVFJ?=
 =?utf-8?B?YUVKczFmWnEzKzVTMGdGdUZ2RFZ0Q0tjdWRZei9LZDFDZHBOdjNldjdNaGc4?=
 =?utf-8?B?RzQzMXJVQS9BUjlYWUM5UXpFU2ZsSXd1dVVuVzFPRjI5anV0Nys1REswWTFY?=
 =?utf-8?B?UjVyRlJUZTd1RVVQc2k0TGNKdEZBSnl4NmhuMzM4cjJ2MEZvdmNSMFY4Qm9Y?=
 =?utf-8?B?eGhuQkYwYnRHM2VxQ1hSc0l6ZjByZVZXV2pFOC85dmdURDhWa25tY2Jjc0tB?=
 =?utf-8?B?bFM1Uk96a0JOYUgxbXdlc25IbWppcElNdDdXZFVxeCtrcFJmNmdkNkpWM2Nr?=
 =?utf-8?B?UVhDWjFXK1ZlbUkwbmhGN0ROWUxuSjZkZ29acGkzWVNZZWNaeU91aW5oZTA1?=
 =?utf-8?B?VUMvS2RFMnN1c0JDVTdqUyt4NFpjQkY4eEpDSEp5WVFaa2pJM1pHM0V2QVFo?=
 =?utf-8?B?TVBaMGJENDV0dGM4eVZzRVFIWk9JbS9hSDVxaVNkNm5teUdwT1NtVmF0bU9F?=
 =?utf-8?B?NEI0OHAvOTBjNUxLQ3JaM2ZwM2EzanB1aEh3R1pyeitnd2Y1TVFab2Zpbjdl?=
 =?utf-8?B?cHpZdEtmQXFaeGcvWURpbnJkeVhBc3ZTSzRNNi9CZlErTUY1Uk15RS9LM3o2?=
 =?utf-8?Q?uEzCyAKdpOpQ3ONjFTvYUPuSCInm2toxdydd3eON/bXFl?=
X-MS-Exchange-AntiSpam-MessageData-1: GOpU4xG0CeNIqg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66457fa9-1625-4e58-d155-08dedc2801cd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:02:32.1663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdpvTCe/iLKgMZyxqNT7zAazzbANeebhMesgUiZWFsj2kWw65N6sM+7til8TSTawJtIqo2aYyBGIdgzy3lIFBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8309
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

On 7/6/26 09:21, Philippe Mathieu-Daudé wrote:
> Hi Denis,
>
> On 19/6/26 13:21, Denis V. Lunev via qemu development wrote:
>> ATAPI CD reads are issued through ide_buffered_readv()
>> (cd_read_sector() and ide_atapi_cmd_read_dma_cb() in hw/ide/atapi.c).
>> The PIO path discards the returned aiocb; the DMA path stores it in
>> s->bus->dma->aiocb.
>>
>> A guest can stop and restart a port's command engine
>> (PxCMD.ST 1 -> 0 -> 1) while such a read is still in flight. Stopping
>> the engine unmaps the command list (ahci_unmap_clb_address()) and
>> restarting it re-maps the list and clears AHCIDevice.cur_cmd to NULL,
>> but nothing tears down the outstanding read. This path does not run
>> ide_reset(), so the drive's transfer state is preserved and the read
>> still completes. Its callbacks then dereference the stale or NULL
>> cur_cmd in the AHCI transfer helpers:
>>
>>    PIO: cd_read_sector_cb() -> ide_atapi_cmd_reply_end() ->
>>         ide_transfer_start_norecurse() -> ahci_pio_transfer()
>>
>>    DMA: ide_atapi_cmd_read_dma_cb() -> ahci_dma_rw_buf() ->
>>         ahci_populate_sglist()
>>
>> Both crash with a NULL cur_cmd; the PIO variant has been seen in the
>> field.
>>
>> Cancel the outstanding I/O when the command list is unmapped, reusing
>> ide_cancel_dma_sync() as the ATAPI DEVICE RESET command does. It runs
>> the completion callback with -ECANCELED (which tears down
>> s->bus->dma->aiocb for the DMA case) and orphans the buffered request,
>> so the eventual asynchronous completion is a no-op. Merely setting the
>> orphaned flag is not enough: it would leave s->bus->dma->aiocb pointing
>> at a freed aiocb that a later reset would cancel.
>>
>> Fixes: 1d8c11d63154 ("ide: add support for IDEBufferedRequest")
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>   hw/ide/ahci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index c2b4432b94..8e3684cd3c 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -740,6 +740,9 @@ static bool ahci_map_clb_address(AHCIDevice *ad)
>>   
>>   static void ahci_unmap_clb_address(AHCIDevice *ad)
>>   {
>> +    /* Cancel in-flight reads that would complete against a cleared cur_cmd. */
>> +    ide_cancel_dma_sync(&ad->port.ifs[0]);
> ide_bus_active_if(&ad->port.ifs) would be safer, otherwise the
> patch looks reasonable.
Anything else for the series?

Should I respin or this change could be cooked at merge?

Thank you in advance,
    Den

