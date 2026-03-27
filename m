Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF19710AB83C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 01:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5w2I-00021C-Qt; Thu, 26 Mar 2026 21:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5w2C-00020n-Fy; Thu, 26 Mar 2026 21:30:49 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5w25-0002GN-Bg; Thu, 26 Mar 2026 21:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774575041; x=1806111041;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wSYhc6vo2epv+k9YrxjnTSrmutGDpDqH62hJfRi/wOg=;
 b=XP5uCfStLKnVuEJm0aJIApVJkK1Q8buleYxF0FQIP7/GiQMP7Mjz6K5n
 8UKF6LszSGgxOdXtdNSYCHGbWX7IQ68hdqP5DWr2xx/HPxg72pVGhlW3N
 KzlY2PYVjAGQKQLuzfXarpLn1KXXU+yowKtYPgORd3ans7S/Snmlejptg
 NIJYXGY7BZsMFQsWHEi25amL56muwV5u3CvZF7G7fABja55pqnaF9VbSc
 rKzJ/nfnE7laE66Nwv/2PyYIjHTffM2XmVJjmudsupajJdN9uqUqf8ypm
 n8BCHEjwj9r6s+4TVOB906FEttW/qhUjA9MHEFbw5dqeoET/tEmDGe9gw w==;
X-CSE-ConnectionGUID: cJpKcpVCSmyTmEOYn9vdHg==
X-CSE-MsgGUID: qGhU3LyWQtiXcMPa+psPrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="93228173"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="93228173"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 18:30:38 -0700
X-CSE-ConnectionGUID: +JOloLb2SIyPCSpAeHk/wg==
X-CSE-MsgGUID: uITRd/6mRsuX8k3DoMMNlw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 18:30:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 18:30:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 18:30:37 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 18:30:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOX8dzMevv6G7KEozsJNughLEiyWN/c6tG1jOQrzi1xMY6OJb+1XVIlxKJZ6d0uidR022qnjfzqzsV9BZQjeQeS32lrTwmByOtK+Etv5ObYaZbExyyyVlzsdwZOlA0VPYQqxjpgzBnl2MJiqLo48qrq5HJ2VnCj70LVsjHXIIpoCO6DS2wWHMuM3sbu4C2EMYjQwvvK+duqkLKqKPaB8zmVsBvbvJylZoXjsmmFNXI4Gbjtsbe10ARmJknUdxMuqtZqLdA1S1RhFPzTGmnmfzEXpAB4EatGaX/14muZtyR4wFMTM9m+gRq03Ntx6F1SiJTcXuMvW8kDOXlkyZn13vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSYhc6vo2epv+k9YrxjnTSrmutGDpDqH62hJfRi/wOg=;
 b=jp4LJgXLKpzICNayxSqWRRtP6Kmt56GT+2MqJLVu2RVpC6Xr9wnImecKYoifBP8WYKdB5m14IHKS54WuMmU8oetyHbJKie4pAomn1DmIv3MZZkvVj5Wwisxs9yPC55vkitN2ZdhjiBSfQd0eMLC8jQ+TE5WRdAVfj2fOVOijcJYyjnuvXDC6JGIwZQnmbwHCimNY/m0vqg2fPq32Q5NeQ9xXeQckJ5WuvAL74mUXxkDUTzJ06G/1YSoIcMYb+mU6ujiPH05mLODGy+jIVyPzhON3xd9BHUXlN1tbsueTd+E250P0v6qsNyQBqNZZx+PxQ0drBPd8zhDAD1njv6g2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB6612.namprd11.prod.outlook.com (2603:10b6:510:1cf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 01:30:33 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 27 Mar 2026
 01:30:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Landon Clipp <landonclipp@gmail.com>, Steve Sistare
 <steven.sistare@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: RE: [PATCH V6 06/21] backends/iommufd: change process ioctl
Thread-Topic: [PATCH V6 06/21] backends/iommufd: change process ioctl
Thread-Index: AQHb65ySsm3efUYUE0GrBKF2anf6SrXC6LkAgABR/zA=
Date: Fri, 27 Mar 2026 01:30:32 +0000
Message-ID: <IA3PR11MB91365C0D06544074B5C783F99257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
 <1751493538-202042-7-git-send-email-steven.sistare@oracle.com>
 <DHD021CSIBZK.3PZ1A7CQUUBQU@gmail.com>
In-Reply-To: <DHD021CSIBZK.3PZ1A7CQUUBQU@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB6612:EE_
x-ms-office365-filtering-correlation-id: 311463e4-2199-4c85-cfe8-08de8ba07064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: qOLVzPJoDmrlWlQ24n/ANylMNl1axAQo8VmhRphImNXafMSFWq/ngydDTXVyBCkSUGAT+UWdyeuwDvlcQUhK/bAgqgNCE5X1rdQSxvuxSaL+EG77CMDhWRz6V/ZiEfn2bfUI8bMfFpy77FUQD5k/5J5i08Vg/xy6aag/ReGHnk9ZLPwpuTC3hpeD832KimH7JrnxlygyR6i2kxut2yV/2ZGvVYkPkVcve5Enmok4hpnjmiqs8B7iOlX5j/7hpAZMK2+PWCKeLcMrVJbULEmNR2wo/cELaQ7I+RDWScgEDNTp85vYr0KiRuSlbWMu1PVvzG5xkX4TJyZUEKt9t7zn93UIW82vV+mWrVq5cqonlGVTIU0CmTvbee9RfPYeeiMxDeVLqVVzWzNbLVPeDfwCDO0CNpMa5VcPPXyyiyk10O41WZ49WQoRP1mYFPQpvz9Dm1AFbc9iKI0nq5ul4Vhe+nbzvh/gOO6tl4pYbmpIK1bl/uvieaG8US4gZdxXJC5R/rJF/Bwp7ZL7iiUbGc77brXCNVSTwfaH+cssSeBtrVsblbVAMGRshdR82VrM7CV3iTLsfISZ50YFEMvdBsQKvh9sXKqDh5pFNSRn5gn9zmwPbkfvWaFJhEHYj7n69IsHhzetOPZBmyhWz8VUzI5u5DVk7Qaf6etko/Jarm8MC0IKiVcSR33KgWN+RIcoRncQB6zXMYdkznjQoAu7DNX6NY+89FxmlUnbB0ZQvmtvhRwrYD4NPsa67kq8tiyolHus2jz9XycBZmFKv8/ZSQM0cA20McWllxRK3aj3Qve9TmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmdoZ0ppeDNoeVlGalYrc0lVRHI5cHd4U2ltQ0pQY1VxUHlmTEI0Q1ZGRDZr?=
 =?utf-8?B?c3UvQnNsc20xVlFiVHR5eVlhd0Zqa1RON0NFRnJRS3U5RnNBNU04VWJrbm5m?=
 =?utf-8?B?Q0hqSlBQcDZSYWtpQnpFcytseUl5QVlBbTVVekMwc0xlY1FLRUJiYklpMzRh?=
 =?utf-8?B?L0FKRFMwSEhQTkI1Y0VVL0NnUjJEbGk5UFluYzRoSnYxSHVoKzJ2Wm1YdSsx?=
 =?utf-8?B?OFIwakQ3dlM5alF1MVM3SXJtbHh3WUtPR1dTNDJFckJVOWNFZnlPQlpkM2cz?=
 =?utf-8?B?eFdvUEJGeVptSnByL0IvcWN5ZVVuQmVMQnRFbUoxWXl0UkdMdXUxZjFkOG55?=
 =?utf-8?B?V3VFWjNwTUNmN3cxOXlrY0ZiMXp2VlBrNFBZTmgwRko1dVozUjJjRjg1YVZO?=
 =?utf-8?B?SVNWYlBXMlZucTJDckR3SVYxZlJpQVVseFk1OGh6cnZjSytkaUFQTFJTVWhZ?=
 =?utf-8?B?cjVFWkFQOUpHWXBnTnZXeEJENVhISnljTFd1aU1CeTJkM3pZR2VpakJXdm5I?=
 =?utf-8?B?bUV0cTFXU21LaE9lZ0NPWE5OY1BRZjNGK294U0pUdkdBR1FHdjNpakwwSFpt?=
 =?utf-8?B?czJwQUkwSWg5UzMrZ3dqcXRvTWZwM0NZSGY1SFc1b2NPcjc2YlRMOXlCVjkz?=
 =?utf-8?B?K3owZFRFbjJwNWxOSzJJS1M5Y2ZBeW1QMnVjMmE0S081bVNlN01VQjBHNURr?=
 =?utf-8?B?bmZCUCt5YmNBVHBEZE4xbGNXMTdxMWxHU0RkMXVPRmdmY2pMZDRMTGlUVEVv?=
 =?utf-8?B?Mmk4UnJtSjlsSHZ3LzlCQkV6dTFSWDg1YVRjRTViKzRsS1lrN3k5SnZ6Ukxu?=
 =?utf-8?B?VlJ5UTZsNE1YU251V3lLSnA4VTlmRlUzSnlJT0VObVBGOXU2Ty8yZ3hTVXVz?=
 =?utf-8?B?U2ZndlROdHQ1K25jYkpoQzl2aW9ka20raEZDbmJtcW9UUjl1Z0Ftc2w4eGNG?=
 =?utf-8?B?dDYrM1ZCTmw3a0xFZmlvakZSTHIwblRmVzhqVWJsbWFRMWFFQXhBNDJOUmxn?=
 =?utf-8?B?dmtDYVZlakJsaDY1K2ZjN1hiTkl1VTEvTXdFZlRLYVBKbWozb1dVM3FhYW01?=
 =?utf-8?B?ZlhPZ3RyeG1pTWNKdk8vaCtvZ08ycDd0WHlIU2xGZW82azhCRm0rY2NRa3pv?=
 =?utf-8?B?bTl4T2J2NjJmWlZEUVlXdkpRTU85NjBWZE5tc0h0eEg4L1BhNURZVWplcjdZ?=
 =?utf-8?B?a3Q2M0FzWEFwakc0VllhcFltdjZHdnp3SlkweUpkaW9FQU84M3p4SWVZck55?=
 =?utf-8?B?UWFJcWJxNVZPT256eUhZbGt5c01qSmlKV042NG5sT051UU5aeWc3VUZnQUNm?=
 =?utf-8?B?TEVUT0MxOEdyNXVYT3hyeEd0eFlJUGRYSllhSUhUOWgxNUpRVWZIbDBFWTdB?=
 =?utf-8?B?Mm12UjIrQlMvSFN2UE81Z3FjTUtoeTlKUmdoRG8vTnc5MFROaURPZDgyelBk?=
 =?utf-8?B?dTlnOW4rdzlESzYwaEVmOFgvSC8wejhNd0tIWXh2OWM4QVR6SWU1Z3dvY3pq?=
 =?utf-8?B?aHF3M0RleC91cURjMExQL2hqUFQ1U3EreWlPOFN6KzQxczd6Y05IU1JRMHpn?=
 =?utf-8?B?Zk80MUhrRVlMY1RYcUV3L05mNThYbVY2UW1xNTFMMTZOeGRpRDNVQVYyM2ZU?=
 =?utf-8?B?amlYNmVPZGVmd3JzTnRpM0FBY014OXdaeFdSSnZCdG4wK2lQK1NEQXdlTzlO?=
 =?utf-8?B?NE1KbVYydlFSRVJXMWZWUjcrV0YzQTNITW9SVFlSL3JtWDNYL1hROEZXREV4?=
 =?utf-8?B?ZlVrZndwMjR6amVubGFERE1SSnZ4K0pRUDJ3bnR3aU14dXI1L284S0k3VURv?=
 =?utf-8?B?cXBLV1hodmlEalkyWmY3b1ZwU21aN2FVSUQwNUF3OWMzYkFnYTZwdzgxM0Nr?=
 =?utf-8?B?UnBHUXVKUlVnZEpyMkdnZkllZE5FcHdyY0tqblJXb3FOTjFycktyWU9EL1BF?=
 =?utf-8?B?UE1RRktSYVZQZkRPUTlqWGdWZ2c5SGJrdFhRNTdNRnY0bEV1SzJjZGlyVC9a?=
 =?utf-8?B?aXFtUlU5b3B0UUNYMEMrSllMQXpyNCtheXFpZDk4YVJ2S3NzMTdFMnNyUVQv?=
 =?utf-8?B?Yi9OM3hsR3FwWVZJckFjWFI4RkVPbTNJMlVkNU9PZWtmcU5ZeVdqZ0YwWDBQ?=
 =?utf-8?B?WFMvREwrR1NJeFVHdjZlWnBRNVNaS29mYjlRQTBGdER2K1hmS0owanIrU3Y4?=
 =?utf-8?B?ckJPS2p2MTJZa3NLakU3d0pNcStFWU8xQUExTEt1MmdzYjdUUFNJcFE2THBL?=
 =?utf-8?B?RCtDMXkrNytZRTBYQXZIdFdnSnNpQ0FmWXNkRTJEUWFZWFlKTlJjbmJWaW9H?=
 =?utf-8?B?T2c1Mm1FQTlZcGNPTG5aRGExV1ZpMTJPRVhyUE9rbTBVS00yK3lOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rg4rwXq3PMSD6aFzzndp+nKW3kqYhBB+oPQ2b915KXNVg/t50jEoXDHtTTXpT3984sHhzphStJZkyvAuFt+c5ofeYyR2A9jrPmib0rKQ7rlIjWu8ojINnOOxy92qLTBEsYjiKhe/PtKyhzybPlB/yuG0fLhKglEb/afcHLE2Th3MikGIDKVltVyt4O9QCG9WrAX7t7MalIpZcZoZugyI3jYAMgEJy0z5mO5Y+lUA9VF711wgO/238zLwJnYpNcu60BshIM40Bv6Pnrfi+yCTogaN+JngujLi7KRhouBv4zd9WrH0o9mnpDuBEfO2wZYhCju1cN4Gl5ip6C0dOOk3lw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311463e4-2199-4c85-cfe8-08de8ba07064
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 01:30:32.9326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vbq4ED5RiiE1lFYXAEKq6CdsI6brF6fHQ8WwWKrZAMoCjSK3mWbTFR2LS1Yc2Agt1M+TqaRkhAxPNO2iF54525PuEH7jkU7pT9qOqV35Erc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6612
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
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

SSB0aGluayB5b3UgbmVlZCB0byB0cnkgdjYuMTMga2VybmVsIG9yIGFib3ZlLg0KDQojIGdpdCB0
YWcgLS1jb250YWlucyA4MjllZDYyNjQ5OWMxMWM5ZDExYzY1ZTkzZmViYzFlMGRhN2NkNjFiDQp2
Ni4xMw0KdjYuMTMtcmMxDQp2Ni4xMy1yYzINCnY2LjEzLXJjMw0KdjYuMTMtcmM0DQp2Ni4xMy1y
YzUNCnY2LjEzLXJjNg0KdjYuMTMtcmM3DQp2Ni4xNA0KLi4uDQoNCj4tLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPkZyb206IExhbmRvbiBDbGlwcCA8bGFuZG9uY2xpcHBAZ21haWwuY29tPg0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjYgMDYvMjFdIGJhY2tlbmRzL2lvbW11ZmQ6IGNoYW5nZSBw
cm9jZXNzIGlvY3RsDQo+DQo+SGVsbG8sDQo+DQo+SSdtIHJ1bm5pbmcgTGludXggNi44LjEyIGFu
ZCB3aGVuIHJ1bm5pbmcgUUVNVSAxMC4xIG9yIGFib3ZlLCBpdCBzZWdmYXVsdHMgd2hlbg0KPnN1
Ym1pdHRpbmcgdGhlIElPTU1VX0lPQVNfQ0hBTkdFX1BST0NFU1MgaW9jdGwgd2hpY2ggaXMgbm90
IHN1cHBvcnRlZCBvbg0KPm15DQo+a2VybmVsLiBIZXJlIGlzIGFuIGV4YW1wbGUgc3RyYWNlOg0K
Pg0KPjMzODgyNjAgMjI6NDg6MzAuNTQwODc5IG9wZW5hdChBVF9GRENXRCwgIi9kZXYvaW9tbXUi
LA0KPk9fUkRXUnxPX0NMT0VYRUMpID0gMjUNCj4zMzg4MjYwIDIyOjQ4OjMwLjU0MDk0MiBpb2N0
bCgyNSwgSU9NTVVfSU9BU19DSEFOR0VfUFJPQ0VTUywNCj4weDdmZmU5MWQ5NjQ5MCkgPSAtMSBF
Tk9UVFkgKEluYXBwcm9wcmlhdGUgaW9jdGwgZm9yIGRldmljZSkNCj4zMzg4MjYwIDIyOjQ4OjMw
LjU0MTAwMyBjbG9zZSgyNSkgICAgICAgPSAwDQo+MzM4ODI2MCAyMjo0ODozMC41NDEwNTkgY2xv
c2UoMjYpICAgICAgID0gMA0KPjMzODgyNjAgMjI6NDg6MzAuNTQxMTIwIC0tLSBTSUdTRUdWIHtz
aV9zaWdubz1TSUdTRUdWLA0KPnNpX2NvZGU9U0VHVl9NQVBFUlIsIHNpX2FkZHI9TlVMTH0gLS0t
DQo+DQo+SSBoZWFyZCB0aHJvdWdoIHRoZSBncmFwZXZpbmUgdGhhdCB0aGlzIGlzIGEga25vd24g
aXNzdWUgYW5kIHdhcyBmaXhlZC4gTXkNCj5xdWVzdGlvbiBpcyB3aGF0IFFFTVUgdmVyc2lvbiBz
aG91bGQgSSBleHBlY3QgdGhpcyBmaXggdG8gbGFuZCBhbmQgcm91Z2hseSB3aGF0DQo+dGhlIHRp
bWVmcmFtZSBmb3IgaXQgaXMgKGFzc3VtaW5nIGl0IGhhc24ndCBiZWVuIGxhbmRlZCBhbHJlYWR5
KT8NCj4NCj5MYW5kb24gQ2xpcHANCg==

