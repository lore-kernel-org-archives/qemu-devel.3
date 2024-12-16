Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498D9E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 08:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN6Mm-0007OO-Q7; Mon, 16 Dec 2024 03:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tN6Mj-0007Nq-NW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 03:22:09 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tN6Mg-0002Qj-NH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 03:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734337327; x=1765873327;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HBVY9+ZXXbp8rY6ujW+/cZG0GZKmXJMZjSGRN7fIcI8=;
 b=Ex4ZR995YIHNWOSivlkb4madh55gMXUbxUhAFsyMRnA6u+YQYnGwHSeL
 UUIGSM7AOkatD2/wmPD/NDuJkhNQGJfghs8+UNPZTUW/bpj2KX7OpWRw+
 BiAWz7TzUC9IenVktoKcCZu0F38gcKBfokJhqBGeQKMritHAr6BEOk0Z1
 tPhf9wXDjyh9yOkc1g72/gyCsbYwL5Ps92B5Os9tpYHzi9gPIr1IhuXWQ
 UFZL4Oy3ovFo8lH2FvX5dCdRf8bR3ER2CyVy2xOynihwkavtzn6yz/yFA
 q4XBE3zmc46meu233HJFnO3b3q+4zzsiVgGii+C4MiZSiEVR9gQJdVTwt A==;
