Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436F5C25B5F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4E1U-0005SJ-EB; Tue, 07 May 2024 02:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4E1S-0005Rw-3L; Tue, 07 May 2024 02:09:54 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4E1P-0005t8-2f; Tue, 07 May 2024 02:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715062191; x=1746598191;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bIl6PpvfZLSYbY6k68Tl/9c62FuH+of7AnjrVYGCohU=;
 b=nMUyB2J1QSaBnNrfbKyTC65MNqtBcfCdXQkXfAtOfDY7s0qC213MrARn
 sSNELezRXrmKIGPPtv29q8Uoxsf7o2yMT3dgcSoDxX5QU29RuDvPRMYsA
 qhRJAJ2laFXWd2M8Wxcznf15Aww9jm12DxMlHqszJ4XHCgUREQ+aSuE+e
 G3jI7ZCj732qnCcH6FJ/OCywTcHui2ZoqEUVVs1q5c10qlcrCc4593yii
 8FemYtbnIvdGdPVahMaovoboMSEdq0LfiBhdbcEeqIzUZN7P6itl43ah6
 wlL6SHG8Itwnz3K/AKlTRPoxxjC+O1jBn3m7yWsFGt/fmeuiKITVGueAy w==;
X-CSE-ConnectionGUID: pOEwItprSYqPu4JrW3t2Nw==
X-CSE-MsgGUID: L2/GQmCFQCO/b/xSOob3Tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10686159"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10686159"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:09:47 -0700
X-CSE-ConnectionGUID: B+uE8ChQSOCLyJKwOSn6rQ==
X-CSE-MsgGUID: Qfwcr44FS2uATtBEJBducw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="33077794"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 May 2024 23:09:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 23:09:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 23:09:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 23:09:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 23:09:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSUZRl6mroEo4Amnshll9qR6GfVuP8Dtg/+2AFPdUvic1Jr1F1h1Ia64UZj/0aFQFhPrLw7xbz91M0AN/xlAwIPpQ35sbGURFOT8FLmbxJJd0PYnwOibobxUKN0kvPNl+OWa5YQTHMF1w7nspMsJPWkXvbQebC6lRZw3K/dUsF/XkJn/ju+PAAliuJerlakK526f9d2gn0bBnSnD/bT04c118sAqg5dbfAh+pPaDqI8Icgpdii4I0C5nCFsQcluECnk5A41b7QLuZ3ivz22RGhmPcL0tY8NZ7abBDtFpXqcH2Jr2uKZ4RqDzoTNjZX6nilTelwiU/14z6CTRJCTCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIl6PpvfZLSYbY6k68Tl/9c62FuH+of7AnjrVYGCohU=;
 b=apteje/Mh+WO3L8Cb9bx11IGzQuEWDWAHumTrzacr9AOZLkpSeYFnsI/shEgjBXGgX/4/AXuNL3C/5IijJSeA/J0IMmzMTWgSobMVCO2dWctL1vIpt3To/W2URYYyEO84dBHpJ9oyT+IgVhSfYOGDmCrIJgBIdxRXsVg09qwrZOXG0/gKx3P4ye7XJn+O1AAxMkmj5snyFj6o5MABy4JQn6O+iPQTa2nO3hpDujqnT6ZY/sEaZ1WLH+B50oz3bBCtut6jgwcIbjPukc78HBtr28zCpPpK8FHN8IJfG5nD1vfsOM+B9DHFDNgyVRdrftijsE5EdSfXYLp5klCRPJAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6358.namprd11.prod.outlook.com (2603:10b6:8:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 06:09:43 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 06:09:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "open list:vfio-ap" <qemu-s390x@nongnu.org>
Subject: RE: [PATCH 1/3] vfio: Make VFIOIOMMUClass::attach_device() and its
 wrapper return bool
Thread-Topic: [PATCH 1/3] vfio: Make VFIOIOMMUClass::attach_device() and its
 wrapper return bool
Thread-Index: AQHan5B85WaojUNI70K7eHtIfhvHK7GKGqUAgADsRjCAAEDhAIAAAUKA
Date: Tue, 7 May 2024 06:09:43 +0000
Message-ID: <SJ0PR11MB67441DA8F04C4968400AF3CE92E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240506083352.4037226-1-zhenzhong.duan@intel.com>
 <20240506083352.4037226-2-zhenzhong.duan@intel.com>
 <056f1ba7-a51b-4859-a80d-616c30e63e06@redhat.com>
 <SJ0PR11MB67443A9F217791EF4E6EA43792E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <faba937d-885b-4b2c-a98f-47146b053031@redhat.com>
In-Reply-To: <faba937d-885b-4b2c-a98f-47146b053031@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6358:EE_
x-ms-office365-filtering-correlation-id: 9d14e1e3-6bb4-4b53-acf8-08dc6e5c49a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?WXhHZ1poVVlWaVoxMWh5MkY5VnRNMDh4SGVFL3NGNVFsSFo5bytqMGZleWNq?=
 =?utf-8?B?ZUVuQVRkMk00YmxxemM1MzE5aXFZeVR5Ti9OeDNxVFNjaTl6WnUxbEFpeTlr?=
 =?utf-8?B?YVdnTHh2dyt0elZtTVZrL2R5L295aHhiZzdQSXFRZTlkTng4VE5PUVoxRVor?=
 =?utf-8?B?cnNoZVBIYVBHN1pBeWpOb1VJVVptNUl6TVNKeGNVRTBnamgvbytpeWNtVG9Q?=
 =?utf-8?B?em9EdnQ3VFZUWVBuTTE0WUNoYTZSZVFjN0dKMitBb0srZjh6MmcvKy84RVV2?=
 =?utf-8?B?My9jUzNSUWRIQkE2VUpSc2JVZi8wSkVQUHIrRVlPZlBKNkpHMGxqV2tNN3Br?=
 =?utf-8?B?Qm9LdnR3UUdUc0ljZU5qeUxXWUFCMW5hV1RHTmZRU085NTljaXd3NHB3ZERZ?=
 =?utf-8?B?dDBFdWxFVWsrMXhBSFlCa0VqWHZQUXZXMkpUWlJJOENxT1FPZTc4TGwxWVd4?=
 =?utf-8?B?TURnOHhoVXo3Z3RUYk5uZlRnTGE3QkpFd1VsVHF1ckJISmR2S1JYc21yQzBt?=
 =?utf-8?B?Z3ppTXU0NlVIbmg2VHBiVUVVVi9yTThhd0o0Wm13WU12M3VZc00zN0gybGMw?=
 =?utf-8?B?ZldCSEFUbks2OGNsSlVUM2JVMCtuNjVKYWh6aThtV2lpRlhITFJvb1lvMVFW?=
 =?utf-8?B?aWNWZXJ5UHFpMXZCclRKdUk2d0FLRGs1ZWlYM2pMM2V6OUJreVNyZDJ1M2w1?=
 =?utf-8?B?Zm9FV21zQ2QrQ0VySlZkdDhrN25UYWFQWnZDQ2J0SlM2L2pqVTBJbWFoZm5W?=
 =?utf-8?B?NWZlOFhJQnVDeTJiYjdEUnA1NWQ5Y2RLc01ONWlvVWNiVlQzUmFGWkdNaVl5?=
 =?utf-8?B?SDMyaWRwTENzaHJ2d3phNGlrSkJtSUIrU3VsOS9XNHVSZFBINHdERXVNWXVp?=
 =?utf-8?B?MSs4T1c0ZGtqZFlYMUhvNFFqcHFiT0tBbElwcmE1aXR2dEFMQlczdHZobmtT?=
 =?utf-8?B?ODBpMGE5aTRpcjNKWTVONzJpSjY1cUJHNW5jY29Reit5dEtxVTZhTWF5MC9D?=
 =?utf-8?B?a1A1WE9MUENjVGljMzRCZDBmWEFET2lVUUdSaVBBUkhIVTNCaG9kZUNsVmpW?=
 =?utf-8?B?dWZhOUFDRlozN1F4ODdVQU9lMVp1aWxnKytIZmM3QkhOQm0zMmdycVdKNWc1?=
 =?utf-8?B?bGRqTkJ2ajdlY0pSRW5hRUttMlVnYURaYkwzaU9HanlSRXpQTW1DbSt0NlE5?=
 =?utf-8?B?NGlSNXRZQU9oNGdHTUw3Qi80KytyL1ZLZ0g2ZkdkbkNtdkVOY01iQ0ljYnYw?=
 =?utf-8?B?bXRkMHBCTHVKMGRYSW5yNFVJQktYUThEcVdLM0RDQUxMdDBJRDhjMlY0c3FW?=
 =?utf-8?B?YUloQ3BXMmRsV0hhQ3lvTkdzaDNrZXZJRm8xclZsdmxPV1RxOE5KQm1CMk5C?=
 =?utf-8?B?OW5jU3lzVUc2S2c3Q1pDV1lENjJSOXB6aUFHVHBwc2hyVDJvSmgzU3RRcFlp?=
 =?utf-8?B?NFkrWjkyRWhETmczeGZxMWFYeUpQOWlvbms0ZVY4ZEo0SFVkSnJ4dkJ4ZHZL?=
 =?utf-8?B?SVNQK0VKWGdEMVNPazIwSFpEbGE3enc3cDNzSVdNS0t6VFFqSkE4eUp5TWRJ?=
 =?utf-8?B?S3NTQ0xWMkp0V0UxZDBPS3lOYkxPd1RhWE5jdTE5YmNjMDlFVkNlK090OWtZ?=
 =?utf-8?B?TWhwOXNtNWk5U2tGUzJ0SEt4UUFIRzdkVE1COEQwRTZkemdWcTI1UTFXV0pF?=
 =?utf-8?B?YmpPa2FUdnBZYnhpMmxJUThvNXFUMlBZaWlzUTl5R3NZa2FZVFhpWGxJRkI5?=
 =?utf-8?B?RTRLUEJ3dlRmSEw2cndNaDNRSnV5UTFOT0tPOTkvVVNHcE41NnF4TUJnZmJv?=
 =?utf-8?B?Vy9tMUVYMEIwb3RFd05FZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTRHMWpPRDN6VFFHeDloNnZzT2FnRm91MjRJYy9uR1F3WjlRVG1CanBuVFFv?=
 =?utf-8?B?UjF2Yy9ZeTZyMUdUeVdTMlFuOGpGL0dwenVONlA3enZLeUcxWWs0Vk9qQ0pF?=
 =?utf-8?B?cGc3b2RpMmNyeGlSbnNHU1FNU1o4dU4vKytockc1ZEZvenRqaVNGR3d5Rkcw?=
 =?utf-8?B?U2RRK0VDNlMxenRSUzM3bG85K3JCM1JxQUM2dDVlRmpIRzR0eWdqaXRxYjlM?=
 =?utf-8?B?RUVHOFh4N0E5ckNGOCtSdlFxeS9PcXZLNzNEd0ZHd0gyQkw0ZEx5aHpxaStj?=
 =?utf-8?B?M1N2ZmpyblNFVlFFQ0cvSHNPMGRFakRRa1hNWEhvVjZycU9uU3FSd1RsaW1T?=
 =?utf-8?B?Vnk5b3ljbWRZdWhKUWpxdWhiV0d1STI0ak1NR0lZQ2FWWEZUcXUxeE82ZzZi?=
 =?utf-8?B?bXZTSDFpSDdkYTdxZWtVUjVRYnkxOGxEUXh0b211L3BtZmY5Z2J5T2IxSEVK?=
 =?utf-8?B?em9HZVd2bFlkY0dOc3VjWHJmN0VydzlSSTN5TFhQOEFuVDVaM3FSd29kbnRZ?=
 =?utf-8?B?ZWtWR2YydnRnakZIUWRsbHRQU2VpU0FXNWpORUFmRUorTU1ObzBXalAyV080?=
 =?utf-8?B?Y3JVUnNrRkoyNktrUm9UcnFxNjlJZ01TOG1TU2kvRlJOZU83MDRBVlY2R0FD?=
 =?utf-8?B?Vyt4QnZPY1FYVm5zTVhhTDJPU053NEZERVVXQit2TzNNZjlyQ250eC9YRnRM?=
 =?utf-8?B?WU5RUHY3RnRjNE05aXEwZSszczlTN3FkUGc0Z0pwNWVZcGdEZzhPaHN2SU1O?=
 =?utf-8?B?b1o2cUtSVndSY1FPNldiejIrVU1YZFdPQi9nSUg3eGtST3dUUUE0N1VyY2NE?=
 =?utf-8?B?cjRLZU4zdVlOMnFsUGo5em03VnVOOWhBQzFrYmZ0dGl5RkdNK0dGbFduUE9r?=
 =?utf-8?B?UUU4SzZ1aXZBUTNFUkdTbWFxN29mbjAvNEp1OWU0YmlLMncxbEg3NjNOcG5o?=
 =?utf-8?B?bEt1bm15T3IwTEVFaGMxTFFTRHZHa2h0OEMxSW1uK1hiaStranhxYlhTNjhE?=
 =?utf-8?B?cktHWTNaWnZoSVF0VXFZZkUxSTFodjJIZUlpcmV1SllHd0VVbFllZlVTR0tr?=
 =?utf-8?B?VW9xZ1lCWmFJazdkb0NHUjVaOVI3aWx2LzZlRWt0RTB1c1Q5M09kQTFDQTYy?=
 =?utf-8?B?UjlsZWdoQzh6Y2JCODN2WFNqTHdtSTJQOFVpQnppZS9US2pHNkdKMGhCdTlw?=
 =?utf-8?B?UmxQclRGQTU0TmdPanVmZUhwWDJUckhNYmdhQndtMTIwdjBkY25aSDV4TnlU?=
 =?utf-8?B?M2hVN1JPZXJDSFgxc3VLTXpLY2FFWEN0SGN6eGZQRDIxVEI4bVhrZ05OYWps?=
 =?utf-8?B?UnVjSGFiWGQydmx3UWhOZGg3ZzBXb2tkUksyOTNXSVZLbDhUZit3TUhBdFZT?=
 =?utf-8?B?b1lrbGRSbEVIbkx4OG5waGtNSitRVHF5MDhYa3ZTY2hWclBMaFNhMGVDdE9p?=
 =?utf-8?B?S3hKb1k0cTRXay9iT2VldEJIaGVRazRodC9YU2ZFUjRZWDdFWmY0WTQ0OGdi?=
 =?utf-8?B?a3EvZXBEWGNmWWU0RitiVVFWbkszNzZjK3FRdDRWSUdvOXRLaG81N2RqTjdQ?=
 =?utf-8?B?bWNtQkxLOGpVaGp0THZKQlg2emlJNG1DRXl2RzZaOThCa0JuMzUwOWRZWmNj?=
 =?utf-8?B?TUtNbzZEZXVWbkJyZytmNWNXT2RCSE51WHBYSGFPL3hFNnBOcUhIdjNveG1y?=
 =?utf-8?B?Ync3bzBTNXBFNG92RXcwTjFyMlZrSDdpaTN0K2JQK3ZETUhLTiswTzZtMzhp?=
 =?utf-8?B?OXZ2TUxjdjVWQnArUE53dzcvajcwTzlVZlFqazg5V3g0bktKWXQ5M1dHR01D?=
 =?utf-8?B?MHo3ZDVROWxDQTFwSEtac2hPSDFzRFVCNC9kREI3OCs0YUE5K0I2M0NUNmJ5?=
 =?utf-8?B?eC84RTZwelRVL1d5bitmUjZJNkNsUjErWVg4Mit6OEVSUzFVVnZvNXl2Si9D?=
 =?utf-8?B?ZzI4Mm8rWUluK055Y01KZUJZUXpFL1dkRFMvVmNJOVJZSnI0ak1BRHM0RTAz?=
 =?utf-8?B?N09YOWdDRkt0dE1Vc2RvbGM0TS9DTFB6T25KOG5McUlRVUwrU2pVU08vYSsx?=
 =?utf-8?B?SHM5cXBicVdNYkorMjY4ajBPc2czRDB4NGN4enZjRFdKOWRJeE02dy9EZ0NT?=
 =?utf-8?Q?DhJPwd8IBOieIpCuxnfnKq1g/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d14e1e3-6bb4-4b53-acf8-08dc6e5c49a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 06:09:43.0793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdIfWwl1wT7N80dKZoqtJniN2c0f9tyj4hvC84W6SS2busMuqF+A1iP+iAS8NClfyFEL6Ka/T6AgnryK8s5vHS9maOq/vEl5q4zEDz9gnz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6358
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDEvM10gdmZpbzogTWFrZSBW
RklPSU9NTVVDbGFzczo6YXR0YWNoX2RldmljZSgpIGFuZA0KPml0cyB3cmFwcGVyIHJldHVybiBi
b29sDQo+DQo+T24gNS83LzI0IDA0OjA5LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4N
Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEPDqWRyaWMgTGUgR29h
dGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gdmZpbzog
TWFrZSBWRklPSU9NTVVDbGFzczo6YXR0YWNoX2RldmljZSgpDQo+YW5kDQo+Pj4gaXRzIHdyYXBw
ZXIgcmV0dXJuIGJvb2wNCj4+Pg0KPj4+IE9uIDUvNi8yNCAxMDozMywgWmhlbnpob25nIER1YW4g
d3JvdGU6DQo+Pj4+IE1ha2UgVkZJT0lPTU1VQ2xhc3M6OmF0dGFjaF9kZXZpY2UoKSBhbmQgaXRz
IHdyYXBwZXIgZnVuY3Rpb24NCj4+Pj4gdmZpb19hdHRhY2hfZGV2aWNlKCkgcmV0dXJuIGJvb2wu
DQo+Pj4+DQo+Pj4+IFRoaXMgaXMgdG8gZm9sbG93IHRoZSBjb2Rpbmcgc3RhbmRhbmQgdG8gcmV0
dXJuIGJvb2wgaWYgJ0Vycm9yICoqJw0KPj4+PiBpcyB1c2VkIHRvIHBhc3MgZXJyb3IuDQo+Pj4+
DQo+Pj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggICAg
ICAgICB8ICA0ICsrLS0NCj4+Pj4gICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJh
c2UuaCB8ICA0ICsrLS0NCj4+Pj4gICAgaHcvdmZpby9hcC5jICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICA2ICsrLS0tLQ0KPj4+PiAgICBody92ZmlvL2Njdy5jICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDYgKystLS0tDQo+Pj4+ICAgIGh3L3ZmaW8vY29tbW9uLmMgICAgICAgICAgICAg
ICAgICAgICAgfCAgNCArKy0tDQo+Pj4+ICAgIGh3L3ZmaW8vY29udGFpbmVyLmMgICAgICAgICAg
ICAgICAgICAgfCAxNCArKysrKysrLS0tLS0tLQ0KPj4+PiAgICBody92ZmlvL2lvbW11ZmQuYyAg
ICAgICAgICAgICAgICAgICAgIHwgMTEgKysrKystLS0tLS0NCj4+Pj4gICAgaHcvdmZpby9wY2ku
YyAgICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKy0tLS0tDQo+Pj4+ICAgIGh3L3ZmaW8v
cGxhdGZvcm0uYyAgICAgICAgICAgICAgICAgICAgfCAgNyArKystLS0tDQo+Pj4+ICAgIDkgZmls
ZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCBiL2luY2x1ZGUvaHcv
dmZpby92ZmlvLQ0KPj4+IGNvbW1vbi5oDQo+Pj4+IGluZGV4IGI5ZGE2YzA4ZWYuLmE3YjZmYzhm
NDYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+Pj4+
ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+Pj4+IEBAIC0xOTgsOCArMTk4
LDggQEAgdm9pZCB2ZmlvX3JlZ2lvbl9leGl0KFZGSU9SZWdpb24gKnJlZ2lvbik7DQo+Pj4+ICAg
IHZvaWQgdmZpb19yZWdpb25fZmluYWxpemUoVkZJT1JlZ2lvbiAqcmVnaW9uKTsNCj4+Pj4gICAg
dm9pZCB2ZmlvX3Jlc2V0X2hhbmRsZXIodm9pZCAqb3BhcXVlKTsNCj4+Pj4gICAgc3RydWN0IHZm
aW9fZGV2aWNlX2luZm8gKnZmaW9fZ2V0X2RldmljZV9pbmZvKGludCBmZCk7DQo+Pj4+IC1pbnQg
dmZpb19hdHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4+
PiAtICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNzU3BhY2UgKmFzLCBFcnJvciAqKmVycnAp
Ow0KPj4+PiArYm9vbCB2ZmlvX2F0dGFjaF9kZXZpY2UoY2hhciAqbmFtZSwgVkZJT0RldmljZSAq
dmJhc2VkZXYsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNzU3BhY2UgKmFz
LCBFcnJvciAqKmVycnApOw0KPj4+PiAgICB2b2lkIHZmaW9fZGV0YWNoX2RldmljZShWRklPRGV2
aWNlICp2YmFzZWRldik7DQo+Pj4+DQo+Pj4+ICAgIGludCB2ZmlvX2t2bV9kZXZpY2VfYWRkX2Zk
KGludCBmZCwgRXJyb3IgKiplcnJwKTsNCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZp
by92ZmlvLWNvbnRhaW5lci1iYXNlLmgNCj5iL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPj4+IGNv
bnRhaW5lci1iYXNlLmgNCj4+Pj4gaW5kZXggMzU4MmQ1Zjk3YS4uYzgzOWNmZDljYiAxMDA2NDQN
Cj4+Pj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPj4+PiAr
KysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+Pj4+IEBAIC0xMTgs
OCArMTE4LDggQEAgc3RydWN0IFZGSU9JT01NVUNsYXNzIHsNCj4+Pj4gICAgICAgIGludCAoKmRt
YV91bm1hcCkoY29uc3QgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIsDQo+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGh3YWRkciBpb3ZhLCByYW1fYWRkcl90IHNpemUsDQo+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgIElPTU1VVExCRW50cnkgKmlvdGxiKTsNCj4+Pj4gLSAgICBp
bnQgKCphdHRhY2hfZGV2aWNlKShjb25zdCBjaGFyICpuYW1lLCBWRklPRGV2aWNlICp2YmFzZWRl
diwNCj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNzU3BhY2UgKmFzLCBFcnJv
ciAqKmVycnApOw0KPj4+PiArICAgIGJvb2wgKCphdHRhY2hfZGV2aWNlKShjb25zdCBjaGFyICpu
YW1lLCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgQWRkcmVzc1NwYWNlICphcywgRXJyb3IgKiplcnJwKTsNCj4+Pj4gICAgICAgIHZvaWQgKCpk
ZXRhY2hfZGV2aWNlKShWRklPRGV2aWNlICp2YmFzZWRldik7DQo+Pj4+ICAgICAgICAvKiBtaWdy
YXRpb24gZmVhdHVyZSAqLw0KPj4+PiAgICAgICAgaW50ICgqc2V0X2RpcnR5X3BhZ2VfdHJhY2tp
bmcpKGNvbnN0IFZGSU9Db250YWluZXJCYXNlDQo+KmJjb250YWluZXIsDQo+Pj4+IGRpZmYgLS1n
aXQgYS9ody92ZmlvL2FwLmMgYi9ody92ZmlvL2FwLmMNCj4+Pj4gaW5kZXggN2M0Y2FhNTkzOC4u
ZDUwNjAwYjcwMiAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvdmZpby9hcC5jDQo+Pj4+ICsrKyBiL2h3
L3ZmaW8vYXAuYw0KPj4+PiBAQCAtMTU2LDcgKzE1Niw2IEBAIHN0YXRpYyB2b2lkDQo+Pj4gdmZp
b19hcF91bnJlZ2lzdGVyX2lycV9ub3RpZmllcihWRklPQVBEZXZpY2UgKnZhcGRldiwNCj4+Pj4g
ICAgc3RhdGljIHZvaWQgdmZpb19hcF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoq
ZXJycCkNCj4+Pj4gICAgew0KPj4+PiAgICAgICAgRVJSUF9HVUFSRCgpOw0KPj4+PiAtICAgIGlu
dCByZXQ7DQo+Pj4+ICAgICAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4+Pj4gICAgICAgIFZGSU9B
UERldmljZSAqdmFwZGV2ID0gVkZJT19BUF9ERVZJQ0UoZGV2KTsNCj4+Pj4gICAgICAgIFZGSU9E
ZXZpY2UgKnZiYXNlZGV2ID0gJnZhcGRldi0+dmRldjsNCj4+Pj4gQEAgLTE2NSw5ICsxNjQsOCBA
QCBzdGF0aWMgdm9pZCB2ZmlvX2FwX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj5FcnJvcg0K
Pj4+ICoqZXJycCkNCj4+Pj4gICAgICAgICAgICByZXR1cm47DQo+Pj4+ICAgICAgICB9DQo+Pj4+
DQo+Pj4+IC0gICAgcmV0ID0gdmZpb19hdHRhY2hfZGV2aWNlKHZiYXNlZGV2LT5uYW1lLCB2YmFz
ZWRldiwNCj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2Vf
bWVtb3J5LCBlcnJwKTsNCj4+Pj4gLSAgICBpZiAocmV0KSB7DQo+Pj4+ICsgICAgaWYgKCF2Zmlv
X2F0dGFjaF9kZXZpY2UodmJhc2VkZXYtPm5hbWUsIHZiYXNlZGV2LA0KPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZhZGRyZXNzX3NwYWNlX21lbW9yeSwgZXJycCkpIHsNCj4+Pj4g
ICAgICAgICAgICBnb3RvIGVycm9yOw0KPj4+PiAgICAgICAgfQ0KPj4+Pg0KPj4+PiBkaWZmIC0t
Z2l0IGEvaHcvdmZpby9jY3cuYyBiL2h3L3ZmaW8vY2N3LmMNCj4+Pj4gaW5kZXggOTBlNGE1MzQz
Ny4uNzgyYmQ0YmVkNyAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvdmZpby9jY3cuYw0KPj4+PiArKysg
Yi9ody92ZmlvL2Njdy5jDQo+Pj4+IEBAIC01ODAsNyArNTgwLDYgQEAgc3RhdGljIHZvaWQgdmZp
b19jY3dfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LA0KPj4+IEVycm9yICoqZXJycCkNCj4+Pj4g
ICAgICAgIFMzOTBDQ1dEZXZpY2VDbGFzcyAqY2RjID0gUzM5MF9DQ1dfREVWSUNFX0dFVF9DTEFT
UyhjZGV2KTsNCj4+Pj4gICAgICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2ID0gJnZjZGV2LT52ZGV2
Ow0KPj4+PiAgICAgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+Pj4+IC0gICAgaW50IHJldDsNCj4+
Pj4NCj4+Pj4gICAgICAgIC8qIENhbGwgdGhlIGNsYXNzIGluaXQgZnVuY3Rpb24gZm9yIHN1YmNo
YW5uZWwuICovDQo+Pj4+ICAgICAgICBpZiAoY2RjLT5yZWFsaXplKSB7DQo+Pj4+IEBAIC01OTQs
OSArNTkzLDggQEAgc3RhdGljIHZvaWQgdmZpb19jY3dfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2
LA0KPj4+IEVycm9yICoqZXJycCkNCj4+Pj4gICAgICAgICAgICByZXR1cm47DQo+Pj4+ICAgICAg
ICB9DQo+Pj4+DQo+Pj4+IC0gICAgcmV0ID0gdmZpb19hdHRhY2hfZGV2aWNlKGNkZXYtPm1kZXZp
ZCwgdmJhc2VkZXYsDQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGRyZXNz
X3NwYWNlX21lbW9yeSwgZXJycCk7DQo+Pj4+IC0gICAgaWYgKHJldCkgew0KPj4+PiArICAgIGlm
ICghdmZpb19hdHRhY2hfZGV2aWNlKGNkZXYtPm1kZXZpZCwgdmJhc2VkZXYsDQo+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBlcnJwKSkgew0K
Pj4+PiAgICAgICAgICAgIGdvdG8gb3V0X2F0dGFjaF9kZXZfZXJyOw0KPj4+PiAgICAgICAgfQ0K
Pj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jb21tb24uYyBiL2h3L3ZmaW8vY29tbW9u
LmMNCj4+Pj4gaW5kZXggOGY5Y2JkYzAyNi4uODkwZDMwOTEwZSAxMDA2NDQNCj4+Pj4gLS0tIGEv
aHcvdmZpby9jb21tb24uYw0KPj4+PiArKysgYi9ody92ZmlvL2NvbW1vbi5jDQo+Pj4+IEBAIC0x
NDkyLDggKzE0OTIsOCBAQCByZXRyeToNCj4+Pj4gICAgICAgIHJldHVybiBpbmZvOw0KPj4+PiAg
ICB9DQo+Pj4+DQo+Pj4+IC1pbnQgdmZpb19hdHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsIFZGSU9E
ZXZpY2UgKnZiYXNlZGV2LA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNzU3Bh
Y2UgKmFzLCBFcnJvciAqKmVycnApDQo+Pj4+ICtib29sIHZmaW9fYXR0YWNoX2RldmljZShjaGFy
ICpuYW1lLCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgIEFkZHJlc3NTcGFjZSAqYXMsIEVycm9yICoqZXJycCkNCj4+Pj4gICAgew0KPj4+PiAgICAg
ICAgY29uc3QgVkZJT0lPTU1VQ2xhc3MgKm9wcyA9DQo+Pj4+DQo+Pj4NCj5WRklPX0lPTU1VX0NM
QVNTKG9iamVjdF9jbGFzc19ieV9uYW1lKFRZUEVfVkZJT19JT01NVV9MRUdBQ1kpKTsNCj4+Pg0K
Pj4+DQo+Pj4gSSB0aGluayB2ZmlvX2F0dGFjaF9kZXZpY2UoKSBjYW4gYmUgY2xlYW5lZCB1cCBh
IGxpdHRsZSBmdXJ0aGVyIDoNCj4+Pg0KPj4+ICAgICByZXQgPSBvcHMtPmF0dGFjaF9kZXZpY2Uo
bmFtZSwgdmJhc2VkZXYsIGFzLCBlcnJwKTsNCj4+PiAgICAgIGlmIChyZXQgPCAwKSB7DQo+Pj4g
ICAgICAgICAgcmV0dXJuIHJldDsNCj4+PiAgICAgIH0NCj4+DQo+PiBOb3QgdW5kZXJzdGFuZCB0
aGlzLg0KPj4gSSBoYXZlIGJvdGggb3BzLT5hdHRhY2hfZGV2aWNlKCkgYW5kIHZmaW9fYXR0YWNo
X2RldmljZSgpIHJldHVybiBib29sDQo+PiBpbiB0aGlzIHBhdGNoLiBEbyB5b3UgbWVhbiBkcm9w
IHRoZSBjaGFuZ2UgZm9yIG9wcy0+YXR0YWNoX2RldmljZSgpPw0KPj4gT3Igc3BsaXQgdGhlIHR3
byBjaGFuZ2VzPw0KPg0KPlRoZSByZXR1cm4gdmFsdWUgb2Ygb3BzLT5hdHRhY2hfZGV2aWNlKCkg
c2hvdWxkIGJlIHRlc3RlZCBhcyBhIGJvb2wgbm93DQo+YW5kIG5vdCBhcyBhbiBpbnQsIGFzIGl0
IGlzIHN0aWxsIGN1cnJlbnRseSBkb25lLg0KPg0KPlNlZSB0aGUgZml4IGhlcmUgOg0KPiAgICAg
IGh0dHBzOi8vZ2l0bGFiLmNvbS9sZWdvYXRlci9xZW11Ly0NCj4vY29tbWl0L2FiYWU4OGRjMjhl
NzIzNzQ1ZmUyZmY1MDZlYTlmMGFkZWI0N2FmZGINCj4NCj5QbGVhc2Ugc2ltcGx5IGZvbGQgdGhl
IGNoYW5nZXMgaW4gdGhpcyBwYXRjaC4NCg0KQ2xlYXIsIEknbGwgZm9sZCBpdCBpbiBoaW9kIHY0
IHNlcmllcy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

