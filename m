Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD74DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 06:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwz4z-0003PL-GH; Wed, 17 Apr 2024 02:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1rwz4w-0003Ox-FE
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 02:47:34 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1rwz4t-000830-Fn
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 02:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713336451; x=1744872451;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VaaVUzkrVWmTHY+yjAUStyWB4H+i1Gcqn+mUpJGYfyg=;
 b=Jng/OOJLWeXCxXSP9L/e07Pd2QV3o2LzO1N6UNCFVaOg/oTk5lFXQGIP
 xQn8IEuwhESb9SM2I1F6oCHf99ybUT1LDFKKIDhyxePG5U0T2O3Y/vBRO
 xxRPBTxh7H7viqFAEKozoSPhm7ksTjtVzjsIChQU1LFWXdr7FiTEJRVDt
 2h3f/mRzC5t/sS4oknzXwYjG049KGqhQQpn22PHxfsrSqlqv14sMG8G0X
 jQu9frZeS8KtIc3UIY7XIVDdN03y7UM8PflE+5T+iEsYTyyE9U/3hotde
 KFKxW7v6w8zu/LdV++1pNq0LXORg7HT44gyLDneZe6w6cgidw2BRLjuRe A==;
X-CSE-ConnectionGUID: GViKUxDORXyuoL5QVtRbow==
X-CSE-MsgGUID: o0musJlKS/+uJ3AvUAajjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19415060"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="19415060"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 23:47:27 -0700
X-CSE-ConnectionGUID: 6KsSH10gTpGHz9OvNC9leA==
X-CSE-MsgGUID: v1EiXOP5QwenfRwAT3MTig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="53723616"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Apr 2024 23:47:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 23:47:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 23:47:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 23:47:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsQct6XvmSeRMt85u4qwLWGsVpGjdUhTJsProNJD4ZVkG0IUyzuEAHMpghxz3/kNRSbDAziNxz5gs/xkuLNod1vsuaZNaZoysl0tx5jI0o3nAOD/XUS8zz4Rxa+Y3u9T1RR9zoNDp0Z0+R9AcgH/0ml4j6DYtKH8eZayBW0s35CyhEyyoOAnC2SzKxcb4JiPRfAPhf4l2nBn8RAW1mzBpZpcmCNN/J3bdNaXtA6+WnxV3RDUvc9AEqhDYP16g+k4KXIaUmQqntyiCFazjBrAjMeRZKwdHeddR/UQIw7UZE8TStPnuSLZ98SdPBCDXQNMS10rIQkKNS/HOkQLefatEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaaVUzkrVWmTHY+yjAUStyWB4H+i1Gcqn+mUpJGYfyg=;
 b=PZ2Lw/MSpn0JILBaIm2Ygf4qLuql3f3nteCCTHOg1XQVYV3wsIwEZh/9qYr1kb17DprsARr2etICQWNM+wzMnMBhwfxdylbu7rTzlBL7ENq+Uy7OJmXCETHRAL+3+BVLVNSF0Vea2tW3xoMVxQX/+xkrVVAEkoz3vOdoyeWmyDdYPXlke7C3oICupZox0/NHTPG0hv0GRijHuo2dRCEsVx2wVdZmWoMqlx9Sqwle4BIBHe0/5xAcrnDKI/sa4KIVGY2h4oEDgHDo8hLUaA91pV3ybdzrv9NJROOmFbhIt8tKXXAPNX6LZhPoKr5VaWK9KYmZLEh3930/YijHUc+MAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Wed, 17 Apr
 2024 06:47:23 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::60a7:2a84:f3d8:2828]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::60a7:2a84:f3d8:2828%6]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 06:47:23 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Li
 Zhijian" <lizhijian@fujitsu.com>, "Zhang, Hailiang"
 <zhanghailiang@xfusion.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Wen Congyang
 <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>
Subject: RE: [PATCH v2] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
Thread-Topic: [PATCH v2] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
Thread-Index: AQHakHJ+yXyDbXp5Gkmj375QEc6aprFr+9+AgAAGihA=
Date: Wed, 17 Apr 2024 06:47:23 +0000
Message-ID: <CYYPR11MB8432BD8E8E4DAA9FFEBD19E99B0F2@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20240417025634.1014582-1-lizhijian@fujitsu.com>
 <84c98291-c9a4-4349-9143-aff61e06c125@linaro.org>
