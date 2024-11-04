Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D07D111AB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 05:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7pwO-0004Jr-Hn; Mon, 04 Nov 2024 00:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7pwL-0004Ia-IB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 00:47:49 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7pwJ-0003PG-Nb
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 00:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730699268; x=1762235268;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wKazaRqBLwudmcKBPuPAuPczkX5UwKqx4jhUstYcC7Q=;
 b=cViR98PMwaVMCity2A7Bew85ns7OrsviN+91QIozT43d+LO8bNl3+Mb3
 BqSqzoJqgozNvF0tHbmLw+kvge16R7aUilmczUiaamvfr/PAem6zHT2ZO
 vPc2S4iDVlrnk9X47H+tD1ACbl/Tq6tcUQwKtsAbMfLj1TSeYTGHkl0gp
 7ZaF9oInurmO+UPZwDuFw7lSlo2FXel4aWw51+39Ca/ObEckLyKMQI0hM
 ixUQ/o1pqsJQwe1IZFdJr4o1oWfbBh42P9Srhh0xn5gxgKjVRjwi8JNmn
 zgT/zIkQQXx23LmqADUhobhuW42w25gBoVrZP/b7mqCgzgztNWKJX8No8 Q==;
X-CSE-ConnectionGUID: CaNT8SRnQNW1bsDwH8ym+g==
X-CSE-MsgGUID: wnON7JxbQeSfFcI/zB8EFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="18000451"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="18000451"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 21:47:44 -0800
X-CSE-ConnectionGUID: S7aSb31kRu6bkuV/2oxp7g==
X-CSE-MsgGUID: 3AhxznnJTeGB/zhyoFxK2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83479655"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 21:47:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 21:47:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 21:47:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 21:47:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUPdWJ0YVkPk0SyYqB2l6GXrB6NqCVVzMr26hUB7n1NeYQUqT5InMQgWM9ydk9p2rlakK25gzvRxvea1HpYOxO5SOpvP9UU1fpG+q2DoSW2ebAfEGywMlIuBncPl6oEl5jgx1mRMrhvHa4sT0ADWPzgBhLmi+6jGy/o2IAwALtZz89S4SjxhacfiXfRTXJZeuk547FEuGCHqh+ReFFTMv0krs7zCUNkJoX9hjIdsrxCg6wpT7d7+hmgXUHJp0t9tvEDqEUs9xAj8s8in0xVaFkHopyaqOdA4ydCMEmkwkoa1hLcPhGh/+rKXKeUHakipQQIhtJ0g7OGI1RtevDySqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKazaRqBLwudmcKBPuPAuPczkX5UwKqx4jhUstYcC7Q=;
 b=mksBWYtI5KNF+Z/XUmplLmtt5HOKFQkgADl4bjonnMHGltv/uYygrffPqrhm2RT/ATzXTdz7PwRWj2uis4sh8kVa3kARwAVvQ7eS73lUcgVCHiCDJhJNtzqla1GiajeTw5fB3IMV/to21mf4Z53QPUfy6DFABU20Y18SUOfCCeo7S2ZbcVGgOv3LbxxP+3XXBshMj6187ry603huX/ldioPO/F1jZipFHxe4KLDrmWm45QvDx1qKnXFJgyEYsJ+y+pbvJMOptgIBE2EPPlgvsB4x8B3TyLyP/35tB1JB3CpbnhFXaBfOWqkT4acE+lwmRSU2ZOhlVxAqym8fm1QJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4879.namprd11.prod.outlook.com (2603:10b6:a03:2da::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 05:47:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 05:47:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v4 11/17] intel_iommu: Add an internal API to find an
 address space with PASID
Thread-Topic: [PATCH v4 11/17] intel_iommu: Add an internal API to find an
 address space with PASID
Thread-Index: AQHbExt5dEzoVlRZgky+lxuLIemQ7bKmooYAgAAxJ5A=
Date: Mon, 4 Nov 2024 05:47:35 +0000
Message-ID: <SJ0PR11MB6744942A963D10760E94590A92512@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-12-zhenzhong.duan@intel.com>
 <4e21d66d-a923-40c5-ac12-14a349e840c5@intel.com>
