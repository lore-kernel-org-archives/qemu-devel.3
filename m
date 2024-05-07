Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAB4C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FZ8-0007MP-Rt; Tue, 07 May 2024 03:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4FZ0-0007JL-AN
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:48:40 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4FYx-0003u3-17
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715068115; x=1746604115;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y/ecbJcBfkkdGDIDVV6H+m4ObeG1H0q1F9V9ks/KP38=;
 b=LPhdvXmoZoEm2FpNy6IVpRphj4p7bjNA+v+IXRHjxPJTM5MHMWR7MLry
 H3hNimA4EF7XGsZfN3dKJpsuoyJRI+20yL41aLFepZItAFiKOMsJobfgy
 cReGxD6LvaO3g5hhbpr3QeAljDDw+q0BHz4T0SOIicgTTUQoR2yR5riY4
 31O27a6k3mF3xexrBnLr6Y5iBkOYTuzhP7PW8unhVFOUWmMdUeDGTlrgG
 aKtaqWgeZEVHygkec4jGL8cXQK6HxPClv1gbC3yOBPhGg/2qpygeTc8AW
 jwF5ItQO8bT/u5xpcXIMTOlQHPT6yImW3Kc7uWd+sr0vx3R61yW1xh2DX w==;
X-CSE-ConnectionGUID: AZCH6sfBRnqa5CDShN0HIQ==
X-CSE-MsgGUID: fTmRYmz7QEOWXRTmeTgtBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22257186"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22257186"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 00:48:32 -0700
X-CSE-ConnectionGUID: qprIAzGVTIq+3hrxXGN04g==
X-CSE-MsgGUID: 4pV5L3PiRWePmCYQoqFmNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="33236355"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 May 2024 00:48:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 00:48:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 00:48:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 00:48:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 00:48:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GebSpxdEha14hhtHRB0xANKfoczkxiqhqxbxvLBVER/MnWnMTiafprLPcIVixCklDrbRIjnfV1LvlJRex/6MdSfLLBZUy/QBzcXcO6gFjCRzjgMVDqx2ngBGYuJN3U7JibgExo7GRU2eEbSoAFujv5ieXVV0HdNhkvizNLBtUQa/5NucZO1lBP+uSJeNtITKaZf+E07Nd12KmQSdvcil4qklh5m3j1XbfGgcH/nq0S63yhIXHtxXGx7DuBpFA7KmjLMqYUvKdaZrZkn/JQ24HR0Gk+0rQtbP02FdA5ZlJjT1lPvU95sVmhPY4CHzrysY0l1aTd3F+IHlAl1CtZNzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/ecbJcBfkkdGDIDVV6H+m4ObeG1H0q1F9V9ks/KP38=;
 b=SU+VU5I+EY30NTrAIWioeNI15k80Ai49+xzRZW2q4lVI41D9YvNhc5Oz9RhQdyRj6x0T+KtnXUW5TrR1cf1NSXTGFYfg57MKMlMStpp+5lDAckgkTT+Ml3a8zLRC2gan4aruKeEh7Zo5miciCk86+i2CIi0Gf83nXH+Yx07IrOa0T84iXWqnqhqtd15Lssb+nAIr8rA49TkLPAuMVFdZvCi5dsjflyvchItC4aq362/lSKccWbPQ6An/3DQVJSnhzuFkHlp5PdnFAFV/GVSBxBL0+Zbzt+zqDOLn9xQ1zkuBFAhyj4tzPvNGEoTtVBVvtI0rWSjsJZzgXZB/TAlsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 07:48:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 07:48:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 15/19] hw/pci: Introduce
 pci_device_[set|unset]_iommu_device()
Thread-Topic: [PATCH v3 15/19] hw/pci: Introduce
 pci_device_[set|unset]_iommu_device()
Thread-Index: AQHamgIc3p7zOkUbKEGY+9IBw5Ark7GLZbOAgAALF4A=
Date: Tue, 7 May 2024 07:48:26 +0000
Message-ID: <SJ0PR11MB6744EEA78AD1ADA4CC71DD8092E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-16-zhenzhong.duan@intel.com>
 <adb10cf9-faff-41f1-a6e4-e7c169f16c72@redhat.com>
