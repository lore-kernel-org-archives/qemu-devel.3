Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F5ECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcl3-0000vZ-Fg; Tue, 28 Oct 2025 02:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDcks-0000uG-2S
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:00:29 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDckm-0005Vk-Kv
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761631221; x=1793167221;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vrKfUb8USWC7nF+73baL7vdQWcz+veDKtGqdcM5qM6I=;
 b=jilYsx4zy74wLty/EldhKmUbFsU2B0RhHiKNbV2yMjJC9fZYTc6ZT20o
 1Impw9CuISVeUx87HK2U1XfQmtYovltALI5pvDfVKw1wT/GEbOoTaUHL0
 4izc0I7jPIAq6n9DFmxjf/dZWp7YTy5EGpFCVFSgOlRIwsYMu/msUQAcc
 hxGDRprOI99x1WYd1WSKRo/e6/y6wKq6EOG1NA6xaNn7Zx0p96eqVvfWf
 cHOgbqv+VPLCXe1BmQcPZ4ZtOEbv/zHEzuXxXrC5QavnCQx1mh2mEAP4C
 yzdb49nwlgsN3rjM6ZF0CCfdJnNI7QMF1RlmiszfoE5YgCeHi0Q2KhO12 w==;
X-CSE-ConnectionGUID: tTxRT2VYQDe2q36nO38RLA==
X-CSE-MsgGUID: lNtGymkGR0SwwGYJeW2mFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63817475"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="63817475"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 23:00:14 -0700
X-CSE-ConnectionGUID: Nc3RVB3iSayNSq+OK03GzA==
X-CSE-MsgGUID: cTAcf/WTTF6pxNrZnIP76Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="185713615"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 23:00:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 23:00:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 23:00:13 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 23:00:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BInC/W3vOWCOyb+vG/0ISKyAz6FeJ/CuGaV04DSy7BD+vdDRJ1c/BfxSCSSk9u0DdvEe9KzWAPrj5cEfdw+IlYTbSWxplD+Ay3W9T/oluOvi0hG24pB8Jsablshc6Zm/fgzSlfMlOnpYr6d35Fnlo9v5khL6R0k/0ZqfsvmXte58co6QWjGmGDhXQOq7wn7EjUSjEv4jv4CEW4dGLqCCEZ7Y5KBZFiDv6IU1Kp90H6Ur8G2Bi1TxlueoZ+/13mh73+pFoqH33SKJ+OSvKB0suD6Nqma06S5ix9eQfqxdMNRVmOc7x3DbB2UlXu+78R1YjBsU++oVGEu9arxof5xnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrKfUb8USWC7nF+73baL7vdQWcz+veDKtGqdcM5qM6I=;
 b=ASqnPFfBVkCIwI1Ou9M3773P489xRobDwYRvDGUSyGJKOrcGgVB2re1Jb0JyZPyS8rdPKPE7wXC890ukTA9jlsaSxpP0EZyKIoYoIzVbK/Sz0X4G2IvRiNfC4Vnatop21AZlwDfenOhnTCBXCx6JKwEB055YRiM8NnRrXglTrbj8DI5BcCBc3+SkiHgGIl9XzCuLCGBqQFitBWPUTr+88KSvsxLtZ3uT97K4CAERNpRmHrZe47JjvESkcNSi5tkE0Uawe8mE//keb4xEqcy8edYpUogq5OLRt9gDNgh8kSSlHLIvg9cA5TA5IdyWuQNay0iQDH+9iZB4Ki3jDfjFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 06:00:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 06:00:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 08/23] vfio/iommufd: Force creating nesting parent HWPT
Thread-Topic: [PATCH v7 08/23] vfio/iommufd: Force creating nesting parent HWPT
Thread-Index: AQHcRMKJXQNxCbH2eEGa0/pvizNqGrTRe50AgAWa0IA=
Date: Tue, 28 Oct 2025 06:00:05 +0000
Message-ID: <IA3PR11MB9136419B3CDFB08CEDC532D292FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-9-zhenzhong.duan@intel.com>
 <00cf41c9-3683-42de-84ce-fce2ca5babfb@redhat.com>
