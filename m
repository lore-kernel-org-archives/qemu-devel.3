Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA08C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1n3S-0004DT-3i; Wed, 02 Sep 2026 11:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x1n3P-0004Ch-NT; Wed, 02 Sep 2026 11:39:12 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x1n3O-0003uX-0l; Wed, 02 Sep 2026 11:39:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VV7Paoxtc7/Q/FEdCoZjb9Smwl9YhjDZHWZqEJ+0ihqoU+594mwAPtCV+3JRsWiC0Yy3R0jt0rL6K8qILgQkcsRvQk4Ll26os6vD+X4ZQv3ygQUIv3SiwHeDKOUHHIeIWmviRVtV6+eXQnpW4RosGUDj1G+b1UYWaYiTTS2XLK2D90NnkdirIPzgWnXmC66R1xKX6fn2Y86C1wvrsu6BBsI2RxWhmOhMOwzlYBD83UjOXp7P8bldDELSo8YoauBXloMDiPCuNozRHAxexuSydZAemcw91tsinb2sx/RIWxxm+YaNPns+PrtaygVBVKXy3qteQO4YGUf+dsRx0l5N9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC4SmRxsP0U9gzARA+4QQnKU95V3AfM3c5ZgKt7OK04=;
 b=fVLF4LumSWm48lHPWBGB7SGjmeyazECrE7fK1X9FAYog/wygoMjnkEzj7W8IXN2lgHRupX5UBkGyYdP1vm3L41tYzUELiaQiTwLDpkXmoHM74QYRarEy5EtHY4B4b5bk/wyRuVgmvBW2UK9IWIMVvj6Dp5xdfMq5JMXQSqnqP30asuQv6iDg6RA9wy1hBzPtKgC1SJwI8cJWUCn7HEy9tNrqlOok7G/94HyA7LY7wSIYHl7Bnp4ZrWJ86Pp/i95q2qRHNe3kwP5iMMbM0pX4KvOyjFL8jOpT1ry+PZOy9ELUWOXQnPcFvmZVklp3Lky0KLBU79Yn4Us4ukCA+G0RMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC4SmRxsP0U9gzARA+4QQnKU95V3AfM3c5ZgKt7OK04=;
 b=JYNdSq6rKl+TOHY3J+cSH19PWciDIGS0jPHINFyme7fMbiiKqLfVeK9H3i0O/E/mdgua2TePDNCsgTv6DrVSJGAKRd8PszCz1a4Ke/4FhKGfcXpbU5Sz+njbgaZyeL/zOm5pchRl2tVJrF0EsCjtnwGgtKV+4+Nv1XY5OInsWilZb6u9dQ5VUurTY70fEF03rvlfvUscdZHOO89j0YRAhol5LGAxYAWYzeUjoHSVfuebFY38F4r/Hj//Ya+gmNWBS6eDAWhLm27f5FLx3elOEQxT4MTRuaqyQO32gSHPb6Xsi1c5J8/3F30+wnJTjwsmfgBEtlZUntjlrq43ghOtsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by ZR6PR08MB233201.eurprd08.prod.outlook.com (2603:10a6:910:db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 15:39:02 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 15:39:02 +0000
