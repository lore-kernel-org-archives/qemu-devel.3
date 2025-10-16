Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8D9CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9GbT-00016J-GG; Thu, 16 Oct 2025 01:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v9GbR-00016A-F0
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:32:41 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v9GbN-0003xA-MZ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760592757; x=1792128757;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JhJNvbZZoaVrTGnfWOKECVlbUKkwKwjsjOAldWVe0Io=;
 b=MwH9bDXsDIfuEimlzYYW8GuhuVvvw/ssS0+cxVoAw/X6VAhtrKDmaK5r
 skB7M44UiSdQKpTdN/gdVmU/DQoMhZM8a1mUofAkEzSpuRdAbK5oLlDNs
 PM5bUhoc/c64P52Y2XhBbJ1Du2ksupIm2A5UF+1ofZ+GFH+PqjrAcXguZ
 /Cs7t75zWgvdnJRXOk0xui7Yqv7xdPQOBh7xpD6A0qWzqf8DxHipXkxB3
 FlZK4zLrI+Cuj/ylhd3SeEJM7sP7DT31rkZnN/x6FG6Sp0x0XhE7pG/fk
 G4lvZ+RwasOmbjEwWhJjtjVKU5QVpmoIL3wohBpmcS7/g2Q5O12tIAsDa Q==;
