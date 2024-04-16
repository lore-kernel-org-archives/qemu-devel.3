Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBA5C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 05:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwbpx-00023M-TV; Tue, 16 Apr 2024 01:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwbpv-00022x-Ow
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 01:58:31 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwbpt-0008Pm-0i
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 01:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713247110; x=1744783110;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Xkhw/9O0oSsn6NR0PRhR/pibd8ytivJZvx8uYqLLDR8=;
 b=GYvS1ntC1jZZFHY/SGv7J7HytzDjxx3j8sYoUxah7eQjQYxd6u83FEcR
 MKvkwodnMCFsx6Od+TXkv2JIPDM8s/76nMFyuMvCsKKdTdEMnTrWQBZel
 1JaBrBl60GxZrGPKFfg3IttRlkxQ/DSMtD+Ofpcb4klnNOy9E+g2n2BLc
 HtMmD22Mn+QOf8DKJbK87O3GrLUCoSeg1//NgZW2gBpnAKMY0lH6EZvRC
 pcqTI5cxjLNGcy8RLYKdfS/flRJeZd0N5235CnVtsiS9bzyQ0FQvd21fA
 LE7gVJDGwaUsvHcSUcK8CyCpn2uF0gF7LeuYjjonvDNtpBdcGk1kffoz4 Q==;
X-CSE-ConnectionGUID: TwECwo8RQYmg3j9hZOpLXw==
X-CSE-MsgGUID: WImBUUqYT6CkduR27ObxNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12454977"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; d="scan'208";a="12454977"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 22:58:26 -0700
X-CSE-ConnectionGUID: 9S7IRhGdQfKr6lXEsRCrNQ==
X-CSE-MsgGUID: GqFhlhMoTfGca8YPkUGd0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; d="scan'208";a="26809112"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 22:58:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 22:58:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 22:58:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 22:58:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 22:58:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHMVI8MeOYueZb3wqLtfRf8uz8QNQmVCMwX+uOVia/6eDzYEE8m+qVNyAs9jIUCplOLtNtm0WeDluSVHP+ypryrN46FQTu0IQA3CwUuBREDmbw+CvZxTIWnxeJSJZ7mXuzlcDq101BsafD8+qH4EI5byQdKtL4tV7EWzri/fnZKq2/M+hQWgfGQvIwBL+ezTfWf+qz2usSY2t3Fa9Tu6O/xJOSH/whA/aHYPztC7bSr92CmpYh/+HR4/50J5dZuMSP6gbaX4+ZqWwQAKtbjrQsyl5UnkDmC2xpMyj15Vd0GWa6ZlY86lqWvTY0UHWdnomL6vKXNfUGvdgHa0l17u2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xkhw/9O0oSsn6NR0PRhR/pibd8ytivJZvx8uYqLLDR8=;
 b=RfYL+9k58Q4gBDSWZTFDwX2c+kpBnzrhLRZK369G0GH8+kseOkafHY7rpLb0LxJQs/97+Jv31e4rQko5va8kuqW2s9Fei9WR10a+m+Fmfiddyt9bQUIWzQzcFGltMR5D97a6VF+thLpdgW6fiOKC8dzU6O5zUe9d5Oe2BOLGRBPOCy5aIpbFy3q2Vn6enKmtk2cDnQV69rhSWZHSJZNOpd9np9ZqLRN1vNUp+mXRMsohZHBZvJQ6MDIko2cdGFlEi+dTsMbqNowbNnIxw5pMLWoLdGTJJQWjC2C0LEIQqiJQMXbPXcAorf7I8rWFrANAAu9SeptsQXzcJ966n6ga2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7721.namprd11.prod.outlook.com (2603:10b6:610:12b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 05:58:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 05:58:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 05/10] vfio: Implement get_host_iommu_info() callback
