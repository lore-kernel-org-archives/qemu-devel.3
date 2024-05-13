Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F034EC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 16:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Yp0-00071k-D6; Mon, 13 May 2024 12:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s6You-0006zk-Gp
 for qemu-devel@nongnu.org; Mon, 13 May 2024 12:46:38 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s6Yor-0004o0-Fs
 for qemu-devel@nongnu.org; Mon, 13 May 2024 12:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715618794; x=1747154794;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uFhkvBXU8l6d93X40HGidiAgBfv7tpXvzeM4irb8pXs=;
 b=L4ehhT4V8AHnyRfVQisu6qaJ4GgttM8KcI6KOH3ZW0TLra+pEwhQcHcC
 9cLh+tFPhxBuA0C2mciLou7Y1TRPN4pSwojDIMYHd+25M9hJRc743r1+4
 MoRZm5W/ugh7Zf15hX9MzuXZEZLJL+Roa1J6UZ9GGI1VOIft2ZkCUw7e0
 FDwiIzr82rDD8hhu65WpmeGN7y3zbl3AcXxfVHqvbh0ZnoJlnKJOp7hW8
 I2EWkbovYwXw6Z2xpJ/y0E3grgLXiUM2FYbDKEff+HTNruJma2VpxbDru
 xBYb2mqlteljfk0bNHiw1B/19XRJX1HRJY+WQqFSucvBIgqfpdCIAN+px g==;
X-CSE-ConnectionGUID: RiOWVEjEQZK1SgV3TCffyQ==
X-CSE-MsgGUID: +mduhFviQuO4r6xW0ie3vA==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11723832"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; d="scan'208";a="11723832"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 09:46:29 -0700
X-CSE-ConnectionGUID: uMxpaPdURTCCT5QIjnvsRg==
X-CSE-MsgGUID: KKWDSkIoREq8YiW72f9BGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; d="scan'208";a="35266318"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 May 2024 09:46:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 09:46:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 09:46:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 09:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzL1gG7gf4YHWNvnK52LlMubNjp34R71GjJeYn0ahmd2ZaFo2yeo+NhlskgwDDeKJE1juYoTfzz+MlRGVsgS/ZWpOCnJ4u5ACUOTvyONeEKwNOPJwYbjdbPwUhVI/stRa8al4UVNsK/Dih1txHZ5++gdn153HI56R4dBL0WZyTyB7q0BQci9y/6PGnQgD8HQxUSKVULYu1mY54EJmn9+CJWsg46BE1mVB/PAlpps9pyfz2XXPlkuz3q6txH6d2N69EBKNN1ecYaoDXUYsn+8eZq3MJwzw5IcG4JyYWzAOqfbzjD/Lr1IrQv8uK6S5znY0y2Kc9vG4a4L3kWdtO1moQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFhkvBXU8l6d93X40HGidiAgBfv7tpXvzeM4irb8pXs=;
 b=Tvb7pZxQSNNmJJJ7asVuSgrv5ci+ReOVpdSlynyTkAokNaz1HWqqj4AECpq5AfOMP6C1sAicsSt6SkoSfPeZzgMKxWjsORGsK3nWywR0q0ReDw8iE4N3kXbAb3XQj57lITo9jojHOaci7DxcN656AloQOOSG+S4r5ovK5Pw99Y1DD+FfzB15t3mb76nDUZWKktNAt/ef1+ht9k4rHhs/AyB5MrkPKcKdPwXswBDlmkOdw2RXNV/yrj+aSmAmmq8jA8Eo4yPNxSSA4ZmFlxLsfMoY0vvgW0zwCJFtzdwxmT1Da6EKJ3v9r/RAtrDHMjgGeNorMYQ22lE1+Wtvp6Oh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 16:46:26 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 16:46:26 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v2] vhost-user-gpu: fix import of DMABUF
