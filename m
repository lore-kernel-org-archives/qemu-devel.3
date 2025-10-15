Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED543CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8tXA-0008Fu-QX; Wed, 15 Oct 2025 00:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8tX4-0008Fe-J5
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 00:54:38 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8tWy-00063P-Si
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 00:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760504073; x=1792040073;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kUCuzKJWMfJwminjai0FJqX4b6ypyhivKsr4LSfa6cY=;
 b=D0g/ppisA/6BHw4wZp07hE8urDQuD+t1TAzVgbqCAjINuHZnE9J/U+aK
 DYn9Cb6dtIlLhPC9V4IHkXmpfAfobZ97RXfOekM5uouMUOSmR5H7ALJwe
 j6mzP80GZqdrSqqcUdUzsZnFyZ1jnv5Y0cPkGdL8dJ+8SBT8fG14LvB73
 PfFBc3OznvMn0DZ7qfZoJi4lLZNf8C/wHpkxgNsNo8uvf0ywcfSaj6iiP
 WiMONqv6vSyA4Yzorj+8BwwYW97trolZhg1wbYZXmNoCIm2JxLlhaomTv
 VLPMa32JOfuY1EL+3m9UMoveXQibyKWKvTbOj52ugeEHuwWpJ9YLGx7Bq g==;
