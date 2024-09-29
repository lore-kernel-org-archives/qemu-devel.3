Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45F6CF6491
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 02:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sujbD-00010J-Ff; Sat, 28 Sep 2024 22:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sujbB-0000zl-Th
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 22:23:50 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sujb9-0004WB-Fk
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 22:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727576627; x=1759112627;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=83bi+pRirVQgoNNkDaSRgA6KQ9xZpV/OYY7b8f7PCJM=;
 b=TcjizlEflM6Id6bFm3wsS8OGqZIDOJXCXAAGBZInrXBjGET5vNTv9a8d
 OYXTojE2199B7unj6iO6fpiKXt3namW0zYfidyUJLiAKMDgYXmU5sJfB/
 TjZGF2OInV7wZgY2PfRY7m3IeYV7SYkNkp1/DXQCer9BG0rwWyrcEvkFb
 uSK0c7KF+G0lTiigcGsgOP00vg1uHY6O4kDptkfTQc7OUagtq/r9GI4tE
 drZ7eOSdO8RvANWaKj+B4NXgcR1E6aOGCHkSBWkYFS6dMy8yp3JysTHVh
 Yqyi0XhQLFN9ptk7cHz0JXGp7tXQF2TMFjRFQ6KSHAtf1i4oeEpq6zejZ A==;
X-CSE-ConnectionGUID: /jcEB5uTSamUHgBFsgZ0Dg==
X-CSE-MsgGUID: cdE8EVkORJ6ndc2JtDqJUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26637097"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; d="scan'208";a="26637097"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2024 19:23:43 -0700
X-CSE-ConnectionGUID: 6OVHWTjTQ+GxDxin9aSVLg==
X-CSE-MsgGUID: MZv0EnlrR6ugfuA5CAFhQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; d="scan'208";a="77445565"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Sep 2024 19:22:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 28 Sep 2024 19:22:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 28 Sep 2024 19:22:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 28 Sep 2024 19:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0Yc5NlvSn1l6RkMUXQMfNFYhsVEh3+0QBN/Hp2PYhcXZBESMKwypIQzp5QiAd+Z2mXNZFFUB5P32S3uz/htBlUzj3CtoHrjA92GUd18K2RV8SYhBDuMmfgIwwjZJ6qDRyaqQtKV53YJk9TMskTcZNj4ksdliDX6kco4EyOy3DBq9fhObMJjUeyingDd2F2+AcfC5rW71U4ZHo/w+NbIiMoMFwvls1jbMAmPK5UAGyW08yzFaICHeO9nFOsw1wIxUoBJKofAKdXWIwaFN+MvhHOMFRUtYJlr7YhblNJNmUGbFxRPxVVsWLybxBr02lSQ2LaMIVnnCpPVpDrFj9/yMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83bi+pRirVQgoNNkDaSRgA6KQ9xZpV/OYY7b8f7PCJM=;
 b=bn5EmIdNdPjIp5sqmn8WW0D3puZtx/cV/I5eUpf/fXyp6zbzYPIjq3Hl2SjyxbBFbJ5dXI8Seagog6LaCaKw7SjTc+vZhf/I6RDFnh8tQcmF9bYLFZXu5BXs5DQRMPIYKhyzD+H6ZU1SePydTfW5tBPtHUWAB5LJflAWZBoM15vTZCyqK/ldrmq9NLmHZD5eV0iEN6Lybliyh7DItqQvzPNNFb5XEWT/Rg7yjCx2X2yMhWf+Z5DelpMkyJRMkVKQEApUWl9VHoELWlzjPFDek01Pj2eAV8MCFPjVM43PPKke9y2CeBCg4QsxEviN0ZwVCu9AUGM8SNg4b/AYes204A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sun, 29 Sep
 2024 02:22:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 02:22:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Baolu
 Lu" <baolu.lu@linux.intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Thread-Topic: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Thread-Index: AQHbBAs7dSCINsfvkEGytF87b/oqprJrHaMAgAAom3CAAtf8gIAABcsQ
Date: Sun, 29 Sep 2024 02:22:35 +0000
Message-ID: <SJ0PR11MB6744FD2943387D1C22D74B4492752@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-13-zhenzhong.duan@intel.com>
 <CACGkMEscZB9f6toOcm_+3pQknDgnp3r6MvzbejB9BVEsKz7rjA@mail.gmail.com>
 <SJ0PR11MB67441D158F394CE1EA620CA9926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuXX6UE0=dNjeNJ5rHxkJADUrTG0tU1Cd1n0cvik5NnKg@mail.gmail.com>
