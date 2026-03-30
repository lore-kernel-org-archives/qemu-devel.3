Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CCCFF494B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 06:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w75tH-0003VT-35; Mon, 30 Mar 2026 02:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w75t8-0003T9-Lx
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 02:14:15 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w75t4-0005BQ-2U
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 02:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774851250; x=1806387250;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=goJO1lKQmB9vj0uEjg9yB7AA1XR5sHvx638pQ39csiU=;
 b=MLnLE4LM5mphEUvtVJVvpJnWRYk9hBHJ+FWpcxVdCqWJZSbRwpq+4aK3
 AljigjxW4UYxVQ1x4R/Rt/zd91RjF8Oam/4lh9dpuvXFKB+gbPppI0IJm
 uKmYZTaOETcSTLIsHCtdXbLHwoWGDDc6XKIj7fWVD1fjMKzIuiz3lqZY4
 2jzbi09OXzKWRBoUt1DP2cZLoM1i46/9psP8va+CWadQ2+YAoHQfV2fLt
 oHbUVo08V4Eaxg7WHFn0BNhy27re8c9vsqJBrBjgK3JmX5f6dQj+hpOlK
 dgZwvAD9bgE/aN33rA4NYSfIOZWfNuMticDw2165O0d4WP2xmLzQpcImZ w==;
X-CSE-ConnectionGUID: wn8yyF6tQiKsRU7/+iwG6Q==
X-CSE-MsgGUID: 6WCEOoWnS1GZIwvT0Nis8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79738410"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="79738410"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 23:14:03 -0700
X-CSE-ConnectionGUID: h95X6dySTb6sLmijsF5wPw==
X-CSE-MsgGUID: Pruny9VeSpmE9ewvafvTXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="225961562"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 23:14:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:14:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 23:14:02 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvDTD23225Bb98DhzysXvkQoHn/EJrrD2nUFeTtwskGiv+bJKKtdhhwCABzXuXy4Nx9I+xzznhqYGE6wI5F0wO+jTaKVZPv49G/Mn/l7bOCGiVLYp3f+kHGi2MP9Pahl2kZxy74hiSAyYbZqqvXym2ZrfWikmVfN9rOs4Hcv8U1wAXNxd1BhtvFBGQ5s7IGeluP5NixlGSOtRrGB0z+CSpGrFretuaFIqXgOL4PUDc55k/64b/9sJjYQIo5TBlRgF1vGvMPzOxlvEjbWs/yvAANMt8gcHCx9Y0rQQ1qVM6GLQwjgOQhS9Pa0Jw7C9QHDhfK38DeHLr6Vp1sbES0I0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE8FRs+1JzyQrSEpXTDJKTlh4TUekQDUAmInWYwCdl4=;
 b=UQwrUeSQNzb4CEs46fmY2JUCz/sj9I0evzYUJPY+MZi14QxE/FD5FcbwoCzlyviX55gSGvgjd5C+U/ovOjyOsjo6thAOceNAdMIfiEoMmQtN7FZ5ce8U2OBiUclKsKALLE6kl+EMm+T4sSg9zAn8g1/arEz15/HVkRP0Ch3hlFvpmJzju0Cgj9cEJxfzdFTxVizuX6uvPNLHvajkUB9yjcTwRWPneMuAchom5R67jiaa/uJibRMKYRgfBkRvu6hwP7oQP11x+QJp4na9GChdpABRDJBtpw9vPM93mbetkq82oGM5LG/8P+5p7w2aOu+oIY3JNXkshCMMoz481Hg3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 06:13:59 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 06:13:59 +0000
