Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A54C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 06:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uILho-0002pd-9y; Fri, 23 May 2025 02:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uILhm-0002oc-2p
 for qemu-devel@nongnu.org; Fri, 23 May 2025 02:16:30 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uILhg-0005kz-8E
 for qemu-devel@nongnu.org; Fri, 23 May 2025 02:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747980984; x=1779516984;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=psac88bqcJYHbeuQMe4QGu/4KUUf2im0e9MLFbH5ukw=;
 b=FIcWyoVoha5xIZEnrlK2hR+qm8jf5gch9+3f8SsLdX3A+se8VqxBRq0W
 ECJHwSw7wm5iarS9azttc/lP4gT8XR3Nz1+S0Zy3mM2dGtvsNPkFdf1aI
 A4v9F0+k5YaxBerZjjjKRTcMs6uD8isLM/ZjCVCfk0a1cJPzs6nbTdo+G
 TBixDrY3jTTyfCWZ6J60KXhWgMzICwcXJFRsZE64PeCyiPJiifwhehokF
 94KdprsIoLz444y8XhHbuULp/ouHugfBG3Hd14AURvDKkV7AOmbcgG6fp
 SpDlLa7WFIPQrqYRorXfQSdUzsUfieEy+VnizzjflWUGiiupSLQ0JUIfA g==;
X-CSE-ConnectionGUID: fUyItsqRS7+5AlrYsXQvYg==
X-CSE-MsgGUID: TWg3nuBZTLeQGQyywUa1Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50191678"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="50191678"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 23:16:15 -0700
X-CSE-ConnectionGUID: f/GRjtMKRH6vkCN9sJDvkg==
X-CSE-MsgGUID: 3XT4Fv+NQF2ssShb1XlZ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="178133905"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 23:16:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 23:16:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 23:16:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.64)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 23:16:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD+j27QU+5Pjvj8Knl8Fy/yXskIMudtJuvhKlW8rYfYJnqfuA+EK9FnlaSa6s/pWDShOrnOAYoIw8OdDxReeP+L0ShPouodLxHpYmyqD/n/OneHSQBdlKDq/JqAkpl95XmXY2nvTRJHucsVqG1dAwA9PRkhtXIzvSPILiRQES/Hj/f0KSJWpgZJQjoj/XsGgvpq1Aw1mnzqUSII+7NM3kdL1SY4eno9FtkrZMAItk0oRKABZpQr4aRvQYESDRJZO9SmeIbLvQ9zn1ELcGjJgDvhihNhM0jOCJiy+8ngtFMaGjqf+QEKoFOtx70JPapunvrOStVpXIqJgheMJxG0i2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVJTu/RAiiZhza8HWVVCUORDbwJrqc1RbnfK8Mfh4OM=;
 b=ODELXnUl00Sn3nyXbGnnnir3mdF16GFoO8ZA4+zfWskK0aoimDAKbJEppbYybTtMYx3VnjMy64fUIIOK0XYtncZ6AIc61tpOGETciDp8wkMebbC1Hx6IhypODZ3MDp52soYhWBsHJpA54hcJNPRwhn+fTS2Nf/d7jn49V0XPYTsGfJ//ZZAQLw/9cAQYtvWw/vT6szaIijIOOq/CLqCO7VN02wvwpMmIUXW/9giCPmXQZa6siSHVacJ5mGQf85leHTPJuJlVfa+VW60I/SfixSrp37VX7D8JFkvEOmk/8cQVqyaFF8SJQk3pUeDUKrjZ2Ei8ZSUR47taKd8u66npOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6355.namprd11.prod.outlook.com (2603:10b6:510:1fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 06:16:09 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 06:16:09 +0000
