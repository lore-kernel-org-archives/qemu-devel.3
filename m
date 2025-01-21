Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F10CC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBja-0003nw-TI; Tue, 21 Jan 2025 05:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1taBjZ-0003m0-7l
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:43:49 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1taBjV-0003IG-J8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737456225; x=1768992225;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=jbmLjzygF/pKCh0hhkJzdQ6ssKlXwULKkApcW+eogRo=;
 b=LGHgAllXDcnP0oR8mYzVQXMmQrGOYS+68v3+2GkrXyxotn1vbUpjJa9P
 gcEMXWo7lsyYvifpcBZBswGAgDdIjoRw5uAiJEvmLYDX+Sg0Iylbf390c
 vvv05r+flYKTnVGit4y/YXDJ31EGd902bcf4A+CxXYKPoUwWlHQc8/uH2
 4szrtzj1TgdgVbiR0d9nR9w5p0e/GdLxtVjaA2csHUDRibfa5PzYyN6Cx
 R1ex9/DANVVMmKeW92RO5vn2nxH+BAjQyjrGWDNuJuGz5MUDZLBHeFywc
 NY8DM+IstTb+J03LwxVPp9m7tVQygbMzPwP2N4Fik4lUnYFixm0oPZjzE A==;
X-CSE-ConnectionGUID: UNQDZxXpRP25nOjY6icc9w==
X-CSE-MsgGUID: 4ldTPQL9SxyXzKWnXG00RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37559803"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="37559803"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 02:43:42 -0800
X-CSE-ConnectionGUID: VyiH7WCKSEOyi6sIE9s81g==
X-CSE-MsgGUID: 20exVtjlQryEvd5EELKPog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="106559554"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 02:43:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 02:43:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 02:43:41 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 02:43:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiDOqEt9qxfxxhSiJQUoAmk1K8Wl4xxXbEhPtk8hx76kiBI0Vn9tG+eRFqr4eLUozM1srbU0Sqt6e9AwwnKZScoEsLaQaxD9t6bLIRBdtPmTHTa69lYjduVrde47+QpB3dQfreVWXMSPkb2ZP6irzvK20AziJpw2foReaj5QMQHG5aGzaVGpaJt9hBadfnaeE2hOzQV3dpTqRIJb/6qFOD3vtIcsm1P1gVdnUOvs83v3/pMG0ZnliWDOrIQV9I4u0A32faT7Z3X1DYT9VrwEpT98IRjyGZEnTSEEYKGZI4wxECFqCNKSdT26XCgoRA1ITNVpDDMrU6vx8NU89pz0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbmLjzygF/pKCh0hhkJzdQ6ssKlXwULKkApcW+eogRo=;
 b=CMrJIV5HD01nWvP3IXLy7a09E6DFFRzj3mx4eeRKYwaU5mKDk/q6HS0wwxSfxDDMpf+JJa3Ls9ft2Di/q52iTaQZg1uPHM3FjhYHzuTff6pek0YOZVKdRno5Qhjf2RjRrPx3V8pN2oMArmbOl+4L1pISwaCeBIMTL3/2v6OTPHXsCrjRTWHi+vw1gNULlcoFd+oTE+fqduqoPaKCQVnO+oeeyNivmLDifxuyvdtm0cWhpPm1waYnenxlTpRuE6EUdxX9O0mLoI79Z2qGjhTgfQWG/ZQdEFy65ZCuKEE1I/17Ka4ns3RCLfqBQ5nXg0alPKFGzK3zIlKfUdZt6fstQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 10:43:34 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 10:43:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>
