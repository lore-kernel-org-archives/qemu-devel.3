Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E251EF532D4
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 05:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4uhs-0004i7-MT; Tue, 24 Mar 2026 01:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w4uhq-0004hk-Ps
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:53:34 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w4uho-0004FL-NH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774331613; x=1805867613;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yZOpMpFZLa0JMKx3VoOnvC5IyUjXRX//NLmDG+V9EnQ=;
 b=iaVPplQIDP4nU/S+HO4EWRmemCvJ24MKMLLNCne09sNQtrigN6UAUjbk
 MZ5bD0S7CeZM8u4gaS0SbeLUiOFR35FXtKMKU29Q3mkKf6afz+LSiGUN6
 /3q9picFTbnrXxX3ez1vaez7xWSFxBvHzZKS8PZZzEA7vHeFAIlFSeH4h
 IS5Ck2a9B7MXhjTggFW6VIi7EGZJhzTOMlcuMSU+7jds3iOP9e4hU3EPA
 lNIjicwi2IJFl5lMkp7H6ffD1Foi6Zqrtm9ykOGJ9HlCnja7LEgdTFY0O
 AHyWbw8l8Sqjw+INVYhWpSSxl01UkaDdcqzqRKDPiLncMTLLaMos9l6Ys Q==;
X-CSE-ConnectionGUID: EtmP7Pb6SzCJeakE3os1Bg==
X-CSE-MsgGUID: wdkRGeZNSuasTM3vSx2UCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74360887"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="74360887"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 22:53:31 -0700
X-CSE-ConnectionGUID: XBJCqdzIS3+MhM9XFzq2Rw==
X-CSE-MsgGUID: jWg1WBa/SdOaAy/F59P2ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="247899268"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 22:53:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 22:53:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 22:53:29 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 22:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzmwigCZeU9u5U+ruuh1g4kSpQBVglguonr8cb9WTbb+rrTPbYT8yONRkzcRIpDg0TlAcuUGSihuRdQw1m1K6Di+v1Y/UnTfBlVEgzu0h8wz8BiqVq+hwvmAw805Nfopny3B8e3ATwWVQ3zHy4kl5Ks2NNPeSEJR7OHFhxX7r7DciW28TWWlbCohnVDsVCs/9IriJ8ChBz4t7r0IZZ9f4tJ26E6ysJPPFPX/7Ycys/XctCweOMb5vbx9mCkytFeGWlviSYIKohqilTrpIMwIRnfjX85+t+N1TqbWFNSIimGDwCvU+Bb2wWwNMqN7wGGswFJHHKF5lHhZiPCt0QjCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOjvo9kTn/D05wJQ3AxJ6rZoE0mbBQ6keJiduVWBGwY=;
 b=dG1pm2XIP1Sc8UIjWDAhTl39cMOLbKi2NhzoO2yB14M+let5nYBv4XArGBOfN9nO+GbsZKDEqp/1rdCwohS5zlicyfM6WN3BSemSpX0gIKuYixnx8CExYdmGP/WMwRUB+JF1xMC1uWOadq3aLvDj9vqOaiLtwAA/KX9pFDJegXZGMLssBnGz2uDZpny40+UWqVk3cI2YR10+edpsEWkmGBn82XfvNjPPTsoj2qmsq/4CsQN1657qz942F7WL65Bk4SiUOwr5jSXtiiulAvNOEZ1+NtjvoIGcvkDx6swOgalnCTaCo3q6oHjecVb7LbzbTozsBoDyI84HsIUQsFKBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS4PPF25B1C4D24.namprd11.prod.outlook.com (2603:10b6:f:fc02::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Tue, 24 Mar
 2026 05:53:26 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 05:53:26 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Topic: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Index: AQHct2CBd1EkLKy70EmTrlWjg/HgLrW8bKeAgAANlYA=
Date: Tue, 24 Mar 2026 05:53:25 +0000
Message-ID: <IA0PR11MB718579B3F8EFCB2C2E2D1E93F848A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-10-vivek.kasireddy@intel.com>
 <a112aab0-df42-47b6-a5de-f6827321c8d5@redhat.com>
In-Reply-To: <a112aab0-df42-47b6-a5de-f6827321c8d5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS4PPF25B1C4D24:EE_
x-ms-office365-filtering-correlation-id: afb700dc-ebed-47f9-860b-08de8969aa9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: GvrQKvLTBMbQYMbwBQmOTexqXXwAwAPfyj95Wkr3BYwOJVDlCYuIUTetfcb0kJCK6GNwojhto1s8o1QeRRsA4aUA+bunB0em1KyLrcpjci4ifEAbXU46NX6xU6WK8L1dK6+1TDkmLG3rZ5Z6z2OEKG6h+UuHCYQEZLQy9jVbJxfXROfVmsQ4+GX9WfvFsi+SEvaO6jPgruuMM0Czs8+lgOg7eQSeATD5A7UxHV1coRKThFkQZU74TmJXiezEkc8sREuX36jGZAqDOJHmOu4UW7NqPXJ7uzuu2+/W62IQU4CQ36XLyM0rpopTQSyO7Fi+Tgk3TaV8ruuvAFHdEeFKDKJEivb5PYFy8ME126hWMFnVKf9FENKna+fMU1YJ2KXJaW1g5kHS/jGcby2PKsl00m1S85Ic9++wcWoY5R8SqQJ1HmQYzR2fYulO5yx7FtjyX2Z8JkVjfcsE7U/sxakm+Tp3Wahd8o5lMVeWqdueJmgaG3xwQqujiVU7FBYlz/cWYoMiMhsgWiwtkuGwoPZTq4CWcDplCEGgtdWI9bG6se0pmEbz0watscWaUqBe3OPKi45diahGsVOxNia+/PBCWdmhnqxEy5n8jRvWX0oe+86pp+9Jh0qsHlHDmLXx/pyHX4vZISf5WtPurF2mNBW1bFm/lvxpb9oIq7iD5Nv+RyJVKD8/tGfxxyRdJ4i3ulzWvoHSKLrsxKeqAbT4N2qzSp7OiU3zeixPfvJ9i3VA1+KvNFkIlHIoauREKRVlPYtWLhYNJfjCOm6E3tbiYusMDa6EILohFjiqAwe9/mW/8KY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?motN7wwkkuzqSuXPmRV+cRbI6Roz2lz2GhEGxIoLUcym5q1FnYksFUmlY/?=
 =?iso-8859-1?Q?DeLEqQINBId6bASwReZE2UTA0GrAbXQngngthAR7D5rXjVfxPUxIJuiga8?=
 =?iso-8859-1?Q?5qzYZhlW9aux4U5GLvszfKtV1djzcrbVOAy5ApUx40mt+gAAzqfzPsFNTT?=
 =?iso-8859-1?Q?xqoX8WwI15IKptDKw295PZ3Xc0UWIQeOyfmuajavcfflomiJn5Gtze/1i1?=
 =?iso-8859-1?Q?NT5O2ewQB/GoYzhFY8f/bPIejjw8+MfjG6NT2tuM6WneCUu6GDUQKzLEJb?=
 =?iso-8859-1?Q?wwVvazYFS5GBaI1e+/pA8OyFMi8Ce4h6UltLp16UR/DhnyY07jXQ0w5nWP?=
 =?iso-8859-1?Q?ibZpiT/QQtabQGe6f8Inh1yy7/4VQDRKgKa9B0wTV6hwcbA5Y0birMMCtm?=
 =?iso-8859-1?Q?Mw2OAtAZg1+l/z0pBvYNd60tDhhNCPLxZEPmU4IlJcTUCxfEEcrUTZyxnI?=
 =?iso-8859-1?Q?/EVB2Yr26IGZJd/VD0+JCqDlhPh6/YfueU/VDG9Sx8315chlGh0hb+tKaP?=
 =?iso-8859-1?Q?Aa/9ZXIjFPHTi1qBDJ3v5avLSUGQUaP3Xvq84v3JVFdKHwMBsvmXtXY92M?=
 =?iso-8859-1?Q?AnlxEQNNiw60y9ckanQphV37KAUnOo6uPlKJTHeB1ZU/mUdUsK52O5ToBP?=
 =?iso-8859-1?Q?FRMssJ3CKduBqiVVUylmVM+4jABm+fEMXXtjaTOq4IQsXmwZZ9rfV3Rl2S?=
 =?iso-8859-1?Q?XkFtl0kJDr/D24GBRqr8qGqi8FeAZGlpy0Z3Fr0X/AQKE8AlXmf1YInIO8?=
 =?iso-8859-1?Q?AuspsQCz7KZXLwalOBF/K4JVxxLKCJ06HZPKWAn5dq/X1dqyIkM897nAkg?=
 =?iso-8859-1?Q?rvZaRIRESKKFUspahM8zc388quFQNcjffAsXYFoKmX9xR+Vgn9Cf0HzivL?=
 =?iso-8859-1?Q?V1ckTu6pjBKxvIKDQQOsd4RJfvvyWYhnRlt8ODc/sby8XHnMwpzW7aG+X8?=
 =?iso-8859-1?Q?fLNtgevSRHRt15rTVfOHp6w8gl1F+tgR1ferGNMugniGYgM6vyafHVxGNu?=
 =?iso-8859-1?Q?DKTHQOVsy4WA6dUIBpF/r3WnauArhZfPBo4OuOgdzbhF/VBCQupbBwTe2j?=
 =?iso-8859-1?Q?lO5GVC6vE8v74oy/zp2WiRriyKB4Cy16ei0I33cy9yYhXrjsNcH9iw6Mbj?=
 =?iso-8859-1?Q?+1yEjvvO3ggYUUq0M3Pqmes5XK52pwliUC5XK2WxIpRaJf0kZJsJYY39UP?=
 =?iso-8859-1?Q?LfnehWJ2P01/8wuE4za3t+pLyNFww4+M7UzHBY6MSJHC8bPLwIAnbWhZ7C?=
 =?iso-8859-1?Q?ueTp/icfoiS+BJAfNoR1NU49jy0neiFvWTa7GqE+mi8A09nP1SkRM4T/vE?=
 =?iso-8859-1?Q?/4nZnXNrkdLm3mpOuDm+lr2WMXoUBI7Rgi+erbzVzoBC8sUbPYkLB0kUb3?=
 =?iso-8859-1?Q?yFGbUbRHldot0h2KzFNrd7bbFvJVCMMOqjqT74c/6EkkCkg84jl4x0MCKL?=
 =?iso-8859-1?Q?KECEjn419plINCND1XMPT+3SVDROV2s8pveeao/31ZksYTLBBChsscXYTG?=
 =?iso-8859-1?Q?SwV8wag4LMSklSLmGwxU4Gdc65IEZdCbBjv1tQn2PtttBPmhuJaXOI7RHc?=
 =?iso-8859-1?Q?oMIZS3RXXPAg/DF7Hsw62/poJb1AAkjh2YAvxn0tqYW4IlNDSXA5YYMdjS?=
 =?iso-8859-1?Q?yXdew3Ee427+nwt0oNzxDuGpkG9ampdQcyLjMDi5dif8pEUO1h/uxGytHv?=
 =?iso-8859-1?Q?ZOll7uA/n1z3yt1sy/x4JA6mBGQfwqffcy8qiOuOlxYm1yCRZ1FRn37GxE?=
 =?iso-8859-1?Q?WlAlFgQZKW3BVB4y3QzBS7Up71+wJ8JoifRBS39KXCmjRVm8O/iceT+R9V?=
 =?iso-8859-1?Q?0wRnamOkZw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Lj+CMhHsWCN9LmuoUH41ZcwBik2FvnCpMm31MZ66DgxBvQaR0gRE3g+G+UVMYQzOGQtOHvCFbciAu6Ey7Sk7r5I1P95nEcCLZrAG8NhknKiemcnVQXHaAtWl7uGnuNK8q+HNxRwU1ZL6unm0Kce6ym6VSCPP5G3vE3gIZBkyADiEf5RdBOF7SEUdrl/XSFrSYUzBcdr6oSJs7/FUONifZec2CWfLgADCmjim0wONzXkAApp3TDn1kWvdY/Q2O2uTl4G9P4E6wvIAYhfaXh0Yr1SzDzmydrZcNiMYhnhy2FblRUteAHXh4GqFoZDz33WjQ2AsK0cfKYefQhzN1Tyrhw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb700dc-ebed-47f9-860b-08de8969aa9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 05:53:25.9837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bPLwhIcH460z9tpLNzasuFQQmHvJl5PUAD+g/nSwTVrjp+EL0e9+uVNKvGhBd8QaNQWMANjSP6oR/UOc7v+yrEXwpp3Ab6DRIslxukAbiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF25B1C4D24
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
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

Hi Cedric,

> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error
> handling with 'Error **' and err enum
>=20
> On 3/19/26 06:15, Vivek Kasireddy wrote:
> > Make the error handling more robust in virtio_gpu_init_udmabuf()
> > by introducing 'Error **' parameter to capture errors and using
> > an enum from VFIO to categorize different errors. This allows for
> > better error reporting and handling of errors from
> > virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-dmabuf.c | 67 +++++++++++++++++++++++-------
> ----
> >   1 file changed, 45 insertions(+), 22 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index e35f7714a9..89aa487654 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -18,6 +18,7 @@
> >   #include "ui/console.h"
> >   #include "hw/virtio/virtio-gpu.h"
> >   #include "hw/virtio/virtio-gpu-pixman.h"
> > +#include "hw/vfio/vfio-device.h"
> >   #include "trace.h"
> >   #include "system/ramblock.h"
> >   #include "system/hostmem.h"
> > @@ -27,16 +28,18 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > -static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> > +static int virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res,
> > +                                     Error **errp)
> >   {
> >       g_autofree struct udmabuf_create_list *list =3D NULL;
> >       RAMBlock *rb;
> >       ram_addr_t offset;
> > -    int udmabuf, i;
> > +    int udmabuf, i, fd;
> >
> >       udmabuf =3D udmabuf_fd();
> >       if (udmabuf < 0) {
> > -        return;
> > +        error_setg(errp, "udmabuf device not available or enabled");
> > +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>=20
> The function virtio_gpu_create_udmabuf() is returning VFIO_DMABUF_*
> enum
> values, which is problematic because the function creates a udmabuf,
> not
> a VFIO dmabuf.
>=20
> This creates a layering violation. The virtio-gpu-dmabuf code (which
> handles both udmabuf and VFIO dmabuf creation) is using error codes
> defined in the VFIO-specific header.
>=20
> Please find another solution.
Other solutions I can think of are either move these error enums into virti=
o-gpu
(and disregard the error return type from vfio) or move them to some other =
header
where they are visible to both virtio-gpu and vfio. I'd like hear Akihiko's=
 thoughts/
comments on how to proceed given that he had reviewed virtio-gpu patches in
this series.

>=20
>=20
>=20
> >       }
> >
> >       list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> > @@ -45,7 +48,8 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       for (i =3D 0; i < res->iov_cnt; i++) {
> >           rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> >           if (!rb || rb->fd < 0) {
> > -            return;
> > +            error_setg(errp, "IOV memory address incompatible with
> udmabuf ");
> > +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> >           }
> >
> >           list->list[i].memfd  =3D rb->fd;
> > @@ -56,22 +60,28 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       list->count =3D res->iov_cnt;
> >       list->flags =3D UDMABUF_FLAGS_CLOEXEC;
> >
> > -    res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> > -    if (res->dmabuf_fd < 0) {
> > -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> > -                    strerror(errno));
> > +    fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> > +    if (fd < 0) {
> > +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl
> failed");
> > +        if (errno =3D=3D EINVAL || errno =3D=3D EBADFD) {
> > +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> > +        }
> > +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >       }
> > +    return fd;
> >   }
> >
> > -static void virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > +static void *virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res,
> > +                                     Error **errp)
> >   {
> > -    res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> > -                         MAP_SHARED, res->dmabuf_fd, 0);
> > -    if (res->remapped =3D=3D MAP_FAILED) {
> > -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> > -                    strerror(errno));
> > -        res->remapped =3D NULL;
> > +    void *map;
> > +
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> res->dmabuf_fd, 0);
> > +    if (map =3D=3D MAP_FAILED) {
> > +        error_setg_errno(errp, errno, "dmabuf mmap failed");
> > +        return NULL;
> >       }
> > +    return map;
> >   }
> >
> >   static void virtio_gpu_destroy_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > @@ -125,22 +135,35 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > +    Error *local_err =3D NULL;
> >       void *pdata =3D NULL;
> >
> > -    res->dmabuf_fd =3D -1;
> >       if (res->iov_cnt =3D=3D 1 &&
> >           res->iov[0].iov_len < 4096) {
> > +        res->dmabuf_fd =3D -1;
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> > -        virtio_gpu_create_udmabuf(res);
> > +        res->dmabuf_fd =3D virtio_gpu_create_udmabuf(res, &local_err);
> > +        if (res->dmabuf_fd =3D=3D
> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> > +            error_free_or_abort(&local_err);
>=20
> Why not report the error in the QEMU log below ?
I think the idea is that in the case of INVALID_IOV error, it is sufficient
to just report that the Guest passed in incompatible memory addresses.
But I guess we could also just do:
qemu_log_mask(LOG_GUEST_ERROR, "%s\n", error_get_pretty(local_err));

Thanks,
Vivek
>=20
> > +
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "Cannot create dmabuf: incompatible memory\n=
");
> > +            return;
> > +        } else if (res->dmabuf_fd >=3D 0) {
> > +            pdata =3D virtio_gpu_remap_dmabuf(res, &local_err);
> > +            if (!pdata) {
> > +                virtio_gpu_destroy_dmabuf(res);
> > +            }
> > +        } else {
> > +            res->dmabuf_fd =3D -1;
> > +        }
> > +
> >           if (res->dmabuf_fd < 0) {
> > +            error_report_err(local_err);
> >               return;
> >           }
> > -        virtio_gpu_remap_dmabuf(res);
> > -        if (!res->remapped) {
> > -            return;
> > -        }
> > -        pdata =3D res->remapped;
> > +        res->remapped =3D pdata;
> >       }
> >
> >       res->blob =3D pdata;


