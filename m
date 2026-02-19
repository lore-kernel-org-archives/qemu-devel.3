Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0BDE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 07:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsyQa-0007jr-6Y; Thu, 19 Feb 2026 02:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vsyQY-0007jY-2X
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 02:26:22 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vsyQV-0004l8-Or
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 02:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771485980; x=1803021980;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QxxYD3/WiWQMK5aiYE20kVO9h+8LE+rA3YeBqbWIx+U=;
 b=ag+gLYGEFx6VelqoXrWD7DiwObYgNxjolqp4DH5/yK9U6unu9aYWPPs0
 XvKoBR2ZY1t/9S3kQGp+sVRxWdliuQxl3GVqSMcTLvFbNE27ksC/ITSw5
 fgfXlVLaf/KBsEibBGDve/0T3tGQZLRH5u/FLcBM0L0qvd1Y4bFzB6pTO
 51hxMWqFK8WnvI6aPZzKafha33STqNXhBfJ1WVeXCi1zNZ1Rt5tkzN/CX
 LhzcADuDwHWW4hMxRecMbnCMNrh6D0HTlPZytI+NSHyVk3dviQoo+xgNf
 0RnTYtIaVWRgwH9AexxaZorxtSmCD8X7B7InC0wy4kwAobIDX86FsFPCp Q==;
X-CSE-ConnectionGUID: dPUSpPc1QaabOu38q2IptA==
X-CSE-MsgGUID: VIuazyD7TyOiT7Af4e4ZHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72631078"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="72631078"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 23:26:17 -0800
X-CSE-ConnectionGUID: 7d1lEBuwR96186oRdN8jtw==
X-CSE-MsgGUID: VfcDu8+GSx2fb9MHHT7e5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="213136340"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 23:26:17 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 23:26:17 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 23:26:17 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 23:26:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F86XBUzm8cdOv9LV3fZ7xNrJixTVt0SXs+uE2ZcLuFFb5IFVw/L6nIZxdYBDyT6WcZBSRmAmeEFSf++AncjNGE7Dd/dbHdvymSkR94o0Bv0fKfTLgxUWHw0g5TY2gJSg8qKqVQUeHJk7MbLScwDn5HzY6D/9rYv4B3PS6lVtIfXKUwJww9IUBW1TFQkFrwqd7hYKQzVNvxx9NDXjv7Bq57KKWYmgciSXksDNN1nWkf7rWVwgV0zcE4iK8CEjVX0MTXtajcQWM6vZWNgKtA+6XkfkAHMHJRJHP/68i/eNwDmdVHbkk0YiTHH57Erv2TfvaW/cI3ZBYcxjzOlZG+/oZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KIPNhtYbs3w43HBaRjsq+cLBS962VxTp6EZlSAJyyM=;
 b=suN9WTzq4Q5ALiCYL8eMAlzuvqAf5fDMJpR/WCLJLKaPR2lYjmnqSsmJekwNyuRat8a6NvAWZgpT9glUY96n6IfxJSkJWDp7Ai9yJkSCdDHz5bpxIt3gzddPm3SlsXNx+cx1PzoZHoCUExvtpyn6zEKj8/JrxtqLMUig7aQZvP2mDBskKD78OZzJjNWkKPWt2mBwYCPM233q3IJqeYczgbP6VoMRhIlQf0Qy7KvMbR5l4afr6izqh3kbKPX3VfSaHUY6qqQKvnzPtIxpg2/zSe4nvidGHGcyRSpoEKVThnW7eE+pT+mMfC9lWoU8v3PYzvoZSC2pTVpgqIqpVHf4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 07:26:15 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 07:26:14 +0000
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
Thread-Index: AQHcmls54ahhVqRkakqKCJgDMCalvLV7ikcAgAA+8QCAAJeAAIALpbhggAATe4CAASXyEA==
Date: Thu, 19 Feb 2026 07:26:14 +0000
Message-ID: <IA0PR11MB71853E15B09619C37085EA9FF86BA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
 <20260210070155.1176081-7-vivek.kasireddy@intel.com>
 <15ad210e-1464-461e-b113-7fa01f4ece3e@rsg.ci.i.u-tokyo.ac.jp>
 <854a98ca-6282-4c51-ac8e-e89487412f6c@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185118B6112220F36B0E44DF863A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <IA0PR11MB71859E76A326DD910FE50D81F86AA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ea14b035-c98c-4cc6-855f-52ea9d679a69@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ea14b035-c98c-4cc6-855f-52ea9d679a69@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SN7PR11MB6704:EE_
