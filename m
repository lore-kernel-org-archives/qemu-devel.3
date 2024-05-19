Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FCFC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2024 05:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Ymg-0002Xp-Ck; Sun, 19 May 2024 01:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1s8Ymb-0002Vr-0z
 for qemu-devel@nongnu.org; Sun, 19 May 2024 01:08:29 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1s8YmL-0001DO-Dn
 for qemu-devel@nongnu.org; Sun, 19 May 2024 01:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716095294; x=1747631294;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uQQjFxzFSe1RiWo4c1HF2xhb1LP0iJwa4SQ6xmuQBfE=;
 b=UT9y/R9/C9GiVPyQVYxdNgHEwD3g5Wnyc0TaVC/Wszhd/aA4E/8sD4/3
 Yu9YmNpdaeLdHwEsj4CjeQp8dfg2j5H9D30R1GKW/oA3UEQL9IxP5bbHQ
 Wasae2dxY24M2xMp7KGYamg6umZpJPWoqaJjceP5pEBZqDQoREYSAf6aw
 ACO5n0RjEBk5qiP7Tw/7o05UEdpkIO3btYyfpDHrW+G40EeeYJGPnJB+c
 euH5Vs7DjatwxS73oSu/fgBzwKXkV67ip+cti87EXt9njscaTmcVWeEmz
 ZPjMRXzu2UJGQE7q9ilI2SND88SxciWjIWi0l+uVhofirrb04LsaZRsfr w==;
