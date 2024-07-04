Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2805DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPCxB-0006Yz-9W; Wed, 03 Jul 2024 23:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sPCx6-0006W4-Pr
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:16:08 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sPCx3-0000AG-0f
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720062965; x=1751598965;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K9k47rf4aurutEUEfFOzFzxInUSwL2RFVN1bDXJmLWE=;
 b=noVDNRPm5+CL1jewXR94CcZYHaqjGr2HixYud7Q1iHu0i004M0uwuX1T
 6NhNiQL+IpA4GX4QqrTCQGGXr3Oso7mVNc+UV0FVrwRQgjPG0h+3AVVOG
 5KTQ+q0rHNHZbQKM2Ij7nWOGiWcFJckzT+WLbfN6Z5BSD1F4tkDHYIOtm
 ACyjtiOq/M+nGD5DuTG0diHDBwvTeyJ/sQRJMWiEx15OO+S8PHLnWszqH
 lcMJ6wmme25NXrZ8balSbcY2fvEsP6uXIy10pex+YeMOdZk2nO0xG0HLu
 1LDLdm6i37FT4dmahM+0gJNFgmi2G9maCiCtRgKXS9x8/n+EYcsmVJMVm A==;
X-CSE-ConnectionGUID: oG81aQAMSiyf/IWecJDhnA==
X-CSE-MsgGUID: C7KuBkJlQPWh+vjt0HcCAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="28465428"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="28465428"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 20:16:00 -0700
X-CSE-ConnectionGUID: ruSKfpRzQ/GGmXthHZN/mA==
X-CSE-MsgGUID: RYMEoOCXRIyfyZEh6xxShw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46876413"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jul 2024 20:16:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 20:16:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 20:15:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 20:15:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 20:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRDXnZFP4Zi1xDEbR7+Ei7bHRFrAoAoXbuyKRKCx6IleWrvdUvMEWG1qGg19mgRTMHDKRCD0vvWUTjk0RA12EF/fTcJ6RRgTycbtCSAUI7zzayyQThanuaN1zPrQE6QDWPSgCF73P8PH9OFpLkydes1Iid3zooT7gd1h8oBOW+txx1jA75Ma36GVPEyBUU/Go0yo+R+swvmQ/S4b/7j0i8CmVDEJGhRu9Z8Fg/MJYJfgeQBao295OK/vN6KK/0xuExKkuXF4Wd6t15+lG6aljWWZY6yWKIrMMZsW4uGF7BTuvCaT+QWGSFE/idVuK7h5YxhIc02GalqypVpQYs/8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9k47rf4aurutEUEfFOzFzxInUSwL2RFVN1bDXJmLWE=;
 b=Me8tsC4LBf+/AEUmgt98eBKNzWd95hyTcLudlWQ6CHTF+B94hsd3EEZyaCFRlGeq5ZrTI7PLwqz+u62sUHXi8gOJixt0dEvRj6eypmLaNGkEhAYcY+IYZDVXBNSV7YXr/RxoRpm9y6eU6XutYK1KYGc1q/gBnisHPhMl4hlH+Pn56o7Dfno5JPtWzNErKP8nxrqD3mK/1Qypsk8Dw98YUvwdZUL767PrtCA5+tvCWGAfLa5CwqYZOKjLcxqBpv0IyhEUHUn4MEjzoxswNKk650Dxfpg9YO36w0gilByjvx8wcnaqPPhbDttiCuNolwQOwnS00K8/x1sT3SyimpKwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 03:15:51 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%7]) with mapi id 15.20.7719.029; Thu, 4 Jul 2024
 03:15:51 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, "Wang, Yichen" <yichen.wang@bytedance.com>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Fabiano
 Rosas" <farosas@suse.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Hao Xiang
 <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Ho-Ren (Jack)
 Chuang" <horenchuang@bytedance.com>
Subject: RE: [PATCH v3 0/4] Implement using Intel QAT to offload ZLIB
Thread-Topic: [PATCH v3 0/4] Implement using Intel QAT to offload ZLIB
Thread-Index: AQHayOJIDKh+7Tkp2Ua87mwnlN+D07Hj1t2AgACAAZA=
Date: Thu, 4 Jul 2024 03:15:51 +0000
Message-ID: <PH7PR11MB5941E373F92A78EB5A7E4FCAA3DE2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240627223445.95096-1-yichen.wang@bytedance.com>
 <ZoRSA4naaje878PK@x1n>
