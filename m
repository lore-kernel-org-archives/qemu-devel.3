Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0182AC7115C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 02:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTX0W-0007VS-72; Sun, 22 Jun 2025 22:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTX0R-0007VA-PZ
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:34:00 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTX0P-0002eN-TG
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750646038; x=1782182038;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZRxf93qjSwJfc51jIhantSCyUwkri2MiVqmn4vs+r88=;
 b=KNXX18a0uVQScjPvfnANtOLh6LoWjacykKzycRQAnck+JJTHRC0ruOM7
 bqys1lupa6RU/RUqSW2woS5GN71jYvFJi2SWMGW6icOj8XrhwXaIE0Bed
 pUeqVL3PP8c+UiM+JYgo5yMcxiej7AX3Aqmp6nLUR3xQ/c5gi46eVAAC7
 Lk/IUVUtwVuVghTeqbF6X+CyTz9OxZl085EMz6MkpQNGxcqlBNkiMBbSa
 UeVKwCEmHw4Nd10U/jAddCAylFrm088Rtn731SyZc+ZGVd0sPOW7Y+qWQ
 l45gm+91b/qv3PbaYYitqqvdVVZv2qyzDfH7ZNzjH3OpFxeP7BT7ncLs7 Q==;
X-CSE-ConnectionGUID: KRR/+tv7Q6GfSExlR85VjA==
X-CSE-MsgGUID: M7xjiwzbSnGNDylCP/wbkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63527984"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; d="scan'208";a="63527984"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 19:33:55 -0700
X-CSE-ConnectionGUID: nkS6iKRoQW2AQ7uyK4asZA==
X-CSE-MsgGUID: GboYcVS7Tu+i4V8AdBkPHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; d="scan'208";a="151974606"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 19:33:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 19:33:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 22 Jun 2025 19:33:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.48)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 19:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwbZi6pJ9+B54mUYw7lP6/TIjo4VBd1Hls19hT3y6WFjStpfDoCd8j4vo/Dq6GZrK+fxzLSNwD89g3opt7Wss8O/8ppVbeCF3uEZciUGgpT8D6jLjOGI6lrEBKH8HDzKQKzUXraASt/IxIBBvQuQbzwcWg/pi+tD+LgGpVAkaidBcvAsqRKa7CqX9pUOqXNXEco9sld/L7OB3ZB3QsCkvc2OJvSWiH5J9W8HlcHxnYknkc2mmMCNY20AuHiaI8ezgQhHF7WDoSGUUfyOP34gAFPDiwkKqzlTTAtKoV5QwVOmEjRVCCzOO69Mi7HAEu5O6V4xdkZz79XnYT1T9Bo7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRxf93qjSwJfc51jIhantSCyUwkri2MiVqmn4vs+r88=;
 b=jb/Q4Q9uNVkzmfYVrcePziuSesdXs0ve+OVZi3DN3/MkxhVp65aYyNe/xql8BgOxybFvLj/Vkp108SSzbB68wbYNDdGGvRqNfA7NvBVtFVCyttSWVh3U0R2u6LTo0b7joKHYCsAIB88Vk6ZTqJbz6Ctc8ZCqD09zvMpvzOuFA/aw84n1ida9K9PxVggArwu0qou0EsaTdDLGkqb4A89ghHLotgzKNxMQ8OsvDC76ZZbKp2ixZlwpUp11KWIyszt1RMeNa3w8kQlCInp3i0lpUEsri6ZbVtQP/e6lIbIR3gWFzCr8TPZNzwu6Yr1Pz8T7kSZNWBVAKDGElpq+sErZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB7038.namprd11.prod.outlook.com (2603:10b6:806:2b3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 02:33:52 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 02:33:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 04/19] vfio/iommufd: Force creating nested parent domain
Thread-Topic: [PATCH v2 04/19] vfio/iommufd: Force creating nested parent
 domain
Thread-Index: AQHb4bQZmfv9bW4VFEaXRAKh3QS54bQLsacAgARYlkA=
Date: Mon, 23 Jun 2025 02:33:52 +0000
Message-ID: <IA3PR11MB9136B6090F1EFEC8EB86BEEE9279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-5-zhenzhong.duan@intel.com>
 <a4d799f1-76fd-4608-af67-699e3dd4f1aa@redhat.com>
