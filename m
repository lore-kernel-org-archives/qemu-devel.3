Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72DFC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9drd-0006yI-DY; Wed, 22 May 2024 00:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9drD-0006XJ-W2
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:45:46 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9drC-0006RA-6L
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716353142; x=1747889142;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Mj1dmxzrA1gdIy3Tnb+rc3tNGnQZeA3lnJlt0Bcr1Lg=;
 b=RGyZ3qWO7S6VeHawi6Cy3PiqgXCGbgDwrqqGP1WWKv2Cp9UrdDuDCPO4
 iJ+PvyVTvrsVcOXwZU0iZwQrwCUMFtRYSj3qisFqCd9mvxBJ20xRFT64L
 7FlWYXgWXq4ftQpLM/f04NTwmpViQqTMQGF5zV9iYgQPj5F/auW+Ubhr9
 EBNxsjaqqwO46Ado70gF5A7/B66utqyhjcKEHGF5rQ4b6GvIHUfhXvIDb
 nypbyLS+mq2isZSQHF7ISnydq0gDhVHlgNp3W0XQhkXmrt+G6ecOCihZh
 BsCYdd/erOPSS3uVs58c5B8B+n8WVm3gLU0G1i2N1djbeM1Vh5zwHFEYJ A==;
X-CSE-ConnectionGUID: 0poH7phZSU65U6XGmHcQQg==
X-CSE-MsgGUID: oNKp930YSly8Sy4U6OUJsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12452311"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="12452311"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:45:41 -0700
X-CSE-ConnectionGUID: d5q2DrRvR7meCxTtMdmMaA==
X-CSE-MsgGUID: 2hKoz4DKTI6t1XPkOMJQfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="70566157"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 May 2024 21:45:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 21:45:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 21:45:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 21:45:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 21:45:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWdRYQnSLB5J6Gek4K3vksQXA5UIwf+LY4fRAJNgtM6fZXn6PAVqxUxxpQKtlwIbLt4DHXffgsVTuF8kK670IUYw5V3ddTqwUPqgizSN4labCCXXJp0U0vgtcIzrzKaMPqLr8kjZ0B1NyUYH6auu0lLt1c9UIQWAymRyjy37SHV1vjf17Qcd8bVtLVJge0fDhN/SDG8VvHT0QRTWgDlegzrioyXnt8KMO0LnKvDrirp6AGPYLoGflUHjjlZ+AcrG4KJEgdlgGfA57DnPgXBRDe4K/UueTaQS3+bGgaT6AChKoYSPD4KqXuiP6Q/yZQNstSkWemWs0GHu5A6w++qkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj1dmxzrA1gdIy3Tnb+rc3tNGnQZeA3lnJlt0Bcr1Lg=;
 b=m29cL7JvOeaPHl44hEuFqxa/sskp/8/VNvY7n9zw1Tr4z3ZDaKNPkbU7tze1cAYl9+tUoqt7oB03M8lz8t+ohZNjKxp4d3N/nSIkoFXGTmUiNhkF6yoTT7D871rC6QZI3XsPKidpgwB8r9msILhLmSC5LZP5uKS6ZFSSjWD3gAnEUyRFUYGU/kjU/iQrPL7OGZUJkq6GlQSbOMZ8FiXh97WHWeGc+R7jNSxrZPVbEO/B2eKONPXDhuhR4Fvoz4fNnDqzQXIacisknq+5+cJIrDhvVhWeyl4B4YoI29tmUPWX4+xWYif8OU/VO+230aKE4nqk9rvfZpE62ybDhfKrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Wed, 22 May
 2024 04:45:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e%4]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 04:45:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH 02/16] vfio/display: Make vfio_display_*() return bool
Thread-Topic: [PATCH 02/16] vfio/display: Make vfio_display_*() return bool
Thread-Index: AQHapqE2cuXBCoRg+0CL1U9AIYoN17Gho60AgAEUKVA=
Date: Wed, 22 May 2024 04:45:35 +0000
Message-ID: <SJ0PR11MB6744DE4869D9483750739A5E92EB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-3-zhenzhong.duan@intel.com>
 <94735f57-d329-4444-80a7-09ab1182a6b1@redhat.com>
