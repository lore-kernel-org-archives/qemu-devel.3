Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30519CF2582
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 05:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLaom-0004Zh-1Q; Wed, 19 Nov 2025 00:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vLaoh-0004ZU-MR
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 00:33:19 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vLaof-0005mY-Dp
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 00:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763530397; x=1795066397;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IeEx3gQVvb9E8rNwZbUK5+D+Tj+oA/HUHz7PKU0I6IU=;
 b=hETi3o4eWQsOXsAviRyaYWHffPVhrSNvy7Zfx5G6KxgChSUywyijDbXt
 GrUD/2uUr7q8PrgpHab0hYDVR9lyqoFskOqqkC7RsxUTzsQHbdgw/NVG4
 LN3qaa4HdaAsSHWz7HE2Z5XaeBmtE37kYBhQglDADmNPCazXGV2SekHWG
 Yt5sUMU5NT2gYdA7g3GKzDjNPeXLSJ4UAHd3i5iBv+2YnwI7lnmuKZ82A
 FVUyxqxYCHLy1mMZiFvFSv6WtD9gGqbdIhHawvAZNFBtLEZpxfV8Cq+zf
 YlNfD0tEoty60HmlxpdY1m4eyUQp4VGXWqqniveQr0JJ+5wBzKnIiV9pz w==;
X-CSE-ConnectionGUID: T751/xGzRdC6ZVmtC2DYhA==
X-CSE-MsgGUID: uDkD6UuLSvC7B5yQQcrpyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="77021300"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="77021300"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 21:33:13 -0800
X-CSE-ConnectionGUID: aOGObN44TLmMOCxmPeI+6Q==
X-CSE-MsgGUID: dhgG9XuBTuKcZnfrmkAtbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="195070539"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 21:33:13 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 21:33:12 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 21:33:12 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 21:33:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiaeDd1UrmOW4QTKLFFI4Z34BYD+a+Bcf0nO4iEBGHcRO0iwshkbS5oZa5lciyE2bCWhp+KtF7yXSvzZqEGZsAC2SV4BJ3vS+umccN5WwwmVk3t2y3o13lyb72xXW3nkLpQopF506bntlOBdilvTeCJKqamsJEmbxp3B8AU10J4WcLuV+BIVDkh0j4t3BV7Sjme8CBU7Ean+9RNW/98IoL0oWoACi1rgPwqKpul/orml+KihsxSex7aGtf4wCQWMbIj+Jq9uXw72Q52m3PpyTEBvHN0Ofpvb76IlaVBOooGLe0Ac6G3gCMh3IG93hrcQ7LsJDoS+IhDMbIU8tdxNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvYmTPQpQgZ4AmVI5yarIADh442C2gsQYac439HAZ+s=;
 b=phGBOgSGcrLSo7XnrNm0q/s+2p2hJCxKcXOf9NMbaSay+WRcpGq1fXMyNY1z9baMuJU49vCyFftgOU7tpleChqmnHRhHlJ6mmFDMfXZl4n32Hg2IHxxh14sT/wcEYF3Fw5dDn7+2OYGBAnZU+RyAaUAex9TaZ48iTrQwFJi0wIXNJOaraIX940tsd6Gh+aCjHt+PXVkIcihwpD5cG5DpLKaYUuj4OfMTEMXQhVjCwjCZyeM0kIY1hx/JAXRBttH7pQ8Aj0L/lvDUTVirDvnWoivZQRxZJX0idiAAWjoP3qAxj7YkO44F/lmO+C1sOQcbpCFv2n7UEWjeVF9mFW0jOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 05:33:08 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 05:33:08 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcUTsgsJEAjPPBdEeeacaZ/CcvobTrWiQAgAEUO2CAAkjDAIAA2a3wgABopoCAARmAkIAFbe4AgAEEI9CAAHpUgIAA+ErQ
Date: Wed, 19 Nov 2025 05:33:08 +0000
Message-ID: <IA0PR11MB718559871E509E677FEAD51DF8D7A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-11-vivek.kasireddy@intel.com>
 <5c224e00-8114-4586-b502-3819770bc8ff@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71853FE6CD48B77FA586B628F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3c0fe9e8-7efa-4936-b5ef-5cabc4239cdd@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71855ADFEEC4E3267B464768F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8451c0ee-6c9d-4fbf-b1c2-05fd5fd8e4c3@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185D06DA886C3758E9B0FB5F8C9A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8dcffe42-da84-44cf-a240-90680cdb0953@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71850777A66759ADCAFEB53EF8D6A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <04410e24-43e9-4302-8a88-8de870cd53e0@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <04410e24-43e9-4302-8a88-8de870cd53e0@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MN0PR11MB6134:EE_