In-Reply-To: <adb10cf9-faff-41f1-a6e4-e7c169f16c72@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7744:EE_
x-ms-office365-filtering-correlation-id: 42feff85-12f7-4ca1-fde3-08dc6e6a1472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|7416005|1800799015|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?Zzdsd29rdVdWQ2JWaDhwVml6ZFE4QkFjaCtzcGxtNUlhTEQ1WGZwK2M1czVl?=
 =?utf-8?B?Y3draFRQT3Fialdoblh3REE2UFBSU3VuRGRzREhqandwTFgwejZCbEZuN3Zt?=
 =?utf-8?B?dUcxWmtOdzNQcVBlNUxNL3JFem1TWDJTZzIyaksxRGw4TnBaSXNRclprL3RU?=
 =?utf-8?B?TC9RcVdOZEw3REJPOSszTm41N0pIdEpSMlZpcEVtazVpbjEvUnNWbmdtU0wx?=
 =?utf-8?B?YjZiaW8wWWptQWJsZ1FCcWVLcFpSdzVpckNDOFZ0MThvd0RKdVhrTlhMTnZQ?=
 =?utf-8?B?c3ZPdjdsSG8wTGZaUGo4U2dITmczRmRtQ2t4SXdCNFFDODNKdWU5RWZMYWVp?=
 =?utf-8?B?TXNkV3lSU2ViTWQ2RXZWVkkvc3NDaVJoSjY5K1ZMWjVQbWk1MHBrUW9pNGM4?=
 =?utf-8?B?MjJTVlNXcUNFL1ZVeXFDQlZVbTJYWHpxQnZZWVVmWkwzZjNKNjVlYWs2aVd1?=
 =?utf-8?B?bVFuWE5yN29PZUhYenBTbUtZMk4vM0ZsWm9OOGxOWERLNXFuRUJYc0RMRkN2?=
 =?utf-8?B?QjBBaU9lNWpJZkVKRlVmVW41bkl3UmFTVDdteFhjWUdaelI5NW0xZEh4d0RU?=
 =?utf-8?B?dHJEZ2UrRGs0U2NyQUVsa0tuaEo0a0dSajN3c25wdWpINklRL0JLV3RBUUIy?=
 =?utf-8?B?eEl3dHNsWHkzN0ZhdzRyb09LS1gzamo5U3pWc2lsTWE0WjI3N25mOXFUelRr?=
 =?utf-8?B?RTZORnRHTGZZZGpiQzkwKzlVcHFIS3haTG5FT01yb29qZHZwWHBIUjJpbzVV?=
 =?utf-8?B?TG9SMVRIUlpmYUZHMW5VbW52TEJpUnd1TEkxaG8zY3BjMUlVa2kzbGRjNjNo?=
 =?utf-8?B?TEhFeHFDNXZTb3ozaG8rWEFpVFJ0TXVLait5MmRqd1oxSmgvVExPM3lpVlM5?=
 =?utf-8?B?bkQrUHFMOTI3WndEb21GYWU4TkllblAvVjhQY21nZlhHaFF1emxzSWc1eGxj?=
 =?utf-8?B?NVJuUTNYbWtKM25Mb0YwVkJsekxQNFJZR1FLS0xkVkZ5RjlQRUM0V0NUTldV?=
 =?utf-8?B?ZjZLa3ljQzMzaDRzQVlJR1lPWVNYUkhkakpKYkNnMXpEVUVMVE9QYmdkbk12?=
 =?utf-8?B?ZTVGcXIyWU1vNG5WSC84R2thR3dLZVB1dDhBTW1aSnhqcFQveU90TnFxT1pr?=
 =?utf-8?B?RUw4MHZJOFpCd0hQU3ptN1F3Nzg5WlBtZzNFQU5XeG1VRUxwV2FGMlJDMWJv?=
 =?utf-8?B?RlZtb0dOeWg4dExoYzhoMGFEQWtHL3paQzg1VjloZjRLVFdRemZ0TjNWc1Bj?=
 =?utf-8?B?cGRodjlHSkM3eGFPZzE3bDBVNlZyUmNrbkNIS3hDYmQ0OGlRQU1rd2lDdU40?=
 =?utf-8?B?TkhteXM5cXVUdUdRYnhObVRtZTRQTWZnNU91VURhZzk2ODljRGNTUk1EOE5O?=
 =?utf-8?B?Q3VYaDdXSXp3WkY1WUZ1d0EwblA4ZUhHd3pDQ2p4SGtSbUZBcW5nM1lFZWdi?=
 =?utf-8?B?SUZhcWRIZXJScEZDcURnRnV2akVSejRZSVBTa25EbHVkNUNBRDhobldnYTBh?=
 =?utf-8?B?RjlyR0pGeGNRREV2aXlJSEs0YmZvb1BQWVM5VStqbU5ySWRzam5rakVjMGp0?=
 =?utf-8?B?VTJJam53Z1NOK000R1o4aG55S1NSdTBRakNrNlF6bFI1MThhempZa3ErV0kr?=
 =?utf-8?B?dHh0UlpjRU1HTy9aOGtzQU94Q2NQam9YQkZiT3lTYVU0NWZSR2l6VjFUMDlp?=
 =?utf-8?B?cGc3QXIwOUcyWjJ3TVRWdVRYejBCczBaRmNrbHh6UmY1M2dpSDV5OFAyVlJK?=
 =?utf-8?B?WE1TbTMwSy9SNmZjVWJrSWRmU3pjWkpzNVFBMFovdkFqWlVQTzhQbVZtSjhM?=
 =?utf-8?B?d1E0MkNmUElDb016cXdHUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUdOTWxORFNYSlVKWFp3Umc2WS8wT0pOaG5MMUFiamlBZnlzZWd5ektHdWUr?=
 =?utf-8?B?Z1Vpck53aW16bTAwTGE3VlpYMkZSZ1ZhbkVTRXAvaTBKUjQrT3VPV0FCWjBM?=
 =?utf-8?B?bkdPbEhwcTBNcHFlTFJleWhrNytaNEdhVFpsWG9HTktPOTJrR0ppTG9ueE1j?=
 =?utf-8?B?bVZUS3BEeCtNdWxIUnZ2aHFieUJUcWNjSkk1Y3dtd25UQVVMRnJBVDF5LzNY?=
 =?utf-8?B?SXJ0TFpWcithZGxjNE85dU5xcW8waFpNeTVJYjZjMFJWOVZhSWNwaytjeWRJ?=
 =?utf-8?B?N3hOWnpHamlDcWZ6T1ZySXNnVTR0L3pibWhoZ2NETFpuejZMYjRDS3lWUjgx?=
 =?utf-8?B?VE9DQlBPbGF4Mm5LMHVoYWRHdnVlek9FTi9jcXE1V0trS3BTK2JHc0tja3po?=
 =?utf-8?B?OHNJYU1ITE91YmtsekI0cHZ3M3ROY1NZN0FGK3ZtSlo1cVBlVk9zVEFpcTEr?=
 =?utf-8?B?bWx3NUdma1Q5dHFJMXRDOXZZd2x6cS8yZFgxd21IaGRuSVgxdHhKT1BPVmRy?=
 =?utf-8?B?eDM4djNFV24wclBlVFR0M1FLdUE3NGtKZkI3OC9aUU4vYXV4MUYrTEdKVnhv?=
 =?utf-8?B?eWJMK3FYZDZER0tMUkxjazdnU1J3d3BwcjRTNW44T25LU2ttL1J4aDJwbHdD?=
 =?utf-8?B?clF0ZllQK3AvMU8vUzQzV1ZpRXFCamlvMXVyK3F3c042RFBHYUd5NEg1RzRk?=
 =?utf-8?B?UE81U0JncjBxaCtSNmt3NEJablN0OTR2THl5RE9pTHY4QUk1Z1NJbllxSVJz?=
 =?utf-8?B?b3VXTk8rUFZ1Q0l0VHVUS2VRYXhEOE5pVTBRcDYySE9LZElPdlFFaUZIcmJm?=
 =?utf-8?B?SkU2cUpXdjlSZTVwVm1PM0x4dStoeWxONFdVUWVoYVVYU1I5QVZtL0RmdUg2?=
 =?utf-8?B?c3AzdzdsZ3h0ektLaWp2SFBFSmU3bzZXMFVUMVNJc3ZhOG5XV1Jkd04wT1dB?=
 =?utf-8?B?cjVML3RXTEZQeTB0RnBMek1DTlRKeThTczNGSUxvRStQY29JTXpNNHhlT3Vl?=
 =?utf-8?B?L1BIbHh4Vjk0TWVhK0RpY2ZBTzVQTkN1OEExSjFYNVBCSUhVTEd6MlVJbTBI?=
 =?utf-8?B?eUpCTTJBMVdqZk9TMHc2eUtLVDJrM0hBVG5zSm9XMDlkTFZINWduUUprYzZY?=
 =?utf-8?B?MUpTcFhYUjgwQ2htNzN3MHV5RmpzY1IvdTg2alA3THJrRTRlSHg1Mlo0RmNI?=
 =?utf-8?B?eE5aOGFjTDNSWHhpdjAxcWpzMVIyVGFVanpOcjBmNHVUQk5uQXFkQXdPNkpE?=
 =?utf-8?B?V1VnMUR5MExwUEt2ai96UjdiZzEzWmo4VWIySGdpaFJZSW9yT0lXS0VUTnRS?=
 =?utf-8?B?dkQ3dmFyY2FINW1FZ1pHdy9TaXpNV2crYndPMUQwMUV3RGhjdGJVLzVnM25F?=
 =?utf-8?B?RjhWWFJvNVY2SnZkdmNuZjM5TzRLaUQ4b1F3OUZKYStHd1FDNlNaQ0RPcWRH?=
 =?utf-8?B?d080dkZrQ1NpS3ViZzZhcE5RMEltRkV4Y2NkZXVrSGxLT1V6d1BMeVUvUmdH?=
 =?utf-8?B?WElSTjI3eTRzc3k3WEZCbDdFcHVqUVJiKzBCVmczMDRtd09kK25NbnNKVTg3?=
 =?utf-8?B?SWJkakl1MXdxS2oxR0xBTGZvTmdxYmRFd2IxK0Q2c2NKb2s3UklXMUtOTU95?=
 =?utf-8?B?ekg1aW1sUUI3NURmTkRKaktqdUlnNnpFeFFBb3RaZ3JjeWJveTJTUjdvUm1R?=
 =?utf-8?B?MEpkTCtmR2tGaTJ2SGdLUkxaSWRHNXZzTXJheEhvRStVeEkwdVEyQW5IVk1T?=
 =?utf-8?B?bUloZ1ZNRUJpZmxtNkVzT2dSSzFldUR0Z1hma2lmNlFSMko4ZVNNOFBRUWJq?=
 =?utf-8?B?ekdKcnFybHR1eVlVbkxlQ1dWNFZETnZQcHZPdWM2cHE1VFBuTnZhYUhsbjRD?=
 =?utf-8?B?YzFuYlZlMDBvQVVIQ3dmWjVrZkx2R0JDc3pPRU1LZ0F6SHN4bUZKd3hESnZP?=
 =?utf-8?B?cHU4a3NXS2l0SlRXVUYvN3ZsVXU5V01hWFBzc2FOblhPRkpqbTE4Uk9DTjQw?=
 =?utf-8?B?ODhFd3h4UmhYaHJvQ041eGNDMlFiWnIzTmhsRjI5Zkp5bllLY3BWUUZUQW5r?=
 =?utf-8?B?OEU0UWhSaWdoTmlpTFlZNDRDRm03NTcvejJVMzcrY2F2ck5mYlZwajFzSEQr?=
 =?utf-8?Q?ORBN30iczZ8pfQ5BqMV8NIVpj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42feff85-12f7-4ca1-fde3-08dc6e6a1472
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 07:48:26.8186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MF4jyTv8uDdS6LAhlTdBhHL7ikzVezhOy2hrHgnFJejeEpdgWmrgRFxcNtRwGXojJ29f489Lv2+MkTXh8pEEaYWnqw9h9atxh21NWHC7mjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTUv
MTldIGh3L3BjaTogSW50cm9kdWNlDQo+cGNpX2RldmljZV9bc2V0fHVuc2V0XV9pb21tdV9kZXZp
Y2UoKQ0KPg0KPkhlbGxvIFpoZW56aG9uZywNCj4NCj5PbiA0LzI5LzI0IDA4OjUwLCBaaGVuemhv
bmcgRHVhbiB3cm90ZToNCj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4N
Cj4+IHBjaV9kZXZpY2VfW3NldHx1bnNldF1faW9tbXVfZGV2aWNlKCkgY2FsbA0KPnBjaV9kZXZp
Y2VfZ2V0X2lvbW11X2J1c19kZXZmbigpDQo+PiB0byBnZXQgaW9tbXVfYnVzLT5pb21tdV9vcHMg
YW5kIGNhbGwgW3NldHx1bnNldF1faW9tbXVfZGV2aWNlDQo+Y2FsbGJhY2sgdG8NCj4+IHNldC91
bnNldCBIb3N0SU9NTVVEZXZpY2UgZm9yIGEgZ2l2ZW4gUENJIGRldmljZS4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6
IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogTmlj
b2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpo
b25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRl
L2h3L3BjaS9wY2kuaCB8IDM4DQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0NCj4+ICAgaHcvcGNpL3BjaS5jICAgICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9o
dy9wY2kvcGNpLmgNCj4+IGluZGV4IGVhYTNmYzk5ZDguLjg0OWUzOTE4MTMgMTAwNjQ0DQo+PiAt
LS0gYS9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgN
Cj4+IEBAIC0zLDYgKzMsNyBAQA0KPj4NCj4+ICAgI2luY2x1ZGUgImV4ZWMvbWVtb3J5LmgiDQo+
PiAgICNpbmNsdWRlICJzeXNlbXUvZG1hLmgiDQo+PiArI2luY2x1ZGUgInN5c2VtdS9ob3N0X2lv
bW11X2RldmljZS5oIg0KPg0KPlRoaXMgaW5jbHVkZSBkaXJlY3RpdmUgcHVsbHMgYSBMaW51eCBo
ZWFkZXIgZmlsZSA8bGludXgvaW9tbXVmZC5oPg0KPndoaWNoIGRvZXNuJ3QgZXhpc3Qgb24gYWxs
IHBsYXRmb3Jtcywgc3VjaCBhcyB3aW5kb3dzIGFuZCBpdCBicmVha3MNCj5jb21waWxlLiBTbywN
Cj4NCj4+DQo+PiAgIC8qIFBDSSBpbmNsdWRlcyBsZWdhY3kgSVNBIGFjY2Vzcy4gICovDQo+PiAg
ICNpbmNsdWRlICJody9pc2EvaXNhLmgiDQo+PiBAQCAtMzgzLDEwICszODQsNDUgQEAgdHlwZWRl
ZiBzdHJ1Y3QgUENJSU9NTVVPcHMgew0KPj4gICAgICAgICoNCj4+ICAgICAgICAqIEBkZXZmbjog
ZGV2aWNlIGFuZCBmdW5jdGlvbiBudW1iZXINCj4+ICAgICAgICAqLw0KPj4gLSAgIEFkZHJlc3NT
cGFjZSAqICgqZ2V0X2FkZHJlc3Nfc3BhY2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGlu
dA0KPmRldmZuKTsNCj4+ICsgICAgQWRkcmVzc1NwYWNlICogKCpnZXRfYWRkcmVzc19zcGFjZSko
UENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50DQo+ZGV2Zm4pOw0KPj4gKyAgICAvKioNCj4+
ICsgICAgICogQHNldF9pb21tdV9kZXZpY2U6IGF0dGFjaCBhIEhvc3RJT01NVURldmljZSB0byBh
IHZJT01NVQ0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBPcHRpb25hbCBjYWxsYmFjaywgaWYgbm90
IGltcGxlbWVudGVkIGluIHZJT01NVSwgdGhlbiB2SU9NTVUNCj5jYW4ndA0KPj4gKyAgICAgKiBy
ZXRyaWV2ZSBob3N0IGluZm9ybWF0aW9uIGZyb20gdGhlIGFzc29jaWF0ZWQgSG9zdElPTU1VRGV2
aWNlLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAYnVzOiB0aGUgI1BDSUJ1cyBvZiB0aGUgUENJ
IGRldmljZS4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQG9wYXF1ZTogdGhlIGRhdGEgcGFzc2Vk
IHRvIHBjaV9zZXR1cF9pb21tdSgpLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAZGV2Zm46IGRl
dmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyIG9mIHRoZSBQQ0kgZGV2aWNlLg0KPj4gKyAgICAgKg0K
Pj4gKyAgICAgKiBAZGV2OiB0aGUgZGF0YSBzdHJ1Y3R1cmUgcmVwcmVzZW50aW5nIGhvc3QgSU9N
TVUgZGV2aWNlLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAZXJycDogcGFzcyBhbiBFcnJvciBv
dXQgb25seSB3aGVuIHJldHVybiBmYWxzZQ0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBSZXR1cm5z
OiAwIGlmIEhvc3RJT01NVURldmljZSBpcyBhdHRhY2hlZCwgb3IgZWxzZSA8MCB3aXRoIGVycnAg
c2V0Lg0KPj4gKyAgICAgKi8NCj4+ICsgICAgaW50ICgqc2V0X2lvbW11X2RldmljZSkoUENJQnVz
ICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBIb3N0SU9NTVVEZXZpY2UgKmRldiwgRXJyb3IgKiplcnJwKTsNCj4+ICsgICAgLyoq
DQo+PiArICAgICAqIEB1bnNldF9pb21tdV9kZXZpY2U6IGRldGFjaCBhIEhvc3RJT01NVURldmlj
ZSBmcm9tIGENCj52SU9NTVUNCj4+ICsgICAgICoNCj4+ICsgICAgICogT3B0aW9uYWwgY2FsbGJh
Y2suDQo+PiArICAgICAqDQo+PiArICAgICAqIEBidXM6IHRoZSAjUENJQnVzIG9mIHRoZSBQQ0kg
ZGV2aWNlLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAb3BhcXVlOiB0aGUgZGF0YSBwYXNzZWQg
dG8gcGNpX3NldHVwX2lvbW11KCkuDQo+PiArICAgICAqDQo+PiArICAgICAqIEBkZXZmbjogZGV2
aWNlIGFuZCBmdW5jdGlvbiBudW1iZXIgb2YgdGhlIFBDSSBkZXZpY2UuDQo+PiArICAgICAqLw0K
Pj4gKyAgICB2b2lkICgqdW5zZXRfaW9tbXVfZGV2aWNlKShQQ0lCdXMgKmJ1cywgdm9pZCAqb3Bh
cXVlLCBpbnQgZGV2Zm4pOw0KPj4gICB9IFBDSUlPTU1VT3BzOw0KPj4NCj4+ICAgQWRkcmVzc1Nw
YWNlICpwY2lfZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UoUENJRGV2aWNlICpkZXYpOw0KPj4g
K2ludCBwY2lfZGV2aWNlX3NldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYsIEhvc3RJT01N
VURldmljZQ0KPipoaW9kLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJy
b3IgKiplcnJwKTsNCj4NCj5wbGVhc2UgaW5jbHVkZSBhIGZvcndhcmQgZGVjbGFyYXRpb24gZm9y
IEhvc3RJT01NVURldmljZSBpbnN0ZWFkLg0KDQpHb3QgaXQsIHdpbGwgZG8uDQpNYXliZSB1c2lu
ZyBpb21tdV9od19pbmZvX3R5cGUgaW4gaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2Uu
aA0KaXNuJ3QgYSBnb29kIGlkZWEgZnJvbSBzdGFydC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

