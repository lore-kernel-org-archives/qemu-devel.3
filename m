Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1791ACCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 03:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ERc-0002Wh-GF; Wed, 15 Oct 2025 23:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9ERZ-0002WE-6z
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 23:14:21 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9ERU-0004Rh-AY
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 23:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760584457; x=1792120457;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wQXRhxPpob1e3XZkZJBJji+6t4IruaDyO0C+LQwsnSE=;
 b=EK0ZJbKTLkHJpJHYRimo8qpWyjKcF9gkQYVooBjqwB0ti11aqVAyNglA
 fO1E71tmIbURCE1HA5itrwCeAskm95LiyHUvpUnNehRjb2GgNSlOnMe6Y
 iJ1OR3w7VJNAUf/3w3uk5I7x/lrdcnQeByKYhepdTQ2WPw0TrjAlXHiPe
 MvtAhh+xR/LZU5LXXB9tac7rdvGOr1wObjy3u3YeFDoVrFosw8s6LPjOX
 DZReqzxu5VZIghlLEzSNq/AqFrcF5AgTs+O4j78WLbTDw2IFS7bGQG4XV
 aBW1XcVW3eHrph1Om/808AoqkGvaYYeMw7maipUn71NL/QpoRbkLXoYfz A==;
X-CSE-ConnectionGUID: McYjbBnMQIiBnBAYrTlorg==
X-CSE-MsgGUID: sZjKckyzTXqQAjdYPnoRFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73049099"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; d="scan'208";a="73049099"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 20:14:13 -0700
X-CSE-ConnectionGUID: RqUu09IVStqm9jYibVb2UA==
X-CSE-MsgGUID: mBdUK/FOSiWeJbLq4PIr9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; d="scan'208";a="181890868"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 20:14:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 20:14:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 20:14:11 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 20:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yugMM08lNJjDw22KVwNWSHsKJjXyx/R6/Vk9Xi8A/eG3AwuCComuVX+SM56/Ge/UBoayzxdsevF9Upbo3n+HZ9h4+Jc46O7k8R6jTYzcbxjSFU+ipZQNDViYez2qDRagSNNMo+cHsa++0Z+ykSKR7iEbX7qc7PeNw372XF3S8m6R7NGMLKlT8qX/At6F6nzI03WrlsBAj7mZp+HJJ1GDk8ObqSPTDAIippoUSu7cJTU8jJtlBINPv2X9eO9xqgYZl/PIHQCEHMe03ucXdSeAFP3/C7+ySCACrDJCqC3tMtW6notAJBFVrPfM3Z515yW+/dEPx6GpgJR6jNHOWq+0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQXRhxPpob1e3XZkZJBJji+6t4IruaDyO0C+LQwsnSE=;
 b=gcNLMpwx0mNjBnAEoqUsZD9jtWEKO7j9KsOX/EJYnIeBtfo/Gkb8b9ZLZiSVs01Qx4dW7Uj3TBBeziP7VmOqdZHQiTbIVomQ7TOFhxsqhpyxAvrh68JPbWvKhK62L3SM/9gtxLoMVOdW9pEH8oBgQbL0Fzvtxa7yTqik7zetw+QLDRIpzZfB7UVEm9YzfUIn9Yd1vUxQyypTT1FJSL+vJj9eIGb73q37KBZ0c7zbtHUO87iidqafkZFLtD11iXWBCcTtcyNyxdlmhpehVPcA201mK33sXj7uUjgQ8msBxYQ50mXQvl3dbCBikGhuxsb8IlxSAnS/58CBkzZUvHnJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 03:14:08 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 03:14:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>
Subject: RE: [PATCH 3/3] intel_iommu: Fix DMA failure when guest switches
 IOMMU domain
Thread-Topic: [PATCH 3/3] intel_iommu: Fix DMA failure when guest switches
 IOMMU domain
Thread-Index: AQHcPb1dnxsbeD/0xU2J5HU3RbeolbTDJr0AgADyGIA=
Date: Thu, 16 Oct 2025 03:14:08 +0000
Message-ID: <IA3PR11MB9136760C5DACFA58830EDD9F92E9A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251015102003.279239-1-zhenzhong.duan@intel.com>
 <20251015102003.279239-4-zhenzhong.duan@intel.com>
 <847a4b9a-2de1-4c97-b5a4-0cfa6827bf63@intel.com>