In-Reply-To: <94735f57-d329-4444-80a7-09ab1182a6b1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4752:EE_
x-ms-office365-filtering-correlation-id: 1eac6f19-aa58-4359-0eba-08dc7a1a04fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aWJSRlBwOVlXeE11MVdoSVFJOXZXaktJeXZEMzFKRVNaaXY4MzdQem9Od2Fy?=
 =?utf-8?B?Y1ZneTFzMmxHeENQVEVTeXlrTkhBNGRXdGxKWkI3MFVBK0dqSmJ3RXdHSzEy?=
 =?utf-8?B?MWJpSXBKV0I2QUZzemp3QnN6RlZvTkdFcCttRHlyNkh3K2VXKys4Y1NxWTlK?=
 =?utf-8?B?V1FTd1ovTGorR3ExNnJ3TWFpa3JKc0ZPV084TkV1Q3pkZW1mcHJMY1VkYk9j?=
 =?utf-8?B?MktERTNCMUs1Ui9CWmZvT2dLS3lCcHZXYWJoT2tGZDUyRkhETG5hbmtDdlMr?=
 =?utf-8?B?TEpORHNCL1pVVkZUa3lTMHNrVThKRmhIRUN2MkVDSEFjTWJEQm9Sd0tQRnd1?=
 =?utf-8?B?UGVJdkpSaFRMSEhQb0diMEhOR3NGV1E3QmdHT1hZSXFPbnp4ejllbWJWR1Fs?=
 =?utf-8?B?TVhsY21mWWFid3BFZDNOaFEvanoxNHhiVE5oZlcvOVJzOWcxRnR6Q2VEYnJL?=
 =?utf-8?B?bmY0RG1UNWNYUU5tYmNtMmhkSG5jSlA5OVlmMmpQbGpsMnRJcTNCOUU5QmdH?=
 =?utf-8?B?SFAwc3NvUk5aOG94VEE4Lzk1VVdLVnBQSUdFTmk1QVhUMnF3NVNPcnJTOUEx?=
 =?utf-8?B?b2E5d29sUmVQbFplOFdKeTNLMUp6UkpKcG5lZWtMZVBJay93RUdrdlNWT0g5?=
 =?utf-8?B?aW1WZEpTL1VaQTZZc0M4bk1YVjlaU1hSNElPOUY1STJhMm80d1piZVdBSnp1?=
 =?utf-8?B?ek5BbTN2NTJMWFlCNGh4UGtabEM3dk84MXgrVnYrQnVmby9tRVZYaFhHZm1R?=
 =?utf-8?B?eis4eXNxSXkrNHdwU0Fhak1VaklCMHlkejNEZStMd0pjUG9SY2txSnc5dnRt?=
 =?utf-8?B?TzhFcWZqWW4ySE1HZ25pd1NkMlhhQUtzSUdEb3A5QUx5eXZUV01rNGI2bVpT?=
 =?utf-8?B?OEdHQkFhNnBHYTNqb0tFSGlxYmt3eE5acFhDb2srdHhadFFvV2JVdmcwcGNE?=
 =?utf-8?B?QVpzeVhyWTFnR2xrZUN2d3VXOUMxOENOTmt6cFRlWDBHRFVmdlNqZ1Bxbng3?=
 =?utf-8?B?M1ZkYVBETlQzSk9nUGRUWW05WGlPYmsyenl4SEtiaE5UNThRc3VEY1RTZnRa?=
 =?utf-8?B?MXJOeUxzeXpiRURXeVdVUEt6VDVIeGdtZ2NUWnhqdkwrMDVPL1hPanN0M2Uw?=
 =?utf-8?B?UnNxQXVPbDNYbTdUZTlzcGxkOGNTR1JOS1cyRXpueVprdUNqUTFSY2hrbFF1?=
 =?utf-8?B?OUFudlhkU3RZSFQycjRQOS8vaW8xV3ZoL2NmbkRaUWkyU0xkTmw2cDViL0V6?=
 =?utf-8?B?bXRkRjI3TkxXNnl5ZkZpWVYzWTQzZlhxU09GOFlwckdLY1ZsUDl1R1M4OGFq?=
 =?utf-8?B?cStZMFoxeDZIbXZDUHdqaUllUlNnbC85emxlR0FLTGJyaVFGUmxHc3NsWnRH?=
 =?utf-8?B?N0JxNjdmNk9WbzdTUDlxb0xwb1VDZzJ2TElQYkV3TWdURVQ5RXRhQ0wwZC9i?=
 =?utf-8?B?MmVFOEZhSG1yVXBleUcrWWVzYlhNV1lxYlpyTU81RXUzVkRKZzVHdUlPVDZm?=
 =?utf-8?B?V1Z1aHlnY3lvelJ0YXRNbGJFcUs3MFpmZkhmRXlaYzF2c3duU0wzNTVNNTMy?=
 =?utf-8?B?ay9CbWl5dndJUWxBSno1WFRJMDF0dmp3YWFETHdUSnhWTm1GSmNQeDRJS3Y3?=
 =?utf-8?B?OExzMGE0QUxvYk5XNmRGT2hKWFhTMk8vSDc0NTQ0MGI5c21jOUtjNjJCWGNi?=
 =?utf-8?B?U3VZeHZpZUptR2JUWFVibHloWWdVUlRpcksxZ2VueDBodzFIYWwzenl4NGUv?=
 =?utf-8?B?OGNyTTRHekxSdythWEhtdTlnRGhNdnA4UmNiamo1MXJyWGIrbHZjK2llZ0FR?=
 =?utf-8?B?ekNLRVk4amxXbG9neCtOQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3RLYWxvdDdCSXc0a09ieGlLbDZ2NTJvOHNTdC92cWYzak5wakFGUVEvUlFE?=
 =?utf-8?B?Sis1YmdZVDFNSGlNN3NXWEJHMnBFMS9pNHpuY0FpUVJWZE1nK0w1SkttQXJE?=
 =?utf-8?B?S3VyNUo4WW5ZcWR6ZDdIS3FuVG1xaG4ya2trMDZkVkZ3QWN6RlpiZjRKMFMw?=
 =?utf-8?B?QWlsTXRVWndzUlFjOEp1OS81OThmTC8rYXlKVU00bXRnY1ZCMXh0dHJEVU4y?=
 =?utf-8?B?bTNXT1pvVXJHR1VNN0lBVDFrYnhOdEgwV1poNUFxSzFHbVdtYTc3emx6SExn?=
 =?utf-8?B?N0JOMEhmcW1mRW1tcVhxVlNBV3JqTTFEVlFGREVhSGpZejh0V0h3WmtLVFNy?=
 =?utf-8?B?TVRmSThBK29NU3VuV0tpNHFveW5xVmR4elJjeEVFMWN5Um5ocjh6VngvVlhr?=
 =?utf-8?B?UDRZRzNKVVlFcVBpbVhkeFEzRUplOHRuUTNkR1o0UDM4emhTMkJrNkV4bkpu?=
 =?utf-8?B?UlFVVDQyazZYZzZZY3JwdFdZUFFValNqTUY1T3p5WDNQbGxxejZ6VmxXY2Vi?=
 =?utf-8?B?QU5JbERObzAyWWNWc2luNUU5V3k5U1Y5U0prcG9WZkNURityc0FCRGtnOUd3?=
 =?utf-8?B?aXN6QitDelpTL2dkVFNCcmRMTzA2RHJVNi9RbVVBdFBXVVVGL0tuYllpYmRv?=
 =?utf-8?B?aEJ5d3NITHcvZmRWTGxubXNPcTVIOXRNQjVQZ1QzdGVsaExBbXo2ZWVQVE0x?=
 =?utf-8?B?YkNScTBOa2VrQkJSV08xNTRMYUIyRWpqODBsZFdhbUdPMWxtWkxreUZFcXR5?=
 =?utf-8?B?U1FkakdJN3hSQWxld240aHMzd3Z3cnFTWENYLzZVVlp3RjEwekttVVdienNr?=
 =?utf-8?B?NklxeTdBczF5UTFkTHEvMGpERHViNkRCMXJsU2dITlFZTDJoenpVV2Izb3lr?=
 =?utf-8?B?d1hzWkREOE44aHlFMTgvNHZ1VkNuRnRUV1d3OVBUeVFNZ3FTRDdyVytNUVV3?=
 =?utf-8?B?THB6bXk1TWJJRlhiU2tkRHFPK3M5SzRISkQ1TmtDVjVwZnowdHV0UGk5RFo1?=
 =?utf-8?B?QjBTMUFoalB0TnpEaW8xS1ZqcDEraHdweXVCMXh5RlhvN3M5Skg5a1NRUlZu?=
 =?utf-8?B?YjFPUE5IUlNISi9iTUdHSjJ0TkQvdmRVK1lxVHhnWWEzZDQxSDgySWs2ODFZ?=
 =?utf-8?B?aUtERkFyNU1POVo0YkpWY09lbXlTenlsMDlaeks0N2V3eFV6K0o2NE1IeGpj?=
 =?utf-8?B?azR5Y3lwbXltdHhTbkFEQzRITGhON2pxbXh3QjBCaENYRXI5eExwcVJhellt?=
 =?utf-8?B?ektyMWU2K2ZtQi9lTWRSQThac2ZEaVJJdEVwU2tHeG5keGhPbDlKdGpxUFll?=
 =?utf-8?B?R2UxQkJFWGZSeTg3VCtxeHoyUzc0Q1l6ZmlMaGVqU3pBcFZjT0tObG04ZnN3?=
 =?utf-8?B?OGYxcWFzd0xyZjdWWEFESU50SzRCK3Y3SnBNc2preDNlVmNmYUQxcGs4UitI?=
 =?utf-8?B?dHVJaUlOSVlhYlp5WmEzaGVhYThOUzY4REFidy83OWl6U3RCNTg0c1FXajh6?=
 =?utf-8?B?cjY1anFXRUp4NnZWbEViRUFaTGhoRUdnMGxJdHRxemppbEFlQTBEa0xkTDBZ?=
 =?utf-8?B?eHhydytlYk9Kalkyd1YwNUFYZ1RZUFJ4MWFScUxRcDZCMEw1aWV0dHRQMEtU?=
 =?utf-8?B?Ri9PRERIVisyV2lkN2hWcnhMcVU4M3BFWmxiQis3Vy9NV0NORHRJdmowemdy?=
 =?utf-8?B?eFg0OW9CcUxUU0dNVUxSWDBEMVBpMXlzc3FhUGF0QW9DRWdxSENraVcwSXFn?=
 =?utf-8?B?SW1ic2xIMjYwUVJWVGJRUEZyK3Vvd1lqZ0M1OHFSNDBoNWFtLzRWaUdIbmx4?=
 =?utf-8?B?OEpMcE1XRURlOHRmeE9yWDVUQzNkZ2NIdisxTVlqMUtVa0ZYM1VHdDFDeXhw?=
 =?utf-8?B?blliRTl2WnkralRqV0dqUjVlQ2haUEpRTmVZS0FmZG84RTV4Mmg3TUwyRWhs?=
 =?utf-8?B?Zkh1NjVhNnliWnZwZHdVWDl2aXhTcTZpZXE0aVI2M2ZkdHhGZkhuZ3h6eXVN?=
 =?utf-8?B?QytvKzJCV0ZkVWk5NnkvakVoNDVhOGZqMG1NdWxVcFpLVGtkbWFsL2h4UHlP?=
 =?utf-8?B?QkhySHQrbkcrRXB1aXd3eDNYOTA5d3Jza1gxamoyZk9uVnRMMDNDYXlPU0pF?=
 =?utf-8?Q?bkpHUbmpZs1/2m6CcU9pgE3tD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eac6f19-aa58-4359-0eba-08dc7a1a04fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 04:45:35.0969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNCr59P+rgU45a5GCLQnn9pl9WrgJr+nm0mbOJlfckAtkKc+pWbdUzoekdUpf9swwNE/0adaO3Vi3Q6rQ1UNgf8jA1r5sIITkf5Nve3Gd5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDAyLzE2XSB2ZmlvL2Rpc3Bs
