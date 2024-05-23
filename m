Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD14C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA45V-0002mf-OR; Thu, 23 May 2024 04:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA45S-0002dp-2I; Thu, 23 May 2024 04:46:10 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA45M-0006iA-9I; Thu, 23 May 2024 04:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716453964; x=1747989964;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WW/lZfnsn0mKH6/gDEtHboWbnuN3wdYbJ8qjVQKcivo=;
 b=Ao64k2W6UmM/XDe/CXFoFlC918jie53EFcx/qQBxU4/L41DnhxaOViiH
 xsUhyArpvRgsJOfJkSP5nvZfXbDkFRyJ7nSvRIWXv2qDREYC+wKqATb/S
 ewX/vUAkXyeDFgYfyjQvhMkp1nFuscox4ro0sXWeDULCXjB2LgJ3/Hxqy
 BTQOq7jtE3khLWbVyg7j+46hYIu8SVl+/S8lFOBvQ2itU1Gq1H0JnIfeT
 hHcwBsJ91kc1N4DyI68vUJ6y61TIzlJ/VVBrwvBMXxChEXcIAZ1Znpi/D
 fAnfA1qvcpLz6+9HWJ/7al/ofeOUnkeHYP8dmrPx95tEjDhZUn/X6MBtF A==;
X-CSE-ConnectionGUID: d+xRg2oYSFyVRgDo+XBxuw==
X-CSE-MsgGUID: 5/LgZHDDTeKwbgRkf4MRXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23329885"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="23329885"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 01:46:00 -0700
X-CSE-ConnectionGUID: 59S/Z/PRSdST2FgWkEwyTg==
X-CSE-MsgGUID: 0TIWKG/XRUierIMD3NyTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="34133770"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 01:46:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:46:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 01:46:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 01:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv6pO4wYmv7vss6vr//UEZV0MEDV2s9z7TLp64OjGKvRKfGvgZDhMxcingcEbHpQwTlnpa8fk8MVKeE5DT0FKjp1nsFA6LhGjBxyKetwueLls5jEepezwtpWxKLnuTzBPN1ZiXNiuikllYLZwGTMRZ2nsmLqMgu+yndYI2hwE9VZoPAtm6/+JbpfpgVRNuIITKKGUoeMGOfUsHUazfXPDzeVhVVpLiCymHtnTo+5c94USNuO+XZ5JvCeZWLuBFvkIUrTlqC35tGdtRHWjOVp82SnUZ5N2oRjA2BndmYGNF0qw3ugujiLN0NpbMTkttQ8XJZueH+0ErCobXYmIuRBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW/lZfnsn0mKH6/gDEtHboWbnuN3wdYbJ8qjVQKcivo=;
 b=HcXTiUoJQD947yGDHciJy+zYCcvIqnAffPwdf7UYidVuICiEnDMmPCDdahL0hriupSLEjdlwYta5lrbrFzJhAQH3qiJB5okvQlBFD9qmPW3djFPFfOMVGCaplDLEvb3OvH98CbNarh9KJgodazzRfvS6ZHXJ4UdlO8Z+PchnbUlmPGarVabgr3MKm6gjss+urRrysQgqKg/YbbhODHJGuSQ3IZr3AL579HPj21ufDi1h8ZzRj3tbQT6lQk9TYRlSRmOU7ahm6kgHjeT08J0BlrJb9V5HX4BGtHVUv61lzl3IxieM1pohHWZpKJ0qsMAe9tyIrdZ1fFm7MU2X5ZubDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 08:45:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 08:45:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: RE: [PATCH 7/7] vfio/{ap, ccw}: Use warn_report_err() for IRQ notifier
 registration errors
Thread-Topic: [PATCH 7/7] vfio/{ap,ccw}: Use warn_report_err() for IRQ
 notifier registration errors
