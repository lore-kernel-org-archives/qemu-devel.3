Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488B0C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPg5P-0001q3-3b; Fri, 05 Jul 2024 06:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sPg5N-0001pS-Gd
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:22:37 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sPg5K-0004g4-OJ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720174954; x=1751710954;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5w7gdTuPELz0x4C66UE0EJ6tSRpgOp6VaZ9UTdgFDug=;
 b=bxkdkNRsmuSHvUpPRYWzLSn8MMUJoqz3/iXZ/eJqtPHcgKjTZ3kUgZ19
 UFLAq52Iu525wYfLhwEtOHnbfg8QwZ21itPqu0bdNEIODd9LjVKH+Mtye
 9+f5IeAl78N9B5DiUeuJ0ZboNGUH78nNXgKBfEtbKve9aaH68NH5tUGL8
 5xXjqr00PFgADsIICFH/TlpNvkwi8S9ADVqpUeJ/OjBnRlQEejGsL1KgY
 HlFaxlhXldsXJ/nL6Ruo7MwPMeJoZ3sgTQcOnxE4xZdihpVbtmHIXDHfz
 KqESSuCeQRmL0NW7waeSV70y4LWErCaTe/PZUEkX5Cs85n5BAcvC0siPb Q==;
X-CSE-ConnectionGUID: ObnPP1q6S4WEft3aTLm9aA==
X-CSE-MsgGUID: aRH43KWPSHCXXvs48JX+ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17608506"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="17608506"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 03:22:32 -0700
X-CSE-ConnectionGUID: TLovOzjfQ5y+WR2gQLzKLA==
X-CSE-MsgGUID: GR1mXbpuSUiTiyN5Ffdrvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="47268432"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Jul 2024 03:22:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 03:22:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 03:22:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 03:22:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chdM0RkKDAPtH44l5bL+J4urjiIYv2IhDKMfx/BJX0rYqk7qJAqbWq7Jlvl/3ENWU12D4IoUnxex6thGZwz79SI0JyZd5F6/4PDBCA3hSjqZWVVaiN7pnM1Eiy3TroNpoIDCVDpqOuWCtfSXY5EJ8yNFKA6MbjdcSpDyJyfgVPFraakrQ0LM7tlOWN5CQbITK2d07APRR7FRtgwb+0IulCNP5ypEoM/It3FST41U3T8bEjJfQCAlg4Vy+iXOvJ1B6W33JwAGSIVn0HeXpw9YalZYYC3UH7bnSbbiwqY6wFOGdpdgbv3fdtHwrt6gDlfXFKPrdRJf/KoUD0H1rN6VYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w7gdTuPELz0x4C66UE0EJ6tSRpgOp6VaZ9UTdgFDug=;
 b=chYfHPhN/kwrKXkeA7mAQ+MsSN2oljWKV9PctTztSb/VYdGsfJZ4bHtiBEMCepfNyspk3cDRMb9vxp7AQ2igENNcO7f2ojQ3ZXFLwhrTG+dR78esA4/AqtR9xCOeOvW+u2K1HT8Z6U6kAZK40MIfPrRciJM2JAmgW3iPJF0nGpVRF5oKOxaAeH1Tx9OlfCCsJc9VRqaJesYECX6HIfQbykPhgNXnqWRvdIBOnC9ycWl+71+p/YCzeANXhl7CWd72QoQszEZX0Ty4aESVuPzkVIvdUMtMFS0ab46Q5rv7xpS+Ao34A7+5bO9sj9Cop9cUyasozO6CDACLelQkHm1vkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DM6PR11MB4690.namprd11.prod.outlook.com (2603:10b6:5:2ae::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.25; Fri, 5 Jul 2024 10:22:23 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%5]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 10:22:23 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mtosatti@redhat.com"
 <mtosatti@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wang, Lei4"
 <lei4.wang@intel.com>, Jiri Denemark <jdenemar@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid is
 set to false
Thread-Topic: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid
 is set to false
