Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75060C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 17:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEYHz-0006Fa-6Q; Tue, 04 Jun 2024 13:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sEYHw-0006FE-LQ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 13:49:36 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sEYHs-0000Rw-I1
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 13:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717523373; x=1749059373;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QcYdqY+AfjPtetaYfzbI1L8NTrsmU/1GzoTpfoFY8ag=;
 b=VGimkg7OQWz8tgORdOtcNEr9d+JNBscGhESED1ajcYyRZIz//kLk7tFc
 6sgocBm9axKDg3+1M4SqXCYLwN+bisLJLeW0u1r+bXWpkRvYBNGY4qDIl
 ugxe5mlGpFIPJgKlMyXfS22t2AbDA1E6QAo9OdgxYn+iDSlNcMB6ZqoJm
 1tZ0iGP9vHModAorK9pUhMlx+5WegxQB8kdTQKKi1KGz+mUc4KRpFXSzD
 GslIw7WsUfNJ8Gz6pwgvAbT4jVhRO2iEljAn57UlaGcZFjrOrRRy+L8TO
 SKt7MIxEkO4dl0gPQqNMDi2P5zjxuGbdKm/94FahS9u/gT4b/DDHCqg+s w==;
X-CSE-ConnectionGUID: IqdC978OQMykz39MNBMtTg==
X-CSE-MsgGUID: 65a5grCCRnewKfSt7pcX4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17875690"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="17875690"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 10:49:27 -0700
X-CSE-ConnectionGUID: rx83QBYETZ2LPpE79ii4aw==
X-CSE-MsgGUID: rL0nlcLVRg+VwoWycFhz7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="42262230"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jun 2024 10:49:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 10:49:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 10:49:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 10:49:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwpMgUcCCzmkzm46qTEPULbuBDekt5fRiSP+lp/ZcXRJPDfEXiY1bBcJvXc85dRvHrCegaKiuuwqvKgEj8iOFn9x8w1k5H4tsMiFv+6QR1frMMuHuueJ9KPtJtCE3bTaDnIjDR6EnMbby6SnxVOzUe78GGjLiBEG7RUopPXaD8S+ISvkAz2gHoCQBsK/tZ7CTdyMNKp5JPFpOLPUJtc8h38MKJ//MoUKC04ohdLzBQNS7Ff9+SFyratDgOFaBVuSvOsV+RBG/8iIVMj8LYoYeMML9B+nBtppJWhGo7EMVKxPsX0ysKdiz43Pcpjm/eIo56WDFqciNTYvyNHasBSVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNtvSb4ESb/8vBBRE4dRw9u3f+u7YzGlM8m8PR4Oc+o=;
 b=QuTzl7lwsWQsrAhs+T6v63vsVSu8NrYtlw71BMNlc94nV6KizVc/pNubcIPgbiw1zxZJ6aA46/sLZseVsE4nSLote+W0QaR1hWkGVp4XltFBvqCxxx1MbBxSBN0PjHqcJ+mZcBAgOfTcsMvMpUtb8RQwAKatvdACQpgtKEEijEDeXNYToPbEGGXF7YyjVpc9Wi55X33aDf/tjzMFNTg74e+eOTgI3NeIFJYsMWdMgf9Gk4PAERl4QniX4+L9CtXlZS7Wo59UkdZziz+LS03yf+5LOgHNQVKYy6qaMv28sJF4jfrJ6J/YgqoFlj8yKXoDmjtPZE8VMbOQQr1HcvCnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 17:49:23 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7611.016; Tue, 4 Jun 2024
 17:49:23 +0000
