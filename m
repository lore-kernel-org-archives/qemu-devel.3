Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0EFE6C61C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIOmZ-0008EY-6k; Tue, 03 Dec 2024 04:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tIOmX-0008EL-5I
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:01:21 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tIOmU-0007pZ-B2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733216478; x=1764752478;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=s4sPGsYXxeK1WVmWkDg8x51zIw4wZJJZ9yRgQO/NSPA=;
 b=dI6AmCNQJZHLuOvfP+ayyA0Zld+w0P00jDC2H2wSLORdxydaiFBOoKa+
 a7SG/aEPsS7sJhROVa2uo0wWOddWvyfOGU0yZuxl9JTXXkFgeqrMtmpL3
 F225EkYZjPCH0i8d1TI84buFuWgG20/P5uhTq51FNF8MZX6gKjSTWGNMd
 umeatRZhxn3VPMrlRi0+3K6uYMfH5FI+7kC1vK3XDQtHIJK3VvtR7IiJB
 pkazoAqcn/hOm7bsDqd/6MGyaaZM+9gV1xAhH5vpoXsMsapgNxWwrJId8
 ccdU3TNaucdaxUKzDQlQYSq13YfO9rR42cuU9jr3pj3Iqe6AdbP6+X+Po A==;
X-CSE-ConnectionGUID: qQ1GB0gbS4iAFHJ9gjyX8A==
X-CSE-MsgGUID: VcaP6GhmRVm6hB4MVoLUtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32774850"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; d="scan'208";a="32774850"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2024 01:00:57 -0800
X-CSE-ConnectionGUID: Drru49rbTDKWk2YCqxFw/g==
X-CSE-MsgGUID: tZQJuXS0RReMZYSnbIli4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; d="scan'208";a="93828340"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Dec 2024 01:00:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 01:00:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 01:00:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 01:00:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrtpvjAMRnhiUZCmvAMlmVWwh4nT2pw4Tz0t7F+IUiMTWy5RHZaAhXk0nzSbLizayZsG3fZlM01NJy54ax4SEZ16G6Cy9S3S+om3ygZBACEHV5g5XvM+A/qli4W7qgqq7WzLwhCEB/YgqkiLwQPzA/SASVxppIqGgHitTX+nUhhCpyTFdEUpoJqmvnCx7LOfowTf4UnS5qfbz/Crc/085LPgPuqu/08B+VEhsDT/MkkpXcGlcMps0A1fZ2X5I8ULbDnOXdvdgHsSS3/iXbc0OVX8q4I6rtZhbmFnuV2OsnP7/kHbIN1a8hI8EzRbDbtygTLamaGxaLVTw8xvmfQ1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4sPGsYXxeK1WVmWkDg8x51zIw4wZJJZ9yRgQO/NSPA=;
 b=tc9zilF6KDtb7rkX+OFndmfns/EblE7PkRyyN/TuDi5C8+9t392eJfO2+wn0xeAe9iVMdhJs3D1budeuQnWgGSqqqnSX85mjuh+MBWxQnwOFL7iYip4mtTIy0QjwWR7pnEE+DjSC0/pnoXnqbGXK3lkBZXJ5nhcZ6FcbnuP6dYAiSNNkrWwmUby/wTzXkppeGzwnu354MlgEYMdhvj10X7aEObl0ACY6otsRsfliWTsvb4C6IS904ESKHh6KDiMJmC1E92DSyu9N48rzLAp0uyO5I+s5MZnUsN50540xI9jHCpepcxpi2LH0mIwhwgIpILA+/8gqFpG6vdKKTdbtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM3PR11MB8759.namprd11.prod.outlook.com (2603:10b6:8:1ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 09:00:50 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 09:00:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 00/20] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Topic: [PATCH v5 00/20] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Index: AQHbNBUUfhXfHcVmkkOgI6uOAYLshLLUWt0g
