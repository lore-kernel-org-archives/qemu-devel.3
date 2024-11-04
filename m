Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B7ED111B3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 07:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7rZ0-0005yf-Mh; Mon, 04 Nov 2024 02:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7rYy-0005xr-EC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:31:48 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7rYv-0006RX-V9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730705506; x=1762241506;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wfUwhgZd16mWjWeUPc8TcA1W1ubzYkOLKZk0S216A9w=;
 b=hTLte61tRfQTFYvcYjROHPzE0BKvAQi7DwNVNn8KAZGr8tK2dYHJIpz/
 aDnAfPRtdgBSrwC80jcwEcOQRFs9lszCNCGjZvGws5sQeV+1NSLnJ/Jvr
 HDDwCEpkPX//5biw2Puc7L77ON+j+4Vop4DGPO4mXK8vRJWfIfSnQ1Xli
 ddc8uFlaQ9sODNxPWYQ0oo/PsVPwJloykwox9H+SSXOOx4r6dn/5EubOL
 nSeaLcenDFobLMuOzPGLWh/7NHnnRykm53Jf2xFb103Msxxc+OXnR5xsw
 RhSSmp4Fw4VTuyyD6grp4VRCWYWl8+71RpvWAVZdYxnEfPDRfgqAyKFcr g==;
