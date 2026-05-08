Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E8ACD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHqv-0004mS-Vm; Fri, 08 May 2026 05:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLHqr-0004kO-74
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:50:33 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLHqp-0007xr-4a
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778233831; x=1809769831;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=I/jyTjbsetVPhs6DTEu/+VQkt0A43+L7Wn9L9c8PO6o=;
 b=cjE8TKDGNkJwzAH6jxdQUb6Yl0OMUcEMNcBYd4lF1/3sPo4Sy62xYpv5
 9ayjNBQF01YPyxLp79oqEgwo3GGq55ptP8MeDQvNiiXHfAIbBF9NkykBW
 uQwr7POlOy84JoohcvQrASW1k2B4oJGyYjA43/Il2f8cYGhpsRo8BZstt
 abnVauc4WsPRrs4qz4FGT+w0uOTmWtAv+oSkjOc+oVPVqRTus40XfqdkA
 waOiLj703KJBV1xR1z6Jt/Oo5XQMcFcTEv0gETsUztN9GwPm6Tqh9qNaJ
 SoU1Wx3ugqMuYOR77O2GOF/iUl7edbbkh3R449I6uFgngEX+SKERMCVtI w==;
X-CSE-ConnectionGUID: 27oMdt3OTjSu5nzet9Ardg==
X-CSE-MsgGUID: MZn7DNa/QhWOnJOPT//kTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78221471"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="78221471"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:50:29 -0700
X-CSE-ConnectionGUID: tutsod09QsaKPR4GKeirew==
X-CSE-MsgGUID: Dgyg7Zt6T8OeUqAAPOByiQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:50:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:50:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:50:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:50:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnRQI1lCVbWsOIpiJchhPOQgknhmPMADKk7PYIrwhnmC2abviRiOhiTaEAK1OdBHBgZ1YoPl8UO7xqXnruOQeqv7kRTv6uvPnSrm+RbOEhBKIZYPMvXJKILBKv0aYLL5ohGWqSS5le6VUpJS2o2/OqbIEfi9/fY7jTtLWfykVuUK/nCTC/fhHOWZQItiC2o1t1aQYZitxanRWtMGPUJ9Ly5/r6yIsoBd9jkmQ0o1jl23Mwz4OkYYg5u/5wp46I9KVY9+Du5BiZTjkLg3qjS/vFM4xhHTGdiWEuaIxjS81z5v4hCr/flGMfG07cG7f7wheyfpGckhzE1K7RGORMLR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/jyTjbsetVPhs6DTEu/+VQkt0A43+L7Wn9L9c8PO6o=;
 b=SixcEuUtBCCdQX+jLyiPzKkRSW2gBLnUAFIqVerN2nrbN6M5nu7K4xHPoZX0/EqtWculHSG5LUi17+U7EWnTI6BgJnVPqOCindNB98VuyRrvBAw8LII9z5kpqnkF21nI5/2jTo3yoCH68aYg+zMY0g05RMQEWzARj/27OuKirWVkqxSXOF4VlGdQ1lGJkX2dLai/eTN6a8mxUUbKrszchITpardukj1qzG7gIAwW8VEAfkOmMSB9+XIa4Mqj0eJvY7hEvcP0d7OLEhBLPNsvvvLNVd3gl0NscI3SThMuaop9YwWdZRoKlSGaorrBZzYPt4dZzn3gFRcPCxKNpID0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH8PR11MB9484.namprd11.prod.outlook.com (2603:10b6:610:2c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 09:50:26 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 09:50:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v4 05/15] intel_iommu: Change pasid property from bool to
 uint8
Thread-Topic: [PATCH v4 05/15] intel_iommu: Change pasid property from bool to
 uint8
Thread-Index: AQHc2HDu0xN0+Nfjdk+X2qlHAl6uqrYD6vSAgAAEA1A=
Date: Fri, 8 May 2026 09:50:26 +0000
Message-ID: <IA3PR11MB91369C7BBBB37328936B0B31923D2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-6-zhenzhong.duan@intel.com>
 <23957141-dc9e-415c-ae18-b0a0d2e5eb0e@intel.com>
