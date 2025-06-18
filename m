Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C183C71136
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 02:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRiKL-0004AN-N3; Tue, 17 Jun 2025 22:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uRiKJ-0004A0-6s
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 22:14:59 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uRiKH-0001Il-Bd
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 22:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750212897; x=1781748897;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wIAtXtixvBJfc7nI2N+pjBoFI8QD2O038BKxubdBGTM=;
 b=iPu/Ht3xc1u33RB6Hg0Cv7coHZw1qRcjf8Tvs19RgE/WmdryspZKKli/
 nlaaNhz9aksxanrFFsv0GP/OTRHggTqQ6dPIhM+LzDirrlBdDIDAFBNno
 BEvjfFRizNrNkkPGMd0JVk0Vf7ZO309b+7ATHU+qzFa8MAkvwI5WbT0o0
 CKKPlqqFLwjw/B8cScvdtzH2yeUWlIGIXlmZo9FHymPCNlFXB4BZubJd7
 C6CxKQ47QpwVDcsCqyrHYbWhdWuyxYgrQuY33oOtQSTrhVeFbFrRz6doi
 P0WftRTLIiVdF/e87ZLUEm0mU51TBah4GK6i9JPbNZiBsYorP4Ik0PzYh Q==;
X-CSE-ConnectionGUID: wi3dpw9PRBKhC0tM37sGjQ==
X-CSE-MsgGUID: x1L/H4ARSaqPcQMe+a24Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52277923"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="52277923"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 19:14:55 -0700
X-CSE-ConnectionGUID: k/LmS0UOT5S6eUXeW0uzzg==
X-CSE-MsgGUID: hWVGjbLLRvypq5cGVfxbIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="153780231"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 19:14:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 19:14:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 19:14:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.86) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 19:14:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMFbW9kilr0Gr/MVYn2TOWDUOmFQ5yl12PG5XX2l1yuqfQiCgldwmaOr99v3U5j20v7uG1QdIxH1G/8eeFwJFYyZfX499z1i6JfoevIOZu2l52N0rMiTZf2ZlvFu0zc6eoBySUVibK0FFNY958LZpsHHCToKq03hliKLyiKEsh3LHbwaaMhsRgyEP4vmkoKgs8HgNEBZvXdYDNNniCPQndH8cMAAcbWnlcH7p1tlJs/SwOZmV/sE5YAdrZFgJowCl1AmwWv+Ue/LqNS4t+NBVXY08Xk3HMQHPaGzO+qkGHg2Yu3sLBrr7vxYx9vkCSXwSFd7qITMa/ocLQh49Hglkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIAtXtixvBJfc7nI2N+pjBoFI8QD2O038BKxubdBGTM=;
 b=JYPjGn5R0qbv7SIF5xhr12PoUkfaZZMccES/QpY/StmjgTVGKxT+e5bt75y9KLs7rDNg/rIby2QLTUWqyregW9QD8V0fEyK9DqgwTopX28NMoYqmLX5TWYAN6KwepBTpN4xCPDYl/sk3YzYuDp1xr5j7T3KLxH1H66mJ97ty4HGWPqH3U8uodFiiG3bsp1RrXTYEwEjf6Gkn/ftNVOjI9ll7DX6EIywZ4h2m241U3lNWXTBnmVlQUFBPN6HCNLuBu6kBuQZTOIuYhHy15N2MHq18lDTLofkqsaMIFvFPRPV025ZLCColzpysm4vuqgnbxckJ+EXZxE9K7SubblKc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Wed, 18 Jun 2025 02:14:23 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 18 Jun 2025
 02:14:23 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v1 03/15] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH v1 03/15] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHb1sr0ghtk7+sah0iJXBRHkuawkLQHsuSAgACL+mA=
Date: Wed, 18 Jun 2025 02:14:23 +0000
Message-ID: <IA3PR11MB9136D8164C170467FE8C59C89272A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-4-zhenzhong.duan@intel.com>
 <a8b1cf9e-260f-4659-8eac-77993ebab842@redhat.com>
