Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AAEC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1Y0-0003Qb-9o; Wed, 17 Jul 2024 06:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sU1Xy-0003Pr-7N
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:06:06 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sU1Xr-0001HF-2C
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721210759; x=1752746759;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=M5nQ4PTqLCnT6kLz7b74jCHmpb74j/0/3xY4lUKd3us=;
 b=g94LYj4yTAV3AU3HzPzS8SBSzQOniAzdChZ2+oj5K2xdxKQ7nUapyAej
 YrXS1r3Gj1mb0trYG36LeNXE4s2h6GUjS7J/D9/vNl59NM8fg+4fNo7EN
 0OuJSJnIEUiXW/zWGcLnZfJ6zZuyt+MXHTNNv1aQ9SwEYt0tnbTQAmCMG
 Z1G/+n5k1lF9mHoL1pqajrk9GIOWac9HzON/oO7iR3m7y1mOOcn5+K45f
 NMeJJkvLcpzyXUq3Yj9CdrNZjLupF8NM71DsTFO98eulbXbb9CviBbXuA
 y2fgNBy8NPysn0N5U8n/tIO+1wIvj6qXl1HGqGASS5NFw/kbNKByFKXDS w==;
X-CSE-ConnectionGUID: v521xwx5SUeNt+F2IYWSsQ==
X-CSE-MsgGUID: nWQohxdrRXCNDtzg78HWeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="22468661"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; d="scan'208";a="22468661"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2024 03:05:55 -0700
X-CSE-ConnectionGUID: xh2Dn+6ERouaJc1VvZiHMA==
X-CSE-MsgGUID: ij68JYfTTlmiUCOGJLbdPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; d="scan'208";a="54531545"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jul 2024 03:05:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 03:05:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 03:05:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 03:05:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 03:05:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0k3N3ujdDSSjr0G4i+VoKIQzPqE7W8Hi0TQNRhqs0NnRk3acb5pIKNHjODHJ4s/6PgbHEtlFg5a6NsSisIskju+Smcq8Kf2WMZIH4kKTaEmzqBC9Ve35ls8Fg7ldnQpvno6HF6DaDIzhNbOqYqrw4oI1QHaA7nZ+cpEWWBisbcPjkAmqL0jVXJQQXZlveZasa7Ei80uylQRUzYyyqifFS97gfCLuup1Ye+odreBgJl9OpfL3olW7Ngex0DAmnDZJUU6W6+pYPso9P5hhMkAsDOkxBUZdctiGfWzHra8eFmQxi/4IEK961/q+oILeqwwA/ykhL/zHmvzw4R8dypc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5nQ4PTqLCnT6kLz7b74jCHmpb74j/0/3xY4lUKd3us=;
 b=sPU0AL3m/IAa9H2i9kqYSlwwOZVDjZExnfGVxNplzoEWtMBTlpDv1QF1ZOUS/mS1E3lyVhQ1Wzog7MT8HlmVd3+u/22sdAYcRpsaa7CQqksC1fE52pHAD4KMfXpE8ytsqBN5D63C1FsSzGP5QOZlU3FWoGYz1ljQBqno7ECRazkI6QE7ul6jQZ8WzuQTRP9ogPMzAXS5K3T6E/guqeisKCJFisYmWbRhXoPZdPh8KMsc4PDdOxbHiBZ+00r0MCBQJvTn6K79YdZ/LWzOLs51JFS46FpI6h+6hhuhUXJuiUc69XSA1a3dZjF6VSSPjencXPJ86RcyhNS/oYNwQpub+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 10:05:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 10:05:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
