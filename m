Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365F7C27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 18:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHT3I-0006FB-Vq; Wed, 12 Jun 2024 14:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sHT3H-0006DW-0S
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:50:31 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sHT3D-0007YQ-Rs
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718218228; x=1749754228;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Db366+XFJJjvwK4ye0NPt855BxI5rlEzASHzTSK5OMg=;
 b=ciuTTVlvUWUmYfP18EUhKIY3Gi711Yac81sDorRhnkRMWYDW9Dm6o9c7
 9WsQuD4gkHIJr8H7rgH1rLw6x9c6ukjsKrYUB0c02KlCjaBQKo0s30U5+
 dYy5ULj6OA0WKip8TI1paVCW9n48TJWfiN3bdFW9qkdq1t0yX+eUoj0SZ
 iWkgLEF/T+elcyIuGE5h5Vk5IZ3SMWOXK9BMA07uq2hjnnQFutNqfWlT4
 XvvyCsA3MhzoM7192IcZX9v4VvR8RV7SwUXratKtpNJH2J5TEfez7p/a6
 ViV1lfbxFVeKIOaBc0xbtz/n1lBSDtDp5W4ff3yTySK2r2SKxKprYR3eO Q==;
X-CSE-ConnectionGUID: wjh9yzNPQ0GjGyTEw/TJMw==
X-CSE-MsgGUID: 0lqobEadTJm4DSIFsYjPiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15171397"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="15171397"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 11:50:24 -0700
X-CSE-ConnectionGUID: spti58xNSHK0JoM4GEtLdg==
X-CSE-MsgGUID: 4u6jSOUTQaWChjaqIoCt3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="39806931"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Jun 2024 11:50:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 11:50:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 11:50:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 11:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/YFKJjXvjp1Ds3IoZSnozE50/3HlptNGyIbasL4jBd+fA1TQmkyxHzjMcfxTU3XsF1GxU3ctWvDH7EkUQgjsalSEpO1n9vpzXCYTLba10NwXdpG84v1WEcb7zoUMolGIAb/lh/cFWnaV+sH3tV7IOIEdFcoUonrCW181KseuW44r+844QiCHPLZGFXuQQKOImA4ieDHkwVDAEDyGKC36zh3/fw1nU8wA3+MqT0H/zxrRm3rq4wWOz3k6E9ztlP7+HLWSbz9p4sX7ivQ+dyVEL/dR6BlYprVFXcA4MFm3aVvbVXAauOY9vmnjK0nwl9rT8oWvpvf2N/wnGjFMiUPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9MTH0wBtUUf0LfYKG+yF39QxmdLXDsza/OzaUMp3Mw=;
 b=XkgmGAeGoufDwiNfxr/xLSI2itfXCdgmFFIbY7WYVBle2ILR3UrDPBLtHxw8EgfB/LKQWw9K/tMgx0t79rqwlhmsKSWe2NRMdv5eUFz6vp0NsoJdIPNGyfsvZIYCroldc53aENqIgGriX0SUGzWg/IAl5r438NZmIE7pC8zZHpo/Y+czzJy6Ck62weBFliQa/nksWUdAT6ryUtdIiIIEMUWD7thPNM/6zg1BTrxOcOD+1R+xq9Khlis5VlnbW3ZOAUEVpugd7YWxcEWNLLFfb22HvunAtteXgONjpBioO0MEyVvg40jIDXl+RSHIOlnjRhdbxQdWQP1DDQ8Xb4ycdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 18:50:19 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 18:50:19 +0000
Message-ID: <d1534c51-bb11-4439-afc9-0a95f2dc4cf5@intel.com>
Date: Wed, 12 Jun 2024 11:50:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is rendered
 before switching to RUN_STATE_SAVE_VM
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu
 <peterx@redhat.com>