X-CSE-ConnectionGUID: mdADeqkEQeapDp8o60hdEg==
X-CSE-MsgGUID: X1nt1ukhQSKCZE7eAR/epg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="88244896"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="88244896"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 22:32:28 -0700
X-CSE-ConnectionGUID: 3F28GyWuRoudOWHPu8bYpQ==
X-CSE-MsgGUID: vw4dtJd9SFqNpevwURUM+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="219511580"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 22:32:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 22:32:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 22:32:26 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 22:31:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxuYDu7J+yibsV5kfTfouEqZ+irUW9ef5C1L5Da7xgpApnNvPCptPV8mZq/IaOwnrUt22b6G12+iE7l3gC0WnyLD12khx/wtN78VDiHUx0wlyan5Q4HOfCU5RcCUHf7u+IEmIpoLHqbsF+yhMDAxZTya5RdOkqfBoRlRs4SoWctk/IxxBnj/Zik34jUZ9K7YL6k4x9iw65ADOC1O+3fshvcoqM/FepqlmvmrsECDgLD2WBvWsGfcb+tS6wuV8HAtQPJJQPud2LTGuLkgM5f3wPSqKlu+QmUBhnKbiWjKRE6byhhu7T+Qo27lTuwvwJJDRGjO7Uxvo+Fogqt+XQLvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbdhb66uaJhY4LTSDwGlHR25wpCa35mBYkb2LKrKWfA=;
 b=jBdFZvgYwjmotTLxBWEkxlJTTFLKoAkdlJy/662QjYwgPRjaG9ki/XvqS4ejlSSjUB2Vx/Kp94+HP1lt/nvEoR6bxYxaaXqYXymGZtFWWuSrGQYIgA5uL2pHLOC4c7UdGRYoaJ6wApC0GB1LwF3tPQpmDLM1j6gFQXoreVST6AD0jDfU6delgZQzsh2QwyG43oqH4X2YydVHz+g9l7sqGdj4OtLMZHLzyQA3cuIiUJugff5vWwOPdmc/CM7fJb/el+DVE8WLpGipU+vjbY2xgRWK8lw2Smi7fU9ghY2B6lMeWLU3Oy1GyZD035zAOo4sHpRsGHwIxvz2p3MivG2wGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MW6PR11MB8365.namprd11.prod.outlook.com (2603:10b6:303:240::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 05:31:52 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9203.015; Thu, 16 Oct 2025
 05:31:51 +0000
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
Thread-Index: AQHcNL+QQn0dgmrpeUSObhHSZQs0bbS62gWAgAQvqwCAAhi+AIABa/KQgAArEYCAAWKUoA==
Date: Thu, 16 Oct 2025 05:31:51 +0000
Message-ID: <IA0PR11MB71851E990B383EE8B0B67D44F8E9A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-8-vivek.kasireddy@intel.com>
 <25cb995e-bb7f-4901-84e5-853d2a19b5c0@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71851DC9F2EE0B8E4914DB9CF8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ce7ba7b4-f008-4afc-a603-990ac6dfa8a5@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185DAAE7F0B9A2252311250F8E8A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <0235556c-cae0-4ec2-80f8-951005032a3e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0235556c-cae0-4ec2-80f8-951005032a3e@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MW6PR11MB8365:EE_
x-ms-office365-filtering-correlation-id: fb83085e-8ef4-4846-3bd0-08de0c754f87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DLDns9YSTGg7W9g2lyNIPEYO16bS8g2AN9en8d+eFXuPIjTIeqVnUHO+Oq?=
 =?iso-8859-1?Q?92TLCksDIbKC9S2O0BpRMIA8/PMG3fLPHyaqUumB93l2yAi+8/VEf00Xmf?=
 =?iso-8859-1?Q?q/KMD/6XM6yjwEoBJYDqsNmzeMjmuQayhx0G02XSz6XmITLqtSSKxXUk2i?=
 =?iso-8859-1?Q?6a2IBF+PXOCoqJLeZ74EHIeBoSgIzzH2YC24i9RUh8YyrBLVdC6gpf6SpM?=
 =?iso-8859-1?Q?C7NM3AsYuWADLA5VXsF6RYwr0C94dSOifa7d9r2NSzzXVR73m6Kyfz6otJ?=
 =?iso-8859-1?Q?rnsDLZFPVePYmGc8uET6wtTnRen4iBLxYQC1QE2hahVSZfNCXREQe0d5c0?=
 =?iso-8859-1?Q?7NUYVOFjL7OPDMd8eHfZAZlCssn5s13CIkoaMj1gozn8opeoebxjLLHKsn?=
 =?iso-8859-1?Q?y8sMipJ0R1gnMNAKz5TZbHc4pyTxkmckjxaXOxqqVOkjHy3U2nYLjVRzuc?=
 =?iso-8859-1?Q?dm2xN4bN5OKX8EYlBpOiZsssTd5w2r16gB5ywWap/8/yRgqAn8uozKNv+l?=
 =?iso-8859-1?Q?WLr9XKrqEUCNJXvwL829Dly8h5yuqC1MkXgPFVAn3xsa/ReR8DXvn3lbNU?=
 =?iso-8859-1?Q?f7YIq8m5D6e8ZPtf0TBKetsdtLOTj57AhsMKDdK61Mm4rSNOLSHhsMBHM6?=
 =?iso-8859-1?Q?VD/bkpzr8zS1dYoEaOxIun/PyCFfw1lwV8kh0VO8s9n5d89Fq2QKqz8ELp?=
 =?iso-8859-1?Q?9TKkmUbvg/UvOnkQBN1F4uPCMKW2xl3LsF4st0emIaucqVWx1NNb/3dfln?=
 =?iso-8859-1?Q?0FJ/iTntGe+2wikTyrFdRB8HaXGRla6YCr4uFmqxl4iJywvEteX1vJYWh2?=
 =?iso-8859-1?Q?hTp+jg6pN4jvfOjrt29fdCWVdpX0mkYv6ni1xrjt5kNseYw+D3QbZxyYqc?=
 =?iso-8859-1?Q?oLXcjfLiZGhbqGIVyPE+c7gLWLxMTLXagObUTSfpuAoD39O5CTfrDRZ3zm?=
 =?iso-8859-1?Q?ni8+GZeH6b+yG8hiFs1hrceDA7eYFPMaMvxiS1s8P3wi9serLAhH+3sYgz?=
 =?iso-8859-1?Q?evAuJa6GGEZGxNBTa/Qed+s/U7vuKnu2Oa0CuSkxqRsVU67cUZlnYhzYvC?=
 =?iso-8859-1?Q?uEwFYhRa5mTCxSgwdwo4KrRuH83NwfPZTzaR4oEI2dmKSza3ppCnH66qD9?=
 =?iso-8859-1?Q?74Yr17BjxP5NbSMx2aQlCu9q3zhxC+xF3lV8p1GBXqZaVVdAiAn63pZKP9?=
 =?iso-8859-1?Q?DJf/tZGnpMXfpr548dceU+APBi7VkVHITadXwbA491jM4OuIZB1Dq1LABO?=
 =?iso-8859-1?Q?xdMF+zozSe1svqDIULGlZD1zSqJsxM1a0wExR2wV9cMGIxCE/Bxum6IgXe?=
 =?iso-8859-1?Q?KemqCVDymYephbIeyrCcsSrMHyVW9uYwW/BWjMqSbYnAVQgnU18YZB+M+8?=
 =?iso-8859-1?Q?1qjrKjnufDAp3Mt/vBS6GFMaodz66b/hEBXi7pUrGQW0oCU2FaCAnuDHgW?=
 =?iso-8859-1?Q?JyeFNMe4pF0W8IpqhVn3YYBDGWrSLmaHZM3TwLgae80YfG+4A6obQdtLf0?=
 =?iso-8859-1?Q?5tQ2dIUhPeAmhXbdSiXG8DCc90RMQFCg+QfDW14MgkmnYeDR7NkeC5yB7w?=
 =?iso-8859-1?Q?eVFNbIHtDqLQ39TPKgoJhCFHAfIt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1wFa1/Nl+wYuwQ3B4edZs7xe5D7VZvX5w8cTa6g4Yyge5M1b0xBHk86iNI?=
 =?iso-8859-1?Q?BucmQgysPdSftMaAIOEiwI86aQJQBnLq5T0b1W2wXCFfD1l0QlGZMsStjN?=
 =?iso-8859-1?Q?Vy1MfsdWOGn5N8G8xSJVXZkR6Hxe33O8/WcgralvQXXsQyznwv49eIl/6C?=
 =?iso-8859-1?Q?DWZ8nV3DRRDi7Hv0j8RkUtgj+PEO6Z1q9WYFmPkpVEiTaQEvEum37LSBRT?=
 =?iso-8859-1?Q?Kj63iYcFlHbZbt/QRj0DfM/LiFzSaIXCewggwV5YKy3p7Yo/0dj2SyX06u?=
 =?iso-8859-1?Q?5fRdijpf4nQiOZbjh0k2Mjo2F1HDIoROqZ+QE/f72L9fdmvIKBuSRtcabD?=
 =?iso-8859-1?Q?7QNhiiwlS40RuWoTSB+yEdBRelVG6yj7DXeoaxs3Yz7QY0lJKE4At8qkqG?=
 =?iso-8859-1?Q?ZRJHE5AmZxSN8KBkpyugCnCemgbaAPWTyBucAdC1FvWYGRSxxAHnGhGRPs?=
 =?iso-8859-1?Q?bdUXqKmW3+xGKuN+cNvXTSS+zh6+lK2YVh6CXxr7JO84GXUUaSajunw10M?=
 =?iso-8859-1?Q?tAdIocdofrdydAxoTwTSQlgZtD71RSbj0P7+vHJYKQmiyekiUUTryaaGWQ?=
 =?iso-8859-1?Q?L5hl3mAd1OesD1znB4RbkhGtFIRJVBqOs8GpNCxa/4cZEGeF9yWbiW68Pv?=
 =?iso-8859-1?Q?8PJG8eJzUW4cc3q0wJczmTWdONuJEwLQHJkEgnN7PemSIBlFnKVVeZN7Ik?=
 =?iso-8859-1?Q?1pSFEZNbatFD+DQagg8xuy+ZsjSJt8Aorl2vSqICH+AnZoZhqhFQ3MRDIl?=
 =?iso-8859-1?Q?Hy3TfB1dpoIl1zSKqtW8+1Cz5H+erjfiUZGeFnqSXHsbf/U8PTw+DdBugC?=
 =?iso-8859-1?Q?BQ/ts6/ptJuC8xJpqqcV8rXf7QfLap+YaZnpaheFEwib7eFzNeT1QVHYgN?=
 =?iso-8859-1?Q?WXdTZ9X18SGXqP6hMCvw0RJ2bkrMoQ2+E/jlR/X5yd5x8OMXPuNjaVu2I0?=
 =?iso-8859-1?Q?mCzokXEKjd9gYo4qOLuV9zTZ9GC0gK42KxXGjTyb3DWOrx8xAPvxXZIt0K?=
 =?iso-8859-1?Q?3QK9Rc5vM05uDYXV2A+b7jSAk8UxxV87kcr9Zm34zJvQO1okhOx7Rf7ayk?=
 =?iso-8859-1?Q?YNjXHb5zcxQdQZD3P5q8VvX0MUqJUORfQeC2DjSoxsja2NCKW+uRknYFpt?=
 =?iso-8859-1?Q?0Uwh2SURyyworkpd+TwbJ7LBnlBMyeiUdrWio81ZRFLAbHi4HiHwVswYuA?=
 =?iso-8859-1?Q?EDEggz9oYhGwCNaWznT8DJbXO4emI/qHhTnaeDGxOSdklUbnNLe4Z4Qo6q?=
 =?iso-8859-1?Q?RYCBQpqC0GIvblleTMaj0TlQFNguBrNaJ/cg9BltIa9l5mb+gzI9kFiSto?=
 =?iso-8859-1?Q?qOKCyBUb8sdylLNqCRw+gcB12z0ivxXoZ/uiG0oTX3W7CHBDEzHM0/Uodj?=
 =?iso-8859-1?Q?vIuIUqc8/7AzteUrhWSEpWWbYqq9yuB5YZnmX8p2DPQDZb1E0nAdFK0yjM?=
 =?iso-8859-1?Q?zKNfZk7DqE6NtAvtQtV27Jj+4S+99Vx0HwZacskmr6b+XDLWSWipjYBPDn?=
 =?iso-8859-1?Q?pSXJ9vWm4kHwzuRNfwwQKsQ2n+eLNim96lYL+/WrVer2PdjXv9bTv+pX9P?=
 =?iso-8859-1?Q?q3/4Fk7EcfHHq0Q4a9oDufO3UtExqscPrA6hB+n6Yvbx0GikHoQwU0oicU?=
 =?iso-8859-1?Q?4eLxASl8QnlF39KA0iv1Cw5ZSNQrG7C1LK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb83085e-8ef4-4846-3bd0-08de0c754f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 05:31:51.7634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zf+83pSre0OPsvgX/wE1lGhem/DyYL/39eZfAaIcV+WR+8I2Lai78dQIUubdXfgk/RFb1I7i1ETBV9Y/BAR5qojUUmOtyhXh1dltEOExM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8365
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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

> Subject: Re: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 2025/10/15 13:54, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blob=
s
> >> associated with VFIO devices
> >>
> >> On 2025/10/13 16:00, Kasireddy, Vivek wrote:
> >>> Hi Akihiko,
> >>>
> >>>> Subject: Re: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for bl=
obs
> >>>> associated with VFIO devices
> >>>>
> >>>> On 2025/10/04 8:36, Vivek Kasireddy wrote:
> >>>>> In addition to memfd, a blob resource can also have its backing
> >>>>> storage in a VFIO device region. Therefore, we first need to figure
> >>>>> out if the blob is backed by a VFIO device region or a memfd before
> >>>>> we can call the right API to get a dmabuf fd created.
> >>>>>
> >>>>> So, once we have the ramblock and the associated mr, we rely on
> >>>>> memory_region_is_ram_device() to tell us where the backing storage
> >>>>> is located. If the blob resource is VFIO backed, we try to find the
> >>>>> right VFIO device that contains the blob and then invoke the API
> >>>>> vfio_device_create_dmabuf().
> >>>>>
> >>>>> Note that in virtio_gpu_remap_udmabuf(), we first try to test if
> >>>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>>>> use the VFIO device fd directly to create the CPU mapping.
> >>>>
> >>>> It is odd to handle VFIO DMA-BUF in a function named "udmabuf". The
> >>>> function and source file need to be renamed.
> >>> Ok, makes sense. I'll rename it accordingly.
> >>>
> >>>>
> >>>>>
> >>>>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>>>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>>>> ---
> >>>>>     hw/display/Kconfig              |   5 ++
> >>>>>     hw/display/virtio-gpu-udmabuf.c | 143
> >>>> ++++++++++++++++++++++++++++++--
> >>>>>     2 files changed, 141 insertions(+), 7 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> >>>>> index 1e95ab28ef..0d090f25f5 100644
> >>>>> --- a/hw/display/Kconfig
> >>>>> +++ b/hw/display/Kconfig
> >>>>> @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >>>>>         depends on VIRTIO_PCI
> >>>>>         select VGA
> >>>>>
> >>>>> +config VIRTIO_GPU_VFIO_BLOB
> >>>>> +    bool
> >>>>> +    default y
> >>>>> +    depends on VFIO
> >>>>> +
> >>>>>     config VHOST_USER_GPU
> >>>>>         bool
> >>>>>         default y
> >>>>> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gp=
u-
> >>>> udmabuf.c
> >>>>> index d804f321aa..bd06b4f300 100644
> >>>>> --- a/hw/display/virtio-gpu-udmabuf.c
> >>>>> +++ b/hw/display/virtio-gpu-udmabuf.c
> >>>>> @@ -18,6 +18,7 @@
> >>>>>     #include "ui/console.h"
> >>>>>     #include "hw/virtio/virtio-gpu.h"
> >>>>>     #include "hw/virtio/virtio-gpu-pixman.h"
> >>>>> +#include "hw/vfio/vfio-device.h"
> >>>>>     #include "trace.h"
> >>>>>     #include "system/ramblock.h"
> >>>>>     #include "system/hostmem.h"
> >>>>> @@ -27,6 +28,33 @@
> >>>>>     #include "standard-headers/linux/udmabuf.h"
> >>>>>     #include "standard-headers/drm/drm_fourcc.h"
> >>>>>
> >>>>> +static void vfio_create_dmabuf(VFIODevice *vdev,
> >>>>> +                               struct virtio_gpu_simple_resource *=
res)
> >>>>> +{
> >>>>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> >>>>> +    res->dmabuf_fd =3D vfio_device_create_dmabuf(vdev, res->iov, r=
es-
> >>>>> iov_cnt);
> >>>>> +    if (res->dmabuf_fd < 0) {
> >>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> >>>>> +                      __func__, strerror(errno));
> >>>>> +    }
> >>>>> +#endif
> >>>>> +}
> >>>>> +
> >>>>> +static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
> >>>>> +{
> >>>>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> >>>>> +    VFIODevice *vdev;
> >>>>> +
> >>>>> +    QLIST_FOREACH(vdev, &vfio_device_list, next) {
> >>>>> +        if (vdev->dev =3D=3D mr->dev) {
> >>>>> +            return vdev;
> >>>>> +        }
> >>>>> +    }
> >>>>> +#endif
> >>>>> +    return NULL;
> >>>>> +}
> >>>>> +
> >>>>>     static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource
> >>>> *res)
> >>>>>     {
> >>>>>         struct udmabuf_create_list *list;
> >>>>> @@ -68,11 +96,73 @@ static void virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>>         g_free(list);
> >>>>>     }
> >>>>>
> >>>>> -static void virtio_gpu_remap_udmabuf(struct
> >> virtio_gpu_simple_resource
> >>>> *res)
> >>>>> +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource
> *res,
> >>>>> +                              VFIODevice *vdev)
> >>>>> +{
> >>>>> +    struct vfio_region_info *info;
> >>>>> +    ram_addr_t offset, len =3D 0;
> >>>>> +    void *map, *submap;
> >>>>> +    int i, ret =3D -1;
> >>>>> +    RAMBlock *rb;
> >>>>> +
> >>>>> +    /*
> >>>>> +     * We first reserve a contiguous chunk of address space for th=
e
> entire
> >>>>> +     * dmabuf, then replace it with smaller mappings that correspo=
nd to
> >> the
> >>>>> +     * individual segments of the dmabuf.
> >>>>> +     */
> >>>>> +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> vdev-
> >>>>> fd, 0);
> >>>>> +    if (map =3D=3D MAP_FAILED) {
> >>>>> +        return map;
> >>>>> +    }
> >>>>> +
> >>>>> +    for (i =3D 0; i < res->iov_cnt; i++) {
> >>>>> +        rcu_read_lock();
> >>>>> +        rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, fals=
e,
> >> &offset);
> >>>>> +        rcu_read_unlock();
> >>>>
> >>>> I don't think this RCU lock is necessary. The documentation of
> >>>> qemu_ram_block_from_host() says:
> >>>>    > By the time this function returns, the returned pointer is not
> >>>>    > protected by RCU anymore.  If the caller is not within an RCU c=
ritical
> >>>>    > section and does not hold the BQL, it must have other means of
> >>>>    > protecting the pointer, such as a reference to the memory regio=
n that
> >>>>    > owns the RAMBlock.
> >>>>
> >>>> This function is called with the BQL held, and a reference to the me=
mory
> >>>> region is also taken in virtio_gpu_dma_memory_map().
> >>> I agree. I'll remove the RCU lock.
> >>>
> >>>>
> >>>>> +
> >>>>> +        if (!rb) {
> >>>>> +            goto err;
> >>>>> +        }
> >>>>> +
> >>>>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> >>>>> +        ret =3D vfio_get_region_index_from_mr(rb->mr);
> >>>>> +        if (ret < 0) {
> >>>>> +            goto err;
> >>>>> +        }
> >>>>> +
> >>>>> +        ret =3D vfio_device_get_region_info(vdev, ret, &info);
> >>>>> +#endif
> >>>>> +        if (ret < 0) {
> >>>>> +            goto err;
> >>>>> +        }
> >>>>> +
> >>>>> +        submap =3D mmap(map + len, res->iov[i].iov_len, PROT_READ,
> >>>>> +                      MAP_SHARED | MAP_FIXED, vdev->fd,
> >>>>> +                      info->offset + offset);
> >>>>> +        if (submap =3D=3D MAP_FAILED) {
> >>>>> +            goto err;
> >>>>> +        }
> >>>>> +
> >>>>> +        len +=3D res->iov[i].iov_len;
> >>>>> +    }
> >>>>> +    return map;
> >>>>> +err:
> >>>>> +    munmap(map, res->blob_size);
> >>>>> +    return MAP_FAILED;
> >>>>> +}
> >>>>> +
> >>>>> +static void virtio_gpu_remap_udmabuf(struct
> >> virtio_gpu_simple_resource
> >>>> *res,
> >>>>> +                                     VFIODevice *vdev)
> >>>>>     {
> >>>>>         res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >>>>>                              MAP_SHARED, res->dmabuf_fd, 0);
> >>>>>         if (res->remapped =3D=3D MAP_FAILED) {
> >>>>> +        if (vdev) {
> >>>>> +            res->remapped =3D vfio_dmabuf_mmap(res, vdev);
> >>>>> +            if (res->remapped !=3D MAP_FAILED) {
> >>>>> +                return;
> >>>>> +            }
> >>>>> +        }
> >>>>>             warn_report("%s: dmabuf mmap failed: %s", __func__,
> >>>>>                         strerror(errno));
> >>>>>             res->remapped =3D NULL;
> >>>>> @@ -130,18 +220,59 @@ bool virtio_gpu_have_udmabuf(void)
> >>>>>
> >>>>>     void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource
> *res)
> >>>>>     {
> >>>>> +    VFIODevice *vdev =3D NULL;
> >>>>>         void *pdata =3D NULL;
> >>>>> +    ram_addr_t offset;
> >>>>> +    RAMBlock *rb;
> >>>>>
> >>>>>         res->dmabuf_fd =3D -1;
> >>>>>         if (res->iov_cnt =3D=3D 1 &&
> >>>>>             res->iov[0].iov_len < 4096) {
> >>>>>             pdata =3D res->iov[0].iov_base;
> >>>>>         } else {
> >>>>> -        virtio_gpu_create_udmabuf(res);
> >>>>> -        if (res->dmabuf_fd < 0) {
> >>>>> +        rcu_read_lock();
> >>>>> +        rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, fals=
e,
> >> &offset);
> >>>>> +        rcu_read_unlock();
> >>>>> +
> >>>>> +        if (!rb) {
> >>>>> +            qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> +                          "%s: Could not find ram block for host a=
ddress\n",
> >>>>> +                          __func__);
> >>>>>                 return;
> >>>>>             }
> >>>>> -        virtio_gpu_remap_udmabuf(res);
> >>>>> +
> >>>>> +        if (memory_region_is_ram_device(rb->mr)) {
> >>>>> +            vdev =3D vfio_device_lookup(rb->mr);
> >>>>> +            if (!vdev) {
> >>>>> +                qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> +                              "%s: Could not find device to create=
 dmabuf\n",
> >>>>> +                              __func__);
> >>>>> +                return;
> >>>>> +            }
> >>>>> +
> >>>>> +            vfio_create_dmabuf(vdev, res);
> >>>>> +            if (res->dmabuf_fd < 0) {
> >>>>> +                qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> +                              "%s: Could not create dmabuf from vf=
io device\n",
> >>>>> +                              __func__);
> >>>>> +                return;
> >>>>> +            }
> >>>>> +        } else if (memory_region_is_ram(rb->mr) &&
> >>>> virtio_gpu_have_udmabuf()) {
> >>>>
> >>>> memory_region_is_ram_device() and memory_region_is_ram() should
> be
> >>>> called for all iov elements, not just the first one.
> >>> I am not sure if it is enforced anywhere but I don't think a dmabuf's
> >>> segments (or entries) can refer to multiple memory regions. AFAIK,
> >>> the buffer associated with a dmabuf exists entirely within a single
> >>> memory region. And, when it needs to be migrated, it is moved
> >>> completely.
> >>
> >> It should be explicitly enforced. Please refer to section "Unexpected
> >> Device Accesses" in: docs/devel/secure-coding-practices.rst
> > Ok, I'll add a helper function to check whether all the entries belong =
to
> > a single memory region or not.
>=20
> Entries do not have to belong to a single memory region. The existing
> code allows creating a blob composed of multiple memfds so ideally the
> behavior should be preserved.
The ability to create a blob/dmabuf from multiple memfds does not exist
by design and AFAICT, it never actually happens practically.

>=20
> I also think it's better to test the requirement in
> vfio_device_create_dmabuf() and virtio_gpu_create_udmabuf() instead of
Since its the res->iov entries that need to be checked, I am thinking of ad=
ding
a helper in util/iov.c and having both vfio_device_create_dmabuf() and
virtio_gpu_create_udmabuf() call the helper function.

Thanks,
Vivek

> adding another function. This way, you can avoid enumerating entries
> again and prevent a mistake to forget checking memory regions before
> creating DMA-BUF.
>=20
> Regards,
> Akihiko Odaki