x-ms-office365-filtering-correlation-id: 7a7abc85-5e75-476b-49cf-08de6f882a3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8fn3wE/VON6IqOw7cPWi9xJi/HdPaS++PVEmE8zh3NlSklu7R7vXt9BEEJ?=
 =?iso-8859-1?Q?mJWKHT/UTfDFWgDrS/XS3jUZdFyyxvi4rGevjqb+0bGwGjIZX14+PdL9c5?=
 =?iso-8859-1?Q?yh9g9FaOiZAqIqn8Qzci8ddOBbkUeZ2efMXifIDS6VBR3zmw+O7rJMUEyk?=
 =?iso-8859-1?Q?pqhYNOnWjhMXPtE1HXdzP4P2g1KN89dvbv2We1BSHpRV5Xzwxpy1M3DxTo?=
 =?iso-8859-1?Q?5WCZKvX1NC3WM3J/YjbGWLmY22jPXdu6UZaKff+9VTG/eFB08JuHOh4RFQ?=
 =?iso-8859-1?Q?1iGCmrzXWivuI+53H4ZInwjIm30co919UxsxznCB4EY9U+tpEctL8YzAuW?=
 =?iso-8859-1?Q?Y6ZfgHz7ziq0uVB7g4P8L2uUfUSN+N/Zuj9Hifd0bHOp3oS/zWEBtn/paQ?=
 =?iso-8859-1?Q?DMmWl8++G1NbTZLJP7XDOrXbEKtNmllJObk+4TFP1ViF96kUgBHFvxhSxi?=
 =?iso-8859-1?Q?alTwwZ6gNdC0P1LgYWHCQonWi/Z15yhgn6Sjn7DxiOzdb5zR1BBUXGvHRv?=
 =?iso-8859-1?Q?6gBhR89govSUeW60ho97vLzpuztocYcm7HAJ6/EK/G4RkbVsBDfSdQdttM?=
 =?iso-8859-1?Q?+5ii/8e/9MvzovQqyFYtXPptIPZ4iEBU7yb9xaR06ZmPppUkoP6Szi4+/G?=
 =?iso-8859-1?Q?rJt8ip8mO/CKufNobO5w54ZrhHtobzxpTo9dGQmpHvIqeMz7Pqo95ptpJT?=
 =?iso-8859-1?Q?di3ET5uwEt4GxbGnDxWW9+zFgwEHuasJ9HEXU+bywcPwM0/iEoorhJD6tm?=
 =?iso-8859-1?Q?z4J4+Ecm7tx9vvmHg6SXrNQuRWzfnELco5WipswVk6YQToVLJKHcUlzOXH?=
 =?iso-8859-1?Q?y/WmlaZo5InUdP4XzNuDn02P9T4tTGzOkvKCCGilaus7Dun7drUkG4IyRm?=
 =?iso-8859-1?Q?unQ7KeqHzXk0j43QGpBPpvk9TSG7HrWLYxA+I6Vue8TIwZ9IZBPnr10Nip?=
 =?iso-8859-1?Q?YGhSUfWffxES8bwBpnpKmqugAM8BztkhzeAGSaxgreSQcTEWFRHk5RZYdJ?=
 =?iso-8859-1?Q?WevItZt7bgF+Qe5g8a4llkwhe0cIYhbG/ufGyA5kj5Qxrf09forCKDS/gx?=
 =?iso-8859-1?Q?sFG/53JH6ci5XqReqO7b3XUx4SqG1mMF3Ntpp4C4bQGymTRJ5gr9UjrTHQ?=
 =?iso-8859-1?Q?TUYIUOOdppP7Zl272I0XRetqEj7xFl+lSfjm3mBGBmrORRLd4O3FpBREQo?=
 =?iso-8859-1?Q?C6ythNn/iolkDhhgoxU89b53Hm3wohu5XfgmthAmSZSFtEfh7moC/RQXUe?=
 =?iso-8859-1?Q?BETCKuo8PEbkqL7UdVhU7QtNs1PO70y4zUHlPgOV0kAqmVfyPBapprd9dO?=
 =?iso-8859-1?Q?85AhB817rU0NgNMlt89dSelgl6MpsSKLvKjBMnSBRVJ7XmiFVJBpBxQJEO?=
 =?iso-8859-1?Q?3gRH5KaNQd1BlUqhYgE4jnBk+s4YbTBJk6A48Tbj4mrn+1kH6P3X+vP8mP?=
 =?iso-8859-1?Q?hulWjadnd4fzi242qt9+nJwv95UjKxEOUETBME4UPlcA+ia8Qdxr5rrsgc?=
 =?iso-8859-1?Q?Fp6+rkd0Zn5LtmWexcz9iB2xLcka9QiltUNaZyI+2ikFs7t8Sx0VaaGpoq?=
 =?iso-8859-1?Q?otOb4JF7wNymWzSUJaZQItKwUmbMwnvsYsIQ6/rh9L8BiVWUbIQQdeQW/E?=
 =?iso-8859-1?Q?vPVGjTCt7/tK96w0tm+zENJkbjH29HozOxAV0apIaGtUpcTMj+u81KfbqL?=
 =?iso-8859-1?Q?OgW9m+99ePLg+3VVyLc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m1mILO4g6uj3+VKszokaQqBgEdKhqk+TuE6+ud0NodozzVcjzLvs8hq0Bi?=
 =?iso-8859-1?Q?wNUqrTCHQ5pEZDEXvrr234kqJc1kFwfYYWhICqV6Z0b+0JMCRNQWcdrvax?=
 =?iso-8859-1?Q?eOtFmMx8G/ZEGOhiiLMirtnq/LjmgWaaDSWFrUphftApc0GPpyYOQCrIlh?=
 =?iso-8859-1?Q?fOg2GF5SwDNdSs0dEwyRDvClpEo09OTk9Qes5VeVL/YvEeTuzUwxbrY6Z2?=
 =?iso-8859-1?Q?mvy8ZdeJGjt3a5nbEvhBMPmiIjxOqwSh1GH+VXtVIIgWsUdi1U6hgjDL8s?=
 =?iso-8859-1?Q?4mo/G2a1sQc42wcJCGhWsvc4yMKgTFNX1VuViavJmCdpkVXKUfK4ptqQFC?=
 =?iso-8859-1?Q?SAq7yCDY0mW+/gU/Ih/jeekhCAsNv6DF6WidsKrC7orPDX+IZwiDBdZWQC?=
 =?iso-8859-1?Q?xw91x08ZEJ6OtjHjskNTIOVdQbcPRzsqzAGUHMF7GBGmG9ucaRScqk5gCr?=
 =?iso-8859-1?Q?RhUmZiOT9/v4/uEqJ75O5Mj6SaImg1eHMRPGxf0/7/fWDjMHpC/aWN8Lmn?=
 =?iso-8859-1?Q?Drl+uRG0VvKMENwR/oF3FR5eP4UOswd0nLgGfLhSKPj36alKDuyfQ4QA9G?=
 =?iso-8859-1?Q?UKm99IvKXT6W7Jpbd+tlC1S6vijUrHBtdaDaj9jfY5g/Sh3nPlB5coZdK3?=
 =?iso-8859-1?Q?HRXV57S0HhDTS4kbUOCGadMi4atH3zcKmOXVKuMKCF23+x+s8md03KOyNj?=
 =?iso-8859-1?Q?0s+xEFHvVZLZmmfNmcUT1CKtushou3MHR+L6eQjclW7wwfuG5Ajnwhtev6?=
 =?iso-8859-1?Q?yL6qBfnQmDmIinGLLZvMOUyrURWExcb4BWND2JUdo3pqJcby8VF07JlLws?=
 =?iso-8859-1?Q?KmdX7x3jQpoAh7emOt/9c60wirHNw69V6m/IH9+haYe8EKJmv4sQsubzjr?=
 =?iso-8859-1?Q?22PAlcLsBZTwNeFCiLrl/7axS9niS/1VfpwEda59ZIs2bayebhnpy25IXS?=
 =?iso-8859-1?Q?xjzhnBHLs0IDw45dX4cgQv40XPaExN10QVADB6jYkVEUgABVWLf5INDbzN?=
 =?iso-8859-1?Q?K5iKbHjF+uG4JY9PCwcR6l2TG83zKKECSHs8KSRlWoLhdAGhvByDOnzw6U?=
 =?iso-8859-1?Q?YbTJTwaoc1okWls0GutL3yh9XkwTG3XU6bsYoZzHyXpRvA4Y1o3z9Q/468?=
 =?iso-8859-1?Q?HKdtlG20TLzyZczkIweCITzc8a/apYbR5fVRi88eQ2WNfw6AfOdITrRFie?=
 =?iso-8859-1?Q?wv5oPYIOHDgpTLCR+1wS1AvObmKeNxS7vIMvm4llWXrwqiUggkMAm/X5KB?=
 =?iso-8859-1?Q?F+OZU1GhTIbC6rqvPgO9g+Nkb5tUl3zxbQNgQWrCjXCsL91IVwQtNDu08+?=
 =?iso-8859-1?Q?B6/k2KU2VFsKwb77xBPFTPjGoWp4/ApKMOI7LyvmM5owP9wvHbuP7dDYka?=
 =?iso-8859-1?Q?E6QEL1JAHOXchxX68Dn5Gx3wJcNoaTR+RA6wwkaLadG+dyzOsgECZAk5WN?=
 =?iso-8859-1?Q?lWWvFvattVK6uSINHm0HvWOqqH9ZWdwD1COSPVXiwpGVKD/s39M8pQVxlJ?=
 =?iso-8859-1?Q?aA5vlpPY4K7KZV/i5iQCB5QPzlECpCGuJJj+S16iM2Hl/s1oAcWMlDDIYZ?=
 =?iso-8859-1?Q?2E2s9FLAyMaCRseVH7qyVjSExeGWzYI4SzUhf1iLe1sUMR+i06ycHShZ9/?=
 =?iso-8859-1?Q?FsWBCyYFeQXHa8kdwVVAcWLipAotxdIJpyhuEdSr+52aD6t4OltzoVfoLF?=
 =?iso-8859-1?Q?k9zhdfGVC2bNW7x/RsClGLCUcSggacljiqVciY1m8Uobx0KoGuIsNe+bpP?=
 =?iso-8859-1?Q?1J3vqQwk+f4Yb+BMqzkuveYlgNLNnb5wvygTvx3PgWZDy/g88Vv94ImF69?=
 =?iso-8859-1?Q?TSGLTlLcmw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7abc85-5e75-476b-49cf-08de6f882a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 07:26:14.7845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncOcVcsirpFOs3wFou2f5Q5Mj+jh8H0kh90ZfgvJiKRcClxihshrP72gRQAgXWAGbROp4iOJPVBw463Nc5Gi4ogTGHy6DFGIemJIClLPM7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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
