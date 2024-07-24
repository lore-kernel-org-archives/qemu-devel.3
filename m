Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592CEC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 08:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWXZj-0007D7-Eo; Wed, 24 Jul 2024 04:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWXZh-0007CR-23
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:42:17 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWXZe-0008PX-0c
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721810534; x=1753346534;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=C2n9sInm5hFS3ii14TAgkqy4IRS/QyEpPLPou6AiSmg=;
 b=jK9o2dbhfpQXv7QMYhNxgvLlmN//lsZyQZCoR43leou4mek+2HomR+Uj
 8nnORfgFC34jbM/NMKGPqxYm9t0sZAd7SWFe+8CQeBjE/gR+qiugZlfRw
 0YHXtx8W4gRkVmnwmmiPCXDVMeemiCTHA8750JhUUCFUNXsWnGjCvSGXC
 5UrXqIPMbZZLqfbjz1mdN4JP03bx05TUoebQlcuFTdndm+l3v/fE8U/oD
 DvFlGCCqz0FxF/w20YczO+Id6CdE1HUyA0/o3qJJ0Z51DKduFwVZehFC9
 copXdcKw/TQHACCyqEKbFVaXWfpH/Ym3yjR1cGC5DytQiun1l9hIyh0rM A==;
X-CSE-ConnectionGUID: oN4yBY/1SdOZboVqNXwzVA==
X-CSE-MsgGUID: M2D1D/xnSjiZ08nAX1+Yag==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19089569"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="19089569"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 01:42:11 -0700
X-CSE-ConnectionGUID: n0PdFehHQgOlgM/z+WWNKQ==
X-CSE-MsgGUID: MOU2+rVCS0GLp8m4g35ufw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="52394793"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Jul 2024 01:42:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 01:42:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 01:42:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 01:42:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 01:42:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVf+kEvN2PTVyuPuU24bx64eLV3zT3ByhHB9o7bNS/8zNEadbC3RVQ8G3Tz9qfW9RPDHKV2m1A/XpyS62vfKYgaEai92aj6/2QSB1Juwuvah9tRDxIG4vgGwPEFCfX8otWtwzyPzdiWz2YhRVaErRqE7UeaBR4GZUhJ3bJJxORg7pVebmD9xQtgxnUfgSOSqwdW/EHHbPJpABVmDQC3Ivg5EE2YmNeytv3onJbP5nNdE51NXM7uF2PCkNvasLD+ZaIYNY9bgsjNxo4VojQZpzUTxX9u+SOLi9427QBmuXSkQI5XIRgGZbZXDsINnyfvIxdeXtMCRBMCP0Sz0+InzEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2n9sInm5hFS3ii14TAgkqy4IRS/QyEpPLPou6AiSmg=;
 b=upY8VBGA01XezrEdf1W0yT3yu7bl+5Xj/L7SRNSMlRc5VoeP6C172WHeQ5JBjEPaLJWIhPtQ2cIo07QB9SqJmMpITLv2FZQ6MsOE0Z0IJHjUDpB0jwGD5rkFBL9UWkEr1ZPNVMzv6I/2qW9pTMAHoITyUtQD09clj/bY+ApI5McC3uz4OE1WLGCsT2BB7qGYNkahGEavfvajjzfsxD/VcyUUo/j2eBtZW2y4267SGpcPlHTve4zSOpupDGFl5CbM13kd2lnKn/b7zrLj1VYUBEUC+jmuhVFxVcwHL58KFsiXSqULfoByzfxAq1+SA7fwd573T6BvEM04PXa2wByDNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Wed, 24 Jul
 2024 08:42:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 08:42:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v1 11/17] intel_iommu: Extract device IOTLB invalidation
 logic
Thread-Topic: [PATCH v1 11/17] intel_iommu: Extract device IOTLB invalidation
 logic
Thread-Index: AQHa2OthP375xXXZ7EOF+jHhPORsw7IFlwCAgAABfcA=
Date: Wed, 24 Jul 2024 08:42:06 +0000
Message-ID: <SJ0PR11MB674427604CDFE0B071297BE992AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-12-zhenzhong.duan@intel.com>
 <b8e4b976-2c78-4fe1-b095-c5f64db28223@eviden.com>
