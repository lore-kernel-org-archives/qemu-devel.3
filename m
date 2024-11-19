Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97824D591DE
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 07:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDIfS-0001eh-1S; Tue, 19 Nov 2024 02:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tDIfM-0001eL-VY
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 02:28:54 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tDIfJ-0000ZW-GR
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 02:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732001330; x=1763537330;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gZVQH1nK/bcZihYRwz4okrsPNKlovINOcFz5ey3N/lQ=;
 b=b7I9ypD5zEFgQTU0frhiq3GETOaOn+nXzkCGKsQso0QIid6QZQwr5BO8
 nU8kXLkan+6s91aVczU0Uh8Y6jLSA1DvhAFhoEKxvbNUGogA4BAKi1sXU
 +qo7W6XJ3gOOd0eGcsSkgxc+PY+AsCp8HdJ+89Y9w6WMBlMdDffO2u8ft
 3NWm1yBobJD1uxtvxVfQRE6DilDyTxeURpZ4/VrLkiFAT/DNnsWGlFShJ
 h8rPbiyL2Ca10+pcjHtxWcJGs/BstdmGhmLORBGLOoP9W54bd8YvvWYu9
 e7mp+R7sItDMNn97nFnCaq/P6pe5G0xozeOt8PavAnaCP4mqWetmVYl2Q w==;
X-CSE-ConnectionGUID: X1gacpN+Q22uFezHfenooA==
X-CSE-MsgGUID: vbNHnoMZSR+wm59xUZyRVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="43368879"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; d="scan'208";a="43368879"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2024 23:28:45 -0800
X-CSE-ConnectionGUID: Rl400wr0Sb27I6ROkcao5w==
X-CSE-MsgGUID: SKCvbBlwTmyj3f/7WMOyyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; d="scan'208";a="89589187"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Nov 2024 23:28:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 23:28:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 23:28:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 23:28:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKGOfipv1sCDc/Rlk5RrzTTU7AAfrJAogSA0J7T0ysPybYsRgtLHpOP7+Jtf4MvT9ndGVRi8r0RpE2z6itMdf0ukn5cOAplPazgFGHx64ySMqnsuBHrzs0H3VfsYkfWHtZI+/p9AhTLSyylytiaOWWQmE9k9q+2uHKwp0zRbo4E+isuUH/H6p6KFwtYrY37obf5dJmUgNlJeghfMFwd+nbkEgQ6r+D/UDkPxsRS9TR4oxYzNmQAn0I7eG37DbZ2I/rCBHlLknyznnog5jx/zOWivzttfVbwhyGwjNByNdhtayzzAh1KHJnop4petBzC6nG5U4oFykouOmCeHjzaA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZVQH1nK/bcZihYRwz4okrsPNKlovINOcFz5ey3N/lQ=;
 b=N4EF7vYBIIuVlYzNYBbBzUgm/KqxG0CESP264A5WmgzRF9EYleGGqbJNR3Fsi+ghwVhBm8l5I0Xti+gh/K1zmBC+ZhWWyR0twQ1zcqdysy1LSV0yFkGHt32Cim5xLf41w19Uq37u9hwkzjI/wokMWS0rojrWwZ0Aa0Qmc02XevguMXEX+O3LmZu2lZNbignPvaRwzJ60T8ZdTI+cGSCQDVzaNZ1Rt6K/WplQMbx6hnhvXp+Hd/WxyA+aBu5w8dFx5AjCmKEb+Ye47NiF7y9MQH+mttNVQX/kfiy1MtRHEp75XeKEKq0AC5B4kHEMqfUUGnSJsA8d4GNMRTvnfKz5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 07:28:36 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 07:28:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Topic: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Index: AQHbNBVBkR3y0fzlt0GxzbBCrTjZVrK+N5yAgAAE5SA=
Date: Tue, 19 Nov 2024 07:28:36 +0000
Message-ID: <SJ0PR11MB674426124309A5E43608A5DD92202@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-19-zhenzhong.duan@intel.com>
 <3dfc784a-4397-4dd2-9d1f-26549fa09226@eviden.com>
