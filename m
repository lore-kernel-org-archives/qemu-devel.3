Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AFFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 19:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzLSf-00073c-He; Tue, 23 Apr 2024 15:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rzLSc-00073I-8p
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 15:05:47 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rzLSZ-0003O2-Hf
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 15:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713899144; x=1745435144;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1t5fCWetTSIljU3XiKuG8bP5xTK3RLkOETJieNdiQ/I=;
 b=TNwlXOn4ukiT/f7gTXRldVX5dx+amHguo+/SJ/zEv88djP0PoptuCqMx
 aBPoioN2w4QgaT08N3xYfDs/ecuoDOEwKhKQwKp+A9gKSRj6VdsAogNxY
 vd8Nj9/48UnKWL6YRFMfGgXyvdIcXPaYFIvYEt0WCxUOE8vIKTv1XCvSJ
 zFlu2C2BbS38NEU2rhlpMsTWYXf12J44FnVCNjbnU39pk2vofsqVVBGTy
 MhKg33oEVm2y6Ld9PbhfgUwF/NKSL9oOYngsl2CIO3aYhyS3fABryfr/5
 6YrlJ0yPDZjU369Fpdq9z5fWmcM3l0w/7AYLW1vaau7merHTM4+rw+GC/ g==;
X-CSE-ConnectionGUID: maFR1wbUTTW83VlcIckq7g==
X-CSE-MsgGUID: no6RPf8bQ+GlIMMlRRok3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="10045302"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="10045302"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 12:05:28 -0700
X-CSE-ConnectionGUID: HLew0CX1ROiSY2k3dSVIQw==
X-CSE-MsgGUID: lpcRpHSCSQCKgRZVIy4nbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="24527575"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Apr 2024 12:05:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 12:05:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 12:05:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 12:05:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6r5RawTn1ON3VONfptHFIlpkNG0DUqgX8UXlXsM4l9J55hl8eAxUfSY14sfiAYB7y8r6uj2Ye1HqCJBRrB0wRcIFMfOMr+HWqzGHDFSlzymBpxiIC+i9CguXVK+3vXB9acdqevT8shEpAcifsREPdy7ROiUA0GXUcYYEMxjwIm3mZdzQ3XKQBfP/P3SC1aSh2XrdWGGvYdKi8QhA72k5lK2FR40cC9YimkDwJ8cPrnq63g3kQsp2BaD0RMsdeAbQpcfA/JXFbL8qvLho6n9QgAAOpYr1Rcw9q7cEiUX3kCEDVAYw8SnT3ksCr9I2OM8EoNjuhry90zNWT1Op7vqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t5fCWetTSIljU3XiKuG8bP5xTK3RLkOETJieNdiQ/I=;
 b=PXu2/6woJZ5nf0FZ7F8gJ+2jqdXhqvEz9T83CNakMRrhEaBLnNP4AdMNek3sFkM7hmRwtjEWK6dumuNvrhWSEaLFRUaF5xR35EAf2aMGT5pBayrKEDxpb16z5g2yF+gk/wTIppLITXScwfRzRyvlyJeGt6PtnzVXfvuv6RmhaEoxA+oNsN6hZOSR1XRWD8LTgZ660ISgOPaKR7vBQ39qCHUlInwPV1a13BNTOUL1uALTE9ChEQehpzYnTWT7bfko9+BIb0dCeP6/pV9c0yUrksf46PkuoDjGY2/b0CR0zhhAHeovJH8fh9QDiAbf8OUjLoSFFUOqkZI8pgQgrsxjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 19:05:20 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 19:05:20 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Subject: RE: [PATCH v10 2/6] ui/console: new dmabuf.h and dmabuf.c for
 QemuDmaBuf struct and helpers
Thread-Topic: [PATCH v10 2/6] ui/console: new dmabuf.h and dmabuf.c for
 QemuDmaBuf struct and helpers
Thread-Index: AQHalSjw2EuC+4s9ok68yKDtBlFWH7F15KCAgABSe0A=
Date: Tue, 23 Apr 2024 19:05:20 +0000
Message-ID: <PH8PR11MB6879DF1DEEF635AC793CE6D6FA112@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240423022253.1003295-1-dongwon.kim@intel.com>
 <20240423022253.1003295-3-dongwon.kim@intel.com>
 <ZifAdRBCndQeOAwh@redhat.com>