X-CSE-ConnectionGUID: KLd5JVCIRp6sCmrCjQ3nHA==
X-CSE-MsgGUID: RBZZiTwRSxu4ntBsruUI0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="12183066"
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; d="scan'208";a="12183066"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2024 22:08:08 -0700
X-CSE-ConnectionGUID: o7vRqmJbSt2VWfAQaOQG/A==
X-CSE-MsgGUID: vcLFk7/ZRGKwJZVyCKCEgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; d="scan'208";a="32111178"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 May 2024 22:08:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 18 May 2024 22:08:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 18 May 2024 22:08:06 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 18 May 2024 22:08:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy/u8eL5BT1AecKQUjD3C2CqPhHK7XEjKEQ0LXckDVoB8kp5fYiCP7BsPSdNNxTNnIOoQ10so0Pr7anHM+rgL8HaYsMG0RGUI9Ecf9axw6fkOdS3SOjiDypAQYT74vVCP0jGTuS9sBV2T6CAVfFHv0zYyl01hh5+K8OU8Eba8CT2DBG4EqtvNOhveHKZ4T9n3F9SF2QNWkErqISUGZoDrHmaM+U5zrLm2cuSTOkaN8OaTXH5nrOrg29pt00HODgQBSgmZ1GLPC6Bo4ZpdRrCA3+QOtwKFFrAwWSnGpmgqMopjF+BUm2umUzfV65syepEI2GP7MAdhQyHeW1Z3TaXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQQjFxzFSe1RiWo4c1HF2xhb1LP0iJwa4SQ6xmuQBfE=;
 b=X/K0DIRb0t8ZdevhMOKAe9wA5rGJcIzSpmvxBZSTfI/0O0bVf7vvccg3h3t7EjoFyOgMS/+U4Pt9+hnsiWjM3r1kJHWRKzgCoAIpwhhqa0Z4VGI7keNedTdhvYQwbVYIVxp/DsIp5nVD93yZHkdIws5tWZ5biwU/dZI751lVaz9aZuOrLQVjiZFPRMlzENcNUqmdETi8vctYiEJgS7Nd/K+wRPdmzo139bu53+5ECTpvmK/aEnWym4ychKkrP3iIpH8Goj1bNGr6s78lYG2FGYL6lf2WLUcmrlL9alViWTGcsYZDMTxcLefqS4ge+32eVtxBqwhHGMfk0Mh1FkNxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7978.namprd11.prod.outlook.com (2603:10b6:806:2fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 05:08:04 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 05:08:03 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>, Yu Zhang
 <yu.c.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqESnTCEgSFc1NkKmPwe8IhjJm7GbZ2+AgAKco3A=
Date: Sun, 19 May 2024 05:08:03 +0000
Message-ID: <DS0PR11MB75299A30E22AE7CC768CEB64C3E82@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <02ee8c65-54a8-4ce4-a4a0-351f29f3eea6@eviden.com>
In-Reply-To: <02ee8c65-54a8-4ce4-a4a0-351f29f3eea6@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|SA3PR11MB7978:EE_
x-ms-office365-filtering-correlation-id: 1803661e-3049-4e8d-3ea3-08dc77c1a99c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MEFTek1vY0JuUUFMd2x4UkUxUEYvUnM0UmhXalRQcktnaGVWRDIwbzdYakhT?=
 =?utf-8?B?M0Zxalk2OXdGVmRJa3RNWDJqZmN4WXlRUlh2eXFTSFlQb0kxbU95UTdwVUtr?=
 =?utf-8?B?bXJ5Z2VzSUt2MlVIamNKNXZvUDZqb1o0MHlKK3c5cWc0U3pRcHpLdHJJRUVP?=
 =?utf-8?B?SEttZEFTanc2Q0RBM3d0a1gyWklGVElwc0IwVFc4dHZNdlU3QkI1ZXcxOS82?=
 =?utf-8?B?bGpYUFM5dHpxN1hjbzRmWW1TRDdnNzNDY0RFRnM5di9iZTZCOWZ6MDZBYnZW?=
 =?utf-8?B?OW0yRWxpK1pMRTFMRk1VV20yOHgrd3MzM2NweWs0NUhMODVZdzFsTVlvazZT?=
 =?utf-8?B?T2JNWmlvTmtOc0lUdnNQUEFMOXNqSzUrZHZTQWNHUjhMTDRhN0w5RFdndnE5?=
 =?utf-8?B?NkFJUEdHR01LZ2doeHFXQi9CeFcraFNTenhJeWdEN1RFR3M5Q0Z6d043SDhV?=
 =?utf-8?B?Y1FxaWVNWHVkbHkxOEZ3QUdkbUp2U1JDWE41Z24rMmRvVTAvUGlFaU84bVhx?=
 =?utf-8?B?RzFXVWpRYTJjaWlXOVVCZFBFVUo3SjNWdUxHZWNQWjd4MXpHbkwrdyt1Rkpt?=
 =?utf-8?B?ejRuQ0UvcDRZQWFMTG9pMGxoamZyRDgweUZBWDdDM0JNcGxJZnZTQnpCK3hW?=
 =?utf-8?B?Wko3ekl5Z3FVVWpaTVBlZ29FUlhaamNCM0ZScVd1SC9rNm5wR3ltbG82a1lk?=
 =?utf-8?B?VXZ4ZXNFL2QyQTNxcnBtVlBqV2JJVlM2SzNkbG5mNUg0VVN5aTBVM1Y3QXlI?=
 =?utf-8?B?SEM3ZUw3dVRTZWZWK2RUeC9DOXZEY2cxNkVlWHhFS1llVkZ0NVZibFkwVzdQ?=
 =?utf-8?B?RE9qZCtwaFhkS3NDdU8yWXVpWFl0RXg4R1Z6Q2tGZXdNZnVqSEJTUWVRTVBZ?=
 =?utf-8?B?K0Ewbm9TVVo1UWpORWJOTHZ1VUlsMkl6aEZFTm5UM2svNmQxL1ByTnFORW44?=
 =?utf-8?B?TDg3cmFxZDZ4UDN5NFphNks2eHJLZlN1aDFrZFNLL0NkdG9RMENLZGFNemVp?=
 =?utf-8?B?ckpBR0xKY2RXaGFXemtYeksyTHdxc1o2OVE0eXVLWlBNYVpHT3lsb3ZEWjVt?=
 =?utf-8?B?QTFXV0tqVXhva1R4Y0szRXN2K1BWUWFvUHJ4d1lGKzdKMnRFbDhtbkpjUlZo?=
 =?utf-8?B?NUhmS1h1Ky9TeVFKTUtBT3A4YWhzZXFhemZwS3I5THdWS2Z0K0paWEtqekhQ?=
 =?utf-8?B?K3NTRlFMUWZBY3lndGJaWGMwYjN6bXlNQndGWEt2N2F6Z2gwWGZqRldLTUM0?=
 =?utf-8?B?UEVJd0Z0MVhmYm9XaXJyMndHaGtSVFU5RUUyK1BTdjN5c3NNd1BadUtvTmZy?=
 =?utf-8?B?LzI3Q3dvNUhHaWw3WVliTFFMQ3ZDdmVEV1o1WVlSMklIRUN6Qmw2cWlEZUZ1?=
 =?utf-8?B?SmN2cjVYdWZBbHVBcUEvb3FrWXlTN2VadUtVaHRWQ2Z6Y1BCdXJ3RHJoRmlS?=
 =?utf-8?B?dGN6NXBTckN3UmlTK1hCZWdYM25RaTFaUFFyWEx5cXVINUpuN2c3NXc1TkRk?=
 =?utf-8?B?dXA5SENReW5ZeWlmQlZMbzZVb0dvcElIWEJha3dpNzJLN2s4NGoxbC91OFMz?=
 =?utf-8?B?K0hnWGUvUm81UTZ3SmVVTVJ2VFhsQ1paVHVCTHpET3BXRjNNeU1vQmxXaDlU?=
 =?utf-8?B?UmpQczl0RDllMG44cVRKODBVQmtiZXF1aXZxYTQ0YzVuRWppSkVYcldsUlQx?=
 =?utf-8?B?ZE5qUzhGYVArMTR4QVFxQ2gyU2xjWHRKMHRvQmJNV3VEWVRBZXh6Wi9SdzVy?=
 =?utf-8?B?anpuRFA1Uys1S05Hc0VhVXJhemRhc2x3ZTNMdWJlcEJBZVhobW1YQUVIUUJp?=
 =?utf-8?B?ZUtqYWJmcnBpSjhmaUNMdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0lFeGxMeHN3NXBuVDc0WGVNZUZZZnBlVm0veVVLMnQwaUswdEp3RzVyS25n?=
 =?utf-8?B?VUI0S2VwdkMvQ2hSWVZxd2NkWEhidGdsaTZwandGQkdWUUtEUTNhOVA0MVY3?=
 =?utf-8?B?S1Z1aWU2OE9ENnZwQU9QbE40MHBDRGxaa2RhNHRhekVNZ2pTRzRucjdrTDRQ?=
 =?utf-8?B?bkx2L0wxOUhSMnZTVE5ic3Fhazg1bEZhejVYS3NLSHJLM0p1eE04b3UyUDc2?=
 =?utf-8?B?ZVVHd3Y2aWNtcGU1Yy9YV202V2cwcVhRdGVjdGhRODgySm5URG5zc3VVcG5V?=
 =?utf-8?B?OHNSSUJ2UDRQQ0c2Y0dISzNSTlQxcmNRMlJQM01PYmdZd2NFbUpnSytIdFYw?=
 =?utf-8?B?dWNPWVlUV2FwTVpTM0NoY25xekRuZloyWm1JUzVJNTlVSXBxUjJXRlJCMXdH?=
 =?utf-8?B?V2tzeXJkYitQcThybGZJclcrYkdXZVg5UGpld1BoaDRKcjU2RUM2dzIybjRY?=
 =?utf-8?B?M2lOTk12Q0lwcFR0SktXK3VRaXpVMWhuUG5obzZFcjlhUGxoVTR6K2JhTW5H?=
 =?utf-8?B?K0tYZDg0VHFGMFhPd0ZmdGdVZ0x1eW9LYnJsVEpvWVVLMTVDeFFjR1ZoYmpG?=
 =?utf-8?B?K1BYRkFiSThZOUJOUGJGOVZOYUlrWW9qRzJCRG5MTzg2TGwyM2VlWWJwT0hT?=
 =?utf-8?B?ZHpzWnh4dnF2cy8xdmNsZjFtQnRNMktaY1FLRTVCQUYrd2pHcVdxYVZjSlJH?=
 =?utf-8?B?MENqQjM3YmpBek1TUWR4Ky9aT0l0eGlWVmRPcmRNUW1JTkQ5SkREWDlSVzNp?=
 =?utf-8?B?ZjFhQnhEZDBOcTYreTZoOVJnNW1mRnNlM1VXRjBST3h5SDJFc0JSZldTRjYw?=
 =?utf-8?B?OFdidm1BWHg3QVJLc2VFeUR3dXNkSnEzQnlya1daR1gxMmJqaG1pWnRDZDdG?=
 =?utf-8?B?bDRSZjJmaFQ1TkdpSy8raUIyZ0Z0N3ppaFo0b2pKbUFaQ0dNSk0vcE1aYnNa?=
 =?utf-8?B?VDhpRVo2OGVDRlNEaFhkQjRPWU9aUVAvRHB3bTBsS0RFU0J3VTI3ZDV1K2Rj?=
 =?utf-8?B?cmpid09HYm52RmpWR2VGV1Q3SXI4cVlmNmhyS0s0ZkFPbWtpUzgxUVdiQWV2?=
 =?utf-8?B?elRSeDRsL3ArbEJJemNvUTFmNHRVMXNuR3BQWVZZN0JEU0NZcVBldElLWFgx?=
 =?utf-8?B?VUpWMXIwZ2JzTy9DWnZmQW1WWXJ6QldpZDE5R01XNWZITmxIQnRsZGNab3Ny?=
 =?utf-8?B?N2N3Q3ovcjBVeVd0UHZIV0J6d3VhSWlKdjU0S0FQSnVWY1R0ajJsVTdUMUYz?=
 =?utf-8?B?WmpnQnpxdHQyRjE3UmlscXlkblFrV1NTRy9Dd0NISkdUdlN1ak5sNmxDRklt?=
 =?utf-8?B?VEJJTkp6VnpFSE9seUlXQk9Ma21Zb2pEek9Wd0xJWUxLdzVFdlFPbDlQaGpj?=
 =?utf-8?B?dm1kSDRUNXBVOU4yai81ZEZGaVhwSTVKUjkzQkIrcHRIRmZSaG1oZENQVlJz?=
 =?utf-8?B?U3BGTThaRE5UVVVuVENBWTR5cno1eGpZVEExVXAwb0Y5NVFiOVFFemxIUEJM?=
 =?utf-8?B?bWlhYVBrUk13R2RaQTRXbjJHZVFtK2lQbU5JZnM3em9SQW9KOGIzUW5mTmZT?=
 =?utf-8?B?bVA1NGJIZlBSLyt6NHRkZktJVHk5T1RsbnZnc0NHUHFDQWgzR2RHdlUzWWh6?=
 =?utf-8?B?ZG1hNS9BYVdUbHJpWHZyd3QxQU4yWHRlenhVaERqT1BzKzY0VUZNTi9kK0tX?=
 =?utf-8?B?Q1RJdWJxN1R4V0tROGFQWEVlYlJpSVhRWHRVTkNiRGJQLzVZSFdYTHMrYWZ0?=
 =?utf-8?B?NTR1S1FrUGdZVTluUVFmRUgzN2kwamRwVUZQTE9WaWVDR09FQVJHVG4wN2Ru?=
 =?utf-8?B?SkFQdHRBUHhDRG94VU1IbzFSekJPWkdQeDJub3FwbGhYS2RIeENSNmlmSDNj?=
 =?utf-8?B?TFQxb1gySGxxSVE2RG9GTkJEM014VFhwWGdqcnVHMHpVbUdublIzczJ6V3lv?=
 =?utf-8?B?MG9wM0lwYlQvWWY2WUhWNHJ6UWVBVzBMUVNRUWJSVlpZbDBLOWdPRzd3ZWdh?=
 =?utf-8?B?OVpQRWRMeWI2ankzT1BWYXowQzZITlUyTjVzL1hsQ0xjSytaS3h4VnMzeFVx?=
 =?utf-8?B?YlMxRzVFdzV1RTRZY0tTTVpIZTQ5QWVmMVczNjBKN1orSVVGNUVoVTJvNVNR?=
 =?utf-8?Q?vuls79JmjVZViKcJoo+nKkqJn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1803661e-3049-4e8d-3ea3-08dc77c1a99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2024 05:08:03.7647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYcCllpLNBRkDaDIplUp5SsAFJCSVf25/r895+QVePF4wLXdiBMnP4v0IYZou1/NycDLaNHFM7bZ0LTzxNvNRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7978
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.039,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlk
ZW4uY29tPg0KPiBTZW50OiBGcmlkYXksIE1heSAxNywgMjAyNCA5OjEzIFBNDQo+IA0KPiBIaSBa
aGVuemhvbmcNCj4gDQo+IE9uIDE3LzA1LzIwMjQgMTI6MjMsIFpoZW56aG9uZyBEdWFuIHdyb3Rl
Og0KPiA+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBv
ciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwNCj4gY29tZXMgZnJvbSBhIGtub3duIHNl
bmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gPg0KPiA+DQo+ID4gRnJv
bTogWXUgWmhhbmcgPHl1LmMuemhhbmdAbGludXguaW50ZWwuY29tPg0KPiA+DQo+ID4gQ3VycmVu
dGx5IHdlIHVzZSBvbmx5IFZURF9GUl9QQVNJRF9UQUJMRV9JTlYgYXMgZmF1bHQgcmVhc29uLg0K
PiA+IFVwZGF0ZSB3aXRoIG1vcmUgZGV0YWlsZWQgZmF1bHQgcmVhc29ucyBsaXN0ZWQgaW4gVlQt
ZCBzcGVjIDcuMi4zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWXUgWmhhbmcgPHl1LmMuemhh
bmdAbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmggfCAgOCArKysrKysrLQ0KPiA+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5j
ICAgICAgICAgIHwgMjUgKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAgMiBmaWxlcyBj
aGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmgNCj4gPiBpbmRleCBmOGNmOTliZGRmLi42NjZlMmNmMmNlIDEwMDY0NA0K
PiA+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiA+ICsrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiA+IEBAIC0zMTEsNyArMzExLDEzIEBAIHR5cGVk
ZWYgZW51bSBWVERGYXVsdFJlYXNvbiB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKiByZXF1ZXN0IHdoaWxlIGRpc2FibGVkICovDQo+ID4gICAgICAgVlREX0ZSX0lS
X1NJRF9FUlIgPSAweDI2LCAgIC8qIEludmFsaWQgU291cmNlLUlEICovDQo+ID4NCj4gPiAtICAg
IFZURF9GUl9QQVNJRF9UQUJMRV9JTlYgPSAweDU4LCAgLypJbnZhbGlkIFBBU0lEIHRhYmxlIGVu
dHJ5ICovDQo+ID4gKyAgICAvKiBQQVNJRCBkaXJlY3RvcnkgZW50cnkgYWNjZXNzIGZhaWx1cmUg
Ki8NCj4gPiArICAgIFZURF9GUl9QQVNJRF9ESVJfQUNDRVNTX0VSUiA9IDB4NTAsDQo+ID4gKyAg
ICAvKiBUaGUgUHJlc2VudChQKSBmaWVsZCBvZiBwYXNpZCBkaXJlY3RvcnkgZW50cnkgaXMgMCAq
Lw0KPiA+ICsgICAgVlREX0ZSX1BBU0lEX0RJUl9FTlRSWV9QID0gMHg1MSwNCj4gPiArICAgIFZU
RF9GUl9QQVNJRF9UQUJMRV9BQ0NFU1NfRVJSID0gMHg1OCwgLyogUEFTSUQgdGFibGUgZW50cnkg
YWNjZXNzIGZhaWx1cmUgKi8NCj4gPiArICAgIFZURF9GUl9QQVNJRF9FTlRSWV9QID0gMHg1OSwg
LyogVGhlIFByZXNlbnQoUCkgZmllbGQgb2YgcGFzaWR0LWVudHJ5IGlzIDAgKi8NCj4gcy9wYXNp
ZHQvcGFzaWQNCg0KUGVyIHNwZWMsIGl0IGlzIHBhc2lkIHRhYmxlIGVudHJ5LiBTbyBaaGVuemhv
bmcgbWF5IG5lZWQgdG8gdXNlIHRoZSBzYW1lIHdvcmQNCldpdGggdGhlIGxpbmUgYmVsb3cuIEUu
Zy4gUEFTSUQgVGFibGUgZW50cnkuDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg0KPiA+ICsgICAgVlRE
X0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOViA9IDB4NWIsICAvKkludmFsaWQgUEFTSUQgdGFibGUg
ZW50cnkgKi8NCj4gPg0KPiA+ICAgICAgIC8qIE91dHB1dCBhZGRyZXNzIGluIHRoZSBpbnRlcnJ1
cHQgYWRkcmVzcyByYW5nZSBmb3Igc2NhbGFibGUgbW9kZSAqLw0KPiA+ICAgICAgIFZURF9GUl9T
TV9JTlRFUlJVUFRfQUREUiA9IDB4ODcsDQo+ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+IGluZGV4IGNjOGU1OTY3NGUuLjA5
NTFlYmI3MWQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gKysr
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gQEAgLTc3MSw3ICs3NzEsNyBAQCBzdGF0aWMg
aW50IHZ0ZF9nZXRfcGRpcmVfZnJvbV9wZGlyX3RhYmxlKGRtYV9hZGRyX3QNCj4gcGFzaWRfZGly
X2Jhc2UsDQo+ID4gICAgICAgYWRkciA9IHBhc2lkX2Rpcl9iYXNlICsgaW5kZXggKiBlbnRyeV9z
aXplOw0KPiA+ICAgICAgIGlmIChkbWFfbWVtb3J5X3JlYWQoJmFkZHJlc3Nfc3BhY2VfbWVtb3J5
LCBhZGRyLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcGRpcmUsIGVudHJ5X3NpemUs
IE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpKSB7DQo+ID4gLSAgICAgICAgcmV0dXJuIC1WVERfRlJf
UEFTSURfVEFCTEVfSU5WOw0KPiA+ICsgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX0RJUl9B
Q0NFU1NfRVJSOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIHBkaXJlLT52YWwgPSBsZTY0
X3RvX2NwdShwZGlyZS0+dmFsKTsNCj4gPiBAQCAtNzg5LDYgKzc4OSw3IEBAIHN0YXRpYyBpbnQg
dnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVTdGF0ZQ0KPiAqcywNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9hZGRyX3Qg
YWRkciwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZU
RFBBU0lERW50cnkgKnBlKQ0KPiA+ICAgew0KPiA+ICsgICAgdWludDhfdCBwZ3R0Ow0KPiA+ICAg
ICAgIHVpbnQzMl90IGluZGV4Ow0KPiA+ICAgICAgIGRtYV9hZGRyX3QgZW50cnlfc2l6ZTsNCj4g
PiAgICAgICBYODZJT01NVVN0YXRlICp4ODZfaW9tbXUgPSBYODZfSU9NTVVfREVWSUNFKHMpOw0K
PiA+IEBAIC03OTgsNyArNzk5LDcgQEAgc3RhdGljIGludCB2dGRfZ2V0X3BlX2luX3Bhc2lkX2xl
YWZfdGFibGUoSW50ZWxJT01NVVN0YXRlDQo+ICpzLA0KPiA+ICAgICAgIGFkZHIgPSBhZGRyICsg
aW5kZXggKiBlbnRyeV9zaXplOw0KPiA+ICAgICAgIGlmIChkbWFfbWVtb3J5X3JlYWQoJmFkZHJl
c3Nfc3BhY2VfbWVtb3J5LCBhZGRyLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcGUs
IGVudHJ5X3NpemUsIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpKSB7DQo+ID4gLSAgICAgICAgcmV0
dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfSU5WOw0KPiA+ICsgICAgICAgIHJldHVybiAtVlREX0ZS
X1BBU0lEX1RBQkxFX0FDQ0VTU19FUlI7DQo+ID4gICAgICAgfQ0KPiA+ICAgICAgIGZvciAoc2l6
ZV90IGkgPSAwOyBpIDwgQVJSQVlfU0laRShwZS0+dmFsKTsgaSsrKSB7DQo+ID4gICAgICAgICAg
IHBlLT52YWxbaV0gPSBsZTY0X3RvX2NwdShwZS0+dmFsW2ldKTsNCj4gPiBAQCAtODA2LDExICs4
MDcsMTMgQEAgc3RhdGljIGludCB2dGRfZ2V0X3BlX2luX3Bhc2lkX2xlYWZfdGFibGUoSW50ZWxJ
T01NVVN0YXRlDQo+ICpzLA0KPiA+DQo+ID4gICAgICAgLyogRG8gdHJhbnNsYXRpb24gdHlwZSBj
aGVjayAqLw0KPiA+ICAgICAgIGlmICghdnRkX3BlX3R5cGVfY2hlY2soeDg2X2lvbW11LCBwZSkp
IHsNCj4gPiAtICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9JTlY7DQo+ID4gKyAg
ICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfRU5UUllfSU5WOw0KPiA+ICAgICAgIH0N
Cj4gPg0KPiA+IC0gICAgaWYgKCF2dGRfaXNfbGV2ZWxfc3VwcG9ydGVkKHMsIFZURF9QRV9HRVRf
TEVWRUwocGUpKSkgew0KPiA+IC0gICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0lO
VjsNCj4gPiArICAgIHBndHQgPSBWVERfUEVfR0VUX1RZUEUocGUpOw0KPiA+ICsgICAgaWYgKHBn
dHQgPT0gVlREX1NNX1BBU0lEX0VOVFJZX1NMVCAmJg0KPiA+ICsgICAgICAgICF2dGRfaXNfbGV2
ZWxfc3VwcG9ydGVkKHMsIFZURF9QRV9HRVRfTEVWRUwocGUpKSkgew0KPiA+ICsgICAgICAgICAg
ICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlY7DQo+ID4gICAgICAgfQ0KPiA+
DQo+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gQEAgLTg1MSw3ICs4NTQsNyBAQCBzdGF0aWMgaW50
IHZ0ZF9nZXRfcGVfZnJvbV9wYXNpZF90YWJsZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+ID4gICAg
ICAgfQ0KPiA+DQo+ID4gICAgICAgaWYgKCF2dGRfcGRpcmVfcHJlc2VudCgmcGRpcmUpKSB7DQo+
ID4gLSAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfSU5WOw0KPiA+ICsgICAgICAg
IHJldHVybiAtVlREX0ZSX1BBU0lEX0RJUl9FTlRSWV9QOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+
ICAgICAgIHJldCA9IHZ0ZF9nZXRfcGVfZnJvbV9wZGlyZShzLCBwYXNpZCwgJnBkaXJlLCBwZSk7
DQo+ID4gQEAgLTg2MCw3ICs4NjMsNyBAQCBzdGF0aWMgaW50IHZ0ZF9nZXRfcGVfZnJvbV9wYXNp
ZF90YWJsZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAg
aWYgKCF2dGRfcGVfcHJlc2VudChwZSkpIHsNCj4gPiAtICAgICAgICByZXR1cm4gLVZURF9GUl9Q
QVNJRF9UQUJMRV9JTlY7DQo+ID4gKyAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfRU5UUllf
UDsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAgICAgICByZXR1cm4gMDsNCj4gPiBAQCAtOTEzLDcg
KzkxNiw3IEBAIHN0YXRpYyBpbnQgdnRkX2NlX2dldF9wYXNpZF9mcGQoSW50ZWxJT01NVVN0YXRl
ICpzLA0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIGlmICghdnRkX3BkaXJlX3ByZXNlbnQo
JnBkaXJlKSkgew0KPiA+IC0gICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0lOVjsN
Cj4gPiArICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9ESVJfRU5UUllfUDsNCj4gPiAgICAg
ICB9DQo+ID4NCj4gPiAgICAgICAvKg0KPiA+IEBAIC0xNzcwLDcgKzE3NzMsMTEgQEAgc3RhdGlj
IGNvbnN0IGJvb2wgdnRkX3F1YWxpZmllZF9mYXVsdHNbXSA9IHsNCj4gPiAgICAgICBbVlREX0ZS
X1JPT1RfRU5UUllfUlNWRF0gPSBmYWxzZSwNCj4gPiAgICAgICBbVlREX0ZSX1BBR0lOR19FTlRS
WV9SU1ZEXSA9IHRydWUsDQo+ID4gICAgICAgW1ZURF9GUl9DT05URVhUX0VOVFJZX1RUXSA9IHRy
dWUsDQo+ID4gLSAgICBbVlREX0ZSX1BBU0lEX1RBQkxFX0lOVl0gPSBmYWxzZSwNCj4gPiArICAg
IFtWVERfRlJfUEFTSURfRElSX0FDQ0VTU19FUlJdID0gZmFsc2UsDQo+ID4gKyAgICBbVlREX0ZS
X1BBU0lEX0RJUl9FTlRSWV9QXSA9IHRydWUsDQo+ID4gKyAgICBbVlREX0ZSX1BBU0lEX1RBQkxF
X0FDQ0VTU19FUlJdID0gZmFsc2UsDQo+ID4gKyAgICBbVlREX0ZSX1BBU0lEX0VOVFJZX1BdID0g
dHJ1ZSwNCj4gPiArICAgIFtWVERfRlJfUEFTSURfVEFCTEVfRU5UUllfSU5WXSA9IHRydWUsDQo+
ID4gICAgICAgW1ZURF9GUl9TTV9JTlRFUlJVUFRfQUREUl0gPSB0cnVlLA0KPiA+ICAgICAgIFtW
VERfRlJfTUFYXSA9IGZhbHNlLA0KPiA+ICAgfTsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+
ID4NCj4gbGd0bQ0K

