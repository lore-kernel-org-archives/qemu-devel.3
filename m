Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D595CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 05:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ZQq-0003fx-Qg; Mon, 22 Sep 2025 01:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0ZQk-0003bZ-1K
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 01:49:46 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0ZQe-0005cG-Sh
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 01:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758520177; x=1790056177;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DOjzGTqeyh2nwOlvQFAx98C7GsN6OtAn2Q1ZBQMoL/I=;
 b=m1bH2h3bFQwkdFj/TJ6P8L8yKDZs7m/v8YVKMO74BZFsAs2sQKNqCsbu
 UVJjj5XUtbS7zojfZnUwEohz0vp6XNKmyciI03d0LKOF3tDu+10nMtBRy
 aJ5GkgCZOHiAy7nTnsiEeqISsdSWqu5Y204uLZnIFiiOFwyXKKld8NiNR
 c/ecaOepQWHNGt1aHQZpp6iVvPvwk6nLCW6Bc3VessJAFIC3eLBA9Bobn
 QYq8LDI5G1YiBGXjCvs+Vg25+UXvtKYYekuWJsrc2hz2xPW8GuN975noF
 7pchyGactYX2zRQBAoHAL31rYjNHOZ26cl4WjPklZab0JCZ3OMKV6v6iV g==;
X-CSE-ConnectionGUID: tZ8VHrM4R5miWTpjn2LaDw==
X-CSE-MsgGUID: OpUyuxxDQEyHDSn6jTb4dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="59814615"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="59814615"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2025 22:49:34 -0700
X-CSE-ConnectionGUID: lL3nQZ61RdiNmRq712kKSg==
X-CSE-MsgGUID: zX059z44T5OVcbsgLKkZ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="181645566"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2025 22:49:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Sep 2025 22:49:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 21 Sep 2025 22:49:32 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.71)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Sep 2025 22:49:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbQYoPlbp/a4TPglwnxAsXG0GgfekuVN+dGO2gjB5cMPxtP3z5DtaUu4mzJDdD5eMq7dAkBrQjihw/iaP0pEsjARhmQqZ44lwGtelyMN2WDnb9xKXrw/UGd9vTCEO6b2Z+tA50MOwkfRqVWbWpDpBsjQmYCVPh8Qcj1JK9rlPyEip/s274chgnxQDv0d6AbaRMqlwXbbMhDNgu008YOBoZUdPvVW3Cmh6hYKQd3yTxClDL1y5GZU875SOIl9lolEl9CQuwaMONccaoTcsLAT1TGETGdaNm6uhdw5A1mTVM5SqruOg+pioXvYkocc3NfDTnx1dFN3RdNKF+FMqYZOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOjzGTqeyh2nwOlvQFAx98C7GsN6OtAn2Q1ZBQMoL/I=;
 b=yyM93CYw7soulb8SXla0+ZaXpqerwguysf+aNzZfhbXWcX6DYy28xERZdCgDmcdaYYg2eYeQIooIqhWkfcfVGL/B6NnA0fjN4ASXG6EvJGISBmE6pfsbqEU51oK0SFPx3iIOnhx7t04mxD2oYFUloAIxKx2mc6rs6WQ/hrhuTHZeB6C3Du19fQOkgA3zwEbiQzAfNl+2rQgKO1ssnRX0B3hFq9l/UyB1RJoZa5qW+fyV0A2MnbdrH1bWIzmsuLTswn3c4k0f+8dCuR/kxPsQ58t6B4aGozNPzyxztORkBpE7jX8dD7YNKcNzTZ/zvXoKdgtQ5fakz6uY+VPsqZftKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 05:49:30 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Mon, 22 Sep 2025
 05:49:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao,
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Topic: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Index: AQHcIfvtcDcAUY1arESRh5H1VPguD7SaXCYAgAQ5VOA=
Date: Mon, 22 Sep 2025 05:49:30 +0000
Message-ID: <IA3PR11MB9136B9DA08CC2A48E1678DED9212A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
 <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
