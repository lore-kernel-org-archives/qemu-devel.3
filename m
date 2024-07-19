Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37A3C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 02:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUdkg-0008Lc-Iy; Thu, 18 Jul 2024 22:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUdke-0008L5-QZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 22:53:44 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUdkc-0000rV-TF
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 22:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721357622; x=1752893622;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GXYYcfQNWLL0NXD9G+7HMLp3YZAPUUxqAG5uH9vbnPc=;
 b=YPXji1ica53ZHuX2RZamihW3inwmGGBCY5YaAxf2QghvNZtwf8h0gC+k
 IP3v33F1akrO+Vr3rkEYsvZU083Fo9tH+pAX0/YiL1FIKp5B4evTLmotD
 GZ7BghhA04HsUUzE3Q5qwkBjVmVYpDcnxexZv6XCOb+MyQc3NpkH9sYNv
 a7XxO1cEmS2LvCp890nbYYNKbSYYNonTfzwMXvdw9xlYb3TmnntfW0zrg
 h5kSJYtts6qoAE17/mOQ/7m17wShCL22SXJfpbT7KB+dJHpz7U0D1/d/v
 49GHZ8h0zSGSwt9clo0Q/lWdd4MvsCg2YbYXIiBdRXyCR9e0JOPQMDGAZ w==;
X-CSE-ConnectionGUID: BnSHu4hASJ60Mq3X/iUVFg==
X-CSE-MsgGUID: R6m2pYQFS5CzEPr5JkqcAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="21860379"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="21860379"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 19:53:41 -0700
X-CSE-ConnectionGUID: TlzTndecTJqRU7math+tBw==
X-CSE-MsgGUID: UJ+1VjQhTm6IeMsxPNaE5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="55165813"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jul 2024 19:53:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 19:53:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 19:53:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 19:53:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 19:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdeTN0sMSQ3Ubbj0KXS+ez3jToi57lnJzdnlpUHP8EKeA/CBcjIQv0ZPv6yV5tWgxPMt33y/KNFngmWIudpgRJFo2KypeGYxuP58BUggfhULviE7FP61LYjDizl3FY1K6n9/MENv2wkrBtdJPUeOdGVgq2bFpJw4vEPzXVwgwl31hfg0ebiqUTnUsXspMnDyLkkWqWuGZM6Rz2HRNplSUIzTx7A/16rIOS5QnP90GgfB4nAZbtiLnxJqN9Wpt2ogchwP04o69suunHt2IZo4CHQ45zTzJUIlYWQ24Lkgru99oHBlCzcWoIsFWt8y0VjvBn6k9NLAdUR43x/TnhLYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXYYcfQNWLL0NXD9G+7HMLp3YZAPUUxqAG5uH9vbnPc=;
 b=F4gBcgRiVBuhdnlwBoaudFbwZg2Tlyn+AF3CPzpBPdfWLEmIgLupseJakXCEaxQCb59RSNlO8LGF9/KU5xCpFn1ITfeSkGjxnHJVKmjU9/w/OlfUi3oKqk/b9N6VtGEJOQG+xDrQww3cBtDXCz2sXUAW8yJlC3AaGNS2iDCfcbG0Yx4lDDw6i9evfqeL+BLDqKE/K1OYaeDFI5QI2QnMdIPcJrqG4igtHYPmg+CpEfd/CBiY9JMs0vQoVG+qx0NQxNkKlcLQJYj6E17LG5WXQh45icnIoKesizTGJCL4KthGEBE76yITJff/OnEBDySHXQf3ZJZdY3633vp/6HDCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6056.namprd11.prod.outlook.com (2603:10b6:510:1d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 02:53:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 02:53:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v1 16/17] intel_iommu: Modify x-scalable-mode to be string
 option
Thread-Topic: [PATCH v1 16/17] intel_iommu: Modify x-scalable-mode to be
 string option
