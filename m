Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDEFC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 02:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTXDl-0001jl-8a; Sun, 22 Jun 2025 22:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTXDk-0001jZ-1T
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:47:44 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTXDi-0004pK-9j
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750646863; x=1782182863;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mZd4fehuuWwzgeDPqbYGyenl3+o0p3Q/GFjvj81yWxs=;
 b=aE/3LvQGRQ5kbn9HIeeP2FlxSHWE0qdlB5hRLb0jcaFCrU4r7oPuju5l
 rjIT37EWYKoZ8VQalHNBiSdpqA38S6c4elOcmBVm2LlLOrlFu76IAGrzk
 OGGhc084gu+YdeagRk2BJZg5BhbU53/IPlezvZDe+h1dlx4mYtUQj1voQ
 ICLpBh0i9FGNORciKKelTFL3lTGP4Zx4znC7SKLX0ofsYGsDZrLYqcwjc
 dnQ5vrVW16yr4KMdqbJWoLW50r//BzwOGzyBRcqbFndG4N6oR+BqDZkuz
 PvWVtYZr7MwCYzr293CYs6bmbC5vHQLgR86/VbGRAavK9Q+DSvvQEZp9W g==;
X-CSE-ConnectionGUID: 1aHxmBjsSHKpGjQh2fFjvw==
X-CSE-MsgGUID: NrJVQD3eRsSKNg9uMd6Mfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="75369551"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="75369551"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 19:47:40 -0700
X-CSE-ConnectionGUID: jrFisSXhSl62syhtWkdJmA==
X-CSE-MsgGUID: 9MzkBjQTRdSxoMy3n5Sxsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="155851916"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 19:47:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 19:47:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 22 Jun 2025 19:47:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.86) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 19:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9fMKCaLAoNpEsYr0d62RYql2b0d0S99rJD86XhiFuhTPfsnB3HJJhQDdN7KX3JyOavXSFrRmbImeoonr8bKjzMCtAuD4l5+3rubolc8PKGQSdp9lYoxB0/nnFQST6K26PeSk9m68f9B0xtbTrbbL2ETn8qHJgirGBorXLiOxN7bM6fongXdyoWAeIncr2Py1Hj7wlVqUQlzHMGrb3GPkc3Oq7YFEGqUJhlMlDfLWmYyCcj6TWANzrW2xuUDyc5Tefl0bxUtKBgh8BYHZ3kUxpXGNA96RvHT24zkOyYwTbyqwROOdRKHjOqx+erGge3pUGDiMz86zXdSoaLcpRk/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZd4fehuuWwzgeDPqbYGyenl3+o0p3Q/GFjvj81yWxs=;
 b=Ak6TSEnM7eKYlicMlmtwxK5GqyMu6QoT9b7OuUDHOxPJSKZt8EPS6xQFTi0LAoieC40OIi7s5WYQ0P6NBIyWu/5ndkXWmTQNZ9WPrgZ8j8IsKJ7CKTguy7ZLiFSfBu/1MeufiuwV9ej+xZKSKUo7bc8S2J0LBavWfuIu3VYwkCjfw3nGc0gT7eKammjatHDMMPcRNzmupmMAOabPXL0s0jqnz00fO9D/VctookS0ZLXqmahXHs/Ywloq0D8wGhRba9Ee+3McCe3b8zyoqR0XF3/fW7qraT6qUvQT4TdtAyznZy7BjQb8NucvOeXOwrEtoGO9XsXP90eSOK5bRe5BDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB7386.namprd11.prod.outlook.com (2603:10b6:208:422::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 02:47:16 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 02:47:16 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 05/19] hw/pci: Export pci_device_get_iommu_bus_devfn()
 and return bool
Thread-Topic: [PATCH v2 05/19] hw/pci: Export pci_device_get_iommu_bus_devfn()
 and return bool
Thread-Index: AQHb4bQqPdFIqyuiZ06X5SsJ8hrTgbQL8iEAgAQb3wA=
Date: Mon, 23 Jun 2025 02:47:16 +0000
Message-ID: <IA3PR11MB9136E06A48EC0FAF421522959279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-6-zhenzhong.duan@intel.com>
 <6d472e7f-864f-4456-a036-1b5f61516aaa@redhat.com>
