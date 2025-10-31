Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DEECCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEf4i-0002Si-3m; Thu, 30 Oct 2025 22:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vEf4b-0002SJ-Vy
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:41:06 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vEf4S-0001hB-8M
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761878457; x=1793414457;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nrFF4CNT6dL/o8K0KsRO0CODwqxovEpEVkNWI6wk0AU=;
 b=HfPGD7W6Iay7u1uHS3Lii1bU/xl6H8uiWYGIPG5a9MCPGTKR0v5zr+Jd
 VeuKf34ZHWBUfIKpMKAJsHWT+jxP14IwC71/OEzlcRIYDRFAmAuOeM5X6
 THdKqJy8PAjd/jPdZidskxEL1mLJ2BKxFbpxIeLmhETpGD1+dTiKFpagf
 Vcfxx7rKPlSl56sJ6zWBZn0Mw/5EPkoOCFqfZ7zAEs1Oks0q83Wzr7K+K
 H6xJJMPFEKpoPg+3Mz+uAUMUqOh8LU7iocYKMb3X8wTw0qoa/7aW8BAF0
 cAiP59BGpiFImiNc2dKyUOR+nvjN3Gry0rCZK3p5HQfYhNMu0dFLoWf1A Q==;
X-CSE-ConnectionGUID: YrCSrSQgTSWkuOakx013NA==
X-CSE-MsgGUID: b83rLFYARz22u7rjrbaMmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75151220"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; d="scan'208";a="75151220"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 19:40:37 -0700
X-CSE-ConnectionGUID: bPL/70xkTCCV0GveIXdoEA==
X-CSE-MsgGUID: bKUF4VruTJuEI9muO5f4gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; d="scan'208";a="185992646"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 19:40:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 19:40:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 19:40:35 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 19:40:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHgtc0LmqwdfJ6bZjgD2WT51WRjf82S7wAyKG865esymoiDlRgT/m4tC6CsJYyclVC50KSNok/1/YIuNMfKt3qT/QndKnfAd6OZBvmBGDyzsYZU8xRFQV5OrVi20iaQtgQxKS+RpkKaMLeiioxw5VHgy2Ao5G1etj034EVsOs87+JHXL9Pg+tq7MavwNpauKznOmTRpcUisW1k7PX+Fv19yvle+MxgIWUaXCzpC7Z3Kg5y0waBtfpL2uJDv/SoLKZ255vRVUEn2m3sK4zLIPOPNvQCDt9uOW98+dX+R1RWNTiLKnrejZVPKFo8WGjHLM3LQXAVzF9pyt1gUR0gnjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrFF4CNT6dL/o8K0KsRO0CODwqxovEpEVkNWI6wk0AU=;
 b=iE5yDyD/msojx2+IosQO8swm4wrQbkd5+kuTXvrGCiXyrggZwCWSKxRNPo9R5oyk5rkyeLn+LPEIP9BDVNkDNFnUOYwZDaUlBaP7gU2jIfosuoz7cvkxdtVS6szF5Ozzoklv691YkasKmyNRydw+gtJjLb17rNd9sGeYR6t8xXJwsP7+VwUXf9AchcjfzcTwkUueUmWRamNRojhEVA2mYqQDMGPGoRyuhCtvnmB0JW9RCmNKJGcmBut7MqQx0aTgUO+KrbyCcwo57Kl/gvt1mDqjNTVlTCfyzR0ql8OCAh6211dMvXqZdPvHoo/gD8bJwqAdJKkrLnY8Kn7980Mfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Fri, 31 Oct 2025 02:40:33 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 02:40:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, Avihai Horon <avihaih@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Hao, Xudong"
 <xudong.hao@intel.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van
 De Ven, Arjan" <arjan.van.de.ven@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4 08/10] vfio/migration: Fix a check on
 vbasedev->iommu_dirty_tracking
Thread-Topic: [PATCH v4 08/10] vfio/migration: Fix a check on
 vbasedev->iommu_dirty_tracking