References: <20240529224252.80395-1-dongwon.kim@intel.com>
 <CAJ+F1CJFWRtyXvpCJuSVPssJcBx8ecP1HCkWCJ=HBWxXovj+Dw@mail.gmail.com>
 <ed6a1963-b079-4fdc-a6ca-6ba98b95c0de@intel.com>
 <CAJ+F1CJW3b9D4nU3x4XSjpG=KrBpJMLWqdR3tpdipObODZRvgQ@mail.gmail.com>
 <PH8PR11MB68796CDE59AA75FD1D6089A1FAC02@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAJ+F1C+L=5cSPhEXrAczfN27sXEH_2Xwohk7Bt2r4KmhteDguQ@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1C+L=5cSPhEXrAczfN27sXEH_2Xwohk7Bt2r4KmhteDguQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:a03:255::12) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|SA2PR11MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 42654aa5-fb93-46fe-1e78-08dc8b1081ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|366010|376008|1800799018;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1BqSFpGUWltTHpYTnBDVUV0Mmp5Z2JBQkUyMnRaeXJJTVVrdmtML2twMFJ4?=
 =?utf-8?B?bXhRd1hDWWJld3lHNkI3b0FYME1zQ05JNXdjMEc5cDY2ZjVyRlRBRWtkdDY2?=
 =?utf-8?B?eTB2WEVRNWE2UGtDTks1Q1d3cEU5djBHM1VEMmFFblBjZlhVa2gvQlcyZGUw?=
 =?utf-8?B?NWZaalVoSGlWb3NOdUFKL2Y3RkI0emxNVUMzRHI3VVRneFFWb1hWM0JOT01W?=
 =?utf-8?B?akVTRzhmeldFZ2FkdlZXM21DRkVJdzR0Yi9EUWk2ZzhKbnpYYUg0WU9QbE13?=
 =?utf-8?B?YUVJdjhnYmlCUitGKy9iYTd1RGVteFJhYU1iLzRyVXluVEZZTjRXU3o0WW1x?=
 =?utf-8?B?T1N6OWJ5RmpTcGFoMUFmbWk2cTNhdHNraVRURU5LcWdQN2RqRUdmbFkxaU1D?=
 =?utf-8?B?QjNSU0RKdkt2cGhJQnA2bC8wZ1BIdVFZWUtTd0Zoa01IbnVnQkFlYWxCWFRa?=
 =?utf-8?B?aEF4UGlvdnQxMjhWRkNnWjljVi8xUXdSb2JocDVuWDNFKzUrWUdpWC9kdTc4?=
 =?utf-8?B?WTQxaEJ5ZW1XcGs4dUxIZEVsTmVZcmpka2xXYmxnOGtoeU9lSTlJVXZlbzBl?=
 =?utf-8?B?NTJMOGRobk5qcnlKMnZnTDNySlRiUkQ0bjVsY2dpdE9NcHA5WDZidGZ0M2VY?=
 =?utf-8?B?MEZtU1dwQnVMbi9UQUk4UjV1VUtHVkdXbC9qWHlYVFVjOVVHVndlVHN3WW1j?=
 =?utf-8?B?bHZWUGorSVFkZU5wRzA1SCt4dFRpWC8rQjR1QXYrZmRTVEV1Q3p0Mmw0SGFa?=
 =?utf-8?B?bm5BV2NIMlZYKzE3RW4rcitLand6dW1wQlVDNDJSOTNnNlJ1ZmJqczQwUWE2?=
 =?utf-8?B?ZVgrTWFmWmRDekFDa1FEVWJoZnJDQTh4bytQRWNJSGx4TzcvUXBRQ09TVTQv?=
 =?utf-8?B?SVV2ZmNmNWZpRTdaQTUyaTkwcVgrVnhxTXdaUk1aK3UxdSs2N21LTUk1TnlQ?=
 =?utf-8?B?TVpWNGtRQ0ZLYUZBU1prQ3VnNTd4SWlaZXhEL1hXeHdMbCtPRmNHaVVoeUhT?=
 =?utf-8?B?U2NzRW54SU0xdkdxTCs5ZWJVcCs0UGtTeU1xZ1FLcnZYUi8xMXlXdVNOQ0xT?=
 =?utf-8?B?ZklsV21zYTRKVmFZZ3dXNVZSdTU1SmF3eEFUZzVMRm9hZ2liR2E1ZmdEaDFl?=
 =?utf-8?B?cHc0OEFLd2tTaFZMSStCcSt6bWV0aGN5UFRlZFZjTzgrSEhPSmpXc3Y4WXdX?=
 =?utf-8?B?eE1XK2RjR1hsRGJ3QlFPOGF5Qk9IeHRWUHdPYzNGZGI5QzZzTSt3V0xXeVBJ?=
 =?utf-8?B?aU94a2E2UnFOc2x5VmhyeUd0b0k5aUlRUmdjcFd3TDk1cjZjaHRXeW92cWNG?=
 =?utf-8?B?ZlJ1UnZ4SUZqYUxxZTZrZFdkeGF6eFNIckVxYzZkZzRGa1c2U1pPK2kwR0xk?=
 =?utf-8?B?cGYxWDh2WWtrWUFDVnE2MzZHekIxR0I1QkFPYkY5QUFuUkw0bWZmK1lNMEx0?=
 =?utf-8?B?NUY5aEZ6Tk8xS3QwRXBaTGh0SE4rTndJaE43b2JjZ1FnSzBNazRqdFZxYThP?=
 =?utf-8?B?UGJLWG84SVkvS21zTEN1Y1JsOUhRWmNmVWl6dEI1bll6cm9SMzRvWWV2aTJh?=
 =?utf-8?B?M0ZGQ0lwdVFVcSt6cjVML2lnMUkvU05OOHpzaEFOMHU4YlpyMzdRSHBWWVAy?=
 =?utf-8?B?dHdZUUlGc0pGTUV2OTRyZEQ4bjl2WC9QMFZNa21sREpZMVdlTjRweFFnOVFp?=
 =?utf-8?B?WGhFSXN3VTdEY1gyN3lSSE43bmdyZmpDVjVqcWtCbk5pWm50VVBKanpHTGFE?=
 =?utf-8?Q?mMEg7PixGjH4l5Qp6skYedk4w2yzZanLnDoW3zA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(366010)(376008)(1800799018); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZyVjNuMnZMZThtTDJabi9jNVgxWnFiM0Fkay96RXcvaGdpQlRsejd2WERM?=
 =?utf-8?B?alFQN2N1MTBhRjJLRVZSMzZlNk1YTHUvZG4wenhKQW1lRGMxNi9YUHVZOTkr?=
 =?utf-8?B?VzJ0alptYWJiQW9vcExHZllvVHR2OHJxSWdNYlA1djVXeWhZaDJSUjhPYnZR?=
 =?utf-8?B?bnN5N3F4YjFua1RsUi9XWm9YRXBRUnFQQ0tMdE1YRW9DZmxEU2lkVXRuME9U?=
 =?utf-8?B?UWh1RHNjbmF1bkpsNFpDQlIvbUZhQjQvQlduVUcyajNYOExyREx0Ukd4NGxu?=
 =?utf-8?B?REpxdXpkVzhlbzg2VEpmNjYwc2pBNW1ZYW5oOGd0OWtnSUFlOWpETVhaNHBw?=
 =?utf-8?B?WnZFQjQwZHhVckc5MnlHaW9TaHlzYlFjK0J2SnlaZ3ZlQmhCMmYrU0thRktM?=
 =?utf-8?B?eE1ZK3lhZ1VLQ3VIVnV2MVJQM1lqenE3OEJRTkNONFpCa3pSbTYrRTBpcmo3?=
 =?utf-8?B?QjJZMW9KMGJRYmVuQk5EVk03dnFLWHk4dndJUXBYUzhFMWp4VjNxUEtxcFdK?=
 =?utf-8?B?VmZZWjdzS25DdndLb3hHK0V3QTR0YURvZHpENTJmRXNxbWhpcXpLZFQvMkY4?=
 =?utf-8?B?eGR1OTFYbXU2emlvSFQ1bHlCZGJEWC9zcW5rQ0hkNWJQcG9ob1lBdTRGbHlU?=
 =?utf-8?B?MFVTemZIeklZazExOXRZb1BFRC9nZlRPM2ErVGhOVkNUcmpEQS9HbDlvTmhT?=
 =?utf-8?B?MjlBV3BNWDJZSXAxem13czdDTlErczFTUVlaYjJjZ1NXUDVvSE9ac3NobWR5?=
 =?utf-8?B?cjlmVU4vM3F3ZnBFZVFWTXdzSUFIY0hjTFVGa3Z2RzBFUS9RSFZmMmw0MWkr?=
 =?utf-8?B?cXJZOVllMm9uQzVxSU96Rm5XZmJMK0libmVMcTN1RjZtam9jUEpoMndhSzZF?=
 =?utf-8?B?aXc5WVhxMFZxSVFrR1ZJeS9tZkcxL1E1Y0NCbVpCeXNJdDBxbWR4eTRqN3NM?=
 =?utf-8?B?OWNHYWY3Q2UxZ3g3c3dMalpUM1JBUHhNWkQxQUl5Y0ViSFpGYVc5THovV2Z2?=
 =?utf-8?B?SHJMU0ZhS0FJU2lZQzR3U0kxMWpGRHBONk1xWEZUbHU1d21XbnlWTHk0SjhR?=
 =?utf-8?B?ZUpyQ2NpOU93ZWNNc0ovK3h5T0RaMUdzTDJhdFgwdmxTeUtITnFZSkl1TmhF?=
 =?utf-8?B?QUQwRXQzK1lRaTk2Q25MeFZEVkpCQWlWVklGT3c2N0tEK0s2VGNlbGcybkY0?=
 =?utf-8?B?MEw0SGxrTWhiYlA0cUt2eXZrUExpcDRwMGMzaTVUYWtBdWJpMU9RUFFKUU5W?=
 =?utf-8?B?NmN0YW04b04ydXhNd3pQQ00ySXo4TVRVQTlkZ0ZiamFJQ0Iyb3Rrb3JRalYv?=
 =?utf-8?B?V3IwbVRHSllkcmd6djJBMHpNZlBOdGVtQ2NRWksrVnNEc0E2TXR1Z3RaRFNp?=
 =?utf-8?B?SUFGa0J3UlFiaFA5T2hrZTNOMmx6TGROZEFqZ21xZmpBT2cvTVkxdVlqbWVj?=
 =?utf-8?B?VE9aQlRkcHNqSEtxVVQ1UWpWYUxhR25TOURnSkp2VGRVdzN6VzUybEU3Zmtn?=
 =?utf-8?B?WGJtQ2RrUmhZazc2VnV3TURIdTk1eHhsZ3BuUThkL21kOXJlbFdndEx4WjBr?=
 =?utf-8?B?bmJLUzdUbEw5bUdnSGNyU0Z2cjFDVGkrWStrM3VOcjhCNjVzQnhxWldzY0Vl?=
 =?utf-8?B?RnBPZ1ArWldjdzdZK3dpZUd6QzZscFF3Z1dTQWlRY2YrY0ZkQmNhWVBiTDhE?=
 =?utf-8?B?czAwRG5zd1ZpU0dQUHBmYWE2QTNIcnVTdUxJcTV2TFIxd0UxSUZ5bkFDUldw?=
 =?utf-8?B?UFNxVXhxTGVTRi9XZnM3ZXBHQlVWbXFlUTdvdFl3d1VZQnZzRXZlaVhKMlJJ?=
 =?utf-8?B?eUk0VFJxd2N0YTNIVUJva2ZaWS84Z0d5ZHdxVHRZWlZXR3BrLy8rdldUaDAz?=
 =?utf-8?B?RUoyNzhqM24xV1hwM1dYYmpGS1BFSHNDSjhCUnUzQWJ6a3ZKL0hsa0lEM2dD?=
 =?utf-8?B?N1dPMUNnQWROT003cE5jMjBVVnhnaHJ4Sy80QVlscC8yS2h1dmQ2Y2FsRWgr?=
 =?utf-8?B?YVNEeTkxZ1FEV21kUStjYnhHNmhmN1EyaE1kVWFkYnRXNk9maUZVWEtnTzFx?=
 =?utf-8?B?YlVLdXBncmMvL1ZBTHhNRDdGdE1BRXNyNG5Ddm1vQXhYcFRJNEE5OWZaM1U5?=
 =?utf-8?Q?pwweYXt66VKMfLR0H1IHu7T66?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42654aa5-fb93-46fe-1e78-08dc8b1081ca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 18:50:19.4464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXRwq0RwyTxBEktt0RYww+CR2uT+s4QpgEGhO7shy5bpN/BpxYosI7OcJMh6b1Hgk8gIBTIXRKujCg3VJoaDtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5145
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On 6/11/2024 10:44 PM, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Jun 12, 2024 at 5:29 AM Kim, Dongwon <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     Hi,
> 
>     From: Marc-André Lureau <marcandre.lureau@gmail.com
>     <mailto:marcandre.lureau@gmail.com>>
>     Sent: Wednesday, June 5, 2024 12:56 AM
>     To: Kim, Dongwon <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>
>     Cc: qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>; Peter Xu
>     <peterx@redhat.com <mailto:peterx@redhat.com>>
>     Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is
>     rendered before switching to RUN_STATE_SAVE_VM
> 
>     Hi
> 
>     On Tue, Jun 4, 2024 at 9:49 PM Kim, Dongwon
>     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>> wrote:
>     On 6/4/2024 4:12 AM, Marc-André Lureau wrote:
>      > Hi
>      >
>      > On Thu, May 30, 2024 at 2:44 AM <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>
>      > <mailto:mailto <mailto:mailto>:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>> wrote:
>      >
>      >     From: Dongwon <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com> <mailto:mailto
>     <mailto:mailto>:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>>
>      >
>      >     Make sure rendering of the current frame is finished before
>     switching
>      >     the run state to RUN_STATE_SAVE_VM by waiting for egl-sync
>     object to be
>      >     signaled.
>      >
>      >
>      > Can you expand on what this solves?
> 
>     In current scheme, guest waits for the fence to be signaled for each
>     frame it submits before moving to the next frame. If the guest’s state
>     is saved while it is still waiting for the fence, The guest will
>     continue to  wait for the fence that was signaled while ago when it is
>     restored to the point. One way to prevent it is to get it finish the
>     current frame before changing the state.
> 
>     After the UI sets a fence, hw_ops->gl_block(true) gets called, which
>     will block virtio-gpu/virgl from processing commands (until the
>     fence is signaled and gl_block/false called again).
> 
>     But this "blocking" state is not saved. So how does this affect
>     save/restore? Please give more details, thanks
> 
>     Yeah sure. "Blocking" state is not saved but guest's state is saved
>     while it was still waiting for the response for its last
>     resource-flush virtio msg. This virtio response, by the way is set
>     to be sent to the guest when the pipeline is unblocked (and when the
>     fence is signaled.). Once the guest's state is saved, current
>     instance of guest will be continued and receives the response as
>     usual. The problem is happening when we restore the saved guest's
>     state again because what guest does will be waiting for the response
>     that was sent a while ago to the original instance.
> 
> 
> Where is the pending response saved? Can you detail how you test this?
> 

There is no pending response for the guest's restored point, which is a 
problem. The response is sent out after saving is done.

Normal cycle :

resource-flush (scanout flush) -> gl block -> render -> gl unblock 
(after fence is signaled) -> pending response sent out to the guest -> 
guest (virtio-gpu drv) processes the next scanout frame -> (next cycle) 
resource-flush -> gl block ......

When vm state is saved in the middle :

resource-flush (scanout-flush) -> gl block -> saving vm-state -> render 
-> gl unblock -> pending response (resp #1) sent out to the guest -> 
guest (virtio-gpu drv) processes the next scanout frame -> (next cycle) 
resource-flush -> gl block ......

Now, we restore the vm-state we saved

vm-state is restored -> guest (virtio-gpu drv) can't move on as this 
state is still waiting for the response (resp #1)

So we need to make sure vm-state is saved after the cycle is completed.

This situation would be only happening if you use blob=true with 
virtio-gpu drv as KMS on the linux guest. Do you have any similar setup?

> thanks
> 
> -- 
> Marc-André Lureau


