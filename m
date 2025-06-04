Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB29C5B555
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMkqa-0003ZX-Dr; Wed, 04 Jun 2025 05:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMkqX-0003Z9-Ou
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:55:45 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMkqU-00023v-3R
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749030942; x=1780566942;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FxpyfenahnlOiZ0dZ2KX3WiFOZnRGvL4e57nbfafOj8=;
 b=gbpuQobApNXYo1YjF1w1j5+7eu5BxcRwNHoFs0Atu4tS5dydjC2iAGea
 XFcHvqX6L/hUft0FstV/b7bEGAQpPMxFyTYBO8M4kaA44fLtla3nFwSuf
 FV/WqfJO/jZqFQ3xx90WzHgotHFukHbK+Kqzg/l9IB3r3MSai5D6rI4B4
 pcYoYtUtk/yw/EWwOlJiJPg4AbGNs+EF4oKllRoUzeT47QSohDZVZUOMv
 gDvacyW5sQPykIRmbbABbZ2Bml6C0s3gE+arrV8HOeBppzuieAAh/Inw9
 UzM1GdsY0m0GYzvGsvDxKL3NCB6PujTrIgVcDHMI6inYt9mBfI10oHb0x g==;
X-CSE-ConnectionGUID: 37RXGw7MRFmWvlESurz61g==
X-CSE-MsgGUID: /iiN3fdCTcuGF1sDQGH0uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62157311"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="62157311"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:55:40 -0700
X-CSE-ConnectionGUID: VO4btwgiTyaSu8nhzjHvQQ==
X-CSE-MsgGUID: VA0AmUaJRBCOFFpXiv9f3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="145104403"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:55:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 02:55:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 02:55:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.78) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 02:55:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejR7e4xJ0Ym5vc0u4Q9vfPGZOqhDBLUK8ntc371rp4rHCIJEeuvmNEyyhT3ksluf04wY+u/LCzaFm3kx65v4ZJYzx9++DQzXouEkay3ND4HnmBE/4JjWyIySqNABsgYzY5teikyX01NtP1UG4flSBZRLiBp+FOW5uj1BWhcmWBrP3GMKB2LhCLuTyg8RQwTZKX4xORjg9YAlyuHOUt7sFHHD1JN6s2lknKHgwnRbCJyuaPWQuDTIbhoIOLwl24uoHQKgIchU+W2jiUe7BAcqcvofbd60UvcSoeG2bA2ivDV/3OUxB9+09ePwcd+IKlmxO//BkihFwkMbqytutDPhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxpyfenahnlOiZ0dZ2KX3WiFOZnRGvL4e57nbfafOj8=;
 b=nMu81mljN19MSXlGbVBK+WbhD27Q7dhazPEcUUyxWFtMGVePdngj7W8QU8t9AsEboTUQcM5tcXGzRUmAAAj4//jj8qNHOqeqvNygh/KTSH0FyM+sSL3V/08XMkHKyLYogAJyd0kGqbWdWZF1NkArSPCstkqzBffsZ7LQ9Jhl0gq4v10Umg8zDV2tsB0lvp4JZ1A/90/2DWGF7unCVwci5H05ODCD+Zeh2npgYxUhUbkAVgVtxLY84UGbs0dpPOnXsEQz/pBPpHavLUKrIgrvCDTCubnTTPrKpFrAfDFc4erjfdaSaSfhZGHYPONlx9NBtWqIDCn14P6IhRmH+YsQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB5248.namprd11.prod.outlook.com (2603:10b6:5:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 09:55:37 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 09:55:37 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: RE: [PATCH] virtio-mem: Fix definition of VirtIOMEMClass
Thread-Topic: [PATCH] virtio-mem: Fix definition of VirtIOMEMClass
Thread-Index: AQHb1S3uVjr36/Og1kyf11sueVIyArPytXGAgAANtuA=
Date: Wed, 4 Jun 2025 09:55:37 +0000
Message-ID: <IA3PR11MB913659D12CFB166EE107C9F9926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250604084757.4035354-1-zhenzhong.duan@intel.com>
 <a41716ad-c6ab-423f-9001-b0b49f46ee45@redhat.com>
