Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0AECA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 03:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGTeR-0006mM-Nw; Mon, 12 Oct 2026 23:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xGTeM-0006kf-N7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:58:02 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xGTeK-0007hG-DX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791863881; x=1823399881;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=N8vQA5+GY/R9knqZryiX5J2kbl1KcDj3wP/QMgpWlwY=;
 b=XDy1uc/MP3pYBBDXQV1XVMjf/p7Xmby3fXnBSewm3PPx/9Enz614KbaB
 XHcw3OjMog21Asw70WxgfPo64ZFb4roFMAmzFxZ1oW4deQDn3hqX5R5To
 0uyoBMnUddq6FCEwLLUrw1GZfv5p2xetJ7IyvOBKJZSfSD0uoF+bGV7/u
 n749A6X+hx4pE3LtMvjjqK+qkMGpRZS/Q9FLvI/A1JgAT5xJvlpyfA2NB
 7HYn42YMKGYMlKsSRTsrCTsq7kvBUoEyqBwwZIpF68I6RQr7eglFB163o
 VLHYpCjjOWDuVQg+SQ5TFroNyrKG3Gb05LeJwRGBursS8B+BXPV+Eannt Q==;
X-CSE-ConnectionGUID: oP7Wx3OMSZWE5IvAYMyBGA==
X-CSE-MsgGUID: 1KllQeGuSyeO3wWBq5e76A==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="467386"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="467386"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 20:57:56 -0700
X-CSE-ConnectionGUID: uEsGiWYcSVmvxGD6bmsqEw==
X-CSE-MsgGUID: dNlVgFkvRIy1wkrU9ht9uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1381481"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 20:57:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 20:57:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 20:57:39 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 20:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zS4cqGrSxP9S9WRH00Cx7p+u6xgFp7425d+QZFAQ1ku84ptli97L06v3WvWlPH5vE/vEtBMAZPmo4fLFg1ut3S7wlprHivXWLLAx9iwhXRMU1mtghHshWc4B8ibquV9K70Z0WzzGG3kUvGkKAENURU4R71tR0VX0uzKCeInojZbPROj8F9tMn85ywUN1Z0uAQuXDRWgDix3QkSQX7gc7Ni+U4l0/cUYr8jdlTSX6lr09hMLd5JC7xiLp6ruKQXGGCIKT0ru0DQwTu4+M+JLlfCYSP6aZ7bSvJjIWSm27QsB1XXDAyd/KoRgs0nn3g7g0TrHmFLSBX2V2MqGGKz6mQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvYll9E3OYDumV3NcD6YQJqX8L7sqpyzVSN6UeEqlOU=;
 b=stq4xIUMCGHBeEsWBONAHGPhJBDKrmeHYtglEaRzCo3c7BTz6FQxurS0GP5cTYZuVGsUJIiJDvseleYhB5F/qmK4Zn1FNR2IRWjZyQTSMjRs8pxbpnoj+74Aw+sCTYDdpFL32Wd52FqoYK0fIGw6NJ0MovzyhI6AjgfxoMnAa7anT1j9KKdC6D0xCB16NH/iumePUs3kQjrWOK1rrVNk2+2xKtW/Cg42j4T0rFZGJpHxgAPWxYFfeIMAN+jDXFAol1Y7MZoWXU9k6SJlEAcMeTdcF6jaut/A8jHeihE/T05baKdSufH6WQJjbKm/YG+NpqJvzIQC6Sh/tRxe1ZD93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 13 Oct
 2026 03:57:04 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%2]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 03:57:03 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHdVphjmjD/24Tm10GKCqp8WfcGzLbzXLIAgACjmZCAAPn1AIAD/qBAgAD+IYCAAGb1sA==
Date: Tue, 13 Oct 2026 03:57:03 +0000
Message-ID: <CH3PR11MB717792F00FF542E9CD83BDB9F89E2@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-10-vivek.kasireddy@intel.com>
 <b87b6288-4226-442e-8802-d9bf31f5a7dd@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71857E6DC18C3B4B74CE235EF8922@IA0PR11MB7185.namprd11.prod.outlook.com>
 <7bd99ac0-b126-43b4-870a-9211914a9701@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185E449EA1B948028DCD31EF89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3c5fa056-d696-42e5-96df-2d36a485e28f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3c5fa056-d696-42e5-96df-2d36a485e28f@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|SJ2PR11MB7546:EE_
