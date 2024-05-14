Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9110C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 09:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6oKy-0005QE-Ba; Tue, 14 May 2024 05:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6oKw-0005Pp-Kj
 for qemu-devel@nongnu.org; Tue, 14 May 2024 05:20:42 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6oKu-00053Z-17
 for qemu-devel@nongnu.org; Tue, 14 May 2024 05:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715678440; x=1747214440;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=G07+hMCWTjTW3JxJT7EgF6YFtSN4/RTFaNHJ2iK20kA=;
 b=V2RvmsZq7Vr9XSnbOGZQ9yF2qNE4O2ttoH/BR3ewWm+XqwtBwyu4MyO6
 +xuxqctNt2fcCJjUtFV0OMR4v3Ma2Cj8m5f5SQBW0si3Q0k3wSOUI5qgb
 /k37yx+RxoIOEXl17qcNAeg9mujMynBVUbk+zXq897noIm53Une0r9MYG
 s3IzBIot5eX9c7+QW3X44z4d9z1mhf356ssQhXY0oa1uvELksk3OcanQM
 LlGKyOUvQmBQhPt7LONj6EqsaGfHRdvlJgbLDQr/z4YkaPS2RMuO/2mtg
 awZUdbZ/0Wd5xdC5JT6GzpHfqGKsqWZxZEc+CBi3qaZCRDCF9Q/OY4wFD g==;
X-CSE-ConnectionGUID: 0DVOdtqOQbiclMqY2i6btA==
X-CSE-MsgGUID: nwNBwIcyRZuoDXfJfX09jQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11515039"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11515039"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 02:20:37 -0700
X-CSE-ConnectionGUID: Y6KnEzJ/QN6ELNu2jlUQXQ==
X-CSE-MsgGUID: VqPSjOEGQ9WvyXvtrPA62A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="30599912"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 May 2024 02:20:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 02:20:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 02:20:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 02:20:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 02:20:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5jKFQK1w/NKXfHYHWJpvrwsEKsOgvYT+rkhusKNd+l2N3FunaHVEGC17rLrOt79+x7G0yc7eXNfDSHhazfpOY9OxFLALd5WEyH5mJst8o8eYOm0//NLc7mumLZGiIwMCiVRGwJpbMF5nE320yA3/bj9T2TkW35D6VtOQ2HIiAX1NIwwCScV7t719LGVgmvZaISzfR3usrFYS+PusJhsrG1MqkIfd+PI0mK4IGSJ475RE7z+NDx1oLpCGelx09XNLIV6n30F3HSuwwHE4FFFi+J404nWXpVkfUIQnlh3x1s9cC5SzC9y1aKrscbij9YAin/RiEc8dSlBaf/pu3eE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G07+hMCWTjTW3JxJT7EgF6YFtSN4/RTFaNHJ2iK20kA=;
 b=MOd77F2v/YX4YIwPpb95QvOuAaXzwQYj0pGKTkpWxWttUYmbb4/sdBAvYQOiRGXZgyhQY8cMGGbA81RaHPMqdEVAoyfyxIWRYql0Fv8tKY5tPuerxm4McratIa678CDEVBw9wcuaenyZqsMepkvJ/T5HCYVml0eiMY5shxbW1hDalyt5t9wXsY3jRMpu8rO338hqGr8wrCTgstpuieZlOpREFxMSZe5PPFuoL3R94C/rtJ7EEGRV8KbeMfQuComQ4FksDMuVKXp5dOsi7glPA/4JksJ9RvzrqUt+/xb1MILLMgSeDObk3KfWB+r12VtyjrTKTNUVa9xTaPnJda/nZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7194.namprd11.prod.outlook.com (2603:10b6:930:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Tue, 14 May
 2024 09:20:34 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 09:20:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH ats_vtd v1 14/24] pci: add IOMMU operations to get address
 spaces and memory regions with PASID
Thread-Topic: [PATCH ats_vtd v1 14/24] pci: add IOMMU operations to get
 address spaces and memory regions with PASID
Thread-Index: AQHanKWMbRyr56YxIEyFrFUh3BbdsbGWhlKg
Date: Tue, 14 May 2024 09:20:34 +0000
Message-ID: <SJ0PR11MB6744EA11101B9CE5094A071292E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
 <20240502152810.187492-15-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-15-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7194:EE_
