Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2B0CCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 03:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJOBk-00022r-Pj; Wed, 12 Nov 2025 22:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJOBg-0001zE-RM
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:39:56 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJOBd-0004XI-LI
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763005193; x=1794541193;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xY6vSLQoWrgw2GnnXjuSIjOtna6ziZLg2oLlMRq18yI=;
 b=LifFjXUviMdv3Q6UfypbdQduAgp71rc0sN5bMW3j+iwBdMyCeKYTl7WN
 D1mt2EDGwtEZTcziKtkZcxlc+k+yPuCMz5oUu2C/8Qon4TyOVSt4TOglu
 KgV7IDte+5xOguXymDYiUO2KD3SvsX9lgJ0c1Ic9Mv7pn3mJuvnnrYcW4
 czhe9wCxXLyq3Mi+AALExNSBuAeQ5Z9Waq2069v2EjPh7ffE2xf1LFviZ
 7P7yGU1RD42quRhPbj+LJ/8lw/LauGN3ML4zHWSGTcid1zKYUlSStqg5K
 8iu+QcgI9dAGbQ+510AzPZFkBuxAfy4m5N/X+bOnnmgP8dg9MgzmQdyJR g==;
X-CSE-ConnectionGUID: ctZteujSTd2APw/sqFhGzw==
X-CSE-MsgGUID: py5VgUXcQ8mY8KoQxo9TSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="52641185"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; d="scan'208";a="52641185"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 19:39:50 -0800
X-CSE-ConnectionGUID: e/BoNmU5RyycZCiDq2Iw4A==
X-CSE-MsgGUID: tppcQZDzSfe1QfJuTuulTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; d="scan'208";a="194376194"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 19:39:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 19:39:49 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 19:39:49 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 19:39:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ6456O4W4E5g4GbMbQzj3hTsPVWT5WQRuaMmhjxc7y942H97l9aeOsfmnEqGKGzsfGKi3yyU8jbEQoXnqwg1s5fd4QLUp/lc7PYeY3IbFB4xhDFZUPGsDmtmvvOmU/25iCDUy9fP60jVFEAQANSbbKUlbj30vtRZ9h8kdoG05unFIddYhWz0i/Qm81nlB1DUy1K/8/6GgeU6N7qRfbBcWzyMHFU7zSpGblGP1z1auYmQibcTaI9MTl8hxCjn/h0lVBAEB0njyMbs/6yj2vRG8wXcGB8BZbkzcuvek41U7WKZDeeJV0b5CSBPLFwQUBgnzuZN2kTiSWVrBsZXcu3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fjObBpYCbxzVJSOnRoU1Zb/aKSfSDb6dy3FTb0RrQM=;
 b=DJF1JLFBOmbvzq8y2q6T//uknIYAQSOPDiQA1y8wuqD2TeIkvmJBq04KEHEGMK/W4Shi4yuajMk4WbXxup4W5EI+d4kpCMqyVJxGFhORrmosPC6NuTgELEOwzFhbzDQDMaEkmcO1iq2JSnHr2ECAnYNUplO+VqjXonTsFO1iaFmHWQntacryi/oiMEi27cjA/vZm85oloyD30YnOAoL/0HmHybavLBWeLaq1U8ZFKbYc+y/m6Qz6zV3VkNF1FgTazk+gQEY3tlyQinzIibHTQCc9iRCfBw8QKQ4UbqySK3tyYiD9/Pu+P/O/9QgMC7V1emSfW243UBp/5jWi2IJMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH8PR11MB6778.namprd11.prod.outlook.com (2603:10b6:510:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 03:39:47 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9298.015; Thu, 13 Nov 2025
 03:39:47 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Topic: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Index: AQHcUTsfaCBAQNqK6UqI5jTHJ6PIg7Ts6XoAgAE6QFCAAJJ2gIAA3p9A