In-Reply-To: <847a4b9a-2de1-4c97-b5a4-0cfa6827bf63@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB4998:EE_
x-ms-office365-filtering-correlation-id: 67919093-e625-40ac-082e-08de0c621200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UlYwSzZkZG56NWdiSnZLbVNQQ01TaFVPYlBJUStqRnV1eVJyS3drOG9FbW05?=
 =?utf-8?B?WDcvVXE3eXFGeURpejgzQVZCcUVQZXB1SkFXdFhsb0hTMjEzbHpzVWtoTFZX?=
 =?utf-8?B?T1U3L2FQd2JsN1JyTm54Vm5VVnFKbGZpTXN6S3UzaWRRaUV3Q1I2b3JHZXNS?=
 =?utf-8?B?WElVeE02TGw1NTcveXBEbEtKNFlGZ2Z0TzJydTJsMEYwU3pUMFIrWE96Wjhu?=
 =?utf-8?B?LzB3YklWNVdOUmhxMnVhaVAwdUhNTU9ZN25RYXJBbEVZUUx4MkJ2RXY4OURQ?=
 =?utf-8?B?TExJUzVLZG9RNTIwY0NIZlJnMURLcE9nSk5JUUtZK2xnV2N5bWRmQ0k5NG5Z?=
 =?utf-8?B?NzNRbGlTcFpFeE1OV1gwR3NCKzRrckIzZGg1ZC9hNEFRUUFFSjVDbDBLNi9I?=
 =?utf-8?B?V1ZKcXBWbzZxOVFMNEdjL0hpMlZ5ME93dzFacldNZDVrOXFSNjBabmhFeGpX?=
 =?utf-8?B?blVmak5udU0zLzYzNVlhK2FGMTlWSTJ2ZTY2c0xWc3hVQ2MrdTA1UEVvRjBT?=
 =?utf-8?B?Z01QZW5iVmdRamhyeDhkN0FTMzVMVVg1VGpna1V6K2xobUJKbU11TWpEOFJB?=
 =?utf-8?B?WHBwbEoyMFlxM09USkt2RnJNcEFnN043SVlka0ZJcVVjcGk4Y3JJSjFuMmZm?=
 =?utf-8?B?NkdZbHlzUUNmc3FYUE1KNG5pZC81TmJ1SktQQk04VWFsUnVpZGtkQnpYdFIr?=
 =?utf-8?B?VlFlQWIzOUtxNUNVUS8vVHljRkR1MC8xUVYwY1YydCs1QjFuc2Y2SGluTnlM?=
 =?utf-8?B?QmJ1VEZKTmY4YWpIeTU2U2k2NUlTWGs0WDhCbXFvbWZiWHU4SGFrdEdFSjUz?=
 =?utf-8?B?VTJoTEtKVFpLNFFDZVNPb0tHc3ZXSkRJbXB6TXgrUDVUTGZBc2pFWFN3TDkz?=
 =?utf-8?B?ckVteklZdGs3Z1d3bndTWlF6K2lOdU5KQ0RscHA0R1lkUm0xQU9XRnRsSG1S?=
 =?utf-8?B?Y3NCK3JhcEJsd2ZCVmFRaW0rZWxpbHFUSEhLMXk1MXE3YmhFaUZTZ2hNelA4?=
 =?utf-8?B?dWQydkhJaEVsMEliZmV2eEh4ekx4cmd6UVZpV2luWGtlOXZhdk9MQlNwQXNU?=
 =?utf-8?B?SVdjL3FEeG0rZ0poWmpCbUwydE15T0RCTU40eEJGWXpEVk9kbUxzWTFzOFhV?=
 =?utf-8?B?Zkh5RXVNNld4WFZIRDRuR05VcFh5YnkvSExES1JIQ1JPclkzSnpWR0FxNU9h?=
 =?utf-8?B?cCs4QmdMcmw4RTRzREY4ZitkdGErdFN2NXZGVlZVUDF2U3VWMDVWK2kzZDdY?=
 =?utf-8?B?S0d4YzFPQ3JvWFdyVVBRazdkV0RMOHBxQ1o1aTJ4alJKTGhQN25FOGRBMmpz?=
 =?utf-8?B?RnE1WWUyMUNIc1RnQ2I3ckMxRTI0UUU0dDg3NWhHRE9ESEZnZGJMdUxPWTBJ?=
 =?utf-8?B?TFBpeGdjeDl6elQ3VWo4Z2hseFNKR3BvVU9lWWFJMlVWV2hGWUJ3cU5JdFB0?=
 =?utf-8?B?Z3dpRW5oYVJBdmYrYkIwdVN0V2N1TUFHWVY4NWtxN1AzTW1tWUNiSVhWRmRZ?=
 =?utf-8?B?cTJycG1LQ0RnQ0lzcG1ZbVBwTGhEQUIzV3k5QVU1NllCVFR6WEVwSlFrdTNM?=
 =?utf-8?B?TldxM3JKWEVQSkFRc3MyWVdJTE1naUp4OWlZSHdPRGZKYkFPTFRJdVY4M09C?=
 =?utf-8?B?amVqMDl1eG1xMmlRR3FmMUQ0MmlVUzBDZDA1Z3lnT05WOWhQMzJJUU1HVlZD?=
 =?utf-8?B?L2hTYmdFb1pJbmtRTUNhSWY0YmZ2cmpNUktzTzNmVlNQQjhUcEtTSXQyc2d2?=
 =?utf-8?B?NzNnZXYrUGRmZzZ4aDhYSHo2QTNLTEhoNkRLUjZWNmprY2dXWGNoNjY2dlBm?=
 =?utf-8?B?R3JFakR5TSswYjNGbGZLbDMvWGxTY3ZDRnNaMUtjYkdwYlpjc2ZpRVNxSHFs?=
 =?utf-8?B?Vkx4VjJkeEZWZXF6YmxMOTB4a3RnV1RvY0JOdUx2VDdxTkRpU09DUTlBQ2xj?=
 =?utf-8?B?VVJFNG11QlpKZjlNYnBiYU83RXBFL3JFMy94bXNHTnFVVC9wY1RWYUdrSDZ2?=
 =?utf-8?B?TUtsaDhGc1BPUHp0L2xEeHU1cWc0d3RVS09FOHhzOW5ZMndrdHZSb2JxQmht?=
 =?utf-8?Q?ylFdRL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3pVb2lDR0pmamlNaEY2S3pKalNIL1FxN1FwS3FhaDhZSVp6aUd1OEpaWDEx?=
 =?utf-8?B?eTNTK1NrcTIyV3BzSFpPT290NnlMdnZkVnVMRmdyYnNNQVVyYk8vTlFUN0Z5?=
 =?utf-8?B?OGFPYjVXbmJvK0ZYNHk4THVUMW5NZGxwWmFWTTJPd2NGTWNRK1NTcFZJcnZm?=
 =?utf-8?B?ek9HWWovRjNmaWgwMnVnc2pBc29HMThEV3dOR3FvWkZMRm80dHBLUDNXcGYr?=
 =?utf-8?B?ZWQ0a3NsWFlLc2NVL3JIRWVMOVBLRDAvajZvRDQranRqR2l5ek1vcS9qeXc4?=
 =?utf-8?B?V0QyOEo4V294VGkra0JpL3FGeU85TFJuTmJZRW9odFBSRVdKbGFiM3lYajl1?=
 =?utf-8?B?alhFckRFOWRwaHQ0N0RvcjVMcnoxclNPV1JQdStzVDFWSWp6Q1B5eC9nT2ZR?=
 =?utf-8?B?em1QS0tSeUxKeEVVRUNXcEdKdkxzaVhjMkRKWEJDaXFGUE94Z3EybENPZVJW?=
 =?utf-8?B?VkhKZmZFVitFaStNdHFDVVQwTXkxQnI2UWdVcWs0MEhIWTNqWkErTlhacDQ4?=
 =?utf-8?B?dHZyWGxsVVNWY2RKWHA5UEFPRU1kRGpOQ1BzT3dKL0FQVkowd1o1a3B1R3FR?=
 =?utf-8?B?MWJCMFU3UDVXVGYyc21HclJ5RE13Wk1adUdGb0lURzV5aVJwOVp6LzVtZWlo?=
 =?utf-8?B?S3E3cmhRMmtFbkgyQ3JJU0E1L01jQmFEd0NueVp0K0tZLzd3MjUzQnI4aEd6?=
 =?utf-8?B?c3FMNFFpRGVmWmxiS0pjNkIreGVWVGJ0cG43QVkwcDR5RlNSRU04V3pBVnZD?=
 =?utf-8?B?K2hmQnA4MXdLMjRGNmRPQ1BacEpucHRYZDBldGt6TUpzSURrZUw3TEVIUEMv?=
 =?utf-8?B?RmVDNUJXYXNIS3k2b1pEMFkxYndua05CUTRkd1QzM1d1TnErdWVEZTgrUWdR?=
 =?utf-8?B?NXBWUUxkV3lPQTYvdENQeUNyWTVuOEFENTBjcWdiTVJyRWdPTFNIZXF2R1pH?=
 =?utf-8?B?OUR3cXhSb1ZDUmNaZXA2bzdjMk9LUmVzT3hlaFl2aHpDT3NmOFdFcHN5Mk9z?=
 =?utf-8?B?M1BKVUdlOXNpWGs5S05iK2dKZGEwS0xDOUYxQXBpL2dhN3ZONzNyR3RzZnZF?=
 =?utf-8?B?M21UY0RMekVRYnBlZHNneEt1VTdMei9aU1JLQ3Zpa3I1NiswcXNNYjdEMnJJ?=
 =?utf-8?B?N2tNeFpIVkc2UDIrMzFDZTVBbjJkZ1BlQ3ErbXdnZU1wekZ5dkxFWnBIKzYy?=
 =?utf-8?B?QkJkWWxZTkxvM2ZveVh1c0RvZmdoV0hPOEFOTkNIZlp0T3ZDcUdqalkwbHE0?=
 =?utf-8?B?VWx1bFR2ckFFSlBiMEdNMEhIbmJBTVMzZ1lGTFc4dzNLNlFhTmRFdnRXUDMv?=
 =?utf-8?B?NEtYQmxXU0ZoRTh4aFBNaTREYllybGFQOFBMV1V4M1labzZCQUc2R0NjYjR3?=
 =?utf-8?B?cnVLbTRYeUJDcHBLT3pkTnZlME1VNUtIaXlxMDJ0WnhYZzUrY2tZd3ZkbzRz?=
 =?utf-8?B?am5MLzA5WlNtWkZySDk1RXF4U3NIV2VQdFdaMGFjSlpuaFdjUHpQcjJJSkJK?=
 =?utf-8?B?TTFKQTVCSk10TnNiY0RMNWVtUjg5RVN0ZnhZU2tSR2Zud00zc2VTbVlpcnU3?=
 =?utf-8?B?VlYwZzB5YzZ0bjlQOVpzcVYxMThFVk0vQTlRUXV0ZXh5SHNWODh5NFpxY0hn?=
 =?utf-8?B?Q1ZSRUV5S3NmUUw0UlNBWlg2SHdRTXpsQXlreTlndkVhY2hLckc3THNJRlpt?=
 =?utf-8?B?YytiT24vbndjajdjWU1Yb0lqUE9ycVFvMlhMcERsOGJlSllMRHdtR25RNVdy?=
 =?utf-8?B?cWk2RlBjRUFlMXpaY1hOOHlJajBnTmhlOHNQTjZyOGhGY3lBTjVoT2owVHM2?=
 =?utf-8?B?MzJYY0pETWdyNGVhbGlzQjhkcndQOW84ODZuSFZBS1VZK1RGVTljVDgvUmNt?=
 =?utf-8?B?am9PTEI0NlBnVUlzQzRBYkRWYkF3QUNLb2xNK29KT2Q5UUV2MU14a0t1OGtu?=
 =?utf-8?B?RlZsTXlkanhEb3VhTi9GdGQvYUorT2xaMmJsNWREUVFKaWdEbURNR1VWOUhm?=
 =?utf-8?B?RVNPNEwrV1JHZ1VwcEVVNFQwQ09HS2xVNWE4djI0RmkrS2ZoaFUwRFF0S2s1?=
 =?utf-8?B?Qlh4YWtrMmVwVURSZ2JkLzl0Q09RdGNhNTVWWGI2RkJsY1NOVUx0bThPdXRK?=
 =?utf-8?Q?tTkYPWZpub+SyHtreHGc/rfAz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67919093-e625-40ac-082e-08de0c621200
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 03:14:08.1481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNoL5V43LCOmahwDDK7al4MANMOTiOJal4LIleQYT35fnhl4Uo64Uqd2VYaCnbNZZxe1Lf0vQ8UzdagjYWO5bRG54Ovtj2tLaX7RPL78i/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBpbnRlbF9pb21tdTogRml4
IERNQSBmYWlsdXJlIHdoZW4gZ3Vlc3Qgc3dpdGNoZXMNCj5JT01NVSBkb21haW4NCj4NCj5PbiAy
MDI1LzEwLzE1IDE4OjIwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEtlcm5lbCBhbGxvd3Mg
dXNlciB0byBzd2l0Y2ggSU9NTVUgZG9tYWluLCBlLmcuLCBzd2l0Y2ggYmV0d2VlbiBETUENCj4+
IGFuZCBpZGVudGl0eSBkb21haW4uIFdoZW4gdGhpcyBoYXBwZW4gaW4gSU9NTVUgc2NhbGFibGUg
bW9kZSwgYSBwYXNpZA0KPj4gY2FjaGUgaW52YWxpZGF0aW9uIHJlcXVlc3QgaXMgc2VudCwgdGhp
cyByZXF1ZXN0IGlzIGlnbm9yZWQgYnkgdklPTU1VDQo+PiB3aGljaCBsZWFkcyB0byBkZXZpY2Ug
YmluZGluZyB0byB3cm9uZyBhZGRyZXNzIHNwYWNlLCB0aGVuIERNQSBmYWlscy4NCj4+DQo+PiBU
aGlzIGlzc3VlIGV4aXN0cyBpbiBzY2FsYWJsZSBtb2RlIHdpdGggYm90aCBmaXJzdCBzdGFnZSBh
bmQgc2Vjb25kDQo+PiBzdGFnZSB0cmFuc2xhdGlvbnMsIGJvdGggZW11bGF0ZWQgYW5kIHBhc3N0
aHJvdWdoIGRldmljZXMuDQo+DQo+ZG9lcyBpdCBhZmZlY3QgZW11bGF0ZWQgZGV2aWNlPyBUaGUg
ZG9tYWluIHN3aXRjaGluZyBzaG91bGQgaGF2ZQ0KPklPVExCL1BJT1RMQiBpbnZhbGlkYXRpb24u
IHJpZ2h0PyBUaGVuIHRoZSBlbXVsYXRlZCBkZXZpY2Ugc2hvdWxkDQo+bm90IGJlZW4gYWZmZWN0
ZWQuDQoNClllcywgYmVjYXVzZSB3ZSBtaXNzZWQgYWRkcmVzcyBzcGFjZSBzd2l0Y2ggaW4gdklP
TU1VLCB2dGRfaW9tbXVfdHJhbnNsYXRlIGlzbid0IGNhbGxlZCBldmVuIHdpdGggRE1BIGRvbWFp
bi4NCg0KV2l0aCBhIHZob3N0IGVtdWxhdGVkIG5ldCBjYXJkLCBJIGNhbiBnZXQgYmVsb3cgZXJy
b3IsIGd1ZXN0IGhhbmcuDQoNCnFlbXUtc3lzdGVtLXg4Nl82NDogRmFpbCB0byBsb29rdXAgdGhl
IHRyYW5zbGF0ZWQgYWRkcmVzcyBmZmZmZjAwMA0KcWVtdS1zeXN0ZW0teDg2XzY0OiB1bmFibGUg
dG8gc3RhcnQgdmhvc3QgbmV0OiAxNDogZmFsbGluZyBiYWNrIG9uIHVzZXJzcGFjZSB2aXJ0aW8N
CnFlbXUtc3lzdGVtLXg4Nl82NDogR3Vlc3Qgc2F5cyBpbmRleCA2NTUzNSBpcyBhdmFpbGFibGUN
CnFlbXUtc3lzdGVtLXg4Nl82NDogR3Vlc3QgbW92ZWQgdXNlZCBpbmRleCBmcm9tIDAgdG8gNjU1
MzUNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

