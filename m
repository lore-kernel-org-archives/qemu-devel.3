Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EBBC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 03:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzT2g-0006ni-PV; Tue, 23 Apr 2024 23:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rzT2e-0006nB-Ll
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 23:11:28 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rzT2b-0006Z9-2Z
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 23:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713928285; x=1745464285;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q3B+K79QKJKjuXEBkZM/8pLEygPq9Au2oohKR/KXIcU=;
 b=OvLFJ6XM5OeidpAMO6V2T+rY2W5CgM3WW2UlvGA+hzLp5Tkr2vAOg/KU
 Ak6KftCNV39BWeh6VIvc+OxG916IcsUTlPzlS7w9SBaPlNsjY2nH/Oqof
 JgJEFNwcgRsQqdTOnSk+RBKgmMNuMKLqauKA9REadYRkJykLcSHXIzdnb
 asYdGARed7vGDOauwJRjTS/76kVQKVY/jGbYzABzNVDaq5E7skhbiuqZc
 8zEdlVIIjtIFqZd9gdl6pdgEhesSXNxGwc2N/+GrLv4uLMnUpqzLsQeep
 jBeeD1+y6+mFIojuK+B0hQ1Sttbj2qoKJhPntx7OzpR48U5DShWbmxLc1 A==;
X-CSE-ConnectionGUID: /VDZdRw6R1a2GkC1jhpCMg==
X-CSE-MsgGUID: OvPNod7cQh6Ij4ObU9CzfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20690867"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="20690867"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 20:11:16 -0700
X-CSE-ConnectionGUID: uHhaWKJkROq9kXSDWYJ3JA==
X-CSE-MsgGUID: 6UqtVBiPR0OafHFo//mtwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="29015085"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Apr 2024 20:11:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 20:11:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 20:11:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 20:11:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 20:11:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdKQK6cDCXN0gLMDDoseOcqUPfzlljNAWne2+8BP6GzCdZrG8H9m6qpiwR5pu+Xu4SkuRtywmx3IA2mCCqTaDdKxtOvp44cmvXZxYEetgDpZUreKem5bqC0pj8oOUQ+QOQlLaRSYF3PNCgcq/4wPfsaGq8WvDZYmKgFxLO6I25weEg/+WOSMm5P31fzimc5zPTTo6cBgdVfOoNYzhWz+2Ah8BSB31msjg0rqMrPMyuVRvgmYmVxlWZS27Yk2VyDrQcnaAoO8OhwxeSaIKUhlser6wyQaXDF9uUFadb/AOZmKKZxyqwj7zO2h5XhTegtf9vL953GPtQpqtXv/c2oUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3B+K79QKJKjuXEBkZM/8pLEygPq9Au2oohKR/KXIcU=;
 b=iF2UHj9XYc60r4n238SAAnXIXevDsdcDH3UmXoaAkm46/RFaL6qgH/kzQuKWeTikreiEeIn+Lc/xods+0SQ14owhGkfUygTC3+/pPsd/wM32O2oc/P/Px+5QppAAQ10u9Uc4aAc5X50UqlG6Z+jvDXXFNjIzWdUEha2HuKOjfEPbwD7mK2uBpLdymZIAH4c2BtflvOlOgOywELS5dC4K/u7zKfIJxSqFq3hEDTjUjmWKB7wBb5EKL02Y2ZJfeN4FEQPImOwvbnh9Zt0suLdpH2uYqlQIpUHY13ea9TNUsUASYJN55/e8T2X+yHNI2lfzkrBLCOmJB9zZfErjS6Ubyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 03:11:05 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 03:11:05 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Subject: RE: [PATCH v10 2/6] ui/console: new dmabuf.h and dmabuf.c for
 QemuDmaBuf struct and helpers
Thread-Topic: [PATCH v10 2/6] ui/console: new dmabuf.h and dmabuf.c for
 QemuDmaBuf struct and helpers