In-Reply-To: <CACGkMEuXX6UE0=dNjeNJ5rHxkJADUrTG0tU1Cd1n0cvik5NnKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5977:EE_
x-ms-office365-filtering-correlation-id: 8fa451ff-4963-4317-54ac-08dce02d94c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dGNMS3U2M1ZQZG1wMDhsYnl3RC9yNHNLQ1pUcXBORGR1YmNKQVUwejdwVE14?=
 =?utf-8?B?cTRUOXVTZzBiaXZrMU53NHIxdi9xMUF1UlRCUGRkS0dwREZQZEJ5ZnBOc2Yx?=
 =?utf-8?B?bEIwTi9RU09ZUHlOOU51czI4b0VocHB3TGowWFJHUHpjb1ZUUUhvZnZ2L1px?=
 =?utf-8?B?OEFNYi9TdGViRTJzd3R2VHNIbWtsRjFxQlVqcFRoTVBDNG5kVTRRZE91WEU3?=
 =?utf-8?B?VVVQNWQ1akJ4SStCYlREUlk0L2tjQnR1d2owTFBjNWdDSXFsY1VtaWVOelk1?=
 =?utf-8?B?dVg1WGIxMUNBQXdKU0pCcDUzY0ZreFpaS2l0cGd5SnlKYW9IaXRzTk9QbEdH?=
 =?utf-8?B?eDYyT2hBSzQ2MVpQSEc1MndGKzdtTkVQYitvQ1N2KzQ0Y1hsb0laK0N2U3lK?=
 =?utf-8?B?NGVPVkVBYmZYYmRLUHFsanVIQ1k5QkY2TS9ZakpFM09HNjFpMlhyNTJZL090?=
 =?utf-8?B?aE5oRVEvZW9ZYjBkQTVGaUdCdXI3Qks4YjRHeGw0QWd0SjhjazB5WUtRZVZO?=
 =?utf-8?B?THhBaUVuM3ZqNzJ5c2hVNnBPWnByaW56QTNxUGhyRkRXelJxUDFEZVhjQUMv?=
 =?utf-8?B?Sk9kTTBvalRsSDRYWXh6cmdPV3ZjNzl4dDdQUDMydXJNUmVIWVRhamxKdHc4?=
 =?utf-8?B?ZVFpVTI0NjkyMzJld2VTMnpmTmV1aXNmNm1GdFBBNWJZVDVMWEZwbUpSa3Ri?=
 =?utf-8?B?QW1icGlJWXk5MmNmQ1hza00raU1NWExVTENUcXFMcytIN2J0ZHE1N0ZyejRm?=
 =?utf-8?B?aFJWeW8rWC8zRnI1OHBOT3VIaWZVd1pRS2tlZGdGWTVKTHoydlhSK1JDblVz?=
 =?utf-8?B?dmxUT25lQXNvNW5XdWZPcjVjTFZGdUdmbkM1enh6ZXJtd2E0ZWFpNWxWVGph?=
 =?utf-8?B?NUIzQXNhSjllakliTFY3c3lEd1J6MkhkWFZjL3R6dDB0YmE4OXJHQ3hkTzkv?=
 =?utf-8?B?YXY5eEZFRU54czU4dGpJQkRFL24xMXRPczNxUWV4VUJXVzRuOXZnSmpCQkg0?=
 =?utf-8?B?bDl2Z2RWeW1GZitFZmR1c0pZZ2tzOUE4b2dqbjBvMStjS3RrSmptSmFVbWJC?=
 =?utf-8?B?S05ZNnR0V0dVQjVBTjI3MDROMDdvODV0WkdhTzdTZWE3bE5EdVRocFdUYnRT?=
 =?utf-8?B?QWhjMUE3OFFCTnowSnZqQVhac0RyL2ZQTTZScjFQZTRaZlp1TFZrYkJLWVRU?=
 =?utf-8?B?ZG5CYjIxbE14aFFCM2ZoZGJSR0tQbmtSM0llM3FiWFlhMlhmb2ZoUGcwSkVW?=
 =?utf-8?B?V291TXZuNzJ6VjFCaWdHSE85ZlQ4dmxybm1OczFWT0c2V0g0RUVFbTFNNkFV?=
 =?utf-8?B?RnRmY0tocUVvYnltUFFBMjZHbmxrSlBDZGtlaFRDV0I1elVOLzNXQi9ZSW1Z?=
 =?utf-8?B?YTFoYkZGL2tvUG9HQ0Jwd3hIVnJMY0NLVDI4K21seldxY3V6WThIS3hVSTFs?=
 =?utf-8?B?OU5oM0xFNTZrZFBqZ2JBMXhqQzhaekl1VlhJcHoxdk5Ua0UyaG5aeWFmOTFZ?=
 =?utf-8?B?U2lDMHhXemFCL2JuRkJuWHkxcDA4aGphWldnaGNqWmdkci9icThsQnBiSVBL?=
 =?utf-8?B?LzBUVXdHM3hReTRRSVJ0MFVSdlUrQUxxZUtXT1dnT3FUb0Rzc0pwZG93dUpT?=
 =?utf-8?B?MXpMQ0VvcG5uSnRBUHN6NWlsYzVDeU9abWEySGsxNEtXaHQyVENCUm9qeVlM?=
 =?utf-8?B?NzRLeTF3WUE0Q3VNejBuL2NBQTQ0b25nNlhOaU5YUUgrUFBUMGk5dk9rOXhB?=
 =?utf-8?B?bTN6Q09FMVBCV28wYjM1NDlCdE1vSi9tT1E2N0VxaGI4dG8yKzZ2dmg0bUlh?=
 =?utf-8?B?WmFYMlFuUVpYdFVFanRNdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ui9GY29PRVNCZkxJK1JxZGhvYmswa01va3hYS3dualpiOVFvR2RvTXk3TGRi?=
 =?utf-8?B?Mi9ZTnFQVU54RG9oby9KTS9DcnF3WUFEWjhLTVp3L2EvSGVJSjJ4WWhCSjhx?=
 =?utf-8?B?RjFJMkwyUThhc1VJUGlQdTJjSko4T1pyRjIxOUJCajNWZXFXVGxyQThGdklG?=
 =?utf-8?B?ZWZyaS9sdG8rT2w4NHpGckd2NEQybjJJelNLaXNtTnp1bnV4L0RXc1FBay9Z?=
 =?utf-8?B?QU1WL0xOaHVXZzdVN1MyLzl0T3pJbkN3dG1KaTJzVUVCbW56c05xWkw5SEs3?=
 =?utf-8?B?eHp6UWxycC9nT3VrWGp6a2Z2SkVoRitZWDF4NUN1K0IzUThER2dSVjB5eWx0?=
 =?utf-8?B?UlduSXQwYko1R3Y3aTMvcGtHVEFNYlIrNEF3dkhGUFVSSm9YTXZDdDAwWDR2?=
 =?utf-8?B?aVdpVDJOQXdGTm9uRys1RjUrbmo3U1pna0xQSzlheDR4WkJ0SlZTMExyWkRi?=
 =?utf-8?B?THdKK0NIaXJhQ2pRVFVRc1hGWXlONURnMzdIUmtVVHVTMHA0TmpyYyt2UHNx?=
 =?utf-8?B?SEFyZlVwOWh1cWUwdlNrbmJHK0tEK2ZMNS9OZ2swSGhydlpnZFdscmp6VzJq?=
 =?utf-8?B?Z2llOGdtR2E5OGFoYzJFVlk0TTdGS0k0akdGNU03RGp6OWlKb0xIbVgrVE9r?=
 =?utf-8?B?SDg5UVU1bDlBNGVSMGJLNHZCNkcydjZ6ZHZYNzN4TWN4aURiOVJTd0NWdWpY?=
 =?utf-8?B?b2VSZVg5cG9mVml6TkxkZ25MdGd2VVhnVHowdWFOWVUzSkdBRGdjSTd3WW1v?=
 =?utf-8?B?T2ppcVZTMkd6OVdrUG9tVlhiazdiN2wwRFM1ckMybXI3aXVWOG9wU3pzQytV?=
 =?utf-8?B?d0dmeXlJNGc2b1hiT3ZaNndoVG5jUmc5NGlnRjduQVNodDNLNzZyMEhYQ0hF?=
 =?utf-8?B?eTF6YkZHakZRMXZ5MnZMMlJQUHF0WWN6SUIwc1ljY2NZcVpQd1NNdDE5YU9k?=
 =?utf-8?B?TVV3bnptRHpGYUJHUnlacFJKVWNPcnhzQTJUWlBkM2FFa0xtc2M2NVVnVHB4?=
 =?utf-8?B?UjZ2N1dTMXkzRlZDamlDMHNmSnZOL3A5L0VrbmRmQlpLLzZ3dnNnNHlDaU5K?=
 =?utf-8?B?NlphcGpqdjZTTnNqU3gwczh0SDhtYWVQMGhnUjNGSi9BdFNaWi9BaTJvR2ZK?=
 =?utf-8?B?VG9CbTZIcnVFN3htVzl2b0pXY2hwNklqK0E0TGl5Y1pjbC9LMnFXYTF1UTdr?=
 =?utf-8?B?aVp1WjVDM0ZqVWxOT0Y0QyttU1N3OUpmS00vQ0VOUXRjSkpTS0V2NlNmcS91?=
 =?utf-8?B?dWNaTmNJUnRCZzlHOVVBT3hpYXpXMzJQeExKa1NTSkpqMVVMT1Z5TUtnZzEv?=
 =?utf-8?B?OFk4M0tsUzZ5MDdqVGRBMDd4YlNUNXFTYVFaVjlwQ0RJa0FydGxqZnp2b3pq?=
 =?utf-8?B?TFVDeFdoNEtsSkpIQW5rY3pmYmtHR0czcjYwZjFUTyt6NWlMSDFWTWVoL2Ez?=
 =?utf-8?B?TFNUUlM0NTdvU2lQSWZjbXF0R2crRHZUTllReC8wNU5KODdzeXhtNDJUbFRZ?=
 =?utf-8?B?RlUyTEhSLzhHOFovR29FYWwvRHNJOXdrdGROaVV3YWJ1K2JlVVlQdzBFRWRD?=
 =?utf-8?B?czBXdGI4SURUNWpTN0JYSDlRSy95REllNk9oSGxENTdscGN3clpsLzFRbzdY?=
 =?utf-8?B?cWF2VmJISHo1QU91MHdwR00zWXVjYUVqd2loKyt4WFJ0L2tKQmxVaXpQemU5?=
 =?utf-8?B?Yzh0bVJUNjJVOGZOWjlIZTJhd2VDOWFJUTdPd09DWGNjQXRxM3BraTg4KzBB?=
 =?utf-8?B?aE9KejlUZnpmVUhkT2ZndEs3UW0reTR6U0ZSRGxLUWI5cnBVVW5pQUxMNlFh?=
 =?utf-8?B?VjBFOG9HTmpNRG5vVFdMZEpBYUE0aWw2cUJuWkZWQ0xtcEdDVXNZdFROUENj?=
 =?utf-8?B?VHdrZXA1M2Z0Y0NYNjUxemlaWmE0VVlVZDduR05NcVprZVFJUmhMcGhZZ2hs?=
 =?utf-8?B?ZzhxalhUMlhINHNHRlpZS0dOL0V0cmdrY2JBRlBtaGY4T2dnQk55cU0zRUlT?=
 =?utf-8?B?SEtRTDJ0THlrQlJLTWRMbll0UnlEZ0pweDIxd0FsKzUraTdHYlVzZDMyU2N1?=
 =?utf-8?B?MHlCNW83VGdYR1ZqeThpUk5CYVAvNHdUMWdkdXFhYXlSVEdrUEMrYUIvNTBW?=
 =?utf-8?Q?AKBXb+9+YcQrqVe8fT1qzEDRw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa451ff-4963-4317-54ac-08dce02d94c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 02:22:35.3678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AH/XhE6yUdwmm4J5PPoNhYHGIcy7Mf7reqPJET6a/bkuF0jTqPhNPXfcz9t2xBWaeK6K7pUWSNp44amHqqQ/WZxXDcJlxltgi0X/c8fTquM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxMi8xN10gaW50ZWxfaW9t