Message-ID: <59c21c2d-7906-47dc-a3fb-cba2ce0a2686@intel.com>
Date: Mon, 30 Mar 2026 14:21:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] intel_iommu_accel: Handle PASID entry addition
 for pc_inv_dsc request
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-8-zhenzhong.duan@intel.com>
 <1e76a065-3155-4a1d-9d9e-38a90594fcd2@intel.com>
 <IA3PR11MB91367FD38F5BB8BBE50471FD9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91367FD38F5BB8BBE50471FD9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::18) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ2PR11MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: ba549b24-bc10-4295-f858-08de8e238809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|42112799006|3613699012|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UuZY8nQ0yA/4ayhmsN8zejm67rvoqT+Ou5shahZEFLW4Azf8/ve3J9MT1emNuLxbsY1m6UOp2GuOoKK95+fsfgSWH/YLuCNlM5h7ytXI7cfx7XkjYboFQ1eQlZ0UnpPv/oKKw7AqoSnWiywzQHCAmdcbhYiM4GKzTJtbTrRsCD0V2DC4Ynf45+ruHX73c5yIGiBhTE7heADq+FM8jnQIgCnYCPBQ6VlvH4ZaFvOpLsk2Kf8DqGA+foBeOmiVXz7rHHioAkP4v1j6NqMnPWIdUXbARppEUukPMJ/NCHLFMd7XSFqwdP/2939LsmBC2yhTHMdYPUDZhFZMrf5jN6wKG9ARKGKj+5oo85lNuTbQi1qJH1KFjB2Q1Ul4i7cYZQxTywxAz9T8BzNXt/MCinYmVQF5UvEact3yI46AIdQwtkw4soQvPy3lav34KTDrBWbYPqDd034xiq5Z0rvgm3HVpkV3f6PQZKLsyo6Q9xsijtHhW8HNMEQHN47CtHtBJRJviguuQJSexMffmLHusjTe5mkR33yRbFEg+Ps9yS/7Odupya8w50URuoNiHSj3Ekxkmit/iSYPEzhpuarRfRhTQcPOEysbim3zTK9IffRy8M7kjSOthy8enMCbNY/nR/w6YMYw3HN2tpZgxMYnuFE8CoFZaci6HmiR6rdjxz2zn4GoqGXrP+5Lo0IlyuKe5JFauejBiX8xb+DAFte6M+rLHhqGU1WOEa+TYrisat/8ofoWy2XkKvXAmuMboAkKgRmglyaTvdiRUT5EZ/N4JcWGF9HCByEahVGsQzOzTkj/pBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(42112799006)(3613699012)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b05wTnJVa2pkZTMrMGRqckNsT0NiUXJFbEpCN2F3ZXFReXI2Q09tYk8zOUJH?=
 =?utf-8?B?dFpXSzNha3lBMEVhYXE5Sk54ZmFmaVpXaU5KeHBBd2dlT1RwZ0l6dnlnNHQz?=
 =?utf-8?B?UWNMdER1S1JVTktuQkFEVGN3aVp4U2JHQVpNampIN05kSWd3Uk9pNDhoSFlX?=
 =?utf-8?B?ZS96MG4rYTVtMDY5Q0c5M09KamRBYWc2R3NtMk5ValVSdXd2eVhRc09xaU50?=
 =?utf-8?B?a3Q1ZXlNZy9CK0FINDVvOEtKR09JT0pPcXJnbnlrOVFCa2JKM2FMNktQaUt0?=
 =?utf-8?B?L2xuaFJsVE5CcEJlSjExaDEvRUpSQmdMRmVVT3J1c0NHa1FkM1UrVitqdzJl?=
 =?utf-8?B?UEhYQXhSWWRCbG1CM0xhT1g4dlhwcTNTRDZjRUcxL2l3UzdweXpYei9qUUsy?=
 =?utf-8?B?emJPaGEvQlZveFdTRDZ0K2E3SVhic0FSZjJEb3RMeEloMXNZa3pGVndKaElZ?=
 =?utf-8?B?UDNpYm5malJDZ1lTVmlJSzBCaVBXcC9LdE5zNllGRU9VNG9BcXVrQUlCdmFQ?=
 =?utf-8?B?cTdwTzFNNVNyWFhpU3d1a0tFbnhETENEajdRS3ZlMjB1U2cvejZtRjQzZHIv?=
 =?utf-8?B?V1M0SE9EbkFLNHo1WU1WOVE4TlpmZFd0U0oyU09hVnRVbVo2RGtjTFBPbUxt?=
 =?utf-8?B?UktjOTNFcXlFQjBXK2toNW0wamZYUXgwTEF0bVo0M1ROcGFWUGdwTW01cDJS?=
 =?utf-8?B?NlB3RUNha0lINnJxSjFWYUsvYXVvZUJ6eDh6M2w5cVhocTJxaUdFQU1Td3hr?=
 =?utf-8?B?SHVidFpJTktKM01KR0NJangwNkZvUEQ0eGpqREQzNGhNQS96ek1SdnVjODFz?=
 =?utf-8?B?enF2a0ZXKzJFdjdraTJ4b1c3emhNdy9mS2JSMzVOMkhOVllpR0VQQU0zZzJy?=
 =?utf-8?B?V013dUVxY0htR1NNMVFPZHJTY2JsQmozQU5qc09yL1lQVGxVcEk3V2xaSGYy?=
 =?utf-8?B?cFZIdVFmL1E4cVRpaDJHUUhhcU5xRG02YmhObVZpK2RrOWdCZ3JydlhKYjdL?=
 =?utf-8?B?U0plRlZ1dDkyUE9vWUhuaUlod1JhdzlTVXV1Unozb0E0TktBSEFDOThadm03?=
 =?utf-8?B?WTE4Wi8wTTZadjlray9jY0RYWTlxV1R3L0dxWVhuVkVxZmxWZXpLeFpXek1v?=
 =?utf-8?B?QjBDbE85Y1ptNm5xTE9penRCNUJmdkJpVTJsYlVFL2FXYVpkZisvbDJCZkdL?=
 =?utf-8?B?clAwd0xwc1pQR3RYSmFHVDhQU2xJcjhKME1zUW1xTEhQWXE2TXgxRmFvYTYv?=
 =?utf-8?B?WW9NdktHaXdBNUVzemNXMEE4dGFzYmwySkpvUHhpbDZwM1lpbkRNMEpFWG5r?=
 =?utf-8?B?ODNjWUFDRUxHSEwyV0RFYmVabWsvbnZwM3o5WXRUaU12K2hTd3V0aDhLOTNB?=
 =?utf-8?B?Z0ZKeUNLOTB4RzBNa2VXaWs2amdWakRFMytKdUUrRmVSYmZsRUg2S01Ib3pn?=
 =?utf-8?B?VEJSajBoZGdleEQ5cEI4dEhoeVgyYUJhbE96bklTbUpQcEtUck5OVGdLWDNn?=
 =?utf-8?B?QXNHMFdSSkc1Nm9ISHAzcGJ4OU5zZHdIQ2JCdTRSNXgvS2ozNnBwbWFhWWV4?=
 =?utf-8?B?TmJ4Y3pvbkRsOHJNaWdBL0hRU2JieHV4eUtNTG5MZXlVM2tTMjZJbEpBY3Zl?=
 =?utf-8?B?VGRpeW9XMWhYRE9DZW5INnFqR1NobVhhbDU1TlIrOXlNY2E3eEdlZzE3QzJs?=
 =?utf-8?B?Y0dtS01XaW1XTGp2aDVZRmRuTElSUzdFandnYVBRVGdKVyszSGdsenEyQ2t5?=
 =?utf-8?B?clRocStXcnlPZ0cyV0gzOEozbGRSUllBWm9EenNjNVZpYjc4a0QzQU02bnlq?=
 =?utf-8?B?T3p3MkRVdG01TmNxaTNOQWF2dzVUekJNakMyeVJmQlFqeWFkVytQNlVyZGZz?=
 =?utf-8?B?M1hFRm43ZlVvT01ieTB1b1NlZjJRSjdMbHFOcFB2dXhxbkxXcVJQV09rcVJz?=
 =?utf-8?B?cG5vWUhLMGwwZzhNLzBmOThXT1Jvc0V0RENTUi9BTDBPZ2VoUVZXaHAxOUV4?=
 =?utf-8?B?UWtzZDhYbkUyMUhxQ2xTTUdoWHpNSE1GK0o0UnR2cTgvWit6SXNpM2ZiWnBq?=
 =?utf-8?B?MExWVy9WQWdjWjIraXpwWE5idHB5V2U2aWR0dWFXWTlYQnJJVUlKdGNjL3dt?=
 =?utf-8?B?a0RUWHUxaE9sZUEvNUJBank4am9iQzRvMjg2dWtkNUZaYTBSMnMxNnBMY1dM?=
 =?utf-8?B?S2diTTRqUlVIOE1oaFFoeWhRTlIzOGJndFJzRmU3c3AyTEFzOFowTFJzbnNK?=
 =?utf-8?B?S1RLalZLQTVabk5qdTVka2hVYXhiczh6QytxSzhVRVlNR0NBQnRVM3VVZ0E2?=
 =?utf-8?B?aXFWK092K25QdzJSQ05WclFsbVpkNkU4NjJ6YUo1dVdvTGVNMVNXdz09?=