In-Reply-To: <a41716ad-c6ab-423f-9001-b0b49f46ee45@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB5248:EE_
x-ms-office365-filtering-correlation-id: 4fd030f2-5b35-4077-1e04-08dda34df4cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cEN5aUdWREJzcFVjNEwxb1ByS3FSdVpDMCtrU3V0K0ZRVEM4eWJJQTlCa3la?=
 =?utf-8?B?MlV4aGhxOE9TbG9hV2xKTzN0N05RWWlUR0QwU3g0TzVweDdEaTY1ZTZDVDN2?=
 =?utf-8?B?b1M0aUZtN0VVRlZtVVpNbENtVXFRei9WMkMxaC9NM1BrazY1SWUyWjZzRHlU?=
 =?utf-8?B?bmdzdldxajVaTk9neU50NEY3Rk1tc2pzeVZWdzJyUlR5bjQrYUZrclNldmo2?=
 =?utf-8?B?ZklCRXNFTzM5Mng0bkhmeEdlMkhYVWdwNHhra2ZvNXlEdjcvcmpQYVU4ZHpK?=
 =?utf-8?B?SHArcDlVR292S3VhejBSZXhqejBJRTVKUjc0bitBN1EvZ1ZUZWxnY3ZiWjlS?=
 =?utf-8?B?elF4d0VrMXcvQ3lCZ3QzZmxGYi9BVVVpS2VrS3N5TTk2V0pLbjYzeGxoVWta?=
 =?utf-8?B?YWVUT2cwNFMzb0VxckIyT0ZscHNXRkVTRXZxaW45SkhxaHhveVZ0RGY5WFFj?=
 =?utf-8?B?cnFVdk16WEpxaWVwV3lNZzk4UGRLNkhDYXFUQ1pJa0h4Y0RMNlNsRlF1SzF4?=
 =?utf-8?B?eElvbEg3RUk4MEgycy82T0k4d01OdE9KWTJFaWJKUlV5dE1uVm1CRnVUZnZn?=
 =?utf-8?B?VUVDTEZVakRHd21KN0Yxc2tOc2JmZ1hhNWlXTE5MaUVMMnJwSU53czhhNkxn?=
 =?utf-8?B?akZVSGI5STJBRUNBUmV5Y1lKQTJ1WUpkM0M2T05FNStydU1YSDFsSndMY3Ns?=
 =?utf-8?B?eURMeUdLRlg5dUhIb1ZWSERFUkdPZ0ZnTXlvc1NGNkNFekNLeTV1YytWRFNP?=
 =?utf-8?B?aHlmTlZ0M2JISmNLbHh3aUdabXVVNllyTlpzNHFuYjRTRk5jSGxmMTJjcFZx?=
 =?utf-8?B?THJkd3lmeThDeDdMOU53WURrZmJoRWxhYk1WUnJrMVV5RGlmM3cxOENINlYr?=
 =?utf-8?B?Yi8ySUxPbkZVT1Q5TXNuU1l0a0JSMENKcHg1MTZycWhaWExuSDhPaGRaUTJp?=
 =?utf-8?B?U0Y2aXlZemNBTFpiNTdKdUlqRkhWUDJ1Ui9ady95V1FTamlhZmVxbmJzRmpy?=
 =?utf-8?B?VnZwa1UwM2QrZ3lpVDFBZ0RDMTU5aThJaGVNSGNxZWZ4ek4vb3h1bzdrdEQr?=
 =?utf-8?B?ZFRWdWxMM1lJems4OHlvRHMwTGZjU1lWZTZIdmsyWGh0N2JHZUJzeWV1MVBr?=
 =?utf-8?B?TWkya2VreVB2Qks1K0hSaWtGVHJkRTdvK2I3NGNRWDBJOWFienl6Sm9taDlX?=
 =?utf-8?B?NXNTNlYwa1hPOE90RnltWUJKRjcvNmN6ek1iVmt6Y1BlbHlqNFUyd0U3WTVi?=
 =?utf-8?B?dHMxN2pwVWJoS1Z4c1JpUFJhenJzMjBlY0N6R3RPbWNjbjRCcWVqR2k5TEVa?=
 =?utf-8?B?ZVlOeEV2M2JPV3hsNUxRaVREYnNEMUdnU3BrNEgzQkNwM0Q0aGhNUHdMSzMv?=
 =?utf-8?B?MjFTMXVuQ1FvRUtqS2IwWG9FZVZFQ2VYYzFuN0FMVGhuSlVhclNFcENFdlZ3?=
 =?utf-8?B?ckcvUW12cWN3ZkxWa3J4S3VLNWJZc0EzZXhldXdRNE5hc1lraUJXblduMjhZ?=
 =?utf-8?B?Q0ZzQTY2bWxOZU02WUpGZzI2MzMwdkdtMXNXUmxjZDNRQXBQKzczQVg4WmJr?=
 =?utf-8?B?b3k2RkZrcGM1dTZmYUI2OERBajhXV3p6eGdHTFBXZHRTV201K21sYm9CSEFO?=
 =?utf-8?B?a1hEcjVJS294Wk5ZTWlmdE9iMW8wVzZlZEJhaTdSSStsK1JIRVFya0lZRnB0?=
 =?utf-8?B?Nk9VYUQ1VlI4aGFPRXJTWDFxcnkybjFHa2JUWlN6Ulp4SG1vT2tGQUUzemNY?=
 =?utf-8?B?cFJrMm84MWE2RWtDZktON2NLMHBlT2I0MUxPZ2poVk0wQTA3b3dzaXBSZ293?=
 =?utf-8?B?NGFaWnoyd25MUzI4Z1FwRmpmQ1BEWjJySHRxS3ErVDZnVGF1dFFkYWFTL2F6?=
 =?utf-8?B?WVhMczN5aGc5ZVRmWkFiOEdXaWt4akd1TGg5NHZKSko0Ylg1WWtiZUZ4RWYz?=
 =?utf-8?B?UEtWZHZwS3EvaEZKSDAzSFZNRTFPem0wd2ZPbkFHbWNscDR3RzErWFh3Q2Z4?=
 =?utf-8?Q?8d/pTx+0/SR1N4tc+RJDcQtuE8S3ME=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3ZDMmFMSHdueENzNjBZR1VZNWRXOE9mcjZyWjNodU5nOGFSVkNRQWZpMkVy?=
 =?utf-8?B?NlROWktJTjFOaWlhZnZ3UEdsMmpmMzJtL2puWHpIellvWUNXMFFieDRXM2VG?=
 =?utf-8?B?RVN6eWxEWXBDZ25hYUlEZldqSlNEajJyZGp4a3Q5bUszVUhuVE02VEdnRVIr?=
 =?utf-8?B?VTFBSDZhR1pzTEdhQlJDYWlsaG9wSS9JOXVGbWlwT3oyUWcwYkJZK3RPVjBw?=
 =?utf-8?B?SGs3UTk5SlFHK3dOVDQ0SDZVWThzNmhOS3VaR0I0a2tlaWFpUDZrekZZaU1o?=
 =?utf-8?B?alFFZ1lleDNudUNzbExoU2x3bHowUlRzQ2VoK2FyaWEyQXA3dFkxM01LWjAw?=
 =?utf-8?B?QzVkeHVIckIxR0d6ZGx1S052SHBoR3h3ZG1RV1pjWlM5ZWZiQ085N0VpdTRU?=
 =?utf-8?B?alNNemZEZCt6R3dESFNaMWxGbnJrdzZYTHIxWlRCbXliNksya3lBK0FEUjlD?=
 =?utf-8?B?TkxVckhhY3lycnZZZDl4NnFsSUVBQXdHY1JjNFluQTJxaXBIYmx6aHgyOWdp?=
 =?utf-8?B?RktNQjBSUXgxYzBJaDd6V2NrZFVWVGpQQWVGR1JhcFlySDhGdFlPYzVkOEhF?=
 =?utf-8?B?WXRMRFBTYmhsNjJTcUtkT2hIY1dYM1EzUG15RHJWWW84WVpWK1lad3BwZFhr?=
 =?utf-8?B?K0FBamNud0dHVUc4QjdLSzV4UnpZblAzR2hTMCttbStiWFF0MnpuVGVBdU9h?=
 =?utf-8?B?Qmxpc1o5T3FRdmY2Y1hjbjUyTVRyekk2TWh3NFVKNGgzQmNUSzgrVnI5b21p?=
 =?utf-8?B?UVdjZjBURVJlbStiaHdjbmJlWGtuU2tZeVJJRUQyTHhkNUJ5SXpzV0NjY1hG?=
 =?utf-8?B?TnZOeC96WDBobkdyY3l3ZmRSR3Y2YzR1UHRwZTUxeVVHYjJSMXlGeFk5MmV2?=
 =?utf-8?B?VHdSSWxsMXdxYzJXUmpUalMrb3FDVE5DSGQrMUVXcWlmRzk3Q2ROQWdrVGx6?=
 =?utf-8?B?NTVHbUh6SmVFaGxxZHFNY1FVT0tTUUxidTM2M0I2OUdjWkZ0NjBIZHNxckFi?=
 =?utf-8?B?SjV6S25xVUNJNWlZS09lRi82UW1GUXJvcktHM21TWTBhaUpPY3pzY1NVVkxa?=
 =?utf-8?B?QmtGenBXV1dsU0RpZHRKU2d2ekZzSk9IbzQwOVcrNUJNU2x5UHViMWowU216?=
 =?utf-8?B?YTRmZHVDcUw3NkIvR1g1UkdycXdhdmhpdlFEOTMyNzRuNy9Hc09UU3F0cTdN?=
 =?utf-8?B?ekE0Y1crbHErOFRYaFQ5Q2F3cytYSkd6dGVIVkFzNTF5REFmMmNmNThhZlpk?=
 =?utf-8?B?bnc2L1JvUlUrMVI2SjF1UXlCN0RrUGFxTWZlVWs4elYzaEg3N2diUHVzU2Jp?=
 =?utf-8?B?d0RWanVjQWc3TVVPb0NyOGUxUHFlTms1d0FzbExXMzY5S1NqRUhGY2VpcHhw?=
 =?utf-8?B?NVlXUVdYWTBYRE5lV3RLSm4wL0gvV3ZFQ2tHVHpvNUNONEhxZ2pXU2JjMWFx?=
 =?utf-8?B?OElhaW0xYVBJZlV0bHNYbGp6YWpqRVZjcGhWTXlYejFTaFNoZWZRSUVGanZu?=
 =?utf-8?B?TEszdEdycTdPL2J0NjNQcDRJR2hkaHVFWENJMTMxWFBKWGhJVTdORm84TEJN?=
 =?utf-8?B?UkIwMjE5aUhKZWNESVRjQWI5WWNQa3A2cUhIem1LN2o3QUhLY1dFajN5U2R4?=
 =?utf-8?B?Y0RXY2V2d0Q4SmRkNjZIR3crU2R4WTZJc3pKcVpYbHZpNzlCZE9ZRU5hZnpN?=
 =?utf-8?B?cTdTUFlQVk1wQk1XY2NMQ2tuaXE5b21SejUyRzA3ZFRMaFhqbTNQNTRPckQ2?=
 =?utf-8?B?cjlUR1VRM2ExdG84NTJlL3BkNXZxbndwdmZtS0d4MS9lQTBMRFhYcmordTA1?=
 =?utf-8?B?MTdGeS9UT3N5TGxLVnZ2VGMzdXBWZ2tyRlVDMHYxU0VsVHZmNzJXeFUrZUlG?=
 =?utf-8?B?ejAxZVAzS1lBVWpqYndRZkJnUStpaGFrTkFCbFA2TW5ray94eGowT3Z4NENX?=
 =?utf-8?B?N3hST0xWbGE0WHYydFg5ZG9McHd2OVVZTjQwc0tTR0IzN0RjaXgyVkxwVkxm?=
 =?utf-8?B?bjdGdHVVNHJKdjhlbDVXTHlpU3dSWTgyUlM0MXIvVUlkZGRFb05seUV5enFs?=
 =?utf-8?B?a1ZYQVBPUHI5LzZwUVR5b0hMNTJQY1RISzFzd2gveTA4Uis4RjhxSFNaOHpq?=
 =?utf-8?Q?ukxnYVGUdntWBXuFaP5QxGQf+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd030f2-5b35-4077-1e04-08dda34df4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 09:55:37.0988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ue07oENWTGNMjm0HUgP3nTCnGmVgOO+ATF2V82ZM4xNkXiKSmUYnlws43KD0b5SgvYM2w8uBswmOrzUao0KtvsMfwvmFTx1R0GfOemY9A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5248
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZpcnRpby1tZW06IEZp
eCBkZWZpbml0aW9uIG9mIFZpcnRJT01FTUNsYXNzDQo+DQo+T24gMDQuMDYuMjUgMTA6NDcsIFpo
ZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gUGFyZW50IG9mIFZpcnRJT01FTUNsYXNzIGlzIFZpcnRp
b0RldmljZUNsYXNzIHJhdGhlciB0aGFuIFZpcnRJT0RldmljZS4NCj4+DQo+PiBGaXhlczogOTEw
YjI1NzY2YjMzICgidmlydGlvLW1lbTogUGFyYXZpcnR1YWxpemVkIG1lbW9yeSBob3QodW4pcGx1
ZyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1tZW0uaCB8IDIg
Ky0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1tZW0uaCBiL2luY2x1
ZGUvaHcvdmlydGlvL3ZpcnRpby1tZW0uaA0KPj4gaW5kZXggYmM0Zjc4Nzc3Mi4uOTNmZGY5ZTQz
MiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1tZW0uaA0KPj4gKysr
IGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLW1lbS5oDQo+PiBAQCAtMTM0LDcgKzEzNCw3IEBA
IHN0cnVjdCBWaXJ0aW9NZW1TeXN0ZW1SZXNldCB7DQo+Pg0KPj4gICBzdHJ1Y3QgVmlydElPTUVN
Q2xhc3Mgew0KPj4gICAgICAgLyogcHJpdmF0ZSAqLw0KPj4gLSAgICBWaXJ0SU9EZXZpY2UgcGFy
ZW50Ow0KPj4gKyAgICBWaXJ0aW9EZXZpY2VDbGFzcyBwYXJlbnQ7DQo+DQo+V2Ugc2VlbSB0byBo
YXZlIHRoZSBzYW1lIHByb2JsZW0gZm9yIFZpcnRJT1BNRU1DbGFzcy4gQ2FuIHlvdSBjaGVjayB0
aGUNCj5vdGhlciBkZXZpY2VzIGFuZCBzZW5kIGZpeGVzPyBUaGFua3MhDQoNCldpbGwgZG8uDQoN
ClRoYW5rcw0KWmhlbnpob25nDQo=

