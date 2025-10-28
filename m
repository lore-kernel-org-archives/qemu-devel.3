Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67607CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDdeB-0005Fo-GL; Tue, 28 Oct 2025 02:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDde8-0005Ff-8u
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:57:32 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDde4-0007a1-Tx
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761634649; x=1793170649;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Oa3ge+dvzQJv6kgNGKB9EWJ4elWC3bTUOJTWtjrcWOc=;
 b=Dv5ajVA9vFLAb8kWhDtTLw7agUGk9WnrA5vwfhl1Vu5jQv8uhh1qA3ZO
 86fTKwQ6237cq2/hU72M8n48zsLsGN5Ngsm8cC+O1KSwoaHI8sG+CGK0a
 8MgI86hl0DiSq2FgDHvroLR32M+rD7kGB+Rorl7W6GoFNJvceS+ZG8jAh
 bov5ngq/IDpfUvGYlKP0ahRy9Kx++Z9kwQCynOlevKevKJaR2iHoi3O8S
 Ho8FlIkOAp/7QYWGCqIV9+X0jptQFBKjAPqlNGOpuOKREeJlisIAhtj44
 Zw4O68WES+GwDNe8ER/HCk4xSt0tJqaJ+gmOueb/P6QYz0Kloi4l9fuVX Q==;
X-CSE-ConnectionGUID: dclpN7uMT42OLpZuWXA/xw==
X-CSE-MsgGUID: eCkSSttwQJiWaT46rvcEMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63821156"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="63821156"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 23:57:24 -0700
X-CSE-ConnectionGUID: to56K/EFSHWEjA3Pe90ToQ==
X-CSE-MsgGUID: qqhrBMNSTKu383xLTzUlRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="186018267"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 23:57:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 23:57:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 23:57:23 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.30)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 23:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVQKbEFV0D4Vn44fKeQp6KQTFP9TnlGBq8ttnMwDhADe+pTw6IjXgBxHkMMijeyv78TZMNadJA92e57YaZb+GJoAFMJkxjQbphdj96GPto99Kx5GWTkvq0bPaXkMkEERW6NzcFBjz3TapOQi8hcBT5kfP4uwnGqjMdJGk1LtRJCvHR/PQRV+7iwG3Hngbevds8qDASHFtD8a1HlsFUC9vcyMOU6wmfJqba2QlgePhEH7Oro2JAhepE/cfGASw1ZPgjueb+oGlOLktRC3/Jz2OdgAC6ZO3MMD/OVkk7XhBkXbr9/TOhs7NHXdgexI8IJVoN5eBsyBuGn+Y+uX96ANhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa3ge+dvzQJv6kgNGKB9EWJ4elWC3bTUOJTWtjrcWOc=;
 b=VOyc7s3wNsO0JQq+jgRReLBGeNoWD3jQj3E/BbB6zOG+SWqjDpl8VaijpJPhAsZhAXAIY6+Bqo8zVKcN2qAPUWoheGN5ouyCQk7PEEG7H0A0vtk+y1Unil6czKjOlCT1CxvUEquul1Q7wEeSC9DIEHYPHMLmbman8LvASNeAxT7s6wzo4ZxVGGWKXYrpcpKRBfiAd803DiOZbb43lwAT8kfhP1jIqq5SFUAJRVluZuteaJcoOjbM0Okb8wW+gSEctpdL+o3pyrFeUPWJ+vGjgE3AKCM1RD/LdJu+DbF3GDdASAgMgYzdBrtfA6ZnY9u7NCRtc2jUqU7+V3/ZBXfltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 06:57:21 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 06:57:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 05/23] hw/pci: Introduce pci_device_get_viommu_flags()
Thread-Topic: [PATCH v7 05/23] hw/pci: Introduce pci_device_get_viommu_flags()
Thread-Index: AQHcRMJ8phqb4QJF4ESnDa7+/bGyirTRiwCAgAWZuSA=
Date: Tue, 28 Oct 2025 06:57:21 +0000
Message-ID: <IA3PR11MB9136877A703966CA28C91D1792FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-6-zhenzhong.duan@intel.com>
 <8dccb89a-f41b-4ae0-9f9d-f39f609766ee@redhat.com>
