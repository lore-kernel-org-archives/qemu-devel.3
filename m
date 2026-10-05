Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BA9CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 08:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeWw-0000Ha-U7; Mon, 05 Oct 2026 04:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xDeWr-0000HS-M6
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:58:37 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xDeWp-0002WL-Ks
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:58:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi7lJUQmZ91xDtG6ev5JGl6bbhQoqdfNwVbTTrsRjaYbQCKEoUPvZeXPWtPGwYgz2CZJxA/dxTk9MlW4S+VfBTpbWp9Tw1o4c0Gg/4O8dudQ1pkLO07VUy2No8kU7oUjZlF9V29OnpCDtXz2x48xDKheB6AdgX8YZTWV/Rm70ZKx4krZRgNRn+FrsvNeHmOOPKx39prKU9M20yB0eaRof+gGEH6mXAXqlXFaJbv5fGxleqr7lkIqQN12xuWAwPZR32aCTSHRUsIqu0acZ2YOaMQkB6kiyRjUOd3s/J8aMakpo52tW0pZIIe/pHi9fNs400c/QLFobTzek9W8R8OpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyyC+tCwXgk2szBhvWP3h5EPiPUQruudt7c07gp6iHs=;
 b=AvgK8KVn9JJopp2K+wL7VLq9wsadRB0QgyZw6OdvO6hnDGC/1hYBqerQQlPk57733ETULPu6Xv/t2mQxtxxN+6sOeQ6Eu4wVSi/DXY7MweDgFZi/Q9tRnsBncItBs7ZI+VnDe+IbqnNmo/RVOmjEn4jB7tfmZ5LUu0a23I6GVYn2GQJpZQAzjyF2F+L0lSKCusj5vfjKN5b+IZl0FixNx89GQXPgkk7OPLFPIBWyMbAtwyOJRFtJLo4KgqW876RHuBj75BFI4nQrVS8dc8+ApCIYqmdjR2msMAIFAduzOfhNijWuYlKfVYbD07OVw3B/U2sPH1chCVYoLVo1SiHIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyyC+tCwXgk2szBhvWP3h5EPiPUQruudt7c07gp6iHs=;
 b=PHZCovvkM2znox4X/MhFY5himBXTlyU4VdAAeVSbWBcQv7v/Les/f4nZ0/dzYpDhbSzUDSYsLuaz6YwLaxVdmxgGB8kKJbwNrGPaK3F/HW1nCjd1rAdGWooQObzNe2n6Meob9J1bKbPNYAdsfw4wSwg/DgJhSTCaqoTeRymvqP3Em4NggnRqhq5r1xkkAC2O80sT5CHOotx97nupFlKP6RuWkj2f/vBLkFZB67aGarfUnReY7lKx7ADw6Ib6dyOUikiUqQ4eIcL4Lg7pewSzbuCqgyV4cUepZm/iFn8cuXVr/ebV3oDDJIDeVPmYsoWWNYx/SoVNGOSgWR8XSM2/UQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA1PR08MB556523.eurprd08.prod.outlook.com (2603:10a6:102:54f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 08:58:32 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 08:58:32 +0000
Message-ID: <86b784f5-60e7-4be1-8052-068caefdabb2@virtuozzo.com>
Date: Mon, 5 Oct 2026 10:58:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hostmem: fix cpr-exec of VMs with bound guest memory
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>, Igor Mammedov
 <imammedo@redhat.com>, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260924125800.4188406-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260924125800.4188406-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0115.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::13) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA1PR08MB556523:EE_
