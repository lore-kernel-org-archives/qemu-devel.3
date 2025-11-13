Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B40FCD4F5F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 08:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJSsV-0005Gj-It; Thu, 13 Nov 2025 03:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJSsT-00057f-8q
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:40:25 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJSsM-0005z8-4N
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763023218; x=1794559218;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1PvW2Me5ZR4rfDYz6h9JQX25siRRJI80lsHvxXWJLZ8=;
 b=F0TCohuh6B5eJWoyq5HT7ikKGq53ZE/d0dn3RMT1nOuyU5BX4xF5Zn4j
 j94OHr68fhzJqwhRniG1z8u50RXeUNqZiKTBXSR8oxG8rzanojb688lrr
 OjbfTsW0JsWJwKtfm01njlAOeQYPuSDdNojAjpT6o1QK+vQGoxw5GSLQE
 II3k83Ij8lLKqMifUJAeXNAUP5FZDzT4JrB/LVBdY2RJDY71fGRhoq3N8
 txdprI+h/c5qXo/YNWbVBp0H/9HwqOqLMVb4W+UU1lbve/QPu2yjC2htJ
 czktGT4YRcUTcdn5XbLjz9t7edustfyFot/jniwfh/B4lCCZCu6KSn/Va A==;
X-CSE-ConnectionGUID: Iu7sjq77QH2lyDahYven3Q==
X-CSE-MsgGUID: q6uS5BFqQN2HW+MDW6JtKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="65003067"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="65003067"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:40:12 -0800
X-CSE-ConnectionGUID: EhpjCC/KQRqnKQ8YiGIqRw==
X-CSE-MsgGUID: 0y0yt3w9RmCOknroAB9d2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="212828248"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:40:12 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:40:11 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 00:40:11 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:40:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYrKXOss2mEMXvDHn1Gt5RoUWNXYXkFwtInvQFOFcTui3v7BpCGGUbEzMG22QjwB2S45Mr54dfCeTkSntswjycH+9JNKlFOYK1k9XYw3lY+fNzEsl3085StDTOBC+ltlhzfxqOr94usGCGYJ6hrVwu8V/15Yg19tD7Ukp5iUOPZMUOOd3GGjUyIjyL/eNduhLJY+7GB+ldnE/ps3cbF6EBd0rpmr9IhZ5XRaXUxGHrUguND9HdMj3nwzX94HvbnfXoBwwiJZkMJ2oM9mdfI0DuEhtQk4nPL2MQFalgmBkls1sCIGljKE0KJ8GMopGQj7kgLm/CT69fKD6oN9RpHtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PvW2Me5ZR4rfDYz6h9JQX25siRRJI80lsHvxXWJLZ8=;
 b=b4I8H6nrUkyFGZSiELUTbDb/J4j/K78OU+6xiYvDMHQpIEmFLdKySSjwWnr2xXbZEXQD0yvMObHKf8Ai7Z+T057TITF/RJYDONiGoyxvSnyO+7kcxpnBL+utJ4kwl3pjtbSXB1z5qOo+84ildj0Hyv3fAnqjsG/a5JRK1cC8QLCOXwzYNl3oN5727kJM3o2sYvC9vFodFzWIAAEyqURM3+DJALus5gCPN1xUP3r18mhZorE/IT6jWVIm7lffS8O1t9NjePdqiGGClbk6HJiG/tUzaovoMIxnSJf6Ck5TCX4wTrUErFWsOoDRf1f54uYSc83zGqSHyGyain8uyHvUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BL4PR11MB8845.namprd11.prod.outlook.com (2603:10b6:208:5aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 08:40:09 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:40:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 16/23] intel_iommu: Replay pasid bindings after context
 cache invalidation
Thread-Topic: [PATCH v7 16/23] intel_iommu: Replay pasid bindings after
 context cache invalidation
Thread-Index: AQHcRMKX91JfuEEw6EGwugbAEtBZlrTg1IOAgA9cjHA=
Date: Thu, 13 Nov 2025 08:40:09 +0000
Message-ID: <IA3PR11MB913653E17D28043D7E87E6EC92CDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-17-zhenzhong.duan@intel.com>
 <d02dc164-007a-4fe8-82d7-28d61c662e54@redhat.com>