Date: Thu, 13 Nov 2025 03:39:47 +0000
Message-ID: <IA0PR11MB71857687EC63A9A8D46476C7F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-3-vivek.kasireddy@intel.com>
 <ea2e1bd7-d681-4929-b902-1948b854e488@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185866AD30B9A73097934CCF8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8b8e3b19-7696-4b7c-8d74-eab2028dcd02@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8b8e3b19-7696-4b7c-8d74-eab2028dcd02@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH8PR11MB6778:EE_
x-ms-office365-filtering-correlation-id: 82a33497-07e9-45ba-d2f2-08de22664aea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nQZl+9Am+onIPDS7W8VLN0+5ZBa91cxDVoAfNV8y2FUH91SvmWagwxHkF8?=
 =?iso-8859-1?Q?ZhEk+/Djbx9jRgrL4iGVI/iEc3Ts14Iqk7aDUk+Htvd2BcK51eTnvtrhPd?=
 =?iso-8859-1?Q?mj1Mj90AxZBLz1yiD6SHwazmZBDVqFDvvWWNN3DzNMRaJsYh1RAEW2UqZy?=
 =?iso-8859-1?Q?ie1NPdZ1eptJkevsIlnQr/wcfZIa4+j0qH3qkLeyZ0eXbWDVN0OLhNF6jA?=
 =?iso-8859-1?Q?qqFeJhx4BFyH8iIBkmCVItUqm2axY+EBo/uSLYv21FJi7QuJnYQOKYk3bj?=
 =?iso-8859-1?Q?oEL6iQZVMTA+JVNPJSR3196K0AOfdpI1KmgaSM5awIRIkltilsPK7gPdIw?=
 =?iso-8859-1?Q?Yr7t9HqLl491/R84fu1tYT97IcoNo//ke7p5bva4PKQvaHWbnVCWOflelN?=
 =?iso-8859-1?Q?SaC1RhFysLz5OKR0rjB01O9pthvh+JTkD3B+EwFGSTgEpX6aK1ItgGQ6KP?=
 =?iso-8859-1?Q?uYCcMgbwqfTSnFdr4kR5A4vfvbR7757mhKC4NA4AvC0khuuNDoCVhEUOJp?=
 =?iso-8859-1?Q?SrUKsdl8FgSjEYjWNIEbaqIVumhqkzbtR/7+Iuhq/GFtkR91XSsnCo3auf?=
 =?iso-8859-1?Q?JQMcNVEXdFmXUCbtDeqJBIMK094aoQ+Ngd36tU72DDRs+M062jBw38vwbv?=
 =?iso-8859-1?Q?OER4z66rUUBDCo15Njin6AKqVDqECM3DPjLNSCOXKqoADoSD5moFcVGjcD?=
 =?iso-8859-1?Q?odSTn1tcWmH8AnDb4zSbk/3J3N+ju9fdcax8EBxfO/3Qp6INjaWUei0gCI?=
 =?iso-8859-1?Q?iSvhuUsWnWZqo6DHiU2LyZsVbEqcHcZ72G/us4irCf2ZFdlCVzOpgZEy2v?=
 =?iso-8859-1?Q?RAImI3WVoCI+iTg0k0VjU+2MVHvegkPBIct3StPiAtQIs/BPguxxzwwuJs?=
 =?iso-8859-1?Q?Vyw1OKV264x21aCBAf19CBZbblOa7t1RRe4Hx42zzX5qVNqTfL3NfReqyV?=
 =?iso-8859-1?Q?SXyPkHlqHf1MgXTXt/BGBrIHN3UzweerZgjBv0axA8YIpDVpUJRCYWuh0c?=
 =?iso-8859-1?Q?KN1PVyiyOg2kobDSbugLC2Zc24aqi5ZXiQ+/2Jme/YtYWqiLsJ1x11QoqN?=
 =?iso-8859-1?Q?x0cegxgCFdCmj33/9xS/bDFogUQX+GdnyodK4fq+YZiVdin2EW9LZSk08w?=
 =?iso-8859-1?Q?XR+JmS9wOWMlZqVKjJ0J669NtUJW1ISO2XBEbWX2oHzobqdYWzdEXA1n1s?=
 =?iso-8859-1?Q?5b8m0RBJmYNyCM3XPtNTA0mmns0DGfPdVTUbV7s3uCeBr45h53EOLrjye+?=
 =?iso-8859-1?Q?2Oj5dsDHw/kf1zO3MbwRxaQSwPDudjct7obsd3napsVpCzQ2HoilPa5Km2?=
 =?iso-8859-1?Q?4BLf4JMtF00izEsSMI/3QtWWasWGhtNyVl76S9oHY2vddLYNbsCCXXDJ94?=
 =?iso-8859-1?Q?hkw4Z7FlvQhMIiAkrtGto34L/wQvGtMnFHYGdHSa78OAAQt/awKMUIvtFw?=
 =?iso-8859-1?Q?EGourSSjLY1MvrNseHnCGPJjWWCLAiE6K50b/CxvtYOsqlYyuAGdYoX1oF?=
 =?iso-8859-1?Q?hDyn6C1AY5/Fu07QV71h1HHDoLs5DBLxPvxNumH2+YHNzcBDKb5hYKa4+a?=
 =?iso-8859-1?Q?HoZcxwbzOxFnLFTOxx8lIGEsvMb/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m7qyyDe/UpgWA2/tvlyozIEKOKt97ihPxlnQEa/FI7/PQeBrjf9tTM/HLd?=
 =?iso-8859-1?Q?nwBxEJlVuyjUwYhEvKPtV8bSJzB3RfZxojJfg78lryUwZK9CaiXsyfdbCY?=
 =?iso-8859-1?Q?Qg9zA8bZC4k/PQSKPyp+88murVkWCjMEnyz8gRVTDSXAVn+nydGJ82LhQC?=
 =?iso-8859-1?Q?edWiFFYUUM+VOSCjLT+hzljPxKgrjHnehzfJg4xf8cXaKLzIyLC8mRsTev?=
 =?iso-8859-1?Q?Kki5oMmXW+seKubeUqoQFLMiDKP68l9sTy/wMgvJ2U+pz6kuHNJKxuRfAr?=
 =?iso-8859-1?Q?RGGmTdoIk8CYXhrmG0JuCbVYlxmUoL4sSoSq0uALkeGSXq7edeDe+31m8z?=
 =?iso-8859-1?Q?eLx8dkzCz3EA4WEHn47+QhPrtTVAN4pZGDQ8pMUPTbqzHPL3cp8KjjRzPK?=
 =?iso-8859-1?Q?k0Y/dWDpF/uRuogXFCaRI4Q60IrmIiaUgqrFizhVnX0dr4hdnPMK7RuCog?=
 =?iso-8859-1?Q?LcspeB5XMYYOqaKK2QHRc6Sbl/njKErPSPYgQOK2kuubNBgqayM9S+XemV?=
 =?iso-8859-1?Q?GLFCvV4hnVP/vcF2ZfKTyk5qzuezCn66QoQwu589lOh5tKnV8XlsTnRwtv?=
 =?iso-8859-1?Q?x8Ly+ayr0kEvagC3Vr3gHbjG4KiyzEp6uwy+EJ0O2oHh94yw88wvgwT/In?=
 =?iso-8859-1?Q?HLM3A16cEw42PmY+aWNw7zCf92bAXGAKa9qqORvV5vWcvTnHP0d7l6Py6M?=
 =?iso-8859-1?Q?tRzyiR7wUsFtzr940vGWMurslMND38US07zBIxBjd00nsY9RhDDbMBfTD5?=
 =?iso-8859-1?Q?3rDjK0MbPOYHmb2p8yEiJunaK2aqI3CKcNKWucCj4hcZ7iTRohplUUU34w?=
 =?iso-8859-1?Q?o32s/qQjf9WZpT+H5vVt5lVFyvT+thVco0MEVLsR+EGy/xWYAnLLZr4Bxo?=
 =?iso-8859-1?Q?ZLKaMsp5hIk3gJIb4FcPIdgIaW5P7nVS7xjW498VQRSC3LzPBgvO4S28XC?=
 =?iso-8859-1?Q?mMhj00pgd4nCg4krZGZqXIHi0d7JVxkk4MOBe4Xvc61c0GnL0+wG2siKPO?=
 =?iso-8859-1?Q?qArHdx25mpC5hdzjSWm8Jm0TWHF+2EvYSgvXhLeA4gU7XDWgWW4iNwpIm+?=
 =?iso-8859-1?Q?MZjEMumfMU3snTjmpkMvXx5kEt9wx6KaZ280bNx7USBvDz62jxWc+j5ZAO?=
 =?iso-8859-1?Q?YwQmeHzoiMojteAELBjZQR3+j8fSSOPiIkxwoMxQEpdi0dMTsjgGR/Wmej?=
 =?iso-8859-1?Q?CGUiPYZW408BhczHkBwbmmWp1lzKq3k+IjSdiFwo3kJrhsPCIkHP1Bs59n?=
 =?iso-8859-1?Q?pW1t/GoaAbvSolP19Hys9168mDGiu6ts+H8VgKF+AqZ7GmNeNwa+F6SLW/?=
 =?iso-8859-1?Q?QXb7O3oTrwZFe7AIM37zR5eilZFTWnF7tVgGFKjDrvaQcMh62SCSx6ZRy6?=
 =?iso-8859-1?Q?YT8y71+6CYi2eVV6Dyp9/qEuviTz9dAnhmQLWkiP2y+vHzTdTQLXQ1jcih?=
 =?iso-8859-1?Q?Jlr6fyiLdNX774efCJmb+DqTIpgU370al3qvRWJLkdWG/XSiuPt7evtp0L?=
 =?iso-8859-1?Q?EJFND5cFrQ3ZKl7SnUMnxPNQ/gueFm1T0MU2VLPEBt/gF+2MbqKGEGYlWA?=
 =?iso-8859-1?Q?L1K5NelYaC416nFUTQcjeYvwlfTa4nsRcW0/eWms3sFPaOBJx+VBx3J1od?=
 =?iso-8859-1?Q?HZ9nrhkbl5OHhfs0OqiST2EEV77/KJas98?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a33497-07e9-45ba-d2f2-08de22664aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 03:39:47.2070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qblq+02p338dLBKiHTeB8ZTCeZLt1hTXf6NujWYORf12mSXcvCVbfY2X1LT8bk1Gmzc9iaRDk2WngmTbjY31CDH4mBWN+mmZChm7cvEcm1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6778
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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

> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
> associated with a ram device
>=20
> On 2025/11/12 13:30, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA add=
r
> >> associated with a ram device
> >>
> >> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> >>> If the Guest provides a DMA address that is associated with a ram
> >>> device (such as a PCI device region and not its system memory), then
> >>> we can obtain the hva (host virtual address) by invoking
> >>> address_space_translate() followed by memory_region_get_ram_ptr().
> >>>
> >>> This is because the ram device's address space is not accessible to
> >>> virtio-gpu directly and hence dma_memory_map() cannot be used.
> >>> Therefore, we first need to identify the memory region associated wit=
h
> >>> the DMA address and figure out if it belongs to a ram device or not
> >>> and decide how to obtain the host address accordingly.
> >>>
> >>> Note that we take a reference on the memory region if it belongs to a
> >>> ram device but we would still call dma_memory_unmap() later (to unref
> >>> mr) regardless of how we obtained the hva.
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex.williamson@redhat.com>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/virtio-gpu.c | 24 +++++++++++++++++++++---
> >>>    1 file changed, 21 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c index
> >>> 199b18c746..d352b5afd6 100644
> >>> --- a/hw/display/virtio-gpu.c
> >>> +++ b/hw/display/virtio-gpu.c
> >>> @@ -798,6 +798,26 @@ static void
> virtio_gpu_set_scanout_blob(VirtIOGPU
> >> *g,
> >>>                                  &fb, res, &ss.r, &cmd->error);
> >>>    }
> >>>
> >>> +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> >>> +                                       struct virtio_gpu_ctrl_comman=
d *cmd,
> >>> +                                       uint64_t a, hwaddr *len) {
> >>> +    MemoryRegion *mr =3D NULL;
> >>> +    hwaddr xlat;
> >>> +
> >>> +    mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as, a, &xla=
t,
> len,
> >>> +                                 DMA_DIRECTION_TO_DEVICE,
> >>> +                                 MEMTXATTRS_UNSPECIFIED);
> >>> +    if (memory_region_is_ram_device(mr)) {
> >>> +        memory_region_ref(mr);
> >>> +        return memory_region_get_ram_ptr(mr) + xlat;
> >>> +    }
> >>> +
> >>> +    return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
> >>> +                          DMA_DIRECTION_TO_DEVICE,
> >>> +                          MEMTXATTRS_UNSPECIFIED);
> >>
> >> This function should:
> >> - call memory_region_get_ram_ptr(mr)
> >>     if memory_region_is_ram(mr)
> >> - return NULL otherwise
> >>
> >> There are a few reasons. First, the documentation of
> dma_memory_map()
> >> tells to use it "only for reads OR writes - not for read-modify-write
> >> operations." It can be used for read-modify-write operations so
> >> dma_memory_map() should be avoided.
> > This patch series only deals with non-virgl use-cases where AFAICS
> resources
> > are not written to on the Host.
> >
> >>
> >> Second, it ensures that the mapped pointer is writable.
> >> "[PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated
> >> with VFIO devices" adds checks for memory_region_is_ram() and
> >> memory_region_is_ram_device() to virtio_gpu_init_dmabuf(), but the
> other
> >> callers also use the function to map writable pointers.
> > Unless I am missing something, I don't see where writable pointers are
> used
> > in non-virgl use-cases?
>=20
> Rutabaga uses too, but you are right about that 2D operations won't use i=
t.
>=20
> That said, exposing non-writable memory to Virgl and Rutabaga lets the
> guest corrupt memory so should be avoided. On the other hand, it is
> unlikely that rejecting non-writable memory will cause any problem. You
> can also add another code path to use
> memory_region_supports_direct_access() instead of
> memory_region_is_ram()
> for virtio-gpu for 2D and avoid calling memory_region_is_ram() in
> virtio_gpu_init_dmabuf() if you want to keep non-writable memory working.
AFAICS, virtio_gpu_init_dmabuf() is only called in non-virgl/non-rutabaga c=
ode.
And, this patch series and my use-case (GPU SRIOV) only needs to deal with
non-writeable memory because the rendering is already done by the Guest and
the Host only needs to display the Guest's FB.