Thread-Topic: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
Thread-Index: AQHa1FFShwF3jB8O50qStFQJTkISYLH6NXowgAByoYCAAAxgYA==
Date: Wed, 17 Jul 2024 10:05:10 +0000
Message-ID: <SJ0PR11MB674420D8D4742A704036C9F892A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <SJ0PR11MB67443AD929EFB426B4E4FBBF92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <91d16e89-4733-437b-9674-b5a96f4398ec@oracle.com>
In-Reply-To: <91d16e89-4733-437b-9674-b5a96f4398ec@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6908:EE_
x-ms-office365-filtering-correlation-id: 1b49966f-da62-46c4-689b-08dca647f15d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WEpldzlvM0h3emJ6bnUzVlZsOTl3WWFlajlSbGlpZ0NPUTZ3d1B3cU5WUHJ3?=
 =?utf-8?B?c3VWdHhmMExDTzloN0NFTCsrWlZGSStId2R2TFNoZ2x3RFdXREZVV1lXMmpt?=
 =?utf-8?B?bWdvaEUrY3dnMFFKUHNjTkpVRlZNaWhoTUMxemJFbHFPOWZnQkNXR01oZTUv?=
 =?utf-8?B?VGkvTHVTL1R5MmcrbjNQSmZlVUJ1cC8xYk1QaGhsaWtJbklRaFJlWVhCUGps?=
 =?utf-8?B?dlpkWEhiQkFzSllxMmZvNkk2Y0N4d2t6bklxbTd6SWZLNThhc3N3OWhReWp4?=
 =?utf-8?B?a1VvdDd2WHNGcU9saThYZVA1alpFSkkxVlI1RnJFR3ZJeERBR1hlbDM5SE9X?=
 =?utf-8?B?eHU1cmhRVHZ0Q0tUc2NoQVNTVUZnVURhNVhzOWdmY3FsUllhWE9HbklUc09U?=
 =?utf-8?B?S2FRZGZJcXNKM0NPN1dxTXhsNXViZ1BPN3RtV1pqYXM3L0N6SHBtZmpoSUhV?=
 =?utf-8?B?RVRZbmhrUnFtZkw4TENtSGcrU0FQeWIrMGRodzFuQ1hFS1lGd2pZMm1TYWl4?=
 =?utf-8?B?bjFWT2lWK2lKc2sxT1h1TDRqSDRFZ0xIV0tBOFVEU1VpSkdFSTR6aXphRklo?=
 =?utf-8?B?eUoxRWs3YlFpcSt5SUQvRlQrTk5DbHE3RHROQVBPRmNoSTFLUmxaVy9TVStY?=
 =?utf-8?B?aXlWdWRVaExGZ29HYlpLQS93aUhpRW5xVldtSnFJWnpUYzBrNWkvblhwN2pZ?=
 =?utf-8?B?WDFMNFVjaWV3KzJaWVdjdkhDZk1uejFLWHNXZmhudHc5dDc2NDIxRDNIWFU2?=
 =?utf-8?B?SXQwVjBlUkw2eUtwNzhFMi9GYlVZYmFUb2ptaXRrcHgxZEhNY0RWWDh4Uk1L?=
 =?utf-8?B?Q3BTOU5aYUFFMEpWRzY3aUc3VVJvSXVDekl6b1BBYjUweUN1WG1maE0vYS90?=
 =?utf-8?B?dFFzMWoxYjBXZGtOR0pjUkFMTUpVbzRtY3hNNGxvZHZlWTYxQStmSUUrckxR?=
 =?utf-8?B?VWYvZmpJN00wME1OdEYyRThwM1FDbHJhWHRlckxxWDhNMFpTYU04OEl0aEJa?=
 =?utf-8?B?K2xZeVNrd3B3a055MzY2U25KRklzNVJlVXB5RUVsVmQxVEhZUXpEZlVGUkd4?=
 =?utf-8?B?Q3Y3d1c5OTJLWS9KVFpRSFRYazRDM3JnOE5ia3YzTC9nd0MySllraUQyRkZh?=
 =?utf-8?B?OEMrWXBiMXFxODlyQ2RyK1BHYXdndm5zazdMY0NKQlhaWkRSTURaaFhEemxB?=
 =?utf-8?B?N1hENUVBRDliQkp3S1drcHJweUxUUkVzSXdkNGd5Z3ZBT1J1b0g0cnhSa3E0?=
 =?utf-8?B?L2xISG1tUDZlMjNRTUxDVmszRDJIc2FaVUxoejZBMGdQUE1HNXBPNmkrYWtE?=
 =?utf-8?B?M2ZURlhzNGM4N3J1ZTRoUDMvUzFjUkg2SXpXemJMVWtnSVJ2ODVrQTVrMFZZ?=
 =?utf-8?B?ckhIU3BTckVMK3VaaTQrTEZPL0V5NisxdjVOTVZHTGtrczhPQU84anNYZmpu?=
 =?utf-8?B?L3REUmNZcGw5eDJNNjFYTFhHb1liMGUzQTBISzJld3ZoanZGQlVleU1CK0s1?=
 =?utf-8?B?dFlZRHJJdjZ0RWEycU1na2pFZGVRTkE5c3VJOTlja2FxMmJmTjRueVlTbCth?=
 =?utf-8?B?NDlydHdiZVdCZ29WOTZ1Z3RuWHNtM2ZtcmFQdU9HbnMzZmxGbVFuK1FTZXlU?=
 =?utf-8?B?VkUxVW5vTzkvV3BrYlpBMDlPbmtKVW5sMDBMRnZwMTZtNURRZm5wL3Mwa2k5?=
 =?utf-8?B?azZtUWcwc2ZWWmhZcmV6WTdRc2pnOGlFZG5EbmlFTjM1U24rc0pBbDc3cWwz?=
 =?utf-8?B?TGI3U05vVURNa0p2OHN6RXJva2VQOFlYMWZONm12R2M1ZldzQzY4dStTOWxC?=
 =?utf-8?B?U0R1WndFYklMZjI1VCtiOEtZM1pQNHVUSHFsSlRWSSswRVdHTS8yRlk0WXUr?=
 =?utf-8?B?ZjBjS0JaTVNDYXNPV0J5TElZdDI4Unh1YkRqMFNhYk1Mbnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU94KzZwaFRxM2FKY3djS1lqQWZlTlk4SzNtU2RQY01GQWwwN0VGY29DZ0xx?=
 =?utf-8?B?WENoMlBMclpESFh0MTZsdHlaem5Dc01LQTczM3VoMGtJUzZrYk1TQmpWWEh2?=
 =?utf-8?B?cmRCQzlxZGZycTgwU2oxM2FEVTV5cjJucjc4SXJxMForbDRoQXRsZlBkQUti?=
 =?utf-8?B?ZGphV3FmNktodnUxcDBXSklOUEhRQjNnQ0hjS1lYZm1Scm5RaERQVnhSZ0VN?=
 =?utf-8?B?ZXhUR2RUZCtNV1gvZC8wdWRYUmNUWnFaWXZBSUNJc1hPTktYOTVYT0lySlda?=
 =?utf-8?B?WG1sOXF3UXZyTE5oQ0FkRHZjZ3RwNWo3aG5lbDFDVjUvTkNFYTF5OFN5QjVt?=
 =?utf-8?B?TFdVTVYycjFjTnM3QitlbVRvK0xkYmllTzBTRE93QTlrcWhEVmZVTDVVTysv?=
 =?utf-8?B?YnpCNWk5blRYaUJzaFAxSmRRZ0xVdFk0eU5YZnpoSnFQSnBmSjNaZi9zd1E3?=
 =?utf-8?B?cENCd0hHakxmeGNSM296ZFVpY1JGOGZiQlFPS0UwNmdjTkxaN3RpdjVQdyt3?=
 =?utf-8?B?MUZIbStLZTdQQ29CM3lHem5wd1ZzZ1NCZmtvQitsQlpvcmprM0srSjlIcTdT?=
 =?utf-8?B?ZXV4MzNRd0h5UkFTaUs4S3Uzc2RJNmRYYzBtcFB6ZmQ5TTFGZFpYSHk2dXdX?=
 =?utf-8?B?R1lzaVE4WG5nbVVsZ2FtZi92SXVUdE85VkNGSFdZM0VCemtqWHpPeS85UVpv?=
 =?utf-8?B?U3lvVVNjbnpqRWswUW5xOHY3TVR3MERvcWl5bE92V0JkenRnWmNxeGs3bWtv?=
 =?utf-8?B?aEJFRm5MZ1d2WUdFMW4rMnhNNHlORVE2TVhUZ0lBVWw1RnAxMUR5ZjJ5WnNs?=
 =?utf-8?B?b2I1YlVJRVZ6RG5wb3k0c1lhKzVES3BuZTZIQWtCeG5xZkNvN3NJdFZCZzdY?=
 =?utf-8?B?K3ZLbmtCUnBCOGtleFhzN0hYVzJpdEoxcmpRR2pmcURaRGRmSkg5TDZLc2Rj?=
 =?utf-8?B?eDNORVhUNmhPL29qaTRqN2M4RDI4SUs4VVNwZTQ2OTU4VFRzWHRJKzZCRGM0?=
 =?utf-8?B?RlhwVm1tSmY2N1R1MHA1WjVKVnlZYmtiNFZqWURNUXNZUWh6TkIwZXlMMnhR?=
 =?utf-8?B?dEc0Z3JsKythTWIzM0ZvQ2F6YnJkWjJadWwrM2k4VUF5VTBVS1lSY1luTHY2?=
 =?utf-8?B?QTJObzhyMnRUNUZnMkJQUzQ1L0tXNy8rYWJ2c2daTFpIVXBqempnWHVtQWg0?=
 =?utf-8?B?YWVIdjZaa3MzWjVPMEgxZnE1b1h4bFI3TkJYSnRJcVgvWkxLWmxPazRkR1dp?=
 =?utf-8?B?WXVoVUQxSVZMdysvK3pucTc4bEtxTEJBRXJRUWhJWWQvUmdVV3ZkcjdPbUdq?=
 =?utf-8?B?bDNyWnpsTDREYUFtRG8zUHFpK1JiUGY0MUJ5cGRnbmU3Z25Ha2tSbWZudlQ0?=
 =?utf-8?B?a2lNMVNhT3NLT0RKQ25CSEpoRzZudWpXcjFmcmprbHNyWStzdnNKaFFQWmdm?=
 =?utf-8?B?SVlKTUlJZDNmWkQvb0xXeUtLZW5sQkVtMTBVcXV5blBFbmNJRDAwT0wrN044?=
 =?utf-8?B?dHNhUzhPV2ZUNm9XY1lzOXUrUXVLZ3VhaEJTcTJkaUNSVTB1TjZDNjFjTGxB?=
 =?utf-8?B?aU1KUmpVU1QwTHdwSVVJRm92YkRFM1RaeklQa2liV2JtdTZ5OGoxM3ExeEpM?=
 =?utf-8?B?dko5Sk5HS1ZIZW1WS24xZ0tPUXJDalBRL2hZM0x0Q3lLUVp0VEtRSytUYWFo?=
 =?utf-8?B?M3JOY3RZWU1ZNy9sTG84akorUHVOV0tPNzJveHFUWUZWOHFwNm1BRTY3ZlBE?=
 =?utf-8?B?YzJaRVBucExlUjhRRkpZRzRsTmIwbndhM0x1UXAwYktoLzNvWmk1SXRhY0Yw?=
 =?utf-8?B?VXB3Z2Mxdmt2Y3NCZkVpVHhtaFhDTHdoUmlYNlpwSlQxdnkvSVozZ2FpVGtT?=
 =?utf-8?B?SGhYV2p4dDh3WW85Z1UzZXFIWHB1MThoV3JiQzhwTjZwTHExdDlIVit5anY1?=
 =?utf-8?B?NmJpNFVxcTd1QlhTclRkVVZSTXFCeTYvZDN1SE04QWhXS0ZzY1d3NWhta0o5?=
 =?utf-8?B?K29iNTdyTEhjVENldWJGU1dHK0lDMjVjL05xalRJZ2V0OVhyd1UrditUclI2?=
 =?utf-8?B?TDJIcWxOQkxYUHpMK3RkYm4yVWk0RDY5MEMvQ0ZUMU5qWk1HSFUxUWpERnh6?=
 =?utf-8?Q?RAKqGN/+2DKyDqWxEg7MXisDd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b49966f-da62-46c4-689b-08dca647f15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 10:05:10.1732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8b+3tq49mebtgYJiBPmQUAHvtSCyIXpSF2oN+M5uXR64OmAM2ukUfHiCbCSYVW2aOTxDt8R4+0nt8hRTCWAntuFKYd3NJY7UGexDhBjK5p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDA1LzEyXSB2
