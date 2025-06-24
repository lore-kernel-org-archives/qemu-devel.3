Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280F6C7EE31
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU1Kj-0006Ew-MP; Tue, 24 Jun 2025 06:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uU1Kh-0006Eh-Do
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:56:55 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uU1Kd-0003sT-FC
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750762611; x=1782298611;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=We5ZDBg1Dg9/y5NNSGv/pBtNPXB3UYc8csfibADv7lk=;
 b=ShAGS+qDc3NEch05BCHZtlK++zWj9tbKOJFG+p9DTawNlwhayYcOdbHs
 +NtdgUm8jse7veoh4Q5b0Y1EKXq2tHzyQexP0fewDgIPGbYuPtv4dwazr
 VG9c0wh/YmdoKJDwtYNqKRplPnkRPdNw86G8CtyJStQkjtDEUZBNyERoB
 rxMHmPGxaMj8guuFzEiMcfzeOh3jC4GsTGd2TH2rYvGhALfugUcqCTbnr
 UEoOJasrBnTrNqNmumuK4VLF+skwwk9oKFrTiNTNdUwRIyeQNVn2esD2S
 ulb4eQhuw8IESu0lT+6QH/i5LDAn0PxbAK26y6CeeKeM/MzlGHVPJLKFe w==;
X-CSE-ConnectionGUID: 2VIf8yNgQsaQcT5eUITsog==
X-CSE-MsgGUID: f8rks3mhTdWuLsKb/4G0dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52932417"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="52932417"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 03:56:47 -0700
X-CSE-ConnectionGUID: Q3L44Aj/QU6QnvY3zfSj/A==
X-CSE-MsgGUID: S84V4BFGRSSIVpt3Dg6g9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="189072698"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 03:56:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 03:56:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 03:56:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 03:56:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHj84/DqfU0PKM0rmEZaqIjchhbvdtfS1GS+V334tNjRzQVzfzyOzK0hmP38WAyLQu0sr/ZZA3K5/XIJ8UwO1i+vIZ6TYEq4aUf/qf3MKD3xyRFQ02dFrkiLSt4478K5blHwSd6yBIE83Wq2OEVS0PLE2DAIxx9B/KHCS9R0KR1IZgAHOrwMr7a4vzfHQMAFpWEGpEn6ed/o0rpd1HxC+ZbTxFf7SZJQZ37zI3Th8zSVNUMWbOeEVRv1bPTUNVEmJELJBKa/hvTSSD7lGpTv3HR+OqCDvl5HWDRmUyc51GcwT6l7ixzFupP7Rc50wbqzO1xNcVAPxk5CY5aEnsmWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7NUMOT0PlhBP+YdgzmRL4nDTU2zQoqmMc868RFP76E=;
 b=yN9bG7oJkoqS5DiM2UWb0EMwyZy7WnFkYf0aY5hexzOIsTc3EVaNFJ3e4ub7136/mA9qcEf20eEcTwMEIacJnzw9kO7kc1MEALqjRU+M4FwQaupIZkEMPYNALOANehyNLsl0EQa72UQuEOiZRRCP5FvrQ9JIRizu9M0DFPaoU7NtljmLoLthNnkfPRdpcNU7Ht0TdXKJTICzvaokScOgCfZleP5ARKxuKBCRZ+MnzYCOatzQptNz+pSdUh2Ln/y7WrdCkQOjSNyYw9I8xK1SUw6IDd3V+OSqNfFmaPaNdtlGBerXKR/P7qRIZD1YA+c11oWk9JqiUP8RcueG+kRBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:56:42 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Tue, 24 Jun 2025
 10:56:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 11/19] intel_iommu: Handle PASID entry adding
Thread-Topic: [PATCH v2 11/19] intel_iommu: Handle PASID entry adding
Thread-Index: AQHb4bQzg67KvxNv7EO4wUdXpMDIDLQQpeiAgAEORNA=
Date: Tue, 24 Jun 2025 10:56:42 +0000
Message-ID: <IA3PR11MB9136E8C3F327B44D2E1820B09278A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-12-zhenzhong.duan@intel.com>
 <aef0acb5-cfda-4976-acd4-66fc544cddef@redhat.com>
