Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF567C87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 11:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh4vP-0006ol-6o; Wed, 30 Jul 2025 07:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uh4Vt-0000hT-1J
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:58:29 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uh4Vr-0000RV-40
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753873104; x=1785409104;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CTheoiPjitVcXgRhPXeGV8Lr95DPe0S6b6Wb4w7+aKM=;
 b=mj8lwaQojMMafwJAmFOZknE0MKg1ix5H9OABHJ0FL8fGDsWLqps3B8fU
 7d8N65pd2FbdS/QrT8TARx7E/MrQacfMqd/+pIb8zF8iLs6ZKQCJaCKlc
 aHn5CMbdrn+rm9lJjmLRffQWyck6B9cX7jiXlc4x51qnFrbNE/TExCMp/
 rBcPhUCr047i+WmKuSQm8DDfknt8sZDi4Qb5Ozv6a7Inoh1DRUgrsQXHD
 C/h79ONKkbww+N9XMoUzJ/F/S5IDhgMF9AAorPkhoCrH8QYpes3ZO7ZdS
 9QQXK7ViHHVkiPt1Tm60nwj3lBySkPfA9Xl5jo1r38vqUPBXd6XPH09nX Q==;
X-CSE-ConnectionGUID: Xr3pOqlgRTWVFsNRefP+kg==
X-CSE-MsgGUID: egOFB6YHTmeAX14EM3c+zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="73624611"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="73624611"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:58:21 -0700
X-CSE-ConnectionGUID: Zu1aEuznROuQ+N1SHh1z5w==
X-CSE-MsgGUID: uTKxLqeTTRifoRd3dlnwpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="167132317"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:58:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 03:58:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 03:58:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 03:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGkLoYJ/oMmP9Vb367fyk9DtjODQjJwTlTSx0aJSlMGFqoItqc2EbGJRrWpIMdxkd39/pMqpWzKGnYtrBsI4jnC+XacyRkPe5aClelyUbgtPPeZmM9rVTPGCJ+dzJhcGtCAYNzPMHWSnIlU4SMut29pBO4MwKJi3YGiTcjtJR4BR7B/OousY/ER5u1w9gMfJJy2jpfkOxefnMHjkEoh1sHcXZgdW3jH+glOyJBlqPir/ERTJP8DJR3gLoE2SOeZRgw9jnpEt3h7VNpTXE0F7ntrMPvWegreb+CVfYGltmNFiaEHjwS2HlSbHnVsJCpoPxETmAHDceYNKWfjBpZNitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTheoiPjitVcXgRhPXeGV8Lr95DPe0S6b6Wb4w7+aKM=;
 b=CCfT1rkl0M3PJywlYj1GtaFy269JHiWUZPNyD+q0lX+Ipbn3Gkq24yf5CEuLK++O1RVw2usCDAOpgb6abGIYCDWKj7K5LzL2up40EHjKCXrlECQwi0thY8+Pjt7Rj6Jik4u3S3z4Jih9l9zF4pi+xRXLT/DxqucCd0FNiMkc6/WLDCWOqGBoeesW8m0A1n1rQ2Q+xxcUBvLUkxUexiGxgp2osYRhyhWLTZ2c9A3p+QGZIR4OeTe3GX+zC3JGjua7N+7mWJudnvk6Ogbh9sChK63mXC2DbT1CVDirgVCdx4xhh9VAOWqbNOICnS0ssdMKmh57eMI1GdVavflxtVkjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 10:58:16 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8943.028; Wed, 30 Jul 2025
 10:58:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 18/20] vfio: Add a new element bypass_ro in
 VFIOContainerBase
Thread-Topic: [PATCH v4 18/20] vfio: Add a new element bypass_ro in
 VFIOContainerBase
Thread-Index: AQHcAGpS8Ce/Qx+eyUKg1lh8rD0F/LRJIBKAgAFgIkA=
Date: Wed, 30 Jul 2025 10:58:16 +0000
Message-ID: <IA3PR11MB9136F831BDBB3379EB3D86D49224A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-19-zhenzhong.duan@intel.com>
 <1ec1ad68-d6fc-41b1-8f62-5d1f9bdf3655@redhat.com>
