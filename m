Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5670CCA0EFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 18:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk61O-0006lp-H1; Fri, 30 Aug 2024 14:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.d.kinney@intel.com>)
 id 1sk61N-0006hC-2q
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:06:53 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.d.kinney@intel.com>)
 id 1sk61J-0006cj-IG
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725041210; x=1756577210;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PICHoW20jR4nvovIHtGdaX9xYVyEdSuDQ892VTB4kZ8=;
 b=OCHcWnRrnK2DAqbsFDFvgnj3nqGmHroJ4BvmLJOW2O3WzkTCzqOBlgRj
 tW+pfBFNBma62NGl5u33/XY1w3A3/A+98pH3O1QZvtW3yjCWW2neUiflb
 cZZKOT7lQwRDWjS+1u/8QmZn7ZaDuQHNJ5qjrRiJdGjCrA27C1CJVQMQa
 Vqie6foJePgVm+Q8ZesBLNurR8y5m+m/JoKwmXZH7dd+yU+ihT3nzwhfQ
 qUEAh4F0bnLKYkPDJV4wpdCUt1Ox9FgWFYO7dO8tiMcvfpNOh2y7EXwBw
 6FxOORKMbbimCKf5eV1fS95dJuPSy0kYYF4rmuT2a6l7YAxEUvzFAljsH w==;
X-CSE-ConnectionGUID: M0/BNb5eThKarXn4WgmHLg==
X-CSE-MsgGUID: 2mPDzITwTzmev9ZvyJnsrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="27458405"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; d="scan'208";a="27458405"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2024 11:06:44 -0700
X-CSE-ConnectionGUID: XESAhiDZTWOrU3MF7ahd2Q==
X-CSE-MsgGUID: iBdiA0APQx6f+VPsaKuWoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; d="scan'208";a="94780075"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Aug 2024 11:06:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 11:06:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 11:06:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 11:06:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 11:06:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U96WzgCVI86aXkl8rYK+GT0IMWCRY2Dx6OJipf02CYt3H34CiS1xWwto230hwV5XjLLfUaz5YvgRcKbXaYm89fKrIX+D0PWgUw4vrfsbLp22NRS1H5s+2OOcq3VoGjCtoVV2v8p5VUBWCs4a2AYQF1CCopeY8BXmVCgBcyQhNdpivnjNOzy66QbbCWKOrktqRnWyqgUirwaJkWnVNSN8JOwAc4HpjDRDX3wRYW7WPlNRgMqzpD+SsWfW8D8YRiR01Sn/QGUgFHlQ/ODMaiGYJmrGjOhqQhjsTDejEZJGnyYsItJY+hTYsgfoacT61ok4Ii2Q1GhkOh2Eij43BG8bYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3KHwB1pP/8pftoZkqAbv5+/WtMlm3EdL/uqLWPzNu0=;
 b=BgMownY3X/ehH86BY+juN3Uf848up4fxjouzvSI/+JAMxjvGlVynbKqwUdyqrlRApSbj2tZZnWXgIY3FiYpjFMWrIKdgeaGmUCUC0btQbiILTfracdfKmjoWzJPCWoF1tdpu8x/RblOyeA4S/RmEl9M+wXkFPPGpK09J/1X/nLsXXl6Mq9wC6ka0QhMm6YPSa8Xu29c3UTJ2s6u9nCBqIx/UR4iGghiNCNr4qN3cE2SbEbZRScpYMUgCcTLe1G6dCmfZEM5iJrVaiELOmdswbq170Wlpee/ciQbbyW/yjLOBqEmDT7Fb52i6gxVnRQ+eZPYETJ/WB/Pjv1ePGYbbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19)
 by DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:06:34 +0000
Received: from CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::a886:6510:729d:f9d0]) by CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::a886:6510:729d:f9d0%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:06:34 +0000
From: "Kinney, Michael D" <michael.d.kinney@intel.com>
To: "devel@edk2.groups.io" <devel@edk2.groups.io>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>
CC: "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
 "gaoliming@byosoft.com.cn" <gaoliming@byosoft.com.cn>,
 "ardb+tianocore@kernel.org" <ardb+tianocore@kernel.org>,
 "chenbaozi@phytium.com.cn" <chenbaozi@phytium.com.cn>,
 "wangyinfeng@phytium.com.cn" <wangyinfeng@phytium.com.cn>,
 "shuyiqi@phytium.com.cn" <shuyiqi@phytium.com.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Kinney, Michael D" <michael.d.kinney@intel.com>
