Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD87CCD183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 02:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8UpX-0002CN-Nl; Mon, 13 Oct 2025 22:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8UpV-0002C5-UM
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 22:32:01 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8UpR-0006ph-UT
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 22:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760409118; x=1791945118;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qQ0temD4uzvxVEAQRDveJKFKdByy6DVfZL0gWKCHtBw=;
 b=jiRTn4l7bsbMT9ujAk0HNQlVdEUS6pTyKRXuNwEw5gumTio4jiqLInWz
 9IJChEOfyCDcZCgq3vcQkCi6zCrk/Qzr1m7GiWdxBlRkXSJBcvEumu+MP
 5DwreCoFWlZXsR+qwrzZOjm4ff4ZWYfNxTFQE2kYSQl/BDZ/B1M00zH6u
 y3gk7IZi6hJMt8EjvmIHyn6d0h4BmnYGQov60ryTFdFXB3K4eEgBd1Nt1
 hIEuqk9BPpH6dtHznX/FSleUhEacx2J2ff4qAJxd0yMgP7NcdZSIhfTij
 XanjUCCLWK8mqM5LtFJArdun+3qIbYmDpd4dVxSFovgi4SLreMJ3RHHpU Q==;
X-CSE-ConnectionGUID: Zz6tkNSNQA2pZYHDAcmyNA==
X-CSE-MsgGUID: vSnj7XODT2GOJdESkVhktw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62598639"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; d="scan'208";a="62598639"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 19:31:54 -0700
X-CSE-ConnectionGUID: dpAF05CLSmiwgF2Q15PTcA==
X-CSE-MsgGUID: 4ZnwnjDwRHqf9mu3yD7BaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; d="scan'208";a="182217089"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 19:31:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 19:31:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 19:31:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 19:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX3U+K0VskRYrMcIrS+pZMDeU8V2yyjNpkgw4Uvm/oCGVHkdXax/PsvX9lKoZlf+UR5jZNUhBUq7eElHNxdyTAv96OZseS3TZ3mmE6FYEVnE7UYJTNP4628piCNVzVpiOXu5UGyYasE6PXJtnPnZ78++ZrtEuaASPGhalIO4fFsveVyfHhaBbzxYqS31B3Yocxgw77RDDkJMCqHHI9L3mfbRpuXbBYjfA8lY5vSfkuqg4UpOkweYXj/0EqwJJ5QMy+WeYfHM4DQeWbJpE1sPZKjL8uBL1Ig4Lta6qIyZEexlEjOogKaARyG9L18RHLQVkZUx71PM9Vf3iIcpMrADZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ0temD4uzvxVEAQRDveJKFKdByy6DVfZL0gWKCHtBw=;
 b=liGCjqBwak6k+3/GFFB0zIM3GYsNgpTkLv5X3rvof4TzQnmunCPI+X2swXXw6yjAhga+oX+/O/ctShvCaZmQBk/NqMbz+8qCbxpqWwALQBH6nHeBT6fj7/HYggCvmiRXLChY+pMAncahRMRMy2TrxtaJ0tPXV7rKnJiLsBkPyW8wH080Dq7aX1F2l3gTHDZK1F/DZRP7ExykkNVwr8fW4SRrOgSeS6R5YpyEc430nhYTe5yCko51DOgAApB7RDYGkVu9YCjHskZj123vRSuz5dT5H6OZbD88aK/iHQEMV7cWLm43xpISe5oOpU/wE7+U2q0/LgYEkdxcHMf6vaG4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 14 Oct
 2025 02:31:49 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 02:31:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Thread-Topic: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Thread-Index: AQHcIfvpBR8EG6fncUCmXH17xc4ayLS+gq4AgAEL66CAAK7kAIAA3gSg
Date: Tue, 14 Oct 2025 02:31:49 +0000
Message-ID: <IA3PR11MB913676B74FF4A6B74F4959D992EBA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-5-zhenzhong.duan@intel.com>
 <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
 <DS4PPF93A1BBECD1A86879EBF071C6D09D792EAA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <74930e82-62f7-4b4e-8bdc-217142586dd3@intel.com>
