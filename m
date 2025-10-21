Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A411ACCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 03:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB2ft-0007Wl-JW; Mon, 20 Oct 2025 23:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vB2fr-0007Wc-Mp
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 23:04:35 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vB2fo-0004Dp-6f
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 23:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761015872; x=1792551872;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IHLfIMRLblqiYKLCWMnpFyBcTNnNbZ72oPcGk5lpqgs=;
 b=gqhEpahdY9++gLLx4kKNFUdvoQnC9tEJZLJg7OyY/gSxIshzv6uMLz4j
 nzQw2q7UZYHAhTBIdfqnvsJF4TYlVfFAmGXjPoE5Fn+F4AY/8eNrYAU/0
 YM220gm3TWvnB1tqh5qEdzpBOlOynaaqStQSDF3D6JGIuZUQoS9Eod2kB
 oZsR328kXfGUfrHg33l/Ks1XOVWwmV9m0Xrmpi7hn0+EDk1ZOcBkw31nY
 wZ2INRnQsBFPA4UvPne4Od31PEAERoNrg/q8Uwl6FN13EikaoCoCW8BMT
 Rcm+Sf1vgXzFrFTJSyXXhpmhcAmtp17ENg7Bb++XnyvDahUUlSglqzGdY g==;
X-CSE-ConnectionGUID: jdM5zzQmTz+6s9L3fpwmUQ==
X-CSE-MsgGUID: wDDRiVnNTdupk6XYIxXcaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63178747"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; d="scan'208";a="63178747"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 20:04:28 -0700
X-CSE-ConnectionGUID: ecKJs7UqSgmaV/TDHLsWtA==
X-CSE-MsgGUID: sp0dZuSUR02IP4F4WbTL0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; d="scan'208";a="187748923"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 20:04:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 20:04:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 20:04:26 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 20:04:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyqzogU64/SQYw0A3s/Fv0b05eGLGmenbj9IMyfSKySTJtnXUhNXO1XcPcS0Etsr/25aXbdE83p6DgOpM4d0tuZKB13ZaGHFev6kyiPZDhWr20AMZOTJxnPzmd4c/OWa4ZI1Pd4+DO+TPzumYec2q6XHB9Cn8Wedaz2o0VF8Flf275oF+X6Xx92Mmis6P2bsUTjkWzq6gLhx/cobc1NtcjTaOhY7F0Y+3VJLMIfgYH8RrMFLD7qULWgdsSuIePASZlaaoMimat/QPnNU5mIBuYhFGLC2uoclLrnW6Zx0M0EqISyHc5TcCjRNx5S2SFXwEt8V5zKsdm2zZGrIuULSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHLfIMRLblqiYKLCWMnpFyBcTNnNbZ72oPcGk5lpqgs=;
 b=jjqnB/U95lm7G/ZaqGIEVwERDQJSBSXVQTL5O4Z3oaoxlH86seyAc/AHkSLPaV4WCn+e7lzkn/rynKqR0/pEEBGyoJ92vBP5dZE//0fqsSxeEua+7s2roWn91/vWAyi5mXIhDKycEZnIFZqCerGJ1SS/V0HTW8KKzGvRQCq2KtJ/d4YeQzli/84QLfKCWJjtf4x1n5h4bJk1d0gUKFkLTSjkykCTZE6/i7TTVBlcG5XIRYp9nQBjE2DEZeZo56MYuA939mep0TP/qmdO4wpGQnAwIEONfokxUTvTOz3NhybguuiYHDdUxbVggYuvSeyIboAv6AfnJRmTxJ34umvvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 03:04:23 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 03:04:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>
Subject: RE: [PATCH v3 3/3] intel_iommu: Fix DMA failure when guest switches
 IOMMU domain
Thread-Topic: [PATCH v3 3/3] intel_iommu: Fix DMA failure when guest switches
 IOMMU domain
Thread-Index: AQHcP0mCAPqPONpbl0+IAfZ4XwJv8rTLAGgAgADvivA=
Date: Tue, 21 Oct 2025 03:04:23 +0000
Message-ID: <IA3PR11MB9136C2A641874D167930EE9E92F2A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251017093602.525338-1-zhenzhong.duan@intel.com>
 <20251017093602.525338-4-zhenzhong.duan@intel.com>
 <f5342918-497f-44dd-b39a-07a56ca0826c@intel.com>
