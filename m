Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660DCCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIkH6-00021D-7J; Mon, 19 Oct 2026 06:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xIkGz-000209-TY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:07:18 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xIkGx-00076f-L9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792404436; x=1823940436;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4IPlkdxC4k66nNr+ew/uiG57d2CiXLp/a4gHVYXmDCk=;
 b=OVY4gdp8ZGtdbNtLU2Xyc9vZfX0P0u3gEiZlKR4rKzveslLe6OraUFJB
 8YuFGJxecq2sWgR0/B9NVRzv6/WJuLqF3Zo0zY/6aKkIx0HX9b3wUNY/j
 fhtK5r3JUlDUTYLXFn7LUWvJvY5YQ4rih/CFgctAmXLfkWN3B/27Qr0wE
 X939C1ry1EmolOoB2Xth2ktr6napUKhNTCsC+sxh/WsAcrImC2V7+73C3
 OK4f+UKPPZyJ2s25gRTicYuA84iOqRv2vfpBFToq7DKpnH8FqotPFWMsF
 py8zP5A03vZis71SDFJXSTyVvdfX2/BsRwgzOBTbtDYPvK2SHXJ7QIKI2 A==;
X-CSE-ConnectionGUID: mkEFU0e7TOukkMFVfjVoTA==
X-CSE-MsgGUID: M2/4k052TtidDUq4Mkvlvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="982207"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="982207"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 03:07:13 -0700
X-CSE-ConnectionGUID: My8AYRuxRK6jug2ZNY+uZQ==
X-CSE-MsgGUID: O9tcYUt1RB6rBTzsU/RXEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2439725"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 03:07:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 03:07:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 03:07:12 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 03:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STTsgS1A4EeWWz1SOhfFVezXzBOTZ31fqBscQSKh1KjmfCiQe2vvWnaOW3RUR+bAszJcYaEkNGPgoWTMsbA3p8BjOuLfVy0y3JVG1MWTtO+CjYVesYMvhz3SXff7bfmNcjlGB0qcKcLVQk1fFSYtD1vcK7D9+VIhXLTzM5DJei1p1mtLzy2APGSw/7QFF1FopLxjBEDNxWticbh/4k5BrMxtZlbm7Un4nBmHjgZakr3C2PqWwmgqAlUYrs/l7H6rXH+ZtZdq5a3dtpxRJ+cwHf20oY/wexTSrAfNTX10g/PmMpzlMTgmSPsiBaCuw0dqKKfirFc0xGSHSpGv3V++Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IPlkdxC4k66nNr+ew/uiG57d2CiXLp/a4gHVYXmDCk=;
 b=eMS5etcgk1fqmb3E5DhRFbHVpbPUuuQyen+TgF8rK8S+l8K788+L7bwvdoQkQu/nf79j/0b9KJ2KtZp5rwCiFFQBUfrlprlBV/rToXCZTESZQ2mMw/Ess3QubordP8Iwaz6RIKVYTxzgW40LPflDWJs/gdxonSwLS5DGe3IM8BFbm9qLfG2rwDVNqqjs4PTk6M5Ty39GrJymjshM4fDmhbtWO7KUYqZL4smGmgzcG7ZfI655Snif8VJ6mgFd3zmDyss80W29rhXioP3XlJGpXuy5grJYL4aKsKapjuKpdv8W4DpCoFGAaH8l4U6O4PZr5iy+Sc2p87ISmD4cJk+Adg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:07:03 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:07:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v8 5/6] intel_iommu_accel: Accept PRQ response for
 passthrough device
Thread-Topic: [PATCH v8 5/6] intel_iommu_accel: Accept PRQ response for
 passthrough device
Thread-Index: AQHdV8275UZVIA1lz0iyrrMMI9ipZrcDYpIAgAFO0aA=
Date: Mon, 19 Oct 2026 10:07:02 +0000
Message-ID: <IA3PR11MB913685355340A53071AF50D892982@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
 <20261009090737.3930000-6-zhenzhong.duan@intel.com>
 <bd3191df-1503-4caf-8b06-69e8a140268a@intel.com>
