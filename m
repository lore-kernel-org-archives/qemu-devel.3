Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A361C83F27
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFFE-0001yz-7P; Wed, 16 Jul 2025 23:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucFEx-0001tY-8a
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 23:25:01 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucFEu-0006Sb-Gc
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 23:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752722696; x=1784258696;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bLtn0D10XZlc70rb+xNrwkhjwSqjdQVHgAnak8+xbIs=;
 b=Vn1GloVTxH13KPvbigv7BCKB19riSlrBKAq7Fr5r5NM+Cc6sdC1oHlFp
 3ajWHLXNgoz/8+mbQkUlgoNxv+q5pYoT33sQzi9WbRbTma3QIOa3QooHP
 OncVxZtMPZKreWr3ilxYUsBj0O/oJXlq9Uh140oQ/s/vC22BJvF+l1JU6
 ekuG++Fatl1bYt9gzhdwq23mp6/y1qc5liMBcm8lUEQmBlvpfFkAZEQhu
 f3b0MyIf3vrsjFMqYCrGmaA/ntAnrp96vgGXEBP09bcdWsJlBDwHSfY8r
 a8T4jeVMBcNDoE17cLN+nyx2D+pT2XMAZszsjJmNqogu2rUnlAPt7YVZW w==;
X-CSE-ConnectionGUID: 5zFPDsLOR8aVOZSyQ5eR7w==
X-CSE-MsgGUID: 2t0FrAFKT0Wfr/ISk4M30w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54201312"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="54201312"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 20:24:53 -0700
X-CSE-ConnectionGUID: Clx2sQ7XTxuvRQub6q1Xiw==
X-CSE-MsgGUID: n5h28gfAT5a/+n0iXD6rKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="158382740"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 20:24:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 20:24:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 20:24:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 20:24:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDrhGbLtp10Ru0MZk7Xf6eK3UW9wPv+pmNZKvtSkZltuRWszKOT0Tzx8YQ2tYrQ6x3XLVfFKqYL0jYdBLU8Sc2PcIWe9/uhPgiAm1QhKL+5ALVgoArN/qJO/fYLlV08T7TL6fvF65XiX7IMu68NohyG+/nd+J5FdxO6+gFes2iwUCEomnRh6QGmKDbqVy/0BZDrgJd6LGX97/ul0cd4LZaPW+D3fU0FuHddY/W0hNgY7Bckz3glaAAyF21gmMZTJGJ01/hCSVmISe1WmDXWfJSjZZRedVPCACbZkVz9AmQ4dSowPD/twYi+z4/VpnbLuSPb7JnK3XOXC7yMVkolTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLtn0D10XZlc70rb+xNrwkhjwSqjdQVHgAnak8+xbIs=;
 b=aoZNYktD4bLsyOTDp5CIfRRnNlp0+GfsE5utbu+xz4fdJxQQvQmR6eqByMqljyBe+Txkhi/8WyTYef/MBN6HXGCy7d17LA2o2UTeV1fbI5ZvOfxqftQI0yF9RsvD/VBgwkkbitM8YoepwKvVFI75zjQuxPKCTX/FzpCfMNTQndnBSEMd1NWa1v7hzWzHk2CzYXHIubPVEyh8uM2QH3zRa3qPEDcp3yCb7qAZkON9A93bcoXUTqA7cr0Y44dDPFYVttCP3Xfh1JALstJ2waQ6Vf9WprAbCwtODOI0if4fErUDPF+5revZUv7yBI7tv0wjT7KPOZivRLGANXjrgrZmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS4PPF900531A26.namprd11.prod.outlook.com (2603:10b6:f:fc02::3b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 03:24:07 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 17 Jul 2025
 03:24:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 08/20] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
Thread-Topic: [PATCH v3 08/20] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
Thread-Index: AQHb7/hrvcPYlz6LM06YitQhjRC4lbQ0jv0AgAEk7fA=
Date: Thu, 17 Jul 2025 03:24:06 +0000
Message-ID: <IA3PR11MB913617111E1D82B2010DFAF49251A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-9-zhenzhong.duan@intel.com>
 <471cb345-2d67-4a3a-b555-e1da3e57b0e9@redhat.com>