Thread-Topic: [PATCH v2] vhost-user-gpu: fix import of DMABUF
Thread-Index: AQHapSaa6eiYqM8UykaTrOnouywEcrGVXuqQ
Date: Mon, 13 May 2024 16:46:26 +0000
Message-ID: <PH8PR11MB6879330F863487DB48BAA963FAE22@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240513111305.666977-1-marcandre.lureau@redhat.com>
In-Reply-To: <20240513111305.666977-1-marcandre.lureau@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|BN9PR11MB5275:EE_
x-ms-office365-filtering-correlation-id: 908601a2-3eee-4bd8-08d3-08dc736c3b41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aVVVT3NlQS9TNHFSTVRnS1NvaDlUaHpQWndsWWhOaG5ZSzNBNFZDZTk0dzJr?=
 =?utf-8?B?anI3UmVXd3plRGo0YTJMRjRqOWtvbzFNcEQrdlRVS2czd3lHVmoxa2R4OE5X?=
 =?utf-8?B?V09HKzVoZWYxSjU1emVSeHBCQUthQXhRZWJSOG8wS3ZkTFNtb3RZYklKSk1t?=
 =?utf-8?B?bjl4RmV1dGpiS3BXWVpoUUI4OERucWtzQlFZVTR3eWxJRGFGR25QSXhWaGFo?=
 =?utf-8?B?RFgyVkQ2dXBFNG9vdWt4SlQ4NnV1dmFKQXJmSE4wTFdmSlRkaXRWUlNTdzBN?=
 =?utf-8?B?N05yN2RPcXFJQXd0bktMZDJPajFvWS8zQkVVYzlPVmxXZy9BY1hiWTdUUmw5?=
 =?utf-8?B?bHZKZVVuc0dDRWRTbStmMkhzSjdFVTlHUUNsczNURXpjTzFKRnJIUGNOdjVQ?=
 =?utf-8?B?aXNwZUpQdlBhRjYzMEJKRDdyTXpCY29McElpTXhiVmlKZFhyczFHSGU3TXhR?=
 =?utf-8?B?U2VpOUFrR2RDUVhzNms1Qzh3WUFINi90cFUrNzl1VllPRXhzZElEZHFQVE5T?=
 =?utf-8?B?K0llNlN6WWFwRGQvbUJCeGorYnpIbmpJU2dTUHFCcFVsOU16R2VIYmxxQnMw?=
 =?utf-8?B?djFQMDkwYWRlRlFpN24rZ3R1dk8zMU4wUVUyY3Q5d1g3RmhNU2FGUXNFMTIz?=
 =?utf-8?B?MmNRNEh3OHdKQ1J1eFJuVTRodk5FSEhnNTFBUWxPaDZ6VjU2Tk9DWi8xbXFk?=
 =?utf-8?B?NTErbDdtd0R5WG5uMHVWR0NyQ2dLTFY0WmZkK0N2N0dtUVVpTW9kcG54VFM4?=
 =?utf-8?B?UmlGVWN4SVJSYWJ4cGpha2J0NUxnSWk2Vm5CWWVzSzBXKzVHb1Z4YlBYbXAw?=
 =?utf-8?B?WnFodGhaOFFJNDNEcEVsOTJFVEZXejRFZjFQY2Q5Z1hYeFlQT1VVa0g1d2N2?=
 =?utf-8?B?YThuZHJxUFFnTXlURUxuaU94dGtRd1FwR3gxN0dRUFZvUWhJWXc2VC9Lc2Jp?=
 =?utf-8?B?NmZNZ0ZIZFRCM0w3VGxkM09XWFJOV2xTazdxRFllZmFLSTllK3k5Z1EvQ0Z0?=
 =?utf-8?B?ZTBJeWw4RW0wbm1GVFBUbyt3dzA3Wm5zL1NCQ0NhM1c3MlpCMzVLaEVnYzRx?=
 =?utf-8?B?ZHYxdjJWVTJsNW9EazUybU96S2NxZDM5SXY2cTVMa3ZRY0c5eWpyc1lJQ0pR?=
 =?utf-8?B?UnYvR3hCOElIbzNtWlFnbDVzYms5a0ZGWmJwTTViUlkvY0tqeVhzbTFPbTBw?=
 =?utf-8?B?MWpOQjQwWFZhYjlZdXNNc3lhME9sRTAxS1h5cmt6T0V5MmxRTWdXWUVKVGV2?=
 =?utf-8?B?RFpUbkVKSmprQVU3bGhCNmtxWW5OQlBGK0ZnZm9DZU5kSVFHMnJoY2JBSUhG?=
 =?utf-8?B?VFViNHNUbGVqcTd3aHVSM05YUkthV0ZKY2RUWWlUMnFDMkEwbk9CUEg3ejhD?=
 =?utf-8?B?NTJpZ2ZReUwzSmxWY0V5V0JSQmUwU2RDSCtWY1FnbjdZSmMvK1U1RGhUazhO?=
 =?utf-8?B?YVV6eDhyWkVJYnRDdXlFYnhUNUh5elVXVG1HbFZwRGVTc3M0NnZXcEhXVlJj?=
 =?utf-8?B?VVZITHBJMi9DKzRiSkY3bWxWM0IrMnoyYWloK1NaWUxJbGJ6cU4rNFo5Rmts?=
 =?utf-8?B?cnVsUld5REhSdzZWR1V4NzVqaFVVTnkxS3NGcDcyc202ZHYxTVdnb09lMjFN?=
 =?utf-8?B?bnVWeUtPSmdjNWhqT0tIVWNxWUp4VHRla0lyL1ROejdwRjRhRXhzdnlsUE5N?=
 =?utf-8?B?NDJKam80TnRjdFkrRFRFNFdNaFYvRDVJNTNXdTU2SDNIZ0o0eHlKUk5mR0sy?=
 =?utf-8?B?bDRHN1FOb2NwQkhRS3J1ek85RW9SZSsvYTVYNlQ5L24raXNtdlBhdEgrQ05i?=
 =?utf-8?B?MWpsRkMzVEZFeXFZSmt5dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEQvU3NTZHRWSDNsa3Rhdnl1dWVkdWZPTThpM004TjliV1FuZk1acHJHYzE2?=
 =?utf-8?B?cWYwa2J6US9zcUxxUVV1YjRoU0t1cW9ORzVDNW83amozN3M2N211NmF5RC9N?=
 =?utf-8?B?eWVPTWRFL3FIa00zbFh6V1Y2S1A3TlVrTHgyS3RMSThqVUxEV3J0eU5Hc2gx?=
 =?utf-8?B?UDNNNnJJY1dNVDhsc05EYUhnOGxkTlRqNk9ERmphZFpIMnNrekwyQlhQeGtP?=
 =?utf-8?B?cGlVSUU1Uld2TmQ4SGtoMEJnWEl1QWZFYVZDZUN6MGlsM3RDTmgrS1hucG84?=
 =?utf-8?B?K0IyMjFRU0QvV2tiZU82Qzg5NmN2Mk1rdFVjamxiOVlDSGQwaGlmbDlYU3JJ?=
 =?utf-8?B?NjdyUjFMOFJGYlhRbitTUzVFOElONUhieXRTRzlKV051ajRrdFhMN25YWitu?=
 =?utf-8?B?RTQ3NjV3MFRYeDB2VXhYdWs0dWNJdlNHdUcxdGxqVGF5SE9pQ2NNNHBPay9i?=
 =?utf-8?B?a2RXcGdjRkRVbmdWSVEraWV6bUxtS2FZd2FiRlR1aDZ1KzNNNGFTYkdUZXBy?=
 =?utf-8?B?THhCdWU0c1gyTld4cTNnaFlYbVN5YmxEK0lEUXRXWHV6T1BPVTIwN3QvZThO?=
 =?utf-8?B?ZnZwNk5RK1hNTnY2ekI2clZUM0tFUy9mSnpuSWVTL1NDU3pYdzBJVW4yUlVU?=
 =?utf-8?B?QWtza2d4TVVmbHhsRUo5cytvQmVvMmtUb0NPSnRkSGRDaXdlNm1iaGtwNWY4?=
 =?utf-8?B?MGc2dHJqejlKL2lDbUJ2WUdtZ3Bob3RhZmU0Yis1amF2bEZUNzFvZU5RS2Vq?=
 =?utf-8?B?b3Jqemk3eTgwZHp1SGpLU3A2MTVEUk1aeHRvcGE5QTU0UzQySXdYelpQWWZU?=
 =?utf-8?B?RjVDT040UmVJODV0SnZvQ2NYU3NDZnU1NW9VUjJBendQZXhoUkJLOVZSVFhJ?=
 =?utf-8?B?WGd3NlBQTHRjQnIvZFNSNE9EYjJMV1EzS3pvRG1HNWY5a2F2V25YalBhOFJo?=
 =?utf-8?B?THQySVVQSVVsSHVCSHJaQy9tb05BNWd0SThndWxPSWpMaWh1ZHZpaXVXakdG?=
 =?utf-8?B?RVo2UnQzajlleEN4cXhFVnM2eUpBUUlKQzRvWnFyZXJTYnoxbzdnWjBMaGp2?=
 =?utf-8?B?NERFQlRobFpWYTlremVZdXpkeEVpS0dvNVBuVFJUWDNtQ0NDWFdmSGNHQ05E?=
 =?utf-8?B?WWdLVWJhNGt4aWtLQmtkTStJRkdlbWJQYzVQQng4aGxrbDh3Wk1JYmI0dXdH?=
 =?utf-8?B?SkVxMkMrRDJYYWduT3lZNTBkcVBQUXBiVUpLdm9sWWZ5a1FZY0x1QUtLNXZM?=
 =?utf-8?B?LzF4Rnppb2Y1MkcrYnJGaWFYWVhHT09pZS9iU3lzSjBSQ2NIc1ZOayt2OUpj?=
 =?utf-8?B?SU03VUtFZ1JCczRBUStwRlR3UU5ZK1F5RjJ4ZmYxTzhBYUZmUUJqRXJPdnFt?=
 =?utf-8?B?UUh0TFpicnNXR3Bab3Uvb2gwa1FlL25WR09MSFEyKzBQVy9MZkt4S2R1TUtj?=
 =?utf-8?B?TExXNFFneGhwbEJqalBBNHJsMkJldUk3dDRleVJ1Y3NmRjk1Ylh1WEVXVk5F?=
 =?utf-8?B?ajBTWU0xd0N1RWZzWXFucEdWYjVOSjVuY2l1U0ZKaHUrRlNibktEbnhOd0tQ?=
 =?utf-8?B?Z0NsRUJmenRPNmt1OERNNXB2UmU1dmM1KzN4bW81SnMzS003U1lKRis3WDIw?=
 =?utf-8?B?MWNYdXlGL0lnSjBUOEZLNUJDRGw1bHd4YjcrOE52ZXNXQ1J1V05NdmhaUElF?=
 =?utf-8?B?N0lmVnlSVkEvZG9JSmEreGxuM2dSZVpLdHNrZmtRM0FqK3ExN1pZYVNSVEl5?=
 =?utf-8?B?ck50aUd5OWoxcFpIbTR2K1VDN3hsdnZoRVlYWExRdkNOOVFSSlNWSmVXNkFB?=
 =?utf-8?B?dVZHY0w5RVRjWGVZYnNVdndoN2RFK1grWFJTV2ZjR1ZvYzdYczZhSzVESFpr?=
 =?utf-8?B?NE1GTVFTcVB1QWtTQTdhVnhEY3RaMlFySTdrYTFpNTRSWW5US3BZQ3BCMVpT?=
 =?utf-8?B?RndsMGNwZHdyU2Fpa3cwT2hlKzRtUmVxeHMydDVYS0g3THJHcEs4RUY2K2RK?=
 =?utf-8?B?dm5ic1NuMklBc24xb1grT3FjcHFCakVGMmNiRC9lcVJBUGtienpESDJLYXND?=
 =?utf-8?B?RmVaNUtXZFlnd0JON0xNS2t3d1dhdVZLU2oyMERETGo1c01nMXREOUJ3YTNJ?=
 =?utf-8?Q?fxgzeJW4BDxaOS2FCp5fQXkQn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908601a2-3eee-4bd8-08d3-08dc736c3b41
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 16:46:26.7100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4h8um3lUqI+izebknMIY2aG0UxZDgx6sgIsrkCHK8yg0WGCtzZYjSO7ry9swfgcK+geGeydLrw+wn4Cov5WTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

