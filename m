Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97C1C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAN1w-0006Ss-HX; Thu, 01 May 2025 02:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uAN1u-0006Sj-68
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:04:18 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uAN1p-0005kk-Gt
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746079454; x=1777615454;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EutTAaGr/H/0EaH36d6MkWAJ2bsmylTBAttGKOXtV9c=;
 b=MJlYjSwTJQR5wdQ9RcDK5lwZV5OFwbvWYE3cTIM0zdCDFlXGS9wUHjnE
 qUTsEnXmTvJb7f5XNdJN6RzAvd7O71r4195u9iST/x+kFMNfOWi5wn8r0
 juKQdSa/yTK1F65EiCYM91uA12Vuh0PdeVoVi9xryFyfjJ6Hq9T+wcTQn
 Zb7wpTD9Z3Taw/KiPmiOZiTPsq3emtu59NEWaRyj2fwqWFcuqTS9AddmD
 MA7za7vXRZ2fLhlpPkK1dU5m/SB635ZTbwYKFh2orvDFFQK0xueKafDQA
 yX0UqLs/1EQl3EdGgO70sUP/Zbo4r43Wwh9bYvz7ifZVUL6CEPEYxVU5j A==;
X-CSE-ConnectionGUID: wWqxgYmaQNq9u+tH6NyDXw==
X-CSE-MsgGUID: iL5kty+4RI2fzKySjvVh3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47629526"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="47629526"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 23:04:09 -0700
X-CSE-ConnectionGUID: xXNBFoHhQQe4hg94UGpdZg==
X-CSE-MsgGUID: Dc/sf7syT3qV/MZfcWWKvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="134829464"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 23:04:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 23:04:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 23:04:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 23:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICymwCFFO2jwNMoCFutVGh0pqnm6bz2/XIL/RtgSMOGhTgFvKdWAuRAAWam77MZfXhtJ02kGiY56iP5JjbAti1rMlCBIgkyYCf7itjRkyHO45SfCQ4kxqddN3Rn+KZAueAOLPSKvWrFbO2xiwUvA4ladPh+vTyGRmeIMg09BJXHezJSkDdIW5gyOeGqEOwCbYlQRTOOjfhfvMUOP19ciw8UNTsyTihWeeoihqMhDpDS7C7d6vvkWzE9GRh0jB2bdGQDQxu+c/CMgy1rNVzoTvTgovEXW38yCypGkUSZ2wgU5/gsKa2ldbMw6UJm4ff7GjxREJ5gWG8krHjx4JvlEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EutTAaGr/H/0EaH36d6MkWAJ2bsmylTBAttGKOXtV9c=;
 b=K9uQZic4bq1PkZEBD0Yy1XGLy+HLcg+ZuBSIajTVyuP1smyhPDDFqurzo8xrga8ML5HmCX6vNOKG6KJMQC+Pm6azB13C8YdDiX6NDCcThtcKWmMrCVPrhpB1s0oWV9RhKbyr4cOEfe+ExWk+tBKmKLuPyC+Yy3UQXlmjdJQysELhWKWspbJXImp938WpHvQ1cikFbbwQSTCX4Ub6VS2T3fL1sXgv14QJ0PXhNknJzbOpnZiK11mok65hOKF2w9xzp6ClTg7JHZLfMUVxYeX8X1AUyHfuuakVCMyXOPa9dszvQBRyKrU+vbadUaOO/982M+DZthxPOrtaV42fWB0mrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SJ5PPFD47FEA206.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::857) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 06:03:24 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 06:03:24 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Michael Scherle
 <michael.scherle@rz.uni-freiburg.de>, "Kim, Dongwon" <dongwon.kim@intel.com>, 
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v3 0/6] ui/spice: Enable gl=on option for non-local or
 remote clients
Thread-Topic: [PATCH v3 0/6] ui/spice: Enable gl=on option for non-local or
 remote clients
