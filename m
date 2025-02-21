Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B94BC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMDt-0005Pz-0I; Fri, 21 Feb 2025 01:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tlMDl-0005PM-EP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:09:10 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tlMDi-0000YF-PN
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740118147; x=1771654147;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DuTHZeCmpyrjCQ9Ce6q2dRPPubMarjSz0KYSHmxbiSc=;
 b=jaxTVRai9Xtjgq5i2BDS2CwciyOVJMOhKGPBDufU/YZPsNemJkhA1NR0
 esJbJoGGnjzHhEVdNzNFuztpF34pnqEkVyiM2/53ypAtf4UHbSgCLqPfK
 vc3ui/j8JWhSdvMBRz0Vfgg71nrnD7/RwLh4vp4vMHi6/6DT74g9ZwPrw
 cZVvHHWMAx42LQ+ob9KSxDt8eBoZ7YjAe47DoQEKeEGJRFJlon1sdj/Qo
 Tq4Qn3twOvXho8TT5sjlh968tz+f1d3wIrNs2IfxeYeuzYqeSnxx5UjSb
 d9fQX/s/ZmOs/yhEQSCn3jtHBiiY304WB2RRxED4duNyaiFNIyu0Lm4Eh g==;
X-CSE-ConnectionGUID: J0XozOOORRGQQuGq4VolaA==
X-CSE-MsgGUID: UH3bwdX0RnCMMQIW1nypnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40783381"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; d="scan'208";a="40783381"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 22:09:01 -0800
X-CSE-ConnectionGUID: nbC8gUpARYyo/IO95tyrTA==
X-CSE-MsgGUID: O5Akw1USTzCfd8KlPx5hXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; d="scan'208";a="115272467"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 22:09:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 22:08:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 22:08:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 22:08:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW7U82ZhteIjzwQIeO2MVmY4/SG9QFaOPFc9ALmaIH9dKt7HPY1fikLJeHL58OGI3JboCl73GeGa0TUwYin7o2WY4TWAtYQSANyaMFaioqeJlw/VDtThxt43d/QbkWHM20mGnjFwaoeCAjKqUGaDAedLQmPURt7eSUQ3gkBZfZtiwTyfvKuO3Hh/CM0T85eV7NchulfUg5gik7DCzw5+vxKGJu0i68vWwhicOwN8BeLcB5oXYfpJT28nry/oQojMUUuNJ55IVKDRVErvMsWq6hHiaLIvf3LCCH0dUXSDxJWBUOwPsHYB8NOB5D4yg54VdhgXodJQsNMa6IdPtUVh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuTHZeCmpyrjCQ9Ce6q2dRPPubMarjSz0KYSHmxbiSc=;
 b=hNTOZaEFysP/O5jOOFicr06fx1FS2uf7uex08Bc8B5G92fMn5iRski38hi7M6u2QBwZ3CUKEdI9/dnQiHfo+jEy0nlTE9X66/ud/SiRmeR2d8nwQRXEK3fy1t8X83h9EHas0Cn2cI4IlTRomxvxrFA2Ts0YsIOxZ7nVeqsIEu/1RBqjWfKBwZ+LRtvvP/+Ac4isu3RZXFNphqsyBC/IU9ts7SclVLhlKdmKsi8hMEdj4SlkUhICrJv2YZWCB69FTq04EaGut4J6H8/RN5mcddwEEQPAUfkjxMXBlNgc1PI8OHl5M7sT7t/FOosN/wwypBZOWSygeuF6ccLbNx4fFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4866.namprd11.prod.outlook.com (2603:10b6:303:91::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 06:08:13 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 06:08:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Topic: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Index: AQHbgqfz4Rpn6VXaXUyU2i30ijbHzrNQjw2AgAC3zHA=
Date: Fri, 21 Feb 2025 06:08:13 +0000
Message-ID: <SJ0PR11MB67449DC4ED4383A8FA53357092C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <242f875d-a47c-4732-9f17-1a121e89b053@redhat.com>
In-Reply-To: <242f875d-a47c-4732-9f17-1a121e89b053@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4866:EE_
x-ms-office365-filtering-correlation-id: d171d1d4-4c30-4f8a-e36f-08dd523e2006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M0lRV094QUhBVlpNWXk0QU5MMU55cDh3eGhWTmdKaXZVR1phL3NRRkovZW5J?=
 =?utf-8?B?SlVKb25DRVplUHNBcndoUGp4VzR4OFJ0VUYvd3MwcEc0SjkySEltSFRqTEJw?=
 =?utf-8?B?ZVpCQVREZHp6SXd0MzQyWEtLR0JSMjh0ZXoreHZOQWlUVzBDNVM0Wkh6MmFi?=
 =?utf-8?B?RVljaUFxMUh6VURkbXZ3VG5nTVdHSFJCeE9Mb1FYRHhPYlh2U2JQOFpNS0xx?=
 =?utf-8?B?MVY4ZTZ2eHM0Mm5kN3F4ejZZdjFLMDFiUU5qSWFoV21tK1RVVWdLZFEyM04v?=
 =?utf-8?B?T2J2cUZmYWxnRmtVbUxUWHYrRWh5bFB6WW5HZEFIMUFvMXU0TTRmUmEveGpr?=
 =?utf-8?B?UU1SaCtmZ2JlNi95NE90M1VpbldvdnJocW5XRjhjeVhmTnpGbXJDZVdTL2Mr?=
 =?utf-8?B?N09LcG9HRy9RQ28xb2QrUnJYOHRFNEZrVkxxNGV3Q2p6bEZuZVQ1dFQ2d3Av?=
 =?utf-8?B?TVJEaFAyR0czbUk2M0pFTldETDN1eU9hSE95N1JHLzNTMGZQMjhrNFgvalZB?=
 =?utf-8?B?UENoMTdNNHB4cnQ1VzgyVDhkZ0cvWlZtMmkzbEZsOVphMDhXSUI2dXhmRitT?=
 =?utf-8?B?YVg0Y1A4ZEVOREtjZDNZYzI0Z0s3dm9XeSt4dGZ6UmpmbHh4RW9yQU04ZmRt?=
 =?utf-8?B?UStVYXZBUG5uS3IveTllaGc3ZGQvQmxxSUE4UHFiZlRwanZHWDZXY3ZhT0ZL?=
 =?utf-8?B?VU9nZ0RiQ3JrOW52cWQ3YjVaaXJpcU4zY240TjFpUjNUQlU2YjB6Z1NCc3FM?=
 =?utf-8?B?Q040cEQ4TFptcHYvU1gwdTlpZXJYQW5vZUthLzNONUVJNzFER0Vjc1hRWEp5?=
 =?utf-8?B?WGVEUzR6TVlGRWJyNUcwNDJZUnEvKy8xVkZFRHZTdzRlbGg0SDE4KzdBK2Ix?=
 =?utf-8?B?YThYTE1yL01WV245WENHaVVPeVVOKzREQmxVSkxCaWdTajdFb0xGazRaSDND?=
 =?utf-8?B?cUN2NFZvcVJvQUlWRzNQeGlrZGJtbHBEdjhTa0g2OS8zYXdvTXN3SnJnWjVh?=
 =?utf-8?B?RXZldGsvcXRFNTNaTndkNHBjSTJIOWRPME5NMlVPUzR0YlZ6bVhqSHhFcy95?=
 =?utf-8?B?RWUzdUdxSGRtNFdVaVg5N2VVMFJWNndHUDJLTlN3cnZtdCtLZUtnQ1VUQXlL?=
 =?utf-8?B?M3dqc0g4dnpmdVg0dlFqbnBpbkpxaHMwUURNQkpYMWhKYUhyUkVOTElyM0FJ?=
 =?utf-8?B?Mi9xTVdBMVB4YmhISVdITVhLQnpGYUYrQTNJOUEyRFFyN2N2VE80ZFpib21i?=
 =?utf-8?B?YUt0VCtEMTV2dEVaakJWOGJMYmZVakl2NHN5QTFLVm5JRWNIOVdLU1pnTjVJ?=
 =?utf-8?B?QmdUb3VScVpSYkJLK0RyRXBCREx2WnNlaFpsVnNYM21kQWdTQkVGcTV5Unkz?=
 =?utf-8?B?eW1SckNRdnYwV09KMDNqVjRpem0vV21kOWNjdlFqQUVYYW9nSmN2dkVjL0d6?=
 =?utf-8?B?b0w2M2RDS0lUR3FtR2xHczFuNGpWVFpnTmRIMG43aHlXM2R5cjlTTmJJNzl3?=
 =?utf-8?B?YzlnTkplTGxIRmt2MVl6bWJFNDdYWjZhZElLVC9NWkFpeWJSQ2RrTU5sK1A1?=
 =?utf-8?B?WlBmWkdSNlBtVFgxeTdmZkt6emdtYngzUGhFR29CUHMxVk9SZFFET1hXSTZU?=
 =?utf-8?B?bEJBRjl2Yld6dTRXbEppTDF5ZHJtVnZZbkFES0o3ZEF2TW15aHhDUytrMXlw?=
 =?utf-8?B?KzRkQ3lINU5mcUdOT0hDekdLRElJSHRIYUFZVzgrWHVhaHF1dENFelEyVGxC?=
 =?utf-8?B?T1hiaVdKdnpRY1NqMXNXYVQ1ZnlCZjhIanJBV1NheTlkSWVqUlpHU01xeWhL?=
 =?utf-8?B?M2p5TUxieG1QWFIzMnY2YmtwanJVWlVET2lkUmFhdk9yZ1d4aHE4MTJGUldL?=
 =?utf-8?B?MkVYY0tXYTFKOFVheENwVzdYVFljU1ZvVmpqbkVDU3NxcDdyV2ZhdC8wTEx0?=
 =?utf-8?Q?jkSnY2MEUnk5BrvwfJCkN0Hx2WcsBygv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkNFd0ExSlo1alRJOC80bjBOa3ZUanFYLyswNXBmMUFQSko3NmJ5eEtFWmNL?=
 =?utf-8?B?Rms3dWpSNmc5Yjg1SjNpZFg1bmpSNzMrVHhMbkRSY2lIcEEzLzJ2UVc1RzF4?=
 =?utf-8?B?TXp5TGlYcG9WUngrakpxRXJsWWxTTVpDajYxVGFHam8rUVJnTkVQNlpaa04w?=
 =?utf-8?B?OFZ1NisrRXlzMmg3VUFZNCtMSWZ1OVdPdUlNUnhsYk9EM2dpR0VPUCs5L3ZG?=
 =?utf-8?B?WW9wSzJiMFhhTUtuais2M3ozaFdrbmdZazhFOVZDVHBYbEk1SlpmUGxkanBU?=
 =?utf-8?B?cDlOdnpNNHJhWHErM1B6Y25ScU1Cdy84azNKUE83M3VnbytNTjlHMnJHbUtq?=
 =?utf-8?B?WHo1TVp3RzNBRnVncC82elBsUXF2Tk1WNmhXL1RWL0VDcC8rR0p2ZkFSeTdZ?=
 =?utf-8?B?NnQxY0lKdVVjMU1sVytpZUFGM3NXU2YrSUxmaTIzNEowWUJ5TVZlRHQ1Q3N5?=
 =?utf-8?B?eFBrTjY4NEpnVzllczhxRGwzRXhrNzFOVno2RVdSemxrRk5VNjZNTXlITmVH?=
 =?utf-8?B?Q1NETktkWWpPOGRyU0FXMEMxRUw4WHdXSVRmcytsQWVrYTdIV2p3SmNySGRN?=
 =?utf-8?B?STdlaHBwaGgra29hUzJWRkRPaGJsc2E3S1dkRTlqOUFLYXBZTlRDTnRHSHJz?=
 =?utf-8?B?VG8xZjI2MkYxZVBlK01EWnljY3p2WmEvT1l3TmhmNURvTHRlaFo0U2tlcnpO?=
 =?utf-8?B?Q2Z5VmlyaXRxNkNQM0dwenBPdnpUcUlMOGw1M1JYaGJINVl0b0xqWlVDdG9K?=
 =?utf-8?B?Z1AwSUdKQXVmeFdYOXJWSmpreDZPdE1vN3BJbGMzY0UweG5YZ1lNNm5xbDJD?=
 =?utf-8?B?dk5MWXppdTZkNzVuaWZWZHhnVE9jbVhrMUMxZlpIeGNwN0dxTXUrbFBsWHYz?=
 =?utf-8?B?NVFjMHpldmk0OEpPTHQyZHh5NnF1ZmthTmsrVHE5cG1iWU10WGpOT3RBMEhr?=
 =?utf-8?B?RUczZlFvTGNYQVFhVTZZYk1MTHBwUkZ4ZjczTVpqVmNES2o2ZnJTMG4vUkNY?=
 =?utf-8?B?a1htc0gyMmVSNktZYUpxTWZUajhWalFLaXhBOW1EcmRPbkRJYmdxZUthZWZY?=
 =?utf-8?B?TzhqV0RFZktOWGNhaWFjZUFqZmhkdEpDMFRvQ29kaTg0RkxyZk1zQnEvSTFO?=
 =?utf-8?B?ZFlOcHFLY3I0dk9TNHJBbGRKUkZWWlU4VzhwRnpIdlByMUZQMG9ScVFJVUp3?=
 =?utf-8?B?Qmc5WDdNRjVFdHdsNktkc2NNRkhaUTAyajFIMHQvT0VYc0RPWWlhY3ZaeG8w?=
 =?utf-8?B?YWxWL2dIN1lxZlkwRloyZ1FmcFo1RXlXVEc5ampPN01QbDBwNjFwRTRiZ2x4?=
 =?utf-8?B?d3ZIRW1kWVFRVDRvNHhNUjNBU29nU2JKSFZ2eitWUitkaFhkK0FIZGlRNUlH?=
 =?utf-8?B?T1VDMG4vN0h0Y1VZU2cvN2w5Y1BpeXZLQWRDRFhSb09TU01KYzNDTSsrcGFN?=
 =?utf-8?B?cDRYUzM0bmFRVGVVMStJRVhLMk1xMVFucXV4NmZDQWRsKzQxWlJzNVIwSDEx?=
 =?utf-8?B?aU9LR0RPR0JjV0YyVVNDTHJ4Q1B0bGdRaGJXYjR6aUE3S0RvR01Fc0ZISlpy?=
 =?utf-8?B?VG1PWkJwaDQrTFVFUitUZjNYYXJMcHJKRWRtR281ajcvV0Y1RkZOUGxZZE01?=
 =?utf-8?B?b1c0RjFQK3d3RWllR2Y5OVdGdmU2TllLU3V4ZTZQaHNLK1RuWkU0UURteWpa?=
 =?utf-8?B?NHE3bGxNcG9iVE5RVnhFNCtNZW1OcXBXRVlkVFUvWGlwMkQzTG01V24yR3Vh?=
 =?utf-8?B?WXNkSGN1RDZ5OFl6NWs5Y1UyZ3dDV3pkT3IxU1ArY0lORmZwd09iZkpzY2dR?=
 =?utf-8?B?dGE3ZERpQUVuZEtmdHRVU2lCTXhVQVV3V1Jzc1dIVUJmRy9lQ3pmY2RmdTJB?=
 =?utf-8?B?MzJJT3dyZlRoTkNQY1cvNm5jRjF3eVBCNE9PVWhKNnNtM0dGbjJhNFZHd1Jw?=
 =?utf-8?B?U01DQSt5cHhTV011OXgxTkNTa0tzNHJSVDF0NUhXclhwK1BmSGw3TURlWjdL?=
 =?utf-8?B?bkczKzFjU0RodVQraC9HbXdhelVPSjFlWitLajU3eUJQWHk4d3FCNTFMcXBr?=
 =?utf-8?B?TDVoQ0kxaVZjeXpDZm9zZXpvaDRyZ1k3b2YrS2dlMW5TS0kyc1Z4QUNxZmo3?=
 =?utf-8?Q?qrH1OD3wgkvQ0oJVlpKrtUxAD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d171d1d4-4c30-4f8a-e36f-08dd523e2006
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 06:08:13.4696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+9kIzytF/fXDmbf7I9+Zzp1bgajb0UAmq9krLG1Q60wX+E9xBDqYAhrcj9VyofweJqn6B/FrfLKFHs2IUg/IVbi1qq12HEZOgtYE2Sy6VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4866
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggcmZjdjIgMDAv
MjBdIGludGVsX2lvbW11OiBFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3INCj5wYXNzdGhy
b3VnaCBkZXZpY2UNCj4NCj4NCj5IaSBaaGVuemhvbmcNCj4NCj5PbiAyLzE5LzI1IDk6MjIgQU0s
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gUGVyIEphc29uIFdhbmcncyBz
dWdnZXN0aW9uLCBpb21tdWZkIG5lc3Rpbmcgc2VyaWVzWzFdIGlzIHNwbGl0IGludG8NCj4+ICJF
bmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3IgZW11bGF0ZWQgZGV2aWNlIiBzZXJpZXMgYW5k
DQo+PiAiRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yIHBhc3N0aHJvdWdoIGRldmljZSIg
c2VyaWVzLg0KPj4NCj4+IFRoaXMgc2VyaWVzIGlzIDJuZCBwYXJ0IGZvY3VzaW5nIG9uIHBhc3N0
aHJvdWdoIGRldmljZS4gV2UgZG9uJ3QgZG8NCj4+IHNoYWRvd2luZyBvZiBndWVzdCBwYWdlIHRh
YmxlIGZvciBwYXNzdGhyb3VnaCBkZXZpY2UgYnV0IHBhc3Mgc3RhZ2UtMQ0KPj4gcGFnZSB0YWJs
ZSB0byBob3N0IHNpZGUgdG8gY29uc3RydWN0IGEgbmVzdGVkIGRvbWFpbi4gVGhlcmUgd2FzIHNv
bWUNCj4+IGVmZm9ydCB0byBlbmFibGUgdGhpcyBmZWF0dXJlIGluIG9sZCBkYXlzLCBzZWUgWzJd
IGZvciBkZXRhaWxzLg0KPj4NCj4+IFRoZSBrZXkgZGVzaWduIGlzIHRvIHV0aWxpemUgdGhlIGR1
YWwtc3RhZ2UgSU9NTVUgdHJhbnNsYXRpb24NCj4+IChhbHNvIGtub3duIGFzIElPTU1VIG5lc3Rl
ZCB0cmFuc2xhdGlvbikgY2FwYWJpbGl0eSBpbiBob3N0IElPTU1VLg0KPj4gQXMgdGhlIGJlbG93
IGRpYWdyYW0gc2hvd3MsIGd1ZXN0IEkvTyBwYWdlIHRhYmxlIHBvaW50ZXIgaW4gR1BBDQo+PiAo
Z3Vlc3QgcGh5c2ljYWwgYWRkcmVzcykgaXMgcGFzc2VkIHRvIGhvc3QgYW5kIGJlIHVzZWQgdG8g
cGVyZm9ybQ0KPnMvYmUvaXMNCj4+IHRoZSBzdGFnZS0xIGFkZHJlc3MgdHJhbnNsYXRpb24uIEFs
b25nIHdpdGggaXQsIG1vZGlmaWNhdGlvbnMgdG8NCj4+IHByZXNlbnQgbWFwcGluZ3MgaW4gdGhl
IGd1ZXN0IEkvTyBwYWdlIHRhYmxlIHNob3VsZCBiZSBmb2xsb3dlZA0KPj4gd2l0aCBhbiBJT1RM
QiBpbnZhbGlkYXRpb24uDQo+Pg0KPj4gICAgICAgICAuLS0tLS0tLS0tLS0tLS4gIC4tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0uDQo+PiAgICAgICAgIHwgICB2SU9NTVUgICAgfCAgfCBHdWVz
dCBJL08gcGFnZSB0YWJsZSAgICAgIHwNCj4+ICAgICAgICAgfCAgICAgICAgICAgICB8ICAnLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tJw0KPj4gICAgICAgICAuLS0tLS0tLS0tLS0tLS0tLS8N
Cj4+ICAgICAgICAgfCBQQVNJRCBFbnRyeSB8LS0tIFBBU0lEIGNhY2hlIGZsdXNoIC0tKw0KPj4g
ICAgICAgICAnLS0tLS0tLS0tLS0tLScgICAgICAgICAgICAgICAgICAgICAgICB8DQo+PiAgICAg
ICAgIHwgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgIFYNCj4+ICAgICAgICAg
fCAgICAgICAgICAgICB8ICAgICAgICAgICBJL08gcGFnZSB0YWJsZSBwb2ludGVyIGluIEdQQQ0K
Pj4gICAgICAgICAnLS0tLS0tLS0tLS0tLScNCj4+ICAgICBHdWVzdA0KPj4gICAgIC0tLS0tLXwg
U2hhZG93IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0NCj4+ICAgICAgICAg
ICB2ICAgICAgICB2ICAgICAgICAgICAgICAgICAgICAgICAgICAgdg0KPj4gICAgIEhvc3QNCj4+
ICAgICAgICAgLi0tLS0tLS0tLS0tLS0uICAuLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLg0KPj4g
ICAgICAgICB8ICAgcElPTU1VICAgIHwgIHwgIEZTIGZvciBHSU9WQS0+R1BBICAgICB8DQo+PiAg
ICAgICAgIHwgICAgICAgICAgICAgfCAgJy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLScNCj4+ICAg
ICAgICAgLi0tLS0tLS0tLS0tLS0tLS0vICB8DQo+PiAgICAgICAgIHwgUEFTSUQgRW50cnkgfCAg
ICAgViAoTmVzdGVkIHhsYXRlKQ0KPj4gICAgICAgICAnLS0tLS0tLS0tLS0tLS0tLVwuLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS4NCj4+ICAgICAgICAgfCAgICAgICAgICAgICB8
ICAgfCBTUyBmb3IgR1BBLT5IUEEsIHVubWFuYWdlZCBkb21haW58DQo+PiAgICAgICAgIHwgICAg
ICAgICAgICAgfCAgICctLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tJw0KPj4gICAg
ICAgICAnLS0tLS0tLS0tLS0tLScNCj4+IFdoZXJlOg0KPj4gIC0gRlMgPSBGaXJzdCBzdGFnZSBw
YWdlIHRhYmxlcw0KPj4gIC0gU1MgPSBTZWNvbmQgc3RhZ2UgcGFnZSB0YWJsZXMNCj4+IDxJbnRl
bCBWVC1kIE5lc3RlZCB0cmFuc2xhdGlvbj4NCj4+DQo+PiBUaGVyZSBhcmUgc29tZSBpbnRlcmFj
dGlvbnMgYmV0d2VlbiBWRklPIGFuZCB2SU9NTVUNCj4+ICogdklPTU1VIHJlZ2lzdGVycyBQQ0lJ
T01NVU9wcyBbc2V0fHVuc2V0XV9pb21tdV9kZXZpY2UgdG8gUENJDQo+PiAgIHN1YnN5c3RlbS4g
VkZJTyBjYWxscyB0aGVtIHRvIHJlZ2lzdGVyL3VucmVnaXN0ZXIgSG9zdElPTU1VRGV2aWNlDQo+
PiAgIGluc3RhbmNlIHRvIHZJT01NVSBhdCB2ZmlvIGRldmljZSByZWFsaXplIHN0YWdlLg0KPj4g
KiB2SU9NTVUgY2FsbHMgSG9zdElPTU1VRGV2aWNlSU9NTVVGRCBpbnRlcmZhY2UgW2F0fGRlXXRh
Y2hfaHdwdA0KPj4gICB0byBiaW5kL3VuYmluZCBkZXZpY2UgdG8gSU9NTVVGRCBiYWNrZWQgZG9t
YWlucywgZWl0aGVyIG5lc3RlZA0KPj4gICBkb21haW4gb3Igbm90Lg0KPj4NCj4+IFNlZSBiZWxv
dyBkaWFncmFtOg0KPj4NCj4+ICAgICAgICAgVkZJTyBEZXZpY2UgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBJbnRlbCBJT01NVQ0KPj4gICAgIC4tLS0tLS0tLS0tLS0tLS0tLS4gICAg
ICAgICAgICAgICAgICAgICAgICAgLi0tLS0tLS0tLS0tLS0tLS0tLS0uDQo+PiAgICAgfCAgICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
IHwNCj4+ICAgICB8ICAgICAgIC4tLS0tLS0tLS18UENJSU9NTVVPcHMgICAgICAgICAgICAgIHwu
LS0tLS0tLS0tLS0tLS4gICAgfA0KPj4gICAgIHwgICAgICAgfCBJT01NVUZEIHwoc2V0X2lvbW11
X2RldmljZSkgICAgICAgfHwgSG9zdCBJT01NVSAgfCAgICB8DQo+PiAgICAgfCAgICAgICB8IERl
dmljZSAgfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT58fCBEZXZpY2UgbGlzdCB8ICAgIHwNCj4+
ICAgICB8ICAgICAgIC4tLS0tLS0tLS18KHVuc2V0X2lvbW11X2RldmljZSkgICAgIHwuLS0tLS0t
LS0tLS0tLS4gICAgfA0KPj4gICAgIHwgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICB8ICAgICAgICAgICB8DQo+PiAgICAgfCAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIFYgICAgICAgICAgIHwNCj4+ICAgICB8
ICAgICAgIC4tLS0tLS0tLS18ICBIb3N0SU9NTVVEZXZpY2VJT01NVUZEIHwgIC4tLS0tLS0tLS0t
LS0tLiAgfA0KPj4gICAgIHwgICAgICAgfCBJT01NVUZEIHwgICAgICAgICAgICAoYXR0YWNoX2h3
cHQpfCAgfCBIb3N0IElPTU1VICB8ICB8DQo+PiAgICAgfCAgICAgICB8IGxpbmsgICAgfDwtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS18ICB8ICAgRGV2aWNlICAgIHwgIHwNCj4+ICAgICB8ICAgICAg
IC4tLS0tLS0tLS18ICAgICAgICAgICAgKGRldGFjaF9od3B0KXwgIC4tLS0tLS0tLS0tLS0tLiAg
fA0KPj4gICAgIHwgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICAgICB8ICAgICAgICAgICB8DQo+PiAgICAgfCAgICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgICAgIC4uLiAgICAgICAgIHwNCj4+ICAgICAuLS0tLS0tLS0tLS0t
LS0tLS0uICAgICAgICAgICAgICAgICAgICAgICAgIC4tLS0tLS0tLS0tLS0tLS0tLS0tLg0KPj4N
Cj4+IEJhc2VkIG9uIFlpJ3Mgc3VnZ2VzdGlvbiwgdGhpcyBkZXNpZ24gaXMgb3B0aW1hbCBpbiBz
aGFyaW5nIGlvYXMvaHdwdA0KPj4gd2hlbmV2ZXIgcG9zc2libGUgYW5kIGNyZWF0ZSBuZXcgb25l
IG9uIGRlbWFuZCwgYWxzbyBzdXBwb3J0cyBtdWx0aXBsZQ0KPj4gaW9tbXVmZCBvYmplY3RzIGFu
ZCBFUlJBVEFfNzcyNDE1Lg0KPj4NCj4+IEUuZy4sIFN0YWdlLTIgcGFnZSB0YWJsZSBjb3VsZCBi
ZSBzaGFyZWQgYnkgZGlmZmVyZW50IGRldmljZXMgaWYgdGhlcmUNCj4+IGlzIG5vIGNvbmZsaWN0
IGFuZCBkZXZpY2VzIGxpbmsgdG8gc2FtZSBpb21tdWZkIG9iamVjdCwgaS5lLiBkZXZpY2VzDQo+
PiB1bmRlciBzYW1lIGhvc3QgSU9NTVUgY2FuIHNoYXJlIHNhbWUgc3RhZ2UtMiBwYWdlIHRhYmxl
LiBJZiB0aGVyZSBpcw0KPj4gY29uZmxpY3QsIGkuZS4gdGhlcmUgaXMgb25lIGRldmljZSB1bmRl
ciBub24gY2FjaGUgY29oZXJlbmN5IG1vZGUNCj4+IHdoaWNoIGlzIGRpZmZlcmVudCBmcm9tIG90
aGVycywgaXQgcmVxdWlyZXMgYSBzZXBhcmF0ZSBzdGFnZS0yIHBhZ2UNCj4+IHRhYmxlIGluIG5v
bi1DQyBtb2RlLg0KPj4NCj4+IFNQUiBwbGF0Zm9ybSBoYXMgRVJSQVRBXzc3MjQxNSB3aGljaCBy
ZXF1aXJlcyBubyByZWFkb25seSBtYXBwaW5ncw0KPj4gaW4gc3RhZ2UtMiBwYWdlIHRhYmxlLiBU
aGlzIHNlcmllcyBzdXBwb3J0cyBjcmVhdGluZyBWVERJT0FTQ29udGFpbmVyDQo+PiB3aXRoIG5v
IHJlYWRvbmx5IG1hcHBpbmdzLiBJZiB0aGVyZSBpcyBhIHJhcmUgY2FzZSB0aGF0IHNvbWUgSU9N
TVVzDQo+PiBvbiBhIG11bHRpcGxlIElPTU1VIGhvc3QgaGF2ZSBFUlJBVEFfNzcyNDE1IGFuZCBv
dGhlcnMgbm90LCB0aGlzDQo+PiBkZXNpZ24gY2FuIHN0aWxsIHN1cnZpdmUuDQo+Pg0KPj4gU2Vl
IGJlbG93IGV4YW1wbGUgZGlhZ3JhbSBmb3IgYSBmdWxsIHZpZXc6DQo+Pg0KPj4gICAgICAgSW50
ZWxJT01NVVN0YXRlDQo+PiAgICAgICAgICAgICAgfA0KPj4gICAgICAgICAgICAgIFYNCj4+ICAg
ICAuLS0tLS0tLS0tLS0tLS0tLS0tLiAgICAuLS0tLS0tLS0tLS0tLS0tLS0tLiAgICAuLS0tLS0t
LS0tLS0tLS0tLS0tLS4NCj4+ICAgICB8IFZURElPQVNDb250YWluZXIgfC0tLT58IFZURElPQVND
b250YWluZXIgfC0tLT58IFZURElPQVNDb250YWluZXIgIHwtLQ0KPj4uLi4NCj4+ICAgICB8IChp
b21tdWZkMCxSVyZSTykgfCAgICB8IChpb21tdWZkMSxSVyZSTykgfCAgICB8IChpb21tdWZkMCxS
VyBvbmx5KXwNCj4+ICAgICAuLS0tLS0tLS0tLS0tLS0tLS0tLiAgICAuLS0tLS0tLS0tLS0tLS0t
LS0tLiAgICAuLS0tLS0tLS0tLS0tLS0tLS0tLS4NCj4+ICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPj4gICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIC4tLT4uLi4gICAgICAgICAgICAgICAgICAg
ICAgICB8DQo+PiAgICAgICAgICAgICAgViAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFYNCj4+ICAgICAgIC4tLS0tLS0tLS0tLS0tLS0tLS0tLiAg
ICAuLS0tLS0tLS0tLS0tLS0tLS0tLS4gICAgICAgICAgLi0tLS0tLS0tLS0tLS0tLS4NCj4+ICAg
ICAgIHwgICBWVERTMkh3cHQoQ0MpICAgfC0tLT58IFZURFMySHdwdChub24tQ0MpIHwtLT4uLi4g
ICAgfCBWVERTMkh3cHQoQ0MpIHwtDQo+LT4uLi4NCj4+ICAgICAgIC4tLS0tLS0tLS0tLS0tLS0t
LS0tLiAgICAuLS0tLS0tLS0tLS0tLS0tLS0tLS4gICAgICAgICAgLi0tLS0tLS0tLS0tLS0tLS4N
Cj4+ICAgICAgICAgICB8ICAgICAgICAgICAgfCAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfA0KPj4gICAgICAgICAgIHwgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+PiAgICAgLi0tLS0tLS0tLS0tLiAg
Li0tLS0tLS0tLS0tLiAgLi0tLS0tLS0tLS0tLS4gICAgICAgICAgICAgIC4tLS0tLS0tLS0tLS0u
DQo+PiAgICAgfCBJT01NVUZEICAgfCAgfCBJT01NVUZEICAgfCAgfCBJT01NVUZEICAgIHwgICAg
ICAgICAgICAgIHwgSU9NTVVGRCAgICB8DQo+PiAgICAgfCBEZXZpY2UoQ0MpfCAgfCBEZXZpY2Uo
Q0MpfCAgfCBEZXZpY2UgICAgIHwgICAgICAgICAgICAgIHwgRGV2aWNlKENDKSB8DQo+PiAgICAg
fCAoaW9tbXVmZDApfCAgfCAoaW9tbXVmZDApfCAgfCAobm9uLUNDKSAgIHwgICAgICAgICAgICAg
IHwgKGVycmF0YSkgICB8DQo+PiAgICAgfCAgICAgICAgICAgfCAgfCAgICAgICAgICAgfCAgfCAo
aW9tbXVmZDApIHwgICAgICAgICAgICAgIHwgKGlvbW11ZmQwKSB8DQo+PiAgICAgLi0tLS0tLS0t
LS0tLiAgLi0tLS0tLS0tLS0tLiAgLi0tLS0tLS0tLS0tLS4gICAgICAgICAgICAgIC4tLS0tLS0t
LS0tLS0uDQo+Pg0KPj4gVGhpcyBzZXJpZXMgaXMgYWxzbyBhIHByZXJlcXVpc2l0ZSB3b3JrIGZv
ciB2U1ZBLCBpLmUuIFNoYXJpbmcNCj4+IGd1ZXN0IGFwcGxpY2F0aW9uIGFkZHJlc3Mgc3BhY2Ug
d2l0aCBwYXNzdGhyb3VnaCBkZXZpY2VzLg0KPj4NCj4+IFRvIGVuYWJsZSBzdGFnZS0xIHRyYW5z
bGF0aW9uLCBvbmx5IG5lZWQgdG8gYWRkICJ4LXNjYWxhYmxlLW1vZGU9b24seC1mbHRzPW9uIi4N
Cj4+IGkuZS4gLWRldmljZSBpbnRlbC1pb21tdSx4LXNjYWxhYmxlLW1vZGU9b24seC1mbHRzPW9u
Li4uDQo+Pg0KPj4gUGFzc3Rocm91Z2ggZGV2aWNlIHNob3VsZCB1c2UgaW9tbXVmZCBiYWNrZW5k
IHRvIHdvcmsgd2l0aCBzdGFnZS0xDQo+dHJhbnNsYXRpb24uDQo+PiBpLmUuIC1vYmplY3QgaW9t
bXVmZCxpZD1pb21tdWZkMCAtZGV2aWNlIHZmaW8tcGNpLGlvbW11ZmQ9aW9tbXVmZDAsLi4uDQo+
Pg0KPj4gSWYgaG9zdCBkb2Vzbid0IHN1cHBvcnQgbmVzdGVkIHRyYW5zbGF0aW9uLCBxZW11IHdp
bGwgZmFpbCB3aXRoIGFuIHVuc3VwcG9ydGVkDQo+PiByZXBvcnQuDQo+DQo+eW91J3JlIG5vdCBt
ZW50aW9uaW5nIGxhY2sgb2YgZXJyb3IgcmVwb3J0aW5nIGZyb20gSFcgUzEgZmF1bHRzIHRvDQo+
Z3Vlc3RzLiBBcmUgdGhlcmUgb3RoZXIgZGVwcyBtaXNzaW5nPw0KDQpHb29kIHF1ZXN0aW9uLCB0
aGlzIHdpbGwgYmUgaW4gZnV0dXJlIHNlcmllcy4gUGxhbiBpczoNCg0KMSkgdnRkIG5lc3RpbmcN
CjIpIHBhc2lkIHN1cHBvcnQNCjMpIFBSUSBzdXBwb3J0KHRoaXMgaW5jbHVkZXMgUzEgZmF1bHRz
IHBhc3NpbmcpDQoNClNvIHRvIHBsYXkgd2l0aCB0aGlzIHNlcmllcywgd2UgaGF2ZSB0byBwcmVz
dW1lIGd1ZXN0IGtlcm5lbCBhbHdheXMgY29uc3RydWN0DQpjb3JyZWN0IFMxIHBhZ2UgdGFibGUg
Zm9yIHBhc3N0aHJvdWdoIGRldmljZSwgZm9yIGVtdWxhdGVkIGRldmljZXMsIHRoZQ0KZW11bGF0
aW9uIGNvZGUgYWxyZWFkeSBwcm92aWRlZCBTMSBmYXVsdCBpbmplY3Rpb24uDQoNClRoYW5rcw0K
Wmhlbnpob25nDQo=