In-Reply-To: <4e21d66d-a923-40c5-ac12-14a349e840c5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4879:EE_
x-ms-office365-filtering-correlation-id: c45f7e30-83af-49ae-e524-08dcfc942ece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VWNMZmxqY2lWci9JR0NCYUxyRzIwZjdQdkJ0YWM3T29nR1Q2djRpUXBhRldI?=
 =?utf-8?B?SnlEYit6MXdrV1g4SndXM1pSNG1XY0s3S2pDdlBzVVMvZ1ZvaE1JYU9DdTVu?=
 =?utf-8?B?ajhpMHZDcFRRdFAxQmR5ckRndzBLS2FtS1JlTDloTkMzRHVxNWs1NUZqdVVP?=
 =?utf-8?B?a0ZrUlJ0NnFpdkZ6aWdlTkZUOTI2YTB0dWpQZzhNZFRrZkl6ekY1MVlzRjB1?=
 =?utf-8?B?b0xyWktQU3AvUjlHcjltTWVDNjZtcW54RFcwMzJkTmpRMENPYi96ODRkM01K?=
 =?utf-8?B?b3VzcTdmdG1kK3U5UGZsaVhQR1FlUlNwYVlDMmlHTHVDL3dLNjhKb2hOVitT?=
 =?utf-8?B?U0lvM1c0UjVpR3FOWTZjeEpvYTNucWc3YzEyY3hmRjdTak5iUUJtRUhlMkVW?=
 =?utf-8?B?cGVhT1hwOFpTT3hiNE05cTR2N3ZoVTlhdlgveDhzNDdMdU5Pd1VwWnVpaEJy?=
 =?utf-8?B?Z1Y4MnZOcm9sbDBwdC8rTVVMSjgxYk5BQUh6UXU1eERoTnBva0VhVGVDN1dk?=
 =?utf-8?B?aWIwbzEwVHJWMGRWV3FxTTl4d284cnpGVVRlbGhQNjlSSis0M3NYbU8wWXh3?=
 =?utf-8?B?UWFjYjgyWWxkazh2ZGQ0cmp3Y2pHZWxPUzV1SmViRk83dU1Yc0d0aWdxQUtW?=
 =?utf-8?B?em8xTWY3MXgybVNWV01EaXZlYzY0ejcveXg3ajR4L3ZLVVErL1JjeVlHVzY1?=
 =?utf-8?B?eWNyR3lCNWZ1RHJWNjNJZjFaTGNXY3dCQlBnOWRJc1NtQktCSjcrK2NscDFR?=
 =?utf-8?B?VHNzWitLbEYzeHh2eDFDc2hUcmZiL0Mrc3hlM1RQeFhWMm43TzIwSUF6RWcr?=
 =?utf-8?B?eEVBd2FrVjl0VTIyNlNTOUphL0Q3ZEdPaytNaU0ySTQyYUpFMnlhNk11SGdn?=
 =?utf-8?B?WG5EQzZHRkxPSUdOR3FOeHZPVTdiUmNSWUxjZjJwa2x4aE5jaW5JaDZkWk92?=
 =?utf-8?B?b1ZoN0FQVDVpdi9SbVVERUZKZHRCMGNLeE03QklrT3JEWEFxMlhNZzJnT2tG?=
 =?utf-8?B?bjJwaGp4OUxqK0JFb0IvVkRqV2llUVFleEFDbktJakFkNUpNYll3aEI3Vmc5?=
 =?utf-8?B?WDhUd1p0Q2IwUkFjR0FreUo0UHdCMEZiQXJDT290bktqb2JBRnR5dno5WjJD?=
 =?utf-8?B?TDlKbG9XOEl1ayt4Znh5TjJHOGRuOVF5alFVZFVHRkFGeWQ0UWdBOWtYMjNM?=
 =?utf-8?B?aGZVamtQNC9hdXVoMk9xTWRyNUkwYkZFWTlSWFJQNm0vKzZwYUx6YzdDMFZW?=
 =?utf-8?B?cks0QmhjOHo1RGwybUpGSmR3ZTNpcVhaYXJ0cktUTzNFQUtEa3pZSUxSMkVJ?=
 =?utf-8?B?L1pjM3NQU25FeWlMeVp0bDBza3Q4RU15OWpXSHNVVnR2aTVJNTNWYStQM0lD?=
 =?utf-8?B?c3NCU3gzT1Z6YzZlekdCYjlHYUF5aDBvQVJ3RVRiUnZuRndRZDQ5eW1pbVhv?=
 =?utf-8?B?YnFFYWsvSHBUVVFHbjQ0UFJJR3B4OFFCOVBwVVlZQU1hazh0STBGYjZYVFRt?=
 =?utf-8?B?Yk9LeVJPa3RCaDlEYWNDYTlzTzdvVDZXdWExcWhGbVJjWTY0SVZxQklKZHQx?=
 =?utf-8?B?K2o5NmsrRzN4bGhCd2VkYmY0UWo4OE1mNVV0WHc0RzJmVlF3cm1FSWN4SWhw?=
 =?utf-8?B?M3JsdWhab04rNkQ5amhDbXlRSTFkQ1doQ1MrZHBnK1NDVS95ODZvV3JyTnVL?=
 =?utf-8?B?Qk1YYjhFZ3VlbnhkYjcrempQdnFKYXNJd1UwckRtTGl0V0JPWi9sc2swTXpT?=
 =?utf-8?B?a3hlQkNiUWtnTFhMMDRuVTFqRk42WlViMk9VcjVZUWtxem9VaHF2cDVHUmlq?=
 =?utf-8?Q?NqMRlK64dAUH6HYMpSlNgtiODmr5BpX/QYliE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkRsWTB6bXp1dWpuZWdQNXJJVG5JcXZ5RkVHbzhodUlWRlgwZWVOYUFDRkVo?=
 =?utf-8?B?SDRENlQvamlad3g2OU5zS3VJWEQ3ZWRweG50Njhtc3pRZmZiSGFDdFJ5VlUw?=
 =?utf-8?B?cHpCNEl6Q0gvTG16Y082RnVrNVE2RVZKUHkwV2UrWTU2RFF5Q2kzbUtQdkhr?=
 =?utf-8?B?aW1PZE83L3dkT0hEcnBhTVBteHVBY1JDeUo5VTFYWkkzcmZxNUpOQTFScllk?=
 =?utf-8?B?SHpuTnN1RHlUUUxudWQ1YmtLam9XeXBTRTBjSit0bzFLMllja0JrQ2dzOXNS?=
 =?utf-8?B?TkorVWYrZEFoZjRmZkd1Z3ppZTdCaXB3TFpQaUZZWE5EUkYxTkNhRTB5a2FM?=
 =?utf-8?B?a1g0K09URmRnU2lBMVp5Y05xNmQ5WjNOY0F3SmdseTVTRFpFVCtlT2JCbVVi?=
 =?utf-8?B?OHRHRWhJVFhsV0JWTlV3K3FMckNNZ004ckRPczh2R2RqSWdOOE4vWkFpakpB?=
 =?utf-8?B?K2YwZFJKNGlrckJFOElieC84ZUovRXl4UU1yQXM4ZFg2NDcvRzIwTW5EQ0R3?=
 =?utf-8?B?d21ITDRoaVp6RHFMY3U4WVB5V2hYZCtNeG1ZKzRWTGdnalJxZDhHQ082WWh3?=
 =?utf-8?B?K0VFaGZEcUpVdytlUWc2d0wwVGJZeTQ5MDBObHhvZVh2cVBzck44dE9vUDVj?=
 =?utf-8?B?eHBkZ2s0by82blNsYzE2Q0o3Q0RnQ3lNbkpNbVY4Yys2eSs2VGVMWlFkUlJr?=
 =?utf-8?B?N1NNVFlaZHo2RXhEVkcwVW9aVHR3SHM2WExJTUpzUzc3alFuSHg0T0VLbWxj?=
 =?utf-8?B?V1RiMFg3TlplUmJhUUkvTlpHaHVDekpzYTFNNXVqeU04dzIyenZXUDF6UnJk?=
 =?utf-8?B?MkZYdW5XSzZWUldOcG9kdVlaR0krUmg0ZVQvZXc1WWl1TGpQOC9jUlptRmky?=
 =?utf-8?B?QnhUREpGMGEyQ3lLdlVvOUFYODVqQWxzekZGOTlyckNaUDI0eHBBa0lEZkpP?=
 =?utf-8?B?eFNGaERGa1hlaFBncWdkKzZySDh3WUcxU3N5VFRrNU43RExDRE1TVHJvczdI?=
 =?utf-8?B?REc3Skd0LzhsM0tlak54Mk4xT2NQa1VHQzFyWWlLZk0xNDMzbDh3b0Q0RzFu?=
 =?utf-8?B?NGFtV1RReXcrSlJhbjVRUjNiYjNDY3pvVnNDcWE5UE9pclN3Nk5QcFN4Q2xa?=
 =?utf-8?B?MlY4Q2svbmxveWdkOVgvcnlraEFTRFhseTNwQjZZVGhtRjJtM3ZGSnNCaE9X?=
 =?utf-8?B?Vk9VMTd6dVF2UVlaNVA4dUdKK0xqMzdiZTRmaXU0ZXZSQU5IbnRtNXMybWVo?=
 =?utf-8?B?aU8xRFBaZk53ZVJ1OGtGazhiR2hlenpleDFCanVFRzJtNkRubE1EdWtIcXRw?=
 =?utf-8?B?WSt0c3pra1dyYS9VMDJNTUR3MmpqelU0NndKWlRrUkcyK3c4NnVTUjU1cTZh?=
 =?utf-8?B?NlFWUU04akxlZGdWLzlpVnVZWUtTbjM0akxIQkI2NVJJaUJzUFhPRTh2b1Vo?=
 =?utf-8?B?WGtnQzZyQWE0bEx0YlZZbGJMMEgxYnVHTSs5MUVXOWFqdWhFYmpsYkdkUkJF?=
 =?utf-8?B?STBicVVJdmN4TTdWTDRWcTZ2V2RNSUFlVmVrUjJSNlRaa3NXcEErbnhiY3Vr?=
 =?utf-8?B?MDBnQy9EWldpZVduOWhXL3ZhRW5VMGUwbnMydFAwaW1zSlJ5TkpJcFJ1ZjlY?=
 =?utf-8?B?ZS9FcFFyNVp5RmRQQVZ0MnBKdEd1ajB1TmVYTVBtV3NCc1h2S0RKS1hJTVUz?=
 =?utf-8?B?K2RYWUxFRGlaMjdBeGdYb0c3eUVpMjNxUE1vbmRsU2dKZGZQazhMekFkL1dt?=
 =?utf-8?B?eS9jM0xsSEkvNzhjUGdkNmlGNDhGbW1iNjNzMDFJQ2tSQ0VVZFJ0SzRpR0Ni?=
 =?utf-8?B?RDZXWTZsQjliei9lU1ByUHdrWUcvV0F6VVBQbTFKZjQ1ZDVUNFd6NlVES3V0?=
 =?utf-8?B?MHk2TWdDRlJ0eFI2SjFMTUhXUUlIU2VvU0grUmg2QkVlWVRtWG9XQ0M1eFdn?=
 =?utf-8?B?TXUvS0sxeU9kQmFtOURPZ3hIbVJ0STZ2NG1kTHllYlJqOGlkZ0Q2TFJ2Q2do?=
 =?utf-8?B?Ulc0d3I0cE0vQTlaTUZrbDZxeWlMczJWZG51RFFsMVgrRnF5Rmx4NEcxdXVX?=
 =?utf-8?B?Tk9IMFBrMEVlQmt4NXdGM2IzNXdjSGhVN0RRK1RubjhJdThwSytLbEo5WVFx?=
 =?utf-8?Q?97aojsCi7/UvVQUrCdml0zPVV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45f7e30-83af-49ae-e524-08dcfc942ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 05:47:35.0224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rnp9JpUEC44+sPj0l3coPxiENM+GzUcGkaFSwbhBhNgVuxDHyD1z632R4CvZcCBtoTqgiR5aVJ0NHll12aBphLMm4QV484ekKI+m8qkFNMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4879
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAyNCAxMDo1MSBBTQ0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTEvMTddIGludGVsX2lvbW11OiBBZGQgYW4gaW50ZXJu
YWwgQVBJIHRvIGZpbmQgYW4gYWRkcmVzcw0KPnNwYWNlIHdpdGggUEFTSUQNCj4NCj5PbiAyMDI0
LzkvMzAgMTc6MjYsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gRnJvbTogQ2zDqW1lbnQgTWF0
aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pg0KPj4gVGhp
cyB3aWxsIGJlIHVzZWQgdG8gaW1wbGVtZW50IHRoZSBkZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9u
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5t
YXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwg
MzkgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBp
bmRleCAyODkyNzhjZTMwLi5hMTU5NmJhNDdkIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC03MCw2ICs3
MCwxMSBAQCBzdHJ1Y3QgdnRkX2hpb2Rfa2V5IHsNCj4+ICAgICAgIHVpbnQ4X3QgZGV2Zm47DQo+
PiAgIH07DQo+Pg0KPj4gK3N0cnVjdCB2dGRfYXNfcmF3X2tleSB7DQo+PiArICAgIHVpbnQxNl90
IHNpZDsNCj4+ICsgICAgdWludDMyX3QgcGFzaWQ7DQo+PiArfTsNCj4+ICsNCj4+ICAgc3RydWN0
IHZ0ZF9pb3RsYl9rZXkgew0KPj4gICAgICAgdWludDY0X3QgZ2ZuOw0KPj4gICAgICAgdWludDMy
X3QgcGFzaWQ7DQo+PiBAQCAtMTg3NSwyOSArMTg4MCwzMyBAQCBzdGF0aWMgaW5saW5lIGJvb2wg
dnRkX2lzX2ludGVycnVwdF9hZGRyKGh3YWRkcg0KPmFkZHIpDQo+PiAgICAgICByZXR1cm4gVlRE
X0lOVEVSUlVQVF9BRERSX0ZJUlNUIDw9IGFkZHIgJiYgYWRkciA8PQ0KPlZURF9JTlRFUlJVUFRf
QUREUl9MQVNUOw0KPj4gICB9DQo+Pg0KPj4gLXN0YXRpYyBnYm9vbGVhbiB2dGRfZmluZF9hc19i
eV9zaWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwNCj4+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGdwb2ludGVyIHVzZXJfZGF0YSkNCj4+ICtzdGF0aWMgZ2Jvb2xl
YW4gdnRkX2ZpbmRfYXNfYnlfc2lkX2FuZF9wYXNpZChncG9pbnRlciBrZXksIGdwb2ludGVyIHZh
bHVlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdw
b2ludGVyIHVzZXJfZGF0YSkNCj4+ICAgew0KPj4gICAgICAgc3RydWN0IHZ0ZF9hc19rZXkgKmFz
X2tleSA9IChzdHJ1Y3QgdnRkX2FzX2tleSAqKWtleTsNCj4+IC0gICAgdWludDE2X3QgdGFyZ2V0
X3NpZCA9ICoodWludDE2X3QgKil1c2VyX2RhdGE7DQo+PiArICAgIHN0cnVjdCB2dGRfYXNfcmF3
X2tleSB0YXJnZXQgPSAqKHN0cnVjdCB2dGRfYXNfcmF3X2tleSAqKXVzZXJfZGF0YTsNCj4NCj53
aHkgbm90IGp1c3QgZGVmaW5lIHRhcmdldCBhcyBhIHBvaW50ZXI/DQo+DQo+PiAgICAgICB1aW50
MTZfdCBzaWQgPSBQQ0lfQlVJTERfQkRGKHBjaV9idXNfbnVtKGFzX2tleS0+YnVzKSwgYXNfa2V5
LT5kZXZmbik7DQo+PiAtICAgIHJldHVybiBzaWQgPT0gdGFyZ2V0X3NpZDsNCj4+ICsNCj4+ICsg
ICAgcmV0dXJuIChhc19rZXktPnBhc2lkID09IHRhcmdldC5wYXNpZCkgJiYNCj4+ICsgICAgICAg
ICAgIChzaWQgPT0gdGFyZ2V0LnNpZCk7DQo+DQo+aGVuY2UgdXNpbmcgdGFyZ2V0LT5wYXNpZCBh
bmQgdGFyZ2V0LT5zaWQgaGVyZS4NCg0KU3VyZSwgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhv
bmcNCg0KPiBPdGhlcndpc2UsIGxvb2tzIGdvb2QgdG8gbWUuDQo+DQo+UmV2aWV3ZWQtYnk6IFlp
IExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPg0KPj4gICB9DQo+Pg0KPj4gLXN0YXRpYyBWVERB
ZGRyZXNzU3BhY2UgKnZ0ZF9nZXRfYXNfYnlfc2lkKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2
X3Qgc2lkKQ0KPj4gK3N0YXRpYyBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9nZXRfYXNfYnlfc2lkX2Fu
ZF9wYXNpZChJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IHNpZCwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQp
DQo+PiAgIHsNCj4+IC0gICAgdWludDhfdCBidXNfbnVtID0gUENJX0JVU19OVU0oc2lkKTsNCj4+
IC0gICAgVlREQWRkcmVzc1NwYWNlICp2dGRfYXMgPSBzLT52dGRfYXNfY2FjaGVbYnVzX251bV07
DQo+PiAtDQo+PiAtICAgIGlmICh2dGRfYXMgJiYNCj4+IC0gICAgICAgIChzaWQgPT0gUENJX0JV
SUxEX0JERihwY2lfYnVzX251bSh2dGRfYXMtPmJ1cyksIHZ0ZF9hcy0+ZGV2Zm4pKSkgew0KPj4g
LSAgICAgICAgcmV0dXJuIHZ0ZF9hczsNCj4+IC0gICAgfQ0KPj4gKyAgICBzdHJ1Y3QgdnRkX2Fz
X3Jhd19rZXkga2V5ID0gew0KPj4gKyAgICAgICAgLnNpZCA9IHNpZCwNCj4+ICsgICAgICAgIC5w
YXNpZCA9IHBhc2lkDQo+PiArICAgIH07DQo+Pg0KPj4gLSAgICB2dGRfYXMgPSBnX2hhc2hfdGFi
bGVfZmluZChzLT52dGRfYWRkcmVzc19zcGFjZXMsIHZ0ZF9maW5kX2FzX2J5X3NpZCwNCj4mc2lk
KTsNCj4+IC0gICAgcy0+dnRkX2FzX2NhY2hlW2J1c19udW1dID0gdnRkX2FzOw0KPj4gKyAgICBy
ZXR1cm4gZ19oYXNoX3RhYmxlX2ZpbmQocy0+dnRkX2FkZHJlc3Nfc3BhY2VzLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdnRkX2ZpbmRfYXNfYnlfc2lkX2FuZF9wYXNpZCwgJmtl
eSk7DQo+PiArfQ0KPj4NCj4+IC0gICAgcmV0dXJuIHZ0ZF9hczsNCj4+ICtzdGF0aWMgVlREQWRk
cmVzc1NwYWNlICp2dGRfZ2V0X2FzX2J5X3NpZChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90
IHNpZCkNCj4+ICt7DQo+PiArICAgIHJldHVybiB2dGRfZ2V0X2FzX2J5X3NpZF9hbmRfcGFzaWQo
cywgc2lkLCBQQ0lfTk9fUEFTSUQpOw0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgdm9pZCB2dGRf
cHRfZW5hYmxlX2Zhc3RfcGF0aChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNvdXJjZV9p
ZCkNCj4NCj4tLQ0KPlJlZ2FyZHMsDQo+WWkgTGl1DQo=

