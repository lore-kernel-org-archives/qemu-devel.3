Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E661C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 02:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKNV-0004BT-Kh; Mon, 03 Jun 2024 22:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEKNT-0004BH-4Q
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 22:58:23 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEKNQ-00087m-CQ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 22:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717469901; x=1749005901;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ItuovUkA2RAjLPO0yj63jzwM+kGHG/Cs7KCjUHn6We4=;
 b=CKSR/KYkoMICfQ24pU1LHSUDpk0Fj6WSoo1HBa1zRINb/nQe6JoT7IDl
 meiMX9HtuUsDo5oFZE3AH0Nw25mF3nzJs79R1KT+8X0BJT0PGhGxuf4nk
 VRUu28OpViJuhf5Tnlu6aP0n8UHBuE7RQ0cMR6MxB5Cxuk8+/uidEq7bi
 iUAyln09aKm5E1dS/MFmXcBPixaEDWhg0Z9z/uCUauIXeCh0QLRWMH3FC
 bvl7VnZ+vYAF6x0O+ivEtnJtTcdHV7LowO9etkNU/eOdCDsJHXg18O3Pn
 reiJ9Or/XvDMn2qJOSlzAkJPsUSc9zmnfGJ248HHhDWh52+oA98EegFQl Q==;
X-CSE-ConnectionGUID: W1bk2N8PR42/prTb5zQ9Ag==
X-CSE-MsgGUID: I5Dc3gi3RCyiYWYaCYxwJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14115501"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="14115501"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 19:58:18 -0700
X-CSE-ConnectionGUID: qu/duLWbQZOdioDbYRjbiA==
X-CSE-MsgGUID: 7AKS+JygShuWmUK6CGu13A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="42021488"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 19:58:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 19:58:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 19:58:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 19:58:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 19:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxC1I4NLr/QJN3MKKnsx14W9U0QADV1K4tYhVWJUxjmpVlDeprEu9FC79u7J+AxX1XVOlhE49pwDBvQ/ijaOiQUEG+WomVXUdThWpvU3sLRqGepHedAykXNgWv9bBQ46+RZJXkpIyVbVMSHQUL4WKbC67k+08smK9H7CNmd7/C3mYK3oV+Ai5Q8BgnX2ZpUYvEYbRMkaiznw9IP80CV/9/llqqOhitdCjLZgEyaF0zQMqW7IQdGUgqWhwTs+tk8Ehjk7dXCfrnF0JAfZ+M5ueL5/Uh5FtJnKWDhy9cCpHKb93Ft1xqao3M/5QPacnBfdeULzurdewas3vO8/dLi5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItuovUkA2RAjLPO0yj63jzwM+kGHG/Cs7KCjUHn6We4=;
 b=Ex3Afnq/7yiwhCC/ddZViVsTS0pDnGOiRCEcZ8rWqPKEQBf8SGASbAoKQSw9VJHGBQIqWZjbKW4DwxcDldZIHMnQZj1xMbG15NlkTRiw4YBpVjSn1Hgl3qrFMPzxZ/fI40wChhr3ndvVWPLD0cjTiuMfuuS03qHUlnEzS4J3JQAIGIJM2c1baKipt/xotphmdPRBlueEJ78ibwGzTGY0kgqNc7PxPTUyVqghJhrsQ61SGtM2fi4LUiKQeUKl2JPU3h7cDjNDw4k++4wH6zgLU4bfs7OQL4Qe0w1KJMdHjJqY0PNIMIvPKVdVjUysLTbxj2F9H/nnyRvDVE/HT510mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 02:58:14 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 02:58:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Topic: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Index: AQHatX026AiY+etA/U+I5iKUsGNWX7G16AIAgAEAAYA=
Date: Tue, 4 Jun 2024 02:58:13 +0000
Message-ID: <SJ0PR11MB67441F9E6629728ABBF7655092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-10-zhenzhong.duan@intel.com>
 <e20c3fce-5a5a-4efb-9383-9ed7c9c6ef32@redhat.com>