In-Reply-To: <74930e82-62f7-4b4e-8bdc-217142586dd3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BN9PR11MB5323:EE_
x-ms-office365-filtering-correlation-id: 5ab55b57-f34d-4adf-33db-08de0ac9d435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cWs4VDhtRnFZY2dkcStza0dMMHZTaVJObUxhLzRVYnVPNU8vK2JuNjhyUlIr?=
 =?utf-8?B?S1VkVHp1QXFkcVUvaEE1Q0hqU09qSE9Lb2tiQVArRDJaTEsveUJ2K09USXcw?=
 =?utf-8?B?MjdYczBYMkZuRkEyZVJwcDU3WVRrS1RGY2RwMHg2YTBmTmJMRmg0RjBpTEdW?=
 =?utf-8?B?QkE0dTZ4cHpBTUlUQlRFUUwrQ3J2M25QYy9zRHd6ZXVDOVh6c0FoTkJVbkVI?=
 =?utf-8?B?U0hrclhOVUk2U2VYNHZ5UnE0YzZqcHAyZzd2dHYxcEhkQUdqUkdCRG9idVow?=
 =?utf-8?B?VU1HV3FLNTZzLzB6VnhTQXZ3WGxxM2NrVHI1NWxiYzNUYkdiVWxCUzcxMDU0?=
 =?utf-8?B?QjdTZEluc3g2WVlPS1YwZlFmcTcyWlZSTnVpZVo4Z3lKZE4zNGlJeTRTUFdG?=
 =?utf-8?B?bUFlSDk5YVU1d2U2WURYMWp3Y1A4RXJEbTJPcnhRQnlkSVkrNyt6UFZZRDh2?=
 =?utf-8?B?Vk9uc0s3cjRVaEJ6bzZ1SHZhSUp3bVBZcTBiQ3l3Zm9QRU1DM2VoMmFOQ0RT?=
 =?utf-8?B?a0V2Uk1KVFY2SDRKNWpMTVhxcmdGNHRNaE9pblZ5ZDBnT1VvMkw5Z284NjlR?=
 =?utf-8?B?bVhSN21YZHpvSGFjRFFXWkl2MGkzTUd1MkU5TkEvYkZ2ZGpxMDBYV0dDdzY5?=
 =?utf-8?B?QXRVNEhqRnA4TFZIbWh2cmRidUp1M1gvZFpoYUNVWlVybWZOMmlTd3lLQmQ4?=
 =?utf-8?B?RVhVMElpcnlubS84RFgzTXduY0M5NTRYNHIzSktnL3BMRkI2d0hHY2s0NEdz?=
 =?utf-8?B?dVMzU0tDZkpHRHF1elcyRUxiU3M2RWk1N0dTV2NzeGQ4bThKamJacER0Tisx?=
 =?utf-8?B?a0RpUVR4TE1VaGdYTW90UVRqWmNVMU02dzhGdFExNEV1OUU5R2V1ZzVZeTFV?=
 =?utf-8?B?czg4SUc4TExoTEN0ME9kRGJIdEc4czQ3cDd0S2JmemtZVHFHeGQvY3VubnJH?=
 =?utf-8?B?YjhVUW83c3VFa0VwbGladThMd0VyaG42c3FxSCtHb0ZzK0FGR3huSGVzS1g5?=
 =?utf-8?B?SHkzQ0pLT2tDamEwMi9nUVN0Nm9hTkxYcUtZQU1xOUpkeEI1aGFWa3Fyeksz?=
 =?utf-8?B?VURtTkZWa3dhMEgwUmcvSkpiTFQwK0krbXZZZk9Wc2J0S2swWi9ITENhb2w1?=
 =?utf-8?B?VG1wY0tvUy9xZUZxM3FoRnFSSVFCc2s5UkxyZXA2OVY0QUJiRnRuL3NkKzh0?=
 =?utf-8?B?QkJvSXFJd01aMHJjYjVzdWJJeGdjZjhUaDZTWTBBNGpENmx3WVB6UXYxaVd3?=
 =?utf-8?B?UVRoLytmQ1ovaStxMzFpanVmR042SzNrMmlaekQxUHBLeFRKVlQ2R3dQUmpw?=
 =?utf-8?B?eXovZ2xYeFRZditCWWZxYU9DNHV4VjFWN0NsMnppaTEvb0FGRnhVOGkzUFJL?=
 =?utf-8?B?b1RtaXhzRjUvVzlJdTRjN01jUmZUK3dYdjFZVG1ad0ttditBMDJVaFZwdjZ0?=
 =?utf-8?B?S3BIYWpPSnZTQWVEYWdvWkNhZVM3TlV1MUxLbjNmck9EYUxhSFBteENzTFF6?=
 =?utf-8?B?RXJSdGNid05EZUZwbURlV1QzR0FwVSs1aCt3MWNRTlN5em5DRm9tRVkxN0VS?=
 =?utf-8?B?VVBIc2RRMFQ0cWRYNWFXWmhHNjk2NUozOGNxUnY4cUJZTGRGT3l0eHlGYkYz?=
 =?utf-8?B?K09UODdIR3NzZEhpYVF0OWhOMUQ5QWNKWVplRmkydFBmZjJhcmNOT2pwY3Rr?=
 =?utf-8?B?R2c4REtIdVhoM2lleGwwQzJlMDRjQUxybUFwMGE3dHoyS1VIZC9ZT0ROTVF2?=
 =?utf-8?B?Y29idDE0dk92TjhBWTF0bGdzVHh0SW16c3VlT0xraWwzRGtIdVNsb1MwYTJx?=
 =?utf-8?B?YXZRVTZYQzNrbGNUdUg1TlpwSFBGSE1UYWZrVG1YVlpJbTJTWWFHUFBXbjRx?=
 =?utf-8?B?d0JET0hYMVN4bHgwRzFCN3pSbzgyQ3lvUlV3ZG9JNUVVM2pKTkpIWkxxUWZk?=
 =?utf-8?B?NTFPd3BhNmpQc2grZkp3ZThnazQwbzlMR0dDeDhvSFBWYzNaZS9xcG9na0pV?=
 =?utf-8?B?MFhqMzFiMXVwWWhKc2NYZ2lZcmUxQ0pCZEc5bW56Z1I1UDFhZ051R0dCSTVp?=
 =?utf-8?Q?FHic72?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkxDOUVNdC9seUg3c25kSklGaXZRaHExMGVnUWN0REtuaW51WVdBMUgzdGZP?=
 =?utf-8?B?L1N0Qms2aW5yRUdZTGlMUWgyVDhUNFRvaGpmV0I4Y1pMWTZSdkpXc0NkYWJX?=
 =?utf-8?B?aHlLaUFqWm5NQ2l5ejVhS3NxUWNoNWVCRVRPdXc5TmtqWEVQa1dWU2xEWE9L?=
 =?utf-8?B?OWZxNnRLbnBTdWMxN1E5a1hsT1pwUkdqMjVMZTJxeUJBTjUrRk8yVjd6ejBk?=
 =?utf-8?B?ZG04emlvNkNMSW9FaURtZnRQMEU3RFMxTDBCa29qRXZLWkg1azkrdkdkSTVz?=
 =?utf-8?B?QmY4NVJvTG9rZkhCSm9KTlFneG9lem03aC9iSGZaYzJzbm1sL0xNWFZkamo2?=
 =?utf-8?B?KzBZb0lLTjVuSGQxejQwT3BNRnlKY2JHTVlwNjhLSmo3bkJ1RExoUzZjRE1S?=
 =?utf-8?B?VVlRbVYyZ3VFS2lNQWZqbXNleXJOSjloVEpSMzgxSkZBK2dpTlB2S1B5dVR0?=
 =?utf-8?B?MTZTNXZoa3grVGNNd3dNbW4xbmpnRDkweVVoc3U2TzMzcmVHeTdqbUdFUVFi?=
 =?utf-8?B?SFJteW41V0ZXUDJaeGF5cXZnbUxuNlpxdG4wUVB4WVZKUlZ0OGN5d1F5YUVB?=
 =?utf-8?B?SFp5MmFwaUI0TUMxT3ZhQ0dlYXc1ZW9ZWWJldTJXZkZiTmgwT1FqSTNMaVhH?=
 =?utf-8?B?SitSbTZEdThqVmF2RUF6aFhRVG42WnpqbWxLMmI3QllnMmQyMXltbU92UkJF?=
 =?utf-8?B?Y1FCalEwcTRZQUJ2UE1UMWNRMWxJdjhXNnVpNFNXWUx3c3A0UGsrT0psclpl?=
 =?utf-8?B?RzNYYThVRFF1MFFFai9RaktVbC94NU4zckFKejc0Y0hINjRvdEJGcXpDcVdk?=
 =?utf-8?B?QThybW1ZU05UeGZSQ3V4NkVrNXkrTUhML09oNEpsS3FVc3dzWWtDejNvTzRx?=
 =?utf-8?B?SUNNa0VTTm91L3BHRU1tVU5KYkcvNkkzTWR2ZDNGMDM1V0taZXkxU2IzY3kw?=
 =?utf-8?B?SkdTVDJXUXZUQWNMdklKSHVqRTVPUEtneGRYZWo2MkxrYmlhRk1VUkRYNldG?=
 =?utf-8?B?L2VtS3dITldiNTlmUnZSOVhwb3FFdHAzZkMrUUQxMTZ6U0ZRdlZCN2xWeU5W?=
 =?utf-8?B?bWRKajZxRTNFdEV3V2pwMkt6Y1JwYWpqY2ZHd2JQbDVPSkc0T05ZYjNWYkJz?=
 =?utf-8?B?Qm9VYllNVDRJUk8wVjl1QUNTTnhlaFVrWm9DY2xab3pWYWFqa1p1c1M3c01l?=
 =?utf-8?B?WC82VHgycnZ0U2ovbjBoRnV4cUwreHVNaWEzcmpjekhkaFRkalpTRHdBc0wx?=
 =?utf-8?B?Y2NxcEs1TWlKQStudTZBemJBaDVoNzVVTmU4M2ZZM2MyTDVDaFB4TTkwN3V3?=
 =?utf-8?B?eVlaZThheXdpUUZwbzhtamgwRXNkQ3RlRUJ0bDFEOXdTMkxiOTBGVjJWVENk?=
 =?utf-8?B?cXpOZDFJWWxNZjRwMVJBTFBrbGE2M0MrVnBSTlU4dnFGMCtDWTkrejVJOG43?=
 =?utf-8?B?bTVudGRFc29yaWJVQU1iNzB1ODRWallqU0VHRUpGam1OZFhhNTJUbTVLNGRN?=
 =?utf-8?B?aVlXQW4vMzIvd3dkZTlJamtLeGZrWjJNb0VDZnpSS2o0dWQ3dGc1Ymw5UzFW?=
 =?utf-8?B?Yk5hODAzUUxIUi9hRXVQdXcxL0NPUkt2WVEwUHI3VDFTSFB0OHB4UGlxNGJ6?=
 =?utf-8?B?ZXJ1WU9aNzlpSzlON0Eyck1VaHdMOGRtUU1lNWNVRTJURUdzMkxweGttQ0VM?=
 =?utf-8?B?OUVpeG5QNXBHUUI2UEdWTndDajhWdktrMGtPVUUvRkwwNjZTWlY4STJKSTUx?=
 =?utf-8?B?V1JEd2dBRTRzeElwZkhTSGI0dEE0aE9VSmxQVEJNeEQ2Rjc3dlJYQnIxTDdJ?=
 =?utf-8?B?RDhEYnE3UEJlRUd3Y3NjV1RMcnNwUHl4ME9tNytEUzVYamRtSHo2a0FWQ2Z3?=
 =?utf-8?B?M2FOcitiMldudHhvR1VZUXVaV0JCRXV6LzhBWjlLTCs0ZGwvQWVrUHdGbysz?=
 =?utf-8?B?eDFzRmdWbnd3U1RqMU0xekQ4ZVVGYnVpU0FZZTlyUjNxbndTSUpKc3VPZThy?=
 =?utf-8?B?Tldyam5xdHhIb3FabnJnOFBubHhzWmxzbHJYZU04NzVkVGtKY1IzSWF0NE5u?=
 =?utf-8?B?cWp6cjhKR1VrQ1g0aExacWlPdFdDKzZPRTlVQmpPVlh6YUQ2K0tuODU4ZlhW?=
 =?utf-8?Q?JsQsQ2tiFOGOabKuFVai+uL9+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab55b57-f34d-4adf-33db-08de0ac9d435
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 02:31:49.7848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FRaZeOHMLgIkUITm7OAk3tVK791Y8FUt8Jy+P7kqMjeq/qwDau13Jfo1ofVJYME4ZE0r/iBoRXUhV36uTvtGEhpora4dMCPP9O4qviUPdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggNC81XSBpbnRlbF9pb21tdTogT3B0
aW1pemUgdW5tYXBfYml0bWFwIGR1cmluZw0KPm1pZ3JhdGlvbg0KPg0KPk9uIDIwMjUvMTAvMTMg
MTA6NTAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzVdIGludGVsX2lvbW11OiBPcHRpbWl6ZSB1bm1hcF9i
aXRtYXAgZHVyaW5nDQo+Pj4gbWlncmF0aW9uDQo+Pj4NCj4+PiBPbiAyMDI1LzkvMTAgMTA6Mzcs
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+PiBJZiBhIFZGSU8gZGV2aWNlIGluIGd1ZXN0IHN3
aXRjaGVzIGZyb20gSU9NTVUgZG9tYWluIHRvIGJsb2NrIGRvbWFpbiwNCj4+Pj4gdnRkX2FkZHJl
c3Nfc3BhY2VfdW5tYXAoKSBpcyBjYWxsZWQgdG8gdW5tYXAgd2hvbGUgYWRkcmVzcyBzcGFjZS4N
Cj4+Pj4NCj4+Pj4gSWYgdGhhdCBoYXBwZW5zIGR1cmluZyBtaWdyYXRpb24sIG1pZ3JhdGlvbiBm
YWlscyB3aXRoIGxlZ2FjeSBWRklPDQo+Pj4+IGJhY2tlbmQgYXMgYmVsb3c6DQo+Pj4+DQo+Pj4+
IFN0YXR1czogZmFpbGVkICh2ZmlvX2NvbnRhaW5lcl9kbWFfdW5tYXAoMHg1NjFiYmJkOTJkOTAs
DQo+Pj4gMHgxMDAwMDAwMDAwMDAsIDB4MTAwMDAwMDAwMDAwKSA9IC03IChBcmd1bWVudCBsaXN0
IHRvbyBsb25nKSkNCj4+Pg0KPj4+IHRoaXMgc2hvdWxkIGJlIGEgZ2lhbnQgYW5kIGJ1c3kgVk0u
IHJpZ2h0PyBJcyBhIGZpeCB0YWcgbmVlZGVkIGJ5IHRoZSB3YXk/DQo+Pg0KPj4gVk0gc2l6ZSBp
cyB1bnJlbGF0ZWQsIGl0J3Mgbm90IGEgYnVnLCBqdXN0IGN1cnJlbnQgY29kZSBkb2Vzbid0IHdv
cmsgd2VsbCB3aXRoDQo+bWlncmF0aW9uLg0KPj4NCj4+IFdoZW4gZGV2aWNlIHN3aXRjaGVzIGZy
b20gSU9NTVUgZG9tYWluIHRvIGJsb2NrIGRvbWFpbiwgdGhlIHdob2xlDQo+aW9tbXUNCj4+IG1l
bW9yeSByZWdpb24gaXMgZGlzYWJsZWQsIHRoaXMgdHJpZ2dlciB0aGUgdW5tYXAgb24gdGhlIHdo
b2xlIGlvbW11DQo+bWVtb3J5DQo+PiByZWdpb24sDQo+DQo+SSBnb3QgdGhpcyBwYXJ0Lg0KPg0K
Pj4gbm8gbWF0dGVyIGhvdyBtYW55IG9yIGhvdyBsYXJnZSB0aGUgbWFwcGluZ3MgYXJlIGluIHRo
ZSBpb21tdSBNUi4NCj4NCj5obW1tLiBBIG1vcmUgZXhwbGljaXQgcXVlc3Rpb246IGRvZXMgdGhp
cyBlcnJvciBoYXBwZW4gd2l0aCA0RyBWTSBtZW1vcnkNCj5hcyB3ZWxsPw0KDQpDb2luY2lkZW50
bHksIEkgcmVtZW1iZXIgUUFUIHRlYW0gcmVwb3J0ZWQgdGhpcyBpc3N1ZSBqdXN0IHdpdGggNEcg
Vk0gbWVtb3J5Lg0KDQo+DQo+Pj4NCj4+Pj4NCj4+Pj4gQmVjYXVzZSBsZWdhY3kgVkZJTyBsaW1p
dHMgbWF4aW11bSBiaXRtYXAgc2l6ZSB0byAyNTZNQiB3aGljaCBtYXBzDQo+dG8NCj4+PiA4VEIg
b24NCj4+Pj4gNEsgcGFnZSBzeXN0ZW0sIHdoZW4gMTZUQiBzaXplZCBVTk1BUCBub3RpZmljYXRp
b24gaXMgc2VudCwNCj4+PiB1bm1hcF9iaXRtYXANCj4+Pj4gaW9jdGwgZmFpbHMuDQo+Pj4+DQo+
Pj4+IFRoZXJlIGlzIG5vIHN1Y2ggbGltaXRhdGlvbiB3aXRoIGlvbW11ZmQgYmFja2VuZCwgYnV0
IGl0J3Mgc3RpbGwgbm90IG9wdGltYWwNCj4+Pj4gdG8gYWxsb2NhdGUgbGFyZ2UgYml0bWFwLg0K
Pj4+Pg0KPj4+PiBPcHRpbWl6ZSBpdCBieSBpdGVyYXRpbmcgb3ZlciBETUFNYXAgbGlzdCB0byB1
bm1hcCBlYWNoIHJhbmdlIHdpdGgNCj5hY3RpdmUNCj4+Pj4gbWFwcGluZyB3aGVuIG1pZ3JhdGlv
biBpcyBhY3RpdmUuIElmIG1pZ3JhdGlvbiBpcyBub3QgYWN0aXZlLCB1bm1hcHBpbmcNCj50aGUN
Cj4+Pj4gd2hvbGUgYWRkcmVzcyBzcGFjZSBpbiBvbmUgZ28gaXMgb3B0aW1hbC4NCj4+Pj4NCj4+
Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCj4+Pj4gVGVzdGVkLWJ5OiBHaW92YW5uaW8gQ2FiaWRkdSA8Z2lvdmFubmkuY2FiaWRkdUBp
bnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11LmMgfCA0Mg0K
Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgICAx
IGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+IGluZGV4
IDgzYzVlNDQ0MTMuLjY4NzZkYWU3MjcgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gQEAgLTM3LDYg
KzM3LDcgQEANCj4+Pj4gICAgI2luY2x1ZGUgInN5c3RlbS9zeXN0ZW0uaCINCj4+Pj4gICAgI2lu
Y2x1ZGUgImh3L2kzODYvYXBpY19pbnRlcm5hbC5oIg0KPj4+PiAgICAjaW5jbHVkZSAia3ZtL2t2
bV9pMzg2LmgiDQo+Pj4+ICsjaW5jbHVkZSAibWlncmF0aW9uL21pc2MuaCINCj4+Pj4gICAgI2lu
Y2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgiDQo+Pj4+ICAgICNpbmNsdWRlICJ0cmFjZS5oIg0K
Pj4+Pg0KPj4+PiBAQCAtNDQyMyw2ICs0NDI0LDQyIEBAIHN0YXRpYyB2b2lkDQo+Pj4gdnRkX2Rl
dl91bnNldF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZu
KQ0KPj4+PiAgICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+Pj4gICAgfQ0KPj4+Pg0KPj4+
PiArLyoNCj4+Pj4gKyAqIFVubWFwcGluZyBhIGxhcmdlIHJhbmdlIGluIG9uZSBnbyBpcyBub3Qg
b3B0aW1hbCBkdXJpbmcgbWlncmF0aW9uDQo+Pj4gYmVjYXVzZQ0KPj4+PiArICogYSBsYXJnZSBk
aXJ0eSBiaXRtYXAgbmVlZHMgdG8gYmUgYWxsb2NhdGVkIHdoaWxlIHRoZXJlIG1heSBiZSBvbmx5
DQo+c21hbGwNCj4+Pj4gKyAqIG1hcHBpbmdzLCBpdGVyYXRlIG92ZXIgRE1BTWFwIGxpc3QgdG8g
dW5tYXAgZWFjaCByYW5nZSB3aXRoIGFjdGl2ZQ0KPj4+IG1hcHBpbmcuDQo+Pj4+ICsgKi8NCj4+
Pj4gK3N0YXRpYyB2b2lkIHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwX2luX21pZ3JhdGlvbihWVERB
ZGRyZXNzU3BhY2UNCj4+PiAqYXMsDQo+Pj4+ICsNCj4+PiBJT01NVU5vdGlmaWVyICpuKQ0KPj4+
PiArew0KPj4+PiArICAgIGNvbnN0IERNQU1hcCAqbWFwOw0KPj4+PiArICAgIGNvbnN0IERNQU1h
cCB0YXJnZXQgPSB7DQo+Pj4+ICsgICAgICAgIC5pb3ZhID0gbi0+c3RhcnQsDQo+Pj4+ICsgICAg
ICAgIC5zaXplID0gbi0+ZW5kLA0KPj4+PiArICAgIH07DQo+Pj4+ICsgICAgSU9WQVRyZWUgKnRy
ZWUgPSBhcy0+aW92YV90cmVlOw0KPj4+PiArDQo+Pj4+ICsgICAgLyoNCj4+Pj4gKyAgICAgKiBE
TUFNYXAgaXMgY3JlYXRlZCBkdXJpbmcgSU9NTVUgcGFnZSB0YWJsZSBzeW5jLCBpdCdzIGVpdGhl
cg0KPjRLQg0KPj4+IG9yIGh1Z2UNCj4+Pj4gKyAgICAgKiBwYWdlIHNpemUgYW5kIGFsd2F5cyBh
IHBvd2VyIG9mIDIgaW4gc2l6ZS4gU28gdGhlIHJhbmdlIG9mDQo+Pj4gRE1BTWFwIGNvdWxkDQo+
Pj4+ICsgICAgICogYmUgdXNlZCBmb3IgVU5NQVAgbm90aWZpY2F0aW9uIGRpcmVjdGx5Lg0KPj4+
PiArICAgICAqLw0KPj4+PiArICAgIHdoaWxlICgobWFwID0gaW92YV90cmVlX2ZpbmQodHJlZSwg
JnRhcmdldCkpKSB7DQo+Pj4NCj4+PiBob3cgYWJvdXQgYW4gZW1wdHkgaW92YV90cmVlPyBJZiBn
dWVzdCBoYXMgbm90IG1hcHBlZCBhbnl0aGluZyBmb3IgdGhlDQo+Pj4gZGV2aWNlLCB0aGUgdHJl
ZSBpcyBlbXB0eS4gQW5kIGl0IGlzIGZpbmUgdG8gbm90IHVubWFwIGFueXRpbmcuIFdoaWxlLA0K
Pj4+IGlmIHRoZSBkZXZpY2UgaXMgYXR0YWNoZWQgdG8gYW4gaWRlbnRpZnkgZG9tYWluLCB0aGUg
aW92YV90cmVlIGlzIGVtcHR5DQo+Pj4gYXMgd2VsbC4gQXJlIHdlIHN1cmUgdGhhdCB3ZSBuZWVk
IG5vdCB0byB1bm1hcCBhbnl0aGluZyBoZXJlPyBJdCBsb29rcw0KPj4+IHRoZSBhbnN3ZXIgaXMg
eWVzLiBCdXQgSSdtIHN1c3BlY3RpbmcgdGhlIHVubWFwIGZhaWx1cmUgd2lsbCBoYXBwZW4gaW4N
Cj4+PiB0aGUgdmZpbyBzaWRlPyBJZiB5ZXMsIG5lZWQgdG8gY29uc2lkZXIgYSBjb21wbGV0ZSBm
aXguIDopDQo+Pg0KPj4gTm90IGdldCB3aGF0IGZhaWx1cmUgd2lsbCBoYXBwZW4sIGNvdWxkIHlv
dSBlbGFib3JhdGU/DQo+PiBJbiBjYXNlIG9mIGlkZW50aXR5IGRvbWFpbiwgSU9NTVUgbWVtb3J5
IHJlZ2lvbiBpcyBkaXNhYmxlZCwgbm8gaW9tbXUNCj4+IG5vdGlmaWVyIHdpbGwgZXZlciBiZSB0
cmlnZ2VyZWQuIHZmaW9fbGlzdGVuZXIgbW9uaXRvcnMgbWVtb3J5IGFkZHJlc3MNCj5zcGFjZSwN
Cj4+IGlmIGFueSBtZW1vcnkgcmVnaW9uIGlzIGRpc2FibGVkLCB2ZmlvX2xpc3RlbmVyIHdpbGwg
Y2F0Y2ggaXQgYW5kIGRvIGRpcnR5DQo+dHJhY2tpbmcuDQo+DQo+TXkgcXVlc3Rpb24gY29tZXMg
ZnJvbSB0aGUgcmVhc29uIHdoeSBETUEgdW5tYXAgZmFpbHMuIEl0IGlzIGR1ZSB0bw0KPmEgYmln
IHJhbmdlIGlzIGdpdmVuIHRvIGtlcm5lbCB3aGlsZSBrZXJuZWwgZG9lcyBub3Qgc3VwcG9ydC4g
U28gaWYNCj5WRklPIGdpdmVzIGEgYmlnIHJhbmdlIGFzIHdlbGwsIGl0IHNob3VsZCBmYWlsIGFz
IHdlbGwuIEFuZCB0aGlzIGlzDQo+cG9zc2libGUgd2hlbiBndWVzdCAoYSBWTSB3aXRoIGxhcmdl
IHNpemUgbWVtb3J5KSBzd2l0Y2hlcyBmcm9tIGlkZW50aWZ5DQo+ZG9tYWluIHRvIGEgcGFnaW5n
IGRvbWFpbi4gSW4gdGhpcyBjYXNlLCB2ZmlvX2xpc3RlbmVyIHdpbGwgdW5tYXAgYWxsDQo+dGhl
IHN5c3RlbSBNUnMuIEFuZCBpdCBjYW4gYmUgYSBiaWcgcmFuZ2UgaWYgVk0gc2l6ZSBpcyBiaWcg
ZW5vdWdoLg0KDQpHb3QgeW91IHBvaW50LiBZZXMsIGN1cnJlbnRseSB2ZmlvX3R5cGUxIGRyaXZl
ciBsaW1pdHMgdW5tYXBfYml0bWFwIHRvIDhUQiBzaXplLg0KSWYgZ3Vlc3QgbWVtb3J5IGlzIGxh
cmdlIGVub3VnaCBhbmQgbGVhZCB0byBhIG1lbW9yeSByZWdpb24gb2YgbW9yZSB0aGFuIDhUQiBz
aXplLA0KdW5tYXBfYml0bWFwIHdpbGwgZmFpbC4gSXQncyBhIHJhcmUgY2FzZSB0byBsaXZlIG1p
Z3JhdGUgVk0gd2l0aCBtb3JlIHRoYW4gOFRCIG1lbW9yeSwNCmluc3RlYWQgb2YgZml4aW5nIGl0
IGluIHFlbXUgd2l0aCBjb21wbGV4IGNoYW5nZSwgSSdkIHN1Z2dlc3QgdG8gYnVtcCBiZWxvdyBN
QUNSTw0KdmFsdWUgdG8gZW5sYXJnZSB0aGUgbGltaXQgaW4ga2VybmVsLCBvciBzd2l0Y2ggdG8g
dXNlIGlvbW11ZmQgd2hpY2ggZG9lc24ndCBoYXZlIHN1Y2ggbGltaXQuDQoNCi8qDQogKiBJbnB1
dCBhcmd1bWVudCBvZiBudW1iZXIgb2YgYml0cyB0byBiaXRtYXBfc2V0KCkgaXMgdW5zaWduZWQg
aW50ZWdlciwgd2hpY2gNCiAqIGZ1cnRoZXIgY2FzdHMgdG8gc2lnbmVkIGludGVnZXIgZm9yIHVu
YWxpZ25lZCBtdWx0aS1iaXQgb3BlcmF0aW9uLA0KICogX19iaXRtYXBfc2V0KCkuDQogKiBUaGVu
IG1heGltdW0gYml0bWFwIHNpemUgc3VwcG9ydGVkIGlzIDJeMzEgYml0cyBkaXZpZGVkIGJ5IDJe
MyBiaXRzL2J5dGUsDQogKiB0aGF0IGlzIDJeMjggKDI1NiBNQikgd2hpY2ggbWFwcyB0byAyXjMx
ICogMl4xMiA9IDJeNDMgKDhUQikgb24gNEsgcGFnZQ0KICogc3lzdGVtLg0KICovDQojZGVmaW5l
IERJUlRZX0JJVE1BUF9QQUdFU19NQVggICAoKHU2NClJTlRfTUFYKQ0KI2RlZmluZSBESVJUWV9C
SVRNQVBfU0laRV9NQVggICAgRElSVFlfQklUTUFQX0JZVEVTKERJUlRZX0JJVE1BUF9QQUdFU19N
QVgpDQoNCj4NCj4+Pg0KPj4+PiArICAgICAgICBJT01NVVRMQkV2ZW50IGV2ZW50Ow0KPj4+PiAr
DQo+Pj4+ICsgICAgICAgIGV2ZW50LnR5cGUgPSBJT01NVV9OT1RJRklFUl9VTk1BUDsNCj4+Pj4g
KyAgICAgICAgZXZlbnQuZW50cnkuaW92YSA9IG1hcC0+aW92YTsNCj4+Pj4gKyAgICAgICAgZXZl
bnQuZW50cnkuYWRkcl9tYXNrID0gbWFwLT5zaXplOw0KPj4+PiArICAgICAgICBldmVudC5lbnRy
eS50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnk7DQo+Pj4+ICsgICAgICAgIGV2ZW50
LmVudHJ5LnBlcm0gPSBJT01NVV9OT05FOw0KPj4+PiArICAgICAgICAvKiBUaGlzIGZpZWxkIGlz
IG1lYW5pbmdsZXNzIGZvciB1bm1hcCAqLw0KPj4+PiArICAgICAgICBldmVudC5lbnRyeS50cmFu
c2xhdGVkX2FkZHIgPSAwOw0KPj4+PiArICAgICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21t
dV9vbmUobiwgJmV2ZW50KTsNCj4+Pj4gKw0KPj4+PiArICAgICAgICBpb3ZhX3RyZWVfcmVtb3Zl
KHRyZWUsICptYXApOw0KPj4+PiArICAgIH0NCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiAgICAvKiBV
bm1hcCB0aGUgd2hvbGUgcmFuZ2UgaW4gdGhlIG5vdGlmaWVyJ3Mgc2NvcGUuICovDQo+Pj4+ICAg
IHN0YXRpYyB2b2lkIHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKFZUREFkZHJlc3NTcGFjZSAqYXMs
DQo+Pj4gSU9NTVVOb3RpZmllciAqbikNCj4+Pj4gICAgew0KPj4+PiBAQCAtNDQzMiw2ICs0NDY5
LDExIEBAIHN0YXRpYyB2b2lkDQo+Pj4gdnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAoVlREQWRkcmVz
c1NwYWNlICphcywgSU9NTVVOb3RpZmllciAqbikNCj4+Pj4gICAgICAgIEludGVsSU9NTVVTdGF0
ZSAqcyA9IGFzLT5pb21tdV9zdGF0ZTsNCj4+Pj4gICAgICAgIERNQU1hcCBtYXA7DQo+Pj4+DQo+
Pj4+ICsgICAgaWYgKG1pZ3JhdGlvbl9pc19ydW5uaW5nKCkpIHsNCj4+Pg0KPj4+IElmIHRoZSBy
YW5nZSBpcyBub3QgYmlnIGVub3VnaCwgaXQgaXMgc3RpbGwgYmV0dGVyIHRvIHVubWFwIGluIG9u
ZS1nby4NCj4+PiByaWdodD8gSWYgc28sIG1pZ2h0IGFkZCBhIGNoZWNrIG9uIHRoZSByYW5nZSBo
ZXJlIHRvIGdvIHRvIHRoZSBpb3ZhX3RlZQ0KPj4+IGl0ZXJhdGlvbiBjb25kaXRpb25hbGx5Lg0K
Pj4NCj4+IFdlIGRvbid0IHdhbnQgdG8gZGl0cnkgdHJhY2sgSU9WQSBob2xlcyBiZXR3ZWVuIElP
VkEgcmFuZ2VzIGJlY2F1c2UgaXQncw0KPnRpbWUgY29uc3VtaW5nIGFuZCB1c2VsZXNzIHdvcmsu
IFRoZSBob2xlIG1heSBiZSBsYXJnZSBkZXBlbmRpbmcgb24gZ3Vlc3QNCj5iZWhhdmlvci4NCj4+
IE1lYW53aGlsZSB0aGUgdGltZSBpdGVyYXRpbmcgb24gaW92YV90cmVlIGlzIHRyaXZpYWwuIFNv
IHdlIHByZWZlciB0cmFja2luZw0KPnRoZSBleGFjdCBpb3ZhIHJhbmdlcyB0aGF0IG1heSBiZSBk
aXJ0eSBhY3R1YWxseS4NCj4NCj5JIHNlZS4gU28gdGhpcyBpcyB0aGUgb3B0aW1pemF0aW9uLiBB
bmQgaXQgYWxzbyBXQSB0aGUgYWJvdmUgRE1BDQo+dW5tYXAgaXNzdWUgYXMgd2VsbC4gcmlnaHQ/
IElmIHNvLCB5b3UgbWF5IHdhbnQgdG8gY2FsbCBvdXQgaW4gdGhlDQo+Y29tbWl0IG1lc3NhZ2Uu
DQoNClllcywgdGhlIG1haW4gcHVycG9zZSBvZiB0aGlzIHBhdGNoIGlzIHRvIGZpeCB0aGUgdW5t
YXBfYml0bWFwIGlzc3VlLCB0aGVuIHRoZSBvcHRpbWl6YXRpb24uDQpJJ2xsIHJlcGhyYXNlIHRo
ZSBkZXNjcmlwdGlvbiBhbmQgc3ViamVjdC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