X-MS-Office365-Filtering-Correlation-Id: 508939ce-f385-4fac-5bd6-08df22bed518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|10070799003|366016|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oinqWBFVNb9fKN2aMFrw3l43Bj1KadjMU1rZ5QMUjH3SMpTlV3Hmt2k8RcXq657s8fuet6Oywpj4fueSBb9+/nKPBMtx95GfIv1VdnBGZTZz16NgNQvwlLWNnedImNQ5C8q5wx3D9iW+V+tVc3jE22JXVaiigefBqrKH3gsJlg55oCmlkP02iiHSwbPeKN2WI8Hl9Y9slf3cWESlBAZ/wCpH0l3bsv4nz45Ft26jO4zo6EovRunKEB6Bmy1rrOF9FNQMWTTYziRMF6unYVcs74x+TnXzqbEqiWe8PhUnNoTosqQ7sPmP9kBPMwQBO0T89vB1/c0E/NP95dAKZe+XRFenmYlXMqR0p1p3Nih7WiT4lvajsyzKH/WNG0VtKNN9/KkDX3DsGuC1PY+La/EpICyv7qeneXTy9dipdHoXEjCaSuyuH8pWfUWQKctH4wnuPKrH612AU60qKrziGsS0VcQbyFCBuc3tyEpTpX8aw6IcNhlc2GYVOl4N8xZ6vUvUrD2BK+zqJa9u6PEbMP5vYh+8tYOEh9Djl4HQJTSiDc8+KyDXowRRMeEExl947q6lCelu6jQS0/vaXNr8T7j3of55o7s4sFAKtZ3ww9fmk+++bHfSZykfV6LdkG4BwCAdX/OsSn9k4mDWtQ8LFDqZT6Uxw53rIS5UHbdVP7iPzz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(10070799003)(366016)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1lUNy9JZ05JOWpySHZDYWgwY256VTdFMFRsSk15L2tnLzFYNHRMS2NYR2k5?=
 =?utf-8?B?NDVHUktmaVR6Mk1ad050SFJENjRaZDRwTTFYNTRGZWNPL2lHNVhBOG8vaVZh?=
 =?utf-8?B?a3gyV2dDNEkwSFpzZWVFNkFoT2xsa3dnRjhyZ0RYOTg4aEZNUDYvRWtldi9i?=
 =?utf-8?B?ZERRYVdVL0d0VUkzOVZaaFI5RmxTc1VjVkpwWWRtRFNSQ2ZwWVhaNWozL2JZ?=
 =?utf-8?B?RVJTZ1FKTlVjQUNhUHdEV2lKUXRVc0NMSXRsMFJBWnBsbVdsNk9Zbno5eWty?=
 =?utf-8?B?TGdYYlpONExJNy93SFJHRE41dXBYMTZERkV3bFBmTVJxWkpXS1hSRjJVOTAv?=
 =?utf-8?B?TFNLczRFZUtEZHlTZ1JEUGF0bHBkdHRTU2daNERRS2piVzdsZTBxVHpYNUla?=
 =?utf-8?B?ZVFrbVZTMXFueDc5cFE1eFdLZUgxMGltZThiSUx1TE9QOFJRL3ZEZWp3emZq?=
 =?utf-8?B?ZWdlODBMZ3h4S005c0RDZ0RPQ0d2eUEwVWF1MDhoMzh6U1luREN4RmY4U0Uy?=
 =?utf-8?B?czNCRlJUT1FSeHFTZ0FYTkNpUXlrWWF6UUZuK0lYSE5pYVBCNlY5UUNHNE95?=
 =?utf-8?B?S1UrL2tlTlZzcjNObW1SVGFnVy9pYVZ0MzZxMVNlN0ErODZma3d0eENIbk5E?=
 =?utf-8?B?SlJFREFsK0l1RWgwUzc3OVVjemNMWGgyeTN3b3g2TVBlOW1GTWlRSkJ3MWpK?=
 =?utf-8?B?UlpSUlNOSVB2RVNTMk1TanBBQ3ptTk50Yi9tQTduV2Q2VzJWaWhjSVJ1Ujdy?=
 =?utf-8?B?aG9XU0ZWT3hMMktjaXlZbGwydlNaYnFLVlVHVHpRNUNBaWliWGpvRUhaR1Z6?=
 =?utf-8?B?SGRNdFRUTTNsNWh2R3lWS3BkUVo3a3EvenQzcU5hazkrdk5hRHN1aEZQS3d1?=
 =?utf-8?B?VDNqRTUraW52QitxczZ1Z2VzbitZQVBXOHVuRGNvOHRVTDdGVDErNUF2OUZK?=
 =?utf-8?B?blk1NXNUSkU5SjgvWjNpTHc4NXVRTXNoNmVuTlNRSDlIVkFYRVZXR1NGeGdC?=
 =?utf-8?B?WWRvOS9JUHJrWXhqNnlOV1NJMGQrSittZ3BkajZQWVQwbXdLZEd3T2VHVDVL?=
 =?utf-8?B?dzRweStXZjNiS2Q2RlBJYk03VDh6WUthNTcvQys5SUZXN3RIM1hZK2xnV21j?=
 =?utf-8?B?emMzZmt3MmU5ekNDSVF4cU9mN3N0ZSs4MWtSeEQvM1gybWJEZkUySkxYSWFY?=
 =?utf-8?B?cEVUaktMNDQ2YWlJb3VjOU5zTzZ6ai9pdHVyVGhEYzNKY0VhS2NtZG15RWZk?=
 =?utf-8?B?eENoQVAvbFZsOFV5OUtKbVdIejhMRFBTNVdzMjFLWmowUWJPMmJITjFGMUho?=
 =?utf-8?B?ZEhaeHRzVzFhOUxDSVVMT0h2NS9kUmc4VzdmUjBybmNMY1FkTWo4eGVlTXpB?=
 =?utf-8?B?V1l5dVhzSzRVbnBmWjZyQlNNb2dHdEIxTmpmMi9Qby9FL1BxeVBNMXNhR1hs?=
 =?utf-8?B?RElOTzl3YzdkeVVrU3NzREtzR3h1cU5HaFkxc0lia1c2Sk0yanhXcm8rMFdN?=
 =?utf-8?B?Mkcydll6MFJyTWcxYjdpYjlMamdHODlFQjY5S0hBNUpXVTMzMU54MU5rN3J6?=
 =?utf-8?B?VkZpVXg1aktvb3czSzVxTTBTMFBTd1BSWm9GZHQvOExYY1RpaUNZR1FXbU5y?=
 =?utf-8?B?L2NNR3R1YjBjeExMQk4yWWVBRUNRNkhubmJET2NjNGdqWU1JOFh6WE50OHdE?=
 =?utf-8?B?SGFVMGRHWGNXYjd3SzQzOGJZd3Y2cXpVeG1ITVV2WFErSGd4S3dIbnVOeHJx?=
 =?utf-8?B?Q2pOS2U5cXdNT2RXazlrTWJVc2hUai95eHArQ0UwVGo3MHcycE5YdVljNER3?=
 =?utf-8?B?WGg1VHNENGpKZUtTdmNTMm9RVm4rWkZTNXRXd0pLZE1GWUtORzJkZmpCanNi?=
 =?utf-8?B?ajdkOWNEdnVZRHR3cmJQVjNFOUZZbUJKM21KeDltRW13SDY2YTVxSFJPb2Mv?=
 =?utf-8?B?Q1ordnhYK3AzWHZTRUZYalozUmVVZmtwODFqaStTeFZydXJYb2dJK1VOODJJ?=
 =?utf-8?B?azZSRWZFQjJjeUV0TkVGQVp0aDZLeUVjYm9vS0krS0E5YlRxYWtjSmpRdG1Z?=
 =?utf-8?B?c2dqUk1ManNpSjV1bFFiVEViRXo4ejRpNUl3ZVpvMU9pVlliZ243NmVHQWl6?=
 =?utf-8?B?dmY3RURsVnBMbndGTis1bFl5NVE3UUFlQ1BCbE84NzZKRnZtZTZUYjBqa3ds?=
 =?utf-8?B?WGlIV2pERzJ1K2FBbUJEZjZCSzU4K0V2c3NWa1c0K215OE5VcFdGQk9PYzdO?=
 =?utf-8?B?eUFSdmFmdVVLT3NvYnc2SmxXUGUrK1ZOa0ZWOUlHRHRCQ3RaOGVOTEd3Rmtt?=
 =?utf-8?B?bDFLYnd5L3ZyRS84Q052OU1QSVNvMkE2VTQ2RHl4OXBHdGlJc3lCOGlJR2Zo?=
 =?utf-8?Q?Qiv4yzThe0CkjolSvHAL9I2tCJ3Y9T55M9nUT4SOOxvuV?=