In-Reply-To: <bd3191df-1503-4caf-8b06-69e8a140268a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB8109:EE_
x-ms-office365-filtering-correlation-id: aee75532-3504-4a61-23fe-08df2dc8b8fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: MbJMP3PuvAcfDatGJAN50iB/AX92r1ExJw7yvCYICvcZPdDUbtCGct89ScLEP2rHLrLQtGskpchFCi5yZ2oLPH4hhfLvl4VWcUen12Ta3R11j3O1fJpbyieGpQzXCO0cpHWhU4wvbsOP4iq5jta+nJ6nOphe0Zqj3E5mr6dWXc++kTcoEDMYoRmmuXH+VY6VXrQOTdb/CSCDMB6+vWX5hO8vylZKv5DUlFGuMxnLfGzucdljyQuT2eAV0qOXEL+BtYcvdqjrgyaBHGRvBj/uwWyO4ywRRREkHVl4m9IuOiNQ9KU9hLdw6URrjc0nrQOMcbBs4nKapiIqdC7J962QS9BiRWSdhw8WzfgRrX28INAX7hCVNyGm8obMfB2zrXliVkugd127+jA2EbAiBkLkXJ9OZuIbzMVgFyJpgMLfSYior6LPH7Uw6j+yU08e01R80EF4HFxuSwjJZJvn/tXMxVmcaQl8RqXa3rRnINuBWUaAxR2qXMrpm6GJM7lbHz5BzDMs8WwgKEadIJqoIuUfrofsd1A7FulNQ4iB9VE9yrCPT+WTDU/ds2hGfa29/p8Msg9hBdNaQciBQeukGMPPI/kQR16k6VMUVoJ2eB6Zo9akFdV+vfGFZuhX5ZQ26PV5Jw9UPQASvp+ngjpBw8dVPLlHRKDTu5Cy7VPrwjNINHEFRxBuMS1qgD/Mffy0ets+IqhOQGZnLuWVFtGH1weJ66bFvH8vtVS57PvhHyXj75Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWw4aTJSNEU2NngvbGtrZktmd25EckpvSzZ6dGtEcWhsVzd0alE4d00vN0l4?=
 =?utf-8?B?YXExZWszZVIvZ296ZHgxcHJneWFGV25DZ2ZzaGVTMk1ybGRsU3VYcS9tNFdu?=
 =?utf-8?B?YVZrdlRnNkhnVWMwMDNvN2I5TmNxbHc2ZjE5WXNqdmo1bkJTTW5scGdabWZ0?=
 =?utf-8?B?NldSQkdmczVJRVlDVE5NT3J1bHVkc3h2NE5lbzZZU09weTkza2ZHeldFWlNa?=
 =?utf-8?B?N3U2eUUzTGhOd3V2RklXWHJXbHphVm04Ukc4VXhUb0dYYU92dGVmaWd0aFdo?=
 =?utf-8?B?Mk5JaWtWZWVEcGVKUHRwWWJzb1IzbHloNHRadHJQYWhwaVBmWm00WFNYY0Jw?=
 =?utf-8?B?YUNzc0M1d1dQT2gxeGgvVytQVVpJZU1TR1lYRlV5dE1tTDRiVld4aHlqY0Rl?=
 =?utf-8?B?RFpUdUs3UzNaTloxL3EyN3Vqd1FxcjI0MmpoVC9qTVN3azhMOHVHNWdhQXhs?=
 =?utf-8?B?VkxpaysyNCtZUWozakpzMGlUWllveDJKWmtHTnUwajVodGtaaW1RblQyVFVn?=
 =?utf-8?B?MFVXeFllck9weFM5SVp1dDlxMTZENkh5am1NUzRvSVZ0MzcyOFdBNjErNTJr?=
 =?utf-8?B?SVJES1VhZnJSa2N4S1BrSnQ3dnVqZlJlUTIxbEpZdEtqTExHWTlWdTN2U3V2?=
 =?utf-8?B?UjExczlsMFlOcnJNc29iOEhFWER2cVFLRHd0d0JoZktpL0U1WFZhNGFTcWhX?=
 =?utf-8?B?V3lOcGp5Sjc5eEVVNFg0S1o4WUNnalp1TkJYcDcvSjcvK2I1NjNBTmQydzNx?=
 =?utf-8?B?V2VFV0NPYVd5bkh3czF2NHN1dmV3Z0wxWWRUUXBVREU0anVZajU2aDhHN1lQ?=
 =?utf-8?B?TTZUcy9ZL0NpYXFjU0diWHJiWEpYREdrQkpkMVpjaUpVQ2VHQkhwRlp3WHBW?=
 =?utf-8?B?cmFCb2o4Tjd2RUVJNEVIM1F0cjRkMnFkRy8zU3RDYzVHR2RuRkVYVnZxelU2?=
 =?utf-8?B?T3NpVFErT2JyQlRHOUY3dnFpY2FqWWwwVmFsbVdVVG4rU1J3QXZaMTdOeTJP?=
 =?utf-8?B?dE9iQXBCYUs0T3JUdkMyektPYk50Z1JLUG5LMDRpZzNmc2tRRWN3dUZMdm9l?=
 =?utf-8?B?WGdGUnN1cFIycGRqTER4Nk40U01vemtoaFVXbEZMaXVOVjZpcTNzM1pvVW0z?=
 =?utf-8?B?Yy9LWitCckduWWF5S092bFdzYTI1bnE2YXpQN01YNWZMUloxZko2RDVNNzcx?=
 =?utf-8?B?dzJWc2ZNWEdZOEpoRHJTQTFjUkNnclNUb0Y3d2d1bEtIc3p6NmhpWklGZ3l6?=
 =?utf-8?B?NEhpUzNRQ01vcnptT2hmVFlLTXhFN1IyTnB3S1dYM1V4TGx6RTJDK056RXdL?=
 =?utf-8?B?REJNRlJ3NGRBTWx0WlhNaWRyTHZ0N1E4ZFlWaXorMmtNNjZNeXZpRVd4RmYv?=
 =?utf-8?B?RExQcFhrZTdya3dCMTFHZVdjSzhXMjRQcy92bGcyNG5VeVM5dkJhd1dseXoz?=
 =?utf-8?B?dmZrb0Rwejc3cjJkSVp0VWo0dW05ZzZnVjB4cUVsMHlEdmxUaVY3S3dqalNR?=
 =?utf-8?B?UzVudnRnR25WMlZ2bFQzKzBCVWgvRG16dlhtMlhaVm4vSC9VYklMUG1Nbm84?=
 =?utf-8?B?MHArYWdicjNZb0UvTTZWdEVwb0R3WVdPNG93TmFFaTkyUnhWdGZDY2x1SnVK?=
 =?utf-8?B?ZG0vYnhTUjc3b2ZFWHhXbHJUTTlJUE41MUtWZzc2TFlucEtCSnVxak9xL1FC?=
 =?utf-8?B?ekNmRDdENnBnd2JTMXlaeVBqMk82Nk9FMHB1YVJZRWpaQ25IL3NmdXNzMGRU?=
 =?utf-8?B?TXZraFVnLzZWdXlmdnNQaHRVdTRacTg2eXdwQ0s1M0lhRDBSenNWR1NsY1c1?=
 =?utf-8?B?RDd6V2pWMDVDamxzbjJyZnpqOGF3UTZIMlU0Rm5leXJCWXptdURPMzh5c01R?=
 =?utf-8?B?dTQzWWRFMXNQZGNvTy9CdDFqVUpubmp5UnFFbEZJMW91Q0c4dEphK1g5M2Mr?=
 =?utf-8?B?NVZZRzVYRGZ0c2tXWDlMaERKUGlNN1FpVU9rdzIzbHNZdzZNTUJta2FQeVpH?=
 =?utf-8?B?bjRCVUpzRGlCVGZMTDhscmdvMm1EYndZaUEweGR3OTR1eU8wWFlXdndtV3gz?=
 =?utf-8?B?WXZ5MDJXblgxd2ZXWFlVNHpjNzlqeHBTeVpqN0l5ZFUzb0lCNWt0RnAxT201?=
 =?utf-8?B?YzVNV0lna20wYUcvZHZCUGM2TGhJT3dpQ3dJdDBySUJ5d0djQjBJRGVuYlFM?=
 =?utf-8?B?OEFXeU5pcWFodWxHQy9iQU9qU2d2MlBrdzh4dVBTalhaaXBTdURKemRvVzd2?=
 =?utf-8?B?R3dQSmhaMjdSWVZwT2FJWTlFNVNXdEpucjJXZ08zbXNnekJwT3BmSmpTdmJj?=
 =?utf-8?B?elRodThwbUZDb21QZzArS0J6UnQ0bnZnT0lnV3lZOHVDRDdEVTVrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YvGcEvlBXO7Rh9Kp8rwd7oKdw6XvL6peHfyNtyGidgdk2m+qLdSaT3gOfZwStoLDDS/GOtCa0TWOR/jyCThS6fcrylouTafvplGCYv1CcRR/u87CvuuNb1yDjQWN+oJJzE7L6L3mtR1ktPIxZy6N0d31wYT17AaxctSQ3rn6H7SLmB5LzQrVMiR0neRZuQaO7MdPJdv0bmtJwDPAOf+rAk518pcy7/hcp+9miUszTd3PVYX/FrcHUPEQ3OAIlW9eSDIWBXOOywtDmFMJ0/90iaQcILh9hEkX+I54jQkXqugULpskPj9mWEPffQdNQ4ICTinKc2dLQGMAQfZgHUPstg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee75532-3504-4a61-23fe-08df2dc8b8fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 10:07:02.9647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWrEyXSM8HN1grLOOfNd+ckSk8CwHZ80kitfhOqlofeJ0MGP+VTbGqOyOjwmVsRxhQ7K+nXhVZIxi5YJcKkgSwg56hW6mrU0SHO1qb++h/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggNS82XSBpbnRlbF9pb21tdV9h
