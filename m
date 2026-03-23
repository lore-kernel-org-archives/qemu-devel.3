Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F6AD58CD6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 06:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4YKg-0001Nw-3z; Mon, 23 Mar 2026 02:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w4YKb-0001MC-Kf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 02:00:05 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w4YKX-0007cx-VY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 02:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774245601; x=1805781601;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bAnzZ0bp2JJoswNwsBaLcUKVsrkdrTf1ORF1lyFZhrE=;
 b=dOLiY1RGh5xQIbRaRGYyl0dTjkLwfkb3xFSO+QVyE9X/1qFYhTD2fm9R
 igQ4ACn+HuIkSSN1BHiVYZ+zFRrlVu18H30PcKpKjsLnuygsmrzfflu+Q
 s6B32gtR75hJD2XeaSPGLLJrFqyrwAw2ORWJTDLyFgtETN49bBYa1jxxP
 cH3KJ/OeaZ+nr7LnxYNQX4IkSiT8yFiCK9IZq/fPlUT+fjD860+OCRjX9
 IC5i5UX1kKC8OnQ2r2PXzoyRAMaqyGw8yTbQPUVBRcWwRhJatMq6eH50Q
 cY8zUVEnv7TU7HPqce5a/UQopdW0S0WxBTz+tFn6ezkcIMoss33D/qXUh w==;
X-CSE-ConnectionGUID: L5YwDYNSQIaO7Q3LCErXwg==
X-CSE-MsgGUID: bQ9nBKz+SX2jQo/URwTmJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="97858739"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="97858739"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 22:59:59 -0700
X-CSE-ConnectionGUID: AL0VrqshTTWZlUvl1qUedg==
X-CSE-MsgGUID: 1gjTvCXwR/ea6M3xt1K6RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="219584281"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 22:59:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 22:59:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 22:59:58 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.36)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 22:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3+9EBoIY8gwfisYa3nL8z1mQ2T/XveU4pF+W2sCl5NGMiTToDixXpTiEqso0ccLmV/a31bHDBjLtjuA90sQpzTNUsZNHK0YSPBJeMaQ4Z57VHOpYbS8v9eyF6IY1AYeUTBBMB9ftfxXXJ0oCMTJ+hvzFq7qNEaMVcItNHHkd6n+XiRYMgZqq5Z63zC8DZ2td2I7k/kNO6R30qA70Y1I8ea89l4OyAZ2f7XK+6M4lEZGhT+AGfNsTRnUsn1glEAkAFfhuzea0e0FjruaNAH8sA5pz60t2L8lIeurySAm/jzXibUdL89R0J7QmmLuKEVKKoHrVL3z0ldJ6fYh78Sjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAnzZ0bp2JJoswNwsBaLcUKVsrkdrTf1ORF1lyFZhrE=;
 b=RuVX8EevhDEB64m6qA5yPMov3lqipBpRu8rZSNW4BBydZ2WZP8rlwLLkztfwiyScC/w7llzanU7YH1Qtz1xGF1Mt51Ye4t7FCUCQzLCwAyNxsNfINoaHm1qYCb5qbUV17CslswgoPrfprAb037PvTONrNQ0zcMA3Nttq2nHt9veWy7CStYbqdxNUErYiennVE8zKhU8qjqRJarFjP6MT6jfVz71JCcWQNylaK4WN7n/WqW34dmY4Ekqkq1GojcYD4kudeMs5FLCN2U6P0rKug9IDnr/1XxXWnekWuyU6i4yc60JBte+vPp3SzRCh7woOD/F/RDgW3UuLbwtbqnJF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM3PPF4C5964328.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Mon, 23 Mar
 2026 05:59:51 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Mon, 23 Mar 2026
 05:59:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
Thread-Topic: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
Thread-Index: AQHcrRuZzPy+NHZDEEGZrvXfRrImE7W0TzwAgAFJ0UCAAbE2gIAEb+cQ
Date: Mon, 23 Mar 2026 05:59:51 +0000
Message-ID: <IA3PR11MB913664B4A5600509D355ACBD924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-8-zhenzhong.duan@intel.com>
 <e8843f0e-61ec-4425-ba25-62b85b0e5371@intel.com>
 <IA3PR11MB913681B1F3E8A68B3049D0F0924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9d6ef338-48b8-4724-8a5c-fe610a98620e@intel.com>
