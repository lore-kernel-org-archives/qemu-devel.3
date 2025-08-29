Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4C0CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3M-0001Xf-5B; Sat, 30 Aug 2025 10:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uroKm-0004qK-NB
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 21:55:20 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uroKY-0000jB-13
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 21:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756432506; x=1787968506;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RRBZjkGSbL+UGFfHyl8KRqZTtDyHQEnMqCjnryp5e/0=;
 b=cxLEjr2sxOj0yRSiUuXxor86fuDAxo2BI5Zb7SZKxn+pmt/cRkeb3nH3
 E+6I1idAABOqbrrVainONyI9emKMJBg0eTDqydrnKAgeAZxDUXxIfjTza
 41JiXzUNV+vVyCKc89IQdMBW4V4UVwnq8wK/unxO/2Kmw7Gn63iU+agAd
 4Vej6M64hi6alDm1Dv2gINKmvx5rR1qHrrIewdDjk/Y0DjQ/x8FOg+jwu
 ApSwaZZKQ1Xo5vpil9pHrpPfFTCvfYE9ojZTvSixRahzL5HKrziSI3VQh
 I2T+MBvnJkBeFXjN+v3U5rBW11MYFqCLOHBihyzvLuPBWm3aEoN5QUiZk Q==;
X-CSE-ConnectionGUID: oRZVTTd+QfC8cYNkJzBIkw==
X-CSE-MsgGUID: 1R9zQ1OsSbi9FSCmS7EI6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58425816"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="58425816"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 18:54:59 -0700
X-CSE-ConnectionGUID: P7rfr/JoQda9EOrp8C/WqA==
X-CSE-MsgGUID: OdsNlTsGTEyFoCR4b+Kicw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="169788775"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 18:54:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 18:54:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 18:54:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.79) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 18:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2+ForHH4FrX+zMooMdfksfUR12Ly9lugJlaqwy+Dzb9qfvA7pAwcCDURCAIwVf8aUjXG0Z9eslSreC6XtStORjp+kxJXzW9/oWzURUqBEgh8ThA+Xnwp/wyVVwhEVMeo+qKcc7ffDkx73NK4joDgSGJL2/ANnW8dQaPGavM2a0vxuZtkMlOGjm/9iTdx4/ghR0RLX1erT2ViTrgSWRzPRjSsLwevr4Fo/nhnQpAHv7tvLisRnaKHN6Q4WmZT1Turn+zw1LzgiKe+Zf11use58jlskklhCAGnrUsmGXiXXLC5neK9oykEoWfUHu/HCzXSLzb76ztqlbrndCwS/2icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRBZjkGSbL+UGFfHyl8KRqZTtDyHQEnMqCjnryp5e/0=;
 b=om6Mwq7c4Q96JJljYD4gGGcfx5rbh2JMkfqjYNAFe1UFTYM6ls3xYV4YKGLN3HRF2lxhvuq0AFNDMcuDxdmteDjNpTI22apxDoUUHSDN4jWNqho3e9mQTgz3wGeervaWf5lmXFIWECIWHCa8IBr+BTxuLDGt3pOuGrctGOx8fXR2Ta15Hxl/c18vQYRRNHsQY+VfcwnaEk4g+AIhTcL0KC9c/NIU1rK271eT83iNEOh1oYeMXwWCbNW2Ap3RhoeW1IFRXCwHcnAuRv6WSSMcnXUQt5U1/eBF7PAUV584BmN3v49HhiEeTORn1Z7SVLiqJ6duUa797f11Jcg/LQ7yDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 01:54:50 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 01:54:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Eric
 Auger <eric.auger@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHcEy/SWdP0XuMIEEmlrKJvbaEB37R2YPIAgAACfoCAABL+AIAAAI8AgAAxxICAARvqgIAACdtggAEaboA=
