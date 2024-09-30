Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8807CF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 03:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sv7Ji-0007Lx-1r; Sun, 29 Sep 2024 23:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sv7Jg-0007LQ-6e
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 23:43:20 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sv7Jd-0007LR-VJ
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 23:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727667798; x=1759203798;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TO3FzevPvEKIYg8cne7gXNKChM4VobIjZfFGsUPVgcw=;
 b=fnezm5w7FSUhJ0KrjJ3mQurXaLReikgsAGWU1AwU/kSv7Ek09tSd9lK6
 2KQWa7M7I4DZcWzXKoQOrq0IDMIfH3SnnXiuhmV4MpRCxGXy0TwJxGT3t
 pNKuFZLStXBmNH6R9RqhAeelMrSrP2gLuKQZt0bHH+I4u4cy0A9BH0KH4
 Tno4MUxgT0PEqudzbIRl1VsGTxhRzQGvLvTmuOj+j4Oiv/gEhgLaWPi7W
 QTlg64PWY8FCUfmJHL5K3oN/ieoR6W1V/jkWwi+tHWB51p3R3bR9AvrXB
 5ihF1SzY6M0EyOiDyIbivvHV3ERWq7jvNlN76/3rjE+DsbmTxhJyd+QCY g==;
X-CSE-ConnectionGUID: Tkd0CvdZSE2uZlOMj5/VsQ==
X-CSE-MsgGUID: LXsx1kB3SMyETfmNgueFcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="52150910"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; d="scan'208";a="52150910"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2024 20:43:13 -0700
X-CSE-ConnectionGUID: eyro+KIPR+WEdtGfDOEg2w==
X-CSE-MsgGUID: scHVEEm3TM63IIzXDMCAdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; d="scan'208";a="110642141"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Sep 2024 20:43:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 20:43:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 20:43:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 20:43:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 20:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlLiRC1Tco/8Xps7F6YkzTkLlb3Fdzc45Ku2jlDrN5DR3exCLOqePivlhQK80sJCA2Oavu9eyQAjZ3nstLnMEk5FqpbEx9ekRtZXpjyiYjbT3kIN0pGWvUy5M5z/+uug1bKEOYlLYFmemnrj2upfS9QPi1qkPuhHlOz1EXq+X1mXCp23eCat4CDHHNnXXfrWl37ysapHWi4R5G97L7X5ju1Tn9TU0N4D8l4bW9GhrabBcUpNtIR1ctwUDBR29lq46+Zlb2Vv2yaSmtwHYXLHogJnR9eZTGloZXv8lFrO6kbXy99QX/qkmG8PH/C63NIhiHcO0d/HqsA/g4TS0pLQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO3FzevPvEKIYg8cne7gXNKChM4VobIjZfFGsUPVgcw=;
 b=ovaGP8vlk7Lb5F229gaZa/Jp/tJBxlsPUnE3bBC1Jelz2iARkQB+Ki19k5qlZdwhooEuuLuHFV99ffeSn/vq45lGpMUJtrLDLBnWqIzQdnHf3eSnnxR+HBmbtia8tycWUiLP4LPKrXkVpblwJLPxsMe2icjK1jsciwf5d5jgXGGfL/weLZs8lM2G2KoCuE8lJvWCs6uTUnySUIKiGairjRDga20zPuE6X7jZOO9VT0creaw6O2vKNHcQ6S1vNon9o3YL8iQQbYbjX0nPe5ol6rbmhPtGub2nxDT2+bGjJLTcMwOdwuEopvnCGY/932IA00lsgCWmmSxqvrjT3XCjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 03:43:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 03:43:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 05/17] intel_iommu: Rename slpte to pte
Thread-Topic: [PATCH v3 05/17] intel_iommu: Rename slpte to pte
Thread-Index: AQHbBAskZGeplGUCD0Ww1hJq1GJqCbJu0jEAgAD4oeA=
Date: Mon, 30 Sep 2024 03:43:09 +0000
Message-ID: <SJ0PR11MB67446A0C7ED440B64ABC1BF492762@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-6-zhenzhong.duan@intel.com>
 <2832359e-9e9d-4407-a105-0a24cdf31e00@intel.com>