In-Reply-To: <84c98291-c9a4-4349-9143-aff61e06c125@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|PH7PR11MB5818:EE_
x-ms-office365-filtering-correlation-id: 4e4bab20-cdfd-41f2-2dda-08dc5eaa3caf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OfGAAydLkHUVAlj2J6JYsSmykYgdEeN1o8NZkDbKOIrL3djUZBkVJaGt4P0rFNo9uvpM9diW3nhAIa03owAY4SJFJc9VD3TLE5rCLI4T/5nyT+jb7uXrdPU2fEPtn8HhfZ9xFidHTJPBZxQlPfq8prAGrttptVsgcYu5UawsFC1tOcA+gxCCpTq0B8hJG/y2K93UctDf2aV/fnNbtga7/XJxgpzA4xxT8reuskR+iuxca+46qhhC5Xf1jPpJr9t41cPF4wXAhLq4y08z7l6h+cuVssqZ02GlvkDLRnEo2JkdqU/zDnqifLVOor2Vjh8z0gDVMlli19LGiO0lql+t1qMrLviISjjYziUejfKcIfdVuGPHq8UhrhVJxd7v2zL8p2wDJy5MFXfJGkCQOWOt6u+T1zqlHayKq9dtSEhclIog4VzdiyT0CHUKQs5KbzKzlcdh79IvY9jrT/bhT90zyUgdBu9p0/AcZ7D+Pjt1Mt77vYld8V/OGV2Wf9m/8H9CQZn2HzzYM2VLrb1+49YaYc7/gMIptE8E60Cwij3OQhTXxvIRd1pLxOtdoRt5LwM0oYFa69/fEpVLZ4IlyK96YNyvQTe23XSkDsQ737ARcibGQm8UaxMQC0zO8K6LDscTqBpL15WX9HZXfIsCLrCQgtSga+eCfFbDQvMAiaccg6J3i+yIdauY42oofFHuRtwg8lG9OLH45oItESAdQ/sCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjJhbEp1cGJkM3ZMSFNLYURQWWhBV3dGa21qLzlYT09GTnd0dHZWRlVHZlBl?=
 =?utf-8?B?S2hYRVd1WlFHdWF4L004bHk5SVBpdS9xNVAzbTdNK0VmTzV4RTFDMUhWaTgr?=
 =?utf-8?B?czRtQUFzb2l5b2RhbWU4dzJOVUNDREcrK3JOZXBnYUxvSUJFZnB2WXZoTjFh?=
 =?utf-8?B?WFlBL1pSczRSTWVhdHJ1ZWtoaUxPS2FyV09wOFYxNUhNM2pGMGZhdGgrZWpK?=
 =?utf-8?B?QTlNS0RVQnE1T3BwQ3l5SXFwc3hzL2NIR2hIMmZkMzQ4MGlnS1I5OHpxT3Ay?=
 =?utf-8?B?dzRkYzlES291eVZTZTB4Q0w2Ylc0ZXMvVTFKblpuYitCQWJjNjNaMVB0aER4?=
 =?utf-8?B?K1d1TUM0U2xXUy9GY2NqUlZHZ0NXL3hEOE5XVmFTT1RrTlhNRWNVbnR2WjFz?=
 =?utf-8?B?T2ZhdUs0NzZmYmFVcEJ6Z2tlN3hVS1F2eVNwenpGZE5Rcncva0tTcHEwQnM5?=
 =?utf-8?B?ZFBFMG9DU3NVT1AwL0RJUlVPTVBKbDNiY2NrWS9MeXhaUXJyK3AxVkZGaG44?=
 =?utf-8?B?ZUlLaE5RcVU4eDc4NTZMcEU5V0ZDZ3FFRFJNVExHcFphVXc1a2Z0QlV3a0VY?=
 =?utf-8?B?OEt0QjAvdFJMSUdXWExiUU90NWJTcDJQUHNUbk14KzZPdXY2aEh1cDVkcGRj?=
 =?utf-8?B?aVR1Nm1hQmtnQm1aUHVuVGY2MXpIRGY5cStkRmxEZ2tvOSs4c3h3b2lRY3ZB?=
 =?utf-8?B?VVA0OFlFNjhnTmNObzFGZXkzYTdTNnRNdEI1YzJ0UVFkaVV3bmlseHNlTGJs?=
 =?utf-8?B?YWhRc3V3Q2pGb1hpUjl1UDk5SlN0N2JkWURHME1QTUxsZVBoak5oNytwNW5X?=
 =?utf-8?B?dnRUcFNrM0Y4VmNnME43aW1Pa3JIMEVWcEVuc0lhOGhxbkgwTzZSOTBYSEh1?=
 =?utf-8?B?NFVWSkdFRkJmWnBGYWJEWUFReEg2aDUvYkpXMk9mbEttS3VWQWpiRk1HRUVw?=
 =?utf-8?B?a2ZSSHZLdXNPR0g3YXZXOE9rQjlVWHNLY2IwcWl5TTdxaVJMN1dScWNUYzFj?=
 =?utf-8?B?UFdKdWt1eGc3TEhYOGhVVEFXc3BFTXVqbVFNZllhMXNibFhkTGZGdVFnRHNU?=
 =?utf-8?B?VmdKZk1XYTZMbTZHeXB4L0ttWjJvQ0VwRUd4L1ZDSHk1c2JIRTY4czFnaWQw?=
 =?utf-8?B?dHZCTWk3WGpSWlJLWGNmNGJ5UExuT1lqTDVBVUcyTEZxd0I1MjQxRGpDbHVM?=
 =?utf-8?B?bHdkK1dkOWVSRVkvR2Y3bEJCMXh3NjhyVW52Vkt3UHpXU2EyaXhvTjZBQWZ6?=
 =?utf-8?B?WmlVazJNditLamdMbVd6RVBLeUphM0p3U0RKemNNVXRKVDc3V1dUbW9zZGxq?=
 =?utf-8?B?V25JSTR1d0ljYmRSbUFhcllhakdXSlJjdU5ld3RRM0dpd0lJZ0pxaVhqUXhm?=
 =?utf-8?B?UlFhQy9Ka2lleHJwSGN5dU5wNmIxVHhNWXdBbTlZVDFwNHlya1FFQnJEUWMy?=
 =?utf-8?B?a3VwbG43NXJLVWprcjFSOTJVcG56a2VsSUZTRjVsZnNxY2ttRUVhbDJiNWpu?=
 =?utf-8?B?NDhjRUNEZTQ1NjlSNjlXT1ZabHpmck95Z1RWZnVMWFBBcVVnQ2lNemZ3NlBU?=
 =?utf-8?B?MnZ2NVdWM0E3WmN4MUJhdjNZNzllelQwZThXWnpuVHE2U2dDTzNvRFYrdkdw?=
 =?utf-8?B?Y1MvUnEyQ0NFTjZnblVMV0huU29kQi9OdE94c0s3cDJNRkcyblN6MjMzSkdN?=
 =?utf-8?B?K2t1bTVRb1ZqUnI0TFljK2Z1clAxZVRLeDFQWW9QVUpkQW9BaHBxa3BwYXE5?=
 =?utf-8?B?MEZTUlJnWlZkejU5WXVWUkozKzZBdU16R1JIVzBneDFPY3hKY091c0lYSUUz?=
 =?utf-8?B?L01pbkJLQU05WFU1Kzhva3RQQzZXVUE2YjBiOW42Y3JLUGhLOGlEOXhNVEl4?=
 =?utf-8?B?WjlmMGc3SmdYT0sxTm1JcVZSOVoxTGlhSGdyeTlVb1cxSzRCL0toOVhSbmxB?=
 =?utf-8?B?RzhpazRpSWdyMXhiMEZTdmhjZEE2V3RhaFJnUDdBWnBsNkFsWDNVZkszS09D?=
 =?utf-8?B?VEpiSHdiWHJMVkxDWEN4d29WenRIMVBFUXVua2ZFdTR3VVRnQkE4bDgyMDUw?=
 =?utf-8?B?REREam1lRFdUWTU0aWw3MDltbGJuN0loQTZ1RHQ1TnVsNFlHRS9UeE5zcWgr?=
 =?utf-8?Q?0PZqILsMM372iuO5n2ETOv1sP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4bab20-cdfd-41f2-2dda-08dc5eaa3caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 06:47:23.5292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Kk9FboKzm0Y3hIuKdc+AipwmZZ1XAVE9fiGmHEFLY4X8TOqgO9eP0Yh8ZvCe0CW8HpVlAkknhMc85/IsHd69Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE3
