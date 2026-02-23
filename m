Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459E4E98DFA
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 07:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuQnI-0000dL-Hy; Mon, 23 Feb 2026 02:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vuQnH-0000dB-8b
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 02:55:51 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vuQnE-0003nd-CT
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 02:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771833347; x=1803369347;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KvIxHHWMKEr1I/4jCp64DX0HzCd/O4ywihaw0/GrQzM=;
 b=BZRYxkeHrHtzyCJ5sxYhjV8XciJZt8iv2ul03moIe1Hvpckkv9dMyFZQ
 ML938U5Pl66TZ3uQi9DiOs47Qt4DgaUVHWUufnaCd9wN6bQrjmGq0X51H
 MZMmMkF0YjPkBp137J5/jE6sXxj1vISmyHrKBi6Y4x9AlSGNPZd99HMY3
 mhNO0vX86OoYYCStTiC9dBGnZJVoUZp8DfJZHiWKbgqukNuT/FRp7Tugp
 KDGY1LSMU1nNniuQM8imW5EqM1Po9AEFlHMqDn3PZdafu3WJSeY0DVubf
 Uf2N+rbF6JyQOH2rXfSkoeo5eZUDpzqp90vP7PEfBdfHCnDaiZdj3O2qg g==;
X-CSE-ConnectionGUID: U/Wqu9rpTe6IgONaDyBaBQ==
X-CSE-MsgGUID: J+huwNUyRemPmf7eYhPgag==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="90227505"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="90227505"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2026 23:55:42 -0800
X-CSE-ConnectionGUID: 3rrMdEhHQiSDy0PJZ0ieWw==
X-CSE-MsgGUID: HS7zvUCvTe+8w4HDHh8wgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="219990095"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2026 23:55:43 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 22 Feb 2026 23:55:42 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 22 Feb 2026 23:55:42 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 22 Feb 2026 23:55:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvX5LCYE3hUmip4Mvb0++dzjBNEWJD6USPmB4HbbN3K/3ng0xyLUvPMm0dv8gGWYyi93xE6uBrRSPc/+Z3REcFAW5tnhWwPufrmwSxdRMKmqpr7mezqN+ZByClPW21E5+96OqJjTA5E/TTCjQaJVOKESYwP/5MulGOpC8iz+HLggzP+g0+eTc8RVgDcVmNwcqllUpF6+B69BFRysowvRa7ZQTPLAaOt2SaoLu9bm/5j4d1+TaNlOFuefxsjE1cPsU4clfzn2Rqip4OSZ2cEnJdwJxLmYJLa3v7AyZ3A5OtmQQxBtMekM8xMtG0wAVdNzc5qEQeWSg8B0p4+ya47dRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbbrnRGUL5TfW2raltUQeuN/wuu49y5dmw0oeM+fyaY=;
 b=JbbsjtuXE1De5OszFHuB3aG6lwUgNuXsxwIJ0dtunlyEUUX+LnJvOdDYG9DBYR5JSIs/zRMMrtSb6KKwPC9V8+A+KWxuPTzgoBQXqqllvvPwNiWApkJSuD2+eTVZC1Kzov2wwGIQPeFv7tstYDQmHzy8GREvhJnRhHe83d4H5Zq41JbsWSQ4g/2bPxib7YW3+xoA31zz74AROYXGkRQbL8tsi/N+v+s/KUgUyVkokl/BCizwie1nGfDh1iQVygZMe7g+QhRT+7iKG49mQevI2XT0jKV5mxYU8t1ncC9l23O0AwFCBdqiE0yvSdfuKmgrq+LnUM1V7tv83dBsWQttkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CH3PR11MB8591.namprd11.prod.outlook.com (2603:10b6:610:1af::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 07:55:40 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 07:55:40 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcmls4q3luewSeSECtMA18foJZSbV74KeAgACEarCAAjb9AIAKp9MggANblQCAA1uAQA==
Date: Mon, 23 Feb 2026 07:55:40 +0000
Message-ID: <IA0PR11MB71858F39EA8EA9CEBACDDB1EF877A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
 <20260210070155.1176081-12-vivek.kasireddy@intel.com>
 <c7c03384-4815-4032-89bd-de1ef90bb949@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71856CAA4507A8EFD5AF5F45F863A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a7b64dbd-9535-4927-bf36-e579b8bec4ca@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71855A99CC24E9367DFC8223F86BA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <40ca075b-51e5-4aad-aab5-fbaf1c9d530c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <40ca075b-51e5-4aad-aab5-fbaf1c9d530c@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CH3PR11MB8591:EE_
x-ms-office365-filtering-correlation-id: f222741e-0cc5-40ad-d946-08de72b0f02b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7BJAW1P8Dkn4GB8p7NlwqIjIesBN+cujKJX9KnqFVS0H24Es0FUhB/KJgo?=
 =?iso-8859-1?Q?YUZstUsFo4OQm/pY0nStt3lcY04Tt0MK9AZyBz7NQ9Bhz2nDats/fbrys9?=
 =?iso-8859-1?Q?0TnOPG1N3v3+H36lCeEmBhVeXIBAc6oxqAUZUocNnovSPfpNC1hy9FK2QK?=
 =?iso-8859-1?Q?1ge+HrgpjJktiIJT5e4mW08apQXgAUiAtwyiyqXIP61B+IO8n13HvHE1/q?=
 =?iso-8859-1?Q?1lOUQmKP/VkckNYmik8ZVoOJT/I/oKyXdNfR4teWm36lIU8LYKXl3wGWVz?=
 =?iso-8859-1?Q?XFTlL84NlYHKVGjn+2UucO3bWpNslxeDxVvq3yrInGidfDBa4o4VLVR7cE?=
 =?iso-8859-1?Q?Fwm9V4A3zPnRvS58euxu+ml9DazX4wtQBWdMakkp+1o8yfZgDJdXNdjzbs?=
 =?iso-8859-1?Q?pMIbDqobx3SpcFn7GQ39rjuNn9alTW8dQY6DdDQwKWhCFpMv+mKsLbwFJh?=
 =?iso-8859-1?Q?wLNzG1sRlRMrPtjw+fG94LeNdHOda4B7qDH5H9uLgKlsAIN4Bz9bxKQE8p?=
 =?iso-8859-1?Q?dtkDMyp6rgbs1LrXaY1WNXprgf1/5X2/mkxnbaAIrmfcqB7uJP4UdnwvBq?=
 =?iso-8859-1?Q?Ax8Yh22CjM4U4RksE8CMXpl5Apj2cmsANwufhjztTSMGArY1DblWy/DSjn?=
 =?iso-8859-1?Q?CKUznoVY4gabOCrZHYs7R7L0mylto1UJ5O300LQWmbGxioT6WnP5oU5Z5A?=
 =?iso-8859-1?Q?e3kuY2pG/mEFpiiksXB4iM9EiLmFLdWpzxVRSkKXLELrpJ9ls6UcxVZ9UZ?=
 =?iso-8859-1?Q?A0PMAVaLI7Jmu4PHh8mi1O8EToKZMMAhXCUTml1yi2ZsvTKSFmNAASGWDV?=
 =?iso-8859-1?Q?1ik24pjjFEQOnlFn4lSaJHxk0uWHbDqP+B+OzRRrzzpVfZ/CozKOA9cYlI?=
 =?iso-8859-1?Q?0SDEm7uRfyWFcn7vNGGhL8+jPbKyd680uqtN/LmxAvBcXj40Hf9SArgT6E?=
 =?iso-8859-1?Q?KGIJtkIxPwJKfknlyevf99+VMIwAs2fXPF6SxFOw6dIrOD5Qvs/UWh9NX1?=
 =?iso-8859-1?Q?IJsCj5wm4NAqeuA7gk4b5QUVGFq2ikznIkhzK5lVb0s8s/z5Qw/AWzSgF3?=
 =?iso-8859-1?Q?s4bOnk8sNK30ny6ZgWaDxl5xZq8uXLEgXFZhJr4vpBmuOyHSED0voz/EHe?=
 =?iso-8859-1?Q?ThUyK/c6ZZVdKZnddkOX5Uup+PVf7dJauURi17K8Jd4BJxvYWyf6maJmS4?=
 =?iso-8859-1?Q?eebShszDu9os0wNUN863VTZoslz1PPXweJTz2RT/YGlPWAzz4ASnf0H4Sl?=
 =?iso-8859-1?Q?3q7a259Y4zRHFonhrNYH/T4+eBgcpFwsjoLatcxeLFChT7i2K1Uu1nUjCn?=
 =?iso-8859-1?Q?C1A7KA1+6TOh3Cx6bkJ6pA31Z3C5As6elD63tY6qUhvp1c+lkhsLhW75uT?=
 =?iso-8859-1?Q?9nBPkJQEGRkJ4rOO5htVdKcWgtf1eX3UvaFNiuaoS/J1lSEJc3mGReUe+v?=
 =?iso-8859-1?Q?jUiooSpgPpXb+6LjjBnmckZHkXbTJyuiOLdokDBkLcQP6DEwU0ik8VG4Ey?=
 =?iso-8859-1?Q?SAd/c/0rZ5NmcqnbeHTv3o90QeJWgB+aiWheu9+qaIsR3QcURooNgtCGGA?=
 =?iso-8859-1?Q?vPigqzJoFLWDBEWWn4435uP8kgcOvim08bqKzsvI1S9tgF0O5d5hu5uSiG?=
 =?iso-8859-1?Q?F/5CuwF+9wVRA6/wARajxQBWP7s4O2VOuHU98UoYaXnWiYDLwbugHUgzlK?=
 =?iso-8859-1?Q?Kq3Ez/DdFllVPkJZFEU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LSSq0LPgvCd9jfg8xqH5TkQAOFQQ3yTckjPq6Z1GvKAYs9vrjaT3cA8g9Z?=
 =?iso-8859-1?Q?Wr4PTR3FC8lDT+bwn1MOKbMEaVGebVIVBmpMeKE4S94S9vPQIej9gl3/Fg?=
 =?iso-8859-1?Q?Mcr/SFELbcSxOlbBCaiTwpBhZU8osDJLdFYy4CgWSoSFce0KKIXXdTIJNZ?=
 =?iso-8859-1?Q?aj9CmF9xG6OfmSy2U5/NvVA9Mi4hAEARZuaVwdV5mvqjvavH2bQX3BBm2k?=
 =?iso-8859-1?Q?/UE01YuWbmMqw61436Uqcjaoia4u/2+qesMCvCCESYvTkn7x1GmXLkZfnE?=
 =?iso-8859-1?Q?/PRQmx1m5V73vUGfvt1gssVbdPFHW4VTtfM+xnqZ8JNUVSfq7GCiJhceKZ?=
 =?iso-8859-1?Q?UkonLJgwUscTO2wIKhtyj4GpAVp1qjZzPuRd1YEzgHVTpq53bjye3P5Sf3?=
 =?iso-8859-1?Q?bT4EJyffXMMgvujgEmXXTY/p9r2Av13HsirytRu+ZR+HyOYSznHfwngda4?=
 =?iso-8859-1?Q?Yvooi8r5MK6oUW+ILCluLYcN0exleKshywAXrlxGWdUezsEhRM4lZAZ0dW?=
 =?iso-8859-1?Q?YsLU3wC+0zRdQtVeX7XNIByJr7Z7ySnlzX351VTT5M6xeebVfU8VxGFFwU?=
 =?iso-8859-1?Q?7ZTFjdD43c/FV1vY7PedfaX/3pSxBJz+Mq1J2AKSCn+YVCTO4mLPqDsSrx?=
 =?iso-8859-1?Q?QOToPBsGXvsYDPS9qqa79b74hiEYW0Ub/GKJecVVCVi/72rODZzZRQndBo?=
 =?iso-8859-1?Q?ZxR+79MEP81B9xA1hwKmw3cRXptModuK6VenvQPyaAVnnUGIrAsSBpAVKp?=
 =?iso-8859-1?Q?5sKqmUIGrzpQsG6XfSyfREeeQnYQMUIyJ56BzyNEfKwfaVjzomAgQ3DDyG?=
 =?iso-8859-1?Q?qBWo2joJuS7erwefc6SL98Rq8ACHvF6zZnDLdwCKoRu0ODzJL0JgOgiwkv?=
 =?iso-8859-1?Q?OT0fAcVHEdGleNm1AaQCeNTs5hR/zJYjnwx8Z8se7VMd5H09n1eO9orTOy?=
 =?iso-8859-1?Q?BBjrh6+XFW+bLgJqtctc8o+LkUngC6f2O1/9vmM3r2U3xOwO8/a7vrBCfo?=
 =?iso-8859-1?Q?Ap837as4vA+xImmwhv8zV56wl5UTf6AjhZnjn1syXAVQTdoJVpymszDMFu?=
 =?iso-8859-1?Q?PZnLrIfKfsI+u59bgC8PjN8w1SNPqHcrSkPm2EsDy06NpAVij1rDnWOsgq?=
 =?iso-8859-1?Q?YSS+URt6Yv8TFisTKSUcE2s1kAl36HYbK5oe/HVB+yIqFNdTXE4hjoEf2U?=
 =?iso-8859-1?Q?e/NtKXOJ5J9kPuGJQA7HokIqc621ldv2y6pb9ek+cKyEAWdyshqqhpzttO?=
 =?iso-8859-1?Q?k/0gNeNBS3EIjfCSwMkMdrgBG1GyWb/eiLPuHG5gwDSeYYrj5LWe41Ukr0?=
 =?iso-8859-1?Q?sZ1Cz/t1+UFmzySxkQxqHmPOwJMet11W1JyZhPtJglLmnXxRc4ZthCg4xD?=
 =?iso-8859-1?Q?LZYNXgSbthpsMYP5E1bDI51EM3OqYj86DnT90LGolP0QRpzRHZBuS3IpyX?=
 =?iso-8859-1?Q?IP6Ao0PL4jwqshKm7Wyr0jViAWIKiFLGYvBBnhFtrQG9yX6zw+yxXvv5oP?=
 =?iso-8859-1?Q?LemMXMo0CtJnO/KyXYYOTeepQnnTqoxdxaETBXqhVa7R0A2mjWfEvn8wXL?=
 =?iso-8859-1?Q?nnzm7VZMeHTtIKtqd1CR4b8vXzhDm++is64NFX9CGs+zs5l/9UVuyXtGsI?=
 =?iso-8859-1?Q?OAMqEPL5+hxUe7/1rL+2V2Nwc1dQA9/kmn+927+9IZdG7rc0PrOq/JDd1f?=
 =?iso-8859-1?Q?qch3dH69DEaDziU7Z2TnZmadPCnI0Azdi80VB3ptMN6DYHAdA9QAzF5A7i?=
 =?iso-8859-1?Q?iaCIMDJZQ0mNGUHR79rHY21m7fPq5nLmGcZL2VBcL2vospC9rhEO0Ir+KO?=
 =?iso-8859-1?Q?/ioO6CO3jA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f222741e-0cc5-40ad-d946-08de72b0f02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 07:55:40.1763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IU3s66g6qAVoXkuMoWLJYg8rg9/KwWineZbH26gs0KL1qPLsjdAUgyJeBV3/ioZJ6/US+Icn1G2wpUMT8TcKdMgWcooPmoVbeMH+YynzaI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8591
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
> >>
> >>>>> In addition to memfd, a blob resource can also have its backing
> >>>>> storage in a VFIO device region. Since, there is no effective way
> >>>>> to determine where the backing storage is located, we first try to
> >>>>> create a dmabuf assuming it is in memfd. If that fails, we try to
> >>>>> create a dmabuf assuming it is in VFIO device region.
> >>>>>
> >>>>> So, we first call virtio_gpu_create_udmabuf() to check if the blob'=
s
> >>>>> backing storage is located in a memfd or not. If it is not, we invo=
ke
> >>>>> the vfio_device_create_dmabuf() API which identifies the right
> VFIO
> >>>>> device and eventually creates a dmabuf fd.
> >>>>>
> >>>>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> >>>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>>>> fall back to the vfio_device_mmap_dmabuf() API to get a mapping
> >>>>> created for the dmabuf.
> >>>>>
> >>>>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>>>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>>> Cc: Alex Williamson <alex@shazbot.org>
> >>>>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>>>> ---
> >>>>>     hw/display/Kconfig             |  5 ++++
> >>>>>     hw/display/virtio-gpu-dmabuf.c | 50
> >>>> ++++++++++++++++++++++++++++------
> >>>>>     2 files changed, 47 insertions(+), 8 deletions(-)
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
> >>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-
> gpu-
> >>>> dmabuf.c
> >>>>> index d9b2ecaf31..54d010b995 100644
> >>>>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>>>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>>>> @@ -18,6 +18,7 @@
> >>>>>     #include "ui/console.h"
> >>>>>     #include "hw/virtio/virtio-gpu.h"
> >>>>>     #include "hw/virtio/virtio-gpu-pixman.h"
> >>>>> +#include "hw/vfio/vfio-device.h"
> >>>>>     #include "trace.h"
> >>>>>     #include "system/ramblock.h"
> >>>>>     #include "system/hostmem.h"
> >>>>> @@ -27,6 +28,27 @@
> >>>>>     #include "standard-headers/linux/udmabuf.h"
> >>>>>     #include "standard-headers/drm/drm_fourcc.h"
> >>>>>
> >>>>> +static bool virtio_gpu_create_vfio_dmabuf(struct
> >>>> virtio_gpu_simple_resource *r,
> >>>>> +                                          Error **errp)
> >>>>> +{
> >>>>> +    bool ret =3D false;
> >>>>> +#if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
> >>>>> +    Error *local_err =3D NULL;
> >>>>> +    int fd;
> >>>>> +
> >>>>> +    if (!vfio_device_create_dmabuf(r->iov, r->iov_cnt, &fd,
> >> &local_err))
> >>>> {
> >>>>> +        error_report_err(*errp);
> >>>>> +        *errp =3D NULL;
> >>>>> +        error_propagate(errp, local_err);
> >>>>> +        return false;
> >>>>> +    }
> >>>>> +
> >>>>> +    ret =3D true;
> >>>>> +    r->dmabuf_fd =3D fd;
> >>>>> +#endif
> >>>>> +    return ret;
> >>>>> +}
> >>>>> +
> >>>>>     static bool virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res,
> >>>>>                                           Error **errp)
> >>>>>     {
> >>>>> @@ -73,16 +95,28 @@ static bool
> >> virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res,
> >>>>>     static bool virtio_gpu_remap_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res,
> >>>>>                                         Error **errp)
> >>>>>     {
> >>>>> +    Error *local_err =3D NULL;
> >>>>> +    bool ret =3D true;
> >>>>>         void *map;
> >>>>>
> >>>>>         map =3D mmap(NULL, res->blob_size, PROT_READ,
> MAP_SHARED,
> >>>> res->dmabuf_fd, 0);
> >>>>>         if (map =3D=3D MAP_FAILED) {
> >>>>>             error_setg_errno(errp, errno, "dmabuf mmap failed");
> >>>>> -        res->remapped =3D NULL;
> >>>>> -        return false;
> >>>>> +        map =3D NULL;
> >>>>> +        ret =3D false;
> >>>>> +#if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
> >>>>> +        if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> >>>>> +                                    res->blob_size, &local_err)) {
> >>>>> +            ret =3D true;
> >>>>> +        } else {
> >>>>> +            error_report_err(*errp);
> >>>>> +            *errp =3D NULL;
> >>>>> +        }
> >>>>> +#endif
> >>>>> +        error_propagate(errp, local_err);
> >>>>>         }
> >>>>>         res->remapped =3D map;
> >>>>> -    return true;
> >>>>> +    return ret;
> >>>>>     }
> >>>>>
> >>>>>     static void virtio_gpu_destroy_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>> @@ -145,8 +179,10 @@ void virtio_gpu_init_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>>             pdata =3D res->iov[0].iov_base;
> >>>>>         } else {
> >>>>>             if (!virtio_gpu_create_udmabuf(res, &local_err)) {
> >>>>
> >>>> virtio_gpu_create_udmabuf() will log "Could not find valid
> ramblock"
> >>>> even for VFIO, which shouldn't happen.
> >>> AFAICS, it won't log a failure here because rb->fd is valid in the VF=
IO
> >> case
> >>> especially after 8cfaf22668 ("Create dmabuf for PCI BAR per region").
> >>> The failure would occur in UDMABUF_CREATE_LIST IOCTL most likely
> >>> because rb->fd is not memfd in this case.
> >>
> >> It is still nice to ensure that the log will never be emitted in the
> >> VFIO case without relying on the internal behavior of the VFIO device
> >> code.
> > Ok, got it.
> >
> >>
> >>>
> >>>>
> >>>> This logic should look like as follows:
> >>>>
> >>>> virtio_gpu_create_udmabuf(res);
> >>>> if (it turned out the memory is incompatible with udmabuf) {
> >>>>        virtio_gpu_create_vfio_dmabuf(res);
> >>>>        if (it turned out the memory is not backed by VFIO) {
> >>>>            qemu_log_mask(LOG_GUEST_ERROR, "incompatible\n");
> >>>>            return;
> >>> I think this is mostly how I have it right now except that I am using
> >>> error_report_err() instead of qemu_log_mask(). Do you want me
> >>> to only use qemu_log_mask() when we cannot create a dmabuf via
> >>> udmabuf and vfio?
> >>
> >> More precisely, use LOG_GUEST_ERROR if and only if creating a DMA-
> >> BUF
> >> failed:
> >> - in *both* virtio_gpu_create_udmabuf() and
> >>     virtio_gpu_create_vfio_dmabuf()
> > Ok, but should we also set the 'Error *' when this failure occurs?
> >
> >> - and it is due to a guest's fault.
> > I think the only case where we can consider Guest is at fault is invali=
d
> rb/addr
> > (i.e, qemu_ram_block_from_host() returning NULL). Can we limit it to
> just this
> > particular case because in all other failure cases (for example,
> UDMABUF_CREATE_LIST
> > IOCTL failure), I don't see any obvious way to deduce whether Guest or
> Host
> > is at fault?
>=20
> We should assume that the guest is at fault. In general, when a feature
> is missing and the guest tries to use it (e.g., by accessing MMIO
> registers present only with the feature), there is a possibility that
> the user misconfigured the VM. But we just emit LOG_GUEST_ERROR for
> such
> cases.
>=20
> >
> >>
> >>> As you can see, I am using a mix of error_report_err() and
> >> qemu_log_mask()
> >>> after Cedric suggested to improve error handling by using 'Error *'.
> >>>
> >>> On a slightly different note, do you (or Cedric/anyone) know how to
> >>> properly include CONFIG_DEVICES header to fix the following error:
> >>> ../hw/display/virtio-gpu-dmabuf.c: In function
> >> 'virtio_gpu_create_vfio_dmabuf':
> >>> ../hw/display/virtio-gpu-dmabuf.c:35:13: error: attempt to use
> >> poisoned 'CONFIG_VIRTIO_GPU_VFIO_BLOB'
> >>>      35 | #if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
> >>>
> >>> Looks like I am missing some key detail as I have tried different thi=
ngs
> >> but
> >>> have not been able to fix this compilation error.
> >>
> >> I think you are supposed to add stubs. See hw/vfio/iommufd-stubs.c
> for
> >> example.
> > I have tried adding stubs following the example of:
> > cca621c782 ("intel_iommu_accel: Check for compatibility with
> IOMMUFD backed device when x-flts=3Don")
> > but it doesn't help. I still get the following errors:
>=20
> You are looking at the wrong example. It uses target-specific macros
> because intel_iommu_accel is specific to i386; virtio-gpu isn't. Refer
> to hw/vfio/iommufd-stubs.c, which I mentioned. For the user-side
> example, refer to migration/cpr.c.
>=20
> > In file included from ../hw/display/virtio-gpu-dmabuf.c:21:
> > /media/myvdi/build/git-libs-64/cedric_qemu/qemu/hw/display/virtio-
> gpu-vfio-dmabuf.h:14:10: error: '#include' expects '"FILENAME"' or
> '<FILENAME>'
> >     14 | #include CONFIG_DEVICES
> >        |          ^~~~~~~~~~~~~~
>=20
> CONFIG_DEVICES is a target-specific macro. Directly include the relevant
> header as migration/cpr.c includes hw/vfio/vfio-device.h.
>=20
> > /media/myvdi/build/git-libs-64/cedric_qemu/qemu/hw/display/virtio-
> gpu-vfio-dmabuf.h:16:8: error: attempt to use poisoned
> 'CONFIG_VIRTIO_GPU_VFIO_BLOB'
> >     16 | #ifdef CONFIG_VIRTIO_GPU_VFIO_BLOB
> >        |        ^
> > In file included from /media/myvdi/build/git-libs-
> 64/cedric_qemu/qemu/include/exec/poison.h:7,
> >                   from /media/myvdi/build/git-libs-
> 64/cedric_qemu/qemu/include/qemu/osdep.h:38,
> >                   from ../hw/display/virtio-gpu-dmabuf.c:14:
> > ./config-poison.h:233:20: note: poisoned here
> >    233 | #pragma GCC poison CONFIG_VIRTIO_GPU_VFIO_BLOB
>=20
> CONFIG_VIRTIO_GPU_VFIO_BLOB should be removed. It should always
> use the
> necessary symbols as migration/cpr.c always uses
> vmstate_cpr_vfio_devices.
Thank you very much for your suggestion. It now works as expected.
I'll send v7 shortly that would address your other feedback.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