However, I see that virtio_gpu_create_mapping_iov() is used by virgl/rutaba=
ga
code as well, so I am wondering how do things work right now given that
virtio_gpu_create_mapping_iov() always calls dma_memory_map()?=20
In other words, is there no problem currently with non-writeable memory
in virgl/rutabaga use-cases?

>=20
> >
> >>
> >> It also makes the check of memory_region_is_ram_device() and
> >> memory_region_is_ram() unnecessary for virtio_gpu_init_dmabuf(),
> reducing
> >> the overall complexity.
> > Since buffers reside completely in either ram or ram_device regions, us=
ing
> both
> > memory_region_is_ram_device() and memory_region_is_ram() to check
> where
> > they are located seems necessary and unavoidable.
>=20
> It can unconditionally call virtio_gpu_create_udmabuf(), and if the
> function finds the memory is incompatible with udmabuf, it can call
> vfio_device_lookup() to tell if the memory belongs to VFIO or not.
Yeah, what you suggest is doable but seems a bit convoluted to have to
first call virtio_gpu_create_udmabuf() and if it fails then call VFIO relat=
ed
functions.=20

I think using memory_region_is_ram_device() and memory_region_is_ram()
to identify the right memory region and calling either virtio_gpu_create_ud=
mabuf()
or vfio_create_dmabuf() is much more intuitive and readable.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

