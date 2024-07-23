Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DF0C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWBEZ-00020U-KZ; Tue, 23 Jul 2024 04:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWBEY-0001wC-Dt
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:50:58 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWBEU-0006LV-QR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721724655; x=1753260655;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x+G6GbQrzRCNaInujD9v+HuUTTrec3tFKZhG62uYtLE=;
 b=QHeYWA3XRG2d5mWoha4oRV6fGLrss5EHEAYiINWl3X1f/X3xGu/9giDE
 C65R28OQYs0gr7VmYqtM49we8jFffJVbmQtyxWLOayDFLFqnCWIL0nY3S
 x8x83CUR3wwkb9v5fRaKThBcsxDQkblas9x4pR8MdfNFCyOl3LYPhkxXr
 h+6OaucJj8wrpKPkYaUiLty2DuUJKT+wAZN2HOreWBFM059HJT2VHlSZ+
 o32O+GfojRDWlRxA7jj80Nqh2JPL7zPDNjohn7gkkY4b/MyMveLVIgik9
 SsWhNT9Z19rVW5txKjgGwYh5sYeRj6E9L5xz+qj7YWABtoOHMmCHvPzS7 g==;
X-CSE-ConnectionGUID: oNtqSJ+JSQeo6LtZC9jFrw==
X-CSE-MsgGUID: XgQYKtcRRI+crIzINUd8fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="36859064"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="36859064"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 01:50:51 -0700
X-CSE-ConnectionGUID: DknTRVN1RSCkZSpCcd8iNQ==
X-CSE-MsgGUID: ar3S7eK5RZW+GQlRTHWXXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="52108256"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jul 2024 01:50:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:50:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:50:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 01:50:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 01:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dx+ckDgLz8ZIhSDHt1ouN/D8OGeGmYXq+Y2OsaIN0RmhDhXOQGKSww6vrJ0rv+bcpbpIWWkfuaO7X6vNATOWY9afWYl7++Az1MiSvRNQoYmdth/iLem4yK6W8fZbvafdrje/90MayitNDV9Fq1R72bYUybG3ik7Hf++UqddRsKJdXtZ8CB8pL4pRxO+AZA8ad94V3FdGbGbeMmaxEaC4zBwq6HsjjWuT/rH2u6lb+nzA2BabnIeBnSmJUeRhYfvsZO6IevhB2ZewJ6ROi7+ZtFmfZeH/g+1VYqyUzPPuWyueEIikGHupPCPuj7WCKxqN8bkSDGrfjdsWNHIdOKrSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+G6GbQrzRCNaInujD9v+HuUTTrec3tFKZhG62uYtLE=;
 b=B8TZmgnDfxWAKmEqAZBeG44aP0z0d4a5L9efMeqaoqE7QHyWb/iWkUzlKA8+S1yKfq7LmNp9UgPa42YjIeUggAfkihBifwXv1gp+sP0zOYVZ+xm/MClhWDfYZNeQPG4Kgnshy6Bhoq8oYFBsP4DuMAOLZvDAN0Z68I90+BulnqaHEvgRGKTUV24CMMr29l8vfpQJzjaumNL30BqiNBKrBXbtwlTSyP9pPWDH324NB4CjxiL6vC48imTZ2LWws3F9maGxMQx0Qdyvt+GwLW6GTrRhHLtZq8oUgUz2+YDlvdv79AAtv2O0k0x9cJ+daDPamfEvSkHk7hHkHT5tgr6+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Tue, 23 Jul
 2024 08:50:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 08:50:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa2OtCWmQl4pZpx0e1R3JC4utGS7H8MJAAgAEmyHCAAAyqAIAAAulwgAABqiCABoT4AIAAGgrQ
Date: Tue, 23 Jul 2024 08:50:42 +0000
Message-ID: <SJ0PR11MB6744C4FB80847214EED92C8B92A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-4-zhenzhong.duan@intel.com>
 <e41c8b79-1b86-42de-b1d5-dce7ed29d422@eviden.com>
 <SJ0PR11MB6744F86F44C2C32C4B79C80A92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9c9dba22-df29-4121-8126-4707084b891b@intel.com>
 <SJ0PR11MB6744F4CAEA5A9627D79AFE2092AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB67448D180C7D00AD8F38EA4492AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <e755af11-d3f8-451d-b4ec-5da00fe2cfa1@eviden.com>
