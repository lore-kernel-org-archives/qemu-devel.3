Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F4FC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 03:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGs61-0001Cm-L4; Mon, 10 Jun 2024 23:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs5z-0001Bv-MI; Mon, 10 Jun 2024 23:22:51 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs5w-0006Wz-H2; Mon, 10 Jun 2024 23:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718076169; x=1749612169;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WvNjWp5HkIC2Y4+7O5hn5EJ3xy04cpTPpS2jZ+3iIcA=;
 b=GmOftZthsO7LeDs99dTNe7a/XVTH2irGTgG/x9eV+pT8/uevoTSf97K0
 /pQo8llI5SxqmAEMbvgQb/MvhhO5wc1OZ5l+hr6XHBw75ngqnBpTDMnKK
 BJctAJbrluYy8piXl9FjKnh/d6LQdgQ1f1Y7mA4GG1sKzmStbR5d8LU+d
 B5E4AVQQM0XnC3DI4FBo8gyxgN2FFDjbZyS1DqmqlsVizfcpZF919sRsL
 NMXJH6ZLf1GVbaRLBJ1eukaZMud1GTpTQCk5SUYyLDLxXQNK+E+uMRoHJ
 9kt/HzOh0Lr2psJhgwbit2e4ubMt6rqO/GWvdwLv9/t02S0kluTCPqbOd A==;
X-CSE-ConnectionGUID: nMRGxVGMShimK0mopA3kKg==
X-CSE-MsgGUID: ebYTuJO3TbiWb+x+TYlhCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32249887"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="32249887"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 20:22:45 -0700
X-CSE-ConnectionGUID: 8kk+0d+3Q+6Wa7MCclq39A==
X-CSE-MsgGUID: dpb1eKALQ4S6eoBO6F3Gnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="39843866"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jun 2024 20:22:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 20:22:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 20:22:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 20:22:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjYnoR5wG5daDPcn+Qx0IX6Eks4cIjgpU1qF2budw3wQ+IUKNnTaTli3lDeItFfTtcL7YLcA9C6WTldHYqNJebU4j9ac8tCXnHNZZn7HmAf4yn4tSdQhi5KZZrENBRx/BnEjAFEnYUxJgJIvXLOm8V5zInm1EvehrEW0iE5M8GFZwAROEB7pF23YEJf5JyFvCrKfhpuvDFhn5wV2Uy+FrwGindJeUvsFwCwluz55yPS/CdoFK2i8K1Pqx8/hXqBqAn4GFLCZt7Jm0EHexYIZz2ZhLEuoz0RF98AfrAECOYyXMSvtS4lZYAgYMNQ59mCQMJYBAPGPWjHzdQ3gIOx37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUjpKP+y5/CaoDvR0mMrrcJ6NZEgyNAjXDCVEcgxDYI=;
 b=CYgJFdTF0UTEXpb3pNtiOmoSiJubdEcHqk/sVqQa/lhbJe6pd0OBv29J3rPh82vcrO+7a8i78FSlJWqsfP8tcMpRzb2BGAsjLyejmwg+d2VN2z8Y2uW77aIagdngCkzueq6czfYkljPt7nadnCho9vpJbQZTHrHuzqlDbAJsQoN64zoTV9uH4iWSt5iUFAFnshG8zmoMcxR04eGJjFivcuwleP9fOStG8srlgGzsexYUrMjlOdhMWYC7zun8qmAMx2ypa8fnynugaLXTLa5jx13RBw0jjfebkZOakXVRHNMjrVIGcNdecylRxPsNGnQr3qyqNNZxRaZpZFZZd773+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:22:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:22:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [RFC v2 1/7] HostIOMMUDevice: Store the VFIO/VDPA agent
