Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D0BCF8577
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 09:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM0zM-0000Kk-EO; Thu, 20 Nov 2025 04:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vM0zD-0000Gb-R7
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 04:29:56 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vM0z8-0004PY-II
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 04:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763630991; x=1795166991;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xrcJZGpl7JAse7NWw9reo37BwqQeU/l/vPjDg05tuYE=;
 b=bIwuUhijTeQgdcvbUDxM5KBmNXDG2X1UAxeDkLwXmA70rSmAttaTJs2s
 q2JHl17DE2Fd2xd92+TJ+qpeH7VrfwVgQspvfQMDaTxkzzgeOWegNA5Ow
 ORzY66BDkl344xxxW1oTQ+Vdobd+4Pm7XAoHSheuciMAO/PpA2o2CXOFh
 JlBXsVCfxmme/Vuz8zUo3GGmTaPozHEszmE9op+AtFSJVWU5d/KKjEWyI
 t+TbmeKzg/CcftV4BdhFDoXa8v4EdpKWE0WUNfLojBGUmuSqbFlikQCx/
 N/IIsj9uWjlbjQQs/4skePBEsdFYTm0JWzz4MpwzdfZIjIA+3kJTHFxEn Q==;
X-CSE-ConnectionGUID: Kgo/ZXjCShC0dxS1vriQGA==
X-CSE-MsgGUID: 0Azt3XBBSsmxW4fqhpW+vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572455"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572455"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 01:29:45 -0800
X-CSE-ConnectionGUID: FnFCmcFbRXeFalMCMg2U2Q==
X-CSE-MsgGUID: iu2vr9HMRaei9BxUqVL2sQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 01:29:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 01:29:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 01:29:44 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 01:29:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYhZzJYCN68vLxNXMXhzA34zMGgJfX1Bbmj3fMrPzckF5NF+FmLCn/nnyFruxQtJMYql3kxWcartnVCLRKjXyDyW2pJm619DVssAQeemxX2sPt/b0eqcthNrAtXs+Trg2QnUgRcYy3jxpmSi6Tc/eXpkTJXPbgu/ZgFb2gLP4Tqor98ZlXT6O/dWNWhz4QnmbMvGJN0af2XqrMV6tqfWgaCrYxTJyuCPlHQz4t7XiQ9i4xZgrlJEb9WRQcw/jiv2BDaLwijratr84Ys5iMsPGp7zzT1+5Z9cToItd17rObNyxiKbQGH4oxhrWd+fxSoIAO74tderH0ZK+cEdSAemLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrcJZGpl7JAse7NWw9reo37BwqQeU/l/vPjDg05tuYE=;
 b=NYlvcNA5GNqi14hTMM6eMMn/XwfEntarGmXbL7/gMzC4Mjp01Zh7OH5JuKJ88CnTze7rcKXMS1Wzk+evvDLJErQm8nNNi2XThLHbVX3kj4KFZDV5Krt/gStycmzyxBOvZrD5+1qkBpoj4ouQdP1xl/qTuyFufoo/GmyTik9KheiREMf5U4z8+1AjXqzUhihx2AulmCc+1BDwfIDkBeYPuJi9A5SfNIAlJ11AcTs5vPBzlJDiZBi3R6Ib5biyg8+d2NCXO+0orJylr1WnRZ/XkoqGwrL+zPJoxEMsptLtZztAV8ZJQa8m3wZ5M36c9ErRBXCiiTju4S/3xcL+OEcUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH3PPFEC89C124F.namprd11.prod.outlook.com (2603:10b6:518:1::d5d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Thu, 20 Nov
 2025 09:29:37 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 09:29:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, Rohith S R <rohith.s.r@intel.com>, "Gross,
 Mark" <mark.gross@intel.com>, "Van De Ven, Arjan"
 <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v5 0/9] vfio: relax the vIOMMU check