In-Reply-To: <d02dc164-007a-4fe8-82d7-28d61c662e54@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BL4PR11MB8845:EE_
x-ms-office365-filtering-correlation-id: a9284dd5-ea22-44bc-3565-08de22904123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YkdmaVE3NFpMYU1kRzJDSEg3UWZ4UngxR2tHZVYwTmNzUTVydUhZQUhwSysz?=
 =?utf-8?B?QW9IblFCcDF3SDQ2amNzc2ROcWFzRUhCUng2clJod1RJNWJCSTdkNDlrbEcv?=
 =?utf-8?B?cjZaNDYzd3BNbURMNll6WXZ3UHgvU3c2alZWZ2NMNytTZmtQZklZSWliRnE0?=
 =?utf-8?B?TEFCancrdWpwQUYxZlo5QzhLUThIa1JjakhuMWxmVXBPcnB4Y0lycS9BZXB1?=
 =?utf-8?B?L09Pb1FkMHJsckZWOXJhNkVJWk92Q3F2YjM3MnhvY0dMMTdia0V2SDFZanlQ?=
 =?utf-8?B?QzRWK05CdlBDWk1iODFPNUs3eGx0ZE5RbGo5Vi9wM0JBOWdpZEFxcFNjQndR?=
 =?utf-8?B?ajIvM1l1Rmx3K0luOVB5UUVxZFBMcWhGelBuMS9TbTZoVVhVaDViR1JwNi9m?=
 =?utf-8?B?VG01Y3BnN1hrSWsvb3VxRnlBOENYSXRMOFFRbThaVXBpQndybWh1N1hBbDFo?=
 =?utf-8?B?S1pSTGE1ME5SYVpTN0l3OHplZEttR2M0NnArY3lJcll3QWxCd3dveEJCZTR4?=
 =?utf-8?B?UlUvZ3VHS1VFSnNwQWNZcHZXUFBWUml1MDRyZlhFcHcvOUJRb3RJTVREZ0lp?=
 =?utf-8?B?RjFLOGd0ekNWN1VNYUdaMFh2S0UzNVB1cXZyV3hLUFhNakFSU1VFOXBkS3BI?=
 =?utf-8?B?U2dRaG8rMDhxZk92WEtDN001cUkxbnVoT1EyNlJTK3I3ME5vZC9XUHB3N0pT?=
 =?utf-8?B?Q0RYbFlUT2I2dUtwNkZWVTN4UjVvSUkvS0xCem5iMlR1Zm9pbWZ2aGp0VWdU?=
 =?utf-8?B?OVBTSE9yeElBc0pyQURlT2wrZFRIbjV0VnVqYzlhekhvWnBOZlY1dFdRNklO?=
 =?utf-8?B?bVpLTEVvT0xMSkxnUnF5YThPZmR1VHVjRUxkY2xIc08rRDNibVc3ZXZuakVF?=
 =?utf-8?B?Nm5PNnBjSVR0a1VGT0E5aEVNUitKQzdoYU0yL0s1MjJvYTFyWXl1d3BOWHo5?=
 =?utf-8?B?bFhBcThTOFZHUkk4VFlsZlVDb1VYL2FlUUVTeHFOWGlodStOVWNSMWZvaXZV?=
 =?utf-8?B?dUxLZmVYNDNmWG5VMW50OVR0ZDJHL29XSnNDeDBCamRnNlJablNsWWdIOEps?=
 =?utf-8?B?SjV5WG5JUkZHNUwrdFdZWnVsM202VE1SanZrQ1RzeWYxL3FqWVJWUVFtSC9w?=
 =?utf-8?B?cHFNNnJ1ZEpFZTlHTkVXYWQxWjh6RUxCYjBZNEMxdTVJd1BXYVloU3FKNzJh?=
 =?utf-8?B?QXZTUzBHTXplM2FWczhucm84dVlvYlE1L1d0RTV1V1JXL1A1TFhXWUxVYUlk?=
 =?utf-8?B?SUIvdElHSGFpdjlDdlI2bGFuYVdWaUF2eUw1R2tRQUNDWjVpZlRwV0xsTTha?=
 =?utf-8?B?R2pRbFVIcFJndG5JNFZoRmZ5NGhjTzdteHVCVVBiWU5xN0lqTFNtdUJUL2Za?=
 =?utf-8?B?QmcwWjRyS01uWGl0Vm9hTDM3SlRFcUNQcU1nbE1zL1R5MklSVnFzL0wvQTJ3?=
 =?utf-8?B?c1BXL09Ecmg4cmZqaC9pNCtuM1pLV280M1IwMFFiWlR5RjQ3eFdsak5Mek5t?=
 =?utf-8?B?dzlhbktaa0RaRlFkdWlBN3lhakZIZXJreDM1anRDNklyK3l3Vm5sUXpWNU1u?=
 =?utf-8?B?aEg5QXlneGFGajRwcVZwSm93eCtQUkpUa3hHYUsxM0owZFU1bmI4a09Ba0RU?=
 =?utf-8?B?QzM0QjFpY1FLNko4S3djQmZJb0hrM2pNb0NDbVVuaHZxUHk4OTFIR1hXNm1K?=
 =?utf-8?B?OWJHNDA0RGV5enppRWxHWURMcXlGcnU4WktLNlFPUkJZMGY2YVpCOXdyOWNz?=
 =?utf-8?B?SURzaW85MGt1Nnd5N0Q1ZWw5WHJ3elNPNGcvSk4ydGlYczkzSkFhKzd3ZFNt?=
 =?utf-8?B?cW1jUERZblJPVzhXQlQrOTVzQlhkZDZ2WWNLVjRpTmdDZDNrS0N0TnYrcTQr?=
 =?utf-8?B?K1Fpd09oTE9rSHBXTjZpb1g0Z2MzQkUvVnNZMDZDMk13ZTF3VDIzWWNPM0Nh?=
 =?utf-8?B?Y216SS8rUG1iVVhGSEdGMWdoU0srVGJTT3E0NzFlSTlKdGozMXBHSWdEdFZC?=
 =?utf-8?B?NytzWTNIMVRJVThzQmJCdE9yWU5nVlorSTlGQmZJZTdxZTRjbDhuNldSQy85?=
 =?utf-8?Q?IphM8N?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXkxVWEraXV5U1Z4MCtWYUdtblR3ZGFJK3JHSHRDRDh6WGVNR2xHY3pKZjcv?=
 =?utf-8?B?U1RLcTFPeGw5K0oweU1ZTXJNZ2pKTXBudE9NMmQ3YkhwM0FJOWpVeGlROSt2?=
 =?utf-8?B?VmhuVGNRUkNKbFJpVEF5QmI5Q0tWazVuMlBITzhOdWpFV3ZaaVpVby9td1BG?=
 =?utf-8?B?KzQ0R2Iwa2N3MVRablcyQzlVMW54UnFaT0lGQ08raDRHZ2pGRUtObVZmbnYr?=
 =?utf-8?B?VnFjS3Z2T1lIcmc0ODN6Zkx5akpzQmtIWUdnNVJSenZBbzMxdmRuOUdtVW1Q?=
 =?utf-8?B?RlJ0NHJEWTRDZmEvd3BMQTBYdHNBZCtnVTBKNzhNdEphS1Q5MVh2Z0lJeDZq?=
 =?utf-8?B?Q0hmd2pHVTgzOFJTMUNveHdqR2oxeU9EWmpqbUlCaVlQWFQ5NXFiN3N3MjJD?=
 =?utf-8?B?QWJGUTIzWlRRRndya0NtUWsycmZwVUR2clZLUmd0YXFFZ240RnpSczc2TU00?=
 =?utf-8?B?cUdITEdYUXVHWGd5UDVSZXdOM1ZHSmtVLzFQb2RVa3R4TEZzOFVyOHh0UHky?=
 =?utf-8?B?U0VJR1BYYjB6SGljVHJaSFVIUmFWRWtjU2lyRGRkb045MlRhYTEyeGNjakNj?=
 =?utf-8?B?RTdIZXhLVG1vZ3JQTHA3a1FLRjV3NWE0MVFsMHdDNVhsU0U4aG54VjdmaDdO?=
 =?utf-8?B?eGlXNnllajRENGsxeUFNS1oyb1k2WVYwZlZwM2RDaURHNWh5cmRDWE5QVnJZ?=
 =?utf-8?B?ejM2akRGUnZsOStQdXdUVjM4MVdBdjVtc0xobHgwanBTR2J5WjhVY2tVaC92?=
 =?utf-8?B?UWdVVk90MTRpVkVwUEovelFjd3J0Y1ZMZFBBSCtXMy9sc0lSY3ZjeEMwYlhP?=
 =?utf-8?B?Ull6dEdiM1N6THc2bHhHUVJpZ1M3QmhsRVpibEdZTUdUcFBCRTFGL2dIM0xj?=
 =?utf-8?B?Q0syZVBicGJKMkFBTFQ2NjNSYXFVQUo3VnNBNVNZWExlbUc5MzBQcGkxYnhY?=
 =?utf-8?B?RTFVRUFyY3U2UERKWHNMYlFjcG5Zcmt1bHFmd3BSeW5KdlQ2eUU2R0lXUEVn?=
 =?utf-8?B?SXkzVUs4S1U5V2JEdmZZbzJVbGNYWlEzWElyVEFtRGxxa1pYdjQ3bjF0NFcr?=
 =?utf-8?B?bGUxTFM5TWtkM0tWRFRPMnEwTGxSRG1VSjdOMnYyV3g3SGJxc0VTSGcxSzFN?=
 =?utf-8?B?VitJVUlXQURqNEdPRGZXZjFMUStjejFTREtmOTI0TkN4Z2ZTL0QzQlZxQ0p2?=
 =?utf-8?B?d2R4Y1hURnk4TGlRb2NRSGlqQjJCVmNnaTRCNXJWODFEaTN2SCtTSzZqMTcr?=
 =?utf-8?B?VGh4N0V0aUlaTHdXK2dPM01BRnpXYVpmT3ZwTjFvNUs4ckRBRHNmUElNNHd2?=
 =?utf-8?B?WHVZWC9Oc25DZm5LUHJhd0FLVm10Y3c3UlFqRnJYZEJ4VG9NbWRENVF5blV5?=
 =?utf-8?B?UXFWbnlRdzBUbDJnMitZWlQ1czBCME9yRGxmM1NFRFB4UXl5d0NNVXJ2YlJ6?=
 =?utf-8?B?dU54UXpVd0NnK2hrSEpQMisxbjRWRlZVbFBGc29ic3YycDNNbTZhMWNZSWZa?=
 =?utf-8?B?WUxzQTFtWThQaTZLNG9QTTlEdkx5R29CSUgydFNFWE4rL1dsaUd5YW5FUFJU?=
 =?utf-8?B?T1ArQmpadno2ODJ4N3RhZEFnYS90cnUxbXp4Y0VhUzNYMk83U0w1RHh1Y1FZ?=
 =?utf-8?B?M2VKQWdZY29GMWpaZ1Y5Q0dpREErYXBxMmtNOWtmeCtzTndTWFhuTXFqWXRX?=
 =?utf-8?B?QUxPMUpHTys4eFMzajJuZ201enNPeGxZTnhmQ1NOdzFUeWN4dWl6U3QvR0NE?=
 =?utf-8?B?d1ZqRWFqNFlPU2lBaXIrKzZCeHFTMUptekNvQUlKSmc5RzJEWnYvaWo1NWMw?=
 =?utf-8?B?NVorenJWZTdvdUMvQmdXTHFXVnV4anNPZkJrWXZiZHQrTkRJMkJzZHEvM0V6?=
 =?utf-8?B?VlM2Qm8wM3Z4TDVpV0pmbnRNZ2prSStFRDBJa0NNSHNTODVoN1ZZMmZjVmxU?=
 =?utf-8?B?cmtlSjFaVlNseUhtTy9rZjJyWExtSVJTenJhOElzYVZPbzBnRjJKM2dkR2R6?=
 =?utf-8?B?UGJvZUs0Z3dkNDVVSjRoMElpbDRMMHBuTk1BNTA3ekR4OXUzY054MGl4b0NN?=
 =?utf-8?B?R2tpMUtVNDR6enlVVkk0NktacHdqWVM1MnZaVXdaVzR3eWJOQ0RIc3hmRm5Q?=
 =?utf-8?Q?iAvX1iVbOS3t/bJFl3RH1tH1s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9284dd5-ea22-44bc-3565-08de22904123
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 08:40:09.6234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1GWzTakLHEB+HHl67XXi4IN+fOkNoH7jFPFDO/F6qCg6Z4shPZGNhjwIEeaijPwUpKzuPIGyQGjITagMk28/krmFkR1+dNjWfeGeUoMe4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8845
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDE2LzIzXSBpbnRlbF9p
b21tdTogUmVwbGF5IHBhc2lkIGJpbmRpbmdzIGFmdGVyDQo+Y29udGV4dCBjYWNoZSBpbnZhbGlk
YXRpb24NCj4NCj4NCj4NCj5PbiAxMC8yNC8yNSAxMDo0MyBBTSwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+PiBGcm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+DQo+PiBUaGlzIHJl
cGxheXMgZ3Vlc3QgcGFzaWQgYmluZGluZ3MgYWZ0ZXIgY29udGV4dCBjYWNoZSBpbnZhbGlkYXRp
b24uDQo+PiBBY3R1YWxseSwgcHJvZ3JhbW1lciBzaG91bGQgaXNzdWUgcGFzaWQgY2FjaGUgaW52
YWxpZGF0aW9uIHdpdGggcHJvcGVyDQo+PiBncmFudWxhcml0eSBhZnRlciBpc3N1aW5nIGNvbnRl
eHQgY2FjaGUgaW52YWxpZGF0aW9uLg0KPj4NCj4+IFdlIHNlZSBvbGQgbGludXggc3VjaCBhcyA2
LjcuMC1yYzIgbm90IGZvbGxvd2luZyB0aGUgc3BlYywgaXQgc2VuZHMNCj4+IHBhc2lkIGNhY2hl
IGludmFsaWRhdGlvbiBiZWZvcmUgY29udGV4dCBjYWNoZSBpbnZhbGlkYXRpb24sIHRoZW4gUUVN
VQ0KPj4gZGVwZW5kcyBvbiBjb250ZXh0IGNhY2hlIGludmFsaWRhdGlvbiB0byBnZXQgcGFzaWQg
ZW50cnkgYW5kIHNldHVwDQo+PiBiaW5kaW5nLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExp
dSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9t
bXUuYyB8IDQ3DQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4gIGh3L2kzODYvdHJhY2UtZXZlbnRzICB8ICAxICsNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDQ4
IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCAxZjc4Mjc0MjA0Li5lZGQxNDE2Mzgy
IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4+IEBAIC05Myw2ICs5Myw4IEBAIHN0YXRpYyB2b2lkDQo+dnRkX2Fk
ZHJlc3Nfc3BhY2VfcmVmcmVzaF9hbGwoSW50ZWxJT01NVVN0YXRlICpzKTsNCj4+ICBzdGF0aWMg
dm9pZCB2dGRfYWRkcmVzc19zcGFjZV91bm1hcChWVERBZGRyZXNzU3BhY2UgKmFzLA0KPklPTU1V
Tm90aWZpZXIgKm4pOw0KPj4gIHN0YXRpYyBpbnQgdnRkX2JpbmRfZ3Vlc3RfcGFzaWQoVlREQWRk
cmVzc1NwYWNlICp2dGRfYXMsIEVycm9yICoqZXJycCk7DQo+PiAgc3RhdGljIHZvaWQgdnRkX3Jl
cGxheV9wYXNpZF9iaW5kaW5nc19hbGwoSW50ZWxJT01NVVN0YXRlICpzKTsNCj4+ICtzdGF0aWMg
dm9pZCB2dGRfcGFzaWRfY2FjaGVfc3luY19sb2NrZWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlciB2
YWx1ZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3BvaW50
ZXIgdXNlcl9kYXRhKTsNCj4+DQo+PiAgc3RhdGljIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3Jlc2V0
X2xvY2tlZChJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiAgew0KPj4gQEAgLTIzODgsNiArMjM5MCwx
MyBAQCBzdGF0aWMgdm9pZA0KPnZ0ZF9jb250ZXh0X2dsb2JhbF9pbnZhbGlkYXRlKEludGVsSU9N
TVVTdGF0ZSAqcykNCj4+ICAgICAgICogVlQtZCBlbXVsYXRpb24gY29kZXMuDQo+PiAgICAgICAq
Lw0KPj4gICAgICB2dGRfaW9tbXVfcmVwbGF5X2FsbChzKTsNCj4+ICsgICAgLyoNCj4+ICsgICAg
ICogU2FtZSBmb3IgcGFzaWQgY2FjaGUgaW52YWxpZGF0aW9uLCBwZXIgVlQtZCBzcGVjIDYuNS4y
LjEsIGEgZ2xvYmFsDQo+PiArICAgICAqIGNvbnRleHQgY2FjaGUgaW52YWxpZGF0aW9uIHNob3Vs
ZCBiZSBmb2xsb3dlZCBieSBnbG9iYWwgUEFTSUQNCj5jYWNoZQ0KPj4gKyAgICAgKiBpbnZhbGlk
YXRpb24uIEluIG9yZGVyIHRvIHdvcmsgd2l0aCBndWVzdCBub3QgZm9sbG93aW5nIHNwZWMsDQo+
PiArICAgICAqIGhhbmRsZSBnbG9iYWwgUEFTSUQgY2FjaGUgaW52YWxpZGF0aW9uIGhlcmUuDQo+
PiArICAgICAqLw0KPj4gKyAgICB2dGRfcmVwbGF5X3Bhc2lkX2JpbmRpbmdzX2FsbChzKTsNCj4+
ICB9DQo+Pg0KPj4gICNpZmRlZiBDT05GSUdfSU9NTVVGRA0KPj4gQEAgLTI1ODksNiArMjU5OCwz
NSBAQA0KPnZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9ja2VkKEludGVsSU9NTVVTdGF0ZSAq
cywNCj4+ICB9DQo+PiAgI2VuZGlmDQo+Pg0KPj4gK3N0YXRpYyB2b2lkIHZ0ZF9wYXNpZF9jYWNo
ZV9kZXZzaShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcykNCj4+ICt7DQo+PiArICAgIEludGVsSU9N
TVVTdGF0ZSAqcyA9IHZ0ZF9hcy0+aW9tbXVfc3RhdGU7DQo+PiArICAgIFBDSUJ1cyAqYnVzID0g
dnRkX2FzLT5idXM7DQo+PiArICAgIHVpbnQ4X3QgZGV2Zm4gPSB2dGRfYXMtPmRldmZuOw0KPj4g
KyAgICBzdHJ1Y3QgdnRkX2FzX2tleSBrZXkgPSB7DQo+PiArICAgICAgICAuYnVzID0gYnVzLA0K
Pj4gKyAgICAgICAgLmRldmZuID0gZGV2Zm4sDQo+PiArICAgICAgICAucGFzaWQgPSB2dGRfYXMt
PnBhc2lkLA0KPj4gKyAgICB9Ow0KPj4gKyAgICBWVERQQVNJRENhY2hlSW5mbyBwY19pbmZvOw0K
Pj4gKw0KPj4gKyAgICBpZiAoIXMtPmZzdHMgfHwgIXMtPnJvb3Rfc2NhbGFibGUgfHwgIXMtPmRt
YXJfZW5hYmxlZCkgew0KPj4gKyAgICAgICAgcmV0dXJuOw0KPj4gKyAgICB9DQo+PiArDQo+PiAr
ICAgIHRyYWNlX3Z0ZF9wYXNpZF9jYWNoZV9kZXZzaShwY2lfYnVzX251bShidXMpLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlREX1BDSV9TTE9UKGRldmZuKSwNCj5WVERf
UENJX0ZVTkMoZGV2Zm4pKTsNCj4+ICsNCj4+ICsgICAgLyogV2UgZmFrZSB0byBiZSBnbG9iYWwg
aW52YWxpZGF0aW9uIGp1c3QgdG8gYnlwYXNzIGFsbCBjaGVja3MgKi8NCj5jYW4geW91IGNsYXJp
Znkgd2hpY2ggY2hlY2tzIGFuZCB3aHkgeW91IHdhbnQgdG8gYnlwYXNzIHRoZW0/DQoNCkFsbCBi
ZWxvdyBjaGVja3MgaW4gdnRkX3Bhc2lkX2NhY2hlX3N5bmNfbG9ja2VkKCkuIEJlY2F1c2UgYWZ0
ZXIgY29udGV4dA0KY2FjaGUgaW52YWxpZGF0aW9uLCBhbGwgY2FjaGVkIHBhc2lkIGVudHJ5IGZv
ciB0aGlzIGRldmljZSBiZWNvbWUgc3RhbGUuDQpXZSBuZWVkIHRvIGludmFsaWRhdGUgdGhlbSBh
bGwuDQoNCiAgICBzd2l0Y2ggKHBjX2luZm8tPnR5cGUpIHsNCiAgICBjYXNlIFZURF9JTlZfREVT
Q19QQVNJRENfR19QQVNJRF9TSToNCiAgICAgICAgaWYgKHBjX2luZm8tPnBhc2lkICE9IHZ0ZF9h
cy0+cGFzaWQpIHsNCiAgICAgICAgICAgIHJldHVybjsNCiAgICAgICAgfQ0KICAgICAgICAvKiBG
YWxsIHRocm91Z2ggKi8NCiAgICBjYXNlIFZURF9JTlZfREVTQ19QQVNJRENfR19EU0k6DQogICAg
ICAgIGlmIChwY19lbnRyeS0+dmFsaWQpIHsNCiAgICAgICAgICAgIGRpZCA9IFZURF9TTV9QQVNJ
RF9FTlRSWV9ESUQoJnBjX2VudHJ5LT5wYXNpZF9lbnRyeSk7DQogICAgICAgIH0gZWxzZSB7DQog
ICAgICAgICAgICBkaWQgPSBWVERfU01fUEFTSURfRU5UUllfRElEKCZwZSk7DQogICAgICAgIH0N
CiAgICAgICAgaWYgKHBjX2luZm8tPmRpZCAhPSBkaWQpIHsNCiAgICAgICAgICAgIHJldHVybjsN
CiAgICAgICAgfQ0KICAgIH0NCg0KDQo+PiArICAgIHBjX2luZm8udHlwZSA9IFZURF9JTlZfREVT
Q19QQVNJRENfR19HTE9CQUw7DQo+PiArDQo+PiArICAgIC8qDQo+PiArICAgICAqIFdlIGFscmVh
ZHkgZ2V0IHZ0ZF9hcyBvZiB0aGUgZGV2aWNlIHdob3NlIFBBU0lEIGNhY2hlIGlzDQo+aW52YWxp
ZGF0ZWQsDQo+cy9nZXQvZ290LiBOb3Qgc3VyZSB0aGUgY29tbWVudCBpcyB3b3J0aC4NCg0KT0ss
IEkgY2FuIHJlbW92ZSBpdC4NCg0KPj4gKyAgICAgKiBzbyBqdXN0IGNhbGwgdnRkX3Bhc2lkX2Nh
Y2hlX3N5bmNfbG9ja2VkKCkgb25jZS4NCj4+ICsgICAgICovDQo+PiArICAgIHZ0ZF9wYXNpZF9j
YWNoZV9zeW5jX2xvY2tlZCgma2V5LCB2dGRfYXMsICZwY19pbmZvKTsNCj4+ICt9DQo+PiArDQo+
PiAgLyogRG8gYSBjb250ZXh0LWNhY2hlIGRldmljZS1zZWxlY3RpdmUgaW52YWxpZGF0aW9uLg0K
Pj4gICAqIEBmdW5jX21hc2s6IEZNIGZpZWxkIGFmdGVyIHNoaWZ0aW5nDQo+PiAgICovDQo+PiBA
QCAtMjY0Nyw2ICsyNjg1LDE1IEBAIHN0YXRpYyB2b2lkDQo+dnRkX2NvbnRleHRfZGV2aWNlX2lu
dmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAgICAgICAgICAgICAqIGhhcHBlbmVk
Lg0KPj4gICAgICAgICAgICAgICAqLw0KPj4gICAgICAgICAgICAgIHZ0ZF9hZGRyZXNzX3NwYWNl
X3N5bmModnRkX2FzKTsNCj4+ICsgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAgICAgICAqIFBl
ciBzcGVjIDYuNS4yLjEsIGNvbnRleHQgZmx1c2ggc2hvdWxkIGJlIGZvbGxvd2VkIGJ5DQo+UEFT
SUQNCj4+ICsgICAgICAgICAgICAgKiBjYWNoZSBhbmQgaW90bGIgZmx1c2guIEluIG9yZGVyIHRv
IHdvcmsgd2l0aCBhIGd1ZXN0DQo+d2hpY2ggZG9lcw0KPj4gKyAgICAgICAgICAgICAqIG5vdCBm
b2xsb3cgc3BlYyBhbmQgbWlzc2VkIFBBU0lEIGNhY2hlIGZsdXNoLCBlLmcuLCBsaW51eA0KPj4g
KyAgICAgICAgICAgICAqIDYuNy4wLXJjMiwgd2UgaGF2ZSB2dGRfcGFzaWRfY2FjaGVfZGV2c2ko
KSB0byBpbnZhbGlkYXRlDQo+UEFTSUQNCj4+ICsgICAgICAgICAgICAgKiBjYWNoZSBvZiBwYXNz
dGhyb3VnaCBkZXZpY2UuIEhvc3QgaW9tbXUgZHJpdmVyIHdvdWxkDQo+Zmx1c2gNCj4+ICsgICAg
ICAgICAgICAgKiBwaW90bGIgd2hlbiBhIHBhc2lkIHVuYmluZCBpcyBwYXNzIGRvd24gdG8gaXQu
DQo+cGFzc2VkDQoNCldpbGwgZG8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPj4gKyAgICAgICAg
ICAgICAqLw0KPj4gKyAgICAgICAgICAgIHZ0ZF9wYXNpZF9jYWNoZV9kZXZzaSh2dGRfYXMpOw0K
Pj4gICAgICAgICAgfQ0KPj4gICAgICB9DQo+PiAgfQ0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYv
dHJhY2UtZXZlbnRzIGIvaHcvaTM4Ni90cmFjZS1ldmVudHMNCj4+IGluZGV4IDVhM2VlMWNmNjQu
LjVmYTVlOTNiNjggMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L3RyYWNlLWV2ZW50cw0KPj4gKysr
IGIvaHcvaTM4Ni90cmFjZS1ldmVudHMNCj4+IEBAIC0yOCw2ICsyOCw3IEBAIHZ0ZF9wYXNpZF9j
YWNoZV9yZXNldCh2b2lkKSAiIg0KPj4gIHZ0ZF9pbnZfZGVzY19wYXNpZF9jYWNoZV9nc2kodm9p
ZCkgIiINCj4+ICB2dGRfaW52X2Rlc2NfcGFzaWRfY2FjaGVfZHNpKHVpbnQxNl90IGRvbWFpbikg
IkRvbWFpbiBzZWxlY3RpdmUgUEMNCj5pbnZhbGlkYXRpb24gZG9tYWluIDB4JSJQUkl4MTYNCj4+
ICB2dGRfaW52X2Rlc2NfcGFzaWRfY2FjaGVfcHNpKHVpbnQxNl90IGRvbWFpbiwgdWludDMyX3Qg
cGFzaWQpICJQQVNJRA0KPnNlbGVjdGl2ZSBQQyBpbnZhbGlkYXRpb24gZG9tYWluIDB4JSJQUkl4
MTYiIHBhc2lkIDB4JSJQUkl4MzINCj4+ICt2dGRfcGFzaWRfY2FjaGVfZGV2c2kodWludDhfdCBi
dXMsIHVpbnQ4X3QgZGV2LCB1aW50OF90IGZuKSAiRGV2IHNlbGVjdGl2ZQ0KPlBDIGludmFsaWRh
dGlvbiBkZXY6ICUwMiJQUkl4OCI6JTAyIlBSSXg4Ii4lMDIiUFJJeDgNCj4+ICB2dGRfcmVfbm90
X3ByZXNlbnQodWludDhfdCBidXMpICJSb290IGVudHJ5IGJ1cyAlIlBSSXU4IiBub3QgcHJlc2Vu
dCINCj4+ICB2dGRfY2Vfbm90X3ByZXNlbnQodWludDhfdCBidXMsIHVpbnQ4X3QgZGV2Zm4pICJD
b250ZXh0IGVudHJ5DQo+YnVzICUiUFJJdTgiIGRldmZuICUiUFJJdTgiIG5vdCBwcmVzZW50Ig0K
Pj4gIHZ0ZF9pb3RsYl9wYWdlX2hpdCh1aW50MTZfdCBzaWQsIHVpbnQ2NF90IGFkZHIsIHVpbnQ2
NF90IHNscHRlLCB1aW50MTZfdA0KPmRvbWFpbikgIklPVExCIHBhZ2UgaGl0IHNpZCAweCUiUFJJ
eDE2IiBpb3ZhIDB4JSJQUkl4NjQiIHNscHRlDQo+MHglIlBSSXg2NCIgZG9tYWluIDB4JSJQUkl4
MTYNCj5CZXNpZGVzDQo+DQo+UmV2aWV3ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVk
aGF0LmNvbT4NCj4NCj5FcmljDQoNCg==

