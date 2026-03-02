Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A674D58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwNv-0002eK-Uo; Mon, 02 Mar 2026 01:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vwwNt-0002dz-RB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:04:01 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vwwNp-0003sb-7K
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772431438; x=1803967438;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=y1U0cE3fEBkMUMZDmAuiio/jV6vpXMAsGO6Shjq9JEU=;
 b=WHizf0ktRAMUqWJWLvWmAETL9ChcoyJQDT7Chsnnh7kxPmFEE5buGkn3
 b4CqrA2ssokci6q3D1S5Svv5JHb6D0nZzvDQdHpjGK9JebURYylIbkWY6
 ioNay25qoOFDgKaVujPvsAIqG6vYoi9vCB2uqlRc91gVkVXlgy/P/HoOu
 xs2aNoRIyiURKHuCFVcgbhcRPiQYs42WlsNPvgXR1NEcei52L2GVDeUVu
 oAmdNHCNqR7Dp/jU6pmTWqgk7kyfHWnIXCHh4mzXJ2l7ui/i/c2a6yL6N
 OM9p0hf7kLEaUuZPQyzFyWlxS9eAeKaYr53Cgvfl8LnjqgBHKZZfTZltB w==;
X-CSE-ConnectionGUID: tUNgCS/VSOK1zR9CFecxGw==
X-CSE-MsgGUID: REWYOw6zTz6X9PUJj/bUuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="77042200"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="77042200"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2026 22:03:53 -0800
X-CSE-ConnectionGUID: bzJeJBRaREOrkeJcRwCH1w==
X-CSE-MsgGUID: frIPHkZ+Qnavg5H83fQjdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="244663924"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2026 22:03:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 1 Mar 2026 22:03:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 1 Mar 2026 22:03:51 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 1 Mar 2026 22:03:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYrhEA6T1MEo5lTmdhqHMc5R5vfCvP6HjqDL/t9PSshXasJ90iSTXYIj+ik7sSbIzI1Plpw1XZ1sYhFgpRRJdGdXoxQpMbbYBqWAo/Ck5wFOmzlyQL4iHe5ZtdJgWt68Erf/zRlZs4kQDJaNKRMoaarUzpFPW8ayZAm86c69QFsuqmD8FaPvNZUzjmPfDNJF6BAb24qvtAtyt3DE14DzFCJ8dSqDzdDalDQnpWZ8OOJcVIK+TCW4o5W7mQ0jt/W524Igtx9FlmSD9G3JT+f6Ek/bG9kU4q9EoeXS7rHBjUzjdfjbo7JCULwHA/1rw+kcNqD+TANKH95n9AM7z7Gjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMgGMS5cp0160IUhzr/eO/OLfBUdFn5qVoQIO5WLyWc=;
 b=CCWxyh1T5hNJTXncqQwemrtWACHXhjqYmFt3kCEr53Ae/CT7HHyDLNzrbjkRT/j1Rka1YqWO6V3wo1r05PLhNAPW+JcRYo+h4Oret5Q70e+LX7huXwWsI5GLZRYYauLJBsz20mbAnwVWWep/l54XqT0unIW+XWmdSaz9qkH6BSAPFi0Vq8ZgVxENYbVJBE2nla9CdRVwrRmGgnq5grD0yK6w2mZ5VMJGFKSRIcEtLSyD8E1v0xRuRa0Y1TG/5NaKXzCDmEhRksw5UBxzADoFMWqKpk1BdlS6WoeODg4ovtehbpfyubHkV5e0P8bHFRXc9OYfwW4BPkF9oNYeZHEsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 06:03:49 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 06:03:49 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v8 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Topic: [PATCH v8 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Index: AQHcqDcy+xC9oS+I3U6DsxDUS0xBdLWXtaEAgALlrGA=
Date: Mon, 2 Mar 2026 06:03:48 +0000
Message-ID: <IA0PR11MB7185A75292BD4C70154A98CAF87EA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260227221632.827046-1-vivek.kasireddy@intel.com>
 <20260227221632.827046-10-vivek.kasireddy@intel.com>
 <daa04cc8-c2ae-43f7-8e5c-a2e6d44b1f50@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <daa04cc8-c2ae-43f7-8e5c-a2e6d44b1f50@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: 45302631-4af7-4cf4-be8d-08de782178d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: zyEp7mCdezDuFFV0rK42W3vqMvSlpcJTJv8wFC7zQuoxVvpyTp+8ywRtr9KvxME7zVBSJVkEntQz+u43AhWKLh4keoUzJ6x+3mnwPoWiVWHyNAFM4cfby+vMOPMHC9pd/24Dd5cu3kAHy96i2E3+ehJT5PSdVp92FE3blCd0B1NTyI7xne+qEF2tweNt3p0oYvTv9srQnJxxIdw8N2E3DOTI3oFTGajll3Dn8EO1PrPskIMFu8hHXcqzTpt7SLLKR/Kwg4d+GskjK2Aert4TIsD0DXXX9oRxMBsOm1Ctxatq1bI2VqlBlT0Mv+TalfmJQx8LaBiGDpXMD/r3K2ZqgqdV7QbXi0jzBYqyy20305cZ7HZKqrztAIISFDorgySL2w553Umjr8JJV+30t8zASTIXIXZGNq5oC044+wT39F1PNY2Sd0vAGLs0/L3XDxpB2feayqKFbPXn6Y+DgcTgV5R9N5JulypRTToplYJ68ypfG5/PSIRICBlETcwc9M/DrSKBMkEpfmUFKjuHQTIZvZMY3PoASIons6QkcaxMpHlO9YMDvEVxbGmkXDccq6U2pSrYc3ubO2uPHHR0x4sCbRZm9Bpyq3/raZsVjKDhun2itiHJ3b9HGX8u2dFBe0joKXOtylzzbjjM4ZosIW2ZsHGX2GQXZXWarUgVftwzHveyRWowhli0JTcNrvP1I0F8II474lY3ni3Ly4GyFkkx7fHDUjYkPL/ZkHwQUP7TvzydbROCGrT2aoXRXcnPMVNpd6w137i2vS6JlHa8o4lyKIkgLo+WsaJaBXMYKLAKkHI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8I+sz3yT5AYaGRqbdmVPPvz3IChKOBCZOhPL+ixHYUCuYxJeub+4Pmetbx?=
 =?iso-8859-1?Q?QkBRf2JkbwUFpXoweDblZViv1u/wBILjHk7TkrckuZS50ZifxrooydenyK?=
 =?iso-8859-1?Q?4ahBfmvQ4vPTzVgYoQ5yPKmfH+0Mk0xp20qVpL9HaOLhVvqOVak3WU5wMZ?=
 =?iso-8859-1?Q?oHvt9QMUbDOkaID57FJFN9WTvwnpYhgwYjkQ7NVXeh1aThkOoeRjSLk3Gf?=
 =?iso-8859-1?Q?8psFSmO2gMnTMT0lb6FjCo4enTlw1wAW8y9m6bX3jkEpGXlc61I+5qQbHH?=
 =?iso-8859-1?Q?mR1Sduxd4uSErFpO/USqfkNYXda4prwtXYF4kmCcrgEOoabcrvvN1ishnR?=
 =?iso-8859-1?Q?OkqkA5S65CgCHZVFnoxEt5lXUTlS674OCHdxVrKFpXPaogBcZWj8GbJyNW?=
 =?iso-8859-1?Q?vD7T4LgtV97mravlIW7ruG+C9GoxzVZC+z2znj2nS76hZxOIoFkwevLH19?=
 =?iso-8859-1?Q?+xHSr7G3YVrXp7vL2qXKQEGxfugyhNAEaxE2dVJ9kobnhMz0SAWuRtLVTK?=
 =?iso-8859-1?Q?lGdput6HvV9IHbAWjoDxRjga7rppS1KSf+oa9uxjRQBYBXeSWjI0f/bCgl?=
 =?iso-8859-1?Q?wiZpXJjVdj1Pahsxv6Jxc3Wn+b8ClkGgUdFAhsmO9xxZCNxZHrb1ccYHrl?=
 =?iso-8859-1?Q?uteLzRxv8jYG1rTabGBIBfV2Zt9X71yQErDdfdnWx6GHr+osrw3YyNN6l+?=
 =?iso-8859-1?Q?IlmtiWRUbAFltSMjFRgrolRpofJ8rCDGOaerbjrwxq1MUDzfEUb8tvZWUJ?=
 =?iso-8859-1?Q?IqB1ZV0N279DuPOIC7p4HyddgxFFfPV+siKpTz+/uojxuyLWVhByt85Uyh?=
 =?iso-8859-1?Q?u309CGo9qHCUOMXPWsir00HdPMcptYmQZ57mlyX+P5oOBz95HRGRzJ1NjV?=
 =?iso-8859-1?Q?WImeTUXb1PRfFXgX3zBDx43YN09PHxtartCAsTMWssLu3HGomiDfEVD7d3?=
 =?iso-8859-1?Q?VaYz9SQn7Va8ibSzolR6YDwLviM5hViUuh4T4+bvi2tiYdl8IqgO5m6FlL?=
 =?iso-8859-1?Q?oYwSCEn+o+epUTYBGO0Mz6f/E8QDHlNEV3YUZje1RKINdzLSscONseWSvX?=
 =?iso-8859-1?Q?lH2YFNtzTJWSC7g57f7Ok8/vLRceEc3y/gxszd3pEsy4tUDCzZf6xAMDx1?=
 =?iso-8859-1?Q?fpsjtlIFuTmdCNBriOMv85B1lGxFNT90WecEokMxr0fuj1o5um4SXbkoAs?=
 =?iso-8859-1?Q?kQXK8BXoKUScvTV1yIhkYHp/cQdjwldSm8kBV6JnT814nZrFMOrx5cRGq4?=
 =?iso-8859-1?Q?Mnd7485oOVw0NADYXvuERTW1seutC3FML9o14IZwMvxTXN3Yx+tOEsiKD4?=
 =?iso-8859-1?Q?mfOjoBD5OEx5OoLfC+93SgmZJs1E3lmzmGnbGRxcCGStHAtOGkJtho6ST/?=
 =?iso-8859-1?Q?VOOPgM96gt7Gg5vxSpR5VurW+vAm/LTPMvYtjxzSP5wJBT523VHQhYLm2y?=
 =?iso-8859-1?Q?l5CtEqepqV7B8GH2BtulCCpytwy7xovCsc9Oge2wjd6V80O4XbP1jR/IPl?=
 =?iso-8859-1?Q?0AfuqJyoOWwIXDI/P/Qqc8e1bPlDzvz0W06bQ39UC4WKxXcS5fGOQpV7dP?=
 =?iso-8859-1?Q?+w8BJMOKwsPm6gVSt/vfusL4rZa1CIMTuTFp+5zC04+d0cMlynWH839tYP?=
 =?iso-8859-1?Q?3V843O70aSeiStHJjXJQ3L7at0j9BrV/l709RTrMUE2eugjPrH/+IG4u3i?=
 =?iso-8859-1?Q?vCJ1tHAdv21U4KTqNOUTmIyp8zz/jwWmc7R97ashkB6b3FplEjHcVf97CC?=
 =?iso-8859-1?Q?VwJz0f610Zx3qnqdsqq8htImm81rNL+CZzrcSK39S6XhVeYpIO3HyAcAvO?=
 =?iso-8859-1?Q?AadqOxusbQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45302631-4af7-4cf4-be8d-08de782178d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 06:03:48.9281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4J9G9mEyezs/NR73DCoDxpGslLY5zMMh/58fXA+SD1TOwSXxJnjAVnKt4NwKIsmRQW4EXSxENi8Ix6y1SpmUkHXmkF8Ft+1qwrxpAnqgsqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v8 09/10] virtio-gpu-dmabuf: Improve error handling