x-ms-office365-filtering-correlation-id: cd3ecdf2-51bd-457f-43e0-08de272d1f64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+KK7/5+jwy5uXFjH7rigv5SFoejG+w3yBxHiChzctwZEngLqXL+onXhBxG?=
 =?iso-8859-1?Q?HlGGVAsEQ55bbw6GvLf/SKBsteEwGpdq/et5kgjdg9qVyN9IEtzOx751d2?=
 =?iso-8859-1?Q?0kL6m/h3SrVS8+yfjjT/ZSeNOUqjJCiBUJNVDoADKF+YXcJObgCDKu+q8b?=
 =?iso-8859-1?Q?ywLjAfi8h/J84+NMdUfPIzHJmGqLcr1fCB3HyX3ShqPx3g6leFM8A39ZQ4?=
 =?iso-8859-1?Q?rUt0OB7otV414im0Pax0z5I/YT1roL8ctLTIsqtF3judcqlw14HqkhHqzX?=
 =?iso-8859-1?Q?cFZAD7dgt4l3rCBp+OfsvI7nBlw38FZOIupSr0RFof5RfCPao28F3xOYBB?=
 =?iso-8859-1?Q?S4IKVibVALVuO8DENREuUPytLdLAN6zL4YDXRWAeEM+FoX8u7iIUXTeApR?=
 =?iso-8859-1?Q?LpmIux3mTtxKVRnBY0M4RfR0fuD6oL4xqmLKM8Es853CV0t36U5UTzkQ4R?=
 =?iso-8859-1?Q?05PyaVOMH4uWmbd3wKNb6r3PbE2mJ60xawHGo4okdEpfvbfcPcaq5kHEoG?=
 =?iso-8859-1?Q?pWaTfL5fLXCA1/hKqctfDIINlM5dayN5oaiSdAIyNJhVLpMrnFeQw301K0?=
 =?iso-8859-1?Q?6dKuDE7AFXEMHo2YMjmhmoZa5EAz/zNLZOGZGK6cx6As7ZNSrlk2D8Rvqg?=
 =?iso-8859-1?Q?0ixLPkMPDJDsNfP1/OikAbjtcU3zEGJgCDlpPqnmg59jrovWqu++6zlJaU?=
 =?iso-8859-1?Q?hRwnTstqqZDCExBTeqe0QAtG2nR26OzH2KmMqObqz3PRC0l1lFh7METkUO?=
 =?iso-8859-1?Q?YoNZv3e3ynGlbFG16yW1jRF93bpSnQXXXuyOQKsXXIHQ/GTeQC1hBYdP+N?=
 =?iso-8859-1?Q?Zpxbtg/qvJch+WatwpC6X0fhHvKQtMCYSTU/KHuzhI2EofH7+q3dzFe++s?=
 =?iso-8859-1?Q?6/BySgZ5rI/zpaz3U/PYKJr9SjS5Z9Rc7rSY6xfmkSBDORO/JjdjhrrLr3?=
 =?iso-8859-1?Q?4nRYG9LoGnWcEqEBZ+YYIcu5FhcwQMcvLkLSIMqr2dXltU/jwDXFDD/9e+?=
 =?iso-8859-1?Q?oSaPG0NXJS5+dj8zm3ow4nTdnjC3poCqIeNHNNGkUUdI4ZD2PaqHlCj2jL?=
 =?iso-8859-1?Q?2uN5hdvnprDBMIEACXXKuk75/hvAGei0IENO8WM/JS3dKw5d3dZ2Ip+Mbu?=
 =?iso-8859-1?Q?2P8NcDFBts+iepAN8Rso3PUOe8JYp5BVYwwPW9G37+i7Z9X5aPGSKtIwoP?=
 =?iso-8859-1?Q?tmAC9WC6yxVMX+oKN0HmS7ozb5cPOJfFbxduX6ngMZgosNpxAeHAo+YBig?=
 =?iso-8859-1?Q?2yVIBLqCD0ZVs+h7GoJ8JMLKMHz/bbZ5yy2/mybMwNKX/gAGyzw4p94sd7?=
 =?iso-8859-1?Q?Ig4F68+EOrII5ZvNNRNsqKJo/KvW3VFvFPoPaPI3ZGqxnoj8urUqSL1tM+?=
 =?iso-8859-1?Q?3cnlhf/teGJQvnzsCJGzU4l/uOPL74W9gY4T5hzwPOQgZdrdiW42oNUqg+?=
 =?iso-8859-1?Q?GjTKpYUs0WynYTHohT2Gt7Xw/2Xfdw9gO140KKU951LREYZT48/rx5v8l9?=
 =?iso-8859-1?Q?wb1lixtgAFkAd0o2tD9iXXCpnhhjzgOTVLbi2A7miBXw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IA6m9XSYzCJOIuEBLqc0A6DLOPj9ANsNksV2ELBVj5luiSY/ClIRqADlMI?=
 =?iso-8859-1?Q?y3hbPZc3XF3irUpYXWqsw2uCxMU5AVDqaNaiTiGuYi0Fh26Jf/29JJ2nqy?=
 =?iso-8859-1?Q?SNl6+7INjkvjDOw1DeyBZWv4p/iTy4wbTIwNxA83JPneSdkt7uT6w4ivFC?=
 =?iso-8859-1?Q?TGarbukzvofSasATtWlB8qdDd6F6uwopvLg3NqRC/M0lTcoLITsWImLnTm?=
 =?iso-8859-1?Q?ZRGwNYvzTLkiAkF9gcGFJFbQhifNOKVBtxIUzJIAvDUJmD9W1+/xLG7Cf7?=
 =?iso-8859-1?Q?ntZqUSCmUqoyWO+0/GoAuIAm+FLok2eEtX3AfXgq+HdFYkOQhZVZREhlZd?=
 =?iso-8859-1?Q?GCPnGbJXssjju8I5F58mrS6DOpONvomXzMSBC2gsEknFdpnezHPzq2YErY?=
 =?iso-8859-1?Q?V2yJt/9HuvMyZFKNpRmvF3ihH1eNFh9BMky8Wu6I59HZWRhxXPlVR71b0b?=
 =?iso-8859-1?Q?KocbleVRHxnVVw3y65nBfhbalPv4HjqfVtTYQlrftP0CxDoN1Y582Jzfhz?=
 =?iso-8859-1?Q?Wzo3whlFKStCxM4mnIm8ZhuvpRfQhlJBBhxAEAjIgtpuB/1S8nkwfHw3CP?=
 =?iso-8859-1?Q?GNXZJzgE7zq7YXevUbbBV2lJL0OK2XevF9ELNUHDZ35Lg6cmNXgITSndCm?=
 =?iso-8859-1?Q?eRFcriRLd7ETTU0ORPQWnS7HlwQEBR53ddW1fOgs6ZaV0aVYD3Etq9ZNoz?=
 =?iso-8859-1?Q?HTcmwKlNmfW1Po/vNZ6U6e3rThVnonAOxZ+3hjUITHeruaa7202rezkB1G?=
 =?iso-8859-1?Q?AracNCSR0uQ3+NVjGSMlmBg0qQ95UZjG2CLyU8vPHPpwTPW+Fxz5XcXsch?=
 =?iso-8859-1?Q?tLI/oyOLfdjWZeSgWRQEDOr5FV9PvDRXnfJMlafRfKpKXULZpm/ldNyzW6?=
 =?iso-8859-1?Q?4OwRNWlAxWwdCWNsFTeSgAFbiZcevIDCmMKtTcqi+JrGz48rqGyjyfXIFl?=
 =?iso-8859-1?Q?1WIdGbX49/O2fcLB51yiuPRT8H452/uFn02qbfz5yJrmuhzSKvmG2yk9DZ?=
 =?iso-8859-1?Q?Gf2YIjTAxDsJJhAWEpomVRAfBz3c0kGjNVhwTzBJAWTAGP9UcQnaz0qhD3?=
 =?iso-8859-1?Q?5oDSFyfP8lHuVHCT/OjQ7iWhI2v/+1XXFLmSKV7x1yBHgCRhwNyo3jQsy6?=
 =?iso-8859-1?Q?RXMvbCx9OdglhH+opeqHNwOC6LWUT2j/UUk8CLmIuTZpyGlM5p7KXeqDQf?=
 =?iso-8859-1?Q?ZHI1x8TlRMjrww5caXH8JWdCAqlFgYUs+U2LzBxgLrjt6y99BFuLrl6nax?=
 =?iso-8859-1?Q?vteurNA7sdfSMVOc0PEhud6QjaRMAgEJFmTFJNkiwQM1VLi2bHxyoeqnuf?=
 =?iso-8859-1?Q?P1BcsXMpjneE8bPAWDI+Tvtdtp2ioGRmDxUoKFiZ0wugpnoEzAGEf7GqmG?=
 =?iso-8859-1?Q?akKHhPZEv5oi0e7nh42c/q9CZHehZqogY09NbrtJLnJOgfWFlf4MVJkJeE?=
 =?iso-8859-1?Q?9nOzlbsnSZkeh6BsskGO8Q/olSx/9CuAl+YnfsjLav7POBwvUk1WVwQ35O?=
 =?iso-8859-1?Q?CX4NXtHNH43EoawFmnPtsbSX+B8HAoSRtfY+GhamwXJzi8yatxZmVO8AZ2?=
 =?iso-8859-1?Q?myDrPAxCzvl/C5vUwej5tQYLdR0toeWopVBosV/9/voo7IgAaGSbKtfdUK?=
 =?iso-8859-1?Q?uZzm2IEx2NETfx4+vJ44cY79j19EWjM5xT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3ecdf2-51bd-457f-43e0-08de272d1f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 05:33:08.6495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAhKnREODC4d+8jEu2poUXTlaY+O/f38DBxrVPHDvs+KUaA9UrXmQf/HKkWppUw1vHcP8FeMClEWn49oAdVkp0PNOGyv8kARJvY5SgXic0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
