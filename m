Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C636C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWy8x-0000kL-QF; Wed, 02 Jul 2025 10:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWy8t-0000jZ-TG
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:08:57 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWy8r-0006Ko-2p
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751465333; x=1783001333;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vzi90AmrjkI48oH2zdu5qZOCwV2E51YnOoiiLC0NNow=;
 b=oJupkSZxBg/ukBt5hOoBuThl+o3/ItxU82TSh8PTyLqSezlQa0GG9kHG
 RJBWdpgQYOU5gK2N+QwtlSMZUi7RgmfpqUxcI4i5LDpcGd0MHfIFv0rXa
 KldXiDYkrkUK8KIivVheK/M7QfsKLLdXOWiOzMO2ycOEch6u5n1/z7SOg
 wsnksLrnpNddkyjd4dOvlhXzX9y9KAppvYYBq+TLHWZc5Qnv5h/VSEzkw
 Pgxn3lbKDQ/DoPCwOLIpk0kBuKTje39ZqH/oCw0+owCnhlRQ0mGt4Zmtl
 5SSWyWMr1g9Y8vK6CyB4E+Kbq1epOgVLq8QX6ZBX/UC4QHvcVQaHXNxZi Q==;
X-CSE-ConnectionGUID: eUmDwTuHSjinprSP8+UpFg==
X-CSE-MsgGUID: MisBrk7hTsOoStrZ5IXbLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64809364"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="64809364"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 07:08:49 -0700
X-CSE-ConnectionGUID: MsA9z57XTa2+51bQg1Tnuw==
X-CSE-MsgGUID: rB/c2kF4T+2mKq1sl4kLrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="159778378"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 07:08:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 07:08:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 07:08:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.81)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 07:08:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6uzQDNLeLm8RCHa/B+ZeTMpT5qFLyWVvJVzugEx5tuB8MnWj2A/W4rC0a89PfUWyoTl7LG09ZO4pmvN0E5B8PrNw3ASHoLSnrADUEWoQ6UETkrocChISotgsZb9Cqct0IphLwhfSfG6WnU7X4z40qEigJzh4pVqd65QFm13ebEAHQEXmDrP7ZCENHt7tLfLW95J5N0IxIekZTJLq/9irI/3udt+ERrl6LyAi7lI85qEFWvB5QNrWhtsTdGwJZEw9e6DieiTlCjxTSZ07ufir6KodW7Aa6wNjkAG+0tCIx41dyuM+fqVFOBLys/Lp6/RjGq9xaxyTKRPNbuUm0aPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzi90AmrjkI48oH2zdu5qZOCwV2E51YnOoiiLC0NNow=;
 b=q4mxRljealCcih59Y8MDQ4hfpQIFQZXAJbYWCtvpoD9Hrj73LF3adj1ApunXpzY2Ca5IwEmr0prPrqSbn7Yf7ZE9NwOQWVrngorTcbFLAM9Vw6R+Ph6W06Hffhb96qVg4DPjp44/vU3lAaEpk01r8dHpztCMOuCqgaSfZ2rasrrXWZHJ9OcNhjkDJLAimLh9A8cgDmqVNGSBZph5XjqfJl5R6KNAb5xz+y9QPgwSKzZgWgsISqBLgl1rZejnPJg6MfPFGXaWbHDSDkmnzpsU08SXgsB5GMSfWbnVBCpVbDSNs+CrPWaRF6vlBhEF5Anf9mNpxKPxytNi+jVvSCPWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB7183.namprd11.prod.outlook.com (2603:10b6:8:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 2 Jul
 2025 14:08:45 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 2 Jul 2025
 14:08:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 32/38] vfio/iommufd: preserve descriptors
