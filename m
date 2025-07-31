Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A58C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 03:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhJz7-00032Y-IZ; Wed, 30 Jul 2025 23:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uhJz6-000325-CP
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 23:29:36 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uhJz3-0005Qp-Rg
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 23:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753932574; x=1785468574;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Fil8v5j4/1TX19Xvx+SR0DGY09ROAaDD/M9oEZdn/Kw=;
 b=Yu4+Jlxp4Rqk6CqQy35DQrXKOC6R2aTrwbzSV7mVQkQh0q9l4oFtGwRR
 BGr8cU6LdICF3Ldr9kpXYGjcWahbzTDZ3827sb+N6E9HwRpf73sXi0HIo
 bilS8A8Ukor0Tkb9/cSiLzTlg0cCaGC+jUzNJ8kVpgbvnItrJ+QssUk/c
 1SkKBXW21xraTnP4bc50zeG3/yFrQ5rfSPc464eJGCzD62Q589/I/T4/h
 1/7FNHOYsSStpzMvcZfQTZGnEaBEP/4pAtrdIExjl/6QQrLy0gJ7ri4xp
 fENIxNSJSQ5P6KGIqqSJeoMA+lzodVqLtD5EHjszPaf0XxIQ1P0VXkhQa A==;
X-CSE-ConnectionGUID: fFxW4sR1R2S2M5xzFzAOFA==
X-CSE-MsgGUID: upSXM0gfSZuxInktMK0bZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73703665"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="73703665"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 20:29:30 -0700
X-CSE-ConnectionGUID: P8hnd3LOSkKAzsgQBY9zZQ==
X-CSE-MsgGUID: Emab9U7zTaWg/MC4qIj68A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="162739128"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 20:29:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 20:29:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 20:29:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 20:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NACNmmIOmLj3/AAdb51X4SjYzgCnnr6Rjdhe83mtcgwJPq090byjPOnMYaNWiiBa5EJuNgvw8CCTnr7tF+delwjzOqkblAtByusmY73DOc1vW4oFjfNPsrE5Te2eirmZsyOvBO43ZSCvEZsjNeW6eKcx2YeXKlr7cFWZEtBiHaF9r/XEjlMGjE1xsBynzbbYrRSqSz7dbytI73KqcsW6p4NcjCZfleAH/gAPVLBpI8apUStEUvleJRwtmmZL6b44tzMq/6oCxw8MThKdqZeCDBfIhgMK/9PxfULwUrbC/RVb/yPBGCcTBwMSgOEzUYoqfkGgGPnKprjUquzaYYv9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fil8v5j4/1TX19Xvx+SR0DGY09ROAaDD/M9oEZdn/Kw=;
 b=WaDxxvFiHrWd4Ca0Jl2MJ4tg3TnJJpEf3sOBrschfRw7IQ2ITDm0y9hvE1hcTdFkBA0IqnbBjMQoC0u+Ee9YPG+NChFFm47zOMl4nxW7PW6d20Xepmazmwz67T4eWZfDe4thnqNP/+E7jkFrfvZrtDo+wO125/ARS7eBgD4N4Y2vnfw4S6d8COIAW4Cq3/xvulwF9mAkFLxcIrsZGuFg9SY3kSliFS/z2fBr3VfVQHQC5fhBOpLr7HlfhzIYdpS0B4E+p5nDU0jzzDNURJpz8vXmpZHbOudh0ifG8d5nJIGcnp2fNAtEsGRkKbUJVYITJJZ0nYZDlvjt8sxp4DmRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by SJ0PR11MB5790.namprd11.prod.outlook.com
 (2603:10b6:a03:422::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Thu, 31 Jul
 2025 03:29:08 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::e495:c424:3fc7:e18]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::e495:c424:3fc7:e18%6]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 03:29:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 04/20] vfio/iommufd: Force creating nested parent domain
Thread-Topic: [PATCH v4 04/20] vfio/iommufd: Force creating nested parent
 domain
