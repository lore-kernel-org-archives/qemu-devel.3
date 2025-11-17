Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB250CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 04:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKqdE-0005me-31; Sun, 16 Nov 2025 23:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vKqd5-0005lI-Dq
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 23:14:15 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vKqcz-00045b-UM
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 23:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763352850; x=1794888850;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pTvS2hkvUxUyxeWgmkYdVA8Wlw8+sJFIV0hddmRrsB8=;
 b=lLxEA82bWY/NHFLVM+wYy/39g4ta+d8dmlN9jdKsBPDPcklp5T4BjHzu
 bjo0N3g7kCEEyh91w+YCixzk424R6kIMueNfSlpoDe3eqoa+//FfU+eBp
 omZ2tEmbspU8CdR1mWASnMOuTsFkOO674lZ5TBeIJZ5DKauhPeu/C40mp
 p6ZePK15MK9Aw0gF37tAiSyX8W0nWB3JzwoflDPCGni1i0zojoD21wWtr
 RDH9CxBrOUvHmyTPAWnUrEbk16TSww7LiyFakHu7wB9pCAZuNH6P+6ijB
 UGNVytzNm5l8bKKY+neqalUXavNGiSlxGHNCzX/2uoPmz+YpkNqjKdHv8 g==;
X-CSE-ConnectionGUID: 2NB3MoeISSGQIgMILQrl6A==
X-CSE-MsgGUID: eN8suGMFTUWkd3jXQ7CHFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76448024"
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; d="scan'208";a="76448024"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2025 20:14:04 -0800
X-CSE-ConnectionGUID: PsoaXjtTQHS3giw6NFVF6A==
X-CSE-MsgGUID: oaAWqFnGTl+CYjCiJV4Oow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; d="scan'208";a="227674196"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2025 20:14:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 20:14:03 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 20:14:03 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 20:14:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8UqUsppJ1E/wsjYOEHPjbqUVi1svQPpoJGvr/h7YFlv/2xZj6H42te67EkPUofcxc/+0lin/P1CWGlBhcxGzrpHy5eqak4dUr7AR5NWDaxNNY6tOMVLtwhMtLWjf1ZiO33+xpu0O+3qk22phNt+itV2w8Y0swhG8715pOErb2wlEfnBnbcQx4NGft2+gS2BhcqKjFBsVNH1aQacZfe+NqpzSr71RabdbYvfYJqFqKyEzAve6DdBqpv8/ylQSo2o2/zYzpgehOARUGJj2eA4GZgWPfUnc5Op+VUsPzYZ76C91dn9GeP+H0Qmu1Jeez5fT8pcrISjzCkLf3rGM/4QZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olZuSGMLmEGrHMP28xDpxppZxRIJ8BlWGaDFL5Tt1HE=;
 b=gxTuCk5qnlLbsuRVS+CAwfI8JVq1HrM8RTXLN6rWGGQEzBOsAgNhL7nWvVjWOLor0l5r8bPEyBihUyzR7/DiUakjXsAS5EvPz4krKHbCpUNOU5e10iCm0JZLB3F7Yp91GeREv2AQqPO2pZS6X7+NT0SNp2gKdFqIZI2k6900R3hM5eGknKQJPfPRnP9eqcPO6Cjx6OCcJsIPkZ3ezEVACEf0jqpwcSuLb+tEffIKHKizAlrszxFLDBX3QDGDsFCiW1I3tq6beuZA/sVPM9tEXxFFkrrn7UxHew33uYyj3jOb+L842BBFQ5AKfDq7gbmPdR902KE3XzmfY7+qDpOhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS4PPF6915D992B.namprd11.prod.outlook.com (2603:10b6:f:fc02::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 04:14:01 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 04:14:01 +0000
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
Thread-Index: AQHcUTsfaCBAQNqK6UqI5jTHJ6PIg7Ts6XoAgAE6QFCAAJJ2gIAA3p9AgABvJgCAAROboA==
Date: Mon, 17 Nov 2025 04:14:00 +0000
Message-ID: <IA0PR11MB71852A2F1894A75CE0B7EB13F8C9A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-3-vivek.kasireddy@intel.com>
 <ea2e1bd7-d681-4929-b902-1948b854e488@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185866AD30B9A73097934CCF8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8b8e3b19-7696-4b7c-8d74-eab2028dcd02@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71857687EC63A9A8D46476C7F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <e9424a92-f612-4cce-abc1-5336949ca71b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <e9424a92-f612-4cce-abc1-5336949ca71b@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS4PPF6915D992B:EE_
x-ms-office365-filtering-correlation-id: 3b6060be-e903-4ec8-5aac-08de258fbcba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?enMhKBqUVB9IIZvzGT1fdhFl8viirwzKas0e8Oktl/4b6Utj3WQBaIe4hY?=
 =?iso-8859-1?Q?aGP6m2RUElOqQMwcw9pmvtIZFsuUqjQmhVCzt3ZjMjEhPOuVgTrSX3KgfN?=
 =?iso-8859-1?Q?DRsoXOWmdefEilvgskSBme0iF3f9H2kKBEPvTq5nMdJlgvLPT4dg2pXDhU?=
 =?iso-8859-1?Q?q4QtxQAkUTYVV8dI67XfvIbWPkAbAqezbgSU0ATq4ZD7JBr+JMbTCO2RDn?=
 =?iso-8859-1?Q?5nj3b/E43CqPQo3aTvkKWFaGtzK0i/mjXQjMO4ohtQmr34S0lbcEIdVJTP?=
 =?iso-8859-1?Q?KubLQEjqvcHAwXBaNLJkPqQYfBK6ojpJa1EnkPHGNyTZStF/sdRcE2E2Ch?=
 =?iso-8859-1?Q?Q2U3JVDTHWJDWPvD7ZD6LcSKl/9F4y+BuOqlKFn4RiB7dfWywNROpgueA1?=
 =?iso-8859-1?Q?VSn/ufcR+/3lpWVHC8+7r4tZ3EJnn1XIOefC6A+3a+8txxclNPlThqLUXf?=
 =?iso-8859-1?Q?AVNJ1u+pcZUAyrWFRVB6QtfOLpsxeMVC9+lDanIEyT9jQUs4PhwjBrAKGy?=
 =?iso-8859-1?Q?HQEyag6qRgSFGspK5WKaADurpeeiy3Zyv+bk7/iVhXLgkiMJpBtRZeLjYG?=
 =?iso-8859-1?Q?XZNj//vhO8acR2B19Ie6WftjNQ4etiWyvvnUVjB7izFBMg/BDwjos7lkmb?=
 =?iso-8859-1?Q?YLdTu7l8HKPv/CQ7qj4TACKKRU3npCJQqSpjiuQxi/CIlUczWfqd/XKJOM?=
 =?iso-8859-1?Q?nuKWN74+Jv35kZCY/0oczngiqXA3xlQ2Q88t8d1kdLLolhWh41Puy65zEp?=
 =?iso-8859-1?Q?yg17UrVQF3XDXolamY0a2Zvkbv1aJiA34V6Qpk8ZUBkKzibjbUjQtseAIy?=
 =?iso-8859-1?Q?iG0EojSzaJt0jTgTTAnU5N/dqYSGahBQPLfG/edmTLdM/+oKw8OqLa6TWw?=
 =?iso-8859-1?Q?joITl8dK7lssMcKI4ERrxDCxpuJpSpM+TRj2IG5TsE0WRv74o8DDcWwPQB?=
 =?iso-8859-1?Q?HQqCzZicGEnIEj7faXqMsi9EbKRnMJlJSV4V+W4OzD48HZXVlfOlhyq1iP?=
 =?iso-8859-1?Q?8yJ9XCuuByHiUYuabFQq8zEw4KhHvT8ETrbpkgO1ce+YCxT5SrmkLCxpMb?=
 =?iso-8859-1?Q?ksYDW5h7Cltjjcc8orqQkWxRtvSKo6PvA4PXya0lh8/LSpTIaLRtdON069?=
 =?iso-8859-1?Q?mJIoenB9SfrQGlPffxoBhOL+QsIwJui8lOILtMQmgFiQmJcF1ZFgge4Y6j?=
 =?iso-8859-1?Q?RPkHC566xKMGk/IbLX597LsHeJZI64i93WP86DB6Wocoilxknrkq+PQQYN?=
 =?iso-8859-1?Q?p8igPis7DYirZT5OogTah6z+UtgzIgn8FGD0EU/JXJwrsvZDvyvBtFVnjK?=
 =?iso-8859-1?Q?UjxZRwA9J/4UD0D5hSCZX8JYX75pmoPjyKzgh0imIrKI7ZHMrwsto5I1/Z?=
 =?iso-8859-1?Q?vCBnaPNMczyK/Py8jupAb5uMs8kpMwHWAP6E8b1cN5sibBAJCgaXg/shNZ?=
 =?iso-8859-1?Q?TMnWr5sfBe3hshuRIY2LABD/e9tUmEsssgU142Up6RXxmJrappsp49+4br?=
 =?iso-8859-1?Q?2bMZhdjyJ+VK8b9vZXJI9e3NKLzcejfjKHyOHjfhym9Jbuu/lj315wpx5V?=
 =?iso-8859-1?Q?LN4A83jcEzGhkLPzT/b/6fdNpNq7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xnaRlJYCiKyfzxQI8xvxolC1YoYjv0pQzsuEVallokWNvcwhsP5ph8qPn4?=
 =?iso-8859-1?Q?lg+5vrBspaz8iAJz9urncJOUMalRmG5LANeXZOGD51C7tzfT4bAgYKubGP?=
 =?iso-8859-1?Q?WtW2VNg+/IRsqox+26lNij796+XeDWzbf5RptRD0d9ukYhZgU+BG1apoT3?=
 =?iso-8859-1?Q?1oXUjiNalObSzbw1UBBs23gUz8/9L2AC/m6saNQeirJeb0J2uxxCAMXIWw?=
 =?iso-8859-1?Q?jk+Of4aIY7j/35a6Nbqg5mmyVbkw1GxXir+N6v5akMn5/9y91Zx9KvaEPn?=
 =?iso-8859-1?Q?8vER5wBkNEMcJaTdgY9mfq5u0pGZnD36ob+Qr8SFAYUpqcJFwA8+n+YGKh?=
 =?iso-8859-1?Q?mrf9HuOgXxAuvenbdMOEOuek6Y19+JUa+0oYvrtRWoipiYk0THOFvC1Apy?=
 =?iso-8859-1?Q?70wa7SrWu9fU9N15VKXGzpQawhliHKYixPsW3rHHlatoOkOn2mdIbL+P0j?=
 =?iso-8859-1?Q?4oFSwi+w3MVMVXTdUtqWixhSFlcMxNcZ4jSYPs2hjbJ39CQN1g7wCOVa+X?=
 =?iso-8859-1?Q?yhqGrALkRF+xyutFwIKHMrx63THFrwW1mxoVLVs9WQ2wjQ7q1thpcIwRY3?=
 =?iso-8859-1?Q?CTjZuM74TAW18srInTDFAqzT0KncAs5xqSEfy0okSfkCC57M3D6oncv460?=
 =?iso-8859-1?Q?iFNQNCgUQAp2xY+SIs62NOCpmofgJAe0NOnZBlJ5KsiJvipLE5412Ns80u?=
 =?iso-8859-1?Q?XjtUmukFVZ1m0J4k+Iv2PJCbDtISO2IVA5ttpzYwrwldfRkAsjcoaXfbm8?=
 =?iso-8859-1?Q?9aZay7ySr+2ZONkagBmdPdElpvMMTGVjzUghC1qz3Kog6MeO2lx0V2slV7?=
 =?iso-8859-1?Q?Oz+JqDnibeI5cgT11zlJMOIPouHdeBk6aPtOJUImMpYRWKJJ143xIX+dgI?=
 =?iso-8859-1?Q?EkJGa5Y8Wl1atnVYxZ5ykFraQx/796W5knHflnbiSSfH0M21P6rIC/3w6r?=
 =?iso-8859-1?Q?Jr9ZaDeoOTCSFQSBECKE8MUDbEVL50rboRZrlz4OzZL9ZeDtW3cyaDRpTK?=
 =?iso-8859-1?Q?J5OXWJ1vY2elRPMFKW9vsDh72M8EDvIboWdibR8uRGJPJDpJarZ0LLYALr?=
 =?iso-8859-1?Q?qHvCTnbZNs6Y2ze5oMvQOuVIimAHKJryBewiqIBRpkERWfqOiFQTpLzzg7?=
 =?iso-8859-1?Q?7u0Y1uuckNJ/q0lm/QeR8toIYkHnrg0nMf+F76F/CKim6KP5omG+Fk76V4?=
 =?iso-8859-1?Q?8lO2KYxIMSIjFibcTABhHiZnIPsWdl/4DAJEmQmq9E9/Li3SNrr7Xl/pPK?=
 =?iso-8859-1?Q?RmBmu0P78Ff7cHpElsQuqSh+uzMeDxR+gANKqDvqhP7OTRNjXkSwPGWMhr?=
 =?iso-8859-1?Q?xoWTBEt+y9gjWQIO1CGCvCFxR0VZyAj3Dc3+GbjHMxui+oHiD3LR9n/GJr?=
 =?iso-8859-1?Q?xP9HrD3bPmXNZyiGRs77nM8QZT84Vzxavu3pcOLuuKVfHVD5c1XySCE8zu?=
 =?iso-8859-1?Q?MPlEaEENiPgjqfWsHZtVAfSTj00lIa2e+ynZbZaoFEaPUf4UmKWEf4uIRQ?=
 =?iso-8859-1?Q?Wfk95IvFPG5GrDDIlCifir2dnJzhF3tp4CDyDygHThg7hB2ZyJ8HNk/vHn?=
 =?iso-8859-1?Q?37At6TCm4nfcH6wMX3XskrG/vTda78NrxgV7ESzePL6uGuXa2TqVNtDjgX?=
 =?iso-8859-1?Q?j2379oPU0A1miRnWa1aKUv3xjbTDZg3t0k?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6060be-e903-4ec8-5aac-08de258fbcba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 04:14:00.9942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snqvtQg5Pq7Vt5U3wrAbEK63dJyvTfl7j02ORsxx7uIgJz5LUWYP0/XrThEUUvyT4p4XbcoGSpoPUkb7NdVtJS9jRvKU/YAE+QSJ3e2YQwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6915D992B
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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
>=20
>=20
> On 2025/11/13 12:39, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA add=
r
> >> associated with a ram device
> >>
> >> On 2025/11/12 13:30, Kasireddy, Vivek wrote:
> >>> Hi Akihiko,
> >>>
> >>>> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA
> addr
> >>>> associated with a ram device
> >>>>
> >>>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> >>>>> If the Guest provides a DMA address that is associated with a ram
> >>>>> device (such as a PCI device region and not its system memory), the=
n
> >>>>> we can obtain the hva (host virtual address) by invoking
> >>>>> address_space_translate() followed by
> memory_region_get_ram_ptr().
> >>>>>
> >>>>> This is because the ram device's address space is not accessible to
> >>>>> virtio-gpu directly and hence dma_memory_map() cannot be used.
> >>>>> Therefore, we first need to identify the memory region associated
> with
> >>>>> the DMA address and figure out if it belongs to a ram device or not
> >>>>> and decide how to obtain the host address accordingly.
> >>>>>
> >>>>> Note that we take a reference on the memory region if it belongs to=
 a
> >>>>> ram device but we would still call dma_memory_unmap() later (to
> unref
> >>>>> mr) regardless of how we obtained the hva.
> >>>>>
> >>>>> Cc: Marc-Andr=E9 Lureau<marcandre.lureau@redhat.com>
> >>>>> Cc: Alex Benn=E9e<alex.bennee@linaro.org>
> >>>>> Cc: Akihiko Odaki<odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>> Cc: Dmitry Osipenko<dmitry.osipenko@collabora.com>
> >>>>> Cc: Alex Williamson<alex.williamson@redhat.com>
> >>>>> Cc: C=E9dric Le Goater<clg@redhat.com>
> >>>>> Signed-off-by: Vivek Kasireddy<vivek.kasireddy@intel.com>
> >>>>> ---
> >>>>>     hw/display/virtio-gpu.c | 24 +++++++++++++++++++++---
> >>>>>     1 file changed, 21 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c inde=
x
> >>>>> 199b18c746..d352b5afd6 100644
> >>>>> --- a/hw/display/virtio-gpu.c
> >>>>> +++ b/hw/display/virtio-gpu.c
> >>>>> @@ -798,6 +798,26 @@ static void
> >> virtio_gpu_set_scanout_blob(VirtIOGPU
> >>>> *g,
> >>>>>                                   &fb, res, &ss.r, &cmd->error);
> >>>>>     }
> >>>>>
> >>>>> +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> >>>>> +                                       struct virtio_gpu_ctrl_comm=
and *cmd,
> >>>>> +                                       uint64_t a, hwaddr *len) {
> >>>>> +    MemoryRegion *mr =3D NULL;
> >>>>> +    hwaddr xlat;
> >>>>> +
> >>>>> +    mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as, a,
> &xlat,
> >> len,
> >>>>> +                                 DMA_DIRECTION_TO_DEVICE,
> >>>>> +                                 MEMTXATTRS_UNSPECIFIED);
> >>>>> +    if (memory_region_is_ram_device(mr)) {
> >>>>> +        memory_region_ref(mr);
> >>>>> +        return memory_region_get_ram_ptr(mr) + xlat;
> >>>>> +    }
> >>>>> +
> >>>>> +    return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
> >>>>> +                          DMA_DIRECTION_TO_DEVICE,
> >>>>> +                          MEMTXATTRS_UNSPECIFIED);
> >>>> This function should:
> >>>> - call memory_region_get_ram_ptr(mr)
> >>>>      if memory_region_is_ram(mr)
> >>>> - return NULL otherwise
> >>>>
> >>>> There are a few reasons. First, the documentation of
> >> dma_memory_map()
> >>>> tells to use it "only for reads OR writes - not for read-modify-writ=
e
> >>>> operations." It can be used for read-modify-write operations so
> >>>> dma_memory_map() should be avoided.
> >>> This patch series only deals with non-virgl use-cases where AFAICS
> >> resources
> >>> are not written to on the Host.
> >>>
> >>>> Second, it ensures that the mapped pointer is writable.
> >>>> "[PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
> >> associated
> >>>> with VFIO devices" adds checks for memory_region_is_ram() and
> >>>> memory_region_is_ram_device() to virtio_gpu_init_dmabuf(), but the
> >> other
> >>>> callers also use the function to map writable pointers.
> >>> Unless I am missing something, I don't see where writable pointers ar=
e
> >> used
> >>> in non-virgl use-cases?
> >> Rutabaga uses too, but you are right about that 2D operations won't us=
e
> it.
> >>
> >> That said, exposing non-writable memory to Virgl and Rutabaga lets the
> >> guest corrupt memory so should be avoided. On the other hand, it is
> >> unlikely that rejecting non-writable memory will cause any problem. Yo=
u
> >> can also add another code path to use
> >> memory_region_supports_direct_access() instead of
> >> memory_region_is_ram()
> >> for virtio-gpu for 2D and avoid calling memory_region_is_ram() in
> >> virtio_gpu_init_dmabuf() if you want to keep non-writable memory
> working.
> > AFAICS, virtio_gpu_init_dmabuf() is only called in non-virgl/non-rutaba=
ga
> code.
> > And, this patch series and my use-case (GPU SRIOV) only needs to deal
> with
> > non-writeable memory because the rendering is already done by the
> Guest and
> > the Host only needs to display the Guest's FB.
> >
> > However, I see that virtio_gpu_create_mapping_iov() is used by
> virgl/rutabaga
> > code as well, so I am wondering how do things work right now given that
> > virtio_gpu_create_mapping_iov() always calls dma_memory_map()?
> > In other words, is there no problem currently with non-writeable memory
> > in virgl/rutabaga use-cases?
>=20
> The current code is problematic, and using memory_region_is_ram() will
> fix it.
Ok, I'll make the change.

