Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4412FD132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vXB-0000PN-Aa; Mon, 04 Nov 2024 06:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7vX8-0000IW-7t
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:46:10 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7vX5-00023g-0e
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730720767; x=1762256767;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=j9Q8jiSIggGX4wvWnrn0NmUjK9tU8iqTMUO2RiJljy4=;
 b=Jho+lUJYKPNK2RglyrbRx4heIhQoIn5FdQPDqweJRjxq2UrvGU9RAatQ
 t1wXY7zcG8xWWN4Qe9Q63P2RmoXTyoLvUcKHgSKKtTzbidsAD0ettnQIm
 r/q9tf3vq2OCi9RGVNEbzT998WyxPSMpXsJSXe/Dp/oPvrTVV/DT4lt/H
 NwmYf7/cxY21RwY/P81i4QaNbZnGQjN+IBPgcnsIRQXNIe6MRZlc8dgO/
 JsElMwhszCG+9dHFALSNrrzHiGbRaMtYNua9IalDt6tCHCYz1NIGNJoJR
 g/UgL/J9DbIGh1qWn2LEJ7IerzzkgkJ4iIFg+vl6AjW09kkQUQAnmYe2Z g==;
X-CSE-ConnectionGUID: hSCoooCsRFqBGdWBakKT3w==
X-CSE-MsgGUID: +HX2bqJ3QACZVRTErPM0BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="40995198"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="40995198"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 03:46:04 -0800
X-CSE-ConnectionGUID: szmiweDtQmG3ENDxnYugIQ==
X-CSE-MsgGUID: QDgBGaTVQFGKSp1GzDm0xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="88396201"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 03:46:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 03:46:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 03:46:03 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 03:46:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCL3mXXZ/IMZfqQ+VEkGoepfg6Y69SXjFkDQWM0mWa6j1GwPf+IHRv63TK1RS9lwd9Lxd3W26NRdLJ4DNHnVxGwAwbiWcKfjb9d9FFZAfvOK7yhe7EB/74iTXPvFOFDjYF+5JM9rjuyg91J10URAcHFmruLkpqSMd9hyZV//i2EnIuDvun91WhSuduPubbXdeMZWTJSitL8IIiH7GH6LY2X2RXW5CYTwmaNp1Abpmo5XT661I7tQh45nuTKTp88v04xK8HIj9d3zP3D7RgM65lVBzodB1f1s2bKVf/G0zFyPweburgrEBPXvrlGyh7Szw2xmC0SVhTTh+lIt/2q1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9Q8jiSIggGX4wvWnrn0NmUjK9tU8iqTMUO2RiJljy4=;
 b=Xbmz2knbJcaTdZE8k2awB7BQckaGDrns7pISUarKUMpzLs65BKWiGg1ZF0gFZlAyU0K/N5CkFZn6LXkr6mERQ4EAL4Indx2rnQU3T8gGGu+uxf7Xahc4bSg8xYh0s1A6rANBXvD5izIjsYI3qkq1Q0dfXbTER2IE4VlSQ5ZwPRBtvjONu8ljuL04HUEw10E8Pk5ljZ9zmQI5xs5qMxzEbYt3HusQdz/FDRDWo62unABscZ8pK0ewEY/3XvQ7xBBgClF1nzmy7pqpOE4m/9Shp9+EvwjM4Ol/+4q3UPVusZTZU+SHRwLGjZtRwLfuwRmAZ3wahDgszkS8IOVHCFX0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Mon, 4 Nov
 2024 11:46:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 11:46:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Index: AQHbExtWwxmDUGznNEuh9QEgt9JZFbKmoiIAgABQaICAABLpAIAAMdxw
Date: Mon, 4 Nov 2024 11:46:00 +0000
Message-ID: <SJ0PR11MB674422638A5915D608E9A80992512@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-5-zhenzhong.duan@intel.com>
 <3bb9da3b-f1de-4a3a-bdd8-37937ed15d50@intel.com>
 <14799ff1-8da4-4b42-921a-ad1198de1bdb@eviden.com>
 <119078eb-81f0-47a7-81b0-aaf6b7878581@intel.com>
