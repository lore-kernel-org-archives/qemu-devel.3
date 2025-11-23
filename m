Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485ABCFA46B
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 06:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vN3Pr-0003Pz-Mi; Sun, 23 Nov 2025 01:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vN3Pg-0003KQ-Ju
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 01:17:32 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vN3PV-0005NE-2l
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 01:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763878641; x=1795414641;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vSp5uPEkfmQiV3lwq13eW2AL8/t7JIuRKiHftsaibM4=;
 b=fSnVfz/EqLCEKkwtndyNQsZhVtjg8PMrReU3S9klRtfDKjeT9E4mx3Ld
 QVGv2zX4MR+T5ssi3gPu/pvWzY5BatSJbY3Dt0+lpwagEg00v1GeXG3Kq
 8e2mAAbYW1QYMv6G740/ib66sED4Du0jdC1tDOukqoGqFa6HllLszgYjM
 tbfz15/KdAl6ZUN3pQtuYUFaBQ4n5aJ+Lv5VXQNtbobTp9HD7k1oycIKM
 rmtjeNW4frIRoZm/H52FBAFJnA/tNnSCnwlAtijIkWRQ4EylOzpBclg12
 Sg9ynKyukzpfVpaA8oJ7fT5H5M72ME3EduebFSk3lBFgOMf/cfR/Rx9Ih g==;
X-CSE-ConnectionGUID: Ua+nSWCnSc6PvY/xXv5g3g==
X-CSE-MsgGUID: TlbHQLkORIWdYBg0X9zNLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="53483846"
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; d="scan'208";a="53483846"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2025 22:17:04 -0800
X-CSE-ConnectionGUID: jUI402SSQB+LAivNF6vjLA==
X-CSE-MsgGUID: 9TuVx53IT4mES2DJ+81AwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; d="scan'208";a="215400473"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2025 22:17:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 22 Nov 2025 22:17:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 22 Nov 2025 22:17:03 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.53)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 22 Nov 2025 22:17:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/B0Bdr3760XwL2M6V0cUBzmwjQCKExgQDzD1zD8xAG4rYRpA56eOX2c4PT2LFaEhMo7K4nkAxEfaigVvGjZnROTYBe+2MJVcin/iyzPfiyw9A+QkBLzizwkE4izxHTU9XXtC8pvsH5oNSsv736OHwfbfFMUjB2fB5R/9l1YyjqvmouHyKsdzHiJoyGoJTLwkjjEuyfKX+7KY7vGUwMWyJkGM56m0rStpquqR70X2YgzIGYfvi5fjJlgxNW8mnQ5BExb7lNTgMfIebOJ1T+D8TpqPsjv1M8SnNGBAu+Ihiw/MeKou3zIBcIPI/w0FgdUo3qIaZfxpDjEg9/aK5/URw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuhakablqhG4Qy7/CgcI0+lOZpZwuTdH969VcSGF1+M=;
 b=yVNRlSPv5ZKEe+dCeYdFnUQVpyotgxim9Ja/PVARB2eUaKBsznaq2toO+Lc3F+5p1BJ22mUvciofRFSMRVmCnWLppdPCTknZJ9h9tgFTZvgmpULBNRN1BxSMXvaG1b+G8o5uLEX8ZkFf42ZGl6+bhLefBklGBruPItF+b6uPQcw7jJ8XutHhpLZlupKUwrWuV78Syq8TiLBli0JY/oIF2HrpZYeytQa4bziaXC5JGWWAXMMDDPiIeK/p2vdCyL+udj/1wpjLAsOF4RXiGUUrfDVDE7xZtQwHVTAhILIGiasYZUtKQuDM54wOFBVbjDo1uSuqWYuaJJ9nXshCT29pqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Sun, 23 Nov
 2025 06:17:00 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9343.011; Sun, 23 Nov 2025
 06:17:00 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v3 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v3 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcW3xQap9NDYNKLkWy5QRJs1FMO7T+S0cAgAD95GA=
Date: Sun, 23 Nov 2025 06:17:00 +0000
Message-ID: <IA0PR11MB7185273C43DA53473EC8B796F8D3A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
 <20251122064936.2948632-10-vivek.kasireddy@intel.com>
 <74f4e219-a094-42b9-a30c-8de597692ab6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <74f4e219-a094-42b9-a30c-8de597692ab6@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CH0PR11MB5233:EE_
