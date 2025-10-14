Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6684DCCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 05:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Y1I-0008Jl-M5; Tue, 14 Oct 2025 01:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8Y1G-0008JL-59
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:56:22 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8Y1D-0001Pl-IX
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760421379; x=1791957379;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZEGawx4MDPTXFfZhk1vA36tm5Q2g9Tff1KQwg92HQnM=;
 b=dqzxjA3ShqU3QNYDGiIk4DpuPBejt/+U8oM/lER2C3Dexb4kKxQlo0u7
 QzZZUG6VOTY0JCCHqdz+FcXLOXrDOumPtc0/KtSZTLnMlHhd+4eO0SVfJ
 PTpt48QRb/xNodN8NrhSYpwe+Sy8SQM9H23Yd3EBJ7OXzAOrt/gQ3R8bL
 qPV9u8HtXa2msyDUHty4OOm3FZtt7KzVoyoHjORNxzMlOsjFhXrGzcz3Z
 G3ipsEb0szGKJE7PZmN/+Lx30/phYXndtImHJ/C9Xy2W/rmPlxfp1tGNu
 CmmldPilLWj40npVVlzQ67Wf5xsjpIiLi6xXqsa2gtd0CbofN2Z2P4Vdy A==;
X-CSE-ConnectionGUID: g0s0z5QnS1mK9uxkYi/4tw==
X-CSE-MsgGUID: WTMGI9nMTGqMvjieuFdoew==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62461644"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="62461644"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 22:56:15 -0700
X-CSE-ConnectionGUID: 3oGzdBcSTje5Nn+d7Rne7A==
X-CSE-MsgGUID: 0HYPgTEgQ7ayQZ6txkf8cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181475280"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 22:56:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 22:56:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 22:56:14 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 22:56:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGHMtodbldHDtMWlI9y/QXpxSx+9WAJ0U8NfaZVRYM1JynG5AOXilSOOgbw/OK007xxuiodssxqM/hV1tk3CyoxLjSEDv/UCPT5Hb8u5+6rqr/i1HYwDY8ZwUrKN+fsaDuWjQv5aSGS+hAy7YoJ9X/dbP9EG0LKjZT43GibS8btGPI+zAY9ScGyIj+ZaO9RexXAjup8Y2qvwVwZ9qh6/FPJ9yWeGsuCoiUFJ9KICXQVMB0cq3QIRIL69ZuVpWbWGIWoKAueXXFUBzBZOqy335p8xyzRaF29r3+qKFiqvf1mf8fnOFhuaibbzrWhvGC25BEyModegZxkHo5sP1KUfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEGawx4MDPTXFfZhk1vA36tm5Q2g9Tff1KQwg92HQnM=;
 b=gSnqlFIB2M5pXxpFASmYsNDx74XHpYmHtl3jJg4Nf8gdS7h2y8LMH/bw98Mei/M+7UFwXqtYssvjW/4dF4rxk4IkCy2UzZhZ3rKKbh9/P+F7JKE4jSt9ZUaa1iJFcXeiFfeEBWytNqDJpzo+mN8nqmbrTtgychDiFbLUSwl0meJgEwbnk6kMVOjhUw9ZuRvsnBH/deZoaNPnisU685JN2MCZAhc6NuQqPYxGS2Ebx+xdUHaWNPrWoHWENw+NUtc0YS/DUwcgTVn6GCIfBHSd5lpW7uzsYHO/LgSWfBlSk9YHAHCVdvSuWaVdnZ9ZYIJlybxdwoO27aSPlcevjefj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS4PPF551321A38.namprd11.prod.outlook.com (2603:10b6:f:fc02::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 05:56:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 05:56:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 13/22] intel_iommu: Reset pasid cache when system level
 reset
Thread-Topic: [PATCH v6 13/22] intel_iommu: Reset pasid cache when system
 level reset
