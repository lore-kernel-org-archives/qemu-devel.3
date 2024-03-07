Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B71C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHwH-0007WL-1i; Thu, 07 Mar 2024 12:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1riHwD-0007V2-Rg
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:53:50 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1riHwA-0007AE-1v
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709834026; x=1741370026;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PTU/bxHiN7qOQUmnu3BeiiPMvsTGsbQeKNo0D6hb9sg=;
 b=MCChmAF8V5E20tEoOaFqh7p29BJbUzZe08A7rvDpCCgXkO6b2R5dfbvJ
 aQNvMPKPhCdGJrZKICVp21MwZ4CHEgSuAX4fXD6XUyjNaE6ASuZio7RHQ
 6DY7EsaBZdC9F+oHkStsdR/lNFmGN5jVvasShxToPXWVxdGp53S4dXunN
 5/cjeH5uRO01V5wW1nEEQRwUanWwY5LicrHDLtCdZTrQfCoS/7EaxBYtQ
 /2eW4nfouDNsB+8yft2JZcDGvVIha7pPSCZFncoxwce342bwN8xK9ca5e
 lLyP61aU5HJcpIQh7R0NHdbT9xfiRT38ywcZI+aQnzlVLFL0QQdYu8zYN A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4367104"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4367104"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 09:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; d="scan'208";a="14776192"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Mar 2024 09:53:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 09:53:30 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 09:53:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 09:53:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:53:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK+cxSu79e623DRJZETYQsSP6ti3pMfXGFXF6kzYxsLYRjvnZXl7Sc/6TcjDmJLJ4vteHUfnaNf9Jpp+dxbXkmdUDJRizJeFkwguyVhkTuX9rG0HaKj7voqkWE9T5ZpHM7Hlxh1yhbiLqavp6Th/zaNapAHf0DbBhkUSdoYG0eZykO5muSMn7ywyDjDUqEUcKLUYEOtiDQ6UV6Qnqri9trpPaBwhu2ADWnVeakcZQNRE20XGyK9xCsi9DSukAIid0Ehpu+G29QUxbYTp18JoyCLM9a95QGiIbNh/1tqUBKMxzH9A99iktSfhG0P3LYJzeJSHA+QCsNeasGdHq8JKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTU/bxHiN7qOQUmnu3BeiiPMvsTGsbQeKNo0D6hb9sg=;
 b=daRhhqaZnfb/f6nNUpkaym2De3A/nmRKyghvkvUYemK9oqlZGpzX2748XMx1sptfn5NmqIo0I6ufrSKeKOKeX9Mvte2KT895bhMXfYSlF4FABo02B/74JdrpkT/N5iaUiwP7CXFcH7IVXVWoX/Wv1v2Lj0zG5tP/r8QFyk2UCTWVOY3C5zkCMsnIryecwyyoPp1cNUoNsWrVU0isF29P4KeBMO3Tywj50DhO9Q/8eo1nKbqWth7e9f+ZdlctLXMIbHiB0a4Lblq1GkoboEWMFCXTcSt7oKriJDxZyyH27OcxdWW9oytuYWEJvYE3EKk3nY7daKsDic8PU2xnYckedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.9; Thu, 7 Mar 2024 17:53:25 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 17:53:25 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated VC
 is invisible
Thread-Topic: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated
 VC is invisible
Thread-Index: AQHaU9fcRg8sk5PypUazkJHR2gMsqbDzgQeAgADEP6CAAMa/gIAAyKaAgDZsN4CAAILtEA==
Date: Thu, 7 Mar 2024 17:53:24 +0000
Message-ID: <PH8PR11MB6879A43FEDABBD1307861429FA202@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-2-dongwon.kim@intel.com>
 <CAJ+F1CLzVDfCdy9XUGxAf1DN=ert+9JDs3Sq1HYve4Bdy7mFHw@mail.gmail.com>
 <PH8PR11MB6879524941306A7B3FB17EE2FA7C2@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAJ+F1C+4f7=GAa8gOhH+=Qv5WAQrypa=83R-+RVEAo4JjknLSw@mail.gmail.com>
 <PH8PR11MB6879AF46B1B0A31E68D146F9FA432@PH8PR11MB6879.namprd11.prod.outlook.com>
 <ZemM45aJdtzx9LH2@redhat.com>