In-Reply-To: <23957141-dc9e-415c-ae18-b0a0d2e5eb0e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH8PR11MB9484:EE_
x-ms-office365-filtering-correlation-id: bb6dd0e4-9587-4fa7-2560-08deace73b0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|7416014|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 67zmVvyfg+Ujs+taQGKbSDdi8XLA/A9shv7JAo2UfTNrGNG2f8ghkbqq0lGeGIsbfdITCR0yUn/y6v7JWfuElQqyXSFKuHhFaiYznPxge1i+gqqjX5idhfFn0qPZzHow6wgdDYFNCng7+9vf1sJ7aLWTBQfvU1nmomlssZic0xrp45MQMDXdlLaGbdNQYSLWinSv4kpr2cMoQBlHFgF2UT23x2sUdTM8snSM0SJga3FWsWWoS3ZbwynJscO6m2GpKT6GxbJoa0hadwWqkvLGzpnW17BXGGFUQewJUGlJuLsU9205rSiBzuYJaTMdqPSjDL84c+mLA4RFCKGLexXMdXX+bqMjtlOk5jrWcYeAcSYJIVvCeJv5z3uVfikAuLPbKRZTNXeGfdW9/x56zMBzcQw1do4wAbLWPkImLo1es6zHBUwaVxw/Izq1aM2BMSKhyavzSFYv0qQreL120ilSVoA7xXzbY/9d9lLC8qoUl9Fcv74lcxD12MSPoWxWL/FanJGkHVdKc+PxcSZtryjA29Vatk/b66zF9SDKgUb/4ae9cewRZnkDAGzweP7j1194D/0QC0CAuKJvVtJTxAioFlbHUUS6ITpH7kCNuJY93E/QkHJigiBmEL1YiwUm8n2ikVreKGwI30Asl3XeodSEH1dX8rljOCc/oaZ/X0MTUBDFXecj/YA8dyyQLC9KxtYpn9aKx9QuPsEQITwaVMyvOMbl4VI2/wP2t8MthmlgP2m0RY7fBqDISbIEv++AXi5v
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTdlQUNmS0J0RC9Mci9Eam1MRkhNZzZ1d0t4MUN6SllzcFVVOVdSTzFkVXU3?=
 =?utf-8?B?T2xCSzVUSGNMS0VPbVJlelE3UkY3TjY5aGhhc2NCS1hXSGpud0xCenhDdTFw?=
 =?utf-8?B?K2YxSWVmOUJoNk5sUUgveWt5cVBrT3BKTWpMV1h3WGwvdW5BWUtmd3pxcUIx?=
 =?utf-8?B?SWdDZTlTTGo3djloUTU5VG1idWVaMFNoZUc5dlprTGRKbDRqKys5WTdCOE9m?=
 =?utf-8?B?MCt1UEE0aGhvRmN2YzNZOVA2YTFrS3VycjJid1RNdG05L0llSEd5UjZrRXZz?=
 =?utf-8?B?VTczRHNpZ0MwaXJ5eTFDNzJ2RUM4clJHU2xRRXZDaHBXVW1lcWlQeFVGSitL?=
 =?utf-8?B?YmpIbUZ4Z1hMaHBvdk5BdzZTWmZ0MldESVRTMGN1a1luemZNNzRxcXo1aWFk?=
 =?utf-8?B?MlZWS1FZUXFvNEZ3SW01Wldqam11MXhjQnRlTXlkMVRodUFsVEJLUlVEVXlH?=
 =?utf-8?B?bUtJRDN3eXBxdjhncTFuWjVVM21sREZZampwWUd2ZEhUY3dKK0tSSHhlcUVp?=
 =?utf-8?B?dTZNWGlpcUFpcGZoYmhaLzhqd1RZeWpIQ2FvemlLRjJWU0JFZ0tGekNJNG5Q?=
 =?utf-8?B?WkphMExhNmJjV3hxZytrWVFzUzBwb0U3NVR4SGFxSnp5U2lla0ZXalBZaVpw?=
 =?utf-8?B?S0lWTDZra2V5NXlkSGROdEdqaXNsU3d0emcrR2dXUHZiU0F2VEduWmxjWE1v?=
 =?utf-8?B?aHVQWEp1aXhCdi9qZEppNGZBRVpqYTF0dnpjTFd0dzRjS3M1YmlYRlpOL3Nw?=
 =?utf-8?B?L3JqVzFPQlNvWVhMRWx3Mk11ZSt2Z05BV0xWMnFPRFk2SHZ4OEY1WWN1SytU?=
 =?utf-8?B?ZGFlVU81d0JzY1RBbUFWZVpqdmNCYkg3ZlBTTDZqdTE0QmlxN0dIUHNmR0NQ?=
 =?utf-8?B?ZVoyaFdiUVAvZW9hYWdCSVVWTi85TVlNLy9oend2N1d6WDdzbWVDb3A1clZP?=
 =?utf-8?B?NitwSFY1cVB1S25iK3JoRkRQS3NEWUtrQmtWU29SZytHQVRVdzg0OGhJekRE?=
 =?utf-8?B?dmxQbEkwRmJOa2tmTkpqVnBwV1hxdjNKb0VHUkNiZ0ZmMnJtUFRua3pxdzdB?=
 =?utf-8?B?UEF5b0hLT3grdlNZUUUvM1dwcU9zK0IyZ0xIaGNXcUlvWStnOTV4dmR4b25X?=
 =?utf-8?B?cFNGV3lqYnNFNVJ6dUVnZVdWRlAzTnNJeUkwMUFYVDl5bHcvODVCaGQ1UXo2?=
 =?utf-8?B?Q21GbjI0bmNGeGpmUDhtb0tERTlkWWRzblRabkQ0dDJlQnZvNk5qYlJFc2M0?=
 =?utf-8?B?S2J1c3k0L3EvMlF0TzVIcjVraUczQTZFWjJVQWxIVTk0ZFlmc083SUZIZm95?=
 =?utf-8?B?c0d5TjUzb0tTMEpHNk1IYjR0VCsvbHdVNWRTcmwwVEJJZ0lieGQyNThvcEtI?=
 =?utf-8?B?UC9pakpXeStDaUVYeDQxNjFvVFE4N2MxSmZYenNpZlQyNWRVTkZoQWhrZkw1?=
 =?utf-8?B?c0l6NjZQL3hBT1hEdW1vRk1LMkpaN0xCWnJBT3V2VktNZWhvdmlVK0lDOWZY?=
 =?utf-8?B?VWI1cGw0VE84aFYyRE5KN212alVWc3Z2WnJML2liQmJ1YUZWa3NYSkRYODVq?=
 =?utf-8?B?eVVHM2JkbEhPbWwrcFV4WC82cUxqczNNZXNzRy9EQU5aQzJFOCtNTTE1c1FP?=
 =?utf-8?B?ZzNjTFRmVFJhL0FwTXRDS2hYRnNWZWxveWFlbUlvWFhnV0lGdnU0amFnaUxn?=
 =?utf-8?B?OW9ERk9KNkltYXNjd2lrb2k1UVdYWXVVazRudkJlM2lZeU43bkZULzczekpL?=
 =?utf-8?B?dzFLT0tkRTNwdzZ3aG51MDV1dmdBM2xpV3lWejhWTEpzZHJLRi9Qd0xsa2Rm?=
 =?utf-8?B?UWJoZmNyRVd2aVZncVlvMWhwSS9GK0U3TVlqYVArQnJ6Y05ieVd3NUdVa3ZD?=
 =?utf-8?B?WnhtMlNaK1pQcmVMM3VJSER4UHRDSi9KYnlNZ2Y2clNjVzJmV2I1TEJZcGY4?=
 =?utf-8?B?bHZaYUliYm05aXRDNTdVdldKR2c2R2VTYWMvNU1YY0pKY1Y0TUp5ay92c09E?=
 =?utf-8?B?ZEdLZkhYemNla04ycFd4N0taK2lZd0RkTW01THVoWDVRU2hRZGF6aEdmdXlI?=
 =?utf-8?B?bDBGQ3JoK1VYV3JZYS96NkxYVTIvQTUwR0hMZXQ2eit0cnBMeUhwRHdIckpv?=
 =?utf-8?B?eEY5Mk9ub3RVMXRPaHFFSWxvVVZLWWVIN1NEakw3c1l5b0ZYa3RCVW9IYUhL?=
 =?utf-8?B?bTZKZWZMdzVqT29vUDE5NXN5MHNwWkJYdm94bWl1OHFpUlBCaXpSZlljaVlt?=
 =?utf-8?B?L3ZiVG9LK2crK2NoeVVrcmFJZ2xtNXorTWhlM0NEaU9QL0ZKWmwzSDk0alVj?=
 =?utf-8?B?djFhMFQxL1lQNXVtWDVKaUJ2SHc0b0pnM3ROM1R5ODZOMnZPOVFZUUdLSUVw?=
 =?utf-8?Q?RUuZ7pXQTExn0Byp/O/caO2NkzkJCDDB/dxR/cq4i3sii?=