Thread-Index: AQHcAGoofFm7MkRMFk+/2nrYogGqmLRJHN6AgAFiUjCAADR8gIAA4cOA
Date: Thu, 31 Jul 2025 03:29:08 +0000
Message-ID: <DS4PPF93A1BBECDD8CFE9795632F3956B399227A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-5-zhenzhong.duan@intel.com>
 <74895627-74a8-4cb4-a460-491ac5dd1c2b@redhat.com>
 <IA3PR11MB91365795415087EF9550FB209224A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <8c395b8f-4c6d-4c64-bf02-feb1e2e5e369@redhat.com>
In-Reply-To: <8c395b8f-4c6d-4c64-bf02-feb1e2e5e369@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|SJ0PR11MB5790:EE_
x-ms-office365-filtering-correlation-id: ea8c6713-d36e-449e-4108-08ddcfe268e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?K2ZOSUY3UXgxS3ZzNTVabGZYTDVmejVWUWlsNU9RTW4yQ1ZWVERCc25FQVZk?=
 =?utf-8?B?ZTJVWmZDOHhiNHIzYlpzUGlDREl0SU5lUnhlUS82a1ZvSTNPYmNqK2pjNkdM?=
 =?utf-8?B?ak5uUU45aWJhT0RiVmh0VExJZFVvNEJLa2RZRy90R29WczVDNXp3T3ZMbEN2?=
 =?utf-8?B?V3pTazBqMTFLbmtldDZEc2RCSjM3d0RjMlNpQkFZZHhLK09FTjJMQTdKUldV?=
 =?utf-8?B?RWpzRGpxd0k5Q21wTytleG5wNzhKSzM0ZnhrMlpFdEVTRjNaYitWWkxMWFdl?=
 =?utf-8?B?TnA5aWt1bnM5eis1SUdmSUJuUlJpU1lDazBsbU9yYkFEbm95N2hUV205Umg1?=
 =?utf-8?B?UERVUGVOQzI5R1F0dUVzVTZMYUhrY2lBZFd4RW9WdVY0eGN0WlpaRVhGZ3RS?=
 =?utf-8?B?UjVtQS96QlNmUHNEU1piaFl6VnFHRkI0bnFGS0dFMHErR0txeUVOUFhiNHo1?=
 =?utf-8?B?SW5KUnRDRksybDhNcEVkTnF5anhTSWlqV3E3S1Jzc1pkOWFpcEtOdm1ySFdQ?=
 =?utf-8?B?eEhPaVVHQVo3d3E0RHA4Z0F2MTQ1ZmRCcmk0YjlDZ1hGTG5GWlBHRnhxNGda?=
 =?utf-8?B?OVArMjk4KzIrUDRueUhhVlFCS3VmL2xRTlN0aHBEelBtR01CY2piQjVuTUcw?=
 =?utf-8?B?TnBWV2FZenEzMmhjQmhNUFVtcFNTVWFZVnlzOXlhcS9TeWQ4anlzUkY2VHFh?=
 =?utf-8?B?bGkxU3AvVkd4bEJoajM0cUtVQ05maThqZkNkNmFucFJjRXJiUGRhc2pSNVA5?=
 =?utf-8?B?OHJCcjRtR0l0Vk9GSHovdW9QREkwT2NHNGxPbWNMWjZOeUo3cGhyaTExdVNQ?=
 =?utf-8?B?eFg5S0ZmSUsyT0dUejZqVElTQnNqZ0UvV3lTTDA5UFUvNFNrMXRaSzJyUXli?=
 =?utf-8?B?blpPek04Z2Y3YVhBV1Q2ZzZ2RXliM09jZSt4Rm9aNGhFRTY1YWVUa2RmSGto?=
 =?utf-8?B?eCt0QVN0TXF4NVQ0b2xiYnRHYW5DZG1acDQ0MUJnbGwrUUs5WUpEUDJKSkow?=
 =?utf-8?B?NUs2aEExM0g0SXJ0Yzc2ODhha1hWTnp3cGs5N1dOSkJkZEJqMjFLZlQwbEVy?=
 =?utf-8?B?bEV5eGFiaytZS2pGdkRmTlJzKytTZlZxRXBoRUgxVGRReTJZTGtmVGpsZ3lp?=
 =?utf-8?B?bDR6eWpSMWpQTGtTWUhrZVNpSkF5UUNnZVV0VlBqc3pGR2FBdEQ0bHVPOFh4?=
 =?utf-8?B?cWdCOTgzdW9YQUpNRzFYZnB2QVlsSkdWc0FzNk5NZGh1L1FQQVZ0QStyUm5F?=
 =?utf-8?B?U1NHUnk1T0kzVVRERmtXd1hQUHc5NTU4dU1kemFHOVJSTmF3RjJoYkRTRnNz?=
 =?utf-8?B?ejJ5eUx0L0NnL1ZETjB1b0QwQ0pDazdSd3lOdjMzS2g2cGJXWGRZdWg2WENX?=
 =?utf-8?B?VER0QXBuc21aOHRmTzBjd2tvdFRpUks5R08ra1IzZCtMdGJrRWlMSmV4eHlx?=
 =?utf-8?B?dVZRRExabnFCQkdXeTdsdkhoMTBUaGNaWTZhUjJrZW5kOStJZ2xKc1E2UlN1?=
 =?utf-8?B?ZVAxWUIxT09ETlloMThROEN1Rzl3MUNXckhwY0xLREVCMDAwb0NHNFdYcG1S?=
 =?utf-8?B?dVRMNC9RMFJibVpUSmR3Q1hENlM0c0xzRDJXUmFjaTRoSjI4TTVIa1BoQmRF?=
 =?utf-8?B?VzRQZlpVaUMrWG5WQUxsb3ZtbDVSUTZHcHQxeXVVR1ZicXhBcFhtanMrVGh0?=
 =?utf-8?B?WWE1amlZdjNodEtsallzQ2tCK1BnZ3RwUzN4UGJML1ZJSmo1dUYwV1N6QmlI?=
 =?utf-8?B?aVVJelZxSitmTnZDSWlWWENTYkF6RVVTTnFyYk1POE9NR3REQS80M0creEw1?=
 =?utf-8?B?cXp0VmZEV05lam9xTzJZR3B2R0ZMcjJXdjdUZFdwU0pRTXkrbEEzekIrc1BO?=
 =?utf-8?B?ZGdkcjJwZ2R1c2p5RUF4QVBGZUZHWUd0QlRsaUtZWkNjNHRic3ZSSGFiNlZK?=
 =?utf-8?B?RTIybnJTci9IOE1sdXlPMHJxeWpQT1ZBYk9TRU55UlNBaytHaEZ2LzU2UTFl?=
 =?utf-8?Q?geI9FyA85BFES21HLRje1x8DwN4fcQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZSTm1DYjBpY2JQZjc5cHpMby9YL0xhZXZmQjk0L3N2VEliNDN0NTV3MitL?=
 =?utf-8?B?eU1PVm9QRWs4RHNyeGp1YTdXc1B3WEhnSmdlUXoyQUFVL2Q0bmpSek5hNEVT?=
 =?utf-8?B?eHJ2NXM1TmdYeGNwLzE5U1RoODlrZk1jWVVTV1dQbXd0cEhRMTgvWXRMaXNx?=
 =?utf-8?B?VS9OdkM5cXN5Y1pROVdhTHdVV3Y4Y1I2SGtqNC90U2pMOTNyUmIwMlVQZnN3?=
 =?utf-8?B?NkEwQkt1a0U2S25Kdm5zQkducXZYR3NsRjhWWWFiamo3L0JNN3NsTVNvQlB3?=
 =?utf-8?B?KzYzVFdkemFEN01mNnBjZkVhYmd5RnNsaGR1QVE1VWxFcTlKTFdySlVndEtS?=
 =?utf-8?B?c2crUGEwZ09mN2FVWjdpZG1UZUU0SlIxU2xrT28vektpaGNmWGx2cThITEh6?=
 =?utf-8?B?bkczTStURVpnWURFUkpVMUF3QWp0S1hPdjBVU0hPVGFPUVQ4WUZnRWUwMVh5?=
 =?utf-8?B?M2pXdG9lQkY4NmE0ekVFWkZZd3dtS0QvSUlzVWhYSU96M1A3Wm5HeFFnaW40?=
 =?utf-8?B?aDNMUGg5MXR5NzBZQlpGMTJpVVFOYkpvNDJVZ2ErNkdvMW9xaktrb1ZvYkxN?=
 =?utf-8?B?M3QyN1VDZXBHcnpENmtIVmJqK0FtUFVYcUhldm1jV1d1SnREa1hzUE55TjBJ?=
 =?utf-8?B?SVJjODNZaEhZWkhUT3FLb0d2a2twcElYMjlpWmlWRU9ReVV0ak8raStqY25q?=
 =?utf-8?B?THdyZEFTalF6YWQxQmR2MUYxaC83eFZ5MFJyS0NHcDc1bWJhc2xVeUFKTXcy?=
 =?utf-8?B?WlU1N01RNWxzZ1IwOFhSVitUYnVrSmtQVW5UQkZJeCtSNmJlN29MWEFIcUZl?=
 =?utf-8?B?em9jOTBpMXVTTG5taWhLTGVPcStpU2VsT1JyK04ra2pZcHI4Z21XcDNlR0wy?=
 =?utf-8?B?Q1BmMFNxZ2t6RU1xbXMrSnFRczNGMkQ4a1h1K1FnV0JPY2RhelFBUWdVUU1V?=
 =?utf-8?B?Q0RMQzdLYmF3VmNUTWdJMjdXbTFEb3RISGFRU3A4cWQrUGhMVHcweXZ6U3dM?=
 =?utf-8?B?VFFTOVFPRkt6Yk13U1dsaVhUZlZiby90emhzM1htL3U4MGNGWlVaa1FwM3Vk?=
 =?utf-8?B?NEpBQ0k5NkkwUXZ3bHhwTHFuN2ZyZWxwZ3hSNVQ3a2orY2NWc2pCbGMwd08z?=
 =?utf-8?B?dUNMV2gxci9IbGRoZVdkVmxMRUx4ejZjRkhxWHNPa3p0elQ0ZlRCTSs4SkhF?=
 =?utf-8?B?V3JtK0FWQjFUSm1xOUp5WnkyZndIaVNQUG53ZmczdTl3azlYbFVNTFBHY0s2?=
 =?utf-8?B?TXRLUmlnWE1Eb1FGMU1YVFJWNmY0MmcwMXVJcGtLaFRhV01xOGh5dTNqeFRC?=
 =?utf-8?B?SDdSSWtpdGNPSlQydTkrNDFhYVE4WHFJcittZldjdzlGY0ROcEFheGRmaTZq?=
 =?utf-8?B?MnhDREpKSHBSVXYxR2ZUT0ZmU0lObnFqQWIrRTZkR1ExSXZsb2dYblJFZWUx?=
 =?utf-8?B?cWJoNGJKV1RnRGlXTHVXYnB2eENQNUEzeTRtNDNYN1pSWTBZTUlhSDVPdWRp?=
 =?utf-8?B?RHFjZWRxQTFYMFNKVTZYMHE5NmhYZUFGdVNHMjRkQzVYUm5VN0tuYVlnay9l?=
 =?utf-8?B?QzdBNXRqcjdCMENoUi9HYkNjR01vYUJwMDZtMTRnTGVjaDQwREVyVDFaWGt6?=
 =?utf-8?B?S1l1aWF5T2wwMjF3SHVhN1VuUTREWk1RT3R4ejJFcFpZazN5RDdRLys3bUJv?=
 =?utf-8?B?TnVWU0JabWtnWjdEU2p1eEo3SmFOSTBFa1oxNkxoVkNZR3d2Tmo1SVBSdHVD?=
 =?utf-8?B?VjQzTFBKcXRpU3QyQTBaWDhxeENkREcxYU4xMDlQMlJaNjBBdittUW5iQTlG?=
 =?utf-8?B?SFVwYTRBRVpNZU1zUm9neW9QV2FzaG0xK0Q1K0V0S1Arc2lMdG1HTExOK1d5?=
 =?utf-8?B?c0tQdWRVUWxScW9SZ2ZDQ0ZaSUxtNzY1ajNIN0ZjaVdxVDl1S2xmWkVoS2dT?=
 =?utf-8?B?WlkwdWJacnU0eFl6V0U4K0NnSi9WWkxLSXpPamVNZHZTM1d6N3BRVk1BVGtl?=
 =?utf-8?B?RFpLR3JsaDBtUlRBWkpheDljeEkvOTBkeGJrOE9LQ3QrWE51TUsvLzdCbWVa?=
 =?utf-8?B?WUNRRHZpK1NiQ2VGQThuR3cyMmxCUFNkekRpekRkUVBjaGVvRmVPN1RBTm5X?=
 =?utf-8?Q?BvRCwvzO6kwRVFT3cEBa3V7gR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8c6713-d36e-449e-4108-08ddcfe268e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 03:29:08.5461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrNCB3BuydhR0ZvdCf63nv+QPj2L+TnuFZp4JyVwQI+Kz461N8zhHfpUx4U5dEvNmFRXC310pnkW3Y0VB94u8E3jahQGM/za1F62eRQ6rXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5790
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDA0LzIwXSB2ZmlvL2lv
bW11ZmQ6IEZvcmNlIGNyZWF0aW5nIG5lc3RlZCBwYXJlbnQNCj5kb21haW4NCj4NCj5PbiA3LzMw
LzI1IDEyOjU1LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0
LmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA0LzIwXSB2ZmlvL2lvbW11ZmQ6IEZv
cmNlIGNyZWF0aW5nIG5lc3RlZCBwYXJlbnQNCj4+PiBkb21haW4NCj4+Pg0KPj4+IE9uIDcvMjkv
MjUgMTE6MjAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+PiBDYWxsIHBjaV9kZXZpY2VfZ2V0
X3Zpb21tdV9jYXAoKSB0byBnZXQgaWYgdklPTU1VIHN1cHBvcnRzDQo+Pj4gVklPTU1VX0NBUF9I
V19ORVNURUQsDQo+Pj4+IGlmIHllcywgY3JlYXRlIG5lc3RlZCBwYXJlbnQgZG9tYWluIHdoaWNo
IGNvdWxkIGJlIHJldXNlZCBieSB2SU9NTVUgdG8NCj4+PiBjcmVhdGUNCj4+Pj4gbmVzdGVkIGRv
bWFpbi4NCj4+Pj4NCj4+Pj4gSXQgaXMgc2FmZSBiZWNhdXNlIGh3X2NhcHMgJiBWSU9NTVVfQ0FQ
X0hXX05FU1RFRCBjYW5ub3QgYmUgc2V0DQo+eWV0DQo+Pj4gYmVjYXVzZQ0KPj4+PiBzLT5mbHRz
IGlzIGZvcmJpZGRlbiB1bnRpbCB3ZSBzdXBwb3J0IHBhc3N0aHJvdWdoIGRldmljZSB3aXRoIHgt
Zmx0cz1vbi4NCj4+Pj4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5j
QG52aWRpYS5jb20+DQo+Pj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+Pj4+IFJldmlld2VkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhh
dC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBody92ZmlvL2lvbW11ZmQuYyB8IDE0ICsrKysrKysr
KysrKysrDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+
Pj4+IGluZGV4IDQ4YzU5MGI2YTkuLjYxYTU0OGYxM2YgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L3Zm
aW8vaW9tbXVmZC5jDQo+Pj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+IEBAIC0yMCw2
ICsyMCw3IEBADQo+Pj4+ICAgICNpbmNsdWRlICJ0cmFjZS5oIg0KPj4+PiAgICAjaW5jbHVkZSAi
cWFwaS9lcnJvci5oIg0KPj4+PiAgICAjaW5jbHVkZSAic3lzdGVtL2lvbW11ZmQuaCINCj4+Pj4g
KyNpbmNsdWRlICJody9pb21tdS5oIg0KPj4+PiAgICAjaW5jbHVkZSAiaHcvcWRldi1jb3JlLmgi
DQo+Pj4+ICAgICNpbmNsdWRlICJody92ZmlvL3ZmaW8tY3ByLmgiDQo+Pj4+ICAgICNpbmNsdWRl
ICJzeXN0ZW0vcmVzZXQuaCINCj4+Pj4gQEAgLTM3OSw2ICszODAsMTkgQEAgc3RhdGljIGJvb2wN
Cj4+PiBpb21tdWZkX2NkZXZfYXV0b2RvbWFpbnNfZ2V0KFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0K
Pj4+PiAgICAgICAgICAgIGZsYWdzID0gSU9NTVVfSFdQVF9BTExPQ19ESVJUWV9UUkFDS0lORzsN
Cj4+Pj4gICAgICAgIH0NCj4+Pj4NCj4+Pj4gKyAgICAvKg0KPj4+PiArICAgICAqIElmIHZJT01N
VSBzdXBwb3J0cyBzdGFnZS0xIHRyYW5zbGF0aW9uLCBmb3JjZSB0byBjcmVhdGUgbmVzdGVkDQo+
Pj4gcGFyZW50DQo+Pj4+ICsgICAgICogZG9tYWluIHdoaWNoIGNvdWxkIGJlIHJldXNlZCBieSB2
SU9NTVUgdG8gY3JlYXRlIG5lc3RlZA0KPj4+IGRvbWFpbi4NCj4+Pj4gKyAgICAgKi8NCj4+Pj4g
KyAgICBpZiAodmJhc2VkZXYtPnR5cGUgPT0gVkZJT19ERVZJQ0VfVFlQRV9QQ0kpIHsNCj4+Pj4g
KyAgICAgICAgVkZJT1BDSURldmljZSAqdmRldiA9IGNvbnRhaW5lcl9vZih2YmFzZWRldiwNCj5W
RklPUENJRGV2aWNlLA0KPj4+IHZiYXNlZGV2KTsNCj4+Pj4gKw0KPj4+PiArICAgICAgICBod19j
YXBzID0gcGNpX2RldmljZV9nZXRfdmlvbW11X2NhcCgmdmRldi0+cGRldik7DQo+Pj4+ICsgICAg
ICAgIGlmIChod19jYXBzICYgVklPTU1VX0NBUF9IV19ORVNURUQpIHsNCj4+Pj4gKyAgICAgICAg
ICAgIGZsYWdzIHw9IElPTU1VX0hXUFRfQUxMT0NfTkVTVF9QQVJFTlQ7DQo+Pj4+ICsgICAgICAg
IH0NCj4+Pj4gKyAgICB9DQo+Pj4+DQo+Pj4NCj4+PiBDb3VsZCB5b3UgcGxlYXNlIGFkZCBhIHdy
YXBwZXIgZm9yIHRoZSBhYm92ZSA/IFNvbWV0aGluZyBsaWtlIDoNCj4+Pg0KPj4+IHN0YXRpYyBi
b29sIHZmaW9fZGV2aWNlX3Zpb21tdV9nZXRfbmVzdGVkKFZGSU9EZXZpY2UgKnZiYXNlZGV2KQ0K
Pj4+IHsNCj4+PiAgICAgIGlmICh2YmFzZWRldi0+dHlwZSA9PSBWRklPX0RFVklDRV9UWVBFX1BD
SSkgew0KPj4+ICAgICAgICAgIFZGSU9QQ0lEZXZpY2UgKnZkZXYgPSBjb250YWluZXJfb2YodmJh
c2VkZXYsDQo+VkZJT1BDSURldmljZSwNCj4+PiB2YmFzZWRldik7DQo+Pj4NCj4+PiAJcmV0dXJu
ICEhKHBjaV9kZXZpY2VfZ2V0X3Zpb21tdV9jYXAoJnZkZXYtPnBkZXYpICYNCj4+PiBWSU9NTVVf
Q0FQX0hXX05FU1RFRCk7DQo+Pj4gICAgICB9DQo+Pj4gICAgICByZXR1cm4gZmFsc2U7DQo+Pj4g
fQ0KPj4+DQo+Pj4gTWF5IGJlIHRoaXMgcm91dGluZSBiZWxvbmdzIHRvIGh3L3ZmaW8vZGV2aWNl
LmMuDQo+Pg0KPj4gRG9uZSwgc2VlDQo+aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11
L2NvbW1pdC83Y2UxYWY5MGQ1YzFmNDE4ZjIzYzllMzk3YTE2DQo+YTM5MTRiMzBmMDlmDQo+Pg0K
Pj4gSSBhbHNvIGludHJvZHVjZWQgYW5vdGhlciB3cmFwcGVyIHZmaW9fZGV2aWNlX3RvX3ZmaW9f
cGNpKCksIGxldCBtZSBrbm93IGlmDQo+eW91IHRoaW5rIGl0J3MgdW5uZWNlc3NhcnksIEknbGwg
Zm9sZCBpdC4NCj4NCj5JdCdzIGdvb2QgdG8gaGF2ZSBpdCBpZiB5b3UgdXNlIGl0IGV2ZXJ5d2hl
cmU6DQo+DQo+aHcvdmZpby9kZXZpY2UuYzogICAgaWYgKHZiYXNlZGV2LT50eXBlICE9IFZGSU9f
REVWSUNFX1RZUEVfUENJKSB7DQo+aHcvdmZpby9jb250YWluZXIuYzogICAgICAgICAgICAgICAg
dmJhc2VkZXZfaXRlci0+dHlwZSAhPQ0KPlZGSU9fREVWSUNFX1RZUEVfUENJKSB7DQo+aHcvdmZp
by9jb250YWluZXIuYzogICAgICAgICAgICAgICAgdmJhc2VkZXZfaXRlci0+dHlwZSAhPQ0KPlZG
SU9fREVWSUNFX1RZUEVfUENJKSB7DQo+aHcvdmZpby9saXN0ZW5lci5jOiAgICBpZiAodmJhc2Vk
ZXYgJiYgdmJhc2VkZXYtPnR5cGUgPT0NCj5WRklPX0RFVklDRV9UWVBFX1BDSSkgew0KPmh3L3Zm
aW8vbGlzdGVuZXIuYzogICAgICAgIGlmICh2YmFzZWRldi0+dHlwZSAhPSBWRklPX0RFVklDRV9U
WVBFX1BDSSkgew0KPmh3L3ZmaW8vaW9tbXVmZC5jOiAgICBpZiAodmJhc2VkZXYtPnR5cGUgPT0g
VkZJT19ERVZJQ0VfVFlQRV9QQ0kpIHsNCj5ody92ZmlvL2lvbW11ZmQuYzogICAgICAgIHZiYXNl
ZGV2X3RtcC0+dHlwZSAhPQ0KPlZGSU9fREVWSUNFX1RZUEVfUENJKSB7DQo+DQo+U28sIEkgd291
bGQgYWRkcmVzcyB0aGlzIGNsZWFudXAgc2VwYXJhdGVseS4NCg0KT0ssIHdpbGwgc2VuZCBhIHNl
cGFyYXRlIG9uZS4NCg0KPg0KPkZZSSwgV2UgYWxzbyBoYXZlIHRoaXMgaGVscGVyIDoNCj4NCj5W
RklPRGV2aWNlICp2ZmlvX2dldF92ZmlvX2RldmljZShPYmplY3QgKm9iaikNCj57DQo+ICAgICBp
ZiAob2JqZWN0X2R5bmFtaWNfY2FzdChvYmosIFRZUEVfVkZJT19QQ0kpKSB7DQo+ICAgICAgICAg
cmV0dXJuICZWRklPX1BDSV9CQVNFKG9iaiktPnZiYXNlZGV2Ow0KPiAgICAgfSBlbHNlIHsNCj4g
ICAgICAgICByZXR1cm4gTlVMTDsNCj4gICAgIH0NCj59DQoNCkknbGwgcHV0IG5ldyBoZWxwZXIg
cmlnaHQgdW5kZXIgaXQuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

