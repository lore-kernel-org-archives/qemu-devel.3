Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA12FCF2570
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 05:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLayD-0005wG-3j; Wed, 19 Nov 2025 00:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vLayB-0005v4-JC
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 00:43:07 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vLay8-0007Uw-Q8
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 00:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763530985; x=1795066985;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Rso24emARchyBg0BR8BKF+m1G0z8bf3W27mLqc94bCo=;
 b=dodhwWZjsbWmw9yERfrqmtQufytgiriQLjiOGsX6DzxoBnxeRaOywMFY
 4QTZ4xuyOARCh3pJEBPPwjhPMDPD8YmV9ywa0iiCOMSs6Nb3lFYnu+wvs
 ipTivhGJtjripMdvBF+p2HRU5vp8SSQYApKXYMm0Aazv2PiYO8kT0/XtH
 9rKaICp6UnGVl2E5DJOPZsLmlsA+yJWvZBti2IgGO3TjTG2q23MepnliZ
 MgBto0JAY2lOhGWDDfCPDbRUxdR/HoNGCOl4pa3UTO7wYVVBGVl69h9rV
 sDrox6mBwSZP9YRgaFqxcedm5SyOYmFvbxzlzuHeeGQc95sg9XNNiHHIO g==;
X-CSE-ConnectionGUID: nLFIZM+STlCU0KkXwnVD9w==
X-CSE-MsgGUID: e42ujb8tS2ijMnVAwomCHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="53136059"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="53136059"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 21:43:01 -0800
X-CSE-ConnectionGUID: 1WSQBc0aS2+2tQRldvLn4g==
X-CSE-MsgGUID: q+xAu7HWT8uiGwP1FBx2Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="190614151"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 21:43:01 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 21:43:01 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 21:43:01 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 21:43:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFX0SL3V8e6MYLSB1S8rL36xYAaF4203/MxnwwabAdtQWLRvfn3VT+8BfMuR9GmmDwHisK1Hlmt0afEiFohZBh6ndgHQsdKkotju6MjrmQNueQYkV1Feq7cjM4nAXAa6R8C0wYVJJ6a3Q+k4ucTu1NsOx+f05agr8eUA6z0YC+YYmhQ8HTXCDTC7SqzdR9kGA1bjGmb19aKfyncB3RhXi76mI5SK+AG4bkGcOshArTtExdlh8jh3HBteQicON5x7Cv0cBesgaztQw9NAvY5471pR5I8Vd+rtuklVjjrc/Is+0elttPLHeKxWyRRf1MPns2ZDG3t5Z12PD08JAwGPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhZoec3ya0QL+AnV3tZx3SSu79Npqub84+S5pzc7SaI=;
 b=e12Vk14weoE9aD8HlYNhaLc8bj1sgRaaB+jH2QgirYXDRfMifYGy9RRwDJH1uiiSYXOVt1RVlD9VW+egn0rsXbdK4erX+/ONW2Cx5RtGrrDXjoDagMOJfkE4wMIe6IqjOkRF+M+xYxjvlwhYQ8ae0RytUsll/E+7Yy5ztzDt5qluzx5gSbND4gpzT2Nc3bi/PnDXR90fuya57gTAFRysHNgeC1ryHqbV+/c5UqGe1ODtD3ayHrR0hNv9PP7RTTSfK/Vi8QsA7oXXd/41U369azfZyLH6Z/g75GkMFoEt1zxM6EmOAY6vqmjC6AbacR3Py8E6X5+9zy/6/arNjreAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA3PR11MB8919.namprd11.prod.outlook.com (2603:10b6:208:576::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 05:42:59 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 05:42:59 +0000
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
Thread-Index: AQHcUTsfaCBAQNqK6UqI5jTHJ6PIg7Ts6XoAgAE6QFCAAJJ2gIAA3p9AgABvJgCAAROboIAFZI8AgAEGRKCAAHYegIAA+XkA
Date: Wed, 19 Nov 2025 05:42:59 +0000
Message-ID: <IA0PR11MB7185B46F9919473A37BBFC0DF8D7A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-3-vivek.kasireddy@intel.com>
 <ea2e1bd7-d681-4929-b902-1948b854e488@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185866AD30B9A73097934CCF8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8b8e3b19-7696-4b7c-8d74-eab2028dcd02@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71857687EC63A9A8D46476C7F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <e9424a92-f612-4cce-abc1-5336949ca71b@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71852A2F1894A75CE0B7EB13F8C9A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a5b4e817-93b2-45c3-8c59-21a4b65174b4@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71852665F80155422F4714E2F8D6A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <329aaeec-0fb6-467b-922a-a17743a62a05@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <329aaeec-0fb6-467b-922a-a17743a62a05@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA3PR11MB8919:EE_
x-ms-office365-filtering-correlation-id: ff8075aa-00cb-488a-4b33-08de272e7f50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?b0peUL7WqKKbzxT1Dc8Mj7YVpK3s4xf+eJTM3UxMFDjeAS/KBPBU67qNGG?=
 =?iso-8859-1?Q?zHucWd7KfT3EaPuhlK521veSDBXEmO5nf5JuiOIEmrFcOaej0hND4fUFy5?=
 =?iso-8859-1?Q?cq2koRXKz/BmgHWYjrQOqSnQ7vcpd+PDdQekR/215j6viqRyiOElZdxenN?=
 =?iso-8859-1?Q?EF6Q2PAYIalkX+9AKeaa24A34J4dS4ZkSLP+5r4w+9hsR/rM8p2aMxMcC6?=
 =?iso-8859-1?Q?3OHANE9w2aJyKAQKAvYF34RrA3zlhPk/OKtQzoY7s1eJokTkk+IiPD38u7?=
 =?iso-8859-1?Q?lv3w5Jr6be38ULCjqmtN684AEgnsKtAKO6AT5vsebEtqeb+kPQzq9udmgQ?=
 =?iso-8859-1?Q?iI3NmyBc6sJQykUkasyUXeIaIO59AJ1l2CVUwEV2M70vYiJyAUKNxh2wbX?=
 =?iso-8859-1?Q?GYdYNHAdcxNYFFLETWnp4ulsqo/4ib+5OPHbZ3O74XM2LsnOgz7qMW3zTp?=
 =?iso-8859-1?Q?EunXr/4gYJEe7Ymjeytsj45my6zu2nMZcLspNeLO86PTwVaR4BlYKuUpN/?=
 =?iso-8859-1?Q?z8LNyCJTHsGr0Il/y4DPHNS+gwxgcpiATFa7q51Lu3qUO2tboB4/liOR0d?=
 =?iso-8859-1?Q?MQnH6oS2kIXFtYHvlegtelSK0jvxm6D5S3Q+flAbW0XNi62hpwfc+3xADT?=
 =?iso-8859-1?Q?1RHoFcguFlMoBsllhGbi3jDZjcv39kVO2pwpXCrA0Zu9OwwXPxyP1/Gipw?=
 =?iso-8859-1?Q?UeheKYopKwG+a+ztPByaBg53/r4JMWMMzCe9rI6kGKyrvdiXCwpO3Whope?=
 =?iso-8859-1?Q?tnyRAClLIBxEI0G2UHhGoM8LhSx7hvk6DwY2WgdHlElG5fB/tg6nF1Pt/E?=
 =?iso-8859-1?Q?LJFHKJDe214Qzoq170tr0NmoqZKmsw3SPvD/fpY4eYHK/M8eWfxRth45OT?=
 =?iso-8859-1?Q?jgUsjm9Wj3JIOadro309MXQdLNvI/roXPcIHmz/bzzWqomRzPPR4hnMdSk?=
 =?iso-8859-1?Q?14VaOYVEnjC11orZyVDWVoHFVI68WsxHVn6385/TK0NoPPFvJpZyfHQJLk?=
 =?iso-8859-1?Q?k9CC4WUlwVaf6ONlqsGLtFcufRZIxnqmYNi11hCysuxkEp2fc7Ufg49Y/8?=
 =?iso-8859-1?Q?DmtIm1xX2gW76tDISNxA8YtjCN5BwUp35qhdGLSE8YwJoCg8QcnP5Qv8Bk?=
 =?iso-8859-1?Q?C7sRv8pFJSuF0d6sbY9ESknet+n3sVOhuU7A/CNejo8HYpW75qjO6hEMz7?=
 =?iso-8859-1?Q?A7Dbmyd/Ws4xVjL+n5iidUnoVdUSuKpU9MSwRq4PJyDy2CNxuEbMBuUCFa?=
 =?iso-8859-1?Q?ept37LEgJqkKmlJdfanKdyt80g9rypZyP64IVkRI5kePCx32IVbliV7hL/?=
 =?iso-8859-1?Q?HAJJJE+y1f394B/kdJ0EzNAUSvDLoH7e4dL+LwvOthfNhXBuYdokFsV+jL?=
 =?iso-8859-1?Q?7Q2CSqWdzr9r4zITVe3OdA8LZx58MJQXkXFcxnyyZmsgF4q2JovMqztHdL?=
 =?iso-8859-1?Q?gT8e/ECa0iRJO6JbXOZEHSOWgL7Ij+zabSAdqtkRxwdC1+D1wNQz3kmzSW?=
 =?iso-8859-1?Q?EiI8hw951jAMmQqN0Fr954DhLiK6jusJmB42eqoHioMfYsSrkAFjPutaRj?=
 =?iso-8859-1?Q?jWOBnBxJRqk8I6LK9TeOOSdqZ1LU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7EyJeqLddKv3hNp8ffhDoCdzNMNwVsbl7nTpPxxMxIsOjiEkopuTR3an3p?=
 =?iso-8859-1?Q?nfApOrOiNgjZYCl3ROzlH42zDSy1QWb372j0IlJpBm7xrl56XKrr7S9ik3?=
 =?iso-8859-1?Q?LF/p4XMusu2qP0Kg9/5LIzst3vHy9cp63r3e79pBJfLRwMdthnUUzhU8dj?=
 =?iso-8859-1?Q?leod9g1O5pcio1GaDQ4JZatZeuhDxrziZVqkwxjCKCE7f+HlADTfds1WN0?=
 =?iso-8859-1?Q?A0sYsJrq0l5QDIQBdFH75bTYv5w6mKBMQ85ss39tLXKulkbdqtacDk1wqm?=
 =?iso-8859-1?Q?eN6gbPUp6TuNH9t7XxsYL+oDKHyn0Zm+yIPHb9d1PZdu7Hf7AZr5vL3W6c?=
 =?iso-8859-1?Q?ROzlPid/mx228EBcl/8dh1uSvPmjnwWsKKRae6qf62mSoeovgh7BhuTHXM?=
 =?iso-8859-1?Q?cMKctDxVG7NCw8K1pXA6jrXd0Yg/9GlpJj+roSD+U1TBiqxKq8OXEg/FJ1?=
 =?iso-8859-1?Q?aA1UmQkYEF6n5pyl+Fqk/fdBmeLLMyBP4yhKDYoZm2eVEyYcT91NB/ZY1a?=
 =?iso-8859-1?Q?5drL166j3OsiQ2lg/zTXxqGdSVQQHXQ8C3Y5Ya2+mj94sjHVnV0wH4a6rn?=
 =?iso-8859-1?Q?BbQJc2S3sx5Eu0xFLANJc21ySPYmNVLdih5JPF4ZGkff+Hlx4IGdZfIuYU?=
 =?iso-8859-1?Q?K6KY54VjnvDfU31qZfKu3xvxnok7DF2mFtBaG7X3zKD0OY6KbFfQ8lKJ4l?=
 =?iso-8859-1?Q?nG/VHg7sFSne8zXEKxoWEhr/Ht3oNpELhkIC5bU8ksWYccFs+cOdAQfjPU?=
 =?iso-8859-1?Q?6x8OCHE9j2tfdHicOlG+qlgEWQPyH7XVJelgiAETJexW1vC/ngX52jOO/c?=
 =?iso-8859-1?Q?/i1NYS2Sbby/xTytixNBVk/Bl4ha3WHSICFbVxY+oyzYYQmKB3eAeT1ryr?=
 =?iso-8859-1?Q?aWE1jcalPaAoA+cf7qJU46pkhg2+njWM28ss/Ub/ZOeuUCrXPw2Bw5Oxvv?=
 =?iso-8859-1?Q?/RHcF0HId8dvwcRzsmGXQynbsTCqc1XeJLTm61xHYeXZmffC/g1UFllUrP?=
 =?iso-8859-1?Q?A2cSOtwMU1TTVTAObr/nWOSVoS5/uWUYlQKAwj21ZEizFV4rbj9gAG+qWd?=
 =?iso-8859-1?Q?dXuhthuUaS7OfbZ4RhDaUprJXCn9uZoqZc2SuYcSidf8xuPqqLfBSkRQh+?=
 =?iso-8859-1?Q?qE5p2tZksatRVDsR5MbtLjKaWnBHMjx8xPwcYCVDMtaWtGHT0X9Mrj4V15?=
 =?iso-8859-1?Q?knlEokof3EhOXXT1lfQgx/pcl5WA87neoXpPs7tD3t4hX3gc3nK0Jb48a3?=
 =?iso-8859-1?Q?g/UXlR7EMFEhiknMVRssfC/F1xdA0r7/0G060nCl74Kz81KZylUaOyv8/D?=
 =?iso-8859-1?Q?1Mc8FgaCTKjQjFiLDYdOR4ne8/NkUeHul0D9pSiUyoAjDKTdSa6vG/+wu/?=
 =?iso-8859-1?Q?cD/XJrIa6S44soq4FXNvfq/DGFJGmYOObAf4Ohy1Rm0lXDsQHIKfInm6bH?=
 =?iso-8859-1?Q?rxLXXVj1BObo5K6rjz9MI35g9NABGP2Lco37NkGnvc7YUtJx5cVE0pRH5k?=
 =?iso-8859-1?Q?HDHdnFoFr+KFPDgVPikFRWre9heEi70ZVuNVLA1qrW1xDVE521CR0MBODO?=
 =?iso-8859-1?Q?U4qi9D1Y4UvWMPZ/YAV7GlC/1W070YtTDR8e15oDPLgYrlsEBGciCDrbd4?=
 =?iso-8859-1?Q?8YqvaA8thXBm81Z88ea4F9EnCG+GSz0cJd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8075aa-00cb-488a-4b33-08de272e7f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 05:42:59.0981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbVTrRQSe7d9TbpzoVFYY3bhLSOEso69ZRApyeeSaABkxa1qzCUp7H8YDOh9Jm5edl2ON4BHhEyq7h5TYqtA6KPihynFgyQi9Ooq79pdRXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8919
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
> >>>>>>>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> >>>>>>>>> If the Guest provides a DMA address that is associated with a
> ram
> >>>>>>>>> device (such as a PCI device region and not its system memory),
> then
> >>>>>>>>> we can obtain the hva (host virtual address) by invoking
> >>>>>>>>> address_space_translate() followed by
> >>>> memory_region_get_ram_ptr().
> >>>>>>>>>
> >>>>>>>>> This is because the ram device's address space is not accessibl=
e
> to
> >>>>>>>>> virtio-gpu directly and hence dma_memory_map() cannot be
> used.
> >>>>>>>>> Therefore, we first need to identify the memory region
> associated
> >>>> with
> >>>>>>>>> the DMA address and figure out if it belongs to a ram device or
> not
> >>>>>>>>> and decide how to obtain the host address accordingly.
> >>>>>>>>>
> >>>>>>>>> Note that we take a reference on the memory region if it belong=
s
> to a
> >>>>>>>>> ram device but we would still call dma_memory_unmap() later
> (to
> >>>> unref
> >>>>>>>>> mr) regardless of how we obtained the hva.
> >>>>>>>>>
> >>>>>>>>> Cc: Marc-Andr=E9 Lureau<marcandre.lureau@redhat.com>
> >>>>>>>>> Cc: Alex Benn=E9e<alex.bennee@linaro.org>
> >>>>>>>>> Cc: Akihiko Odaki<odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>>>>>> Cc: Dmitry Osipenko<dmitry.osipenko@collabora.com>
> >>>>>>>>> Cc: Alex Williamson<alex.williamson@redhat.com>
> >>>>>>>>> Cc: C=E9dric Le Goater<clg@redhat.com>
> >>>>>>>>> Signed-off-by: Vivek Kasireddy<vivek.kasireddy@intel.com>
> >>>>>>>>> ---
> >>>>>>>>>       hw/display/virtio-gpu.c | 24 +++++++++++++++++++++---
> >>>>>>>>>       1 file changed, 21 insertions(+), 3 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index
> >>>>>>>>> 199b18c746..d352b5afd6 100644
> >>>>>>>>> --- a/hw/display/virtio-gpu.c
> >>>>>>>>> +++ b/hw/display/virtio-gpu.c
> >>>>>>>>> @@ -798,6 +798,26 @@ static void
> >>>>>> virtio_gpu_set_scanout_blob(VirtIOGPU
> >>>>>>>> *g,
> >>>>>>>>>                                     &fb, res, &ss.r, &cmd->erro=
r);
> >>>>>>>>>       }
> >>>>>>>>>
> >>>>>>>>> +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> >>>>>>>>> +                                       struct virtio_gpu_ctrl_=
command *cmd,
> >>>>>>>>> +                                       uint64_t a, hwaddr *len=
) {
> >>>>>>>>> +    MemoryRegion *mr =3D NULL;
> >>>>>>>>> +    hwaddr xlat;
> >>>>>>>>> +
> >>>>>>>>> +    mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as, a=
,
> >>>> &xlat,
> >>>>>> len,
> >>>>>>>>> +                                 DMA_DIRECTION_TO_DEVICE,
> >>>>>>>>> +                                 MEMTXATTRS_UNSPECIFIED);
> >>>>>>>>> +    if (memory_region_is_ram_device(mr)) {
> >>>>>>>>> +        memory_region_ref(mr);
> >>>>>>>>> +        return memory_region_get_ram_ptr(mr) + xlat;
> >>>>>>>>> +    }
> >>>>>>>>> +
> >>>>>>>>> +    return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
> >>>>>>>>> +                          DMA_DIRECTION_TO_DEVICE,
> >>>>>>>>> +                          MEMTXATTRS_UNSPECIFIED);
> >>>>>>>> This function should:
> >>>>>>>> - call memory_region_get_ram_ptr(mr)
> >>>>>>>>        if memory_region_is_ram(mr)
> >>>>>>>> - return NULL otherwise
> >>>>>>>>
> >>>>>>>> There are a few reasons. First, the documentation of
> >>>>>> dma_memory_map()
> >>>>>>>> tells to use it "only for reads OR writes - not for read-modify-=
write
> >>>>>>>> operations." It can be used for read-modify-write operations so
> >>>>>>>> dma_memory_map() should be avoided.
> >>>>>>> This patch series only deals with non-virgl use-cases where AFAIC=
S
> >>>>>> resources
> >>>>>>> are not written to on the Host.
> >>>>>>>
> >>>>>>>> Second, it ensures that the mapped pointer is writable.
> >>>>>>>> "[PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
> >>>>>> associated
> >>>>>>>> with VFIO devices" adds checks for memory_region_is_ram() and
> >>>>>>>> memory_region_is_ram_device() to virtio_gpu_init_dmabuf(), but
> the
> >>>>>> other
> >>>>>>>> callers also use the function to map writable pointers.
> >>>>>>> Unless I am missing something, I don't see where writable pointer=
s
> are
> >>>>>> used
> >>>>>>> in non-virgl use-cases?
> >>>>>> Rutabaga uses too, but you are right about that 2D operations won'=
t
> use
> >>>> it.
> >>>>>>
> >>>>>> That said, exposing non-writable memory to Virgl and Rutabaga lets
> the
> >>>>>> guest corrupt memory so should be avoided. On the other hand, it i=
s
> >>>>>> unlikely that rejecting non-writable memory will cause any problem=
.
> You
> >>>>>> can also add another code path to use
> >>>>>> memory_region_supports_direct_access() instead of
> >>>>>> memory_region_is_ram()
> >>>>>> for virtio-gpu for 2D and avoid calling memory_region_is_ram() in
> >>>>>> virtio_gpu_init_dmabuf() if you want to keep non-writable memory
> >>>> working.
> >>>>> AFAICS, virtio_gpu_init_dmabuf() is only called in non-virgl/non-
> rutabaga
> >>>> code.
> >>>>> And, this patch series and my use-case (GPU SRIOV) only needs to
> deal
> >>>> with
> >>>>> non-writeable memory because the rendering is already done by the
> >>>> Guest and
> >>>>> the Host only needs to display the Guest's FB.
> >>>>>
> >>>>> However, I see that virtio_gpu_create_mapping_iov() is used by
> >>>> virgl/rutabaga
> >>>>> code as well, so I am wondering how do things work right now given
> that
> >>>>> virtio_gpu_create_mapping_iov() always calls dma_memory_map()?
> >>>>> In other words, is there no problem currently with non-writeable
> memory
> >>>>> in virgl/rutabaga use-cases?
> >>>>
> >>>> The current code is problematic, and using memory_region_is_ram()
> will
> >>>> fix it.
> >>> Ok, I'll make the change.
> >>>
> >>>>
> >>>>>
> >>>>>>>> It also makes the check of memory_region_is_ram_device() and
> >>>>>>>> memory_region_is_ram() unnecessary for
> virtio_gpu_init_dmabuf(),
> >>>>>> reducing
> >>>>>>>> the overall complexity.
> >>>>>>> Since buffers reside completely in either ram or ram_device
> regions,
> >>>> using
> >>>>>> both
> >>>>>>> memory_region_is_ram_device() and memory_region_is_ram() to
> >> check
> >>>>>> where
> >>>>>>> they are located seems necessary and unavoidable.
> >>>>>> It can unconditionally call virtio_gpu_create_udmabuf(), and if th=
e
> >>>>>> function finds the memory is incompatible with udmabuf, it can cal=
l
> >>>>>> vfio_device_lookup() to tell if the memory belongs to VFIO or not.
> >>>>> Yeah, what you suggest is doable but seems a bit convoluted to have
> to
> >>>>> first call virtio_gpu_create_udmabuf() and if it fails then call VF=
IO
> related
> >>>>> functions.
> >>>>>
> >>>>> I think using memory_region_is_ram_device() and
> >>>> memory_region_is_ram()
> >>>>> to identify the right memory region and calling either
> >>>> virtio_gpu_create_udmabuf()
> >>>>> or vfio_create_dmabuf() is much more intuitive and readable.
> >>>>
> >>>> memory_region_is_ram_device() and memory_region_is_ram() are not
> >>>> sufficient to identify the right memory region.
> >>>> memory_region_is_ram_device() returns true for RAM device created
> by
> >>>> non-VFIO devices, and memory_region_is_ram() returns true for
> memory
> >>>> regions created with memory_region_init_ram_ptr(), which is not
> backed
> >>>> with memfd.
> >>> Right, but structuring the code in the following way would address yo=
ur
> >> concerns
> >>> and make it more robust:
> >>>           if (memory_region_is_ram_device(rb->mr) && (vdev =3D
> >> vfio_device_lookup(rb->mr))) {
> >>> 	vfio_create_dmabuf(vdev, res);
> >>>           } else if (memory_region_is_ram(rb->mr) &&
> >> virtio_gpu_have_udmabuf()) {
> >>> 	virtio_gpu_create_udmabuf(res);
> >>>           } else {
> >>> 	...
> >>>           }
> >>
> >> One of the concerns I raised is that having such checks has an inheren=
t
> >> hazard that they can be inconsistent with the actual implementations.
> >>
> >> The original checks had such inconsistency, and the updated one still
> >> have too. memory_region_is_ram(rb->mr) &&
> virtio_gpu_have_udmabuf()
> >> can
> >> be still true even for memory regions that do not have memfd; please
> >> refer to the example of memory_region_init_ram_ptr() I pointed out in
> >> the last email.
> >>
> >> Even if you somehow managed to write checks that match with the
> >> implementations, it is still possible that a future change can break i=
t.
> >> Letting the implementations check their prerequisite conditions
> >> completely prevents such an error by construction and makes the code
> >> more robust.
> > IIUC, your suggestion is to add a check for
> memory_region_supports_direct_access()
> > inside virtio_gpu_create_udmabuf() and call it unconditionally right?
>=20
> No, my suggestion is to remove it at all. Creating udmabuf only requires
> that the memory regions are backed with memfd.
If we unconditionally call virtio_gpu_create_udmabuf() for VFIO backed buff=
ers,
I think it makes sense to return early without having to iterate over all t=
he iov
entries to check their memory regions. So, I am thinking adding a
memory_region_supports_direct_access() or !memory_region_is_ram_device()
check would help with this.

Thanks,
Vivek=20

> memory_region_supports_direct_access() on the other hand tells if the
> host can access it directly by normal load and store instructions, which
> is irrelevant when creating udmabuf.
>=20
> > And, also move the (memory_region_is_ram_device(rb->mr) && (vdev =3D
> vfio_device_lookup(rb->mr)))
> > check inside vfio_create_dmabuf() right?
>=20
> Moving vdev =3D vfio_device_lookup(rb->mr) into vfio_create_dmabuf()
> sounds good to me.
> memory_region_is_ram_device(rb->mr) is again irrelevant; it tells if the
> memory region has a flag that prevents MMIO-incompatible operations, but
> we only care if it belongs to a VFIO device.
>=20
> Regards,
> Akihiko Odaki