Message-ID: <ed6a1963-b079-4fdc-a6ca-6ba98b95c0de@intel.com>
Date: Tue, 4 Jun 2024 10:49:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is rendered
 before switching to RUN_STATE_SAVE_VM
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
References: <20240529224252.80395-1-dongwon.kim@intel.com>
 <CAJ+F1CJFWRtyXvpCJuSVPssJcBx8ecP1HCkWCJ=HBWxXovj+Dw@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1CJFWRtyXvpCJuSVPssJcBx8ecP1HCkWCJ=HBWxXovj+Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48)
 To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|IA0PR11MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: dd23e6a5-2849-4a53-6502-08dc84beab8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amh4eUp3Y0VFRDdlSWVnaGJRcHhja1ZMNGRDZ2xFM0tIYXV1dExoL0NXYUll?=
 =?utf-8?B?UXNuSE90R0J0dGsvY3R1UTN2ZnYzUXdNNHg1VjlLcjN2QjdzRzFDYzNhN0pJ?=
 =?utf-8?B?TVpUZXBTV2txS2huVmd1RU5OZGVTQm5WZy9wSmhTcDBEaVducXhJM1VsUlIw?=
 =?utf-8?B?RWoxRzNHRi82N04xV1ZKbGtkYnlpMTlZaVpFSkZuUFJTRDF5OTdlN1MyRXk1?=
 =?utf-8?B?eTU4ZGlZUENPOE1aRURmOTFLU2J3NkIzUjU5ejRUMEFlU1BqNkVydFk4cElu?=
 =?utf-8?B?YkprR1dmd0F5TXpncmxxMVE5UW9SMm5tS1puclAxZjVuMGVaT240bHc2aHZm?=
 =?utf-8?B?MHVhQU1ZeFVvT3ByK0J1VGEvd1laTGxvRjNVTlVDeWQxa3pObjRndEJURmg1?=
 =?utf-8?B?MkFwcmx1ZzVUSlM4QTNDai9TVGhpbWNTbENROHM5Q1ArQVhCNSt3ekdWLzR4?=
 =?utf-8?B?eEw4bDF2RGI3cmp0TFpNdUlBNTlwL1BPQnl5RUNQOHkycTRTTUJFZnZocnFr?=
 =?utf-8?B?TXZiaGhrK1QzaU9UdnB4TCtFQXN2eElyN1krNTJJKzI3YS83cEJwNWh3S20z?=
 =?utf-8?B?dU9BOXo3S3dHc2ZhVllla2FuUGdLU0dqNC95RmkxbGVsb2R6NzIzUXFhTU1i?=
 =?utf-8?B?VHpjaVJHVW9ldytuU05OVkhMcEpJcXppM1VMN1YweVdKNjJUUDJobVdXU2d5?=
 =?utf-8?B?TnVLQ0ZGNFJSeFdZeXgwc1BJUWtKeS9jUERORVpBV2FYbkVqRG1EOWlLYTVq?=
 =?utf-8?B?RklFNlRyT2tBRGpkUEhNVmgxS2wrcWNLMWI1NlFKbVJRQ0psR1VTcVo0ZGM1?=
 =?utf-8?B?a3ZMNi9aQklpUzU4K2RkbEtJRWlySDFXVlNiYVUrM1d3YU1hVVFzcjUzeXE5?=
 =?utf-8?B?UDhMeXlKZHRLdmdxeU9RZ2JJQ01FVWlDdGtPYXJGMUw0OEhxZElqRk9KRGZk?=
 =?utf-8?B?Ti9YZXdtMnR1L2dja3ArbGprQTlxNTVRMWFKaUhWMUlvams5SkdRRTZiTlZS?=
 =?utf-8?B?NUJCeVRHdTZPcTZKYjQxUkhTd2NtV29ReXlLMzBYUmZxdEpGa1EvRXBUdHBa?=
 =?utf-8?B?Nnloajl3QkJNQi8yMlRXNkZtS0tSOU1JTjhVWkZ1dDlqUWVwN2ViQzcvQ1d4?=
 =?utf-8?B?K1p0cWxjTjZoaFRFUlM0UWYwUDBXZ0hWV0g5MmUzSnhYN2FoTGx1TFBLUWpJ?=
 =?utf-8?B?YmxrNjhPSXROZzRBaW9od2I0WmNPTWphVDJqcmVIUk0xNjcrZndmYWpqUFFi?=
 =?utf-8?B?UlYwanlmdC9seTQyMWdsSXBUejJRelFzcHpIMGE2QmhWUnpXSGQzTk9yMDU0?=
 =?utf-8?B?Y21ha3FtcmVCeEJvbWM0YldCZVpFYTIyRDZzYVczejdpcGU2WW1BOGZrenBs?=
 =?utf-8?B?T01MZTlEK2pVYTZ5U2JjeGY2NURMRys1b2NOMWFndzNwcFpVTER2OTNNYVhP?=
 =?utf-8?B?WHlKMmlUbkZzRFRRUDRxTFJLeXhIbWdkS2Rnb1NEZmFoQW42SHFvdDZybVNG?=
 =?utf-8?B?M2NhQmpoUU5xdExDK1dHY2dOQnFUVU9yZXd1RWRKQVJvOVhRQXB5UXlScjJv?=
 =?utf-8?B?VnpyeFVVdy9DM1c2L1U3NUsyK1Y2NjllczRvbXJ0NEJQTi9hUy94aXBWMnBw?=
 =?utf-8?B?a3lhdDlIZ0duU0pnOEtqU3BDNzJ3RWZEZ0lpK2JXRWttL0hNTzV3c05PNUxC?=
 =?utf-8?B?aDRrKzduaEhvOFpTSzNtVmdEVHU5TzRRbDNTVGRzMGJCQ3VVak0vSkZybk92?=
 =?utf-8?Q?iqyxa66qAOTCc59gC+jMrsyZr5hPcNAuSxRx1mb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm90QWhtTWN0Yys1SGpwaUNvZStpRGdmMkNUOU13d0dpbk9tREZGZUp4U3lB?=
 =?utf-8?B?T2piTDQ3aFFxMEg3MzJpcVJaSEJBeCtEWGM3SGJXYVlkRVIrd3ZkTVkwdklV?=
 =?utf-8?B?eTJyYzVvZ0Z5M2tqM1o5UUJvQXB3cUVKa2NhQTNHVGdaRG10eG00SXNxdU1k?=
 =?utf-8?B?a0pFZ3NmdXVWNnpKUDh4dVZWcTIyVWZBbjB5RmpLdEdmSUVNQ1o4ZjA1RWYv?=
 =?utf-8?B?OGhBc1BubVQwM01QcExpSkNrRThGUXpwT2pNcVdoTE9RcUVpTldZTUI5KzM2?=
 =?utf-8?B?bmxsT2p2TDBma2NOM3lMUmwzM2tSZDdXWHNPWmpYZkp0Z1poOWpWTmY2djdT?=
 =?utf-8?B?OUZreVZwVjhOemZpcG9VYllhU0Yrb25RTUhqdXBreTd3UEJ0VnRXSkxFOThN?=
 =?utf-8?B?Yk1xY2VOL1czVXJiekIva2N1clRUczg1RDRObGEwTUN6bkNxRXl5T0RucGNH?=
 =?utf-8?B?M29WODZyU1ZnOHEwN1ZLanVzUjhHQW9nYk9HWlkzb0hOQnFPUGl6eTQ4T1hH?=
 =?utf-8?B?enkrVCtKTXVaUUtYU1FmVXZkZytYU2pxb0pyclpkUkFwbXZCeFFoU09QdG5q?=
 =?utf-8?B?ZFNHdG84WDZHbXhZMzkyZDcwM3lzTWpkZHByYmw2TEpUR29MaUl1WjdLNVNk?=
 =?utf-8?B?SWdlRmpSN3pPNFhqc1ZqcjBaOHlzeUl1ajVYSnN3YzdvQlZGaVRSQVJ1RjZI?=
 =?utf-8?B?U2F1em02c0NoMzRQWU1sTGdwTzZnRW8va3NaWSt3elRDbHRiZ2g5d2JwWkpZ?=
 =?utf-8?B?RW0zNERMeVNMT2lRSTNHWDkzSDJwUURpeTBhT0dVVllEK2hRdGxGY2t6Q0Ni?=
 =?utf-8?B?bmZkOW5yMDhkMUJabmtiSHhUQmZDZVBiVWtQbjI1RExYQWVlMjB2TUVrR1c4?=
 =?utf-8?B?aXJPMk1xQUdFTE1DQ2FPQVpkdlI3ZW9KV1B4WHRsSzJqb0JjZ1hBZmgwOTVQ?=
 =?utf-8?B?WlN2WVlRTHRjZVBrS0hacUdYZzR2aVhFM3NTWndycm12bklhVGtkWmdtbmlk?=
 =?utf-8?B?WmFRL01VSWpmM1MreWFhZnZ3TVFTNWFYOUcrMmlCWTBmaDJiNjJzN0lDMzFW?=
 =?utf-8?B?dkFERHBXOHdiZWFYTHR0NWFoaWRad1hSSE16d2FXS255Rzc2aDVKNlhwN2xz?=
 =?utf-8?B?bmFwdGpMUmFKdmJGR3ovb1NGUzB4TWNpQnh3aTA3SjB3TkhJL3R6RzJ2bGVl?=
 =?utf-8?B?Skw5eEhRMzl0VnJTVTdJT1lKVHZoUzlRUlJIUU56STkxMEs5cDlSeEhNWXVp?=
 =?utf-8?B?c21CN095OGIvUlM0RmFDUGZmTVdwQnN6WmsyZkhvQnNIczBoczlWdjFrRXdV?=
 =?utf-8?B?b29STmlMa1dWWkwrZ0pxQU1kSEZERjcxK3RJaXpuZyt2eG5TVyszbkNKay9H?=
 =?utf-8?B?SXFCcy8yOEFhbFVOM0ZjL29oVnVWZlRpaGJjazJhdngvK0J6WnFYRUtrODg2?=
 =?utf-8?B?ODdodys3SVExaFpLV0w2SG9LOGRtMlhVVG4yVFpxSWxJeE1VUGFKVVNWZk9E?=
 =?utf-8?B?VzF6L05VVzVkUXdndDBRc2toSlFYcnVJdXp1a3BpMzZXZ2FjOW5oUTJJdmVZ?=
 =?utf-8?B?TTJWcGNuTmhxbE9FeXBEdlp1cnhwNlpvNnVyaGU2M1VUYTFiZzJaQUxHU3lX?=
 =?utf-8?B?SklOT3FQVS8yZGlRbE5YbnhtaHpaaFhsbkdFd0d2R2tkaHI0ZXZqK1E3T2RM?=
 =?utf-8?B?eEVrUnQveU1DQjdzVGdpRE5MOEJHZ3l4ODFKdjFaMEd5Z2p4VWRZbE9oM2tu?=
 =?utf-8?B?ck9nM2dTVk8vczcwUmhrVmFyVkc5U1FnZUh3dlBnd3cvT0xySkZhWGhPZXBL?=
 =?utf-8?B?bmxvcGxsMXFsNXpjRXY5VFJpSmpmUFg4aW9Hb3RRWWdEWHVGV0Q0VEl1Qi9B?=
 =?utf-8?B?dXoxQjNXQks4aFY5bFkrZGZzaVBuUllFd3RvRGxuYkpKVnlvQW9xRmlBcjhi?=
 =?utf-8?B?L0k3MTdpN2xPWnFwWEtBM1kwd2RGSEYrS0E5dmIvWVZxVmU2SkwrbjdhOGV1?=
 =?utf-8?B?bWJwako3UFBiR2E1Nmp0WWY2NnV0VmZRUHd4U3JlZHBCSDQyMjhQZU1xU2N5?=
 =?utf-8?B?QWZkZ2lJd05IbFE2Zm9lZTZIZUdweTU2aEdPTW51WDZ0TWJLbVpSRlI4Qmhs?=
 =?utf-8?Q?dMlus3GgnR8Lrlf+ZgMw2Umg6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd23e6a5-2849-4a53-6502-08dc84beab8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:49:23.8344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvSwoCy/5GvIQVk2iABYDnee4LR0XpHI87J+ttOxDwdRGeUrTcwDHSLkxhd0m7Bi3g1Z4MhaAiW4Ijl8mvlZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/4/2024 4:12 AM, Marc-André Lureau wrote:
