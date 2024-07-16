Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD28C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdQU-0007Wf-1U; Tue, 16 Jul 2024 04:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTdQF-0007Tv-F6
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:20:32 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTdQB-0000CC-Px
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721118028; x=1752654028;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TuUCUUaWkUFF66CELJ6qvS23y9P0jSudhAm/YqfUpDU=;
 b=moOs32QzoZbXlLNW47yt5pcc7W1eILLLerkk9XayhmOWklZR0O/fWlej
 yKkXnqwtZBNyrJKIx0sWjsoHWnGsdxXboq8VKMxO+uTyd7cHKkSas8wB4
 SV3eXEpTda6iA1jR+Q8lPnwu47s8wn24Pv7aXGy8cYCshhKAz7A9hL2eS
 E8EhC3khJv2+jqtUBrcawn3sMVpbjl9iQjE8AVy7YXdrR+BuQfBQxedlL
 YbkcP2h6sSGyNTsj3J0cis3Eo4NyYpz7BwyAhvSCnUkAdoNlGxppG0BBQ
 CqurJaPw0Oh31j15Xbcq+tf535noc+GDouWxBj+LRR0WrFnJywKtM2t1m g==;
X-CSE-ConnectionGUID: 96N2F7ljSbSoEDI2sfPIKw==
X-CSE-MsgGUID: l4xzOemjTEeKsOUnjECVWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="22300430"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="22300430"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 01:20:23 -0700
X-CSE-ConnectionGUID: 6HxtBqZ1TSSh183yrr+v6g==
X-CSE-MsgGUID: ViclaEofT5KQghmewyml8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="49676196"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 01:20:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 01:20:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 01:20:21 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 01:20:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3XVBj3Ko6vPswXOoPG0clAMoJ94cYqoRlqTNcDjSi34A96xWEx3l8oacktc7tSDKsTMgfFxSGxsNr79KIFIm4zleOnGXZ87tCiAGg2vjZUL2QVCBb1jh6lwV6IU/k4w5j06a594MvHADkjdBkIA9RmIECkhE5XgJPe9UR2Xusyz4APbhEQv7XdYvVJl4HMvLpnZMYnnStKmpqDAna7IJU8rDqRj0yv+Z7wHp9iygD6cdg8AwANfHdxNgQohcs0HfsdION7H10XCu926ElFNY5gs+Haas8QjPYJnfHP7IpBMTY8KH0Z43wEmA0iJ5vSXxmIjC4fUs82kWfvv+dutmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuUCUUaWkUFF66CELJ6qvS23y9P0jSudhAm/YqfUpDU=;
 b=p3JcRYUioyQtsl8CzYnl0i5t6D1L8wBtu8M5lznSyokTF9UZ+ZQtgxSXeDTZNZf9g8hfOL2P/fn9A9+BsLGbWWJOlInDmv5IBM5LD6ItyGE05ADkwnZrKuAvBEiMCcXwa5SjNCe90+97oq1RyvDzUVeR0Ne4Bh5bDutVnCU+6TABQ7SSSgEcYU3c7qpb444ZBui7keatpBEWr0ktZnjbH5pl4mYkBNnXF7TXX5nSpMX/F5rwV+VXFoRYgct6TE7XAl/1uiITIAxuzmTdueDFBeBAGHKcmdW/79n5KXrS67vH+IUecQPBW/8VLMGHelMJEKEIUcJ3S6nAHKJZG1bbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Tue, 16 Jul
 2024 08:20:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 08:20:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v4 00/12] hw/iommufd: IOMMUFD Dirty Tracking
