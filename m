Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEEDC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 03:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seRRp-0001Kw-IO; Wed, 14 Aug 2024 23:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1seRRn-0001Ji-RI
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 23:46:47 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1seRRl-0005VG-N4
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 23:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723693605; x=1755229605;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9aLsWPRmKrjsVu5UzvGG7Vv/3ufloJbHP6kKAJnjalc=;
 b=TUq/NU5ArkNPbVkXXofsEgQqoKXG4pihbyJELOM8pLY9JpS1w+waCk3k
 KocwdA0H6h2N7B5YG4+YGJ3+ZPSSCcVsUwJC6tLbID25vKtqrFf+37Tlh
 1T5OAibXX8ki7edTxAQYKLDZ5n6M6eyIG2f693xquHwVpSpHijuvT7s9+
 JAKRt6yiZPbEiV49xVCWNNf1ltG0jcM1hbnmeHWWH1r9RTGi+ks8sJmYE
 Qi6TQuuwOLrtNlfuJPipNAaDpmSRVmj0l6ZBkW/rZtevRxEKgoiXgOCXz
 Nl1sMEf+In8twQJ5YQfr+9jCMsK+c515QItpy1RXaobmFBMCAE+3Y3j57 w==;
X-CSE-ConnectionGUID: KLiA0tTjTy6tnIxJonvqoQ==
X-CSE-MsgGUID: llNBGPtNR82PheVJN0f+UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="39398122"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; d="scan'208";a="39398122"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 20:46:43 -0700
X-CSE-ConnectionGUID: S7ocNFEOTOqyqJjOIKsxzw==
X-CSE-MsgGUID: FIqjigIpRSqAA52n9vKp5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; d="scan'208";a="58898828"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Aug 2024 20:46:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 20:46:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 20:46:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 20:46:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 20:46:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1ehvq73Q9HK3laVsxOpi9bGAs0uGYuoGrWpe3xbYW9+9r272dIM+TSXtKbs9rjj2Pc8zdhdQOUuD8xWVkMa6tVA/EOrd6MsTYEAXxp6G9kFOW8340P4vB1hUGgjQncW2jVthmRfK0EGxBYPSDztKqqIq995WQnuN6H6VuEM10X9EFL1/ZvR0QAE5w76zTiWdJmxfaAd9o8JraVb1RtJkOcgU27uCSvfzHzAeHR0nccX0rEHz2l22K/HHbS+i0W4ux129MB6AfAud5c3icop5C3ZIQ/Kr2pWkXgI8DqMOfeAQ7NcTnrG5v77rixUwdkF6elkU56yNS9qb5kHiBC6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aLsWPRmKrjsVu5UzvGG7Vv/3ufloJbHP6kKAJnjalc=;
 b=bDh/ZfqgWGjW5pH1ieBn9oeYzwHf6H5hUt1vPh+zkPy4kyFouJQaT6ixBTtAv5MNdMkZm8epwC5zRiaWASOU2QZMjyBzdD4n4D9hSPIBk+ULnkJ/+9yXXU/fjihLrJX0aDqw5k45hxRT5057XAbSPCgVVKazxcdZuJ24T2ZwXSHdnQeQAHWLpzKDa5ipByCvwj30K5LI0xE+50QkC6wmWVnh07taziOvY/0u05Y9jN0+erY6Co5dWYVMwR7wekN7RymwYpPV3IXODjwcNvMrNW4XM0BNRsUPilsol9yWzVLevnbnFyNrI9Gc0F76ImbQWtfpRlERS7D9TXtmQW4yLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6142.namprd11.prod.outlook.com (2603:10b6:8:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Thu, 15 Aug
 2024 03:46:38 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Thu, 15 Aug 2024
 03:46:37 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
Thread-Topic: [PATCH v2 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
Thread-Index: AQHa5wEcbJ7zQ5MdU06ZtXNCg9xsy7Imu2OAgAEA3vA=
Date: Thu, 15 Aug 2024 03:46:37 +0000
Message-ID: <SJ0PR11MB6744410546621C57CCF7D2E892802@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-17-zhenzhong.duan@intel.com>
 <9b2b2f76-a5ef-4378-b233-af1a44f742c7@intel.com>
In-Reply-To: <9b2b2f76-a5ef-4378-b233-af1a44f742c7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6142:EE_
x-ms-office365-filtering-correlation-id: 0942386b-43e7-45d5-99d4-08dcbcdcddc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?S0NVaXh3K2JxRm1xSXI2NjI3UWtxV2JUZThvdmF4VDNyTkVwQkV3Q242V2x0?=
 =?utf-8?B?ZzBNelhYRlMvdk9mdkRPeHFnSEZjU1J1VzI4UGVqNFY4TVVOM1pJaUMwNDd2?=
 =?utf-8?B?YUZXV05LeUN5VFdiZHh6U0hPNk9MdEJHQVpVSjlzTzJaQktiSjFiYXRnRnZq?=
 =?utf-8?B?d0NYcmtWMUhFTFQ2RmNRdDdEMWZEb1BYVG0vdkhiU2tvOG1Wcnl0SzJPbW9r?=
 =?utf-8?B?T3NPTVhDcVVtai9ObWN2dTd5cUhUdDlzNzRDVjBSakNuVStUaEc5ZkpzSmdO?=
 =?utf-8?B?ZitkZlRJNzEzVHljWWljL1IyVjJVdWFkS2JDWkZJZm50K3crZmRLcjlFK0p5?=
 =?utf-8?B?Vmg2dHBkb3o0WHFVNU1EMWJEcXFLMURMSnJSVWJrY2hwTEpRYjV6em1XTHZV?=
 =?utf-8?B?VWlsNE9nNHJFWTQzaEw1NG0xVUxLb3pVamJncnJWOWVNWTh2alN5YUlCWFdr?=
 =?utf-8?B?Unpodzg2amlaWXBGRzlkbzRkU0NFOHJqWWxzdTBYOEs2anh1QzV0NTcxQ1Ru?=
 =?utf-8?B?eVlDMTF4Z09QMk5hRW5uV0xIR0RQdHE3SmIzay9RSG1hUFBtNTJCN1dZSlFu?=
 =?utf-8?B?d1FMek4vSzZpL25sSVBVa1E5MWorcXV5VU9UZjFKcjVjbXJCSm9XMWN5Y0tH?=
 =?utf-8?B?RDRITWY5SGwxdnB4Zk14SXRnK2l6WGNGaGZ3K214R2t0ZkpWMThnVHk1QlF3?=
 =?utf-8?B?NVBESzJQM3hhZVpPR0R3M2lLYVZlZ2FXU2wvNk52LzZ5VFpKMTFJVE0rRzA1?=
 =?utf-8?B?cDJyTjduV0FtOUt3Yi94a0tzTFFoanRnSW4rOVJJVnFoQ3JERW1GKzJXSmxz?=
 =?utf-8?B?UTBzQ2lXczB0SUU5RG9XUXdYbWZjSURIKzVKZTdqVE5uZFNPUFh2VUF4QTBk?=
 =?utf-8?B?VHFtMEhPMU5NOUw4cHh1aFZKZEpmVER6UXI0ckl4Uy9Ua1ovU3JIbG9pa2FP?=
 =?utf-8?B?UkZGWFBZOHEvVVM3dWhGL292VFdleHRLUWF6aC9tRUhhblBhVGwzU3FVZzBk?=
 =?utf-8?B?T0pNM3ErOFYyRTYzN0ZaSUlUSmordVZQRmJCT2dBb01tK2d2RHpHVmg4c1Fo?=
 =?utf-8?B?TGRVMGRNdXFrMjJmSVBoT0hXY2RGUGRhUEpDdHY1SHNyeHFDcHFEdjZla1E2?=
 =?utf-8?B?cXFMNUpuUnVYenlvSUIvT0tHNHJpRU0vb29NdkFWK3hXNGpBWWFkQUpBeTNR?=
 =?utf-8?B?WlRvRmczS0llb0pXVXBYMllVdFplZ2J5bjNZY21xZXhDczUyZzVYc0lTTFQr?=
 =?utf-8?B?Rmt2Yy9UQytGTFpPWFVTellQbzV3SFd1di80WlZYM2VTMzNYV1VzR2xvNkUx?=
 =?utf-8?B?NGczZlZnZWhhTWpaSFNVaS80RUhSM0x1NmxoVTFVbytpN2JxZmQ1ZVlKcWgv?=
 =?utf-8?B?M052bTZzdW14MUIxU3JvUWh2OWZDc2RXUWpleitpbzdhY3BubDJ4ZnhybVpw?=
 =?utf-8?B?L3VyWmREcG03c092UnRyTkNubG9zNFZmYzBSZ1I4QmpXOEdLeFdzRlJLcS81?=
 =?utf-8?B?Ri85eVZUWWJZZ0Mzd0tDd1N5b1BzZ2xVRzJkbTNjTmlaeXpXOE1xN0ZZQnBv?=
 =?utf-8?B?aWYrOFNmbEdvNWxjK2FGN28vNkYxbElCWHRvMUx2NWx1YTJsblBqQXVIYk81?=
 =?utf-8?B?alBJMmFmdklMVkIzYTZUUWJ1MDExTHpQb2wxZWZncWFwS01KSWxrUlVzUU1C?=
 =?utf-8?B?M2FpYVBRWFRVVHJBWEJqdlJpQW9xbkZpVEtkNTE3YTlpWW5KZkgxcEl1NmxR?=
 =?utf-8?B?WUxLbXVReFE5RWExbUJDMk04VXBVdG1ISWNOZzNmV0UrSS9Ic2RaQS80WVgz?=
 =?utf-8?Q?X0NDnTAZ915nIfNjbxEvsyMaqEcZgR2zsmGSM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGMxKzdiK21lSTZadDZOeVFuYnFrb2xTZ0UxdXBDQysvRXd5S1JmZUZIRnJu?=
 =?utf-8?B?VXBoczNrL0xzSzdpb0s1dzZFaVhJaHRTQk5RWEhyQXZJT1FiSjhRemlaZnhi?=
 =?utf-8?B?MWUxZUxWdXVoVDVXSTlOandhSm53Mm41SFBtWUk0czhZZHNoa0ZQSWpGVUM3?=
 =?utf-8?B?RkFaUEUycWdwOUkvYlVvMWJCWkNxMEFRWURuRVFndlI0ZmxFdkc1R2U4STdq?=
 =?utf-8?B?eUN6OHBnbElRcDBxNHBTa0dZQUdMcVZoM1pBMDhJOVJ6cEU3aXpBNzlaMjZy?=
 =?utf-8?B?UzN5a3MrUVdVZ005dmhJUzl6MFVhZU5pOGY1L2lEODUzQXZhbzlUVEVJV3FI?=
 =?utf-8?B?bWU4YjZTRUVFRStRbTlIR3d4WngxS1l0K2Y2Vzl4SXo4VEVRSFp1YmtTRUZ4?=
 =?utf-8?B?WTVOMzZrZnZnVTkrSmc1K1luczFZbVRKcW5hdDhUUVdNeTE5WWkwVURrdVpv?=
 =?utf-8?B?V05CclRyanNwSnFKU01qd1lTRGhxaGFnVFk0dHNZUTBxTDJrY1pyTnZPdjVj?=
 =?utf-8?B?ZUpYT0VFeHRoY0JvNStOY2taM010SVVhVFZBbmU5VXVkbG1LdHgxR3RUejNv?=
 =?utf-8?B?NXBkL0VFM0poMnVxSy85c2JDVmRkSTdld29oV2xPSHpFQmdxM3RETWtsclNQ?=
 =?utf-8?B?eWVnK0xNa1dFMlpwaFhBWUY1a2FpZ3RsdUl2bGlOTU9FbTIxWlovVEd1V09D?=
 =?utf-8?B?Zi80ckVBdnJldGtxUkc3QWFjWmo5eTgzYklnKzgwM0ZacUlKWjZVZnJnYlNx?=
 =?utf-8?B?K3M5L1lMWU0wLzJ1UVlzRjlYNFNoa2ZheUJQWUdMTDBnOTNOaStiVDdnNC9j?=
 =?utf-8?B?MnA2OVZEOVJXYTRMYnFXSGdVQm5FVGZ6V2tOMDNjUjAvYysxYjNjVGdkbm9t?=
 =?utf-8?B?eHpXcDFIQWd0ak02K3RaYTZERkRMOTQ5Rnh5RGh3QkhhLzFwK05KTjZ2cG1o?=
 =?utf-8?B?ZkgrNGJiZ3VtNlhzTy9WUXovUzROU0hwQnRodnAvR2dvdXhkQmNoRjVYYTZp?=
 =?utf-8?B?RlBtajlBQmhNUmVvQmxYOVBIa2ZtS2xoZE9TWGRrcnc3Tm5XYW9XWDVJbmZz?=
 =?utf-8?B?UmhZaFR6YU53NFZwT0ZaQ1JtemlsSExEQWJrQjJvWHhrMDdidXN2TVZBc0ZD?=
 =?utf-8?B?eVZJQnAwcStXRFZTTUZGUjhSUEgxTUNwK2pPR1Iyd294VWVEbzFoRzBkWXdx?=
 =?utf-8?B?eDRBRCt5VVEwUVN5Y2o3ZG5zMk1UZ1N4Yi91WVhZTzdvM1hqQkFzOXpxcWIw?=
 =?utf-8?B?UEJmNFNNZVJ6dzdmcXd3MFBmWktmREFNNmk2N2MvWVlFLzNoeWRVenFtK0R3?=
 =?utf-8?B?SDRXTUpjZXg0YUVRZmxTZWRhMStvanhFaVJnR3pZOXpONTBraWh2NDFmYjBC?=
 =?utf-8?B?UTVXZm1teUZOVGVUVStYYmhhd000MW44RVptQ2xPcEQ3bUJiNmFFN3h4cXJt?=
 =?utf-8?B?a1FKeWlhOGY2SVNNK3kvSmxuZkxBMi91S2hSZ1NpeTZLOVJicXdaT2N1b1My?=
 =?utf-8?B?S1VJbVdmR3lZMnVWanFqMklhY2lTVnp4ZU9CbGhuUUhmK2RIV3BUcVdMcW9Y?=
 =?utf-8?B?dG90RGxBMit1TzVEMTBOSUR3VURhOGo1cWl3VDVvdHU1Rmx5d1ZDL2dQK0dU?=
 =?utf-8?B?MGtjVU9TbzB5OXRtTm5xUnJvRWxLdHZMOEVQUzkrK240REFwNkNKaWxjNjFt?=
 =?utf-8?B?Ris2SzZiYkJXNFBoV3k1SXB1eW1uSHNNeDRaV0NEK3dQMnM1MEl2TXJpUjNP?=
 =?utf-8?B?MTRmWUxocmcrUndsUDA5dDgwNHlNREFGQi9kWHprMFZxcUJyWVNFWnp4UEo3?=
 =?utf-8?B?TW16dzdCTjE5RUozM1BwR0t3eXJwekc5UFdVZWphM1FYVklESlFHRFlHZitL?=
 =?utf-8?B?QzhZMnFublYrN2VBTkpQdzJmRmdnd1ZKSm9BZjZLVXdNTmlYd2U5T1EyNkpU?=
 =?utf-8?B?eTVCc3ZVck9CaWF4NGQzb2I2SDdDY0kzSU5GYnI4WnV5cjRlM2NvcFJFd2Jz?=
 =?utf-8?B?eFd3MVRqVHoxN2RWN3hjQ0NSaThzYVF3WlNvQ05jK28wclppWVJUWlpKRTJR?=
 =?utf-8?B?ZFpUdldsTVVwYzJMTzBESmd4WVFyaEhVT0ZvVHpmM2p2WHArZ3lJeDZEbWwy?=
 =?utf-8?Q?3fQ8/KiNT4gSjRpRa5C4UhYeY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0942386b-43e7-45d5-99d4-08dcbcdcddc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 03:46:37.8867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cpAqzhvBvBYleRXvcfmaxUGmc+rA/CD7SABavM/Ft9WFobq+9idlZzmQfK0V1bzEa3HtAFa0PLlJDjUlrgzRdNcgNudm9zGoy6ekhrkFWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6142
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTYvMTddIGludGVsX2lvbW11
OiBJbnRyb2R1Y2UgYSBwcm9wZXJ0eSB0byBjb250cm9sDQo+RlMxR1AgY2FwIGJpdCBzZXR0aW5n
DQo+DQo+T24gMjAyNC84LzUgMTQ6MjcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2hlbiBo
b3N0IElPTU1VIGRvZXNuJ3Qgc3VwcG9ydCBGUzFHUCBidXQgdklPTU1VIGRvZXMsIGhvc3QNCj5J
T01NVQ0KPj4gY2FuJ3QgdHJhbnNsYXRlIHN0YWdlLTEgcGFnZSB0YWJsZSBmcm9tIGd1ZXN0IGNv
cnJlY3RseS4NCj4NCj50aGlzIHNlcmllcyBpcyBmb3IgZW11bGF0ZWQgZGV2aWNlcywgc28gdGhl
IGFib3ZlIHN0YXRlbWVudCBkb2VzIG5vdA0KPmJlbG9uZyB0byB0aGlzIHNlcmllcy4gSXMgdGhl
cmUgYW55IG90aGVyIHJlYXNvbiB0byBoYXZlIHRoaXMgb3B0aW9uPw0KDQpHb29kIGNhdGNoLCB3
aWxsIHJlbW92ZSB0aGlzIGNvbW1lbnQuDQpJbiBmYWN0LCB0aGlzIHBhdGNoIGlzIG1haW5seSBm
b3IgcGFzc3Rocm91Z2ggZGV2aWNlIHdoZXJlIGhvc3QgSU9NTVUgZG9lc24ndCBzdXBwb3J0IGZz
MWdwLg0KDQo+DQo+PiBBZGQgYSBwcm9wZXJ0eSB4LWNhcC1mczFncCBmb3IgdXNlciB0byB0dXJu
IEZTMUdQIG9mZiBzbyB0aGF0DQo+PiBuZXN0ZWQgcGFnZSB0YWJsZSBvbiBob3N0IHNpZGUgd29y
a3MuDQo+DQo+SSBndWVzcyB5b3Ugd291bGQgbmVlZCB0byBzeW5jIHRoZSBGUzFHUCBjYXAgd2l0
aCBob3N0IGJlZm9yZSByZXBvcnRpbmcgaXQNCj5pbiB2SU9NTVUgd2hlbiBjb21lcyB0byBzdXBw
b3J0IHBhc3N0aHJvdWdoIGRldmljZXMuDQoNClllcywgd2UgYWxyZWFkeSBoYXZlIHRoaXMgY2hl
Y2ssIHNlZSBodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvY29tbWl0L2I3YWM3Y2Uz
YTJlMjFlYjFiMzE3Mjc0M2VlNmY3M2U4MGZlNjdiM2ENCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