In-Reply-To: <6d472e7f-864f-4456-a036-1b5f61516aaa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB7386:EE_
x-ms-office365-filtering-correlation-id: 8b737c34-9858-4f67-5b71-08ddb2004417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?enowRmNkRjBxbDU4Uk5jbnFqcXBQcGVqRUtodEF0ZkZIY05lOFEyNTRUWGUx?=
 =?utf-8?B?ZTIwZEpOZEJRS1JQWjRrc1JVdWRKVHA2dUl1aTc4TTFSallvbXpmYkxZV1FB?=
 =?utf-8?B?STMvUzdtQ250TVNFbEUrZFlGZEJHb1RhSEVUK2NaMW9zdmk3amtVdzEveitM?=
 =?utf-8?B?cTJISkFZN1ZhbjhmN0dTZDZDYitST3Exb2tHS1VxOHBieFVaRlhqV1RIeklS?=
 =?utf-8?B?cGlvMHBaWnkyNnlCS2lXQTM1S3YyL0dsaVFYajlGZnpTaTBGU0RpOEswVG5O?=
 =?utf-8?B?UmpNOTkzQSttNy92UFdxRktQeFdPSDMyaXhpY21rdlJySlhjUXcxY0pmNkZa?=
 =?utf-8?B?N3g1Zjg5NWNMMHpXdjBNdWMxNXNFdnN5M0tEZ0I2OEpDSlJzdUhma3pBaTUz?=
 =?utf-8?B?eDZSOVJGWGxpN09OY3BwQit0RUJFWXNlSUFBUVdGL2dobndFdTRzbXFWWTJp?=
 =?utf-8?B?YXp2anpxTWRxVktqV3R4OHY3VVdJRUpvL2N3bCtoM0l3eklZaEk2R1VvY1d0?=
 =?utf-8?B?TGhLYzJxQVUxOXlneGtLTzdmYjc4cWUxMXo3M1YrdmFOTHVCekEzM1IrY3dt?=
 =?utf-8?B?Z3FWK2ViYk8wUHo1dFhtK3U2UHdtUktCSm11T0xUbWwwcUJWQ0gxRDZzeDR4?=
 =?utf-8?B?azErUGxYeWZjaDVwOFZYYWtOOEF5R096bThDeVF1MUV6VUZZa0JLallhdGc4?=
 =?utf-8?B?SEZuTU93Rmo1SFJsUGNrZjZENk5kakxmaDBIcXM5Q245L3FKVkVMaUxmNi9E?=
 =?utf-8?B?K1hHV3V3SnVpY0hmQm9nZnp4NEU1Y3drWTRaYTF2Yi9pRTZLOXMxLzZ5MEND?=
 =?utf-8?B?QTZsQnFJYTFqNEpyQjhqM1VzZFFvZTc1VU9QSFgrRk5jZ0ZYQVhId3k2WEsr?=
 =?utf-8?B?cHJpRjJPazBVclZqZkx3UnJUODlmR3pMYWhDTnJ5Q0RranREekNBTm1NTTl3?=
 =?utf-8?B?cllialFySys3L0JzWEVZR3p2di9sR0U0ZWV5cUVEaUc2MTNTeVQ2VVhybnVF?=
 =?utf-8?B?UUxLSFRGV1NzeUp4OXFKc0tac3Qrazh5cENTNFAvWTZXSnA2UHB0Y3NSZXJE?=
 =?utf-8?B?ZTJYbk9oOUdPejV2b1FvaHJTMlVtYWN0aDFIWWorUTc2K01BZ1RwS1V2Zklt?=
 =?utf-8?B?UnZ5V0tKcVU1YThKYklCNDR6Z0ExV2drS3o1ZnQxem1oaDd1OGMrNzJ6ZnJQ?=
 =?utf-8?B?QlZBRjVjUEYyM0lhV1dmeE9ucXBuY0JCS3pUT0QzamxoY01QQUg0NWZFN0xX?=
 =?utf-8?B?NkRDR09xQmFGQTh6SW16VXpzTlhBODJ0V1l6YWV0NUpNelhLWHdEQXRXOURC?=
 =?utf-8?B?Z25lOFFTMmxWbGErZFN3MmhWMHppZmlUeDZRa25wbmlleTBRVnlJTi9NTmZX?=
 =?utf-8?B?YnBHd0xGNnlkU1h2ZEdtQ09DWDF1cHpSUUVoQ08zN0pEUWhyckRkOU1wUDB3?=
 =?utf-8?B?emFldVdHVUhGYnNOOEVpOUEzejFmb3BTUE5RRHQvd21QeFVhUEU2dkRRaFdD?=
 =?utf-8?B?YnQxWHYyVytwZlZuc01leVFwRCthWFljYlpBejRMc2NrOHpIMGt1N3l1aTYr?=
 =?utf-8?B?ZGZtNzF1VlM2dWtQRGRRUlBPNEczc3hwVDBXU1NmVGtvcUdETkd6SFowZU9S?=
 =?utf-8?B?OVpxQVpFV253NmllMjJ5RTN4RVduY2pGZyt3YklFT0VmNVJsaGhKVVRwa3ow?=
 =?utf-8?B?bWRWYXlWZ1dQb3hqMHdUdmx3QmtHUXJ4QXJSUHFqVTJpa3FPc1FkWnNtVE93?=
 =?utf-8?B?NjI2WlhYR2NJR2I1b2RwNXJVck9OR25LcmdYbFBhcE5MeGJyNEloMGtEYnlu?=
 =?utf-8?B?aFZicHFGVkZTajRwdXRBRTdRVmFvQy9FWmZqOGtXYVRVQTVVME9jSmpjd09Z?=
 =?utf-8?B?eW0rYkJPNVpzYnNPeko3cEllSy9qYzY2Mk5jWFloQytyMm1wU20vTm1rbC9I?=
 =?utf-8?B?amt0V2k2R3dFZ2QrYkc4Mm5vZ2VPWFVUWWc4eWJEVzdmeHpSY0FTbHV1TUJ4?=
 =?utf-8?Q?7ti4OFTsI6IztXXCaQXoFtpbDR067c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1poVDVvQmxlNEhXc29yWUtyenVCeVJmYWdVRXZaQ2F5YXp6K2ZtREpMbXM4?=
 =?utf-8?B?Vzl5MkxNNnpSclllT0t1M3Z0bWlWZVp0OUREbEsyelhGRE5kTXI3aXdUTlg5?=
 =?utf-8?B?NXRTNkZEd3lPbkJ0T05pamNQWXRPbC9yV05jcVFLK25rUHR6SGlOZVp1MUFm?=
 =?utf-8?B?czVrZThyWlgwc0NST2VzNW5LbGR3SGNSMkNPaDdVWlpHVS9ZdVh1cVowN1d5?=
 =?utf-8?B?TSs2c1g0bG9JK2IvZVZ4N3dtYjNQUnFLeU9kSGlucmc3RE53eWVBY1NsOHBv?=
 =?utf-8?B?dER2TzVLNnhySWpMV3FLdGVQY0RLbjJCekxlWWJtQ1pmNWlkZWI4aHcxVjk3?=
 =?utf-8?B?Q2xkbHkwRkhRTFZNZVI0NXlrRnF2ZnlKc3I3OExLaGQvZ2R4MkVLa1hhUWpW?=
 =?utf-8?B?aGIyK05rODVRTVNnc01SbkcyUk8xR2tVc1NOTlVVMkhUeXZrc2Y2MUxjYUVM?=
 =?utf-8?B?WnhFTXZyVmYxY2pOZ25DVCtTOEt2WXFNZVEwYnRiMjRub1NXMlRhMENoY3FJ?=
 =?utf-8?B?b3poY1kvaEVYOHJCZjNyL1NrSmd2Q0M4UDRnUEYvTXRPQnpJOWdMQW94WHBm?=
 =?utf-8?B?dG5qSHJTMyt0bTY3VmdQampKMGEwc2J4T2x5UGN0ZUpCZC8vQUJrRTkwRmZn?=
 =?utf-8?B?SjQwcUdOY2NUcDdWZERzcUZPdHQvR3lxZnpqQ1VNQnJmMms2MFhCRm5sTy9h?=
 =?utf-8?B?aENyaE90L01GRkVQdzNSLzZGZkZnNW5FaVcvTmVsY2hWT1hkKytjc0ZZTzRU?=
 =?utf-8?B?STI3bDdkYkJyUzcxZFNWTlFZWDNjN2pQT2U5OEF5ZGM3R1ZqVkZobE9rZTRi?=
 =?utf-8?B?RDdUQlVkQTBXZzN2M0lXbzJhN0V4R2x4VkdaMS9PWHgzSlBkaHZuc3FoMisy?=
 =?utf-8?B?aUEvSWFuYlNQS1drR3J5OFcrZ1ExbEFwY0ZpdzdDMDlIQzEvZG9tYWowU0N4?=
 =?utf-8?B?NGFtUlJmSUF1b3hQd2ZIQnJueTlMVDdIUm10VUh2VEYxZ29ZYVI5TzRtR2Ri?=
 =?utf-8?B?RGNaNXV2OE5ROWdENWIxL3dVbUFDRDFOOVdxem1jRlk1VnVJcm5Pb3BEdnpO?=
 =?utf-8?B?Ry9WQWprL1dCYnpXYzRUV1hnckIzZVk4amdLZ2R0U0ZkNEtoUWw5a05FQndZ?=
 =?utf-8?B?TGN6cUQyOFQ5SzVyV29TdHNLazVkSGEvTTUzaVVKMThvOStraTMzNzdYaDBC?=
 =?utf-8?B?SE91Y1B2Z3c3YzM4OVpYR2pSeFZoSmdqZnNIN3lSVDYrOTRWNW5zRHU3WWZJ?=
 =?utf-8?B?QkFOM0NIZDNHSm5MTjhkSkdmUnExUVdldkhiY3QyYW9DREN0ZTdKbG4rWDRy?=
 =?utf-8?B?T0hTVHBaSkQrS3JQaHRFNFdhampZS2JlRFFhbzdEckFBRGMzd0FLVE1iNW5k?=
 =?utf-8?B?SG9hMnNZeGxRZ1BJdWFrMStuQjA0UkRpTlZJVUltOVhLdVBHRnZDZ1NaRWxQ?=
 =?utf-8?B?NHNmb3VVVk9hWmtJL2d6bk0wWmRhNlZ2OGJIL0d5dXhJVTRmaU02Mi83cE5F?=
 =?utf-8?B?SU9SVU4xMnNhRVB0VU0vdUpXMGZrRTM1MHNoVzNjbkk4K2Z2Q1pLamFKVzlx?=
 =?utf-8?B?QndXK2hjd3Uzd21aMUdNdFBqZWE0TCtGb2pYQ0REZ1B3cnBPYUl4b0dOcTUy?=
 =?utf-8?B?cGJ2YjVzR3VpdTN5aXFRb0JzUk1HWHMyM015eE16US9VRXRZT2tHTlpKeE5M?=
 =?utf-8?B?WDNEcVNCY2lhbWZiaDFLbWgxamcyeWRsaFpNZ1dmcDhNWkppS0dlSTZKYWFS?=
 =?utf-8?B?cHNPWVV5aHFybW5EeEFhK3FPY01GTFdSYVFnZHJVUHU1N3lhS2U4RHU3dFhv?=
 =?utf-8?B?TEIzdEtPNTQ3U0ZuUnk5VlU0OE02WTh3UUFoRzZLRWdZZWVzVFR0aWRoNHA0?=
 =?utf-8?B?V2NUWVRFcktKT1ZRTDZXQWk0SG0zaktzQ21jZ0UzL1pHOUFnQm8xWE82NXhN?=
 =?utf-8?B?NU1hczRXOUxMLzFJTC95eUhSTDJ1Vm4zVDVCWGtRS0ZiR1pLRTliemY3bUhO?=
 =?utf-8?B?UlRFdXh0NnlYRVk1TXZadzNrbWlVcW5sRFFwQW9McnkvNUhweFVBQk9kN2w5?=
 =?utf-8?B?eGZoMEdFYUpkQkxWa3lrdzJVNUY0ZGdhdVlITUtwWFJqZGFUdkdOMmdIWks2?=
 =?utf-8?Q?oGla/SDhlqXeXVVxFkcFaIE7q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b737c34-9858-4f67-5b71-08ddb2004417
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 02:47:16.8321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dAJVOHiOkyojrepRcpRl2sRZDw20DOs/e+rqyI+XSmGT47vpDZQwhD7pHE6/raRm6RA2Z/I0Cbgt6O09uXcGx0KUReBkp8y90nsZy/i2fVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7386
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDA1LzE5XSBody9wY2k6
IEV4cG9ydCBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oKQ0KPmFuZCByZXR1cm4gYm9v
bA0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiA2LzIwLzI1IDk6MTcgQU0sIFpoZW56aG9uZyBE
dWFuIHdyb3RlOg0KPj4gUmV0dXJucyB0cnVlIGlmIFBDSSBkZXZpY2UgaXMgYWxpYXNlZCBvciBm
YWxzZSBvdGhlcndpc2UuIFRoaXMgd2lsbCBiZQ0KPj4gdXNlZCBpbiBmb2xsb3dpbmcgcGF0Y2gg
dG8gZGV0ZXJtaW5lIGlmIGEgUENJIGRldmljZSBpcyB1bmRlciBhIFBDSQ0KPj4gYnJpZGdlLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQo+PiAtLS0NCj4+ICBpbmNsdWRlL2h3L3BjaS9wY2kuaCB8ICAyICsrDQo+PiAgaHcv
cGNpL3BjaS5jICAgICAgICAgfCAxMiArKysrKysrKy0tLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCj4+IGluZGV4IDgyOTc1
N2IyYzIuLjMwMjljZGYyNmYgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2kuaA0K
Pj4gKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCj4+IEBAIC02NDAsNiArNjQwLDggQEAgdHlw
ZWRlZiBzdHJ1Y3QgUENJSU9NTVVPcHMgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBib29sIGlzX3dyaXRlKTsNCj4+ICB9IFBDSUlPTU1VT3BzOw0KPj4NCj4+ICtib29sIHBjaV9k
ZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihQQ0lEZXZpY2UgKmRldiwgUENJQnVzDQo+KipwaW9t
bXVfYnVzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBDSUJ1cyAq
KmFsaWFzZWRfYnVzLCBpbnQgKmFsaWFzZWRfZGV2Zm4pOw0KPmlmIEkgYW0gY29ycmVjdCB5b3Ug
aGF2ZSBhIHNpbmdsZSBjYWxsZXIgb2YgdGhlIGhlbHBlciB1c2luZyB0aGUNCj5yZXR1cm5lZCB2
YWx1ZSwgaW4gaW50ZWxfaW9tbXUuYywgd2hlcmVhcyBhbGwgdGhlIGV4aXN0aW5nIGNhbGxlcnMg
YXJlDQo+bm90IHVzaW5nIHRoZSByZXR1cm5lZCB2YWx1ZS4gWW91IG1heSBzaW1wbHkgcGFzcyBh
IG5vbiBOVUxMIGFsaWFzZWRfYnVzDQo+YW5kIGFsaWFzZWRfZGV2Zm4gYW5kIGNoZWNrIHdoZXRo
ZXIgdGhleSBkaWZmZXIgZnJvbSB0aGUgb3JpZ2luYWwNCj5idXMvZGV2Zm4uIEJlc2lkZXMgdGhl
IHBhdGNoIGxvb2tzIG9rIHRvIG1lLg0KDQpJIGRvIHRoaXMgd2F5IGluaXRpYWxseSwgYnV0IGl0
IGRvZXNuJ3Qgd29yayBpZiBQQ0kgZGV2aWNlIGlzIHRoZSBmaXJzdCBkZXZpY2UgdW5kZXINClBD
SUUtdG8tUENJIGJyaWRnZSwgZS5nLiwgMDE6MDAuMCwgaW4gdGhpcyBjYXNlIGFsaWFzZWQgQkRG
PT1yZWFsIEJERi4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