In-Reply-To: <8dccb89a-f41b-4ae0-9f9d-f39f609766ee@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB7366:EE_
x-ms-office365-filtering-correlation-id: a3b23770-f240-4e71-3073-08de15ef3df8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?aWZuVTRkc0tNQXJYQXV5eDF1bkd0b1lZbjJhQWowak5IR2R3VjJ2ZXQwQUZG?=
 =?utf-8?B?cmRhZndkcDBhdVQyczQ3NXR1cXFwK0toTmp5ZklobUY0NFI2MHp0UG1hR1F3?=
 =?utf-8?B?cG9Hc0RVeGJpU1Bab3c1eVNzM0lQL0NRazBQVnorQWdRdjN3Z01pVXVsS2xq?=
 =?utf-8?B?WDByc0dYd1hmZEpmTzVxOWlqbVpiYks0VDBrT2k4RWkrR3A2UjRiRDk0cUx6?=
 =?utf-8?B?VjMyUFprUHR4MU1CMTkycVVUcnI3Nk9vaDBCV2R5U3d5NGRDVCtMZ1NWWDRk?=
 =?utf-8?B?VkMzWjJPVU9CSU80akE2RmNFL3dSdk43RmFJM0FtQzlMcHNOQkpLMmppK1M2?=
 =?utf-8?B?aUp5amVvYk1TR2ZsbjZZK2NPc2VEWW0wdlVpT3dFQ1N1OW9UR1NPNDdTU0VW?=
 =?utf-8?B?WjVTblNFb3Z0QWt2ZnVhZ0pwL095MWdLTnZ1dENuWmlZOFYyU0djQ0k1bXhi?=
 =?utf-8?B?VmJXY1lKaDJNWlZBcS83d0huUFlTOEl3VHZTNnlNTmEvZWFuWUJ0d1hEYUkr?=
 =?utf-8?B?MnFwWFdscFU0ZDBObmliSFZZZDgrdGpQd2x2bUpDWTNld01NRWI3Qi9rUHJE?=
 =?utf-8?B?WUlpUmNFVWM3b2VkTCs1Y3F0Q0JadDd4TjRLV2ZmTVByaHlPdENTenRFYktK?=
 =?utf-8?B?cmZmOEg4R0pVdXdIaWlmRGRkbXFjUVErR3U5ZW9VM0NCSFFlTy9FejJxTjdW?=
 =?utf-8?B?NkwyVWRjcWNpdnl3OVFEdUJMWnBFbm1Gbk1RektnUnhmTGJENTZMcDF3Mm85?=
 =?utf-8?B?Yy9CUUx6Y1ZYa3MzTmFWWFFYOTk0WHdxVWk3K2tOWE8ybmlibUNFdUZGdTZ6?=
 =?utf-8?B?akRGYWV4VFdtVHRNcm5jWTEvaSt1dUI1NjNaZ0RyUHJkZkVzeEhhdXFFcWZL?=
 =?utf-8?B?SWpOOTl2Zmg5bWRrYWR6b29ZR3o3UzNsaHhDZ3JGV3M4YnlTRVBPNi9NcWtj?=
 =?utf-8?B?NHFpNXQ3VFpMTXJqdWwyMnJsQWFucWg3dXNnUTZmRGRtZnRmVThXc0JYWnFF?=
 =?utf-8?B?QXN5ay9GOFJXbmRUZ0x3YjQyeThleERZQVNyTmVxMEFKaVN6UkNHQWJQRWNo?=
 =?utf-8?B?dmUyOEdNOGlLVm9vOGhWRDhHUnJEWFp4UndxRzMrcUFtcUlYQXorT1ZBTUJq?=
 =?utf-8?B?YkI2Tzg4LzNvN0k3L240Ylh1Zm5DSVg5MDk3THpWVURrVHZUVlBHQThTcHVF?=
 =?utf-8?B?TGV6ZC9NOFlDYWVTSmkxQ0JIZkk1OTl4Mk5pVjVlU2J0WHFlTWxGQzVrbU1C?=
 =?utf-8?B?Q2czNGU5Q2FhMVI4UTAxcXNHY040Rm1qeTl1Q1Z1T2I4TDdHb1ErTFlzNExq?=
 =?utf-8?B?WGo3RUpzY1VGc0JtZUUyWUk3ZU9EYkFxMXgrNmd0Q3RjbHc2K1Q3WTk5VXJ3?=
 =?utf-8?B?bEFORW8rY3dJK0ZGTHZGQWs3bE9sZjJpTjFtZGdiZkhaU1FxaVJUemo3NFYx?=
 =?utf-8?B?aWc3bmRvdGxNaXdzOWp2ODFIZ21aa2FXTnNpWFVUcm5DSXlWQ0dMazFsc2hm?=
 =?utf-8?B?Z0lROE4wellLS2U1RmJQYXlsVXZnaEtvVWlCZjNiSnFXVWZhRW8yTlNtSThX?=
 =?utf-8?B?QzlZbkc5bDdHc2lyWUxxcU53RkhVcnY3N1FBSHU4Z0lXU1B3cjg1VXovemVo?=
 =?utf-8?B?aG5IeVRhQnU1anJzcEtCMEsrZ1R1V1ZzbWRKcldTVysrRjkyYWc4THpqcWZO?=
 =?utf-8?B?RnNSZXJSK2lrNzlFZ0VTNFh0bUhUby96bmI2cWI3aFpGSE03RnFYTTM4TXJD?=
 =?utf-8?B?c2xxK0g5d0xiL3IvbDF6ZzhNUXFCT3hWdmNad2FVU3NQekN2dlNhYTdNNXcx?=
 =?utf-8?B?SGxOZkRHSUVodDU2dDZxRS9tQTlFdnJvUE1NU1hzQU1EQkl1RFgzTWVCU2FE?=
 =?utf-8?B?ZGVWcTVZUDlMaEVKeDhLZEljK1VFVzlvZ29mdjdCUGhQMU5HMGVNTXFXMjBV?=
 =?utf-8?B?d2NNenVVazN3ZGNkYzhqbWIyckg4bkVVa3A1c0VJVU1OTlprL0pjTXBON3Nj?=
 =?utf-8?B?bzRub3hOMUtmN3FNMnlmbG5KZDZuaTVHUnNIRXlURlR0NjBZNlhHL1VoRUJi?=
 =?utf-8?Q?sV1fNu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUtIUTIzR3pZbE9KMWRYd2lFUFZPcWRtbnMvVnJsSU9Lb0J0a0RVTVA4OWFv?=
 =?utf-8?B?N2RVWVczOEsvK1ZwZmhYMnJKQzBRejhVSm9uY0JMWmJMZzlUWFpGdko3TkNO?=
 =?utf-8?B?NzlLUHZUYis2dGhTVGNEanhZV3NqeTRvOGJmM3k2ZlBSRi9RMjJicGY1STZZ?=
 =?utf-8?B?UUxSYVk0S2N4UExBdFliUzBBc3ZhY3Q2VEQ2ZWZGZ3d5Zk8ydW9hSm1NWjRB?=
 =?utf-8?B?S2FLWDhLOGQvNFVaekFCL2UvdHpCL09iamMwREltOTRlSHpUZVJiL2M2OGVY?=
 =?utf-8?B?TEcvTjMwU0thb2NMeEEzRlBPUHVMNEVwS1RaK0V5VGJCYUkxT3RKU0JUQWp2?=
 =?utf-8?B?SUI1Qjhia1IySXlFU0ZaTFZUZVRsNzM5UmFqZ2hYVzRXSWZJZTZzUms1djhp?=
 =?utf-8?B?SUFpam5qL1RMbUZ6Y2U0QUdlZ0s2UDY0WE5YbDUxcWVGVHc5S01wSDNBUzBL?=
 =?utf-8?B?L0crZlBrUm44Si8xM0xqOE83UGpsSWJuV3UrWmkyQnYxZ1VJZFZMbWRNeUJ2?=
 =?utf-8?B?cS83dVl5REpIcWRYVlFxakFyM1BkNG9XOFVXSlQvQzdncXBIY1R1Q3VFdGdQ?=
 =?utf-8?B?THRBa2ZnTlpRYnZienIyK0I4UE1qNTJRZGVYTUNHeGdTNVkzSUlPNXNXeGY3?=
 =?utf-8?B?OWZCbnlSVjQybzZDaW1Hb1l5UjJFbjRtbHVOUTZyeFhXaVg3MVFzeXRGOUhj?=
 =?utf-8?B?YUxZMDN1T0U1aVlQYWxiSGpvSkJDaWJCOUVFZVFaY3ZWSkNudTNRdXNJbDVm?=
 =?utf-8?B?dERIbnRZZXNLOGJpd0hlTy8yQzExenhPS0kwanA1eDFMVFMzNy9FOG1wSmtw?=
 =?utf-8?B?aSthRS9KN241bTlkSnNlUVRrREtrQjhhYWJTTzlScVNZVWdJcTRRak9pUkE2?=
 =?utf-8?B?MXVvWWNLK05ueDNrYjFtY1QrYkJ5YlRGT0JnY0JLQzZJTlYxODFwcUUrdm9n?=
 =?utf-8?B?dVQ5NjNQUWthdlNrL2F4blZPRE9NbmNlOSt4WkJ3RFZQd3NwNUlsbys3RHY1?=
 =?utf-8?B?aWN2b2V4ck8ycEhTRGVWWi9VTExIS1JrcXVJMi9vUnR4aVBFdWpNMVFrUzgw?=
 =?utf-8?B?WW1BSmZHTnZySTlpZm5qaVlCeVh3NVIvQ1krOE8yU0dUbkZzT29hdkIreTB1?=
 =?utf-8?B?NzJ3ekZnSkI1a2JLcTJ4MHUwNWdRd3lPVDN0QThrTWVyblZmV2xRKzB5L1c5?=
 =?utf-8?B?MW0vVjY0VkhwN01Ic2hKMVkzWU1sRGdWdVNnMXVadFZKa1NnZXk2V1QrVk1v?=
 =?utf-8?B?ckF0Vm11RFJDZ0taWTdTV1FlUXJNSXQ2dTg3c1M3cTZKOTRidWlEcTB2OHor?=
 =?utf-8?B?QkNqZTdxQVhJbWk3RnkwR2VlYW1idEk1L0NIYllTT2g4Mi9NY1FkSmxwck5m?=
 =?utf-8?B?NkZLS05NTXd2cmV6d2lvOEZaTHNzR3BQVFdwVnd4TXgyd1RpUlVuS29QUnAv?=
 =?utf-8?B?MjFaZGdjZklNL3JmTEN0dXZkNUl1QlkvL0NROXFOY2lJdjZRTVQ1SHZkTEJy?=
 =?utf-8?B?a1JYRjk4REtzL0M5SnU5MGlvV2FhaDJETUZFbjlWeVZlcEFvZ0xQNjRSVERw?=
 =?utf-8?B?VmlySVNOOE81N0hoSUVHeEVXaUR3RHA1V2htem9tYlRXc2h3djJObDc2aGtC?=
 =?utf-8?B?SWlKeklOOHRHYmw5Vm9oYjhCWmtRMVBsMzF1NDBpL1FrUlhmVVpsNzRrbWY3?=
 =?utf-8?B?a0YyTS85OTQrQ3lTM2JrT093anNjZUthbTl5UWd1aVluZXBoeDQ4bk1LZlZJ?=
 =?utf-8?B?cVNRSW42Ni9XcmcwdEl1aDZuNUIrOStMblptZmNKaXlvZWR2QXQzL1ZGRm1t?=
 =?utf-8?B?T3pXRTdYV3NsN0t2Q0tCVE1CY1F5bTZoR3BzSkJWSFR2U1RmRTkyZmRnb1Bj?=
 =?utf-8?B?VXdydlVtN3ZaUjVmeTZMNUdiN2h1dWI3NlR1NUZkTnF2ZFJVbG1oZ1FHcnNx?=
 =?utf-8?B?bjMvRXN0TnYzQjVUVVplWGE0ZjBQSkpHcjFra3Vna2xyL2xZS2RzUjIrOVRz?=
 =?utf-8?B?NnJmbitTenIyVFhuVk1ERmhXY3hWaXZIb24vbnFLckVhdG5DTTZYVkkwRGM1?=
 =?utf-8?B?ZDB0VGUvSGIwUlhQVmFtL0NVM0RBT3Z3QnBmcmpIYzAvbWRKN1pTUjN2eVlm?=
 =?utf-8?Q?+3+GOtXRBVnO+HDnTSTaSr91D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b23770-f240-4e71-3073-08de15ef3df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 06:57:21.4163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XF927S9ZldAPiAwIGiFk78SiZvhJ0GCx3/Xv5C93TLmyvdYLLl91/b1Wy60GvCqtcGe0H44DrngUuhnF5wLRANnMERogBtsKf/iGQ7VTQBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDA1LzIzXSBody9wY2k6