> Hi
> 
> On Thu, May 30, 2024 at 2:44 AM <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     From: Dongwon <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>
> 
>     Make sure rendering of the current frame is finished before switching
>     the run state to RUN_STATE_SAVE_VM by waiting for egl-sync object to be
>     signaled.
> 
> 
> Can you expand on what this solves?

In current scheme, guest waits for the fence to be signaled for each 
frame it submits before moving to the next frame. If the guest’s state 
is saved while it is still waiting for the fence, The guest will 
continue to  wait for the fence that was signaled while ago when it is 
restored to the point. One way to prevent it is to get it finish the 
current frame before changing the state.

> 
> 
>     Cc: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>     Cc: Vivek Kasireddy <vivek.kasireddy@intel.com
>     <mailto:vivek.kasireddy@intel.com>>
>     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>
>     ---
>       ui/egl-helpers.c |  2 --
>       ui/gtk.c         | 19 +++++++++++++++++++
>       2 files changed, 19 insertions(+), 2 deletions(-)
> 
>     diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
>     index 99b2ebbe23..dafeb36074 100644
>     --- a/ui/egl-helpers.c
>     +++ b/ui/egl-helpers.c
>     @@ -396,8 +396,6 @@ void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
>               fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
>                                                     sync);
>               qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
>     -        eglDestroySyncKHR(qemu_egl_display, sync);
>     -        qemu_dmabuf_set_sync(dmabuf, NULL);
> 
> 
> If this function is called multiple times, it will now set a new 
> fence_fd each time, and potentially leak older fd. Maybe it could first 
> check if a fence_fd exists instead.