In-Reply-To: <e755af11-d3f8-451d-b4ec-5da00fe2cfa1@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6096:EE_
x-ms-office365-filtering-correlation-id: ea975efb-023a-4da1-5297-08dcaaf488cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WVNFMnRRMnZGUkZOOU91MnFGSTg1Qy9SejRlNGlhNGM0T1FIOU96QkpjbW1J?=
 =?utf-8?B?RE11MThtQzg1cm5kK3NtSDN6Zkhwd0hYWXJNYTRMVEc5TjZodzFoTStCTFo3?=
 =?utf-8?B?TmgzQkVpUlRsS2JPb0RtTU0wVXZ4ZDZ3cXpVVlpKa095b2VnTjFQVVJEV204?=
 =?utf-8?B?L3dNeGpLaWx3WnNyOHh1U1RVRWJqSituWUpXVXVqb0tXUnRTZnpSWm91eFY0?=
 =?utf-8?B?ZkhwWFNJL1NkK0g4U2UzNDgzR1daWVhJaTlzQW0rU2c5NUl5MEVzMDlvRDhs?=
 =?utf-8?B?aW9wYzZCY2lyRVBpR0JLYWtUaHU1K1dFTC9abURBWVhuM0dMUTJGSlRBN3hQ?=
 =?utf-8?B?YVd3TEVESE9ZQ0VvTVJmQ044OHNtNUNkeGhKcHhIMHk4RUx4cXg3eGpQQlBX?=
 =?utf-8?B?WGhRVm1lN0JIeis3Syt5M2Y3UEJ3WC83ZVErcVFsbEY5aGRQUnEvNnFxUmQ0?=
 =?utf-8?B?VkRpb1BMMnd1UjRSamRQa1dvc0Q0THl0b3ZhdE9aZnJLcUhDclVPUUJwYStI?=
 =?utf-8?B?TGJHbEdSVlM1OTlUemw4Q1MwY0RlN25ybWt5U0ZlOG5uWTdsYnhiK2srbXpq?=
 =?utf-8?B?blpMbnpRazNrZ2xHbnJleGxmbVZZSHdIbTNzM3dHc3Q1UU5Pam1XN0R3bE1K?=
 =?utf-8?B?Tk9qb2dreHNiY2dpdXk3S09jNWkvd2JIQWIxNDhENUk0eU9COXZVSDVvQ0NH?=
 =?utf-8?B?VlhJWFROdVVsY251SDJCUjlMN3QwaWFVd25xK0diRS9VdmF0VnBSOFU2QWJo?=
 =?utf-8?B?OVZ6TVJDNGR6cHdOYmtzcnI4S2F3bVl6aDlZczQ4K1RKdm5IdzQ0Z2QyV0dz?=
 =?utf-8?B?MXZtS1NYTWY4ZmhtVGtFNlN0akU5WExucS8xY2VFdkJxM1NkeVk0M2cyZEsx?=
 =?utf-8?B?eTdvMWtodFJoUEM1ck56aWlEeUxXME1yNjExc015ZTgzV0ZoZW03UW14NVQx?=
 =?utf-8?B?OTJRNWVYN3k4UnNyVEg1dmpmaVhoSi9WRFBZemd0SHU0SE51MU1oT0lZV2sy?=
 =?utf-8?B?NHE4aDBxU3dYVlRuTEh6VHAyNGEyYjBCSGdQTmg2K2RtRkRseWFqUmZVakh3?=
 =?utf-8?B?RGE1VkhEWi9UM29vcGh2ZGI0S3ZMaG5BV2x0ZlEvZzFUaTRDb2JxUU5mRTRh?=
 =?utf-8?B?QlU5Unh0ay9PZlgwdkNUcllpQWFUbmhublVNeUtGT1ZncWVxSkpNNWJpNkhE?=
 =?utf-8?B?akp6TGFGMjZEMkk3alhZWnVybElqVCswcW0rRG1vVVJXVUxZa1dpVkJTbUd2?=
 =?utf-8?B?enc2dHc4TGcwRG1kS01qM3ZLMW9iLzZ6NzRtOHZMMStpdzQ0WldjbGJ3YVQz?=
 =?utf-8?B?OURrUDRWN2tjVEtCYWdqVjB2QWtRTERNclp4eDE0WjJTRUY0ZXozL0JCdm9x?=
 =?utf-8?B?SXRXb0lmRkthazJ2emp3YjFuRHZDOVIyRE5LV1hQOW0zOUlwa1FXcE0vU0xV?=
 =?utf-8?B?RlcyWGwvK3lKTmQ5eE1KbGpnR1F5TFRieUdaeUxpZ2t6N0dYQWhYY1MrNXhV?=
 =?utf-8?B?UjRnR1hMaFAybnZVQTVKMkd3eDNZMjN6Mnd5VmFkcEVpRS80cFN4QlhOekpl?=
 =?utf-8?B?NU80NnN5cmdVcGZ0UURHeVVJaHF4RjJBWkJWdG9VWnVqamhtampORVE4ZjMx?=
 =?utf-8?B?bXVJN0o1UVJaRlg3OUtPUnBtVlB0VEw4Qm52RnRBcDdUUDczQXBoOFdMRHFV?=
 =?utf-8?B?cHpqc2k0YUx3bGEwV1MydWRqcjB4OTFQOUhCek5zd251QU1HZVUxQndoeEth?=
 =?utf-8?B?T1JTTkN0aWRvaU1tWlpONnRuMjd2RWlSWnZnVkRXNmFmK1BGMmpFNndhN1VF?=
 =?utf-8?B?b2IyelBiRmxscjcvWjExNXNLeTNPSEpVU3hzNHZhdUlqQXpRb2F1ZDVmS2Zl?=
 =?utf-8?B?K041am5zem4zMnRHWEJZak5ScXl3bGhJRGxxaFVObTZJZXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGRFSXRaV0wwM0h6NEtzejIrYWFBSGRZT0gzeGw3dmttVzNKaTIwT2FTRjIv?=
 =?utf-8?B?NVVwcEY0cnlMd3h4Ny9kaDNSRnRGckk5b2laS0FvVm1LVXhwY1FTYkE4aTBv?=
 =?utf-8?B?Yms0NXp5TXBrdHdHcmZqUW9mbnkzVXNObEpkUTltZUVOWU1BOFZxdkQ1QU50?=
 =?utf-8?B?WUJLK3Eva2JzY0ppYnJSdkE2NnA0cHc4R1V0QlpEdndXZ0w1TldKRkd4blZB?=
 =?utf-8?B?UW1vMXlibE1qaU1tdTNTLzNrR0Q2SzlBNFFBMHI0T21lY2hVZkplVDlYM0lG?=
 =?utf-8?B?bW1Nd0hFZWVYMjM1Z0VBUXgxWUpsV2F1TC95NTZ3RlpzMUtUZnY0czNTbDVu?=
 =?utf-8?B?SU5CeEJZblN0NzZ4aEh6S3dmTXQ1NlNJaWtXWHBZSnA3RUJnZmZFOVMxRm03?=
 =?utf-8?B?S0JEQWI1MWNZL1hPdmJ0b2g4ZHhaYVVBZDFDVCtMdXJYcjhNVG9hMnhZQ29T?=
 =?utf-8?B?QTlhS3pBZzdrTFNlODlrNXVOWUVPYVEwYWZtZ3loeWplMkVZZGxsdGxSUTJD?=
 =?utf-8?B?aGRtNlIzZnBtQlNtb0lOK1V4alFwaGZiOG5ld2RCRjUwcUxOUDVNOXpXV2pS?=
 =?utf-8?B?d2RqZlkrZTJLNm9ZMUZSZFpuTU03YXlKNEFrVk1teC9SaU9FSHl0dzF6TTR6?=
 =?utf-8?B?dFZBQ3JoMkFQT0Q2c3hWbFJuTWV6bTBhWmJzdHVkNmhmYUpGcUhWV1ZBT2Fl?=
 =?utf-8?B?NnlyV212ZG9BOEVYN1oweUczbjhmbUl4Si9SL0V4WXI1TjRsa1FhN2U3cS9m?=
 =?utf-8?B?b1NyRFl5Q09Ia1RPSG9tSFRTNUd2bG5WeGtHKzV0QWdCbFlRd21IQnZYUEtT?=
 =?utf-8?B?TC9MWCt4WE9aS2VHOE9OUy9hbkpHZXNvbUdPcTdoY2toKzlWbTZ4Q3VYNEww?=
 =?utf-8?B?Qmt2VUQ1Z3p0eEV4UVVtMWR6azhIbjZKYXBNSEhIMXdBbDhtOHFFdndrRXFQ?=
 =?utf-8?B?a3ZKSmlIcUs2dG9wVFc2ZEc4OWozbjJUQlZMOWpZQkdvNzhySUtCeXVhdWVz?=
 =?utf-8?B?ejI2Qm1JNjI0YkpqbnpMT0pyVzdkMG9ETkNCbWV6NGg5WElBUFpWVXFZVmx6?=
 =?utf-8?B?Q05ReVlwbyswdWFaT0U0RWRpb1JleGYwb3FvWWlzTGduVDNOVmxhaEdZNkVM?=
 =?utf-8?B?aFZRTDQwaENLM2IwODB2VHBRWDRRMzFET0NvY21zM0o4NkVQUzF3dWpDbEtq?=
 =?utf-8?B?Um9lT00xVXFtTG82NStVVzJRSUFHdmtXaXdrcjFwWm41bkhjTm9jOTJsVW41?=
 =?utf-8?B?aTNxMWE5ejJIamRseVp2Q0owenB3djEyRGgvQTZnai9nbXNyOGxmYnVYVHNQ?=
 =?utf-8?B?R1JuL3p0Nm5IN3U4bFBxSjVGaEJPWURza00wSjE0a0drZkQ0Z2Z5ajFCT0Ni?=
 =?utf-8?B?VlB3UkMvOGFLV2VVNGl0Tk45dDd6RTVZdUZ3eTZham5lcEJDSGtvRDJ4Z1Fu?=
 =?utf-8?B?czJYNUdPcStkVWNoMUc3UEtGdU8rU3NXZ0E4L2RGcjd6TWdWMTF0N0pZOEJs?=
 =?utf-8?B?VndkOVJ2QWMxYlJXblFVZFBGSHpRMkNYOU1hSTNnZUZyUWFtZXJSbjJvZXJP?=
 =?utf-8?B?WXp3RnJIOTlIZU5QUThqaWRIcW9GTnhjWExSbkM3Q2lsU2JORW9FcGpWRlRE?=
 =?utf-8?B?SFVCVmkzUjJKdEtic0RhMW1WUFJsZ3F6S1ZpUEhZZGJRbTBJdU9FNzBlNUlS?=
 =?utf-8?B?TThQTzNteldQa0NTa1NkUGpSbUFmMU1QV1RoZ0ZwcGNtN09NenZ0MWVBRWdU?=
 =?utf-8?B?SDdhSjQzckRpOU84NzU1bzhlT1BKN04reVpOZGZVQTBmVDRMWnE1cS9TcFpn?=
 =?utf-8?B?MWo5OEYxNDcraWY5YnhiUjZUSnlQVXJVbEQya3puM1dJSS9XZm9HbzhTbmwx?=
 =?utf-8?B?Vk5yOUxUKzQ2K1hBeks3L2tJQkNkWkVpSzVQdy9uZG1EWjNMTk9hNW1iTUt6?=
 =?utf-8?B?SlpNMDVmd0ZLeVpJTGlOMENpbDlDM0FvQTZmcnNoYS8rYWJ3bDJialg5L1VS?=
 =?utf-8?B?V2JqZStiNGJjVlJSV05RMXIvdUxzeXpRWWFMQ2VtdjNPa29FMG1jUVNRZVQy?=
 =?utf-8?B?ZHZldG0wN0REeURVdmtVMWt1SHRoUVk3NXBCY0dTU0kvWmpFSlBqb2RHWXJO?=
 =?utf-8?Q?AePEeMTun97lIicgUXEsmNMYz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea975efb-023a-4da1-5297-08dcaaf488cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 08:50:42.2992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5aisbNUsX1k0V5QZtPLVUpyVD1Lfpw+CXocXqCTpIJNGGfB2PEAWIw3dCCD8nh3tTQLzzLf7SFozUr6FfBSbogEqKEl1sooESJ8FqZgpC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAwMy8xN10gaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9sZGVyIHZhcmlhYmxlIGZv