In-Reply-To: <f5342918-497f-44dd-b39a-07a56ca0826c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8657:EE_
x-ms-office365-filtering-correlation-id: ef1398db-7a62-494a-f8b9-08de104e89a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OTJ6ZVlTQ0VKV04reUY1Q2krSklETnR3b2VYcGwvZ0hEWlNkL3ZvZjJkazE3?=
 =?utf-8?B?elFnLytYQjhWaHN3T3E2aktGMzJNVzFOaUNpejNobndONDdUVE45UjlCOVVJ?=
 =?utf-8?B?eE85dXNIUjFMVmZYK2hyRUdlaW1yZ3c0ekpsZEtyeThrTXMrNGthdUZaTThU?=
 =?utf-8?B?S01ZTWxOSy9IVnZQZS9wVkVHMGZheER1V3E4dm5lN2hnQmJGWUVXdCt4VENy?=
 =?utf-8?B?NU44K0ZXTVhPcFJVWGpxYnkrMjlZZUdPcWdLaERxYnNqeDRLaktLMWhyb3By?=
 =?utf-8?B?MGE3RnRpTkNlN090RlRmdlBYckVZMTV0eEZrcHg0MFpOWTVQb0hkSGJ4dlBj?=
 =?utf-8?B?KzJLVCt3dGZ5dnc3V3FhVE42NEJTbFJOdVpkMDdCOTJkcVJFNEgvTERFYW5T?=
 =?utf-8?B?bEp4YkZnNHYrWHdJTmVnOEZNc2Fyd3dYMzlMelIyb2x1TUM2dENtYWRLTzJS?=
 =?utf-8?B?RVhiU1RLa1RhWUpYN0FNWnRnRGVFN2N2KzBaNUtHTWQyVDk3U3A1U3hjd3h3?=
 =?utf-8?B?K1JrS0t3WDZWaTZWd1VhVVo5VGVML1RtaEZzWnJBQmlTVytuOVFiQlJOanBs?=
 =?utf-8?B?NFd2NjY4NmU0Uktnb0d6NjFGbWd5WFFSNkFNb2dmYTJMTHB1eXFlcWFBY2Nr?=
 =?utf-8?B?N05LdW9yS0pmcTNzZW04eVlpWDd2SnMwOWdNc1Q0Tlc0blNuL1g1YTlLREt3?=
 =?utf-8?B?andHVC9qTWtlNXRidFJEWnhEekNLai8rWjBCNmNqSjBhT211Qzd2aFhZSjM2?=
 =?utf-8?B?S2ZwSEhkakRYL3Z3aUZZclplN2gwbjZuSXlSd2tYQnZuZGJ2MHZsNGp4bEpE?=
 =?utf-8?B?bSt4akx0NGJwc1ovTjAwYzBzMjJYODEyVmtOTzBoVVNqK2YySUpVMU5TL3U0?=
 =?utf-8?B?VUY0NmxMMVpmVGZqMEJXemhFbDJ1ZkUzTm13WkV2UjNGalJoL0Juc2JMNEVQ?=
 =?utf-8?B?OVBIdklQOTZaajVGWHp0NEYyVnpheisrR29XR3VyaG9LdTQ0WXkwbkl1b29k?=
 =?utf-8?B?cFhxMEM0UDRXY1MvY1p1SUQ2SUlKRlRSZkd6L2ErdG8yYmNNYm1nNU9WMFFn?=
 =?utf-8?B?bk0xUmZaa2V6RmhnNkQ0RXl0eVcxZkdqbC9sSVE1a0VFa0lMVkN3MXdFc2NJ?=
 =?utf-8?B?RTVaMGc0K3diL0hneTVEYnhSMXRvakJOWTZ6eWY3ZktEK0ZnTlJWWUU4SlZK?=
 =?utf-8?B?NTZDMWxzZFFXdlJwZU0wMExUdkdWMWdqTXNrS1lCRGF4UlMvZ2tqVHVRT3VL?=
 =?utf-8?B?S2FkTFNzak96d3dWTE92V2hQRDRNREpSS1RjYWR0Z0hjc043ZTc0TWcxZ05X?=
 =?utf-8?B?a0JMbjlrV3dEQmNNSnZxLy93UFA1dU9zOXhMcjJBbVZwblY4akVjTXhsYlJX?=
 =?utf-8?B?eXVFRDMzbXRVbTQvcTVlWlQ5VytmOEN3VG9XOGhpZm1mYTZ2Y3JDSEVXN1Qv?=
 =?utf-8?B?NnRWTG9lVXVCRVFjQXFvZC8vd0g3Z05UVWJBa0dZbUhPbTQ5RVpEVkx5UTE0?=
 =?utf-8?B?TE43anNWdVpvRkd1R0UrenEyY2syRGQ5M2N1QVAya2ZSNjZzSkxueGVVUnVO?=
 =?utf-8?B?ZlFMeEUrT1hScFNlVkJQcjAvcXBEUzFSYkVzeGpjSWU0OGhaWGltTkkzMkVk?=
 =?utf-8?B?MG5EbnQyVFIxQ084Z0VSLzlrVkJzcmVDT1Q5Z3k3MEF5WXB0OVQ5ZWhKNU9Z?=
 =?utf-8?B?UG1XRTQvT3ZEVGpNQjY4ZjlQOGN1eFZ6dnpTanFTakZmblJaUTMwYjJ2VWQr?=
 =?utf-8?B?VDBrZzN3SWlWTFJJVWtMT1BKMlJaTk54M1d6UTM3Nm51cDA1WXpvQUt1ZkJC?=
 =?utf-8?B?K3gzOU9YRGN6TEtRMGJMLzNsaCsrcmtuVU1iYWVXS0VHSVN4MjlpeTJDR2x1?=
 =?utf-8?B?VnVLQjVmbGFnRUgweEFYRUpyT3ovTHFZUnEvbDRKaDgrRHZXbDROWTFFUTk5?=
 =?utf-8?B?TDd5cHVyZnZ2VWdhVE8yTTBhWFQ0ZTFENzdsQ1JXMmkrSm1CTjJTb2gvRVVo?=
 =?utf-8?B?OWROUkNlam0vT0tpSVBzejkvOTBLRUs0S3NtMVFlM1FUeUFLM3JWbFJkS055?=
 =?utf-8?Q?Jb0tin?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emdFSTgxOVo2SFVycFVzVmZnNHBRS3V0UWpJQi9FbTN4WFVJaWlGOWl4bU5S?=
 =?utf-8?B?TlRSNmo0UEdRMEtmQllCMVhWSVhGTGFzajRMc3hTRm9OcDJWakRSbVJ3LzNr?=
 =?utf-8?B?SWI1RnlDMEhxR3FvMEd6amZsYmJsRnRYQ0dLUDVhUU5XbTgxR0R5N2JMRlY4?=
 =?utf-8?B?TDZmMnQrVVhId0VsZU9idmlrWjdheS80em1RVkVvQURWUEFjTHZDZ290bzRt?=
 =?utf-8?B?ZEJWcGxEL3pwdzQvUzJLYXJYSDZKYWdiR3dvSThmQmFGcG1aalNrcXh2ck8z?=
 =?utf-8?B?QkhDSHE2bklkR1IwZVdta1NncDl5aEpoS0lxVmVUTjhpbms0VFNnSE1QNUpH?=
 =?utf-8?B?V3d5K2dqaEVRb2pQOG1OQTNYNkIwOThLV3pESFVCSjYwbWhLa0xET29yR242?=
 =?utf-8?B?YlVzNkFoalBVdzVNazcvWEdxZjZxaDFjWmxmRnU0cDJhV1lpcGJxdEtsS25m?=
 =?utf-8?B?UVQwUGRSZEdKSE81TFNNRU05N2djbnZlOEpzSnZWTk9UWHRQZnUxTFBNZyt4?=
 =?utf-8?B?VjRpKzlpNmdEME9kY1VrN2JhMWRacVNpSWgwcVRMT1RtV1pOWndFSEg4QkhK?=
 =?utf-8?B?NVFaVzBBMzR4U2xrQ0JKcVU3WnM5d3c1Tm8zVWc4L3Y1YmhoNVpQQTExS3pG?=
 =?utf-8?B?elZPSXNpSmx3T3k4cVVLTk9wY1NTdU1NRW5BYzVKVXBKeGZRUUo4Y1FDNyt6?=
 =?utf-8?B?VFFSNzNBUEpVczhLdXlPNlUxbmFrclY0N3ZEVnVxa0pYNHFmeG15VGtDeDVv?=
 =?utf-8?B?ZmMzZ2kra1RSa3JUOWFFZEoweDA3bGZVaWp1dHBEUkRyZER5SklqYjJIWVNF?=
 =?utf-8?B?U0IvaCtnUTE4S2hhSzhvck9zYkgxZjZMbWE3WERwT1B1N2J3VFlwM2VhMUdM?=
 =?utf-8?B?S1ZlV0tseGZCUUFhYmRjK0pQT1JCdSthSUdKa0s1UDBRQWpxZWpNQ25RVXBx?=
 =?utf-8?B?aWRXVnFFbXJqVGcwa3B6bi81cGJlNWIyODdxcTErbjYvMUVZbXBPazhNbnlT?=
 =?utf-8?B?S1ZYYW42QndqT0pwdkordXQrd3NnVUdNbmhtSm52Nzh3ODI1T2k2WXMwSjRO?=
 =?utf-8?B?aDl1enVtTnBnWW1hTWM4NXZMd2pPMks1MzdtRTh3UU55UGl6a2tDR0E1dFZH?=
 =?utf-8?B?Y2k0S292MG9jejB1dmJtQUZqaE0ySENLV28wV05zNWRJT3VPMFZBU2RqMEs0?=
 =?utf-8?B?M0t2Tk5UZlhYRmR0N1pOVnhycVZkTG50SWU2aUhqek1ESjRZYUYvbWVPUUNv?=
 =?utf-8?B?L2FIUDRmY1ZtMVR4c0prUnRLYitxZ1FXMndWbUZtMDlUWVBna0R4VzRGdGp4?=
 =?utf-8?B?UGIrVm4wME5tZ1NLZGh1bHlrWHFQSDBMdFd3NGNnc1JTZ0MrZFpoNWxCNFJL?=
 =?utf-8?B?TXcwWlNCWEowbk10RlZKem8zNm1OSlBzVVhWNVVQZFFWU2U3N3g0RlZWUVN5?=
 =?utf-8?B?UU5pUFZaeE14N2RtMHFtQm4zbWVjdjF3dmdweTdzdktxRWREbHI0VXR6MGRk?=
 =?utf-8?B?OXFHQ010OVdVOGlDTmNrU0ZGekFBbmJndEdoQ2swbVBPYTVscjZ5TVhsS1E3?=
 =?utf-8?B?OS9kOGVLbW1iQUFRUE1wMUtzT2cwaTFqUENqM3pDNW1jUTUzL1hTWXFacE5H?=
 =?utf-8?B?MCt4SXRHOWVDRFhHOGtkWDlsNmNHS0QwSEtyZ1lRSWYzM0srS2pQWXVHaEtK?=
 =?utf-8?B?N2N1U3plemptdlkvMGFPUGlkY3pSeXROTG5DSFZ0NDN1VUc2RUJ4SGN6MFZQ?=
 =?utf-8?B?WFpOcVdoT1JUTTdiRFVRbW1SeTRXMHFKK3VJOFF3eDRWT3FoWTdaM25ZQ2Nq?=
 =?utf-8?B?Q3NkclNSekZ4TVlISVJ5eWJ6WDR3ZFNsaE5UTTV4bjFlcDJKSlBQZXl4ME1C?=
 =?utf-8?B?YlkvSndoNHFGZjk5elN4aUg2YklJQUoxL2MyV09rZ3JDaTRzSWhFSWllRld5?=
 =?utf-8?B?UzJxb0t4L2JHbUhaV01qQVc2dzVON25JYlZGSEhZU2NmWkZqKzRabmNJRFpY?=
 =?utf-8?B?N20zbTNGOGFoeWJFQTBuQlJXMFFGUWlXaVordEZFSks1K1JkaW9ST0FXWGwv?=
 =?utf-8?B?cjRVem1zK0h4U1BQR3hTbnBFWjBFQUFvTkFjOU9OTUtWUVc3dGs0RFZYS2cv?=
 =?utf-8?Q?/gzKfyq4QJKHsHCqHvbxVRGqr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1398db-7a62-494a-f8b9-08de104e89a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 03:04:23.5808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6EHnKR6YGjhC4kD9i5pq8JLi7jSloe1vi6hPcV0cC3B91sYSYqcHC6FsDmqHqs0I26JA+wEHprvnxc8Sy8ggKowXA33QKZl9dAMnswXaAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy8zXSBpbnRlbF9pb21tdTog
