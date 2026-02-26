Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D276F55451
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 06:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvUlu-0004wa-Je; Thu, 26 Feb 2026 01:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vvUlq-0004tA-Bs
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:22:46 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vvUlm-0007KJ-7n
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772086962; x=1803622962;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aLSef8O0yXE+ioEqxum26SivfRBTjpp+MYTt2RWN87M=;
 b=j6c6Qzqn1isARo9IewVylbkF1R/PHZUyJvudiHyM0uq/Rp1WXbjULrf+
 0Q0VPnX+Fuc0MCNCah4aMvADcK8HuBtlEzHa52JfR/c0PmfDJ5n5C3Wvs
 0JQELPHzos4pCXB4KcgtjKwAtOH915HhZkaTlMKDQXq9LpZiG5YzfTXRC
 jICaq4VXutjtfNPJxuVpCUoaSX03ZEV9/gCbF6v0eKQNDewxwuBHKcKPA
 1xaQ6tFV0vJTICKxQDuz5meUhZros7qnKGLDoTcbuXWa/iF00q58K8sBV
 izR+ppZmbjZpNwusYIr0BumopAPsPsxKsckBRT7zwxVAVuBhIIYbov6SN Q==;
X-CSE-ConnectionGUID: N9f0GJolTRyPIlcHg2EgJg==
X-CSE-MsgGUID: bauORZyaQ0ynNgxCw615Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73210591"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="73210591"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 22:22:38 -0800
X-CSE-ConnectionGUID: mrsOkqXVTkOWT4jrys3obw==
X-CSE-MsgGUID: /tmjlAqeRr66wloc6iRBNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="221447687"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 22:22:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Feb 2026 22:22:37 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Feb 2026 22:22:37 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 22:22:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn6Nm2sbSBrJ3kGgHqtc2NVSi0bESe32fBfndbZ/0vcD61p0IeSuN2WP5pvA0WGmOJn+EUMcWjBFz8sCBuGXM92mUvEy9MyyaxKathHd+9x0ErSEZgrr93tHC2Ofwzjkgnp3iAizcT+itD37rvYnQu/2kJr8r7mYbyG/t4tEsph2yP8ZVzb4dk5poIkO54gF8VHynowpxwc8KiMdYVtVG+ZGxXg6s+tgSx9/Ew4fAiiBkBpySAn8ygRgFdo3moeVPpV4rXvVYuy4EYje05xFusRhmiLwosOEvOUZbYyE/gmSTjjnHTVzIEVjKVsG+20FqrErg8oksCiFd+2kqyDQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dOL8riAc+KwBpSZSXhxzgouj9+5wBKnFUDc5ha4cQA=;
 b=Noo7JhR3YyQziGluKkdhzSB0k7zw7cqtuC/98pJKQ1N5FVjSpJL6vetRi5OjvQOeaAQgeeereru7sk7Kbm7hdYNmezr9AAtQG8CQBWe1QWUx+rEmrtxwkSuFFTtgZFB7p1mJbC4qXcE26AtWeYaw68ftKEH+zZt6Qz6xAtkvXGxzcUz9MuyoSPhfQuwQ51XV+Bh3sHMTFnOSo2sSh2Rvk3H5IE1TQ7r17XPLfXqIBCXRNuXlrqyzqHZ2Oec8JG5Q0Lz6UXYtlz4IPniGzSmbtq4p+V1q6Tcmp86IOgJu10e3VS03qPboWJHf7rMVxv+Osd+j/kIEoWxKsuR1ZMdH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 06:22:35 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 06:22:34 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v7 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v7 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcpJsL0c9wpUJoVEWe9i3pMi0k1bWROJ+AgAEtoFCAAIyRgIABFzfw
Date: Thu, 26 Feb 2026 06:22:34 +0000
Message-ID: <IA0PR11MB7185B641D5749566273C27E5F872A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260223080200.468558-1-vivek.kasireddy@intel.com>
 <20260223080200.468558-11-vivek.kasireddy@intel.com>
 <aa496278-274c-4fb1-bb47-bfdda7337628@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185F034A065CCE507F69F14F875A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <d2779f88-735e-4d14-9b5d-8577282c5477@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d2779f88-735e-4d14-9b5d-8577282c5477@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SJ2PR11MB8471:EE_