Subject: RE: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Topic: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Index: AQHba2GEeT3q2OY+G0e4DMt12KVy1rMg8zrggAAWLgCAAAHyAA==
Date: Tue, 21 Jan 2025 10:43:33 +0000
Message-ID: <SJ0PR11MB6744B213CB3B90549F1BF00692E62@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <SJ0PR11MB67445918D03892472C78C2DD92E62@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <0a9acf3d-184d-4947-be72-63e7187ef82f@redhat.com>
In-Reply-To: <0a9acf3d-184d-4947-be72-63e7187ef82f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6723:EE_
x-ms-office365-filtering-correlation-id: dffc510b-d97b-4d2c-c315-08dd3a087406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZzkxR3dyY25vT3dZNHhZVmxGY2FTdzljcW5ZU1NUd0RmamdhVnNhUytCOHgz?=
 =?utf-8?B?NDRzNFZ6TURuQWhmTEhKWEN6Y244d01OQk5ZcjRHUDFOdElmVFFEMTB1bldV?=
 =?utf-8?B?eWlidTNFZ0cvcndnL2ZoeWZpRlFsUGJtVXdueWw4SWRlS3NWOUhNOWMrWGdi?=
 =?utf-8?B?cmIwakZSUVMyejJiMjVpM05CN2F5NUpxb1Fna3pFNzRpTUJ6NVhZSWNaV3c2?=
 =?utf-8?B?L0FvOVFWeTZwTzJVZjdabmN3NWl4NGwyYWU5cjdEbVVWbWlEdmhmbC83OXJN?=
 =?utf-8?B?YUx1RHpWWUUvMzI3dnUxMWdZb3BPRGlKRnpLZzlDeGlwVHgvTnFGeGdlUElV?=
 =?utf-8?B?WktlOU9aNGdBOVFnNGo0eHRoVUg5M01xdFNRQVRubzA2K2JYYkhWWHVmSjJi?=
 =?utf-8?B?a0oxc2Y0bXNDdlBudlY5ckI2ZDV5Z2RDOStZZmkyZVo2cjB3d1c1MTdvMmhy?=
 =?utf-8?B?SXFZYjAvaVA2YmhrWlBQQ3VmSUE2cXpMQUZQOWY1KzYwa3FsTllZbDhuMmVy?=
 =?utf-8?B?YmJjMldpTENvOGpEcS93RzV2eGJMOEltYlZFYVo1a3FrdEtWZUF4OVdzcmpX?=
 =?utf-8?B?ek50cEVoUng5YTFiM3ZUcFMzVzZOYU5UN1hFYzlOemdyaG1uRUk5OHc4REFJ?=
 =?utf-8?B?Uk9yTG51ZE80N0lOMG5OS2RPMDdxMlBmRldub2JQZkZ3RnJFWmxOYUxaTS96?=
 =?utf-8?B?M0FreFpJc3pTeFpyMUJFZ1BEdDZlcUlNMURBUFFWem1INHVDY0kxTUZ4dytl?=
 =?utf-8?B?c291V1hCUXdQNlBWWW9PT2VhY0lKbnkraTVSZTFTbDVROUMzZHFKWWhXdDhv?=
 =?utf-8?B?NDhFUmtGZTNBWkxBdFlZOWJEVTFyT1p2bmp4MnBtSkYvTk5hOWQ5RlFUMnBp?=
 =?utf-8?B?WnkxRlBtb3lZdlhQL1dsdkpaMFlHVnpqUjFGdEVtTGFKQ0hEMHhZRG52VzZr?=
 =?utf-8?B?MWs5b0JPM1dWU0xRR2pSYVVxemxnT1JvYlNWZjgwTXdSOHFpR2tveG5tNHFJ?=
 =?utf-8?B?WUF2bi9IT0FFazQyVkxrREpKUHBNRU93c0l0Rm91aENseEpCOVhpdGFlc2Ju?=
 =?utf-8?B?aFFvQ2VTVFJJZVJSaU12RTFoWEtxRWNYc2c5eGh4bDlua3hnWHhJUFd6Snpw?=
 =?utf-8?B?YVRwdExvMVBuVXhiT29IdXFZUTJlS3Vya3UvaDdxNFJzbDU3YTBZYkt0MndS?=
 =?utf-8?B?MXUxQndab0x0WXpQeU5Obkhwb1Fpem45TUR1MEF6bE1WTzd6Skx5L1p2R3pS?=
 =?utf-8?B?NGNGelEwMEpqdWlWWDdXME5HWXkzaTFpSndTb1EvbTZjWkhkaWVCaXMveTlk?=
 =?utf-8?B?VXAzdEhhejUyZnRsRFk3Vkw1dy9VcGpFa1ZkRXE2dFlRMzBNMXNWeFlPOE42?=
 =?utf-8?B?akRjSlh5dG14SDBEeGZZWW5ZYVlTR3dZVXhHeENGd0Z2bkc5SC9vbjFkdTcr?=
 =?utf-8?B?d00rekdUZEoxaHdkUUo5ZlA3YUV1TGFMcUdOVndUZUpFZS9Peng2MW5JaU5p?=
 =?utf-8?B?OXJJVHdpdTBlbmxzREFvVEJrSmZTWmVBWkh5dzRrU0hkeEsxcy8vclNlNXZ0?=
 =?utf-8?B?VEpXM0xnZVA4eHgyQkl4SjJoVFR4dU9HVld3a3NkaVUya1hacGZLeGlPWHNn?=
 =?utf-8?B?UURpenJ2eWxMRGFpbXkwQlhtS210YTlXeDd3VlhkRUVNbFJteVRndVZ2NDNX?=
 =?utf-8?B?cEVFZTR4dHo2V0RPdm5waFFWWnErSzAxRFlOYW9UMUlZajJnTSt4L1ptYWds?=
 =?utf-8?B?SXI5ZkdmcmlNUDZ3VFZSUUtWYVVjSUhkT2lOTXYySENtY011MUp4YS92bE5Z?=
 =?utf-8?B?ekVlZHh2R1hzWmxSdmEvUEd3S2lKUFZrKzU5YnVHN2U0TDdQVExvNHQ1eFRT?=
 =?utf-8?B?a1hpQkNxRHlVdmo5V0xTS3pqbkp0dFBlL0Q0MjAwNlB5ek9xdUFMeHp1bUpG?=
 =?utf-8?Q?SwNuO+4EAeao/r+86ZdlJyfVjvwbF0IF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDdlU0V6WktmQ0lhVzB1ZmM0dnh1Q1pZa1JuVm1wbVN6WXJrdFhtTFZkR2Jk?=
 =?utf-8?B?OUdjK1Nudzhaa0Ewa3ZzLzhRdkMxbGFCbXh4NnNZdFVtVjdBVnRqOEZBMVR1?=
 =?utf-8?B?ZXVOK3dkU0RVNDl1YkxOOStpWWViUW5PMVZhTThrYmtIbFhSUmdBdm1nbXVs?=
 =?utf-8?B?bVlTY1NVcWVHVzB6M3BUSXNtcVdOSGo2YS94MHpZUlVGa2Qxa0pZeUZmd2N2?=
 =?utf-8?B?VmZIVnVPOGI3Z2xZNlVKeUJKR01icGsyOGxRN3dodDBtMmcvVlhrYlVwcGNO?=
 =?utf-8?B?YXNsblJVZE5oOElGcWpqM0Z0RlM5TktXNUc3TUNUeW1QcXVaV200eFRPdVg5?=
 =?utf-8?B?OVY0WENvaWc5VUNTTy8rSWVkN1JDQWQvbzZQcCtIR1BOOXh6SWNpeW84U29k?=
 =?utf-8?B?b1B3NHovYTR3VHYrWHhZZHlYcFpoMHpGaUhvMm15dUd3RCtzaUJsOGlmU29Z?=
 =?utf-8?B?bDFBeWlLVi9IQ1FVd3lDOC9zNjl2aHh4Q1Jsa2doVDh0SW9HNkltMWttMVV3?=
 =?utf-8?B?UDE5Zk5yeXZtMmdrbW5vdEdlbUJzU09XYXdhYTdxN3VYQlY2TDhGVjM2TFk1?=
 =?utf-8?B?OEZNdnM5V0JaeFRGUjMxWEZoOUdSbEt6Z1hLdWNOWDBXMFJvTHNSM3pCNkFh?=
 =?utf-8?B?cHZVRkE3bnFYN1lnT283RVF1Qnp0bkRDMk9ML1JwOWErTFN5WmZTc1Q4TXMv?=
 =?utf-8?B?VjltTFoyRDZya0lESjlXR1VTUkJQaUNRMStkeHk1VUlVQ0lOUDJueTdaZHhw?=
 =?utf-8?B?dkdPMjU3a0tKaTRCbVhvSGJUN3ZRU0c4akhYNVNnT3E0K0luYll1WUdKVmMr?=
 =?utf-8?B?Rll2U2lsZzk0UG5OWkFWRXQzWUpaNDVSR0FES0dNWVdQT3VtN1RTVmZkWWtY?=
 =?utf-8?B?S0w2WHNqSW9rVWg4eGo3TGZKcWJ0QlVsWUpUVnhGTTBmeE9lSFRCZjhPQWg4?=
 =?utf-8?B?NnBjNGdDWEV1ayt2M3R0a0pkb3hTdEhLZ2FtQStkekttNGRDR0pXTkJLbUQ5?=
 =?utf-8?B?YkRKZExTcERvR0lBQ0swSEVNS0RORC9WYzJXbUEyb2RHTTlDTUZFb1MycTlN?=
 =?utf-8?B?aHlpTFdOWnN0Z25XU1F2MXFHRTE4cWNBYkQ0ek5NbFg3a1pnRklWdFg4WHZY?=
 =?utf-8?B?RGdmQnRoT21YYWI0T2lPc0p2eTlsOHRVamh6ZVhiZDB4L1ZPMVl6U3Z1N29R?=
 =?utf-8?B?bks3TExtYUZnMWlJdmRKN00yYUFGeHV5eEJ5QmZsWmg3TkdzUVE4eUpZVEJV?=
 =?utf-8?B?bGJZdEtRa1hBRUVMdXIxUlAya3pQbDBoa25SWUphYkFaVmIrSDFtT1UwQTRW?=
 =?utf-8?B?dnhTaWFmK1NGWDQ5d080c3Nob0xVVnd5TEw5MVgwalJ0ekV0RnRMQ3pPZUM1?=
 =?utf-8?B?dzJqcHpjOWF6MHlEZTJxeWdtU2FPNUhHVWpUem42UG1DaGo5L0xFUEVzcHBG?=
 =?utf-8?B?NEZxdXg5c0tvbU9DV1RLWWRoV3JvUlZUellsMWMrUU9sbEl1ZVl4a2lvczZ0?=
 =?utf-8?B?ZUNrRnd0a3VSRGIvQnFWcGhBbHRTdjZaVlU2SjZNSC9SaGc4WVJteHEyRkpE?=
 =?utf-8?B?VGphd0wyOEMzVkh3U1QxQkt1cUNrKzR5dFJnSzhoNEFQOUFYejgxRjFhMmZH?=
 =?utf-8?B?bDFqbUwrWlkwWCtRUEFOZndBNHlJUE0xaFRlZStXK0o1QkFLZ1M0MnAzQnJQ?=
 =?utf-8?B?UVVHd1dVcmpkNzNCWDV3Vjc2N0hyZGtOSy9sWU9NSXUrRjdsVy9VQTJvdC9P?=
 =?utf-8?B?a1drSjlBRlRjbHEzYWlZa1h5azRReHl5Wjd2N3UyeVNXcE1zZWVIUml4OFdv?=
 =?utf-8?B?elZkRmREc2dsaHhYV1RLc1A5Zm9uNFQxL3FSVmxHSDUyTHM5NGNReVM4T0lS?=
 =?utf-8?B?aE1FVzZmY29FRWgyNHRWN2R2VHE0QTllNDlOc21aQUxucU9lckN2K1NJSlVN?=
 =?utf-8?B?cllIVFFjMTdrVE9iYmo1YjlVSXNrQ3JnSmJYbTc0cisvd3hCN1pjYmtFdzZO?=
 =?utf-8?B?RXAvQU1nS25zRnZUMytaUVlZNkpzMnVoOHMxME5YVEdqVzVNSzh0ZFFEajBO?=
 =?utf-8?B?ZVNzZkxmNGtTZzI3U2dwUyt3WmxxSjdrVlFaaUhYb0ZEVENWVnFWUWVuYWRp?=
 =?utf-8?Q?Lms4SCK7FHpVOyHpa0OUw/1eK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffc510b-d97b-4d2c-c315-08dd3a087406
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 10:43:33.6997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njZfSSP36SicYiQvUni2p2krjeYbrUkEfdX5D1QxAGy3EPcM+aPb+DLAmvqTlK8InBUVzp82QxG85TX94Q37zkCGDaT0c/mS/VJrypVVMR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBody92aXJ0aW8vdmhvc3Q6
IERpc2FibGUgSU9UTEIgY2FsbGJhY2tzIHdoZW4gSU9NTVUgZ2V0cw0KPmRpc2FibGVkDQo+DQo+
SGkgWmhlbnpob25nLA0KPg0KPg0KPk9uIDEvMjEvMjUgMTA6MTggQU0sIER1YW4sIFpoZW56aG9u
ZyB3cm90ZToNCj4+IEhpIEVyaWMsDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+IFN1Ympl
Y3Q6IFtQQVRDSF0gaHcvdmlydGlvL3Zob3N0OiBEaXNhYmxlIElPVExCIGNhbGxiYWNrcyB3aGVu
IElPTU1VIGdldHMNCj4+PiBkaXNhYmxlZA0KPj4+DQo+Pj4gV2hlbiBhIGd1ZXN0IGV4cG9zZWQg
d2l0aCBhIHZob3N0IGRldmljZSBhbmQgcHJvdGVjdGVkIGJ5IGFuDQo+Pj4gaW50ZWwgSU9NTVUg
Z2V0cyByZWJvb3RlZCwgd2Ugc29tZXRpbWVzIG9ic2VydmUgYSBzcHVyaW91cyB3YXJuaW5nOg0K
Pj4+DQo+Pj4gRmFpbCB0byBsb29rdXAgdGhlIHRyYW5zbGF0ZWQgYWRkcmVzcyBmZmZmZTAwMA0K
Pj4gRG8geW91IHNlZSB0aGlzIHByaW50IG9uY2UgZHVyaW5nIG9uZSB0aW1lIHJlYm9vdD8NCj5B
Y3R1YWxseSB0aGlzIGhhcHBlbnMgcmFyZWx5IG9uIHJlYm9vdC4gVGhlIHJlcHJvZHVjaWJpbGl0
eSBpcyBvZiB0aGUNCj5vcmRlciBvZiBtYWduaXR1ZGUgb2YgMS8xMCBmb3IgbWUuIEkgdXNlIGEg
dm0gd2l0aCB2aG9zdCBuZXQgZGV2aWNlICsNCj52aXJ0dWFsIGludGVsIGlvbW11IGZlYXR1cmlu
ZyBhIGNyb250YWIgam9iLg0KPkByZWJvb3QgL3Vzci9zYmluL3JlYm9vdA0KPj4NCj4+PiBXZSBv
YnNlcnZlIHRoYXQgdGhlIElPTU1VIGdldHMgZGlzYWJsZWQgdGhyb3VnaCBhIHdyaXRlIHRvIHRo
ZSBnbG9iYWwNCj4+PiBjb21tYW5kIHJlZ2lzdGVyIChDTUFSX0dDTUQuVEUpIGJlZm9yZSB0aGUg
dmhvc3QgZGV2aWNlIGdldHMgc3RvcHBlZC4NCj4+PiBXaGVuIHRoaXMgd2FybmluZyBoYXBwZW5z
IGl0IGNhbiBiZSBvYnNlcnZlZCBhbiBpbmZsaWdodCBJT1RMQg0KPj4+IG1pc3Mgb2NjdXJzIGFm
dGVyIHRoZSBJT01NVSBkaXNhYmxlIGFuZCBiZWZvcmUgdGhlIHZob3N0IHN0b3AuIEluDQo+Pj4g
dGhhdCBjYXNlIGEgZmxhdCB0cmFuc2xhdGlvbiBvY2N1cnMgYW5kIHRoZSBjaGVjayBpbg0KPj4+
IHZob3N0X21lbW9yeV9yZWdpb25fbG9va3VwKCkgZmFpbHMuDQo+Pj4NCj4+PiBMZXQncyBkaXNh
YmxlIHRoZSBJT1RMQiBjYWxsYmFja3Mgd2hlbiBhbGwgSU9NTVUgTVJzIGhhdmUgYmVlbg0KPj4+
IHVucmVnaXN0ZXJlZC4NCj4+IFRyeSB0byB1bmRlcnN0YW5kIHRoZSBzZXF1ZW5jZSwgaXMgaXQg
bGlrZSBiZWxvdz8NCj4+DQo+PiAgICAgICAgICAgIHZob3N0ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2Y3B1DQo+Pg0KPj4gY2FsbCBpbnRvIHZ0
ZF9pb21tdV90cmFuc2xhdGUoKTsNCj5ObyB0aGF0J3MgYSBrZXJuZWwgdmhvc3QgdHJhbnNsYXRl
IHJlcXVlc3QgdGhhdCBub3JtYWxseSB0cmllcyB0byBmaW5kDQo+b3V0IHRoZSB0cmFuc2xhdGVk
IGFkZHJlc3Mgb24ga2VybmVsIHNpZGUgaW4gdGhlIElPVExCIGJ1dCBzaW5jZSB0aGUNCj5kYXRh
IGlzIG5vdCB0aGVyZSBpdCBlbmRzIHVwIGFza2luZyBmb3IgdGhlIHRyYW5zbGF0aW9uIHRvIHVz
ZXIgc3BhY2UgLi4uDQo+Pg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZXQgcy0+ZG1hcl9lbmFibGVkID0gZmFs
c2U7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN3aXRjaCBvZmYgaW9tbXUgYWRkcmVzcyBzcGFjZTsNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZGlzYWJsZSB2aG9zdCBJT1RMQiBjYWxsYmFja3M7DQo+dnRkX2hhbmRsZV9nY21k
X3dyaXRlL3Z0ZF9oYW5kbGVfZ2NtZF90ZS92dGRfaGFuZGxlX2djbWRfdGUgd2hpY2gNCj5ldmVu
dHVhbGx5IGNhbGxzIHZob3N0X2lvbW11X3JlZ2lvbl9kZWwNCj4+DQo+PiBjaGVjayBpZiAhcy0+
ZG1hcl9lbmFibGVkOw0KPj4gcmV0dXJuIGZsYXQgdHJhbnNsYXRpb24gYW5kIHRyaWdnZXIgd2Fy
bmluZw0KPnZob3N0IGluZmxpZ2h0IHRyYW5zbGF0aW9uIHJlYWNoZXMgdXNlciBzcGFjZSB0aHJv
dWdoDQo+dmhvc3RfZGV2aWNlX2lvdGxiX21pc3MoKQ0KDQpVbmRlcnN0b29kLCB0aGFua3MgRXJp
YyENCg0KQlJzLg0KWmhlbnpob25nDQo=