ZmlvL2lvbW11ZmQ6IEludHJvZHVjZSBhdXRvIGRvbWFpbg0KPmNyZWF0aW9uDQo+DQo+T24gMTcv
MDcvMjAyNCAwMzoxOCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0
aW5zQG9yYWNsZS5jb20+DQo+Pj4gU3ViamVjdDogW1BBVENIIHY0IDA1LzEyXSB2ZmlvL2lvbW11
ZmQ6IEludHJvZHVjZSBhdXRvIGRvbWFpbg0KPmNyZWF0aW9uDQo+Pj4NCj4+PiBUaGVyZSdzIGdl
bmVyYWxseSB0d28gbW9kZXMgb2Ygb3BlcmF0aW9uIGZvciBJT01NVUZEOg0KPj4+DQo+Pj4gKiBU
aGUgc2ltcGxlIHVzZXIgQVBJIHdoaWNoIGludGVuZHMgdG8gcGVyZm9ybSByZWxhdGl2ZWx5IHNp
bXBsZSB0aGluZ3MNCj4+PiB3aXRoIElPTU1VcyBlLmcuIERQREsuIEl0IGdlbmVyYWxseSBjcmVh
dGVzIGFuIElPQVMgYW5kIGF0dGFjaCB0byBWRklPDQo+Pj4gYW5kIG1haW5seSBwZXJmb3JtcyBJ
T0FTX01BUCBhbmQgVU5NQVAuDQo+Pj4NCj4+PiAqIFRoZSBuYXRpdmUgSU9NTVVGRCBBUEkgd2hl
cmUgeW91IGhhdmUgZmluZSBncmFpbmVkIGNvbnRyb2wgb2YgdGhlDQo+Pj4gSU9NTVUgZG9tYWlu
IGFuZCBtb2RlbCBpdCBhY2NvcmRpbmdseS4gVGhpcyBpcyB3aGVyZSBtb3N0IG5ldyBmZWF0dXJl
DQo+Pj4gYXJlIGJlaW5nIHN0ZWVyZWQgdG8uDQo+Pj4NCj4+PiBGb3IgZGlydHkgdHJhY2tpbmcg
MikgaXMgcmVxdWlyZWQsIGFzIGl0IG5lZWRzIHRvIGVuc3VyZSB0aGF0DQo+Pj4gdGhlIHN0YWdl
LTIvcGFyZW50IElPTU1VIGRvbWFpbiB3aWxsIG9ubHkgYXR0YWNoIGRldmljZXMNCj4+PiB0aGF0
IHN1cHBvcnQgZGlydHkgdHJhY2tpbmcgKHNvIGZhciBpdCBpcyBhbGwgaG9tb2dlbmVvdXMgaW4g
eDg2LCBsaWtlbHkNCj4+PiBub3QgdGhlIGNhc2UgZm9yIHNtbXV2MykuIFN1Y2ggaW52YXJpYW50
IG9uIGRpcnR5IHRyYWNraW5nIHByb3ZpZGVzIGENCj4+PiB1c2VmdWwgZ3VhcmFudGVlIHRvIFZN
TXMgdGhhdCB3aWxsIHJlZnVzZSBpbmNvbXBhdGlibGUgZGV2aWNlDQo+Pj4gYXR0YWNobWVudHMg
Zm9yIElPTU1VIGRvbWFpbnMuDQo+Pj4NCj4+PiBEaXJ0eSB0cmFja2luZyBpbnN1cmFuY2UgaXMg
ZW5mb3JjZWQgdmlhIEhXUFRfQUxMT0MsIHdoaWNoIGlzDQo+Pj4gcmVzcG9uc2libGUgZm9yIGNy
ZWF0aW5nIGFuIElPTU1VIGRvbWFpbi4gVGhpcyBpcyBjb250cmFzdCB0byB0aGUNCj4+PiAnc2lt
cGxlIEFQSScgd2hlcmUgdGhlIElPTU1VIGRvbWFpbiBpcyBjcmVhdGVkIGJ5IElPTU1VRkQNCj4+
PiBhdXRvbWF0aWNhbGx5DQo+Pj4gd2hlbiBpdCBhdHRhY2hlcyB0byBWRklPICh1c3VhbGx5IHJl
ZmVycmVkIGFzIGF1dG9kb21haW5zKSBidXQgaXQgaGFzDQo+Pj4gdGhlIG5lZWRlZCBoYW5kbGlu
ZyBmb3IgbWRldnMuDQo+Pj4NCj4+PiBUbyBzdXBwb3J0IGRpcnR5IHRyYWNraW5nIHdpdGggdGhl
IGFkdmFuY2VkIElPTU1VRkQgQVBJLCBpdCBuZWVkcw0KPj4+IHNpbWlsYXIgbG9naWMsIHdoZXJl
IElPTU1VIGRvbWFpbnMgYXJlIGNyZWF0ZWQgYW5kIGRldmljZXMgYXR0YWNoZWQgdG8NCj4+PiBj
b21wYXRpYmxlIGRvbWFpbnMuIEVzc2VudGlhbGx5IG1pbW1pY2luZyBrZXJuZWwNCj4+PiBpb21t
dWZkX2RldmljZV9hdXRvX2dldF9kb21haW4oKS4gV2l0aCBtZGV2cyBnaXZlbiB0aGVyZSdzIG5v
DQo+SU9NTVUNCj4+PiBkb21haW4NCj4+PiBpdCBmYWxscyBiYWNrIHRvIElPQVMgYXR0YWNoLg0K
Pj4+DQo+Pj4gVGhlIGF1dG8gZG9tYWluIGxvZ2ljIGFsbG93cyBkaWZmZXJlbnQgSU9NTVUgZG9t
YWlucyB0byBiZSBjcmVhdGVkDQo+d2hlbg0KPj4+IERNQSBkaXJ0eSB0cmFja2luZyBpcyBub3Qg
ZGVzaXJlZCAoYW5kIFZGIGNhbiBwcm92aWRlIGl0KSwgYW5kIG90aGVycw0KPndoZXJlDQo+Pj4g
aXQgaXMuIEhlcmUgaXMgbm90IHVzZWQgaW4gdGhpcyB3YXkgaGVyZSBnaXZlbiBob3cgVkZJT0Rl
dmljZSBtaWdyYXRpb24NCj4+PiBzdGF0ZSBpcyBpbml0aWFsaXplZCBhZnRlciB0aGUgZGV2aWNl
IGF0dGFjaG1lbnQuIEJ1dCBzdWNoIG1peGVkIG1vZGUgb2YNCj4+PiBJT01NVSBkaXJ0eSB0cmFj
a2luZyArIGRldmljZSBkaXJ0eSB0cmFja2luZyBpcyBhbiBpbXByb3ZlbWVudCB0aGF0IGNhbg0K
Pj4+IGJlIGFkZGVkIG9uLiBLZWVwIHRoZSAnYWxsIG9mIG5vdGhpbmcnIG9mIHR5cGUxIGFwcHJv
YWNoIHRoYXQgd2UgaGF2ZQ0KPj4+IGJlZW4gdXNpbmcgc28gZmFyIGJldHdlZW4gY29udGFpbmVy
IHZzIGRldmljZSBkaXJ0eSB0cmFja2luZy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEpvYW8g
TWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+PiAtLS0NCj4+PiBpbmNsdWRl
L2h3L3ZmaW8vdmZpby1jb21tb24uaCB8ICA5ICsrKysNCj4+PiBpbmNsdWRlL3N5c2VtdS9pb21t
dWZkLmggICAgICB8ICA1ICsrKw0KPj4+IGJhY2tlbmRzL2lvbW11ZmQuYyAgICAgICAgICAgIHwg
MzAgKysrKysrKysrKysrKw0KPj4+IGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAgICAgIHwgODIN
Cj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+IGJhY2tlbmRzL3Ry
YWNlLWV2ZW50cyAgICAgICAgIHwgIDEgKw0KPj4+IDUgZmlsZXMgY2hhbmdlZCwgMTI3IGluc2Vy
dGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21t
b24uaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPj4+IGNvbW1vbi5oDQo+Pj4gaW5kZXggNzQx
OTQ2NmJjYTkyLi4yZGQ0NjhjZTNjMDIgMTAwNjQ0DQo+Pj4gLS0tIGEvaW5jbHVkZS9ody92Zmlv
L3ZmaW8tY29tbW9uLmgNCj4+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0K
Pj4+IEBAIC05NSwxMCArOTUsMTcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0hvc3RETUFXaW5kb3cg
ew0KPj4+DQo+Pj4gdHlwZWRlZiBzdHJ1Y3QgSU9NTVVGREJhY2tlbmQgSU9NTVVGREJhY2tlbmQ7
DQo+Pj4NCj4+PiArdHlwZWRlZiBzdHJ1Y3QgVkZJT0lPQVNId3B0IHsNCj4+PiArICAgIHVpbnQz
Ml90IGh3cHRfaWQ7DQo+Pj4gKyAgICBRTElTVF9IRUFEKCwgVkZJT0RldmljZSkgZGV2aWNlX2xp
c3Q7DQo+Pj4gKyAgICBRTElTVF9FTlRSWShWRklPSU9BU0h3cHQpIG5leHQ7DQo+Pj4gK30gVkZJ
T0lPQVNId3B0Ow0KPj4+ICsNCj4+PiB0eXBlZGVmIHN0cnVjdCBWRklPSU9NTVVGRENvbnRhaW5l
ciB7DQo+Pj4gICAgIFZGSU9Db250YWluZXJCYXNlIGJjb250YWluZXI7DQo+Pj4gICAgIElPTU1V
RkRCYWNrZW5kICpiZTsNCj4+PiAgICAgdWludDMyX3QgaW9hc19pZDsNCj4+PiArICAgIFFMSVNU
X0hFQUQoLCBWRklPSU9BU0h3cHQpIGh3cHRfbGlzdDsNCj4+PiB9IFZGSU9JT01NVUZEQ29udGFp
bmVyOw0KPj4+DQo+Pj4gT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoVkZJT0lPTU1VRkRDb250
YWluZXIsDQo+Pj4gVkZJT19JT01NVV9JT01NVUZEKTsNCj4+PiBAQCAtMTM1LDYgKzE0Miw4IEBA
IHR5cGVkZWYgc3RydWN0IFZGSU9EZXZpY2Ugew0KPj4+ICAgICBIb3N0SU9NTVVEZXZpY2UgKmhp
b2Q7DQo+Pj4gICAgIGludCBkZXZpZDsNCj4+PiAgICAgSU9NTVVGREJhY2tlbmQgKmlvbW11ZmQ7
DQo+Pj4gKyAgICBWRklPSU9BU0h3cHQgKmh3cHQ7DQo+Pj4gKyAgICBRTElTVF9FTlRSWShWRklP
RGV2aWNlKSBod3B0X25leHQ7DQo+Pj4gfSBWRklPRGV2aWNlOw0KPj4+DQo+Pj4gc3RydWN0IFZG
SU9EZXZpY2VPcHMgew0KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgg
Yi9pbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4+PiBpbmRleCA1N2Q1MDJhMWM3OWEuLmU5MTdl
NzU5MWQwNSAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4+PiAr
KysgYi9pbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4+PiBAQCAtNTAsNiArNTAsMTEgQEAgaW50
DQo+Pj4gaW9tbXVmZF9iYWNrZW5kX3VubWFwX2RtYShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQz
Ml90DQo+aW9hc19pZCwNCj4+PiBib29sIGlvbW11ZmRfYmFja2VuZF9nZXRfZGV2aWNlX2luZm8o
SU9NTVVGREJhY2tlbmQgKmJlLA0KPnVpbnQzMl90DQo+Pj4gZGV2aWQsDQo+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICp0eXBlLCB2b2lkICpkYXRhLCB1
aW50MzJfdCBsZW4sDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQ2NF90ICpjYXBzLCBFcnJvciAqKmVycnApOw0KPj4+ICtib29sIGlvbW11ZmRfYmFja2VuZF9h
bGxvY19od3B0KElPTU1VRkRCYWNrZW5kICpiZSwgdWludDMyX3QNCj4+PiBkZXZfaWQsDQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcHRfaWQsIHVpbnQzMl90
IGZsYWdzLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGRh
dGFfdHlwZSwgdWludDMyX3QgZGF0YV9sZW4sDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdm9pZCAqZGF0YV9wdHIsIHVpbnQzMl90ICpvdXRfaHdwdCwNCj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4+DQo+Pj4gI2RlZmlu
ZSBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQNCj4+PiBUWVBFX0hPU1RfSU9NTVVfREVW
SUNFICItaW9tbXVmZCINCj4+PiAjZW5kaWYNCj4+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaW9t
bXVmZC5jIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+Pj4gaW5kZXggMmIzZDUxYWYyNmQyLi41ZDNk
ZmE5MTc0MTUgMTAwNjQ0DQo+Pj4gLS0tIGEvYmFja2VuZHMvaW9tbXVmZC5jDQo+Pj4gKysrIGIv
YmFja2VuZHMvaW9tbXVmZC5jDQo+Pj4gQEAgLTIwOCw2ICsyMDgsMzYgQEAgaW50DQo+Pj4gaW9t
bXVmZF9iYWNrZW5kX3VubWFwX2RtYShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90DQo+aW9h
c19pZCwNCj4+PiAgICAgcmV0dXJuIHJldDsNCj4+PiB9DQo+Pj4NCj4+PiArYm9vbCBpb21tdWZk
X2JhY2tlbmRfYWxsb2NfaHdwdChJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90DQo+Pj4gZGV2
X2lkLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHB0X2lk
LCB1aW50MzJfdCBmbGFncywNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCBkYXRhX3R5cGUsIHVpbnQzMl90IGRhdGFfbGVuLA0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZvaWQgKmRhdGFfcHRyLCB1aW50MzJfdCAqb3V0X2h3cHQsDQo+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4+ICt7
DQo+Pj4gKyAgICBpbnQgcmV0LCBmZCA9IGJlLT5mZDsNCj4+PiArICAgIHN0cnVjdCBpb21tdV9o
d3B0X2FsbG9jIGFsbG9jX2h3cHQgPSB7DQo+Pj4gKyAgICAgICAgLnNpemUgPSBzaXplb2Yoc3Ry
dWN0IGlvbW11X2h3cHRfYWxsb2MpLA0KPj4+ICsgICAgICAgIC5mbGFncyA9IGZsYWdzLA0KPj4+
ICsgICAgICAgIC5kZXZfaWQgPSBkZXZfaWQsDQo+Pj4gKyAgICAgICAgLnB0X2lkID0gcHRfaWQs
DQo+Pj4gKyAgICAgICAgLmRhdGFfdHlwZSA9IGRhdGFfdHlwZSwNCj4+PiArICAgICAgICAuZGF0
YV9sZW4gPSBkYXRhX2xlbiwNCj4+PiArICAgICAgICAuZGF0YV91cHRyID0gKHVpbnQ2NF90KWRh
dGFfcHRyLA0KPj4+ICsgICAgfTsNCj4+PiArDQo+Pj4gKyAgICByZXQgPSBpb2N0bChmZCwgSU9N
TVVfSFdQVF9BTExPQywgJmFsbG9jX2h3cHQpOw0KPj4+ICsgICAgdHJhY2VfaW9tbXVmZF9iYWNr
ZW5kX2FsbG9jX2h3cHQoZmQsIGRldl9pZCwgcHRfaWQsIGZsYWdzLA0KPmRhdGFfdHlwZSwNCj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFfbGVuLCAodWludDY0
X3QpZGF0YV9wdHIsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBh
bGxvY19od3B0Lm91dF9od3B0X2lkLCByZXQpOw0KPj4+ICsgICAgaWYgKHJldCkgew0KPj4+ICsg
ICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJGYWlsZWQgdG8gYWxsb2NhdGUg
aHdwdCIpOw0KPj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+PiArICAgIH0NCj4+PiArDQo+
Pj4gKyAgICAqb3V0X2h3cHQgPSBhbGxvY19od3B0Lm91dF9od3B0X2lkOw0KPj4+ICsgICAgcmV0
dXJuIHRydWU7DQo+Pj4gK30NCj4+PiArDQo+Pj4gYm9vbCBpb21tdWZkX2JhY2tlbmRfZ2V0X2Rl
dmljZV9pbmZvKElPTU1VRkRCYWNrZW5kICpiZSwNCj51aW50MzJfdA0KPj4+IGRldmlkLA0KPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqdHlwZSwgdm9p
ZCAqZGF0YSwgdWludDMyX3QgbGVuLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50NjRfdCAqY2FwcywgRXJyb3IgKiplcnJwKQ0KPj4+IGRpZmYgLS1naXQgYS9o
dy92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4gaW5kZXggMDc3ZGVhOGYx
YjY0Li4zMjVjNzU5OGQ1YTEgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCj4+
PiArKysgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4+IEBAIC0yMTIsMTAgKzIxMiw4NiBAQCBzdGF0
aWMgYm9vbA0KPj4+IGlvbW11ZmRfY2Rldl9kZXRhY2hfaW9hc19od3B0KFZGSU9EZXZpY2UgKnZi
YXNlZGV2LCBFcnJvciAqKmVycnApDQo+Pj4gICAgIHJldHVybiB0cnVlOw0KPj4+IH0NCj4+Pg0K
Pj4+ICtzdGF0aWMgYm9vbCBpb21tdWZkX2NkZXZfYXV0b2RvbWFpbnNfZ2V0KFZGSU9EZXZpY2Ug
KnZiYXNlZGV2LA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFZGSU9JT01NVUZEQ29udGFpbmVyICpjb250YWluZXIsDQo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4+ICt7DQo+Pj4gKyAgICBJ
T01NVUZEQmFja2VuZCAqaW9tbXVmZCA9IHZiYXNlZGV2LT5pb21tdWZkOw0KPj4+ICsgICAgdWlu
dDMyX3QgZmxhZ3MgPSAwOw0KPj4+ICsgICAgVkZJT0lPQVNId3B0ICpod3B0Ow0KPj4+ICsgICAg
dWludDMyX3QgaHdwdF9pZDsNCj4+PiArICAgIGludCByZXQ7DQo+Pj4gKw0KPj4+ICsgICAgLyog
VHJ5IHRvIGZpbmQgYSBkb21haW4gKi8NCj4+PiArICAgIFFMSVNUX0ZPUkVBQ0goaHdwdCwgJmNv
bnRhaW5lci0+aHdwdF9saXN0LCBuZXh0KSB7DQo+Pj4gKyAgICAgICAgcmV0ID0gaW9tbXVmZF9j
ZGV2X2F0dGFjaF9pb2FzX2h3cHQodmJhc2VkZXYsIGh3cHQtPmh3cHRfaWQsDQo+Pj4gZXJycCk7
DQo+Pg0KPj4gSWYgdGhlcmUgaXMgYWxyZWFkeSBhbiBod3B0IHRoYXQgc3VwcG9ydHMgZGlydHkg
dHJhY2tpbmcuDQo+PiBBbm90aGVyIGRldmljZSB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCBkaXJ0eSB0
cmFja2luZyBhdHRhY2hlcyB0byB0aGlzIGh3cHQsDQo+d2lsbCBpdCBzdWNjZWVkPw0KPj4NCj4N
Cj5JdCByZXR1cm5zIC1FSU5WQUwsIGFuZCB3ZSBoYW5kbGUgdGhhdCByaWdodCBhZnRlciB0aGlz
IHN0YXRlbWVudC4gV2hpY2gNCj5tZWFucw0KPmFub3RoZXIgSFdQVCBpcyBjcmVhdGVkLg0KDQpM
b29rZWQgaW50byBrZXJuZWwgY29kZSwgSSBkaWRuJ3Qgc2VlIHRoZSBjaGVjayBhYm91dCBkaXJ0
eSB0cmFja2luZyBiZXR3ZWVuIGRldmljZSBhbmQgaHdwdCwgZG8geW91IGtub3cgd2hpY2ggZnVu
YyBkb2VzIHRoYXQ/DQoNCj4NCj4+IElmIGV4aXN0aW5nIGh3cHQgZG9lc24ndCBzdXBwb3J0IGRp
cnR5IHRyYWNraW5nLg0KPj4gQW5vdGhlciBkZXZpY2Ugc3VwcG9ydGluZyBkaXJ0eSB0cmFja2lu
ZyBhdHRhY2hlcyB0byB0aGF0IGh3cHQsIHdoYXQgd2lsbA0KPmhhcHBlbj8NCj4+DQo+DQo+SG1t
LCBJdCBzdWNjZWVkcyBhcyB0aGVyZSdzIG5vIGluY29tcGF0YmlsaXR5LiBBdCB0aGUgdmVyeSBs
ZWFzdCBJIHBsYW4gb24NCj5ibG9ja2luZyBtaWdyYXRpb24gaWYgdGhlIGRldmljZSBuZWl0aGVy
IGhhcyBWRiBkaXJ0eSB0cmFja2luZywgbm9yIElPTU1VDQo+ZGlydHkNCj50cmFja2luZyAoYW5k
IHBhdGNoIDExIG5lZWRzIHRvIGJlIGFkanVzdGVkIHRvIGNoZWNrIGh3cHRfZmxhZ3MgaW5zdGVh
ZCBvZg0KPmNvbnRhaW5lcikuDQoNCldoZW4gYmNvbnRhaW5lci0+ZGlydHlfcGFnZXNfc3VwcG9y
dGVkIGlzIHRydWUsIEkgdGhpbmsgdGhhdCBjb250YWluZXIgc2hvdWxkIG9ubHkgY29udGFpbnMg
aHdwdCBsaXN0IHRoYXQgc3VwcG9ydCBkaXJ0eSB0cmFja2luZy4gQWxsIGh3cHQgbm90IHN1cHBv
cnRpbmcgZGlydHkgdHJhY2tpbmcgc2hvdWxkIGJlIGluIG90aGVyIGNvbnRhaW5lci4NCg0KSWYg
ZGV2aWNlIHN1cHBvcnRzIGRpcnR5IHRyYWNraW5nLCBpdCBzaG91bGQgYnlwYXNzIGF0dGFjaGlu
ZyBjb250YWluZXIgdGhhdCBkb2Vzbid0IHN1cHBvcnQgZGlydHkgdHJhY2tpbmcuIFZpc2UgdmVy
c2EuDQpUaGlzIHdheSB3ZSBjYW4gc3VwcG9ydCB0aGUgbWl4aW5nIGVudmlyb25tZW50Lg0KDQpU
aGFua3MNClpoZW56aG9uZyANCg0KPg0KPlFlbXUgcmlnaHQgbm93IGRvZXNuJ3QgaGFuZGxlIGhl
dGVyZWdlbm91cyBlbnZpcm9ubWVudCwgaXQncyBhbGwgb2YNCj5ub3RoaW5nDQo+YXBwcm9hY2gg
ZXZlbiBiZWZvcmUgdGhpcyBwYXRjaHNldC4gQWRkaXRpb25hbGx5LCBJIGFtIG5vdCBzdXJlIHNl
cnZlcg0KPmVudmlyb25tZW50cyBhcmUgYXBwbGljYWJsZSBoZXJlLiBTbyBlc3NlbnRpYWxseSBJ
IGtlcHQgdGhlIHN0YXR1cyBxdW8gLS0NCj5tb3JlDQo+Zm9sbG93LXVwIGlzIG5lZWRlZCB0byBz
dXBwb3J0IGEgbWl4IGFuZCBtYXRjaCBvZiBJT01NVSArIFZGIGRpcnR5DQo+dHJhY2tpbmcgdG9v
Lg0KPlRoZSBjaGFsbGVuZ2UgaXMgaGF2aW5nIHRoZSBtaWdyYXRpb24gc3RhdGUgb2YgVkZJTyBk
ZXZpY2UgaW5pdGlhbGl6ZWQgZWFybHkNCj5lbm91Z2ggdGhhdCB3ZSBjYW4gbWFrZSBhbGwgc29y
dCBvZiBkZWNpc2lvbnMgd2hldGhlciBJT01NVSBkaXJ0eSB0cmFja2luZw0KPmlzDQo+ZGVzaXJl
ZCBvbiBhIHBlci1kZXZpY2UgYmFzaXMuDQo=