In-Reply-To: <ZoRSA4naaje878PK@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|PH0PR11MB5901:EE_
x-ms-office365-filtering-correlation-id: 96884bba-bb88-479f-2bc9-08dc9bd79bae
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Z1NWSmsvOWFUb1NJeTNGYThFMHd6MzRjQXh0UkRRUklHWGtKR1RlMTh1bE5F?=
 =?utf-8?B?L0dUZXlHK21hUk10UUlQalYxU1ZVdU16akFIVmJWQ1FuOGl6b2FHNjNwaDV6?=
 =?utf-8?B?cTVWVUFkbk1KNFlVbGNZZmFlMTJGSlZwYWVOK3FqbzNSNFc4RXFvdytROVlC?=
 =?utf-8?B?cVFvUVBMc1BQZjRkYmhnMEQrV2hWUGExSS84K0hQT1pGbnZSc2NHRk1IZ1k2?=
 =?utf-8?B?cVVQVGE0VkFFcDVIR3dQdnlVUDY3UTdwSTRhcFB0Rnp3cUh4TEVXbSszK2My?=
 =?utf-8?B?UWtLTzM1cWlnb1NvTFRCV2JMN2F2WVNYUHd6YnlEbmZ0ZnRrT3B3SUpaQlhJ?=
 =?utf-8?B?aXpZbVRCYlRaT0FLWlJwbkt6bnhwaEFkeHJrSHprdFhjUFJyd1NodFdXcGxw?=
 =?utf-8?B?L1ByT0w3RXIvRTFXbXVmV09HSTRjMCs1UFlDVGVJRHhCTWRUb3JYdXA0Uzll?=
 =?utf-8?B?bkVjSFFyNXdRMGxkKzZSWXZPb0RBQlZla2hPSzFHc1FDSUNwaytaTFd2N0dm?=
 =?utf-8?B?Y0p2bUF6TnE3Vlg5VnJzWTVoUFZWaWFucWVhRlcvTklVRnBzQlhXU2FPMkNF?=
 =?utf-8?B?eVpISUhGMDY4MmxzdDVYWVp1dGNjbVlMLzM3R0JFSU0vRXExVXRkZ2V6T1hY?=
 =?utf-8?B?WHBuZ0ZHZEM3Q2Fpd01TZTBSVStqcXp2SUVyUGgyNVFPZCtZam5MMEtrU1NF?=
 =?utf-8?B?MHJJS2JGVy84M0ZWeGllNmdCbXpkeEtiM2lMWXhyczBYVDdlTjFYTkd5Q3NS?=
 =?utf-8?B?QzFOZWwyRlM2dlpDbHVyak1ad3lRTG94enhJdEJ4aU82eXFkdFJHU2MvZ1pt?=
 =?utf-8?B?dUFmWVVsT3J5dER2dk9hZFNTK0srSlFUUy9rNnJZYWJzQ09pZ3ZEaHRjTmpI?=
 =?utf-8?B?U2JzbzBSbXc3U2c2OE9FYzJuVHZpYzlnaExWcUR2RE91L1Z2ekJad0dTM3Ux?=
 =?utf-8?B?OXFsZlA4M0JqOWNjMWVEWTl4enVwYVZISmFGUmdTUkhHY2UxbEFrRGRGUnc2?=
 =?utf-8?B?eFRQMU03MzFXWnEyVGlyaGsyV0puT1FtNGs3NGoyZUFIR3RJSmk3WmFSdXlp?=
 =?utf-8?B?bEdHZUo2YU9tRElxQjJOSk5hMVZMdUhCazVabllVTjZNRGkvR05hN2x6VS85?=
 =?utf-8?B?Y3M4a0luWTgzMFlKSG5FRmZ3ODNhNWZ1V2gxQ1JKY25kZ1YzSjVrcjdYMUZ3?=
 =?utf-8?B?SDhxU1VkcVo1TVA0cWNVb0ZPdFdQSFR6bFJHV3VCRVlqZjhEY0hDTElGMmxh?=
 =?utf-8?B?WTBZdVdmWERHRzQ3bGFxVDhtaE1kMVpob0cyVGNmdDNhT1cycTBxdUtQRU1T?=
 =?utf-8?B?U0pmMDZwamU0NWFGQnduVDIrU0lvYjFWTkZmbmt3dngybTJZMFpMVHAxZlNu?=
 =?utf-8?B?clFnNHdFVVJBVEkzV2paK3JsMVJ1Y2ZNSDkyOHJwU25xZk95OGNEeFRFbjVG?=
 =?utf-8?B?Q2licGJuZGhvV2FxSm9uRUdDZ3c5WjJEOEtMQWI0UFlVR0dLQzlWQjE4M0pM?=
 =?utf-8?B?V0RZY0h6Q05WNW9TbnppUCtGaFdqSU9mWmowdFBZY3hSU1puck5QU05zTHEv?=
 =?utf-8?B?MTJ2ZnZZRjlyR1ZWNVJEejVPQTRMV0hwL0tJMklLRFhUMEx6eUpJZU15OGgz?=
 =?utf-8?B?cnBFYTc1bkNwT2VyMTFNeTBGK2RUSkZieXNhUmxkR2duRDRtQm9PZlRVV2FD?=
 =?utf-8?B?MDdKT3hYMXVFNDVGNFdDY1daQ3ZwTGl2a0FWTXZPZG0yZlNjU05udmZlL1hU?=
 =?utf-8?B?WkFaV2lpRFlhZ284RVJtWEViUGlWUkVvMUdQUXFtTlJ3SE93QmJ5ZnMzZ0Jv?=
 =?utf-8?Q?naz2aTZIYP9c2EiTC87cMzVnObq+8sh2Qbk8s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHkrOXZjSEJEek9CWVh4TE43WFpnYVV3RFQ0UTdNZWYvbVhncmJOeitKVU5H?=
 =?utf-8?B?SUlwMWl2REkyb0t5V3BRdkRPM0NxWHpqTmh1VkhEc2JSdlg4U3I0QVVwRFFO?=
 =?utf-8?B?WmFaMHlkb0wwMlNsNEZhVGhHSk4vMlFWSFFyQXp0SWdwdkZDUDIvM3VZYVRV?=
 =?utf-8?B?ZjVqNVVrT0lDTmFiUE93TUhqTkJGTWdpbHdmVjFUaXZRTHlnMW1PcFlIWDJm?=
 =?utf-8?B?SUtYWnlIcGFPbjlXWDFuUHYweHlqdXdjeXgrT1FrMVQ5TEVIRjFURFVoODh3?=
 =?utf-8?B?SjZKaGhTM1pXck9Sbk1KWXpUcjNEUVd0L0QyR1lORHlHR0hhRzc4WDY1aFls?=
 =?utf-8?B?NEJ4bWl6MlNqQkp6OWtPSm1sVEprWC8wajFSSVVhbkRoYjRWVDNtNTlWM3VE?=
 =?utf-8?B?WS94S2VKNXlYT2RkSHQ4R3EzcDVUayt6RDdHZWt5S3ZqQzc5M0NaclgrZ1ll?=
 =?utf-8?B?RWRQOSt4NldENzVseUZSZjRzSXdjWCsrc2V1aW5pZDNybHB4NW1JODNWMXNk?=
 =?utf-8?B?RDdWdVFDUTFPUFFWckw0Q1hEOExIbGFJdFh0a0taeXlCaHJIeFhVZ1k4bjdD?=
 =?utf-8?B?ZjMvTWo2R0FVWWQzRDdVckZxS0IzWnV3MGQ4ZTdFRll6ZzFBQXZpcUxFenRq?=
 =?utf-8?B?QkF0L0VvbkdhOXpJdm1oUFR4ZTBQL05PUXpSTVBSUTEyWWpXSVJwQnRBYmxT?=
 =?utf-8?B?ZjBzVmc2bHl0enA2cTZEWGFRVVF6VHU2TFpkRWVWK212bmY1MGFHRnVLdFIx?=
 =?utf-8?B?UDgvRTVjOENwMHVCem4yUFFjbXdKaVJnR3VwWUlEaXMwazVtR3FNOWFNR1FB?=
 =?utf-8?B?OWtaMnRKdXVrVW9yMVJTU3h1UVRCeXRJVENNR3BTaTBRSnN1ckZsM3pLbUFV?=
 =?utf-8?B?dVJHQXU4U3pXTWorcWR0U0VKRlRsV3diM2hFZlo0clZNVDA5d3NwSU1ZT1My?=
 =?utf-8?B?Y2JUZ29YeDZLS2JMYStyVjVtNUplMUR2bmRPZHpLdFkyK2VMWkc3T2xYdlc3?=
 =?utf-8?B?VWJLem5hODZzc3FZdDBIZyswUVB4dGN1MnJXVXQ2Rnp0bE95c2JYSHlTbUhu?=
 =?utf-8?B?VHYrOTFNaysvSDAwNjdBUnBTL3V5dHlrWXJ4ZHBpcnBCcno0aEw1QWZGZWRu?=
 =?utf-8?B?UEI3WUpqc3JTYkNoak1Jcm5LY0g4Y2ppM05SVHltOXlZY3FlWXJNbHJMQzVX?=
 =?utf-8?B?V3JvaExRajlTU3h4SUJmdGRxYVZhODZXK2doQzZ2dkt4dnAzbVlpRmVnMHNn?=
 =?utf-8?B?TG41NWlFT2d4N1NlVG8zb3hYRmcvampTNVBHWkl0K3R3R3c3ZktGMnJ4NUEw?=
 =?utf-8?B?YnV2VDJUZVBBS2NJc1FwMjFnS1V2S2tYTllUeVJoRWxxekhQb3dBUS9obWo2?=
 =?utf-8?B?K3pDN3plUFkwUDc3c2JtYmNnRVk4UGN2ZzUwajcvYjdpR3lNVkNGME5Lb1FE?=
 =?utf-8?B?UHBSUzdMYWxTVm9ROEJ0VFM0RDNEaTE1ci9ZbTVCOEcxdFZZRHZMWnlTT2lm?=
 =?utf-8?B?dUtEQ2tuNldLbXE1UW1zVG1Gbi96bC8vQmdlSTJJaWhrM2J1eWdSbzNhWHpC?=
 =?utf-8?B?QmwrTndnT09Kc0hrTURuVkkwSFM2YU1tKzBSL2Q5Y3c0M1RNcEhVbEgrODQ3?=
 =?utf-8?B?M3BKcnhqcDl4V2FsY2I3a2dxTWV4UjQrblExWlV3UXNBRzZnSitjR1NraFNO?=
 =?utf-8?B?WERpdHNhUlBaMldPb1ViaUU4QkpoeVlEblZqUms0QTBqU1gzN3B0NU52OG12?=
 =?utf-8?B?cjkycXkyU2cwdy9qYWFGL0Q3Z2N1K1kvem1UdWdrTjN3VTBiYittR2tkTFZi?=
 =?utf-8?B?YitNUXhsc1pITi8yckJWOWFkYkc4K2VqeTNLd2d6TEFORlZ6WE1scGorMS9E?=
 =?utf-8?B?dmI1b0RBMklpOTV0c3NMRzY1VHhHYTFoSko4SVlJRzN4RjJOQVlYK1pybWQ0?=
 =?utf-8?B?SEpwaU9MNzlyaC9ESWI3N0NqNStSQVYrbURwbnhsMEg2T3ZRN2FQek1PTGtM?=
 =?utf-8?B?ZXJMSDFtS2x4Z3c5VjBRcFVvVVladkZ0a3JVanBiQXphT0x4UldUVUtmZCsw?=
 =?utf-8?B?OW40bHRYUFZtTWRqSVgvTDFhUTJ2SlB1Y1NnbHI5bGRINWZ6M1RLMEF2bXd3?=
 =?utf-8?Q?p/yfKFNMHWIfVHuQ3kUGE40ak?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96884bba-bb88-479f-2bc9-08dc9bd79bae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 03:15:51.1621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DDVVgutgIF3qktAv9RVQubwWMvaZpUuWPqa0LSQjp/M7QatugSCJJ8fvviW4MH0WmiSNrfJbe53rfBGtGloIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yuan1.liu@intel.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAzLCAyMDI0IDM6MTYgQU0NCj4gVG86