Message-ID: <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
Date: Fri, 23 May 2025 14:22:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
To: Nicolin Chen <nicolinc@nvidia.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 905064e7-8289-4820-265a-08dd99c14f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3JUbE1ad1N3TkQvZjg1R3ZRZ2J1bnlXZ3VyNUllQXVFOEhmOUtBSUtqQ1pX?=
 =?utf-8?B?N2RwUEUrN3ozQnRXNXJwalRZOGcyUS9qenRpQkxiZ2M2SUVkeXdyOG5GOEp3?=
 =?utf-8?B?TVh4QzRZVXIyUHgyUkNjdU4zeWFHVWw5WmRuUFZrNnBsTUt1eDRJRmFYempJ?=
 =?utf-8?B?TFQ1TkJIM2g3ZWYwN2N5Uy8wUDhBSHlDSDhBQk9EUkw5QThkdGU1UWRCNU1I?=
 =?utf-8?B?aHJXTGFnUzdNT0QrYzUxeUpVc2RPRnlIU2o2emdWeEl2bnFPRTV2dkdYQmlj?=
 =?utf-8?B?WUJVQTd2enB6cVYwc29TSVRlM2hxUnMvQlZuUHhZKytwYjd3Zkd0eVpWVVhv?=
 =?utf-8?B?KzZqWlZuQnU5T3IrcDVRbVd2dElreXhvUzZqYzF2cEN4bjgvY2ZqOUxiRmpG?=
 =?utf-8?B?V1dWQ2hUdkg4TTdTUW1HVzIzTFpGWTkrQUtHeTl5c3FHV2Q1RStMVUdzS3Za?=
 =?utf-8?B?U1JCNVprbE1vcXkyUnpHUmNjN3Z2b0VwcjFzZTNNNVRseGZoOUtJVjQvRlph?=
 =?utf-8?B?V0FUNlh1U2tkS3plQ0xJYnJyU3BiMmMxb3dPWE4yMkMrZTd2cjY3T0Y4ZTJG?=
 =?utf-8?B?WW9nNEhTb0hFcjBZTmxpbUVqbGppalBJU0hJVnBQNFZQS2piK2VsZ2k4V2Zu?=
 =?utf-8?B?d2xHdm54QXNXNHlyV2JUdlZFZ1F1Ymt3UW56dm5nTGRIZkx0bW1aNU4rNjFr?=
 =?utf-8?B?Z0tqTFl0MCtnejFHeFhoQUp1NnhIL09ra3Y0U05IWWRhblhVb3ZGcG1LR3Jl?=
 =?utf-8?B?SVRqanYvOEZZZE1MRFk5WEQ5M0hEQWdnYUlRUU82T1lEeG5kV1o2NTFjM20z?=
 =?utf-8?B?OHdXVDdqWkp3SVNMQVA3eU1LZU1KWmo4NFdQbEwxRU1TVS9BNWF3V2xRS0VQ?=
 =?utf-8?B?WEh3TmlmOXUxSjRUZ05OemRuNG55T0phUzlEbUZsTnBCckNsUW9RRlhLc3Ay?=
 =?utf-8?B?bDNnR2pkSTBvbFR0NStCNjFYSldEUDAzQ3BmSUJVRXQ4RHJMcXpmRTAxWXlW?=
 =?utf-8?B?L0hSMVNGUWtBa28vdmVwd2RqWlZqOFdkdWxPd1N5WjNSaHJvWFg0WS90YVkx?=
 =?utf-8?B?ekJMcGlOT3IzZEdiZ25VbEhRY3h2SDVTRGVzcncwMmNnemU3RFBkTVNnTjdx?=
 =?utf-8?B?L05iMjVTRUtVQ2ErU2NDZzU0aUdtTHJPajFwSXdMUkI5TCswWCtiNFNUVWhx?=
 =?utf-8?B?L0dHQW1kR0FUeCt2bEtRc0tZRVo2MDBmbjRPL01IVG93ZXBoUFBRaTVKby9V?=
 =?utf-8?B?VURVOCs1UkJ4aTcwMklFeklFWmNzdC9aWi9sSTdSUXVtSzlVbnNiTlBkTWNV?=
 =?utf-8?B?bGFxRC9GOERBZnp1NHZJSjN3VnV0bFBaM3Fzc2xGYjNIYmo4VVhnZEpHTGRK?=
 =?utf-8?B?a0crbFUzNkNXOWdqOWUySmdmOGlmWWxKSDFUUlRHYVN4ckFZUGxFNUZuWW1R?=
 =?utf-8?B?ZFJISHAzZElveGgvVVpqQ1RPT1VrdVhiWXZHMVBIUFpnM2VkUlFOTTRtbU1S?=
 =?utf-8?B?UEd1WGp2cWpjZllLRjdwdlhPUzZCOFN6N0lKWVAycys0eDBMTDErR3FLSEFi?=
 =?utf-8?B?NkN4RjVtTW5mWHZvMVhoZmhveU5LaFhadzI4V3djVHpGQzdVVmFGTG5iT1Y1?=
 =?utf-8?B?dWw1am1sMmJsTVhkWVc3Y0VGenFqZ1ltSlpCRmxNZ0plR2tlcm9ycGVLaDhL?=
 =?utf-8?B?bHJtZVYvRGx0RjFVQnRrNG81N0ZNUGR0NW9HdXFmRFpjMjZybDIvcWlSZlc2?=
 =?utf-8?B?RmtJWjYrbFFvZ0lwWTJVZzFHTVZlZTFxUXNFUmNtUkRSTUdnSTliUDZFc1Jp?=
 =?utf-8?Q?Zo0BSilnU9L1B0FQAohZDc0j9in7lFo3UWrKs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5URVV1NXZ0MWJCSWRnejVTb1R1V1lRVVF6dDZNU1UwZ2NacUpYN2pBRU9D?=
 =?utf-8?B?MGJrUU82aWdDa21vMnhpU2dpZ2FpK3RvUU4rMVVaWjNVOWRpaXQ5QkpuSndt?=
 =?utf-8?B?KzkvUzFkcXpoUFNjWGdDSkFXMHNBeUZGdHBzYllzaXNqS1J2TzVWVUY4RHlC?=
 =?utf-8?B?OWhsaldNajBjUWF3MVdYbkZXU1RMcDV3MUc4OU4xaU5raElFVVFEbGZvckRD?=
 =?utf-8?B?K3h2OVZTTEVsbVpmUWhBV3RYa1BQV3lSajF1eEZWMFkwYUFvd0NaS09ROUM2?=
 =?utf-8?B?YnNtMjh3Mzh4b01Cd1pyNitCSlZwaG1Pc0NOUDlTdkpXTHliZURzeHE3RnV4?=
 =?utf-8?B?aVZ3QSsrS0RKOE9pNXV4ZnVCQjdGVStWZjNsQXRaTmhXVHVGVkNQaFVpZTFZ?=
 =?utf-8?B?S2trQkYrRkVpVEp4OXFiVlRNdGFLSUh1eklxa0V0WXBpUXhrOXRSUlpYL2I3?=
 =?utf-8?B?bHRlSmliVW5DWkRoZDJnSXhFRmNxVHNKeGRFQmZzVVNtTGNLbElRRTNQMSs2?=
 =?utf-8?B?bzJlRWRMZ0tvQlRzMDRYNjUwTjY3eW54SWlySFBFT0pWQVVZOCtnK2J5TTVi?=
 =?utf-8?B?eU9Ba3cwMFJsWnN2ZnFyQ3VVelFEdTRvOWljQ0puSks3dmVnSWJGd3hZTkc4?=
 =?utf-8?B?UldCcVFkaklXMktja3dib054dUlyTWJla0RXNzFWalN4N0VMb29wazRSR0Zm?=
 =?utf-8?B?dG1wdi9ycWNrVzRYSXV1elRMZkxxS0hqNDR0Z3YwVDVYYXUvUithZG83MDdz?=
 =?utf-8?B?OU5XWms4VlJMYVJlTkJDYk15ckx1b3RuWGV3MW5kNmNkaGdWS2xIZ0xaRHlj?=
 =?utf-8?B?TmhRYU0zTW4ydXZtVGpIcmhpZkdZTFp4dFVWSXAyK21sdE5MQ1IyRjJ5VzlD?=
 =?utf-8?B?cFovdmQzSGM1ckN1bzM3WkhYelQ3MnUxQUxNdEtIZW5ELzcrdmZDc1QrSEVt?=
 =?utf-8?B?S0F5SUlOcHA4ZlJoV1Q3dlZJb0JreUd0Q3FyM0dYUm1nZW9tVEIxZTNUMUpq?=
 =?utf-8?B?SG1xdDhCUHkvQ3F4aFloUk5JM3MyMUNRaFRWaVlDMlB0MkpUWFFMci9sME1z?=
 =?utf-8?B?bWpoNzFrOVczenloT2NseFF6YjE2d0cwY3I5RXM1aExFMVc0VG9VQ0RocEgr?=
 =?utf-8?B?b0czZHRxR1N6SjJiUVhvcXlHUEhYczVRZUY1TFNNUlZSRkNWQjNKYng1NmM5?=
 =?utf-8?B?dmt5cUNjSllxeXBNaGd4WEkxZFJvQ1VhUWtqS0FaMTIvZ3ZyMDJralQ4VGN3?=
 =?utf-8?B?QzJsK29sQWhMOVJrclVoM3Mvb1BUWGJjSWNZLzNIUk1PQmsyVkl3RS9EZmhX?=
 =?utf-8?B?dnN6blo3bTJsTUQ4UmZsUlVyVmZnUXpmOWZnMEswR1RjbzlrK3V1UXRWb3NJ?=
 =?utf-8?B?SWNSYjYzT0p4ejF0RUVsdHd6ZlN6ZGRueXJQcEV6K0p0QUVVOWVyYmpnbjVj?=
 =?utf-8?B?SzdnYkl4SCszYVhpUW00WWRqVGszMmErVUFPNjIzWlllSWEzWkxzUzcyR3Nq?=
 =?utf-8?B?ajAydnQ0Q2VwUi9ZcGR0ZUY0bmRPaEc0RG1RSWdnbzlYZnkzRkdkNy9Fd21R?=
 =?utf-8?B?Tko3Mll3R3RqZ1BDbDV5RTViK3lWa081NlRwaVo0dE80S3pJaEZYQUFnQ3kx?=
 =?utf-8?B?RUdqZGVnenhZbDNQc00zUkM2MTgyNWlxKy96YmlpWGU0alpYK1NxOUU1Vjh5?=
 =?utf-8?B?K0ZyN25qc0F2TDJ0Ri9paHFCczlybUh2UHZ0TWpnbDlxMVJ6NDl1M2JlSGcr?=
 =?utf-8?B?RmVDTTdML3FoSGNrWTcyQlJ5RVJ5V3VqbkV5ZFFscWVRWGpNZlRjRXJvR0JU?=
 =?utf-8?B?dE5WT1BsbzltanFNMC9idEpQQWlpTGxDazg4QnMwY0tsazZvbGNvVTFKWVVF?=
 =?utf-8?B?R290VlJBa0J0VldWRCtodnBYeUxLbHV5eUFSZE5HQ3J0VmJicG9BcWo5LzVz?=
 =?utf-8?B?K1pqbnhEcXZaUXZ2dUxDV2RiRnUvSVRRUFJJeHRXUS9zMXZhQ2t0NmFxVk9h?=
 =?utf-8?B?ZEFCUk44Y1crN0FFdmE2dXBDNmF4aGhzOUpMd0tiUTFOc3F5Y0NjYmQ1OGVn?=
 =?utf-8?B?S2k0SnhrcC9IYnliYXpMYTM1cFljNjRKZWk1am1UbitxT3ZkUGZTTTdESG9R?=
 =?utf-8?Q?rc1zIGGTHWKUh7lFYDU2IUwYO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 905064e7-8289-4820-265a-08dd99c14f45
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 06:16:09.5198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y34Cmi2jjrBITrmUHjbQEE39a0EYuOdNlP5NQb4j9TY4o5EVbwBHSpI8ZLdoqFbogOkWIr3uVf9L3DDxezFQMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6355
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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

