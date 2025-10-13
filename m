Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF201CCD18A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 07:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8CYi-0001qR-NL; Mon, 13 Oct 2025 03:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8CYT-0001m3-Az
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:01:14 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8CYL-0002Sc-UH
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760338866; x=1791874866;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Bkq+eY+nInwGtjVYWFcpq5q0pFzchc9GsXmd/xSn76o=;
 b=QXDRuHsSyb/lZXYeYTy1V2DB40E81usvkgqTTWIE+nmc36mi+igmG8/N
 fLo7I2FHNKWYdqigpOnpJnxpjhcSmOIhNPyxkOLJdVtd6f3J0IgPP0pwO
 JASirt1GRboKUQk+hzNkxXlgiy65peEDyb8hV+Z8O7cNPedCtzUk6FiIt
 guNvU27MvKg3AvN7N6acU3fYWTgvayzYiVIed/q594D0/N0eDdoFVd6iD
 J2sLoblywp8Hlbn/Q5WfXFGPNygymP4LFSSW7IEAaUb1e2nDHDpzLDri3
 LuAlYfuDkKhlAupOzdodzYQktP8lc8jsvqaJH1WTNOzwGPApJL1SbZZO7 A==;
X-CSE-ConnectionGUID: QSmv76lWTCuILhIcqDOxZw==
X-CSE-MsgGUID: z2qTA22uTFGj8Q+VgTLGzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73078704"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="73078704"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 00:00:49 -0700
X-CSE-ConnectionGUID: ULzS2cFATZ2j9dKctjlDeQ==
X-CSE-MsgGUID: 68eHIq5pRV+Uzl+sGmen9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="186811174"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 00:00:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 00:00:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 00:00:48 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 00:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEiWZ2tZrynm+242skAyzUxzAyaLLTvuhhYGRjuHocHndqJFWv79V0EGiw2NnBl/tq5rOunPBy9vq14vCp/aVOtsVHKAmEmOrR6PEGe3O0VJX8qbM8ES8+tUDA1YUNy/tltfbO3AmF/Qty041hslHCuyF5H1waSnP8EuJbrkvkuvmOdeaxlz3nNlqRGYydOJJD7OTJH1dJSBwZIodwsCKgcTv17XufbM9OdtyVq9qXqL/y1byLa9t+hv7/GSxeND5n0cqEU8WZk6mLIOHztmK+rHx+/wElAK4smorFnfd0ccHUo846J2rZFkg5sO5OCe05aLFsuS1bp+kFxhlPo1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkPxdXi+PmbtoSVgJQEOG9O658KfEaa59oE6b0QKJzU=;
 b=aAcPebevZ0yWyr+t5bVkLk0x1jQEusDDXhpbsGcQMdRKvddOpcPqw+GFVW0vyKeynYfto62PN+fnePw/jeTGoJjR2f041jwQ3IrXmszn6sZA/H268GWUTYXbynqDxhwF2AiXSCjL/3YlHvi8CMPQrw74dTBpgQea7IzdCoI/zbc39jHjVk+zIol4GOxCOIEWRBp2aLScOLgdlsuQhBaMSN2khSTM4IUfuG4HmqbSMGzt6wJxUgiv29A6+ZChTe8i6vmnusd0wehWiIFZo6mrUgsEuT39ICQptm1y6i9JaWEFKMLopm2FNKbWXch9s7cXVnD+uXq6Buw21qpEoPhnZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS4PPFFAE6AEB4B.namprd11.prod.outlook.com (2603:10b6:f:fc02::61)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 07:00:45 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:00:45 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcNL+QQn0dgmrpeUSObhHSZQs0bbS62gWAgAQvqwA=
Date: Mon, 13 Oct 2025 07:00:45 +0000
Message-ID: <IA0PR11MB71851DC9F2EE0B8E4914DB9CF8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-8-vivek.kasireddy@intel.com>
 <25cb995e-bb7f-4901-84e5-853d2a19b5c0@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <25cb995e-bb7f-4901-84e5-853d2a19b5c0@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS4PPFFAE6AEB4B:EE_