In-Reply-To: <1ec1ad68-d6fc-41b1-8f62-5d1f9bdf3655@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB5327:EE_
x-ms-office365-filtering-correlation-id: 7d6eace9-aea4-4899-d9c2-08ddcf57fce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YWlSNGFCSk8rYW51SFpNSHpVSlQ1UHFHbEtsQkk0VjZ5M1BQL2hEYlhHZjA2?=
 =?utf-8?B?QnhMNDlucDVLcVVXbnFBRUdWMW13bWFCV2pTVWRIVFVqQ3N5QTkxT2lGVUNl?=
 =?utf-8?B?V1h6Uy9DSi9hc2I3QUI1SUNLQVYyTkR6bzBqL2FxWi9HZ0IzdFVjZTkrclZw?=
 =?utf-8?B?bU9vTUFsc08zVEdOdEV0cTJ0YmR5RzgyU1Y3Tm9qSjQ2NmJBWFRaZzBVaStm?=
 =?utf-8?B?VjJxaTZKQnJYYXhyNXBMdlJ2RllZOXlWVlI0cHZJM2hXWVgzZVpJV25LT0VH?=
 =?utf-8?B?bW1CaytwVHNWK3FTVmtvaW4zSFJoakNFU2xjYjV4SGV1aFh6eEhadGVzdzA5?=
 =?utf-8?B?R1dHcUtUNHBxQW84ZEdOVkd2cXhjTURhQnhzUm56TUpEOTYwVWlNQ2dkWi9D?=
 =?utf-8?B?TkE3Ry9GV2Z6S1FnTXkvMFJUb3dIbWlDblpZcWJuMmFTZGlxUERUc2hCamVJ?=
 =?utf-8?B?SlA4QzJMdnZhZldLcVpveGsyYVV5dWxEbnFBZlVNc3Q1RG9RTjRNZnRoMVBt?=
 =?utf-8?B?VTcwRUNHRVhqU1VjZjkyQkhvYVh3QkNJaEIrV1NhUnF4aGxCSllOcDB3U2pl?=
 =?utf-8?B?aS9RL2wzSXl6ZmliVjNkSFQwaWl1NHY3VkNlSmwrdWtRSWpqalBPamc3MnN3?=
 =?utf-8?B?SWJTRS9tdDVIZ3dRNnVydllPQnVjaXhPYktWeHBFL1VYRlVhMS9vODNQaTdL?=
 =?utf-8?B?RkNjNjFSQWF4Q3BjWUtUYWdiMWJjeWFkUDVvM0N0eDZ4dHVKZUVOZFI5YXRE?=
 =?utf-8?B?TVRPUDY2S2JUM0t0QmgwQmZ5TTEyUThIS2NhbXRqMlFiSVMxT1Q3ME5yaXZU?=
 =?utf-8?B?WURxTzRSQ2kxMjJpQ2lnL2V2QWtOVGgvVzMvckdXd3NRdnFxZTRuc21QQm13?=
 =?utf-8?B?QmdxdkZaS3hJWVNNOXdhSzJnWE56bFlPYnY0YXlzbzY2aFJSN0w4REtCSkQr?=
 =?utf-8?B?NjBhZ2l6SWFKN0trc0k3RHBmK09OVFcrZnZYN21Mais1Wjd4VXNuT3ZuaDYx?=
 =?utf-8?B?TmxaQWs1VGVIUGFtRFZsZkRFVmJrMFRHN0ljdEhGNWpBQW56M2poQ1NYRnNz?=
 =?utf-8?B?Ym9uOEoxdE53dXcyM3QrcERvejdKLzNrbUcrRE9yNi9mdExsRjRYZmFadnJZ?=
 =?utf-8?B?RWtIQ3hUZ21lV1RLaXphWUI5T1loaEE4SDNFbEFVelhIczZwMzErZDl3djZa?=
 =?utf-8?B?NlRsVGNiNUhkeVZ5YlpOcDRtQ2dHSkpvaGNwenEzMEVCaEdDSlVUclZwTmlx?=
 =?utf-8?B?R2RYZXhzTkd0RTJUTGgwbEpFejdtckNIdEVMSytTOFJDVW51VmR0RG5jWVhU?=
 =?utf-8?B?WWZYYlV3UXIxRmdhZTZnY2p0UGRzQ21TWkxscWFJbHB5UktzWm14bnNTQm1u?=
 =?utf-8?B?NEM3emxhTEMzc2h6YnRKRWNvOXR3R3A2R2g2L21LeGpCWUpTUWZ3Q3hLM1Bi?=
 =?utf-8?B?T0k1ditEL1ZDZHFyRG9iUDVHVHFicDVjOWJFQVRMK0pLWXZoK2F0WXA4RWs0?=
 =?utf-8?B?UElXZkhML3dKQlJ6OXQraUdSSmxjTmtvNFVxYU9QY1ZEUk1sYW14M2IwTkJM?=
 =?utf-8?B?OEhaQ3NPS1hjbFREc21pT2JhbTR0Tmx2RmVsY3kvUXpmaEpGUS9iWWY2alZF?=
 =?utf-8?B?U0pqRkZqNFJRdHVicFhoMjQ5R2JPTU1teDd3eXNtUGFwUGhIeTNyOTlpSU1D?=
 =?utf-8?B?dDUyNFpsVSt1ekRCMVc2akx1ZXRKeFVCSHZsZEdTT2lXZ2VaVXViMU5yN3Jo?=
 =?utf-8?B?NGRtcGJaVFMva1lYcG8yV2IvV2dhckJWSWFsQ1c5RzN1TnhNTUtHYzE0Rm9Q?=
 =?utf-8?B?anpBczlvZzhqd3FHUWorMmpVQnFPd2JCL1htYnpBQTdsSGV2QnNqTFRvYUJ4?=
 =?utf-8?B?WXZGVVpCK1VSdS9TYWtVTG1XaFBjTjFlMDZjejNBUDZYMStrK1JXeXlMcTYy?=
 =?utf-8?B?SUFvWlRlSm5UZTRFOE94TldLQmNQZldmbEw4ejhSOGVSU29WNHRWT0xzRUVR?=
 =?utf-8?Q?hRZBJ4nuVByeKKe9rQIjNh+i3wZ/3M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXh5Q3R2Rmk0UlY0N25xQmxFK0FOOUd5WVFpQm0xeTdUT1RPWnJTa2RHQzhX?=
 =?utf-8?B?bXJuelcvejQ3bEpzM3VDeHc0VzdnSnhzN3hkYTVHQ2NYUVIwTWJEWk1YK3hj?=
 =?utf-8?B?eW4xaVBjcnRzZ3ltR1hiYWI2R3lxTzA4Vnljc1dDdXA2Y3l5KzhzczJ0Vzk3?=
 =?utf-8?B?a2JBRGwxbWxxOE9LMUl6NTNVT1g4K0VRWGhOZHB3SVllaFoySExYVUZ6SVBz?=
 =?utf-8?B?Tkxvb2RNb2JLRGc5a250RDJYYnBKTDk2NVR6Ym1lTEhHN3Q3Nk5BbjZGMWdz?=
 =?utf-8?B?MldUbjhuaTVubStwVjljZ3lTMkpWcHFENytNa3lUNVRicDBrZmNBY1FJWnRI?=
 =?utf-8?B?S2Z3MEFvVEFOVmtOOWlKUjZHcUk5Yk9QL0tZb2JLTDVDVVdRa3JRdmh6R0VJ?=
 =?utf-8?B?TUpUS2k2Q1N6NzRFWGNldDdhU2ErUDkzVU9DcTNzODRaRGdVMXA0d1hiOXJo?=
 =?utf-8?B?NXpENHJYdXNlVmNQeCsycnNSMU1IY1VwRVR4Z1E4cmZWNXBoNXVzeURRRzgy?=
 =?utf-8?B?Uk1vZDJ1a2pIVWlHb1B3OXp3NFBWNXlUTm05SnRTa2FCSm5yTzMwZFpJVWVP?=
 =?utf-8?B?cGJyTytMa0ZVdUk5VzBoOW4vM0d0ZS9VakJKMVZ2L0FTcVplcmUydG5DOE1w?=
 =?utf-8?B?ZUt2ZE9aRWM1Vm55VnU2R21oempqeGI2UTlYK01ZUWsybUk2RzZXSFlzTHRL?=
 =?utf-8?B?ZG5JUThvcjVnRVdKNFl1QVVTRlVsK3E3cFAxYVNXaEZlRWx1YVlqR3lucVZD?=
 =?utf-8?B?NkdhM2taSHRJOWxxWm5ibEszdmpsQkRhRXRWV3A1MTJWOVd5bDNETWpic2lr?=
 =?utf-8?B?UE9paC9vOURhWWhJWjYreXc1TUo3NTRKTkJrVGJiL2N3bDlVcVVZZVpwMW5W?=
 =?utf-8?B?cVI2SXpyTitSVTA1c2p2OW5ZZGpsR0NZMkNxbVBYSXhhVkhiOVR1MEZxdmRK?=
 =?utf-8?B?VWYyQkdJYytOMTVSMnVvbjk3QVoyOThvZnBEVVViUkZNNXlTek9vbllWdWsz?=
 =?utf-8?B?VGZZUEVlMUxkY3NBajZtUEtGOXBrYjdpQ2dkZEhPbnROb2R5ZVBqL3pvN1JQ?=
 =?utf-8?B?RDRsUUZtTG11SSt1bWMvQnJWQjRFbTMyNDdvWHVJekJzelN1eW5sT0Y2ZDhC?=
 =?utf-8?B?WnhEVmw2VGNDallEWG9KcGdrMGVPeVl5OHhWQjMrTEp2YlJHekJ5UmRDa0M4?=
 =?utf-8?B?SEdJS3BHN0t5d2RGY2ZRNFJEdjR0Q0YzK0o4dzlJSDV3cVkzUmZ0NExsRXkw?=
 =?utf-8?B?UHpQeXMybHhLSTZWVXo0djV1ZEhIVG9RRnp1YUxibmJkTDZ5YWxZSnBiaVh2?=
 =?utf-8?B?WnpRNGY5cFVpT1UrRllvVXpndzhDYW9zUDl6cUtIY2FBV21KY1NmdXV4YkpQ?=
 =?utf-8?B?SnhQMkg1ZjAyR2p4U2FHbUdUR1RmazlkTERKbFlneEFiNS9ZYmNJNmZkbmtq?=
 =?utf-8?B?YnlVdVBDQlBkOEdyTEY3TGN2bUVPNVIvMFFoU3VsRWtnc1ZKSnVUMUtOaGxo?=
 =?utf-8?B?LzZibXB2RVN6NEtCN3ZSa1FWNENlN1lXbzlUK2J0RUVHTGQwM0VjM3NkbGdw?=
 =?utf-8?B?NC9RQU5WUWpGSERHcWxYWlhURkl4RDIzbllLa1hieFE2dXVEUlI5U0Z5amhR?=
 =?utf-8?B?TXRjdW5uMlBuNzBxaVlVM1I4RURhMURsbEE0ZHZtNGRlall0RUlmdUpodzdB?=
 =?utf-8?B?cVlTdjl1cnF6ek4wWWhrbk5EWEV4ZXV5TFQzUm1veXpUcnVra0hlQjNCTU5W?=
 =?utf-8?B?Vi9uUys2WTF4aTRVSW5uQVJvWU0xZ09Hb0dZNm1UekFoRlFuV1JaTEU2WEQz?=
 =?utf-8?B?UW9UTVcxL21NeW1vQ1FsZG5lTmZHWmJ2WkNpemtDQ2lWTEZMZGZpVzY2M2Er?=
 =?utf-8?B?bWN2SHFzb0VLK0lRL2hQYTYxY2k5ZFhqZHR4QnJmcm5wUm8rQUZUV3p1ZDBy?=
 =?utf-8?B?UVBKbnltaVhFUU9ZOTlpMkQ4NUJaL1dFTjYxdlErYlYybGlDL1gyNjArV2Q3?=
 =?utf-8?B?SDIxNFFwS0NoLys1dnZZUmhMSTZsNHZDOC9VWmZZSFhSU3JHSWp2cjIremMr?=
 =?utf-8?B?dTVDMlF4WGdXZXhoK0FVUTFUWVdyMFVpSnU2ckprMW03anlwSXlqcENmMzZj?=
 =?utf-8?Q?gxwOAYGAy/4d/ICloi6e8A5RY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6eace9-aea4-4899-d9c2-08ddcf57fce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 10:58:16.7999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAoySCrq4pZqH+byEOA/JRF3Wo+rHwBI8tUGUV2/BLrv/jbpb4Rzqf0XYtBMRfG/FVwdRJIFn4YP2neKIBUm5p7hfub2I4WUnuecUsTtxFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDE4LzIwXSB2ZmlvOiBB
