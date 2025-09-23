Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A12CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zkq-0000Wh-AA; Tue, 23 Sep 2025 05:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0zkf-0000UH-0M
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:56:02 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0zkZ-0008BG-UM
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758621357; x=1790157357;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ev/eVeujqSeq5CATsTa+H+HvHP6r9kfouzb62NZuf1M=;
 b=ecPnf7nXSl1YyRSx4X6pBOV8yIj6BvzpxbJbA2H9Ni8BD2Qos0DMfQFv
 qlKAIgTXSPFcRxvLeLlS1fw8r30gaD5RWE69zsIN41p+WHTbRZd+0BJhT
 AAxvrZf6wO0QKAGJEvIxtZ8OFWHAWbL9cV02jMEdpVDWSNSKtyKaO69uw
 iNSL5nO0dPLMCj+11zTD/llWCVxglBXiOFsTlBsgkbJlDRxfUJeKz5Mao
 z7v2YmRPhvcVsINyPBrAvHVhW8+aSpMI6f01jdeXcLnpsQWU6qJ5EQZGq
 em1nS1g1tBUEPuvarkfnlRCarmtgwgRGX1Q3QWd9J+VxwRgCAeHer+ND1 Q==;
X-CSE-ConnectionGUID: QTijMQiRSnOwp7nWr3PWUw==
X-CSE-MsgGUID: IwhBehPKT0essdkNXnlCxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72321163"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="72321163"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 02:55:50 -0700
X-CSE-ConnectionGUID: RhG50+SrTwyXWL/DRGdUMw==
X-CSE-MsgGUID: wnzI2nudQTKXRu2b3S3bXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="177511406"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 02:55:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 02:55:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 02:55:48 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 02:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYz0MNgx46uS2ViyVfjVxsYAAJJeZM/EKV3Fh6rf5WvqCr3147oXJGzz3qnxY7SekTIg3X4RcQw8djDwAjHaxThY/NeCPBxin/W8WKDQmY8Va8sFRIZZOYZBtF5R8ufx87Z90SUOH4fE8fJ4pQEmNSdWFgXVP17Ttk0PYmtdq9X5rqBgIcUKFaTmCVg2qESFHMOCxEA5FILeg43874x3rlGIXATVVXedbxqHjge3GX1BSzL9lRI0zkiJGwvOQYcyvGytA+VGbeXG8XBgs8E5HoSaDu4v8ZU3KsJrmUFBTBfKyK7iQ5CLYACmLd51d3k0q3DWvAbVu+NxjmornI8Q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev/eVeujqSeq5CATsTa+H+HvHP6r9kfouzb62NZuf1M=;
 b=ufPgfBET5ijLZXhnLEwvELD+HOUEYVeWEMMbrwVjV6ZUk0bwe5Kj+/SvbLiricSINz9K6IC+hZIixKnojk4cPb2TwwlvLof79ZjKwG0GRQCupRgHVrvBXlyw5rR6SuV9usr+CftuR9MHIJJNuLZu1by13H3Odre4G4pm3HdtKN+pqtkq6JfBcPO3f+VS3jfjCGUWKoXs1uiYkVzbt3B05ywWIfxhVIqI4h4lLZbsNH0/liCVM+RHv4AYG6e2DTV0VRJKPhAqBpaf9GTLPPARHSY0sZN3yfgl5H/GfWkpKS4sblwqVvpXtoFDf2CtWycdvKZBwTPF5/A9Rr0B6vv6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 09:55:45 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Tue, 23 Sep 2025
 09:55:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "avihaih@nvidia.com"
 <avihaih@nvidia.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, 
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Topic: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Index: AQHcIfvtcDcAUY1arESRh5H1VPguD7SaXCYAgAQ5VOCAANsXgIAAATaAgAAPTgCAAKChkIAAcAiAgAAJPEA=
Date: Tue, 23 Sep 2025 09:55:45 +0000
Message-ID: <IA3PR11MB9136C05AA0D42A3010D7C3EB921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
 <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
 <IA3PR11MB9136B9DA08CC2A48E1678DED9212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
 <ce629779-42ea-4850-924a-5803a7547998@oracle.com>
 <4120d83b-9f84-466d-b359-d73a3e7192a8@oracle.com>
 <IA3PR11MB91368B78D35566353217B544921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <54480877-bdda-4acc-be44-b09ed141a00b@oracle.com>