Thread-Index: AQHalSjw2EuC+4s9ok68yKDtBlFWH7F15KCAgADZXmA=
Date: Wed, 24 Apr 2024 03:11:05 +0000
Message-ID: <PH8PR11MB68793BC791B2ECE9CA8B5A0AFA102@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240423022253.1003295-1-dongwon.kim@intel.com>
 <20240423022253.1003295-3-dongwon.kim@intel.com>
 <ZifAdRBCndQeOAwh@redhat.com>
In-Reply-To: <ZifAdRBCndQeOAwh@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SA3PR11MB7554:EE_
x-ms-office365-filtering-correlation-id: dd483f75-bcd4-4f7c-5844-08dc640c2df2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VkVOdUFaNnJHaGQ5SStsMG1ITEEvWFN2V1ZFaXl4Z3NmQmlZajU4RUVmNVdm?=
 =?utf-8?B?OVpueTdIZkI1R3hvMXRRNXQreXErTUxsOEFzaFozR0w0ZmQ3bkV5M0Y1WWw1?=
 =?utf-8?B?T3VyaEJSL1NDTzZ6RnRtQWlKQm1RejN1SG5tdWl0NVFKUlp6RjgvUUU0bFVF?=
 =?utf-8?B?NFYvS3RmQi8vSldwcU9nSHA5bUpQdXNoWmhhYS9LSE5aNWo2VVJvMVlYYmxI?=
 =?utf-8?B?V1BHdW4xeHVIOXVZVHprdE9kZG1DNnhJWWtTMGY0Rk50andhMXNYRTlVZFIz?=
 =?utf-8?B?WFhYZnVnTG4zSWJLMWlyWTVZMEtiQ1FSRzdTVThUVGk4ckdpcnFCak5pM3M2?=
 =?utf-8?B?aFMrVDU5VTY0Q2kvZHpmSlc2OExiQWl1N21BSGNNclVyODNTMHJ4NXZHbGM0?=
 =?utf-8?B?SGFPeWEvYzZiOERCQnNjelBsT1lGR3ZzUVdZMUdnSHU1d1I4WUV1T1d1VU5z?=
 =?utf-8?B?QnM1M09GOTBlSzBpV2xkcDJ0T2duK1pMSC9nWFpFNnJsUk42Zmx3cUIya3dD?=
 =?utf-8?B?NFZTVUdJaFByT1FHenNNRHIzRUs2V0xSODRoQUpTV0hBYlMxWEVHTE96Misw?=
 =?utf-8?B?cXVUQjViYnpHbHJOOUhuR0ZaMFBWcFVtVkVCWDZYZVJVUFhnakZ4RW5xako2?=
 =?utf-8?B?VCtXY2MrNHFsbDFTS1ByUnhOTmI2ZTFwZWNsRTF0Sk9mUk4zV01rOHgxRjJJ?=
 =?utf-8?B?UU1hYzMyOG53TTk1M29rZFF0dkZuVHdOTXp0bU4rVzRHdHdZdWY3MUdUZ3JX?=
 =?utf-8?B?aElJbFJ5U1hvK092dmczNHJ5ZjBsYkdMdjQwYVBoOCtRbk44dk53eGF5YlV1?=
 =?utf-8?B?dllkT1MvK0JsaEgzMUpyL3FzL1lad3BlQ1czU0VYNkV6cG0rT3AyTnU5Skls?=
 =?utf-8?B?KzM4M1BTK1ZmTVprR0ZaeEkycTZDS25aUFBoV2NseS9UZ2RaM1dXb3VralpO?=
 =?utf-8?B?bG5mMWFMRnRaMDV6MGE1UDdqSmozV29FbzdhdFRBbkd6Zm5qOCtnZGowdGxs?=
 =?utf-8?B?KzJDcnk3RmVIdDI3OExkWFVBK0hqVy90ZzNLN3l0dWhKWE9oVTB1eTdMRjNL?=
 =?utf-8?B?LzBzbDZnc2RxNG1MUXoxYStoS2hZQ1RoTllGWUtJMmxoUzFLNlpLZSt5eDhn?=
 =?utf-8?B?Sk9KbHhIR2Yvd1RYeUxKeFpwU1UzOXEvaUFZMUVldVdQU3lOazA2NG1GWFcv?=
 =?utf-8?B?SlZvOVh4RVQzVG9seUdRaUF3UmUwa0pYcTVTc3NaSi9CdVlHTU8rT3JBOGtS?=
 =?utf-8?B?WEFHei9tQnhlT1FEcUVyYXN3SWRWdHhsT3lXYmZNK2NWYzJuTUVjNzJ0S1o4?=
 =?utf-8?B?bnpXdnlSSVhjS2NiTzFuRHNYOVU0ZVVQaUlDUEk5WGdkUDdxdlkzUndlVFhD?=
 =?utf-8?B?dDMzTnp1a2dGenN6VkJtWUZGUFduZUFYQWx4OWtNVmdzU0NZaXNsUFVCUlUv?=
 =?utf-8?B?SGRxZnBocXVtU1ArUnZzNWttdjR1UWV2azg2TWVVREJmOG9YbTNJWDJ1bWg4?=
 =?utf-8?B?Wk5LWFNJbmpqVUFxeHhJbUdKSU5EbUxwUDgwejgyUHlSNXcyN1JXK3Y5YUsw?=
 =?utf-8?B?MDhML3lxUDFLOGVuejZ2V3FtWDk5aVgvTEdLaDhzakNodHRudHBqbjBKVk1Z?=
 =?utf-8?B?OW82NzhXd0Vic0taYUg2MHRRUkN3L2c1amV0V2pWYmk2RFg2MXhNU3VNNmdY?=
 =?utf-8?B?NWg0djRKY0FoVUhjczdoaWZCSWxyTGN4V2VoQ1lWRDVtSEVCMmJMZWVBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTc1OE1OREduMGdqemE3dVFVTkJJRW5zZWk1S1dSMmNnL0hwOStOellyMUh4?=
 =?utf-8?B?ZUhQV2VqRnBrK1M4TjJlcjl1R2VnUXFWTmZhdHZTUWVna0x1SndYbmZ1L2lJ?=
 =?utf-8?B?S0lOSVR4V2V6NHNLRXcyeHMvQjdLYXY1RWY5Rk5YaHc1WU41RkNMOHNta1BO?=
 =?utf-8?B?SWw5c1RQVDZSZGtLK1dQODIxTEJaTzlCUE4vOWpSQk43M1FMc2tSTHhHSWYx?=
 =?utf-8?B?YlRkQ0N6eXlka3pOb2t2Rm1GUXhGS0Fudy9TM3ZtZjBMcUlRak5FTDBZQlBL?=
 =?utf-8?B?TWN5d2VhS3UweVR2VkcxQW9ldDJpZG5reFVMN1lYOEJZcEdkdTIrTzd4dlJY?=
 =?utf-8?B?bHdPVU13c1BlUEx4K1Vrc2JzNndOeHlRSEJHTkZjYVJMY2NIa1FHV3B0aitX?=
 =?utf-8?B?TjVzb0JNMjJyTFJtOXVjNEFKUlU5L05IbmN5YWdsV2tTT1JMdUdCWnRxVzhT?=
 =?utf-8?B?U0lwM2pQUUFhYkc2a1ZjS0VqWW1qckZjcGtTNURheENXNEEwK25GZVNIWDFm?=
 =?utf-8?B?OTJoWDdNZktNaHR5YWlqZGxBRGkzenVPc2IybjFSNW12V0NDcTdNOXB0Rk45?=
 =?utf-8?B?dWduWThZQ3dTTnlORTVVYzU3YU1UNUdoOHFNUGhiQU1KOEgvdzBPUFgxRlZq?=
 =?utf-8?B?eURCdVRvaE9hWkZXS09xbTI2ZFQzdHgzbWRpMis3NVoyL01hcjdpRTk4cUVN?=
 =?utf-8?B?U1BITVJOZDR5bkhONStKTmdyRTlwTW5TbStKV2taRzVIS0xDNzBkcGdua3Bo?=
 =?utf-8?B?bjNJTkpXS2lSVFVtVmpiS2VtVGYyUnNtdkpVcTFVY210R3dMOWlaNFpCTVRa?=
 =?utf-8?B?V2FlRHNKcUFaUFJjcUZGbjY1Z3ROdWZTY24vRGZ0M0dJMXJtamVjVVZheFdt?=
 =?utf-8?B?T29ubUFzZ2d2cFM0NnMvOUMvU25VNVhVbC9oZGYrYjlRelV2Nkh4K2JCTUhi?=
 =?utf-8?B?STErUHN5ZnJUdkgwTXZ2NHlmVk9ZRUR3SzBpSVI3QVRkMVZkTjlua3VUZ2Nu?=
 =?utf-8?B?eFNUV0lVRFBydTA0VEs3cW54Qjl3VHRWWXVUQllNZDEyVW9pdUdrMjFmMEF4?=
 =?utf-8?B?d3ErRDJnaWFwTWVVK3dSMWxldi9pQTZmRjBqK1NBSk1GTTdmNHZrQ0JLNUlK?=
 =?utf-8?B?VWdybUdNYVlIenZWWFBoZjM0NWJ1c2o1S1hKemUxWUt1Mkh4Ky94RFdCSHE0?=
 =?utf-8?B?V1NHZm5kbFgxVVRIdG1wMmJPWjRIbDIvWFVlT2I0VGJrMVRZMDlQaUlGWGFz?=
 =?utf-8?B?RWZmS2VLTjB0bFBOWTZ2Qm90OW1tM2RNcHIxdlMxblFUdnpsMDNqV0tlbXRy?=
 =?utf-8?B?SVYybnNwaTk5L1hQNDJCZjUrbU5FSWxYUlRYSS9Tb3p6d1hMZTVjSzc4WEtz?=
 =?utf-8?B?Vkp3Y1l3L2M2RUdRUmNxZUU0WWxFTEZ6dzVhNkRKYURmZFRGSnk0YU85b0Zl?=
 =?utf-8?B?bHJ6TWVxdFBneUY0NWZ1MmFFZ0lsRGdTbjdmZ0R1VHNrYjJla2JHN2RGT3ZM?=
 =?utf-8?B?azhWK1I4Rm5yeDN2TTV1V0FaTDN4ZGoyVHkxSzRtVmNjWmhKei9UZklDVmJG?=
 =?utf-8?B?clV2L1lod1hEUUlkbDBsazJSNFJSZXNrWXpaek52M3V0RFNzeHFDNnUwbTFk?=
 =?utf-8?B?ZlJCdUVobDNtN1BKQno5eDM4bnJZb2ZoR3lOZ3J4dk5XRkpBQWVSVEYzL0J3?=
 =?utf-8?B?Z2pWd2w4M3JnVWJvdXNiMThlaHdsQ2YwRll3dkR5ZjFlSStSakRDMk84Mk43?=
 =?utf-8?B?SGdXRXJHd2lmTWVGYmMwV1hCRnU5Tis0K3k3N1RNOC9nVXkzSGpGNXJaRXUv?=
 =?utf-8?B?c2pvRkdpMG9HSUI4a2I1czRmZVFldklva1dVWElCRFhLZ25CUnhGeitKRDVQ?=
 =?utf-8?B?Z1UrbWhZNXVjTDExK2xZV0tvSDhJcXE0TmQydEdMOEFoK1dqc1hUeS9DMXNU?=
 =?utf-8?B?dFhTVUU0WDlHTmw2VDRhYStxNDhUa1VXR3dQU2o0cXJBTWtjU2poWUVZYWxC?=
 =?utf-8?B?ZUs0QkVvKzFUVi8wRFRIRXdLT2Z5d0FxVzl5MENSV0VsUHI1NDFrOGl0akl3?=
 =?utf-8?B?V0o5bERYKzdSb0J0ZTlUenVJS2diQ1o5Q21DQlVoeCtyWHNQQnVCLzljdjFW?=
 =?utf-8?Q?oQLOH3GbJb5XMupvCJ+tfXSjM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd483f75-bcd4-4f7c-5844-08dc640c2df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 03:11:05.2460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5xGz0Yu1O1umGJhirQxf4lxU/o4fpj4mBFinpIuYXP+MjE7fWITFgbPIP5iDV59lbWMVdvp94XeE0BWsoSOfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7554
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFw
cmlsIDIzLCAyMDI0IDc6MDcgQU0NCj4gVG86IEtpbSwgRG9uZ3dvbiA8ZG9uZ3dvbi5raW1AaW50
ZWwuY29tPg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBtYXJjYW5kcmUubHVyZWF1QHJl
ZGhhdC5jb207DQo+IHBoaWxtZEBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEw
IDIvNl0gdWkvY29uc29sZTogbmV3IGRtYWJ1Zi5oIGFuZCBkbWFidWYuYyBmb3INCj4gUWVtdURt
YUJ1ZiBzdHJ1Y3QgYW5kIGhlbHBlcnMNCj4gDQo+IE9uIE1vbiwgQXByIDIyLCAyMDI0IGF0IDA3
OjIyOjQ5UE0gLTA3MDAsIGRvbmd3b24ua2ltQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBE
b25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiA+DQo+ID4gTmV3IGhlYWRlciBh
bmQgc291cmNlIGZpbGVzIGFyZSBhZGRlZCBmb3IgY29udGFpbmluZyBRZW11RG1hQnVmIHN0cnVj
dA0KPiA+IGRlZmluaXRpb24gYW5kIG5ld2x5IGludHJvZHVjZWQgaGVscGVycyBmb3IgY3JlYXRp
bmcvZnJlZWluZyB0aGUNCj4gPiBzdHJ1Y3QgYW5kIGFjY2Vzc2luZyBpdHMgZGF0YS4NCj4gPg0K
PiA+IHYxMDogQ2hhbmdlIHRoZSBsaWNlbnNlIHR5cGUgZm9yIGJvdGggZG1hYnVmLmggYW5kIGRt
YWJ1Zi5jIGZyb20gTUlUIHRvDQo+ID4gICAgICBHUEwgdG8gYmUgaW4gbGluZSB3aXRoIFFFTVUn
cyBkZWZhdWx0IGxpY2Vuc2UNCj4gPiAgICAgIChEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5n
ZUByZWRoYXQuY29tPikNCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTogTWFyYy1BbmRyw6kgTHVyZWF1
IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+ID4gQ2M6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gPiBDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gPiBDYzogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNp
cmVkZHlAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmd3b24gS2ltIDxkb25nd29u
LmtpbUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvdWkvY29uc29sZS5oIHwgIDIw
ICstLS0tDQo+ID4gIGluY2x1ZGUvdWkvZG1hYnVmLmggIHwgIDY0ICsrKysrKysrKysrKysrKw0K
PiA+ICB1aS9kbWFidWYuYyAgICAgICAgICB8IDE4OSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIHVpL21lc29uLmJ1aWxkICAgICAgIHwgICAxICsNCj4g
PiAgNCBmaWxlcyBjaGFuZ2VkLCAyNTUgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pICBj
cmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBpbmNsdWRlL3VpL2RtYWJ1Zi5oICBjcmVhdGUgbW9kZSAx
MDA2NDQgdWkvZG1hYnVmLmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VpL2NvbnNv
bGUuaCBiL2luY2x1ZGUvdWkvY29uc29sZS5oIGluZGV4DQo+ID4gMGJjN2EwMGFjMC4uYTIwOGE2
OGI4OCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VpL2NvbnNvbGUuaA0KPiA+ICsrKyBiL2lu
Y2x1ZGUvdWkvY29uc29sZS5oDQo+ID4gQEAgLTcsNiArNyw3IEBADQo+ID4gICNpbmNsdWRlICJx
YXBpL3FhcGktdHlwZXMtdWkuaCINCj4gPiAgI2luY2x1ZGUgInVpL2lucHV0LmgiDQo+ID4gICNp
bmNsdWRlICJ1aS9zdXJmYWNlLmgiDQo+ID4gKyNpbmNsdWRlICJ1aS9kbWFidWYuaCINCj4gPg0K
PiA+ICAjZGVmaW5lIFRZUEVfUUVNVV9DT05TT0xFICJxZW11LWNvbnNvbGUiDQo+ID4gIE9CSkVD
VF9ERUNMQVJFX1RZUEUoUWVtdUNvbnNvbGUsIFFlbXVDb25zb2xlQ2xhc3MsIFFFTVVfQ09OU09M
RSkNCj4gQEANCj4gPiAtMTg1LDI1ICsxODYsNiBAQCBzdHJ1Y3QgUUVNVUdMUGFyYW1zIHsNCj4g
PiAgICAgIGludCBtaW5vcl92ZXI7DQo+ID4gIH07DQo+ID4NCj4gPiAtdHlwZWRlZiBzdHJ1Y3Qg
UWVtdURtYUJ1ZiB7DQo+ID4gLSAgICBpbnQgICAgICAgZmQ7DQo+ID4gLSAgICB1aW50MzJfdCAg
d2lkdGg7DQo+ID4gLSAgICB1aW50MzJfdCAgaGVpZ2h0Ow0KPiA+IC0gICAgdWludDMyX3QgIHN0
cmlkZTsNCj4gPiAtICAgIHVpbnQzMl90ICBmb3VyY2M7DQo+ID4gLSAgICB1aW50NjRfdCAgbW9k
aWZpZXI7DQo+ID4gLSAgICB1aW50MzJfdCAgdGV4dHVyZTsNCj4gPiAtICAgIHVpbnQzMl90ICB4
Ow0KPiA+IC0gICAgdWludDMyX3QgIHk7DQo+ID4gLSAgICB1aW50MzJfdCAgYmFja2luZ193aWR0
aDsNCj4gPiAtICAgIHVpbnQzMl90ICBiYWNraW5nX2hlaWdodDsNCj4gPiAtICAgIGJvb2wgICAg
ICB5MF90b3A7DQo+ID4gLSAgICB2b2lkICAgICAgKnN5bmM7DQo+ID4gLSAgICBpbnQgICAgICAg
ZmVuY2VfZmQ7DQo+ID4gLSAgICBib29sICAgICAgYWxsb3dfZmVuY2VzOw0KPiA+IC0gICAgYm9v
bCAgICAgIGRyYXdfc3VibWl0dGVkOw0KPiA+IC19IFFlbXVEbWFCdWY7DQo+ID4gLQ0KPiA+ICBl
bnVtIGRpc3BsYXlfc2Nhbm91dCB7DQo+ID4gICAgICBTQ0FOT1VUX05PTkUsDQo+ID4gICAgICBT
Q0FOT1VUX1NVUkZBQ0UsDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWkvZG1hYnVmLmggYi9p
bmNsdWRlL3VpL2RtYWJ1Zi5oIG5ldyBmaWxlIG1vZGUNCj4gPiAxMDA2NDQgaW5kZXggMDAwMDAw
MDAwMC4uN2E2MDExNmVlNg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL3Vp
L2RtYWJ1Zi5oDQo+ID4gQEAgLTAsMCArMSw2NCBAQA0KPiA+ICsvKg0KPiA+ICsgKiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiA+ICsgKg0KPiA+ICsgKiBRZW11
RG1hQnVmIHN0cnVjdCBhbmQgaGVscGVycyB1c2VkIGZvciBhY2Nlc3NpbmcgaXRzIGRhdGENCj4g
PiArICoNCj4gPiArICogVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGUgR05VIEdQTCwgdmVyc2lvbiAyIG9yIGxhdGVyLg0KPiA+ICsgKiBTZWUgdGhlIENPUFlJTkcg
ZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsj
aWZuZGVmIERNQUJVRl9IDQo+ID4gKyNkZWZpbmUgRE1BQlVGX0gNCj4gPiArDQo+ID4gK3R5cGVk
ZWYgc3RydWN0IFFlbXVEbWFCdWYgew0KPiA+ICsgICAgaW50ICAgICAgIGZkOw0KPiA+ICsgICAg
dWludDMyX3QgIHdpZHRoOw0KPiA+ICsgICAgdWludDMyX3QgIGhlaWdodDsNCj4gPiArICAgIHVp
bnQzMl90ICBzdHJpZGU7DQo+ID4gKyAgICB1aW50MzJfdCAgZm91cmNjOw0KPiA+ICsgICAgdWlu
dDY0X3QgIG1vZGlmaWVyOw0KPiA+ICsgICAgdWludDMyX3QgIHRleHR1cmU7DQo+ID4gKyAgICB1
aW50MzJfdCAgeDsNCj4gPiArICAgIHVpbnQzMl90ICB5Ow0KPiA+ICsgICAgdWludDMyX3QgIGJh
Y2tpbmdfd2lkdGg7DQo+ID4gKyAgICB1aW50MzJfdCAgYmFja2luZ19oZWlnaHQ7DQo+ID4gKyAg
ICBib29sICAgICAgeTBfdG9wOw0KPiA+ICsgICAgdm9pZCAgICAgICpzeW5jOw0KPiA+ICsgICAg
aW50ICAgICAgIGZlbmNlX2ZkOw0KPiA+ICsgICAgYm9vbCAgICAgIGFsbG93X2ZlbmNlczsNCj4g
PiArICAgIGJvb2wgICAgICBkcmF3X3N1Ym1pdHRlZDsNCj4gPiArfSBRZW11RG1hQnVmOw0KPiA+
ICsNCj4gPiArUWVtdURtYUJ1ZiAqcWVtdV9kbWFidWZfbmV3KHVpbnQzMl90IHdpZHRoLCB1aW50
MzJfdCBoZWlnaHQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3Qgc3RyaWRlLCB1aW50MzJfdCB4LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQzMl90IHksIHVpbnQzMl90IGJhY2tpbmdfd2lkdGgsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgYmFja2luZ19oZWlnaHQsIHVp
bnQzMl90IGZvdXJjYywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50NjRfdCBtb2RpZmllciwgaW50MzJfdA0KPiA+ICtkbWFidWZfZmQsDQo+IA0KPiBTaG91bGQg
YmUgJ2ludCcgbm90ICdpbnQzMl90JyBmb3IgRkRzLg0KPiANCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBib29sIGFsbG93X2ZlbmNlcywgYm9vbCB5MF90b3ApOw0KPiA+
ICt2b2lkIHFlbXVfZG1hYnVmX2ZyZWUoUWVtdURtYUJ1ZiAqZG1hYnVmKTsNCj4gPiArDQo+ID4g
K0dfREVGSU5FX0FVVE9QVFJfQ0xFQU5VUF9GVU5DKFFlbXVEbWFCdWYsIHFlbXVfZG1hYnVmX2Zy
ZWUpOw0KPiA+ICsNCj4gPiAraW50MzJfdCBxZW11X2RtYWJ1Zl9nZXRfZmQoUWVtdURtYUJ1ZiAq
ZG1hYnVmKTsNCj4gDQo+IEFnYWluIHNob3VsZCBiZSAnaW50JyBub3QgJ2ludDQyX3QnDQo+IA0K
PiBJIHRoaW5rIHRoZXJlIG91Z2h0IHRvIGFsc28gYmUgYQ0KPiANCj4gICBpbnQgcWVtdV9kbWFi
dWZfZHVwX2ZkKFFlbXVEbWFCdWYgKmRtYWJ1Zik7DQo+IA0KPiB0byBkbyB0aGUgZHVwKCkgY2Fs
bCBpbiBvbmUgZ28gdG9vDQo+IA0KPiA+IGRpZmYgLS1naXQgYS91aS9kbWFidWYuYyBiL3VpL2Rt
YWJ1Zi5jIG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4DQo+ID4gMDAwMDAwMDAwMC4uZjQ0N2Nj
ZTRmZQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi91aS9kbWFidWYuYw0KPiANCj4gPiAr
DQo+ID4gK3ZvaWQgcWVtdV9kbWFidWZfZnJlZShRZW11RG1hQnVmICpkbWFidWYpDQo+ID4gK3sN
Cj4gPiArICAgIGlmIChkbWFidWYgPT0gTlVMTCkgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4g
PiArICAgIH0NCj4gPiArDQo+IA0KPiBJIHRoaW5rIHRoaXMgbWV0aG9kIHNob3VsZCBiZSBtYWRl
IHRvIGNhbGwNCj4gDQo+ICAgcWVtdV9kbWFidWZfY2xvc2UoKQ0KPiANCj4gdG8gcmVsZWFzZSB0
aGUgRkQsIGlmIG5vdCBhbHJlYWR5IHJlbGVhc2VkLCBvdGhlcndpc2UNCj4gdGhpcyBtZXRob2Qg
Y291bGQgYmUgYSByZXNvdXJjZSBsZWFrLg0KDQpbS2ltLCBEb25nd29uXSAgRGFuaWVsLCBJIGlu
aXRpYWxseSBhZ3JlZWQgd2l0aCB5b3Ugb24gdGhlIGlkZWEgdGhhdCBpcyB3ZSBzaG91bGQgY2xv
c2UgZG1hYnVmLT5mZCBoZXJlIGluIGZyZWVpbmcgcm91dGluZSBhbmQgSSBhbHJlYWR5IHN1Ym1p
dHRlZCB2MTEgY29udGFpbmluZyB0aGF0IGNoYW5nZSBidXQgSSBqdXN0IGZvdW5kIGl0IGNhdXNl
cyBzb21lIHJlZ3Jlc3Npb24gYXQgbGVhc3QgZm9yIHZpcnRpby1ncHUgY2FzZSBiZWNhdXNlIHRo
aXMgZmQgaXMgZm9yIHVkbWFidWYgYm91bmQgdG8gdGhlIGFjdHVhbCByZXNvdXJjZS4gVGhpcyBp
cyBkZXNpZ25lZCB0byBiZSBjbG9zZWQgYnkgdmlydGlvLWdwdSB3aGVuIHRoZSByZXNvdXJjZSBp
cyBmcmVlZCwgbm90IHdoZW4gUWVtdURtYUJ1ZiBzdHJ1Y3QgcmVmZXJlbmNpbmcgdGhhdCByZXNv
dXJjZSAodWRtYWJ1ZikgaXMgZnJlZWQuIFNvIEkgZ3Vlc3Mgd2UgbmVlZCB0byBzcGxpdCBmcmVl
IGFuZCBjbG9zZSBoZXJlLiAgSSB3aWxsIHdvcmsgb24gdjEyIGJ1dCBJIHdpbGwgd2FpdCBmb3Ig
eW91ciBmZWVkYmFjayBiZWZvcmUgc3VibWl0dGluZyBpdC4NCg0KVGhhbmtzIQ0KPiANCj4gPiAr
ICAgIGdfZnJlZShkbWFidWYpOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gV2l0aCByZWdhcmRzLA0K
PiBEYW5pZWwNCj4gLS0NCj4gfDogaHR0cHM6Ly9iZXJyYW5nZS5jb20gICAgICAtby0gICAgaHR0
cHM6Ly93d3cuZmxpY2tyLmNvbS9waG90b3MvZGJlcnJhbmdlIDp8DQo+IHw6IGh0dHBzOi8vbGli
dmlydC5vcmcgICAgICAgICAtby0gICAgICAgICAgICBodHRwczovL2ZzdG9wMTM4LmJlcnJhbmdl
LmNvbSA6fA0KPiB8OiBodHRwczovL2VudGFuZ2xlLXBob3RvLm9yZyAgICAtby0gICAgaHR0cHM6
Ly93d3cuaW5zdGFncmFtLmNvbS9kYmVycmFuZ2UgOnwNCg0K