IFdhbmcsIFlpY2hlbiA8eWljaGVuLndhbmdAYnl0ZWRhbmNlLmNvbT4NCj4gQ2M6IFBhb2xvIEJv
bnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBEYW5pZWwgUC4gQmVycmFuZ8OpDQo+IDxiZXJy
YW5nZUByZWRoYXQuY29tPjsgRWR1YXJkbyBIYWJrb3N0IDxlZHVhcmRvQGhhYmtvc3QubmV0Pjsg
TWFyYy1BbmRyw6kNCj4gTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBUaG9t
YXMgSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT47DQo+IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAbGluYXJvLm9yZz47IEZhYmlhbm8gUm9zYXMNCj4gPGZhcm9zYXNAc3VzZS5kZT47IEVy
aWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPjsgTWFya3VzIEFybWJydXN0ZXINCj4gPGFybWJy
dUByZWRoYXQuY29tPjsgTGF1cmVudCBWaXZpZXIgPGx2aXZpZXJAcmVkaGF0LmNvbT47IHFlbXUt
DQo+IGRldmVsQG5vbmdudS5vcmc7IEhhbyBYaWFuZyA8aGFvLnhpYW5nQGxpbnV4LmRldj47IExp
dSwgWXVhbjENCj4gPHl1YW4xLmxpdUBpbnRlbC5jb20+OyBab3UsIE5hbmhhaSA8bmFuaGFpLnpv
dUBpbnRlbC5jb20+OyBIby1SZW4gKEphY2spDQo+IENodWFuZyA8aG9yZW5jaHVhbmdAYnl0ZWRh
bmNlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzRdIEltcGxlbWVudCB1c2luZyBJ
bnRlbCBRQVQgdG8gb2ZmbG9hZCBaTElCDQo+IA0KPiBPbiBUaHUsIEp1biAyNywgMjAyNCBhdCAw
MzozNDo0MVBNIC0wNzAwLCBZaWNoZW4gV2FuZyB3cm90ZToNCj4gPiB2MzoNCj4gPiAtIFJlYmFz
ZSBjaGFuZ2VzIG9uIHRvcCBvZiBtYXN0ZXINCj4gPiAtIE1lcmdlIHR3byBwYXRjaGVzIHBlciBG
YWJpYW5vIFJvc2FzJ3MgY29tbWVudA0KPiA+IC0gQWRkIHZlcnNpb25zIGludG8gY29tbWVudHMg
YW5kIGRvY3VtZW50YXRpb25zDQo+ID4NCj4gPiB2MjoNCj4gPiAtIFJlYmFzZSBjaGFuZ2VzIG9u
IHRvcCBvZiByZWNlbnQgbXVsdGlmZCBjb2RlIGNoYW5nZXMuDQo+ID4gLSBVc2UgUUFUemlwIEFQ
SSAncXpNYWxsb2MnIGFuZCAncXpGcmVlJyB0byBhbGxvY2F0ZSBRQVQgYnVmZmVycy4NCj4gPiAt
IFJlbW92ZSBwYXJhbWV0ZXIgdHVuaW5nIGFuZCB1c2UgUUFUemlwJ3MgZGVmYXVsdHMgZm9yIGJl
dHRlcg0KPiA+ICAgcGVyZm9ybWFuY2UuDQo+ID4gLSBBZGQgcGFyYW1ldGVyIHRvIGVuYWJsZSBR
QVQgc29mdHdhcmUgZmFsbGJhY2suDQo+ID4NCj4gPiB2MToNCj4gPiBodHRwczovL2xpc3RzLm5v
bmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMy0xMi9tc2cwMzc2MS5odG1sDQo+
ID4NCj4gPiAqIFBlcmZvcm1hbmNlDQo+ID4NCj4gPiBXZSBwcmVzZW50IHVwZGF0ZWQgcGVyZm9y
bWFuY2UgcmVzdWx0cy4gRm9yIGNpcmN1bXN0YW50aWFsIHJlYXNvbnMsIHYxDQo+ID4gcHJlc2Vu
dGVkIHBlcmZvcm1hbmNlIG9uIGEgbG93LWJhbmR3aWR0aCAoMUdicHMpIG5ldHdvcmsuDQo+ID4N
Cj4gPiBIZXJlLCB3ZSBwcmVzZW50IHVwZGF0ZWQgcmVzdWx0cyB3aXRoIGEgc2ltaWxhciBzZXR1
cCBhcyBiZWZvcmUgYnV0IHdpdGgNCj4gPiB0d28gbWFpbiBkaWZmZXJlbmNlczoNCj4gPg0KPiA+
IDEuIE91ciBtYWNoaW5lcyBoYXZlIGEgfjUwR2JwcyBjb25uZWN0aW9uLCB0ZXN0ZWQgdXNpbmcg
J2lwZXJmMycuDQo+ID4gMi4gV2UgaGFkIGEgYnVnIGluIG91ciBtZW1vcnkgYWxsb2NhdGlvbiBj
YXVzaW5nIHVzIHRvIG9ubHkgdXNlIH4xLzIgb2YNCj4gPiB0aGUgVk0ncyBSQU0uIE5vdyB3ZSBw
cm9wZXJseSBhbGxvY2F0ZSBhbmQgZmlsbCBuZWFybHkgYWxsIG9mIHRoZSBWTSdzDQo+ID4gUkFN
Lg0KPiA+DQo+ID4gVGh1cywgdGhlIHRlc3Qgc2V0dXAgaXMgYXMgZm9sbG93czoNCj4gPg0KPiA+
IFdlIHBlcmZvcm0gbXVsdGlmZCBsaXZlIG1pZ3JhdGlvbiBvdmVyIFRDUCB1c2luZyBhIFZNIHdp
dGggNjRHQiBtZW1vcnkuDQo+ID4gV2UgcHJlcGFyZSB0aGUgbWFjaGluZSdzIG1lbW9yeSBieSBw
b3dlcmluZyBpdCBvbiwgYWxsb2NhdGluZyBhIGxhcmdlDQo+ID4gYW1vdW50IG9mIG1lbW9yeSAo
NjBHQikgYXMgYSBzaW5nbGUgYnVmZmVyLCBhbmQgZmlsbGluZyB0aGUgYnVmZmVyIHdpdGgNCj4g
PiB0aGUgcmVwZWF0ZWQgY29udGVudHMgb2YgdGhlIFNpbGVzaWEgY29ycHVzWzBdLiBUaGlzIGlz
IGluIGxpZXUgb2YgYQ0KPiBtb3JlDQo+ID4gcmVhbGlzdGljIG1lbW9yeSBzbmFwc2hvdCwgd2hp
Y2ggcHJvdmVkIHRyb3VibGVzb21lIHRvIGFjcXVpcmUuDQo+ID4NCj4gPiBXZSBhbmFseXplIENQ
VSB1c2FnZSBieSBhdmVyYWdpbmcgdGhlIG91dHB1dCBvZiAndG9wJyBldmVyeSBzZWNvbmQNCj4g
PiBkdXJpbmcgbWlncmF0aW9uLiBUaGlzIGlzIGFkbWl0dGVkbHkgaW1wcmVjaXNlLCBidXQgd2Ug
ZmVlbCB0aGF0IGl0DQo+ID4gYWNjdXJhdGVseSBwb3J0cmF5cyB0aGUgZGlmZmVyZW50IGRlZ3Jl
ZXMgb2YgQ1BVIHVzYWdlIG9mIHZhcnlpbmcNCj4gPiBjb21wcmVzc2lvbiBtZXRob2RzLg0KPiA+
DQo+ID4gV2UgcHJlc2VudCB0aGUgbGF0ZW5jeSwgdGhyb3VnaHB1dCwgYW5kIENQVSB1c2FnZSBy
ZXN1bHRzIGZvciBhbGwgb2YgdGhlDQo+ID4gY29tcHJlc3Npb24gbWV0aG9kcywgd2l0aCB2YXJ5
aW5nIG51bWJlcnMgb2YgbXVsdGlmZCB0aHJlYWRzICg0LCA4LCBhbmQNCj4gPiAxNikuDQo+ID4N
Cj4gPiBbMF0gVGhlIFNpbGVzaWEgY29ycHVzIGNhbiBiZSBhY2Nlc3NlZCBoZXJlOg0KPiA+IGh0
dHBzOi8vc3VuLmFlaS5wb2xzbC5wbC8vfnNkZW9yL2luZGV4LnBocD9wYWdlPXNpbGVzaWENCj4g
Pg0KPiA+ICoqIFJlc3VsdHMNCj4gPg0KPiA+IDQgbXVsdGlmZCB0aHJlYWRzOg0KPiA+DQo+ID4g
ICAgIHwtLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS18LS0t
LS0tLS0tfC0tLS0tLS0tDQo+IC18DQo+ID4gICAgIHxtZXRob2QgICAgICAgICB8dGltZShzZWMp
ICAgICAgfHRocm91Z2hwdXQobWJwcyl8c2VuZCBjcHUlfHJlY3YNCj4gY3B1JXwNCj4gPiAgICAg
fC0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0t
LS18LS0tLS0tLS0NCj4gLXwNCj4gPiAgICAgfHFhdHppcCAgICAgICAgIHwgMjMuMTMgICAgICAg
ICB8IDg3NDkuOTQgICAgICAgIHwxMTcuNTAgICB8MTg2LjQ5DQo+IHwNCj4gPiAgICAgfC0tLS0t
LS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS18LS0t
LS0tLS0NCj4gLXwNCj4gPiAgICAgfHpsaWIgICAgICAgICAgIHwyNTQuMzUgICAgICAgICB8ICA3
NzEuODcgICAgICAgIHwzODguMjAgICB8MTQ0LjQwDQo+IHwNCj4gPiAgICAgfC0tLS0tLS0tLS0t
LS0tLXwtLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS18LS0tLS0tLS0N
Cj4gLXwNCj4gPiAgICAgfHpzdGQgICAgICAgICAgIHwgNTQuNTIgICAgICAgICB8IDM0NDIuNTkg
ICAgICAgIHw0MTQuNTkgICB8MTQ5Ljc3DQo+IHwNCj4gPiAgICAgfC0tLS0tLS0tLS0tLS0tLXwt
LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS18LS0tLS0tLS0NCj4gLXwN
Cj4gPiAgICAgfG5vbmUgICAgICAgICAgIHwgMTIuNDUgICAgICAgICB8NDM3MzkuNjAgICAgICAg
IHwxNTkuNzEgICB8MjA0Ljk2DQo+IHwNCj4gPiAgICAgfC0tLS0tLS0tLS0tLS0tLXwtLS0tLS0t
LS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS18LS0tLS0tLS0NCj4gLXwNCj4gPg0K
PiA+IDggbXVsdGlmZCB0aHJlYWRzOg0KPiA+DQo+ID4gICAgIHwtLS0tLS0tLS0tLS0tLS18LS0t
LS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tfC0tLS0tLS0tDQo+IC18DQo+
ID4gICAgIHxtZXRob2QgICAgICAgICB8dGltZShzZWMpICAgICAgfHRocm91Z2hwdXQobWJwcyl8
c2VuZCBjcHUlfHJlY3YNCj4gY3B1JXwNCj4gPiAgICAgfC0tLS0tLS0tLS0tLS0tLXwtLS0tLS0t
LS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS18LS0tLS0tLS0NCj4gLXwNCj4gPiAg
ICAgfHFhdHppcCAgICAgICAgIHwgMTYuOTEgICAgICAgICB8MTIzMDYuNTIgICAgICAgIHwxODYu
MzcgICB8MzkxLjg0DQo+IHwNCj4gPiAgICAgfC0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0t
LS18LS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS18LS0tLS0tLS0NCj4gLXwNCj4gPiAgICAgfHps
aWIgICAgICAgICAgIHwxMzAuMTEgICAgICAgICB8IDE1MDguODkgICAgICAgIHw3NTMuODYgICB8
Mjg5LjM1DQo+IHwNCj4gPiAgICAgfC0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS18LS0t
LS0tLS0tLS0tLS0tLXwtLS0tLS0tLS18LS0tLS0tLS0NCj4gLXwNCj4gPiAgICAgfHpzdGQgICAg
ICAgICAgIHwgMjcuNTcgICAgICAgICB8IDY4MjMuMjMgICAgICAgIHw3ODYuODMgICB8MzAzLjgw
DQo+IHwNCj4gPiAgICAgfC0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0t
LS0tLS0tLXwtLS0tLS0tLS18LS0tLS0tLS0NCj4gLXwNCj4gPiAgICAgfG5vbmUgICAgICAgICAg
IHwgMTEuODIgICAgICAgICB8NDYwNzIuNjMgICAgICAgIHwxNjMuNzQgICB8MjM4LjU2DQo+IHwN
Cj4gPiAgICAgfC0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0t
LXwtLS0tLS0tLS18LS0tLS0tLS0NCj4gLXwNCj4gPg0KPiA+IDE2IG11bHRpZmQgdGhyZWFkczoN
Cj4gPg0KPiA+ICAgICB8LS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0t
LS0tLS0tfC0tLS0tLS0tLXwtLS0tLS0tLQ0KPiAtfA0KPiA+ICAgICB8bWV0aG9kICAgICAgICAg
fHRpbWUoc2VjKSAgICAgIHx0aHJvdWdocHV0KG1icHMpfHNlbmQgY3B1JXxyZWN2DQo+IGNwdSV8
DQo+ID4gICAgIHwtLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0t
LS18LS0tLS0tLS0tfC0tLS0tLS0tDQo+IC18DQo+ID4gICAgIHxxYXR6aXAgICAgICAgICB8MTgu
NjQgICAgICAgICAgfDExMDQ0LjUyICAgICAgICB8IDU3My42MSAgfDQzNy42NQ0KPiB8DQo+ID4g
ICAgIHwtLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS18LS0t
LS0tLS0tfC0tLS0tLS0tDQo+IC18DQo+ID4gICAgIHx6bGliICAgICAgICAgICB8NjYuNDMgICAg
ICAgICAgfCAyOTU1Ljc5ICAgICAgICB8MTQ2OS42OCAgfDU2Ny40Nw0KPiB8DQo+ID4gICAgIHwt
LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0t
fC0tLS0tLS0tDQo+IC18DQo+ID4gICAgIHx6c3RkICAgICAgICAgICB8MTQuMTcgICAgICAgICAg
fDEzMjkwLjY2ICAgICAgICB8MTUwNC4wOCAgfDYxNS4zMw0KPiB8DQo+ID4gICAgIHwtLS0tLS0t
LS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tfC0tLS0t
LS0tDQo+IC18DQo+ID4gICAgIHxub25lICAgICAgICAgICB8MTYuODIgICAgICAgICAgfDMyMzYz
LjI2ICAgICAgICB8IDE4MC43NCAgfDIxNy4xNw0KPiB8DQo+ID4gICAgIHwtLS0tLS0tLS0tLS0t
LS18LS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tfC0tLS0tLS0tDQo+
IC18DQo+ID4NCj4gPiAqKiBPYnNlcnZhdGlvbnMNCj4gPg0KPiA+IC0gSW4gZ2VuZXJhbCwgbm90
IHVzaW5nIGNvbXByZXNzaW9uIG91dHBlcmZvcm1zIHVzaW5nIGNvbXByZXNzaW9uIGluIGENCj4g
PiAgIG5vbi1uZXR3b3JrLWJvdW5kIGVudmlyb25tZW50Lg0KPiA+IC0gJ3FhdHppcCcgb3V0cGVy
Zm9ybXMgb3RoZXIgY29tcHJlc3Npb24gd29ya2VycyB3aXRoIDQgYW5kIDggd29ya2VycywNCj4g
PiAgIGFjaGlldmluZyBhIH45MSUgbGF0ZW5jeSByZWR1Y3Rpb24gb3ZlciAnemxpYicgd2l0aCA0
IHdvcmtlcnMsIGFuZCBhDQo+ID4gfjU4JSBsYXRlbmN5IHJlZHVjdGlvbiBvdmVyICd6c3RkJyB3
aXRoIDQgd29ya2Vycy4NCj4gPiAtICdxYXR6aXAnIG1haW50YWlucyBjb21wYXJhYmxlIHBlcmZv
cm1hbmNlIHdpdGggJ3pzdGQnIGF0IDE2IHdvcmtlcnMsDQo+ID4gICBzaG93aW5nIGEgfjMyJSBp
bmNyZWFzZSBpbiBsYXRlbmN5LiBUaGlzIHBlcmZvcm1hbmNlIGRpZmZlcmVuY2UNCj4gPiBiZWNv
bWVzIG1vcmUgbm90aWNlYWJsZSB3aXRoIG1vcmUgd29ya2VycywgYXMgQ1BVIGNvbXByZXNzaW9u
IGlzIGhpZ2hseQ0KPiA+IHBhcmFsbGVsaXphYmxlLg0KPiA+IC0gJ3FhdHppcCcgY29tcHJlc3Np
b24gdXNlcyBjb25zaWRlcmFibHkgbGVzcyBDUFUgdGhhbiBvdGhlciBjb21wcmVzc2lvbg0KPiA+
ICAgbWV0aG9kcy4gQXQgOCB3b3JrZXJzLCAncWF0emlwJyBkZW1vbnN0cmF0ZXMgYSB+NzUlIHJl
ZHVjdGlvbiBpbg0KPiA+IGNvbXByZXNzaW9uIENQVSB1c2FnZSBjb21wYXJlZCB0byAnenN0ZCcg
YW5kICd6bGliJy4NCj4gPiAtICdxYXR6aXAnIGRlY29tcHJlc3Npb24gQ1BVIHVzYWdlIGlzIGxl
c3MgaW1wcmVzc2l2ZSwgYW5kIGlzIGV2ZW4NCj4gPiAgIHNsaWdodGx5IHdvcnNlIHRoYW4gJ3pz
dGQnIGFuZCAnemxpYicgQ1BVIHVzYWdlIGF0IDQgYW5kIDE2IHdvcmtlcnMuDQo+IA0KPiBUaGFu
a3MgZm9yIHRoZSByZXN1bHRzIHVwZGF0ZS4NCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhlIGRvY3Mv
bWlncmF0aW9uLyBmaWxlIGlzIHN0aWxsIG1pc3NpbmcuICBJdCdsbCBiZSBncmVhdA0KPiB0bw0K
PiBoYXZlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24gb3Igc2VwYXJhdGVseS4NCj4gDQo+IFNvIGhv
dyBpdCBjb21wYXJlcyB3aXRoIFFQTCAod2hpY2ggZ290IG1lcmdlZCBhbHJlYWR5KT8gIFRoZXkg
YXQgbGVhc3QNCj4gbG9vaw0KPiBsaWtlIGJvdGggc3VwcG9ydGVkIG9uIGFuIEludGVsIHBsYXRm
b3JtLCBzbyBhbiB1c2VyIHdob2V2ZXIgd2FudHMgdG8NCj4gY29tcHJlc3MgdGhlIFJBTSBjb3Vs
ZCBzdGFydCB0byBsb29rIGF0IGJvdGguICBJJ20gdXR0ZXJseSBjb25mdXNlZCBvbiB3aHkNCj4g
SW50ZWwgcHJvdmlkZXMgdGhlc2UgdHdvIHNpbWlsYXIgY29tcHJlc3NvcnMuICBJdCB3b3VsZCBi
ZSBncmVhdCB0byBoYXZlDQo+IHNvbWUgYW5zd2VyIGFuZCBwZXJoYXBzIHB1dCBpbnRvIHRoZSBk
b2MuDQoNCkkgd291bGQgbGlrZSB0byBleHBsYWluIHNvbWUgb2YgdGhlIHJlYXNvbnMgd2h5IHdl
IHdhbnQgdG8gbWVyZ2UgdGhlIA0KdHdvIFFBVCBhbmQgSUFBIHNvbHV0aW9ucyBpbnRvIHRoZSBj
b21tdW5pdHkuDQoNCjEuIEFsdGhvdWdoIEludGVsIFhlb24gU2FwcGhpcmUgUmFwaWRzIHN1cHBv
cnRzIGJvdGggUUFUIGFuZCBJQUEsIGRpZmZlcmVudCANCiAgIFNLVXMgc3VwcG9ydCBkaWZmZXJl
bnQgbnVtYmVycyBvZiBRQVQgYW5kIElBQSwgc28gc29tZSB1c2VycyBkbyBub3QgaGF2ZSANCiAg
IGJvdGggUUFUIGFuZCBJQUEgYXQgdGhlIHNhbWUgdGltZS4NCg0KMi4gUUFUIHByb2R1Y3RzIGlu
Y2x1ZGUgUENJZSBjYXJkcywgd2hpY2ggYXJlIGNvbXBhdGlibGUgd2l0aCBvbGRlciBYZW9uDQog
ICBwcm9kdWN0cyBhbmQgb3RoZXIgbm9uLVhlb24gcHJvZHVjdHMuIEFuZCBzb21lIHVzZXJzIGhh
dmUgYWxyZWFkeSB1c2VkIFFBVA0KICAgY2FyZHMgdG8gYWNjZWxlcmF0ZSBsaXZlIG1pZ3JhdGlv
bi4NCg0KMy4gSW4gYWRkaXRpb24gdG8gY29tcHJlc3Npb24sIFFBVCBhbmQgSUFBIGFsc28gc3Vw
cG9ydCB2YXJpb3VzIG90aGVyIGZlYXR1cmVzIA0KICAgdG8gYmV0dGVyIHNlcnZlIGRpZmZlcmVu
dCB3b3JrbG9hZHMuIEhlcmUgaXMgYW4gaW50cm9kdWN0aW9uIHRvIHRoZSBhY2NlbGVyYXRvcnMs
DQogICBpbmNsdWRpbmcgdXNhZ2Ugc2NlbmFyaW9zIG9mIFFBVCBhbmQgSUFBLg0KICAgaHR0cHM6
Ly93d3cuaW50ZWwuY29tL2NvbnRlbnQvZGFtL3d3dy9jZW50cmFsLWxpYnJhcmllcy91cy9lbi9k
b2N1bWVudHMvMjAyMi0xMi9zdG9yYWdlLWVuZ2luZXMtNHRoLWdlbi14ZW9uLWJyaWVmLnBkZg0K
DQpGb3IgdXNlcnMgd2hvIGhhdmUgYm90aCBRQVQgYW5kIElBQSwgd2UgcmVjb21tZW5kIHRoZSBm
b2xsb3dpbmcgZm9yIGNob29zaW5nIGEgDQpsaXZlIG1pZ3JhdGlvbiBzb2x1dGlvbjoNCg0KMS4g
SWYgdGhlIG51bWJlciBvZiBRQVQgZGV2aWNlcyBpcyBlcXVhbCB0byBvciBncmVhdGVyIHRoYW4g
dGhlIG51bWJlciBvZiBJQUEgZGV2aWNlcyANCiAgIGFuZCBuZXR3b3JrIGJhbmR3aWR0aCBpcyBs
aW1pdGVkLCBpdCBpcyByZWNvbW1lbmRlZCB0byB1c2UgdGhlIFFBVFppcChRQVQpIHNvbHV0aW9u
Lg0KDQoyLiBJbiBvdGhlciBzY2VuYXJpb3MsIHRoZSBRUEwgKElBQSkgc29sdXRpb24gY2FuIGJl
IHVzZWQgZmlyc3QuDQoNCj4gSSBhbSBob25lc3RseSBjdXJpb3VzIHRvbyBvbiB3aGV0aGVyIGFy
ZSB5b3UgcGxhbm5pbmcgdG8gdXNlIGl0IGluDQo+IHByb2R1Y3Rpb24uICBJdCBsb29rcyBsaWtl
IGlmIHRoZSBuZXR3b3JrIHJlc291cmNlcyBhcmUgcmljaCwgbm8tY29tcCBpcw0KPiBtb3N0bHkg
YWx3YXlzIGJldHRlciB0aGFuIHFhdHppcCwgbm8gbWF0dGVyIG9uIHRvdGFsIG1pZ3JhdGlvbiB0
aW1lIG9yIGNwdQ0KPiBjb25zdW1wdGlvbi4gIEknbSBwcmV0dHkgc3VycHJpc2VkIHRoYXQgaXQn
bGwgdGFrZSB0aGF0IG11Y2ggcmVzb3VyY2VzDQo+IGV2ZW4NCj4gaWYgdGhlIHdvcmsgc2hvdWxk
IGhhdmUgYmVlbiBvZmZsb2FkZWQgdG8gdGhlIFFBVCBjaGlwcyBpaXVjLg0KPiANCj4gSSB0aGlu
ayBpdCBtYXkgbm90IGJlIGEgcHJvYmxlbSB0byBtZXJnZSB0aGlzIHNlcmllcyBldmVuIGlmIGl0
IHBlcmZvcm1zDQo+IHNsb3dlciBhdCBzb21lIGNyaXRlcmlhcy4uIGJ1dCBJIHRoaW5rIHdlIG1h
eSBzdGlsbCB3YW50IHRvIGtub3cgd2hlbiB0aGlzDQo+IHNob3VsZCBiZSB1c2VkLCBvciB0aGUg
Z29vZCByZWFzb24gdGhpcyBzaG91bGQgYmUgbWVyZ2VkIChpZiBpdCdzIG5vdA0KPiBhYm91dA0K
PiBpdCBvdXRwZXJmb3JtcyBvdGhlcnMpLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gPg0KPiA+DQo+
ID4gQnJ5YW4gWmhhbmcgKDQpOg0KPiA+ICAgbWVzb246IEludHJvZHVjZSAncWF0emlwJyBmZWF0
dXJlIHRvIHRoZSBidWlsZCBzeXN0ZW0NCj4gPiAgIG1pZ3JhdGlvbjogQWRkIG1pZ3JhdGlvbiBw
YXJhbWV0ZXJzIGZvciBRQVR6aXANCj4gPiAgIG1pZ3JhdGlvbjogSW50cm9kdWNlICdxYXR6aXAn
IGNvbXByZXNzaW9uIG1ldGhvZA0KPiA+ICAgdGVzdHMvbWlncmF0aW9uOiBBZGQgaW50ZWdyYXRp
b24gdGVzdCBmb3IgJ3FhdHppcCcgY29tcHJlc3Npb24gbWV0aG9kDQo+ID4NCj4gPiAgaHcvY29y
ZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMgfCAgIDYgKy0NCj4gPiAgbWVzb24uYnVpbGQgICAg
ICAgICAgICAgICAgICAgICAgfCAgMTAgKw0KPiA+ICBtZXNvbl9vcHRpb25zLnR4dCAgICAgICAg
ICAgICAgICB8ICAgMiArDQo+ID4gIG1pZ3JhdGlvbi9tZXNvbi5idWlsZCAgICAgICAgICAgIHwg
ICAxICsNCj4gPiAgbWlncmF0aW9uL21pZ3JhdGlvbi1obXAtY21kcy5jICAgfCAgIDggKw0KPiA+
ICBtaWdyYXRpb24vbXVsdGlmZC1xYXR6aXAuYyAgICAgICB8IDM4MiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIG1pZ3JhdGlvbi9tdWx0aWZkLmggICAgICAgICAgICAgIHwg
ICAxICsNCj4gPiAgbWlncmF0aW9uL29wdGlvbnMuYyAgICAgICAgICAgICAgfCAgNTcgKysrKysN
Cj4gPiAgbWlncmF0aW9uL29wdGlvbnMuaCAgICAgICAgICAgICAgfCAgIDIgKw0KPiA+ICBxYXBp
L21pZ3JhdGlvbi5qc29uICAgICAgICAgICAgICB8ICAzOCArKysNCj4gPiAgc2NyaXB0cy9tZXNv
bi1idWlsZG9wdGlvbnMuc2ggICAgfCAgIDYgKw0KPiA+ICB0ZXN0cy9xdGVzdC9tZXNvbi5idWls
ZCAgICAgICAgICB8ICAgNCArDQo+ID4gIHRlc3RzL3F0ZXN0L21pZ3JhdGlvbi10ZXN0LmMgICAg
IHwgIDM1ICsrKw0KPiA+ICAxMyBmaWxlcyBjaGFuZ2VkLCA1NTEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgbWlncmF0aW9uL211bHRpZmQtcWF0
emlwLmMNCj4gPg0KPiA+IC0tDQo+ID4gWWljaGVuIFdhbmcNCj4gPg0KPiANCj4gLS0NCj4gUGV0
ZXIgWHUNCg0K

