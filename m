Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC79CCA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 02:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utzqc-0003di-8B; Wed, 03 Sep 2025 22:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1utzqZ-0003dQ-Hk
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 22:37:11 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1utzqW-00021c-0G
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 22:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756953428; x=1788489428;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=P6DL3WNTVvYlMSlCpUoUiu/kuxlXWLdSAL5VMPrqdrk=;
 b=h0xoaXUu20crjIokwTsPvogu+VrVYGw4CqlWL6EIKDANuXC7vhKxZ/VB
 mSbyz0Z1NJj0BEVdWUdOi6xm//ZJVIhubOg0xMlRmb7bvEseKksn4m7n7
 L5GWxThVkNJYSkwkx+MV/EiRY8VutZUjWtPhlO9mCSA3msPFopYjYIfEn
 7Ap8hkQJ4fcE/ejaCQPrIRB0Z628oDvh6uYHnrqZ3kDRt0uWFHFTL75Ut
 +9NLOWxK0wRzekxhoox8fzHESi7gZPi3PSwpDFlkUzM6+TuXXzSmeiyPC
 6/iDldSuJKpdBd+TGOumiKQ2VKNRsO17DVcnG2zTLkbmk4flMUV8I0hZI w==;
X-CSE-ConnectionGUID: tLL+5OobTOe7Ptzn8t31jQ==
X-CSE-MsgGUID: Anzn4885RsuBqocKPIhsxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59137620"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; d="scan'208";a="59137620"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 19:37:05 -0700
X-CSE-ConnectionGUID: DLTz9PwWRQOQwGUgyLdLhA==
X-CSE-MsgGUID: h9FJMt1hR1SPYI4L8uqK8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; d="scan'208";a="171885205"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 19:37:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 19:37:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 19:37:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.80) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 19:37:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzcEys5SRYhJez+1QBaA1pFDauiByJJbAPzbKJAfGTLRkrl8aiKTxnuOFxRXDUe5axLnRx75fql3FJJFH1rdKCjrsAtRT856HvkIZ1lkmOEzO8dU+IxI3T/o1HjVAFNJfGO6js8/Te1nLy26juYPn4SgN9oWG4NcQ0T7+QwlQSQDVPYVGaHd9vn4kFLUyK2TAxMs/f1HP7VdwWL6FgbxJwu7BJolGB+9bhF+ItKiuVCGbSyQSAQpz+r5Jqb2ncRaK8lD8Sqt/t6/n499xGS8M7qFV3DbOAYjkpzkki93uZRLbZbRPSpbQ1OzR6Tj4/X+iY4Hl245rTmQPNywTZylHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6DL3WNTVvYlMSlCpUoUiu/kuxlXWLdSAL5VMPrqdrk=;
 b=pR6QQxLtZB7rHUS1Dk2/6pATtQScsvKneedPIsA9aGNPInSY2n7nsskl8rjEBwZxyX9n/IoVBu8/HegNyii2c5lcM9snJqe3zXqBYIf5fjEzx8IO90Xd+ukodhzvStcJyo4l/xfZVMgQZ8vibO4+QFpkxskxT5gP30k3BQOlST63zGwokHl6sVoCBixA5S14fTbBbIaN3iVU8MxVkSvgaMljusZejOs514KmMcZajeZjMWkN18MELchtBfQiSq29tOMMHeZx3dSAMXPtAU4mUD9F7ElvMEP2m9M2i+JT5B22UoacF+cx0mRs2vC0XQuXT1xP/MJyWdFc83prgqZ2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by LV3PR11MB8742.namprd11.prod.outlook.com (2603:10b6:408:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 02:37:01 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 02:37:01 +0000
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
Thread-Index: AQHcEy/oRsc7Lu/sH0aYzDboCey+yrR4Aa6AgAW195CAA3MFgIABOAyw
Date: Thu, 4 Sep 2025 02:37:01 +0000
Message-ID: <IA3PR11MB91365A557AC68953898F3CEB9200A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-12-zhenzhong.duan@intel.com>
 <5ccc7892-2024-409b-b107-4ffa02e31b71@intel.com>
 <IA3PR11MB9136FC723C303B92F4957C179207A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <7435cb2a-929d-4565-848d-8a4520ade461@intel.com>
In-Reply-To: <7435cb2a-929d-4565-848d-8a4520ade461@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|LV3PR11MB8742:EE_
x-ms-office365-filtering-correlation-id: 3dd095b4-ec10-4afb-3c92-08ddeb5bed57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Tk9QZ0t0OVAvckxlczJqZWRrMUpwVjdYVlJiTHVqTEQ0MVVTVGNaR09PVUc0?=
 =?utf-8?B?bTE1UFE1VGYwdjZJN2lPSUxkZGhac3lPcUllK3hnNnIzVm0vS0tPeCtpZEhI?=
 =?utf-8?B?dVcyRE1kZUU1L2xiLy9xMVZ2azJEWDhTMWYrMUp0My9oWHNsYVcrc3ZnaXlU?=
 =?utf-8?B?OUd3S1lvN0JRSDJHVkFpaHJyOFYydktHMVhaK3ZJblh5MUtYR3llajZjNDc1?=
 =?utf-8?B?SzlwNkRYSXZlL1l3ckM2amN3Z2pzR25sZmZVY0RoZkVBU2lMYzMxZ2pNT0lC?=
 =?utf-8?B?VUdoZnBzUzkwSUNldllkUVBPK1ZUZnJ5YW42cjJtUzA1UVBwQUorUEN4TDhU?=
 =?utf-8?B?a0l5cnZHSlliZDVnSmIzUUNIZ2dyd0Zoai9SL1diV29EL3d3azc5Q1JyWmpk?=
 =?utf-8?B?STA1ZkpOdGlXZlowSEhBTnRaMlZHaU5OdGVNdENmeVZjejNaT2lPc2RJeERv?=
 =?utf-8?B?OFJhNUVHc3g4MGZhRWRjMkNjWlgxTmRoUEo2SWl5dXk2bTU1NGduamRZWjZi?=
 =?utf-8?B?Ky9jc1E0UEgyeG1jMGJBWFpKTUVLVE5KeEZEZTdlb092cFlEZlRDdm92UGtT?=
 =?utf-8?B?VFFMNTg0Rm95TktVcE5zVlBhUGR0Q2svRFpDNzBMN2NNVVpLSnFBTVA4VFpC?=
 =?utf-8?B?cUJ2ZTErWFpFblpYYjVsM0plRTJ0UzhHUzh6ekNXSGFzUHNSWkZCM0Zaak1M?=
 =?utf-8?B?dG9hRWR3cGhDMnV3RzRRUi9NMjdEajZrTXcvaXZNYUhjNjVPdVUrUzZEcm1T?=
 =?utf-8?B?UDN5endrM3JqNTd6cjVjenpUZVRyQVBRSE82L0dZZTBGQUFydjdKSTJSY2hY?=
 =?utf-8?B?U3ZkYmVvSUc3Ymo5WkYvN3FYOVlTeVZja1FETmltaW4yRkFSc1dKS0cxa3pB?=
 =?utf-8?B?ZEhzc2JwWTF5OEU5eERXQS9lMzlqNVZFa2VmcENDVDZDWHhwTWEzeVZYa2kx?=
 =?utf-8?B?cmFRL3N4REVnUlpFc2VKSlgvR2YyRmVaTS9zTjBSbFhKak50bjhZL0M4YVEw?=
 =?utf-8?B?U09ZaGVQT2YwY0h3bEhoUjBCanlyaE9PTWhOcU5NM3FXd0hPNUd2am1rdXEr?=
 =?utf-8?B?UDlYeDhWMWVzRGp6OGV5TUpGVG1iNGJKdVR3dWxCZ1ZqdzBrNFlHK3hvUTZB?=
 =?utf-8?B?KzhIeXE4QVRPd0xZOWVYa25adHVES0tXUXFuVUhKRFJtNGtWVERIWUF6Zldi?=
 =?utf-8?B?dWg0ZHFEQnM0SGZHSDVSV1pOL1FDZDMzcVh3b3h0WTBUQmNBREhjVXB2bmpa?=
 =?utf-8?B?TCs2cEdrcktmQ2NyeUFYRC9UWmZ4TGVSaFVSZ0UzOWRFWE05V3Zld2VNSHF0?=
 =?utf-8?B?TG1PRTJmM0xZdmtTNXNSMlBhUXV2UUR3N1NVbE5FTE9HUVZUZHVOZU1RdU5S?=
 =?utf-8?B?eUJHNmVMNjAvSDg0MXBjWmlMRGY3WE5oVkIzeDFLWExOMENSOEJOSWMrZzFV?=
 =?utf-8?B?MUlhUG5ocmhFbHFhV1dxcXpFczNMdzVaTFp4RzJyRDAxdEtrcEZUS2t1ZnBz?=
 =?utf-8?B?RGtpRzhGdHcrZWRiZ3YzV3psSEluUkpZbE5XQWwxSkZOZ2ViRko1eFRhRzEw?=
 =?utf-8?B?VFkzejZCWlpLK0RLbEFaZkY0MGVTTVlrcnZ3TGdzaVBodXY3QWhTR3FXOEdy?=
 =?utf-8?B?Ym5rSkF4djVxcWRNZ2VnZGtkNFlqQUkwUkJiQUw3dUxLZTZCbFhuc3ZyRVM0?=
 =?utf-8?B?ZXEwZWh0MWlINnJwNVhJQ045U3dTWU5kMjk4TEJTdDZzRWYvaVN1QmwrMity?=
 =?utf-8?B?dGs3b3U4YkFOalZEaHZ6bjc5RU5KTDh3c0pSVmJxUzVWK05rckVMWTh2Z0ZP?=
 =?utf-8?B?Y1crT2ZkOHBsdXNKMDY4MHNKeEhYY0JWbXJBaklibWNJcm9PSjdlaEloTjJR?=
 =?utf-8?B?cWdJa0RDdFFnR1ZmdWhMYmY1c3ZOVjRyOUZaWFU0RGVsbTZSbnlFQkp5UGRy?=
 =?utf-8?B?R0czbnFNVEVFZWRIemJoYlZrb0wxMmtMckUyZEVIbWlQMnhTWWZva2JRUi9k?=
 =?utf-8?B?ZlI3bFRieUhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Kzh0UHM0Q3ZwMEJyUWFSSVZONUphVzZKNjRHTHhKVXVmTjJBR2NiSVFHQnVS?=
 =?utf-8?B?WTZIbnkybmZHNG4rdVBWendRbjhJTEo4UzZiRmNPeEYvQlVHNHVTRzZMN0hv?=
 =?utf-8?B?a0FHRXlzRHAvK2hEdlVUU2NkVTY4RWo4enpoMm5ySUNFUjVUbyt5ZDFBOThn?=
 =?utf-8?B?MkVBdU5QcVk4allJMVYxQ0hrcmh0M3R2OVF1Ym1yTXovUmZvVStWbDIrV3Ix?=
 =?utf-8?B?ZGFWZ1UvNE8rZlJLTk9NekdYMmVqYVhOQ2JYaXIrODZIRFpzcnZzckp3Z21p?=
 =?utf-8?B?QzlVVFBjZ2RkTkFqaE9sS3FPY3laa3RuSTlBdGFPNDE4dXFqTmdGWFU2L2xI?=
 =?utf-8?B?dUxwQmc1T3JqaFZjMlVUcy9hYkJmYk5QYVNXRW1FbTN0WWpSMFpyRnZ4QUpa?=
 =?utf-8?B?dSt4SHdTZjJodFJMSmsxbjJuMnNmamZHNitzaTJ6VjlpQXBMd2p3UVRlYjN1?=
 =?utf-8?B?ZUE4UlR6Y3U0RDlBUEpOQUxaa0FZRnJUUTNaV0hSbENybDc4ZzM5cmQ4elBa?=
 =?utf-8?B?ek9oV0VhWmxjNEQvMjhPZDh6R3RMcDk4OE1jZTFUSkQxcFl3dTIxRjhzTXFN?=
 =?utf-8?B?ckVydmhhZWhjZHhYRXFEV213eXFKaXFtVWphVUVFVVBrWTRFWUhPYXFzYlNn?=
 =?utf-8?B?Um50K2NRVUFEMFZISTFFWjZvNDRQKzVtSWlqU1ZFeUR2SEJlRmNsRndCV0hD?=
 =?utf-8?B?aUVKZFhDVnBDdWkxZnVucWRvZzJ0WnZQWmlyTnV4bmZhcXpuaDVIb1NUQVho?=
 =?utf-8?B?NnZ2MENLM2ZqaFU4dC9rbTh3eFp0TnRwdHBqK21kRjhpNGxBdUIrdytRVm9z?=
 =?utf-8?B?ejBxTFNZenJoUFZzZHB3dEhod0VoYkVnMTlObXNoczcwRklUOFFvRmlBZHZ4?=
 =?utf-8?B?TjhPNTRyaXgxT2hPRFYxdTF5R2h5UWYwWWRiYnRTbXdMV2VzUHp3alF4ZFRp?=
 =?utf-8?B?LzFDeU9STkh0SDJPTS9GYzl5bGVvVVZpUi81bi9OUTVJWldlNDRhVjQzVWY3?=
 =?utf-8?B?aUpJTXhKbkdPWHhUM2U2czZOaVp2YTZoT0g0QWpzNUpQc2JrRlhRWTV5TXpJ?=
 =?utf-8?B?Ny9QdjF4WFZHTWY0M0ZqclA5V0NlWEtZKzlFVHQ3dUdBVEFaRXZqeE9OUm5T?=
 =?utf-8?B?NG42dERXUTdidC9OaEJMcWdYdzBxQzUyR3M2ZDdidVdhd3ZIc2NxMWYrTUQr?=
 =?utf-8?B?emRFN0xaVlN1Z2wyeFBTN3o1dVhIWUdtVEIyVWtlcjNSUmg0dVRtRWxQNHFB?=
 =?utf-8?B?WU1GL28wUUI2WXBtb1cwNEExclM4Y2o0T1dBVHEwWGRmcXJjVGdwd1VtWTc0?=
 =?utf-8?B?dDZXVUdmRXREcndMTzdSQ1lyQ2o4cXdySEovR2JUMld3clJEbDkwTGxPY0xI?=
 =?utf-8?B?NytaRHRlVjlUVmFPdW1ZUDlYcTVXTGwvd0didWxvLzJudVhJWGhNNi9aZWo0?=
 =?utf-8?B?OERSQlo1MEczWmsyZXJUVVFMTmozdXY3b0w0UWQ0VjIxbGxqa2ZSSkxYL1pp?=
 =?utf-8?B?L2NMY1BGTGVIYUJVNGRyN1NuWXJ6SzRKQ0lwOVA1dFI0UFJEdmZsK29BZ3J3?=
 =?utf-8?B?aXdUL25rQWtFb011cFRJMi95Z3VPZXZ4OFlLT0ZKN2NsUnUwdDRGTWFGdFlp?=
 =?utf-8?B?QW8zckZ1TjhRL1pOMGFDemdUa3ZiRXQzTnBRSk11dlNvaS90N0ZlWFBBU01n?=
 =?utf-8?B?U1BQdUxjRVhmRFhQRnBzY2xyNlNzRGlZZWFqMVBteVdPYXRiQVMyTG5RVnpR?=
 =?utf-8?B?Z21rVHRuN3dhdmtMV01qWlNMTFU1SE1aQWE3Tk9xa1ZkbnBBbTNwbUlWdWZ5?=
 =?utf-8?B?WE5IOWg2TDU5Vk50bmY3S3gxakhMUHB3Q0RVZkNyVHhPbm9QbldzRHNxTWxW?=
 =?utf-8?B?c2FnWVpqMXBQTVgxSEJ0d01tT243QU5VRXhwOFVtSWVMQ0M4ejZCeSt0RDRT?=
 =?utf-8?B?WUcrOXpaSnNmNndabnZzMWtxSWZCQ0JNMUVWbkxoT2RMQVBrVVV5d3JxSGpk?=
 =?utf-8?B?azFmZmxRTnhFc2s5NE1ZWlNnMDNIREYySTA4aloxZzJVRHJ3UlUzS0tjM0ox?=
 =?utf-8?B?V2dnY05sNjVFSmNmSGFOS1JtMDJEUytyZUlXN2RWN2JRdnhLcnV1eDV0QmZY?=
 =?utf-8?Q?JBjRM5bDBKemm0pVVf3Vgn8u/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd095b4-ec10-4afb-3c92-08ddeb5bed57
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 02:37:01.2346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Voi7Yh4TIgkVFoUInoOeTK7inDIbdTP1yJCA40LzCJ8Guw7zYmo7EebzNBHesWku4/msdH2t9OkVUVABhYHwE5xaQQmHJ+y+duLB5BhxdhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8742
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
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
OiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBhbmQNCj51cGRhdGUNCj4NCj5PbiAyMDI1Lzkv
MSAxMTozMSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDExLzIxXSBpbnRlbF9pb21tdTogSGFuZGxlIFBB
U0lEIGVudHJ5IHJlbW92YWwNCj5hbmQNCj4+PiB1cGRhdGUNCj4+Pg0KPj4+IE9uIDIwMjUvOC8y
MiAxNDo0MCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IFRoaXMgYWRkcyBhbiBuZXcgZW50
cnkgVlREUEFTSURDYWNoZUVudHJ5IGluIFZUREFkZHJlc3NTcGFjZSB0bw0KPmNhY2hlDQo+Pj4g
dGhlDQo+Pj4+IHBhc2lkIGVudHJ5IGFuZCB0cmFjayBQQVNJRCB1c2FnZSBhbmQgZnV0dXJlIFBB
U0lEIHRhZ2dlZCBETUEgYWRkcmVzcw0KPj4+PiB0cmFuc2xhdGlvbiBzdXBwb3J0IGluIHZJT01N
VS4NCj4+Pg0KPj4+IEhhdmUgeW91IHNlZW4gYW55IGV4dHJhIGNvZGUgbmVlZGVkIGJhc2VkIG9u
IHRoaXMgc2VyaWVzIHRvIHN1cHBvcnQgbm9uDQo+Pj4gcmlkX3Bhc2lkIFBBU0lEcz8gSWYgbm8s
IG1heSBqdXN0IHJlbGF4IHRoZSBzY29wZSBvZiB0aGlzIHNlcmllcy4NCj4+PiBvdGhlcndpc2Us
IHlvdSBtYXkgbmVlZCB0byB0d2VhayB0aGUgcGF0Y2ggYSBsaXR0bGUgYml0LiBlLmcuIGZhY3Rv
cg0KPj4+IG91dCBzZXR0aW5nIHgtZmx0cyBhbmQgeC1wYXNpZC1tb2RlIGF0IHRoZSBzYW1lIHRp
bWUuDQo+Pg0KPj4gVGhlcmUgYXJlIHF1aXRlIGEgZmV3IGNvZGUgYXJlIGNvbW1vbiBmb3IgYm90
aCBub24tcmlkX3Bhc2lkIGFuZA0KPnJpZF9wYXNpZC4NCj4+IFNvIGluIHRoaXMgc2VyaWVzLCB0
aGVyZSBhcmUgc29tZSBpbmZyYXN0cnVjdHVyZSBjb2RlIHRoYXQgbG9va3MgbGlrZSBpdCdzIGZv
cg0KPm5vbi1yaWRfcGFzaWQuDQo+Pg0KPj4gQnV0IHRvIHN1cHBvcnQgbm9uLXJpZF9wYXNpZCwg
d2UgbmVlZCBwYXNpZF9hdHRhY2gvZGV0YWNoKCkgd2hpY2ggaXMgbm90DQo+aW1wbGVtZW50ZWQg
aW4gdGhpcyBzZXJpZXMuDQo+DQo+SSBzZWUuIEJlc2lkZXMgdGhhdCwgdGhlIHZJT01NVSBpbnRl
cm5hbCBpbmZyYXN0cnVjdHVyZSBzaG91bGQgYmUgcmVhZHkNCj5mb3Igbm9uLXJpZF9wYXNpZCBh
ZnRlciB0aGlzIHNlcmllcy4NCg0KT2tleSwgSSdsbCBmb2xsb3dpbmcgeW91IGFuZCBFcmljJ3Mg
c3VnZ2VzdGlvbiB0byBzaW1wbGlmeSB0aGlzIHNlcmllcyB3aXRoIG9ubHkgcmlkX3Bhc2lkIHN1
cHBvcnQuDQoNClRoYW5rcw0KDQo+DQo+PiBFdmVuIGlmIHgtZmx0cyBhbmQgeC1wYXNpZC1tb2Rl
IGJvdGggb24sIHBhc2lkIGlzbid0IGVuYWJsZWQgc2luY2UgVkZJTw0KPmRldmljZSBkb2Vzbid0
ID4gZXhwb3NlIHBhc2lkIGNhcGFiaWxpdHkgdG8gZ3Vlc3QsIHNvIGd1ZXN0IG5ldmVyIHVzZQ0K
Pm5vbi1yaWRfcGFzaWQNCj53aXRoIHRoaXMgVkZJTyBkZXZpY2UuDQo+DQo+b2suIEdpdmVuIHRo
YXQgMXN0IHN0YWdlIGZvciBlbXVsYXRlZCBkZXZpY2UgaGFzIGFscmVhZHkgc2JlZW4gdXBwb3J0
ZWQsDQo+aXQncyBmaW5lIHRvIHJlbHkgb24gdGhlIGtub2IgaW4gZGV2aWNlIHNpZGUuDQo+DQo+
Pj4+DQo+Pj4+IFZUREFkZHJlc3NTcGFjZSBvZiBQQ0lfTk9fUEFTSUQgaXMgYWxsb2NhdGVkIHdo
ZW4gZGV2aWNlIGlzIHBsdWdnZWQNCj5hbmQNCj4+Pj4gbmV2ZXIgZnJlZWQuIEZvciBvdGhlciBw
YXNpZCwgVlREQWRkcmVzc1NwYWNlIGluc3RhbmNlIGlzDQo+Pj4gY3JlYXRlZC9kZXN0cm95ZWQN
Cj4+Pj4gcGVyIHRoZSBndWVzdCBwYXNpZCBlbnRyeSBzZXQgdXAvZGVzdHJveS4NCj4+Pg0KPj4+
PiBXaGVuIGd1ZXN0IHJlbW92ZXMgb3IgdXBkYXRlcyBhIFBBU0lEIGVudHJ5LCBRRU1VIHdpbGwg
Y2FwdHVyZSB0aGUNCj5ndWVzdA0KPj4+IHBhc2lkDQo+Pj4+IHNlbGVjdGl2ZSBwYXNpZCBjYWNo
ZSBpbnZhbGlkYXRpb24sIHJlbW92ZXMgVlREQWRkcmVzc1NwYWNlIG9yIHVwZGF0ZQ0KPj4+IGNh
Y2hlZA0KPj4+PiBQQVNJRCBlbnRyeS4NCj4+Pj4NCj4+Pj4gdklPTU1VIGVtdWxhdG9yIGNvdWxk
IGZpZ3VyZSBvdXQgdGhlIHJlYXNvbiBieSBmZXRjaGluZyBsYXRlc3QgZ3Vlc3QNCj5wYXNpZA0K
Pj4+IGVudHJ5DQo+Pj4+IGFuZCBjb21wYXJlIGl0IHdpdGggY2FjaGVkIFBBU0lEIGVudHJ5Lg0K
Pj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+
Pj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo+Pj4+IC0tLQ0KPj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgMjcg
KysrKy0NCj4+Pj4gICAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggIHwgICA2ICsNCj4+
Pj4gICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMTk2DQo+Pj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+Pj4+ICAgIGh3L2kzODYvdHJhY2UtZXZlbnRzICAg
ICAgICAgICB8ICAgMyArDQo+Pj4+ICAgIDQgZmlsZXMgY2hhbmdlZCwgMjIwIGluc2VydGlvbnMo
KyksIDEyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4gYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgN
Cj4+Pj4gaW5kZXggZjc1MTA4NjFkMS4uYjliNzZkZDk5NiAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPj4+PiBAQCAtMzE2LDYgKzMxNiw3IEBAIHR5cGVkZWYgZW51bSBWVERG
YXVsdFJlYXNvbiB7DQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
IHJlcXVlc3Qgd2hpbGUgZGlzYWJsZWQgKi8NCj4+Pj4gICAgICAgIFZURF9GUl9JUl9TSURfRVJS
ID0gMHgyNiwgICAvKiBJbnZhbGlkIFNvdXJjZS1JRCAqLw0KPj4+Pg0KPj4+PiArICAgIFZURF9G
Ul9SVEFERFJfSU5WX1RUTSA9IDB4MzEsICAvKiBJbnZhbGlkIFRUTSBpbiBSVEFERFIgKi8NCj4+
Pj4gICAgICAgIC8qIFBBU0lEIGRpcmVjdG9yeSBlbnRyeSBhY2Nlc3MgZmFpbHVyZSAqLw0KPj4+
PiAgICAgICAgVlREX0ZSX1BBU0lEX0RJUl9BQ0NFU1NfRVJSID0gMHg1MCwNCj4+Pj4gICAgICAg
IC8qIFRoZSBQcmVzZW50KFApIGZpZWxkIG9mIHBhc2lkIGRpcmVjdG9yeSBlbnRyeSBpcyAwICov
DQo+Pj4+IEBAIC00OTMsNiArNDk0LDE1IEBAIHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJ
bnZEZXNjOw0KPj4+PiAgICAjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9WQUwwDQo+
Pj4gMHhmZmYwMDAwMDAwMDBmMWMwVUxMDQo+Pj4+ICAgICNkZWZpbmUgVlREX0lOVl9ERVNDX1BJ
T1RMQl9SU1ZEX1ZBTDEgICAgIDB4ZjgwVUxMDQo+Pj4+DQo+Pj4+ICsvKiBQQVNJRC1jYWNoZSBJ
bnZhbGlkYXRlIERlc2NyaXB0b3IgKHBjX2ludl9kc2MpIGZpZWxkcyAqLw0KPj4+PiArI2RlZmlu
ZSBWVERfSU5WX0RFU0NfUEFTSURDX0coeCkgICAgICAgIGV4dHJhY3Q2NCgoeCktPnZhbFswXSwg
NCwNCj4yKQ0KPj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURDX0dfRFNJICAgICAgIDAN
Cj4+Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEQ19HX1BBU0lEX1NJICAxDQo+Pj4+ICsj
ZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRENfR19HTE9CQUwgICAgMw0KPj4+PiArI2RlZmluZSBW
VERfSU5WX0RFU0NfUEFTSURDX0RJRCh4KSAgICAgIGV4dHJhY3Q2NCgoeCktPnZhbFswXSwgMTYs
DQo+Pj4gMTYpDQo+Pj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRENfUEFTSUQoeCkgICAg
ZXh0cmFjdDY0KCh4KS0+dmFsWzBdLCAzMiwNCj4+PiAyMCkNCj4+Pj4gKyNkZWZpbmUgVlREX0lO
Vl9ERVNDX1BBU0lEQ19SU1ZEX1ZBTDANCj4weGZmZjAwMDAwMDAwMGYxYzBVTEwNCj4+Pj4gKw0K
Pj4+PiAgICAvKiBJbmZvcm1hdGlvbiBhYm91dCBwYWdlLXNlbGVjdGl2ZSBJT1RMQiBpbnZhbGlk
YXRlICovDQo+Pj4+ICAgIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIHsNCj4+Pj4gICAgICAg
IHVpbnQxNl90IGRvbWFpbl9pZDsNCj4+Pj4gQEAgLTU1Myw2ICs1NjMsMjEgQEAgdHlwZWRlZiBz
dHJ1Y3QgVlREUm9vdEVudHJ5IFZURFJvb3RFbnRyeTsNCj4+Pj4gICAgI2RlZmluZSBWVERfU01f
Q09OVEVYVF9FTlRSWV9SU1ZEX1ZBTDAoYXcpICAoMHgxZTBVTEwgfA0KPj4+IH5WVERfSEFXX01B
U0soYXcpKQ0KPj4+PiAgICAjZGVmaW5lIFZURF9TTV9DT05URVhUX0VOVFJZX1JTVkRfVkFMMQ0K
Pj4+IDB4ZmZmZmZmZmZmZmUwMDAwMFVMTA0KPj4+Pg0KPj4+PiArdHlwZWRlZiBlbnVtIFZURFBD
SW52VHlwZSB7DQo+Pj4+ICsgICAgLyogVlREIHNwZWMgZGVmaW5lZCBQQVNJRCBjYWNoZSBpbnZh
bGlkYXRpb24gdHlwZSAqLw0KPj4+PiArICAgIFZURF9QQVNJRF9DQUNIRV9ET01TSSA9IFZURF9J
TlZfREVTQ19QQVNJRENfR19EU0ksDQo+Pj4+ICsgICAgVlREX1BBU0lEX0NBQ0hFX1BBU0lEU0kg
PQ0KPlZURF9JTlZfREVTQ19QQVNJRENfR19QQVNJRF9TSSwNCj4+Pj4gKyAgICBWVERfUEFTSURf
Q0FDSEVfR0xPQkFMX0lOViA9DQo+Pj4gVlREX0lOVl9ERVNDX1BBU0lEQ19HX0dMT0JBTCwNCj4+
Pj4gK30gVlREUENJbnZUeXBlOw0KPj4+PiArDQo+Pj4+ICt0eXBlZGVmIHN0cnVjdCBWVERQQVNJ
RENhY2hlSW5mbyB7DQo+Pj4+ICsgICAgVlREUENJbnZUeXBlIHR5cGU7DQo+Pj4+ICsgICAgdWlu
dDE2X3QgZGlkOw0KPj4+PiArICAgIHVpbnQzMl90IHBhc2lkOw0KPj4+PiArICAgIFBDSUJ1cyAq
YnVzOw0KPj4+PiArICAgIHVpbnQxNl90IGRldmZuOw0KPj4+PiArfSBWVERQQVNJRENhY2hlSW5m
bzsNCj4+Pj4gKw0KPj4+PiAgICAvKiBQQVNJRCBUYWJsZSBSZWxhdGVkIERlZmluaXRpb25zICov
DQo+Pj4+ICAgICNkZWZpbmUgVlREX1BBU0lEX0RJUl9CQVNFX0FERFJfTUFTSyAgKH4weGZmZlVM
TCkNCj4+Pj4gICAgI2RlZmluZSBWVERfUEFTSURfVEFCTEVfQkFTRV9BRERSX01BU0sgKH4weGZm
ZlVMTCkNCj4+Pj4gQEAgLTU3NCw3ICs1OTksNyBAQCB0eXBlZGVmIHN0cnVjdCBWVERSb290RW50
cnkgVlREUm9vdEVudHJ5Ow0KPj4+PiAgICAjZGVmaW5lIFZURF9TTV9QQVNJRF9FTlRSWV9QVCAg
ICAgICAgICAoNFVMTCA8PCA2KQ0KPj4+Pg0KPj4+PiAgICAjZGVmaW5lIFZURF9TTV9QQVNJRF9F
TlRSWV9BVyAgICAgICAgICA3VUxMIC8qIEFkanVzdGVkDQo+Pj4gZ3Vlc3QtYWRkcmVzcy13aWR0
aCAqLw0KPj4+PiAtI2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfRElEKHZhbCkgICAgKCh2YWwp
ICYNCj4+PiBWVERfRE9NQUlOX0lEX01BU0spDQo+Pj4+ICsjZGVmaW5lIFZURF9TTV9QQVNJRF9F
TlRSWV9ESUQoeCkgICAgICBleHRyYWN0NjQoKHgpLT52YWxbMV0sIDAsDQo+MTYpDQo+Pj4+DQo+
Pj4+ICAgICNkZWZpbmUgVlREX1NNX1BBU0lEX0VOVFJZX0ZMUE0gICAgICAgICAgM1VMTA0KPj4+
PiAgICAjZGVmaW5lIFZURF9TTV9QQVNJRF9FTlRSWV9GTFBUUFRSICAgICAgICh+MHhmZmZVTEwp
DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+IGIv
aW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4gaW5kZXggNTBmOWIyN2E0NS4uMGUz
ODI2ZjZmMCAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgN
Cj4+Pj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4gQEAgLTk1LDYg
Kzk1LDExIEBAIHN0cnVjdCBWVERQQVNJREVudHJ5IHsNCj4+Pj4gICAgICAgIHVpbnQ2NF90IHZh
bFs4XTsNCj4+Pj4gICAgfTsNCj4+Pj4NCj4+Pj4gK3R5cGVkZWYgc3RydWN0IFZURFBBU0lEQ2Fj
aGVFbnRyeSB7DQo+Pj4+ICsgICAgc3RydWN0IFZURFBBU0lERW50cnkgcGFzaWRfZW50cnk7DQo+
Pj4+ICsgICAgYm9vbCB2YWxpZDsNCj4+Pj4gK30gVlREUEFTSURDYWNoZUVudHJ5Ow0KPj4+PiAr
DQo+Pj4+ICAgIHN0cnVjdCBWVERBZGRyZXNzU3BhY2Ugew0KPj4+PiAgICAgICAgUENJQnVzICpi
dXM7DQo+Pj4+ICAgICAgICB1aW50OF90IGRldmZuOw0KPj4+PiBAQCAtMTA3LDYgKzExMiw3IEBA
IHN0cnVjdCBWVERBZGRyZXNzU3BhY2Ugew0KPj4+PiAgICAgICAgTWVtb3J5UmVnaW9uIGlvbW11
X2lyX2ZhdWx0OyAvKiBJbnRlcnJ1cHQgcmVnaW9uIGZvciBjYXRjaGluZw0KPj4+IGZhdWx0ICov
DQo+Pj4+ICAgICAgICBJbnRlbElPTU1VU3RhdGUgKmlvbW11X3N0YXRlOw0KPj4+PiAgICAgICAg
VlREQ29udGV4dENhY2hlRW50cnkgY29udGV4dF9jYWNoZV9lbnRyeTsNCj4+Pj4gKyAgICBWVERQ
QVNJRENhY2hlRW50cnkgcGFzaWRfY2FjaGVfZW50cnk7DQo+Pj4+ICAgICAgICBRTElTVF9FTlRS
WShWVERBZGRyZXNzU3BhY2UpIG5leHQ7DQo+Pj4+ICAgICAgICAvKiBTdXBlcnNldCBvZiBub3Rp
ZmllciBmbGFncyB0aGF0IHRoaXMgYWRkcmVzcyBzcGFjZSBoYXMgKi8NCj4+Pj4gICAgICAgIElP
TU1VTm90aWZpZXJGbGFnIG5vdGlmaWVyX2ZsYWdzOw0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+IGluZGV4IDE4MDFm
MWNkZjYuLmEyZWU2ZDY4NGUgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gQEAgLTE2NzUsNyArMTY3
NSw3IEBAIHN0YXRpYyB1aW50MTZfdA0KPj4+IHZ0ZF9nZXRfZG9tYWluX2lkKEludGVsSU9NTVVT
dGF0ZSAqcywNCj4+Pj4NCj4+Pj4gICAgICAgIGlmIChzLT5yb290X3NjYWxhYmxlKSB7DQo+Pj4+
ICAgICAgICAgICAgdnRkX2NlX2dldF9wYXNpZF9lbnRyeShzLCBjZSwgJnBlLCBwYXNpZCk7DQo+
Pj4+IC0gICAgICAgIHJldHVybiBWVERfU01fUEFTSURfRU5UUllfRElEKHBlLnZhbFsxXSk7DQo+
Pj4+ICsgICAgICAgIHJldHVybiBWVERfU01fUEFTSURfRU5UUllfRElEKCZwZSk7DQo+Pj4+ICAg
ICAgICB9DQo+Pj4+DQo+Pj4+ICAgICAgICByZXR1cm4gVlREX0NPTlRFWFRfRU5UUllfRElEKGNl
LT5oaSk7DQo+Pj4+IEBAIC0zMTEyLDYgKzMxMTIsMTgzIEBAIHN0YXRpYyBib29sDQo+Pj4gdnRk
X3Byb2Nlc3NfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+PiAgICAgICAgcmV0
dXJuIHRydWU7DQo+Pj4+ICAgIH0NCj4+Pj4NCj4+Pj4gK3N0YXRpYyBpbmxpbmUgaW50IHZ0ZF9k
ZXZfZ2V0X3BlX2Zyb21fcGFzaWQoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsDQo+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkLA0K
Pj4+IFZURFBBU0lERW50cnkgKnBlKQ0KPj4+PiArew0KPj4+PiArICAgIEludGVsSU9NTVVTdGF0
ZSAqcyA9IHZ0ZF9hcy0+aW9tbXVfc3RhdGU7DQo+Pj4+ICsgICAgVlREQ29udGV4dEVudHJ5IGNl
Ow0KPj4+PiArICAgIGludCByZXQ7DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAoIXMtPnJvb3Rfc2Nh
bGFibGUpIHsNCj4+Pj4gKyAgICAgICAgcmV0dXJuIC1WVERfRlJfUlRBRERSX0lOVl9UVE07DQo+
Pj4+ICsgICAgfQ0KPj4+PiArDQo+Pj4+ICsgICAgcmV0ID0gdnRkX2Rldl90b19jb250ZXh0X2Vu
dHJ5KHMsIHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKSwNCj4+PiB2dGRfYXMtPmRldmZuLA0KPj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmY2UpOw0KPj4+PiArICAgIGlm
IChyZXQpIHsNCj4+Pj4gKyAgICAgICAgcmV0dXJuIHJldDsNCj4+Pj4gKyAgICB9DQo+Pj4+ICsN
Cj4+Pj4gKyAgICByZXR1cm4gdnRkX2NlX2dldF9wYXNpZF9lbnRyeShzLCAmY2UsIHBlLCBwYXNp
ZCk7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBib29sIHZ0ZF9wYXNpZF9lbnRyeV9j
b21wYXJlKFZURFBBU0lERW50cnkgKnAxLA0KPlZURFBBU0lERW50cnkNCj4+PiAqcDIpDQo+Pj4+
ICt7DQo+Pj4+ICsgICAgcmV0dXJuICFtZW1jbXAocDEsIHAyLCBzaXplb2YoKnAxKSk7DQo+Pj4+
ICt9DQo+Pj4+ICsNCj4+Pj4gKy8qDQo+Pj4+ICsgKiBUaGlzIGZ1bmN0aW9uIGlzIGEgbG9vcCBm
dW5jdGlvbiB3aGljaCByZXR1cm4gdmFsdWUgZGV0ZXJtaW5lcyBpZg0KPj4+PiArICogdnRkX2Fz
IGluY2x1ZGluZyBjYWNoZWQgcGFzaWQgZW50cnkgaXMgcmVtb3ZlZC4NCj4+Pj4gKyAqDQo+Pj4+
ICsgKiBGb3IgUENJX05PX1BBU0lELCB3aGVuIGNvcnJlc3BvbmRpbmcgY2FjaGVkIHBhc2lkIGVu
dHJ5IGlzDQo+Y2xlYXJlZCwNCj4+Pj4gKyAqIGl0IHJldHVybnMgZmFsc2Ugc28gdGhhdCB2dGRf
YXMgaXMgcmVzZXJ2ZWQgYXMgaXQncyBvd25lZCBieSBQQ0kNCj4+Pj4gKyAqIHN1Yi1zeXN0ZW0u
IEZvciBvdGhlciBwYXNpZCwgaXQgcmV0dXJucyB0cnVlIHNvIHZ0ZF9hcyBpcyByZW1vdmVkLg0K
Pj4+DQo+Pj4gYWxzbywgdGhpcyBoZWxwZXIgd2lsbCBhbHdheXMgcmV0dXJuIHRydWUgaWYgdGhp
cyBzZXJpZXMgZG9lcyBub3QNCj4+PiBzdXBwb3J0IG5vbi1yaWRfcGFzaWQgUEFTSUQuDQo+Pg0K
Pj4gRG8geW91IG1lYW4gcmV0dXJuIGZhbHNlPyBJIGRvbid0IHRoaW5rIGl0IHdpbGwgcmV0dXJu
IHRydWUuDQo+PiBGb3Igbm9uLXJpZF9wYXNpZCwgaXQgbWF5IHJldHVybiBmYWxzZS4NCj4NCj5h
aGEsIHllcy4gZm9yIHJpZF9wYXNpZCwgeW91IG5lZWQgdG8ga2VlcCB0aGUgdnRkX2FzIGluc3Rh
bmNlLg0KPg0KPlJlZ2FyZHMsDQo+WWkgTGl1DQo=

