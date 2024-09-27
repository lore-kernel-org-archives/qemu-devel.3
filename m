Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECB0CEBF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 07:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su5F7-0003L5-JD; Fri, 27 Sep 2024 03:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su5F1-0003Jl-8u
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 03:18:17 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su5Eu-0002kB-BA
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 03:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727421488; x=1758957488;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Bl1g2OoR6QnE7LNarPJ/GWAjChOrcUDJei6EZsNRCgc=;
 b=kX3Sqin8QQv0r2FwNWBKZ/zh2LxIQH0zmVfk1BzJDRtdFhfhaMKJLqUM
 fqKzdiqRAzp13kFpwXsnKa3zkhQTG1LP0XcACnZNWpN3nagQskufpcP4C
 lw5auPkONTwBYhYgzYLlkDsmf098D0wVsn0cofwWc+TKadTcY2fUGzV+a
 NRBqncsy7Vsjxnvpc0m1AHNtfiDqMAGKcMTPMuhzJmzXOOpSVqExkR4sS
 uK12TCAFebQW3P/I0vzZHIIQm6PxvInfBieIL6V17FLcDDU2wTYM59W8K
 iGn5s6j8YGaZsgyF/neK+kyvBDPxkJmMDceePGlxhd8Uy+qTlTzulFm5E g==;