Date: Fri, 29 Aug 2025 01:54:50 +0000
Message-ID: <IA3PR11MB9136978139DB0DA6A2A06C82923AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
 <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
 <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
 <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
 <153e1475-6678-415c-86bf-b7251cb59f3f@redhat.com>
 <aK8kqQOV28V36wtM@Asurada-Nvidia>
 <ecd95fc6-ce8f-484e-b685-d78a382f1705@intel.com>
 <IA3PR11MB913632FB83D138289BB718C2923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB913632FB83D138289BB718C2923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB5216:EE_
x-ms-office365-filtering-correlation-id: 99cfd840-f76e-42e4-8442-08dde69f0a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UHExZlNsTXBqT2hkeXdnRzVsUlh3SzBISlZieGVlSUVlOGNhVmUyYmtiaDA0?=
 =?utf-8?B?ZkNJeW9QTlVJdkNHR2NUZ1ZNZ3VWcis0VnVmMU9hN0FOTi9SK3BMYmhiZTVt?=
 =?utf-8?B?bW02cVZlMTE5MFNNc1BDanNZVXNzb2V2SkphWW5SZCtYYnR4dVB6M0pxVEhy?=
 =?utf-8?B?QXcyV3dHWGhxUEQ0V1NZOTZGekpFenZsc29wb0xCMGxoMmQzN2NYUFYvYnhx?=
 =?utf-8?B?YVpIOUdIVklFTFpaZ2p0Vm1lZmVaeDNtbDMwdEFXTUJZellHK0dkNzBTaWRU?=
 =?utf-8?B?eG5DZGE4M0dHVERZaDRpeHRyUWRmWCsxaUNRcEVuU3ZnMEZJcjZ3RTV6bGli?=
 =?utf-8?B?MnZ4RVF1L2hXZFpmdGcwRS90NVhNc0IybEI3SXVnbWFKYXRlU21iTGFDeWdq?=
 =?utf-8?B?Unp0SFgvREF5QTBrUnRYUGZlT3djb2YwdktEV0JObWwrN0ltbTQyVnQrK2g1?=
 =?utf-8?B?eTE5ODVDeE9hR2hTdWdoSFhyUXBsNlVQZWxKT1I5RER6c09uRGVsTS8zQm9Z?=
 =?utf-8?B?dWtpbngzM0pKM1dmelBCSXkwWmN2MzFVbCswN3BmU0R3UENFbHh3SloyZ2xv?=
 =?utf-8?B?V3lQeHNNTHBjUGxiMUxITDUyY1JneGdMaHBLdzBPZFprZTVqVzdBNGdVZk5D?=
 =?utf-8?B?S1hrU1puUXQ5MVJuSTBRWWQ4V0tmWHArRUdVWlVMaFVVSTZtRG9Scm1UZVVn?=
 =?utf-8?B?d1dqMWFMRUZlanlUdDFLTGM1b3gyMmhjMGxPcldrc3hMakRJNlgwejZDT251?=
 =?utf-8?B?NWxGNmU4MFFSTmF2ZDExUFp4N2I1T05Mb2JoM0RRaytBMk9vS216eS8zT1Nm?=
 =?utf-8?B?bkVuUzhPdUEwODlWM2g5TSszV1VvV091V0dpYU5wQ0xlcGduUnZmS2dwcFg4?=
 =?utf-8?B?U3JzUmQxYVB6Q2s5NS8yY0tCRjhXRGhFZDRVbE8xbmtDcVpGY3RzMXNZZkNR?=
 =?utf-8?B?QVgvbEtHMnlidFdIeDM4N2hVTmZmMUFTMnhqcFdVb1ZiUkQwWGNXWGY4MXFo?=
 =?utf-8?B?dEtFLzhiZHIxc3h1V2xFN0pVbnhGQlVNRG5ORlRZbEpTbzBhTWJWaHMycFdh?=
 =?utf-8?B?NkZQVVVFdDFaRGc5NityMDl0OFhzVS8zS1JrTm1tbVhzQkE5Rm9mZ3hXUHpp?=
 =?utf-8?B?KzhOWDFxWU5tTlBoaCtlZTdOeXF2R0krMmFtMWN0bHBPVFRJTGxKcTFxMFFk?=
 =?utf-8?B?bmptaEZsMi9tVXVSL1dtd2Y5eFVDSXNTU0FiR0dpSEJYOUxSZ21ZT3ZNcVI4?=
 =?utf-8?B?MFpEb3VhenUwK2NmajVPU2M1TWVGLzRqUlZubEtoRnNkWjNYUi8rVUxFZU16?=
 =?utf-8?B?d09XQjRRZXd1Y0FjSmJBSklRcmFlb0FLay9zbjQySTRTTndIOElsTDVvSVps?=
 =?utf-8?B?T3RnUTdsRjlqSGR4aHRYZjV6cThXMHZWeUhZVTViSFQ4bmg2a0IwWE5Fdi9U?=
 =?utf-8?B?UnFMeEp5ck9yTVNaOTZWeDQydFpYZkR2M3dhakRlMXpNWEVhMVNiVFlOdG9s?=
 =?utf-8?B?MGs2RUVPL1hhTTZYZzBZMDZPRVM1MGcxdlhWT2J6R2JqZnQ5M1NKVEFiQzFD?=
 =?utf-8?B?TGRKUDcvZ1RtYkZyQUV0Z1BnZm0wenZRaFhOMXpPYXZwdElJendJckpmTlA0?=
 =?utf-8?B?dHpwYWhma3VrT3QwUzhMbGdGMENaMkxkRDJTYjNrNEVxbDFuSHVEYkVxWkVV?=
 =?utf-8?B?bEM0YzNNc0l2THdtemNjZ0QrYjlZUzJJUXVUQ241ZzZzZlpGbW5wOTg3OGlZ?=
 =?utf-8?B?Y1pVYnNBVGFCQzIzU0FDUlpSRGJ1UWJTcEl4RmVnT0ppSGFoVGZUT20xeVV6?=
 =?utf-8?B?QzNTZnY4NUY4N2hzSVZUU1VXRmlOQk5GQlNsWVhQcVRvZUVlWVdKeE81Nmpo?=
 =?utf-8?B?cVV1ZVhueVh1blRoWnMwcFlWZDlKSjVUcm1lYzhRbVRzK1lLS2FHRmRvZmdo?=
 =?utf-8?B?aWxGbHVGRXZteTN0a0RETlljWXU4TkdZdUppdVhrY2tJV08reis2WmVvK3By?=
 =?utf-8?Q?7VMJmO123h+3TtkELjFtg0f1xV8FR8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjBIQko1QU9aVTVFeWtoVVVtSEdJcVgrL3RKSTJMcTR1dC84T3pDRTJ1ajdM?=
 =?utf-8?B?R1JtaE1zem1CbVN2ZTlUVG9WMWJRK1VWNzJLREpWZDA4dGtZb1ZKN2l5RDM3?=
 =?utf-8?B?blFBM0M5ZThpeGFmbjk3Y2RZYkhLNEh5d0RUQzNzbUdqbzFCTVp6T08wWEcr?=
 =?utf-8?B?QVlKQ05aMkRIUW9DcmdxTXNySlpES1NrK2Nta1RGLzJUdXhRSEFHTERMdDBS?=
 =?utf-8?B?RHhwNFg1QTRWRWZNaWc2SVd3OHlCTlBMWkFnZWNSM1B5MUNqYlVaVEw5MUxw?=
 =?utf-8?B?VG9XTkl4dndQU1JFRXhmdWQxN3Z0UU5CQ1ZBQWhkeXI5NTJxdkRDamxPdmIv?=
 =?utf-8?B?VHB2Ykt2eXBoZE1tRm5lUzRPQ0FPeDNLRGhuekxWY1pWWjlUamRmaU8yeDhL?=
 =?utf-8?B?RlBCU2tGZ1M2SjFFdzNlcDRJNVQ1SjRtWGZ3US9meXc3dUQvM3lKWUZYZzNq?=
 =?utf-8?B?bU1GRG45NjcvL0JsRklZcEtNdzZkV1lpMjdSaFhOcm5Ea3RVZWxLazhYY211?=
 =?utf-8?B?SkUva1BFUG8vdDJLL05CUXZrUkVTY1hKSU9iM05SUVoxRjQ5U2FOU2lwWWVp?=
 =?utf-8?B?WmpuRkhFWXQxK0Q3Qk9HOXhsQzh6TEk0MTc3Rk11T2pndSsxbFh0Q1o5UEYr?=
 =?utf-8?B?U2FadkE2YjIyd20xS0RDRFVjNGhZaVZKYitkMjB1cEtabkgrQ1F1OHd0U0pr?=
 =?utf-8?B?TUphOWttdkFSc1c0dmlGbzZ4VXZ4S0tnR1lpVUlwRlZlNkVQSjh6VFFscmUr?=
 =?utf-8?B?TjcyUFpQTDhTbFpXSlNPWVpldjVOZ2xLSXd3TGdjQi9JQzJsRzRzMEZaRm5v?=
 =?utf-8?B?Y0dwN3RFYXpSb1QrZzgveUZ0UUVpWlZ3UUJSaWgwcnZCU2wzKzNLbHVkZFMw?=
 =?utf-8?B?aC9MZHZKa25MeVE5WG9ZZEc4enJudGxhbWZaTHpMN0JnUGxlTEZudkVMSmxR?=
 =?utf-8?B?SlY2TFBZWC9FaE1nTTRERFBPb25lV0RDYUxWSGRLSUxSenRGMDZYT1dBdkR6?=
 =?utf-8?B?My9IQ1E4TTFodEE2Wm13U0owUTFKUHVtUERMQlVZcWpsTURPMzNlM0FGbnNp?=
 =?utf-8?B?SGpCMHhVS2Jya3lCVyszTm56eFUwd21WdExtVHhhREVzTnNMNmc3R0ZGTHBu?=
 =?utf-8?B?RTJGRytwbStkWXQxVUxwTnRxb3Qwekp3TWdKY0swUTgyMURhc3lZaGpJZGJr?=
 =?utf-8?B?MXUwMThuUXVkZVB0b2VHZEd4Rmh4Qk9wbTJZVnFHSjZMaHpaYnoxN25HRHVF?=
 =?utf-8?B?dzQ0NzBHdjkydm9mcE9VeWpZWEdNdk4yZnhaRWFPemVRMzNXZEcwWWRWSXpH?=
 =?utf-8?B?eVA4YjJ1SlJJSDVJaUxaREFNMWR0S1ZzSjNMNHhWWlZpelVCZXlnY05GcEh6?=
 =?utf-8?B?TVMwTjJnOWF2Vmwrc1kyMm9VbHBNSFZ2bHk0ZG1JcmlGQUpXbzZwUzhGcTRn?=
 =?utf-8?B?SmNhcjMyWXVlZWVTSTJvZytKWUtnc21yTVNrcHdzVURRS3k0RFVrSXJYYWFR?=
 =?utf-8?B?UG9KRCt4OUFQQTNlb1FVSXJCR0tqQW1NWGNpc1pPeTBMSEF6b05YaHVEK2xU?=
 =?utf-8?B?NWdOVUxReGNWL01yc3NtckJGZkFuRDA4UU1WcCsrZHlES2RiLytRM3dFOVdq?=
 =?utf-8?B?WFEwbzVZelRodDhYZnBXclpTZ2RpT2dyTGhiRTdxWVM4ZGw4VndKN1pHMGl0?=
 =?utf-8?B?MTl0NExMZmZhYkw3T0ptWVhyREZoM3doc3lYL2czaGszTUQra0xwNU9raUNO?=
 =?utf-8?B?SjJXQVdXNnV5WU5tM2p5WHo1VFlNSUo5Mlh1ZTU5Ly9LbHJRTTU0QjlYWlVa?=
 =?utf-8?B?bUpDRXZpOXBYYjhPb0ZmVUVzYWRYbWRIeGdSNjlJL2lsNHBBTWVjVEMydkhX?=
 =?utf-8?B?bzEvYW01ZEdPL1JydzYzd0wwMmRZWU1xZ2Q4QVRaYUtZdVJSbnlwTlY4REU1?=
 =?utf-8?B?NWkwSmY2K3MweHVHbXFVYVF5SXZKaTRMNndsaU5rN0dJQjdhaktkWlYvcTVU?=
 =?utf-8?B?ZTJGTDVxZkxQbmYvOXVUOS80cWNiMXYwQVFZaC85aEMrN1EwUUcxY3R0eEF5?=
 =?utf-8?B?dFcwU1Q1b0M0dGgxSDZrbFd0MDlTbStpdkFrK29CejhLQ1JpVHp5NDlibGE4?=
 =?utf-8?Q?gYOKLeb3zNbh99zjz7oylwMgS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cfd840-f76e-42e4-8442-08dde69f0a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 01:54:50.1388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIGRVQrr72sutMV4gTgM5OY6g3XewHh8bVrjTRHZDf49GHb7U6hrTuTNLd/yR/dMq5mdH+QyKc8YUBoBGgCPrFXo5Lp+4q6a8QdC5c59IAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5216
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRHVhbiwgWmhl
bnpob25nDQo+U2VudDogVGh1cnNkYXksIEF1Z3VzdCAyOCwgMjAyNSA1OjA3IFBNDQo+U3ViamVj
dDogUkU6IFtQQVRDSCB2NSAwMi8yMV0gaHcvcGNpOiBJbnRyb2R1Y2UNCj5wY2lfZGV2aWNlX2dl
dF92aW9tbXVfY2FwKCkNCj4NCj4NCj4NCj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+
RnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PlN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjUgMDIvMjFdIGh3L3BjaTogSW50cm9kdWNlDQo+PnBjaV9kZXZpY2VfZ2V0X3Zpb21tdV9j
YXAoKQ0KPj4NCj4+T24gMjAyNS84LzI3IDIzOjMwLCBOaWNvbGluIENoZW4gd3JvdGU6DQo+Pj4g
T24gV2VkLCBBdWcgMjcsIDIwMjUgYXQgMDI6MzI6NDJQTSArMDIwMCwgRXJpYyBBdWdlciB3cm90
ZToNCj4+Pj4gT24gOC8yNy8yNSAyOjMwIFBNLCBZaSBMaXUgd3JvdGU6DQo+Pj4+PiBPbiAyMDI1
LzgvMjcgMTk6MjIsIEVyaWMgQXVnZXIgd3JvdGU6DQo+Pj4+Pj4+IFRCSC4gSSdtIGhlc2l0YXRp
bmcgdG8gbmFtZSBpdCBhcyBnZXRfdmlvbW11X2NhcC4gVGhlIHNjb3BlIGlzIGENCj5saXR0bGUN
Cj4+Pj4+Pj4gbGFyZ2VyIHRoYW4gd2hhdCB3ZSB3YW50IHNvIGZhci4gU28gSSdtIHdvbmRlcmlu
ZyBpZiBpdCBjYW4gYmUgZG9uZQ0KPj4+Pj4+PiBpbiBhDQo+Pj4+Pj4+IG1vcmUgc3RyYWlnaHRm
b3J3YXJkIHdheS4gZS5nLiBqdXN0IGEgYm9vbCBvcCBuYW1lZA0KPj4+Pj4+PiBpb21tdV9uZXN0
ZWRfd2FudGVkKCkuIEp1c3QgYW4gZXhhbXBsZSwgbWF5YmUgYmV0dGVyIG5hbWluZy4gV2UNCj4+
Y2FuDQo+Pj4+Pj4+IGV4dGVuZCB0aGUgb3AgdG8gYmUgcmV0dXJuaW5nIGEgdTY0IHZhbHVlIGlu
IHRoZSBmdXR1cmUgd2hlbiB3ZSBzZWUNCj4+Pj4+Pj4gYW5vdGhlciByZXF1ZXN0IG9uIFZGSU8g
ZnJvbSB2SU9NTVUuDQo+Pj4+Pj4gcGVyc29ubmFsbHkgSSBhbSBmaW5lIHdpdGggdGhlIGJpdG1h
c2sgd2hpY2ggbG9va3MgbW9yZSBmdXR1cmUgcHJvb2YuDQo+Pj4+Pg0KPj4+Pj4gbm90IHF1aXRl
IHN1cmUgaWYgdGhlcmUgaXMgYW5vdGhlciBpbmZvIHRoYXQgbmVlZHMgdG8gYmUgY2hlY2tlZCBp
bg0KPj4+Pj4gdGhpcyAiVkZJTyBhc2tzIHZJT01NVSIgbWFubmVyLiBIYXZlIHlvdSBzZWVuIG9u
ZSBiZXNpZGUgdGhpcw0KPj4+Pj4gbmVzdGVkIGh3cHQgcmVxdWlyZW1lbnQgYnkgdklPTU1VPw0K
Pj4+Pg0KPj4+PiBJIGRvbid0IHJlbWVtYmVyIGFueSBhdCB0aGlzIHBvaW50LiBCdXQgSSBndWVz
cyB3aXRoIEFSTSBDQ0EgZGV2aWNlDQo+Pj4+IHBhc3N0aHJvdWdoIHdlIG1pZ2h0IGhhdmUgb3Ro
ZXIgbmVlZHMNCj4+Pg0KPj4+IFllYS4gQSBSZWFsbSB2U01NVSBpbnN0YW5jZSB3b24ndCBhbGxv
Y2F0ZSBJT0FTL0hXUFQuIFNvIGl0IHdpbGwNCj4+PiBhc2sgdGhlIGNvcmUgdG8gYnlwYXNzIHRo
b3NlIGFsbG9jYXRpb25zLCB2aWEgdGhlIHNhbWUgb3AuDQo+Pj4NCj4+PiBJIGRvbid0IGtub3c6
IGRvZXMgImdldF92aW9tbXVfZmxhZ3MiIHNvdW5kIG1vcmUgZml0dGluZyB0byBoYXZlDQo+Pj4g
YSBjbGVhciBtZWFuaW5nIG9mICJ3YW50Ij8NCj4+Pg0KPj4+ICAgIFZJT01NVV9GTEFHX1dBTlRf
TkVTVElOR19QQVJFTlQNCj4+PiAgICBWSU9NTVVfRkxBR19XQU5UX05PX0lPQVMNCj4+Pg0KPj4+
IEF0IGxlYXN0LCB0aGUgMm5kIG9uZSBiZWluZyBhICJjYXAiIHdvdWxkbid0IHNvdW5kIG5pY2Ug
dG8gbWUuLg0KPj4NCj4+dGhpcyBsb29rcyBnb29kIHRvIG1lLg0KPg0KPk9LLCB3aWxsIGRvIHMv
Z2V0X3Zpb21tdV9jYXAvZ2V0X3Zpb21tdV9mbGFncyBhbmQNCj5zL1ZJT01NVV9DQVBfSFdfTkVT
VEVELyBWSU9NTVVfRkxBR19XQU5UX05FU1RJTkdfUEFSRU5UIGlmDQo+bm8gbW9yZSBzdWdnZXN0
aW9ucy4NCg0KSSBqdXN0IG5vdGljZWQgdGhpcyBjaGFuZ2Ugd2lsbCBjb25mbGljdCB3aXRoIHlv
dXIgc3VnZ2VzdGlvbiBvZiB1c2luZyBIV19ORVNURUQgdGVybWlub2xvZ3kuDQpMZXQgbWUga25v
dyBpZiB5b3UgYWdyZWUgd2l0aCB0aGlzIGNoYW5nZSBvciBub3Q/DQoNClRoYW5rcw0KWmhlbnpo
b25nDQo=