In-Reply-To: <3dfc784a-4397-4dd2-9d1f-26549fa09226@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7768:EE_
x-ms-office365-filtering-correlation-id: b117b380-dc35-40c1-4b00-08dd086bc7e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dGc0cTBpYm5yMEV0eEczdkVza24vUS91VE45RGowSGpoY1VmTkJlQ1FEaFpC?=
 =?utf-8?B?RGV5d1ErdG9vd2JNUFgxbHpzRFhiMXNtRUJrZTFsWlQxVExBbjBuK3VtVDBZ?=
 =?utf-8?B?V0tUaUpwMnBndDlJQWgxYU5PNWJ1YWV2dG5FeG5uN1F6QUFiMXlyNlpZc3c0?=
 =?utf-8?B?ODRoeGp1MTJISTZsc3ZFblNSOVFBRlRLVVdhcC9Ea2lmbDA4TGZLNm1OUm5G?=
 =?utf-8?B?aC9lOENIWnc2b1A4RnVMQlZ1Sjdscm15T2lRNWZML0xITHhWYnRyUGNKWVoz?=
 =?utf-8?B?T2lLNGRRZmdVSkp3akFSQ3hLUDBwbDM3T2FBYmdUUmdJRzdRUURPclhpaEFS?=
 =?utf-8?B?UkxUdWlXOGhPZElwbXhsNFlZbzJyUVcwUk1qaDRMeEVWc2U2YzBCMmVEVzQ4?=
 =?utf-8?B?MS81RTRFdzlzRFN5SDVRSTJiT2lUQy9QcWwzQ01Ka2l0NnpDZjVFRjVKTEw0?=
 =?utf-8?B?NCs5aTZLYnRDdjBiRGViaWtSRHdzbUQxdlFRdEQ3ODBBakN4VEZQdkVkMm9W?=
 =?utf-8?B?YlJVU2FjRTc2NEl1YmFyMW0waU9yUDNCNUNzMjVTUFJaRGZMQ2Q3cG10ME5V?=
 =?utf-8?B?cEF5YlU3TzFPNElwOEs0YStiU004SHJnTWtSU0ZIUmUvV0tEVGIzUDNhczQr?=
 =?utf-8?B?V3A0UnlxT0RTa25CZjNPcDdoRTRCd1lWTXBnWFpZSDBEcVVOSzRqSnIwenU4?=
 =?utf-8?B?d0hzVndaNHNOZ2VWNEFMbWMra21GU1ZaRkQ4Q1p4eEdYbmdOU3I5MFFoTncr?=
 =?utf-8?B?Uk04UmhrQzZDL1ZiYjhLYnlYZytxSUZGckk2dS9YcXRCVDZkb2JBVUd2ODZj?=
 =?utf-8?B?dXB4WWlCTld1dHB5UVJWTnlMZjFSbWk1QUhZVDJuK2Y5VHdpY09LYkRYcnpy?=
 =?utf-8?B?blFsUCs1MDdDVFNsc01iamdtOVhzL3dFZm1RcUdCaEpPc2EvVU5GTHdEL0t0?=
 =?utf-8?B?TE1Nb2tmeUVONnkwL1N1MjBjVHZxR3RVaVYyWEl0bThFSVc0TnF3dVNFVFJN?=
 =?utf-8?B?M0pBTkMrWThEZFNhbFhoK2xHaWtEMm9xZ3VXSGRmK0thN1NpK3ZxNzFSUEpZ?=
 =?utf-8?B?L3BKNStqWUpNcFptZGlmT1pLN2pTdXJDdUVKMXdSU0VMU2tQN1pWUENuaXo0?=
 =?utf-8?B?eFpKZnVNK3llR3Y1Mkhjck5JT29vRXdVMkRTK0ZTb2hkZ1VoZTFzT1R1VUta?=
 =?utf-8?B?aDZCcFBVcW9PMGh4RU1vL2FMY1JGVE80b0t6MTNjK3ljZU5KV2NMSmxCcHRK?=
 =?utf-8?B?aGdnQ212VzNTV3VFT210NkZoOUtFcnM1ai9Eb1pGZFFRYnlka2ZQTm5NVFRj?=
 =?utf-8?B?SlRUbmR4ejhkR2gyRXY3SVY5dHJoTDQ0Q3FKQjY0WE1NNGZMTEhWYnlkZDZq?=
 =?utf-8?B?OSt6ZmxsVDVQQ3ExdkdTNktDOStma1pGQnBvenIwYWg0RTEwWEVjTWtSRmdi?=
 =?utf-8?B?bXFoMVhxam12YXpCbWdjak1ZYkNPcGI5ajFYS1QwNWs1bFM4THFhbm91VG12?=
 =?utf-8?B?TnZ5c3NJWThYN2VLcnBud21oZ0d5VHpTUmhobWkvdWdmOWdMR1JmY014RHdO?=
 =?utf-8?B?RUgxWndvWGhCNy9EUnNRNmt4Yno1NjFJN1B5TlQxZE92b1JUU1VZWUgrSExm?=
 =?utf-8?B?RVA4ZHhFd25hUFl4c2dsTFp5U3JrV1NPRWVzajFXazJOYm4yVzBGbDRjem9k?=
 =?utf-8?B?WU4vQ1ZDYXZROU54VEI1dXZvcjFlNkh6K1VqQWgzYzhCd2RpY3ZSbkk4WVNY?=
 =?utf-8?B?MThQY0hmRXNRNktxU3dKVFBhblVCeWZlbTJac0dDMTJiU3Q0RmRxZGZPYU9N?=
 =?utf-8?Q?krfkw+dAranLgYgg15xycbHjUXkCrcn6b3PUs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2N6Tk1TbEhiYTkwOGRBSDhUTGhmQXZUaWVBcTF2L1B0VGpnQnhNREk0NjRo?=
 =?utf-8?B?RS8rTzZEOEdFeHdWckp2V2RISFhvSUJXYy9OUHlOT3hxR2NER0dicWsyWFZ0?=
 =?utf-8?B?VWx4V1pCYkVZR3IzQnJBOEFDNFZ2WXhyemcxUnVab05VM0N6QmExeWVzb0ZR?=
 =?utf-8?B?b2IrL2ZoZmNhNnQrdThJdk1KWFN6OUpRaGJRSWRXYmFSV2JBZTBvTXEyRlJZ?=
 =?utf-8?B?cGpJVkZyVnJIcmNMc24wVE9hNXJFQjIrK3JHdmxWcGt4ZXV3K3ZPTXNPbEpw?=
 =?utf-8?B?dkdjeEswUndNQUxtcWRpMk5ocEwra0hLdnBidC9xQ2tIUjE0aVd3MzZxMkRV?=
 =?utf-8?B?WHh2YzUzV0dPZXJXblllUkczcnFyS0I3dFhXMmI3YzFUdHo5ZS9WVGdEUDFt?=
 =?utf-8?B?aVdYdGJGN0JaTGErMEU3ZFJSS1VNV1M0SXVLMm1CWDRUT3B4T2drekFQa0p5?=
 =?utf-8?B?U2VCVmpFWW13RTZ6bkJjYmNPMUhPcUVzK3k5bXhxWjRmTzZPWjQ4V2p6d1Jx?=
 =?utf-8?B?WjBla3N1dTZlQUdGVFQrNWMrV20zVEVKM0lBR2s5YVBtLzlBZGU4QjlNYnpC?=
 =?utf-8?B?bXEvbjRXTkRpMmFUczF4K21SUmVNRHBCdmYvR3ZEZUkvMURzU3JZTEUyendD?=
 =?utf-8?B?aURRQVNSeXhURVE5RWRtSEhiM0pJa0RRbXN1blc4VnVCbzNZT1ZQeHZYL3JM?=
 =?utf-8?B?amluQ20wbC8vOEpROUd2NDFCWkNtTDVlWGRkTUlhcWdoMVVxMit3dTYzaU5n?=
 =?utf-8?B?MmVoczRkeGhtUWkzcEJHQURXRjViSTVPQnE1RHN3YUJMSllZUmdpa2NKY0cr?=
 =?utf-8?B?Ry8xOWdLN1VEZllnN1FZNTNYRWNyaUl1R05pZ09JZURkdEpWRksxcnFyK0JQ?=
 =?utf-8?B?THozNTl1Z3E4dEVhL05ieVlIYjRLT2VMQ0hYYkR1NjF4N3l1V0hJVnJlRlZB?=
 =?utf-8?B?dURERXo1cXFUQW9CUko5a2R1YUhHZVNmWTVJb1RsUE50SjJJeWVxeHdIRk16?=
 =?utf-8?B?dGpzQzJ1NlVta21nUk1aaVFHcENnZys0RXVPL0lrQnU0dHhWQXdnY3J3ZFJI?=
 =?utf-8?B?dnkzaVRzVVZJUnEyTVRNTHJaemJYNHNyNHBtMjFWMy9naUtrbkViS0hDTzBL?=
 =?utf-8?B?Y0pBM2djVnVnbUFLSGRSUXU1K3QyQzMrTzBkMS9VRjlQOU1WdU1RY3piOUFL?=
 =?utf-8?B?MmJRT2wzemtwNDdCTkRzSWR6UFVwQTJvbUtscVVaL0hkOCtPbzBNcWpsOXFi?=
 =?utf-8?B?bkoyOFRMbWJLd1lMYVMzZDdsL09lYmZiaFlPQ3BDYzhhWTVBWG5sbUV1SHJr?=
 =?utf-8?B?WGw4V0lGaDZ5WGozZVJGUUVDQldEUk42TFllR1ZYTU1tVnpDQU1IODl6c0NW?=
 =?utf-8?B?RGdIYmVWTGFRVVFDeUMyUU9WejlBaW0zNmhxUHpiU0xCWEJ1YVBzZXo5OTdj?=
 =?utf-8?B?ZjkxTzJGQThRQ21mRVRZd2VqTWVMOWR4R1FyNjB5b2dNZldGMHRGL1hFUUpS?=
 =?utf-8?B?NDBWMjRmK0Y2Q0Jia3F3MTBrWjNsZnE3cDlNRnRTZkhCMVJEU3V2b3dyMW0x?=
 =?utf-8?B?MFZGYjl6cXJqNW5BSU1tc09iWXY1Y2NySjU1REJsWjVwN3JFYXdMS3RUY3dC?=
 =?utf-8?B?UXMvQ2FZSFc3WWxLaXdLcmpuTVVoZTEvUzBFWTRZRXlZYUFIRkpraFUwUGFK?=
 =?utf-8?B?dlhUVkM1cTB3TEp1VmNKajhtaTdCV0tJUFQ5QzJTM1Z1NnRVRzJKNnJmN1pL?=
 =?utf-8?B?YlBCVEZnUUxGSlRNVWszMVJGbktnNFBMYWN1b2dxMHg2VUdBNFBKTVFUTG90?=
 =?utf-8?B?WWwrdHVGcnV2c3NrWHBGTU4vQzJjenZ6bWJHdFRCOFExdWlLTVJSYVhJZ1I2?=
 =?utf-8?B?LzNxM2JJTHlneHJ6U1hrRVdyZU4rRGJjVCtaUzFoWnlkRXhBT3M4S2JXd3BQ?=
 =?utf-8?B?azQyQS80T3BkRHUvaWFTeHBHOG5FbDU5MU5UMU4xdzEvRVY3cUpQU0tvaTFm?=
 =?utf-8?B?WS9kdHV4eVVxN0FrR1R5TGw5MTlrUStwc2dsYlpEenBHZzZEbkpyWHk3a1pt?=
 =?utf-8?B?Y1M5YUM1aitzRFBJbVE4eHRrN3lLc2xyaTBpK1pFeXJsTEpJTlN5T1R6TTBG?=
 =?utf-8?Q?E3pgE6qnH2pdTR98QOSvfanWY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b117b380-dc35-40c1-4b00-08dd086bc7e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 07:28:36.4809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBshrFRLOHYWJaIIAlXwhpHqEadCiwNRKXD3iwO10ylTeggmUKNaoga1FVSwo10sHI39GrsvAfEHmEdQ2Jooa/q9uc/jJrbP3X+rMXME62A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7768
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj5TdWJq
ZWN0OiBSZTogW1BBVENIIHY1IDE4LzIwXSBpbnRlbF9pb21tdTogSW50cm9kdWNlIGEgcHJvcGVy
dHkgeC1mbHRzIGZvcg0KPnNjYWxhYmxlIG1vZGVybiBtb2RlDQo+DQo+SGkgemhlbnpob25nLA0K
Pkp1c3Qgb25lIGNvbW1lbnQgYnV0IHlvdSBjYW4gYWRkIFJldmlld2VkLWJ5OiBDbMOpbWVudCBN
YXRoaWV1LS0NCj5EcmlmPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPg0KPg0K
Pk9uIDExLzExLzIwMjQgMDk6MzQsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQ2F1dGlvbjog
RXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1
bmxlc3MgdGhpcw0KPmVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pg0KPj4NCj4+IEludGVsIFZULWQgMy4wIGludHJvZHVj
ZXMgc2NhbGFibGUgbW9kZSwgYW5kIGl0IGhhcyBhIGJ1bmNoIG9mIGNhcGFiaWxpdGllcw0KPj4g
cmVsYXRlZCB0byBzY2FsYWJsZSBtb2RlIHRyYW5zbGF0aW9uLCB0aHVzIHRoZXJlIGFyZSBtdWx0
aXBsZSBjb21iaW5hdGlvbnMuDQo+Pg0KPj4gVGhpcyB2SU9NTVUgaW1wbGVtZW50YXRpb24gd2Fu
dHMgdG8gc2ltcGxpZnkgaXQgd2l0aCBhIG5ldyBwcm9wZXJ0eSAieC1mbHRzIi4NCj4+IFdoZW4g
ZW5hYmxlZCBpbiBzY2FsYWJsZSBtb2RlLCBmaXJzdCBzdGFnZSB0cmFuc2xhdGlvbiBhbHNvIGtu
b3duIGFzIHNjYWxhYmxlDQo+PiBtb2Rlcm4gbW9kZSBpcyBzdXBwb3J0ZWQuIFdoZW4gZW5hYmxl
ZCBpbiBsZWdhY3kgbW9kZSwgdGhyb3cgb3V0IGVycm9yLg0KPj4NCj4+IFdpdGggc2NhbGFibGUg
bW9kZXJuIG1vZGUgZXhwb3NlZCB0byB1c2VyLCBhbHNvIGFjY3VyYXRlIHRoZSBwYXNpZCBlbnRy
eQ0KPj4gY2hlY2sgaW4gdnRkX3BlX3R5cGVfY2hlY2soKS4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBM
aXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5z
dW5AbGludXguaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmggfCAgMiArKw0KPj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAg
fCAyOCArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5h
bC5oDQo+PiBpbmRleCAyYzk3N2FhN2RhLi5lOGIyMTFlOGIwIDEwMDY0NA0KPj4gLS0tIGEvaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj4+IEBAIC0xOTUsNiArMTk1LDcgQEANCj4+ICAgI2RlZmluZSBWVERfRUNB
UF9QQVNJRCAgICAgICAgICAgICAgKDFVTEwgPDwgNDApDQo+PiAgICNkZWZpbmUgVlREX0VDQVBf
U01UUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQzKQ0KPj4gICAjZGVmaW5lIFZURF9FQ0FQX1NM
VFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NikNCj4+ICsjZGVmaW5lIFZURF9FQ0FQX0ZMVFMg
ICAgICAgICAgICAgICAoMVVMTCA8PCA0NykNCj4+DQo+PiAgIC8qIENBUF9SRUcgKi8NCj4+ICAg
LyogKG9mZnNldCA+PiA0KSA8PCAyNCAqLw0KPj4gQEAgLTIxMSw2ICsyMTIsNyBAQA0KPj4gICAj
ZGVmaW5lIFZURF9DQVBfU0xMUFMgICAgICAgICAgICAgICAoKDFVTEwgPDwgMzQpIHwgKDFVTEwg
PDwgMzUpKQ0KPj4gICAjZGVmaW5lIFZURF9DQVBfRFJBSU5fV1JJVEUgICAgICAgICAoMVVMTCA8
PCA1NCkNCj4+ICAgI2RlZmluZSBWVERfQ0FQX0RSQUlOX1JFQUQgICAgICAgICAgKDFVTEwgPDwg
NTUpDQo+PiArI2RlZmluZSBWVERfQ0FQX0ZTMUdQICAgICAgICAgICAgICAgKDFVTEwgPDwgNTYp
DQo+PiAgICNkZWZpbmUgVlREX0NBUF9EUkFJTiAgICAgICAgICAgICAgIChWVERfQ0FQX0RSQUlO
X1JFQUQgfA0KPlZURF9DQVBfRFJBSU5fV1JJVEUpDQo+PiAgICNkZWZpbmUgVlREX0NBUF9DTSAg
ICAgICAgICAgICAgICAgICgxVUxMIDw8IDcpDQo+PiAgICNkZWZpbmUgVlREX1BBU0lEX0lEX1NI
SUZUICAgICAgICAgIDIwDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCBiOTIxNzkzYzNhLi5hN2E4MWFlYmVlIDEw
MDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+IEBAIC04MDMsMTYgKzgwMywxOCBAQCBzdGF0aWMgaW5saW5lIGJvb2wN
Cj52dGRfaXNfZmxfbGV2ZWxfc3VwcG9ydGVkKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDMyX3Qg
bGV2ZWwpDQo+PiAgIH0NCj4+DQo+PiAgIC8qIFJldHVybiB0cnVlIGlmIGNoZWNrIHBhc3NlZCwg
b3RoZXJ3aXNlIGZhbHNlICovDQo+PiAtc3RhdGljIGlubGluZSBib29sIHZ0ZF9wZV90eXBlX2No
ZWNrKFg4NklPTU1VU3RhdGUgKng4Nl9pb21tdSwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVlREUEFTSURFbnRyeSAqcGUpDQo+PiArc3RhdGljIGlubGluZSBib29s
IHZ0ZF9wZV90eXBlX2NoZWNrKEludGVsSU9NTVVTdGF0ZSAqcywgVlREUEFTSURFbnRyeSAqcGUp
DQo+PiAgIHsNCj4+ICAgICAgIHN3aXRjaCAoVlREX1BFX0dFVF9UWVBFKHBlKSkgew0KPj4gLSAg
ICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9TTFQ6DQo+PiAtICAgICAgICByZXR1cm4gdHJ1ZTsN
Cj4+IC0gICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfUFQ6DQo+PiAtICAgICAgICByZXR1cm4g
eDg2X2lvbW11LT5wdF9zdXBwb3J0ZWQ7DQo+PiAgICAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRS
WV9GTFQ6DQo+PiArICAgICAgICByZXR1cm4gISEocy0+ZWNhcCAmIFZURF9FQ0FQX0ZMVFMpOw0K
Pj4gKyAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9TTFQ6DQo+PiArICAgICAgICByZXR1cm4g
ISEocy0+ZWNhcCAmIFZURF9FQ0FQX1NMVFMpOw0KPj4gICAgICAgY2FzZSBWVERfU01fUEFTSURf
RU5UUllfTkVTVEVEOg0KPj4gKyAgICAgICAgLyogTm90IHN1cHBvcnQgTkVTVEVEIHBhZ2UgdGFi
bGUgdHlwZSB5ZXQgKi8NCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgY2FzZSBW
VERfU01fUEFTSURfRU5UUllfUFQ6DQo+PiArICAgICAgICByZXR1cm4gISEocy0+ZWNhcCAmIFZU
RF9FQ0FQX1BUKTsNCj4+ICAgICAgIGRlZmF1bHQ6DQo+PiAgICAgICAgICAgLyogVW5rbm93biB0
eXBlICovDQo+PiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gQEAgLTg2MSw3ICs4NjMsNiBA
QCBzdGF0aWMgaW50DQo+dnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVT
dGF0ZSAqcywNCj4+ICAgICAgIHVpbnQ4X3QgcGd0dDsNCj4+ICAgICAgIHVpbnQzMl90IGluZGV4
Ow0KPj4gICAgICAgZG1hX2FkZHJfdCBlbnRyeV9zaXplOw0KPj4gLSAgICBYODZJT01NVVN0YXRl
ICp4ODZfaW9tbXUgPSBYODZfSU9NTVVfREVWSUNFKHMpOw0KPj4NCj4+ICAgICAgIGluZGV4ID0g
VlREX1BBU0lEX1RBQkxFX0lOREVYKHBhc2lkKTsNCj4+ICAgICAgIGVudHJ5X3NpemUgPSBWVERf
UEFTSURfRU5UUllfU0laRTsNCj4+IEBAIC04NzUsNyArODc2LDcgQEAgc3RhdGljIGludA0KPnZ0
ZF9nZXRfcGVfaW5fcGFzaWRfbGVhZl90YWJsZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAgICAg
ICB9DQo+Pg0KPj4gICAgICAgLyogRG8gdHJhbnNsYXRpb24gdHlwZSBjaGVjayAqLw0KPj4gLSAg
ICBpZiAoIXZ0ZF9wZV90eXBlX2NoZWNrKHg4Nl9pb21tdSwgcGUpKSB7DQo+PiArICAgIGlmICgh
dnRkX3BlX3R5cGVfY2hlY2socywgcGUpKSB7DQo+PiAgICAgICAgICAgcmV0dXJuIC1WVERfRlJf
UEFTSURfVEFCTEVfRU5UUllfSU5WOw0KPj4gICAgICAgfQ0KPj4NCj4+IEBAIC0zODI3LDYgKzM4
MjgsNyBAQCBzdGF0aWMgUHJvcGVydHkgdnRkX3Byb3BlcnRpZXNbXSA9IHsNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgIFZURF9IT1NUX0FERFJFU1NfV0lEVEgpLA0KPj4gICAgICAgREVGSU5F
X1BST1BfQk9PTCgiY2FjaGluZy1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBjYWNoaW5nX21vZGUs
DQo+RkFMU0UpLA0KPj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1zY2FsYWJsZS1tb2RlIiwg
SW50ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2RlLA0KPkZBTFNFKSwNCj4+ICsgICAgREVGSU5F
X1BST1BfQk9PTCgieC1mbHRzIiwgSW50ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2Rlcm4sIEZB
TFNFKSwNCj4+ICAgICAgIERFRklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElP
TU1VU3RhdGUsIHNub29wX2NvbnRyb2wsDQo+ZmFsc2UpLA0KPj4gICAgICAgREVGSU5FX1BST1Bf
Qk9PTCgieC1wYXNpZC1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBwYXNpZCwgZmFsc2UpLA0KPj4g
ICAgICAgREVGSU5FX1BST1BfQk9PTCgiZG1hLWRyYWluIiwgSW50ZWxJT01NVVN0YXRlLCBkbWFf
ZHJhaW4sIHRydWUpLA0KPj4gQEAgLTQ1NTgsNyArNDU2MCwxMCBAQCBzdGF0aWMgdm9pZCB2dGRf
Y2FwX2luaXQoSW50ZWxJT01NVVN0YXRlICpzKQ0KPj4gICAgICAgfQ0KPj4NCj4+ICAgICAgIC8q
IFRPRE86IHJlYWQgY2FwL2VjYXAgZnJvbSBob3N0IHRvIGRlY2lkZSB3aGljaCBjYXAgdG8gYmUg
ZXhwb3NlZC4gKi8NCj4+IC0gICAgaWYgKHMtPnNjYWxhYmxlX21vZGUpIHsNCj4+ICsgICAgaWYg
KHMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAgICAgcy0+ZWNhcCB8PSBWVERfRUNBUF9T
TVRTIHwgVlREX0VDQVBfRkxUUzsNCj4+ICsgICAgICAgIHMtPmNhcCB8PSBWVERfQ0FQX0ZTMUdQ
Ow0KPj4gKyAgICB9IGVsc2UgaWYgKHMtPnNjYWxhYmxlX21vZGUpIHsNCj4+ICAgICAgICAgICBz
LT5lY2FwIHw9IFZURF9FQ0FQX1NNVFMgfCBWVERfRUNBUF9TUlMgfCBWVERfRUNBUF9TTFRTOw0K
Pj4gICAgICAgfQ0KPj4NCj4+IEBAIC00NzM3LDYgKzQ3NDIsMTEgQEAgc3RhdGljIGJvb2wgdnRk
X2RlY2lkZV9jb25maWcoSW50ZWxJT01NVVN0YXRlICpzLA0KPkVycm9yICoqZXJycCkNCj4+ICAg
ICAgICAgICB9DQo+PiAgICAgICB9DQo+Pg0KPj4gKyAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGUg
JiYgcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJM
ZWdhY3kgbW9kZTogbm90IHN1cHBvcnQgeC1mbHRzPW9uIik7DQo+VGhlIGVycm9yIG1lc3NhZ2Ug
c2hvdWxkIGJlICJ4LWZsdHM9b24gbm90IHN1cHBvcnRlZCBpbiBsZWdhY3kgbW9kZSIgb3INCj5l
dmVuICJ4LWZsdHMgaXMgb25seSBhdmFpbGFibGUgaW4gc2NhbGFibGUgbW9kZSIgYXMgdGhlcmUg
aXMgbm8gRkxUIGluDQo+bGVnYWN5IG1vZGUNCg0KT0ssIHdpbGwgZG8uDQpCdXQgSSdtIG5vdCBx
dWl0ZSBjbGVhciBvZiB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuDQoiTGVnYWN5IG1vZGU6IG5vdCBz
dXBwb3J0IHgtZmx0cz1vbiIgYW5kICJ4LWZsdHM9b24gbm90IHN1cHBvcnRlZCBpbiBsZWdhY3kg
bW9kZSIuDQpJcyBpdCBiZWNhdXNlIHRoZSBsYXRlciBsb29rcyBtb3JlIGZvcm1hbCBvciB0aGUg
Zm9ybWVyIGhhcyBhbWJpZ3VpdHk/DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