x-ms-office365-filtering-correlation-id: 86c877b1-2938-42a7-5357-08de0a263b82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SDBHAMr/zbaZdX0qn47oB8L4LjQDtCFmcIYginelYYZrj5Mv2jh/P1ABZF?=
 =?iso-8859-1?Q?A85mfB2uKNb8tz7MzLlOmgE2AjtEYLlXsSai1I4Y2kUIEmpuQLO58rv3fN?=
 =?iso-8859-1?Q?CJxJP7m27OarbvuJ+l0s9n9nfAF53caFCs3+z93iRMsabem9/1Gjm1B7OI?=
 =?iso-8859-1?Q?hOxz2Maa33ZdO8V+TQKulL52Svdg8zI8FtOepXZjuBQKEocbXqa2wd7XJz?=
 =?iso-8859-1?Q?Gsc6QvMhkZmtCSTFJx7+duZhczS0onRWELs2ht/zotCTgKUMgiKHqcmFp2?=
 =?iso-8859-1?Q?9V/1uFzASaYREkf8pQk5bx5bQr2K1bVkhsuJ0VGqNQMudHVkzhgaE4XF9/?=
 =?iso-8859-1?Q?DaiR4/c8vbTeY77crQHX8tzb3aSc6xWSBoG8CdEONddKP2UtCFzimWYDjr?=
 =?iso-8859-1?Q?IA9fd+OLoRX8qRKBjMJNYqTRrm1iMKGD+7YqHhwbpyBrqNFLW8L3URSd0a?=
 =?iso-8859-1?Q?KRGQaV92Xi0YpLbkUkMK3bBfhfLLNsfJQsEHaJiDWDb/TqsFm5L9WXuGDR?=
 =?iso-8859-1?Q?rWqDxrCh2DoeBeI0ZLl87/IB2BHBVU7vh0r3skk8JBTL+pktrw/hABQS6y?=
 =?iso-8859-1?Q?GVl5xMluNPnaOtsGo/oOYmvnuEB17vmOueTBeHq+I/qIkNuusTO2dIRzsX?=
 =?iso-8859-1?Q?R/48ptAaSeF+9V54J045qPgH2roA9PC2jrxu7RFS8m6T75VH8qdpHqUrLO?=
 =?iso-8859-1?Q?yRgrag7Yzb8Yg1m8zrKAA7aTVerRsuWu4GWP4WaRlrjXZNnCyHluO2hcFg?=
 =?iso-8859-1?Q?wJV9vbKtLnRdqLXRy0nKbS83NQXF7O1iH6jAAibUgrwSVllqNXNMNG4BaO?=
 =?iso-8859-1?Q?f+dkQR8to1TgauAuFIthQpANF4a4LZzwFKcpqsBc3Wpw1S8k3DC1g5FqCk?=
 =?iso-8859-1?Q?pknmTvg++Kcr2Lo1yPowKVCNmD8p/XixhB64IehV4Fke3zN77jfVewg3+u?=
 =?iso-8859-1?Q?vFGJU5vE2/vHdJNHSMxPnCeqaVkp4VPrzSznZYpWNC9ik7g8FFkvEN3pYU?=
 =?iso-8859-1?Q?36yLXLZV13ul04/TNIhbxV/umhpsUDZ24VBbBfis3pIrTZmUZsEzus7Un8?=
 =?iso-8859-1?Q?Pm/eYLlQNIRTDpkbe69Kt3jT8o7dzV5bkbIjwsDDLk1XXYNSk9HKuJfuXC?=
 =?iso-8859-1?Q?gPLpKgcA0+jhnJMlL2J6jzHmTvETne3KxFg6MPi9rs35Z6M9BwFPx3AoqE?=
 =?iso-8859-1?Q?Oucvvuj2R3s9LL5QIq1GyT2DOBYeHQcTXVDNFNvWeoFJmnRUTkRY2ejCXj?=
 =?iso-8859-1?Q?fyhppiAD1hiyLUwZEQccLAJB6Z+dUsm1orq5sUV/mcMjF26cqO3hhSVbl1?=
 =?iso-8859-1?Q?eVLYLz1Fliju3VMoseGpOg8blpUVFc1ZN6URogntz8ZEojot/opnQY00iI?=
 =?iso-8859-1?Q?oZ1zAX4lbyk/iddfGr2bRcunwNJmj/tCOA3JZNYgRn8DBDbpWaUIq/3Al8?=
 =?iso-8859-1?Q?H6K6rHBEg9JVxY4nwiNmM53DFd94gF99xfery/pclxeMBY7SV3C6p1Am6c?=
 =?iso-8859-1?Q?KYIck2WkjlJ10g6+q6u5kEgDLPEaWDaZZgP5lzItx1OlE3chbgAJV+naga?=
 =?iso-8859-1?Q?+PvK6mLGuYHyKovcBEaeP7iHP2W9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oTNV34isDaO5tnjlsCZguhFHM1mel35HQAX4NXy8iaQEEDvb1/ESHOok4L?=
 =?iso-8859-1?Q?c4zRxjxuVR/qxSv90zK7/G0FpYu/eSjr+uFvcM/hPoxrPFQwUuVP6ZKrM4?=
 =?iso-8859-1?Q?YoRispi/uOWZ49/gotLjvbQOuBjpebI8V97ghI0pKZjSm6S1yfdr3S8AiH?=
 =?iso-8859-1?Q?eg8Lg1AeUUWhIBes0orSi0riGpv5O1JG1bXSaSSwcQnbYlYGkE00EPxNAo?=
 =?iso-8859-1?Q?+NRBWr4QFJ94Z5vUqzgrLjZQcABGgMoZOW4vjTSpv/KkFt0SID+ZOx7W+N?=
 =?iso-8859-1?Q?1b+g44FBhFCi0AZD02aD7vEPcyXu218egTsm8zjhOuikt0dORKnvWkW/nq?=
 =?iso-8859-1?Q?wGoQ1bFkp/lC8vRC4BoGow3jiwpPwFUPT0zgwwYwxXAGhOpRw8/EJcbNFi?=
 =?iso-8859-1?Q?/7JSEN1JzL1NFtCr8T+ihzJBoCkLzoiocdW8ym7KICsZ7cB1jeDJNQWn3g?=
 =?iso-8859-1?Q?QA5QhcVwlCn7on8XJTrAaxdyYkhbd7l2db8R3Tn2w2js+hDClNW8pe0NIB?=
 =?iso-8859-1?Q?sx/TzWfahtYdknaFJWxgB398U88Y3yfJL2gvM399jiMayjKNQNkmx9vrW8?=
 =?iso-8859-1?Q?zJyCUJehHZzoxKbTNDAu3nzJd9snVVTGGS41QlzRCnBotQpvDIxaTaw2Jb?=
 =?iso-8859-1?Q?h5ZvrHkEk7JtxRLU4s/g9VzwC3Vg5XZqKA+pFJqGPF8qex28ayWI/ec6kx?=
 =?iso-8859-1?Q?xWp9lbsKhF5Aabq/nNorKJ0pNvpu8FG+wtFclNqTpaEm6B0pgwrUDuO/Zr?=
 =?iso-8859-1?Q?SfCZquDzQ3x6ERmsrCbibasJ/+rrHP1VhEz+SKjQKh+N57Zh87UihSYPQX?=
 =?iso-8859-1?Q?xCDA8X3sFooPxeECV2jy6v25mKZ5JLSHdX4iWnXZ/KfMCuf/OkAeZD3LuT?=
 =?iso-8859-1?Q?5m1yzvB5SFf/pzxLC/d5DYYB4x/GowsC02jsEJRk6ObxXHcQ1UA5tZYK/b?=
 =?iso-8859-1?Q?TiD2RPjjnaAx8u/fA7wTFv3JheGOVeHyr4Jq4DoSqRfuhJ5Kv8G/Dx9kfV?=
 =?iso-8859-1?Q?XRMRCredRmB/kfCeggaVs7GqZtSJ5SF6/9GOAmExb6vBFUWUdGs5qhflEN?=
 =?iso-8859-1?Q?BmS8hFWfD3/UcRyNcZe5ev5wKt3Ahr6eQzwFY2WpIXxv9YVRp9fZFJb2g5?=
 =?iso-8859-1?Q?AG1BKVINgDPGr4IcTh94drHS7pK1jvpMFhJoH9t+U6ef2ZsdnFvNNbI/hc?=
 =?iso-8859-1?Q?5T4P7HRp9TtElH1UV+H8WboKsUFP/Mi2dOjks168ihf76uSj7AlsfySGsN?=
 =?iso-8859-1?Q?bSpkuY3FcjYUh+XqBJ3zz/tvuuPh0Z7AxV7ErXUiJpNCnc62Am6IpY6l3D?=
 =?iso-8859-1?Q?q2exg5vlwP+x6V8B1v9sp7he6B22qLI9Z4jlUKcN6FmVVt4lbjgixjSxe/?=
 =?iso-8859-1?Q?YRon4swOoq4dGYJTXfAiz7mN+mzOhIelNfJ41XYYQiX2EOe+ai7t7chemj?=
 =?iso-8859-1?Q?QLDK1pz2PipH/gtJKX96XL/Tk1bJrWroKSi20YQFHN0ACrkvSBlWNqHZKC?=
 =?iso-8859-1?Q?oqTWt7WgGyT6DLMOrHVtep3UUSC4J+4c9rz4qRWP/I+Mr6orlZQTiYLTaB?=
 =?iso-8859-1?Q?MgqSbrL8MMRmpxXMPp7f6D1OdU/SYITfRG6GCjU3UUVkOqnNyNRaqa2f3v?=
 =?iso-8859-1?Q?o6mD9Zi67NfPNGdnav09HakHu//2yNT+FH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c877b1-2938-42a7-5357-08de0a263b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 07:00:45.6350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dk1nPwsOLGd0O5J/UqWlYixXGl8f7Xu03RhgTN2DZCv0DKprxk9tM8MSD2SJCkR/wd7OeQp5oQ5kN8iUe4nHz39op99mLAhAW6ai4TfcUEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFAE6AEB4B
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
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

