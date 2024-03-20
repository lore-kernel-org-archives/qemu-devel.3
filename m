Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B939C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmylz-0005r4-Dh; Wed, 20 Mar 2024 12:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmylw-0005qj-Ud
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:26:36 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmylu-0005Yl-Gs
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710951994; x=1742487994;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JQgMt1WgJ0nbv6XaCOiwgv19EjJkFZs4FJ03Z+qzUiA=;
 b=VvRRMtWJiCP9IYBoqPGx0Yx51LZMNkXFGe3ZAJVwOiRJuOZysLJR31Um
 dUxRAPLHUcByOJnLo/k5b722XryMi6UayA4UUJIREWhbEjc5tulo+EHRC
 JFb11dXbZl5+INgIFcK/YTU7tHRtGIOSwdUvXO6Fwp1zbZZ9RLi+NJX01
 i+cRYzbyDm/mM79kHv3QjQczAvxhUuuy5Xx9FBbLuNLn0YANpogO2LnDk
 XcD/JXN3pmwmoimKAQ1HRBoUvTcmUFP91zwxEhkwm8xXPscQWXocyaO94
 gM5Ni7JJcMAImbgKBdOAcYb9e7jtOoUbpC7h1bs5s0/i9vSB3Uc7+t85R w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="8839164"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="8839164"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 09:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="37325861"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Mar 2024 09:26:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 09:26:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 09:26:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 09:26:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 09:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK/jD6jzSipxO0vaZLUzDaklmrDg3uhBPjoRsiPk7GZAbzgfYXJ6u+gSuNhYlOd3gFPG/COKht+UrJ52lWUdEWr6zaV7VhMJsmos15CSD5PfLYzpMUCjT5sShH8goJUOOBp4Mv+fHQ0/1UARTY8azEi1SgrTNYYFq85oGw9IJOHAK7xh0woR2qOSGj9bQSkGzAnczWfG32tDIhK6eQjWO/xubmxiKAXPSaIjPcd8M9x6L4SyIwEV91yEtrwwLFTU5idL0uJmmth8EHp+2VqivBs3EJMdKgcBffjfCKyuKRNyzdX9xfvrUKviI+rdsZ6ovQ6xTMwWhIiG3p9yRdkkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQgMt1WgJ0nbv6XaCOiwgv19EjJkFZs4FJ03Z+qzUiA=;
 b=oTWN7AFZCNNUPhcEDpJxdPUVZWam0HLEhc621jUTajdj079+hfhwusnqGx0mNmi0QBWQldz9uhkUem0Id/FZji51a3YVHjBZP/+BzYIKFZAYyky/dkZMT9nfvrhNq+g0zdTJ0wDprLz7QYnGA+hfqd1jb0v45W80bgFCaLOIK3bMsdibkXvGN2Oh2xHv0WpT6gB6jYB9cHPbPAtpe5IOm6In6a50sugT15thoIinpMk+em8VlN1qaFiAEJZVrMv8eNJn4KICR2S6eBmZYhMzslwMIocBLNpRQlDPjoQ9zWBZ8yWq74rwdppDYUjiyd0lvVja+KxBIa0scopcDPzfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by CH3PR11MB7370.namprd11.prod.outlook.com (2603:10b6:610:14e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 16:26:21 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 16:26:20 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 7/7] tests/migration-test: add qpl compression test
Thread-Topic: [PATCH v5 7/7] tests/migration-test: add qpl compression test
Thread-Index: AQHaeqFN3RFTN7VnMUC5HRmYwLqpVrFAck4AgABKnfCAAAdzgIAADMbQ
Date: Wed, 20 Mar 2024 16:26:20 +0000
Message-ID: <PH7PR11MB5941B90F048E8816D17670B0A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-8-yuan1.liu@intel.com> <Zfq-Yu-aLa1OJL25@redhat.com>
 <PH7PR11MB5941FDC1E4B9723CBBAEC2B4A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfsDOabHdAqPBKvL@redhat.com>
