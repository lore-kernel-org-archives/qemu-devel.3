Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579AAF5545F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv80A-00032W-7K; Wed, 25 Feb 2026 01:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vv807-000326-Ox
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:03:59 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vv804-0001Xc-2d
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771999436; x=1803535436;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xgNY4RSUASsKjb7hdWac4cHBsneA9Ib/D19jvrguY6A=;
 b=ANuOgaKnfquXondqV897Ksoa8Cxrvxkgygiq5CmC+2KMI5AINz/qy3hI
 wub57mgoej09oZgZc/1A8wn3QfI3ScDDzRuA3M0RUtaVwQxD4vTq3JazU
 Xb2zssZMQ86Bn1PdGWSALOQlp1GVpXtJy2dVRM0/Gc44VEA7JhqmM7Eki
 rw4vuJPCFZGhLmpbRZ7UUyJy7ipDAvbwkX54rId9tlCHOp5RHpI6XJWL5
 Dcn+AG/GtYk2D5AIEFYOcLGWhcoA+RBfvMjIryKbamkJz2VdLeYqdpl0u
 IDoRHuUmuxGE6e7Obc7F+kpEI+/p/aYcaxOfbFg+5bi3xfiYrechauyWG w==;
X-CSE-ConnectionGUID: r+oVbUIkTJ+9ME5dYg4uog==
X-CSE-MsgGUID: UIonmMrmS8yBS32kxz92KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="98494200"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="98494200"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 22:03:52 -0800
X-CSE-ConnectionGUID: We9OlJMMQf6Oc4qB1XSchA==
X-CSE-MsgGUID: 8Vv4eZ6mR5umHeYB1tA/mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="243960957"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 22:03:52 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 22:03:51 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 22:03:51 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 22:03:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+AGY+wjTjmPMYkozL4Mu+0XHErifL3nW99c/M6t9GILkE3ynJvcSa1VjeEbvrJFBd0w+0iN2fKUccBxkZ+iwnE2oDKjxWvI/dczjnahHiJOP0fB9eeiE5pLEpSv+Sh57h+J7puhHpQvcXYv9WNExnc5B1yvMQftOwMACE2x10n0X++MiRxl4VnuVzqhA1SNl8PPfuJmmmiqjO4rStWx7cQYm4DVs2IO4dE/Xb3YLQBjElRG6y+ilPDsODpw8Vf+unF9F1YLaFNSFhbkFX41/yFxCehN1BhN0VuxfV1FespF5/nQkW+dLzBGRJlWAZjswHXQt9WrRJ3Hc3KSQtyP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM5qaAv2gvPGf7vVzkDgrJpqwu1ZBEYL1oz1gKV/OC4=;
 b=xwSvutrjhQnM2ex7C5hLjsRikzHggaucLxJwHc5E9JY+N53AUDqGiJQWLLi2QX1T+t3kkFeOS/TkUGT28d0Q+fQGXHuNLiTmTo5DANGQlQUcNEW71p/Fttjhr+ISJm8oQNud7lSo5GSVavBoWmsvmMf1POyEUxoRk3LPcBDVVGLS501Mo4CAR976nrJ+tbG0Kc0R2nsXsxq6otQJCd+qSTD1azv4hx65fGk14ykGYcoOL+doSTTKQx6KdoMnu6fSdlPQRLT2my3hJPkrx3s8ds87e4rvKfY0osUIVfJwpnBHGjXoDhAvTVqJLUFtOoJ22UChg4QSNwOco/dLFI9gAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH0PR11MB5927.namprd11.prod.outlook.com (2603:10b6:510:14e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 06:03:48 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:03:48 +0000
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
Thread-Index: AQHcpJsL0c9wpUJoVEWe9i3pMi0k1bWROJ+AgAEtoFA=
Date: Wed, 25 Feb 2026 06:03:48 +0000
Message-ID: <IA0PR11MB7185F034A065CCE507F69F14F875A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260223080200.468558-1-vivek.kasireddy@intel.com>
 <20260223080200.468558-11-vivek.kasireddy@intel.com>
 <aa496278-274c-4fb1-bb47-bfdda7337628@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aa496278-274c-4fb1-bb47-bfdda7337628@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH0PR11MB5927:EE_
x-ms-office365-filtering-correlation-id: 9cb1adce-6829-4a9b-082c-08de7433a487
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fmf2mVU/U3iRXT0UUT5+bOf37f1IsXCKl+YUgo4ql6iHEMtxwjvFUAkkwk?=
 =?iso-8859-1?Q?dfiAQG2RbUaYiVSJvn8/MPGJ8JMOWCM5NiexfAheSqay7yVEX9LXuBKN43?=
 =?iso-8859-1?Q?pLhcdBgRUyh8Fnn0LHA7/AoQe0bfi9cLEleqCwHbgI/otgqD+sNQgSvsw8?=
 =?iso-8859-1?Q?z4v99P5dWZja73pmNfNHTzRPZgtBKjAxzrLK0icZksIPG7d2BoJpsMWx4S?=
 =?iso-8859-1?Q?5lBnNvN9QOB2YRztjAtoi5c+i1UH3RhrTBq5yuy4fl1nrEGX5b3vg4fwWD?=
 =?iso-8859-1?Q?E8xuBt1R9EHb0rDvSnPmsSNQA1hpn7e6gzHEf7q6y0kDUFK8ZJcar/W9ge?=
 =?iso-8859-1?Q?xKWhIv7QSusGVZbLgrIxMavq+SAP4SQFyguC4cD0bvg0F4lwmOAf92N3qW?=
 =?iso-8859-1?Q?4e52JMzruMPzXbBd6HeHJjGNoKAMXCFtBKp86so+yTAFK4GwUUQg+o5lC/?=
 =?iso-8859-1?Q?lKRkBOla4wkaMyMLLUUO4zSOepck9tiZtozhpL5xRVygzJtWAVFne2ay1c?=
 =?iso-8859-1?Q?FVrW9rVOxVFHgI87L6NTcVD4pWGqHqEm4gW/qQPhcxWMB7slZ1n9ocroCX?=
 =?iso-8859-1?Q?ka9FWk7NIyNVopjT2S82/SxpUGbVKbwca/l1krEkAB4tUttPkkCrQZ+shc?=
 =?iso-8859-1?Q?mbxrzDAmWBvulRVQSK7zkacXN6GybxoZ5z/nHoZvOcXmPOoNDBW4xjLOxM?=
 =?iso-8859-1?Q?m7VsejNkiQVWZGmixtY0ISDmXDwrVKIDQJXcZCYek+7f0OL6T8/M0CLBMz?=
 =?iso-8859-1?Q?zfm5/ZLYecOzn13nJAQc+7kI6+qgDLK8rHWOfpeMqI9qrQEFzkWlt5yt/x?=
 =?iso-8859-1?Q?6cSbADmIxyXxM01QWFe5iwRRe3jafUb4Zw0qWis4kAuaPogPSkGtAWcGs4?=
 =?iso-8859-1?Q?ieFrQLwj1DHHCt4rDC5GGXMOBvX9KKivaTGj00miBhp6pU8Qh7tZo2H5mL?=
 =?iso-8859-1?Q?jZjTfQZ2hk5dJvTomGMRhwBchresPxUt6X7WmIjFt4CUQ8VwlWHaHTll2A?=
 =?iso-8859-1?Q?1FCPw6XG8pTyCBKygesc6ZMssSyaveXeuR3tfrYPqDSxcsE7VcmGhwqgth?=
 =?iso-8859-1?Q?SH100C/GfW4NeJRDeBD2IMIQq/V72tAAGzkv1qGWLDfEyLDUEpDyLkdKgW?=
 =?iso-8859-1?Q?qYDFE1BP32Z98CV0cyMzbME/CWvYRJxDV/lNBzOy7afJsfhCBchha9a/aF?=
 =?iso-8859-1?Q?RvvDg2R3FF+B/jp7jdspj2UXBCvcdV/7rCwxJUvcn3Gvlc9Tzkihth8t8x?=
 =?iso-8859-1?Q?w/M0/ZZokliuWCEMJd7NhCzBtu0qQ7npCXDSCVSopBZb28uO4WHsRkN85M?=
 =?iso-8859-1?Q?qWNcMdvSemn2UsHYiDZ8hZDIOaUoOUIV+cVp+AQqV7l40PxMFWbimyZbzI?=
 =?iso-8859-1?Q?vYiwjnkJhRJbN7ZMm/507kamxbVxPrGEjbT7fkRdm/k/oSnWe87EqlEqIT?=
 =?iso-8859-1?Q?WVe4fuuEAC0K7alQGJGBFknNAik3RcV6RTf741HVn9eSelW6DO5lWnFYIG?=
 =?iso-8859-1?Q?8MTiponctvUsCF5m2COfGzHndENDKpoIo1RoK4yWD43rslfyzKwytZbRIG?=
 =?iso-8859-1?Q?4Szxv3Q3cEnFD7op/3MCUvwHcCSEiLmgCdYvcSw6WB+9IWac+b39spBaLs?=
 =?iso-8859-1?Q?tFVW0ZxVWMHLRv9mQ/ujkU80bauxn+UM4ryE6qMyXQCiarUMCT0cOX0Vl/?=
 =?iso-8859-1?Q?DJO4E1VPsYCO+gctCBM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pwTimulv8TQOZXMbM83u3EPuPR0pYx9HTJEj6xRLFy27PUWkZO5TEjrnYH?=
 =?iso-8859-1?Q?gB0UWOauEmRzjLkuiNIYvFz3Uyek8XHPEWU3cUjGRm4Krz390k0YibltA7?=
 =?iso-8859-1?Q?Qeo0ZMqgyrv5aRaTcd3iCVf4dr1t+6hC6XW++owXDPVwhXlMLt7Ox37uxG?=
 =?iso-8859-1?Q?1noIDeTJav3O5z1v0y1EhehN5KTMuGGjn9Sn90rk/7tZnF8Uml+L5qHNmR?=
 =?iso-8859-1?Q?FcsviOyHmIfXOmuwgQIUMhNya+w834SsOJS6CJg7+SBAGnPo4pXFgPPzhg?=
 =?iso-8859-1?Q?P4+YdlR889jvPG/jXDBa3NWAb+FBuDaBcgTH51Age9+dlz3yC1936AUaik?=
 =?iso-8859-1?Q?4wHrgbQuNLqtL/Y1+myNnicRzcwFbwI98o4j/LnmYc7KJHFOj7Tjr1H0Lt?=
 =?iso-8859-1?Q?094J1z6Fx/M11B9Rm+iYqcPdeVCyzREMJXStOMr3JCriR8kj7thpEiv3Na?=
 =?iso-8859-1?Q?SGN+1f9K6Mpylg/sgN7fAMYlP6SVujpP/2HXtydnn5405uDdgyB2SS/G/J?=
 =?iso-8859-1?Q?q/DbEkjfaxlkrR1oWk1nHlt1oOMGQtsLD/7XQVsH0WgzsBVaQcfYYG9szM?=
 =?iso-8859-1?Q?hL71Q1CY77pWLS+xetYldwEsgYeZxBQsCF3shMlIoTV6xd6tSRTyacOCZm?=
 =?iso-8859-1?Q?4k9MAGoUvn1boSdoBWacZsrnmyV+dhoOGqgX4UsqL/AJlyOq3CJ0I16o5H?=
 =?iso-8859-1?Q?sQtu9kfxVTQRYF0sPJsJGRkbkU+uhi53/jZlvCpIn4S3P+FyXHJ7xjRUHa?=
 =?iso-8859-1?Q?LKb27DaD+nnBsqytlhKY18coRLzE2gAOv/bSyBb5TKCEE3eK7JtyitIjbM?=
 =?iso-8859-1?Q?Ir4altBEROQDJx4Aszq4zxjFAED8iMES8JNvee8iKp0YOrkBVLwNTVxbaV?=
 =?iso-8859-1?Q?sxTvNGcX13BUW45lG6/JgfRLvCpkNDjbnhj0bG5xX9WDBC69UcuU/RWDG8?=
 =?iso-8859-1?Q?2IjvmdCsFueha+H80glqlp8bf0Lv3FBd9KJb/pLTBq24E4S4SayZ00IyE2?=
 =?iso-8859-1?Q?sVXtnRTlE+ZNg5ar/0Chfvew/HPhNCaz44ZXbJFKphDxKRJCdZZEUJAWul?=
 =?iso-8859-1?Q?sBzrmlIBWfHCOCC8ZzKtuCbak+oYVcTXyoxSik2KfdMGshhD1onI6Iy23i?=
 =?iso-8859-1?Q?SxhhDlwBix4WTotD2/mxMjVh3BxbLEhQqOaLhlhp1LcGeeVGsUEPSMWSps?=
 =?iso-8859-1?Q?4LMp3SLcD4lC4KSDluG9EW6nUgtqw5V+YMkTC+O1SAb6+/B9Cp4d4i8xf3?=
 =?iso-8859-1?Q?xaxcpr5fbZ/+zH2kU4jnXQR9mNntsHd+paLpqWn9AQK7OPDk4/7TQSgHmu?=
 =?iso-8859-1?Q?iOo4cirFZdljQ1RrCocYo13mpTW30b35bikhxl+9eFoSk3zyxyGMhjIHk+?=
 =?iso-8859-1?Q?J7OdvtNq4er/tSXgKbQP+E4EWbTP1s4EDLMok9p95whVJnsCdmsr4XhDGf?=
 =?iso-8859-1?Q?4ytiAXR74dV4HHUevnCRoD7oM7bPAKctDWwWt0GSx4Vh0GBKT0vQioczuy?=
 =?iso-8859-1?Q?ePKmkS0qXmNf2wah+k/AReZ7sI5txJhewaR9PPBhdqnZf4bjXJyBAQSJDG?=
 =?iso-8859-1?Q?OYXt6lUHjPUy6dq+C/lW/vFR0XzyLogbVCNGgxYrHMuY0y1LSwX7wv6thv?=
 =?iso-8859-1?Q?S858epRA1gPq7z+noVtNPkrQZvstSIHG3dHRIgN13J17IUgcvWUgIfNZY8?=
 =?iso-8859-1?Q?R3LZl9T4YqobirfprtPTn/4/cMgTup+ylwXtp6x8jT43OlBddMR4Ydv1QJ?=
 =?iso-8859-1?Q?9r6VkJUjEBaNeva8nkVPryJCuMWjWDkZiG6fSnSz/8NL/P/YTBjSH+KCzK?=
 =?iso-8859-1?Q?ULz2r2GWpQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb1adce-6829-4a9b-082c-08de7433a487
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 06:03:48.5417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmTDmk5NcKeABBS2ronisQycS0oqm0rFSmZgnSakSt9BXOiqb5EqmgsNwDmOgvZe/5zAEQUl9Cq/qX1GAN/ZJhv8+icWFIsWNrtu/i4S0kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5927
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v7 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> On 2026/02/23 17:00, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Since, there is no effective way
> > to determine where the backing storage is located, we first try to
> > create a dmabuf assuming it is in memfd. If that fails, we try to
> > create a dmabuf assuming it is in VFIO device region.
> >
> > So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> > backing storage is located in a memfd or not. If it is not, we invoke
> > the vfio_device_create_dmabuf() API which identifies the right VFIO
> > device and eventually creates a dmabuf fd.
> >
> > Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> > the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> > fall back to the vfio_device_mmap_dmabuf() API to get a mapping
> > created for the dmabuf.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/meson.build         |  1 +
> >   hw/display/vfio-dmabuf-stubs.c | 23 +++++++++++++++++++++++
> >   hw/display/virtio-gpu-dmabuf.c | 32 ++++++++++++++++++++++++-----
> ---
> >   3 files changed, 48 insertions(+), 8 deletions(-)
> >   create mode 100644 hw/display/vfio-dmabuf-stubs.c
> >
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index f5f92b1068..7d2bd839cc 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -70,6 +70,7 @@ if
> config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >                       if_true: [files('virtio-gpu-base.c', 'virtio-gpu.=
c'), pixman])
> >     if host_os =3D=3D 'linux'
> >       virtio_gpu_ss.add(files('virtio-gpu-dmabuf.c'))
> > +    virtio_gpu_ss.add(when: 'CONFIG_VFIO', if_false: files('vfio-
> dmabuf-stubs.c'))
> >     else
> >       virtio_gpu_ss.add(files('virtio-gpu-dmabuf-stubs.c'))
> >     endif
> > diff --git a/hw/display/vfio-dmabuf-stubs.c b/hw/display/vfio-dmabuf-
> stubs.c
> > new file mode 100644
> > index 0000000000..12f016f0c5
> > --- /dev/null
> > +++ b/hw/display/vfio-dmabuf-stubs.c
> > @@ -0,0 +1,23 @@
> > +/*
> > + * Copyright (c) 2026 Intel and/or its affiliates.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/iov.h"
> > +
> > +bool vfio_device_create_dmabuf(struct iovec *iov, unsigned int
> iov_cnt,
> > +                               int *fd, Error **errp)
> > +{
> > +    error_setg(errp, "VFIO dmabuf support is not enabled");
> > +    return false;
> > +}
> > +
> > +bool vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int
> iov_cnt,
> > +                             void **addr, size_t total_size, Error **e=
rrp)
> > +{
> > +    error_setg(errp, "VFIO mmap dmabuf support is not enabled");
> > +    return false;
> > +}
>=20
> This is VFIO's implementation and shouldn't be here. Follow what
> hw/vfio/iommufd-stubs.c, the previously-mentioned example, does.
Ok, I'll move this file to hw/vfio directory.

>=20
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index fdcf8e53a2..3f39371de1 100644
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
> > @@ -82,13 +83,21 @@ virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res, int *fd,
> >   static bool virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res,
> >                                       Error **errp)
> >   {
> > +    Error *mmap_err =3D NULL;
> >       void *map;
> >
> >       map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> res->dmabuf_fd, 0);
> >       if (map =3D=3D MAP_FAILED) {
> > -        error_setg_errno(errp, errno, "dmabuf mmap failed");
> > +        error_setg_errno(&mmap_err, errno, "dmabuf mmap failed: ");
> >           res->remapped =3D NULL;
> > -        return false;
> > +
> > +        if (!vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> > +                                     res->blob_size, errp)) {
> > +            error_report_err(mmap_err);
> > +            return false;
> > +        }
> > +        error_free(mmap_err);
> > +        mmap_err =3D NULL;
> >       }
> >       res->remapped =3D map;
> >       return true;
> > @@ -145,7 +154,7 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    Error *local_err =3D NULL;
> > +    Error *local_err =3D NULL, *vfio_err =3D NULL;
> >       VirtIOGPUErrorType err;
> >       void *pdata =3D NULL;
> >       int fd;
> > @@ -158,12 +167,19 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >           err =3D virtio_gpu_create_udmabuf(res, &fd, &local_err);
> >           if (err !=3D VIRTIO_GPU_NO_ERROR) {
> >               error_prepend(&local_err, "Cannot create dmabuf: ");
> > -            if (err =3D=3D VIRTIO_GPU_GUEST_ERROR) {
> > -                qemu_log_mask(LOG_GUEST_ERROR,
> > -                              "Cannot create dmabuf: incompatible mem\=
n");
> > +
> > +            if (!vfio_device_create_dmabuf(res->iov, res->iov_cnt, &fd=
,
> > +                                           &vfio_err)) {
> > +                if (err =3D=3D VIRTIO_GPU_GUEST_ERROR) {
> > +                    qemu_log_mask(LOG_GUEST_ERROR,
> > +                                  "Cannot create dmabuf: incompatible =
mem\n");
>=20
> This logic is faulty. err is not set by vfio_device_create_dmabuf(), so
> it reports a guest error even when the memory is compatible with
> vfio_device_create_dmabuf() and it raised an error for a different
> reason.
Maybe I misunderstood your previous comment about this but I thought
we are going to assume that if both virtio_gpu_create_udmabuf() and
vfio_device_create_dmabuf() fail (assuming Guest error in case of
virtio_gpu_create_udmabuf ()) then it is reasonable to assume that Guest
is at fault for passing in incompatible memory addresses.

However, in order to fix this properly, I think we would have to have
vfio_device_create_dmabuf() return VIRTIO_GPU_GUEST/HOST_ERROR
(or something equivalent) which I was trying to avoid. Do you see any
other proper way to fix this issue without messing with the return type
of vfio_device_create_dmabuf()?

The reason why I am hesitant to make vfio_device_create_dmabuf() return
Guest/Host error is because a future user of this API may not need this inf=
o.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> > +                }
> > +                error_report_err(local_err);
> > +                error_report_err(vfio_err);
> > +                return;
> >               }
> > -            error_report_err(local_err);
> > -            return;
> > +            error_free(local_err);
> > +            local_err =3D NULL;
> >           }
> >
> >           res->dmabuf_fd =3D fd;


