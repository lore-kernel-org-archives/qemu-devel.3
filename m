Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D8BCA0FE8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usvGQ-0005IJ-UQ; Sun, 31 Aug 2025 23:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usvGI-0005GP-G6
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 23:31:19 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usvGF-0003l4-IK
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 23:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756697476; x=1788233476;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lfvCo/RIUJlxVrfGyLHiurSFMd/x+KvNrYXU5FDD+Uk=;
 b=cwIKA2qbMuAYPIdQBn8Z+lqTvDjYCZh1bQTvXtl7iV7UKr/S+QICXVbV
 /+h+YyQs6fe9O4cDdA1Dyzz5+5duXQQx77Hv0FmjcPGNoiB1GIMvMD/yN
 9AGKGGmpN+1rybZOk4kyGVRO/0tDfqVGqVEYdgDI/BTeoLYE7pkJn4KzJ
 uo7Zlr7AFJW5gRjp2SzS6sUpjdEBk17Dt4hrYUGjLki+9CETO7RILsglF
 taW4gD3ii3hWfBwgrc/Bdz1GPmh27YtahrzTsDGsBv3KrnZCyehuFr8Io
 3HAd3b8x+FW5ee8TrelUYITI1ljTNe0DWhDn2jV01JiKOAhSZycXWnyL7 g==;
X-CSE-ConnectionGUID: PZoLRCL9QMq70NPXDw/gQw==
X-CSE-MsgGUID: Dpr5ZSG4SWqOkTWG1p6g4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81478606"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="81478606"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 20:31:11 -0700
X-CSE-ConnectionGUID: DTDNtrScSDi+cB8BombcLA==
X-CSE-MsgGUID: yjpVnjdAQPaeh2Te8JjE2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="171028420"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 20:31:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 20:31:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 31 Aug 2025 20:31:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.69)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 20:31:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHGvp+hrdfqoRMZE12pUoigkkJrye0aCmHhDse8mi42EC/ZkO1iNZwG1dlDxWI4Z+sUYoKbI0wzeBcdJqoXrpeL4zWiU8obqGQg1SqYKv0q7kk7t6W/G0lWZ3XKFGO2ALS0vYqcZg61ZFEgV8RScpWsN9WTPOza9D0wupjQAHxr1pVkEvRoEqKECmE4BelnxTCx1A/6pqlFDJWqSImzy+xe7f6krteg4jQs28S5tC5tz9DpO23BDSyGD/CIKEmtFu5hrxRxc7BMGbnzijH35ol9E+yk3KaYu+zxf5ruDhNLzLnawKMWwDHv+bHXtUUVvwhzv3ACjOk8X6J9WFjhKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfvCo/RIUJlxVrfGyLHiurSFMd/x+KvNrYXU5FDD+Uk=;
 b=dTOE1K1MjzWttXqBg5LaY5MBJSelNkWGlJ9ZgiZITXLp3WNZ8Pfs7dqe0q52t+ny5gbloNRYq0IKSwV+R4htp1tL1g0uTyU73rFdtlzK1TGgBn95Dur+cfm88LJug3/NAzehPJxKEW8saC7Ad4G577eoKbQ/pC9C+hKBak6WKLy6OsQjVm2hFI78+U//C1t2aToKPKqCzWYIpPQhw6vsvLnSrjo9CAvE4ToOmqk4A6yLo0phG0OmXWRhiOQiObytfdP5lpPOf4Hb53hI2vlxY+zY3uT68zYJ3v/OJS1bmYBXBJ74HDikVa+h0oqzdaXqV5CEU1BuHFXawXMAlS9mkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA4PR11MB8992.namprd11.prod.outlook.com (2603:10b6:208:56e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:31:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 03:31:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v5 11/21] intel_iommu: Handle PASID entry removal and
 update
Thread-Topic: [PATCH v5 11/21] intel_iommu: Handle PASID entry removal and
 update
Thread-Index: AQHcEy/oRsc7Lu/sH0aYzDboCey+yrR4Aa6AgAW195A=
Date: Mon, 1 Sep 2025 03:31:05 +0000
Message-ID: <IA3PR11MB9136FC723C303B92F4957C179207A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-12-zhenzhong.duan@intel.com>
 <5ccc7892-2024-409b-b107-4ffa02e31b71@intel.com>