X-Exchange-RoutingPolicyChecked: gu56mIdwnCemOiz2mhcfF3g8EaHJ9166b7+dlQ82cXhdc8UIrEMdpqQJWbL9jCh+V740unuTC2XE7ep1IYfeuHnfu95x5xSrZY3WybLRWyqaGl9HxS3QYa7UBS7PusXzbBEZmHWWto+h4DZ8B2rgm+CHmpzNv6Geqe3wcInYEKNQmEJtH+v73uRdWSpSYf38LgxherizpCwLgfyr0/eVVF3a2chU2M/pScuupbtUf6l9iaHAAkjJuhNYsvXfW0OiV8jSLoBBDJ/0fmLMN6T1IxBk1hJVJUjHPZSRFpkYVNL0kee7Qf1J0dSJgfwr+owszt4i/Ag2mVwbiwrPHahrVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ba549b24-bc10-4295-f858-08de8e238809
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 06:13:59.4050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsSYpQ8GqvaK4LVwJs25D75KmhXK1gn8YLTzMkyD/9Z/5Gh+pmMeB3MAUsLfKsKBY2JJbDnxjnFM/hrf5jw1cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8401
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

On 3/27/26 16:08, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v2 07/14] intel_iommu_accel: Handle PASID entry addition for
>> pc_inv_dsc request
>>
>> On 3/26/26 17:11, Zhenzhong Duan wrote:
>>> Structure VTDAddressSpace includes some elements suitable for emulated
>>> device and passthrough device without PASID, e.g., address space,
>>> different memory regions, etc, it is also protected by vtd iommu lock,
>>> all these are useless and become a burden for passthrough device with
>>> PASID.
>>>
>>> When there are lots of PASIDs used in one device, the AS and MRs are
>>> all registered to memory core and impact the whole system performance.
>>>
>>> So instead of using VTDAddressSpace to cache pasid entry for each pasid
>>> of a passthrough device, we define a light weight structure
>>> VTDAccelPASIDCacheEntry with only necessary elements for each pasid. We
>>> will use this struct as a parameter to conduct binding/unbinding to
>>> nested hwpt and to record the current bound nested hwpt. It's also
>>> designed to support PASID_0.
>>>
>>> VTDAccelPASIDCacheEntry is designed to only be used in intel_iommu_accel.c,
>>> similarly VTDPASIDCacheEntry should only be used in hw/i386/intel_iommu.c
>>>
>>> When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
>>> (pasid cache invalidation) request, walk through each pasid in each
>>> passthrough device for valid pasid entries, create a new
>>> VTDAccelPASIDCacheEntry if not existing yet.
>>>
>>> PASID_0 of passthrough device still need to register MRs in case guest
>>> does not operate in scalable mode. So for PASID_0, we have both
>>> VTDAPASIDCacheEntry and VTDAccelPASIDCacheEntry.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>
>> perhaps togather with a co-d-b tag, otherwise this s-o-b tag is strange.
>> same to other commits in this series. :)
> 
> Sure, will do😊
> 
>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_accel.h    |  13 +++
>>>    hw/i386/intel_iommu_internal.h |   8 ++
>>>    hw/i386/intel_iommu.c          |   3 +
>>>    hw/i386/intel_iommu_accel.c    | 170 +++++++++++++++++++++++++++++++++
>>>    4 files changed, 194 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
>>> index e5f0b077b4..c5981a23bf 100644
>>> --- a/hw/i386/intel_iommu_accel.h
>>> +++ b/hw/i386/intel_iommu_accel.h
>>> @@ -12,6 +12,13 @@
>>>    #define HW_I386_INTEL_IOMMU_ACCEL_H
>>>    #include CONFIG_DEVICES
>>>
>>> +typedef struct VTDAccelPASIDCacheEntry {
>>> +    VTDHostIOMMUDevice *vtd_hiod;
>>> +    VTDPASIDEntry pasid_entry;
>>> +    uint32_t pasid;
>>> +    QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>>> +} VTDAccelPASIDCacheEntry;
>>> +
>>>    #ifdef CONFIG_VTD_ACCEL
>>>    bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice
>> *vtd_hiod,
>>>                              Error **errp);
>>> @@ -20,6 +27,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace
>> *vtd_as, Error **errp);
>>>    void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t
>> domain_id,
>>>                                          uint32_t pasid, hwaddr addr,
>>>                                          uint64_t npages, bool ih);
>>> +void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo
>> *pc_info);
>>>    void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>>>    #else
>>>    static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
>>> @@ -49,6 +57,11 @@ static inline void
>> vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
>>>    {
>>>    }
>>>
>>> +static inline void vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
>>> +                                              VTDPASIDCacheInfo *pc_info)
>>> +{
>>> +}
>>> +
>>>    static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>>>    {
>>>    }
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index c7e107fe87..d5f212ded9 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -616,6 +616,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>    #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>>>
>>>    #define PASID_0                             0
>>> +#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
>>>    #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL |
>> ~VTD_HAW_MASK(aw))
>>>    #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>>>    #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
>>> @@ -646,6 +647,7 @@ typedef struct VTDPIOTLBInvInfo {
>>>    #define VTD_PASID_DIR_BITS_MASK       (0x3fffULL)
>>>    #define VTD_PASID_DIR_INDEX(pasid)    (((pasid) >> 6) &
>> VTD_PASID_DIR_BITS_MASK)
>>>    #define VTD_PASID_DIR_FPD             (1ULL << 1) /* Fault Processing Disable */
>>> +#define VTD_PASID_TABLE_ENTRY_NUM     (1ULL << 6)
>>>    #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>>>    #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) &
>> VTD_PASID_TABLE_BITS_MASK)
>>>    #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable
>> */
>>> @@ -711,6 +713,7 @@ typedef struct VTDHostIOMMUDevice {
>>>        PCIBus *bus;
>>>        uint8_t devfn;
>>>        HostIOMMUDevice *hiod;
>>> +    QLIST_HEAD(, VTDAccelPASIDCacheEntry) pasid_cache_list;
>>>    } VTDHostIOMMUDevice;
>>>
>>>    /*
>>> @@ -768,6 +771,11 @@ static inline int
>> vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
>>>        return memcmp(p1, p2, sizeof(*p1));
>>>    }
>>>
>>> +static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
>>> +{
>>> +    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
>>> +}
>>> +
>>>    int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
>>>                                      VTDPASIDDirEntry *pdire);
>>>    int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index b5d18ae321..451ede7530 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -3202,6 +3202,8 @@ static void vtd_pasid_cache_sync(IntelIOMMUState
>> *s, VTDPASIDCacheInfo *pc_info)
>>>        g_hash_table_foreach(s->vtd_address_spaces,
>> vtd_pasid_cache_sync_locked,
>>>                             pc_info);
>>>        vtd_iommu_unlock(s);
>>> +
>>> +    vtd_pasid_cache_sync_accel(s, pc_info);
>>>    }
>>>
>>>    static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
>>> @@ -4759,6 +4761,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus,
>> void *opaque, int devfn,
>>>        vtd_hiod->devfn = (uint8_t)devfn;
>>>        vtd_hiod->iommu_state = s;
>>>        vtd_hiod->hiod = hiod;
>>> +    QLIST_INIT(&vtd_hiod->pasid_cache_list);
>>>
>>>        if (!vtd_check_hiod(s, vtd_hiod, errp)) {
>>>            g_free(vtd_hiod);
>>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>>> index c2757f3bcd..32d8ab0ef9 100644
>>> --- a/hw/i386/intel_iommu_accel.c
>>> +++ b/hw/i386/intel_iommu_accel.c
>>> @@ -257,6 +257,176 @@ void
>> vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>>>                             vtd_flush_host_piotlb_locked, &piotlb_info);
>>>    }
>>>
>>> +static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>>> +                              VTDPASIDEntry *pe)
>>> +{
>>> +    VTDAccelPASIDCacheEntry *vtd_pce;
>>> +
>>> +    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
>>> +        if (vtd_pce->pasid == pasid) {
>>> +            if (vtd_pasid_entry_compare(pe, &vtd_pce->pasid_entry)) {
>>> +                vtd_pce->pasid_entry = *pe;
>>> +            }
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>> +    vtd_pce = g_malloc0(sizeof(VTDAccelPASIDCacheEntry));
>>> +    vtd_pce->vtd_hiod = vtd_hiod;
>>> +    vtd_pce->pasid = pasid;
>>> +    vtd_pce->pasid_entry = *pe;
>>> +    QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
>>> +}
>>> +
>>> +/*
>>> + * This function walks over PASID range within [start, end) in a single
>>> + * PASID table for entries matching @info type/did, then create
>>> + * VTDAccelPASIDCacheEntry if not exist yet.
>>> + */
>>> +static void vtd_sm_pasid_table_walk_one(VTDHostIOMMUDevice *vtd_hiod,
>>> +                                        dma_addr_t pt_base,
>>> +                                        int start,
>>> +                                        int end,
>>> +                                        VTDPASIDCacheInfo *info)
>>> +{
>>> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
>>> +    VTDPASIDEntry pe;
>>> +    int pasid;
>>> +
>>> +    for (pasid = start; pasid < end; pasid++) {
>>> +        if (vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe) ||
>>> +            !vtd_pe_present(&pe)) {
>>> +            continue;
>>> +        }
>>> +
>>> +        if ((info->type == VTD_INV_DESC_PASIDC_G_DSI ||
>>> +             info->type == VTD_INV_DESC_PASIDC_G_PASID_SI) &&
>>> +            (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
>>> +            /*
>>> +             * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
>>> +             * requires domain id check. If domain id check fail,
>>> +             * go to next pasid.
>>> +             */
>>> +            continue;
>>> +        }
>>> +
>>> +        vtd_accel_fill_pc(vtd_hiod, pasid, &pe);
>>> +    }
>>> +}
>>> +
>>> +/*
>>> + * In VT-d scalable mode translation, PASID dir + PASID table is used.
>>> + * This function aims at looping over a range of PASIDs in the given
>>> + * two level table to identify the pasid config in guest.
>>> + */
>>> +static void vtd_sm_pasid_table_walk(VTDHostIOMMUDevice *vtd_hiod,
>>> +                                    dma_addr_t pdt_base,
>>> +                                    int start, int end,
>>> +                                    VTDPASIDCacheInfo *info)
>>> +{
>>> +    VTDPASIDDirEntry pdire;
>>> +    int pasid = start;
>>> +    int pasid_next;
>>> +    dma_addr_t pt_base;
>>> +
>>> +    while (pasid < end) {
>>> +        pasid_next = (pasid + VTD_PASID_TABLE_ENTRY_NUM) &
>>> +                     ~(VTD_PASID_TABLE_ENTRY_NUM - 1);
>>> +        pasid_next = pasid_next < end ? pasid_next : end;
>>> +
>>> +        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
>>> +            && vtd_pdire_present(&pdire)) {
>>> +            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
>>> +            vtd_sm_pasid_table_walk_one(vtd_hiod, pt_base, pasid, pasid_next,
>>> +                                        info);
>>> +        }
>>> +        pasid = pasid_next;
>>> +    }
>>> +}
>>> +
>>> +static void vtd_replay_pasid_bind_for_dev(VTDHostIOMMUDevice *vtd_hiod,
>>> +                                          int start, int end,
>>> +                                          VTDPASIDCacheInfo *pc_info)
>>
>> s/vtd_replay_pasid_bind_for_dev/vtd_accel_replay_pasid_bind_for_dev/
> 
> An implicit rule is to use vtd_accel_* for all external functions, but for local functions,
> we don't force it. But I'm fine with vtd_accel_replay_pasid_bind_for_dev if you prefer.

yep. Given that we have vtd_replay_pasid_bindings_all() in 
intel_iommu.c, I think add vtd_accel_ prefix here would help
readers.

Regards,
Yi Liu