Thread-Index: AQHazVg5C0RiDxJPOUeRPpagSbRqXrHlS/KAgACmBACAAMmIgIAApEnA
Date: Fri, 5 Jul 2024 10:22:23 +0000
Message-ID: <DS0PR11MB6373F79B4D34DBF5DAB416F2DCDF2@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <ZoWSdR1IOQ0iIxZC@x1n>
 <DS0PR11MB6373852F86A43ED9E1AFC7B7DCDE2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZobGx3KORPLQfBNC@x1n>
In-Reply-To: <ZobGx3KORPLQfBNC@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DM6PR11MB4690:EE_
x-ms-office365-filtering-correlation-id: 03b84c05-f46f-4bbc-9e62-08dc9cdc5c0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R3ZuUit4WXcwd2lmalFRRkNsVnozZlQxZnZxbXFqUVh3Qis0MHFNWWtBWGJZ?=
 =?utf-8?B?NzF3R1VPWFl4OW5uNmtiTVE4NkI3b1dkc3VISnVUOHBDLzdydWJWMTBHRFVa?=
 =?utf-8?B?MkRLVXhZUUkwZkFPS3VGVW85VDlFbnRYKytyWjAxUUFJMDNxUDF4a2hLU3R5?=
 =?utf-8?B?OUk0OFdEV2k2TFJQelgrQmRYdm44VUFyOVh0Rlo0UFZqUGxaT0NqQjFZdVEy?=
 =?utf-8?B?VFBQeTZIbEdZZFR3b3VKVFhGZUZ3UDlzZmhCSWZSZ3JjTlIxTDlMMXFPbHRh?=
 =?utf-8?B?WjZkRG5tQmMzWURYYW9wNUVTSXFVTERWc0dBeGxUK1FMMTlwbUV3QjREZk9y?=
 =?utf-8?B?WStnMnp4eVg1RC9BMDhUT1J5R1VKRll6a3ljWEVzQ0Q0OWV4eVNkRU9zRTYy?=
 =?utf-8?B?M3JjaVJxU21mc0Jiazh3Y0doTjRsb2g1THJFeFpOOHhqVVMyOGluWmZ4d0VV?=
 =?utf-8?B?N2dKaER4aSs5dHVVTHd0dlRKUk1wUEI1OVplcFYrc05NbWQyMzJzUit0UlJz?=
 =?utf-8?B?aSt6eDdLQ0E3TTRxZmFJdStBTC8yRFB0S0hzampvOC81NEFZaUtuQ3NjckZY?=
 =?utf-8?B?ckVOaW40VHNQdFpiQlp1U3NUT3ZqTHB0MVpRUWVhZ2d0Ymd3ME9GR1c1MkZO?=
 =?utf-8?B?Y2JCUFlNa3dDRWliRzZUM045dmtBU1JjeDVFWlhrUFY1WmNwdS9WTktWQVRj?=
 =?utf-8?B?RllZV0xUdGxIY1d6NE8wQmt5alhwVUlvbG9NeURrM2RSMkVEZ3JUWXREaHBH?=
 =?utf-8?B?SDZ5SzNITUVvS0tXNzBjZFR5SXk2WGFzRWRWSm1oUGJJNEY1OVhaaFFOZ0Fp?=
 =?utf-8?B?dnNSd2xpMlBublZtL0dDcWd2RXRBL3NYUzZrY0d3eXBLaCtWNXdXQ24zNVUv?=
 =?utf-8?B?Y0lmZ1ZNNVF4bDByWGs1MFRDOXNDd200ZGkwYUpGOFJmZDZIdnNrbFdPTjd6?=
 =?utf-8?B?M3pIV2Nqc0J3UUwyOTBMTVBYNTNVbTNKRGhjcXZDMitBZTlQbVJRNnBLSDFY?=
 =?utf-8?B?NGpmYkhWMGhiUUlwbStIQllVSGFPOGZYMDAwT00zNDFtaEpySnBJV1ZQQ3pT?=
 =?utf-8?B?eklwUjFsZlBCTVNtOUUvQ1lpdEkxcGlNUUpxT0hxdTRwanRUdXpiTjROZEVi?=
 =?utf-8?B?VnBHOGFxcVpTeFZmMVR6SXRkcytOQ3B4bHhqN2ZxN3BibFh0MDh1QU9NK1d4?=
 =?utf-8?B?NXR3NitQcGRxZUNzOFh0N3Q5L2pmZTY5cTZUb0dtSzFhZWN1WWh5ZzJaR2Va?=
 =?utf-8?B?VUR4UDE1T2gzOE1QMXY5QnB4NUdWWFQ0Z3Eyb291Rng2ZHQyQ294QVZheDE1?=
 =?utf-8?B?eEFjenQ5b1NqdGJQYlI1V3dqcDRRTzJ1SjZteTB6VHM0TmkvVUhOVUpMY2tR?=
 =?utf-8?B?WnRFVGpTUThvZHp1VzJMUUYzVEVtOHNVVGMveDdEY3gva3A5THpQNUVtSzNO?=
 =?utf-8?B?TEkzZ3pQRlhjdDdnOHYzUENQY1BKZUNwejRsT0NGek8vMXNGYTlBSlhHN3FP?=
 =?utf-8?B?WnpDL3dwV25ydExjUzZPUnZNWGMzRlVPSi9IM1VPZXRyN2lGenpPOHp4VWJS?=
 =?utf-8?B?NUNYdGJ0QlNsR09mUjdOMDlBQkpmRGRlcnlzZHZnZFRRRWdCTE1zdEV0UnBD?=
 =?utf-8?B?cGgwcngrMjRkbmdtcysxVzFhWUdkMitvU2N6a3lhMTVtb1cxUEF4RTB1L1NY?=
 =?utf-8?B?RDB5cmZZOU1lUUxMakl1aDd4aEROeTR4VkFVZ3V0RERBRWlwMitMdjJYbTU2?=
 =?utf-8?B?ZEwzQ3Q5OG1FZTZJVkdCSXQwZHhtcU1pUFpSc0pMRkRuU2lMWnJVMlMrWGoz?=
 =?utf-8?B?d2Q3SkNOQUwwak0zVXBuWFREekQyMGc4UXZ3SWg4T291UjhpcW1oaVRZRDB5?=
 =?utf-8?B?TkhmWFNjejJGK1ZkL2YzREQzMm12Q3hLS3dNOHd1WDBRQ0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGg0Sis2WGVZbzBSakxadlpBWnR6WGEwN2V3dWlmcEQzcm1BYWwycERoQ2xI?=
 =?utf-8?B?d012VU11M3lUKzErQjU3WW5UOTlEUlU3aTQrSkZaNGxRaHo2cFU0NU50OUpO?=
 =?utf-8?B?d0FYV3JISitidDJnWk9Ccm56RUtGaUJkdi96YXJsa3BzTW1tREN1dmhjN1Jn?=
 =?utf-8?B?NE0xaUt4NHpaZXZvR1dlRzBWRHhBeW5KU3hocW9HL1BPTlE2ZU5ERS9OYVBN?=
 =?utf-8?B?OFd1K0JOOHlOaWZEMVd4eDFVYnpXL3g3SklySDd6WTFRRHprdnJzV2xBN3BY?=
 =?utf-8?B?V2hZRnhNWjNzMzdkRjFPSW1XQkxTblQwYTRLZ0d1THZ1ZXRDeHJnU2dsUUhN?=
 =?utf-8?B?N2ZYUTZEdjdIUUN2Q3VVQnJvS2trckZvUWVIWUVFMkUzRUZvMEx0YzVMUmRy?=
 =?utf-8?B?dGYvWkI3dDNTVnNLeFN6WjJtQzlWRVgwajUwNTRWYmRBVW9MNXVHVzBaS3Q0?=
 =?utf-8?B?RHBDQ3lLNFEySEcrWEppazhTVWNNaC9RZmtsMlhoUlVjTXJnOVA1Q0Zmemw4?=
 =?utf-8?B?ZkM0MFNXalNIblJkWkwzTTlyWnhCb0NxMDN1U3JUR0RNSVpZbytOZkxaY0k5?=
 =?utf-8?B?UFYveW94Yi9zOUM0N2FxemdSZ2xTMm0yOXZNaldWUFdjWGFoS05pdTZCRS95?=
 =?utf-8?B?UjFQdHcrTXN1MVd1USt5UGtYaUtkYVBZMXcvV1llMFNsZ21iM1NFSjBBNjJT?=
 =?utf-8?B?YnBpUUI0K3RCZ0dMU3A2c3BvTlhlZzJncDRaZG1sMmJiMFczR1cwei96OHJu?=
 =?utf-8?B?QUx4K1pVekxUYmVyZndEZEZRQ2pERE9pZ0pEZi9PRDUzclU0MDArLzJxWVRF?=
 =?utf-8?B?dHVnOUZ0Um5LNDVDcE1WUGNXNmFvanVFTHdIVjVYcHpXV25RNlh2MUVvR1da?=
 =?utf-8?B?TVkrU2ptNGFySko2b0dpV1UyN0p4VXU2SzJpeVc1Q2xjTzk5TFI0MWdNQ011?=
 =?utf-8?B?cnBzWGFWMTZSazlqRVlRSE5SUXN1eEorNk43QkNFNU9IZFNEVUU4MjR6bEtj?=
 =?utf-8?B?TjdjbU5NMU90d0M5QnVXVTd0bjNtSXYwOWlwVGVQaXlkVTQybFFhZDlUSjlL?=
 =?utf-8?B?MDNQbUgvbVdXQldxQkkyOUVMVllkTWZxSUYyd0pXdlZtdFhMVll4OGppSzcy?=
 =?utf-8?B?b0QvR2llL3NBWWN6NC9ja2NHQ2dyMEJEK2cyamVENk9uc3RsdWJnTVlUSUpQ?=
 =?utf-8?B?bXluU2RyeTBpMXhUeTdYbkFOVU9ETUtnSGFmOWl3RzRvRkFhREtvcHk1dk03?=
 =?utf-8?B?RnJ6cXpaK1dvNklDT2M5eDlMV3BPOUhMNUNxc1dnMWJIT3FhRTh3M2tCcVNh?=
 =?utf-8?B?Z1dLNDZncU9UbUR5NVpNemIvOVc4OFEzc2c4TWdiSDIrMTRaeVUyZlFnd3pM?=
 =?utf-8?B?eURCKzdsMjcyOFF3bnVtTThlQXpKU2QzT21zR3N1UGttUmhpczhRdHhTYzZt?=
 =?utf-8?B?Ly9EL21LNVFwNmw0NVR1MWNVL1ZKY3VnRy9kR29jZ3lSRThhNWovbTZiZ2hw?=
 =?utf-8?B?V1JTenh4OC8vbjN2VVBWQTY1cCtkSFJDeEJUZFo0aGZvM2dhWUE5TVRHU1dI?=
 =?utf-8?B?YmtiRVRsRloxbFhRZVdhQ2lxQjhVN2xQN1ZqbHczallONXpSM3ZWYzlEa0FS?=
 =?utf-8?B?d0ZEZlE2RUJobzlkS0xIdmdvQVdaQ3dhMUEyMU5GOEtTUzlwajBvOHZqWGVw?=
 =?utf-8?B?UEY0QWdhcTFleGFoQ1gyYm01eUwrczlpekFmdnlxeVMyNjd3dUpvYmFCTUdH?=
 =?utf-8?B?VWNOMkhtUmVhMjNpb0JWNzJsSHpmVVh0UFF6VWNuYytyaHc1dVY4T0RVZ3Vm?=
 =?utf-8?B?ZGdXQXJMWFljRnMwRkRCdG0zbWExRFJPR2YxcXUxWUpQOTE3U3E5MllHZnZE?=
 =?utf-8?B?RDlzZy9LOTM0TUgzQ2Y5WWFQUVBTWUJjVGtSZUZFekIrMnZvc0wzV2JpZDVK?=
 =?utf-8?B?a3VlKzRXMUFMZ2RZM3Z0L2tLM0FCUzhZTjIrZDNiTWpDek4vdzd6ZGZDMEww?=
 =?utf-8?B?c1RCbmw2N3FWRndGYlFtYzU2UlA5WXpNclQzemhkL1NuYnBIL3ljMjE3UGJq?=
 =?utf-8?B?a0E2dDZYSW84Z1BWcTBKSEwwdVIwVXQ4Rnc4VVFDZ1MrWUtjTFdMbk9rMmhr?=
 =?utf-8?Q?3nj9VYu/QI3tR3utMHIKcJUd/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b84c05-f46f-4bbc-9e62-08dc9cdc5c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 10:22:23.0390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRcpUDi9QSLwT9li5NEky8n+b00AlJxpI9M9VKmjz8QAlsj6OnQ6I/OgdFH9UtfQiM3Sny93v2YmDjsxoDBnEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4690
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
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

