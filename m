Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4848EE01FB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soD6s-0005CN-5H; Tue, 10 Sep 2024 22:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soD6q-0005Br-43
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:29:32 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soD6n-0002r0-JN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726021769; x=1757557769;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZJU1/+KI8KvSW38Hot1I1FTb624P4k/Gkihw1HL/FOo=;
 b=WRnDIYoCfXQFvevUV4iHdC3Tt3Yi3XiORPaOtiaxEqaq2z1UD7+oofUa
 QLkVUirHChJoinlPIhy4buym8OHduwZW15xf35VfZQibuWtmRzJ6G1yTz
 rJtJc/j7chox2FlT3ZxRXk5hCrRYpasrH74qEwpxiCSzUpLYvqpVhXq7+
 CntoPVut0SRTKXS3bUqeYSFTwq1mr9C/qTbIyzKpGIEcsGgNsfWC4KaKB
 eN1Jimu5gn5jcnyEqzbhMnGll9YV9YP08kPdXENNzVVp5vAgBBv3Xwayu
 0fFBaN8R1BkzJEq6ymcqDeR2JjvDl813ko0ccpt+nwtUbjndtTV8ffF1Z g==;
X-CSE-ConnectionGUID: XiCCoghtSMiTz85OOMA/SQ==
X-CSE-MsgGUID: iOoKvOFlS/WqpDAUCBjv8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24675408"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; d="scan'208";a="24675408"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 19:29:25 -0700
X-CSE-ConnectionGUID: 05xkFsELQ0K3OtlUW2cExA==
X-CSE-MsgGUID: fkiutFOlQ1WXbbMSFm6rpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; d="scan'208";a="72017372"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Sep 2024 19:29:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 19:29:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 19:29:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 19:29:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVVd9bKvEfN7CWwMJbp6mEhksXduXNu/Pkzjkl52IxiqZg7Ch17qRz60sYujpTbnx2Kj6RL0P7CjSbbPp2pTWers1GSHTFnU6UtHAfwCq4Md8b2r8OCxNl/xSD3B3HOIlfgTTJZKtvTg6T/2hl82OsrBJDH2TdDjlknsFSLMndJQJCoUBu0D/Q7d4aZ9du7NdX7/9d80GkjHgzOYMTT+V4aD4N4yJTTfskcJEau/OWgtyJDeXhByRAtYtAvp1djZEpP4ZMa7pcc6oNWCGFpD3qyc+eMEhjTPxrQeuctQXqjzXjNF5I3seJrnioiZ/VLaGTrihDftZ6hB0hgiUNryBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJU1/+KI8KvSW38Hot1I1FTb624P4k/Gkihw1HL/FOo=;
 b=hZN1qLPSPXb4CnZBAOpBMA9RVrMchxyOhEe2ooYc4d1hAdeT4RkTsbYJhQkxnbSvrHRxETLjgxYWXm94/mHQjuGf8yTgfZWv2WexhWosaODKqlTk4fZFIPWE4VwsKMwQeBxwQm9tZWA/qYF6oz7Rfl5vPIMdDlu9Dlm5HQ9lhX48eDx8gyWsuhWTu0Y+bsf8lh4wF/R/geu5PHVX/wsA1EzEYEOWwIHAZkdQLiOYK/eQgm72xloP06vuR8MnGt/4hotYC3Ma2syD6sqzuLUntJig5jNJUSii6942733VaQr+nJg1yh2MGlKsqWbu7iPhYSyCBRRp5275tQ1dUynULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 02:29:23 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 02:29:23 +0000
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
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Topic: [PATCH v2 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Index: AQHa5wD4GnE8Rdo4hEylPacmeTL9M7JRG2kAgAD691A=
Date: Wed, 11 Sep 2024 02:29:22 +0000
Message-ID: <SJ0PR11MB674439887C1F699C45C704F3929B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <edba8c59-86b5-42ca-ba69-d3160609aaed@eviden.com>
In-Reply-To: <edba8c59-86b5-42ca-ba69-d3160609aaed@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB4843:EE_
x-ms-office365-filtering-correlation-id: 9ee4135e-7c33-40e0-38a5-08dcd2098c4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?b2piRTdtSkRKaFQ0aEhzRDJxclcrSFUxd1ZXWGlxRi83dnlCU3BycXRUcWFC?=
 =?utf-8?B?M1Q4OENaSDVSdE1pUGdtcXg1VVdHOGYxWVZrL1lJelFVWk9sRHEwVmVKN1Ni?=
 =?utf-8?B?Z2hTMU1Yd2NQdmt4U0RZallOUTlVdkMyRXYzdk84MWNEcmNzdnVBVnNCQndx?=
 =?utf-8?B?VVUxM3ZVbGJabk85dC9sWjZ6QnowOFRkVzZDNzh0SFhQdHZZSjdLbFVaRmlo?=
 =?utf-8?B?eVZyVHVwVzQyZ3pEUVV1WFlrUzRCY1dsaFNqM2JoOUdTb3cwTkNsWXpRdm1Z?=
 =?utf-8?B?UnAwYXk2ZjFwVnpDN212NFd1N1pKL05QeW1XRWZaZFAwT2drZ0MyclN5YjJP?=
 =?utf-8?B?SjA5SVdPUXhBRFdJSDJCM2tzSzRLa2ROYlZLY2RJQllaeU5lMnk1N1l0UGJC?=
 =?utf-8?B?WG5jOVZhQnVFMmVPakZ2N2VqQUtRcnVPNVRrcDZQNm0xOHhuZk02L2Y3UEJG?=
 =?utf-8?B?Qm9KZWxXdUM3OHBxOStabGYvZklEd0l3REVXVkg5VTRFUDB0VGF5bjNiQ3BG?=
 =?utf-8?B?QkVrRDR4ZmgzallScnlVRHBsOFg4YTM1eGpTazZrMHJwVVVXcCtwaG8wT2hM?=
 =?utf-8?B?VmRUTlUvUHRMNklXTXJUcFVuTW5ackZMb1Z5MVZJdkRRdHgvZ3IzSDhtSU9w?=
 =?utf-8?B?R3NmQzVBWXdzV25Tc3Fvbm94SGo1d0VqWWgrbG9JTzNtR244OVBOZS9MRVJw?=
 =?utf-8?B?ZXM4NU1PTFBpS1hUV3R2QWRrTlEvbWFBdytWZS94dW5FVEFUTXIzUVE5Vjla?=
 =?utf-8?B?a2s0VjQrZ00rSjR5a2FuVHRqUUJqZys2em5KYnZKMVNYdlJwNkc2aTc2bDBt?=
 =?utf-8?B?Um9zTnVmbXBVNUtrQnhmRTZiOXllMWVSZU12c3l1ckpGUFo2L3FMNVluS2hC?=
 =?utf-8?B?bkFFK1Q3UWlOSzZEZXViTWlFVkF4cmRPWkpUY0dheGMzOHVTWXJDMU1lcjJl?=
 =?utf-8?B?cmdPZXZDYmpNckoremNBWExOSXI2YXRHSEptRnFTTkpnNU11SWJsRjRPVXcz?=
 =?utf-8?B?dHpTRGtPcWlzRkdHTnFER3hSYjlrNlloQ3J3aG03WlhqcExtRnVFb2szU0Zt?=
 =?utf-8?B?TEZMc2VVbVdxamVJa2xqQmxGUWczUWRhVDFQMnQ0WWMrMERPaCtWQkJKYzlV?=
 =?utf-8?B?R2N5VmNIM1BDd2hJVENydWJld1lDbjBNcVEzNHJWbkVOUWpLNzVRQXV2ZE5l?=
 =?utf-8?B?cHFPRXVXcnFOcElCUTE2MjBxYURJU3lzajRLRVJaVHdHSDlmYUpXdE1ObTMr?=
 =?utf-8?B?ZEw4VlpVaUxPWEVkRUlwbEhDL1p5TVliQWkvSlRkVHBrTDhiRGxIVWxlOHIv?=
 =?utf-8?B?RXV4U3loWW5mMi9OMUhNeXRyR0lkUDI5eHRBeEVZLy91d1BmbkZsUlpFUW5t?=
 =?utf-8?B?ZWJXclQ0V3FHWFFudktXMW5BTWVYUThqUUVXR09FMGVnYWZYYlVPMTRQQk8v?=
 =?utf-8?B?UFlPRi9iN1JXdFd4M3BUQ1lCT3o3cEpHMmZkVjUvNVNOelR0VGFKRXdZY2dU?=
 =?utf-8?B?MDlEZmdmT29LVnhpYmIxMmpLRGNvMnljZ05WVHd6QmxkQ1ptUjA2Yjk0V3FF?=
 =?utf-8?B?VHphclhrRXNqeXhONGVlQ2VkMC9QekIwQmZaRTNJYjF1UkhHbkVuN0ZuRk9z?=
 =?utf-8?B?VVNJUVJVYnk4QkdjUi9peFJKaU5Wc1VQblJXc3VyNWlKUXg0alIvRGd6SzA0?=
 =?utf-8?B?KzU2dnJzZjJUVHJTa0g3TmdEQ2JiWHFUOFBiVWl5aS9JZE9PWmxjdWwyc2hT?=
 =?utf-8?B?ZGpjRXRNUUFtSkdKRTVubVdMaE5Xc0VRRU4yQnJXSExmdTlMZ2x4TDZBclJQ?=
 =?utf-8?B?bjhnUHVURDh6SHBHQ0tUWDdFRFBBWHRqdEkzNzBMZThlY0h6VldGU3VVRW15?=
 =?utf-8?B?U0ZlQXV2L2ZFRjFkQzlxWUJPWXVpVTlZeExZUGJLWjZLZGgwMWRsUDdTSEpB?=
 =?utf-8?Q?3UDEa6YRjXc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVk3WXpWOVVxQ05DOEpyOUFWWTBvSmVWM1hndFpFclB6b1AzZUtyT0hyR0lJ?=
 =?utf-8?B?QzdWMjRvbjd3TnMybDJ1aVMrWEY1aDlUK2h2ZE5FMzZ6cUkxQnpycnJLdjh0?=
 =?utf-8?B?NVQxRXlLSWZNN1gzdzdxVXI1djN4dVBCaHRCMXJSVnAwTlpFblM3czI4dmxi?=
 =?utf-8?B?YlRnVEFneGVYUlNwL1pwdFFsdTFjZXRHdUZyeXRDMWJuMU1BSnV2SEhlSWVQ?=
 =?utf-8?B?ODUvbGI0RllUaHJ1eWMzRTBYazdPeFg0T1NaZzZrcm1VY3JHajR3T0F6NUVy?=
 =?utf-8?B?Sk9tZDYyTFJwQjdaZnMxTnRqcGlYL0F1SzQxRDh6R1lSdHJSNnlkR1FtMzli?=
 =?utf-8?B?MEdISHptTXd6aVcvWWIxcnpRbWJjZmljazl5cDF0VGo2ZUVJNFNhT0tVZ2sw?=
 =?utf-8?B?Z2xiWTdEdGQ0ODNhR3k5RHJYcnlOam9QMlhNRGFLekRPbDZkQTh3TmErSW13?=
 =?utf-8?B?ODRndUdSODBWa3ZaSEdVMnFoa204SW1STVFSU0JES1J0cU1oT0dyMDBEeG1z?=
 =?utf-8?B?cFJwS2sycnNCY3NleGlXSk5Bbm5CV0hObDhFeU1vOE5JWmwxSlZvZ3Uwd1Q5?=
 =?utf-8?B?dGhMRXh1VXd3NHkzaEVPN2dndUlFdWszYzBMekFVdTBNUUpKRWtBOStDT3Ew?=
 =?utf-8?B?eVZlcDdsUjA5bE9ScncrY3c3TThoV2hLNzdITnpZeWZpbGNLUC96SXVSSnMx?=
 =?utf-8?B?Mm9jeVRtd2VPa3hVVE8raWJMTzNkZGN0dmFFSUpKK0RNNXZ0V29rRVlTMzlz?=
 =?utf-8?B?R3dWYkdWL3VCUVJ6bE5FVGJiZVg4TUl5KzVLeXF5ZFQ2YjRrL3dzcXgwVkpK?=
 =?utf-8?B?dDZ5bFA4LzRHRTdFeEZEQ1BHdFF0eElyZ1Nsd2FPQW5Dek9HUjZmRkhvVnYr?=
 =?utf-8?B?clVFZ2s1My9LTlUySlEzbXFMQXRJRm1aRUQ1Y0FGRG1PSGtNQnhDWnRndGx4?=
 =?utf-8?B?VEp6VWlMZkVTMHNFWWdrYTJQNWtWbjU0SVdHOHVrQW92TTZDdUxrME9FM0gy?=
 =?utf-8?B?RklQaUs1OFMvdUpWYXVPR0hlQ1JpY0xGaG9Cd1dWWUc3V083blZMTXIxZEtm?=
 =?utf-8?B?bEJwL04yRHVxKzZhN000Qmljd01DV1poTHA3SGdQU1JJQno5ZkJrS2YxMk9O?=
 =?utf-8?B?c2ZVWVhCNFlDMVMxN1AvbFhYckVVekdvZkZLWGNKQmVidFVNa0lZTXhzaDl1?=
 =?utf-8?B?eGZsWEFsS1pMYTBCbEM3VnU4ajdjS3ZzYzRDS0hHeW9BNlpPUS9rUksxdHFl?=
 =?utf-8?B?a0JQRVBUNHkraE9MR1Y3OVk3eUgrUWptMTlpemdqUnhaWmloUXVEbkhPTjMz?=
 =?utf-8?B?S1dvbFBhWUhUU0ZIK1VMQ0h1TExRZ3cyNGNhTjV4SGc3a2lvWXFlY0xkYVFV?=
 =?utf-8?B?eDBRM1dOaGhIZTdvbDZsNGwxd1dJQjhvVlZ4cGFoS1kvVno2NEZONGE2QlNv?=
 =?utf-8?B?OGIwV1FlTjMrTElTb2VVQ2tsOE5NUTd1SHN4WkNWTnVzaE5zenNxVUZCWE9G?=
 =?utf-8?B?UVdoUUxIL3kzbVVCYnljKzhMWUlIaHJJR3pQNVNOd3N5VDI2K3pxTk05UmJ0?=
 =?utf-8?B?K0J4Yk4zcm9wWVhJMSs2WXVVZGgwQm5SU1AzODE0WExYWEdYOEt5M3poUUpS?=
 =?utf-8?B?KzV3VEhuYUpGRG8wYklGNGhSVS81ZFdLYjJKM3hFamcyNVhCWFljeUJGRzFr?=
 =?utf-8?B?M0ZRblpQOUdIUitLYVQvOGdQd09wY0orWVIxWmdSdEE5b1lCR3B1Z2htZGxW?=
 =?utf-8?B?SnVMSk1jWGI2OU5qcDdsL1ZFdzh5ckRPaVpwaTVlVU9DbzJwaVpoT0VEdHF0?=
 =?utf-8?B?VzRzeCsyKzNvVWJLUGVMK1ZNMCtEZVpzc2I4K1dIRStwaDI2VDlYQVVzd1Vj?=
 =?utf-8?B?L3RTT2Z4Qk1nTE9Ma0c0T0F2cHYyRlovNnV0cE9MaGNKY29nR09QNjZDclFC?=
 =?utf-8?B?eTFYMStiTlBRbWd5a1g0YXYwMWF3cGpWWFN5RkFYai8rVXhVNFJWYmVkWk5s?=
 =?utf-8?B?eUlxaXlEaHBXczMxQ09jSUVUcjRYSkdoZlJQVnY3dnp0Ymg2dTMzVWYxMkZU?=
 =?utf-8?B?Y0NhWk9NTk9QeUVGWmhYWXJuSkpJdHU5RE0yQXY2YUpQbVlYSkp1a2pXWjd2?=
 =?utf-8?Q?DcD/BxciU2tjbxJN9SRgpCMle?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee4135e-7c33-40e0-38a5-08dcd2098c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 02:29:22.9705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNUI7Y5zU3Z11UFmBVpPoGER6iaLTDAtH8VBd/mjTJEENd+uMcp3pEa8o2Yb7tE5zAVmcSB4HcJp7FIwnzUawxqZVjBpfgAYPVkIXFNoGlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

SGkgQ2xlbWVudCwNCg0KWWVzLCBJJ2xsIHNlbmQgYSB2MyBpbiB0aGlzIHdlZWsuDQoNClRoYW5r
cw0KWmhlbnpob25nDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1F
TlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAwMC8xN10gaW50ZWxfaW9tbXU6IEVuYWJsZSBzdGFnZS0xIHRy
YW5zbGF0aW9uIGZvcg0KPmVtdWxhdGVkIGRldmljZQ0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5E
byB5b3UgcGxhbiB0byBwb3N0IGEgdjMgZm9yIHRoaXMgc2VyaWVzPw0KPg0KPlRoYW5rcw0KPiA+
Y21kDQo+DQo+T24gMDUvMDgvMjAyNCAwODoyNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBD
YXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sg
bGlua3MsIHVubGVzcyB0aGlzDQo+ZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+DQo+Pg0KPj4gSGksDQo+Pg0KPj4gUGVy
IEphc29uIFdhbmcncyBzdWdnZXN0aW9uLCBpb21tdWZkIG5lc3Rpbmcgc2VyaWVzWzFdIGlzIHNw
bGl0IGludG8NCj4+ICJFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3IgZW11bGF0ZWQgZGV2
aWNlIiBzZXJpZXMgYW5kDQo+PiAiRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yIHBhc3N0
aHJvdWdoIGRldmljZSIgc2VyaWVzLg0KPj4NCj4+IFRoaXMgc2VyaWVzIGVuYWJsZXMgc3RhZ2Ut
MSB0cmFuc2xhdGlvbiBzdXBwb3J0IGZvciBlbXVsYXRlZCBkZXZpY2UNCj4+IGluIGludGVsIGlv
bW11IHdoaWNoIHdlIGNhbGxlZCAibW9kZXJuIiBtb2RlLg0KPj4NCj4+IFBBVENIMS01OiAgU29t
ZSBwcmVwYXJpbmcgd29yayBiZWZvcmUgc3VwcG9ydCBzdGFnZS0xIHRyYW5zbGF0aW9uDQo+PiBQ
QVRDSDYtODogIEltcGxlbWVudCBzdGFnZS0xIHRyYW5zbGF0aW9uIGZvciBlbXVsYXRlZCBkZXZp
Y2UNCj4+IFBBVENIOS0xMzogRW11bGF0ZSBpb3RsYiBpbnZhbGlkYXRpb24gb2Ygc3RhZ2UtMSBt
YXBwaW5nDQo+PiBQQVRDSDE0OiAgIFNldCBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFi
bGUgbW9kcmVuIG1vZGUNCj4+IFBBVENIMTUtMTY6RXhwb3NlIHNjYWxhYmxlICJtb2Rlcm4iIG1v
ZGUgYW5kICJ4LWNhcC1mczFncCIgdG8gY21kbGluZQ0KPj4gUEFUQ0gxNzogICBBZGQgcXRlc3QN
Cj4+DQo+PiBOb3RlIGluIHNwZWMgcmV2aXNpb24gMy40LCBpdCByZW5hbWVkICJGaXJzdC1sZXZl
bCIgdG8gIkZpcnN0LXN0YWdlIiwNCj4+ICJTZWNvbmQtbGV2ZWwiIHRvICJTZWNvbmQtc3RhZ2Ui
LiBCdXQgdGhlIHNjYWxhYmxlIG1vZGUgd2FzIGFkZGVkDQo+PiBiZWZvcmUgdGhhdCBjaGFuZ2Uu
IFNvIHdlIGtlZXAgb2xkIGZhdm9yIHVzaW5nIEZpcnN0LWxldmVsL2ZsL1NlY29uZC0NCj5sZXZl
bC9zbA0KPj4gaW4gY29kZSBidXQgY2hhbmdlIHRvIHVzZSBzdGFnZS0xL3N0YWdlLTIgaW4gY29t
bWl0IGxvZy4NCj4+IEJ1dCBrZWVwIGluIG1pbmQgRmlyc3QtbGV2ZWwvZmwvc3RhZ2UtMSBhbGwg
aGF2ZSBzYW1lIG1lYW5pbmcsDQo+PiBzYW1lIGZvciBTZWNvbmQtbGV2ZWwvc2wvc3RhZ2UtMi4N
Cj4+DQo+PiBRZW11IGNvZGUgY2FuIGJlIGZvdW5kIGF0IFsyXQ0KPj4gVGhlIHdob2xlIG5lc3Rp
bmcgc2VyaWVzIGNhbiBiZSBmb3VuZCBhdCBbM10NCj4+DQo+PiBbMV0gaHR0cHM6Ly9saXN0cy5n
bnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjQtDQo+MDEvbXNnMDI3NDAuaHRtbA0K
Pj4gWzJdDQo+aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25n
L2lvbW11ZmRfc3RhZ2UxX2VtDQo+dV92Mg0KPj4gWzNdDQo+aHR0cHM6Ly9naXRodWIuY29tL3lp
bGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25nL2lvbW11ZmRfbmVzdGluZ19yZmMNCj52Mg0KPj4N
Cj4+IFRoYW5rcw0KPj4gWmhlbnpob25nDQo+Pg0KPj4gQ2hhbmdlbG9nOg0KPj4gdjI6DQo+PiAt
IGNoZWNrIGVjYXAvY2FwIGJpdHMgaW5zdGVhZCBvZiBzLT5zY2FsYWJsZV9tb2Rlcm4gaW4NCj52
dGRfcGVfdHlwZV9jaGVjaygpIChDbGVtZW50KQ0KPj4gLSBkZWNsYXJlIFZURF9FQ0FQX0ZMVFMv
RlMxR1AgYWZ0ZXIgdGhlIGZlYXR1cmUgaXMgaW1wbGVtZW50ZWQNCj4oQ2xlbWVudCkNCj4+IC0g
ZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfRyAoQ2xlbWVudCkNCj4+IC0gbWFrZSBlcnJvciBt
c2cgY29uc2lzdGVudCBpbiB2dGRfcHJvY2Vzc19waW90bGJfZGVzYygpIChDbGVtZW50KQ0KPj4g
LSByZWZpbmUgY29tbWl0IGxvZyBpbiBwYXRjaDE2IChDbGVtZW50KQ0KPj4gLSBhZGQgVlREX0VD
QVBfSVIgdG8gRUNBUF9NT0RFUk5fRklYRUQxIChDbGVtZW50KQ0KPj4gLSBhZGQgYSBrbm9iIHgt
Y2FwLWZzMWdwIHRvIGNvbnRyb2wgc3RhZ2UtMSAxRyBwYWdpbmcgY2FwYWJpbGl0eQ0KPj4gLSBj
b2xsZWN0IENsZW1lbnQncyBSLUINCj4+DQo+PiB2MToNCj4+IC0gZGVmaW5lIFZURF9IT1NUX0FX
X0FVVE8gKENsZW1lbnQpDQo+PiAtIHBhc3NpbmcgcGd0dCBhcyBhIHBhcmFtZXRlciB0byB2dGRf
dXBkYXRlX2lvdGxiIChDbGVtZW50KQ0KPj4gLSBwcmVmaXggc2xfL2ZsXyB0byBzZWNvbmQvZmly
c3QgbGV2ZWwgc3BlY2lmaWMgZnVuY3Rpb25zIChDbGVtZW50KQ0KPj4gLSBwaWNrIHJlc2VydmVk
IGJpdCBjaGVjayBmcm9tIENsZW1lbnQsIGFkZCBoaXMgQ28tZGV2ZWxvcGVkLWJ5DQo+PiAtIFVw
ZGF0ZSB0ZXN0IHdpdGhvdXQgdXNpbmcgbGlicXRlc3Qtc2luZ2xlLmggKFRob21hcykNCj4+DQo+
PiByZmN2MjoNCj4+IC0gc3BsaXQgZnJvbSBuZXN0aW5nIHNlcmllcyAoSmFzb24pDQo+PiAtIG1l
cmdlZCBzb21lIGNvbW1pdHMgZnJvbSBDbGVtZW50DQo+PiAtIGFkZCBxdGVzdCAoamFzb24pDQo+
Pg0KPj4gQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiAoNCk6DQo+PiAgICBpbnRlbF9pb21tdTogQ2hl
Y2sgaWYgdGhlIGlucHV0IGFkZHJlc3MgaXMgY2Fub25pY2FsDQo+PiAgICBpbnRlbF9pb21tdTog
U2V0IGFjY2Vzc2VkIGFuZCBkaXJ0eSBiaXRzIGR1cmluZyBmaXJzdCBzdGFnZQ0KPj4gICAgICB0
cmFuc2xhdGlvbg0KPj4gICAgaW50ZWxfaW9tbXU6IEFkZCBhbiBpbnRlcm5hbCBBUEkgdG8gZmlu
ZCBhbiBhZGRyZXNzIHNwYWNlIHdpdGggUEFTSUQNCj4+ICAgIGludGVsX2lvbW11OiBBZGQgc3Vw
cG9ydCBmb3IgUEFTSUQtYmFzZWQgZGV2aWNlIElPVExCIGludmFsaWRhdGlvbg0KPj4NCj4+IFlp
IExpdSAoMyk6DQo+PiAgICBpbnRlbF9pb21tdTogUmVuYW1lIHNscHRlIHRvIHB0ZQ0KPj4gICAg
aW50ZWxfaW9tbXU6IEltcGxlbWVudCBzdGFnZS0xIHRyYW5zbGF0aW9uDQo+PiAgICBpbnRlbF9p
b21tdTogTW9kaWZ5IHgtc2NhbGFibGUtbW9kZSB0byBiZSBzdHJpbmcgb3B0aW9uIHRvIGV4cG9z
ZQ0KPj4gICAgICBzY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPj4NCj4+IFl1IFpoYW5nICgxKToNCj4+
ICAgIGludGVsX2lvbW11OiBVc2UgdGhlIGxhdGVzdCBmYXVsdCByZWFzb25zIGRlZmluZWQgYnkg
c3BlYw0KPj4NCj4+IFpoZW56aG9uZyBEdWFuICg5KToNCj4+ICAgIGludGVsX2lvbW11OiBNYWtl
IHBhc2lkIGVudHJ5IHR5cGUgY2hlY2sgYWNjdXJhdGUNCj4+ICAgIGludGVsX2lvbW11OiBBZGQg
YSBwbGFjZWhvbGRlciB2YXJpYWJsZSBmb3Igc2NhbGFibGUgbW9kZXJuIG1vZGUNCj4+ICAgIGlu
dGVsX2lvbW11OiBGbHVzaCBzdGFnZS0yIGNhY2hlIGluIFBBU0lELXNlbGVjdGl2ZSBQQVNJRC1i
YXNlZCBpb3RsYg0KPj4gICAgICBpbnZhbGlkYXRpb24NCj4+ICAgIGludGVsX2lvbW11OiBGbHVz
aCBzdGFnZS0xIGNhY2hlIGluIGlvdGxiIGludmFsaWRhdGlvbg0KPj4gICAgaW50ZWxfaW9tbXU6
IFByb2Nlc3MgUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9uDQo+PiAgICBpbnRlbF9pb21t
dTogcGlvdGxiIGludmFsaWRhdGlvbiBzaG91bGQgbm90aWZ5IHVubWFwDQo+PiAgICBpbnRlbF9p
b21tdTogU2V0IGRlZmF1bHQgYXdfYml0cyB0byA0OCBpbiBzY2FsYWJsZSBtb2RyZW4gbW9kZQ0K
Pj4gICAgaW50ZWxfaW9tbXU6IEludHJvZHVjZSBhIHByb3BlcnR5IHRvIGNvbnRyb2wgRlMxR1Ag
Y2FwIGJpdCBzZXR0aW5nDQo+PiAgICB0ZXN0cy9xdGVzdDogQWRkIGludGVsLWlvbW11IHRlc3QN
Cj4+DQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgIGh3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICA5MSArKysrLQ0KPj4gICBpbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgIDkgKy0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5j
ICAgICAgICAgIHwgNjg5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4tLQ0KPj4g
ICB0ZXN0cy9xdGVzdC9pbnRlbC1pb21tdS10ZXN0LmMgfCAgNzAgKysrKw0KPj4gICB0ZXN0cy9x
dGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAgIDEgKw0KPj4gICA2IGZpbGVzIGNoYW5nZWQsIDcz
MSBpbnNlcnRpb25zKCspLCAxMzAgZGVsZXRpb25zKC0pDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0cy9xdGVzdC9pbnRlbC1pb21tdS10ZXN0LmMNCj4+DQo+PiAtLQ0KPj4gMi4zNC4xDQo+
Pg0K