Rml4IERNQSBmYWlsdXJlIHdoZW4gZ3Vlc3QNCj5zd2l0Y2hlcyBJT01NVSBkb21haW4NCj4NCj5P
biAyMDI1LzEwLzE3IDE3OjM2LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEtlcm5lbCBhbGxv
d3MgdXNlciB0byBzd2l0Y2ggSU9NTVUgZG9tYWluLCBlLmcuLCBzd2l0Y2ggYmV0d2VlbiBETUEN
Cj4+IGFuZCBpZGVudGl0eSBkb21haW4uIFdoZW4gdGhpcyBoYXBwZW4gaW4gSU9NTVUgc2NhbGFi
bGUgbW9kZSwgYSBwYXNpZA0KPj4gY2FjaGUgaW52YWxpZGF0aW9uIHJlcXVlc3QgaXMgc2VudCwg
dGhpcyByZXF1ZXN0IGlzIGlnbm9yZWQgYnkgdklPTU1VDQo+PiB3aGljaCBsZWFkcyB0byBkZXZp
Y2UgYmluZGluZyB0byB3cm9uZyBhZGRyZXNzIHNwYWNlLCB0aGVuIERNQSBmYWlscy4NCj4+DQo+
PiBUaGlzIGlzc3VlIGV4aXN0cyBpbiBzY2FsYWJsZSBtb2RlIHdpdGggYm90aCBmaXJzdCBzdGFn
ZSBhbmQgc2Vjb25kDQo+PiBzdGFnZSB0cmFuc2xhdGlvbnMsIGJvdGggZW11bGF0ZWQgYW5kIHBh
c3N0aHJvdWdoIGRldmljZXMuDQo+Pg0KPj4gVGFrZSBuZXR3b3JrIGRldmljZSBmb3IgZXhhbXBs
ZSwgYmVsb3cgc2VxdWVuY2UgdHJpZ2dlciBpc3N1ZToNCj4+DQo+PiAxLiBzdGFydCBhIGd1ZXN0
IHdpdGggaW9tbXU9cHQNCj4+IDIuIGVjaG8gMDAwMDowMTowMC4wID4gL3N5cy9idXMvcGNpL2Ry
aXZlcnMvdmlydGlvLXBjaS91bmJpbmQNCj4+IDMuIGVjaG8gRE1BID4gL3N5cy9rZXJuZWwvaW9t
bXVfZ3JvdXBzLzYvdHlwZQ0KPj4gNC4gZWNobyAwMDAwOjAxOjAwLjAgPiAvc3lzL2J1cy9wY2kv
ZHJpdmVycy92aXJ0aW8tcGNpL2JpbmQNCj4+IDUuIFBpbmcgdGVzdA0KPj4NCj4+IEZpeCBpdCBi
eSBzd2l0Y2hpbmcgYWRkcmVzcyBzcGFjZSBpbiBpbnZhbGlkYXRpb24gaGFuZGxlci4NCj4+DQo+
PiBGaXhlczogNGE0ZjIxOWU4YTEwICgiaW50ZWxfaW9tbXU6IGFkZCBzY2FsYWJsZS1tb2RlIG9w
dGlvbiB0byBtYWtlDQo+c2NhbGFibGUgbW9kZSB3b3JrIikNCj4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcv
aTM4Ni9pbnRlbF9pb21tdS5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4gaW5kZXggMDdiYzBhNzQ5Yy4uYzQwMjY0M2I1NiAxMDA2NDQNCj4+IC0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBA
QCAtMzA4Nyw2ICszMDg3LDExIEBAIHN0YXRpYyBpbmxpbmUgaW50DQo+dnRkX2Rldl9nZXRfcGVf
ZnJvbV9wYXNpZChWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywNCj4+ICAgICAgIHJldHVybiB2dGRf
Y2VfZ2V0X3JpZDJwYXNpZF9lbnRyeShzLCAmY2UsIHBlLCB2dGRfYXMtPnBhc2lkKTsNCj4+ICAg
fQ0KPj4NCj4+ICtzdGF0aWMgaW50IHZ0ZF9wYXNpZF9lbnRyeV9jb21wYXJlKFZURFBBU0lERW50
cnkgKnAxLCBWVERQQVNJREVudHJ5DQo+KnAyKQ0KPj4gK3sNCj4+ICsgICAgcmV0dXJuIG1lbWNt
cChwMSwgcDIsIHNpemVvZigqcDEpKTsNCj4+ICt9DQo+PiArDQo+PiAgIC8qIFVwZGF0ZSBvciBp
bnZhbGlkYXRlIHBhc2lkIGNhY2hlIGJhc2VkIG9uIHRoZSBwYXNpZCBlbnRyeSBpbiBndWVzdA0K
Pm1lbW9yeS4gKi8NCj4+ICAgc3RhdGljIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3N5bmNfbG9ja2Vk
KGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBncG9pbnRlciB1c2VyX2RhdGEpDQo+PiBAQCAtMzA5NSwxNSAr
MzEwMCwyOCBAQCBzdGF0aWMgdm9pZA0KPnZ0ZF9wYXNpZF9jYWNoZV9zeW5jX2xvY2tlZChncG9p
bnRlciBrZXksIGdwb2ludGVyIHZhbHVlLA0KPj4gICAgICAgVlREQWRkcmVzc1NwYWNlICp2dGRf
YXMgPSB2YWx1ZTsNCj4+ICAgICAgIFZURFBBU0lEQ2FjaGVFbnRyeSAqcGNfZW50cnkgPSAmdnRk
X2FzLT5wYXNpZF9jYWNoZV9lbnRyeTsNCj4+ICAgICAgIFZURFBBU0lERW50cnkgcGU7DQo+PiAr
ICAgIElPTU1VTm90aWZpZXIgKm47DQo+PiAgICAgICB1aW50MTZfdCBkaWQ7DQo+Pg0KPj4gICAg
ICAgaWYgKHZ0ZF9kZXZfZ2V0X3BlX2Zyb21fcGFzaWQodnRkX2FzLCAmcGUpKSB7DQo+PiArICAg
ICAgICBpZiAoIXBjX2VudHJ5LT52YWxpZCkgew0KPj4gKyAgICAgICAgICAgIHJldHVybjsNCj4+
ICsgICAgICAgIH0NCj4+ICAgICAgICAgICAvKg0KPj4gICAgICAgICAgICAqIE5vIHZhbGlkIHBh
c2lkIGVudHJ5IGluIGd1ZXN0IG1lbW9yeS4gZS5nLiBwYXNpZCBlbnRyeSB3YXMNCj5tb2RpZmll
ZA0KPj4gICAgICAgICAgICAqIHRvIGJlIGVpdGhlciBhbGwtemVybyBvciBub24tcHJlc2VudC4g
RWl0aGVyIGNhc2UgbWVhbnMNCj5leGlzdGluZw0KPj4gICAgICAgICAgICAqIHBhc2lkIGNhY2hl
IHNob3VsZCBiZSBpbnZhbGlkYXRlZC4NCj4+ICAgICAgICAgICAgKi8NCj4+ICAgICAgICAgICBw
Y19lbnRyeS0+dmFsaWQgPSBmYWxzZTsNCj4+ICsNCj4+ICsgICAgICAgIC8qDQo+PiArICAgICAg
ICAgKiBXaGVuIGEgcGFzaWQgZW50cnkgaXNuJ3QgdmFsaWQgYW55IG1vcmUsIHdlIHNob3VsZCB1
bm1hcCBhbGwNCj4+ICsgICAgICAgICAqIG1hcHBpbmdzIGluIHNoYWRvdyBwYWdlcyBpbnN0YW50
bHkgdG8gZW5zdXJlIERNQSBzZWN1cml0eS4NCj4+ICsgICAgICAgICAqLw0KPj4gKyAgICAgICAg
SU9NTVVfTk9USUZJRVJfRk9SRUFDSChuLCAmdnRkX2FzLT5pb21tdSkgew0KPj4gKyAgICAgICAg
ICAgIHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKHZ0ZF9hcywgbik7DQo+PiArICAgICAgICB9DQo+
DQo+SSBqdXN0IHJlYWxpemVkIHRoYXQgaWYgdGhlIE1SIGlzIG5vZG1hciBNUiwgdGhlIG5vdGlm
aWVyIGlzIG5vdA0KPnJlZ2lzdGVyZWQgYXQgYWxsLiBpcyBpdD8gU28gdGhlIGFib3ZlIGxvb3Ag
YW5kIGJlbG93IGRvZXMgbm90DQo+ZHVwbGljYXRlLg0KDQpZZXMsIGlvbW11IG5vdGlmaWVyIGlz
IGEgbWVjaGFuaXNtIG9ubHkgZm9yIGlvbW11IE1SLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