Date: Tue, 3 Dec 2024 09:00:50 +0000
Message-ID: <SJ0PR11MB6744E1315D9B89B48F7E08AF92362@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM3PR11MB8759:EE_
x-ms-office365-filtering-correlation-id: 142d7eb4-5a43-4f9a-6eab-08dd1378fc11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NlBNY09SQmZRbHFMajBKN0Q5RzV3WDEvQyt0R09LdHNRTVoxQ2tYNFFPYzkv?=
 =?utf-8?B?Yks5ZkovaFRKVWo5RmN5Mmx0ZVdVclF5R3NiOG5tRVM4ZXpReHdHL2VOTk9X?=
 =?utf-8?B?TWJtSDRQaHpUTHhRd0o5L3FxYkozbG9FZCtROWIvL0FDWWZOWFVjamtyWXJM?=
 =?utf-8?B?UE9DOUNjcE9GVXJMY0xEalJabTRxb2ovRFVEc1crc3djdS90dDkxWmt1K1VL?=
 =?utf-8?B?SWl1eXNRWk1TTjBicStzdlc3MHFWcXhVTWErT2h1Q1BmamxaclpjenhlRUNN?=
 =?utf-8?B?bnBJV0pUSWFDdlpBZzFRMjFZM21xOVNGSjRQQWlZcUVsVG5OcTI2L2VDVUl3?=
 =?utf-8?B?dFNEdjlHeUNmaUlNUWsxRXNpdXhiam84ZWZUWU5OQXUxMGw4Mlc0U1JHdU5R?=
 =?utf-8?B?Z1RNMEdhdWMxSlRYSVZqU01kYTNydjNObkFTc1FLaGtMc1UrWWRpQ000UnN4?=
 =?utf-8?B?UnlKNUczZ3huaVNZSldYQ25KUmNUSU82R1BiS2UveE9UeFVLMG1DMDl5VU8v?=
 =?utf-8?B?QWlvM2RNY1Qzc3BBN0FWQ1BGYWRqVUhiWENsejVEdXkvTVhYbHJITG1BZE95?=
 =?utf-8?B?WGZsc28xQWFFaFFFZTFQekl5NGdUbEE2NFpHRjNmZ0xId3czQ29MVlFMNVAv?=
 =?utf-8?B?RnpzL0JVamZBbzhORHQranlOak1Cb3Q0Y3JldVlqSUFUanJYRmxkdFEybVJS?=
 =?utf-8?B?RThCRm9vR1VQTDVCM3lLdm9sSG9HUFV5YmJseXl1c2NNS3pqV3lNd09qeThl?=
 =?utf-8?B?ZVpTTVk1MDJ5Qll5NklVckphdStyMDBacUZQTW1jc1dadElUcjk5eHJoU2c1?=
 =?utf-8?B?Z3IxWHN3ZTRyVGV2ZkxTVHpqYVNEeUNlbTVBWU1yVm1HOEQ4TTRkV1AzQks3?=
 =?utf-8?B?QnpxVTF2TUpFM2tyd2l2YkZ4VTNmMkpORzgyNHZXRmhiMVNaVGtyT3l6V044?=
 =?utf-8?B?ZFJ5MTZ4dm1xbmNkRi9KNTJPbktZbW1ueW82S1hSMit6U0FNczF0bXRTRTRC?=
 =?utf-8?B?WkNBN01TZWdNOUhKd1JIUWRFYVh4dHJKMGltV1pMMmFPWHZvcHB5bGpITVVH?=
 =?utf-8?B?dHBNU0VCcUxhN1NSRkZCR085T0taR3ZtMHdoYStUbG81SjdJa21EbnJSOXl6?=
 =?utf-8?B?YllGSHJMZk5tVHM1L1hibmFqcElvOG5PTkM1dDFUVUhIWUtrQ01JNjJPR3pT?=
 =?utf-8?B?SitwMVp5MjRFdE5YNTZRVWtRQlZsTFpoQVpPTi9wVDluSjNjV0VIZnR1VFJk?=
 =?utf-8?B?L1o1WWE0WWhXZ0JFYldyUXZqTXVvaitDMVVZUGd1ZHpDS0JycjRJcnZjdzF4?=
 =?utf-8?B?bng1dElWbGRhbDRLa09KVEw0d045SVIvTis4Y3NLQUhNSDNzVFU0OWRmT2c2?=
 =?utf-8?B?dDNwUlY5Z1FXS3dSR3BCTzBjYno5cnhDVUQ3U0FjZTZBUjRJdmtkbTFPQjdP?=
 =?utf-8?B?YXFuYytZNmFYVlpSNVg0dGpCY2cxUWxuWGY0dUhwV2hxcGRLY0VkYkEyUzVZ?=
 =?utf-8?B?aXlVeHgyVXpYQmRwMjlrVmRjWktxdGtUOWNRL09pYUxFcXZWTllhZzFpaWJ1?=
 =?utf-8?B?dWhFc09pVTh4K1pweFpLU2dySjAxbVM1eVFFVG96VU11OVZnWkNqaGZvOGRw?=
 =?utf-8?B?c0k0VzlEWkJ3RC85NE93MjFoeG0ybUVJcHRYT0l0eURGYUVvU2U4bWxFcy9G?=
 =?utf-8?B?YWNYbmlMaUd3UGdwV1gxTVQ4TXhKOTV3QlZoL1M1MkVYRGYwY1FRVnNGdUdn?=
 =?utf-8?B?UDdMNWZpbFVGeERqWlU2SmhsUWtQMzFYM1RabFRVREp5UVBHeEdHbkVsMnFF?=
 =?utf-8?B?Rngxdzg2NTlzMXE3NkIvTVZCOWx2ajI5QXd1SzRnYmprQThzdEdWOXExay9u?=
 =?utf-8?B?K0JhRXJKOTJHVThNWGVuVDRFVk1MZGJoQ3B1WFZ4VnMxaWhCVGV1cFBXWUdn?=
 =?utf-8?Q?mv8Sv+p0/1U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnZpc3ErbGVBTy9vbEM2bFRpakJqczU4Y2V5TmxBVHdGVGJKQnJ5T01nTGlt?=
 =?utf-8?B?Nm9PZ1I5QWZOZW1hSXJwdnkvRERCbVJRUTVoY3lOaW1lNWpmZjZMLzB5SDA4?=
 =?utf-8?B?akg3MVBLVXJMOWtydWlKQ2NHVzI4SlJQZmlIR1ZiYWtJRFp0Nm9jakhYaG50?=
 =?utf-8?B?TFpzYm9MdGcvQjd0R3J6MWtZeWVNMGgyd01ablc5Ylg1bGRlekJ1WWkvY0Yw?=
 =?utf-8?B?Zlo3aWxjb1ZjNE5JelBnUXhaeXcrWjB4Y0k5dW5sQkVTRlg5QzRiL1pETnVQ?=
 =?utf-8?B?N0dTdFJ2QVBKTjN2eFh4S2RySldQTzBRODRucUxTMzc1RmJZemtiN2NVZnIz?=
 =?utf-8?B?RE9pSjJJS3VkTzFuY0ZYNXlWR2VJQW1SY2hTcDhEbFdBM0p3aE9zeng3aXly?=
 =?utf-8?B?ZkJOdkRrWDFWYXR0ZExiQWFlK211TVhFK3c4ZUlYcUQyajFKQXoyUFZZRStM?=
 =?utf-8?B?L0FYNHgvQk95RndrQit2VFlYNW5vRGN3ZEl4N3htODdCRzFjaHlNbHB2VEdI?=
 =?utf-8?B?MWk2bzZJK0xTUWlZRFpGOWs5eFBISUFBemM0alBaMWFNbnY4ZzJBYlYyWHI1?=
 =?utf-8?B?NE5pSEQ4bkxVUWkzcnhaOXFpdVdWZEZNR0Q4UFhwcUgxeHhOT2kxUXpUc3JS?=
 =?utf-8?B?dDZmZFlGV3IwTFRwVUVLakRlbStrZVJXYkVRd1lNWnN0ZnlqWGMrUVZhS01l?=
 =?utf-8?B?ZTI3VlFZeWJlOWM3dGN2dGRieXdOeE5rQ0ZTV2FyTWlXcWlsWjd1TFZrLzBY?=
 =?utf-8?B?eTlEQTRYZlRhOE9KcnFmRzNZM1lJQWt2R1dTcDljQjFMMk1pY3BEMnNWakhr?=
 =?utf-8?B?eEpkQlpOUVJXT09PTUNudWNsQnBhY3o0SG8xNThyWlNyNGpra0xZNjMydnBs?=
 =?utf-8?B?TmZnaE0wLzkxTzk4dFlJdTFBTXdmZnlQRVNTWk1vaTVLMGpIT2NwVzJ3NTFw?=
 =?utf-8?B?b2ZWVmlFVnRpQ3hRcGdPdkNnNXZmZDB3RFk4b2xlR3N3ckI5TFVaTGw3RU9K?=
 =?utf-8?B?a2ZFbjhmS2k0WUNrN09KVUNILzcvMGpLME9NZDU4b2lMcXVSRGVRL0V4KzZB?=
 =?utf-8?B?ZXRyM0hVem5BM2c1YTJzY2ZpMHhQZUlmeGVSWGhrdXFkVHhWZ3Z2VlRzWWth?=
 =?utf-8?B?Z2NxK2RFYzRiNWpNWHJlSGtFVnBlVnUra2lOd2tzVkNvbkFvSmVHRGNGNzZs?=
 =?utf-8?B?bEY4UFRia3ZxVFFtdUxZUHJCWTlCenBSanhqK0tVYU1GbjVTd2l2K2xsaTg2?=
 =?utf-8?B?SDlidHdwUnR3WHFmWkZQM0NieWlqWjR4Rll3bE9lUFlCQitVMk9QQVNITEVV?=
 =?utf-8?B?bGpZS2tsQmVOWXh2MzNBamd2eGlmVE4rM0pXVVg1TzZML2FPSGJOZzRvbytT?=
 =?utf-8?B?c01la3BKR3FKa1VPQUpCc3dKallmUytZTmJOYldnNzRXWGRRWEpMTFBKc0Y3?=
 =?utf-8?B?Ri9HNERvY1pKbVhNZnUzV05jS1I1SGkvR2xNbDVuWCtXSmRDR2U0NHM1WVFa?=
 =?utf-8?B?bjFoM3RCNmJPOUF5WGdFSHNoczB3eDZ2a2NOSGh6dDlLK3ZWWU94ckNMTHpP?=
 =?utf-8?B?WUErQ0tJSWw4eFhJbnZIeXVtQ2N5WkQvMFlxWEU3VkJLRFFDdHU4TUVaQTl5?=
 =?utf-8?B?VWtRV1NVRks3bDkvYTJGNHdxRlZQODZwZmNVT0c4SitVWVd5d2dUNDdPcWdW?=
 =?utf-8?B?TDFPd1I1UWlhaHREZ1h1cHQxdkwzeTB5OGN1Q0UvQWdEYkxQSjlKRVZsU2Vt?=
 =?utf-8?B?SlhmQXB2Z0thMy84c1c0RHcybWRWVnQ0bGQ0OXlKTm1PVU1RVHpGRTA4dHF5?=
 =?utf-8?B?cXpQbXRmQk5MZzA5S1ZJeFdoZnhPb253UWFYbTlhQWliN1ZTTVJ1V2pxOWh0?=
 =?utf-8?B?SDZ0bkFtdlgvalBjTXJJME9TQjNjSW11dEFrRjlkM0d5ZHFrWU95SjFmTFR3?=
 =?utf-8?B?M1E3R01GSHhCamY0anJUd3VBdkxaWFdjc0MrVEJpQXNpazRueFJlWDArLzlD?=
 =?utf-8?B?S25wYy84Z1dJc2lQTWZSTVgwbFJ0Sm8wUDlWRHVJeUhtd1BHQStkb0RjNEg3?=
 =?utf-8?B?N09OS2RpekdvbU9iOG1zWitVVmdybXM3cHl3VFpWNWFERks4U3RlVXJ1ZXZJ?=
 =?utf-8?Q?ovIftAUy9EOYyz6mIj9kmpMHF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142d7eb4-5a43-4f9a-6eab-08dd1378fc11
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 09:00:50.2133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtOrxIUQRfWP4F6Vw/pK8W0Ou4wD4BMICSJq+m6uBCPA4dm+/GLwrY4b7sWJ7/3R1kB0zgoqSz1Jc7ps9qfbyZgxnVI+nINWtz2onH325yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8759
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgYWxsLA0KDQpLaW5kbHkgcGluZ/CfmIosIGFueSBtb3JlIGNvbW1lbnRzIG9uIHRoaXMgdmVy
c2lvbj8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+RnJvbTogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+U3Vi
amVjdDogW1BBVENIIHY1IDAwLzIwXSBpbnRlbF9pb21tdTogRW5hYmxlIHN0YWdlLTEgdHJhbnNs
YXRpb24gZm9yIGVtdWxhdGVkDQo+ZGV2aWNlDQo+DQo+SGksDQo+DQo+UGVyIEphc29uIFdhbmcn
cyBzdWdnZXN0aW9uLCBpb21tdWZkIG5lc3Rpbmcgc2VyaWVzWzFdIGlzIHNwbGl0IGludG8NCj4i
RW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yIGVtdWxhdGVkIGRldmljZSIgc2VyaWVzIGFu
ZA0KPiJFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlIiBz
ZXJpZXMuDQo+DQo+VGhpcyBzZXJpZXMgZW5hYmxlcyBzdGFnZS0xIHRyYW5zbGF0aW9uIHN1cHBv
cnQgZm9yIGVtdWxhdGVkIGRldmljZQ0KPmluIGludGVsIGlvbW11IHdoaWNoIHdlIGNhbGxlZCAi
bW9kZXJuIiBtb2RlLg0KPg0KPlBBVENIMS01OiAgU29tZSBwcmVwYXJpbmcgd29yayBiZWZvcmUg
c3VwcG9ydCBzdGFnZS0xIHRyYW5zbGF0aW9uDQo+UEFUQ0g2LTk6ICBJbXBsZW1lbnQgc3RhZ2Ut
MSB0cmFuc2xhdGlvbiBmb3IgZW11bGF0ZWQgZGV2aWNlDQo+UEFUQ0gxMC0xNDpFbXVsYXRlIGlv
dGxiIGludmFsaWRhdGlvbiBvZiBzdGFnZS0xIG1hcHBpbmcNCj5QQVRDSDE1LTE3OlNldCBkZWZh
dWx0IGF3X2JpdHMgdG8gNDggaW4gYWxsIG1vZGVzLCB1cGRhdGUgRE1BUiB0YWJsZQ0KPlBBVENI
MTgtMTk6RXhwb3NlIHNjYWxhYmxlIG1vZGVybiBtb2RlICJ4LWZsdHMiIGFuZCAiZnMxZ3AiIHRv
IGNtZGxpbmUNCj5QQVRDSDIwOiAgIEFkZCBxdGVzdA0KPg0KPk5vdGUgaW4gc3BlYyByZXZpc2lv
biAzLjQsIGl0IHJlbmFtZXMgIkZpcnN0LWxldmVsIiB0byAiRmlyc3Qtc3RhZ2UiLA0KPiJTZWNv
bmQtbGV2ZWwiIHRvICJTZWNvbmQtc3RhZ2UiLiBCdXQgdGhlIHNjYWxhYmxlIG1vZGUgd2FzIGFk
ZGVkDQo+YmVmb3JlIHRoYXQgY2hhbmdlLiBTbyB3ZSBrZWVwIG9sZCBmYXZvciB1c2luZyBGaXJz
dC1sZXZlbC9mbC9TZWNvbmQtbGV2ZWwvc2wNCj5pbiBjb2RlIGJ1dCBjaGFuZ2UgdG8gdXNlIHN0
YWdlLTEvc3RhZ2UtMiBpbiBjb21taXQgbG9nLg0KPkJ1dCBrZWVwIGluIG1pbmQgRmlyc3QtbGV2
ZWwvZmwvc3RhZ2UtMSBhbGwgaGF2ZSBzYW1lIG1lYW5pbmcsDQo+c2FtZSBmb3IgU2Vjb25kLWxl
dmVsL3NsL3N0YWdlLTIuDQo+DQo+VGVzdCBkb25lOg0KPi0gdHdvIFZGSU8gZGV2aWNlcyBob3Rw
bHVnL3VucGx1ZyBpbiBsZWdhY3kgYW5kIHNjYWxhYmxlIG1vZGVybi9sZWdhY3kgbW9kZQ0KPi0g
dmhvc3Qgd2l0aCBjYWNoaW5nLW1vZGU9b2ZmDQo+LSB3aW5kb3dzIDIwMTkgVk0gYm9vdHVwDQo+
DQo+UWVtdSBjb2RlIGNhbiBiZSBmb3VuZCBhdCBbMl0NCj5UaGUgd2hvbGUgbmVzdGluZyBzZXJp
ZXMgY2FuIGJlIGZvdW5kIGF0IFszXQ0KPg0KPlsxXSBodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyNC0wMS9tc2cwMjc0MC5odG1sDQo+WzJdDQo+aHR0cHM6
Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25nL2lvbW11ZmRfc3RhZ2Ux
X2VtdV92NQ0KPlszXSBodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvdHJlZS96aGVu
emhvbmcvaW9tbXVmZF9uZXN0aW5nX3JmY3YyDQo+DQo+VGhhbmtzDQo+Wmhlbnpob25nDQo+DQo+
Q2hhbmdlbG9nOg0KPnY1Og0KPi0gYWRkIG5ldyBwYXRjaDggdG8gY2hlY2sgaWYgdHJhbnNsYXRp
b24gcmVzdWx0IGZhbGwgaW4gaXIgcmFuZ2UgKExpdXlpKQ0KPi0gcmVtb3ZlIHVudXNlZCBwYXJh
bWV0ZXIgaWggZnJvbSB2dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZSgpIChMaXV5aSkNCj4tIGRl
ZmluZSB0YXJnZXQgYXMgcG9pbnRlciBpbiB2dGRfZmluZF9hc19ieV9zaWRfYW5kX3Bhc2lkKCkg
KExpdXlpKQ0KPi0gcy94LWZscy94LWZsdHMgKExpdXlpKQ0KPi0gc2V0IGRlZmF1bHQgYXdfYml0
cyB0byA0OCBmb3IgYWxsIG1vZGVzIChqYXNvbikNCj4tIGZpeCByZXR1cm4gdmFsdWUgb2YgdnRk
X2lvdmFfdG9fZmxwdGUoKQ0KPi0gbWVyZ2UgcGlvdGxiIGludiBub3RpZnkgdG8gdnRkX2lvdGxi
X3BhZ2VfaW52YWxpZGF0ZV9ub3RpZnkoKSwNCj4gIG5vIGZ1bmN0aW9uYWwgY2hhbmdlDQo+DQo+
djQ6DQo+LSBzL1NjYWxhYmxlIGxlZ2FjeS9TY2FsYWJsZSBpbiBsb2dnaW5nIChDbGVtZW50KQ0K
Pi0gdGVzdCB0aGUgbW9kZSBmaXJzdCB0byBtYWtlIHRoZSBpbnRlbnRpb24gY2xlYXJlciAoQ2xl
bWVudCkNCj4tIHMveC1jYXAtZnMxZ3AvZnMxZ3AgYW5kIHMvVlREX0ZMX1JXX01BU0svVlREX0ZM
X1JXIChKYXNvbikNCj4tIGludHJvZHVjZSB4LWZscyBpbnN0ZWFkIG9mIHVwZGF0aW5nIHgtc2Nh
bGFibGUtbW9kZSAoSmFzb24pDQo+LSBSZWZpbmUgY29tbWVudCBsb2cgaW4gcGF0Y2g0IChqYXNv
bikNCj4tIHMvdGFuc2x0aW9uL3RyYW5zbGF0aW9uLyBhbmQgcy9WVERfU1BURV9SU1ZEX0xFTi9W
VERfRlBURV9SU1ZEX0xFTi8NCj4oTGl1eWkpDQo+LSB1cGRhdGUgdGhlIG9yZGVyIGFuZCBuYW1p
bmcgb2YgVlREX0ZQVEVfUEFHRV8qIChMaXV5aSkNCj4NCj52MzoNCj4tIGRyb3AgdW5uZWNlc3Nh
cnkgIShzLT5lY2FwICYgVlREX0VDQVBfU01UUykgKENsZW1lbnQpDQo+LSBzaW1wbGlmeSBjYWxj
dWxhdGlvbiBvZiByZXR1cm4gdmFsdWUgZm9yIHZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nhbm9uaWNhbCgp
IChMaXV5aSkNCj4tIG1ha2UgQS9EIGJpdCBzZXR0aW5nIGF0b21pYyAoTGl1eWkpDQo+LSByZWZp
bmUgZXJyb3IgbXNnIChDbGVtZW50LCBMaXV5aSkNCj4NCj52MjoNCj4tIGNoZWNrIGVjYXAvY2Fw
IGJpdHMgaW5zdGVhZCBvZiBzLT5zY2FsYWJsZV9tb2Rlcm4gaW4gdnRkX3BlX3R5cGVfY2hlY2so
KQ0KPihDbGVtZW50KQ0KPi0gZGVjbGFyZSBWVERfRUNBUF9GTFRTL0ZTMUdQIGFmdGVyIHRoZSBm
ZWF0dXJlIGlzIGltcGxlbWVudGVkIChDbGVtZW50KQ0KPi0gZGVmaW5lIFZURF9JTlZfREVTQ19Q
SU9UTEJfRyAoQ2xlbWVudCkNCj4tIG1ha2UgZXJyb3IgbXNnIGNvbnNpc3RlbnQgaW4gdnRkX3By
b2Nlc3NfcGlvdGxiX2Rlc2MoKSAoQ2xlbWVudCkNCj4tIHJlZmluZSBjb21taXQgbG9nIGluIHBh
dGNoMTYgKENsZW1lbnQpDQo+LSBhZGQgVlREX0VDQVBfSVIgdG8gRUNBUF9NT0RFUk5fRklYRUQx
IChDbGVtZW50KQ0KPi0gYWRkIGEga25vYiB4LWNhcC1mczFncCB0byBjb250cm9sIHN0YWdlLTEg
MUcgcGFnaW5nIGNhcGFiaWxpdHkNCj4tIGNvbGxlY3QgQ2xlbWVudCdzIFItQg0KPg0KPnYxOg0K
Pi0gZGVmaW5lIFZURF9IT1NUX0FXX0FVVE8gKENsZW1lbnQpDQo+LSBwYXNzaW5nIHBndHQgYXMg
YSBwYXJhbWV0ZXIgdG8gdnRkX3VwZGF0ZV9pb3RsYiAoQ2xlbWVudCkNCj4tIHByZWZpeCBzbF8v
ZmxfIHRvIHNlY29uZC9maXJzdCBsZXZlbCBzcGVjaWZpYyBmdW5jdGlvbnMgKENsZW1lbnQpDQo+
LSBwaWNrIHJlc2VydmVkIGJpdCBjaGVjayBmcm9tIENsZW1lbnQsIGFkZCBoaXMgQ28tZGV2ZWxv
cGVkLWJ5DQo+LSBVcGRhdGUgdGVzdCB3aXRob3V0IHVzaW5nIGxpYnF0ZXN0LXNpbmdsZS5oIChU
aG9tYXMpDQo+DQo+cmZjdjI6DQo+LSBzcGxpdCBmcm9tIG5lc3Rpbmcgc2VyaWVzIChKYXNvbikN
Cj4tIG1lcmdlZCBzb21lIGNvbW1pdHMgZnJvbSBDbGVtZW50DQo+LSBhZGQgcXRlc3QgKGphc29u
KQ0KPg0KPg0KPkNsw6ltZW50IE1hdGhpZXUtLURyaWYgKDQpOg0KPiAgaW50ZWxfaW9tbXU6IENo
ZWNrIGlmIHRoZSBpbnB1dCBhZGRyZXNzIGlzIGNhbm9uaWNhbA0KPiAgaW50ZWxfaW9tbXU6IFNl
dCBhY2Nlc3NlZCBhbmQgZGlydHkgYml0cyBkdXJpbmcgc3RhZ2UtMSB0cmFuc2xhdGlvbg0KPiAg
aW50ZWxfaW9tbXU6IEFkZCBhbiBpbnRlcm5hbCBBUEkgdG8gZmluZCBhbiBhZGRyZXNzIHNwYWNl
IHdpdGggUEFTSUQNCj4gIGludGVsX2lvbW11OiBBZGQgc3VwcG9ydCBmb3IgUEFTSUQtYmFzZWQg
ZGV2aWNlIElPVExCIGludmFsaWRhdGlvbg0KPg0KPllpIExpdSAoMik6DQo+ICBpbnRlbF9pb21t
dTogUmVuYW1lIHNscHRlIHRvIHB0ZQ0KPiAgaW50ZWxfaW9tbXU6IEltcGxlbWVudCBzdGFnZS0x
IHRyYW5zbGF0aW9uDQo+DQo+WXUgWmhhbmcgKDEpOg0KPiAgaW50ZWxfaW9tbXU6IFVzZSB0aGUg
bGF0ZXN0IGZhdWx0IHJlYXNvbnMgZGVmaW5lZCBieSBzcGVjDQo+DQo+Wmhlbnpob25nIER1YW4g
KDEzKToNCj4gIGludGVsX2lvbW11OiBNYWtlIHBhc2lkIGVudHJ5IHR5cGUgY2hlY2sgYWNjdXJh
dGUNCj4gIGludGVsX2lvbW11OiBBZGQgYSBwbGFjZWhvbGRlciB2YXJpYWJsZSBmb3Igc2NhbGFi
bGUgbW9kZXJuIG1vZGUNCj4gIGludGVsX2lvbW11OiBGbHVzaCBzdGFnZS0yIGNhY2hlIGluIFBB
U0lELXNlbGVjdGl2ZSBQQVNJRC1iYXNlZCBpb3RsYg0KPiAgICBpbnZhbGlkYXRpb24NCj4gIGlu
dGVsX2lvbW11OiBDaGVjayBzdGFnZS0xIHRyYW5zbGF0aW9uIHJlc3VsdCB3aXRoIGludGVycnVw
dCByYW5nZQ0KPiAgaW50ZWxfaW9tbXU6IEZsdXNoIHN0YWdlLTEgY2FjaGUgaW4gaW90bGIgaW52
YWxpZGF0aW9uDQo+ICBpbnRlbF9pb21tdTogUHJvY2VzcyBQQVNJRC1iYXNlZCBpb3RsYiBpbnZh
bGlkYXRpb24NCj4gIGludGVsX2lvbW11OiBwaW90bGIgaW52YWxpZGF0aW9uIHNob3VsZCBub3Rp
ZnkgdW5tYXANCj4gIHRlc3RzL2FjcGk6IHEzNTogYWxsb3cgRE1BUiBhY3BpIHRhYmxlIGNoYW5n
ZXMNCj4gIGludGVsX2lvbW11OiBTZXQgZGVmYXVsdCBhd19iaXRzIHRvIDQ4IHN0YXJ0aW5nIGZy
b20gUUVNVSA5LjINCj4gIHRlc3RzL2FjcGk6IHEzNTogVXBkYXRlIGhvc3QgYWRkcmVzcyB3aWR0
aCBpbiBETUFSDQo+ICBpbnRlbF9pb21tdTogSW50cm9kdWNlIGEgcHJvcGVydHkgeC1mbHRzIGZv
ciBzY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPiAgaW50ZWxfaW9tbXU6IEludHJvZHVjZSBhIHByb3Bl
cnR5IHRvIGNvbnRyb2wgRlMxR1AgY2FwIGJpdCBzZXR0aW5nDQo+ICB0ZXN0cy9xdGVzdDogQWRk
IGludGVsLWlvbW11IHRlc3QNCj4NCj4gTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAg
IHwgICAxICsNCj4gaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oICAgIHwgMTAxICsrKyst
DQo+IGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICAgICB8ICAgOCArLQ0KPiBody9pMzg2
L2ludGVsX2lvbW11LmMgICAgICAgICAgICAgfCA3MzIgKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tDQo+IGh3L2kzODYvcGMuYyAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+IHRl
c3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYyAgICB8ICA2NSArKysNCj4gdGVzdHMvZGF0YS9h
Y3BpL3g4Ni9xMzUvRE1BUi5kbWFyIHwgQmluIDEyMCAtPiAxMjAgYnl0ZXMNCj4gdGVzdHMvcXRl
c3QvbWVzb24uYnVpbGQgICAgICAgICAgIHwgICAxICsNCj4gOCBmaWxlcyBjaGFuZ2VkLCA3NDkg
aW5zZXJ0aW9ucygrKSwgMTYwIGRlbGV0aW9ucygtKQ0KPiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVz
dHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jDQo+DQo+LS0NCj4yLjM0LjENCg0K