In-Reply-To: <e20c3fce-5a5a-4efb-9383-9ed7c9c6ef32@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV8PR11MB8486:EE_
x-ms-office365-filtering-correlation-id: 97dc634e-c797-48f7-2377-08dc84422d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|376005|7416005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?SlhGVFk4ZXJrNWJReWJhVzJTWVZmUUhWbklYTjcydWRyQ3lySDl6RzdiQ2o5?=
 =?utf-8?B?UHMwVGZrNDFLUjVnZEVnK0JVUFdZUHE5d3JWSGJUcjFIZjdLNHZ4Rjk0QVZI?=
 =?utf-8?B?S2lUSVhOUUh6SUw3WitDSHYxY1FLQzdwMGVOUko3d1lFSGRJeWwycURGL2lj?=
 =?utf-8?B?KzczR0gvMnhOaU1FSWF6Q0ErT1B2VGZWcmpWb1dCUmQrZE1ZVFF5SWJlczF2?=
 =?utf-8?B?UC90UDZFS0ZOVHNPa3JoL2tlU3lPeXlQUWhUMFFvQ3ZLR3o2M3NsMzZmcUN3?=
 =?utf-8?B?MnpGOFBkMG9NS0Z4Y0xoNnBRYXBheVhQbk5HWGFjdkFpSFA4OU1sazRDT3Zm?=
 =?utf-8?B?Z0dBK3orVUxxQktmY1FCeDZ5MjBSZk9iRUV5MFExWmNTTmVGY0ZHT3J6WUZ3?=
 =?utf-8?B?RUNmS3dDY1hZaVF4UGVoREV1ZmhrKzh2U2tjRlRMNDBjWjI2d3haUFcrUG1u?=
 =?utf-8?B?VnFnYng2NU5zcE9MenNIUjZKMFZDTjdKQitjWEl3YnBZaWdld1FsWE9ETFhX?=
 =?utf-8?B?RjRFVlRTWm0wUFB2d0Nud2x4eDZMZXJoa09vMFBoLzhXWm5KTkNQMFo4RGRV?=
 =?utf-8?B?NGQvREVwTWFTOExuMER4czlzcU5jNjZldWxwaGhRaXRpTk5LVmdVZU1PajNK?=
 =?utf-8?B?TFlTa3UxYnNuUDhybFRvZyt1MEFUVUtzT1Fkc28vMXY2UW9tTjN1YjU1MTM0?=
 =?utf-8?B?eTkxZUx2c3d5TmxHQzBBbnFJZ1BXSTJtNEw1UktuZXlRSjk1UzlkYmxtLzBo?=
 =?utf-8?B?SlJISWI3RzVOeW16ZDhONnBIVVRQT05lSnhrZEtKMWN2TWpPemd6VzE3MElC?=
 =?utf-8?B?S3VxbFRUcWlRcEkzZjAraC9mOW5lTTNXbTkrZzFSWXpkU0g3MWtoa3dHOW9i?=
 =?utf-8?B?Rm85bk5jOFBOODcwcXE1WTc2RTdQVzBNWXF4TFhranVHR2ZOd0VNbjhwZG1H?=
 =?utf-8?B?eGVXSUJjZzFNMU5YVjhLbE94b3lVcVZLOTVHSnlvR21qUk01ei96RVhTTHFq?=
 =?utf-8?B?L1pibVlYRXZ0RE5ua2lRd0RsSy9TdHpUaDJVckxid05wZzhRTis2R2NjWFNi?=
 =?utf-8?B?UExjUTFuMXFlTDlzcW5zZDNob3NGejlUekROTVU1dnlzT0E2N1BzZWtUNjBK?=
 =?utf-8?B?bHpjUUl0TkRZZkpzYWF3aGZNK3BRMThaYjVuR1JJd2Nyb2pQV2FzdUxOUGFv?=
 =?utf-8?B?UzRhSHc2L3BDNktwVFNINXNLajJMM0c5N3JYY3R3TWQ0VDhJL01OSUxuN2Zm?=
 =?utf-8?B?RTRzRlE0OC81M3R4S0kyNTRGUkJ5TUg2Yms3TmJRcThsa2JMa2poTXFBZGU2?=
 =?utf-8?B?UkNTMmVSbm4zQ2N2NkZYRGhDT212NGZKUlNlVVFTU1JXQ1lHL2ZULzBNeUg3?=
 =?utf-8?B?cU1DaTc5cDdkRFNLamhjQ21iK1dSTnRERnZOamZIMEZoY29WaU5qYUhYSnlK?=
 =?utf-8?B?dmhHM1pubW9Ma0ppdzExdDB5ZFhRU05ESU5aS0hSVDlLdzI3ak5DY3ZaT0to?=
 =?utf-8?B?QmZEanFMVFJsMWlRZzdzYVZlVXJxRk94NkRzMVk4UWxUR1VWUEtFZTBPR1pn?=
 =?utf-8?B?RzZwaE5MWHI4WlBPNXpZRUphRGlVVEpzeHM0bUczcHROQTNRTmdzWWM3ZnFl?=
 =?utf-8?B?TjdzMVhPY2ZOQ00xYis5cHk3MmpQeUNoMldCMnNZMk5xUGI1REhabGxrYk11?=
 =?utf-8?B?eDRmTVp6SWIraDc4RGZIVzIzR25ZZEdxREE0a3MzMlhMS3N4Tys5bk9NZ1BR?=
 =?utf-8?B?bmRpaDRDc1JRSUVWM3kzZ0NhTVVjVVd4TWwvU2tlV3h3U1lBQm56ZEEvdEhP?=
 =?utf-8?B?bXZ6L0ZwNjRpRWdiVGlEdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVpjaFhkMDhmUVJTSjdUTHVTRkR1d3Fwd2Z3TlJoTHVIOVVDajFQSndnZWxa?=
 =?utf-8?B?NGQ5TE9rb2ZxL1M0cEtCdktLZlYwbzdTZmZHb3I1TTkySXk3YUM2anVmQVhP?=
 =?utf-8?B?SGdlUm9vandxSTM4MWZBeEVrT3dyZDcyb0cxOFM3NEFJbWdTUDZYUkdaT2da?=
 =?utf-8?B?aHZjc1NGTytOdDNaOFN1R1ZrZXRYcmtKdkhySGNta1BleVkrS0pQaHBIK1NV?=
 =?utf-8?B?dURRNkwzMCtzZ0Z2enk1U3ZTY09jUndEa2gxUWZERUw5cGk5MEZLQW40dGdY?=
 =?utf-8?B?WVB5MGFhNDBmdUdjNlhaR2gzWUdka05wM3JRNVNtSFgyZTAwQjlPei9IRDlI?=
 =?utf-8?B?TjZ5MmVUTWd5d1RRSkNzTzVxT2tac0xEeEIyYTVVS0hUZjNBd1ArK1VPei9B?=
 =?utf-8?B?ZkI4cm5kZEFWVUo0ZVFPTmw3ZjhPQzB6YWdyUWc2ejRFSEpVL1Y0V3UyVzl6?=
 =?utf-8?B?K0piSE9sVUo5S1JaTHY4em9NcVlHU2xyN1NpZVlOV0oxVlhHWWM0TjdNakc1?=
 =?utf-8?B?eXRoUTdBelJSR3lZOXprTWpBSUJTWGQ4bFhFZ0R2eUpsK09wdFBUQ1Z6WmpJ?=
 =?utf-8?B?UjJ5eWtkOXlMYVdkbzZyb3N2VUVCTW5HeWUrUUEyVitQTG45djRmcDRwUkNt?=
 =?utf-8?B?N3BZc2drNG1uVzhnbUJPM1dNOVY4aE1xUDNPZXpGcnhLcnNsQWFEdlpmNXJa?=
 =?utf-8?B?V2UzeFFkVzNISXRhalRWdnJ3dS94L3JuQ09JWXFCUG44K0pMcEhEN0g3RmRp?=
 =?utf-8?B?d2xmVWxNQmJqR2ZhNEowZzNSQm9qWXJiaFpyM0h4VGoxbmNsUnJ5dmxZQTF0?=
 =?utf-8?B?MUV2OWZOMmtUWHhqVXFPUy8xSVhOUVJRWGlBdTJPaWJnMXZCNncrU3ZTWEdz?=
 =?utf-8?B?TFIwWkRWdjJGdmZvNXVNdEczQU9NcU9jTzJoWHdvSytXaHdUT1Y4bU81REZq?=
 =?utf-8?B?Sk0zTU1mYzRPbCtaY0ZOQVFhV1dPbTJnZVUwVzI3aEFvYUpiK0NWczRFRVhU?=
 =?utf-8?B?QTk1VGRGeU5LMVpQK0JsVnh3RklkTk1ac2VIbzBDYVZUa0FoOGJZTG1lMUVt?=
 =?utf-8?B?cjczTW51eEx5OVZnM25ZNGtza3cvUHRvd3JZeDRwUUowU0RoeUd0VUh0d2oy?=
 =?utf-8?B?THEyd2pNbm05NkFHN0xVbkpGUk5jQUxiNzNDVzNvcDBqYmlZcWJLai9qeXBZ?=
 =?utf-8?B?OHNPRytpenFvY0VBeGo2dm1sZmRmdGxPMTVuWkJVdlhWZjdWQTRpWXdIWU5Y?=
 =?utf-8?B?aldqR1RRWktXMjBRTFdTN1lVUlo2a0F4ZHVGVDNqMjZwSEJzdkpZS0xndWo0?=
 =?utf-8?B?cW5ETHB5TzdQTzc1eFNmSWZlWFNMelFlclRBbmM0cFo5NmgwaDZzOHJwdnVZ?=
 =?utf-8?B?bEJrbjl5M1NQSStTNVc0YmEyeTl5c1RpOVY1RU0wOCszc05NbXZ4aWV6b1BW?=
 =?utf-8?B?WmE2aXNieFh6WHM4SUorU0ttTGxCdUpzNlhvajZGNG5mNmhCM0dyL1ZBV1Jm?=
 =?utf-8?B?REtsUUhTOXZmVTJqVTRGbmRkQk5TZjJ6R1JRTHIrTjJzZTNqVG9HcVhCYThZ?=
 =?utf-8?B?VTVrbzBaMDZaUStaSWE3c1F5WmxjNWs1STZUeUEveDlEN0oxcjBDNWlXa09x?=
 =?utf-8?B?QXEvUHFlOWlDQnBpYzd0Z3lRb0drdXRBaHN4OTMyZEZVTHp4b09ac3dlVVph?=
 =?utf-8?B?K0tTb1oyRjZaOW5OZGRoNG9pNzd4MDh4UG9GeG9XZGdoYVZVcmdxU2lkSUJY?=
 =?utf-8?B?NVJrNUlJTDBXcVlITW4xNDhkbkRTSHltazRhbEJBbVhBclA1MzBRTGx4NitQ?=
 =?utf-8?B?dGdxdjR1ZG5SYmhXcTFrMlJLMFk0NWNFRmRlM0s2TzZvSFNId29tUkg3RU9S?=
 =?utf-8?B?d0pVQklaV3p3M0VYcFpIeWNEUW9CY2U0K1VEazJBUEgwcWVoZ2NUTHorTmdU?=
 =?utf-8?B?TlE0SnpGT2FndkRXZ2lRY3JJUG92dTNNdGxCcnZqUWxmRlp5bzgxRWluZjBj?=
 =?utf-8?B?dEhTL2t1c0w2M29kbVRwMmVJZHM1d2s2dWY4cThJcHVUdTV0ZWd0V3JMUDBN?=
 =?utf-8?B?UWNWcm1MR0daRmpQa3Z6dnRQVUQwdkswdmFOZkQzK0ovUW9SeTlacEwvZ1di?=
 =?utf-8?Q?P9jK3UHWlh/qWSji2e0GR6Gvv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dc634e-c797-48f7-2377-08dc84422d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 02:58:13.9219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vN1O9PpZLDFYH/zrD4qjvNW4JQE04Tyzt1ZXYEZpgWwv2Zl5x9nBDIczZt8Iv8xjWDAKPs7QjSSOvZGdZbhYAyPxvr3iArlRs3e8TyUhy8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDA5LzE5XSB2ZmlvL2lv