x-ms-office365-filtering-correlation-id: 7a4e56c2-b7e6-47c1-c632-08de2a57e99d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0QUtc673X/r/Ny0adhr7nIaaiB3HBD9hT7xvffd9LhRqizwhKzYawboSIk?=
 =?iso-8859-1?Q?UTqUJbYbgu7XPhR3Gf4GU3+/OY2jw2O8oEoE7jaZ8+y3PB4NlbPz62/fgm?=
 =?iso-8859-1?Q?kwlJA8Hgb4kNMTeKL0qhNtISzwkNVGmQ+cQh0/AMiKyPXOnR6aHuMg2U0j?=
 =?iso-8859-1?Q?v7ybQd0tCn6giD2QzZaMy+8gFnbc0uHV7nGJTbleEssSlY2i0UreDnKgy5?=
 =?iso-8859-1?Q?qULrK7tGmhKE3CffeVN6243DN9/AjcgILgWA66kcorUucp5xxbUrcp+PVm?=
 =?iso-8859-1?Q?zA1AS3sZeTpS3b3owfDnwApIGtU++lLzmwBZ/JureQ6MkRQBsuBCqYkqW1?=
 =?iso-8859-1?Q?3xnpPS9m465Gbgw157vCdJ/lmMBNjR/I0RKAZHrebjXlHa4TO0A/qkkI+T?=
 =?iso-8859-1?Q?IDYbZEsPwWVm6UzCBJlHHTs5cpWH3j6odFlIwYuIPwLXH68EUOMb5CU6lX?=
 =?iso-8859-1?Q?jvhL/HGeyeSXFwAhiSf1hXtlWChvTGvlTcCvFCPdajERjr9gRmyGrU2If0?=
 =?iso-8859-1?Q?awYWRhSRIgXuDcml2gzQEiQ6zOvgvz1U9/+PBNH9+w1RI7FdBEGeAjj1uh?=
 =?iso-8859-1?Q?VU8GJZS+5x+cHRJ2BaVxyltzuXQp+5rmBMi4RrIE9qT1h/s/PGkgKQoy/B?=
 =?iso-8859-1?Q?yaUTS3eX4skj6R4bSlg/JFTTmy09dSe1jzc4/SguuMkvD/9Z5/9+U+bFn1?=
 =?iso-8859-1?Q?sDFAIq2JIyDNqD1ALUZCd47laMZgQ/pG2kcnHtug1pwkB2Euw4JTsgq6OY?=
 =?iso-8859-1?Q?UVpL332LVLBiLLjbIzwZb1WNqGlY4EVzUVUPFlLtqSL+0EO1EfT35nS+R0?=
 =?iso-8859-1?Q?+LSW9P0N47HJrXhukG1Uy9tFVRjRcdi/rJIhpjvaGJWFvPJK0DlP7Sorpl?=
 =?iso-8859-1?Q?n23JzufxaLWIWpFi8sHrM80uEBD+ngYtUjWXkAQGEF2ctFhmPRFybwK3oY?=
 =?iso-8859-1?Q?4ZvZMSuJlMriX9FG/TTPHdkT4Jrt0HpJKMqh3Tc1EjIE0at+4bN/ZbaZQY?=
 =?iso-8859-1?Q?FAAnSwl6TdgSY5XojT8a4NYSoQMchFYqbCK564npdbJ12wmCoos+VOEMfA?=
 =?iso-8859-1?Q?0VX3/1WQBA1U4EkkpMMAgIq9DjmTob6huQLw/H3BlkoNse0737mhVMWfTL?=
 =?iso-8859-1?Q?iykY1tZJBzcEvY0r6nWX4HqqzJarwCKJIH9gcmwTeH2dP0887JeAFbZeAS?=
 =?iso-8859-1?Q?snBiFbED3P6CYzAPmAFAKgbzJqINijmjIMPeJkp1EKeXssO/XR+p1dck4w?=
 =?iso-8859-1?Q?Z8m/zp+CqzyS/7209+P9bJTgDnPhvllBisQ4jmAHlaHM3Xvnb2+SamDUTr?=
 =?iso-8859-1?Q?/PbktdXbhfrdl+mUY1O5SHc65RWqMSgK92r156tlPxIM9xjePPKz74KCpP?=
 =?iso-8859-1?Q?Vod2wSqS95J+Ml4Shv6yQ41fEv2bHOuoPYtzjP82RS+dCAKvLc2SmEj56L?=
 =?iso-8859-1?Q?mU20v+zbYFgfgxqSOj9gwXGumrO6XqROuB66EvZuSS0FvxZBuHwCxr1jXt?=
 =?iso-8859-1?Q?Z1qB/CiSRUK3L7X/2jkkrnHv/0/Kli+zb7s9IQnplUaXi1GAYL0HxHIGeS?=
 =?iso-8859-1?Q?ddKEiRczXsEMr4kQoiX4+anEO5h0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sw+ywNK4ru2lxeeWOEi2c56Nj9uwTK4lPW1+vuymWw9t+xLFexFOGyYdp2?=
 =?iso-8859-1?Q?0Ue/MEEzoGKGFiXypo9y8FJ/EXDnMAepXCTDWjGEgwZp1E1aTVjiHFbsi1?=
 =?iso-8859-1?Q?/uNa0kNMHWT8PRXjzMYb+shM2NzqutQKpNTQPYdf+k6hsjPsnsAV4j4j/f?=
 =?iso-8859-1?Q?DjvkCzqi3QNSBf2pEs0pN1qvyFF3gEqnWocQcjZ9VU76vzdDjdMeAs5Xav?=
 =?iso-8859-1?Q?CTWIxXLnfXppKyADzHOT9XJagdHrdvwKtyCCtBWNKQ4WR1CZLi3onK+K/3?=
 =?iso-8859-1?Q?Ymzv0EQqs5uMZqSfolWNxJ8T5zUFMU7VsVIJFt9aozqhlS4HDL71US0jhE?=
 =?iso-8859-1?Q?g8Ft2SUHH1YESvm/TX2bEk6sb1A8yTZmgx/IfzUKuxp8HpbkLM5KUO2YRV?=
 =?iso-8859-1?Q?J0cWTeHU4pii/HDNq7p5aNUJ9Sp/kRLWcxTalw1Awzkm319fDJ6hy31uB4?=
 =?iso-8859-1?Q?rfF/1ykZZmppZmikltlufpWOwkFBOs9ZegBnTuKvmrP4OlXKQBz2luDTov?=
 =?iso-8859-1?Q?5LWix1fWBlhbElfl1qs+8rlecN/22Dyo+KN/TuB+L0tCUxdumj+YNS/ezD?=
 =?iso-8859-1?Q?i1edygYm4vvLW7bc52dOFFZHMvQwvyjw2dIIyTgM8xut+xwG4WX6s4u6hq?=
 =?iso-8859-1?Q?js5W0I2kJSNsuE4Jmcj7YVWs/ZnXI4hrmLG6a12qTWVMEu5WXBBUnrGsB+?=
 =?iso-8859-1?Q?GT7/HVDPxCy6uSpgfr4anPfTnIlACDqzm72e2B7C3emC1IUu0THgLrbca8?=
 =?iso-8859-1?Q?ONcOMXIEmJaE1JiaFot64OmO/8+KCRREQK18ih0RICbX64ZPsHrSTQ4huw?=
 =?iso-8859-1?Q?RhCDm9lGAaE6cqJpR2zqyz+sFCruX/pQSne3hGCDasFUhwQ770jujLgynu?=
 =?iso-8859-1?Q?x0mROa4vVc3pw7Dpdpzo+3KjWvvy0bXKYgSJYobKQnVw+yhVT+h4aQ3vWL?=
 =?iso-8859-1?Q?mB1nE8uCOX4xiiEaHT2LIt/6/sIdCAbH6Ooij/wBXFWNHNXf4eVPpKNZ6j?=
 =?iso-8859-1?Q?aQf2amp+Lhg1Vwv1/PzrT+ZyIf5mOzc3DTbtCp8ew4Ti1SQiCsF7FqCqky?=
 =?iso-8859-1?Q?Il4JWCS/NqfATHmrHJaegfiloEnRC8a1pEaCFMsA5MACWesb7MjUDS70Uf?=
 =?iso-8859-1?Q?iK7Ir6vM4/PeqphIFBIPHIRVdNQsQ4klUnXygcgs8K1OZ0q1zbm2Q9hJRT?=
 =?iso-8859-1?Q?k0SWBDfXL6rfBzWDs04NgQTCG4/2/TF7OcRV8WkW6MisANGr+LuzttWTwB?=
 =?iso-8859-1?Q?RboS4KMhKxPNe3U9JgTknsaqrtUqWgrLj7diTNRDTsqPCI8rGAG5Migpl6?=
 =?iso-8859-1?Q?PkV9o6UFD2C+9V02oRSudUeBRXASTpddrxOs1pN4g5DeMfWOy2fnK2xSpG?=
 =?iso-8859-1?Q?EHucGSZysPQwiQ+udUlyJKLTi0Ibtt5Qqpr/KYl0OwkOHJa/HnLYi2ftjN?=
 =?iso-8859-1?Q?BDi7P3BGCjV8tPq21hcMiyWxHLgVbVZ1hcMU4DeoKDMsUF+oUxHAXsq+9+?=
 =?iso-8859-1?Q?618WwgsfrMm/DdfPBBW8T64kPQZMaayJuPuDjWVEPwY7V3tlW2A8ucVagG?=
 =?iso-8859-1?Q?kr9VNRSCnFj6+lgJG8niis4rIGiBJ4oVCdTBaqyyTPDTVrgxVTMNV6hPIZ?=
 =?iso-8859-1?Q?waGsImBfqkVxVw9X4duarAjMRuIqW95adj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4e56c2-b7e6-47c1-c632-08de2a57e99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 06:17:00.2514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLqYX/kSzY7kPp9Uff5XALQhIREv6ZksAeF2RDNuCarWtVI0zXGDnrzQYsHj6bJPm+lYEA5BDTvSqWRVpSEgEhRQpCcijc/OOIt3QAX1p6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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

