Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252D5C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3z0n-0006te-0L; Tue, 08 Sep 2026 12:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x3z0f-0006tK-VR
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:49:26 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x3z0d-0000ei-2A
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788886163; x=1820422163;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=emM29KH+jJNPuKQ3Vb+63YLCteKMwLbz+m5YugABXNU=;
 b=LLv8GrzVlytTGZDkfPqTwdA+ZTszyVlO46PGfl+OWWb282ezEhN+XpxE
 BfvQlMaZ3SNNL9bG5uN5guMD97lBa3ENmghSwC7+vFuxVShMQWOKCsTNM
 dacbrip+T4Ah6BIEBoLzAovu7j8acPLlFqENo9ETtShlv0pAwugckUfCx
 ZMBtQlT28iIpApSJMyBlw6M0oCxxZoNQ7H56V/nXereY11KbEOJxSXcMu
 0cN100bjfk/bmff8pB3aX+SihHxMzGhiy/Xd6RUAyd7HemLlRvZR/HGVV
 QJFMnJ84ljS7bumAClRalPQDWACukm3y7sJ+XN+EEiiL5tvhsCzxJNw6t Q==;
X-CSE-ConnectionGUID: tYgxHlgeTFmz0MAfmR1qlw==
X-CSE-MsgGUID: u5sSn9nVQ5qPJtCI+47VfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88229682"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="88229682"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 09:49:19 -0700
X-CSE-ConnectionGUID: 3tVQiXTkQR66qG5M7OyQYg==
X-CSE-MsgGUID: 3lmvT3hETUi67xriJuC5UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="269311615"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 09:49:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 09:49:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 09:49:18 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 09:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJQm7USYslmxMiQgVII92+fXiU9ZSyZMxFZCSOAZMJxqzx1NQ2WxqFhPnueYKqH0hkF3beDcZl5UQ/PRa3Fn9tUu2tVpes/85Ga2rnEGRm8hNDTRmoYU1Y+eP+43+8qjySGiobGYEr+665ImbKI+NvziRU8qouSVxut8q+ou5v10igTnymkAk/yF2oYR7vTCeVMETmfGwqRwiWQ4phkwxZqBr+Lg8XiCqileXV8zFltne0v0NORs5ZuNDB2kFkdvxJqKg8rGWQphGKQI99EeWEngmm/qY14746TMvMXiLfLo4qfjeikPdNdcoZbZuRRUEclGcskB16N+pIqlmgYSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emM29KH+jJNPuKQ3Vb+63YLCteKMwLbz+m5YugABXNU=;
 b=Q7hucIv/PLqMszroHX3J7HF3NbkYkTEJ5qJsqXRXKQrxQGd9zvi49n0oB+6mkYGZkiqX2lYjkUDBoUExPNaxn1imvI11fiGtT3XTiMw9F791rM/YI80pAYLvxgEzeb6BLK8oTXhAeN+2iiuTlimWHERwJQNBPTlopWmUjI2+EhMoMFI7i2CqjWkxYJ/MPnUI9i5sVKosM27P06a289Z760cPa7TOhQkdWa37XekO6O40WpS2qNvHMdxItiJXgLPssBMnjeDVYxjOrQdkwx77ddcPwF1Xbm4TzakoZ7TyjzB6DkdKH0vlIqaA0VYPI7xcgsaFHFuFj7JaFOoBlKsb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by IA1PR11MB8803.namprd11.prod.outlook.com (2603:10b6:208:59a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 16:49:16 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 16:49:16 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] ui/gtk: Handle empty notebook state in menu handlers
Thread-Topic: [PATCH] ui/gtk: Handle empty notebook state in menu handlers
Thread-Index: AQHdPwYjhzr25zRXrkerUnSJYXpKI7bEXuUAgAB8ymA=
Date: Tue, 8 Sep 2026 16:49:16 +0000
Message-ID: <PH0PR11MB5112DE2261942C6F3058CD0FFAB12@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260907201724.523270-1-dongwon.kim@intel.com>
 <CAJ+F1CKJN8enxs5Me-QydcG-8mH4oQqd8aCtQa=phHa+r6yANw@mail.gmail.com>
