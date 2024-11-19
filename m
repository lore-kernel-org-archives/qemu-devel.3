Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C4CD591C4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 07:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDIL8-0004XP-CD; Tue, 19 Nov 2024 02:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tDIL4-0004X9-Ee; Tue, 19 Nov 2024 02:07:55 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tDIL1-0006CU-4a; Tue, 19 Nov 2024 02:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732000071; x=1763536071;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vHXrCSKW0T70gtKB6sAvG4/BaPbmnDCQWBugpeY581Q=;
 b=CLt6rjDg/hmtY2/lUduVR+BYR/ybZl36PM5YVJIOWSkyQPJXWqMR69jr
 7PMlXU6R6sTh+eHIdyCw1dgBp3/KM66OpXexxz/LO+mcTLar6SuyJCQqB
 w5f+5QNmpFD8VIer76lYzIVbGsgI3vwOPC2hYLfRfuw8OVXaYtbD/Kjau
 b8W9nOVRLvqCrLmcte2RNQWQlOySY/CW5l9DUQ56STnR9sJmZzDGg9aBN
 6gmFLQcO29h4XhxOhUg51hRpW83Qy667ej5XFV4kC09CqK2FqUnpgmLqH
 tpw+JFkhenh1vDQPkOgIFDhthA51/n+p7OYx9peyOLgQJk98MqBfJYOHS A==;
