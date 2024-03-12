Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F245C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZS-0004S3-N6; Tue, 12 Mar 2024 18:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rkAZH-0004Pe-GV
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:55 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rkAZD-0004D5-NV
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710282352; x=1741818352;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uGlD6UVT4vAV+wph9v8Ns5n0IsDYuNj8C/LNW2jZlHs=;
 b=PjHHJYFgljOkUdIAI4qP4wziGMfHERoBvmJxDzsfpojzRg79sn67AN29
 2GQ/0EWDGvy9dHCEB1FA3MkO4SVmMxs51eEykCTKIgE2fJfHmjhM9mdDd
 WPvdf0mxP5NQwGXVktNkyM6ojNDdaSdMb5KJUR8pnEi7udOCErrQjp9KC
 81jaYQCNOjWHzq9Z4upwPRz7jInZ13P+N20t5D4YfBnuz8qiwbUBUgKXr
 43tYge4ul5s+2w8nrRS3ovUTW6hi7Ol5EFF2vqJSTG0xCc4sVbuNLJMsJ
 5VgZEbdL9MrCRp4sDyGwsYP4FEaZJJvqNXR+NPYQjKsE/PnbHD+tVC83c Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5191466"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5191466"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 15:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16356163"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Mar 2024 15:25:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 15:25:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 15:25:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 15:25:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 15:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7vaJwc5FyKPz2y5zd3Z608FSVPZIk6JOYSKTOUcFGsvV6PALqOP1fbejaJtQsgmJBUwQjVwBMrg0Qo9QN2N5+S1XeIsLkPwEfBmEMAOCoooJwrGL8u/E1fQ2xubwvy7wKQj0EbTgYV1N01VrDEy6L3wqkLQV+Qir5Al6EZCzywEILAoIfovFtP6KAlF8LroGX7cuZ6uPuyyX7gwM/yBpxD53TMVPsbfujQb0CwN/3hM0CsWGzqkb9KFDuAaD1yQSOSRAAF7+JS5UhKbULPCj1qWk8ak3+RKbJ407eXwmLodBZWM3xk59TT6K66+VlllWC4aQH7MK2LTLcLKlSCa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGlD6UVT4vAV+wph9v8Ns5n0IsDYuNj8C/LNW2jZlHs=;
 b=DK81QwFQYHjK6pBMG3DHfTXkQK6lTKcAmDHGJwd57PMIIIHA6nGH52ROll7cu8sk1qouIC13HkJ9uvcDzvzoiKa7SwV6tfyc2G/DzV+UvUNQJfTqY4DHiG6sMtsDXg5CqPCoZ4z9vzplzpIzhIOHIt57eq7Sqiqnv3+FfgF4eGQGv12NGnwhYxGPTpPDXQ7WwMYP5fJ9y0bNgZSpaERAdvKT3+m6l0g0eQIt0wEjSKjvmmhb/W5tsezDDd9KzQhkJHCtT/YM0kAHzOhdH9eJwxWDoX7m6f34JoNCUVuQKuvKspZKaJOSUdr3/v7fBnNgZCx3L9p/ylJIQYatNHy1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Tue, 12 Mar
 2024 22:25:44 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7386.017; Tue, 12 Mar 2024
 22:25:44 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3] ui/gtk: flush display pipeline before saving vmstate
 when blob=true
Thread-Topic: [PATCH v3] ui/gtk: flush display pipeline before saving vmstate
 when blob=true
Thread-Index: AQHacBWXquRjD26Fqk6ni0B3Bu2RYLE0ACwAgAC3UzA=
Date: Tue, 12 Mar 2024 22:25:44 +0000
Message-ID: <PH8PR11MB6879D4AC965133F9F637266EFA2B2@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240306222523.3236832-1-dongwon.kim@intel.com>
 <CAJ+F1CJEJ8neE9woTJ=SPoSdZA+T4QNC0-GccZ9N2C_cgOvNwQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJEJ8neE9woTJ=SPoSdZA+T4QNC0-GccZ9N2C_cgOvNwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|MW3PR11MB4716:EE_
