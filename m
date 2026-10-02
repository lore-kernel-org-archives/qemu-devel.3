Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4EFCA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfxs-0007wL-Rr; Fri, 02 Oct 2026 12:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCfx8-0007it-Bh; Fri, 02 Oct 2026 12:17:43 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCfx5-00050E-UD; Fri, 02 Oct 2026 12:17:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaH4wJINm2yWDnyluKmtbLZi3y0qg75+BXE+DGv6bTjo3Lc0aZKEg+IepULVSA+TRYDzgkNpGEchMvk/qmnhIAeYIJ0gz5Gi8FXZt+lWvE4Y500Kkkx2HIa/o4oa910l6EwwqspUxO0VBHP1HomUA5llSBttO39QcGFSffvlIGVetngBxNKntVp/iM4kBLpWsAPSmoCqFQD/EHE2Oww9VHfwI2ivKHgf1PlnN+KayLMrwU2r8tbiyS6X7Wy2ueFbTSy8o/O+MlPazKNJ6lX5iul095mSTYv859yU2w907YEEN64PS+rhq/HD3TEcgk04YFQhZEBVS+onzwTr3TJ47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8t1TvHEbHdcRn6FyK66JKIB7xDD/fAm6ISY071wzIM=;
 b=x1onHToo2ZbYqJViWvFUR2rKpkvPlyOllfK0ggmI7nsVkjHE9hMJ+9pTexAEKLjmuGth68ETqC+tOmHX2yLd60G9MRdu/zp1sC4scLaSjdenZzo5KoceWcQ8YGh+otWz38UEAfOLTk1i6y+y+dMVWbP7xpBGaAv07bsqmYfjoUfucjT9y2r01GPQYD2Sht5aKXQa1O8Fkge5EtWK9uuk4ixQOXPAT5SYLY4Uw2Z+ZcCnQ9TCCGbRJZXDGVtTCMz7AVJIdzYacs7HNsKzUol22Hb4BUAaZyfXFUjXiEeZjcKDPPl+YYgoKFsIQmjaocwhbr8aZ1EiT+q5UjHUBD2tjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8t1TvHEbHdcRn6FyK66JKIB7xDD/fAm6ISY071wzIM=;
 b=tabj/4k/YNw9u1wmxdLFTcowJpe/C05+H2K3FJ6BlNRBAhOw/sOsn4eAZp5s9yfkij/C8BH2dNUEBiCI6gYuqpOEs2xlIhpGvoiDEiB0ei/40O5xxi9DBwCZCYD5eZq2E3nRlw0+RUiiEDLrcT3gLhidWOZm3JSyHP1ryUwh9idByK9Vk5BzyyniUOVXgLHSr80yhXzy8gBvd6ETxjYFTYxM6XcEwOcIT9IvgWGsdG4mCNPLvQ92ZKApBjn4UxP9RlPEvBFXIvBHMmZ1xHMlKHNsWL2TZN5rg5Tpc4D++dN5OP3GH9j56a1ctdrE0gmO3kqJEWmPDbO1htSJnxhafw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from GVXPR08MB10667.eurprd08.prod.outlook.com
 (2603:10a6:150:15a::13) by PAXPR08MB7396.eurprd08.prod.outlook.com
 (2603:10a6:102:2ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 16:17:21 +0000
Received: from GVXPR08MB10667.eurprd08.prod.outlook.com
 ([fe80::d70a:96e3:8888:668d]) by GVXPR08MB10667.eurprd08.prod.outlook.com
 ([fe80::d70a:96e3:8888:668d%5]) with mapi id 15.21.0496.010; Fri, 2 Oct 2026
 16:17:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/13] block/preallocate: hold back writes into a
 preallocation in flight
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260930165000.303236-6-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-6-den@openvz.org>
Date: Fri, 02 Oct 2026 19:16:59 +0300
Message-Id: <179095781937.643598.10736910750466449353.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR09CA0091.eurprd09.prod.outlook.com
 (2603:10a6:803:78::14) To GVXPR08MB10667.eurprd08.prod.outlook.com
 (2603:10a6:150:15a::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR08MB10667:EE_|PAXPR08MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edf3968-a3e7-4169-3df3-08df20a09ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|52116014|366016|376014|5023799004|56012099006|38350700014|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5lcaWvTqs7ynQqKG2/JVIbcMVKqmqWzb9xlfDuspFLPZOWdpGqmHPm+3kH9gV2Zy18C95rVBCZp47YUuUGUM6dh3XWEheT4AOAaLN9YiPNyKdG4sQO/CcXw4fAb4cap9KaHhFtfCX9koTDT2nGztXL5IJq7pdrOe5vgptHhQnu2D1RDSSefFAsnJmDGF8BWIqG0amr3i9duNPIHqgK5SSQwa9jjhqrBOp+NA/Png5lfLwx9yokWx2mjf3eo/dKrQLmRBkbpo4Ee2U2j4hqIcnTTnIYSiF1HLYBmAEvjP6h1S1YKDlMjyaebKrfkGlEc/O58033CcSVwfxLqffucbnkQNAVaeFedG2Niy+dyl3NVdXk7J8zsZr3Q/wGF4hxMLdqMHWZhHsWOugKmpzrS5BsrG+ZRuJJXATsvC0ws6F1EMLOPWqSH1jE19krBUdXWBjEjSD6j+wqyeVNRghaf7tPmPTmRfqWGODECDGfN6FYa+DpVJbNMSspuU3gRozjE5SPBCpdQrMpqKq873XrnxKtaUw0lMdN2lIYbZDohaaDJdL3nSOhB2Dj07GyrD1pjIc+TTSThyFpROy/7p1iAuqpn6EsldE1Mo3POJBwci/0o6sTShyy5vp0bSXFGG6EFQhKHy7naqZXp+LDyIcg8uiYAufw6GXGwlNaPgBP2IzaRTzWyHYhbh7MS/yP5mc56mhCkuyo+mfMdWUM6Cx1bGIfwX+iVGqQ+sxSqPHCLX+dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR08MB10667.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(52116014)(366016)(376014)(5023799004)(56012099006)(38350700014)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWh1Sk9xVm40aUVlZ01XWUN1eUZsSzRVWXFmS2NSeU5QRDBwTFJiblF5bzc1?=
 =?utf-8?B?MVpWUWtvd2hUV1lvR1gwWGVnVEkwS2Vjd0tuWGVyOTlXUUVwdm5BTEVTblJp?=
 =?utf-8?B?czlnY3Vza3Z6Ym80SnhCV1R3ejc5M1pYK2NuMXkyYkE3T1R3Nkd1S1RGeHBp?=
 =?utf-8?B?cTI0QlJGQjg0OUZ3QjdsKzEzdW12bjNTaVlCMEp6dmovcFZEdXRRaXZiUXhC?=
 =?utf-8?B?cjNhVWNiaFQ1OWRRVElvdXRoNW9GRXZGRHdPUVI3bkllY1owb0tHWVg1ZTVV?=
 =?utf-8?B?Qmc0RHFoUjFQdFpSRC9WbHVaaFlUQldzaklaMThoKzNoVVcvZXBzZFFDUVZN?=
 =?utf-8?B?SWFrU0MwdEFpdlBhTnFSL2hMdkx3Qm9oRE02NWZZaEVPdFdnK01BOWZ6ODNm?=
 =?utf-8?B?Y2kyWGJrdzBzL203ME9wd1ljYWFxaVpjK2Z0a2ZyUWlhcGFtQTIraldzdTdv?=
 =?utf-8?B?VkJUWDRnVHZrYjJZeTRsajZ1NXE4RjVFKzV1VjdBT3JwWVdkb1lvUDMyRlBO?=
 =?utf-8?B?K3Q0RlJrbzFmRkh2RnNvQWd3UWZBZ2pRb0tKTmNRc1hNS0VQZGx0ejNybEFS?=
 =?utf-8?B?TFFqZGJ1U2I0VFYwVERHVlhHRGdWQ1VoL0J4cWlPdWhIVm5RUjd6SklkNlJP?=
 =?utf-8?B?YnZ5SFZwcTVPc0lzUkppWm9HR0hEdnhNQWRpNW1ZM3pyVlVaMFRSejNQZk1U?=
 =?utf-8?B?eXRUTCs2NGtrZFlway9iSlRTbThrUzZpMkxRZXYzYTJYZ0U2OGZTdlYwV0U0?=
 =?utf-8?B?QThtZ0MxZzlPd25nem1lbzJuSmVDbjhrUFdpTnMzQll1N0R4a1Q0Slk0cCtZ?=
 =?utf-8?B?TTZtblBxamVwdTY0bEhsMHNqM0dNR3l0dEZJSFdadmpoQlpYckpvQ3NiOE8v?=
 =?utf-8?B?OHhvbHRnYnJ2d2kzdUZoejVDbXdiZU0rODZHVnd4NVVTK0lySkNvdHRSZWEy?=
 =?utf-8?B?TW5hM25LZlRWRitKT2I3cjVldFdLdFp0YThkVjRKSGY0NnQ3RWRic1VFbXdi?=
 =?utf-8?B?RzB3akZpeVRjV3YwRExTNXJLWnp5eFlvY240OEFXdTRWL0dPOUhoZlNPRm9Y?=
 =?utf-8?B?TkdaVmYzcGpaZHBaTEd5Rm0vS1ppcmI5S0Q0OHhrZWhVZndlVTlpaDRZM1FZ?=
 =?utf-8?B?N2wxNFRqRHo3ODdLa3lNa1ppcUdFNXBET3FBaFdub05JK2hEbnRuWk85bEIv?=
 =?utf-8?B?L3MydDAxMmhUY0VEY0owaldBL0l0M3I0Q2hjRWw4a3U2UXZ5Q25zSTU0WmVw?=
 =?utf-8?B?elk4VHFOSjRvZEZSa2Fvd0FlSnNpeUlaeCs1QzM0RkFuTU1VQUZ5NmRkVTVH?=
 =?utf-8?B?Ynk0NmppdjltMXBPT011eURxd21pSkJlS01oMGU4dURXa0JCMldFaVhremRF?=
 =?utf-8?B?cHBZRE1NYWNyZnpLeFljVW4zSmJhVWxmaGpoUnEremZjeHkxc011NlUraXc4?=
 =?utf-8?B?clI4U1FrQjR5SHJaY05GcmZ1eWhQM0RDWjRJOVMwTjdkdkt0eHpRQkxxWktM?=
 =?utf-8?B?V2pHbEVNOVdDZ1I3QlJHSTNMQkNsM3p1THBHVnlyTnJMWUFlM3JiaFFMYlE2?=
 =?utf-8?B?aGM1ZC9sWUFrMzR5dE02RFd2Y3BvVUpVUENuY05tTzdxWHpVSWhwTFk1SDN0?=
 =?utf-8?B?NjgwYXZIcStQb0tnV1padURWWHVBWmtXTFl3LzRlRFVZdVBCcWR3a09veC9Z?=
 =?utf-8?B?NzA0MXRZaXpqUFBncm8zZjU4T3VBQ01VL0Q3NG80eTNYRzhoT3dIYjdHK0k1?=
 =?utf-8?B?OXFKSmYrZVlUdUM2ZkJZUnRLK0xIeFJSb0hqNG5mSVBISitzNHlvUjNubllO?=
 =?utf-8?B?RjFqMlB4WE4zb1FQRDFqc1NFeExoU1YrbWZjQmVQVGR4SkR1YUJyMEZrRFIw?=
 =?utf-8?B?SkZ0VW5BVS83VWhVd2JNWTJ3V2ZBV0pYdEp2Y2VBR2hrczhHNzl6L2tlaDVx?=
 =?utf-8?B?VHBhSGlZWFVzZlZlRi81dy85UytRWS9DRlVzeHZxbGc1eXRPYkFaOVdpRTZh?=
 =?utf-8?B?RWdSMzRVQWVnV2t4NkNRZTE1TVMxWmg3Y2RtTjgzK3ZLRnlZZTNaaGxHdjI0?=
 =?utf-8?B?UEpLeFR1SUhHbUdmLy9idW9zSXNpdldaejJJZytka2tyMjVhWGE5U2NyZGQ0?=
 =?utf-8?B?WHV3UmhLcTNONXFCcWplV1hMNGpBclVUV3Zuci8yaWsvQlRxY0Qzb01CTncz?=
 =?utf-8?B?MFdobjQ2cDg5VE1ieEJoRnlPa3VGdnBwMHdrZ1dreDJGelB5VzNWUTUzdGxK?=
 =?utf-8?B?NFV1RFJCTm5Obkk5bVdkUDJmOE9xdWx5NXFzU2lSMmE4cUF5bUV5K3VxZGsy?=
 =?utf-8?B?eU80VC9mS0EycHNZS0NZNC9ZVHNFdjM0bEl4SW9NekdiQnJlZlkxMkVJUjAr?=
 =?utf-8?Q?3pdNgqvV1RkH6WcA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edf3968-a3e7-4169-3df3-08df20a09ac8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR08MB10667.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:17:07.5105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TI/EvQWaTtl/vYWwBDJDJft+M0Ofy6/Ijf/yhX40OmJzsadIR++Hs4Gs2ABjY6ahgkbprtSRSHp1COStGha4BCnkXQLvSXVz800rKrpejI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7396
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

> The previous patch holds the mutex across all of handle_write(),
> including the preallocating write zeroes. That is correct and far too
> coarse: the fallocate takes as long as it takes, and every writer that
> extends the file waits for it.
> 
> Reserve the range instead of holding the lock over it. file_end moves
> to the end of the preallocated range before the request is issued, so
> a writer arriving while it is in flight works from a length that
> already covers the range being zeroed.
> 
> That leaves it going straight into the range, and BDRV_REQ_SERIALISING
> cannot stop it. Serialisation orders a request against the ones in
> bs->tracked_requests, and the zeroing request is not there yet: the
> filter runs above bdrv_co_pwritev_part(), which is what tracks it.
> Whatever the filter lets through in that window is unordered by
> construction, so the filter has to hold it back itself.
> 
> safe_end trails file_end, standing at the lowest start of a
> preallocation in flight and reaching file_end once none is left. A
> write above it waits on a queue and re-reads the state when the
> preallocations drain. A write zeroes merged into a preallocation
> starts it below file_end, so safe_end has to move down as well as up.
> 
> Below safe_end nothing can be zeroed any more, so those writes do not
> queue, and below zero_start there is nothing to record either, so
> those take no mutex at all. The stores are qatomic_set() because that
> path reads them without it.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: qemu-stable@nongnu.org
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/block/preallocate.c b/block/preallocate.c
> index 442cdb01768..128f1da0145 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -32,6 +32,7 @@
>  #include "qemu/units.h"
>  #include "block/block-io.h"
>  #include "block/block_int.h"
> +#include "qemu/atomic.h"
>  
>  
>  typedef struct PreallocateOpts {
> @@ -76,6 +77,21 @@ typedef struct BDRVPreallocateState {
>       * BLK_PERM_WRITE permissions on file child.
>       */
>  
> +    /*
> +     * @file_end is reserved as soon as a preallocation is decided on, so
> +     * that the next one starts above it. @safe_end is the lowest start of
> +     * a preallocation in flight, or @file_end when there is none: nothing
> +     * below it can still be zeroed, so a write ending below it does not
> +     * queue.
> +     */
> +    int64_t safe_end;
> +    int prealloc_in_flight;
> +    CoQueue prealloc_waiters;
> +
> +    /*
> +     * Nothing done while this is held may wait for a request that has already
> +     * passed the filter: that request can need it back.
> +     */
>      CoMutex lock;
>  
>      /* Gives up the resize permission on children when parents don't need it */
> @@ -106,9 +122,17 @@ static QemuOptsList runtime_opts = {
>      },
>  };
>  
> +static void preallocate_set_file_end(BDRVPreallocateState *s, int64_t v)
> +{
> +    s->file_end = v;
> +    qatomic_set(&s->safe_end, v);
> +}
> +
>  static void preallocate_set_state(BDRVPreallocateState *s, int64_t v)
>  {
> -    s->file_end = s->zero_start = s->data_end = v;
> +    preallocate_set_file_end(s, v);
> +    qatomic_set(&s->data_end, v);
> +    qatomic_set(&s->zero_start, v);
>  }
>  
>  static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
> @@ -158,6 +182,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
>       */
>      preallocate_set_state(s, -EINVAL);
>      qemu_co_mutex_init(&s->lock);
> +    qemu_co_queue_init(&s->prealloc_waiters);
>      s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
>  
>      ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
> @@ -188,7 +213,7 @@ preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
>      int ret;
>  
>      if (s->file_end < 0) {
> -        s->file_end = bdrv_getlength(bs->file->bs);
> +        preallocate_set_file_end(s, bdrv_getlength(bs->file->bs));
>          if (s->file_end < 0) {
>              error_setg_errno(errp, -s->file_end, "Failed to get file length");
>              return s->file_end;
> @@ -200,10 +225,10 @@ preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
>                              NULL);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret, "Failed to drop preallocation");
> -            s->file_end = ret;
> +            preallocate_set_file_end(s, ret);
>              return ret;
>          }
> -        s->file_end = s->data_end;
> +        preallocate_set_file_end(s, s->data_end);
>      }
>  
>      return 0;
> @@ -345,18 +370,21 @@ handle_write_locked(BlockDriverState *bs, int64_t offset, int64_t bytes,
>      }
>  
>      if (s->data_end < 0) {
> -        s->data_end = bdrv_co_getlength(bs->file->bs);
> -        if (s->data_end < 0) {
> +        int64_t len = bdrv_co_getlength(bs->file->bs);
> +
> +        if (len < 0) {
> +            s->data_end = len;
>              return false;
>          }
> +        qatomic_set(&s->data_end, len);
>  
>          if (s->file_end < 0) {
> -            s->file_end = s->data_end;
> +            preallocate_set_file_end(s, len);
>          }
>      }
>  
>      if (!want_merge_zero && s->zero_start >= 0 && end > s->zero_start) {
> -        s->zero_start = end;
> +        qatomic_set(&s->zero_start, end);
>      }
>  
>      if (end <= s->data_end) {
> @@ -365,13 +393,13 @@ handle_write_locked(BlockDriverState *bs, int64_t offset, int64_t bytes,
>  
>      /* We have valid s->data_end, and request writes beyond it. */
>  
> -    s->data_end = end;
> +    qatomic_set(&s->data_end, end);
>      if (s->zero_start < 0 || !want_merge_zero) {
> -        s->zero_start = end;
> +        qatomic_set(&s->zero_start, end);
>      }
>  
>      if (s->file_end < 0) {
> -        s->file_end = bdrv_co_getlength(bs->file->bs);
> +        preallocate_set_file_end(s, bdrv_co_getlength(bs->file->bs));
>          if (s->file_end < 0) {
>              return false;
>          }
> @@ -395,16 +423,27 @@ handle_write_locked(BlockDriverState *bs, int64_t offset, int64_t bytes,
>  
>      want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>  
> +    /* Reserve the range; safe_end keeps writers out of it until it is zero. */
> +    s->file_end = prealloc_end;
> +    if (s->prealloc_in_flight++ == 0 || prealloc_start < s->safe_end) {
> +        qatomic_set(&s->safe_end, prealloc_start);
> +    }
> +    qemu_co_mutex_unlock(&s->lock);
> +
>      ret = bdrv_co_pwrite_zeroes(
>              bs->file, prealloc_start, prealloc_end - prealloc_start,
>              BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
> +
> +    qemu_co_mutex_lock(&s->lock);
>      if (ret < 0) {
>          s->file_end = ret;
> -        return false;
>      }
> +    if (--s->prealloc_in_flight == 0) {
> +        qatomic_set(&s->safe_end, s->file_end);
> +    }
> +    qemu_co_queue_restart_all(&s->prealloc_waiters);
>  
> -    s->file_end = prealloc_end;
> -    return want_merge_zero;
> +    return ret < 0 ? false : want_merge_zero;
>  }
>  
>  static bool coroutine_fn GRAPH_RDLOCK
> @@ -412,9 +451,22 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>               bool want_merge_zero)
>  {
>      BDRVPreallocateState *s = bs->opaque;
> +    int64_t zero_start = qatomic_read(&s->zero_start);
> +    int64_t end = offset + bytes;
>      bool ret;
>  
> +    /*
> +     * Below zero_start there is nothing to record: data_end covers it, and
> +     * only a write zeroes that already covers it can preallocate over it.
> +     */
> +    if (zero_start >= 0 && end <= zero_start) {
> +        return false;
> +    }
> +
>      qemu_co_mutex_lock(&s->lock);
> +    while (s->prealloc_in_flight && (s->safe_end < 0 || end > s->safe_end)) {
> +        qemu_co_queue_wait(&s->prealloc_waiters, &s->lock);
> +    }

I feel this patch logic might be over-engineered.  Let's see when we
ever get past the above waiting condition.

1. To start a zeroing a writer needs 'end > file_end' (otherwise "no
preallocation needed").
2. 'safe_end' is always either a start of the running zeroing
preallocation, or just 'file_end'.  Thus condition 'safe_end <= file_end'
is always true.

Now the above wait loop.  A writer can get past it in 2 cases:

  * nothing is in flight -> it might start a preallocation zeroing, and
    it's  the only one;
  * something is in flight but 'end <= safe_end'.  But then based on 2)
    'end <= file_end'.  Then then based on 1) this writer cannot start
    zeroing.

Please correct me if I'm wrong somewhere up until this point.

Now, if the above facts hold, it means that while 1st zeroing runs
nobody can ever start a 2nd.  Thus 'prealloc_in_flight' only ever goes
between 0 and 1.

And if so, nothing prevents us from safely getting rid of the queue, the
in_flight counter and 'safe_end'.  We can just do:


  static bool handle_write(...)
  {
      ...

      QEMU_LOCK_GUARD(&s->lock);
      return handle_write_locked(...);
  }

What do you think?

Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

