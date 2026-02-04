Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAD4E8B39A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVCS-0005xu-5D; Wed, 04 Feb 2026 00:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnVCO-0005xT-Sk
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:13:08 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnVCL-0005xm-8L
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770181985; x=1801717985;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ONXcrm7AFJY7LPqR9LKcB0x1BwiIvuwUuRbFu+hGALk=;
 b=Objr+hITqQH/aYoDMQAzlRTxB7zJY9q6WKoaCi55qqV5oCpLNCnENNMD
 BEmCvR4VEagLdOAykatmNcvfjCPe5mo1A82iWodh1+LE3ZA2PP4zz97KQ
 y/rlmCmPtwa24smJEx80y4bW72PAAKdfmyKf2XV1f8C2V7m8zxwDAY19P
 i50xBtBkTeUjDE9sQrxmaV/X7ehqCVWQOJbCGDdbVKWpY3iN+3pAHQF95
 HsF9gR9og/wUjtDkgCf9yY5fBWaVk8WCfsND6VYN8CjMTkHoNJxuVVA4j
 63a957kDcQYotMTlBjJrVknenS78zlwO+oI4gUvzkFu82Ujw7JcPCRATv g==;
X-CSE-ConnectionGUID: s1FTtn/lTlq8AiC6CV95hA==
X-CSE-MsgGUID: v108tdxXRgufSzwCxqg1Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71422030"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="71422030"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 21:13:02 -0800
X-CSE-ConnectionGUID: 6RKKV7AyTZyIW4yaUgcc3A==
X-CSE-MsgGUID: 2sX5hHlTSNy4cqZdQJGTqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="210098438"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 21:13:02 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 21:13:00 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 21:13:00 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 21:13:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYyiSvV4BUbXZmZBnhDHPM6EHiXb08U3ShYKqWYMBa92gnV0KA8d+y0jixlsrDJKLwe+XVx4UqAN67lLhpCHEciQ1DGve+V4WYginASWFtCNSBGLrWFb/Vn2wDyM1KW57NP3+fCgJvkmA/r1FJZFCd9owEx6ybfrC6+/Gsbkf4d27x68IFBqRloDIO6N+XB1J0FhgnVtPIlG/5Llh4NajLgqPY92EVf1PKgwTsr1sT4t9um5ygFaZhb9LW6ZVUxxUXx0T+bn0vmxQ4/uyk/jY2LMFAwMNMARF8eixpoj/Q5LVWs/0Za6EdyR+aynLLPRLJvTupcBpJJfCEmHpQw6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SK3gpDmka30C+rrahjAlO5KirXtludsKEZ+Xos3sbYE=;
 b=UWOZrKVNXhzQN7c+WxmX/fysC64yuzIrLQQxzoan5j7bAm1A5Qr1ghBIZPAeKNWGbQE68t4zMD1AskH6c1Knl0Rmgrv0CRRLZ85/V/czWeGDS6Qb8kAWpIqmf8SmgKgWJb1tAQMKbhVkC33wTKmrA/HiefmfYT4gvUgIIzqTAGd/schPuu8Aal/Ts1SzMApHZj4ddphLxMcrbhnFH7R0yXMe6xnJZ2fUQPuOTHD9DRs3vEfpNd1/iK6rueTRWKK+ERNoD9ry8xT63a7kLau1UG9xQ3TjniWq7YM+8rzHi4pLkECrY6ZMh0URNOnL/NjTToNs8j5vjlck7jrYy8zPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Wed, 4 Feb
 2026 05:12:59 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 05:12:59 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v5 12/12] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v5 12/12] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHclN9KKehwGwfZP0uL1Ero8hOPIrVxAWWAgACHQgA=
Date: Wed, 4 Feb 2026 05:12:59 +0000
Message-ID: <IA0PR11MB7185AD122729307CD0294E05F898A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260203073200.848183-1-vivek.kasireddy@intel.com>
 <20260203073200.848183-13-vivek.kasireddy@intel.com>
 <60caad88-611b-4ccb-b591-e34c9c751a72@redhat.com>
