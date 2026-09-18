Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C86C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YVC-0004C0-0d; Fri, 18 Sep 2026 09:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1x7YV9-00047e-UT
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:19:39 -0400
Received: from mail-southcentralusazon11012040.outbound.protection.outlook.com
 ([40.93.195.40] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1x7YV7-0008Lw-Sr
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:19:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d849NjUXKlFA1XwqhQJo0e4lgI1pF4j7iUBSVjIMiOSFwCa6+yAlpizJoDVs3jfaJ1f3X1pVNDi5Gy4WWaajVLjVv4EGcpm3CTTY3jK7Y/J84hV4/eErIpy49OE7xeTKwVWOA/Xspq/lTFo06uxDAd0V6HIzpM1SHGC+tE9FX6EMlBtxMDLBpYsVpdLHfl3F8Lk7vqaNnbSvHtvrTPPyM7G2KTOPWSQh25BvPbwQHcYiDO8o3tnVTELKQd2MibIwL8RcnHV7CY2ky23EV9hnZSb93FZtcXfqJJPvEyTC1zp3lJRCY+KuXpadJ9mD2/TI/nUUGARyX/sCiNTQ5h++Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4ifpLomry5gMeyeT/ahOwYrLfz80Zmfr7qTuPsi0dw=;
 b=ELBlQOlb4nn3Z4YoS9jpHVgceKSD99SIwEBZ4sxIOxVhYPQcZLWtPtzVM+aZoubxcyUkToLMtZabuAgkxbtmN81VZ+gbPvw3uybf5TcmfsR6+kt4U0MyZaCnAmSxzuOWfUpR6KZpl5R6eV0NMtY6JgqVLnHMcaADjXgrdlH8RZCuuGBho1aDyoXF37hdJW4mws9EK4Xe8tf7Frm/uGtWb5abWw25wvn/uiPPKIJLH3RO+cHqGTolm6ws2zmijc5Ipq/8U055ZJ+ZTgWvLsn1+A5dmRTcmdseCFR2veIwHoG99xotsD6TQo3cmRmTBs3kNmy/uz+GWqq5lfkuPEoDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4ifpLomry5gMeyeT/ahOwYrLfz80Zmfr7qTuPsi0dw=;
 b=RQOdB5t0X0BUU1BqQKEpybuu2zilzFIrFW7Qen5u0/ZqbKmjgFrbLsb6ejI9+5COzQao9/A37S45ZsRf/sYtXUDARkIlFbrlNIeW7IJFJVSuRcXgHpC4AUwy4+Fc93p0K+FfwelRjd7zhIgwfrWSd1knR7/oaLFg/SOatV7nNYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8274.namprd03.prod.outlook.com (2603:10b6:610:2ba::5)
 by CH4PR03MB7724.namprd03.prod.outlook.com (2603:10b6:610:244::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 13:14:31 +0000
Received: from CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096]) by CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:14:31 +0000
Message-ID: <0bf76f4f-8762-4e28-9964-479400e8ec76@citrix.com>
Date: Fri, 18 Sep 2026 14:14:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/11] xen-mapcache: Remove 32bit support
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
References: <20260918113926.831204-1-peterx@redhat.com>
 <20260918113926.831204-5-peterx@redhat.com>
