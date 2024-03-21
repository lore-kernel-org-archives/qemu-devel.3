Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16524C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 07:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnCQs-0006Fh-Ib; Thu, 21 Mar 2024 03:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnCQo-0006FN-3z
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 03:01:42 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnCQm-0007HG-37
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 03:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711004500; x=1742540500;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rpO8eagrkuLJANMzcJSM7qrbgcwTsAWwcF8b8KI5Zz0=;
 b=Wd1rELe1LeySn00eYgIJlYUUhr9hyNhmifsGaagCTEWLrRaZSCx/hMiL
 714X8PxsQaLA1Y8wrT2Hp1CpjhSVD+28xBJ3R4mcie9aJmJiy7qIvAWej
 KoFt4s+brgISiSV2lBSzCh5T3NtpItrH9Z9lFihzG+HJQ+hM3vGRg3MP/
 sUmzCcdt50Lfsm3dp/ZU4uvjlKfO0ZqFJT/Cpi5TXqhefhkYo6stdHuDS
 oYxH/SoDfG5hSXuNUBJA5iJ8ymrr8O0qoScsW9np6JgfiOb4lbTfr/Oac
 U7kkNE3qGfVFbFebf2O1Q2tJFF9rsUQI8Ici+bhb3unZMhjf4dlsbG1hI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="31409057"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; d="scan'208";a="31409057"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2024 00:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; d="scan'208";a="18881877"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Mar 2024 00:01:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 00:01:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 00:01:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 00:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDQTXZkaUHLtZqkla1zNShfXM4zt/lZGI9Yrg6syqJy1o4J3IbFjWcFcs/GL9nI7uag0K/DG3vRF4aBzUUIjP1YkyCjWWGS7v5c731/npLvxiJtB12sEwk3cnzXRf4k1pKkp3Byo0J30c9XNR325b0QDVnOuXusyeGdnE+e7k/AcwC6CN3znprBJgmYkYyV6AzynvhdONGuFbAgN39SBBw9ufn70iLgZ8Wyi6+9Gelk/Qd/6ZCrFrP86mNYCNDK9VcYKl+9xOwFOdITDzRhf0aJl25urLJntVJQ1cuGeyc3r2vyppPamlTF3OIh2xThB6BQHVAQvdww+afo1EqgqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpO8eagrkuLJANMzcJSM7qrbgcwTsAWwcF8b8KI5Zz0=;
 b=Dc7hE8oy2tYuRyrkRNdW9sca37v2l7X7LUxOfrfnk6tN7YyCWJ7DqLlHsIqny4qmeKOja1kPi8kYoXZMeI9AhmmJBsGyF9Zy4IXlJ72r1cKxVoBLXa3wcAfnjWoGk0RviNGqr12PWkDdDyoT/MLVVPTvjx5ZuoJPXkQo7zfw4vj19Jo6548zU4/fxrUw9m/ycfdg93bbRjiivgFnVSLyT/mKXvwMpxvYNyslPJFExsAZ4D839xdWe8W33jCE+t4RGiornYDatimKKqDsNWaFBpYrcfjXyja7tDjW1eOMvx5byuBNocWwrS2XytPYfiVLsGtKXo4rf1c8sopPFdwggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by DS0PR11MB6470.namprd11.prod.outlook.com (2603:10b6:8:c2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.23; Thu, 21 Mar 2024 07:01:32 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 07:01:31 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Subject: RE: [PATCH 0/3] ui/console: initialize QemuDmaBuf in ui/console
Thread-Topic: [PATCH 0/3] ui/console: initialize QemuDmaBuf in ui/console
Thread-Index: AQHaewic2fK1XLm69ky4EVwyQAqJALFBw+IAgAAAuwA=
Date: Thu, 21 Mar 2024 07:01:31 +0000
Message-ID: <PH8PR11MB687990BDC78BD650F5FDA391FA322@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240320205018.3351984-1-dongwon.kim@intel.com>
 <9617e174-1aef-4caf-9f15-2ce3c455527c@linaro.org>
In-Reply-To: <9617e174-1aef-4caf-9f15-2ce3c455527c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|DS0PR11MB6470:EE_
x-ms-office365-filtering-correlation-id: 75cb7db5-35c5-4dad-9c8d-08dc4974bcef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zds0nQOwkQa8Esr4i190Bhp1nfNvDpNOHsCzStf9oGug7I12xzQrxoDHyV0yIpQfeAWF6hahdaNzXV0Lut3lQ1FNzle3j83T1MTUCLcbHgVZ8AZ57MZHoUpUb4RxvaYQnEosFo5ikP+GmeQW17aLS7LzMZiLf2HybWlBRJCMNL4aZH8IAQhiFfM6XRM6rdo9o0Gt6wtv3FVwjPd4+06TDbvL03R/6dd7FtIofkwLt3W3sUHlx36IDka+jdFxMRekf7MOTrf5bafcB3ceO0ZqQY/xQrnUMjGNWB4AsGfI5nJLwf/t4IJdLCWkmO82x6gl33E9/6VaE59XkddwTQ8q00LvwyTTHaaVWdHDNnGw3S026TuTX8QpeWqPIa7envLgiYTuX6wRzYGnPRjjMyVXZmG8QNb2r6ojhKcg/5ZFTfvBcdT6b0Nl8jMQCTS0CQaz8e69JKtPVeT081Dw5A5b5p+o+uhGB0bTVHnTApkgdibzaMH9rPqFhjuMvQq9OsG5jXwE5arbO+BNHyWOzwlJYbMTmmdz9G5/o+9MHWGrOQXMge7ZwLJlpYLOhc70SKxrLLU1m6mCZ0USO70Z1l6GJDEi3duZ7I7djfdLPWwTH2QDZgmLPkEu9eyhH1rI45YDwMc2IpJ7OKc9dIEpryQt7A4uOFS6soZVSV/LNsixOVRPO6Ofk8j83JEoPea0RO/teA5sSrGzhQvDfvkq+nN/9EAL84XpywQXB6u7tMHoKEo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1BOeFB4WWlwWHQ3Y0d1b01Bd2RRbWR3TXVjaitEV1BZQjRWR09hRjJwWWRZ?=
 =?utf-8?B?TUw5RVI5TzNxR0tmTWs4QmVQTllwVkt4RTAvbW0vUmpmY3kxNGZzTFFxZ25V?=
 =?utf-8?B?MmNJRXRHY0V0SndLV2JsMmR5TmY0eVFtRGRaS0pRZDRGa2JXV2oweHJ0dFpo?=
 =?utf-8?B?cFFRb3Fja1dQdVBoN2hXSUJlYU5nU2o2NjFMa0cvbXN4eUpxM2ZUNm9rZ3Fa?=
 =?utf-8?B?Ui9XRkkyWFgyMHd4MEJnL3ppYll0WFRnWnJyZU1BQXBUNDNrcXNKaGJRdmhh?=
 =?utf-8?B?VDc3L1NFMm1RaUFyNTNWYzk4dXRuSGROK0l5bklnOHhZTHM2WmltOVUvamlh?=
 =?utf-8?B?TFRBUnFHbGNtSVZkWFhEL0hvTVo5SnVtbEd2NjJMZG16TmZ6RVRLVmhGTGwr?=
 =?utf-8?B?YTRrNGxNSk5oem9vU05yQmY0WnVaTjQ1M0hlN0ZMbk9MTmhVaTc3WlgvV2hC?=
 =?utf-8?B?K3ZlVWhwUXExUm15TWl3MzdQSDB5TkVGeDRQM052Z1lwV0k0K0I5NWFJZElx?=
 =?utf-8?B?NFFvVkh0UExLWlp0RU9RYlJwUG5aZE9GdzRZY0VVb2NkTld5Uis4TEt1NnZr?=
 =?utf-8?B?T1lHUmU4VDc1ektVaUVuQTJzMkJnMXN1ZG5mRnlJR3dBRmM1OWtmekdyNC9p?=
 =?utf-8?B?YUlsbU5XQ2M3a2lJM1N2TUpBVWloYnh1cmNJWUhkTWpLbTJJeDVDYVNzTUs4?=
 =?utf-8?B?K1l0R0RJUGxiZkRMOXlINWlCZVB3SW1RVTdrakNEcVFhR0l0SDl5NFUza1Rn?=
 =?utf-8?B?aDVlNndSblArZkVCd0gwSktWM0YwSktKd1pxQy9oZWcyWjVZOXZkWW0yaXRD?=
 =?utf-8?B?R3BrRXEyNHhRK2tCbUtPN3Zqa2JSZWR0LzI4Z3Q3SUFDeUY4K3k4U0ExbVdv?=
 =?utf-8?B?akFkUmVucjdsRzhISmNkQVBuSElWbUpZOUt0WWlnQk5RbHRidmVKQ21iWjV0?=
 =?utf-8?B?ZmVNZ01CaSs2T3RTVys2MHlpZkdKM0MvMHRtaDhBN3hxTjIzNnNKd3M0S2RO?=
 =?utf-8?B?OEV1V0docFlNZFBsR1hzWEM3SjloTE91aUh4Z1hxWllGakpXRkRZQ2pveDB1?=
 =?utf-8?B?WDVpWnRmaWs2emdjWFdKa3orUFUvbW1CMGtyMVBYQitOS2h3TkttaFpobXFU?=
 =?utf-8?B?cGVHRFhXRkF0QWVDOEtPdjlVNkNmem5MazlIVEFyMFNZSUE4WGRDS2t6MDdh?=
 =?utf-8?B?TW1mT2JRVjJwSjNnMHhEQnBpMzZxRFZPaCtyNHdVemlDVXBlbTUzNFRtWS80?=
 =?utf-8?B?RTdyNUlXVjVOaGVEMlAvaXFJS1NMQnlpQWlxWEp3UlJCVGhiUzh3V25nbXN3?=
 =?utf-8?B?MzgyVXZCeUhlWW1mNVVnKzVybDgwKzYwdm1ZQTRjSDZENGpxb1lWWStBYTFL?=
 =?utf-8?B?R3pTSi9BQmYxRHJaMk1ZVTZ1ZkdReFRraTBOdXB6Q2VBSGIzT1VGbjJ2b21J?=
 =?utf-8?B?Q05iY1VPL2tETG16QkYxNW51SkJlYTRSQVJHM3lkYW9kQW5yVDNIUmhZZlBZ?=
 =?utf-8?B?MVpnQ1hwTTBVSUdzeDJicXhscHA2Q3Q2UnJjMFR4THFRRUpuanQzaWs0SWor?=
 =?utf-8?B?RlNxRjg4YkpZV2Jyb1ozSHJ0KzdnZStnSzN3Z1RzQ0xmWlBtVWRrVlkvakJL?=
 =?utf-8?B?c2crRVdLWUNGci94ZTBjTmN5Tlo4d3ZtZjRYcDZxSnhqemw0RTJzbjJNcnQr?=
 =?utf-8?B?TGNpUllIWXk4dzdzUEdwMURLNWlPbk1aNzQ2L2RRanpVNnlKYlY0QzlsV2tp?=
 =?utf-8?B?aTYwbHFvbmcwZ2Jad3ZmVXRqZzQ0a0NUUG8wWFlDKzJaZ1lCL085OGUzSVZC?=
 =?utf-8?B?bEdYRFhwN21sN09HeXVFTXFqTHlOaWNkcGFWSGFFblhZOENJWVIzQ3NUV0dM?=
 =?utf-8?B?aXl3KzNSdXYxN3Jiei9ZTFJnSlBKQnJlb2xJNWJsTEkvQklyT3FnRHBEVC9K?=
 =?utf-8?B?eEhHbHExblFpS0dtSE02KzRMTW1WVi92dzJrOHN4M3JxS2dzQW9YM1JuU01r?=
 =?utf-8?B?dEJ0ZFVZdkhDV3NYaGpHY29tQ3VBdTd1U3hiME1jcVpsNndOVlpDWDcvcy9s?=
 =?utf-8?B?WHdmTUtkb1Q4UXRIcmVQK2V2b1p0MkV1THAxT0tTTWNWN2MyVnJiWU5Udk1Z?=
 =?utf-8?Q?0QknfSw0DWekas8T/Mc98Xjjr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cb7db5-35c5-4dad-9c8d-08dc4974bcef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 07:01:31.4540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CemMEBYYtTlZ+HPXUQTVK9laLTmedAoDoIsuMc60q3HkcQ9zvm/kg9TFk2hnoxe7xq5Ae/jVUsA20s4tJQQ38g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6470
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=dongwon.kim@intel.com;
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

SGkgUGhsaXBwZSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgTWFyY2ggMjAsIDIwMjQgMTE6NTcgUE0NCj4gVG86IEtpbSwgRG9uZ3dvbiA8ZG9uZ3dvbi5r
aW1AaW50ZWwuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBtYXJjYW5kcmUubHVy
ZWF1QHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzNdIHVpL2NvbnNvbGU6IGlu
aXRpYWxpemUgUWVtdURtYUJ1ZiBpbiB1aS9jb25zb2xlDQo+IA0KPiBIaSBEb25nd29uLA0KPiAN
Cj4gT24gMjAvMy8yNCAyMTo1MCwgZG9uZ3dvbi5raW1AaW50ZWwuY29tIHdyb3RlOg0KPiA+IEZy
b206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+ID4NCj4gPiBRZW11RG1h
QnVmIHN0cnVjdCBpcyBkZWZpbmVkIGFuZCBwcmltYXJpbHkgdXNlZCBieSB1aS9jb25zb2xlL2ds
IHNvIGl0DQo+ID4gaXMgYmV0dGVyIHRvIGhhbmRsZSBpdHMgY3JlYXRpb24sIGluaXRpYWxpemF0
aW9uIGFuZCBhY2Nlc3Mgd2l0aGluDQo+ID4gdWkvY29uc29sZSByYXRoZXIgdGhhbiB3aXRoaW4g
aHcgbW9kdWxlcyBzdWNoIGFzIGh3L2Rpc3BsYXkvdmlydGlvLWdwdQ0KPiA+IGFuZCBody92Zmlv
L2Rpc3BsYXkuDQo+ID4NCj4gPiBUbyBhY2hpZXZlIHRoaXMsIG5ldyBtZXRob2RzIGZvciBhbGxv
Y2F0aW5nLCBpbml0aWFsaXppbmcgdGhlIHN0cnVjdCwNCj4gPiBhbmQgYWNjZXNzaW5nIGNlcnRh
aW4gZmllbGRzIG5lY2Vzc2FyeSBmb3IgaGFyZHdhcmUgbW9kdWxlcyBoYXZlIGJlZW4NCj4gPiBp
bnRyb2R1Y2VkIGluIHVpL2NvbnNvbGUuYy4NCj4gPiAoM3JkIHBhdGNoKQ0KPiA+DQo+ID4gRnVy
dGhlcm1vcmUsIG1vZGlmaWNhdGlvbnMgaGF2ZSBiZWVuIG1hZGUgdG8gaHcvZGlzcGxheS92aXJ0
aW8tZ3B1IGFuZA0KPiA+IGh3L3ZmaW8vZGlzcGxheSB0byB1dGlsaXplIHRoZXNlIG5ldyBtZXRo
b2RzIGluc3RlYWQgb2Ygc2V0dGluZyB1cCB0aGUNCj4gPiBzdHJ1Y3QgaW5kZXBlbmRlbnRseS4N
Cj4gPiAoMXN0IGFuZCAybmQgcGF0Y2hlcykNCj4gDQo+IFRoYW5rcyBmb3Igc3BsaXR0aW5nLCB1
bmZvcnR1bmF0ZWx5IHRoZSBzZXJpZXMgaXNuJ3QgYnVpbGRhYmxlIC8gYmlzZWN0YWJsZSBzaW5j
ZSB0aGUNCj4gbWV0aG9kcyB1c2UgaW4gcGF0Y2hlcyAxJjIgYXJlIG9ubHkgaW50cm9kdWNlZCBp
biBwYXRjaCAzIDovDQpbS2ltLCBEb25nd29uXSAgTWF5YmUgY2hhbmdpbmcgb3JkZXIgb2YgcGF0
Y2hlcyBsaWtlIDMtMS0yIHdvdWxkIGJlIGFjY2VwdGFibGU/DQoNCj4gDQo+ID4gRG9uZ3dvbiBL
aW0gKDMpOg0KPiA+ICAgIGh3L3ZpcnRpbzogaW50aWFsaXplIFFlbXVEbWFCdWYgdXNpbmcgdGhl
IGZ1bmN0aW9uIGZyb20gdWkvY29uc29sZQ0KPiA+ICAgIGh3L3ZmaW86IGludGlhbGl6ZSBRZW11
RG1hQnVmIHVzaW5nIHRoZSBmdW5jdGlvbiBmcm9tIHVpL2NvbnNvbGUNCj4gPiAgICB1aS9jb25z
b2xlOiBhZGQgbWV0aG9kcyBmb3IgYWxsb2NhdGluZywgaW50aWFsaXppbmcgYW5kIGFjY2Vzc2lu
Zw0KPiA+ICAgICAgUWVtdURtYUJ1Zg0KDQo=