In-Reply-To: <60caad88-611b-4ccb-b591-e34c9c751a72@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH0PR11MB4824:EE_
x-ms-office365-filtering-correlation-id: b088b15e-aa92-4fe1-3435-08de63ac1058
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SoqfceElTnsE9EyAgcu1orE4paSpeXaFzVJtViOstyCYww0DaQBNkKm2sg?=
 =?iso-8859-1?Q?7I2bwOcm25OcBP/PxM6qhOj2sVoEoUUdwGOG5Hq6+guLTrXb3Cb7fgkdYB?=
 =?iso-8859-1?Q?QT2xx6EeQka2LLH4ghlfPe/DRimpc05MsKdK5ik2eCc0dZO+mWrzi5rVM/?=
 =?iso-8859-1?Q?l1rr/m7sr9CT8+fKaynVZXqi4zgALGMykbDeeDsCdl61itY0IXPSicj4or?=
 =?iso-8859-1?Q?kJe9mJW/FNTScw8XtZ7tJC7svPcK62f9bOrwHNKWe+6PwYP97c9lQBaThh?=
 =?iso-8859-1?Q?a0O74TGxYfOviqAvkZxS/hjSygPJSddNiF2f1rYAc0iXYDM7LZH5snB4Zx?=
 =?iso-8859-1?Q?neDnXfdUYSpz0nupdpXB9FnYH1QzOEwj84lrv8ged2lyTccU5Lu5YVmE5B?=
 =?iso-8859-1?Q?UuR7A8Tz4xE4aLjALMfHjxqdMN/VXbCUglpdU3fi5AcynktOFEUFPzgu0v?=
 =?iso-8859-1?Q?6dkwGvw+K6aBryNZXYC7a7JZoSbV+yjXL9Nh8Mii5tDpbVIxSk2KD2yTQL?=
 =?iso-8859-1?Q?0cansNi6wL7T2R8fIKgI5RK2vb85D1kAwcEuWFtXWAih4RpOivg2rwXdcH?=
 =?iso-8859-1?Q?C38OOV2SVNK+5a3bbXmxWkhGiZvrrFomEmIRd5aFws2mFLu6jNy2e3iDwv?=
 =?iso-8859-1?Q?Si5T2yPZXqY8u/+OCAZQrnrOpIAdRG3xu58gzLKhhM22tCUR4gGTyeEnW5?=
 =?iso-8859-1?Q?MfcpkDtBJCfWgx+AQu8GzQZ7oeJf2F6gR46YuJt2WHgmBZEGOeqjMujiQP?=
 =?iso-8859-1?Q?S33xkNS2YpwDx2zepb8xaq5zjRFNyWFjcSBrg6rWq6Kb7CVwg17BgbCvJk?=
 =?iso-8859-1?Q?YKHrT1nruontkzpdgRamsDqsQPyRIyVIY3xA6db0I9ZHbFI7pbzs3vI/td?=
 =?iso-8859-1?Q?68GVnIPAvi2kOuCsyxSu7aq68y5YQQM5In22cd0u+WO+Mo3y9qdZvAg+hW?=
 =?iso-8859-1?Q?gx0xvAEKvTt2wOXBfmeSB0Qr38GX/rYxlBdBPCWjd0St14ASevfotWxUmN?=
 =?iso-8859-1?Q?z5c4ZMnnOKtehGCR2uwyDT6uPR8t4daRRQkyFBPFDA2inawgQOQU1EASE4?=
 =?iso-8859-1?Q?Bx3AkZa8XAwIV9asy/xYuB865bDpWGfiBJJIYdXzHeQltTTL6fNdZyahCq?=
 =?iso-8859-1?Q?pEPrRiWBtiMirMY1o+BaSCo4c/oUZ+1wiqVgkYdtvXWxyJhqKZHXZx8lpM?=
 =?iso-8859-1?Q?lmSfo1GWT8hPOSC/DfkpJ8LTYq8SRk4/EhL4KcX2ZVZ0T2xVAkTwPDRbMf?=
 =?iso-8859-1?Q?n2/oyg0jl/q6ZgFIKTWxARbCzY6baNlwvnf8XMt8xDqvbp8eSJpNASPAK9?=
 =?iso-8859-1?Q?qI6HpLi1VJ47yAzYn4xdduqz9vK2dvlYaCjj4HFcKXc/1cec7/b8bpclp9?=
 =?iso-8859-1?Q?abEj5JSx0xB7YbglzV28vTuJ4/Syde3T3Pg0mSyjDEa2koNDasQzpkKsJB?=
 =?iso-8859-1?Q?oD2J8e/oDOG5DgeDPFQiZriOTvhfhHh/ya61MNoD7NdC3fwj8W2Ff2zFB1?=
 =?iso-8859-1?Q?TkAGBaJZ2kDC8+2WbzXZO8VwLQjdNLCRg94tUj480klduCUdFS6kzPcnEw?=
 =?iso-8859-1?Q?xVtkzeF/Uu5OpeSIpdnzQWc9BUwPSuvwpqy6kF2pB4ltnCKdnB5htROinS?=
 =?iso-8859-1?Q?q0/U8KXn5rin+dURSt+HYY9MXd9o77QKrCH2IHCo8uPWDKOU6fp8GeTK/V?=
 =?iso-8859-1?Q?nC1s908vZUT5WGlcYnM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bm4nq4wucdIzWaexMtf0H8UWOWueVqiByN/F89UxzbicwPUt1uvTv6cKAv?=
 =?iso-8859-1?Q?2f3oZiRCFTBqHwBKSV7N1c6HX6WDf4Ddzaad0zswf4EFcNf4/RzxzjLbNH?=
 =?iso-8859-1?Q?Um4OPRpLPO187jaZ6bq0fklCuDBr4c63GpremPn2wE07/FDzO9cdVrcMbR?=
 =?iso-8859-1?Q?PITAkxpN/Fg2i0N/zixn+NNlqwudRbeDaESzr/+NhcfUy/ufiuA2JVllc7?=
 =?iso-8859-1?Q?awJku6m813St1MjsGBHW3l2D7XPyHijlaRFDBz+Ui2cMBdctBIQRg98SSk?=
 =?iso-8859-1?Q?HZv24yoCXSzCEWqHbV6ZloDEnqwSDBRmPnFt/O045NLmRLMgcPXsZi/Lpg?=
 =?iso-8859-1?Q?sbS79s+QSDw+Riy98vfUwZZEijV+gz8VNEC6lg1HL3ckraAUDiD51+KjFa?=
 =?iso-8859-1?Q?iionc0QbX9p7uSDC5DQbkFI0KK+XZvu8CEXRk2pH3hRonu+8VYaOdxCbYx?=
 =?iso-8859-1?Q?LnKGSgPA3GBbN5O+ykZCwU16AQ1PX9rkVPc8Tif2PZsXlgX1vMyjE+ee/H?=
 =?iso-8859-1?Q?6NCRLzCHVkrimAcFe5OQLb8LoQqm8nmF4YkGztRz5zf0vd4urcqY3cQnwa?=
 =?iso-8859-1?Q?7EqxakBIItpfDtrxFm1YHyonsOfcfXfsW0uIo22yUCtwT1vp6Z8zOv5B5i?=
 =?iso-8859-1?Q?kBclWxLuSq/tfaccjUsSqzAdBtJ7MSBp/WJqGRit9VKjzeBb1z0dI/rkHP?=
 =?iso-8859-1?Q?7Q/p3WBRgh1BY7tFEbC8XZZnJbNyAxNgax636yv56FPnSEYW5xcBx3sSkw?=
 =?iso-8859-1?Q?U5ja8E1/GCRcha36zunqkJbb1StVLyAmmOvzNxV8/KrGQn7XZ/VJU8Cm8t?=
 =?iso-8859-1?Q?DRTpCDq+xy1GHAR1H0JJ+Cnz8llFIQRXDUvyLtZpLl5jlOAPy0IUzir9nK?=
 =?iso-8859-1?Q?kigyPiq66bOQ0DjOG2/YdXYPYx4ThDSBWXKrJpbHho3cyCNtiQtPFIzRre?=
 =?iso-8859-1?Q?upYgTnMfClEl71gvWjeX/KO/Lvsez0y4WLwO/9EdmD58i8lXBoEIHt+tJ6?=
 =?iso-8859-1?Q?igzghcal4gyeGmkehw4E/0kcnIsZYBQdmjDP+zj/zz0Kqu4G0krseW+x03?=
 =?iso-8859-1?Q?Xe1SpnyTpRq/OfackjwGmA2bQqTGSn3rg/GO1Pt/o+fnPKJynUP64DDgDb?=
 =?iso-8859-1?Q?THE0401fVG5zqPvN7YQGXeRw8qhOWcNXbOi0V4FfseLzrxZZcWCWos2GPe?=
 =?iso-8859-1?Q?ONxyl2//zrvcdmVykGXIIAwLl5u5xorED5GjbrwFzztPrz+GgbrhY5GsYO?=
 =?iso-8859-1?Q?LPDWZPpjf7c19F5C1YT0048PS/XMHaQaW4SvbZ7kTMhA6J57vxjoUBjFZx?=
 =?iso-8859-1?Q?o+gHwRh+wFuqAkb/Bb5AN1UP1giU4ra/N3DL+pklCDVeoeIKs1/zZfVcAb?=
 =?iso-8859-1?Q?aNO0mGKwZN+plqgF4LvHrPrJAfiSCj685GK6eVCVm3kir6GFWTAdC1cp8/?=
 =?iso-8859-1?Q?cccnAhR0ryD14PZXkedy1xVLp4+k5CehAXmycus8FnrUfat1tIpUPjSjN7?=
 =?iso-8859-1?Q?Yunh7GDCmeSFhqSUJSsJC68v4jGSi2qx2MbWZCntOCN3FWrNB96BTojisp?=
 =?iso-8859-1?Q?znvfO8kJHokSuyGEztGZCJYUBLOsNT7okHRdSUman1StcYt67g74WQrP7q?=
 =?iso-8859-1?Q?rc+nOMV1LFATypugH+H+sP6WpMEVlxGeEYKOdWrhLpv53TIh9BrJycRe75?=
 =?iso-8859-1?Q?WY5dMhpnUYEXTzpoMpx5BxpOCfi+1ZmwoVoxOV/VZYzHNo/H9uOTZeiyhF?=
 =?iso-8859-1?Q?H0TOnClknzFvFlpRLkVrBPpUSbL+8pjcZbAcENCzMVYTo5teFTX87JSc6T?=
 =?iso-8859-1?Q?BXARNR9+mg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b088b15e-aa92-4fe1-3435-08de63ac1058
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 05:12:59.1841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUx6wda+SYpCL1p6TEabIzqc+uqBLPWAdibC2tu/Q4onzpZbugro84qIZ8fBSFbjz/bECbLu0vF2aKb8N6oeEQ+TI2v8c64TcB2Sj0MrM2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
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