> Subject: Re: [PATCH v3 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 2025/11/22 15:46, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Therefore, we first need to figure
> > out if the blob is backed by a VFIO device region or a memfd before
> > we can call the right API to get a dmabuf fd created.
> >
> > So, we first call virtio_gpu_create_udmabuf() which further calls
> > ram_block_is_memfd_backed() to check if the blob's backing storage
> > is located in a memfd or not. If it is not, we call vfio_create_dmabuf(=
)
> > which identifies the right VFIO device and eventually invokes the
> > API vfio_device_create_dmabuf_fd() to have a dmabuf fd created.
> >
> > Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> > the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> > use the VFIO device fd directly to create the CPU mapping.
> >
> > While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
> > from virtio_gpu_create_udmabuf().
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/Kconfig             |   5 ++
> >   hw/display/virtio-gpu-dmabuf.c | 122
> ++++++++++++++++++++++++++++++---
> >   2 files changed, 119 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 1e95ab28ef..0d090f25f5 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >       depends on VIRTIO_PCI
> >       select VGA
> >
> > +config VIRTIO_GPU_VFIO_BLOB
> > +    bool
> > +    default y
> > +    depends on VFIO
> > +
> >   config VHOST_USER_GPU
> >       bool
> >       default y
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index 258c48d31b..d121a2c9a7 100644
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
> > @@ -40,10 +41,42 @@ static bool ram_block_is_memfd_backed(RAMBlock
> *rb)
> >       return false;
> >   }
> >
> > +static void vfio_create_dmabuf(struct virtio_gpu_simple_resource *res)
> > +{
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    VFIODevice *vbasedev;
> > +    RAMBlock *first_rb;
> > +    ram_addr_t offset;
> > +
> > +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false,
> &offset);
> > +    if (!first_rb) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Could not find ramblock\n", __func__);
> > +        return;
> > +    }
> > +
> > +    vbasedev =3D vfio_device_lookup(first_rb->mr);
> > +    if (!vbasedev) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: No VFIO device found to create dmabuf from\=
n",
> > +                      __func__);
> > +        return;
> > +    }
> > +
> > +    res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(vbasedev,
> > +                                                  res->iov, res->iov_c=
nt);
> > +    if (res->dmabuf_fd < 0) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> > +                      __func__, strerror(errno));
> > +    }
> > +#endif
> > +}
> > +
> >   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resour=
ce
> *res)
> >   {
> >       struct udmabuf_create_list *list;
> > -    RAMBlock *rb;
> > +    RAMBlock *rb, *first_rb;
> >       ram_addr_t offset;
> >       int udmabuf, i;
> >
> > @@ -52,15 +85,17 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >           return;
> >       }
> >
> > +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false,
> &offset);
> > +    if (!ram_block_is_memfd_backed(first_rb)) {
> > +        return;
> > +    }
> > +
>=20
> We had an extensive discussion but I still don't understand the benefit
> of this change while I see it adds complexity by having another call of
I'll get rid of the extra call to qemu_ram_block_from_host() in the next ve=
rsion.