x-ms-office365-filtering-correlation-id: 2559c16c-b76a-484f-2b54-08df28de0a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|11063799006|22082099003|5023799004|4143699003|6133799003|10067099003|56012099006|261009223027099003|38070700021;
x-microsoft-antispam-message-info: SXtRvbt1pBzmbHWuZuGphV+1pDCxtQ5IeJ6Hsz1u8iu7FiwJQNUxnmYS0mefhK+UXjMjvwgwlbwQ+C5uoPiBWAe1HIJF384TL6pFrok4Hk5jhI/Nghagfipu+jKw9gjwrBdKUD8uMWXPt8K/FC8C34cC1r+mxvqM65utpaZP+Sm2smDbQoDyQPrrV+DDPOiHHJG9Ttu3USxeszs7Xsw3QueaH3ct3mD1qC9oMDC0iqJmEwnekdT6ZtxXwlLifEurovUTWKoTqORHS/9hyW9379h/KTRzkYJNhqNrws16uysiazzljAMyt9YHyW0lh+nOGqGiBk/YsI6el5NT8wtgy8G1bGB9asyBoi7UnSgm528MIG76dSnzWnaayVYGWrvHJg2gcrokKYMJaQyoJq9J/UY3KPuodHRqcefqINkQCveJFSyqKd65FwAUTs9TO6B85FYHNYC/xHK6Ntjcoh8WQmYuRS0dFYPl42MaqNl6tnhlujta4Es+h3Mr0MYZIpFSZQ6uoBOXsJFx+z7qwWJObs+TrPdRlfZmvNbxmaFiPE1A4y9e46RSyOyQiXYNwX/b2beSh6Z3K2IgdD/RiYbereeUEPoeZY5ZrsL65fNCYamD1NuY6Kp4kVp8pB6umhv89wvOGia6j0RxHPqJuw1m6V3v5jnMZTSzbE3UD8GPpGBHXq5rsYlo//ix4HEUe0rJRuiNLFz2Nr4qUGKQr94KsXsoSmzTkYheTkuj0304F7E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(11063799006)(22082099003)(5023799004)(4143699003)(6133799003)(10067099003)(56012099006)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qSeI9TnirFxiGQgR3xEt3FAMToda6oYWIQoSrKFIdDZb5Rj9s/oqVXBxKL?=
 =?iso-8859-1?Q?byU83/1VJf2OlKWY3MQC31v2z0mq4bydUPj6zfvEKXB76UC32I/j0W6veQ?=
 =?iso-8859-1?Q?WP+uoXVQAYnyuKQg+KDX8Ep1yuXG32QDgB/LoOJMgmGjJQ0/8LG2TnDKqw?=
 =?iso-8859-1?Q?UBTZeniIpa+aBJT291NS+e0xERnkAtg0ukl3Y7kdHCWlc9zZjWYobVzUUU?=
 =?iso-8859-1?Q?Ycp+PbcVv6AwNjw64V5EAk110o4HRFu57uUlIFWHj9Z5ktQQl0kRF7vyto?=
 =?iso-8859-1?Q?rEiKJ5f4/FzNdjzkh6+4IHhtINDuwR53MDeqf40WIEKEBW2/myjE999H3n?=
 =?iso-8859-1?Q?ECXQbqYEK9ZoDT2W2dqq+ULEzm6j3QokB/iYcnPeIgvO4Q9FNbBoiY+POg?=
 =?iso-8859-1?Q?IIjVSEyhMve+S/vQq/vIrxafq9cWTOY7rkKgN0eGjG+pWXLRgc7FSMh3q3?=
 =?iso-8859-1?Q?6jLHKg/6E++x4maSw/1u234uQChCYYCZMEkk9Lzs6OtIHH36P9E7bmFvT/?=
 =?iso-8859-1?Q?lnHuFOcwdrcEP1lBp7lInS+0QegXYcVHkhbtztaHQYIJqegoIdBSt+Meem?=
 =?iso-8859-1?Q?CakJZKwBi1JoWjho6cgZJ/UrWKba9HVlNAkD3613otqKh3nK/zW2B6eJP7?=
 =?iso-8859-1?Q?b7U7amo4Oppm0aeQlD1Nt6nJ7iFcC9/8xk1FeVqnASvMiVRlAcfUi7Qt7K?=
 =?iso-8859-1?Q?ocyDky2AqrIWroezLF2wRxhil7mjyJ0fXaewrQdpTEr3Wt3Ky8pTDVqoxW?=
 =?iso-8859-1?Q?uPINaYpEZpuKLolr4w5btIS0PEqTYQCeojZ0uKSu9aMbeH40Sl1El2VSXc?=
 =?iso-8859-1?Q?wmUmExWvrhPxgRvSkNVECFCINsE+/l32V0WEQGIvYZOOeUsNNMLhDYs0P1?=
 =?iso-8859-1?Q?qh0fT/rl3arQi6rdV3bq447uh3QqzqAlIhIsyUNvW0VT+2EwAmVkp3dAhC?=
 =?iso-8859-1?Q?JVK+7HTMmr4NkS2mtcWhNaag8SUDy8nZ6P0MJASx7jJ17sgf+L9oGnb7Bc?=
 =?iso-8859-1?Q?l9t8D7FZwF+4JChOizUWBhCePytlzSmE9Yas3+tJwVrfHy9/BAY3xievIe?=
 =?iso-8859-1?Q?jT0CxL3hw1G6HO9zJWc+yjxLq5vm5lggXgiK/D/gJ6Cr68Ns7NeJbLMKyq?=
 =?iso-8859-1?Q?LseV4w96OgGExM9+33PSrOy5uTHOgw0hp+F1+HpFa2SAcD5YT7TJuzhi6Y?=
 =?iso-8859-1?Q?Wm2KPU6GJoHQZisfQfng/OndHUHaZTvN7Qimry8YvduqLiTY9rzuVnJiyg?=
 =?iso-8859-1?Q?azfNiN9tZgbahb9yJGjiVH+rwvaccl4OsMEAy4NqfFPA1iUSPWY1og9Hfh?=
 =?iso-8859-1?Q?0bA0zPne6PSnycXiIs8D8XqGu3aYxxKgYDYUUwxwv1lshwPW3l2g2HAjcj?=
 =?iso-8859-1?Q?iwMQMuAVEuXUnfOU2lTLjCRmsBxPpWIfkZN4ZR6m/y8M+ckR/Lism8OA5F?=
 =?iso-8859-1?Q?KSBXcaCpzOhwJU8+s69Y+5MqCoIh57KYRJOfv3I9MuN/4e4fI00N6Hr52V?=
 =?iso-8859-1?Q?hs1dGkfm3Asf4LUW05dvUqrovdTYFDJoj98r2ABKdsOvqd4SjcB808STN1?=
 =?iso-8859-1?Q?70faHux4hgqC1uhwG7oHXP6nYvpb6CcpplkKcGxafDX5k/hA8PilZNUUr2?=
 =?iso-8859-1?Q?N4BceBok5b6OhyIWNEXETvCVEsmUnsOzaJzO6tG8a3AsmRXT6+jBTNcGqS?=
 =?iso-8859-1?Q?wfxCpO/yaZMdEGV7LJxqmCTVk9fjfrIfH+IhSDw1nSu8gPBQWb+vCE2xQL?=
 =?iso-8859-1?Q?jh7/Lm/RQemVzxPszH7/hLg+OM61CzMOFzSSG3lFYWUQ3/TkQI5EDjj/yU?=
 =?iso-8859-1?Q?OIq8lRMX8A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Zy7CBfB6HVmzxIbb6984vuyU5+qNxC2xl+cie/XNAg5JbhO1VbYd0XY0ztdUJfEgTIRdmwXusQklNsvKZerPlcfu1gFYgwuhkwykwzYF+pSDB526IfCMCheXGn2pq3UiYt12X8mPA/mPKsn+5hFPSoPXSzwDShg3n6/tJl0W3ZaljquZgv2GScvHFXd25vXp4QxuUFCE5qjARx1GJFdDqAylWlEu2ni6mrhBy7iWIe4Wc8jILsyf57cV0gzpl1MZGpCAwctjA5oxLSxKcMLrHmuzH4rA6Ybcv0c40ZBltj/y5JrDKYD9jQ3jlr4etzqccRDZxBMo3A1teWDIaOG1JA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2559c16c-b76a-484f-2b54-08df28de0a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 03:57:03.2624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUYSpIzxpaDab3jEZNmCoowHTbmVlz84qSENHsdioNd4v8TUGw4CSFX7OUzIT7y4Qam/6xAY73FtdxINdjoOkicUX1aOdgzF2gWLK9nAoX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7546
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