In-Reply-To: <471cb345-2d67-4a3a-b555-e1da3e57b0e9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS4PPF900531A26:EE_
x-ms-office365-filtering-correlation-id: c926384b-638d-4806-4215-08ddc4e16310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WUxWbjl2YVIyTFQwTU8xL2Rib2thK2FJWi8zWDAzOGtVMG51cUlqSy9Jdm9m?=
 =?utf-8?B?T0lYM0xYK3ZrWTFKRVBjOU5OUGJOaG9aOHExQzlNT24rd2pUanZLdGlFd0Z3?=
 =?utf-8?B?NTVBakRNYk5PSkNweXFQczh1S0ZmUTNPZ01SanRGeGtFcG1nbm1uZjhaRU1T?=
 =?utf-8?B?aER5eHU5eGRIcytUWjhOYTUweHJjRy9JVVgrRFZNODdqVms0bGZxeFljSmZ4?=
 =?utf-8?B?TXRYTERUWjhGeEFjdytveEtvWTM2T09YNmxCa0dONTllMU54OVl6ZnRhVE1z?=
 =?utf-8?B?R0dRaWU4OG9KbjF2eUJxV2kvbEZ2SFVYbEVZR3ZyemR4S1ozRDlPYmxwTzFN?=
 =?utf-8?B?NnlWbVl2dk11TVZJSHorQVpLMXpwSlZtMUJ2STFSZzJ0bTQwZlVIeklkM21u?=
 =?utf-8?B?TlVlN0x3SHplcTI4bk1Qd0t6SnVoclUySGFobDhQS3dod3FaZ3V3eTlhalpD?=
 =?utf-8?B?a1djajludkVMbWF6RWUrZ2x4QUs0UnVXYjY4ZXV1ZjM1NVowMlVQa2NoRFo5?=
 =?utf-8?B?cmFZS1MzY1I2KzhZQnpGa0preTRiUi9FRWxZazE4eDlQeWdSNzkrSEdaNjhD?=
 =?utf-8?B?WEV2QkdxMWJwU2UvUHduVUhJLy83amg0SzVGTmZyRktVZU9uckFWaklJR3po?=
 =?utf-8?B?ak4xaEsrUW5kUmZmVGhqSlJNZEZyOFdjaTVJQU1MKzhRYmxoL3EvdGZLWDNZ?=
 =?utf-8?B?ajlaMjIrUEpEaUExU0F4Z094ZUdVaUZTVkMycjR5QnM5RklqbnF2c0NDNkFM?=
 =?utf-8?B?UnZFSVRGRndKZkpzYVEzUjRQR0lwRGIvZXJjV3dTcGxDN1c2b0YreTRYKzh0?=
 =?utf-8?B?cXlybnlEOURpdTNCU25jVENRdGQxY1V2akhpSm1ycGcxaElNOThvbHpDdm9r?=
 =?utf-8?B?c3RvV1hGYm5sOXR3Q3FyNGM3MFczdlhwbFk5b1lHa1BEZFZMZEs2c3V3KzVS?=
 =?utf-8?B?cFJJWnlNUUtFZE55UnA4bUtnMmNsUW5ncHFOMjliNWwrSEdnR2dHY21yaWpp?=
 =?utf-8?B?RXJrdFlTbU0rNDhBN3hCSEd2K3FnMlQvZWQ0OW15Tm94TjU2MjVWM09NSUhY?=
 =?utf-8?B?QUY1WGZ3L2swMUkySHBaeFczMUdSdnIxR2h5SHVRbGx2c25DTjZTQWVjSnFk?=
 =?utf-8?B?TUJDYUhkOGdQQkxTQ29YY29PM0VPMDVKUE5KZ1l3T1V4bHV0dUxlWnNoTUJM?=
 =?utf-8?B?WGdHU00yVUc2b3JSdDBpQ2Y3U3RZNmhZS2ZWTzlXVGplK3ZGZjRsb1NDSzdK?=
 =?utf-8?B?Vkh1RmZUblJYZXNmdUUxeGMxZVdVTlprQ1E2VXI1NG9yNTJhdkpSZzBzeDFo?=
 =?utf-8?B?VHdIc0NQY1lXSnM0ZEJ1WmRlbHdnTFA2RVBuSE5PSkhpOHdNcnYrditIUHg3?=
 =?utf-8?B?dTdsc2lET25LMGNSTDN5VmdZT0ZQT0o0SExYaWRxZXhpdzdFU1FwUUQ5d0p1?=
 =?utf-8?B?bXhvdUYxN1FGNG5LU0xSdm1lS3NYNmdsSnRoa05kV1cvWTMwNXJzL2szelNw?=
 =?utf-8?B?RnppV3BQMkJ2SndieXMzd0lHdUtlRXhNK1ZQRzk4UUlTWC9rZnFhOCtTZGFL?=
 =?utf-8?B?WmtEZHphVkpnU3JGQWZ5RkZtTWpFcUJFb2FoUTN4T3pSdkhhM1pUNFFtQXVF?=
 =?utf-8?B?dng5QWZxRHo3RXdRNGdsNGlONUlKU1Fkd2xMR1JCUVBROTJ3T09xUUgrejIx?=
 =?utf-8?B?YTRCU0w1S2JoUTF0ai94MWpFM0VGR2V5VzRtb3RQZDVnM3d2bkFHdXZQT3N4?=
 =?utf-8?B?ZlA0elNUYlJxR1ZjdlN0bWMrd1lBeHFCSG5SSXltU09YU2NRSEpqSjRMWVVx?=
 =?utf-8?B?UDhGbklRbDU3K0VQTzBlSUt1ZFN4MHMzTU5nVE0zTWFqM2dqOWJCU0NBS2JV?=
 =?utf-8?B?aXRkUjZZWmhIUW1WUlJKWXMzWU0rWkJlT2p2V2pnQkw1NW82QW1aUU8wdlZ3?=
 =?utf-8?B?bjRaMThKK2s4MTA2SG5nZlZMcXJvR1RDRFB4VTZvajk1eXpoY3diNCtsQXNX?=
 =?utf-8?B?UkFEYWJvS093PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODZsZG9qRDF6b3hYK0F5RmNmVEJXY1doanZxYTliVHZEWXZHK2JqR2dYaVVC?=
 =?utf-8?B?QUZJTVQ5RUFZeUdNYU9HZmJRdFR3RlZFeDI5UDQ1RkRuT1N5eUhlK2N0LzBn?=
 =?utf-8?B?dVk2OExBSi9kQU9vOHlVeDd2OHRVNFV3L3J0d0Z3Y0Q4Tmd1UUZOanFhaFZP?=
 =?utf-8?B?Zll6cnc1VStzb2NXdWVzSUNZN29RTExxR3V3VThBdTMvbFY3NDEySStlN0Ux?=
 =?utf-8?B?dlFxT1VUTVVVdmRyMGl5TjVEZnFDemY1amU4YTNMUDF0SENrTkFGdjVUbkM2?=
 =?utf-8?B?alZmL1ZxVU9zVVUra0RFU2NwNGxnOW9sdmhjZE9ZaW5BRGxyY3pXUHZoVWdx?=
 =?utf-8?B?akpMMXE2ZG4ydDVvcnJRV1liR0MwZzIvOEhNTVg1ZzhDZlN2TTMxcGx2Mmk3?=
 =?utf-8?B?ZFRNN2pybnhVK1MrUTNhaEhzQmNPQkMrQzZOMEZCYVFpNGN6aTA1MXBsNGNW?=
 =?utf-8?B?UzZSSzdVWTBTZ3NVL0pWamlBWTRiTzN6RVFZcjZaZ2J1Yk9uUmRYY0RsU0x1?=
 =?utf-8?B?WjZLSnU0ZCtjeWVaaXk0UWlxSStXbXZDWU9VcHlOR0tlTzNWYTZFZXRSUWhI?=
 =?utf-8?B?RWZyK25NTHRmbnZSTmRxV0RUQStJcTFpSG5IeWptU0JrTENrc09UUTZqeTdN?=
 =?utf-8?B?Q2RKMzNDdzBNZUxOdFU0alpiVGx1Y2tBWXZKWSs0WGxwbWxvQ09mVWl4ajlT?=
 =?utf-8?B?OEpXS1NuNEIxeWZxbnQ4OGtnT1lOOEV4anRzYThFSDNIR1ZhTStBQTdqNWpT?=
 =?utf-8?B?UTl0bHIzTEVEVVZOZ1VHM0NZMC9NdzcveC90YUlsWEM0UmMwdWtEQTNRKytm?=
 =?utf-8?B?czQvMy8vRll5bGphdFh0TkxBNmIrbGZYZkRES1FXZTZ6T3czMUEzZENpOS9s?=
 =?utf-8?B?dWRPVERpK0lPK0RyMGR1RGpmN1ZxU0pxeVBZK1NEUlcyYUZXM3BGMHgzZ1Iy?=
 =?utf-8?B?U0Z2SFMrRjFzM1lhd0xZaDhncUVFM3AyMTJpa0RodnB6ZitVTi9Eb3diSmps?=
 =?utf-8?B?UnoxeWkzN0dkWnI5SmJ0MVBLb0Q3U3J1dCs0Mk50bmtiMDJGMlRsazBmdWc0?=
 =?utf-8?B?a2VBdC9QZythNjZ1cmJrdWRzTGkwWU52NmpBK3R3c3h6ekVpaVRPYWJpZjRk?=
 =?utf-8?B?YWR2ME5vWVVvamsrTThMWXNjV2NyK1lyRzhvYThCU3lqRnQrYUxLNGpGUXl6?=
 =?utf-8?B?YnVVNS9NOWNOcGRld3dybWNRY0dqT2dJZHdGRzEyVHA2OXFMTGRDTnVYODFs?=
 =?utf-8?B?SDcycUY4Q2NiRk1WZ2tKVW5RaFloVSs0UGNZTitUc2FEaTZHNUIvSmtPSzRT?=
 =?utf-8?B?Mko3YnpEeXB0TkIvKzRSUklFcWxwWE14aW1UMyswWlBuWlV3VDhCUjVBaURD?=
 =?utf-8?B?UVREWUVXazYrZ1FCbTZ2emRHSUVDN1psZEc1QTQ2WVYwNHJ3M1RBUWlHRGJI?=
 =?utf-8?B?aEdIbitFc0lwbHBSYXNsRHI2WHArdTAwRTF5QTlJUjlGbHUyNWNrV2N4ZUtu?=
 =?utf-8?B?cGtiU3AzOWJHUW53R3V1dDlmaDJZRWFiS3NHeTRnTDRPSVdCNEJRSWIyYk5M?=
 =?utf-8?B?WjNodWlrTlBRWUJhVWJBV2Rxd1R5MHZjMUFpSm1FNG1OenpUYTArZmlwd2R6?=
 =?utf-8?B?dXZQUkV5dU1PL0tCRjhzb3JSNXM0RG5LWUFUN29Qb1huSlhsSXlpaVFmNWpv?=
 =?utf-8?B?bFJ4NzV4L0lTQlg3Q3R6WHIvT1hUY3R0cWQzLzdicFVOaTc4U0t2OXNJYWxF?=
 =?utf-8?B?bEZpZ2NPVDU3NUZSUk1Od3JWVVR0dU0zd2hTTFF2ZzR3aUgwSTBya1ByRWcv?=
 =?utf-8?B?SlJHVUtaRFAzdE1lSGh5MEVqYlZVOWZ4RjBWcTA0cHNsR2Z5T082dUdoUTdz?=
 =?utf-8?B?U1VyVFRJaVBDSW5sU1lFaU90ZGo4Y3VjalVyMDg2emNycVNFTkxaM0JwR1NB?=
 =?utf-8?B?MVdseDZSTWFVRklqdSs2bXNNbzVXYTluNklvdis2VVJnTGtwTWxkTkl5SG5i?=
 =?utf-8?B?bzhTTklYODBNWkJlOUlaL1Zza2laSEp4K0p4UTlIdkEwazBhVEY4RGx0VDB2?=
 =?utf-8?B?Zk9KbUFLK3ZPQlBOemlEZDVwUE0vcU4rSmNFYXRTWGlIZmZZOEk2N2lXRExB?=
 =?utf-8?Q?BN5ixMN4S0I19d15UI/ki3AO0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c926384b-638d-4806-4215-08ddc4e16310
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 03:24:06.5046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKhT9eywrP4tVNRuVnXNrlrn4EZI3L1JgQPIsfw6RWB630k6qocazgu8oWftaicLEEmW+tm5nZ/CEoT3Hb7QTS6kUL9rmFe5092c+hvE0n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF900531A26
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA4LzIwXSBpbnRlbF9p
b21tdTogRmFpbCBwYXNzdGhyb3VnaCBkZXZpY2UgdW5kZXIgUENJDQo+YnJpZGdlIGlmIHgtZmx0
cz1vbg0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiA3LzgvMjUgMTowNSBQTSwgWmhlbnpob25n
IER1YW4gd3JvdGU6DQo+PiBDdXJyZW50bHkgd2UgZG9uJ3Qgc3VwcG9ydCBuZXN0ZWQgdHJhbnNs
YXRpb24gZm9yIHBhc3N0aHJvdWdoIGRldmljZSB3aXRoDQo+PiBlbXVsYXRlZCBkZXZpY2UgdW5k
ZXIgc2FtZSBQQ0kgYnJpZGdlLCBiZWNhdXNlIHRoZXkgcmVxdWlyZSBkaWZmZXJlbnQNCj5hZGRy
ZXNzDQo+PiBzcGFjZSB3aGVuIHgtZmx0cz1vbi4NCj4+DQo+PiBJbiB0aGVvcnksIHdlIGRvIHN1
cHBvcnQgaWYgZGV2aWNlcyB1bmRlciBzYW1lIFBDSSBicmlkZ2UgYXJlIGFsbA0KPnBhc3N0aHJv
dWdoDQo+PiBkZXZpY2VzLiBCdXQgZW11bGF0ZWQgZGV2aWNlIGNhbiBiZSBob3RwbHVnZ2VkIHVu
ZGVyIHNhbWUgYnJpZGdlLiBGb3INCj5zaW1wbGlmeSwNCj50byBzaW1wbGlmeQ0KDQpEb25lLg0K
DQpUaGFua3MNClpoZW56aG9uZw0K