LCAyMDI0IDI6MTQgUE0NCj4gVG86IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT47
IFpoYW5nLCBIYWlsaWFuZw0KPiA8emhhbmdoYWlsaWFuZ0B4ZnVzaW9uLmNvbT47IHBldGVyeEBy
ZWRoYXQuY29tOyBmYXJvc2FzQHN1c2UuZGUNCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsg
WmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgV2VuDQo+IENvbmd5YW5nIDx3ZW5j
b25neWFuZzJAaHVhd2VpLmNvbT47IFhpZSBDaGFuZ2xvbmcNCj4gPHhpZWNoYW5nbG9uZy5kQGdt
YWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gbWlncmF0aW9uL2NvbG86IEZpeCBi
ZHJ2X2dyYXBoX3JkbG9ja19tYWluX2xvb3A6DQo+IEFzc2VydGlvbiBgIXFlbXVfaW5fY29yb3V0
aW5lKCknIGZhaWxlZC4NCj4gDQo+IE9uIDE3LzQvMjQgMDQ6NTYsIExpIFpoaWppYW4gdmlhIHdy
b3RlOg0KPiA+IGJkcnZfYWN0aXZhdGVfYWxsKCkgc2hvdWxkIG5vdCBiZSBjYWxsZWQgZnJvbSB0
aGUgY29yb3V0aW5lIGNvbnRleHQsDQo+ID4gbW92ZSBpdCB0byB0aGUgUUVNVSB0aHJlYWQgY29s
b19wcm9jZXNzX2luY29taW5nX3RocmVhZCgpIHdpdGggdGhlDQo+ID4gYnFsX2xvY2sgcHJvdGVj
dGVkLg0KPiA+DQo+ID4gVGhlIGJhY2t0cmFjZSBpcyBhcyBmb2xsb3dzOg0KPiA+ICAgIzQgIDB4
MDAwMDU2MWFmNzk0ODM2MiBpbiBiZHJ2X2dyYXBoX3JkbG9ja19tYWluX2xvb3AgKCkNCj4gYXQg
Li4vYmxvY2svZ3JhcGgtbG9jay5jOjI2MA0KPiA+ICAgIzUgIDB4MDAwMDU2MWFmNzkwN2E2OCBp
biBncmFwaF9sb2NrYWJsZV9hdXRvX2xvY2tfbWFpbmxvb3ANCj4gKHg9MHg3ZmQyOTgxMGJlN2Ip
IGF0IC9wYXRjaC90by9xZW11L2luY2x1ZGUvYmxvY2svZ3JhcGgtbG9jay5oOjI1OQ0KPiA+ICAg
IzYgIDB4MDAwMDU2MWFmNzkxNjdkMSBpbiBiZHJ2X2FjdGl2YXRlX2FsbCAoZXJycD0weDdmZDI5
ODEwYmVkMCkNCj4gYXQgLi4vYmxvY2suYzo2OTA2DQo+ID4gICAjNyAgMHgwMDAwNTYxYWY3NjJi
NGFmIGluIGNvbG9faW5jb21pbmdfY28gKCkgYXQgLi4vbWlncmF0aW9uL2NvbG8uYzo5MzUNCj4g
PiAgICM4ICAweDAwMDA1NjFhZjc2MDdlNTcgaW4gcHJvY2Vzc19pbmNvbWluZ19taWdyYXRpb25f
Y28gKG9wYXF1ZT0weDApDQo+IGF0IC4uL21pZ3JhdGlvbi9taWdyYXRpb24uYzo3OTMNCj4gPiAg
ICM5ICAweDAwMDA1NjFhZjdhZGJlZWIgaW4gY29yb3V0aW5lX3RyYW1wb2xpbmUgKGkwPS0xMDY4
NzYxNDQsDQo+IGkxPTIyMDQyKSBhdCAuLi91dGlsL2Nvcm91dGluZS11Y29udGV4dC5jOjE3NQ0K
PiA+ICAgIzEwIDB4MDAwMDdmZDJhNWNmMjFjMCBpbiAgKCkgYXQgL2xpYjY0L2xpYmMuc28uNg0K
PiA+DQo+ID4gQ0M6IEZhYmlhbm8gUm9zYXMgPGZhcm9zYXNAc3VzZS5kZT4NCj4gDQo+IENjOiBx
ZW11LXN0YWJsZUBub25nbnUub3JnDQo+IA0KPiA+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuY29t
L3FlbXUtcHJvamVjdC9xZW11Ly0vaXNzdWVzLzIyNzcNCj4gPiBGaXhlczogMmIzOTEyZjEzNSAo
ImJsb2NrOiBNYXJrIGJkcnZfZmlyc3RfYmxrKCkgYW5kDQo+ID4gYmRydl9pc19yb290X25vZGUo
KSBHUkFQSF9SRExPQ0siKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlh
bkBmdWppdHN1LmNvbT4NCg0KSXQgbG9va3MgZ29vZCB0byBtZS4gQW5kIGFscmVhZHkgdmVyaWZp
ZWQgdGhpcyBwYXRjaCBpbiBteSBlbnZpcm9ubWVudC4NCkFmdGVyIGFkZHJlc3MgUGhpbGxpcHBl
J3MgY29tbWVudHMgcGxlYXNlIGFkZDoNCg0KUmV2aWV3ZWQtYnk6IFpoYW5nIENoZW4gPGNoZW4u
emhhbmdAaW50ZWwuY29tPg0KVGVzdGVkLWJ5OiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVs
LmNvbT4NCg0KVGhhbmtzDQpDaGVuDQoNCj4gPiAtLS0NCj4gPiBWMjogZml4IG1pc3NpbmcgYnFs
X3VubG9jaygpIGluIGVycm9yIHBhdGguDQo+ID4gLS0tDQo+ID4gICBtaWdyYXRpb24vY29sby5j
IHwgMTggKysrKysrKysrKy0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9taWdyYXRpb24v
Y29sby5jIGIvbWlncmF0aW9uL2NvbG8uYyBpbmRleA0KPiA+IDg0NjMyYTYwM2UuLjU2MDBhNDNk
NzggMTAwNjQ0DQo+ID4gLS0tIGEvbWlncmF0aW9uL2NvbG8uYw0KPiA+ICsrKyBiL21pZ3JhdGlv
bi9jb2xvLmMNCj4gPiBAQCAtODM1LDYgKzgzNSwxNiBAQCBzdGF0aWMgdm9pZCAqY29sb19wcm9j
ZXNzX2luY29taW5nX3RocmVhZCh2b2lkDQo+ICpvcGFxdWUpDQo+ID4gICAgICAgICAgIHJldHVy
biBOVUxMOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgLyogTWFrZSBzdXJlIGFsbCBmaWxl
IGZvcm1hdHMgdGhyb3cgYXdheSB0aGVpciBtdXRhYmxlIG1ldGFkYXRhICovDQo+ID4gKyAgICBi
cWxfbG9jaygpOw0KPiANCj4gTm90ZSB0aGVyZSBpcyBhbHNvIHRoZSBjb252ZW5pZW50IEJRTF9M
T0NLX0dVQVJEKCkgbWFjcm8uDQo+IA0KPiA+ICsgICAgYmRydl9hY3RpdmF0ZV9hbGwoJmxvY2Fs
X2Vycik7DQo+ID4gKyAgICBpZiAobG9jYWxfZXJyKSB7DQo+ID4gKyAgICAgICAgYnFsX3VubG9j
aygpOw0KPiA+ICsgICAgICAgIGVycm9yX3JlcG9ydF9lcnIobG9jYWxfZXJyKTsNCj4gPiArICAg
ICAgICByZXR1cm4gTlVMTDsNCj4gPiArICAgIH0NCj4gPiArICAgIGJxbF91bmxvY2soKTsNCj4g
PiArDQo+ID4gICAgICAgZmFpbG92ZXJfaW5pdF9zdGF0ZSgpOw0KDQo=