Hey Nic,

On 2025/5/22 06:49, Nicolin Chen wrote:
> On Wed, May 21, 2025 at 07:14:45PM +0800, Zhenzhong Duan wrote:
>> +static const MemoryListener iommufd_s2domain_memory_listener = {
>> +    .name = "iommufd_s2domain",
>> +    .priority = 1000,
>> +    .region_add = iommufd_listener_region_add_s2domain,
>> +    .region_del = iommufd_listener_region_del_s2domain,
>> +};
> 
> Would you mind elaborating When and how vtd does all S2 mappings?
> 
> On ARM, the default vfio_memory_listener could capture the entire
> guest RAM and add to the address space. So what we do is basically
> reusing the vfio_memory_listener:
> https://lore.kernel.org/qemu-devel/20250311141045.66620-13-shameerali.kolothum.thodi@huawei.com/

in concept yes, all the guest ram. but due to an errata, we need
to skip the RO mappings.

> The thing is that when a VFIO device is attached to the container
> upon a nesting configuration, the ->get_address_space op should
> return the system address space as S1 nested HWPT isn't allocated
> yet. Then all the iommu as routines in vfio_listener_region_add()
> would be skipped, ending up with mapping the guest RAM in S2 HWPT
> correctly. Not until the S1 nested HWPT is allocated by the guest
> OS (after guest boots), can the ->get_address_space op return the
> iommu address space.