In-Reply-To: <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB7276:EE_
x-ms-office365-filtering-correlation-id: 3761d59f-8283-4475-9440-08ddf99bcc7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RzRWNnVyenJCMUtzYk1sc0hQUWNLNElHOWJaMGlTaVFYLzRpazZQUXZCamN1?=
 =?utf-8?B?SG8zNVlyaXhBVWJxVEhzM1JoOEZOT0Z3L01nekkrZEVYOXB6aFhLTkdwckto?=
 =?utf-8?B?YlNaN2ZlZTFaTjBqUnJtRFFpbW96alBEOVVzSGpGc2s5aFhmci8rN1JST1JW?=
 =?utf-8?B?Tjd3RW8vWFpCTElrTk5QZkRhWVJrbHVQYWtHOG1NQ3N1N1p6NVFCVGlxK1Fh?=
 =?utf-8?B?cFhKT1Z6NXQ2K2c0Z3hiQVhDMFAvUlFQbzNyNlBGSVFicXpTeHZRY3lDQUpo?=
 =?utf-8?B?NHdHNkFJeGNkTkozamNyY2c0Q2ZmNllqeGxlQWhwYkwvdUd0U01jTFpJQWtI?=
 =?utf-8?B?cWNaUml2UWpkY2FZeS9SanpSWHZsdWEzTHJKYzFaZDhyaU9UQ0N4WklOZ1Bi?=
 =?utf-8?B?YU1yaDMwMmZtQzRXNW9YSFRGVHFZajg2ZTJybjgrbmg4TVVaUkxneUpXaCtO?=
 =?utf-8?B?c1Avd0QyUytZSGRURkR1NFpFN3B4WXpjazd5MXJmZFlkSnYzZHcya2JZT1ZT?=
 =?utf-8?B?clJuc09zNzEyRkJuZzVRRWk0dCt1anY5enAwRWo2a25jbjE0a3hFY2N2cUg4?=
 =?utf-8?B?bjJyM2o2VjU1ZUw4NjY0WkhsUTRIL1lBOVZXQmhZM2lVWnVpM3Q0c3NvK3VN?=
 =?utf-8?B?b2ZRMFBLc0VReGNlY1l5RC8wV2JDdkZaL0g5M0xmdC9ZNzlQYkpZTzh3aXdS?=
 =?utf-8?B?bGt2dnBXUW1VWXQ4L1J6cTN2UXB6Z1c4Q011L1pIbkNRMk9seVJ0UnZ5SXdX?=
 =?utf-8?B?OVUzVGNzOG9WOGhvSE9kcEdNdktBYkJBZW1HK2pybU1BaVU1aER0Zzc0YnFr?=
 =?utf-8?B?elIyOG9ENGRPTm5OU1lNOUdib0RWeHhsUWdqblBMQlpMS0wveDZINk1rR3o1?=
 =?utf-8?B?NUg4Q0pBRXFCVU9ndjc0Uk9sVlVWVGlJK2FPWnlMdWVZYSt6aDA1Y3MxVkt6?=
 =?utf-8?B?dURrUXdLakJrKzdVa0hzNTVqNHFtRlBvemEwUHlibEJla1kwZGZ0WE1xdHVE?=
 =?utf-8?B?YkVIbjZSYWt2cG9hWjdKc0dtRDJrNDVPTktLZEluYTJQbG8vZUd1UFBURG9V?=
 =?utf-8?B?MG42blZQdENqa3NxMzA0ZHZ6RzFTK01KcmgvaHVpelptMTdaR3JKbFU3NWx0?=
 =?utf-8?B?bzV0VDg2WVc4NHRYMlE3bWg5N1I4VllzUGJoTDBYaFlmRHlSMFR3ZHA2UGEv?=
 =?utf-8?B?WVRNK2xwMU1EcjB3bXB4ZXMzTGhxTVZublhObnIyWFJCdDkxQWlNMXhubXA0?=
 =?utf-8?B?LzRFSkFvdEZjVFpVeGhobUU5ZzBYOHJDNG9vUSttTUw2L2l2aDVZVkRoVWRj?=
 =?utf-8?B?WmdLeVp4ZGNobHlMVnBaMUdiTnBDbUlCeWJzbFJMcUlrZWpKRXZDdHlJT0ty?=
 =?utf-8?B?Q3RCNUU3ck9PL1YvU255aTlETVNGOEJRLzUrNE5QL3hudDF2R2xSZXhYaVBk?=
 =?utf-8?B?WmxHeDBiTzFTL0lidlJ1Z1Q1T3pSQWhwOExwd0JaOFdPaW9WVnlad1B0ZEtk?=
 =?utf-8?B?ZXpNQTdRRDcvT0FWeEFGVVI2U0hDOWJKTzNWeVR4OG5nSjIyMlI2eFZMLy9x?=
 =?utf-8?B?cFR1QUJpQzdHT0VZVFRvYlpjZjhNaUVQQjFzcXRUQ1lndmRrOXh4V3lrSnk5?=
 =?utf-8?B?OGJ3cEtHZWZvbkloQUlSZTd6VVZFSGdtNmJYZVlHaHZpeXZjMndqYlZvSlBy?=
 =?utf-8?B?VWVxaGhvR0VSc0tMSWNZMXZCeWo1VGs1SEhZdjg1cjZMZEtuV0FiQ3ppOHBr?=
 =?utf-8?B?VXQ1dldkb29uR0dldWZVRmpuRWljd1gxcmZBZ1RBUEU0cUdvZThBRVFrQ0dU?=
 =?utf-8?B?NUNYNy9wMEVBdGFvbCtKdzJQWm5USVlZYVZ4L3ZLRkYwRHBoUytNejVYYWRs?=
 =?utf-8?B?aUZ4Y0hqME1wbm5UOUVoTkZDRkNkdnp5aVJjTXd0ZEdzMmhqMkVINURNcmk5?=
 =?utf-8?B?VzJaR1llOGcrWHBXVDNCRFA5Y0h0RkZPWmFvNU9sVXFXVGl0dnJNWFJWblE2?=
 =?utf-8?Q?IVHUcrJcocUDYKlnCiFAHTS/t+Gz1Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zjcrc1NQcjVveUJSN2FDUGFrNm5GazZRRTNQUzRndjR2eGpyOEk0NnVGaUl4?=
 =?utf-8?B?UDdwUUxXbHpWdGlUTHkxY1BYRHRWRklxWjlFdk8yZi96V29iZ3NhNVJTRjd0?=
 =?utf-8?B?TkNpTndyV0NuSnhOZ1VRVGRQUGxUNTJkczN0ajlBNVEwNVd2bmdkQWQwTkN3?=
 =?utf-8?B?a1hHNUlmQmtlZTFSQXpNSlFSUjRwVUJBL3RPMGNmOGJnejVkTzAwYS9hcXVB?=
 =?utf-8?B?c1d0NExYWThZWkdid0NNdTAzcSs0OWplMUd5TytyWUtMQ2dseEQ3Ky9ZNWpB?=
 =?utf-8?B?Y2ZSdldSSGpSWFExcjNLdkt5QndnSGZxRGc0WkNraEc4d09HQXpFSmkwWTdZ?=
 =?utf-8?B?ejFtKzJveFdBOEdyY0VtN01HMjZscHZMaEpaWTVETHZBdWFkZGFwQlhmT0Ev?=
 =?utf-8?B?ajFER1RVMEJFMDhwZ3VSaXpIbWhUSGllbXAwZHpDWTFwMTNXVFdLMUdnL2lk?=
 =?utf-8?B?Wjh3Q0dOMm5OU0hKb3VuVG5LSFh5dE5JUXAzaWpvMkRyK1BwKytCTSs3dVJE?=
 =?utf-8?B?QUgybjZ4c0RRQ0daTzN6TUpvUHVvYTVoTU4wWDdISWc2djE5RnFQanQ0YWp5?=
 =?utf-8?B?U0ovcHhHMHdMOVVIeXhwYVRtSVlzQXZ3V1dTUTIyK2hTRDBnbkZ2enU5c1JT?=
 =?utf-8?B?NGVabUoyUWJXZmgrcmpuaFBIcHM4ZEFGaWIzT0xKbjBwV2tXUWtPK3NGbDlj?=
 =?utf-8?B?S1E1cHB5bTJwNXhXMVlUVHNOam5reXZYMTR4bCtiNTZ6eCttSDgydVMzbFVw?=
 =?utf-8?B?SEM4S0UvQ2VYZmVQOVVuZ2NGTC9tc3hzNG5MVm40c2U3ZXViUDU3aHU4RHFP?=
 =?utf-8?B?Tlc2MSt2NTNEQUsycW5zblJPMGtDY0tLREZpRlpyWXJhSmlXYXVqNDk0RmF1?=
 =?utf-8?B?b2Vvam1hVG5jZ1dYMWJYZ1EzSDZWS2FYWVNPQkdOanpxL3ZmdndKd0ViSHBR?=
 =?utf-8?B?dStPdXF5SlpkMDE3LzluR3lmRytZZ1pDWDFtdTlTZUxNK1hibWw4MktBMjkv?=
 =?utf-8?B?NDBIYnMrOEtlQXc5RUh6ODJsRXNuUXQxeWozeWNpUXFPNVZ1MUZjanVWSjl4?=
 =?utf-8?B?a3hjZWhCQWJaVEVkUWcrakxFdVh5dVNhRVVtS2IrcVVpTXNUNUZxY0kvVmtz?=
 =?utf-8?B?c0k2TVN6SFllNUw5QXdEdnRjSzRoRkYrajFrdTVZSGdIWnBGeFRRdzNNek4r?=
 =?utf-8?B?eTV3ZExEd0dlWDAySmtVdExnTzZneEFva3g0VFVnNmpSY04rNVFGU0o5djQ5?=
 =?utf-8?B?K25OQks1RktqTWZURUxWbWg4MWFnVFdvK2I1OHRpbkZwL21RZkFqck9WQmFx?=
 =?utf-8?B?RFh3cGNFZ1NlRmVvTWNoZ0ZRWExsUXpEekN4alNvQktpdnkwdnRJV2pDcnBL?=
 =?utf-8?B?Tmx2eFdITkc4UmhOb1RkTjBrZjFLTTNjODFPR1VTVC9vN0RGY0JGZmdDbjRG?=
 =?utf-8?B?YXJUSzhzeXRFR1E2RFUrb2FXbWhmc0xtQ3ZEN3BtVlIzZW9QaGR1bFFPWUU1?=
 =?utf-8?B?SFVpSVZGVDVxSFdFMGZDVlMySXFETWhyeXFZTklpQnFvSVViRVhzRGd0cjFn?=
 =?utf-8?B?dVluUENOVUExR1NodVdBWmRQNUpINkkraXlZSFkyczhhb3Y2bGI0MnZqaW5N?=
 =?utf-8?B?S0djekZVaVBlbmxSNXpUeWhDU0p0M2tjRGUyL0dKRE56NkRpVnJqRHZ2Skhp?=
 =?utf-8?B?SXR3NjVXN3JRUm8vOC9NOWhoUlBSeFJ0TnVPdHlFaUJRYTRTTWw5bHRIS3F3?=
 =?utf-8?B?djJkdUpjK3hEU0M0QU1MWWxmYVlEVnNZQi81Vk4yclBLVWZrT3Y4aVBidjZp?=
 =?utf-8?B?SFVDRnNkOVArNUdFeVFQdzgyaDNndldlWDBSUUpPWjhoUWo2OTgzTkUrMjZx?=
 =?utf-8?B?UlhLL1I0Q0l5VURJTWFRRldpcDh1eHI2elMwSEdwZlNtL0tud3QyWlRnbmhB?=
 =?utf-8?B?NXJMQnM3anZ2THJ5aG1Dc0N6Y081clJmZHRPeEVWTlVOSzhIU3VsYXBvMEhy?=
 =?utf-8?B?N3V2QlByRjBsWkMzUlJEZVA2NThrVzBWRFlEOU1rTTJVa043a0M1bjUxdUhC?=
 =?utf-8?B?K1IxUmZybXpRdGNKRVo1eTdJenB2cStlVmpJSUsveWtoZDROLzdhcXFuNXhB?=
 =?utf-8?Q?Qx32PflUov0RuOBoYG7A8tvVb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3761d59f-8283-4475-9440-08ddf99bcc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 05:49:30.1967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mwjgxB31IVMJaaIHkFpa8UaxkyqhpaoPJ6xjaXIRV5UkJ5UGhBz5SxTSy2vR+eUg4F2nyCUxyVvRbkwj9eGZ7COwWIEa2Q8GAkCp/EMGNiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgSm9hbywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0
aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMy81
XSB2ZmlvL2lvbW11ZmQ6IEFkZA0KPklPTU1VX0hXUFRfR0VUX0RJUlRZX0JJVE1BUF9OT19DTEVB
UiBmbGFnIHN1cHBvcnQNCj4NCj5PbiAxMC8wOS8yMDI1IDAzOjM2LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+IFBhc3MgSU9NTVVfSFdQVF9HRVRfRElSVFlfQklUTUFQX05PX0NMRUFSIHdoZW4g
ZG9pbmcgdGhlIGxhc3QNCj5kaXJ0eQ0KPj4gYml0bWFwIHF1ZXJ5IHJpZ2h0IGJlZm9yZSB1bm1h
cCwgbm8gUFRFcyBmbHVzaGVzLiBUaGlzIGFjY2VsZXJhdGVzIHRoZQ0KPj4gcXVlcnkgd2l0aG91
dCBpc3N1ZSBiZWNhdXNlIHVubWFwIHdpbGwgdGVhciBkb3duIHRoZSBtYXBwaW5nIGFueXdheS4N
Cj4+DQo+PiBBZGQgYSBuZXcgZWxlbWVudCBkaXJ0eV90cmFja2luZ19mbGFncyBpbiBWRklPSU9N
TVVGRENvbnRhaW5lciB0bw0KPj4gYmUgdXNlZCBmb3IgdGhlIGZsYWdzIG9mIGlvbW11ZmQgZGly
dHkgdHJhY2tpbmcuIEN1cnJlbnRseSBpdCBpcw0KPj4gc2V0IHRvIGVpdGhlciBJT01NVV9IV1BU
X0dFVF9ESVJUWV9CSVRNQVBfTk9fQ0xFQVIgb3IgMCBiYXNlZCBvbg0KPj4gdGhlIHNjZW5hcmlv
Lg0KPj4NCj4+IENvLWRldmVsb3BlZC1ieTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0Bv
cmFjbGUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGlu
c0BvcmFjbGUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbT4NCj4+IFRlc3RlZC1ieTogWHVkb25nIEhhbyA8eHVkb25nLmhhb0Bp
bnRlbC5jb20+DQo+PiBUZXN0ZWQtYnk6IEdpb3Zhbm5pbyBDYWJpZGR1IDxnaW92YW5uaS5jYWJp
ZGR1QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGh3L3ZmaW8vdmZpby1pb21tdWZkLmggICB8IDEg
Kw0KPj4gIGluY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCB8IDIgKy0NCj4+ICBiYWNrZW5kcy9pb21t
dWZkLmMgICAgICAgfCA1ICsrKy0tDQo+PiAgaHcvdmZpby9pb21tdWZkLmMgICAgICAgIHwgNiAr
KysrKy0NCj4+ICBiYWNrZW5kcy90cmFjZS1ldmVudHMgICAgfCAyICstDQo+PiAgNSBmaWxlcyBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9ody92ZmlvL3ZmaW8taW9tbXVmZC5oIGIvaHcvdmZpby92ZmlvLWlvbW11ZmQuaA0KPj4g
aW5kZXggMDdlYTBmNDMwNC4uZTBhZjI0MWM3NSAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vdmZp
by1pb21tdWZkLmgNCj4+ICsrKyBiL2h3L3ZmaW8vdmZpby1pb21tdWZkLmgNCj4+IEBAIC0yNiw2
ICsyNiw3IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9JT01NVUZEQ29udGFpbmVyIHsNCj4+ICAgICAg
VkZJT0NvbnRhaW5lckJhc2UgYmNvbnRhaW5lcjsNCj4+ICAgICAgSU9NTVVGREJhY2tlbmQgKmJl
Ow0KPj4gICAgICB1aW50MzJfdCBpb2FzX2lkOw0KPj4gKyAgICB1aW50NjRfdCBkaXJ0eV90cmFj
a2luZ19mbGFnczsNCj4+ICAgICAgUUxJU1RfSEVBRCgsIFZGSU9JT0FTSHdwdCkgaHdwdF9saXN0
Ow0KPj4gIH0gVkZJT0lPTU1VRkRDb250YWluZXI7DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvc3lzdGVtL2lvbW11ZmQuaCBiL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaA0KPj4gaW5kZXgg
YzljNzJmZmM0NS4uNjM4OThlN2IwZCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvc3lzdGVtL2lv
bW11ZmQuaA0KPj4gKysrIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiBAQCAtNjQsNyAr
NjQsNyBAQCBib29sDQo+aW9tbXVmZF9iYWNrZW5kX3NldF9kaXJ0eV90cmFja2luZyhJT01NVUZE
QmFja2VuZCAqYmUsIHVpbnQzMl90DQo+aHdwdF9pZCwNCj4+ICBib29sIGlvbW11ZmRfYmFja2Vu
ZF9nZXRfZGlydHlfYml0bWFwKElPTU1VRkRCYWNrZW5kICpiZSwNCj51aW50MzJfdCBod3B0X2lk
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgaW92
YSwgcmFtX2FkZHJfdA0KPnNpemUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50NjRfdCBwYWdlX3NpemUsDQo+dWludDY0X3QgKmRhdGEsDQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgZmxhZ3MsIEVycm9yDQo+
KiplcnJwKTsNCj4+ICBib29sIGlvbW11ZmRfYmFja2VuZF9pbnZhbGlkYXRlX2NhY2hlKElPTU1V
RkRCYWNrZW5kICpiZSwNCj51aW50MzJfdCBpZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQzMl90IGRhdGFfdHlwZSwNCj51aW50MzJfdCBlbnRyeV9sZW4s
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqZW50
cnlfbnVtLCB2b2lkDQo+KmRhdGEsDQo+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaW9tbXVmZC5j
IGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+PiBpbmRleCAyYTMzYzdhYjBiLi4zYzRmNjE1N2UyIDEw
MDY0NA0KPj4gLS0tIGEvYmFja2VuZHMvaW9tbXVmZC5jDQo+PiArKysgYi9iYWNrZW5kcy9pb21t
dWZkLmMNCj4+IEBAIC0zNjEsNyArMzYxLDcgQEAgYm9vbA0KPmlvbW11ZmRfYmFja2VuZF9nZXRf
ZGlydHlfYml0bWFwKElPTU1VRkRCYWNrZW5kICpiZSwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGh3cHRfaWQsDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBpb3ZhLCByYW1fYWRkcl90DQo+c2l6ZSwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHBhZ2Vf
c2l6ZSwNCj51aW50NjRfdCAqZGF0YSwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQ2NF90IGZsYWdzLCBFcnJvciAqKmVycnApDQo+PiAgew0KPj4gICAgICBp
bnQgcmV0Ow0KPj4gICAgICBzdHJ1Y3QgaW9tbXVfaHdwdF9nZXRfZGlydHlfYml0bWFwIGdldF9k
aXJ0eV9iaXRtYXAgPSB7DQo+PiBAQCAtMzcxLDExICszNzEsMTIgQEAgYm9vbA0KPmlvbW11ZmRf
YmFja2VuZF9nZXRfZGlydHlfYml0bWFwKElPTU1VRkRCYWNrZW5kICpiZSwNCj4+ICAgICAgICAg
IC5sZW5ndGggPSBzaXplLA0KPj4gICAgICAgICAgLnBhZ2Vfc2l6ZSA9IHBhZ2Vfc2l6ZSwNCj4+
ICAgICAgICAgIC5kYXRhID0gKHVpbnRwdHJfdClkYXRhLA0KPj4gKyAgICAgICAgLmZsYWdzID0g
ZmxhZ3MsDQo+PiAgICAgIH07DQo+Pg0KPj4gICAgICByZXQgPSBpb2N0bChiZS0+ZmQsIElPTU1V
X0hXUFRfR0VUX0RJUlRZX0JJVE1BUCwNCj4mZ2V0X2RpcnR5X2JpdG1hcCk7DQo+PiAgICAgIHRy
YWNlX2lvbW11ZmRfYmFja2VuZF9nZXRfZGlydHlfYml0bWFwKGJlLT5mZCwgaHdwdF9pZCwgaW92
YSwNCj5zaXplLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBwYWdlX3NpemUsIHJldCA/IGVycm5vIDoNCj4wKTsNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZmxhZ3MsIHBhZ2Vfc2l6ZSwgcmV0ID8NCj5lcnJubyA6
IDApOw0KPj4gICAgICBpZiAocmV0KSB7DQo+PiAgICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVy
cnAsIGVycm5vLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAiSU9NTVVfSFdQVF9HRVRf
RElSVFlfQklUTUFQDQo+KGlvdmE6IDB4JSJIV0FERFJfUFJJeA0KPj4gZGlmZiAtLWdpdCBhL2h3
L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IGluZGV4IDAwNTc0ODhjZTku
LmM4OTdhYTZiMTcgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4gKysrIGIv
aHcvdmZpby9pb21tdWZkLmMNCj4+IEBAIC02Miw3ICs2Miw3IEBAIHN0YXRpYyBpbnQgaW9tbXVm
ZF9jZGV2X3VubWFwX29uZShjb25zdA0KPlZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgaW92YSwgcmFtX2Fk
ZHJfdCBzaXplLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVRM
QkVudHJ5ICppb3RsYikNCj4+ICB7DQo+PiAtICAgIGNvbnN0IFZGSU9JT01NVUZEQ29udGFpbmVy
ICpjb250YWluZXIgPQ0KPj4gKyAgICBWRklPSU9NTVVGRENvbnRhaW5lciAqY29udGFpbmVyID0N
Cj4+ICAgICAgICAgIGNvbnRhaW5lcl9vZihiY29udGFpbmVyLCBWRklPSU9NTVVGRENvbnRhaW5l
ciwNCj5iY29udGFpbmVyKTsNCj4+ICAgICAgYm9vbCBuZWVkX2RpcnR5X3N5bmMgPSBmYWxzZTsN
Cj4+ICAgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+PiBAQCAtNzMsOSArNzMsMTIgQEAg
c3RhdGljIGludCBpb21tdWZkX2NkZXZfdW5tYXBfb25lKGNvbnN0DQo+VkZJT0NvbnRhaW5lckJh
c2UgKmJjb250YWluZXIsDQo+PiAgICAgIGlmIChpb3RsYiAmJiB2ZmlvX2NvbnRhaW5lcl9kaXJ0
eV90cmFja2luZ19pc19zdGFydGVkKGJjb250YWluZXIpKSB7DQo+PiAgICAgICAgICBpZg0KPigh
dmZpb19jb250YWluZXJfZGV2aWNlc19kaXJ0eV90cmFja2luZ19pc19zdXBwb3J0ZWQoYmNvbnRh
aW5lcikgJiYNCj4+ICAgICAgICAgICAgICBiY29udGFpbmVyLT5kaXJ0eV9wYWdlc19zdXBwb3J0
ZWQpIHsNCj4+ICsgICAgICAgICAgICBjb250YWluZXItPmRpcnR5X3RyYWNraW5nX2ZsYWdzID0N
Cj4+ICsNCj5JT01NVV9IV1BUX0dFVF9ESVJUWV9CSVRNQVBfTk9fQ0xFQVI7DQo+PiAgICAgICAg
ICAgICAgcmV0ID0gdmZpb19jb250YWluZXJfcXVlcnlfZGlydHlfYml0bWFwKGJjb250YWluZXIs
IGlvdmEsDQo+c2l6ZSwNCj4+DQo+aW90bGItPnRyYW5zbGF0ZWRfYWRkciwNCj4+DQo+JmxvY2Fs
X2Vycik7DQo+PiArICAgICAgICAgICAgY29udGFpbmVyLT5kaXJ0eV90cmFja2luZ19mbGFncyA9
IDA7DQo+DQo+V2h5IG5vdCBjaGFuZ2luZyB2ZmlvX2NvbnRhaW5lcl9xdWVyeV9kaXJ0eV9iaXRt
YXAgdG8gcGFzcyBhIGZsYWdzIHRvbywgbGlrZQ0KPnRoZQ0KPm9yaWdpbmFsIHBhdGNoZXM/IFRo
aXMgaXMgYSBsaXR0bGUgdW5uZWNzc2FyeSBvZGQgc3R5bGUgdG8gcGFzcyBhIGZsYWcgdmlhDQo+
Y29udGFpbmVyIHN0cnVjdHVyZSByYXRoZXIgYW5kIHRoZW4gY2xlYXJpbmcuDQoNCkp1c3Qgd2Fu
dCB0byBiZSBzaW1wbGVyLCBvcmlnaW5hbCBwYXRjaCBpbnRyb2R1Y2VkIGEgbmV3IHBhcmFtZXRl
ciB0byBhbG1vc3QgYWxsDQp2YXJpYW50cyBvZiAqX3F1ZXJ5X2RpcnR5X2JpdG1hcCgpIHdoaWxl
IHRoZSBmbGFncyBwYXJhbWV0ZXIgaXMgb25seSB1c2VkIGJ5DQpJT01NVUZEIGJhY2tlbmQgd2hl
biBkb2luZyB1bm1hcF9iaXRtYXAuIEN1cnJlbnRseSB3ZSBhbHJlYWR5IGhhdmUgdGhyZWUNCmJh
Y2tlbmRzLCBsZWdhY3kgVkZJTywgSU9NTVVGRCBhbmQgVkZJTy11c2VyLCBvbmx5IElPTU1VRkQg
bmVlZCB0aGUgZmxhZy4NCg0KSSB0YWtlIGNvbnRhaW5lci0+ZGlydHlfdHJhY2tpbmdfZmxhZ3Mg
YXMgYSBub3RpZmljYXRpb24gbWVjaGFuaXNtLCBzbyBzZXQgaXQgYmVmb3JlDQp2ZmlvX2NvbnRh
aW5lcl9xdWVyeV9kaXJ0eV9iaXRtYXAoKSBhbmQgY2xlYXIgaXQgdGhlcmVhZnRlci4gTWF5YmUg
Y2xlYXJpbmcgaXQgaW4NCmlvbW11ZmRfcXVlcnlfZGlydHlfYml0bWFwKCkgaXMgZWFzaWVyIHRv
IGJlIGFjY2VwdGFibGU/DQoNCj4NCj5QYXJ0IG9mIHRoZSByZWFzb24gdGhlIG9yaWdpbmFsIHNl
cmllcyBoYWQgYSBWRklPX0dFVF9ESVJUWV9OT19GTFVTSCBmb3INCj5nZW5lcmljDQo+Y29udGFp
bmVyIGFic3RyYWN0aW9uIHdhcyB0byBub3QgbWl4IElPTU1VRkQgVUFQSSBzcGVjaWZpY3MgaW50
byBiYXNlDQo+Y29udGFpbmVyDQo+QVBJLiBUaGVuIGluIGdldHRpbmcgYSBWRklPX0dFVF9ESVJU
WV9OT19GTFVTSCwgdGhlbiB0eXBlMSBiYWNrZW5kDQo+Y291bGQganVzdA0KPmlnbm9yZSB0aGUg
ZmxhZywgd2hpbGUgSU9NTVVGRCB0cmFuc2xhdGVzIGl0IHRvDQo+SU9NTVVfSFdQVF9HRVRfRElS
VFlfQklUTUFQX05PX0NMRUFSDQoNCkkgZGlkIHBvcnQgb3JpZ2luYWwgcGF0Y2ggaHR0cHM6Ly9n
aXRodWIuY29tL3lpbGl1MTc2NS9xZW11L2NvbW1pdC85OWY4MzU5NWQ3OWQyZTQxNzBjOWU0NTZj
ZjFhN2I5NTIxYmQ0ZjgwDQpCdXQgaXQgbG9va3MgY29tcGxleCB0byBoYXZlICdmbGFncycgcGFy
YW1ldGVyIGV2ZXJ5d2hlcmUuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