x-ms-office365-filtering-correlation-id: 5d91589a-e9ff-4176-9477-08de74ff6e4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: xI82HbjVfuhdvPchrphdnnQo0GHbfCiVFIydSgqglDNr6vs7xd8YebZkEFE7R7d1sWxgD58NcOKXxGpiFRzPjZ0Ki9WRPdWVu1OspQu+bUPtvEsjGrfQiPy/Eg7F87UGYd0vcOIAHOTs5kNYfhXVbs6wW4U8CgSj78I9y2o43bnaaI72zjRrZNaWWalf4yuV3VcZo9Mt+93VDQcPOLIruA4gczv9BeF0/tam7CPjonHvu5nnh9Inm6HU+nYVvP1BR6kDO87YY2n955IUcXZj0r0agPG1RqBFDgrTLQlp1pQvA/m7fu6OMOzpDcPGlKcG32YrUzWTC3kHyzVX0gkHkXpxw/Qlus1f/z2vLrAGBJRblJ9IOfZwEzgJOQSZaRP3gdznj07B/pZKqrqWb2+t6Za1T1hhaklYrxNpAmwTQL1f1NhBRZ2c8M3mJsHAe3YzBFglnzTeaXDiF2XTv2uuRLaBVvRT3OcoKUIbiZHfrJ7x/ISiDtg4Zqi3xvmWqEWnXaOudpQkc7URd3OkRCEhtbayGh/dQRg0lfTYd4l+FXYmo2qq+Sd30TsejGER1RgR5jp9CJy51eUR/6mWHUPPdsQn1IE7umRjXkvVPe2R0/7OZ2T9WbmPDiRUu6imEeeqwutA0En3tKNGEjuD5GtmDtppI0tC4Rc5yFkoN+hTO7JupWB3/lAbXPgyU3KUINQCAuUiQ8Ms3qSN/3YvQOG9YlImk98V+UV1OGievjyLsVQv1Os8xS2kmHIG3ZZ3yPuICxZ+ybXUSL+Gf5dp6c4uiHhQksNT9tmgxE8Wcu/9Jik=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K0iMnchtz9c06dtkEFawhapKly+3dwC7Nz86/yuzHp2PLEtWvzfzdIl9Qw?=
 =?iso-8859-1?Q?2nEhAYvRQAN9XVs9+qjyyYjT7k+eXOsd/cGuna5QF68eAwRFE91s+yp86P?=
 =?iso-8859-1?Q?g+g00onW3QPLR6PbUtqzameQDC+cE4s48vEBVn72F7rIyYqvjoClCI3p71?=
 =?iso-8859-1?Q?KPrp3JfB/AaunPUMlbzruIULYtVJb1mAoz0FQSMBvm0v4O9zasJu0v4s1k?=
 =?iso-8859-1?Q?fMcuKtvJZn/OaxBgt1iO2P0RUmb7bqjAhqv6BLjBoevgduoLn27GWIyOj0?=
 =?iso-8859-1?Q?rlCBO9vkcRs8bcHFDSAzUhyDeOJ2ZOcJykjjPoC+cBRegJR6ue52ajZz2K?=
 =?iso-8859-1?Q?qbW0aEAHtoF73Aa/c8bygc0BuLK8dE33LRPNT8bavz0SHggUhkpfirHNUo?=
 =?iso-8859-1?Q?b/6dr+STN1AsSSA/we2xn1J7XJkuZTwmGgiykV7wfjJyhAk97dzZ+KtPLn?=
 =?iso-8859-1?Q?OiTP1OpMFwUslQBtW7fT3LZvzcAYvCtfyWAH6UmqyJ1OcMNrxF345LTZHb?=
 =?iso-8859-1?Q?fYbaAM+cflB7n0I+kmXjDGkMantrPr5/zoNc5yQpD18Vhe3MwXHUO0XbD6?=
 =?iso-8859-1?Q?KyWOSoBpj44ACBoG88vpJOT2WejR9oMo4rzahxTbD/x1frqnmD7coDWqPQ?=
 =?iso-8859-1?Q?JwLR39a+IxqyGmy4hWjYpA+vF86O4gFOSa/nWuIlDv/dXwhNT18I5kSN9t?=
 =?iso-8859-1?Q?s/RsnTHmLRC4RG2tUtbHkMgw4SFfmXtbF+oZJkNrKlPIbP+JXTaKawnMbA?=
 =?iso-8859-1?Q?z1DTpm/FNAvEDdZMmKy6YyTZMFbxasYBBon340Byf2ZsWrSUhzX2dGP61U?=
 =?iso-8859-1?Q?f/eFr8RMnfGgYYibjOojxGFAhIq+fAnbNO+aCxr4mSjX59M592rexmVpT0?=
 =?iso-8859-1?Q?3OJn7pUlhUTgLsqdSsPm9xgAPVpkuQtJo+O5LIyzodyLcdlOXECUfPivxl?=
 =?iso-8859-1?Q?qatwr2BDk/cif8ksDelV5st1Xx+os5wryqIwFstiTT+74rTeOzUYo4lbLk?=
 =?iso-8859-1?Q?NVpR77S0tpyf2JCNxgumaBvB9fPyus5bExC1tUOo3HX5S3JIFVgV9YfVdt?=
 =?iso-8859-1?Q?Ml5baHA4WyL3ercKRT0vzyE83LmBYg0TrO9k0KzKbctuSjO3r5Q/s89e/v?=
 =?iso-8859-1?Q?MkG8X5+GRZ55pj7/3OnaGSlI5271rD9tYEwnif3WyF42zJ+ww7gBeJ0c+W?=
 =?iso-8859-1?Q?kgEUdxKcLbbMbm1cmSqCE4GxSsCY4uevGoyLbBL9kLZ5wTahtVf26WmnJG?=
 =?iso-8859-1?Q?ckPMXkFDoEbt8qovDZqvhsoFT+PSJYxm+A8LzMqZapoMgECvxbbpnITaz2?=
 =?iso-8859-1?Q?rgAIlSpBN2AYbfkYNX5s2eVNNfZ7CNEqlI1qQkYK+Ln6sBKCa5npCWFTo3?=
 =?iso-8859-1?Q?4T9A8nOlt7RKSIVxVXFb35NnTfj0Cgnv/F5jTUwN6W+dEyQaj4EBsiv+Vo?=
 =?iso-8859-1?Q?hdRB+S//E0JKynEoyfiQXgCJd6iZzKnahpv4WXWgBuRNUNuvRkwxrPhm7B?=
 =?iso-8859-1?Q?HrSFI4PcmDNo2TMB15vdcHpycYEH1anMnGqqtQUaE9qFBbgD8yQjPUBP41?=
 =?iso-8859-1?Q?4Wy2PBBseJsz5JRxhNs9ET9x5k8lIOlZkJigqOfF1MtPTrykEeWskCbflC?=
 =?iso-8859-1?Q?NsRS6/LoqgZdaRmiJwHCGPIiXRmQX9lVVH7YCnPjhidq5oiWesZknKSQO5?=
 =?iso-8859-1?Q?is5ZRRGXuj+r2KleO3QIfA7C8g6NyGNaZDg5hm8DlhiQIXFp1TIMfzEFX1?=
 =?iso-8859-1?Q?+LVtx9/AeWeE8uTHciCve1Cxb/M76VDquSCnocnnUbx4Hpvgzt/qlvSOH6?=
 =?iso-8859-1?Q?8X6vjg9BXQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d91589a-e9ff-4176-9477-08de74ff6e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 06:22:34.8609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeN4dFPF+vVMsvfcjaxkrosOuthuRyusRcuY1v6x6OtSAvR7jWgOwdV+03F2pvIr0mI7hfnXc52An2cg5lrPo4i3U32n88TbUHe/GgVD91E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v7 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> >>
