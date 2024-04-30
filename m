Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F946C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kGY-0006o7-4W; Tue, 30 Apr 2024 05:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kGV-0006nD-Ej
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:59:11 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kGT-0000Td-9Q
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714471149; x=1746007149;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DgeXf01USQyxoGC3xOtWGJzlRZnSFq/JDxP5Ile0aSk=;
 b=m0MZtEua9joEjJ9eWjvC0hUzM9HC8qO571byX7OACxN+iiCIFDL6+QNQ
 Jfzt69iDN0ug+tsW8Zi/HYsp8hgxE6bZ575vn3ALSwcMgACo0eYNSz/vh
 DJmlGxsM9FPbdvIoxcLk1fnF6AZqT2Y+NsB1ode6GAoPNBk9sOsjp1vtw
 F7gT78uaAPPVlAtYd0kvErE7X3uT6MnEcU9Vyt1JErYAJpH5BdPHQNoRK
 z59VRh0H5qpVepJaCPlQAWvMJkxAWPPcVQDIKIVFJuNssKuPMsETd8Ha2
 Gwn6ROx27GXRjjQGc9BG+dif6yYdWJDAreCxN0/uIwJDin4y7ZGSYxMHl w==;
X-CSE-ConnectionGUID: dc1HgKnqSpaJnuKlJrEmgw==
X-CSE-MsgGUID: OEudnx3pTYiWhQII3qTyog==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10327467"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="10327467"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 02:59:06 -0700
X-CSE-ConnectionGUID: MoFIZPvoTKazsmAPSWhHfw==
X-CSE-MsgGUID: Oa2QAz4xTL6gdFgm5txDtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="63890866"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Apr 2024 02:59:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:59:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:59:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 02:59:05 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 02:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig93a/ajqWI+2tTSd8a3qtUWqP/NyTQeF3cNO8m9Fx6zys36Sa91q3xLXO0zirImOHbA6awnUtsURLLAPUR3nYTzmlohcvPvXRsEMK1sUhOVJ/SPD/qXOq0/3twYdly+fVUEkBnHrIzOfq0oBA8rmRAPesJsgLV8zWcr0t+M0SlfJO92SUuyAZqD0vjjssYdIJd8QxEa6wQKfSRJDNmq0lz6SQKygEPgIzsPMpoc2SumpY1AGuFdc5EYmjAceWZ/Qygq6eX1cZldF0Hx2FLWYvpeQy/BxjN5itdmPerBzT32VWAMeGPpJELvd90Tks2VdY/VOYt7wt0aBE586nNMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgeXf01USQyxoGC3xOtWGJzlRZnSFq/JDxP5Ile0aSk=;
 b=gXceOCMIsKW/+MFiPiR/JHJzOT3mKuG3XPEl6uO321fEjrc3+BhRX29waLoWlrAiW5vXospjx0khlAjb+5Pk+as1WnvPHxs6QIE+pdn+u7cFUMnOekwjdhxPM7ZJkAA5z9gt50xLR7gHcILKKG9Jn6SXgvkLdGWDdzMdJejl0gifvd8anglCFsQydjdZf+gvXXQzoGTaPkorNrKuKGdiCbqhsmnPZZXwN6BE6AT3tgpj/UfGGqyrszzrrBgoqk3bYbawtgBHTe8hg7UBUe+XbWw6OMEDS4z+R3fXeOPQgT1LpOdYHqn254phWWj7B+tjam81dALh1E6WRqEnetCrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CYYPR11MB8387.namprd11.prod.outlook.com (2603:10b6:930:c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 09:59:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 09:59:02 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Topic: [PATCH v3 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Index: AQHamgIaYPclSBQv1EucbqMZQWxTVrGAkReAgAAEtKA=
Date: Tue, 30 Apr 2024 09:59:02 +0000
Message-ID: <SJ0PR11MB6744798B7E58DFCB6D962C54921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-8-zhenzhong.duan@intel.com>
 <6a24df9b-9851-4304-b962-a98a65758a00@redhat.com>
In-Reply-To: <6a24df9b-9851-4304-b962-a98a65758a00@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CYYPR11MB8387:EE_
x-ms-office365-filtering-correlation-id: 6d9923e6-f41f-4137-26de-08dc68fc2a18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|7416005|376005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?NjdHRC9VKzlTaGYxcVRmOG5aeFhaamxSRldNWHdDVHp3S2lKbVZhMk1RU0k3?=
 =?utf-8?B?OEtFOFNMZHZVRlZ4TEpGYXpZeVZjOU10MVlHaG9YZ2JZbUlVU1RDZTJQZjJR?=
 =?utf-8?B?NjMvWjhuZFY0Q0hya2dSTy9ZYzRYYWhTUjBrV3pwbFUyMmE2bTJiWWpYT3hH?=
 =?utf-8?B?RnVLQm4yK3BEUERDbEl5a0o4TXZqdzFRelI4Q2hyYUJPektWZmx4bDhPdFpV?=
 =?utf-8?B?cU1jMCtjRzY0Z1VOVHBvWXdhY3BSQnY1UFVxYzZnMmdiZmNxQWpzMHpNT1Vt?=
 =?utf-8?B?VWk3THNCb1lldGdZWGpGbTk2b1hmWFptbnhBTy95d1B0VUZLOUlGTFdYU3F3?=
 =?utf-8?B?T3FxRXV5ODdnZ1VnaDQza2NvbjRqV0h2bW9OVVVLZjkySnVFMDY5WThkRU4w?=
 =?utf-8?B?cnlqVDhQWXB2VDZFbWgvOVoxcGZWTmZtbG1xclV6SjlhNXlMeTZaRGZvenIv?=
 =?utf-8?B?MVpPbWI0NXNkdkxKZm1IQjBVZXd1ZmlWQXlxcU9HTnZjTXMrZmtUcGhFZEJL?=
 =?utf-8?B?ekd0SGkrdGN4dFIwTm0rTmVZQ1Qrbkt1RlpsTGVkZmk5MDZ6NW1mR2VlWnZr?=
 =?utf-8?B?MVhhRytiUS9rMmcwNm5WaVVGS3c5eTZPbU84TG1aUmVoM2lVU0ZQMzB5VTBY?=
 =?utf-8?B?WC9RV01oMERqc2xmcWlTMWhyUjRzeDFNMFhtVzBkS00yZlNGbXpnNnBDMHBh?=
 =?utf-8?B?YXcwTTZ0cFU5bWFyZllNcjhWRmpuN1A1bUlFeDlSVEYrNTVjSDRwek1sc1Vh?=
 =?utf-8?B?MlpML2d1ai81VGVGU2FSMllTZWpZZW1EUDRiVkM1YWdaY1dlVlJBWDN0TjV4?=
 =?utf-8?B?Y090WXNlRTRXREJEZHpReUlSL28wTEZTUWR0c0RqYkNPTlZVeEpucUlmM2pC?=
 =?utf-8?B?aytvTzh5cFN5OHlzSlRqU1pGU3RPVHVrN1VKOFJtdlRlcHBqSmhSSmRRekN3?=
 =?utf-8?B?UWlIOEJhQWhxRVBNQ1RrdXZQaUE4R2V0QlVFbGU5RDNMcXZZbXY1VUxLYXhT?=
 =?utf-8?B?S2xBdzVBM2pZRVllZkpmOXJGTU9RUE1MdklETWZlZnBtUHBPZEZnZlNnRGRk?=
 =?utf-8?B?SHJPUnNtWXdpT3dFeVQ1MlRYeE03bnpBQmRsUHFmQnZqWGo0K1d6T0VGUjZl?=
 =?utf-8?B?dzYydDUxaEo0SDFNS0crRjdwcFVGMUpXdWxtcU5qTzFNNlk0dEFralc1WVBT?=
 =?utf-8?B?RGRKSU1oWXJGc09nV05UdWh5MlA3Znlva2tIN2FhVzUva0ZWUFUyaG80aWM4?=
 =?utf-8?B?amswMExKbjJPRndBUTNnVS9MdGdqOGlVNnF6a1R3L2thYytuRENuTjdiUlZw?=
 =?utf-8?B?a3h6WkZQNlRZakdPY1BpRjF0bHYwT1ZnMHUyZjRtcmd1aW53b2lKTDN1R2hl?=
 =?utf-8?B?TVRpc1ZFYWp1ZG9wVk5zOFZHbVVuVXBBWXoxa1Q5cGtzVW1GbDY5WHp4WFR1?=
 =?utf-8?B?Z21jRXAyaGU3VFU1VmFrWXdBOWxuQ0VTbEQybUlqM2tiTmtlekZFS2NKdGlU?=
 =?utf-8?B?UURsVkhXSFY3amxFQ0hrME1oZUpFL0p3L2srSitMWUM4NE1EaDhMUHR6bkpo?=
 =?utf-8?B?eVBuS2VxUWF1QkJSdkpaMnRiMGdpMTMvUVU2d0lFaVJtblVxOXRxclhZbmVD?=
 =?utf-8?B?ZE0yUVdTcGRUNWRsM0pMTVBpSUs3eDR3KzlJMXo2b1dwWkpmRjQvL3QwNVM2?=
 =?utf-8?B?Yzk5dkNML0ZodnB4eVZHWk9RME96Tys0bGtKM0l5K003VEdacEdxL1djcC9F?=
 =?utf-8?B?WnhHWk5UaU00eXl0amU3QWx1VFFRNVVqc2JpbnJpQmtYenI1ak1qbHpreEJh?=
 =?utf-8?B?WTEwOFRqbFdFR2d2Q1BwZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmJwenBjc2hxVmsrRFpSOU1sYWtISVRQdW84NkFRVjI2eExTbzQyTkZyd1hh?=
 =?utf-8?B?SlhRMGJzdlhMek1sRnVQSEtYckp0MXlKTTAwejRNUlVkc0hVU1pUdXVIdkMr?=
 =?utf-8?B?bXZNVldBbWkvUWVFVnV0eHVaaXhUQkgvQ2ZQRTUrMEFqZlQrbDF6NHhwZWNn?=
 =?utf-8?B?RWlQcVNZTWViMzRLdzBPLytsajBpakxneEVPYlhKTFZmTEp2blZMZUtSRkt1?=
 =?utf-8?B?dnE2ZVFPdEZaZE1vV0RNS0lSUGluaWVPYUZOUlZ2TFo5a25aL3Zmc1JJSE5F?=
 =?utf-8?B?b2JGRHYwRDBhU3NRYjl5OFJjN0NKYVV2dTRHVmZlQXFQMEpzaXlGbnlCYjhX?=
 =?utf-8?B?UlBicmFBZTA5THQvaHhERFkvTHNIRlltNlVEdFVEUHVUcXFISElmdko0WmFn?=
 =?utf-8?B?SWF5QmlUR1N3dTgxUzRWUVROR0dEcE9GRE0rVVd3MlpiSlp1K1BMbTJTMGQw?=
 =?utf-8?B?bGVGN2JqTGhZcVJtYU5XR29zOUVCdi85RGJLeFJZVmhHUktVeHpmQWJValZN?=
 =?utf-8?B?OG5laXlScXNOMDh2bkFkTDZLMmVEWUJ3MStYWkVLeE90ajJuNEJTVTNLdDZU?=
 =?utf-8?B?M0p1azRETmpLM01JM1R4cGNqbnN1T1RnK1hMOXlDclBJbStWdStuVFZBWTNW?=
 =?utf-8?B?dDY0MFQzcHplMHYwMzZFQm0xdVNYQzlJbDNwNHhMWkJ5YzlzcE9ReEVQTjY0?=
 =?utf-8?B?aVdoMkVaVTNQU3ZQOHVaRlF4WEtjMnlvaW4vU2RHWnNabVJmb2swcG96Skk2?=
 =?utf-8?B?blE3ZkpBTTU2NXZtbXBMc1ZMU3RybWZGTlVadFI4bFJuMHI3SkN6aHJPQVM1?=
 =?utf-8?B?THVWWXU3WG00M0VDditROXgxem9hYVBaVUR3WmZoM3RhdTZybmttSjRMMHN2?=
 =?utf-8?B?K0ltVVV5NjZQeVVtS1ZmQXhOUnkvTTdrYzBYL1huUSs2M1FUVEJyYXQvazVm?=
 =?utf-8?B?Q3RhY3RLdi8zUnF1MHNVc043cVE1dUhXVGVHZ3lSNWwrV0p5dTg4cDl5OFFi?=
 =?utf-8?B?cUYvdFZuRGZ4NnFVVTlUK0ZaYkJOa1RSSUNqK3BKVDBYTzZaWEtoSVgrZUNR?=
 =?utf-8?B?SHZmR3cxTEV5N0dRUkRnNWRkRW1QOW10K0FtdTRqME5YOEJEdXREb3FTUTFT?=
 =?utf-8?B?dG83K2hlMGJ0SDNZdGJkbzlESUMzYTJhUmVUMnQ5Q1BEL0o1Z0V4czMyOUxQ?=
 =?utf-8?B?ai9FUjhGYlF4R1gvNndlY2VMaUEwYXJhaFAxb0dGTE5hTFBqOHBJVVg0S2lF?=
 =?utf-8?B?S1J1QWZyUGVGRnJBVm82SjlKTG9zcDF4WENSQzlvR2dDOHFrNHUxL2twS21S?=
 =?utf-8?B?cmMrdGlpNHNzM0pJYjJPdnk1eDFLRldhSDlpWFQvNHpvZGdlam1udVJMR0lG?=
 =?utf-8?B?U1Q3SHBkUWdBa1hKSDhXUXVobzhPZENEVTRaWGlMZVVseHRvWVV0Tkxjdk1i?=
 =?utf-8?B?Nkp3RnB3ZXRwRFZiZXdlei9YSXROMlZTQmJweG5CTlJXZitPcXVYVk5odmRC?=
 =?utf-8?B?elJBd21DNWtPYjlRT0p0S3prVlAxVDd5Vk5malNSeG0rN1Btd1hlNCtJMFZ0?=
 =?utf-8?B?d0JKa3ViUjYrVXgwcDhSSTBYMm00UHdETVhGbkNycGdpdHQ1SzIyYjJvckdz?=
 =?utf-8?B?ci9TVmxRRndWSHcvck11Q2s2dUlsMGVjd1pBRnZUZHJQZ2xNejNpcEF2UlNr?=
 =?utf-8?B?U1V5S2lvaXNqZjJvSUJBR1I3M283cjRiWk5McGlFbE5BdEZqazlVM1Q0cTFZ?=
 =?utf-8?B?MWx6Y1ZUaWdpRVlVTjBYenAxRFlIb2FPcHZHWVphb2RwSUFLOU1wRW12WXNR?=
 =?utf-8?B?Z3JEOHhPUTQ5ZE0zNHl4QU5hZGl3d3huM0ZHN1o3cjNQblYwa2VzN1NpcDJZ?=
 =?utf-8?B?YkFJeWMyeTU1MXBNTzkxaWpYYzZNVElvOFlXc1h0aVN2UDUrSkRSUU5ESlZH?=
 =?utf-8?B?dkVlenRkVXpJVFg4WjJsUUdzN0wwdWJvWHY0dDVHTjdIVlB4RDUyUThKZmRV?=
 =?utf-8?B?MXo5Wno4Y3ZYMDRJTFdWZUJPUHEyZXJveW0raHdlVFlUWHZRcnJiS05WQ2tZ?=
 =?utf-8?B?K1hEejVkUkVJakNoQU8rZ2RBU2JiVnpYTDFLUklLVzE5Mmxvb2Z1aWNEQzlY?=
 =?utf-8?Q?mLT27XG/Ilvw3CbnLe6VEr/hF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9923e6-f41f-4137-26de-08dc68fc2a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 09:59:02.6968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0/zKD0u/SvK7aanpyXjIUjUea/juTqI37R36OJKBHlxvUbxy9JlvC2fx0TpwhbZ2A6PFJUjMKb0uOf5w++fNwWC2UwXl7R6NKQXer2aAaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8387
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA3LzE5XSB2ZmlvL2Nv
bnRhaW5lcjogSW1wbGVtZW50DQo+SG9zdElPTU1VRGV2aWNlQ2xhc3M6OnJlYWxpemUoKSBoYW5k
bGVyDQo+DQo+T24gNC8yOS8yNCAwODo1MCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBVdGls
aXplIHJhbmdlX2dldF9sYXN0X2JpdCgpIHRvIGdldCBob3N0IElPTU1VIGFkZHJlc3Mgd2lkdGgg
YW5kDQo+PiBwYWNrYWdlIGl0IGluIEhvc3RJT01NVURldmljZUNhcHMgZm9yIHF1ZXJ5IHdpdGgg
LmNoZWNrX2NhcCgpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvdmZpby9jb250YWluZXIuYyB8
IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAy
OSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMg
Yi9ody92ZmlvL2NvbnRhaW5lci5jDQo+PiBpbmRleCAzYjY4MjY5OTZhLi44NjNlZWMzOTQzIDEw
MDY0NA0KPj4gLS0tIGEvaHcvdmZpby9jb250YWluZXIuYw0KPj4gKysrIGIvaHcvdmZpby9jb250
YWluZXIuYw0KPj4gQEAgLTExNDMsNiArMTE0MywzNCBAQCBzdGF0aWMgdm9pZA0KPnZmaW9faW9t
bXVfbGVnYWN5X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPj4g
ICAgICAgdmlvYy0+cGNpX2hvdF9yZXNldCA9IHZmaW9fbGVnYWN5X3BjaV9ob3RfcmVzZXQ7DQo+
PiAgIH07DQo+Pg0KPj4gK3N0YXRpYyBib29sIGhpb2RfbGVnYWN5X3ZmaW9fcmVhbGl6ZShIb3N0
SU9NTVVEZXZpY2UgKmhpb2QsIHZvaWQNCj4qb3BhcXVlLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiArew0KPj4gKyAgICBWRklPRGV2
aWNlICp2ZGV2ID0gb3BhcXVlOw0KPj4gKyAgICAvKiBpb3ZhX3JhbmdlcyBpcyBhIHNvcnRlZCBs
aXN0ICovDQo+PiArICAgIEdMaXN0ICpsID0gZ19saXN0X2xhc3QodmRldi0+YmNvbnRhaW5lci0+
aW92YV9yYW5nZXMpOw0KPj4gKw0KPj4gKyAgICAvKiBUaGVyZSBpcyBubyBWRklPIHVBUEkgdG8g
cXVlcnkgaG9zdCBwbGF0Zm9ybSBJT01NVSB0eXBlICovDQo+PiArICAgIGhpb2QtPmNhcHMudHlw
ZSA9IElPTU1VX0hXX0lORk9fVFlQRV9OT05FOw0KPj4gKyAgICBIT1NUX0lPTU1VX0RFVklDRV9J
T01NVUZEX1ZGSU8oaGlvZCktPnZkZXYgPSB2ZGV2Ow0KPg0KPmNhc3QgdXNlcyB0aGUgd3Jvbmcg
dHlwZSBhbmQgSSBhbSBub3Qgc3VyZSB0aGUgLT52ZGV2IGlzIHVzZWZ1bC4NCg0KR29vZCBjYXRj
aCwgd2lsbCByZW1vdmUgdmRldiBhcyB5b3Ugc3VnZ2VzdGVkLg0KDQpUaGFua3MNClpoZW56aG9u
Zw0KDQo+DQo+DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQo+DQo+PiArDQo+PiArICAgIGlmIChsKSB7
DQo+PiArICAgICAgICBSYW5nZSAqcmFuZ2UgPSBsLT5kYXRhOw0KPj4gKyAgICAgICAgaGlvZC0+
Y2Fwcy5hd19iaXRzID0gcmFuZ2VfZ2V0X2xhc3RfYml0KHJhbmdlKSArIDE7DQo+PiArICAgIH0g
ZWxzZSB7DQo+PiArICAgICAgICBoaW9kLT5jYXBzLmF3X2JpdHMgPSAweGZmOw0KPj4gKyAgICB9
DQo+PiArDQo+PiArICAgIHJldHVybiB0cnVlOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9p
ZCBoaW9kX2xlZ2FjeV92ZmlvX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRh
KQ0KPj4gK3sNCj4+ICsgICAgSG9zdElPTU1VRGV2aWNlQ2xhc3MgKmhpb2MgPSBIT1NUX0lPTU1V
X0RFVklDRV9DTEFTUyhvYyk7DQo+PiArDQo+PiArICAgIGhpb2MtPnJlYWxpemUgPSBoaW9kX2xl
Z2FjeV92ZmlvX3JlYWxpemU7DQo+PiArfTsNCj4+ICsNCj4+ICAgc3RhdGljIGNvbnN0IFR5cGVJ
bmZvIHR5cGVzW10gPSB7DQo+PiAgICAgICB7DQo+PiAgICAgICAgICAgLm5hbWUgPSBUWVBFX1ZG
SU9fSU9NTVVfTEVHQUNZLA0KPj4gQEAgLTExNTIsNiArMTE4MCw3IEBAIHN0YXRpYyBjb25zdCBU
eXBlSW5mbyB0eXBlc1tdID0gew0KPj4gICAgICAgICAgIC5uYW1lID0gVFlQRV9IT1NUX0lPTU1V
X0RFVklDRV9MRUdBQ1lfVkZJTywNCj4+ICAgICAgICAgICAucGFyZW50ID0gVFlQRV9IT1NUX0lP
TU1VX0RFVklDRSwNCj4+ICAgICAgICAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihIb3N0SU9N
TVVEZXZpY2VMZWdhY3lWRklPKSwNCj4+ICsgICAgICAgIC5jbGFzc19pbml0ID0gaGlvZF9sZWdh
Y3lfdmZpb19jbGFzc19pbml0LA0KPj4gICAgICAgfQ0KPj4gICB9Ow0KPj4NCg0K

