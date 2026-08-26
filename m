Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02643C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAmF-0007r2-4x; Wed, 26 Aug 2026 06:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzAmD-0007qV-95; Wed, 26 Aug 2026 06:22:37 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzAmB-00013F-En; Wed, 26 Aug 2026 06:22:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDYm3caD1PzvNSQQlrihhWnzLPszmYDj2Uqgx2D5Rt8YnSfuRYBedA8MRcGlQ1FoQ+nJZQxkZf/IDtgCIyP09glky01EDiFt1I0HiJzGI3dekt+EbEnOcZY2FT1XXtKumTqHwCxXBiIUJWyoluo0Rm614AllAEpeo43NO3+qEtYOrStzTnEmwzqzMthpmf8g5oPz8IntkNd+Kt+I/ONBlVaj9Te6kL3KmCjsK0DcQNCIRv5USUSs1vfgLXXY0AH5V2TfD4vFmBF2d/OgC9BhH8D4rPj3mZVoXz/VP7+A1WeAI14DHXGUtM0xUGAcUckYEpmV9ljp4GwkmQYHfeD9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N7wi2DYpHpRuRweePXzavVV+B7CNBNfd9jkrS/r2yY=;
 b=tljIWfN6aQ6MRRDOB8Hgggi2BYnDF6IYcBurMJZV574dx99k7I3wZh1k+CsVEMDjqgXZOf07Q+BNHW+z5A2lZiDXuNC+CbNZniSUKwFlw7yPdS4OHhxb2x85KVp9c7iH3KzlZ/HfeM6h6y1MwWbJJ34F+nWh5RZZGfQ+uZuZyVHR8xu8MjRTdPhhzDJGJYi6PHdsUQIESUDChuuUGJQ6752iuGKTK0PURaxywQ3y+yQtakHIumuCrnhmn8P4UQmoQu+5QD1KMiSExP5Ro8zRQmzIQImOTlykmjP6H5IEOnnWDaSgUUN5Cvo0G2dkzxniWop/ewSAOZH0uLYxDEFzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N7wi2DYpHpRuRweePXzavVV+B7CNBNfd9jkrS/r2yY=;
 b=zICBf3VHz/TesZcddHXz3DwHSfshDNumc8dQceH7gmNjAKE38oAn0u9id657lQhHLXS2NeHvavXm0GfqEP+rFGAwvIgKNfbw7z/tVBh0nbTEi7mzz4QGig+PJApqu3HPA690hrLvdBCKmv1J6yifeaJW/OXSNyD+rrv95K4eIxGeNQ9VLOsQJw0W0GmzawU7bWlcctNgsA+6w02vyNRxpYWZoTAOc0+Uqap9ZFdXfxgIdHUIErFgg2PlLsUvCS9nXaegPUNsc78QgGMKh8DGtVbSHR42+B5G8+nN7iZcRYLtC1OiWmL2mOppFGRMj547PWTRZKEUHItKP9OVFbj/8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAWPR08MB9889.eurprd08.prod.outlook.com (2603:10a6:102:330::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.5; Wed, 26 Aug
 2026 10:22:30 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.004; Wed, 26 Aug 2026
 10:22:30 +0000
Message-ID: <e38ac31f-0130-41d4-8e9a-9f8ae4dbfe77@virtuozzo.com>
Date: Wed, 26 Aug 2026 12:22:28 +0200
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0098.eurprd09.prod.outlook.com
 (2603:10a6:803:78::21) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAWPR08MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e07fb5-3f50-4bfc-f62f-08df035bef4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|10070799003|1800799024|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y8a1G1Bvbtmkcx4IBiy+TlNOLb6Hx8nEXkdPhLYcq/GZklnGkPx4eClswGe2bsmDDjsOMM8W9aLtTQbu0WBamXGRo6AdfRrgf78/ltrUyuUd61RNz7Zjn65eP8GQuSH3z2mS7ZT8YdHKZmfK4P3QgpgxFbGhNtnB3ZcvE+osZWkDhfOoEMBh4Q236DxagbCU0EKpVv0yJQyRpVtuGnn8uoTHVqGZghOHlyToBaakZYyz7WsfCoswH2KdPtEFpVUEejuun5MqRO2uOtE2OLeNDzqf2JgfPG6jxtu08QOkMajEcBxXiZY7W3BDv0rPmLSqflS7FE02NPMCCCqVq/L97r1XvpRtPilfFdzNU67SezkrcI1Dt8fC3PB3bkbmDaA0KUCah3HvlSS5uca8S7DrWJoQn7sYmxFwtADi9UAioV1721BskhWRzcd9dv1EEjWHUsPwXG2HMUP6tk6SMoRJY15y1oLQfmGD/sO9vIEuTfRUAACUwR7HGwE/iMBpp3BHB0cSAA7EJJI7LK+8Ss9TsEWi4jCrqQkVhDBMPsE/iyMCxUnnc1yNWh29k6aZmWEVvFsAAz/94WMLoY+V2XXmnx7P/b8CoH5GDHwhaqpF3eX+ok/iC2F+iATOGYXt0Z0B+Wa9Tz4yrt/OvDblKceP00xlyzlWdpPHU5ixbEB+fzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(10070799003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aSt6SXZRb2QvamVPRG9jTVdEb0tIdHdFd3NaUHh3WXFaMGttSDVQbXZOMDgz?=
 =?utf-8?B?WUdPc3NtQzF1eFR5NmFTd2FsK3IwdTZFWlUwMnUrUE5saVZTSEFGaGppZFNO?=
 =?utf-8?B?SGZva3BRL2toeHRBUk9rR3Z5VHhiTjRGSmhEem9JRnNPL2ErZXNYTWdRVW1S?=
 =?utf-8?B?Y090RDBuYmdUbVV5YzN1STg5UlRvN2dML3owaUNDeDlIQmlBaytRU3huWWNK?=
 =?utf-8?B?Q3hYV09MT0crQnhkdW9DK3pzcTN4V0NQYUNEaUpvQzhQYjhFTVFPWXdBMWVs?=
 =?utf-8?B?ZzBMUHZSRC9LNVRsN2xFZzVUOHlNMGxreGxIYnVhU3lzREJiKzFDdjYxbE9u?=
 =?utf-8?B?N1Y5cUN6L2NGN05Eb0k2WGNNbXJQUDR5T3ZTREtEdHpWWmlaWk1hZzZ0NWlZ?=
 =?utf-8?B?SkZ5b1A1UXNoaHQ0SmNNRnFUL29VQUZGQ2hFVXF4Z2Y4azNsUlNVZTcvNWxJ?=
 =?utf-8?B?NDB3ay9saEJsK3o5WEcyRGxVd1lkbEdUZ09aUW1YdnBmUVhETTNwQTkvc0kw?=
 =?utf-8?B?RHFJZmFCWUxJSklLZHZ4cDBjWHRIYkNEYXdBbDFkSVBaazN2ZFh1SzhYcmJa?=
 =?utf-8?B?dW9aejNBOVZ0TXB4UnhDVFV5dGNGMFUyUXdOejdPY0FuWWp3VTZUWTRPNkc2?=
 =?utf-8?B?czM4ZEozdlduSWphZnJ6aWl2QjY2c29BUUpVNWk3cFZWTHdJNmVMM1ltNmdy?=
 =?utf-8?B?Sjl6WGhWKzN0akdSNWgxLzB1QVRWYTg3TlozeCtsNklUcThyMTduaTZxWG52?=
 =?utf-8?B?bHZSamIxeUpMcVl5azB0eDRjdlJkOWlENWNPWkJ3dGFHbi9FRkVuMHoxMjlQ?=
 =?utf-8?B?aEJrZDJEM25WeS9DMlNoK1VWQUFSZ1pJUmNGNmZTWlNPUXlmOWdvTEZ3bkZ4?=
 =?utf-8?B?WGVhc3gyeWttOVVpcEU0eThCOG1jL2VBd0lzVVJpT1A5T3VxVlA0Z3JKaVgy?=
 =?utf-8?B?VkVLWUZtclloYmdsYldTdy9vNlFyd3FOUDJtaFdWVWFQUnB0Q1hkUHpCczhJ?=
 =?utf-8?B?eWVyYkNmYzBuZ0RuMmg4NUFmMmlZek5mNG9mV2JCejlDMVdIeUI5dCswM0ZK?=
 =?utf-8?B?aVZEZVhkQzZPRjhrU1QySnNJQkM1aUVHakpvYWFwK0l3OG5KZmxOSjI4RUtF?=
 =?utf-8?B?WU9SdHpOVlpwcERrcVk0OGg2SGtGb1VON2FZd2t1RkgwaW1IVmswU0p4d3VN?=
 =?utf-8?B?SllyeUhHRi9tT2xGeXFRdzVaWm15Uml2Q1RQa1RsL2dPRTNJZWg4c1gvQ01P?=
 =?utf-8?B?ZUJHWjBHRzJVcFQ5SWgwM01CUllmSWRIWTYweXpXVzhUbkJuMkJzZDRGaWZK?=
 =?utf-8?B?Sms1YzFneHZ3SlR6OXR5cTNWNzU4R2JoM1pxUEtZdGxoQjRWZUVudDQ4SFUx?=
 =?utf-8?B?VmdtY1FYR0p1L2RtYVVETDAxTkovaDdtYkNSVGZvZ1hKTDJOaHBEMUh1aTFn?=
 =?utf-8?B?UXFzbHpWK3FpQ1JnRjhQR3FmeStRR0UraDBxTlJjSE9RWE01T3lzeWpTdXIy?=
 =?utf-8?B?R1I0MjMwSXdDcnMyUUVaTkdoQkpOZHdaV1F1NC81cHhhMjAwWUtVZGRHQWNV?=
 =?utf-8?B?L2NlWVExMTVuV25YNkE3bWwxQlFHNVhWN3FQcVhPSzJYSEpySWpISW9EY3cz?=
 =?utf-8?B?NzRTL2FFTUx3NFJCNzNMZ0p0V2ZNVUp3bG9vV3JHR0pPNVpORzI0d1J3bEsw?=
 =?utf-8?B?K2VYdldMN0RIWW9oSm9hMzBoamptZUplM3o1UVY5djArZG11Um9RUmkzYVVa?=
 =?utf-8?B?Ri9MR0p1Sy9lczZocGlFNzRrdWVKOUMvSXp0RG45NDJKMVcrNFpiTWR0Sm8x?=
 =?utf-8?B?OHNmQ3pIUXhPU0k3N2FQdFhkOGZYYWo5dWxVZmxpajQvTGZsbWhJZEgwb24x?=
 =?utf-8?B?a1JTR2hhSVJXb3B3YmwwajBLczJ6SEs5bWZoQUdpM1p6ZDh1c2U3QndKQXZO?=
 =?utf-8?B?cGQ0TUFvNmszck03L2RuQWd5azJnQjRsUWQzSnI4RmpQaWZETEdUUE5tRHJn?=
 =?utf-8?B?dkhVS2tVbzR0Mko3R294Z0Fnd1VOUmNTY1h1OGZvd1hNTjlCc1gwNkRGL1gz?=
 =?utf-8?B?RjljTnpwTGh3U0Via0RXUnNpa0lwYUZ3TGhzSUNtdXBscEt2cFJhemtVbWQ3?=
 =?utf-8?B?c3BqVEFMRXBBMGR4YUYwcWVCR1BVa2tBRkRtZURjYkdFNCttOVo5eFdDdTJm?=
 =?utf-8?B?djdmMURPVC9UcGkvaDJkTTZ0ZFkwY0ZCRFBNazY2L2NsbUpQUWhPQzI4UjE2?=
 =?utf-8?B?WGhGUWJrVjVWVGE5R1RKNDhBSVE1UW1sQ2F2YW1NbEZBYVZqZmNNQnhIUnRT?=
 =?utf-8?B?K0cvN3VsRlIxNE9VT0FKUjlKTHZRL2JVbFoyU0IvT1gralFzeXZKMkd2OU1O?=
 =?utf-8?Q?WJntrkvYwwrRL7prlfXlT5x2xhJ4yb0LiN9XJga0+MwtJ?=
X-MS-Exchange-AntiSpam-MessageData-1: +DtEk5rP1J2TLg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e07fb5-3f50-4bfc-f62f-08df035bef4d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 10:22:30.2718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glSmcpVAR5/EnHuNGZmpR7nUuGbAsC93fAmt1YLlBICoZljknkGOS+A/xfnTcKY7FBHuG0bvG31LBPTTSBP6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9889
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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
ping v2