In-Reply-To: <aef0acb5-cfda-4976-acd4-66fc544cddef@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS7PR11MB7805:EE_
x-ms-office365-filtering-correlation-id: 1ccf79ca-124f-4149-1de6-08ddb30dcd9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?etfkcm1vOWnMm/IzWARXkS7yzB336L6+tQBclFjVDc+oFVy5pzZUCkQemJ0K?=
 =?us-ascii?Q?2gQKCfzj/WmmhslCVKHbWO/40eUMU5JbE6XofES1DHcF95s/iQt7/RjErcvQ?=
 =?us-ascii?Q?0oCaY7yMV9K3x/UOClAe0raWIBEHXbaNXCmObVKD3wHrZTTNMQH/uQvPHmz3?=
 =?us-ascii?Q?VR8tb204CaMlozp1SyLkOZMu1aW1SkXm3/TrSPEpjMDIwbHvnzWL2I2v4tiS?=
 =?us-ascii?Q?JgVX2R4a4jowhQXsmoB7PTOIIoixDhwYClYgDVf5cQNDgPHhff2G0ov7aDOH?=
 =?us-ascii?Q?jA1clvvNTG06LuL3WiucxTkXaijxzwQYYgO/UR8SrdRC5Uy83CGxtQea/M4M?=
 =?us-ascii?Q?HXCr4QJfw9MRL3yUDmasZI4dZdFYRp0YtlqbdbeNMBQCIIKqVFEQWGtbOghq?=
 =?us-ascii?Q?yLMA+dXWwXmUNeQGAFyt2QyE98ThXBiQo8kHY7yVia+4cKv9FYeskhfFpAX0?=
 =?us-ascii?Q?uKPqdO86FABTy4ZKg4bISNkwdOPYWF7K47c0xxHTjSMum0nDD0sqYphKUqf/?=
 =?us-ascii?Q?F4hiVyFv3sejK8V7PAx6n2y3wiR5LfNpxxjxzIuRlfQlcRvKj7VZhxtZub+7?=
 =?us-ascii?Q?YifPU1a0oNf8upqSMi9l4Tx09EZ9Zerwg3emrPP1A8d6/8tmn8IL1UlA+6ii?=
 =?us-ascii?Q?oJwQko4Y1GkLRehDs2EZFS6PQQUwv8f86L+Ba50OAEgJJ+pD8u6kaFWU9IHY?=
 =?us-ascii?Q?hj++9npC+fm1zrzGVm1bOIJXdw3rGRs7bi1gwTYAVPGJK1xo7qfDfKKY4fmV?=
 =?us-ascii?Q?G0q7wxRaFrM8bWWSPBzKGGUahVxN8CrVrIMo4SmuFMDX/agebmVqheYy13BM?=
 =?us-ascii?Q?jj/lJ6ZADgboEir4T76eUIrwtBZbfRhrs5pJrZCyf3dO7+5p9rYtTBb1AC1Q?=
 =?us-ascii?Q?i8ELfthPRSadtMaNGkTX7kHq7nyxkHyLfFOdgUK8NJZnsN8z+pGouK0ofO6b?=
 =?us-ascii?Q?iKcfeOyQD1kIcoktqnkJJFKE1az1p5CoWP6mk7dGyFmfHMbAalAowvQmNlGm?=
 =?us-ascii?Q?HlO30pNOEotWF+RVoh4sYyW6Ts3M4qqTOkydrKqqLmGkrxg7lypnZtrfnltM?=
 =?us-ascii?Q?hVk5io9Omoc9y7+9C98mikJQG+6RmOHood2uwbn7FpmctQEjLR1jzgTIW2mU?=
 =?us-ascii?Q?/JJ0FEUhRHW5Rl6hjb8MiXFBBkvlrAlMzjIdcplRYN2PxExhWHC6XFqa9VPl?=
 =?us-ascii?Q?B+COP3mk/eJFWoRvlI/JGNFDDoQdsFpqGQKLqCZEY+sz8r6iUydUUAH3Jlev?=
 =?us-ascii?Q?2KwUMoaN2vI745zl6J74i4zhIqBzQzhE7c2pz7HroQyABcE4UiOpMtL004Jv?=
 =?us-ascii?Q?P+qUibGPZ3k5iSMPd1waMOzY7SFfn96FPIWsGIL9NlkmTjC33nlh58vsTQX9?=
 =?us-ascii?Q?vP+TxwQHXUBVa4XNHO1O7aj/stukZJm666pjiAprYNPjhbymKOlVVSkBDXoU?=
 =?us-ascii?Q?tw2bsDRQ99H0PQgTjr0DdNEw101ShEEGhAGtTsZJ2m5KUK8jqdeNqA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9DpQTs/WCV4TonNO7OC52lzXcsmuU+z/rdn+Xz/H0c6UCKsuxKIjEOvOFNWf?=
 =?us-ascii?Q?jkYOER/Wj7Im9K5a5M4bql9k4wAgl6ordpQSX/caCEupl0MSQTU1zIp7FZUI?=
 =?us-ascii?Q?G7X/3JOnAxRv8nu/H4ACT5pWGM3gcwiR3VyGHc3O151UiCjhs1QcQfn0Y4u2?=
 =?us-ascii?Q?JZuDN7fpyr3k4Y+3NJM6ToDSGbUnRI46eWq2nUU67SAYpO5VOrgdmNBMUe1C?=
 =?us-ascii?Q?D2cYdDGm7+QPnPKf9dL+DprVRtasKlY8987CLmDl1NkpOitxgOX0KHAktRcf?=
 =?us-ascii?Q?PnuZJ1G9ZuPHoilQgzPTBzTNx730AD6ZZNsTRIUhFgYB7XcXI+AKjsjrUoQO?=
 =?us-ascii?Q?Io8L5CUfv00+Y6De7yKAUCVbeEJd9L06fOsRJxa9YO+XKOjEnRqe15n8MbiW?=
 =?us-ascii?Q?mz0urcbDm2wJIb/vQRpiWWYIiv2keqLn56Xdt4a5j2QrLpaqWOStzWtl7Sae?=
 =?us-ascii?Q?IEu411F3pC+yNRoOJWP0rDy5RlYhRX/xu/fCi6xHhxuXYOwtsrGgjw7YKNs9?=
 =?us-ascii?Q?YHfjYI4MSsdOhQc57FUoRScOhcZNlUWCfOumN+wXRMy9CSX15MQv9HoOjD34?=
 =?us-ascii?Q?xx1T2hM4h9ZIXlwI60bhm6CAzI76Itt0JuC5TORuo8d21q8FRaLsiYVV+wGk?=
 =?us-ascii?Q?X5Avzb0FM3HdHnTD7fv78drmS8FvsfQAYTGoPTIdlrJqY2ix0Udj1drJH9G5?=
 =?us-ascii?Q?HoddOZn6EZDemmDvMLqcSiWyIfOIUwFHhEkbN8etM7Le4hQZ+C2ufVU5HqAK?=
 =?us-ascii?Q?16MWyEsl9WTb2S+oF7aWfn1F1gTTymgngN3lvi/FC0V4JbDkf1Gb5hWoo0PO?=
 =?us-ascii?Q?8uZswV9KtBaa3QRaFjc132w33oLj/fhFok1IUPJOgjmUxU18At7GeWCLA+dw?=
 =?us-ascii?Q?tx4Oj8q1p+/Ou0hv9wv5LP9ZRmDkcMM1VmVYNkj0zA0hhqVYxKxHEwEvHaEt?=
 =?us-ascii?Q?qN0FlHEu+l54+ot0F3sUICGR8ZU0xAK3q+F4MQL0Ze3AMVT7dmEk5PVmvk66?=
 =?us-ascii?Q?RNP1f/WolSAe+PmexlYWqHbq31kx/ATOv5utn9rKj4hazRW0qdg2sYHkNxI/?=
 =?us-ascii?Q?dQY2AKYU41jC5+l49125iE1vJTgt4UUsnRa+wuAzsRQyDiHu2uSLtnp1ePVJ?=
 =?us-ascii?Q?Ca7EYN91LBusFLHk+8Y7lT+Y9j4GB9IVSUQ7t4HW99wNrJhoFzYaktHtu0L2?=
 =?us-ascii?Q?eoNaKpoMdj5ZK35fTKimsXCx1oYpXx/HraaYU9cRtTvfcXdQUZ/26+gaga8F?=
 =?us-ascii?Q?5QJ4AAaTZURw9gFqyJYljO8q3Vhr5G+N5J4v8tTw0AIkM4VcZnQQK9+A3SIS?=
 =?us-ascii?Q?hhYl6i9rWRP2CbryAFGoAoWH0lyso4orUv6usRGaLte3IXh1bq4c5F7+wB7K?=
 =?us-ascii?Q?OIB1HCkacen/HV+fpRTOnOhO4P76O6uUKfkge5VNfPbjRZmzS4vvUcBIf7NH?=
 =?us-ascii?Q?CM45izk5xMTniu/NYEK2fEGszC0sQjEdNISd5IP7LtztDbJKv9VEJT5XpEYd?=
 =?us-ascii?Q?cNl/zehKnkDGUrR7tB7Vkrq6zHmQjBJP4QvIaknnOOyolfl9Bry4+8wfaqZv?=
 =?us-ascii?Q?wy8cSBG4jMfImJhreh3a+TS8nTbTEOBM9Gv/1FRg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccf79ca-124f-4149-1de6-08ddb30dcd9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:56:42.1905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twCsGsB3GcpTeeH/QtGuCOvQZ6fiGnuw+TVHodD0r40+hwXYfcUAhkdXb1w2D9wgAuiXTZsQwrKRHHdNTFGsXA2HOBoXhLTDqJN5/cRxu7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
