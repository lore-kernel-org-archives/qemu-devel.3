Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867DFCA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 06:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy2my-0004uO-GU; Mon, 15 Sep 2025 02:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uy2mv-0004tz-KQ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 02:34:10 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uy2mk-0003Tx-SQ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 02:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757918039; x=1789454039;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y8FXdlON1LCy4vuEsxEzCysoluG0ZBoMOl6TUoDhwCI=;
 b=gl+SSqumGa2TMFaXo/qcHHN58zb8A+Q5tUJenJSE1S08+SZ5tJSJbEiN
 fwffJCpX6Dq7GXpShf68uEAP2A8yRFDKXuEh8L9UtsRes0Q7u7zPir3+Y
 YVYylym7yurrTl+tDPYhFZBwTBZS9Pn7QfF2CWVigG7yHd5Xl5E14wI3n
 TCmfBBlgtTdim8Jpv24E1MkzBB9g6TeExCnnYWwr0hXnqtFZ1++UltYOB
 yPsOjwT76Hdu9Sf46Zz0aF9nMwsJdJUOLdLSzxIWO28L5JdxiZ0Ese71R
 OFNtQR0grNvzVNtBK7Y/o3XsvlbXKtm4wMfD0coAAQ8aCIfWAp6S2B/p/ A==;
