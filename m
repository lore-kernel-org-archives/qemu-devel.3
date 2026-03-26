Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553FD109E557
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 05:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5dgi-0002Xj-Se; Thu, 26 Mar 2026 01:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w5dgh-0002XZ-4T
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 01:55:23 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w5dge-0007vj-OC
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 01:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774504521; x=1806040521;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jGee6E8hCSwrHuMO+ljG/gPDl3In3KzISM0klbgyhsY=;
 b=CK7YgFNMTJj1PXz/wwYL+IJRaLZbrci5jgmZe96LtvnMtVwRHSLOkSNJ
 0cgAHaT7UGKuEJtTccuryvNvq1NvDOKKKMTGtXyq+5/vm1QTW8+nwWkuJ
 iAlpk8i5el9On3IyVXPuUvAKnpd+JotslIwA0t2OMaXDJZcpqQ9fgSSZT
 sWATj8sFmoEPqVdIkq3EzbMZitgmjbyGZk+G1/jFt0bLD6RdHPD4+lWnr
 nwHB43u0thX6EwbezZq6TRBQTUezAMBef+hEZ8w0wKZxKUC0bxJqkPwV9
 poKCJkxL3bqBcV1eXxDsP5818CDrV6IpXT1nu6kpzvnw2l4uatQsN9XcZ g==;
