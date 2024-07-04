Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9738C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPO6f-0004SN-Mq; Thu, 04 Jul 2024 11:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sPO6d-0004RG-A6
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:10:43 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sPO6a-0000pw-QA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720105841; x=1751641841;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=N4ZGSDeAl8uikMkQ3g7PLvDYb9ZG0XEDTNa/ZWEv2CA=;
 b=TYqG62aDzl9E5GBB67b2o+RH3a+Ryia67O78igdNhI7gMf4DgjGUcf4R
 zJ8zIaB1XEjhzqY49nset9UePZ/0H7beuFJvv2XEHYJqHlStlN8A007f4
 RjX8utNyfahxQeDZBZiYKevol9xjgQ5Op5rnBrrOt1pjz6jArv/6GnWY5
 xhLnaTpzc13hlX43i/l+QYT08c03QsWhhCebD9+Q4ENP8pNPngH6UVA76
 uLjFO683CfdBCPRXCRBMly6bPMDWgxJeYkqZTZRjlK4cpoNmzHlWCbwgu
 ZMZ9oTuKQKeTKWMqq7xE6gH2TBMksMOpAsEZct/H6cGLdgpgvEUTMlWVO w==;
X-CSE-ConnectionGUID: l/RaYHq+QlGa14OsieboMg==
X-CSE-MsgGUID: VD7Ms18qQ6KZ06YkwW6+Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21259378"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="21259378"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 08:10:36 -0700
X-CSE-ConnectionGUID: L8tksIDgTYSaUDb7yTSf4g==
X-CSE-MsgGUID: TFEPhUOgQSm2Guo8zJD7kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="51593633"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jul 2024 08:10:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 08:10:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 08:10:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 08:10:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 08:10:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lciFJ9jBw+Z1FoK+jyzLvo3dQuiFeTNGv5QeVEcWL8PaGy/1iJdyhy8EKeOZf7ff+isAF1KKpdoNfrNdDfCE9bHLBSgSIx7c8rYjTd6LC/XAGz6a6lm7lS1Byy8ZUl5pdQic7R2brey8AgRKaI8Rb/n/pMRu5twARU83t1kGlqZxS1Axg/Lj6RtydxbQDLcNKHaGBYyyu68QkZ+LjJ0I0O2hAehn07qFYUckWhoQECLxx5IFOwXUTlJm0glqnjY5pEY2h12PQhBfkfQIURYfH1ypp45n51irRXax+6PTjT6Rw5Pz0L4tvXd8RFgmPUCsbzvaGFgz+FwzWNgYIx4CeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4ZGSDeAl8uikMkQ3g7PLvDYb9ZG0XEDTNa/ZWEv2CA=;
 b=T+j8Cvvimzf0XaMOLeuGhdyg+UZnDdPS7bLkH0GQNwBV3JynwBG+icnB1JR5SW9k8S7s1sbgW3usRcsnzqWIXU7ZmODFN19fep86evqScSjPfJ0qZden2eU04OBFR1tuXPIZf5ZCjwi7ZqpzrVQjaXn3uPOtRvghPTFGPEWxiWpkO0HMiuTlkkWgoMvfII1WVjER+v/mrAuMbByN6H9BrviDbaeZs/eI8BM8K9uLmtTLsSYfwLdorVOBVjgdlHPsChI5Q5nZdMmzl61O1ySlIYvFWOmbPHQnj3fYfJEYq/ZhUUG3EJRLos+UM1AOf0qu0r/oygnM/bqM7/+dWOPFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Thu, 4 Jul
 2024 15:10:28 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%5]) with mapi id 15.20.7719.029; Thu, 4 Jul 2024
 15:10:28 +0000
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
Thread-Index: AQHazVg5C0RiDxJPOUeRPpagSbRqXrHlS/KAgACmBAA=
Date: Thu, 4 Jul 2024 15:10:27 +0000
Message-ID: <DS0PR11MB6373852F86A43ED9E1AFC7B7DCDE2@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <ZoWSdR1IOQ0iIxZC@x1n>
In-Reply-To: <ZoWSdR1IOQ0iIxZC@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|PH7PR11MB6006:EE_
x-ms-office365-filtering-correlation-id: c84f298d-cd9e-49f0-a39a-08dc9c3b703b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eFdVSlJVZExCSmhCL3JVRWY2QVRtbW9RYWU3U052WWJCT1RwWFJVN1RxeGp0?=
 =?utf-8?B?S1NYK0FtUVgwRDZCTUFjcDhUUytPSlE1Rkpkbk1wWTcyM21rWHI0dnVyV2NP?=
 =?utf-8?B?ZEhPUHpRYjYzNVNLd0QzUmM2cmNpQlJlcmwzQXU0b0s5bzBFTUpxUEp6TFNy?=
 =?utf-8?B?VmIrMEFVODNYMzhEVXBHQ0szeFI1S0hZODNVWnMxWW1iQTBvOUJOTklrKy9C?=
 =?utf-8?B?QVZYMlIrY1lkR2VEbEhnNEs2TkpYOVNhMmwyMWJOOTVJSGJaWTBKbmV1Q2l0?=
 =?utf-8?B?Z1k3OVB0aU9BeHJSb3RmbFYzM3RKd0VicHJlNitacllGNmNNbC9LMG9iWlBE?=
 =?utf-8?B?L0wyaWN2NEQwdFUvbERqcGtmUjMybmxtckZ2ekg0cVFVSnZHNVcwYUVMUmds?=
 =?utf-8?B?TFdUbWhON1hUWTVLVk1FMGJLL1FNclRRVjU2TmowNks0SXNVZk1RbDJITHRB?=
 =?utf-8?B?WjI4OEFFYzJjV2RNQkFONm43Nm5XaHhFZTN1b01iNGI0ZnJaUlBuT3lJOEJy?=
 =?utf-8?B?clBZcUR6eXhUUzVZSCt5UFBIMWhyMnZPekRpK016WXJhUkgyWUZ1UXZzUktN?=
 =?utf-8?B?Wm9ydnJaUW9ORHdVM2pRRVFrdWF3ZEJOaVlTZXNDY25YNVFvc3B1K25lUjMx?=
 =?utf-8?B?bXVwallsWWt0bVhpUnhkY1c1TkY1Tm1NeHo4ZGptV2FhUUhMNjF5RDRVYVJH?=
 =?utf-8?B?QlQ5emlzNmtsQk55ZmZvaGxRMXFCOTVBM2VheWZJSjBQaUlHN2w1RVdvbWZo?=
 =?utf-8?B?ZXYyR2xGYUxFSjByQ0N0ZTcwTkxsdWkxaTNrWks5cndvMU0vM2RXUVdVRUxu?=
 =?utf-8?B?QU1Md20wR3VZZEkyMnRtRmlPZncxTnR5b1NheTR6aTRkSmc2K3A1U2hOQ2lV?=
 =?utf-8?B?S0RwQXh5QVdKOXpJa05QajZSbXI0NzVsSzJEMHBjbW1hejdjTS80YkgzYjR1?=
 =?utf-8?B?dWJVVXBhMkIrOUpXVUplWHlrM2NHMEc2dWlZbnVwMFBtbCtSN2dTUVNkU0Yx?=
 =?utf-8?B?RTVPTG0vZU1JZlVZOUx5NTVFdDRXNEVvcmUrNmhGN2lQMERKUUFBTVNqR1V3?=
 =?utf-8?B?WDN0Myt5azVkSUd5TS8raXIyS3U5MlUzTjhxdGt3UnUvY3hzRWZKd1M0cFc2?=
 =?utf-8?B?SktaeDdnWE1kWmRnVE9WWksySXdqc0pzVVJHSU1SZ3lrNFZZRHRpa2d0Zm5V?=
 =?utf-8?B?ZXRsdUZpRzRvc3dENWFVWmt1b0RuaktQUnN5c0VMWXZ0Y1c1N0l0aEFuWW5K?=
 =?utf-8?B?Q0VwZG9jdUNacDlEcy9rVlF3Q2dDSEl0MUVwNW9UdGlnMU8yL1p1Z29PMWNs?=
 =?utf-8?B?UEhrQjZKcXA0NVpCT21oZFdUd1lMODhhWUxCU0VDOUwzN2poa0s5NC9NaFFw?=
 =?utf-8?B?M0R0R29BWXB5anoxTDJYamkvclJ3d3UvNnZCeUVsdFhpQnRnLzFlMWlrMjky?=
 =?utf-8?B?bE5jUm1DRDFMRTg5NTBEMEErL3RENVlvYjgwdGlLZmlQSzY2SlZBdVVVZExT?=
 =?utf-8?B?OEJsWEFmMUppek5HZ1d0MWFsb0pVN2MzWFFXd3VMK0x2ZjZ5SEdoVTdKdHd3?=
 =?utf-8?B?VXNBc0kydVNENXM1S3hGMElBbzJYRElmbm1RZ25ZTlJYSnY1cFVyWGF0cnhz?=
 =?utf-8?B?RmFHN2MwTXphaVNiWDhkVEZsM1BXY2VncjdYMGRTVVcxVU4zU1doWGF0ZFBa?=
 =?utf-8?B?WTFVc2QxUTQyMEpjSTFiYVozOFNxQnRWVG5jNU5vNkJKSWpLbVVTSWQ3NDBQ?=
 =?utf-8?B?NkhTaTYvS0RHbCtPRXRPWE5OdFRnZTBHaEhUMEo1MUR1N2tYYmFVYnF4QjJS?=
 =?utf-8?B?OVM2c3lKTEZ6YVNFaFNwWTQ2anlLMDRPLy9lYU5FdHBRWjkrMHJCV01qMG9F?=
 =?utf-8?B?TlJLc0FoWWpTWFdmQ1MzRHdRNE9keUJ5M0JLc3hHcTZoYlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEE4dURNcmpma3B5bWpRbmxCN0FUdkE1aU5Ib2x3UHpCd3JnMkthV1RidGNB?=
 =?utf-8?B?T3RWdzk4UU9uZjFqTXRtOE1TcGUyT2hJaE12WjI4OFJSQzZIZitocml6cWF3?=
 =?utf-8?B?TDB2TjNuVXl3elY4akFiNGsvbjhBZFBHeWNGZVFSZDZXNG9mMzQ3L2NONVoz?=
 =?utf-8?B?ank1Yit0T2Jqelg2Z1JXUlFva21ENjZPenRQdmlhMXEzYnhRelY1OWFFeUxi?=
 =?utf-8?B?V3JmcjR6WkxMVDl2ZkJ1ZWFvQTRzaFpVeDJiVCthWXFQNkh2V1pKdHBwNXc1?=
 =?utf-8?B?ZFJNTWxiWjBTVGM5aXNYYTZubUp5aHBtOW9BWGdQajhUbUp0R3ltWXJVVC9t?=
 =?utf-8?B?c093S2hLOW4vVFpjOUZZL2xscC9zK3pLR29RZ2dGbUZudUNVbGViTmZWT2Uv?=
 =?utf-8?B?ZER3bEhTeEJqZk45ZWthb2JPeUViOHpnNHM3ZEo1ME52Q2FUSEdQakZic1Ay?=
 =?utf-8?B?Y0piYWRMK1FhSXpDaG9DRlN3MEgzdjlmUXhaeHAwRnNQVG5sQjBHejhTR09Q?=
 =?utf-8?B?aGw5SUNXYVhtVW5HWEMrZnhqWDQvSHE3T3p5RkdpL3VMTkNJcElrcVU3b2hG?=
 =?utf-8?B?c0w2anQ4YUgzZkR4OW1TcW1WcnRRMnNySG9Celhxc21lSGZoVlI0Nzk5NlNL?=
 =?utf-8?B?TndMNVY0SDlPQVF1SEU0QWsyS2I5M1Y0Y2FIV1EyRC9Yb1loWEhGbnN3U3dW?=
 =?utf-8?B?dmRLdUFyK0plblF0Y0R3aFVFWmlWbGFRQzNheEZQbldZSkM0VUYrbUZIUy94?=
 =?utf-8?B?dVdHMUZQZkt0RFVrUGJ6c1FmVUhOdEdkajhzSFRucVdnNFJEYmlKT3VONUNt?=
 =?utf-8?B?TDhLMU9qNXJTU0tkbm43eFVTMnVEaHZORTVlMzcvUUxVL1pIT25ka00wTlFH?=
 =?utf-8?B?ajV3V3BEb0htdFFIbnVOMUlXWlhWVWF3YTJpaXdZZmU0a1V3SG84cVhGWmVE?=
 =?utf-8?B?cUNDTTg3Y1FiVnRtV1pUNUhpQ1hGR2RLTHUyaFNKMkI3MlpNTWFnenVyTUla?=
 =?utf-8?B?T3ZRd1hKcGZRZkhLN2I3aENpbFQ3NkFIcDRNRTNNV0dqRVNuSVQwSEh6dkpn?=
 =?utf-8?B?d0x4V0VkbUlrYWNPV0RqbFBZeCtDTGo1bHlsSGdGcHhyOE5LQWlZbnZFU0s4?=
 =?utf-8?B?aW14b2x2bVdkb0tMckR1S0IvWHQ3VlYraWxwMDZQVUI3NUZHcnNTSHYxazMr?=
 =?utf-8?B?c0ozNGk0MW5mV3RHLy9ubW1aeTdra2pVMitac3gzNWtZMmVtUCttY0I1SXVw?=
 =?utf-8?B?SVV2b2ZMdVdYWXRIYUxpdlgvMjFhTEhzdUFKRlBLMFk0eXNsd1JST242OGJZ?=
 =?utf-8?B?N041NGRkTVh4TitrbW5ZNGRDZFp1eUZNTFdzWlJpM0lTMUVYOHBZb3JyQUJV?=
 =?utf-8?B?dlVSRUkvejRSalB2b2R1THZheGhZRDErejYzQW1EdVhmMVZTNFdmWEVlU2tm?=
 =?utf-8?B?QW5yTUJNR2N5d0l3SUFIZ0grdFlYczRUNHN5dG1qWTVkdUltQ3N3Y2ZCZWdu?=
 =?utf-8?B?alhYdW1zeGV4dVAwSlZ6MWtPVzBoSXlRaVFaSEhDeHd1dGZNTGtnaEJNL1lV?=
 =?utf-8?B?VFpHOGRuTGRNeXVhdm9aSnUzWTFUMXRQQTJ3ZmhKMTdza3NzWlNOenh0TWp3?=
 =?utf-8?B?NUhYUnJ2c28xME1JS2YwaThqd0psOHZWQW1qZ2FtTWlGUFhPRkpQT0VnSUFH?=
 =?utf-8?B?cmxzVzNQUUxTYkl2VVA5SkdxckNUK1luaFdCeW5Hci9JVGNsdmNCZ3JYL0Q4?=
 =?utf-8?B?c20vQ3ZqT3pPaU8yZXdqamRSazRNRHFqUldxK0tCTVpBQTZFQnRUaFRtTjdq?=
 =?utf-8?B?Ym9qREZCaWxpWlJIeEw5bjJ4bVJuT0F1UkFYMXpwLzR4U2c1NmpHZmNtNkdD?=
 =?utf-8?B?V2pjbGluYXdtaTI2c1k0UHZjUElDc0drTW8zMG1ZZEFDdnFKcUlpd3VDb0Vy?=
 =?utf-8?B?VURxd2xvdTF3VFM0UVVkUjhEb1poNFN6ZXkxRzA3R1kxQmhTY0hhU0JBRGtk?=
 =?utf-8?B?SE9VUDdjL3FqbS9xSU1oOU1EUnlvNE5DdWRUNThyeG1tYndMSjVlSENlUVM3?=
 =?utf-8?B?bEg4RGc4WHFpZk5HMXRUTE9pOFlJQzR3WEtYN2xYVXJ2bUNOdGY5WTlUc3Nx?=
 =?utf-8?Q?mS931VJVjEm2ZdbyY0Sd6br2K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84f298d-cd9e-49f0-a39a-08dc9c3b703b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 15:10:27.9098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4+gr6YVg2LnTfkmP5OYw8dtfIfJMeiTARBJYgYvk7eE/oIyjeRp6hHXvmStHuyZQm9UB9ZpdDocNCCTsOAylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6006
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=wei.w.wang@intel.com;
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