> Subject: Re: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 2025/10/04 8:36, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Therefore, we first need to figure
> > out if the blob is backed by a VFIO device region or a memfd before
> > we can call the right API to get a dmabuf fd created.
> >
> > So, once we have the ramblock and the associated mr, we rely on
> > memory_region_is_ram_device() to tell us where the backing storage
> > is located. If the blob resource is VFIO backed, we try to find the
> > right VFIO device that contains the blob and then invoke the API
> > vfio_device_create_dmabuf().
> >
> > Note that in virtio_gpu_remap_udmabuf(), we first try to test if
> > the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> > use the VFIO device fd directly to create the CPU mapping.
>=20
> It is odd to handle VFIO DMA-BUF in a function named "udmabuf". The
> function and source file need to be renamed.
Ok, makes sense. I'll rename it accordingly.

>=20
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/Kconfig              |   5 ++
> >   hw/display/virtio-gpu-udmabuf.c | 143
> ++++++++++++++++++++++++++++++--
> >   2 files changed, 141 insertions(+), 7 deletions(-)
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
> > diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-
> udmabuf.c
> > index d804f321aa..bd06b4f300 100644
> > --- a/hw/display/virtio-gpu-udmabuf.c
> > +++ b/hw/display/virtio-gpu-udmabuf.c
> > @@ -18,6 +18,7 @@
> >   #include "ui/console.h"
> >   #include "hw/virtio/virtio-gpu.h"
> >   #include "hw/virtio/virtio-gpu-pixman.h"
> > +#include "hw/vfio/vfio-device.h"
> >   #include "trace.h"
> >   #include "system/ramblock.h"
> >   #include "system/hostmem.h"
> > @@ -27,6 +28,33 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > +static void vfio_create_dmabuf(VFIODevice *vdev,
> > +                               struct virtio_gpu_simple_resource *res)
> > +{
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    res->dmabuf_fd =3D vfio_device_create_dmabuf(vdev, res->iov, res-
> >iov_cnt);
> > +    if (res->dmabuf_fd < 0) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> > +                      __func__, strerror(errno));
> > +    }
> > +#endif
> > +}
> > +
> > +static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
> > +{
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    VFIODevice *vdev;
> > +
> > +    QLIST_FOREACH(vdev, &vfio_device_list, next) {
> > +        if (vdev->dev =3D=3D mr->dev) {
> > +            return vdev;
> > +        }
> > +    }
> > +#endif
> > +    return NULL;
> > +}
> > +
> >   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resour=
ce
> *res)
> >   {
> >       struct udmabuf_create_list *list;
> > @@ -68,11 +96,73 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       g_free(list);
> >   }
> >
> > -static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource
> *res)
> > +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res,
> > +                              VFIODevice *vdev)
> > +{
> > +    struct vfio_region_info *info;
> > +    ram_addr_t offset, len =3D 0;
> > +    void *map, *submap;
> > +    int i, ret =3D -1;
> > +    RAMBlock *rb;
> > +
> > +    /*
> > +     * We first reserve a contiguous chunk of address space for the en=
tire
> > +     * dmabuf, then replace it with smaller mappings that correspond t=
o the
> > +     * individual segments of the dmabuf.
> > +     */
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, vdev-
> >fd, 0);
> > +    if (map =3D=3D MAP_FAILED) {
> > +        return map;
> > +    }
> > +
> > +    for (i =3D 0; i < res->iov_cnt; i++) {
> > +        rcu_read_lock();
> > +        rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false, &=
offset);
> > +        rcu_read_unlock();
>=20
> I don't think this RCU lock is necessary. The documentation of
> qemu_ram_block_from_host() says:
>  > By the time this function returns, the returned pointer is not
>  > protected by RCU anymore.  If the caller is not within an RCU critical
>  > section and does not hold the BQL, it must have other means of
>  > protecting the pointer, such as a reference to the memory region that
>  > owns the RAMBlock.
>=20
> This function is called with the BQL held, and a reference to the memory
> region is also taken in virtio_gpu_dma_memory_map().
I agree. I'll remove the RCU lock.