x-ms-office365-filtering-correlation-id: 6ef55112-7fc7-4580-1c80-08dc42e35b9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cLzyMJTtctB0oHL0ep33r0a8vq6Lutb6UjkcJIEuVkJGsWdktk0btad1BVBQUIGT6ow4OCVx8p+koi/976xvVeaBEh09dmG792V9oIiIsnWUigljcvceNAEn7ckBOVVGLEQvtVS6ExGiIrYQS68uQh/E+x3Di53hTBMmqMVoIzas9vGu1VOTeBVfzCaNgGLstobX9dJqPlrRPRD4xt7wVIz7V3DZW3eoNNyqIa4HtbI4irfKEHEIfjGXs+h6n8a+UOdrND3NsPED7+NrOGuRm4xSmFnbOT0i7aMkIdoZ2OFTFancZTp8O3AuPBV2Kd7Vg6iBgRgdRMCdqunaHMUFNrWMBjyEadg5xZP4trJI89l+Uubldavg7rkH/ghFTCcYwbWSF2Ih618fH7mfTlhBp7CyaLJVCoRO8wkigv9NwJVatr/aABAhHjtKwAiLKEwRqVZgbaAT8gOQKuBs5J1OOAatnSFYHRaP3GUbX0yZGZXf+fPFxC5QiGPtL51bmcssCBCPXZaRweHzN6snUD9cPjZ8tYEllzp45AiPajQvmc4psP49aio6AYudSlBh/S2Dch/+0eIoubPYsZHsXEMTyoyIBH3wkx4O+E54FVtyhvoiJETAoz2MtjNQrfyA12WpWs3lpyHjYIZuWx5tpI7qgwMgOfUAKNT0jBJyoqtF7qGX6kn9hy54IEx0OfppliwD796+PdFgTpsnVLi/GixgKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0U4cUVOMlJ0TGRoWFAyNkNYVC9ScWtONjk5OWtEK2R6b3J2alBOb01Ibkd0?=
 =?utf-8?B?SE4wRXcvMlk2dXJQTmRRdk5VYXhtd1lIdmFKV1g5cnkyRTl2anJadHgxbTNY?=
 =?utf-8?B?UFRJVWZoUWdxOVFHMmpidTBDc2VxVVduT2J2MmtOR0ZOTDNzRWNPUjZYaFY0?=
 =?utf-8?B?TGFGaXQrS2FmS1V4ZlJPOHgxdjMwck8xaHhqWDNQY3ZLU0lLSGlWSGVRa3d0?=
 =?utf-8?B?b1NZekJOaGtuY2hDckJyMGVURENQZFdwK01JWHVzejB4TElTQmhmQ2Q1aXJX?=
 =?utf-8?B?dEcxVEhXUFlnUUtER2UvdUFUMGdmdUxqaDhOMUw4SXUxd3pJQ3Q0VjhJOXhu?=
 =?utf-8?B?bjc4MHVoM214WlVsTjc2bkhRM042VnE2NkcxMlhBYTVNWEU0QnkyUWhDTlhW?=
 =?utf-8?B?TlA5enF6T2RrOGo4MXUxOTUrbmgyTHhMM3haSHhxNXpEYUsrQ3RjSmxqVHUx?=
 =?utf-8?B?cEt0R2xVSHNoeUFqV2w5enlhdW1MeTU1MTNuSXNpK0xoNmhWa3Q4TEllbElP?=
 =?utf-8?B?cVZ1YlVRcU9WMFFGWEdHZjJFb2szK1FOcEp5OWUwS1BaRHY3K21DUlZyR3B0?=
 =?utf-8?B?SnQ2SW5vdHNjVXBSdHFZUXlkUWFGVmZ5QU1xMGFBbzRlVytTVU1LaFgwOURI?=
 =?utf-8?B?dERiR3NGVWdzVzhLUG0wTDRMdFJ1cVQrdGxCMDZXZFhZOGdvcis2NmFMZmpn?=
 =?utf-8?B?YzhMeWlOeHJWMk41NmVpKzNQL0F4TWdJUDYyd2tuQ09EV0pIUDZJV3pXVnZW?=
 =?utf-8?B?N0pSbzAzMWRzYW1CL29PTHBMcERkQy9hMUJWb2hPUGlVb0pOaTZhWllZUXl2?=
 =?utf-8?B?bDJ2OVc4WUFLNlNmdDI3L1VXZkxVZkZRbkJZNDN5TWVtdDkwL3lFSUVDdlA5?=
 =?utf-8?B?dDBEblFkTTBEUTZjZFNFeXp3TGNyRzZRYlJma2k5WFZFMnhqbVVEcUFuSUYw?=
 =?utf-8?B?WlFxWHk5blBPVUtFSWlCc3pDM1JQTDZSNVZsSFNyN0pBMkhaQ005YU9JUFBk?=
 =?utf-8?B?TERIb1hvNlpMcUwvbTdWU3BldlFBa1ZibUFSWEdjem1XZUJxNnRvMjBQMjRo?=
 =?utf-8?B?VHhvSVVDaURTbDloM2hWSTdHV1lzU0VucnFSR2VhdGxhVUU3RzZTVWMyemVM?=
 =?utf-8?B?ZDJtY3VIaCttVkRHOTdFNWJDb1RKcXQwaUVMUmhuVHpSbkdSdmFiTWdRRUli?=
 =?utf-8?B?Z3I0ZDllTld2dG11cERIVklHeWxWd2wwdU0yQTJJaFhUSzIrN2ZDRStVM1VQ?=
 =?utf-8?B?Nzdwa3ZTR29NeVhxYVFzNDJ3R3hpaUNmMDdGYXlmVHVTdVNvdU1XUGlLT2Ns?=
 =?utf-8?B?VytobC9xRnZQS2RkT2JvbzlDT1V1QUVlNEt3OWVJMWVoWWRIRzlKZDMzRjJW?=
 =?utf-8?B?THFmZkpaNXVXb3V6NWMrcEhPS25yRnp5eGVJWFlZcHUwNmZOM1BpZG4wWjM2?=
 =?utf-8?B?M0w0ZCtVcW5XNlJOOTVITFU2UWFXcmZ1ekhvaVFFbVI4UG5TNk11R1RPTDh1?=
 =?utf-8?B?VkdWUzl1b1BaVGtUTUphd0NBQ200YzV5eGdxR2hiV1lEWHdDckNhQzA0T3R4?=
 =?utf-8?B?dXZUMTdFTTJPMDdpU1ZOY1ppQ1pTdmVSQ1dmL3J3UU5teitDalU1Zzl1NjQ2?=
 =?utf-8?B?T3QxV3NJQlQrTEhENFpIVE40dVA1Vm8yL0JydWwvbGEzM1NRS0dIU1BhLzJL?=
 =?utf-8?B?UzBpMVo4eENwcFhxZlYzb2RLaVJkc1UvL2VHb01hWG5Va2poeU9vblBJd1Fk?=
 =?utf-8?B?bkRJTXFmbS9kOE9yQ05tU0NoUFR0WHMxZDdFK3NRREVyQ2F2Q1E1Y1ZTT0dt?=
 =?utf-8?B?SDZsNUVES0gyQzhsbVkrTmRMeXBheFhGQVYwZUl2aWpzVW4wVXBGK3BZVkhD?=
 =?utf-8?B?ZUFjSkxkTm9lRWdqZW1vUW5oMHUvRWw4NkZSMmc0RkplMytWaHovYXYwaXNy?=
 =?utf-8?B?N2tMQ0Uya2cvalZXdjl2VWE4UkVGcit6TE9zMGNzcVdCRGNoZklUNnR2T0FB?=
 =?utf-8?B?d0RWVHZudGUrSmpsdHdEZDY5cGVQRGJtYnpTOUpNRHpxK3RNTFBrdXRPMm9n?=
 =?utf-8?B?MFJNZkUreWd4K0trMUhSbDhqdWFGeWFGSXdOWnMwSk9ZL3RLVFpDL3RXVHMw?=
 =?utf-8?Q?g5WHMdaQCO7G1qTr0KiXjBv5A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef55112-7fc7-4580-1c80-08dc42e35b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 22:25:44.1678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGfQ9BSVJL29Hvp+9bMroQRzp5LOXeXNtV4jPFGBsog9wd17fK80I1d4FyAlpx/HKrh0eWy1jcMJeMTrfpVzrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgTWFyY2ggMTIsIDIwMjQgNDoyNyBBTQ0KPiBUbzogS2ltLCBEb25nd29uIDxkb25n
