Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38F1C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBTru-0004Zr-LQ; Mon, 27 May 2024 02:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sBTrE-0003p8-EW
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:29:21 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sBTr8-00052k-Ty
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716791355; x=1748327355;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FFCwsvJge8nfn8D33ZI2aNMUNmkDH0gxYNvmq9+biL8=;
 b=TyVm22eJjfGSb2a0nsIvqalNexS5A97LJjE/bXE++6xevUOj9FJUe1ej
 2GuOBEfTnDUDV6E501R2b/jUbZsuaCBF/jJsP0BoJLdJlnrJGz74cTshW
 t/57eTyc6EfqLNUEfsj2N8QWA4SKS0zab4UwhUo7rDTCZ3ZHvlhIRckxF
 PrBei4Bl9E+uv+gep0elRavVG0JZpW3VG/voY2JwGC2kdcdG7VwMyvdRe
 1YmlIWuPoKcTL+cRgfHZZ/ibdSl8gXhKQ5idyhWFJDe4j6KIlVYjnWIsD
 vI/JgVMGvW1+tn7NADy2ZOqbEEJ0AFoV6NLYM7UUMjvewqVktcRXAv21I w==;
X-CSE-ConnectionGUID: 8SUOWhVkRoi535kuuM3EUg==
X-CSE-MsgGUID: /uoPz41/Qt2BMe4ZltWg9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="23757988"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="23757988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2024 23:29:09 -0700
X-CSE-ConnectionGUID: nbPBrWE5Ri6qDxKcm0+vEQ==
X-CSE-MsgGUID: JprITVmDQ46vee4mqNH/sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="34544017"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 May 2024 23:29:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 23:29:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 23:29:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 23:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax6n0bR/Bm+N678pW3/yG6bUt1OMP7z6seGhNlRur5EcJM/WHKcH4HNDBYdpHQTmr+lKr6Pc8mbBg6dEy0neUTMqslWDF+P/mJs+PLqExEOZaIU80Sj68mM+orNsKV9V/Yyf/LbVFdC2IfOVfnv1uYuvkLz/gBPo/oxxWMD66baN2fT+HQ2JNgyj3tPUffqpfxe7nAp3/LI1pnU7hmR/eL7hJpptMAnQ6IATkHhu008gH5wVYwKkJzBxA+GWu1WzP3EKAV1PZzZVQZVLYckrVqssKGukrSVPTgkNHiAJgbiBIO9fepgRTx8vsWG2tpOqN54eZINSpkU1BaN4d86mMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8stQCE6GdRCnjWw+YiwF5rQJBtUleMQoL2OtHTQ+EIg=;
 b=HfZ1rUiT4jb5NZnVyGa1n3XmyRU6CRYPbGJvq8I7MX9UtTfT4K+ttzKDETUbWujWCvlaFPWsPLvE3ufsQufXdSgQ079ff9zSLXdz1r4mWxe89pO29YWrNEPuRx4vYdqDKnaTJxBkQ+4ifKIaHfbSsBAY30XmKqiSt4c9RStE8mqX1o0B3n0KXBXZ95aMxf3vtrnq6CpT+coM3uc+CDWDWAx43I9n6ERWN7XqVIEM29wwTH1aOunxTL14EjSGtolZwdkI7qz3a0vYrjnaxcIiH+vpW92CgldTWabB3Jxwj6RgQMGyFU4JA4K0IeMNYMZkyrn6GPvdKi3jUQ/QPqi21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 06:29:06 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 06:29:06 +0000