> Subject: Re: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> >>>
> >>>>> In addition to memfd, a blob resource can also have its backing
> >>>>> storage in a VFIO device region. Since, there is no effective way
> >>>>> to determine where the backing storage is located, we first try to
> >>>>> create a dmabuf assuming it is in memfd. If that fails, we try to
> >>>>> create a dmabuf assuming it is in VFIO device region.
> >>>>>
> >>>>> So, we first call virtio_gpu_create_udmabuf() to check if the
> blob's
> >>>>> backing storage is located in a memfd or not. If it is not, we
> invoke
> >>>>> the vfio_device_create_dmabuf_fd() API which identifies the right
> >>>>> VFIO device and eventually creates a dmabuf fd.
> >>>>>
> >>>>> Note that, for mmapping the dmabuf, we directly call mmap() if
> the
> >>>>> dmabuf fd was created via virtio_gpu_create_udmabuf() since we
> >>>> know
> >>>>> that the udmabuf driver supports mmap(). However, if the
> dmabuf
> >>>> was
> >>>>> created via vfio_device_create_dmabuf_fd(), we use the
> >>>>> vfio_device_mmap_dmabuf() API to get a mapping for the
> dmabuf.
> >>>>>
> >>>>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>>>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>>> Cc: Alex Williamson <alex@shazbot.org>
> >>>>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>>>> ---
> >>>>>     hw/display/virtio-gpu-dmabuf.c | 22 +++++++++++++++++++---
> >>>>>     1 file changed, 19 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-
> gpu-
> >>>> dmabuf.c
> >>>>> index c9de8e9ba3..f59a5e76ff 100644
> >>>>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>>>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>>>> @@ -153,9 +153,25 @@ bool virtio_gpu_init_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>>             if (res->dmabuf_fd =3D=3D
> >>>> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >>>>>                 error_free_or_abort(&local_err);
> >>>>>
> >>>>> -            qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> -                          "Cannot create dmabuf: incompatible
> memory\n");
> >>>>> -            return false;
> >>>>> +            res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(res-
> >iov,
> >>>>> +                                                          res->iov=
_cnt,
> >>>>> +                                                          &local_e=
rr);
> >>>>> +            if (res->dmabuf_fd =3D=3D
> >>>> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >>>>> +                error_free_or_abort(&local_err);
> >>>>> +                qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> +                              "Cannot create dmabuf: incompatible
> memory\n");
> >>>>> +                return false;
> >>>>> +            }
> >>>>> +
> >>>>> +            if (res->dmabuf_fd >=3D 0) {
> >>>>> +                pdata =3D vfio_device_mmap_dmabuf(res->iov, res-
> >iov_cnt,
> >>>>> +                                                &local_err);
> >>>>
> >>>> This maps the complete IOV size, while virtio_gpu_fini_dmabuf()
> >>>> unmaps
> >>>> only blob_size. Create and attach accept backing larger than the
> blob,
> >>>> so excess pages remain mapped after detach, unref or reset.
> >>> Good catch. I'll add a check in virtio_gpu_fini_dmabuf() to
> determine if
> >>> IOV size > blob_size, then do munmap(res->remapped, IOV size);
> >>> I think this should be safe even if the mapping (created with mmap)
> >>> size is blob_size. Or, is there a better solution you can think of su=
ch
> as
> >>> tracking the exact mapping size in res object?
> >>
> >> Unmapping the IOV size is not safe if only blob_size was mapped:
> >> munmap() can also remove unrelated mappings in the excess range.
> > Ok, got it.
> >
> >>
> >> A cleaner fix is to update vfio_device_mmap_dmabuf() to take the
> size to
> >> map (or cap it to blob_size).
> > Currently, vfio_device_mmap_dmabuf() creates an IOV sized mapping,
> so it
> > is going to need extra logic to cap it to blob_size, which needs to be
> explicitly
> > passed in. So, are you ok with this given that you previously did not
> like the
> > idea of passing in blob_size as a parameter?
>=20
> Yes, I am fine with a mapping-length parameter for this purpose.
> I should have made the distinction clearer.
>=20
> Previously, total_size was required to equal the IOV size, adding
> blob-specific validation to the VFIO helper. That validation belongs
> in virtio-gpu.
>=20
> Here, the parameter specifies how much of the IOV to map, which can
> be less than its total size. That is a generic mapping operation;
> the helper does not need to know about blobs. We can name the
> parameter length and have virtio-gpu pass res->blob_size.
>=20
> The extra logic to stop at that length and shorten the final mapped
> segment as necessary is appropriate. This lets mapping and unmapping
> use the same length without additional tracking.
Ok, I'll make the change to have vfio_device_mmap_dmabuf() accept
a length parameter.=20

Thanks,
Vivek
>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >
> >> This keeps it symmetric with the udmabuf
> >> path and allows virtio_gpu_fini_dmabuf() to continue unmapping
> >> blob_size
> >> without needing extra tracking variables.
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Thanks,
> >>> Vivek
> >>>>
> >>>> Regards,
> >>>> Akihiko Odaki
> >>>>
> >>>>> +                if (!pdata) {
> >>>>> +                    virtio_gpu_fini_dmabuf(res);
> >>>>> +                }
> >>>>> +            } else {
> >>>>> +                res->dmabuf_fd =3D -1;
> >>>>> +            }
> >>>>>             } else if (res->dmabuf_fd >=3D 0) {
> >>>>>                 pdata =3D virtio_gpu_remap_dmabuf(res, &local_err);
> >>>>>                 if (!pdata) {
> >>>
> >