In-Reply-To: <9d6ef338-48b8-4724-8a5c-fe610a98620e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM3PPF4C5964328:EE_
x-ms-office365-filtering-correlation-id: 0c8db845-358e-46be-7a1a-08de88a165cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|3613699012|38070700021;
x-microsoft-antispam-message-info: cZmBE17aq30T4L8fKiBqagWSZxSoS2rpkPkU6sDV/yA9t6j5gFAMIcKeVNe8b/W7St63ufdPiITPlP5c9embntPemou4/oDOKK9JGYEnKUcppg99DHIIeQIyyWA8jDcKCKXDE6GBNqEz+AFXpuyr+DTMi9LNxqaegZLmC3yjY242A8vp0oGt1/mZY9g0d7XSIOxIH+o2KUhyAIxevB++iiKfPTbnzaUHlPOcXuoTsvqvMowKTZwjJJSoESc57VLoWxHW/3N9CRsWYRji7XEEdpfU+Cw6bSEM7/sDCWJHi7SCQnZVQWiI7npE3jvAB4R5bUI0cpEVdu5weIaat+xdMdJkhjPGLWxa4wvOEuC/5nRye3upzXgfiYJrXwPBzHzrHIozCCI+xnzacQM8J4XyE8YTw88B9S6PSIWVtsILlB89qGKvfxQGq6KXwfEqIAHtvSx0C6jKYWXCT6MgAuuPQNzwZQpORYg9guS8jBv3pImB/QOaW7Ft7mr8EzzM6azxm6XTAvswKdy4eGdaetUQYWZHfQdkq05jw0rKmz+lQe81I8TdnZLlSbJldqkiNo/JKE+UDCYBPARG8UmMY5YiZN6AnKJK/uT4FUGkHBvDJmvrhEU7lR1IgaIfWieAj3NuoAkaLz9tUuFuSwTJeVLP7EHgMLqoZ+58wMWSpclSFSYDFPZAJrBvbKwcWym8a4CQSiuyEpEhOdJzkKpNft9C20mL8ltijrez54T2x+TU5yHHgZtQO4pVIQruj7malfz0vsp7ZXM1tE24AqYxuT07kixXj6OkVUBfnhcj2/u02zlt+V9sWDhMCgniJ7aLP5wp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(3613699012)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TCtlVHhLaTZBNDdQZGNLaFlGWU4xaERyamt1bGhlU2NPbjc0eVlwQmhlSkJi?=
 =?utf-8?B?ZEFHQVM1ZWswV3ltSlhwV2t0VEdsNWxsWWNSUTY1NlltZnFkZW5JZ2lLVnN3?=
 =?utf-8?B?SHRJRVZhSWkwWEJycVpnSVNtdXhLc25xcW9ZN1Y1dzBqc1pIdUx5ck8rSFM2?=
 =?utf-8?B?amFiOUZZMUFhbExUUFZ5Sy9XaTBNZ1MwTU5wZ3NOaGthbWlrWUVWNTRmZVpx?=
 =?utf-8?B?QzROeFB2d1hHOXB6UU8xRXlyUTF2T3dZUjRyREdxMEpGQ2x2eEMrMGtsNzcy?=
 =?utf-8?B?azAvZDFob1A1TC9zSzZEQVZYRnA5d0J1WGNaR3V6T0ZrZ0lHdkQvNFc1QnU3?=
 =?utf-8?B?SEZTQ2h6djQxeHhWeTlmd3A1SWlqM282QjBTUEtXVDZ3Y2YwNXBLMFlKWVdo?=
 =?utf-8?B?TUVJVWdoTllsV2VjcWlxc043MURJWEgxSTk5RUFrZDg1blNaSW1EZ29rdDNN?=
 =?utf-8?B?NytKdzlMd3J1azVUZjdhK1d0MzRBS2NSZ0cxbTVxRk80cXczTUJNVEFEMDJ0?=
 =?utf-8?B?Um5hYTMvZEhyZ3RqM2hDbUx3enp5TENXVVNWNEhNRjlXbC9LeGRGSW9DMnp1?=
 =?utf-8?B?c2kwQTB5UEZrVUpwc1NpN2pTam5ic1F3dkw2Z2dlS3VON2JQdWZTUlJmNHBM?=
 =?utf-8?B?bC9kRVVRUG8wNDg2MHdwcDRQN2d4S1BUaXhES1N4bXh4ZXN5TTF5c1JrRTZv?=
 =?utf-8?B?RVNKNVJlVlRrZnhObXhteWlJN3pXdVZqQ2R6UXZ3UVJsMlRRMlNiQVIweGNn?=
 =?utf-8?B?aEJJTEhPOW1CSmRzRUc1YmNrVUZsNkhVVHpna0xIZU1QZm1aVGcxUVpNQTlX?=
 =?utf-8?B?VUxuWFFQcFZXRFVnR0MzeFJvUXVDd01zZ3F6a3VSNHZDQ1VmTUlNaW02Q3E4?=
 =?utf-8?B?bGlFTWwzeXMvSXJ5R0xPUThCZ05TZTR5WU54WlUxaUduaTFZSFkwWmdsbjRN?=
 =?utf-8?B?ZXVYclVieWE0WjBNM0R1bHR2azJsRmpPM3B0MUU4RGo5c2NNTUpDeDdGdkEv?=
 =?utf-8?B?bkFMQzdNTmYvY09vUDZyZ2ZkM0M5bU1vd0lDOFNDT3V3U2txTFdKNVkwM3lk?=
 =?utf-8?B?UzFIYU9NeGNXWWg1VzREcHhHVWFuS1VtNHk4ZVZYZThLSUZKaDRHd3MwNkRJ?=
 =?utf-8?B?U1lnWDdvcjZXVzNDNFZUenR5cjNxcUdOOHZ6d2xQM0hpNitYVVJKc01CWXhM?=
 =?utf-8?B?QXZpeUFxN1hhWnVmYWt4SkY0OUFXVlROaXg5WUZCb2FCaExtenZTNWpNK2I2?=
 =?utf-8?B?T05FS3YzRTN3NGJpd0RNMTBtZjJFUmdjYVNaY3JBN3BxaFZ6MnY1V05EdG9I?=
 =?utf-8?B?TnlMTGRQRnNHeWZoZmxHKzVveU9ubzlKTkdQTzRBcS85YTJ1L0trL0lEUXZt?=
 =?utf-8?B?bnR1QVdQMDU4MEVQNkNjZis5cG9nVjg5ZXprajRyZTNhTi9yQjZJKzhpWUZh?=
 =?utf-8?B?emJ2OHUzZndJbU93MWU4NGJ3KzdZT1EvZ0dBOFFhejZJNzAzTVpDdXF6Q2Jh?=
 =?utf-8?B?SFkzeWUzZVg4NEtKR3oxdUc1VUVRcXQ5MXNjN054ZGlZeGFtRzRsNDdlMVZs?=
 =?utf-8?B?UlJJNzhkSXlSTS9nSGUwb2NyRVJ4MmFMU2k2UW9XZ3pKb2dBYTk1OFluWHdI?=
 =?utf-8?B?RFRMbitBQmNVQ3ozYStYOHpoNXN0QnRKZ3BIQTVvQ3MzdFYxNG96ZFJ2TmV4?=
 =?utf-8?B?MGsyd1YwTysvc2NkeStiMW4yUTRxeVk3RmZ4Q1h3MGhXaHlnblBaSGVUNXhF?=
 =?utf-8?B?bE1CZDBwTFRwZlRQUW5wMGUzMU9wSlR6a1luUjBEMEVIZXVzVU5QdzhWUmFY?=
 =?utf-8?B?TFA3Tm9UUXlYblJuQWJHdVBhUHZDL05YQUwyRXZod1RXZHBlK3FzN0YrZEFV?=
 =?utf-8?B?TzZYMC9qaEJqck1leGFRcGZhTlp3eFNFUUJEVFFUVmxrRklmNGVMbnJqQWlF?=
 =?utf-8?B?NWcyS0xpVWFycUxoMXd4bFIwdnQ2bklZbEZrSFVFS3NqSGxmY0lka2h4dksv?=
 =?utf-8?B?TlhodTV5aWNjeEpJQkUxMjdyd2dEOTlCcm9jNTJLRncyVzVkSUVOdktsRlJM?=
 =?utf-8?B?TFFCSlpvbnVka1lRL0lpZ3NBZ2ZzdENYRUtDZVpxWTMxOTQ2b1BBZHArbllx?=
 =?utf-8?B?RHhnZnpCdkF2WEZGWDJDUUxQV280S210SU94YTZabDZ6RzJ3SkdsT2RPVkIx?=
 =?utf-8?B?QytxTU9IanVoTTJzbTlpVnpnVHRxbmt1OGNPbHZERzhtbFJsQ0FRU2lULyt1?=
 =?utf-8?B?RXZER21LSWt5d2ROalM1cjI0WnpVRTZReUNzb1doZEF1OVJ5bmtIN3BuYVZx?=
 =?utf-8?B?aHYrZmt0bkR2MEdzYUFEcTNjaWlQbjFndzNCbUY5bm5xU2s5aGUzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cXj4THlYHBURwjKcQ9gKiseMxhliz/By2JKK6R7MR3H+Dk4wgkjxPoNepsSaUN/NyGAtzDtcRkLx71uWaijaYdn6R2sH1sgBwxOOdK7AU2UCpMgZv8cASaQGPeku5NjNRibN0Nvif/afS/frWEfaP3wBTKHGII07Uj3Llufqz4OSVeDgTACHbXPnnb4pDJ1mn3y8UC0YOhs+yHKBkOJ8WGoIxO9S9jctpgE+FyP88IvcTOhRbXzaP/rkP5KYKD852V6QOY3yRmJmRbdbRkR7716EoBjLsyUXAjQ9Sa6gVldCueDoFO5Rpuz3EojNDn0bN3356P2fKh5GMJ/3JA0fQg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8db845-358e-46be-7a1a-08de88a165cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 05:59:51.2077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Klsg1aYqLJMJKu1Cn3TxR/YGrgRicUCVSS/I+4y9WbWM2TnZHoAHmvmSZBwq0tK58CBe3tQY8AZgYsHsGDywQg+ddT2dAg1ydxqGzK5e/rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C5964328
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDcvMTNdIGludGVsX2lvbW11
OiBIYW5kbGUgUEFTSUQgZW50cnkgYWRkaXRpb24gZm9yDQo+cGNfaW52X2RzYyByZXF1ZXN0DQo+
DQo+DQo+DQo+T24gMy8xOS8yNiAxNjoyNiwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+
DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlp
LmwubGl1QGludGVsLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA3LzEzXSBpbnRl
bF9pb21tdTogSGFuZGxlIFBBU0lEIGVudHJ5IGFkZGl0aW9uIGZvcg0KPj4+IHBjX2ludl9kc2Mg
cmVxdWVzdA0KPj4+DQo+Pj4gT24gMy82LzI2IDExOjQ0LCBaaGVuemhvbmcgRHVhbiB3cm90ZToN
Cj4+Pj4gU3RydWN0dXJlIFZUREFkZHJlc3NTcGFjZSBpbmNsdWRlcyBzb21lIGVsZW1lbnRzIHN1
aXRhYmxlIGZvciBlbXVsYXRlZA0KPj4+PiBkZXZpY2UgYW5kIHBhc3N0aHJvdWdoIGRldmljZSB3
aXRob3V0IFBBU0lELCBlLmcuLCBhZGRyZXNzIHNwYWNlLA0KPj4+PiBkaWZmZXJlbnQgbWVtb3J5
IHJlZ2lvbnMsIGV0YywgaXQgaXMgYWxzbyBwcm90ZWN0ZWQgYnkgdnRkIGlvbW11IGxvY2ssDQo+
Pj4+IGFsbCB0aGVzZSBhcmUgdXNlbGVzcyBhbmQgYmVjb21lIGEgYnVyZGVuIGZvciBwYXNzdGhy
b3VnaCBkZXZpY2Ugd2l0aA0KPj4+PiBQQVNJRC4NCj4+Pj4NCj4+Pj4gV2hlbiB0aGVyZSBhcmUg
bG90cyBvZiBQQVNJRHMgdXNlZCBpbiBvbmUgZGV2aWNlLCB0aGUgQVMgYW5kIE1ScyBhcmUNCj4+
Pj4gYWxsIHJlZ2lzdGVyZWQgdG8gbWVtb3J5IGNvcmUgYW5kIGltcGFjdCB0aGUgd2hvbGUgc3lz
dGVtIHBlcmZvcm1hbmNlLg0KPj4+Pg0KPj4+PiBTbyBpbnN0ZWFkIG9mIHVzaW5nIFZUREFkZHJl
c3NTcGFjZSB0byBjYWNoZSBwYXNpZCBlbnRyeSBmb3IgZWFjaCBwYXNpZA0KPj4+PiBvZiBhIHBh
c3N0aHJvdWdoIGRldmljZSwgd2UgZGVmaW5lIGEgbGlnaHQgd2VpZ2h0IHN0cnVjdHVyZQ0KPj4+
PiBWVERBQ0NFTFBBU0lEQ2FjaGVFbnRyeSB3aXRoIG9ubHkgbmVjZXNzYXJ5IGVsZW1lbnRzIGZv
ciBlYWNoIHBhc2lkLiBXZQ0KPj4+PiB3aWxsIHVzZSB0aGlzIHN0cnVjdCBhcyBhIHBhcmFtZXRl
ciB0byBjb25kdWN0IGJpbmRpbmcvdW5iaW5kaW5nIHRvDQo+Pj4+IG5lc3RlZCBod3B0IGFuZCB0
byByZWNvcmQgdGhlIGN1cnJlbnQgYmluZGVkIG5lc3RlZCBod3B0LiBJdCdzIGFsc28NCj4+Pj4g
ZGVzaWduZWQgdG8gc3VwcG9ydCBQQVNJRF8wLg0KPj4+DQo+Pj4gUEFTSURfMCBvZiBwYXNzdGhy
b3VnaCBkZXZpY2Ugc3RpbGwgbmVlZCB0byByZWdpc3RlciBNUnMgaW4gY2FzZSBndWVzdA0KPj4+
IGRvZXMgbm90IG9wZXJhdGUgaW4gc2NhbGFibGUgbW9kZS4gU28gZm9yIFBBU0lEXzAsIHlvdSB3
aWxsIGhhdmUgYm90aA0KPj4+IFZUREFQQVNJRENhY2hlRW50cnkgYW5kIFZUREFDQ0VMUEFTSURD
YWNoZUVudHJ5LiBJcyBpdD8NCj4+DQo+PiBFeGFjdGx5IQ0KPg0KPmJldHRlciB0byBub3RlIGl0
IHNvbWV3aGVyZSAoY29tbWl0IG1lc3NhZ2UsIGNvZGUgY29tbWVudCkuIEl0IHdvdWxkIGJlDQo+
YSBnb29kIGhpbnQgZm9yIGZ1dHVyZSBtYWludGVuYW5jZS4gZS5nLiBpdCBpcyBlYXN5IHRvIGZv
cmdldCB0aGlzIGZhY3QuIDopDQoNCldpbGwgZG8uDQoNCj4NCj4+Pg0KPj4+PiBXaGVuIGd1ZXN0
IGNyZWF0ZXMgbmV3IFBBU0lEIGVudHJpZXMsIFFFTVUgd2lsbCBjYXB0dXJlIHRoZSBwY19pbnZf
ZHNjDQo+Pj4+IChwYXNpZCBjYWNoZSBpbnZhbGlkYXRpb24pIHJlcXVlc3QsIHdhbGsgdGhyb3Vn
aCBlYWNoIHBhc2lkIGluIGVhY2gNCj4+Pj4gcGFzc3Rocm91Z2ggZGV2aWNlIGZvciB2YWxpZCBw
YXNpZCBlbnRyaWVzLCBjcmVhdGUgYSBuZXcNCj4+Pj4gVlREQUNDRUxQQVNJRENhY2hlRW50cnkg
aWYgbm90IGV4aXN0aW5nIHlldC4NCj4+Pg0KPj4+IEkgdGhpbmsgdGhpcyBpZGVhIGlzIG9rLCBi
dXQgd2UgbmVlZCB0byBiZSBjbGVhciBhYm91dCB0aGUNCj4+PiBib3VuZGFyeSBiZXR3ZWVuIHRo
ZSB1c2FnZXMgb2YgdGhlIHR3byBwYXNpZCBjYWNoZSBzdHJ1Y3R1cmVzLg0KPj4NCj4+IFllcywg
dGhlIHByaW5jaXBsZSBoZXJlIGlzIFZUREFDQ0VMUEFTSURDYWNoZUVudHJ5IGlzIG9ubHkgdXNl
ZCBpbg0KPmludGVsX2lvbW11X2FjY2VsLmMsIFZURFBBU0lEQ2FjaGVFbnRyeSBpcyBvbmx5IHVz
ZWQgaW4gaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+DQo+anVzdCBtYXJrIGl0IGluIGNvbW1pdCBt
ZXNzYWdlIGFzIHdlbGwuDQoNClN1cmUuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

