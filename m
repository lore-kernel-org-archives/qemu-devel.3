Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66EBC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmx8x-0002LH-BG; Wed, 20 Mar 2024 10:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmx8v-0002Kw-M6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:42:13 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmx8r-0002g9-3V
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710945729; x=1742481729;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gosYdHKEBn1fEsy+CkNh4v+nPVI/U30bbhUQkDYPBYc=;
 b=MupE2VEtJg990nvetrRX5Ms5CsitISiWLgR/kx0OZMUqC1XX2cIUHEQ1
 ggZPP5RTdNic1t0tNJjYc0rfunvULDdCH5t59Bzjaz29G2zg1EuSAkXbt
 m086EOtsPHn/fMDFwmbnZ/4bFerzhR67G5oSQXXXCjfx1Yi2P9MJHYAhX
 ERpSaEQY3Jr/3a3Js29SBFtVT/xxz0cDqKFMr/SxapL+qL3GEXeoKQZ8t
 c3iAM6s+uoUnDq+8T9HepEpvCu9F2uUzXER233WTFE1Jc8mIfr7N+FZx/
 GD5htewhksF09Xn1KXfODeMPNEj6YCZ6l5FByS37O3jC6kaMzRsKi/Z2k w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="17275080"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="17275080"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 07:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="18911017"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Mar 2024 07:42:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 07:42:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 07:42:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 07:42:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaMK9azu+UkXHxF6cWPXBCgG0qz7cqDIsDVMHicCe1an1v4JJyegKRmMeHhpk4T29E30EDTXK0N4Qr8Aq+kGN6Pnkkemam5BeX6tuhwRReKgZIqDKq0ZOaMHq33srJJGIAo1Qf4AgcwWSfFb6LUTS4W4xCmZ1WUazSHOPoIfLjiEQKxi1/EFs27EHMCwxWsvA80ci6dZnRgloaLY12W3cKjlO5JNkiodsE8y9eUUgzzLNhWaXhLepm2Z8ucsi1sVEJApbUWcS25de1cta1mhOEu38z8oj8VpbhBqFzcvJEWuXEPoNYpk302QWusjibpFVKl9YSp7jeWlge0D1et9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gosYdHKEBn1fEsy+CkNh4v+nPVI/U30bbhUQkDYPBYc=;
 b=HI5xIAQPdRTZKCBROxK8Sm0qquv4j17NZFhmLX38wO+G0H7+ZdQZRySQI8Q+HXY3BlFTtX8XSbuc0XpgMX+iRYY9RrXnDyqYT4oNz5rot6cwUxT5t9MMj8nTTfJ5mBUhZP1F8IlmQJB20F8c9QEoLC42sdXoLtBUbqP13R+FGOac+7DZWtLuxwPazW8ykiTYIontFJ3Ead43dNfwqOwLvG34hlLFwT9vzaU+CO/HMA4PTAGCkN0li3Hx53oAkZfHtJ2hAXSDfzaz9GJq8Z1XGS7EwHK3W7mCPXLU6hdWXHVA4qUtPXGzjN+ymr2W0XOJSvKihmfg9W2HvVBS9dHFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SN7PR11MB6849.namprd11.prod.outlook.com (2603:10b6:806:2a1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10; Wed, 20 Mar
 2024 14:42:03 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 14:42:03 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 3/7] configure: add --enable-qpl build option
