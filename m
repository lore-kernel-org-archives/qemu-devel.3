Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7D7E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 06:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsarj-0001uC-43; Wed, 18 Feb 2026 01:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vsarf-0001tt-UV
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:16:47 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vsarc-0005In-Rq
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771395405; x=1802931405;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vbAE++2bEHT/aD5XY4sSEl6iyIDUKNJXoiZzA32h4Ow=;
 b=NR54XTB2pAoF3ieqECTowM/WDVnDWAhharILxy7XFKic/NBbUtnnDfGy
 NNf4Q8E3gz2X2UdsnCiM+MkcTS2zve3EhNrwb+3RqxPxSyU1U3twVTg+q
 WVFkoN/SlY1baMZUjzRSTEIQd2H1KiCDGZ5RwgOAMx+peKLWa++fc1xY/
 P/IvNTh/5geGZxo1vNeDulcAKNa9lqWg1maHRyJxLzO5NCrojP98PCBYt
 sKlhYuxm9LHG2owzwrVLXNVSYeeGap84/Ur1F4a9/L7NSAvSdrPJDfET6
 zM0RGTpKUc+ON9MLEK776ENd70sFrW4twMrv+gNwsn/zWRvbQp136o9DO Q==;
X-CSE-ConnectionGUID: 78JVciBqRwad6oXOCeJbjw==
X-CSE-MsgGUID: iEMUYW5XQ2iTjPABRbKm/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72359350"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; d="scan'208";a="72359350"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 22:16:40 -0800
X-CSE-ConnectionGUID: cKurZZRoS1CAfXkt/yhY5g==
X-CSE-MsgGUID: QnJdpLrST6Gf1cmxpqp6dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; d="scan'208";a="212495161"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 22:16:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 22:16:39 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 22:16:39 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.50)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 22:16:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmTm5VDDrEpErUkvUvO00C8pw2ZP7UrCJRaPDj/cV+njxgZP9gFBQOE4AIY7O9b+GC1ZvQAvTCNtbC5Y2QJMrSqH4VsiG1X2T/MO7m7sSV2i1mNeq+gE5fwOnkpovimJbx2Bduojmp5PdEVztJja4gJiR5fLuRN3SWNiyxHHMbFm1z7LFcaDKEjMCSuZ1uOQDS19G+MoHlWpkNUIZNn63MNhWC1Ddb8afUki3t+qHtTaTvCX2NMrXZRKXfwVKZp8wlRV2dlLw6SMsYbnjaU/nPujI8u0oCTRtLVfNI9mD/IH1QB/Z5JSYMa9xsVbqJtIAaG9+DjcPY20WNSurhuZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRKIqsTXO3GB+SaGb7mJkNPbJBkSVo3BfcW3NX+lUFk=;
 b=XM2MQ2u7HiEUJPN3GQ8tUZOfvSf7R7ZYB25x8eDQhjk+dkjX4WCyauKxWrxx50C9YkNu6zKJ5mvQO/YmzRMFNbLTMvK0hV5oc94/B2mwIuvT9Oq6+PcDhFJOqJpESN6zxbFNOgx3TSBQNNNWcVfWUWX73WfYBditpSIObXmoR3HdVyqWPpKEf7c+zkqVYoGO6qkI7WAVMORi8Yyt21luXgFI0CH8FBmkvD2t8eHKCj2/O3+toUe1F/+fJni4FPBAxzIHyAELzT9X7FgBWljQB3oZKEpbsHsutCOgGo9q4Vox1Och3L4quxMMwc9jozenBUswKcvKgElausUfJTUNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA1PR11MB6942.namprd11.prod.outlook.com (2603:10b6:806:2bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 06:16:34 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 06:16:34 +0000
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
Thread-Index: AQHcmls54ahhVqRkakqKCJgDMCalvLV7ikcAgAA+8QCAAJeAAIALpbhg
Date: Wed, 18 Feb 2026 06:16:33 +0000
Message-ID: <IA0PR11MB71859E76A326DD910FE50D81F86AA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
 <20260210070155.1176081-7-vivek.kasireddy@intel.com>
 <15ad210e-1464-461e-b113-7fa01f4ece3e@rsg.ci.i.u-tokyo.ac.jp>
 <854a98ca-6282-4c51-ac8e-e89487412f6c@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185118B6112220F36B0E44DF863A@IA0PR11MB7185.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB7185118B6112220F36B0E44DF863A@IA0PR11MB7185.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA1PR11MB6942:EE_
x-ms-office365-filtering-correlation-id: 43c6e272-6106-465a-dd55-08de6eb543e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OWW0VemSRLsRffAKzw23KW4RyUXYlprhacmZr74Vgq4lwYoxyW/oo4jdVu?=
 =?iso-8859-1?Q?7RgakZgyx+1l4Fwi13vHKkg2wjWjUwDkwQPB6od4pWlgFtx5cB52L++zFd?=
 =?iso-8859-1?Q?oeIYey4mImcfr/G1JDjjSoXa5fqzb0aGhFSHZ0JO++UxbsXqEBRg5jDT3X?=
 =?iso-8859-1?Q?SC5WVtQg7mT+JaC4dfNtlOYr4q7X1OQf2DOfBDVnmJ3t/im4T+LPOx7UR3?=
 =?iso-8859-1?Q?sza7AcPo6OeWqWLuROD9KgfkN+8KwEztgaK0szSqQIZJVwgEfbuKqTBso5?=
 =?iso-8859-1?Q?F8294FZNKsMlG0e8Wu7kHF2iW3msYuMzDvh8HdiHCtje97iIlv/WsyNKv4?=
 =?iso-8859-1?Q?w22wUnxi18XcIbQ4uTGpZYs8D1xAN/+ARGBKmgw9j/lU9tbauqWsYaW0q/?=
 =?iso-8859-1?Q?5/sCyy72XiGEp2/35R/oiyijanP/tWqGa/wGLSR0x/SgcynzrID5ITTYGj?=
 =?iso-8859-1?Q?On5ZZf3KTlVCsi6cYn9TfFtuPROyzdohChl4vjq5htmUt3O9PiAw15ezFZ?=
 =?iso-8859-1?Q?HbCtnvbda3ixwxEGG5O85NQ1hlWFnbLtP4LTPN4/ZX77XCqK3qWabty62X?=
 =?iso-8859-1?Q?8abadZRxeloltcuhJ+e/D0+XKokxLZ2k0/JDPyc9ZZrvuAhxQbIoUFNLzw?=
 =?iso-8859-1?Q?MbpN4jLXcC/gwClLCYDjhmFR31yGMbgGro/kqaxg0y5141aPM7Kw4Z6lDd?=
 =?iso-8859-1?Q?6a3hz9/UMh3puQXXoF0pTeKBHKUqxGFsm55WsqZ0bGVwoLmrYItkIdUBNP?=
 =?iso-8859-1?Q?OIJkVkMyq1R8Cr/WhlCy5BjNEsTRly5ArdhFr/W6aE2/wmdiJ3iQ2Ywu4s?=
 =?iso-8859-1?Q?WIC1F3Rg5Ya3fdWDOTG05bySDC5uj/TrusXegSkfnq7AhGFVApTTsgRTNx?=
 =?iso-8859-1?Q?Q+L6u6Bg2wO0iCNaV/Bv1m3YeTSUwLdvjptdReekWOCQwB6RaTrLxD4Ca2?=
 =?iso-8859-1?Q?KeVCCv/NueBuGO2Dsr6LUm6724jn9Szc16eMgveAlo1sJX4tlqv+QAt7aw?=
 =?iso-8859-1?Q?PGw+b/SnidR1ZYhsSxe1oddyi4NXhnHAJ6R7YvyBeqh9nG3iCmeeFR0F/g?=
 =?iso-8859-1?Q?EaTGNdy5xNOVaxlwIiwO5sn61sxfaAp9HZq+cgASW+aubNAO1M+OQQe+8y?=
 =?iso-8859-1?Q?GR2+3WdExoM5taN3dlH4x3Zp0bsgJGmdP2G6Plosa5nhd2C+jQ9OXDtmqK?=
 =?iso-8859-1?Q?pVp16v5WxQkmuQBRqATz0gWfRZOO7w7Jfe7BR+jYywyFr2zQ17/6ZATYfm?=
 =?iso-8859-1?Q?v53MAkEta8O246qri1XLBG8FyisoswcRZbypVZ2xRCmDdzgZbaH0qcTjig?=
 =?iso-8859-1?Q?lsPjAH+ivUAiR29SN/ULiIgJr4gld3soUfbwFJqcQAbmj9Npo8MnH7yhiB?=
 =?iso-8859-1?Q?POvtXMVZzkFNc7v/KHFkaQta7SsPbDsg327BlvZjGXqVa/e6F9iURKhKeU?=
 =?iso-8859-1?Q?NVqfvHlRNIdAGg3KQ0idfp+8T3K6/fyoq3EGrteq0BRtz5xda+56Pg0clO?=
 =?iso-8859-1?Q?8e3S/GI04xn0HC1uxRb54vdJFk6IyaJcY4BSKZ3JYj2aN1fgERWCmWmWm/?=
 =?iso-8859-1?Q?u/DrXiQ0wnOiW7L2in8ymJ1DuOF8b+F+M51WLadRwA3WYn9LWLKQ16cWUu?=
 =?iso-8859-1?Q?BZKM+uqH3ng99LEGMDK4Nr6mX46t8gWa5euAtAUL6ROtPqg/vCstuExcII?=
 =?iso-8859-1?Q?qzq+AU1JiCWYYYDey1U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rr5QUy+TXtPCQPJDBDoNJt9kq50zzQPyVE6upM4RxR+Ip/zw8IYBrRJ6Q6?=
 =?iso-8859-1?Q?+8EaV9MRIkFXEjJB9S3DIqGEN5MnYQ0gVb3T2IKLw4ypTasXdL++C1udd8?=
 =?iso-8859-1?Q?3YzGQ3MCHojpghXH+8T4zU6vQEc9+8S1TeMR7QWXEzlNaWPJfFUiM2UDcl?=
 =?iso-8859-1?Q?NEDpuZIHWSAj68roixPmWi2ClayTtFIX1RM4INPnRLmhdK262D/OL3bDzo?=
 =?iso-8859-1?Q?itXOSpNc6EL4kQdF6Nd/7nOCBAS3hvdoNKL70tV0gLipOggguKzxrKK2bk?=
 =?iso-8859-1?Q?krllfrjwzZRuzHKWCuUhvJqe0WaxpmuT0MSokYsu2vbFDBYNleAwpIxydu?=
 =?iso-8859-1?Q?JZoP7D/TYHyK5vhoUxSUcNgHMYQYQkFJTWwuPWgF3pVAcFne3KLWWSa9zL?=
 =?iso-8859-1?Q?jMMW8uuZPnZ5ZTNBTon4mj42ysPZ2ayGqLmfmZGy3OS3T+9HfybhLnxhDB?=
 =?iso-8859-1?Q?AYLJ37j+uupff7VxvYpwSCqcjvpf1NVhW7cX00/Rarp6Bld04hxUyMFM1V?=
 =?iso-8859-1?Q?5SxDukL9oh34uZMPJ7x+Jxv79LSdDEyBafuI7QOkl1Y56uU7kDeAvC8Sl6?=
 =?iso-8859-1?Q?U0pxzVWN2thT5QiiZwSSp7co7zvXOCeVK7xmZ70+tQAmaPK9zawiVWNeda?=
 =?iso-8859-1?Q?FJwJiqaHtja2JrqdrENOqRop0YDJlH4XuGNaCbDPgXt+X/fANeoL3ppRd2?=
 =?iso-8859-1?Q?n0t7zn0MncKW/VDJeiUJRm1H+/k547TncNNU4R/mqjaCB6n5w+cNsGc5n6?=
 =?iso-8859-1?Q?zHD8fpO6kQ33JLvTl62hGt03nc2n8KJtjNx9aCrvgWuH6bfrjMsli+wlrq?=
 =?iso-8859-1?Q?+vyS5FbgSFW6PBQjDS1ZLsGqzNFc1zBY05S5ueWvuvuZ7EaVFzSf4cCZ45?=
 =?iso-8859-1?Q?WPyEuB+t1sI/3voYtFCD7oNf83ZixHBitULNzS7V11fESdBCQeHZiCbHKU?=
 =?iso-8859-1?Q?pPegNGFsbrydqYxDJRwsEy3zbXZodgRUOAYQEs1XztIzyHmEN0TwDhssKb?=
 =?iso-8859-1?Q?1rTDvxRHSb4ZMydqWrewuNEATRpqrkmKZB6vadgLyXDTM0a7kbjLXQ1n2c?=
 =?iso-8859-1?Q?0P2FF/j4nYXzO/5mivHAmusYDOASPAj7x5zXaLQjmU8AsUrYD2g2gAQwwA?=
 =?iso-8859-1?Q?j0XC/IMdC24OP5qTXQxiY0XDIBNikaBcc1gmXviLywpWfHN1i/z8noXKGu?=
 =?iso-8859-1?Q?YbbSFzXNUQKbnCVUwuS/uNPmstvLjHjTFpmB7pFFEuVkzDPPC9cflV3Af0?=
 =?iso-8859-1?Q?pwrCDByjLULGZKyBOmWdkm3ZH64VgEOrAJbwX/m4v/V18RIV/LjW4vW5Rv?=
 =?iso-8859-1?Q?uJGuPggnR1k2rCkYRUwBhDuDNsWLsTup7tEygCvW361XrcG4wWlyAXdfOX?=
 =?iso-8859-1?Q?9/nZgeuM8TPZ3GcqQ5KEEp2g84+F0dQHXQwRkkGtCpXdU69O2B8myyRptI?=
 =?iso-8859-1?Q?eVj3Gzyf5jX/9LGUj4JYIYO+JQaHhsvHzn002badCyZ9UeWh4l5CRIRTU5?=
 =?iso-8859-1?Q?Tv3tGsOYpxiZgc53eTr65uSEjH40fyDWNcXd1zVqxA02ah0mOdu5J3RVri?=
 =?iso-8859-1?Q?voqqzRyaeg422FquzpJISA8CYQcTRqOGHcKKG0hTbbV7oRLZnDKrlvOcNu?=
 =?iso-8859-1?Q?lhX/3pY+Q3/1rHTCbEq3PIM29M2HHwk8aj90dHezHkdQDh8OsyJDQYk9Jj?=
 =?iso-8859-1?Q?zOvUEDJLK+ab0c/JKbFtNxG0CllbZ60ZOOS3QgA24nitARuZe5Wnif68tR?=
 =?iso-8859-1?Q?OG75aVWGDk/9MlvyKbrWV2D+s0TjiG4nRy5r4I364MujxhR6u2oeA6NKk3?=
 =?iso-8859-1?Q?ogy0pw7OBg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c6e272-6106-465a-dd55-08de6eb543e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 06:16:33.9710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fO3kLuLdD8kHBn+/N0X+rWoU3mLCUBAtGvAUCb1c13WnutUEpRFo+T9iEnYEnJD9TUCY6EXuUxaotFJGuVkLiGpXwMUrexdsGJfR0LvHmJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6942
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
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

> Subject: RE: [PATCH v6 06/11] virtio-gpu-dmabuf: Improve error handling
> by introducing 'Error **'
> >
> > >> Make the error handling more robust in virtio_gpu_init_udmabuf()
> > >> by passing in 'Error **' parameter to capture errors from
> > >> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> > >> And, since they now take in 'Error **' parameter, have them
> > >> return a bool to adhere to best practices.
> > >>
> > >> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > >> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > >> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > >> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > >> Cc: Alex Williamson <alex@shazbot.org>
> > >> Cc: C=E9dric Le Goater <clg@redhat.com>
> > >> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > >> ---
> > >> =A0 hw/display/virtio-gpu-dmabuf.c | 45 ++++++++++++++++++++++------
> -
> > -----
> > >> =A0 1 file changed, 30 insertions(+), 15 deletions(-)
> > >>
> > >> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> > >> dmabuf.c
> > >> index 8d67ef7c2a..d9b2ecaf31 100644
> > >> --- a/hw/display/virtio-gpu-dmabuf.c
> > >> +++ b/hw/display/virtio-gpu-dmabuf.c
> > >> @@ -27,7 +27,8 @@
> > >> =A0 #include "standard-headers/linux/udmabuf.h"
> > >> =A0 #include "standard-headers/drm/drm_fourcc.h"
> > >> -static void virtio_gpu_create_udmabuf(struct
> > >> virtio_gpu_simple_resource *res)
> > >> +static bool virtio_gpu_create_udmabuf(struct
> > >> virtio_gpu_simple_resource *res,
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Error **errp)
> > >> =A0 {
> > >> =A0=A0=A0=A0=A0 g_autofree struct udmabuf_create_list *list =3D NULL=
;
> > >> =A0=A0=A0=A0=A0 RAMBlock *rb;
> > >> @@ -36,7 +37,8 @@ static void virtio_gpu_create_udmabuf(struct
> > >> virtio_gpu_simple_resource *res)
> > >> =A0=A0=A0=A0=A0 udmabuf =3D udmabuf_fd();
> > >> =A0=A0=A0=A0=A0 if (udmabuf < 0) {
> > >> -=A0=A0=A0=A0=A0=A0=A0 return;
> > >> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "udmabuf device not availabl=
e");
> > >> +=A0=A0=A0=A0=A0=A0=A0 return false;
> > >> =A0=A0=A0=A0=A0 }
> > >> =A0=A0=A0=A0=A0 list =3D g_malloc0(sizeof(struct udmabuf_create_list=
) +
> > >> @@ -45,7 +47,10 @@ static void virtio_gpu_create_udmabuf(struct
> > >> virtio_gpu_simple_resource *res)
> > >> =A0=A0=A0=A0=A0 for (i =3D 0; i < res->iov_cnt; i++) {
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 rb =3D qemu_ram_block_from_host(res->iov=
[i].iov_base, false,
> > >> &offset);
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!rb || rb->fd < 0) {
> > >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_log_mask(LOG_GUEST_ERROR,
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 "%s: Could not find valid ramblock\n",
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 __func__);
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;
> >
> > include/qapi/error.h suggests the following error handling pattern:
> >  > Call a function, receive an error from it, and pass it to the caller
> >  > - when the function returns a value that indicates failure, say
> >  >   false:
> >  >     if (!foo(arg, errp)) {
> >  >         handle the error...
> >  >     }
> >
> > Returning false without passing an error to the caller breaks it so
> > please don't do that.
> That's why I added an additional check in the caller:
>                 if (local_err) {
>                     error_report_err(local_err);
>                 }
> Having said that, I am not sure what is the right thing to do here.
> IMO, the proper way would be to add error_setg() but you mentioned
> doing that would be incorrect given that this is a Guest error.
> So, how should I proceed?
Any further thoughts/comments here and below?

Thanks,
Vivek

>=20
> >
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 list->list[i].memfd=A0 =3D rb->fd;
> > >> @@ -58,20 +63,26 @@ static void virtio_gpu_create_udmabuf(struct
> > >> virtio_gpu_simple_resource *res)
> > >> =A0=A0=A0=A0=A0 res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIS=
T, list);
> > >> =A0=A0=A0=A0=A0 if (res->dmabuf_fd < 0) {
> > >> -=A0=A0=A0=A0=A0=A0=A0 warn_report("%s: UDMABUF_CREATE_LIST: %s", __=
func__,
> > >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 strerror(=
errno));
> > >> +=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, -res->dmabuf_fd,
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 "Could not create dmabuf fd via udmabuf
> > >> driver");
> > >
> > > This is a guest error since it indicates that the guest specified wro=
ng
> > > addresses.
> I don't have a strong opinion here but my understanding is that this
> should
> not be considered a Guest error because the rb (which we obtained using
> Guest addresses) is valid at this point, so the UDMABUF_CREATE_LIST
> IOCTL
> failure should be treated as a Host error.
> Regardless, it is not clear how we can precisely determine who (Guest or
> Host)
> is responsible for the failure here and in some other places.
>=20
> Thanks,
> Vivek
>=20
> > >
> > > Regards,
> > > Akihiko Odaki
> > >
> > >> +=A0=A0=A0=A0=A0=A0=A0 return false;
> > >> =A0=A0=A0=A0=A0 }
> > >> +=A0=A0=A0 return true;
> > >> =A0 }
> > >> -static void virtio_gpu_remap_dmabuf(struct
> > virtio_gpu_simple_resource
> > >> *res)
> > >> +static bool virtio_gpu_remap_dmabuf(struct
> > virtio_gpu_simple_resource
> > >> *res,
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Error **errp)
> > >> =A0 {
> > >> -=A0=A0=A0 res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> > >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 MAP_SHARED, res->dmabuf_fd, 0);
> > >> -=A0=A0=A0 if (res->remapped =3D=3D MAP_FAILED) {
> > >> -=A0=A0=A0=A0=A0=A0=A0 warn_report("%s: dmabuf mmap failed: %s", __f=
unc__,
> > >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 strerror(=
errno));
> > >> +=A0=A0=A0 void *map;
> > >> +
> > >> +=A0=A0=A0 map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> > res-
> > >> >dmabuf_fd, 0);
> > >> +=A0=A0=A0 if (map =3D=3D MAP_FAILED) {
> > >> +=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, errno, "dmabuf mmap fa=
iled");
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 res->remapped =3D NULL;
> > >> +=A0=A0=A0=A0=A0=A0=A0 return false;
> > >> =A0=A0=A0=A0=A0 }
> > >> +=A0=A0=A0 res->remapped =3D map;
> > >> +=A0=A0=A0 return true;
> > >> =A0 }
> > >> =A0 static void virtio_gpu_destroy_dmabuf(struct
> > >> virtio_gpu_simple_resource *res)
> > >> @@ -125,6 +136,7 @@ bool virtio_gpu_have_udmabuf(void)
> > >> =A0 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> > *res)
> > >> =A0 {
> > >> +=A0=A0=A0 Error *local_err =3D NULL;
> > >> =A0=A0=A0=A0=A0 void *pdata =3D NULL;
> > >> =A0=A0=A0=A0=A0 res->dmabuf_fd =3D -1;
> > >> @@ -132,12 +144,15 @@ void virtio_gpu_init_dmabuf(struct
> > >> virtio_gpu_simple_resource *res)
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 res->iov[0].iov_len < 4096) {
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 pdata =3D res->iov[0].iov_base;
> > >> =A0=A0=A0=A0=A0 } else {
> > >> -=A0=A0=A0=A0=A0=A0=A0 virtio_gpu_create_udmabuf(res);
> > >> -=A0=A0=A0=A0=A0=A0=A0 if (res->dmabuf_fd < 0) {
> > >> +=A0=A0=A0=A0=A0=A0=A0 if (!virtio_gpu_create_udmabuf(res, &local_er=
r)) {
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (local_err) {
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report_err(loca=
l_err);
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > >> -=A0=A0=A0=A0=A0=A0=A0 virtio_gpu_remap_dmabuf(res);
> > >> -=A0=A0=A0=A0=A0=A0=A0 if (!res->remapped) {
> > >> +
> > >> +=A0=A0=A0=A0=A0=A0=A0 if (!virtio_gpu_remap_dmabuf(res, &local_err)=
) {
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report_err(local_err);
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 pdata =3D res->remapped;
> > >
>=20