X-CSE-ConnectionGUID: yIFNyNvMQMWzGCdCVW9yhA==
X-CSE-MsgGUID: 0ENZpqdkSUaGU6PAmOoUrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="38394298"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; d="scan'208";a="38394298"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 00:22:03 -0800
X-CSE-ConnectionGUID: sDRmFw12S2+N4gXM03GJ7w==
X-CSE-MsgGUID: GIQW1KyyQuyQIjP/p5TJqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; d="scan'208";a="97175906"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Dec 2024 00:22:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 00:22:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 00:22:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 00:21:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh237co8LU9AO08mX+SMaqdBjyiob6h2zq+C93Jw1IKqRph/PmrzaVu2gRtAm6R+NreWRO5SLYBbkS5QalnjbtaNBS6iQPJIDRRV2S8FUOnZrQBMjXeCNIlOLWyi+QaY2ieHIwqzTS31xhYpwue8yMEl8V3DqX89r7vkWJBpRiT67xyX9+bLzOCKH+rNR3a9XHqaOJmLKs38A+LiAw2JTqvPPLsVyJ+YT3Ara59wR01kulIoaqUetAoD08Uy7Tu+5X/9b2/FRHaJjo2Ngj8iqolNqA5hAEEG1YlDsSLHRUohekDHlDE+79DLbZKpezVFovBJyQGiOjfJ/n9/e7B9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBVY9+ZXXbp8rY6ujW+/cZG0GZKmXJMZjSGRN7fIcI8=;
 b=xeTXCUCD50p4tQ4Akn24gW3CD+1p3TFA5IticCGvMxy3uk+PS0BYIyWK2jextaPUBZMi1bDgNuX04RfLK7rtO9ubQHJ9So7nPKYN34U/7758qH89ZCJk/CGo4krHTe4hQRvFo9nAT+B+v7geyl+MsB/hRlFPru1HtEJ76YzEQ+FiNKOUwThoKyOPuthjw31wxqoMK73Zbd3Cg7tEj8XSb1cesgyI7dnvJZGH9z4RbLKWRjyXj3JXMdVHKwM6mT5eJomkX3Xe3RchG/ftacsMTqV2v26sZoWNk9D5Q9n/sMfLbTzijWfkd7gA1eXNp4LhOF2RVDebWnNfdDm3lLw51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB8417.namprd11.prod.outlook.com (2603:10b6:208:48d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 08:21:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 08:21:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Thread-Topic: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Thread-Index: AQHbBAs7dSCINsfvkEGytF87b/oqprJrHaMAgAAom3CAAtf8gIB6/KPA
Date: Mon, 16 Dec 2024 08:21:38 +0000
Message-ID: <SJ0PR11MB67447F79B1350833A5D878F8923B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-13-zhenzhong.duan@intel.com>
 <CACGkMEscZB9f6toOcm_+3pQknDgnp3r6MvzbejB9BVEsKz7rjA@mail.gmail.com>
 <SJ0PR11MB67441D158F394CE1EA620CA9926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuXX6UE0=dNjeNJ5rHxkJADUrTG0tU1Cd1n0cvik5NnKg@mail.gmail.com>
In-Reply-To: <CACGkMEuXX6UE0=dNjeNJ5rHxkJADUrTG0tU1Cd1n0cvik5NnKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB8417:EE_
x-ms-office365-filtering-correlation-id: 043cf427-2dde-4822-afee-08dd1daaa9cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WjR0TVFadUhTYUhXVWkzZTg1enY5Z3RtQXBkU0FkWitUaFdtU1Z2VWxFNTVU?=
 =?utf-8?B?aTMrYnpURXcrUENsTFVZQ2hBTjFaVDdEUE54VkgweWtDV0NVMEFySWdUMHVu?=
 =?utf-8?B?dTVhWXQyMmdWT0pMcWJoREdQUEEzM2ZTTFNoWjNpZlIrMi9OQXQxYTY4WDE5?=
 =?utf-8?B?dmxpRkVWak4rVEZ6UWdQZFBZL050Y0NHa2tSeUt5ZEpOMm5saHdQYkErYVJW?=
 =?utf-8?B?TmV1VzFnT2E1b1JDcDZYVHdtTHlKaXA1OEwwSEczek15ZTRlY0hIUEljTjNJ?=
 =?utf-8?B?ZWUxY1FiZHU1WnloKzBxTXhackw2WEMyZll3Z1ZFV3E0S2FjNENDNHdQclhy?=
 =?utf-8?B?UDFicWVWM2tNaWdkdzE0ZERGbXFLbXlKTUt3S0lRVnFVVzBtVnU5MEYrMHk2?=
 =?utf-8?B?bVpNbVNJa0ZEMDdoTGVyekJXK0k1VVNwOVRVMHkxTllncUV2c2hFMmVBeFFi?=
 =?utf-8?B?VWE0cjVwbHFIVWU2UDg0SkxsYzlWeVhnVmJxUGpjcmJkQmI1RzhPdE5pL0lF?=
 =?utf-8?B?UXhsZjJmaHU2Y0YxTkdOUGxzWk5sRnNYb2xHcUF1bjBQZFZCQURualdVK2lw?=
 =?utf-8?B?TjBabEZ1eHN3SHhKZkVOQlFxRzJFRGM1YjhoNFlvbVpSYmJnQlhmM1B1djFB?=
 =?utf-8?B?OHc5U3UvVUt3WndUV0JZRExVenF0RldHM1BIbGQyNDY1SDVRTG5SbmZCQWx6?=
 =?utf-8?B?QkR5Qm5kNHlGOTFINTE4eEZ1RVY0amJmYWRreXo3ZlRwZWgxMU5hMzd2ZDE0?=
 =?utf-8?B?UjM0cDY3ZlY2RGE4WjlFbi9PN25KNzJXNjBjR0VadGFQNkhEQTFuSWRuQ05V?=
 =?utf-8?B?Y2Y0cWQ1Nm1xRURhVDdYOHNkenVZNnk5Wk9KMVlMN0FRbEFMZnEzWXdOekNV?=
 =?utf-8?B?a3NaTE9kSHJQenJFVEFYQWZQd2UzeDNLNDRLOG5FaHNjSW1PUTVBOXlyNHBh?=
 =?utf-8?B?cE1VYWFQN3laZTFaOGFOaUxWR0VEUm8zNUVxTXg1TnFDSUhKNDJRNXdiYTAr?=
 =?utf-8?B?N0FTaFQxUEw0ZVJJVElxcVFSWGRWQ09lSmgwcEwvaVd2YjA2Y0ZTTGVBQy9i?=
 =?utf-8?B?TnlDdHBlcE5Ib2RCdzJtVFpBTFZzaUxTTFF1MytWNUJhVzVSYXB1RmhURmtG?=
 =?utf-8?B?TkJrTEpXU2plQWZvZGhQdldidFR5UVNzTDhuZmVvbVZzUDZKSHUzY0I4TXJn?=
 =?utf-8?B?U3JNcXhlTC9hK21KWVBRN2QvcXdsL2lJcXEvRWZhdjR5c2dwQktCSCtaQTdz?=
 =?utf-8?B?ZGQ2RldkMnJtbmJqWWkxZXQ2SVowU1hxZGY0Z3RBME9EVDdEejYzK1h6T3Jz?=
 =?utf-8?B?Q0JFbHdtcTlSU3dOWGx0amloNUVrNGlUdC9KWGxXc3UvOXlNRkpSaFhiQ09i?=
 =?utf-8?B?TnlaUkxvWFlNU3dIenhweU90TDJ5VmdWU3NnV3Y3ZCtWK2RHZzNzcFNuODMr?=
 =?utf-8?B?R1ZrMmpQOGdmV2RVVExrU0ZUM2Jnb2xuUngvcUEvLzEyUzVMWHNKcGxEL2V2?=
 =?utf-8?B?L2lNajdoMkNrZFdaaXF1WmxPT0k2blA2ekU3L1lEbnFCcWFoQVZmUlJCdi81?=
 =?utf-8?B?VjRGSnVJbndNN3lmdWpNUElhb0NzTmdXMzFHL1lXVWgvcWxKYlBxYlRwdFdY?=
 =?utf-8?B?eGVtS3JxcFFlMU1oampuVzAvYndDVkRjM05vcE1pOE5taldkTlplejZleDIw?=
 =?utf-8?B?NlpINlRCKzZTWFc4dy9yMWw3VlVjUkRra1Q1enV3UkdLcm1ZcXNZU1dIVjNX?=
 =?utf-8?B?UEhvZ3RJeVdhbHVqTjRrTUszWnR2bFcvNUMrV0czSVIrK210WDc4bGdVemxQ?=
 =?utf-8?B?MGlobkdnclUyVm1oYU1Sb1VtTWhScXNNbnNReGlKVnpUSER2dHZHTnAxbmdl?=
 =?utf-8?B?Q0Jma2lCK1c4WlVGdEhWbVdFcGdDclh4eE5VTnNycmc5cThKQVl1ZGtEWi9Z?=
 =?utf-8?Q?g1jPTSJswS0rQuSdnk/GzIzAiAt1A89Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L05wY1BncU8vMzJXUG9UL05xbU50bkJXUXlQOEVIaTJHTDA5NEI2NU1CL00z?=
 =?utf-8?B?U1dtSURDSEc3RmpQQVNyYU84SXBwT2JPZFg4YTIrUlVORTVFM3duL2xQN2cv?=
 =?utf-8?B?dStEOU1iRU9TSmJsNGJGZ1l2aUJCbTdxNUs4TnVHbGd4NFE5NGdGdjRsNDJo?=
 =?utf-8?B?eERsNDh0L0JGUlo2TVhXSWJoc3IzQnB1OG9mVU44U0I0VCtZcW9JZmZUaWNy?=
 =?utf-8?B?WW1zQkkzL3dpRE9QMFphaThteVY3eE53bGk5b2lHVjNZOC9WdklHbFhtOVp5?=
 =?utf-8?B?VUVXUjdqbDk5THA5L0dBalhnQ1VyMmhNazJia3IyNWM0eEtSMzdmNGR5L043?=
 =?utf-8?B?RWo2aFBmUWlkdUF3S1FYUk15NFBxV0NpNlNVVFdZc3FlSWdIOE1UdDZwR3g1?=
 =?utf-8?B?OTZ6d3VBMm00MzcrU2YyanZLVlluVVpmczA4VDBGV2NtenpiV0I5RnNCajRQ?=
 =?utf-8?B?VWhmYnNMYVA5Q2IrR2xqbFl6RDgwYUNDVmtsV05kRVFFZ1RheFBNOEg4SUVT?=
 =?utf-8?B?SWRMdHltamJFR1hzVDU3ZVN1clRqeSs2MXFSN21LRVYxUEQ3TDJIMHhOaytO?=
 =?utf-8?B?S1p4WkszZ29JUzA4NlZGSklzV24rMnMrRUovaFJJZmVPeVJMUUJzeVJZRGNR?=
 =?utf-8?B?SGdjeUJweXBQOVNhWmZUOEpBbXJzTkxBSEhlR2RXSE9qSGxmTnBBNVZKcmVj?=
 =?utf-8?B?M0FqbXZiVzZlTGwzQy82anI0QUxuYkE1ajZqUi9iWG1ic0NoTERBS1lwcmhM?=
 =?utf-8?B?TEJ4azYzNjhqcU9wRHpMcVhBYmJzSm5aM09nSTUxaTBmYmFQSXpKSTBjbnV0?=
 =?utf-8?B?KzF3V3o0azk5NXBoQTNxVExKQ01sUjdtS3ZkdVlBUUcrRTdqcnhpbi9hM21J?=
 =?utf-8?B?MVcwTWsydFBza29HdUducW9lejkzOGJMZ2pvcDJoSDQ3TCtmKzJJVlpzRGFX?=
 =?utf-8?B?WlJjMk93ZVFZS2lCakwwS2g3M2I4cTlsOFd2eVk2YWs1NWZJcHZ3bjNsdFJS?=
 =?utf-8?B?YVhHdEFyRFVocXY2TGwzVmVpUE1ZdjJmOWs2SUhxUXBEdytuaFY5ZVhQRC94?=
 =?utf-8?B?WGdSbGg2SldlMlg0QnlCci9XVjNhRThUdjJrTXM3ZDlQQ2tacEVEVG80N3Z4?=
 =?utf-8?B?UWpYMlpiWDMvYVBDaENFZUxWSHNJSjlQWnY2YnR1R3hCMk9zSWIxb0NQVXdW?=
 =?utf-8?B?TUtSOEg1OXFNSjVKWXVpN0JjQVBoTlV4OHUxUkNkS2ZBZUk3VjhuUjJUb1B6?=
 =?utf-8?B?Qk5TSjdFZVBabXFiemlZYkg4cHRaUHV2dXBWM0MzdDd6NWVGS1RJZWpsbjJI?=
 =?utf-8?B?d1NvaEFtOWwzNldlaXFnN1hod1FNbnJhcDI0WXpoMzl4dGRzT1UyNmkrbE5a?=
 =?utf-8?B?cFpzVUVQT3o0WWhRdEk5NDJ3bzNmSjU3RXpETVFtekxtWnVwTEdydk82NDdD?=
 =?utf-8?B?UmU0djYzT1VIM0RUM3FjeFFOWnZKNS9yQkwxSVkyZVR1MDFyaWo4YlptcWhK?=
 =?utf-8?B?T3ljREcxaHpMY085ZkI3bC90T1RTSm5YQXFLV2t1YVQ0V2ZJb2tjY0wvT3c5?=
 =?utf-8?B?Zk5Pam94Y1NBMDJIR1V3bGc0Z0ZXL2d2N0J4c0RmMCtKSHltTkgrSHpMSjhv?=
 =?utf-8?B?MzhyRG9VaWtVcGJKQnNKeXFmQ0I5d1AyelVjSzdoUy9wVkpEQWVwOHJXOFg1?=
 =?utf-8?B?ak1Hc1lHbXBQZ05vcDA4WEowUEIwSDRzdC95dXZWa2ZtYVVydGl4UzVsT2Ru?=
 =?utf-8?B?ODFlNml4SGdNamE5dnVGSUk4K3N6QkdZT0laUTkzeFFiSnRScFBwWHZvVHd0?=
 =?utf-8?B?UDYwbDdhVm5oZjRwUXNTQlhocVpiYzg1MVlFZGNQdkNuMEJOME1ianBLM1JT?=
 =?utf-8?B?cktsYXUxU0FRa0M3Nmw5WTd3enpxVlp1VFBITXhJcTFKSDlFZkFXVlNVa25Y?=
 =?utf-8?B?azIwQzVNZmJPZDdBY3BPVnM5UlhvTUd0bDdxdTU2M1hKeVpGaWMxQVNqcUtO?=
 =?utf-8?B?NHBlbHpwMVIxMTJVSnd1Ymw4aVJBeDhINHRYaGdHZDlBb0V4QlFEcGxxNjBO?=
 =?utf-8?B?RWNWd29tZVB2YnZwOVlCZTRFdTJZY1hYN2U1MEtpR1NuaW1QK2NrRCttRU84?=
 =?utf-8?Q?WQvDD314dKzV/3H6eb3Henjkl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043cf427-2dde-4822-afee-08dd1daaa9cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 08:21:38.6647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kb8/bEvfuoak8NeuC0vZGTasUxpkpr1plM6Zsp5Fr6C2HGUs2aHGmBKMGVVTRuxH6H0GROVvkL2CLpT/+iUlQXw8ZYzF1puj1YZw4FzW1Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8417
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjQgOTo1OSBB
TQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTIvMTddIGludGVsX2lvbW11OiBBZGQgc3VwcG9y
dCBmb3IgUEFTSUQtYmFzZWQgZGV2aWNlDQo+SU9UTEIgaW52YWxpZGF0aW9uDQo+DQo+T24gRnJp
LCBTZXAgMjcsIDIwMjQgYXQgMzoxOOKAr1BNIER1YW4sIFpoZW56aG9uZw0KPjx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+DQo+Pg0KPj4gPi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+PiA+RnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4+
ID5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDEyLzE3XSBpbnRlbF9pb21tdTogQWRkIHN1cHBvcnQg
Zm9yIFBBU0lELWJhc2VkDQo+PiA+ZGV2aWNlIElPVExCIGludmFsaWRhdGlvbg0KPj4gPg0KPj4g
Pk9uIFdlZCwgU2VwIDExLCAyMDI0IGF0IDE6MjfigK9QTSBaaGVuemhvbmcgRHVhbg0KPj4gPjx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4gPj4NCj4+ID4+IEZyb206IENsw6lt
ZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4g
Pj4NCj4+ID4+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25n
IER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+ID4+IC0tLQ0KPj4gPj4gIGh3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDExICsrKysrKysrDQo+PiA+PiAgaHcvaTM4Ni9p
bnRlbF9pb21tdS5jICAgICAgICAgIHwgNTANCj4+ID4rKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+PiA+PiAgMiBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspDQo+PiA+
Pg0KPj4gPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4g
PmIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiA+PiBpbmRleCA0ZjJjM2E5MzUw
Li41MmJkYmYzYmM1IDEwMDY0NA0KPj4gPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+PiA+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ID4+
IEBAIC0zNzUsNiArMzc1LDcgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7
DQo+PiA+PiAgI2RlZmluZSBWVERfSU5WX0RFU0NfV0FJVCAgICAgICAgICAgICAgIDB4NSAvKiBJ
bnZhbGlkYXRpb24gV2FpdCBEZXNjcmlwdG9yDQo+PiA+Ki8NCj4+ID4+ICAjZGVmaW5lIFZURF9J
TlZfREVTQ19QSU9UTEIgICAgICAgICAgICAgMHg2IC8qIFBBU0lELUlPVExCIEludmFsaWRhdGUg
RGVzYw0KPj4gPiovDQo+PiA+PiAgI2RlZmluZSBWVERfSU5WX0RFU0NfUEMgICAgICAgICAgICAg
ICAgIDB4NyAvKiBQQVNJRC1jYWNoZSBJbnZhbGlkYXRlIERlc2MgKi8NCj4+ID4+ICsjZGVmaW5l
IFZURF9JTlZfREVTQ19ERVZfUElPVExCICAgICAgICAgMHg4IC8qIFBBU0lELWJhc2VkLURJT1RM
Qg0KPj4gPmludl9kZXNjKi8NCj4+ID4+ICAjZGVmaW5lIFZURF9JTlZfREVTQ19OT05FICAgICAg
ICAgICAgICAgMCAgIC8qIE5vdCBhbiBJbnZhbGlkYXRlIERlc2NyaXB0b3INCj4+ID4qLw0KPj4g
Pj4NCj4+ID4+ICAvKiBNYXNrcyBmb3IgSW52YWxpZGF0aW9uIFdhaXQgRGVzY3JpcHRvciovDQo+
PiA+PiBAQCAtNDEzLDYgKzQxNCwxNiBAQCB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52
RGVzYzsNCj4+ID4+ICAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfUlNWRF9ISSAw
eGZmZVVMTA0KPj4gPj4gICNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVklDRV9JT1RMQl9SU1ZEX0xP
IDB4ZmZmZjAwMDBmZmUwZmZmOA0KPj4gPj4NCj4+ID4+ICsvKiBNYXNrIGZvciBQQVNJRCBEZXZp
Y2UgSU9UTEIgSW52YWxpZGF0ZSBEZXNjcmlwdG9yICovDQo+PiA+PiArI2RlZmluZSBWVERfSU5W
X0RFU0NfUEFTSURfREVWSUNFX0lPVExCX0FERFIodmFsKSAoKHZhbCkgJiBcDQo+PiA+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHhmZmZmZmZm
ZmZmZmZmMDAwVUxMKQ0KPj4gPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9J
T1RMQl9TSVpFKHZhbCkgKCh2YWwgPj4gMTEpICYgMHgxKQ0KPj4gPj4gKyNkZWZpbmUgVlREX0lO
Vl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9HTE9CQUwodmFsKSAoKHZhbCkgJiAweDEpDQo+PiA+
PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1NJRCh2YWwpICgoKHZh
bCkgPj4gMTYpICYNCj4+ID4weGZmZmZVTEwpDQo+PiA+PiArI2RlZmluZSBWVERfSU5WX0RFU0Nf
UEFTSURfREVWSUNFX0lPVExCX1BBU0lEKHZhbCkgKCh2YWwgPj4gMzIpICYNCj4+ID4weGZmZmZm
VUxMKQ0KPj4gPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9SU1ZE
X0hJIDB4N2ZlVUxMDQo+PiA+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lP
VExCX1JTVkRfTE8NCj4+ID4weGZmZjAwMDAwMDAwMGYwMDBVTEwNCj4+ID4+ICsNCj4+ID4+ICAv
KiBSc3ZkIGZpZWxkIG1hc2tzIGZvciBzcHRlICovDQo+PiA+PiAgI2RlZmluZSBWVERfU1BURV9T
TlAgMHg4MDBVTEwNCj4+ID4+DQo+PiA+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiA+PiBpbmRleCBkMjhjODYyNTk4Li40Y2Y1
NjkyNGUxIDEwMDY0NA0KPj4gPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiA+PiAr
KysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ID4+IEBAIC0zMDE3LDYgKzMwMTcsNDkgQEAg
c3RhdGljIHZvaWQNCj4+ID5kb19pbnZhbGlkYXRlX2RldmljZV90bGIoVlREQWRkcmVzc1NwYWNl
ICp2dGRfZGV2X2FzLA0KPj4gPj4gICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdSgmdnRk
X2Rldl9hcy0+aW9tbXUsIDAsIGV2ZW50KTsNCj4+ID4+ICB9DQo+PiA+Pg0KPj4gPj4gK3N0YXRp
YyBib29sIHZ0ZF9wcm9jZXNzX2RldmljZV9waW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMs
DQo+PiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURElu
dkRlc2MgKmludl9kZXNjKQ0KPj4gPj4gK3sNCj4+ID4+ICsgICAgdWludDE2X3Qgc2lkOw0KPj4g
Pj4gKyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9kZXZfYXM7DQo+PiA+PiArICAgIGJvb2wgc2l6
ZTsNCj4+ID4+ICsgICAgYm9vbCBnbG9iYWw7DQo+PiA+PiArICAgIGh3YWRkciBhZGRyOw0KPj4g
Pj4gKyAgICB1aW50MzJfdCBwYXNpZDsNCj4+ID4+ICsNCj4+ID4+ICsgICAgaWYgKChpbnZfZGVz
Yy0+aGkgJiBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1JTVkRfSEkpIHx8DQo+PiA+
PiArICAgICAgICAgKGludl9kZXNjLT5sbyAmIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9U
TEJfUlNWRF9MTykpIHsNCj4+ID4+ICsgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52
YWxpZCBwYXNpZC1iYXNlZCBkZXYgaW90bGIgaW52IGRlc2M6Ig0KPj4gPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgImhpPSUiUFJJeDY0ICIocmVzZXJ2ZWQgbm9uemVybykiLA0KPj4gPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGludl9kZXNjLT5oaSk7DQo+PiA+
PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiA+PiArICAgIH0NCj4+ID4+ICsNCj4+ID4+ICsg
ICAgZ2xvYmFsID0gVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9HTE9CQUwoaW52X2Rl
c2MtPmhpKTsNCj4+ID4+ICsgICAgc2l6ZSA9IFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9U
TEJfU0laRShpbnZfZGVzYy0+aGkpOw0KPj4gPj4gKyAgICBhZGRyID0gVlREX0lOVl9ERVNDX1BB
U0lEX0RFVklDRV9JT1RMQl9BRERSKGludl9kZXNjLT5oaSk7DQo+PiA+PiArICAgIHNpZCA9IFZU
RF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfU0lEKGludl9kZXNjLT5sbyk7DQo+PiA+PiAr
ICAgIGlmIChnbG9iYWwpIHsNCj4+ID4+ICsgICAgICAgIFFMSVNUX0ZPUkVBQ0godnRkX2Rldl9h
cywgJnMtPnZ0ZF9hc193aXRoX25vdGlmaWVycywgbmV4dCkgew0KPj4gPj4gKyAgICAgICAgICAg
IGlmICgodnRkX2Rldl9hcy0+cGFzaWQgIT0gUENJX05PX1BBU0lEKSAmJg0KPj4gPj4gKyAgICAg
ICAgICAgICAgICAoUENJX0JVSUxEX0JERihwY2lfYnVzX251bSh2dGRfZGV2X2FzLT5idXMpLA0K
Pj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2dGRfZGV2
X2FzLT5kZXZmbikgPT0gc2lkKSkgew0KPj4gPj4gKyAgICAgICAgICAgICAgICBkb19pbnZhbGlk
YXRlX2RldmljZV90bGIodnRkX2Rldl9hcywgc2l6ZSwgYWRkcik7DQo+PiA+PiArICAgICAgICAg
ICAgfQ0KPj4gPj4gKyAgICAgICAgfQ0KPj4gPj4gKyAgICB9IGVsc2Ugew0KPj4gPj4gKyAgICAg
ICAgcGFzaWQgPSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1BBU0lEKGludl9kZXNj
LT5sbyk7DQo+PiA+PiArICAgICAgICB2dGRfZGV2X2FzID0gdnRkX2dldF9hc19ieV9zaWRfYW5k
X3Bhc2lkKHMsIHNpZCwgcGFzaWQpOw0KPj4gPj4gKyAgICAgICAgaWYgKCF2dGRfZGV2X2FzKSB7
DQo+PiA+PiArICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+PiA+PiArICAgICAgICB9DQo+PiA+
PiArDQo+PiA+PiArICAgICAgICBkb19pbnZhbGlkYXRlX2RldmljZV90bGIodnRkX2Rldl9hcywg
c2l6ZSwgYWRkcik7DQo+PiA+DQo+PiA+UXVlc3Rpb246DQo+PiA+DQo+PiA+SSB3b25kZXIgaWYg
Y3VycmVudCB2aG9zdCAod2hpY2ggaGFzIGEgZGV2aWNlIElPVExCIGFic3RyYWN0aW9uIHZpYQ0K
Pj4gPnZpcnRpby1wY2kpIGNhbiB3b3JrIHdpdGggdGhpcyAoUEFTSUQgYmFzZWQgSU9UTEIgaW52
YWxpZGF0aW9uKQ0KPj4NCj4+IEN1cnJlbnRseSwgaXQgZGVwZW5kcyBvbiBpZiBjYWNoaW5nLW1v
ZGUgaXMgb24uIElmIGl0J3Mgb2ZmLCB2aG9zdCB3b3Jrcy4gRS5nLjoNCj4+DQo+PiAtZGV2aWNl
IGludGVsLWlvbW11LGNhY2hpbmctbW9kZT1vZmYsZG1hLWRyYWluPW9uLGRldmljZS1pb3RsYj1v
bix4LQ0KPnNjYWxhYmxlLW1vZGU9b24NCj4+IC1uZXRkZXYgdGFwLGlkPXRhcDAsdmhvc3Q9b24s
c2NyaXB0PS9ldGMvcWVtdS1pZnVwDQo+PiAtZGV2aWNlIHZpcnRpby1uZXQtcGNpLG5ldGRldj10
YXAwLGJ1cz1yb290MCxpb21tdV9wbGF0Zm9ybT1vbixhdHM9b24NCj4+DQo+PiBJdCBkb2Vzbid0
IHdvcmsgY3VycmVudGx5IHdoZW4gY2FjaGluZy1tb2RlIGlzIG9uLg0KPj4gUmVhc29uIGlzIGxp
bnV4IGtlcm5lbCBoYXMgYW4gb3B0aW1pemF0aW9uIHRvIHNlbmQgb25seSBwaW90bGIgaW52YWxp
ZGF0aW9uLA0KPj4gbm8gZGV2aWNlLXBpb3RsYiBpbnZhbGlkYXRpb24gaXMgc2VudC4gQnV0IEkg
aGVhcmQgZnJvbSBZaSB0aGUgb3B0aW1pemF0aW9uDQo+PiB3aWxsIGJlIGRyb3BwZWQsIHRoZW4g
aXQgd2lsbCB3b3JrIHRvbyB3aGVuIGNhY2hpbmctbW9kZSBpcyBvbi4NCj4NCj5HcmVhdCwgaWYg
cG9zc2libGUgcGxlYXNlIGNvcHkgbWUgd2hlbiBzZW5kaW5nIHRob3NlIGZpeGVzLg0KDQpGWUks
IEkganVzdCBmb3VuZCB0aGUgb3B0aW1pemF0aW9uIGhhZCBhbHJlYWR5IGJlZW4gZHJvcHBlZCBz
aW5jZSBBcHJpbCAyMDI0IGJ5IGNvbW1pdCBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD0zMDRiM2JkZTI0
YjU4NTE1YTc1ZmQxOThiZWI1MmNhNTdkZjYyNzVmDQoNCkFmdGVyIHVwZGF0aW5nIGd1ZXN0IGtl
cm5lbCB0byBhIG5ldyB2ZXJzaW9uIGNvbnRhaW5pbmcgYWJvdmUgY29tbWl0LA0Kdmhvc3Qgd29y
a3MgaXJyZXNwZWN0aXZlIHRoZSB2YWx1ZSBvZiBjYWNoaW5nLW1vZGUuDQoNClRoYW5rcw0KWmhl
bnpob25nDQo=

