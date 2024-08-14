Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D2CC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 02:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se3mt-0004nF-DS; Tue, 13 Aug 2024 22:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1se3mk-0004KG-8O
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 22:30:51 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1se3mh-0001aV-Qq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 22:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723602648; x=1755138648;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ALm8X5hqCeypKZ0MB+p8kFfLCDjVSXJnqCCq2OYrXso=;
 b=I81kkoQOu6FdzrRt+REW2DHJMuQIQSkVTR/7b1MVGIuSVgSofiTE8JZq
 yd8MkFRAzOqgkgpdikNwhFHl9dhwlXIy/idVwdsppOCnLNG10B/aAm5Nr
 UbMOX2nS7zktqe4QfLzmGy8oj8LLU83xBarddXjoNFrXKTdsW2Ql/QXCI
 +amaVq5AbjrosXyJKVDQWf1ZFbg+p87y/aGwdEPy5AHKpcV7Xu/bjI9le
 QV5LUkBbn/OS9nVnvu8gbeX0hQmTuO9UmELm7hcpRDgmUcf43c3V+yo40
 +OU/uyiQCwFPlEhLaDxtsXdz2PQi3V7lM1cWp7yfQiSQnHuliFlmhfu0e Q==;
X-CSE-ConnectionGUID: sU41OKS/RJiE9Ur4sfOYMg==
X-CSE-MsgGUID: 5PoBzn6VQl++fwnnJPfXmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="39246645"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="39246645"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 19:30:46 -0700
X-CSE-ConnectionGUID: gj6GH925RXy8hgvf3FILhA==
X-CSE-MsgGUID: PyZCGsPMQWS8qiV/ZRUjHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="58551340"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Aug 2024 19:30:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 19:30:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 19:30:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 19:30:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 19:30:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXGmgMiTqBrI9ubmzNJDxxo+HFcZEsFg0rc0I78E95o/J+vQ6+nvcRuy74faN5nGA5o4cXy4m/qvQ7LZIBc1WmIQpXbB4XRWS8PdfIr8WRsp+iQkeYeaV1f2d39N1Y4D4oOwdm56/QPIVjyuOZ0biTWlW6AW+uMRhFk6+1MvLMpHMflOAl6LfmPFtjMcF2MLvmllzZZn888HeRPKYfbwTPrHpnHhRUYVmGV0Oew4i9BfFck9UFbqowBLW8KnCl3Clyibbrr0yoXHt746m6ATu5a7ssN2yRI78N/Lf+dVAPGps9TlZXR5KrB/7Fu0bvGi8ZzICZ8A229JznuzQOHbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALm8X5hqCeypKZ0MB+p8kFfLCDjVSXJnqCCq2OYrXso=;
 b=kJ0e9kLfVIeKOuhEVfw1hRlNC63BfU/US3qHNnrXpdnkqAI30I6aTrznVcA5+nNgZzksxDVGiK94z7sDsg4fjCA2xbxNc+WbXyeGBHw+7JRFpxKB09rPB1w1jdMjvEFcGxUcCJj7BHovh+Y46FkVFKY5kM+R9d0SrKdGh9/anBt8KmgCBVmucyZ8X+9BVbvGf7hqACgfHBLvn7TGK77ZUjuu43hg0EB2EwiI/txhmXCBaRmGDN1FIThzBS1Q8Qkj3wgt5qLER/0pnFBaIIwZQ0gNNdFoZmxyitEGSX5A3aeqlg4l7ZhUAHvuLlfW+SfqQIF/fOFWZPGRRan3LymigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 02:30:36 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Wed, 14 Aug 2024
 02:30:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v2 01/17] intel_iommu: Use the latest fault reasons
 defined by spec
Thread-Topic: [PATCH v2 01/17] intel_iommu: Use the latest fault reasons
 defined by spec
