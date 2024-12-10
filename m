Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2E0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4K3-0003WR-8B; Tue, 10 Dec 2024 12:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick.p.edgecombe@intel.com>)
 id 1tL4Jy-0003WG-CE
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:46:54 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick.p.edgecombe@intel.com>)
 id 1tL4Ju-0007Es-RR
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733852811; x=1765388811;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=T0bbjNocPKCEXA5woMbaieg1Tn2aiqzLl5i67MWdJNI=;
 b=WEuC14PxyP17Vu3ZAzw9CjebAgvfhHZlyvSoIy/AYr1pSMs27Ht5NA0M
 4IA28dDKRUz05HZS+dq8wiVo8iaPeC+TIocFES6ZjIKz9XXEP29cSmTSN
 siAB8cLd6LWkdaTdp+HchCpl28Qy5V0oKHIkgJ+YeJ1FAZRctIGymxgBz
 p6dfluKig+p7b/ileQV416MtJx1YmXmPVEyZ7Jt/Mi2B/EbmEW1hiWFpm
 9w9wXuHXnMI6nCuOX5u20XQMbjJNcQ0uitM8pwKvlrekd8wfjkU8ep2pT
 9kTEFsC5mDzUOrZI+3WC0RGdmI0j6mehAEUgzMKEub5Y92e/mNkaLbJpd Q==;
X-CSE-ConnectionGUID: 2+ENt4jzT1aN3m6cYmHUgA==
X-CSE-MsgGUID: rS3d3XLDQe+Hzuiogg098A==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34130247"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; d="scan'208";a="34130247"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 09:46:46 -0800
X-CSE-ConnectionGUID: QnE48Gp8TyqcId8PDTqQUA==
X-CSE-MsgGUID: kwhyBFUERfq1wraZY3ip1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; d="scan'208";a="95821459"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2024 09:46:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 09:46:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 09:46:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 09:46:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVkoTx2raxspPRCARpney7S+a4Pyj7Vr3w+n+I2a4ZDConSn8lb6sl+y0vRV12m7E6ifBbac24EMhiLJUcAJnSHwBR1I44I5GvNURAS7wdVZyLzXlBxv8IiVYQcYLqNdOTQvL0QhTSNtQZ2dXvIRwVywZQ7mJzKOL4YyyA+16y7aYiG5T8JUaNnPlgLEf0xfDgEWB0ypRh5jP1Uv0AhHBdUs90VKWd0IoTkJKyLcKlQUo8Yi9LTqQmqOeJRvM8sDnbqacbUFJRx2GX2O4cucTAilPi1FJtDFnMJnJ8fN/XBe6BUfQkdEEChPtCq5viZM1LDoWTR4Eo5N5CDIkfm4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0bbjNocPKCEXA5woMbaieg1Tn2aiqzLl5i67MWdJNI=;
 b=OSQ68zxjlAMjfQ9zYp11nEiMcYdub6lqBX1qzeOv0q1WGh3tEGBs1sEjng8vu3pa5TrBi7XdM57bW0Mp/EQXYjprOMBCp8t4Jmv0qrWOa4v924nOnpcnqIA7ltz4Y38VFzld/FTZ5cZ0Ycnc5l6iZjnHNlJGBHdSYzPMP7WGDKvGld4sVkYBJk0OgcBdTDRdrkt9qsNabW/zh9n+FWTEwxzIqz2oji/rzkWZUYBU0+nKIZF/JoLiuK4T2Bl0f7xvyS0an+ebFhfCOHOMZjQNxoo/jnraQ5SeumvD20XLaBNERMUg/Fk2OOumTe1S2oavwbrgl0ANEMeiDHv9Yfm64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 17:45:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 17:45:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "Huang, Kai" <kai.huang@intel.com>, "binbin.wu@linux.intel.com"
 <binbin.wu@linux.intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>, "tony.lindgren@linux.intel.com"
 <tony.lindgren@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "Hunter, Adrian" <adrian.hunter@intel.com>, "Yamahata, Isaku"
 <isaku.yamahata@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: (Proposal) New TDX Global Metadata To Report FIXED0 and FIXED1
 CPUID Bits
Thread-Topic: (Proposal) New TDX Global Metadata To Report FIXED0 and FIXED1
 CPUID Bits