X-CSE-ConnectionGUID: uo2Ztf5xSwCZBAvn3T0ryQ==
X-CSE-MsgGUID: S+SgdWoRTCie2FUtVOndpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="88138226"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="88138226"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 21:54:23 -0700
X-CSE-ConnectionGUID: WMqfCv4zSuGZ63vLs401lA==
X-CSE-MsgGUID: 6odzYmGnSBygF0aIkfjrVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="205765319"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 21:54:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 21:54:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 21:54:22 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 21:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAz6L/hU7HgrCpdcXfZDrGO1hy57ubF2xIlMM/XXUMCJrEGw+E6EFzT9ItFwwEOfCgn/DtqBvHknceMljljqXChSukApDR/P3XE/y2n2pUvJXSQyR0bLYZ2o9hXVy2QmzdHPQ5Mq91y9D62w8DEbJI15azCdnrIKPogqoLVGnFwGQQhC1yE7uCBpJGYJlaD5vDprh3gqRPKeYH04wg4R7lhRN2bNtRRA1Ki+apcbzbLYslbLQ19ytlQtLdhyw1CngicvRML8q+NWKatPcJbrqEYGm1YXl0KvKICqX7dvqxt7gMIAErF7pICgwoz5pMTNBUbrlxlmgmYr1Nh+9jT9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tezxYKgHRBr/j3KohiJjAnG562IEA+PTyxtFB/o7KLE=;
 b=JvSHjYy3tR5P7ANSxXJmd293vDAu/3NaHYAlO4Kt3yXdWjvLuamF2fwtwMt8Z6dPhpdbX5pE9tLYyEXdbFFI8NbRpxJo+BG7WwzqBBukqrpmyOVtsxrnZeLQW9pdXvqMMOgpFKKINQRuWjjuu6k7CpeD3runFmqs8dUZx3hnk38xp17JJ7t762EkP/86YZRMzSJmn05JMM9FuO5MrqiVR3NyBpmvWuwxZ/yLw/ZS6rrT5nzEz7lK4V8/eD8s3sM0cJASsCnQXca0a0KuUrODhEVvjEseEUka/k+qJw3g+28VYnuh/ANXrvklVnvJWnpkqO+divnTIQMKCJcET0lYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH7PR11MB5957.namprd11.prod.outlook.com (2603:10b6:510:1e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 04:54:20 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 04:54:20 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcNL+QQn0dgmrpeUSObhHSZQs0bbS62gWAgAQvqwCAAhi+AIABa/KQ
Date: Wed, 15 Oct 2025 04:54:19 +0000
Message-ID: <IA0PR11MB7185DAAE7F0B9A2252311250F8E8A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-8-vivek.kasireddy@intel.com>
 <25cb995e-bb7f-4901-84e5-853d2a19b5c0@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71851DC9F2EE0B8E4914DB9CF8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ce7ba7b4-f008-4afc-a603-990ac6dfa8a5@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ce7ba7b4-f008-4afc-a603-990ac6dfa8a5@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH7PR11MB5957:EE_
x-ms-office365-filtering-correlation-id: 821849e5-916c-4a34-aa82-08de0ba6e6fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aeO62g1eEPfQa1L+SCPsWKLqGprsa5X5h4bhDsbqJobkpiIUNqUuZ8h1N7?=
 =?iso-8859-1?Q?T/wne9YmeKtbiXltqa7NvsIJlDTxRrOMlIrPwQ25qVCaob2yHuFmQA03LY?=
 =?iso-8859-1?Q?y5zNApVCARsqtJX1dw1/LFmooqsXIOOe8IjmPIy4ycxPaDGLITdq2DEvqM?=
 =?iso-8859-1?Q?rlfISCSStYoEGg6ilEnWI3n0ADXwUl4env11S3fOD62vA7YRhqDN4JHZa/?=
 =?iso-8859-1?Q?IOG4yh5wKxGalMYNBDWFlqgZ6F52dWqYK1/AdR2xRpdTNxBki4Xqx9i9dP?=
 =?iso-8859-1?Q?zR0vUmkgOWp+NVo8FqIs4LqHqQzz9TtGG7zRNGqSREwC7Hiz4FGNO4deZp?=
 =?iso-8859-1?Q?ufl1hCfAaZxoPKk7ap/cfAGNaueX0+XtPUSoHShunKcDQWrBDwX3ZAskcs?=
 =?iso-8859-1?Q?X6lx06RTaSu0EFI+N4Xppnv16Mez8HFZmPedSuByyTPLCz7+gtXVxAIxRH?=
 =?iso-8859-1?Q?+ZiAW35V4snwMfr9AcfUM8qZNDnPJ5xIdWPlgp+X67lLLXfeKm5ghPBmN+?=
 =?iso-8859-1?Q?Bm4ON3eRyqZgWUO13eS2NtVcK64Nw7opZ96RxQ2wtWYtf/TY6ltnc8x7Ni?=
 =?iso-8859-1?Q?381F0BBoIVKU0j7H8n6YSeL7vdZWmUVUrcLJ3aWgCGQL7cQj5hIZ4dYfGK?=
 =?iso-8859-1?Q?E/bjjnIG9/6LS5wO65AkiK8kZT+7uMHAhUAMjzBF89kKXmzQW6edUaNRtl?=
 =?iso-8859-1?Q?Suo46iRd3grsDc29kB0BfnOFuAwHhG/5mmHeN5fCDWqfMCBG8eChCEtAro?=
 =?iso-8859-1?Q?1T+ggjreJp62PP6MgCeQFpjlr0cXINZuAkwBWiCNcuW7vxpr2abvnN7Ix+?=
 =?iso-8859-1?Q?26VSWRWiATGAYNAluon4jFMk52JEyWw/UJz9tXUyTAtXJYLAOFVVZuT7Lm?=
 =?iso-8859-1?Q?O5tS7eWftEcbaVB1IwfDVSqX+JLr+WA/Ue8MT+SaZCvIzEVvNjsR4ehUSZ?=
 =?iso-8859-1?Q?u5k7ULdVLxfxk0CfQOl0cUNeqGbV4C9RotJuZK4l7Vzk3emdkUz0+rDaFU?=
 =?iso-8859-1?Q?UvBnN3o4av3IXIcvvavULpCIBT7GY2F35KoJ+uDPwL34YJRvtbCmXxsyY7?=
 =?iso-8859-1?Q?h4Ao0MkjZDvfD1F6J1BkrzzS3st/WbbMJGsvss47PpK0OaZk2ckELMid7f?=
 =?iso-8859-1?Q?OJhIqcBiZEycbefwWGsGhTC5Id/zpeNcilJ/R8K8hYmbTlFwDTC+/XXBri?=
 =?iso-8859-1?Q?kV/dvfTsGcg6ThYcIh44Fz56FTQA7+CPP3LXCCSXJXi8QTouEoVoNxl9Ph?=
 =?iso-8859-1?Q?TiJLCzfWvm4TndVbJ5AhhJIlfiHfdxuwIuQsB6ZKbm4Taedf7pvaWIhR2a?=
 =?iso-8859-1?Q?/6XERfVDdIE+Hy5uPq8zYNiVSmmxewQuXnuXPEYr4bf1czsx/YBRAqnnkD?=
 =?iso-8859-1?Q?3LUWzhXp69KtvWk12LmSwmpCjP0JvPk5jFPa+APM/oBadIJE1lsV8MJOm/?=
 =?iso-8859-1?Q?+EfLhbRMLBZI7KwZVGsnu8nQV9kzDoP/ZxYJDd58YNWEWXTGeig2sz8RJv?=
 =?iso-8859-1?Q?kGC7veD2A1/5zybwbaweLzCiXDo2I9xs2LHNnbz2IbEdUtc6YpPsVHvS7k?=
 =?iso-8859-1?Q?l8WP6UxqId+a/0LEPl4A3vTqEESI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SIPEkUA7IuG+6zm+XNGEDCcNJ/bC0CeSJK/lFKVpZmXOaXVWx71/vVvY4Y?=
 =?iso-8859-1?Q?wzB9TQApAENb8GzeAXaTYBaIWMXV3BgFbXGJKcoZMtiIRYHgJGvtVtYgt7?=
 =?iso-8859-1?Q?umJMOBpYb6vbqaD7sQ55R5KvWM6l0ijVF3FKRwoCxB69ncGCvkVOog5roS?=
 =?iso-8859-1?Q?Jf/bWj+ii90Xg0Jhf8M6WdeLwgVyJcAHAuusZyJAwfpfqalowpc9yZUHpd?=
 =?iso-8859-1?Q?2Yynw2aFeIfFJStayMp/CgQgQkWTCCJmMTNAOfePDqwBvd16zzGV8niK1n?=
 =?iso-8859-1?Q?x+WxT07zltQMZviE1DfJtXc0IZNDU/Xy5qOJkdnB/lBRfkb/uCVw8uSJOe?=
 =?iso-8859-1?Q?dD3z7hhphMVavXcI+NKV/nQuEDBWBtr+x4notbQ0Pi+r11AXvnNcSOVKmW?=
 =?iso-8859-1?Q?mEe6f/QDTDcWlGZhlNHQcF/b9jftqyklMtAAnldU8L+G2TfX9jTv9S9m1W?=
 =?iso-8859-1?Q?HfL6JGFypQShOhOvi8w6EVClfxBNXZJX0C8ZAd+9uDPIgknvKVhSFgfsOk?=
 =?iso-8859-1?Q?o7oOmgcR82Exwt39wiTuUWGyGhg3L/IPE6pEq04BgvYBPHMOm85K7FYRht?=
 =?iso-8859-1?Q?moFYyb3fn72Dmqw0FR0o8TC3tEVE+QgCZtzWosgCoTy6mg/CYMF05cNaCc?=
 =?iso-8859-1?Q?fQU4d7InNQs0+oEPQBdutxAPmnCaGhTJilIMaeWJY+0kdCKgnJVQaD3Cn+?=
 =?iso-8859-1?Q?+UEuf2Ch9g8PvLaD1Y6CBQRs7k1R2+zh3xMLeqCp6V54W+k4wokBZJ1/eI?=
 =?iso-8859-1?Q?MJuBzXreN33UYC/Jntqyx3siVEXjpbfe5tTPHwt5gc0yYOq7CR8ITztIbB?=
 =?iso-8859-1?Q?ejCEmQJDCtvzvWg/u7M3RFZ7kb07NWJz1Aml+JSJmuxVyPm1axJxuOB0ZM?=
 =?iso-8859-1?Q?Nfz8QkXUQ3+tQlVJRXhzCGHekRU2UFUBr4rAJJ0xKMcShfxOmw1K+QLrwh?=
 =?iso-8859-1?Q?GqS6pJGaVLaFW4ATUnHK3FLN4Je7le/rwqigbnbpE29grUflR7sqXg/V2D?=
 =?iso-8859-1?Q?FJzzZoNmaiQxprM1pW4TVoHHEi4fVUm/cumTczJzAR9IK0XWxuJ1nkzXvk?=
 =?iso-8859-1?Q?L/7T6zumc6NrOaahGGzK0agp9pc1SjlhpAWK7W6qWnrJYaAxCaY1DmHuaF?=
 =?iso-8859-1?Q?7ex2ZwGH/PSCrGN9jVDJKhxhyBF04Fbv1Dsfh/GyIyVt6qGpJcfYUG49YS?=
 =?iso-8859-1?Q?hFeCLXHWVA10tU0NMV7A2QEfKXqEOGxfe0P+WB3T5sDuSw9ndmnPMB4uH7?=
 =?iso-8859-1?Q?V5YbLgpM5VvuNPoamLF6OhdtDWVqyE2PbjcahHarPfqtL3eRQjqDVT0N6a?=
 =?iso-8859-1?Q?+rOqj0nkyWCuT/LxTlfBYqBgrvQtKT9s4dfxItBtgJR4eIUlvtxN+2rQkZ?=
 =?iso-8859-1?Q?ICndax/6jT79VsCG7Ah+V1zciJrAUFOHXWdEO1xgO6vgZkJZ5X7kju7T6n?=
 =?iso-8859-1?Q?0psUGnyP6wlsxFVPzpozhtUS/sJcsHmdw0OsnfSYmUnpdj4znX1QU1/pQX?=
 =?iso-8859-1?Q?FzSlGz8qkwjJJtyuOhtYDWYX7GLD8tj18HZ84iKuEToW5vlNn8rmwccApe?=
 =?iso-8859-1?Q?ksUC+htTCkFZhkvuY9kmSqUvNZyZXCnSdhDK0rU3oQk/pUmISTJWTHz2c0?=
 =?iso-8859-1?Q?cbSHZ8wp//VRzyDTs3uJBchyL5U9G9KTgd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821849e5-916c-4a34-aa82-08de0ba6e6fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 04:54:20.0508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZU8CwaWqK+Ku0hkuU3WYvqAkI5JNRa+AE/y0dV345fBssb+X3/RSuO0FNKYRKR1UwK0gTWPNvaxgGmf1xzv7K1erStYA7Vk6tT2z1W7O5hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5957
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Akihiko,

> Subject: Re: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 2025/10/13 16:00, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blob=
s
> >> associated with VFIO devices
> >>
> >> On 2025/10/04 8:36, Vivek Kasireddy wrote:
> >>> In addition to memfd, a blob resource can also have its backing
> >>> storage in a VFIO device region. Therefore, we first need to figure
> >>> out if the blob is backed by a VFIO device region or a memfd before
> >>> we can call the right API to get a dmabuf fd created.
> >>>
> >>> So, once we have the ramblock and the associated mr, we rely on
> >>> memory_region_is_ram_device() to tell us where the backing storage
> >>> is located. If the blob resource is VFIO backed, we try to find the
> >>> right VFIO device that contains the blob and then invoke the API
> >>> vfio_device_create_dmabuf().
> >>>
> >>> Note that in virtio_gpu_remap_udmabuf(), we first try to test if
> >>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>> use the VFIO device fd directly to create the CPU mapping.
> >>
> >> It is odd to handle VFIO DMA-BUF in a function named "udmabuf". The
> >> function and source file need to be renamed.
> > Ok, makes sense. I'll rename it accordingly.
> >
> >>
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/Kconfig              |   5 ++
> >>>    hw/display/virtio-gpu-udmabuf.c | 143
> >> ++++++++++++++++++++++++++++++--
> >>>    2 files changed, 141 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> >>> index 1e95ab28ef..0d090f25f5 100644
> >>> --- a/hw/display/Kconfig
> >>> +++ b/hw/display/Kconfig
> >>> @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >>>        depends on VIRTIO_PCI
> >>>        select VGA
> >>>
> >>> +config VIRTIO_GPU_VFIO_BLOB
> >>> +    bool
> >>> +    default y
> >>> +    depends on VFIO
> >>> +
> >>>    config VHOST_USER_GPU
> >>>        bool
> >>>        default y
> >>> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-
> >> udmabuf.c
> >>> index d804f321aa..bd06b4f300 100644
> >>> --- a/hw/display/virtio-gpu-udmabuf.c
> >>> +++ b/hw/display/virtio-gpu-udmabuf.c
> >>> @@ -18,6 +18,7 @@
> >>>    #include "ui/console.h"
> >>>    #include "hw/virtio/virtio-gpu.h"
> >>>    #include "hw/virtio/virtio-gpu-pixman.h"
> >>> +#include "hw/vfio/vfio-device.h"
> >>>    #include "trace.h"
> >>>    #include "system/ramblock.h"
> >>>    #include "system/hostmem.h"
> >>> @@ -27,6 +28,33 @@
> >>>    #include "standard-headers/linux/udmabuf.h"
> >>>    #include "standard-headers/drm/drm_fourcc.h"
> >>>
> >>> +static void vfio_create_dmabuf(VFIODevice *vdev,
> >>> +                               struct virtio_gpu_simple_resource *re=
s)
> >>> +{
> >>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> >>> +    res->dmabuf_fd =3D vfio_device_create_dmabuf(vdev, res->iov, res=
-
> >>> iov_cnt);
> >>> +    if (res->dmabuf_fd < 0) {
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> >>> +                      __func__, strerror(errno));
> >>> +    }
> >>> +#endif
> >>> +}
> >>> +
> >>> +static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
> >>> +{
> >>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> >>> +    VFIODevice *vdev;
> >>> +
> >>> +    QLIST_FOREACH(vdev, &vfio_device_list, next) {
> >>> +        if (vdev->dev =3D=3D mr->dev) {
> >>> +            return vdev;
> >>> +        }
> >>> +    }
> >>> +#endif
> >>> +    return NULL;
> >>> +}
> >>> +
> >>>    static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource
> >> *res)
> >>>    {
> >>>        struct udmabuf_create_list *list;
> >>> @@ -68,11 +96,73 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>        g_free(list);
> >>>    }
> >>>
> >>> -static void virtio_gpu_remap_udmabuf(struct
> virtio_gpu_simple_resource
> >> *res)
> >>> +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res=
,
> >>> +                              VFIODevice *vdev)
> >>> +{
> >>> +    struct vfio_region_info *info;
> >>> +    ram_addr_t offset, len =3D 0;
> >>> +    void *map, *submap;
> >>> +    int i, ret =3D -1;
> >>> +    RAMBlock *rb;
> >>> +
> >>> +    /*
> >>> +     * We first reserve a contiguous chunk of address space for the =
entire
> >>> +     * dmabuf, then replace it with smaller mappings that correspond=
 to
> the
> >>> +     * individual segments of the dmabuf.
> >>> +     */
> >>> +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, vdev-
> >>> fd, 0);
> >>> +    if (map =3D=3D MAP_FAILED) {
> >>> +        return map;
> >>> +    }
> >>> +
> >>> +    for (i =3D 0; i < res->iov_cnt; i++) {
> >>> +        rcu_read_lock();
> >>> +        rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> >>> +        rcu_read_unlock();
> >>
> >> I don't think this RCU lock is necessary. The documentation of
> >> qemu_ram_block_from_host() says:
> >>   > By the time this function returns, the returned pointer is not
> >>   > protected by RCU anymore.  If the caller is not within an RCU crit=
ical
> >>   > section and does not hold the BQL, it must have other means of
> >>   > protecting the pointer, such as a reference to the memory region t=
hat
> >>   > owns the RAMBlock.
> >>
> >> This function is called with the BQL held, and a reference to the memo=
ry
> >> region is also taken in virtio_gpu_dma_memory_map().
> > I agree. I'll remove the RCU lock.
> >
> >>
> >>> +
> >>> +        if (!rb) {
> >>> +            goto err;
> >>> +        }
> >>> +
> >>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> >>> +        ret =3D vfio_get_region_index_from_mr(rb->mr);
> >>> +        if (ret < 0) {
> >>> +            goto err;
> >>> +        }
> >>> +
> >>> +        ret =3D vfio_device_get_region_info(vdev, ret, &info);
> >>> +#endif
> >>> +        if (ret < 0) {
> >>> +            goto err;
> >>> +        }
> >>> +
> >>> +        submap =3D mmap(map + len, res->iov[i].iov_len, PROT_READ,
> >>> +                      MAP_SHARED | MAP_FIXED, vdev->fd,
> >>> +                      info->offset + offset);
> >>> +        if (submap =3D=3D MAP_FAILED) {
> >>> +            goto err;
> >>> +        }
> >>> +
> >>> +        len +=3D res->iov[i].iov_len;
> >>> +    }
> >>> +    return map;
> >>> +err:
> >>> +    munmap(map, res->blob_size);
> >>> +    return MAP_FAILED;
> >>> +}
> >>> +
> >>> +static void virtio_gpu_remap_udmabuf(struct
> virtio_gpu_simple_resource
> >> *res,
> >>> +                                     VFIODevice *vdev)
> >>>    {
> >>>        res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >>>                             MAP_SHARED, res->dmabuf_fd, 0);
> >>>        if (res->remapped =3D=3D MAP_FAILED) {
> >>> +        if (vdev) {
> >>> +            res->remapped =3D vfio_dmabuf_mmap(res, vdev);
> >>> +            if (res->remapped !=3D MAP_FAILED) {
> >>> +                return;
> >>> +            }
> >>> +        }
> >>>            warn_report("%s: dmabuf mmap failed: %s", __func__,
> >>>                        strerror(errno));
> >>>            res->remapped =3D NULL;
> >>> @@ -130,18 +220,59 @@ bool virtio_gpu_have_udmabuf(void)
> >>>
> >>>    void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *re=
s)
> >>>    {
> >>> +    VFIODevice *vdev =3D NULL;
> >>>        void *pdata =3D NULL;
> >>> +    ram_addr_t offset;
> >>> +    RAMBlock *rb;
> >>>
> >>>        res->dmabuf_fd =3D -1;
> >>>        if (res->iov_cnt =3D=3D 1 &&
> >>>            res->iov[0].iov_len < 4096) {
> >>>            pdata =3D res->iov[0].iov_base;
> >>>        } else {
> >>> -        virtio_gpu_create_udmabuf(res);
> >>> -        if (res->dmabuf_fd < 0) {
> >>> +        rcu_read_lock();
> >>> +        rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false,
> &offset);
> >>> +        rcu_read_unlock();
> >>> +
> >>> +        if (!rb) {
> >>> +            qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                          "%s: Could not find ram block for host add=
ress\n",
> >>> +                          __func__);
> >>>                return;
> >>>            }
> >>> -        virtio_gpu_remap_udmabuf(res);
> >>> +
> >>> +        if (memory_region_is_ram_device(rb->mr)) {
> >>> +            vdev =3D vfio_device_lookup(rb->mr);
> >>> +            if (!vdev) {
> >>> +                qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                              "%s: Could not find device to create d=
mabuf\n",
> >>> +                              __func__);
> >>> +                return;
> >>> +            }
> >>> +
> >>> +            vfio_create_dmabuf(vdev, res);
> >>> +            if (res->dmabuf_fd < 0) {
> >>> +                qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                              "%s: Could not create dmabuf from vfio=
 device\n",
> >>> +                              __func__);
> >>> +                return;
> >>> +            }
> >>> +        } else if (memory_region_is_ram(rb->mr) &&
> >> virtio_gpu_have_udmabuf()) {
> >>
> >> memory_region_is_ram_device() and memory_region_is_ram() should be
> >> called for all iov elements, not just the first one.
> > I am not sure if it is enforced anywhere but I don't think a dmabuf's
> > segments (or entries) can refer to multiple memory regions. AFAIK,
> > the buffer associated with a dmabuf exists entirely within a single
> > memory region. And, when it needs to be migrated, it is moved
> > completely.
>=20
> It should be explicitly enforced. Please refer to section "Unexpected
> Device Accesses" in: docs/devel/secure-coding-practices.rst
Ok, I'll add a helper function to check whether all the entries belong to
a single memory region or not.

Thanks,
Vivek