> >>>
> >>>>> Make the error handling more robust in
> virtio_gpu_init_udmabuf()
> >>>>> by passing in 'Error **' parameter to capture errors from
> >>>>> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> >>>>> And, since they now take in 'Error **' parameter, have them
> >>>>> return a bool to adhere to best practices.
> >>>>>
> >>>>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>>>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>>> Cc: Alex Williamson <alex@shazbot.org>
> >>>>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>>>> ---
> >>>>>  =A0 hw/display/virtio-gpu-dmabuf.c | 45 ++++++++++++++++++++++-
> -----
> >> -
> >>> -----
> >>>>>  =A0 1 file changed, 30 insertions(+), 15 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-
> gpu-
> >>>>> dmabuf.c
> >>>>> index 8d67ef7c2a..d9b2ecaf31 100644
> >>>>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>>>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>>>> @@ -27,7 +27,8 @@
> >>>>>  =A0 #include "standard-headers/linux/udmabuf.h"
> >>>>>  =A0 #include "standard-headers/drm/drm_fourcc.h"
> >>>>> -static void virtio_gpu_create_udmabuf(struct
> >>>>> virtio_gpu_simple_resource *res)
> >>>>> +static bool virtio_gpu_create_udmabuf(struct
> >>>>> virtio_gpu_simple_resource *res,
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Error **errp)
> >>>>>  =A0 {
> >>>>>  =A0=A0=A0=A0=A0 g_autofree struct udmabuf_create_list *list =3D NU=
LL;
> >>>>>  =A0=A0=A0=A0=A0 RAMBlock *rb;
> >>>>> @@ -36,7 +37,8 @@ static void
> virtio_gpu_create_udmabuf(struct
> >>>>> virtio_gpu_simple_resource *res)
> >>>>>  =A0=A0=A0=A0=A0 udmabuf =3D udmabuf_fd();
> >>>>>  =A0=A0=A0=A0=A0 if (udmabuf < 0) {
> >>>>> -=A0=A0=A0=A0=A0=A0=A0 return;
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "udmabuf device not availab=
le");
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
> >>>>>  =A0=A0=A0=A0=A0 }
> >>>>>  =A0=A0=A0=A0=A0 list =3D g_malloc0(sizeof(struct udmabuf_create_li=
st) +
> >>>>> @@ -45,7 +47,10 @@ static void
> virtio_gpu_create_udmabuf(struct
> >>>>> virtio_gpu_simple_resource *res)
> >>>>>  =A0=A0=A0=A0=A0 for (i =3D 0; i < res->iov_cnt; i++) {
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 rb =3D qemu_ram_block_from_host(res->i=
ov[i].iov_base,
> false,
> >>>>> &offset);
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!rb || rb->fd < 0) {
> >>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 "%s: Could not find valid ramblock\n",
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 __func__);
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;
> >>>
> >>> include/qapi/error.h suggests the following error handling pattern:
> >>>   > Call a function, receive an error from it, and pass it to the cal=
ler
> >>>   > - when the function returns a value that indicates failure, say
> >>>   >   false:
> >>>   >     if (!foo(arg, errp)) {
> >>>   >         handle the error...
> >>>   >     }
> >>>
> >>> Returning false without passing an error to the caller breaks it so
> >>> please don't do that.
> >> That's why I added an additional check in the caller:
> >>                  if (local_err) {
> >>                      error_report_err(local_err);
> >>                  }
> >> Having said that, I am not sure what is the right thing to do here.
> >> IMO, the proper way would be to add error_setg() but you
> mentioned
> >> doing that would be incorrect given that this is a Guest error.
> >> So, how should I proceed?
> > Any further thoughts/comments here and below?
>=20
> Sorry, I missed them.
>=20
> Here, this function should not require its caller to have such an
> additional check. Ideally, the idiom described in include/qapi/error.h
> should work.
>=20
> include/qapi/error.h says:
>  > - Whenever practical, also return a value that indicates success /
>  >   failure.  This can make the error checking more concise, and can
>  >   avoid useless error object creation and destruction.  Note that
>  >   we still have many functions returning void.  We recommend
>  >   . bool-valued functions return true on success / false on failure,
>  >   . pointer-valued functions return non-null / null pointer, and
>  >   . integer-valued functions return non-negative / negative.
>=20
> Since this function is deriving a file descriptor, it should return one.
> The error condition should be represented by a negative value. It is a
> common to return -errno and let the caller distinguish error conditions,
> but the error conditions we care cannot properly represented with
> -errno, so there should be an enum for the two error conditions: invalid
> iov or anything else.
Ok, I'll look into adding an enum but I feel like this is getting unnecessa=
rily
complex particularly with the introduction of 'Error *'. I think it might b=
e
easier to just not use 'Error *' in virtio_gpu_create_udmabuf() and elsewhe=
re.

> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 list->list[i].memfd=A0 =3D rb->fd;
> >>>>> @@ -58,20 +63,26 @@ static void
> virtio_gpu_create_udmabuf(struct
> >>>>> virtio_gpu_simple_resource *res)
> >>>>>  =A0=A0=A0=A0=A0 res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_L=
IST,
> list);
> >>>>>  =A0=A0=A0=A0=A0 if (res->dmabuf_fd < 0) {
> >>>>> -=A0=A0=A0=A0=A0=A0=A0 warn_report("%s: UDMABUF_CREATE_LIST: %s", _=
_func__,
> >>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 strerror=
(errno));
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, -res->dmabuf_fd,
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 "Could not create dmabuf fd via udmabuf
> >>>>> driver");
> >>>>
> >>>> This is a guest error since it indicates that the guest specified
> wrong
> >>>> addresses.
> >> I don't have a strong opinion here but my understanding is that this
> >> should
> >> not be considered a Guest error because the rb (which we obtained
> using
> >> Guest addresses) is valid at this point, so the
> UDMABUF_CREATE_LIST
> >> IOCTL
> >> failure should be treated as a Host error.
> >> Regardless, it is not clear how we can precisely determine who
> (Guest or
> >> Host)
> >> is responsible for the failure here and in some other places.
>=20
> rb->fd may still contain something other than memfd.
>=20
> Assume anything the guest passes can be invalid. iov the guest passes
> can be whatever you do not expect.
Right, but my point is that, for example, if UDMABUF_CREATE_LIST IOCTL
failure is due to -ENOMEM, then how can we distinguish this case and
categorize it as Host error?

And, similarly, rb->fd being something other than memfd does lead to
UDMABUF_CREATE_LIST IOCTL failure and this needs to be categorized
as Guest error. So, can we rely on errno being -EINVAL or -EBADFD to
identify Guest errors and categorize all other errors as Host errors?

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> >>
> >> Thanks,
> >> Vivek
> >>
> >>>>
> >>>> Regards,
> >>>> Akihiko Odaki
> >>>>
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
> >>>>>  =A0=A0=A0=A0=A0 }
> >>>>> +=A0=A0=A0 return true;
> >>>>>  =A0 }
> >>>>> -static void virtio_gpu_remap_dmabuf(struct
> >>> virtio_gpu_simple_resource
> >>>>> *res)
> >>>>> +static bool virtio_gpu_remap_dmabuf(struct
> >>> virtio_gpu_simple_resource
> >>>>> *res,
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Error **errp)
> >>>>>  =A0 {
> >>>>> -=A0=A0=A0 res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 MAP_SHARED, res->dmabuf_fd, 0);
> >>>>> -=A0=A0=A0 if (res->remapped =3D=3D MAP_FAILED) {
> >>>>> -=A0=A0=A0=A0=A0=A0=A0 warn_report("%s: dmabuf mmap failed: %s", __=
func__,
> >>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 strerror=
(errno));
> >>>>> +=A0=A0=A0 void *map;
> >>>>> +
> >>>>> +=A0=A0=A0 map =3D mmap(NULL, res->blob_size, PROT_READ,
> MAP_SHARED,
> >>> res-
> >>>>>> dmabuf_fd, 0);
> >>>>> +=A0=A0=A0 if (map =3D=3D MAP_FAILED) {
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, errno, "dmabuf mmap f=
ailed");
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 res->remapped =3D NULL;
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
> >>>>>  =A0=A0=A0=A0=A0 }
> >>>>> +=A0=A0=A0 res->remapped =3D map;
> >>>>> +=A0=A0=A0 return true;
> >>>>>  =A0 }
> >>>>>  =A0 static void virtio_gpu_destroy_dmabuf(struct
> >>>>> virtio_gpu_simple_resource *res)
> >>>>> @@ -125,6 +136,7 @@ bool virtio_gpu_have_udmabuf(void)
> >>>>>  =A0 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> >>> *res)
> >>>>>  =A0 {
> >>>>> +=A0=A0=A0 Error *local_err =3D NULL;
> >>>>>  =A0=A0=A0=A0=A0 void *pdata =3D NULL;
> >>>>>  =A0=A0=A0=A0=A0 res->dmabuf_fd =3D -1;
> >>>>> @@ -132,12 +144,15 @@ void virtio_gpu_init_dmabuf(struct
> >>>>> virtio_gpu_simple_resource *res)
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 res->iov[0].iov_len < 4096) {
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 pdata =3D res->iov[0].iov_base;
> >>>>>  =A0=A0=A0=A0=A0 } else {
> >>>>> -=A0=A0=A0=A0=A0=A0=A0 virtio_gpu_create_udmabuf(res);
> >>>>> -=A0=A0=A0=A0=A0=A0=A0 if (res->dmabuf_fd < 0) {
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 if (!virtio_gpu_create_udmabuf(res, &local_e=
rr)) {
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (local_err) {
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report_err(loc=
al_err);
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >>>>> -=A0=A0=A0=A0=A0=A0=A0 virtio_gpu_remap_dmabuf(res);
> >>>>> -=A0=A0=A0=A0=A0=A0=A0 if (!res->remapped) {
> >>>>> +
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 if (!virtio_gpu_remap_dmabuf(res, &local_err=
)) {
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report_err(local_err);
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 pdata =3D res->remapped;
> >>>>
> >>
> >