In-Reply-To: <ZfsDOabHdAqPBKvL@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|CH3PR11MB7370:EE_
x-ms-office365-filtering-correlation-id: 1c835f94-401d-4a12-5d08-08dc48fa7a38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b/o8+8QFznYjRR0f3bVg+YuewBfKbMreGN/Hj20gtZBPd3rnwK9yr9ZkNPYdOyFir79HANYxyyL3u5JqY/oyvybHhqftaUAaZpuD3uSl/ESZ+QquPrpxzhoBovbmbB/+oAdTGvELI8VETpEnuU9aHI3B1VjVL2pqFbgeLIcRdQC7/zXG722FThzsJvUwqSFTvFUVuOTdLIvgaCSEzEXloLvMYc3uJ6RovPTOwGmitQK4ENs0jtOZShnF2SzymoAc7LtNtzNRZ4EgjSjDPGLwDh6juP+to7EksnBpYTGFwa8bFFNMP6EtK7ThR1DqDEuoZP1+3hrXZjv3SiEnnHgJJOJA7CfABnnUaTgMwDJLWGCXpPBAJC2bIohuP6W6VzYq36Sdfk8W6OmtUiQ8JsQehQ0r0WV1UHOcHhIpwmyxqkDvwmxCSvSxLIlx8NIOKshNKJg8KOuEQdznj8HOEpVzJWUhySrNNprT+k+KicBoREfuXQ4l/CoEPTGncl+xOIkI/UrvhGK5gf9/MCUsdp4qoFzP8Tkh5jgwG+sxKKt81r6xXNYRGVCw30mPOerINHkNft1h8Z56sJgy2K11aMvVMa82Xkho1Az1RkknfBQjyE7g8B3/oDWDb6kry0UBFlhGsJ0UEaSpWdiKEjrmexOZzyCpkygaLbFpe+bag0C3Z2qhd4Ns8t/W6cNBd8YEdWYS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3JKcWF2czhNTEYyQTMxNm9ITU9TMFh0Mnc1Y0tCazZYU1lQNkNGdlBrUWZ2?=
 =?utf-8?B?c0RhVUJmWkRtdGZnRFNOaEN6UkF6cGZxUUxLSmZBVHRtWlZtQmIvdjAyTVpN?=
 =?utf-8?B?L3M5ZFVCbFc1LytOdFkvN0ZuaEY4S0NPK3M4d3BBcFBNQlA2MlE1OGlocHNi?=
 =?utf-8?B?bzdnUDF3SDFJMU5jNk9XUmxqQnJJSnVuRHNtYWVWL0d5QUZTQVB0ZmNFRWpR?=
 =?utf-8?B?UVlDUW5aR21IemF4ZVo4a01LS1FMNG56TldqUXFvUldZdGVEcTh1d0cwMGl4?=
 =?utf-8?B?L0hDQmtWdWlXM3ZPN0Jzb3J4OXdPR2dBVWdJSWVDa2hyMnJWamtsaGtrSmJK?=
 =?utf-8?B?YUhVY1Vud0w3dVFucFBUOVBKTmJvclFhUDZCNWswVHVJOEN0OUVCd2lpOVdp?=
 =?utf-8?B?RVlFWG1uZ3hDZHQyTVpnSDZ0V29uL0ZQSktvbU9BZ0lFc3hXcWVXWDZTeSta?=
 =?utf-8?B?Y0F2dDloOXBKUlBkay9OdTlsTk1vZUprRGdOMGNYMVZVNTBvODBRUkFsak9D?=
 =?utf-8?B?Y3ZrVnBPbU12dmE4c0VYUHZiMFlUQjgyOTNkOGh4ZUgxMUVrT0tLVjdrVktt?=
 =?utf-8?B?NlFTeUd0eDFQQjN4bzhGTVJ4Unl2SHM1MkJPTGpuQWtMSE9iVDJPbm9xTFNj?=
 =?utf-8?B?TVdPTGprU25rZ2ptK0FERjZxZ3pobUtPTGZUbHZaRW1BQ2xvakU3VmNRazk4?=
 =?utf-8?B?NjNWc3lWMzE4blVweW9tSFRuQ0NETEpYWHRtNHpSYkhVTjIyUm1IRjR2bTBX?=
 =?utf-8?B?SHZqVzk4cjJHNW44S01zZ2JkVlk0MU5FS0NrZVlZZjVLVGl5dGVGYzNJaklt?=
 =?utf-8?B?NHZCWUFrbnRTUklHOS9heUhkUjhtVXNoM2dIUlpVNmhrVUV4WGl1M0RJWDNB?=
 =?utf-8?B?YU5aMU9PTEMrMVNncWIvV3R2UVV4THBBRHQ5UFpsa09EVVl3ZnY1OTlDMmwz?=
 =?utf-8?B?QldMbzF2K0kyRFoyaTRWRlBIbDdMWGNrQldNYzFoKzBETXJ5YlpKTEFPbWFB?=
 =?utf-8?B?Q2R5ZUdqSzYxR0RWT0srbk8veXhkS3kvemtzTjF4YzFFRWF5aU5wdTRBRmho?=
 =?utf-8?B?YzRTMVJFc3Azb3JFTG5zNW9TRWU2bTY5MlFXUkkzZGhOYTdJeTlMTnZxSW5s?=
 =?utf-8?B?bU45TnAzMWN6Y1EzUFhFNEhMS3N3ZDFGaVA1dDErY012dHZlRkgvNG53S3pP?=
 =?utf-8?B?RUJJU3RCS051UzlwTTh1ZncyOFBhSzg3MjlPcGhwQlRTV1RwT3VlUzBpdXhr?=
 =?utf-8?B?Mnk3MTBhODAvVHY0WERyd3N2UTdVcUtRRWdoblpzVjVRL2UwN1BXdldSU1pU?=
 =?utf-8?B?N1FGdk5NN0JXVGVKSWNZZW4rOUVud0VVNkRWOU1HS2k1SDRERncrOHZWakh1?=
 =?utf-8?B?Um1hZTFKMDhQdmw0NVYxdmNHL0FJaDc3OW9Xem0wN2tVMnRibmtpR3czZTN3?=
 =?utf-8?B?ZnB4R0k4UHhmSUp1eE41cVdpQVV2SzdEMW8xaFNTdjhXdll5OWtWcDYzRHlh?=
 =?utf-8?B?cWFWVmc0eUhIZkQ3RzZxTjdNREVmLzFlVDJMK054ZzdSLzZ5OHpoSldsd0c0?=
 =?utf-8?B?K0RDSnFXdjJSYnFZVXJETzhCeVJBUWF2aCs5YkNEUlZ2eFd1K2o3K3doYVla?=
 =?utf-8?B?REZuZitkbWtlV2Y0a2JOYmtpT1BlSVBadWFDQ0o0OWt1YzdHZzdpNytEa0R6?=
 =?utf-8?B?cXFDYVVEQ0FqUVM2NHh2a3JsK0RvOE1SSzc1WnZWMkg0cGppc1BmZlRveS80?=
 =?utf-8?B?UWx5czcrTjdUQjVDamFMSTczSmh6MjU1azJzK1M4RmVlai92b1UxaWdvVTNV?=
 =?utf-8?B?TmwzOElvRERyKzNoNTg2M0JCZWhPU205ekNJQWlBa3MzUlRFRWtkKzVqRmMz?=
 =?utf-8?B?NEIzb0xCRmtMelZKMWxXSHdCdVl6UkUvU1duQy9kbGE2aXNPQmZnampPNHdN?=
 =?utf-8?B?QXMwczlPZ3c5aDBpYjFEYVZBZ1A4QU1ScEZYejN1dko4cjQ5eWpPZWJTT0kz?=
 =?utf-8?B?eCtLRDZsTTA5L0tTWnRCV2xtRU80L0VDWURBRUoyRGxKMThoSERPRHZWMkVP?=
 =?utf-8?B?eVZzOXpWbUtERlpUNW9CYnZUNVNXdzZ3MDY0SVZtNHJkMXBGR3NwNUtLRlpR?=
 =?utf-8?Q?2cehRZB46EYSz9n9IueUV7ciX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c835f94-401d-4a12-5d08-08dc48fa7a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 16:26:20.8866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eTMoPglkmLCgz3HL4f7zA/v4CqfWgarT4/ffqrE2hOw1GZNjbuzxfV+aHIwm1cmgdEBx7H4OrPQ881+s9TzXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgUC4gQmVycmFuZ8Op
IDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDIwLCAyMDI0
IDExOjQwIFBNDQo+IFRvOiBMaXUsIFl1YW4xIDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiBDYzog
cGV0ZXJ4QHJlZGhhdC5jb207IGZhcm9zYXNAc3VzZS5kZTsgcWVtdS1kZXZlbEBub25nbnUub3Jn
Ow0KPiBoYW8ueGlhbmdAYnl0ZWRhbmNlLmNvbTsgYnJ5YW4uemhhbmdAYnl0ZWRhbmNlLmNvbTsg
Wm91LCBOYW5oYWkNCj4gPG5hbmhhaS56b3VAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDcvN10gdGVzdHMvbWlncmF0aW9uLXRlc3Q6IGFkZCBxcGwgY29tcHJlc3Npb24gdGVz
dA0KPiANCj4gT24gV2VkLCBNYXIgMjAsIDIwMjQgYXQgMDM6MzA6NDBQTSArMDAwMCwgTGl1LCBZ
dWFuMSB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiA+ID4gU2VudDog
V2VkbmVzZGF5LCBNYXJjaCAyMCwgMjAyNCA2OjQ2IFBNDQo+ID4gPiBUbzogTGl1LCBZdWFuMSA8
eXVhbjEubGl1QGludGVsLmNvbT4NCj4gPiA+IENjOiBwZXRlcnhAcmVkaGF0LmNvbTsgZmFyb3Nh
c0BzdXNlLmRlOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ID4gPiBoYW8ueGlhbmdAYnl0ZWRh
bmNlLmNvbTsgYnJ5YW4uemhhbmdAYnl0ZWRhbmNlLmNvbTsgWm91LCBOYW5oYWkNCj4gPiA+IDxu
YW5oYWkuem91QGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNy83XSB0
ZXN0cy9taWdyYXRpb24tdGVzdDogYWRkIHFwbCBjb21wcmVzc2lvbg0KPiB0ZXN0DQo+ID4gPg0K
PiA+ID4gT24gV2VkLCBNYXIgMjAsIDIwMjQgYXQgMTI6NDU6MjdBTSArMDgwMCwgWXVhbiBMaXUg
d3JvdGU6DQo+ID4gPiA+IGFkZCBxcGwgdG8gY29tcHJlc3Npb24gbWV0aG9kIHRlc3QgZm9yIG11
bHRpZmQgbWlncmF0aW9uDQo+ID4gPiA+DQo+ID4gPiA+IHRoZSBtaWdyYXRpb24gd2l0aCBxcGwg
Y29tcHJlc3Npb24gbmVlZHMgdG8gYWNjZXNzIElBQSBoYXJkd2FyZQ0KPiA+ID4gPiByZXNvdXJj
ZSwgcGxlYXNlIHJ1biAiY2hlY2stcXRlc3QiIHdpdGggc3VkbyBvciByb290IHBlcm1pc3Npb24s
DQo+ID4gPiA+IG90aGVyd2lzZSBtaWdyYXRpb24gdGVzdCB3aWxsIGZhaWwNCj4gPiA+DQo+ID4g
PiBUaGF0J3Mgbm90IGFuIGFjY2VwdGFibGUgcmVxdWlyZW1lbnQuDQo+ID4gPg0KPiA+ID4gSWYg
c29tZW9uZSBidWlsZHMgUUVNVSB3aXRoIFFQTCwgdGhlIG1pZ3JhdGlvbiB0ZXN0ICptdXN0Kg0K
PiA+ID4gcGFzcyAxMDAlIHJlbGlhYmx5IHdoZW4gZWl0aGVyIHJ1bm5pbmcgb24gYSBob3N0IHdp
dGhvdXQNCj4gPiA+IHRoZSBRUEwgcmVxdWlyZWQgaGFyZHdhcmUsIG9yIHdoZW4gbGFja2luZyBw
ZXJtaXNzaW9ucy4NCj4gPiA+DQo+ID4gPiBUaGUgdGVzdCBjYXNlIG5lZWRzIHRvIGRldGVjdCB0
aGVzZSBzY2VuYXJpb3MgYW5kIGF1dG9tYXRpY2FsbHkNCj4gPiA+IHNraXAgdGhlIHRlc3QgaWYg
aXQgaXMgaW5jYXBhYmxlIG9mIHJ1bm5pbmcgc3VjY2Vzc2Z1bGx5Lg0KPiA+ID4gVGhpcyByYWlz
ZXMgYW5vdGhlciBxdWVzdGlvbiB0aG91Z2guIElmIFFQTCBtaWdyYXRpb24gcmVxdWlyZXMNCj4g
PiA+IHJ1bm5pbmcgYXMgcm9vdCwgdGhlbiBpdCBpcyBlZmZlY3RpdmVseSB1bnVzYWJsZSBmb3Ig
UUVNVSwgYXMNCj4gPiA+IG5vIHNhbmUgZGVwbG95bWVudCBldmVyIHJ1bnMgUUVNVSBhcyByb290
Lg0KPiA+ID4NCj4gPiA+IElzIHRoZXJlIGEgd2F5IHRvIG1ha2UgUVBMIHdvcmsgZm9yIG5vbi1y
b290IHVzZXJzID8NCj4gPg0KPiA+IFRoZXJlIGFyZSB0d28gaXNzdWVzIGhlcmUNCj4gPiAxLiBJ
IG5lZWQgdG8gYWRkIGFuIElBQSByZXNvdXJjZSBkZXRlY3Rpb24gYmVmb3JlIHRoZSBRUEwgdGVz
dCBiZWdpbnMNCj4gPiAgICBJbiB0aGlzIHdheSwgd2hlbiBRUEwgcmVzb3VyY2VzIGFyZSB1bmF2
YWlsYWJsZSwgdGhlIGxpdmUgbWlncmF0aW9uDQo+ID4gICAgdGVzdCB3aWxsIG5vdCBiZSBhZmZl
Y3RlZC4NCj4gPg0KPiA+IDIuIEkgbmVlZCB0byBhZGQgc29tZSBhZGRpdGlvbmFsIGluZm9ybWF0
aW9uIGFib3V0IElBQSBjb25maWd1cmF0aW9uIGluDQo+ID4gICAgdGhlIGRldmVsL3FwbC1jb21w
cmVzc2lvbi5yc3QgZG9jdW1lbnRhdGlvbi4gSW4gYWRkaXRpb24gdG8NCj4gY29uZmlndXJpbmcN
Cj4gPiAgICBJQUEgcmVzb3VyY2VzLCB0aGUgc3lzdGVtIGFkbWluaXN0cmF0b3IgYWxzbyBuZWVk
cyB0byBhc3NpZ24gSUFBDQo+IHJlc291cmNlcw0KPiA+ICAgIHRvIHVzZXIgZ3JvdXBzLg0KPiA+
ICAgIEZvciBleGFtcGxlLCB0aGUgc3lzdGVtIGFkbWluaXN0cmF0b3IgcnVucyAiY2hvd24gLVIg
dXNlciAvZGV2L2lheCIsDQo+IHRoZW4NCj4gPiAgICBhbGwgSUFBIHJlc291cmNlcyBjYW4gYmUg
YWNjZXNzZWQgYnkgInVzZXIiLCB0aGlzIG1ldGhvZCBkb2VzIG5vdA0KPiByZXF1aXJlDQo+ID4g
ICAgc3VkbyBvciByb290IHBlcm1pc3Npb25zDQo+IA0KPiBPaywgc28gaW4gdGhlIHRlc3Qgc3Vp
dGUgeW91IGxpa2VseSBzaG91bGQgZG8gc29tZXRoaW5nDQo+IGFwcHJveGltYXRlbHkgbGlrZQ0K
PiANCj4gI2lmZGVmIENPTkZJR19RUEwNCj4gICBpZiAoYWNjZXNzKCIvZGV2L2lheCIsIFJfT0t8
V19PSykgPT0gMCkgew0KPiAgICAgbWlncmF0aW9uX3Rlc3RfYWRkKCIvbWlncmF0aW9uL211bHRp
ZmQvdGNwL3BsYWluL3FwbCIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgdGVzdF9tdWx0aWZk
X3RjcF9xcGwpOw0KPiAgIH0NCj4gI2VuZGlmDQo+IA0KPiBwb3NzaWJseSBtb3JlIGlmIHlvdSBu
ZWVkIHRvIGFjdHVhbGx5IHF1ZXJ5IHN1cHBvcnRlZCBmZWF0dXJlcw0KPiBvZiAvZGV2L2lheCBi
ZWZvcmUgdHJ5aW5nIHRvIHVzZSBpdA0KDQpZZXMsIHZlcnkgdGhhbmtzIGZvciB5b3VyIHN1Z2dl
c3Rpb24sIEkgd2lsbCBmaXggdGhpcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFl1YW4gTGl1IDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiA+ID4gPiBSZXZp
ZXdlZC1ieTogTmFuaGFpIFpvdSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiAgdGVzdHMvcXRlc3QvbWlncmF0aW9uLXRlc3QuYyB8IDI0ICsrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4g
PiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi10ZXN0LmMg
Yi90ZXN0cy9xdGVzdC9taWdyYXRpb24tDQo+IHRlc3QuYw0KPiA+ID4gPiBpbmRleCA3MTg5NWFi
YjdmLi4wNTJkMGQ2MGZkIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS90ZXN0cy9xdGVzdC9taWdyYXRp
b24tdGVzdC5jDQo+ID4gPiA+ICsrKyBiL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi10ZXN0LmMNCj4g
PiA+ID4gQEAgLTI4MTUsNiArMjgxNSwxNSBAQA0KPiA+ID4gdGVzdF9taWdyYXRlX3ByZWNvcHlf
dGNwX211bHRpZmRfenN0ZF9zdGFydChRVGVzdFN0YXRlICpmcm9tLA0KPiA+ID4gPiAgfQ0KPiA+
ID4gPiAgI2VuZGlmIC8qIENPTkZJR19aU1REICovDQo+ID4gPiA+DQo+ID4gPiA+ICsjaWZkZWYg
Q09ORklHX1FQTA0KPiA+ID4gPiArc3RhdGljIHZvaWQgKg0KPiA+ID4gPiArdGVzdF9taWdyYXRl
X3ByZWNvcHlfdGNwX211bHRpZmRfcXBsX3N0YXJ0KFFUZXN0U3RhdGUgKmZyb20sDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFUZXN0U3RhdGUg
KnRvKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArICAgIHJldHVybiB0ZXN0X21pZ3JhdGVfcHJlY29w
eV90Y3BfbXVsdGlmZF9zdGFydF9jb21tb24oZnJvbSwgdG8sDQo+ID4gPiAicXBsIik7DQo+ID4g
PiA+ICt9DQo+ID4gPiA+ICsjZW5kaWYgLyogQ09ORklHX1FQTCAqLw0KPiA+ID4gPiArDQo+ID4g
PiA+ICBzdGF0aWMgdm9pZCB0ZXN0X211bHRpZmRfdGNwX25vbmUodm9pZCkNCj4gPiA+ID4gIHsN
Cj4gPiA+ID4gICAgICBNaWdyYXRlQ29tbW9uIGFyZ3MgPSB7DQo+ID4gPiA+IEBAIC0yODgwLDYg
KzI4ODksMTcgQEAgc3RhdGljIHZvaWQgdGVzdF9tdWx0aWZkX3RjcF96c3RkKHZvaWQpDQo+ID4g
PiA+ICB9DQo+ID4gPiA+ICAjZW5kaWYNCj4gPiA+ID4NCj4gPiA+ID4gKyNpZmRlZiBDT05GSUdf
UVBMDQo+ID4gPiA+ICtzdGF0aWMgdm9pZCB0ZXN0X211bHRpZmRfdGNwX3FwbCh2b2lkKQ0KPiA+
ID4gPiArew0KPiA+ID4gPiArICAgIE1pZ3JhdGVDb21tb24gYXJncyA9IHsNCj4gPiA+ID4gKyAg
ICAgICAgLmxpc3Rlbl91cmkgPSAiZGVmZXIiLA0KPiA+ID4gPiArICAgICAgICAuc3RhcnRfaG9v
ayA9IHRlc3RfbWlncmF0ZV9wcmVjb3B5X3RjcF9tdWx0aWZkX3FwbF9zdGFydCwNCj4gPiA+ID4g
KyAgICB9Ow0KPiA+ID4gPiArICAgIHRlc3RfcHJlY29weV9jb21tb24oJmFyZ3MpOw0KPiA+ID4g
PiArfQ0KPiA+ID4gPiArI2VuZGlmDQo+ID4gPiA+ICsNCj4gPiA+ID4gICNpZmRlZiBDT05GSUdf
R05VVExTDQo+ID4gPiA+ICBzdGF0aWMgdm9pZCAqDQo+ID4gPiA+ICB0ZXN0X21pZ3JhdGVfbXVs
dGlmZF90Y3BfdGxzX3Bza19zdGFydF9tYXRjaChRVGVzdFN0YXRlICpmcm9tLA0KPiA+ID4gPiBA
QCAtMzc4OSw2ICszODA5LDEwIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4g
PiA+ID4gICAgICBtaWdyYXRpb25fdGVzdF9hZGQoIi9taWdyYXRpb24vbXVsdGlmZC90Y3AvcGxh
aW4venN0ZCIsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHRlc3RfbXVsdGlmZF90
Y3BfenN0ZCk7DQo+ID4gPiA+ICAjZW5kaWYNCj4gPiA+ID4gKyNpZmRlZiBDT05GSUdfUVBMDQo+
ID4gPiA+ICsgICAgbWlncmF0aW9uX3Rlc3RfYWRkKCIvbWlncmF0aW9uL211bHRpZmQvdGNwL3Bs
YWluL3FwbCIsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHRlc3RfbXVsdGlmZF90
Y3BfcXBsKTsNCj4gPiA+ID4gKyNlbmRpZg0KPiA+ID4gPiAgI2lmZGVmIENPTkZJR19HTlVUTFMN
Cj4gPiA+ID4gICAgICBtaWdyYXRpb25fdGVzdF9hZGQoIi9taWdyYXRpb24vbXVsdGlmZC90Y3Av
dGxzL3Bzay9tYXRjaCIsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHRlc3RfbXVs
dGlmZF90Y3BfdGxzX3Bza19tYXRjaCk7DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMzkuMw0KPiA+
ID4gPg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFdpdGggcmVnYXJkcywNCj4gPiA+IERhbmllbA0K
PiA+ID4gLS0NCj4gPiA+IHw6IGh0dHBzOi8vYmVycmFuZ2UuY29tICAgICAgLW8tDQo+ID4gPiBo
dHRwczovL3d3dy5mbGlja3IuY29tL3Bob3Rvcy9kYmVycmFuZ2UgOnwNCj4gPiA+IHw6IGh0dHBz
Oi8vbGlidmlydC5vcmcgICAgICAgICAtby0NCj4gPiA+IGh0dHBzOi8vZnN0b3AxMzguYmVycmFu
Z2UuY29tIDp8DQo+ID4gPiB8OiBodHRwczovL2VudGFuZ2xlLXBob3RvLm9yZyAgICAtby0NCj4g
PiA+IGh0dHBzOi8vd3d3Lmluc3RhZ3JhbS5jb20vZGJlcnJhbmdlIDp8DQo+ID4NCj4gDQo+IFdp
dGggcmVnYXJkcywNCj4gRGFuaWVsDQo+IC0tDQo+IHw6IGh0dHBzOi8vYmVycmFuZ2UuY29tICAg
ICAgLW8tDQo+IGh0dHBzOi8vd3d3LmZsaWNrci5jb20vcGhvdG9zL2RiZXJyYW5nZSA6fA0KPiB8
OiBodHRwczovL2xpYnZpcnQub3JnICAgICAgICAgLW8tDQo+IGh0dHBzOi8vZnN0b3AxMzguYmVy
cmFuZ2UuY29tIDp8DQo+IHw6IGh0dHBzOi8vZW50YW5nbGUtcGhvdG8ub3JnICAgIC1vLQ0KPiBo
dHRwczovL3d3dy5pbnN0YWdyYW0uY29tL2RiZXJyYW5nZSA6fA0KDQo=

