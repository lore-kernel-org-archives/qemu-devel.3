Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACFFC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHdf-00070w-UE; Thu, 07 Mar 2024 12:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1riHde-00070f-7o
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:34:38 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1riHda-00020Y-VP
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709832875; x=1741368875;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ah+m9FcYBkvFCG5pBPQRJvF3wyJCeG+DxyPZNxTjbEI=;
 b=MnJtu9CmakftaSEeyZuTfigWzSOL9KoZsjnpHBXqMuMigju/SzftF7UZ
 i2ULIZogkK5o86wB2e0w1NjalWvwn/LhBCvEkQ4VJ75BkxL5dyDIyJ4fY
 +sKyrtS2suKyvohrEE/7EfP0ZRP9TVIuiPyXjlRynR+G+ekaKgGm08/Ph
 /bMHoiiaBiCDieDeFfwiS3eKOpiU4VJ7fYaFUhZUGbfT10MAHmr8xUZ4D
 CkHN+lwO95FGs27swPi8KHOh491DbfxU8w7YzNpRaDKTUjWjV697d4z0i
 0zZCq1OmXEDh5BBRe49X7lKHq+BFDcmk3PAzJ3MedOqoBsA5lgENQcCJQ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4397356"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4397356"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 09:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; d="scan'208";a="41158974"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Mar 2024 09:34:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 09:34:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 09:34:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:34:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBvDKoPfxcOjVBmZ9fv0gq1+GFVO8fvR7POQyx292oyE0ghdiMmdYMrUy/OkdNmm0kyU/TyvD5ZQKVchTLWd2175zjoWX2GBofNlxhRbDWs3pwtkaFElP7s/aFHO1vWXrcLRvBb1a6WyvLE7/unCEIENYtPksQMFBr+QuKgFhd5ry6pQ90DXM5u0pZ1qnL86mkGvCDxrT8oiuAA/zQRr+8zTgnXnj7cD12x426+2nojThXd21uDB7CtXtwWaenUtzFECd0zqCEy6Ll//enMRZAqWiQyWM1BYIuW7hFgqqHPOTJuNJdaZ2bAhIX2RM9W5iyYsV9ka4LPDeMCqopN6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah+m9FcYBkvFCG5pBPQRJvF3wyJCeG+DxyPZNxTjbEI=;
 b=H1ayY79oni1kpLWLi/+XfoqdVJhRSLfVDtSf94Y29R+EsYFZuNsZ1HU1BSyOMn2LgzNV2E+vP13/fDMYI+SLeuBZHU9WraboIsv3v8HfqPnxjYi4GXJEgp5ZF7GPJTqVFyaeDfQgsZQSaZaMmKRZNBGv+UqQ2QKEo/+EOKmdZjpl2Ol8SlGQvei2HUrnr9e8w7yztsBxSSqkjwMjykYmtzsqzCm+aQ6wZhoNrKjLgArqEBRALQ8z4c6Uky0ZtLQvsj+4bWXWp6i/oLtUXAIa8W5MmO1tRJ6mmpzXmVeYprDM1d1aYLyNfGJt7ZT9Rrpe3rAAIlsAztPaE2ic37TtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by IA0PR11MB8420.namprd11.prod.outlook.com (2603:10b6:208:482::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 17:34:28 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 17:34:28 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated VC
 is invisible
Thread-Topic: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated
 VC is invisible
Thread-Index: AQHaU9fcRg8sk5PypUazkJHR2gMsqbEsP2OAgACDjHA=
Date: Thu, 7 Mar 2024 17:34:28 +0000
Message-ID: <PH8PR11MB68792D0B02A1FA7D088A9ADFFA202@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-2-dongwon.kim@intel.com> <ZemLoa0JLXJW9l0F@redhat.com>
In-Reply-To: <ZemLoa0JLXJW9l0F@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|IA0PR11MB8420:EE_
x-ms-office365-filtering-correlation-id: 48bfa897-aa6d-4bb8-6e76-08dc3eccd767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U2dMNO05IGpy4LwQUjkjXb2JLldIaeBVlNvw48N+MjODNbh0H5JcRxarl2ClhsYqoYtPXIEmPjEup7YlC9/BJKzHXIrrdRH3blAdjXZQ4vDj9al33qzJUSfij03xfVnpbS3qkNxqxqtZBI8Jk29Ch+HkvFPqnLLWdqGoXnPm7i/EH4zCv52fI+4hwMfYD8fzfaNkJDm5eqm+j+Q7D1TY/Cf/r1v0j0cEwxkIVPHmuQDU1DV0g+AJD2YYKzsspcMeORP/rDwKkYZKjOeDQmK6MUc5ljflL4ATvJbYLgDvN+AXWnhBgqBdgrrCu0t0/5F0qDBd33XJRSsqtaQa2cnDQRF4yyPom4kDdolofy6vf12TSbWHGtBEtb7gRkXqKnyjNjBRVG8c3klKwWYw5P219Sp60voUmIi7HzDMZWtbpxpbaaoOds+jWfz8zfMhJuu1nm29nq6wHVZ9MrBv4W5sp440zHmS6Rx51jZUrrpQOGCDljEurlHxvb1qtw+desQxiWSdktnYSDqSilPx/CczQczhZayVr6ZsMvRcgOHN8/5s1BXnJSV5xYjLaC8yJI6ZaSjDVpm3uEQER8PerUnhkri4vEFtyXt+qgOvoVnZ1ZvOZlHqqtK2ScerSCccSRXf2LhPXzN8nedesAiAHaQ11epfOaTgClE9AqG49oBgpCEcUDRdvvf0jBk+1Sc1NPWj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2VrRlJNVHhTUXp1RnM2SkdIQWVraDY5ckR4MmcwdHRUTzlBem5XQ1F3Ujhq?=
 =?utf-8?B?TWFXSUlxVUxJRWZRbWRxYm1TelVoOURnU1kzMWpoYTF2NVI2M1VHZUYzRnVC?=
 =?utf-8?B?dmNRdkloekNrWHY0QUwxb1grT0JZaGUwbWF1TjNvbnh5M0FFL2pZNUlBRGFs?=
 =?utf-8?B?M1M3WGdFT1dPU3NlRGNKNzRLYXorRnNZUHhlSFJxcjNmMDR5RStvU1ptWU8w?=
 =?utf-8?B?MEllZUM2STNpVytnMnQzR2cyNkRSdzRqRWNDVzJadFBGYnkrYzJrcXhmSzlk?=
 =?utf-8?B?RHdFeHBMMHNNRUh3eDB1RFF2VVl4c2VGWWpwWFNjaXVzcjY0ZVhnK29KSE8r?=
 =?utf-8?B?eDhXbXBERlBOd3ljLzFmRC84Z2E5MlViUjlLcDlma3pNOEJFcEI3ZkQwZDBO?=
 =?utf-8?B?K1JqbURyZHh2cWJnY0YvV1ZBTkhwS0c0UHgzY0VZcnhqUFhSUmhoZytjMVhM?=
 =?utf-8?B?ODVUbm50OTZXMmR1d2lhZjAwODdMWE00WWFvSkFnZkFGVmVYQUVGVGZocDE5?=
 =?utf-8?B?eWY2MlZ1azJFd2lTcmNCYlo5eHVRUnVGbWhUYllybVRTRkhieS9sbGN0QmZh?=
 =?utf-8?B?WFN2QTFyeVUzeGpBZTJ1L1FCOGRBak5ZNDFaemtNQ0I1eFg4RnRKMzB3Y0NY?=
 =?utf-8?B?VC9YMVZ5bCtkZ2pCVm8xalJUSUhSRlIxeXhEQy9NKzVoZ3lMZzZpcnpHak1Y?=
 =?utf-8?B?ZUdHS0VubWgvVVk5VXBobTAvVFh0K3haaFZPb1prWGUxVVc4UDQyRmNmY1Bj?=
 =?utf-8?B?SHo0LzRqR3hqN2I0OUhvNjlDdnBQcC80RVRHVW52ZEJ5bmRteEhMNThsaVZZ?=
 =?utf-8?B?ZWt3dURPUmJLTEc3UjBveUFhTE5qK3JjYzMxVThQS0NHdjRpZDhWeFp2RnFQ?=
 =?utf-8?B?dm5zbW5MTGR6ZVJSYnZNWlJkb1lYekRTSHhBekRjSEczaGdVSEMwcDYyOFlU?=
 =?utf-8?B?ZmNWTmRiSHNsVlgwUnBRUWNvY1RTSS9UVUpXTmFicFMvNWNHbUt5eUp2akRn?=
 =?utf-8?B?TUswS2l1UjNleTJjNE5yaGx2aUFLeEkyNC9LWkpZRzZCeUF2MmlhU1orcmZP?=
 =?utf-8?B?Ykd1clc5OWJsbmhpbzVrZDFrN0lkS0JIUFkrOW52L2dZRjhoSHdsT3ZhQ2N5?=
 =?utf-8?B?aHN2Q0FURXAwR29PUkxMTmx3R2Fla2E0bE15d3ZDTGFjaGpjbEUzZHBLZFZV?=
 =?utf-8?B?VUxyeDVNZmhuWGVBUlorU3FoOWlkRzBSY1lJdjhqNWQ5aEwvVXFLSUJCY3Zh?=
 =?utf-8?B?S1NNclBud0ZrSTJsVEgyQzlxTU42dXFQWjlRNDlDYmhSeTlRSVl1YktjdGJ0?=
 =?utf-8?B?WFAzQWl2RUFNZ0RwZ0kxYlBZYkhZVVBFYVh1akZmYkVaYTFnZjlVREhBU3NY?=
 =?utf-8?B?Y3A3U1FUWGkyR29GK3hFbjhtb2VBdjZZMjhXemlWem0rQ0lJNVA0S3hHMFB0?=
 =?utf-8?B?cStxV2h5SDRUbEk4VUxLa0RnbnIxNm5SSFdXU3VFSExPVjRVTkFqaDJUdSt0?=
 =?utf-8?B?Zy93bXp4T29SM2xhci9UZ1QzVVM0Z2hsVVZsc2VkQ01nUm96M21GV2NMbjBl?=
 =?utf-8?B?Q2FKOHlremRXU3FZUm4wd3A2UEJ3bm8xbm1OMjdyS2tkK1BvQ2g3OHUvOHZ6?=
 =?utf-8?B?THZPdmNqT0M5MVdnOGxXSmJncW1ZbE5abjg4L3JzSEptQUJDTWxxeTBQaXgy?=
 =?utf-8?B?TXF1S1p4UEl3M29YM2dVbmljV3N5R1BaYTNLUmlwSG1LU2daN2ZYc2NKYzI2?=
 =?utf-8?B?cnVhVXdXY0V2L2F6dDkwbjBLV1ZxcEM0TWpESG1Ob2lEd3M5L1FibG13VXdv?=
 =?utf-8?B?N3p2WFlTSXZYblIxMm5IRFdNOGEwcTZpS1NhNklhRTlVV0djak8vcnBNc2xR?=
 =?utf-8?B?bFMxSDFSUzMxR1M2dEp6VjlpbTZsa3hkR1dlK2N1VStFeU9XazJyMUJPZzhr?=
 =?utf-8?B?UzlReWNYQmI3NktWb3hDQkRoazNra3JOdFNvNG1UMVhEUmZ6WlhaUFJwRlFU?=
 =?utf-8?B?NTJEaHNHZ2I3b21QRWdnRGhJdU9YODlzSTFySllYVDk2WTdvQjVUSnVXU0Fi?=
 =?utf-8?B?bTNqQ0xlZHZDbzZlc2xCMGFEZVNMODl5UW9aVERObnFkOWJqSy9sWlJuL0ln?=
 =?utf-8?Q?I44WMJ4QGmXBMJbBnz0LqHvCR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bfa897-aa6d-4bb8-6e76-08dc3eccd767
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 17:34:28.7816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+S5ltc4XvnJCratlgcM2mn2Ful5vl31Bgw+wsuIo9fqXgRdI8GAvm3z0JWtHQL7GimekQKda55ww7PqE2fbCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8420
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCA3LCAyMDI0IDE6NDEgQU0NCj4gVG86IEtpbSwgRG9uZ3dvbiA8ZG9uZ3dvbi5raW1AaW50
ZWwuY29tPg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMS8zXSB1aS9ndGs6IHNraXAgZHJhd2luZyBndWVzdCBzY2Fub3V0IHdoZW4gYXNzb2NpYXRl
ZA0KPiBWQyBpcyBpbnZpc2libGUNCj4gDQo+IE9uIFR1ZSwgSmFuIDMwLCAyMDI0IGF0IDAzOjQ4
OjM4UE0gLTA4MDAsIGRvbmd3b24ua2ltQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBEb25n
d29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiA+DQo+ID4gQSBuZXcgZmxhZyAidmlz
aWJsZSIgaXMgYWRkZWQgdG8gc2hvdyB2aXNpYmlsaXR5IHN0YXR1cyBvZiB0aGUgZ2Z4IGNvbnNv
bGUuDQo+ID4gVGhlIGZsYWcgaXMgc2V0IHRvICd0cnVlJyB3aGVuIHRoZSBWQyBpcyB2aXNpYmxl
IGJ1dCBzZXQgdG8gJ2ZhbHNlJw0KPiA+IHdoZW4gaXQgaXMgaGlkZGVuIG9yIGNsb3NlZC4gV2hl
biB0aGUgVkMgaXMgaW52aXNpYmxlLCBkcmF3aW5nIGd1ZXN0DQo+ID4gZnJhbWVzIHNob3VsZCBi
ZSBza2lwcGVkIGFzIGl0IHdpbGwgbmV2ZXIgYmUgY29tcGxldGVkIGFuZCBpdCB3b3VsZA0KPiA+
IHBvdGVudGlhbGx5IGxvY2sgdXAgdGhlIGd1ZXN0IGRpc3BsYXkgZXNwZWNpYWxseSB3aGVuIGJs
b2Igc2Nhbm91dCBpcyB1c2VkLg0KPiA+DQo+ID4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFy
Y2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+IENjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxA
cmVkaGF0LmNvbT4NCj4gPiBDYzogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNpcmVkZHlAaW50
ZWwuY29tPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2lt
QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS91aS9ndGsuaCB8ICAxICsNCj4gPiAg
dWkvZ3RrLWVnbC5jICAgICB8ICA4ICsrKysrKysrDQo+ID4gIHVpL2d0ay1nbC1hcmVhLmMgfCAg
OCArKysrKysrKw0KPiA+ICB1aS9ndGsuYyAgICAgICAgIHwgMTAgKysrKysrKysrLQ0KPiA+ICA0
IGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VpL2d0ay5oIGIvaW5jbHVkZS91aS9ndGsuaCBpbmRleA0K
PiA+IGFhM2Q2MzcwMjkuLjJkZTM4ZTU3MjQgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS91aS9n
dGsuaA0KPiA+ICsrKyBiL2luY2x1ZGUvdWkvZ3RrLmgNCj4gPiBAQCAtNTcsNiArNTcsNyBAQCB0
eXBlZGVmIHN0cnVjdCBWaXJ0dWFsR2Z4Q29uc29sZSB7DQo+ID4gICAgICBib29sIHkwX3RvcDsN
Cj4gPiAgICAgIGJvb2wgc2Nhbm91dF9tb2RlOw0KPiA+ICAgICAgYm9vbCBoYXNfZG1hYnVmOw0K
PiA+ICsgICAgYm9vbCB2aXNpYmxlOw0KPiA+ICAjZW5kaWYNCj4gPiAgfSBWaXJ0dWFsR2Z4Q29u
c29sZTsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS91aS9ndGstZWdsLmMgYi91aS9ndGstZWdsLmMg
aW5kZXggM2FmNWFjNWJjZi4uOTkzYzI4MzE5MQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL3VpL2d0
ay1lZ2wuYw0KPiA+ICsrKyBiL3VpL2d0ay1lZ2wuYw0KPiA+IEBAIC0yNjUsNiArMjY1LDEwIEBA
IHZvaWQNCj4gZ2RfZWdsX3NjYW5vdXRfZG1hYnVmKERpc3BsYXlDaGFuZ2VMaXN0ZW5lcg0KPiA+
ICpkY2wsICAjaWZkZWYgQ09ORklHX0dCTQ0KPiA+ICAgICAgVmlydHVhbENvbnNvbGUgKnZjID0g
Y29udGFpbmVyX29mKGRjbCwgVmlydHVhbENvbnNvbGUsIGdmeC5kY2wpOw0KPiA+DQo+ID4gKyAg
ICBpZiAoIXZjLT5nZngudmlzaWJsZSkgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAg
IH0NCj4gPiArDQo+ID4gICAgICBlZ2xNYWtlQ3VycmVudChxZW11X2VnbF9kaXNwbGF5LCB2Yy0+
Z2Z4LmVzdXJmYWNlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgdmMtPmdmeC5lc3VyZmFjZSwg
dmMtPmdmeC5lY3R4KTsNCj4gPg0KPiA+IEBAIC0zNjMsNiArMzY3LDEwIEBAIHZvaWQgZ2RfZWds
X2ZsdXNoKERpc3BsYXlDaGFuZ2VMaXN0ZW5lciAqZGNsLA0KPiA+ICAgICAgVmlydHVhbENvbnNv
bGUgKnZjID0gY29udGFpbmVyX29mKGRjbCwgVmlydHVhbENvbnNvbGUsIGdmeC5kY2wpOw0KPiA+
ICAgICAgR3RrV2lkZ2V0ICphcmVhID0gdmMtPmdmeC5kcmF3aW5nX2FyZWE7DQo+ID4NCj4gPiAr
ICAgIGlmICghdmMtPmdmeC52aXNpYmxlKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsg
ICAgfQ0KPiA+ICsNCj4gPiAgICAgIGlmICh2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1ZiAmJiAhdmMt
PmdmeC5ndWVzdF9mYi5kbWFidWYtDQo+ID5kcmF3X3N1Ym1pdHRlZCkgew0KPiA+ICAgICAgICAg
IGdyYXBoaWNfaHdfZ2xfYmxvY2sodmMtPmdmeC5kY2wuY29uLCB0cnVlKTsNCj4gPiAgICAgICAg
ICB2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1Zi0+ZHJhd19zdWJtaXR0ZWQgPSB0cnVlOyBkaWZmIC0t
Z2l0DQo+ID4gYS91aS9ndGstZ2wtYXJlYS5jIGIvdWkvZ3RrLWdsLWFyZWEuYyBpbmRleCA1MmRj
YWMxNjFlLi4wNGUwN2JkN2VlDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvdWkvZ3RrLWdsLWFyZWEu
Yw0KPiA+ICsrKyBiL3VpL2d0ay1nbC1hcmVhLmMNCj4gPiBAQCAtMjg1LDYgKzI4NSwxMCBAQCB2
b2lkDQo+ID4gZ2RfZ2xfYXJlYV9zY2Fub3V0X2ZsdXNoKERpc3BsYXlDaGFuZ2VMaXN0ZW5lciAq
ZGNsLCAgew0KPiA+ICAgICAgVmlydHVhbENvbnNvbGUgKnZjID0gY29udGFpbmVyX29mKGRjbCwg
VmlydHVhbENvbnNvbGUsIGdmeC5kY2wpOw0KPiA+DQo+ID4gKyAgICBpZiAoIXZjLT5nZngudmlz
aWJsZSkgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAg
ICBpZiAodmMtPmdmeC5ndWVzdF9mYi5kbWFidWYgJiYgIXZjLT5nZnguZ3Vlc3RfZmIuZG1hYnVm
LQ0KPiA+ZHJhd19zdWJtaXR0ZWQpIHsNCj4gPiAgICAgICAgICBncmFwaGljX2h3X2dsX2Jsb2Nr
KHZjLT5nZnguZGNsLmNvbiwgdHJ1ZSk7DQo+ID4gICAgICAgICAgdmMtPmdmeC5ndWVzdF9mYi5k
bWFidWYtPmRyYXdfc3VibWl0dGVkID0gdHJ1ZTsgQEAgLTI5OSw2DQo+ID4gKzMwMywxMCBAQCB2
b2lkIGdkX2dsX2FyZWFfc2Nhbm91dF9kbWFidWYoRGlzcGxheUNoYW5nZUxpc3RlbmVyICpkY2ws
DQo+ID4gI2lmZGVmIENPTkZJR19HQk0NCj4gPiAgICAgIFZpcnR1YWxDb25zb2xlICp2YyA9IGNv
bnRhaW5lcl9vZihkY2wsIFZpcnR1YWxDb25zb2xlLCBnZnguZGNsKTsNCj4gPg0KPiA+ICsgICAg
aWYgKCF2Yy0+Z2Z4LnZpc2libGUpIHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9
DQo+ID4gKw0KPiA+ICAgICAgZ3RrX2dsX2FyZWFfbWFrZV9jdXJyZW50KEdUS19HTF9BUkVBKHZj
LT5nZnguZHJhd2luZ19hcmVhKSk7DQo+ID4gICAgICBlZ2xfZG1hYnVmX2ltcG9ydF90ZXh0dXJl
KGRtYWJ1Zik7DQo+ID4gICAgICBpZiAoIWRtYWJ1Zi0+dGV4dHVyZSkgew0KPiANCj4gSWYgd2Ug
c2tpcCBwcm9jZXNzaW5nIHRoZXNlIHJlcXVlc3RzLCB3aGF0IGhhcHBlbnMgd2hlbiB0aGUgUUVN
VSB3aW5kb3dzIGlzDQo+IHRoZW4gcmUtZGlzcGxheWVkLiBXb24ndCBpdCBub3cgYmUgbWlzc2lu
ZyB1cGRhdGVzIHRvIHZhcmlvdXMgcmVnaW9ucyBvZiB0aGUNCj4gZ3Vlc3QgZGlzcGxheSA/DQog
DQpbS2ltLCBEb25nd29uXSAgU2Nhbm91dCBibG9iIGlzIGNvbnRpbnVvdXNseSBzdWJtaXR0ZWQg
YnkgdGhlIGd1ZXN0IGV2ZW4gd2hlbiB0aGUgdmMtPnZpc2libGUgaXMgZmFsc2UuIFNvIGl0IHdp
bGwganVzdCBkaXNwbGF5IHRoZSBjdXJyZW50IGd1ZXN0IGZyYW1lIHJpZ2h0IGF3YXkgd2hlbiB0
aGUgd2luZG93IGlzIHJlZGlzcGxheWVkIGFnYWluLg0KDQo+IA0KPiA+DQo+IFdpdGggcmVnYXJk
cywNCj4gRGFuaWVsDQo+IC0tDQo+IHw6IGh0dHBzOi8vYmVycmFuZ2UuY29tICAgICAgLW8tICAg
IGh0dHBzOi8vd3d3LmZsaWNrci5jb20vcGhvdG9zL2RiZXJyYW5nZSA6fA0KPiB8OiBodHRwczov
L2xpYnZpcnQub3JnICAgICAgICAgLW8tICAgICAgICAgICAgaHR0cHM6Ly9mc3RvcDEzOC5iZXJy
YW5nZS5jb20gOnwNCj4gfDogaHR0cHM6Ly9lbnRhbmdsZS1waG90by5vcmcgICAgLW8tICAgIGh0
dHBzOi8vd3d3Lmluc3RhZ3JhbS5jb20vZGJlcnJhbmdlIDp8DQoNCg==