> >>>>>>>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> >>>>>>>>> In addition to memfd, a blob resource can also have its backing
> >>>>>>>>> storage in a VFIO device region. Therefore, we first need to fi=
gure
> >>>>>>>>> out if the blob is backed by a VFIO device region or a memfd
> before
> >>>>>>>>> we can call the right API to get a dmabuf fd created.
> >>>>>>>>>
> >>>>>>>>> So, once we have the ramblock and the associated mr, we rely
> on
> >>>>>>>>> memory_region_is_ram_device() to tell us where the backing
> storage
> >>>>>>>>> is located. If the blob resource is VFIO backed, we try to find=
 the
> >>>>>>>>> right VFIO device that contains the blob and then invoke the AP=
I
> >>>>>>>>> vfio_device_create_dmabuf().
> >>>>>>>>>
> >>>>>>>>> Note that in virtio_gpu_remap_udmabuf(), we first try to test i=
f
> >>>>>>>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't,
> we
> >>>>>>>>> use the VFIO device fd directly to create the CPU mapping.
> >>>>>>>>
> >>>>>>>> I have just remembered that mremap() will work for either of
> udmabuf
> >>>>>> and
> >>>>>>>> VFIO. That will avoid having two different methods and make
> >>>>>>>> vfio_get_region_index_from_mr() and
> vfio_device_get_region_info()
> >>>>>>>> unnecessary.
> >>>>>>> IIUC, the name virtio_gpu_remap_dmabuf() is misleading because
> we
> >>>> are
> >>>>>> not
> >>>>>>> actually doing remap but are simply calling mmap(). In other
> words, we
> >>>>>> are not
> >>>>>>> expanding or shrinking existing mapping but are creating a new
> >>>> mapping.
> >>>>>>> And, for dmabufs associated with VFIO devices, without having to
> call
> >>>>>>> vfio_get_region_index_from_mr() and
> vfio_device_get_region_info(), I
> >>>>>> don't see
> >>>>>>> any other way to determine the region offset.
> >>>>>>>
> >>>>>>> So, I guess I'll create a new patch to do s/remapped/map.
> >>>>>>
> >>>>>> I mean calling mremap() with 0 as the old_size parameter. The man
> page
> >>>>>> says:
> >>>>>>     > If the value of old_size is zero, and old_address refers to =
a
> >>>>>>     > shareable mapping (see the description of MAP_SHARED in
> >> mmap(2)),
> >>>>>> then
> >>>>>>     > mremap() will create a new mapping of the same pages.
> >>>>> It might be possible to use mremap() here but using mmap() seems
> very
> >>>>> straightforward given that we are actually not shrinking or expandi=
ng
> >>>>> an existing mapping but are instead creating a new mapping. Also, I
> am
> >>>>> wondering what benefit would mremap() bring as opposed to just
> using
> >>>>> mmap()?
> >>>>
> >>>> As I noted earlier, mremap() removes the need of having two differen=
t
> >>>> paths for udmabuf and VFIO, and make
> vfio_get_region_index_from_mr()
> >>>> and
> >>>> vfio_device_get_region_info() unnecessary, reducing code complexity.
> >>> Sorry, I should have researched thoroughly before but after looking a=
t
> the
> >> code
> >>> again, I don't see how mremap() removes the need for having two
> different
> >>> paths for udmabuf and VFIO and make
> vfio_get_region_index_from_mr()
> >>> and vfio_device_get_region_info() unnecessary. Could you please
> elaborate
> >>> how it can be done?
> >>
> >> Not tested, but something like the following:
> >>
> >> head =3D qemu_ram_mmap(-1, res->blob_size,
> qemu_real_host_page_size(),
> >>                        QEMU_MAP_READONLY | QEMU_MAP_SHARED, 0);
> >> if (head =3D=3D MAP_FAILED) {
> >>       return NULL;
> >> }
> >>
> >> cursor =3D head;
> >>
> >> for (i =3D 0; i < res->iov_cnt; i++) {
> >>       if (mremap(res->iov[i].iov_base, 0, res->iov[i].iov_len,
> >>                  MREMAP_FIXED, cursor) =3D=3D MAP_FAILED) {
> > This is very elegant and I can now see how it is expected to work.
> However,
> > I went ahead and tested it and it does not seem to work for VFIO backed
> > buffers. It works for buffers based out of System RAM though. Here is t=
he
> > actual code I tested with that I am unconditionally calling for both VF=
IO
> > and udmabuf cases:
> > static void *vfio_dmabuf_mmap2(struct virtio_gpu_simple_resource *res,
> >                                 VFIODevice *vdev)
> > {
> >      void *head, *cursor;
> >      int i;
> >
> >      head =3D qemu_ram_mmap(-1, res->blob_size,
> qemu_real_host_page_size(),
> >                           			QEMU_MAP_READONLY |
> QEMU_MAP_SHARED, 0);
>=20
> By the way, please do:
> head =3D mmap(NULL, res->blob_size, PROT_NONE, MAP_SHARED, -1, 0);
>=20
> I forgot that we don't need to map a RAM but mmap() with PROT_NONE is
> sufficient. It will catch a bug that fails to mmap() a real resource on
> top of it.
>=20
> >      if (head =3D=3D MAP_FAILED) {
> >          return head;
> >      }
> >
> >      cursor =3D head;
> >      for (i =3D 0; i < res->iov_cnt; i++) {
> >           if (mremap(res->iov[i].iov_base, 0, res->iov[i].iov_len,
> >               MREMAP_FIXED | MREMAP_MAYMOVE, cursor) =3D=3D MAP_FAILED)=
 {
> >               goto err;
> >           }
> >           cursor +=3D res->iov[i].iov_len;
> >      }
> >      return head;
> > err:
> >      qemu_ram_munmap(-1, head, res->blob_size);
> >      return MAP_FAILED;
> > }
> >
> > It (mremap) initially errored with -EINVAL in all cases but adding
> MREMAP_MAYMOVE
> > fixed it for buffers based out of RAM but for VFIO backed buffers, it s=
eems
> to be
> > throwing -EFAULT/Bad Address error. I did not yet check why or where th=
e
> kernel
> > driver is returning this error from.
>=20
> The man page says that EFAULT means:
>  > Some address in the range old_address to old_address+old_size is an
>  > invalid virtual memory address for this process. You can also get
>  > EFAULT even if there exist mappings that cover the whole address space
>  > requested, but those mappings are of different types.
>=20
> None of this should be true so it should be a bug, though I'm not sure
> if it is a bug of QEMU, Linux, or the man page (i.e., the man page
> failed to mention another failure scenario). In any case it needs to be
> debugged.
I found that the check that fails due to which -EFAULT is returned is this:
https://elixir.bootlin.com/linux/v6.18-rc6/source/mm/mremap.c#L1736

And, removing the check makes it (mremap) work. So, it is not clear whether
mremap() is supported for VMAs that have VM_DONTEXPAND and VM_PFNMAP
flags set, like in the case of VFIO. I guess I'll send a patch removing thi=
s check
to linux-mm to discuss this issue with mm developers.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

