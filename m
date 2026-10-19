Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25D5CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 01:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIbtz-0001fw-Ox; Sun, 18 Oct 2026 21:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIbty-0001fZ-Fy; Sun, 18 Oct 2026 21:10:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIbtw-0003OD-QP; Sun, 18 Oct 2026 21:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792372256; x=1823908256;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TtrI+dyOVJpYn/ZdrL/3MEMnDmsShR39dNU3kEFDgps=;
 b=N5AHsJ+m1AY2oCgEqqd2ahI6WUlvWCo3YyIInywWTl24Jv8C2U9tnTP4
 zruRAKjXukuLatv49R9jeXEdEeI6ojsgY9jrW46KpE0Eiz0akNwGRwSXA
 gIzx6SKwKWbzevl9Le7LhgAQXy8zhl6rER/ktCzTIO93cVZT6YFzBZipd
 si64gPCSgfZSq+94dX4TLolEdJNclt8h11MQfnBoAPFEX2KhOzZIeUp3/
 tIWPqF8k/ujBqYqnj3mjq64nKak3wbagopFGLg7Ibwl0RaQ2t8Lfnp28l
 pGP4weDTMUxvXxfd+i7nm1A6ktq1KRIv/BJ5ydGzdCHv/vP8Ynz5yHK8d A==;
X-CSE-ConnectionGUID: fnsdYmW8T2mnsCMecSy7Lw==
X-CSE-MsgGUID: KON6RPCfR6u9JquJgYNbHg==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="157449822"
Received: from mail-eastusazon11011041.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.41])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 09:10:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyBj25aMk7GIHNGbi4KjQB4OmEnEh73gpg0fIDvdpwunE6ysV1txwuFuDEf+Ze/0MnfAtgzWXGDa04ZExz/SGKIc6y3QfWTJZKpprVXYJsqPuhwMmFfc2V0r0MUIshQxr/4oIsx6gmIfbEGCMK+xAieLb8wKLnifMiNTpaAjBBXC8oCRb5Wg+0vRk10klPiRqeZdcI+DHlZy3xf0RgucvCkbIj1UEqtsLxvOJ73KFzRUNhv/mtwrFXH03WnLOYA4AmxglS9WkG6W7Hq4yBGBLkQu+ZfGmHPneQ0t8hgOBTGae78DRs58qGybC5ycQzmVqm4nxZFW7alkUpn2oOZEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtrI+dyOVJpYn/ZdrL/3MEMnDmsShR39dNU3kEFDgps=;
 b=HEvLFrv5wo3+VrQLwbnn8UBAIFze1m9RwC/JkuYOrEkeY8URuItP9Asy7IZQhzGa61M+Q4RzDM96xkCMkKJAA3ujrfM5gNJGhRfeZn+xAAxI4rSLuFl6GqLphXRIcQXVXOAv4aqzNJpyeuvnujrAlUEq/ZBd9KGbJW1kq1ZNwCp1EIWDU6JEUuKbPEL6JoEjV6uNzAk0qrmJTF4B6aqmzxRegzf6oZv86teAk7IkGJJLIHNIb0q6KcFy5jM9zAOaqq1P7NFUIiuedP2YPkIM6H10dU9T1OdrmAvcBhZUptyrfHiE4NqTOjmVBuy1j0Kviu5XotHSAXRWJgDjZxSJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtrI+dyOVJpYn/ZdrL/3MEMnDmsShR39dNU3kEFDgps=;
 b=rXvqoSh8s2//MQaDXO1WVnkFiVt5+Q7Xu42oYFxqueSbLwxZbBnU+6C8Dky1w37Zn05CPPHwvuoi3hQWKRWLQkmxk7sppcqERcnui+Z8HWfS4vlyB/v3+ZM8XX2QCgG8x3cnMzp+kO7XMJ26lZ+ghpeN2sM4fmyh4Xsf5Ucri0E=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DS0PR04MB8741.namprd04.prod.outlook.com (2603:10b6:8:127::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 01:10:49 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 01:10:49 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "joel@jms.id.au"
 <joel@jms.id.au>, "mpe@kernel.org" <mpe@kernel.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>
