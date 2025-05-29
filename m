Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834ADC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 06:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKX2O-0003Nd-Kz; Thu, 29 May 2025 02:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKX2L-0003NO-G4
 for qemu-devel@nongnu.org; Thu, 29 May 2025 02:46:45 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKX2I-0001Ay-JZ
 for qemu-devel@nongnu.org; Thu, 29 May 2025 02:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748501203; x=1780037203;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZzWwXFP8hNg922LGtJJqCYm9fz1mtrqqj+R/ti16A2M=;
 b=EGd7E+0y95tXaDCWlgvL5zASEi85s/43hxk4Ne8kBryyVAosq/ZI+Kyx
 BUk9JUo6ybyG+Z6tyuO1ARj6o3n9IK5QAzhHYhVNbAMxYfN2lpFtYDPQl
 QHKRToRKW28xDidS1/aD7Rvsq5PCOTKB6JJZG8n0/bz/kXIIxn0zXpQ9N
 YS2tvyyf4LJTxBBSc33HWP4YaXYwtMW0gKsMDftvCZh24upIW8wVpoZg1
 SW8CBo2B6b4Vm1v4WbGSK0wflKCCEbWjUuHpQ8yYt0GJcBloFIhU50il+
 S+k+8GPpLagD4QY9tkasfdjn3p1/vxs2ZimFTqRWgNvcAgobksT6Lz5Ia g==;
X-CSE-ConnectionGUID: Jc1En1S6R/isPhVsS/IweA==
X-CSE-MsgGUID: CMwaeUAOSQWLkqj04bxoGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61183227"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="61183227"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 23:46:38 -0700
X-CSE-ConnectionGUID: on06igGaRt+vqNC+/JYiCw==
X-CSE-MsgGUID: xbyNKwa9SzSgV2O1RaDrdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="144454073"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 23:46:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 23:46:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 23:46:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.55) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 23:46:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyWdB2MgzFZFEV4aTk01PF/mwHVwo5upH7Dv+qkO7IMzP4BqmLcipgm9cUY/bzoxpnLBzZVJjT9IIyOxKKYuUd9AO6ywMjA4BOwCy4tGS+SF6EogmUzCJqfh4BiatLLlFOEhMq+Qu24ixGf1iZLcbrGYKgE8T06v3gzwceOAZBrFp9GKtDYiRJf/NB9J1j5K1TR7hJOS+rMyke3pd36QzVE9SOIQ9B+FiqRMuajqa/T8dT7cfCC2m0Pbq3tL8HhLNg1D20c+qvNazHJADtRs6/LRV29aSs6xaosQP4ecnJ2JSCb9QI+KBB/T47LFvBbnpL/9BTEdK6NJ3wdNo5vQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzWwXFP8hNg922LGtJJqCYm9fz1mtrqqj+R/ti16A2M=;
 b=t5d7cjy1OzymQPvrsMe9iDm1NQ2PuB/4Ol8/YW4h2UEo9siYXBRYkl7eNd1nOWF2RYZShXqRK7bPZVzwONBXFM7yvRRUrSq0bAXfSZ0ZrU32o9JJoO44/16j+YcI9+OOBUYCh8HNsmc7eX5C9BS2+L9Qeh+aYJuCuFPurLSwy5NUkh0Y3CX1m8iAtxlt7ZGeHaCVIDU45lIT6pYz0BsHMzEVwQTIqPcRwVtG9NL4Jy6BDWm+uFoi3P8Tr9frtrElQ7gSQj+PIOdVIlhRFRRFa2jVrKif4Xl3x+pCWLOLhpdxem+IzEcnG7D8fj6uBayo/H3QAj3CXmaa+Q3/bq1seQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 29 May
 2025 06:46:21 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8769.021; Thu, 29 May 2025
 06:46:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 1/6] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
Thread-Topic: [PATCH v1 1/6] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
Thread-Index: AQHbz5bjeLpxzgIre0OmPOnzMlrvULPnzzSAgAFUbFA=
Date: Thu, 29 May 2025 06:46:20 +0000
Message-ID: <SJ0PR11MB6744B5EEAD02E7DA89263AA99266A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
 <20250528060409.3710008-2-zhenzhong.duan@intel.com>
 <538e848b-148a-49f1-bf06-f534ff44bf87@redhat.com>
