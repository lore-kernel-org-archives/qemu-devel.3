Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C511C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woK4T-0003Se-Rc; Mon, 27 Jul 2026 08:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1woK4T-0003SK-0q; Mon, 27 Jul 2026 08:04:37 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1woK4R-0005Rr-2h; Mon, 27 Jul 2026 08:04:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIyQC9UAN16L5jGW3z3k9z3/DKAdfQlkGiPx+AjKeOpy/4gwP/dZn2inVx0UMYeSJqLtDZ/KjGz7VhAiTCEDRQqGIz2Wq+m5mwRqgi7Bf7nliou6Vc6E1gG0UvqYx6kmoNtqrktY5kVwI8fXQkdrbugtxJGbB9rhpIUfQSUeOSQX5itELTM8Z3XKCPYCgbfT+6qyzgSJzgMbQfx/Gm4BjFyW9sRgFg1iD5uJS8datGBAGf/OOXDyF76J1TB8kHJmIYEUIwm31Dixfr2AjtODEguwZ6+hBBurfqMBi84E7T0r1vN9Ac6zMpdQhVZHyk0ODu+ehQ6AOKeFPGP6k59YvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HG0WF/UGObF/yo+mOAr6MnboAUYVLow/UmIY/H17jzE=;
 b=qDoLg/i+MFw2mkGXo4s25ZV/4Tk1DJRNzPVPUmb4t2QvEOkQn1ciC1gPli2x70ooBZMxS0Ku8P0vu4g0ipccTdJN6kadTNwvqBFUlcnmjCPgVSo9zSjg0fZXuyis0h/qeBvHxI/TTRxr0r8by/WvEP4altyYJOlSjWFKBrafSTjQrcaRxhO2WFlUmKOJfO22cVycaBSmiwUDbJL3bdE5rIbmHuOnuSpiXafdCY39t64RRxP5tqO84tOLyUJgBo4yok3ieBoIu/v4OahU3plwtq39lHMciD+IoIDSnxUELpy/q+4whhpsDYyTtX8gvZvOmHuocCBlyTVsNcr50YIKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG0WF/UGObF/yo+mOAr6MnboAUYVLow/UmIY/H17jzE=;
 b=pHqNfVCx7FRMsHzbkM6iwnr2CSbFenDislds6YnkT2SJ12XAvexvbEShs0PUttXDXVruTKf0lYcxYgRozYFezHV/i+7XBOkeisQSyL1pw4jl+6mbYCQV+2tRViXhbj+LJXCuEeG9BXpyqlwWH1vxJZwSrxqAk8d9QvDCJI9PSosgfIYMME4ztaNVOxO4xtUxJ1S3n+ehebq/uRQshf2DVZmfS6UAOOUYz4F4Dw4sNoNvD9Kb1XjdACThDQ7S5+qJr481rmFzsgBGoxW0cw6xal7ZmVfUZ//8Vf1Tk/NPeNFvpHhmoXt0qDU7Zar/uTBGHfOLJH27STlH5qBMYGPhGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS4PR08MB7831.eurprd08.prod.outlook.com (2603:10a6:20b:51b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:04:27 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 12:04:27 +0000
