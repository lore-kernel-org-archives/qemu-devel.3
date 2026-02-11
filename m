Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A9BEB5969
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 06:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3pa-0002GZ-CB; Wed, 11 Feb 2026 01:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vq3pZ-0002Ft-Bt
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:36:09 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vq3pX-0004iY-Av
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770791767; x=1802327767;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fQG4KO+/bPNQyQ6c6UpRLjSNGI5/R8HfxiuXvv1s438=;
 b=SBOQJfff/byczU+9S1CawMw9R7eDLO9wyzqIBaTdvf2zhjG4s3ZzrEH4
 haJoqxFodjwDIzL+IL8D2prDspDesHmSSYqZefmfT839urTz/BhqirmUz
 ElKlJ6KEAtdMySntX6fSYr9+yMLFPHXYul/Osxi60kjw/2VTQANyMX+Qm
 wxxi65I/0kWxsyxALw0tu5vvywmNt7X2R0pnhclC+fzp/CWCyGdPoMWmR
 AhQ4Ou32LT7KZ5KdGagwdPkz05BlPnwhGmuWjV/QiQFf+YorsW6nOtYkZ
 k1RiQsDaGNpYit7tFXwHyHR8I8ih2oR20IvZ+IJHSIP+pwp4LHoM8BkKU w==;
X-CSE-ConnectionGUID: ngxBrpRsQwyE8pG4eEwpxA==
X-CSE-MsgGUID: rbzd7jYYRym2wMua4nys7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59499108"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="59499108"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:36:03 -0800
X-CSE-ConnectionGUID: vGgvIYH5TiufJp8kC7xp7Q==
X-CSE-MsgGUID: dDVq3JQtQ4yWwfWNUyJpnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216661044"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:36:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 22:36:02 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 22:36:02 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 22:36:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmjm/ZBhmgDBpLfDHL/WSuQfQHN5W96Ca+lgWCOusJBfXQuV5jv07eYFa7/oE557t5KEvEuW8Bb7TRI+yZCZW+v6jtAfMp2uSiDL2FPy4Cc45o0tnkVC5w0dvq6l8jqLHwOeB7Wha9MyNgMf69ERRFmkRBYfLg8J9Nvfj0e4ojzxIHLThN0ijCeU4kIDwFDnCe9w4nhvXnmk/W32FdsXuFkVRmqWMqmEWExmHhZSJgux+LdGTusSS/0JfqcWfeHwTGk77VmJJPp0eI5ehyOzB5LP3IIhAAHtwXcFxXe+yFcXk2ZDjqpcZPTOw22jlySvojHEEFsm++JHWMcGbNu8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9dMiioXou9UPSd7yuGG7JwUsX7WhuJdBrPYBt/5LWI=;
 b=iUMv1deblz1Rd2lGJB7y7zX0BND4E9Ug8YdkNhK7hoLVm9yWeVBXm6eQRYcxvkmmfbVME9EKdWmBovNEL4JfyzhoQpSNsaXFSd4QkhRHQNHog+dFQdGxR4kAzGcSIQW4ZNhCo0dnQSGhD3ANKJVtEVPFRGeziegf9S5fsojOVPgUU/vLxAziqZA+tLzSfMZywzLGN+4hv9Iaxrfrs2fkkufpn/DMwHnhH98d3N5fktWMT3+fzAbxUbF29g40nJU25IGgVzrFaiAkK+cDTvZSRJPLA3A39R9uMvCi4lk3O5g4+2O47r+A5pZUqAt6CeqQiIf6CJvQ/qcUzSacg7L0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA3PR11MB9112.namprd11.prod.outlook.com (2603:10b6:208:575::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 11 Feb
 2026 06:36:00 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 06:36:00 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v6 06/11] virtio-gpu-dmabuf: Improve error handling by
 introducing 'Error **'
Thread-Topic: [PATCH v6 06/11] virtio-gpu-dmabuf: Improve error handling by
 introducing 'Error **'
Thread-Index: AQHcmls54ahhVqRkakqKCJgDMCalvLV7ikcAgAA+8QCAAJeAAA==
Date: Wed, 11 Feb 2026 06:36:00 +0000
Message-ID: <IA0PR11MB7185118B6112220F36B0E44DF863A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
 <20260210070155.1176081-7-vivek.kasireddy@intel.com>
 <15ad210e-1464-461e-b113-7fa01f4ece3e@rsg.ci.i.u-tokyo.ac.jp>
 <854a98ca-6282-4c51-ac8e-e89487412f6c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <854a98ca-6282-4c51-ac8e-e89487412f6c@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA3PR11MB9112:EE_