In-Reply-To: <538e848b-148a-49f1-bf06-f534ff44bf87@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: jgg@nvidia.com,nicolinc@nvidia.com,yi.l.liu@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB5819:EE_
x-ms-office365-filtering-correlation-id: f417d36b-b2c8-4a90-f503-08dd9e7c8568
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RkNaN1RsK2tzRXRJSDFyOUZHd1BKd0xkLzdSZFFlTGlEU2lzMGduSUlidGJH?=
 =?utf-8?B?N05lc0VDMFdaR1l5QjE4ZWhnbCtqR0RQUnV5OFMxZ0Z5ZnNmWVgrdTNqbHN5?=
 =?utf-8?B?Nk0yVHR3dnQxbUFhenBDUFFnR2ZPaUd6NG00SmRQK3R3Yi84WDFoRkhBRTY0?=
 =?utf-8?B?ZDI1d0U1ZndTUlNPS0xENHROOVhlMis3YWsyZVlOK1Qwdzl3MVBGbmIyRHhz?=
 =?utf-8?B?VVBBeGtSamJXZmYrTjgvZUtqWFVmZWEyN2E2ZDMxcTVxMGFHZmxCbTVXWnJw?=
 =?utf-8?B?VXRIbUNoS1VwYk1jQnV3Q1ZrVTJBQkZ4RVh5THhuSnlyQ29WVU9JT1FDWkdK?=
 =?utf-8?B?L1Q3NHJWcXdHUGJRNFM5SmQxQVlUZjZaWnp0a2oweFo4T2JLOEhXRWxPSS90?=
 =?utf-8?B?NDBFbGNac2t2aGZYOFdncmk3UW5aWFk2bHA1UzlpS1FZbzJkTVdmNlhRV05C?=
 =?utf-8?B?bmZjK0lFbk9tSTZCb0hFWGhnaDM3RDAvOVFzczJyODExc0t1WlY1N2tDYmgx?=
 =?utf-8?B?dXEyM1lUaEtDcnNuT2hvWkZBbnl3M3dwV1dHNnBrZUhrZk5wcWdORzNULzUr?=
 =?utf-8?B?RXpJV3hXOXlRNHRkRGpaZTRuUnVqTWxRTGtUd1pKL2hqYUdDTW1DZ1RuaVRp?=
 =?utf-8?B?WE53bDJDUmxZSGlUckxwMzEwYnZsSmlXdFNaNlJSeG53MzhTRkpWSXd0dllr?=
 =?utf-8?B?NEpYQjFzR0F5UlpPUEQyNi8rak5OVVBVWmR3Y0s0aGpLQUlZaU90NUkvUzdP?=
 =?utf-8?B?Mit4TUpjdlFIbVdRdXNoN3VVbjJVQy9POEJIU095VzV2TkhYVndSUHU5VmxP?=
 =?utf-8?B?Yy8vMDRkeDdTYWlYRVRJYXdNTTdBR3BxY1NlZG9rd3ppK2tJV0dIVW9SVTc4?=
 =?utf-8?B?T0ZtNkhGNzJsUWpKQVJUR0Rmc21ES1VWY0Njbk9qbExGRXFwMWU4aTQ2N0dt?=
 =?utf-8?B?MDJvTThFdHhMUTFib0hLblkxUGI4U050S2ZBMTFaSkNkMjA1V3ZlQllYb2ZQ?=
 =?utf-8?B?eTlEZjJ3WXQwQ2xHeDBSTUJRYjd3QWszbldGWCsyRGVnSkJTS3BBekZTKzVq?=
 =?utf-8?B?MDgvZ3ExQWZVMXZTNnVJYzd5U3k2SzJJQmJDa3JIL0IwSlpYUUVKc3ErUmc0?=
 =?utf-8?B?ajZhMng1SG1EZUd5Q1dIY1ZHZCtWWExNMEIzZkJvbU1kZGZvOVlBcC9jNlNC?=
 =?utf-8?B?eEFnUVNUa20vNXkvQk9kNlZHNjVsYUJoVWdENkc5SUQxbGgxekR2YWFZY2R1?=
 =?utf-8?B?UXRIbXc5VWdpRzNuUXNLTzFTeE05UmxPNXlwSWxCS2wzWnZwK2kvOTJJRlRx?=
 =?utf-8?B?VXZnNndwcjZOZGZpWWthNUExeVZTRk5JVzFCWTg4MEMyUDN3b3hyWHhYSmZM?=
 =?utf-8?B?NkdFaTdsTzIzclZvT2FYWnNySXRvcmcwTzU0ckRQM3ZwQXlQaFZNVnQwdmdv?=
 =?utf-8?B?RnIrelA5ZVZJeTRPRE03WEtsZDdrR092bmhRb0xZWWhTU3NrZVhpY2htSk4x?=
 =?utf-8?B?YVNCK1I2Vm9YWWxvQkE3QmJBbzd4RFd2L3JFaVpBYUp0QThZbXRWQlpIU0l1?=
 =?utf-8?B?d2dzdTAzZDRwQU9ONkNaYm9nLzRqQVBFOUVVWjRLVWYwUVN4dENadTd1dGJI?=
 =?utf-8?B?NlIxSVFQY05TelZaSndQR3ArOUpYK2t5eVZEeldKZWRBa05SQWhwbFhkU1ds?=
 =?utf-8?B?NGlqOFdmVHdnMW9KbzhNTjFFUGZiNGtCd3Vuc2p0VlROQVl1MnlWMGszNVd5?=
 =?utf-8?B?U3l2anRJRDhYdTBReHR3YUNLd0pQNmtkUDdyYWtwOTM3QnhhcnVXTkw3RWJY?=
 =?utf-8?B?VnA3K1VJem5UYkpYR0hDNVkzWGNQaEUzMzM4djBlRzZMV3pNaVN5Ui9tNWNC?=
 =?utf-8?B?T2ZaYVlYalRuVS9sYnRlV1hLcmw4dVc0TGVyVHdSN1NIUXdUV3BjNm1RbXRp?=
 =?utf-8?B?bEhHaDRZNU9XNkE0MzMxYXlMSHE2Mi94dVB1MDZVVzU4KzZKMjl0RmJuSXVl?=
 =?utf-8?Q?004I89qBWJ+LZQLoU3IqdlcCEtPHpA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW5JS0xrdElrUGJsbFpkRzhMSGw0MnpMcHAwb0YvbnJndktObWMyYzVXS3RC?=
 =?utf-8?B?cTVEdlF0SS9od1BFZlpwcXFYS2YzczI4N2Z3dURva1ZDSGJ4cUlzQ2QwUytU?=
 =?utf-8?B?VlEwRVd3bFRaa0hPaWx6VHcwck4vRTByamsxbzd4ZzFTZHF3WitiMU84cUxn?=
 =?utf-8?B?NlY1d3lHOG93Ym9PMERMM0pGTVdud29wTFZlcCtZZ1h2QVlzUk1rT1pJOFky?=
 =?utf-8?B?ZURXQXN1NWl4YVFPb2F0S3FybE9hV21pK3o5cTNIeGxkdWRJeUlIS2JxeXJE?=
 =?utf-8?B?U1B0SFhqTHlvdXNLYnd1eXN2SzI4NnlvVmRjdDVMZHNsMXdVZjVvaGRhWGlo?=
 =?utf-8?B?SVBrbTJZQnpBUW9sWFdZdE5WMi80TURRSllMd29KSlJCQTBlOTlxenJWYWMw?=
 =?utf-8?B?N0VybHBuaWdyQlZKN245bXRlNkZMRm1ETE9QVjBlN1MyZVRDNnZWUWNUdVM2?=
 =?utf-8?B?dFJyQXR5TEtsdW4rQmtwNXdEUDJENEZvbGw2eTgrYlVXR2NjVUdLN3hWLzJs?=
 =?utf-8?B?TDJvOUo4cndxNEJuMVoxZmZPaHI1Z2QwVnc2Ty9FV1l2OWhPaHpKSktlZzM2?=
 =?utf-8?B?YnZyZVE2Yjd5REEyMzV5NndGdzYyMUZDNUtOMk1BRHpuMm1qSVQzcjhBWWN5?=
 =?utf-8?B?RWdVZ2phMTJWdHRjYUhlV0ZwZFd6UzhNamFZdEJWTTh5VnQzbXQ0L3plTzdX?=
 =?utf-8?B?Q0NxUnQ0UTVGSnljWCtieVFGdmpVZW9HajVOeHU3TDdTaFVZbFdxVXU2aGpI?=
 =?utf-8?B?dmdXVW9xLzVmd2pMNG1jdWdGSkgyNUgzNHRTYllVcU5haHova1FGR245cGhx?=
 =?utf-8?B?MGlGN0RrTGRYbnA0YXBXL2c0SU5NMEJNQkxNUDYzc1FhWFRiTUZUL2ZvVUND?=
 =?utf-8?B?R1crMldCTldHK3dNb1htWVNsMXZOVEcydkRZeXdneGxMQUJ6eEJBSVk1Y2g0?=
 =?utf-8?B?OFdVR3NYMFN5akZHak4xd1g3U0c1RzlKU1dva0pkcHlNeFRIQTdZVkhxQ21m?=
 =?utf-8?B?VjJWZWF2TDdrOVdXUDBKT2tiTldwZzJuMk1pL2NrdE5NOVlIQlNUYVRuNG5y?=
 =?utf-8?B?MzhjbFRGYkwySjhpZG9SK0VBZ1JSalNXRE1jdGtqL1RHZU9GYThyWnM5ME1G?=
 =?utf-8?B?eCtrRWtsNGEwcHJnUDhubkk2NDNQNksra01jWTl0T281eXJNZGFzREM4NEY5?=
 =?utf-8?B?RWJkQnU3YzdFSXhldDhySkcwUGJwaEVhK3EvaVEzVUFZbytaUFNqMDZLWEds?=
 =?utf-8?B?RTlvbzJwRExaUlFUUzdCVnF5WExHR28wOHRTR1BFcnZZL2FtSjZRRFUvVTgv?=
 =?utf-8?B?WXpCYzVwTXlSMlhNdnhkV1dxcFR2alF3UkQxL2hNejdEKys5YjJXZ3hIZUta?=
 =?utf-8?B?Um1aMFpkNThMSUNTVjR6Qld6dmVKbWxGUFZuRFFoV2V3UVNBQlVBdm9wajJY?=
 =?utf-8?B?VUhHdENIQTZsWkFJYmF6dlRtSFdYSVh5R2NYWDFLUENuV0dnb3lNSnFzVTV1?=
 =?utf-8?B?ejdzdk9JVjJINWR4Z2JkYUtOUWUydlkzbmF0cmdIT0xLaFRsa2ZoYzhFMGtk?=
 =?utf-8?B?RWRuME9VQmRPUnhUZVlOUlpsYTE4Y05aTzFnOFVsM3JxV3RSWnQrT2FNWkd6?=
 =?utf-8?B?NkVoK3lPeDlORDl3bW5kTTdCTVRNbmtSSnRTMlNERnR4QWxxUzVrYTF4ZVp4?=
 =?utf-8?B?UWV5SCsxTUZXYi8vbzBlZ29waDRpb2l6N0VLaEF2cmFJK0hKSWN6Vk5tMnpY?=
 =?utf-8?B?QTdoV3pPUTdYQTdWTHpPMmNoTVBZZHdLY0V1cHlycDNLdURZOXRLNjhqQmxP?=
 =?utf-8?B?VUNtU3pYT3Bpc2krWHJRN3Y4SS83MDJJS0JKWE9uR0J5ZnpjY250M214eW9D?=
 =?utf-8?B?Q256cERQYkhLMGhvbGxvUnlWWjFHZ0M0VEYyRXVNdVJoYUdGRWJXdlZSRllT?=
 =?utf-8?B?MXJZNDNOYTZHdWloSktKQ0FxNTRuTThpVXlKZGg0RXpUd3J1bUEreGZsNjlW?=
 =?utf-8?B?bFo5UUZtZFhNRlo5K3Q5N21TdTU4bGhkQ1Z2Z1JSc1lvcnFqN2dGa2tCTVpW?=
 =?utf-8?B?WmhsblEwUTl5N2d6WndIZUNMVnBDRHM4NllQRHBKUkZ4SDhXMTVzUXhTeGdO?=
 =?utf-8?Q?bqj+fD6DgZukwyZgz10naChC+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f417d36b-b2c8-4a90-f503-08dd9e7c8568
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 06:46:20.7536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcV6Kx8NpAQq7Bedsewa9rsVkgVZkoU/9cpA2EFJOZ0kyCYRnxTnN4GEpThIQ5lbIfsGnlRuSX6a/BrCILLxQST/Q38Evcgp0XUxIBM3bfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5819
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS82
XSBiYWNrZW5kcy9pb21tdWZkOiBBZGQgYSBoZWxwZXIgdG8gaW52YWxpZGF0ZSB1c2VyLQ0KPm1h
bmFnZWQgSFdQVA0KPg0KPkhlbGxvIFpoZW56aG9uZywNCj4NCj5PbiA1LzI4LzI1IDA4OjA0LCBa
aGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFRoaXMgaGVscGVyIHBhc3NlcyBjYWNoZSBpbnZhbGlk
YXRpb24gcmVxdWVzdCBmcm9tIGd1ZXN0IHRvIGludmFsaWRhdGUNCj4+IHN0YWdlLTEgcGFnZSB0
YWJsZSBjYWNoZSBpbiBob3N0IGhhcmR3YXJlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE5pY29s
aW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9z
eXN0ZW0vaW9tbXVmZC5oIHwgIDQgKysrKw0KPj4gICBiYWNrZW5kcy9pb21tdWZkLmMgICAgICAg
fCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgYmFja2VuZHMvdHJh
Y2UtZXZlbnRzICAgIHwgIDEgKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMo
KykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oIGIvaW5jbHVk
ZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiBpbmRleCBjYmFiNzViZmJmLi41Mzk5NTE5NjI2IDEwMDY0
NA0KPj4gLS0tIGEvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiArKysgYi9pbmNsdWRlL3N5
c3RlbS9pb21tdWZkLmgNCj4+IEBAIC02MSw2ICs2MSwxMCBAQCBib29sDQo+aW9tbXVmZF9iYWNr
ZW5kX2dldF9kaXJ0eV9iaXRtYXAoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdCBod3B0X2lk
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGlv
dmEsIHJhbV9hZGRyX3Qgc2l6ZSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50NjRfdCBwYWdlX3NpemUsIHVpbnQ2NF90ICpkYXRhLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7DQo+PiArYm9vbCBp
b21tdWZkX2JhY2tlbmRfaW52YWxpZGF0ZV9jYWNoZShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQz
Ml90IGlkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QgZGF0YV90eXBlLCB1aW50MzJfdCBlbnRyeV9sZW4sDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqZW50cnlfbnVtLCB2b2lkICpkYXRhX3B0ciwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7
DQo+Pg0KPj4gICAjZGVmaW5lIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRA0KPlRZUEVf
SE9TVF9JT01NVV9ERVZJQ0UgIi1pb21tdWZkIg0KPj4gICAjZW5kaWYNCj4+IGRpZmYgLS1naXQg
YS9iYWNrZW5kcy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+IGluZGV4IGI3M2Y3
NWNkMGIuLmM4Nzg4YTY0MzggMTAwNjQ0DQo+PiAtLS0gYS9iYWNrZW5kcy9pb21tdWZkLmMNCj4+
ICsrKyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4gQEAgLTMxMSw2ICszMTEsMzkgQEAgYm9vbA0K
PmlvbW11ZmRfYmFja2VuZF9nZXRfZGV2aWNlX2luZm8oSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50
MzJfdCBkZXZpZCwNCj4+ICAgICAgIHJldHVybiB0cnVlOw0KPj4gICB9DQo+Pg0KPj4gK2Jvb2wg
aW9tbXVmZF9iYWNrZW5kX2ludmFsaWRhdGVfY2FjaGUoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50
MzJfdCBpZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQz
Ml90IGRhdGFfdHlwZSwgdWludDMyX3QgZW50cnlfbGVuLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVudHJ5X251bSwgdm9pZCAqZGF0YV9wdHIs
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnAp
DQo+PiArew0KPj4gKyAgICBpbnQgcmV0LCBmZCA9IGJlLT5mZDsNCj4+ICsgICAgdWludDMyX3Qg
dG90YWxfZW50cmllcyA9ICplbnRyeV9udW07DQo+PiArICAgIHN0cnVjdCBpb21tdV9od3B0X2lu
dmFsaWRhdGUgY2FjaGUgPSB7DQo+PiArICAgICAgICAuc2l6ZSA9IHNpemVvZihjYWNoZSksDQo+
PiArICAgICAgICAuaHdwdF9pZCA9IGlkLA0KPj4gKyAgICAgICAgLmRhdGFfdHlwZSA9IGRhdGFf
dHlwZSwNCj4+ICsgICAgICAgIC5lbnRyeV9sZW4gPSBlbnRyeV9sZW4sDQo+PiArICAgICAgICAu
ZW50cnlfbnVtID0gdG90YWxfZW50cmllcywNCj4+ICsgICAgICAgIC5kYXRhX3VwdHIgPSAodWlu
dHB0cl90KWRhdGFfcHRyLA0KPg0KPk1pbm9yLCBvdGhlciBoZWxwZXJzIHVzZSBhICdkYXRhJyB2
YXJpYWJsZSBuYW1lLg0KDQpXaWxsIGRvLg0KDQo+DQo+PiArICAgIH07DQo+PiArDQo+PiArICAg
IHJldCA9IGlvY3RsKGZkLCBJT01NVV9IV1BUX0lOVkFMSURBVEUsICZjYWNoZSk7DQo+PiArICAg
IHRyYWNlX2lvbW11ZmRfYmFja2VuZF9pbnZhbGlkYXRlX2NhY2hlKGZkLCBpZCwgZGF0YV90eXBl
LCBlbnRyeV9sZW4sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHRvdGFsX2VudHJpZXMsIGNhY2hlLmVudHJ5X251bSwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKHVpbnRwdHJfdClkYXRhX3B0ciwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID8gZXJybm8gOiAwKTsN
Cj4+ICsgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgKmVudHJ5X251bSA9IGNhY2hlLmVudHJ5
X251bTsNCj4+ICsgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJJT01NVV9I
V1BUX0lOVkFMSURBVEUgZmFpbGVkOiINCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIiB0
b3RhbGx5ICVkIGVudHJpZXMsIHByb2Nlc3NlZCAlZCBlbnRyaWVzIiwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgdG90YWxfZW50cmllcywgY2FjaGUuZW50cnlfbnVtKTsNCj4+ICsgICAg
fSBlbHNlIHsNCj4+ICsgICAgICAgIGdfYXNzZXJ0KHRvdGFsX2VudHJpZXMgPT0gY2FjaGUuZW50
cnlfbnVtKTsNCj4NCj5LaWxsaW5nIHRoZSBWTU0gYmVjYXVzZSBhIGtlcm5lbCBkZXZpY2UgaW9j
dGwgZmFpbGVkIGlzIGJydXRlIGZvcmNlLg0KPkNhbid0IHdlIHVwZGF0ZSB0aGUgJ0Vycm9yICon
IHBhcmFtZXRlciBpbnN0ZWFkIHRvIHJlcG9ydCB0aGF0IHRoZQ0KPmludmFsaWRhdGlvbiBpcyBw
YXJ0aWFsIG9yIHNvbWV0aGluZyB3ZW50IHdyb25nID8NCg0KV2lsbCBkbywgbGlrZSBiZWxvdzoN
Cg0KLS0tIGEvYmFja2VuZHMvaW9tbXVmZC5jDQorKysgYi9iYWNrZW5kcy9pb21tdWZkLmMNCkBA
IC0zMzksNyArMzM5LDEwIEBAIGJvb2wgaW9tbXVmZF9iYWNrZW5kX2ludmFsaWRhdGVfY2FjaGUo
SU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdCBpZCwNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIiB0b3RhbGx5ICVkIGVudHJpZXMsIHByb2Nlc3NlZCAlZCBlbnRyaWVzIiwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgdG90YWxfZW50cmllcywgY2FjaGUuZW50cnlfbnVtKTsNCiAgICAg
fSBlbHNlIHsNCi0gICAgICAgIGdfYXNzZXJ0KHRvdGFsX2VudHJpZXMgPT0gY2FjaGUuZW50cnlf
bnVtKTsNCisgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgLUVGQVVMVCwgIklPTU1VX0hX
UFRfSU5WQUxJREFURSBzdWNjZWVkIHdpdGggdW5wcm9jZXNzZWQgZW50cmllczoiDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICIgdG90YWxseSAlZCBlbnRyaWVzLCBwcm9jZXNzZWQgJWQgZW50
cmllcyIsDQorICAgICAgICAgICAgICAgICAgICAgICAgIHRvdGFsX2VudHJpZXMsIGNhY2hlLmVu
dHJ5X251bSk7DQorICAgICAgICByZXQgPSAtRUZBVUxUOw0KICAgICB9DQoNCiAgICAgcmV0dXJu
ICFyZXQ7DQoNCj4NCj5XaGF0IGtpbmQgb2YgZXJyb3JzIGFyZSB3ZSB0cnlpbmcgdG8gY2F0Y2gg
Pw0KDQpJJ20gdGFraW5nIGl0IGFzIGEga2VybmVsIGJ1ZyB3aGVuIHJldCA9IDAgYW5kIHRvdGFs
X2VudHJpZXMgIT0gY2FjaGUuZW50cnlfbnVtDQoNCj4NCj5Mb29raW5nIGF0IHRoZSBrZXJuZWwg
aW9tbXVmZF9od3B0X2ludmFsaWRhdGUoKSByb3V0aW5lIGFuZA0KPmludGVsX25lc3RlZF9jYWNo
ZV9pbnZhbGlkYXRlX3VzZXIoKSwgaXQgZG9lc24ndCBzZWVtIHBvc3NpYmxlIHRvDQo+cmV0dXJu
IGEgZGlmZmVyZW50IG51bWJlciBvZiBjYWNoZSBlbnRyaWVzLiBBcmUgeW91IGFudGljaXBhdGlu
Zw0KPm90aGVyIGltcGxlbWVudGF0aW9ucyAoc01NVSkgPw0KDQpZZXMsIHNhbWUgZm9yIHNNTVUn
cyBhcm1fdnNtbXVfY2FjaGVfaW52YWxpZGF0ZSgpIGFuZCBzZWxmdGVzdCdzDQptb2NrX3Zpb21t
dV9jYWNoZV9pbnZhbGlkYXRlKCkgYW5kIG1vY2tfZG9tYWluX2NhY2hlX2ludmFsaWRhdGVfdXNl
cigpLg0KDQpJJ20gbm90IHN1cmUgaWYgdGhpcyBzaG91bGQgYXBwbHkgdG8gYWxsIHR5cGVzIG9m
IElPTU1VcywgdUFQSSBkb2MgZG9lc24ndCB0YWxrIGFib3V0IGl0Lg0KDQpATGl1LCBZaSBMLCBA
bmljb2xpbmNAbnZpZGlhLmNvbSwgQEphc29uIEd1bnRob3JwZSwgc2hvdWxkIEkgdHJlYXQgcmV0
ID0gMCBhbmQgdG90YWxfZW50cmllcyAhPSBjYWNoZS5lbnRyeV9udW0gYXMgYSBrZXJuZWwgYnVn
IG9yIG5vdD8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