X-MS-Exchange-AntiSpam-MessageData-1: zeLfgBkUZAn0aw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508939ce-f385-4fac-5bd6-08df22bed518
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 08:58:32.5445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9ubB5Z+F+eH+MrIuTctGCSZnCvRjCDdQcF6V0TRjgH450797R/0RHS66akVfR7lehiCRvuQFBnNKQw4xbRjKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR08MB556523
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

On 9/24/26 14:57, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> We lost several production VMs during an in-place QEMU update. Each had
> its guest memory bound to a host node with host-nodes. The new QEMU
> re-ran mbind() on the inherited RAM, got EINVAL and exited, taking the
> guest with it. The likely trigger is the host's memory manager moving
> the emulator cgroup's cpuset.mems to other nodes while the VMs ran;
> doing exactly that reproduces the failure.
>
> Patch 1 stops the new QEMU from rebinding and preallocating memory it
> inherited over CPR. Patch 2 adds a qtest that reproduces the failure
> without root: the exec'd QEMU asks for a host node mbind() rejects,
> which is what a narrowed cpuset looks like to it.
>
> Tested with migration-test on x86_64: mode/exec/numa fails without
> patch 1 and passes with it, the rest of the suite passes. A standalone
> reproducer that moves a real cgroup v2 cpuset.mems between nodes while
> the VM runs shows the same before and after on a four-node host.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Mark Kanda <mark.kanda@oracle.com>
> Cc: Ben Chaney <bchaney@akamai.com>
> Cc: Steve Sistare <steven.sistare@oracle.com>
> Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> Denis V. Lunev (2):
>   hostmem: fix cpr-exec of VMs with bound guest memory
>   tests/qtest/migration: add a cpr-exec test for bound guest memory
>
>  backends/hostmem.c                |  5 ++++
>  tests/qtest/migration/cpr-tests.c | 38 ++++++++++++++++++++++++++++---
>  2 files changed, 40 insertions(+), 3 deletions(-)
>
>
> base-commit: 942229961efea74b153c44c59188eb08375f10f1
ping