Thread-Index: AQHbR4iHazsMJxPtGkeCIJI86qO187LZjbkAgAVIvYCAAPE0gA==
Date: Tue, 10 Dec 2024 17:45:58 +0000
Message-ID: <269199260a42ff716f588fbac9c5c2c2038339c4.camel@intel.com>
References: <43b26df1-4c27-41ff-a482-e258f872cc31@intel.com>
 <d63e1f3f0ad8ead9d221cff5b1746dc7a7fa065c.camel@intel.com>
 <e7ca010e-fe97-46d0-aaae-316eef0cc2fd@intel.com>
In-Reply-To: <e7ca010e-fe97-46d0-aaae-316eef0cc2fd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6244:EE_
x-ms-office365-filtering-correlation-id: 26244153-e06a-4da6-ea5c-08dd19428156
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|3613699012; 
x-microsoft-antispam-message-info: =?utf-8?B?eHpuNUplN3BWRDh3RFV3MUFlMVkzUGdCcUF3SFVQdGZKVmtRZFdOb0FMVGV0?=
 =?utf-8?B?M0Ywcnl4ZndtY3hSRVE0ZUhLRkFnRjNlRGhjQ2I4R2Z2MmN1NHNqMnFCenB2?=
 =?utf-8?B?MjRaNGNDQ004cjhnSkNCS253Tm9GOUJSL1N1ekt5WG5ZOEdxL05JWmdCVXhN?=
 =?utf-8?B?VmJ5SklkdXo0bDB6cVZVUUFSOVpzNWIxWU51NnRyVTd2RU53cDZsS3VzaHgr?=
 =?utf-8?B?YlNoclpsTXJ5RlV1dFBybVQ4R2xWaTMwbHJmb1Jrc0d2ZjNUT1RrbmhwZnFE?=
 =?utf-8?B?Tm1DeDRES2NzaXZ5R1AwNmN5b1NnWkZKcjRZc1NNbmxMT2lwZVJ1cS9Wd1Jl?=
 =?utf-8?B?OTAxaVAwUG42RXRPdWtRQUVsUVM2UWNDRUZqYnpXNDFuL0NYSGphK2FMTjBw?=
 =?utf-8?B?UWFuMmNDUDBheUJDY0NVNGt4VlFPVWhBT2llN2MrV3lCRVF1SzJvVitQWjdB?=
 =?utf-8?B?RE5FbkNuY0dCeWIwSXdsSnJiT3VTc0p3OVVJYkRYSUx4QU50U0FpU1FsTzJ3?=
 =?utf-8?B?N0h2Z1RIQ2xGcTJ4T1ZsMXNNVklDQUcvejMvS0RyejZGRFNQNkkxKzMydkE3?=
 =?utf-8?B?R1ZaNVBrZ0ROdjdTa1Vrb0VnYlNURXVHSGd0VFJkNEYxZzVOaDE2UHhDWHlu?=
 =?utf-8?B?U3BvSE1FMXNFenhoMFp3bGJNdERDSEdDbjBVbmRSMnhVdzk5L2pTRHhBd3pJ?=
 =?utf-8?B?NVg2S09QUUlnaDZZV0dSa1FEOFZlNHVaWnMvaExYNTVLbGFqK2lnL3lIak1w?=
 =?utf-8?B?WTR2NlVHcmRTdnN3UUVWK3JjcWFxbU80THFhVGZCN2xHNDZkK3lQRTh6VGtk?=
 =?utf-8?B?RyszS2xjZlB0dXZaamE5NmllWEdxNmdRVyt5S0RmRGZpak13dVVyZkZJN1NI?=
 =?utf-8?B?Smg3QVVteUlaVjZ5b21temhBZlJGSWxmeXpkWUtoVytnSTlveFNLRnFEOWxN?=
 =?utf-8?B?SWliTWhqSGJ1cnMwUGs4Snl4NkR3bWxCNmd3cVZmNXVVT3VWM3VkQzE3UTd6?=
 =?utf-8?B?b3ZKM2lKMmx0Lzg3alcrNjZGSk9Hb25QK0MzSTlIMHpaM3ozSGM2WkVzWUpN?=
 =?utf-8?B?d0I5aU54bXM2RjFaM0RjRjVrTUx4UlBpWk1kME9Eak9SanNoR0JXK0JodGJN?=
 =?utf-8?B?LzVoQUdoK0VXU2wrR25PbUxUeUdhYWdWaUFoSkREWUVucVgzSTFwdERFYkEr?=
 =?utf-8?B?UlN0YjVsRzV6V0VFSGlreTlmaDBIWldsaE5ITGErVDY0dDVSU2xITVBjSVM1?=
 =?utf-8?B?bnd2cmM1RExPdkgrTmpoKzlObVk2YkJKbFZVdmN0ZEFQVzNVSWoyd3lHL0Jw?=
 =?utf-8?B?TjZBR0VGVE41dEZ0S0RzOTFTa2pEUWIzS1cvUHcvbndOK0dnTDV6b0lJYWtC?=
 =?utf-8?B?ODU1YnpVa3JTcVNOdXpIcW9lNEIxUUNxS3JZTTRzR0t2M3hFdnlCU1E5TUs5?=
 =?utf-8?B?OVI5cnNSYUhVTVZ0d01ROG5YeXh4bmJ5SzJadm1td1JsVFpya095RXRxb3Qx?=
 =?utf-8?B?c1g0YXpMMnZYSzV0dHp5YVBpVG9BTE1mbjIzN2V5L0FxSU9iTEdyMDNiWmE1?=
 =?utf-8?B?OGlFa09KZ1A2QSt4RDZ3V3MyRVhlYXNwTVAvZHdkK1l3SnNOd2R3b2xxWjgv?=
 =?utf-8?B?RjArMWtNUWNWYkRyU3N4MkY1azkxUlZsK2p3cThxc3QreFJPNVdwL2RXMS91?=
 =?utf-8?B?Qmh6WmFFdUFhTmUwZnJPRW5lSTRQV0FCanZyZmpZSFkwbEcySVhMUFdmQktU?=
 =?utf-8?B?UXZpdG1wY2s2ODNoellPM2JoNXI0cXZBUGF0S0dlMWdQQnhYRGljcmM2NHJF?=
 =?utf-8?B?aHlSbCswdUJONmN5WUFVYjE1b0JHNmRyeTBwL1hSNnJITmp1bUZpRUVIbnZu?=
 =?utf-8?B?T1JZSmx3MFJWYk9JWldzdGdvQXQ0Y0Z4MlFBcGdGOVREdi9pNmZ4bCtjeU9y?=
 =?utf-8?Q?243BTAihvu62xQ9DSvR0GLqT3EY3lsBw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB5963.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(3613699012); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2RjamRrSTVjaG5nWitWd2xZMDhDRkdCcjRpWGdmdUsvL0tmYWpjYkp1eXdS?=
 =?utf-8?B?MXpySmlQWjJjdmI4ZVRNcHhPd3lWdDlIV3YwWUdzOUFUSlBBOUhBU1FuZExn?=
 =?utf-8?B?eVhUdzRkaUVTOFVDZWlSMkU5b05qYzlMRVZBak01cTNxdk9ueDFqNXlac21w?=
 =?utf-8?B?RHlveFN4TmI2eEJPKzVQMFNUaGdPcXRCVFp2ZldkdytITC9uajFSTXJmQnF2?=
 =?utf-8?B?ZlBrYm1nM21JWDFVSUhKajdrV2N2aExXeHRNQ1FMVUpaU2l6Q1gxMTk4SGJo?=
 =?utf-8?B?ZFBmNW9tZko1LzVLRm1LRWN3dkNMZ1BtcjFzSGtZeHQxSUFkZi9wZk1NcnNT?=
 =?utf-8?B?dGU4SE5wTXUxcE1qL2JlaE9TV05ZOVl5Z3ZBTHlRZGZ5NGpmc0VVcnk1WjR0?=
 =?utf-8?B?S1llMFlHUTh3M1RGdnlQTW9FZnlScll2dVNIVkkwb28xMVh0M1NSdkhEL2Nx?=
 =?utf-8?B?NWI4d0d3c3lyRTgrYklhSmdsZ01NK3k2S2s2bTE5OUZ5TFZlcXdUQTFVZkk2?=
 =?utf-8?B?aHl4NGU0NFF2Si9FNHFlVDI2VXhQWlhnWVZlSHRIbU42UDFWOXVLcHpOSUMz?=
 =?utf-8?B?QXB5OEFHQ2dFeVJ2bDZFZENJblFRS0F5Z2JwcVhmK0JnRGl6aDJ2K1R0TE5o?=
 =?utf-8?B?TFVVcWdjNUs0czJxS3V1bWpVQUUvWkwzT0xmNDRaQkh0SVZSWVJ0dWV6TnNh?=
 =?utf-8?B?ZThNT0Q0Q2JwcVhWVldEYTltS0FNYTJ0QnlwaDdTdHNpV1I1Z0R4R0l5dm1p?=
 =?utf-8?B?Wjc5WXd1RnRDRmtaczduWjJRaWE3RXU1M1k4RGJIeWl1dDJqVjgrY3g4Z0xC?=
 =?utf-8?B?cUM4RnJvZCtYMVdWWHpEcmZhcGZ4dTVTdzNsMWhGcnd2dW1LZHNQOG5objVR?=
 =?utf-8?B?aEVCNXZqNjFxM3QvUHlwL3Q1WCtCT3dIZjFVVEpsRDRXYU84TFVCUGNVT3Rt?=
 =?utf-8?B?TDNqdlhlWnJzNXl4clF0VU8zZFp3MFd6WVNYc0NhNHo3d3F6NlNpSENUYnNx?=
 =?utf-8?B?Zis3STRlNWR4STE2TEV5dTZYTWZzbTJEdUszVGhQOVF3NnBKOHI0cmt0bkRI?=
 =?utf-8?B?ckQ5QjZpSXNCU3JQU1RNSndzL2RIVjVYZm1mTytPUnlIaDcwSUxHSDRxUjBi?=
 =?utf-8?B?WllKZXl6ZTVkMVhORkZNemEzVERUVDJ1UzA1V2tOSmFFWXBVbThPb2hzL0p2?=
 =?utf-8?B?OVNjdndHSmlja1FFc2RXY21ERzRLVTBMMlJ4STIwclRnRUFOQWt4eHpVWlNF?=
 =?utf-8?B?WVd4WmlLeXJrdGFqQWxjaEpaSXZ3T2VKQnNrREkyYmRxeXRvY1c4TWRJcGlY?=
 =?utf-8?B?MkFFVy9VRCtkVXFqTVNWOUtEYWdGRlM4SWV3b2FwTFFQSGJSMEsyYXRWUklt?=
 =?utf-8?B?OTRvZGptZk5LR0Zibkd4cWlzTmFvSFpWbzh0Vi92L2VUakhEbXZNZWFLTER3?=
 =?utf-8?B?Y20wbHpoeXRmTE4xbmwvMm1XSklMd3FFekMvcWp3WkRUN2NSS0wvOXlydTd1?=
 =?utf-8?B?ejRoZ1pobkM5L2IzWko1SzlKZ3o0U2ppRmlyQ1NxSEJ3RkR6bkdUaVFGYktY?=
 =?utf-8?B?aHlwemFuU0l0UlEvQjVYckRaNjByTFBRdVRUZkE1am8zZUZncDgrSmdUclJU?=
 =?utf-8?B?SUJ0cG9RNjJUTjlHWEIwbTVmYlI4cVpUUEFtSndZcW43ckVnc1hjMTVLeDlI?=
 =?utf-8?B?RllXak93dG9BSjNoVFNuOUswaUthOHFxNGZySW5laUhSTmVoOUVMeEw0dG1F?=
 =?utf-8?B?Q3NLUFpsSUdWN05hOHBQbGtsOWR5SG1lUmh4S3o0MUsyck9ZMklrTFdaMVQ4?=
 =?utf-8?B?VWFDb0NtS09vVy9WYURvVWhmMXNMSTE1eUhPVkpBRUtmcEwzaWVuNW9uSUI5?=
 =?utf-8?B?b1BvWHJ4aW5UOVJORXNBK2EzajRPWmh3NXNJR3g4T011V0QxaWFSb3dPM2hx?=
 =?utf-8?B?bDV5T04zWTFDUVIzRmZUMlRJdmxiNXFDemk5MHRKbks2NURzTUIzOUNHR2la?=
 =?utf-8?B?ZStQWkxnY3E3cWxNb3Bqa01XSnlhdWhpS2ZSQWw4K3ZWMTltTWF6K1V5VEJK?=
 =?utf-8?B?ZDRRZUQwbGFzbTZoeEF6YlNqTU1heldDQmkxRHFHdmluRXlqR0JBNmhJRHJJ?=
 =?utf-8?B?QkZxaTJaOTBqT0dLVkxYRVFYeExWQ21MTVpWT21TbTc5RlRCL0lyelpXL1Q2?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DBAA31D3DD7B14285F96A92579B3DC7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26244153-e06a-4da6-ea5c-08dd19428156
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 17:45:58.4381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2wHlY9hBCqLa8zqb2HksSk1GwgUDraBfRgI5Jm/VHN3Rc1eb2jTvI0qtmMoiL5XeERPYVsDOAeM4Zx50eTgU8GP3VFRCQv7osX1K6jqopY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=rick.p.edgecombe@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