X-CSE-ConnectionGUID: fyfXDrEZQFejcDLwRZJ82Q==
X-CSE-MsgGUID: N1yDevOkRgeGBQLVEIVIWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="43366489"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; d="scan'208";a="43366489"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2024 23:07:46 -0800
X-CSE-ConnectionGUID: 26++nMzQRpCKWGEcYCHENg==
X-CSE-MsgGUID: nblc7TX/Q0Kca6kLimv+bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; d="scan'208";a="89585091"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Nov 2024 23:07:46 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 23:07:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 23:07:45 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 23:07:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSx+ixzg58lUaEKzX6ON/OUzaIksFfMsH0/GWFdaClYM9UvnpFYZ6vHmV4iaw+Rf3gsjd3n5gFgE01STeBTO0wkHKAypJj/kHfBbepuQ0ikCPbThqR2pwEw06mEy07cb6wZGSl1Re6qJIBKSylY8di5bqGuKDrngtQgj2kbEQ8mrOTsJkMdxtn8hjyMGHeDVBBhy5OLBthwDn3Npq17iuqo62ugWWhzz8N+ZQ0O2tXVHKTGGYhXMxIhB78bz9+6AM0l0OxkQHalj0XQ6JAoE5mfdZD6r9tC6pELgYGU4CMuFGngLHPQVbBP/8kLLHwBiYXF7JeLBr/+v2CdS503oUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHXrCSKW0T70gtKB6sAvG4/BaPbmnDCQWBugpeY581Q=;
 b=Bc+1z/nGiPuDSnvnimoWyHvECAQj1G5onUGORZ8CEhzTtzR6FJ+zw2GNcbu7tUNLARv3soUDUn4de9zHW96c0rU5ncJ5tBVIvOa9DrWSbmYeE0t12FmVazrHpUbmwfU5IimBlJgrU6wjUfbzsRLvkUYfkCyHN9eXM2vE2SooSv1qkWV41buSXJK+nyPHltwCWwmrcXblWMJby8LfwvO9SgqVFAnmj+m3LWnJ2GYja50X1kOY+IhVNWrll+Pk+w/XcC8dw5ZXtVnt3xoE9DKMzJjSUPiFRepq5X+97Uivf7nPMIXksNRE/mRlf4T1rQbeZP2M9m7kiq2OIbkeO6Hfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB7781.namprd11.prod.outlook.com (2603:10b6:8:e1::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Tue, 19 Nov 2024 07:07:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 07:07:37 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Mostafa
 Saleh" <smostafa@google.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, Michael
 Shavit <mshavit@google.com>, Andrea Bolognani <abologna@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Zhangfei Gao
 <zhangfei.gao@linaro.org>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "arighi@nvidia.com" <arighi@nvidia.com>, "ianm@nvidia.com" <ianm@nvidia.com>, 
 "jan@nvidia.com" <jan@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>, Don
 Dutile <ddutile@redhat.com>
Subject: RE: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Thread-Topic: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Thread-Index: AQHbOeO44r/7t98PXkuS+XUA0Ue3w7K+K/7w
Date: Tue, 19 Nov 2024 07:07:37 +0000
Message-ID: <SJ0PR11MB67448860487317755CCCF76192202@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <1845a6b8-5214-4379-85f4-3d36b61059dd@redhat.com>
 <Zy0jiPItu8A3wNTL@Asurada-Nvidia>
 <e36a1c1c-c880-4c64-82f9-34d55a04bd00@redhat.com>
In-Reply-To: <e36a1c1c-c880-4c64-82f9-34d55a04bd00@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB7781:EE_
x-ms-office365-filtering-correlation-id: 7c473957-6cfc-41cf-83b4-08dd0868d95a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c09zVmxZcHMwRi9SRHVsQjBvdzNhY2NVT3JOSTJTbDNGMFRQaVJCQkxobTlw?=
 =?utf-8?B?ZGljT1c0QW9vM0ZDRzdQUXNickJ0bUNoUStKaE1HRE0xN0dsQWNaU3Rnbjc3?=
 =?utf-8?B?OG5UNzVZMGdPWUZPdW5CSzZBZXM5eHRsc01mSlBXTG5YZnVEaFc5MHlrS3J5?=
 =?utf-8?B?ZHF6U1VoMDZCZHBOQWs4NjFsMW1FTlk4ZjNlZUtmYnJrbWtIM3k0eGF0cVdM?=
 =?utf-8?B?Qkx6bklacW1LYng1b3NrRUhoaTRFMi9vNmNibFdmTS9rK2paVkltVVBldUF4?=
 =?utf-8?B?YlBHMUxmV2t5cFNYYUtoYTI0emlPL084bDdaYnZqZUdDelBxaDlQa2JBVFFU?=
 =?utf-8?B?NjVWa0tuYmFjSzNsdXp5YlZwSzF2a3dmdlRORkl6aEtaTWVRdWlTcXlsY054?=
 =?utf-8?B?VVl5MUFSNE02Z2VsOG1FbXloOVc4ZTlQRjhxRjBGVTZEdGk1alF4S3p4TStU?=
 =?utf-8?B?S3lVTFU4a3hxNUIxazhObGs2anRCcEl1SDlVYkdtd2d4ckNIcnhTTitpMlVO?=
 =?utf-8?B?dE5mdkgrMXBoeWtBK1ZWcHk0QkpFb1dOZ0IwWmNlQUx4WVoyVXBjOG5sUk9J?=
 =?utf-8?B?OEIrU0gxOWNCeno1cTk2U3E3a00zOTF6Yys2eDVqL2tQamIxNTJrcXNKTklm?=
 =?utf-8?B?aVR2dDhISWdUOXNHWFNTWDFQbExNMk1LTmJUSkdwM1B1WHNBN1FmRXMzempx?=
 =?utf-8?B?Z0g1aHhGRms3WDBrN0JrMU52anNkSHFNNUFkQlIwRnppZTdKbzVkekwwbkgy?=
 =?utf-8?B?RERHcFVrS1cwWTk5ZXNjTW1ueittUXhicER2b1pGS082aTFzWW9MVytXVUdX?=
 =?utf-8?B?MmtTendXdjVlYWcrOUQ2R3NZMkRDeERObHJtNWRIc1krSGVvWlFWSytDSnYw?=
 =?utf-8?B?WW5CUWFaT3FxY2c5b1NLaGltcWtxNnBQdnRvc3lDMHk5a1pQeUVqbXhNSUNv?=
 =?utf-8?B?Z3cyVGV1ejQwWld5cHpLZ05vNDlrNzAwR0xuOVAxelU0TjNUS0FOME93ZExx?=
 =?utf-8?B?UnVrbEtTakpENzNGdnh1Z1l3WnIxK2Rlb2J6eWlCV0krVk9UMDR3Q3kyYTlB?=
 =?utf-8?B?UXo1c0cxdWsrbmJ4bUtHQ1E0S0NrbU1nU2NYdXZUVjZNMG1DRG91cUxYVVNH?=
 =?utf-8?B?KzFZbklDOHlmRVNIK0d5ZVJ2RWJxU3EvZXRGQXBIa090MWFvWGJmZWYwZGpV?=
 =?utf-8?B?bnRmcDRLSy9GNkhHYWVaQTlhUG9GY3dpNlA3aWptaFA0U0FBZHFtaTJSYllq?=
 =?utf-8?B?YkpWZi9XOUNFeG5EaHFzYmhVWXpkUzZUQ2xLa3NFSk90Yy93Rkg4VVBzT3VH?=
 =?utf-8?B?YXRtZG8vd2hsN3IxbVF4cHRZY285KzNVOFoyNC9lOGtnR1BHNUtxQmhQVG1r?=
 =?utf-8?B?WlN3ZzBCNXpTS0Y3cGFlSXZ2Q242bHFMZE5iMG5rWFd0RmIrNk85dE5sOGVZ?=
 =?utf-8?B?Vzg2MFlmVE9LanpxQ01GV1ZDTjJXMGp6WDVDUkcwc1N1dCtHT3ZyZUZsYklW?=
 =?utf-8?B?b1Z4VW5nY0FscDJHc01yc3NTUC9VdjhNNytvMVR6Z2ZZR2VtbXJZU3VWL2w4?=
 =?utf-8?B?V2FRUHdmVVRiUFFucGZ4NU5WbHA1VS9ZUU9mTFM1VG1FMVRIR3FjOVg3NUhV?=
 =?utf-8?B?ZEJibXdTYnZDZ0J0ZTBZTXFLSk0wUFBwQmtBSzdHRStsRUZvaWpValBuQ0Y2?=
 =?utf-8?B?UG1IdGRQWU1kSCsxMFh1blcxWXppdW5yYmFWcHQyUE01Q2RXRzAydGRHaVht?=
 =?utf-8?B?Z0k5dmxRUHdvbDhneWljNzM1SWkrbTduYmpoTmxYUmpBQ1JRVnJya1pza0Ji?=
 =?utf-8?B?U3MyY3BLdXBURXdzNDMzZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmV1WjlBVnRTLzJqdTlVYk1PWnFnNW9BazZyaHhhRERyU0VQUEFKdllsSU5G?=
 =?utf-8?B?UmFFOTZPYlZ1UmJSQlRqVnRzaWVETnBrUUVadjBCMmtBNnBwekpkRXJFVnJ2?=
 =?utf-8?B?MTBwVC9VVG4yR0dwUDFFcWhZV3dnQWljeHpwVFBUVFRrK3JFRlJKcGFkemJR?=
 =?utf-8?B?c1BDOGdsS005ZzdsTHBYOVhkd0NvODdpZGxrNzM0UFF4UGZLSXlLTGZwUzBi?=
 =?utf-8?B?eHV3OHNwSHhjSzFCWGN6ZnZTbHJTMVo2NGtDN1Q4ckRiSzBySUIxaHFPc3VS?=
 =?utf-8?B?bkI4d0Zud1BPc05YZS9mdHo2UXFSN2RjRVBSMTlLSi9oNTRsMlRmL1NrNElx?=
 =?utf-8?B?ZkpnNit2YzJtdTRVN3lxSWM1SWM1dzNCN2NqcXAzdHR2Zk04bnI3THpHdVlY?=
 =?utf-8?B?MVBwTFNtbHZLUjJGK0xGMkYvSXBUdGFxenUvek0vZ0xvSURLbktzZyt3aXRB?=
 =?utf-8?B?VW4yN0V3WXJIaVVqMXhpUmlUNjJhV3pLZGYxZTIvZjFvQlBhc3hJTnRDNVkw?=
 =?utf-8?B?QzNJK0VSQm1jOXJVMHZKZFY1Y3RLeXJHVXlKRjdTUk0wUFFxam5DM2hXUVRS?=
 =?utf-8?B?c2s1NlgydmdFeXNNNkE4RERiSEVCRXlIVlFId1diMFZ1KzMyeWMvOEo4N2F3?=
 =?utf-8?B?Z3luQXNFTkorQ0JjRGxtS2ZWQ0M1ZEt1TUlnMDRLcEswZEtNVkV4MERDVFBG?=
 =?utf-8?B?Zk5oWjZwdjJseVFsaHJIWjVZSWQ3ZW1oWjVDb3V2TUNxL0E0NVV3bzNQNXI1?=
 =?utf-8?B?YXNseVc4VWVSYzZ0OU9GMFBVNE1vdnpHcmdJaC80V2hJdXF2VDNicmlTSC95?=
 =?utf-8?B?MHRLeHVQdlVQc3p1UFZVTmFCYXN6b3JYcDBWZ3l3ayt6eHB2YW9tQlZXa0FZ?=
 =?utf-8?B?Q1cwZVN3WGxyWG40dzF5dlRtd2d6OGg2YlFabUVvOGtjTTJJZlNnTS9sODND?=
 =?utf-8?B?TXEyaEF2cE5pbGN3d1JTSlRjSFg2Mit4d2JKaEt1bWozVnB4YTcwRWJXWXBm?=
 =?utf-8?B?QVM2RlZ4UlZiTnhDRnVNMFVCSDVWMXBneW5KSlVQSXBqMzZPS1BTN0czak5a?=
 =?utf-8?B?VERZUDE1NUVzZ1VJWmlhbVhCVnV5eVBJN253RHFiYVkwSXU3UXFwS1JLNHFN?=
 =?utf-8?B?MXRFR3BiakpmTTZxYlhraENnSkRDMlcreGVFUVNTajM2SFVtSUdrT2s4WFZp?=
 =?utf-8?B?Y2k4Rlk2WWtVS1BvRjBNbEhabFpoQzJ6MWc0RFNpeHZuS1JGTkJzNENHemZG?=
 =?utf-8?B?N2lQdkFRS3pjRXZacnBsVmFKTUlpNDBvUVUyYW9QYWJsQjNQdC9iZVJ4VG00?=
 =?utf-8?B?TzAvakZLN3ZMcUhyTVNrck9NVXdQcXhjckJUaDhaV3JkSWovaXE1cXlOejVj?=
 =?utf-8?B?c2o2T2tYTDlIbXZJYlFLNEFDUEloQkFOMVpETVFpb1lXNEsvZHIxWURaV3pi?=
 =?utf-8?B?WDI3UVgxY283SUh5c2VEMms3OXlrakdQRllaZmoySlU5TUNkZ3FVNG5wYWhK?=
 =?utf-8?B?RkNML3ZnYlJMbTVaZkFMK2ZuWGhaZHVPSGllL2tMV1lxejkvZjYvTWE4WHlq?=
 =?utf-8?B?QnBFT29IUDBRQUVtUkljMzlrVU0yYWtCVGxqN056WFYvZEs1OU9EV2xEV0Va?=
 =?utf-8?B?N3RVUk5vaU9TNlJ4V0VaL1RaTU11ZFBOdFhMRnlSMVlidk1UVkZWNFZnYVcv?=
 =?utf-8?B?cVJrNGRaSnBDQTAxRkVNYm9xSVZxVCs2VVpCUzhCMUJ2QmszdCt3dFhTb0hK?=
 =?utf-8?B?ajA4REV6empSa3N0YzRVOWVKSmE1czVCdWZQc29JY2ovOXFROWVwU3l3SzZp?=
 =?utf-8?B?dUQxUnBiaVdPUVgvNmFzZUoreUR6VHBEcjJ4N3ZRZmFKbTZ1bGhBaFQ5RTA2?=
 =?utf-8?B?MS9wT1VGVGVGU2wzOS9nYmM0Y2lFTFBsRE9yZDNkZ0ozZTZrNHUxQnEzdTBD?=
 =?utf-8?B?bkh0cmxyNWtUMFBYR0N0NjZWWVZKZjlwUXZIU09Kb3RnSGxzU0JncnJuOHNN?=
 =?utf-8?B?aVQ2eTdGZm1jY1A4MC9ma2xSZlcwOElBakozNXA5RmJWRkc3N2g0THBHd2sw?=
 =?utf-8?B?RXY2clBFRk5hT3JvZGJ4TGM0OHEzeHlkM2pWczlpWkhHU1F1eHJnMzk4dXpE?=
 =?utf-8?Q?5E4IJo1wb1PLk2xesLlRBv1Xo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c473957-6cfc-41cf-83b4-08dd0868d95a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 07:07:37.2183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7usb0VBycaBjCvmzFLOVR2v9NxF0HH61SymCzOgCV0zaEM4FqMwh0gDjB29q/PQjylhF99r0GAaPevBxW1xwNMbHarbMFjqYqojfimq/hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7781
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE5LCAy
MDI0IDI6MDAgQU0NCj5TdWJqZWN0OiBSZTogbmVzdGVkLXNtbXV2MyB0b3BpYyBmb3IgUUVNVS9s
aWJ2aXJ0LCBOb3YgMjAyNA0KPg0KPkhpIE5pY29saW4sDQo+DQo+T24gMTEvNy8yNCAyMTozMSwg
Tmljb2xpbiBDaGVuIHdyb3RlOg0KPj4gSGkgRXJpYywNCj4+DQo+PiBPbiBUaHUsIE5vdiAwNywg
MjAyNCBhdCAxMjoxMTowNVBNICswMTAwLCBFcmljIEF1Z2VyIHdyb3RlOg0KPj4+IE9uIDExLzEv
MjQgMDU6MDksIE5pY29saW4gQ2hlbiB3cm90ZToNCj4+Pj4gSGksDQo+Pj4+DQo+Pj4+IFRoaXMg
aXMgYSBjb250aW51ZWQgZGlzY3Vzc2lvbiBmb2xsb3dpbmcgcHJldmlvdXMgbW9udGgnczoNCj4+
Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9adnIlMkZiZjdLZ0xOMWNqT2xA
QXN1cmFkYS1OdmlkaWEvDQo+Pj4+DQo+Pj4+IEtlcm5lbCBjaGFuZ2VzIGFyZSBnZXR0aW5nIGNs
b3NlciB0byBtZXJnZSwgYXMgSmFzb24ncyBwbGFubmluZyB0bw0KPj4+PiB0YWtlIHZJT01NVSBz
ZXJpZXMgYW5kIHNtbXV2M19uZXN0aW5nIHNlcmllcyBpbnRvIHRoZSBpb21tdWZkIHRyZWU6DQo+
Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4xNzMwMzEzNDk0LmdpdC5uaWNv
bGluY0BudmlkaWEuY29tLw0KPj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvY292ZXIu
MTczMDMxMzQ5NC5naXQubmljb2xpbmNAbnZpZGlhLmNvbS8NCj4+Pj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzAtdjQtOWU5OWI3NmYzNTE4KzNhOC0NCj5zbW11djNfbmVzdGluZ19qZ2dA
bnZpZGlhLmNvbS8NCj4+Pj4NCj4+Pj4gU28sIEkgdGhpbmsgaXQncyBwcm9iYWJseSBhIGdvb2Qg
dGltZSB0byBhbGlnbiB3aXRoIGVhY2ggb3RoZXJzIGFuZA0KPj4+PiB0YWxrIGFib3V0IGtpY2tp
bmcgb2ZmIHNvbWUgUUVNVSB1cHN0cmVhbSB3b3JrIGluIHRoZSBtb250aCBhaGVhZC4NCj4+Pj4N
Cj4+Pj4gQFNoYW1lZXIsDQo+Pj4+IERvIHlvdSBoYXZlIHNvbWUgdXBkYXRlIG9uIHRoZSBwbHVn
Z2FibGUgc21tdXYzIG1vZHVsZT8NCj4+Pj4NCj4+Pj4gVXBkYXRlcyBvbiBteSBzaWRlOg0KPj4+
PiAxKSBJIGhhdmUga2VwdCB1QVBJIHVwZGF0ZWQgdG8gdGhlIGxhdGVzdCB2ZXJzaW9uIGFuZCB2
ZXJpZmllZCB0b28uDQo+Pj4+ICAgIFRoZXJlIHNob3VsZCBiZSBzb21lIHBvbGlzaGluZyBjaGFu
Z2VzIGRlcGVuZGluZyBvbiBob3cgdGhlIGJhc2ljDQo+Pj4+ICAgIG5lc3RpbmcgaW5mcmFzdHJ1
Y3R1cmUgd291bGQgbG9vayBsaWtlIGZyb20gSW50ZWwvRHVhbidzIHdvcmsuDQo+Pj4+IDIpIEkg
Z290IHNvbWUgaGVscCBmcm9tIE5WSURJQSBmb2xrcyBmb3IgdGhlIGxpYnZpcnQgdGFzay4gQW5k
IHRoZXkNCj4+Pj4gICAgaGF2ZSBkb25lIHNvbWUgZHJhZnRpbmcgYW5kIGFyZSBub3cgdmVyaWZ5
aW5nIHRoZSBQQ0kgdG9wb2xvZ3kNCj4+Pj4gICAgd2l0aCAiaW9tbXU9bm9uZSIuDQo+Pj4+DQo+
Pj4+IE9uY2UgdGhlIHBsdWdnYWJsZSBzbW11djMgbW9kdWxlIGlzIHJlYWR5IHRvIHRlc3QsIHdl
IHdpbGwgbWFrZSBzb21lDQo+Pj4+IGNoYW5nZSB0byBsaWJ2aXJ0IGZvciB0aGF0IGFuZCBkcm9w
IHRoZSBhdXRvLWFzc2lnbmluZyBwYXRjaGVzIGZyb20NCj4+Pj4gdGhlIFZJUlQgY29kZSwgc28g
YXMgdG8gY29udmVyZ2UgZm9yIGEgbGlidmlydCtRRU1VIHRlc3QuDQo+Pj4+DQo+Pj4+IEZXSVcs
IFJvYmluIHJlcXVlc3RlZCBhIGRpZmZlcmVudCBzb2x1dGlvbiBmb3IgTVNJIG1hcHBpbmcgWzFd
LCB2LnMuDQo+Pj4+IHRoZSBSTVIgb25lIHRoYXQgd2UgaGF2ZSBiZWVuIHVzaW5nIHNpbmNlIEVy
aWMncyB3b3JrLiBJIGRyYWZ0ZWQgYQ0KPj4+PiBmZXcgVkZJTy9JT01NVUZEIHBhdGNoZXMgZm9y
IHRoYXQsIHlldCBwYXVzZWQgZm9yIGdldHRpbmcgdGhlIHZJT01NVQ0KPj4+PiBzZXJpZXMgbWVy
Z2VkIHRvIHRoaXMga2VybmVsIGN5Y2xlLiBJIHBsYW4gdG8gY29udGludWUgaW4gTm92L0RlYy4N
Cj4+Pj4gU28sIGZvciB0aGUgbmVhciB0ZXJtIHdlIHdpbGwgY29udGludWUgd2l0aCB0aGUgUk1S
IHNvbHV0aW9uLCB1bnRpbA0KPj4+PiB3ZSBoYXZlIHNvbWV0aGluZyBzb2xpZCBsYXRlci4NCj4+
Pj4NCj4+Pj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11L1pyVk4wNVZ5
bEZxOGxLNHFAQXN1cmFkYS1OdmlkaWEvDQo+Pj4gQXQgUmVkIEhhdCB3ZSBtYXkgZmluZCBzb21l
IGN5Y2xlcyB0byByZXN1bWUgd29ya2luZyBvbiB0aGUgUUVNVQ0KPj4+IGludGVncmF0aW9uLiBQ
bGVhc2UgY2FuIHlvdSBza2V0Y2ggc29tZSB0YXNrcyB3ZSBjb3VsZCBjYXJyeSBvdXQgaW4NCj4+
PiBjb29yZGluYXRpb24gd2l0aCB5b3UgYW5kIFNoYW1lZXI/IEFkZGluZyBEb24gaW4gdGhlIGxv
b3AuDQo+PiBUaGF0IGlzIGdyZWF0IQ0KPj4NCj4+IFNvLCBnaXZlbiB0aGF0IFNoYW1lZXIgaXMg
d29ya2luZyBvbiBwbHVnZ2FibGUgbW9kdWxlIHBhcnQgYW5kIHdlDQo+PiBoYXZlIGZvbGtzIHdv
cmtpbmcgb24gbGlidmlydC4gSSB0aGluayB0aGUgb25seSBiaWcgdGhpbmcgaGVyZSBpcw0KPj4g
dGhlIFNNTVV2MyBzZXJpZXMgaXRzZWxmLiBQbGVhc2UgcmVmZXIgdG8gdGhlIGNoYW5nZXMgaW4g
dGhlIGxpbms6DQo+PiAgLSBjb3Zlci1sZXR0ZXI6IEFkZCBIVyBhY2NlbGVyYXRlZCBuZXN0aW5n
IHN1cHBvcnQgZm9yIGFybSBTTU1VdjMNCj4+ICAtIGh0dHBzOi8vZ2l0aHViLmNvbS9uaWNvbGlu
Yy9xZW11L2NvbW1pdHMvd2lwL2Zvcl9zbW11djNfbmVzdGluZy12NC8NCj5Mb29raW5nIGF0IHlv
dXIgYnJhbmNoIEkgc2VlIHRoZSBmb2xsb3dpbmcgc2VyaWVzIChtYXJrZWQgd2l0aCBjb3Zlci1s
ZXR0ZXIpDQo+Kg0KPg0KPiAgKg0KPg0KPiAgICBjb3Zlci1sZXR0ZXI6IEFkZCBSTVIgV0FSIGZv
ciBNU0kgbWFwcGluZ3MgKGJhc2VkIG9uIGZvcm1lciBSTVIgZmxhdA0KPiAgICBtYXBwaW5nIGFu
ZCBub3QgcmVsYXRlZCB0byAqW1BBVENIIFJGQ3YxIDAvN10gdmZpbzogQWxsb3cgdXNlcnNwYWNl
DQo+ICAgIHRvIHNwZWNpZnkgdGhlIGFkZHJlc3MgZm9yIGVhY2ggTVNJIHZlY3Rvcg0KPiAgICA8
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtL2NvdmVyLjE3MzExMzAwOTMuZ2l0Lm5pY29saW5j
QG52aWRpYS5jb20vI3I+DQo+ICAgIEkgZ3Vlc3MpKg0KPg0KPiAgKg0KPg0KPiAgICBjb3Zlci1s
ZXR0ZXI6IGh3L2FybS92aXJ0OiBBZGQgbXVsdGlwbGUgbmVzdGVkIFNNTVVzIChOaWNvbGluIC0+
DQo+ICAgIFNoYW1lZXIpDQo+DQo+ICAqDQo+DQo+ICAgIGNvdmVyLWxldHRlcjogQWRkIEhXIGFj
Y2VsZXJhdGVkIG5lc3Rpbmcgc3VwcG9ydCBmb3IgYXJtIFNNTVV2Mw0KPiAgICAoTmljb2xpbikN
Cj4NCj4gICoNCj4NCj4gICAgY292ZXItbGV0dGVyOiBBZGQgVklPTU1VIGluZnJhc3RydWN0dXJl
IHN1cHBvcnQgKE5pY29saW4pDQo+DQo+ICAqDQo+DQo+ICAgIGNvdmVyLWxldHRlcjogaW50ZWxf
aW9tbXU6IEVuYWJsZSBzdGFnZS0xIHRyYW5zbGF0aW9uIGZvcg0KPiAgICBwYXNzdGhyb3VnaCBk
ZXZpY2UgKFpoZW56aG9uZykNCj4NCj4gICoNCj4NCj4gICAgY292ZXItbGV0dGVyOiBpbnRlbF9p
b21tdTogRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yIGVtdWxhdGVkDQo+ICAgIGRldmlj
ZSAoWmhlbnpob25nKQ0KPg0KPlRoZSBsYXN0IG9uZSBpcyBjb3ZlcmVkIGJ5ICpbUEFUQ0ggdjUg
MDAvMjBdIGludGVsX2lvbW11OiBFbmFibGUgc3RhZ2UtMQ0KPnRyYW5zbGF0aW9uIGZvciBlbXVs
YXRlZCBkZXZpY2UNCj48aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMTExMDgzNDU3
LjIwOTA2NjQtMS0NCj56aGVuemhvbmcuZHVhbkBpbnRlbC5jb20vI3I+DQo+Kg0KPg0KPipJIHNl
ZSB0aGVyZSBpcyBhIHJlZmVyZW5jZSB0byAqIkVuYWJsZSBzdGFnZS0xIHRyYW5zbGF0aW9uIGZv
cg0KPnBhc3N0aHJvdWdoIGRldmljZSIgc2VyaWVzIGJ1dCBoYXMgaXQgYmVlbiBwb3N0ZWQgZm9y
IHJldmlldz8gQWRkaW5nDQo+Wmhlbnpob25nIGluIGNvcHkuDQoNClRoZXJlIGlzIGFuIFJGQ3Yx
IHBvc3RlZCB1cHN0cmVhbSB3aGljaCBpcyBhIGNvbWJpbmF0aW9uIG9mDQoiIGludGVsX2lvbW11
OiBFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3IgZW11bGF0ZWQgZGV2aWNlIiBhbmQNCiIg
aW50ZWxfaW9tbXU6IEVuYWJsZSBzdGFnZS0xIHRyYW5zbGF0aW9uIGZvciBwYXNzdGhyb3VnaCBk
ZXZpY2UiLg0KTGluazogaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRl
dmVsLzIwMjQtMDEvbXNnMDI3NDAuaHRtbA0KDQpJZiB5b3UgbWVhbnMgdGhlIHNwbGl0IHZlcnNp
b24sIG5vdCBzZW50IHlldC4gUGxhbiBpdCBhZnRlciB0aGUgc2VyaWVzIGFib3V0DQplbXVsYXRl
ZCBkZXZpY2UgaXMgYWNjZXB0ZWQuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

