Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5769CC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8yv-0002wH-AL; Wed, 12 Aug 2026 09:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wu8yt-0002sj-Iy
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:26:55 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wu8yq-0001sJ-Qw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786541211; x=1818077211;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=d3FO2GnEzb+D3Gow6oUAdXcneZlP1YOAIjhcZ1nLpL0=;
 b=V4cboQSLVl2X2JQj0u9pgRNOAyLE1EjhYDULVzcSMLulSMmjAPObT2OB
 dVoanmqOMg96cCO2x8pAD1T5OgDP+sem3npmvt/rf56VPxVwo5aHwqb3w
 d731HqU7a3MDVCuuWEqz8jK7fm8bvAUyOkyrZbCtGx/VUUuzJions3b89
 Dx3RhNbPIoM+gR1jrfpQsOKPvS/I33oVaYPrDCegUAEJvM5VBRuQhOBlT
 4Mkpw1T+BMUWKdhWlmM+pUeHA+3e+zHxrnHv5am0aVKhyLrdeRMJalgbT
 Ga88Fobzu0IMPif9mQ/CnapH3m5ujERO8qzTylVH95ILm4kL4uJJSpVCO g==;
X-CSE-ConnectionGUID: yZ9R1DATTUmmv8G+dmKjBw==
X-CSE-MsgGUID: RbazXP/QRCyjK3cnC9fTHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="104628876"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="104628876"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 06:26:49 -0700
X-CSE-ConnectionGUID: r9OICKOAQM2Isom9mJxs0g==
X-CSE-MsgGUID: PpI7S1SkS9GSxtgHurYfJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="257452113"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 06:26:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 06:26:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 06:26:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 06:26:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzC4vBiieB+a3Bw6MZXUxUTMcbIXyR+65/Q14g61UCqw0lrtSIl5MGIxPvjhW8M0VqdS2FbjlT0AhUNnUyF/jDKHnvbm6N/R8gln42R9uoL55yRU/fzj/Y+il2dBCCGdS/Eupatmn5tNkAEa5mJhx+c0ggBJtZNoxVfN2EYiRZc3S7HKuI55QfzTydakfzqgCux8zdYAxfXOjwfer5l9ysdUazB5kMHTUB+yLD6CV+K/PbNQNqJGwZgYVfuzMdnzy4ZgQlu/+Pv1HHxdqHPkgkONUyja489iCqE4S7Tgs/qtTk2q7twiOSNzgFVZgu2JkZZnKuX3Y8iaauTWiGdCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3FO2GnEzb+D3Gow6oUAdXcneZlP1YOAIjhcZ1nLpL0=;
 b=NMUFVgVP7GuwoQfHrvQihql6bCIDa2iAGNcWdiflm98fA7i+QYFmM8+yWDrzJpSdsLjO0Hdo1SbZlslPxBJ9IyfYbWkzlKnR3WDULQkPE/QoGvj8JTH3Rg9pRXrzI37csC+R6GykXiBi5B6JsXk735/ylTGqCGxck8hE/MHzueprQeeRKLLsQ7oYjOWo/su5PQM1oZOAog2YN/SJHDxDNtPZstRb3xZaV2XKh13XeHA/qZliHAnoLIzilkhbZwF21Y5LnwivIYsLftw1TJ2bO2NsCI2goiAYd0jhFxp3BI4xmcs1XDxicrusNb5d1fIVkyy5elJ42OlMW+24pxON6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB8035.namprd11.prod.outlook.com (2603:10b6:510:245::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 13:26:45 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 13:26:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Topic: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHdJXaoJ2foc7Rrs0CFGZilBc0gdraUUwKAgALNe6CAAAbZgIADRW4w
Date: Wed, 12 Aug 2026 13:26:45 +0000
Message-ID: <IA3PR11MB9136F6CEC9314AD408EFFE7992DC2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <45013c8a3fe7983ee31f52d9d9ba6c176ce98fdb.camel@bull.com>
 <IA3PR11MB9136D461AAF0FCC8D757B33C92DE2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <97d42422c79aaa53a4a3faca5fc04ca75e22042c.camel@bull.com>
In-Reply-To: <97d42422c79aaa53a4a3faca5fc04ca75e22042c.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB8035:EE_
x-ms-office365-filtering-correlation-id: 75da661c-cbf4-4525-a99b-08def8755b2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: +ywiilkcc/8sU1lCIcvatkKOmUfNPr53/DI9czXI0BphAkol+/QxjaS9L+XzuevomRH72tOkyYHh3VX1O3bWgRsNfTmkVsfH8YBZ/BHkyVoiNk1hHFkkP6xSnr4R5x2yc5C6BHQUmmMuB0EhEpQyZPTRrRlrNYPO9WhTslvmJ9TAV65FWX8vivaH6YVpp9m6N3qYLInrq5hx1iOLLahaoyOBucajdxD0zvpOb0qmb+2JGVnVIsSY8ppatHQVda7/c07YWCen5IB6JA95DEZxfOMoMo7AGiRo4c/dAu1mqHWdaSQIc4c9jWP48WkUf9Dkn5zD2TSh80hboIOtcpqVVGDYzNnIB0uwbr5gxQQwaMX1mIKQiAwnJFFsjOI/9Q99p5gxQ+DShDOaFl1EJOvRLUgbT+GOA1SUW0lho6SH4Ita4eNfDnk9dxSNemmF9RL4k+ULSEjCYUvu3vGFp7FAQ8yScDHZ46wxEIHPdISup9u3XYTEQELKlyJsQRlEkuQpwQr4pWUMUy47KhnbjuomkysAfQ+mvMXnDzBihxHR0hC1VqoKv8HhtDJOkRYHE33bBT3bmbC1+PgKy2flXq8qpGIlQ39CWNSuGL/eG1Dwys1vIFvqgrQbejFzFp4JTJ29Ve/Np26wzydFKSL7ceFbJ1woWFBUWiWl7X3jsFs0g9wk0fpmCFBSYEyg+weiTYqjoGicQS8pi3MHuHIGbYNIAV8q3amBxfqpYMwxEDOIIcE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHlkYzEvZlhuU3pIUjZaakRscWx5SkZRWWY4cXZsVFdGZnZ0bHhJQk04dytI?=
 =?utf-8?B?QXgzUkdhYmJZZEVGcWl6Q1ZLY3p5VG1RRkg1V2JZT0Y1NFVJVGs5Z3NtRlJG?=
 =?utf-8?B?OHBwZDlUWnBkbGp5RVZpOXZZWkZranFPTjYwbzhJTFAwbkxxdkNic243OEpX?=
 =?utf-8?B?dDNoZjJUWlRvbDVOVGJaYldzSUp1Uzc3eExFenZpa3R4NktGZHl0SVlPUDZW?=
 =?utf-8?B?Mkt1alBDUmt3TXdxamtJTEE4Ri9uV05SciszQ3VxaDZZZXZZTSs4U1JKSWZs?=
 =?utf-8?B?cGR5dzZpRk1WYUwvMU41LzdOM1l2cnF2RHRxNlJ6dmUyd3R2WmpkWGZqdlVJ?=
 =?utf-8?B?bnF0Wms3aEMzaXdxM1FFQUtNWWNYSXJHdEx1dVdtbnNKQUZsSVpBWHVuR3FS?=
 =?utf-8?B?Z3AyNWt5V3kxSnNjeFE4ZDIxU0JJaGE5ZUlYWktuVG5oMmx6cFllQWVwckFY?=
 =?utf-8?B?c2tRUU4rckZ5RlNYL01qVUoyMTh5eWVKRU8wYTN1YkIxRHpHOThuWEpUa2JV?=
 =?utf-8?B?KzJvV0paNnlYNEVnZ0hBdUw5bHB4bUFUOVYxZGpJTUhVU2hJSUFmWEJsNW1r?=
 =?utf-8?B?V0Y0UkNybjJNN0tSMjlSNUd4M1NjUmd1alU1aDZFMjdZQmdKWExBOFBiWDJH?=
 =?utf-8?B?NmJ4dmF5UVVOZEhHaHh4cmZJbDlOZ1IvbW9La2NtMXpxWS84Yi9DSUFGZDJK?=
 =?utf-8?B?RHIyakE1VUhYNU9haHBTYXpvUFp4NVQwR0lEZzVhNURxaFZOMlptZFlPRGM1?=
 =?utf-8?B?K0pLeERaS1BvVEdZRlZFM1RROXBtazVEbGNybHF5ZFU4N0lXM3dhRS8xR3VX?=
 =?utf-8?B?UEtQazAvYTBkbXNldDJJN3R3Q04rdWJOVVM1WXJmRys3ckcvQS9LOVJibmt0?=
 =?utf-8?B?ZTlxTjh6aVRRaEdQV3hGRzFpUjJPUCtORVlpZWlCSWtaZEo3NFl2SlZSTVRT?=
 =?utf-8?B?SkI4a0w2dzh5L2pWdjczKytNTS9XTFhFczFMUDA0T2swbWdIaTJZS1lTYmV2?=
 =?utf-8?B?ZEo1TTlBUkkyaW13Z01ZbElld2pERVl5TDVTdmZqS1BsT0twRjZ2TnVERCs4?=
 =?utf-8?B?T3hiQjRaeU5IanNKSnUvekRzYitrR2RTUmVadXdURTFFSkdtM1c0R2dqeU4v?=
 =?utf-8?B?cEZvQ0FqOTlQWm95dVR0Q1RWbmJjWUFNV2UvUzZ4NU1qUWVMMW4xTVVYYUk5?=
 =?utf-8?B?bEFZcFIwWlhSYWtmZmxxNUpBR1JzOS9aQVRQMEYwbkk4djNrVTNjZlZHUGdU?=
 =?utf-8?B?WVR6Q3JZd2h2UWVPdGlpNUwwOC91WmVYYUY0U1ZCR2F1S2t6MHdNQnppL2Rp?=
 =?utf-8?B?VFJBL1B3Q2U0eFBNMmJCRy9LbFB6QnFXcXJhOWNVRWNDNVRnM21ydTBoKzh4?=
 =?utf-8?B?L3BlVExlTnpQQStiUXJBcVBZTHVpdWladUJuSUZ4ZUFaVDJmTDZaSzVMQjh5?=
 =?utf-8?B?aFBYRGp0ZkdqSWRJcTI0aDhTQW1vcktDSzJaVFpRcFIzbHcydU5ITjU3L29D?=
 =?utf-8?B?RFY2OFphb2JWRy9DUkRBWGNwMWJuYmpTNFFhWFVTK0xmMlUwMzRHUW81RFdI?=
 =?utf-8?B?cHR6NUQwNTNiMTlGczlFMFZLL1lLd0I1ejAwZDBYNC9GRmg0M1JMSHFIKy81?=
 =?utf-8?B?ZG1CbmkvL1R1YjdEUTRDWkxMZXBpd0p0WThhcHE0VDlGdGpZV3Y1QkxMNXo3?=
 =?utf-8?B?NDRMRUg2TDlzVkppaC9hRWNObENZcWJGMERvN2JpU2xtejd1bGhzbmtFNUVL?=
 =?utf-8?B?c09KenVoRkdXTTF3NWMzWXNNbGhCMkp6TXdHS01xcEdGeGVFZzZBcTZ4TDIx?=
 =?utf-8?B?Ty9nUUpZYzBZaHJvVTFvWmg1R2VYbnJiSjJzR1dvVFpBN3NCZCs0UGU1NG0v?=
 =?utf-8?B?UER4UUlsUFczbmhUWmFtL0hGSlptS3Zubi9NNWFPU1lQR1RjdThoSWl2ODYv?=
 =?utf-8?B?RFExcWRpNy9lZncrYXAvdjNVWFVzb2thNDNUOWp6YlFYQkUrUXl5WlRHZHc4?=
 =?utf-8?B?eVZ0c3FpMWwvZ3VwOG4rWnU0T3l1dXlVUEtxL05lbXlESWN0NVduaFVZVG53?=
 =?utf-8?B?WEdUeDBEZ0tFWkQ0TlVXa3F1TFovV2hGV0REcDNtUXNqcEQwMzJYeDNKbS81?=
 =?utf-8?B?ZjN6UUNpRGs1aTZRUWcrRm0wWUxBT3dwMkl3cVJpQkloWFZqWUlxT1dSNWNX?=
 =?utf-8?B?eW1tenlleGxJQVh0N1dRNzYwUDgxUzZSZ3ZoZDZpaDQyci9NcTFUbnp2cDU1?=
 =?utf-8?B?REFSWldKdFNncWJoOW1VelYwdzVKRjVxK3MxQ25ELzVocjc5c1h4U0k1NVdQ?=
 =?utf-8?B?aG12K2dRcWt3RHVCbTZBVU5TM3dxb1d6REdOa2NTU0w3dUtlbkRNdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YVgyXPjJkrwY3L59w2yVIl8XH5JNOoSCxzlwNouNUJMvIpYFEvOtxlsnxoS/mplwpJbYdtVV1qKQNCY9/Zk1WZ0NrzTDMKHW+FKZrp812m+0DG2Tyklq3RAK5frlCZy+yKpFIrR3BPqoOKiIu/EifgwP8DyGk39pvy/iiofe6wFsC1E06kLEk4rkFxWM5vDAKGSE/lo97uFw+uySyIlOdyMtSubkMYzuJK3hTqSjA0bO/Qcl32nXW8ZPRWDUrVQA0PuXp+QQc613lR7YUsxxga0CZ6dN81H+oMGHhIlRQJCj1dquLubqFEZf3FntNoH+zXMOkGO9ie0IVFT//aDTdg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75da661c-cbf4-4525-a99b-08def8755b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 13:26:45.7182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BY466b8I2ImlEopbU0VEyCiqc1KyGQmKluLT5VFm0H7EGM+mUd8L4LwZ4qkbjyCdmJ93nV2o2L8ueuXh62B6fcP1B4xakstb7cr7vdbyqew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8035
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsw6ltZW50IE1BVEhJRVUt
LURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYzIDAvNl0gaW50ZWxfaW9tbXU6IEVuYWJsZSBQUlEgc3VwcG9ydCBmb3IgcGFzc3Rocm91
Z2gNCj5kZXZpY2UNCj4NCj4NCj5PbiBNb24sIDIwMjYtMDgtMTAgYXQgMTA6NDkgKzAwMDAsIER1
YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qg
b3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwNCj5jb21l
cyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0K
Pj4NCj4+DQo+PiBIaSBDbGVtZW50LA0KPj4NCj4+DQo+PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+PiA+IEZyb206IENsw6ltZW50IE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhp
ZXUtLQ0KPmRyaWZAYnVsbC5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5j
b20pPg0KPj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gaW50ZWxfaW9tbXU6IEVuYWJs
ZSBQUlEgc3VwcG9ydCBmb3IgcGFzc3Rocm91Z2gNCj4+ID4gZGV2aWNlDQo+PiA+DQo+PiA+IEhp
IFpoZW56aG9uZywNCj4+ID4NCj4+ID4gSSB3aWxsIHJlYWQgdGhpcyBzZXJpZXMgZWFybHkgbmV4
dCB3ZWVrLg0KPj4gPiB0aGFua3MgZm9yIHRoZSByZXNwaW4hDQo+PiA+DQo+PiA+IGJ0dywgcmVs
YXRlZCB0byB0aGlzIHdvcms6IGhhdmUgZXZlciBzZWVuDQo+PiA+IHZmaW9fZGV2aWNlX2dldF9h
d19iaXRzIHJldHVybmluZyA0NyB3aGVyZWFzDQo+PiA+IHRoZSBpb21tdSBzdXBwb3J0cyA0OD8g
VGhpcyBsZWFkcyB0aGUgZm9sbG93aW5nDQo+PiA+IGF3IHRlc3QgdG8gZmFpbDoNCj4+ID4NCj4+
ID4gYGBgDQo+PiA+IHJldCA9IGhpb2RjLT5nZXRfY2FwKGhpb2QsIEhPU1RfSU9NTVVfREVWSUNF
X0NBUF9BV19CSVRTLCBlcnJwKTsNCj4+ID4gaWYgKHJldCA8IDApIHsNCj4+ID4gwqDCoCByZXR1
cm4gZmFsc2U7DQo+PiA+IH0NCj4+ID4gaWYgKHMtPmF3X2JpdHMgPiByZXQpIHsNCj4+ID4gwqDC
oCBlcnJvcl9zZXRnKGVycnAsICJhdy1iaXRzICVkID4gaG9zdCBhdy1iaXRzICVkIiwgcy0+YXdf
Yml0cywgcmV0KTsNCj4+ID4gwqDCoCByZXR1cm4gZmFsc2U7DQo+PiA+IH0NCj4+ID4gYGBgDQo+
PiA+DQo+PiA+IEkgZ290IHRoaXMgd2hlbiB0cnlpbmcgdG8gbmVzdCBWTXMuDQo+Pg0KPj4NCj4+
IEkgYW0gdHJ5aW5nIHRvIHJlcHJvZHVjZSwgd2hhdCBkZXZpY2UgZGlkIHlvdSBwYXNzdGhyb3Vn
aD8NCj4NCj5JIHVzZWQgZWR1IGZvciB0ZXN0aW5nLg0KPkFuIEkgaGFkIGF3LWJpdHM9NDggb24g
Ym90aCB2bXMuDQoNClJlcHJvZHVjZWQgdGhlIHNhbWUgd2l0aCBMMShmc3RzPW9uKSBhbmQgTDIo
ZnN0cz1vZmYpLg0KDQpJdCdzIGV4cGVjdGVkIGZhaWx1cmUgYXMgZmlyc3Qgc3RhZ2UgcGFnZSB0
YWJsZSBvbmx5IHN1cHBvcnRzIDQ3Yml0IElPVkEgcmFuZ2VzDQphbmQgTDIgd2hpY2ggdXNlcyBz
ZWNvbmQgc3RhZ2UgcGFnZSB0YWJsZSBzdXBwb3J0cyA0OGJpdCBJT1ZBIHJhbmdlcywNCnRoYXQn
cyBub3Qgc3VwcG9ydGVkLg0KDQpUaGlzIGlzIGRvY3VtZW50ZWQgaW4gdnRkIHNwZWMgMy42Og0K
DQpTb2Z0d2FyZSB1c2luZyBmaXJzdC1zdGFnZSB0cmFuc2xhdGlvbiBzdHJ1Y3R1cmVzIHRvIHRy
YW5zbGF0ZSBhbiBJTyBWaXJ0dWFsIEFkZHJlc3MgKElPVkEpIG11c3QgdXNlIA0KY2Fub25pY2Fs
IGFkZHJlc3Nlcy4gQWRkaXRpb25hbGx5LCBzb2Z0d2FyZSBtdXN0IGxpbWl0IGFkZHJlc3NlcyB0
byBsZXNzIHRoYW4gdGhlIG1pbmltdW0gb2YgTUdBVyANCmFuZCB0aGUgbG93ZXIgY2Fub25pY2Fs
IGFkZHJlc3Mgd2lkdGggaW1wbGllZCBieSBGU1BNIChpLmUuLCA0Ny1iaXQgd2hlbiBGU1BNIGlz
IDQtbGV2ZWwgYW5kIDU2LWJpdCANCndoZW4gRlNQTSBpcyA1LWxldmVsKS4NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg==