Thread-Index: AQHbuM24WNYAylLmTkK8zkN3QNLGELO6SEkAgALtM2A=
Date: Thu, 1 May 2025 06:03:23 +0000
Message-ID: <IA0PR11MB7185C2F28CDFECB978E08C29F8822@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
 <CAJ+F1CJA1qH5sm+E7e4yD7vdZsOGczYY-w+FD2j3zynX9t5Bjw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJA1qH5sm+E7e4yD7vdZsOGczYY-w+FD2j3zynX9t5Bjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SJ5PPFD47FEA206:EE_
x-ms-office365-filtering-correlation-id: 19ec277f-f99c-48d1-bf05-08dd8875e1d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ym83WG83SHhiY3NwMG5TS1plVUd1YUE0aVI1WTFkcktEbDJPY1lidElsQzk5?=
 =?utf-8?B?NE1ESHRRSUpPeEVYTGtBR3lBS3o0MUZacWQ4d3F6dzMxWkxEWitUZVhNcW1K?=
 =?utf-8?B?blh1NTlZNStocWw2RU5qWTNBUEwrdXJaa3NVbGVJU1lqWkRPY2kycDJGOVpX?=
 =?utf-8?B?QzN5bnRTWWxHVktVR0w2cUh3eHF4Vk80dUhaWktRQk1NTC9SSDcxZW9DWkFD?=
 =?utf-8?B?S1dKWi9lYjdjbG13RThDVHU3SHRXUDZNYnNhQUN5eXJhSDJTcytWYWZQcy8z?=
 =?utf-8?B?R3diK0ovTmYwY3NJT01jd0oyZFhmT1BaemNtWGFXUCsyT1pIRy96bDdBSndz?=
 =?utf-8?B?c2M2YTZxeXllUHdBY3lsNzJsblZLM3dQc08zeGFoSklaUVhEMW5teTZnbEtV?=
 =?utf-8?B?UjNsbWxaZ0NLWFB2Q216RUswTlNQMnZkODNQK3ZIMmNObEdXYStUdkhTZ3M4?=
 =?utf-8?B?S2dJaE51MDhGZTVyQVBqQUh2WFNlOTFpYzBrbXhuNHlxTEJ3RXRwdU5lNVhw?=
 =?utf-8?B?UXZvWkdTTXFlbDlMckM3YnBFZHpkK2tTdEVrNDVXTnRUUWhSV09hWVIzTjV5?=
 =?utf-8?B?UEZNU0d6UHBESWg2NXVJMW9xeDRZZzdlSzhTSXlKZy9MSU44Q1dQNVk1Vitt?=
 =?utf-8?B?M3N0ZmM5anBpTWR3RDRXNTBnMnIrb1Q0RVBpaHZtcDd2eWk0S290T29ndERm?=
 =?utf-8?B?WW5UZ3M2RGZHTlZrbkdDVDVCY3hzNWZ0S1E5YkhrTHNDSGNnNHkreE91aXZ5?=
 =?utf-8?B?M2VwZSticWI2VjJib0s2VzNEYTIyNWhlcUd1LzRqaVlJV1EzV1NXeVQ2TlRv?=
 =?utf-8?B?RUxDTVpnd0plS3NBK1dyc3lLTHNYNFBsZUhpYmx0eTJUNXcvRkd6bE56NXhj?=
 =?utf-8?B?NFJzVDU1RGNNaHZZTENhMmR3SWJ2N0RHcE8zUEtnNW5FV05rK2ZveXBQaTlS?=
 =?utf-8?B?R3FxTktYTDdoTlBxeWIya3hMWkEzaWZWYkZ5VFBhRkhGa3ZhLzlPSWo2L3Z5?=
 =?utf-8?B?V3M4WEdzUVpDSUZsRzdKVlVTQVhEUnZSd2FyRmdHSGlRa082anlDY3lQN1V0?=
 =?utf-8?B?aFoxVUpmVWo4SXBwUnpVOFd1OFRFdjlaN3BLdlM3dzlZTUF1eXhGbFc5NmZi?=
 =?utf-8?B?aUlUVm5ETncyZG44dGVOd0w5TFQ3bVlQaUJGaWZpY0hsSjduOHhsTEZTeUc0?=
 =?utf-8?B?aEFTZ29yNFNFV0hjS25ZU3g3QXZWbUU0ZzhCNUJrMnh2NDdiWW95QitiV2hI?=
 =?utf-8?B?a2xvUXlYQXo4OXVwNVV2QldYUTN4RlFlYXlLeDl5T0kvRS9FY0c2SU9MQUpw?=
 =?utf-8?B?UXkzaWRZNUFoeUN3UUpEZWQ3VjQ2M1pZZHZER3lUVXBOT2wwQTRRU29BSGpY?=
 =?utf-8?B?R3NhYlJQRnNZUXk5dHVIb25Ia1BVaVErUUFlN3I3M3Jub05ZLzhpRjBCcWlv?=
 =?utf-8?B?SzZwTE5XSDAxbEZmd3JiUUFrQnVkL3VWQm9JYUhUL0NUdzVKcGh1bXNKTUti?=
 =?utf-8?B?TDVvS05SUHlEeVJMMWxmUWxZOW5KOUJHbWYvODI1Wmo5NGtNeHR3Sm5jck5R?=
 =?utf-8?B?MnZ4RzNBLzBGWno5SHhoVnpyTmFUK2lYMGRKdFNMZXhKdXZMYTBBeDNsY2Nm?=
 =?utf-8?B?NER0SmI1RFRORENZb21IN2JpekNEQjdkVkdvd01QZjhtdVQvckpYL2J5UGRP?=
 =?utf-8?B?M1d4TDk1NWtBa2VuUSs4cWF3K0tlWFBrLzBpRzlzbEc2WDQ3MllIM3MwSDlx?=
 =?utf-8?B?WDMyTWNxRWFBRTVzcDhRcW9jY09FaVpEWnV4MXZxYnh4bEFYMTh6RlIzdGFS?=
 =?utf-8?B?RVVXdzREUFJ5RmdFazFyd3c0QWc5L1BST1QxM01zYnMvNmhFdnowazJmS3ZF?=
 =?utf-8?B?Y3h2WSs5UlpGQzFUaktPWUdycjM2TGJ6N2Z2RjdWZW1iUk5mdS9xWlJiN3B3?=
 =?utf-8?Q?bXadnr/jqPo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjdIZEp5UExTR3dIRndiTUowaThuRW5hTmF2UWVKTXIybTRpV0dkaEFFM3JY?=
 =?utf-8?B?NzdjNTY2ZklMUkJpb0pxQ3FYWVU0NHZmRjg2VkRFMnFoVnMxbUVnRlNPSFg0?=
 =?utf-8?B?bVgyLzB4eklaTlA2QlowMHVGTkpWTlJvS1BzcWp1dzlTWHR3SXlDaDZlV0JS?=
 =?utf-8?B?VjVXRXhQOFFtOVBSNmJUYjlFTFdsTFl1WFBVL1lFU0J0UFZIYmRlMkVKc1dW?=
 =?utf-8?B?R0N1NnAxdFlJbHAxK0RzQnZkc1FMQ00wUWlyRjgwS0RlRFZSRUdlLyt3MC9O?=
 =?utf-8?B?UGpEdmtKNFo2Vk1DWXBBREJpV0cxVVNsRUgrVFpVVUZGUy9SV3UyY2ZDWm9l?=
 =?utf-8?B?WTRGeWlENitwMCtOakg2UmhKcUZLcEE5bU1PTHovaXhWV3VSeGtmazRHcDdC?=
 =?utf-8?B?NUI3NnRNeDBHUjBVdFNiZXdaL1FndUh3TklkT0pnUFhMUXh2aG9iNysvMjZv?=
 =?utf-8?B?OE96WTJPNWdsb3JRMFFPQ0tJYkdBMHFXSG9rZDYycXZ0disrb0dSdEsxVjZK?=
 =?utf-8?B?ekpnV0JjR1puZ1RGY0IxSVdtakVZRTRBVURCWFRHUlBzMGJqdVJwTEpEeW5P?=
 =?utf-8?B?ZGNHdExZWFRRU3NMbEFTSHN3M1pnazNidE5uczNsL2gyYmxZTVYxTy9OV0pj?=
 =?utf-8?B?eEtoRmZpSVNwdE5iUGt5NWZpY05kOTdUQjZnUWhPWXdQT1lQUmd2RDNsWGRM?=
 =?utf-8?B?RnB3OWhTY3NuVWh6NVZSSnY2UHRoYUhoNUVEZkJ5TXlSRk4wNTQ4alQreEQx?=
 =?utf-8?B?WTZPRllUalRBK21QbGF6cVlzQytSTUV6TDlTdlFxcmxWODRYWTk1eksxdllB?=
 =?utf-8?B?SEszdFRTRHVadXNvM2p5c3pDZGJhZnJGdmNaYzRWMjc2NTR4QWlTZ2tMTmg0?=
 =?utf-8?B?Wjh0dTg4SmxmWUdSUUhOZklnamNzRGJlYUltMUxoN0VFbEsxZXZ2bWZYT1BG?=
 =?utf-8?B?ZEdrTHNtZTNhVkkyK3ZyN2JqZkc3SjgyOTB0OHlVN04rU0VpYVZSMmlGSW5n?=
 =?utf-8?B?QWJ0SDZHOHdrOC8rZXNXamRIV1hNTEh0MjQ2T2dKNG9SUXN4S1FJR2IvOHpV?=
 =?utf-8?B?Qk85YkNZVnVxMFFRNXBIL1JmUUlVK2FTSUpGWk5KMk9aUGFDNnJZQ3AzN1Nw?=
 =?utf-8?B?ZWlFTnlTY1hhaVYzTE9HT2dpYTI0WW1CankyTE1XamRxTXlZSXNWaEszWFh1?=
 =?utf-8?B?Y0ZEVUxxdmVNTndRL1BCeEZZN0x2Nm9Uc2E4UFpjMG1kc1g0SmRmUTZUTFJW?=
 =?utf-8?B?bURBTSs0L2lxWFo0WGRWdXhtT2NDUTZrSFlDSTd5OFF3ekUrMXZ4c0NQalhP?=
 =?utf-8?B?S0toTHFjZHRsaHdSd0Q0NU55Mzk4Nk5qSERHbVpHK0lIN1h3YnFySHRLYWVn?=
 =?utf-8?B?bHFWMUpFd2UraVdFa0FpczR1VlpvMFB0VkswNGhTcnN3V1NldSt0OG5TQ0ZO?=
 =?utf-8?B?VXNyVms4T2ZKOWhGaXVuZkV0RWxseS9DWk84TXFkaTk2RUhKVmIvbnpKYlFo?=
 =?utf-8?B?Ykpub3hpZGIvVmlicHB4UUtyUlBzOTM5ZXJYN2VpSC9tSzhhQ0VySHF2OUZq?=
 =?utf-8?B?eTNFbEREVGt0NzVUMW1DdDIzY2svQ3QrK21ZdStjWEoyWFhSRUpxRHZTbzVQ?=
 =?utf-8?B?MXcxQXNRRDlteCtxY1k4c1E4UjgwODhqZWt6eDluMXVpMURHRS9ZMnVtUmhn?=
 =?utf-8?B?TWV0dW5BQkdyK25tOVJoUzZTNGhQUktXLzVCOFR1YXBrc09DUjVTQkNhZFYw?=
 =?utf-8?B?UVRpRzhFK0JZTzd0RGliSFA0bHZzb05KOHFBTEd6amhwd0F1Q2ZMZnNHdGda?=
 =?utf-8?B?Y2t1SFhldUF3VVZydTR1OTYvdldLVWtscUlFY0cvZmVGbXJDSmVLSDYyc2V6?=
 =?utf-8?B?MndYOVlJRlJGSmV5eHVDY3JyNEY4NHo1eDJzYVVyS3lUazlCZUlkdERqTnVL?=
 =?utf-8?B?bFYxU25IOGlOdDhjTGtUY0QxdHQralFQWkRPWm53VUtnbytndlJjQy9ydk5E?=
 =?utf-8?B?TXVEclNEY1BCWjY5NEpBTzMvZXhDdkZ1bTlDUnJjT3RQejZidyt6NkZaMTF2?=
 =?utf-8?B?MzBKUE1aVWk5YlcxeFI5dVVNbjNGZjNmRlVRUkxkeWxhL0lnWnVCVDJwdmxD?=
 =?utf-8?Q?GG84gm8R+6jcTajn6eOIYF/y+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ec277f-f99c-48d1-bf05-08dd8875e1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 06:03:23.7598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HUR0gKMsZ/25XywXWMZlFBsfhnSnNkFXbOi6GH+TIPuZeFq3HtvEfy130xiTTc29wLRLjuMXoGszOupbs3aeVZ040PoaKQ5C6kCfsia8K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD47FEA206
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