x-ms-office365-filtering-correlation-id: 5deadaeb-53c7-4310-a4d4-08de6937d204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CN6BCDzPzcfoZNou9P66lET+FHHdvfX8nwCnviJZD+qk7bUeFEZKWenlj1?=
 =?iso-8859-1?Q?6gFTaIFfgOt65D4rXaRP5XeFrjbY65InHnmzyQ39QTDlEryxOWRxCTFo24?=
 =?iso-8859-1?Q?NiGV4RiZV/lwK6a0KCf+bhkaoAjbsTR6GCBzqju6wl03P4aMMwB7QdAPWR?=
 =?iso-8859-1?Q?rpFWLxHcVvl6IuvKZueNr+vIPuxxU7C0vtDJZ5Y43ngI/G7kMiNmXmxeqN?=
 =?iso-8859-1?Q?m4GSN8yMc2BV0XU+FS3l9MW1nRfzQM/HqpzQVer0+rgSohsEBQIQg95j2e?=
 =?iso-8859-1?Q?aJYtkucixPduCp9feDfnowngTBfgIqczd6F+6NyNhyjJfrPZyxJPafsqfZ?=
 =?iso-8859-1?Q?qpX4JovNBC3pIwM4xPWpzT9pFGQNg/fW1gDP4HGcTF6d4M8IKMADSX+hb2?=
 =?iso-8859-1?Q?ilPbmLGqorcfPh4HjplkWyMcIEmgGyb5RkD0HRCcZQdKMFsVzRLb/uSyjZ?=
 =?iso-8859-1?Q?Of+FP1+CWxKs8H8PiIGXThFCOHpuiZOE8y71ualFgi6RdhudnlfmLvgqpr?=
 =?iso-8859-1?Q?MIV8omYdzNRon6YD1YPcb0WqXE18JlunkpMMbNhnmkivWHFoxip+i7bL4o?=
 =?iso-8859-1?Q?XeeWIvdIvUPYrSlbOIYneCuWDDmQAe7DF27woK+wOs4bUXhuEtpN8gmJcP?=
 =?iso-8859-1?Q?yp5QbdILYf1SzbDRIUIuTM4rmCEz0ZlaaUv8lRd+Js6pEy5Z/nAQ1vYV0g?=
 =?iso-8859-1?Q?hhwB2WNZK/iREVan1nZLl9/KcvXdWrhdu42Lzl4PMzHTvCU5YW9vDaatPK?=
 =?iso-8859-1?Q?yC59pCeu2Yu79092QPkpK73695+DcorO4xfLzN7ZJ17SRiWEi2cojWZyVH?=
 =?iso-8859-1?Q?Vwqj2Z6BMp1/jKzrWagybwh8SJljBqOZEWZH/8X/S0XSmre+eBIKFzDbws?=
 =?iso-8859-1?Q?wgxtDGe8BhkZUA7deih4JLTCy0GDcDBQHL8Ia4zX2mBzM0o69D/JxkcHJa?=
 =?iso-8859-1?Q?aGPW9PhzM+6GRuRzujXupRqAgUzkNnR89GxWDrGzJJxDo8sLMHPIKox3RH?=
 =?iso-8859-1?Q?7dgOhrFXMg0sOjMOqOe9lgCjsr5GNsgq8Gd2BEjdskXZWqpuFHD5AZnMlA?=
 =?iso-8859-1?Q?uBW1nEYH/lHUuWsSgz3SJF8wrOtdJbe8RvzHaMFiEL8ETS012H71ZqlWXZ?=
 =?iso-8859-1?Q?F5wO8GH/1hdYzqmCnXwlbPbtpjkmhqfNh7U+eQl+l13P5tRlc9K4vlrMod?=
 =?iso-8859-1?Q?Bo5UIc5yUOMgV8lwS9x5Zz7M/YWWrEzze+LMxkjf8Op+SBEfcSXTz5gRJJ?=
 =?iso-8859-1?Q?5rjBgujzNtl5a+t7Bpbx7saV8JdpVlXTrvMLU67YPeSzKGMzy0TDFNI/Ka?=
 =?iso-8859-1?Q?BxROxiG2P6/0lhQk1oy8ngjxPu+aJ1qGLOvXi9xiBMMWd0xQyZxmp0AVBQ?=
 =?iso-8859-1?Q?JqRrpMLnk2qjLoaYDLzpw+z9F46klVdF5kc2NftdltkK8qJuqaMv78Gkqs?=
 =?iso-8859-1?Q?/CFOQUdQNOt5OuaGiJsbdBtDMc/YlG4DoZ54G2BQc8BL7hV0aG9LgtRdL1?=
 =?iso-8859-1?Q?fstbC/9eMK4wDkEM+1wpm3HCPf+Fp0Tm/J7sYVhfSAwhA/af6Kt01UPkPx?=
 =?iso-8859-1?Q?cGDsnU0M6VtRbtAXJgWJA+vRWQtsIgwkHKWEuqBcyf/gIDrgAL0dl3yLzI?=
 =?iso-8859-1?Q?VTr/jZtjGENz6r4YW9Ys9qHX3RGcj0UFB6FvvYf/7cHvtLuhJJts0kZNbH?=
 =?iso-8859-1?Q?YfGleW17r0zNlMC7A7Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lmlu2PdpRZKuREenPN9IZ2tL/H6rmEgKIVLXHVCOkYGTIYMRVRebUyplRR?=
 =?iso-8859-1?Q?6TG2b6V2fxO+ghgC+reBX6k4/BUblLfvdB6ZbK14QGuM+qn1z6/nlEmcH+?=
 =?iso-8859-1?Q?6XuicrcoQ/LEJtJBlIjnxpdbNFBVYq/gl6kXgOhrGtS/F0iCXHGpDriBWC?=
 =?iso-8859-1?Q?SxvrIEjVcB2B1VpvJyfjU17JKdIQbzma42vcrQSpDFR2exidyfOLZNNMfS?=
 =?iso-8859-1?Q?yjeeIdZ5x8RtDrVtL3Zpv3f8N/imP48k78o5NiLu0Cjki/k2f2PKTIJofO?=
 =?iso-8859-1?Q?LoibpCTV/hPFls/naIg0DYyylzHtCzPwg42iGpwXMAoGWbVDAw+Opv5yyB?=
 =?iso-8859-1?Q?o9EHQCZpGZLQZWFA8w6J1eC/9bV+CL0auiTMLUX8gHnbdE9EEmjrej1bMy?=
 =?iso-8859-1?Q?SdtnCJ10YKwwCYqeRZtBJ73rHU3uW5FXJSa4QntQhWFqSDHXFCanSW4JPp?=
 =?iso-8859-1?Q?7bQcas+nLrDj0MSOG9hmlxSlaSvMFMFFLp24RKYOxkNQPUcds+I0JFxZgP?=
 =?iso-8859-1?Q?dLbq/kE6ML6emB71uukuZDqnfD7/8yg5ZlGnjZnXje4veL+JuAm3VmIKnj?=
 =?iso-8859-1?Q?QxgQR9HDFOWKM4znAvJS+plrtugIYtIRzN2JJh3nqORo+pmpEslVKXbcvj?=
 =?iso-8859-1?Q?v8mk9z+e833XVz03M6XEA0IDovvRZX6NIXF7hP0c2Nwj3Dqy5EOHKdzpPj?=
 =?iso-8859-1?Q?hP+deJg+JSdrUk1/EivruhK2/wyOz+Cu2sX3yBAJTWn0eSTNGmrNJJ40Iq?=
 =?iso-8859-1?Q?gcOeAoyzKnJ82QDlFcBYbb+aXjlr4qcGLDz/Yqt3pc2cvWDczwHKDEdTLr?=
 =?iso-8859-1?Q?CxrwClimkc2cBIixmzInILzo5KWqZh2tJsBUvfPy6C+U+zC1k+mRLOOzEv?=
 =?iso-8859-1?Q?NdSMbO3i2+3VwI3zPcMThtYDkaEslCKbr6G5VrF9YcG4ac6OCvpVDIH65B?=
 =?iso-8859-1?Q?xykYjfwNHjz0Oo3kyOwF//M8K01jd1yK9uvFOpfl5ZhPvPBSfVw7GaR8HP?=
 =?iso-8859-1?Q?y7GiUgoKDyw45eAR7TdHLIwZsGwTg2bi4CHTmBnOitlkP6NDhBFwAdKBp1?=
 =?iso-8859-1?Q?ljXctXBkHtMxwyM+u0kNesT5Ie+p9OaS/H8adMKouKwyDlXeM73Hdj/4eD?=
 =?iso-8859-1?Q?/modybT12cxShc6bj8zsoRB3QlqAVK5Hb6ccUXs2jqPU4NKxe96vILh6nG?=
 =?iso-8859-1?Q?CUmg26giHIK/eJfwjZA/4BQEPDFBAugi46kKnpxSxVF7xsLTfvyK/RXn2m?=
 =?iso-8859-1?Q?5hkv8TAlcYR+T4ADZT0h+N7CU0nfz5iD3PyE4NJLvQeQq5QjTm+tL+hBDa?=
 =?iso-8859-1?Q?bycYocjfEh809syws0chRw9seNxqx2IaepQrB5dztvLkX8MNfsIfCKlATM?=
 =?iso-8859-1?Q?TqWpIt3gelgyvHDgogtw2YaELIPdePIgKOn2rih5nIQClL8rhou1YRuI2g?=
 =?iso-8859-1?Q?RmNnFYFnNWQxrUhka3wrxe3ONITn4J3kXxHpBchOa98oNDcLmKg0JI0AP9?=
 =?iso-8859-1?Q?jwCwLAi/sSTz432S3tcXjvNIGjcOlIZIrfdT8/GUTB3CLnLR4xWTWcD48l?=
 =?iso-8859-1?Q?cmQE1eEbocxUCAiT2AjpTOrYzdmqOHwmdsK+c6FcoezUHYJrO2pWN7YEVA?=
 =?iso-8859-1?Q?rJUR1x04tFclrAFA7pZRDQZxQnR/njeBzQJ2SRD3cthV/xr4JXPm8pxOzV?=
 =?iso-8859-1?Q?ozQT0XiSftr+KNcYr7lmLarWhprrrzVB7MOZ14kAqvnKtxPMS2UAAlqwZ7?=
 =?iso-8859-1?Q?777Rh2E95DPN5ZaUgG8xKV3Fymf8UjoCThNcC4eGH86bFz9dLNjZxKSky2?=
 =?iso-8859-1?Q?Gopb40vFZg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deadaeb-53c7-4310-a4d4-08de6937d204
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 06:36:00.0683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +wOGdrulCDt0k38lzWRN1DCgOimwReiutYUswaFsPGUPJp86YMLAcIkVmuC15yuZJB8v00SAnTUamC07Qh21JeHgC4UbQY69FJpkcQFgwvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9112
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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

