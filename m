Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889A2C48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 00:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfqSs-0008DR-Ae; Thu, 29 Feb 2024 19:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rfqSh-000895-O6
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 19:09:17 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rfqSf-00037d-JX
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 19:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709251754; x=1740787754;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=pXPWBxtvnD7zWVL/qGBOn03/CCaw5VjOaalxjKlHJLM=;
 b=P+lVKcrfilnRPqaUgvriuUY7YxIWQ1YBnye8AJfmxqduo4EWYuMLIlN3
 7qIF3xoZkCzG5+FxDxRCpK/fU+P7zCPALfkNYXRkg+W7rnx6v/F0tK4pO
 8Zr4jOLs/zc80QOsXhHqQuPky/BtZ7t15kg/2cJ1aZ8gaKdew5hWUDMXn
 03r8URksLoT45jrIhjnFvlCgsJOEogdNuf3zS5ceDm0WCgQzav3WplFp+
 C443Kj7MRsEBVmfBNv8q/AWGUTbajTR9hSmh59xdzH+4GiwJHPo8gK7UN
 vkuucyW1IX9Pvhzxq93KgO6Smim1v0c2J7Hxe0uqgWcUJyJHi8subTmzg g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7587103"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7587103"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 16:09:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; d="scan'208";a="12592558"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Feb 2024 16:09:11 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 16:09:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 16:09:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 16:09:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 16:09:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Id9fIMIzO4eb+hwvQN8noe8t4//7eL0cIUuXUWHg9bUWQHmaXoeItE9ZX214QdT3S3PbAnEGRdRCox70/DH0BW24Gi+6opxS/3nz9rANM0+lOffHVVmWCgCrP0JDUQgTHmQVJ8dMZFylGu11rAcCcq/xK06+t8kIz73dpVQ3PboujXR346XJAnDj36tT1UhtXhD7YSYGQzVOyLZTA3Esc5WywFzSIhvMYKFtgBIo9R1b6htTyfi7sy1rQTyAKExXLCPyAxhyvlSfpruVXAH7e9C4CqLbwFrsAe/KItTeRAem4E8CdAsa1YMOpyhm2hMFBCcEc9/KB73JKnEXmOOtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXPWBxtvnD7zWVL/qGBOn03/CCaw5VjOaalxjKlHJLM=;
 b=WWnSMMQWNgeCF8Tx7vsjscB6heZu/sQ0wXykeWnig2LIAGMAbfubSQie3WHHX64cYl1X0OhIm4DpJg3/Pj8Nq5L3qDj06ECL/E2P7A5TjiyPaLJnJltRskzfYF/bL+0MTllqN6FQFWM1+2m3UEozPPSyOPCKXzOwARhfyP2a+S1a96typVNBFWIhRshpJJLBH2akSo3mnRK7P0w53N6i+xDatP+JrUwE4C6/W6feCvZMfIVaY+axnzdiaGakIbA9JuU/uOG9jZnrAxGM+BeMmzCDRRC1g5VK1dP+t21yGtXkOGQ5J+c86LgUfkTsCmHsw+4WQtAQARDoynj8pWGcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Fri, 1 Mar
 2024 00:09:07 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7362.013; Fri, 1 Mar 2024
 00:09:05 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>
Subject: RE: [PATCH v3 1/2] ui/gtk: flush display pipeline before saving
 vmstate when blob=true
Thread-Topic: [PATCH v3 1/2] ui/gtk: flush display pipeline before saving
 vmstate when blob=true
Thread-Index: AQHaTmxqzy7lfz2kZ0+8S6yIEI5TvbEiO9dg
Date: Fri, 1 Mar 2024 00:09:04 +0000
Message-ID: <PH8PR11MB6879F8752A08AE8AC9F91A46FA5E2@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20231204183718.16777-1-dongwon.kim@intel.com>
 <20230920232426.5950-1-dongwon.kim@intel.com>