In-Reply-To: <00cf41c9-3683-42de-84ce-fce2ca5babfb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB5044:EE_
x-ms-office365-filtering-correlation-id: d860bb70-d63a-49d0-f494-08de15e73e48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MTNzdFdFcm8yVFhoYkhkSW5oSDZFT29pZGNXK2RDclFlTWVqVHJyNEtxTzNl?=
 =?utf-8?B?c0l1WWRNWWh5VlFwWHFDb0lwdkxtdUhJZkxYMnF1bGs4T3B1TThGOTJadUdi?=
 =?utf-8?B?S2UvaWxSWVZUb1BWazVySUZ5NE44UTVtYlEzd2xHN1E2d1JFWDgvZFhJMHdv?=
 =?utf-8?B?a1J0aklKWHFRdjNrd1dXSWs4VG8vOTFYN3U0ZG5mczdtVWR5U29hb2hJL3ln?=
 =?utf-8?B?Wk9Nd2ZqU0pZVVBVWm9iNGlVRTlBaStmcmhLa3FHTUdUUXArc2NESjd6SFlx?=
 =?utf-8?B?WldWeHpjbUJiTTBMdlJ0NlhTN1IyZkIzeXM5T2Q2UHAxeTl5ZFQ4Uml5aTRX?=
 =?utf-8?B?Z29XZ3ZDVVRpeGdmK0Vyd3JGMkd0WDZWRkFMRHNXRE9yTTkwSWJwMXRRRmQ1?=
 =?utf-8?B?THM1TDNmSUFaaWkzdWE0Q1RnNktVUFV0d1BUV0I3M2x3bVFsdTc2dTBKZ2kw?=
 =?utf-8?B?eHBNMGx0RVRSZnBjcFJPeU1qbnR3WjJhRUVodUxOSVNDeGxEeEZyalgwTHpt?=
 =?utf-8?B?Y3l5eHFnbWZLa3U5V2dncnVydjE3cy9rZGdJTWhtVWJtM1g0aWpxOGRraEJl?=
 =?utf-8?B?dnJ6UGkwbjVHL05qWURhWHVseTRjaGRzdUtLUGNrOHdWY0NvczdBOWwvTW16?=
 =?utf-8?B?UXZGekFuUE5vckd0RWxjMVIrYlFWdjlIbkY4anZsY1YvV1NtWWdTYkc3YXFL?=
 =?utf-8?B?ejZpSGxwcjZVb1ozRHVYcUNQcUo4UGJodVVJb0NUWUpuV0dydWFlS3o1LzZ2?=
 =?utf-8?B?QkNZdWFjdC9KY3JGbVYyMGp3NlBjcHBPQUEyUTJrSUdxN1dvRXJhVWVZSloz?=
 =?utf-8?B?cytyU0N2TDQ5cERRc2dkT0toUFQ2M0pTQk9nNWpqYXk1SUV2dXhadEMxWitj?=
 =?utf-8?B?MVdiZnZ4UzlOTmwzQzExcEk1c0dOMlljUWxSdkhEZURlWUhyMGtuZ3NTVzVR?=
 =?utf-8?B?YUhhVzZaN3JHWVFacWIzTi9lSEdQUzRISm9WWEtVYnZ3bGlFcXMyc3lOM1di?=
 =?utf-8?B?OWUxZjIwVXp2OTl2UGFYVm1YVThtTmFmZWdCMEJWeFNsR0F3UTh6TEFWYVhI?=
 =?utf-8?B?MU55MW1EZlFzbERnbHVHdVBaaHcxaGZOc0txQTJmcjUwVmRvRnJSbDFYcWUr?=
 =?utf-8?B?b1h5aWZHZksyN09YUGZzYUxhaHBJRk1pMng1bzdDdHFUL2RuLzJYakYrYThk?=
 =?utf-8?B?NG50V09NRWgzVkhaQ2F5RmcrUUxyWWpjUUxXMVVmZHBGd1BhWjBnNHlwZGhw?=
 =?utf-8?B?Z3FjZVhYZkQvQkx4OXE0OXpNQi9wSUNka2xZczRxc2o2NEFPMko0R1Y1UVBO?=
 =?utf-8?B?MEluZjVDSGFEdWRkK0RRa29obUNUU3dwMGVDWHdycndGR1hLMm1Db1pkS1A3?=
 =?utf-8?B?YS9TZnJHSzJ1S01IRjdnU0ZBNktLYzdDSWg5Zk10ZDk5Ry83TkxZam11dzF4?=
 =?utf-8?B?M29nQitTQldYcXJEbHdick1QM0lOSnd5UmVZQ0Y5c1B2NEY5ZlZiVkM3K1Jw?=
 =?utf-8?B?MGJCa05xVXp6MlE1WFZHdjhPVmNCaGJVdTVSYjJtbURxNWpFUWExSFRONVpi?=
 =?utf-8?B?cGxZUzgxYWIzQUIvNS9UdkI3Z3o3TGNLS3JVRjFWVzhiTTNCSC9YblJyVDIv?=
 =?utf-8?B?K3pQdWdMR3ZDWG5HZHhsU2IxMVVNTlpHR012R1RVejNhdUJzd3dwTktHZGw0?=
 =?utf-8?B?emwvZ2lRRlJoZXV4Y1NWdW5VWUNHVExnWFdsbGhZWm9mVXFUVThBbnpvTTVG?=
 =?utf-8?B?SDJ2NmJwTUpFbFczVk94NC9XbVZKSGZ2NjdqZXIxTGcxUXUvT0RZZTR4TUc4?=
 =?utf-8?B?VnpkdlgwSGU4akFySWt5T3lTM3MrRmpvUUZ4Y0NxMnhaM3B1SDlmajAwV2Zq?=
 =?utf-8?B?c29LeUxCMWVwV3FBUU96ckpZMUpkVWVKK21kSlVwSHJjUUdwR2pVOEozQy9G?=
 =?utf-8?B?SWQwVnUvOTZLWmM2QVB2UVdJSWxZVHZHTXcxYWFraWM3S082T0xkTFhJZllB?=
 =?utf-8?B?OXEvUldjZlVmcHZQa0Q3ZURlWkYwaUVZY1hYTHo2U2pTdlRUWlhkZFozU21J?=
 =?utf-8?Q?bp+SyN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmRRWUZxN3hMSmZCY0wybVZrVW95OHBmbGxNZCt3YXpGdFgvN1dOL2ZmeE9Z?=
 =?utf-8?B?NHR1cnVSbjdsZGVUMW9hSFR5ajU5aUF4NEpyU0NRKzNSSlhCMnlFdmJlcllO?=
 =?utf-8?B?MmpQNnVFYldRZmlHbFc1a3c3bVlsS0ljSllKMHVCaDJSbE05M2R1K2c1M3Vw?=
 =?utf-8?B?NGJ4eUs4V1ZacTZzc0ZKakw1QUhReGNwcE9SUVNQK1RxOHM1Tzh6QWRUV3Fn?=
 =?utf-8?B?RHRtRFI0RHNUQkJhaUJabk1hTGkzcTVlcCtXNm5oWjF6dzhEUWpYbHhKY1Fz?=
 =?utf-8?B?Ni9XQUx0TzdJNkg1aWZpYjVYeXA0MkJTYy9KcEppZjJCTmFXMmdicHU5eVNM?=
 =?utf-8?B?WUk2bmltMXloZy83QVhHRE4vd0w4OEpYSDFxL2g1NkF0K2ZkY05rS0xFcEZJ?=
 =?utf-8?B?dEh0ZFQwN1F3TzFRMWdkZUVRanpLWGJQTCtkT1pDQUdYUEJuR0RQcVVmbjh4?=
 =?utf-8?B?bEZPbmZpR2dyNGVWV3RrV1ZiZTVLZHQ3N0FRUjF4UVVOZDF2ZDl6RnJOL0dS?=
 =?utf-8?B?VGVjMG5hbWRST0R4TDhwcXFHWXFhU3ZVU0lva2pGL3ZReVdUNHRkYkZPbnk3?=
 =?utf-8?B?Z2VFcTdLakpiemk4djREeXZjYkRWSlM1Q0FuWG5ORnFJdUFYZ3RNbGNwenpv?=
 =?utf-8?B?ZXBBeitPLzN5R2hXR3RsemtWRW5DMzI4cnJtV1dHaXZISUsvaXliUjVDaDJG?=
 =?utf-8?B?ZktEZjFnd21qcVpDY1BVbGg0T1VkOHlaNzY4ZjB0Wm9vU1JMaFRwRWVTbWFK?=
 =?utf-8?B?RmFVMFNkZlFDdDJab0xHeE9ITyttbE9lRjF1U1o2U21ZRm9MMHNsQVZXM2R6?=
 =?utf-8?B?MjlPZ21Hd0pSK0pCM3JEb3YwbUJtQTRtZWo3ZFF1NGFZM1ZYWlVQdWJNcWU5?=
 =?utf-8?B?enFtQ0ZjcXBsQ1M4WTdUQWppZkJIS2UralNXVE45Q05kWmdsOGJJcWhXRVhR?=
 =?utf-8?B?K0FzOU85TlhWVDN3SG5wK1drcmM1d1V0TitOYm5MNVcvVXZCTHE0R1lmQ1ho?=
 =?utf-8?B?WnhZRFlqd3hNUzRLOGlNeUNMVC8wTXJ5aWpKYVFmUWFpOVI1UVJ5VU1BeGEw?=
 =?utf-8?B?Qkd1Vysybi8yMi84STRyT3llN0JBS0xsQWoxN0Zxckd3aUV4U0pDOFIxbE5o?=
 =?utf-8?B?eUUvbUhENGVUU1lGT2ttV1ozNDFLREd2OWMwWWdDVGpQeGI0ZlBQQXlGb0lZ?=
 =?utf-8?B?Ulh6cVZma052NFRvNEFvcGZHdzVESnJXS2hqckFwM2JYd1RyY1Z6bGdaUnUw?=
 =?utf-8?B?aUhSODhmUXJBVFVsZDNPdXdxenZQeDFHL2tubW1CN2dwWmhaOXRJaE5XQ09m?=
 =?utf-8?B?U0Y4aHZPK3VSMjkveHpycFZlMUgwYVBJaFNKcXh3MWNDZDM5UVpXNmJ0cEYr?=
 =?utf-8?B?WFhtZnJKZ0ljbmtZVVdWZkRzU0FUK2s0VlhqUHVqNFUrakhyTkkxSHYySXZZ?=
 =?utf-8?B?RlhUZ1ErVXZCY0dHeHZjWkRlYksxWFM0dlpGaUV4dWdNWDEwVVdYSDgzdVht?=
 =?utf-8?B?MjVnMG01cGJYeFNEVmMrM2J5TEQ4cmFJNVBTVlJ0MWhKd2piVzAyYmdUU29W?=
 =?utf-8?B?YVgxc1ZjaEd6anBvdkljMVRIUGFhNEZhOWFZY0h5Z1lubDRVMDlUWWZ2Z0cr?=
 =?utf-8?B?ZkkrYndRa0xEOXVHVGtkOHYyNW1hMktnblpxODZNcWZkaHQ5NGRIaFJ3OUFy?=
 =?utf-8?B?S1RNYjJHS3ZGUVI4a0x0dlRUZGZOV0FKNWRVS2EraDkzTlB5a1FtUUN0NDhS?=
 =?utf-8?B?TlBnRlhPRXdhVGMrMU5XWmt4bXF0c0daaFpzQ0laUnlZK0lJenJvUDBYckcx?=
 =?utf-8?B?b0w0czFTdHJLRDN6TmJJVzdkakwrQW9haHcvcGR3L21QMFRqS2Jzc2YwSDFT?=
 =?utf-8?B?MVAxbCtVUHAxQ0dhaHRha0M2eVI5V3RqL1hxOVRDVktDQXBzZEtHQjNxdWNk?=
 =?utf-8?B?RFBCSGorVEdSdnhWZ3M3dit5TUpaaTJVamY1THNDL1FUOXJreVNHMVBFWlJi?=
 =?utf-8?B?SW1CTCsyL2NlNEtIMVlyZzlxa2xOTFJSb0JEVW50aFYvdlFVMzdOMUZ2Q3I1?=
 =?utf-8?B?K2RRdUllV0ZCelIzRkhwTjBPWUZYdnlQcTloNXJISUFydldFY2JkVGVxSlZQ?=
 =?utf-8?Q?jAidYdgjibFj/B4VR6a4wTnWw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d860bb70-d63a-49d0-f494-08de15e73e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 06:00:05.9641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDcyWPW7ZVxAWcDfYY6qjdyXA7+GzqQDwzjo6OumFX+IfKxBTk0fgL/Pyn7qtqRmhCwtv4YEMU1nCZU2WdIB7mtyp+KcfnXlcWCGV4bjS2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDA4LzIzXSB2ZmlvL2lv