Hi Akihiko,

> Subject: Re: [PATCH v6 06/11] virtio-gpu-dmabuf: Improve error
> handling by introducing 'Error **'
>=20
> >> Make the error handling more robust in virtio_gpu_init_udmabuf()
> >> by passing in 'Error **' parameter to capture errors from
> >> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> >> And, since they now take in 'Error **' parameter, have them
> >> return a bool to adhere to best practices.
> >>
> >> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> Cc: Alex Williamson <alex@shazbot.org>
> >> Cc: C=E9dric Le Goater <clg@redhat.com>
> >> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >> ---
> >> =A0 hw/display/virtio-gpu-dmabuf.c | 45 ++++++++++++++++++++++-------
> -----
> >> =A0 1 file changed, 30 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >> index 8d67ef7c2a..d9b2ecaf31 100644
> >> --- a/hw/display/virtio-gpu-dmabuf.c
> >> +++ b/hw/display/virtio-gpu-dmabuf.c
> >> @@ -27,7 +27,8 @@
> >> =A0 #include "standard-headers/linux/udmabuf.h"
> >> =A0 #include "standard-headers/drm/drm_fourcc.h"
> >> -static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >> +static bool virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Error **errp)
> >> =A0 {
> >> =A0=A0=A0=A0=A0 g_autofree struct udmabuf_create_list *list =3D NULL;
> >> =A0=A0=A0=A0=A0 RAMBlock *rb;
> >> @@ -36,7 +37,8 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >> =A0=A0=A0=A0=A0 udmabuf =3D udmabuf_fd();
> >> =A0=A0=A0=A0=A0 if (udmabuf < 0) {
> >> -=A0=A0=A0=A0=A0=A0=A0 return;
> >> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "udmabuf device not available"=
);
> >> +=A0=A0=A0=A0=A0=A0=A0 return false;
> >> =A0=A0=A0=A0=A0 }
> >> =A0=A0=A0=A0=A0 list =3D g_malloc0(sizeof(struct udmabuf_create_list) =
+
> >> @@ -45,7 +47,10 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >> =A0=A0=A0=A0=A0 for (i =3D 0; i < res->iov_cnt; i++) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 rb =3D qemu_ram_block_from_host(res->iov[i=
].iov_base, false,
> >> &offset);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!rb || rb->fd < 0) {
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_log_mask(LOG_GUEST_ERROR,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 "%s: Could not find valid ramblock\n",
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 __func__);
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;
>=20
> include/qapi/error.h suggests the following error handling pattern:
>  > Call a function, receive an error from it, and pass it to the caller
>  > - when the function returns a value that indicates failure, say
>  >   false:
>  >     if (!foo(arg, errp)) {
>  >         handle the error...
>  >     }
>=20
> Returning false without passing an error to the caller breaks it so
> please don't do that.
That's why I added an additional check in the caller:
                if (local_err) {                                           =
                                                                           =
                      =20
                    error_report_err(local_err);                           =
                                                                           =
                      =20
                }
Having said that, I am not sure what is the right thing to do here.
IMO, the proper way would be to add error_setg() but you mentioned
doing that would be incorrect given that this is a Guest error.
So, how should I proceed?

>=20
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 list->list[i].memfd=A0 =3D rb->fd;
> >> @@ -58,20 +63,26 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >> =A0=A0=A0=A0=A0 res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST,=
 list);