Thread-Topic: [RFC v2 1/7] HostIOMMUDevice: Store the VFIO/VDPA agent
Thread-Index: AQHauOiG0IqKm1eT40Owsp5StCp+K7HB6y6A
Date: Tue, 11 Jun 2024 03:22:40 +0000
Message-ID: <SJ0PR11MB6744419244FE6E8A85462C0C92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-2-eric.auger@redhat.com>
In-Reply-To: <20240607143905.765133-2-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5238:EE_
x-ms-office365-filtering-correlation-id: b3709ac3-8ba1-4ec3-9e14-08dc89c5c05e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|366007|376005|921011|38070700009; 
x-microsoft-antispam-message-info: =?us-ascii?Q?33MgHeW0oSc0grNoBE8nZfXSEN4+xodC0vMVH0nVohpsilcQi86g/rmpWzQ1?=
 =?us-ascii?Q?7QSmP0ZwpI8r0oUOZ0AiW0MscecGm3S4z2zd5QWIll3+hrufeFqjGLzlF80Z?=
 =?us-ascii?Q?TEScJNfPdeZLNmAnBNw6KLsgRAV9alu7dtDCSUd22P/mdQtICDFfyzUzv8M9?=
 =?us-ascii?Q?2XGvLXKZyqJ9iln7s3/fQ4PjQevEtF1PIOZMYMXB7pVb3qdnBAa+xFBeTD7O?=
 =?us-ascii?Q?tdUu0m+PIvic6CfuxI69I0uROLc0Zt9ztxGsSP+dH91cxUwdK/fKjw4WJ2NO?=
 =?us-ascii?Q?q0XRDLNHpLFBeGJu5idhAvdRZSGYxnTOsYujZY5YP6hzuA889l3GLoFNfy+c?=
 =?us-ascii?Q?K2BOnSOyEfEzJRBo7zF/osOCSF1Oqhy0C490bRSankQm2uP9v6SejrQhb0jB?=
 =?us-ascii?Q?Mmb7QayX2zpYtCq+9Kf1D7eIQKkKbplo3RKpLIxOW4LVaPL6A2oCz5j5evfX?=
 =?us-ascii?Q?hJAAtZIFpNxnwf1sMX3jUboMNaYtUlQ18UA0r+InAtOWzviYWSSUD2VEWw9D?=
 =?us-ascii?Q?t41eePKV2jrVg6mdWVGHUh1cmcSvSvyvcIHX2BnpQTOL1Kaxhv58PtWB+I0T?=
 =?us-ascii?Q?qBiKILRxzoV68Pf/N3QtsPiV/QZ7xCxhV/2tUUwatujGlaQEMWME6Xf4nNZb?=
 =?us-ascii?Q?HxWXFZcG8X1WxZNVmGYQDfIVV2d4iX6uMNCb/pN0SWwrv8wPsp1Et28ksYLY?=
 =?us-ascii?Q?8cqWv/CZukkraluJkx6o16my9kFhwKu5AHZtg2vjKbj7YWRdJQMThE+AwZRv?=
 =?us-ascii?Q?z9btcGSnWjeiaquIbULMLiqYgbIj+Z5BdK6Jwo5O9VbO1JOP6F29Dxl82lMi?=
 =?us-ascii?Q?rNYOC6uven0DJpFhI22/dHgsSSTpVphnRcdTgvs9bQrokLnq8w1GfMZv+DCx?=
 =?us-ascii?Q?cirLpVqVPpua8TSlXAqGj4b2orOyOe9+J7X9k60mY1btXl6eVWGBO9Q8GqLc?=
 =?us-ascii?Q?5mSndYkcholuxlTrbex/kLeWzSr0E4gXG1bxLVgYUZMsc2yqYCORf1FfWyIJ?=
 =?us-ascii?Q?QYGhXnt0xvNIas8zY3JgiJrBXsOSGbnPrLIyG4i1PPiN3vOd0kcTHFresw8j?=
 =?us-ascii?Q?272u1NfOE7WhuCt2BCgShQ5+Cm/2KXdzo5BIpuZfpwSXXtLQHesYY61RxSIm?=
 =?us-ascii?Q?b97rAaassbQIoI9//Xwv1zuS8TjW1up3WO3zu+FPBDQqKFWiUe6gJMxcYGGT?=
 =?us-ascii?Q?PBmAvglYzD4+i18YFNJ/8US+WLjEn9JaLWsJa1+bdcx1ULJeaKg272PMrPII?=
 =?us-ascii?Q?qfdrwGUp9QcCr/PZ2C3reTGGBUKuq/c9fmSqnJGuNfROmNg0soD3yaIVpamD?=
 =?us-ascii?Q?uocPxGJec46fdaVcYLO3Sk+XZqzoXZDU97S/WsqY5/W5NTjpFF5wy0rd9rnl?=
 =?us-ascii?Q?i+ia9yXsgbaoYSGVNtyioXfVnG2L?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005)(921011)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1YO5qzVkbZrZvKT2DZrORBsem9dkeNleFSpyAkKoHZFzC4PT2lgAsWnVKE88?=
 =?us-ascii?Q?b2/YaOW9C9qR6V+g4gEiUGIKXFZD8jofw7O90nJ/hhvb3tAkNf9KWftLLUpI?=
 =?us-ascii?Q?xnGoISHfwuXvpzmRC+5FzfSH8Lch2UTg1FHC4/9oP3QM7EW6r4DfyDKECK99?=
 =?us-ascii?Q?qaTkT6cCT3nq9+3WwDRm78Nalv38x3Zo1ZGKNGYOYBvBQaTIeM1lu5PwNEQg?=
 =?us-ascii?Q?JZp/8rbJRgN2e/QA4HtxCLHo76yeC3SzTAUHHG2t72FcW4HmBBFw6zhqSUgr?=
 =?us-ascii?Q?pZl991pFJa9bPjQOfyneoCyEgUri34o1LKZ/qcAoIxLSvWl6JV9iJN2fOvdy?=
 =?us-ascii?Q?brCh3hV6vZU9BBzxkLKdTh7JMtbbUKV/9d8FgdxQkSbcJsXoMmQIg9HwWeNy?=
 =?us-ascii?Q?U47+TxG4pStyQOg9yUc2zYp7+AXlhAsx7KvKOASLyd4pxQEeMqREnmuQWWZF?=
 =?us-ascii?Q?co/KAhikgas82dykO/W9nFP9d4vzqzk1xRhVAn39sqcd0xBcYqQ6NYc2kTdf?=
 =?us-ascii?Q?d2AKmTHsmrfv4iq5a3OMVhFoVpQOhycdv2uhbHrfPyFTfCuEErCKLrIkthOV?=
 =?us-ascii?Q?Ytme4OVPE5EPzt+jVTpEjKn5Dk4LO3qNQZlI8V05xdLPVtR4nfVSuQYl7pU7?=
 =?us-ascii?Q?PjoXfUmOkFKrrkzOFFR4lbdyRqFTfx0/hp71lu39egweVQgM7irKvRf3xPiZ?=
 =?us-ascii?Q?fAXDaCvyWuCuMivIqGcs5joodigz6aulw5JubrTcIoZQaCVC1JDjdX7HrH3b?=
 =?us-ascii?Q?JfTacR17/KCXgDi/162Z72sLtBXBKKTLGve/rP1ZKE8FJHAAEec3DQB0k1s7?=
 =?us-ascii?Q?rkck1qrUgJHxUQ/lPMJMHEnsP04iC/UyU3YWLlBMOJml3orIp3X96afZdafo?=
 =?us-ascii?Q?GanTTpAm/QrL4jYu4AK0/+4IByTZKNin7XtdQ3Sx/QVew06sfSTFbUZyWr15?=
 =?us-ascii?Q?U/ymTJkgJ7BEy5a9JF+33MLuG4zXD1Eu2utHAgYQ7ztouB7IurkL6aMYVMtV?=
 =?us-ascii?Q?ZC7gaQFM/pKUkd8Kkn6jNNsx7i1meRZaVVxFXPD6Smiil+r5M+r87iGbJ0Ha?=
 =?us-ascii?Q?g5I0taydC0Tz/qpANlZF9kt9GmoQyO6Q6ik+p1rvXgsrtd6YjNnhMxpeKeO3?=
 =?us-ascii?Q?4U7PY4PU9vIBCRRuG6htGNeINwZjMjfcBVwRSzLtWjSnJNsaf7sX7mO9m57m?=
 =?us-ascii?Q?sOeEqzi4nMcw750EPxdkQ4xh4iroocnFmVHg4LEYyHKRTEG/hD/G2apylByK?=
 =?us-ascii?Q?mV8WM4SmLG2uaNUMEPKHyBBRWFd9g0fVg8rPQ3MRc7AvsNLViak7r17zAmBB?=
 =?us-ascii?Q?v+mZ/5Kp7TciLDMrstvazTtz6a8wkKaEvcrnOXhCaOVGxQarfVuUm8Ej5ndW?=
 =?us-ascii?Q?XlGll3/rwQkR4eCToI7tIK9BOMIbHEcmpKFDCb9hO+7l53POZilK/jsNuMYW?=
 =?us-ascii?Q?BsQwWbw693r9wf8q//ANqhCya6cLwnXiA+ORngGDQyuR9I+ssWME5HpI104P?=
 =?us-ascii?Q?L5RmIstX7Pb+mych48SyDFqIjWOq8SSrNfxcRtSI4Fs7j2txDVYyd3IUeeuB?=
 =?us-ascii?Q?94FoJkMt/vA54ZJleDqBs0Za9JZhEK9NwUaWcY1A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3709ac3-8ba1-4ec3-9e14-08dc89c5c05e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 03:22:40.8589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkHOYlKBfFxqtYO+AgMIE3kJHaW4abFcNb7yL+pTKkuepArbPQy2LYRrQC1m5iE1pwMxaYhpldiSJih7p4pfFBDaPhCWUY+okGSFtqLDM6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [RFC v2 1/7] HostIOMMUDevice: Store the VFIO/VDPA agent
