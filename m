Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A93CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 06:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDzOK-0007ZG-F6; Wed, 29 Oct 2025 02:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.gao@intel.com>)
 id 1vDzOI-0007Z7-DL
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:10:38 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.gao@intel.com>)
 id 1vDzO8-0006Zh-K3
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761718228; x=1793254228;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HqK8C7kHOdGy6rdk9RElMTegQT1mX8y2fqo+K0f26W0=;
 b=RYS84LqdmAQHnJfrbzY6d6DESZXfRCihR8yUwhuJ3rN/Q98qoYo+v24w
 U8XdHhPIFonTDsgcPGh9CoyD6dtpSgj8FrPIDlaYN5/EkCxiipgHM52fZ
 xBJ8lfSK88Sjn0QlxD/DhOkd9XosWKngmXOknvZIZt18QBRY07CDTmZ0s
 a+ptaoTK3+yzUknbktbRCB1uyAIvsb/ZtRdXPw4KlevTbPeOCIFQJGO30
 9nTo/NmQIfU6NwaEGKz88BAA0USIY3rwYrkF8qDd6l3AxCkRTGICDhFn7
 7W5Opx90HN8h55p8s4ZVQ1g89hNfDmVVPUDtSMTk9R31TlZVEjWpHotSW g==;
X-CSE-ConnectionGUID: eALbJBPVRAOoQUlVYS0rSA==
X-CSE-MsgGUID: 5jithss1RtK7rGtVT/vVOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63865699"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="63865699"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 23:10:22 -0700
X-CSE-ConnectionGUID: idNdlCHTRZCJOJnqm7Qv4g==
X-CSE-MsgGUID: u6llkmNjQ1ilMf3bnanhQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="216220863"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 23:10:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 23:10:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 23:10:21 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 23:10:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr73U0NUGY7RIuaQ2j2m+p2rRlGw/4kQ9xk91fiieIho0QPXIClfhENZ6mv9O4J+piTVCg5siMrBntcL43QeNylEKv+1XlXnwzFshSAVGzSjCQq213qoSO1463nuqkgEcwSduB0pgG8wFXcK/epkbh4ahz32RQfsKE9ljGX6blqkOTSrsJYzY+FaVMaUfpqaAi1kiaNaQQ4c6E52RuYrUcVheK1sGhuswH69byXx9X7pnOEMpJ3GCfK8yMWu8gY94Etwu2csxHSptGwNPdwUY1u/Esh8WKjJaHbaQB7Gsvp8uuq6iUWCk3RFmHgLB/tISoJgBEeTwVpHU/ynQq8/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dg3GWbuWGq9/twmKIUawtmnMCtKD+JWgQqxr59ssdFw=;
 b=GTUUFYzirVF08ERgmjBTCPg7qLnjlJPdy3nMfDPppWNco03/fd3ivy9ZL7DEANt+hLXMTG4W0yH7IkyvqdvRNPT0zKcKmfK9Z9eWrHOj4dDPHie1JWO8R9eny8SGKYhDtDH1m4dCoVPivZf/6rg0PmKaV4fUiOasni9H7pElzXFxC/Bc60UpL4o4UPLipaLdP1Q0I9NdCH75DvlUJkOcREbUdvFnhcfypFEdmx5TV5s26ryzpoQ5USkRwMSslUULPPgowVpoFgI67TsX+Gi6h+Qz/iTh0Zt/7YUGNkpcKC3u7EFFJJyAtKLz2P03PZKAnqrn5gPiPn8fC9+wstfcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA0PR11MB7955.namprd11.prod.outlook.com (2603:10b6:208:3dd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 06:10:19 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 06:10:19 +0000
Date: Wed, 29 Oct 2025 14:10:08 +0800
From: Chao Gao <chao.gao@intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, "John
 Allen" <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>, Mathias Krause
 <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen
 <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 16/20] i386/cpu: Mark cet-u & cet-s xstates as
 migratable