Thread-Topic: [PATCH v5 0/9] vfio: relax the vIOMMU check
Thread-Index: AQHcTtS9IRCjPe3DhUyqG046jCGPSbT7YQ7w
Date: Thu, 20 Nov 2025 09:29:36 +0000
Message-ID: <IA3PR11MB91364009C0A6B80E2FFF425C92D4A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
In-Reply-To: <20251106042027.856594-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH3PPFEC89C124F:EE_
x-ms-office365-filtering-correlation-id: 7e590f23-37cc-4fd0-8a15-08de28175262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZjRERFNsZFVVUG5zcFdPNmlzbFpsWkZLMXFPUTBrMGhlL3QvRTNPT21adlZp?=
 =?utf-8?B?MU5KU0lLT3Nuczl5enVvSFNTRERNcnBKTm9EMkIvV1hqOEU5eWFTaXh6Szgy?=
 =?utf-8?B?MTZkUmp0Q2lnTVdJcXZHd2RsMzd6VTVueEQyTkx0Tzg3aDc2TmIyeGhQK3px?=
 =?utf-8?B?Njg3N1hrenF3RXh6TElOSzJ6cVdJUUxzblppV1E0eG0yekI0WjRLTDJaTUVa?=
 =?utf-8?B?MW04d0VlUllvVGZmN1VCZlRGZkphOEpZNEw3U3ZCTE9aeDl1L3BlV2NnMkRy?=
 =?utf-8?B?TzdVZ2M5M0xiWkE4NndsRlNSaENLMFRXL2F5MXRyMS9wV0dtbE9WanFDWlJI?=
 =?utf-8?B?T1Mrb3VKWUdqa3ZsZFJyT1NFNXkwRjJTT3F0SzFYZ0l6LytiSE9FSjIyY3Jz?=
 =?utf-8?B?OUJqYXA5eGpJZUxyZG90bzlnYUt6c0Nxcng0RFZrUEd6UWZFM1psTVZYTFJG?=
 =?utf-8?B?cjUrZ254WVR5cDRoN2RrK2pRZEMydzRmNnRqZFo2WTVkNWNtMlFRcEE0clM2?=
 =?utf-8?B?dlhFTkI2YTNNWStIcUQ3d1FJQktzdGg4cExEQjBhUzl5Z21RVkpJKytRNHdh?=
 =?utf-8?B?aDRuckpNNnYzWWgwNEhyL3YrVXVJZ1lKOG5kOCtOTUlOU3NEUDM2eFFNTTZM?=
 =?utf-8?B?bnhKdnlUQlA2NXdZWFRrQXE3R3NaODFyRjdLUDR3WHQ0enh0dEI4STVLZEhh?=
 =?utf-8?B?eEFvb1RMN0x6OXBlWmdCeXBldlNOVyt2aHQ0NzV1bmZuWXlSb1FUMFFpcWdk?=
 =?utf-8?B?bUc1SjZZWnVmd0NQZUZueG91cXA3aW5RMTgxb0NOTHZQS1h1SkkrRTlmYStq?=
 =?utf-8?B?cStFZkhuVjROQVBrSlZUSUlpd3J6MzRKbzFIV2R4Q01XaE5Id0xtTUhUOXRj?=
 =?utf-8?B?SkhEZzFicVRGMDNXNnhOZlJSSUw2YXdpTk40L3pqUGg2NWJkRUNiRG0wRENR?=
 =?utf-8?B?Wmpid3RiZnc2VDd5MEJQSUJKSDAxSWYrbGlVd1lPL0Y3U2pmZzdwVmFHL1pL?=
 =?utf-8?B?NjRhQzgwQU1lY2dqY3NTTXNNd29tdHNBbE1CV3o3TUxDTUk0NW9Vd3FqOWtt?=
 =?utf-8?B?UkJFdzlybTFvWUZNV1E1Zm0wV0xsQ0haeDJjNEEyaVZsMG12ZUhsakZ0cUNU?=
 =?utf-8?B?S0VMeTJ1TnFiZDYxc205cHI0SnRaa3hnTlJpV2VzSllYOGZueDA3TEFaZXdX?=
 =?utf-8?B?bHpoTGRYcUlhSmtwVG1vTGZmTU9aL09TWE5SVzV3TmlJL3pQcWQ1dTFYYnhS?=
 =?utf-8?B?ZWpxRStwRVlXWGxBd291Q0hvQWZzVHZnbi9wNy9TUksxWmc3RG5VU3ZRVGFi?=
 =?utf-8?B?L3V4TE5sT0ZtOWkzWnRocXA0VUI5L2M0aE12V3VOQVJka28rZlg5bzFQMWxz?=
 =?utf-8?B?NjNpQXpwQVVpNFRJc1grQzNoMVFMaWRxT3d3eFlLejdnV0luTnJWRUFPWUor?=
 =?utf-8?B?U3czMjlqeTRlL1lwaG5neHp3VERqMUVQdzdMeFZiSy9GL2d2bFh5Qk9LZjEy?=
 =?utf-8?B?NmhRbHBGdE9lTmJydFM3Uk1nOVh1YlJYcm9WQTdsSWZIeVJLRFhKT3BnYWRS?=
 =?utf-8?B?ZzVZZTFqQ1hrWDJqS2xHbnN1VnpUY1l2ZkxlODdKL0VpeGlFWHAzTzJzR1Vn?=
 =?utf-8?B?RmpmV1JrYStsZ2lDanZkS1E1ZEMwREVudVFlTmdFQnI3UHlWTjlnSG13dE1N?=
 =?utf-8?B?L05yRlU2ckVQcGFCek1CLzY0UWhtZEgxeC95ZVBTQVkwMnp2SGE4aytTRTBQ?=
 =?utf-8?B?TEF0Y3RvbVpPbkh6M1RBOFlYS1BwUERSNll5WlZtc1oyS2RRWVR2YXowR3FI?=
 =?utf-8?B?MGpvQTZvSG9ubUZyVGQ2ZXlvL2VtajJaUDR5NnF0YTdaN2VIRnNrb0FPdURW?=
 =?utf-8?B?REx0dXBIa1poSndMTW81UHB4WkhxanpUa05sTHNWRHVqNXJHYnZpdExxSXM5?=
 =?utf-8?B?Zm1wc081SjdLRkdBWm00TWtBNGJIVkNqQnY2SWhzdmhPOTFsT2x6MnNwQkg3?=
 =?utf-8?B?MFVkZlV1MFBDRW1DQzlQK3RMYXJ6SUZ2WlJ4b2tPS2dqOHdmRmM4dlR4a0g3?=
 =?utf-8?B?Y2k5TFNNZm9vVk9IMzdFeXRsUFBzbHd3OTRzZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnUyZldQc09VS0RWb05NZGE5anJPb2trWUwrUTlsWlhoNVh1YTZ3OHEyM2Z3?=
 =?utf-8?B?UVB6MVVyNDZQRk14N1V1WUhtRFVrRzMvb1kyN2VGaFpMRHBsOEZwcGhndGFs?=
 =?utf-8?B?bW9OOW03NGt2dUgwa3dKVUJMVWNsSHQxWmdOdGl3bmxLYmc4YjUzNDU2VW85?=
 =?utf-8?B?dzFBY2Q1Zk1hZktKUWdLWFdBS3FZZkwvZjhaa0VLL3hVMElYcGZ6SjhlRXZZ?=
 =?utf-8?B?N1FLMEwwODhDajl4V2Z6UnJCMUhmcnptTXA5NE9xcVA0RERpYmFKRWJQWElW?=
 =?utf-8?B?NFhtZ0tlbEorWjEzMExOZm43SDU4MzVjUHExOTVMbHhHTUd6SHVkbFpCdWhO?=
 =?utf-8?B?T0NVUVN0MkF1VERKSHZRcG5GQU5vengxR3UrZm1FT0wrdWszWkhxUmdKNHEv?=
 =?utf-8?B?ZUlRRG93UFU1MU5BaWpPTEdpelpHS1hUOUZTcDdGM0NSdWJ0RFdoZ25YZFlW?=
 =?utf-8?B?NzhaVW1nRkY1ei8xN3JDSkpGUXlaRnU3ZWRFVUVSMWlQdkVjYUVEeXBmVE12?=
 =?utf-8?B?TVEwTXN3RnkxSTQyaDk3V2hTMzJPN3RLSUlyUU1kamk4a05VRytjdTU1VHBw?=
 =?utf-8?B?dDBjdjUvaVBTQ0RaUmNOYTMxaVYva1NFNnFyeXhUcFZBZ1J1Zlp3S09Kb1hs?=
 =?utf-8?B?TG5xNlpMeFVodVR5S0VLMTBQejlRVFllbVFWdjFRbzAvdHJxYk1UaGZaRGti?=
 =?utf-8?B?d0NBalkzbnIrZjRnbmY0YWdoNktDNWpLQTZaS0hpUlBMM1Bsb3kvSlNBYUpy?=
 =?utf-8?B?VUpkVkxuakxQZGJlZGcwM1FHUWg2Q0hNL0hTU0lLbzRCQmh2cWlSSlZnbmJv?=
 =?utf-8?B?WDdpUk0rR0dkR1gvS09DZXBVeG5Ca3hrT29raTBwUEViaTNVaG5JSit0QnhO?=
 =?utf-8?B?cFgwU3QvNWhBNUdpdVdHbDNvRDFESHI4bXpuRVoxcU1TeUJQTGFxZHJPUVo0?=
 =?utf-8?B?amd2QTBlbzdiY0VwOEJhTEpQVjJOOXl4NDRvckh5bGxvUGc3OUIrV2RUd0di?=
 =?utf-8?B?QXRuZm52Zk0zeUIwNnBMcFl6VHBsSFNKb0FJVkRMRlhBNElOaDNTRFcyS0Zi?=
 =?utf-8?B?c1MySEN2Nk9mRStTa2lSek1hVW9rT20ySGx5QzNLOEFaa1pQcTBjOTdPSmVr?=
 =?utf-8?B?cWtKVVlXY3d0bEx4eDhEb1R0M21xMFVQUExnVE9SM0FvQkFuaWVnNVpEclRQ?=
 =?utf-8?B?NDZMb0hxZWtLUFdmTTdmc0JWdk13MnRpWmdrdmF4M3BXYXJxK2NLWmI2UlMx?=
 =?utf-8?B?RzBkWGxjL3RwMDNQUkhjMG43WkgwYkd6MWtJRmxHREFOQm5wMXBzM1NCcFN3?=
 =?utf-8?B?SjQwME5qd0d0eXZ1U3pzYkFIM0RDZkl2L25CaUpzOEg0Z090bS9oR3lMR2h5?=
 =?utf-8?B?aEpDSUhkVi9rUzN2RURtZUZwa3VaaDMyUWRnYUFwUEVwUHVWMktHTlBoREI4?=
 =?utf-8?B?TVZqWjFDVFE5M2M4clVFeVFvb0thZDhWN2k3Qk5lS3hFUm55VHF1bFF5OVcx?=
 =?utf-8?B?a0FNaVZFbm1mM2lRZFZaUm5RZUtaelQ5OXdRVFUzRGk0anBwNjc0bTYvS3RH?=
 =?utf-8?B?dFdoNXpMMVMyVmxnQzNGSm5sOWNYcjByWmt4cGxKbStFclBBcVRSV3RqTXJz?=
 =?utf-8?B?QUdxL3prV09wcmNSZzBHYStUR2FZUEpHaVBJa2tuUXFweDdHR09sTnlOYjRj?=
 =?utf-8?B?b2t4Vk1aNk1Wd2tBWDd4OVFTUXJUN3ZVdk9BUThBTWljckJkQ1dKSHpTdE5B?=
 =?utf-8?B?a0hLY1Foa0Vad3NnbUFKL2FhdVloMWhlWkR5ZjFTOVgxOTZXUDlUQlBpN1pz?=
 =?utf-8?B?dWZlOUhQMThSeXZHL1ZJbTluNXBTV29HUjZLZVNBK3ZzcVVvZVlBK1NuTDRQ?=
 =?utf-8?B?WE5NN2hkKzVEZHhCRG1MME0wSlFXaHBKV1prYXFMa0I3R2I5TGxJSzdMWlBa?=
 =?utf-8?B?RmNpRlBVRWZoNEZoSXdFVjJ5c1VaTjBpS0dhMk9lSDVIcUN5ZFg1a0cyWmJM?=
 =?utf-8?B?VW9BZmMwR0VXOG5US05rQXBXSmwyQjhWczVmOUtwbUJ4TXNjYmZ5SzZvajV6?=
 =?utf-8?B?VFJGQjFuclQxRjBQaDV0aG1pc0UxVHdKYzBoNlF4dU1GUnl6WkFMTEtoeGFq?=
 =?utf-8?Q?7P6mZlAUj6xvaUX3R0VEjgqh5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e590f23-37cc-4fd0-8a15-08de28175262
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 09:29:36.4208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAUyvboKBotQrWYZLGpsK8nWpyaN+CVSGkAJuqd6RYS8K40l/peirHfPFyhM1+15jxDrSgIeihvQH5f1L24tq3JDgiGjm+ADZCE6db99nAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFEC89C124F
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgQWxsLA0KDQpLaW5kbHkgcGluZ/CfmIosIGFueSBtb3JlIGNvbW1lbnRzPw0KDQpUaGFua3MN
ClpoZW56aG9uZw0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBEdWFuLCBa
aGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjUg
MC85XSB2ZmlvOiByZWxheCB0aGUgdklPTU1VIGNoZWNrDQo+DQo+SGksDQo+DQo+VGhpcyBzZXJp
ZXMgcmVsYXggdGhlIHZJT01NVSBjaGVjayBhbmQgYWxsb3dzIGxpdmUgbWlncmF0aW9uIHdpdGgg
dklPTU1VDQo+d2l0aG91dCBWRnMgdXNpbmcgZGV2aWNlIGRpcnR5IHRyYWNraW5nLiBJdCdzIHJl
d3JpdHRlbiBiYXNlZCBvbiBmaXJzdCA0DQo+cGF0Y2hlcyBvZiBbMV0gZnJvbSBKb2FvLg0KPg0K
PkN1cnJlbnRseSB3aGF0IGJsb2NrIHVzIGlzIHRoZSBsYWNrIG9mIGRpcnR5IGJpdG1hcCBxdWVy
eSB3aXRoIGlvbW11ZmQNCj5iZWZvcmUgdW5tYXAuIEJ5IGFkZGluZyB0aGF0IHF1ZXJ5IGFuZCBo
YW5kbGUgc29tZSBjb3JuZXIgY2FzZSB3ZSBjYW4NCj5yZWxheCB0aGUgY2hlY2suDQo+DQo+QmFz
ZWQgb24gdmZpby1uZXh0IGJyYW5jaDoNCj4NCj5wYXRjaDEtMjogYWRkIGRpcnR5IGJpdG1hcCBx
dWVyeSB3aXRoIGlvbW11ZmQNCj5wYXRjaDM6ICAgYSByYW5hbWluZyBjbGVhbnVwDQo+cGF0Y2g0
LTU6IHVubWFwX2JpdG1hcCBvcHRpbWl6YXRpb24NCj5wYXRjaDYtNzogZml4ZXMgdG8gYXZvaWQg
bG9zaW5nIGRpcnR5IHBhZ2VzDQo+cGF0Y2g4OiAgIGFkZCBhIGJsb2NrZXIgaWYgVk0gbWVtb3J5
IGlzIHJlYWxseSBxdWl0ZSBsYXJnZSBmb3IgdW5tYXBfYml0bWFwDQo+cGF0Y2g5OiAgIHJlbGF4
IHZJT01NVSBjaGVjaw0KPg0KPg0KPldlIHVzZWQgWzJdIHRvIHRlc3QsIGl0IGNvbnRhaW5zIGRv
bV9zd2l0Y2ggc2VyaWVzICsgdGhpcyBzZXJpZXMgKw0KPm5lc3Rpbmcgc2VyaWVzLiBJIGluY2x1
ZGVkIG5lc3Rpbmcgc2VyaWVzIGp1c3QgYmVjYXVzZSBJJ2QgbGlrZSB0byBjb25maXJtDQo+dGhl
IHR3byBwYXRjaGVzIG9wdGltaXppbmcgb3V0IGRpcnR5IHRyYWNraW5nIGZvciByZWFkb25seSBw
YWdlcyB3b3JrLg0KPg0KPldlIHRlc3RlZCBWTSBsaXZlIG1pZ3JhdGlvbiAocnVubmluZyBRQVQg
d29ya2xvYWQgaW4gVk0pIHdpdGggUUFUIGRldmljZQ0KPnBhc3N0aHJvdWdoLCBiZWxvdyBtYXRy
aXggY29uZmlncyB3aXRoIGd1ZXN0IGNvbmZpZyAnaW9tbXU9cHQnIGFuZA0KPidpb21tdT1ub3B0
JzoNCj4xLlNjYWxhYmxlIG1vZGUgdklPTU1VICsgSU9NTVVGRCBjZGV2IG1vZGUNCj4yLlNjYWxh
YmxlIG1vZGUgdklPTU1VICsgbGVnYWN5IFZGSU8gbW9kZQ0KPjMubGVnYWN5IG1vZGUgdklPTU1V
ICsgSU9NTVVGRCBjZGV2IG1vZGUNCj40LmxlZ2FjeSBtb2RlIHZJT01NVSArIGxlZ2FjeSBWRklP
IG1vZGUNCj4NCj5UaGUgUUFUIHdvcmtsb2FkIGlzIGEgdXNlciBsZXZlbCBhcHAgdGhhdCB1dGls
aXplcyBWRklPIHRvIGNvbnRyb2wgUUFUIGRldmljZS4NCj4NCj5UaGFua3MNCj5aaGVuemhvbmcN
Cj4NCj5bMV0gaHR0cHM6Ly9naXRodWIuY29tL2pwZW1hcnRpbnMvcWVtdS9jb21taXRzL3ZmaW8t
bWlncmF0aW9uLXZpb21tdS8NCj5bMl0NCj5odHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3Fl
bXUvdHJlZS9saXV5aS96aGVuemhvbmcvaW9tbXVmZF9uZXN0aW5nLnYNCj44LkRTX0xNLndpcA0K
Pg0KPkNoYW5nZWxvZzoNCj52NToNCj4tIGRyb3AgdGhlIHBhdGNoIGNoZWNraW5nIGlvbW11X2Rp
cnR5X3RyYWNraW5nIChBdmloYWksIEpvYW8pDQo+LSBwYXNzIGlvdGxiIGluZm8gdG8gdW5tYXBf
Yml0bWFwIHdoZW4gc3dpdGNoIG91dCBvZiBzeXN0ZW0gQVMNCj4NCj52NDoNCj4tIGJ5cGFzcyBt
ZW1vcnkgc2l6ZSBjaGVjayBmb3IgZGV2aWNlIGRpcnR5IHRyYWNraW5nIGFzIGl0J3MgdW5yZWxh
dGVkIChBdmloYWkpDQo+LSBzcGxpdCB2ZmlvX2RldmljZV9kaXJ0eV9wYWdlc19kaXNhYmxlZCgp
IGhlbHBlciBvdXQgYXMgYSBzZXBhcmF0ZSBwYXRjaA0KPi0gYWRkIGEgcGF0Y2ggdG8gZml4IG1p
bm9yIGVycm9yIG9uIGNoZWNraW5nIHZiYXNlZGV2LT5pb21tdV9kaXJ0eV90cmFja2luZw0KPg0K
PnYzOg0KPi0gcmV0dXJuIGJpdG1hcCBxdWVyeSBmYWlsdXJlIHRvIGZhaWwgbWlncmF0aW9uIChB
dmloYWkpDQo+LSByZWZpbmUgcGF0Y2g3LCBzZXQgSU9NTVVGRCBiYWNrZW5kICdkaXJ0eV9wZ3Np
emVzJyBhbmQNCj4nbWF4X2RpcnR5X2JpdG1hcF9zaXplJyAoQ2VkcmljKQ0KPi0gcmVmaW5lIHBh
dGNoNywgY2FsY3VsYXRlIG1lbW9yeSBsaW1pdCBpbnN0ZWFkIG9mIGhhcmRjb2RlIDhUQiAoTGl1
eWkpDQo+LSByZWZpbmUgY29tbWl0IGxvZyAoQ2VkcmljLCBMaXV5aSkNCj4NCj52MjoNCj4tIGFk
ZCBiYWNrZW5kX2ZsYWcgcGFyYW1ldGVyIHRvIHBhc3MgRElSVFlfQklUTUFQX05PX0NMRUFSIChK
b2FvLA0KPkNlZHJpYykNCj4tIGFkZCBhIGNsZWFudXAgcGF0Y2ggdG8gcmVuYW1lIHZmaW9fZG1h
X3VubWFwX2JpdG1hcCAoQ2VkcmljKQ0KPi0gYWRkIGJsb2NrZXIgaWYgdW5tYXBfYml0bWFwIGxp
bWl0IGNoZWNrIGZhaWwgKExpdXlpKQ0KPg0KPg0KPg0KPkpvYW8gTWFydGlucyAoMSk6DQo+ICB2
ZmlvOiBBZGQgYSBiYWNrZW5kX2ZsYWcgcGFyYW1ldGVyIHRvDQo+ICAgIHZmaW9fY29udGlhbmVy
X3F1ZXJ5X2RpcnR5X2JpdG1hcCgpDQo+DQo+Wmhlbnpob25nIER1YW4gKDgpOg0KPiAgdmZpby9p
b21tdWZkOiBBZGQgZnJhbWV3b3JrIGNvZGUgdG8gc3VwcG9ydCBnZXR0aW5nIGRpcnR5IGJpdG1h
cA0KPiAgICBiZWZvcmUgdW5tYXANCj4gIHZmaW8vaW9tbXVmZDogUXVlcnkgZGlydHkgYml0bWFw
IGJlZm9yZSBETUEgdW5tYXANCj4gIHZmaW8vY29udGFpbmVyLWxlZ2FjeTogcmVuYW1lIHZmaW9f
ZG1hX3VubWFwX2JpdG1hcCgpIHRvDQo+ICAgIHZmaW9fbGVnYWN5X2RtYV91bm1hcF9nZXRfZGly
dHlfYml0bWFwKCkNCj4gIHZmaW8vaW9tbXVmZDogQWRkIElPTU1VX0hXUFRfR0VUX0RJUlRZX0JJ
VE1BUF9OT19DTEVBUiBmbGFnDQo+c3VwcG9ydA0KPiAgaW50ZWxfaW9tbXU6IEZpeCB1bm1hcF9i
aXRtYXAgZmFpbHVyZSB3aXRoIGxlZ2FjeSBWRklPIGJhY2tlbmQNCj4gIHZmaW8vbGlzdGVuZXI6
IENvbnN0cnVjdCBpb3RsYiBlbnRyeSB3aGVuIHVubWFwIG1lbW9yeSBhZGRyZXNzIHNwYWNlDQo+
ICB2ZmlvL21pZ3JhdGlvbjogQWRkIG1pZ3JhdGlvbiBibG9ja2VyIGlmIFZNIG1lbW9yeSBpcyB0
b28gbGFyZ2UgdG8NCj4gICAgY2F1c2UgdW5tYXBfYml0bWFwIGZhaWx1cmUNCj4gIHZmaW8vbWln
cmF0aW9uOiBBbGxvdyBsaXZlIG1pZ3JhdGlvbiB3aXRoIHZJT01NVSB3aXRob3V0IFZGcyB1c2lu
Zw0KPiAgICBkZXZpY2UgZGlydHkgdHJhY2tpbmcNCj4NCj4gaW5jbHVkZS9ody92ZmlvL3ZmaW8t
Y29udGFpbmVyLmggfCAgOCArKystLQ0KPiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2UuaCAg
ICB8IDEwICsrKysrKw0KPiBpbmNsdWRlL3N5c3RlbS9pb21tdWZkLmggICAgICAgICB8ICAyICst
DQo+IGJhY2tlbmRzL2lvbW11ZmQuYyAgICAgICAgICAgICAgIHwgIDUgKy0tDQo+IGh3L2kzODYv
aW50ZWxfaW9tbXUuYyAgICAgICAgICAgIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiBody92ZmlvLXVzZXIvY29udGFpbmVyLmMgICAgICAgICB8ICA1ICstLQ0KPiBody92ZmlvL2Nv
bnRhaW5lci1sZWdhY3kuYyAgICAgICB8IDE1ICsrKysrLS0tLQ0KPiBody92ZmlvL2NvbnRhaW5l
ci5jICAgICAgICAgICAgICB8IDIwICsrKysrKy0tLS0tLQ0KPiBody92ZmlvL2RldmljZS5jICAg
ICAgICAgICAgICAgICB8ICA2ICsrKysNCj4gaHcvdmZpby9pb21tdWZkLmMgICAgICAgICAgICAg
ICAgfCA1Mw0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+IGh3L3ZmaW8vbGlz
dGVuZXIuYyAgICAgICAgICAgICAgIHwgMjEgKysrKysrKysrKy0tLQ0KPiBody92ZmlvL21pZ3Jh
dGlvbi5jICAgICAgICAgICAgICB8IDQwICsrKysrKysrKysrKysrKysrKysrKystLQ0KPiBiYWNr
ZW5kcy90cmFjZS1ldmVudHMgICAgICAgICAgICB8ICAyICstDQo+IGh3L3ZmaW8vdHJhY2UtZXZl
bnRzICAgICAgICAgICAgIHwgIDIgKy0NCj4gMTQgZmlsZXMgY2hhbmdlZCwgMTk0IGluc2VydGlv
bnMoKyksIDM3IGRlbGV0aW9ucygtKQ0KPg0KPi0tDQo+Mi40Ny4xDQoNCg==

