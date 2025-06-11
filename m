Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5712EC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 10:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPIzA-0002OQ-2m; Wed, 11 Jun 2025 06:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uPIz4-0002O7-6d
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:47:06 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uPIz1-0002Dh-HC
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749638823; x=1781174823;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nZIQnnm+vIqO71m1t+gaRVh8Ib+5UGzxaqTCoxMe8wc=;
 b=Xw9Ee19ai9h6F4ydJw4Ezf69XaPu90f5matqMAiSFrlihTmqteWgijDK
 uU2i95YnvLLXjU6TawviosXRdpuoXpHG/hMDgBTId1xm9dK5GPsam8gJK
 pns24WZpbO5GuuDuygRHTOiQKVHa5sFphf/b1oFragm8dBLb1k2RNCvQ2
 5EQpYajZYj3/mglnjX+B85LLcXQTJx6drIO3UW0D+irNraoSSmTmydsff
 UNexEP6QxXA/OsHBCzcSqSdyx5mWJDkY6mQ8BH6UU/aUT7kPZUJmE+uVx
 Gt+ZHc+QYBmyBM4Inr4Iz8cHZKX31npXRTWWebAmq1npu51f5akIOti9X Q==;
X-CSE-ConnectionGUID: r/tLpY6ARXiHHDvna1mmqg==
X-CSE-MsgGUID: duWdcKWHRSuMBbY0JrPn2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51768339"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="51768339"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 03:47:00 -0700
X-CSE-ConnectionGUID: 4Qe7rY8UTiK2t/Htd5aJwQ==
X-CSE-MsgGUID: pjmoBOoFS5KCXlFIktw6gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="148075133"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 03:47:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 03:46:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 03:46:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.80)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 03:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO4WDflnhWuWq1mIKs8hgIumP07DUyv57CorwhuVW/SjXcF3d1ydLMyrnan5P2UCg2FE1NgiGXnZdGMVyFV7jmvePpfJrnfceoozARsXoPM/V9lhfUbb6E775131JYMJ32tbSjG58fQUyIoJTrXP8e2/T+PGW1YKBSaqKegzM4d2uyUnOYt7WXrV3ky8nPAixjQFuXmOhPprNp7jN/U3cK8z4JD7dkLuRsG2An3LqYKbLC1hOBCdRpwUn1hs5ECo/k2iuQwpSDvaYbRpe3mAwZmwqt/LAVlM+w9ZwPSjviK8Yg82xq31ulznfj7we9u9DOXqfUhNJfsZq3eVzVMQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZIQnnm+vIqO71m1t+gaRVh8Ib+5UGzxaqTCoxMe8wc=;
 b=fC8bbwQAB/jfdL/vTmq4G37WL3Z8S579k12nYhfR9xhkZGlV93UXC6Z3N5tKC28jlbVsDV30l0qRxrb3Mr1Nj/EPYpCRfmGpZSU7T8bKqPFslukMXsdpREc3qpJUrIIhdAP4AIf4IwS241utwJpzeaSnXP4g9ANezfVMKrD0/5yOH+oLOLqWVzxI2AvbbbsZ5rJe2iJOLBRe143l+4B9pbXHrmIFphY+xiaiRNGD/2f47O9VlY+IGbigwyBMj7g1o15ZLK6oBnS6oO9g0t7YjV04dHfbSuWxkrWmOFdeuleJmBAWrvZRmWMM5nmBYrYFytHCesCTsyQloAW8FLHyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW4PR11MB6840.namprd11.prod.outlook.com (2603:10b6:303:222::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Wed, 11 Jun
 2025 10:46:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:46:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v1 05/15] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Topic: [PATCH v1 05/15] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Index: AQHb1sr8vTBgHrNJJUGsjDTsRuzrLrP9v/8AgAAE6QA=
Date: Wed, 11 Jun 2025 10:46:56 +0000
Message-ID: <IA3PR11MB9136DF86BA8E60C52336F7819275A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-6-zhenzhong.duan@intel.com>
 <6bbc4632-1234-4f6f-a621-d5f8a1a27bcd@intel.com>