Message-ID: <10696888-9d9c-4a09-854d-a923246035a2@intel.com>
Date: Mon, 27 May 2024 14:32:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Jason Wang
 <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
 <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0192.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA2PR11MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0c8371-cc9a-420e-e9d7-08dc7e164758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckRDMHVhMWJKOERBWmxabjVIejV2eUhtYWY3QnBjaXRnYm5aeUpLalR0N2p6?=
 =?utf-8?B?aU9DWXFGYjArME81SjMrOG4wTXl6TWlRbzhTd1UyWDd3TVVkWmNVUThZQ2JX?=
 =?utf-8?B?WXJtWnhDZWJ4RXFFdlM0T2JNTFZqdjc1UGdVaGQzQVo0OU9VZGxxeS9Kcmxt?=
 =?utf-8?B?dnc4K044ZWNWRUpPZ1J5clpVcDd3VEZKamhzSjJKUTRIWDEyZ0VjVm9KQWp6?=
 =?utf-8?B?UXYzVUhPWTkzNUR4Tys1QXprbXQwR0c4REQ5d2JoTW9UWlY3R1ZhZWF0S2FX?=
 =?utf-8?B?dnk4cGE3dHo4THJEdmt0Z3NXYXNWZWpWUm9ReUVvcG8zTWNsRnY2dmNIbFVy?=
 =?utf-8?B?anpsKzRiY01ERE1oU25tMEs2TUo2Y2NqZzRkbDhIQ0g5TldnSW9hMmFyOVpa?=
 =?utf-8?B?V0hmclIxelUyUGhNeU02QzA5bndXOXEwM1dndC8xN2xzUHk4K1RGZlhxYllt?=
 =?utf-8?B?R3VCUTYvSktRaXRHV0dWWkwzTTM2U0hpY3VUeEFuTTd1MkpIYjUyMXk1Vmtl?=
 =?utf-8?B?TjJRLytVU1pYWHdrWVkwQjZhTWlBMnpmeE1MTWtKQzlQcVRCNi9WSFNFV210?=
 =?utf-8?B?ZmRGcURXeW1TOFBEZVFtb2V6QmdScGU3SkFaNkx3YTA0WlpCbmNFZVQwL0tl?=
 =?utf-8?B?UklWYUM5N2s0dG9XWXJjUDR6UW5kdnhyYWFCVlczeFZrWUVUbXZLQXFBbWZR?=
 =?utf-8?B?Y0IyMHFUNVczendMbXBJbm1lT3h3WFYrMkpEUmd6Qk1oNUt3NHBIdnN5dnRP?=
 =?utf-8?B?bmJIR2xENGRZL1JjeE1XMDJlbEtaMmJYdDcxZUE1emh4Ty9WZWlXdzhYMjE5?=
 =?utf-8?B?OUFYRlJKaVI5Q3pJakJ0cWljQ3Y4ZHVqYURrVDJjZEl3ektJQUV2dXJJVjVE?=
 =?utf-8?B?Wk0rSlRPT1FmSDh2T0RDcGFoREJGL042bTlVVEpieGluMlRwb01nWURMTHN4?=
 =?utf-8?B?WlQwNTNLSm1MejQwc1YwODFmeFE4Y04xMzdoaDJ3N2o0SWtOUGdZaFZpR0Uw?=
 =?utf-8?B?RURRWXFBMGF2WWFoZ1NNZWJ5TCtBUHBGOGNPZThkWnduNG5jQmxYVjc1aW9G?=
 =?utf-8?B?MFJyb3l4ZG9zczZmTy9aR0JCYmRqSnIyV0tBclJ2REFVclpGMUxqMXQ0QkVj?=
 =?utf-8?B?SVVoTDNRa3NFT3owNzdTTytzbGVnVGJLQTNtZVI4ZDYycUIzMkdkTXBwbDd4?=
 =?utf-8?B?TVRySTRkVnViMjYrdXdWWWFoTzNOVFBvcmUzVktYRXdSN0MwODVoT3M2Wlc1?=
 =?utf-8?B?a1MwRHZFSG9RcTBnemY2NzdBNUdpZnNucVdvdkIyNi9FWG1xa0JWQVlWeFlD?=
 =?utf-8?B?V0ppNkU0WmJhWVBza3ozNWYxdTA5Y0E4MVpYUDkxcDFHV3llYkM0R1IwTjYy?=
 =?utf-8?B?MzY0RWVsc05oSXkzTnU3bFk2Q0NoZ1ZYdUwxVWVUK2xlUjhjZFdkSU5NMjJC?=
 =?utf-8?B?cDFHOWgxUHd1WjhaWnFaZVRDaVJRa2l5MDhLbzF3bzhuN1FMWGkxUXpRWXo4?=
 =?utf-8?B?RnpCSUVEWTg4cXZOOHhoWGRrTEltVW9WQmFJMy9wU2FkcGpWLzdsc2VlejE4?=
 =?utf-8?B?Nk0xVUdFODVqa2J6UGQ5eGRMc3VTWGZPNSs5cnJNYkpSSCtPNUtMd0tWRmNI?=
 =?utf-8?B?M1RVUDhvaWhGUnlNdXJYcUlSU0gvdHJuQmhWazQrSisza3ZUVC94UTlhMjVk?=
 =?utf-8?B?Vkp1YjJsMjJTcVFlRDl2aWF2Z3FKN0pOVjZZKy9hOVd2bkM1MGp2VXFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7540.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW5USnBHMk02UVd6MzJRckVKTzNNVXpZd1ZuSitYU0xCSTMrUWVyNHd0V2sv?=
 =?utf-8?B?RHZyTkY5SDcrdHNXdHdONXVicEduWWhKZ1lNWFBGWjJzdFpXRTFDOHRoNVhl?=
 =?utf-8?B?MjlyTWY0ZnFGUWdLaTZRdzZhQXBsandsSzgyY0M5LzdkbjBEQnVrMElOVWZ1?=
 =?utf-8?B?WTZaYWxNTTljVVh6bDFuL3dTZkRncWpBOStHMDB5VG84b1FqUlUraWNLTWx5?=
 =?utf-8?B?UHRoWkFuMjVUT1NTMDZmNWliamFkUTZuZnFHRExaaHQxVmxyUzhPLzNoclZ5?=
 =?utf-8?B?QVhnSEYxSXArVm8wUVYwRDY0Ym9IUlRiNEpXZFBHT1NjbUw4aVdxTFl5bXlL?=
 =?utf-8?B?enZsQi9YZWpMSHA0Nm54MUp0UVRiNngyRDQ0c09mVmtZUXZtNjNFaXZHVnV0?=
 =?utf-8?B?N0E2T2lUaGtFUGNaUitpRW14QnJjaUxCR3Z0a2E5ZkFIZkZCc0VmK2Y5RVlu?=
 =?utf-8?B?T2JOMUlpWE9HdGNGTFFDdkorSE1kY3BEdzQzbGJjdS9sRXRNbXhYakl1dE03?=
 =?utf-8?B?c0JNV01MVlZLZkFNQmhBcUNnbUYxdVpka0Zwa2Z0RU84SWlXSW1BUm9pR1p0?=
 =?utf-8?B?bS9qUmJhR1RKb3ZMb3lOOTlsT3BDdThJSWptWm1vTkVlUUlYeDM4TVYzZnk5?=
 =?utf-8?B?SmJzTnBrY1BKRk9rWmZMWTNGMEVDM3plQk9MaXgrRWcrRUxCcUxiQnV0N1FV?=
 =?utf-8?B?T1hvdVpyNmtxcyt6UWpTdmpHL2hZaHdZNmlUd0FGMnFnTVQzcllkRlVJOWRa?=
 =?utf-8?B?cGYwRlYxOVBqc3dEVTdWVGJScXJpSFkyd2YxelBNOTZPSUFGV3ZXM2swVHhx?=
 =?utf-8?B?T2dDbGs5MWljMkI0eUhzSW9vbzNNWjhwNW9Ua0xPYkgvYkx2Q1EvSnBGU0dE?=
 =?utf-8?B?dStMWWx0K2p3NHkwMTRTM1g5S29IRERNeGczL2JScFRqT1ViOGJYTGV1WXEr?=
 =?utf-8?B?OVZJaEdNcEVTOWVJQkROZzRTb3BpeXU0MXB6eUlOdlEzdnJ2Sk94L21VM3A0?=
 =?utf-8?B?ZXNQdTBDNTJWZEV0dUZzQTcxTFJ2T0cyamFCUko1TGxpU0RVV3NkUnFka3Uy?=
 =?utf-8?B?ay9rKzYwQ1BVYXNGR0xtWWw3YlVkalhkdjVlKzFMdkFQMWt5SGY4SS9KaGRC?=
 =?utf-8?B?cDFsZzlFRmlZTU41c3RTUzZ0NkFpNm4wSkNIZHdoNHk1a0hsekl6WThxeXNG?=
 =?utf-8?B?R0xkY1lXZjR5TjZWUFJzamJYTTl0R0l5QmYxRWIwLzd3VVBma2hzRFpuOExW?=
 =?utf-8?B?bktJUGlXTUV5WmlIOFFrVUFWa0JMVUdwcW1lc1NYQjUySU9KaWRTOTdLTlBB?=
 =?utf-8?B?SExKUWdJN3BjemlOa1lmVk5UWnMvNjJOMTdNZm1GZE5XNS9hSDloM2F3cS85?=
 =?utf-8?B?SWtPNWsrNmZoaURxTjRFVStITTRQWDUzT2RZRUV2Mm9PSjdWUXhuMms0U2tY?=
 =?utf-8?B?QXYrclA1bUlSR2RPZHpVZFY1WlBrd2FvLzNmMDluY1BKcHRybVJ3ankrTXdq?=
 =?utf-8?B?TGtVY05SbVBPQTZPb1N0UnZhNGlxUFNrWTFCcXZ6SmpqWHFxeVFNeElzZGxS?=
 =?utf-8?B?dmpPOE1EMzJHVnlDSDJrbVFJVHV5QU1iUzlxRFpMRTJMYnBBc2M4VkpFV2N3?=
 =?utf-8?B?bmVrQWIzQ1gwMThMNFZCQlNQdm92RlVqM1JQWXg4K2RhWU0vS0VHWEtWVmF1?=
 =?utf-8?B?ZUxGSHZpd3JoQ0VHaytxYjAwS3A2OXlVem94N0o1LzVkSTFVWVFFWHF0QU56?=
 =?utf-8?B?b2ZLT24yNjJrYTBlaWVucDk3RVJwK1FMb2pqZVNrRWp1NkZoWlBmaXFaanU2?=
 =?utf-8?B?cGxJSDV2ai9jYTU4MnU1QktlckZsWHM0dGNOcW9VYUxGcjhJQzEvUWduZEJw?=
 =?utf-8?B?MUlNUnZYc3dpQmtNYjNWYWNpU1YzU1ZBUXFmanBSS2lpQmtIbGRnNjlGUUNK?=
 =?utf-8?B?a2dTUkpxT2ZaTjIxUWhjVytoVGsvQk02SjhNcms3ZjlyVmlCZ1V6VWltZm5m?=
 =?utf-8?B?QWJDZmsydDFyMVFDa2FsU1NRelNueFQ4eVk5d2tqL2xmcnZjQkoxUWFGNkUw?=
 =?utf-8?B?bitHZlJpRE9vbExseFp2STUzTWxNSXpObjVMbGdQbWp1T3FycUp1ZjF6OW93?=
 =?utf-8?Q?s+Ah+Mm83jSfTBLiQP1RLKvoc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0c8371-cc9a-420e-e9d7-08dc7e164758
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 06:29:06.2540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GndeAxH1A4vZ99ZZuGA75P4NKIEY99C642igOJZh5sXeW1txJsx3eqeNxBR/G+n0crOAJdCF8PnmuCXOfenkLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2024/5/27 14:04, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Jason Wang <jasowang@redhat.com>
>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by
>> spec
>>
>> On Fri, May 24, 2024 at 4:41 PM Duan, Zhenzhong
>> <zhenzhong.duan@intel.com> wrote:
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jason Wang <jasowang@redhat.com>
>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by
>>>> spec
>>>>
>>>> On Tue, May 21, 2024 at 6:25 PM Duan, Zhenzhong
>>>> <zhenzhong.duan@intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Jason Wang <jasowang@redhat.com>
>>>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined
>> by
>>>>>> spec
>>>>>>
>>>>>> On Mon, May 20, 2024 at 12:15 PM Liu, Yi L <yi.l.liu@intel.com>
>> wrote:
>>>>>>>
>>>>>>>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>>>>>> Sent: Monday, May 20, 2024 11:41 AM
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Jason Wang <jasowang@redhat.com>
>>>>>>>>> Sent: Monday, May 20, 2024 8:44 AM
>>>>>>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>>>>>>> Cc: qemu-devel@nongnu.org; Liu, Yi L <yi.l.liu@intel.com>; Peng,
>>>> Chao
>>>>>> P
>>>>>>>>> <chao.p.peng@intel.com>; Yu Zhang
>> <yu.c.zhang@linux.intel.com>;
>>>>>> Michael
>>>>>>>>> S. Tsirkin <mst@redhat.com>; Paolo Bonzini
>>>> <pbonzini@redhat.com>;
>>>>>>>>> Richard Henderson <richard.henderson@linaro.org>; Eduardo
>>>> Habkost
>>>>>>>>> <eduardo@habkost.net>; Marcel Apfelbaum
>>>>>> <marcel.apfelbaum@gmail.com>
>>>>>>>>> Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons
>>>> defined
>>>>>> by
>>>>>>>>> spec
>>>>>>>>>
>>>>>>>>> On Fri, May 17, 2024 at 6:26 PM Zhenzhong Duan
>>>>>>>>> <zhenzhong.duan@intel.com> wrote:
>>>>>>>>>>
>>>>>>>>>> From: Yu Zhang <yu.c.zhang@linux.intel.com>
>>>>>>>>>>
>>>>>>>>>> Currently we use only VTD_FR_PASID_TABLE_INV as fault
>> reason.
>>>>>>>>>> Update with more detailed fault reasons listed in VT-d spec
>> 7.2.3.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
>>>>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> I wonder if this could be noticed by the guest or not. If yes should
>>>>>>>>> we consider starting to add thing like version to vtd emulation
>> code?
>>>>>>>>
>>>>>>>> Kernel only dumps the reason like below:
>>>>>>>>
>>>>>>>> DMAR: [DMA Write NO_PASID] Request device [20:00.0] fault addr
>>>>>> 0x1234600000
>>>>>>>> [fault reason 0x71] SM: Present bit in first-level paging entry is
>> clear
>>>>>>>
>>>>>>> Yes, guest kernel would notice it as the fault would be injected to vm.
>>>>>>>
>>>>>>>> Maybe bump 1.0 -> 1.1?
>>>>>>>> My understanding version number is only informational and is far
>>>> from
>>>>>>>> accurate to mark if a feature supported. Driver should check
>> cap/ecap
>>>>>>>> bits instead.
>>>>>>>
>>>>>>> Should the version ID here be aligned with VT-d spec?
>>>>>>

