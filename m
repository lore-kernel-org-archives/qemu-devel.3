Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFB4D12D66
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 02:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAKd5-0004DZ-TV; Sun, 10 Nov 2024 21:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAKd4-0004DC-Dz
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 21:58:14 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAKd0-00027T-Tz
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 21:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731293891; x=1762829891;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uomvasKV0FMO3RNt33C7OCuPgzbiU8B8dNyQzwGQZQU=;
 b=U9dr93G5HVPU5uqoiyW03yUEaElz3zOWWXoCudpj/0fW9KhLB/8DUBF/
 3xkK95S0wcetDwFdkND/EdiPLqq0mQxNA4DLt9o4zjO1Cfq++QKPoFV73
 Q/NQCLONeTjkezj2+6K1/E6YDGn7eOO2UPm9OPjCXXLytiPNhTBCXi0H9
 5WDcxu+ZniDc6R85zvbxJYcrWPwfGfn+abcyok/8YKpuUy6F7qAOlGcdX
 6DqlH10cmoFGvb2xCdgw8ne9DYOsFhpR+NZEa97L5vNxScvKiFzUiLX/s
 nrnjMHD6Orel0SSQq4rw3/LIObY4m/oqg9Ohb48kW+wYyTL2ksO5ZpLIE g==;
X-CSE-ConnectionGUID: sZur1UlGQWWTDVT2VB/XcA==
X-CSE-MsgGUID: A3+0U/H2SoaSc7Ud07I0NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="56489295"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="56489295"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2024 18:58:05 -0800
X-CSE-ConnectionGUID: BSRzbYBJTgyyKM4uR/LfCQ==
X-CSE-MsgGUID: KYbLsBBkT4OWQCugjpp4iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="91791630"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Nov 2024 18:58:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 18:58:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 10 Nov 2024 18:58:04 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 10 Nov 2024 18:58:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEF2sQQAgOKeiaCLPXt/L9I2upJEXhA2wNylTDzraxU9ABxX6tq53Rh2QnEUTP2zhApg4bz4wBbNhu6/zKiLgyCJ6vAByDEsn4CHKaBOAwi3PvWyXPim7I5h60+fdsK4dWkPKHrX7AtLTmumPq+BQhBgNDZYQXUYP4dMFQpnwrd6T37dNtjhgUa8ZqepwL3/rabK9Yolv1Zq6U099OEaPb24Rlir6aSgbiyyYqqjtgdR+rHwoqRg0pyGhD9pYWp81TFQyoa25kUuxUvkoGOhjP4j2EgCDnV9qdbWCfpL/M/x8etAdFGFS3ONrMDLcJ3zyZf8ik4YHlhuSQPUprQe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uomvasKV0FMO3RNt33C7OCuPgzbiU8B8dNyQzwGQZQU=;
 b=MILlX66pj1yX5JB6nbKBTohui//VM30m8ZkFPCqPowSV+txYRHoMgfwFOSOZJ2wo5cUREBIjL5PPpYh8U5EgBniU6s7d4SZ0fcQ2MAcPiCEfR7+LNz+Rrg/qh45+Hs/2l5V/L15Lg2uhXJ2CmUZCAiBsvLU7MF2jkReMDPcwQv39igvzEaYFkdn2yrhloULLKGAU/6JYwFa44idvnG84o3KD6f+Uz9u5cCvpl6mg87DtVwU3a909ChW7ZfVGvKUwcLRNeWOkGSHMT8hSoMO4LDF+TBZUvqVpTsSjcJrBMxk3k32xbU0MIIM/G3GCQ+sN/li8MJqsxWSeP9scefdJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB6837.namprd11.prod.outlook.com (2603:10b6:303:221::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 02:58:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 02:58:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