Y2NlbDogQWNjZXB0IFBSUSByZXNwb25zZSBmb3INCj5wYXNzdGhyb3VnaCBkZXZpY2UNCj4NCj5P
biAxMC85LzI2IDE3OjA3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFByb3BhZ2F0ZSBndWVz
dCdzIFBSUSByZXNwb25zZSB0byBob3N0IGJ5IHdyaXRpbmcgdG8gZmF1bHRfZmQuDQo+PiBDcmVh
dGUgYSBuZXcgVlREUFJRRW50cnkgdG8gY2FjaGUgY29va2llIGZvciBlYWNoIGZhdWx0IGdyb3Vw
LA0KPj4gdGhpcyBjb29raWUgaXMgdXNlZCB0byBtYXJrIHRoZSBmYXVsdCBncm91cCBvbiBob3N0
IHNpZGUuDQo+Pg0KPj4gSWYgdGhlcmUgaXMgZWl0aGVyIFBSUSBvdmVyZmxvdyBvciBmdWxsIGVy
cm9yIGNvbmRpdGlvbiwgcHJvcGFnYXRlDQo+PiBhIHN1Y2Nlc3MgcmVzcG9uc2UgdG8gaG9zdCBm
b3IgTFBJRyByZXF1ZXN0IHdpdGggdGhlIFBSUSByZXF1ZXN0cw0KPj4gZHJvcHBlZC4gRm9yIG90
aGVyIGVycm9yIGNvbmRpdGlvbnMsIHByb3BhZ2F0ZSByZXNwb25zZSBvZiBpbnZhbGlkDQo+PiBy
ZXF1ZXN0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQo+PiBSZXZpZXdlZC1ieTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxj
bGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+DQo+PiBUZXN0ZWQtYnk6IFh1ZG9uZyBIYW8g
PHh1ZG9uZy5oYW9AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVf
YWNjZWwuaCAgIHwgMTIgKysrKysNCj4+ICAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11Lmgg
fCAgNiArKysNCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgfCAgNCArKw0KPj4g
ICBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgICB8IDk5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tDQo+PiAgIGh3L2kzODYvdHJhY2UtZXZlbnRzICAgICAgICAgIHwgIDEg
Kw0KPj4gICA1IGZpbGVzIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggYi9ody9p
Mzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+IGluZGV4IGUwMzE5NzQ5YTUuLjBjYzIyYjJjYmIg
MTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+ICsrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaA0KPj4gQEAgLTIwLDYgKzIwLDcgQEAgdHlwZWRlZiBz
dHJ1Y3QgVlREQWNjZWxQQVNJRENhY2hlRW50cnkgew0KPj4gICAgICAgdWludDMyX3QgZnNfaHdw
dF9pZDsNCj4+ICAgICAgIHVpbnQzMl90IGZhdWx0X2lkOw0KPj4gICAgICAgaW50IGZhdWx0X2Zk
Ow0KPj4gKyAgICBRTElTVF9IRUFEKCwgVlREUFJRRW50cnkpIHZ0ZF9wcnFfbGlzdDsNCj4+ICAg
ICAgIFFMSVNUX0VOVFJZKFZUREFjY2VsUEFTSURDYWNoZUVudHJ5KSBuZXh0Ow0KPj4gICB9IFZU
REFjY2VsUEFTSURDYWNoZUVudHJ5Ow0KPj4NCj4+IEBAIC0zMSw2ICszMiw5IEBAIHZvaWQgdnRk
X2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9sb2NrZWQoSW50ZWxJT01NVVN0YXRlDQo+KnMsIHVpbnQx
Nl90IGRvbWFpbl9pZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1aW50NjRfdCBucGFnZXMsIGJvb2wgaWgpOw0KPj4gICB2b2lkIHZ0ZF9hY2NlbF9wYXNpZF9j
YWNoZV9zeW5jKEludGVsSU9NTVVTdGF0ZSAqcywgVlREUEFTSURDYWNoZUluZm8NCj4qcGNfaW5m
byk7DQo+PiAgIHZvaWQgdnRkX2FjY2VsX3Bhc2lkX2NhY2hlX3Jlc2V0KEludGVsSU9NTVVTdGF0
ZSAqcyk7DQo+PiArYm9vbCB2dGRfYWNjZWxfcHJvcGFnYXRlX3BhZ2VfZ3JvdXBfcmVzcG9uc2Uo
SW50ZWxJT01NVVN0YXRlICpzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQxNl90IHJpZCwgdWludDMyX3QNCj5wYXNpZCwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVBSSVJlc3BvbnNlDQo+
KnJlc3BvbnNlKTsNCj4+ICAgdm9pZCB2dGRfaW9tbXVfb3BzX3VwZGF0ZV9hY2NlbChQQ0lJT01N
VU9wcyAqb3BzKTsNCj4+ICAgI2Vsc2UNCj4+ICAgc3RhdGljIGlubGluZSBib29sIHZ0ZF9jaGVj
a19oaW9kX2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+IEBAIC02OSw2ICs3MywxNCBAQCBz
dGF0aWMgaW5saW5lIHZvaWQNCj52dGRfYWNjZWxfcGFzaWRfY2FjaGVfcmVzZXQoSW50ZWxJT01N
VVN0YXRlICpzKQ0KPj4gICB7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIGlubGluZQ0KPj4gK2Jv
b2wgdnRkX2FjY2VsX3Byb3BhZ2F0ZV9wYWdlX2dyb3VwX3Jlc3BvbnNlKEludGVsSU9NTVVTdGF0
ZSAqcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MTZfdCByaWQsIHVpbnQzMl90DQo+cGFzaWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVQUklSZXNwb25zZSAqcmVzcG9uc2UpDQo+PiAr
ew0KPj4gKyAgICByZXR1cm4gZmFsc2U7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgaW5saW5l
IHZvaWQgdnRkX2lvbW11X29wc191cGRhdGVfYWNjZWwoUENJSU9NTVVPcHMgKm9wcykNCj4+ICAg
ew0KPj4gICB9DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgN
Cj5iL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBpbmRleCAxODQyYmE1ODQwLi41
ZDQ0ZWFjMGVkIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgN
Cj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBAQCAtMTAwLDYgKzEw
MCwxMiBAQCB0eXBlZGVmIHN0cnVjdCBWVERQQVNJRENhY2hlRW50cnkgew0KPj4gICAgICAgYm9v
bCB2YWxpZDsNCj4+ICAgfSBWVERQQVNJRENhY2hlRW50cnk7DQo+Pg0KPj4gK3R5cGVkZWYgc3Ry
dWN0IFZURFBSUUVudHJ5IHsNCj4+ICsgICAgdWludDMyX3QgZ3JwaWQ7DQo+PiArICAgIHVpbnQz
Ml90IGNvb2tpZTsNCj4+ICsgICAgUUxJU1RfRU5UUlkoVlREUFJRRW50cnkpIG5leHQ7DQo+PiAr
fSBWVERQUlFFbnRyeTsNCj4+ICsNCj4+ICAgc3RydWN0IFZUREFkZHJlc3NTcGFjZSB7DQo+PiAg
ICAgICBQQ0lCdXMgKmJ1czsNCj4+ICAgICAgIHVpbnQ4X3QgZGV2Zm47DQo+PiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRl
eCA4MWM1M2M2ZjVhLi40YzIzNDdlN2QyIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0zMzgwLDYgKzMz
ODAsMTAgQEAgc3RhdGljIGJvb2wNCj52dGRfcHJvY2Vzc19wYWdlX2dyb3VwX3Jlc3BvbnNlX2Rl
c2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAgICAgICAgIHJlc3BvbnNlLnJlc3BvbnNlX2Nv
ZGUgPSBJT01NVV9QUklfUkVTUF9GQUlMVVJFOw0KPj4gICAgICAgfQ0KPj4NCj4+ICsgICAgaWYg
KHZ0ZF9hY2NlbF9wcm9wYWdhdGVfcGFnZV9ncm91cF9yZXNwb25zZShzLCByaWQsIHBhc2lkLA0K
PiZyZXNwb25zZSkpIHsNCj4+ICsgICAgICAgIHJldHVybiB0cnVlOw0KPj4gKyAgICB9DQo+PiAr
DQo+PiAgICAgICBpZiAodnRkX2Rldl9hcy0+cHJpX25vdGlmaWVyKSB7DQo+PiAgICAgICAgICAg
dnRkX2Rldl9hcy0+cHJpX25vdGlmaWVyLT5ub3RpZnkodnRkX2Rldl9hcy0+cHJpX25vdGlmaWVy
LA0KPiZyZXNwb25zZSk7DQo+PiAgICAgICB9DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRl
bF9pb21tdV9hY2NlbC5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiBpbmRleCA3
YmFlZmUzMGNjLi5jZDIyNzMxNWRhIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21t
dV9hY2NlbC5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+IEBAIC04
NCw2ICs4NCw2MiBAQCBWVERIb3N0SU9NTVVEZXZpY2UNCj4qdnRkX2ZpbmRfaGlvZF9pb21tdWZk
KFZUREFkZHJlc3NTcGFjZSAqYXMpDQo+PiAgICAgICByZXR1cm4gTlVMTDsNCj4+ICAgfQ0KPj4N
Cj4+ICtzdGF0aWMgdm9pZCB2dGRfd3JpdGVfZnNfZmF1bHRxKFZUREFjY2VsUEFTSURDYWNoZUVu
dHJ5ICp2dGRfcGNlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QgY29va2llLCB1aW50MzJfdCBjb2RlKQ0KPj4gK3sNCj4+ICsgICAgc3RydWN0IGlvbW11X2h3
cHRfcGFnZV9yZXNwb25zZSByZXNwID0gey5jb29raWUgPSBjb29raWUsIC5jb2RlID0NCj5jb2Rl
fTsNCj4+ICsgICAgdWludDMyX3QgaWQgPSB2dGRfcGNlLT5mYXVsdF9pZDsNCj4+ICsgICAgaW50
IGZkID0gdnRkX3BjZS0+ZmF1bHRfZmQ7DQo+PiArICAgIHNzaXplX3QgYnl0ZXM7DQo+PiArDQo+
PiArICAgIGJ5dGVzID0gd3JpdGUoZmQsICZyZXNwLCBzaXplb2YocmVzcCkpOw0KPj4gKyAgICB0
cmFjZV92dGRfd3JpdGVfZnNfZmF1bHRxKGlkLCBmZCwgY29va2llLCBjb2RlLCBieXRlcyk7DQo+
PiArICAgIGlmIChieXRlcyA8IDApIHsNCj4+ICsgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCJG
QVVMVFEoaWQgJXUpOiB3cml0ZSBmYWlsZWQgIg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIltjb29raWUgMHgleCBjb2RlIDB4JXhdICglbSkiLCBpZCwgY29va2llLA0KPmNvZGUpOw0K
Pj4gKyAgICB9DQo+PiArfQ0KPg0KPnBlcmhhcHMgd2UgY2FuIHBsYWNlIHZ0ZF93cml0ZV9mc19m
YXVsdHEoKSBhcm91bmQgdnRkX3JlYWRfZnNfZmF1bHRxKCkuDQo+T3RoZXIgcGFydHMgTEdUTS4N
Cg0KVGhpcyByZXF1aXJlcyBhIGZvcndhcmQgZGVjbGFyYXRpb24gb2YgdnRkX3dyaXRlX2ZzX2Zh
dWx0cSgpLCBhcw0KdGhlIGNhbGwgY2hhaW4gaXMgdnRkX3JlYWRfZnNfZmF1bHRxKCkgLT4NCnZ0
ZF9wcm9wYWdhdGVfcmVjb3ZlcmFibGVfZmF1bHRzKCkgLT4gdnRkX3dyaXRlX2ZzX2ZhdWx0cSgp
Lg0KVGhhdCdzIHRvdGFsbHkgZmluZSwgSSB3aWxsIGFkZCBpdCBpbiB0aGUgbmV4dCByZXZpc2lv
bi4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