Thread-Topic: [PATCH v4 00/12] hw/iommufd: IOMMUFD Dirty Tracking
Thread-Index: AQHa1FFDRkoLjK7NzkiqN4/11c+RQLH5B1sQ
Date: Tue, 16 Jul 2024 08:20:19 +0000
Message-ID: <SJ0PR11MB6744C37D32B04773DCD00FCF92A22@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-1-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB7592:EE_
x-ms-office365-filtering-correlation-id: c549fa25-98c0-4a45-9f57-08dca5702142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RlMyUzJnQml5aTA2bWpVL1dEUjk1VUtpT3JYSlU3WmRhME1LSmVCMWo1Q0V6?=
 =?utf-8?B?RnpxNkdCK3h0T2QvL21mOWJCRjNrMU80WW1QWThQb2t6cXl5dE5KUldySjFR?=
 =?utf-8?B?QmJDM2hTdWxLbzFHcEdVZThjaDZZM0xNajY2MklNS0JNWWxvVXFBdlFNS0ds?=
 =?utf-8?B?YVJHcnpTa05XOVZUNUgvdVNVMXRKVEU1dWI3YkNPZGl0dm9KeGFPcW81ZFo3?=
 =?utf-8?B?aHh1b3YvNUZscmxsRkhZQnhDR1hMU3BGWHVMNldVWU1QM2UyMEhNYUl3T0Z0?=
 =?utf-8?B?NEgxQ3ltaTVOekJFbmJ1UUZoS1Y4dkdEWDFGVi9mSC9QUlVwUGVLZjF1aGdv?=
 =?utf-8?B?UVNCd1FUREtpb1RnUWVlWGlsMTNKZnYyTUJCcW9rNGFFWGliMzRDWE1zUGFI?=
 =?utf-8?B?N2Fyc1BPSHJ2aEUyUTMwWS9rOGNTdTIvc0ZNMXRFSGt2V1didFhCaHZ3bkFl?=
 =?utf-8?B?L1VmaXpDdy9lSm5pOFdiSGoyUGg4TlIvK2Ezb0pNaXBtT003dVRFRVg4NXMz?=
 =?utf-8?B?dFU1TTNmWGVCSHY3RU5GNDREOUVmWXRzK3NaQWsvQkxtc01wZC9GNDJPNWx3?=
 =?utf-8?B?b2Njb1d0ZHZ4bXJuUmZORDV5bGJlRHdiN0YvYllEclpPUHc5L0EvRHRmeGoy?=
 =?utf-8?B?eng5NFRVRnQ0bVI2U1BTdFhiRDhzOWxHQldzRFF4aUNqYWNEOHVDVW91Wmxi?=
 =?utf-8?B?b0Jyd2JXQ3U0YWh1N3JyMmFVdEpVNUtKd0JpYytaRTE1NzQ0Mk9xcDZkUDBY?=
 =?utf-8?B?K3RIazYyK0R2azV3ZlVESzh3emY4VzI5Zi8za25TUEM5aFBBOUdRV29kcHl5?=
 =?utf-8?B?NUlDNzRRZnZ0dS8vN2M1TUh6bVlRM1ZBcFpnb1N0RXpwQmUxWEI0cW16NkFV?=
 =?utf-8?B?SkRONzRHeGNXcGRxRlNRZ2wxRlVtdWZwUzhFOHBXUFJ4RkhEZXRLRnZVbDhD?=
 =?utf-8?B?UnZGNkhxaE1XK2p3cy90NU91emo3VkdQNWwrRlBUcFZaSWdWNEdxeWFNTkRs?=
 =?utf-8?B?Nkx5aHVjOGNSVFNRM2NYUjN5NnAwOG9nbUlGNkRIWDU0MmYvdE5NSUFjQWY1?=
 =?utf-8?B?eUkxY1R2aFM3em5vcEZhYldtU2p4MHluMkdla0l2bWlMUEJyYkRLMGw2ZmNk?=
 =?utf-8?B?U0xBN2JxNzRYQktBZHBuK0tNQ3dsNmNpQktTK1RQR0J5TWl2MzVhQk9HOGR6?=
 =?utf-8?B?Q1RkWllMTXRvRUxsSUkydklLY3p3Q1JENkhsMnNNV2NGMjJKS3BBelkwcDNr?=
 =?utf-8?B?S3RBc0lhazA1RmZEUU01NWJodURXRzBpMkkweXBYb2hhak5mZGplczh1S25k?=
 =?utf-8?B?d2tzSmhZWjVMZ3NWMXNrS21xRTVVdjlNRCtodjR2Q2Z6S003cnZxUUlUdE96?=
 =?utf-8?B?RUtObzYwdjR5b0ZNeEdRcndpQlZXSGZFV1N6OGhHNFlHSmxRWFVxSE9ScFh3?=
 =?utf-8?B?Z3RqSVk1TkRhSVUrZEtGYTZ3MFlNZVg3MFFyZjNXZ2FWVXUxVU5sWnh3cGJI?=
 =?utf-8?B?SmlleHRHVmhQZHRVbUlVZjNyQ2pkV1BQczFMbnVUS3dUcks5K3Jhc0phaGQx?=
 =?utf-8?B?YkJrbmNGS1IvaVlLZjJPVWFUMDQ3UGNNVDIrQWRqYkxXQ2d0R2J1Y2VqV2tR?=
 =?utf-8?B?dHN3OXlHM2VzZDVGSE1FSG5FNE5JdVVhUml3LzMrNHY3Vm1lRHRaeW9VdHZv?=
 =?utf-8?B?VXZ4dStjaU9WcHdkYmJlc2tXVlJ0dHFRZ3QxSE5JUVI1dzVWSENCb0xnT0s4?=
 =?utf-8?B?emtNc2pncTMxejFaYk4vVjB5T29QNkRyTWNqRUZ0UG5XS2VGSWgxdDdBdVUw?=
 =?utf-8?Q?mJzLwPYT+xz6goyAhFiPNSWfWxEQUTv01n4MI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE5UbjA3RWNDT1lUVkNKblBqUGFJTzNsdGJGdnlyeW9NMyt1TkpwbEYvdW5m?=
 =?utf-8?B?bnNnblVXUmp0dGZxcHQwTktleUYzNXFyNGxKZGo4dFc5RmZibVlja2tKbjAy?=
 =?utf-8?B?dnpDaTlQaTYranRSajRyREpRaHc2ZVZ6OXR1M25BSFU1blVMU1FVcWYvTlUr?=
 =?utf-8?B?QkRNM0IxR1VMMlptclVQb3cxK3RwMktEdmE4YTZCbGh5eEE0ZVJvaWUrS0Mw?=
 =?utf-8?B?aDFWNlNnZmpYYnRaYkc4V0FBaEZDL09RMjlacW11eS83WVNvSzM3TmN5LzVl?=
 =?utf-8?B?K1FiaFd6NXdLZW5ndkxPVDVnV0NtUTZRV3BwWWRnQVNkcUNYa2ExVUhFcHND?=
 =?utf-8?B?RGtidStaeHAxWFFmMEQ0b2VTczZNWWVZaXd0TnQxdkRHalVRVEliQlVVMUdy?=
 =?utf-8?B?T3pkb210bDBZeTZMMGJhb2d1T3JOYlNrb09VaEFmLzlyZ0V4RCs5REFYcSt5?=
 =?utf-8?B?SXBYMWQ0M05iM1hEeXg3Q01pVk5PRTZ3WWFNQXhza095UFpobzJBYWtKL0Q3?=
 =?utf-8?B?OW8rd0FTZTVOQ2orU2I1elVRdWtFVzFIemo1UDVQbTE2TTFDQmdSS3lhU1Jo?=
 =?utf-8?B?ZmpUZXNHOU9abm9vY3k1VUh0cnRWV3VWSmg3Ukw1NUhCTzR0b3hyU25XYXBj?=
 =?utf-8?B?VTVDUXUxOEtBNnFyYi84VnRVWnNQYWtnWDhIbFgrOVlvdGdad09od1duN0Zr?=
 =?utf-8?B?V3Z5azcvdGV4eVRRQm1qTlM1OFZoZ0xyTTl4dGNFVDFrRlNseTgrNk1qV1ZD?=
 =?utf-8?B?ZHVkY2pXUUp0L2JJMTI4VDF1Y2h5bm9aOUwzRk4zM01sbG5NR1NFTGVMZ2hK?=
 =?utf-8?B?aGVERGxpZjkrQURhREd3M1JrOXBIMGNaVkN3Rzk1R2RCNW5OVW80TmZ5Y2Nh?=
 =?utf-8?B?T2ZqL0JWdzJyWFI3ODUvV0pVaU95ZWVrcm1vV0FkM1FpRjlsUXZ0ZDNoc3I0?=
 =?utf-8?B?Y2R4T2tVUDlhUlFPV2JORTgxZmlIUjdXai9HaEpNOHBFN1RkdFhBUkp0aE5m?=
 =?utf-8?B?YWt3WmN0Y2E0QlVZaDh4ZlpIU2dhM0MvUjRQUWVndVVWU1dxZHZkMXNEQ1Z6?=
 =?utf-8?B?emNUVFF4c3pSUjZiTUtiUmtsNStLNllLcFdmbUs5UGxaNGl3VFJSdHhvRnNj?=
 =?utf-8?B?ZnFhOVhjem9PcS9LWWcyak9rV2lEU1JWZlliYWVSNERWbHhaYVAxVGVqR2pl?=
 =?utf-8?B?S05WRExyZzI2R3ZXM1cxb29jQ1ZFblFPaVQ5amVSOThmaC9vZUVFWFk0alBP?=
 =?utf-8?B?cEQvUUdUM01mMWcvbjl6SlZ0eUFXRnNROTlzUkJ0SS9FdjkyOXU2bFQxWnhV?=
 =?utf-8?B?ODlleXNIMEtrWGxLNmE5ZDNLSGJNOTVOQ3U0dWN4dVJrTFZuV3Awb1hROWtR?=
 =?utf-8?B?TXRPTGxRaXBmb2NSNnFuRi9sa21wQkFjZ1kvbmxYVHNzS2grNlRWTGdCaFhx?=
 =?utf-8?B?Vm4xZThHWWs3UUUxdFZURVIxNjZOVDAyamladHZFdnExZHkvcEVkanJqb21w?=
 =?utf-8?B?V3NIZFkxdUFVamtoNGZEMEVIV3lIK0pXaGZKbUpsMnRnOEhWWTU0UTI5OG8w?=
 =?utf-8?B?KzZ2UHlHaldMbHpnSXVMMmdWRXU3bHYrSHdQN29jSnZYYnI4ckFNd2t4UDdU?=
 =?utf-8?B?NDRyclNOQStTTmhRbWpFSXdhc09GMm5KcXJIRW5MTHJuWjgxNGRUU2VpNUdN?=
 =?utf-8?B?ZlRtNU8rZU9MNGhMQU5jTkdzdmFvSnBRM3RuMkEya1BuVlJyOHpxQTJGN2do?=
 =?utf-8?B?SWFpRGZ5aUNyNUxOWkxINzE3VVpHQ3paTmNaSTBtcEM1bGY2SnFWQjRvN2hq?=
 =?utf-8?B?TFFyVVRUcHRrQ1lVV214dEJyT0QzOHBOWG1HU2pWbkNxdU9QdWU3WUpOaENl?=
 =?utf-8?B?UFUyd0V0MnlkZ1dPSzNDN2VadlBWdVVudHlYcVhXcWNFcVpORWx3V0E3Qjl1?=
 =?utf-8?B?SmNSTzZORlI2dk1IMG1GZFhMeDllbTE3Wjl2VFEvYTFVeWU4aGpvYjNmaUN3?=
 =?utf-8?B?SGN4cGxJRTVOOHR3aURYTkpPbFFTWjNENUJhUnh0eXBNbDF4RmtSRlZiVlY0?=
 =?utf-8?B?N3ArVUxzUnJwZ2pyS0l3QWNnZE1nM3ZRV09RL1Bsc1lFVVZaeTlBczNsOEta?=
 =?utf-8?Q?Nzhn3EiE88lyVAQ0INK8wjszV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c549fa25-98c0-4a45-9f57-08dca5702142
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 08:20:19.2505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfschNenTxdCbFknr6MCy9gZPrR5KLnbK+cHLwgYS1xDnygv1+5A+8f1eKT5Dtk9k7j1pAUXR8gVc+7HZAzdetfKZjvegqsHaXOU3iYpFtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7592
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjQgMDAvMTJdIGh3L2lv
bW11ZmQ6IElPTU1VRkQgRGlydHkgVHJhY2tpbmcNCj4NCj5UaGlzIHNtYWxsIHNlcmllcyBhZGRz
IHN1cHBvcnQgZm9yIElPTU1VIGRpcnR5IHRyYWNraW5nIHN1cHBvcnQgdmlhIHRoZQ0KPklPTU1V
RkQgYmFja2VuZC4gVGhlIGhhcmR3YXJlIGNhcGFiaWxpdHkgaXMgYXZhaWxhYmxlIG9uIG1vc3Qg
cmVjZW50IHg4Ng0KPmhhcmR3YXJlLiBUaGUgc2VyaWVzIGlzIGRpdmlkZWQgb3JnYW5pemVkIGFz
IGZvbGxvd3M6DQo+DQo+KiBQYXRjaCAxLTI6IEZpeGVzIGEgcmVncmVzc2lvbiBpbnRvIG1kZXYg
c3VwcG9ydCB3aXRoIElPTU1VRkQuIFRoaXMNCj4gICAgICAgICAgICAgb25lIGlzIGluZGVwZW5k
ZW50IG9mIHRoZSBzZXJpZXMgYnV0IGhhcHBlbmVkIHRvIGNyb3NzIGl0DQo+ICAgICAgICAgICAg
IHdoaWxlIHRlc3RpbmcgbWRldiB3aXRoIHRoaXMgc2VyaWVzDQoNCkkgZ3Vlc3MgVkZJTyBhcC9j
Y3cgbWF5IG5lZWQgZml4ZXMgdG9vLg0KV2lsbCB5b3UgaGVscCBvbiB0aGF0IG9yIEkgY2FuIHRh
a2UgaXQgaWYgeW91IHdhbnQgdG8gZm9jdXMgb24gZGlydHkgdHJhY2tpbmcuDQpUaGUgZml4IG1h
eSBiZSB0cml2aWFsLCBqdXN0IGFzc2lnbiBWRklPRGV2aWNlLT5tZGV2ID0gdHJ1ZS4NCg0KVGhh
bmtzDQpaaGVuemhvbmcNCg0KPg0KPiogUGF0Y2ggMzogQWRkcyBhIHN1cHBvcnQgdG8gaW9tbXVm
ZF9nZXRfZGV2aWNlX2luZm8oKSBmb3IgY2FwYWJpbGl0aWVzDQo+DQo+KiBQYXRjaGVzIDQgLSAx
MDogSU9NTVVGRCBiYWNrZW5kIHN1cHBvcnQgZm9yIGRpcnR5IHRyYWNraW5nOw0KPg0KPkludHJv
ZHVjZSBhdXRvIGRvbWFpbnMgLS0gUGF0Y2ggNSBnb2VzIGludG8gbW9yZSBkZXRhaWwsIGJ1dCB0
aGUgZ2lzdCBpcyB0aGF0DQo+d2Ugd2lsbCBmaW5kIGFuZCBhdHRhY2ggYSBkZXZpY2UgdG8gYSBj
b21wYXRpYmxlIElPTU1VIGRvbWFpbiwgb3IgYWxsb2NhdGUNCj5hIG5ldw0KPmhhcmR3YXJlIHBh
Z2V0YWJsZSAqb3IqIHJlbHkgb24ga2VybmVsIElPQVMgYXR0YWNoIChmb3IgbWRldnMpLiBBZnRl
cndhcmRzDQo+dGhlDQo+d29ya2Zsb3cgaXMgcmVsYXRpdmVseSBzaW1wbGU6DQo+DQo+MSkgUHJv
YmUgZGV2aWNlIGFuZCBhbGxvdyBkaXJ0eSB0cmFja2luZyBpbiB0aGUgSFdQVA0KPjIpIFRvZ2ds
aW5nIGRpcnR5IHRyYWNraW5nIG9uL29mZg0KPjMpIFJlYWQtYW5kLWNsZWFyIG9mIERpcnR5IElP
VkFzDQo+DQo+VGhlIGhldXJpc3RpY3Mgc2VsZWN0ZWQgZm9yICgxKSB3ZXJlIHRvIGFsd2F5cyBy
ZXF1ZXN0IHRoZSBIV1BUIGZvcg0KPmRpcnR5IHRyYWNraW5nIGlmIHN1cHBvcnRlZCwgb3IgcmVs
eSBvbiBkZXZpY2UgZGlydHkgcGFnZSB0cmFja2luZy4gVGhpcw0KPmlzIGEgbGl0dGxlIHNpbXBs
aXN0aWMgYW5kIHdlIGFyZW4ndCBuZWNlc3NhcmlseSB1dGlsaXppbmcgSU9NTVUgZGlydHkNCj50
cmFja2luZyBldmVuIGlmIHdlIGFzayBkdXJpbmcgaHdwdCBhbGxvY2F0aW9uLg0KPg0KPlRoZSB1
bm1hcCBjYXNlIGlzIGRlZmVycmVkIHVudGlsIGZ1cnRoZXIgdklPTU1VIHN1cHBvcnQgd2l0aCBt
aWdyYXRpb24NCj5pcyBhZGRlZFszXSB3aGljaCB3aWxsIHRoZW4gaW50cm9kdWNlIHRoZSB1c2Fn
ZSBvZg0KPklPTU1VX0hXUFRfR0VUX0RJUlRZX0JJVE1BUF9OT19DTEVBUiBpbiBHRVRfRElSVFlf
QklUTUFQIGlvY3RsDQo+aW4gdGhlDQo+ZG1hIHVubWFwIGJpdG1hcCBmbG93Lg0KPg0KPiogUGF0
Y2hlcyAxMS0xMjogRG9uJ3QgYmxvY2sgbGl2ZSBtaWdyYXRpb24gd2hlcmUgdGhlcmUncyBubyBW
RiBkaXJ0eQ0KPnRyYWNrZXIsIGNvbnNpZGVyaW5nIHRoYXQgd2UgaGF2ZSBJT01NVSBkaXJ0eSB0
cmFja2luZy4NCj4NCj5Db21tZW50cyBhbmQgZmVlZGJhY2sgYXBwcmVjaWF0ZWQuIFRoYW5rcyBm
b3IgYWxsIHRoZSByZXZpZXcgdGh1cyBmYXIhDQo+DQo+Q2hlZXJzLA0KPiAgICBKb2FvDQo+DQo+
UC5TLiBTdWdnZXN0IGxpbnV4LW5leHQgKG9yIGZ1dHVyZSB2Ni4xMSkgYXMgaHlwZXJ2aXNvciBr
ZXJuZWwgYXMgdGhlcmUncw0KPnNvbWUgYnVncyBmaXhlZCB0aGVyZSB3aXRoIHJlZ2FyZHMgdG8g
SU9NTVUgaHVnZXBhZ2UgZGlydHkgdHJhY2tpbmcuDQo+DQo+Q2hhbmdlcyBzaW5jZSB2M1s1XToN
Cj4qIFNraXAgSG9zdElPTU1VRGV2aWNlOjpyZWFsaXplIGZvciBtZGV2LCBhbmQgaW50cm9kdWNl
IGEgaGVscGVyIHRvIGNoZWNrDQo+aWYgdGhlIFZGSU8NCj4gIGRldmljZSBpcyBtZGV2LiAoWmhl
bnpob25nKQ0KPiogU2tpcCBzZXR0aW5nIElPTU1VIGRldmljZSBmb3IgbWRldiAoWmhlbnpob25n
KQ0KPiogQWRkIFpoZW56aG9uZyByZXZpZXcgdGFnIGluIHBhdGNoIDMNCj4qIFV0aWxpemUgdmJh
c2VkZXY6OmJjb250YWluZXI6OmRpcnR5X3BhZ2VzX3N1cHBvcnRlZCBpbnN0ZWFkIG9mDQo+aW50
cm9kdWNpbmcNCj4gIGEgbmV3IEhvc3RJT01NVURldmljZSBjYXBhYmlsaXR5IGFuZCB0aHVzIHJl
bW92ZSB0aGUgY2FwIHBhdGNoIGZyb20NCj50aGUgc2VyaWVzIChaaGVuemhvbmcpDQo+KiBNb3Zl
IHRoZSBIb3N0SU9NTVVEZXZpY2U6OnJlYWxpemUoKSB0byBiZSBwYXJ0IG9mIFZGSU9EZXZpY2UN
Cj5pbml0aWFsaXphdGlvbiBpbiBhdHRhY2hfZGV2aWNlKCkNCj53aGlsZSBza2lwcGluZyBpdCBh
bGwgdG9nZXRoZXIgZm9yIG1kZXYuIChDZWRyaWMpDQo+KiBEdWUgdG8gdGhlIHByZXZpb3VzIGl0
ZW0sIGhhZCB0byByZW1vdmUgYXdfYml0cyBiZWNhdXNlIGl0IGRlcGVuZHMgb24NCj5kZXZpY2Ug
YXR0YWNoIGJlaW5nDQo+ZmluaXNoZWQsIGluc3RlYWQgZGVmZXIgaXQgdG8gd2hlbiBnZXRfY2Fw
KCkgZ2V0cyBjYWxsZWQuDQo+KiBTa2lwIGF1dG8gZG9tYWlucyBmb3IgbWRldiBpbnN0ZWFkIG9m
IHB1cnBvc2VkbHkgZXJyb3Jpbmcgb3V0DQo+KFpoZW56aG9uZykNCj4qIFBhc3MgZXJycCBpbiBh
bGwgY2FzZXMsIGFuZCBpbnN0ZWFkIGp1c3QgZnJlZSB0aGUgZXJyb3IgaW4gY2FzZSBvZiAtRUlO
VkFMDQo+ICBpbiBtb3N0IG9mIGFsbCBwYXRjaGVzLCBhbmQgYWxzbyBwYXNzIEVycm9yKiBpbg0K
PmlvbW11ZmRfYmFja2VuZF9hbGxvY19od3B0KCkgYW1kDQo+ICBzZXQvcXVlcnkgZGlydHkuIFRo
aXMgaXMgbWFkZSBiZXR0ZXIgdGhhbmtzIGluIHBhcnQgdG8gc2tpcHBpbmcgYXV0byBkb21haW5z
DQo+Zm9yIG1kZXYgKENlZHJpYykNCj4NCj5DaGFuZ2VzIHNpbmNlIFJGQ3YyWzRdOg0KPiogQWx3
YXlzIGFsbG9jYXRlIGh3cHQgd2l0aCBJT01NVV9IV1BUX0FMTE9DX0RJUlRZX1RSQUNLSU5HIGV2
ZW4NCj5pZg0KPndlIGVuZCB1cCBub3QgYWN0dWFsbHkgdG9nZ2xpbmcgZGlydHkgdHJhY2tpbmcu
IChBdmloYWkpDQo+KiBGaXggZXJyb3IgaGFuZGxpbmcgd2lkZWx5IGluIGF1dG8gZG9tYWlucyBs
b2dpYyBhbmQgYWxsIHBhdGNoZXMgKEF2aWhhaSkNCj4qIFJldXNlIGlvbW11ZmRfYmFja2VuZF9n
ZXRfZGV2aWNlX2luZm8oKSBmb3IgY2FwYWJpbGl0aWVzIChaaGVuemhvbmcpDQo+KiBOZXcgcGF0
Y2hlcyAxIGFuZCAyIHRha2luZyBpbnRvIGNvbnNpZGVyYXRpb24gcHJldmlvdXMgY29tbWVudHMu
DQo+KiBTdG9yZSBod3B0OjpmbGFncyB0byBrbm93IGlmIHdlIGhhdmUgZGlydHkgdHJhY2tpbmcg
KEF2aWhhaSkNCj4qIE5ldyBwYXRjaCA4LCB0aGF0IGFsbG93cyB0byBxdWVyeSBkaXJ0eSB0cmFj
a2luZyBzdXBwb3J0IGFmdGVyDQo+cHJvdmlzaW9uaW5nLiBUaGlzIGlzIGEgY2xlYW5lciB3YXkg
dG8gY2hlY2sgSU9NTVUgZGlydHkgdHJhY2tpbmcgc3VwcG9ydA0KPndoZW4gdmZpbzo6bWlncmF0
aW9uIGlzIGluaWl0YWxpemVkLCBhcyBvcHBvc2VkIHRvIFJGQ3YyIHZpYSBkZXZpY2UgY2Fwcy4N
Cj5kZXZpY2UgY2FwcyB3YXkgaXMgc3RpbGwgdXNlZCBiZWNhdXNlIGF0IHZmaW8gYXR0YWNoIHdl
IGFyZW4ndCB5ZXQgd2l0aA0KPmEgZnVsbHkgaW5pdGlhbGl6ZWQgbWlncmF0aW9uIHN0YXRlLg0K
PiogQWRvcHQgZXJyb3IgcHJvcGFnYXRpb24gaW4gcXVlcnksc2V0IGRpcnR5IHRyYWNraW5nDQo+
KiBNaXNjIGltcHJvdmVtZW50cyBvdmVyYWxsIGJyb2FkbHkgYW5kIEF2aWhhaQ0KPiogRHJvcCBo
dWdlcGFnZXMgYXMgaXQncyBhIGJpdCB1bnJlbGF0ZWQ7IEkgY2FuIHB1cnN1ZSB0aGF0IHBhdGNo
DQo+KiBzZXBhcmF0ZWx5LiBUaGUgbWFpbiBtb3RpdmF0aW9uIGlzIHRvIHByb3ZpZGUgYSB3YXkg
dG8gdGVzdA0KPndpdGhvdXQgaHVnZXBhZ2VzIHNpbWlsYXIgdG8gd2hhdCB2ZmlvX3R5cGUxX2lv
bW11LmRpc2FibGVfaHVnZXBhZ2VzPTENCj5kb2VzLg0KPg0KPkNoYW5nZXMgc2luY2UgUkZDdjFb
Ml06DQo+KiBSZW1vdmUgaW50ZWwvYW1kIGRpcnR5IHRyYWNraW5nIGVtdWxhdGlvbiBlbmFibGlu
Zw0KPiogUmVtb3ZlIHRoZSBkaXJ0eXJhdGUgaW1wcm92ZW1lbnQgZm9yIFZGL0lPTU1VIGRpcnR5
IHRyYWNraW5nDQo+W1dpbGwgcHVyc3VlIHRoZXNlIHR3byBpbiBzZXBhcmF0ZSBzZXJpZXNdDQo+
KiBJbnRyb2R1Y2UgYXV0byBkb21haW5zIHN1cHBvcnQNCj4qIEVuZm9yY2UgZGlydHkgdHJhY2tp
bmcgZm9sbG93aW5nIHRoZSBJT01NVUZEIFVBUEkgZm9yIHRoaXMNCj4qIEFkZCBzdXBwb3J0IGZv
ciB0b2dnbGluZyBodWdlcGFnZXMgaW4gSU9NTVVGRA0KPiogQXV0byBlbmFibGUgc3VwcG9ydCB3
aGVuIFZGIHN1cHBvcnRzIG1pZ3JhdGlvbiB0byB1c2UgSU9NTVUNCj53aGVuIGl0IGRvZXNuJ3Qg
aGF2ZSBWRiBkaXJ0eSB0cmFja2luZw0KPiogQWRkIGEgcGFyYW1ldGVyIHRvIHRvZ2dsZSBWRiBk
aXJ0eSB0cmFja2luZw0KPg0KPlswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVs
LzIwMjQwMjAxMDcyODE4LjMyNzkzMC0xLQ0KPnpoZW56aG9uZy5kdWFuQGludGVsLmNvbS8NCj5b
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MDIwMTA3MjgxOC4zMjc5
MzAtMTAtDQo+emhlbnpob25nLmR1YW5AaW50ZWwuY29tLw0KPlsyXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9xZW11LWRldmVsLzIwMjIwNDI4MjExMzUxLjM4OTctMS0NCj5qb2FvLm0ubWFydGlu
c0BvcmFjbGUuY29tLw0KPlszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIw
MjMwNjIyMjE0ODQ1LjM5ODAtMS0NCj5qb2FvLm0ubWFydGluc0BvcmFjbGUuY29tLw0KPls0XSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQwMjEyMTM1NjQzLjU4NTgtMS0N
Cj5qb2FvLm0ubWFydGluc0BvcmFjbGUuY29tLw0KPls1XSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjQwNzA4MTQzNDIwLjE2OTUzLTEtDQo+am9hby5tLm1hcnRpbnNAb3Jh
Y2xlLmNvbS8NCj4NCj5Kb2FvIE1hcnRpbnMgKDEyKToNCj4gIHZmaW8vcGNpOiBFeHRyYWN0IG1k
ZXYgY2hlY2sgaW50byBhbiBoZWxwZXINCj4gIHZmaW8vaW9tbXVmZDogRG9uJ3QgaW5pdGlhbGl6
ZSBub3Igc2V0IGEgSE9TVF9JT01NVV9ERVZJQ0Ugd2l0aCBtZGV2DQo+ICBiYWNrZW5kcy9pb21t
dWZkOiBFeHRlbmQgaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbygpIHRvIGZldGNoDQo+
SFcNCj4gICAgY2FwYWJpbGl0aWVzDQo+ICB2ZmlvL2lvbW11ZmQ6IFJldHVybiBlcnJubyBpbiBp
b21tdWZkX2NkZXZfYXR0YWNoX2lvYXNfaHdwdCgpDQo+ICB2ZmlvL2lvbW11ZmQ6IEludHJvZHVj
ZSBhdXRvIGRvbWFpbiBjcmVhdGlvbg0KPiAgdmZpby97aW9tbXVmZCxjb250YWluZXJ9OiBSZW1v
dmUgY2Fwczo6YXdfYml0cw0KPiAgdmZpby97aW9tbXVmZCxjb250YWluZXJ9OiBJbml0aWFsaXpl
IEhvc3RJT01NVURldmljZUNhcHMgZHVyaW5nDQo+ICAgIGF0dGFjaF9kZXZpY2UoKQ0KPiAgdmZp
by9pb21tdWZkOiBQcm9iZSBhbmQgcmVxdWVzdCBod3B0IGRpcnR5IHRyYWNraW5nIGNhcGFiaWxp
dHkNCj4gIHZmaW8vaW9tbXVmZDogSW1wbGVtZW50IFZGSU9JT01NVUNsYXNzOjpzZXRfZGlydHlf
dHJhY2tpbmcgc3VwcG9ydA0KPiAgdmZpby9pb21tdWZkOiBJbXBsZW1lbnQgVkZJT0lPTU1VQ2xh
c3M6OnF1ZXJ5X2RpcnR5X2JpdG1hcCBzdXBwb3J0DQo+ICB2ZmlvL21pZ3JhdGlvbjogRG9uJ3Qg
YmxvY2sgbWlncmF0aW9uIGRldmljZSBkaXJ0eSB0cmFja2luZyBpcw0KPiAgICB1bnN1cHBvcnRl
ZA0KPiAgdmZpby9jb21tb246IEFsbG93IGRpc2FibGluZyBkZXZpY2UgZGlydHkgcGFnZSB0cmFj
a2luZw0KPg0KPiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCAgICAgIHwgIDEzICsrKw0K
PiBpbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oIHwgICAyICstDQo+IGluY2x1ZGUv
c3lzZW11L2lvbW11ZmQuaCAgICAgICAgICAgfCAgMTQgKystDQo+IGJhY2tlbmRzL2lvbW11ZmQu
YyAgICAgICAgICAgICAgICAgfCAgODkgKysrKysrKysrKysrKystDQo+IGh3L3ZmaW8vY29tbW9u
LmMgICAgICAgICAgICAgICAgICAgfCAgMTcgKy0tDQo+IGh3L3ZmaW8vY29udGFpbmVyLmMgICAg
ICAgICAgICAgICAgfCAgMTEgKy0NCj4gaHcvdmZpby9oZWxwZXJzLmMgICAgICAgICAgICAgICAg
ICB8ICAxOCArKysNCj4gaHcvdmZpby9pb21tdWZkLmMgICAgICAgICAgICAgICAgICB8IDE3OCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiBody92ZmlvL21pZ3JhdGlvbi5jICAgICAg
ICAgICAgICAgIHwgICA0ICstDQo+IGh3L3ZmaW8vcGNpLmMgICAgICAgICAgICAgICAgICAgICAg
fCAgMjIgKystLQ0KPiBiYWNrZW5kcy90cmFjZS1ldmVudHMgICAgICAgICAgICAgIHwgICAzICsN
Cj4gMTEgZmlsZXMgY2hhbmdlZCwgMzM5IGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQ0K
Pg0KPi0tDQo+Mi4xNy4yDQoNCg==

