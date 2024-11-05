Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98258D111A2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 07:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8E9l-0002gK-Td; Tue, 05 Nov 2024 02:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t8E9a-0002ek-UW
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:39:07 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t8E9X-0008Rc-BF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730792343; x=1762328343;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y9w4DOESrtWAtJxnBb+s4DnnV1glMgFZ1Wlz2ZJtl5k=;
 b=anR0KP10JRmQg9dXSznW1fs5nIrxBc/Q8Xw4GlAmMUzcPja2rcVDyA2j
 us/jt/cJRBmRfrnqCGhCKT2gfYQkdYzqbj+38/OFI+3842ZW6FjsxZFxr
 OSUQjPDCDR0oNRUyiu0ZRStBXh3RSrlkWL5Wy1ciQmy1zeLk1keiBWsIF
 7CRikxbh7lMmojUEbzAcF5wg5iXqm/L3FT9NCoH1MFCfqcn0eIaTcYELP
 SuivFX4jRM0LEDIapdqTBU58vLqOE6YBtKDa3Qxe8CvmFOfLsmyz/DxP4
 i8dTRbyN/rwKSC8bCzurZ43DSS9izeIP4o9bKZuaDzmDNFQTa+mCbb0BP A==;
X-CSE-ConnectionGUID: fpctUNIxTE2qgRENwqXfPg==
X-CSE-MsgGUID: LFcEWS0YR0+90jdx4bDa/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47985105"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="47985105"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 23:38:55 -0800
X-CSE-ConnectionGUID: C87VCa8MRpuSRLc5M3qWYw==
X-CSE-MsgGUID: vHCzJ3YsSi6/vYCKSaYp6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="84721379"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 23:38:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 23:38:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 23:38:52 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 23:38:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoyYVJm69BM6AkILmmn7hLA3PETeDUdkFm8e4LFHD71TsltrYhYawQXWtSTaM/vUOuJZIyn7QYrxuri1nzB0Mr1cgd2Zwfjv5XqJUhSTPa5ynHkoSlw0fjosXQZeGM0uVDcLkmQ6zhZnxQhPg5SufNzu83HAUaXVNP2Ta0lKsENT9GyXaumxHgjBP/m+74NNy3Axl87tIisAQwWv22NOWm8JSz7rFk5giF/1+VAmihY1HuXRgs6tUWZN1Gyl/i6khG0bIgD+rl7B+n/pVwFV+SrwzcN4fpluRoVSRD7N46pNxGV+xW0hU6hGPKDR4Iodn5wlAAujRJeVPEz4LVOgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9w4DOESrtWAtJxnBb+s4DnnV1glMgFZ1Wlz2ZJtl5k=;
 b=lI0yVDUDp3DSYHnE5WcPsyq/LaSugvWk8FrRV2d/qgQRcgd3aAPfRADI0lNysvqn3SCTWymUzXKuz1uypuRO5STitRorWk7bhqDB7vQ7upOz7+dyLPFbAezEHS2km72MGV7FrxZRQxpLFaxEPRU1IYa4e+ouG4QXYSWP6kJuyjG/iW9iTUg3CayyBZM0cfXgrcge3+FvmAAaWujSjTBk86xwAXDHw7yOJMgim+iwIYnJBuXYQUitamERL4v77OuhTiyaEOnh+LLWrIFrroZXRxPiw1iKqs5gGw/oSK7RI82G1lJGoa3HeVXVLDDTm4uFTaAF3EWBiopIxY4j//+4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:38:49 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 07:38:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Thread-Topic: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Thread-Index: AQHbLrllsz/Poj6ktkWylIhCzxfopbKoPIYAgAAOOMA=
Date: Tue, 5 Nov 2024 07:38:49 +0000
Message-ID: <SJ0PR11MB6744A9DA583E376307C5E3B492522@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-3-zhenzhong.duan@intel.com>
 <f92098c3-32a2-4493-993b-e15284d1211c@eviden.com>