T24gVGh1cnNkYXksIEp1bHkgNCwgMjAyNCAyOjA0IEFNLCBQZXRlciBYdSB3cm90ZToNCj4gT24g
V2VkLCBKdWwgMDMsIDIwMjQgYXQgMTA6NDk6MTJQTSArMDgwMCwgV2VpIFdhbmcgd3JvdGU6DQo+
ID4gV2hlbiBlbmZvcmNlX2NwdWlkIGlzIHNldCB0byBmYWxzZSwgdGhlIGd1ZXN0IGlzIGxhdW5j
aGVkIHdpdGggYQ0KPiA+IGZpbHRlcmVkIHNldCBvZiBmZWF0dXJlcywgbWVhbmluZyB0aGF0IHVu
c3VwcG9ydGVkIGZlYXR1cmVzIGJ5IHRoZQ0KPiA+IGhvc3QgYXJlIHJlbW92ZWQgZnJvbSB0aGUg
Z3Vlc3QncyB2Q1BVIG1vZGVsLiBUaGlzIGNvdWxkIGNhdXNlIGlzc3VlcyBmb3INCj4gbGl2ZSBt
aWdyYXRpb24uDQo+ID4gRm9yIGV4YW1wbGUsIGEgZ3Vlc3Qgb24gdGhlIHNvdXJjZSBpcyBydW5u
aW5nIHdpdGggZmVhdHVyZXMgQSBhbmQgQi4NCj4gPiBJZiB0aGUgZGVzdGluYXRpb24gaG9zdCBk
b2VzIG5vdCBzdXBwb3J0IGZlYXR1cmUgQiwgdGhlIHN0dWIgZ3Vlc3QgY2FuDQo+ID4gc3RpbGwg
YmUgbGF1bmNoZWQgb24gdGhlIGRlc3RpbmF0aW9uIHdpdGggZmVhdHVyZSBBIG9ubHkgaWYNCj4g
ZW5mb3JjZV9jcHVpZD1mYWxzZS4NCj4gPiBMaXZlIG1pZ3JhdGlvbiBjYW4gc3RhcnQgaW4gdGhp
cyBjYXNlLCB0aG91Z2ggaXQgbWF5IGZhaWwgbGF0ZXIgd2hlbg0KPiA+IHRoZSBzdGF0ZXMgb2Yg
ZmVhdHVyZSBCIGFyZSBwdXQgdG8gdGhlIGRlc3RpbmF0aW9uIHNpZGUuIFRoaXMgZmFpbHVyZQ0K
PiA+IG9jY3VycyBpbiB0aGUgbGF0ZSBzdGFnZSAoaS5lLiwgc3RvcCZjb3B5IHBoYXNlKSBvZiB0
aGUgbWlncmF0aW9uDQo+ID4gZmxvdywgd2hlcmUgdGhlIHNvdXJjZSBndWVzdCBoYXMgYWxyZWFk
eSBiZWVuIHBhdXNlZC4gVGVzdHMgc2hvdyB0aGF0DQo+ID4gaW4gc3VjaCBjYXNlcyB0aGUgc291
cmNlIGd1ZXN0IGRvZXMgbm90IHJlY292ZXIsIGFuZCB0aGUgZGVzdGluYXRpb24NCj4gPiBpcyB1
bmFibGUgdG8gcmVzdW1lIHRvIHJ1bi4NCj4gPg0KPiA+IE1ha2UgImVuZm9yZV9jcHVpZD10cnVl
IiBhIGhhcmQgcmVxdWlyZW1lbnQgZm9yIGEgZ3Vlc3QgdG8gYmUNCj4gPiBtaWdyYXRhYmxlLCBh
bmQgY2hhbmdlIHRoZSBkZWZhdWx0IHZhbHVlIG9mICJlbmZvcmNlX2NwdWlkIiB0byB0cnVlLA0K
PiA+IG1ha2luZyB0aGUgZ3Vlc3QgdkNQVXMgbWlncmF0YWJsZSBieSBkZWZhdWx0LiBJZiB0aGUg
ZGVzdGluYXRpb24gc3R1Yg0KPiA+IGd1ZXN0IGhhcyBpbmNvbnNpc3RlbnQgQ1BVSURzIChpLmUu
LCBkZXN0aW5hdGlvbiBob3N0IGNhbm5vdCBzdXBwb3J0DQo+ID4gdGhlIGZlYXR1cmVzIGRlZmlu
ZWQgYnkgdGhlIGd1ZXN0J3MgdkNQVSBtb2RlbCksIGl0IGZhaWxzIHRvIGJvb3QNCj4gPiAod2l0
aCBlbmZvcmVfY3B1aWQ9dHJ1ZSBieSBkZWZhdWx0KSwgdGhlcmVieSBwcmV2ZW50aW5nIG1pZ3Jh
dGlvbiBmcm9tDQo+ID4gb2NjdXJpbmcuIElmIGVuZm9yZV9jcHVpZD1mYWxzZSBpcyBleHBsaWNp
dGx5IGFkZGVkIGZvciB0aGUgZ3Vlc3QsIHRoZQ0KPiA+IGd1ZXN0IGlzIGRlZW1lZCBhcyBub24t
bWlncmF0YWJsZSAodmlhIHRoZSBtaWdyYXRpb24gYmxvY2tlciksIHNvIHRoZQ0KPiA+IGFib3Zl
IGlzc3VlIHdvbid0IG9jY3VyIGFzIHRoZSBndWVzdCB3b24ndCBiZSBtaWdyYXRlZC4NCj4gPg0K
PiA+IFRlc3RlZC1ieTogTGVpIFdhbmcgPGxlaTQud2FuZ0BpbnRlbC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogV2VpIFdhbmcgPHdlaS53LndhbmdAaW50ZWwuY29tPg0KPiANCj4gW0NvcHkgSmly
aSBhbmQgRGFuIGZvciBsaWJ2aXJ0LXNpZGUgaW1wbGljYXRpb25zXQ0KDQpUaGFua3MhDQoNCj4g
DQo+ID4gLS0tDQo+ID4gIHRhcmdldC9pMzg2L2NwdS5jICAgICB8ICAyICstDQo+ID4gIHRhcmdl
dC9pMzg2L2t2bS9rdm0uYyB8IDI1ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9jcHUuYyBiL3RhcmdldC9pMzg2L2NwdS5jIGluZGV4
DQo+ID4gNGMyZTZmM2E3MS4uN2RiNGZlNGVhZCAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQvaTM4
Ni9jcHUuYw0KPiA+ICsrKyBiL3RhcmdldC9pMzg2L2NwdS5jDQo+ID4gQEAgLTgyNTgsNyArODI1
OCw3IEBAIHN0YXRpYyBQcm9wZXJ0eSB4ODZfY3B1X3Byb3BlcnRpZXNbXSA9IHsNCj4gPiAgICAg
IERFRklORV9QUk9QX1VJTlQzMigiaHYtdmVyc2lvbi1pZC1zbnVtYmVyIiwgWDg2Q1BVLA0KPiA+
IGh5cGVydl92ZXJfaWRfc24sIDApLA0KPiA+DQo+ID4gICAgICBERUZJTkVfUFJPUF9CT09MKCJj
aGVjayIsIFg4NkNQVSwgY2hlY2tfY3B1aWQsIHRydWUpLA0KPiA+IC0gICAgREVGSU5FX1BST1Bf
Qk9PTCgiZW5mb3JjZSIsIFg4NkNQVSwgZW5mb3JjZV9jcHVpZCwgZmFsc2UpLA0KPiA+ICsgICAg
REVGSU5FX1BST1BfQk9PTCgiZW5mb3JjZSIsIFg4NkNQVSwgZW5mb3JjZV9jcHVpZCwgdHJ1ZSks
DQo+IA0KPiBJIGFzc3VtZSBpbiBtYW55IGNhc2VzIHBlb3BsZSBjYW4gc3RpbGwgcHJvcGVybHkg
bWlncmF0ZSB3aGVuIHRoZSBob3N0cyBhcmUNCj4gc2ltaWxhciBvciBpZGVudGljYWwsIHNvIG1h
eWJlIHdlIGF0IGxlYXN0IHdhbnQgdGhlIG9sZCBtYWNoaW5lIHR5cGVzIGtlZXANCj4gd29ya2lu
ZyAoYnkgaW50cm9kdWNpbmcgYSBtYWNoaW5lIGNvbXBhdCBwcm9wZXJ0eSk/DQoNCllvdSBtZWFu
dCBrZWVwaW5nICJlbmZvcmNlX2NwdWlkPWZhbHNlIiBmb3Igb2xkIG1hY2hpbmUgdHlwZXMgKGUu
Zy4gYmVmb3JlIDkuMSk/DQpUaGlzIHdpbGwgbWFrZSB0aGVtIG5vbi1taWdyYXRhYmxlIHdpdGgg
dGhpcyBwYXRjaCwgYnV0IHRoZXkgd2VyZSBtaWdyYXRhYmxlIChieQ0KZGVmYXVsdCkgYXMgIm1p
Z3JhdGFibGUiIHdhc24ndCBlbmZvcmNlZCBieSAiZW5mb3JjZV9jcHVpZCIuIFNob3VsZCB3ZSBr
ZWVwIHRoZW0NCmJlaW5nIG1pZ3JhdGFibGUgYnkgZGVmYXVsdCAoZS5nLiBlbmZvcmNlX2NwdWlk
PXRydWUpIGFzIHdlbGw/DQoNCj4gDQo+ID4gICAgICBERUZJTkVfUFJPUF9CT09MKCJ4LWZvcmNl
LWZlYXR1cmVzIiwgWDg2Q1BVLCBmb3JjZV9mZWF0dXJlcywgZmFsc2UpLA0KPiA+ICAgICAgREVG
SU5FX1BST1BfQk9PTCgia3ZtIiwgWDg2Q1BVLCBleHBvc2Vfa3ZtLCB0cnVlKSwNCj4gPiAgICAg
IERFRklORV9QUk9QX1VJTlQzMigicGh5cy1iaXRzIiwgWDg2Q1BVLCBwaHlzX2JpdHMsIDApLCBk
aWZmIC0tZ2l0DQo+ID4gYS90YXJnZXQvaTM4Ni9rdm0va3ZtLmMgYi90YXJnZXQvaTM4Ni9rdm0v
a3ZtLmMgaW5kZXgNCj4gPiBkZDhiMGYzMzEzLi5hZWU3MTdjMWNmIDEwMDY0NA0KPiA+IC0tLSBh
L3RhcmdldC9pMzg2L2t2bS9rdm0uYw0KPiA+ICsrKyBiL3RhcmdldC9pMzg2L2t2bS9rdm0uYw0K
PiA+IEBAIC0xNzQxLDcgKzE3NDEsNyBAQCBzdGF0aWMgaW50IGh5cGVydl9pbml0X3ZjcHUoWDg2
Q1BVICpjcHUpDQo+ID4gICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBF
cnJvciAqaW52dHNjX21pZ19ibG9ja2VyOw0KPiA+ICtzdGF0aWMgRXJyb3IgKmNwdV9taWdfYmxv
Y2tlcjsNCj4gPg0KPiA+ICAjZGVmaW5lIEtWTV9NQVhfQ1BVSURfRU5UUklFUyAgMTAwDQo+ID4N
Cj4gPiBAQCAtMjAxMiw2ICsyMDEyLDE1IEBAIGZ1bGw6DQo+ID4gICAgICBhYm9ydCgpOw0KPiA+
ICB9DQo+ID4NCj4gPiArc3RhdGljIGJvb2wga3ZtX3ZjcHVfbmVlZF9ibG9ja19taWdyYXRpb24o
WDg2Q1BVICpjcHUpIHsNCj4gPiArICAgIENQVVg4NlN0YXRlICplbnYgPSAmY3B1LT5lbnY7DQo+
ID4gKw0KPiA+ICsgICAgcmV0dXJuICFjcHUtPmVuZm9yY2VfY3B1aWQgfHwNCj4gPiArICAgICAg
ICAgICAoIWVudi0+dXNlcl90c2Nfa2h6ICYmIChlbnYtPmZlYXR1cmVzW0ZFQVRfODAwMF8wMDA3
X0VEWF0gJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVUlEX0FQ
TV9JTlZUU0MpKTsgfQ0KPiANCj4gTml0OiBtYXliZSBpdCdzIG5pY2UgdGhpcyByZXR1cm5zIGEg
ImNvbnN0IGNoYXIqIiB3aXRoIGRldGFpbGVkIHJlYXNvbnMgdG8gYmUgcHV0DQo+IGludG8gdGhl
IGVycm9yX3NldGcoKSwgc28gaXQgZHVtcHMgdGhlIHNhbWUgYXMgYmVmb3JlIGZvciB0aGUgaW52
dHNjIGJsb2NrZXIuDQoNClNvdW5kcyBnb29kLiBJJ2xsIGNoZWNrIGhvdyB0byBpbmNvcnBvcmF0
ZSBzdWNoIGluZm8gaW50byB0aGUgbG9ncy4NCg==

