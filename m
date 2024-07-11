Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F1DC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 12:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsdu-00061N-RP; Thu, 11 Jul 2024 08:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sRsdY-0004s8-K9
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:11:03 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sRsdQ-0003Hv-RV
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720699853; x=1752235853;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h/agJrwO6WsTkuBTb+4LZ5YfxAUlaohL7QDhqVB4bI4=;
 b=OrKJHiYb2/qVSRbMH129MGSSfUOPu5v3FyVWacin9j+UksqWM6M7lPl4
 yZtQJh6XgS4dst2DnnLQcRPxdzHPVoE6GlxTSV8Y0y1uMa7hrA0pcAAWq
 lpWBpYDvw7bI+AxiDTMyvqShQ4dWhbx7CK+0kdS7cVx+K4QIZNKpWIqxw
 laElL9Y8qodOZvL1Lq8WlG0Ze70oqQo2FR96UaMziNGnzaSLMSR7cxWKW
 xZzc7iX1q7j96BLEvUdE85Q3q1YkSQSK26ha7lmpqpVgK9abUIhLkuW8e
 CvuJtalNQTdvuYY3AWLkgEKY8Vu+jxJskShVEI7Playijtg/sqmtLs9q2 w==;
X-CSE-ConnectionGUID: OGCPcD4rSBOdgBMgsZw5fA==
X-CSE-MsgGUID: kbdGUZR5R+Grc69SS72e0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17890545"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; d="scan'208";a="17890545"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2024 05:10:43 -0700
X-CSE-ConnectionGUID: 8iMcmu23SueTneulE4XF9w==
X-CSE-MsgGUID: mbEgbEWIQMS9H1X3nrR1Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; d="scan'208";a="48432687"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jul 2024 05:10:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 05:10:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 05:10:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 05:10:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 05:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpJfPW3/nrNlpHRyymeJy3L9tIvLdl+kwafvFWGl6WkgyZLUtzBmN71G9QdSFdx986pQenZDe5JVfbx1qRcxcwbRrppowKfs1PSMd5l5HAkjJ8gHJxotEW8F5JNy/3F6yzsONZg/ZExniuVXtrKwHWurAQ+ooNTiudoIlPIgGFGXOvsevz0y/DBJx/TLmEuqKzGMz3Ai8JbakQgs+MvYO/g+KUyIwH7KFgz7QSfyBgwkPvOL/+pHOzrReUY/BJyG5iFHLLh4aN5EgsdCljjVgcmv1FWijCvZUv/78vRFj00kdkpEcIEPwBv7Pg6C/9TxJpZXEcyTpePrDPKHQQPS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/agJrwO6WsTkuBTb+4LZ5YfxAUlaohL7QDhqVB4bI4=;
 b=Cul9TJppFBYssL0+S7As0thtjtJPtTWJK7nTks+dmaqg8P+4WoIkWlqL4qfyNBBrf2Cm4Ync++CA0HVzuKAmS5FoVSuNF1S+9LlBiw9vvmhWUPJEvGDrGTxtXEec8V0gtcDvlYpxCKwzH4Wg72osaw8sNTEm7fILbAq1EhL6t4TYk5yaT4nEDnEO8kozwxkOVqzDuEs79O1Fq4GiRy1jdu9eplszckrAKRFuFfiCX0RXXVj0T2oxixWoQ4LN9xuQW+lKAo1CAH41GrLFWj33sSYwB+wLO5ZBuYW/zqvks2HO1e91WPGQdXkvQQCMpumcDz53NG5Xx2B+Iy0rMJ7Puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 PH7PR11MB6795.namprd11.prod.outlook.com (2603:10b6:510:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Thu, 11 Jul
 2024 12:10:34 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 12:10:34 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Wang, Lei4" <lei4.wang@intel.com>
Subject: RE: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid is
 set to false
Thread-Topic: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid
 is set to false
Thread-Index: AQHazVg5C0RiDxJPOUeRPpagSbRqXrHxdZ6AgAACIHA=
Date: Thu, 11 Jul 2024 12:10:34 +0000
Message-ID: <DS0PR11MB6373A148EDE4EB3125B6C42DDCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <Zo_GZfR1sQH06TCp@redhat.com>
In-Reply-To: <Zo_GZfR1sQH06TCp@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|PH7PR11MB6795:EE_
x-ms-office365-filtering-correlation-id: 4bb7c583-79dc-4cc8-64cf-08dca1a277b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L3JDZE5JNkpWRHJ4Y1I5L2NqR2psQWVXYVhrWWNKWndmY2FvRTVreCs0T2Na?=
 =?utf-8?B?N3hGaXpCNkFyZ0F6NWw4RWtMNVdZTDhiRHhuV3FaQVJHaUM3d1Z2TW1rRTlU?=
 =?utf-8?B?ekxWSUwwc05uY3NWcDlzR245a25sTFpJdzc1MVRJd2dkdTdOcFdpamlIUm1X?=
 =?utf-8?B?UkpqRWNXZ2JFYmc3dFExYmp0aHZEUTlyUW5laHhnRUg2WTVJKzY3ZlREazVQ?=
 =?utf-8?B?cEFaeXRocHpMOTRuU0NjZ3JQc3cvZ3ZUTUdoZEkwMG1SYmlHeVVRQzBxM3ho?=
 =?utf-8?B?NzlwclFuWWdvK3FraDFQVVBxUm4rSWlCRnFBcnFxRk9hL1BUSTFlNjIvbFdn?=
 =?utf-8?B?NG5ZVU9LQ2d3TUEvSm5peHRieTZuMXFTb1JLR3QrOXQ2OGtRd0NnU244dEdE?=
 =?utf-8?B?alpiekRsVVI2K0E3czJ3RnllK096Z09ZSC9Ob2lJSkNicXh2MlpNejFDenlV?=
 =?utf-8?B?aVk4M2tEaCtVRHRGNFdMMkJrRWpvMk9Ic3Z2ZkFpZ2FqL1psRUMvTFFaK0ls?=
 =?utf-8?B?M3pFTmd3UzhTU0JIZEo4NGhGaVRVVlVpeUZxK2dFc082ZWlvMXJVV213NCtP?=
 =?utf-8?B?UW9YYjNpOFdnZjZwOXhLVmFJeXRabWF2anlDbU9mNStLT0VyZjlFZEZTMVVm?=
 =?utf-8?B?bU0wVVh5S3pVZm1hVzdCWFB5SkJldUkrbXd2R3ZDRHZ2WU9OME5neVIyb1BO?=
 =?utf-8?B?RkJhUnh1bjJJRjZKN3g1RXpSQ2hzZ1h4MWdaTFJ4SlJOZXYwNDNRa05iNjh4?=
 =?utf-8?B?djhtdXJGQjBQeStRbHFLUk9jcWwzemg1cnFTc1ZBTTFvZEpPY2ZpTmh1ak0r?=
 =?utf-8?B?SkpnUzhuU3V6NHorUW1PbGRoaWQwWkFRSmJSL1J2aytGVk1uUzlORUdKTys2?=
 =?utf-8?B?cS9odFAvQTB5dXl5NkJYZmtmbGxJNDF5Ym0xZkhHcG11TWh0eHhLMmhRZ3Ax?=
 =?utf-8?B?YjdIUUF6NjR2MU5kNjZBc0ZmcFhXQkd2YlNNelBXa1BCakZwNEFwTU1KNEtX?=
 =?utf-8?B?dzN2TnRWZU5qNkJrcjBJRmk0dTQ1L25uSEFRK1FDVE5yVHhTUTRsZ1JXTWNj?=
 =?utf-8?B?eTJQNjNyejFBUHRkR1pPZDdscFhwbWFqK3F1UStad1ZkYURRK0NBWlpDMlYy?=
 =?utf-8?B?eG1tZDMyQkF0TXRRVjlYZE9LMTdXNkFwTXhRZGZ0eFpQRTFiWHN0K0xoeVhm?=
 =?utf-8?B?dXQrSGpza0tlcjF5Z0NnQWFYc3diSThhRHU3Z2JYbXhuZ0pCYmduZEJGb09u?=
 =?utf-8?B?cEFGMmZMZ1hDTGQ1UzVjZ0pIRkxqWUp0c05FUTFSTFJEbnNtNHJDUENmM3hu?=
 =?utf-8?B?N3JSUE9BZ1R5dllGZlBEbHVLMW01MXJSWjFaTFhqYW1zd2JoQlU2Q0F6NkdT?=
 =?utf-8?B?MTZqbHZ0bm5LdnBJWklaS0d3NGcyajl6cVpiSlZlUklrcTNxQTdQOHhkT0JK?=
 =?utf-8?B?Tit6M3BJd0hldlBXeW9Tb1Z3Z0pxQndQUllFbHd1U1NhK3dpZmtZVUxsaUFi?=
 =?utf-8?B?S0VZaWt2ZUY5R3NWYzY1WHVYUmt2a28zclB0eG9peUx4L2p5SUhCbU1vYVpY?=
 =?utf-8?B?SE5vN3VXdEVRdkZBS2xuRW90NC9yRWxad0ZiWngxcVhSQ1RpTTlKTENja21W?=
 =?utf-8?B?bVZGcFgxSXdwL3VPdGNQaHNGUCtDcnROTzF4UlF2aU02cTRXeE1sY3FKL0Mr?=
 =?utf-8?B?OERISUZBSEtrMXphOTVyaFpwcFFPTVBYeHVwU25QU2JYQk9XWFhkc3lIOWNn?=
 =?utf-8?B?TnVHeWRKWS9BcFN1QVRGV1E4UGxQSzJtMldDOGEyUkFYbm5veU5zd2dLNXdO?=
 =?utf-8?B?b2FhOUNObmxwZmMwcGVPbXRmT2FvRXY3VHAzSWZTQ3lHNHNkU3Q4QklSM0hy?=
 =?utf-8?B?WWtEaUllcEcwR3U0V0FPSExnd0xyTXVMR3VmTEg2WDRrUkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVA3SEtqTW1Ra0FrZm9SRUNRREt5UEVJMHlTMEFWWlFpbWMzNmlncHdTWStZ?=
 =?utf-8?B?ZmJFT0wzMjFpRGphalBzdkl0UUkyMFpPbm9vWlNKYUkzdWxILzZMQnpzNGtk?=
 =?utf-8?B?SGY3Z3FYR1pDVml3bWhnc2owVTY2eFdFZkRoN0F6UURVUnZQZFJqUmZiNDZy?=
 =?utf-8?B?RkFBVTc2YmVjcDNBc2hQWUZEOUthckdJbFF2LzltSGVlYS8vWFRXQzR5TXp5?=
 =?utf-8?B?am1aclpWQy9EWGtiZlNUQ1hvT0tZRTNlUE5yanN6K1cxd2RwZ1BESTFVb1Rv?=
 =?utf-8?B?RGdOVEovMnJSOS8zbXZtZGRDUEpwa2RxWk1vakVzbERVSmpIcGZlV0Fvd0hC?=
 =?utf-8?B?QzJ3MGt0K2RXSlpnVFdEZWladkVuellPY2FYL0pvZlNHQUhJWUVHdm1GRVhq?=
 =?utf-8?B?eGRuU3RlZEpMRXMvRldIcmdrajNnOEttUDRGTFJWUVFVRnQ4YVFKU0FnWGxO?=
 =?utf-8?B?L0xnUmlXLytrc1dsbFlZY2ZtK2dxVDhkQjQrcnZSd0JYVnJjWUN4VStGaTdx?=
 =?utf-8?B?dTBJZm0rbXdqcUl1TVpNMzJKcHVraG1JMFJNQjFDdmNkU1NPQkJZUGMvSUNU?=
 =?utf-8?B?a1hJOVdpTVNqdzlhZXVVbVFybE9ZbmxkTDY5dmZFbkY1WGd0bElDdklQdGZ4?=
 =?utf-8?B?cXNNL0FicjlKS2I3b1M0OWUxRkVTMURoa0IxYng2QmF0Y1pTMXpZd3dseFZV?=
 =?utf-8?B?cSs3RUp1OUFHNGZKMnArS1lyelk1Y3FXbm93UE91Y241L1BhTWNEdTdiUmNI?=
 =?utf-8?B?VDgyWjd6ZXduZHNRc3VYVkhNcThlaCthY2tCaDBJR082TjFnUjRwMlVLaUN2?=
 =?utf-8?B?MDF0TGg4UEx4N1VPTlA4ay9NaEtaWVc3ajJ5RlJ1Yy81UkkrdTVrcnErU2xw?=
 =?utf-8?B?Mmx6M1RaSHo1SkxhbVprTVNTRzNZeitHUENGL1VpMm95NUduZFRCRGhDdEtt?=
 =?utf-8?B?WVB3WkY2eCtaTllva3I1YjhCbGxDRm56bldoVXVrWXQxcjd2bkJwK2o1cWg2?=
 =?utf-8?B?SVd2bzgzSm8wTHdvK2drVHoyWHB6M3NrRmFWWGZzQlNwU0tzbi9nVzRwSlFC?=
 =?utf-8?B?Sk8ya0lWenV1NW9XWnJnQm5jc3lNNUliL2YxdENrT1JZU1hkS1hGeGJpYkRI?=
 =?utf-8?B?dHB0MnFzMUVwdnNzQmpuVjV0RDR2amE4c0hOaWRvN1hwQ0RQNGRyQ2lyaFAv?=
 =?utf-8?B?VkhOYXdIclI2SWFzbHpWSXNOcDdlQkZxbE1FNFpYWWRKZ0x3KzVjeWVXamdk?=
 =?utf-8?B?Mk1DTU45RGY4NzFlYTFLV2ZlL2pnTDUyYlBYeEMyZ2N5QWtNZHdpLzc5T08z?=
 =?utf-8?B?bDcwSll1bTZRSHVuS3c5UHk2NTlML2UzNUNYOWRkTWdTTDV5MUJRcGxjTHRF?=
 =?utf-8?B?dWJseUpSZEVnb01zRXVOenFmRStZbjZuaG1xazFOMFM0TGNzQ292RUF3N3dv?=
 =?utf-8?B?SzNwaGkxL3d1eVpGY21MSS82K1I5K09DMUFaRElLckVWNnBhekFRQ1plSnBJ?=
 =?utf-8?B?bXpUR0VWR25oeCtNOUh5dGpDSC8zWHFqRXhsb1BQcGR0MENoZ3Y4VDJ6R0po?=
 =?utf-8?B?NTYxaVpjRSs3dFZodWJ2MUVYRHNFRitDZ2FoNEN6b3hEQisrdG9XNVBHOVl2?=
 =?utf-8?B?Vit1YkdLTnRmbEl0cTB6OFVUQ1N4c3Y2ekdqOW05VWtvMWZYYnRSakFNa2Jo?=
 =?utf-8?B?ektqRGo0Sk9tYjdobWMwZ1ByL0kzbzF6Wk51OWRGeCtEdzNUQ2pyeE9qeXE3?=
 =?utf-8?B?V1NuSmRkREpNN3h1QWM2ZFVITGdqempyTXRteVcvZy9XdXJtT1o2ckpmNTBH?=
 =?utf-8?B?SGkxeHhCRm1kZjVDMUJjR2VzS2FMREgxQk9WaXVlUDBnWXFId2JiOE1WSTYw?=
 =?utf-8?B?MnZxZ1lnUFZkRmxVNUNZakNUeXBiNlU5NVhSTEhrTXRrOHFjdCtYTFpxNm5u?=
 =?utf-8?B?SlJ4dHNjc2QwcUlzWjJLNDlQeFpKbk44RExiVnZrNTBPaVl3ampIZzlZNENS?=
 =?utf-8?B?cmxYbUJDaXNTdXdRZWZlUzZ3aGhESjBtbmp5cnRWMFlESHozZVBieE5KcnJ4?=
 =?utf-8?B?bVF2cDZVeVgxWEpTSDNmSGhCWDhhNHRsNmpWUkJSYitxOTcvWGZEc2l3MWRM?=
 =?utf-8?Q?KMdm3ENqNJsKOKKcrqsacNUgG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb7c583-79dc-4cc8-64cf-08dca1a277b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 12:10:34.4717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSV1oT98XzZdGEMRfi2YQcXkFNARLAasK0ussWi5Na6VwzrqOscczy3KjP0aniJcsqf1pObFP6ejISkXpjYRkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6795
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

T24gVGh1cnNkYXksIEp1bHkgMTEsIDIwMjQgNzo0OCBQTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3
cm90ZToNCj4gT24gV2VkLCBKdWwgMDMsIDIwMjQgYXQgMTA6NDk6MTJQTSArMDgwMCwgV2VpIFdh
bmcgd3JvdGU6DQo+ID4gV2hlbiBlbmZvcmNlX2NwdWlkIGlzIHNldCB0byBmYWxzZSwgdGhlIGd1
ZXN0IGlzIGxhdW5jaGVkIHdpdGggYQ0KPiA+IGZpbHRlcmVkIHNldCBvZiBmZWF0dXJlcywgbWVh
bmluZyB0aGF0IHVuc3VwcG9ydGVkIGZlYXR1cmVzIGJ5IHRoZQ0KPiA+IGhvc3QgYXJlIHJlbW92
ZWQgZnJvbSB0aGUgZ3Vlc3QncyB2Q1BVIG1vZGVsLiBUaGlzIGNvdWxkIGNhdXNlIGlzc3VlcyBm
b3INCj4gbGl2ZSBtaWdyYXRpb24uDQo+ID4gRm9yIGV4YW1wbGUsIGEgZ3Vlc3Qgb24gdGhlIHNv
dXJjZSBpcyBydW5uaW5nIHdpdGggZmVhdHVyZXMgQSBhbmQgQi4NCj4gPiBJZiB0aGUgZGVzdGlu
YXRpb24gaG9zdCBkb2VzIG5vdCBzdXBwb3J0IGZlYXR1cmUgQiwgdGhlIHN0dWIgZ3Vlc3QgY2Fu
DQo+ID4gc3RpbGwgYmUgbGF1bmNoZWQgb24gdGhlIGRlc3RpbmF0aW9uIHdpdGggZmVhdHVyZSBB
IG9ubHkgaWYgZW5mb3JjZV9jcHVpZD1mYWxzZS4NCj4gPiBMaXZlIG1pZ3JhdGlvbiBjYW4gc3Rh
cnQgaW4gdGhpcyBjYXNlLCB0aG91Z2ggaXQgbWF5IGZhaWwgbGF0ZXIgd2hlbg0KPiA+IHRoZSBz
dGF0ZXMgb2YgZmVhdHVyZSBCIGFyZSBwdXQgdG8gdGhlIGRlc3RpbmF0aW9uIHNpZGUuIFRoaXMg
ZmFpbHVyZQ0KPiA+IG9jY3VycyBpbiB0aGUgbGF0ZSBzdGFnZSAoaS5lLiwgc3RvcCZjb3B5IHBo
YXNlKSBvZiB0aGUgbWlncmF0aW9uDQo+ID4gZmxvdywgd2hlcmUgdGhlIHNvdXJjZSBndWVzdCBo
YXMgYWxyZWFkeSBiZWVuIHBhdXNlZC4gVGVzdHMgc2hvdyB0aGF0DQo+ID4gaW4gc3VjaCBjYXNl
cyB0aGUgc291cmNlIGd1ZXN0IGRvZXMgbm90IHJlY292ZXIsIGFuZCB0aGUgZGVzdGluYXRpb24N
Cj4gPiBpcyB1bmFibGUgdG8gcmVzdW1lIHRvIHJ1bi4NCj4gPg0KPiA+IE1ha2UgImVuZm9yZV9j
cHVpZD10cnVlIiBhIGhhcmQgcmVxdWlyZW1lbnQgZm9yIGEgZ3Vlc3QgdG8gYmUNCj4gPiBtaWdy
YXRhYmxlLCBhbmQgY2hhbmdlIHRoZSBkZWZhdWx0IHZhbHVlIG9mICJlbmZvcmNlX2NwdWlkIiB0
byB0cnVlLA0KPiA+IG1ha2luZyB0aGUgZ3Vlc3QgdkNQVXMgbWlncmF0YWJsZSBieSBkZWZhdWx0
LiBJZiB0aGUgZGVzdGluYXRpb24gc3R1Yg0KPiA+IGd1ZXN0IGhhcyBpbmNvbnNpc3RlbnQgQ1BV
SURzIChpLmUuLCBkZXN0aW5hdGlvbiBob3N0IGNhbm5vdCBzdXBwb3J0DQo+ID4gdGhlIGZlYXR1
cmVzIGRlZmluZWQgYnkgdGhlIGd1ZXN0J3MgdkNQVSBtb2RlbCksIGl0IGZhaWxzIHRvIGJvb3QN
Cj4gPiAod2l0aCBlbmZvcmVfY3B1aWQ9dHJ1ZSBieSBkZWZhdWx0KSwgdGhlcmVieSBwcmV2ZW50
aW5nIG1pZ3JhdGlvbiBmcm9tDQo+ID4gb2NjdXJpbmcuIElmIGVuZm9yZV9jcHVpZD1mYWxzZSBp
cyBleHBsaWNpdGx5IGFkZGVkIGZvciB0aGUgZ3Vlc3QsIHRoZQ0KPiA+IGd1ZXN0IGlzIGRlZW1l
ZCBhcyBub24tbWlncmF0YWJsZSAodmlhIHRoZSBtaWdyYXRpb24gYmxvY2tlciksIHNvIHRoZQ0K
PiA+IGFib3ZlIGlzc3VlIHdvbid0IG9jY3VyIGFzIHRoZSBndWVzdCB3b24ndCBiZSBtaWdyYXRl
ZC4NCj4gDQo+IEJsb2NraW5nIG1pZ3JhdGlvbiB3aGVuIGVuZm9yY2U9ZmFsc2UgaXMgbWFraW5n
IGFuIGFzc3VtcHRpb24gdGhhdCB1c2VycyBvZg0KPiB0aGF0IHNldHRpbmcgYXJlIGluaGVyYW50
bHkgYnJva2VuLiBUaGlzIGlzIE5PVCB0aGUgY2FzZSBpZiB0aGUgdXNlci9hcHAgaGFzDQo+IGFs
cmVhZHkgdmFsaWRhdGVkIGNvbXBhdGliaWxpdHkgaW4gc29tZSBtYW5uZXIgb3V0c2lkZSBRRU1V
LiBCbG9ja2luZw0KPiBtaWdyYXRpb24gaW4gdGhpcyBjYXNlIHdpbGwgYnJlYWsgdmFsaWQgd29y
a2luZyB1c2UgY2FzZXMuDQoNCkl0J3MganVzdCBhbiBlbmZvcmNlbWVudCB0byBlbnN1cmUgYSBz
YWZlIG1pZ3JhdGlvbi4gV2l0aG91dCB0aGlzIChpLmUuLCB0aGUgY3VycmVudA0KUUVNVSBjb2Rl
KSBpcyBtYWtpbmcgYW4gYXNzdW1wdGlvbiB0aGF0IHVzZXJzIGFsd2F5cyBoYXZlIHZhbGlkYXRl
ZA0KY29tcGF0aWJpbGl0eSBpbiBhIGdvb2QgbWFubmVyIG91dHNpZGUgUUVNVSwgd2hpY2ggaXMg
cmlza3kgdG8gc29tZSBkZWdyZWU/DQoNCkRvIHlvdSBzZWUgaG93IHRoaXMgd291bGQgYnJlYWsg
dmFsaWQgd29ya2luZyB1c2UgY2FzZXMgKGFueSBleGFtcGxlcyk/DQpUaGlzIGlzIGFjdHVhbGx5
IHdoYXQgd2UgYXJlIGxvb2tpbmcgZm9yLiBQbGVhc2UgYmUgYXdhcmUgdGhhdCAiZW5mb3JjZSIg
aXMNCmNoYW5nZWQgdG8gYmUgdHJ1ZSBieSBkZWZhdWx0IHRvIG1ha2UgdGhlIGd1ZXN0IHRvIGJl
IG1pZ3JhdGFibGUgYnkgZGVmYXVsdA0KdW5kZXIgdGhlIGVuZm9yY2VtZW50Lg0KDQo+IA0KPiBJ
TUhPIHRoaXMgcGF0Y2ggZG9lc24ndCBuZWVkIHRvIGV4aXN0LiBJZiB1c2VycyBvZiBRRU1VIHdh
bnQgc3Ryb25nIHByb3RlY3Rpb24NCj4gdGhleSBjYW4gYWxyZWFkeSBvcHQtaW4gdG8gdGhhdCB3
aXRoIGVuZm9yY2U9dHJ1ZS4NCg0KQUZBSUssIG1hbnkgdXNlcnMgYXJlIG5vdCBhd2FyZSBvZiB0
aGlzLCBhbmQgYWxzbyB3ZSBjb3VsZG4ndCBhc3N1bWUgZXZlcnlib2R5DQprbm93cyBpdC4gVGhh
dCdzIHdoeSB3ZSB3YW50IHRvIGFkZCB0aGUgZW5mb3JjZW1lbnQuDQo=