T24gVHVlLCAyMDI0LTEyLTEwIGF0IDExOjIyICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
IFRoZSBzb2x1dGlvbiBpbiB0aGlzIHByb3Bvc2FsIGRlY3JlYXNlcyB0aGUgd29yayB0aGUgVk1N
IGhhcyB0byBkbywgYnV0IGluDQo+ID4gdGhlDQo+ID4gbG9uZyB0ZXJtIHdvbid0IHJlbW92ZSBo
YW5kIGNvZGluZyBjb21wbGV0ZWx5LiBBcyBsb25nIGFzIHdlIGFyZSBkZXNpZ25pbmcNCj4gPiBz
b21ldGhpbmcsIHdoYXQga2luZCBvZiBiYXIgc2hvdWxkIHdlIHRhcmdldD8NCj4gDQo+IEZvciB0
aGlzIHNwZWNpZmljICNWRSByZWR1Y3Rpb24gY2FzZSwgSSB0aGluayB1c2Vyc3BhY2UgZG9lc24n
dCBuZWVkIHRvIA0KPiBkbyBhbnkgaGFuZCBjb2RpbmcuIFVzZXJzcGFjZSBqdXN0IHRyZWF0cyB0
aGUgYml0cyByZWxhdGVkIHRvICNWRSANCj4gcmVkdWN0aW9uIGFzIGNvbmZpZ3VyYWJsZSBhcyBy
ZXBvcnRlZCBieSBURFggbW9kdWxlL0tWTS4gQW5kIHVzZXJzcGFjZSANCj4gZG9lc24ndCBjYXJl
IGlmIHRoZSB2YWx1ZSBzZWVuIGJ5IFREIGd1ZXN0IGlzIG1hdGNoZWQgd2l0aCB3aGF0IGdldHMg
DQo+IGNvbmZpZ3VyZWQgYnkgaXQgYmVjYXVzZSB0aGV5IGFyZSBvdXQgb2YgY29udHJvbCBvZiB1
c2Vyc3BhY2UuDQoNCkJlc2lkZXMgYSBzcGVjaWZpYyBwcm9ibGVtLCBoZXJlIHJlZHVjZWQgI1ZF
IGlzIGFsc28gYW4gZXhhbXBsZSBvZiBpbmNyZWFzaW5nDQpjb21wbGV4aXR5IGZvciBURCBDUFVJ
RC4gSWYgd2UgaGF2ZSBtb3JlIHRoaW5ncyBsaWtlIGl0LCBpdCBjb3VsZCBtYWtlIHRoaXMNCmlu
dGVyZmFjZSB0b28gcmlnaWQuIEJ1dCBhbm90aGVyIHdheSB0byBhZGRyZXNzIGl0IHdvdWxkIGJl
IHRvIGdldCB0aGlzDQppbnRlcmZhY2UgKmFuZCogdW5kZXJzdGFuZGluZyBvZiAibm8gbW9yZSBD
UFVJRCBjb25maWcgY29tcGxleGl0eSIuIEFuZCB0aGF0IG1heQ0KYmUgYSBnb29kIGlkZWEgYW55
d2F5Lg0K