In-Reply-To: <b8e4b976-2c78-4fe1-b095-c5f64db28223@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB6516:EE_
x-ms-office365-filtering-correlation-id: b21ff91f-5890-4b6a-5be6-08dcabbc7feb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?V2d4WWZXcUFhQ0lpSnNOQU9iVUVwd1hkU0RlZERVTmhqOHdwc05Bd3dDYUJx?=
 =?utf-8?B?dFl0ZnVLeWdEWFRIaGNiWDhDRW1rNGxYK0pkUmtFWE4xNnE0Vk04SjlPOGYx?=
 =?utf-8?B?Y25rRXdWU2pTUWRLYzd1VXRIMkVqL0MvWW9GK2taUitxM1VkUzh0MGRqNlFk?=
 =?utf-8?B?bTZlbjc1U1RMUUd3czZLWlFQWmdnVGh1ekdCZkptbEtSRkwwM3BGWTIxT0Za?=
 =?utf-8?B?enJGaUdsSmhPdzJxY1IvTmFZQStJZkRoZnp6eGVvdTJDb2Q0V0Q2UmRIN3ZR?=
 =?utf-8?B?cWR6ajBycmhSOXN6bVllaG15VGdUaFYvL0RNUXBtaTdoRHA1cTU2VjFUb2tJ?=
 =?utf-8?B?S3l6eGdzUGlBV3g3RFQwTlF6ZnFqYlBMVHhwb2g3S0NnRkdPdmFKUG54bmVO?=
 =?utf-8?B?YjIzbjZnTERhRy9zMzJSWUlEaW1PdU1ZbEE3MTV0VVFkaVcrd0E2M2piVlRn?=
 =?utf-8?B?SDM0dVZYSDNFT1QvOEJpckJGZlhYbW40c29PMGFpRVBVSmtDUWZtMGpob1hk?=
 =?utf-8?B?RkVzbHVWeXBOdTdaazlzbEUydVJ5UXdmODVOT3BaSWgxbGxZWTFGbENjNUti?=
 =?utf-8?B?Rm41RGZZZXlCenJNMkx4M1dXRWkxTmJOTHltclBReXRjZDlndFpXckJVT2ZY?=
 =?utf-8?B?ZzdGZmg2OWVDalR6VkRsT3QrWitZTTMyOFlBdFpoUmdDdjFaMXlNOEZRYmFL?=
 =?utf-8?B?Rk1Wc1I0TzY4Ymw4WnRSaHRMb2UyQ2Q4a1p2cUEyOVZEOWhXNTNCMjQyVnAx?=
 =?utf-8?B?MHVwTWZBQ3FpWC9GbGlZOG4vTCsyektXQjE1aVY3Q0NIYXFsYVJrTWdOWlgw?=
 =?utf-8?B?LzRlM0hTbnJXK0FqYXBnOGttOUVUSWRCNDhoMnp0ekU1blhRb095cDNkaUZz?=
 =?utf-8?B?bUJjZWM4MFJlM0o0N0pqOHIzZHhKZVRUc3ZQdGtUUTE3U0NHR0RVMFBtSXkw?=
 =?utf-8?B?d0lQcnY5RGFFMEJHbmI2SlovdXJ5Z2c4M1ZEVTg4UVhXalNqRmk3RVZnZG5Z?=
 =?utf-8?B?Ym9mNWcwaWg3VFBmb0FTTzJLWlZ1cHlkcU9NYVZzWEFnUzlsZlhEZmgzTHZs?=
 =?utf-8?B?WEkwNFpCbVN5REJRdDZCVERVUW9QdVhrTDdLRlhEdGJhcGlZWk9kWmh6N09O?=
 =?utf-8?B?S1BFTmVuM2IwSkE1SzJkZHZaZUV3Y2MvSW1Dak5YWjFWTGd3SWZzSnlkaXI0?=
 =?utf-8?B?MGxicEx3K1pDTUpadEgxWVdUeHhhc05LQ1JSRC90WUY2U1hCazBBc1R2YVAv?=
 =?utf-8?B?cmhzSmpSZnR6L2N0ZmxXYXZWVGFkd05lWVJSSDZFakFRa2xwRktKUDZ2L3hT?=
 =?utf-8?B?RW0yUko5NkZaUDk3VWplbHBySm1RcFFpVUt6bmIwclRmMTVTUE8zNjVLUWwy?=
 =?utf-8?B?THJkMFVuV1IrTUZRNHRGRW16TXcrazVyNmpHTG9XSk9SR2d3TkpZOXNLQWRw?=
 =?utf-8?B?OUNmeGVOcDhPTFV3eGkyTllROUlZM3hGbDFXaUNROFN6dGRmNVZDbzFUbTV2?=
 =?utf-8?B?SUJEenN2Vjd1YmFZRFYvTlA0andWK0dGMEkyelVieGJFTFF3OVJZY2hGNnox?=
 =?utf-8?B?NjlBMnlSRlpUZW1pVitSNWxmMWlkd1VmdXFnV3JpT1U2RXZVRmZ4V3RMbnRm?=
 =?utf-8?B?VEZVWjhJcXZkTmIxT1EybXRwZnpBTkFBaDRnTE00L3NURi9qQ3hiMmNnQ2dN?=
 =?utf-8?B?NXAwZStmUUp6aU9lcUZWL25jQnFiMzVGaU1Sd3l2YmRjaWpyWWE0c1Nxcmd6?=
 =?utf-8?B?VDY1dTUyWms2VzludG5LZDZsVUM3TVc2K0NiU3Zud1lUc3IxSFBid3NVUjN2?=
 =?utf-8?Q?BiiGw9xgzQ6WR+RGMWPrr4w7PrormEBmhoDFw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFQrMmczYWxkMTJlMFBQcXFTUS91VDZrNzlJdlUzVTRJTmFuUnB3M2UrWXhv?=
 =?utf-8?B?ZkFaSm9LZzJZYUdDSDBiZ1o3Z0xlK1FpUndDbTNCVEtnb2dwMThOZTE4Wk9P?=
 =?utf-8?B?V0RDaTBVWnF0dWk2YlZiY2Jrb1g5ckZKR3hYZGZlUmdsb1VtOGc1RmxTbEIx?=
 =?utf-8?B?Q0JhSUk3dDQ5bndROVY2WXBZZ2tDdklGcnZkQTRzRVVzdXFzU3V6Z0Q2TjZM?=
 =?utf-8?B?WEExVUpVZ0o5VGR5V0FGTStHdU0wUytZQUxTZ3p2c0JHZjBBVzhIaUx3U09V?=
 =?utf-8?B?LzZ5Vk43MnRmSGJ4MlA0L2l2Q1dFeUJHejByOWU1Sk1XRzRNWFFvMjJBbEFl?=
 =?utf-8?B?Q2g3R1RJamdSYUhybTg2WTNQekorNjdTVmFwRDZSK2pWUHQrNWNUMC9rVzNi?=
 =?utf-8?B?QWZIdStnd2c1K2xiT3E0WVVaTEhPWFI0M1Fvd2t0b2t0eGR4czhudHFCZkRu?=
 =?utf-8?B?WkczMHdUaGFPb0J3ekc2bnBFR0t5NVVkWEtDUHhiZ3MrbC9RRTVMR0dNMWMw?=
 =?utf-8?B?Q2kzMkxQWksrU3B2YWZVYndabnkvOU5VNm1yYWZqOTNnL0xwd0laNEl1b2Zq?=
 =?utf-8?B?RVdBU1I4UXZtRUczK2ZyaTVDSi91VFZ4Ym1CT2hEaTlYU2E3MXh5Z3FENEh5?=
 =?utf-8?B?VUt4MFhOZXNTR0xFVW5qZVRNNXFweEYwVldBT3RtRXd4SmU4RmJDaGh4WVRz?=
 =?utf-8?B?R3JXS3haRFZDbmFoeVd6TkFoU1ZNY05KbCtYRUNXZytGTFdQSWQ4bDFWTit3?=
 =?utf-8?B?aGFSd0dFeDByV3h5NGIvaVlPbDFHM3oxMEFPMmF3TllVb3hxblBucFFmekVj?=
 =?utf-8?B?dW5ncWZtNHUwRXd4bXpzekZidERkd3MwcWsvK1B3S08vMERSQjZWelBYUDl3?=
 =?utf-8?B?ZU5DMjhDS3VwallkZ0RIeHhaMU5zS05uMGpORlFOYVB2SDYycXJmZFFQeXQ5?=
 =?utf-8?B?SUVualFhU0dGdVFGKzM0eU8wVXFEbHNGRmllblkyejFCdVZHTDBvd3JNVnFw?=
 =?utf-8?B?ZGs5aVdLckxhWnVSUGVra1pJOE5FWnp6eDZCay90dm5SaEtGY09VOElVM0lS?=
 =?utf-8?B?a2RBSnZQUlI3elArQUplTnlkNlE1YmRYVHYzdUlDbEcwdXBTRURra2xxR1h2?=
 =?utf-8?B?aEJBMVFGYThOOXQ2SEhYK3ZCVlVvOVArN2UwTGVkTHVsbVVWd3FxMGhYZkRa?=
 =?utf-8?B?THYxWm43Smcva1JvVEs5Q0hDWkpNZWxjVEpOc2R6aUMxWENlaFRZaVFsUGxn?=
 =?utf-8?B?aFVseU9kaFFuMUVtL3B0cllhS1dQK0FPSnBZQ1BzTlNDUWtibjdOb2J4b0dy?=
 =?utf-8?B?bGJKdWxpSlhYYUhWQkRMZVJQOEVlNFR5SUwyS3ZQQlZhZmJNVEZxSUNrYmhj?=
 =?utf-8?B?TnNsRDRQZHdGdHE0bFZOQjFDclhoSklCeE05UkVzaW1GYk5zdGhKemh4eExt?=
 =?utf-8?B?UHc5RE9rVS8vTzZVSlFZK3dpQldNWmhPamNHalNHQmh5a0hYRC9nZlJ4Q1RE?=
 =?utf-8?B?OHJHZDc1d1loM2NiYjNmQWxmKzJmYTZRZWRoa0xPNTF1bkw2WlRkK1dGcFZN?=
 =?utf-8?B?Z0Z3Tjh5ZWd2czNtQzF1U2Z0ZnpXdHFVRjQzbTd3MVRLTUN4MHFtaHVqc21h?=
 =?utf-8?B?YjFNL3FvSEpRRGFOeHI4UWI3Ty9oUE5wbEhTZ1A3eGphVk9oakwra01BYytJ?=
 =?utf-8?B?Qy90elMvRXRTOG5Sczl0TjljT09MVlI1dkFuTVUvZytaSklSUkN2SlBtNEg3?=
 =?utf-8?B?bGVaQ2xkYlNQblJrQzBZL3dKUTFvMmJYUHJIUHhCTGZrRnBCNGs0MENyWWVR?=
 =?utf-8?B?WEIzMGZtQ3RrUEJXMmhlV05NZEhTSmhGSU5nTCtJUVVYZFhOL3Q5dXdVeFFx?=
 =?utf-8?B?aWdBSEt6akNvYTk3UXUyVnUzY2w0elY0TVhxNUh4aVJwdnNxSWVva2REL2Jr?=
 =?utf-8?B?N0hCV1pIVlpZYkc4TnZ5ZjBtM281YXlUeGpjYTBUNlFWaktudmJGMUJtVVQ2?=
 =?utf-8?B?RlA3Yzh6cCs0WE14ZiswK1ZaMC92Q2VkZEh2ZVUvV2NXT1lmV0txOGdnN2Jw?=
 =?utf-8?B?ejRncDBGeUpSN1Nkem9TMHpkWERyejBlMDhhQm5ZdGM2UXY4SGVaWG9Xd0tm?=
 =?utf-8?Q?LkGg0lvstUxkKUUn9+B1zQEns?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21ff91f-5890-4b6a-5be6-08dcabbc7feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 08:42:06.7882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vr0YCOzdSU7EFIedHDkgYNldPSppVx3+N/Esg7Ynd6xpCEtppZgWz+a0i3wV2KsAyfSAEre3ZO4wBKw/76qjBenGihnl5P+93rPc9prMnkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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

