Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85E3CFA477
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLlc-0000X8-Og; Fri, 21 Nov 2025 02:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vMLla-0000UF-9y
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:41:14 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vMLlW-000570-Vz
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763710871; x=1795246871;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fNv7Ppvql5JtctCfOENHqXCUMLn/7A3IoGt4foCJlmg=;
 b=A52nKfWWIPOSppkp2XB+ARqKZ3F9+i4JJsuG28vxEuNdsqrONhx/yWUH
 nQ6z5Uz5o//E1iP1Fq3qMR2X5Usfz90GOsxCEQlCp2QXeXK1k1nanrx/X
 5RFrFoXg00FivseBg0/TVgMOSrvo+xQEnlwrAcB16qbsMopEgXLZACBZs
 5dXuEr6VufuhYjYRHAZQ61XNG9bdy9zWb7spfDAVWgA5vsEqrBB2P4MSv
 V97WaNIVdce0qeTDmxlwGmO6Mn/bkSj5hfSfCAVgpFyyIfz8LAxA72yKO
 iw5oc3E5c+aE8zQlpZ+mUW4lYDseydo6bQxYKWUHlPdzVyy558cmALpyN A==;
X-CSE-ConnectionGUID: L2Lts9wTS4GshoQy60ivGA==
X-CSE-MsgGUID: SfjJ1dgLSgOnZY2n24qauw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="88446544"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="88446544"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 22:56:45 -0800
X-CSE-ConnectionGUID: rHTB8abvRKej/aWAdsTCWA==
X-CSE-MsgGUID: HJsKYQL6TMKODNeXrP8QrA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 22:56:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 22:56:43 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 22:56:43 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 22:56:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzpSUUbqoYGLJpWRc0puft1B6z/pn+g9Xk1GRKt3yFNEvhiUDtEk6F1GmZpZT4EPZjyW2iInyelYed3bk+Pk3xdpZyvrwqGildRvKJHDY81Dhbq9VC48pOhKrELNF9QkUyYCmBM4uSb6V7qId5m9duXPW2jSHVLM0dMhCTMbH3CVFD5aRcQXJCOYGUlnyqvGqsbNg+MCfCRbiqD7WSePNZLX7Wezek1wh4d662ro/ecvSiU6NENSdqEYzx3OpOJpya8CqmiA4e+Kx5HrDxH8JIZ0hAzkHrFc1NY95peoTJEkNqQgFtwN+WeTZQmXeVtLBSnRwlSsvaHakN591ETeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YObA8tQnYkS7J3fCQuNQYoNUdiibbnMtE40zPMBqdN0=;
 b=eBGmSrrId2aaVYr0ZGe1Vf8vhScZrgfNY7X5q5TeLG8IBsZ76h5U2KNM2giZTL6T4NQN6bRBN2FBZlMMjr6MOC1/rfaa19oh8r/jG87JqEG+gpdtNnZdPPQvpF+druiZ+U99w1JOc1h4POwBxFCqdoipGuux8hUqTigPxdmae3qMtGwrYiQBBL7eHLg+hChkIE06xxgTd/K8l21P/tKGXUKchGT2TxSL4wopLzCDRWgmfdU485Fe44g+wU0MfcL/VOjkLy2rNrG1sgT8lk27ITeEQUGKgluEcUX4juIR2NIFH4OIFS19NPvHzCWs/9OfuN7M3HP6MjcKqYZv4J8WRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.11; Fri, 21 Nov 2025 06:56:41 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 06:56:41 +0000
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
Thread-Index: AQHcUTsfaCBAQNqK6UqI5jTHJ6PIg7Ts6XoAgAE6QFCAAJJ2gIAA3p9AgABvJgCAAROboIAFZI8AgAEGRKCAAHYegIAA+XkAgACdx4CAAy0k0A==
Date: Fri, 21 Nov 2025 06:56:41 +0000
Message-ID: <IA0PR11MB7185706A5A2A1A4FD2845D81F8D5A@IA0PR11MB7185.namprd11.prod.outlook.com>
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
 <IA0PR11MB7185B46F9919473A37BBFC0DF8D7A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3c68353c-f62f-4e37-aa4e-3920e9ef0c5f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3c68353c-f62f-4e37-aa4e-3920e9ef0c5f@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS0PR11MB7957:EE_