In-Reply-To: <119078eb-81f0-47a7-81b0-aaf6b7878581@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7193:EE_
x-ms-office365-filtering-correlation-id: e59e0831-a9bf-4f8b-a0b4-08dcfcc64137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VHd2NTg3cTBqNk0wSVhjNjRWd2xaTGx5NXZZRzEzamdUdGp3bktMbmpJbU1X?=
 =?utf-8?B?dko4dTdCUm5HbFIxYjZSMGhtOTdkSWJVd1h4aGd6Q0o0QW9YbnU5MjRUZjRJ?=
 =?utf-8?B?ZWN0b2ZDWUk2RzU2TDEvN0RaWHErRzVSKzB3SkMzaWwvOW5tcXh2eE41L3li?=
 =?utf-8?B?SXhGaE4xcHREdG5jcXE1MTlOYjA3dW5OZEo3MlRBR3hUbThOZG52SW9mSGZE?=
 =?utf-8?B?QjFtN2tjTnNYa3N2czJsRW5mZkZLUStNRlEybFA3RDVWTWduSHhMNlBJeW5v?=
 =?utf-8?B?Q3ZpaVR2RXBpU3ZpdE05NldWaThVbDlMOVB6K1FHZWJQejR2eEQrLytvV25i?=
 =?utf-8?B?QXhBZ1BXUnhvRXRTNUxLbzVoZlpIMm10aWdvbFE3bTkwUng3UEtWam8vcTB1?=
 =?utf-8?B?Rm1ORC9Nbkhkd2Fuc3hoaEVNZGFiN05pVnppaEVzaGpGUkdoWEw5M241R3lh?=
 =?utf-8?B?cFd3QzJWYzQ0K0czOVJoQm9PelBuZjNEOTNHYUJUSEN3N1c1UXVXditXY1g3?=
 =?utf-8?B?aXE5T0VDUmVFbTVLQytodlcvS3JsN1V1ZVhZZ1ZOSHViYXBZY0pnSEQxV2hB?=
 =?utf-8?B?S2ZLemZ6VVpjLy81MDNjdzVPK1ZCVFJiK082L01NU1VOaW5RcExzdHpCVGZE?=
 =?utf-8?B?VE1na2pYeVpBVTNZS1ByZUo3bm5UTXBENjg1RXdIZ05OSHkzbnQ1Y1R3VTNE?=
 =?utf-8?B?RzdkUGxQU0QxMWNwZzBnNy85emRtU1IxbVBHNVd2ZERSb2VDWkNyMEpqQVJw?=
 =?utf-8?B?bTViV24xaEpKdkF0YnVQYm9yS2grWFJYRTl0UzljSmh4ZElzNUJBZGpOVUZD?=
 =?utf-8?B?am5JTVJuZTB0bC92R0dsTTdPZjNBeVJZZklJK3pmekRzbXlIcjNsQlk5eUxh?=
 =?utf-8?B?SHcwc08xUVRCWWh3OXRvSnRCRi9CanFHODlBSUR2di96UGY2MlRIcGU0MWdV?=
 =?utf-8?B?YnhFcGhlejdEY00rTjFpdjk5bzJXMVZEMVNBajVYK1dMeTFSNkFldjZ3K1Uv?=
 =?utf-8?B?a3ZBaWpSQ3BBd0ZqdzRXQzl0K1FEZjBqaDEwMUlOUlVVdHJFanNudVpLcGN3?=
 =?utf-8?B?U3NHMTVmNEp5eldDbjRDVnBJalJaUURqSFFTdHlRK1ZNSXd0NkRnOWpaV3pG?=
 =?utf-8?B?ZXBrQ3NzL1p0TXJZWGYrWGZvbXEwYUVNK05CZW9HNFlNZ1ZEWGZkanlsNUds?=
 =?utf-8?B?T2Q2NExQem42eEptTERQeFFMeFliTmVOb240dlpZcStnQ1BzU2dJNmxUM2xR?=
 =?utf-8?B?UXQ0UHdFQis5blFnTG9zcHdLckkzT2hTWFFnTHlQSksvQzhmeEE5bWdGd1BR?=
 =?utf-8?B?ZG4rRmE3ZXZjRHRqMDlzQi80TjhtL2k1RS9jRzFhVXpBZ2xvajZvOGR6L0Y2?=
 =?utf-8?B?Z3ZkQVk3Rjk5bWtUWkl3MFBTeVBJelFaZTJwTEgrTEwxNHVLMjhzb2ZESW1Q?=
 =?utf-8?B?M2xwSjg4RGhiZWpXa2ludHE0TmVnRUNNd0V2ZHg1UDFmc3haN1Rmbi9pbTZz?=
 =?utf-8?B?eWNrcnIyNEhtSXlmZGxvVzJNc3p2eVo1SHhIYkdKVkpYdmU2NEUwM1N3cUF4?=
 =?utf-8?B?QktMTDE4aG4xc0Y4T3BPMkVUcm1PWURzdDVydFJGOElHWURhKzlCdzIvN0Vv?=
 =?utf-8?B?RkpHNkN4RU1PVk0zYnJXSXFGd2dBVEs3bUpGdmQ4SnFaeHNKMS9kcWFQaWNS?=
 =?utf-8?B?UCtRRXlRaVI5RVF5N0l5STJiLzZEZUtKUHozTFVmazZPQi9LTEVVcTI5aUNE?=
 =?utf-8?B?WmYzUUlTaEZKZjRHZjVLMUFyNEZCczgyaVl4MmZlZjFxa2JWVVVOT1k2YTdZ?=
 =?utf-8?Q?0sYbXQV0X0KP1X7ROxiIhcb6qJ+gJSmw81f+U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a21pemVFZDRxa3hpb1lxVHlLZUlQcmZZaXpXMTgzQmpVZWlCNGVTRU5naGlK?=
 =?utf-8?B?eit4UDlXUnpKWGdsYy9wdUxYUjBCNFplb1BYZ0dHd2c4UGg3S28zNUdvNTdz?=
 =?utf-8?B?OGRVZGdBTVBSMXR5T0xINnkxRDIrSHN4eWVEU3ZKVHlRRVljVFVJaU5RdFor?=
 =?utf-8?B?YjBIK1JWckhrbFY1dEdhVzUxdDFLTUkwU2Vid09PaXQzaFgrSVRMS3VnZmQ0?=
 =?utf-8?B?aEduMHpMeVBYVFJObkgxYzVWcnNsZHpnYVl5dEtlY28vQmdVb3JjVENLNm1F?=
 =?utf-8?B?cjRJcUxuY1AxQXpFaThIYWdnQmtTQ0E0VFRpZWJjTUdCYXQ4RnJycDhOVisv?=
 =?utf-8?B?bHB0WUJOdnNBbkpzeUhua0J3VVc3blV1U0l6TDRtRHQrQjljNk5YUnJLL21V?=
 =?utf-8?B?UmtmamprTzRTbTI5MnVQTjkxWnZBSWRPTTRYT2dkTlJpT3FiRnJKWUJvcXpn?=
 =?utf-8?B?d20rUG5LK2FLOEJ3V0NlUHE0Z05qblQvdS9GR2gyRzgvUnhIQVhnamFBNnNw?=
 =?utf-8?B?am1VWngxTnZNbWZzR0NiOTZqZmVOOWdEL09DYzZWT0JjV0tRMTZYdk81aVFk?=
 =?utf-8?B?UEFiNlVaVjh3cG1uRDdMcnM5QzNQbTBYbndKekROd094R1dxVjBoWTdhcFB5?=
 =?utf-8?B?REdjbnBSWFFTRzlUekU0YUYrQXNsa1hta2lSVmtBOEl3MzA1QWxmODNwU0VY?=
 =?utf-8?B?bVR2RVpGSzRmakZrVXN0ei9nZkgvbSs1RFZ0NlJWQ2lPdXp3ZndTMytxNFZz?=
 =?utf-8?B?N0RzTkwvdjBZT3N3UjRGR0R5bWtCMTVIVEV4akp3VnM1OUlPc01scElEZ1lQ?=
 =?utf-8?B?M1dBT2lkdGZWYXlSazFtMkZvallLTHZiNXN1SHZCVXZxV3NQVExWVTVWM0xa?=
 =?utf-8?B?YzRHaWtEYi8xVzNuU3NxaGFxZWpCTkZIMUtRdFdXYkpaQ25aY042dEtNS29W?=
 =?utf-8?B?azBvanJVVTNKRXVJSUFBbzNPVjFrbW5oUVM5blZSdVRZNHM0amVoeFJidnJr?=
 =?utf-8?B?cGI0WFV0RitKUG1PdkV5M216RGpwWTN5VmRsby9YODdZSEoyVkMvemU0azl3?=
 =?utf-8?B?V25hclpmUXFVTGNGT29WYWtGbWlScGk1M2NUUjkya3Vja3NhM2hXaHFheThx?=
 =?utf-8?B?TFBPUWQzOUhka1ZEWjA2bzdBS2NaTDU1b2d6VFJnOWs3NkVLZkk5bmU3ZXpo?=
 =?utf-8?B?VysyZHdVdDFGS0xjc1Z1TC9aR04xNlZYTlNSOGhSSFBDSFVXMXFkdjZ5eDMz?=
 =?utf-8?B?VmcySDFQejY1S3FjWDNsRTk3Rmw5MkhxTi90bXVMTmVlaGEybnhCeWI5NEVH?=
 =?utf-8?B?ZDU1cXFSMmRYcmN5MHQycXNJSFMycUhkZXpib0JFL0xKaVg5TlF0MXg2eUor?=
 =?utf-8?B?R0dPNG9Hc3ZGOEpEcE1MS212MU56ZjdBOGlCVFVuam5OTG9yalRFdmgrY0dn?=
 =?utf-8?B?Q3lHcG5hUmFCK1JzM3NuK1pGeWhmeWcwNVF4MTRRUE44aFNpQW5HbUNoUmd3?=
 =?utf-8?B?bWM0NlpOWmtYRnJZRFdjWktFZnhZTTJrZU13ODlaMGtuZHBQblQ3UGlwUUd0?=
 =?utf-8?B?R3l1Y3JzeSt6RkZadjhVdS83b3VkRTkxV213dzdvTks3Y0hYYjJzVVhlUS9h?=
 =?utf-8?B?a05Hbi8vb2VDUXRLOUVyOTNiUWd1ckJ0RmdZa1hqczJUWFZSeENoR3RJcDVD?=
 =?utf-8?B?c1VxVnRaTlRuOG5zVGp3d0p4OS9NcDY2d2cxdFR5QTIxTHA5UHVtTklhZW44?=
 =?utf-8?B?ZDZpMDhjOVRtbXlNS2lQNFRkbFh1d2N5RkJib1B6YjBkcko3cU84MmRpaUw3?=
 =?utf-8?B?Q21KS0F6dXQ0VDR1M1FiVGZsVG5QTlkrUnRWd0NiNVQvUExadjA2WmNHOGlE?=
 =?utf-8?B?c24yOHZ2OWxlNjNoaUt3V2pSbkszLzdRaWkxYU1GWDRVNTlZd1hwT3Bwa3Y5?=
 =?utf-8?B?SWljVDVPY0twUkJBbFNpTjB5bS9PaU52K2VwdWpIOFRKSnJsY2NhSTJ5VS8w?=
 =?utf-8?B?YVlWdVU2YlpjeCs4YkxXWEFxcUlUQ3ZZa2lKRFErVjlaRTNFb1BSbEw1MTFK?=
 =?utf-8?B?SXpwNmMxWmJNaHhRRmNFYm11MXE4ZndwdmxyVEJEcTFNT2E0QlJWRnczOVlW?=
 =?utf-8?Q?dit7WHBvjfM+TyEkuet2A1KxI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59e0831-a9bf-4f8b-a0b4-08dcfcc64137
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 11:46:00.7334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxFkIy6Ju+7FVa6slw4VSawqJ2kyXofHhpiGEUhnvYJCPxxliIeFbdUVMbWe4Iv+4+ezwrAstLHrAXOzkHn7rQOUtgtbiU3eoe1gcGpCGGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7193
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAyNCA0OjQ1IFBNDQo+
U3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNC8xN10gaW50ZWxfaW9tbXU6IEZsdXNoIHN0YWdlLTIg
Y2FjaGUgaW4gUEFTSUQtDQo+c2VsZWN0aXZlIFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlv
bg0KPg0KPk9uIDIwMjQvMTEvNCAxNTozNywgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0K
Pj4NCj4+DQo+PiBPbiAwNC8xMS8yMDI0IDAzOjQ5LCBZaSBMaXUgd3JvdGU6DQo+Pj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MNCj4+PiB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4NCj4+Pg0KPj4+IE9uIDIwMjQvOS8zMCAx
NzoyNiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IFBlciBzcGVjIDYuNS4yLjQsIFBBRElE
LXNlbGVjdGl2ZSBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24gd2lsbA0KPj4+PiBmbHVz
aCBzdGFnZS0yIGlvdGxiIGVudHJpZXMgd2l0aCBtYXRjaGluZyBkb21haW4gaWQgYW5kIHBhc2lk
Lg0KPj4+DQo+Pj4gQWxzbywgY2FsbCBvdXQgaXQncyBwZXIgdGFibGUgVGFibGUgMjEuIFBBU0lE
LWJhc2VkLUlPVExCIEludmFsaWRhdGlvbiBvZg0KPj4+IFZULWQgc3BlYyA0LjEuDQo+Pj4NCj4+
Pj4gV2l0aCBzY2FsYWJsZSBtb2Rlcm4gbW9kZSBpbnRyb2R1Y2VkLCBndWVzdCBjb3VsZCBzZW5k
IFBBU0lELXNlbGVjdGl2ZQ0KPj4+PiBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24gdG8g
Zmx1c2ggYm90aCBzdGFnZS0xIGFuZCBzdGFnZS0yIGVudHJpZXMuDQo+Pj4+DQo+Pj4+IEJ5IHRo
aXMgY2hhbmNlLCByZW1vdmUgb2xkIElPVExCIHJlbGF0ZWQgZGVmaW5pdGlvbnMgd2hpY2ggd2Vy
ZSB1bnVzZWQuDQo+Pj4NCj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+PiBSZXZpZXdlZC1ieTogQ2zDqW1lbnQgTWF0
aGlldS0tRHJpZjxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+Pj4gQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgwqAg
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMTQgKysrKy0tDQo+Pj4+ICDCoCBody9p
Mzg2L2ludGVsX2lvbW11LmPCoMKgwqDCoMKgwqDCoMKgwqAgfCA4OCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystDQo+Pj4+ICDCoCAyIGZpbGVzIGNoYW5nZWQsIDk2IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2Lw0KPj4+PiBpbnRlbF9pb21tdV9pbnRlcm5h
bC5oDQo+Pj4+IGluZGV4IGQwZjlkNDU4OWQuLmVlYzgwOTAxOTAgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+PiArKysgYi9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCj4+Pj4gQEAgLTQwMywxMSArNDAzLDYgQEAgdHlwZWRlZiB1bmlv
biBWVERJbnZEZXNjIFZUREludkRlc2M7DQo+Pj4+ICDCoCAjZGVmaW5lIFZURF9JTlZfREVTQ19J
T1RMQl9BTSh2YWwpwqDCoMKgwqDCoCAoKHZhbCkgJiAweDNmVUxMKQ0KPj4+PiAgwqAgI2RlZmlu
ZSBWVERfSU5WX0RFU0NfSU9UTEJfUlNWRF9MT8KgwqDCoMKgwqAgMHhmZmZmZmZmZjAwMDBmMTAw
VUxMDQo+Pj4+ICDCoCAjZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9SU1ZEX0hJwqDCoMKgwqDC
oCAweGY4MFVMTA0KPj4+PiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUEFTSUTC
oCAoMlVMTCA8PCA0KQ0KPj4+PiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUEFH
RcKgwqAgKDNVTEwgPDwgNCkNCj4+Pj4gLSNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1BBU0lE
KHZhbCnCoMKgICgoKHZhbCkgPj4gMzIpICYNCj4+Pj4gVlREX1BBU0lEX0lEX01BU0spDQo+Pj4+
IC0jZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9QQVNJRF9SU1ZEX0xPwqDCoMKgwqDCoCAweGZm
ZjAwMDAwMDAwMDAxYzBVTEwNCj4+Pj4gLSNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1BBU0lE
X1JTVkRfSEnCoMKgwqDCoMKgIDB4ZjgwVUxMDQo+Pj4+DQo+Pj4+ICDCoCAvKiBNYXNrIGZvciBE
ZXZpY2UgSU9UTEIgSW52YWxpZGF0ZSBEZXNjcmlwdG9yICovDQo+Pj4+ICDCoCAjZGVmaW5lIFZU
RF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfQUREUih2YWwpICgodmFsKSAmDQo+Pj4+IDB4ZmZmZmZm
ZmZmZmZmZjAwMFVMTCkNCj4+Pj4gQEAgLTQzMyw2ICs0MjgsMTUgQEAgdHlwZWRlZiB1bmlvbiBW
VERJbnZEZXNjIFZUREludkRlc2M7DQo+Pj4+ICDCoCAjZGVmaW5lIFZURF9TUFRFX0xQQUdFX0wz
X1JTVkRfTUFTSyhhdykgXA0KPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgICgweDNmZmZmODAwVUxM
IHwgfihWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pKQ0KPj4+Pg0KPj4+PiArLyog
TWFza3MgZm9yIFBJT1RMQiBJbnZhbGlkYXRlIERlc2NyaXB0b3IgKi8NCj4+Pj4gKyNkZWZpbmUg
VlREX0lOVl9ERVNDX1BJT1RMQl9HwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgzVUxMIDw8IDQp
DQo+Pj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfQUxMX0lOX1BBU0lEwqAgKDJVTEwg
PDwgNCkNCj4+Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9QU0lfSU5fUEFTSUTCoCAo
M1VMTCA8PCA0KQ0KPj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0RJRCh2YWwpwqDC
oMKgwqDCoCAoKCh2YWwpID4+IDE2KSAmDQo+Pj4+IFZURF9ET01BSU5fSURfTUFTSykNCj4+Pj4g
KyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9QQVNJRCh2YWwpwqDCoMKgICgoKHZhbCkgPj4g
MzIpICYgMHhmZmZmZlVMTCkNCj4+Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZE
X1ZBTDDCoMKgwqDCoCAweGZmZjAwMDAwMDAwMGYxYzBVTEwNCj4+Pj4gKyNkZWZpbmUgVlREX0lO
Vl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDHCoMKgwqDCoCAweGY4MFVMTA0KPj4+PiArDQo+Pj4+ICDC
oCAvKiBJbmZvcm1hdGlvbiBhYm91dCBwYWdlLXNlbGVjdGl2ZSBJT1RMQiBpbnZhbGlkYXRlICov
DQo+Pj4+ICDCoCBzdHJ1Y3QgVlRESU9UTEJQYWdlSW52SW5mbyB7DQo+Pj4+ICDCoMKgwqDCoMKg
IHVpbnQxNl90IGRvbWFpbl9pZDsNCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9t
bXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiBpbmRleCA5ZTZlZjBjYjk5Li43MmM5
YzkxZDRmIDEwMDY0NA0KPj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gKysr
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+IEBAIC0yNjU2LDYgKzI2NTYsODYgQEAgc3Rh
dGljIGJvb2wNCj4+Pj4gdnRkX3Byb2Nlc3NfaW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMs
IFZUREludkRlc2MgKmludl9kZXNjKQ0KPj4+PiAgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4+
Pj4gIMKgIH0NCj4+Pj4NCj4+Pj4gK3N0YXRpYyBnYm9vbGVhbiB2dGRfaGFzaF9yZW1vdmVfYnlf
cGFzaWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdwb2ludGVyIHVzZXJfZGF0YSkNCj4+Pj4gK3sNCj4+Pj4gK8KgwqDCoCBWVERJ
T1RMQkVudHJ5ICplbnRyeSA9IChWVERJT1RMQkVudHJ5ICopdmFsdWU7DQo+Pj4+ICvCoMKgwqAg
VlRESU9UTEJQYWdlSW52SW5mbyAqaW5mbyA9IChWVERJT1RMQlBhZ2VJbnZJbmZvICopdXNlcl9k
YXRhOw0KPj4+PiArDQo+Pj4+ICvCoMKgwqAgcmV0dXJuICgoZW50cnktPmRvbWFpbl9pZCA9PSBp
bmZvLT5kb21haW5faWQpICYmDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChlbnRyeS0+
cGFzaWQgPT0gaW5mby0+cGFzaWQpKTsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArc3RhdGljIHZv
aWQgdnRkX3Bpb3RsYl9wYXNpZF9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MTZfdCBkb21haW5faWQsIHVpbnQzMl90DQo+Pj4+
IHBhc2lkKQ0KPj4+PiArew0KPj4+PiArwqDCoMKgIFZURElPVExCUGFnZUludkluZm8gaW5mbzsN
Cj4+Pj4gK8KgwqDCoCBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hczsNCj4+Pj4gK8KgwqDCoCBWVERD
b250ZXh0RW50cnkgY2U7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoCBpbmZvLmRvbWFpbl9pZCA9IGRv
bWFpbl9pZDsNCj4+Pj4gK8KgwqDCoCBpbmZvLnBhc2lkID0gcGFzaWQ7DQo+Pj4+ICsNCj4+Pj4g
K8KgwqDCoCB2dGRfaW9tbXVfbG9jayhzKTsNCj4+Pj4gK8KgwqDCoCBnX2hhc2hfdGFibGVfZm9y
ZWFjaF9yZW1vdmUocy0+aW90bGIsIHZ0ZF9oYXNoX3JlbW92ZV9ieV9wYXNpZCwNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICZpbmZvKTsNCj4+Pj4gK8KgwqDCoCB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4+PiArDQo+
Pj4+ICvCoMKgwqAgUUxJU1RfRk9SRUFDSCh2dGRfYXMsICZzLT52dGRfYXNfd2l0aF9ub3RpZmll
cnMsIG5leHQpIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghdnRkX2Rldl90b19jb250ZXh0
X2VudHJ5KHMsIHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHZ0ZF9hcy0+ZGV2Zm4sICZjZSkgJiYNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZG9tYWluX2lkID09IHZ0ZF9nZXRfZG9tYWluX2lkKHMsICZjZSwgdnRkX2FzLT5wYXNpZCkpIHsN
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgcmlkMnBhc2lkID0gVlREX0NF
X0dFVF9SSUQyUEFTSUQoJmNlKTsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoKHZ0ZF9hcy0+cGFzaWQgIT0gUENJX05PX1BBU0lEIHx8IHBhc2lkICE9IHJpZDJwYXNp
ZCkgJiYNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2dGRfYXMtPnBhc2lk
ICE9IHBhc2lkKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGlu
dWU7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4gKw0KPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZF9hZGRyZXNzX3NwYWNlX3N5bmModnRkX2FzKTsN
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+PiArwqDCoMKgwqDCoMKgwqAgfQ0K
Pj4+PiArwqDCoMKgIH0NCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArc3RhdGljIGJvb2wgdnRkX3By
b2Nlc3NfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBWVERJbnZEZXNjICppbnZfZGVzYykNCj4+Pj4gK3sNCj4+Pj4gK8KgwqDCoCB1aW50MTZfdCBk
b21haW5faWQ7DQo+Pj4+ICvCoMKgwqAgdWludDMyX3QgcGFzaWQ7DQo+Pj4+ICsNCj4+Pj4gK8Kg
wqDCoCBpZiAoKGludl9kZXNjLT52YWxbMF0gJiBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRfVkFM
MCkgfHwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIChpbnZfZGVzYy0+dmFsWzFdICYgVlREX0lOVl9E
RVNDX1BJT1RMQl9SU1ZEX1ZBTDEpIHx8DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpbnZfZGVzYy0+
dmFsWzJdIHx8IGludl9kZXNjLT52YWxbM10pIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGVycm9y
X3JlcG9ydF9vbmNlKCIlczogaW52YWxpZCBwaW90bGIgaW52IGRlc2MgdmFsWzNdPTB4JSJQUkl4
NjQNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICIgdmFsWzJdPTB4JSJQUkl4NjQiIHZhbFsxXT0weCUiUFJJeDY0DQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiIHZhbFswXT0weCUi
UFJJeDY0IiAocmVzZXJ2ZWQgYml0cyB1bnplcm8pIiwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZnVuY19fLCBpbnZfZGVzYy0+dmFs
WzNdLCBpbnZfZGVzYy0+dmFsWzJdLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW52X2Rlc2MtPnZhbFsxXSwgaW52X2Rlc2MtPnZhbFsw
XSk7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+Pj4+ICvCoMKgwqAgfQ0K
Pj4+DQo+Pj4gTmVlZCB0byBjb25zaWRlciB0aGUgYmVsb3cgYmVoYXZpb3VyIGFzIHdlbGwuDQo+
Pj4NCj4+PiAiDQo+Pj4gVGhpcw0KPj4+IGRlc2NyaXB0b3IgaXMgYSAyNTYtYml0IGRlc2NyaXB0
b3IgYW5kIHdpbGwgcmVzdWx0IGluIGFuIGludmFsaWQgZGVzY3JpcHRvcg0KPj4+IGVycm9yIGlm
IHN1Ym1pdHRlZCBpbiBhbiBJUSB0aGF0DQo+Pj4gaXMgc2V0dXAgdG8gcHJvdmlkZSBoYXJkd2Fy
ZSB3aXRoIDEyOC1iaXQgZGVzY3JpcHRvcnMgKElRQV9SRUcuRFc9MCkNCj4+PiAiDQo+Pj4NCj4+
PiBBbHNvIHRoZXJlIGFyZSBkZXNjcmlwdGlvbnMgYWJvdXQgdGhlIG9sZCBpbnYgZGVzYyB0eXBl
cyAoZS5nLg0KPj4+IGlvdGxiX2ludl9kZXNjKSB0aGF0IGNhbiBiZSBlaXRoZXIgMTI4Yml0cyBv
ciAyNTZiaXRzLg0KPj4+DQo+Pj4gIklmIGEgMTI4LWJpdA0KPj4+IHZlcnNpb24gb2YgdGhpcyBk
ZXNjcmlwdG9yIGlzIHN1Ym1pdHRlZCBpbnRvIGFuIElRIHRoYXQgaXMgc2V0dXAgdG8gcHJvdmlk
ZQ0KPj4+IGhhcmR3YXJlIHdpdGggMjU2LWJpdA0KPj4+IGRlc2NyaXB0b3JzIG9yIHZpY2UtdmVy
c2EgaXQgd2lsbCByZXN1bHQgaW4gYW4gaW52YWxpZCBkZXNjcmlwdG9yIGVycm9yLg0KPj4+ICIN
Cj4+Pg0KPj4+IElmIERXPT0xLCB2SU9NTVUgZmV0Y2hlcyAzMiBieXRlcyBwZXIgZGVzYy4gSW4g
c3VjaCBjYXNlLCBpZiB0aGUgZ3Vlc3QNCj4+PiBzdWJtaXRzIDEyOGJpdHMgZGVzYywgdGhlbiB0
aGUgaGlnaCAxMjhiaXRzIHdvdWxkIGJlIG5vbi16ZXJvIGlmIHRoZXJlIGlzDQo+Pj4gbW9yZSB0
aGFuIG9uZSBkZXNjLiBCdXQgaWYgdGhlcmUgaXMgb25seSBvbmUgZGVzYyBpbiB0aGUgcXVldWUs
IHRoZW4gdGhlDQo+Pj4gaGlnaCAxMjhiaXRzIHdvdWxkIGJlIHplcm8gYXMgd2VsbC4gV2hpbGUs
IGl0IG1heSBiZSBjYXB0dXJlZCBieSB0aGUNCj4+PiB0YWlsIHJlZ2lzdGVyIHVwZGF0ZS4gQml0
NCBpcyByZXNlcnZlZCB3aGVuIERXPT0xLCBhbmQgZ3Vlc3Qgd291bGQgdXNlDQo+Pj4gYml0NCB3
aGVuIGl0IG9ubHkgc3VibWl0cyBvbmUgZGVzYy4NCj4+Pg0KPj4+IElmIERXPT0wLCB2SU9NTVUg
ZmV0Y2hzIDE2Ynl0ZXMgcGVyIGRlc2MuIElmIGd1ZXN0IHN1Ym1pdHMgMjU2Yml0cyBkZXNjLA0K
Pj4+IGl0IHdvdWxkIGFwcGVhciB0byBiZSB0d28gZGVzY3MgZnJvbSB2SU9NTVUgcC5vLnYuIFRo
ZSBmaXJzdCAxMjhiaXRzDQo+Pj4gY2FuIGJlIGlkZW50aWZpZWQgYXMgdmFsaWQgZXhjZXB0IGZv
ciB0aGUgdHlwZXMgdGhhdCBkb2VzIG5vdCByZXF1aXJlcw0KPj4+IDI1NmJpdHMuIFRoZSBoaWdo
ZXIgMTI4Yml0cyB3b3VsZCBiZSBzdWJqZWN0ZWQgdG8gdGhlIGRlc2Mgc2FuaXR5IGNoZWNrDQo+
Pj4gYXMgd2VsbC4NCj4+Pg0KPj4+IEJhc2VkIG9uIHRoZSBhYm92ZSwgSSB0aGluayB5b3UgbWF5
IG5lZWQgdG8gYWRkIHR3byBtb3JlIGNoZWNrcy4gSWYgRFc9PTAsDQo+Pj4gdklPTU1VIHNob3Vs
ZCBmYWlsIHRoZSBpbnYgdHlwZXMgdGhhdCByZXF1aXJlcyAyNTZiaXRzOyBJZiBEVz09MSwgeW91
DQo+Pj4gc2hvdWxkIGNoZWNrIHRoZSBpbnZfZGVzYy0+dmFsWzJdIGFuZCBpbnZfZGVzYy0+dmFs
WzNdLiBZb3UndmUgYWxyZWFkeQ0KPj4+IGRvbmUgaXQgaW4gdGhpcyBwYXRjaC4NCj4+Pg0KPj4+
IFRob3VnaHRzIGFyZSB3ZWxjb21lZCBoZXJlLg0KPj4NCj4+IEdvb2QgY2F0Y2gsDQo+PiBJIHRo
aW5rIHdlIHNob3VsZCB3cml0ZSB0aGUgY2hlY2sgaW4gdnRkX3Byb2Nlc3NfaW52X2Rlc2MNCj4+
IHJhdGhlciB0aGFuIHVwZGF0aW5nIHRoZSBoYW5kbGVycy4NCj4+DQo+PiBXaGF0IGFyZSB5b3Vy
IHRob3VnaHRzPw0KPg0KPnRoZSBmaXJzdCBjaGVjayBjYW4gYmUgZG9uZSBpbiB2dGRfcHJvY2Vz
c19pbnZfZGVzYygpLiBUaGUgc2Vjb25kIG1heQ0KPmJlIGJldHRlciBpbiB0aGUgaGFuZGxlcnMg
YXMgdGhlIGhhbmRsZXJzIGhhdmUgdGhlIHJlc2VydmVkIGJpdHMgY2hlY2suDQo+QnV0IGdpdmVu
IHRoYXQgbm9uZSBvZiB0aGUgaW52IHR5cGVzIHVzZSB0aGUgaGlnaCAxMjhiaXRzLCBzbyBpdCBp
cyBhbHNvDQo+YWNjZXB0YWJsZSB0byBkbyBpdCBpbiB2dGRfcHJvY2Vzc19pbnZfZGVzYygpLiBE
byBhZGQgcHJvcGVyIGNvbW1lbnQuDQoNClRoYW5rcyBZaSBhbmQgQ2xlbWVudCdzIHN1Z2dlc3Rp
b24sIEknbGwgc2VuZCBhIHNtYWxsIHNlcmllcyB0byBmaXggdGhhdA0KZm9yIHVwc3RyZWFtLg0K
DQpCUnMuDQpaaGVuemhvbmcNCg==

