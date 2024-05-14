Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3661CC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 08:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6nHC-00065E-9u; Tue, 14 May 2024 04:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6nH5-00064T-6y
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:12:39 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6nGy-0007fs-Qk
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715674353; x=1747210353;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wl4JkUzzqSwQd1BibTsaz1HKEGi5amWMVlpJR7ccZfA=;
 b=LT7PEzmgGI4QoXj/1zoCtCi7XheJojMUKK4RIV0iceupK6cb4C9KiZVG
 xn0WNPNQ/PODnlCPEk1cCiqTx43PRkV4bp0ayMOuX7nqiqjkscm1kSzne
 fwwdxhhP31rCaCP79/EC8/Q2yadxiOBH344wXEd/9XpzExt5PBWCHQdMU
 Jum8OlERi5H68hDsqIoARIWIXvGc6rTttMCHuiwsU4HFSISXXwfRYMgN1
 sr7FGuAP9JghPtzZfQ8wOdEpTIibTYsxl2LA/K9MRIhXYQIbu4cRVp+Xi
 1qGXwAmpfeBlU24V/6a8Rt5tb+r2rsSg9E7jJVfG3kdXA3MYmqStLGV9Y g==;
X-CSE-ConnectionGUID: puz6loSwSduLABl2ZlDEXA==
X-CSE-MsgGUID: pzJF9w58Q5S9M7eq8WjByw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="22789124"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="22789124"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 01:12:22 -0700
X-CSE-ConnectionGUID: criB7jzPRnmqY/rUpmX94g==
X-CSE-MsgGUID: w/6bxzmhRSaKvKvGQLdoFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="31152531"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 May 2024 01:12:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:12:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 01:12:20 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 01:12:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKBqbFEEyzqVzZ02blHTxO/knEiovkDlkZX0j2NiROkVcXtg5tF/QdkWaHDE8XObhPTvJjYYl68qBaNkl6Uhw8/XTlVxPCydlBWgSp8IMcK2zc3KQCbFb2MCQl5gk9RrBCXHTJ2JeAv4H8zBiNaqUg2boz96DNIX7hmjD+tpFzwH760yqSO6g6Yy0oAFMsVGzeHhqNpmzkL8+B0mHx+5e7/po7NjJLUZ0Fpl3vqQMrsyyg+cm6tueg30r/JVAR7hGicwB//HznpuPqWW0wdWWYa487KljER9Z7Io3NrEhWJyrBvZjixBybM3hmlNhGy1Ggo2qVzjVNBMubJe2PaDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl4JkUzzqSwQd1BibTsaz1HKEGi5amWMVlpJR7ccZfA=;
 b=IXyt9yK56lqBnqzBueCKplthHu4w0D3w5hOUXxCH2h2VCUzkYGi2K2Ys6Zdiye5HgssHARtmWfRZU1pa18FvOae0xVaipvguwrTMVa1k6Oz1lbvHXRES8yKT6McUdxZYKj0m7hLTZ3xOKirCCtjsbVUGycOGT9Ecl/kbDIOxYEUOBdn45Dcw1fKvDhVjeu+nuY5tqAHzKThslcOzyButLEf0suP9vFdFwG14G7pPM1noqKX5BTP/bLWNT21pYAYLF+VXdOeHrBXR6m2KczkasyAWDqCH0lULVjG4zIo6vJWvJPq9WJJVzu1xpR2M6spXdDxsxq237/6NnQWHVmTlFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 14 May
 2024 08:12:18 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:12:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH ats_vtd v1 04/24] intel_iommu: set accessed and dirty bits
 during first stage translation
Thread-Topic: [PATCH ats_vtd v1 04/24] intel_iommu: set accessed and dirty
 bits during first stage translation
Thread-Index: AQHanKWQJSjiyXPlDUqP+lIOZbryMLGWbOpA
Date: Tue, 14 May 2024 08:12:17 +0000
Message-ID: <SJ0PR11MB6744CD5D2DA2897274660AA592E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
 <20240502152810.187492-5-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-5-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB6918:EE_