In-Reply-To: <ZemM45aJdtzx9LH2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|DS7PR11MB6039:EE_
x-ms-office365-filtering-correlation-id: fd88d79a-00b3-42c6-c6fd-08dc3ecf7ccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VlwJaskReS2ha8IiXkCZbOcJNRH1OplBe7SB8eUUSZNOsy3po8ehSHgHL9t8ZaEWa7cK+LDht8J10GjtBHZoCW0WrOLF1M5Z2RJTL+/B3RsvzD3aRQgN+B2dUarmybROA/ziMkuNuGOVxtc8AeWKck4/bZZub9rPOadlgGnctU5F2qOkVFj2G/Uz4HTz2WfKeJSdow/DvusmX1HVETBwngFY8cK3F5Y0sQMWjzBVuwYbeBAxIGDUNytcVuHRrOuyJ8LI5fAGN1QKaDXOdC11laLG4xO8Y/ZcQin8lHp5edZF4GYHa9jowQHsemksMBYCcb3MSzLU+TOgx8tNXONctQqtx+FXv+w3L6OBU8TF3HO2WUXaze/Zqnp0M8uBYmiB+aoBHKWYCKUYi07XX/w+3OACZ96RJc+1lfPb7SOgjqRpV5YZAmbKJjhk9pU+97OqFdBauLWY+Uhz7ZcPLtti1on71wjEkouIlN20O/u1rpeB6rQzFC+Dyj3iqqWB0WPykVyRgGOxyn8NkNmUmhzEc2Vkp8ePrKKvyXy93yEM6ahDtMl9l/eLAhjqRJAGqo8/DXkPRcQ3xLnqeT1ZpBxezct9rDABEna613XmCBePkZkxitF+f1f2fyEr4UuTonP7bHUUcD5b0iKroDxB6/4sn4LwUZnKAi5ur9dJB4Oe7n6FopuTEcPpuXUxRP3nCzcq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXZEdWs4VXR6aXVjbXdVM1ZaNFRaOEtZbXVzcktXQ1FxRVlScU5BZmd3NW5E?=
 =?utf-8?B?MlQ0Ulo2Qk1sOThKSkZoaEhKc1ZvS2pkRnhFQXFMQkhLSmJQaVkwY0wyMDMw?=
 =?utf-8?B?Q0dkamdyR0ZsVTQwanJ1bDRDMHV2YU94MVU5YTcycHFuOFFEcEh3dU9LS0FU?=
 =?utf-8?B?MHBBS2xqYUdrVjRVN2piRHB4MjN3Q0h1bmJBNmF3WHplYnVDZ2dJTk43WVow?=
 =?utf-8?B?VURKam1neXAxY0psdlE4dTZSVkdzNVg5TnhrU1M2M1A1Y1lhNUduUE9hT2Mx?=
 =?utf-8?B?Mnl1c1JWK2hhSVhYWnNOOFk5Y3YzR28xY3IxMHN2SktZdkFsUklhY0ZLZ2w0?=
 =?utf-8?B?OUI0WVRSUUxUeFErN3ZES2Z4U0ZkSFFxc1R4RHB6S0pKWWVOdjBTREVHQmg5?=
 =?utf-8?B?VXlTbmxLUk9xVmJKR0VDQmUzTEZ6TWZWcmJDYWZhUWNaUzh5TEtDRHdUSjlZ?=
 =?utf-8?B?YmhTTXFqM3FvbCtkOWZnRGQvdHJUMmxOZlZVR2tOSWQ2dmtrck5kQnM3T0ho?=
 =?utf-8?B?bko4SXRYSDZzTDBVWjNFSUU5Q0h3THYvY3I5M3ZtZW92L2ZydmlXMVByVitJ?=
 =?utf-8?B?clRWUjMxcGFoMFRYRGNjaURkNXlsVTJiVEFQeEl5dVlLWi85ZGNPV3lGQkxp?=
 =?utf-8?B?M3kvWHkzQnZKRnBRai8zQkx4dEo2NnJpZWEvMEt5eTYyWktEOWNxRFluMENr?=
 =?utf-8?B?R3dVS2Qxelo0NHF0SFBIL0o5NExYanhQeGNXdEVLSjdjVHJvZFYzZDE0Z05l?=
 =?utf-8?B?dEI5SXoxRkVEREJEV3RxYnZnNzJCRnZjZmZGSTl1OXd0MmVsbVI2UitvM0gr?=
 =?utf-8?B?SjRiSVJxREsrUDVFU1RSUnRvYk42ZEJYK0I4WVQ3U01TclBJdkJuUHlveEUx?=
 =?utf-8?B?bWdycDcxeEtoekNyemN2YzhPQ2pLaG5vd2hYdDd6WldCUXcyTWRqL1pyU3pv?=
 =?utf-8?B?RFhQZ2VWNkovL0NVTlFCa0REZUNYS05ONGxMZWI3RXp3OVFNWkFkZFN3b1ZL?=
 =?utf-8?B?NXFFSmNtWHlpTnpQUDhnL1VSaG91TDJncVVMSGFWVVBCU3BKc1U5QW12M2xQ?=
 =?utf-8?B?czRZd1plRkN1UmdjY2NmQmh0bVdIRU1yNkdNWWw1ZGxkejlsd0FvbFdlb1hy?=
 =?utf-8?B?NmtnOXZpU0tJaUlKazVncGgyRzN3T0JBcnlOQ3lkRFRXa21kNUo2MjRMQVp6?=
 =?utf-8?B?NHNUV0JZMWpYYzhCM2hrbzJXS2dPSzg0bk5RNDg3R0tRbDA2WERTUjQ1WkJ3?=
 =?utf-8?B?cFJZUU1pMWZISlhYSCs5UUtvZ2hsYndOc3dnbXRhNU5QdXlSQ0lPcEsyZDF4?=
 =?utf-8?B?a1phanczY3p3T2I1L1JRMkJWK21LZVU0eHdPelUra2pYb2hQcGVLRXpBbDEx?=
 =?utf-8?B?NG1YaUlwUTFsYzVpdEx1bTZJdCtMbE9RRXhnZkhUc2w5VlFCL3ZGZUR2b0NV?=
 =?utf-8?B?RDc5MmdoUkNYUzR1VGZRbDZ1bmF2K0F1WEpHZUtndE5VWVB5SzFud3A1bUZz?=
 =?utf-8?B?WjlzNGIxQjRFQ3FLcTdXUVpFWmNPQ1Fpc2t2QXluTjY2NER2RWh4aVhNSHNC?=
 =?utf-8?B?VWxxd0U2Tm4zcUpUUjF0RUlOWUdIdG1Laysxbm9iR1plNUoyelNvN3lha1h2?=
 =?utf-8?B?ZC95UTZqdXE2K05vRTV4K1hiNGdvL1VoV0VqYW9VSlNQTFF5ZzZMUWJHM3o0?=
 =?utf-8?B?MkROd2k4UU8rWGlKUGxwa1A1Rm9NU0ZxalRmdGZxdU5BMlBYUzNlZXdmNkJK?=
 =?utf-8?B?OEtZU0pBNG1MZlA1c2xaa1VqY0hNZkRySlhPM2lJdWE3VGJzK1c5Sk9YZWZ3?=
 =?utf-8?B?L0kzcDNBQWlxVWRRa0xmaWdvMEdSOEQ2Y29HeC9WbWVvcE5zUUR4WmhXNUpW?=
 =?utf-8?B?SkxBOUFIOHhBVFRPaFIzVVV4dm5TeXd1SHo5UU8vVDJRcDBkdlFGN3BaOFVs?=
 =?utf-8?B?UU45UFJGR0NrSU9KeVFnR0ttTDh1eGlaRm1GZTFiSmt5OUZ5aEkzM0VZRzVr?=
 =?utf-8?B?N0M5bmI0cStkRjJpTTF4dHNZRTZkM3Q2K1JNKzZUQlRqdFcyNVA0QW1uZUtD?=
 =?utf-8?B?WWNwenoxT3FYNXFEemJsc29NcXZVZEQzdHhuc1JIOU9EUVpYSGV4bUNXNUt1?=
 =?utf-8?Q?SknMTDwDpMwm5RgqbO+Ez06l9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd88d79a-00b3-42c6-c6fd-08dc3ecf7ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 17:53:25.0087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZhBbjCjDjCxl+TdSss73QMOr0fy4x2TkouPEWjmX/ZmF2tYEQqOlr6cg9J8a+X8tHpLYWSmQvYtGmSzJw2X6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6039
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCA3LCAyMDI0IDE6NDYgQU0NCj4gVG86IEtpbSwgRG9uZ3dvbiA8ZG9uZ3dvbi5raW1AaW50
ZWwuY29tPg0KPiBDYzogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QGdtYWls
LmNvbT47IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAx
LzNdIHVpL2d0azogc2tpcCBkcmF3aW5nIGd1ZXN0IHNjYW5vdXQgd2hlbiBhc3NvY2lhdGVkDQo+
IFZDIGlzIGludmlzaWJsZQ0KPiANCj4gT24gVGh1LCBGZWIgMDEsIDIwMjQgYXQgMDY6NDg6NThQ
TSArMDAwMCwgS2ltLCBEb25nd29uIHdyb3RlOg0KPiA+IEhpIE1hcmMtQW5kcsOpLA0KPiA+DQo+
ID4gVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLiBZZXMsIHlvdSBhcmUgcmlnaHQsIHJlbmRlcmlu
ZyBkb2Vzbid0IHN0b3ANCj4gPiBvbiBVYnVudHUgc3lzdGVtIGFzIGl0IGhhcyBwcmV2aWV3IGV2
ZW4gYWZ0ZXIgdGhlIHdpbmRvdyBpcyBtaW5pbWl6ZWQuIEJ1dA0KPiB0aGlzIGlzIG5vdCBhbHdh
eXMgdGhlIGNhc2UuDQo+ID4gU29tZSBzaW1wbGUgd2luZG93cyBtYW5hZ2VycyBkb24ndCBoYXZl
IHRoaXMgcHJldmlldyAodGh1bWJuYWlsKQ0KPiA+IGZlYXR1cmUgYW5kIHRoaXMgdmlzaWJsZSBm
bGFnIGlzIG5vdCB0b2dnbGVkLiBBbmQgdGhlIHJlbmRlcmluZyBzdG9wcw0KPiA+IHJpZ2h0IGF3
YXkgdGhlcmUgd2hlbiB0aGUgd2luZG93IGlzIG1pbmltaXplZC4NCj4gDQo+IFRoaXMgbWFrZXMg
bWUgcHJldHR5IHVuY29tZm9ydGFibGUuIFRoaXMgaXMgcHJvcG9zaW5nIGNoYW5naW5nIFFFTVUN
Cj4gYmVoYXZpb3VyIHRvIHdvcmthcm91bmQgYSBwcm9ibGVtIHdob3NlIGJlaGF2aW91ciB2YXJp
ZXMgYmFzZWQgb24gd2hhdCAzcmQNCj4gcGFydHkgc29mdHdhcmUgUUVNVSBpcyBydW5uaW5nIG9u
DQo+IA0KPiBXaGF0IHlvdSBzYXkgIndpbmRvdyBtYW5hZ2VycyIgYXJlIHlvdSByZWZlcnJpbmcg
dG8gYSB0cmFkaXRpb25hbA0KPiBYMTEgYmFzZWQgaG9zdCBkaXNwbGF5IG9ubHksIG9yIGRvZXMg
dGhlIHByb2JsZW0gYWxzbyBleGlzdCBvbiBtb2Rlcm4NCj4gV2F5bGFuZCBob3N0IGRpc3BsYXkg
Pw0KDQpbS2ltLCBEb25nd29uXSAgSSBkaWRuJ3QgbWVhbiBhbnl0aGluZyBhYm91dCB0aGUgY29t
cG9zaXRvci9kaXNwbGF5IHNlcnZlciBpdHNlbGYuIEFuZCBJIGFtIG5vdCBzdXJlIGFib3V0IHRo
ZSBnZW5lcmFsIGJlaGF2aW9yIG9mIFdheWxhbmQgY29tcG9zaXRvcnMgYnV0IHRoZSBwb2ludCBo
ZXJlIGlzIHRoZSByZW5kZXJpbmcgd2hpbGUgdGhlIGFwcCBpcyBiZWluZyBpY29uaXplZCAobWlu
aW1pemVkKSBpcyBub3QgYWx3YXlzIHRoZSBjYXNlLiBGb3IgZXhhbXBsZSwgSUNFLVdNIG9uIFlv
Y3RvIExpbnV4IGRvZXNuJ3QgaGF2ZSBhbnkgcHJldmlldyBmb3IgdGhlIGljb25pemVkIG9yIG1p
bmltaXplZCBhcHBsaWNhdGlvbnMsIHdoaWNoIG1lYW5zIGFsbCBkcmF3aW5nIGFjdGl2aXRpZXMg
b24gdGhlIG1pbmltaXplZCBhcHAgYXJlIHBhdXNlZC4gVGhpcyBpcyB0aGUgcHJvYmxlbSBpbiBj
YXNlIGJsb2Igc2Nhbm91dCBpcyB1c2VkIHdpdGggdmlydGlvLWdwdSBvbiB0aGUgZ3Vlc3QgYmVj
YXVzZSB0aGUgZ3Vlc3Qgd29uJ3QgcmVjZWl2ZSB0aGUgcmVzcG9uc2UgZm9yIHRoZSBmcmFtZSBz
dWJtaXNzaW9uIHVudGlsIHRoZSBmcmFtZSBpcyBmdWxseSByZW5kZXJlZCBvbiB0aGUgaG9zdC4g
VGhpcyBpcyBjYXVzaW5nIHRpbWVvdXQgYW5kIGZ1cnRoZXIgaXNzdWUgb24gdGhlIGRpc3BsYXkg
cGlwZWxpbmUgaW4gdmlydGlvLWdwdSBkcml2ZXIgaW4gdGhlIGd1ZXN0Lg0KDQo+IA0KPiBJZiB0
aGUgcHJvYmxlbSBpcyBjb25maW5lZCB0byBYMTEsIHRoYXQgd291bGQgc3RlZXIgdG93YXJkcyBz
YXlpbmcgd2Ugc2hvdWxkbid0DQo+IHRyeSB0byB3b3JrYXJvdW5kIGl0IGdpdmVuIHRoYXQgWDEx
IGlzIHZlcnkgbXVjaCBvYnNvbGV0ZSBhdCB0aGlzIHBvaW50Lg0KDQpbS2ltLCBEb25nd29uXSAg
SSB0aGluayBJIHNob3VsZCB0cnkgV2F5bGFuZCB0b28gYnV0IEkgZ3Vlc3MgaXQgZGVwZW5kcyBv
biB0aGUgY29tcG9zaXRvciBhbmQgdGhlIHNoZWxsIGRlc2lnbi4gT2YgY291cnNlIEkgbmVlZCB0
byB0ZXN0IGJ1dCB3aGF0IGlmIGl0IHdvcmtzIG9rIG9uIHRoZSBVYnVudHUgcnVubmluZyB3aXRo
IHdheWxhbmQgYmFja2VuZCBidXQgbm90IHdpdGggV2VzdG9uPw0KDQo+IA0KPiBXaXRoIHJlZ2Fy
ZHMsDQo+IERhbmllbA0KPiAtLQ0KPiB8OiBodHRwczovL2JlcnJhbmdlLmNvbSAgICAgIC1vLSAg
ICBodHRwczovL3d3dy5mbGlja3IuY29tL3Bob3Rvcy9kYmVycmFuZ2UgOnwNCj4gfDogaHR0cHM6
Ly9saWJ2aXJ0Lm9yZyAgICAgICAgIC1vLSAgICAgICAgICAgIGh0dHBzOi8vZnN0b3AxMzguYmVy
cmFuZ2UuY29tIDp8DQo+IHw6IGh0dHBzOi8vZW50YW5nbGUtcGhvdG8ub3JnICAgIC1vLSAgICBo
dHRwczovL3d3dy5pbnN0YWdyYW0uY29tL2RiZXJyYW5nZSA6fA0KDQo=