cg0KPnNjYWxhYmxlIG1vZGVybiBtb2RlDQo+DQo+DQo+DQo+T24gMTkvMDcvMjAyNCAwNTozOSwg
RHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5v
dCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0KPmVtYWlsIGNv
bWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IER1YW4s
IFpoZW56aG9uZ10NCj4+PiBTdWJqZWN0OiBSRTogW1BBVENIIHYxIDAzLzE3XSBpbnRlbF9pb21t
dTogQWRkIGEgcGxhY2Vob2xkZXIgdmFyaWFibGUNCj5mb3INCj4+PiBzY2FsYWJsZSBtb2Rlcm4g
bW9kZQ0KPj4+DQo+Pj4NCj4+Pg0KPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+
PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MSAwMy8xN10gaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9sZGVyIHZhcmlhYmxl
DQo+Zm9yDQo+Pj4+IHNjYWxhYmxlIG1vZGVybiBtb2RlDQo+Pj4+DQo+Pj4+IE9uIDIwMjQvNy8x
OSAxMDo0NywgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+Pj4NCj4+Pj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MSAwMy8xN10gaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9sZGVyDQo+dmFyaWFibGUNCj4+
Pj4gZm9yDQo+Pj4+Pj4gc2NhbGFibGUgbW9kZXJuIG1vZGUNCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+
Pj4NCj4+Pj4+PiBPbiAxOC8wNy8yMDI0IDEwOjE2LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+
Pj4+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9y
IGNsaWNrIGxpbmtzLA0KPnVubGVzcw0KPj4+PiB0aGlzDQo+Pj4+Pj4gZW1haWwgY29tZXMgZnJv
bSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+Pj4+
Pj4NCj4+Pj4+Pj4gQWRkIGFuIG5ldyBlbGVtZW50IHNjYWxhYmxlX21vZGUgaW4gSW50ZWxJT01N
VVN0YXRlIHRvIG1hcmsNCj4+Pj4gc2NhbGFibGUNCj4+Pj4+Pj4gbW9kZXJuIG1vZGUsIHRoaXMg
ZWxlbWVudCB3aWxsIGJlIGV4cG9zZWQgYXMgYW4gaW50ZWxfaW9tbXUNCj4+PiBwcm9wZXJ0eQ0K
Pj4+Pj4+PiBmaW5hbGx5Lg0KPj4+Pj4+Pg0KPj4+Pj4+PiBGb3Igbm93LCBpdCdzIG9ubHkgYSBw
bGFjZWhob2xkZXIgYW5kIHVzZWQgZm9yIGNhcC9lY2FwIGluaXRpYWxpemF0aW9uLA0KPj4+Pj4+
PiBjb21wYXRpYmlsaXR5IGNoZWNrIGFuZCBibG9jayBob3N0IGRldmljZSBwYXNzdGhyb3VnaCB1
bnRpbCBuZXN0aW5nDQo+Pj4+Pj4+IGlzIHN1cHBvcnRlZC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gU2ln
bmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+Pj4+
IC0tLQ0KPj4+Pj4+PiAgICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDIgKysN
Cj4+Pj4+Pj4gICAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8ICAxICsNCj4+Pj4+
Pj4gICAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDM0ICsrKysrKysrKysrKysr
KysrKysrKysrLS0NCj4tLS0tLQ0KPj4+IC0tDQo+Pj4+IC0tDQo+Pj4+Pj4+ICAgICAzIGZpbGVz
IGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPj4+Pj4+Pg0KPj4+
Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+Pj4g
Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4+Pj4gaW5kZXggYzBjYTdiMzcy
Zi4uNGUwMzMxY2FiYSAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+Pj4+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0K
Pj4+Pj4+PiBAQCAtMTk1LDYgKzE5NSw3IEBADQo+Pj4+Pj4+ICAgICAjZGVmaW5lIFZURF9FQ0FQ
X1BBU0lEICAgICAgICAgICAgICAoMVVMTCA8PCA0MCkNCj4+Pj4+Pj4gICAgICNkZWZpbmUgVlRE
X0VDQVBfU01UUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQzKQ0KPj4+Pj4+PiAgICAgI2RlZmlu
ZSBWVERfRUNBUF9TTFRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDYpDQo+Pj4+Pj4+ICsjZGVm
aW5lIFZURF9FQ0FQX0ZMVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NykNCj4+Pj4+Pj4NCj4+
Pj4+Pj4gICAgIC8qIENBUF9SRUcgKi8NCj4+Pj4+Pj4gICAgIC8qIChvZmZzZXQgPj4gNCkgPDwg
MjQgKi8NCj4+Pj4+Pj4gQEAgLTIxMSw2ICsyMTIsNyBAQA0KPj4+Pj4+PiAgICAgI2RlZmluZSBW
VERfQ0FQX1NMTFBTICAgICAgICAgICAgICAgKCgxVUxMIDw8IDM0KSB8ICgxVUxMIDw8IDM1KSkN
Cj4+Pj4+Pj4gICAgICNkZWZpbmUgVlREX0NBUF9EUkFJTl9XUklURSAgICAgICAgICgxVUxMIDw8
IDU0KQ0KPj4+Pj4+PiAgICAgI2RlZmluZSBWVERfQ0FQX0RSQUlOX1JFQUQgICAgICAgICAgKDFV
TEwgPDwgNTUpDQo+Pj4+Pj4+ICsjZGVmaW5lIFZURF9DQVBfRlMxR1AgICAgICAgICAgICAgICAo
MVVMTCA8PCA1NikNCj4+Pj4+Pj4gICAgICNkZWZpbmUgVlREX0NBUF9EUkFJTiAgICAgICAgICAg
ICAgIChWVERfQ0FQX0RSQUlOX1JFQUQgfA0KPj4+Pj4+IFZURF9DQVBfRFJBSU5fV1JJVEUpDQo+
Pj4+Pj4+ICAgICAjZGVmaW5lIFZURF9DQVBfQ00gICAgICAgICAgICAgICAgICAoMVVMTCA8PCA3
KQ0KPj4+Pj4+PiAgICAgI2RlZmluZSBWVERfUEFTSURfSURfU0hJRlQgICAgICAgICAgMjANCj4+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Pj4+Pj4g
Yi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+Pj4+PiBpbmRleCAxZWIwNWMyOWZj
Li43ODhlZDQyNDc3IDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxf
aW9tbXUuaA0KPj4+Pj4+PiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+
Pj4+PiBAQCAtMjYyLDYgKzI2Miw3IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4+Pj4+
Pg0KPj4+Pj4+PiAgICAgICAgIGJvb2wgY2FjaGluZ19tb2RlOyAgICAgICAgICAgICAgLyogUk8g
LSBpcyBjYXAgQ00gZW5hYmxlZD8gKi8NCj4+Pj4+Pj4gICAgICAgICBib29sIHNjYWxhYmxlX21v
ZGU7ICAgICAgICAgICAgIC8qIFJPIC0gaXMgU2NhbGFibGUgTW9kZSBzdXBwb3J0ZWQ/DQo+Pj4g
Ki8NCj4+Pj4+Pj4gKyAgICBib29sIHNjYWxhYmxlX21vZGVybjsgICAgICAgICAgIC8qIFJPIC0g
aXMgbW9kZXJuIFNNIHN1cHBvcnRlZD8NCj4qLw0KPj4+Pj4+PiAgICAgICAgIGJvb2wgc25vb3Bf
Y29udHJvbDsgICAgICAgICAgICAgLyogUk8gLSBpcyBTTlAgZmlsZWQgc3VwcG9ydGVkPyAqLw0K
Pj4+Pj4+Pg0KPj4+Pj4+PiAgICAgICAgIGRtYV9hZGRyX3Qgcm9vdDsgICAgICAgICAgICAgICAg
LyogQ3VycmVudCByb290IHRhYmxlIHBvaW50ZXIgKi8NCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+PiBpbmRl
eCAxY2ZmOGIwMGFlLi40MGNiZDRhMGY0IDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+Pj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+Pj4+
IEBAIC03NTUsMTYgKzc1NSwyMCBAQCBzdGF0aWMgaW5saW5lIGJvb2wNCj4+Pj4+PiB2dGRfaXNf
bGV2ZWxfc3VwcG9ydGVkKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDMyX3QgbGV2ZWwpDQo+Pj4+
Pj4+ICAgICB9DQo+Pj4+Pj4+DQo+Pj4+Pj4+ICAgICAvKiBSZXR1cm4gdHJ1ZSBpZiBjaGVjayBw
YXNzZWQsIG90aGVyd2lzZSBmYWxzZSAqLw0KPj4+Pj4+PiAtc3RhdGljIGlubGluZSBib29sIHZ0
ZF9wZV90eXBlX2NoZWNrKFg4NklPTU1VU3RhdGUNCj4qeDg2X2lvbW11LA0KPj4+Pj4+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lERW50cnkgKnBlKQ0KPj4+
Pj4+PiArc3RhdGljIGlubGluZSBib29sIHZ0ZF9wZV90eXBlX2NoZWNrKEludGVsSU9NTVVTdGF0
ZSAqcywNCj4+Pj4+PiBWVERQQVNJREVudHJ5ICpwZSkNCj4+Pj4+Pj4gICAgIHsNCj4+Pj4+PiBX
aGF0IGFib3V0IHVzaW5nIHRoZSBjYXAvZWNhcCByZWdpc3RlcnMgdG8ga25vdyBpZiB0aGUgdHJh
bnNsYXRpb24NCj50eXBlcw0KPj4+Pj4+IGFyZSBzdXBwb3J0ZWQgb3Igbm90Lg0KPj4+Pj4+IE90
aGVyd2lzZSwgd2UgY291bGQgYWRkIGEgY29tbWVudCB0byBleHBsYWluIHdoeSB3ZSBleHBlY3QN
Cj4+Pj4+PiBzLT5zY2FsYWJsZV9tb2Rlcm4gdG8gZ2l2ZSB1cyBlbm91Z2ggaW5mb3JtYXRpb24u
DQo+Pj4+PiBXaGF0IGFib3V0IGJlbG93Og0KPj4+Pj4NCj4+Pj4+IC8qDQo+Pj4+PiAgICAqVlRE
X0VDQVBfRkxUUyBpbiBlY2FwIGlzIHNldCBpZiBzLT5zY2FsYWJsZV9tb2Rlcm4gaXMgdHJ1ZSwg
b3IgZWxzZQ0KPj4+PiBWVERfRUNBUF9TTFRTIGNhbiBiZSBzZXQgb3Igbm90IGRlcGVuZGluZyBv
biBzLT5zY2FsYWJsZV9tb2RlLg0KPj4+Pj4gICAgKlNvIGl0J3Mgc2ltcGxlciB0byBjaGVjayBz
LT5zY2FsYWJsZV9tb2Rlcm4gZGlyZWN0bHkgZm9yIGEgUEFTSUQNCj5lbnRyeQ0KPj4+PiB0eXBl
IGluc3RlYWQgZWNhcCBiaXRzLg0KPj4+Pj4gICAgKi8NCj4+Pj4gU2luY2UgdGhpcyBoZWxwZXIg
aXMgZm9yIHBhc2lkIGVudHJ5IGNoZWNrLCBzbyB5b3UgY2FuIGp1c3QgcmV0dXJuIGZhbHNlDQo+
Pj4+IGlmIHRoZSBwZSdzIFBHVFQgaXMgU1Mtb25seS4NCj4+PiBJdCBkZXBlbmRzIG9uIHdoaWNo
IHNjYWxhYmxlIG1vZGUgaXMgY2hvc2VkLg0KPj4+IEluIHNjYWxhYmxlIGxlZ2FjeSBtb2RlLCBQ
R1RUIGlzIFNTLW9ubHkgYW5kIHdlIHNob3VsZCByZXR1cm4gdHJ1ZS4NCj4+Pg0KPj4+PiBJdCBt
aWdodCBtYWtlIG1vcmUgc2Vuc2UgdG8gY2hlY2sgdGhlIGVjYXAvY2FwIGhlcmUgYXMgYW55aG93
IHRoZQ0KPj4+PiBjYXBhYmlsaXR5IGlzIGxpc3RlZCBpbiBlY2FwL2NhcC4gVGhpcyBtYXkgYWxz
byBicmluZyB1cyBzb21lIGNvbnZlbmllbmNlLg0KPj4+Pg0KPj4+PiBTYXkgaW4gdGhlIGZ1dHVy
ZSwgaWYgd2Ugd2FudCB0byBhZGQgYSBuZXcgbW9kZSAoZS5nLiBzY2FsYWJsZSBtb2RlIDIuMCkN
Cj4+Pj4gdGhhdCBzdXBwb3J0cyBib3RoIEZTIGFuZCBTUyBmb3IgZ3Vlc3QsIHdlIG1heSBuZWVk
IHRvIHVwZGF0ZSB0aGlzDQo+aGVscGVyDQo+Pj4+IGFzIHdlbGwgaWYgd2UgY2hlY2sgdGhlIHNj
YWxhYmxlX21vZGVybi4gQnV0IGlmIHdlIGNoZWNrIHRoZSBlY2FwL2NhcCwNCj50aGVuDQo+Pj4+
IHRoZSBmdXR1cmUgY2hhbmdlIGp1c3QgbmVlZHMgdG8gY29udHJvbCB0aGUgZWNhcC9jYXAgc2V0
dGluZyBhdCB0aGUNCj4+Pj4gYmVnaW5uaW5nIG9mIHRoZSB2SU9NTVUgaW5pdC4gVG8ga2VlcCB0
aGUgY29kZSBhbGlnbmVkLCB5b3UgbWF5IG5lZWQNCj50bw0KPj4+PiBjaGVjayBlY2FwLlBUIGJp
dCBmb3IgVlREX1NNX1BBU0lEX0VOVFJZX1BULiA6KQ0KPj4+IE9LLCB3aWxsIGJlIGxpa2UgYmVs
b3c6DQo+Pj4NCj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiArKysgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4+PiBAQCAtODI2LDE0ICs4MjYsMTQgQEAgc3RhdGljIGlubGlu
ZSBib29sDQo+Pj4gdnRkX3BlX3R5cGVfY2hlY2soSW50ZWxJT01NVVN0YXRlICpzLCBWVERQQVNJ
REVudHJ5ICpwZSkNCj4+Pg0KPj4+ICAgICAgc3dpdGNoIChWVERfUEVfR0VUX1RZUEUocGUpKSB7
DQo+Pj4gICAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9GTFQ6DQo+Pj4gLSAgICAgICAgcmV0
dXJuIHMtPnNjYWxhYmxlX21vZGVybjsNCj4+PiArICAgICAgICByZXR1cm4gISEocy0+ZWNhcCAm
IFZURF9FQ0FQX0ZMVFMpOw0KPj4+ICAgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfU0xUOg0K
Pj4+IC0gICAgICAgIHJldHVybiAhcy0+c2NhbGFibGVfbW9kZXJuOw0KPj4+ICsgICAgICAgIHJl
dHVybiAhIShzLT5lY2FwICYgVlREX0VDQVBfRkxUUykgfHwgIShzLT5lY2FwICYNCj5WVERfRUNB
UF9TTVRTKTsNCj4+IFNvcnJ5IHR5cG8gZXJyLCBzaG91bGQgYmU6DQo+Pg0KPj4gKyAgICAgICAg
cmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9TTFRTKSB8fCAhKHMtPmVjYXAgJg0KPlZURF9F
Q0FQX1NNVFMpOw0KPj4NCj5Nb3Jlb3Zlciwgc2hvdWxkbid0IHdlIGRlY2xhcmUgdGhlIGNhcGFi
aWxpdGllcyBhZnRlciB0aGUgZmVhdHVyZSBpcw0KPmltcGxlbWVudGVkPw0KPkkgdGhpbmsgRkxU
UyBhbmQgRlMxR1Agc2hvdWxkIG5vdCBiZSBkZWNsYXJlZCB0aGF0IGVhcmx5Lg0KDQpPSywgSSBj
YW4gbW92ZSBpdCB0byAiIFtQQVRDSCB2MSAxNi8xN10gaW50ZWxfaW9tbXU6IE1vZGlmeSB4LXNj
YWxhYmxlLW1vZGUgdG8gYmUgc3RyaW5nIG9wdGlvbiIsDQpJbiBmYWN0LCBiZWZvcmUgcGF0Y2gx
NiwgdGhlcmUgaXMgbm8gd2F5IHRvIGVuYWJsZSBzLT5zY2FsYWJsZV9tb2Rlcm4sIHNvIHRob3Nl
IGNhcHMgY2FuIG5ldmVyIGJlIGVuYWJsZWQuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4+PiAg
ICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX05FU1RFRDoNCj4+PiAgICAgICAgICAvKiBOb3Qg
c3VwcG9ydCBORVNURUQgcGFnZSB0YWJsZSB0eXBlIHlldCAqLw0KPj4+ICAgICAgICAgIHJldHVy
biBmYWxzZTsNCj4+PiAgICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX1BUOg0KPj4+IC0gICAg
ICAgIHJldHVybiB4ODZfaW9tbXUtPnB0X3N1cHBvcnRlZDsNCj4+PiArICAgICAgICByZXR1cm4g
ISEocy0+ZWNhcCAmIFZURF9FQ0FQX1BUKTsNCj4+PiAgICAgIGRlZmF1bHQ6DQo+Pj4gICAgICAg
ICAgLyogVW5rbm93biB0eXBlICovDQo+Pj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+DQo+
Pj4gVGhhbmtzDQo+Pj4gWmhlbnpob25nDQo=