Hi Cedric,

> Subject: Re: [PATCH v5 12/12] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> On 2/3/26 08:30, Vivek Kasireddy wrote:
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
> >   hw/display/Kconfig             |  5 ++++
> >   hw/display/virtio-gpu-dmabuf.c | 49 ++++++++++++++++++++++++++--
> ------
> >   2 files changed, 43 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 1e95ab28ef..0d090f25f5 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >       depends on VIRTIO_PCI
> >       select VGA
> >
> > +config VIRTIO_GPU_VFIO_BLOB
> > +    bool
> > +    default y
> > +    depends on VFIO
> > +
> >   config VHOST_USER_GPU
> >       bool
> >       default y
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index 22e66fbb12..2e65f21dda 100644
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
> > @@ -27,6 +28,23 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > +static bool virtio_gpu_create_vfio_dmabuf(struct
> virtio_gpu_simple_resource *r,
> > +                                          Error **errp)
> > +{
> > +    bool ret =3D false;
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    int fd;
> > +
> > +    if (!vfio_device_create_dmabuf(r->iov, r->iov_cnt, &fd, errp)) {
> > +        return false;
> > +    }
> > +
> > +    ret =3D true;
> > +    r->dmabuf_fd =3D fd;
> > +#endif
> > +    return ret;
> > +}
> > +
> >   static bool virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res,
> >                                         Error **errp)
> >   {
> > @@ -72,18 +90,25 @@ static bool virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res,
> >   }
> >
> >   static bool virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res,
> > -                                    Error **err1)
> > +                                    Error **err1, Error **err2)
>=20
> This looks wrong. Why do we need 2 errors ?
As seen below in virtio_gpu_init_dmabuf(), we have a situation where
there is a need to collect errors from two different paths and report
them only if both the paths fail. In other words, we do not want to
return an error when the first path fails. The intended goal is to inform
the user that one or both paths were tried when a failure is seen.