> qemu_ram_block_from_host() and imposing an extra restriction that all
> elements need to belong to one RAMBlock.
I thought you suggested that we need to ensure all entries (need to be
validated and) are associated with the same memory region? As
virtio_gpu_create_udmabuf() was not doing that, I thought this
change/restriction needs to be added.

And, since calling ram_block_is_memfd_backed() for each entry would
incur extra overhead (as there can be thousands of entries and fcntl needs
to check with the kernel), I figured calling it once for the first ram bloc=
k
and comparing all the other ram blocks against it made sense.

Also, rethinking this whole situation again, I don't think we should try to=
 create
a dmabuf for a buffer that might have mixed/different memory regions or
memfds (as this is most likely an invalid scenario that could lead to undef=
ined
behavior) so this change is meant to prevent such scenario.

Thanks,
Vivek

>=20
> If anyone else have some opinion on this, I'd like to hear.
>=20
> Regards,
> Akihiko Odaki
>=20
> >       list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> >                        sizeof(struct udmabuf_create_item) * res->iov_cn=
t);
> >
> >       for (i =3D 0; i < res->iov_cnt; i++) {
> > -        rcu_read_lock();
> >           rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false, =
&offset);
> > -        rcu_read_unlock();
> > -
> > -        if (!rb || rb->fd < 0) {
> > +        if (rb !=3D first_rb) {
> >               g_free(list);
> >               return;
> >           }
> > @@ -81,11 +116,77 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       g_free(list);
> >   }
> >
> > +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res)
> > +{
> > +    struct vfio_region_info *info =3D NULL;
> > +    VFIODevice *vbasedev =3D NULL;
> > +    ram_addr_t offset, len =3D 0;
> > +    RAMBlock *first_rb, *rb;
> > +    void *map, *submap;
> > +    int i, ret =3D -1;
> > +
> > +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false,
> &offset);
> > +    if (!first_rb) {
> > +        return MAP_FAILED;
> > +    }
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    vbasedev =3D vfio_device_lookup(first_rb->mr);
> > +#endif
> > +    if (!vbasedev) {
> > +        return MAP_FAILED;
> > +    }
> > +
> > +    /*
> > +     * We first reserve a contiguous chunk of address space for the en=
tire
> > +     * dmabuf, then replace it with smaller mappings that correspond t=
o the
> > +     * individual segments of the dmabuf.
> > +     */
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> vbasedev->fd, 0);
> > +    if (map =3D=3D MAP_FAILED) {
> > +        return map;
> > +    }
> > +
> > +    for (i =3D 0; i < res->iov_cnt; i++) {
> > +        rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false, &=
offset);
> > +        if (rb !=3D first_rb) {
> > +            goto err;
> > +        }
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +        ret =3D vfio_get_region_index_from_mr(rb->mr);
> > +        if (ret < 0) {
> > +            goto err;
> > +        }
> > +
> > +        ret =3D vfio_device_get_region_info(vbasedev, ret, &info);
> > +#endif
> > +        if (ret < 0 || !info) {
> > +            goto err;
> > +        }
> > +
> > +        submap =3D mmap(map + len, res->iov[i].iov_len, PROT_READ,
> > +                      MAP_SHARED | MAP_FIXED, vbasedev->fd,
> > +                      info->offset + offset);
> > +        if (submap =3D=3D MAP_FAILED) {
> > +            goto err;
> > +        }
> > +
> > +        len +=3D res->iov[i].iov_len;
> > +    }
> > +    return map;
> > +err:
> > +    munmap(map, res->blob_size);
> > +    return MAP_FAILED;
> > +}
> > +
> >   static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource
> *res)
> >   {
> >       res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >                            MAP_SHARED, res->dmabuf_fd, 0);
> >       if (res->remapped =3D=3D MAP_FAILED) {
> > +        res->remapped =3D vfio_dmabuf_mmap(res);
> > +        if (res->remapped !=3D MAP_FAILED) {
> > +            return;
> > +        }
> >           warn_report("%s: dmabuf mmap failed: %s", __func__,
> >                       strerror(errno));
> >           res->remapped =3D NULL;
> > @@ -146,6 +247,13 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >       } else {
> >           virtio_gpu_create_udmabuf(res);
> >           if (res->dmabuf_fd < 0) {
> > +            vfio_create_dmabuf(res);
> > +        }
> > +
> > +        if (res->dmabuf_fd < 0) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: memory region cannot be used to create =
dmabuf\n",
> > +                          __func__);
> >               return;
> >           }
> >           virtio_gpu_remap_dmabuf(res);
> > @@ -160,9 +268,7 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >   void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    if (res->remapped) {
> > -        virtio_gpu_destroy_dmabuf(res);
> > -    }
> > +    virtio_gpu_destroy_dmabuf(res);
> >   }
> >
> >   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)