bW11ZmQ6IEltcGxlbWVudA0KPkhvc3RJT01NVURldmljZUNsYXNzOjpyZWFsaXplKCkgaGFuZGxl
cg0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiA2LzMvMjQgMDg6MTAsIFpoZW56aG9uZyBEdWFu
IHdyb3RlOg0KPj4gSXQgY2FsbHMgaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbygpIHRv
IGdldCBob3N0IElPTU1VDQo+PiByZWxhdGVkIGluZm9ybWF0aW9uIGFuZCB0cmFuc2xhdGUgaXQg
aW50byBIb3N0SU9NTVVEZXZpY2VDYXBzDQo+PiBmb3IgcXVlcnkgd2l0aCAuZ2V0X2NhcCgpLg0K
Pj4NCj4+IEludHJvZHVjZSBtYWNybyBWVERfTUdBV19GUk9NX0NBUCB0byBnZXQgTUdBVyB3aGlj
aCBlcXVhbHMgdG8NCj4+IChhd19iaXRzIC0gMSkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhl
bnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGluY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgIDEgKw0KPj4gIGh3L3ZmaW8vaW9tbXVmZC5jICAg
ICAgICAgICAgIHwgMzcNCj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4g
IDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPmIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmgNCj4+IGluZGV4IDdmYTBhNjk1YzguLjdkNjk0YjA4MTMgMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2lu
dGVsX2lvbW11LmgNCj4+IEBAIC00Nyw2ICs0Nyw3IEBAIE9CSkVDVF9ERUNMQVJFX1NJTVBMRV9U
WVBFKEludGVsSU9NTVVTdGF0ZSwNCj5JTlRFTF9JT01NVV9ERVZJQ0UpDQo+PiAgI2RlZmluZSBW
VERfSE9TVF9BV180OEJJVCAgICAgICAgICAgNDgNCj4+ICAjZGVmaW5lIFZURF9IT1NUX0FERFJF
U1NfV0lEVEggICAgICBWVERfSE9TVF9BV18zOUJJVA0KPj4gICNkZWZpbmUgVlREX0hBV19NQVNL
KGF3KSAgICAgICAgICAgICgoMVVMTCA8PCAoYXcpKSAtIDEpDQo+PiArI2RlZmluZSBWVERfTUdB
V19GUk9NX0NBUChjYXApICAgICAgKChjYXAgPj4gMTYpICYgMHgzZlVMTCkNCj4+DQo+PiAgI2Rl
ZmluZSBETUFSX1JFUE9SVF9GX0lOVFIgICAgICAgICAgKDEpDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IGluZGV4IGU0YTUwN2Q1
NWMuLjlkMmU5NWUyMGUgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4gKysr
IGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IEBAIC0yNSw2ICsyNSw3IEBADQo+PiAgI2luY2x1ZGUg
InFlbXUvY3V0aWxzLmgiDQo+PiAgI2luY2x1ZGUgInFlbXUvY2hhcmRldl9vcGVuLmgiDQo+PiAg
I2luY2x1ZGUgInBjaS5oIg0KPj4gKyNpbmNsdWRlICJody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmgiDQo+Pg0KPj4gIHN0YXRpYyBpbnQgaW9tbXVmZF9jZGV2X21hcChjb25zdCBWRklPQ29u
dGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj5od2FkZHIgaW92YSwNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmFtX2FkZHJfdCBzaXplLCB2b2lkICp2YWRkciwgYm9vbCByZWFkb25s
eSkNCj4+IEBAIC02MTksNiArNjIwLDQxIEBAIHN0YXRpYyB2b2lkDQo+dmZpb19pb21tdV9pb21t
dWZkX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPj4gICAgICB2
aW9jLT5wY2lfaG90X3Jlc2V0ID0gaW9tbXVmZF9jZGV2X3BjaV9ob3RfcmVzZXQ7DQo+PiAgfTsN
Cj4+DQo+PiArc3RhdGljIGJvb2wgaGlvZF9pb21tdWZkX3ZmaW9fcmVhbGl6ZShIb3N0SU9NTVVE
ZXZpY2UgKmhpb2QsIHZvaWQNCj4qb3BhcXVlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgVkZJT0RldmljZSAq
dmRldiA9IG9wYXF1ZTsNCj4+ICsgICAgSG9zdElPTU1VRGV2aWNlQ2FwcyAqY2FwcyA9ICZoaW9k
LT5jYXBzOw0KPj4gKyAgICBlbnVtIGlvbW11X2h3X2luZm9fdHlwZSB0eXBlOw0KPj4gKyAgICB1
bmlvbiB7DQo+PiArICAgICAgICBzdHJ1Y3QgaW9tbXVfaHdfaW5mb192dGQgdnRkOw0KPj4gKyAg
ICB9IGRhdGE7DQo+PiArDQo+PiArICAgIGlmICghaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2Vf
aW5mbyh2ZGV2LT5pb21tdWZkLCB2ZGV2LT5kZXZpZCwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZ0eXBlLCAmZGF0YSwgc2l6ZW9mKGRhdGEpLCBlcnJwKSkg
ew0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGNh
cHMtPnR5cGUgPSB0eXBlOw0KPj4gKw0KPj4gKyAgICBzd2l0Y2ggKHR5cGUpIHsNCj4+ICsgICAg
Y2FzZSBJT01NVV9IV19JTkZPX1RZUEVfSU5URUxfVlREOg0KPj4gKyAgICAgICAgY2Fwcy0+YXdf
Yml0cyA9IFZURF9NR0FXX0ZST01fQ0FQKGRhdGEudnRkLmNhcF9yZWcpICsgMTsNCj5QbGVhc2Ug
Y2FuIHlvdSByZW1pbmQgbWUgb2Ygd2h5IHlvdSBjYW4ndCByZXVzZSB0aGUgaW92YV9yYW5nZXMg
bWV0aG9kLg0KPmlzbid0IGl0IGdlbmVyaWMgZW5vdWdoPw0KDQpZZXMsIGlvdmFfcmFuZ2VzIG1l
dGhvZCBpcyBvbmx5IGZvciBpb3ZhX3Jhbmdlcywgd2Ugd2FudCB0byBtYWtlDQpIb3N0SU9NTVVE
ZXZpY2UuZ2V0X2NhcCgpIGEgY29tbW9uIGludGVyZmFjZS4NCg0KV2hlbiB3ZSB3YW50IHRvIHBh
c3MgaW92YV9yYW5nZXMsIHdlIGNhbiBhZGQgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0lPVkFfUkFO
R0VTDQphbmQgSG9zdElPTU1VRGV2aWNlLmlvdmFfcmFuZ2VzLg0KDQo+PiArICAgICAgICBicmVh
azsNCj4+ICsgICAgY2FzZSBJT01NVV9IV19JTkZPX1RZUEVfTk9ORToNCj5zbyB3aGF0IGFib3V0
IG90aGVyIHR5cGVzPw0KDQpUaGVyZSBpcyBubyBvdGhlciB0eXBlcyBmb3Igbm93LiBXaGVuIHRo
ZXJlIGlzLCB3ZSBjYW4gZWFzaWx5IGFkZCB0aGUgY29kZToNCg0KY2FzZSBJT01NVV9IV19JTkZP
X1RZUEVfQVJNX1NNTVU6DQogICAgY2Fwcy0+YXdfYml0cyA9IHh4eDsNCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg0KPg0KPkVyaWMNCj4+ICsgICAgICAgIGJyZWFrOw0KPj4gKyAgICB9DQo+PiArDQo+
PiArICAgIHJldHVybiB0cnVlOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBoaW9kX2lv
bW11ZmRfdmZpb19jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkNCj4+ICt7
DQo+PiArICAgIEhvc3RJT01NVURldmljZUNsYXNzICpoaW9kYyA9IEhPU1RfSU9NTVVfREVWSUNF
X0NMQVNTKG9jKTsNCj4+ICsNCj4+ICsgICAgaGlvZGMtPnJlYWxpemUgPSBoaW9kX2lvbW11ZmRf
dmZpb19yZWFsaXplOw0KPj4gK307DQo+PiArDQo+PiAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIHR5
cGVzW10gPSB7DQo+PiAgICAgIHsNCj4+ICAgICAgICAgIC5uYW1lID0gVFlQRV9WRklPX0lPTU1V
X0lPTU1VRkQsDQo+PiBAQCAtNjI3LDYgKzY2Myw3IEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyB0
eXBlc1tdID0gew0KPj4gICAgICB9LCB7DQo+PiAgICAgICAgICAubmFtZSA9IFRZUEVfSE9TVF9J
T01NVV9ERVZJQ0VfSU9NTVVGRF9WRklPLA0KPj4gICAgICAgICAgLnBhcmVudCA9IFRZUEVfSE9T
VF9JT01NVV9ERVZJQ0VfSU9NTVVGRCwNCj4+ICsgICAgICAgIC5jbGFzc19pbml0ID0gaGlvZF9p
b21tdWZkX3ZmaW9fY2xhc3NfaW5pdCwNCj4+ICAgICAgfQ0KPj4gIH07DQo+Pg0KDQo=

