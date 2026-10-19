Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8421FCCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIk1B-0005MY-KB; Mon, 19 Oct 2026 05:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xIk12-0005LU-0J
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:50:48 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xIk0z-0005QU-Kz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792403446; x=1823939446;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qbf/aVOn0kt1iUh++cu6ZrrRVxxGcsy87NO2I+0Qn40=;
 b=XaS+PU7Egr/miiAliVMtJrVGczDdK4hhUrI4aAHooLUn5EbqKwytou+b
 e2LcZIK7lGFV/GhGL80NKiv7mzdqRraX7uGarjhBP8imz4qZCqfHOou0d
 QSyIFseyJnaFYNMIjgH/3Z/cJrOjWF3+R34JliS9c6z8IMpGqvovg5+T+
 clvGbKaGVssK0KzY1D1CoRrUnzzU8pMkRQYaEY23DMe/ezPyZJ+pf1tyW
 c/pnt6r/P6j/C7psnOG/ubae0lmuxtYKxEaMAYDXC/BOf1LCy5bn8GxA2
 Knej/MbVCzIHajqSqkLKqHIKnEjNY1usgKbhXv+v7Pzpp0HXPU4HPL6s4 w==;
X-CSE-ConnectionGUID: hvgQFq6iQWiZjFa8JtdjRg==
X-CSE-MsgGUID: BKfBDXIKQ0uZMCmvljY/Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1105736"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1105736"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 02:50:40 -0700
X-CSE-ConnectionGUID: LeFKCF7SQC2QyjZmU6/+AQ==
X-CSE-MsgGUID: dtknbHRHRnGw57yP2qkoaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2835051"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 02:50:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 02:50:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 02:50:37 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 02:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8KC9LFUwqAztWWsiSLx24clJdYSXyUIKGBHomT+xYTQXhz1D1xLiXub6QpsihSRdqsGCiTzL/h9mGh8v9sDD8wPeSYaD9P3Vl7E7Vt/hH0MSKrIn7qTvO8gDRgp4In7fgjex0bAUSHuan4fQk9pOc5PStk0aMFfM7MjtrbsuKXrEvZVl62puALe5uDJp7eBZyj7J3SQYjhfwCfrZpQAEAedYXQ3smYhGk2VuSm2xHN7BH4PeP/M9GoT/Logy+vuacNSZVF2WfzJoVFNA3hxw0SRsKl4O/Dv0S90NXKyA0U+sF8F2XjslgI0hTc/bJ2BCk68Icy3K8Yf/uUA9iqw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qbf/aVOn0kt1iUh++cu6ZrrRVxxGcsy87NO2I+0Qn40=;
 b=mllVzpbzctS1RKUGft56tpVVF9EPoCMSsSjJZcau9y8qVWtj3tavZaDv6bSjJuN9MIghh6HR1DBjf7278UraTophfp6Lq+VNOTu6W/dmpqmfQucvJhJoVBCb3hjStSf/OcH061AH/0/PymSrolsSPvd1mQ+mVHi+3+dEnkopRcXTsopqJtnXF+VAW84rZJehB0MnbwIxLoGvd8EDWL8KVo46jFNX6rDLxdq3GbAzMg4WVdgZ51cM+I3KXGrTEuh0itJeUvz3aFY9Br+En4ydRxnsbpzlciI9diXYncO4vgTJDT71FhH97NfGfgT6ZOOjjBAPKI9YWUE4ISpDS2ww1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB7043.namprd11.prod.outlook.com (2603:10b6:806:29a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:50:35 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:50:35 +0000
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
Subject: RE: [PATCH v8 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
Thread-Topic: [PATCH v8 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
Thread-Index: AQHdV828wzshGbvx9ECNBG9MIYLlQLcDYp2AgADX9nCAAHOmoA==
Date: Mon, 19 Oct 2026 09:50:35 +0000
Message-ID: <IA3PR11MB9136715B1F812D5215836B1092982@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
 <20261009090737.3930000-7-zhenzhong.duan@intel.com>
 <d7b37c65-7234-4eb4-b960-454572f447a5@intel.com>
 <IA3PR11MB91360BE8D6DA1C1F7239873092982@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB91360BE8D6DA1C1F7239873092982@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB7043:EE_
x-ms-office365-filtering-correlation-id: 1f44a30c-2e11-4157-ef77-08df2dc66c71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|261009223027099003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: 9vL1TmPbPnCAfZLxkvgtWBEHp9powhbBY4/1pRCfVchMcLCyHisv30ziRJmVqwl6Nj3uRP71HOYNWN5zY3OVTnItwI+RIF41iFLhlBWGim0ggwzak8AhMxyNoH5S1ndXFYV5FIys4mg6d8NLOrdvjUwgSbYqr7QMdmgBb2KfoRj0ZZ4dJgQsZ5E9EsuTT/1Zns3Jn0v6g8j8zJUuef4WHizN+zeZ6qJkMlyXNvb06sambeMOijv/LU+xakYJADbvHu4+PxzTPZ2z20dRzzCd/sRDD4cc44HBcjCOy9ixqj9USeVWuEEexkWIc1fuU6ESAX0GM7EHBkwr1WsJrqz2B+Tm6yOyI+zJtG/wCybvDcjFOJhlc97FjTWC7fUilWW86J0bjyoSp5ui+oylXu3uwRaQa/O8TG/lljphl1p+VE4Dn23eIbEpIrhgO8bHwxKV7Prl5qoeZ9ks1oN6EHhbGV+SN5QWnCrzrppUgoaxb+5sUK/cStWjeyE+MRNfpJHumtwWTQG1XJqMWQPT20UZPSQKkV1jjFDcA8dCPi15NJQItCoFT1/ZHPBBNQa3RhzjkQ9e9IQOm0aDSQ89zN8d7wq/E4VPHegthaCwK3xe4HHSBVe8eaHsRKxOUUq1La1ZWewAJvR9SpE+57rI/pwgHBVk6kwLz/udAtb+TL+x7tW5G9NAcNAuuTcVqbVn98EEbUnsfzIlVa6sXi2SdbvHVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(261009223027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWsrU0RraFhXcURnV3pGN2tuR1pDZzNrRmFrQXBsWERaVXV2NG8rU3ZYT1cw?=
 =?utf-8?B?dUhMVHYzMzFqZkt5UEJGK29manJTRXNvMisxNkJvUGoyamR6Mm9MYWVGY0pN?=
 =?utf-8?B?L0ZISHU5QzFiTHRvYysyQTRqK29qdFRIL1NmMUlBVklTLzJxUVh5Y3hqeC9F?=
 =?utf-8?B?OFlIb0xpRTlITkJ5RElvUXEzMUkrSEJYOVBxSkJ2OVllRnlqL1gyVU13cy9Z?=
 =?utf-8?B?U3ZvUnVpbm1jNTV3cWNUTHRPMmFKMTFYeFVlcVpJdmVSV2tNMGxoTjFZWHlr?=
 =?utf-8?B?cVJHcDNRLzZubUo4RFFCYWtyT3dsK2p1c1JDSVZ6MW83VU1TZW5Fd3FmbHlm?=
 =?utf-8?B?ajFBSExrNnFqSGU2YUYrclhyWWovYzY4K3M3d2h3dmlERWh3WEtMdmdBUEhy?=
 =?utf-8?B?dGg3WHZuRkFscDVVVGZIL0dhVVJYQWU0d0ZNN25jVTJScVJUQ0tKTTBDdWc2?=
 =?utf-8?B?WVFGMm84WitobWltdlhHZTZ5Y1FSYzVOQnZob2c5Z1U2SkIyQ0x1aGt2djY1?=
 =?utf-8?B?cXF4dGJ5SzVlWWhFaVRFbStBSE1QUFh2Q01qdE9EUHpKcU5FTkZGbEV4cFJL?=
 =?utf-8?B?d2VFK0pYU1lvcjAydll4QSs4UnpjRlBqY3FjenlIQkpEck1MUlo1Z3oyc21a?=
 =?utf-8?B?MjRwOGdZb3JFR3VCdDlObW1vd2k3ZVExenlaU1Y5enB6RFpSS2RUK0ZlclVD?=
 =?utf-8?B?YUhnWUcwL1p2aVh1YllkK0VuUVRCUEdyNHczUWhsMlhPTzl2SjRhTW5QSmx0?=
 =?utf-8?B?RU1oUTdQVG9wd3ZFTFI3V2VFTGVkVEVrdTUrVHB2UEgzRlZWL1BXdStLSVMz?=
 =?utf-8?B?cE9mNHl5VDhKTXVTMEZFZlN6Y0gvYVhQcm8rWEM0VFc1TTdaam1taEF2VmpT?=
 =?utf-8?B?a3RLTWt1OGl6VEErc0V4bFJhZ3pvaGZBOUJ6M3dhYmpnczBmOUsxcUdWYWRK?=
 =?utf-8?B?cGI3UWpHelBXUEFjN1JFZFBVRWhPWHdEZHdlWGZqQWNKb0R1MWdkK0w1VjBK?=
 =?utf-8?B?azIwWE5oajZWZnpmNFQ3clZTWndDcGc0M0NMTUNpeTBLUFpZUWZyMUp4RjVB?=
 =?utf-8?B?NG9WTlJ6dVlJYlYvVC9PUWhadkRPNEQ4R0U0Y3JoaUFMMHhXdHB6Z25PNWpY?=
 =?utf-8?B?U1JiVHRBd2x2RmZJYk9WRmdYTGwrNXNIQW9tTmxjdGVNcldDTFhhZ3RvaHlM?=
 =?utf-8?B?cUpNd212NXVXRXBrRW9ZNHd1K1huR2JTa0hFRU5DUGJ1OGlEZUk2OHdjaHU3?=
 =?utf-8?B?RWtnUmVZMEFiUENBNVduY3VOOGxJNnV6clZJRE84QU9BU21UVjFqOElzblha?=
 =?utf-8?B?MWNJSTlJd1VESE5vQ0I5SG11N0ZtRVQwenhxREoxTlZJbS85VGdMT3JyNThs?=
 =?utf-8?B?cG81eW9pVmNGRHdnT0o2VVA2WjF0V1JXSzAxczJDYlkzbm9wL2kxT0RvMUpv?=
 =?utf-8?B?anVkbHZlT2dtVDhsVUIvVm91VVVHYWFJQWQ2eVhzTUZPaENmekExNUhob2Nx?=
 =?utf-8?B?V295NzZ1ZkZTekhWQ3E3ZHhrTUd1ZmVJdDQ0bVZVaGxGRDhtK3dyWkowL2Jk?=
 =?utf-8?B?bG9RSWFLOXN4WG5MSkNWSjNoZEpuU2xQQTdvcmlzVFdEdFVUU2hNMkJEZ2ph?=
 =?utf-8?B?ZE5IakxnRGN1YlMzV3VDaGl5cUIxd2F2S2s5Q3VNRzAxa0hFbm9KUlFNZGc4?=
 =?utf-8?B?YWNETGlQUEY5Y3dmTXJDMGNvTTdYRktleXVxRTl6L0ZmYUpMeHNRVXl4SW1x?=
 =?utf-8?B?VlhudDZRUGVldndqMGpSTFVOZCtFM1hSem1CanNZTXgydVptbk1vakpMOEw1?=
 =?utf-8?B?ZmREUEZ1dUN3cW9xMjE5T2k5TS9qWDhZTEc0c055aFgvajR6MjRmY1FqYkJG?=
 =?utf-8?B?RittTXZkenpoeVFpL244VTVESGZUS0JHWnB4cFk3Y014K0x2RlI2R2UvVitW?=
 =?utf-8?B?bW1qZDJyT2gvaUVFdm8wN2JEVXBCd1pyUjkxV0thQ0srZERlZnF5aThjaXpU?=
 =?utf-8?B?Q0tlVmRRekRJdzdQZGc5Y01JQzI4LzdTeDczZkZhQ2MzSEZXYU9aTU1Td29F?=
 =?utf-8?B?bTJ1dENnM1FwaW1qWVkxVFhHVU9ybEFJcGt5WFFrQnAyVDNhajZtRjBOVHF1?=
 =?utf-8?B?enFoUlhSTkhpR0hOUkZaNEc1VjdXZzY2dFZjNS9peG1Ua1VDVG5WUWpWWVR2?=
 =?utf-8?B?b214emhqZ0NrcjF4VnBvMFlDT0F2Znh0SUxmOWVxVzRONWhqN05HeHcwdkhv?=
 =?utf-8?B?QXRvOHRPK2MydDNWMXFWQXFWc0M5NFd0ZEFNS0hId2ZFOE9QYTRlVWtibk0v?=
 =?utf-8?B?RnBSVllnTzJGZTI5em9TL2lxenAwbEJySkQrMTJDdjE3OXF6RFNNUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uA3WNnQt73MGXAJlOtWJjFd1IXS/lYRbiHbPL1GJxbIiSk0jPppWvronQYrhr34z5XXdj/RMCkM5s6rasP+SW7/KpZeY6YuPqse5jUNJ+liOBMbX7ggNC/1WQCgfdNg47CR7TiEUJLMBsjzFfZwl7CmL3o7DeALDwSnW7JiUUAnWhKG/DHPbbyY7ZXT6xU/kfiHvDrD8l+Giwb2K+LxDjPRWvZPS+iTukEjk6zn35eablXaLB7WYpwwSk59ustk3UufnVeAyXlaFAYgC7PiOUntWIxhcxtcTC9sr3MTeoqx1JYEi2Uiy8PC82cKXJK4+uyxC/361STvkdOgl5hfARw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f44a30c-2e11-4157-ef77-08df2dc66c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:50:35.5933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFrT8OwVuaDZ/LflxpdNs2Pa1CAHUA8jZ7BKE+r0O26/sYIayZ4lsKCu2v0ZD6XQC6S0D24ZzgZWmDCru1v8rEbL1RwUExGnvYLTxZbt6wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7043
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IER1YW4sIFpoZW56aG9uZw0K
PlN1YmplY3Q6IFJFOiBbUEFUQ0ggdjggNi82XSBpbnRlbF9pb21tdV9hY2NlbDogdGVhcmRvd24g
RkFVTFRRIHJlc291cmNlcyBpbg0KPmJvdHRvbSBoYWxmDQo+DQo+DQo+DQo+Pi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0K
Pj5TdWJqZWN0OiBSZTogW1BBVENIIHY4IDYvNl0gaW50ZWxfaW9tbXVfYWNjZWw6IHRlYXJkb3du
IEZBVUxUUSByZXNvdXJjZXMNCj5pbg0KPj5ib3R0b20gaGFsZg0KPj4NCj4+T24gMTAvOS8yNiAx
NzowNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4gV2hlbiBhIHBhc2lkIGVudHJ5IGJlY29t
ZXMgaW52YWxpZCwgd2UgbmVlZCB0byByZWxlYXNlIGFsbCByZXNvdXJjZXMNCj4+PiBhbGxvY2F0
ZWQgZm9yIHRoYXQgZW50cnkgaW5jbHVkaW5nIEZBVUxUUSBvYmplY3QgYW5kIGZhdWx0X2ZkLg0K
Pj4+DQo+Pj4gV2UgY2FsbCBxZW11X3NldF9mZF9oYW5kbGVyKCkgdG8gZGV0YWNoIGZhdWx0X2Zk
J3MgaW9fcmVhZCBoYW5kbGVyIGFuZA0KPj4+IHdha2VzIHVwIG1haW4gdGhyZWFkIGZyb20gcG9s
bCgpLCBidXQgdGhlcmUgY291bGQgc3RpbGwgYmUgYSBzbWFsbA0KPj4+IHdpbmRvdyB3ZSBjYWxs
IGlvbW11ZmRfYmFja2VuZF9mcmVlX2lkKGZhdWx0X2lkKSBiZWZvcmUgcG9sbCgpIGV4aXQNCj4+
PiBhbmQgcmVsZWFzZSBmYXVsdF9pZCBmaWxlIHJlZmVyZW5jZS4gSW4gdGhpcyByYXJlIGNhc2Us
IEZBVUxUUSBvYmplY3QNCj4+PiBmcmVlIHJldHVybiAtRUJVU1kgYmVjYXVzZSBvcGVuZWQgZmF1
bHRfaWQgZmlsZSBrZWVwcyByZWZlcmVuY2Ugb2YNCj4+PiBGQVVMVFEgb2JqZWN0Lg0KPj4+DQo+
Pj4gVGVhcmRvd24gRkFVTFRRIHJlc291cmNlcyBpbiBib3R0b20gaGFsZiB0byBlbnN1cmUgcG9s
bCgpIGhhcyByZWxlYXNlZA0KPj4+IGZhdWx0X2lkIGZpbGUgcmVmZXJlbmNlLg0KPj4+DQo+Pj4g
U3VnZ2VzdGVkLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj4+IFRlc3RlZC1ieTogWHVkb25nIEhhbyA8eHVkb25nLmhhb0BpbnRlbC5jb20+DQo+
Pj4gLS0tDQo+Pj4gICBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgfCA0MCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMzcgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody9pMzg2
L2ludGVsX2lvbW11X2FjY2VsLmMgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+PiBp
bmRleCBjZDIyNzMxNWRhLi5jMDdmZmE2OGUwIDEwMDY0NA0KPj4+IC0tLSBhL2h3L2kzODYvaW50
ZWxfaW9tbXVfYWNjZWwuYw0KPj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0K
Pj4+IEBAIC0yNjgsMTcgKzI2OCw1MSBAQCBmcmVlX2ZhdWx0cToNCj4+PiAgICAgICByZXR1cm4g
ZmFsc2U7DQo+Pj4gICB9DQo+Pj4NCj4+PiArdHlwZWRlZiBzdHJ1Y3QgSU9NTVVGYXVsdFF1ZXVl
IHsNCj4+PiArICAgIElPTU1VRkRCYWNrZW5kICppb21tdWZkOw0KPj4+ICsgICAgdWludDMyX3Qg
aWQ7DQo+Pj4gKyAgICBpbnQgZmQ7DQo+Pj4gKyAgICBRTElTVF9IRUFEKCwgVlREUFJRRW50cnkp
IHZ0ZF9wcnFfbGlzdDsNCj4+PiArfSBJT01NVUZhdWx0UXVldWU7DQo+Pj4gKw0KPj4+ICtzdGF0
aWMgdm9pZCBmYXVsdHFfdGVhcmRvd25fYmgodm9pZCAqb3BhcXVlKQ0KPj4+ICt7DQo+Pj4gKyAg
ICBJT01NVUZhdWx0UXVldWUgKmZxID0gb3BhcXVlOw0KPj4+ICsgICAgVlREUFJRRW50cnkgKnBy
cWUsICpuZXh0Ow0KPj4+ICsNCj4+PiArICAgIFFMSVNUX0ZPUkVBQ0hfU0FGRShwcnFlLCAmZnEt
PnZ0ZF9wcnFfbGlzdCwgbmV4dCwgbmV4dCkgew0KPj4+ICsgICAgICAgIFFMSVNUX1JFTU9WRShw
cnFlLCBuZXh0KTsNCj4+PiArICAgICAgICBnX2ZyZWUocHJxZSk7DQo+Pj4gKyAgICB9DQo+Pj4g
Kw0KPj4+ICsgICAgcWVtdV9zZXRfZmRfaGFuZGxlcihmcS0+ZmQsIE5VTEwsIE5VTEwsIE5VTEwp
Ow0KPj4+ICsgICAgY2xvc2UoZnEtPmZkKTsNCj4+PiArICAgIGlvbW11ZmRfYmFja2VuZF9mcmVl
X2lkKGZxLT5pb21tdWZkLCBmcS0+aWQpOw0KPj4+ICsNCj4+DQo+PmEgbml0OiBhbnkgcmVhc29u
IHRoYXQgeW91IG9wZW4gY29kZSBpbnN0ZWFkIG9mIHJldXNpbmcNCj4+dnRkX2Rlc3Ryb3lfZnNf
ZmF1bHRxKCkgYXMgdGhlIGV4aXN0aW5nIGNvZGU/IElmIG5vIHNwZWNpYWwNCj4+cmVhc29uLCBt
YXkgYmUgYmV0dGVyIHJldXNpbmcgaXQuDQo+DQo+SW1hZ2luZyB3aGVuIHdlIHVucGx1ZyBhIHZm
aW8gZGV2aWNlLCB0aGUgYm90dG9tIGhhbGYgY2FuDQo+cnVuIGFmdGVyIHZmaW8gZGV2aWNlIGFy
ZSBhbHJlYWR5IGZyZWVkLCBpZiB3ZSByZXVzZQ0KPnZ0ZF9kZXN0cm95X2ZzX2ZhdWx0cSgpIHdp
dGggdnRkX2hpb2QgYXMgaW5wdXQsIHZ0ZF9oaW9kDQo+Y2FuIGJlIGdhcmJhZ2UgaXRzZWxmIGFu
ZCB3ZSBjcmFzaCBxZW11Lg0KDQpPaCwgSSBqdXN0IGZpbmQgYSBwb3RlbnRpYWwgcmFjZSBhYm91
dCBpb21tdWZkIHdoZW4gdW5wbHVnIGENCnZmaW8gZGV2aWNlLCBJJ2xsIGFkZCBiZWxvdyBjaGFu
Z2UgaW4gbmV4dCB2ZXJzaW9uLg0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9h
Y2NlbC5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQppbmRleCBjMDdmZmE2OGUwLi5h
YzdmOGUyMDVjIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQorKysg
Yi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCkBAIC0yODgsNiArMjg4LDcgQEAgc3RhdGlj
IHZvaWQgZmF1bHRxX3RlYXJkb3duX2JoKHZvaWQgKm9wYXF1ZSkNCiAgICAgcWVtdV9zZXRfZmRf
aGFuZGxlcihmcS0+ZmQsIE5VTEwsIE5VTEwsIE5VTEwpOw0KICAgICBjbG9zZShmcS0+ZmQpOw0K
ICAgICBpb21tdWZkX2JhY2tlbmRfZnJlZV9pZChmcS0+aW9tbXVmZCwgZnEtPmlkKTsNCisgICAg
aW9tbXVmZF9iYWNrZW5kX2Rpc2Nvbm5lY3QoZnEtPmlvbW11ZmQpOw0KDQogICAgIGdfZnJlZShm
cSk7DQogfQ0KQEAgLTMxMSw2ICszMTIsMjQgQEAgc3RhdGljIHZvaWQgdnRkX2Rlc3Ryb3lfb2xk
X2ZzX2ZhdWx0cShWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSAqdnRkX3BjZSkNCiAgICAgZnEtPnZ0
ZF9wcnFfbGlzdC5saF9maXJzdCA9IHZ0ZF9wY2UtPnZ0ZF9wcnFfbGlzdC5saF9maXJzdDsNCiAg
ICAgUUxJU1RfSU5JVCgmdnRkX3BjZS0+dnRkX3BycV9saXN0KTsNCg0KKyAgICAvKg0KKyAgICAg
KiBEdXJpbmcgYSBWRklPIGRldmljZSBob3QtdW5wbHVnLCBpZiB0aGlzIGlzIHRoZSBsYXN0IGRl
dmljZSBjb25uZWN0ZWQNCisgICAgICogdG8gdGhlIElPTU1VRkRCYWNrZW5kLCB0aGUgYmFja2Vu
ZCB1c2VyIGNvdW50IChpb21tdWZkLT51c2Vycykgd2lsbA0KKyAgICAgKiBkcm9wIHRvIHplcm8s
IHRyaWdnZXJpbmcgaW9tbXVmZF9iYWNrZW5kX2Rpc2Nvbm5lY3QoKSB3aGljaCBjbG9zZXMNCisg
ICAgICogdGhlIGJhY2tlbmQncyBvcGVuZWQgY29udGFpbmVyIEZELg0KKyAgICAgKg0KKyAgICAg
KiBTaW5jZSB0aGUgdGVhcmRvd24gb2YgdGhpcyBmYXVsdCBxdWV1ZSAoZmF1bHRxX3RlYXJkb3du
X2JoKSBpcw0KKyAgICAgKiBzY2hlZHVsZWQgYXN5bmNocm9ub3VzbHkgYXMgYSBib3R0b20gaGFs
Ziwgd2UgbXVzdCB0ZW1wb3JhcmlseQ0KKyAgICAgKiBpbmNyZW1lbnQgdGhlIGNvbm5lY3Rpb24g
dXNlciBjb3VudCBvZiB0aGUgaW9tbXVmZCBiYWNrZW5kIGhlcmUuDQorICAgICAqIFRoaXMgZ3Vh
cmFudGVlcyB0aGUgYmFja2VuZCBjb25uZWN0aW9uIHJlbWFpbnMgb3BlbiBhbmQgaXRzIG9wZW5l
ZA0KKyAgICAgKiBGRCByZW1haW5zIGFjdGl2ZSB1bnRpbCB0aGUgYXN5bmMgQkggY29tcGxldGVz
Lg0KKyAgICAgKg0KKyAgICAgKiBJbmNyZW1lbnRpbmcgdGhlIHVzZXIgY291bnQgaXMgZ3VhcmFu
dGVlZCB0byBzdWNjZWVkIGhlcmUgYmVjYXVzZSB0aGUNCisgICAgICogVkZJTyBkZXZpY2UgaXMg
c3RpbGwgcmVnaXN0ZXJlZCBhcyBhbiBhY3RpdmUgdXNlciBvZiB0aGUgYmFja2VuZCBhdA0KKyAg
ICAgKiB0aGlzIHBvaW50IGluIHRoZSB0ZWFyZG93biBzZXF1ZW5jZS4NCisgICAgICovDQorICAg
IGlvbW11ZmRfYmFja2VuZF9jb25uZWN0KGZxLT5pb21tdWZkLCBOVUxMKTsNCisNCiAgICAgYWlv
X2JoX3NjaGVkdWxlX29uZXNob3QoaW9oYW5kbGVyX2dldF9haW9fY29udGV4dCgpLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBmYXVsdHFfdGVhcmRvd25fYmgsIGZxKTsNCiB9DQo=