Content-Language: en-US
From: Ross Lagerwall <ross.lagerwall@citrix.com>
In-Reply-To: <20260918113926.831204-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0511.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::18) To CH8PR03MB8274.namprd03.prod.outlook.com
 (2603:10b6:610:2ba::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8274:EE_|CH4PR03MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 29166d1c-218f-433b-2fb5-08df1586c673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: bd16kEWStNhP7tjXnPvxBAexvu4kTw/qVsLqc+7gGEcwn0511TC9YmclncCouC8boYJe946eRIU/vjGcMxA2bXtf1vJQrZnsxMkg4oQb2zOorpjnTvh58idT7zHVt4fTYt6biDtf65JBZiZI24ULcgRJnhOYn6l1yC3qFbfpwm3jjTaDMElZPCwqcbNHf8+MjPGw+C+4QNbnTp3z2q3hTWTkANHKADIzHOAuf+ajY3HS7rz4QbwjpfJzSFz7WiJ/mkeexICwYkSg/XNu9eHvjRnFlCTjv8WCZWh9iavB4QSLM2p18jcvZxx05VlTYZ79Oj61MMSjyVz2bBp+jtypVJT4c7VaCjKxvx/buUqajp82ZcZdwdCTfqMAVVu+nilutVBMV1vKDtjPSX6R6GRJQuxlfiz1Dg70sY3MV+DViSbeRIHshFTgBjaFYuiJrjS6ixNNQG+CpymgsYZzfqvbZT1BY6zZGhponuS+kTKy8CqxRIwFOwT9qo7poLp5I7HnQM4LjBVpL8n70sDzOzT6Y9YuTL1JDzCNKGh4YRUqYCsGOeQvZyxO9ULYHIyxXf8JP0MJ4n6KrBk0KZ+w9alh4ZvJ8ayoo4izCyC+UFDkZtWWPDiL2Sl1thIaXJe5euqFvHbsHmsmtUljBOuxvuFlrd9nUyOqZ6kA9Sn2zZqgQIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH8PR03MB8274.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVibkhpQ2grTjV0akhRZWhrRnBoSnh1SHplSVhZS0FrNWU5NVgrWG14UW9T?=
 =?utf-8?B?RUt5MERDOCthZENsai94Z0pvVnM3UU1la0UxMUhxeVloWmdVOFRvUzlKS0JJ?=
 =?utf-8?B?S1BCQ0JZejB0dHVGcXZacTZ3azZqZDZ6MkdpOEtpdGJMWGlGZ0d4MWJkbjhX?=
 =?utf-8?B?N3RMRWpUVGxaNjRUVWppZ1l5eVkzUUxtRGJHa0llVkhoUDBTdG81T29SN3N2?=
 =?utf-8?B?eHovYjBYQmJrcEw2bFRzbHRMeWJQeHFFWitBOE9NeTZUakprK1k1MzhTS0VQ?=
 =?utf-8?B?aStJOUo0cVhhNEtTenBiZXlka09yWStiTUV5OHVrN0piV0tHL2JYUHl0Y3dm?=
 =?utf-8?B?dDNuZEpPR1dMTk5tZGpNYTQrWGdBMFlCbnVWblVMTzRwQ2tGVmcyV2loT1lp?=
 =?utf-8?B?QmdSa0FTaGZTTmQ3ciswdHZqc2NVeVVxYXR0VU1DZndSajg1WXNWTlFmNHBE?=
 =?utf-8?B?dk05VEp1eWVEeFNJbVBQQ0taU2hnUk5temQ3dDh1VGhvSEF5RjJQYTk5dDFy?=
 =?utf-8?B?NmZkRlRFUVI1K0IzM1ozbzNsZmtHajZDQUszS2I1a01MRE9sZDVIQzZudVho?=
 =?utf-8?B?cUxXZ1NxMFVmb29lMVp3ZUcwSUZncS9OUnZ4VStyZEpqMTBnK2l3cjd5TVY0?=
 =?utf-8?B?SE1jZUtJSENPM3ZWSTRuVytMbUZRNzE1bWJoeE42azhtcGkwNXQ1Z3FwdGZk?=
 =?utf-8?B?Zm9ZUDdrRDRrd3V1N1RuUkhJdDQ1ZTlzSkhTWlRVN3o2c3g0S2xLZnhmVHdq?=
 =?utf-8?B?RjMySWo0bTUvTXZRY1dra2pvMEhHOExMMG9HaUd4ZWlnd3VVWkxhRmlrQmpu?=
 =?utf-8?B?cWNQaTd1U2tWUld3NDliZGVuR1A5cWFXVGd6bjRYTjFMTFYzV1ZReVp3Y2o4?=
 =?utf-8?B?bXFtaEx0OUdNS3A4UlFsS0ZFL2lTemplRVIybkUvd1ZCSVhXNWIwMG4zRWFI?=
 =?utf-8?B?SW8wMTZvYk5BemhtQ0txRUNuQjlmS2R2ZUJDNDBDQ2VOMVQrcDZSRC9mcGhU?=
 =?utf-8?B?aDZiVU8yVTJsaE9Fb3ZKckhwQkRzM0xxVER1Rm5TeHVhdTNVWFErWmp3bFBx?=
 =?utf-8?B?cGp1elluZjlQRXlRZmJSWHMvT3N5ZTZuQlZ4ZmNvMkZ6VVFraGtRYUgraFVH?=
 =?utf-8?B?ZkFFQ3FDRE41dnJvUXJ0Y21JWWhPeXdjRTZmRGtEenhJT28ya0NHL2JGMHM2?=
 =?utf-8?B?NHdqQnRGSjNWbGg2MGx1M0sxSEJ2aEh4dXMxWjllVktneFN6UHdva2F5Vk9a?=
 =?utf-8?B?ZmdGSFVRZUJPTVlOQ1R4SmltTzRuNms5M09DVitTZ2tDdGZETWJ2akRYNXRV?=
 =?utf-8?B?UTZBdjUydVJFK2NMRmlLTllvUFUzcUp2aGNScEUwUVh4SU1Na28xdWVIY01v?=
 =?utf-8?B?Tk5HYk4zU2hrQWRBSTBQN21kWVpRSTRnYUZKNEZ0MndhbFBZdjA0KzVWK2Qv?=
 =?utf-8?B?eDZmRk8xYUExUVNzeFhmdStQRzFBa2VucGU5SzIwRGtOSDFQaFhhUnA3eFJY?=
 =?utf-8?B?dHpQY3krd3M4ZDdEMEFrS0xnanY3WHhTUkkxRWg4UGswOTNINVZVTFlVeGRC?=
 =?utf-8?B?L20rNE9vcVhFckVlQ25UU3N1SGhBQlU4MFNUZE41dXNtSm1nR2lORXp0ZDIz?=
 =?utf-8?B?VjRQdWpTdHZ5cWNJYVFoNEVkTVpPLzBiWkxuSHRvcnR4WWJBSzJQcGlLano0?=
 =?utf-8?B?bHY0eGxWb0tmZERvOHhueU02Vkg3UW9uOU5Od0s1d242eUFIcmdCTmhBUWkw?=
 =?utf-8?B?bjF4TE5zOG9GbWdDaFRwRWdiZTNXTHhqU25mc0IwYVc5dWQ0Vyt3RERvRWdI?=
 =?utf-8?B?c1RiS0llYVc4dzBoOXZGT2xRbnVZNFhmWkkzMkU4OStBTmNjak1qNWE4aHMy?=
 =?utf-8?B?d3Y4UTY4c0xhNVFnSVFIUnhGRWJLdzJSRUFTcFY3MVlmYUtiV3d2QUdZVHBO?=
 =?utf-8?B?Mzd6ZXRlS1M3NVR6Y3pVSCt3YldMN3hRNDlnMnp3STFWOTI5bUxweEkyUTVE?=
 =?utf-8?B?NHViN1c2Qm83QmR0b0dQTUZqS0NFSDYxMS8xUUtWa29MSE8xckNrWFFBaVRq?=
 =?utf-8?B?RUlXUGNscTIrV1I3ODNydENldzhLRXdKZkJmcStrL1lUMm5pcWRkbzBoZDNs?=
 =?utf-8?B?UlpWdUxpYkpxV1dJVHlaUnczeGF2LzZmN2lraE5SWThLSWxkdStjWGlFS3hQ?=
 =?utf-8?B?ckEvWVRoUzUwRVFhMGhmU1FyZVpsK3hwbk1mTTc4enZreVJudXROTzU0eE5x?=
 =?utf-8?B?L1hVTVMxYjZxc1lGNElPVGZqZVdzUWIrakRvNFc3RllPajg3TW1yQkRGdklz?=
 =?utf-8?B?R21ML0plN1gySHB4TUtucjRWMG5uRU51OGYyUjhwdHBvVEtjazlWMk9UblpH?=
 =?utf-8?Q?VX1JCpNY0eO3A+ks=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29166d1c-218f-433b-2fb5-08df1586c673
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8274.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:14:31.0591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tW6vK0g1vQsAcvSTVZpPioCjRl/taSdWqB57snQdVUJJVQzuBJWd2QRIgKvCy750KVjU6Tm4cpbJnB38KQQTND1yG9l2862clC2BqW/qEy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7724
Received-SPF: pass client-ip=40.93.195.40;
 envelope-from=ross.lagerwall@citrix.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 9/18/26 12:39 PM, Peter Xu wrote:
> QEMU has switched to 64bit-only hosts for all system emulations.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Link: https://lore.kernel.org/r/20260818172012.3052821-5-peterx@redhat.com
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony PERARD <anthony@xenproject.org>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/xen/xen-mapcache.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 85cf0cf359..e30c07c2ee 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -26,11 +26,7 @@
>   #include <xenevtchn.h>
>   #include <xengnttab.h>
>   
> -#if HOST_LONG_BITS == 32
> -#  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
> -#else
> -#  define MCACHE_MAX_SIZE     (1UL<<35) /* 32GB Cap */
> -#endif
> +#define MCACHE_MAX_SIZE     (1UL << 35) /* 32GB Cap */
>   
>   /* This is the size of the virtual address space reserve to QEMU that will not
>    * be use by MapCache.
> @@ -151,11 +147,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>           exit(EXIT_FAILURE);
>       }
>   
> -    if (HOST_LONG_BITS == 32) {
> -        bucket_shift = 16;
> -    } else {
> -        bucket_shift = 20;
> -    }
> +    bucket_shift = 20;
>   
>       if (geteuid() == 0) {
>           rlimit_as.rlim_cur = RLIM_INFINITY;

Using a local variable here to store a constant is a bit weird and its only use
is to be stored as MapCache.bucket_shift and MapCache.bucket_size which are
effectively constant. Not sure why this isn't just a couple of #defines at the
top and used everywhere bucket_shift and bucket_size is needed. Perhaps that is
further cleanup to be done separately...

Ross