Message-ID: <89b586fc-4fe9-4378-8098-7d0215a61d5f@virtuozzo.com>
Date: Mon, 27 Jul 2026 14:04:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20260610115850.2410566-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260610115850.2410566-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0088.eurprd04.prod.outlook.com
 (2603:10a6:803:64::23) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS4PR08MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b69ec85-9eb7-466c-f087-08deebd734b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|23010399003|376014|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M4VxtRnXEfL4S8UBUgvU3S5iQygyPDdJEdx9We7yiF7iHPtmjsk9aUrS+OoltxsMb9+FwGmOhTXAB9HMfbMbxRdtjRaMshShCNRgSrK43DWOlfGwlGDdzOcqAvk/VxltHnTRnLsYbxutYL9wZKNeiKTS0q3D9XrZNEMhO1VFKVE/MgZFtOqiq1fwQJzVQ96IdH04mS/6sVwuKHY1RKcKriBeKZr/hsEGBOSvwO74hfbpPH+8Um/CMwpO9e+6gEYNytpQWBLIPP8tfTWU9Pjpp/fsf6gMukYmea1dCbsSSacwlbBrzz3HWVZNAGlEvWkd3qggVgzuUxMY8Sg8/LaYLVjvcNBMw1e0GNHWwQpGZStLeIHOPqiIdDHw5TElqRqImpCBDaDdlhU+KoooaHl/2YEDxnvVnxdNy+JqYqUQsQq22jY8aTRkPqbz9vZfmgMc+PQrRKYlipfAaOjjUJZfYalhnjl+YSSCQhH6J+NHCIdVZNMMlYFWl02ON53ZnVKzwx83g6YYo0U8Z+0Yx7O+dbQsfGz4zgch+3BDWHRLuZIEGS/77KDQGOYGJpK0aGj5wQ6eSPRSb3PYFtcJHOIY3fODD5p/iB1jEyii5YLPfXn+5PMVWu7dyDZf9JYP6pJpSd6sdMZ876BZVKcGEwx27IBe5GpJX3TCXLpQ2qhjSvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlA3UWc4NVZkSEZBaWJTZ2pVQ0RQWjNxTXcrcnd5ZThnSi9tMEpkWHd1ZHFs?=
 =?utf-8?B?M2Frb2pwSU10ZEtDN3BzYWRoN1NLckZRQVR0Y0ErZGR5MHNycXlWQ0Qrd3BO?=
 =?utf-8?B?L0RUNmVhdXpPYzhkZFRBS0tuMGwxL0pwSFJpQzlLeTdXb0xSN3Ivc29iWThu?=
 =?utf-8?B?eWQ4ZnRNby9LVGhlOWJwcTY0TXRxUUVqd1MwQ1ZsNU9DZU5DYkRLRmlOSGFW?=
 =?utf-8?B?QmRLWFliM2ZDK3djRWdzcnpPOE43MXF5dmRFUDBjaVVKbW9PZC9UMG5Xa21z?=
 =?utf-8?B?cGdWR2x1TmYvK2hZM1JzWWtvWnpETzZZRDU4bUV2L3RGZVRKeGpVdTZOcGRs?=
 =?utf-8?B?a2FISXg4RVB0azhsVnozZU9QdWQ3N3lvdlFHdmYrU1FEalExODVLblM4dHNs?=
 =?utf-8?B?RnVOaUJxbE9CWHZWallWdmRCZFo4S3VPajFpblgwTFhLYmR4Q2l1QjFLMlR5?=
 =?utf-8?B?WEl6V3BZYnVHdEN4Nld0ckpLS1h3UmcyRXZ1eDUrc0xLNDdUYU1qNG9rVENp?=
 =?utf-8?B?K2RVbGJ3d21wWGFrMHp3YjU3NEtGSUtqbUFEamUyRkFoc3d5S25MZ28wcGww?=
 =?utf-8?B?dFhsOG9xSjZvRUVsSzlTQmU4L29pVjA4ZWNEMjkxNWlnRVdtSngrZ2c2d2F1?=
 =?utf-8?B?NUpFWWpGOTF1NWZJV0RJdGVyRDlIaEdWK052YWRzaTNKQmJxMHhSYXhGa3Vp?=
 =?utf-8?B?TU5pd3g1aTQrRXpQUzR1Mk9HaU9lQ054SWVKREVtbEhuYmkrZEU1ZitCQUFI?=
 =?utf-8?B?M1BkSSthL05qcXBZcVA1eGZYY1hOVzhRbU1RVEVrMnVQUlVmNmIrd1ZOUUhB?=
 =?utf-8?B?Rkl5c29ldWxDSVNDMCtPMDEvdExEUW5pK1RJZlNMSGU2YnpEMFNURDlDYVc1?=
 =?utf-8?B?RWJBQmRibUNWbXBiaEdkWXNZcVlkY01JVnB4bk5XbjhabVgxeXBQZ3VGd0RP?=
 =?utf-8?B?TUdqU0NTMDVsMW1ZUUhrN2luK20wNERBNFpEV1VRT3F3YjkvVWtJK3puWUJU?=
 =?utf-8?B?c0RLR0lvMW8rU01VY3FaWVY0UVlMVkFBUTJOd1VEV2ZlUWl1cDE2REN2V0dp?=
 =?utf-8?B?ZlhBUFhZbHZHNUtHR0kwZFAyUllBdFFIanhnUllBc2lZbUxVQS9vR3k2YXVk?=
 =?utf-8?B?TU8yV0I1OHkxZ0hyZXVMaXhndHlKdm9sb0dzQ1hTUXB1MXcwNFN3b3BaSDU3?=
 =?utf-8?B?Mk15YjYyNk8wUEVKRGM2M3ZUWmhrRlllajRia2VucTQ2Y0NQZHdOMnIzUjRw?=
 =?utf-8?B?cFJUN25rWmxNT3IxQ1lGcTBveXB3MFQyUkJDaFh4TXUzNjM0RDd0aS9YMEhq?=
 =?utf-8?B?OTU0T1pkaTViZHNTR1FZcmJWUWRLTS82K1ppQnp3dmdIczdxd0VrVnl0cWt3?=
 =?utf-8?B?dmlkekVIdG9DYW5GTXBSQzZwYjNpL0JXVHRnQ1hPbGtUcWxpdkNKZisyWEcw?=
 =?utf-8?B?bDdPdjNCelNPK3Nyc2F3QkYyc3BXbkdwL0VQR0NZQ0Z0Z3BIRkcrWmZnT21P?=
 =?utf-8?B?ekJUV1B5dVYzT3hqN1BUNXZTbVNYdEovMFNCNE8rT21lWVM3elhxWXN0cnFW?=
 =?utf-8?B?aUM0bnJRQXZhY3hjVldkNDMvbXFFaHZjeTZVUElNQ1kzMEMvSEFnOS9KOTJu?=
 =?utf-8?B?TFM5RmN3QmxRUGNZMzhQMlF6U2EzazQzVEdmOHlJNzZxWnRrazVvbTd0ditk?=
 =?utf-8?B?OU1sYklpWHRjUGNPakVrUDdjdjVJUDhWNWc5TmdZK1REQU92QnMwQnY2b1N4?=
 =?utf-8?B?MVBiNGdXL0laSitIbWNsUndHMHBJL0hoQ2ljN2pTSEllS0tyQy93Q3BTbmxa?=
 =?utf-8?B?Y0FYSGZjUlRUOXIyY3E5RS8vS0NsbUNqS0swdjZIbm40dFhNK2l6VGlKYzdX?=
 =?utf-8?B?QVhUdFlTV0pFZFUwdm9JN1dEcE96WUJRa0tPcS9jSUhxNzhybWhJcnZvQWlK?=
 =?utf-8?B?SkFLdDR3dm5aZWIyTFViOEUrZkNaTnc3OWk3VGRnbGpWRkVxL3hnbk1DemhV?=
 =?utf-8?B?ZnhwUUFFL2hoNmZpUWZnZWxGTEZHWkxqdXhEcTJlT1lFUGpWZ08xa1Z1ejZn?=
 =?utf-8?B?T3FFSE9sRHhsWU5oczRkcHFrNi8zQmlRTUFZa3N0NzZXdjhRaUNybGJveGFp?=
 =?utf-8?B?bEo2ZkRmRkt6WWFhZWV4RGRVWHFDMnBuRUJVRS9KMjEwZXR4VjBMRHp5V3Vu?=
 =?utf-8?B?U0NpVFplOEJ0NWhxclpPTHpUNy9MR3FxVHpHdVB2OGFKbDVGZzJMWGJDNUNV?=
 =?utf-8?B?MFBXU05SdUdTR05NVjhiV3hkVDM5N09yWXRrZnJlVGhpejlzY3BBWXFXbGxS?=
 =?utf-8?B?R2hlcWxxM1p5U29TSThvRjJGSVRnU3RUMW90Z0dkdDVPSUp6TThpWHQxMzJQ?=
 =?utf-8?Q?Ctb2qJtCtMvAeULHsLUwzv5RN+BrpjQZTNL9Ufdd1dA3B?=