In-Reply-To: <6bbc4632-1234-4f6f-a621-d5f8a1a27bcd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW4PR11MB6840:EE_
x-ms-office365-filtering-correlation-id: 1f9c8e2a-0bc9-4135-d406-08dda8d5491a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aFNNOEpsUzJRRGZ2aldOaUZEQ085ZkJHWVlpenpOZVdWQVYyT3U5TGdDQzFh?=
 =?utf-8?B?K0M2M3pFbVpicWk1NDd2V1RYSmlnNFhWN0xKNFZ4WWlHNlhKQzdja0UyMDY1?=
 =?utf-8?B?N1JKNThNVytsVHdTWXM1OGIrK3JHNjdaZmNCc3FlQkwyZ2N0aWVOenpXYU5h?=
 =?utf-8?B?L291OE9FdzVrZjRsd1NZOFhKSXQvN0dKVjdNYWVjLzZMMjNGMXJ3ZWNTeXZO?=
 =?utf-8?B?alc0dEZWVUZsYUVqTWdPU3pGdDVxeENKZGg0Mkl5U292Sm1PYUNoNVY1YVRm?=
 =?utf-8?B?NlhEaVN5VFRsZVVnRi9KMERzbXhPL3ZYV1RtamVPVWtzazhNYlR2QytYOUdl?=
 =?utf-8?B?OUNQSy9KUHlJTUg4azN4a0FjN1RnRW8wM2hDU2E5bzVkLzU0SlhFdUh2bEw1?=
 =?utf-8?B?bkMrRWNkZDJvRGh0S0ppdmYzNndtTkYyODhsN2NLc3R2L0tLOEFDaElpMmUz?=
 =?utf-8?B?YVdLYlBLaWlkQ1dQU0ZqRVlseFhHWmIzQU5JY2JGT0MrL1RFQmhUY05Gd3VR?=
 =?utf-8?B?MGJPQkprbncyV3ovQkxoSzExM0tXR1BmZ2QvYTJ0UHplUlZDZXlUbFViQ29W?=
 =?utf-8?B?bk5udjVaN3FBcE05RXp5WENEM3FJbU1JWUdQV2lmdGkrL2NNNEVvWjU0S0hs?=
 =?utf-8?B?S1BMejBGMzhGZkdWd0QyWUhteUxMUitWVzlOT3pzYTkyL0FESWhrTXRtQVg2?=
 =?utf-8?B?eHNPTkpxZmdwQU1RZXRaamNIWVdxSENZTWZtU1VhKzBDV3dzVzRQUW9FMEpr?=
 =?utf-8?B?N0tpWHBldWpHbEEyVGlIL2hBd3F3SkR1SFlVNXRScTF5YzJreFB4dTlMNmEx?=
 =?utf-8?B?dngxVHA0YVpCSHRHUjhDWnlNcW1FUWlHWDc1VzB6UElPYWxkbk94VWplVEVa?=
 =?utf-8?B?dnphN1pmc2hWOWpVV0tRellOOFh4UC9RWXFQVCtSUEpyYlkrSkpaVTJ5NHVa?=
 =?utf-8?B?Rk1TRStsU0tEM0E3NUdvL2g2V1ZoZXF0VEF3NmRXNGtxK1paTUtWMks0WnhB?=
 =?utf-8?B?cjMxSEN1SmEyWDBzN3JBTnE0VG5Oa3VaR0RrVlFSZFpoUXpFSHhTVXA4SlFx?=
 =?utf-8?B?T0Z6bllKZHhvb1lMbDF0dm9UQytYdkVUMmpUdGFpZk9oNlRDaUlyMzZ1QTVw?=
 =?utf-8?B?OUdFelpiMm8vUVRYNnpZbURqMEVHTi9zUGNhZlZKTXZocEdLaWd2eHhCOVBQ?=
 =?utf-8?B?MDl2RjlIckd4RCs1aFVLb0xZQWx6SEdhRUU4Z1NoK3htNEZiTVFuSytTeFZB?=
 =?utf-8?B?NWpHdmszVkZWQmFoQTJaU2loaThuMi9OVFh3WFZjM3ROYnpUbEF4UDllbDFn?=
 =?utf-8?B?b3YweXJRQityZ2lBdTd3d2Y4Sjl5cEdSY01Ma2RVRU5rZFhhVnFNbTZ1WkhC?=
 =?utf-8?B?a0pERFFGR09FSUg1TFlRU3hLN01mZUVqcHFEZC9iY25TR2g1VlN4ZDVETmdy?=
 =?utf-8?B?UXlPY3dtYXc4SHZaNVUzc0hpWGw2Sng4Zis2VGtDVjIzWndMNVc5QW55cTlt?=
 =?utf-8?B?R0JHaVQ5cHJaRVR6ckdlK3FNeUdKaitMK2VRK3hHSXA0RVpta2dOYW5JYUhr?=
 =?utf-8?B?ZEk0TmxGMFJsVmhzSmhzQVVDZ0laZUxDL051S2hoQWtCTndFam1lOGV0RzNZ?=
 =?utf-8?B?Y1l3b2twcVQxaDlNdU16b0hDeisvYmQ0ck9tajl0MXVFVm81bTdJT0M4bEhw?=
 =?utf-8?B?QzdNZTBuZEYyZGdYTDJuK1BVZVhiNnFLVVE4ODF4SjVKVWVHdkttekpjY0tS?=
 =?utf-8?B?NUM1QkFGZXJsS29qUVU4WnJJTTJIS2FCK0UyNTZXTGo0WHlOM0FVT1BKeGFK?=
 =?utf-8?B?NkVPdGIrUVZWYW8yR3pGNUVOeGFINFVmK3hGa1BkT1FkV1ZmY2dwTE80QWxY?=
 =?utf-8?B?UkJSZVN0cnBDQ0lYSkhPV29UYUwzK3JVNlRzdmJqbGYrN1gxclRFSEwzRGU2?=
 =?utf-8?B?KytrRi9HazRXcWJYNUJlRDVOYmNnU1JEczVFdzBLU2Uxdzh5a2FUOFVHUWRN?=
 =?utf-8?Q?GcUDpvhdwwvzc8a9kCHKvfhkfPI+Jw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1FXLzZmdXhJWUgvM29UaU5kcDRRRU9DZjRYMlVwZ3VNbWdQZ1JVOWZoZndo?=
 =?utf-8?B?NXhFVE5QdEt6Vml3Y3Z0RS9OVDZuNjN3N2JrVWt2enFFekNBYUhYVm1SdGVy?=
 =?utf-8?B?NDVSUU1qK0x2UC9KTkhjUFlQc0dGVG1mdU9mditqM3NVbVcvVDBXVXZlVkE0?=
 =?utf-8?B?TW5OUVFPV0RiQTlqTXVUK3NrZTV1T1VVQitjZGlkWnJFZUplTDlPbGtYdDE2?=
 =?utf-8?B?RGlDMGdJSUdsZnNoQzhSOGw2YldxM2VJQzk5d0JZY1EzRTJ4QW5RR1lEOWRZ?=
 =?utf-8?B?cEpib3R2OEhZNEZYY1ZZUEZSUFNFR1I2UmswNSt4cnBBRUtVSVBsRmdYMCtv?=
 =?utf-8?B?aW5mbVViTkk1N1pDSkJqU2JKTUJoaUNHRVpmakw5RFFyek0rTXgydkhBZjRs?=
 =?utf-8?B?TzduY0tjak9tYkdqbWtFSVdXOFBXSEorckwxalpBekV4YmFNbUxlUTJvQ3RP?=
 =?utf-8?B?SHkzRWhvZWt0UDQxQmpQNXhqa0tSVlVRZkxBakRVOHR0QlZxdlVjRXgvb3lj?=
 =?utf-8?B?QXRCMy9odWVUakpYMXJFUmVFc3dSRFEydVZhcXZCbXIzSXYvV3NNZ1dyLyt4?=
 =?utf-8?B?SlhBMFBNRGl5dUY1MzVaL1duZVJwTWo4OFVUZG1KcDdIMGRmK2k3VGhyc2RI?=
 =?utf-8?B?RjJPQkNSdDBqRUc1Tk01N0FsVGVXb25uUHdNRG4rRDhYNll3OHBUVGVvYzhm?=
 =?utf-8?B?cG5wTGpHUzRqMndVNEJzWTArYXNHNGdZZzBYMTFwT1IzdS9EWW1kYjJEVzIv?=
 =?utf-8?B?Si95Nnd0eVk4MDBMQlF3VHJpT0JoM2Nib2c0WlZXMlU5TkRnemVKSHY2Yll0?=
 =?utf-8?B?R2tTMC84R29JbVRCNEtib3JZS2R4RmZGRk44QlJIWG5QU2JqWWQ0emNQZjlx?=
 =?utf-8?B?UVNZZGF1WVBiN1plL0ZlKzBWaExFMTVRQU0vZVJOdE5rUW0yV2dhaHlBQVFn?=
 =?utf-8?B?WEcvLzZ1Tm9YS1VxYXZGcGZpbW9QVlNPS3U2RUFNRThnb21rY2ZFdC9VYkNQ?=
 =?utf-8?B?SlFtc0d6aThIbC93NGxJbXI5RVlPc3pQVDV0YkhoU2Rrc0RhNXZZWHF2M29R?=
 =?utf-8?B?eVVuRlZKdmsxRzdnV3dkcW13aXZuR0JQcGVURjBDcytFOWNuUnVRK1VlejBi?=
 =?utf-8?B?MlFydWpvUEo3Q1ZXb2ZqVEc1LzNLNG1leVY5ZTRVYzYrZGZkZUNiRkJ6VkV2?=
 =?utf-8?B?WERXQVROSUhMSGhGUWNDRy9oekpyeGZwb2tiVEYwTWM5Z2lja0hUZXdKV3lE?=
 =?utf-8?B?REdFQVhIOHhhaXl2cmpqdnVBeFp2SlQ3WktoeTQ0amZBTGFSNlpsSjdCYmpq?=
 =?utf-8?B?TjR5alRscjdyOXFUa3d0TERIdHZEdUxzYm5Vb1NUTlhVM0lJbFFnK0RHV3FV?=
 =?utf-8?B?V3h3TmljeXpucVJINkN1TVlWWGlMdWk5NUZDNWw4K3k1WXZOLzNwMG5ERTJF?=
 =?utf-8?B?eDhGZU5PalZqM2Y2VjhCZ1hhd2hMNjQ4MzN6Y0F3Wk0wY2ZFZGcybitjd3hq?=
 =?utf-8?B?ZzFmMnlGNmlCQ084S1VodGF3OWttdzdoaG1KY2F2YVpEUnZJdXdqNVhMRnEr?=
 =?utf-8?B?Rk5MS2ZUUmNOOXkrb0wwQ2Z2cHRRQ3VkVGpnUGZDSWFWK2JmYlh4U2ZhVG9h?=
 =?utf-8?B?MHFtNlVRMk9IMEhacll5OUxEVlZyMTZZb1o0VFR2b1QyZFNSNTRCY2JxN3My?=
 =?utf-8?B?Z00vVXFLUVZsVDRjRkxBUzBCM2tldlB2V0MyRXRqWWlYOFhyYS9RS2NyK0Y5?=
 =?utf-8?B?RWFTNS9GZ2ViTmtISGtKOFpXTHZkOXhxMTJBekMxNUhZNisvV1Q4bTgvajZi?=
 =?utf-8?B?THFtbzUvSU9QRnFIK1NDSUtEN2YxYi9lekpUK3lyR3dpaWloTTVva0tUVTI5?=
 =?utf-8?B?WHRNWTc0ZHp1cHNodlZZVGdpTWJ6RXhLVWc2ellha29wOHQ4M0Y0Q1pzRFUx?=
 =?utf-8?B?M0p0Q1NPQ004Rll6L1p6SUhyWHgrY3BUYXE1V1FKMGRWZFVZT0g0UEFoM3lT?=
 =?utf-8?B?T0dWK3B2b2FsQ2RmQXF5T0JQRTNQMkNJVkFkQkdJZ0s2cnhDWWt1dHUxWTd6?=
 =?utf-8?B?TmcyZElaUkRPWXdRV1piVndLKzVlU0Q0UjUxUFIvTXlYWmZrQk5YYkp2clRK?=
 =?utf-8?Q?9Yrql5QMSuJ8uw1lH+T0bpWfM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9c8e2a-0bc9-4135-d406-08dda8d5491a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 10:46:56.4087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzE9rxIRkVDkHZsYPqueOGruB+6FhL0CSizviqe4cAdqAe1l91MuzLSC2/ru9X832VCTH3Gw3fSJ+/md6QPkaVd3iodszrV7EBqxhHU/oMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6840
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDUvMTVdIGludGVsX2lvbW11
OiBJbnRyb2R1Y2UgdHdvIGhlbHBlcnMNCj52dGRfYXNfZnJvbS90b19pb21tdV9wYXNpZF9sb2Nr
ZWQNCj4NCj5PbiAyMDI1LzYvNiAxODowNCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBXZSBh
bHJlYWR5IGhhdmUgdnRkX2ZpbmRfYWRkX2FzKCkgdG8gZmluZCBhbiBBUyBmcm9tIEJERitwYXNp
ZCwgYnV0IHRoaXMNCj4+IHBhc2lkIGlzIHBhc3NlZCBmcm9tIFBDSSBzdWJzeXN0ZW0uIFBDSSBk
ZXZpY2Ugc3VwcG9ydHMgdHdvIHJlcXVlc3QgdHlwZXMsDQo+PiBSZXF1ZXN0cy13aXRob3V0LVBB
U0lEIGFuZCBSZXF1ZXN0cy13aXRoLVBBU0lELiBSZXF1ZXN0cy13aXRob3V0LVBBU0lEDQo+PiBk
b2Vzbid0IGluY2x1ZGUgYSBQQVNJRCBUTFAgcHJlZml4LCBJT01NVSBmZXRjaGVzIHJpZF9wYXNp
ZCBmcm9tIGNvbnRleHQNCj4+IGVudHJ5IGFuZCB1c2UgaXQgYXMgSU9NTVUncyBwYXNpZCB0byBp
bmRleCBwYXNpZCB0YWJsZS4NCj4NCj5XaGVuIHJlYWRpbmcgdGhlIGZpcnN0IGxpbmUsIGl0IG1h
a2VzIG1lIHRoaW5raW5nIHdoeSBuZWVkIHRoZSBoZWxwZXJzDQo+c2luY2UgdGhlcmUgaXMgYWxy
ZWFkeSBhIGhlbHBlciB0byBmaW5kLiBUaGUga2V5IGlzIHRoZSBsYXRlciBwYXJ0LiBXZSBuZWVk
DQo+dG8gdHJhbnNsYXRlIHRoZSBQQ0lfTk9fUEFTSUQgdG8gcmlkcGFzaWQuDQoNCk9LLCBwcmVz
dW1lIHlvdSB3YW50IG1lIHRvIGRlbGV0ZSBmaXJzdCBsaW5lLg0KTGV0IG1lIGtub3cgaWYgeW91
IG1lYW4gbm90Lg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+PiBTbyB3ZSBuZWVkIHRvIHRy
YW5zbGF0ZSBiZXR3ZWVuIFBDSSdzIHBhc2lkIGFuZCBJT01NVSdzIHBhc2lkIHNwZWNpYWxseQ0K
Pj4gZm9yIFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQsIGUuZy4sIFBDSV9OT19QQVNJRCgtMSkgPC0+
IHJpZF9wYXNpZC4NCj4+IEZvciBSZXF1ZXN0cy13aXRoLVBBU0lELCBQQ0kncyBwYXNpZCBhbmQg
SU9NTVUncyBwYXNpZCBhcmUgc2FtZSB2YWx1ZS4NCj4+DQo+PiB2dGRfYXNfZnJvbV9pb21tdV9w
YXNpZF9sb2NrZWQoKSB0cmFuc2xhdGVzIGZyb20gQkRGK2lvbW11X3Bhc2lkIHRvDQo+dnRkX2Fz
DQo+PiB3aGljaCBjb250YWlucyBQQ0kncyBwYXNpZCB2dGRfYXMtPnBhc2lkLg0KPj4NCj4+IHZ0
ZF9hc190b19pb21tdV9wYXNpZF9sb2NrZWQoKSB0cmFuc2xhdGVzIGZyb20gQkRGK3Z0ZF9hcy0+
cGFzaWQgdG8NCj5pb21tdV9wYXNpZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcg
RHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50
ZWxfaW9tbXUuYyB8IDUwDQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+
IGluZGV4IDc5NmI3MTYwNWMuLjExMmUwOWUzMDUgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTE2MTcs
NiArMTYxNyw1NiBAQCBzdGF0aWMgaW50DQo+dnRkX2FzX3RvX2NvbnRleHRfZW50cnkoVlREQWRk
cmVzc1NwYWNlICp2dGRfYXMsIFZURENvbnRleHRFbnRyeSAqY2UpDQo+PiAgICAgICB9DQo+PiAg
IH0NCj4+DQo+PiArc3RhdGljIGlubGluZSBpbnQgdnRkX2FzX3RvX2lvbW11X3Bhc2lkX2xvY2tl
ZChWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICpwYXNpZCkNCj4+ICt7DQo+PiArICAgIFZU
RENvbnRleHRFbnRyeSBjZTsNCj4+ICsgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgcmV0ID0g
dnRkX2FzX3RvX2NvbnRleHRfZW50cnkodnRkX2FzLCAmY2UpOw0KPj4gKyAgICBpZiAocmV0KSB7
DQo+PiArICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIC8qIFRy
YW5zbGF0ZSB0byBpb21tdSBwYXNpZCBpZiBQQ0lfTk9fUEFTSUQgKi8NCj4+ICsgICAgaWYgKHZ0
ZF9hcy0+cGFzaWQgPT0gUENJX05PX1BBU0lEKSB7DQo+PiArICAgICAgICAqcGFzaWQgPSBWVERf
Q0VfR0VUX1JJRDJQQVNJRCgmY2UpOw0KPj4gKyAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgKnBh
c2lkID0gdnRkX2FzLT5wYXNpZDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByZXR1cm4gMDsN
Cj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGdib29sZWFuIHZ0ZF9maW5kX2FzX2J5X3NpZF9hbmRf
aW9tbXVfcGFzaWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlcg0KPnZhbHVlLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdwb2ludGVyIHVzZXJf
ZGF0YSkNCj4+ICt7DQo+PiArICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzID0gKFZUREFkZHJl
c3NTcGFjZSAqKXZhbHVlOw0KPj4gKyAgICBzdHJ1Y3QgdnRkX2FzX3Jhd19rZXkgKnRhcmdldCA9
IChzdHJ1Y3QgdnRkX2FzX3Jhd19rZXkgKil1c2VyX2RhdGE7DQo+PiArICAgIHVpbnQxNl90IHNp
ZCA9IFBDSV9CVUlMRF9CREYocGNpX2J1c19udW0odnRkX2FzLT5idXMpLCB2dGRfYXMtPmRldmZu
KTsNCj4+ICsgICAgdWludDMyX3QgcGFzaWQ7DQo+PiArDQo+PiArICAgIGlmICh2dGRfYXNfdG9f
aW9tbXVfcGFzaWRfbG9ja2VkKHZ0ZF9hcywgJnBhc2lkKSkgew0KPj4gKyAgICAgICAgcmV0dXJu
IGZhbHNlOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldHVybiAocGFzaWQgPT0gdGFyZ2V0
LT5wYXNpZCkgJiYgKHNpZCA9PSB0YXJnZXQtPnNpZCk7DQo+PiArfQ0KPj4gKw0KPj4gKy8qIFRy
YW5zbGF0ZSBpb21tdSBwYXNpZCB0byB2dGRfYXMgKi8NCj4+ICtzdGF0aWMgaW5saW5lDQo+PiAr
VlREQWRkcmVzc1NwYWNlICp2dGRfYXNfZnJvbV9pb21tdV9wYXNpZF9sb2NrZWQoSW50ZWxJT01N
VVN0YXRlICpzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQxNl90IHNpZCwgdWludDMyX3QgcGFzaWQpDQo+PiArew0KPj4gKyAgICBzdHJ1
Y3QgdnRkX2FzX3Jhd19rZXkga2V5ID0gew0KPj4gKyAgICAgICAgLnNpZCA9IHNpZCwNCj4+ICsg
ICAgICAgIC5wYXNpZCA9IHBhc2lkDQo+PiArICAgIH07DQo+PiArDQo+PiArICAgIHJldHVybiBn
X2hhc2hfdGFibGVfZmluZChzLT52dGRfYWRkcmVzc19zcGFjZXMsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2dGRfZmluZF9hc19ieV9zaWRfYW5kX2lvbW11X3Bhc2lkLCAma2V5
KTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyBpbnQgdnRkX3N5bmNfc2hhZG93X3BhZ2VfaG9v
ayhjb25zdCBJT01NVVRMQkV2ZW50ICpldmVudCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZvaWQgKnByaXZhdGUpDQo+PiAgIHsNCj4NCj4tLQ0KPlJlZ2FyZHMs
DQo+WWkgTGl1DQo=

