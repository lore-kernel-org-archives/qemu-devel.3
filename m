Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAD8F01804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPuP-00043b-HG; Fri, 06 Mar 2026 02:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vyPuN-00043P-Bk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:47:39 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vyPuD-0004cw-Os
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772783250; x=1804319250;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9tdGyb+H/2UuaQUmhHLu5mPTaopHbKC+YDAW7wcklHA=;
 b=nPVB1NcrUeCnSBOWkoOrBjWVWG1YMYq94RVOtn8yVBSy+ZfkuMkqc21d
 tEhqL2Y6Cm2tmhxLOpNZTfBRGDktJSX57ZH6/b+hsyQQtDv2bGkUGBaHO
 P8Xd4PYvWumS7y6WlQJr/maK4pC8jKomZMhz7gAlE56GyhK9alOmfXxm9
 v3lEuWUCNk5XkyPgoPClQfdJT9MlNJXNdIwz3o31e4FoDnZ00NKvN/8sQ
 i+7GSwITgo5VbT4RvEo6uajdWVSBSfFaWeKcvg2HJBiWzDLRMMro+DQlt
 FWc/nUw+AHNXPUjX+16h8F7qP3kRs6XzAYhpLt/peU6JG1KU6wXLLDaLI g==;
X-CSE-ConnectionGUID: YCa4FZyESr6WrYyV53M2Hg==
X-CSE-MsgGUID: 6ZBRmIXgT4KPyEykef7uEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73077786"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="73077786"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 23:47:25 -0800
X-CSE-ConnectionGUID: INg5leUwQ3SyBfxns+ebgA==
X-CSE-MsgGUID: QVxE+UbFTm6j74CemiqzQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="256840919"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 23:47:25 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 23:47:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 23:47:23 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 23:47:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n58Naev2Ma3xhfJWKbvU5Bt44PN9ZB+H+nrxctBdpmNHDwMty2vkaS9wN655d/J78w4I1ZnTxXRLeI84Q2Jh40qi8VaqyQwQCXGPiMLtLwvqHdS+zAuY/m/KHQnZcqchEhTDINXJ13UeUJ2oNEm8S9zdWhRJka0Suuvuyay+UxfQ6U14bipG4OvUTwuRfQl0urvLHVZFaXQUZOOe2s2hboawrXE+0WkmRqcT1PyhUPmSgqJCDHuOPJzpuiVQ+VpCUIda/+vg+8AY5j5x6lb33vO6sBydcJamH2FMwodmSqS2AcDf6i8Zj0QsIS1Eu5xcG9MGwiGqi4qqeHrFqk1uRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOgYvDhWL2iq6XYzHUCKP7Bk3Iw1KDDbK/sCsP2I/Ts=;
 b=VI5mQgvVHoOBRsg43Z2ieNDqAK08Buu5cOzGdkLRtJWXaWhHdIYlF8Uc6vvfSP0GQTRalo7DBDO4G0b686vCM0x9F1RwpjMlJq5Eq90pYGySP6T+lA7XPhQTTz3R5uuTvcnU85snOtu/Cfnh2IhPjAAew2VMfp5TnU9ZhmV2KNpVKjiaX+XLCPRvlLfRnivDgU5TBqT9epNpvG4rF1YLkeDZtR+j1ptpRNhQF6cLNqDkNmOtACNAr1NgyB9+HEcRZj5Y+i2GixpdI9CNu48xQkYrLo8DDc9cQM7Q8Bs0185Us5i+D5M6int60u08xTXyCCEY5QRsiB2h1BptjAIZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MN0PR11MB6279.namprd11.prod.outlook.com (2603:10b6:208:3c1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 07:47:21 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 07:47:20 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v9 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v9 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcrG2kSoq0BKLlH0KkQshv+g3cCrWfyqEAgAB6EvA=
Date: Fri, 6 Mar 2026 07:47:20 +0000
Message-ID: <IA0PR11MB7185E548B48C9E6A8E4E595EF87AA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260305065700.1155146-1-vivek.kasireddy@intel.com>
 <20260305065700.1155146-11-vivek.kasireddy@intel.com>
 <6d5d1e1c-2ed3-4f2f-ac35-f7086b877fad@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <6d5d1e1c-2ed3-4f2f-ac35-f7086b877fad@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MN0PR11MB6279:EE_
x-ms-office365-filtering-correlation-id: fbfc7fe9-6dfe-4cee-e078-08de7b549912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: Zvucwu2zTZv7gdyDDsa2NQEbsWJFY8UEisVCUl+b9HGEcwzklWKiQjvwV8AgExCZF9HBN90VCSF6ippL+cxEtIuIEVQIVSs2nzk2pE2xOczVMc3qqe6Qt1pzqJ94TtjloGJPJ8dETLhnAUwzdVMe+XfyR21hsilCbR3QYK/m0GgFk3SvtX1bH9Rha13p8ktOJEAewOcCENiO7W4JDk7NMYUhkS/icpoegdOlm6qBWdi9/3PKYlKeil8TvQhn/gwmOpODPFXPOdgBqKqmqzQ0vwNkPddS7kZymcMDpcC75aR6PqgyV0UsRRVMuNjK7n29yO0WZP4ogULCpCbOv6TCPepA7gvwnAYVTEvh8P9ZRkWnFwY6+yyud5nZTs2nfX41T2NzQuAvZBE3eM4zkT4O7S4IHVc9GzNnT6JDiwEwdWCXZnGqlod94a8hWC6SEwDyFkqFo3qlXsvsiZUoBkrMxPWLvW6g+J85vzgPL1hb/agP0PJ1BVE3qgAK/iY69Z5ABHW3pS6c0puwxyU1qgcJNxrpXQEQjeJVfUz8fjexHggJcwSlbr6f1b8Q/NjYNJuK92EteU1WeMcMPuoVbzbtq+sc4lfsA4vj4RrQDDMGl8m9KjwsjwyOKJcF1x4WZH9/UO3f9nuecuMiQ1zRJ4WYU7c17s5P5wqka10f3bOKlDlS1QqlhP4NNwbZRAKdQrSEPUJabWrkeQywNvuqJQZ/y+o9wvgXJ6FAkX+Fi6QEAyVIWSyGh7aaQKP69iJOF3qgKv2N1ja3r1BeOtEarEh58Cm2UePHmAWXSOG6EiiDaGw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?es3lGxVyndCWdvH16hZNpuv72dUfIRxn1raqabOf1WO5PMhxkJQmP52tRN?=
 =?iso-8859-1?Q?KkXYIi+HzmPHHfb33ZSRN4qmwMrzrb5Bb+H8KD7ppeGkVcQv/9Fm+UsQwy?=
 =?iso-8859-1?Q?rnD6pJSmVL9t4onZYmmmZM8UMCoR/nZmFoCbZEPh5qZIJ7ilpcbhaneKjz?=
 =?iso-8859-1?Q?W8cvI+jByrRqux/QGYKxHWagt+2MP7pkiw3L1axV1VwcN7lYAzzbzLL1C0?=
 =?iso-8859-1?Q?FRv3j2jiWrsCpbuV3KccQCNdxrADm1HG9JFETgW5llPg5jRCWfhzksJLxi?=
 =?iso-8859-1?Q?6yLw/62nUytM/sZyB9p54ocI6xGuOjHeSCLGSmhQiaA5iY/EMBpFC/X6G8?=
 =?iso-8859-1?Q?dawm1SM2PTOAjlMSWPDlpNDDN4fpYiRW3qi8a7pke0ww+K3QFgPEVQmKUT?=
 =?iso-8859-1?Q?bCR6Em7UobHm+zM+t1GojT5oyByA7Ca9Rrgr7AwTchZ2HN3D6WUCZ/Xg1z?=
 =?iso-8859-1?Q?o27HjnVWzeeFP15fepuNBcBYlGducJzrSVWl79kT2Vm847yFX6dYcp48mn?=
 =?iso-8859-1?Q?xeWTRe1NGiRHszljG6f2xEaO4QlMzv9pwN4Iy5xRn29k3dedscMZ+NViG3?=
 =?iso-8859-1?Q?xj0uGLAf039AaOyVzIq7rjr18eFlXJdUrQfTKNSscH9TlfZ1Cu6nAMEE+N?=
 =?iso-8859-1?Q?e9LEORwoogmqSdacA+xX8o1h7wuZjiT/BE07d6a7S+n7KV34rCL5wovYpu?=
 =?iso-8859-1?Q?i545UNA5ZIn/Gjb5j6nrPGJOkZ2B4EYuhDbkEw9j5nAtT+1CNOipuN4bct?=
 =?iso-8859-1?Q?h5ELPXwk3PKQM9x6afrn6oE3uODTB1yeNXsojf3fMa23jzbqGiMYMluTOH?=
 =?iso-8859-1?Q?FjphsPzVlxzMhAL3xVTGkvh1wy+MnCEelIZDCeKoT/yQdEBUSBOcEXI/+1?=
 =?iso-8859-1?Q?uAKRwyPoWbNTYfoMLQlCA9HkrycbSOAe2ZlqabhL9F9YkEWKFhB2A4dg0B?=
 =?iso-8859-1?Q?Ps3bkpouvC8besnIyl96/fbwzOYwhmRcMZYWOtIVRDpDmo7MBhysmb7vdU?=
 =?iso-8859-1?Q?tgOp7zN4FpWx/UmID+Mc3vsMjrWTxRnvhI7KSRnY/fRFCLazHOekuh83iX?=
 =?iso-8859-1?Q?VJdiMvchFyo/VEvtBztLD3spshoO6mmsglIh7atn46Yx9q8r+xwgskYPx+?=
 =?iso-8859-1?Q?PNWzSa+u1CFyJvHdS/23XLqMkMjz2LBjeYNzMluGfeSgT+2BOlsHduZ05m?=
 =?iso-8859-1?Q?FPTcdwOPYCzlLn8OcjmcsxjcukSQONwvevVUrOHbSqIT+a4Tv2ij+HZLPo?=
 =?iso-8859-1?Q?dtfCnLLQrNgkbTdPcr8WlXEEzZsoqEZjvTGOvEdYO1XUXrviBp7sfgKWve?=
 =?iso-8859-1?Q?591tRKpS3IW0qER4+vUyd3rtyQV6MScBAX9LI7olHXZssMnw5zzCOUGCmA?=
 =?iso-8859-1?Q?gP6DxJ6NFj1nGdF+KnhyICh6H9OqAX7e0faOA6ziuCCU6ULhqHtHWiW+Pj?=
 =?iso-8859-1?Q?ok/SmTqJSQ9ubb3Ms58SoNGfaL/eVHXfDztu4/9s04rMZqo8q0mU117/Cv?=
 =?iso-8859-1?Q?8TIiHddLUeIqut25rN4V1GLDajJ5ATtDO2gYgh1PzMp1V/V/RhsRzIlpCa?=
 =?iso-8859-1?Q?Y7IIgCPqt3Up3rK3akSs5TpcpOnzsCItSGvLQzhdD7aDXakAzvOcuIEJls?=
 =?iso-8859-1?Q?n44X45F90LY/qsgNcorJ1EQjQ6TRdm19FPjflrn5Pya4+VS9/L1mKoMYUl?=
 =?iso-8859-1?Q?EQTR5eUB/PTJ3Ny8GewFyypI1mLyDclbFyA9wKDy2RSOKMMIZhoJ5k59ye?=
 =?iso-8859-1?Q?79l/vMpF1LQmrHZvh7Hw3kdjpboe005C583Pykp5QQHIrKD3Vvvtmb0Acs?=
 =?iso-8859-1?Q?iqj8waB9Fw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MDd3qwgJubHdNi/2LdLo0eHO9pEgK5JPBgHVoVB0xDakv4FyISeDYEon4QpZHAwXKxgV3lJl2YZPiY/4uuo2TDl8X6Kp1aqReQX9P5KaW87sgicv62a6lnVI6a2JigHtYY1qlJi6oU4U9NUo2t+Z0d0pYQplqP5cYy8MoFLY+G7K6CEmnl8txbT16YLlT8MJREHCyROQuBZFsIWrh5zLlFe71cdJstiSAmwLUAHHKTg+Ge1Q7LMf++9kUaAWlpGKu84GkG86QMkrTR8D2yiK7A2NEMFzoViuMF4tUm7pE3sNpYthZmOigCQGeOwYkH5nbkktKT9xJVlaPsKbWOv3ew==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfc7fe9-6dfe-4cee-e078-08de7b549912
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 07:47:20.8375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNObUSM4kSSVtYRjQyXrKDXekny9z+N439b4iK9PRtD4n9pVOtudaVKkJ+48zp/9UovhVWxHVus3Y1ItHOUJRj2f9N55cOBm+D7XpiF7Yk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6279
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v9 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> On 2026/03/05 15:54, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Since, there is no effective way
> > to determine where the backing storage is located, we first try to
> > create a dmabuf assuming it is in memfd. If that fails, we try to
> > create a dmabuf assuming it is in VFIO device region.
> >
> > So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> > backing storage is located in a memfd or not. If it is not, we invoke
> > the vfio_device_create_dmabuf_fd() API which identifies the right
> > VFIO device and eventually creates a dmabuf fd.
> >
> > Note that, for mmapping the dmabuf, we directly call mmap() if the
> > dmabuf fd was created via virtio_gpu_create_udmabuf() since we
> know
> > that the udmabuf driver supports mmap(). However, if the dmabuf
> was
> > created via vfio_device_create_dmabuf_fd(), we use the
> > vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-dmabuf.c | 24 +++++++++++++++++++-----
> >   1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index dd64fbbc2d..7f4c399416 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -136,7 +136,7 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    Error *local_err =3D NULL;
> > +    Error *local_err =3D NULL, *vfio_err =3D NULL;
> >       void *pdata =3D NULL;
> >       int ret;
> >
> > @@ -155,10 +155,24 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >           }
> >
> >           if (ret =3D=3D VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> > -            qemu_log_mask(LOG_GUEST_ERROR,
> > -                          "Cannot create dmabuf: incompatible memory\n=
");
> > -            error_free(local_err);
> > -            return;
> > +            ret =3D vfio_device_create_dmabuf_fd(res->iov, res->iov_cn=
t,
> > +                                               &vfio_err);
> > +            if (ret > 0) {
>=20
> Zero represents a success by convention.
>=20
> > +                if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt,
> &pdata,
> > +                                            res->blob_size, &vfio_err)=
) {
> > +                    error_free(local_err);
> > +                    goto out;
> > +                }
> > +            }
> > +
> > +            if (ret =3D=3D VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "Cannot create dmabuf: incompatible memo=
ry\n");
> > +                error_free(vfio_err);
> > +                error_free(local_err);
> > +                return;
> > +            }
> > +            error_report_err(vfio_err);
> >           }
> >           error_report_err(local_err);
>=20
> This reports invalid IOV even when it is actually a valid pointer to
> VFIO and the VFIO is failing. Such an error report does not help and we
> should instead report only the VFIO error.
I thought reporting more errors to the user made sense here in this case.