X-MS-Exchange-AntiSpam-MessageData-1: 8IE26ufYH3zCFQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b69ec85-9eb7-466c-f087-08deebd734b4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:04:26.9369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okP9GpMZI+c8s7aE3Xydfud7E6RUF057ygeWZDCS7kWfu7nWgbhDmYLgytFgVFoV/8FB8jeMxh/72IA7i+qH/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7831
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

On 6/10/26 13:58, Denis V. Lunev wrote:
> Changes since v2
> ----------------
>   * Drop the redundant fast-path check in qemu_co_sleep(); the publish
>     cmpxchg already consumes a pending wake (Kevin).
>   * Add a deterministic regression test, no threads or timers needed.
>
> Changes since v1
> ----------------
>   * Patch 1 (graph-lock) applied as e3082ab3b3, dropped here.
>   * Fix the qemu_co_sleep_wake() primitive instead of working around
>     it in qcow2 (Kevin).
>
> Problem
> -------
>
> The qemu shutdown / blockdev-close path can deadlock permanently on
> upstream master. The main thread enters ppoll(timeout=-1) holding
> BQL, no other thread has a wake source that points back at it, and
> qemu has to be SIGKILLed. The hang has no timeout -- it is a hard
> deadlock, not a slow operation; behind BQL, RCU, VCPUs and every
> iothread path that needs BQL stall with it.
>
> The race exposed in qcow2's cache_clean_timer cancellation path:
>
>   ppoll -> aio_poll -> cache_clean_timer_del_and_wait -> qcow2_close
>
> The race diagram and the exact stale-state read are in the patch's
> commit message.
>
> Reproducer
> ----------
>
> Environment: 4-vCPU VM guest, kernel 6.12.x, upstream master at
> de5d8bfd61. On modern bare-metal the window is narrow enough that the
> hang rarely reproduces without a VM -- a VM guest under full CPU
> saturation is what makes the timing reliable.
>
>     # reproducer
>     stress-ng --cpu "$(nproc)" --timeout 0 &
>     for r in $(seq 20); do
>         timeout 120 ./build/tests/qemu-iotests/check -qcow2 iothreads-create
>     done
>     kill %1
>
> With `stress-ng --cpu $(nproc)` the race surfaces. With
> `stress-ng --cpu $(($(nproc) - 1))` or without a stressor it does
> not reproduce reliably across 20 iterations.
>
> The new unit test reproduces the same lost wakeup deterministically,
> without a VM or a stressor.
>
> Results
> -------
>
> Same guest, 20 iterations of the loop above, master at de5d8bfd61:
>
>   without this patch:  reproduces reliably (qcow2_close in ppoll)
>   with this patch:     20/20 PASS
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
>
> Denis V. Lunev (1):
>   coroutine: fix lost wakeup in qemu_co_sleep_wake()
>
>  include/qemu/coroutine.h    | 17 +++++++++---
>  tests/unit/test-coroutine.c | 53 +++++++++++++++++++++++++++++++++++++
>  util/qemu-coroutine-sleep.c | 53 ++++++++++++++++++++++++++-----------
>  3 files changed, 104 insertions(+), 19 deletions(-)
>
ping v6

