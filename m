Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F5FC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 01:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTWtF-0000Vf-HT; Mon, 15 Jul 2024 21:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTWtD-0000V3-Ed
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:21:59 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTWt8-0006Wm-Pu
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721092915; x=1752628915;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qyFgT3cfNnJNhoq8+S+MpzfuLQJ1+n1ilEpHnZGgmcA=;
 b=IvGQ1NfxAZdLxQ6zQ4f/mJWQWfszuCFvQC1kYeSuQX1FdYRvt2xNDNGK
 VuXiVmlXajNTWLuRCDpkx3d8VtMhUBW9UjOVOw9imICf/905oRdqMttBp
 /sxcGvWiTEiDjDLWYM+3Y4g2XRQe+WNPI8fqr9PPa8U/899b9mMjt6gPt
 xKOHyVPqn36ZeIivnh/xaLSx77PfE0IorM2uEqHfSPOhxa39VGY+Ge7gx
 2sxNFftM3bokgxo/kkguailyiB157o6lnBRcnRqwXFCsusu08VHJ1D3PY
 CpPouNVkOc2hjxleogMXlRFpq8s7cmahLcuyY1NBm+3hIOoQhIvGST6gp Q==;
X-CSE-ConnectionGUID: aI86c8nLSAehUVwAjR2b6A==
X-CSE-MsgGUID: eB2Pux1KSu+pcM+vop/qgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18656888"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="18656888"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 18:21:51 -0700
X-CSE-ConnectionGUID: H1Kw8RPkQFe+4A0Spl/xxA==
X-CSE-MsgGUID: erfBGa/eSMWkVbIEXnnclg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="49713185"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jul 2024 18:21:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 18:21:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 18:21:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 18:21:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbjlJv+wVdi7LwzcFjij6LO8K/5y4WthCT8WmvtvNhukgtyW1lhT4+5xl0PzctUH+sSDbwRkChA2vO+rLR2yAeYj/GrpEGm8jt//OK083Ik7LrvPpqsq0IC3rxPKL7okPGtlaJii4GFS1hAtOD5jRlp1TtMu6r3IH88kKz3d2XRWl5IwARMzkw4X/ik1lk0eZFgFLtPcJoTreD9RZhD3OQexUnnBBg8uT4uyNvPJc5SqoRRvAjzGTEtmC1u+MzOU5rD4z2k2dvB00ZcbHdr5CTDfuv4pcWyNLJd3Ifpl29XPH+uZlw5FfJhLfhD/quM3leBLjzW427BX9wqIhqMNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Az1QOKHKkbVAmBSKrR1okJaYKBFlV4FpD+dA0gHmnM=;
 b=bUYPyKsLhbmwWcr5QFZCYLbAKgikKats25gcgA4+ndH1IuT0lrC+Cl7HGMAJhk3ROF/mt0tdcm8jyuVeew8tmkUZ/Myx4/BWRbybSjY5XrJlvxkSymW7/GkGl3pp9WjXh1ecN42mMShP3Agvov/rt6Rb5REWtQWENloLiH5dkiYIUcSL1W17RUBdvTWqI25Jsi5neRvmzUNfYPrPXHlMSRGjJGrei4yir41eGaymbpof7KNd8RWFltdbIlENmiz3R6qD1nvDBnpxeSgjFfl7whbc4b7nonlZTDLBGnSfUROZXacJj0kAzir3V64rMXF0an7fSAXstiPnbxRzOPdq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by PH0PR11MB5807.namprd11.prod.outlook.com (2603:10b6:510:140::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 16 Jul
 2024 01:21:46 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 01:21:46 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Wang, Yichen" <yichen.wang@bytedance.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hao
 Xiang" <hao.xiang@linux.dev>, "Kumar, Shivam" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: RE: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload zero
 page checking in multifd live migration.
Thread-Topic: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload zero
 page checking in multifd live migration.
Thread-Index: AQHa09y4Qu9AOd5eTECcwvlNYUC9ULHyIXCAgAVUt7CAAEXVgIAAAUtwgAAldYCAAAW84IAAEkYAgACaaDA=
Date: Tue, 16 Jul 2024 01:21:45 +0000
Message-ID: <PH7PR11MB5941D545D7EC31B3F844F395A3A22@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711184131-mutt-send-email-mst@kernel.org>
 <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715081857-mutt-send-email-mst@kernel.org>
 <PH7PR11MB5941A453AC1A4B3A387475A7A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715104015-mutt-send-email-mst@kernel.org>
 <PH7PR11MB59410B8B35F932AF55C8A243A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715120657-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240715120657-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|PH0PR11MB5807:EE_
x-ms-office365-filtering-correlation-id: 517a07e4-8e11-437c-4798-08dca535a891
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CAFD+GVLx8uZm6pQJ389kIc7UJw8SLPo90HSdsraOAioJUqwA3JO7PvAiL?=
 =?iso-8859-1?Q?ftf2w+S83LMRjXN8V/GwNXAvgz/EigyFAcfsHhWSM3o9jo6b76ix5pFi5Y?=
 =?iso-8859-1?Q?us3yIalatU5qUHt9Jg8pqAbNscDeilZf1XtX4bp2DZLUn1I1aSY+DlO2VM?=
 =?iso-8859-1?Q?IiE6LL7BLcSqzaAcvSJ9R3jk0tRpZEqfIQ4dIcDBWIQGIkvMtfe8vQMGGQ?=
 =?iso-8859-1?Q?0A3+g/RkIt9CWZ+zisE1DRBKt6mJ+FvsY8NOobbpBBAeEo/cSN4xSgZnDV?=
 =?iso-8859-1?Q?KLdBfsvNcQXqXF1u3YZZEAaljopH49iJ9fY06RufE/uaPVqQljrmFNG52J?=
 =?iso-8859-1?Q?/HgN1hF1fDUQBhiO52nTwNbXV8N2f/DAUlL/281oiQxqrCci5QxEbngOFR?=
 =?iso-8859-1?Q?yYTBALJqEf60A/pIAQuZZP1NqrRLZIT9CyDjsoWm8ESHBgXWaIEvFhOG5M?=
 =?iso-8859-1?Q?vFdoh67zfh6i5DF6AwN8E+9ermpNWwQYktrV00eNn2elTK5r7U6X3UXG0P?=
 =?iso-8859-1?Q?Ci8ijv8NXZMzo0Y5xK8jX3uPGjvm6AUH6ANdpMqpzxtlo4etHLmVMwPFS6?=
 =?iso-8859-1?Q?vWU2ZhtL3z8pgQldd++2f4atL3DrfC7rAz41vhzicWCRDLrp/AVj/EyXec?=
 =?iso-8859-1?Q?Rnd/GfAlYAU+60s4wYgsp/PMOUlvhSfCJ9WRHMyBobuBBXwrQOdP1Jl32R?=
 =?iso-8859-1?Q?ddbo53qeKXB62UQc+0AfSr9/JZrP39hd4kaaic5dkwKYPdd7ZTbimc2XpT?=
 =?iso-8859-1?Q?w/jrmwXeEjGK1O51j1hYi3g8fYSojJPhuJyzwCB2j0oT0ZMrZixZYpgoTW?=
 =?iso-8859-1?Q?tCYlx773/tzKIPhK0pF12vEoIcz4xusW1EH9Uf/QdyAmNmVmU9K1bunqgW?=
 =?iso-8859-1?Q?4/vyD48wS8BbNBOdVcpTobJ6yQyUKX5c41XyZ6QG6SwXTyC2xOCjH+XwNB?=
 =?iso-8859-1?Q?CoDf+OdE0csWdrUMtWujDVtNWnn2SnWSaeb+PmdMTt3YOxLaKB0rinw/M0?=
 =?iso-8859-1?Q?maCkc5uo+gOnyf/eHCxiAFFQfjBM0Che8BPZrg6shi3lhsQ34DaFM2eVzn?=
 =?iso-8859-1?Q?6XBG0UIsxTBzvOkMBeUC+nP4Jvjuapq/kL78Llwk8CcfVMBcoXDNrgASgW?=
 =?iso-8859-1?Q?PwBdYIfRptM49pwowvDMePG4m2W5FgG/mGlys/B6oSvYC1oTX4/8ordfPL?=
 =?iso-8859-1?Q?Vs4ZQjE8cqrMuR9NPqwCssPgSPfIUhO7kgp2FPioL44GXufF/FWZGs49KN?=
 =?iso-8859-1?Q?GCykjA7zd1iaATFpPf7K5XLpCI63OJukKNOATlDqA7pavPxI7pKDxsARd4?=
 =?iso-8859-1?Q?dm/szPL4Aqt4/90k45HObFuWeiSIOJPetWzrj8qXojri2zXt2Uy7kUBL3w?=
 =?iso-8859-1?Q?uBbQfScbWmzaqBTEll8DK8QjSxyGsSvxmxUqjs6ALevXXrsI8zKF0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N/jyjvfOi4j4F/aNcisdRzKMjWDfhdctK2ad4AYVYCV/iAX7HCQ8qzDLSu?=
 =?iso-8859-1?Q?kid48PucmYZaeHxgPjRyC2VIZOo8+DSO3TptOe6ooMIfn0eFzdimsiu87n?=
 =?iso-8859-1?Q?jZfKvO0aQrPwgVz2b6feW60h2Ub9yPSEzqETQDh6c+DVcgg74Kv7sf0EwU?=
 =?iso-8859-1?Q?x76m2EyMkVVVhXLTE0cVUcuWC0+5JeKWIKEGSPcQkXewOhuHoVhxTe9M3B?=
 =?iso-8859-1?Q?10BPbFxYsE/hfgZtxnaozzEtOz3A0f/Mno4akepZe1F0n+hD5LlUwPLv4K?=
 =?iso-8859-1?Q?dbb/109zb08q8jP6FbVlOf6bHVemTyc7zXgHrX4CYhYyVX7YTupICCivLc?=
 =?iso-8859-1?Q?Xa6ovtBmgby7hH//5C/KYQyyuko0KHKHSvgccoIELMrEhj1xVnQMcWvhWT?=
 =?iso-8859-1?Q?IS41k32qkCyljLGB2PFrpKz45jDYuZeM+AnFjAxFgbeMVzxDdyl9hHkzep?=
 =?iso-8859-1?Q?fRBw9kTU9qIFVQ4rKrAWNfi9/2JTmI0XRHB1O13b3X0eANhQ841o0Sg4CK?=
 =?iso-8859-1?Q?nKj+K6WlYYoycrU+G5x0udH84F3KHxJm+jETHP5OylqYHhwJBsrTDuHZpe?=
 =?iso-8859-1?Q?NkfqODElKcSIQivNFVATzwK7MnPB4hVgS8o4OuN9kI4t+KeTc70aw+b52p?=
 =?iso-8859-1?Q?Z2oocq41OF93qCg6zFpOK7Du4WyWd5SOqCDL0pA7z2R6Q+N1I308Qvopef?=
 =?iso-8859-1?Q?0BpnEhxQPuR6T3cowDAawIhWghFOYIlVUs9UIod/G0oY7M36KwVflxdTBq?=
 =?iso-8859-1?Q?2LA4NoEt0MSWDe/hI5B4qO1YskqD6nwDbQJ0YM33ZiiREv6kbbetXCm1W4?=
 =?iso-8859-1?Q?6rVS6uPxbri4Gdj2Vq/jzAMbbvZvkRMWhYYv7KAtW/pxslbLG6ud8MZ1wo?=
 =?iso-8859-1?Q?wsKwmnlLSXdn8lCfe64LhuvgEsywJB+faVHvFAz4p/fkUjsGqjLWCAl4CV?=
 =?iso-8859-1?Q?NPpLtAKy+t5eZzdgsIOBHQMpv1ILZ7p0RhzeqjrK6xoWGNzcizTcGMDfa9?=
 =?iso-8859-1?Q?ByK5MYSyyuWPS7K9r88aw5CRKXQILz8XT1aDBHn6QEYDjYhR4IQFvMp21Q?=
 =?iso-8859-1?Q?hifGNSELWyFDG9mqFfhhXDe07hk5anQPAF95TccASJKJRovDuTs2MCMYJu?=
 =?iso-8859-1?Q?GLJnFnbIUQ4iZPhuPWgLm11HcSZg9dK25CIU2W/qlP6ZTourJAuqMdjOXo?=
 =?iso-8859-1?Q?8gXMcc9l4ThUU0hckcAE4Pl6pTpN+yTIj3y2jeKw3IbRYun8CnDasL+W/P?=
 =?iso-8859-1?Q?K007XfUDy5Nka93f4fXAkp5h+KUfpX7Q1OVLhWopPgKrt7Hu2rB/Rtlh0s?=
 =?iso-8859-1?Q?FqWNOrYEfnyGF1cSG9I8RRh84QvO9MUPmysCvo6CdG/mS7yezz7qCY7IF2?=
 =?iso-8859-1?Q?l5v08BEbhzMDtkVWF3cu66Is+gfOsaqguK2HjfWy5VhmHIRFp0kBxnpQD7?=
 =?iso-8859-1?Q?rJXoQU1wMehGrboc5kKJoenNPpTH8BVtWd8+UxQGwus4OieJSBFtSN29Sh?=
 =?iso-8859-1?Q?ny0j7GxPoxLomieSZk8Y42NK2t02FiMarGXetfn0UNqTtYOT4NZyIjkAjB?=
 =?iso-8859-1?Q?0cZEy3QrgDx9OZghz6lkUnYPArQ4slXDRtLJJTCs6OUUPJ9OLhTQSVeUOP?=
 =?iso-8859-1?Q?Ff6tebSedZWDBG69FsdeNhD50En8Yq54rf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517a07e4-8e11-437c-4798-08dca535a891
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 01:21:45.9686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVfn3Uwv279eGftj15EyGmKzVfQtZA0vnPKnIjM0fcDIJsXUrHNm9fOQrOj3IOwWErHDmYHEnBn+rW6np0PL2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5807
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, July 16, 2024 12:09 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>
> Cc: Wang, Yichen <yichen.wang@bytedance.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>;
> Daniel P. Berrang=E9 <berrange@redhat.com>; Thomas Huth <thuth@redhat.com=
>;
> Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Peter Xu <peterx@redhat.com=
>;
> Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> Armbruster <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Kumar, Shivam
> <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> <horenchuang@bytedance.com>
> Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload
> zero page checking in multifd live migration.
>=20
> On Mon, Jul 15, 2024 at 03:23:13PM +0000, Liu, Yuan1 wrote:
> > > -----Original Message-----
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, July 15, 2024 10:43 PM
> > > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > > Cc: Wang, Yichen <yichen.wang@bytedance.com>; Paolo Bonzini
> > > <pbonzini@redhat.com>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>;
> > > Daniel P. Berrang=E9 <berrange@redhat.com>; Thomas Huth
> <thuth@redhat.com>;
> > > Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Peter Xu
> <peterx@redhat.com>;
> > > Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>;
> Markus
> > > Armbruster <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
> qemu-
> > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Kumar, Shivam
> > > <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> > > <horenchuang@bytedance.com>
> > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to
> offload
> > > zero page checking in multifd live migration.
> > >
> > > On Mon, Jul 15, 2024 at 01:09:59PM +0000, Liu, Yuan1 wrote:
> > > > > -----Original Message-----
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Monday, July 15, 2024 8:24 PM
> > > > > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > > > > Cc: Wang, Yichen <yichen.wang@bytedance.com>; Paolo Bonzini
> > > > > <pbonzini@redhat.com>; Marc-Andr=E9 Lureau
> > > <marcandre.lureau@redhat.com>;
> > > > > Daniel P. Berrang=E9 <berrange@redhat.com>; Thomas Huth
> > > <thuth@redhat.com>;
> > > > > Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Peter Xu
> > > <peterx@redhat.com>;
> > > > > Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>;
> > > Markus
> > > > > Armbruster <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>=
;
> > > qemu-
> > > > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Kumar, Shivam
> > > > > <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> > > > > <horenchuang@bytedance.com>
> > > > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to
> > > offload
> > > > > zero page checking in multifd live migration.
> > > > >
> > > > > On Mon, Jul 15, 2024 at 08:29:03AM +0000, Liu, Yuan1 wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Sent: Friday, July 12, 2024 6:49 AM
> > > > > > > To: Wang, Yichen <yichen.wang@bytedance.com>
> > > > > > > Cc: Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=E9 Lureau
> > > > > > > <marcandre.lureau@redhat.com>; Daniel P. Berrang=E9
> > > > > <berrange@redhat.com>;
> > > > > > > Thomas Huth <thuth@redhat.com>; Philippe Mathieu-Daud=E9
> > > > > > > <philmd@linaro.org>; Peter Xu <peterx@redhat.com>; Fabiano
> Rosas
> > > > > > > <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> > > Armbruster
> > > > > > > <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> > > > > > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1
> > > > > > > <yuan1.liu@intel.com>; Kumar, Shivam
> <shivam.kumar1@nutanix.com>;
> > > Ho-
> > > > > Ren
> > > > > > > (Jack) Chuang <horenchuang@bytedance.com>
> > > > > > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator
> to
> > > > > offload
> > > > > > > zero page checking in multifd live migration.
> > > > > > >
> > > > > > > On Thu, Jul 11, 2024 at 02:52:35PM -0700, Yichen Wang wrote:
> > > > > > > > * Performance:
> > > > > > > >
> > > > > > > > We use two Intel 4th generation Xeon servers for testing.
> > > > > > > >
> > > > > > > > Architecture:        x86_64
> > > > > > > > CPU(s):              192
> > > > > > > > Thread(s) per core:  2
> > > > > > > > Core(s) per socket:  48
> > > > > > > > Socket(s):           2
> > > > > > > > NUMA node(s):        2
> > > > > > > > Vendor ID:           GenuineIntel
> > > > > > > > CPU family:          6
> > > > > > > > Model:               143
> > > > > > > > Model name:          Intel(R) Xeon(R) Platinum 8457C
> > > > > > > > Stepping:            8
> > > > > > > > CPU MHz:             2538.624
> > > > > > > > CPU max MHz:         3800.0000
> > > > > > > > CPU min MHz:         800.0000
> > > > > > > >
> > > > > > > > We perform multifd live migration with below setup:
> > > > > > > > 1. VM has 100GB memory.
> > > > > > > > 2. Use the new migration option multifd-set-normal-page-
> ratio to
> > > > > control
> > > > > > > the total
> > > > > > > > size of the payload sent over the network.
> > > > > > > > 3. Use 8 multifd channels.
> > > > > > > > 4. Use tcp for live migration.
> > > > > > > > 4. Use CPU to perform zero page checking as the baseline.
> > > > > > > > 5. Use one DSA device to offload zero page checking to
> compare
> > > with
> > > > > the
> > > > > > > baseline.
> > > > > > > > 6. Use "perf sched record" and "perf sched timehist" to
> analyze
> > > CPU
> > > > > > > usage.
> > > > > > > >
> > > > > > > > A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> > > > > > > >
> > > > > > > > 	CPU usage
> > > > > > > >
> > > > > > > > 	|---------------|---------------|---------------|-------
> ------
> > > > > --|
> > > > > > > > 	|		|comm		|runtime(msec)
> 	|totaltime(msec)|
> > > > > > > > 	|---------------|---------------|---------------|-------
> ------
> > > > > --|
> > > > > > > > 	|Baseline	|live_migration	|5657.58	|		|
> > > > > > > > 	|		|multifdsend_0	|3931.563	|		|
> > > > > > > > 	|		|multifdsend_1	|4405.273	|		|
> > > > > > > > 	|		|multifdsend_2	|3941.968	|		|
> > > > > > > > 	|		|multifdsend_3	|5032.975	|		|
> > > > > > > > 	|		|multifdsend_4	|4533.865	|		|
> > > > > > > > 	|		|multifdsend_5	|4530.461	|		|
> > > > > > > > 	|		|multifdsend_6	|5171.916	|		|
> > > > > > > > 	|		|multifdsend_7	|4722.769	|41922
> 	|
> > > > > > > > 	|---------------|---------------|---------------|-------
> ------
> > > > > --|
> > > > > > > > 	|DSA		|live_migration	|6129.168	|		|
> > > > > > > > 	|		|multifdsend_0	|2954.717	|		|
> > > > > > > > 	|		|multifdsend_1	|2766.359	|		|
> > > > > > > > 	|		|multifdsend_2	|2853.519	|		|
> > > > > > > > 	|		|multifdsend_3	|2740.717	|		|
> > > > > > > > 	|		|multifdsend_4	|2824.169	|		|
> > > > > > > > 	|		|multifdsend_5	|2966.908	|		|
> > > > > > > > 	|		|multifdsend_6	|2611.137	|		|
> > > > > > > > 	|		|multifdsend_7	|3114.732	|		|
> > > > > > > > 	|		|dsa_completion	|3612.564	|32568
> 	|
> > > > > > > > 	|---------------|---------------|---------------|-------
> ------
> > > > > --|
> > > > > > > >
> > > > > > > > Baseline total runtime is calculated by adding up all
> > > multifdsend_X
> > > > > > > > and live_migration threads runtime. DSA offloading total
> runtime
> > > is
> > > > > > > > calculated by adding up all multifdsend_X, live_migration
> and
> > > > > > > > dsa_completion threads runtime. 41922 msec VS 32568 msec
> runtime
> > > and
> > > > > > > > that is 23% total CPU usage savings.
> > > > > > >
> > > > > > >
> > > > > > > Here the DSA was mostly idle.
> > > > > > >
> > > > > > > Sounds good but a question: what if several qemu instances ar=
e
> > > > > > > migrated in parallel?
> > > > > > >
> > > > > > > Some accelerators tend to basically stall if several tasks
> > > > > > > are trying to use them at the same time.
> > > > > > >
> > > > > > > Where is the boundary here?
> > > > > >
> > > > > > A DSA device can be assigned to multiple Qemu instances.
> > > > > > The DSA resource used by each process is called a work queue,
> each
> > > DSA
> > > > > > device can support up to 8 work queues and work queues are
> > > classified
> > > > > into
> > > > > > dedicated queues and shared queues.
> > > > > >
> > > > > > A dedicated queue can only serve one process. Theoretically,
> there
> > > is no
> > > > > limit
> > > > > > on the number of processes in a shared queue, it is based on
> enqcmd
> > > +
> > > > > SVM technology.
> > > > > >
> > > > > > https://www.kernel.org/doc/html/v5.17/x86/sva.html
> > > > >
> > > > > This server has 200 CPUs which can thinkably migrate around 100
> single
> > > > > cpu qemu instances with no issue. What happens if you do this wit=
h
> > > DSA?
> > > >
> > > > First, the DSA work queue needs to be configured in shared mode, an=
d
> one
> > > > queue is enough.
> > > >
> > > > The maximum depth of the work queue of the DSA hardware is 128,
> which
> > > means
> > > > that the number of zero-page detection tasks submitted cannot excee=
d
> > > 128,
> > > > otherwise, enqcmd will return an error until the work queue is
> available
> > > again
> > > >
> > > > 100 Qemu instances need to be migrated concurrently, I don't have
> any
> > > data on
> > > > this yet, I think the 100 zero-page detection tasks can be
> successfully
> > > submitted
> > > > to the DSA hardware work queue, but the throughput of DSA's zero-
> page
> > > detection also
> > > > needs to be considered. Once the DSA maximum throughput is reached,
> the
> > > work queue
> > > > may be filled up quickly, this will cause some Qemu instances to be
> > > temporarily unable
> > > > to submit new tasks to DSA.
> > >
> > > The unfortunate reality here would be that there's likely no QoS, thi=
s
> > > is purely fifo, right?
> >
> > Yes, this scenario may be fifo, assuming that the number of pages each
> task
> > is the same, because DSA hardware consists of multiple work engines,
> they can
> > process tasks concurrently, usually in a round-robin way to get tasks
> from the
> > work queue.
> >
> > DSA supports priority and flow control based on work queue granularity.
> > https://github.com/intel/idxd-
> config/blob/stable/Documentation/accfg/accel-config-config-wq.txt
>=20
> Right but it seems clear there aren't enough work queues for a typical
> setup.
>=20
> > > > This is likely to happen in the first round of migration
> > > > memory iteration.
> > >
> > > Try testing this and see then?
> >
> > Yes, I can test based on this patch set. Please review the test scenari=
o
> > My server has 192 CPUs, and 8 DSA devices, 100Gbps NIC.
> > All 8 DSA devices serve 100 Qemu instances for simultaneous live
> migration.
> > Each VM has 1 vCPU, and 1G memory, with no workload in the VM.
> >
> > You want to know if some Qemu instances are stalled because of DSA,
> right?
>=20
> And generally just run same benchmark you did compared to cpu:
> worst case and average numbers would be interesting.

Sure, I will have a test for this.

> > > --
> > > MST