In-Reply-To: <f92098c3-32a2-4493-993b-e15284d1211c@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7744:EE_
x-ms-office365-filtering-correlation-id: a8b246ab-be57-4797-6d82-08dcfd6ce353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MytQYmtSakIzUFJsOC91WmJUclZoS2tIalUwL1R1NVNYU1doQW5XaGoxdnk2?=
 =?utf-8?B?UnRGc05DRUgzV0VzWFY5MVpwNlZBUXJqVi9BMDVlQ3hwdkVwZE1xdFEwaFEy?=
 =?utf-8?B?SlNGaUdHTXdBdElVREtGTkU5VG50bXJjdXRPZkhkM1BRazg0TWxBVU1oQ242?=
 =?utf-8?B?WGpsUUpkcHlyL2V1WmtuQzlzbW11Yk5TaEFsSUNjUTEydDB0aEVRMUlYaGVt?=
 =?utf-8?B?dU5HQ3hsRnR1Zk9lZHlwT2JVM2NrNlprc3pGNFBJTzRGaW8zajFFcDFHWHB3?=
 =?utf-8?B?RGZTUk8wemFOaENFbG1JY1V3VzhxTkRaUzdXZWJOSkdiRkk3SG9remlCNjJ1?=
 =?utf-8?B?ZGhqc2ttb2hYTEFQa21IT1l2UlNrSEJKbWlFK3V6a0hPQXlEbWwyd2FWMGxh?=
 =?utf-8?B?R2NsUVgybDRUc0FHTDNqUXVhWC9oVmZHNGZ0anVnNkxjejl5Y0F6dEdCazkr?=
 =?utf-8?B?RVZSWDlybnFVYlRKTWowTEFRSWJpdkhMRU52ZDFXWG1rdWVyd25idTF6WnZj?=
 =?utf-8?B?c1dCSElCZ3IrVnpoMmY1RE9kbHNVaHBFZzNlUXNJWDlWdW84cVJWME5Yc2NC?=
 =?utf-8?B?R1NDeUp4TmVLcWQyK1hLRFd3T29xSEQvV0ZYODl6bWwyanJJaHFjd0ZGSllR?=
 =?utf-8?B?WGNDVGp4OGhpelBDUitycDNXcytFdEJKSEZMWElhdENxaWk5MmV0eVpyQ3ps?=
 =?utf-8?B?a3V5WkRQZDNrMzZveFhkUGdyc2RXdDJ2K0hpMGdqazJSbVlwQ3dFdFhielJs?=
 =?utf-8?B?QzBCeFh0amVocDl2M3B4L2hud1I3QzlXSW1RY2E5VG5WWFowdnhOR0tHNWtW?=
 =?utf-8?B?a0xOanRabG9adWNFWlZrOU44dWVOUHRQb0FBYXJsdEQzT0RBTHUzUzlUMk82?=
 =?utf-8?B?cUUxYnMzQXZRQVkvLzl4ZzZJSzBsamlTa3F2bys4Qlg2NitiR04zYUt5dTQv?=
 =?utf-8?B?dFVOOWZKWXAzK0txd1djcDBTMklDdlRJQWJVc1RJMzhxQ3RxRTZtL2xvbzQ1?=
 =?utf-8?B?bTA2Q3dWN2hkNUQyL0luNTRHM0grcEdZOTZHbi9tbERWNmU4RTlGb0thL0FU?=
 =?utf-8?B?dUpZYXpmaHVQMGpTYUFzeHFVZDRKQ3ZKYWJHOFlVcnovdUZ6MTV2MTU5MUpX?=
 =?utf-8?B?TWNmMUQ1YkJWMDgyZjRsL2ZrVmM4RlR3TUVwd3dJOElmRlViM0t6elZ2N3BC?=
 =?utf-8?B?MWo2V1VLZk8rN0dpN2pqNEVPOC9WeTE5ZlVJT3owc1FUaDBVMFZ6V004VnRp?=
 =?utf-8?B?b1ArTGpLV2dHTDl5b2dEa2pnbkdBTmNCYkpGd0R5d2UwYjUvQ1RGZmdKMDND?=
 =?utf-8?B?WDRkbVdCTmVoRzQxZnVQamU1TUh0aERLeWhFcDIxeTBiZ2Y3MmE3SXAyYmJR?=
 =?utf-8?B?RGNnQ1ZIZkVuaTdxK2tvTDFQbkQ0OVpTME44Q3o1RnQ1dGJjdzlQRkp6M1Nl?=
 =?utf-8?B?bHNDNFViRkx0MWRIcnhWSXRQOXdMWWpQVW5Gc01PdTFVVnoyK1diMFJmNC9W?=
 =?utf-8?B?aFFmd2lYVU9uWVozZ2lUUE9hMEMydC9XL2s0VEJmaFF3MG1aYTlwYm9JWk1U?=
 =?utf-8?B?QWdnYzRyZnFXeXdjVEVNdnYwWis1UklLcXhsWERxbzk0UzJkUEhiYWpLTmZ1?=
 =?utf-8?B?all4eEE3SEx6RXMwVlN3amtJaGN6U2lwSVJJbUpoQWd2bXRDa25TbzY0TTVM?=
 =?utf-8?B?S1grSnNZYkVyTWFOS1ViNitoZVN0RllpMlRrVVRUVGdYdHh0cUZWSmJPSzVU?=
 =?utf-8?B?QWFOVlNpNUF4TlhZREpnK0NVL1VkOU10RE9hYXViRTduOWorWG5xNk8rL1dt?=
 =?utf-8?Q?Vsnz+dlJdsf+l+6AnB0jz6OjGdgKIGyqvAyYU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STlGQXJyeWNrZmpwK1RmRTROdmJYVk1FMTFxUHIzYUtXYm9UYXhoVnh4Y1Qr?=
 =?utf-8?B?SXZZaGZGN0hpTXVyZGJuNGljcUpFWFMxNEdXRVRNVnVqK3d1OHMvUEM0cHpj?=
 =?utf-8?B?K202dHFCRXpDSG1mK0FONGVVemJNdGNncHIrbnFkMHUyNXMybHZHSm9pZEZP?=
 =?utf-8?B?bXkycmdHcVh5MEFFNVZQa09Fdy9kNnFJV2V2NmpyeTM4MXZuRE1yQXB4dEc4?=
 =?utf-8?B?blZvZ3NNcDh1R2x5d3habGNTWlh1Rm9vYXRrOFFkelFLVjB5dE5lTVQ4WGor?=
 =?utf-8?B?VnloY2VPejZGazF6ZHBRc2ltVkhOemhPbjhpSjdrVjN5QWJ3a0RiRDhuRWRC?=
 =?utf-8?B?a01tY1QxM0wvY3NSQ0FzVHF2WXdhOUk5SHgrYlBoZStMbFVlU2YwN3B3YlU4?=
 =?utf-8?B?MXZyaG03N1FXQThFMmVPR1VNaU14YUlRenR2NWxaNzJWM1FkZDdFam52Z3l5?=
 =?utf-8?B?Ry9qMS9VUUhrS0NCL1lzRFdpSytERng3eDJ1ZVgreDhUbTJuT0RqYSs3R3ZS?=
 =?utf-8?B?eU9CWlNrSFRDTGx1Snd1TERPeldjYUh4TERqTlo4VmNqa0hiSTZWeTAzUDZH?=
 =?utf-8?B?VVRvQW1NTzJWY2tKbnlZMGw0T0h3cWx1STBIWnlCdDVQNlVMZDZ4TklkRWF5?=
 =?utf-8?B?N2ZhekREK2c1V1gwK2VwcmJWc3BObmJPbVMzeFJWdUs4bHRQTWFFeTFYNytB?=
 =?utf-8?B?NWd3VWZTZE9JLzhQQzBtZEdSblh6NjM2ZTlLMGZaTzlhOGFUZEpVZnBFM2M0?=
 =?utf-8?B?dGRWM1BOeVNTbDhqWHNxZnBKYnUrSWVaSVdydkZtTGVyTDduZm9RbmhxTENS?=
 =?utf-8?B?VElKYU5HWGtkUFdEcXVxMXVNbmNBRURmbVJZdURsa3RUSVAzMnNHV0hhdjhS?=
 =?utf-8?B?Tm5CNWQ2cURkV2YyaTJ3YVlXWDY3cVJ5amd0RC9kNTVpSGJ4Q0JYZk9YaHpP?=
 =?utf-8?B?VCtQSXBhZGtmWTYxcnkxVUZRUDNVWC9JRVRDM3ZSWVhHZEhWNkRSUC9wU1R0?=
 =?utf-8?B?WTQ0MFhEdmdzL0dDMGxrbGVSNDV5QnEwbWVSbjYvVDU5T0hYaWVyQ3JGdWV3?=
 =?utf-8?B?NzF0UG5pYnlseHdrMlU0VWQ3NTc1dk05bDR2UXNxT09JTFc4UkdTUlJ6eTR5?=
 =?utf-8?B?cWdYV1luZi9kbEFQeklUUWY4TTRJaFVEa0tUNXNRUVpjUzM4K2c5K1NwS3E4?=
 =?utf-8?B?V2llWnRoc0NZSmcrbG1ESHc0OFh4L0tqaURXOXdOYUYrQkVINFFvVTNySXNU?=
 =?utf-8?B?ZzEycFE1amZyVW53Q2tRU3MzU1JvbzlZQmswc0NJV2FPajVvd1I4aE5ad2s2?=
 =?utf-8?B?MVBVNE9oVjdVaTJxVUdPcTd4TzRKaGNoS2Juc2Q3L0FnN3JlY2YxbnhTcUdw?=
 =?utf-8?B?N2hSL1JiZDNxbHQ5bElaZlk3MzRYbGxLenk5Y28vcmFCK1F6UldyMXBOREIy?=
 =?utf-8?B?Kyt5Qm9ZaE5PaGxKUFRWUFd1TmxOTWJreGNJamwySXQwUkJYL2EzbmpLRzZ6?=
 =?utf-8?B?bFJhcHAwdHVoYml1eXdVak1NaHB2YUNXWk5RSkRWeFlJMTJNMTNjNlNTQkoz?=
 =?utf-8?B?K2ZJQWd3Q3ZLNEorRnZKQ1d2cjFKVE81THVqbEU0U3M0RmVZYi9MMDdmRDcz?=
 =?utf-8?B?emM0RHhFZW00UEVQVU1PZ3lrLzBoNS9wR0xtei9rb1EzYytxVmJxN1lSUGov?=
 =?utf-8?B?RWxqYkY1c0I1bVRSMFRzNVBaaTFkczM5cmhrelZHVTRUWUV6NUxLRlZCNVM4?=
 =?utf-8?B?T2s4Z082STd6MkJlN1dUS1pJcjdUQ2x2V2RLQ2JSdktTWUtJTWREckU1aTBG?=
 =?utf-8?B?MjZ4LzhGNDQ0ZUlCNHZjYXhnNldieitZbVhkczRLOVVFNkxUMWIyOG80U0Yv?=
 =?utf-8?B?MHdwdTNGdTRIcW1BdFNRTkxiSTdWMW9ZZ2xQaEF6VlJTRlNYZS9mc1pxR0wz?=
 =?utf-8?B?M1ZDVnc0YzU1RU0rai9nZGhUdS83bGVsQmlDTGMydDA3Q050ZVV4bDFTQ2l0?=
 =?utf-8?B?Z1dONXhqK0g1YTFvMzZVSVRFeTI0YnY3Sm5xUGR4NEZGbHBwMFcyMDJheHlq?=
 =?utf-8?B?bVhxK0pmZEVpc29kNEUxWHVqc0MvNysrZFRMRWRRQUxocG1FSTZQbTZML3RH?=
 =?utf-8?Q?JmzeP8I5Jr5fVDoImyNnry6og?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b246ab-be57-4797-6d82-08dcfd6ce353
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 07:38:49.1541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dyjq6NccwwNr4TfFWIVIlWP+tuYhIoJpgLWyYUGvRGhNF0EmQHeFI24TaNHo7sguneDClxDeWc4CT9X+iPN3vvQsokyIjn1hCM9Ttk0jJ70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U2VudDogVHVlc2RheSwg
Tm92ZW1iZXIgNSwgMjAyNCAyOjM2IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGludGVs
X2lvbW11OiBBZGQgbWlzc2VkIHNhbml0eSBjaGVjayBmb3IgMjU2LWJpdA0KPmludmFsaWRhdGlv
biBxdWV1ZQ0KPg0KPkkgc2F3IHRoZSBwdWxsIHJlcXVlc3QsIGp1c3QgYSBmZXcgcXVlc3Rpb25z
L2NvbW1lbnRzIGluIGNhc2UgdGhlcmUgaXMgYQ0KPm5ldyBzcGluLg0KPlRoZXNlIGFyZSBub3Qg
aGFyZCByZXF1aXJlbWVudHMsIHRoZSBjdXJyZW50IHZlcnNpb24gbG9va3MgZ29vZCBhcyB3ZWxs
Lg0KPg0KPk9uIDA0LzExLzIwMjQgMTM6NTUsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLCB1bmxlc3MgdGhpcw0KPmVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pg0KPj4NCj4+IEFjY29yZGluZyB0byBWVEQg
c3BlYywgYSAyNTYtYml0IGRlc2NyaXB0b3Igd2lsbCByZXN1bHQgaW4gYW4gaW52YWxpZA0KPj4g
ZGVzY3JpcHRvciBlcnJvciBpZiBzdWJtaXR0ZWQgaW4gYW4gSVEgdGhhdCBpcyBzZXR1cCB0byBw
cm92aWRlIGhhcmR3YXJlDQo+PiB3aXRoIDEyOC1iaXQgZGVzY3JpcHRvcnMgKElRQV9SRUcuRFc9
MCkuIE1lYW53aGlsZSwgdGhlcmUgYXJlIG9sZCBpbnYgZGVzYw0KPj4gdHlwZXMgKGUuZy4gaW90
bGJfaW52X2Rlc2MpIHRoYXQgY2FuIGJlIGVpdGhlciAxMjhiaXRzIG9yIDI1NmJpdHMuIElmIGEN
Cj4+IDEyOC1iaXQgdmVyc2lvbiBvZiB0aGlzIGRlc2NyaXB0b3IgaXMgc3VibWl0dGVkIGludG8g
YW4gSVEgdGhhdCBpcyBzZXR1cA0KPj4gdG8gcHJvdmlkZSBoYXJkd2FyZSB3aXRoIDI1Ni1iaXQg
ZGVzY3JpcHRvcnMgd2lsbCBhbHNvIHJlc3VsdCBpbiBhbiBpbnZhbGlkDQo+PiBkZXNjcmlwdG9y
IGVycm9yLg0KPj4NCj4+IFRoZSAybmQgd2lsbCBiZSBjYXB0dXJlZCBieSB0aGUgdGFpbCByZWdp
c3RlciB1cGRhdGUuIFNvIHdlIG9ubHkgbmVlZCB0bw0KPj4gZm9jdXMgb24gdGhlIDFzdC4NCj4+
DQo+PiBCZWNhdXNlIHRoZSByZXNlcnZlZCBiaXQgY2hlY2sgYmV0d2VlbiBkaWZmZXJlbnQgdHlw
ZXMgb2YgaW52YWxpZGF0aW9uIGRlc2MNCj4+IGFyZSBjb21tb24sIHNvIGludHJvZHVjZSBhIGNv
bW1vbiBmdW5jdGlvbiB2dGRfaW52X2Rlc2NfcmVzZXJ2ZWRfY2hlY2soKQ0KPj4gdG8gZG8gYWxs
IHRoZSBjaGVja3MgYW5kIHBhc3MgdGhlIGRpZmZlcmVuY2VzIGFzIHBhcmFtZXRlcnMuDQo+Pg0K
Pj4gV2l0aCB0aGlzIGNoYW5nZSwgbmVlZCB0byByZXBsYWNlIGVycm9yX3JlcG9ydF9vbmNlKCkg
Y2FsbCB3aXRoIGVycm9yX3JlcG9ydCgpDQo+PiB0byBjYXRjaCBkaWZmZXJlbnQgY2FsbCBzaXRl
cy4gVGhpcyBpc24ndCBhbiBpc3N1ZSBhcyBlcnJvcl9yZXBvcnRfb25jZSgpDQo+PiBoZXJlIGlz
IG1haW5seSB1c2VkIHRvIGhlbHAgZGVidWcgZ3Vlc3QgZXJyb3IsIGJ1dCBpdCBvbmx5IGR1bXBz
IG9uY2UgaW4NCj4+IHFlbXUgbGlmZSBjeWNsZSBhbmQgZG9lc24ndCBoZWxwIG11Y2gsIHdlIG5l
ZWQgZXJyb3JfcmVwb3J0KCkgaW5zdGVhZC4NCj4+DQo+PiBGaXhlczogYzBjMWQzNTE4NDliICgi
aW50ZWxfaW9tbXU6IGFkZCAyNTYgYml0cyBxaV9kZXNjIHN1cHBvcnQiKQ0KPj4gU3VnZ2VzdGVk
LWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56
aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDEgKw0KPj4gICBody9pMzg2L2ludGVsX2lvbW11
LmMgICAgICAgICAgfCA4MCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gaW5kZXggMmY5YmMwMTQ3ZC4uNzVjY2Q1MDFiMCAx
MDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBAQCAtMzU2LDYgKzM1Niw3IEBAIHVu
aW9uIFZUREludkRlc2Mgew0KPj4gICB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVz
YzsNCj4+DQo+PiAgIC8qIE1hc2tzIGZvciBzdHJ1Y3QgVlRESW52RGVzYyAqLw0KPj4gKyNkZWZp
bmUgVlREX0lOVl9ERVNDX0FMTF9PTkUgICAgICAgICAgICAtMVVMTA0KPg0KPnMvb25lL29uZXMN
Cj5BbmQgbWF5YmUgfjB1bGwgaXMgYmV0dGVyLiBJdCdzIHVwIHRvIHlvdQ0KDQpPSywgd2lsbCBk
byBpZiByZXNwaW4uDQoNCj4NCj4+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfVFlQRSh2YWwpICAg
ICAgICAgICgoKCh2YWwpID4+IDUpICYgMHg3MFVMTCkgfCBcDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKCh2YWwpICYgMHhmVUxMKSkNCj4+ICAgI2RlZmlu
ZSBWVERfSU5WX0RFU0NfQ0MgICAgICAgICAgICAgICAgIDB4MSAvKiBDb250ZXh0LWNhY2hlIElu
dmFsaWRhdGUgRGVzYyAqLw0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggMWVjZmU0Nzk2My4uMmZjMzg2NjQzMyAx
MDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jDQo+PiBAQCAtMjUzMiwxNSArMjUzMiw1MSBAQCBzdGF0aWMgYm9vbCB2dGRf
Z2V0X2ludl9kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICAgICAgIHJldHVybiB0cnVlOw0K
Pj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBib29sIHZ0ZF9pbnZfZGVzY19yZXNlcnZlZF9jaGVjayhJ
bnRlbElPTU1VU3RhdGUgKnMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFZUREludkRlc2MgKmludl9kZXNjLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50NjRfdCBtYXNrWzRdLCBib29sIGR3LA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpmdW5jX25hbWUsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKmRl
c2NfdHlwZSkNCj4+ICt7DQo+PiArICAgIGlmIChzLT5pcV9kdykgew0KPj4gKyAgICAgICAgaWYg
KGludl9kZXNjLT52YWxbMF0gJiBtYXNrWzBdIHx8IGludl9kZXNjLT52YWxbMV0gJiBtYXNrWzFd
IHx8DQo+PiArICAgICAgICAgICAgaW52X2Rlc2MtPnZhbFsyXSAmIG1hc2tbMl0gfHwgaW52X2Rl
c2MtPnZhbFszXSAmIG1hc2tbM10pIHsNCj4+ICsgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIiVz
OiBpbnZhbGlkICVzIGRlc2MgdmFsWzNdOiAweCUiUFJJeDY0DQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICIgdmFsWzJdOiAweCUiUFJJeDY0IiB2YWxbMV09MHglIlBSSXg2NA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAiIHZhbFswXT0weCUiUFJJeDY0IiAocmVzZXJ2ZWQgbm9u
emVybykiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jX25hbWUsIGRlc2NfdHlw
ZSwgaW52X2Rlc2MtPnZhbFszXSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgaW52X2Rl
c2MtPnZhbFsyXSwgaW52X2Rlc2MtPnZhbFsxXSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgaW52X2Rlc2MtPnZhbFswXSk7DQo+PiArICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4g
KyAgICAgICAgfQ0KPj4gKyAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgaWYgKGR3KSB7DQo+PiAr
ICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCIlczogMjU2LWJpdCAlcyBkZXNjIGluIDEyOC1iaXQg
aW52YWxpZGF0aW9uIHF1ZXVlIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgZnVuY19u
YW1lLCBkZXNjX3R5cGUpOw0KPj4gKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAg
ICAgIH0NCj4+ICsNCj4+ICsgICAgICAgIGlmIChpbnZfZGVzYy0+bG8gJiBtYXNrWzBdIHx8IGlu
dl9kZXNjLT5oaSAmIG1hc2tbMV0pIHsNCj4+ICsgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIiVz
OiBpbnZhbGlkICVzIGRlc2M6IGhpPSUiUFJJeDY0IiwgbG89JSJQUkl4NjQNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgIiAocmVzZXJ2ZWQgbm9uemVybykiLCBmdW5jX25hbWUsIGRlc2Nf
dHlwZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgaW52X2Rlc2MtPmhpLCBpbnZfZGVz
Yy0+bG8pOw0KPj4gKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgICAgIH0NCj4+
ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByZXR1cm4gdHJ1ZTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0
YXRpYyBib29sIHZ0ZF9wcm9jZXNzX3dhaXRfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsIFZURElu
dkRlc2MNCj4qaW52X2Rlc2MpDQo+PiAgIHsNCj4+IC0gICAgaWYgKChpbnZfZGVzYy0+aGkgJiBW
VERfSU5WX0RFU0NfV0FJVF9SU1ZEX0hJKSB8fA0KPj4gLSAgICAgICAgKGludl9kZXNjLT5sbyAm
IFZURF9JTlZfREVTQ19XQUlUX1JTVkRfTE8pKSB7DQo+PiAtICAgICAgICBlcnJvcl9yZXBvcnRf
b25jZSgiJXM6IGludmFsaWQgd2FpdCBkZXNjOiBoaT0lIlBSSXg2NCIsIGxvPSUiUFJJeDY0DQo+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAiIChyZXNlcnZlZCBub256ZXJvKSIsIF9fZnVu
Y19fLCBpbnZfZGVzYy0+aGksDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICBpbnZfZGVz
Yy0+bG8pOw0KPj4gKyAgICB1aW50NjRfdCBtYXNrWzRdID0ge1ZURF9JTlZfREVTQ19XQUlUX1JT
VkRfTE8sDQo+VlREX0lOVl9ERVNDX1dBSVRfUlNWRF9ISSwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICBWVERfSU5WX0RFU0NfQUxMX09ORSwgVlREX0lOVl9ERVNDX0FMTF9PTkV9Ow0KPg0K
PldoeSBkb24ndCB3ZSBkZWNsYXJlIHRoZSBmdWxsIG1hc2tzIG91dHNpZGUgb2YgdGhlIGZ1bmN0
aW9ucyAoY2FsbGVkDQo+c29tZXRoaW5nIGxpa2UgLi4uX0RXX01BU0spPw0KDQpEbyB5b3UgbWVh
biBtb3ZpbmcgbWFza1s0XSBvdXQgYXMgYSBzdGF0aWMgYXJyYXk/DQpJcyAuLi5fRFdfTUFTSyB0
aGUgYXJyYXkgbmFtZT8NCg0KPg0KPj4gKw0KPj4gKyAgICBpZiAoIXZ0ZF9pbnZfZGVzY19yZXNl
cnZlZF9jaGVjayhzLCBpbnZfZGVzYywgbWFzaywgZmFsc2UsDQo+DQo+TWF5YmUgdGhlIGR3IGFy
Z3VtZW50IHNob3VsZCBiZSBkZWNsYXJlZCB1c2luZyAjZGVmaW5lIGluIHRoZSBpbnRlcm5hbA0K
PmhlYWRlci4NCg0KSSBzZWUsIG1heWJlIGRlZmluZSAuLi5fMjU2X0JJVCBhbmQgLi4uXzEyOF9C
SVQuDQpCdXQgYSBib29sIGlzIGVub3VnaCBmb3IgdGhlIHB1cnBvc2UsIHdlIGp1c3Qgd2FudCB0
byBrbm93IGlmIGl0J3MgMjU2IGJpdCBkZXNjLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