Subject: RE: [edk2-devel] [RFC PATCH 1/1] MdePkg/IndustryStandard: add
 definitions for ACPI 6.4 CEDT
Thread-Topic: [edk2-devel] [RFC PATCH 1/1] MdePkg/IndustryStandard: add
 definitions for ACPI 6.4 CEDT
Thread-Index: AQHa+oH4NXtM1oKKn0a6oV85YWa4T7I/py8AgABvHGA=
Date: Fri, 30 Aug 2024 18:06:34 +0000
Message-ID: <CO1PR11MB49291F248F08F89124086C8AD2972@CO1PR11MB4929.namprd11.prod.outlook.com>
References: <20240830021117.538954-1-wangyuquan1236@phytium.com.cn>
 <20240830021117.538954-2-wangyuquan1236@phytium.com.cn>
 <20240830121646.0000729a@Huawei.com>
In-Reply-To: <20240830121646.0000729a@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4929:EE_|DS0PR11MB6373:EE_
x-ms-office365-filtering-correlation-id: e31f0d7a-a23a-4f98-009d-08dcc91e7ba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|4022899009|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KnRjiA0eCqNX+0hNntEi2FbVjXEw/yGjU7NXDUFIYNz3+CgR4+/d6zX/8lWg?=
 =?us-ascii?Q?5iB7W72cnVsOjgw27BmqNmS383pPdth4lEe2OcgfeH76FtCG++4p2nkG/fcE?=
 =?us-ascii?Q?M/AOnUiMWTsbmuRlIjjohQlj80PFjseaC4lqY3cN/qF6u5orZl1xEkQgYBC5?=
 =?us-ascii?Q?u9A/2sWnB/HD/QtO2ja4WusKTeBkJu/kXz5BG1v3SmzDXNQt2UxfxMvzS9LF?=
 =?us-ascii?Q?DIesYyEaUbf13Ylti+G7XbmNAlxaGoauMGd/zGZEIFNyBhXu/abOnxuZveEA?=
 =?us-ascii?Q?4esx/GHaUBJ6UvksoAMKQ6tSANF+2wUUPi5QZiNMcib6EZvOUCYLC3vu/jdk?=
 =?us-ascii?Q?uWcGXY8tXYkzh3ThjYKI1nr8O9llT1MxDY7J1hIAKQos46QFCs9InkbeRTLF?=
 =?us-ascii?Q?P53t/BElrh46bS/v/PdoMbWtAH8vRDphMhriEuFjpQhziY7FOqigItR0j40e?=
 =?us-ascii?Q?4IDTc/Ko3f1F7QoVeVo9Rhy/IfRVh65W5raHvm4qdtQ6SfPFmEjQYTw374GZ?=
 =?us-ascii?Q?ElkjPYCqy+psZF2M7imNTT918YKwswDMp8tukQWINT5EccY6IWluZyn7z5w+?=
 =?us-ascii?Q?Ml9xJ/D84Bd8XRv74tSQIpxVK1iJWuhfMm/SyFjLFs4QUcE4XzG6b4Hte3Ig?=
 =?us-ascii?Q?IsMPc4MrOfiPdNCUvt1y4EvpQF5rWS7q/qZqINV7upR5MKaLucecmVtuw3mk?=
 =?us-ascii?Q?li1xoRn1RB4qv2urPVdhiS4qEfq9/pBqK5BrDJj14U2y/09R4lY5k5Nmjl52?=
 =?us-ascii?Q?3nHGNgDCO7uU0RfSuUeYJvcSwSpPA9EPoFz7Jq5dObUWKyRr6YDj94f/O+qm?=
 =?us-ascii?Q?IJdSgPsCSiDLWYgy+NOoeTKTXBMGTNsV5oosnhTm9d3Dcw3oF2qKGwsOira0?=
 =?us-ascii?Q?Ppv+s999HHS/3QqWd0zCir/XxmKGRH1oenazNVXPFPgLgVedXejY0vvgsF0/?=
 =?us-ascii?Q?0xCHjMEmKWNKCWdHrrRqvvk1hp7FC7VOqH0S4cBlTKj+GeiJLyCdaHQX7Yuv?=
 =?us-ascii?Q?OkXaZdsW3VP60RCCdVu9VZWnz/njlL5OkNOI9XPWAZex0Xm/+P7rfWrx5wNY?=
 =?us-ascii?Q?C8AabpyQC3r9f7ByTkSfcoMFgsqddxgnDW1zznTy0fgEKufDcED2Ij8ohVjo?=
 =?us-ascii?Q?7xjxILSKdwntYMh01EfyENp0QByfaGxoJg85n+uDIklMnFiYcRsN4RxElKRp?=
 =?us-ascii?Q?JPxjUUqGUmjHuRN3f0InsuN6u8bEPHc09p8V7IdglZmIb5WhRuEIx4ycNaE8?=
 =?us-ascii?Q?ABqX+nsdZdCN/rhxsFkuvdR9kaHXfvAmi8yNfXXZo5AKrBXFPHGCQwDOveHY?=
 =?us-ascii?Q?Uh5ZsIYQoK1wHHI7CWSePaHXyr6qS/EEvYQzG6F+abxNAFi9/UNvh/SQFiDF?=
 =?us-ascii?Q?TC3PvW8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4929.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(4022899009)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J6DCGp8ZjGvXkAi0P6dUnKJGTXy0s2PEHrEuDqzeDPwsPGEgK7smCIytCXt8?=
 =?us-ascii?Q?4aFqaT08aE427Ge1BPp0XhzRc7aC3/iqmQkjyDH3cf+mDUkNef5dm8w+c0p6?=
 =?us-ascii?Q?4ydKgtOKGWa6uI0iOQHreByYWfCA1qoNVnxS4mQW/+A6BE4Sk5SYmsGR6nhW?=
 =?us-ascii?Q?vTENrkfVN+Y8Sq9RZtkwL1+Oa9dpThdfkFeXCMQXIYBHi5fmd2yHIeFPtCoW?=
 =?us-ascii?Q?vJ5Q1OHAfiYVJD+1BWSyASqYrOyEVt0vaJSXFN4d/pANIfasGId3x8wphyMu?=
 =?us-ascii?Q?vwW8QxJnh/s3JzKfNtVt17z3N04Rk9VC3+BTyD9t6GxGmZ4y6ESv+swFNQcF?=
 =?us-ascii?Q?7LAl784rOPprhe/S5GfSoxK6bp4ejDqtiQP5YOm6d6JBjfJhbWr1LtK1wNfF?=
 =?us-ascii?Q?YccUAinoOfQOknC9pRRKG+2lU4kc+F3YuTEHWGWP5lnA9rDBPLDz1LsT4P0f?=
 =?us-ascii?Q?di9hxg2r17aHPBLhXNmIjwdpjjzOYSy2zZlO1k+FtnvIHFvGWhufPd9Wa8gS?=
 =?us-ascii?Q?O2FNQ3eaIp5iW0HyCfqe7bAm7YAe4sAKgh7jERufopCV01mjHA2BGfQkseRY?=
 =?us-ascii?Q?TQ5ID9fDfAJIlRYWkFevTI3nQWaG+/zLBj556XYK/eeQDR8hMFEtOQHrW60M?=
 =?us-ascii?Q?2icoscbhRi8mdm7ZYaP4rYCOq2E2P0UEdjvOO1dR5+4CJFfvD4Fa6WcUj7RF?=
 =?us-ascii?Q?xpqyhManHqQaCQ1tvJ9BIL5EMwSI0t/dtRxIMzEnjAhtujnyfBNav9MUbPPx?=
 =?us-ascii?Q?RVvj3/hGInXPE4Pku2yDZb8L7RxzXxDNgYJOTpPiWLhBYyzNR82ic+90pTLU?=
 =?us-ascii?Q?4jJ34qiW1OvnL9XF2pbZ5g5HuuaoMOzOytbs/DJeNGcpiPnOgNeLSDA20YTn?=
 =?us-ascii?Q?lfonvbE38mEt6/+RKEKO/wPve/l3+seGRBh6yc9hg4Tq8Q0CjEAx3QPam/u+?=
 =?us-ascii?Q?O1FWlfu6iB6sFAAoGvH4ZnlRk5L2D26FnvsIMey6wpzWw2n9kB6sa0QlDbOo?=
 =?us-ascii?Q?JjYlWicngCFc7WX9Q6o9L7v9vdwC62Sx5HFTXwQwmqjrFuIBgtYS7vq0zYeM?=
 =?us-ascii?Q?VCZD1iYPl9F2VY+XfgF08QHB5vCtUDhCnpdxNywj3pQc3lIt0wsE9QENpZdN?=
 =?us-ascii?Q?kwHegs81m2qAKwB2MPhlKD3O3iJccRwMMxbZlAtpvpNRgcPwSzSwpPnohwut?=
 =?us-ascii?Q?sLg9j//pMwVR/2CAZEV5MnGXtVfSec0SVUCGcvzjp6SuNjdHYRAYUb511XqS?=
 =?us-ascii?Q?oUFLUb5eKMAmmRIomqCvQzozy3Bhuo5pPOaGvZtPswRsnGzrMPxEeKiyUtr0?=
 =?us-ascii?Q?c0FVuKOqGucQZD1W/XR+/J8nIGCD9ZjrrOevqz34AB3p0jbqpXGVpuvcvZzg?=
 =?us-ascii?Q?CksjbUzKk13Jdezvizspdk+/xZluKi+Ulz6Ew4CxFQurNWoLdb6E5VqzdlsY?=
 =?us-ascii?Q?MJLg6uUQut/YzGH1435gjZCZNX0Z/Mom+yRy8urmfxBhwz3TaVj/SKjUN1gJ?=
 =?us-ascii?Q?WkIutYmfLxQwBaP+CRgcU0dooA0Ird68f4RdmXXBd0X/+5Xb8GH/pVyXA1Ib?=
 =?us-ascii?Q?wCD29s0gH0B63yfQHO0/HTDFU0NOHkU4dAqWAe/DrgKm7jJA+cc8p0Gt4SbA?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4929.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31f0d7a-a23a-4f98-009d-08dcc91e7ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 18:06:34.0245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5i0WIc6gvl7885bWyo2StXNhFd2pim+D2OGkFXpVbwIKCejfzFTTz8WKxhb2QfOZbtAo3YEsFntLmuuZUfuWVySki+TB4hgCysP99MEMFuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6373
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=michael.d.kinney@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For this MdePkg change to add an ACPI table type, do you mind opening a PR?

