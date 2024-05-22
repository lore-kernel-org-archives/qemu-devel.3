Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2137C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 08:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9guX-0008LG-VL; Wed, 22 May 2024 04:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9guQ-0008Id-Tr; Wed, 22 May 2024 04:01:19 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9guL-0007GZ-UK; Wed, 22 May 2024 04:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716364870; x=1747900870;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Uwa7JRdGGRIkm89eGb9XlAZ3e292YzwloFCepDIyhwE=;
 b=c8OswZDySyEJXNZBaKSWTLW2fjuawLqlVA86kike3NbzH2BSXyILEjVp
 6WGu6eXksgL39Z0jjHjosppavV2XoDvx4+3md4RtMeG7CZfUPWGeEpO2v
 899CbUmb0q89UhQHPQVgprU9TLIMd8OyAikQpBO2GWFqmE5FUe/3CJRNs
 iuEE6tiCNQZhiUoJmbd5YxAfuFjInb8Tu+VLCKAkbColIK6/g+hdCkZXW
 m8tDbITikkPh2KZUs25uJ2AejTvqjc7lGj6C0SPfs13VB79O31MTn0AgC
 gGkynEVEjLOMkPh4wdAVWBXslK8Rh6SWjRCHtOF1kWr9Fc/2x4Yo84MKX Q==;
X-CSE-ConnectionGUID: +MzE+dgPQmKxHHDAi6uQhA==
X-CSE-MsgGUID: DyJU1cySRq+VP8y4rpwEwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="24011593"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="24011593"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2024 01:01:07 -0700
X-CSE-ConnectionGUID: 7l5JIqxEQOmCChda4ezvCA==
X-CSE-MsgGUID: 3+7AQn/tRDGEIxXoGIFTYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33323848"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 May 2024 01:01:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 01:01:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 01:01:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 01:01:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAKl3TsIQJJti9lTt3AtUqTHo68ejSsUwvj0s93OtOVejxoXFTNNOxTteUt5sl2YpDjKHq7wfLP6bnrFMaIJ97iDpJDC0MKqCxOLjnoru4frck+5RCiZ1d/kNs64NoETIsHqS/yVkzcnT4i/dmmqPbauUA1aMqMspGTnr5QvnRAHdRvmpsvXHbqrXy7uJ0TO/hiXPAtWzgI7N0jHYhsC0CMN7jGXj94kAVrXTtlOHT5ynh1+POsXPsuTqcjl+KpaKVZCdlAsYm9GMlK/6a3f0qc733XqKCbqCTy5y2BghEWiPV3+lLA6XexgEzLYXr72b4NpXPdJPKdmINanZ65oHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwa7JRdGGRIkm89eGb9XlAZ3e292YzwloFCepDIyhwE=;
 b=iE7DjRuO+4W2NlqnzgsFrpWR2uBSufyvDlwjkkSAmQ3kKFo18o1IWk2UwDOzQttcJeDgg6OKm7O7pliVskMomSH5LolFp+vhIsZukfIQBut5hvyUf6RVVwBpFWK1VydmTWVGlf/0A+loYMQ3Rj5kVw36SDOR/NuDnZ81AAd51/8aAuJtcboCJV6FE8bNSrnmciWNbtC7BMk23Yi71HAzsfNFX6IAPl5prKDQa9XdaCllWbS/OS+5HGKyZxVABAYBRCnbDdgr59Fqg+d7wLVR8DkcJ3okCkQk6sgUG69MZMejkRX06DIe+UDUPA213HVzyMFYeBjKSmbK/Ou9K92mhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 08:01:04 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e%4]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 08:01:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, "open
 list:vfio-ccw" <qemu-s390x@nongnu.org>
Subject: RE: [PATCH v2 19/20] vfio/ccw: Drop local @err in vfio_ccw_realize()
Thread-Topic: [PATCH v2 19/20] vfio/ccw: Drop local @err in vfio_ccw_realize()
Thread-Index: AQHarAKXNlH5hiSDT0OR0pySef2Du7Gi4XKAgAACQSA=
Date: Wed, 22 May 2024 08:01:03 +0000
Message-ID: <SJ0PR11MB67446DA34F0E493A9A755B3892EB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
 <20240522044015.412951-20-zhenzhong.duan@intel.com>
 <adb8e0e9-a58d-45f5-979c-fe16d82ad988@redhat.com>
