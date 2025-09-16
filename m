Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB016CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQt4-0004DQ-1S; Tue, 16 Sep 2025 04:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uyQsc-0003wf-5u
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:17:39 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uyQsW-00046C-Rr
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758010653; x=1789546653;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yoffCoproyxI54rj4Mi/4EYXT7Gy2N6IIS1hGdIygQ8=;
 b=AHM643TZa0h4tNUK/gpcMDlIgSC6b9i+bTv0+0hiMe9QVIwpbRYdQIbS
 Ad7iXcqwBzg+RSjY7TWw1ZjQ8Nei8kMEZKtPi81DnFtzxMB8ldrOKn1eE
 ZyM97m6w/8glwmjjPlVcDmwu88wWD2ZJw7MHqgiCK19QlbXSoUsokl6wX
 ZqhUasMNxfaYU50Jsx9V0WZ5RMe6cCfmoQUTyuiqk5+8ZnFvJbkOvlgf9
 C0ZTdwXHoC6fv9NeDH7fvjb9cVMYCVXig5Qj41G8ry+pWV9kXw07fQ7OC
 69VReOqxGEVIOJhc+YCnQWVBOB77dL6Utam6Erd4j+lOuoX5XSkpL3E31 Q==;
X-CSE-ConnectionGUID: ararzD0LRXGyc1eHkBEmaA==
X-CSE-MsgGUID: r0YRgIOjT4OGsfoHU/Cqeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77723391"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77723391"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:17:23 -0700
X-CSE-ConnectionGUID: XGt1eFqSTSWozIVekdL/KA==
X-CSE-MsgGUID: LuxOnbScQAuy0Z/9+9Ke/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174483497"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:17:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 01:17:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 01:17:22 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 01:17:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljpzii0LAixQdT64XMuXsG05k1y97ijKUJuNBtBakSSCX+IMBbjoXUZP0AUxdcv8wIwhjst1BRB0xbC4JUQMLWjP0YCVNU/scQUtJK59AC0tpAjBzrH21KRGzeCSGWy0vL/hegzIxPLSojLwZ0G4QeBw9gcVM6rmfba75mNAvin+OqtToPNCfB9FhpNJb8jlLraPGJIpUnTtkoieBR6vyzuukYFli5/U6inL9JuSJxxl2vLqvpB5QuF5oX734cS+S9AmSie7bUKoE6INuVEkX0O1UAlonw6OiEIevSGyuVF2dZGRLAmMX+p4hxmlBvVRvt549A5ekux6XRuvCwVYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoffCoproyxI54rj4Mi/4EYXT7Gy2N6IIS1hGdIygQ8=;
 b=rQc/KUm893Po+OvhwNErhVYus/rWFyPgsiHz2gYt8xVwU+rI0m/OrRTa3cwFHanB4rTfK2XjVwPbUICB/Ky5P6EN3yM4GBR5uA9/eY6ycxD9+r0DrtWHfOvLVNa7VN7lqvYjqbigDLXc+JMzG+kiMzUpMDKY67l53s2Pg1qeyeORBGwzqJ/eAH4V/OoZQBOQd/+wPuhALYuRLjPrAEyCtVHYzj4utH02ALaPMHVoh/CyC555l5P0mXiK0kfFgorDj2mdqvRVDsdTwTd1gw4wbpm7ebLE/VoewshaK8fmmbABIdKKM/cH4RPbL69GfmWa7P+84A+0QY8nQEy0qIn0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BL1PR11MB6027.namprd11.prod.outlook.com (2603:10b6:208:392::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 08:17:20 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 08:17:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 21/21] intel_iommu: Enable host device when x-flts=on
 in scalable mode
Thread-Topic: [PATCH v5 21/21] intel_iommu: Enable host device when x-flts=on
 in scalable mode
Thread-Index: AQHcEy//rgU/OCvX5UWaMK5iQLVRubR5Sp4AgBxSEkA=
Date: Tue, 16 Sep 2025 08:17:19 +0000
Message-ID: <IA3PR11MB91365B151CAC1C450AF9BEE89214A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-22-zhenzhong.duan@intel.com>
 <73f2d705-e571-4248-8a2a-26c38a0395e5@intel.com>