x-ms-office365-filtering-correlation-id: 215923ff-5e82-4447-9817-08de28cb2031
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qgzE+6nWpxO2/fovqjLJoiUeWuXAhCGGHUI8xJCBjj8UJF0mEdV++HcrT9?=
 =?iso-8859-1?Q?XQopGd7LTr1E8QM5MtGxABsoWLS2GNzec0RkNs0da6g1e8Ldhp5iVb3xqu?=
 =?iso-8859-1?Q?drPHcwsj+4oNb6HAG70UYHns0Ig/iTieDU9aV2CHQRUAyybtDbgv7eD/bG?=
 =?iso-8859-1?Q?Or58Ek6SJA2oCcEtJtb0ootI3Pr6UEA0mkcdIHzgXEYpWFfxatytL3hgeR?=
 =?iso-8859-1?Q?LAS2iKRnv938yaVs1cQ44n+RQMUi86PG+a7JBZvEoSbU2wNRHsxaZ5LPSm?=
 =?iso-8859-1?Q?Imhk+bi6TxQgKJT6WnsnsjgLqBdF1QiN/gs517PgqAEelh8RUl69+WENY5?=
 =?iso-8859-1?Q?IDZY1z3Fz5SY8VABTckofBnleLd5RA2gAc/Zbq0AiB6AFkTiddF65GGlM9?=
 =?iso-8859-1?Q?6yNEMYHJ+nl72X4rh8ptFHWv5OSEk1ILatJtl8aaZ5/5bib68M8yKS4Ac9?=
 =?iso-8859-1?Q?Ij1gS9an9KyCIihnzett5RK12KgMGeoU4o3kPSGo2O4IfaD4X5edyCinRc?=
 =?iso-8859-1?Q?WUNNLDJBLO3iaCGn6HTeFBik0zj4uaPLGfm4pRPBkGImWS0pBD4fYschlk?=
 =?iso-8859-1?Q?+hq3LiE7PK4GtMM0Xgdp1fiv16Jrfz2b4nZDKiWqmwrXShS/W6moU/Vq7A?=
 =?iso-8859-1?Q?jr0z/NqeVVt4gQz9I3zC3Ssy0u1SyS8BNhfvW0C9kLV4mngSwlJ3rmqNoa?=
 =?iso-8859-1?Q?ojAPcToasYmVXFN1eDIjiO61wHQjxJjOMsEXtb0nycgng+xxVV8cy52Ppj?=
 =?iso-8859-1?Q?X+DqfpXKQj/v1xgyULOJTz0eZPFy39sClrI7XwLHWSbtw0Knh8y9owGAax?=
 =?iso-8859-1?Q?uJPVk39V7nztKblCYgNafjgAugqKkfbRZY2rRB10B657suO3SCSmntl0PX?=
 =?iso-8859-1?Q?ymz6jBe6gEW+9TWM7/4YvFZRVypnRH1YSzcIbfZrVEElCsMgO2hi4O/Qpt?=
 =?iso-8859-1?Q?HS4PHVKFiowPoTLejYhpJJlBGqEWdklRZHzgcwdrFYBoyKUDAP+RE0Rh70?=
 =?iso-8859-1?Q?7K8jnv1xMV51rSw+WDQR/zP+dxw8HjYUYRpDeqYX9FhIyiAKVg1XDW/ubn?=
 =?iso-8859-1?Q?WxJ69QVL7qoraNAoUwnHybnmzLgEgT6P86iNvHqGoov8ndf/tvNP1j0Q1r?=
 =?iso-8859-1?Q?RJtxc5DZ35gxkoEQs6nzrxVFJuC2fILpTPRFhGUIqBVC43fLi0Ly/T9VY5?=
 =?iso-8859-1?Q?wk3CWtwKh38EeXU3/DPjfDfwHMwnfsjfYvyKOJuCPhRCOw9gdbOtXs6h3C?=
 =?iso-8859-1?Q?xYvadwEJofPRUaHxM4wOsxd8O7KnR0XQ654yiuBq+9xWUGQ8WffLcBtcrJ?=
 =?iso-8859-1?Q?WjVD55AceC5bg9Mn3a0Bc5wpM/h6RL6yvfsfvrtK4AJrVCalbwFKpTn5GH?=
 =?iso-8859-1?Q?fwnPSKOeu1AT/KIXV7CepbYw+mDKHcU66D4nn73s5HW/SIPoX1gqqe3Yn+?=
 =?iso-8859-1?Q?lj5tnPellsE1qK0Xf/zPDheQeCK/LrWwIGQmmj2bhBxMsg6jLjn/66vE/7?=
 =?iso-8859-1?Q?vXXYsSi5f0IgukuBFbdWZP4CINOaxLREixzBhbj/NARdtCHUUk9gQBCW3g?=
 =?iso-8859-1?Q?ZiNNLD9sPW85Jeq/lH8E9oOEi0bd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aYu5LjdkAOOMhY0dt/kXhWYbxW+Vvap2kK2U+/SBqQMld+lMct/+XezZie?=
 =?iso-8859-1?Q?C49/6FyChew8BPQgyx/f62WJQXSjBQsqztIHTJU/tutOUyIuUZjY0ajJiq?=
 =?iso-8859-1?Q?IWPFzXqXzfWTW9vF9ytc/UUJEB7zmKLl45SLmbOIOm6E0tRuA5lE33+jPb?=
 =?iso-8859-1?Q?U+lLEtiHTYLjV1/1kLsn2LS822iZy6YeH2f7CkkGjifJvomeAwT+6LR3+/?=
 =?iso-8859-1?Q?S1tDezfCbc2q10TeC39e169ywcZmAj2cBX0OZoVxFL18dD19izH+t4hcxh?=
 =?iso-8859-1?Q?Fnz0LSDUiX/LpamWzAnz4uUp6rvHX5ill1zuNVpeZJNTGlxvk4eURxLwNR?=
 =?iso-8859-1?Q?c+sYg2mTOkKFuiy2rQt6f5BwgT4jiU1tyyBS0FEBcE4Yj5x2y+7YSY3o2N?=
 =?iso-8859-1?Q?53juKJ75mFrsmUbGjJ0lar49W80nsVc6PfEvX5q6Rp7JyOvZKSyfr/4v4z?=
 =?iso-8859-1?Q?AIMzYtGAny+UNpyOoG+p+8EqDCc9NCdkmIbH7LVoALSnVTTXyBLA2ooDCB?=
 =?iso-8859-1?Q?eYOHKxkyZua49Z/318Z56xspy+Uot4E7WkEe2pd85RV6buS6Fg/XDM3m/z?=
 =?iso-8859-1?Q?RYECh1Iy5CR6udfDfmcRVAERZKOcVJZiylxD2tpU3CEm0/ntr/jQbeqZVf?=
 =?iso-8859-1?Q?475LWyZl5Jhm9Sb0lkc9aE7a5h5lN1pF+icbgjEqWr6g9e++TjSRSE8gNC?=
 =?iso-8859-1?Q?dIweCWuak7P0OCREtyt8yVe8VcjVuU5Ahkw1a0MVHhd91napm+J5I8SZlW?=
 =?iso-8859-1?Q?ZseX4y7AO7QfROYC+5zcIQp3F55FkWKduaR7Bi6dNydnhP9dV3ZI6vzima?=
 =?iso-8859-1?Q?h4vsM7w2n9SzsLQ004VgJnxBSqIeVhjWcnziks2sLnJwXwOsZsZaYXB/9O?=
 =?iso-8859-1?Q?XcBbpMFlYRWbXfhxSGQX6B4nbgP88RRRDLGiVsd3zHueKp8jTZ0FqCObjw?=
 =?iso-8859-1?Q?QNSHjw7O66sCLlzZ0R4cCwyzp0d8PXGj1hYM7DZ0qLvDg2r3HWXaF3ag9O?=
 =?iso-8859-1?Q?7ZbwLT5uKfV1DO0xIz3FScOINVrjyP1M9OD0+VGYA+Hv/cuF11qWuVzjI5?=
 =?iso-8859-1?Q?46JbBVyQ3gdvnAiOpdcPAiub9azTdv6wdxg1GCQw7PA5/g6paqMwS/F/nN?=
 =?iso-8859-1?Q?GpOJg+0tikXFqflKx0icaNqxhbEofovXTiKwaJCYb/EdZQfnvKh6Qgm27d?=
 =?iso-8859-1?Q?fAt1r7fAAh1I2zHsPc5ZdPkglNSIE13BhumqxsGdhK2DTvKtl/x89fl7Z1?=
 =?iso-8859-1?Q?KXTmYcjui3CzqW/Iqmz7dR14xK6DMCygMPoypGvEv0mbCYEcsgOEun3iS+?=
 =?iso-8859-1?Q?X1YrgxYWFHHs2KpMOuVzQKy/ORjVVSxezcGL++LHw6Uas7eqXj0uUecQb+?=
 =?iso-8859-1?Q?g6CSV+QMZN4QiyXQv47QaMAaA0sUoPtgA9Bi2MOPu8dnAPMFH2c7Q/Udhp?=
 =?iso-8859-1?Q?Un5y9csAtdJdAroNUhgQYdChf+PAdVv2Id2gYBxqq1/h1WuSlidTVvImGF?=
 =?iso-8859-1?Q?Lj0fN86kzsFSBLo1WoQWWXTl61tyrFDt2/qiMAYXvx3e5W23zAp/SD4H2j?=
 =?iso-8859-1?Q?4zQ1gyAuZbXrThplAllek5W0zrpy4c8Occ2AC7MB8bidsDFtY6c5/BADtC?=
 =?iso-8859-1?Q?Hp4h9AwF56zXS0K6FTvWyQ5YzEM2nwgxRb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215923ff-5e82-4447-9817-08de28cb2031
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 06:56:41.6211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31G0DbuyZf9OAmYwvHuW/m+JrUY6ZfcN1fwY7U3WnZV7KOewYUDsTq6GHva8Mop2TlDsxXBxgQ97u9hIAu1yQj2QCyi2ZpZF8fNsSPJD/FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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
> On 2025/11/19 14:42, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA add=
r
> >> associated with a ram device
> >>>>>>>>>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> >>>>>>>>>>> If the Guest provides a DMA address that is associated with a
> >> ram
> >>>>>>>>>>> device (such as a PCI device region and not its system memory=
),
> >> then
> >>>>>>>>>>> we can obtain the hva (host virtual address) by invoking
> >>>>>>>>>>> address_space_translate() followed by
> >>>>>> memory_region_get_ram_ptr().
> >>>>>>>>>>>
> >>>>>>>>>>> This is because the ram device's address space is not accessi=
ble
> >> to
> >>>>>>>>>>> virtio-gpu directly and hence dma_memory_map() cannot be
> >> used.
> >>>>>>>>>>> Therefore, we first need to identify the memory region
> >> associated
> >>>>>> with
> >>>>>>>>>>> the DMA address and figure out if it belongs to a ram device =
or
> >> not
> >>>>>>>>>>> and decide how to obtain the host address accordingly.
> >>>>>>>>>>>
> >>>>>>>>>>> Note that we take a reference on the memory region if it
> belongs
> >> to a
> >>>>>>>>>>> ram device but we would still call dma_memory_unmap() later
> >> (to
> >>>>>> unref
> >>>>>>>>>>> mr) regardless of how we obtained the hva.
> >>>>>>>>>>>
> >>>>>>>>>>> Cc: Marc-Andr=E9 Lureau<marcandre.lureau@redhat.com>
> >>>>>>>>>>> Cc: Alex Benn=E9e<alex.bennee@linaro.org>
> >>>>>>>>>>> Cc: Akihiko Odaki<odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>>>>>>>> Cc: Dmitry Osipenko<dmitry.osipenko@collabora.com>
> >>>>>>>>>>> Cc: Alex Williamson<alex.williamson@redhat.com>
> >>>>>>>>>>> Cc: C=E9dric Le Goater<clg@redhat.com>
> >>>>>>>>>>> Signed-off-by: Vivek Kasireddy<vivek.kasireddy@intel.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>        hw/display/virtio-gpu.c | 24 +++++++++++++++++++++---
> >>>>>>>>>>>        1 file changed, 21 insertions(+), 3 deletions(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.=
c
> >> index
> >>>>>>>>>>> 199b18c746..d352b5afd6 100644
> >>>>>>>>>>> --- a/hw/display/virtio-gpu.c
> >>>>>>>>>>> +++ b/hw/display/virtio-gpu.c
> >>>>>>>>>>> @@ -798,6 +798,26 @@ static void
> >>>>>>>> virtio_gpu_set_scanout_blob(VirtIOGPU
> >>>>>>>>>> *g,
> >>>>>>>>>>>                                      &fb, res, &ss.r, &cmd->e=
rror);
> >>>>>>>>>>>        }
> >>>>>>>>>>>
> >>>>>>>>>>> +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> >>>>>>>>>>> +                                       struct virtio_gpu_ctr=
l_command *cmd,
> >>>>>>>>>>> +                                       uint64_t a, hwaddr *l=
en) {
> >>>>>>>>>>> +    MemoryRegion *mr =3D NULL;
> >>>>>>>>>>> +    hwaddr xlat;
> >>>>>>>>>>> +
> >>>>>>>>>>> +    mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as,
> a,
> >>>>>> &xlat,
> >>>>>>>> len,
> >>>>>>>>>>> +                                 DMA_DIRECTION_TO_DEVICE,
> >>>>>>>>>>> +                                 MEMTXATTRS_UNSPECIFIED);
> >>>>>>>>>>> +    if (memory_region_is_ram_device(mr)) {
> >>>>>>>>>>> +        memory_region_ref(mr);
> >>>>>>>>>>> +        return memory_region_get_ram_ptr(mr) + xlat;
> >>>>>>>>>>> +    }
> >>>>>>>>>>> +
> >>>>>>>>>>> +    return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a,
> len,
> >>>>>>>>>>> +                          DMA_DIRECTION_TO_DEVICE,
> >>>>>>>>>>> +                          MEMTXATTRS_UNSPECIFIED);
> >>>>>>>>>> This function should:
> >>>>>>>>>> - call memory_region_get_ram_ptr(mr)
> >>>>>>>>>>         if memory_region_is_ram(mr)
> >>>>>>>>>> - return NULL otherwise
> >>>>>>>>>>
> >>>>>>>>>> There are a few reasons. First, the documentation of
> >>>>>>>> dma_memory_map()
> >>>>>>>>>> tells to use it "only for reads OR writes - not for read-modif=
y-write
> >>>>>>>>>> operations." It can be used for read-modify-write operations s=
o
> >>>>>>>>>> dma_memory_map() should be avoided.
> >>>>>>>>> This patch series only deals with non-virgl use-cases where AFA=
ICS
> >>>>>>>> resources
> >>>>>>>>> are not written to on the Host.
> >>>>>>>>>
> >>>>>>>>>> Second, it ensures that the mapped pointer is writable.
> >>>>>>>>>> "[PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
> >>>>>>>> associated
> >>>>>>>>>> with VFIO devices" adds checks for memory_region_is_ram() and
> >>>>>>>>>> memory_region_is_ram_device() to virtio_gpu_init_dmabuf(),
> but
> >> the
> >>>>>>>> other
> >>>>>>>>>> callers also use the function to map writable pointers.
> >>>>>>>>> Unless I am missing something, I don't see where writable point=
ers
> >> are
> >>>>>>>> used
> >>>>>>>>> in non-virgl use-cases?
> >>>>>>>> Rutabaga uses too, but you are right about that 2D operations
> won't
> >> use
> >>>>>> it.
> >>>>>>>>
> >>>>>>>> That said, exposing non-writable memory to Virgl and Rutabaga le=
ts
> >> the
> >>>>>>>> guest corrupt memory so should be avoided. On the other hand, it
> is
> >>>>>>>> unlikely that rejecting non-writable memory will cause any
> problem.
> >> You
> >>>>>>>> can also add another code path to use
> >>>>>>>> memory_region_supports_direct_access() instead of
> >>>>>>>> memory_region_is_ram()
> >>>>>>>> for virtio-gpu for 2D and avoid calling memory_region_is_ram() i=
n
> >>>>>>>> virtio_gpu_init_dmabuf() if you want to keep non-writable memory
> >>>>>> working.
> >>>>>>> AFAICS, virtio_gpu_init_dmabuf() is only called in non-virgl/non-
> >> rutabaga
> >>>>>> code.
> >>>>>>> And, this patch series and my use-case (GPU SRIOV) only needs to
> >> deal
> >>>>>> with
> >>>>>>> non-writeable memory because the rendering is already done by the
> >>>>>> Guest and
> >>>>>>> the Host only needs to display the Guest's FB.
> >>>>>>>
> >>>>>>> However, I see that virtio_gpu_create_mapping_iov() is used by
> >>>>>> virgl/rutabaga
> >>>>>>> code as well, so I am wondering how do things work right now give=
n
> >> that
> >>>>>>> virtio_gpu_create_mapping_iov() always calls dma_memory_map()?
> >>>>>>> In other words, is there no problem currently with non-writeable
> >> memory
> >>>>>>> in virgl/rutabaga use-cases?
> >>>>>>
> >>>>>> The current code is problematic, and using memory_region_is_ram()
> >> will
> >>>>>> fix it.
> >>>>> Ok, I'll make the change.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>>> It also makes the check of memory_region_is_ram_device() and
> >>>>>>>>>> memory_region_is_ram() unnecessary for
> >> virtio_gpu_init_dmabuf(),
> >>>>>>>> reducing
> >>>>>>>>>> the overall complexity.
> >>>>>>>>> Since buffers reside completely in either ram or ram_device
> >> regions,
> >>>>>> using
> >>>>>>>> both
> >>>>>>>>> memory_region_is_ram_device() and memory_region_is_ram() to
> >>>> check
> >>>>>>>> where
> >>>>>>>>> they are located seems necessary and unavoidable.
> >>>>>>>> It can unconditionally call virtio_gpu_create_udmabuf(), and if =
the
> >>>>>>>> function finds the memory is incompatible with udmabuf, it can c=
all
> >>>>>>>> vfio_device_lookup() to tell if the memory belongs to VFIO or no=
t.
> >>>>>>> Yeah, what you suggest is doable but seems a bit convoluted to ha=
ve
> >> to
> >>>>>>> first call virtio_gpu_create_udmabuf() and if it fails then call =
VFIO
> >> related
> >>>>>>> functions.
> >>>>>>>
> >>>>>>> I think using memory_region_is_ram_device() and
> >>>>>> memory_region_is_ram()
> >>>>>>> to identify the right memory region and calling either
> >>>>>> virtio_gpu_create_udmabuf()
> >>>>>>> or vfio_create_dmabuf() is much more intuitive and readable.
> >>>>>>
> >>>>>> memory_region_is_ram_device() and memory_region_is_ram() are
> not
> >>>>>> sufficient to identify the right memory region.
> >>>>>> memory_region_is_ram_device() returns true for RAM device created
> >> by
> >>>>>> non-VFIO devices, and memory_region_is_ram() returns true for
> >> memory
> >>>>>> regions created with memory_region_init_ram_ptr(), which is not
> >> backed
> >>>>>> with memfd.
> >>>>> Right, but structuring the code in the following way would address =
your
> >>>> concerns
> >>>>> and make it more robust:
> >>>>>            if (memory_region_is_ram_device(rb->mr) && (vdev =3D
> >>>> vfio_device_lookup(rb->mr))) {
> >>>>> 	vfio_create_dmabuf(vdev, res);
> >>>>>            } else if (memory_region_is_ram(rb->mr) &&
> >>>> virtio_gpu_have_udmabuf()) {
> >>>>> 	virtio_gpu_create_udmabuf(res);
> >>>>>            } else {
> >>>>> 	...
> >>>>>            }
> >>>>
> >>>> One of the concerns I raised is that having such checks has an inher=
ent
> >>>> hazard that they can be inconsistent with the actual implementations=
.
> >>>>
> >>>> The original checks had such inconsistency, and the updated one stil=
l
> >>>> have too. memory_region_is_ram(rb->mr) &&
> >> virtio_gpu_have_udmabuf()
> >>>> can
> >>>> be still true even for memory regions that do not have memfd; please
> >>>> refer to the example of memory_region_init_ram_ptr() I pointed out i=
n
> >>>> the last email.
> >>>>
> >>>> Even if you somehow managed to write checks that match with the
> >>>> implementations, it is still possible that a future change can break=
 it.