In-Reply-To: <a8b1cf9e-260f-4659-8eac-77993ebab842@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB5971:EE_
x-ms-office365-filtering-correlation-id: 7226e2f2-bc43-4a68-3060-08ddae0dd7f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UnlWMnNwRWU3Z1dnTEZJZUFJOGUwSStZV3UyL25KUEF3QWY2dGhGRGY2VWY4?=
 =?utf-8?B?LzlnbG45SGl4Yk43NmZNanR5Wk1RTkQ1Qk5BVUQ4MTh6aGIxb2RIc0VlTWdv?=
 =?utf-8?B?TUxuRm90dkhGeG5XWnlodWxHNHZCN1g5RXQvTHBBVVk5bUNTRlByYXZVMHg1?=
 =?utf-8?B?dlRrM29lOWs3VXJFaktXSy9jNm5kdk9RTGNGYUcrb2JmUm5jL3d6QWQzZjNT?=
 =?utf-8?B?RWJkVnoxQi9qWEc5WnFkMTNOeUhhc0R3RDBEV0VpQks2aFFCa1BRQ29KZ2E4?=
 =?utf-8?B?UlVNVUc3YlVkKzZqcnhiODhES01vRkd6SU85eVh0N3ZwOXZxRHRzejB1SG5D?=
 =?utf-8?B?ZG4xdWNoNlFaU25XbGYwbG54c1NHSnFZNDZxOUl2YThuSVBLN2Vzek9nZU0v?=
 =?utf-8?B?aXY0NVUyajBKYTZmZXpvWCtidXBRQ0NYYTVuMlIxZDdRaWpqZFJjTXdQMm03?=
 =?utf-8?B?cm1RY3ZRcjQxSktiME5pSUk5eWorOEc0S1A4L2t4cGJ2RHN6WFR0c3JEa3kv?=
 =?utf-8?B?czh2OGVIbXNPcU9NT3lnVXNpaUtFcUdWKzNISTZFd24yWWZPc09FdDFBR3JG?=
 =?utf-8?B?RlJXUTNuT1NhTm01cHNWbndvOXNhZHIyYmwwa3VxVXFPS3N2empuZkpBKzEz?=
 =?utf-8?B?QWMrTllDWXF5dm1sclk1cVZYeDRsZmFiNUxPVzRlMDdTb2pVZUs1NnM5bG1M?=
 =?utf-8?B?R2J2VWxnRlJoQ0gyeGVvMjhzcDJUK1ZyR0pQR3pnZER0R29GVm9tZXlQbEZO?=
 =?utf-8?B?d3NCTHNMOFh4NTNtc1JkWHVyNmgwWUUyandSd1BBdHFTR1QwdFFiaFVxYms2?=
 =?utf-8?B?TXRDbThSWlZscmRtNndMdUN0KzMxREZaZ0xjWloydVBHZllueENuS1JxNE5o?=
 =?utf-8?B?NXV3REZLd2ZMdGRTMndxUVl3cjZ6K1MvMnZIN3lRKzVYY0QrWUhzNlBOS1BS?=
 =?utf-8?B?ZVozTGdEVEpWZkV6VmpRN0tQTk9icmQ2bUV3di9MdG1mRUN3UXNCbjNESFhJ?=
 =?utf-8?B?ZmpmWmxLdzBQMjhQL2lGc0NUTHFlOTdYaTR5a3RRV3dNd0MrT2w4RlIrbEEx?=
 =?utf-8?B?ckhwc1MzYTIrQkJyWnZiN1hYeUZlNDRRczZpR21RekNjWDVoMWpTKzZNTHBN?=
 =?utf-8?B?NG1pYWNCS3JBcVgzZTR6NkwxOE91ZDh4OEM3MmdIQnNYWXd5NnY1bkZYbGJB?=
 =?utf-8?B?dkRHenU5QTNuNVhMalFsT01FU2RodWsrbldqeXZwdTFFcitOZk5mbmk2RHI3?=
 =?utf-8?B?VTROc2d1L2kvbHorT01JR082U0JUUVhoV3M2M1pzTThoWk1VamNOeTZkVE05?=
 =?utf-8?B?OFdkcjFOSWM5WVU5UnlVQUMrZ3NTaktpVkU2MFA5VmZUcktsZC8zcDZNVU96?=
 =?utf-8?B?bXlGc1lxcjlQQVVlaTdyVkI2ME5iUTZCUmdhcXQ3bjI5ZHdTcHhLcDljOWhK?=
 =?utf-8?B?VWhSU1hXZ0haaTF4cDByamt1eHFaZzZPT2JxL0R6OGRPNEIxNFFPdURLMDdt?=
 =?utf-8?B?S0dMVlgwbjJ6YzhoZWRya1dvcVVjTW1vKy9RbGEvVE8yeXJrSis2ODloVHhm?=
 =?utf-8?B?aDg3ck03aWtUWDBkcXIwdWtYcTY0WEJUb0RzRHlhb0d0SCswdkZDMGJVYmNZ?=
 =?utf-8?B?QzMraGdReEd1WWlENThMTVZHZTJybnhsTmpnK0E1cW5kbkhBL0RlcHlCQlBm?=
 =?utf-8?B?NEcybUgwT0hqRmNDck9XSGtLZXJ3Q05haUpla090OVd0TGwxbndOLzhlNGRH?=
 =?utf-8?B?S25CRGpGUVhIUExWdGxqQWptaDNpdW9JRXlOdTdiY1VGaEk3dU1td2pPNmtu?=
 =?utf-8?B?UTJNT3Roa0dWOFJUWFdvMmMzUDRCbzVuU3J5N0F3SFZYVVN3b3lmbGxnS1NZ?=
 =?utf-8?B?NTkyMi9TYkNVMi8zeCs0QzZFOFM1VXBzdHprYTZLcnMvcWNvSTZxSkVjUFZh?=
 =?utf-8?B?NU1UVTJMOG91YmJTY1E4WkFSM3duY1NYNWpGc1c4VmdRaVVRbkhDSnpGZG9R?=
 =?utf-8?B?Qm9HUzhLakNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WERnbHhldEV3YzhndUVoL1ZHYkJyaHZYRzhKeHkxem5EdEFXdjhkcVVHcEZp?=
 =?utf-8?B?cHhhUk5wbzZUS2o1VlM4cGgrdXBGSnpHdnRQR0lJNFF2Q0NqOXdYWHNEUXRZ?=
 =?utf-8?B?TjdVc09nb0huRGlyWngyNUp0TWIzTGlCYTlDUkRwbXNyc1E0OFRzSXpqRzlX?=
 =?utf-8?B?UENSSGZuaXArcGlmN2laZ1VkRkdpbHBIaUkvZm5vODgxc1lZcDdsNzlBK0JB?=
 =?utf-8?B?K1VYZTBRaEJvMWNNWVZUcmJNZE5OYzdzOHFCaU1zMDZyZ3pZNm9nTDlxQW5o?=
 =?utf-8?B?YVpGb1VaSXpPaG1ydTdvM3dHRXpqMUpUN3gxenpRR2tIRFVjam5mT2RVUTF4?=
 =?utf-8?B?ZGxxVXJsNStJOUFEWjdlZnEvZHZ2eWdSSjRwWFFtd096RWNKRFFwaEJjbDlM?=
 =?utf-8?B?U2JYNVVpVVRZNmZhbWJ3d1lSeEhSRDZFbE9EN2FxdmpsLzR2NW04L3dIdWc3?=
 =?utf-8?B?TFVuZlJmUjNxNjVZWk9CSEU1RlArYTdRMnQ5OEtRY1hQcEJ1MEFuYzdHN1Y4?=
 =?utf-8?B?OGU1Sm9vYlRoREYwMk5pd2hBMnh3bHc1UmhDMi84OHZoV3MzdnpQZEk3ZUlk?=
 =?utf-8?B?dzdpN2FrdnhHdTBxRTViTTBnQ2ZITitNeVhsTnM2SEUrYjNRRDJiY2Y3S2o4?=
 =?utf-8?B?L0pYMktNbDZPLzU3YmluMjFzSmhacS82dDNSeHJVNzc0VU5EZXV1UDZPTG9n?=
 =?utf-8?B?d3lWNTh5Z1k4VVBMRFhkb2ZDRk5CeXNoMmIvTGZhZWxUUWtOcGl1RktMZGZY?=
 =?utf-8?B?MkpRUDNzSkswLzNNUlBSTSswdWM3aEhEVEJMenNYcDBOWUx2NjhVazE0SzNq?=
 =?utf-8?B?clR6Q2lKdUZNdy9DVjVqbmw5SHVPVWRpMWxUd09pSmFESGRBcXBxckh2N29x?=
 =?utf-8?B?RVVmRkxTQmRqR2JleEozY0h3ZTVMK2ZEc1pWbzVsWUlUeDJ4Sk12UVpsRnVO?=
 =?utf-8?B?aUVFSHdwdjh1Z1huOGhzTm1wdkROT3NPZld5bGZ0amk5V2dlSkpFRVhYcEJ6?=
 =?utf-8?B?N1VUVVRDWGF5S0JYM3duNVV2ZU9rS3dIM3pRNkR4NXdrM1ZJREZMYXdwMmJF?=
 =?utf-8?B?eGEwRzBpeGRRZ244bjFvKzROeUlZTjNFYWwwWjRldW5ZNE5KTFZVTGhjbDRO?=
 =?utf-8?B?Wkdla0Jsc0JDazhoVDdURkNhK0c2cEtURWZqYmFjRldvbTFma29QeDZvdGZs?=
 =?utf-8?B?L0JyMTBPaENIK0QzWHFjdkM0NC84Y3BPay93YlJMVVBmZUJ6dUZYcnYyNzNW?=
 =?utf-8?B?UVJObndrU1NLbHZ5dlVJRitTUjNDSGwwN3hiMVJBZE1uQU9TV0ZuNmExdktI?=
 =?utf-8?B?NHd1TkVFRjMxRCs0WHVUaDc5YjhLY2k1Rjh4eTdxWmY1ejl2UHlzUFRyQ0Vz?=
 =?utf-8?B?TGYvUXkzWXpNREZrMjNVYUFYUFFrV3NQbDVOL2N0Q1NnL25pemxpZ1VSWHpJ?=
 =?utf-8?B?OU9KMzlPZTBEUXpOaklReURuVEtMYzJtTWZ4QU5ETGtheGFZQnRISFpCcUEy?=
 =?utf-8?B?Zi8zRmF1T3BnUUhwcFlGMmZ0bUcra1JxM2NIZ2hQYnZPK2phTzAvZHhrV3pM?=
 =?utf-8?B?WW1ROGhSOTFuc25nWGNoY1lmNjFtK2tDVmVUUXJESC9KeEVjQUxCaWJ6K08v?=
 =?utf-8?B?RGQwVmd5VlR3NUVZU2NLeCtWVWQyUWNadjRqUmdVZGx1U096bUdKVEtpNDZE?=
 =?utf-8?B?QUUrcjVaTGtjWGhSbSt2MkY3azNhaTVnL3hEaHRFWnVoRk5NME0vTm5nbWhQ?=
 =?utf-8?B?OEdtbDZDZG1sL21nOEoxR0VmTFVWdTlkT3JYQkpnZ1NjWTdoQll5N0Mrcjhn?=
 =?utf-8?B?cHRIdDB4akpBaWxwMlk4K1c1ZmlQZFVoa0IrR1RkNTFjOGhSRGZVYncveVgv?=
 =?utf-8?B?bDlLbUZBdW5ZYjhnTDNybTMyMXV3MThqWVdHWG9tWld2NEYvVFhycGk2U0E0?=
 =?utf-8?B?Z0tGOVpscTFCeHFnNmtLMUtRbERKUk56WEMwQVdvRnNDbC82bUhlRHZDUjJx?=
 =?utf-8?B?U2xJQnRKa0d2RW9pWDlDT3lla2t6SE5Jdzc5cVJiZWhrQTRmU1hUQzBHRzNt?=
 =?utf-8?B?RW9lMnRVZEpOQW15aXlkTllNRi9MQ2RBRnQzOGxWYmQzcXZzNktjNFZBbS85?=
 =?utf-8?Q?ALJk7zdxDwMEAALrp0jQBxY8x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7226e2f2-bc43-4a68-3060-08ddae0dd7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 02:14:23.6924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+DvS+mkletxkpYXC9FXSlsbmQdFDmgYYtp+6o7WDYXlo/ertTw5JXoh5x4V6udcobTCnDyKTC5+MdwpTKNvl4HnVrRhFntyl57nm954Of0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDAzLzE1XSBpbnRlbF9p