>
>Store the agent device (VFIO or VDPA) in the host IOMMU device.
>This will allow easy access to some of its resources.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>=20

Thanks
Zhenzhong

> include/sysemu/host_iommu_device.h | 1 +
> hw/vfio/container.c                | 1 +
> hw/vfio/iommufd.c                  | 2 ++
> 3 files changed, 4 insertions(+)
>
>diff --git a/include/sysemu/host_iommu_device.h
>b/include/sysemu/host_iommu_device.h
>index a57873958b..3e5f058e7b 100644
>--- a/include/sysemu/host_iommu_device.h
>+++ b/include/sysemu/host_iommu_device.h
>@@ -34,6 +34,7 @@ struct HostIOMMUDevice {
>     Object parent_obj;
>
>     char *name;
>+    void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
>     HostIOMMUDeviceCaps caps;
> };
>
>diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>index 26e6f7fb4f..b728b978a2 100644
>--- a/hw/vfio/container.c
>+++ b/hw/vfio/container.c
>@@ -1145,6 +1145,7 @@ static bool
>hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>
>     hiod->name =3D g_strdup(vdev->name);
>     hiod->caps.aw_bits =3D vfio_device_get_aw_bits(vdev);
>+    hiod->agent =3D opaque;
>
>     return true;
> }
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 409ed3dcc9..dbdae1adbb 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -631,6 +631,8 @@ static bool
>hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>         struct iommu_hw_info_vtd vtd;
>     } data;
>
>+    hiod->agent =3D opaque;
>+
>     if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>                                          &type, &data, sizeof(data), errp=
)) {
>         return false;
>--
>2.41.0