X-CSE-ConnectionGUID: 7htC0JxlRqGQIqg81zgb2A==
X-CSE-MsgGUID: iI4lc6LfR4muFQI+yQ+0RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30268769"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="30268769"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2024 00:18:03 -0700
X-CSE-ConnectionGUID: RC61P230RfG9/f10+LyFSQ==
X-CSE-MsgGUID: Bvg4oPgiT76+LBSkF516xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="72439800"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2024 00:18:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 00:18:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 00:18:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 00:18:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 00:18:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrDB5zaZZrj2l2YbdwT7Ye4OYtZ+6l5M6cYn7ex4tEhZ/VUmHe/imgw+tvDyfzkeMb9sN9ZWSYalqhc0lnJuht7bzZFjIkIUnnwe2snAtuVGYS0Lgjqqi1IkUzPdUVdd7oH92l/zM3IjB4etQvITBg09o5GzzosR2eID6LdtikZUZEmwh8tvv0PCSUUJ0eg69KIxVf6D8pdOiLG0jkQeQdxV8rqEZTIbe/6nTCjSZbmZaahHCoByNohdra1waIkr8e2VoDjw18QfCsZIaoNNu1dINoHLsmw0K8T3GgFOlX+65PdS0mX41yRBSPrBhuAFEwbNFiRMUlAptjNKzj69OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl1g2OoR6QnE7LNarPJ/GWAjChOrcUDJei6EZsNRCgc=;
 b=JZJmjsWrKd89xQsIaJtisZH5wjir1uaoUfssAUlDZVrs1ndpqyi3d00gFqve8758kIjr1xmp+rv7yEgSt+ICg3yiXK51xlIuZWeXSVw3aeUrt1A7FywcrBPdAxHRWSwhnqMt8ormI8xAT2Ilct7EZQ5ghZSRYXmro5s/BlMdRm+NDH4yIG4WGtv2xOuXrMHlpJzsaesEaOMbzs8mvmi07Al40qnkE/FP+DiW0+UAHxR8CRQKPI2EjEqTiGr55FIVo854XkXhWz9hyvqo0KSHESozP3fEaIY2jwqmCyzcSWPs1Vn0AAOyANWfoMDxVi6BfJwbFLAa1Vq5P5icRwKw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BY1PR11MB8030.namprd11.prod.outlook.com (2603:10b6:a03:522::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 07:17:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 07:17:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Thread-Topic: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Thread-Index: AQHbBAs7dSCINsfvkEGytF87b/oqprJrHaMAgAAom3A=
Date: Fri, 27 Sep 2024 07:17:53 +0000
Message-ID: <SJ0PR11MB67441D158F394CE1EA620CA9926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-13-zhenzhong.duan@intel.com>
 <CACGkMEscZB9f6toOcm_+3pQknDgnp3r6MvzbejB9BVEsKz7rjA@mail.gmail.com>
In-Reply-To: <CACGkMEscZB9f6toOcm_+3pQknDgnp3r6MvzbejB9BVEsKz7rjA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BY1PR11MB8030:EE_
x-ms-office365-filtering-correlation-id: e121aaa0-f3ab-477a-7715-08dcdec480f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZjF4a1hyTTdaQ1Q0Um42TTd0aURJZXI1Rll4Vnd0ZHk3Ukh5Wk5JK2R3d1Jr?=
 =?utf-8?B?TGpFMTh2Wm1VUHJPNEhsMGhOWWtiNEJmakF4UDJWVnA1MGgza3lzem1RMXZQ?=
 =?utf-8?B?SGhrZmd3OGlrL0p5WTRUTmdESGJtU3dmdHN6RnIzT2dtdVg2c1gyK2FMVHVO?=
 =?utf-8?B?dmJINk52aitvbWgvVi9KUkRmZjBFUXVIREVGVU9ITEJhcGt5Ny9HbjNRODV6?=
 =?utf-8?B?aFN3K3FpcGdsaFJ3eXplQkhIQkg5MVdZMktSa0hnV082THZodmYrdEwvKzhz?=
 =?utf-8?B?czVvNUlwb1NZSVAyTDlaZUJIRHdxRWpNaldvTFFiaVlXQTdyR245SjVJN01C?=
 =?utf-8?B?YWJFa1o2U1Q2WUFJWDFQRDcwc21OdXJ0OVFpazFzT0hQQUhUMVBKaXF6UjZR?=
 =?utf-8?B?T3p5TlQzT1FMZ2FaRjJUL3FUbmh4UWJobUVFcDdOS255c2gyTHlzL2FZSndl?=
 =?utf-8?B?RW42azgzeHptNFBIMkc3K050NFVNZVRrM0U5OStNRHNReUlIWXZFZnk1L0Z2?=
 =?utf-8?B?a2w3VzRWbWRBYWY2dm9mN2owTG15eENnTE1aamVTakh2WklQRkExS3ZYQUUy?=
 =?utf-8?B?cGQxNXFBdUhkdmRDMWp0anIvdmNUa2NSOG1jb0xGbVVXVnEyYnVrMnAvekxP?=
 =?utf-8?B?dDkrbXhLRTc0M2NxMDNodUV6TEVGcXZIeWJVbE5tT3pNc3RwNFpFeGVaUVVv?=
 =?utf-8?B?cWVDajRlOVNnNmhxbVdFSXRVaHllWGpVaHVEeElpTnFZYlhIMDIra0xaUDJE?=
 =?utf-8?B?WUM0bU9xOERwM2ZNZjBBU0lzS0E1K3BrdGwyaXJHWmpuUnd6aUwxUTE2dmIx?=
 =?utf-8?B?c2FvRXFlbmQ2MjlncllZdmpYQTE1ekxySGJIVmIxUVVpU1BmSzNyUVFjL2ZT?=
 =?utf-8?B?WFh4NG9OcFI1U1BibWRTbFMyUjhPT1VEeTdOKzhMU0ZIS0J2YUUvNU4yeTRy?=
 =?utf-8?B?QXV4RzZuQkNJaTVwb2daMkRhOHRUKzRYUW92SU9xUDl6bHN1Z3lZeG1wQUpY?=
 =?utf-8?B?MUVkTzZaOVA5Y3dWQVV4dk50YmpOam4zWE9YWXdMZ1JwVFRtOVRsUHdyZTlM?=
 =?utf-8?B?Q2tIOGdTTjFhOEE3UkFZZ1dIT1Jla0VBYzV6bmpTYWl6b0VxS1hPM1JCUlkw?=
 =?utf-8?B?YmppUUYvUnpFZDBTdVRIVDNYTTBrUVBTTG5rVks0Vzg4YzYwWXJHODFOeldG?=
 =?utf-8?B?UGMxWFQvRzcvYnh5OFg4MXlYdnhNWEk0M0R0bTlDZ2FnaXhXT056THIrUnoy?=
 =?utf-8?B?UlB5Qk5reGxWMmpidVk3UW5RM3lWenRISTQyTUJidmFUejdET0prZkxOMmFP?=
 =?utf-8?B?ZEV6U1ZZV3RmMkR6cmpDa3plaVRCMlhrVXVXYjFmRWF6dlBaWXVtTHIzeVlr?=
 =?utf-8?B?WDZZWTVGNzdaTXlrTHZ1eC93dnFZN1llWXFGMzE5UEtMVjBPNXZoTGF4QSsx?=
 =?utf-8?B?b0c4QUdPSzV1eUMwSjhJb0pkWGgvVS92bnB1Y0dyRzdQbHNOOGk2dkNSUHNo?=
 =?utf-8?B?SW5xcXBOanY1R0c1ZjU4VDZYOGtETmdQdk9pbEdwRmVGNmNNR3daNVN1clRL?=
 =?utf-8?B?NWhHRlNMZWJLUHg1cGtGRGw0U3YrQjB1RUZacEJWN2hRWHEzbzBSWHk3WXY4?=
 =?utf-8?B?cVF3U2dScHJIRUZmL1hBVGRmM3pORlZ0T01wWTdYV3Vib29JTDNOR2VvclFX?=
 =?utf-8?B?dWNDUDl2VEVsUzU3NHVaQ2lzRVo2angzSTE1MTEwbWJSWkttNTJxQi85eDFC?=
 =?utf-8?B?U2VJLzdVakQ3SllyVk5QRWFrUWFmYmtHcGxjcEJJTnZWRi9oQ1Fra01lVHQ0?=
 =?utf-8?B?MFErcWRGNWFnYkdmdDc0QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1llZkpmSmIycXg3ZkZ6alRRSWorSTdNd2Jybmd5aVptSFNhQVIrSUh5b3N4?=
 =?utf-8?B?R0pMWTlKbUo4bzdDdC9PeWpOdmdOOEg0bklSaEV1ZHhNamsrbC9xQTBMVjdL?=
 =?utf-8?B?ZDZFMFB2QXRWZ2VDZkNGWDVDWUVGNzhXdTZKakF0U21ZMHIzcUZndWU1UjdH?=
 =?utf-8?B?TVIwWUJVcGpOQzJZRlJMY1FOWVdES1JlRjBuY3FJSGZNZ01LQ0FtcGl6Uzdl?=
 =?utf-8?B?c2hGMTFnWDRMeGF0aXZ2a1NOZ0ViVnZDMUtnVTZJL2dPK1QzcXlCY3k3MStV?=
 =?utf-8?B?M0x0R0V5SWdIbDBwUmxIamJLdWwxZXQ2QytSd1BhODJmUVcvWmhKSG0vNXdQ?=
 =?utf-8?B?TzJPVkNEa3R5M2doVlJKeWlOSEdUbTQwbmtvY3lmMDJrNGtpVnJGb1BKbEpK?=
 =?utf-8?B?VVFOeHJsbmlNVS82NXd6bEpja3NIOXYvZlRQS0xjYit0UjYvbEhpWlFYbnc5?=
 =?utf-8?B?aC9WZVlFZk50TGFoV2w2WHoyVkNpbG9MdkdyR05LVk1MSnoyWHRWZ24zeEFT?=
 =?utf-8?B?NzVPbFlodXpVaDRxbzJIQm5YMEwram8yc2o4VFk4YTd3WXdtMDA0MUcvL0No?=
 =?utf-8?B?NGk2QXFTUk90d1ZSZmNieEhOQ0VUenpPaXVvMXVaVjRMeFFmZmZqeVlJS0JB?=
 =?utf-8?B?OEVKQ25UdmRUWE1zMmxNa293bXJFem0yUEZIMVdUK0d2a2NEWHBjSDdnL0hq?=
 =?utf-8?B?b2hOcWdMbGM2dzg5U2ZxTjg5SG5yRGxCOGhON3dJNVRtZ1ByLy95LzNtREM2?=
 =?utf-8?B?b2FwTEtWdFhIN2Zwd0kwc0YrNVk4WkRnY3AyMWtOakMrc2VSYUlMT3RVek5S?=
 =?utf-8?B?cFdrZjh3aWhZSGFhT0l5NHh2VnJpbE9ONkM1bE5MNHlBcnN6Z2tuK3plRkZH?=
 =?utf-8?B?SGlpbWVGL2JtbFhTbmxHSzBrRDMxdnJTWnJzZ1FyVk42TVF3Ni9pVmFXQm1P?=
 =?utf-8?B?b2xBcGc3ZVJ4b2Y0c0R5ZjRWUVRyV1Ewci8ydElZYWVBYURzQjdRQWIzWEpw?=
 =?utf-8?B?cWVxTWhEdnBNMDBUczFHV25NSi9hV1V4bUdzNkFkNWZmcEhlNXBMNW5Ybm8z?=
 =?utf-8?B?eE10a2t4N0lTU09JaUNpejFuc3Y2NXB3SnEwS000UjRmU0lhaGthSlVOV2M4?=
 =?utf-8?B?RVg4REFsZmt5ZnVQTEJSdko5VTlzSXlTWFpHWnQ4QkQ4empqVkh6dFdpS2Y5?=
 =?utf-8?B?enpnaDVXVVFBb1g0cEpPV1UrcmJvbEZUWDRGTDREbmJEZmh2c0V1aHdlYmZv?=
 =?utf-8?B?MmdzeUl5M3VNUHYzOGpaTCtWcTJRYnF1Z2xGMmY2azdFWFgzSmdUQm1RanM5?=
 =?utf-8?B?UHlPd1dZMUtqUEpPY045SjZwRGt6aVhCVWoxTmlDeGlFMXFsNW9uNytpOXFW?=
 =?utf-8?B?Z1F4VWNaWldhdFhPaUhNSTlBeTdkcUFoVXh0WVN0NENLaUt4anc5a1duQUJF?=
 =?utf-8?B?SUswNGJDQTU5LzRKTnk1OEhlV3dnbEppNTJVdktlcCsvN2lPOGNUb2FTK1lu?=
 =?utf-8?B?dlFZUmswTjJhMXpTVFdyb1krUlV5aUZ5T2ZWTnlDUnluV20waWFrVnB4Tnda?=
 =?utf-8?B?MDN4a1ZlS1JNS1FzT1g1M1haenlwSGRvQ0NLT1JJVElWdDVuZGdIalhPNURM?=
 =?utf-8?B?KzRqQ0JsUkYxbi9VS01QdmJvWnNtRE0waWx4cStUTGRNbkR0QWtpMWlJKzI5?=
 =?utf-8?B?T0ZFUmJDa2ZGL21qS0NLckVzUmV5ajN1N0dua3Vld3hnWkRuQVBwVDI2WHN0?=
 =?utf-8?B?azU3SUp5NjBoTFArSUpwZFgvS1FOd2c0dmpyMWJ4VkQ0bUVjcFpGTzJ5QU5O?=
 =?utf-8?B?Q09nRTdSbnNwclBYM0VDbnJ4OTcxZWpQakhjRG1qL2djR2FMZ2lyeUdKMko4?=
 =?utf-8?B?dmRVKzhnRVJZZGRDQVpIeDZnWk1LVTloSmEvU1REY1RXV1JpWTgxUXpoRTVj?=
 =?utf-8?B?SitKaGxnNDZlLzNCcXNVK1BKL1YzSHZhYkhIS01EdWZLZlFBa2prdEx3WUJj?=
 =?utf-8?B?cUZ5QTFNTlFVWWsvSkRQL0ZOQUk3Rk9ENFhJdXh0YTdtTVhkNHVFcVJPa2p5?=
 =?utf-8?B?dlJwWWJBWnF0bTVjMUtsOG5oRytSZWJxZ3FDaytmc0UrL09STmlqU2RnbjlJ?=
 =?utf-8?Q?3DBkWbaEqOe/SyISdtjKjpW5M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e121aaa0-f3ab-477a-7715-08dcdec480f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 07:17:53.8005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljdOmZx76on7b9DNNQw9WDQgrYd/5kE80FX1TpVb5eg+OAhBAOBAXX23S1ccWbqN539/8pTKkr6BuF/HD9V1eDrwXAZNVLl9uG7mYntvvgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8030
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxMi8xN10gaW50ZWxfaW9t
bXU6IEFkZCBzdXBwb3J0IGZvciBQQVNJRC1iYXNlZA0KPmRldmljZSBJT1RMQiBpbnZhbGlkYXRp
b24NCj4NCj5PbiBXZWQsIFNlcCAxMSwgMjAyNCBhdCAxOjI34oCvUE0gWmhlbnpob25nIER1YW4N
Cj48emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90ZToNCj4+DQo+PiBGcm9tOiBDbMOpbWVu
dCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUt
LWRyaWZAZXZpZGVuLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmggfCAxMSArKysrKysrKw0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAg
ICB8IDUwDQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCj5iL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0K
Pj4gaW5kZXggNGYyYzNhOTM1MC4uNTJiZGJmM2JjNSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+PiBAQCAtMzc1LDYgKzM3NSw3IEBAIHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBW
VERJbnZEZXNjOw0KPj4gICNkZWZpbmUgVlREX0lOVl9ERVNDX1dBSVQgICAgICAgICAgICAgICAw
eDUgLyogSW52YWxpZGF0aW9uIFdhaXQgRGVzY3JpcHRvcg0KPiovDQo+PiAgI2RlZmluZSBWVERf
SU5WX0RFU0NfUElPVExCICAgICAgICAgICAgIDB4NiAvKiBQQVNJRC1JT1RMQiBJbnZhbGlkYXRl
IERlc2MNCj4qLw0KPj4gICNkZWZpbmUgVlREX0lOVl9ERVNDX1BDICAgICAgICAgICAgICAgICAw
eDcgLyogUEFTSUQtY2FjaGUgSW52YWxpZGF0ZSBEZXNjICovDQo+PiArI2RlZmluZSBWVERfSU5W
X0RFU0NfREVWX1BJT1RMQiAgICAgICAgIDB4OCAvKiBQQVNJRC1iYXNlZC1ESU9UTEINCj5pbnZf
ZGVzYyovDQo+PiAgI2RlZmluZSBWVERfSU5WX0RFU0NfTk9ORSAgICAgICAgICAgICAgIDAgICAv
KiBOb3QgYW4gSW52YWxpZGF0ZSBEZXNjcmlwdG9yDQo+Ki8NCj4+DQo+PiAgLyogTWFza3MgZm9y
IEludmFsaWRhdGlvbiBXYWl0IERlc2NyaXB0b3IqLw0KPj4gQEAgLTQxMyw2ICs0MTQsMTYgQEAg
dHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7DQo+PiAgI2RlZmluZSBWVERfSU5W
X0RFU0NfREVWSUNFX0lPVExCX1JTVkRfSEkgMHhmZmVVTEwNCj4+ICAjZGVmaW5lIFZURF9JTlZf
REVTQ19ERVZJQ0VfSU9UTEJfUlNWRF9MTyAweGZmZmYwMDAwZmZlMGZmZjgNCj4+DQo+PiArLyog
TWFzayBmb3IgUEFTSUQgRGV2aWNlIElPVExCIEludmFsaWRhdGUgRGVzY3JpcHRvciAqLw0KPj4g
KyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9BRERSKHZhbCkgKCh2YWwp
ICYgXA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDB4ZmZmZmZmZmZmZmZmZjAwMFVMTCkNCj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJ
RF9ERVZJQ0VfSU9UTEJfU0laRSh2YWwpICgodmFsID4+IDExKSAmIDB4MSkNCj4+ICsjZGVmaW5l
IFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfR0xPQkFMKHZhbCkgKCh2YWwpICYgMHgx
KQ0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9TSUQodmFsKSAo
KCh2YWwpID4+IDE2KSAmDQo+MHhmZmZmVUxMKQ0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BB
U0lEX0RFVklDRV9JT1RMQl9QQVNJRCh2YWwpICgodmFsID4+IDMyKSAmDQo+MHhmZmZmZlVMTCkN
Cj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfUlNWRF9ISSAweDdm
ZVVMTA0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9SU1ZEX0xP
DQo+MHhmZmYwMDAwMDAwMDBmMDAwVUxMDQo+PiArDQo+PiAgLyogUnN2ZCBmaWVsZCBtYXNrcyBm
b3Igc3B0ZSAqLw0KPj4gICNkZWZpbmUgVlREX1NQVEVfU05QIDB4ODAwVUxMDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
Pj4gaW5kZXggZDI4Yzg2MjU5OC4uNGNmNTY5MjRlMSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtMzAx
Nyw2ICszMDE3LDQ5IEBAIHN0YXRpYyB2b2lkDQo+ZG9faW52YWxpZGF0ZV9kZXZpY2VfdGxiKFZU
REFkZHJlc3NTcGFjZSAqdnRkX2Rldl9hcywNCj4+ICAgICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlf
aW9tbXUoJnZ0ZF9kZXZfYXMtPmlvbW11LCAwLCBldmVudCk7DQo+PiAgfQ0KPj4NCj4+ICtzdGF0
aWMgYm9vbCB2dGRfcHJvY2Vzc19kZXZpY2VfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpz
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERJbnZE
ZXNjICppbnZfZGVzYykNCj4+ICt7DQo+PiArICAgIHVpbnQxNl90IHNpZDsNCj4+ICsgICAgVlRE
QWRkcmVzc1NwYWNlICp2dGRfZGV2X2FzOw0KPj4gKyAgICBib29sIHNpemU7DQo+PiArICAgIGJv
b2wgZ2xvYmFsOw0KPj4gKyAgICBod2FkZHIgYWRkcjsNCj4+ICsgICAgdWludDMyX3QgcGFzaWQ7
DQo+PiArDQo+PiArICAgIGlmICgoaW52X2Rlc2MtPmhpICYgVlREX0lOVl9ERVNDX1BBU0lEX0RF
VklDRV9JT1RMQl9SU1ZEX0hJKSB8fA0KPj4gKyAgICAgICAgIChpbnZfZGVzYy0+bG8gJiBWVERf
SU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1JTVkRfTE8pKSB7DQo+PiArICAgICAgICBlcnJv
cl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgcGFzaWQtYmFzZWQgZGV2IGlvdGxiIGludiBkZXNj
OiINCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICJoaT0lIlBSSXg2NCAiKHJlc2VydmVk
IG5vbnplcm8pIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpbnZf
ZGVzYy0+aGkpOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiArDQo+
PiArICAgIGdsb2JhbCA9IFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfR0xPQkFMKGlu
dl9kZXNjLT5oaSk7DQo+PiArICAgIHNpemUgPSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lP
VExCX1NJWkUoaW52X2Rlc2MtPmhpKTsNCj4+ICsgICAgYWRkciA9IFZURF9JTlZfREVTQ19QQVNJ
RF9ERVZJQ0VfSU9UTEJfQUREUihpbnZfZGVzYy0+aGkpOw0KPj4gKyAgICBzaWQgPSBWVERfSU5W
X0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1NJRChpbnZfZGVzYy0+bG8pOw0KPj4gKyAgICBpZiAo
Z2xvYmFsKSB7DQo+PiArICAgICAgICBRTElTVF9GT1JFQUNIKHZ0ZF9kZXZfYXMsICZzLT52dGRf
YXNfd2l0aF9ub3RpZmllcnMsIG5leHQpIHsNCj4+ICsgICAgICAgICAgICBpZiAoKHZ0ZF9kZXZf
YXMtPnBhc2lkICE9IFBDSV9OT19QQVNJRCkgJiYNCj4+ICsgICAgICAgICAgICAgICAgKFBDSV9C
VUlMRF9CREYocGNpX2J1c19udW0odnRkX2Rldl9hcy0+YnVzKSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnRkX2Rldl9hcy0+ZGV2Zm4pID09IHNpZCkp
IHsNCj4+ICsgICAgICAgICAgICAgICAgZG9faW52YWxpZGF0ZV9kZXZpY2VfdGxiKHZ0ZF9kZXZf
YXMsIHNpemUsIGFkZHIpOw0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsgICAgICAgIH0NCj4+ICsg
ICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIHBhc2lkID0gVlREX0lOVl9ERVNDX1BBU0lEX0RFVklD
RV9JT1RMQl9QQVNJRChpbnZfZGVzYy0+bG8pOw0KPj4gKyAgICAgICAgdnRkX2Rldl9hcyA9IHZ0
ZF9nZXRfYXNfYnlfc2lkX2FuZF9wYXNpZChzLCBzaWQsIHBhc2lkKTsNCj4+ICsgICAgICAgIGlm
ICghdnRkX2Rldl9hcykgew0KPj4gKyAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPj4gKyAgICAg
ICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgZG9faW52YWxpZGF0ZV9kZXZpY2VfdGxiKHZ0ZF9kZXZf
YXMsIHNpemUsIGFkZHIpOw0KPg0KPlF1ZXN0aW9uOg0KPg0KPkkgd29uZGVyIGlmIGN1cnJlbnQg
dmhvc3QgKHdoaWNoIGhhcyBhIGRldmljZSBJT1RMQiBhYnN0cmFjdGlvbiB2aWENCj52aXJ0aW8t
cGNpKSBjYW4gd29yayB3aXRoIHRoaXMgKFBBU0lEIGJhc2VkIElPVExCIGludmFsaWRhdGlvbikN
Cg0KQ3VycmVudGx5LCBpdCBkZXBlbmRzIG9uIGlmIGNhY2hpbmctbW9kZSBpcyBvbi4gSWYgaXQn
cyBvZmYsIHZob3N0IHdvcmtzLiBFLmcuOg0KDQotZGV2aWNlIGludGVsLWlvbW11LGNhY2hpbmct
bW9kZT1vZmYsZG1hLWRyYWluPW9uLGRldmljZS1pb3RsYj1vbix4LXNjYWxhYmxlLW1vZGU9b24N
Ci1uZXRkZXYgdGFwLGlkPXRhcDAsdmhvc3Q9b24sc2NyaXB0PS9ldGMvcWVtdS1pZnVwDQotZGV2
aWNlIHZpcnRpby1uZXQtcGNpLG5ldGRldj10YXAwLGJ1cz1yb290MCxpb21tdV9wbGF0Zm9ybT1v
bixhdHM9b24NCg0KSXQgZG9lc24ndCB3b3JrIGN1cnJlbnRseSB3aGVuIGNhY2hpbmctbW9kZSBp
cyBvbi4NClJlYXNvbiBpcyBsaW51eCBrZXJuZWwgaGFzIGFuIG9wdGltaXphdGlvbiB0byBzZW5k
IG9ubHkgcGlvdGxiIGludmFsaWRhdGlvbiwNCm5vIGRldmljZS1waW90bGIgaW52YWxpZGF0aW9u
IGlzIHNlbnQuIEJ1dCBJIGhlYXJkIGZyb20gWWkgdGhlIG9wdGltaXphdGlvbg0Kd2lsbCBiZSBk
cm9wcGVkLCB0aGVuIGl0IHdpbGwgd29yayB0b28gd2hlbiBjYWNoaW5nLW1vZGUgaXMgb24uDQoN
ClRoYW5rcw0KWmhlbnpob25nDQo=