YXk6IE1ha2UgdmZpb19kaXNwbGF5XyooKSByZXR1cm4gYm9vbA0KPg0KPk9uIDUvMTUvMjQgMTA6
MjAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gVGhpcyBpcyB0byBmb2xsb3cgdGhlIGNvZGlu
ZyBzdGFuZGFuZCBpbiBxYXBpL2Vycm9yLmggdG8gcmV0dXJuIGJvb2wNCj4+IGZvciBib29sLXZh
bHVlZCBmdW5jdGlvbnMuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPg0KPg0KPlJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQo+DQo+T25lIGNvbW1lbnQgYmVsb3csDQo+DQo+PiAtLS0NCj4+
ICAgaHcvdmZpby9wY2kuaCAgICAgfCAgMiArLQ0KPj4gICBody92ZmlvL2Rpc3BsYXkuYyB8IDIw
ICsrKysrKysrKystLS0tLS0tLS0tDQo+PiAgIGh3L3ZmaW8vcGNpLmMgICAgIHwgIDMgKy0tDQo+
PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmggYi9ody92ZmlvL3BjaS5oDQo+PiBpbmRl
eCA5MmNkNjJkMTE1Li5hNWFjOWVmZDRiIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9wY2kuaA0K
Pj4gKysrIGIvaHcvdmZpby9wY2kuaA0KPj4gQEAgLTIzMiw3ICsyMzIsNyBAQCBpbnQgdmZpb19w
Y2lfaWdkX29wcmVnaW9uX2luaXQoVkZJT1BDSURldmljZQ0KPip2ZGV2LA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+DQo+PiAgIHZvaWQgdmZp
b19kaXNwbGF5X3Jlc2V0KFZGSU9QQ0lEZXZpY2UgKnZkZXYpOw0KPj4gLWludCB2ZmlvX2Rpc3Bs
YXlfcHJvYmUoVkZJT1BDSURldmljZSAqdmRldiwgRXJyb3IgKiplcnJwKTsNCj4+ICtib29sIHZm
aW9fZGlzcGxheV9wcm9iZShWRklPUENJRGV2aWNlICp2ZGV2LCBFcnJvciAqKmVycnApOw0KPj4g
ICB2b2lkIHZmaW9fZGlzcGxheV9maW5hbGl6ZShWRklPUENJRGV2aWNlICp2ZGV2KTsNCj4+DQo+
PiAgIGV4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdmZpb19kaXNwbGF5X3Ztc3RhdGU7
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9kaXNwbGF5LmMgYi9ody92ZmlvL2Rpc3BsYXkuYw0K
Pj4gaW5kZXggNTdjNWFlMGIyYS4uYjU2MmY0YmU3NCAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8v
ZGlzcGxheS5jDQo+PiArKysgYi9ody92ZmlvL2Rpc3BsYXkuYw0KPj4gQEAgLTM0NiwxMSArMzQ2
LDExIEBAIHN0YXRpYyBjb25zdCBHcmFwaGljSHdPcHMNCj52ZmlvX2Rpc3BsYXlfZG1hYnVmX29w
cyA9IHsNCj4+ICAgICAgIC51aV9pbmZvICAgID0gdmZpb19kaXNwbGF5X2VkaWRfdWlfaW5mbywN
Cj4+ICAgfTsNCj4+DQo+PiAtc3RhdGljIGludCB2ZmlvX2Rpc3BsYXlfZG1hYnVmX2luaXQoVkZJ
T1BDSURldmljZSAqdmRldiwgRXJyb3IgKiplcnJwKQ0KPj4gK3N0YXRpYyBib29sIHZmaW9fZGlz
cGxheV9kbWFidWZfaW5pdChWRklPUENJRGV2aWNlICp2ZGV2LCBFcnJvciAqKmVycnApDQo+PiAg
IHsNCj4+ICAgICAgIGlmICghZGlzcGxheV9vcGVuZ2wpIHsNCj4+ICAgICAgICAgICBlcnJvcl9z
ZXRnKGVycnAsICJ2ZmlvLWRpc3BsYXktZG1hYnVmOiBvcGVuZ2wgbm90IGF2YWlsYWJsZSIpOw0K
Pj4gLSAgICAgICAgcmV0dXJuIC0xOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICAg
ICAgfQ0KPj4NCj4+ICAgICAgIHZkZXYtPmRweSA9IGdfbmV3MChWRklPRGlzcGxheSwgMSk7DQo+
PiBAQCAtMzYwLDExICszNjAsMTEgQEAgc3RhdGljIGludA0KPnZmaW9fZGlzcGxheV9kbWFidWZf
aW5pdChWRklPUENJRGV2aWNlICp2ZGV2LCBFcnJvciAqKmVycnApDQo+PiAgICAgICBpZiAodmRl
di0+ZW5hYmxlX3JhbWZiKSB7DQo+PiAgICAgICAgICAgdmRldi0+ZHB5LT5yYW1mYiA9IHJhbWZi
X3NldHVwKGVycnApOw0KPj4gICAgICAgICAgIGlmICghdmRldi0+ZHB5LT5yYW1mYikgew0KPj4g
LSAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gKyAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4+ICAgICAgICAgICB9DQo+PiAgICAgICB9DQo+PiAgICAgICB2ZmlvX2Rpc3BsYXlfZWRp
ZF9pbml0KHZkZXYpOw0KPg0KPnZmaW9fZGlzcGxheV9lZGlkX2luaXQoKSBjYW4gZmFpbCBmb3Ig
bWFueSByZWFzb25zIGFuZCBkb2VzIGl0IHNpbGVudGx5Lg0KPkl0IHdvdWxkIGJlIGdvb2QgdG8g
cmVwb3J0IHRoZSBlcnJvciBpbiBhIGZ1dHVyZSBwYXRjaC4NCg0KWWVzLCB0aGF0IGRlc2VydmUg
YSBmaXguIFdpbGwgYWRkcmVzcyBpdCB3aXRoIGEgZnV0dXJlIHBhdGNoLg0KDQpUaGFua3MNClpo
ZW56aG9uZw0KDQo=