In-Reply-To: <73f2d705-e571-4248-8a2a-26c38a0395e5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BL1PR11MB6027:EE_
x-ms-office365-filtering-correlation-id: cd6866c7-6c6f-42e5-1916-08ddf4f974aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NEdmeWNpYmVycGRoUlpjMGFjdWpqNDRhRWNvOWJJdE9iTmVRWVBDYXRVTkox?=
 =?utf-8?B?UzlPRVJBc2xha3IydzZURmRFUXNOOFBiVURnNi9OYlFkczVoblhseVYxYzdI?=
 =?utf-8?B?MzE3VE1BTU93Z2VwUnAxRVhaSEo3cndDcEN5MTVOVWV4OENmdmNlcnJQL1FH?=
 =?utf-8?B?bWZXWURJTnFFaEtWWWMybzRSWTJiaEkvbmREN1FZTUhHMUtmejVCemZSd3BY?=
 =?utf-8?B?bFBrYVBVN2xQU2gwNFdUQmFYNmtTK0hzQTcvTVh6bzJNMS9mVjZuM2VUSmN6?=
 =?utf-8?B?UEpNZDd2aHpYeDFJZlJtV1JLcDNXUXh3OVltRVVLSmQ0VGNtWHhVREI2Q0xD?=
 =?utf-8?B?akRONy9qaTdEem9mSzBYblBGSjJOSVZKL2hLL2ZndWQxKzgvQnA5VndsbW5j?=
 =?utf-8?B?SThGS0xZVXdqOXVDWHB3TVNtVFhHM0wreTlXS1pYa3RwVlBESWl1b2Vhek9W?=
 =?utf-8?B?OENMY1o4M0ErbngwbmVLL1RhM1NGRHl0cnZmQTBxenpmeFk3d1B2Rkp4YXRw?=
 =?utf-8?B?dVB0ekxjd085RkcrdWw3T3E1N2UyZ2YydWx1WUFJSVduU3BhSUl5ZG9JZkhv?=
 =?utf-8?B?NmJJNGoxaTlJcEpnRGNQbFpZRkdSbWovdVFueUluRTlrMjYyN3ZiNWJRVjRj?=
 =?utf-8?B?dmpXam1DN1dZZHd5M0l5ODVueGllSUVlT3dEUk4wWjk4WUlGbVBXZGVRcEU3?=
 =?utf-8?B?NlBrMEZVaHZ0Mis3SGdDMHNXcTZ1RFF4TGt6RGFBMWdNNVpKSXZiV3BtUVN3?=
 =?utf-8?B?dnQ3MVAvWG8xc0VmdjhHcXJGUHZiOFZLR3ZkWDlkN2xsSlRnTGpxTU9tbjdW?=
 =?utf-8?B?bXlsVFFXbnN3d2dGc0pBQUZ5eW9HMWFjOUFvV2NScWxVMnVoQ2FhVkxLcHBL?=
 =?utf-8?B?SlZHQ2VwZXZocHVpVFp4RkxTT1ZBYzkvRjFMUEd6Rmh2a0hoUllXS2IvVk55?=
 =?utf-8?B?Q0R4RTJNMUlPRTlLSnU4aVRGT3YrS3Q5aDNJM09CdWRuOHJUUGNQUDVSU1VB?=
 =?utf-8?B?amorUmwxczNXblFTYVhIK1B0ZVFlT1Btc1JWR0I1Y0lrekFCVWJRM3JHQlNZ?=
 =?utf-8?B?aDdaemQrVGRSdWhMR3JHaVdxQkVnU0VLY01WZmozd3FZTkNGQWtOM2kyQkU2?=
 =?utf-8?B?WjcvSTR6cUpiUnVJdVBpNmV4UHF0aWV2K1hBblJOMzA1clhQS1daZlZ0NTd0?=
 =?utf-8?B?TTU3UnNrVG9lVFZEbm50S0p1NmZsYmg5UlZJS1I1dEI0U0Z0UTdzTWttM1lS?=
 =?utf-8?B?NVhoTTR0YVBwUUs0OG1tNXEwbU4wSU5sRUxNN1VtUnZXVXNLNjZyTmdZOVFt?=
 =?utf-8?B?T1A2MHJBQktJSExYVzRMQk1Qa3g0RnFQSCtGTGsrbllOaEsyMkxEZEdTcUxP?=
 =?utf-8?B?SzlzWXhpYUFTYk15S0Y5MEZXVS94WmJ1bXNzQjZub1BSNXJqRkk1M2FHVGpV?=
 =?utf-8?B?dC9vWFNnSE5HMldNS3NBb2tKSDRKSnptUkU0Y2pidi90Z1FvMzd4eHVJQWE1?=
 =?utf-8?B?cWpoTGRUdnREYm1ZZzEwbWVmbGIxTERobjljZEFrU1JMZXBPR1hzeDJBbTBn?=
 =?utf-8?B?QWJ0TjROcFNZOUQ4eGZKSkxGRFo1eTlxZWxvMXF1a29OeUNiQVFLd01OOVNZ?=
 =?utf-8?B?angySytaWXFXK2NwUGlJNllzNzUxMWUxbUdzZHVTOHBieVljZlBRa0pLVDJT?=
 =?utf-8?B?RXovSUFia1FUSFNsY01Cd0YvdG9OcStuYUtXOWtqRkNuQXpvWHpZd3hhMzhx?=
 =?utf-8?B?NGN0MUcyY0lzV2F3TjJKL1c5cjdOVzd1dGJXUEwrNmtJWmFTUUM5Qi9zT0Mx?=
 =?utf-8?B?VnFVckEzeW80R2FDL0NkZ1VzclpVdmluMTdMUzFPT0Fxcjk0WHZWUzlsQmNh?=
 =?utf-8?B?NU5hLzE1UjlxdUJkSk1FdlVoUEZCZWZ4UWVPOFYxaDFuTTRvTS9kVUt0R3Uv?=
 =?utf-8?B?ekdSYjFlL0x5aU1idTVhV2QxUUZaSlM5QTVPdGQwMmtPUEJTcjRISkNGUjlI?=
 =?utf-8?B?K05QV3IyOW5BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG9WbDkvQ0lqWFBuMjdGbTY1T21YOGdmMXRhM05UbWUwRVNaQ2ZFWG9EdGJl?=
 =?utf-8?B?cnFSUVVZM3JDblRITVFJeWozVVV0UGR5TTBWZXg2aDVsS0tnRGpmbUJJV2hD?=
 =?utf-8?B?MzNzQWZDVUgyY0I2aDlIMFJnNFlXQ3BwcnlJeWoyZWRqV2oyakRFTjVuTXlM?=
 =?utf-8?B?MklkS0RlbVNmYW5zdk1KaTZFOWlRckNqUi92bU96bFVsdytYNXVjTWhidzB6?=
 =?utf-8?B?Q0VIWUx5cHNLUDAzMCtOa0dvdVhUUFJQZVN0VWNVUTROaWU2S1pNeDgxdk9Q?=
 =?utf-8?B?ZmNsT1JWSjBqUFJSSFdSUy9LYU1zdUdHRVlxaXFWcit4SlJqVXcvbS9YdGh0?=
 =?utf-8?B?ZGc0N21YQWNjNVZsU1BJc09ybEZwcnF2bU5hejZBZEFNckd5Tk54MytxVmE2?=
 =?utf-8?B?a1BUZmJUT0VDMGorUDBleE5pY0kvbDVrYzhsMk9BK0MwR0F4MHR4ZjdOcnFH?=
 =?utf-8?B?VG1VRzJvdjY2QXlCU0dCSUpZelExaytQa21RbEVQbng4bEVWUGNrYjM5RGJH?=
 =?utf-8?B?S2hKTGFlV2p4UGdsanB1MmpTS2ZsRkJidUVWK2xRTFZ0NXYwZnoxK3BkanJV?=
 =?utf-8?B?QnJOUnlDMlBOTFJGMXVyL1NveWFGcnBmQkFmY3JtY0ZJU1hJS0Y0S2MzdkNj?=
 =?utf-8?B?U3RmOXB1QnYrdnRkaUNHc28yaEdNVWFQa0R4dUpIUmprZWVGdmtSL2tVaHdq?=
 =?utf-8?B?aWMzRG5aWFY2TGJSZmdGaVJJYnJIR0FoVGxRaVIrOXE0YWp6b0RybW5ZOXM5?=
 =?utf-8?B?WWVXUGh5WWhIK3lJWkw2YzVkZ2oxZmhIZy92aUJ5MmpZWUNxS0xqNG1ORGRY?=
 =?utf-8?B?RGpNMS9GY1haeSs1MmhZR1JtOXZhV0hENlh3MmFuMTdLbkRJdnAyMVhUTjRW?=
 =?utf-8?B?RHQycnZvM3gxZjd2VGNLeG0zdFJFZUdLZUFlWk4rSCtQamlUWWdZczl6MW13?=
 =?utf-8?B?cU1PMjdlcTV1NHBVUUJrTnQ1d0prTmRMV0RpLzU0WXVPeC9Fejhyanp6K3dS?=
 =?utf-8?B?bnltK2pJaG80cE96TE5kWGhUUTRxWHVKM0dWRjNIOGgvaUQvYlQ5RW5Ic1BD?=
 =?utf-8?B?QUZOQlhjRnZtWk85TWFpSVlSOFZLSFZpbzNGNzJxbXVLd1ZESGNsd09URXJE?=
 =?utf-8?B?RHN6OTFsZytPLy9vRXVhb2ZvcWZTYVdBUnBtM2Npc0pjaFVibk1IZlJPaEtR?=
 =?utf-8?B?cENqZmdCUGgrMTdVS2FHaVBIWG5ZTXFXTnpQcVVtOTVoSXRQNFZTYzBkVE1o?=
 =?utf-8?B?a2FDTUJSZ0FlTGhzTFJjM0czT0FRY2VSQ1ZraEZROG0vSDY2WXVjV1B4bzgx?=
 =?utf-8?B?NTVRN0syTjhpVkRiM0gvNXpzcUpSK2l1T2ZuVU1FMEhrK0lrSjZXcDlqb24y?=
 =?utf-8?B?WldFQnN2d0REOG9rMzNlNmNkdW9wN1N6MlVoMnJRcXRWbE9Ia2hCbDl1RkhZ?=
 =?utf-8?B?ZE9naE0yeUwvNXQ1eFM5MHdaMXBHYmRWYlhOQzdQSjhnUEkrMHhDVll3WU56?=
 =?utf-8?B?REhWaXRPMWNKU0d3NHZncWIvMEVvWUZRcm0ycTFpQ0o4TnZCK1Q5OVBnSTRh?=
 =?utf-8?B?Z0dpaEk0bW1CVFBOOTEydy82RDM1dkc2SEhYL3RxbGVrVFBIQ0IxdVArbG9O?=
 =?utf-8?B?bVRDU0Z1K0VDbmo0U0ZpOTIvNHBSdGFRajFvb29rWXBjMlprS1VYQUhrWHZi?=
 =?utf-8?B?SkplM0cxeXp4N2ZkeUV5ckxpTHd2WHdINGhEVE9EenpYbkMrS3pFcmdZWkJL?=
 =?utf-8?B?ZkZLQ0wrVGJZVVhONW5EN2hzeWdzZ2FTa1FzSkthZE5PcllJeU5VMkU3OHV6?=
 =?utf-8?B?a3B2SXZUT1NZYzdwVi8yVzRDQnRpdTVqVkFiZDdDbkMzTUZjUVBYSFFPVXFC?=
 =?utf-8?B?MlI4bDhia2RHZllPWUZkMG1tdHpDTkhqWUxOUnE0MjZzS084VXpxWEp2OWVB?=
 =?utf-8?B?dXB5ZUVaQlBEOVRpVGhiSTJXSk5nTnRRMVBzZ2V2T2pZVmJDU0pVTVVWMHFL?=
 =?utf-8?B?bFRtNCtlQ2NDbTBvTnYzZTJJUHd4MTdvVGxGamRCUkIzdGlMcFFUYVdIdTNX?=
 =?utf-8?B?MjJERTA5Zjd5QW5KS2xRdDNod0hzMU9ZSFFjbkxhSjFHU2x0NmxyaVRJdnQx?=
 =?utf-8?Q?WKzFTWJWkCs+4RtLITSZ1zi8d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6866c7-6c6f-42e5-1916-08ddf4f974aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 08:17:19.7755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VQQ4AdVaLtiNxnBNHxZC0g/rGFrC2JCvPlnSf91CVjcrjj1aeAC7UpKUTZPlfr/IQG6n/mGuIXfFAOm74Bh8THX0KoNwSprHm77SjzP160=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6027
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMjEvMjFdIGludGVsX2lvbW11
OiBFbmFibGUgaG9zdCBkZXZpY2Ugd2hlbg0KPngtZmx0cz1vbiBpbiBzY2FsYWJsZSBtb2RlDQo+
DQo+T24gMjAyNS84LzIyIDE0OjQwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IE5vdyB0aGF0
IGFsbCBpbmZyYXN0cnVjdHVyZXMgb2Ygc3VwcG9ydGluZyBwYXNzdGhyb3VnaCBkZXZpY2UgcnVu
bmluZw0KPj4gd2l0aCBzdGFnZS0xIHRyYW5zbGF0aW9uIGFyZSB0aGVyZSwgZW5hYmxlIGl0IG5v
dy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDIgKysNCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IGY5
Y2IxM2U5NDUuLjA0YTQxMmQ0NjAgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTUyMjIsNiArNTIyMiw4
IEBAIHN0YXRpYyBib29sIHZ0ZF9jaGVja19oaW9kKEludGVsSU9NTVVTdGF0ZSAqcywNCj5WVERI
b3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kLA0KPj4gICAgICAgICAgICAgICAgICAgICAgIndoZW4g
eC1mbHRzPW9uIik7DQo+PiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICAgICAgfQ0KPj4g
Kw0KPj4gKyAgICByZXR1cm4gdHJ1ZTsNCj4+ICAgI2VuZGlmDQo+DQo+anVzdCB0byBlY2hvIGlm
IHRoaXMgc2VyaWVzIGRvZXMgbm90IHN1cHBvcnQgbm9uLXJpZF9wYXNpZCBQQVNJRHMsIHRoZW4N
Cj5mYWN0b3Igb3V0IHRoZSBjb25maWd1cmF0aW9uIHRoYXQgaGFzIGJvdGggeC1mbHRzPW9uIGFu
ZCB4LXBhc2lkLW1vZGU9b24uDQoNClRoaXMgbG9va3MgYW4gb3ZlcmtpbGwsIGltYWdpbmUgYSBx
ZW11IGNvbmZpZ3VyYXRpb24gd2l0aCBlbXVsYXRlZCBkZXZpY2VzDQpzdXBwb3J0aW5nIHBhc2lk
IGFuZCBwYXNzdGhyb3VnaCBkZXZpY2Ugbm90LCBldmVuIGlmIHdlIGFsbG93IGl0IHRvIHN0YXJ0
LA0KdGhlcmUgaXMgbm8gaXNzdWUgYXMgcGFzaWQgY2FwYWJpbGl0eSBpc24ndCBleHBvc2VkIHRv
IGd1ZXN0LiBJZiB3ZSBkb24ndCBhbGxvdyBpdCwNCnRoZSB3aG9sZSBxZW11IGZhaWxzIG91dC4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPj4NCj4+ICAgICAgIGVycm9yX3NldGcoZXJycCwg
Imhvc3QgSU9NTVUgaXMgaW5jb21wYXRpYmxlIHdpdGggc3RhZ2UtMQ0KPnRyYW5zbGF0aW9uIik7
DQo+DQo+VGhpcyBwYXRjaCBpdHNlbGYgbG9va3MgZ29vZCB0byBtZS4NCj4NCj5SZXZpZXdlZC1i
eTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo=