> with 'Error **' and err enum
>=20
> On 2026/02/28 7:13, Vivek Kasireddy wrote:
> > Make the error handling more robust in virtio_gpu_init_udmabuf()
> > by introducing 'Error **' parameter to capture errors and using an
> > enum from VFIO to categorize Guest and Host errors. This allows
> > for better error reporting and handling of errors from
> > virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-dmabuf.c | 61 ++++++++++++++++++++++++-------
> ---
> >   1 file changed, 43 insertions(+), 18 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index 8d67ef7c2a..b2badfc1bd 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -18,6 +18,7 @@
> >   #include "ui/console.h"
> >   #include "hw/virtio/virtio-gpu.h"
> >   #include "hw/virtio/virtio-gpu-pixman.h"
> > +#include "hw/vfio/vfio-device.h"
> >   #include "trace.h"
> >   #include "system/ramblock.h"
> >   #include "system/hostmem.h"
> > @@ -27,16 +28,18 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > -static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> > +static int virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res,
> > +                                     Error **errp)
> >   {
> >       g_autofree struct udmabuf_create_list *list =3D NULL;
> >       RAMBlock *rb;
> >       ram_addr_t offset;
> > -    int udmabuf, i;
> > +    int udmabuf, i, fd;
> >
> >       udmabuf =3D udmabuf_fd();
> >       if (udmabuf < 0) {
> > -        return;
> > +        error_setg(errp, "udmabuf device not available or enabled");
> > +        return VFIO_DMABUF_CREATE_HOST_ERROR;
>=20
> I failed to point out one thing for naming of the enum. The name should
> express if the error is caused by invalid iov or something else. Then
> virtio-gpu decides how to recover the error; it's virtio-gpu who knows
> the iov is from the guest and decides to report a guest error, not vfio.
> Otherwise, it reports a host error.
So, it sounds like you are suggesting that there needs to be three enum
values:
enum {
    /* Guest is responsible for this error */
    VFIO_DMABUF_CREATE_GUEST_ERROR =3D -1,
    /* Guest is at fault as the IOVEC passed in is invalid */
    VFIO_DMABUF_CREATE_INVALID_IOV_ERROR =3D -2,
    /* Host is at fault for this error */
    VFIO_DMABUF_CREATE_HOST_ERROR =3D -3,
}

Or, please let me know in detail what changes you would like to see.

>=20
> >       }
> >
> >       list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> > @@ -45,7 +48,8 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       for (i =3D 0; i < res->iov_cnt; i++) {
> >           rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> >           if (!rb || rb->fd < 0) {
> > -            return;
> > +            error_setg(errp, "IOV memory address incompatible with
> udmabuf ");
> > +            return VFIO_DMABUF_CREATE_GUEST_ERROR;
> >           }
> >
> >           list->list[i].memfd  =3D rb->fd;
> > @@ -56,22 +60,30 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       list->count =3D res->iov_cnt;
> >       list->flags =3D UDMABUF_FLAGS_CLOEXEC;
> >
> > -    res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> > -    if (res->dmabuf_fd < 0) {
> > -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> > -                    strerror(errno));
> > +    fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> > +    if (fd < 0) {
> > +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl
> failed");
> > +        if (errno =3D=3D EINVAL || errno =3D=3D EBADFD) {
> > +            return VFIO_DMABUF_CREATE_GUEST_ERROR;
> > +        }
> > +        return VFIO_DMABUF_CREATE_HOST_ERROR;
> >       }
> > +    return fd;
> >   }
> >
> > -static void virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > +static bool virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res,
> > +                                    Error **errp)
> >   {
> > -    res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> > -                         MAP_SHARED, res->dmabuf_fd, 0);
> > -    if (res->remapped =3D=3D MAP_FAILED) {
> > -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> > -                    strerror(errno));
> > +    void *map;
> > +
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res-
> >dmabuf_fd, 0);
> > +    if (map =3D=3D MAP_FAILED) {
> > +        error_setg_errno(errp, errno, "dmabuf mmap failed");
> >           res->remapped =3D NULL;
> > +        return false;
> >       }
> > +    res->remapped =3D map;
> > +    return true;
> >   }
> >
> >   static void virtio_gpu_destroy_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > @@ -125,19 +137,32 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > +    Error *local_err =3D NULL;
> >       void *pdata =3D NULL;
> > +    int ret;
> >
> >       res->dmabuf_fd =3D -1;
> >       if (res->iov_cnt =3D=3D 1 &&
> >           res->iov[0].iov_len < 4096) {
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> > -        virtio_gpu_create_udmabuf(res);
> > -        if (res->dmabuf_fd < 0) {
> > +        ret =3D virtio_gpu_create_udmabuf(res, &local_err);
> > +        if (ret < 0) {
> > +            error_prepend(&local_err, "Cannot create dmabuf: ");
>=20
> This error_prepend() is redundant. The error messages
> virtio_gpu_create_udmabuf() emits already suggests they are problems
> with DMA-BUF.
Ok, I'll drop the error_prepend().

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> > +
> > +            if (ret =3D=3D VFIO_DMABUF_CREATE_GUEST_ERROR) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "Cannot create dmabuf: incompatible memo=
ry\n");
> > +                error_free(local_err);
> > +                return;
> > +            }
> > +            error_report_err(local_err);
> >               return;
> >           }
> > -        virtio_gpu_remap_dmabuf(res);
> > -        if (!res->remapped) {
> > +
> > +        res->dmabuf_fd =3D ret;
> > +        if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
> > +            error_report_err(local_err);
> >               return;
> >           }
> >           pdata =3D res->remapped;