IEludHJvZHVjZQ0KPnBjaV9kZXZpY2VfZ2V0X3Zpb21tdV9mbGFncygpDQo+DQo+T24gMTAvMjQv
MjUgMTA6NDMsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSW50cm9kdWNlIGEgbmV3IFBDSUlP
TU1VT3BzIG9wdGlvbmFsIGNhbGxiYWNrLCBnZXRfdmlvbW11X2ZsYWdzKCkNCj53aGljaA0KPj4g
YWxsb3dzIHRvIHJldHJpZXZlIGZsYWdzIGV4cG9zZWQgYnkgYSB2SU9NTVUuIFRoZSBmaXJzdCBw
bGFubmVkIHZJT01NVQ0KPj4gZGV2aWNlIGZsYWcgaXMgVklPTU1VX0ZMQUdfV0FOVF9ORVNUSU5H
X1BBUkVOVCB0aGF0IGFkdmVydGlzZXMgdGhlDQo+PiBzdXBwb3J0IG9mIEhXIG5lc3RlZCBzdGFn
ZSB0cmFuc2xhdGlvbiBzY2hlbWUgYW5kIHdhbnRzIG90aGVyIHN1Yi1zeXN0ZW0NCj4+IGxpa2Ug
VkZJTydzIGNvb3BlcmF0aW9uIHRvIGNyZWF0ZSBuZXN0aW5nIHBhcmVudCBIV1BULg0KPj4NCj4+
IHBjaV9kZXZpY2VfZ2V0X3Zpb21tdV9mbGFncygpIGlzIGEgd3JhcHBlciB0aGF0IGNhbiBiZSBj
YWxsZWQgb24gYSBQQ0kNCj4+IGRldmljZSBwb3RlbnRpYWxseSBwcm90ZWN0ZWQgYnkgYSB2SU9N
TVUuDQo+Pg0KPj4gZ2V0X3Zpb21tdV9mbGFncygpIGlzIGRlc2lnbmVkIHRvIHJldHVybiA2NGJp
dCBiaXRtYXAgb2YgcHVyZWx5IHZJT01NVQ0KPj4gZmxhZ3Mgd2hpY2ggYXJlIG9ubHkgZGV0ZXJt
aW5lZCBieSB1c2VyJ3MgY29uZmlndXJhdGlvbiwgbm8gaG9zdA0KPj4gY2FwYWJpbGl0aWVzIGlu
dm9sdmVkLiBSZWFzb25zIGFyZToNCj4+DQo+PiAxLiBob3N0IG1heSBoYXMgaGV0ZXJvZ2VuZW91
cyBJT01NVXMsIGVhY2ggd2l0aCBkaWZmZXJlbnQgY2FwYWJpbGl0aWVzDQo+PiAyLiB0aGlzIGlz
IG1pZ3JhdGlvbiBmcmllbmRseSwgcmV0dXJuIHZhbHVlIGlzIGNvbnNpc3RlbnQgYmV0d2VlbiBz
b3VyY2UNCj4+ICAgICBhbmQgdGFyZ2V0Lg0KPj4NCj4+IE5vdGUgdGhhdCB0aGlzIG9wIHdpbGwg
YmUgaW52b2tlZCBhdCB0aGUgYXR0YWNoX2RldmljZSgpIHN0YWdlLCBhdCB3aGljaA0KPj4gcG9p
bnQgaG9zdCBJT01NVSBjYXBhYmlsaXRpZXMgYXJlIG5vdCB5ZXQgZm9yd2FyZGVkIHRvIHRoZSB2
SU9NTVUNCj50aHJvdWdoDQo+PiB0aGUgc2V0X2lvbW11X2RldmljZSgpIGNhbGxiYWNrIHRoYXQg
d2lsbCBiZSBhZnRlciB0aGUgYXR0YWNoX2RldmljZSgpLg0KPj4NCj4+IFNlZSBiZWxvdyBzZXF1
ZW5jZToNCj4+DQo+PiAgICB2ZmlvX2RldmljZV9hdHRhY2goKToNCj4+ICAgICAgICBpb21tdWZk
X2NkZXZfYXR0YWNoKCk6DQo+PiAgICAgICAgICAgIHBjaV9kZXZpY2VfZ2V0X3Zpb21tdV9mbGFn
cygpIGZvciBIVyBuZXN0aW5nIGNhcA0KPj4gICAgICAgICAgICBjcmVhdGUgYSBuZXN0aW5nIHBh
cmVudCBIV1BUDQo+PiAgICAgICAgICAgIGF0dGFjaCBkZXZpY2UgdG8gdGhlIEhXUFQNCj4+ICAg
ICAgICAgICAgdmZpb19kZXZpY2VfaGlvZF9jcmVhdGVfYW5kX3JlYWxpemUoKSBjcmVhdGluZyBo
aW9kDQo+PiAgICAuLi4NCj4+ICAgIHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShoaW9kKQ0K
Pj4NCj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4g
UmV2aWV3ZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4+IFJldmll
d2VkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PiBSZXZpZXdlZC1i
eTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgTUFJTlRBSU5FUlMg
ICAgICAgICAgfCAgMSArDQo+PiAgIGluY2x1ZGUvaHcvaW9tbXUuaCAgIHwgMjUgKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPg0KPg0KPkhtbSwgd2h5IG5vdCB1bmRlciBpbmNsdWRlL2h3L3Bj
aS8gPw0KDQpJJ20gbm90IHN1cmUgaWYgaXQncyBiZXR0ZXIgdG8gcmVzdHJpY3QgaW9tbXUgdG8g
cGNpIHN1YnN5c3RlbS4NCkkgaGF2ZSBhIHZhZ3VlIG1lbW9yeSB0aGVyZSBpcyBpb21tdSBzdXBw
b3J0aW5nIG5vbi1QQ0kgZGV2aWNlcy4NCg0KPiBXYXMgdGhpcyBkaXNjdXNzZWQgPw0KDQpOby4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPg0KPlJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQo+DQo+DQo+PiAg
IGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBo
dy9wY2kvcGNpLmMgICAgICAgICB8IDExICsrKysrKysrKysrDQo+PiAgIDQgZmlsZXMgY2hhbmdl
ZCwgNTkgaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9p
b21tdS5oDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4+
IGluZGV4IDM2ZWVmMjdiNDEuLmQ5NGZiY2JkZmIgMTAwNjQ0DQo+PiAtLS0gYS9NQUlOVEFJTkVS
Uw0KPj4gKysrIGIvTUFJTlRBSU5FUlMNCj4+IEBAIC0yMzM4LDYgKzIzMzgsNyBAQCBGOiBpbmNs
dWRlL3N5c3RlbS9pb21tdWZkLmgNCj4+ICAgRjogYmFja2VuZHMvaG9zdF9pb21tdV9kZXZpY2Uu
Yw0KPj4gICBGOiBpbmNsdWRlL3N5c3RlbS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiAgIEY6IGlu
Y2x1ZGUvcWVtdS9jaGFyZGV2X29wZW4uaA0KPj4gK0Y6IGluY2x1ZGUvaHcvaW9tbXUuaA0KPj4g
ICBGOiB1dGlsL2NoYXJkZXZfb3Blbi5jDQo+PiAgIEY6IGRvY3MvZGV2ZWwvdmZpby1pb21tdWZk
LnJzdA0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2lvbW11LmggYi9pbmNsdWRlL2h3
L2lvbW11LmgNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi45
YjhiYjk0ZmMyDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL2h3L2lvbW11LmgN
Cj4+IEBAIC0wLDAgKzEsMjUgQEANCj4+ICsvKg0KPj4gKyAqIEdlbmVyYWwgdklPTU1VIGZsYWdz
DQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjUgSW50ZWwgQ29ycG9yYXRpb24uDQo+
PiArICoNCj4+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0K
Pj4gKyAqLw0KPj4gKw0KPj4gKyNpZm5kZWYgSFdfSU9NTVVfSA0KPj4gKyNkZWZpbmUgSFdfSU9N
TVVfSA0KPj4gKw0KPj4gKyNpbmNsdWRlICJxZW11L2JpdG9wcy5oIg0KPj4gKw0KPj4gKy8qDQo+
PiArICogVGhlb3JldGljYWwgdklPTU1VIGZsYWdzLiBPbmx5IGRldGVybWluZWQgYnkgdGhlIHZJ
T01NVSBkZXZpY2UNCj5wcm9wZXJ0aWVzIGFuZA0KPj4gKyAqIGluZGVwZW5kZW50IG9uIHRoZSBh
Y3R1YWwgaG9zdCBJT01NVSBjYXBhYmlsaXRpZXMgdGhleSBtYXkgZGVwZW5kIG9uLg0KPkVhY2gN
Cj4+ICsgKiBmbGFnIGNhbiBiZSBhbiBleHBlY3RhdGlvbiBvciByZXF1ZXN0IHRvIG90aGVyIHN1
Yi1zeXN0ZW0gb3IganVzdCBhIHB1cmUNCj4+ICsgKiB2SU9NTVUgY2FwYWJpbGl0eS4gdklPTU1V
IGNhbiBjaG9vc2Ugd2hpY2ggZmxhZ3MgdG8gZXhwb3NlLg0KPj4gKyAqLw0KPj4gK2VudW0gdmlv
bW11X2ZsYWdzIHsNCj4+ICsgICAgLyogdklPTU1VIG5lZWRzIG5lc3RpbmcgcGFyZW50IEhXUFQg
dG8gY3JlYXRlIG5lc3RlZCBIV1BUICovDQo+PiArICAgIFZJT01NVV9GTEFHX1dBTlRfTkVTVElO
R19QQVJFTlQgPSBCSVRfVUxMKDApLA0KPj4gK307DQo+PiArDQo+PiArI2VuZGlmIC8qIEhXX0lP
TU1VX0ggKi8NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2kuaCBiL2luY2x1ZGUv
aHcvcGNpL3BjaS5oDQo+PiBpbmRleCBiZGU5ZGNhOGUyLi5jZjk5YjViYjY4IDEwMDY0NA0KPj4g
LS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvcGNpL3BjaS5o
DQo+PiBAQCAtNDYyLDYgKzQ2MiwxOCBAQCB0eXBlZGVmIHN0cnVjdCBQQ0lJT01NVU9wcyB7DQo+
PiAgICAgICAgKiBAZGV2Zm46IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyIG9mIHRoZSBQQ0kg
ZGV2aWNlLg0KPj4gICAgICAgICovDQo+PiAgICAgICB2b2lkICgqdW5zZXRfaW9tbXVfZGV2aWNl
KShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4pOw0KPj4gKyAgICAvKioNCj4+
ICsgICAgICogQGdldF92aW9tbXVfZmxhZ3M6IGdldCB2SU9NTVUgZmxhZ3MNCj4+ICsgICAgICoN
Cj4+ICsgICAgICogT3B0aW9uYWwgY2FsbGJhY2ssIGlmIG5vdCBpbXBsZW1lbnRlZCwgdGhlbiB2
SU9NTVUgZG9lc24ndA0KPnN1cHBvcnQNCj4+ICsgICAgICogZXhwb3NpbmcgZmxhZ3MgdG8gb3Ro
ZXIgc3ViLXN5c3RlbSwgZS5nLiwgVkZJTy4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQG9wYXF1
ZTogdGhlIGRhdGEgcGFzc2VkIHRvIHBjaV9zZXR1cF9pb21tdSgpLg0KPj4gKyAgICAgKg0KPj4g
KyAgICAgKiBSZXR1cm5zOiBiaXRtYXAgd2l0aCBlYWNoIHJlcHJlc2VudGluZyBhIHZJT01NVSBm
bGFnIGRlZmluZWQgaW4NCj4+ICsgICAgICogZW51bSB2aW9tbXVfZmxhZ3MuDQo+PiArICAgICAq
Lw0KPj4gKyAgICB1aW50NjRfdCAoKmdldF92aW9tbXVfZmxhZ3MpKHZvaWQgKm9wYXF1ZSk7DQo+
PiAgICAgICAvKioNCj4+ICAgICAgICAqIEBnZXRfaW90bGJfaW5mbzogZ2V0IHByb3BlcnRpZXMg
cmVxdWlyZWQgdG8gaW5pdGlhbGl6ZSBhIGRldmljZQ0KPklPVExCLg0KPj4gICAgICAgICoNCj4+
IEBAIC02NDQsNiArNjU2LDE2IEBAIGJvb2wgcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2aWNlKFBD
SURldmljZQ0KPipkZXYsIEhvc3RJT01NVURldmljZSAqaGlvZCwNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+ICAgdm9pZCBwY2lfZGV2aWNl
X3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldik7DQo+Pg0KPj4gKy8qKg0KPj4gKyAq
IHBjaV9kZXZpY2VfZ2V0X3Zpb21tdV9mbGFnczogZ2V0IHZJT01NVSBmbGFncy4NCj4+ICsgKg0K
Pj4gKyAqIFJldHVybnM6IGJpdG1hcCB3aXRoIGVhY2ggcmVwcmVzZW50aW5nIGEgdklPTU1VIGZs
YWcgZGVmaW5lZCBpbg0KPj4gKyAqIGVudW0gdmlvbW11X2ZsYWdzLiBPciAwIGlmIHZJT01NVSBk
b2Vzbid0IHJlcG9ydCBhbnkuDQo+PiArICoNCj4+ICsgKiBAZGV2OiBQQ0kgZGV2aWNlIHBvaW50
ZXIuDQo+PiArICovDQo+PiArdWludDY0X3QgcGNpX2RldmljZV9nZXRfdmlvbW11X2ZsYWdzKFBD
SURldmljZSAqZGV2KTsNCj4+ICsNCj4+ICAgLyoqDQo+PiAgICAqIHBjaV9pb21tdV9nZXRfaW90
bGJfaW5mbzogZ2V0IHByb3BlcnRpZXMgcmVxdWlyZWQgdG8gaW5pdGlhbGl6ZSBhDQo+PiAgICAq
IGRldmljZSBJT1RMQi4NCj4+IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNp
LmMNCj4+IGluZGV4IGQwZTgxNjUxYWEuLmM5OTMyYzg3ZTMgMTAwNjQ0DQo+PiAtLS0gYS9ody9w
Y2kvcGNpLmMNCj4+ICsrKyBiL2h3L3BjaS9wY2kuYw0KPj4gQEAgLTMwMTAsNiArMzAxMCwxNyBA
QCB2b2lkDQo+cGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYpDQo+
PiAgICAgICB9DQo+PiAgIH0NCj4+DQo+PiArdWludDY0X3QgcGNpX2RldmljZV9nZXRfdmlvbW11
X2ZsYWdzKFBDSURldmljZSAqZGV2KQ0KPj4gK3sNCj4+ICsgICAgUENJQnVzICppb21tdV9idXM7
DQo+PiArDQo+PiArICAgIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihkZXYsICZpb21t
dV9idXMsIE5VTEwsIE5VTEwpOw0KPj4gKyAgICBpZiAoaW9tbXVfYnVzICYmIGlvbW11X2J1cy0+
aW9tbXVfb3BzLT5nZXRfdmlvbW11X2ZsYWdzKSB7DQo+PiArICAgICAgICByZXR1cm4NCj5pb21t
dV9idXMtPmlvbW11X29wcy0+Z2V0X3Zpb21tdV9mbGFncyhpb21tdV9idXMtPmlvbW11X29wYXF1
ZSk7DQo+PiArICAgIH0NCj4+ICsgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gICBpbnQg
cGNpX3ByaV9yZXF1ZXN0X3BhZ2UoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLCBib29s
IHByaXZfcmVxLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBleGVjX3JlcSwg
aHdhZGRyIGFkZHIsIGJvb2wgbHBpZywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQxNl90IHByZ2ksIGJvb2wgaXNfcmVhZCwgYm9vbCBpc193cml0ZSkNCg0K

