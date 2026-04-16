Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E04AF433D4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBpx-0007RQ-0r; Wed, 15 Apr 2026 21:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wDBpv-0007RF-19
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:48:07 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wDBpr-0006j0-5D
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776304081; x=1807840081;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=trZK6iewbHp1pzIgDJ4HFlxoIzd7iFScD/YkvbUpnE8=;
 b=idz+fonwyulMjClzdjVKS7pz0Kkf82B069/Pj5ORqtjliB0GoqabDUoI
 VvNVe9JaMBIj0wrQuFzaxi52HzJ4wAyF7+crpf7PCZroPuWB24FKnrcTH
 fMlJ0FjWIRRAzWWhGLM7xx5C3NZJPCc2XwA9+Tkk98o4+zLkNWeb2simP
 m8D8tb5sAhbJYQBbvZMDxOaEFZan5NJ68t6dGDvojXpMiIauFeUA5sCi2
 zp6ssJBmHfW44k9TqfkI0R/lZWXXksI3k/2tsg9/X4IJGqB7gZ8M4CDp/
 3Mcn7A/cCYSdn7NotTsfNq8E3zAbirmW5ZcOTUnpqa74dicwISrolcRwr g==;
X-CSE-ConnectionGUID: o9M+1w7XQPOeEk7cttaM9A==
X-CSE-MsgGUID: Ldk8L3ytSmOCMuYaKpitqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="94865290"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="94865290"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 18:47:56 -0700
X-CSE-ConnectionGUID: WeFH/ZpaSz2RyY4EEQNUug==
X-CSE-MsgGUID: VjtU+GBgT2KiyF6z8XgcjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="230824518"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 18:47:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 18:47:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 18:47:57 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 18:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2w1JfgsAGafHKYEQsT/NBw/nPmz4qCdtAHt+2/G/7llSqvuFp5eEhHJQ6OW5fIoRNegP9b2v3rfl10Vfjl9TXq8VIWA0dLh4+TTonRXDBYYpNtqOM/KfPcxRUSvYJr0AQwOMw2lflVScG55LAw41CjxMeEc67ygA8+91D3Vrwk3NImVuylt53CXgXJKZMXK7CsjCIox6Zs/ZGIP4Ki3e0QYKJ8OANkLuA7kN4huDsUZ1CvydJKboyU6betN2UlsNbNdeuEzEAxw1PxrQfpZrtL79ExH7yD93tHf7vOejk+wDoanhMKxBupIy+fM4ZHZtk/3EsAiRWnUsF/E8NuKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trZK6iewbHp1pzIgDJ4HFlxoIzd7iFScD/YkvbUpnE8=;
 b=HlttdCB+uez428hY38aH9QB+eCxzpmw8MTIWzRhFsNDAseaJsB7S51HnhTvjoQrNu7zaat/pii/dkDTRwno2OPgomJ5Pb6XzsqSqHI8hWs2et05K+WqJoviv3z5n7q6sS2cCwvj/RXEokhKUnPjOUcVZcjI9cIvbyKFj9kIZGC8GksTo/+4cJOEXal6WmUy94zQOd4yUXPdmm68cS37+AqEASBqZYf/8Vv8mZ3Gz/KrVY47bnvBIYj+5VcNzZ8jGjvnyvNISkZ/fkI8v7B+pS/YXQFm4gUcRU8rNT4JAiBgWtXxN7Yu4MYAw8QdWovrW175wntbZqXrDOxnMOZDtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB8685.namprd11.prod.outlook.com (2603:10b6:8:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:47:51 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Thu, 16 Apr 2026
 01:47:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: RE: [PATCH] intel_iommu: Re-expose VTD_ECAP_PT
Thread-Topic: [PATCH] intel_iommu: Re-expose VTD_ECAP_PT
Thread-Index: AQHczL54bfuYgfL9lUCDi0QGrCdERrXgFy2AgADVOIA=
Date: Thu, 16 Apr 2026 01:47:50 +0000
Message-ID: <IA3PR11MB9136DA7E04C3BA29BE1F5F6092232@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260415095832.9631-1-zhenzhong.duan@intel.com>
 <6fd7a51125963dabe9e9b3732e2ece5086b666d6.camel@bull.com>
In-Reply-To: <6fd7a51125963dabe9e9b3732e2ece5086b666d6.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB8685:EE_
x-ms-office365-filtering-correlation-id: 07416895-ccf5-4367-a77e-08de9b5a2b58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 5dik2KAaf/hmptczsQh0mr+pw/HdyVeDwPky1KBcdB2c8hxDjuSSXq54gXOsVp4gis4+eBeN4EHEv3a+3TMKtH/5YF6cnYEfBe284r5hXt9PgwMbO+fLYerWizhUrzaZBYstcogWBy/+aaMWVlXXOgKBseQP9zitEhRJO/ALj/aNn5QIEY2mgpu1SYHaMJiQjjqzh5ikjG7ugMgqSXCWpOfkzIKRgoN2Iaeyit/6JwrKjMQvtE3vh5e4qYFW9zjD4SsN973TDTiI4vHacZlwvIWqBo4NIDp00dyiPVnmQDVCk3a6rWiYoDqRqO4zXA6tvsS5zgGjHpRT1E0ghJhdkC/NR3sfj8kTQ1bCYEUgi34pJGHU0rvHX0N4yYw/hhy03yxYiHpwm+yQTaRrnhWdpcUr2AdZ6AGQbrJ7mDqtlNG6jAw/N6ST1Ssddy+EppswjBCDciYDOODscT9iQyzosU8d1YN052aw3AKNqjTSTSuEOiXOoV6rem9x8ixDGDpmfWDjyAGaLv6MUPbtreUH9/eY6BHFqfRBH1jWfg9+34etRaDWqlB7IwcCELAfhV4+dG5uE/xxzKXjWsZ9CtI15hGrqhipwiuWvMbHyLiHN4sdL9FWCm4vaDb0vMjAYuc9ax2O9rAYUGemxFLUMuIVBn2BRu9HK+JVPtI6oKZigBThDu1On6x97+gtuP7fgL7DezxxRUq/x6wHec2e15oE1ZpyxTupZwcCop7pvqumLKkVcCMw3QxUU4zY1uSdlJq4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0czRGVSR2RaZThrVXBscXJnRmE3aWJRSjBtVlMxclF5OFNiY295aWZPb0Z1?=
 =?utf-8?B?WUFmQ0lEZmN5L2V4T3BFUnJUUXI1bWUzMEVCTEM2dVFhNnkrcEI4amlleUVD?=
 =?utf-8?B?b3dsdlkvK3M1bXFZQkNKbzZFa1BQaTBMd200cGxqd09lTWVlN3F2TlpLclli?=
 =?utf-8?B?cjNZcllzZW8rMWFwTzBFN012RVNUY04ybERNWVZMM3gvaVQxOFBVeHFVY3h3?=
 =?utf-8?B?WTR2bUc4Z3F6Q2tzeDJwaHlZMHVyOGVod0ZrcEVmWEEzbDhIMGpJa3VvUGpW?=
 =?utf-8?B?U1Z3Unl5VmxkMWlyQnBFWFVvaXJ4MW93eCtKUE41RWQ2R0Y5Mk9RTW43ZW9Z?=
 =?utf-8?B?dUphVG04RXFSWW91bHJ0U09Ndmd4Vkg5Z2l6NzZBQTZtbWFxeFBpeWMwcXJz?=
 =?utf-8?B?SS8yUXhxaUlXQ09MYWNEaVBxYlhxL3VnZHA1NW1WZXZDRG0rTmY3WVZrNHJz?=
 =?utf-8?B?bEdCNWJVZVZRVlRBYWMyaUdyWGt6dVlDaUdVYUduZzNiekdZdHVndnAybE5t?=
 =?utf-8?B?ZFFpb1U4UXNxYzhPVlZ3VGsrb055NVpPWFB5OEpHaFlZanlhcGxvSkVxRy8y?=
 =?utf-8?B?YU5OYlVLVC9SbmZqNlc1bDZMSFJxNkpRcTdRTnlXcmEvNzdsTnVQMWM3NUtq?=
 =?utf-8?B?YzcxMWpUZUVlc2J4NmJrRjN4V2NxUi9yVDZaTWU5bmEvczlxcVpHbTlrNUox?=
 =?utf-8?B?MzFsMHVLZnBuRk9XSmpQVzcrSkhiM1JhUnpTQnBZZHRjSFNETElySXpKOFY3?=
 =?utf-8?B?NEl3cERHQjVkdjhubldYaFJPdTVVektjWnM0d01wOHBJUHdDWHRrbUZLeTdD?=
 =?utf-8?B?QTVsOXhvcEtMcTFDU2RYY3BuT0FXSzY0clBGN21kY0ZOK0o5VmJyZFc0SHBn?=
 =?utf-8?B?NmZMZG9NZSt0YkVOdWhQaGlOTTVZdCtYTlhBUkZYa2hGRWltZ2tIMHFkbkdI?=
 =?utf-8?B?OXp2SUpxNUFmK05aQnNocUVMYUZCWHNXNHdHZWdQaTNORmwzUEZyVFRRY1B2?=
 =?utf-8?B?OTFPMEdaZjg0N2tSWUFOa2hEQTl0ZWkxR1NtUi9lVURQWUFLYmpRVFhBQ1d0?=
 =?utf-8?B?czREZC9DTVBhNldJOGZMUk53TmdqRUEvUVgvRmFPN3ZXVzNKeGx1dkpmMVZV?=
 =?utf-8?B?Y3IyK0xDVS9aV25IWDAvaEgvQ2NyNytSZmoxSmFIVDRoRmN5elhlTXpVdEZ1?=
 =?utf-8?B?Y21RQU5CRVNwSkxENGJsQzFZbEUvdzRSRmdTWGo0bmtSNzROalh6OEd6U1gv?=
 =?utf-8?B?UzllVWEwU2F6V21kN0pZSFRvR2h4M1BsQ2psUmtrSzRLZWh5THYrVTd3Ujgx?=
 =?utf-8?B?Z3dNL0tKVFo2LzhidzF4UDlMalJGUTRLV1R1RzZNZzEvUm5Gbm1aSXJ5QU1w?=
 =?utf-8?B?Y1BURXphRDdJTUEwY2dUOGtUeCtZSFN5MmdHb3Yxd1BScGhHL0hQMGtVMDVK?=
 =?utf-8?B?bTdXSWlWb1FoakRDc1VWbGJnTkM1MFVpNEtObGNibEQwNVcvLzZ5Q3A4eFJI?=
 =?utf-8?B?bUlaL2cxek1MclZFNytIUjRaTTMreDU2RFE0bFRvNG5UbkcvVVh6QmxuN1cy?=
 =?utf-8?B?aDJvUUtoNWo2Y2dSL0FPVWp5Qk5ueGxLeWZ4TGt5SHZIVkF6cHFudGFoMXl1?=
 =?utf-8?B?OXRvZUJQTmgxQUtmczNNWU1KM2lMQmdTWkdsRW4zWGpIVVk4OEZQNnpFcEx3?=
 =?utf-8?B?ZHE0dGZRRkJzNk4vZDM0bVQrVU9vc2dUeHlnN2NaU1hTdFFSeWtld0dTWHFp?=
 =?utf-8?B?aGxrSDh2dUl0NzRBcHA3TDVyOUFGblp1c2o5ZnMrZktFOGs5dlpVWllpQXYz?=
 =?utf-8?B?QS93Q0JZVjlzRHRzQnAyLzZzY1lPaDJDa2hhMTFxeWZJeU5pS1kyRHdycDNZ?=
 =?utf-8?B?S29kSFBNeFRxTFYxUWxqN1B5WkNEZjFocEYzaWZUamxOdnV6YU1JeXExREQr?=
 =?utf-8?B?b0pveTUyUVZRa3FrdjZxa1I3SjZFcGhkYjJ2eU5TR3JEb0hKNVhXNlBnS2VW?=
 =?utf-8?B?TndNbWRpd0tIQ0dhbkhWc1ZhbnBRY2xtK2I4UkVTZS9Xek9xeUdlV2hFSEQr?=
 =?utf-8?B?c3NESUVyenZuQmtDTFhyOExFNXdzbVRuNEVCMUNIVGd6Wmp2RE9aR0t6SVBy?=
 =?utf-8?B?ZTdCbGJRTDFiaFAzbWZndDZOSUpqVkM0UE5YSTZpK1lxSWJDNzI1eTA3ME5H?=
 =?utf-8?B?VHpnMGFzdWJEKzJYLzdwRW1uTXhSdzRnNzR5VFVJVEFIanRkQXZZc0dySGc5?=
 =?utf-8?B?VmVhNzVUTWh1aC9RR3pvRjNxRU9ad0x0MkJWb3dZUDRHWWZxZUhDZlhibEpL?=
 =?utf-8?B?Wm82SE0vYU9SQlFxM3J6b0VwQys1T2puYUpmVjJ4WWswZHB3U3NUUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: I4zOxC6s+oDau447uwRaU6JAFNoO3QyMFYTHcd0j4KM3QtD7GPDiRgUIopmUbmd3GKnDscsrcaPlbbMxTB5epEob7xC6DTvdtXgYgU6/1Bfk3LliVpDguGB88silYQujjB9PX5kraSRcnYUcVXHGv77QPifztNLOm7aCyqhKuMCxEwADnqejMk/TOJdOpnHSo6aGR4E9RpRuANOa5elF5/ve3h8Wi5JO4eexevk/UL9oTYIe8U2J+bArH5y9qRC1bSqrR/zPGZKv91CWUD+Ea5xSY7aGVPTQgEWPIlSBgvbIWZZDKqERm592IEAMJ6aZhP1mXz6ktavpyxft8WMYdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07416895-ccf5-4367-a77e-08de9b5a2b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:47:50.9232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgO6kpJd+2wFQVJS70a5M9y5o+zQrlQu8fzxjduJgd6hRDcfTQHudGVJqsV7mrT4YjjN9n2BTUXoUiyIADe9/UezNo317dY6RPfQD1uaKow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8685
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

T2gsIEkgaGF2ZSBub3QsIHRoYW5rcyBmb3Igc2hhcmluZy4NCg0KPi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+RnJvbTogQ2zDqW1lbnQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1
LS1kcmlmQGJ1bGwuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTUsIDIwMjYgOTowNCBQ
TQ0KPlRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZw0KPkNjOiBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNv
bTsgcGhpbG1kQGxpbmFyby5vcmc7IExpdSwgWWkgTA0KPjx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
U3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IFJlLWV4cG9zZSBWVERfRUNBUF9QVA0K
Pg0KPkhpIFpoZW56aG9uZywNCj4NCj5IYXZlIHlvdSBzZWVuIHRoaXM/DQo+DQo+aHR0cHM6Ly9w
YXRjaGV3Lm9yZy9RRU1VL0NBRkZFMmF2ckhES1pkNW03ajNFM3g1PUY9cHpuLTNjOXZ6R1dQMys5
LQ0KPkFWUHdRbmc3d0BtYWlsLmdtYWlsLmNvbS8NCj4NCj5PbiBXZWQsIDIwMjYtMDQtMTUgYXQg
MDU6NTggLTA0MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQ29tbWl0IGM3YjJlMjJiZDk1
NyBjbGVhcmVkIFZURF9FQ0FQX1BUIGluIGVjYXAgcmVnaXN0ZXIgYW5kIHNldCBQSE1UIGJpdA0K
Pj4gaW4gY2FwIHJlZ2lzdGVyLCBtYWtlcyB2SU9NTVUgcGFzc3Rocm91Z2ggdW5zdXBwb3J0ZWQs
IGZpeCBpdC4NCj4+DQo+PiBGaXhlczogYzdiMmUyMmJkOTU3ICgiaHcvaTM4Ni94ODYtaW9tbXU6
IFJlbW92ZQ0KPlg4NklPTU1VU3RhdGU6OnB0X3N1cHBvcnRlZCBmaWVsZCIpDQo+PiBTaWduZWQt
b2ZmLWJ5OiBaaGVuemhvbmcgRHVhbg0KPjxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXShtYWls
dG86emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4NCj4+IC0tLQ0KPj4gwqBody9pMzg2L2ludGVs
X2lvbW11LmMgfCA2ICsrKy0tLQ0KPj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IGYzOTVmYTI0OGMuLjZiOGY3NWE4
YjYgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTQ5OTgsOCArNDk5OCw4IEBAIHN0YXRpYyB2b2lkIHZ0
ZF9jYXBfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiDCoHsNCj4+IMKgwqDCoMKgIFg4NklP
TU1VU3RhdGUgKng4Nl9pb21tdSA9IFg4Nl9JT01NVV9ERVZJQ0Uocyk7DQo+Pg0KPj4gLcKgwqDC
oCBzLT5jYXAgPSBWVERfQ0FQX0ZSTyB8IFZURF9DQVBfTkZSIHwgVlREX0NBUF9ORCB8IFZURF9F
Q0FQX1BUIHwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVlREX0NBUF9NQU1WIHwgVlRE
X0NBUF9QU0kgfCBWVERfQ0FQX1NTTFBTIHwgVlREX0NBUF9EUkFJTg0KPnwNCj4+ICvCoMKgwqAg
cy0+Y2FwID0gVlREX0NBUF9GUk8gfCBWVERfQ0FQX05GUiB8IFZURF9DQVBfTkQgfCBWVERfQ0FQ
X01BTVYNCj58DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZURF9DQVBfUFNJIHwgVlRE
X0NBUF9TU0xQUyB8IFZURF9DQVBfRFJBSU4gfA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgVlREX0NBUF9FU1JUUFMgfCBWVERfQ0FQX01HQVcocy0+YXdfYml0cyk7DQo+PiDCoMKgwqDC
oCBpZiAoeDg2X2lvbW11LT5kbWFfdHJhbnNsYXRpb24pIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAocy0+YXdfYml0cyA+PSBWVERfSE9TVF9BV18zOUJJVCkgew0KPj4gQEAgLTUw
MDksNyArNTAwOSw3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9jYXBfaW5pdChJbnRlbElPTU1VU3RhdGUg
KnMpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmNhcCB8
PSBWVERfQ0FQX1NBR0FXXzQ4Yml0Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+
IMKgwqDCoMKgIH0NCj4+IC3CoMKgwqAgcy0+ZWNhcCA9IFZURF9FQ0FQX1FJIHwgVlREX0VDQVBf
SVJPOw0KPj4gK8KgwqDCoCBzLT5lY2FwID0gVlREX0VDQVBfUUkgfCBWVERfRUNBUF9JUk8gfCBW
VERfRUNBUF9QVDsNCj4+DQo+PiDCoMKgwqDCoCBpZiAoeDg2X2lvbW11X2lyX3N1cHBvcnRlZCh4
ODZfaW9tbXUpKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgIHMtPmVjYXAgfD0gVlREX0VDQVBfSVIg
fCBWVERfRUNBUF9NSE1WOw0K