b21tdTogQ2hlY2sgZm9yIGNvbXBhdGliaWxpdHkgd2l0aA0KPklPTU1VRkQgYmFja2VkIGRldmlj
ZSB3aGVuIHgtZmx0cz1vbg0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiA2LzYvMjUgMTI6MDQg
UE0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2hlbiB2SU9NTVUgaXMgY29uZmlndXJlZCB4
LWZsdHM9b24gaW4gc2NhbGFibGUgbW9kZSwgc3RhZ2UtMSBwYWdlIHRhYmxlDQo+PiBpcyBwYXNz
ZWQgdG8gaG9zdCB0byBjb25zdHJ1Y3QgbmVzdGVkIHBhZ2UgdGFibGUuIFdlIG5lZWQgdG8gY2hl
Y2sNCj4+IGNvbXBhdGliaWxpdHkgb2Ygc29tZSBjcml0aWNhbCBJT01NVSBjYXBhYmlsaXRpZXMg
YmV0d2VlbiB2SU9NTVUgYW5kDQo+PiBob3N0IElPTU1VIHRvIGVuc3VyZSBndWVzdCBzdGFnZS0x
IHBhZ2UgdGFibGUgY291bGQgYmUgdXNlZCBieSBob3N0Lg0KPj4NCj4+IEZvciBpbnN0YW5jZSwg
dklPTU1VIHN1cHBvcnRzIHN0YWdlLTEgMUdCIGh1Z2UgcGFnZSBtYXBwaW5nLCBidXQgaG9zdA0K
Pj4gZG9lcyBub3QsIHRoZW4gdGhpcyBJT01NVUZEIGJhY2tlZCBkZXZpY2Ugc2hvdWxkIGJlIGZh
aWxlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+DQo+PiAtLS0NCj4+ICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgMSArDQo+
PiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMjggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IGU4YjIxMWU4YjAuLjJjZGE3NDQ3ODYgMTAw
NjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTE5MSw2ICsxOTEsNyBAQA0KPj4g
ICNkZWZpbmUgVlREX0VDQVBfUFQgICAgICAgICAgICAgICAgICgxVUxMIDw8IDYpDQo+PiAgI2Rl
ZmluZSBWVERfRUNBUF9TQyAgICAgICAgICAgICAgICAgKDFVTEwgPDwgNykNCj4+ICAjZGVmaW5l
IFZURF9FQ0FQX01ITVYgICAgICAgICAgICAgICAoMTVVTEwgPDwgMjApDQo+PiArI2RlZmluZSBW
VERfRUNBUF9ORVNUICAgICAgICAgICAgICAgKDFVTEwgPDwgMjYpDQo+PiAgI2RlZmluZSBWVERf
RUNBUF9TUlMgICAgICAgICAgICAgICAgKDFVTEwgPDwgMzEpDQo+PiAgI2RlZmluZSBWVERfRUNB
UF9QQVNJRCAgICAgICAgICAgICAgKDFVTEwgPDwgNDApDQo+PiAgI2RlZmluZSBWVERfRUNBUF9T
TVRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDMpDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCBhMmYzMjUwNzI0
Li5jNDJlZjgzZGRjIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiAr
KysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0zOSw2ICszOSw3IEBADQo+PiAgI2lu
Y2x1ZGUgImt2bS9rdm1faTM4Ni5oIg0KPj4gICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5o
Ig0KPj4gICNpbmNsdWRlICJ0cmFjZS5oIg0KPj4gKyNpbmNsdWRlICJzeXN0ZW0vaW9tbXVmZC5o
Ig0KPj4NCj4+ICAvKiBjb250ZXh0IGVudHJ5IG9wZXJhdGlvbnMgKi8NCj4+ICAjZGVmaW5lIFZU
RF9DRV9HRVRfUklEMlBBU0lEKGNlKSBcDQo+PiBAQCAtNDM2MSw2ICs0MzYyLDMzIEBAIHN0YXRp
YyBib29sIHZ0ZF9jaGVja19oaW9kKEludGVsSU9NTVVTdGF0ZSAqcywNCj5Ib3N0SU9NTVVEZXZp
Y2UgKmhpb2QsDQo+PiAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+ICAgICAgfQ0KPj4NCj4+ICsj
aWZkZWYgQ09ORklHX0lPTU1VRkQNCj5pcyBpdCByZXF1ZXN0ZWQ/DQoNClllcywgd2luZG93cyBi
dWlsZCBuZWVkcyBpdC4NCmlvbW11X2h3X2luZm9fdnRkIGFuZCBJT01NVV9IV19JTkZPX1RZUEVf
SU5URUxfVlREIGFyZSBkZWZpbmVkIGluIGxpbnV4L2lvbW11ZmQuaCwNCm1lYW53aGlsZSBhbGwg
YmVsb3cgY2hlY2sgdGFrZSBlZmZlY3Qgb25seSB3aGVuIElPTU1VRkQgaXMgc3VwcG9ydGVkLg0K
DQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+Q2hlZXJzDQo+DQo+RXJpYw0KPj4gKyAgICBzdHJ1
Y3QgSG9zdElPTU1VRGV2aWNlQ2FwcyAqY2FwcyA9ICZoaW9kLT5jYXBzOw0KPj4gKyAgICBzdHJ1
Y3QgaW9tbXVfaHdfaW5mb192dGQgKnZ0ZCA9ICZjYXBzLT52ZW5kb3JfY2Fwcy52dGQ7DQo+PiAr
DQo+PiArICAgIC8qIFJlbWFpbmluZyBjaGVja3MgYXJlIGFsbCBzdGFnZS0xIHRyYW5zbGF0aW9u
IHNwZWNpZmljICovDQo+PiArICAgIGlmICghb2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QoaGlv
ZCksDQo+VFlQRV9IT1NUX0lPTU1VX0RFVklDRV9JT01NVUZEKSkgew0KPj4gKyAgICAgICAgZXJy
b3Jfc2V0ZyhlcnJwLCAiTmVlZCBJT01NVUZEIGJhY2tlbmQgd2hlbiB4LWZsdHM9b24iKTsNCj4+
ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAoY2Fw
cy0+dHlwZSAhPSBJT01NVV9IV19JTkZPX1RZUEVfSU5URUxfVlREKSB7DQo+PiArICAgICAgICBl
cnJvcl9zZXRnKGVycnAsICJJbmNvbXBhdGlibGUgaG9zdCBwbGF0Zm9ybSBJT01NVSB0eXBlICVk
IiwNCj4+ICsgICAgICAgICAgICAgICAgICAgY2Fwcy0+dHlwZSk7DQo+PiArICAgICAgICByZXR1
cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaWYgKCEodnRkLT5lY2FwX3JlZyAm
IFZURF9FQ0FQX05FU1QpKSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJIb3N0IElP
TU1VIGRvZXNuJ3Qgc3VwcG9ydCBuZXN0ZWQgdHJhbnNsYXRpb24iKTsNCj4+ICsgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAocy0+ZnMxZ3AgJiYgISh2
dGQtPmNhcF9yZWcgJiBWVERfQ0FQX0ZTMUdQKSkgew0KPj4gKyAgICAgICAgZXJyb3Jfc2V0Zyhl
cnJwLCAiU3RhZ2UtMSAxR0IgaHVnZSBwYWdlIGlzIHVuc3VwcG9ydGVkIGJ5IGhvc3QgSU9NTVUi
KTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKyNlbmRpZg0KPj4g
Kw0KPj4gICAgICBlcnJvcl9zZXRnKGVycnAsICJob3N0IGRldmljZSBpcyB1bmNvbXBhdGlibGUg
d2l0aCBzdGFnZS0xIHRyYW5zbGF0aW9uIik7DQo+PiAgICAgIHJldHVybiBmYWxzZTsNCj4+ICB9
DQoNCg==