This seems a bit different between ARM and VT-d emulation. The VT-d
emulation code returns the iommu address space regardless of what
translation mode guest configured. But the MR of the address space
has two overlapped subregions, one is nodmar, another one is iommu.
As the naming shows, the nodmar is aliased to the system MR. And before
the guest enables iommu and set PGTT to a non-PT mode (e.g. S1 or S2),
the effective MR alias is the nodmar, hence the mapping this address
space holds are the GPA mappings in the beginning. If guest set PGTT to S2,
then the iommu MR is enabled, hence the mapping is gIOVA mappings
accordingly. So in VT-d emulation, the address space switch is more the MR
alias switching.

In this series, we mainly want to support S1 translation type for guest.
And it is based on nested translation, which needs a S2 domain that holds
the GPA mappings. Besides S1 translation type, PT is also supported. Both
the two types need a S2 domain which already holds GPA mappings. So we have
this internal listener. Also, we want to skip RO mappings on S2, so that's
another reason for it.  @Zhenzhong, perhaps, it can be described in the
commit message why an internal listener is introduced.

> 
> With this address space shift, S2 mappings can be simply captured
> and done by vfio_memory_listener. Then, such an s2domain listener
> would be largely redundant.

hope above addressed your question.

> So the second question is:
> Does vtd have to own this iommufd_s2domain_memory_listener? IOW,

yes based on the current design. when guest GPTT==PT, attach device
to S2 hwpt, when it goes to S1, then attach it to a S1 hwpt whose
parent is the aforementioned S2 hwpt. This S2 hwpt is always there
for use.

> does vtd_host_dma_iommu() have to return the iommu address space
> all the time?

yes, all the time.

-- 
Regards,
Yi Liu