We can make that change.

> 
>           }
>       }
> 
>     diff --git a/ui/gtk.c b/ui/gtk.c
>     index 93b13b7a30..cf0dd6abed 100644
>     --- a/ui/gtk.c
>     +++ b/ui/gtk.c
>     @@ -600,9 +600,12 @@ void gd_hw_gl_flushed(void *vcon)
> 
>           fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
>           if (fence_fd >= 0) {
>     +        void *sync = qemu_dmabuf_get_sync(dmabuf);
>               qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
>               close(fence_fd);
>               qemu_dmabuf_set_fence_fd(dmabuf, -1);
>     +        eglDestroySyncKHR(qemu_egl_display, sync);
>     +        qemu_dmabuf_set_sync(dmabuf, NULL);
>               graphic_hw_gl_block(vc->gfx.dcl.con, false);
>           }
>       }
>     @@ -682,6 +685,22 @@ static const DisplayGLCtxOps egl_ctx_ops = {
>       static void gd_change_runstate(void *opaque, bool running,
>     RunState state)
>       {
>           GtkDisplayState *s = opaque;
>     +    QemuDmaBuf *dmabuf;
>     +    int i;
>     +
>     +    if (state == RUN_STATE_SAVE_VM) {
>     +        for (i = 0; i < s->nb_vcs; i++) {
>     +            VirtualConsole *vc = &s->vc[i];
>     +            dmabuf = vc->gfx.guest_fb.dmabuf;
>     +            if (dmabuf && qemu_dmabuf_get_fence_fd(dmabuf) >= 0) {
>     +                /* wait for the rendering to be completed */
>     +                eglClientWaitSync(qemu_egl_display,
>     +                                  qemu_dmabuf_get_sync(dmabuf),
>     +                                  EGL_SYNC_FLUSH_COMMANDS_BIT_KHR,
>     +                                  1000000000);
> 
> 
>   I don't think adding waiting points in the migration path is 
> appropriate. Perhaps once you explain the actual issue, it will be 
> easier to help.
> 
>     +            }
>     +        }
>     +    }
> 
>           gd_update_caption(s);
>       }
>     -- 
>     2.34.1
> 
> 
> 
> 
> -- 
> Marc-André Lureau