In-Reply-To: <a4d799f1-76fd-4608-af67-699e3dd4f1aa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB7038:EE_
x-ms-office365-filtering-correlation-id: c51b7a31-a0a5-477d-cfee-08ddb1fe6472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WnZweGpNTHNrQkNEem9jZElORUdPeDZWVkZLUDNqSkZVTURmazR1WEZMdXZN?=
 =?utf-8?B?ejBZWFBNak5USGMzR0k2QW1hcHVzbGhGUmZzRW9DSjBESnVlSk1aaVdiS2o1?=
 =?utf-8?B?TjFQMGpIcmNuVU56WjBya1h1ZWw0ZDd4a0tUa0VaUzRlcUUvRTExdkZDMUl2?=
 =?utf-8?B?ak1Jc2lFY0ZDRXowWjVxRkRNM0V6TjVLL2U5Nis3bSsxcDM5K1RmQVpNeFo0?=
 =?utf-8?B?dlA0U1Fsb2MyT0RFUnRXL0NmUmVXWEhKOVA1Mi9DYTJXVm5BODR5NnpYelZh?=
 =?utf-8?B?ZTRDUmxHOHk1UkdGQ0gzTGxyMlY1dFVvMm1jVzRteHVnaTU0QW5LSm9GUmI5?=
 =?utf-8?B?SFhsZk1KaUh6UnJWVENReVBTdUR0S21uYzJVenIwR0FYbFZrUHRDTVBaWmdC?=
 =?utf-8?B?aS9QK0U3aWJlcmdWbXRkTTdKQUhITUZwT0h1cjBOamNXTWtlMmpKd2Y0Y2tq?=
 =?utf-8?B?ekVQanN0RGVCMi9FcFZMcTZ1WHBCUTBFdjNOVUxVeEtWcm9TOWt6QTRWeUQw?=
 =?utf-8?B?bEFoNjhKWHVGa1dqMzE5cmtRSGNBWG9xZG5aQmphc3ZnNGhYSnh2bmRSUVYr?=
 =?utf-8?B?UVpVaTBETEdDSlNpOHkyV29KK3lpQ202TlpxV2FiOTZDaDN4ZE1GMkFDVTUz?=
 =?utf-8?B?OURYSCsxdjN4K0dzVlFVcEcveGRjR0hqc2poOEtqRW1CTWVHUTZydjI5QS93?=
 =?utf-8?B?bXVYcXFDQUthd3R6cGJCT3VtaFdMTGJQVHpmZmxzaGlpVHBDUHZlNmJoRWFS?=
 =?utf-8?B?UytqbSs4QzB3R2RkTmxGSkg0N1Z2QmxURFdiZ0pmS05xRjBKczhMQjVISmUx?=
 =?utf-8?B?bFlzQ3NndjNLaHNqR3FCZGQ0YVVCL0F2cUhsUENZRS9qVEhDVzFxb1o3anpV?=
 =?utf-8?B?L3hPbEt6T1hra2doSnF1aE1RYk9LTjUzd0xLTHJvTHZ4cnRzMU56RjQzdUhr?=
 =?utf-8?B?Vk1BWlJmeThDblZ4U3NaWDBNcHZFK05MNG5uQVhzeitqUCtYcUxLbVRTVjhG?=
 =?utf-8?B?VHBTdkxuRUVXeHJ2UmxERy9KYjVyNWxhOUx0YisxeU1OaXc5akhKTHRGSytJ?=
 =?utf-8?B?bUErWjlacllMRGVIanJNTmcrV1VTdWZuZVppNUJVVUY5c0RHZktqL1lORHZP?=
 =?utf-8?B?ZisxcFFDK2VBT2paWFBObEtrbkFkMGRDWWlzY0JGTTRGbGpZcFRtN1k1MExB?=
 =?utf-8?B?MHNMc0dYZHhyZmZ3UVhIeEdMbm9oWDNmYXVITE00U0N6S2lFR0U5emsvQ3Mz?=
 =?utf-8?B?OEtjZU11MHRQUW5uNjRhNTJ3RENSdkxWUEp2Qmp0ci9VZXZVVW5JZzB0VUMw?=
 =?utf-8?B?am81b1lnOXNWOUhneFpib2k3cHpMZ08ra3A3cVlzbURkZ2d2bUxQZHd4M3lQ?=
 =?utf-8?B?MkhtV1hTNER1QjM0dGtuSmNqazRXUnY1anZOZjZzOXlDK1lwYVp2YWtBNmUz?=
 =?utf-8?B?OFMxSjRBeWoyeHc2UDQ1WnBqTjNzcXpRajRYSGZrem41Z3BoblJObVZHSGdV?=
 =?utf-8?B?M3NtWVdJa0swaU9vcUhYNGxmQ29Vc0hhVkoyK0xwWDNVOEg3a2xXNmlTZWM1?=
 =?utf-8?B?bXAzZnFtaCtLdTFBT3VmM1dWTWFNc3NWWFFhYlpaQ01tQ2dpZnV0TUxqWlhT?=
 =?utf-8?B?c29XN3dEK2pSOHlkWmFHaWMxK1l3MDBSSXpRcFY5ZFM2VFBvNmpTdkpsMHI4?=
 =?utf-8?B?d1ROMjRTQ3hzSjdkQU1mMVR3cEZOZWk3RmZtZEN5YXNZV0QxOXBQK2RFMFNy?=
 =?utf-8?B?ZWhtdlYxWEFlRHljNU41Tndzdk05aDR3TFd6VlN0YU1FSVh1enM5NnVRYWJR?=
 =?utf-8?B?ZEhyYmVlcDU2bGl3cysrM294Q3lCRStCSk1lR0JUcmRXZi9WeUlVaVowQVdr?=
 =?utf-8?B?a1QrNnJIUHlJVWgwbitmc3V0MTZFT1poMWZ5UTlydGRVMnA0aW1CZldvckM5?=
 =?utf-8?B?K3plM2JyTXdtUUw2emNLV1RRblZCMnpHRkdrdmc4dm5TTFZTM1hUYjhYdTJm?=
 =?utf-8?Q?KJ61XylHmR65U6TCQHR7HBVa/mElRA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enVRSjBiMFAvSXM5V2JnZWFpYzRmTmxIamVIbWc5OE8xMmU1Q255NFR5aVFl?=
 =?utf-8?B?bW5mRW1JVnVkNWZnaDJrcnRTYWpJZ0dHWFR3VlNOTXdyUTlENy9weTFxbzls?=
 =?utf-8?B?S2pCbkp1MW93ZGlCbkdqOXEvelE0aVpGZUczcnJNMWdQcWdJWjhNb3lkQ2tY?=
 =?utf-8?B?ZVlQUU5XWk9RUjRUbDMyQk5iWjlMNmtVeTYzdC9QWE02VzhySmZjZWN4MWo2?=
 =?utf-8?B?WHVQVEpSbDBoQXBCWkRxb3gxeko1cTdLUmdjcEZwQk1JLzRqUHp2cUk2TVJE?=
 =?utf-8?B?TTROdEx6OUVFM0R0RWhaOVZPc1lQSitjRENJVlRmR3ZUTG5uQWlUVkZsbG1y?=
 =?utf-8?B?NFpZakdyb2R3UkFTTThSNGtza1JNZFVVQ2hzSlFvZi91Nmp3N082STNrT0RB?=
 =?utf-8?B?T09mUFczQzdqYm1OdDhSdk9WVDRQRHhPZFg5VUpFSVZqR3F1L1M4cjJmRHRz?=
 =?utf-8?B?aXFlVFgzV3grN0VQNTFwUTZqU0pXcHJuNEJ1VW1LWG1vOXZKNkprTlRTSGdj?=
 =?utf-8?B?eklPUk5VUFkycU9EMU5sRE5HeVFBZENkVzBoOWpuREpyUStNMFNiSXZVbEZC?=
 =?utf-8?B?ZnhWLzlIRlhvMCtyY3VKLzBTRkR2cFNGaDhFOStGbUkzSzVsK1I5NzJSUGd1?=
 =?utf-8?B?ODRXa3Z4ejZNTFhOdG5hZEw0dDdtb3NkRVJJdVBzNTlJeFVSZG12NmwwM3lJ?=
 =?utf-8?B?bXhiNEZpaGtvOG04anNjR2ZOVDdoVC93REIwTi9jMTA1VnhVSEN6V2RmTnFV?=
 =?utf-8?B?R1JleGRUUk5VTEJBNEFPWDBXOEp6Qmg1eFJUNGovSENLeUF2KzMzS2tCMGNI?=
 =?utf-8?B?Qis3MUM5VXp4TE1iMENQSmhTLy8rcldUMTB0ZHk5YXJrUSttV2o2YmE2V2ZN?=
 =?utf-8?B?cmpYSUZzcmNBbHkrTzZJNW1SOVlNVTAwd3c3d2RadjA0NE5XdzMvYkwyOVRM?=
 =?utf-8?B?QlJZbWNReXhqRE5uZFlkQWhpdXpRU2x4M3RWN1lwcUJQa2VLcFJsNENFOWp4?=
 =?utf-8?B?TjUva0xFbW9XM0FFVzFmVFQzb1VMSHZkYzREN3B3dVJoS0syNUtxSjBEL3VN?=
 =?utf-8?B?UFAzaDI3WEJmZHJuakh2ZEYxb3NvanZlK1BubVRTOTRXWWtRRlFnaXc5dmlT?=
 =?utf-8?B?K1ZVbXA2TjBxdm83ZHdPY1FrVlVhS1padFBGdnAxajJxNXllbXNjNXFQNVNi?=
 =?utf-8?B?VEVGbkFNRElsa0d0WUYwbm8vOGE2TFB3WXpidkZIL0h4RCt4aHhrQzU2Rk1Z?=
 =?utf-8?B?K3E4QkdNY08xUWJCeHRIblZjb0lsSko2VTg0clhpU0J2NldGTnhXd1o3QVJ4?=
 =?utf-8?B?WGoxbjhLZDR1SEVmYkpNU25hN3dSNEtyZ2xkWURBaGlLbjA3Q3hwTTgrZGNL?=
 =?utf-8?B?TDNGZmpQdVpPMmtFRUJZbWhLSHhydEtsQWhiQ3RTeDV0TENVSGJwdkdhemc3?=
 =?utf-8?B?dDM4TDlTeEZNU01vWTRwMWhKeFlXNzNSSzFPWjBmS3l5NVpoLzdDY2dKOTJQ?=
 =?utf-8?B?c1V3N0NycVYyZzRpYkJBRTRCK3JRS3NZb01BYkpGVGNQejBUeDMybzQ4UjY5?=
 =?utf-8?B?UVI2d0h3d0VBZDhvRDJ6ZFRoaGsvMFoxNEU5T1pCL2FBT3dHb2NjM3dTZnAz?=
 =?utf-8?B?MXpUU3pEUE5Xa0JPRjNMUWpHZ1B0YStza3M0RGlBK1dqNnZiTGxmWHg0Zlk2?=
 =?utf-8?B?Sm9mMDVvdjVIQ2F6Y1BDRi8vRUJ4NitQaXlsay9KT0Z3UDd6bzh5VnpadTBE?=
 =?utf-8?B?Vi8wZVIrSGhMeU9ZMVVCaUpqMnBqbWdxTXdYekxQai9WaWZaZHUwUnBqb3lS?=
 =?utf-8?B?R1lUWjk4ekZCRXhQaThIOGZLcU9aTExZUFFMSEhQWWNFYkVxeEFJQnQ0M0Na?=
 =?utf-8?B?cTFOMkQyb3F0enJvRTZMZU5hbllacUFiTW9KVncxemtSeFcrM2d6ak80MlNP?=
 =?utf-8?B?N1h3NElscUlwQTVtMGNHOHp1WVorZFVENXJiSHNLY0QwUG1lWFc3OElsMlh4?=
 =?utf-8?B?WTZPSnpRcnpWRk1yNmtFMEN3SFR5aXRQL2F6MldleTZQOXVzR052M0kxRFQy?=
 =?utf-8?B?R3pOSm9ZdTJGQ0xYSEhXNStSUXZxekJ2Z1RrejBzOHRMVmZTdTYxLyt5eHlK?=
 =?utf-8?Q?X6XHkMJWIcfi/Wtc6vYY6UrL9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51b7a31-a0a5-477d-cfee-08ddb1fe6472
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 02:33:52.1278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lagO4OqSNxzZczeZCUeIY+K0gQBdKJae+jhkkSxfQ6ssDj5xVrNQ1xGjhvt08arxWqfDPZbXBris/W9h4ym0JGP8RWQgyKZifwa8tWzCERQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7038
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDQvMTld
IHZmaW8vaW9tbXVmZDogRm9yY2UgY3JlYXRpbmcgbmVzdGVkIHBhcmVudA0KPmRvbWFpbg0KPg0K
Pg0KPg0KPk9uIDYvMjAvMjUgOToxNyBBTSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBDYWxs
IHBjaV9kZXZpY2VfZ2V0X3Zpb21tdV9jYXAoKSB0byBnZXQgaWYgdklPTU1VIHN1cHBvcnRzDQo+
VklPTU1VX0NBUF9TVEFHRTEsDQo+PiBpZiB5ZXMsIGNyZWF0ZSBuZXN0ZWQgcGFyZW50IGRvbWFp
biB3aGljaCBjb3VsZCBiZSByZXVzZWQgYnkgdklPTU1VIHRvDQo+Y3JlYXRlDQo+Y291bGQ/IElz
IHRoZXJlIGEgY2hvaWNlPw0KDQpJIHRoaW5rIG5vIG90aGVyIGNob2ljZS4NCklmIHZJT01NVSBy
ZXR1cm5zIFZJT01NVV9DQVBfU1RBR0UxLCBib3RoIHNtbXV2MyBhbmQgdnRkIHdhbnQgbmVzdGVk
DQp0cmFuc2xhdGlvbi4NCg0KPj4gbmVzdGVkIGRvbWFpbi4NCj4NCj5JIHdvdWxkIGFkZCBpbiB0
aGUgY29tbWl0IG1zZyB0aGF0IGl0IGlzIHNhZmUgYmVjYXVzZQ0KPg0KPmh3X2NhcHMgJiBWSU9N
TVVfQ0FQX1NUQUdFMSBjYW5ub3QgYmUgc2V0IHlldCBiZWNhdXNlIHMtPmZsdHMgaXMgZm9yYmlk
ZGVuDQo+dW50aWwgbGFzdCBwYXRjaCBvZiB0aGUgc2VyaWVzLg0KDQpXaWxsIGRvLg0KDQpUaGFu
a3MNClpoZW56aG9uZw0K