Thread-Index: AQHa5wD3ePoUGCDjckyB75pG24FakrIlERAAgAEBTgA=
Date: Wed, 14 Aug 2024 02:30:36 +0000
Message-ID: <SJ0PR11MB6744188480973E2D7E41D77C92872@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-2-zhenzhong.duan@intel.com>
 <a2894553-cd5f-4ebc-80c6-6b33128ceefe@intel.com>
In-Reply-To: <a2894553-cd5f-4ebc-80c6-6b33128ceefe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6802:EE_
x-ms-office365-filtering-correlation-id: d53cc5bc-5859-4261-e18f-08dcbc0914a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WlZMRDJqU3daQnlETGR6eFd6VVIwSEhBeXZzS0REeWVUcHlqUE4xSXJpSU54?=
 =?utf-8?B?VGd1c1N2b0txZ2NET0NyQjdSa0JoVERyQ3hmSFA1N3NXdzVQaFVTSDFCV01L?=
 =?utf-8?B?RW9aNkxjcURmdUJvaE5TZ1hWZUhvKzlNMXhLeElTVFY4OGFJa09zTFJIekdF?=
 =?utf-8?B?RlRoRmJ2a1REK1hwRGNuQm5kRmZYZGZ2YUdJMnladmp2akpYeHZVYTlxekpJ?=
 =?utf-8?B?dWZoWk5NODhKcU4wYnRPTFBVNXpTSXRhdlViUlBCdjVOelFBWDNyYWREVU5M?=
 =?utf-8?B?TFZiL3EyOEo0ZFg5Ym9MMWw4Z1hXdzNFOHVZVmxtdEFMTHJTdHZsOWxrMGJU?=
 =?utf-8?B?SXM0ek5RMkplTmRNdi9iWHB5ZC9XYlNadUJjSXBXWWZjdktTZkhzMmk4T3Vi?=
 =?utf-8?B?Q2NUcDZzZEhHMCtrTnBqdFhZWVFCd0toMWRkMjgweUt5TzVHc1dCZWRRdldp?=
 =?utf-8?B?czNZc2NxZHlTWm55RDM0MDl3ajJKayttVllmdEpRQ2Y4SFlRNm4wT1ZlZzh3?=
 =?utf-8?B?SFV0cTFtWEtraHhpbGNwYjRaWGF4eS8wZ0xPVnVqUkxlVXFiOHlFTlpFTGpP?=
 =?utf-8?B?VS9rdzJIUytSVWY5S2wvbjF0djRqTTdSV2dUSHJtSGJ1YmdmU0RpWnp0VUhP?=
 =?utf-8?B?SXJGME41QllHQVBsYTNmVERnVXB6a0pVam01YXUwRWdxdU5FbktmTDdWZ1FQ?=
 =?utf-8?B?TEgydVF3WElRUWxYc3B2Zk90THM0a2lsV1dmWmFmN1BwdTNMQkRVVmo3Rlhm?=
 =?utf-8?B?SXlNL0tSbithNmJyTWpnclViRWlhTUwrWFlQdFpUeHJtaVh2OFdwMkZiSTRO?=
 =?utf-8?B?MEV3cVg4M3gyME82NTFnRXBLai8xVjVDdUVmOW9mMFZib0tvdXIzS0Exbi8x?=
 =?utf-8?B?Y0lDRmxOcHBkdXJYMXlGRGF5allzeU1hbTEvaEc5Q1ZxMnF2c1JNYkJTbWtF?=
 =?utf-8?B?WmRRNlMvNVFPRDhOSWlKYVJxVEJXSDhpRXFlRFhCMWNmUWRsVll6aUZMZk5o?=
 =?utf-8?B?TFZ6V05LV2FHdGNDd0tNZ29XeTJtcnhNaUxzeTNmN0svVmNmU3NkVTZoRWpk?=
 =?utf-8?B?cGNpSlJzUlJ0c01LblZDL0poMDVCUHVtOGN1OXVJUE1ONS8wNmo2NDdONnNs?=
 =?utf-8?B?QkZsZHlKNGQvTkxjRVYwaFlyVXFBU0hZS0RCNDBzaThDNWdQalZGQlhCbVd6?=
 =?utf-8?B?Y05MNWpnQWwxNnZGZm1pK0Z1aGdMWHd6NWxwSUxIUjdIMmc1QW5lVEVjQWM3?=
 =?utf-8?B?NVA4dU9PZFVNZFlNV3dYb2wxeUpEVnBHOE5CVmR4VnFaVDE5M0tnM1BqNjRy?=
 =?utf-8?B?S2lMMHd4Z0JMNzVoMy81WVY4VFhiT3ozS081QXF0a242SVpzaVFvWEJnM2JE?=
 =?utf-8?B?dlBDT3FVMWw4Y1EvU0dFSTYwNVI5blpNMEJqSUJ0bEhiVnVtZFpocXQ3Yndn?=
 =?utf-8?B?Wi9wdnhjRUFlVFl2OFM3RzZYbGlvS2xJWDh4TG1UNWIzb3ZSSHRiZllXTm92?=
 =?utf-8?B?dWZMSi9XOGk3QnBZb2d4MFNYcXQwRHR3ZFlmbFBLUkFsK1o4UlZadUJ3QVpr?=
 =?utf-8?B?K1REdXVhQXpCaVBvY0JZby90MkRtMktveXFRb3lWMk0rZ3dBQmdUb2wydTZ4?=
 =?utf-8?B?eHFLYkZSNzVKZUdOaWpHakRtOW5UamIwa3NOWjZQY3Fzem82WG5JY1dUUWZK?=
 =?utf-8?B?RDBENUM1akRQMGtnTm5Wb0drNVN4d3lXa2lzRTBFUlJpZlhzMVdkTVh4SGla?=
 =?utf-8?B?bjg4M2UvRUJic2hhekNFM3l6S0hzVlNSTFN0S3N5enZnTWFMaTMwR1RvamY2?=
 =?utf-8?B?clVudXh1b0VvR05sZllzOUNpblFrSXNEMkhpK2FoRmxKdkxzWXkxV0dOb2kx?=
 =?utf-8?B?dkEzZGpISklWOUtPeUkydHM0ZmlQYVlqWTB2R2crcGVEYWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWE5Y0QvQmtYc05wQ1RXWElJQnBBR0NuaU4yUHJZa1p3eVhGSkdDVFFxeWZH?=
 =?utf-8?B?ZWxBRE5LNnA0Q2UwTGtIcXg1Zmp2OFpkeUtGdlYyVmJCbW1RSGQ2Q2ZqTXpm?=
 =?utf-8?B?R25weVFRL2xrWG1JdmZtSHcyeUJkaWc1OWdSUXNnaC8vSXNaNlowbTJpd1RN?=
 =?utf-8?B?UHMrbEpZOFMxazNyZFhMNTBwWmxOM0IrTXlXd0pJYUFENXE1M0N0b2wrSG9B?=
 =?utf-8?B?RXBZaXNkczNtL2pCSUpzVEpDb2xSeFN4QW5Rcno4QnZBOUVvS3A1QVlCMEU0?=
 =?utf-8?B?bkVoQ0crbkJNWVpBbGFHSi9wTjZwbVhIY2c2OUhtTysxbUVPaVFnRGlLOFAx?=
 =?utf-8?B?L2NWdjhNZzFRQnR5ZVBwSlg1d0trR0JQSEd0QkJ5WHpjbWtvaVZ1RnlxTGt0?=
 =?utf-8?B?QUVlWkJHSVY5NkY2UXBPeitQV0k2MU95eGFSejVQTDZiSGw3Wm9MRkg1OTdN?=
 =?utf-8?B?dmNibFFnN24yTEUrcUx5UTVCTFUxRnZXUURUbVYwZEpEWVFRdDNzQkVDVFZs?=
 =?utf-8?B?NGo3S2o2bWk5bFVGNHJkdCt4bjJJL29jTEFCMUQ0VTBWU2xBV0lnREtTb2Jt?=
 =?utf-8?B?YkthSHJFT3JEakJjQ2ZXUkVKU0NNQzFsajRLME45YTc4WWNsSjRxa3JQeExD?=
 =?utf-8?B?cHV4ODBWRytMTnJQb0MzV3EzSTVSWTBUZTlxMEI0Nm15b05CSTIvVWxTS0Nq?=
 =?utf-8?B?QVQ3NFltakhTTUM0SUhrZlBkNzlKQXNRN3g1UXhZdW1TSXl5MzlhV05Xc0Nt?=
 =?utf-8?B?bnNaYndsT3diTXBSdVFBcnFlT2pZR0xyWXRudTBaSTR5ZmkwOG9vWit1dlVB?=
 =?utf-8?B?T2lxNnIrdFZmdkRaVzJGcm83cVJXQzNCUE1FUHhyMXZuSExSOWRxZHFTY2o3?=
 =?utf-8?B?SGdZc1BnYjNkamRoN0RMOFlhWmFUVnI3Z1NoL2dpR3ZESmtMK2tlU2ZTUFU5?=
 =?utf-8?B?NkkxUjNhRTlDUCtOV3FlaGhHSmZqM1hJNEpiNHZZUS85SFpVeW94enRXdDdp?=
 =?utf-8?B?RmpTdCs0YUN5U3A1cE0rOFBDN0RzYThhYmV2TnJwMXdGV3ZLWWtmVmdqVDlp?=
 =?utf-8?B?S2NURWZqUkZxVEZpRTAxTElOb3cxMldWeUlRS2FQNEFlZkNvcEIwd1JqNG4x?=
 =?utf-8?B?NDY1VVEzRTh3UmNXMlpHVnRiRzlPOWFYMEkvTklyQkZYcEwweTNlcldiRVV2?=
 =?utf-8?B?QkxIMlFreUVsQ2xwZWhKVUMraEJPYzNHdUxiV3paSnVQME0xVElsdWJvVnU0?=
 =?utf-8?B?RUl3M1J0MzF1TUxjVk5qN2FNbjBoQUlCbW1lVm9zeUhaYVZoMTZnSjBJRko1?=
 =?utf-8?B?SklpWnllaHh5anZHL2ltd1czZkhnRlZ4dU1KVitvbmJicG93MllXQmxWdEw5?=
 =?utf-8?B?cnFmU0FpMy9SWjhrZWxNczFMbDdZRG5LMTRlRjUxd3hOOWJYRjl4RnRObXZU?=
 =?utf-8?B?ZTE3bFA2WnJQN0hNbzVaRFlPU2c0dTR4Ym10SGdlTFcvMzh3bUxpRHZaOUtF?=
 =?utf-8?B?MVRDQnh1bUJjS3FDejlXalRabVArWnV0NmJJdnJsVkhqeDRIdHUzeHZ6MW55?=
 =?utf-8?B?cHpqQlcyOGNyWGhPV09kUWJ2ZTlxUkdydVpuM3NrbllXK3ZXMXJpMlZEdlEz?=
 =?utf-8?B?enUyUGRaOGdSQnFxM2haUDNRd2xSRnRTMU5MaVc5OFRDU3c0dndueVJrQWhx?=
 =?utf-8?B?MmRBUEl2bjdKVHN6TmxoVHNEMnlTY3hHRXdNVSsvTzB6UFdIYjFEczR4OVYx?=
 =?utf-8?B?cHEyU0J3empTRS9qV3IrRmp5RjVNdWVWUllLRFFXRENsREhwRUFUZjdicnJE?=
 =?utf-8?B?b1dyZ0l3aGdFUGhDYjJ2MWJoQUNUcEYwOERsSlRRS00xS3NEeEJmSWlybmVv?=
 =?utf-8?B?TWtZQXJQcGl2MnhPeW1zZnd6UjdvUjV6WU9mSTdKYkJLYy9QWWdLZmFCV2xt?=
 =?utf-8?B?TFo2R0NZUEk4SWhiNm9yY2l0cUtwcWtIV3c5TEJxNGhieVAwTjJGRE1RQjQ3?=
 =?utf-8?B?T0FzSjh4Wkplckc5czFGQlR0RHhXRXRORitNZW5VMTNIQXNKcms5dWFiNjZ3?=
 =?utf-8?B?VzdIeUs5NXlsRXU4OEllYzZkWGEwOUU0SkNweUpiNWxTbXY2dEVrbUhTRUpC?=
 =?utf-8?Q?TH4ab2u5P9RHPQf7MvO7XPdJz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53cc5bc-5859-4261-e18f-08dcbc0914a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 02:30:36.6422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KPcORpkhvL3TEWuRmYpCKibiUG23+kncb8ri7YyPXulaf8YODFG5SdYNhBDxi4zvUH7N5VuYKagXKfy6TKNhfs+5ePQ2Va3/S+ZSNfieb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDEvMTddIGludGVsX2lvbW11
OiBVc2UgdGhlIGxhdGVzdCBmYXVsdCByZWFzb25zDQo+ZGVmaW5lZCBieSBzcGVjDQo+DQo+T24g
MjAyNC84LzUgMTQ6MjcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gRnJvbTogWXUgWmhhbmcg
PHl1LmMuemhhbmdAbGludXguaW50ZWwuY29tPg0KPj4NCj4+IFNwZWMgcmV2aXNpb24gMy4wIG9y
IGFib3ZlIGRlZmluZXMgbW9yZSBkZXRhaWxlZCBmYXVsdCByZWFzb25zIGZvcg0KPj4gc2NhbGFi
bGUgbW9kZS4gU28gaW50cm9kdWNlIHRoZW0gaW50byBlbXVsYXRpb24gY29kZSwgc2VlIHNwZWMN
Cj4+IHNlY3Rpb24gNy4xLjIgZm9yIGRldGFpbHMuDQo+Pg0KPj4gTm90ZSBzcGVjIHJldmlzaW9u
IGhhcyBubyByZWxhdGlvbiB3aXRoIFZFUlNJT04gcmVnaXN0ZXIsIEd1ZXN0DQo+PiBrZXJuZWwg
c2hvdWxkIG5vdCB1c2UgdGhhdCByZWdpc3RlciB0byBqdWRnZSB3aGF0IGZlYXR1cmVzIGFyZQ0K
Pj4gc3VwcG9ydGVkLiBJbnN0ZWFkIGNhcC9lY2FwIGJpdHMgc2hvdWxkIGJlIGNoZWNrZWQuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogWXUgWmhhbmcgPHl1LmMuemhhbmdAbGludXguaW50ZWwuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVs
LmNvbT4NCj4+IFJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmPGNsZW1lbnQubWF0
aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCB8ICA5ICsrKysrKysrLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgICAg
ICAgICAgfCAyNSArKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+PiBpbmRleCA1ZjMyYzM2OTQzLi44ZmEyN2M3ZjNiIDEwMDY0NA0KPj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCj4+IEBAIC0zMTEsNyArMzExLDE0IEBAIHR5cGVkZWYgZW51bSBW
VERGYXVsdFJlYXNvbiB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
IHJlcXVlc3Qgd2hpbGUgZGlzYWJsZWQgKi8NCj4+ICAgICAgIFZURF9GUl9JUl9TSURfRVJSID0g
MHgyNiwgICAvKiBJbnZhbGlkIFNvdXJjZS1JRCAqLw0KPj4NCj4+IC0gICAgVlREX0ZSX1BBU0lE
X1RBQkxFX0lOViA9IDB4NTgsICAvKkludmFsaWQgUEFTSUQgdGFibGUgZW50cnkgKi8NCj4+ICsg
ICAgLyogUEFTSUQgZGlyZWN0b3J5IGVudHJ5IGFjY2VzcyBmYWlsdXJlICovDQo+PiArICAgIFZU
RF9GUl9QQVNJRF9ESVJfQUNDRVNTX0VSUiA9IDB4NTAsDQo+PiArICAgIC8qIFRoZSBQcmVzZW50
KFApIGZpZWxkIG9mIHBhc2lkIGRpcmVjdG9yeSBlbnRyeSBpcyAwICovDQo+PiArICAgIFZURF9G
Ul9QQVNJRF9ESVJfRU5UUllfUCA9IDB4NTEsDQo+PiArICAgIFZURF9GUl9QQVNJRF9UQUJMRV9B
Q0NFU1NfRVJSID0gMHg1OCwgLyogUEFTSUQgdGFibGUgZW50cnkNCj5hY2Nlc3MgZmFpbHVyZSAq
Lw0KPj4gKyAgICAvKiBUaGUgUHJlc2VudChQKSBmaWVsZCBvZiBwYXNpZCB0YWJsZSBlbnRyeSBp
cyAwICovDQo+PiArICAgIFZURF9GUl9QQVNJRF9FTlRSWV9QID0gMHg1OSwNCj4+ICsgICAgVlRE
X0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOViA9IDB4NWIsICAvKkludmFsaWQgUEFTSUQgdGFibGUg
ZW50cnkNCj4qLw0KPg0KPmhvdyBhYm91dCBtYWtpbmcgdGhlIGNvbW1lbnQgbGluZSBhbGlnbmVk
PyBFaXRoZXIgb25lIGxpbmUgb3IgdHdvIGxpbmVzLg0KDQpJdCBsb29rcyB0aGUgb3JpZ2luYWwg
cnVsZSBpczoNCklmIG9uZSBsaW5lIGV4Y2VlZHMgODAgY2hhcnMsIHNwbGl0IGRlZmluaXRpb24g
YW5kIGNvbW1lbnRzIHRvIHR3byBsaW5lcy4NCklmIG5vdCwganVzdCB1c2Ugb25lIGxpbmUuDQoN
CkknbSBmb2xsb3dpbmcgdGhhdCBydWxlLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+QmVzaWRl
cyB0aGlzLCBsZ3RtLg0KPg0KPlJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4NCj4+DQo+PiAgICAgICAvKiBPdXRwdXQgYWRkcmVzcyBpbiB0aGUgaW50ZXJydXB0IGFk
ZHJlc3MgcmFuZ2UgZm9yIHNjYWxhYmxlIG1vZGUgKi8NCj4+ICAgICAgIFZURF9GUl9TTV9JTlRF
UlJVUFRfQUREUiA9IDB4ODcsDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCAxNmQyODg1ZmNjLi5jNTI5MTJmNTkz
IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4+IEBAIC03OTYsNyArNzk2LDcgQEAgc3RhdGljIGludA0KPnZ0ZF9n
ZXRfcGRpcmVfZnJvbV9wZGlyX3RhYmxlKGRtYV9hZGRyX3QgcGFzaWRfZGlyX2Jhc2UsDQo+PiAg
ICAgICBhZGRyID0gcGFzaWRfZGlyX2Jhc2UgKyBpbmRleCAqIGVudHJ5X3NpemU7DQo+PiAgICAg
ICBpZiAoZG1hX21lbW9yeV9yZWFkKCZhZGRyZXNzX3NwYWNlX21lbW9yeSwgYWRkciwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcGRpcmUsIGVudHJ5X3NpemUsIE1FTVRYQVRUUlNfVU5T
UEVDSUZJRUQpKSB7DQo+PiAtICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9JTlY7
DQo+PiArICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9ESVJfQUNDRVNTX0VSUjsNCj4+ICAg
ICAgIH0NCj4+DQo+PiAgICAgICBwZGlyZS0+dmFsID0gbGU2NF90b19jcHUocGRpcmUtPnZhbCk7
DQo+PiBAQCAtODE0LDYgKzgxNCw3IEBAIHN0YXRpYyBpbnQNCj52dGRfZ2V0X3BlX2luX3Bhc2lk
X2xlYWZfdGFibGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkbWFfYWRkcl90IGFkZHIsDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lERW50cnkgKnBlKQ0KPj4gICB7
DQo+PiArICAgIHVpbnQ4X3QgcGd0dDsNCj4+ICAgICAgIHVpbnQzMl90IGluZGV4Ow0KPj4gICAg
ICAgZG1hX2FkZHJfdCBlbnRyeV9zaXplOw0KPj4gICAgICAgWDg2SU9NTVVTdGF0ZSAqeDg2X2lv
bW11ID0gWDg2X0lPTU1VX0RFVklDRShzKTsNCj4+IEBAIC04MjMsNyArODI0LDcgQEAgc3RhdGlj
IGludA0KPnZ0ZF9nZXRfcGVfaW5fcGFzaWRfbGVhZl90YWJsZShJbnRlbElPTU1VU3RhdGUgKnMs
DQo+PiAgICAgICBhZGRyID0gYWRkciArIGluZGV4ICogZW50cnlfc2l6ZTsNCj4+ICAgICAgIGlm
IChkbWFfbWVtb3J5X3JlYWQoJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBhZGRyLA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBwZSwgZW50cnlfc2l6ZSwgTUVNVFhBVFRSU19VTlNQRUNJRklF
RCkpIHsNCj4+IC0gICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0lOVjsNCj4+ICsg
ICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0FDQ0VTU19FUlI7DQo+PiAgICAgICB9
DQo+PiAgICAgICBmb3IgKHNpemVfdCBpID0gMDsgaSA8IEFSUkFZX1NJWkUocGUtPnZhbCk7IGkr
Kykgew0KPj4gICAgICAgICAgIHBlLT52YWxbaV0gPSBsZTY0X3RvX2NwdShwZS0+dmFsW2ldKTsN
Cj4+IEBAIC04MzEsMTEgKzgzMiwxMyBAQCBzdGF0aWMgaW50DQo+dnRkX2dldF9wZV9pbl9wYXNp
ZF9sZWFmX3RhYmxlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+DQo+PiAgICAgICAvKiBEbyB0cmFu
c2xhdGlvbiB0eXBlIGNoZWNrICovDQo+PiAgICAgICBpZiAoIXZ0ZF9wZV90eXBlX2NoZWNrKHg4
Nl9pb21tdSwgcGUpKSB7DQo+PiAtICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9J
TlY7DQo+PiArICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlY7DQo+
PiAgICAgICB9DQo+Pg0KPj4gLSAgICBpZiAoIXZ0ZF9pc19sZXZlbF9zdXBwb3J0ZWQocywgVlRE
X1BFX0dFVF9MRVZFTChwZSkpKSB7DQo+PiAtICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9U
QUJMRV9JTlY7DQo+PiArICAgIHBndHQgPSBWVERfUEVfR0VUX1RZUEUocGUpOw0KPj4gKyAgICBp
ZiAocGd0dCA9PSBWVERfU01fUEFTSURfRU5UUllfU0xUICYmDQo+PiArICAgICAgICAhdnRkX2lz
X2xldmVsX3N1cHBvcnRlZChzLCBWVERfUEVfR0VUX0xFVkVMKHBlKSkpIHsNCj4+ICsgICAgICAg
ICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlY7DQo+PiAgICAgICB9DQo+
Pg0KPj4gICAgICAgcmV0dXJuIDA7DQo+PiBAQCAtODc2LDcgKzg3OSw3IEBAIHN0YXRpYyBpbnQN
Cj52dGRfZ2V0X3BlX2Zyb21fcGFzaWRfdGFibGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAg
ICAgfQ0KPj4NCj4+ICAgICAgIGlmICghdnRkX3BkaXJlX3ByZXNlbnQoJnBkaXJlKSkgew0KPj4g
LSAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfSU5WOw0KPj4gKyAgICAgICAgcmV0
dXJuIC1WVERfRlJfUEFTSURfRElSX0VOVFJZX1A7DQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAg
cmV0ID0gdnRkX2dldF9wZV9mcm9tX3BkaXJlKHMsIHBhc2lkLCAmcGRpcmUsIHBlKTsNCj4+IEBA
IC04ODUsNyArODg4LDcgQEAgc3RhdGljIGludA0KPnZ0ZF9nZXRfcGVfZnJvbV9wYXNpZF90YWJs
ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAgaWYgKCF2dGRf
cGVfcHJlc2VudChwZSkpIHsNCj4+IC0gICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxF
X0lOVjsNCj4+ICsgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX0VOVFJZX1A7DQo+PiAgICAg
ICB9DQo+Pg0KPj4gICAgICAgcmV0dXJuIDA7DQo+PiBAQCAtOTM4LDcgKzk0MSw3IEBAIHN0YXRp
YyBpbnQgdnRkX2NlX2dldF9wYXNpZF9mcGQoSW50ZWxJT01NVVN0YXRlDQo+KnMsDQo+PiAgICAg
ICB9DQo+Pg0KPj4gICAgICAgaWYgKCF2dGRfcGRpcmVfcHJlc2VudCgmcGRpcmUpKSB7DQo+PiAt
ICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9JTlY7DQo+PiArICAgICAgICByZXR1
cm4gLVZURF9GUl9QQVNJRF9ESVJfRU5UUllfUDsNCj4+ICAgICAgIH0NCj4+DQo+PiAgICAgICAv
Kg0KPj4gQEAgLTE3OTUsNyArMTc5OCwxMSBAQCBzdGF0aWMgY29uc3QgYm9vbCB2dGRfcXVhbGlm
aWVkX2ZhdWx0c1tdID0gew0KPj4gICAgICAgW1ZURF9GUl9ST09UX0VOVFJZX1JTVkRdID0gZmFs
c2UsDQo+PiAgICAgICBbVlREX0ZSX1BBR0lOR19FTlRSWV9SU1ZEXSA9IHRydWUsDQo+PiAgICAg
ICBbVlREX0ZSX0NPTlRFWFRfRU5UUllfVFRdID0gdHJ1ZSwNCj4+IC0gICAgW1ZURF9GUl9QQVNJ
RF9UQUJMRV9JTlZdID0gZmFsc2UsDQo+PiArICAgIFtWVERfRlJfUEFTSURfRElSX0FDQ0VTU19F
UlJdID0gZmFsc2UsDQo+PiArICAgIFtWVERfRlJfUEFTSURfRElSX0VOVFJZX1BdID0gdHJ1ZSwN
Cj4+ICsgICAgW1ZURF9GUl9QQVNJRF9UQUJMRV9BQ0NFU1NfRVJSXSA9IGZhbHNlLA0KPj4gKyAg
ICBbVlREX0ZSX1BBU0lEX0VOVFJZX1BdID0gdHJ1ZSwNCj4+ICsgICAgW1ZURF9GUl9QQVNJRF9U
QUJMRV9FTlRSWV9JTlZdID0gdHJ1ZSwNCj4+ICAgICAgIFtWVERfRlJfU01fSU5URVJSVVBUX0FE
RFJdID0gdHJ1ZSwNCj4+ICAgICAgIFtWVERfRlJfTUFYXSA9IGZhbHNlLA0KPj4gICB9Ow0KPg0K
Pi0tDQo+UmVnYXJkcywNCj5ZaSBMaXUNCg==