>=20
> And there is another bug with the previous patch where res-
> >dmabuf_fd is
> invalid when virtio_gpu_remap_dmabuf() uses it.
Yeah, I see it. Will fix it in the next version. FYI, this was the only ver=
sion
I did not test as my test environment was not available.

>=20
> Below is my attempt to fix these issues:
It is a different style and structure (compared to mine) but I guess I'll a=
dopt
it in the next version to get things going. I do have one comment/question =
below.

>=20
>      if (res->iov_cnt =3D=3D 1 &&
>          res->iov[0].iov_len < 4096) {
>          res->dmabuf_fd =3D -1;
>          pdata =3D res->iov[0].iov_base;
>      } else {
>          res->dmabuf_fd =3D virtio_gpu_create_udmabuf(res, &local_err);
>          if (res->dmabuf_fd =3D=3D VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>              error_free_or_abort(local_err);
>=20
>              res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(res->iov,
>                                                            res->iov_cnt,
>                                                            &local_err);
>              if (res->dmabuf_fd =3D=3D
> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>                  res->dmabuf_fd =3D -1;
>                  error_free_or_abort(local_err);
>                  qemu_log_mask(LOG_GUEST_ERROR,
>                                "Cannot create dmabuf: incompatible
> memory\n");
>                  return;
>              }
>=20
>              if (res->dmabuf_fd < 0 ||
>                  !vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &pdata,
>                                           res->blob_size, &local_err)) {
>                  res->dmabuf_fd =3D -1;
I am wondering here and in the below else if what is the benefit of setting
res->dmabuf_fd to -1 if it is already negative? Also, if res->dmabuf_fd is
valid (non-negative) and mmap fails, shouldn't we call virtio_gpu_destroy_d=
mabuf()
to close the dmabuf fd?

Thanks,
Vivek

>              }
>          } else if (res->dmabuf_fd < 0 ||
>                     !virtio_gpu_remap_dmabuf(res, &pdata, &local_err)) {
>              res->dmabuf_fd =3D -1;
>          }
>=20
>          if (res->dmabuf_fd < 0) {
>              error_report_err(local_err);
>              return;
>          }
>=20
>          res->remapped =3D pdata;
>      }
>=20
> Regards,
> Akihiko Odaki
>=20
> >           return;