Message-ID: <65792421-83d6-45fc-afa3-fc332d54707a@virtuozzo.com>
Date: Wed, 2 Sep 2026 17:39:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] block, scsi-disk: honour a size change on child
 replacement
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20260812121500.1034178-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260812121500.1034178-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0227.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::48) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|ZR6PR08MB233201:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2ac637-0af8-4e5f-93af-08df090850a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|23010399003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O9zF574LK33CRARiAIWBwNbJ9YdQPFDE9prHf5uU1selkpj2af626UcLE/86BhzxQaDpA9pfITcFSIWvDubYnwOUnqUy+fU+jPgHJ/R05K0zB6lFfojPsKRdYJeysqqNZpOev97hWLbUjNuftz/2nnmOWEFulZcWIJ0xrVInHOe0JzVrKW3e5ySKR1QAzDwN0U0gOxuUDaMQDekZSu+8m76oHMgxlrBAR677Vd/yktIMg5SWmohA7aSHM68UnkAlzEQZ/BgNPgnDj4S9HZOv9XE40Kd0lQ3JooJ7lxxzm1kBY2TlryglLe6jGAl+K+SG8fdJ5hHWo6NtAjY6H76d3jDjMlKsJ1LjVpGHkrVgAr5SMRqSYFcyKHNlzSX9+VNf2dxcavQWAAl+oc0ohDO7ZJevBN6GDkDAGDcaj6Fc2TkE5JFDtWqFa43gLQ3qTS0yDbA22qt/2IuHpZXBmtbvSm3tcz4BHkG0Z68vwfPnUKJpSLLhsyuIfOiGOLY+RcWF4tYgq35BhqnzskC/RDwqyD0+JG4CoAPuKgLlYCsHmpmKl65WdQvn8qMxU8JkQmhZQGnbEbEWyDNgeCP5DxL4eFzhNUClFLcMmvHECyCltns0a54feTD+E6WF9kNM55GzzeVJmYW7vEiJTycx4/qUgSpS93LW6twkdAHOhlYynvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW81VWtlakdYV29MVFFEcGNsd1hYdlFTWDB2d2lNK3hBeEU1d1Rjd01MZjhx?=
 =?utf-8?B?YkZpcWFKOFNEQ2dNaW1IT3VGbkNDZVp3amxBSW9DMk9kcDE4dGtYWkxyL1lN?=
 =?utf-8?B?M0s4dDU0aGNoZ0JKWTlDRTJ3ZmVpZm9zc2U5M3QwN09ZU2hMbVVDYzJGOXNJ?=
 =?utf-8?B?R3phQnJ3blFyMVA1cVMwMzZRQ1FpS2U3c1RpSGdJS3AyWXRFL0l2ODlFWUEw?=
 =?utf-8?B?Mm9yeWRyMzJDUGZtQ2ZPSE9xVVR1L1FmaXpKdmxaR3ZqNDZMYTZKUGhUSWR2?=
 =?utf-8?B?T0phczYrcy9aRXNIY2RuVzV6UWJlWElPb3VyNXVweXdGMnRqa2xvNkJLRDF0?=
 =?utf-8?B?cUhPWnkrWDkrc0xMUkRObFFzc1Fzem1hdHkxSkZ2b2ZCL3RhMTI5bFRiaGJZ?=
 =?utf-8?B?RXR0dU5URGdCc1hXOU1DWkxjT2JFajUwaENBN2FYUU0wOWJNUGNENzVaSXU0?=
 =?utf-8?B?SGhhTit1RVEzNXRJQUNLOW9QWHMwV0wwaWh6cjFkQ1BwQXdScmhVOWF0SGs3?=
 =?utf-8?B?bW5rK1ppV1RTc200SldtcHlyQlRUcFBzUmVsakRpOTRCakFiSG41Nlh0cTRH?=
 =?utf-8?B?YmdqM2pYSy96eGxiaXhiK1pPcFBnMEk1OWZTaGtYQ0VGZ3VsUjhKd1MvMXBR?=
 =?utf-8?B?R1U2R3FNUlVZMWF1dVdvbklWT0FvREdIc2luekFDUVcwR0JlWUdVRWtjQi9l?=
 =?utf-8?B?Z3VTOVVscTQ2TUtZM0dqcVl3ZGZOVEF2bTczTkNrQkFpOG04elg4WWlEZTZi?=
 =?utf-8?B?R2EzekloelRKaW12OENwZUhhMUhKcEVUVzZCQWM0TmF3M0JXYlozczJSV3cv?=
 =?utf-8?B?QTBUcDB0Z3VYT2wxTC8wd0Q2ZzB4SzJkd1pGdWF4dFB3bWZDVGNSNHc0ZHNM?=
 =?utf-8?B?b0NWbUhaajNCb2p2cU1OMU1pSG42L3Z2M1Q5RGdSc2VWOVRaZWZhc25pNUli?=
 =?utf-8?B?ZWp2YzJ4NkZ0K0tvKzRWdmNEb0ViSnVuTDNFTE1zcVBTdmVVbjljZXNUUGNN?=
 =?utf-8?B?L0pPQWVadFNOYjlhSnhFNis1WCtHbDkzbWpxQmtKblV5RGJaN21GR1VObEQy?=
 =?utf-8?B?Wi9TOHVFczE3VW1ESWw0WUZkMWFscTVuMGFPeE1yTlliRFNQSVFya3RSZXpz?=
 =?utf-8?B?Y3UrUzV5ckhTVk41WkFCbkpYTVVaaVFwQXducGUrcFUxUTZpaGJoN1lpU1Zo?=
 =?utf-8?B?TUxNUFlSdURBNWxwb05TdFc1V1NrOHZQa01TMW5oSzFDOFhlQzlXazVRSmps?=
 =?utf-8?B?QnNJY2w3UXdLVFlmckV4M013Q2EvdW8xMEhQd3BWZ0Flb0p2Nzh2V3QzSkRT?=
 =?utf-8?B?enhZVXFWRnRKT1VvdXBkNVhIdEVDaUgwb2w5WTBubEowc0pOR01BZ25NNjlz?=
 =?utf-8?B?dTJMQjBCeTVyRjl5Y3llaEovUjhvKzhwMFlBbHd5eElvQ3gzOE8vRGhPMU1x?=
 =?utf-8?B?UHNqdG9SNzN6T3VhemIwWW9oMnFBNzBmaGdWblFnUXZlRENhTXNRVEpYcHZW?=
 =?utf-8?B?NENjdGg3N214UGdLdFl3ZkFId1RnMWQraHJlM3V0STdGdEt1bm91SDhxZUx1?=
 =?utf-8?B?bWphN1pNM3lON0k5dWREa0p0VWxMUDBtNXM0UzI1cUpCejgyS1NtUFUvS3VG?=
 =?utf-8?B?ODBkaGtudmhlOHdOTzBsSklTSzVaWS9hb2JhT2c5V3BLeXdnU0lZT1BoM1RJ?=
 =?utf-8?B?VHNBUmhPbEpmdU5lcWhXMkcxVXJCZXBCUUhGV1VmVUUrQUhZM01lSklhR3p5?=
 =?utf-8?B?bkNjOENsbzV5VmQ3SCtZM29laGtKTWh3MjMxaHJaaGMvOXVkWmxFYVRTT3hT?=
 =?utf-8?B?SzNwWVozM1lSVHNTTmJZRnVlZFQwSlYvdlloQWV5WVJjNjdhTkt6eXg5UGt2?=
 =?utf-8?B?aEdUbTlRVDg5Y3huRDBUTFY5a2Jkb0M4WGZhUFpVMHhHam5LNGIwUmt0QVBv?=
 =?utf-8?B?Njl3a1VKcHpDZUVwRmIrRTJWNDBNelUvVFhnNkdNdHZYdUZoTnFuWk5IVFpl?=
 =?utf-8?B?Q1FyaHU1SURkd0xWZTZTSUxCK0hjaWczZXBvVThOTjhSQWk0VFg3Sml3RFNF?=
 =?utf-8?B?bDRPT3JiSlZPTWlSN1hRZFp5N3dQc2F1S1RWWWxhTjQzQU1sSlM5SEhhNkxQ?=
 =?utf-8?B?aC9VdjhrVkxsUzhoSWlqTnhDdjBxYzlFd01BeFVIUDAyTHhoc2NoVEpNcllT?=
 =?utf-8?B?dnFVWXJ4Mko5TmJweUR5SUhoaUYwVlJmTWVFV3ZVdDVoR2xQd1VqOVE1TVlw?=
 =?utf-8?B?ZHZnSkM0SFkxSUkrNUQyYVl4NmZxdjQyVmZrQ3RTUjZsY3FsdDk3WWRXUEFq?=
 =?utf-8?B?Tmx3b3hPSzRLbm1mSHdaTGZQZFVnelRha2x6TzkwT2p2TklxZmFpb1pHN1BP?=
 =?utf-8?Q?p4Wi80wh7KnRpafgEMi0D8JuHk3ZXLDeMjz2Mn70kdGKP?=