>=20
> >
> >>>> It also makes the check of memory_region_is_ram_device() and
> >>>> memory_region_is_ram() unnecessary for virtio_gpu_init_dmabuf(),
> >> reducing
> >>>> the overall complexity.
> >>> Since buffers reside completely in either ram or ram_device regions,
> using
> >> both
> >>> memory_region_is_ram_device() and memory_region_is_ram() to check
> >> where
> >>> they are located seems necessary and unavoidable.
> >> It can unconditionally call virtio_gpu_create_udmabuf(), and if the
> >> function finds the memory is incompatible with udmabuf, it can call
> >> vfio_device_lookup() to tell if the memory belongs to VFIO or not.
> > Yeah, what you suggest is doable but seems a bit convoluted to have to
> > first call virtio_gpu_create_udmabuf() and if it fails then call VFIO r=
elated
> > functions.
> >
> > I think using memory_region_is_ram_device() and
> memory_region_is_ram()
> > to identify the right memory region and calling either
> virtio_gpu_create_udmabuf()
> > or vfio_create_dmabuf() is much more intuitive and readable.
>=20
> memory_region_is_ram_device() and memory_region_is_ram() are not
> sufficient to identify the right memory region.
> memory_region_is_ram_device() returns true for RAM device created by
> non-VFIO devices, and memory_region_is_ram() returns true for memory
> regions created with memory_region_init_ram_ptr(), which is not backed
> with memfd.
Right, but structuring the code in the following way would address your con=
cerns
and make it more robust:
        if (memory_region_is_ram_device(rb->mr) && (vdev =3D vfio_device_lo=
okup(rb->mr))) {
	vfio_create_dmabuf(vdev, res);
        } else if (memory_region_is_ram(rb->mr) && virtio_gpu_have_udmabuf(=
)) {
	virtio_gpu_create_udmabuf(res);
        } else {
	...
        }

Thanks,
Vivek

>=20
> In general, checking prerequisite conditions before performing
> operations implemented elsewhere is dangerous because the checks and
> the
> operation implementation can be diverged, and these facts demonstrate
> that.
>=20
> Regards,
> Akihiko Odaki