Subject: Re: [PATCH v5 0/3] Improve modeling of the Atlantis UART
Thread-Topic: [PATCH v5 0/3] Improve modeling of the Atlantis UART
Thread-Index: AQHdXDwtV38iS71H/0uEQLnNwyJux7cEFOEA
Date: Mon, 19 Oct 2026 01:10:49 +0000
Message-ID: <7be712e01da275c190359661a6477128780e5303.camel@wdc.com>
References: <20261015002849.1640109-1-portias@oss.tenstorrent.com>
In-Reply-To: <20261015002849.1640109-1-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DS0PR04MB8741:EE_
x-ms-office365-filtering-correlation-id: d5a60795-ca62-48c7-6f78-08df2d7dd011
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|19092799006|366016|1800799024|376014|7416014|38070700021|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: XykhwOzEFcaBxVZVuxUKk91UTRCVSQUJLuRpNcfX/293yFshTqenxRFOE8DiRKP7QQkq4+Dvy58kpJ572oxYiaevxKd5kEx9HC6DPWploGpipku95XHuRD/O4QPH69DxxyNLcq9f8VgQMxuxYQDrLi9kDCCaW9lC53dEFUrdY8IvtDfpviIBeiYJyj3+xR0b9/Kxq3zp+8lpdYTjYQP796+HX/x59g4/u/xPHxvpChp6+NKvcH9Xry0VJWDIR3vq8Hq4ibaPZlhdqUIj73lmX/+R32+Pijo17pcIKO04bosO/2FZoM2ujuSNti2mMdaT4CrbyL8sm4vEeepK2ZARK9hNxcvUF/ClKQHFUy9K77HN6VJbrwRC3xgTf7avD1K1aDnSjjhgwqfYyysHqmP5ryHoYTeuCSWdpqCY4dfghfV3eNOF8eTQ+hTqSHP3Gb5tqlxKnWWat6lm0YW7eK/Hx6YUg2qalLGzrfv23KHOH7nlwFEd+mRmiOeID+vnw1xqOnYhHuHzqjEY6IKL9npYJfvgm6h4TRmSarqHQe7nzRWZZKLGI3z8ijXsW+6XfPJqTbL2R/vx7kSfOUDYnFjr9dvPX7Mp6ZfKtMPvpUPkIq5/wUfHN+CxsuqZlCiUguJdyxbtIxGbIXAyTZ+QcWY5jDIBio0yntIDz1YAJeV9BW85x/rcRRIpj0sFN7gtcxqLkA44r+b9dV4zQGsCFC6Kf5gY9/Rp/TGVsEfW6/CqLKs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(19092799006)(366016)(1800799024)(376014)(7416014)(38070700021)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUFpYmJxR1p6UUFoK1RBUXFwM0VWb2dZTmtzaGNQNGxNRUJ3M2tXSmxoSU9I?=
 =?utf-8?B?YmlJamVuUnNPN0s3MncxYlhEUXJ0emFWUkF5V042eU9hOUdkdEE0V2tGRzhh?=
 =?utf-8?B?R0p5THhRQkR6NmlXL2lwNXo3WEkxNnM3SDc2b2VkdGVUOVM1dGFOK204Qm5Q?=
 =?utf-8?B?eUhOTzZCV1dKSnlvMmVsSDhTT1dJK2poNXZYYjJ1SkRqbGUzWExqbFBaRGI1?=
 =?utf-8?B?d1hVTUNiNHE3ekViMWE2WmJLdjNpMjlFMVRlZ3dvbE5vMDZreTg3WENjTm9C?=
 =?utf-8?B?TDBHWSswejcwSGM2R1JCNzJQUVYrVm5vWUc2RWlMdWF4SXc3cFpGV3NJRjdC?=
 =?utf-8?B?SnNwT1dMSGZVTzhobnV6Ukl3ajdsV2RiZm42cWhEYStIMmRrZlNlUDBRUGFO?=
 =?utf-8?B?eGRPQ1NDTytBcTRIZHRHalhaRW0rVXE3UmpidzBnZmRMYUtNcFpzNEVMUFB4?=
 =?utf-8?B?ODR6cVlIUFByY0tTanBDV2g0cmNyUk40TTVNNG9oSGYvaEUrMlB6REcrTkl3?=
 =?utf-8?B?Tll4a2ZGNlp6bEJzeHNqNWZKOUROeThlZk5IMGd3UzVOemdUMlRQcmJHNjBC?=
 =?utf-8?B?dTVLN3RKbXVYL3B1RTVwVURTd3ZpVFBtZ0d0eklmVUgyMTJsdTZYZFJseWtl?=
 =?utf-8?B?K0dBdzJJWXpLU3FFTTJvZktFbUJtRHJNU1VYS0plUWlzQThQdWZZbmN5UFpn?=
 =?utf-8?B?RHpvREZLWWtQQ0cxOEVoMW1ocjg1cXl1NEovRGxEYm43d0h4c29HTzN6anRQ?=
 =?utf-8?B?NjdBSGlZZzROMUR4NEl2TzhiNlowOWpva1ViVEJBcTdsc0VnTTlFV1lZZ0NN?=
 =?utf-8?B?NmQyNng4MXJJdXhqWWFNejlxd2VuNlJ1ZmNydDBSTlJTSU5TUS9jNjN5MEFp?=
 =?utf-8?B?Qk1YdlJsR1BaNi9lNGl4Zmg2MzA2YVRDY2FTSnpFa2wyL1hpN0xGdHVYUFNW?=
 =?utf-8?B?cHJCVXVYU3dnakpJR0dGazF3aFRUVlRxS3BJZGFaNk1KdU43dDB5RjMwUnBM?=
 =?utf-8?B?L0JpWTZWOHhTaHlzcW9iYkN0emdralVoZm1RUjBpMFdPcXJaNWtBWjhNdUFu?=
 =?utf-8?B?QzdvVDYyKzIzd2MybHdoRU1XaWJncXV0VWlrUVY1WnZuOHJkZmV6M0M3aTFa?=
 =?utf-8?B?cW84M1ZCODVRZGpwZGovbzNrTVlsc1U5Y1MyejJaekdGMVZwa1JpQ0sxb0x2?=
 =?utf-8?B?TmFEbXM4YXBYTTJseTQyY3VvWUZ4SzhhalEyY1M2c0ZZaHB0aGp5MlZwMkR0?=
 =?utf-8?B?Z0pCOWpxZ251L04xMEM1eWNOdDVsSy9VYUJyYXpWdXd5Ukp6SlJrOEZpSXZO?=
 =?utf-8?B?by9Uck5vZzJlWTBVNDFHazhHaC95YUpSOFNBeE9jT3p3a05TYkpzdnNmL3FO?=
 =?utf-8?B?UUxEWllMYnhNUEo5dXQvYzlXMTV6UlJQanNnRE54Mmh2Nkovd1dzZHZZS0o3?=
 =?utf-8?B?Nkd1RVlyZnE3dHVXblBaN24veENoWnBad3pNTnZrNUdJNTEvdkhsUUVWOFpa?=
 =?utf-8?B?MWlLUGJtTlArRmc1M1cvTFBRSnd6Ui81WlRMRVdKWWhqSWIzWEIwN25xeWRQ?=
 =?utf-8?B?bTNBajY2TUFnRzlhdG1VSU4xTWEwS0tzckVyaXJ4dyttTURGVGhFelNNU0pp?=
 =?utf-8?B?OWt3VnBuSnA3QWJjQnAvdUhSYzFDNkVIdVBHeWtJbXpyanRrWkUzUTVWQ296?=
 =?utf-8?B?S0l6YXB4WjU2Ui8wZHBSOG9wY1VMM0tMeUM3d1VTQmpDYXp4QUllVlBQbHRu?=
 =?utf-8?B?bTI1akJzNllnSGJ3RDRBRDd6blVGQjVhOXJwTFBENjN0eTRQeFQxSHlXSXlJ?=
 =?utf-8?B?K0pLQkYyNlNESGRDY0pVUDI2c0k4VzFxZ3lPT0FmQzIvckpZNnI4ZlNNSldq?=
 =?utf-8?B?VG1BOEpVMWF5T2pDVVcwWW9hMEQyck1RcVlrZTdzYWx0NmVJUUZ3eTZuVVpZ?=
 =?utf-8?B?Nis2WXkzSFJyUSthTXNrQjF6QmpyRHEvaVJOL2hBV09Idm13T09jVHlxaG5i?=
 =?utf-8?B?Mkx5OTNjazA0UFBYQ1ZqTmRJdkIzVlkvdjlsc2w0K0l4eVpXQ1gxR3R4QVY3?=
 =?utf-8?B?VWJ2emJSOTg4TnI0TC96blFxM2VCL1dnOE9EWVJhVlhUVDlkbXcxbGdzU1Jz?=
 =?utf-8?B?TjlzT0FBYkpnamxTRXZrVzgrWFFsb2ZFaXd1cnF6TW5TYStQeThmOEVHUC9U?=
 =?utf-8?B?dWhWR1lQdHNvSE9pcFRvVmNzdjF1N2tzb2xzYVNBTklPRWpJZlgwd2VoQ2VW?=
 =?utf-8?B?dkhIRGxLV3gxN0xDTDR6VTZLSUNDanNjMFJGMEpLN3BzUVppZGt3eVpkak1W?=
 =?utf-8?B?QVBVT0dsM3luQjVMS3FQMTVMZWxyNExLSEpZRGRaMDZSM29KZU5Wd2ZVeVZZ?=
 =?utf-8?Q?9iBw7a6lga8g2+WaUIeUf0qVdOfN2B3GKHchMpl9xFirQ?=