d29uLmtpbUBpbnRlbC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2M10gdWkvZ3RrOiBmbHVzaCBkaXNwbGF5IHBpcGVsaW5lIGJlZm9yZSBz
YXZpbmcgdm1zdGF0ZSB3aGVuDQo+IGJsb2I9dHJ1ZQ0KPiANCj4gSGkNCj4gDQo+IE9uIFRodSwg
TWFyIDcsIDIwMjQgYXQgMjoyN+KAr0FNIDxkb25nd29uLmtpbUBpbnRlbC5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gRnJvbTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPg0K
PiA+IElmIHRoZSBndWVzdCBzdGF0ZSBpcyBwYXVzZWQgYmVmb3JlIGl0IGdldHMgYSByZXNwb25z
ZSBmb3IgdGhlIGN1cnJlbnQNCj4gPiBzY2Fub3V0IGZyYW1lIHN1Ym1pc3Npb24gKHJlc291cmNl
LWZsdXNoKSwgaXQgd29uJ3QgZmx1c2ggbmV3IGZyYW1lcw0KPiA+IGFmdGVyIGJlaW5nIHJlc3Rv
cmVkIGFzIGl0IHN0aWxsIHdhaXRzIGZvciB0aGUgb2xkIHJlc3BvbnNlLCB3aGljaCBpcw0KPiA+
IGFjY2VwdGVkIGFzIGEgc2Nhbm91dCByZW5kZXIgZG9uZSBzaWduYWwuIFNvIGl0J3MgbmVlZGVk
IHRvIHVuYmxvY2sNCj4gPiB0aGUgY3VycmVudCBzY2Fub3V0IHJlbmRlciBwaXBlbGluZSBiZWZv
cmUgdGhlIHJ1biBzdGF0ZSBpcyBjaGFuZ2VkIHRvDQo+ID4gbWFrZSBzdXJlIHRoZSBndWVzdCBy
ZWNlaXZlcyB0aGUgcmVzcG9uc2UgZm9yIHRoZSBjdXJyZW50IGZyYW1lDQo+ID4gc3VibWlzc2lv
bi4NCj4gPg0KPiA+IHYyOiBHaXZpbmcgc29tZSB0aW1lIGZvciB0aGUgZmVuY2UgdG8gYmUgc2ln
bmFsZWQgYmVmb3JlIGZsdXNoaW5nDQo+ID4gICAgIHRoZSBwaXBlbGluZQ0KPiA+DQo+ID4gdjM6
IFByZXZlbnQgcmVkdW5kYW50IGNhbGwgb2YgZ2RfaHdfZ2xfZmx1c2hlZCBieSBjaGVja2luZyBk
bWFidWYNCj4gPiAgICAgYW5kIGZlbmNlX2ZkID49IDAgaW4gaXQgKGUuZy4gZHVyaW5nIGFuZCBh
ZnRlciBlZ2xDbGllbnRXYWl0U3luYw0KPiA+ICAgICBpbiBnZF9jaGFuZ2VfcnVuc3RhdGUpLg0K
PiA+DQo+ID4gICAgIERlc3Ryb3kgc3luYyBvYmplY3QgbGF0ZXIgaW4gZ2RfaHdfZmxfZmx1c2hl
ZA0KPiA+DQo+ID4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRo
YXQuY29tPg0KPiA+IENjOiBWaXZlayBLYXNpcmVkZHkgPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNv
bT4NCj4gPiAtLS0NCj4gPiAgdWkvZWdsLWhlbHBlcnMuYyB8ICAyIC0tDQo+ID4gIHVpL2d0ay5j
ICAgICAgICAgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS91aS9lZ2wtaGVscGVycy5jIGIvdWkvZWdsLWhlbHBlcnMuYyBpbmRleA0KPiA+
IDNkMTlkYmUzODIuLmE3N2Y5ZTU3ZDkgMTAwNjQ0DQo+ID4gLS0tIGEvdWkvZWdsLWhlbHBlcnMu
Yw0KPiA+ICsrKyBiL3VpL2VnbC1oZWxwZXJzLmMNCj4gPiBAQCAtMzg1LDggKzM4NSw2IEBAIHZv
aWQgZWdsX2RtYWJ1Zl9jcmVhdGVfZmVuY2UoUWVtdURtYUJ1Zg0KPiAqZG1hYnVmKQ0KPiA+ICAg
ICAgaWYgKGRtYWJ1Zi0+c3luYykgew0KPiANCj4gV2UgbWF5IHdhbnQgdG8gY2hlY2sgdGhhdCBu
byBmZW5jZV9mZCBleGlzdHMgYmVmb3JlLCB0byBhdm9pZCBsZWFrcy4NCg0KW0tpbSwgRG9uZ3dv
bl0gIE9LDQo+IA0KPiBJIGFsc28gbm90aWNlIHRoYXQgZmVuY2VfZmQgaXMgaW5pdGlhbGl6ZWQg
d2l0aCAwIGluIHZmaW9fZGlzcGxheV9nZXRfZG1hYnVmKCkuIEl0DQo+IHdvdWxkIHByb2JhYmx5
IG1ha2Ugc2Vuc2UgdG8gaW50cm9kdWNlIGZ1bmN0aW9ucyB0byBhbGxvY2F0ZSwgc2V0IGFuZCBn
ZXQgZmllbGRzDQo+IGZyb20gUWVtdURtYUJ1ZiBhbmQgbWFrZSB0aGUgc3RydWN0IHByaXZhdGUs
IGFzIGl0IGlzIHRvbyBlYXN5IHRvIGRvIGEgd3JvbmcNCj4gaW5pdGlhbGl6YXRpb24uLi4NCltL
aW0sIERvbmd3b25dIFllYWggSSB3aWxsIGxvb2sgaW50byB0aGlzLg0KPiANCj4gDQo+ID4gICAg
ICAgICAgZG1hYnVmLT5mZW5jZV9mZCA9IGVnbER1cE5hdGl2ZUZlbmNlRkRBTkRST0lEKHFlbXVf
ZWdsX2Rpc3BsYXksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRtYWJ1Zi0+c3luYyk7DQo+ID4gLSAgICAgICAgZWdsRGVzdHJveVN5
bmNLSFIocWVtdV9lZ2xfZGlzcGxheSwgZG1hYnVmLT5zeW5jKTsNCj4gPiAtICAgICAgICBkbWFi
dWYtPnN5bmMgPSBOVUxMOw0KPiA+ICAgICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvdWkvZ3RrLmMgYi91aS9ndGsuYw0KPiA+IGluZGV4IDgxMGQ3ZmM3OTYuLmVhY2E4OTBjYmEg
MTAwNjQ0DQo+ID4gLS0tIGEvdWkvZ3RrLmMNCj4gPiArKysgYi91aS9ndGsuYw0KPiA+IEBAIC01
OTcsMTAgKzU5NywxNCBAQCB2b2lkIGdkX2h3X2dsX2ZsdXNoZWQodm9pZCAqdmNvbikNCj4gPiAg
ICAgIFZpcnR1YWxDb25zb2xlICp2YyA9IHZjb247DQo+ID4gICAgICBRZW11RG1hQnVmICpkbWFi
dWYgPSB2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1ZjsNCj4gPg0KPiA+IC0gICAgcWVtdV9zZXRfZmRf
aGFuZGxlcihkbWFidWYtPmZlbmNlX2ZkLCBOVUxMLCBOVUxMLCBOVUxMKTsNCj4gPiAtICAgIGNs
b3NlKGRtYWJ1Zi0+ZmVuY2VfZmQpOw0KPiA+IC0gICAgZG1hYnVmLT5mZW5jZV9mZCA9IC0xOw0K
PiA+IC0gICAgZ3JhcGhpY19od19nbF9ibG9jayh2Yy0+Z2Z4LmRjbC5jb24sIGZhbHNlKTsNCj4g
PiArICAgIGlmIChkbWFidWYgJiYgZG1hYnVmLT5mZW5jZV9mZCA+PSAwKSB7DQo+IA0KPiBJdCBt
YXkgaGF2ZSBmYWlsZWQgdG8gY3JlYXRlIHRoZSBmZW5jZV9mZCwgYnV0IHN1Y2NlZWRlZCBpbiBj
cmVhdGluZyB0aGUgc3luYywgaW4NCj4gd2hpY2ggY2FzZSBpdCB3aWxsIGxlYWsgdGhlIHN5bmMu
DQo+IA0KPiBCdHcsIGNhbid0IHRoZSBmZW5jZV9mZCBiZSBjcmVhdGVkIGF0IHRoZSBzYW1lIHRp
bWUgYXMgdGhlIHN5bmMgaW5zdGVhZCBvZg0KPiBoYXZpbmcgdHdvIGZ1bmN0aW9ucz8NCltLaW0s
IERvbmd3b25dIEkgd2lsbCB0YWtlIGEgbG9vay4gDQo+IA0KPiBJIGFsc28gbm90aWNlZCB0aGF0
IGZlbmNlZF9mZCBpcyBpbmNvcnJlY3RseSBjaGVja2VkIGZvciA+IDAgaW5zdGVhZCBvZiA+PSAw
IGluIGd0ay0NCj4gZWdsLmMgYW5kIGd0ay1nbC1hcmVhLmMuIENhbiB5b3UgZml4IHRoYXQgYXMg
d2VsbD8NCltLaW0sIERvbmd3b25dIFN1cmUgSSB3aWxsIHdvcmsgb24gdjIgd2l0aCBzdWdnZXN0
ZWQgY2hhbmdlcy4NCg0KVGhhbmtzLA0KRFcNCg0KPiANCj4gPiArICAgICAgICBxZW11X3NldF9m
ZF9oYW5kbGVyKGRtYWJ1Zi0+ZmVuY2VfZmQsIE5VTEwsIE5VTEwsIE5VTEwpOw0KPiA+ICsgICAg
ICAgIGNsb3NlKGRtYWJ1Zi0+ZmVuY2VfZmQpOw0KPiA+ICsgICAgICAgIGRtYWJ1Zi0+ZmVuY2Vf
ZmQgPSAtMTsNCj4gPiArICAgICAgICBlZ2xEZXN0cm95U3luY0tIUihxZW11X2VnbF9kaXNwbGF5
LCBkbWFidWYtPnN5bmMpOw0KPiA+ICsgICAgICAgIGRtYWJ1Zi0+c3luYyA9IE5VTEw7DQo+ID4g
KyAgICAgICAgZ3JhcGhpY19od19nbF9ibG9jayh2Yy0+Z2Z4LmRjbC5jb24sIGZhbHNlKTsNCj4g
PiArICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gIC8qKiBEaXNwbGF5U3RhdGUgQ2FsbGJhY2tzIChv
cGVuZ2wgdmVyc2lvbikgKiovIEBAIC02NzgsNiArNjgyLDI1IEBADQo+ID4gc3RhdGljIGNvbnN0
IERpc3BsYXlHTEN0eE9wcyBlZ2xfY3R4X29wcyA9IHsgIHN0YXRpYyB2b2lkDQo+ID4gZ2RfY2hh
bmdlX3J1bnN0YXRlKHZvaWQgKm9wYXF1ZSwgYm9vbCBydW5uaW5nLCBSdW5TdGF0ZSBzdGF0ZSkg
IHsNCj4gPiAgICAgIEd0a0Rpc3BsYXlTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4gPiArICAgIGludCBp
Ow0KPiA+ICsNCj4gPiArICAgIGlmIChzdGF0ZSA9PSBSVU5fU1RBVEVfU0FWRV9WTSkgew0KPiA+
ICsgICAgICAgIGZvciAoaSA9IDA7IGkgPCBzLT5uYl92Y3M7IGkrKykgew0KPiA+ICsgICAgICAg
ICAgICBWaXJ0dWFsQ29uc29sZSAqdmMgPSAmcy0+dmNbaV07DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICBpZiAodmMtPmdmeC5ndWVzdF9mYi5kbWFidWYgJiYNCj4gPiArICAgICAgICAgICAgICAg
IHZjLT5nZnguZ3Vlc3RfZmIuZG1hYnVmLT5mZW5jZV9mZCA+PSAwKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICBlZ2xDbGllbnRXYWl0U3luYyhxZW11X2VnbF9kaXNwbGF5LA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdmMtPmdmeC5ndWVzdF9mYi5kbWFidWYtPnN5bmMs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFR0xfU1lOQ19GTFVTSF9D
T01NQU5EU19CSVRfS0hSLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MTAwMDAwMDAwKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAvKiBmb3JjZSBmbHVzaGlu
ZyBjdXJyZW50IHNjYW5vdXQgYmxvYiByZW5kZXJpbmcgcHJvY2Vzcw0KPiA+ICsgICAgICAgICAg
ICAgICAgICoganVzdCBpbiBjYXNlIHRoZSBmZW5jZSBpcyBzdGlsbCBub3Qgc2lnbmFsZWQgKi8N
Cj4gPiArICAgICAgICAgICAgICAgIGdkX2h3X2dsX2ZsdXNoZWQodmMpOw0KPiA+ICsgICAgICAg
ICAgICB9DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+DQo+ID4gICAgICBnZF91cGRh
dGVfY2FwdGlvbihzKTsNCj4gPiAgfQ0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gPg0KPiAN
Cj4gdGhhbmtzDQo+IA0KPiANCj4gLS0NCj4gTWFyYy1BbmRyw6kgTHVyZWF1DQo=