> >>>> Letting the implementations check their prerequisite conditions
> >>>> completely prevents such an error by construction and makes the code
> >>>> more robust.
> >>> IIUC, your suggestion is to add a check for
> >> memory_region_supports_direct_access()
> >>> inside virtio_gpu_create_udmabuf() and call it unconditionally right?
> >>
> >> No, my suggestion is to remove it at all. Creating udmabuf only requir=
es
> >> that the memory regions are backed with memfd.
> > If we unconditionally call virtio_gpu_create_udmabuf() for VFIO backed
> buffers,
> > I think it makes sense to return early without having to iterate over a=
ll the
> iov
> > entries to check their memory regions. So, I am thinking adding a
> > memory_region_supports_direct_access() or
> !memory_region_is_ram_device()
> > check would help with this.
>=20
> They don't make a difference.
>=20
> If the first memory region is backed by VFIO, the loop ends with the
> first iteration and you do not need to iterate over all the iov entries.
>=20
> If the first memory region is backed by memfd but a succeeding memory
> regions is backed by VFIO, checking
> memory_region_supports_direct_access() or
> !memory_region_is_ram_device()
> only for the first memory region is ineffective.
Given that we have not yet encountered buffers with mixed memory regions
(memfd and VFIO) and since this is only a theoretical possibility at this p=
oint
(as we have no evidence of their existence), I think it is reasonable to as=
sume
that the first entry's memory region is representative of the whole buffer.

In other words, if the first memory region is backed by memfd, then we have
to assume that memory regions associated with other entries are also backed
by memfd.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