x-ms-exchange-antispam-messagedata-1: fWAHgVkAVxQDGQr0yKKtVA9JcxAU8wc/cY4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB7690E73345F84096C318AB31FDDBC0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: y47c/EpYjXeYI69OioKYqyS3IO2xTlxgCZCb7fsMopm2DpUTH7WIeF76rzQJUxoWqYbuJB4+rOTj+par/u3jyK0jCHrr4Sf+LKyK5j5BfaqV39dqNxL6lOcFggJcdl0s/sAa1NSfOdN/VUKusc5awHxf1f2Hf5iA1Id07ke9euOkwMzfzVFR+8NIChYrA+hrbgMiw1anSU8skhdoglcjJbg1zusgc4bEBHGsIhcCJRevdcKXUz+ALIRa4D5V6272HLqk49HAgZbNo4diM0BHUjwa/uB2xe6apcLpsc8P/FEVxj5rsdFxUasZNzUrIbHqonVysnFr2hOIG14XjpOU7Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GmmTGUfs12bTfq3xidexv+l5M1zgoc7Z419xt5FQCqh3RASapOe0PADyhprB2j6ZG05qjjXVdHVVyjxGZo1ms6kGtZeCI5Xc68PjX2yqZTOMvbQU5t4JYl/T2aKwi1cS+wgu2CgoJekYFgYp8+oRwmZlvyCT6W+ouALgQJujygITLKsPL4zF9L1ozHoWVX6r7cmbXLS53veijIQjHLMadKKJK9sY7vf8mRR0gS9hgjKmPH/weujv1reNn/6dLX6RAISp5Z1Aj6c/K9dGRL1NKYPD5GVRhBoZKsfNlao4gSQi3gA4QrNmPm721fOURLhc+aGw01BLZDqn8rG3Dx1ZThbZgD3NHYUB7q/Bqenc7/ln0ndNdEvLxJS0ks6WvHVD2ef/EQEi6/LKfsNe7u+m9nz+DzcI/eYgY9cJtsgAlGhei3xCVs7hSl2m0UFE3U7q7GcQJnJKzEb7tpBbQrsqwdFGHS9XFVLetdw6T4xRkTTn10S8zuWO0i1jI9LJNgXvioSkF6Vbyk4vpPrhm7SoHxoINwY2APWjCCCLeL1JwOyRqO9QTyZA0y8h3FNjXycGVhV03o/eBCToP6D5epNT8Ltq+pHwVg/fU3ehqr8nypp9cNdJ9lGHffA4M5GwyWYg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a60795-ca62-48c7-6f78-08df2d7dd011
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 01:10:49.4605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02ZjZWN+MKiqfe5WQkxs7xooJ5iF91j6cNsUUhDQWBgnc1XwI2qsW2xc1je+aigNRFRvuhjDosJeDzqQxwtiSWMDXobK5lU0qII28Eih2Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8741
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDEwOjI4ICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
DQo+IFRoZSBBdGxhbnRpcyBTb0MgaGFzIGEgRGVzaWduV2FyZSBVQVJUIGNvbXBhdGlibGUgd2l0
aCBEVzgyNTAuDQo+IFByZXZpb3VzbHkNCj4gdGhlIEF0bGFudGlzIG1hY2hpbmUgaGFkIHVzZWQg
dGhlIG5zMTY1NTAgVUFSVCB3aXRoIGFuIHVuaW1wbGVtZW50ZWQNCj4gbWVtb3J5DQo+IHJlZ2lv
biBiYWNraW5nIHRoZSBEZXNpZ25XYXJlIHNwZWNpZmljIHJlZ2lzdGVyIHNwYWNlLiBUaGlzIHVw
ZGF0ZXMNCj4gdGhlIEF0bGFudGlzDQo+IG1vZGVsIHRvIHVzZSB0aGUgbm93IG1vZGVsZWQgRFc4
MjUwLg0KPiANCj4gVGhlIEFzY2Fsb24gY29uc29sZSwgdWFydDEsIHJlbWFpbnMgb24gdGhlIGZp
cnN0IGNvbW1hbmQgbGluZSBzZXJpYWwNCj4gaW50ZXJmYWNlLiBUaGUNCj4gb3RoZXIgNCB1YXJ0
cyBhcmUgbm90IGFkZGVkIHRvIHRoZSBjb21tYW5kIGxpbmUgaW50ZXJmYWNlIHlldC4gVGhleQ0K
PiB3aWxsIGJlIGFkZGVkDQo+IGFzIG1vZGVsaW5nIGlzIGFkZGVkIHRoYXQgcHJvZHVjZXMgb3V0
cHV0IG9uIHRoZW0uDQo+IA0KPiBDaGFuZ2VzIGZyb20gdjQ6DQo+IC0gUmViYXNlZCB0byBpbmNs
dWRlIFBSQ00gY2hhbmdlcy4NCj4gLSBEcm9wcGVkIHVhcnQyIHRocm91Z2ggNCBmcm9tIGRldmlj
ZSB0cmVlLCB0aGlzIHNob3VsZCBvZiBiZWVuIGRvbmUNCj4gaW4gdjMgd2hlbiB0aGV5DQo+IHdl
cmUgcmVtb3ZlZCBmcm9tIHRoZSBjb21tYW5kIGxpbmUgLXNlcmlhbC4NCj4gDQo+IENoYW5nZXMg
ZnJvbSB2MzoNCj4gLSBEcm9wIG1hY2hpbmUgcHJvcGVydHkgd2hpY2ggY2hhbmdlcyB0aGUgb3Jk
ZXJpbmcgb2YgdGhlIHNlcmlhbA0KPiBkZXZpY2VzIG9uIHRoZQ0KPiBjb21tYW5kIGxpbmUgYW5k
IHVwZGF0ZSBkb2N1bWVudGF0aW9uIHdpdGggdGhlIGNoYW5nZS4NCj4gDQo+IENoYW5nZXMgZnJv
bSB2MjoNCj4gLSBGaXggdHlwbyBpbiBkb2N1bWVudGF0aW9uDQo+IC0gRml4IHdoaXRlIHNwYWNp
bmcgaXNzdWUgaW4gbWFjaGluZSBoZWxwIHRleHQNCj4gDQo+IENoYW5nZXMgZnJvbSB2MToNCj4g
LSBEcm9wIERXODI1MCBmaXgsIHRvIGJlIHNxdWFzaGVkIGludG8gb3JpZ2luYWwgcGF0Y2ggd2hp
Y2ggaXMgbm90DQo+IGFwcGxpZWQgeWV0Lg0KPiAtIFVzZSBxZW11X2ZkdF9zZXRwcm9wX3N0cmlu
Z19hcnJheSBmb3IgY3JlYXRpbmcgY29tcGF0aWJsZSBzdHJpbmcNCj4gLSBDaGFuZ2UgbWFjaGlu
ZSBwcm9wZXJ0eSxjb25zb2xlLCBmcm9tIHN0cmluZyB0byB1aW50MzIgYW5kIHNldA0KPiBkZWZh
dWx0IHZhbHVlLg0KPiAtIERvY3VtZW50YXRpb24gZml4ZXMNCj4gDQo+IFBvcnRpYSBTdGVwaGVu
cyAoMyk6DQo+IMKgIGh3L3Jpc2N2L2F0bGFudGlzOiBVc2UgZHc4MjUwIFVBUlQgbW9kZWwNCj4g
wqAgaHcvcmlzY3YvYXRsYW50aXM6IEFkZCBhbGwgVUFSVHMgZm9yIEF0bGFudGlzIFNvQw0KPiDC
oCBkb2NzL2F0bGFudGlzOiBVcGRhdGUgQXRsYW50aXMgVUFSVCBkb2N1bWVudGF0aW9uDQoNClRo
YW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0DQoNCkFsaXN0YWlyDQoNCj4g
DQo+IMKgZG9jcy9zeXN0ZW0vcmlzY3YvdHRfYXRsYW50aXMucnN0IHzCoCA3ICsrLS0NCj4gwqBo
dy9yaXNjdi9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiAr
LQ0KPiDCoGh3L3Jpc2N2L3R0X2F0bGFudGlzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNjgg
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gLS0NCj4gwqBpbmNsdWRlL2h3L3Jpc2N2
L3R0X2F0bGFudGlzLmjCoMKgwqAgfCAxMyArKysrKy0NCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDUw
IGluc2VydGlvbnMoKyksIDQwIGRlbGV0aW9ucygtKQ0K