In-Reply-To: <adb8e0e9-a58d-45f5-979c-fe16d82ad988@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB6538:EE_
x-ms-office365-filtering-correlation-id: d82dc38b-7fee-47df-fb48-08dc7a3553e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZURpZk4zWmtYY3RmVDhtRm1DR0EyZEh5N0hJUkRodDc2NkI3YVk2SG05WnB1?=
 =?utf-8?B?UWp6emFEbHZxMGZId0JBa3laWUVSclpjM2p4b3pVVUI5UEpnMnRUaGRwSWF5?=
 =?utf-8?B?WE95U2t5ZExJSjRKdnRXV2NvMHVRaXdNb0dOVWl6Qk40Z3FIYWlHWWc3V0VN?=
 =?utf-8?B?aU0vUktZVDhZR3draXQreTVyV3kwNjc4ekFFQW9zY1NiTkcwZ0Mwc2FyZktr?=
 =?utf-8?B?NXZUWnArRkFZNVhLcFJ2US9WSlZIcThFaExXQ2JPamFESHFZbkRDbVNzemtN?=
 =?utf-8?B?T3FOcFo4bDNja1R6SHMvYzQ0aTRUSEQycTJTZnc3R0lWUkZXcTVnWkhITzVN?=
 =?utf-8?B?RzFSd1AwSGtsRzVjRVJBY0k0eXErL084MDFaYU5nNENRcmNIL1BkVGhSNHlZ?=
 =?utf-8?B?M2ZRbmd0UE9sNXpta0V6ZHcxdERQd2Y3bFB6SCs2aXpwQUFhNGV1RzMvbVJq?=
 =?utf-8?B?dDlxY014WjBXWDNUS3JTY0ZhQitDWW9rd1V5UWJmTTlMWSsvYmRuK0Z2RWFn?=
 =?utf-8?B?SFhZMXpBQ25ERHZEeUV2TlA5QWpjcG5IT0djT0FmTTJEWGVDT1JqL1FJdk1C?=
 =?utf-8?B?WlROMVhuMy8vSGZYVURxR0pxQlMzUVNPVHoyUlBWOEIxQ21XdFZ5K21sS2ty?=
 =?utf-8?B?TFRWRGxxU0ZXOVBBdEhibTl0TDVyQVNyL0EzWG1hcko0NkY0SVkxZFM3elcr?=
 =?utf-8?B?a3Irb1R6WUJqRjJoOFNLM3ljWkNkVDNEZk9FcWQ1bFM0NDlaMThrMWNROGl4?=
 =?utf-8?B?UGttOEM4dTZLZ0E5cVcrSTB1ZzY1c2FUMzFENnhYay9zVnk2ZUdLa3Q0akpp?=
 =?utf-8?B?NWlmNzRkRnZPUWJ0QzZROHROYWpRbnRIM0s1VW02V2doYjZwY1d3bEdNOWlR?=
 =?utf-8?B?M3YrckpUMWhaVVhtcUE0d0RmSUNJWXNCUC9nUGNWYW8xQmdyRHFsVmZwb1JW?=
 =?utf-8?B?dENUUWVEdFYrbXNHWFpuV1dFcXppQUQvbmFrbzFRMXFLVzF0U2ZZcWVKSTFr?=
 =?utf-8?B?Wi9iWGNjenhxeTVQanRJVlR3S3o1OGc1dFZKMFBnMktTOTJrWnBlOU9Gbmxn?=
 =?utf-8?B?VjFLdGtZZndxN0ErdGowTzY4Vm1kK2VQT29sYmlSczNDcktZUWZzZkNwVG1M?=
 =?utf-8?B?OGFxV0pSdTQzUXYzbkc2ekZnY3pkeDlXb21nZC81N0NGN2F3dnlVenNLSWNn?=
 =?utf-8?B?TDVXc1NSaVRSdUE0TEduaGpxbG9uRmJzRG53U1ZzTXc0SFdPUi81U3V5T0NM?=
 =?utf-8?B?ZUFrR29pMjdTeHVFNWxkT0N3cklYZ25yMWRMeW9SeDlQU2ZQUzBwT0FUNjdj?=
 =?utf-8?B?S1p0Uk1id203bTZ5VndEVVRYREl3blJrY2Z0aWl4VVExWkg5bTdQMnVZQ3oz?=
 =?utf-8?B?eDJ4anZzRFp4Unh1bk5hTVJWTTZ5cUtLNGh0UURrc29EU3hXaGtESW1YbjdG?=
 =?utf-8?B?M2hSWlpkNmhHMk8zN3QrdjM5Sm5DemJmZ21sMm1nM056eHRybnovVUxhRGRD?=
 =?utf-8?B?SmxLSEFGUEJSVHlkL1RzUVNmcC9MZk8ycU9CVHQ2UGEyRzhxU0hnTDRyT3po?=
 =?utf-8?B?VnVHSGwvcW5WU3FVQXZGTStXWkh6MjZyNUFEc1NhV2RqVGVwaDU0RkV4N2Nt?=
 =?utf-8?B?NXQ2OE95YnR2U3N3TU1tMTE5NHp5UmY5anJadTgwRjVRM3JYUlVaOFMxTVlp?=
 =?utf-8?B?alZwVXB2dEpXVjFXcXBLTWpSN1FGOFQ3UmdOTTEvb2JVSGRvaFJ1TnEyNGk5?=
 =?utf-8?B?ZzRHa01wdVZCOHYxa1cwZERVWElCUWlLQ01VOUFJbDJ5aFEzMlZteXZIMG5B?=
 =?utf-8?B?dUhGVzV5bC8wMWhwY3dWQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEhMK0YxWHJUcmVHOHRod09keEs4QndRY3MvM2k5UE1xNFJiMEprVFF0b0xV?=
 =?utf-8?B?R0Vza3V6VVpyeHBCSGhIazJQRGk2dkg2Qk5EMGp6emZ0M3AybnR1WUZYZVpB?=
 =?utf-8?B?UFdZc2dRdmdDTEcrT2RCbWM5cERpN0VmcEd1QmhlRGx0eHFsdzlNTXhxcHZK?=
 =?utf-8?B?dHo4a0FKdllXOFFNbkZVSUdyT29wajI0eUQ0aStIWGFIZ0JCaE91TUpYbzB0?=
 =?utf-8?B?KzZTOURMZjBnQllacEE4ZXhRUU9MZ055NG1TQmRrNVdmYmJyVzdtTU8wdlA5?=
 =?utf-8?B?elJlbTBRb1BDRWxORlJMZUxsVGFwLzhoMDFkY0w1RzR3Z3Y0RXM4cml0bU9H?=
 =?utf-8?B?ZkhOM1NuNmY1MHlaNWl1bEFxazYrVkxpcTc5TmN6dDc1Wjd5Ui9wb1kxYTdt?=
 =?utf-8?B?THdMUDRJV2FXOVNLSXFvQ3Ftc0JSRjBSTlZVb3dPUmhGc1d5c2o2OHZreVJE?=
 =?utf-8?B?M1VYdVBkdmlEM0NBMlZ6R1orcjZjanJNeFo1R1Z4czVzVU1rQ2tmNU95NWh4?=
 =?utf-8?B?U1RRa1lHSWQ0bEZHT0QzYmsxUVhRQnh3ZmVXb1hyWGNBSWREdzc0bFJxcENR?=
 =?utf-8?B?S0tQL2tFeUd4eTJYV2NYeW4zVTRPNGNXRXBCL3JVQTZoWTZZMnN1NWtKMEtn?=
 =?utf-8?B?Zm03bGdIdmhTM0JodnZqaE15c0VxNGpuNjNDcnR4b0p1TnZCOVk4dWFuNGI2?=
 =?utf-8?B?amhwWlpQbmRqa3JYeHVOcldqR0xjSjRoL2h1bUF5YkcrVEExTWZYdGpNYktS?=
 =?utf-8?B?WEh3TWp5a1JtNlF0S1orRFNjcWJZVHRUVDJpeFR0Vk5TdFBzSHZCbHlQaW5Q?=
 =?utf-8?B?YmJpSlhEOW1DNUFIZHdqWG1vNnd1MlgwQUhBUzBIQ0t6US9ZWnpmemJZVWNy?=
 =?utf-8?B?RVVxMXFqa1JlRHZkUjVUKzRLYjVTcnFzQWdiRnhMbVpHQmd6djNHdlFzL09x?=
 =?utf-8?B?V0dJMWZwOVFNWk44M3BiT0hjdytGL253U2gxcnVQd2lWdm1VNEtJaTFaRHIw?=
 =?utf-8?B?MnNFTE1SK2c2YlUvUnM2VjJmVC9EbXRHb0RpL2xGdS9aSE1aNGU2aGZtNks5?=
 =?utf-8?B?SDBvaTdUcWFqRExrRVlzb3J0QWtKWWRVejhCd2J5ZEFWaVcrRHB0YzNPY0Jn?=
 =?utf-8?B?bjM4NzBNYWI5RHZYZjVzS1pnNmk0M2hvbzRHMERjU281U0dkWUlmWlNaeHFH?=
 =?utf-8?B?VzVxZzZ5OVY0bGxDS1F1TmRlSGRWZzd2a3l2c0JEMXVHcFYwMkc0YVNoKzZq?=
 =?utf-8?B?YThTUi9xditYMkUxYjJtL0ZWcGxlN3lSeXdta1R2Wkx2aGJDdWNhQklOVTk2?=
 =?utf-8?B?c0VxR0piSXpRYkF5T1hsb2NkMGd3ZnVuS21oU212YVMwbENzWmtHRHk2cVB4?=
 =?utf-8?B?QTVpSUJINUFoMVFlSzF3Q1lpRExuaDV6Y2ROZndGOFczMnA5elFUWXE4cko0?=
 =?utf-8?B?Tmo0VDdUSHVHTHpJc0txWWNmSzJUdFRYLzNnallSRVE5NmNkSDhmL2p2M1Y0?=
 =?utf-8?B?cGNPd0RnSDZHMU04eE1nUm9nVm1rVm1IOVdjSm90ZDMyeTN2MnZZcEhMclpZ?=
 =?utf-8?B?V2NhcjVLcFdSazZjcUVEenRuME43TWFOV3BQZzk1azJsM0xXbnVKcXIxK2xN?=
 =?utf-8?B?c2RhRVlFTm5DU0plUUdHUmFZZ3dLNm5ZblBKSWUrcXlFZW9jK2JpaVVmb3Y0?=
 =?utf-8?B?a21oTUFWSERRYmF3Qy9nT2ZLcHArOFNrUkEwRGlZOVpUK1c2bUhqTTFoMFo3?=
 =?utf-8?B?akZORUNwSEpIbXNoakswMWRlWExnUnJZbHBXSGg5SVIvbEMzSEluWU5tMElG?=
 =?utf-8?B?Qi95aE9qZCtwVE1PMUFJbmZ1MGdHc0t6SmZWSWZLSUtXVmVXeXNJVVRadDNu?=
 =?utf-8?B?S1VrbnlRYytFdWNWbkFIVTczd0NVK0tGOHZJYm9DL2hENkJzNkhWeTFtZmc1?=
 =?utf-8?B?b0p3OEJTUVVHTkg1TFhxaHg1N3dCS2RzTzZqSUhUNG9PeU8yc3ZxSkdCbFlm?=
 =?utf-8?B?VWJISUhmNG5heHlRbHV6S0VtNjBtREZhVmVKWFR0VzMrL3FEbUEzRDlWNTF3?=
 =?utf-8?B?aVJuczJ6bEQyRmE5Y1UxRy9HeWc2eWdYSEI0M2txb28weGFlUkdZc05Fb0NF?=
 =?utf-8?Q?clHKclV8Ut/yBHoHEfaUmoEax?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82dc38b-7fee-47df-fb48-08dc7a3553e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 08:01:03.8978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aaYqqvnfNKUEBI6a3970QO6uVvx3XzuH6mFJd38+cZks7VW/H9cGoVZF/bzVavs5WoTqPVwTD8mADPt0gy4SzvHtBez/KGev0viAM1Xd5uU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDE5LzIwXSB2ZmlvL2Nj