>=20
> > +
> > +        if (!rb) {
> > +            goto err;
> > +        }
> > +
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +        ret =3D vfio_get_region_index_from_mr(rb->mr);
> > +        if (ret < 0) {
> > +            goto err;
> > +        }
> > +
> > +        ret =3D vfio_device_get_region_info(vdev, ret, &info);
> > +#endif
> > +        if (ret < 0) {
> > +            goto err;
> > +        }
> > +
> > +        submap =3D mmap(map + len, res->iov[i].iov_len, PROT_READ,
> > +                      MAP_SHARED | MAP_FIXED, vdev->fd,
> > +                      info->offset + offset);
> > +        if (submap =3D=3D MAP_FAILED) {
> > +            goto err;
> > +        }
> > +
> > +        len +=3D res->iov[i].iov_len;
> > +    }
> > +    return map;
> > +err:
> > +    munmap(map, res->blob_size);
> > +    return MAP_FAILED;
> > +}
> > +
> > +static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource
> *res,
> > +                                     VFIODevice *vdev)
> >   {
> >       res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >                            MAP_SHARED, res->dmabuf_fd, 0);
> >       if (res->remapped =3D=3D MAP_FAILED) {
> > +        if (vdev) {
> > +            res->remapped =3D vfio_dmabuf_mmap(res, vdev);
> > +            if (res->remapped !=3D MAP_FAILED) {
> > +                return;
> > +            }
> > +        }
> >           warn_report("%s: dmabuf mmap failed: %s", __func__,
> >                       strerror(errno));
> >           res->remapped =3D NULL;
> > @@ -130,18 +220,59 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > +    VFIODevice *vdev =3D NULL;
> >       void *pdata =3D NULL;
> > +    ram_addr_t offset;
> > +    RAMBlock *rb;
> >
> >       res->dmabuf_fd =3D -1;
> >       if (res->iov_cnt =3D=3D 1 &&
> >           res->iov[0].iov_len < 4096) {
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> > -        virtio_gpu_create_udmabuf(res);
> > -        if (res->dmabuf_fd < 0) {
> > +        rcu_read_lock();
> > +        rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false, &=
offset);
> > +        rcu_read_unlock();
> > +
> > +        if (!rb) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: Could not find ram block for host addre=
ss\n",
> > +                          __func__);
> >               return;
> >           }
> > -        virtio_gpu_remap_udmabuf(res);
> > +
> > +        if (memory_region_is_ram_device(rb->mr)) {
> > +            vdev =3D vfio_device_lookup(rb->mr);
> > +            if (!vdev) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "%s: Could not find device to create dma=
buf\n",
> > +                              __func__);
> > +                return;
> > +            }
> > +
> > +            vfio_create_dmabuf(vdev, res);
> > +            if (res->dmabuf_fd < 0) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "%s: Could not create dmabuf from vfio d=
evice\n",
> > +                              __func__);
> > +                return;
> > +            }
> > +        } else if (memory_region_is_ram(rb->mr) &&
> virtio_gpu_have_udmabuf()) {
>=20
> memory_region_is_ram_device() and memory_region_is_ram() should be
> called for all iov elements, not just the first one.
I am not sure if it is enforced anywhere but I don't think a dmabuf's
segments (or entries) can refer to multiple memory regions. AFAIK,
the buffer associated with a dmabuf exists entirely within a single
memory region. And, when it needs to be migrated, it is moved=20
completely.=20

So, given that the goal here is to identify the region the dmabuf is
referring to, I think just using the first iov element to make this
determination is sufficient.

>=20
> Calling virtio_gpu_have_udmabuf() here is redundant since
> virtio_gpu_device_realize() already calls it.
Ok, I'll remove it.

Thanks,
Vivek

>=20
> > +            virtio_gpu_create_udmabuf(res);
> > +            if (res->dmabuf_fd < 0) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "%s: Could not create dmabuf from memfd\=
n",
> > +                              __func__);
> > +                return;
> > +            }
> > +        } else {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: memory region cannot be used to create =
dmabuf\n",
> > +                          __func__);
> > +            return;
> > +        }
> > +
> > +        virtio_gpu_remap_udmabuf(res, vdev);
> >           if (!res->remapped) {
> >               return;
> >           }
> > @@ -153,9 +284,7 @@ void virtio_gpu_init_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >   void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    if (res->remapped) {
> > -        virtio_gpu_destroy_udmabuf(res);
> > -    }
> > +    virtio_gpu_destroy_udmabuf(res);
> >   }
> >
> >   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)