X-CSE-ConnectionGUID: InpAxGyJQiuJ0YZ+xzQjsQ==
X-CSE-MsgGUID: tnrBtV1BSD6ms1FDN9Ib0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87031549"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="87031549"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 22:55:14 -0700
X-CSE-ConnectionGUID: s4HqASsbQzq+ZWbj+w8lKg==
X-CSE-MsgGUID: cG3pT1ItQVmS3In5277Nqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="221586696"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 22:54:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 22:54:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 22:54:58 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.37)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 22:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT9XexKNoDaoyqJLt3OkyYLH0tjL4bD4/sK/6vCnxjeFWrG661iRngvTo9AoEt9LDyEdB6dWCL6ogclf4oqAMhSOe0Pes00hNLAr5Q92ZpLkJNmA8bOwTdgDcL7u5qUFHSTbV7SJGt21jLDMcXidAx0YCuDTiPpyNynt3PBmiuu8JUnMv+ZgBjy4P2Xkt0rviNR3ZrFQLh7RrZEaXq0ggxNjQUklSNBvbRpuKcdHxNwtNUgauUPR+ZGLBanY58TE2DrP/+POEle2ByeU7NIgSuIwgUSUbm6WyqeRT89so8KNh820eBvIE6PnXosbzt0l0mTRKBunsSlwVn8CIqpADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkly8Rc//m7UUl1izO3no0uAboZPo5QMIJVcyMkqmog=;
 b=FXQId63fL3h6diTPG2BOzVuunNBGSLdkxxwg+yjX1+EDqQXV6MfUL+cPo3Wbu5jjHhQMI8tMVAof7z5dqpFTy7U3fWNgd5TIIHrWNw+EBcQRFFqlv8Ho5XLq5SF/40/Alz223ERUQSbH85ue/m6nq60T4TntH3JeC41gPylVuNOqljisL9VT8C0ig29ELWrrkjawBWrhWDstj2Jjj00sLUumsxsyHr/0cKz31cjJfbcOLrGXLXh2Q4s4X6S3OE6fHicTyzdE4z+hoWdvhS9h+QWhXLRLX2XFQNgNhH92HlBkg1Zcz71ZJXh/hkmRNvR0tH03Qr15HLpF8LagnPe5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by BL1PR11MB6050.namprd11.prod.outlook.com (2603:10b6:208:392::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 05:54:56 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 05:54:56 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Topic: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Index: AQHct2CBd1EkLKy70EmTrlWjg/HgLrW8bKeAgAANlYCAAO/SgIAAuJ2ggADRFQCAAKnY8A==
Date: Thu, 26 Mar 2026 05:54:56 +0000
Message-ID: <CH3PR11MB71779911F01B3FF646043ABEF856A@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-10-vivek.kasireddy@intel.com>
 <a112aab0-df42-47b6-a5de-f6827321c8d5@redhat.com>
 <IA0PR11MB718579B3F8EFCB2C2E2D1E93F848A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3434becb-639b-435d-a36a-71b5a3760ba2@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71851F5FD322F30FAD53D1F4F849A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|BL1PR11MB6050:EE_
x-ms-office365-filtering-correlation-id: 0226df71-3953-48bc-ee1c-08de8afc354f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: bEZylWwU798UWS0F6whTwHZ3pOS+1a4cK770RV2Q2sUcG3cHSF7uD59LlZCdIWsrR3/18udkGKniaU13fiJons1DqDdl3JYRDViG0QB2VGc3mKfEPAQGiXyU/pJw95aW6pf0w4vqOuS57C3z2hxqiF6eRJuEqq4X/Pjg9AcFMjqy6lPYQkzIJIzPP0/l+tQhdZvUUdVQzlnvef8ptaY8UbeMK4U2DrmSMxs4HeLAlcCsm0V1HHNeKNcZyWZZ0miLx4Ae6XWgwWvLc0i0Gr3s99Zc8qlzz8bTtvRyIw2fGmpnRk0WO3T3+5QHQpFUWzZG4uR630KFGNbXBinadh3MDrLOIO2rnMtcGZgqiSQbSHTgsFVdhdp8CEu6tuzRQUojt+SoW8wh7t1NJivDKalSHuGoH4TD/EkpWjs3CrcJaDM6w2sHIKiLh7oPov7c6VkBi0sErqnZN9jD+L96K4JN+/XGKEkHn6pFvimeM5wi+km37ZadkAIur0OWJ5A3kWgTof2uEwQREAYSF1pMlp3842L+n82p3TAg7gMQIY4iknCIEjJHYtfVh4EYP/OJen9XeHaHXFdK7VFthpCl7Fv7om5h3tq0h9kY8w8kmZSTauAgVWhxIPmDDimIOgswnOWR2gjl+WprlIdWr1/24mo9CsG1f2pvcoBeZmV+cNcqGANgezzrWcrSLA3hQvWl8YQf7gUK8S+8z7g9iCZfLshzCfxnR/zM4Zl101qrK1ztFdwS20aZ/b7RvGYPLmxZcFdz1mFLZc00rWv8rewFbdzcpRELzXpaPoplkqT/aMIbKlw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?opTZISih21XrvRVKRospL4YM2d88E9yfWpxrNwbPHNadE6yxSbiEK0c9+1?=
 =?iso-8859-1?Q?Va7JdCxU7fguth9tb1CSRuZ+IRkV23q6AKXoqU9QOkU+kBHeshk/JWZ4tl?=
 =?iso-8859-1?Q?A854Icqa01dCWU7RvikWiSiSPUUfqXw8lUY6j0+TFcGQmCX9JR7v2Rgd/S?=
 =?iso-8859-1?Q?6m3wdlR24ONvLmHbELssuwUDRqEF5xOhl378mvgknwkj/ul9BcICbV4Mh9?=
 =?iso-8859-1?Q?dVS2BrOJMkdrF8aF3mf6RDZrYmy6D09Vt+d7pbo/gUFkvC9prm6cH442gQ?=
 =?iso-8859-1?Q?JCVXQSXOa54u8eKMbquMcUEJcMT1qX0dLGZUmvo+F3JfCtyAKCipKxYt3d?=
 =?iso-8859-1?Q?Rsgf4NeDanUd1ZLEg9sagjA+qjZiIAWrzfciHAMeLmlcxG64wkpGxrqawX?=
 =?iso-8859-1?Q?Zqc4nTUBPgi1MIgrEsvlQGED/7mXMiEVCUnjFk6Li1iWSuVHg6Ei649pY7?=
 =?iso-8859-1?Q?EaDMx7hFvv7Ifmlfw5/bwL7u2BRo7gmIG3oEk2h5tfq2fY9pawawc0FHOG?=
 =?iso-8859-1?Q?0pvZHXOl7sPV/LqJBFXrJpY9x2i6lfXPohwSe2zSWS7DWAUxR47m605BSI?=
 =?iso-8859-1?Q?ENj7VXxkBZqF1IevhBvGgY/huniVX4fO7qMsruXCepXtc5YybaQE8TUM3k?=
 =?iso-8859-1?Q?eYXjp1BSMRq8G1gMidqFT99g2buy2kHsviQcHg84ucUgGyglDnakTMmr5k?=
 =?iso-8859-1?Q?7cWU9Cgw1TmJy/SumuzNERKjl8NM7fbbGUAWxDEdrr/vXw7g9KF2bapdgr?=
 =?iso-8859-1?Q?TMRlDV47TZt5/oMaXyviXQnz711MK9ZHcqGHMYGsHJlHHEXguDR5tKhtj6?=
 =?iso-8859-1?Q?n7N0CFFwQ1TFrkrotQ+Dp45bzM/Vg2rXoS6Lhn+hIkTaQoOrZevNQKWAqW?=
 =?iso-8859-1?Q?49IclHIVnPpFXtII4T/62Icn44IdDxqsrOe76fqqQUZggAfcqrqaugE7d5?=
 =?iso-8859-1?Q?AmejD33TJwUf9jECdAbqbSWUcQEeZSjxOhTeyuIgVyi1OQ6pi1cYYKwJph?=
 =?iso-8859-1?Q?rgJTT4ZCW9yLeQEoyj/9NM+5wkHZvdse8WDBAN21I3dyu1RMSX4TrKO6hq?=
 =?iso-8859-1?Q?AVDR3T9p4H6/fpddMS/msXAtz79s6GHGu4T5xXGI59FVtAbX9YowYNq8bO?=
 =?iso-8859-1?Q?/gZD0zrVQRno1EwsOn4LeqVJCSG0Et5g42PWb+J76MLjMciGrDuGk+IAvM?=
 =?iso-8859-1?Q?ws/BgOast1Xy79sy/ax8uMKKqR/dCRNcIGwqNW/fviaZLjp8a3JTV47Clc?=
 =?iso-8859-1?Q?fV7Z1BqpyeyEY4WY5lj0eH8sEXF+0jfwuzgnhcL98M3tD3Yoij3MBc4M06?=
 =?iso-8859-1?Q?72aif1f9T4G1rHb4VvokopJBxSdyAQK5orThSHeDI+J0R1V7UTKMWNdT2z?=
 =?iso-8859-1?Q?fyj3KZSr4zik2tOYKUpTDNKcEL8eE+AvheLLvX5w7PygzKa5jusjM2WvAF?=
 =?iso-8859-1?Q?KzqwTCE3YZQdjbEf7w8y2nCbJD7Tbxx1bbxsFGE+4ff7Qv23tEXnUedNrC?=
 =?iso-8859-1?Q?Bg7PFWggE6PMUc9RkaQX8bc/DmuuxK6rOAH/F9ICE6Ba0dYlj1/q0nIIPy?=
 =?iso-8859-1?Q?rzj563nhJhuFvk3csGr3RLAPDIkOjqVGHNj25VyR63qCf1FqQ/H3Bp/Zfg?=
 =?iso-8859-1?Q?tdvdB/WxITMj2tjvemRH5SfJHuehBAMDRcMIPnnY2ar6hd2/ANLKJckW98?=
 =?iso-8859-1?Q?xtP7FH/aj1ZaFDR6CPwGEOI04KxQ2Pf3E628r35e2aNnmiHbLnxojOo4rU?=
 =?iso-8859-1?Q?7+M7ecc0mmPjTAYXD0uFnPQp11dAKATsIuSGOg1UDOb8VI8SfGK89yM2uf?=
 =?iso-8859-1?Q?4YH5CQQLvQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uLEwxcv6MDvL6h9LgVlmAG2itFWzfCs6mVx4qOU7/os5/2jhF69Dy4ePTUrht2JpTGvZRPmymxuXXepZW24QZy4w9dmqcf7i4+62/eWw11m7cGEtY5pnAYob0olrh/yu2OGsKnqz/S9vKXvJhJiFIwf2HNAJcy3YHOJEK7hu3DtuNWwNp+tRjxDDonZsqtnW28jGPKh3UtcojvRXg5zHdcJYylSgQBEIEY+YuaA6QAGsNTO+eY9Mhg0py14Nf5yWTzbKiNyibGt2CFcZGRpGtIhfu+8cD7n7EQCGU/nQ141snH2PUFoIdtbyEyUF1EbzIrkWwuGFRZDITr1VZpjx0g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0226df71-3953-48bc-ee1c-08de8afc354f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 05:54:56.3559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLWGzzahRTtmdysFrla0Kod7rEGZEwFIrQrqaSDkgOk6GBsAI3FEuLrJXbbdKzEmynx6ZDfSPphzP48QOYQMYxfReAU9v7dvPMb5qmiNOPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6050
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
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

> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling
> with 'Error **' and err enum
>=20
> >>>>
> >>>> On 3/19/26 06:15, Vivek Kasireddy wrote:
> >>>>> Make the error handling more robust in virtio_gpu_init_udmabuf()
> >>>>> by introducing 'Error **' parameter to capture errors and using
> >>>>> an enum from VFIO to categorize different errors. This allows for
> >>>>> better error reporting and handling of errors from
> >>>>> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
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
> >>>>>     hw/display/virtio-gpu-dmabuf.c | 67
> +++++++++++++++++++++++--
> >> -----
> >>>> ----
> >>>>>     1 file changed, 45 insertions(+), 22 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-
> gpu-
> >>>> dmabuf.c
> >>>>> index e35f7714a9..89aa487654 100644
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
> >>>>> @@ -27,16 +28,18 @@
> >>>>>     #include "standard-headers/linux/udmabuf.h"
> >>>>>     #include "standard-headers/drm/drm_fourcc.h"
> >>>>>
> >>>>> -static void virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>> +static int virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res,
> >>>>> +                                     Error **errp)
> >>>>>     {
> >>>>>         g_autofree struct udmabuf_create_list *list =3D NULL;
> >>>>>         RAMBlock *rb;
> >>>>>         ram_addr_t offset;
> >>>>> -    int udmabuf, i;
> >>>>> +    int udmabuf, i, fd;
> >>>>>
> >>>>>         udmabuf =3D udmabuf_fd();
> >>>>>         if (udmabuf < 0) {
> >>>>> -        return;
> >>>>> +        error_setg(errp, "udmabuf device not available or enabled"=
);
> >>>>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >>>>
> >>>> The function virtio_gpu_create_udmabuf() is returning
> >> VFIO_DMABUF_*
> >>>> enum
> >>>> values, which is problematic because the function creates a
> >> udmabuf,
> >>>> not
> >>>> a VFIO dmabuf.
> >>>>
> >>>> This creates a layering violation. The virtio-gpu-dmabuf code (which
> >>>> handles both udmabuf and VFIO dmabuf creation) is using error
> >> codes
> >>>> defined in the VFIO-specific header.
> >>
> >> The rationale of using error codes is as follows:
> >>
> >>   > In that case, using it for udmabuf is cheating, but I think it's f=
ine
> >>   > since it's locally-contained in virtio-gpu-dmabuf.c, its intent is
> >>   > still clear, and it has no adverse effect for users (at least ther=
e
> >>   > will be no bug).
> >>
> >> https://lore.kernel.org/qemu-devel/becde56b-90bd-40ca-9329-
> >> 0c92b9519a67@rsg.ci.i.u-tokyo.ac.jp/
> >>
> >>>>
> >>>> Please find another solution.
> >>> Other solutions I can think of are either move these error enums into
> >> virtio-gpu
> >>> (and disregard the error return type from vfio) or move them to some
> >> other header
> >>> where they are visible to both virtio-gpu and vfio. I'd like hear
> >> Akihiko's thoughts/
> >>> comments on how to proceed given that he had reviewed virtio-gpu
> >> patches in
> >>> this series.
> >>
> >> Disregarding the error conditions of VFIO is not OK. That can cause a
> >> guest error to be reported as a host error.
> >>
> >> I think the simplest alternative is just to have a duplicate enum for
> >> virtio-gpu.
> > That would address the layering violation but Cedric's other concern is
> > that he believes having errp is sufficient and using these error enums =
in
> > VFIO would be overkill.
>=20
> It would be beneficial to describe the rationale behind the enums; the
> patch message only says "better error reporting", which is quite
> insufficient.
>=20
> The rationale is that we need a special handling for the INVALID_IOV
> case. The INVALID_IOV case can happen in two cases:
> - The memory is backed by VFIO. It will result in the INVALID_IOV error
>    for the first attempt to use udmabuf, but this error can be properly
>    recovered by letting the VFIO code to create a DMA-BUF instead.
> - The memory is not backed by memfd nor VFIO. In this case, the error
>    is a guest's fault, so we should:
>    - Use qemu_log_mask(LOG_GUEST_ERROR, ...) instead of
>      error_report_err().
>    - Emit a message useful to diagnose the guest error, which we have
>      discussed in this thread.
>=20
> A common pattern is to return -errno to let the caller implement a
> special error handling, but in this case we specifically need to
> distinguish the INVALID_IOV case from the others and these enums are
> more convenient for this.
This definitely helps in understanding the reasoning behind why these error
enums are useful. Before submitting the next version (with the above ration=
ale
added), I'd like to wait and hear Cedric's thoughts/comments on whether
this is acceptable or not.

Thanks,
Vivek
>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >>
> >>>
> >>>>
> >>>>
> >>>>
> >>>>>         }
> >>>>>
> >>>>>         list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> >>>>> @@ -45,7 +48,8 @@ static void virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>>         for (i =3D 0; i < res->iov_cnt; i++) {
> >>>>>             rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, f=
alse,
> >>>> &offset);
> >>>>>             if (!rb || rb->fd < 0) {
> >>>>> -            return;
> >>>>> +            error_setg(errp, "IOV memory address incompatible with
> >>>> udmabuf ");
> >>>>> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> >>>>>             }
> >>>>>
> >>>>>             list->list[i].memfd  =3D rb->fd;
> >>>>> @@ -56,22 +60,28 @@ static void
> >> virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>>         list->count =3D res->iov_cnt;
> >>>>>         list->flags =3D UDMABUF_FLAGS_CLOEXEC;
> >>>>>
> >>>>> -    res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >>>>> -    if (res->dmabuf_fd < 0) {
> >>>>> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> >>>>> -                    strerror(errno));
> >>>>> +    fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >>>>> +    if (fd < 0) {
> >>>>> +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl
> >>>> failed");
> >>>>> +        if (errno =3D=3D EINVAL || errno =3D=3D EBADFD) {
> >>>>> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> >>>>> +        }
> >>>>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >>>>>         }
> >>>>> +    return fd;
> >>>>>     }
> >>>>>
> >>>>> -static void virtio_gpu_remap_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>> +static void *virtio_gpu_remap_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res,
> >>>>> +                                     Error **errp)
> >>>>>     {
> >>>>> -    res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >>>>> -                         MAP_SHARED, res->dmabuf_fd, 0);
> >>>>> -    if (res->remapped =3D=3D MAP_FAILED) {
> >>>>> -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> >>>>> -                    strerror(errno));
> >>>>> -        res->remapped =3D NULL;
> >>>>> +    void *map;
> >>>>> +
> >>>>> +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> >>>> res->dmabuf_fd, 0);
> >>>>> +    if (map =3D=3D MAP_FAILED) {
> >>>>> +        error_setg_errno(errp, errno, "dmabuf mmap failed");
> >>>>> +        return NULL;
> >>>>>         }
> >>>>> +    return map;
> >>>>>     }
> >>>>>
> >>>>>     static void virtio_gpu_destroy_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>> @@ -125,22 +135,35 @@ bool virtio_gpu_have_udmabuf(void)
> >>>>>
> >>>>>     void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> >> *res)
> >>>>>     {
> >>>>> +    Error *local_err =3D NULL;
> >>>>>         void *pdata =3D NULL;
> >>>>>
> >>>>> -    res->dmabuf_fd =3D -1;
> >>>>>         if (res->iov_cnt =3D=3D 1 &&
> >>>>>             res->iov[0].iov_len < 4096) {
> >>>>> +        res->dmabuf_fd =3D -1;
> >>>>>             pdata =3D res->iov[0].iov_base;
> >>>>>         } else {
> >>>>> -        virtio_gpu_create_udmabuf(res);
> >>>>> +        res->dmabuf_fd =3D virtio_gpu_create_udmabuf(res,
> >> &local_err);
> >>>>> +        if (res->dmabuf_fd =3D=3D
> >>>> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >>>>> +            error_free_or_abort(&local_err);
> >>>>
> >>>> Why not report the error in the QEMU log below ?
> >>> I think the idea is that in the case of INVALID_IOV error, it is suff=
icient
> >>> to just report that the Guest passed in incompatible memory
> >> addresses.
> >>> But I guess we could also just do:
> >>> qemu_log_mask(LOG_GUEST_ERROR, "%s\n",
> >> error_get_pretty(local_err));
> >>
> >> The error message may not be useful. e.g., "UDMABUF_CREATE_LIST:
> >> ioctl
> >> failed" does not tell what error the guest made and how to fix it.
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Thanks,
> >>> Vivek
> >>>>
> >>>>> +
> >>>>> +            qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> +                          "Cannot create dmabuf: incompatible memo=
ry\n");
> >>>>> +            return;
> >>>>> +        } else if (res->dmabuf_fd >=3D 0) {
> >>>>> +            pdata =3D virtio_gpu_remap_dmabuf(res, &local_err);
> >>>>> +            if (!pdata) {
> >>>>> +                virtio_gpu_destroy_dmabuf(res);
> >>>>> +            }
> >>>>> +        } else {
> >>>>> +            res->dmabuf_fd =3D -1;
> >>>>> +        }
> >>>>> +
> >>>>>             if (res->dmabuf_fd < 0) {
> >>>>> +            error_report_err(local_err);
> >>>>>                 return;
> >>>>>             }
> >>>>> -        virtio_gpu_remap_dmabuf(res);
> >>>>> -        if (!res->remapped) {
> >>>>> -            return;
> >>>>> -        }
> >>>>> -        pdata =3D res->remapped;
> >>>>> +        res->remapped =3D pdata;
> >>>>>         }
> >>>>>
> >>>>>         res->blob =3D pdata;
> >>>
> >