SGkgTWFyYy1BbmRyw6ksDQoNClRoaXMgY29tbWl0IGxvb2tzIGdvb2QgYnV0IGFyZSB5b3UgcGxh
bm5pbmcgdG8gbWVyZ2UgdGhpcyBiZWZvcmUgInVpL2NvbnNvbGU6IFByaXZhdGUgUWVtdURtYUJ1
ZiBzdHJ1Y3QiPw0KSXQgd2lsbCBjYXVzZSBzb21lIGNvbmZsaWN0LiBMZXQgbWUga25vdyBpZiBy
ZWJhc2luZyBpcyBuZWVkZWQgb24gInVpL2NvbnNvbGU6IFByaXZhdGUgUWVtdURtYUJ1ZiBzdHJ1
Y3QiLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IG1hcmNhbmRyZS5s
dXJlYXVAcmVkaGF0LmNvbSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiBTZW50OiBN
b25kYXksIE1heSAxMywgMjAyNCA0OjEzIEFNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcN
Cj4gQ2M6IEtpbSwgRG9uZ3dvbiA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPjsgTWFyYy1BbmRyw6kg
THVyZWF1DQo+IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBHZXJkIEhvZmZtYW5uIDxr
cmF4ZWxAcmVkaGF0LmNvbT47DQo+IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+
DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gdmhvc3QtdXNlci1ncHU6IGZpeCBpbXBvcnQgb2YgRE1B
QlVGDQo+IA0KPiBGcm9tOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVk
aGF0LmNvbT4NCj4gDQo+IFdoZW4gdXNpbmcgdmhvc3QtdXNlci1ncHUgd2l0aCBHTCwgcWVtdSAt
ZGlzcGxheSBndGsgZG9lc24ndCBzaG93IG91dHB1dA0KPiBhbmQgcHJpbnRzOiBxZW11OiBlZ2xD
cmVhdGVJbWFnZUtIUiBmYWlsZWQNCj4gDQo+IFNpbmNlIGNvbW1pdCA5YWMwNmRmOGIgKCJ2aXJ0
aW8tZ3B1LXVkbWFidWY6IGNvcnJlY3QgbmFtaW5nIG9mDQo+IFFlbXVEbWFCdWYgc2l6ZSBwcm9w
ZXJ0aWVzIiksIGVnbF9kbWFidWZfaW1wb3J0X3RleHR1cmUoKSB1c2VzDQo+IGJhY2tpbmdfe3dp
ZHRoLGhlaWdodH0gZm9yIHRoZSB0ZXh0dXJlIGRpbWVuc2lvbi4NCj4gDQo+IEZpeGVzOiBjb21t
aXQgOWFjMDZkZjhiICgidmlydGlvLWdwdS11ZG1hYnVmOiBjb3JyZWN0IG5hbWluZyBvZg0KPiBR
ZW11RG1hQnVmIHNpemUgcHJvcGVydGllcyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMtQW5kcsOp
IEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3L2Rpc3Bs
YXkvdmhvc3QtdXNlci1ncHUuYyB8IDYgKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2Rpc3BsYXkv
dmhvc3QtdXNlci1ncHUuYyBiL2h3L2Rpc3BsYXkvdmhvc3QtdXNlci1ncHUuYyBpbmRleA0KPiA3
MDljOGEwMmExLi45Njc0M2FiYThhIDEwMDY0NA0KPiAtLS0gYS9ody9kaXNwbGF5L3Zob3N0LXVz
ZXItZ3B1LmMNCj4gKysrIGIvaHcvZGlzcGxheS92aG9zdC11c2VyLWdwdS5jDQo+IEBAIC0yNzMs
OCArMjczLDEwIEBAIHZob3N0X3VzZXJfZ3B1X2hhbmRsZV9kaXNwbGF5KFZob3N0VXNlckdQVSAq
ZywNCj4gVmhvc3RVc2VyR3B1TXNnICptc2cpDQo+ICAgICAgICAgIH0NCj4gICAgICAgICAgKmRt
YWJ1ZiA9IChRZW11RG1hQnVmKSB7DQo+ICAgICAgICAgICAgICAuZmQgPSBmZCwNCj4gLSAgICAg
ICAgICAgIC53aWR0aCA9IG0tPmZkX3dpZHRoLA0KPiAtICAgICAgICAgICAgLmhlaWdodCA9IG0t
PmZkX2hlaWdodCwNCj4gKyAgICAgICAgICAgIC53aWR0aCA9IG0tPndpZHRoLA0KPiArICAgICAg
ICAgICAgLmhlaWdodCA9IG0tPmhlaWdodCwNCj4gKyAgICAgICAgICAgIC5iYWNraW5nX3dpZHRo
ID0gbS0+ZmRfd2lkdGgsDQo+ICsgICAgICAgICAgICAuYmFja2luZ19oZWlnaHQgPSBtLT5mZF9o
ZWlnaHQsDQo+ICAgICAgICAgICAgICAuc3RyaWRlID0gbS0+ZmRfc3RyaWRlLA0KPiAgICAgICAg
ICAgICAgLmZvdXJjYyA9IG0tPmZkX2RybV9mb3VyY2MsDQo+ICAgICAgICAgICAgICAueTBfdG9w
ID0gbS0+ZmRfZmxhZ3MgJiBWSVJUSU9fR1BVX1JFU09VUkNFX0ZMQUdfWV8wX1RPUCwNCj4gLS0N
Cj4gMi40MS4wLjI4LmdkN2Q4ODQxZjY3DQoNCg==