SGkgTWFyYy1BbmRyZSwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gdWkvc3BpY2U6
IEVuYWJsZSBnbD1vbiBvcHRpb24gZm9yIG5vbi1sb2NhbCBvcg0KPiByZW1vdGUgY2xpZW50cw0K
PiANCj4gSGkgVml2ZWsNCj4gDQo+IE9uIFR1ZSwgQXByIDI5LCAyMDI1IGF0IDEwOjEz4oCvQU0g
Vml2ZWsgS2FzaXJlZGR5DQo+IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IFRvIGFkZHJlc3MgdGhlIGxpbWl0YXRpb24gdGhhdCB0aGlzIG9wdGlvbiBpcyBpbmNv
bXBhdGlibGUgd2l0aA0KPiA+IHJlbW90ZSBjbGllbnRzLCB0aGlzIHBhdGNoIHNlcmllcyBhZGRz
IGFuIG9wdGlvbiB0byBzZWxlY3QgYQ0KPiA+IHByZWZlcnJlZCBjb2RlYyBhbmQgYWxzbyBlbmFi
bGUgZ2w9b24gb3B0aW9uIGZvciBjbGllbnRzIHRoYXQNCj4gPiBhcmUgY29ubmVjdGVkIHZpYSB0
aGUgbmV0d29yay4gSW4gb3RoZXIgd29yZHMsIHdpdGggdGhpcyBvcHRpb24NCj4gPiBlbmFibGVk
IChhbmQgdGhlIGJlbG93IGxpbmtlZCBTcGljZSBzZXJpZXMgbWVyZ2VkKSwgaXQgd291bGQgYmUN
Cj4gPiBwb3NzaWJsZSB0byBoYXZlIFFlbXUgc2hhcmUgYSBkbWFidWYgZmQgd2l0aCBTcGljZSwg
d2hpY2ggd291bGQNCj4gPiB0aGVuIGZvcndhcmQgaXQgdG8gYSBoYXJkd2FyZSBvciBzb2Z0d2Fy
ZSBiYXNlZCBlbmNvZGVyIGFuZA0KPiA+IGV2ZW50dWFsbHkgc2VuZCB0aGUgZGF0YSBhc3NvY2lh
dGVkIHdpdGggdGhlIGZkIHRvIGEgY2xpZW50IHRoYXQNCj4gPiBjb3VsZCBiZSBsb2NhdGVkIG9u
IGEgZGlmZmVyZW50IG1hY2hpbmUuDQo+ID4NCj4gPiBFc3NlbnRpYWxseSwgdGhpcyBwYXRjaCBz
ZXJpZXMgcHJvdmlkZXMgYSBoYXJkd2FyZSBhY2NlbGVyYXRlZCwNCj4gPiBvcGVuc291cmNlIFZE
SSBvcHRpb24gZm9yIHVzZXJzIHVzaW5nIFFlbXUgYW5kIFNwaWNlIGJ5IGxldmVyYWdpbmcNCj4g
PiB0aGUgaUdQVS9kR1BVIG9uIHRoZSBob3N0IG1hY2hpbmUgdmlhIHRoZSBHc3RyZWFtZXIgZnJh
bWV3b3JrLg0KPiA+DQo+IA0KPiBDb3VsZCB5b3UgZXhwbGFpbiB3aHkgU3BpY2Ugb3IgR1N0cmVh
bWVyIGNhbid0IGhhbmRsZSBhIG5vbi1saW5lYXINCj4gdGV4dHVyZSBsYXlvdXQ/IEl0IGZlZWxz
IGxpa2UgYSBsaW1pdGF0aW9uIHRoYXQgaXMgbm90IHVuZGVyIFFFTVUNCj4gcmVzcG9uc2liaWxp
dHksIEkgYW0gbm90IHN1cmUgaXQgc2hvdWxkIGhhdmUgdG8gZG8gaXQuDQpBRkFJVSwgdGhlcmUg
YXJlIHNldmVyYWwgdGhpbmdzIHRvIGNvbnNpZGVyIGZvciBoYW5kbGluZyBub24tbGluZWFyL3Rp
bGVkDQpsYXlvdXRzIChha2EgRFJNIG1vZGlmaWVycykgaW4gdGhpcyB1c2UtY2FzZToNCi0gVGhl
IGNob2ljZSBvZiB3aGljaCBlbmNvZGVyIHRvIHVzZSAoaGFyZHdhcmUgdnMgc29mdHdhcmUpIGlz
IGRlY2lkZWQNCiAgZHluYW1pY2FsbHkgYW5kIGlzIGludGVybmFsIHRvIFNwaWNlIGF0IHRoaXMg
cG9pbnQuIEFuZCwgc2luY2UgdGhlcmUgaXMgbm8NCiAgZWFzeSB3YXkgdG8ga25vdyBmcm9tIFFl
bXUgd2hldGhlciBhbiBlbmNvZGVyIGNob3NlbiBieSBTcGljZSB3b3VsZA0KICBzdXBwb3J0IGFu
eSBnaXZlbiB0aWxpbmcgZm9ybWF0LCBJIGNob3NlIHRvIGFsd2F5cyB1c2UgbGluZWFyIGxheW91
dCBzaW5jZSBpdA0KICBpcyBtb3N0bHkgZ3VhcmFudGVlZCB0byB3b3JrIHdpdGggYWxsIHR5cGVz
IG9mIGVuY29kZXJzLiBIb3dldmVyLCBpdCBtYWtlcw0KICBzZW5zZSB0byBhZGQgc29tZSBraW5k
IG9mIGVuY29kZXIvY29kZWMgY2FwcyBleGNoYW5nZSBiZXR3ZWVuIFFlbXUNCiAgYW5kIFNwaWNl
IGluIHRoZSBmdXR1cmUuDQoNCi0gVGhlcmUgZG9lcyBub3QgYXBwZWFyIHRvIGJlIGEgd2F5IHRv
IGRvIHRoZSBjb252ZXJzaW9uIGZyb20gdGlsZWQgdG8gbGluZWFyDQogIGF0IHRoZSBlbmNvZGVy
IGxldmVsIHdpdGggR3N0cmVhbWVyLiBJbiBvdGhlciB3b3JkcywgaWYgU3BpY2Ugd2VyZSB0byBw
aWNrIGENCiAgc29mdHdhcmUgZW5jb2RlciBzdWNoIGFzIHgyNjRlbmMsIHRoZW4gaXQgd291bGQg
YmVjb21lIG5lY2Vzc2FyeSBkbyB0aGUNCiAgY29udmVyc2lvbiBpbiBRZW11ICh1c2luZyBHTCkg
d2hlcmUgdGhpcyBzaXR1YXRpb24gY2FuIGJlIGVhc2lseSBkZXRlY3RlZA0KICBhbmQgaGFuZGxl
ZC4NCg0KLSBBbmQsIGxhc3QgdGltZSBJIGNoZWNrZWQsIERSTSBtb2RpZmllcnMgc3VwcG9ydCBp
biBHc3RyZWFtZXIgd2FzIHN0aWxsIG5vdA0KICB2ZXJ5IG1hdHVyZSBhbmQgbm90IGFsbCB0aGUg
a2V5IGVsZW1lbnRzL3BsdWdpbnMgc3VwcG9ydGVkIHRoZW0uIFNvLCBpdCBtYXkNCiAgbm90IGJl
IGd1YXJhbnRlZWQgdG8gd29yayBpbiBkaWZmZXJlbnQgdXNlLWNhc2VzLg0KICANCkdpdmVuIGFs
bCB0aGUgYWJvdmUsIEkgZmlndXJlZCBpdCBtYWtlcyBzZW5zZSB0byBzdGFydCBzbWFsbCBhbmQg
c3RpY2sgd2l0aCBsaW5lYXINCmxheW91dCBmb3Igbm93IGFzIGl0IHdvcmtzIGluIGFsbCBjYXNl
cyBhbmQgdGhlbiBpbXByb3ZlIGJ5IGFkZGluZyBtb2RpZmllcg0Kc3VwcG9ydCBsYXRlciB0byBh
ZGRyZXNzIHRoZSBzY2VuYXJpb3Mgd2hlcmUgdGhleSBjYW4gYmUgc3VwcG9ydGVkLg0KDQo+IA0K
PiBCdHcsIHRoZSBzZXJpZXMgd2lsbCBsaWtlbHkgaGF2ZSBjb25mbGljdHMgd2l0aCAidWk6IHN1
cHBvcnQgbXVsdGkNCj4gcGxhbmUgdGV4dHVyZSIsIHdoaWNoIEkgdGhpbmsgd2Ugc2hvdWxkIG1l
cmdlIGZpcnN0Lg0KPiAoaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VLzIwMjUwMzI3MDI1ODQ4LjQ2
OTYyLTEteXVxODI1QGdtYWlsLmNvbS8pDQpPaywgZm9yIHRoZSBuZXh0IHZlcnNpb24sIEknbGwg
cmViYXNlIG15IHBhdGNoZXMgb24gdG9wIG9mIHRoZSBhYm92ZSBzZXJpZXMuDQoNClRoYW5rcywN
ClZpdmVrDQoNCj4gDQo+ID4gdjIgLT4gdjM6DQo+ID4gLSBDaGVjayBmb3IgZXJyb3JzIGFmdGVy
IGludm9raW5nIGdsSW1wb3J0TWVtb3J5RmRFWFQoKSB1c2luZw0KPiA+ICAgZ2xHZXRFcnJvcigp
IGFuZCByZXBvcnQgdGhlIGVycm9yIHRvIHVzZXIgKERtaXRyeSkNCj4gPg0KPiA+IHYxIC0+IHYy
Og0KPiA+IC0gUmVwbGFjZSB0aGUgb3B0aW9uIG5hbWUgcHJlZmVycmVkLWNvZGVjIHdpdGggdmlk
ZW8tY29kZWNzIChNYXJjLUFuZHLDqSkNCj4gPiAtIEFkZCBhIHdhcm5pbmcgd2hlbiBhbiBmZCBj
YW5ub3QgYmUgY3JlYXRlZCBmcm9tIHRleHR1cmUgKE1hcmMtQW5kcsOpKQ0KPiA+IC0gQWRkIGEg
bmV3IHBhdGNoIHRvIGJsaXQgdGhlIHNjYW5vdXQgdGV4dHVyZSBpbnRvIGEgbGluZWFyIG9uZSB0
bw0KPiA+ICAgbWFrZSBpdCB3b3JrIHdpdGggdmlyZ2wNCj4gPiAtIFJlYmFzZWQgYW5kIHRlc3Rl
ZCBhZ2FpbnN0IHRoZSBsYXRlc3QgU3BpY2UgbWFzdGVyDQo+ID4NCj4gPiBUZXN0ZWQgd2l0aCB0
aGUgZm9sbG93aW5nIFFlbXUgcGFyYW1ldGVyczoNCj4gPiAtZGV2aWNlIHZpcnRpby12Z2EsbWF4
X291dHB1dHM9MSx4cmVzPTE5MjAseXJlcz0xMDgwLGJsb2I9dHJ1ZQ0KPiA+IC1zcGljZSBwb3J0
PTMwMDEsZ2w9b24sZGlzYWJsZS10aWNrZXRpbmc9b24sdmlkZW8tY29kZWNzPWdzdHJlYW1lcjpo
MjY0DQo+ID4NCj4gPiBhbmQgcmVtb3RlLXZpZXdlciAtLXNwaWNlLWRlYnVnIHNwaWNlOi8veC54
LngueDozMDAxIG9uIHRoZSBjbGllbnQgc2lkZS4NCj4gPg0KPiA+IEFzc29jaWF0ZWQgU3BpY2Ug
c2VydmVyIE1SIChtZXJnZWQpOg0KPiA+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9z
cGljZS9zcGljZS8tL21lcmdlX3JlcXVlc3RzLzIyOQ0KPiA+DQo+ID4gLS0tDQo+ID4gQ2M6IEdl
cmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IENjOiBNYXJjLUFuZHLDqSBMdXJl
YXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBDYzogRG1pdHJ5IE9zaXBlbmtv
IDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4NCj4gPiBDYzogRnJlZGlhbm8gWmlnbGlv
IDxmcmVkZHk3N0BnbWFpbC5jb20+DQo+ID4gQ2M6IE1pY2hhZWwgU2NoZXJsZSA8bWljaGFlbC5z
Y2hlcmxlQHJ6LnVuaS1mcmVpYnVyZy5kZT4NCj4gPiBDYzogRG9uZ3dvbiBLaW0gPGRvbmd3b24u
a2ltQGludGVsLmNvbT4NCj4gPiBDYzogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8u
b3JnPg0KPiA+DQo+ID4gVml2ZWsgS2FzaXJlZGR5ICg2KToNCj4gPiAgIHVpL3NwaWNlOiBBZGQg
YW4gb3B0aW9uIGZvciB1c2VycyB0byBwcm92aWRlIGEgcHJlZmVycmVkIGNvZGVjDQo+ID4gICB1
aS9zcGljZTogRW5hYmxlIGdsPW9uIG9wdGlvbiBmb3Igbm9uLWxvY2FsIG9yIHJlbW90ZSBjbGll
bnRzDQo+ID4gICB1aS9zcGljZTogU3VibWl0IHRoZSBnbF9kcmF3IHJlcXVlc3RzIGF0IDYwIEZQ
UyBmb3IgcmVtb3RlIGNsaWVudHMNCj4gPiAgIHVpL2NvbnNvbGUtZ2w6IEFkZCBhIGhlbHBlciB0
byBjcmVhdGUgYSB0ZXh0dXJlIHdpdGggbGluZWFyIG1lbW9yeQ0KPiA+ICAgICBsYXlvdXQNCj4g
PiAgIHVpL3NwaWNlOiBDcmVhdGUgYSBuZXcgdGV4dHVyZSB3aXRoIGxpbmVhciBsYXlvdXQgd2hl
biBnbD1vbiBpcw0KPiA+ICAgICBlbmFibGVkDQo+ID4gICB1aS9zcGljZTogQmxpdCB0aGUgc2Nh
bm91dCB0ZXh0dXJlIGlmIGl0cyBtZW1vcnkgbGF5b3V0IGlzIG5vdCBsaW5lYXINCj4gPg0KPiA+
ICBpbmNsdWRlL3VpL2NvbnNvbGUuaCAgICAgICB8ICAgMiArDQo+ID4gIGluY2x1ZGUvdWkvc3Bp
Y2UtZGlzcGxheS5oIHwgICA0ICsNCj4gPiAgcWVtdS1vcHRpb25zLmh4ICAgICAgICAgICAgfCAg
IDUgKw0KPiA+ICB1aS9jb25zb2xlLWdsLmMgICAgICAgICAgICB8ICAyOCArKysrKysNCj4gPiAg
dWkvc3BpY2UtY29yZS5jICAgICAgICAgICAgfCAgMTYgKysrKw0KPiA+ICB1aS9zcGljZS1kaXNw
bGF5LmMgICAgICAgICB8IDE4NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
DQo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgMjIzIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjQ5LjANCj4gPg0KPiA+DQo+IA0KPiANCj4gLS0NCj4gTWFy
Yy1BbmRyw6kgTHVyZWF1DQo=