Thread-Index: AQHa2OtzrfwHoZeBPkCNofl42TrcfLH8NuOAgAEjp5A=
Date: Fri, 19 Jul 2024 02:53:32 +0000
Message-ID: <SJ0PR11MB6744FA9E7C8A6C5235E08B8292AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-17-zhenzhong.duan@intel.com>
 <ce514028-3ed6-4aba-bfb1-75f52dfc0934@eviden.com>
In-Reply-To: <ce514028-3ed6-4aba-bfb1-75f52dfc0934@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6056:EE_
x-ms-office365-filtering-correlation-id: 4704c29d-780e-4b10-81a6-08dca79dfa1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Y1hEbmxKQW1HSUZrR2Fvd2lTOG5ZanRIRTd4TTk4bGViUHlodlYyTEFDZHpw?=
 =?utf-8?B?eisyMU04bWoxWWVINlo1OHRDYVpyN0VweVY5UDVadHJpR2dlZWVPY0Q0V083?=
 =?utf-8?B?RHFoVVpKZ1dPNklVcFNGOEtCN2Vvcis2b0JLMm94dFovSHZMS3pMM2JIMS9D?=
 =?utf-8?B?cVZKcjNDelhaS3drRFZ6ajJBa1k5MzQ2ZXdJbExDQkdLM2tqNjRkK3g3bHlu?=
 =?utf-8?B?M1dxT1NGQWgxb3lCNXdjY0I0SjhjS1Q1bEJvc0plWVYzTmJLVjl3Sm9BT1E0?=
 =?utf-8?B?emsvdTM1WVRoR0NubjN2NVhKT3haK2FXbWgvUEhJcnVhdmcwR2g4RElZR0lz?=
 =?utf-8?B?VkZNM0lERGc0emFKUFptbCtudFp1Nk9nenE3SzA3dzNGR2F2TStvQVFRSWV0?=
 =?utf-8?B?bkZmdnNtT2FEMk5tRmZPaGhtc01LMlJYaFJMRENlM2N0ZXhKR0FQc3hiWlRP?=
 =?utf-8?B?a01WVFJXOVY2SUkwZ0hFdzFsZnIwbHRWYVVGZW1ZYjcvUnBkR1JoYzFKOFpX?=
 =?utf-8?B?R3B3UGZVUWN1cTdYenlvU2R0bm85SHg3ZGY4WjJoMzAwMy9ocjJtQ291NXk5?=
 =?utf-8?B?bjBIUUkzU2c1eWt4OTZCVzNrZmtnQzZ0Z2IyL3FtbFFXSWlzZ3NISXJNTFZN?=
 =?utf-8?B?ZlJXd2NpeE56WmFXNS80MWxDdlhmeHluTVVocmFLVUd3UjNHc2ttRUY0QlFH?=
 =?utf-8?B?cXBMQnpmMUo5dGZHSUVBS0hBa05pbGZwbE03UXV6Q2pEb3ZjYU4zT2NXbjJQ?=
 =?utf-8?B?cjVkTWNyRFFvOEhUK3ZJRFlGNUFBTEJPM2R4c2lOZnh6bHhaRTdsd2pHdWlu?=
 =?utf-8?B?dGh2YTUxVW5CTmJUaHVhc0dZQlVVVVZ2VmdQUWhYK3k4dkxDM0pBQ091Sk1Z?=
 =?utf-8?B?aVpkd3BSNzRLNE4zTE9yNWk0aUdHQXptd3hGc01XcnVJZzVVNUFJRUdNeXVK?=
 =?utf-8?B?dzZCQTBYZFc4M1ZVd0txeWltV08rUkhVQm11ZGNpYUJFOU9ocWxWVVl5ZkQz?=
 =?utf-8?B?QzE5MjJJd1FkWE9QZER5Wi9rK2FZRU9PVjFXa3ZTMWhiTGJsZXlRSnhvSHhv?=
 =?utf-8?B?OUpvVUhtNnFobkJiS3JLcXpIeXhrTXZNRHFFZ3BHdEwybDdSU3R2eHBBaC81?=
 =?utf-8?B?b2dlKzJiQ2FWc0NWSWFUWm9LK2RCWmRYOUhZd013TVRYRXA2TVpadHE3aWtw?=
 =?utf-8?B?TW1lT1pQOTFncHExRWs3Wlp4SEJxNFRZSjhFdXV1TzhEbTM5Tk1sVFhoRWl6?=
 =?utf-8?B?MUZxUFMxMWtCa2Y1ZUNCRjVRaFVEM0Rsb1YyNk9rd1VLVWpSejIxK2tKcTRY?=
 =?utf-8?B?dnk2T3NmYnpaN2RqeHFjRzAra3doU1pEcEdOS2tuNmhsRWJ5dis2cVFBNnVm?=
 =?utf-8?B?RUZDdXc2MmF3QnRtaVBlaHhIZWVOd0NMMTdNcnFSWGZ4R0dkTVU4bTMyQ2xH?=
 =?utf-8?B?QjZvaFNVR25EVlBzUkxGcmF5NDlscy85Ni9FOXFGbnFTR1JGaVVTbzgzL2ts?=
 =?utf-8?B?SmhYYWJOQ1FIazgvQktBVHBTOHhOTEpnNE53VEJUNUl3dUxPeEFUbFlSTkpD?=
 =?utf-8?B?TFZFRmtXcGRNQ3dqSERUaUlGeXVpMWs3OEZzMTU3L2d6Vkl1amhjTXNYUi9L?=
 =?utf-8?B?OXhINTlIVFY5QXVqM1d4cllWdEY2YkM0OURJUTZwOTNOMGxKMUZ1T3NlcDZ4?=
 =?utf-8?B?S2laWVVOYnZwOVJ1VFVYSjFHUHoyZEUxZ3VaMmMyRXlJMExKVVhDeElzbGxo?=
 =?utf-8?B?TVptNzFlT0szREJiRksyTklVU0dXWlZuMlYweFFycDRRNFQ3dTlCclA5ZDls?=
 =?utf-8?B?NWVJMjZkNFRQMDZKZFR3cENkajFrMmgvS3dqZW9XQmdGVTRrSXlySUFIeVM0?=
 =?utf-8?B?OEtSaUViK1NMeVhtNFZUWnRkaStYWFdPS1ZldU8zVWlJQkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1huZ1YvL0VHY1pqbW1Odk05MWZBYVY4TEpiMnVCbkZLQjNsY0E5ajJHVVJZ?=
 =?utf-8?B?d2VVMlVjUWZLM0Y5ejRGeFE4Vk1XUk9neGExQkh3NG5nSkY4K1BRZU81YUJi?=
 =?utf-8?B?UnNhOUwweVoxSHBVYVJJRDVmZGtVWGsvckl5WDV4Z2V1RmNJUGJJUmVxSTE4?=
 =?utf-8?B?UlZBNjg4Z3AvU3VnbU56RmFrQTdNRURRcGY1dS9DM25JelFGZ2dMRzJLMmdn?=
 =?utf-8?B?SDlOczVyblVndG5QUU9VR054NEFSdm01RnlRZzkrcXpBQlhqMWNIVkNpMDR4?=
 =?utf-8?B?cm96eU1HNk5PYmJpSVNXSzdjOEZSN0h6VldZREVzLzExczg2akpCYWtjWjcv?=
 =?utf-8?B?OEloUjg0aGF5dnVkK2RwZDd5VUVJTTlNYkhyRkhwbUM5NElFb1pFYWc1elNh?=
 =?utf-8?B?TmlqT3JzUEphOGR0RkdDcmsrYnhHUXNjRmxPRk1nVFovcUlreXY4QzU0czFk?=
 =?utf-8?B?eU9HeE1NVTBxWEduRkZ1TmJmWEI2eGhFRHM3dFhjTHJEQ0pTMUNRVmdianln?=
 =?utf-8?B?NkxDQ1dXUFVUNWF4NlNrSUg2M2lZaHBvajZrcTBqVC9kQkdTMWlNYW02VTY0?=
 =?utf-8?B?b0hOSXZKQXRTemV1NTBsLzJsODBlM052UUFTeDBZbzFaMjhtUEpuTXJRekl5?=
 =?utf-8?B?aDNtNThIM2ZoOGcwZTBBWXNNRmc5d2FrWFdsbURTNlQ4OW5yZ1AxUEc3VzhM?=
 =?utf-8?B?OWhIZ0lnYnk3WUcvK1prUXJHSXZNYUdZTmpzcWtsT1pWb3hQcEtYMUFOMmJz?=
 =?utf-8?B?UGkra0d0MmdYT2ZkU29pV3lSNzYrUDYvckxDMXo1TUZkYkFpeGtjTUlaQm8v?=
 =?utf-8?B?N2FTT1Q1TkU2VWIrZmJGaTFnZmVHVC9YS3F0QndpcTB3Ui9rNkthUkJqb29h?=
 =?utf-8?B?QUlNbm5RUmVHbzhRaVlpWldXb2pFeG1kdmw2Y3VENFhFK05VOFcxM05qWkpT?=
 =?utf-8?B?UU8wUmRHVkFNdnVxZDMvckg3bVlxSFFlOUgwOTJ2VWVTUmZVZkxpQ3o0b3BM?=
 =?utf-8?B?WU05a0xUcmc1NnAwdkF2OC9OL0Z6SlJUY2J2dUhCazNkOTBhMWs1OXpZN1Nv?=
 =?utf-8?B?djNLUnFwK0g5ZU8yNkFaYVgrTy9pZm1MUWh4YjdDV3ZTNVhodHRMZHB4Um9a?=
 =?utf-8?B?eWN4d3FOQktJbFBYUEVnNnlLL1hRZjZLZEo0aUtHU01WN0NBSXB4TjRVYlcy?=
 =?utf-8?B?cEUxS0RkV1VDZkp1VmNGbmRSNGVjRDFTaTIyalhocXVJRmg5Yko2d0MzNisw?=
 =?utf-8?B?WGxOdTFPMjZzZFRlT3JYSGQ1dzdsSkl6MjdIbi84OTlzNEIrc1UrZU03Mkl0?=
 =?utf-8?B?K2RWVzM1VFBiVTg3M2QwYm1SV3YwQnVpbEhaeHJRRzJsbG9uYzQ4bnR4OUdE?=
 =?utf-8?B?bVpsZWdhV05TU1ppZWxiWWtaLzgrWnRIZURNMzhDTzZHZjg2RzdaMXRLUEwr?=
 =?utf-8?B?cVUvY0J4Y3ZpaCtLVWgwNmVvdnZDOGQzTWFNdC9qclBJRnJ3UWhxbndmVWFG?=
 =?utf-8?B?OHN1TkN5MjQ3VmgxY0NrSWVzNkVEN1l0YWN3bXc3a0FVWnUxY2dyekkzMXVC?=
 =?utf-8?B?ajliWERObHF1UG81alE3bHNCc0h2Q3NLc3cvK3o5cjFNR1crZGN0QU5iOU5i?=
 =?utf-8?B?WjB5ZjJWUXIySCtRVTEvSWxBYjhhMFc5cERMcjR4djFRWTJzTjJ1c1haaEdP?=
 =?utf-8?B?Z0dycUtjcEpNSU53cCs5ZEgwQjdQbWxPY0hwbHgwb1F0dDVEZEEvSW5qYUZ3?=
 =?utf-8?B?MXZMTDQxYWl6a0tIc1lmYjdHZklDVWRxWkNNZHVScExPY2duamErYjczM1hK?=
 =?utf-8?B?OVN1RWgzTERkQWpNbEhVNEd2RllLT2VlOWpXYkJEUzgxK1psVWdqZEFBcmFC?=
 =?utf-8?B?MzBrbVdXVEdzWEx4OVMrYSt0Uk8waHZVZTNmYzBGaGhiUDhJRXlVUEZVZlRP?=
 =?utf-8?B?dlkwVjlDWEd4OEl6YlIxYUZJVVRiZTBkTVc1cjhrY0xVNEhYWnk1cTdCZzVq?=
 =?utf-8?B?ZFJwZ29ZTHNCdzhlcWZjSkM4U2xUbzdZak9GbnIyanhQUnViSm1MbGdWendl?=
 =?utf-8?B?RDhrT29xQkFWMEcvZmJtQm5yNTNndTV6QWh3dnFyankrSWNDbDY0dEtQWXZS?=
 =?utf-8?Q?LF1eVrQDcxKBszYsuzKj3qqQy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4704c29d-780e-4b10-81a6-08dca79dfa1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 02:53:32.7639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tm5KWhjrHdPE0DNogWF4drC+3+tRmiCqpWalB2R94P2A7cGflSl3KPOOM1vdxiyuwmqRBGHKXhJtITJehsB8k6T4MTWNos8GukOA+VlMYO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6056
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAxNi8xN10gaW50ZWxfaW9tbXU6IE1vZGlmeSB4LXNjYWxhYmxlLW1vZGUgdG8gYmUN
Cj5zdHJpbmcgb3B0aW9uDQo+DQo+DQo+DQo+T24gMTgvMDcvMjAyNCAxMDoxNiwgWmhlbnpob25n
IER1YW4gd3JvdGU6DQo+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0
YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzDQo+ZW1haWwgY29tZXMgZnJvbSBh
IGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+DQo+Pg0K
Pj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pg0KPj4gSW50ZWwgVlQtZCAz
LjAgaW50cm9kdWNlcyBzY2FsYWJsZSBtb2RlLCBhbmQgaXQgaGFzIGEgYnVuY2ggb2YgY2FwYWJp
bGl0aWVzDQo+PiByZWxhdGVkIHRvIHNjYWxhYmxlIG1vZGUgdHJhbnNsYXRpb24sIHRodXMgdGhl
cmUgYXJlIG11bHRpcGxlIGNvbWJpbmF0aW9ucy4NCj4+IFdoaWxlIHRoaXMgdklPTU1VIGltcGxl
bWVudGF0aW9uIHdhbnRzIHRvIHNpbXBsaWZ5IGl0IGZvciB1c2VyIGJ5DQo+cHJvdmlkaW5nDQo+
PiB0eXBpY2FsIGNvbWJpbmF0aW9ucy4gVXNlciBjb3VsZCBjb25maWcgaXQgYnkgIngtc2NhbGFi
bGUtbW9kZSIgb3B0aW9uLiBUaGUNCj4+IHVzYWdlIGlzIGFzIGJlbG93Og0KPj4NCj4+ICItZGV2
aWNlIGludGVsLWlvbW11LHgtc2NhbGFibGUtbW9kZT1bImxlZ2FjeSJ8Im1vZGVybiJ8Im9mZiJd
Ig0KPj4NCj4+ICAgLSAibGVnYWN5IjogZ2l2ZXMgc3VwcG9ydCBmb3Igc3RhZ2UtMiBwYWdlIHRh
YmxlDQo+PiAgIC0gIm1vZGVybiI6IGdpdmVzIHN1cHBvcnQgZm9yIHN0YWdlLTEgcGFnZSB0YWJs
ZQ0KPj4gICAtICJvZmYiOiBubyBzY2FsYWJsZSBtb2RlIHN1cHBvcnQNCj4+ICAgLSAgaWYgbm90
IGNvbmZpZ3VyZWQsIG1lYW5zIG5vIHNjYWxhYmxlIG1vZGUgc3VwcG9ydCwgaWYgbm90IHByb3Bl
cg0KPj4gICAgICBjb25maWd1cmVkLCB3aWxsIHRocm93IGVycm9yDQo+cy9wcm9wZXIvcHJvcGVy
bHkNCj5NYXliZSB3ZSBjb3VsZCBzcGxpdCBhbmQgcmVwaHJhc2UgdGhlIGxhc3QgYnVsbGV0IHBv
aW50IHRvIG1ha2UgaXQgY2xlYXINCj50aGF0ICJvZmYiIGlzIGVxdWl2YWxlbnQgdG8gbm90IHVz
aW5nIHRoZSBvcHRpb24gYXQgYWxsDQoNCllvdSBtZWFuIHNwbGl0IGxhc3QgYnVsbGV0IGFzIGEg
c2VwYXJhdGUgcGFyYWdyYXBoPw0KVGhlbiB3aGF0IGFib3V0IGJlbG93Og0KDQogIC0gImxlZ2Fj
eSI6IGdpdmVzIHN1cHBvcnQgZm9yIHN0YWdlLTIgcGFnZSB0YWJsZQ0KICAtICJtb2Rlcm4iOiBn
aXZlcyBzdXBwb3J0IGZvciBzdGFnZS0xIHBhZ2UgdGFibGUNCiAgLSAib2ZmIjogbm8gc2NhbGFi
bGUgbW9kZSBzdXBwb3J0DQogIC0gIGFueSBvdGhlciBzdHJpbmcsIHdpbGwgdGhyb3cgZXJyb3IN
Cg0KSWYgeC1zY2FsYWJsZS1tb2RlIGlzIG5vdCBjb25maWd1cmVkLCBpdCBpcyBlcXVpdmFsZW50
IHRvIHgtc2NhbGFibGUtbW9kZT1vZmYuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBp
bmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8ICAxICsNCj4+ICAgaHcvaTM4Ni9pbnRlbF9p
b21tdS5jICAgICAgICAgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKy0NCj4+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Yi9pbmNsdWRlL2h3L2kzODYv
aW50ZWxfaW9tbXUuaA0KPj4gaW5kZXggNDgxMzRiZGExMS4uNjUwNjQxNTQ0YyAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiArKysgYi9pbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gQEAgLTI2Myw2ICsyNjMsNyBAQCBzdHJ1Y3QgSW50ZWxJ
T01NVVN0YXRlIHsNCj4+DQo+PiAgICAgICBib29sIGNhY2hpbmdfbW9kZTsgICAgICAgICAgICAg
IC8qIFJPIC0gaXMgY2FwIENNIGVuYWJsZWQ/ICovDQo+PiAgICAgICBib29sIHNjYWxhYmxlX21v
ZGU7ICAgICAgICAgICAgIC8qIFJPIC0gaXMgU2NhbGFibGUgTW9kZSBzdXBwb3J0ZWQ/ICovDQo+
PiArICAgIGNoYXIgKnNjYWxhYmxlX21vZGVfc3RyOyAgICAgICAgLyogUk8gLSBhZG1pbidzIFNj
YWxhYmxlIE1vZGUgY29uZmlnICovDQo+PiAgICAgICBib29sIHNjYWxhYmxlX21vZGVybjsgICAg
ICAgICAgIC8qIFJPIC0gaXMgbW9kZXJuIFNNIHN1cHBvcnRlZD8gKi8NCj4+ICAgICAgIGJvb2wg
c25vb3BfY29udHJvbDsgICAgICAgICAgICAgLyogUk8gLSBpcyBTTlAgZmlsZWQgc3VwcG9ydGVk
PyAqLw0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDI4MDRjMzYyOGEuLjE0ZDA1ZmNlMWQgMTAwNjQ0DQo+
PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4gQEAgLTM3NzAsNyArMzc3MCw3IEBAIHN0YXRpYyBQcm9wZXJ0eSB2dGRfcHJvcGVy
dGllc1tdID0gew0KPj4gICAgICAgREVGSU5FX1BST1BfVUlOVDgoImF3LWJpdHMiLCBJbnRlbElP
TU1VU3RhdGUsIGF3X2JpdHMsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBWVERfSE9TVF9B
V19BVVRPKSwNCj4+ICAgICAgIERFRklORV9QUk9QX0JPT0woImNhY2hpbmctbW9kZSIsIEludGVs
SU9NTVVTdGF0ZSwgY2FjaGluZ19tb2RlLA0KPkZBTFNFKSwNCj4+IC0gICAgREVGSU5FX1BST1Bf
Qk9PTCgieC1zY2FsYWJsZS1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLA0KPnNjYWxhYmxlX21vZGUs
IEZBTFNFKSwNCj4+ICsgICAgREVGSU5FX1BST1BfU1RSSU5HKCJ4LXNjYWxhYmxlLW1vZGUiLCBJ
bnRlbElPTU1VU3RhdGUsDQo+c2NhbGFibGVfbW9kZV9zdHIpLA0KPj4gICAgICAgREVGSU5FX1BS
T1BfQk9PTCgic25vb3AtY29udHJvbCIsIEludGVsSU9NTVVTdGF0ZSwNCj5zbm9vcF9jb250cm9s
LCBmYWxzZSksDQo+PiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJ4LXBhc2lkLW1vZGUiLCBJbnRl
bElPTU1VU3RhdGUsIHBhc2lkLCBmYWxzZSksDQo+PiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJk
bWEtZHJhaW4iLCBJbnRlbElPTU1VU3RhdGUsIGRtYV9kcmFpbiwgdHJ1ZSksDQo+PiBAQCAtNDY4
Niw2ICs0Njg2LDI4IEBAIHN0YXRpYyBib29sDQo+dnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01N
VVN0YXRlICpzLCBFcnJvciAqKmVycnApDQo+PiAgICAgICAgICAgfQ0KPj4gICAgICAgfQ0KPj4N
Cj4+ICsgICAgaWYgKHMtPnNjYWxhYmxlX21vZGVfc3RyICYmDQo+PiArICAgICAgICAoc3RyY21w
KHMtPnNjYWxhYmxlX21vZGVfc3RyLCAib2ZmIikgJiYNCj4+ICsgICAgICAgICBzdHJjbXAocy0+
c2NhbGFibGVfbW9kZV9zdHIsICJtb2Rlcm4iKSAmJg0KPj4gKyAgICAgICAgIHN0cmNtcChzLT5z
Y2FsYWJsZV9tb2RlX3N0ciwgImxlZ2FjeSIpKSkgew0KPj4gKyAgICAgICAgZXJyb3Jfc2V0Zyhl
cnJwLCAiSW52YWxpZCB4LXNjYWxhYmxlLW1vZGUgY29uZmlnLCINCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgIlBsZWFzZSB1c2UgXCJtb2Rlcm5cIiwgXCJsZWdhY3lcIiBvciBcIm9mZlwi
Iik7DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAg
aWYgKHMtPnNjYWxhYmxlX21vZGVfc3RyICYmDQo+PiArICAgICAgICAhc3RyY21wKHMtPnNjYWxh
YmxlX21vZGVfc3RyLCAibGVnYWN5IikpIHsNCj4+ICsgICAgICAgIHMtPnNjYWxhYmxlX21vZGUg
PSB0cnVlOw0KPj4gKyAgICAgICAgcy0+c2NhbGFibGVfbW9kZXJuID0gZmFsc2U7DQo+PiArICAg
IH0gZWxzZSBpZiAocy0+c2NhbGFibGVfbW9kZV9zdHIgJiYNCj4+ICsgICAgICAgICFzdHJjbXAo
cy0+c2NhbGFibGVfbW9kZV9zdHIsICJtb2Rlcm4iKSkgew0KPj4gKyAgICAgICAgcy0+c2NhbGFi
bGVfbW9kZSA9IHRydWU7DQo+PiArICAgICAgICBzLT5zY2FsYWJsZV9tb2Rlcm4gPSB0cnVlOw0K
Pj4gKyAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgcy0+c2NhbGFibGVfbW9kZSA9IGZhbHNlOw0K
Pj4gKyAgICAgICAgcy0+c2NhbGFibGVfbW9kZXJuID0gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICAgICAgIGlmIChzLT5hd19iaXRzID09IFZURF9IT1NUX0FXX0FVVE8pIHsNCj4+ICAgICAg
ICAgICBpZiAocy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiAgICAgICAgICAgICAgIHMtPmF3X2Jp
dHMgPSBWVERfSE9TVF9BV180OEJJVDsNCj4+IC0tDQo+PiAyLjM0LjENCj4+DQo+TEdUTQ0K