> >> =A0=A0=A0=A0=A0 if (res->dmabuf_fd < 0) {
> >> -=A0=A0=A0=A0=A0=A0=A0 warn_report("%s: UDMABUF_CREATE_LIST: %s", __fu=
nc__,
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 strerror(er=
rno));
> >> +=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, -res->dmabuf_fd,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 "Could not create dmabuf fd via udmabuf
> >> driver");
> >
> > This is a guest error since it indicates that the guest specified wrong
> > addresses.
I don't have a strong opinion here but my understanding is that this should
not be considered a Guest error because the rb (which we obtained using
Guest addresses) is valid at this point, so the UDMABUF_CREATE_LIST IOCTL
failure should be treated as a Host error.
Regardless, it is not clear how we can precisely determine who (Guest or Ho=
st)
is responsible for the failure here and in some other places.

Thanks,
Vivek

> >
> > Regards,
> > Akihiko Odaki
> >
> >> +=A0=A0=A0=A0=A0=A0=A0 return false;
> >> =A0=A0=A0=A0=A0 }
> >> +=A0=A0=A0 return true;
> >> =A0 }
> >> -static void virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource
> >> *res)
> >> +static bool virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource
> >> *res,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Error **errp)
> >> =A0 {
> >> -=A0=A0=A0 res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 MAP_SHARED, res->dmabuf_fd, 0);
> >> -=A0=A0=A0 if (res->remapped =3D=3D MAP_FAILED) {
> >> -=A0=A0=A0=A0=A0=A0=A0 warn_report("%s: dmabuf mmap failed: %s", __fun=
c__,
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 strerror(er=
rno));
> >> +=A0=A0=A0 void *map;
> >> +
> >> +=A0=A0=A0 map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> res-
> >> >dmabuf_fd, 0);
> >> +=A0=A0=A0 if (map =3D=3D MAP_FAILED) {
> >> +=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, errno, "dmabuf mmap fail=
ed");
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 res->remapped =3D NULL;
> >> +=A0=A0=A0=A0=A0=A0=A0 return false;
> >> =A0=A0=A0=A0=A0 }
> >> +=A0=A0=A0 res->remapped =3D map;
> >> +=A0=A0=A0 return true;
> >> =A0 }
> >> =A0 static void virtio_gpu_destroy_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >> @@ -125,6 +136,7 @@ bool virtio_gpu_have_udmabuf(void)
> >> =A0 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> *res)
> >> =A0 {
> >> +=A0=A0=A0 Error *local_err =3D NULL;
> >> =A0=A0=A0=A0=A0 void *pdata =3D NULL;
> >> =A0=A0=A0=A0=A0 res->dmabuf_fd =3D -1;
> >> @@ -132,12 +144,15 @@ void virtio_gpu_init_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 res->iov[0].iov_len < 4096) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 pdata =3D res->iov[0].iov_base;
> >> =A0=A0=A0=A0=A0 } else {
> >> -=A0=A0=A0=A0=A0=A0=A0 virtio_gpu_create_udmabuf(res);
> >> -=A0=A0=A0=A0=A0=A0=A0 if (res->dmabuf_fd < 0) {
> >> +=A0=A0=A0=A0=A0=A0=A0 if (!virtio_gpu_create_udmabuf(res, &local_err)=
) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (local_err) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report_err(local_=
err);
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >> -=A0=A0=A0=A0=A0=A0=A0 virtio_gpu_remap_dmabuf(res);
> >> -=A0=A0=A0=A0=A0=A0=A0 if (!res->remapped) {
> >> +
> >> +=A0=A0=A0=A0=A0=A0=A0 if (!virtio_gpu_remap_dmabuf(res, &local_err)) =
{
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report_err(local_err);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 pdata =3D res->remapped;
> >