Thread-Index: AQHarGnRQ9lJ7czIVE2c06f4QVkCprGkglNA
Date: Thu, 23 May 2024 08:45:53 +0000
Message-ID: <SJ0PR11MB6744CFC57BF84CF787C8D11D92F42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-8-clg@redhat.com>
In-Reply-To: <20240522170107.289532-8-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4849:EE_
x-ms-office365-filtering-correlation-id: 891e01e6-23bb-4dee-8d51-08dc7b04c173
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cHI3b3BwUG1jZTc3Z09ENlhtRm5CZVpvVnU3dkVjRkF6bkRHZEgxNmhNbU5q?=
 =?utf-8?B?VHFpeS9Jb05ZQ3o5VmRzdTFEUUpzRFhHWmtHZElYc1RGN0NOZk5xNnR1VXNE?=
 =?utf-8?B?bGFFZFpIRWtMK09pc3lvd2V1QU5TMk02a2ZsVXBlZlVOWkYzV0VkQmwvNllv?=
 =?utf-8?B?NU5yQ2l0UVJaVWVJQm1Scll5WnY1cGQ4eVpuV29VM3FoK1paUGZBUyttenVV?=
 =?utf-8?B?RW9qTGE0NE9iMm9mNEZGV1NDYytrSi9RVzZsRFdqaGd1L2dlUXJlNVpESGdy?=
 =?utf-8?B?QUdSTTFBWE5HcmV1eHdnUEphekxHK3NmT1RiWDR2V0F3SGl1cStTeVJmV2VR?=
 =?utf-8?B?UHpXN2JHamxWajJGSHVXaERxMmMraDcwMXpQQnBlZm5MUmlrOHJUdlFrTy9p?=
 =?utf-8?B?dzJpeWo2MkxEVHVBTGZ6Yk1Va1NZVm1vL0lYUHdsYis5NDJXeEFtcERNT3ZI?=
 =?utf-8?B?Kyt5SGdPcm1nbUR6VGZSK3NyNm9CRjdTcDZ3ajhXN1Q4cmN0Q1ZHeHFXOThF?=
 =?utf-8?B?QVJtc0diWmNqbnI2Tm52S0RkekhneFMxUytkUGVqRnQ2SGlPbnJLQ0ZidzFC?=
 =?utf-8?B?cXc4SVhjZG9iQTZWYnM2ZVpXdTh0Z2dzMUtFWTZqTTBpbE85ZTZ2bDJMazFh?=
 =?utf-8?B?eDhRc1dpdUIyTUlLc09xS1N1RWxjeFVwZTVuRlBzekt4WVVaQ3g1RjR3NERz?=
 =?utf-8?B?bHhEbjk3Yi90WFFLZ2phTXdJWXJLTEVEVVZxejUxbCtYYU1TbHE4WE16WjF6?=
 =?utf-8?B?eTMxTVluTFE0RWVKWUxQM1lxaGNMUDlMVW5aTWJKaVJHRG84clVwVUEwNmpr?=
 =?utf-8?B?Mzl5cXhOZUc0Vml2UzgvWmJHNFNsdElJZm5tODVZMUUzbkIrOGxFYWdhNGI1?=
 =?utf-8?B?MW5FUzRwVXlMbGU2NDBoMy9QektOUjVsZnNDQmM0T0pMKzRBT1RhQS9sRHp5?=
 =?utf-8?B?OUVZU0ZJdEQveTYweWQ5NHhyZ0hoV1ZlYlVJRnJIaDFDeWJyS0dSdXc3VzNW?=
 =?utf-8?B?N0dXVjMxS1gxS25tT0tOTzRiMTNhNmdJdkZrbVY0WGdCcTRLdUo2ZDU3Z0t4?=
 =?utf-8?B?Q09KN3NFaFFFMzRMYXVUbnZqMWpTZnkzNWh2SGtRN1dDOGJOb0N2dlRuQ3lv?=
 =?utf-8?B?bm10Q2JkRzlCUUpscUgyWmZFekc3V1RlMnJmbTJUSEI4SDNza0N0dkZnZU5a?=
 =?utf-8?B?TnUvalVrUllHMGsxNXM1UlM2ZHpKSEVVTW9IaUNhZWMvV1orZzVvNnZHY0pE?=
 =?utf-8?B?dlBUNFlrdjAyeERmcHJSeldjQUREc0VLRjN4R0NTKzNCZkY0WGtCSTlzd0Ns?=
 =?utf-8?B?Rk5zcDcvTDhPeW8yZWxybC9OZ1lKQkxDV1QyV3EyKzYrMWEvbmVLMzZrcThn?=
 =?utf-8?B?UnFXL3ppeTZ6d3c3emQ5K0FmcWpvbU5CKzFmRWdLMmllbEZHditMT0FrcU9O?=
 =?utf-8?B?VkFQOVZZVDh6VHVkcWlyODArYnV1WU13NEJzaE81b1RGRjI5T3VoSmlVQWhG?=
 =?utf-8?B?VkdTbWZqWlA4SlMxNDJ5MUVzSHhkbW1PbzU5RVR5KzVJL09aQ0syNUZibzNE?=
 =?utf-8?B?MXBLajQwbHpZU1VLbWRRcVpTSTljdElERkRUcVRHQTFKVVlSOEJpQnBtRzVi?=
 =?utf-8?B?VlZGSzgxZEszRjA2aUJDdDZtdHh6WG9jZnkzS0o4ck10N2xHRXdnQU9GS1dH?=
 =?utf-8?B?d1VvdkV1VkcwTWE2TlB2SlhnQm95Qmh1RUh6bWdHY3c4cDZIaFdkUVpJbjR6?=
 =?utf-8?B?UFR3QVB6d214Ukl1RDVmNklKOTZaRTRMWU05OHN4N0xNNmQ0SDg3b3JaWjds?=
 =?utf-8?B?NUR0cXUrMzhKT3NjVVdiQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3JsMWhjVXFja1c1NFlEMnJ1azlpOFdnQUZ3eGlEbnpmT1ZwRlEzODJsTkNH?=
 =?utf-8?B?OHduOTRUbHkxOEVpQXhyMFMvemhrY0o4MWtZUXJyaW9nbUJ6b216bi9nQzBw?=
 =?utf-8?B?SW9kd0k2S1dxWllodk5ZeGpsbHBocGZsUmVwUXJ3b3daeWx4MVp4eE5ZQmEr?=
 =?utf-8?B?eWlGdmdUOXNiOUpraTViWGlUbFREekVQUk4zRGhVWm80ZndtYitra0dSMnVL?=
 =?utf-8?B?eVhFcnFmdEJPU2tXMUFHSmk5ZHcrZVR3RXB4NGkxZUNES25qVHFVTnhqZDhk?=
 =?utf-8?B?d2JIWlprc3JmZ1ZLNUx4NlpVYWg4MC9qVEFyQUxvVzdlMGZISkpzaGFWK0dI?=
 =?utf-8?B?M1U2ZU9VOHYrMTh3RElldUpydVZVOUkrZ25MZGJ4Qy9pRUNObjM4SUliT2ZI?=
 =?utf-8?B?cy9Kb1ZkVDZRcFJlTTYxNFI3eUYyT2tNZEc3QlppYWJkRE5zS2UwK3NuMnhm?=
 =?utf-8?B?d1Y0UWptcUhiNXJROS92dUtUYm55ZmV4M01iR2Q0UkxpdTh6OHV4ai80WmVI?=
 =?utf-8?B?WGVTak5hbkhtZmpLc25DZ2dTWld4amVieWZ6YldZMTBScGJrZXMrM01WaFNO?=
 =?utf-8?B?TzlydEdaQ2ZGVkxDbGN0Q1JReHBQU0F3TFVrYjBHRXAxeTh6bnl1emNNdVcw?=
 =?utf-8?B?YXdLWG1TVWMxMFhWM1IxS1BPUzFkZWxPK3I4K3VoUTFYODVuam1PeUttQkFT?=
 =?utf-8?B?Wk1rNTVaeHFWRjNYRXR6cVhBcWxZWjBESDdBcm80UXpSU2pHYVI5MEsyQnNM?=
 =?utf-8?B?TFA1L0owRFBKT1NNSHdscmtuc3VGSWt4UEZQSTk0ZEFRWFBlckRWRmZMaWdT?=
 =?utf-8?B?aGxOOWtIRHZ2WTRvY3M1VG1zV0JJeXVNd250Mi9lK1Z5bXpkaUlKZ3JqK0hD?=
 =?utf-8?B?N3M3cm5zOXVYaW8zbWdMNmtsdjFVd29PdUNKWlRHNit2VytjZ2RMTmtnUUNp?=
 =?utf-8?B?cWxVWTdaM1ovQWdpWS9VQ2xnMTdaTnZKMEhhdjNHemo2YWhIOUd5ZEdCSHJK?=
 =?utf-8?B?LzZWN01oOVRrYWdDT1l5QnJyMWEzRGpjOUxQd1dWMkpaZGJreTdBR2hFb09O?=
 =?utf-8?B?WFJqWCtYUWpjNldkUXdUK3JudUFBV3FyTUlicTRJOGJJRzlhSGtKSU8vZnFI?=
 =?utf-8?B?enlZblpNdkZCbkowblRuelhIdjFZelNNKzJiNnpNUTUvZVlrU014VGxtU0ts?=
 =?utf-8?B?cXpDYldsUDRJN0VSbEtYaGRuNHo2SVUwYk9kcXpDUXpwS2FiTFY2YTZDenZm?=
 =?utf-8?B?Zzl4VG5PTXN5ME5uSWVLaWFrK3ZGSENVRHNGRThpR2JMdVNuL050TW5EUWNZ?=
 =?utf-8?B?Y1pWeGY5U1JYREpBWjgra3luM3pqUW96djMzN2oxakRwUlVQL3lCZUFUeFFO?=
 =?utf-8?B?dmJyYlRzSGpLRkkvQnNTV1ZkYlNQQUwxSCtkLzBwODZNQXJzYXZQdm12K2FG?=
 =?utf-8?B?M0R2ZWhvdm9xa2ROZ05MSmtaNGtocENYcFhTdVUyZ3krRHdJOEhwU3FnT2RG?=
 =?utf-8?B?R1hYVkpJMDBUanA1cW5VNGMyLzhkZWdVWHQ3dEhnRXJNU205WUM1L0E1Lytm?=
 =?utf-8?B?MklJTkJCWUw5N3FFeEFLbVFad1BFZG5VSVZuQWVTUFI2dGF6WTZaRFRiYWhM?=
 =?utf-8?B?M3pENVBoeHQ1UER2ZXRwbzhrcFR5cEZ6Q1I5aG55WTFjN0NJSGtaS2ZqV01n?=
 =?utf-8?B?NzZ3V3N2T0xYTzhJdDFNWDd5ZFlvV2pKUjZIMFgzOTdWQnVsb3RNYkU0YU53?=
 =?utf-8?B?K0djLzQ2eUo5TEtjSHE0ZEtoRXVIWHptYlU0TzlORkVITDc3WjAyR2wzbzdR?=
 =?utf-8?B?dWFZNmFLQitrMi9UU21XdzFKdUQyZlRTY09Jd0huZVNDR0p5MlJDblNlcnQv?=
 =?utf-8?B?N05HSGNwRi9vL0tJK1ZXWS9pZjlLVld4cnRZOHRsZ1hUY2g5S1BYUkVlNTNV?=
 =?utf-8?B?VEowNmRESFhwWEk1bTZhZjhsdjhENUc3RS9CMk1VM3hpcXV6SWJkODYraUlv?=
 =?utf-8?B?ZSswNkl5dFNMT3I0TVhVUTVTeUZTNm9DTnhubnIwcXVjK2FhWlBZZzBQSlFu?=
 =?utf-8?B?ZG83ZkVRNjN2cjBRY1N0bDZoYmFhSkFXVFpFRmxTbHZEcU04eERpQW45QXZS?=
 =?utf-8?Q?hVyzhwuW6DQuIZwDugxreyiVX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891e01e6-23bb-4dee-8d51-08dc7b04c173
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 08:45:53.5137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baAGYBp238JdRo3Ji2Td5X1ukAXy+v7DXyvAtXzgNXCaKqcS4N+t5pQOiQxA83CZ7xjxVq9Lhp3bOGbAybSLTZX6ot189inV3FfgOcjVceY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4849
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggNy83XSB2ZmlvL3thcCxjY3d9OiBV
c2Ugd2Fybl9yZXBvcnRfZXJyKCkgZm9yIElSUSBub3RpZmllcg0KPnJlZ2lzdHJhdGlvbiBlcnJv
cnMNCj4NCj52ZmlvX2Njd19yZWdpc3Rlcl9pcnFfbm90aWZpZXIoKSBhbmQgdmZpb19hcF9yZWdp
c3Rlcl9pcnFfbm90aWZpZXIoKQ0KPmVycm9ycyBhcmUgY3VycmVudGx5IHJlcG9ydGVkIHVzaW5n
IGVycm9yX3JlcG9ydF9lcnIoKS4gU2luY2UgdGhleSBhcmUNCj5ub3QgY29uc2lkZXJlZCBhcyBm
YWlsaW5nIGNvbmRpdGlvbnMsIHVzaW5nIHdhcm5fcmVwb3J0X2VycigpIGlzIG1vcmUNCj5hcHBy
b3ByaWF0ZS4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhh
dC5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+LS0tDQo+IGh3L3ZmaW8vYXAuYyAgfCAy
ICstDQo+IGh3L3ZmaW8vY2N3LmMgfCAyICstDQo+IDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2FwLmMgYi9o
dy92ZmlvL2FwLmMNCj5pbmRleA0KPmMxMjUzMWE3ODg2YTJmZTg3NTk4YmUwODYxZmJhNTkyM2Jk
MmMyMDYuLjBjNDM1NGUzZTcwMTY5ZWMwNzJlMQ0KPjZkYTA5MTk5MzY2NDdkMWQzNTEgMTAwNjQ0
DQo+LS0tIGEvaHcvdmZpby9hcC5jDQo+KysrIGIvaHcvdmZpby9hcC5jDQo+QEAgLTE3Miw3ICsx
NzIsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2FwX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJy
b3INCj4qKmVycnApDQo+ICAgICAgICAgICogUmVwb3J0IHRoaXMgZXJyb3IsIGJ1dCBkbyBub3Qg
bWFrZSBpdCBhIGZhaWxpbmcgY29uZGl0aW9uLg0KPiAgICAgICAgICAqIExhY2sgb2YgdGhpcyBJ
UlEgaW4gdGhlIGhvc3QgZG9lcyBub3QgcHJldmVudCBub3JtYWwgb3BlcmF0aW9uLg0KPiAgICAg
ICAgICAqLw0KPi0gICAgICAgIGVycm9yX3JlcG9ydF9lcnIoZXJyKTsNCj4rICAgICAgICB3YXJu
X3JlcG9ydF9lcnIoZXJyKTsNCj4gICAgIH0NCj4NCj4gICAgIHJldHVybjsNCj5kaWZmIC0tZ2l0
IGEvaHcvdmZpby9jY3cuYyBiL2h3L3ZmaW8vY2N3LmMNCj5pbmRleA0KPjM2ZjI2NzdhNDQ4YzVl
MzE1MjNkY2MzZGU3ZDk3M2VjNzBlNGExM2MuLjFmOGUxMjcyYzc1NTVjZDBhNzcwNDgNCj4xZDFh
ZTkyOTg4ZjZlMmU2MmUgMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9jY3cuYw0KPisrKyBiL2h3L3Zm
aW8vY2N3LmMNCj5AQCAtNjE2LDcgKzYxNiw3IEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X3JlYWxp
emUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3INCj4qKmVycnApDQo+ICAgICAgICAgICogUmVwb3J0
IHRoaXMgZXJyb3IsIGJ1dCBkbyBub3QgbWFrZSBpdCBhIGZhaWxpbmcgY29uZGl0aW9uLg0KPiAg
ICAgICAgICAqIExhY2sgb2YgdGhpcyBJUlEgaW4gdGhlIGhvc3QgZG9lcyBub3QgcHJldmVudCBu
b3JtYWwgb3BlcmF0aW9uLg0KPiAgICAgICAgICAqLw0KPi0gICAgICAgIGVycm9yX3JlcG9ydF9l
cnIoZXJyKTsNCj4rICAgICAgICB3YXJuX3JlcG9ydF9lcnIoZXJyKTsNCj4gICAgIH0NCj4NCj4g
ICAgIHJldHVybjsNCj4tLQ0KPjIuNDUuMQ0KDQo=