Folks, looks like it's not necessary to be aligned with spec version.
e.g. I can see something like below. This is an old machine which is
not possible to be built according to vt-d spec 4.0. Let me check more
machines as well to confirm this.Perhaps virtual VT-d implementation
can have its own version policy? @Jason, how about your idea?

cat /sys/class/iommu/dmar0/intel-iommu/version
4:0

>>>>>> Probably, this might be something that could be noticed by the
>>>>>> management to migration compatibility.
>>>>>
>>>>> Could you elaborate what we need to do for migration compatibility?
>>>>> I see version is already exported so libvirt can query it, see:
>>>>>
>>>>>      DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
>>>>
>>>> It is the Qemu command line parameters not the version of the vmstate.
>>>>
>>>> For example -device intel-iommu,version=3.0
>>>>
>>>> Qemu then knows it should behave as 3.0.
>>>
>>> So you want to bump vtd_vmstate.version?
>>
>> Well, as I said, it's not a direct bumping.
>>
>>>
>>> In fact, this series change intel_iommu property from x-scalable-
>> mode=["on"|"off"]"
>>> to x-scalable-mode=["legacy"|"modern"|"off"]".
>>>
>>> My understanding management app should use same qemu cmdline
>>> in source and destination, so compatibility is already guaranteed even if
>>> we don't bump vtd_vmstate.version.
>>
>> Exactly, so the point is to
>>
>> vtd=3.0, the device works exactly as vtd spec 3.0.
>> vtd=3.3, the device works exactly as vtd spec 3.3.
> 
> Get your point. But I have some concerns about this:
> 1.Exact version matching will bring vast of version check in the code,
>     especially when we support more versions.
> 2. There are some missed features before we can update version number to 3.0,
>      i.e., nested translation, Accessed/Dirty (A/D) bits, 5 level page table, etc.
> 3. Some features are removed in future versions, but we still need to
>     implement them for intermediate version,
>     i.e., ExecuteRequested (ER), Advanced Fault Logging, etc.

Even the hw follows vtd spec 3.0, it is not required to implement all of
them. So it should be fine to implement part of the capabilities. :)

>>
>> When migration to the old qemu, mgmt can specify e.g vtd=3.0 for
>> backward migration compatibility.
> 
> Yes, that makes sense for such migration.
> But I'm not sure if there is a real scenario migrating to old qemu,
> why not just update qemu on destination?
> 
> Thanks
> Zhenzhong
> 

-- 
Regards,
Yi Liu