There are some minor code style issues that need to be addressed.

Structure type names and define names should be all upper case.

	__CXL_Early_Discovery_TABLE_H__ -> __CXL_EARLY_DISCOVERY_TABLE_H__

File names should be camel case.

	CXLEarlyDiscoveryTable.h -> CxlEarlyDiscoveryTable.h

Also, please provide links to the supporting public specifications in
the include file headers.

Thanks,

Mike

> -----Original Message-----
> From: devel@edk2.groups.io <devel@edk2.groups.io> On Behalf Of Jonathan
> Cameron via groups.io
> Sent: Friday, August 30, 2024 4:17 AM
> To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> Cc: marcin.juszkiewicz@linaro.org; gaoliming@byosoft.com.cn; Kinney,
> Michael D <michael.d.kinney@intel.com>; ardb+tianocore@kernel.org;
> chenbaozi@phytium.com.cn; wangyinfeng@phytium.com.cn;
> shuyiqi@phytium.com.cn; qemu-devel@nongnu.org; devel@edk2.groups.io
> Subject: Re: [edk2-devel] [RFC PATCH 1/1] MdePkg/IndustryStandard: add
> definitions for ACPI 6.4 CEDT
>=20
> On Fri, 30 Aug 2024 10:11:17 +0800
> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> One request - when cross posting to multiple lists, it is useful to
> add something to the patch title to make it clear what is EDK2, what
> is QEMU etc.
>=20
> [RFC EDK2 PATCH 1/1]
>=20
> It might irritate the EDK2 folk but it is useful for everyone else
> to figure out what they are looking at.
>=20
> > This adds #defines and struct typedefs for the various structure
> > types in the ACPI 6.4 CXL Early Discovery Table (CEDT).
>=20
> It's in the CXL spec, not ACPI spec so call out in this
> patch description that all that was added in ACPI 6.4 was
> the reservation of the ID.  The rest needs to refer to appropriate
> CXL specifications.
>=20
> For naming I have no idea on the EDK2 Convention for
> structures in specifications other than ACPI that are for
> ACPI structures.  The current one is definitely missleading
> however.
>=20
>=20
> >
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > ---
> >  MdePkg/Include/IndustryStandard/Acpi64.h      |  5 ++
> >  .../IndustryStandard/CXLEarlyDiscoveryTable.h | 69
> +++++++++++++++++++
> >  2 files changed, 74 insertions(+)
> >  create mode 100644
> MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
> >
>=20
> > diff --git a/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
> b/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
> > new file mode 100644
> > index 0000000000..84f88dc737
> > --- /dev/null
> > +++ b/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
> > @@ -0,0 +1,69 @@
> > +/** @file
> > +  ACPI CXL Early Discovery Table (CEDT) definitions.
> > +
> > +  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
> > +
> > +**/
> > +
> > +#ifndef __CXL_Early_Discovery_TABLE_H__
> > +#define __CXL_Early_Discovery_TABLE_H__
> > +
> > +#include <IndustryStandard/Acpi.h>
> > +#include <IndustryStandard/Acpi64.h>
> > +
> > +#define EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_01  0x1
> //CXL2.0
> > +#define EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_02  0x2
> //CXL3.1
> > +
> > +#define EFI_ACPI_CEDT_TYPE_CHBS     0x0
> > +#define EFI_ACPI_CEDT_TYPE_CFMWS    0x1
>=20
> Sensible to add all defines from the start?
> So CXIMS, RDPAS and CSDS
> (only that last one was added in 3.1 / revision 2.0)
>=20
>=20
> > +} EFI_ACPI_6_4_CEDT_Structure;
> > +
>=20
> > +///
> > +/// Definition for CXL Host Bridge Structure
> > +///
> > +typedef struct {
> > +  EFI_ACPI_6_4_CEDT_Structure    header;
> > +  UINT32                         UID;
> > +  UINT32                         CXLVersion;
> > +  UINT32                         Reserved;
> > +  UINT64                         Base;
> > +  UINT64                         Length;
> > +} EFI_ACPI_6_4_CXL_Host_Bridge_Structure;
> Should this naming reflect where it's actually defined?
> EFI_ACPI_CXL_3_1_CXL_Host_Bridge_Structure etc
>=20
> > +
> > +///
> > +/// Definition for CXL Fixed Memory Window Structure
> > +///
> > +typedef struct {
> > +  EFI_ACPI_6_4_CEDT_Structure    header;
> > +  UINT32                         Reserved;
> > +  UINT64                         BaseHPA;
> > +  UINT64                         WindowSize;
> > +  UINT8                          InterleaveMembers;
> > +  UINT8                          InterleaveArithmetic;
> > +  UINT16                         Reserved1;
> > +  UINT32                         Granularity;
> > +  UINT16                         Restrictions;
> > +  UINT16                         QtgId;
> > +  UINT32                         FirstTarget;
>=20
> Is this common for an EDK2 definition?  If it were kernel we'd
> be using a [] to indicate this has variable number of elements.
> I'm too lazy to check for EDK2 equivalents ;)
>=20
> > +} EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure;
> > +
> > +#pragma pack()
> > +
> > +#endif
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#120447):
> https://edk2.groups.io/g/devel/message/120447
> Mute This Topic: https://groups.io/mt/108173030/1643496
> Group Owner: devel+owner@edk2.groups.io
> Unsubscribe: https://edk2.groups.io/g/devel/unsub
> [michael.d.kinney@intel.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