x-ms-office365-filtering-correlation-id: 2eedb5a6-6940-4601-83a6-08dc73f71c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aUtoZytYeFFuai9DdThtU2FzMTdSb3JtM3ZtS284RzIvOExxbEV0ZWhoM0tS?=
 =?utf-8?B?WVRjNDRFN3VYOGxjZXR1M0JpWU13YzFDM29haE9hMUxJKzNWY2VPaHN4bE9q?=
 =?utf-8?B?bmE5TnJ2M1hqZG4xZEFhVmMwY2VjVFlNdjZpeUJCV3lSSVhTQUJHOXh2RE4r?=
 =?utf-8?B?Wm5aa21iSnYyVWVnQ2ZjYlBYNmwybDRiOGZsYUduSWNmVnQxd0JXaGdOYVZx?=
 =?utf-8?B?Qm55Y2lRWndWSm5pdSs2cENGV3Zuam5GaGQ0U2NkRXJ5c2FtTmdhYlo0MkxK?=
 =?utf-8?B?V3FhbTZWdUpsMXQ3VTFGZi8vMGduenNFQWZEMGJ5d0xKd0NlcUU4eFN4aElu?=
 =?utf-8?B?c3dMUXphTkdQeHc2cHZBcWlCbUhkZ2NBczl5QjNQZngzamN1T0FrYjJJMk1s?=
 =?utf-8?B?UCtEWG5xcnVNK1JHb25lRVd3cTdlajVuMEpIOUl3U2hBbkNTdThLNmgxc1ph?=
 =?utf-8?B?WXZMNlJCbzBNb0xNOTJrSEVYb0daeFFhcXlFR3o5YTNvcDdxTmVyWkxIelln?=
 =?utf-8?B?NW1NNmdnV0kvM3RxQ0ZXR0RZVTlaME9UT3ZNUGRjY1VzV1ZRdVNKUURPTkJD?=
 =?utf-8?B?VE45bzRaZCtCaS84ZUtLbmRrc2FBZ2cvaElJWmVsY0lrYktsSTFGd242N1lY?=
 =?utf-8?B?NEdWUnViK1JaWkdsWDRTbDVqS1FpZmNIbXZrMTNubmNnanBkMXZxM09YSlc5?=
 =?utf-8?B?bUpuNVBDQllCNUhsMGMvdWhucjhySHQrTURjRVZMNy9LeS9TSHpXbm9tMDRV?=
 =?utf-8?B?N1ZLUURzRnZkVEpXVzZJeHpNZWpkVjZWdVA2YVNNeDZVRmJhaTlqMEE4OTlh?=
 =?utf-8?B?TFJBRU5DQjkvd1grTVliUEZNa05IZmVyQ3NkeFpaTVkvczJ5NXZKZjJ2ZDFi?=
 =?utf-8?B?TXVWSjFXYnNJMExYdDY2YklZdWRCOEVIMERJeGp5UTJsNm90dTJTQXRuS2px?=
 =?utf-8?B?UlZXZ3V1VUM1V2FSM08vWGpubmNuSldNbWhWcGl6ZU1KRU55UkZSTUQ5RStB?=
 =?utf-8?B?dE1JQ3RzTk9LOUZsL0lyVW14TTE1RlAyeExWZGdORUFCZTJ5NTNNVCtDTEpW?=
 =?utf-8?B?SnpYMGxReTFWelQreDg4cmFUV3Y4VzdPQU5DS2g5dmUveWlkdWRWRHdZSjhX?=
 =?utf-8?B?Y3RMMDZ5cjVQbHNrVTlZRkJCVUoxRDk5MjNhWHhaQkJ5eGhVQm9zYWJyN0Vw?=
 =?utf-8?B?ZWdzckwvOUlKaFZUYTVnc1ZtNTM3RjAxZG5hUE13d29IUUF2YWs4eFpqTGVp?=
 =?utf-8?B?bG1oSERDYWRiaCs2WEd2RGVjK3l2Q2t6bWVNRG13RWdJNUt0TTFDNlpab2ZL?=
 =?utf-8?B?S3RJKzZFTHJNWTV2RDdseit3THM4OTJOVTZIS0NxZTFsOWtnZW54dStDdkxa?=
 =?utf-8?B?N3dnVW1JRzRtT3VhdzJBOU04czN1bG9vYktMK3FsYTJWM0NnT2V2TFNjQWVk?=
 =?utf-8?B?eUxScC9OSzVscWd2cjF2aE9oRHNBOW13b2pxL1ZiMW9hWlhCOFFsOHhteU5V?=
 =?utf-8?B?NGYrSjhmaGU2S3NEZExaZHlxVzBXdDYwb0c2NExNTzdod3I5VGtxM3cvQUlQ?=
 =?utf-8?B?T3d1VFZpU1FCaDRzRE5HNkhXdWwzUWdsVEt5REl3elBsU2tSNEpBUk9pS2hx?=
 =?utf-8?B?MlhTMFNjdDFzQTQ5elpybVFISlV3bndrYzN5UE9mQzFxN05kZTBJbTFCRTNL?=
 =?utf-8?B?VFZYa3NIWVNmdjZ0SkZ5T3RQR1VTMUVnT1VJaXdTZm1uRlhxWndSSEczS3BG?=
 =?utf-8?B?QlZQbTBWdXFRaVZ6SFVOT05rSFRCTmlIUXNHOGJHNXZSVk1zNUtMZE5hVXlm?=
 =?utf-8?B?bHVZNGRlT2YzempxOEVIQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2lNb3RKQWFzOExRYUFVTXBRUDRZOXZ6MnYwUmdaVjFsWEFZQ1Ixcm1GMlph?=
 =?utf-8?B?cHJGMXNqMXJ6SjIzbXJUY2tRVysrcUFSWWlHZ215Z1BWdDMwRWFQb2l4eW5X?=
 =?utf-8?B?OG1WbDc1SVZnMG1IanNyNlNLN0hxbnhWK2dlamR2U1prdmlOSzQ3eXkwTDBQ?=
 =?utf-8?B?Q2daemlaZmMwUlR3SCtIdzR0REs4OVl2cFZkSFRkdE5XL1A1TVQ0QS9wQnIw?=
 =?utf-8?B?YkVaWi9BTHErTDJwVEwyYUUxaktKdm9OT0RvTWV3bFNVOXdQTUxnOUVmYXdh?=
 =?utf-8?B?U0liOFFTdlJ6RmhuRGZxT1BiSHQ2UFNxR0h4OU1pVHJoYkEveVBMT0tvMnI4?=
 =?utf-8?B?bVB1OGpDSktLdGc3SGc0dlZ1OHducHRpQk1aNlZpZXFWRy9DSWhwOURlWk9z?=
 =?utf-8?B?Qm1LMjRUckNrQzVmQytPaFBEVU1zcTV3aithcTZMSUlEWVpQbzJ2MlZlZkM3?=
 =?utf-8?B?aStHWnNwK1c0dzkvZHVEeEMveitmd3pZa2FLMWllTDMwRkJmOEZKYUptdlhu?=
 =?utf-8?B?U2VQVmVBV3AxWkk2OXd0dTRaTVJsT2pkWElQQzVQSUF4L0FPNTBCNTdXZmZF?=
 =?utf-8?B?Wi9vL1dmQzJVRTFxL3VCZzRxMW9CL2lnMVZKZzNQVGJHaWt2WDJpRGNJZzJQ?=
 =?utf-8?B?U2x1U1JLbUJpb2c1Y2VXaW5kblNVOGdvZCtBQnJiZjBuVGtvSFFUWlNjc1JS?=
 =?utf-8?B?b0psT3lGREQ3YVk4Q3QvRlBCSk5kTSsyYXYrTHpRZFpXQzk4SHdhQTZsVzRn?=
 =?utf-8?B?MkVhUENDbjRwU1ZadXIxYldKOGhtZld1cWNJNHBBQ0pxMG5JOEE5dTl4Wm8r?=
 =?utf-8?B?QVZMYVp5bEpLdXlBbjdsNDEzWHg3bU5YZ0hCWmQraXJodk0rTy94c3ZrL1Bp?=
 =?utf-8?B?SklhSzkyL3dtTkRBZmhXNk1nL2V2Q0tmVUNBcGptZXp6WDJHbm5iYmRxbGZH?=
 =?utf-8?B?UXAvMUU2akExcnpueCtoSnJKR1RUUTVyejExYWlaMDg3OTJ3RzhpOUNuVFhT?=
 =?utf-8?B?aE50VnVDODVtcFVHQ3JKV2ZMTjgxa21zVGhOMEM2UGhWMzB3UEcwSHZEQXJy?=
 =?utf-8?B?T0xhbk9XSDROUWpvUHFIYTlWUFhOYTltWUMrcUlFUHJ0R01SZ3NSc3BuTDkv?=
 =?utf-8?B?TFRQeVNUVkRFSGZJd1RKZXI2SFF6ang1ZnBmLzAzS09oK3k3UkdOcGxSSFZr?=
 =?utf-8?B?clhtUjRXcFZENG1NZlVjSUpmV1h5RWJtQjVES1FJTENidUNrQ1U2U3Vqb3Nj?=
 =?utf-8?B?dlQ0VU5FSThla2o1R3Q1R2FtUjdLZDdBWk9oajdpckcxbTVzME1ucjJVN3Fa?=
 =?utf-8?B?V01JZmlib29SYzdkY2Q3aXhYNVUvTDNrenJPNGs3NEhhdmh4VzB5TVhIb3lJ?=
 =?utf-8?B?RXh1Q2sremtRaGk0c3Y5a1VWV01TdklOc2trL0lrR09kSkhUMGR4ZGVscCtO?=
 =?utf-8?B?N1diZG11OTBDQXZ6YTFQYTdyTjBNcUxIZ1FGM2hUVnBuSmpBeUVVZHNoZFIv?=
 =?utf-8?B?ZWpQNWlDcExsQmNHRFZFamV4KzBtaTc0Tko1QmJvK2dxTEVyZWszZW9TNlpB?=
 =?utf-8?B?dGI1cEMwZjh1dTRLcFdwWkFGNk9wbWRZb3dsVm5QYjNLaFpjU24wOU0rdVQv?=
 =?utf-8?B?OUg1R3BVTjhiNHhwS3BUd05YT0NCMGVQdEF2Qm1MZ1RiMlBqMmFWODVxTHBO?=
 =?utf-8?B?b1RhRjYyU0hDUzVaa053STkzaGRnSkhldHdRYStiZWtFUW5Qdm9WMktDKzZT?=
 =?utf-8?B?STQwelNuUEI5ZTlrM3VHZ29YTGFXRGN3TElUd3ZHaE40TytKWElpc2Vkb2NB?=
 =?utf-8?B?U01GMHIxOVZXS01TdERReC9rZW55UHJ5ekNWV2d6KzU1SkdIcTJmd0JaQjZp?=
 =?utf-8?B?UFNwa215ZGY0SFYzd3p3MVlSVExsclh4cFBjYTNvY3Y2a1FCODhOSEtRRUdV?=
 =?utf-8?B?STdEa0JmcGJZY3V3NE56MzJpbnZXMld2UTJpWUs2OWRnUTNEWnJQUGlrTXc1?=
 =?utf-8?B?Q3ovMlpDTlBadnRybVFMLzg5cnUwMmVBYkFkUkMyckRKc2l4ZG5VZzVZZ1pM?=
 =?utf-8?B?TzVidW8zdGpnbFRtcUR1b2pmUVFobkdMOUNVNnIzd3ZmeGVac1N3NEdyMjBW?=
 =?utf-8?Q?wfuy4WWM6C+b/E5WMjc43ALGn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eedb5a6-6940-4601-83a6-08dc73f71c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 09:20:34.5038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xk6yb4fKItviY8t/tOH/IjubYA8ZAICHXqNVtQX2bGIyYXiIS5G5URrQFe+ggRmXGQnAbX47c/FyHNRxPG2mpOM9+PdbsJn6fAgDynSv9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7194
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogW1BBVENI
IGF0c192dGQgdjEgMTQvMjRdIHBjaTogYWRkIElPTU1VIG9wZXJhdGlvbnMgdG8gZ2V0DQo+YWRk
cmVzcyBzcGFjZXMgYW5kIG1lbW9yeSByZWdpb25zIHdpdGggUEFTSUQNCj4NCj5TaWduZWQtb2Zm
LWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVu
LmNvbT4NCj4tLS0NCj4gaHcvcGNpL3BjaS5jICAgICAgICAgfCAyMCArKysrKysrKysrKysrKysr
KysrKw0KPiBpbmNsdWRlL2h3L3BjaS9wY2kuaCB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gMiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspDQo+DQo+ZGlm
ZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KPmluZGV4IGU1ZjcyZjlmMWQu
LjllZDc4OGM5NWQgMTAwNjQ0DQo+LS0tIGEvaHcvcGNpL3BjaS5jDQo+KysrIGIvaHcvcGNpL3Bj
aS5jDQo+QEAgLTI3NDcsNiArMjc0NywyNiBAQCBBZGRyZXNzU3BhY2UNCj4qcGNpX2RldmljZV9p
b21tdV9hZGRyZXNzX3NwYWNlKFBDSURldmljZSAqZGV2KQ0KPiAgICAgcmV0dXJuICZhZGRyZXNz
X3NwYWNlX21lbW9yeTsNCj4gfQ0KPg0KPitBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVf
YWRkcmVzc19zcGFjZV9wYXNpZChQQ0lEZXZpY2UgKmRldiwNCj4rICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQo+K3sNCj4r
ICAgIFBDSUJ1cyAqYnVzOw0KPisgICAgUENJQnVzICppb21tdV9idXM7DQo+KyAgICBpbnQgZGV2
Zm47DQo+Kw0KPisgICAgaWYgKCFkZXYtPmlzX21hc3RlciB8fCAhcGNpZV9wYXNpZF9lbmFibGVk
KGRldikgfHwgcGFzaWQgPT0NCj5QQ0lfTk9fUEFTSUQpIHsNCj4rICAgICAgICByZXR1cm4gTlVM
TDsNCj4rICAgIH0NCj4rDQo+KyAgICBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2
LCAmYnVzLCAmaW9tbXVfYnVzLCAmZGV2Zm4pOw0KPisgICAgaWYgKCFwY2lfYnVzX2J5cGFzc19p
b21tdShidXMpICYmIGlvbW11X2J1cy0+aW9tbXVfb3BzICYmDQoNClRoaXMgaXMgaW1wbGljaXRs
eSBjaGVja2VkIGluIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbigpLg0KSnVzdCBkbyAi
IGlmIChpb21tdV9idXMpICYmICINCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPisgICAgICAgICAg
ICBpb21tdV9idXMtPmlvbW11X29wcy0+Z2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQpIHsNCj4rICAg
ICAgICByZXR1cm4gaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9hZGRyZXNzX3NwYWNlX3Bhc2lk
KGJ1cywNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9tbXVfYnVzLT5p
b21tdV9vcGFxdWUsIGRldmZuLCBwYXNpZCk7DQo+KyAgICB9DQo+KyAgICByZXR1cm4gTlVMTDsN
Cj4rfQ0KPisNCj4gaW50IHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRl
diwgSG9zdElPTU1VRGV2aWNlDQo+Kmhpb2QsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRXJyb3IgKiplcnJwKQ0KPiB7DQo+ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3Bj
aS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCj5pbmRleCA4NDllMzkxODEzLi4wYzUzMmM1NjNj
IDEwMDY0NA0KPi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQo+KysrIGIvaW5jbHVkZS9ody9w
Y2kvcGNpLmgNCj5AQCAtMzg1LDYgKzM4NSwzOCBAQCB0eXBlZGVmIHN0cnVjdCBQQ0lJT01NVU9w
cyB7DQo+ICAgICAgKiBAZGV2Zm46IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyDQo+ICAgICAg
Ki8NCj4gICAgIEFkZHJlc3NTcGFjZSAqICgqZ2V0X2FkZHJlc3Nfc3BhY2UpKFBDSUJ1cyAqYnVz
LCB2b2lkICpvcGFxdWUsIGludA0KPmRldmZuKTsNCj4rICAgIC8qKg0KPisgICAgICogQGdldF9h
ZGRyZXNzX3NwYWNlX3Bhc2lkOiBzYW1lIGFzIGdldF9hZGRyZXNzX3NwYWNlIGJ1dCByZXR1cm5z
DQo+YW4NCj4rICAgICAqIGFkZHJlc3Mgc3BhY2Ugd2l0aCB0aGUgcmVxdWVzdGVkIFBBU0lEDQo+
KyAgICAgKg0KPisgICAgICogVGhpcyBjYWxsYmFjayBpcyByZXF1aXJlZCBmb3IgUEFTSUQtYmFz
ZWQgb3BlcmF0aW9ucw0KPisgICAgICoNCj4rICAgICAqIEBidXM6IHRoZSAjUENJQnVzIGJlaW5n
IGFjY2Vzc2VkLg0KPisgICAgICoNCj4rICAgICAqIEBvcGFxdWU6IHRoZSBkYXRhIHBhc3NlZCB0
byBwY2lfc2V0dXBfaW9tbXUoKS4NCj4rICAgICAqDQo+KyAgICAgKiBAZGV2Zm46IGRldmljZSBh
bmQgZnVuY3Rpb24gbnVtYmVyDQo+KyAgICAgKg0KPisgICAgICogQHBhc2lkOiB0aGUgcGFzaWQg
YXNzb2NpYXRlZCB3aXRoIHRoZSByZXF1ZXN0ZWQgbWVtb3J5IHJlZ2lvbg0KPisgICAgICovDQo+
KyAgICBBZGRyZXNzU3BhY2UgKiAoKmdldF9hZGRyZXNzX3NwYWNlX3Bhc2lkKShQQ0lCdXMgKmJ1
cywgdm9pZCAqb3BhcXVlLA0KPisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW50IGRldmZuLCB1aW50MzJfdCBwYXNpZCk7DQo+KyAgICAvKioNCj4rICAgICAq
IEBnZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZDogZ2V0IHRoZSBpb21tdSBtZW1vcnkgcmVnaW9uIGZv
ciBhDQo+Z2l2ZW4NCj4rICAgICAqIGRldmljZSBhbmQgcGFzaWQNCj4rICAgICAqDQo+KyAgICAg
KiBAYnVzOiB0aGUgI1BDSUJ1cyBiZWluZyBhY2Nlc3NlZC4NCj4rICAgICAqDQo+KyAgICAgKiBA
b3BhcXVlOiB0aGUgZGF0YSBwYXNzZWQgdG8gcGNpX3NldHVwX2lvbW11KCkuDQo+KyAgICAgKg0K
PisgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51bWJlcg0KPisgICAgICoNCj4r
ICAgICAqIEBwYXNpZDogdGhlIHBhc2lkIGFzc29jaWF0ZWQgd2l0aCB0aGUgcmVxdWVzdGVkIG1l
bW9yeSByZWdpb24NCj4rICAgICAqLw0KPisgICAgSU9NTVVNZW1vcnlSZWdpb24gKiAoKmdldF9t
ZW1vcnlfcmVnaW9uX3Bhc2lkKShQQ0lCdXMgKmJ1cywNCj4rICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLA0KPisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZGV2Zm4sDQo+KyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IHBhc2lkKTsNCj4gICAgIC8qKg0KPiAgICAgICogQHNldF9pb21tdV9kZXZpY2U6IGF0dGFjaCBh
IEhvc3RJT01NVURldmljZSB0byBhIHZJT01NVQ0KPiAgICAgICoNCj5AQCAtNDIwLDYgKzQ1Miw4
IEBAIHR5cGVkZWYgc3RydWN0IFBDSUlPTU1VT3BzIHsNCj4gfSBQQ0lJT01NVU9wczsNCj4NCj4g
QWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UoUENJRGV2aWNlICpk
ZXYpOw0KPitBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZV9wYXNp
ZChQQ0lEZXZpY2UgKmRldiwNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpOw0KPiBpbnQgcGNpX2RldmljZV9zZXRfaW9t
bXVfZGV2aWNlKFBDSURldmljZSAqZGV2LCBIb3N0SU9NTVVEZXZpY2UNCj4qaGlvZCwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPiB2b2lkIHBjaV9k
ZXZpY2VfdW5zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2KTsNCj4tLQ0KPjIuNDQuMA0K