In-Reply-To: <ZifAdRBCndQeOAwh@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|PH7PR11MB6476:EE_
x-ms-office365-filtering-correlation-id: e851de9b-5a43-464c-93f6-08dc63c85227
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZTlQMUdhZFpLSlFLZ2YrU1dTT2xCRVg4NS9ydVlxUURnbzg1QWF3bDNEODly?=
 =?utf-8?B?RHg0NURsbU1pTzdYby95ckR5T2ZVQWZNRlMvMlhRZE1yODlLcExKRFlkTmxQ?=
 =?utf-8?B?VGRFVnpIZXNXU051OXlZdm8xajcxb3lab2hlTEFRVEYrNHB4Z050UnB6Znpn?=
 =?utf-8?B?a2RVTzl6UW1vQUlvS2hreU9FN1M0WldkeE1YUWsxazJlYVlNNmJNMTVKWlI3?=
 =?utf-8?B?S2k1M0k1aXdyaXhUV1oxM204S0cyWTVBTE52MzE5dVJsRDNNRkhRbWU4RGhj?=
 =?utf-8?B?NVFWQmN0TEpXQUdJOVRXMWtqeS9IOE50c2FKMnJheWxDWUQzWWgyZm8xNUkv?=
 =?utf-8?B?bFA4M0NuWDB2V1pJUFd3STRoTjBxdHFzSEkxaTRNa1BWYTNHZlZtdlBrd3JZ?=
 =?utf-8?B?OUJoc2VmMjRFZGk4aEUvWkNPZzlxYkdRak1WMGlMU0d5TEFPeE9taWhsM3ZK?=
 =?utf-8?B?NlJ6eERZL0I0a3dnMlFwTGZUNDBtYTBEbk9aeTIwMGUrT2Qya0FGbjd3bUkv?=
 =?utf-8?B?NUNETHRrQTVXbEdoOG5DVG1SN1NXVFhsYkFhQ2lTZGhtdXB6dEI5MWZraWxu?=
 =?utf-8?B?Wm1PRlBYY09ZdnVoMnVGK20xc2VUVURDNmRCNE9UOE41R0hUNVBJQmMwU1lJ?=
 =?utf-8?B?SU1xaVFmOWxYNE1YUDNoT3ZHMkdoSEFIWm9rSU5qcHlGNzg5MFV4MVdoOVA3?=
 =?utf-8?B?RWpwcVB5L0V5QXRTZW1DaHBZTEwrMmZNUGdxUlgwUlU5SkJ1b3B6M0ovSU9z?=
 =?utf-8?B?SnZIdmtKSFdWNGVsMk1iS2p0OFZLajNUbmtTSlJXMklHdlRJR0RjWVdQdWs1?=
 =?utf-8?B?OHRlTkJIdHhlTG05S3VJRmVpMklaOWF3MCs4UTJvRVlHMDRKVzZKdEs3NnRW?=
 =?utf-8?B?MFFOU2hBRDh0RG5SRzRJcUdSclFzemE0T2tBMjJFMS9oMk80WHQySW52R2hD?=
 =?utf-8?B?dVVsRkN1SHc4KzhzNDNDR3FQOExpUzhpRnZNazM2NjRmU2EyZUUyOXA5RFNC?=
 =?utf-8?B?WlF6TUhmVE1POWdGbEU5dVNpQTd1dEdQV2VQeHNhOEM5cDRFWGo2MnR4VGVN?=
 =?utf-8?B?dW5ybGJvOTVEK1lFTE9kc3pnWkhLTGxYSzd3SVNJckdEMCtFK2Z6VDdHbERJ?=
 =?utf-8?B?NTVRZjRhb1lWQjM4WHBvbjlpaXdZSi9QSVJwZnkraUk5Vk9KTVRkOGdHSk5I?=
 =?utf-8?B?dC9IQzd4UW96RzBNY3BnUFhzUzAyV2pvcVFzMWZVTlBUZUYzbVlGUWY5VFda?=
 =?utf-8?B?NmRHYndUUG9Penh3dEFNdXVuRXFvcVZoL3dSUXRNaDE0VUx4MGhhUWhkUnJs?=
 =?utf-8?B?VDUvWThvclBwS0d2OWlGNHRRb0MvYmd6WWJoZ096UVFrelYvc1BxMWRMbmNp?=
 =?utf-8?B?QndzaVhnMHRlbkRERHN0Zk1SYW5Fekc4Yzc2eTRMS3lBK1JObUxMOCtTTU5G?=
 =?utf-8?B?ZHlWMkhINDl5RVA4ZXRUVTZYRHFPbGp6Z0h5Q3pkN0ZPQUhTcWtVSUJFeXBY?=
 =?utf-8?B?MTJjMHE1VGZ2d2ExSkFoY0JTUmFNYTRhRm1UU016WEFKWER1ZU5ERGg1T2hk?=
 =?utf-8?B?RFo4M3p0L241cEpnRStGc1d4MUI2VXh0eEo1UkF0eFFwY25SbWswRjl0ME4w?=
 =?utf-8?B?dzhIMTFEMXU4aDdoN3U0NzhNTXVHOVhyOHZkbFZYdndaSnkyaFN3QzVBQjZL?=
 =?utf-8?B?RDBpNGM4eFU5bHE5bkVSQjRKWDc3a3BOeU14KzQyVFY0VXRyYmJ5eUl3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2p3c2FBcnJSVll3ZFh3VU9tc0dnSEFyWWlNVmd4cW4wRGJvSENySmtBVDE4?=
 =?utf-8?B?QVNwbUFLN3o4eE9nRWh1MUVIck1nWm1xdnJ1UlRlK05QWUlURzRpWFNJa1Ni?=
 =?utf-8?B?M2R4c0trdFhjMWNIcnNpSG1IdkE1d1VoY1p1ZGJVSFlhK0x6dUZoeXArc0x1?=
 =?utf-8?B?Wmg4TjV0S0Z0alp1TkFGMFl2N2ZWekVNMy9iQ2ppZjVRclBEaVpucU9POTdt?=
 =?utf-8?B?SFBucUYySU1jaldVcUZYVDhmbGFBRWU2UU80ZnpFRC9zMExINGY3MHd4WGQv?=
 =?utf-8?B?Q2J1MU9BUk1hQTI1RXhhcGFDT2FLd0ZqZ0s0L1pjcVI2VUVkYksyR0xWZ3JC?=
 =?utf-8?B?bnBjWjc4WUNBbkk3R0RZYzdTYThjUW9MczFIUTNoWnpkQlBnNURHK005YWpN?=
 =?utf-8?B?WngvcUNKM3hOcHo4dzRXd01QaHlad3I1Rno1SmVPQzc1bkEzeFFQZFg5VEd1?=
 =?utf-8?B?b2NJYWJuRHU1WDRlM2tvbTFOdS92ZWtXT1ZFSU1iTWlYdEhnMlhhZ0tSSE1L?=
 =?utf-8?B?c3Z6Vy9La3B4TFZXUzFWbWsraTdhK3NUUDJJaG01MkIvZWlQU2x2M1VRa1ZM?=
 =?utf-8?B?ZDdEejV3N3AzT1ZaTUVtdldSRmlUTWNqQm5XYUp2NThhRHdmMmVuK3hGa0Nn?=
 =?utf-8?B?S0NnL3h1b0ZuWktDQ0JnYmlwdzhpeTF0ZTlQQlhrdzdqNlVFKzYyR0ZuZjZS?=
 =?utf-8?B?YWEwUE9xZDZaSVppemh5dnFLWmxuajZzeFFWZHBPdDNrZDIvc09ZN1ZCVGV3?=
 =?utf-8?B?RjVyUEFTcU4vTmtNY2dxMGZhcFdzVGQ3WjNCTHd5NGgzbkxHUkZUNFFxSEhS?=
 =?utf-8?B?WE1ySFBRRUdvNTRYNXRhMXlLUGgzK2psbm93Yit1anZseTQ0VkFDY0xKL2xZ?=
 =?utf-8?B?Q2Q4V3AxSjhYZnlXOW9JOGFacGdZTVFDcGVvWjNmSDk3bXhvYWh4czJtaGVk?=
 =?utf-8?B?SUtBS2FnVkwyZU5RVlNtbWhCNnBrWWVKNkxxL3hYbGp3ZE45Sld1aDlMV3pC?=
 =?utf-8?B?b2FBeXp5ZGcvSUtMMEVSTDJ0Mm1MU1h3ampqaW5kaEZaa1ErS21ScVI3ZGZq?=
 =?utf-8?B?akJHckxpcjNyemxLeDRSa1Vrb3JkRmRhY1RINzZwakM2R0NnQnhNQWNoMEps?=
 =?utf-8?B?MkMrSjIrYjE4TFRXcjVsQ0JEZmNTZFRlNGo2ejFtOGRtWkM1MVdpZ0NOZXJU?=
 =?utf-8?B?OGRJQmZCQUtBRTZ0VkJVN2dtQTczamc3eWltS1l5TmtobmhyRFRnVXlZWXcx?=
 =?utf-8?B?M0s3aFVDUjY1NS95M1hWWlVZUUVONFVFYWVxeVQzaVJKOFVWbkk3VTBEanNx?=
 =?utf-8?B?ellEc1hjeWZvenlHS2J3dFBUQlM5Z09veDV4R0ozN2ZXZys0REQ0SURFSzMx?=
 =?utf-8?B?MnE2SVJHRnpMSzloM0xkc3JJV09VREJLdEZ1dkZ5aXRjQkVQOW9nTXdsbVRw?=
 =?utf-8?B?L0V5WXJJSW05Zk03MndTZnJ0R0N3bkNnUnIwWnAxM1hxRjNzZVRqb1BsZU9E?=
 =?utf-8?B?dGZkcmtnZWlYc2VjTVFrdDV2Q2lYczUwcnFLb3lORUhRbnNsV3c0YXh2bWxa?=
 =?utf-8?B?S1kwUmU0OTNTRVZRbGxqcnRRQUpIOFhrZFk5OHdtMXBaUzFua09US01Halcz?=
 =?utf-8?B?SVhIbVdrMkRzOHgrY2RZYnlaNzRTZEFDeG1PSWZpcmVvamxuUVU1TURSYzRq?=
 =?utf-8?B?b3V1YlpBSXdoNU93WTdGNUgzY0Y4d20yNXdaWWViaTduaHFzUVczMHlNcVNz?=
 =?utf-8?B?ZUdxM0FtQlpXek4yazE1V3dmNitWSzVablphUXlpcHgxVHkrWTQ5bnB2SlRE?=
 =?utf-8?B?bmNWbGdYcEF2K0dPMWJocU05Ritsd0Y4SlpkRjN6ZVBLbTBjRWNkL0pvNkp4?=
 =?utf-8?B?NjFOYzVMTWN5ckgycHFNT2lycWpWb3VKeGRNVDhRRVA4S2RsL3JoeXRLTXha?=
 =?utf-8?B?Mk9zN1VTbmRQTzBGUEF6L1IwQjlDekl4VjlSTVZoUXRqTDAvVlZLWE4wYTRV?=
 =?utf-8?B?N2pzdUN0UjZaSlZEZnVadHdNVHVxN3Z6R1U1SloxV28vK1kzbjkxU1MwM2lm?=
 =?utf-8?B?SUl1c3dLWlQyS2tuTDk1YUpBbUdRYXc2RFgzUGhlS29wNEN3UmRwN0dFbFRW?=
 =?utf-8?Q?rZd0BIAr/YyD5irxkwA36GXVU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e851de9b-5a43-464c-93f6-08dc63c85227
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 19:05:20.2375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ic7r+2WrQRdoc5evQx6g5R9mHEox5rYMUyZb+taCD03sMos8Ka4NstKcmTQ7LMVoit1sZ3ZNB6ZfnzChYQb1xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFw
cmlsIDIzLCAyMDI0IDc6MDcgQU0NCj4gVG86IEtpbSwgRG9uZ3dvbiA8ZG9uZ3dvbi5raW1AaW50
ZWwuY29tPg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBtYXJjYW5kcmUubHVyZWF1QHJl
ZGhhdC5jb207DQo+IHBoaWxtZEBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEw
IDIvNl0gdWkvY29uc29sZTogbmV3IGRtYWJ1Zi5oIGFuZCBkbWFidWYuYyBmb3INCj4gUWVtdURt
YUJ1ZiBzdHJ1Y3QgYW5kIGhlbHBlcnMNCj4gDQo+IE9uIE1vbiwgQXByIDIyLCAyMDI0IGF0IDA3
OjIyOjQ5UE0gLTA3MDAsIGRvbmd3b24ua2ltQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBE
b25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiA+DQo+ID4gTmV3IGhlYWRlciBh
bmQgc291cmNlIGZpbGVzIGFyZSBhZGRlZCBmb3IgY29udGFpbmluZyBRZW11RG1hQnVmIHN0cnVj
dA0KPiA+IGRlZmluaXRpb24gYW5kIG5ld2x5IGludHJvZHVjZWQgaGVscGVycyBmb3IgY3JlYXRp
bmcvZnJlZWluZyB0aGUNCj4gPiBzdHJ1Y3QgYW5kIGFjY2Vzc2luZyBpdHMgZGF0YS4NCj4gPg0K
PiA+IHYxMDogQ2hhbmdlIHRoZSBsaWNlbnNlIHR5cGUgZm9yIGJvdGggZG1hYnVmLmggYW5kIGRt
YWJ1Zi5jIGZyb20gTUlUIHRvDQo+ID4gICAgICBHUEwgdG8gYmUgaW4gbGluZSB3aXRoIFFFTVUn
cyBkZWZhdWx0IGxpY2Vuc2UNCj4gPiAgICAgIChEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5n
ZUByZWRoYXQuY29tPikNCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTogTWFyYy1BbmRyw6kgTHVyZWF1
IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+ID4gQ2M6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gPiBDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gPiBDYzogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNp
cmVkZHlAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmd3b24gS2ltIDxkb25nd29u
LmtpbUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvdWkvY29uc29sZS5oIHwgIDIw
ICstLS0tDQo+ID4gIGluY2x1ZGUvdWkvZG1hYnVmLmggIHwgIDY0ICsrKysrKysrKysrKysrKw0K
PiA+ICB1aS9kbWFidWYuYyAgICAgICAgICB8IDE4OQ0KPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gIHVpL21lc29uLmJ1aWxkICAgICAgIHwgICAxICsN
Cj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAyNTUgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0p
ICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBpbmNsdWRlL3VpL2RtYWJ1Zi5oICBjcmVhdGUgbW9k
ZSAxMDA2NDQgdWkvZG1hYnVmLmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VpL2Nv
bnNvbGUuaCBiL2luY2x1ZGUvdWkvY29uc29sZS5oIGluZGV4DQo+ID4gMGJjN2EwMGFjMC4uYTIw
OGE2OGI4OCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VpL2NvbnNvbGUuaA0KPiA+ICsrKyBi
L2luY2x1ZGUvdWkvY29uc29sZS5oDQo+ID4gQEAgLTcsNiArNyw3IEBADQo+ID4gICNpbmNsdWRl
ICJxYXBpL3FhcGktdHlwZXMtdWkuaCINCj4gPiAgI2luY2x1ZGUgInVpL2lucHV0LmgiDQo+ID4g
ICNpbmNsdWRlICJ1aS9zdXJmYWNlLmgiDQo+ID4gKyNpbmNsdWRlICJ1aS9kbWFidWYuaCINCj4g
Pg0KPiA+ICAjZGVmaW5lIFRZUEVfUUVNVV9DT05TT0xFICJxZW11LWNvbnNvbGUiDQo+ID4gIE9C
SkVDVF9ERUNMQVJFX1RZUEUoUWVtdUNvbnNvbGUsIFFlbXVDb25zb2xlQ2xhc3MsDQo+IFFFTVVf
Q09OU09MRSkgQEANCj4gPiAtMTg1LDI1ICsxODYsNiBAQCBzdHJ1Y3QgUUVNVUdMUGFyYW1zIHsN
Cj4gPiAgICAgIGludCBtaW5vcl92ZXI7DQo+ID4gIH07DQo+ID4NCj4gPiAtdHlwZWRlZiBzdHJ1
Y3QgUWVtdURtYUJ1ZiB7DQo+ID4gLSAgICBpbnQgICAgICAgZmQ7DQo+ID4gLSAgICB1aW50MzJf
dCAgd2lkdGg7DQo+ID4gLSAgICB1aW50MzJfdCAgaGVpZ2h0Ow0KPiA+IC0gICAgdWludDMyX3Qg
IHN0cmlkZTsNCj4gPiAtICAgIHVpbnQzMl90ICBmb3VyY2M7DQo+ID4gLSAgICB1aW50NjRfdCAg
bW9kaWZpZXI7DQo+ID4gLSAgICB1aW50MzJfdCAgdGV4dHVyZTsNCj4gPiAtICAgIHVpbnQzMl90
ICB4Ow0KPiA+IC0gICAgdWludDMyX3QgIHk7DQo+ID4gLSAgICB1aW50MzJfdCAgYmFja2luZ193
aWR0aDsNCj4gPiAtICAgIHVpbnQzMl90ICBiYWNraW5nX2hlaWdodDsNCj4gPiAtICAgIGJvb2wg
ICAgICB5MF90b3A7DQo+ID4gLSAgICB2b2lkICAgICAgKnN5bmM7DQo+ID4gLSAgICBpbnQgICAg
ICAgZmVuY2VfZmQ7DQo+ID4gLSAgICBib29sICAgICAgYWxsb3dfZmVuY2VzOw0KPiA+IC0gICAg
Ym9vbCAgICAgIGRyYXdfc3VibWl0dGVkOw0KPiA+IC19IFFlbXVEbWFCdWY7DQo+ID4gLQ0KPiA+
ICBlbnVtIGRpc3BsYXlfc2Nhbm91dCB7DQo+ID4gICAgICBTQ0FOT1VUX05PTkUsDQo+ID4gICAg
ICBTQ0FOT1VUX1NVUkZBQ0UsDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWkvZG1hYnVmLmgg
Yi9pbmNsdWRlL3VpL2RtYWJ1Zi5oIG5ldyBmaWxlIG1vZGUNCj4gPiAxMDA2NDQgaW5kZXggMDAw
MDAwMDAwMC4uN2E2MDExNmVlNg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRl
L3VpL2RtYWJ1Zi5oDQo+ID4gQEAgLTAsMCArMSw2NCBAQA0KPiA+ICsvKg0KPiA+ICsgKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiA+ICsgKg0KPiA+ICsgKiBR
ZW11RG1hQnVmIHN0cnVjdCBhbmQgaGVscGVycyB1c2VkIGZvciBhY2Nlc3NpbmcgaXRzIGRhdGEN
Cj4gPiArICoNCj4gPiArICogVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBv
ZiB0aGUgR05VIEdQTCwgdmVyc2lvbiAyIG9yIGxhdGVyLg0KPiA+ICsgKiBTZWUgdGhlIENPUFlJ
TkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4NCj4gPiArICovDQo+ID4gKw0KPiA+
ICsjaWZuZGVmIERNQUJVRl9IDQo+ID4gKyNkZWZpbmUgRE1BQlVGX0gNCj4gPiArDQo+ID4gK3R5
cGVkZWYgc3RydWN0IFFlbXVEbWFCdWYgew0KPiA+ICsgICAgaW50ICAgICAgIGZkOw0KPiA+ICsg
ICAgdWludDMyX3QgIHdpZHRoOw0KPiA+ICsgICAgdWludDMyX3QgIGhlaWdodDsNCj4gPiArICAg
IHVpbnQzMl90ICBzdHJpZGU7DQo+ID4gKyAgICB1aW50MzJfdCAgZm91cmNjOw0KPiA+ICsgICAg
dWludDY0X3QgIG1vZGlmaWVyOw0KPiA+ICsgICAgdWludDMyX3QgIHRleHR1cmU7DQo+ID4gKyAg
ICB1aW50MzJfdCAgeDsNCj4gPiArICAgIHVpbnQzMl90ICB5Ow0KPiA+ICsgICAgdWludDMyX3Qg
IGJhY2tpbmdfd2lkdGg7DQo+ID4gKyAgICB1aW50MzJfdCAgYmFja2luZ19oZWlnaHQ7DQo+ID4g
KyAgICBib29sICAgICAgeTBfdG9wOw0KPiA+ICsgICAgdm9pZCAgICAgICpzeW5jOw0KPiA+ICsg
ICAgaW50ICAgICAgIGZlbmNlX2ZkOw0KPiA+ICsgICAgYm9vbCAgICAgIGFsbG93X2ZlbmNlczsN
Cj4gPiArICAgIGJvb2wgICAgICBkcmF3X3N1Ym1pdHRlZDsNCj4gPiArfSBRZW11RG1hQnVmOw0K
PiA+ICsNCj4gPiArUWVtdURtYUJ1ZiAqcWVtdV9kbWFidWZfbmV3KHVpbnQzMl90IHdpZHRoLCB1
aW50MzJfdCBoZWlnaHQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDMyX3Qgc3RyaWRlLCB1aW50MzJfdCB4LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQzMl90IHksIHVpbnQzMl90IGJhY2tpbmdfd2lkdGgsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgYmFja2luZ19oZWlnaHQs
IHVpbnQzMl90IGZvdXJjYywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1aW50NjRfdCBtb2RpZmllciwgaW50MzJfdA0KPiA+ICtkbWFidWZfZmQsDQo+IA0KPiBTaG91
bGQgYmUgJ2ludCcgbm90ICdpbnQzMl90JyBmb3IgRkRzLg0KPiANCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBib29sIGFsbG93X2ZlbmNlcywgYm9vbCB5MF90b3ApOw0K
PiA+ICt2b2lkIHFlbXVfZG1hYnVmX2ZyZWUoUWVtdURtYUJ1ZiAqZG1hYnVmKTsNCj4gPiArDQo+
ID4gK0dfREVGSU5FX0FVVE9QVFJfQ0xFQU5VUF9GVU5DKFFlbXVEbWFCdWYsDQo+IHFlbXVfZG1h
YnVmX2ZyZWUpOw0KPiA+ICsNCj4gPiAraW50MzJfdCBxZW11X2RtYWJ1Zl9nZXRfZmQoUWVtdURt
YUJ1ZiAqZG1hYnVmKTsNCj4gDQo+IEFnYWluIHNob3VsZCBiZSAnaW50JyBub3QgJ2ludDQyX3Qn
DQo+IA0KPiBJIHRoaW5rIHRoZXJlIG91Z2h0IHRvIGFsc28gYmUgYQ0KPiANCj4gICBpbnQgcWVt
dV9kbWFidWZfZHVwX2ZkKFFlbXVEbWFCdWYgKmRtYWJ1Zik7DQo+IA0KPiB0byBkbyB0aGUgZHVw
KCkgY2FsbCBpbiBvbmUgZ28gdG9vDQo+IA0KPiA+IGRpZmYgLS1naXQgYS91aS9kbWFidWYuYyBi
L3VpL2RtYWJ1Zi5jIG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4DQo+ID4gMDAwMDAwMDAwMC4u
ZjQ0N2NjZTRmZQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi91aS9kbWFidWYuYw0KPiAN
Cj4gPiArDQo+ID4gK3ZvaWQgcWVtdV9kbWFidWZfZnJlZShRZW11RG1hQnVmICpkbWFidWYpDQo+
ID4gK3sNCj4gPiArICAgIGlmIChkbWFidWYgPT0gTlVMTCkgew0KPiA+ICsgICAgICAgIHJldHVy
bjsNCj4gPiArICAgIH0NCj4gPiArDQo+IA0KPiBJIHRoaW5rIHRoaXMgbWV0aG9kIHNob3VsZCBi
ZSBtYWRlIHRvIGNhbGwNCj4gDQo+ICAgcWVtdV9kbWFidWZfY2xvc2UoKQ0KPiANCj4gdG8gcmVs
ZWFzZSB0aGUgRkQsIGlmIG5vdCBhbHJlYWR5IHJlbGVhc2VkLCBvdGhlcndpc2UNCj4gdGhpcyBt
ZXRob2QgY291bGQgYmUgYSByZXNvdXJjZSBsZWFrLg0KIA0KW0tpbSwgRG9uZ3dvbl0gIFNvIHlv
dSBtZWFuIHRoaXMgY2xvc2UgY2FsbCBzaG91bGQgY2xvc2UgYWxsIEZEcyBpbmNsdWRpbmcgZHVw
ZWQgRkRzLCB3aGljaCBpbXBsaWVzIHdlIHNob3VsZCBpbmNsdWRlIHRoZSBsaXN0IG9mIGR1cGVk
IEZEIGFuZCBpdHMgbWFuYWdlbWVudD8NCg0KID4gDQo+ID4gKyAgICBnX2ZyZWUoZG1hYnVmKTsN
Cj4gPiArfQ0KPiA+ICsNCj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQo+IC0tDQo+IHw6
IGh0dHBzOi8vYmVycmFuZ2UuY29tICAgICAgLW8tDQo+IGh0dHBzOi8vd3d3LmZsaWNrci5jb20v
cGhvdG9zL2RiZXJyYW5nZSA6fA0KPiB8OiBodHRwczovL2xpYnZpcnQub3JnICAgICAgICAgLW8t
ICAgICAgICAgICAgaHR0cHM6Ly9mc3RvcDEzOC5iZXJyYW5nZS5jb20gOnwNCj4gfDogaHR0cHM6
Ly9lbnRhbmdsZS1waG90by5vcmcgICAgLW8tDQo+IGh0dHBzOi8vd3d3Lmluc3RhZ3JhbS5jb20v
ZGJlcnJhbmdlIDp8DQoNCg==