Thread-Topic: [PATCH v5 3/7] configure: add --enable-qpl build option
Thread-Index: AQHaeqFAp/BSNyhWSU+idVclCeNmKLFAbj4AgABD2TA=
Date: Wed, 20 Mar 2024 14:42:03 +0000
Message-ID: <PH7PR11MB5941EFA36E738083110F15FAA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-4-yuan1.liu@intel.com> <Zfq6-s9xRse06R6k@redhat.com>
In-Reply-To: <Zfq6-s9xRse06R6k@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SN7PR11MB6849:EE_
x-ms-office365-filtering-correlation-id: ab5c4421-dd93-4936-a8e9-08dc48ebe853
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jwZz4ykvR0TYZfKbNzDYBDNWLIV19gzjzkzgT64we+6eIlph5w37lmfm1UqwBrvKmz7hPGXZnXRcqMCFnHSANZefwJ5e6Quw3mIYaUEiAykmO5vTYDUcxYM5mQyc8Mf+o40/OYs9+wH/EfWkK5f74uSZInPHLl7atfDHfBHsgkxEernlLVRleNlPJzvkV9k4v+tMqFXZZovaZ8WM3EoFcI932ZtetMWC2pu00+6DozAiW1FS2vtGYMBBttHTp5ItUar1gUg5TL3jbWngnTJVJUt9ByqOCKVmGS1xUlfjnfkG+F0gLkwrt0aSLIQX5nZQ0rHzy+v+fi0Tb89C4t/XR4wC9BG38O2vXeyzPjARv1Qd7F7FnNafZ2nFaHNggn4BR9Fkz+gQoWp5W4cmHCPuAaqwXaKStcFjAn1toZjLZ2ZOAKSbmd/1qozZwVT3LU9uqxwrv0hDTVRNkiXCAd26Y75QWlMl4w9p+PXKXcRdgEPsa4QjEVJeGS9Y8zb76ZFc+yXGitd+r4YkQopmT388ADmiOf56eFm2X62OtsDqVcgbKgakdmnSKgFA510yHsOGKctjvY/rlZqcCbknslmZv5539vYYhBAwhaul6vLXbdjclQ0MDX8hiZHR468pKwB3uUT5mLdQb/g0W0bMc/gBPCvVEy/MnNpQBpUGZVlQwh7be8qF5TSk6s4LSgEUY8WO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHphaUdCMHRKOTZYMXZIMG1wUmg4WGFVbHFabGN1ckxZYWprcTkwbFc0U1BB?=
 =?utf-8?B?dXRhbkJ4MFNLR0Y2VWlXQ1k2Zzk5MHlUdUd3Vjc2UGUydVZBenFRWGMyVXBR?=
 =?utf-8?B?N2V0NUVOa3dPNlVrbUE2UzJ6N1pSc3dGWjBrZUJIaGI2UWJvVnY2MlZwanZx?=
 =?utf-8?B?S2txM2FiZkRLMTZmQ2RjNVNQblVqOENHZmRHcER1V0Y2QTg2R0wrYUkzTnI2?=
 =?utf-8?B?M0RnTGVYL0QvZy95cU83T3VBQ2VaZStlQ0NJZFBHOW9UVm5MMHgzUWFOS1hS?=
 =?utf-8?B?ZGxvamo1cVhoaC9rSUxpVSsveGZzclUyT0gwU2NoVG95cHpyTFlhM0hrVy8w?=
 =?utf-8?B?Sk00bDVKVXMwU1JnWFpUeStZdmlzRnN6Mk4ycWZYUEZmdkkwREh0MzhrdFRB?=
 =?utf-8?B?d2huaEZVdG16ZFhEK0J6eVhsNVRxSTZ4OGZRbHBrR2RsQ0NIdFZ2NDZRZ3pT?=
 =?utf-8?B?ejZjeHNUTDZIS3kyUGpGL1RicmNYem5xZEs1MHpmb0Z3SU1tQlk0RUZQWnRv?=
 =?utf-8?B?cXRPVUIzcEx5ZlExOXkvMXNSOHN0TEc2MjhZcGdzWllDaFAwa3J6ZUJJenFK?=
 =?utf-8?B?NVcyc1FmSUlvVERiZHo1MCt4eDZyTEJ5YWovQzNvaDdvUEhXMjVSNlg0OGVN?=
 =?utf-8?B?N0lFUEd5R3JqQVRLRk96cUdvMkxta1A4M3ZoenFpWlU5NWpWT1FYbWtkNysw?=
 =?utf-8?B?ZEtGeFhrbWdyaCtGdFVDTXg2Mk9HRHhCeHVNeGFidUk5NExzQ1Q2bkxYcldW?=
 =?utf-8?B?aDlQMUo5WXc3Z0JIbnNzcjRDQXZjNkRlMWZXaktGT1lTc1d4bFQzMVJTODh5?=
 =?utf-8?B?YVBYQ25YSjl5aUdUZnhERzNXRjh1bkt2QzNZeFJ0c0NVWG15ejZoaURBQVBo?=
 =?utf-8?B?TVlROXl5TGpnaVl1cEo5ak9CQk8rcXJ5RmFkc2RVNjZ3WTZIVHBZNHE5UDc0?=
 =?utf-8?B?QXRVN2pGUjUvRmZ4ZlBwME1JazNXZndmb0FnQkI4MXRDeHJZaTFweG1TZ052?=
 =?utf-8?B?WFNrMStwZ2VsWEFZZG1VT1JXVkQvdVRvSm9yRGpKenMvdzlvSG13UDhubXkw?=
 =?utf-8?B?NUpmaEpTR1p1Y0ZwM0xOM0Q4N1F1S0RuVFNqYUFIVmhWd1ZlSzRaWnVKVHB0?=
 =?utf-8?B?ZWhDb29kOUREcTF5akNlblRPTnVKQkd1d3FpbGVtcjhMaWxmWlNUNnBiMGp1?=
 =?utf-8?B?TUxKYlJjMVRWVnByUnJQYXZxcWtBbWo1U3hmcURRLy9NWlhFSDkxNzRDbEY4?=
 =?utf-8?B?akZjaXBzNSsrTno3QVhQYkdJYTV2TFg3TzFtM1lWeHlZeXhqSnI2Z3BGaU92?=
 =?utf-8?B?czBUZ2x2bjg3cUptS1VOYWQxYW5NY3pNNGJOdGV0TmV6bTc0akdjL2lWT213?=
 =?utf-8?B?UGd1ek4rSHUzakRFbkhkTHRnMUk3YWFjRCtQb1VLKzNna1F5WlJyRHhJam5l?=
 =?utf-8?B?QjNUWWpRbDVIdDlZdGNERnVFY0dpbStrejlDOG5EKzFtMU5qR1pvK04xRjkw?=
 =?utf-8?B?M01HL1YxSFpqTkNIZUFxV05zTm9ITlhUZGU5aXZEdm00VDU0bjRvR2dWZ3lw?=
 =?utf-8?B?R2U1d3hsT05DUGc2K0Z0NDNDYVNrTHRoODFQbG8zQ2xPWTZGQWJkdW9BeGp2?=
 =?utf-8?B?L2lRS05IVCs0QnozeXJwRGZ5SVVJMTQxMGxKYllKbnoyN3c5S1orcDd2Snk0?=
 =?utf-8?B?d1ZiSDVRVHBKU1BrNGFBMmZOTzRvR2NocGNSS3BrSlhtUXpDdmJkcUM4YXZJ?=
 =?utf-8?B?MmZ0L01KTXFUQThGb0xtOWIzc3FaenRGcGdJYk1mZkFPUng3Q0FxZ1owSGc3?=
 =?utf-8?B?ZW5HWVBRdTZobVJyeElsOTR4ZXhhOUlTaG50SjNhSlFzWUpMRFo1eWZpMFp5?=
 =?utf-8?B?WURPVUplUnF6VUNEeHltMktuZHhFeEgwOWNqc1JlVkZFNnhTakluT2FIb2c0?=
 =?utf-8?B?ek1PMlF4UWxySFFpREE0UWlzSnpiNGdLNFhBb2N5ZWlXbDRoSWh4V2ZuMngy?=
 =?utf-8?B?cTZSSU96Zzh2Y05VU3F0REg3d3FMdXdjNzlDWmNJOERzR0VoVEZHc0QwS3hm?=
 =?utf-8?B?Vm5LRG5Gb1VmR0dXWVFMZ2hJcUFnRGhEQXFPR2JNdDhXRVAwRWhlVlk2aVdW?=
 =?utf-8?Q?XLqV6K6nSSV2Yi2Tgws3p5bhD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5c4421-dd93-4936-a8e9-08dc48ebe853
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 14:42:03.1963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYONvI+mmh4ty7+5kEsmKVDrlewtH2mhKcX95LUP+tNtjlwTtvkWDg6ZvluLNXZ8Zp8mUciI/AikfBGtEbJntQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6849
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgUC4gQmVycmFuZ8Op
IDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDIwLCAyMDI0
IDY6MzEgUE0NCj4gVG86IExpdSwgWXVhbjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+DQo+IENjOiBw
ZXRlcnhAcmVkaGF0LmNvbTsgZmFyb3Nhc0BzdXNlLmRlOyBxZW11LWRldmVsQG5vbmdudS5vcmc7
DQo+IGhhby54aWFuZ0BieXRlZGFuY2UuY29tOyBicnlhbi56aGFuZ0BieXRlZGFuY2UuY29tOyBa
b3UsIE5hbmhhaQ0KPiA8bmFuaGFpLnpvdUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjUgMy83XSBjb25maWd1cmU6IGFkZCAtLWVuYWJsZS1xcGwgYnVpbGQgb3B0aW9uDQo+IA0K
PiBPbiBXZWQsIE1hciAyMCwgMjAyNCBhdCAxMjo0NToyM0FNICswODAwLCBZdWFuIExpdSB3cm90
ZToNCj4gPiBhZGQgLS1lbmFibGUtcXBsIGFuZCAtLWRpc2FibGUtcXBsIG9wdGlvbnMgdG8gZW5h
YmxlIGFuZCBkaXNhYmxlDQo+ID4gdGhlIFFQTCBjb21wcmVzc2lvbiBtZXRob2QgZm9yIG11bHRp
ZmQgbWlncmF0aW9uLg0KPiA+DQo+ID4gdGhlIFF1ZXJ5IFByb2Nlc3NpbmcgTGlicmFyeSAoUVBM
KSBpcyBhbiBvcGVuLXNvdXJjZSBsaWJyYXJ5DQo+ID4gdGhhdCBzdXBwb3J0cyBkYXRhIGNvbXBy
ZXNzaW9uIGFuZCBkZWNvbXByZXNzaW9uIGZlYXR1cmVzLg0KPiA+DQo+ID4gVGhlIFFQTCBjb21w
cmVzc2lvbiBpcyBiYXNlZCBvbiB0aGUgZGVmbGF0ZSBjb21wcmVzc2lvbiBhbGdvcml0aG0NCj4g
PiBhbmQgdXNlIEludGVsIEluLU1lbW9yeSBBbmFseXRpY3MgQWNjZWxlcmF0b3IoSUFBKSBoYXJk
d2FyZSBmb3INCj4gPiBjb21wcmVzc2lvbiBhbmQgZGVjb21wcmVzc2lvbiBhY2NlbGVyYXRpb24u
DQo+ID4NCj4gPiBQbGVhc2UgcmVmZXIgdG8gdGhlIGZvbGxvd2luZyBmb3IgbW9yZSBpbmZvcm1h
dGlvbiBhYm91dCBRUEwNCj4gPg0KPiBodHRwczovL2ludGVsLmdpdGh1Yi5pby9xcGwvZG9jdW1l
bnRhdGlvbi9pbnRyb2R1Y3Rpb25fZG9jcy9pbnRyb2R1Y3Rpb24uaA0KPiB0bWwNCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFl1YW4gTGl1IDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBOYW5oYWkgWm91IDxuYW5oYWkuem91QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAg
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgfCAxNiArKysrKysrKysrKysrKysrDQo+ID4g
IG1lc29uX29wdGlvbnMudHh0ICAgICAgICAgICAgIHwgIDIgKysNCj4gPiAgc2NyaXB0cy9tZXNv
bi1idWlsZG9wdGlvbnMuc2ggfCAgMyArKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWls
ZA0KPiA+IGluZGV4IGIzNzUyNDhhNzYuLmJlZTdkY2Q1M2IgMTAwNjQ0DQo+ID4gLS0tIGEvbWVz
b24uYnVpbGQNCj4gPiArKysgYi9tZXNvbi5idWlsZA0KPiA+IEBAIC0xMjAwLDYgKzEyMDAsMjAg
QEAgaWYgbm90IGdldF9vcHRpb24oJ3pzdGQnKS5hdXRvKCkgb3IgaGF2ZV9ibG9jaw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgIHJlcXVpcmVkOiBnZXRfb3B0aW9uKCd6c3RkJyksDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgbWV0aG9kOiAncGtnLWNvbmZpZycpDQo+ID4gIGVuZGlmDQo+ID4g
K3FwbCA9IG5vdF9mb3VuZA0KPiA+ICtpZiBub3QgZ2V0X29wdGlvbigncXBsJykuYXV0bygpDQo+
ID4gKyAgbGlicXBsID0gY2MuZmluZF9saWJyYXJ5KCdxcGwnLCByZXF1aXJlZDogZmFsc2UpDQo+
ID4gKyAgaWYgbm90IGxpYnFwbC5mb3VuZCgpDQo+ID4gKyAgICBlcnJvcignbGlicXBsIG5vdCBm
b3VuZCwgcGxlYXNlIGluc3RhbGwgaXQgZnJvbSAnICsNCj4gPiArDQo+ICdodHRwczovL2ludGVs
LmdpdGh1Yi5pby9xcGwvZG9jdW1lbnRhdGlvbi9nZXRfc3RhcnRlZF9kb2NzL2luc3RhbGxhdGlv
bi5oDQo+IHRtbCcpDQo+ID4gKyAgZW5kaWYNCj4gPiArICBsaWJhY2NlbCA9IGRlcGVuZGVuY3ko
J2xpYmFjY2VsLWNvbmZpZycsIHZlcnNpb246ICc+PTQuMC4wJywNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgcmVxdWlyZWQ6IHRydWUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
IG1ldGhvZDogJ3BrZy1jb25maWcnKQ0KPiA+ICsgIHFwbCA9IGRlY2xhcmVfZGVwZW5kZW5jeShk
ZXBlbmRlbmNpZXM6IFtsaWJxcGwsIGxpYmFjY2VsLA0KPiA+ICsgICAgICAgIGNjLmZpbmRfbGli
cmFyeSgnZGwnLCByZXF1aXJlZDogZ2V0X29wdGlvbigncXBsJykpXSwNCj4gPiArICAgICAgICBs
aW5rX2FyZ3M6IFsnLWxzdGRjKysnXSkNCj4gPiArZW5kaWYNCj4gDQo+IEFyZSBlaXRoZXIgb2Yg
dGhlc2UgbGlicmFyaWVzIHByZXNlbnQgaW4gYW55IG1haW5zdHJlYW0gTGludXgNCj4gZGlzdHJv
ID8gSWYgbm90LCB0aGVuIHRoaXMgZmVhdHVyZSB3aWxsIG5vdCBnZXQgYW55IENJIGJ1aWxkDQo+
IGNvdmVyYWdlIGZyb20gUUVNVS4NCj4gDQo+IE5lZWRpbmcgdG8gbWFudWFsbHkgYWRkICctbHN0
ZGMrKycgJiAnLWxkbCcgaXMgcHJlc3VtYWJseSBhDQo+IHJlcXVpcmVtZW50IGZyb20gJ3FwbCcu
IEFzIGEgZnV0dXJlIGVuaGFuY2VtZW50IGl0IHdvdWxkIGJlDQo+IG11Y2ggYmV0dGVyIGlmICdx
cGwnIHByb3ZpZGVkIGEgcGtnLWNvbmZpZyBmaWxlLCBzbyB0aGlzDQo+IGxpc3Qgb2YgZGVwZW5k
ZW5jaWVzIGRpZG4ndCBoYXZlIHRvIGJlIGhhcmRjb2RlZCBieSBhcHBzDQo+IHVzaW5nIHFwbA0K
PiANCj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQoNCkhpIERhbmllbA0KDQpUaGFua3Mg
Zm9yIHlvdXIgY29tbWVudHMsIHRoZSBRUEwgaGFzIG5vdCBiZWVuIGludGVncmF0ZWQgaW50byAN
Cm1haW5zdHJlYW0gTGludXggZGlzdHJvIHlldCwgSSBhbSBhY3RpdmVseSBwcm9tb3RpbmcgUVBM
IHRvIA0Kc3VwcG9ydCBwa2ctY29uZmlnIGZpbGUgYW5kIGludGVncmF0ZSBpdCBpbnRvIHRoZSBk
aXN0cmlidXRpb25zLg0KDQpUaGUgUVBMIHdpbGwgc3VwcG9ydCB0aGVzZSBzb29uLCBJIHdpbGwg
dXNlIHBrZy1jb25maWcgaW4gdGhlIG5leHQgDQp2ZXJzaW9uIHRvIHNvbHZlIHRoZSBRUEwgYnVp
bGQgZGVwZW5kZW5jeSBpc3N1ZS4NCg==