x-ms-exchange-antispam-messagedata-1: +R+j29cHrDZTDQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tOQbvdzsjdPEOCWqpyDkZLYzUjLxy/rccndRD/yjWRmrhdG3lFrPYWSdIPxJmhnHHWAK+rE9INIh0DCpVHxkD2AGjXIifk9LfR/1x1toSvu4PFEh11ODB07RZD7chVG4GD36BA8RsrwUJQCMcIDkId011ZLfkHWNGoUOs5qQUSBBJXVWuil6bkZ1FzlKzEMj6FTOrUe+zmNLUiwwjxs4s00DqhCHwziHCJ0SNoLb+XsugflGOYBXKWuNYujDTvP1a1rpN1VwUywwprjEDpbkCqaYwsNDzm1yCl3ZyMVHl8mNJkB0q2NMdZLDo965p3re7NPShAH8tHvyYtkIwVGLIQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6dd0e4-9587-4fa7-2560-08deace73b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 09:50:26.0877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qbHT8VgvQDdLAFFtg8jdGobgnp7UbmURaAz32jiD/EsDPW15zPnKDXSi7soLtcgN32kmF9I9NkQwIfi/4+OLbwQ7TGRlnVT415DGlcb1mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9484
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDUvMTVdIGludGVsX2lvbW11
OiBDaGFuZ2UgcGFzaWQgcHJvcGVydHkgZnJvbSBib29sIHRvDQo+dWludDgNCj4NCj5PbiA0LzMw
LzI2IDE1OjEzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+ICd4LXBhc2lkLW1vZGUnIGlzIGEg
Ym9vbCBwcm9wZXJ0eSwgd2UgbmVlZCBhbiBleHRyYSAncHNzJyBwcm9wZXJ0eSB0bw0KPj4gcmVw
cmVzZW50IFBBU0lEIHNpemUgc3VwcG9ydGVkLiBCZWNhdXNlIHRoZXJlIGlzIG5vIGFueSBkZXZp
Y2UgaW4gUUVNVQ0KPj4gc3VwcG9ydGluZyBwYXNpZCBjYXBhYmlsaXR5IHlldCwgbm8gZ3Vlc3Qg
Y291bGQgdXNlIHRoZSBwYXNpZCBmZWF0dXJlDQo+PiB1bnRpbCBub3csICd4LXBhc2lkLW1vZGUn
IHRha2VzIG5vIGVmZmVjdC4NCj4+DQo+PiBTbyBpbnN0ZWFkIG9mIGFuIGV4dHJhICdwc3MnIHBy
b3BlcnR5IHdlIGNhbiB1c2UgYSBzaW5nbGUgJ3Bhc2lkJw0KPj4gcHJvcGVydHkgb2YgdWludDgg
dHlwZSB0byByZXByZXNlbnQgaWYgcGFzaWQgaXMgc3VwcG9ydGVkIGFuZCB0aGUgUEFTSUQNCj4+
IGJpdHMgc2l6ZS4gQSB2YWx1ZSBvZiBOID4gMCBtZWFucyBwYXNpZCBpcyBzdXBwb3J0ZWQgYW5k
IE4gLSAxIGlzIHRoZQ0KPj4gdmFsdWUgaW4gUFNTIGZpZWxkIGluIEVDQVAgcmVnaXN0ZXIuDQo+
Pg0KPj4gUEFTSUQgYml0cyBzaXplIHNob3VsZCBhbHNvIGJlIG5vIG1vcmUgdGhhbiAyMCBiaXRz
IGFjY29yZGluZyB0byBQQ0kgc3BlYy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcg
RHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IENsZW1lbnQg
TWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPj4gVGVzdGVk
LWJ5OiBYdWRvbmcgSGFvIDx4dWRvbmcuaGFvQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgMiArLQ0KPj4gICBpbmNsdWRlL2h3L2kzODYv
aW50ZWxfaW9tbXUuaCAgfCAgMiArLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAg
ICAgfCAxMSArKysrKysrKystLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gaW5kZXgg
MTFhNTNhYTM2OS4uZGI0ZjE4NmEzZSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+
PiBAQCAtMTk1LDcgKzE5NSw3IEBADQo+PiAgICNkZWZpbmUgVlREX0VDQVBfTUhNViAgICAgICAg
ICAgICAgICgxNVVMTCA8PCAyMCkNCj4+ICAgI2RlZmluZSBWVERfRUNBUF9TUlMgICAgICAgICAg
ICAgICAgKDFVTEwgPDwgMzEpDQo+PiAgICNkZWZpbmUgVlREX0VDQVBfTldGUyAgICAgICAgICAg
ICAgICgxVUxMIDw8IDMzKQ0KPj4gLSNkZWZpbmUgVlREX0VDQVBfUFNTICAgICAgICAgICAgICAg
ICg3VUxMIDw8IDM1KSAvKiBsaW1pdDogTWVtVHhBdHRyczo6cGlkICovDQo+PiArI2RlZmluZSBW
VERfRUNBUF9TRVRfUFNTKHgsIHYpICAgICAgKCh4KS0+ZWNhcCA9IGRlcG9zaXQ2NCgoeCktPmVj
YXAsIDM1LCA1LCB2KSkNCj4+ICAgI2RlZmluZSBWVERfRUNBUF9QQVNJRCAgICAgICAgICAgICAg
KDFVTEwgPDwgNDApDQo+PiAgICNkZWZpbmUgVlREX0VDQVBfUERTICAgICAgICAgICAgICAgICgx
VUxMIDw8IDQyKQ0KPj4gICAjZGVmaW5lIFZURF9FQ0FQX1NNVFMgICAgICAgICAgICAgICAoMVVM
TCA8PCA0MykNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCBi
L2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBpbmRleCBlNDRjZTMxODQxLi45NWM3
NjAxNWU0IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+
ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBAQCAtMzE0LDcgKzMxNCw3
IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4gICAgICAgYm9vbCBpbnRyX2VpbWU7ICAg
ICAgICAgICAgICAgICAvKiBFeHRlbmRlZCBpbnRlcnJ1cHQgbW9kZSBlbmFibGVkICovDQo+PiAg
ICAgICBPbk9mZkF1dG8gaW50cl9laW07ICAgICAgICAgICAgIC8qIFRvZ2dsZSBmb3IgRUlNIGNh
YmFiaWxpdHkgKi8NCj4+ICAgICAgIHVpbnQ4X3QgYXdfYml0czsgICAgICAgICAgICAgICAgLyog
SG9zdC9JT1ZBIGFkZHJlc3Mgd2lkdGggKGluIGJpdHMpICovDQo+PiAtICAgIGJvb2wgcGFzaWQ7
ICAgICAgICAgICAgICAgICAgICAgLyogV2hldGhlciB0byBzdXBwb3J0IFBBU0lEICovDQo+PiAr
ICAgIHVpbnQ4X3QgcGFzaWQ7ICAgICAgICAgICAgICAgICAgLyogUEFTSUQgc3VwcG9ydGVkIGlu
IGJpdHMsIDAgaWYgbm90ICovDQo+PiAgICAgICBib29sIGZzMWdwOyAgICAgICAgICAgICAgICAg
ICAgIC8qIEZpcnN0IFN0YWdlIDEtR0J5dGUgUGFnZSBTdXBwb3J0ICovDQo+Pg0KPj4gICAgICAg
LyogVHJhbnNpZW50IE1hcHBpbmcsIFJlc2VydmVkKDApIHNpbmNlIFZURCBzcGVjIHJldmlzaW9u
IDMuMiAqLw0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggYjc4NGM1ZjEwYS4uZDE5NDZlM2E1OSAxMDA2NDQNCj4+
IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+PiBAQCAtNDIwMyw3ICs0MjAzLDcgQEAgc3RhdGljIGNvbnN0IFByb3BlcnR5IHZ0ZF9w
cm9wZXJ0aWVzW10gPSB7DQo+PiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJ4LXNjYWxhYmxlLW1v
ZGUiLCBJbnRlbElPTU1VU3RhdGUsIHNjYWxhYmxlX21vZGUsDQo+RkFMU0UpLA0KPj4gICAgICAg
REVGSU5FX1BST1BfQk9PTCgieC1mbHRzIiwgSW50ZWxJT01NVVN0YXRlLCBmc3RzLCBGQUxTRSks
DQo+PiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJzbm9vcC1jb250cm9sIiwgSW50ZWxJT01NVVN0
YXRlLCBzbm9vcF9jb250cm9sLA0KPmZhbHNlKSwNCj4+IC0gICAgREVGSU5FX1BST1BfQk9PTCgi
eC1wYXNpZC1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBwYXNpZCwgZmFsc2UpLA0KPj4gKyAgICBE
RUZJTkVfUFJPUF9VSU5UOCgicGFzaWQiLCBJbnRlbElPTU1VU3RhdGUsIHBhc2lkLCAwKSwNCj4N
Cj5ob3cgYWJvdXQgcGFzaWQtYml0cywgaXQgc3VpdHMgYXctYml0cyBhcyB3ZWxsLg0KDQpZZWEs
IHNvdW5kcyBnb29kLg0KDQo+DQo+PiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJzdm0iLCBJbnRl
bElPTU1VU3RhdGUsIHN2bSwgZmFsc2UpLA0KPj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgic3Rh
bGUtdG0iLCBJbnRlbElPTU1VU3RhdGUsIHN0YWxlX3RtLCBmYWxzZSksDQo+PiAgICAgICBERUZJ
TkVfUFJPUF9CT09MKCJmczFncCIsIEludGVsSU9NTVVTdGF0ZSwgZnMxZ3AsIHRydWUpLA0KPj4g
QEAgLTUwNDUsNyArNTA0NSw4IEBAIHN0YXRpYyB2b2lkIHZ0ZF9jYXBfaW5pdChJbnRlbElPTU1V
U3RhdGUgKnMpDQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAgaWYgKHMtPnBhc2lkKSB7DQo+PiAt
ICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1BBU0lEIHwgVlREX0VDQVBfUFNTOw0KPj4gKyAg
ICAgICAgVlREX0VDQVBfU0VUX1BTUyhzLCBzLT5wYXNpZCAtIDEpOw0KPj4gKyAgICAgICAgcy0+
ZWNhcCB8PSBWVERfRUNBUF9QQVNJRDsNCj4+ICAgICAgIH0NCj4+ICAgfQ0KPj4NCj4+IEBAIC01
NTg2LDYgKzU1ODcsMTIgQEAgc3RhdGljIGJvb2wgdnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01N
VVN0YXRlICpzLA0KPkVycm9yICoqZXJycCkNCj4+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+
PiAgICAgICB9DQo+Pg0KPj4gKyAgICBpZiAocy0+cGFzaWQgPiBQQ0lfRVhUX0NBUF9QQVNJRF9N
QVhfV0lEVEgpIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlBBU0lEIHdpZHRoICVk
IGV4Y2VlZHMgTWF4IFBBU0lEIFdpZHRoICVkIGFsbG93ZWQgIg0KPj4gKyAgICAgICAgICAgICAg
ICAgICAiaW4gUENJIHNwZWMiLCBzLT5wYXNpZCwgUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRI
KTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gICAgICAg
aWYgKHMtPnN2bSkgew0KPj4gICAgICAgICAgIGlmICgheDg2X2lvbW11LT5kdF9zdXBwb3J0ZWQp
IHsNCj4+ICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiTmVlZCB0byBzZXQgZGV2aWNl
IElPVExCIGZvciBzdm0iKTsNCg0K