ZGQgYSBuZXcgZWxlbWVudCBieXBhc3Nfcm8gaW4NCj5WRklPQ29udGFpbmVyQmFzZQ0KPg0KPk9u
IDcvMjkvMjUgMTE6MjAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2hlbiBieXBhc3Nfcm8g
aXMgdHJ1ZSwgcmVhZCBvbmx5IG1lbW9yeSBzZWN0aW9uIGlzIGJ5cGFzc2VkIGZyb20NCj4+IG1h
cHBpbmcgaW4gdGhlIGNvbnRhaW5lci4NCj4+DQo+PiBUaGlzIGlzIGEgcHJlcGFyaW5nIHBhdGNo
IHRvIHdvcmthcm91bmQgSW50ZWwgRVJSQVRBXzc3MjQxNS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAg
IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggfCAgMSArDQo+PiAgIGh3L3Zm
aW8vbGlzdGVuZXIuYyAgICAgICAgICAgICAgICAgICAgfCAxMyArKysrKysrKystLS0tDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPmIv
aW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPj4gaW5kZXggYmRlZDZlOTkz
Zi4uMzFmZDc4NGQ3NiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRh
aW5lci1iYXNlLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNl
LmgNCj4+IEBAIC01MSw2ICs1MSw3IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9Db250YWluZXJCYXNl
IHsNCj4+ICAgICAgIFFMSVNUX0hFQUQoLCBWRklPRGV2aWNlKSBkZXZpY2VfbGlzdDsNCj4+ICAg
ICAgIEdMaXN0ICppb3ZhX3JhbmdlczsNCj4+ICAgICAgIE5vdGlmaWVyV2l0aFJldHVybiBjcHJf
cmVib290X25vdGlmaWVyOw0KPj4gKyAgICBib29sIGJ5cGFzc19ybzsNCj4+ICAgfSBWRklPQ29u
dGFpbmVyQmFzZTsNCj4+DQo+PiAgIHR5cGVkZWYgc3RydWN0IFZGSU9HdWVzdElPTU1VIHsNCj4+
IGRpZmYgLS1naXQgYS9ody92ZmlvL2xpc3RlbmVyLmMgYi9ody92ZmlvL2xpc3RlbmVyLmMNCj4+
IGluZGV4IGY0OThlMjNhOTMuLmM2NGFhNDUzOWUgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2xp
c3RlbmVyLmMNCj4+ICsrKyBiL2h3L3ZmaW8vbGlzdGVuZXIuYw0KPj4gQEAgLTM2NCw3ICszNjQs
OCBAQCBzdGF0aWMgYm9vbA0KPnZmaW9fa25vd25fc2FmZV9taXNhbGlnbm1lbnQoTWVtb3J5UmVn
aW9uU2VjdGlvbiAqc2VjdGlvbikNCj4+ICAgICAgIHJldHVybiB0cnVlOw0KPj4gICB9DQo+Pg0K
Pj4gLXN0YXRpYyBib29sIHZmaW9fbGlzdGVuZXJfdmFsaWRfc2VjdGlvbihNZW1vcnlSZWdpb25T
ZWN0aW9uICpzZWN0aW9uLA0KPj4gK3N0YXRpYyBib29sIHZmaW9fbGlzdGVuZXJfdmFsaWRfc2Vj
dGlvbihWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTWVtb3J5UmVnaW9uU2VjdGlvbg0KPipzZWN0aW9uLA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAq
bmFtZSkNCj4NCj5JbnN0ZWFkIG9mIGFkZGluZyBhICdWRklPQ29udGFpbmVyQmFzZSAqJyBhcmd1
bWVudCwgSSB3b3VsZCBhZGQgYW4NCj5leHRyYSAnYm9vbCBieXBhc3Nfcm8nIGFyZ3VtZW50Lg0K
DQpEb25lLCBzZWUgaHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L2NvbW1pdC9iMGJl
OGJmYzlhODk5MzM0ODE5ZjNmNGYwNzA0ZTQ3MTE2OTQ0YTUzDQoNCk9wcG9ydHVuaXN0aWNhbGx5
LCBJIGFsc28gaW50cm9kdWNlZCBhbm90aGVyIHBhdGNoIHRvIGJ5cGFzcyBkaXJ0eSB0cmFja2lu
ZyBmb3IgcmVhZG9ubHkgcmVnaW9uLCBzZWUgaHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9x
ZW11L2NvbW1pdC9hMjFjZTBhZmQ4YWVjNWQ1YTllNmRlNDZjZjQ2NzU3NTMwY2I3ZDlmDQoNClRo
YW5rcw0KWmhlbnpob25nDQo=

