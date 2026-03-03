Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E0E67A81
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 07:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJuC-00057N-Hb; Tue, 03 Mar 2026 02:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vxJuA-00057E-Tg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:10:55 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vxJu8-0000kt-I2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772521852; x=1804057852;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mf2/6afYSxm5l43x0iM6lB0IpEeaOa8Hs/gohey78Y0=;
 b=FN1OhAK+uRwF6Hi/2h7VFLhCf3AmBb2WWAYQU4ZUC8MSolexFlV2/efN
 cTRPC9YbR82ZmD1QrYf5vMLIFDjPIatoUhtlLdnNWKvmfPE0gPR5ZBGce
 Ca6hi9qYdps08PaWXn71aoyp5iz8LbL1I0gvv0CVYeskgs8OyYvdHxKkl
 42PF2NchpHym1FEYJLYlNnZkng+UdLDpk93OBfc7HjC0gEHWcJ+7u9RlZ
 g6WLmAFO+p8v5O7IA1cs07JmPQFVGWwm5RvdiFWTt6M0QhEBYGUX/u8xW
 /2+IWead1LUoqZzS1kagWssg/ms1K+h05rjAkdcU2Dd298ugtgl8X4XpN A==;
X-CSE-ConnectionGUID: mxtz07eNQDOwdmeQ+PanEQ==
X-CSE-MsgGUID: PuPElzdITXaFZZeq7MmCaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="77413056"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="77413056"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 23:10:47 -0800
X-CSE-ConnectionGUID: YMu2KIYVQ6ait5E89UE7GQ==
X-CSE-MsgGUID: YVTJtUwgR9iQlaIPaXBhSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="222568993"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 23:10:47 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 23:10:46 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 23:10:46 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 23:10:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzhPnbGNEe6nrO7UAnzfkAgMsnFqwLvZRkSpWsmdSV50U3k1F9xmfWNV7/Uo6MbLZuGbmwZ7ZhBoyELWVbDJk0hZEAqQxj059EumD/5V4szanJuhWR6vncYwHrmC43VBGjYi1od0vbldX9ZhB3dv9l7vQmMqxm8jAJ5FxishmEsDGX572mECnkDdaMapqjAijuqyJgAF0FE73OkAa2WeKe4H5epecmkFr5jXs/YjaPlpenXSf78ezupcKv5xun45AzqeCU6bZcOqgKZPjwL5Me25Ar3KMNeBkz0M/Bpr/zdHoXe8ryQAZhw69a28wPtQOsLoxQgMQck0FpwfokBPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsCb0pg8xL6BNvXJM0gYU+NCuZCwET+cwPcGBD/e5HU=;
 b=QRpur5E/ETEY/cuqNIHq0qazfgAFGlMNOI4m6UZotxqsliXGSzl/li/ohzt+VmqnjdwCKr8GbX9mJscdy3V5p3Hcl1r16E4KOWSeu5XHK/4zG1Hq8xa3mCyhwkzMm/1Cg33/O7CVsBB0Iel9SO1da7Ev/IU3n4C2bi7Pavlol14kgGVo2SsPY0cyaIEw5PS2CokR6nM1z1licpTcXlU8ijjyiuiolobzDEkDt9KTtn+6mDZM039d31b97LvDIM0m2FZgXLnSCNPUev5sv5Q2ScwcfQCudtNm3iTLD5Go1waa6ePIj2drx6wFYn6jIhA44VnJhyRAlG8TTUYo8cGsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 07:10:44 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 07:10:44 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v8 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Topic: [PATCH v8 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Index: AQHcqDcy+xC9oS+I3U6DsxDUS0xBdLWXtaEAgALlrGCAACowgIAA71pQ
Date: Tue, 3 Mar 2026 07:10:44 +0000
Message-ID: <CH3PR11MB7177F7B3A2C4C062848D6D29F87FA@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20260227221632.827046-1-vivek.kasireddy@intel.com>
 <20260227221632.827046-10-vivek.kasireddy@intel.com>
 <daa04cc8-c2ae-43f7-8e5c-a2e6d44b1f50@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185A75292BD4C70154A98CAF87EA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <90bb995b-30f0-4d0a-b574-773ef47d798b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <90bb995b-30f0-4d0a-b574-773ef47d798b@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|SN7PR11MB7589:EE_
x-ms-office365-filtering-correlation-id: d0f0f986-0a00-4635-59e0-08de78f3fc79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: G4mkHTVX2Li6J3J9SSsGlie76LgWZc8E1s+krV1XtfCe3UTMjXazhXxznAsfEITJ3gYNB27TelQkIl/gvBDB60I5SQ5co31fSNsX7pkQMC6pRxTAI3KbpWCAr6UegBAclKHY2/ANMDTwsiA6KQ2kSAzpyDRUZhLWAzAIHqH08ZRDyaCYnsW02ooEe9tvvzPVDDBpW/IfaQJr9woIZndONGjpkERdeENAo+LK11RAVCHzXIx3LgNrwy8591O2dibhgPFxUmAkXW+bojjfiy7TmpmsxbtI+ThXlWxn021l8BcL+Rxwm/Y+8PIFomluirFdkFvM8qmI8Py3Hbyx5shRkOXguor8xsDUWIzn/nLWIS1X3FZTQvGu09H4JsLTPT63XUgM4wWDzsTXWM/mN8XnVMSmSKyNoOrWKPTMqgbfVm3ddRZQ/+woS9xQ3pKVBWp84A6PkTCTOjVR16nK2WIojqHI85CGOJ/JesYminFdNJ/3mHn2ZVtGlrqK7qpcMLGumZM/OoXbcCaFhAN7pX2c9HtpMhXbNXptdTpBHcbzY1+tuP4HUi+r8p+vvBrbyn+0Eql42sK7ZZ6fsB1N2LRpGM/81ot56MtAGmJPibojD0VEjXm3UkaOKrI6bgHjvFmhw7jMEeIzLKkfWIMoheZ/Bh0jK1Ze44tMoZAIAZib5zimcQ4Y8r4rPM5KshWhZWtZm6hsb/DocY2028uFfYeX01tr/S8F4mIsw4lq25frG18BByNzHcHg0E2vn/fFqxtdfoExQZUfMRTpL6Rw6hgYh4rOgj7BaYfMxmP8/Jh5mnk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b45ZQfcFrZuiDzA7i5QCIocWP21IkRysgNBbxdIZFnrp5wAmlwMiOWGWYk?=
 =?iso-8859-1?Q?8hwPYMpanLnAuFClagUh8sW1qYjaslbY/rjPtf5tXeVB9wl/79jQK+4nSM?=
 =?iso-8859-1?Q?8/1wB3wnyzPo2Hg2we6BMUYUPaHPAZ4zZGEarcP/Gx/+QPlJ2WSmtHBSr2?=
 =?iso-8859-1?Q?vNZuQoq7TVvSAnE+9AYry73Z6tW5w/UunjHamjri1NyoOPFc+DRFVOQPOp?=
 =?iso-8859-1?Q?xZc7gZgSP15thqRCXG221IcygcWIxU3xTT6lApFHCyzTv9teqNvu8tNF6+?=
 =?iso-8859-1?Q?Sju6U7iOJTjpNQzrC26NvrcmCuFRPyeUoHzapFYiTZjBR85kpTCHzTBW4i?=
 =?iso-8859-1?Q?fZV7SDV5boXAIQQsh9BWbhzPqz3FzOtGHWcwdOJPUuiZXSK9rXtGAqxFdR?=
 =?iso-8859-1?Q?unnFpauhnfKTl7eiYVTHlrAwiTi2Z2yme/1gWJ6seSe8q+ZyyioEEbp7ES?=
 =?iso-8859-1?Q?aNeHUNr3M6vMF3Y62KNZuBRzeys2cRLih6POOfqcuVWKpykqs0WbKZLRbB?=
 =?iso-8859-1?Q?+XRLRGcZv4QAcXJVsbyNML92wWAe/e+zCfeWg2FvOVbzD0Ljh8ptV+JOgE?=
 =?iso-8859-1?Q?6sagUYIRRkVOdgf/OR2WisrqwtIkKD8T/odu3HKRr7Vm1ykbdgpfnMLNB2?=
 =?iso-8859-1?Q?MlEEUlDw7ijzFR7X+ahfpLs6qe+VJ50lAWJy/qU3Ux90ePWTgFhJNM6BDy?=
 =?iso-8859-1?Q?kTBx55rcWKcqHhfBk6XEev0iuuM8pmk1g0QUrxxAlSpqqyztTsnM6g7xdh?=
 =?iso-8859-1?Q?I3K6nxthbeFjGFTIWqVGfJvuBwmyqVoV/lYTbQJXZVF+1ka3f+48vIO9TD?=
 =?iso-8859-1?Q?BhmCvLIt0ug6mOjdJxG1knTgMGfAQ3tyVuAm72oZv+wrq02TZZFgRuOS9T?=
 =?iso-8859-1?Q?vNuc+cEFrPVvybQKTgvgF/IA5vG8F12pFzLzCCTXLktw+F40xxm/4gT2Wp?=
 =?iso-8859-1?Q?/CiRQT4/Z/PGhPCYfcr6TVqgH+DUa4Nwcb+4UyedT5PpCCSm+bZvLVCOUn?=
 =?iso-8859-1?Q?KaKzRmc9rFrmh3oPC3izHBEI5wo1cYYpGRnXyb6Y9Vfz6fHBSir5fCOELe?=
 =?iso-8859-1?Q?uyS5nra+JliYhQjhQeW4I5QDL9QZOlDoPdT71kpw16ufNlT7nPnyZ/y8T/?=
 =?iso-8859-1?Q?FUksVbBKg+rtCi2WQg11dEnL18M6edpqYMhtGqn73VAGnRuPdKbgORxr+q?=
 =?iso-8859-1?Q?mP/y8pRGLHWS3F1ArwsuESAZeKutrk4DGS5mWIWmQLVnHS65GXbF1ZGGet?=
 =?iso-8859-1?Q?tlVqAOhpj5CI6p18Fo1iJp2SvnqCROLrSk/6XsmSXt6CPRuRBhcbl6HDGC?=
 =?iso-8859-1?Q?wVgNjr3wUs50qG/XE+rm4ot8lb1ysKPWJs3ne55jTyN2f6s11xxJoKhec6?=
 =?iso-8859-1?Q?0RH8ZSJ2c/e+WeQ9uIk/reGjLuu1z8z0NvCH0KPIuOyjq9ZdCXiiHMKf/4?=
 =?iso-8859-1?Q?u8nwrTLDHDK2+n3X4PtJfca0uNBsYrRbH8RQJilENnfSBggcrEiK+xLs43?=
 =?iso-8859-1?Q?3WMWftSc2igcNmZXmBuoPmvx2751XN6bp1LtlLpJA3UmpTC+ZtDxgDZ616?=
 =?iso-8859-1?Q?xvFGSGsaepN2RXMihSuPbAA+67TQkgw/9PX/0shzZ6yqKCNQK1xt0CfD9p?=
 =?iso-8859-1?Q?GaKsIOsm6NqFJeI+vS9mNbPB2+be5xQe3+XuTQdf6/CPjmxG/1RnEfN0CQ?=
 =?iso-8859-1?Q?rMdWLMfX34V61a7UDbcBPzMmdnCLj5SlZ9TAoTrnWOEDFGlFOPbC4skKlZ?=
 =?iso-8859-1?Q?CTCKC+xxyKNUGBIQDTuEarsoKwAAmhVb45hV09C9UrLKaMnyvU2lCJYpvf?=
 =?iso-8859-1?Q?ZzhBGf90Ew=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f0f986-0a00-4635-59e0-08de78f3fc79
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 07:10:44.0855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfUE63fVamCfXlAKy5Ip2fBFA7IPfgaU1s8g827GkPDQ6oajPjeTykHQvikX6le7CiHPEzMBnrVFYikMaQtnSRHuuHm8BYngI7L2gTtWR0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7589
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v8 09/10] virtio-gpu-dmabuf: Improve error
> handling with 'Error **' and err enum
> >> On 2026/02/28 7:13, Vivek Kasireddy wrote:
> >>> Make the error handling more robust in virtio_gpu_init_udmabuf()
> >>> by introducing 'Error **' parameter to capture errors and using an
> >>> enum from VFIO to categorize Guest and Host errors. This allows
> >>> for better error reporting and handling of errors from
> >>> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/virtio-gpu-dmabuf.c | 61 ++++++++++++++++++++++++-
> ------
> >> ---
> >>>    1 file changed, 43 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index 8d67ef7c2a..b2badfc1bd 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -18,6 +18,7 @@
> >>>    #include "ui/console.h"
> >>>    #include "hw/virtio/virtio-gpu.h"
> >>>    #include "hw/virtio/virtio-gpu-pixman.h"
> >>> +#include "hw/vfio/vfio-device.h"
> >>>    #include "trace.h"
> >>>    #include "system/ramblock.h"
> >>>    #include "system/hostmem.h"
> >>> @@ -27,16 +28,18 @@
> >>>    #include "standard-headers/linux/udmabuf.h"
> >>>    #include "standard-headers/drm/drm_fourcc.h"
> >>>
> >>> -static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>> +static int virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>> +                                     Error **errp)
> >>>    {
> >>>        g_autofree struct udmabuf_create_list *list =3D NULL;
> >>>        RAMBlock *rb;
> >>>        ram_addr_t offset;
> >>> -    int udmabuf, i;
> >>> +    int udmabuf, i, fd;
> >>>
> >>>        udmabuf =3D udmabuf_fd();
> >>>        if (udmabuf < 0) {
> >>> -        return;
> >>> +        error_setg(errp, "udmabuf device not available or enabled");
> >>> +        return VFIO_DMABUF_CREATE_HOST_ERROR;
> >>
> >> I failed to point out one thing for naming of the enum. The name
> should
> >> express if the error is caused by invalid iov or something else. Then
> >> virtio-gpu decides how to recover the error; it's virtio-gpu who knows
> >> the iov is from the guest and decides to report a guest error, not
> vfio.
> >> Otherwise, it reports a host error.
> > So, it sounds like you are suggesting that there needs to be three
> enum
> > values:
> > enum {
> >      /* Guest is responsible for this error */
> >      VFIO_DMABUF_CREATE_GUEST_ERROR =3D -1,
> >      /* Guest is at fault as the IOVEC passed in is invalid */
> >      VFIO_DMABUF_CREATE_INVALID_IOV_ERROR =3D -2,
> >      /* Host is at fault for this error */
> >      VFIO_DMABUF_CREATE_HOST_ERROR =3D -3,
> > }
>=20
> vfio doesn't know if the guest or the host is responsible, so it cannot
> make use of VFIO_DMABUF_CREATE_GUEST_ERROR and
> VFIO_DMABUF_CREATE_HOST_ERROR.
>=20
> >
> > Or, please let me know in detail what changes you would like to see.
>=20
> A possible combination of values is as follows:
>=20
> - VFIO_DMABUF_CREATE_ERR_UNSPEC
> - VFIO_DMABUF_CREATE_ERR_INVALID_IOV
Just these two error types are needed? Should I completely drop
VFIO_DMABUF_CREATE_GUEST_ERROR and VFIO_DMABUF_CREATE_HOST_ERROR,
even for udmabuf errors?

Thanks,
Vivek

>=20
> I took the example of VIRTIO_GPU_RESP_ERR_UNSPEC and
> VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER for naming.
>=20
> >
> >>
> >>>        }
> >>>
> >>>        list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> >>> @@ -45,7 +48,8 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>        for (i =3D 0; i < res->iov_cnt; i++) {
> >>>            rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, fals=
e,
> >> &offset);
> >>>            if (!rb || rb->fd < 0) {
> >>> -            return;
> >>> +            error_setg(errp, "IOV memory address incompatible with
> >> udmabuf ");
> >>> +            return VFIO_DMABUF_CREATE_GUEST_ERROR;
> >>>            }
> >>>
> >>>            list->list[i].memfd  =3D rb->fd;
> >>> @@ -56,22 +60,30 @@ static void
> virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>        list->count =3D res->iov_cnt;
> >>>        list->flags =3D UDMABUF_FLAGS_CLOEXEC;
> >>>
> >>> -    res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >>> -    if (res->dmabuf_fd < 0) {
> >>> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> >>> -                    strerror(errno));
> >>> +    fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >>> +    if (fd < 0) {
> >>> +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl
> >> failed");
> >>> +        if (errno =3D=3D EINVAL || errno =3D=3D EBADFD) {
> >>> +            return VFIO_DMABUF_CREATE_GUEST_ERROR;
> >>> +        }
> >>> +        return VFIO_DMABUF_CREATE_HOST_ERROR;
> >>>        }
> >>> +    return fd;
> >>>    }
> >>>
> >>> -static void virtio_gpu_remap_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>> +static bool virtio_gpu_remap_dmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>> +                                    Error **errp)
> >>>    {
> >>> -    res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >>> -                         MAP_SHARED, res->dmabuf_fd, 0);
> >>> -    if (res->remapped =3D=3D MAP_FAILED) {
> >>> -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> >>> -                    strerror(errno));
> >>> +    void *map;
> >>> +
> >>> +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> res-
> >>> dmabuf_fd, 0);
> >>> +    if (map =3D=3D MAP_FAILED) {
> >>> +        error_setg_errno(errp, errno, "dmabuf mmap failed");
> >>>            res->remapped =3D NULL;
> >>> +        return false;
> >>>        }
> >>> +    res->remapped =3D map;
> >>> +    return true;
> >>>    }
> >>>
> >>>    static void virtio_gpu_destroy_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>> @@ -125,19 +137,32 @@ bool virtio_gpu_have_udmabuf(void)
> >>>
> >>>    void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> *res)
> >>>    {
> >>> +    Error *local_err =3D NULL;
> >>>        void *pdata =3D NULL;
> >>> +    int ret;
> >>>
> >>>        res->dmabuf_fd =3D -1;
> >>>        if (res->iov_cnt =3D=3D 1 &&
> >>>            res->iov[0].iov_len < 4096) {
> >>>            pdata =3D res->iov[0].iov_base;
> >>>        } else {
> >>> -        virtio_gpu_create_udmabuf(res);
> >>> -        if (res->dmabuf_fd < 0) {
> >>> +        ret =3D virtio_gpu_create_udmabuf(res, &local_err);
> >>> +        if (ret < 0) {
> >>> +            error_prepend(&local_err, "Cannot create dmabuf: ");
> >>
> >> This error_prepend() is redundant. The error messages
> >> virtio_gpu_create_udmabuf() emits already suggests they are
> problems
> >> with DMA-BUF.
> > Ok, I'll drop the error_prepend().
> >
> > Thanks,
> > Vivek
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>> +
> >>> +            if (ret =3D=3D VFIO_DMABUF_CREATE_GUEST_ERROR) {
> >>> +                qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                              "Cannot create dmabuf: incompatible
> memory\n");
> >>> +                error_free(local_err);
> >>> +                return;
> >>> +            }
> >>> +            error_report_err(local_err);
> >>>                return;
> >>>            }
> >>> -        virtio_gpu_remap_dmabuf(res);
> >>> -        if (!res->remapped) {
> >>> +
> >>> +        res->dmabuf_fd =3D ret;
> >>> +        if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
> >>> +            error_report_err(local_err);
> >>>                return;
> >>>            }
> >>>            pdata =3D res->remapped;
> >