Thread-Topic: [PATCH V5 32/38] vfio/iommufd: preserve descriptors
Thread-Index: AQHb2h4gQH+JbpON4UagdDOZcgrkKbQSRDbwgAsvxICAAY0c8A==
Date: Wed, 2 Jul 2025 14:08:45 +0000
Message-ID: <IA3PR11MB9136499D70B48A9E44F1F1119240A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-33-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136E189D71587ED549F823F927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <01a73b7a-1586-43eb-b6d1-c3ea78915c30@oracle.com>
In-Reply-To: <01a73b7a-1586-43eb-b6d1-c3ea78915c30@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB7183:EE_
x-ms-office365-filtering-correlation-id: 1997d4b8-0bff-4890-8f87-08ddb971f58e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WWo4c0x6bzFzQ0RyalFHWWdEUlE5YUc5KzFhN3NtMlVtbEZBWVJhMjBwWTlZ?=
 =?utf-8?B?MDFoeUQ5UncwZmxrZy91eWVtU0NWNkFXOE9tVyt6cG1HT1BzWEJZK2FQR0w3?=
 =?utf-8?B?elRnS2hQU1pDOWdhVEFURk9iQll6QlJ4bnNKWFFDMVZWdTJjdVk4bUpnQWhr?=
 =?utf-8?B?WURoSVU5cXdaUmhyNVc5QkxiSUFFZjBNS2srTXNtTWg3cTZmS1NBWmJCUW5E?=
 =?utf-8?B?bzRLa0ZHSGpJeWZUN3NaOUNVT2RqM0UzME9TWkM0SmNzWHNXVzdMZU9qRzda?=
 =?utf-8?B?WVRjdnF4bnpOUFFZY0xUdHVSNEtRdXh4anVKR0Z3emkwRUplbmpERFRGYWdQ?=
 =?utf-8?B?dUR3NWYzaWNPWlBzeEdBV0xlTjBpNjU2L01Ra2wvSE9SRWMrbWVsbUFmR1Vo?=
 =?utf-8?B?NHJTSC9FbnhzOWxZSFVjcGY2MHpGcGlHTm1JbFNGOTNaVjBRUGNialUwZWF0?=
 =?utf-8?B?bmprQnpsNEdYTTRrbGN4QXdhUEdmZmliSUNtSS9sSndJZjRJRmhUK1ZFVk8y?=
 =?utf-8?B?YkpwSzJsT1RINHlibGNHTThEOTFsRE0vVm91eFNWVm4wWDl2RUJacThmQ0w5?=
 =?utf-8?B?UEg1bGVubFZkV3Y2dUhGY1hsRElGQU0xNnZ3MWVKZUErbmRWT3pBWUxnMEdI?=
 =?utf-8?B?Mk05N0VVUEhiNzFzNXlTVm42WFlPSzJ6RGV3MVpIdWtIdGY3NWFYVFRRRGpl?=
 =?utf-8?B?MGpKYWVaaFR6c3BMOW9ETXY1cXRuZk15M0hjUHBrVE9Ra3FnY1BDSkV4RnBy?=
 =?utf-8?B?S3NydkNFbkJUMGpROUNLYWt3QjNNSENXaG94eUU2R2I5T3k0ZzJqRUJMOVZX?=
 =?utf-8?B?em81U0EzVDlhcmpVcjUwK3N4WW11QlN5WUFaYlBvY0tSdHRDVGI2WnZkL0Y2?=
 =?utf-8?B?QXR3c3JPa2hTNHN4dHZxN0FhVERWNXY0VTg3eDd3bXNxMVAvL04wRmJXZGpF?=
 =?utf-8?B?cDUxelBtUnRwZ2VBcWZLTlJ1SGN1MFdJZGFIVWpudDI3eldhMnJ3VkxZRElR?=
 =?utf-8?B?eFFCaVNEZy9FYUxBbm1ucE1SY3lOd0RRZ0tmR1Y2TDF6d3psc2p4dHBoeHJC?=
 =?utf-8?B?R1REUkVsZXliMVc0L2FsaEo5MzMwTCtaK2FZd3dyUlZsSzR1c284UEdPa1ZT?=
 =?utf-8?B?ZlIzM29OeWZMbWEySUhXbkMzRTdQU1JGUzhxQzl0RU5sQ3QrTExiWkFFMzUx?=
 =?utf-8?B?eEc4RGE3bXdpSXJNZzN2VGJFVWE1QzBPdmY1K1VqSzVPUWh0NmlvMWN6eEFa?=
 =?utf-8?B?SFBVZEV0aTJiTXRLMGNrSXcxUUxGa3NTMWtVYkFRSm9aLzlRREcxV1pqbjNJ?=
 =?utf-8?B?WjhzeGh2MVR4OFRJMDZtcVlXdVFBdkMzNWRtb2FpUWswYTZuQUdNNVByMVVV?=
 =?utf-8?B?bUR2c3VTd2lXMTUrWEt3enRQWU9KZmk3MUZkdFNVY21vTnlLR3Y4SzFOQkNo?=
 =?utf-8?B?SGFuM2l5MHhpajI0d3c5T0RGbEFRUXBNdFFoalhwQWl1NFgvVUNYL1RjclNW?=
 =?utf-8?B?WVgzNVVRK1BqN2k1ME9LM0pGdlpoeFlUSXlqcVhEdGtESkxVb3F1bENGVTIx?=
 =?utf-8?B?bzZvM2poY0NkVFRNYVV6UWtEbURVZ2ZNUWhIazhXUkhSRVZmcTlNdDBpNXd2?=
 =?utf-8?B?NFVteFhzcTB6QTJaK3YrUjRaaFFYaVBtU0VpbjFIS1dSSnJ6L3d4TUNvdERU?=
 =?utf-8?B?a1ZzSmdaVm55QXBCWU1QM2xzUHJjbmhYVEdpZVlqZzBiZm9OcW1XV1E3RHFX?=
 =?utf-8?B?dXFzMkpKUmJJSnJrREZaWUV4cDVlU2tYVjFwM3FJWXZxTVA2bUNYeitlWWVZ?=
 =?utf-8?B?SXJxejZrc2J4dDA2dWxBb0R1RkFndlJ0QlJoa3ZOWFR4U1h1YlUyTjZzNy9R?=
 =?utf-8?B?YlVRYmM0VngrNE1xRmxISTBndVh2QkpXZDBnYjhZcUxmWTlKb2tseEpQVmNm?=
 =?utf-8?B?T3lnbUVMdzVZeW0wU2g2ckd4ZlFYc2tOdDVmMVR2ZHkyTk1UUng1WGlyc0sy?=
 =?utf-8?Q?vjWCfTGftRb4CwgEaObuZm8MWRIR+I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlBDVGJaM0FTeUVYY2kwWUptTzNKckFITGZUZGc0SjFHQmp3UTZ2a3Z3VW13?=
 =?utf-8?B?TjU0azVQQW9IaGNKcnpTajBlQVhzeW9xck9oL1FiRDRHeUhTWTRaUkRERW5H?=
 =?utf-8?B?aGtxdk9LSjlnTE9PS0VLUjJPNm5obThxS05aNXluRDdVTVdQK1RubnZqUDht?=
 =?utf-8?B?WjJkaitrcUY0TUYweEovYmRLUzRRSGJUMThtYnN2dVV2QmdLVDRaTzl4ZnBp?=
 =?utf-8?B?ajFab1pOczBuL21WZDFDOWpvaDRQYjE0aHkwVE5nTjkxL3F0NlJmbzN1VmNC?=
 =?utf-8?B?dzc5SVB2TndJV3ZLVlEwdXlwUGgxNEM3eEFwUmxOV2lPeVUwU3ZoblhKSmhz?=
 =?utf-8?B?eVA3TlVWbUtVUS9kNjYzbndLVEdrZm1UdkZBT3k3TGdJV2VoOERVQkRXUmUy?=
 =?utf-8?B?KytiUXBjcE1leUlqRnA3MTJZc3JacWg1UHo2WktBZTJrUlBXK0JhTE8yZFUy?=
 =?utf-8?B?djNvYnVPTHZucHR3YThxajlWWkphWDhkajZWWnhBdGwxeTNKNDdpTEJPMDRU?=
 =?utf-8?B?ZVlueUh6Nk4zbzYxc3daSVA2TFUrL0FZcTBUSFo4aWJmTzhmNXJzU0xrRlV4?=
 =?utf-8?B?SUpLNHFYVUdWUDY2SGtzSWczdzJJNC80Zk0zdjJNQ3BkMkowd05ZblpXMmFZ?=
 =?utf-8?B?MFZnYlFRcG9EUXBFTzAzWjVzaHRkM0FZWHRHRFBvTFlNcFpQZXZoRmExeFdo?=
 =?utf-8?B?c1pIM3ROVWoxZ3ZDeGdhY3dtRGMzZGtSUlQzUnhtdmlsM24xQWgzb2RHQ0Zs?=
 =?utf-8?B?NEVoNTk4RG94cmc2L0s3d21qeWFSMzJBZjhhMi9qYnF4OEhOOWs5QW1Fb0tM?=
 =?utf-8?B?eWVQdEswckV5ellDZkNIUmI2TmhzLzdpbThWck8wMWdTeWR6UjRIMy9LRVpF?=
 =?utf-8?B?WVZHQml2SllZQnNMUnd1ZWVGV2Zyck80RlBpL0RKVUo4Z3FsZEpKV1Y3cHhY?=
 =?utf-8?B?R3p4OWlrRW90VElDak9UckhiWVVMZTFZZ0hwMUJOQ2k0QzZBejZQM3BGT29k?=
 =?utf-8?B?ZjFkQnRjS0tnSytBMmFlZ2ZPaWl2dTJMc1lEdjQzSmhKWlNuWHJ1b1NZNCtU?=
 =?utf-8?B?WkwxS2Y4aVhKd1ppT0ppVS9tVUV5TzhMbGo4STBzd29qejdKeklMNVJqcUhw?=
 =?utf-8?B?b0toVUhuUnQ2b0JmSjZWaVI1NkNKRDRyQXF5TU5kRTM4ck16VjF5bGg0bVBY?=
 =?utf-8?B?KzUwRGJRWXJkd1I0MFM1bG1YV2JoUm5MSEQ3NkI1R3ZyTlczYThtNlpiNnVT?=
 =?utf-8?B?ZlVvT01pY3FmMkFZNTUxOStqOEEyOGozRkp3aW8zbUhkdE5Qcmo4c2lRZTdt?=
 =?utf-8?B?aWt6SFRTMHZLMFh3QmxJdkgya3dJQzBrU1R1UVI3RS9vMEo5QzdyemxsZ3pq?=
 =?utf-8?B?cG0xRllvMTA2VGhsYVVQUEdORmhiT0JTejRkQkZqR01OZFFVTTdmK0NVQnNZ?=
 =?utf-8?B?WXJ0L2haNnR6YlBZOUU0d2YyRHVjdGhRc1BlbWt0czVrSEhCU3Q4VkdManFX?=
 =?utf-8?B?eVVxaWlFNC9wMndDb3k2bThYMUx2NUNGRDZTZS9lYktyZGtDcjBWM1VEbE5v?=
 =?utf-8?B?NllSYmg5TFVHaVplUlF1dzNXYmRxUmZFVVhkK0pwNkthZTEzQ3hvTDdVRlR6?=
 =?utf-8?B?akFZeFFqaU9VajkrSHB4d3ltVkQvelNYZnp6Q1d3eE9HaXFNVVBQL1JFZFRB?=
 =?utf-8?B?TkJIQU9KQUtGVG9qdWM0cVlZeGh3M0hycE5UMFB4eFdqVll5U2RFM01NbEw4?=
 =?utf-8?B?aW10WGlmbFdqK1JTRFp6VzcwY0J4K1o0OSttRTRWb0M0aUhuZGc2Q1FKVnI3?=
 =?utf-8?B?bG9YcFdLNEpBdEhUWG4zbHc0MENpeU9FaUlXTE0wQmxYcTVyUjhJVmlDLzFz?=
 =?utf-8?B?MEc0QjhuRlpxMnhLTXdhNVI2R0VyN1JMT0dMLzZFZ2RCaTdTQ3VGYlB4RXRW?=
 =?utf-8?B?Wm1sTmFRZGtWaU16d2Q3bnNBT0lXaVVGOVVWMWx3NHNCQXNQUkpJUS82TTRI?=
 =?utf-8?B?VUJIVGJiaG16Z2NZaWp6SWxyK1JxdSsvazMzcVhzRXVTWCtaRmE4ZFJtQzVJ?=
 =?utf-8?B?aG8zS1BLS2xBeUs2WktiTXRSMHMxbmwydXRqeGNWL0FrVHlCUGgxaWNVL0Vy?=
 =?utf-8?Q?4Tw10my+CdJpWYqn/jrHxxNn9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1997d4b8-0bff-4890-8f87-08ddb971f58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 14:08:45.8084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBObMLq8ugNBgxgi/zcLYczQmFaZe4WGcoez8f33oRO7lMZJz3k00SwTEsWFiL+mBoaSMdu6944xPoIJEYGiDlrcCNsgmWFQIcSBhiklDPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7183
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUgMzIvMzhd
IHZmaW8vaW9tbXVmZDogcHJlc2VydmUgZGVzY3JpcHRvcnMNCj4NCj5PbiA2LzI1LzIwMjUgNzo0
MCBBTSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+Pj4gRnJvbTogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4N
Cj4+PiBTdWJqZWN0OiBbUEFUQ0ggVjUgMzIvMzhdIHZmaW8vaW9tbXVmZDogcHJlc2VydmUgZGVz
Y3JpcHRvcnMNCj4+Pg0KPj4+IFNhdmUgdGhlIGlvbW11IGFuZCB2ZmlvIGRldmljZSBmZCBpbiBD
UFIgc3RhdGUgd2hlbiBpdCBpcyBjcmVhdGVkLg0KPj4+IEFmdGVyIENQUiwgdGhlIGZkIG51bWJl
ciBpcyBmb3VuZCBpbiBDUFIgc3RhdGUgYW5kIHJldXNlZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+Pj4gLS0tDQo+
Pj4gYmFja2VuZHMvaW9tbXVmZC5jICAgIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
Pj4+IGh3L3ZmaW8vY3ByLWlvbW11ZmQuYyB8IDEwICsrKysrKysrKysNCj4+PiBody92ZmlvL2Rl
dmljZS5jICAgICAgfCAgOSArLS0tLS0tLS0NCj4+PiAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2Vy
dGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMv
aW9tbXVmZC5jIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+Pj4gaW5kZXggYzU1NGNlNS4uZTAyZjA2
ZSAxMDA2NDQNCj4+PiAtLS0gYS9iYWNrZW5kcy9pb21tdWZkLmMNCj4+PiArKysgYi9iYWNrZW5k
cy9pb21tdWZkLmMNCj4+PiBAQCAtMTYsMTIgKzE2LDE4IEBADQo+Pj4gI2luY2x1ZGUgInFlbXUv
bW9kdWxlLmgiDQo+Pj4gI2luY2x1ZGUgInFvbS9vYmplY3RfaW50ZXJmYWNlcy5oIg0KPj4+ICNp
bmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPj4+ICsjaW5jbHVkZSAibWlncmF0aW9uL2Nw
ci5oIg0KPj4+ICNpbmNsdWRlICJtb25pdG9yL21vbml0b3IuaCINCj4+PiAjaW5jbHVkZSAidHJh
Y2UuaCINCj4+PiAjaW5jbHVkZSAiaHcvdmZpby92ZmlvLWRldmljZS5oIg0KPj4+ICNpbmNsdWRl
IDxzeXMvaW9jdGwuaD4NCj4+PiAjaW5jbHVkZSA8bGludXgvaW9tbXVmZC5oPg0KPj4+DQo+Pj4g
K3N0YXRpYyBjb25zdCBjaGFyICppb21tdWZkX2ZkX25hbWUoSU9NTVVGREJhY2tlbmQgKmJlKQ0K
Pj4+ICt7DQo+Pj4gKyAgICByZXR1cm4gb2JqZWN0X2dldF9jYW5vbmljYWxfcGF0aF9jb21wb25l
bnQoT0JKRUNUKGJlKSk7DQo+Pj4gK30NCj4+PiArDQo+Pj4gc3RhdGljIHZvaWQgaW9tbXVmZF9i
YWNrZW5kX2luaXQoT2JqZWN0ICpvYmopDQo+Pj4gew0KPj4+ICAgICAgSU9NTVVGREJhY2tlbmQg
KmJlID0gSU9NTVVGRF9CQUNLRU5EKG9iaik7DQo+Pj4gQEAgLTY0LDExICs3MCwyNyBAQCBzdGF0
aWMgYm9vbA0KPj4+IGlvbW11ZmRfYmFja2VuZF9jYW5fYmVfZGVsZXRlZChVc2VyQ3JlYXRhYmxl
ICp1YykNCj4+PiAgICAgIHJldHVybiAhYmUtPnVzZXJzOw0KPj4+IH0NCj4+Pg0KPj4+ICtzdGF0
aWMgdm9pZCBpb21tdWZkX2JhY2tlbmRfY29tcGxldGUoVXNlckNyZWF0YWJsZSAqdWMsIEVycm9y
ICoqZXJycCkNCj4+PiArew0KPj4+ICsgICAgSU9NTVVGREJhY2tlbmQgKmJlID0gSU9NTVVGRF9C
QUNLRU5EKHVjKTsNCj4+PiArICAgIGNvbnN0IGNoYXIgKm5hbWUgPSBpb21tdWZkX2ZkX25hbWUo
YmUpOw0KPj4+ICsNCj4+PiArICAgIGlmICghYmUtPm93bmVkKSB7DQo+Pj4gKyAgICAgICAgLyog
ZmQgY2FtZSBmcm9tIHRoZSBjb21tYW5kIGxpbmUuIEZldGNoIHVwZGF0ZWQgdmFsdWUgZnJvbQ0K
PmNwciBzdGF0ZS4gKi8NCj4+PiArICAgICAgICBpZiAoY3ByX2lzX2luY29taW5nKCkpIHsNCj4+
PiArICAgICAgICAgICAgYmUtPmZkID0gY3ByX2ZpbmRfZmQobmFtZSwgMCk7DQo+Pj4gKyAgICAg
ICAgfSBlbHNlIHsNCj4+PiArICAgICAgICAgICAgY3ByX3NhdmVfZmQobmFtZSwgMCwgYmUtPmZk
KTsNCj4+PiArICAgICAgICB9DQo+Pg0KPj4gTWF5YmUgdGhpcyBjYW4gYmUgaGFuZGxlZCBpbiBp
b21tdWZkX2JhY2tlbmRfc2V0X2ZkKCkgaW5zdGVhZCBvZg0KPmludHJvZHVjaW5nDQo+PiBjb21w
bGV0ZSBjYWxsYmFjaz8NCj4NCj5BZnJhaWQgbm90LiAgaW9tbXVmZF9mZF9uYW1lIC0+IG9iamVj
dF9nZXRfY2Fub25pY2FsX3BhdGhfY29tcG9uZW50DQo+bmVlZHMgdGhlDQo+cGFyZW50LCB3aGlj
aCBpcyBub3Qgc2V0IHlldCBpbiBpb21tdWZkX2JhY2tlbmRfc2V0X2ZkLiBUaGUgY29tcGxldGUN
Cj5jYWxsYmFjaw0KPnNvbHZlZCB0aGF0IHByb2JsZW0gbmljZWx5Lg0KPg0KPj4gQ2FuIHdlIGNh
bGwgY3ByX2dldF9mZF9wYXJhbSgpPw0KPg0KPk5vLiAgVGhhdCBvbmUgZXhwZWN0cyB0byBnZXQg
dGhlIG5hbWUgZnJvbSBtb25pdG9yX2ZkX3BhcmFtLg0KDQpPSw0KDQo+DQo+Pj4gKyAgICB9DQo+
Pj4gK30NCj4+PiArDQo+Pj4gc3RhdGljIHZvaWQgaW9tbXVmZF9iYWNrZW5kX2NsYXNzX2luaXQo
T2JqZWN0Q2xhc3MgKm9jLCBjb25zdCB2b2lkICpkYXRhKQ0KPj4+IHsNCj4+PiAgICAgIFVzZXJD
cmVhdGFibGVDbGFzcyAqdWNjID0gVVNFUl9DUkVBVEFCTEVfQ0xBU1Mob2MpOw0KPj4+DQo+Pj4g
ICAgICB1Y2MtPmNhbl9iZV9kZWxldGVkID0gaW9tbXVmZF9iYWNrZW5kX2Nhbl9iZV9kZWxldGVk
Ow0KPj4+ICsgICAgdWNjLT5jb21wbGV0ZSA9IGlvbW11ZmRfYmFja2VuZF9jb21wbGV0ZTsNCj4+
Pg0KPj4+ICAgICAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X2FkZF9zdHIob2MsICJmZCIsIE5VTEws
DQo+aW9tbXVmZF9iYWNrZW5kX3NldF9mZCk7DQo+Pj4gfQ0KPj4+IEBAIC0xMDIsNyArMTI0LDcg
QEAgYm9vbA0KPmlvbW11ZmRfYmFja2VuZF9jb25uZWN0KElPTU1VRkRCYWNrZW5kICpiZSwNCj4+
PiBFcnJvciAqKmVycnApDQo+Pj4gICAgICBpbnQgZmQ7DQo+Pj4NCj4+PiAgICAgIGlmIChiZS0+
b3duZWQgJiYgIWJlLT51c2Vycykgew0KPj4+IC0gICAgICAgIGZkID0gcWVtdV9vcGVuKCIvZGV2
L2lvbW11IiwgT19SRFdSLCBlcnJwKTsNCj4+PiArICAgICAgICBmZCA9IGNwcl9vcGVuX2ZkKCIv
ZGV2L2lvbW11IiwgT19SRFdSLA0KPmlvbW11ZmRfZmRfbmFtZShiZSksIDAsIGVycnApOw0KPj4+
ICAgICAgICAgIGlmIChmZCA8IDApIHsNCj4+PiAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
Pj4+ICAgICAgICAgIH0NCj4+PiBAQCAtMTM0LDYgKzE1Niw3IEBAIHZvaWQNCj5pb21tdWZkX2Jh
Y2tlbmRfZGlzY29ubmVjdChJT01NVUZEQmFja2VuZA0KPj4+ICpiZSkNCj4+PiBvdXQ6DQo+Pj4g
ICAgICBpZiAoIWJlLT51c2Vycykgew0KPj4+ICAgICAgICAgIHZmaW9faW9tbXVmZF9jcHJfdW5y
ZWdpc3Rlcl9pb21tdWZkKGJlKTsNCj4+PiArICAgICAgICBjcHJfZGVsZXRlX2ZkKGlvbW11ZmRf
ZmRfbmFtZShiZSksIDApOw0KPj4NCj4+IEkgdGhpbmsgd2Ugc2hvdWxkbid0IGNhbGwgdGhpcyBp
ZiBub3Qgb3duZWQuDQo+DQo+SSBhZ3JlZSwgdGhhbmtzLCBhbmQgYSBtaXNtZXJnZSBkdXJpbmcg
cmViYXNlIHB1dCB0aGUgb3V0IGxhYmVsIGluIHRoZSB3cm9uZw0KPnBsYWNlLg0KPkl0IHNob3Vs
ZCBiZToNCj4NCj52b2lkIGlvbW11ZmRfYmFja2VuZF9kaXNjb25uZWN0KElPTU1VRkRCYWNrZW5k
ICpiZSkNCj57DQo+ICAgICBpZiAoIWJlLT51c2Vycykgew0KPiAgICAgICAgIGdvdG8gb3V0Ow0K
PiAgICAgfQ0KPiAgICAgYmUtPnVzZXJzLS07DQo+ICAgICBpZiAoIWJlLT51c2Vycykgew0KPiAg
ICAgICAgIHZmaW9faW9tbXVmZF9jcHJfdW5yZWdpc3Rlcl9pb21tdWZkKGJlKTsNCj4gICAgICAg
ICBpZiAoYmUtPm93bmVkKSB7DQo+ICAgICAgICAgICAgIGNwcl9kZWxldGVfZmQoaW9tbXVmZF9m
ZF9uYW1lKGJlKSwgMCk7DQo+ICAgICAgICAgICAgIGNsb3NlKGJlLT5mZCk7DQo+ICAgICAgICAg
ICAgIGJlLT5mZCA9IC0xOw0KPiAgICAgICAgIH0NCj4gICAgIH0NCj5vdXQ6DQo+ICAgICB0cmFj
ZV9pb21tdWZkX2JhY2tlbmRfZGlzY29ubmVjdChiZS0+ZmQsIGJlLT51c2Vycyk7DQo+fQ0KDQpM
b29rcyBnb29kLg0KDQo+DQo+Pj4gICAgICB9DQo+Pj4gICAgICB0cmFjZV9pb21tdWZkX2JhY2tl
bmRfZGlzY29ubmVjdChiZS0+ZmQsIGJlLT51c2Vycyk7DQo+Pj4gfQ0KPj4+IGRpZmYgLS1naXQg
YS9ody92ZmlvL2Nwci1pb21tdWZkLmMgYi9ody92ZmlvL2Nwci1pb21tdWZkLmMNCj4+PiBpbmRl
eCAyZWNhOGE2Li4xNTJhNjYxIDEwMDY0NA0KPj4+IC0tLSBhL2h3L3ZmaW8vY3ByLWlvbW11ZmQu
Yw0KPj4+ICsrKyBiL2h3L3ZmaW8vY3ByLWlvbW11ZmQuYw0KPj4+IEBAIC0xNjIsMTcgKzE2Miwy
NyBAQCB2b2lkDQo+Pj4gdmZpb19pb21tdWZkX2Nwcl91bnJlZ2lzdGVyX2NvbnRhaW5lcihWRklP
SU9NTVVGRENvbnRhaW5lcg0KPipjb250YWluZXIpDQo+Pj4gdm9pZCB2ZmlvX2lvbW11ZmRfY3By
X3JlZ2lzdGVyX2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldikNCj4+PiB7DQo+Pj4gICAgICBp
ZiAoIWNwcl9pc19pbmNvbWluZygpKSB7DQo+Pj4gKyAgICAgICAgLyoNCj4+PiArICAgICAgICAg
KiBCZXdhcmUgZmQgbWF5IGhhdmUgYWxyZWFkeSBiZWVuIHNhdmVkIGJ5DQo+dmZpb19kZXZpY2Vf
c2V0X2ZkLA0KPj4+ICsgICAgICAgICAqIHNvIGNhbGwgcmVzYXZlIHRvIGF2b2lkIGEgZHVwbGlj
YXRlIGVudHJ5Lg0KPj4+ICsgICAgICAgICAqLw0KPj4+ICsgICAgICAgIGNwcl9yZXNhdmVfZmQo
dmJhc2VkZXYtPm5hbWUsIDAsIHZiYXNlZGV2LT5mZCk7DQo+Pj4gICAgICAgICAgdmZpb19jcHJf
c2F2ZV9kZXZpY2UodmJhc2VkZXYpOw0KPj4+ICAgICAgfQ0KPj4+IH0NCj4+Pg0KPj4+IHZvaWQg
dmZpb19pb21tdWZkX2Nwcl91bnJlZ2lzdGVyX2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldikN
Cj4+PiB7DQo+Pj4gKyAgICBjcHJfZGVsZXRlX2ZkKHZiYXNlZGV2LT5uYW1lLCAwKTsNCj4+PiAg
ICAgIHZmaW9fY3ByX2RlbGV0ZV9kZXZpY2UodmJhc2VkZXYtPm5hbWUpOw0KPj4+IH0NCj4+Pg0K
Pj4+IHZvaWQgdmZpb19jcHJfbG9hZF9kZXZpY2UoVkZJT0RldmljZSAqdmJhc2VkZXYpDQo+Pj4g
ew0KPj4+ICsgICAgaWYgKHZiYXNlZGV2LT5mZCA8IDApIHsNCj4+PiArICAgICAgICB2YmFzZWRl
di0+ZmQgPSBjcHJfZmluZF9mZCh2YmFzZWRldi0+bmFtZSwgMCk7DQo+Pg0KPj4gTWF5YmUgY2Fs
bCB0aGlzIGFmdGVyIGNoZWNraW5nIGNwcl9pc19pbmNvbWluZygpPw0KPg0KPlRoYXQgaXMgbm90
IG5lY2Vzc2FyeSwgYmVjYXVzZSBjcHJfZmluZF9mZCByZXR1cm5zIC0xIGlmICFjcHJfaXNfaW5j
b21pbmcoKSwNCj5idXQgSSdsbCBjaGFuZ2UgaXQgc28gdGhlIGludGVudCBiZWNvbWVzIGNsZWFy
ZXI6DQo+DQo+dm9pZCB2ZmlvX2Nwcl9sb2FkX2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldikN
Cj57DQo+ICAgICBpZiAoY3ByX2lzX2luY29taW5nKCkpIHsNCj4gICAgICAgICBib29sIHJldCA9
IHZmaW9fY3ByX2ZpbmRfZGV2aWNlKHZiYXNlZGV2KTsNCj4gICAgICAgICBnX2Fzc2VydChyZXQp
Ow0KPg0KPiAgICAgICAgIGlmICh2YmFzZWRldi0+ZmQgPCAwKSB7DQo+ICAgICAgICAgICAgIHZi
YXNlZGV2LT5mZCA9IGNwcl9maW5kX2ZkKHZiYXNlZGV2LT5uYW1lLCAwKTsNCj4gICAgICAgICB9
DQo+ICAgICB9DQo+fQ0KDQpMb29rcyBnb29kLCB3aXRoIGFib3ZlIGNoYW5nZXMsDQoNClJldmll
d2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFu
a3MNClpoZW56aG9uZw0K