bW11ZmQ6IEZvcmNlIGNyZWF0aW5nIG5lc3RpbmcgcGFyZW50DQo+SFdQVA0KPg0KPk9uIDEwLzI0
LzI1IDEwOjQzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IENhbGwgcGNpX2RldmljZV9nZXRf
dmlvbW11X2ZsYWdzKCkgdG8gZ2V0IGlmIHZJT01NVSBzdXBwb3J0cw0KPj4gVklPTU1VX0ZMQUdf
V0FOVF9ORVNUSU5HX1BBUkVOVC4NCj4+DQo+PiBJZiB5ZXMsIGNyZWF0ZSBhIG5lc3RpbmcgcGFy
ZW50IEhXUFQgYW5kIGFkZCBpdCB0byB0aGUgY29udGFpbmVyJ3MgaHdwdF9saXN0LA0KPj4gbGV0
dGluZyB0aGlzIHBhcmVudCBIV1BUIGNvdmVyIHRoZSBlbnRpcmUgc2Vjb25kIHN0YWdlIG1hcHBp
bmdzDQo+KEdQQT0+SFBBKS4NCj4+DQo+PiBUaGlzIGFsbG93cyBhIFZGSU8gcGFzc3Rocm91Z2gg
ZGV2aWNlIHRvIGRpcmVjdGx5IGF0dGFjaCB0byB0aGlzIGRlZmF1bHQNCj5IV1BUDQo+PiBhbmQg
dGhlbiB0byB1c2UgdGhlIHN5c3RlbSBhZGRyZXNzIHNwYWNlIGFuZCBpdHMgbGlzdGVuZXIuDQo+
Pg0KPj4gSW50cm9kdWNlIGEgdmZpb19kZXZpY2VfZ2V0X3Zpb21tdV9mbGFnc193YW50X25lc3Rp
bmcoKSBoZWxwZXIgdG8NCj5mYWNpbGl0YXRlDQo+PiB0aGlzIGltcGxlbWVudGF0aW9uLg0KPj4N
Cj4+IEl0IGlzIHNhZmUgdG8gZG8gc28gYmVjYXVzZSBhIHZJT01NVSB3aWxsIGJlIGFibGUgdG8g
ZmFpbCBpbg0KPnNldF9pb21tdV9kZXZpY2UoKQ0KPj4gY2FsbCwgaWYgc29tZXRoaW5nIGVsc2Ug
cmVsYXRlZCB0byB0aGUgVkZJTyBkZXZpY2Ugb3IgdklPTU1VIGlzbid0DQo+Y29tcGF0aWJsZS4N
Cj4+DQo+PiBTdWdnZXN0ZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4N
Cj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gUmV2
aWV3ZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4+IFJldmlld2Vk
LWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PiBSZXZpZXdlZC1ieTog
WWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9ody92Zmlv
L3ZmaW8tZGV2aWNlLmggfCAgMiArKw0KPj4gICBody92ZmlvL2RldmljZS5jICAgICAgICAgICAg
ICB8IDEyICsrKysrKysrKysrKw0KPj4gICBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICB8
ICA5ICsrKysrKysrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tZGV2aWNlLmggYi9pbmNsdWRl
L2h3L3ZmaW8vdmZpby1kZXZpY2UuaA0KPj4gaW5kZXggYTBiOGZjMmViNi4uNDhkMDBjN2JjNCAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWRldmljZS5oDQo+PiArKysgYi9p
bmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2UuaA0KPj4gQEAgLTI2Nyw2ICsyNjcsOCBAQCB2b2lk
IHZmaW9fZGV2aWNlX3ByZXBhcmUoVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+VkZJT0NvbnRhaW5l
ciAqYmNvbnRhaW5lciwNCj4+DQo+PiAgIHZvaWQgdmZpb19kZXZpY2VfdW5wcmVwYXJlKFZGSU9E
ZXZpY2UgKnZiYXNlZGV2KTsNCj4+DQo+PiArYm9vbCB2ZmlvX2RldmljZV9nZXRfdmlvbW11X2Zs
YWdzX3dhbnRfbmVzdGluZyhWRklPRGV2aWNlDQo+KnZiYXNlZGV2KTsNCj4+ICsNCj4+ICAgaW50
IHZmaW9fZGV2aWNlX2dldF9yZWdpb25faW5mbyhWRklPRGV2aWNlICp2YmFzZWRldiwgaW50IGlu
ZGV4LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2ZmlvX3Jl
Z2lvbl9pbmZvICoqaW5mbyk7DQo+PiAgIGludCB2ZmlvX2RldmljZV9nZXRfcmVnaW9uX2luZm9f
dHlwZShWRklPRGV2aWNlICp2YmFzZWRldiwgdWludDMyX3QNCj50eXBlLA0KPj4gZGlmZiAtLWdp
dCBhL2h3L3ZmaW8vZGV2aWNlLmMgYi9ody92ZmlvL2RldmljZS5jDQo+PiBpbmRleCA1ZWQzMTAz
ZTcyLi5iZTk0OTQ3NjIzIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9kZXZpY2UuYw0KPj4gKysr
IGIvaHcvdmZpby9kZXZpY2UuYw0KPj4gQEAgLTIzLDYgKzIzLDcgQEANCj4+DQo+PiAgICNpbmNs
dWRlICJody92ZmlvL3ZmaW8tZGV2aWNlLmgiDQo+PiAgICNpbmNsdWRlICJody92ZmlvL3BjaS5o
Ig0KPj4gKyNpbmNsdWRlICJody9pb21tdS5oIg0KPj4gICAjaW5jbHVkZSAiaHcvaHcuaCINCj4+
ICAgI2luY2x1ZGUgInRyYWNlLmgiDQo+PiAgICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+PiBA
QCAtNTIxLDYgKzUyMiwxNyBAQCB2b2lkIHZmaW9fZGV2aWNlX3VucHJlcGFyZShWRklPRGV2aWNl
DQo+KnZiYXNlZGV2KQ0KPj4gICAgICAgdmJhc2VkZXYtPmJjb250YWluZXIgPSBOVUxMOw0KPj4g
ICB9DQo+Pg0KPj4gK2Jvb2wgdmZpb19kZXZpY2VfZ2V0X3Zpb21tdV9mbGFnc193YW50X25lc3Rp
bmcoVkZJT0RldmljZQ0KPip2YmFzZWRldikNCj4+ICt7DQo+PiArICAgIFZGSU9QQ0lEZXZpY2Ug
KnZkZXYgPSB2ZmlvX3BjaV9mcm9tX3ZmaW9fZGV2aWNlKHZiYXNlZGV2KTsNCj4+ICsNCj4+ICsg
ICAgaWYgKHZkZXYpIHsNCj4+ICsgICAgICAgIHJldHVybiAhIShwY2lfZGV2aWNlX2dldF92aW9t
bXVfZmxhZ3MoJnZkZXYtPnBhcmVudF9vYmopICYNCj4NCj5Vc2luZyBQQ0lfREVWSUNFKHZkZXYp
IHdvdWxkIGJlIG1vcmUgYXBwcm9wcmlhdGUuIEl0IGNhbiBjb21lIGxhdGVyLg0KDQpZZXMsIHdp
bGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