X-MS-Exchange-AntiSpam-MessageData-1: nT9p759/uLq6tg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2ac637-0af8-4e5f-93af-08df090850a5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:39:02.8491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZzMcBeBrKbP6v0+OHfgyjDfjRBjTZ6HpPKQZ+jXZTPw9oJb0EB35jeuv3YIWbvebDjI0sUsQjh/y0o9YhZqWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB233201
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

On 8/12/26 14:14, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> qom-set of the 'drive' property is allowed on a realized device and ends
> up in bdrv_replace_child_bs(), which swaps the node a BdrvChild points to
> without telling the parent anything about it. Every other way the size of
> a node changes goes through bdrv_co_truncate(), which does notify, so a
> device model caching the size of its child has no way to learn that it
> changed.
>
> scsi-disk is the one really hurt by this. check_lba_range() validates
> every guest request against SCSIDevice.max_lba, filled in by
> scsi_disk_reset() and updated only by the READ CAPACITY(10) and (16)
> handlers. Point a scsi-hd at a larger node and every request past the end
> of the old one is refused with ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS
> OUT OF RANGE for the whole life of the device, which Linux turns into
> EREMOTEIO for reads as well as writes. It is silent on the host:
> out-of-range requests are answered by scsi_check_condition() and never
> reach scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and
> io-status stays 'ok'. virtio-blk and ide call blk_get_geometry() for
> every request, so they end up with a stale idea of the size but never
> refuse I/O the node underneath can serve.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
>
> Denis V. Lunev (4):
>   block: notify the parent when a replaced child has a different size
>   scsi-disk: refresh the cached capacity from the resize callback
>   tests/qtest/virtio-scsi: cover a replacement that changes the size
>   tests/qemu-iotests/qom-set-drive: replace with a differently sized
>     node
>
>  block.c                                    | 13 +++++
>  hw/scsi/scsi-disk.c                        | 16 ++++--
>  include/block/block_int-io.h               |  3 ++
>  tests/qemu-iotests/tests/qom-set-drive     | 14 +++--
>  tests/qemu-iotests/tests/qom-set-drive.out |  2 +
>  tests/qtest/virtio-scsi-test.c             | 63 ++++++++++++++++++++++
>  6 files changed, 104 insertions(+), 7 deletions(-)
>
>
> base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
Kevin, Hanna,

have you had a chance to take a look?
I think block tree is correct one to go through.

Thank you in advance,
    Den