Message-ID: <aQGvwMTWYPx5FNdQ@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-17-zhao1.liu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251024065632.1448606-17-zhao1.liu@intel.com>
X-ClientProxiedBy: KL1PR01CA0084.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::24) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA0PR11MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 3066e1de-9def-4697-9f63-08de16b1d603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i6JppNaiBU5Un6cg3DN0LTqlrRSS6ccOxcnpTfYEycr3Qc9oNagRBsdl4hq4?=
 =?us-ascii?Q?Y1pTE7V0zbDUyO50MzbSHTBtjn1eSxxDee/NAJiQ7+xJxiMAjvPGXBkOs3Jb?=
 =?us-ascii?Q?DymodTgKjQkNTETa3Y9TNzkKcQgjU2wi6yl71YEzP2kkJbc1f6YlaQ9/syOB?=
 =?us-ascii?Q?yIxzkuYXJCDrfY69hcFb5tn8FQM0jysOXMesU2oGCYgag1ScCNvtmZVR8Rdo?=
 =?us-ascii?Q?AKzlyvJDr+ip57QFsgz3C+R89kL4JgRN5xu2w4hCN0BfP7JVRS76/rELApfL?=
 =?us-ascii?Q?57GOXFWxXDqHN9HHQd1mHNmxXgjScURrpgsXzDJs/7hlqR4O2LjnYBaeg/fR?=
 =?us-ascii?Q?ETIXtj1BrG6M9af9EsjdVFQ6GGWWEtElD+jTshjht1GDiQydEgMn9H/nCL2m?=
 =?us-ascii?Q?H+qerV2hNsX50gc1MkPtzZJkJZ2ESOmSRLuifAvBQCnrsM1nA3qL92sx6fLN?=
 =?us-ascii?Q?/gB5qunkh3ql7zl1uPITfcXp11Br4OKhPkOvwq9LuyHS/SD1P40fJfYFkhKe?=
 =?us-ascii?Q?htwc+/mU7s63vh5iLsjAZ8aLaMpOKxFQzDG9C4DLs7eey/bTKsyhH4dWqNhk?=
 =?us-ascii?Q?4x4iBjf2nUG+2bbt8vBS/ER1xU3+7W/YDr3cJuWezYpe3GvVDM6yROpfENoH?=
 =?us-ascii?Q?B7k5hMTsaeJ7u0TA8j2ygJ/I5fAeIvWPL39GQkO0QuakTROypqE8jPeqxrUI?=
 =?us-ascii?Q?aVguczn1jQgtmJnauX2XLo87Gr4fxkjLSBSutUOaks4nI3Rs0I/swVGpdWXw?=
 =?us-ascii?Q?9t2mzWoX5ZT89jQMyGhmd5XBhERQneOqBK8t9dL5K+wgoShc4Jb6ImKY9uaO?=
 =?us-ascii?Q?4iAFBfxCcVd8sfYlibsq78LG9HT8P2XTJxBgbeKBK48OKZozy8fuH2EsRxnt?=
 =?us-ascii?Q?/+WEnaTKJPpMz7dmaiHUVoPosBWJAYKKOC14RqwnSU4qaag8WFD1Fq/2TZmQ?=
 =?us-ascii?Q?t6bU0urWZAApFYbxivF4eZJ+yDyipaI99A7o5jnAI7pJ87AsOD6RanpuQAg1?=
 =?us-ascii?Q?cQrXF8UXMfNfhG6LyTFnvfjF1xaB0/27NJooC4037Ob8I2+/75dP4JRQJ2YA?=
 =?us-ascii?Q?HH332IL8yh1XihifsNVQWty6uTshJSQsyGLnWJdM4vXdW+qQdPKloA2k5wqH?=
 =?us-ascii?Q?9mJnm+1OgqUdRJIQbZzrCgFr5LU09n3AHRn85Jo0zu5QEOyTq6lYdz085TcY?=
 =?us-ascii?Q?eYvSB/qqspn92IFOmVa2gwGlKbkmwLoXB/ywJPFMg16af1SSHvAfQpHTEPPZ?=
 =?us-ascii?Q?Agkh0stkFJnaEisbP1LoRvhX7biTFHg3bu4JcJcfbLZGDxQmlrQKxVQSs0Qh?=
 =?us-ascii?Q?1Pww8JJAEEizfYdJweC2Dw4GTco0wqx1wpyg87eZ9iF29DtSeK64IJxDLie2?=
 =?us-ascii?Q?05W6v9F1jbxpmiwPNG2mBEnLJ3LVTaE5ypISL7T/i8EAaOZ/EXCQOSMXyY/B?=
 =?us-ascii?Q?Mh0uUJACBCzY+ORHPvBK7kq/qL1DWeru?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8660.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s9a+BIx7b/SbWlx/YnjTo/BbQzQn8rhQ9YFR1FmwAuwjQmjm1d3/oy+RkVV2?=
 =?us-ascii?Q?EYfUjpvej3vre2Q1K58fWVSGZQYJNCcmtuE1622yKnEB67dCSDrfSSzih3nj?=
 =?us-ascii?Q?mBrNVOhygklrxKOtAoL27LNG+QSmMfVVI5jkk7q6ozUALXQj7ZwDZc9Orc+V?=
 =?us-ascii?Q?RHtEIEpNWr+X1nncWCa6yirRlvq+C3tjsGOgGrATLmjroXp5dbYBJY7qZAGA?=
 =?us-ascii?Q?qzbGT5UeH1iHfBy8mk8cAcGUXqo0P2kbGr3nPw0/MPyBvPs6884UzvMSvMDg?=
 =?us-ascii?Q?3Vk4SAr7L+iAc7H0Z9GSX3a9fEiOPfDtOGw7zpU0ga1jviAudcgzqpnCvnLx?=
 =?us-ascii?Q?GOP0368ABv3h5w12wu3W4VtV/9IRuHITrnD+ltfQPZxmeuAp6tniWxlUtU9u?=
 =?us-ascii?Q?r5zumBcLJjLlJuNvc6d84pIQpMh98jgEZjOusdZ7h/XXQkRs2SWHZJq8p8lY?=
 =?us-ascii?Q?b4L0icWcfLglkdMgCfR4ZnH3DJGu8IUPYcWvrzUQ+/FmHZM3/8Uq5iibV2Hm?=
 =?us-ascii?Q?5vzat2ofjvIXwKr92bncOJqWTeJ3QGTVsVUAvYfGtS65ipcsUg2lMe+cVMuI?=
 =?us-ascii?Q?zPKROhv9WO5+1rZTttfSM068gKxcUvFjkKdaVvQaXDOr/ICe/2jBgkrDjwHl?=
 =?us-ascii?Q?YTBokzJHmrKuqPe+Wqckuf+9/ZnkU1XkWIrzmTQp31HoEzTGFIkjIkSWg936?=
 =?us-ascii?Q?a7DJr3QyccKZvYsYjAmOywbJ8ylKyxI60dUHryOccrfQC1/V9K4Ma8Sukn9J?=
 =?us-ascii?Q?ngo0nT3Yj/olZsceQltHEar83nZLNBTJktV3aZpLE0fE2mPPvw2Tl4W1MkWn?=
 =?us-ascii?Q?BQ1xNmJHAWYQgfyIJ484V+tpTQJs8ItPOy27qKI/GypDpOaDGpL7MTTHFHxe?=
 =?us-ascii?Q?FPhcwNyfFgf9+06zMNVx/WGNBYJ6WbT5wOEtZJizliuyqGwSQs2U8NQ0u3ft?=
 =?us-ascii?Q?TyIivCQzrSk0HqCqoOChXoxEg0dI4PFrFfRW8f2X8VMgraoYQNCVcNkyST3a?=
 =?us-ascii?Q?E3UixyN60T1kKL+vdwwA2C3cSIgOnm3/BtVJKuNElp56rrGUYdWHH2ytyxEL?=
 =?us-ascii?Q?FomJ3MXjrSoE+UzSyTi8/2FJMG+gYpdHaU9zj8z0PJMsHGLZBJVaoOkTt9dS?=
 =?us-ascii?Q?7+ani845EfFDizuheqIpMrASsqYu9BTQ2lQV5RUYnj+BSemFk7rlSelccvmK?=
 =?us-ascii?Q?O3MQ2JKoQokfFI9MDMsd4b10nuea0evBcSG7Ivrz7qOh/LaJXC/tEGIy/Rcb?=
 =?us-ascii?Q?OizGUSfEm7q7NeybObgNGALh5oHQcDB3GrTvaTL8UceTo2aovri59+p0/XHG?=
 =?us-ascii?Q?yjXCM5BaHfrMgL/ALBv2FwgrV4YfCPj8+l880QmaByu4AhY79iwW6LjkPM4h?=
 =?us-ascii?Q?fqmzu0puE839ipDFo2YuViFA95XBhp43TeiTiJtfLd6IN90SPwFrPfhfo13k?=
 =?us-ascii?Q?yz6Si4Ncha6s1O/9K5BftlTu/V91zZtksqBn2H8QCe447J9yQHErt92EGI5t?=
 =?us-ascii?Q?ukiMvz+F+9dspX2pe9u9eyNfJEF5YROBsai+PKghHrGpgheIt/OUFjGVpg0G?=
 =?us-ascii?Q?Jd4mV4FTSF7bQX0IG/MSaNAMqFd6DioZJM8By9Gn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3066e1de-9def-4697-9f63-08de16b1d603
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 06:10:19.0418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asSPCPXvqS+tWsuviwAB4byXQ6HQE07MKvOXppsty8QCPXuog1FTciWBwJF7tTtDjuYbyilcKdILB1lo+C6UTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7955
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=chao.gao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 24, 2025 at 02:56:28PM +0800, Zhao Liu wrote:
>Cet-u and cet-s are supervisor xstates. Their states are saved/loaded by
>saving/loading related CET MSRs. And there's a vmsd "vmstate_cet" to
>migrate these MSRs.
>
>Thus, it's safe to mark them as migratable.
>
>Tested-by: Farrah Chen <farrah.chen@intel.com>
>Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>---
> target/i386/cpu.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>index 0bb65e8c5321..c08066a338a3 100644
>--- a/target/i386/cpu.c
>+++ b/target/i386/cpu.c
>@@ -1522,7 +1522,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
>             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
>             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
>-            XSTATE_PKRU_MASK | XSTATE_ARCH_LBR_MASK | XSTATE_XTILE_CFG_MASK |
>+            XSTATE_PKRU_MASK | XSTATE_CET_U_MASK | XSTATE_CET_S_MASK |
>+            XSTATE_ARCH_LBR_MASK | XSTATE_XTILE_CFG_MASK |
>             XSTATE_XTILE_DATA_MASK,

Supervisor states are enumerated via CPUID[EAX=0xd,ECX=1].ECX/EDX while user
states are enumerated via CPUID[EAX=0xd,ECX=0].EAX/EDX. So, maybe we need to 
two new feature words?

>     },
>     [FEAT_XSAVE_XCR0_HI] = {
>-- 
>2.34.1
>