Thread-Index: AQHcKHqVNpjRbmR1JUOZZvWnq8AXCbTABnKAgAFG0EA=
Date: Tue, 14 Oct 2025 05:56:05 +0000
Message-ID: <IA3PR11MB9136AD902C2684AE7049C76492EBA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-14-zhenzhong.duan@intel.com>
 <3f5e636b-255b-4535-acc9-79a6179439ef@intel.com>
In-Reply-To: <3f5e636b-255b-4535-acc9-79a6179439ef@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS4PPF551321A38:EE_
x-ms-office365-filtering-correlation-id: 053fcb0d-c7f3-4ea4-a055-08de0ae65d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?enNEa29Bd3NHN0pJVlBrSFROODkvd3dQL0E2WFFiR1psNWltTFZPNFBHQVoz?=
 =?utf-8?B?NHNLOE1jM1VVakQxNlFnRlZuQXJXYng0eHlwbHN1TTh1L250Qk0rbDJya29u?=
 =?utf-8?B?MStNaU5UaVA4Vk15aUE1eUpjeVdaMG8xY3h3RmRkYlRvUXZHQ2h5bHc0aFM1?=
 =?utf-8?B?dHVieFdZNk8rTmNocjQ0Q3dLNENneXFDZTRoejQwNk9Lb3BXa2VrQ0dtay9N?=
 =?utf-8?B?TWpFUFo2SllLb3dyZkk0S0hKb3ZodkxvNEIxUytCOGcvYWNSMmhSY0RWRjFI?=
 =?utf-8?B?MFpVRXAyUnIwL0xuY2xMck50RjFjM1MyMDZ4TGpBMS9CZFhpVGh5aUNGMHBk?=
 =?utf-8?B?Rmd2aExLYVFJTTcyM1J2aGhGZUlVUVVVSGFGelBnRlZBWVk1WjlzSDRlS3lV?=
 =?utf-8?B?cHlTTWloSlNpVGd1NW5KTFNBVkZuMXdXdEhZNVBzdkwxcFFENDdvTzhnSmpk?=
 =?utf-8?B?MUVzajduR0tOQndrRkszTnkyRWs3V1RJUjlPV1VCMmVHRXZiWWtQUkloejBV?=
 =?utf-8?B?cnlFS2xPUERvb3E0NFZYYldGdzM4QTNNdFBvcGJaU1lpcE5vTy90WTlRcEpy?=
 =?utf-8?B?WlloOG1NUjBWSHlZKzU2MmRWb0pkc01Nb01ENWNkSzVDeHlaUkxBYjBUZ2pT?=
 =?utf-8?B?TTF6L25wR01FaEFxWHY0ZUI3cEhzTU9WTUFSZTVWWGk4eXJvNm1kNVNCdjg1?=
 =?utf-8?B?akpoQzVtQklnaXNUVSs4TExEeGJPY0IwZ3ZHSmYxZDFzK1JlS2ZTelVBSE9N?=
 =?utf-8?B?bHY0OCtRU1A0V0JZbThLdlcwaHNLdTAwWkZMOFpMeEl4VDNZUm1IVHpLVDVE?=
 =?utf-8?B?VG80N2hpRkdxdU5NRzBqOURKaGptMy9qYXJjWHhUYmVpMUo3ZE9hQXhETklO?=
 =?utf-8?B?WFBQeVl3Sno4TklSWlhxOUowbnRuYjl4dS81NWQxVDFmL21RZm03bFF3aHFj?=
 =?utf-8?B?R3RRaGg0Uk5YZHhyS2NRSDU3QlNnSVA5WWdia3ZrYmk2alJzclozK2xIVTNS?=
 =?utf-8?B?T21FS0ZibDliaHJzeEpoYnRQMkpkcWI3WlUxUXBIcXUxakNCNWUwb01hd2dr?=
 =?utf-8?B?UHhnM1dYekJqQkZBR1NPbXFsaEtlVndtbzlmakVtdFlBMkhqMU9yVzdDcFpH?=
 =?utf-8?B?TDFFa2V6Qm5nRy9UTGZxN3hTb3czZGhyWGRDWmxSWDRhSmxjdXJ4OFpINUNJ?=
 =?utf-8?B?eHdtcUJTMWhtRDd3bHVENDBleWlvczRPZURzU1lxdXc1dWZXVWFZdXlEVUc0?=
 =?utf-8?B?ZTZXUURHWk1lNHhEb2xTNU91Z1RMeWdNQXgrMWdxVDZFZGllc0xOaWxMdFQz?=
 =?utf-8?B?ZStHdlVEOHhTTHQzY0NMV2VRdTdEYjRaODJ0MU94Q3IyeWNaQithZUZtb0J1?=
 =?utf-8?B?NWZnMnY2bGlrMjE3azZSYVhTSE5oUUo3NFBWc1FOcVRtTE9tVzVTR005NGNS?=
 =?utf-8?B?bTBSVkFHNkRoWmdKZDNMWFo5dGVOT3lVRmhoeVl2L0VUVUpHQm14bDZZRXMy?=
 =?utf-8?B?cWxuUXdEaWljNXVZSE1ZenEvc0ZYSjdhOWd1UC9pTGFDMUUzVEtjYStkZVVS?=
 =?utf-8?B?Q3JXRnEzdWZlOStYaUxvRGlialBSNGV3VThzUmdCU1RxVlNuUHpoaEdPT3A4?=
 =?utf-8?B?d2txcE1samhhNUJ3bGRRaTdsUXlvZitaTTdDcUJRREU1YzJHMXU5bTZRSERY?=
 =?utf-8?B?SU51alJLVlNBaGFKckU2WGwveGZXMW5ieHFZMmpVUzNFWk5YVDAxbnlnc3Jh?=
 =?utf-8?B?UGhFYm94UFdUVmlzaVBHbTlNc0gyN0VQSU9FWlBTK3IzZDc5WGJ6MDg2Mjho?=
 =?utf-8?B?Y2JiL0ozaENrcTcwbTRIK3FGVVZ4VHJuTXRhTjlkV2xJV2VtdFdiMThqdCs3?=
 =?utf-8?B?YnFkR3A4cnljeUxCTXFycjE5a0lIZ0R4ZzVtdFM3OHNDRXVDeFlyMUY0Vnht?=
 =?utf-8?B?OStkV0RIWG50UGsvcVk4YkN1QTRaeTZoSjMwMU1PYzgzdnIwS082T1U2Z0Zj?=
 =?utf-8?B?cmpEZFN0WXd1cW9IZ09sWEJ2cmw1Y1pCQ3c5T1EwTG5WQWhXa3pYVDEzb0xB?=
 =?utf-8?Q?B+J9GV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUdxckZ3THZWZi9JdTdEeW5uTWNVTTVDOXJmNUQwRFlVckxaTE4zMWFpTm5o?=
 =?utf-8?B?dkIwUjgzbi9pZnlJdlMwZXpQOEo2ZGVlR09yYlYxeDU3T3ZvQ2JWbktFWTMx?=
 =?utf-8?B?OUJZbEhKM2VyKzUyN0xMZnFJT3BVZ1FUT3RESzBRVUxtRHFydzd5VTAwVEJ4?=
 =?utf-8?B?ZDZGOWJLZER4TXdMSDlkY1p3NUo1RkZaL1l4eFRyNmVjaGNWME94RjhRQThH?=
 =?utf-8?B?YXJIUEt1SHdKOVBKeWpRbGFrOFhCY2lNeFNVSWpKaXJKR2oxLzZXZFFrN2pW?=
 =?utf-8?B?V0w5MmpVNkpVNm1jTEtrck9CTnNiSjhWOEFNTkNTVHhhak9kWGx6N0ZDQUpT?=
 =?utf-8?B?ZEYrSVc0ZkpzOUQ2Z21ua0JwOFNDWW41eUx0NUd2ajlMR09ZVnhoZEJ6OXJa?=
 =?utf-8?B?SjJtakY3aWRHVE9VN1YzU1BobG9RMHByZEZhQ2lOME9MaElIYTQ0NE10OStz?=
 =?utf-8?B?eUgza0lybVFEc1dDemJhYi9FWkVqSlBISSszRy94V1o4S05QVE1ZbWxYYnBo?=
 =?utf-8?B?aXRnbHc2OCtUZmZNMFkxUFEycjFCOW56ZlM3c1ZESWpzNUdiUmllMGxRNGRJ?=
 =?utf-8?B?REp3UitldjNDeFFTMzVLOEt3V1p3NE1oVFNQa0hKR1dUYW01Q3ZqczFGYVZJ?=
 =?utf-8?B?OTBkcWZTcnl6QzZacmZxeWF3S0tCR1dUcVNBcUgvVS8wTDZLQkt4OG9FSUhE?=
 =?utf-8?B?OFFnMk9JcUcvaFV5b2lkRDFyVktiUFRweW53L3RvRFdJS0dGTFNhemRmVklx?=
 =?utf-8?B?T2NqTjFqY2FxZWRVSG1ZWWc4Z2hzZHY2QlhYbUlOM2JpLy94SVZiaEVtZlZ2?=
 =?utf-8?B?ZWJCUFZzTWM2ZEt5OEgzdWVHSDNQNzYrN1NSN1Rlakdpb3RudHV1bko2SE93?=
 =?utf-8?B?Vm8xVm13ZHA5SjBzVlZ2SVlvQkpxTFBaTm1WZTIzL2NoSDRYeENFUmNZVDE0?=
 =?utf-8?B?OElIWkZ5K05YWDZ2aWpFeWNkTmxNS3JkbXVLSEtlLyt5K1huUjhBWFNZcnc4?=
 =?utf-8?B?NUtHMlhkcE5oRzBxNEQ3Q3JGR1lxNDI3eWZpK0VCbzQzNWdWQU1UT1NuYnF6?=
 =?utf-8?B?d2Jmc3FyT2hiWmMzTmJoMW5ubDM5K3JDNjBJUUlhQitSbDRZZ2krQkpkREJP?=
 =?utf-8?B?Ny95TnExYkdGSkpGZ3UycmpKVytNNFFLV0phZ1IrOXJyMTErdkxoZnpPYjZm?=
 =?utf-8?B?NzIxdEduNjQ5L3NTVnhJVjRWSnNCbUxnRTkxMGJjck5uZjhtWDQ5d2xGQkpq?=
 =?utf-8?B?ZjltQUVIQUszbFd6bnlIRExaM09JVi90OVR0ZDN5RjBpU1Y1UmdXK3gzZ3B1?=
 =?utf-8?B?dUljYWQzUEpIY0gvN0twaWFsMXlNYUxSazRaZGJpckNoc1dObk9QblpJa0VS?=
 =?utf-8?B?REF4VEdqT2RBcnpBY0E2ZEpnd0laUmdMTmdITGtwL0FNcjNmNm51M2tlWkll?=
 =?utf-8?B?SkVYeEN3QTZCbHkwNkdRRVhWN3NJYUpLUUtXSnJsODNWcXAzY2p6eFViblRT?=
 =?utf-8?B?ZUM3WWNhUjkrYlBkV2ZFUkVMSUxSMGxHZDN4UFVqT0hzcllTUFpHZW9yUVBJ?=
 =?utf-8?B?U3VyblR1Q21xc2J3ZTc5Z092VkFMQjQ2WnBBZy91Qnp2TnZSY1Q1TS9rR3NC?=
 =?utf-8?B?SnNPYnZxaytRSm1sbUdjZzJWc3AzRXZ1UDRPby9GbHAxZUlNQ0RYdVNEcUds?=
 =?utf-8?B?MytadlBjeXpIdFZVdWJkV093ZS84RzRZVlpYSVZEMC9uVXQ4YjJ6UnB2bHRQ?=
 =?utf-8?B?UE5wZXBFc2tLNnlsaFFFcU5BYzV5T2E3QzJBaTRQeEJnTWttbzVKZDlVTmFw?=
 =?utf-8?B?andFSXhDWjVpeU82ZURkVlR1eWRSenIrUHl1eGpMMUtjN09McFUyZFB4RnZX?=
 =?utf-8?B?Ym5TWldQK0N1UitDRGlUOU8rT01zWVMvSzdmRGFNeEJSeFpyOWxHWEJhWkFi?=
 =?utf-8?B?ZGJBWU42ZytLM0tlV2lLdEt6TnZDNVl1dUVQM3BXbXY5MVRQdlljMC9ycmwv?=
 =?utf-8?B?Q0Y2VFZ2S0lQc3pOK2Vpc2FWbEtyeXJXYnEyR1B0QmhKZGdRUEdqVVA1eHN5?=
 =?utf-8?B?WEJUdndGQ3dlZFM0bVNzd1R0dUhzQitXRG5NL2Vlc050cldnb1E1WkdhTWlC?=
 =?utf-8?Q?8Tnox9EqF39DkzqziOGpFZrmG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053fcb0d-c7f3-4ea4-a055-08de0ae65d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 05:56:06.0010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shZu8dde+IuPpK97Py3Oa7HsDiV1Zu1QxqIxph5yAIjLlirLFNaTf938HiQB5c0LyFb7GJ/RxrPNGfElYi4jEj5dMrdp85G9+JWCBypeUgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF551321A38
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMTMvMjJdIGludGVsX2lvbW11
OiBSZXNldCBwYXNpZCBjYWNoZSB3aGVuIHN5c3RlbQ0KPmxldmVsIHJlc2V0DQo+DQo+T24gMjAy
NS85LzE4IDE2OjU3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFJlc2V0IHBhc2lkIGNhY2hl
IHdoZW4gc3lzdGVtIGxldmVsIHJlc2V0LCBmb3IgUklEX1BBU0lELCBpdHMgdnRkX2FzIGlzDQo+
PiBhbGxvY2F0ZWQgYnkgUENJIHN5c3RlbSBhbmQgbmV2ZXIgcmVtb3ZlZCwganVzdCBtYXJrIHBh
c2lkIGNhY2hlIGludmFsaWQuDQo+Pg0KPj4gQXMgd2UgYWxyZWFkeSBoYXZlIHZ0ZF9wYXNpZF9j
YWNoZV9zeW5jX2xvY2tlZCgpIHRvIGhhbmRsZSBwYXNpZCBjYWNoZQ0KPj4gaW52YWxpZGF0aW9u
LCByZXVzZSBpdCB0byBkbyBwYXNpZCBjYWNoZSBpbnZhbGlkYXRpb24gYXQgc3lzdGVtIHJlc2V0
DQo+PiBsZXZlbC4NCj4+DQo+PiBDdXJyZW50bHkgb25seSBJT01NVUZEIGJhY2tlZCBWRklPIGRl
dmljZSBjYWNoZXMgcGFzaWQgZW50cnksIHNvIHdlDQo+ZG9uJ3QNCj4+IG5lZWQgdG8gY2FyZSBh
Ym91dCBlbXVsYXRlZCBkZXZpY2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5s
LmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8
IDE1ICsrKysrKysrKysrKysrLQ0KPj4gICBody9pMzg2L3RyYWNlLWV2ZW50cyAgfCAgMSArDQo+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+IGluZGV4IDI0MDYxZjZkYzYuLmE2NjM4ZTEzYmUgMTAwNjQ0DQo+PiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4g
QEAgLTg1LDYgKzg1LDE4IEBAIHN0cnVjdCB2dGRfaW90bGJfa2V5IHsNCj4+DQo+PiAgIHN0YXRp
YyB2b2lkIHZ0ZF9hZGRyZXNzX3NwYWNlX3JlZnJlc2hfYWxsKEludGVsSU9NTVVTdGF0ZSAqcyk7
DQo+PiAgIHN0YXRpYyB2b2lkIHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKFZUREFkZHJlc3NTcGFj
ZSAqYXMsDQo+SU9NTVVOb3RpZmllciAqbik7DQo+PiArc3RhdGljIHZvaWQgdnRkX3Bhc2lkX2Nh
Y2hlX3N5bmNfbG9ja2VkKGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdwb2ludGVyIHVzZXJfZGF0YSk7DQo+
PiArDQo+PiArc3RhdGljIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3Jlc2V0X2xvY2tlZChJbnRlbElP
TU1VU3RhdGUgKnMpDQo+PiArew0KPj4gKyAgICBWVERQQVNJRENhY2hlSW5mbyBwY19pbmZvID0g
eyAucmVzZXQgPSB0cnVlIH07DQo+PiArDQo+PiArICAgIHRyYWNlX3Z0ZF9wYXNpZF9jYWNoZV9y
ZXNldCgpOw0KPj4gKyAgICBnX2hhc2hfdGFibGVfZm9yZWFjaChzLT52dGRfYWRkcmVzc19zcGFj
ZXMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9wYXNpZF9jYWNoZV9zeW5jX2xv
Y2tlZCwgJnBjX2luZm8pOw0KPj4gK30NCj4+ICsNCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHZ0ZF9w
YW5pY19yZXF1aXJlX2NhY2hpbmdfbW9kZSh2b2lkKQ0KPj4gICB7DQo+PiBAQCAtMzkwLDYgKzQw
Miw3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9yZXNldF9jYWNoZXMoSW50ZWxJT01NVVN0YXRlICpzKQ0K
Pj4gICAgICAgdnRkX2lvbW11X2xvY2socyk7DQo+PiAgICAgICB2dGRfcmVzZXRfaW90bGJfbG9j
a2VkKHMpOw0KPj4gICAgICAgdnRkX3Jlc2V0X2NvbnRleHRfY2FjaGVfbG9ja2VkKHMpOw0KPj4g
KyAgICB2dGRfcGFzaWRfY2FjaGVfcmVzZXRfbG9ja2VkKHMpOw0KPj4gICAgICAgdnRkX2lvbW11
X3VubG9jayhzKTsNCj4+ICAgfQ0KPj4NCj4+IEBAIC0zMTE1LDcgKzMxMjgsNyBAQCBzdGF0aWMg
dm9pZA0KPnZ0ZF9wYXNpZF9jYWNoZV9zeW5jX2xvY2tlZChncG9pbnRlciBrZXksIGdwb2ludGVy
IHZhbHVlLA0KPj4gICAgICAgLyogbm9uLVJJRF9QQVNJRCBpc24ndCBzdXBwb3J0ZWQgeWV0ICov
DQo+PiAgICAgICBhc3NlcnQodnRkX2FzLT5wYXNpZCA9PSBQQ0lfTk9fUEFTSUQpOw0KPj4NCj4+
IC0gICAgaWYgKHZ0ZF9kZXZfZ2V0X3BlX2Zyb21fcGFzaWQodnRkX2FzLCAmcGUpKSB7DQo+PiAr
ICAgIGlmIChwY19pbmZvLT5yZXNldCB8fCB2dGRfZGV2X2dldF9wZV9mcm9tX3Bhc2lkKHZ0ZF9h
cywgJnBlKSkgew0KPj4gICAgICAgICAgIC8qDQo+PiAgICAgICAgICAgICogTm8gdmFsaWQgcGFz
aWQgZW50cnkgaW4gZ3Vlc3QgbWVtb3J5LiBlLmcuIHBhc2lkIGVudHJ5IHdhcw0KPm1vZGlmaWVk
DQo+PiAgICAgICAgICAgICogdG8gYmUgZWl0aGVyIGFsbC16ZXJvIG9yIG5vbi1wcmVzZW50LiBF
aXRoZXIgY2FzZSBtZWFucw0KPmV4aXN0aW5nDQo+DQo+ZG8geW91IHdhbnQgdG8gdXBkYXRlIHRo
ZSBjb21tZW50IGFjY29yZGluZ2x5PyBvdGhlcndpc2UsIHRoZSBwYXRjaA0KPmxvb2tzIGdvb2Qu
DQoNClN1cmUsIHdpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj5SZXZpZXdlZC1i
eTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+DQo+UmVnYXJkcywNCj5ZaSBMaXUNCg==