In-Reply-To: <CAJ+F1CKJN8enxs5Me-QydcG-8mH4oQqd8aCtQa=phHa+r6yANw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|IA1PR11MB8803:EE_
x-ms-office365-filtering-correlation-id: 09a980e6-bb08-4da9-51d9-08df0dc91e80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: uCkN9q1ACmwOjR95ObYbZYiUx0GbJpKg9CEAuns3yQ3IW9hFujlxbxaLWXaV/3T2ZSdugeEPaDQYMymHIoWn/8uKE2F2yGpoXIv8s+ig6EemOjYFOQFyWhQdZSPgOoBSe+D+JteaZnQu8UAcXDkVuiUi9cSd3DtQxo8Uci21nmzrz6Ex2fiqizt41oapAGy4vk0UYXTXKweX3cDzbYNBjEiBe4uUi77a4nxrRIlLpW3tVFAXs0FbZvVJ7rVabkhWo0mSznCGiZ3GwAyqElIh5Sqp9NgtP282jpoJoM4VCAMGuus1J4g+6lFL+88d2G+9SUTv/c9APfqEp6nE+MASWBTmlHV7Gd54sStww4O7y8j/9lI369sQp0h+N1qU7TxJRaQZl8XRnvhQ/WL4M0oObHumalIeWmAEmYOmyOuQxjon2zpe6EJqCjOoGXTz5fiT8Imz9yc+3Tm8Yp+po+1DfTYgdjpF7VMINwuo2GHjXFeEd/ASXnfdnk69m/iYFMqd6MYHlJWn9X1DWvHvtQD365QDSi0IC4G9M/iE6XP0jgYRn/4miKoYtkeV9O79PnMxJ8qbpzATnG1r7V+VefFk8V4Ynw1rtqFYXN5CHhTiQuhkLDuHv5qFWSa0xgaKGc0MgVFse4mcPBxpzH+jg71dulcNxvPKLWy0Jw2+lf5JnJp2SqOKdfcVEnL4J3ECaDF1MxtG8WbavfWxo6ym+Vq9vA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHhnTGpER0pPNVlLaGpWNkZhV1ZzbFVLajdoSFJMOVliM0dRN0w1MVNtbjNp?=
 =?utf-8?B?TXRCTFF2ZEU5dkNJT3lpUksyc1QyMGJyVnJHK052Q1RIM0lTZkNaQmI0K3ZH?=
 =?utf-8?B?c1prSUpybUR5eU84L29KQ01pbnBna2YwdUk3TjVUUzE2SEVVZVBrZzZoTGpT?=
 =?utf-8?B?SkozcUZoZWJ0QXVlcHA3QmRnVnFvWi82U1o3UHIrbFBpdkt2dnJoZmpqS01E?=
 =?utf-8?B?eW5PWkl1WTE5SXBJS0l3Uks4d1BGcmRmT1ZNc2Rmd1pYWkNZc0JFRHZzaE4x?=
 =?utf-8?B?L1F6YUxyc0tUd3gyTnh3c2RDVklHUkY5Sktvdm1nYWt3bnVtZDdjZWowTnBP?=
 =?utf-8?B?ZHZVRzYrcVdkK25YRS9CdHlMYjdsQitkdWxmVldBdk1KT0lZOVVCa3BXd3E0?=
 =?utf-8?B?Z2dLTXJ1Vnd6VmRVSXdUMmhCQStHUHoxN2hHVzJJSTVML2tFRnRzNm1rT0Nx?=
 =?utf-8?B?b0pIRkxDbjJBQWtsV1E4bUgrVVU2U1QyazlMb1ZpUWZaTGpLeGFuSE8xaTEw?=
 =?utf-8?B?QTlSbnZpa21TTFpZUnBwNm1kSzk4c3QzbXBLSTVrVWJNSWI0V0s5c1B6cmxY?=
 =?utf-8?B?TXJKSWV0ZFowbTJuRlBDNWYrT3RhY09hSmNHUWJQaTFjN29aQW5JOXNvNzdi?=
 =?utf-8?B?RXYrTGpGem1DbDFwaFcreGc4R3h5VGFaMzBzUU9MSEdsM0Q1cTJERXZteEw1?=
 =?utf-8?B?V0ljMlNZTzBobnY0YzhkUlRGeDdHVWtZYW40T1JSUTh3RkdTb3g1UmpOWUxQ?=
 =?utf-8?B?NHc2QTBramVBUmRsKzcvcWZZT0ZBRVU2L0tzTVZocnBETHljUmFuOGs1MTJK?=
 =?utf-8?B?SERCeW01NDRFMGU1d2VzRGZhand1NHpVS2VFOXBWbjM0VTk2MzcydzB4SHV4?=
 =?utf-8?B?WHRMMzdwSy9DZ2p4T01yVFEzdGsrcVFiSUhlMm5vMGJySWFvYjdnUGI3SmVs?=
 =?utf-8?B?bEFlajczT2tickF6M1dvaGtwbzhrZXp0aUh3UEg5RUVqUkpiRUVUaFFCb1E2?=
 =?utf-8?B?UnAva1FnUVc3eFZIQTI4UFFVSk5TdW9UWk5GdkFtNHdtS2pxbDhJYzg0TFpl?=
 =?utf-8?B?T3R3MERYNWJLU2ZBbzJTbld4QUZyUC9xSkJUNGxkbDBwekk2bDc4Sjd3RmM4?=
 =?utf-8?B?TkFMNDdrSDJZdHcva2xMVkY5eFlIVVZGamYvUGJkSHYweDBrdlM5MklWeXdN?=
 =?utf-8?B?Wk1TaWlGMThIUGhQR1dzL1BzQVNWS1IvT1NGcTAxcDJYN3YyT1M0cjNnenM4?=
 =?utf-8?B?dFBmWWVzTXpycXVZYVpJNm9yTjVVejA4bXlWTm10ZStlUEZ2U1ZNQWpzbVNX?=
 =?utf-8?B?ek51QjFpc2ZvWmljZDhibUNQTHVHQXJUandJdVgzYmN0ZkxONkREcEhMVmp1?=
 =?utf-8?B?ajZjclZna1pkZVdPQVhsTHYwU2xCK1FrSXA0RDBzVkI1RVRBMC8vd3JmU2NR?=
 =?utf-8?B?YzI0VnZEcXRMb0pjWlRRMXBnU3JNSmtNUHVBWjFWL09KSW5KSC9veTNIdDJG?=
 =?utf-8?B?L2loaTF4b3VqZmtaUlY3cVB1djdHTjQ1V3RzazdnR25HQ0x2UHgvdlZyYUhy?=
 =?utf-8?B?QndXTGVTNVQxdDlQRlk4TmdSdmJvZEFvR1FqL3NtMDlNZFZRTjd5STdJNFpM?=
 =?utf-8?B?QVMwQlZiVEU1aWNzTjRvUEFzdURRZ2R6M0l1S1JEUlZqajJ4M1Ftb1ZicFdW?=
 =?utf-8?B?b0NyckRJdXkxTmJFelV4NmRWUkhjU0FwcjdhRk10Q25HOWZJblUrbUhDc3p3?=
 =?utf-8?B?RS9hWGh0bi9QL2JpSFFqRFNaUmF1YzUzbHZQWEwrSXhQQzlYY3YxQ1Q5MnlN?=
 =?utf-8?B?Qk5LUXVJWlovU0U1S0M1SmVWRE94ZjI2SXk5cnpMbkFpNkJSaWpESTg0MGMw?=
 =?utf-8?B?WHkvaXVJTWJic3d2emdObVlwMkJWWXZxQnZobUtGbGtGZHVKS0dlWmxHRklY?=
 =?utf-8?B?bGpZRWRZcVFpTnlNL29SM2NNY3VVZWVOV25iOVRrdXZaT0lYSkZXM1M5YVlt?=
 =?utf-8?B?NzhablVMd0phcUxXS1VaemlPUCtyTmZMYitQUWh2Ymg2NUlMK1dVSHJDdnBv?=
 =?utf-8?B?R0k3ZlRCVzRuc0FjQnFIUlM5T2FrQ25pOFNDSlcwTWpPMmEvZDdacVh5TTZi?=
 =?utf-8?B?VzQwUnkxd3VUMEI3NnJ6RkdmVlMrVHdWZExWbEdvV1JFRGNlODBGYyt4WGtx?=
 =?utf-8?B?V2x6YjN2d25iVXZpTk5FdWozMUZXVytNRzJLQ3FzK3UzQ01UMTZQUEw3VjEw?=
 =?utf-8?B?U0UzcDdKSmQvOFlVR1lvcDhDS3BtVVFqRlB1KzVxcUpodzFOd1I3WlhaWVhp?=
 =?utf-8?B?U2xFSEZqd1BKZWh6WUp6QkZzcWw5UVYrd2xBQ0RxNk02ZldqbDJjdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G87P0Whc14JdVD/Ggdx/cG8v04cRiALkg50njD7cENsrlELYnW1J3iJsk+rpfh7ftS8O7EB4BmP0wnPKYL8lsErNEDY/86vbnNYycfseWX/Uopyjw/foU0ciacizbltER8ZFmawXhULi7O03tdgkS8bqAY2PDXvn2JHhl3GeyGkejK75WUD/XIFpZot/9/BkSSl/pF69msNr6zitA3PK2LTRqIXYE8+x+1oBjXBA6AdOMLvcMnVSuGwLSgYKI17prLdWX6M4k5mMkssq8sBh9HxzXABMO+aDyG4x0IEs7D7W3ApG4hZwLAQB5VaaGBhcegQh15YYi3bA1EKaMmz1uQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a980e6-bb08-4da9-51d9-08df0dc91e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 16:49:16.1171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4RcsphIECjygwdIuCBU7p60oNxlvRXRgsByYqPynukPbtoTp1dIC9SzumdHQ5gPmVTlRxhniFb2CtEU2Z79TQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8803
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdWkvZ3RrOiBIYW5kbGUg
ZW1wdHkgbm90ZWJvb2sgc3RhdGUgaW4gbWVudSBoYW5kbGVycw0KPiANCj4gSGkNCj4gDQo+IE9u
IFR1ZSwgU2VwIDgsIDIwMjYgYXQgMTI6MTjigK9BTSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPiB3
cm90ZToNCj4gPg0KPiA+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+
DQo+ID4NCj4gPiBXaGVuIHRoZSBHVEsgbm90ZWJvb2sgaGFzIG5vIGFjdGl2ZSBwYWdlIChlLmcu
IGJlZm9yZSBwYWdlcyBhcmUgYWRkZWQNCj4gPiBvciBpZiBhbGwgcGFnZXMgYXJlIGRldGFjaGVk
L3JlbW92ZWQpLCBndGtfbm90ZWJvb2tfZ2V0X2N1cnJlbnRfcGFnZSgpDQo+ID4gcmV0dXJucyAt
MS4gUHJldmlvdXNseSwgdGhpcyB2YWx1ZSB3YXMgcGFzc2VkIHVuY2hlY2tlZCB0bw0KPiA+IGdk
X3ZjX2ZpbmRfYnlfcGFnZSgpLCB3aGljaCBjb3VsZCByZXN1bHQgaW4gdW5leHBlY3RlZCBsb29r
dXBzIG9yIE5VTEwNCj4gPiBkZXJlZmVyZW5jZXMuDQo+ID4NCj4gPiBVcGRhdGUgZ2RfdmNfZmlu
ZF9jdXJyZW50KCkgdG8gZXhwbGljaXRseSByZXR1cm4gTlVMTCB3aGVuIHBhZ2UgPCAwLg0KPiA+
IEFkZGl0aW9uYWxseSwgYWRkIE5VTEwgY2hlY2tzIGZvciB0aGUgY3VycmVudCBWaXJ0dWFsQ29u
c29sZSBhY3Jvc3MNCj4gPiBhbGwgcmVsZXZhbnQgVUkgbWVudSBjYWxsYmFja3MgdG8gYXZvaWQg
ZGVyZWZlcmVuY2luZyBhbiBpbnZhbGlkIG9yDQo+ID4gTlVMTCBwb2ludGVyIHdoZW4gbm8gY29u
c29sZSB0YWIgaXMgY3VycmVudGx5IGZvY3VzZWQuDQo+IA0KPiBUaGlzIGxvb2tzIHJlYXNvbmFi
bGUsIGJ1dCBjYW4gaXQgaGFwcGVuPyBpZiBzbywgaG93PyBSYXRoZXIgdGhhbiBoYW5kbGluZyBh
DQo+IHNpdHVhdGlvbiB0aGF0IHNob3VsZCBub3QgaGFwcGVuLCBJIHdvdWxkIHJhdGhlciBjcmFz
aCBvciBhYm9ydCBpZiB3ZSBicm9rZSBhbg0KPiBpbnZhcmlhbnQuDQo+IA0KPiB0aGFua3MNCg0K
VGhlIG1lbnRpb24gb2YgIk5VTEwgZGVyZWZlcmVuY2VzIiBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ug
d2FzIGluYWNjdXJhdGUuDQpJdCdzIG5vdCBjYXVzaW5nIGEgY3Jhc2gsIGJ1dCByYXRoZXIgbG9n
aWMgYnVncy4gVGhpcyBoYXBwZW5zIHdoZW4gYWxsIFZDIHRhYnMNCmFyZSBkZXRhY2hlZCAodW50
YWJpZmllZCkuIEluIHRoYXQgc3RhdGU6DQoNCmd0a19ub3RlYm9va19nZXRfY3VycmVudF9wYWdl
KCkgcmV0dXJucyAtMS4NCg0KRm9yIGFueSBkZXRhY2hlZCB0YWIsIGd0a19ub3RlYm9va19wYWdl
X251bSgpIGFsc28gcmV0dXJucyAtMS4NCg0KQ29uc2VxdWVudGx5LCBnZF92Y19maW5kX2J5X3Bh
Z2UocywgLTEpIG1hdGNoZXMgdGhlIHZlcnkgZmlyc3QgZGV0YWNoZWQNCmNvbnNvbGUgaW4gcy0+
dmNzLiBNZW51IGFjdGlvbnMgdHJpZ2dlcmVkIG9uIHRoZSBlbXB0eSBtYWluIHdpbmRvdyBtaXN0
YWtlbmx5DQpyb3V0ZSB0byB0aGF0IGRldGFjaGVkIHdpbmRvdyBpbnN0ZWFkIG9mIGJlaW5nIGln
bm9yZWQuDQoNClRoYW5rcyENCg0KPiANCj4gPg0KPiA+IENjOiBEYW5pZWwgUC4gQmVycmFuZ8Op
IDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiA+IENjOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNh
bmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nd29uIEtpbSA8
ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICB1aS9ndGsuYyB8IDU2DQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdWkvZ3RrLmMgYi91aS9ndGsuYw0KPiA+IGluZGV4IDcwNzhk
ODlkNjcuLjBiNTEzOWVmMzEgMTAwNjQ0DQo+ID4gLS0tIGEvdWkvZ3RrLmMNCj4gPiArKysgYi91
aS9ndGsuYw0KPiA+IEBAIC0xODQsNiArMTg0LDExIEBAIHN0YXRpYyBWaXJ0dWFsQ29uc29sZQ0K
PiAqZ2RfdmNfZmluZF9jdXJyZW50KEd0a0Rpc3BsYXlTdGF0ZSAqcykNCj4gPiAgICAgIGdpbnQg
cGFnZTsNCj4gPg0KPiA+ICAgICAgcGFnZSA9IGd0a19ub3RlYm9va19nZXRfY3VycmVudF9wYWdl
KEdUS19OT1RFQk9PSyhzLT5ub3RlYm9vaykpOw0KPiA+ICsNCj4gPiArICAgIGlmIChwYWdlIDwg
MCkgew0KPiA+ICsgICAgICAgIHJldHVybiBOVUxMOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAg
ICAgIHJldHVybiBnZF92Y19maW5kX2J5X3BhZ2UocywgcGFnZSk7ICB9DQo+ID4NCj4gPiBAQCAt
MTQ2Miw3ICsxNDY3LDEwIEBAIHN0YXRpYyB2b2lkIGdkX21lbnVfc2hvd190YWJzKEd0a01lbnVJ
dGVtDQo+ICppdGVtLCB2b2lkICpvcGFxdWUpDQo+ID4gICAgICB9IGVsc2Ugew0KPiA+ICAgICAg
ICAgIGd0a19ub3RlYm9va19zZXRfc2hvd190YWJzKEdUS19OT1RFQk9PSyhzLT5ub3RlYm9vayks
IEZBTFNFKTsNCj4gPiAgICAgIH0NCj4gPiAtICAgIGdkX3VwZGF0ZV93aW5kb3dzaXplKHZjKTsN
Cj4gPiArDQo+ID4gKyAgICBpZiAodmMpIHsNCj4gPiArICAgICAgICBnZF91cGRhdGVfd2luZG93
c2l6ZSh2Yyk7DQo+ID4gKyAgICB9DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgaW50IGdkX3Zj
X25vdGVib29rX3BvcyhHdGtEaXNwbGF5U3RhdGUgKnMsIFZpcnR1YWxDb25zb2xlDQo+ID4gKnRh
cmdldCkgQEAgLTE1MzUsNiArMTU0MywxMCBAQCBzdGF0aWMgdm9pZA0KPiBnZF9tZW51X3VudGFi
aWZ5KEd0a01lbnVJdGVtICppdGVtLCB2b2lkICpvcGFxdWUpDQo+ID4gICAgICBHdGtEaXNwbGF5
U3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4gICAgICBWaXJ0dWFsQ29uc29sZSAqdmMgPSBnZF92Y19m
aW5kX2N1cnJlbnQocyk7DQo+ID4NCj4gPiArICAgIGlmICghdmMpIHsNCj4gPiArICAgICAgICBy
ZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICAgICAgaWYgKHZjLT50eXBlID09IEdEX1ZD
X0dGWCAmJg0KPiA+ICAgICAgICAgIHFlbXVfY29uc29sZV9pc19ncmFwaGljKHZjLT5nZnguZGNs
LmNvbikpIHsNCj4gPg0KPiA+IGd0a19jaGVja19tZW51X2l0ZW1fc2V0X2FjdGl2ZShHVEtfQ0hF
Q0tfTUVOVV9JVEVNKHMtPmdyYWJfaXRlbSksDQo+ID4gQEAgLTE1ODgsNyArMTYwMCwxMCBAQCBz
dGF0aWMgdm9pZA0KPiBnZF9tZW51X3Nob3dfbWVudWJhcihHdGtNZW51SXRlbSAqaXRlbSwgdm9p
ZCAqb3BhcXVlKQ0KPiA+ICAgICAgfSBlbHNlIHsNCj4gPiAgICAgICAgICBndGtfd2lkZ2V0X2hp
ZGUocy0+bWVudV9iYXIpOw0KPiA+ICAgICAgfQ0KPiA+IC0gICAgZ2RfdXBkYXRlX3dpbmRvd3Np
emUodmMpOw0KPiA+ICsNCj4gPiArICAgIGlmICh2Yykgew0KPiA+ICsgICAgICAgIGdkX3VwZGF0
ZV93aW5kb3dzaXplKHZjKTsNCj4gPiArICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyB2
b2lkIGdkX2FjY2VsX3Nob3dfbWVudWJhcih2b2lkICpvcGFxdWUpIEBAIC0xNjA1LDcgKzE2MjAs
Nw0KPiBAQA0KPiA+IHN0YXRpYyB2b2lkIGdkX21lbnVfZnVsbF9zY3JlZW4oR3RrTWVudUl0ZW0g
Kml0ZW0sIHZvaWQgKm9wYXF1ZSkNCj4gPiAgICAgIGlmICghcy0+ZnVsbF9zY3JlZW4pIHsNCj4g
PiAgICAgICAgICBndGtfbm90ZWJvb2tfc2V0X3Nob3dfdGFicyhHVEtfTk9URUJPT0socy0+bm90
ZWJvb2spLCBGQUxTRSk7DQo+ID4gICAgICAgICAgZ3RrX3dpZGdldF9oaWRlKHMtPm1lbnVfYmFy
KTsNCj4gPiAtICAgICAgICBpZiAodmMtPnR5cGUgPT0gR0RfVkNfR0ZYKSB7DQo+ID4gKyAgICAg
ICAgaWYgKHZjICYmIHZjLT50eXBlID09IEdEX1ZDX0dGWCkgew0KPiA+ICAgICAgICAgICAgICBn
dGtfd2lkZ2V0X3NldF9zaXplX3JlcXVlc3QodmMtPmdmeC5kcmF3aW5nX2FyZWEsIC0xLCAtMSk7
DQo+ID4gICAgICAgICAgfQ0KPiA+ICAgICAgICAgIGd0a193aW5kb3dfZnVsbHNjcmVlbihHVEtf
V0lORE9XKHMtPndpbmRvdykpOw0KPiA+IEBAIC0xNjE4LDE0ICsxNjMzLDE2IEBAIHN0YXRpYyB2
b2lkIGdkX21lbnVfZnVsbF9zY3JlZW4oR3RrTWVudUl0ZW0NCj4gKml0ZW0sIHZvaWQgKm9wYXF1
ZSkNCj4gPiAgICAgICAgICAgICAgZ3RrX3dpZGdldF9zaG93KHMtPm1lbnVfYmFyKTsNCj4gPiAg
ICAgICAgICB9DQo+ID4gICAgICAgICAgcy0+ZnVsbF9zY3JlZW4gPSBGQUxTRTsNCj4gPiAtICAg
ICAgICBpZiAodmMtPnR5cGUgPT0gR0RfVkNfR0ZYKSB7DQo+ID4gKyAgICAgICAgaWYgKHZjICYm
IHZjLT50eXBlID09IEdEX1ZDX0dGWCkgew0KPiA+ICAgICAgICAgICAgICB2Yy0+Z2Z4LnNjYWxl
X3ggPSB2Yy0+Z2Z4LnByZWZlcnJlZF9zY2FsZTsNCj4gPiAgICAgICAgICAgICAgdmMtPmdmeC5z
Y2FsZV95ID0gdmMtPmdmeC5wcmVmZXJyZWRfc2NhbGU7DQo+ID4gICAgICAgICAgICAgIGdkX3Vw
ZGF0ZV93aW5kb3dzaXplKHZjKTsNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICB9DQo+ID4NCj4g
PiAtICAgIGdkX3VwZGF0ZV9jdXJzb3IodmMpOw0KPiA+ICsgICAgaWYgKHZjKSB7DQo+ID4gKyAg
ICAgICAgZ2RfdXBkYXRlX2N1cnNvcih2Yyk7DQo+ID4gKyAgICB9DQo+ID4gIH0NCj4gPg0KPiA+
ICBzdGF0aWMgdm9pZCBnZF9hY2NlbF9mdWxsX3NjcmVlbih2b2lkICpvcGFxdWUpIEBAIC0xNjM5
LDYgKzE2NTYsMTAgQEANCj4gPiBzdGF0aWMgdm9pZCBnZF9tZW51X3pvb21faW4oR3RrTWVudUl0
ZW0gKml0ZW0sIHZvaWQgKm9wYXF1ZSkNCj4gPiAgICAgIEd0a0Rpc3BsYXlTdGF0ZSAqcyA9IG9w
YXF1ZTsNCj4gPiAgICAgIFZpcnR1YWxDb25zb2xlICp2YyA9IGdkX3ZjX2ZpbmRfY3VycmVudChz
KTsNCj4gPg0KPiA+ICsgICAgaWYgKCF2Yykgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiAr
ICAgIH0NCj4gPiArDQo+ID4gICAgICBndGtfY2hlY2tfbWVudV9pdGVtX3NldF9hY3RpdmUoR1RL
X0NIRUNLX01FTlVfSVRFTShzLQ0KPiA+em9vbV9maXRfaXRlbSksDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRkFMU0UpOw0KPiA+DQo+ID4gQEAgLTE2NTksNiArMTY4
MCwxMCBAQCBzdGF0aWMgdm9pZCBnZF9tZW51X3pvb21fb3V0KEd0a01lbnVJdGVtDQo+ICppdGVt
LCB2b2lkICpvcGFxdWUpDQo+ID4gICAgICBHdGtEaXNwbGF5U3RhdGUgKnMgPSBvcGFxdWU7DQo+
ID4gICAgICBWaXJ0dWFsQ29uc29sZSAqdmMgPSBnZF92Y19maW5kX2N1cnJlbnQocyk7DQo+ID4N
Cj4gPiArICAgIGlmICghdmMpIHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+
ID4gKw0KPiA+ICAgICAgZ3RrX2NoZWNrX21lbnVfaXRlbV9zZXRfYWN0aXZlKEdUS19DSEVDS19N
RU5VX0lURU0ocy0NCj4gPnpvb21fZml0X2l0ZW0pLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEZBTFNFKTsNCj4gPg0KPiA+IEBAIC0xNjc2LDYgKzE3MDEsMTAgQEAg
c3RhdGljIHZvaWQgZ2RfbWVudV96b29tX2ZpeGVkKEd0a01lbnVJdGVtDQo+ICppdGVtLCB2b2lk
ICpvcGFxdWUpDQo+ID4gICAgICBHdGtEaXNwbGF5U3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4gICAg
ICBWaXJ0dWFsQ29uc29sZSAqdmMgPSBnZF92Y19maW5kX2N1cnJlbnQocyk7DQo+ID4NCj4gPiAr
ICAgIGlmICghdmMpIHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0K
PiA+ICAgICAgdmMtPmdmeC5zY2FsZV94ID0gdmMtPmdmeC5wcmVmZXJyZWRfc2NhbGU7DQo+ID4g
ICAgICB2Yy0+Z2Z4LnNjYWxlX3kgPSB2Yy0+Z2Z4LnByZWZlcnJlZF9zY2FsZTsNCj4gPg0KPiA+
IEBAIC0xNjg3LDYgKzE3MTYsMTAgQEAgc3RhdGljIHZvaWQgZ2RfbWVudV96b29tX2ZpdChHdGtN
ZW51SXRlbQ0KPiAqaXRlbSwgdm9pZCAqb3BhcXVlKQ0KPiA+ICAgICAgR3RrRGlzcGxheVN0YXRl
ICpzID0gb3BhcXVlOw0KPiA+ICAgICAgVmlydHVhbENvbnNvbGUgKnZjID0gZ2RfdmNfZmluZF9j
dXJyZW50KHMpOw0KPiA+DQo+ID4gKyAgICBpZiAoIXZjKSB7DQo+ID4gKyAgICAgICAgcmV0dXJu
Ow0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAgICAgIGlmIChndGtfY2hlY2tfbWVudV9pdGVtX2dl
dF9hY3RpdmUoR1RLX0NIRUNLX01FTlVfSVRFTShzLQ0KPiA+em9vbV9maXRfaXRlbSkpKSB7DQo+
ID4gICAgICAgICAgcy0+ZnJlZV9zY2FsZSA9IFRSVUU7DQo+ID4gICAgICB9IGVsc2Ugew0KPiA+
IEBAIC0xODAwLDYgKzE4MzMsMTEgQEAgc3RhdGljIHZvaWQgZ2RfbWVudV9ncmFiX2lucHV0KEd0
a01lbnVJdGVtDQo+ICppdGVtLCB2b2lkICpvcGFxdWUpDQo+ID4gICAgICBWaXJ0dWFsQ29uc29s
ZSAqdmMgPSBnZF92Y19maW5kX2N1cnJlbnQocyk7DQo+ID4NCj4gPiAgICAgIGlmIChnZF9pc19n
cmFiX2FjdGl2ZShzKSkgew0KPiA+ICsgICAgICAgIGlmICghdmMpIHsNCj4gPiArICAgICAgICAg
ICAgZ3RrX2NoZWNrX21lbnVfaXRlbV9zZXRfYWN0aXZlKEdUS19DSEVDS19NRU5VX0lURU0ocy0N
Cj4gPmdyYWJfaXRlbSksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBGQUxTRSk7DQo+ID4gKyAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICAgICB9
DQo+ID4gICAgICAgICAgZ2RfZ3JhYl9rZXlib2FyZCh2YywgInVzZXItcmVxdWVzdC1tYWluLXdp
bmRvdyIpOw0KPiA+ICAgICAgICAgIGdkX2dyYWJfcG9pbnRlcih2YywgInVzZXItcmVxdWVzdC1t
YWluLXdpbmRvdyIpOw0KPiA+ICAgICAgfSBlbHNlIHsNCj4gPiBAQCAtMTgwNyw3ICsxODQ1LDkg
QEAgc3RhdGljIHZvaWQgZ2RfbWVudV9ncmFiX2lucHV0KEd0a01lbnVJdGVtDQo+ICppdGVtLCB2
b2lkICpvcGFxdWUpDQo+ID4gICAgICAgICAgZ2RfdW5ncmFiX3BvaW50ZXIocyk7DQo+ID4gICAg
ICB9DQo+ID4NCj4gPiAtICAgIGdkX3VwZGF0ZV9jdXJzb3IodmMpOw0KPiA+ICsgICAgaWYgKHZj
KSB7DQo+ID4gKyAgICAgICAgZ2RfdXBkYXRlX2N1cnNvcih2Yyk7DQo+ID4gKyAgICB9DQo+ID4g
IH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBnZF9jaGFuZ2VfcGFnZShHdGtOb3RlYm9vayAqbmIs
IGdwb2ludGVyIGFyZzEsIGd1aW50DQo+ID4gYXJnMiwgQEAgLTE5ODMsNiArMjAyMywxMCBAQCBz
dGF0aWMgdm9pZCBnZF9tZW51X2NvcHkoR3RrTWVudUl0ZW0NCj4gKml0ZW0sIHZvaWQgKm9wYXF1
ZSkNCj4gPiAgICAgIEd0a0Rpc3BsYXlTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4gPiAgICAgIFZpcnR1
YWxDb25zb2xlICp2YyA9IGdkX3ZjX2ZpbmRfY3VycmVudChzKTsNCj4gPg0KPiA+ICsgICAgaWYg
KCF2Yykgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICNp
ZiBWVEVfQ0hFQ0tfVkVSU0lPTigwLCA1MCwgMCkNCj4gPiAgICAgIHZ0ZV90ZXJtaW5hbF9jb3B5
X2NsaXBib2FyZF9mb3JtYXQoVlRFX1RFUk1JTkFMKHZjLT52dGUudGVybWluYWwpLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVEVfRk9STUFUX1RFWFQpOw0K
PiA+IC0tDQo+ID4gMi40My4wDQo+ID4NCj4gPg0KPiANCj4gDQo+IC0tDQo+IE1hcmMtQW5kcsOp
IEx1cmVhdQ0K