U3VyZSwgdGhhbmtzIGZvciByZW1pbmRpbmcuDQoNCkJScy4NClpoZW56aG9uZw0KDQo+LS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTEv
MTddIGludGVsX2lvbW11OiBFeHRyYWN0IGRldmljZSBJT1RMQg0KPmludmFsaWRhdGlvbiBsb2dp
Yw0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5UaGlzIHBhdGNoIGhhcyBiZWVuIG1lcmdlZCBpbnRv
IHN0YWdpbmcgdGhpcyBtb3JuaW5nLCBiZSBjYXJlZnVsIHdoZW4NCj5yZS1zZW5kaW5nIHlvdXIg
c2VyaWVzLg0KPkhlcmUgaXMgdGhlIGxpbmsgOg0KPmh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3Fl
bXUvY29tbWl0LzY0MTBmODc3ZjVlZDUzNWFjZDAxYmJmYWE0YmENCj5lYzM3OWU0NGQwZWYjZGlm
Zi0NCj5jMTlhZGJmNTE4ZjY0NGU5YjY1MWI2NzI2NjgwMmUxNDc4NzI5MmFiOWQ2Y2Q0MjEwYjRm
OTc0NTg1YmU2DQo+MDA5DQoNClN1cmUsIHRoYW5rcyBmb3IgcmVtaW5kaW5n8J+Yig0KDQpCUnMu
DQpaaGVuemhvbmcNCg==