Thread-Topic: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
Thread-Index: AQHbExt6qksyA+pIAUiDQKSj47oTJbKtCtEAgAAInMCABHc1gIAAEMOg
Date: Mon, 11 Nov 2024 02:58:00 +0000
Message-ID: <SJ0PR11MB674497448DE5C1CD18E0294A92582@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-15-zhenzhong.duan@intel.com>
 <CACGkMEsq+VrxjGMf_ma=6xumwWgb2109XB4+86zH0ZXrce5Kdg@mail.gmail.com>
 <SJ0PR11MB6744B13E0A9C352E4E6EF74D925D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEvxK_+foQ1WV6ykJyRxzAPZc80wBfw0c-j-D56jsrTvXA@mail.gmail.com>
In-Reply-To: <CACGkMEvxK_+foQ1WV6ykJyRxzAPZc80wBfw0c-j-D56jsrTvXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB6837:EE_
x-ms-office365-filtering-correlation-id: 69bfb3dc-eb86-4831-774c-08dd01fca755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MHQzL1lmTnh6cDlhbjl1dzFBWTd0UHpvaGRpRWVPaHByNW5zMTdpdFg2QkxB?=
 =?utf-8?B?M05xbGplMlBNb1IrSFMwTHRubnlPdkYzWDBLdHo0K3d5U3crNlFWVStSb0tn?=
 =?utf-8?B?V0ROWE1rUXR2ajJ4YXJURUZlZ3lzMmZDOEtoVFFZOFg4S0JCdEFmbksxUHd2?=
 =?utf-8?B?TGZSWUNBWTJFbGFLdHFTVkNWSWd1MzlKU1VZNXJKZThwWi8rTkYrYUhFZGtr?=
 =?utf-8?B?aHhWNFFHU0s5OWpyT2RXRlNWWHJUd1pVSVg4VjBHNTJTR0lUVENuQ3hQY29Q?=
 =?utf-8?B?VkpJRVFCbmMxOG9YT0ltN3dZMnB6bzlrY0Npb1hLaGhydWtnL0EwWnowQTE2?=
 =?utf-8?B?SUdJeHZ0Wi9uRDNXSCtDaHJOaUhsODBYcFcxcEk4ZzVyUGtrTGVHdXNqU1hl?=
 =?utf-8?B?TW9sL28zaUd1Qnh0Y0RZSXp5UGNVRUhuaDRHQXFJK1FOWVdHRUdqbnZqdXNJ?=
 =?utf-8?B?OGhGUW0zamk1bmZwQ1JhSnZoZ0FubWdDd2szQkFzOXJhaW9QQjNaZUZ5a2dF?=
 =?utf-8?B?ZWcyUnhNajkrUW0xd3dOeUZwcG16Uzhqanc2bWJ6MmNoMVBGV0dCOGpDMTFH?=
 =?utf-8?B?eGs5YXM0NnQxYVhDQWx4QStlVkpyZC94L0RMajBubEU4UFpQOFVpYk9qRGlr?=
 =?utf-8?B?bnQ2VUtKOENidVFkSTVjc2NuT3diWVVERTBLTWpRc3N3YzNxbUxCNVZMY0tZ?=
 =?utf-8?B?WVF5QU00YTBKRUl4SDVvdVRVUmZWdWo1Q01TNFhIcG0rMytRbG90S0lkNm1y?=
 =?utf-8?B?RVZ6WVppck1nNHRBNXgzcm85bngxTU4vMDAvRHpzaDdoNjNzUGh5MzR0c1ZK?=
 =?utf-8?B?ZldtbW1RMnRtWVdJZkhrWnc1MjVzRDBJYUkweHlNbXNiRkZQOXlGVDFwRlRw?=
 =?utf-8?B?bjlRNTFkZzBzRmRVMFp1eHFLMDY4bWp5dkNCaUljOUxmTEVJQXk3R2x1ZXlB?=
 =?utf-8?B?R0ZHLzdSLytiN3lrNTdNUEFic1kweldpSGFLeEI2di84a3Vrbkw0aFZnaXhv?=
 =?utf-8?B?czFNaVo0KzZpR1lzT1dzd2c4ZHNwZEVhSHQ1cWp0SG9VVjRjb0djREJieGFW?=
 =?utf-8?B?QVQvRGpFVkFKSUQ2eHR5bVVpY0EwQ3ZnRndzaXF6QUU0cXRQbElsNDRIV0sr?=
 =?utf-8?B?WGhTTlB5d0NObnRVeTZnMmhCYkVmcVNKTDcxOVV0N01BU3NLUEFMdHFIcVRI?=
 =?utf-8?B?VFI1NW9Sb1JFQXZvdXBLSTFuTmwwYWhGZmIwRlQ5RlAxRktqVTZvVFo1WDhM?=
 =?utf-8?B?RmliclFabW0vV1RsZWt2eTNpdG55cnJucGprODZ1Y1Baazg0YThPajI5bXhz?=
 =?utf-8?B?d2JXTjdNUFN6VFdsekt1MlgzOUxJL1IxeE43OTJnUjRqa3BJOStuRjJCeCt3?=
 =?utf-8?B?bDFwanBTQ2RLdWpHZWt2YUFqdmR4dGEyblgwMnZhbXF5YTlQeDMwdUl4c3Fi?=
 =?utf-8?B?UDgwWlh1L3c4dUFiWi9WMlcwSGoxaHRMcGtmMEVIbXB2T2VSMDFGRElFa2xS?=
 =?utf-8?B?VTdIdlNiZ01KU0pNblE5WjgrbHM5M0RCU3VkOWtQSDV6N3M2OC8xOXlSMVdM?=
 =?utf-8?B?WWQzc29QN3h3WWdvU2pmaElDQWYvVGVRQnpuMDhQQ1E3V1FURVIxQllWQWxK?=
 =?utf-8?B?ZGlERWNVa1F5bDF0ZUkvWENQZVd6bVV0TzhENHpzakNhVVk2VHR3Tjhvcmhw?=
 =?utf-8?B?QnBIU2IvTWhCWGhscXcxY1lRa1gyVTJRVllyWjBXeTNnTEVpQk4vL1pCb25W?=
 =?utf-8?B?MlI2eXFWVXJHSTVhbFUxNUR5aVNRNThSOG1HQ2tJYWx0TFFFeEZzb3E2VXY2?=
 =?utf-8?Q?Dmna2SHMXdLaw1et+M+hXSIvF9C1PqS2dhXqY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1dFR1VtUGFWbzBLOGpQWGVMQ1MyZmFwQVF1YjZSVTRCOHFUWmVMdHFsVy9q?=
 =?utf-8?B?WGdpS0pyVW44RUd4eUFGSGxPRjlsL2hKVWFOVlhHMXlrN2YzODdEYU9kbGxK?=
 =?utf-8?B?UysxTnpZdUYrUjV4UXJ6OGY0Ylk3TTBCNiswUmswN2Z0azBwVHJFbk9aNEdS?=
 =?utf-8?B?QVBPaEFzeHQ3RGN4NzkwTDRQaENVVEhuUGM1OGhWcCs5S2IzbzY1dlQyNTRt?=
 =?utf-8?B?NSs1L1N6bi9WRUlZaEN3ekZwWHJwTStWVEpZS0NFa0s2VEEyS1UxSHUvOTJC?=
 =?utf-8?B?UEVlbVBWWGtJU0Z1M04zeGx5WGhaZ3crb2FvcFNzYk52VGJ4Y2Q5Rnk5RjVh?=
 =?utf-8?B?anNPcTY4WW1HNms1cDFma1htWUkxRzdqWFhTdWU5eGpoOE0rZmtyMVRtZFlM?=
 =?utf-8?B?YkF5aTUzZ1ZWVmQyTGkxRU9PQjRmS0JKZWZvdjczZ2V2ZFhLM1JUT2RBdVd2?=
 =?utf-8?B?dUFNeG8xcFN6L0M3Q0E4bFZlOHFtVlk4YStjUzlUTnEvNTY3TDlZeGNKMHJq?=
 =?utf-8?B?QXYrd0VYTUs4QmpDcmNWcWpOTVNndjEraVI0TklUd0FyWmhUVGUwVjFmMjJm?=
 =?utf-8?B?T0V6UVlSR3FlOWZrWXJBR1NWV0NObStaNzV5dDEzVmhFZUpXY1ZPeTh5MGFp?=
 =?utf-8?B?cGRpZVpvTTh5TjZ2RTZnZm9YYlVITzEwRzJtcHdpekFDV1RFTkZ3NGpFNmNm?=
 =?utf-8?B?YWw3SFVQT1JqcEZSWjVyOUtJaitnbVNzejdPTGp6QmszL1M5MmkxdXdtemJt?=
 =?utf-8?B?cDdGVHZ2eTVTYzFTMlBUUm9zUjdhOHJBdUZyTFVPRUlLN2ttM1BhdDJob2cx?=
 =?utf-8?B?YzhPRFY0SVFDVm8wRmhIUEJmY2RVdDlJK29yS0V5TXVMNDAzYVZNbVYydlBF?=
 =?utf-8?B?MGkwbGY3c0ZxYkgwVEtOWVBITnJZNE03RjJtRkx4NGxIK0pIcW0xM2o3SGxK?=
 =?utf-8?B?b1NpdC9YcE1Vd1l0aTN4Qm1GTUQvYXNrOEpYcFBUZnVhQjc4R2poT3AxVURn?=
 =?utf-8?B?ZW4wYTdBNTR0TFFTRklWaUVvSW9RWXVGWGxCZ1JpV2xwcm9Kek1zSmNwRkFZ?=
 =?utf-8?B?S1F6VTdYMFh2Y3lkT0hjL2FYUWFSaG5TZTZJQ3pYR0t2TytVNWxkdWVaZGly?=
 =?utf-8?B?SFdhY0JYRVMyR284dVVEcm9wYnZubjRLbEZHTDQwMGMrMVZIelNyZU9qUG8r?=
 =?utf-8?B?d1RXSjg5d2s2aE5qYlhsSkhxYWdtUGZRS1I0aWdRSUQ1S2VvYUNvbUJrblpq?=
 =?utf-8?B?RkxpUDNCcXB0Q3pUTHZWdzlveFQyNVlmV0U0WEl0cmt6M3F2cjNBRmt3S04y?=
 =?utf-8?B?aE4vMDJ3RUlLTXZ4d3AwRm9BT2lMUnMyRC9GRWdDZzhZV29KZDZ6VTFlS3FR?=
 =?utf-8?B?eERTd2tIME1LcEZ5THorbUpiTlZGeEpGSDF2QjdOanhaV1libkNMcHdERlhI?=
 =?utf-8?B?NUZXdFpyL3BCL3g3aHlrNmRJNFQyQnNrUS9CaFRUQ29zWGk4Mi91QXdtdzRk?=
 =?utf-8?B?Y3BZamdYOVJSanU2MUJXMjJWQzZSY2FGbi9GbGVqMlhDZVNlWVR2aWRqaEVt?=
 =?utf-8?B?bFJMY092TU5ySnlXRGxwT2FNTHhrTVJFR1U5aHU1L0Z1QURZNGQ5YTR4NDhH?=
 =?utf-8?B?bDdZWEc5RlNDNTlpR2EzMlBpalU0SFpvRExRSHgvcUpoYk1JQVRGTHVZcSs2?=
 =?utf-8?B?d3BNakhuOEYvRkJSc09tT2FJS3Ayck1BYkJvbVF4S0NraWhOS1N1N0pzMGp0?=
 =?utf-8?B?OU9uV0g1SUFrOXZQTlo2MSsrcFc0WnVtNmhwZUVhK3EybXA2SDBOUWtiZXJs?=
 =?utf-8?B?a215THEvUnFrVEt5VDdiSzFDL2x6TTFRSW9vL3U5VDFXUzY5dENibk9KaGdq?=
 =?utf-8?B?R2NPMzI5UkZTck02TUYvSTZTUHpQVXBmT2FxZktQbSttUnpjRnpmRkpUTFFh?=
 =?utf-8?B?Ti9XSEZmWDdhTHNQNVMycUZNUVdkUDRJU1dPanhuWmEwN3VwQng4aDk5OGw4?=
 =?utf-8?B?OVd5b0ZEVkNDZDVzVlQvTW1PTGE4SUpWM0cwTUVMRGZ5TCtsNm0rR0syQzcv?=
 =?utf-8?B?MzkvaXlFd3YzbUZSR2dERjVFNDlubnQ5OG9UdnhvQ0Q3UUoyTlMxU2pKWnFU?=
 =?utf-8?Q?Nh8dZ4Kf81YdgzWkPkbkA5UaX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bfb3dc-eb86-4831-774c-08dd01fca755
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 02:58:00.6640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjfqbWfzyBffxhHfQnL6Nj1088exCMQ6q/bbf289uj+l+kFaQthXoWpxYfnOlYq1fep44SzWkxEDKaD+Xx8mElPLs0ccxKpDyPny+wCsNVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMSwgMjAyNCA5OjI0IEFN
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NCAxNC8xN10gaW50ZWxfaW9tbXU6IFNldCBkZWZhdWx0
IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFibGUNCj5tb2Rlcm4gbW9kZQ0KPg0KPk9uIEZyaSwgTm92
IDgsIDIwMjQgYXQgMTozMOKAr1BNIER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPndyb3RlOg0KPj4NCj4+DQo+Pg0KPj4gPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+PiA+RnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4+ID5TZW50
OiBGcmlkYXksIE5vdmVtYmVyIDgsIDIwMjQgMTI6NDIgUE0NCj4+ID5TdWJqZWN0OiBSZTogW1BB
VENIIHY0IDE0LzE3XSBpbnRlbF9pb21tdTogU2V0IGRlZmF1bHQgYXdfYml0cyB0byA0OCBpbg0K
PnNjYWxhYmxlDQo+PiA+bW9kZXJuIG1vZGUNCj4+ID4NCj4+ID5PbiBNb24sIFNlcCAzMCwgMjAy
NCBhdCA1OjMw4oCvUE0gWmhlbnpob25nIER1YW4NCj48emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4gPndyb3RlOg0KPj4gPj4NCj4+ID4+IEFjY29yZGluZyB0byBWVEQgc3BlYywgc3RhZ2Ut
MSBwYWdlIHRhYmxlIGNvdWxkIHN1cHBvcnQgNC1sZXZlbCBhbmQNCj4+ID4+IDUtbGV2ZWwgcGFn
aW5nLg0KPj4gPj4NCj4+ID4+IEhvd2V2ZXIsIDUtbGV2ZWwgcGFnaW5nIHRyYW5zbGF0aW9uIGVt
dWxhdGlvbiBpcyB1bnN1cHBvcnRlZCB5ZXQuDQo+PiA+PiBUaGF0IG1lYW5zIHRoZSBvbmx5IHN1
cHBvcnRlZCB2YWx1ZSBmb3IgYXdfYml0cyBpcyA0OC4NCj4+ID4+DQo+PiA+PiBTbyBkZWZhdWx0
IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFibGUgbW9kZXJuIG1vZGUuIEluIG90aGVyIGNhc2VzLA0K
Pj4gPj4gaXQgaXMgc3RpbGwgZGVmYXVsdCB0byAzOSBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0
eS4NCj4+ID4+DQo+PiA+PiBBZGQgYSBjaGVjayB0byBlbnN1cmUgdXNlciBzcGVjaWZpZWQgdmFs
dWUgaXMgNDggaW4gbW9kZXJuIG1vZGUNCj4+ID4+IGZvciBub3cuDQo+PiA+Pg0KPj4gPj4gU2ln
bmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+
ID4+IFJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmPGNsZW1lbnQubWF0aGlldS0t
ZHJpZkBldmlkZW4uY29tPg0KPj4gPj4gLS0tDQo+PiA+PiAgaW5jbHVkZS9ody9pMzg2L2ludGVs
X2lvbW11LmggfCAgMiArLQ0KPj4gPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgIHwg
MTAgKysrKysrKysrLQ0KPj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4+ID4+DQo+PiA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2
L2ludGVsX2lvbW11LmgNCj5iL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiA+PiBp
bmRleCBiODQzZDA2OWNjLi40ODEzNGJkYTExIDEwMDY0NA0KPj4gPj4gLS0tIGEvaW5jbHVkZS9o
dy9pMzg2L2ludGVsX2lvbW11LmgNCj4+ID4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9p
b21tdS5oDQo+PiA+PiBAQCAtNDUsNyArNDUsNyBAQCBPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQ
RShJbnRlbElPTU1VU3RhdGUsDQo+PiA+SU5URUxfSU9NTVVfREVWSUNFKQ0KPj4gPj4gICNkZWZp
bmUgRE1BUl9SRUdfU0laRSAgICAgICAgICAgICAgIDB4MjMwDQo+PiA+PiAgI2RlZmluZSBWVERf
SE9TVF9BV18zOUJJVCAgICAgICAgICAgMzkNCj4+ID4+ICAjZGVmaW5lIFZURF9IT1NUX0FXXzQ4
QklUICAgICAgICAgICA0OA0KPj4gPj4gLSNkZWZpbmUgVlREX0hPU1RfQUREUkVTU19XSURUSCAg
ICAgIFZURF9IT1NUX0FXXzM5QklUDQo+PiA+PiArI2RlZmluZSBWVERfSE9TVF9BV19BVVRPICAg
ICAgICAgICAgMHhmZg0KPj4gPj4gICNkZWZpbmUgVlREX0hBV19NQVNLKGF3KSAgICAgICAgICAg
ICgoMVVMTCA8PCAoYXcpKSAtIDEpDQo+PiA+Pg0KPj4gPj4gICNkZWZpbmUgRE1BUl9SRVBPUlRf
Rl9JTlRSICAgICAgICAgICgxKQ0KPj4gPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9t
bXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gPj4gaW5kZXggOTFkN2IxYWJmYS4uMDY4
YTA4ZjUyMiAxMDA2NDQNCj4+ID4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gPj4g
KysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiA+PiBAQCAtMzc3Niw3ICszNzc2LDcgQEAg
c3RhdGljIFByb3BlcnR5IHZ0ZF9wcm9wZXJ0aWVzW10gPSB7DQo+PiA+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE9OX09GRl9BVVRPX0FVVE8pLA0KPj4gPj4gICAgICBERUZJTkVfUFJP
UF9CT09MKCJ4LWJ1Z2d5LWVpbSIsIEludGVsSU9NTVVTdGF0ZSwgYnVnZ3lfZWltLCBmYWxzZSks
DQo+PiA+PiAgICAgIERFRklORV9QUk9QX1VJTlQ4KCJhdy1iaXRzIiwgSW50ZWxJT01NVVN0YXRl
LCBhd19iaXRzLA0KPj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICBWVERfSE9TVF9BRERSRVNT
X1dJRFRIKSwNCj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgVlREX0hPU1RfQVdfQVVUTyks
DQo+PiA+PiAgICAgIERFRklORV9QUk9QX0JPT0woImNhY2hpbmctbW9kZSIsIEludGVsSU9NTVVT
dGF0ZSwgY2FjaGluZ19tb2RlLA0KPj4gPkZBTFNFKSwNCj4+ID4+ICAgICAgREVGSU5FX1BST1Bf
Qk9PTCgieC1zY2FsYWJsZS1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLA0KPnNjYWxhYmxlX21vZGUs
DQo+PiA+RkFMU0UpLA0KPj4gPj4gICAgICBERUZJTkVfUFJPUF9CT09MKCJzbm9vcC1jb250cm9s
IiwgSW50ZWxJT01NVVN0YXRlLCBzbm9vcF9jb250cm9sLA0KPj4gPmZhbHNlKSwNCj4+ID4+IEBA
IC00NjgzLDYgKzQ2ODMsMTQgQEAgc3RhdGljIGJvb2wgdnRkX2RlY2lkZV9jb25maWcoSW50ZWxJ
T01NVVN0YXRlDQo+KnMsDQo+PiA+RXJyb3IgKiplcnJwKQ0KPj4gPj4gICAgICAgICAgfQ0KPj4g
Pj4gICAgICB9DQo+PiA+Pg0KPj4gPj4gKyAgICBpZiAocy0+YXdfYml0cyA9PSBWVERfSE9TVF9B
V19BVVRPKSB7DQo+PiA+PiArICAgICAgICBpZiAocy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiA+
PiArICAgICAgICAgICAgcy0+YXdfYml0cyA9IFZURF9IT1NUX0FXXzQ4QklUOw0KPj4gPj4gKyAg
ICAgICAgfSBlbHNlIHsNCj4+ID4+ICsgICAgICAgICAgICBzLT5hd19iaXRzID0gVlREX0hPU1Rf
QVdfMzlCSVQ7DQo+PiA+PiArICAgICAgICB9DQo+PiA+DQo+PiA+SSBkb24ndCBzZWUgaG93IHdl
IG1haW50YWluIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5IGhlcmUuDQo+Pg0KPj4gSW1hZ2luZSB0
aGlzIGNtZGxpbmU6ICItZGV2aWNlIGludGVsLWlvbW11LHgtc2NhbGFibGUtbW9kZT1vbiIgd2hp
Y2ggaGludHMNCj4+IHNjYWxhYmxlIGxlZ2FjeSBtb2RlKGEuay5hLCBzdGFnZS0yIHBhZ2UgdGFi
bGUgbW9kZSksDQo+Pg0KPj4gd2l0aG91dCB0aGlzIHBhdGNoLCBpbml0aWFsIHMtPmF3X2JpdHMg
dmFsdWUgaXMgVlREX0hPU1RfQUREUkVTU19XSURUSCgzOSkuDQo+Pg0KPj4gYWZ0ZXIgdGhpcyBw
YXRjaCwgaW5pdGlhbCBzLT5hd19iaXQgdmFsdWUgaXMgVlREX0hPU1RfQVdfQVVUTygweGZmKSwN
Cj4+IHZ0ZF9kZWNpZGVfY29uZmlnKCkgaXMgY2FsbGVkIGJ5IHZ0ZF9yZWFsaXplKCkgdG8gc2V0
IHMtPmF3X2JpdCB0bw0KPlZURF9IT1NUX0FXXzM5QklUKDM5KS4NCj4+DQo+PiBTbyBhcyBsb25n
IGFzIHRoZSBRRU1VIGNtZGxpbmUgaXMgc2FtZSwgcy0+YXdfYml0IGlzIHNhbWUgd2l0aCBvciB3
aXRob3V0IHRoaXMNCj5wYXRjaC4NCj4NCj5PaywgSSBndWVzcyB0aGUgcG9pbnQgaXMgdGhhdCB0
aGUgc2NhbGFiZS1tb2Rlcm4gbW9kZSBpcyBpbnRyb2R1Y2VkIGluDQo+dGhpcyBzZXJpZXMgc28g
d2Ugd29uJ3QgYm90aGVyLg0KPg0KPkJ1dCBJIHNlZSB0aGlzOg0KPg0KPisgICAgaWYgKHMtPnNj
YWxhYmxlX21vZGVybiAmJiBzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzQ4QklUKSB7DQo+DQo+
SW4gcHJldmlvdXMgcGF0Y2hlcy4gU28gSSB3b25kZXIgaW5zdGVhZCBvZiBtYW5kYXRpbmcgbWFu
YWdlbWVudCB0bw0KPnNldCBBVVRPIHdoaWNoIHNlZW1zIGxpa2UgYSBidXJkZW4uIEhvdyBhYm91
dCBqdXN0IGluY3JlYXNlIHRoZQ0KPmRlZmF1bHQgQVcgdG8gNDhiaXQgYW5kIGRvIHRoZSBjb21w
YXRpYmlsaXR5IHdvcmsgaGVyZT8NCg0KR29vZCBpZGVhISBUaGVuIHdlIGRvbid0IG5lZWQgVlRE
X0hPU1RfQVdfQVVUTygweGZmKS4NCkRlZmF1bHQgaXMgNDggc3RhcnRpbmcgZnJvbSBxZW11IDku
MiBib3RoIGZvciBtb2Rlcm4gYW5kIGxlZ2FjeSBtb2RlLA0KRGVmYXVsdCBpcyBzdGlsbCAzOSBm
b3IgcWVtdSBiZWZvcmUgOS4yLiBXaWxsIGJlIGxpa2UgYmVsb3csIGxldCBtZSBrbm93IGlmDQph
bnkgbWlzdW5kZXJzdGFuZGluZ3MuDQoNCi0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oDQorKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KQEAgLTQ1LDcgKzQ1LDcg
QEAgT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoSW50ZWxJT01NVVN0YXRlLCBJTlRFTF9JT01N
VV9ERVZJQ0UpDQogI2RlZmluZSBETUFSX1JFR19TSVpFICAgICAgICAgICAgICAgMHgyMzANCiAj
ZGVmaW5lIFZURF9IT1NUX0FXXzM5QklUICAgICAgICAgICAzOQ0KICNkZWZpbmUgVlREX0hPU1Rf
QVdfNDhCSVQgICAgICAgICAgIDQ4DQotI2RlZmluZSBWVERfSE9TVF9BRERSRVNTX1dJRFRIICAg
ICAgVlREX0hPU1RfQVdfMzlCSVQNCisjZGVmaW5lIFZURF9IT1NUX0FERFJFU1NfV0lEVEggICAg
ICBWVERfSE9TVF9BV180OEJJVA0KICNkZWZpbmUgVlREX0hBV19NQVNLKGF3KSAgICAgICAgICAg
ICgoMVVMTCA8PCAoYXcpKSAtIDEpDQoNCiAjZGVmaW5lIERNQVJfUkVQT1JUX0ZfSU5UUiAgICAg
ICAgICAoMSkNCmRpZmYgLS1naXQgYS9ody9pMzg2L3BjLmMgYi9ody9pMzg2L3BjLmMNCmluZGV4
IDgzMDYxNGQ5MzAuLmJkYjY3ZjFmZDQgMTAwNjQ0DQotLS0gYS9ody9pMzg2L3BjLmMNCisrKyBi
L2h3L2kzODYvcGMuYw0KQEAgLTgzLDYgKzgzLDcgQEAgR2xvYmFsUHJvcGVydHkgcGNfY29tcGF0
XzlfMVtdID0gew0KICAgICB7ICJJQ0g5LUxQQyIsICJ4LXNtaS1zd3NtaS10aW1lciIsICJvZmYi
IH0sDQogICAgIHsgIklDSDktTFBDIiwgIngtc21pLXBlcmlvZGljLXRpbWVyIiwgIm9mZiIgfSwN
CiAgICAgeyBUWVBFX0lOVEVMX0lPTU1VX0RFVklDRSwgInN0YWxlLXRtIiwgIm9uIiB9LA0KKyAg
ICB7IFRZUEVfSU5URUxfSU9NTVVfREVWSUNFLCAiYXctYml0cyIsICIzOSIgfSwNCiB9Ow0KIGNv
bnN0IHNpemVfdCBwY19jb21wYXRfOV8xX2xlbiA9IEdfTl9FTEVNRU5UUyhwY19jb21wYXRfOV8x
KTsNCg0KDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