X-CSE-ConnectionGUID: saYDJJK3T6iKxypKlE7uhw==
X-CSE-MsgGUID: mat7VOBmQa+MFs03lJTQBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="82750513"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; d="scan'208";a="82750513"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2025 23:33:50 -0700
X-CSE-ConnectionGUID: Y3PnrdyaR5GjHZQq49YZ3A==
X-CSE-MsgGUID: TTvzrv+4QsajLtg87Amecg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; d="scan'208";a="173677505"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2025 23:33:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 14 Sep 2025 23:33:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 14 Sep 2025 23:33:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.61)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 14 Sep 2025 23:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKfg++AI31NxsSW6CdgYxfvQ/kzYYy4b+rh/Q7OD96VTEHVnDMP2GUg+Cq+wkTi5hudIK+UL22DK79uDeNoF0li4y3j1Fpt++JLDDi/Kp2Tlv9Af4gPrq1NacUpQ/xrwpLWyL8j0abiswSJAw5uXBIiYi9+YyO/cdJae2r9ddHN/GPzWxbdRS58j5hkyAJePp4ANZWVJNEdcg35X9l7Np6n24gW+WXOT66rVEXVZatn88HjuE+7VLzHSWtNPnpIEseojfzaVYoffdYG9+3rnxEB3WBlHL8I7nvwUXl4+BjIHzhFowuWS7Y7stCLLcjxyEx7eEExO/W4i04vH7FYYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeCWhGCi7tHliqWONHWmC5JtSnwNzaE5RtXvdiVnM8M=;
 b=CDbgaodTATZrFnKIvWuptLFErqMu3GseuUXmdjUvzBgZdbamP8DGsVdq8DvuIn2OdbEPd6t3jB/8QXo/G1xFGWYthRrDOGR9TQ01I0vLNkSfI8kMee2vPpeo+aj96QfgsZLted5J/FrNsrXetCr7TDkbRPZonRwcDBzUYPjgG6JZ0DuGghs2YrWcZmWWTrgF6kBWh3WJdzd3btWf++pXq1jda6h6bcWdle60gGkYTjSZhTwSZ+RISygv5oDJ8W7zzgVObW65RuDhes9gt98tBFLhJEYTqEb9MYZwZi9L3MrbJj+TAamWymLB6/23kuDrGEbezDTbLgJTfwngFHlrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS7PR11MB9500.namprd11.prod.outlook.com (2603:10b6:8:258::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 06:33:48 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 06:33:48 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
 resources
Thread-Topic: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
 resources
Thread-Index: AQHcHJY2YKFPoBQc1k6SDELAvZKU07SFiqKAgAqO7zCAAj6KgIABcGJw
Date: Mon, 15 Sep 2025 06:33:48 +0000
Message-ID: <IA0PR11MB7185329E174E270F6911FF03F815A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-5-vivek.kasireddy@intel.com>
 <26c02124-eb57-4d50-bf8d-1fa809984adc@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185758D6CD5D2774E6373BBF80BA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <43a98363-0607-42c6-906b-4f79e5740ea8@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <43a98363-0607-42c6-906b-4f79e5740ea8@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS7PR11MB9500:EE_
x-ms-office365-filtering-correlation-id: 0a2a1b61-cd3f-4c47-7543-08ddf421d3de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OVP3AvUKv6w7cyyEDVZsRDw8y8SPONIvSwa7DxI/4DmZXbNkwa7Uu5xo1s?=
 =?iso-8859-1?Q?D2uYvmbYwziUvCcOhfG4pxtJgNBX2JSnF/6HKvn7QIUydQ/rWcbYMbfytb?=
 =?iso-8859-1?Q?w+CvUrZQA0MDLUaarzw0QFIviH2t13m7H4Sj6fv3H2itw6ghk3XILO5Htm?=
 =?iso-8859-1?Q?r+RcOQUdRUkbb+pN8vrEVV6wwy2ihMBfu8C1bwFU/pxhZ35t3j+YRX8Jxd?=
 =?iso-8859-1?Q?F6CgboC5H+lsKCQwr91jjNN2+kKLYawetAxTXDBdCzcWskOSY6P192W5Wf?=
 =?iso-8859-1?Q?XgV9Np59TbsA9x3SuskuFPbbXw4wNIA7z77Vl2TP/hucYXsN50I4v/fToS?=
 =?iso-8859-1?Q?eRjeyPNyCmUYYKfzIVBMoz63/yxzog83Ge5ruhJRkKX+IL+8J41EiPntMU?=
 =?iso-8859-1?Q?sfa2S+9kZI8H8LxCXIgXatN2LNJ1YRaBmc156B5O0Oijy62DbWwoeRrm9A?=
 =?iso-8859-1?Q?CDZlEAuPiEyDa0b/Kj6x8vQIRXMCrHNn0IkcKG2ZNNdSR/PA8K+dkTyTqc?=
 =?iso-8859-1?Q?kgsjWCQVnlZwBFCUQMNSfGNcJ6kS8RpyVFBqMbb/25zudXmvQrvqRvFZdP?=
 =?iso-8859-1?Q?wJjm8Kzavcoyd58zuDAC4uhoSsOchXqKRIirp1slt2bUYqfM73Jlr+aFKa?=
 =?iso-8859-1?Q?4R60WavOsvBw2jAeINuJcWQseRacAK92isaxtmb1/jJy9i/CPa7/dvDm5K?=
 =?iso-8859-1?Q?KiRBilo+FyY0ME3ML9eBR0rNn2DAVPxdpnxshnt/i1K/XojxxfehS3c3Bn?=
 =?iso-8859-1?Q?92nzukkMNVraeePgDk0+6MIexxNiFKIte+fy5uUBk6INDYkXiXcjevapJk?=
 =?iso-8859-1?Q?0uxPwpt7N8fL/XvsUUBiH6khsVYEj9ZpIE488Cv/MQx7qKn9LBgVRmPPkF?=
 =?iso-8859-1?Q?FtJtgHvqdA+vti5JVOT2dyhvtqqtu3XOF8CxYaF+MT3uiR2I9riTFlYofR?=
 =?iso-8859-1?Q?T6cnvxDuKHOreiihUasCmjQ/ItFyea8R4UlYubea5jaeUQQNIW+4viC2ok?=
 =?iso-8859-1?Q?ADi+7x+xT+du+E4k/pMcPNOpttS3zf91IJ44kn+3wyH6feXXuz4xfypfiw?=
 =?iso-8859-1?Q?hUTMpQ4t8FqU/oBEka3k8BEZzR+I/jitaFHjZqNRTNWV+yTfjUZQ2woK9U?=
 =?iso-8859-1?Q?zgm8X1RjkHJsqCXDp9qE/rhmxtznh35SuqPvFrTQ6OAKxycruSbW6Bg7dP?=
 =?iso-8859-1?Q?kAA5KmnpjN40QMq5FjOdG3+0NwEegN7ya4NgDE4HkQ0qGPedKj3UK+NHe9?=
 =?iso-8859-1?Q?xAFPgvRsksn/c6lHKHS7W38jL8ziGGK0gvLfs+GsFd/Evo9Ff7igWkD5a1?=
 =?iso-8859-1?Q?ogkYeBtkRMrJ60pyQRv9U4g44UQJv1mdLc06ixrtz7ZFewZ3iP7GdcIOAE?=
 =?iso-8859-1?Q?Wy0JpeHB/dDh1msNvpxQgFoKk98AfA5FPiJSN5oR3KBQ5wk8pBhME0n8yf?=
 =?iso-8859-1?Q?VHKeYoWbWMMVy/euTyjwyZzU3Cd4eMw98AENSbXzWKWCxD+N/l4iSikNgm?=
 =?iso-8859-1?Q?kgg2cGEwKQGbBhv5w17pQRaz23YJ8noE505cJ4gSMbYw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2l/LqQiicMpVx0LmazhAMX7YcmWS2NMcynnjPxcwMTrV0x0ENxb6Q042gz?=
 =?iso-8859-1?Q?9GTUYjgApNaVVdYJ78tdUhKkYQQk8cZDK4ztMW3SZ2JZGjN4sa4zSFkYfZ?=
 =?iso-8859-1?Q?LMEJ+VsbFojh4Phk4j88pS0xWUWoX8oTPR81ZNZgJhETHgjXBdVi/uX/4B?=
 =?iso-8859-1?Q?B73xwenykV/JXa6T5UIzp+9jCX05Jpj99w9jlLlQRc9zqxnMBks3IKseY3?=
 =?iso-8859-1?Q?dvEr0mkD4VXZq7ov/BhA3H2yAr+x44EfBK23yoVMKqLoOAWGZZpN8+6uyz?=
 =?iso-8859-1?Q?ySgaattZ6f8qpUq3ECJU4z003LbdO9Pr7PfOW5SjcTiIY2E6rie0HBFUfh?=
 =?iso-8859-1?Q?dpq7JKN+EuxzR7ZHIClBw74WFxFgUYXhwP7yClfVDWl50rffMVDC4YkiQb?=
 =?iso-8859-1?Q?KmZmqxxgVGRaZ8/BeHf3ZkI/543p277auTIOR3v5F6VYTo+UH0abXKEfo9?=
 =?iso-8859-1?Q?22EZLKDwx79hYqi0mT5xLb6D6IbQv0P7ybwMN82IG84z9afTAyPv3HVg+3?=
 =?iso-8859-1?Q?8b9WWKX5msptyTewA7OwQQBbJgR5h2YBJorqmnBrNxKQaBGKK8DtS4lHhG?=
 =?iso-8859-1?Q?cCzORdoClXS6mYYsGnMMKBRNu6XIs6fAWFAza0QztWrRDW+7wsI8LX+kUn?=
 =?iso-8859-1?Q?yeljhweRfbt3K83xt+fBP/ksnWhoTSebfoZIWvcMwsCzLdOky6GdwOadiS?=
 =?iso-8859-1?Q?kYc95WNRkLnq1Bfm7wGUSPC+/FJP95ji7M6MOWuh1jaoi5cB9Rso+FaUOy?=
 =?iso-8859-1?Q?UUUXDBiNamOYN7M4jbQXR3J7ophtLtKXHNa7oDYeS2zsg4qvtnWTaRXvoD?=
 =?iso-8859-1?Q?3kgN969a7KE8AvdHzaOaBsftQmmLnvAzs4XSihXKGSNk1WpzSwwjqDu/oL?=
 =?iso-8859-1?Q?lJKlVPeGz7zV3fXwKwEQ3DOwvBJdJ4mnfauY8HW6x+C/rpGSfmcJW5q0oJ?=
 =?iso-8859-1?Q?zx/ycPRPsPxVkcekUn0tFVYpnzhOE5dci92+30WPuz6mK7mL4LnRhkeBiK?=
 =?iso-8859-1?Q?oPZ+WD5bhV+avE8GsUbUIe5NkB59N4T+Qeqehys2VcwDgp5CZoCPVQ4rz7?=
 =?iso-8859-1?Q?MLVOtzv+t+3cteSYXZtAqiVGHnF7qUv89qRquGjA8tBivwXAvaEKPXxY6n?=
 =?iso-8859-1?Q?Exic1xxbFnFnhRz6cLx8BB8kBYpHJ/8i7g1CBph2UDr1uKDwErv6o6Mxjg?=
 =?iso-8859-1?Q?8CC0Si9WsXo1kqLXs6LWFGI/nH7p7fLZT/eNisvJfk+bh63MZOQiC903pq?=
 =?iso-8859-1?Q?8+8QfCkRFlXV603DXVwRuuS2RhzPo6w0Up9RaTJ4nt73mX6YOmQ03k2J+k?=
 =?iso-8859-1?Q?7phcIQOV14RzeaRPpD4iwtnP6sKA5+MLHa33i6zw8iDBYOGbJPnmYwHSp7?=
 =?iso-8859-1?Q?2I+8b+lGja/Xb1r4qmv1rvECaTLK0dHB/HMA1RacYaaV8r6btCEphQTycd?=
 =?iso-8859-1?Q?W5BA2SVqsCsc6ooyRrPYcJ/KTtL5jXM5WDy95u2n+Av9xEj6compzG0LjI?=
 =?iso-8859-1?Q?5X6UyxcQs3qUUdBPAJCGHRp+uZ2ql5uMjKnouay+z3qXTEXWKihSMcf0//?=
 =?iso-8859-1?Q?NEltWAh6RbINQzLBXq1UEZK0b/XGigaRl6Jrnw+XHL7/rxxPkGKvB1CbMr?=
 =?iso-8859-1?Q?LYeuwrhG4wTOi3MT7fVl1UlVuHdXkNTzqb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2a1b61-cd3f-4c47-7543-08ddf421d3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 06:33:48.1785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FA7oy0fGp4vjPYLJljCUEI0BRp/IKis/hc9za1jz3V6rg8jj8HTtcCkVP3Oc8UjVvPVT+aRZGMRxQXR1ubgqRwISXrTaxHKN/n5iM9ZFjYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9500
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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

> Subject: Re: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify bl=
ob
> resources
>=20
> On 2025/09/13 11:48, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify=
 blob
> >> resources
> >>
> >> On 2025/09/03 7:42, Vivek Kasireddy wrote:
> >>> The res->blob pointer is only valid for blobs that have their
> >>> backing storage in memfd. Therefore, we cannot use it to determine
> >>> if a resource is a blob or not. Instead, we could use res->blob_size
> >>> to make this determination as it is non-zero for blob resources
> >>> regardless of where their backing storage is located.
> >>
> >> I guess this change needs to be applied before "[RFC 3/6]
> >> virtio-gpu-udmabuf: Create dmabuf for blobs associated with VFIO
> >> devices"; without this patch, the "create dmabuf" patch will probably
> >> create an invalid blob.
> > Ok, makes sense. I'll move it earlier in the patch series.
> >
> >>
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/virtio-gpu.c | 19 +++++++++++--------
> >>>    1 file changed, 11 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> >>> index 0a1a625b0e..2f9133c3b6 100644
> >>> --- a/hw/display/virtio-gpu.c
> >>> +++ b/hw/display/virtio-gpu.c
> >>> @@ -57,7 +57,7 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
> >>>        }
> >>>
> >>>        if (res->blob_size) {
> >>> -        if (res->blob_size < (s->current_cursor->width *
> >>> +        if (!res->blob || res->blob_size < (s->current_cursor->width=
 *
> >>
> >> I doubt that rejecting a valid blob due to an implementation concern
> >> (whether the backing storage is in memfd) is tolerated in the specific=
ation.
> > Are you suggesting that the whole if (res->blob_size < (s->current_curs=
or-
> >width *...
> > check needs to be removed? I think it is just a sanity check to ensure =
that the
> blob
> > size is big enough for cursor.
>=20
> I referred to !res->blob, the new condition. It rejects a valid blob
> that is backed by VFIO.
The problem is that for blobs backed by VFIO, res->blob can be NULL but thi=
s function
(virtio_gpu_update_cursor_data) is relying on res->blob always being valid.=
 That's why
the new condition !res->blob is needed here to check the validity of res->b=
lob.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

