Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA51D25030
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 02:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf7jn-0007Ve-CR; Sun, 11 Jan 2026 21:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vf7jl-0007VE-Pm; Sun, 11 Jan 2026 21:32:57 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vf7jj-0001nK-QR; Sun, 11 Jan 2026 21:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768185176; x=1799721176;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4IVnfFuY1EcdJ3OrNoNvBlJvv0AAJ+rYJrxlwNw5rNc=;
 b=dBadASby4imxhf+r5T4DPwwyB6WSTZYxLtCOnARLiEW0zmT5jAAY3h/I
 +b0T9Lh7Dk+VMCQN9ubRv1KT+I9wkYOePYhB1XJv2c/HLEiNWx+dwVMHG
 bidG5h5eUR/aDL9nubjsDRa2F5S+BVhICjWpppF54GGE5ZhuikYLRidIk
 ggotoEEUIceTzhzPK/yzKMB2NsUjQYqSYwUMBFn7MULTxqBXDyQEVAOUy
 7xZqoksEwuUrhQ8K+YORuo22M0j7DPEHGsWCr1H4A+jg0MNRzjEns7Hyi
 iI0/FPAJEwJ1khz6pJJVthfsy3JBP/krL+1eLhJsS9AgpLtHz8gXCyzpk w==;
X-CSE-ConnectionGUID: 1OYKiifDT7+4e2CX68hqcw==
X-CSE-MsgGUID: FLM4Nwa7QKO2gakkGGWNzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="94935728"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="94935728"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2026 18:32:51 -0800
X-CSE-ConnectionGUID: 1Tl1utD/T2CoyNXzs4bRuQ==
X-CSE-MsgGUID: sI4RlkGGT9y7kvuZdCXH+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="203880241"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2026 18:32:51 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 18:32:50 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 11 Jan 2026 18:32:50 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 18:32:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPWCVkXYE2ZLZ6GJjV4awlR0LL9LBKSotQpYyiEE1LTax2KBpKCp416gD47IEc+pqScHBp/OLA3R9TDxdmsf5Eu9sepnOvK+TJcn861tvraXPNvXGr+OlvXG86QmFTJxnpkMecjIw9XD1orzmBmZUmp7L4wRvs58FXHw8aHEa58oHbmy0rUsFIfS/7mHN8FAq5Sv0jxbXyFk7bqz5fMz3gWzId2U1PVMafBamBvUDtQLNBzpfc4zYOSy/HO9UDUeSR2T9KOflI+GsiFTPLiQ2GAfyeMCeOwSUNHw4mmnc/Kx65b5eGmjybLcOzDlbrCUtt+p8+v/dXV8up/gDNKW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IVnfFuY1EcdJ3OrNoNvBlJvv0AAJ+rYJrxlwNw5rNc=;
 b=NKUtyKF3QdNRci5PYiXuIha83GkKffWanKjk6ko8jWaaJSK/7PIzGlzy20GJoyI6qpX8v+FCO17SYQHIdkcDI2qzgQoJoLkEWCo3fqbqepzZouXT09j8UjyeHt6uz4RfgLCtmas/6pE4Y2ECeOw2qc840HRlGKI4JBC9dJs0+Wa6QD1af5tlQ9UwzikKL7t/R+qsgOj56lZ/IdU5i2dF8odMrLfmeWCGCMTjPGOmIQIQBJsGQJ9UV5jM/vPLWqlGNiMx/Q41L5uIgcBmLWqt+ESJjxAF1mZSk9xz/itWxXovxbhetBvdoIno7NLaPTekc/VKMf15Tmgp9l8q2EiKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB6897.namprd11.prod.outlook.com (2603:10b6:806:2a5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 02:32:48 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 02:32:48 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcgIL1GDCpLYnc30ilWHbwOoJZ/bVIHDeAgAF7AACAAE7PgIAD728w
Date: Mon, 12 Jan 2026 02:32:48 +0000
Message-ID: <IA3PR11MB913696E604E31C678F7083979281A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
 <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB9136783B1EC050DB8B655A2A9282A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB75487D6B81B1C6556E044B6EAB82A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB75487D6B81B1C6556E044B6EAB82A@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB6897:EE_
x-ms-office365-filtering-correlation-id: 1bef78db-83c5-4a15-5356-08de5182e043
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?RTIrZUtDOVVISGZXaGNhVGV5dDFpVVdpaElpby9RdEtGa0RuaEdhZy94Z0dI?=
 =?utf-8?B?MzhVcC8xUTYvU3I4SEtBa0syeldOeVk5UnB5Zk5ZdmdzTXhKbkZBb1BYNVJx?=
 =?utf-8?B?aEQvV0lvMDRpTnQvZ1o1NVdwa01aaXNFS2lhZ3JLRHJSQ05sSm9WZTVwU3dY?=
 =?utf-8?B?UzMvalBKV2dzaDhnK3BtQmhaMDhXaTY3SzlDMktPMUxCRTZIc2RhSzVldHhu?=
 =?utf-8?B?d1kzdDRtMUtuTCtYMEdxMCt1RnBOTzIwSmJLTmlYelhvZW9ETzRac0JzWkxI?=
 =?utf-8?B?dDA4T2VHeXFxR3ZWWE0zdmxEVFR0Yll6eTJ5K215cmd6aUtGVVlRLzh2Uisx?=
 =?utf-8?B?bGxoa3MwTGVmZWxYajNYZlUrRitKQ3ZmVFkrOTc1RnpjYVdyd0NHUFBRaWNa?=
 =?utf-8?B?MUpqaDZxay9WZTFVM0gzdkh2aDVhODd5b1NxL1JYTW5RVEt5L3IyM0hTdE1N?=
 =?utf-8?B?WC9aVVVLajM0TjBuOHM4RzNQT3pqUzdhb0FYSlgxWFRiQzZIbk42eGw1WWo3?=
 =?utf-8?B?S0dacjVhNStrZFlQYngzMzZyR2pBTnl4dFhickM0N3ZiMEZrUnc0VU5ONWxo?=
 =?utf-8?B?SVJtWE9UYXVtNGE5NDRDeFROVXFKWVp1amtiRjFsVkpNQnM4QW5wdE5lc29r?=
 =?utf-8?B?YnNVYjdvSGtBQU5XZStmb1EzZmkxckR6MExnOXNPVE5kRnNxWDh5dDdZeGZR?=
 =?utf-8?B?WE1DWVEwckZxWk1xT25Ja1k5WjNFeWNRM2pOU0VJV2JGeHNGK2IxR0ZCci8w?=
 =?utf-8?B?cWhiMFRGb0RseVVWYnNYcmxvNmgzb005d1BRaDBZcmNZVUlPUEhNdFdCQWVT?=
 =?utf-8?B?ZjZjYnlrS3JVMGcrZTNpeW1TdFRGdmphdEo2dFo1bTlMWUU2WC8ySWM3R2My?=
 =?utf-8?B?NHZSbC9IbEt3ZFBBQldwK25NSDNNeDVJQU45aitaRTZxMWdmSmR1Q0IxWEs5?=
 =?utf-8?B?Sm9HbWtnSEREUlRTa2JkdXZzcG5UUVdBdTRPWnppWHFzeE5hNFhQQ1M3c25j?=
 =?utf-8?B?RmJEd0dQTjZIc3FGWXFuajZqcm5vYTdqM3BKUk9NREZmZElSUmJqZXJKUVpk?=
 =?utf-8?B?OWJFMmRRNkJUZGVGV3czZkM4Vmh5TThUS0p2dUVQdXJUN2FER0laWk04UC9C?=
 =?utf-8?B?c25DYVFkZjdqeTV3SXppM3l4WGhTL3hac1VKVnNwRGZKM2RQOEZoeUhZbmRl?=
 =?utf-8?B?b2RseEROMDBTSlFMR3VTT1ZHd1NUQ1A2OWlGVlZYY2hzZVlyVjE0em1MOXdo?=
 =?utf-8?B?azFGTTNtNTRUenFRd0lIbmhVY2xEcGlwWXZjVms3WWRFZVVKYlRUcyt1elk4?=
 =?utf-8?B?MzRyOFd5SlpqRmV5aXVaQWFIdy9OMVZ3K1VFVmFBY1J2b1Z0bWtXS3NabkJp?=
 =?utf-8?B?b2dSSVh4SkFMSWY3VmhQSVA5Qis2alFBMGtLRUVUbVIyQVYrRVQzMitjNHR0?=
 =?utf-8?B?WWwzeDNMUVBBc2NLYjMxZWwyWEFQOGxkcU1OOXZLMnJzaU9UMnIvT1NoZEdu?=
 =?utf-8?B?TDRwTlhuSnNYdzVaOFVjTlFWVkk0WFh2TnkyOTFOTUl1dzhmb1k3WGkvK2ll?=
 =?utf-8?B?dDFmZkU0SG05R2dEQ3RpWEJ6K24wemJ5VmZmRnBtQldCcHFpdTQrNUcyWnBR?=
 =?utf-8?B?cEoxRmNNSnJ5U2tWQksrS216K0V5NEF5c1NiMWZrQUxqSGNhV05YRGw4TWE2?=
 =?utf-8?B?eC9HamNnVGtqY05HcnVwa084MW5Ud2kxUGNCTkdGaDl3UVRvendkdnJxcTYv?=
 =?utf-8?B?dUlEMVN5UkM1WFZIMnNieUZ2WHdPNVlwdytXc0FaNGRMdjNRSEpzV0ZTanFt?=
 =?utf-8?B?ZWduc3BFT2VnNUY4ZllKZitLL3Nsa285OFNINFd5Qk1RUklUWVZFOTFORlU2?=
 =?utf-8?B?U2RxVEJRVkx1YksyR3Bia2pBT1hUN1YrOXhZNVI2NE9xTnRxbjBhZXZucjBI?=
 =?utf-8?B?NnBYZnVFMkYwa3RjVS9qaFFFVUVLSldqSXR1Uk1GTlZaWkE4RmpkMUc1R3Fp?=
 =?utf-8?B?REIvcWYzV2xZbjNJUEFvVUFwVTFHN0w1NWpqUzV3YUhKTTN6aU1lQXBUYXZu?=
 =?utf-8?Q?h7fFTb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHRYNWVxWlJYQjhQNkt1amdEN0JwaHlBc1B1MTdRQ3c1SnNEQlRaU1M0Ri83?=
 =?utf-8?B?dnlXQi9EK2xVbFFOdjNpQWh2SkxqaUV5M090ZWc1Ynlaa0RlWGlaVkNpandp?=
 =?utf-8?B?WjZsam5SdytvQ1p1VmNjUnJHUTlZVzNxNjVtSlRDc0ZPUFZnYW1ZckJnUDZQ?=
 =?utf-8?B?YSt1UjJSY3FYanQxckRwdGE5TmRMMVpFYmRKUW1QQWVIdVBwVlNOcHZXa2Ji?=
 =?utf-8?B?eUJUM24xR2hJWWVRelM4NWxENG82bkV5ZjNtVDk3cGRkclArc1JjbGJwWW1j?=
 =?utf-8?B?NXlaZEZIbGtwdnp6K2hHZE16TDdNdm1BK1FFSXd0RllUVFB1aTNQVmh3MjZM?=
 =?utf-8?B?S1BMbGwrREIyZkFja0gwWkNrd0JoVEVtaWQ0K1hNUEFyK2E1elEwYXNCRWx0?=
 =?utf-8?B?NmQ1KzZIejY1ZnBDcWZnQXZmbnZ2UnRYUC9XT2hXMXFhbnZ4ci94UTZZRDdr?=
 =?utf-8?B?MDREaGRJS2VYTFByVWxoTzRZcUR6NGZXd0VEbEpqd3I3UjJ5aGIrLzJxWHRF?=
 =?utf-8?B?a0lkZGh6eGJzVmlCVC9SeTMyUll5NXdtZkxHSnZEOXhqd1BwSUxSdTlid01w?=
 =?utf-8?B?b2I4MTB2Z2J0cmxNOWQ3M3JDSDB3WWJYREVqUlk2emxzOWFlUXRhL3cxZXVu?=
 =?utf-8?B?dmFXMXpiOS9pbkt1U21ieTZMYzFldkJuN204eHVCZnZmN1RMZE1JdnlXdTdB?=
 =?utf-8?B?YmVDaG5QZHMxVmk1MDhKVGZsRnpUc2xsbDh4NlB3TWZQUS9lRHlMZzNCZnVE?=
 =?utf-8?B?ZGlKZU5Rbm1yNkZYbGFlT2h2a24zU2cxZ21VV1RQMWJ2TExKTVhOdHRZR0U4?=
 =?utf-8?B?enF6ekRiZjRjQ2pDejRvNkpUbXQ1bmFWU2VGWDVUcjZYbnpaalZ3RkNTQ29T?=
 =?utf-8?B?eEFqVm5XTDA4STdRaGxOZE1uNVAyelpzOWF2Y2FZYkdQWFRDZDdsMUJxdkFQ?=
 =?utf-8?B?SEpnZjViYmVweFRDS3VOdmlxVElmSEgzS1RnanpMSUlOZWZnbGc4QW1kczN5?=
 =?utf-8?B?QTlGemJPcU9BTG9yMWt1bFJVaWRsWU1lMnQ0cXBYbEpTM2VIcFcwa3hmWEp6?=
 =?utf-8?B?MEVVcWFBZHoxM0o0M3pLM2VRMTdwcCs4emszUC8zSkhKUS9xUDdaRFJEQWlP?=
 =?utf-8?B?MkhieWF2ek9yR1IzcUF2WE84WDNCdUxWSjVUS2RFd2dRLytYM1Z3NXIxTlNQ?=
 =?utf-8?B?WFhteDI4ZTlmUmExdk44TERkUEx4YzRuaElJNGRLblZZcTAxSzRtandnc0Nj?=
 =?utf-8?B?ZkxlaG1UQm90NkFJay9MakNSeUpZMVhSYXI1bFh4WkQ5L1AzQUlGUDVGR2xh?=
 =?utf-8?B?SlRVQXRkTXVkT2t6K3JqRjhmajh6TXpJTGV1RDNZay9CQjlYRUVsNHptdTY0?=
 =?utf-8?B?YUlJTWJDT3pJeVgrc3lMb3BMYXBVQVlrblNaS0YwTWRDL0dnd0wwMDdGb2Ra?=
 =?utf-8?B?c243TmpWbXNHMUxNT0Q4aldMdzFpMDBsdDd1ZUZOdUE3azJ2S0NUSlpXbFI0?=
 =?utf-8?B?R210V0V5cDhhZWFkdWpPbHpyY1V1NVY0UE8yWnptbCtQVDR0ZXJXcm43Sk5B?=
 =?utf-8?B?YmlhcG9RVkRuM0pRQnI5WGUwTUhUWkNUTkhuUjFwdXNLOW5XU2NRY3hlOVNv?=
 =?utf-8?B?eUhoT3RtUVZFUzNjYmhrbWM2MUhSTEVCdktNZTBGNVE5V09MOUZsZk1mS0tj?=
 =?utf-8?B?TkpwZ2NZcHZNZ013WkQ5Y3VDNnRpVUZyc3dUMVNvSitEYzF6SmdkNDZCUzQw?=
 =?utf-8?B?U09vZmpkam4xOGRuWkUrczd4MjBpY2Y2K3VKdmhUaUJabmpKUlU3a2FhbVlJ?=
 =?utf-8?B?WjA4QjNzL05GZW02b2plQUo0V2ZXMWFpc0NGRzNwUHpObFlLVGZxY0VTWldC?=
 =?utf-8?B?SHJiZEhWLzlnRUZuQ0EvMnRJZEo1S3V5cFZvTDF2VDU1cXdEb010OXYwNllN?=
 =?utf-8?B?K3RRamZKcFZDdzhEUE1SSWhpZUF3a2p3emIxYWFQMGg1bitCZE1LWk9ib0xO?=
 =?utf-8?B?TW9FaFVlZHB0ckFUMGhPME5UZ2UxS0JUWk9vMnBNQWpSVTgzNmRRbnFMVlBm?=
 =?utf-8?B?YmE5U3JiK1JLdHpOb21UbFNvdmZnN2lsUXZoU3VsampHd2QyR3NORWdBUGFP?=
 =?utf-8?B?cEUrVDF6eStRSkhlZC9BaGl3MHNkNzd0Z2l5TlFuZUN1SHByYS9sOUI2THhj?=
 =?utf-8?B?RlFQazJOaUhEUHVwcVBjWkgxakJwWGk1cVZ4SXBCazBOZGFYSldrNk1CekI1?=
 =?utf-8?B?S3lEWHh6SG10RmQ2aDdtSXBMS3g0RlhOaktsMWhJRXJ0d216MFhaYkZCZmQ0?=
 =?utf-8?B?RTlhVDU3aXErZ2pLVEZTQ3BweHpQcEZMazdyVi9vOVNIKzY3bG1CUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bef78db-83c5-4a15-5356-08de5182e043
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 02:32:48.3089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +MR2QccAMTwzWeeG4h5S/2xEoGWrcvWPSosUzgCUi1XfPUJsMfG2pp52TVE15rJFERNJTaR3ZKHQIoGwiaaE8M1QkG8Zc+DXjvbL8Q88Zw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6897
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pj4gPj4gPiBAQCAtMzA1LDYgKzM0NSwyMSBAQCBpbnQgdmZpb19yZWdpb25fbW1hcChWRklPUmVn
aW9uICpyZWdpb24pDQo+PiA+PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
Z2lvbi0+bW1hcHNbaV0uc2l6ZSAtIDEpOw0KPj4gPj4gPiAgICAgICB9DQo+PiA+PiA+DQo+PiA+
PiA+ICsgICAgcmV0ID0gdmZpb19yZWdpb25fY3JlYXRlX2RtYV9idWYocmVnaW9uKTsNCj4+ID4+
ID4gKyAgICBpZiAocmV0IDwgMCkgew0KPj4gPj4gPiArICAgICAgICBpZiAocmV0ID09IC1FTk9U
VFkpIHsNCj4+ID4+ID4gKyAgICAgICAgICAgIHdhcm5fcmVwb3J0X29uY2UoIlZGSU8gZG1hYnVm
IG5vdCBzdXBwb3J0ZWQgaW4NCj4+ID5rZXJuZWwiKTsNCj4+ID4+ID4gKyAgICAgICAgfSBlbHNl
IHsNCj4+ID4+ID4gKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiJXM6IGZhaWxlZCB0byBjcmVh
dGUgZG1hYnVmOiAlcyIsDQo+PiA+PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgbWVtb3J5
X3JlZ2lvbl9uYW1lKHJlZ2lvbi0+bWVtKSwNCj4+ID5zdHJlcnJvcihlcnJubykpOw0KPj4gPj4g
PiArICAgICAgICB9DQo+PiA+PiA+ICsgICAgfSBlbHNlIHsNCj4+ID4+ID4gKyAgICAgICAgTWVt
b3J5UmVnaW9uICptciA9ICZyZWdpb24tPm1tYXBzWzBdLm1lbTsNCj4+ID4+DQo+PiA+PiBEbyB3
ZSBuZWVkIHRvIHN1cHBvcnQgcmVnaW9uLT5tbWFwc1sxXT8NCj4+ID4NCj4+ID5NeSB1bmRlcnN0
YW5kaW5nIGlzIGFsbCByZWdpb24tPm1tYXBzW10gZW50cmllcyBmb3IgYSBWRklPIHJlZ2lvbiBz
aGFyZQ0KPj4gPnRoZSBzYW1lIFJBTUJsb2NrLiBBbmQgdGhlIGtlcm5lbCByZXR1cm5zIGEgc2lu
Z2xlIGRtYWJ1ZiBmZCBwZXINCj4+ID5yZWdpb24sIG5vdCBwZXIgc3VicmFuZ2UuDQo+Pg0KPj4g
Tm90IGdldCwgY2FuIFJBTUJsb2NrIGhhdmUgaG9sZXM/DQo+DQo+WWVzLCBhIFJBTUJsb2NrIGNh
biBlZmZlY3RpdmVseSBoYXZlIGhvbGVzLCBidXQgaW4gdGhpcyBjb250ZXh0DQo+dGhhdCBpcyBu
b3Qgd2hhdCBpcyBoYXBwZW5pbmcuDQo+DQo+SUlVQywgZm9yIGEgVkZJTyBQQ0kgQkFSIHJlZ2lv
biwgYWxsIHJlZ2lvbi0+bW1hcHNbXSBlbnRyaWVzDQo+Y29ycmVzcG9uZCB0byBzdWJyYW5nZXMg
b2YgdGhlIHNhbWUgQkFSIGFuZCBhcmUgYmFja2VkIGJ5IHRoZQ0KPnNhbWUgTWVtb3J5UmVnaW9u
IGFuZCB0aGVyZWZvcmUgdGhlIHNhbWUgUkFNQmxvY2suIFRoZSBzcGFyc2UNCj5tbWFwIGxheW91
dCAobnJfbW1hcHMgPiAxKSBleGlzdHMgdG8gZGVzY3JpYmUgd2hpY2ggcGFydHMgb2YgdGhlDQo+
QkFSIGFyZSBtYXBwYWJsZSwgbm90IHRvIHJlcHJlc2VudCBkaXN0aW5jdCBiYWNraW5nIG1lbW9y
eSBvYmplY3RzLg0KPg0KPlNvIHdoaWxlIHNwYXJzZSByZWdpb25zIG1heSBsb29rIGxpa2UgImhv
bGVzIiBhdCB0aGUgbW1hcCBsZXZlbCwgdGhlcmUNCj5hcmUgbm8gaG9sZXMgaW4gdGhlIFJBTUJs
b2NrIGFic3RyYWN0aW9uIGl0c2VsZi4gQWxsIHJlZ2lvbi0+bW1hcHNbXQ0KPmVudHJpZXMgc2hh
cmUgdGhlIHNhbWUgUkFNQmxvY2ssIHdoaWNoIGlzIHdoeSBhdHRhY2hpbmcgdGhlIHJldHVybmVk
DQo+ZG1hYnVmIGZkIHRvIHJlZ2lvbi0+bW1hcHNbMF0ubWVtLnJhbV9ibG9jayBpcyBzdWZmaWNp
ZW50LCBJIHRoaW5rLg0KPg0KPkhvd2V2ZXIsIHBvc3NpYmxlIEkgbWF5IGJlIG1pc3NpbmcgdGhl
IGNhc2UgeW91IGFyZSBjb25jZXJuZWQgYWJvdXQgaGVyZS4NCj5QbGVhc2UgbGV0IG1lIGtub3cu
DQoNCkkgc2VlIG1lbW9yeV9yZWdpb25faW5pdF9yYW1fZGV2aWNlX3B0cigpIGlzIGNhbGxlZCBm
b3IgZWFjaCByZWdpb24tPm1tYXBzW3hdLm1lbSwNCmFuZCBSQU1CbG9jayBpcyBhbGxvY2F0ZWQg
aW4gZWFjaCBjYWxsLg0KSUlVQywgd2Ugc2hvdWxkIHNldCBmZCBhbmQgZmRfb2Zmc2V0IGluIGVh
Y2ggUkFNQmxvY2suDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