> >> On 2026/02/23 17:00, Vivek Kasireddy wrote:
> >>> In addition to memfd, a blob resource can also have its backing
> >>> storage in a VFIO device region. Since, there is no effective way
> >>> to determine where the backing storage is located, we first try to
> >>> create a dmabuf assuming it is in memfd. If that fails, we try to
> >>> create a dmabuf assuming it is in VFIO device region.
> >>>
> >>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> >>> backing storage is located in a memfd or not. If it is not, we invoke
> >>> the vfio_device_create_dmabuf() API which identifies the right VFIO
> >>> device and eventually creates a dmabuf fd.
> >>>
> >>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> >>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>> fall back to the vfio_device_mmap_dmabuf() API to get a mapping
> >>> created for the dmabuf.
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/meson.build         |  1 +
> >>>    hw/display/vfio-dmabuf-stubs.c | 23 +++++++++++++++++++++++
> >>>    hw/display/virtio-gpu-dmabuf.c | 32 ++++++++++++++++++++++++--
> ---
> >> ---
> >>>    3 files changed, 48 insertions(+), 8 deletions(-)
> >>>    create mode 100644 hw/display/vfio-dmabuf-stubs.c
> >>>
> >>> diff --git a/hw/display/meson.build b/hw/display/meson.build
> >>> index f5f92b1068..7d2bd839cc 100644
> >>> --- a/hw/display/meson.build
> >>> +++ b/hw/display/meson.build
> >>> @@ -70,6 +70,7 @@ if
> >> config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >>>                        if_true: [files('virtio-gpu-base.c', 'virtio-g=
pu.c'), pixman])
> >>>      if host_os =3D=3D 'linux'
> >>>        virtio_gpu_ss.add(files('virtio-gpu-dmabuf.c'))
> >>> +    virtio_gpu_ss.add(when: 'CONFIG_VFIO', if_false: files('vfio-
> >> dmabuf-stubs.c'))
> >>>      else
> >>>        virtio_gpu_ss.add(files('virtio-gpu-dmabuf-stubs.c'))
> >>>      endif
> >>> diff --git a/hw/display/vfio-dmabuf-stubs.c b/hw/display/vfio-
> dmabuf-
> >> stubs.c
> >>> new file mode 100644
> >>> index 0000000000..12f016f0c5
> >>> --- /dev/null
> >>> +++ b/hw/display/vfio-dmabuf-stubs.c
> >>> @@ -0,0 +1,23 @@
> >>> +/*
> >>> + * Copyright (c) 2026 Intel and/or its affiliates.
> >>> + *
> >>> + * SPDX-License-Identifier: GPL-2.0-or-later
> >>> + */
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "qemu/error-report.h"
> >>> +#include "qemu/iov.h"
> >>> +
> >>> +bool vfio_device_create_dmabuf(struct iovec *iov, unsigned int
> >> iov_cnt,
> >>> +                               int *fd, Error **errp)
> >>> +{
> >>> +    error_setg(errp, "VFIO dmabuf support is not enabled");
> >>> +    return false;
> >>> +}
> >>> +
> >>> +bool vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int
> >> iov_cnt,
> >>> +                             void **addr, size_t total_size, Error *=
*errp)
> >>> +{
> >>> +    error_setg(errp, "VFIO mmap dmabuf support is not enabled");
> >>> +    return false;
> >>> +}
> >>
> >> This is VFIO's implementation and shouldn't be here. Follow what
> >> hw/vfio/iommufd-stubs.c, the previously-mentioned example, does.
> > Ok, I'll move this file to hw/vfio directory.
> >
> >>
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index fdcf8e53a2..3f39371de1 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -18,6 +18,7 @@
> >>>    #include "ui/console.h"
> >>>    #include "hw/virtio/virtio-gpu.h"
> >>>    #include "hw/virtio/virtio-gpu-pixman.h"
> >>> +#include "hw/vfio/vfio-device.h"
> >>>    #include "trace.h"
> >>>    #include "system/ramblock.h"
> >>>    #include "system/hostmem.h"
> >>> @@ -82,13 +83,21 @@ virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res, int *fd,
> >>>    static bool virtio_gpu_remap_dmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>>                                        Error **errp)
> >>>    {
> >>> +    Error *mmap_err =3D NULL;
> >>>        void *map;
> >>>
> >>>        map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> >> res->dmabuf_fd, 0);
> >>>        if (map =3D=3D MAP_FAILED) {
> >>> -        error_setg_errno(errp, errno, "dmabuf mmap failed");
> >>> +        error_setg_errno(&mmap_err, errno, "dmabuf mmap failed: ");
> >>>            res->remapped =3D NULL;
> >>> -        return false;
> >>> +
> >>> +        if (!vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> >>> +                                     res->blob_size, errp)) {
> >>> +            error_report_err(mmap_err);
> >>> +            return false;
> >>> +        }
> >>> +        error_free(mmap_err);
> >>> +        mmap_err =3D NULL;
> >>>        }
> >>>        res->remapped =3D map;
> >>>        return true;
> >>> @@ -145,7 +154,7 @@ bool virtio_gpu_have_udmabuf(void)
> >>>
> >>>    void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> *res)
> >>>    {
> >>> -    Error *local_err =3D NULL;
> >>> +    Error *local_err =3D NULL, *vfio_err =3D NULL;
> >>>        VirtIOGPUErrorType err;
> >>>        void *pdata =3D NULL;
> >>>        int fd;
> >>> @@ -158,12 +167,19 @@ void virtio_gpu_init_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>            err =3D virtio_gpu_create_udmabuf(res, &fd, &local_err);
> >>>            if (err !=3D VIRTIO_GPU_NO_ERROR) {
> >>>                error_prepend(&local_err, "Cannot create dmabuf: ");
> >>> -            if (err =3D=3D VIRTIO_GPU_GUEST_ERROR) {
> >>> -                qemu_log_mask(LOG_GUEST_ERROR,
> >>> -                              "Cannot create dmabuf: incompatible me=
m\n");
> >>> +
> >>> +            if (!vfio_device_create_dmabuf(res->iov, res->iov_cnt, &=
fd,
> >>> +                                           &vfio_err)) {
> >>> +                if (err =3D=3D VIRTIO_GPU_GUEST_ERROR) {
> >>> +                    qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                                  "Cannot create dmabuf: incompatibl=
e mem\n");
> >>
> >> This logic is faulty. err is not set by vfio_device_create_dmabuf(), s=
o
> >> it reports a guest error even when the memory is compatible with
> >> vfio_device_create_dmabuf() and it raised an error for a different
> >> reason.
> > Maybe I misunderstood your previous comment about this but I
> thought
> > we are going to assume that if both virtio_gpu_create_udmabuf() and
> > vfio_device_create_dmabuf() fail (assuming Guest error in case of
> > virtio_gpu_create_udmabuf ()) then it is reasonable to assume that
> Guest
> > is at fault for passing in incompatible memory addresses.
>=20
> It's not what I suggested. What I suggested is as follows:
>  > virtio_gpu_create_udmabuf(res);
>  > if (it turned out the memory is incompatible with udmabuf) {
>  >     virtio_gpu_create_vfio_dmabuf(res);
>  >     if (it turned out the memory is not backed by VFIO) {
>  >         qemu_log_mask(LOG_GUEST_ERROR, "incompatible\n");
>  >         return;
>  >     }
>  > }
>=20
> https://lore.kernel.org/qemu-devel/c7c03384-4815-4032-89bd-
> de1ef90bb949@rsg.ci.i.u-tokyo.ac.jp/
>=20
> It is not correct to assume vfio_device_create_dmabuf() is failed due to
> a guest error when virtio_gpu_create_udmabuf(). For example, when
> mmap()
> fails in vfio_device_mmap_dmabuf(), it is a host error, and reporting a
> guest error in the case is a bug.
>=20
> >
> > However, in order to fix this properly, I think we would have to have
> > vfio_device_create_dmabuf() return VIRTIO_GPU_GUEST/HOST_ERROR
> > (or something equivalent) which I was trying to avoid. Do you see any
> > other proper way to fix this issue without messing with the return type
> > of vfio_device_create_dmabuf()?
> >
> > The reason why I am hesitant to make vfio_device_create_dmabuf()
> return
> > Guest/Host error is because a future user of this API may not need this
> info.
>=20
> A future user may not need it, but we need it to make this code bug-free.
Ok, I plan to add the following enum and make it available to VFIO and
virtio-gpu-dmabuf.c:
typedef enum DmabufCreateErrorType {
    DMABUF_CREATE_NO_ERROR =3D 1,
    /* Guest is responsible for this error */
    DMABUF_CREATE_GUEST_ERROR =3D -1,
    /* Host is at fault for this error */
    DMABUF_CREATE_HOST_ERROR =3D -2,
} DmabufCreateErrorType;

Is the naming OK? And, what would be a good location (header) to have this =
in?

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>> +                }
> >>> +                error_report_err(local_err);
> >>> +                error_report_err(vfio_err);
> >>> +                return;
> >>>                }
> >>> -            error_report_err(local_err);
> >>> -            return;
> >>> +            error_free(local_err);
> >>> +            local_err =3D NULL;
> >>>            }
> >>>
> >>>            res->dmabuf_fd =3D fd;
> >