In-Reply-To: <5ccc7892-2024-409b-b107-4ffa02e31b71@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA4PR11MB8992:EE_
x-ms-office365-filtering-correlation-id: 8932a010-38ff-4a2d-f7b0-08dde907fbfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?L3diV3dWYkgvb012VFp6TFlCZjJ2dTUzUnBpa0VaT0V6T2t4MndXaTF0QnU2?=
 =?utf-8?B?Z215RHZWeEFrcU50K1JmMzhOVU9hcnJaVU1UOEpXdkMvcGhaYjJYekRTc1FO?=
 =?utf-8?B?QjRnK3VtSVQwTlRETm0yQ1JXc3QxanUwbkpQT0doZGJvNjA1UU0rTUNUc2Jk?=
 =?utf-8?B?ckc4YnJiV3d1RkVSNUJ3ZUZaekwzVnE1MUJZSE54NVhneml2QkZMWFQvdW9E?=
 =?utf-8?B?MUo1ekRQL2plLzJWT0k0MVRyMnRWZHltb0dhWjh0dVBnSEIzSk0vU0NlSFdX?=
 =?utf-8?B?cVMzNFQzeFVuRDFSZ2pQQzBDVkhPSW4yd3NybU5ld2thRTRyd0djWDlhdWpO?=
 =?utf-8?B?Q0RqVW5Tc2NCUnBTZENsMUxNWUp4VGpoeUVqUnVaeEpQTTNzTDNqSlNiY201?=
 =?utf-8?B?M3NxMDdUNmdUR2E1eVNhby8wYWhqQ2Fra0V5a3JhbE9MM29vYldaZEVTdHNj?=
 =?utf-8?B?Ti85WTdOMjNremtsRjRsUDhsOThmb0RBekJQNFNRMmZMbjZFV0JuSDBNM1A5?=
 =?utf-8?B?SXN5MXZoTURnWWs5SzFnQ2wyNHFYMWVjSFFpeXZNNzZWUm54ZTJSZEwybndp?=
 =?utf-8?B?UWphSTB6WGF5ck5iT21TMXFMNjd5bDkrV3dVdWs0UytJTHFBM0xzYVJUUmUy?=
 =?utf-8?B?cjhwWTBsSHdWaXpoSEgydlM1QzZ4bHU5YWRFL0c5Wlh0Qm10K2RhYm43Y25T?=
 =?utf-8?B?NG9QTklHQzIwbW04NzFUUk5NSldXWGtrWjQ0WGp4b1Mza0RmN1VjdWxxREV4?=
 =?utf-8?B?TDFhOEErelpUYWJoRFRzaXFFK2c2V2IrTmxVbFhDKzFjTXZXNENGaUkwckgy?=
 =?utf-8?B?OWk4Mk5UZlJpTDhIZVdEMzYwbDMzZ1VxN2kwOTVxM3BZY250UVhGN29TTi9k?=
 =?utf-8?B?Y0VFb2tubnJqdDh5eVJPSmlCenMxREp0QkUreFZmRjdibDhveEtWL21jU0R2?=
 =?utf-8?B?ZENQeFFRbThTQlV1dHpWSDY1UmZIWEVhWC9hUUFWNmI5WFJRdStaK0ZKakdR?=
 =?utf-8?B?Vm1SSXkxWDlmTFRJQWpNWGtaUHBOTGpZU0pKNHpzYUFsS0RSa00wcnFOV0pI?=
 =?utf-8?B?dzE0UEF3emhXQmZzam5RejcvUm1oTEhhWTBTSlU2NTRtd3I1dmhncDZSaldu?=
 =?utf-8?B?Zldac1VpbVJIVVVhbE1tclVYcmg3S1NMUUl3V1dnaWsrNjJOdC9aTXFpc2Ex?=
 =?utf-8?B?d1NLSXRwRTJvUDdqNUpCSUNLTmkrVDN4ZDNRRVlWUy9DR0JPbk93UzBxQm5J?=
 =?utf-8?B?ZEw0VkZUdE45U2FCTGJna0I3Sy82REpWYzJTL3ZCNkRVNUxBbzR1TlZuNUpF?=
 =?utf-8?B?U013K3RNUW9YSnZxY2NBZ1NMTjdKbUJKSlBVR3RWMXJhcmhFWHRCVlpZeFd5?=
 =?utf-8?B?eHVIWmd4bXdGa2FqdDZGR0FBajZCdHUreFZmb2RLZTBTcVFGYzNpR1o2bS9Y?=
 =?utf-8?B?dVhNSnBBTjVmckRUbVphdEs4K3lSdi83N0xGOXB3aGhiVGRTNll2dGxSL0Nv?=
 =?utf-8?B?T0NiMTFMZk1pSGlUNnJFbks1dDZmNGxEcm42MUcybkJnWDVDd05qV1RUbG96?=
 =?utf-8?B?MWxqOXh1QmZxSjk4UVNRdnRVWUFzcDV2eEd3Qk94VE1RU1c0MndJa05KaHpq?=
 =?utf-8?B?aUxXMnFhcGpsRE5aSjVCa2Z6M3pTR2l1eWNrNitVeDcvWHJ1c2d2UWVoQ0ph?=
 =?utf-8?B?aTRmT2pyRWlyamFsY2NnVkErZW1TK1FJNDBiQ0VJcGRmS0FTc3RUbERjZytm?=
 =?utf-8?B?aTJBNG5JOUZ5NzlVaDlOUjNnTDdyd0pkNmllSzU5MytEWUFMcUFNOTcraU4y?=
 =?utf-8?B?MFBCdE8vQWc4VnNhdndlL0xMVDkwSEFWdTRjdkt4SzBoTE1MaWluVHNVWE5C?=
 =?utf-8?B?WEtGaXpCS2tURmVCN3VWM3hnQnExSkJSRENPQnpsR0VSRG1ocWVzdmZzMmI2?=
 =?utf-8?B?V01ESnJuQ1BPbEhYWkR5NzQwT3FldEtIdEpMTjJvK1RqVmZtNk1Vek1YSkl5?=
 =?utf-8?Q?L1nBCftRhHrDVZgx66Lq/5YyDlsOl8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTJOT2prZXFMYzUzQzB4MzkxS09nTVg3OXpkanVsMWFWVFgzcndQcXFzTStx?=
 =?utf-8?B?c09reHVtbGMzbjExMEo3MXljbTFyYjZybzRhSGtBTDIzWW5Rc21zSlVSWHJk?=
 =?utf-8?B?SUd0NE9tVHllUXVvN1VHNjFISkJUL3NRWGI5Z1VsS2R5RUNMNnFqdmV5N09m?=
 =?utf-8?B?aHRFeTBPR2lTOUN6VGJ6YlZVcmMwUWZMUWJVVGFVVUNicXJXeXMxM0JKSkRY?=
 =?utf-8?B?UDQ0S3NpcHJmKzJnK0RRazNZY3VHOFp0SmFVaEkzNHd2MVJ5a3pDc045emhW?=
 =?utf-8?B?R242NjFxNHQrVHNsSnBZdXJ0VkFYSDdjY29qRGNNcjd3SEp2STdWdzRIbU0x?=
 =?utf-8?B?OHdMTXNFSEkwWU1PYVdQQnNGTVllZ2ZjcEhSTjFsNW52N0lpRDd4N0ZVZ2RW?=
 =?utf-8?B?MDI1aDZvY0pkR3ZCTlQ2cXhPOHBTdmZsMXdsVkNjM3luVkJiMldlcCt5Y2ZS?=
 =?utf-8?B?ZEZ6OU02UWhrcnlwclFTTU5pV3VDUmwzN2hCYTBYQWM1M0hSUWMvQ2lucE94?=
 =?utf-8?B?MTNxL3l4ODVWenVQeEl4T2NLbVBXVFVQNmJTSVNqcVJ5ZWIvQmZCTGo4KzNU?=
 =?utf-8?B?MUp2WE5MWm45ZXh2QXMxSzVXTkRPbG5PcW1OU0lMQXZFcG9RSmcwbGJZK25W?=
 =?utf-8?B?SDNDUlV3NHdQNW5EQWlRTmYxWjZraCtEYk9GVXdDWklSeVVjZ3duRnVVNUE1?=
 =?utf-8?B?MXVabXoxRlk1bEhPRld5SGZ3WXJlcXUzUFR6TFdud21PZjBtM0U5b1FqNlUr?=
 =?utf-8?B?YkxRaTcvQ2lPNUR0NndjT3hQak5NbGkyT1N1ekFWRllrU3Y0ZXlWK25HZ05H?=
 =?utf-8?B?cGRFZWxRYm9ZbmIzSkdkSEh3ZWkwaTRMaDl0U1UwaDU5NVZXOXdIL1lwbkhn?=
 =?utf-8?B?Ri9NSjA5TWIwWEllMXFXN0d6UXdMWVB5K0hxRDZsSlEzbXBaZUNyMFJ2dW9i?=
 =?utf-8?B?aHFlU0VLSnlrSmpsUUpqR2x3Vk11MmZSSEZ4eFl4ZXMyRkwzay80bjRNVzVQ?=
 =?utf-8?B?UFdaT1FETXVPNDk3K2ovV3oxYVMrdWlYekVWSHFOUXdlWnFhNGxSNUJZMHhS?=
 =?utf-8?B?N2F0Q2t3S2g1UHJUZHFWelpnbUFHdjk3aXgwNENEcGNDRDFraHEyOXpkcFNs?=
 =?utf-8?B?WEdnTStGYTB1WTFvVEdBTGgyNTRoL3BZZFlhd3hiYmttUjZKaGdNNUJnK2VL?=
 =?utf-8?B?SnFzc0JXNWNkQWNIYWtEMHJtanhLSnRwYkk2N2I2a2p1dzl3L0Q3anAwczB3?=
 =?utf-8?B?WDhUYUFlazhMcGUvN2k1U2dlU2RXSTIxc1VteTU0SUJ2U3oxV3M1STk4Ulcv?=
 =?utf-8?B?MDBzWU4zMU1jUEt1VnBoVmZNTVlTak5YYUdTem1uOGlzNnVjZDhGVHNaQy9q?=
 =?utf-8?B?WnFpNHgzcko2Sjh3NUR2U1laQ05OVjA2K1h0SE1uNk9ZQkVTUm1NR1ptQU1D?=
 =?utf-8?B?WjhacVoxbnQ1dG5UZy9JMkREL043bWJyYUxPNjZGRkE3MTZ3NzE5T1FZZ0lC?=
 =?utf-8?B?VG5GTEtNSndkSXVzZ2RRdGZMTVE5QWxDR0k1bWE2aFRuMlQ1TlRONGNVMDBa?=
 =?utf-8?B?TFpLZ1lMUDJtRTMzeHR2eUhKZGlpSllUdUZTR09kMW92RFliYitIRC9Samdt?=
 =?utf-8?B?NTV5SnMxd2FHVDVWSmhieUxoQWJhTGlTU3oxc3J1UnNYQ245UVIwS2V3ZWd6?=
 =?utf-8?B?RVduNVdxaWpVQjE2S1JrTGJqbHFtVkQzd3psaU11WDkrQmZweGRERFhINXBJ?=
 =?utf-8?B?Z3dpVEJHWjZENHIzR1JpczYrNHJ1MDB6MEwyeWRpajBRczcwblg3WHBkR1gx?=
 =?utf-8?B?TXhSKzlnUm0vckhJS2ZKNGxPQ0RIcCtHR3B3SFN3dmNUUndaL3NEVXBXNHdo?=
 =?utf-8?B?dTRDTG1TdTl5c0kzc1ZpZHBOaUQ2cEIvS28vb3U5eXo5QmZOdEpmVHpabW5R?=
 =?utf-8?B?emJGNThCZUVvbHdNd28vSlNobjdLZ1pvZ3ZXM0xIVVZxVjVVN3Yyc0NHMnJ4?=
 =?utf-8?B?MUsxclR1R3NZeDdMR0VMbUQ0N1RodjNsSDlpQ1ZWU0N2N0hWRDVlakh6cHJK?=
 =?utf-8?B?ZWxsb1YzdnRoMzlkanpkT2Vlb3dKVGo2YXZYRXorOFVPR0JBRHQ1Rmh2blhC?=
 =?utf-8?Q?CAGfijSpqz2Wuq85Hurdyg+qP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8932a010-38ff-4a2d-f7b0-08dde907fbfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 03:31:05.7966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2GlmJlgJtVk0/cwdzHVaUv+ExDMveUiaUkASMLTi0u8GhZLbkdtq7xFHGJk3GHLQRUENtr/+M3XWbCu0+YDPcWfUSJ0Vr6HCZsTe7UghFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8992
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTEvMjFdIGludGVsX2lvbW11
OiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBhbmQNCj51cGRhdGUNCj4NCj5PbiAyMDI1Lzgv
MjIgMTQ6NDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gVGhpcyBhZGRzIGFuIG5ldyBlbnRy
eSBWVERQQVNJRENhY2hlRW50cnkgaW4gVlREQWRkcmVzc1NwYWNlIHRvIGNhY2hlDQo+dGhlDQo+
PiBwYXNpZCBlbnRyeSBhbmQgdHJhY2sgUEFTSUQgdXNhZ2UgYW5kIGZ1dHVyZSBQQVNJRCB0YWdn
ZWQgRE1BIGFkZHJlc3MNCj4+IHRyYW5zbGF0aW9uIHN1cHBvcnQgaW4gdklPTU1VLg0KPg0KPkhh
dmUgeW91IHNlZW4gYW55IGV4dHJhIGNvZGUgbmVlZGVkIGJhc2VkIG9uIHRoaXMgc2VyaWVzIHRv
IHN1cHBvcnQgbm9uDQo+cmlkX3Bhc2lkIFBBU0lEcz8gSWYgbm8sIG1heSBqdXN0IHJlbGF4IHRo
ZSBzY29wZSBvZiB0aGlzIHNlcmllcy4NCj5vdGhlcndpc2UsIHlvdSBtYXkgbmVlZCB0byB0d2Vh
ayB0aGUgcGF0Y2ggYSBsaXR0bGUgYml0LiBlLmcuIGZhY3Rvcg0KPm91dCBzZXR0aW5nIHgtZmx0
cyBhbmQgeC1wYXNpZC1tb2RlIGF0IHRoZSBzYW1lIHRpbWUuDQoNClRoZXJlIGFyZSBxdWl0ZSBh
IGZldyBjb2RlIGFyZSBjb21tb24gZm9yIGJvdGggbm9uLXJpZF9wYXNpZCBhbmQgcmlkX3Bhc2lk
Lg0KU28gaW4gdGhpcyBzZXJpZXMsIHRoZXJlIGFyZSBzb21lIGluZnJhc3RydWN0dXJlIGNvZGUg
dGhhdCBsb29rcyBsaWtlIGl0J3MgZm9yIG5vbi1yaWRfcGFzaWQuDQoNCkJ1dCB0byBzdXBwb3J0
IG5vbi1yaWRfcGFzaWQsIHdlIG5lZWQgcGFzaWRfYXR0YWNoL2RldGFjaCgpIHdoaWNoIGlzIG5v
dCBpbXBsZW1lbnRlZCBpbiB0aGlzIHNlcmllcy4NCg0KRXZlbiBpZiB4LWZsdHMgYW5kIHgtcGFz
aWQtbW9kZSBib3RoIG9uLCBwYXNpZCBpc24ndCBlbmFibGVkIHNpbmNlIFZGSU8gZGV2aWNlIGRv
ZXNuJ3QgZXhwb3NlIHBhc2lkIGNhcGFiaWxpdHkgdG8gZ3Vlc3QsIHNvIGd1ZXN0IG5ldmVyIHVz
ZSBub24tcmlkX3Bhc2lkIHdpdGggdGhpcyBWRklPIGRldmljZS4NCg0KPg0KPj4NCj4+IFZUREFk
ZHJlc3NTcGFjZSBvZiBQQ0lfTk9fUEFTSUQgaXMgYWxsb2NhdGVkIHdoZW4gZGV2aWNlIGlzIHBs
dWdnZWQgYW5kDQo+PiBuZXZlciBmcmVlZC4gRm9yIG90aGVyIHBhc2lkLCBWVERBZGRyZXNzU3Bh
Y2UgaW5zdGFuY2UgaXMNCj5jcmVhdGVkL2Rlc3Ryb3llZA0KPj4gcGVyIHRoZSBndWVzdCBwYXNp
ZCBlbnRyeSBzZXQgdXAvZGVzdHJveS4NCj4NCj4+IFdoZW4gZ3Vlc3QgcmVtb3ZlcyBvciB1cGRh
dGVzIGEgUEFTSUQgZW50cnksIFFFTVUgd2lsbCBjYXB0dXJlIHRoZSBndWVzdA0KPnBhc2lkDQo+
PiBzZWxlY3RpdmUgcGFzaWQgY2FjaGUgaW52YWxpZGF0aW9uLCByZW1vdmVzIFZUREFkZHJlc3NT
cGFjZSBvciB1cGRhdGUNCj5jYWNoZWQNCj4+IFBBU0lEIGVudHJ5Lg0KPj4NCj4+IHZJT01NVSBl
bXVsYXRvciBjb3VsZCBmaWd1cmUgb3V0IHRoZSByZWFzb24gYnkgZmV0Y2hpbmcgbGF0ZXN0IGd1
ZXN0IHBhc2lkDQo+ZW50cnkNCj4+IGFuZCBjb21wYXJlIGl0IHdpdGggY2FjaGVkIFBBU0lEIGVu
dHJ5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAyNyArKysrLQ0K
Pj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgIDYgKw0KPj4gICBody9pMzg2
L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAxOTYNCj4rKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0NCj4+ICAgaHcvaTM4Ni90cmFjZS1ldmVudHMgICAgICAgICAgIHwgICAzICsNCj4+
ICAgNCBmaWxlcyBjaGFuZ2VkLCAyMjAgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIvaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBpbmRleCBmNzUxMDg2MWQxLi5iOWI3NmRk
OTk2IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiAr
KysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IEBAIC0zMTYsNiArMzE2LDcg
QEAgdHlwZWRlZiBlbnVtIFZUREZhdWx0UmVhc29uIHsNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICogcmVxdWVzdCB3aGlsZSBkaXNhYmxlZCAqLw0KPj4gICAgICAgVlRE
X0ZSX0lSX1NJRF9FUlIgPSAweDI2LCAgIC8qIEludmFsaWQgU291cmNlLUlEICovDQo+Pg0KPj4g
KyAgICBWVERfRlJfUlRBRERSX0lOVl9UVE0gPSAweDMxLCAgLyogSW52YWxpZCBUVE0gaW4gUlRB
RERSICovDQo+PiAgICAgICAvKiBQQVNJRCBkaXJlY3RvcnkgZW50cnkgYWNjZXNzIGZhaWx1cmUg
Ki8NCj4+ICAgICAgIFZURF9GUl9QQVNJRF9ESVJfQUNDRVNTX0VSUiA9IDB4NTAsDQo+PiAgICAg
ICAvKiBUaGUgUHJlc2VudChQKSBmaWVsZCBvZiBwYXNpZCBkaXJlY3RvcnkgZW50cnkgaXMgMCAq
Lw0KPj4gQEAgLTQ5Myw2ICs0OTQsMTUgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZURElu
dkRlc2M7DQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDANCj4weGZm
ZjAwMDAwMDAwMGYxYzBVTEwNCj4+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRf
VkFMMSAgICAgMHhmODBVTEwNCj4+DQo+PiArLyogUEFTSUQtY2FjaGUgSW52YWxpZGF0ZSBEZXNj
cmlwdG9yIChwY19pbnZfZHNjKSBmaWVsZHMgKi8NCj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19Q
QVNJRENfRyh4KSAgICAgICAgZXh0cmFjdDY0KCh4KS0+dmFsWzBdLCA0LCAyKQ0KPj4gKyNkZWZp
bmUgVlREX0lOVl9ERVNDX1BBU0lEQ19HX0RTSSAgICAgICAwDQo+PiArI2RlZmluZSBWVERfSU5W
X0RFU0NfUEFTSURDX0dfUEFTSURfU0kgIDENCj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJ
RENfR19HTE9CQUwgICAgMw0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEQ19ESUQoeCkg
ICAgICBleHRyYWN0NjQoKHgpLT52YWxbMF0sIDE2LA0KPjE2KQ0KPj4gKyNkZWZpbmUgVlREX0lO
Vl9ERVNDX1BBU0lEQ19QQVNJRCh4KSAgICBleHRyYWN0NjQoKHgpLT52YWxbMF0sIDMyLA0KPjIw
KQ0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEQ19SU1ZEX1ZBTDAgICAweGZmZjAwMDAw
MDAwMGYxYzBVTEwNCj4+ICsNCj4+ICAgLyogSW5mb3JtYXRpb24gYWJvdXQgcGFnZS1zZWxlY3Rp
dmUgSU9UTEIgaW52YWxpZGF0ZSAqLw0KPj4gICBzdHJ1Y3QgVlRESU9UTEJQYWdlSW52SW5mbyB7
DQo+PiAgICAgICB1aW50MTZfdCBkb21haW5faWQ7DQo+PiBAQCAtNTUzLDYgKzU2MywyMSBAQCB0
eXBlZGVmIHN0cnVjdCBWVERSb290RW50cnkgVlREUm9vdEVudHJ5Ow0KPj4gICAjZGVmaW5lIFZU
RF9TTV9DT05URVhUX0VOVFJZX1JTVkRfVkFMMChhdykgICgweDFlMFVMTCB8DQo+flZURF9IQVdf
TUFTSyhhdykpDQo+PiAgICNkZWZpbmUgVlREX1NNX0NPTlRFWFRfRU5UUllfUlNWRF9WQUwxDQo+
MHhmZmZmZmZmZmZmZTAwMDAwVUxMDQo+Pg0KPj4gK3R5cGVkZWYgZW51bSBWVERQQ0ludlR5cGUg
ew0KPj4gKyAgICAvKiBWVEQgc3BlYyBkZWZpbmVkIFBBU0lEIGNhY2hlIGludmFsaWRhdGlvbiB0
eXBlICovDQo+PiArICAgIFZURF9QQVNJRF9DQUNIRV9ET01TSSA9IFZURF9JTlZfREVTQ19QQVNJ
RENfR19EU0ksDQo+PiArICAgIFZURF9QQVNJRF9DQUNIRV9QQVNJRFNJID0gVlREX0lOVl9ERVND
X1BBU0lEQ19HX1BBU0lEX1NJLA0KPj4gKyAgICBWVERfUEFTSURfQ0FDSEVfR0xPQkFMX0lOViA9
DQo+VlREX0lOVl9ERVNDX1BBU0lEQ19HX0dMT0JBTCwNCj4+ICt9IFZURFBDSW52VHlwZTsNCj4+
ICsNCj4+ICt0eXBlZGVmIHN0cnVjdCBWVERQQVNJRENhY2hlSW5mbyB7DQo+PiArICAgIFZURFBD
SW52VHlwZSB0eXBlOw0KPj4gKyAgICB1aW50MTZfdCBkaWQ7DQo+PiArICAgIHVpbnQzMl90IHBh
c2lkOw0KPj4gKyAgICBQQ0lCdXMgKmJ1czsNCj4+ICsgICAgdWludDE2X3QgZGV2Zm47DQo+PiAr
fSBWVERQQVNJRENhY2hlSW5mbzsNCj4+ICsNCj4+ICAgLyogUEFTSUQgVGFibGUgUmVsYXRlZCBE
ZWZpbml0aW9ucyAqLw0KPj4gICAjZGVmaW5lIFZURF9QQVNJRF9ESVJfQkFTRV9BRERSX01BU0sg
ICh+MHhmZmZVTEwpDQo+PiAgICNkZWZpbmUgVlREX1BBU0lEX1RBQkxFX0JBU0VfQUREUl9NQVNL
ICh+MHhmZmZVTEwpDQo+PiBAQCAtNTc0LDcgKzU5OSw3IEBAIHR5cGVkZWYgc3RydWN0IFZURFJv
b3RFbnRyeSBWVERSb290RW50cnk7DQo+PiAgICNkZWZpbmUgVlREX1NNX1BBU0lEX0VOVFJZX1BU
ICAgICAgICAgICg0VUxMIDw8IDYpDQo+Pg0KPj4gICAjZGVmaW5lIFZURF9TTV9QQVNJRF9FTlRS
WV9BVyAgICAgICAgICA3VUxMIC8qIEFkanVzdGVkDQo+Z3Vlc3QtYWRkcmVzcy13aWR0aCAqLw0K
Pj4gLSNkZWZpbmUgVlREX1NNX1BBU0lEX0VOVFJZX0RJRCh2YWwpICAgICgodmFsKSAmDQo+VlRE
X0RPTUFJTl9JRF9NQVNLKQ0KPj4gKyNkZWZpbmUgVlREX1NNX1BBU0lEX0VOVFJZX0RJRCh4KSAg
ICAgIGV4dHJhY3Q2NCgoeCktPnZhbFsxXSwgMCwgMTYpDQo+Pg0KPj4gICAjZGVmaW5lIFZURF9T
TV9QQVNJRF9FTlRSWV9GTFBNICAgICAgICAgIDNVTEwNCj4+ICAgI2RlZmluZSBWVERfU01fUEFT
SURfRU5UUllfRkxQVFBUUiAgICAgICAofjB4ZmZmVUxMKQ0KPj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Yi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUu
aA0KPj4gaW5kZXggNTBmOWIyN2E0NS4uMGUzODI2ZjZmMCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxf
aW9tbXUuaA0KPj4gQEAgLTk1LDYgKzk1LDExIEBAIHN0cnVjdCBWVERQQVNJREVudHJ5IHsNCj4+
ICAgICAgIHVpbnQ2NF90IHZhbFs4XTsNCj4+ICAgfTsNCj4+DQo+PiArdHlwZWRlZiBzdHJ1Y3Qg
VlREUEFTSURDYWNoZUVudHJ5IHsNCj4+ICsgICAgc3RydWN0IFZURFBBU0lERW50cnkgcGFzaWRf
ZW50cnk7DQo+PiArICAgIGJvb2wgdmFsaWQ7DQo+PiArfSBWVERQQVNJRENhY2hlRW50cnk7DQo+
PiArDQo+PiAgIHN0cnVjdCBWVERBZGRyZXNzU3BhY2Ugew0KPj4gICAgICAgUENJQnVzICpidXM7
DQo+PiAgICAgICB1aW50OF90IGRldmZuOw0KPj4gQEAgLTEwNyw2ICsxMTIsNyBAQCBzdHJ1Y3Qg
VlREQWRkcmVzc1NwYWNlIHsNCj4+ICAgICAgIE1lbW9yeVJlZ2lvbiBpb21tdV9pcl9mYXVsdDsg
LyogSW50ZXJydXB0IHJlZ2lvbiBmb3IgY2F0Y2hpbmcNCj5mYXVsdCAqLw0KPj4gICAgICAgSW50
ZWxJT01NVVN0YXRlICppb21tdV9zdGF0ZTsNCj4+ICAgICAgIFZURENvbnRleHRDYWNoZUVudHJ5
IGNvbnRleHRfY2FjaGVfZW50cnk7DQo+PiArICAgIFZURFBBU0lEQ2FjaGVFbnRyeSBwYXNpZF9j
YWNoZV9lbnRyeTsNCj4+ICAgICAgIFFMSVNUX0VOVFJZKFZUREFkZHJlc3NTcGFjZSkgbmV4dDsN
Cj4+ICAgICAgIC8qIFN1cGVyc2V0IG9mIG5vdGlmaWVyIGZsYWdzIHRoYXQgdGhpcyBhZGRyZXNz
IHNwYWNlIGhhcyAqLw0KPj4gICAgICAgSU9NTVVOb3RpZmllckZsYWcgbm90aWZpZXJfZmxhZ3M7
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+PiBpbmRleCAxODAxZjFjZGY2Li5hMmVlNmQ2ODRlIDEwMDY0NA0KPj4gLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+
IEBAIC0xNjc1LDcgKzE2NzUsNyBAQCBzdGF0aWMgdWludDE2X3QNCj52dGRfZ2V0X2RvbWFpbl9p
ZChJbnRlbElPTU1VU3RhdGUgKnMsDQo+Pg0KPj4gICAgICAgaWYgKHMtPnJvb3Rfc2NhbGFibGUp
IHsNCj4+ICAgICAgICAgICB2dGRfY2VfZ2V0X3Bhc2lkX2VudHJ5KHMsIGNlLCAmcGUsIHBhc2lk
KTsNCj4+IC0gICAgICAgIHJldHVybiBWVERfU01fUEFTSURfRU5UUllfRElEKHBlLnZhbFsxXSk7
DQo+PiArICAgICAgICByZXR1cm4gVlREX1NNX1BBU0lEX0VOVFJZX0RJRCgmcGUpOw0KPj4gICAg
ICAgfQ0KPj4NCj4+ICAgICAgIHJldHVybiBWVERfQ09OVEVYVF9FTlRSWV9ESUQoY2UtPmhpKTsN
Cj4+IEBAIC0zMTEyLDYgKzMxMTIsMTgzIEBAIHN0YXRpYyBib29sDQo+dnRkX3Byb2Nlc3NfcGlv
dGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAgICAgcmV0dXJuIHRydWU7DQo+PiAg
IH0NCj4+DQo+PiArc3RhdGljIGlubGluZSBpbnQgdnRkX2Rldl9nZXRfcGVfZnJvbV9wYXNpZChW
VERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkLA0KPlZURFBBU0lERW50cnkgKnBlKQ0KPj4g
K3sNCj4+ICsgICAgSW50ZWxJT01NVVN0YXRlICpzID0gdnRkX2FzLT5pb21tdV9zdGF0ZTsNCj4+
ICsgICAgVlREQ29udGV4dEVudHJ5IGNlOw0KPj4gKyAgICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAg
ICBpZiAoIXMtPnJvb3Rfc2NhbGFibGUpIHsNCj4+ICsgICAgICAgIHJldHVybiAtVlREX0ZSX1JU
QUREUl9JTlZfVFRNOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldCA9IHZ0ZF9kZXZfdG9f
Y29udGV4dF9lbnRyeShzLCBwY2lfYnVzX251bSh2dGRfYXMtPmJ1cyksDQo+dnRkX2FzLT5kZXZm
biwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZjZSk7DQo+PiArICAg
IGlmIChyZXQpIHsNCj4+ICsgICAgICAgIHJldHVybiByZXQ7DQo+PiArICAgIH0NCj4+ICsNCj4+
ICsgICAgcmV0dXJuIHZ0ZF9jZV9nZXRfcGFzaWRfZW50cnkocywgJmNlLCBwZSwgcGFzaWQpOw0K
Pj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgYm9vbCB2dGRfcGFzaWRfZW50cnlfY29tcGFyZShWVERQ
QVNJREVudHJ5ICpwMSwgVlREUEFTSURFbnRyeQ0KPipwMikNCj4+ICt7DQo+PiArICAgIHJldHVy
biAhbWVtY21wKHAxLCBwMiwgc2l6ZW9mKCpwMSkpOw0KPj4gK30NCj4+ICsNCj4+ICsvKg0KPj4g
KyAqIFRoaXMgZnVuY3Rpb24gaXMgYSBsb29wIGZ1bmN0aW9uIHdoaWNoIHJldHVybiB2YWx1ZSBk
ZXRlcm1pbmVzIGlmDQo+PiArICogdnRkX2FzIGluY2x1ZGluZyBjYWNoZWQgcGFzaWQgZW50cnkg
aXMgcmVtb3ZlZC4NCj4+ICsgKg0KPj4gKyAqIEZvciBQQ0lfTk9fUEFTSUQsIHdoZW4gY29ycmVz
cG9uZGluZyBjYWNoZWQgcGFzaWQgZW50cnkgaXMgY2xlYXJlZCwNCj4+ICsgKiBpdCByZXR1cm5z
IGZhbHNlIHNvIHRoYXQgdnRkX2FzIGlzIHJlc2VydmVkIGFzIGl0J3Mgb3duZWQgYnkgUENJDQo+
PiArICogc3ViLXN5c3RlbS4gRm9yIG90aGVyIHBhc2lkLCBpdCByZXR1cm5zIHRydWUgc28gdnRk
X2FzIGlzIHJlbW92ZWQuDQo+DQo+YWxzbywgdGhpcyBoZWxwZXIgd2lsbCBhbHdheXMgcmV0dXJu
IHRydWUgaWYgdGhpcyBzZXJpZXMgZG9lcyBub3QNCj5zdXBwb3J0IG5vbi1yaWRfcGFzaWQgUEFT
SUQuDQoNCkRvIHlvdSBtZWFuIHJldHVybiBmYWxzZT8gSSBkb24ndCB0aGluayBpdCB3aWxsIHJl
dHVybiB0cnVlLg0KRm9yIG5vbi1yaWRfcGFzaWQsIGl0IG1heSByZXR1cm4gZmFsc2UuDQoNClRo
YW5rcw0KWmhlbnpob25nDQo=