Thread-Topic: [PATCH v2 05/10] vfio: Implement get_host_iommu_info() callback
Thread-Index: AQHaiYzy2US92hfBQkGN4Ri91g1SFLFpWvEAgAD55cA=
Date: Tue, 16 Apr 2024 05:58:22 +0000
Message-ID: <SJ0PR11MB6744BB5C25D6C2FFEAD81A0892082@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-6-zhenzhong.duan@intel.com>
 <e9b75cf0-49f4-4773-98c3-ec765c3adbb0@redhat.com>
In-Reply-To: <e9b75cf0-49f4-4773-98c3-ec765c3adbb0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7721:EE_
x-ms-office365-filtering-correlation-id: 9508ab38-49e7-414b-48f4-08dc5dda3927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?KzVKdkNuZUVGZ01aWUtGMDNRL2dNNldQbjlwSkJoQWJWRitTTjdmSzVIN3Bk?=
 =?utf-8?B?LzFhVVZXOU1MbGJTOGEwK2poS0ZBQVVnVXlaSzRHSFZ4WVRlRWZESVZYODhj?=
 =?utf-8?B?cktVOW5CamFZOXo0WVBTbW5hWVpxRnhWQkY4VXFhN3c2U3QxbVNncUYxSzRI?=
 =?utf-8?B?bjZVa3FJcFh1RGtJUFhqMzRRd2FRb0RzMlNnM2huaDFlVzJ1akNZU0tVSVhn?=
 =?utf-8?B?TWg1RkZPVlJmYjZsQ0YvSk1JNUc5eGFuUUpFSWx2eU1sSUR2Sjc0T2huMjEz?=
 =?utf-8?B?STNGa1VlelRSMEpDSUNubFFjWEw5UEZ6a1psR2M0UlBCY2tqbUUxYmU3WU9T?=
 =?utf-8?B?aHEzRG1ieVZqLytKWmQ1c3BJZm9heG91L3ZxZFoyRGE5c2VBZmhOK3pnTU9U?=
 =?utf-8?B?S3ZPQWR1UFVRNHhOd09BK09oQVBFY0UyOTRxb0p6U1hOSW1BanVMTHRYZDYw?=
 =?utf-8?B?TWNnWi9BVXVEUHFaZit6djIyRHgzT1hBTFVIaERhc3dQMEF4bEhFa0lJTlo0?=
 =?utf-8?B?YUszVjM0Sld6SnBuVC80cWF1aDdwRE95MWVEeUxmTEdGMmtiSURrMjArbjlG?=
 =?utf-8?B?RGJhUUxPZ2creEpPanhoZ3FYbzlGSkNYcWsrRjJTaUNieFJxKzJxeGJXaGxr?=
 =?utf-8?B?QnBnVzdRQzN1TFVGWlAwZlFpcFRZVFF5VDQ3cEsxekI5Sk91ZU51SE5rM1dR?=
 =?utf-8?B?a0VLemg2L202T2VoZUxWRDJZTFdUdjdud1FoRnFTWmFQOTVDVjVmZkp0eU5J?=
 =?utf-8?B?ZlZpcXVRV1JwdzNsY2JMeHpVaUs1b01QU0ZUNTgyQWxoczZJVzlKZnFNL0pt?=
 =?utf-8?B?ZW4zcHRyNnUzUHQ3ODFxZWhTTi94bVF5R2RoVG5vY2QrUXc4K2RUTjc2clNr?=
 =?utf-8?B?UlhOeDJ6RUttSUtDWG9LeitETjc5bnczQm5FSVNUb2MzMThtdzBWTitGVG9X?=
 =?utf-8?B?eU5XMnUxaFFsaldDVnhRWnBra3Y1MjVLQWhOQXBGeVptS3BYb2pQY0hzUVdS?=
 =?utf-8?B?WWU2SmZIZTR6TkQ3NjJENDVyazJGbHhJbTVCNHZWS1Nad2N4T3lmSEVpaEo0?=
 =?utf-8?B?eWFjVURiSldlMWRuc3pGQTduMlRDYVVVdjBrd3U2amp5RHhSSjVxRkJ2NCtw?=
 =?utf-8?B?WktjNWhCTi9wSXpNVm1KLzZLUTBGVjl6TmNYeEE4RGpTU3RUQlNiczlESWxI?=
 =?utf-8?B?d2RpMWlmUEc1SStnekVYdjdJWWIrVktBc0tCS0ZiWTZRUWhoUVhQbkNlcldG?=
 =?utf-8?B?VVA4eHpqVzJCanZhU2s4RzdXZzZXMTVTYTIvYWJIV3Y2WWEzbWlYU2NYTWlN?=
 =?utf-8?B?elVybTBuQVVZTEdLVEVvdHJTZ0Y3K2dHRUZsNDdIZElnZmt2eHNxd2U3OWZY?=
 =?utf-8?B?blh0TzVGWkljdDVMOUlVYWRzeEZiUVdCSjBJb3RaY1pKdmxmSmw0UHZNV0Ry?=
 =?utf-8?B?dmNVb0MwMFg3VkJabXZCV2RLMmhkVGhDVjJ5YzNsdzBCTUxZVEVZN3ZDUjl6?=
 =?utf-8?B?bWVVdkZ1ak5Iems3VnZVdjFxSFFCYlJWWmJLTlY0ZURmb1MzeGRIL0lkQ3kz?=
 =?utf-8?B?NGdNVGJsMkJKZGRrZEJRU3g4N0ZZckZRMTQ0bmlyaUdOK0tGUUwxTDV3UmZ2?=
 =?utf-8?B?alVjZ0FoV2QrWUR2RjhPc3RNQXFpZmtNY1UyYkZSZm50RWJPSGxiTmdmTWZD?=
 =?utf-8?B?WUdMbUVGOUlKNDNYOGljaHlHUzRGQURyUU12ZW1wcmhtZzk0UjJPM3hJNXVF?=
 =?utf-8?B?NkEvTTF0M0N0cEp0WlhWTkNNdVg1Tkc2azJLeXpNY0JqUUJUZGUrNjdPeVNk?=
 =?utf-8?B?QUtvNVZGTENDS3dMZHV6dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkRCV29LV2x4d1g5Vm9vK2xVRWRQVG1rV3d0NkxSanAyN2gyVERzQWloTUF4?=
 =?utf-8?B?SW1BaWQzSExpQU41eTZONXFRYzRNcHo3dHdtU1hMcGh5RWs4WlNGQ2N6K0FE?=
 =?utf-8?B?R0hBZDFGVzJjM3k2dDRweTRHSm1CQmNRcnpQUGpaODIvbUdVKy9nc0pRZlJV?=
 =?utf-8?B?QVdvWEtqbmdxVldiRTFMU1FyekFhcEIvY2l2ZGdxVnZUOW56ZXlMREhiRytm?=
 =?utf-8?B?SHJObTJyL0V6VURyNHFnbmV0dUZ4ZkxjVnpnZVlZRFZKREZVbVh6MnNLNitq?=
 =?utf-8?B?NkRIeTVYMTh2VmxRU0RwNGtTVzBaQjBjN0FSdXpPd0VVanYySTRrSzZ4bkJl?=
 =?utf-8?B?Y09lZXBKNUVJekRvK1VZSWdnQTcvRnZzWDVWWFN6eTRGenZYT2tmRlZXd1FJ?=
 =?utf-8?B?NTNYSVRXRVV0VU9NVU9MOHZIc0hZaXBoamNuZWZGa1hzbENhQ2E3Q09RRlUy?=
 =?utf-8?B?VEpnRGpiWCsxU3ZIV3g5cXVnalQyRFFjV1dkWGNSUkFjbGx6TkQva0MzMlMv?=
 =?utf-8?B?eVNMRTFzV0x0UVN0R0ErUkRwa1ZrRGx3YjUwb1F0K0kzSkdOMHFRRUk1WUN4?=
 =?utf-8?B?UWtSWG82WHgvUUNaczBQZGw0Q0FkTWhwQXdIeXh6VDBSYnVna2lmTGVMTnBT?=
 =?utf-8?B?dHdyZEwyS2JEbzhUMjJTMUt3YncrZ2hZSXRUdHNKcXoxMVdlWWZWVW8xOHg5?=
 =?utf-8?B?a2d1TXUwQnc2OU1leXdNdFhGQ29IWWJGV2ttSUZBVFFUUjJEWGwxNnpEMEtm?=
 =?utf-8?B?VlRybnJxR1MwNlU4N21oTGQxOUF0Njl2YVgwV2Q1ZVI0TXZhblFJelVPeTdP?=
 =?utf-8?B?UW9lQmNab1hsWjNFeldlZmFkYzFudWZ0TnZidkZYbW1QWjdKeERvczF2N1Nv?=
 =?utf-8?B?WjNySVdiUXBSV05jS2Q4WjltQ2NsRmRoNm1GQWFhM25YZlhPSzF1Zk5PUC9V?=
 =?utf-8?B?SEV2U3QvUjAyb3Y2TzRjNTVXbHhKaGp6aWt5eFUzSVUvTWQ1WHh3dVg0UTBK?=
 =?utf-8?B?Z0w3WUhjQThtbGQ2TWorbmNiVTl3RnZJMUJES3hSaEE3YXZpdFg0TTZYeWxj?=
 =?utf-8?B?amdFSGpNcVBBeHB5SWF6L21RL0pSaGhuNzFjc1FZMXJ1dVllM0YrY2Zxamk1?=
 =?utf-8?B?ejYrVEZqSHBjcjVsaTYrVUJoRTNoZFBScVJ3UXFCSTlQZWJSUTIvV3FIZ2NI?=
 =?utf-8?B?aDFnaG9UeWQwNStzRE91dnZ2alJRUXAwaG9xTW9zeGhFdHdBVEluVTRiMG1Z?=
 =?utf-8?B?L3NJdzR6eGE1aWlyRXdmRHFvWHpBRW9oZUdTcE5EeGtWY0N6eDJRbVhuYjVh?=
 =?utf-8?B?cG5VVUpNK0pmam9XTFZlNlJWbG02azVPUytJUTQxdHcxY21yWW9RMDd3Tmth?=
 =?utf-8?B?YTVGZitaR2FPcjdDdldBTHZqakRBUXdrKzg2bERLWTVRY0ltMG1HdDUyQ2Zj?=
 =?utf-8?B?UzVHK1lzSmkvbXhUeUtsNWl4VUdVNERJN09tb0p6WEVVTGJuWjdVSmV3R0N6?=
 =?utf-8?B?UUladDBwaW5hM3VmbDFDdFJmY2tjeFZvb1JqditWV1JTTnFOZ3FqQTVRT3p1?=
 =?utf-8?B?YXhQOGFJb0F4WUs0L0J4S21HeWhzS2Fxc0lJdEJGaEQxMnlmcnRKWGhneXFp?=
 =?utf-8?B?cWNINzBDNjhaRmYvRU1RNCtQNDNwUStSVTlYaFpXYy83MmlDUVI3dkYrVFdQ?=
 =?utf-8?B?TVJNeVIyc0RVdy9nd3pzUU1OWWpUQ1l1YnNVa3NubmgyOUd5L1JuZ1VzSmtK?=
 =?utf-8?B?TjFIdHoyRm93dDc4R1d1bWZXR212YmF5OFQreWZlUzkzYTlSNzdBT2Y5MFJh?=
 =?utf-8?B?bEZpVHdoc3NHNnRGbWNGcnNqWUpDeUVEYkU2T1JKeTJuMm1CWkMzY0ZNZlQv?=
 =?utf-8?B?aXpEeWpXY3VXVWVXU1VzVHZBMUptNVRUTXFXWWpYRUl6MnNxc0FIRkR1TFdV?=
 =?utf-8?B?Z1F6UlNhdEZWdEdudGFSd2VQMGlFMnh3MWxLV3NoWUhqZUxNa1pseVE5M2Ro?=
 =?utf-8?B?dmkwKzV6ZXRadGNFWGR2enhDUXJ3dTBCRVVEcE1yVDlrTEp5UzZQcXFqNHdN?=
 =?utf-8?B?TDJyS0RwSUlTVWlKa0gyVW9Od2hydGFTcWdycjJTNHlqZmU3b3lLMi9ZTFZG?=
 =?utf-8?Q?lvO8HVMZGd/0z674grRIefrK5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9508ab38-49e7-414b-48f4-08dc5dda3927
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 05:58:22.2658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjsu7JmK6QL2kbsrh3Y5T19jg8bTb/60982Q1mQkVVIR8RWSWgtOxbE7mR0D4cZ+uqqSbvRQXpfwnvH017PSYtxKmve/pxa9kvvmx7you9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7721
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDA1LzEwXSB2ZmlvOiBJ
bXBsZW1lbnQgZ2V0X2hvc3RfaW9tbXVfaW5mbygpDQo+Y2FsbGJhY2sNCj4NCj5PbiA0LzgvMjQg
MTA6MTIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gVXRpbGl6ZSBpb3ZhX3JhbmdlcyB0byBj
YWxjdWxhdGUgaG9zdCBJT01NVSBhZGRyZXNzIHdpZHRoIGFuZA0KPj4gcGFja2FnZSBpdCBpbiBI
SU9EX0xFR0FDWV9JTkZPIGZvciB2SU9NTVUgdXNhZ2UuDQo+Pg0KPj4gSElPRF9MRUdBQ1lfSU5G
TyB3aWxsIGJlIHVzZWQgYnkgYm90aCBWRklPIGFuZCBWRFBBIHNvIGRlY2xhcmUNCj4+IGl0IGlu
IGhvc3RfaW9tbXVfZGV2aWNlLmguDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL3N5c2Vt
dS9ob3N0X2lvbW11X2RldmljZS5oIHwgMTAgKysrKysrKysrKw0KPj4gICBody92ZmlvL2NvbnRh
aW5lci5jICAgICAgICAgICAgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+Yi9pbmNsdWRlL3N5c2VtdS9ob3N0
X2lvbW11X2RldmljZS5oDQo+PiBpbmRleCAyMmNjYmUzYTVkLi5iZWI4YmU4MjMxIDEwMDY0NA0K
Pj4gLS0tIGEvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gKysrIGIvaW5j
bHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gQEAgLTE2LDQgKzE2LDE0IEBAIHN0
cnVjdCBIb3N0SU9NTVVEZXZpY2VDbGFzcyB7DQo+PiAgICAgICBpbnQgKCpnZXRfaG9zdF9pb21t
dV9pbmZvKShIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIHZvaWQgKmRhdGEsDQo+dWludDMyX3QgbGVu
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+
ICAgfTsNCj4+ICsNCj4+ICsvKg0KPj4gKyAqIERlZmluZSB0aGUgZm9ybWF0IG9mIGhvc3QgSU9N
TVUgcmVsYXRlZCBpbmZvIHRoYXQgY3VycmVudCBWRklPDQo+PiArICogb3IgVkRQQSBjYW4gcHJp
dm9kZSB0byB2SU9NTVUuDQo+PiArICoNCj4+ICsgKiBAYXdfYml0czogSG9zdCBJT01NVSBhZGRy
ZXNzIHdpZHRoLiAweGZmIGlmIG5vIGxpbWl0YXRpb24uDQo+PiArICovDQo+PiArdHlwZWRlZiBz
dHJ1Y3QgSElPRF9MRUdBQ1lfSU5GTyB7DQo+DQo+UGxlYXNlIHVzZSBDYW1lbENhc2UgbmFtZXMu
DQoNClN1cmUuDQoNCj4NCj4+ICsgICAgdWludDhfdCBhd19iaXRzOw0KPj4gK30gSElPRF9MRUdB
Q1lfSU5GTzsNCj4+ICAgI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jb250YWluZXIu
YyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+IGluZGV4IDQ0MDE4ZWYwODUuLmJhMGFkNGE0MWIg
MTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2NvbnRhaW5lci5jDQo+PiArKysgYi9ody92ZmlvL2Nv
bnRhaW5lci5jDQo+PiBAQCAtMTE0Myw4ICsxMTQzLDMyIEBAIHN0YXRpYyB2b2lkDQo+dmZpb19p
b21tdV9sZWdhY3lfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpDQo+
PiAgICAgICB2aW9jLT5wY2lfaG90X3Jlc2V0ID0gdmZpb19sZWdhY3lfcGNpX2hvdF9yZXNldDsN
Cj4+ICAgfTsNCj4+DQo+PiArc3RhdGljIGludCBoaW9kX2xlZ2FjeV92ZmlvX2dldF9ob3N0X2lv
bW11X2luZm8oSG9zdElPTU1VRGV2aWNlDQo+Kmhpb2QsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwgdWludDMyX3QgbGVuLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9y
ICoqZXJycCkNCj4+ICt7DQo+PiArICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2ID0gSElPRF9MRUdB
Q1lfVkZJTyhoaW9kKS0+dmRldjsNCj4+ICsgICAgLyogaW92YV9yYW5nZXMgaXMgYSBzb3J0ZWQg
bGlzdCAqLw0KPj4gKyAgICBHTGlzdCAqbCA9IGdfbGlzdF9sYXN0KHZiYXNlZGV2LT5iY29udGFp
bmVyLT5pb3ZhX3Jhbmdlcyk7DQo+PiArICAgIEhJT0RfTEVHQUNZX0lORk8gKmluZm8gPSBkYXRh
Ow0KPj4gKw0KPj4gKyAgICBhc3NlcnQoc2l6ZW9mKEhJT0RfTEVHQUNZX0lORk8pIDw9IGxlbik7
DQo+PiArDQo+PiArICAgIGlmIChsKSB7DQo+PiArICAgICAgICBSYW5nZSAqcmFuZ2UgPSBsLT5k
YXRhOw0KPj4gKyAgICAgICAgaW5mby0+YXdfYml0cyA9IGZpbmRfbGFzdF9iaXQoJnJhbmdlLT51
cGIsIEJJVFNfUEVSX0xPTkcpICsgMTsNCj4NCj5UaGVyZSBpcyBhIGNvbW1lbnQgaW4gcmFuZ2Uu
aCBzYXlpbmc6DQo+DQo+ICAgICAvKg0KPiAgICAgICogRG8gbm90IGFjY2VzcyBtZW1iZXJzIGRp
cmVjdGx5LCB1c2UgdGhlIGZ1bmN0aW9ucyENCj4NCj5QbGVhc2UgaW50cm9kdWNlIGEgbmV3IGhl
bHBlci4NCg0KU3VyZSwgdGhhbmtzIGZvciBwb2ludCBvdXQuDQoNCkJScy4NClpoZW56aG9uZw0K
DQo+DQo+DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQo+DQo+DQo+PiArICAgIH0gZWxzZSB7DQo+PiAr
ICAgICAgICBpbmZvLT5hd19iaXRzID0gMHhmZjsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBy
ZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyB2b2lkIGhpb2RfbGVnYWN5X3ZmaW9f
Y2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+PiAgIHsNCj4+ICsgICAg
SG9zdElPTU1VRGV2aWNlQ2xhc3MgKmhpb2MgPSBIT1NUX0lPTU1VX0RFVklDRV9DTEFTUyhvYyk7
DQo+PiArDQo+PiArICAgIGhpb2MtPmdldF9ob3N0X2lvbW11X2luZm8gPQ0KPmhpb2RfbGVnYWN5
X3ZmaW9fZ2V0X2hvc3RfaW9tbXVfaW5mbzsNCj4+ICAgfTsNCj4+DQo+PiAgIHN0YXRpYyBjb25z
dCBUeXBlSW5mbyB0eXBlc1tdID0gew0KDQo=