In-Reply-To: <54480877-bdda-4acc-be44-b09ed141a00b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB6728:EE_
x-ms-office365-filtering-correlation-id: 9dbb995b-0d19-41a1-4118-08ddfa875d61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dS9tK1dWUXhsWm81UjNzUS9ITWk4aHdGaXIxMHhzTXE4U0ZSaXBKWHFWYzZs?=
 =?utf-8?B?WnZlNmZNeHNoRDJrRjZmMzcxN2xWclJuSysrdURwZTZycU5ROWRYTjgvUzJ5?=
 =?utf-8?B?UE5icFdvOTU3TW1FS3Zvc2pFTTlnTkpOMVNKR3MzWi93L0pzWDdJbE5RSml0?=
 =?utf-8?B?dkU4SUZjc3ljdFFXVUptdStMT1ZPSnVpWVhsMUlnQ3ZrR2FRTCsybzBEVDNG?=
 =?utf-8?B?WWdzcWJOTWM1VGRLNWhOWGhrNDBtYXRaN2oyK1lzTG1BZ3U5Q0gwMGh0R1ZB?=
 =?utf-8?B?WnR1RHdFbGhzTWgzUW1uZDNYcEZCemUwV3lyVm1YbHkwUDBBaW5ueHZXVmhB?=
 =?utf-8?B?VFA5Q3JiQXEwMXNXMlpOcStsM0JNOXVxMmhPdE9ZdTl2Y281SVhuUHZsU2o3?=
 =?utf-8?B?VkpHcVlQMm56djNaNlRGNmtaOXF5MjBsdU1tS21PU0YrOG5iYWNmQTJ4dVUz?=
 =?utf-8?B?bXpBWmtPQW9JdUN4OFdadnZTblM0UkZzR1E4OEppczF2aThqZ0VjVkhlbzdO?=
 =?utf-8?B?WU5NSldSRXpjWW01MjhVSVpRaFprL3I4bWF0aUx3cTFoOUJjSGhDeXVKdkNv?=
 =?utf-8?B?RmxvSC9Eb2tuWXdhTUN2NnJjVUgyZFBJY2lQUlBuOWFielVGK3lENVV1VFNt?=
 =?utf-8?B?SXJINUQzNjZaeHF4RnpWNWphcmd3L1hneHNJcWN0KzZJODZJUThIMUxyUUor?=
 =?utf-8?B?dksyazhrV0FHc3hhZWxwSDA1Q2VOQkpGZ2x6Mks5TndpS0FtdGRQYzNWcUt3?=
 =?utf-8?B?dm1rSU14WlFQODE3WUZGc1RoaS9aUXU3b3lnVTQ1RDkzb1crZjRpZHAzTkNS?=
 =?utf-8?B?M1BEeE5VMDdVeTQ4ZGdXL3ZRKzZ3blpyelZLR3ZMTFpTZjJzSU1GL3Q3eXBp?=
 =?utf-8?B?RW13OHVML3VQWWtlS2RvZmQ1a2kvNXRyRmtqc3FLQ3k4aTdDU0ZDUmhEUVhr?=
 =?utf-8?B?aXY2eWtLNXMzNUxwUEd0TkpkaHQ1VXVlZ1J1Q25iajZxajRkZElaWWVrL2JF?=
 =?utf-8?B?MDJSU1NIdGFmM0hBS3RIbGNCQ0h1QzVQOGIxeHRoQlYxcW9CSVo5MUVHT2Fy?=
 =?utf-8?B?MnJway9BN2ltbm1oKzVCdS9ic2hXTllzSmpBYktnOUgzMWhEQkpvVEJTQUdL?=
 =?utf-8?B?S2ZDOW55c1VzWnNTaytjamFRQ0ZqTFhJK1JQQytWL1dNYkRHWXFOWWNJWkVq?=
 =?utf-8?B?eTlQeDcxUUw0eW9xS3FPZE1FRUUzcjBma1ltQWNzRGw2QTU5YlpWZ2VqZzU2?=
 =?utf-8?B?aTB0bWlqeTN3SWpRQjJoeDdvQVp3L1gvNjlLckZyY0E5bG1obXBQTk5wQjZ1?=
 =?utf-8?B?YWFONmh5ZE9ZWDdOQlNQOWlvdU1hMTBGLzkyTXhvT2t4d2I3Vk9JZ2FnRXdm?=
 =?utf-8?B?bklMc01zbFZPcEtxNDlaR2t3a3Y3cHo4b05BQldUWnlvM1djNGtRMWp3dlJy?=
 =?utf-8?B?TmZVaWlORHBKL1hQenNJOVFFTFpQUGRJZWZYckxPLzZ3cFlnNmdOQ1hSWkVo?=
 =?utf-8?B?WHlib2s5ZmQzenFkbkNld3pmVVdUUnpWT2l4cmNZeG9jMVlqZjRPUXhRNFpp?=
 =?utf-8?B?UWNsL1BPNXErNXRmc000VmgraWRaOTNud1dNcmpwdVRWNnNLRVV5OFBSZVA5?=
 =?utf-8?B?bzJScTVlTG52VHdoR21waGNvRnh1ZGNNVW8zUHZlaXhrczBmalpvMW5KZDRI?=
 =?utf-8?B?RUl3dmtIMGNUZEphblNtUUhta2J2VnduQTQ5QWFwSUhzajdYUnNWRE9rQlNk?=
 =?utf-8?B?ZWo3dytYdVFrbWVnL0Y0TVlSdTFlTklKS3RtTFk0MXl1d3g2Z1ZGV0lvSHhQ?=
 =?utf-8?B?Z0xjTXNlM2Iwc09TTGd0Q0NBOEhvOCtzbzFDTitCaW5Oc05YcS9XT3hPREhB?=
 =?utf-8?B?NDhaR3VTY203RnVRaVp0L1FkeDBFckxNdVVYRldjTnNwSmZmTmcyT21FZ3BL?=
 =?utf-8?B?NFNZckNob2FmbGVQaTNyT3o0QmpSZkJFODltZW5QUDZuNVZ2Qms4YllZQ0Fl?=
 =?utf-8?Q?PXpRzdYwQlTjoneOhf7MZ/pwraDlbU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEt6eG5wOFdlTm1SYUNvTU15SURocFIvZ1NubEQyOVgweHA4KzgxKzl0T1V1?=
 =?utf-8?B?YkFMd2ZkUkc4WEgvaktJMEpGankzMzRjT0I5RHZGSDhyd1dtRkFoUVJVMG1r?=
 =?utf-8?B?U1p1c2FHcjNoN1lqNnF4c0lkQ0JITlREWnkwbGdUT1dkNGJFVGpzenI5SUxP?=
 =?utf-8?B?K3QxUi8vTVJtY01CTFhUZElZWmhpYkovdEp0Q1gxU0R6SHdjT1Ewa3VtczB0?=
 =?utf-8?B?dFFkSXZ3cmZLOGhSMjhJSS9YVlJSMjhOUS8vc09vU3M3Tk5Da3ZweVVxL2lH?=
 =?utf-8?B?UjhoYm0vblQ3RkZndStsS1RQcTFoZ08rSE96QTRHZGxmb2YwblRWK2tKeWRO?=
 =?utf-8?B?TDJRUFlpOXZVa1pnbWl0YllVVFVLYi9WTmh5SE1jVUlSUVZnUnhIdHY1YjlZ?=
 =?utf-8?B?cUJRNlFvUUZZUzNpMTVqd1hHTTk4dDlEb1ZNb3dwdXdXbU5rakpkdWNJSWwy?=
 =?utf-8?B?MEt3ZFdUVzhrWThlUnM2cU8zbmlQSU51OGFheEZVYktwZExsa2N5aHYxNVZi?=
 =?utf-8?B?VFlzRWVnZ204WkVSMDlkMjFUUG5Sc3VaMkRuVm5uVGU0eFpWSnV4UmxrMGcz?=
 =?utf-8?B?dnBKNGtkVnBaNHBkYUV1UjdKbUhKM0JHUkN1Y056NldrWEZHN2czUzVLdkFz?=
 =?utf-8?B?VGJKTlJQcndISHc5ZHRhRGhjVFkzZjk2N2Zid0phckpTYVJqZlVtT1V1SE9W?=
 =?utf-8?B?YnQzYnhJeXhxTFprTDM1U0MzMEMyRXZPaVRXd044Zy9Ed1hUbk5MNEhGSjVO?=
 =?utf-8?B?UE9Vak1OdDhZSXlpeHN2VkswWDJ6L1Q3QXdmbXc4cUFwZWRBZEhwZ2l6MHJQ?=
 =?utf-8?B?WFY1WkFGaHdNWnRHWGRKWXJJRTBra1ZUOVJWZUhMRlBJWmYwc2hicUd3c0dw?=
 =?utf-8?B?VXByd3dYcEdjencwV0RZS0FYaGZwWDdYNnpPVDN0S2tIQ3RDeGhNSUVtcWo4?=
 =?utf-8?B?R3ppS241UjMvV01udzUrcFAxdHpmdXJZQUd2aHJqVCszazBaVlVyelhleFdj?=
 =?utf-8?B?UzVyODkrcjJ6ek9uV3M1bWR4N084aWFiTmw1enVaUUFsMmdUQ0srRkVIWkE4?=
 =?utf-8?B?ekFmcmRqdnNvTTVBdittbEVkQk1FcGppNU53N2RuVFFWTzNYRGVwUUJWaVdt?=
 =?utf-8?B?SEhtcDBGaW9USGJOU0xLOWNZM0U4dWVZOGE5Z21IVmoveFhnVVhtdGNSN0ht?=
 =?utf-8?B?UGkvTjlwZ3hLbzlEdEk4WWdaMzdJTGR0RGUzbkdxYlJJMDV0NU9LZnZveUpo?=
 =?utf-8?B?Zi9KVXdPUWJDQXhWT0hVbURmaTZjRlZvUzB4ayt0UUw5cEpzQXRYekhwaDB2?=
 =?utf-8?B?anc1TXRtVTVZTHhTQ1k1SktoU1VWckhYeTE4RUNWUThSbXE4anZId0pBRE12?=
 =?utf-8?B?WkxKUHl4bzVGSVphRDdjSzlKS3ZMR2pKeHMrYU5aWFBSUC9QZU85WXhBVzRZ?=
 =?utf-8?B?elp0ZTZLSHhTNGlCL2NFSU4rSnRHUW1HaVQ5cU83Sk5TdFVKT3dya0NrNjFI?=
 =?utf-8?B?WXN5cjJxWUw4L2VsajcwQmcxbDFCYXg4MmtINjRuMnkzaUM3ZWhXQ2RFNVRW?=
 =?utf-8?B?V0d0djV6d1RpbzdCZkdkQzBPODkyRDdxdW9QbXB1akxrOFNUNGJ0Um53T2JE?=
 =?utf-8?B?VnlGQS8zcUllcGpWdjV0THFWVTl0Wm9hZVdyQXp6UWtwRkZuaFdJQjIvSW90?=
 =?utf-8?B?UWZ2RFJXYzgzOE9pdnhkZUxmZ3IyeERldlBTb09uRjdjcG9WUjZWVUFUd2RZ?=
 =?utf-8?B?QnhsTURHRmp2ZUduZ3gzbVVSMG1vYjNjUVJPNWtvdDNjU0ZwVGpnVDd2U0Vt?=
 =?utf-8?B?MjV3T0pKYVl3aUo4WFJNZ096U2pmZjR2eldzMG1vV0Ywc3p6ZVozU090cllt?=
 =?utf-8?B?UXkwYUJzM25nSFVnV1VzZGNQVWNMUHlIdVZFYndOY1h1TnpJVitZL290dXlX?=
 =?utf-8?B?cmcxM2FDNVRsL1FBL3B5aSsxdGx0UGUvYWd3SGovL3FZVnBWWmZZSCtqeStJ?=
 =?utf-8?B?TGIxMkxYQmZMTTBSSnFpb01XeTlXZXUrZGFqVXlYeDVYd1dQNDd6RkJXTTE0?=
 =?utf-8?B?N1lEeHlSb1FIT0tkTmczL3hCcTh4azN1NGRlVUpPdGJMRjBVd3ZkZHdiUEpM?=
 =?utf-8?Q?Jf66kLDnR0MN9XsgH8lFPNCjm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbb995b-0d19-41a1-4118-08ddfa875d61
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 09:55:45.0626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faMU9l3rIpmPQhxwDXrdcBjpbsoWItPu13hEBJtTluQazCPS5j+ma4sLRJyW92n3KSWLHFXggQzP+HWiUSXin2+C3L9NzYNOzz2Afvlo95g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDMvNV0gdmZpby9p
b21tdWZkOiBBZGQNCj5JT01NVV9IV1BUX0dFVF9ESVJUWV9CSVRNQVBfTk9fQ0xFQVIgZmxhZyBz
dXBwb3J0DQo+DQo+T24gMjMvMDkvMjAyNSAwMzo1MCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0K
Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogSm9hbyBNYXJ0aW5zIDxq
b2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy81XSB2
ZmlvL2lvbW11ZmQ6IEFkZA0KPj4+IElPTU1VX0hXUFRfR0VUX0RJUlRZX0JJVE1BUF9OT19DTEVB
UiBmbGFnIHN1cHBvcnQNCj4+Pg0KPj4+IE9uIDIyLzA5LzIwMjUgMTc6MDYsIEpvYW8gTWFydGlu
cyB3cm90ZToNCj4+Pj4gT24gMjIvMDkvMjAyNSAxNzowMiwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3Jv
dGU6DQo+Pj4+PiBPbiA5LzIyLzI1IDA3OjQ5LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+
Pj4gSGkgSm9hbywNCj4+Pj4+Pg0KPj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
Pj4+Pj4+PiBGcm9tOiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+DQo+
Pj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy81XSB2ZmlvL2lvbW11ZmQ6IEFkZA0KPj4+Pj4+
PiBJT01NVV9IV1BUX0dFVF9ESVJUWV9CSVRNQVBfTk9fQ0xFQVIgZmxhZyBzdXBwb3J0DQo+Pj4+
Pj4+DQo+Pj4+Pj4+IE9uIDEwLzA5LzIwMjUgMDM6MzYsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0K
Pj4+Pj4+Pj4gUGFzcyBJT01NVV9IV1BUX0dFVF9ESVJUWV9CSVRNQVBfTk9fQ0xFQVIgd2hlbiBk
b2luZw0KPnRoZQ0KPj4+IGxhc3QNCj4+Pj4+Pj4gZGlydHkNCj4+Pj4+Pj4+IGJpdG1hcCBxdWVy
eSByaWdodCBiZWZvcmUgdW5tYXAsIG5vIFBURXMgZmx1c2hlcy4gVGhpcyBhY2NlbGVyYXRlcw0K
PnRoZQ0KPj4+Pj4+Pj4gcXVlcnkgd2l0aG91dCBpc3N1ZSBiZWNhdXNlIHVubWFwIHdpbGwgdGVh
ciBkb3duIHRoZSBtYXBwaW5nDQo+Pj4gYW55d2F5Lg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEFkZCBh
IG5ldyBlbGVtZW50IGRpcnR5X3RyYWNraW5nX2ZsYWdzIGluIFZGSU9JT01NVUZEQ29udGFpbmVy
DQo+dG8NCj4+Pj4+Pj4+IGJlIHVzZWQgZm9yIHRoZSBmbGFncyBvZiBpb21tdWZkIGRpcnR5IHRy
YWNraW5nLiBDdXJyZW50bHkgaXQgaXMNCj4+Pj4+Pj4+IHNldCB0byBlaXRoZXIgSU9NTVVfSFdQ
VF9HRVRfRElSVFlfQklUTUFQX05PX0NMRUFSIG9yIDANCj4+PiBiYXNlZCBvbg0KPj4+Pj4+Pj4g
dGhlIHNjZW5hcmlvLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IENvLWRldmVsb3BlZC1ieTogSm9hbyBN
YXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPj4+Pj4+Pj4gU2ln
bmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+
Pj4+Pj4+IFRlc3RlZC1ieTogWHVkb25nIEhhbyA8eHVkb25nLmhhb0BpbnRlbC5jb20+DQo+Pj4+
Pj4+PiBUZXN0ZWQtYnk6IEdpb3Zhbm5pbyBDYWJpZGR1IDxnaW92YW5uaS5jYWJpZGR1QGludGVs
LmNvbT4NCj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4gwqAgaHcvdmZpby92ZmlvLWlvbW11ZmQuaMKg
wqAgfCAxICsNCj4+Pj4+Pj4+IMKgIGluY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCB8IDIgKy0NCj4+
Pj4+Pj4+IMKgIGJhY2tlbmRzL2lvbW11ZmQuY8KgwqDCoMKgwqDCoCB8IDUgKysrLS0NCj4+Pj4+
Pj4+IMKgIGh3L3ZmaW8vaW9tbXVmZC5jwqDCoMKgwqDCoMKgwqAgfCA2ICsrKysrLQ0KPj4+Pj4+
Pj4gwqAgYmFja2VuZHMvdHJhY2UtZXZlbnRzwqDCoMKgIHwgMiArLQ0KPj4+Pj4+Pj4gwqAgNSBm
aWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+Pj4+Pj4N
Cj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL3ZmaW8taW9tbXVmZC5oIGIvaHcvdmZpby92
ZmlvLWlvbW11ZmQuaA0KPj4+Pj4+Pj4gaW5kZXggMDdlYTBmNDMwNC4uZTBhZjI0MWM3NSAxMDA2
NDQNCj4+Pj4+Pj4+IC0tLSBhL2h3L3ZmaW8vdmZpby1pb21tdWZkLmgNCj4+Pj4+Pj4+ICsrKyBi
L2h3L3ZmaW8vdmZpby1pb21tdWZkLmgNCj4+Pj4+Pj4+IEBAIC0yNiw2ICsyNiw3IEBAIHR5cGVk
ZWYgc3RydWN0IFZGSU9JT01NVUZEQ29udGFpbmVyIHsNCj4+Pj4+Pj4+IMKgwqDCoMKgwqAgVkZJ
T0NvbnRhaW5lckJhc2UgYmNvbnRhaW5lcjsNCj4+Pj4+Pj4+IMKgwqDCoMKgwqAgSU9NTVVGREJh
Y2tlbmQgKmJlOw0KPj4+Pj4+Pj4gwqDCoMKgwqDCoCB1aW50MzJfdCBpb2FzX2lkOw0KPj4+Pj4+
Pj4gK8KgwqDCoCB1aW50NjRfdCBkaXJ0eV90cmFja2luZ19mbGFnczsNCj4+Pj4+Pj4+IMKgwqDC
oMKgwqAgUUxJU1RfSEVBRCgsIFZGSU9JT0FTSHdwdCkgaHdwdF9saXN0Ow0KPj4+Pj4+Pj4gwqAg
fSBWRklPSU9NTVVGRENvbnRhaW5lcjsNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+Pj4+
Pj4+PiBpbmRleCBjOWM3MmZmYzQ1Li42Mzg5OGU3YjBkIDEwMDY0NA0KPj4+Pj4+Pj4gLS0tIGEv
aW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+Pj4+Pj4+PiArKysgYi9pbmNsdWRlL3N5c3RlbS9p
b21tdWZkLmgNCj4+Pj4+Pj4+IEBAIC02NCw3ICs2NCw3IEBAIGJvb2wNCj4+Pj4+Pj4gaW9tbXVm
ZF9iYWNrZW5kX3NldF9kaXJ0eV90cmFja2luZyhJT01NVUZEQmFja2VuZCAqYmUsDQo+dWludDMy
X3QNCj4+Pj4+Pj4gaHdwdF9pZCwNCj4+Pj4+Pj4+IMKgIGJvb2wgaW9tbXVmZF9iYWNrZW5kX2dl
dF9kaXJ0eV9iaXRtYXAoSU9NTVVGREJhY2tlbmQNCj4qYmUsDQo+Pj4+Pj4+IHVpbnQzMl90IGh3
cHRfaWQsDQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0Xw0KPnQNCj4+PiBp
b3ZhLCByYW1fYWRkcl90DQo+Pj4+Pj4+IHNpemUsDQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdWludDY0Xw0KPnQNCj4+PiBwYWdlX3NpemUsDQo+Pj4+Pj4+IHVpbnQ2NF90ICpkYXRh
LA0KPj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVycm9yDQo+Pj4gKiplcnJwKTsNCj4+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdA0KPj4+IGZsYWdzLCBFcnJvcg0KPj4+Pj4+
PiAqKmVycnApOw0KPj4+Pj4+Pj4gwqAgYm9vbCBpb21tdWZkX2JhY2tlbmRfaW52YWxpZGF0ZV9j
YWNoZShJT01NVUZEQmFja2VuZA0KPipiZSwNCj4+Pj4+Pj4gdWludDMyX3QgaWQsDQo+Pj4+Pj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyXw0KPnQNCj4+PiBkYXRhX3R5cGUsDQo+Pj4+
Pj4+IHVpbnQzMl90IGVudHJ5X2xlbiwNCj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
aW50MzJfDQo+dA0KPj4+ICplbnRyeV9udW0sIHZvaWQNCj4+Pj4+Pj4gKmRhdGEsDQo+Pj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaW9tbXVmZC5jIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+
Pj4+Pj4+PiBpbmRleCAyYTMzYzdhYjBiLi4zYzRmNjE1N2UyIDEwMDY0NA0KPj4+Pj4+Pj4gLS0t
IGEvYmFja2VuZHMvaW9tbXVmZC5jDQo+Pj4+Pj4+PiArKysgYi9iYWNrZW5kcy9pb21tdWZkLmMN
Cj4+Pj4+Pj4+IEBAIC0zNjEsNyArMzYxLDcgQEAgYm9vbA0KPj4+Pj4+PiBpb21tdWZkX2JhY2tl
bmRfZ2V0X2RpcnR5X2JpdG1hcChJT01NVUZEQmFja2VuZCAqYmUsDQo+Pj4+Pj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdWludDMyXw0KPnQNCj4+PiBod3B0X2lkLA0KPj4+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF8NCj50DQo+Pj4gaW92YSwgcmFtX2FkZHJfdA0KPj4+Pj4+
PiBzaXplLA0KPj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF8NCj50DQo+Pj4g
cGFnZV9zaXplLA0KPj4+Pj4+PiB1aW50NjRfdCAqZGF0YSwNCj4+Pj4+Pj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBFcnJvcg0KPioqZXJycCkNCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50
NjRfdA0KPj4+IGZsYWdzLCBFcnJvciAqKmVycnApDQo+Pj4+Pj4+PiDCoCB7DQo+Pj4+Pj4+PiDC
oMKgwqDCoMKgIGludCByZXQ7DQo+Pj4+Pj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBpb21tdV9od3B0
X2dldF9kaXJ0eV9iaXRtYXAgZ2V0X2RpcnR5X2JpdG1hcCA9IHsNCj4+Pj4+Pj4+IEBAIC0zNzEs
MTEgKzM3MSwxMiBAQCBib29sDQo+Pj4+Pj4+IGlvbW11ZmRfYmFja2VuZF9nZXRfZGlydHlfYml0
bWFwKElPTU1VRkRCYWNrZW5kICpiZSwNCj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAubGVu
Z3RoID0gc2l6ZSwNCj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAucGFnZV9zaXplID0gcGFn
ZV9zaXplLA0KPj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIC5kYXRhID0gKHVpbnRwdHJfdClk
YXRhLA0KPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5mbGFncyA9IGZsYWdzLA0KPj4+Pj4+Pj4g
wqDCoMKgwqDCoCB9Ow0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IMKgwqDCoMKgwqAgcmV0ID0gaW9jdGwo
YmUtPmZkLCBJT01NVV9IV1BUX0dFVF9ESVJUWV9CSVRNQVAsDQo+Pj4+Pj4+ICZnZXRfZGlydHlf
Yml0bWFwKTsNCj4+Pj4+Pj4+IMKgwqDCoMKgwqAgdHJhY2VfaW9tbXVmZF9iYWNrZW5kX2dldF9k
aXJ0eV9iaXRtYXAoYmUtPmZkLA0KPmh3cHRfaWQsDQo+Pj4gaW92YSwNCj4+Pj4+Pj4gc2l6ZSwN
Cj4+Pj4+Pj4+DQo+Pj4NCj4twqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhZ2Vfc2l6ZSwN
Cj4+PiByZXQgPyBlcnJubyA6DQo+Pj4+Pj4+IDApOw0KPj4+Pj4+Pj4NCj4rwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZsYWdzLA0KPj4+IHBhZ2Vfc2l6ZSwgcmV0ID8NCj4+Pj4+Pj4gZXJy
bm8gOiAwKTsNCj4+Pj4+Pj4+IMKgwqDCoMKgwqAgaWYgKHJldCkgew0KPj4+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sDQo+Pj4+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJJT01NVV9I
V1BUX0dFVF9ESVJUDQo+WV8NCj4+PiBCSVRNQVANCj4+Pj4+Pj4gKGlvdmE6IDB4JSJIV0FERFJf
UFJJeA0KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9p
b21tdWZkLmMNCj4+Pj4+Pj4+IGluZGV4IDAwNTc0ODhjZTkuLmM4OTdhYTZiMTcgMTAwNjQ0DQo+
Pj4+Pj4+PiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4+Pj4+Pj4gKysrIGIvaHcvdmZpby9p
b21tdWZkLmMNCj4+Pj4+Pj4+IEBAIC02Miw3ICs2Miw3IEBAIHN0YXRpYyBpbnQgaW9tbXVmZF9j
ZGV2X3VubWFwX29uZShjb25zdA0KPj4+Pj4+PiBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5l
ciwNCj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHdhZGRyIGlvdmEsDQo+Pj4gcmFtX2FkZHJfdCBz
aXplLA0KPj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJT01NVVRMQkUNCj5udHINCj4+PiB5ICppb3Rs
YikNCj4+Pj4+Pj4+IMKgIHsNCj4+Pj4+Pj4+IC3CoMKgwqAgY29uc3QgVkZJT0lPTU1VRkRDb250
YWluZXIgKmNvbnRhaW5lciA9DQo+Pj4+Pj4+PiArwqDCoMKgIFZGSU9JT01NVUZEQ29udGFpbmVy
ICpjb250YWluZXIgPQ0KPj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRhaW5lcl9vZihi
Y29udGFpbmVyLCBWRklPSU9NTVVGRENvbnRhaW5lciwNCj4+Pj4+Pj4gYmNvbnRhaW5lcik7DQo+
Pj4+Pj4+PiDCoMKgwqDCoMKgIGJvb2wgbmVlZF9kaXJ0eV9zeW5jID0gZmFsc2U7DQo+Pj4+Pj4+
PiDCoMKgwqDCoMKgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPj4+Pj4+Pj4gQEAgLTczLDkg
KzczLDEyIEBAIHN0YXRpYyBpbnQgaW9tbXVmZF9jZGV2X3VubWFwX29uZShjb25zdA0KPj4+Pj4+
PiBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4+Pj4+Pj4+IMKgwqDCoMKgwqAgaWYg
KGlvdGxiICYmDQo+Pj4gdmZpb19jb250YWluZXJfZGlydHlfdHJhY2tpbmdfaXNfc3RhcnRlZChi
Y29udGFpbmVyKSkgew0KPj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmDQo+Pj4+Pj4+ICgh
dmZpb19jb250YWluZXJfZGV2aWNlc19kaXJ0eV90cmFja2luZ19pc19zdXBwb3J0ZWQoYmNvbnRh
aW5lcikgJiYNCj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJjb250YWluZXIt
PmRpcnR5X3BhZ2VzX3N1cHBvcnRlZCkgew0KPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29udGFpbmVyLT5kaXJ0eV90cmFja2luZ19mbGFncyA9DQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+
IElPTU1VX0hXUFRfR0VUX0RJUlRZX0JJVE1BUF9OT19DTEVBUjsNCj4+Pj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9DQo+Pj4gdmZpb19jb250YWluZXJfcXVlcnlfZGlydHlf
Yml0bWFwKGJjb250YWluZXIsIGlvdmEsDQo+Pj4+Pj4+IHNpemUsDQo+Pj4+Pj4+Pg0KPj4+Pj4+
PiBpb3RsYi0+dHJhbnNsYXRlZF9hZGRyLA0KPj4+Pj4+Pj4NCj4+Pj4+Pj4gJmxvY2FsX2Vycik7
DQo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250YWluZXItPmRpcnR5X3RyYWNr
aW5nX2ZsYWdzID0gMDsNCj4+Pj4+Pj4NCj4+Pj4+Pj4gV2h5IG5vdCBjaGFuZ2luZyB2ZmlvX2Nv
bnRhaW5lcl9xdWVyeV9kaXJ0eV9iaXRtYXAgdG8gcGFzcyBhIGZsYWdzDQo+Pj4gdG9vLCBsaWtl
DQo+Pj4+Pj4+IHRoZQ0KPj4+Pj4+PiBvcmlnaW5hbCBwYXRjaGVzPyBUaGlzIGlzIGEgbGl0dGxl
IHVubmVjc3Nhcnkgb2RkIHN0eWxlIHRvIHBhc3MgYSBmbGFnIHZpYQ0KPj4+Pj4+PiBjb250YWlu
ZXIgc3RydWN0dXJlIHJhdGhlciBhbmQgdGhlbiBjbGVhcmluZy4NCj4+Pj4+Pg0KPj4+Pj4+IEp1
c3Qgd2FudCB0byBiZSBzaW1wbGVyLCBvcmlnaW5hbCBwYXRjaCBpbnRyb2R1Y2VkIGEgbmV3IHBh
cmFtZXRlciB0bw0KPj4+IGFsbW9zdCBhbGwNCj4+Pj4+PiB2YXJpYW50cyBvZiAqX3F1ZXJ5X2Rp
cnR5X2JpdG1hcCgpIHdoaWxlIHRoZSBmbGFncyBwYXJhbWV0ZXIgaXMgb25seQ0KPnVzZWQNCj4+
PiBieQ0KPj4+Pj4+IElPTU1VRkQgYmFja2VuZCB3aGVuIGRvaW5nIHVubWFwX2JpdG1hcC4gQ3Vy
cmVudGx5IHdlIGFscmVhZHkNCj4+PiBoYXZlIHRocmVlDQo+Pj4+Pj4gYmFja2VuZHMsIGxlZ2Fj
eSBWRklPLCBJT01NVUZEIGFuZCBWRklPLXVzZXIsIG9ubHkgSU9NTVVGRCBuZWVkDQo+Pj4gdGhl
IGZsYWcuDQo+Pj4+Pj4NCj4+Pj4+PiBJIHRha2UgY29udGFpbmVyLT5kaXJ0eV90cmFja2luZ19m
bGFncyBhcyBhIG5vdGlmaWNhdGlvbiBtZWNoYW5pc20sIHNvDQo+c2V0DQo+Pj4gaXQNCj4+Pj4+
PiBiZWZvcmUNCj4+Pj4+PiB2ZmlvX2NvbnRhaW5lcl9xdWVyeV9kaXJ0eV9iaXRtYXAoKSBhbmQg
Y2xlYXIgaXQgdGhlcmVhZnRlci4gTWF5YmUNCj4+PiBjbGVhcmluZyBpdCBpbg0KPj4+Pj4+IGlv
bW11ZmRfcXVlcnlfZGlydHlfYml0bWFwKCkgaXMgZWFzaWVyIHRvIGJlIGFjY2VwdGFibGU/DQo+
Pj4+Pj4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gUGFydCBvZiB0aGUgcmVhc29uIHRoZSBvcmlnaW5hbCBz
ZXJpZXMgaGFkIGENCj5WRklPX0dFVF9ESVJUWV9OT19GTFVTSA0KPj4+IGZvcg0KPj4+Pj4+PiBn
ZW5lcmljDQo+Pj4+Pj4+IGNvbnRhaW5lciBhYnN0cmFjdGlvbiB3YXMgdG8gbm90IG1peCBJT01N
VUZEIFVBUEkgc3BlY2lmaWNzIGludG8NCj5iYXNlDQo+Pj4+Pj4+IGNvbnRhaW5lcg0KPj4+Pj4+
PiBBUEkuIFRoZW4gaW4gZ2V0dGluZyBhIFZGSU9fR0VUX0RJUlRZX05PX0ZMVVNILCB0aGVuIHR5
cGUxDQo+YmFja2VuZA0KPj4+Pj4+PiBjb3VsZCBqdXN0DQo+Pj4+Pj4+IGlnbm9yZSB0aGUgZmxh
Zywgd2hpbGUgSU9NTVVGRCB0cmFuc2xhdGVzIGl0IHRvDQo+Pj4+Pj4+IElPTU1VX0hXUFRfR0VU
X0RJUlRZX0JJVE1BUF9OT19DTEVBUg0KPj4+Pj4+DQo+Pj4+Pj4gSSBkaWQgcG9ydCBvcmlnaW5h
bCBwYXRjaCBodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvDQo+Pj4+Pj4gY29tbWl0
Lzk5ZjgzNTk1ZDc5ZDJlNDE3MGM5ZTQ1NmNmMWE3Yjk1MjFiZDRmODANCj4+Pj4+PiBCdXQgaXQg
bG9va3MgY29tcGxleCB0byBoYXZlICdmbGFncycgcGFyYW1ldGVyIGV2ZXJ5d2hlcmUuDQo+Pj4+
PiBJIHRoaW5rIEkgd291bGQgcHJlZmVyIGxpa2UgSm9hbyB0byBhdm9pZCBjYWNoaW5nIGluZm9y
bWF0aW9uIGlmIHBvc3NpYmxlDQo+Pj4+PiBidXQgSSBoYXZlbid0IGNoZWNrIGNsb3NlbHkgdGhl
IG1lc3MgaXQgd291bGQgaW50cm9kdWNlIGluIHRoZSBjb2RlLiBMZXQNCj4+Pj4+IG1lIGNoZWNr
Lg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gTXkgcmVjb2xsZWN0aW9uIHdhcyB0aGF0IGl0IHdhc24ndCB0
aGF0IG11Y2ggY2h1cm4gYWRkZWQgYXMgdGhpcyBzZXJpZXMgaXMNCj4+Pj4gYWxyZWFkeSBkb2lu
ZyB0aGUgbW9zdCBvZiB0aGUgY2h1cm4uIEJ1dCBJIGFtIGNoZWNraW5nIGhvdyB0aGUgY29kZQ0K
PndvdWxkDQo+Pj4gbG9vaw0KPj4+PiBsaWtlIHRvIHByb3Blcmx5IHJlc3BvbmQgdG8gaGlzIHN1
Z2dlc3Rpb24gb24gd2h5IGhlIGNoYW5naW5nIGl0IHRvd2FyZHMNCj4+Pj4gc3RydWN0dXJlZiBm
aWVsZC4NCj4+Pg0KPj4+IFRoZSBjaHVybiBzaG91bGQgYmUgc2ltaWxhciB0byB0aGlzIHBhdGNo
Og0KPj4+DQo+Pj4NCj5odHRwczovL2dpdGh1Yi5jb20vanBlbWFydGlucy9xZW11L2NvbW1pdC81
ZTFmMTEwNzUyOTlhNWZhOTU2NGEyNjc4OA0KPj4+IGRjOWNjMTcxN2UyOTdjDQo+Pj4NCj4+PiBJ
dCdzIG1vc3RseSBhbiBpbnRlcmZhY2UgcGFyYW1ldGVyIGFkZGl0aW9uIG9mIGZsYWdzLg0KPj4N
Cj4+IFllcywgaXQncyBhIGdlbmVyYWwgaW50ZXJmYWNlIHBhcmFtZXRlciBidXQgaXQncyBvbmx5
IHVzZWQgYnkgSU9NTVVGRC4NCj4+IFRoYXQncyBteSBvbmx5IGFyZ3VtZW50Lg0KPj4NCj4NCj5Z
b3UgY291bGQgdXNlIHRoYXQgYXJndW1lbnQgZm9yIGFueXRoaW5nIHRoYXQncyBub3QgY29tbW9u
IGFuZCB1bmlxdWUgdG8NCj5lYWNoDQo+YmFja2VuZC4gdHlwZTEgZGlydHkgdHJhY2tpbmcgaXMg
ZWZmZWN0aXZlbHkgImZyb3plbiIgaW4gVUFQSSAoSUlSQykgc28gSSB3b24ndA0KPmV4cGVjdCBm
bGFncy4gVGhlcmUncyBkZXZpY2UgZGlydHkgdHJhY2tpbmcsIElPTU1VRkQgZGlydHkgdHJhY2tp
bmcgYW5kDQo+dmZpby11c2VyIGRpcnR5IHRyYWNraW5nLiBXaGlsZSBJIGFtIG5vdCBhbnRpY2lw
YXRpbmcgYW55IG5ldyB0aGluZyBoZXJlIChhdA0KPmxlYXN0IGluIHRoZSBuZWVkcyBJIGhhdmUg
YWhlYWQsIGNhbid0IHNwZWFrIGZvciBvdGhlcg0KPmNvbXBhbmllcy9jb250cmlidXRvcnMpOw0K
PmJ1dCB5b3UgY291bGQgc2VlIHRoZSBmbGFncyBhcyBmdXR1cmUgcHJvb2ZpbmcgaXQuDQoNClll
cywgYWdyZWUgaXQncyBmdXR1cmUgcHJvb2ZpbmcuDQoNCj4NCj5UaGUgdWdseSBwYXJ0IG9mIHRo
ZSBhbHRlcm5hdGl2ZSBpcyB0aGF0IGl0IHNvcnQgb2YgbGltaXRzIHRoZSBpbnRlcmZhY2UgIHRv
IGJlDQo+c2luZ2xlLXVzZXIgb25seSBhcyBub2JvZHkgY2FsbCBpbnRvIElPTU1VRkQgd2l0aCB0
aGUgZGlydHlfdHJhY2tpbmdfZmxhZ3MgaWYNCj5pdCdzIGNhbGxlZCBjb25jdXJyZW50bHkgZm9y
IHNvbWUgb3RoZXIgcHVycG9zZSB0aGFuIHVubWFwLiBXZSBzb3J0IG9mIHVzZQ0KPnRoZQ0KPmNv
bnRhaW5lciBkYXRhIHN0cnVjdHVyZSBhcyBhIGFyZ3VtZW50IHN0b3JhZ2UgZm9yIGEgc2luZ2xl
IGNhbGwgYXMgb3Bwb3NlZCB0bw0KPnN0b3JlIHNvbWUgaW50ZXJtZWRpYXJ5IHN0YXRlLg0KDQpk
aXJ0eV90cmFja2luZ19mbGFncyBvbmx5IHRha2UgZWZmZWN0IGR1cmluZyB0aGUgdW5tYXAgcGF0
aCBleGNlcHQgeW91IHRha2UgaXQNCmZvciBvdGhlciBwdXJwb3NlLiBCdXQgeWVzLCBJIG1hZGUg
dGhlIGNoYW5nZSBiYXNlZCBvbiB0aGUgZmFjdCB0aGF0IHVubWFwIHBhdGgNCmlzIHByb3RlY3Rl
ZCBieSBCUUwsIGlmIHRoZSBjb25jdXJyZW50IGFjY2VzcyBpcyBhbGxvd2VkIGluIGZ1dHVyZSwg
dGhpcyBjaGFuZ2Ugd2lsbA0KYnJlYWsuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