dzogRHJvcCBsb2NhbCBAZXJyIGluIHZmaW9fY2N3X3JlYWxpemUoKQ0KPg0KPk9uIDUvMjIvMjQg
MDY6NDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gVXNlIEBlcnJwIHRvIGZldGNoIGVycm9y
IGluZm9ybWF0aW9uIGRpcmVjdGx5IGFuZCBkcm9wIHRoZSBsb2NhbA0KPj4gdmFyaWFibGUgQGVy
ci4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNv
bT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvdmZpby9jY3cuYyB8IDIxICsrKysrKysrKystLS0tLS0t
LS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY2N3LmMgYi9ody92ZmlvL2Njdy5jDQo+
PiBpbmRleCAyNjAwZTYyZTM3Li4xNjhjOWU1OTczIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9j
Y3cuYw0KPj4gKysrIGIvaHcvdmZpby9jY3cuYw0KPj4gQEAgLTU3NCwxNyArNTc0LDE3IEBAIHN0
YXRpYyB2b2lkDQo+dmZpb19jY3dfcHV0X3JlZ2lvbihWRklPQ0NXRGV2aWNlICp2Y2RldikNCj4+
DQo+PiAgIHN0YXRpYyB2b2lkIHZmaW9fY2N3X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJy
b3IgKiplcnJwKQ0KPj4gICB7DQo+PiArICAgIEVSUlBfR1VBUkQoKTsNCj4+ICAgICAgIFMzOTBD
Q1dEZXZpY2UgKmNkZXYgPSBTMzkwX0NDV19ERVZJQ0UoZGV2KTsNCj4+ICAgICAgIFZGSU9DQ1dE
ZXZpY2UgKnZjZGV2ID0gVkZJT19DQ1coY2Rldik7DQo+PiAgICAgICBTMzkwQ0NXRGV2aWNlQ2xh
c3MgKmNkYyA9IFMzOTBfQ0NXX0RFVklDRV9HRVRfQ0xBU1MoY2Rldik7DQo+PiAgICAgICBWRklP
RGV2aWNlICp2YmFzZWRldiA9ICZ2Y2Rldi0+dmRldjsNCj4+IC0gICAgRXJyb3IgKmVyciA9IE5V
TEw7DQo+Pg0KPj4gICAgICAgLyogQ2FsbCB0aGUgY2xhc3MgaW5pdCBmdW5jdGlvbiBmb3Igc3Vi
Y2hhbm5lbC4gKi8NCj4+ICAgICAgIGlmIChjZGMtPnJlYWxpemUpIHsNCj4+IC0gICAgICAgIGNk
Yy0+cmVhbGl6ZShjZGV2LCB2Y2Rldi0+dmRldi5zeXNmc2RldiwgJmVycik7DQo+PiAtICAgICAg
ICBpZiAoZXJyKSB7DQo+PiAtICAgICAgICAgICAgZ290byBvdXRfZXJyX3Byb3BhZ2F0ZTsNCj4+
ICsgICAgICAgIGNkYy0+cmVhbGl6ZShjZGV2LCB2Y2Rldi0+dmRldi5zeXNmc2RldiwgZXJycCk7
DQo+PiArICAgICAgICBpZiAoKmVycnApIHsNCj4+ICsgICAgICAgICAgICByZXR1cm47DQo+DQo+
V2Ugc2hvdWxkIGNoYW5nZSB0aGUgcmVhbGl6ZSgpIHJldHVybiB2YWx1ZSB0byBib29sIGFsc28u
IHRoaXMgaXMgbW9yZQ0KPndvcmsgYW5kIGl0IHNob3VsZCBiZSBhZGRyZXNzZWQgaW4gaXRzIG93
biBwYXRjaHNldCBJIHRoaW5rIGFuZCAuLi4NCj4NCj4+ICAgICAgICAgICB9DQo+PiAgICAgICB9
DQo+Pg0KPj4gQEAgLTU5NywyNyArNTk3LDI4IEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X3JlYWxp
emUoRGV2aWNlU3RhdGUgKmRldiwNCj5FcnJvciAqKmVycnApDQo+PiAgICAgICAgICAgZ290byBv
dXRfYXR0YWNoX2Rldl9lcnI7DQo+PiAgICAgICB9DQo+Pg0KPj4gLSAgICBpZiAoIXZmaW9fY2N3
X2dldF9yZWdpb24odmNkZXYsICZlcnIpKSB7DQo+PiArICAgIGlmICghdmZpb19jY3dfZ2V0X3Jl
Z2lvbih2Y2RldiwgZXJycCkpIHsNCj4+ICAgICAgICAgICBnb3RvIG91dF9yZWdpb25fZXJyOw0K
Pj4gICAgICAgfQ0KPj4NCj4+IC0gICAgaWYgKCF2ZmlvX2Njd19yZWdpc3Rlcl9pcnFfbm90aWZp
ZXIodmNkZXYsIFZGSU9fQ0NXX0lPX0lSUV9JTkRFWCwNCj4mZXJyKSkgew0KPj4gKyAgICBpZiAo
IXZmaW9fY2N3X3JlZ2lzdGVyX2lycV9ub3RpZmllcih2Y2RldiwgVkZJT19DQ1dfSU9fSVJRX0lO
REVYLA0KPmVycnApKSB7DQo+PiAgICAgICAgICAgZ290byBvdXRfaW9fbm90aWZpZXJfZXJyOw0K
Pj4gICAgICAgfQ0KPj4NCj4+ICAgICAgIGlmICh2Y2Rldi0+Y3J3X3JlZ2lvbikgew0KPj4gICAg
ICAgICAgIGlmICghdmZpb19jY3dfcmVnaXN0ZXJfaXJxX25vdGlmaWVyKHZjZGV2LA0KPlZGSU9f
Q0NXX0NSV19JUlFfSU5ERVgsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmZXJyKSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZXJycCkpIHsNCj4+ICAgICAgICAgICAgICAgZ290byBvdXRfaXJxX25vdGlm
aWVyX2VycjsNCj4+ICAgICAgICAgICB9DQo+PiAgICAgICB9DQo+Pg0KPj4gLSAgICBpZiAoIXZm
aW9fY2N3X3JlZ2lzdGVyX2lycV9ub3RpZmllcih2Y2RldiwgVkZJT19DQ1dfUkVRX0lSUV9JTkRF
WCwNCj4mZXJyKSkgew0KPj4gKyAgICBpZiAoIXZmaW9fY2N3X3JlZ2lzdGVyX2lycV9ub3RpZmll
cih2Y2RldiwgVkZJT19DQ1dfUkVRX0lSUV9JTkRFWCwNCj5lcnJwKSkgew0KPj4gICAgICAgICAg
IC8qDQo+PiAgICAgICAgICAgICogUmVwb3J0IHRoaXMgZXJyb3IsIGJ1dCBkbyBub3QgbWFrZSBp
dCBhIGZhaWxpbmcgY29uZGl0aW9uLg0KPj4gICAgICAgICAgICAqIExhY2sgb2YgdGhpcyBJUlEg
aW4gdGhlIGhvc3QgZG9lcyBub3QgcHJldmVudCBub3JtYWwgb3BlcmF0aW9uLg0KPj4gICAgICAg
ICAgICAqLw0KPj4gLSAgICAgICAgZXJyb3JfcmVwb3J0X2VycihlcnIpOw0KPj4gKyAgICAgICAg
ZXJyb3JfcmVwb3J0X2VycigqZXJycCk7DQo+DQo+VGhpcyBzaG91bGQgdXNlIGEgbG9jYWwgRXJy
b3IgdmFyaWFibGUgYW5kIGJlIGEgd2Fybl9yZXBvcnRfZXJyIGluc3RlYWQuDQoNClllcy4NCg0K
Pg0KPkxldCdzIGFkZHJlc3MgdGhlc2UgY2hhbmdlcyBpbiBhbm90aGVyIHNlcmllcy4gSSBjYW4g
dGFrZSBjYXJlIG9mIGl0DQo+bGF0ZXIgaWYgbm8gb25lIGRvZXMuDQoNCk9LLCBsZWF2ZSBpdCB0
byB5b3Xwn5iKDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