In-Reply-To: <2832359e-9e9d-4407-a105-0a24cdf31e00@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB5965:EE_
x-ms-office365-filtering-correlation-id: ad35a5fe-90e7-4a39-f95f-08dce102008a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ODBwQkVYdWNObmUyV04xNUkwWk1kWitXNUN5Z2RUaCtjaU5kT01ETFIzV3h6?=
 =?utf-8?B?MDFpdzNnY3dheTVkYlBDUUpaa2pBVDNQeWx3NmZ6NEIvNkxOcCtyUEd1R3h3?=
 =?utf-8?B?OGlIVlM3Z2gzaE1BUTd4M3B5bFVRQXlyK05RSmVCeU5zbUlQZE1rNXRReFFt?=
 =?utf-8?B?TEJGMi9uaGp5eFo2RVlMV1dOQVFxdmVHR0NsWVEvc2tacjEveWwxZXQvREda?=
 =?utf-8?B?dGh5bG1wVVhJellFYzZvWlFKejkxUnNpUzdGVnFUb1VmdS9VTHE2eGVOOW9I?=
 =?utf-8?B?Ynd1bkVVcDFGOGJtZzUrOE15NCtCb1hvbXVvZEVMbG83U1N2U1YyUWR1elBt?=
 =?utf-8?B?bmlTVEcxMGhwV1ZFR1Z6ZkRRTWRweW5ZT0ZkTTdKVjlacXJuaUcrTVhvdVM2?=
 =?utf-8?B?VTg1NDY2cEszYjR0VGtGY0c0dkwwUU91VXdtRURtNnhPNCtBSHFiME5SZWIr?=
 =?utf-8?B?N1FjRFZ3Q21ON2ZXeDBTT3JwU1E4S1EveHNpdnhyU3Z4anNudFU5TFFacllY?=
 =?utf-8?B?SFJwd01qWWpIM1VyaW9JOCt1a2EyU1A3eTQvSEFtcWZlNUhBb2FJb3daSzJR?=
 =?utf-8?B?cjltRzJsUmh3cExldEs0clBCZjV5ZnBSSGt6WVZWcTBFTTJNM1E2N2FGaXVJ?=
 =?utf-8?B?ZUprcmk3Y2drT0FaNzBzNmd1ZzB2R3ZYUTNpTUVycHZKTHErQWlDbi9PYmFI?=
 =?utf-8?B?Smdta2tDVzBFM2I4TStEL3M1OElMNlZrcktvSzZmNzltbkFwSWhYSUsxTjJ1?=
 =?utf-8?B?eVlVdElQdGlwdjhJWW91R0ZJL2FqNUcxbFdaVENLM3JYZStES3FVWXFUZ3hE?=
 =?utf-8?B?dG8vTExRTXllVHd3a1VvUGtRV3N4ZTJPOTZMNkcwUjNHUWpHTHJtRStKT1Ri?=
 =?utf-8?B?TW9nQ1l4OGlraE90dU5hcDlyVWgrdDloRWN6cDFFdEVqZUduNVV3M1FRL0d3?=
 =?utf-8?B?OSt1aVhnaUFBMnpMZ0gzMDNRRkxWRGRrQitrYTZLeTY3cCtVSEVPVnN0Ym5l?=
 =?utf-8?B?MXVPZGp4czlXd3RhMHZ1dWlJNVhjTUxuVkF5aml1Q2h5QlMzSVlSM2JDNkd6?=
 =?utf-8?B?OUN0eG1iS1ZwY2xTS1F3dy96dUpOTkw0RWpPeTVBcmc1bmNHV2RaQWRMM2NG?=
 =?utf-8?B?V0hNZEdRWjg5UUJ0MDNlSU1aUU5mcmNOa2V4K1h1VSszbzZFbWJTZytTcFRN?=
 =?utf-8?B?eUVpVHhqaFdrMEI2Rk9lc1VwZWNPWWlid1dhVmxnWk1pNjhhb0o2Y1F1RkxN?=
 =?utf-8?B?UU5wUUpGRTNndHQ1WEpCa0gxTGc5U1RwckJWK2VoRDB5RUdPdVU0NVFvaGhu?=
 =?utf-8?B?dEhZazdjQ3Z6c2pzdXNkVmROVVk3NDBUbHZmamJjc3VwMDhxN3lBZ1UyYUNN?=
 =?utf-8?B?SUUzcXQ1eDZWUWpNRFk0cGhLZ1ltQUYxRHFXeno2R1U3dHl0bEpDcjlzalJj?=
 =?utf-8?B?aEtUV1U4a0RpS21LMmpKWC9HdzFkNVcrczdMckJMd1EwczYzNFBya1JTT1lx?=
 =?utf-8?B?bkRzeDZ5dnp0dGFGMDY5a1k5TzBESFVmeFFjMnhRU2JhdjNoUS8wZy9IbDNL?=
 =?utf-8?B?ZG4xckY1NHMxNWJncnkyYjdPK1JUUEpMVXBOMzYzc0hiV0dtWWZORElCMlJ4?=
 =?utf-8?B?VXFBVURJbjBmSWRoMzR3Sk5UQTRWUUwxUlNNdGhxWVpwZHovcFV5SEZpUW4y?=
 =?utf-8?B?Vnl1endCdUwzbTJSZ1ZXY3ZHeG4vRnR0UzlxL1ZiTFduWlY5djhkblhxVkJx?=
 =?utf-8?B?TU1BeCtXUHlZazhhR1BmNFpGajVTMmwzekVUV1RYa3hWK0t1dFlsV003eDg2?=
 =?utf-8?B?RGN1ellXRmhUanl2VDd6RTZ3enh5OHRtSjR1UjVUYURlOHhpS2ZOc2U1RC9V?=
 =?utf-8?B?bFRJckFiSFFwS0VxN3hkNFowUWpxZGpFMDBRaG93dDZzQnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTFkUkh6VGM1RjJNMVB3QTNEeVYyS3dFQmk2a1lJL0Y3ZUxnNnJ6cGs1NWc3?=
 =?utf-8?B?c3c2eG5xRExIaC9HRjlubDNPdnAveDJOSkNsZ0hVZ1Q5cnJJNTg0VDIyaXJW?=
 =?utf-8?B?cFZKZlA4d1FMQkJRMEE0MjgxeUJZRHJOcjBIWmNUY0pDdmkrM1NyVFQvSmpN?=
 =?utf-8?B?NEZacWZQUDJKaEprSlZWTlQ0eWJiNXJ5Wi8rSFdTNG5JRjlBV2h0TTB6eWE3?=
 =?utf-8?B?c3FzUENRc2hEdy9UNWxGNFFqdnBKZUJtSSsyM2JhZVpObThuOXRVdVZNS0dI?=
 =?utf-8?B?VVpqanlsV1p2eEMzZlkrenIzd0I5UzlHZFFIN0VncjA3TVNMTTAxa2VKV095?=
 =?utf-8?B?UTgxTUFwN0xSZnZaa2dvSDN1cGFKQ1dlWi90QWhxcG5taDRZWXVXMTkvLzZP?=
 =?utf-8?B?WUFzUHg4T2ZJd1ZacVRiWC9Sb2ZqUThqT1Jyc3BpUTJXVElLYVU0V3p0Z3Nz?=
 =?utf-8?B?QTdSNG5HdTM0UVlQWGI1SW51WHZPcUEyMGcwM2w5VmlOb3VKZGhZS2Fjemlw?=
 =?utf-8?B?bVFiR3MrMmtYYzJza2hHK0lsMEwxSXhRS0NsOGw1RFlxb21Ua0tLVDVOSUt4?=
 =?utf-8?B?VjdrUUhCRFc0clFieEEwUWxTYll5QW11WkV3aE1VRTU0eHM0UlVtUzFmaW4y?=
 =?utf-8?B?VE4rU29CS0IzNXhtaDhpOXVQakhqcDZ3VnhzZUZLdXZQdjVtRGZnc2d3QXY0?=
 =?utf-8?B?R3cyQmFjbVBQYTBTZXd6K3hWRW1lSzduZlNEbHFQTE9QY3VxalhKWFRwR1ox?=
 =?utf-8?B?VzdOb2tTRXNGZlVRM1ZHOUVJNzZHVS9GRkZqdWlvb2RlNUpjSjhuUkJzRXR3?=
 =?utf-8?B?eWtnN1puVEd4ZEdiRHRQYVZJdW1BZGZBeVBteXM3Umx3QWlpUUw1THQyTzda?=
 =?utf-8?B?UGpHVHppK1I1MGVqVXNhMkJHdHFiYmYvU0l6Z3d2blZYazRxRSszY01Pa1Z4?=
 =?utf-8?B?NUNyeXIzSjhUVE5vVW9JQ28xcFgrYlE3N044cmNRek5RWnJtaG1aVjBvRmFx?=
 =?utf-8?B?U3RSMjFITkcrVUVzYThUQXRNRnV4OWVIOVRtOXY0d3Qxb2RQTzRia1RWeWQr?=
 =?utf-8?B?bENXeERMTUwzbTgyUWF6VTNwcEtZNXZUSDBMeGhzNk5TeVp6ZDBRS01xbGw5?=
 =?utf-8?B?bSt0Y0JpNVVRbU5JTWRNSVFzY3g5bmhCK2lRSzZNTUdEY0prN1h3cDZRNHRF?=
 =?utf-8?B?c3g5NWVvK0YyRUNHdGV3WXd5dkVVa0RZYjNMUVo0T2tKWGhRdXlEYjNZTEZS?=
 =?utf-8?B?Q2pMRXpjTzJlNXJkMWFNNkhCdDB5aUl0Zld6dHNzemJJQ3FwUElQQnQ1MVBs?=
 =?utf-8?B?ME5JOGxhVWlvdUFhbWJrZndReU56Lzg2a011ZXphK2x6YkJyMm1mWXRwM1Rs?=
 =?utf-8?B?NVUxSFNQS3gxcG5CTGZCc3NoRmR6Um1zdDJUTWtQZlJWOE1lbFNsSUZUNDFX?=
 =?utf-8?B?NWdrMzR2SjlXSmM5blM5aE1FeFFKMzB3NGY0UlhZTzNIOHRUVGhMMnBTMWc2?=
 =?utf-8?B?TUFOU1hOUzB2SnZEUGt1TXJNclVFQXNpSDRLbTVyOGVJWFFHRDlnUDAzVnFM?=
 =?utf-8?B?QXZCdEFEMElqZFExUjB3RTZvS0JwRjBsdGpKMHNIZVd1dDlTaEtkdlJBc29T?=
 =?utf-8?B?NTVRVFZVT0JiYlo3cWxxSDhmbFJTMHhYL1ZqWE1sUmljMG5qbno2bmtJTzZP?=
 =?utf-8?B?TlFMdVkxTFVMcEhhNkVmQVBsT2dUN1FwNktpeWxVbSs2UFJMeXE3ekdVeXEx?=
 =?utf-8?B?aXFqdy9Lbyt6TGVEd2RGQm82WDkxRkVFZk5VZ3QzWXFzejl6L2QvRVlnOUdV?=
 =?utf-8?B?dXZ2eVA0RHNkUHEvMmVLM1J5TEw4SHhrQTF3Sk9wT25RUWF0Ykt6cVdpU3By?=
 =?utf-8?B?TGlXNEQzMkZuRXdWK1VMVEY4UGJ3dzFvclEwU1lraFdvY25ha1pLN0NpWGdJ?=
 =?utf-8?B?cW91aHJSSVBFbDF2ZUVna3Nja01ha2ZRNk9IWUI1TCs3MlM1bWR5eFJUeTlS?=
 =?utf-8?B?R1dBU0tweEhsejVpczFDODdUVDZ0SVZuZFZ5SkhiS3VPU3M3V1RpNnVjS0Qy?=
 =?utf-8?B?aTZidFlLb2swZkZyNnRmLzBTbzFReWJjeDdPdXpmWjlVbkNEcDRDeG9JUlRL?=
 =?utf-8?Q?xdpU5wf04BFTF8pY4pGqynIFC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad35a5fe-90e7-4a39-f95f-08dce102008a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 03:43:09.4881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhgn3qyIaq1Vq0UsPQ2N1+aPw7vCy1QRp7h9wDaX6y/RXJ/r1SbjyQmTn94O7K1wbIC2kaCi7cTOPAQQyOTZmUygZx0HnZWFPrjXRl9UP98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDUvMTddIGludGVsX2lvbW11
OiBSZW5hbWUgc2xwdGUgdG8gcHRlDQo+DQo+T24gMjAyNC85LzExIDEzOjIyLCBaaGVuemhvbmcg
RHVhbiB3cm90ZToNCj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KLi4uDQo+
PiBAQCAtMTkxOCwxMyArMTkxOSwxMyBAQCBzdGF0aWMgYm9vbA0KPnZ0ZF9kb19pb21tdV90cmFu
c2xhdGUoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsIFBDSUJ1cyAqYnVzLA0KPj4NCj4+ICAgICAg
IGNjX2VudHJ5ID0gJnZ0ZF9hcy0+Y29udGV4dF9jYWNoZV9lbnRyeTsNCj4+DQo+PiAtICAgIC8q
IFRyeSB0byBmZXRjaCBzbHB0ZSBmb3JtIElPVExCLCB3ZSBkb24ndCBuZWVkIFJJRDJQQVNJRCBs
b2dpYyAqLw0KPj4gKyAgICAvKiBUcnkgdG8gZmV0Y2ggcHRlIGZvcm0gSU9UTEIsIHdlIGRvbid0
IG5lZWQgUklEMlBBU0lEIGxvZ2ljICovDQo+DQo+cy9mb3JtL2Zyb20vDQoNCldpbGwgZml4Lg0K
DQo+DQo+PiAgICAgICBpZiAoIXJpZDJwYXNpZCkgew0KPj4gICAgICAgICAgIGlvdGxiX2VudHJ5
ID0gdnRkX2xvb2t1cF9pb3RsYihzLCBzb3VyY2VfaWQsIHBhc2lkLCBhZGRyKTsNCj4+ICAgICAg
ICAgICBpZiAoaW90bGJfZW50cnkpIHsNCj4+IC0gICAgICAgICAgICB0cmFjZV92dGRfaW90bGJf
cGFnZV9oaXQoc291cmNlX2lkLCBhZGRyLCBpb3RsYl9lbnRyeS0+c2xwdGUsDQo+PiArICAgICAg
ICAgICAgdHJhY2VfdnRkX2lvdGxiX3BhZ2VfaGl0KHNvdXJjZV9pZCwgYWRkciwgaW90bGJfZW50
cnktPnB0ZSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvdGxi
X2VudHJ5LT5kb21haW5faWQpOw0KPj4gLSAgICAgICAgICAgIHNscHRlID0gaW90bGJfZW50cnkt
PnNscHRlOw0KPj4gKyAgICAgICAgICAgIHB0ZSA9IGlvdGxiX2VudHJ5LT5wdGU7DQo+PiAgICAg
ICAgICAgICAgIGFjY2Vzc19mbGFncyA9IGlvdGxiX2VudHJ5LT5hY2Nlc3NfZmxhZ3M7DQo+PiAg
ICAgICAgICAgICAgIHBhZ2VfbWFzayA9IGlvdGxiX2VudHJ5LT5tYXNrOw0KPj4gICAgICAgICAg
ICAgICBnb3RvIG91dDsNCj4+IEBAIC0xOTk2LDIwICsxOTk3LDIwIEBAIHN0YXRpYyBib29sDQo+
dnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpi
dXMsDQo+PiAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAgICAgICB9DQo+Pg0KPj4gLSAgICAv
KiBUcnkgdG8gZmV0Y2ggc2xwdGUgZm9ybSBJT1RMQiBmb3IgUklEMlBBU0lEIHNsb3cgcGF0aCAq
Lw0KPj4gKyAgICAvKiBUcnkgdG8gZmV0Y2ggcHRlIGZvcm0gSU9UTEIgZm9yIFJJRDJQQVNJRCBz
bG93IHBhdGggKi8NCj4NCj5zL2Zvcm0vZnJvbS8uIG90aGVyd2lzZSwgbG9va3MgZ29vZCB0byBt
ZS4NCg0KV2lsbCBmaXguDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj5SZXZpZXdlZC1ieTog
WWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+DQo+PiAgICAgICBpZiAocmlkMnBhc2lkKSB7
DQo+PiAgICAgICAgICAgaW90bGJfZW50cnkgPSB2dGRfbG9va3VwX2lvdGxiKHMsIHNvdXJjZV9p
ZCwgcGFzaWQsIGFkZHIpOw0KPj4gICAgICAgICAgIGlmIChpb3RsYl9lbnRyeSkgew0KPj4gLSAg
ICAgICAgICAgIHRyYWNlX3Z0ZF9pb3RsYl9wYWdlX2hpdChzb3VyY2VfaWQsIGFkZHIsIGlvdGxi
X2VudHJ5LT5zbHB0ZSwNCj4+ICsgICAgICAgICAgICB0cmFjZV92dGRfaW90bGJfcGFnZV9oaXQo
c291cmNlX2lkLCBhZGRyLCBpb3RsYl9lbnRyeS0+cHRlLA0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW90bGJfZW50cnktPmRvbWFpbl9pZCk7DQo+PiAtICAgICAg
ICAgICAgc2xwdGUgPSBpb3RsYl9lbnRyeS0+c2xwdGU7DQo+PiArICAgICAgICAgICAgcHRlID0g
aW90bGJfZW50cnktPnB0ZTsNCj4+ICAgICAgICAgICAgICAgYWNjZXNzX2ZsYWdzID0gaW90bGJf
ZW50cnktPmFjY2Vzc19mbGFnczsNCj4+ICAgICAgICAgICAgICAgcGFnZV9tYXNrID0gaW90bGJf
ZW50cnktPm1hc2s7DQo+PiAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4gICAgICAgICAgIH0N
Cj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIHJldF9mciA9IHZ0ZF9pb3ZhX3RvX3NscHRlKHMsICZj
ZSwgYWRkciwgaXNfd3JpdGUsICZzbHB0ZSwgJmxldmVsLA0KPj4gKyAgICByZXRfZnIgPSB2dGRf
aW92YV90b19zbHB0ZShzLCAmY2UsIGFkZHIsIGlzX3dyaXRlLCAmcHRlLCAmbGV2ZWwsDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcmVhZHMsICZ3cml0ZXMsIHMtPmF3X2Jp
dHMsIHBhc2lkKTsNCj4+ICAgICAgIGlmIChyZXRfZnIpIHsNCj4+ICAgICAgICAgICB2dGRfcmVw
b3J0X2ZhdWx0KHMsIC1yZXRfZnIsIGlzX2ZwZF9zZXQsIHNvdXJjZV9pZCwNCj4+IEBAIC0yMDE3
LDE0ICsyMDE4LDE0IEBAIHN0YXRpYyBib29sDQo+dnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERB
ZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQo+PiAgICAgICAgICAgZ290byBlcnJv
cjsNCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIHBhZ2VfbWFzayA9IHZ0ZF9zbHB0X2xldmVsX3Bh
Z2VfbWFzayhsZXZlbCk7DQo+PiArICAgIHBhZ2VfbWFzayA9IHZ0ZF9wdF9sZXZlbF9wYWdlX21h
c2sobGV2ZWwpOw0KPj4gICAgICAgYWNjZXNzX2ZsYWdzID0gSU9NTVVfQUNDRVNTX0ZMQUcocmVh
ZHMsIHdyaXRlcyk7DQo+PiAgICAgICB2dGRfdXBkYXRlX2lvdGxiKHMsIHNvdXJjZV9pZCwgdnRk
X2dldF9kb21haW5faWQocywgJmNlLCBwYXNpZCksDQo+PiAtICAgICAgICAgICAgICAgICAgICAg
YWRkciwgc2xwdGUsIGFjY2Vzc19mbGFncywgbGV2ZWwsIHBhc2lkKTsNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICBhZGRyLCBwdGUsIGFjY2Vzc19mbGFncywgbGV2ZWwsIHBhc2lkKTsNCj4+ICAg
b3V0Og0KPj4gICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+ICAgICAgIGVudHJ5LT5pb3Zh
ID0gYWRkciAmIHBhZ2VfbWFzazsNCj4+IC0gICAgZW50cnktPnRyYW5zbGF0ZWRfYWRkciA9IHZ0
ZF9nZXRfc2xwdGVfYWRkcihzbHB0ZSwgcy0+YXdfYml0cykgJg0KPnBhZ2VfbWFzazsNCj4+ICsg
ICAgZW50cnktPnRyYW5zbGF0ZWRfYWRkciA9IHZ0ZF9nZXRfcHRlX2FkZHIocHRlLCBzLT5hd19i
aXRzKSAmDQo+cGFnZV9tYXNrOw0KPj4gICAgICAgZW50cnktPmFkZHJfbWFzayA9IH5wYWdlX21h
c2s7DQo+PiAgICAgICBlbnRyeS0+cGVybSA9IGFjY2Vzc19mbGFnczsNCj4+ICAgICAgIHJldHVy
biB0cnVlOw0KPg0KPi0tDQo+UmVnYXJkcywNCj5ZaSBMaXUNCg==