Thread-Index: AQHcSLoYic5r0GqRiU2SGu5DZpxfKbTaWxAAgAADbcCAABzFAIAAKx3ggAANBwCAANapoA==
Date: Fri, 31 Oct 2025 02:40:32 +0000
Message-ID: <IA3PR11MB9136076989336A56CB3ED50192F8A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251029095354.56305-1-zhenzhong.duan@intel.com>
 <20251029095354.56305-9-zhenzhong.duan@intel.com>
 <eb2e5419-7a63-47be-adaf-e34709d8310f@nvidia.com>
 <IA3PR11MB913625D418E023D14D4ED0CF92FBA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <fbfe567f-c8d0-4342-a593-efe48d7050ad@oracle.com>
 <IA3PR11MB9136D46E2ADB556BBFA68A1792FBA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <d073c27d-1006-470b-b5ef-7d7e73a738bf@oracle.com>
In-Reply-To: <d073c27d-1006-470b-b5ef-7d7e73a738bf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB6043:EE_
x-ms-office365-filtering-correlation-id: 6936109b-8e7b-4347-67c2-08de1826dd1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Umd1dElrWDN3K2tobGNkM2FFMmk2b0FkLzEwc1kvZjZwYnM0amVUa1lsRVhE?=
 =?utf-8?B?Vnd6NU5BWTNkejZkdGV2clRHbXpmNVRwUkc3VXZLaXB5aEc4ald6cVBiK1VV?=
 =?utf-8?B?K29Ud3JMUTRESkdDakUwbnZCR2d1Q0hGSis5QnRIdWU3T3dOUnlsMHR0dk44?=
 =?utf-8?B?aWtLSStMcVJ1MUx2V0ZFcW15a3JzSWhKSkhGWVA2ZmhYOWJqaTBQQWxKMSsy?=
 =?utf-8?B?bEpDRTg2OHcyWjFUNGwyR2JTdkJtTlFBVEdReFJ2NkVkNThsOFZLdWRPSVlr?=
 =?utf-8?B?LzN0RGkvdnFEQ0YyWHhkVFNnRmpPMGRUVDVXaC9RcEpidCtHb3N0QkJ2cU5Z?=
 =?utf-8?B?MFNmSjAxNjdEVGFIZFBqSTM2Wk5HUFdWU3hheFJjY2lGV0xNQ2JxRVorazhW?=
 =?utf-8?B?VVoweHEyeXR1TjZ1ZlpwZHExMmo5OHp1TnkxK05rcWVuVEZpVW9nQnJEOEFs?=
 =?utf-8?B?dmlqaGRzRkxhTUdRZms2UXVTb3JqbGlhOTJPa1FZS2Eva2NtVnYzQllMNlhv?=
 =?utf-8?B?YVZ1QjRsbThvcmZ4VHhobjRZS2RxOFBrT3Z2YitNRXRMakJUQWtELzkvdTcz?=
 =?utf-8?B?ZXNmYjdPK2YvQ1V1L3lTYm1vZ3dPOUhIa0xzVmhrVGVVOHhSRXNDZVRzTmJz?=
 =?utf-8?B?TE5DWkMyRlhySXNJVTBsZ1ZITzVpOWVmUkpyayt6NFRpcyszZ2xkWWJqNnFn?=
 =?utf-8?B?NldFK0lkUXUrcmtaWTJocTNVREdnVzAydDU5aXBEYU4xWHRwOGZVYjM5cTFR?=
 =?utf-8?B?SGt4OElmd09WUDFEYjhEWUdkRlhKNFZJTUZUM212Y3pSMW1saGZ5QWxaczVS?=
 =?utf-8?B?TnU1Z01SWFlSZnQ0aWZzNk9Wa1FWT2VpYTlqT0E4Z3QyQ1JJOXBlYVIxN1hu?=
 =?utf-8?B?QUk2RjBycjNNZzZic1BYQ0xIbmNJcUFhUFRvejVlU3BVUGpPdzlFeFBPT3ZH?=
 =?utf-8?B?TmN2WHErSE1qQnJWWlh6bjFtMTRXTzhTSUo2K2ZubXZtV2Zzd2F3TkI0R1pX?=
 =?utf-8?B?OHNpWXBhL1B3NEErYTRnaHVFVjVhbmJDRjVnSzZnQjRIR09vMFhjSFlRTzAw?=
 =?utf-8?B?NFhZSWNvLzcwUVQyZHJPR25Qald2azVoTVIrdlJLejlsd2xHMEJEaFVod3FZ?=
 =?utf-8?B?eGMxTnp3b0VVRmhTRlhrKzJieVM1QUoxNytWRWluUEg3VnJWWXE5T3dHRXNO?=
 =?utf-8?B?YWtTMmkrTlJwUkd5OG1zRWYyQkwwN29lOENVWkFORTZValE3d1R0ckdRNmta?=
 =?utf-8?B?R3VKSjdNdnFNZk5JaXlWL3kwYW1RMThIZlp6ZUQ3d05PTlQ3ZmZjZmo1MUdI?=
 =?utf-8?B?eWhZNFhaS3kya09mUm1PVktaNVFkZ0g4L2M0ZVZiakJWZXB5V3FORTRkb3N3?=
 =?utf-8?B?OWlJcVQyRjkxMlpwc2Z0NjdVNWw0MjIxdHcxbjY2OXMyZklXb2Jrb3hBdEI3?=
 =?utf-8?B?STIyb2kwcnNnUlNRYzlmMm5FOERYQnNzSlkxWUJXU2Ywd0NGcmx4cHRWYVFB?=
 =?utf-8?B?bFN4UU8zNW93WlkzRFVWMjNtV3RXbGZjNDdyOHhidlZYL0pJaUgzSC80UFFK?=
 =?utf-8?B?azlHRXpHWVNsTXZreVovZFpZR0lwRGY3VG1RUmVXSU00NlI0c2pFcWZZN1JN?=
 =?utf-8?B?QTZGak5PeXRsNFMvdm1tbGNpS0FVWDVZSzZaOWplUjgwZDBwSFdDdHlvSTB4?=
 =?utf-8?B?RXZYZEtUaGl0WUh2US8yQXZKbWZDVnhobllXZ2xsZ2tkU2VKRlJPRUFIY3Zv?=
 =?utf-8?B?V2ZrTVcyVmZxUjdMckRRdkFYZ0ViZy94RENWL3cvczJ0MDByckdPdWcyRUUz?=
 =?utf-8?B?RGNnV0U5ZHRVN2xOdXQyUFhQM2dlRDlnUWY0TnZQdXBHcWM2SlpWcVdzTDQr?=
 =?utf-8?B?RVlXWlVoTkE3dFNUbUlHMmNqK0xGaGRwOENmSDZKL0plYmJZN3N1dE1vRnVw?=
 =?utf-8?B?aFRHRFU0NFdjRlR4SWsyUDRxVDlLQzQzRlNpang5L1BBZXZ6SWZBek81aUNy?=
 =?utf-8?B?b29vQnUrenJkL1lQRXNUQTA3Y3FxYWtiT2IxL1pCcnczVUZEY3N0clZUY1Zk?=
 =?utf-8?Q?rb2CuZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmpyN2tROEoyMWQ4aTIvR05NR0VJZlV0T1V2U1VFbkxMZzIxYVpqUWg5ZTVM?=
 =?utf-8?B?bUxKT3pnejZMSWcvTzJlMzF0K09CRDhLVFFhQkZHRTNIWXg5dTJOcmJiU0Y1?=
 =?utf-8?B?aEdjbWk1TElTMWx1Tk8vVXllTTkyUkJCU1pHREJCT3BvSlZtUjAvc0FGR2Ix?=
 =?utf-8?B?ZzdBSUpSQmlDQ2RWanl0QXFwaU00OWRuaTNvbzl1Z251YXRGSTQvM0dOYXB4?=
 =?utf-8?B?MDZjY21XWlh4NnBDUjh0WXFQWnBiY3BsLzA1dXg1aUpHQmcxMGtzWkVLd0wr?=
 =?utf-8?B?T3lHS1pXMmYzTURPdFh6bzR3NVBIdDA5ZnMwMW9BV1ViMk51TWZsM0lKVlE0?=
 =?utf-8?B?OHUxTWJlTDZWUHArUHZwN1JqRUJNdDJhQnZnQlFnQmFacVhtdjdPSnpwdTU4?=
 =?utf-8?B?Y0dOYTMzT09hcWZUaUNOMXcvemFsYzZJa2lRcy9uQk04RC9qV214MVRmVEhU?=
 =?utf-8?B?V3R4ZkRIa1NyMHhpWHNzMjQwWXBEa3J3anhxZWJ3UGdqQU1sMklxNWxFTmZC?=
 =?utf-8?B?OVhDdFlxSDFhNjdlaWRpMysvc0g5SXhTZ1ZyTTdQa1NQSzVhR1hITDBoMlY3?=
 =?utf-8?B?eEJTRjZvV1ZMYWJtT1k1UGJoTmNVS3NZVS9nckJPZy84cDJ2Nmg1Vm9CYkww?=
 =?utf-8?B?UU1kY2xIN3c3SHBZd1EwZTY3QzV6R1g1bFdWZUd1dHB0V3RXcW9HbDVmOHgw?=
 =?utf-8?B?eVIweFd1Vlpranc0UndmYXpXWkFnVi8wcWpFbHpuVXEwTkRSSUdIT28vV2dT?=
 =?utf-8?B?N0NvdDNBNXhaTnBpMkNlMDlrZXBKTnkzZ00yNXVyU3BVcWJiUjZiTE5peHoz?=
 =?utf-8?B?U1dpcXh0Ykg2RHVpQWFLM0hWSllmbHdoMUxNaXVRZUxscDR4a3M4Zi9NeVNJ?=
 =?utf-8?B?RXZkSTAyNEEzeHdjWXdHd0kyQ2dGQUpYQ3BXejRZeit2Ym1WTVVtQ3NVTnFk?=
 =?utf-8?B?SHF2M2NmSTNDZFVQRjkrbkZ0akxPa043Qm8yY3RHdWhQZmRTVzltUGMvakhr?=
 =?utf-8?B?bjdWUStGcGl2czY4RlJXd2ZNZit2Nk5COG1acTZNUCtSL1RnYm9VR2psbjFR?=
 =?utf-8?B?Y1d2VGs0T0V4MnpmUEJmbXMxWGpETDBkY1FZLzdUT24zckJOOTBOTDZtMDRQ?=
 =?utf-8?B?RmJvbEk4TEt3M1VMeUhpcktHM09kRjNQVFBkamliaVVERGtHQnJYdW02K2FS?=
 =?utf-8?B?L0tHQWF3Vk1lT3VCNGhMN29Ucng2amRTeWdSS0FhVjhWRU1vbU1qSForU3dQ?=
 =?utf-8?B?TDB2QjlXdWhPODFFMWxGR202RHAxQmJsL2NCUGJDcExDakxscWJURnhCUUNr?=
 =?utf-8?B?Y01HNmxwNjVRcmUwTmpxSlNqYkRBU1o1N3RNd2FBL016dE9RWUg2N2ROZmQz?=
 =?utf-8?B?dG04WWlXNDM5Vnowc0pPam1mRDREYXloN0Y0QmFFamNqY0ViMDNka254UTlK?=
 =?utf-8?B?UGw0eURVY1diZkRGb1UwWG9qcHZDWmRkNmxDUUhOYm9INVE0THBUZGxyMlZ6?=
 =?utf-8?B?OHU1OStVWWFKaEMycmpDb01iMHl0UWdhQmsybTdHOEY5TTFDWGVPS0sxWGJ0?=
 =?utf-8?B?SkE5UWdTK25sOUlOK0cwU2xFNjFuQUtyU3NLTHRERzdUaFR1MWlNbU5vMUJ0?=
 =?utf-8?B?MXdqeTNQY2Y1QnNySEVLMWdpeDJ4TTVic0RQc3FENGZvUC9FZytsa0lQTlUv?=
 =?utf-8?B?Y2hINnZlajVITVpSYW4zVTgwM00wNzVBd0F2bE9NK2VrQitUNXphV1VjcG1k?=
 =?utf-8?B?cDJRYUwxNlRqWS9EYytEVHpKK3hYem1WVGJJRTFBQkFyNHhqZEY5VEc5MlJo?=
 =?utf-8?B?aEh2N3FkZVF3TVJZVkVnR2JlUm1QMXhLZGROZG0vRkMzRVZodTBGM2lHZTRQ?=
 =?utf-8?B?YzZjU2FGcWFQbnhwVFVtQUJBbmw0Q2dobTdiTEFsaTJGYU9vOU80a1p0eEpK?=
 =?utf-8?B?SUYyYnpia28ybkdCNWRZT0IwQnRkU2FoT0J3MkFLZ1ptSmFrSlg4MUE1d1F0?=
 =?utf-8?B?Y1E5L1hicXFKaEtqcDgzR2c2VnpOQXBDQXdyeVUrU3FQTWQwcnZzdHFqWnI4?=
 =?utf-8?B?NUY0MzRTd2RiSzhoNkNDQUxYNno1OEtlWm8xMWVSZ2J6S3Jnd3U4YlVuVS9W?=
 =?utf-8?Q?17YbGG38KyCxg1OefROOB2IdI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6936109b-8e7b-4347-67c2-08de1826dd1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 02:40:33.0061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdqG8wLBcLnxKg/o17EH6K6FjpCJZQL5qYA899UrM6f92np85e3Xjmc/FudD9MXMzDvLZwoK2Xm8VH2sN0B6Ebiu46rfqNX3jMYGldG1/fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6043
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDA4LzEwXSB2
ZmlvL21pZ3JhdGlvbjogRml4IGEgY2hlY2sgb24NCj52YmFzZWRldi0+aW9tbXVfZGlydHlfdHJh
Y2tpbmcNCj4NCj5PbiAzMC8xMC8yMDI1IDEzOjA2LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBKb2FvIE1hcnRpbnMgPGpv
YW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwOC8x
MF0gdmZpby9taWdyYXRpb246IEZpeCBhIGNoZWNrIG9uDQo+Pj4gdmJhc2VkZXYtPmlvbW11X2Rp
cnR5X3RyYWNraW5nDQo+Pj4NCj4+PiBPbiAzMC8xMC8yMDI1IDA5OjEwLCBEdWFuLCBaaGVuemhv
bmcgd3JvdGU6DQo+Pj4+PiBGcm9tOiBBdmloYWkgSG9yb24gPGF2aWhhaWhAbnZpZGlhLmNvbT4N
Cj4+Pj4+IE9uIDI5LzEwLzIwMjUgMTE6NTMsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+Pj4N
Cj4+Pj4+IEJUVywgZG8geW91IGhhdmUgYSByZWFsIHByb2R1Y3Rpb24gdXNlIGNhc2UgZm9yIG1p
Z3JhdGlvbiB3aXRoIFZGSU8NCj4+Pj4+IElPTU1VIHR5cGUxIGRpcnR5IHRyYWNraW5nPyBJIG1l
YW4sIGlzIHRoZSBzY2VuYXJpbyB5b3UgZGVzY3JpYmVkIGluDQo+Pj4+PiBwYXRjaCAjNyBhIHJl
YWwgdXNlIGNhc2Ugb3IgeW91IGp1c3QgZml4ZWQgaXQgZm9yIGNvbXBsZXRlbmVzcz8NCj4+Pj4+
IElmIHRoZXJlIGlzIG5vIHVzZSBjYXNlLCBtYXliZSBwYXRjaCAjOSBpcyBub3QgcmVhbGx5IG5l
ZWRlZD8NCj4+Pj4NCj4+Pj4gcGF0Y2g3IGlzIGEgcmVhbCB1c2UgY2FzZSwgaW4gZ3Vlc3QsIHdl
IHN3aXRjaCBkZXZpY2UgZnJvbSBJT01NVSBkb21haW4NCj4+PiB0byBibG9jayBkb21haW4gYW5k
IHNlZSB0aGUgaXNzdWUuDQo+Pj4+IFdlIG5lZWQgdG8gc2VuZCBhY2N1cmF0ZSB1bm1hcCBub3Rp
ZmljYXRpb24gd2l0aCBhY3R1YWwgbWFwcGluZyBkdXJpbmcNCj4+PiBtaWdyYXRpb24sIGZvciBi
b3RoIGJhY2tlbmQuDQo+Pj4+DQo+Pj4NCj4+PiBJIHRoaW5rIHRoZSByZWFsIHF1ZXN0aW9uIGlz
IHdoeSB5b3UgYXJlIHVzaW5nIHR5cGUxIGJhY2tlbmQgb3ZlcmFsbCBmb3INCj4+PiBwdXJwb3Nl
cyBvZiBkaXJ0eSB0cmFja2luZy4NCj4+DQo+PiBKdXN0IGJlY2F1c2Ugd2UgaGFkIHNldCBiY29u
dGFpbmVyLT5kaXJ0eV9wYWdlc19zdXBwb3J0ZWQgPSB0cnVlLCB0aGUNCj5kaXJ0eSB0cmFja2lu
Zw0KPj4gYnkgcXVlcnkgdGhyb3VnaCBrZXJuZWwgVkZJTyB0eXBlMSBpbnRlcmZhY2UgaXMgdXNl
ZCBkdXJpbmcgbWlncmF0aW9uLCBldmVuDQo+dGhvdWdoIGl0J3MgJ3BlcnBlY3R1YWwnLg0KPj4N
Cj4NCj5SaWdodCBidXQgdGhhdCdzIHdoYXQgaW9tbXVfZGlydHlfdHJhY2tpbmcgaXMgZm9yLiBp
b21tdV9kaXJ0eV90cmFja2luZw0KPnNob3VsZA0KPm9ubHkgYmUgc2V0IGZvciBzb21ldGhpbmcg
dGhhdCBhY3R1YWxseSB1c2VzIElPTU1VIGZvciBkaXJ0eSB0cmFja2luZy4gQW5kDQo+dGhpcw0K
PnBhdGNoIGRvZXMgdGhlIG9wcG9zaXRlIG9mIHRoYXQuDQo+DQo+U2VlIGJlbG93IG9uIHRoZSBw
ZXJwZWN0dWFsIHBhcnQuDQo+DQo+Pj4NCj4+PiB0eXBlMSBkaXJ0eSB0cmFja2luZyBqdXN0IHJl
dHVybnMgZXZlcnl0aGluZyBpbiB0aGUgYml0bWFwIGFzIDFzLiBUaGVyZSdzIG5vDQo+Pj4gYWN0
dWFsIGRpcnR5IHRyYWNraW5nIGFuZCB3ZSB1c3VhbGx5IGNhbGwgJ3BlcnBlY3R1YWwnIGRpcnR5
IHRyYWNraW5nIGJlY2F1c2UNCj4+PiBldmVyeXRoaW5nIERNQSBtYXBwZWQgYXMgd3JpdGUgaXMg
YWx3YXlzIHJldHVybmVkIGFzIGRpcnR5IG5vIG1hdHRlcg0KPndoYXQNCj4+PiB5b3UNCj4+PiBk
by4gSXQgZG9lc24ndCBsb29rIGF0IHBhZ2V0YWJsZSBuZWl0aGVyIGZvciB0aGUgdW5tYXAgZ2V0
IGRpcnR5Lg0KPj4+DQo+Pj4gSXQncyBvbmx5IChrbm93bikgdXNlIGhhcyBiZWVuIGZvciB0ZXN0
aW5nIChpbiB0aGUgbGFjayBvZiBJT01NVSBIVyArDQo+Pj4gSU9NTVVGRCkNCj4+DQo+PiBZb3Ug
bWVhbiB0ZXN0aW5nIGxpdmUgbWlncmF0aW9uIG9yIHRoZSBsZWdhY3kgVkZJTyB0eXBlMSBkaXJ0
eSB0cmFja2luZw0KPmludGVyZmFjZT8NCj4+IElmIHlvdSBtZWFuIHRoZSBmaXJzdCwgd2UgY2Fu
IGZvcmNlIGVuYWJsZSBpdCB3aXRoICdlbmFibGUtbWlncmF0aW9uPW9uJyBhbmQNCj5zZXQNCj4+
IGJjb250YWluZXItPmRpcnR5X3BhZ2VzX3N1cHBvcnRlZCA9IGZhbHNlLg0KPj4NCj4NCj5JJ20g
YXdhcmUuIEkgbWVhbnQgdGVzdGluZyBvZiBkaXJ0eV9wYWdlc19zdXBwb3J0ZWQgY29kZSBwYXRo
IGJlZm9yZQ0KPklPTU1VRkQNCj5leGlzdGVkLCBvciBpbiB0aGUgbGFjayBvZiBJT01NVSBoYXJk
d2FyZS4NCj4NCj4+Pg0KPj4+IEJ1dCByZWFkaW5nIHlvdXIgc3RhdGVtZW50IGluIGEgZGlmZmVy
ZW50IHdheTogeW91IGFyZSBzYXlpbmcgdGhhdCB5b3UgdXNlDQo+Pj4gKnR3byoNCj4+PiBiYWNr
ZW5kcyBhdCB0aGUgc2FtZSB0aW1lPyBXaHkgd291bGQgeW91IGRvIHRoYXQ/DQo+Pg0KPj4gSSBt
ZWFuIHBhdGNoNyBpcyBuZWVkZWQgbm8gbWF0dGVyIGxlZ2FjeSBiYWNrZW5kIG9yIElPTU1VRkQg
YmFja2VuZC4NCj4+DQo+PiBidHc6IHdlIGRvIHN1cHBvcnQgYSBxZW11IGNtZGxpbmUgd2l0aCBt
aXhlZCBiYWNrZW5kLCBlLmcuLCB0d28gZGV2aWNlcywNCj4+IG9uZSBiYWNrZWQgYnkgbGVnYWN5
IGJhY2tlbmQgYW5kIHRoZSBvdGhlciBiYWNrZWQgYnkgSU9NTVVGRC4gQnV0IEknbQ0KPm5vdCBt
ZWFuIHRoYXQuDQo+cGF0Y2ggNyBJIGRvbid0IGRpc2FncmVlLiBCdXQgdGhpcyBwYXRoIDggZG9l
c24ndCBtYWtlIHNlbnNlLCBhbmQgaXQncyBub3QNCj5maXhpbmcgYW55dGhpbmcgYnV0IHJhdGhl
ciBpbnRyb2R1Y2luZyB3cm9uZyBiZWhhdmlvciBJIHRoaW5rIChhbHNvIHRoZSBGaXhlczoNCj53
b3VpbGQgYmUgd3JvbmcgaWYgeW91J3JlIGNvZGUgaXMgc2V0dGluZyBpb21tdV9kaXJ0eV90cmFj
a2luZykuIEl0IGlzIHNldHRpbmcNCj5pb21tdV9kaXJ0eV90cmFja2luZyBvbiBzb21ldGhpbmcg
dGhhdCBkb2VzIG5vdCBhbnl0aGluZyBpb21tdSBkaXJ0eQ0KPnRyYWNraW5nDQo+cmVsYXRlZC4g
Rm9yIHR5cGUxIGNvbnRhaW5lciBpdCBzaG91bGQgYmUgZmFsc2UuDQo+DQo+aW9tbXUgZGlydHkg
dHJhY2tpbmcgaXMgcHVycG9zZWRseSB0aGVyZSB0byBtYWtlIHRoZSBkaXN0aW5jdCBkaWZmZXJl
bmNlIHRoYXQNCj50eXBlMSBkaXJ0eSB0cmFja2luZyBpcyAqbm90KiBhY3R1YWwgSU9NTVUgZGly
dHkgdHJhY2tpbmcuIEFuZCB0aGF0IHRoZQ0KPm1pZ3JhdGlvbiAqb25seSogZ29lcy9pcy1hbGxv
d2VkIGF1dG9tYXRpY2FsbHkgaWYgZWl0aGVyIHlvdSBoYXZlIGRldmljZSBkaXJ0eQ0KPnBhZ2Ug
dHJhY2tpbmcgb3IgSU9NTVUgZGlydHkgdHJhY2tpbmcsIGJ1dCBub3Qgb24gdHlwZTEgbGVnYWN5
IGRpcnR5DQo+dHJhY2tpbmcgLi4NCj51bmxlc3MgeW91IGZvcmNlIGl0ICh3aXRoIGVuYWJsZS1t
aWdyYXRpb249b24pLg0KPg0KPkltYWdpbmUgdHlwZTEgZGlydHkgdHJhY2tpbmcgYWN0dWFsbHkg
Z2V0dGluZyB0cmVhdGVkIGxpa2UNCj5pb21tdV9kaXJ0eV90cmFja2luZzoNCj5pdCBtZWFucyB5
b3UgYXJlIHRlbGxpbmcgdXNlcnMgdGhhdCAxVEIgZ3Vlc3RzIG1pZ3JhdGlvbiB3aXRoIFZGcyB0
aGF0IGRvbid0DQo+aGF2ZSBkZXZpY2UgZGlydHkgdHJhY2tpbmcgd2l0aG91dCBJT01NVSBIVyBj
YW4gYmUgbWlncmF0ZWQgKmJ5IGRlZmF1bHQqLg0KPkFuZCBpbg0KPnByYXRpY2UgdGhhdCBtZWFu
cyB0aGV5IHRyYW5zZmVyIDFUQiBvZiBSQU0gZHVyaW5nIHN0b3AtY29weS4gQW5kIGhhdmUNCj50
aGVtIGxpa2UNCj4xbWluIGRvd250aW1lLg0KDQpDbGVhciwgc28gaXQncyBpbnRlbnRpb25hbCB0
byBoYXZlIGRpcnR5X3BhZ2VzX3N1cHBvcnRlZCA9IHRydWUgYW5kDQppb21tdSBkaXJ0eSB0cmFj
a2luZyA9IGZhbHNlIGZvciBsZWdhY3kgYmFja2VuZCwgSSdsbCBkcm9wIHRoaXMgcGF0Y2guDQpU
aGFuayB5b3UgYWxsLg0KDQpCUnMsDQpaaGVuemhvbmcNCg==

