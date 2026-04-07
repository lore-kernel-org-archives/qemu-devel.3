Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A80FB5183
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9vz5-00024Y-6M; Mon, 06 Apr 2026 22:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w9vyx-00022g-6I
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:15:59 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w9vyt-0005Ev-VU
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775528156; x=1807064156;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=G1H1c7mX+i+gFvKQ4bxFosIDbYgJPMJ+SvEcYRtv34U=;
 b=SBp3anXzOO5/L9wKvLGNMID8XMEQ3ub/S3d08X9oDkbx6SbPNR0VNSiw
 lareKr1W4QCeLhGKmu+wadNJo7DA7IgkmnJCBEAuSHZPY1PBhKxgnRfHc
 MM+pmgMDbIJkxuWJvUynZYTKPWyxARVEmpZkAhgbjmqkQnOjJv+2KNlO2
 oeqc1v0ANPoW1KfkJf4kLIAbGJ50bZmHGoSkTsYJvGQogvTeLgvsqVEIj
 kIMk4xP0Iux7QJJugjxZ2//IymweYDupJVHPhF7z9ABPkcU12MK1E15va
 U3lSg4Y7JJt0cHMeQwNnh74/emVfJVpKntlHg0NVhj24CQBo2GE4p56sy w==;
X-CSE-ConnectionGUID: bPI75nRtQVOy6cWHpiGivA==
X-CSE-MsgGUID: QX/8JlVnQdKaKNrfJ+M5fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="87107971"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; d="scan'208";a="87107971"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 19:15:51 -0700
X-CSE-ConnectionGUID: E5xW1zFSSyK28afmX+lIfw==
X-CSE-MsgGUID: smVOyA4MRaKPgMuTFnHC6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; d="scan'208";a="251311587"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 19:15:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 19:15:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 19:15:50 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.17)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 19:15:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6URBKSNDws4hxtBnghY4Ab+B5xKE2OEpPBuJEiPI6ZndbcjEuX8ZicXQ0uj3cLMw3CPjzpF5DW7+zSMC/+Ss0i6nz2ohI4LWThg4VbktlbkMHp1lCb6IuxhFj+MEBRcPkGdhSvtSV181n/M/rVff1p77n6aOcajn306MR7JgKay6bs+gBmAN1gyV5PJuVS/eKxxi5lEfN+CMFKS7KbJFS/+qsWdDDV60HpzQGmGoCDum0UMli+N+Dq2W5Ckr4l+J5MOZy9aAP/gu9Uxw9bN767bXb5tLDNI3GOMqQZAZ3y7YrBLtDed6ITBZnI1UgKNymQhbrX1hEgbgmUxEEXabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1H1c7mX+i+gFvKQ4bxFosIDbYgJPMJ+SvEcYRtv34U=;
 b=ZMgzxPYBXdl2tyjmrHx1RmIgp+X9Ro2LGlJxrV0OGBtweWVB3OGmjmPl+6mvD3kfOvO+X9ITyh1y51h7qP19Xd7itxG334uEHuvIlUHItujCN/ja/b4TnnGgIrU15Cu8YJZqwqAqY2JQCP1TfpURFcvOqOjT5YuSFYlcU752FhM9cggFJ0DNtAwKdRelFz86F+dItHJCOESFJPRhCoLnY4wTNggYLL9oy482TxH73pOeQxsVGSya1GL5ausNT3yRaF1FWDDqvhwxx7PCiOHDQmzvyPV5Neu1yifyREAXM8wPldd84wygqRbU29PjK0IP5J1NjcZAA7fP6M/xCREQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 7 Apr
 2026 02:15:47 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Tue, 7 Apr 2026
 02:15:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao,
 Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v3 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [PATCH v3 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHcwx3PMb02EC3zwUCCtH1PR6J357XNFQqAgAXNNbA=
Date: Tue, 7 Apr 2026 02:15:47 +0000
Message-ID: <IA3PR11MB91363EC0C55A498800BD977A925AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-4-zhenzhong.duan@intel.com>
 <6e7013da-fae9-48a3-bdd0-9e19711cedaf@redhat.com>
In-Reply-To: <6e7013da-fae9-48a3-bdd0-9e19711cedaf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB7633:EE_
x-ms-office365-filtering-correlation-id: 2e11fb1b-a052-4b63-54ab-08de944b94b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 2Oy4GMPsJlVr8m88WvQ1JBbYU2bebQdORdkVRyG6Yj5CCJWReMCbezKOtP7IJSeNLLdQQW33beDN6ahtbA4nSN4Rpw5Jb+yoEIDUIoujj4HuEOitUpLvuNLQBHNG/UComNqWfK0Jna010IbPvtDX3vfZd6eBQgTB9aeVgNRQXEPOhJQbamd+QM40dJ2wSpZ9zgK+zwEIo6Gs+7TcBKbtTNog8TNlzdgnZyEjx+/I1eC48umVzBMgYYF8iV52wEYkckU7cuuMyMpBty/gBBBC0BMleY186DGE8awkrGEHG10HwGJmU3jMDI8EVgL5Bu7GxbljAkIqTzwu0h++LkHJ/eoBIVnOxC3aR6ydJQVn1tLU1rInRhaHGeSq1d3mpQOk52kVteVjgH7/6oayRVdCbm0/02GHzmhBdSux2Ka3LkgEhPe+nZOvVIebZwvOqOEX+B2+Dz1wyefxERAnYymF3kSX/61DZNQpeRvZFpBos4q9CUhuSawHhCUTv8rke2LNLAs0bObA3SJg3NgKv6/LuDSCgfDMfeLNxUnjpmyqyEVvXGh7ypYe0+nh9LArMAwM6/gnZnmebY1ssgfMsrHyAgAuiGVZqWHcKxlJ5VNRrLX8DYrllinB/WomAvGCOr2ETUJjzYv0ghXvg6hFnQBWbW3DJPlI1TK3NZKxk6LgH1dW1KJJwyy95Ls6Ffi20SWYjnW4TvOOP+fKdGl0/sSn/zpyh+gbYfPm00VaHFo+yUf75FBY9L5msh2ZRL3TvOgimzGy2K8TVk2PYfR/YlgdVClw3NTIf4ZeQFYttzn3q2I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODlPTmNKeWFFWlRjRktaR0hTZGgzaitMR2l4WS9XMGJSVEtUUThOUURicjFW?=
 =?utf-8?B?dFdESW1kb2ZCY0xzUVphSXVnOFd1M0dMblFHR0w0NTllT01Sakl4Yk0rU3JU?=
 =?utf-8?B?VXFZOUF4Zm5pSUlzUnVRL2ZydTlqM0xjRmJCMnpSSkZOdXlEM3ZJTzBCUUsz?=
 =?utf-8?B?bjU0TDBNamN4VWZ4am15WGZrMFpnZDdHdzJjVGR5bXJwZ0hWL3lkOW5KbnpQ?=
 =?utf-8?B?YkxPRmhpSVRsV1pVUXFKNkp4Zllmc01Gai9Ta2lEaENYZWlPaDRBZE15MG9l?=
 =?utf-8?B?aWIxUHFFalpIM3hnb3VFMElKR0ZkQ054SEM5YU0zeDBIWEc4bUNzd2hxWnJI?=
 =?utf-8?B?NE11T0JoSWlqQmMrRGxSKzFpdjhoZDQ2cnZZK0NMRjQzb2lWZHRQcFpEUG9x?=
 =?utf-8?B?UVBqYzNvamhWMElNZGU4aVhVQ1g0UGRtMXdXU2d6OGxJaGFmbHNGRmJpT0JT?=
 =?utf-8?B?RDF3OUd2ZXIxMFJWWHdhNjkyc1ZhOWVxWE01Mi9LZUdpeGs5R1Z1Qmc5MSts?=
 =?utf-8?B?VGJRazJWU21CdzZ3bXBBZW1vNWNLWEtvNFpxbkxxelJKa0txcmZDWXdNT1c3?=
 =?utf-8?B?eEh3cThiVFJ6UTcrZGx4bHQrbGtoSWcyTlE5ay94S040ZXo4V1pJWmpjVitl?=
 =?utf-8?B?N3krNnpRZkF3bGh5UzlDVUk3Q1pXcUN2cTVJVi9NS3VWYWJUWGRBYlY5Mkk3?=
 =?utf-8?B?RWp5TW5ra3pSOVVmWm4vRHVLaGZpdUVWeHhReGhOM0xtcGNrNGpIREJXSkFr?=
 =?utf-8?B?UTduV1FPelF2dmRGUjhqUllHSER3L1B4YkdzN3NCVTkzeTZKZmtmNytmazBP?=
 =?utf-8?B?ek9DQ3J0UXVMc3pUQms2eW1HNUJTRWxzUUJwaE9OeVZRdlk3clJ1RENkV2hF?=
 =?utf-8?B?VHd5QnJWdGNrK25yUTlrZTROZXQ2dzZqTUFrUVBQSi8zd2t5SHNmZ2tJSXBp?=
 =?utf-8?B?Z3pyOFYzWm5WUG0zVkdxYitpVnVEOGxXeW5ZL2orKzVtSjRvS2ROcm5kYVQ5?=
 =?utf-8?B?U3hPbUluM1J6TWpPOHpIQU9nekRheXFPV0M2S1YycE0xRHFVVE51dG81OGRK?=
 =?utf-8?B?bjZUbUtMTnkyUFBqZ3pMdFhXVk94RXA3ODJzanpLUW1ic2daV241ay9VY0NR?=
 =?utf-8?B?cG0vaW1WQjhmc083Zm9RVjRvL1d0TjBaeXpJZEpGcld0azIwbUJvQllINWpx?=
 =?utf-8?B?d3FyYXRZOGtEa2IwSUpUbFBWcjM5K3c5ODFObWFmK2Z3eXFBY2RrQmNvY1NB?=
 =?utf-8?B?R1hUVm9KcXJWZG0xZ3kxeGJvS2FWanRZSWFlNFlSSURybGYwQUoxVW1hRkI4?=
 =?utf-8?B?QVdBUHV3QlIvUkhNNDR1MU1WK3ZLendIeTUyNy82N0dyaGl5Q00xaG54Wnha?=
 =?utf-8?B?SFF0Z0Y1VVBlMDdFd1Y2SUgzWHArSStTZ1VKK05RVU4rUTBsUnUxeFZCSkpG?=
 =?utf-8?B?ZVh2R3NXSE10SnYva1F2OXZzR3dZMnRBd2IyQVJBUk5EMWZXQnJ3R21PMHll?=
 =?utf-8?B?b0lhdnI2anB1R1JuQkh4ck4xYlMrOW9Ealg4TjFrVEordWxzaVBJcW1xdzUv?=
 =?utf-8?B?YUdzdkhWbWtqZlJBUUpleFRSZmhmYUsvTk9aRTB6UVYybHJqbXJMb1JPeDU4?=
 =?utf-8?B?MCtvaGxTNUdodVo3Vi9HRzBMTTAwOTdLei9QVUc5bFRVM2xDL0thTFFJT3Qx?=
 =?utf-8?B?S1BHVjZrYlRsd3FibzdLUGJPT3o0elpCRGRaZXFHT0E3Y1RWVEpUTGgrbTQv?=
 =?utf-8?B?TDlqdlNMdGJQcVl3UTBwK21wdUhPYk9WREg4R0g1K3hOS1RieFFRRTFvbEpY?=
 =?utf-8?B?SjZJQlR5Sm15Z1REWC94RmNxdkpNS1FDQS9rSmM2TWsrMmN2d3dqWDlQeDNw?=
 =?utf-8?B?YmJKRk1OckM3YXdrZGFMWmxjUGJOU0hpbzRXTjdZVlhaUDJYU0RLUnY2Tjlp?=
 =?utf-8?B?NG1oS1I2N2xORjVGbktQeThFaUc1V0N1Y0lwMjhzYmZlSlYwWXFqTElPdjNO?=
 =?utf-8?B?UFU5MCtVenF5TGllMlU1Q1JOV1ZKYVMwTW1RZzVtaDVJWGU5OTYyaDVvdEpx?=
 =?utf-8?B?RXZZRDJIL1pGdFlCMnMzVGFnaHlpSHFsNW9CZkU4THhsdVVScGpYRXJNc0Nr?=
 =?utf-8?B?RE02ZEVSMGpLMzlodG9LcHJyeU5FaVJOWmdJSXcrb3NpVzVrZHd3K1hFdHZU?=
 =?utf-8?B?aHFTWEUrNG9FOXRxUEoxQkFxSTBnUGpLRXk0cnJnUTBqR2hUNEppNlBFY2NN?=
 =?utf-8?B?VnBTZGtrWndkM3dTSTR3azdZcW53TlpvZnlVZVlxdGxneVgybFpVeVI1akhI?=
 =?utf-8?B?dThGeG1rWUk4VTFvRnRaZUg2S3dTWE9RYnVCdmZyRDRFcCswSlIxdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UYaFBhOqhoOXaWW9SHUTJu2PNxZLKs5SRQDvtx5Nk0AmevHR6d+17rjH3HYfHx9CGif9JOVKPKkQR+mGRrLeAL15OP0z66OIIw+ikaFOPDMhIfOcS4FJ0hNLWg/tSfoWh5BAtZYdx3xaJ2OTcZs2QiWKvgwF1AZK9oAdwbJWlo7rszL7lxbr+zf+hlWvIhn3rSWM8ce5Id8HjXu2pbwi9V6Rb3sqI4mWKaN/5Y87kudmfesRF6LXNo2Xl9EX/T/2TiFF7asb62mdrrUl0pyWJijOsy11HCrH+YXgoBvdk2uCy4Rex7RLdMDCK1m1Kl2i7KCHdlPjly0UmSWDuZhKYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e11fb1b-a052-4b63-54ab-08de944b94b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 02:15:47.1088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fG9voXQ6jOAY/7fI2q12SzskqKxuwP+1JSIvk/jGzv32BwVzZSJEoOm2izGtfMj57jjd55ttHBqqaKfBrqKfSRsIRZnfl9zR9wF8zPMIH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGVsbG8gQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8Op
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2
MyAwMy8xNF0gdmZpby9pb21tdWZkOiBDcmVhdGUgbmVzdGluZyBwYXJlbnQgaHdwdCB3aXRoDQo+
SU9NTVVfSFdQVF9BTExPQ19QQVNJRCBmbGFnDQo+DQo+SGVsbG8gWmhlbnpob25nDQo+DQo+T24g
NC8zLzI2IDA1OjU1LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFdoZW4gYm90aCBkZXZpY2Ug
YW5kIHZJT01NVSBoYXZlIFBBU0lEIGVuYWJsZWQsIHRoZW4gZ3Vlc3QgbWF5IHNldHVwDQo+PiBw
YXNpZCBhdHRhY2hlZCB0cmFuc2xhdGlvbi4NCj4+DQo+PiBWRklPIG5lZWRzIHRvIGJlIGF3YXJl
IG9mIHBvdGVudGlhbCBwYXNpZCB1c2FnZSBhbmQgc2hvdWxkIGF0dGFjaCB0aGUNCj4+IG5vbi1w
YXNpZCBwYXJ0IG9mIHBhc2lkLWNhcGFibGUgZGV2aWNlIHRvIGh3cHQgZmxhZ2dlZCB3aXRoDQo+
PiBJT01NVV9IV1BUX0FMTE9DX1BBU0lELg0KPj4NCj4+IEFSTSBTTU1VIGRvZXNuJ3Qgc3VwcG9y
dCBJT01NVV9IV1BUX0FMTE9DX1BBU0lELCBvbmx5IFZURCBuZWVkIGl0LiBTbw0KPj4gd2UgY2Fu
J3QgY2hlY2sgdGhlIGV4aXN0aW5nIHZJT01NVSBmbGFnIFZJT01NVV9GTEFHX1BBU0lEX1NVUFBP
UlRFRCB0bw0KPj4gZGV0ZXJtaW5lIGlmIHNldCBmbGFnIElPTU1VX0hXUFRfQUxMT0NfUEFTSUQu
IEluc3RlYWQsIGludHJvZHVjZSBhIG5ldw0KPj4gZmxhZyBWSU9NTVVfRkxBR19XQU5UX1BBU0lE
X0FUVEFDSCB3aGljaCB3aWxsIG9ubHkgYmUgZXhwb3NlZCBieSBWVEQuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IFJl
dmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFRlc3RlZC1ieTogWHVk
b25nIEhhbyA8eHVkb25nLmhhb0BpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9ody9j
b3JlL2lvbW11LmggICAgICAgfCAgMSArDQo+PiAgIGluY2x1ZGUvaHcvdmZpby92ZmlvLWRldmlj
ZS5oIHwgIDEgKw0KPj4gICBody92ZmlvL2RldmljZS5jICAgICAgICAgICAgICB8IDExICsrKysr
KysrKysrDQo+PiAgIGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAgICAgIHwgIDggKysrKysrKy0N
Cj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvY29yZS9pb21tdS5oIGIvaW5jbHVkZS9ody9j
b3JlL2lvbW11LmgNCj4+IGluZGV4IGJmY2Q1MTEwMTMuLjY3YzU3NWIwOGMgMTAwNjQ0DQo+PiAt
LS0gYS9pbmNsdWRlL2h3L2NvcmUvaW9tbXUuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9jb3JlL2lv
bW11LmgNCj4+IEBAIC0yMSw2ICsyMSw3IEBAIGVudW0gdmlvbW11X2ZsYWdzIHsNCj4+ICAgICAg
IC8qIHZJT01NVSBuZWVkcyBuZXN0aW5nIHBhcmVudCBIV1BUIHRvIGNyZWF0ZSBuZXN0ZWQgSFdQ
VCAqLw0KPj4gICAgICAgVklPTU1VX0ZMQUdfV0FOVF9ORVNUSU5HX1BBUkVOVCA9IEJJVF9VTEwo
MCksDQo+PiAgICAgICBWSU9NTVVfRkxBR19QQVNJRF9TVVBQT1JURUQgPSBCSVRfVUxMKDEpLA0K
Pj4gKyAgICBWSU9NTVVfRkxBR19XQU5UX1BBU0lEX0FUVEFDSCA9IEJJVF9VTEwoMiksDQo+DQo+
VklPTU1VX0ZMQUdfV0FOVF9ORVNUSU5HX0RJUlRZX1RSQUNLSU5HIHdhcyBpbnRyb2R1Y2VkIHNp
bmNlLiBUaGUNCj5jaGFuZ2UNCj5pcyBvbiB2ZmlvLW5leHQuDQo+DQo+WW91IHdpbGwgbmVlZCB0
byByZWJhc2UuIFdoaWxlIGF0IGl0LCBJIHRoaW5rIHRoZSBkb2N1bWVudGF0aW9uIG9mIGVhY2gN
Cj5vZiB0aGVzZSBWSU9NTVVfRkxBR3MgY2FuIGJlIGltcHJvdmVkLg0KDQpTdXJlLCB3aWxsIGRv
Lg0KDQpCUnMsDQpaaGVuemhvbmcNCg==