X-CSE-ConnectionGUID: W0d96kEqQv279VTcLUSCSQ==
X-CSE-MsgGUID: fOwaviFxTbe5ZLstauyg7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41494900"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="41494900"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 23:31:43 -0800
X-CSE-ConnectionGUID: hSUXWWj/Qj2dm41nQG3T3w==
X-CSE-MsgGUID: TFbpLNIAS5qSJAkgYq1JyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83682127"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 23:31:43 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 23:31:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 23:31:42 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 23:31:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xa3wX8G0mAkGu7oyU6dZm22L5mYum3o2Hr1i3dwUcUPFkmE4nIBI2ghvJjySRBZHXf7hw0n7OioIxPo95bc090nphS+KH7pCH0JE0r8csN3znttLa/DR79NjetLotRldy3ubptGBeqtg0l/KVVeoTm36QBimPeQINACtbDQlSTxme49UmMC+8wsCFRTsVK0cEVQ2dCnnJNuDeYoa95Ov3uXYVWDQBR5jfISp9e3s6nF7EFxP4wDOv33EyBZaMcFHMAcZtgEv1ECJT6gPU8XJjbkvfc5jffwCgMqLI3VskBBPp+gN7aYHHj/YAfTgdS2fU+bzG93b1a8LeDbL4PGFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihxyRlmoYcq3bm2o0/E55giGX5rtjUPyMWiQtf6Zz+Q=;
 b=dayW7KJ6d1ybqZYbyjwW3iWA5hpYfUt04Y7fytaJiXLE4uAh1Av1hLl+emjtyrD2f1eRSPtEaiyv6j2oUwqgK4nHjyvol5gu0zQIPOdiO+sFNahtoGHnhJNtMmg1A7MwDwMPRrfPnJDRwtcUiZ/0Ws6EaR5FW1x7qnuG74hqX/QkNfdgSi/2HOuj89k+M4yGWLtXv6ACPBZ1rbzL8Z/n8/4qe7olJ5/l75KR+k8MErmXXPRaunL/AspdCjWfd7mOxq101oMDvJFHtENTAH0hbBrCIHvRrUf7629f3IKGa/ncSs1ykUQHN6nz/CiAWjh+faLJQtfcz+TMY2Ru1ssgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB5922.namprd11.prod.outlook.com (2603:10b6:806:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 07:31:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 07:31:40 +0000
Message-ID: <f89e59d6-a1d0-4886-8ffc-50b2705b1c19@intel.com>
Date: Mon, 4 Nov 2024 15:36:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-10-zhenzhong.duan@intel.com>
 <39a88bac-ce24-49d5-a6e8-9553a48983a8@intel.com>
 <SJ0PR11MB674468C8BF05B3571B893E9492512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB674468C8BF05B3571B893E9492512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b9ae96-6f7e-4ba8-9d4d-08dcfca2b8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2puSXZzVTBWQ0svT1AvQ3dtSnMwOGNQemgrc2pzbWUyY2VZS0hrSE1mZ1lK?=
 =?utf-8?B?NFYyYi9xWHVXeTQ1RnB0SjdzVWltOEtUeE9Kd01CZGhlbEVTbnNMZ0MvQ1A2?=
 =?utf-8?B?VkltK0c0KzBNeXF2L1pyQkdNT0JHZHkxWTdMT1kzdGQvMVJNQU1xMFp5Vlp3?=
 =?utf-8?B?ZitPT0piWXM2Q1FmOFNJM0Q3SVFKK2cweVRPVmxieUE2bS96UThTUGlZeVFt?=
 =?utf-8?B?M1VvWFlyRE0zdnh6bmhiL3dOV3VOeCt2OXEzc2RMMWJXYXBuYnhlb2VqdCtH?=
 =?utf-8?B?SmNLTXdNWmFnK0FFQWlmZGptb1hVaVhYUTlKdk0rUmlNT0tYbmd3T1EwckZ2?=
 =?utf-8?B?ekFROTc5OWlyZ2lzZGxnbVgrbW9rNm5TQURIMkFmRE5mLzZGVDFEbzM4RHN2?=
 =?utf-8?B?TVB6bDJuN2FmZVpxT28ycjdINW1JQm80cFFYd00xRXQyU1N1c2xnNDRHbnZ5?=
 =?utf-8?B?RnFJclluS1VoZHRYNmNCR3owRXNhSnQrb2cyMm5zMHlQTThBaVkyaDhqdlFM?=
 =?utf-8?B?QUEzRDQ1eEpodlBXMnNMcWZWQmEybnB5Y1UzL2tuYXdCYjR3NVh4VzhSN1dG?=
 =?utf-8?B?Nlc5MjMyblMyam82QnlLQXpCaGtRZkZlOTg3aHlZbmRhZEplM0pwSW9lNUl5?=
 =?utf-8?B?Um41ZmN2eTVpTG54MjdKMFhVV3YyUVpORWVDRUJFR3A1R1NGbnJESSthMnNK?=
 =?utf-8?B?Q29ZbzlydUoyY21lQnJkQWVKK2hJbXVQd3U4eFVhQkdiRVpCT3JpVHcrZlRk?=
 =?utf-8?B?OEcxQlBHa2pLYlJTUW5zdHoxQzhjbTlOb0RDV0xSalBBeS9DK3ZYSVYzOEtz?=
 =?utf-8?B?eWJPUTRWVHljd0MzR2xmOTFDNEJqWEVsU3VRWHdZeE8wek0rTTJmQmZabE9r?=
 =?utf-8?B?REdobVkvR21sY0MyRGJEUmVTMnJQSGFZZDRNMzVEVTd3UWJCbFF0QXBGODFC?=
 =?utf-8?B?NDFvdzlVSTMzY09WT1h5b3IvVHNXVUdkM0h3dlFGL2swZHZCN0dJcDRNUHJB?=
 =?utf-8?B?L2ExZFRveDU2dE13RjhQRDBYZlFIYW1vWDdlTlZTczc4bDlLa1Iyczg5VEYr?=
 =?utf-8?B?VmhVVmJYc3RaemxCOW5PYm5zMG1nS0N5bGpJT3B3N3JYNzd3ekNaUFZnU1BT?=
 =?utf-8?B?a2xwTE1hOFhnMFJuRU5wZFdCeEF5SGR4TDBkRXQzVTBmRmtqRlFLTVpkNVIz?=
 =?utf-8?B?Ny8rVkZmK281eUsyV2dpTjZlWFY4S1JBb3hnYUxJdzB3Q3pjdnZ1dFJZeVJC?=
 =?utf-8?B?cnh5ZGdxTm9DRjFuNkF4S0I1emxGMVdVamZXTXlzWHVhdTlDSExlUURnd002?=
 =?utf-8?B?Q01oQlY5M1FrQmJDdWIrMitsZC9xNjhQb0t4TlZSSVZ5dmlKdUJCMEFBSytV?=
 =?utf-8?B?U0hDbzIzTTQ2ZmFpdjQ1U0RkZk1wQkgzYWdvT1R1RmFidlg0dW1UM0NSTFdr?=
 =?utf-8?B?UHlSUS9Qejd4VVBLeFpicmV3M3FWdFFIWFgrZ2dsTFhTTmdtTWJ1cTJWTmZY?=
 =?utf-8?B?LzdWMFhvRjU0RFUyZ1JjSTZveEFZbkNrTjhydkkzSEhYaXJuQ0MwSW1MZmN0?=
 =?utf-8?B?aS8rQUlsNmlGc2QzenY0MkhtUWlLQ01uYXU2aW5ML1JSMlZHeDhwMUtSdWpX?=
 =?utf-8?B?VElLZ2xud08xTmozTzNwNTlHWXZlSXRZanpJS2lmbXRGVnFpczZkTHg4eHhk?=
 =?utf-8?B?N2F0eGxhQVV1L0FoMVBIVURlV2RNeGtmdThpejMxM0tuWG9YTHI0RW5yRWNJ?=
 =?utf-8?Q?FIY+c2H5J9Y5gjQhOM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHpvYjBLZzBUUUFHQ1E2TzdKbE40WVcwRWZiTzFjMzdyVi8xb0RGMlRiOFRr?=
 =?utf-8?B?Mm8zNTl1SE9XZCtEVTFGTGJIdTFlV1hJV3VINHg1RXlURGlRMDlLeWxkSG9J?=
 =?utf-8?B?a3NZZ3dMazlmQXFvZHJtV3UwVDUvWHBicThQUGJxTmFFcGE1UGE5aHdpeURS?=
 =?utf-8?B?NkVaRXhTckRUYjJlVWFVZGJOZzkzYmpGVlBjOU5sRlNQOVNHbmFvWktEUHRq?=
 =?utf-8?B?M28rWHB1eFRGTG9LMitWSCtTRGszcnNiTmprMHRSNWlHUVJuS1g3TUdHUFFu?=
 =?utf-8?B?SlBkQi8vTHlmeFowYUprOEFFWDZsYjA0cmthdjk4Q1U2QUY5TnhXbHpjMjY2?=
 =?utf-8?B?UEVENmlxYVk1UEZoMjY2d0NpODFONGluUVFoeEZaQWJQaCsyd0JRSlNpczNV?=
 =?utf-8?B?MEdmM0xzdkhKTTdCb0c1TWdHSW5PNUF1RmZrRDRQYi9OdE9WSWhmOXIxanBB?=
 =?utf-8?B?YWRRM2V2Qnp3c3dxSlFPNEF6bnovU0p3S3FaY3paL05nOUwzM0VwaFVNbEFp?=
 =?utf-8?B?cSt3bkk2aXpYeG92K0J1THFac1ZzS0FMTGlzMFFyRVVRdWwyVXZCRnJCQVUw?=
 =?utf-8?B?bzJ0V01Way9TSE9GQTd0bHNlbmlZNjBFYjdvRGl6SGpJS2lRbnNmM2FIY2Zw?=
 =?utf-8?B?NFA3OE5KRlZpV0xObkMrM1V5NkU4bFZSK0F0SzZWSU4vQ1pzdXpiRjJmVEt5?=
 =?utf-8?B?dGJ1WE9abmRxWFJ0YlBQRnZFaG9DVGRvcnFwbGJpakVVZmxoUUlWKzVQa3J0?=
 =?utf-8?B?T2lCcSs1S1hjcVV2WGRlZGdFQ2krRUpIOTRuUHpzVlBsYTRsRlRqUmRibW4w?=
 =?utf-8?B?YlR1RDF2VEVGMm03dXNGVE5WRHV6bVpCaCtEQTEzbjdzSCtRM3ZIc3ZkRGI2?=
 =?utf-8?B?UjdYU0xFQ2JtTlpuSXIyZ3VtQUl6anNVaWlmNUMyMkU2T1lWRDE1NWlGcUlD?=
 =?utf-8?B?THp4NkhBZnkrMFdpMlR5TlF0a0lXYm9EVHhpNzNyM0I0dHBkeWMrb0duSVVY?=
 =?utf-8?B?QTdqdG1vWHIzWVNRVkFaSFhjVHVrbTBBR2hZdWQ0YUdqaXFSVWJFRTQvTVBl?=
 =?utf-8?B?L0I2eVBkc3pUQ3gvOFVqVGpnTXB5Nlg5YzNPcEJlbkRrM2VMNXNlYm1LdG1Y?=
 =?utf-8?B?MjU2WGtnVXJpMUg2QlV2VFhsQ3RabS91WFBzRDVTNVdWc0trN3ZZRmNYQjBs?=
 =?utf-8?B?R2xJRGZqczZZbVJ2bk00NjVybjBuM3ExT0dqNWIvMmxsVXJnd0ZUZmZoN1Ar?=
 =?utf-8?B?d1dYQTlsYmZ3V1FxclRRMXB6b3B6UTBzR0lmekFyblJFNmsxRTlSMkNaajE2?=
 =?utf-8?B?aFFkQ0k5WnpGUndTTXdZdFRSRDBxcE9nTmZOU2hhK1pUWFY3OUE3d2l3WURj?=
 =?utf-8?B?VGRmYThIbFkzN2FTQnBPOXpLMGxhN0JETmhIcy96UzhldjBKbngycmthWDU4?=
 =?utf-8?B?TTdjMmpReEFQR1RYNDExVmJNVkNxL1NWdFEzeUJhVTNrY2JDWlV4UVI1eFBP?=
 =?utf-8?B?M1BtTlNHdFNib3gxckRPY2dYUDRqU1pDVkNNMFJvRjlaYnZEVkdOQ1lldDRh?=
 =?utf-8?B?SXRnZlhXVnZwbXgzcmJXWnFhdDNBNDlnRjZJOUFHSitXT2haanJMT1ExSlJ5?=
 =?utf-8?B?a1VOdGR6OTJkNXpCTUMvZGFzcDFNelc5cnVWYlB0VkMyQ1JSMkROSlNhYm1G?=
 =?utf-8?B?WGhIenl3MGdXUDRPc28zOFFqc3B4S20yb1Nndkl5aU16N0UvVVgxQTZNL0xy?=
 =?utf-8?B?NjNud2p4a2RURmFqYVU2NVZIZkZRR1hWa08zYU5WdVpXTGZaZkFOcDlEUnFq?=
 =?utf-8?B?dFlBeDdTQUlLbGJ6aUlrV2dNVGFsaWJLOGpwZC8wS1J6Q2pKc1BpVHNvMk81?=
 =?utf-8?B?WVJzRGw3UkRVQ3NYalJrYW93ZXI3YTVQbDdGRE5nc3dmSjluZ0FJVTBpMTVL?=
 =?utf-8?B?R0JrZjV0UHRyTUkvTG9Vdm9YUlZvUEM1T09NSjdRZlVIZFFSeEVNU2tVaFZM?=
 =?utf-8?B?ZFM0M2hSUTdLY0dCSUdOT2JTbUNrc2p1QlN2QTZzQWxkZ1dzRldIT3F3Y0Fv?=
 =?utf-8?B?VzhYUXhTZXhZazlPcnF4QmdpUGxUZXVvc1RTblk5QzgvbitsbVM4QzUzVjMy?=
 =?utf-8?Q?4mDrSKh/4dTyP/MHthI0iAAyu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b9ae96-6f7e-4ba8-9d4d-08dcfca2b8f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 07:31:40.1235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjhoGdIANVDb6Qml2NWEfkNs9ghfChJU/GgsQDLwEsebgmnHp1h42hdnYC5g8mDiw5CLrUI1tn8GRqO0rJwvJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5922
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2024/11/4 11:38, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, November 4, 2024 10:51 AM
>> Subject: Re: [PATCH v4 09/17] intel_iommu: Flush stage-1 cache in iotlb
>> invalidation
>>
>> On 2024/9/30 17:26, Zhenzhong Duan wrote:
>>> According to spec, Page-Selective-within-Domain Invalidation (11b):
>>>
>>> 1. IOTLB entries caching second-stage mappings (PGTT=010b) or pass-through
>>> (PGTT=100b) mappings associated with the specified domain-id and the
>>> input-address range are invalidated.
>>> 2. IOTLB entries caching first-stage (PGTT=001b) or nested (PGTT=011b)
>>> mapping associated with specified domain-id are invalidated.
>>>
>>> So per spec definition the Page-Selective-within-Domain Invalidation
>>> needs to flush first stage and nested cached IOTLB enties as well.
>>>
>>> We don't support nested yet and pass-through mapping is never cached,
>>> so what in iotlb cache are only first-stage and second-stage mappings.
>>
>> a side question, how about cache paging structure?
> 
> We don't cache paging structures in current vIOMMU emulation code,
> I thought the reason is it's cheap for vIOMMU to get paging structure
> compared to real IOMMU hw. Even if we cache paging structure, we need
> to compare address tag and read memory to get result, seems not much benefit.

never mind.

> 
>>
>>> Add a tag pgtt in VTDIOTLBEntry to mark PGTT type of the mapping and
>>> invalidate entries based on PGTT type.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>>    include/hw/i386/intel_iommu.h |  1 +
>>>    hw/i386/intel_iommu.c         | 27 +++++++++++++++++++++------
>>>    2 files changed, 22 insertions(+), 6 deletions(-)
>>
>> anyhow, this patch looks good to me.
>>
>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>>
>>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
>>> index fe9057c50d..b843d069cc 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -155,6 +155,7 @@ struct VTDIOTLBEntry {
>>>        uint64_t pte;
>>>        uint64_t mask;
>>>        uint8_t access_flags;
>>> +    uint8_t pgtt;
>>>    };
>>>
>>>    /* VT-d Source-ID Qualifier types */
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 99bb3f42ea..46bde1ad40 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -305,9 +305,21 @@ static gboolean vtd_hash_remove_by_page(gpointer
>> key, gpointer value,
>>>        VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
>>>        uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
>>>        uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
>>> -    return (entry->domain_id == info->domain_id) &&
>>> -            (((entry->gfn & info->mask) == gfn) ||
>>> -             (entry->gfn == gfn_tlb));
>>> +
>>> +    if (entry->domain_id != info->domain_id) {
>>> +        return false;
>>> +    }
>>> +
>>> +    /*
>>> +     * According to spec, IOTLB entries caching first-stage (PGTT=001b) or
>>> +     * nested (PGTT=011b) mapping associated with specified domain-id are
>>> +     * invalidated. Nested isn't supported yet, so only need to check 001b.
>>> +     */
>>> +    if (entry->pgtt == VTD_SM_PASID_ENTRY_FLT) {
>>> +        return true;
>>> +    }
>>> +
>>> +    return (entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb;
>>>    }
>>>
>>>    /* Reset all the gen of VTDAddressSpace to zero and set the gen of
>>> @@ -382,7 +394,7 @@ out:
>>>    static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>>>                                 uint16_t domain_id, hwaddr addr, uint64_t pte,
>>>                                 uint8_t access_flags, uint32_t level,
>>> -                             uint32_t pasid)
>>> +                             uint32_t pasid, uint8_t pgtt)
>>>    {
>>>        VTDIOTLBEntry *entry = g_malloc(sizeof(*entry));
>>>        struct vtd_iotlb_key *key = g_malloc(sizeof(*key));
>>> @@ -400,6 +412,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s,
>> uint16_t source_id,
>>>        entry->access_flags = access_flags;
>>>        entry->mask = vtd_pt_level_page_mask(level);
>>>        entry->pasid = pasid;
>>> +    entry->pgtt = pgtt;
>>>
>>>        key->gfn = gfn;
>>>        key->sid = source_id;
>>> @@ -2069,7 +2082,7 @@ static bool
>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>        bool is_fpd_set = false;
>>>        bool reads = true;
>>>        bool writes = true;
>>> -    uint8_t access_flags;
>>> +    uint8_t access_flags, pgtt;
>>>        bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
>>>        VTDIOTLBEntry *iotlb_entry;
>>>
>>> @@ -2177,9 +2190,11 @@ static bool
>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>        if (s->scalable_modern && s->root_scalable) {
>>>            ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
>>>                                       &reads, &writes, s->aw_bits, pasid);
>>> +        pgtt = VTD_SM_PASID_ENTRY_FLT;
>>>        } else {
>>>            ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
>>>                                       &reads, &writes, s->aw_bits, pasid);
>>> +        pgtt = VTD_SM_PASID_ENTRY_SLT;
>>>        }
>>>        if (ret_fr) {
>>>            vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>>> @@ -2190,7 +2205,7 @@ static bool
>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>        page_mask = vtd_pt_level_page_mask(level);
>>>        access_flags = IOMMU_ACCESS_FLAG(reads, writes);
>>>        vtd_update_iotlb(s, source_id, vtd_get_domain_id(s, &ce, pasid),
>>> -                     addr, pte, access_flags, level, pasid);
>>> +                     addr, pte, access_flags, level, pasid, pgtt);
>>>    out:
>>>        vtd_iommu_unlock(s);
>>>        entry->iova = addr & page_mask;
>>
>> --
>> Regards,
>> Yi Liu

-- 
Regards,
Yi Liu