x-ms-office365-filtering-correlation-id: 2afa224b-7706-45aa-87e8-08dc73ed9269
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bmViOGlKV2thUkl5L0NDb2I5V2NnS0l2WkpjUVVvNWgzSnZYZjA1VjF1bTRN?=
 =?utf-8?B?MkI2ZDE1VUpJbzAwelZGdU5ZNXZvUWp1WjlXY2gzSU1XUkVnL2V0NklGNGpB?=
 =?utf-8?B?RWZKVGQ2bWFYNE1uTEYrNEZ1RHROT2hJVnhnczRSbU00OU9VMWYzYkhKb0JR?=
 =?utf-8?B?TjhFQVJ5TjBKYlBCb3FWUlBTRG5GTWNhY3paTnpuV3V4MFlvSDFkSUlNNUJs?=
 =?utf-8?B?QlJpenpIWm83ZlRLYk1RUC90NW5XRi8rTGR6RW5ram0xOXdBWVRNcWR1QVR6?=
 =?utf-8?B?OUMwa3E0VkJ2M1JUc1RxdVF0MmhSQWNkNDNaL1Vxanp3SUxBd0Z0WjQxeE83?=
 =?utf-8?B?Sk5LMkxVQm1aNmFDSDNBdFdJRXNKR2xSMGxzbmNlVUlGRmVkWEM1QW9pYkFE?=
 =?utf-8?B?SFcvQ1FaUnQ1NHpxeXl1bkVDczhYUEtWcUZLdVVtL1ZON0htbURVT2tlajBZ?=
 =?utf-8?B?KzdTTVc0RFJEMFZIeHNIdE4wcWVMMTJwbHFhQmlOODd6MlBpRHBNdjlrM211?=
 =?utf-8?B?WnN1Q3IyelM2WHlOck1iS2tKVllBNUREVlFScEMrVUprVUJFSnJGalJ6UEFH?=
 =?utf-8?B?bUVCd0JucDNXM0I4dHA5R1JCMWZCS3RhOTVHZUYyNUM3djR4anV3UHhEb1dp?=
 =?utf-8?B?M2srMkh3dkdYNGJZOHMvaUZ4QXRjdkxYSGk2Z1crMGRLaUc1MGR1Sy9CUUw1?=
 =?utf-8?B?cHJ5Zm5SUmI3aDVjdC8vNFpXc3RibTRTRytGRnVqY2JvSXdlcjVRdlFSREZM?=
 =?utf-8?B?ck1GZFcrVjRGQ1ZibGI4ZVlBajJQSWJFSFR6KzhsMGpuKzdyVUNHSTRkbWln?=
 =?utf-8?B?UnJueVhDYmsvaWdwTkpCa3lQMFVNQmYwcEI2N1duMmh0dmE3NUp6VjVnOGdo?=
 =?utf-8?B?MGNLZzdDZkpRNlZnaFNiOWlKV0s3MVRGcXo3cm5QMGI0V3Y5MCt2V2dxNFlu?=
 =?utf-8?B?RGl3K09Lb3A5RDZBLzQ3WmRkWDF3cWRBZlg3VjVid0poSVRNcTRYSUphNkJ5?=
 =?utf-8?B?ZGpNVzgwdHQyOGhpWVMrbm9zNEVWWXV3bCtPVkZUVForTlBQSi9wMFAvNUJ2?=
 =?utf-8?B?WWZQQWVvaXJEbGR3Ump3RHRNUURUQmdNbS8rQ3ZQc1JoNyswY3phOFdRQ2VU?=
 =?utf-8?B?L0pwcHZlenROMkJGdGx5ZUlGWHJpeTRDcUZyU0dsNGZUVyt1bnVaak5CY05B?=
 =?utf-8?B?TTZPNnNGTjdER1FWbytyUFlsN1ZGa0xScHFPUVRCZldOSTc0eEdRa2hCZzRQ?=
 =?utf-8?B?TWpKU2VTYTJSOEdzVGFPY0xVOUY1YThVWlo0eGo1NndtTWFzUmJsR2JOTits?=
 =?utf-8?B?N0RvalQ4N3NsV0N5ZmF0UDM3SzFSUEFlRlVGNmg4MnI2dVpGMTNhZWdkS0NK?=
 =?utf-8?B?czdjYmhHL3psWGZnd09WU1FhTDJiR2VFR0FGbUdEY2h2dlBDSG9zaW4xTkxE?=
 =?utf-8?B?Y3U2cTRSSHZ0eGFJQW9NM3Nid3A3anFXRHlSZUdPUjBrSENCN3pHT3VkNGZV?=
 =?utf-8?B?ZUd4eXpNZUVyMWx4V1dJaDJ6QmFRZHJ3ckpXUXZwNSt3R2ZrNEVtUUJyOTJ1?=
 =?utf-8?B?VGdnL3NHcCtjOHlrWjFScXRqdk9tUXc4c1VIQmRQeGtyVlFWODV2L0NZRjFl?=
 =?utf-8?B?T0N1Y21OMlFHTW1hUHJRdHBvZXJKSkkrd1EyOGw4L2p6cFdzaW9OeVNqWUlN?=
 =?utf-8?B?dUIvZURQZDZPUlQ0UVBGSGdvMFhPbExvbnpUYVBGUlQ4eXpTdm9hcUt1dG5L?=
 =?utf-8?B?ZVhPNm9QYURUMFNtRklMblMwQ0p2OW51REUrWDZJUVg2dVRUcE9rU1JWTHMr?=
 =?utf-8?B?NjRLRUp5ZW8zamR1UmwvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUwzL1NRelJEdHhWN0k4T2Z1NHVRaWZJeCt0ZzJ1UDg2V1BKRGpURTFsS013?=
 =?utf-8?B?VXlFdjZnM1ZhN3RnMUdSb1NBZGlpY0diR2RaNUdWdkNhaHBtNTczQTlldGhY?=
 =?utf-8?B?ZW1oZ3dkV1dkdE1xYjZiS2RLcmJBVjBuaFJxaCtkOWN4QjVGN2dScU9LNDZF?=
 =?utf-8?B?bkdjYlVaRVBtUnRFRHltdmhrVEJMK1lYUWE2Z3F0Z25oU2FwVFY5eWEwekVT?=
 =?utf-8?B?ck14NzcyNXA4OFgwTXMzOUlnenFTK3hzdzF4cW1QalRTQkNUNlRTMkQxMzZP?=
 =?utf-8?B?aURNV2hFUWJqR0g0NC9oM3IyK0kwd0xrQzZwOVdXYmE1Y2pCZThua0J0RXFT?=
 =?utf-8?B?bngvLzdLekppblAxTDJnOVJRYlh0MHVFalpVSVRXNzV2WFpMYjdFcjdreUNs?=
 =?utf-8?B?ekhBdHFnZnJBYmUvM0RsZWZ2VkJsZk1MaitURk5JNCtNd0JTTmFKWk9aZ2RQ?=
 =?utf-8?B?Q2U4YW85UnRXdkdMWS81Y1pSa01Od1M0VFlvTGcrd1hianJlT0tQQ0tjZW9a?=
 =?utf-8?B?ckE3QlJzK0piRklwQUJrUFBQOEE4QmNOQ0JYTS9DeFBmMndzaHZKUFJQcDVK?=
 =?utf-8?B?Z2V2NUpqKy9ON21HcVJzaUNaS2FCZ0NXaFNSbGg2S3VLOWRCU0tvRUNqaVZQ?=
 =?utf-8?B?d0R1YkQ3NyszcjhsZW9ySER0RzlUYVdHenk4R0FOV0hYZEV2dmdoajkvNU5u?=
 =?utf-8?B?dVU0TTdOYUZKS2JrOGNHVHZId2dFUWtoUEM5cTNQS3l5S1FsS2JKU2M1Yldm?=
 =?utf-8?B?Zkxaekw4ZTRESk5JYW43cXlOQU5VcWsyWUV2RkRNWmhMSXN1KzhHZXV5eXE1?=
 =?utf-8?B?N05ES0ljNVloZkxGWk4wZ2p3QS9PVXlFQm81K1E3ZU1KLzh4bXlmcnc2MkpZ?=
 =?utf-8?B?S2tsdUZPaURad1ZMc2diMFRzek9VQjVNWXRBWHhqYUx3eFZNQloxNEtydm5Z?=
 =?utf-8?B?cURjUkN5Q0pmazltdjJzRm9sb3pURnBIM2h4RVFWSmVVTFRjYmNYREg2Y1d5?=
 =?utf-8?B?VkRtVDhwazlPRCt0U0dPMXE0TXhzbW5MeWRmOWR0QWlieERZZ016WkRYSFd6?=
 =?utf-8?B?NGFOc1J3QWlwUGhweTBBdDkwWkRxZzQ4bHNEYXEzdG94VHB6UEgzT0J2R2pY?=
 =?utf-8?B?QnA4TkhDT2NpbmhGUEZTemp2UWMwSEJla0lUeWxNM29VaUpPZXFnNGEzZmsw?=
 =?utf-8?B?YWZZeTVHeFA2NlFOcFV5RjE4Tzd2QytYMHpYU3VJUW9Xd1pOY0l2ajM1ckUx?=
 =?utf-8?B?d1NwaGUvVWt1Y3U2d0ljTk9qL1BJZGh4ZUppWUhhTFlleG5DREloNWlaL25N?=
 =?utf-8?B?WEhNUnRpZXRHSnlGaWdzQUwvanBuUmRLVzVxeGYrWXFsQUJqSE8xbkdobFJy?=
 =?utf-8?B?MHlnWmdxdkdPYjVveTlJNHcrV1FrUHZEZzM5cnBWc2Myb2xYaEpyaDh4dzNS?=
 =?utf-8?B?RVlCU1VVVStTUnJvYVl3b3hLVzVTNUtqbTBVUm9jTGMxUkd4VE1JS09RN0dQ?=
 =?utf-8?B?NVVaOG9hWkRiaUJwMXZrQlRobmNTc3oxOHpTd1pNcjh5R3d4bHBvOXlLekdi?=
 =?utf-8?B?elBjL1BZK2kzWWFib1hoQURsVjAxV2F2ckRtZ25TY3NRTXMyS3hOeE1FY2wx?=
 =?utf-8?B?K1BRaER1aXhsVzhxRGJWRzVuWkVuYUtKcE5QdVV4eG1qYnpTK1NOVFc3Zllw?=
 =?utf-8?B?M2U2RlhLYzZNUUdLbDlLaXVXQm9XZVQzelE1a3ZxQXBadjU4OVV3Vk1hRGhE?=
 =?utf-8?B?bnRCYW5VQ0dUMjNjNlZjY3NmSXFUYi9Pdkh4RjZEZTdGVFhuWVhZRWh2amVC?=
 =?utf-8?B?aFovYUxzSDVjKzFaZzJTOGJEVlcyTTB0K1dTbVh2WEVVeHVNQkp4UkZwUHZt?=
 =?utf-8?B?RlhCMENHRWVKaWhOZU44eFBJTUttbjFueEpzVGFyY1h6VkhDYVQzNnNQMTBr?=
 =?utf-8?B?aUU1YzBya200emt6bzA2ZWYxSk1iam1uU0IyVGc4bFhWbVZGZVdoT25IZ29o?=
 =?utf-8?B?a2FWbWtWcjdkakJldWc2NFhHQlhUSEFCYUhTc3V6Nzlhd1VhOHVqRVRwbDNH?=
 =?utf-8?B?cnROaDdVeG1lZ3BxZXJMY2VIUmZYbTE1TFI0Z01wcjJBOHJ0WTNENHdycEJJ?=
 =?utf-8?Q?vkgqJITzUaaLfOXC9iJFvJ7GT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afa224b-7706-45aa-87e8-08dc73ed9269
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:12:18.0141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GD3hkGHKk+9KB4UVu4MjLXvCzAPIRFGPCIdHd6cozEntv0BDIoT63fiQi34pcAZ3pPcxXia72UXkrOjMrap7dUVclyYbCDx2UBPPbfaSag0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogW1BBVENI
IGF0c192dGQgdjEgMDQvMjRdIGludGVsX2lvbW11OiBzZXQgYWNjZXNzZWQgYW5kIGRpcnR5IGJp
dHMNCj5kdXJpbmcgZmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24NCj4NCj5TaWduZWQtb2ZmLWJ5OiBD
bMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4N
Cj4tLS0NCj4gaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMjYgKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDMgKysr
DQo+IDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYgLS1naXQgYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj5pbmRleCAyNDBl
Y2I4ZjcyLi5jYWQ3MGUwZDA1IDEwMDY0NA0KPi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
PisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPkBAIC0xOTEzLDYgKzE5MTMsNyBAQCBzdGF0
aWMgY29uc3QgYm9vbCB2dGRfcXVhbGlmaWVkX2ZhdWx0c1tdID0gew0KPiAgICAgW1ZURF9GUl9Q
QVNJRF9UQUJMRV9FTlRSWV9JTlZdID0gdHJ1ZSwNCj4gICAgIFtWVERfRlJfU01fSU5URVJSVVBU
X0FERFJdID0gdHJ1ZSwNCj4gICAgIFtWVERfRlJfRlNfTk9OX0NBTk9OSUNBTF0gPSB0cnVlLA0K
PisgICAgW1ZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRF0gPSB0cnVlLA0KPiAgICAgW1ZURF9G
Ul9NQVhdID0gZmFsc2UsDQo+IH07DQo+DQo+QEAgLTIwMzksNiArMjA0MCwyMCBAQCBzdGF0aWMg
Ym9vbA0KPnZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nhbm9uaWNhbChJbnRlbElPTU1VU3RhdGUgKnMsDQo+
ICAgICAgICAgICAgICk7DQo+IH0NCj4NCj4rc3RhdGljIE1lbVR4UmVzdWx0IHZ0ZF9zZXRfZmxh
Z19pbl9wdGUoZG1hX2FkZHJfdCBiYXNlX2FkZHIsIHVpbnQzMl90DQo+aW5kZXgsDQo+KyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHB0ZSwgdWludDY0X3Qg
ZmxhZykNCj4rew0KPisgICAgaWYgKHB0ZSAmIGZsYWcpIHsNCj4rICAgICAgICByZXR1cm4gTUVN
VFhfT0s7DQo+KyAgICB9DQo+KyAgICBwdGUgfD0gZmxhZzsNCj4rICAgIHB0ZSA9IGNwdV90b19s
ZTY0KHB0ZSk7DQo+KyAgICByZXR1cm4gZG1hX21lbW9yeV93cml0ZSgmYWRkcmVzc19zcGFjZV9t
ZW1vcnksDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICBiYXNlX2FkZHIgKyBpbmRleCAq
IHNpemVvZihwdGUpLA0KPisgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnB0ZSwgc2l6ZW9m
KHB0ZSksDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lG
SUVEKTsNCj4rfQ0KPisNCj4gLyoNCj4gICogR2l2ZW4gdGhlIEBpb3ZhLCBnZXQgcmVsZXZhbnQg
QGZscHRlcC4gQGZscHRlX2xldmVsIHdpbGwgYmUgdGhlIGxhc3QgbGV2ZWwNCj4gICogb2YgdGhl
IHRyYW5zbGF0aW9uLCBjYW4gYmUgdXNlZCBmb3IgZGVjaWRpbmcgdGhlIHNpemUgb2YgbGFyZ2Ug
cGFnZS4NCj5AQCAtMjA4MCwxMSArMjA5NSwyMiBAQCBzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2Zs
cHRlKEludGVsSU9NTVVTdGF0ZQ0KPipzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPg0KPiAgICAg
ICAgICpyZWFkcyA9IHRydWU7DQo+ICAgICAgICAgKndyaXRlcyA9ICgqd3JpdGVzKSAmJiAoZmxw
dGUgJiBWVERfRkxfUldfTUFTSyk7DQo+Kw0KPisgICAgICAgIGlmICh2dGRfc2V0X2ZsYWdfaW5f
cHRlKGFkZHIsIG9mZnNldCwgZmxwdGUsIFZURF9GTF9QVEVfQSkNCj4rICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICE9IE1FTVRY
X09LKSB7DQo+KyAgICAgICAgICAgIHJldHVybiAtVlREX0ZSX0ZTX0JJVF9VUERBVEVfRkFJTEVE
Ow0KPisgICAgICAgIH0NCj4rDQo+ICAgICAgICAgaWYgKGlzX3dyaXRlICYmICEoZmxwdGUgJiBW
VERfRkxfUldfTUFTSykpIHsNCj4gICAgICAgICAgICAgcmV0dXJuIC1WVERfRlJfV1JJVEU7DQo+
ICAgICAgICAgfQ0KDQpNYXkgYmUgYmV0dGVyIHRvIHNldCBhY2Nlc3MgYml0IGhlcmU/DQpTcGVj
dWxhdGl2ZWx5IHNldHRpbmcgYWNjZXNzIGJpdCBpcyBhbGxvd2VkIGJ1dCBub3QgbmVjZXNzYXJ5
Lg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+ICAgICAgICAgaWYgKHZ0ZF9pc19sYXN0X2Zs
cHRlKGZscHRlLCBsZXZlbCkpIHsNCj4rICAgICAgICAgICAgaWYgKGlzX3dyaXRlICYmDQo+KyAg
ICAgICAgICAgICAgICAodnRkX3NldF9mbGFnX2luX3B0ZShhZGRyLCBvZmZzZXQsIGZscHRlLCBW
VERfRkxfUFRFX0QpICE9DQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhfT0spKSB7DQo+KyAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1WVERfRlJfRlNfQklUX1VQREFURV9GQUlMRUQ7DQo+KyAgICAgICAg
ICAgIH0NCj4gICAgICAgICAgICAgKmZscHRlcCA9IGZscHRlOw0KPiAgICAgICAgICAgICAqZmxw
dGVfbGV2ZWwgPSBsZXZlbDsNCj4gICAgICAgICAgICAgcmV0dXJuIDA7DQo+ZGlmZiAtLWdpdCBh
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+aW5kZXggZTk0NDgyOTFhNC4uMTQ4NzlkM2E1OCAxMDA2NDQNCj4tLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4rKysgYi9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj5AQCAtMzI4LDYgKzMyOCw3IEBAIHR5cGVkZWYgZW51bSBWVERGYXVsdFJl
YXNvbiB7DQo+DQo+ICAgICAvKiBPdXRwdXQgYWRkcmVzcyBpbiB0aGUgaW50ZXJydXB0IGFkZHJl
c3MgcmFuZ2UgZm9yIHNjYWxhYmxlIG1vZGUgKi8NCj4gICAgIFZURF9GUl9TTV9JTlRFUlJVUFRf
QUREUiA9IDB4ODcsDQo+KyAgICBWVERfRlJfRlNfQklUX1VQREFURV9GQUlMRUQgPSAweDkxLCAv
KiBTRlMuMTAgKi8NCj4gICAgIFZURF9GUl9NQVgsICAgICAgICAgICAgICAgICAvKiBHdWFyZCAq
Lw0KPiB9IFZUREZhdWx0UmVhc29uOw0KPg0KPkBAIC02NDksNiArNjUwLDggQEAgdHlwZWRlZiBz
dHJ1Y3QgVlREUElPVExCSW52SW5mbyB7DQo+IC8qIEZpcnN0IExldmVsIFBhZ2luZyBTdHJ1Y3R1
cmUgKi8NCj4gI2RlZmluZSBWVERfRkxfUFRfTEVWRUwgICAgICAgICAgICAgMQ0KPiAjZGVmaW5l
IFZURF9GTF9QVF9FTlRSWV9OUiAgICAgICAgICA1MTINCj4rI2RlZmluZSBWVERfRkxfUFRFX0Eg
ICAgICAgICAgICAgICAgMHgyMA0KPisjZGVmaW5lIFZURF9GTF9QVEVfRCAgICAgICAgICAgICAg
ICAweDQwDQo+DQo+IC8qIE1hc2tzIGZvciBGaXJzdCBMZXZlbCBQYWdpbmcgRW50cnkgKi8NCj4g
I2RlZmluZSBWVERfRkxfUldfTUFTSyAgICAgICAgICAgICAgKDFVTEwgPDwgMSkNCj4tLQ0KPjIu
NDQuMA0K