T24gVGh1cnNkYXksIEp1bHkgNCwgMjAyNCAxMTo1OSBQTSwgUGV0ZXIgWHUgd3JvdGU6DQo+IE9u
IFRodSwgSnVsIDA0LCAyMDI0IGF0IDAzOjEwOjI3UE0gKzAwMDAsIFdhbmcsIFdlaSBXIHdyb3Rl
Og0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvY3B1LmMgYi90YXJnZXQvaTM4Ni9j
cHUuYyBpbmRleA0KPiA+ID4gPiA0YzJlNmYzYTcxLi43ZGI0ZmU0ZWFkIDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS90YXJnZXQvaTM4Ni9jcHUuYw0KPiA+ID4gPiArKysgYi90YXJnZXQvaTM4Ni9jcHUu
Yw0KPiA+ID4gPiBAQCAtODI1OCw3ICs4MjU4LDcgQEAgc3RhdGljIFByb3BlcnR5IHg4Nl9jcHVf
cHJvcGVydGllc1tdID0gew0KPiA+ID4gPiAgICAgIERFRklORV9QUk9QX1VJTlQzMigiaHYtdmVy
c2lvbi1pZC1zbnVtYmVyIiwgWDg2Q1BVLA0KPiA+ID4gPiBoeXBlcnZfdmVyX2lkX3NuLCAwKSwN
Cj4gPiA+ID4NCj4gPiA+ID4gICAgICBERUZJTkVfUFJPUF9CT09MKCJjaGVjayIsIFg4NkNQVSwg
Y2hlY2tfY3B1aWQsIHRydWUpLA0KPiA+ID4gPiAtICAgIERFRklORV9QUk9QX0JPT0woImVuZm9y
Y2UiLCBYODZDUFUsIGVuZm9yY2VfY3B1aWQsIGZhbHNlKSwNCj4gPiA+ID4gKyAgICBERUZJTkVf
UFJPUF9CT09MKCJlbmZvcmNlIiwgWDg2Q1BVLCBlbmZvcmNlX2NwdWlkLCB0cnVlKSwNCj4gPiA+
DQo+ID4gPiBJIGFzc3VtZSBpbiBtYW55IGNhc2VzIHBlb3BsZSBjYW4gc3RpbGwgcHJvcGVybHkg
bWlncmF0ZSB3aGVuIHRoZQ0KPiA+ID4gaG9zdHMgYXJlIHNpbWlsYXIgb3IgaWRlbnRpY2FsLCBz
byBtYXliZSB3ZSBhdCBsZWFzdCB3YW50IHRoZSBvbGQNCj4gPiA+IG1hY2hpbmUgdHlwZXMga2Vl
cCB3b3JraW5nIChieSBpbnRyb2R1Y2luZyBhIG1hY2hpbmUgY29tcGF0IHByb3BlcnR5KT8NCj4g
Pg0KPiA+IFlvdSBtZWFudCBrZWVwaW5nICJlbmZvcmNlX2NwdWlkPWZhbHNlIiBmb3Igb2xkIG1h
Y2hpbmUgdHlwZXMgKGUuZy4gYmVmb3JlDQo+IDkuMSk/DQo+ID4gVGhpcyB3aWxsIG1ha2UgdGhl
bSBub24tbWlncmF0YWJsZSB3aXRoIHRoaXMgcGF0Y2gsIGJ1dCB0aGV5IHdlcmUNCj4gPiBtaWdy
YXRhYmxlIChieQ0KPiA+IGRlZmF1bHQpIGFzICJtaWdyYXRhYmxlIiB3YXNuJ3QgZW5mb3JjZWQg
YnkgImVuZm9yY2VfY3B1aWQiLiBTaG91bGQgd2UNCj4gPiBrZWVwIHRoZW0gYmVpbmcgbWlncmF0
YWJsZSBieSBkZWZhdWx0IChlLmcuIGVuZm9yY2VfY3B1aWQ9dHJ1ZSkgYXMgd2VsbD8NCj4gDQo+
IEFoLCB0aGlzIGlzIHRyaWNraWVyIHRoYW4gSSB0aG91Z2h0Li4NCj4gDQo+IFRoZSBpc3N1ZSBp
cyBpZiB3ZSBtYWtlIHRoZW0gc2lsZW50bHkgc3dpdGNoIHRvIGVuZm9yY2VfY3B1aWQ9dHJ1ZSBv
biBvbGQNCj4gbWFjaGluZXMsIHRoZXJlJ3MgY2hhbmNlIHRoZXkgc3RhcnQgdG8gZmFpbCBib290
LCBhbSBJIHJpZ2h0Pw0KDQpSaWdodCBmb3IgbmV3bHkgbGF1bmNoZWQgZ3Vlc3RzLCByZWdhcmRs
ZXNzIG9mIHdoZXRoZXIgdGhleSBhcmUgbmV3IG9yIG9sZA0KbWFjaGluZSB0eXBlcywgdGhleSB3
aWxsIGZhaWwgdG8gYm9vdCB3aGVuIHRoZSBob3N0IGNhbm5vdCBhZmZvcmQgdGhlIGZlYXR1cmVz
DQpmb3IgdGhlIGNvbmZpZ3VyZWQgdkNQVSBtb2RlbHMuIFRoaXMgaXMgZXhwZWN0ZWQsIGFuZCBh
Y3R1YWxseSBwYXJ0IG9mIHRoZQ0KaW50ZW50aW9ucyBvZiB0aGlzIHBhdGNoLg0KDQpXaGVuIHRo
ZXJlIGlzIGEgbmVlZCB0byBib290IGEgZ3Vlc3Qgd2l0aCByZWR1Y2VkIGZlYXR1cmVzLCB1c2Vy
cyBuZWVkIHRvDQpleHBsaWNpdGx5IGFkZCAiZW5mb3JjZV9jcHVpZD1mYWxzZSIsIHdoaWNoIG1h
cmtzIHRoZSBuZXcgYm9vdGVkIGd1ZXN0IGFzDQpub24tbWlncmF0YWJsZSwgb3IgYSBfYmV0dGVy
XyB3YXksIHRvIGlkZW50aWZ5IHRoZSB1bnN1cHBvcnRlZCBmZWF0dXJlcyBmcm9tIA0KdGhlIGhv
c3QgZmlyc3QsIGFuZCB0aGVuIGdldCBpdCBib290ZWQgd2l0aCAiLWNwdSBDcHVNb2RlbCwtQSwt
QiIsIHRoaXMgY2FuIG1ha2UNCml0IG1pZ3JhdGFibGUgd2l0aCB0aG9zZSBrbm93biByZWR1Y2Vk
IGZlYXR1cmVzLCBhbmQgdGhlIGRlc3RpbmF0aW9uIGd1ZXN0IGlzDQpyZXF1aXJlZCB0byB1c2Ug
dGhlIHNhbWUgUUVNVSBjb21tYW5kcyAoYXMgdXN1YWwpIHRvIHJlZHVjZSB0aGUgc2FtZSBzZXQN
Cm9mIGZlYXR1cmVzIGFzIHRoZSBzb3VyY2UgYW5kIGdldCBhIGVuZm9yY2VkIGNoZWNrIGJ5ICJl
bmZvcmNlX2NwdWlkIi4NCg0KRm9yIGxpdmUgdXBkYXRlIG9mIFFFTVUgZm9yIGV4aXN0aW5nIHJ1
bm5pbmcgZ3Vlc3RzIChhcyB5b3UgbWVudGlvbmVkDQpiZWxvdyksIHRoZSBpbXBhY3QgaXMgb25s
eSBvbiB0aGUgcnVubmluZyBndWVzdHMgdGhhdCBoYXZlIGhhZCBmZWF0dXJlcyByZWR1Y2VkDQpm
cm9tIHZDUFUgbW9kZWxzIChhdCB0aGUgdGltZSBvZiB0aGVpciBvcmlnaW5hbCBsYXVuY2gpLiBG
b3IgdGhpcyBjYXNlLCB0aGUNCnJlY29tbWVuZGVkIHdheSB0byB1cGRhdGUgdGhlbSB0byB0aGUg
bmV3IFFFTVUgaXMgYWxzbyB0byBleHBsaWNpdGx5IGlkZW50aWZ5DQp0aGUgcmVkdWNlZCBmZWF0
dXJlcyBhbmQgdXBkYXRlIHRoZW0gd2l0aCAiLWNwdSBDcHVNb2RlbCwtQSwtQiIuDQoNClRoZSBy
YXRpb25hbGUgYmVoaW5kIHRoaXMgaXMgdGhhdCB0aGUgZmVhdHVyZXMgcmVkdWNlZCBmcm9tIHRo
ZSBndWVzdCBuZWVkcyB0bw0KYmUgZXhwbGljaXRseSBkZXRlcm1pbmVkIGFuZCBjb250cm9sbGFi
bGUuIEluIHRlcm1zIG9mIGxpdmUgbWlncmF0aW9uLCB0aGUNCmRlc3RpbmF0aW9uIGlzIGVuc3Vy
ZWQgdG8gaGF2ZSB0aGUgc2FtZSBzZXQgb2YgcmVkdWNlZCBmZWF0dXJlcyBhcyB0aGUgc291cmNl
DQpzaWRlLg0KDQo+IA0KPiAgICAgaWYgKGNwdS0+ZW5mb3JjZV9jcHVpZCAmJiB4ODZfY3B1X2hh
dmVfZmlsdGVyZWRfZmVhdHVyZXMoY3B1KSkgew0KPiAgICAgICAgIGVycm9yX3NldGcoJmxvY2Fs
X2VyciwNCj4gICAgICAgICAgICAgICAgICAgIGFjY2VsX3VzZXNfaG9zdF9jcHVpZCgpID8NCj4g
ICAgICAgICAgICAgICAgICAgICAgICAiSG9zdCBkb2Vzbid0IHN1cHBvcnQgcmVxdWVzdGVkIGZl
YXR1cmVzIiA6DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIlRDRyBkb2Vzbid0IHN1cHBvcnQg
cmVxdWVzdGVkIGZlYXR1cmVzIik7DQo+ICAgICAgICAgZ290byBvdXQ7DQo+ICAgICB9DQo+IA0K
PiBJIHN1cHBvc2Ugd2Ugc3RpbGwgbmVlZCB0byBrZWVwIGFsbCB0aGUgb2xkIHdvcmxkcyBydW5u
aW5nIGFsbCBmaW5lIHdpdGhvdXQNCj4gYnJlYWtpbmcgdGhlbSB3aGVuIHBlb3BsZSBkbyBhbiBR
RU1VIHVwZ3JhZGUuICBJdCBuZWVkcyB0byB3b3JrIGJvdGggb24NCj4gYm9vdGluZyBmaW5lLCBh
bmQgb24gYWxsb3dpbmcgdG8gbWlncmF0ZS4NCj4gDQo+IFNvIG1heWJlIHdlIGFjdHVhbGx5IG5l
ZWQgdHdvIHRoaW5ncz8NCj4gDQo+ICAgLSBPbmUgcGF0Y2ggaW50cm9kdWNlIGZvcmJpdF9taWdy
YXRpb25faWZfY3B1aWRfbWlzbWF0Y2ggcHJvcGVydHksIHdoZW4NCj4gICAgIHNldCwgYmxvY2sg
bWlncmF0aW9uIGlmIG5vdCBlbmZvcmNlZCwgb3RoZXJ3aXNlIGl0IHNob3VsZCBzdGlsbCBhbGxv
dw0KPiAgICAgbWlncmF0aW9uIGV2ZW4gaWYgZW5mb3JjZV9jcHVkPWZhbGVzLiAgSXQgc2hvdWxk
IGRlZmF1bHQgdG8gb24sIGJ1dCBvZmYNCj4gICAgIG9uIG9sZCBtYWNoaW5lcy4NCj4gDQo+ICAg
LSBPbmUgcGF0Y2ggY2hhbmdlIGRlZmF1bHQgdmFsdWUgb2YgZW5mb3JjZV9jcHVpZCB0byBvbiwg
YnV0IHR1cm4gaXQgb2ZmDQo+ICAgICBvbiBvbGQgbWFjaGluZXMuDQo+IA0KPiBEb2VzIHRoYXQg
bG9vayByaWdodD8NCg0KSSB0aGluayB0aGlzIGNhbiB3b3JrLiBOb3Qgc3VyZSB3aGF0IHlvdSB3
b3VsZCB0aGluayBhYm91dCB0aGUgYWJvdmUgZXhwbGFuYXRpb25zLg0KSWYgYWdyZWUsIHRoZW4g
cHJvYmFibHkgd2UgZG9u4oCZdCBuZWVkIHRvIGFkZCB0aGUgZXh0cmEgY29tcGxleGl0eS4NCg0K
QWxzbywgdGhlIGFib3ZlIHR3byB0aGluZ3Mgc2VlbSB0byBpbXBlZGUgdGhlIHVwZ3JhZGUgZm9y
IGd1ZXN0cyB3aXRoIG9sZGVyIG1hY2hpbmUNCnR5cGVzIHRvIGluY29ycG9yYXRlIHRoaXMgZW5m
b3JjZW1lbnQuIEkgdGhpbmsgdGhlIHByaW1hcnkgZ29hbCBvZiBsaXZlIHVwZGF0aW5nIHRvIGEN
Cm5ld2VyIFFFTVUgdmVyc2lvbiBpcyB0byBiZW5lZml0IGZyb20gdGhlIGVuaGFuY2VtZW50cyBv
ZmZlcmVkIGJ5IHRoZSBuZXcgUUVNVS4NClNvIGl0IHNlZW1zIG1vcmUgYmVuZWZpY2lhbCB0byBi
cmluZyBvbGQgZ3Vlc3RzIHVuZGVyIHN1Y2ggZW5mb3JjZW1lbnRzLCBnaXZlbg0KdGhhdCB0aGlz
IGRvZXNuJ3QgYnJlYWsgZnVuY3Rpb25hbGl0aWVzIHRoYXQgdGhlIGd1ZXN0IGlzIHJ1bm5pbmcu
IFRoZSBvbmx5DQpyZXF1aXJlbWVudCBmb3IgdGhpcyBpcyB0byB1cGdyYWRlIHVzaW5nIG1vcmUg
ZXhwbGljaXQgUUVNVSBjb21tYW5kcw0KKGkuZS4sIC1jcHUgQ3B1TW9kZWwsLUEsLUIpIHdoZW4g
bmVlZGVkLg0K