><marcel.apfelbaum@gmail.com>
>Subject: Re: [PATCH v2 11/19] intel_iommu: Handle PASID entry adding
>
>Hi Zhenzhong,
>
>On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
>> When guest modifies a PASID entry, QEMU will capture the guest pasid
>selective
>> pasid cache invalidation, allocate or remove a VTDAddressSpace instance =
per
>the
>> invalidation reasons:
>>
>>     a) a present pasid entry moved to non-present
>>     b) a present pasid entry to be a present entry
>>     c) a non-present pasid entry moved to present
>>
>> This handles c).
>
>As you use the replay terminology in the patch, please explain what it
>means in that case and how the patch achieve above goal.

Will do.

>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/i386/intel_iommu_internal.h |   1 +
>>  hw/i386/intel_iommu.c          | 169 ++++++++++++++++++++++++++++++++-
>>  2 files changed, 169 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_intern=
al.h
>> index 01c881ed4d..025787b3b9 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -558,6 +558,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>>  #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>>  #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>>
>> +#define VTD_SM_CONTEXT_ENTRY_PDTS(val)      (((val) >> 9) & 0x7)
>>  #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
>>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL |
>~VTD_HAW_MASK(aw))
>>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 1db581d14a..f4273dc640 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -826,6 +826,11 @@ static inline bool
>vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>>      }
>>  }
>>
>> +static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
>> +{
>> +    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce->val[0]) + 7);
>> +}
>> +
>>  static inline uint16_t vtd_pe_get_did(VTDPASIDEntry *pe)
>>  {
>>      return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
>> @@ -3246,6 +3251,159 @@ remove:
>>      return true;
>>  }
>>
>> +static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
>> +                                        dma_addr_t pt_base,
>> +                                        int start,
>> +                                        int end,
>> +                                        VTDPASIDCacheInfo *info)
>> +{
>> +    VTDPASIDEntry pe;
>> +    int pasid =3D start;
>> +    int pasid_next;
>> +
>> +    while (pasid < end) {
>> +        pasid_next =3D pasid + 1;
>> +
>> +        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
>> +            && vtd_pe_present(&pe)) {
>> +            int bus_n =3D pci_bus_num(info->bus), devfn =3D info->devfn=
;
>> +            uint16_t sid =3D PCI_BUILD_BDF(bus_n, devfn);
>> +            VTDAddressSpace *vtd_as;
>> +
>> +            vtd_iommu_lock(s);
>> +            /*
>> +             * When indexed by rid2pasid, vtd_as should have been creat=
ed,
>> +             * e.g., by PCI subsystem. For other iommu pasid, we need t=
o
>> +             * create vtd_as dynamically. The other iommu pasid is same=
 as
>> +             * PCI's pasid, so it's used as input of vtd_find_add_as().
>> +             */
>> +            vtd_as =3D vtd_as_from_iommu_pasid_locked(s, sid, pasid);
>> +            vtd_iommu_unlock(s);
>> +            if (!vtd_as) {
>> +                vtd_as =3D vtd_find_add_as(s, info->bus, devfn, pasid);
>> +            }
>> +
>> +            if ((info->type =3D=3D VTD_PASID_CACHE_DOMSI ||
>> +                 info->type =3D=3D VTD_PASID_CACHE_PASIDSI) &&
>> +                !(info->domain_id =3D=3D vtd_pe_get_did(&pe))) {
>> +                /*
>> +                 * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
>> +                 * requires domain ID check. If domain Id check fail,
>> +                 * go to next pasid.
>> +                 */
>> +                pasid =3D pasid_next;
>> +                continue;
>> +            }
>> +            if (vtd_fill_pe_in_cache(s, vtd_as, &pe)) {
>> +                pasid_cache_info_set_error(info);
>> +            }
>> +        }
>> +        pasid =3D pasid_next;
>> +    }
>> +}
>> +
>> +/*
>> + * Currently, VT-d scalable mode pasid table is a two level table,
>do you mean PASID dir + PASID table? in the positive I would use that
>terminology directly.

Yes, OK.

>> + * this function aims to loop a range of PASIDs in a given pasid
>aims at looping over a range of PASIDs in a given table?
>so what do you call a table here? is a a PASID directory ot a PASID table.

Yes, this is confusing, will be:

 * In VT-d scalable mode translation, PASID dir + PASID table is used.
 * This function aims at looping over a range of PASIDs in a given two
 * level table to identify the pasid config in guest.

>> + * table to identify the pasid config in guest.
>> + */
>> +static void vtd_sm_pasid_table_walk(IntelIOMMUState *s,
>> +                                    dma_addr_t pdt_base,
>> +                                    int start,
>> +                                    int end,
>> +                                    VTDPASIDCacheInfo *info)
>> +{
>> +    VTDPASIDDirEntry pdire;
>> +    int pasid =3D start;
>> +    int pasid_next;
>> +    dma_addr_t pt_base;
>> +
>> +    while (pasid < end) {
>> +        pasid_next =3D ((end - pasid) > VTD_PASID_TBL_ENTRY_NUM) ?
>> +                      (pasid + VTD_PASID_TBL_ENTRY_NUM) : end;
>> +        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
>> +            && vtd_pdire_present(&pdire)) {
>> +            pt_base =3D pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
>> +            vtd_sm_pasid_table_walk_one(s, pt_base, pasid, pasid_next, =
info);
>> +        }
>> +        pasid =3D pasid_next;
>> +    }
>> +}
>> +
>> +static void vtd_replay_pasid_bind_for_dev(IntelIOMMUState *s,
>> +                                          int start, int end,
>> +                                          VTDPASIDCacheInfo *info)
>> +{
>> +    VTDContextEntry ce;
>> +
>> +    if (!vtd_dev_to_context_entry(s, pci_bus_num(info->bus), info->devf=
n,
>> +                                  &ce)) {
>> +        uint32_t max_pasid;
>> +
>> +        max_pasid =3D vtd_sm_ce_get_pdt_entry_num(&ce) *
>VTD_PASID_TBL_ENTRY_NUM;
>> +        if (end > max_pasid) {
>> +            end =3D max_pasid;
>> +        }
>> +        vtd_sm_pasid_table_walk(s,
>> +                                VTD_CE_GET_PASID_DIR_TABLE(&ce),
>> +                                start,
>> +                                end,
>> +                                info);
>> +    }
>> +}
>> +
>> +/*
>> + * This function replay the guest pasid bindings to hosts by
>replays, host

OK

>> + * walking the guest PASID table. This ensures host will have
>> + * latest guest pasid bindings.
>> + */
>> +static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
>> +                                            VTDPASIDCacheInfo *pc_info)
>> +{
>> +    VTDHostIOMMUDevice *vtd_hiod;
>> +    int start =3D 0, end =3D 1; /* only rid2pasid is supported */
>> +    VTDPASIDCacheInfo walk_info;
>> +    GHashTableIter as_it;
>> +
>> +    switch (pc_info->type) {
>> +    case VTD_PASID_CACHE_PASIDSI:
>> +        start =3D pc_info->pasid;
>> +        end =3D pc_info->pasid + 1;
>> +        /*
>> +         * PASID selective invalidation is within domain,
>> +         * thus fall through.
>this is still not totally clean to me. For domsi I would have expected a
>different setting of start and end?

For DOMSI, it's initialized above, "start =3D 0, end =3D 1".
We only support rid2pasid in this series, so end=3D1.

>> +         */
>> +    case VTD_PASID_CACHE_DOMSI:
>fall though clause here and above?

Sure

>> +    case VTD_PASID_CACHE_GLOBAL_INV:
>> +        /* loop all assigned devices */
>> +        break;
>> +    default:
>> +        error_report("invalid pc_info->type for replay");
>> +        abort();
>> +    }
>> +
>> +    /*
>> +     * In this replay, only needs to care about the devices which
>one only needs to care

OK

>> +     * are backed by host IOMMU. For such devices, their vtd_hiod
>Those devices have a corresponding vtd_hiod in s->vtd_host_iommu_dev

OK

>> +     * instances are in the s->vtd_host_iommu_dev. For devices which
>> +     * are not backed by host IOMMU, it is not necessary to replay
>> +     * the bindings since their cache could be re-created in the future
>> +     * DMA address translation. Access to vtd_host_iommu_dev is already
>> +     * protected by BQL, so no iommu lock needed here.
>> +     */
>> +    walk_info =3D *pc_info;
>> +    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
>> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
>> +        /* bus|devfn fields are not identical with pc_info */
>Can you clarify?

I mean bus|devfn in pc_info is not used here, I'll drop this line as it's u=
nrelated and confusing.

>> +        walk_info.bus =3D vtd_hiod->bus;
>> +        walk_info.devfn =3D vtd_hiod->devfn;
>> +        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
>> +    }
>> +    if (walk_info.error_happened) {
>> +        pasid_cache_info_set_error(pc_info);
>> +    }
>> +}
>> +
>>  /*
>>   * This function syncs the pasid bindings between guest and host.
>>   * It includes updating the pasid cache in vIOMMU and updating the
>> @@ -3301,7 +3459,16 @@ static void vtd_pasid_cache_sync(IntelIOMMUState
>*s,
>>                                  pc_info);
>>      vtd_iommu_unlock(s);
>>
>> -    /* TODO: Step 2: loop all the existing vtd_hiod instances for pasid=
 bind. */
>> +    /*
>> +     * Step 2: loop all the existing vtd_hiod instances for pasid bind.
>> +     * Ideally, needs to loop all devices to find if there is any new
>> +     * PASID binding regards to the PASID cache invalidation request.
>> +     * But it is enough to loop the devices which are backed by host
>> +     * IOMMU. For devices backed by vIOMMU (a.k.a emulated devices),
>> +     * if new PASID happened on them, their vtd_as instance could
>> +     * be created during future vIOMMU DMA translation.
>the above comment is somehow redundant with the previous one

Yes, will drop this one.

Thanks
Zhenzhong