In-Reply-To: <20230920232426.5950-1-dongwon.kim@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SN7PR11MB6969:EE_
x-ms-office365-filtering-correlation-id: b6a08b47-5a94-4f7c-2d1c-08dc3983ce98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLTg8GXPHVzlgi8FSTP5yS2PpkQh2haCwSqPCzt6CLMpu/KHlig/wcJi4+1KWjS5gZtKuGo8NYPwhpiyz3XydlxsaORAkSaWWOkHXJAghrNsmQQwW8bgixwNyjCRXPtNZVduJ6zWwJ8L1sBERUcf2Iz1eJWSHrg8C90J9AR88QM21LYIZ5Rwcr74rcZK+cJWG2WAd+OE5GbIUGsr7Qp+aZnQUCyrkVG5fcmOM3InWOGRTFWh3yrD9id/I75eEaHN4pc7Eq4JTMCudB7qeWz02Y2GC+kyE99f3JzMuO1HVU0PrxejM3rrP2Fb9Yv18ll8Fox3uIinnHOAPBELppA7lHxrlrzS4/uoN/ZCKcorGp8Na38R2qFFcEf1CC5bYzT7A8vtfvQSO6aoOXnSL45HrxV3MxW6cEK+UPR2uV5LTgI9S4ZHnfAlwy4umPOm3gS1DLiR6RsVOICQZVNn+3hipneXhJp4Dfk+33KbFsx8jw5UV3kMwTLeIDH/FGUKTWiRaCcnRywOk/F75KeGrSKdJ7g8hDj3wcwPlzB+7cxJB0zuvSdiPkoLqtzBLvEHJyqe3omx12ARxvF3Uf9oRrLW8xwDTCCuGCskYJUpqglBJvxL9aTQzzLwcB3Dn9RHc1Hyr/HZa/obytNmxUNV9C9FhPf12hnBipRtaMA/FIR2pkI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWhjL00zbXowZzBIRVpvSzJNbFpwT29aZjNTemdSU2wzZkdzMDBXYjM0dkVz?=
 =?utf-8?B?eDRNRWsvVExlQ0hZK3ZuNGVVZ2Y1bW9nZmZqMkppQXJ0NytiY1dvdjlOVHJZ?=
 =?utf-8?B?N0hva2QvODNZTDVvenBUTk0yZ29WdVNHNEhWRkNVdldNdGEvK1c5c0xaV2Er?=
 =?utf-8?B?T0tOM3oxWWFINktwRXJSbWFIdHNXei9ENUtYUlg0bGFIWjFzL09vcm0yanQw?=
 =?utf-8?B?UEtueDQ1VlVpSko0NFNkUFJkeVJqbXN6alNrcXFXWWZVblJKZUl1SmQyQVpy?=
 =?utf-8?B?cWpUT1I3cGRCYURHcmVTUFlaTjdrU0pMa3lKd0RGcisxeGJCeWhidkRrM3kx?=
 =?utf-8?B?VjRLWVp4OFFRSjZTTnRFd0RjRk1CaURWZWxRcTdwR3Zna2hkM2x1Z0dtd2J3?=
 =?utf-8?B?amUrTEJ6Qm5oa2NJTU5EeklnYyt5R3Q4L2pvTzJrclRGNEl2aTluM2lTVWFB?=
 =?utf-8?B?OXZPd3FjZjJTOEI3WlVtQlFLSzNlbkJybmgydW95YUFuQ0NuWFFQa0hmWFJv?=
 =?utf-8?B?UzUyMzJUSHhWUjZFTlptRkJ5TzcySjVqdFpJL1l3ditxWDlkYXppamw2NFBr?=
 =?utf-8?B?RWRwZWl1SDI1SGUrM3F6Tmhsc01NRHlXMW1pK3EwczYyekRzYmxCVDh4NFV3?=
 =?utf-8?B?VERQbGl1cUZYTUloVjZsQUFTKzJxZVQveTlFNTB6YUtEVW1MYnZVSUJRWW9y?=
 =?utf-8?B?eG96V3ZvQmR2WWRseTF4ZkdRN0NOSDBmdVc0eGxPekxudkxHeWN3ZDN4aTNC?=
 =?utf-8?B?RDY4czBzTGNXcEI2ejBMZzVLZ0tpUHc5SytXN2liOUszRW52MVpKbU42OTJL?=
 =?utf-8?B?RWpwZFNnMDJXOU12ek0vbDB3M05IdnZRMUYrYk9NazlCZUZUVFBaQ05IVUcv?=
 =?utf-8?B?c05WcDV2TmJQdkJ0dEwzRzR3QSs3SDNBMHhmMlpZNUs2c2grR3NBTW9WbnE1?=
 =?utf-8?B?WHVlU0lOd2I0RnBITDR5c1ZaUndydjVQTEZmM1plWXNObW9vMEFrV1dRT1V5?=
 =?utf-8?B?d24vaWlWQ3Z5SVJSdXF3K1dwckg2ZUhrRWNJZEE0TVYvR1czOFJrTzJxb2tT?=
 =?utf-8?B?RFpWang2M29SZ1RIOXpud1ZCOG1Mb3F0NUFLTFc1WmhFcnN2SFdtcFBjY291?=
 =?utf-8?B?OWNnNnBSQ0JHZXRJampHUEpDTW5FOGlCWEhKYndTZDRuZlVoUjYvZ3J3eDdU?=
 =?utf-8?B?QitKeVhxSW9vaGV6bWNHY0dxTnRra1NKSDUwMjFyOENVQUc0MUVVVU1PQTMy?=
 =?utf-8?B?d2lYU1RlMXoyMHB5WGFNSi8xYzFhTWpLVksxU0o1QkkvY0F0ZmxNL2t3eEpG?=
 =?utf-8?B?RGF1cmZiQlNEUnJKTkd1aDl5TnNmSkhBV1lmTnFwOE1xUHJlY2t3M2kwVlNQ?=
 =?utf-8?B?TFVMalBEWUlYbXpSaGhzTjgxS2xPTThCUVJZTXZvd3ZkMVRCTXFrWS9mN24r?=
 =?utf-8?B?YTdCYVlPUmpIbVR3Y3M1enlLWjlCb1ExZlhQRUkxaWVmeWZ2b3R3SmhvZFgz?=
 =?utf-8?B?YzdPU2UwRmZxUWdaTWN0dnpmUG00c0tmdE1HMHh2andmeHZ2Zm1oTkhrMnhB?=
 =?utf-8?B?WHh3Ti9MSDhqZ1NOZFYvVWQzZ0Y0NUg1VXcyRVlKcmM5SW80S0FudjVOcWc0?=
 =?utf-8?B?UGh6Vmd1TFR3SDBSNlM3TVB0YUl0RVpTdDNibjV0L0x6UExiYSs5NUd1RHd3?=
 =?utf-8?B?NEVpVVkzS2Y0YnprdWNCZlBHKy93MkU1Nmk3YnR4WXdDcGIvcDdLc3hhYkJQ?=
 =?utf-8?B?aTUwN0lmYy8ydzJoRlVxNy9UdHV6Zk1BZ3pqdUZjQmFaTUpVRjhDLzVKcmlP?=
 =?utf-8?B?cWhEUnNRS2xML1lFeEx2ZDlGSzY5Y21QSzF2cXpzckFQc1lEUGkrazZmTTBC?=
 =?utf-8?B?VGd1S0x3Ym1yN2xzZ3pVdWFVRHYra3NENzQ1ZnZ3a2xEc3lHOUpFSk5ONmto?=
 =?utf-8?B?M3pldTlvNTl1QnJYY2NiZnBTVzlsYlBmemVTMlRnQmdiNFlJT3NyRUNoRTR1?=
 =?utf-8?B?UC8vZWs5bE15YmsyamRPNTBFbFJKSzk2RTJoZG9jYXh5NFFYaVhleGRVamJJ?=
 =?utf-8?B?MU1YOU9VZms4aWJ1dzVUQVZISDRNSVFGUFUyS2Q0dithSDlEaTRnQmRHbUFL?=
 =?utf-8?Q?s35R5yTuYKKtHvSmpdx7FbfzU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a08b47-5a94-4f7c-2d1c-08dc3983ce98
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 00:09:04.9143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZ/oCvIQhY4DxxjVRkmRg4le6jq1fWydwt179UwZSepkI3dIxeS5e1N7AccjRc/K4d802bFR8dPPQU5C1p8Gig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgTWFyYy1BbmRyw6ksDQoNCkNhbiB5b3UgdGFrZSBhIGxvb2sgYXQgdGhpcyBuZXcgdmVyc2lv
biBhbmQgYWxzbyBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwv
MjAyMy0xMi9tc2cwMTgyOC5odG1sPw0KDQpUaGFua3MhDQpEVw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IHFlbXUtZGV2ZWwtYm91bmNlcytkb25nd29uLmtpbT1pbnRl
bC5jb21Abm9uZ251Lm9yZyA8cWVtdS0NCj4gZGV2ZWwtYm91bmNlcytkb25nd29uLmtpbT1pbnRl
bC5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mDQo+IGRvbmd3b24ua2ltQGludGVsLmNvbQ0K
PiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA0OjI0IFBNDQo+IFRvOiBxZW11
LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYzIDEvMl0gdWkvZ3RrOiBmbHVz
aCBkaXNwbGF5IHBpcGVsaW5lIGJlZm9yZSBzYXZpbmcgdm1zdGF0ZQ0KPiB3aGVuIGJsb2I9dHJ1
ZQ0KPiANCj4gRnJvbTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gDQo+
IElmIHRoZSBndWVzdCBzdGF0ZSBpcyBwYXVzZWQgYmVmb3JlIGl0IGdldHMgYSByZXNwb25zZSBm
b3IgdGhlIGN1cnJlbnQgc2Nhbm91dA0KPiBmcmFtZSBzdWJtaXNzaW9uIChyZXNvdXJjZS1mbHVz
aCksIGl0IHdvbid0IGZsdXNoIG5ldyBmcmFtZXMgYWZ0ZXIgYmVpbmcNCj4gcmVzdG9yZWQgYXMg
aXQgc3RpbGwgd2FpdHMgZm9yIHRoZSBvbGQgcmVzcG9uc2UsIHdoaWNoIGlzIGFjY2VwdGVkIGFz
IGEgc2Nhbm91dA0KPiByZW5kZXIgZG9uZSBzaWduYWwuIFNvIGl0J3MgbmVlZGVkIHRvIHVuYmxv
Y2sgdGhlIGN1cnJlbnQgc2Nhbm91dCByZW5kZXIgcGlwZWxpbmUNCj4gYmVmb3JlIHRoZSBydW4g
c3RhdGUgaXMgY2hhbmdlZCB0byBtYWtlIHN1cmUgdGhlIGd1ZXN0IHJlY2VpdmVzIHRoZSByZXNw
b25zZSBmb3INCj4gdGhlIGN1cnJlbnQgZnJhbWUgc3VibWlzc2lvbi4NCj4gDQo+IHYyOiBHaXZp
bmcgc29tZSB0aW1lIGZvciB0aGUgZmVuY2UgdG8gYmUgc2lnbmFsZWQgYmVmb3JlIGZsdXNoaW5n
DQo+ICAgICB0aGUgcGlwZWxpbmUNCj4gDQo+IHYzOiBQcmV2ZW50IHJlZHVuZGFudCBjYWxsIG9m
IGdkX2h3X2dsX2ZsdXNoZWQgYnkgY2hlY2tpbmcgZG1hYnVmDQo+ICAgICBhbmQgZmVuY2VfZmQg
Pj0gMCBpbiBpdCAoZS5nLiBkdXJpbmcgYW5kIGFmdGVyIGVnbENsaWVudFdhaXRTeW5jDQo+ICAg
ICBpbiBnZF9jaGFuZ2VfcnVuc3RhdGUpLg0KPiANCj4gICAgIERlc3Ryb3kgc3luYyBvYmplY3Qg
bGF0ZXIgaW4gZ2RfaHdfZmxfZmx1c2hlZCBzaW5jZSBpdCBpcyBuZWVkZWQNCj4gICAgIGJ5IGVn
bENsaWVudFdhaXRTeW5jLg0KPiANCj4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJl
Lmx1cmVhdUByZWRoYXQuY29tPg0KPiBDYzogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNpcmVk
ZHlAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1A
aW50ZWwuY29tPg0KPiAtLS0NCj4gIHVpL2VnbC1oZWxwZXJzLmMgfCAgMiAtLQ0KPiAgdWkvZ3Rr
LmMgICAgICAgICB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS91aS9lZ2wtaGVscGVycy5jIGIvdWkvZWdsLWhlbHBlcnMuYyBpbmRleCAzZDE5ZGJl
MzgyLi5hNzdmOWU1N2Q5DQo+IDEwMDY0NA0KPiAtLS0gYS91aS9lZ2wtaGVscGVycy5jDQo+ICsr
KyBiL3VpL2VnbC1oZWxwZXJzLmMNCj4gQEAgLTM4NSw4ICszODUsNiBAQCB2b2lkIGVnbF9kbWFi
dWZfY3JlYXRlX2ZlbmNlKFFlbXVEbWFCdWYgKmRtYWJ1ZikNCj4gICAgICBpZiAoZG1hYnVmLT5z
eW5jKSB7DQo+ICAgICAgICAgIGRtYWJ1Zi0+ZmVuY2VfZmQgPSBlZ2xEdXBOYXRpdmVGZW5jZUZE
QU5EUk9JRChxZW11X2VnbF9kaXNwbGF5LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hYnVmLT5zeW5jKTsNCj4gLSAgICAgICAgZWds
RGVzdHJveVN5bmNLSFIocWVtdV9lZ2xfZGlzcGxheSwgZG1hYnVmLT5zeW5jKTsNCj4gLSAgICAg
ICAgZG1hYnVmLT5zeW5jID0gTlVMTDsNCj4gICAgICB9DQo+ICB9DQo+IA0KPiBkaWZmIC0tZ2l0
IGEvdWkvZ3RrLmMgYi91aS9ndGsuYw0KPiBpbmRleCA4MTBkN2ZjNzk2Li5lYWNhODkwY2JhIDEw
MDY0NA0KPiAtLS0gYS91aS9ndGsuYw0KPiArKysgYi91aS9ndGsuYw0KPiBAQCAtNTk3LDEwICs1
OTcsMTQgQEAgdm9pZCBnZF9od19nbF9mbHVzaGVkKHZvaWQgKnZjb24pDQo+ICAgICAgVmlydHVh
bENvbnNvbGUgKnZjID0gdmNvbjsNCj4gICAgICBRZW11RG1hQnVmICpkbWFidWYgPSB2Yy0+Z2Z4
Lmd1ZXN0X2ZiLmRtYWJ1ZjsNCj4gDQo+IC0gICAgcWVtdV9zZXRfZmRfaGFuZGxlcihkbWFidWYt
PmZlbmNlX2ZkLCBOVUxMLCBOVUxMLCBOVUxMKTsNCj4gLSAgICBjbG9zZShkbWFidWYtPmZlbmNl
X2ZkKTsNCj4gLSAgICBkbWFidWYtPmZlbmNlX2ZkID0gLTE7DQo+IC0gICAgZ3JhcGhpY19od19n
bF9ibG9jayh2Yy0+Z2Z4LmRjbC5jb24sIGZhbHNlKTsNCj4gKyAgICBpZiAoZG1hYnVmICYmIGRt
YWJ1Zi0+ZmVuY2VfZmQgPj0gMCkgew0KPiArICAgICAgICBxZW11X3NldF9mZF9oYW5kbGVyKGRt
YWJ1Zi0+ZmVuY2VfZmQsIE5VTEwsIE5VTEwsIE5VTEwpOw0KPiArICAgICAgICBjbG9zZShkbWFi
dWYtPmZlbmNlX2ZkKTsNCj4gKyAgICAgICAgZG1hYnVmLT5mZW5jZV9mZCA9IC0xOw0KPiArICAg
ICAgICBlZ2xEZXN0cm95U3luY0tIUihxZW11X2VnbF9kaXNwbGF5LCBkbWFidWYtPnN5bmMpOw0K
PiArICAgICAgICBkbWFidWYtPnN5bmMgPSBOVUxMOw0KPiArICAgICAgICBncmFwaGljX2h3X2ds
X2Jsb2NrKHZjLT5nZnguZGNsLmNvbiwgZmFsc2UpOw0KPiArICAgIH0NCj4gIH0NCj4gDQo+ICAv
KiogRGlzcGxheVN0YXRlIENhbGxiYWNrcyAob3BlbmdsIHZlcnNpb24pICoqLyBAQCAtNjc4LDYg
KzY4MiwyNSBAQCBzdGF0aWMNCj4gY29uc3QgRGlzcGxheUdMQ3R4T3BzIGVnbF9jdHhfb3BzID0g
eyAgc3RhdGljIHZvaWQgZ2RfY2hhbmdlX3J1bnN0YXRlKHZvaWQNCj4gKm9wYXF1ZSwgYm9vbCBy
dW5uaW5nLCBSdW5TdGF0ZSBzdGF0ZSkgIHsNCj4gICAgICBHdGtEaXNwbGF5U3RhdGUgKnMgPSBv
cGFxdWU7DQo+ICsgICAgaW50IGk7DQo+ICsNCj4gKyAgICBpZiAoc3RhdGUgPT0gUlVOX1NUQVRF
X1NBVkVfVk0pIHsNCj4gKyAgICAgICAgZm9yIChpID0gMDsgaSA8IHMtPm5iX3ZjczsgaSsrKSB7
DQo+ICsgICAgICAgICAgICBWaXJ0dWFsQ29uc29sZSAqdmMgPSAmcy0+dmNbaV07DQo+ICsNCj4g
KyAgICAgICAgICAgIGlmICh2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1ZiAmJg0KPiArICAgICAgICAg
ICAgICAgIHZjLT5nZnguZ3Vlc3RfZmIuZG1hYnVmLT5mZW5jZV9mZCA+PSAwKSB7DQo+ICsgICAg
ICAgICAgICAgICAgZWdsQ2xpZW50V2FpdFN5bmMocWVtdV9lZ2xfZGlzcGxheSwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1Zi0+c3lu
YywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFR0xfU1lOQ19GTFVTSF9D
T01NQU5EU19CSVRfS0hSLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEw
MDAwMDAwMCk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAvKiBmb3JjZSBmbHVzaGluZyBjdXJy
ZW50IHNjYW5vdXQgYmxvYiByZW5kZXJpbmcgcHJvY2Vzcw0KPiArICAgICAgICAgICAgICAgICAq
IGp1c3QgaW4gY2FzZSB0aGUgZmVuY2UgaXMgc3RpbGwgbm90IHNpZ25hbGVkICovDQo+ICsgICAg
ICAgICAgICAgICAgZ2RfaHdfZ2xfZmx1c2hlZCh2Yyk7DQo+ICsgICAgICAgICAgICB9DQo+ICsg
ICAgICAgIH0NCj4gKyAgICB9DQo+IA0KPiAgICAgIGdkX3VwZGF0ZV9jYXB0aW9uKHMpOw0KPiAg
fQ0KPiAtLQ0KPiAyLjM0LjENCj4gDQoNCg==