bXU6IEFkZCBzdXBwb3J0IGZvciBQQVNJRC1iYXNlZA0KPmRldmljZSBJT1RMQiBpbnZhbGlkYXRp
b24NCj4NCj5PbiBGcmksIFNlcCAyNywgMjAyNCBhdCAzOjE44oCvUE0gRHVhbiwgWmhlbnpob25n
DQo+PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+DQo+PiA+LS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID5Gcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPg0KPj4gPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTIvMTddIGludGVsX2lvbW11
OiBBZGQgc3VwcG9ydCBmb3IgUEFTSUQtDQo+YmFzZWQNCj4+ID5kZXZpY2UgSU9UTEIgaW52YWxp
ZGF0aW9uDQo+PiA+DQo+PiA+T24gV2VkLCBTZXAgMTEsIDIwMjQgYXQgMToyN+KAr1BNIFpoZW56
aG9uZyBEdWFuDQo+PiA+PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4gd3JvdGU6DQo+PiA+Pg0K
Pj4gPj4gRnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+PiA+Pg0KPj4gPj4gU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGll
dS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS0NCj5kcmlmQGV2aWRlbi5jb20+DQo+PiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4g
Pj4gLS0tDQo+PiA+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMTEgKysrKysr
KysNCj4+ID4+ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA1MA0KPj4gPisrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ID4+ICAyIGZpbGVzIGNoYW5nZWQsIDYx
IGluc2VydGlvbnMoKykNCj4+ID4+DQo+PiA+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oDQo+PiA+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+
ID4+IGluZGV4IDRmMmMzYTkzNTAuLjUyYmRiZjNiYzUgMTAwNjQ0DQo+PiA+PiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ID4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPj4gPj4gQEAgLTM3NSw2ICszNzUsNyBAQCB0eXBlZGVmIHVuaW9uIFZU
REludkRlc2MgVlRESW52RGVzYzsNCj4+ID4+ICAjZGVmaW5lIFZURF9JTlZfREVTQ19XQUlUICAg
ICAgICAgICAgICAgMHg1IC8qIEludmFsaWRhdGlvbiBXYWl0DQo+RGVzY3JpcHRvcg0KPj4gPiov
DQo+PiA+PiAgI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCICAgICAgICAgICAgIDB4NiAvKiBQ
QVNJRC1JT1RMQiBJbnZhbGlkYXRlDQo+RGVzYw0KPj4gPiovDQo+PiA+PiAgI2RlZmluZSBWVERf
SU5WX0RFU0NfUEMgICAgICAgICAgICAgICAgIDB4NyAvKiBQQVNJRC1jYWNoZSBJbnZhbGlkYXRl
DQo+RGVzYyAqLw0KPj4gPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVl9QSU9UTEIgICAgICAg
ICAweDggLyogUEFTSUQtYmFzZWQtRElPVExCDQo+PiA+aW52X2Rlc2MqLw0KPj4gPj4gICNkZWZp
bmUgVlREX0lOVl9ERVNDX05PTkUgICAgICAgICAgICAgICAwICAgLyogTm90IGFuIEludmFsaWRh
dGUNCj5EZXNjcmlwdG9yDQo+PiA+Ki8NCj4+ID4+DQo+PiA+PiAgLyogTWFza3MgZm9yIEludmFs
aWRhdGlvbiBXYWl0IERlc2NyaXB0b3IqLw0KPj4gPj4gQEAgLTQxMyw2ICs0MTQsMTYgQEAgdHlw
ZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7DQo+PiA+PiAgI2RlZmluZSBWVERfSU5W
X0RFU0NfREVWSUNFX0lPVExCX1JTVkRfSEkgMHhmZmVVTEwNCj4+ID4+ICAjZGVmaW5lIFZURF9J
TlZfREVTQ19ERVZJQ0VfSU9UTEJfUlNWRF9MTyAweGZmZmYwMDAwZmZlMGZmZjgNCj4+ID4+DQo+
PiA+PiArLyogTWFzayBmb3IgUEFTSUQgRGV2aWNlIElPVExCIEludmFsaWRhdGUgRGVzY3JpcHRv
ciAqLw0KPj4gPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9BRERS
KHZhbCkgKCh2YWwpICYgXA0KPj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDB4ZmZmZmZmZmZmZmZmZjAwMFVMTCkNCj4+ID4+ICsjZGVmaW5l
IFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfU0laRSh2YWwpICgodmFsID4+IDExKSAm
DQo+MHgxKQ0KPj4gPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9H
TE9CQUwodmFsKSAoKHZhbCkgJg0KPjB4MSkNCj4+ID4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19Q
QVNJRF9ERVZJQ0VfSU9UTEJfU0lEKHZhbCkgKCgodmFsKSA+PiAxNikgJg0KPj4gPjB4ZmZmZlVM
TCkNCj4+ID4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfUEFTSUQo
dmFsKSAoKHZhbCA+PiAzMikNCj4mDQo+PiA+MHhmZmZmZlVMTCkNCj4+ID4+ICsjZGVmaW5lIFZU
RF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfUlNWRF9ISSAweDdmZVVMTA0KPj4gPj4gKyNk
ZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9SU1ZEX0xPDQo+PiA+MHhmZmYw
MDAwMDAwMDBmMDAwVUxMDQo+PiA+PiArDQo+PiA+PiAgLyogUnN2ZCBmaWVsZCBtYXNrcyBmb3Ig
c3B0ZSAqLw0KPj4gPj4gICNkZWZpbmUgVlREX1NQVEVfU05QIDB4ODAwVUxMDQo+PiA+Pg0KPj4g
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4gPj4gaW5kZXggZDI4Yzg2MjU5OC4uNGNmNTY5MjRlMSAxMDA2NDQNCj4+ID4+IC0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+PiA+PiBAQCAtMzAxNyw2ICszMDE3LDQ5IEBAIHN0YXRpYyB2b2lkDQo+PiA+ZG9faW52
YWxpZGF0ZV9kZXZpY2VfdGxiKFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9hcywNCj4+ID4+ICAg
ICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXUoJnZ0ZF9kZXZfYXMtPmlvbW11LCAwLCBldmVu
dCk7DQo+PiA+PiAgfQ0KPj4gPj4NCj4+ID4+ICtzdGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19kZXZp
Y2VfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERJbnZEZXNjICppbnZfZGVzYykNCj4+ID4+
ICt7DQo+PiA+PiArICAgIHVpbnQxNl90IHNpZDsNCj4+ID4+ICsgICAgVlREQWRkcmVzc1NwYWNl
ICp2dGRfZGV2X2FzOw0KPj4gPj4gKyAgICBib29sIHNpemU7DQo+PiA+PiArICAgIGJvb2wgZ2xv
YmFsOw0KPj4gPj4gKyAgICBod2FkZHIgYWRkcjsNCj4+ID4+ICsgICAgdWludDMyX3QgcGFzaWQ7
DQo+PiA+PiArDQo+PiA+PiArICAgIGlmICgoaW52X2Rlc2MtPmhpICYgVlREX0lOVl9ERVNDX1BB
U0lEX0RFVklDRV9JT1RMQl9SU1ZEX0hJKQ0KPnx8DQo+PiA+PiArICAgICAgICAgKGludl9kZXNj
LT5sbyAmIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfUlNWRF9MTykpDQo+ew0KPj4g
Pj4gKyAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBpbnZhbGlkIHBhc2lkLWJhc2VkIGRl
diBpb3RsYiBpbnYgZGVzYzoiDQo+PiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAiaGk9
JSJQUkl4NjQgIihyZXNlcnZlZCBub256ZXJvKSIsDQo+PiA+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICBfX2Z1bmNfXywgaW52X2Rlc2MtPmhpKTsNCj4+ID4+ICsgICAgICAgIHJldHVybiBm
YWxzZTsNCj4+ID4+ICsgICAgfQ0KPj4gPj4gKw0KPj4gPj4gKyAgICBnbG9iYWwgPSBWVERfSU5W
X0RFU0NfUEFTSURfREVWSUNFX0lPVExCX0dMT0JBTChpbnZfZGVzYy0NCj4+aGkpOw0KPj4gPj4g
KyAgICBzaXplID0gVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9TSVpFKGludl9kZXNj
LT5oaSk7DQo+PiA+PiArICAgIGFkZHIgPSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExC
X0FERFIoaW52X2Rlc2MtPmhpKTsNCj4+ID4+ICsgICAgc2lkID0gVlREX0lOVl9ERVNDX1BBU0lE
X0RFVklDRV9JT1RMQl9TSUQoaW52X2Rlc2MtPmxvKTsNCj4+ID4+ICsgICAgaWYgKGdsb2JhbCkg
ew0KPj4gPj4gKyAgICAgICAgUUxJU1RfRk9SRUFDSCh2dGRfZGV2X2FzLCAmcy0+dnRkX2FzX3dp
dGhfbm90aWZpZXJzLCBuZXh0KSB7DQo+PiA+PiArICAgICAgICAgICAgaWYgKCh2dGRfZGV2X2Fz
LT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQpICYmDQo+PiA+PiArICAgICAgICAgICAgICAgIChQQ0lf
QlVJTERfQkRGKHBjaV9idXNfbnVtKHZ0ZF9kZXZfYXMtPmJ1cyksDQo+PiA+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9kZXZfYXMtPmRldmZuKSA9PSBz
aWQpKSB7DQo+PiA+PiArICAgICAgICAgICAgICAgIGRvX2ludmFsaWRhdGVfZGV2aWNlX3RsYih2
dGRfZGV2X2FzLCBzaXplLCBhZGRyKTsNCj4+ID4+ICsgICAgICAgICAgICB9DQo+PiA+PiArICAg
ICAgICB9DQo+PiA+PiArICAgIH0gZWxzZSB7DQo+PiA+PiArICAgICAgICBwYXNpZCA9IFZURF9J
TlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfUEFTSUQoaW52X2Rlc2MtDQo+PmxvKTsNCj4+ID4+
ICsgICAgICAgIHZ0ZF9kZXZfYXMgPSB2dGRfZ2V0X2FzX2J5X3NpZF9hbmRfcGFzaWQocywgc2lk
LCBwYXNpZCk7DQo+PiA+PiArICAgICAgICBpZiAoIXZ0ZF9kZXZfYXMpIHsNCj4+ID4+ICsgICAg
ICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+ID4+ICsgICAgICAgIH0NCj4+ID4+ICsNCj4+ID4+ICsg
ICAgICAgIGRvX2ludmFsaWRhdGVfZGV2aWNlX3RsYih2dGRfZGV2X2FzLCBzaXplLCBhZGRyKTsN
Cj4+ID4NCj4+ID5RdWVzdGlvbjoNCj4+ID4NCj4+ID5JIHdvbmRlciBpZiBjdXJyZW50IHZob3N0
ICh3aGljaCBoYXMgYSBkZXZpY2UgSU9UTEIgYWJzdHJhY3Rpb24gdmlhDQo+PiA+dmlydGlvLXBj
aSkgY2FuIHdvcmsgd2l0aCB0aGlzIChQQVNJRCBiYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24pDQo+
Pg0KPj4gQ3VycmVudGx5LCBpdCBkZXBlbmRzIG9uIGlmIGNhY2hpbmctbW9kZSBpcyBvbi4gSWYg
aXQncyBvZmYsIHZob3N0IHdvcmtzLiBFLmcuOg0KPj4NCj4+IC1kZXZpY2UgaW50ZWwtaW9tbXUs
Y2FjaGluZy1tb2RlPW9mZixkbWEtZHJhaW49b24sZGV2aWNlLWlvdGxiPW9uLHgtDQo+c2NhbGFi
bGUtbW9kZT1vbg0KPj4gLW5ldGRldiB0YXAsaWQ9dGFwMCx2aG9zdD1vbixzY3JpcHQ9L2V0Yy9x
ZW11LWlmdXANCj4+IC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PXRhcDAsYnVzPXJvb3Qw
LGlvbW11X3BsYXRmb3JtPW9uLGF0cz1vbg0KPj4NCj4+IEl0IGRvZXNuJ3Qgd29yayBjdXJyZW50
bHkgd2hlbiBjYWNoaW5nLW1vZGUgaXMgb24uDQo+PiBSZWFzb24gaXMgbGludXgga2VybmVsIGhh
cyBhbiBvcHRpbWl6YXRpb24gdG8gc2VuZCBvbmx5IHBpb3RsYiBpbnZhbGlkYXRpb24sDQo+PiBu
byBkZXZpY2UtcGlvdGxiIGludmFsaWRhdGlvbiBpcyBzZW50LiBCdXQgSSBoZWFyZCBmcm9tIFlp
IHRoZSBvcHRpbWl6YXRpb24NCj4+IHdpbGwgYmUgZHJvcHBlZCwgdGhlbiBpdCB3aWxsIHdvcmsg
dG9vIHdoZW4gY2FjaGluZy1tb2RlIGlzIG9uLg0KPg0KPkdyZWF0LCBpZiBwb3NzaWJsZSBwbGVh
c2UgY29weSBtZSB3aGVuIHNlbmRpbmcgdGhvc2UgZml4ZXMuDQoNClN1cmUsICtZaSwgQmFvbHUg
Zm9yIHRoZWlyIGF0dGVudGlvbi4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