For example, in virtio_gpu_remap_dmabuf(), we first try to do mmap()
and if that fails, we capture the error in err1. Next, we call
vfio_device_mmap_dmabuf() and if that succeeds, then we do not need
to report err1. However, if it fails, we then collect the error in err2 and
report both err1 and err2.

Is there a better way to handle the above situation?

Thanks,
Vivek

>=20
> C.
>=20
> >   {
> > +    bool ret =3D true;
> >       void *map;
> >
> >       map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> res->dmabuf_fd, 0);
> >       if (map =3D=3D MAP_FAILED) {
> >           error_setg_errno(err1, errno, "dmabuf mmap failed");
> > -        res->remapped =3D NULL;
> > -        return false;
> > +        map =3D NULL;
> > +        ret =3D false;
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +        if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> > +                                    res->blob_size, err2)) {
> > +            ret =3D true;
> > +        }
> > +#endif
> >       }
> >       res->remapped =3D map;
> > -    return true;
> > +    return ret;
> >   }
> >
> >   static void virtio_gpu_destroy_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > @@ -137,7 +162,7 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    Error *err1 =3D NULL;
> > +    Error *err1 =3D NULL, *err2 =3D NULL;
> >       void *pdata =3D NULL;
> >
> >       res->dmabuf_fd =3D -1;
> > @@ -146,12 +171,16 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> >           if (!virtio_gpu_create_udmabuf(res, &err1)) {
> > -            error_report_err(err1);
> > -            return;
> > +            if (!virtio_gpu_create_vfio_dmabuf(res, &err2)) {
> > +                error_report_err(err1);
> > +                error_report_err(err2);
> > +                return;
> > +            }
> >           }
> >
> > -        if (!virtio_gpu_remap_dmabuf(res, &err1)) {
> > +        if (!virtio_gpu_remap_dmabuf(res, &err1, &err2)) {
> >               error_report_err(err1);
> > +            error_report_err(err2);
> >               return;
> >           }
> >           pdata =3D res->remapped;
> > @@ -162,9 +191,7 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >   void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    if (res->remapped) {
> > -        virtio_gpu_destroy_dmabuf(res);
> > -    }
> > +    virtio_gpu_destroy_dmabuf(res);
> >   }
> >
> >   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf
> *dmabuf)


