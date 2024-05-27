Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D720EC25B7A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 03:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQrZ-0008Vf-Vn; Sun, 26 May 2024 23:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBQrT-0008RG-QM
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:17:25 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBQrO-0004oB-Nv
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716779839; x=1748315839;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=frIkkTKDDbV5fkQJw6wfbu4o/r1HxFMEqj/VZ2p8Zw4=;
 b=WGK6d0kzWQFZx84KM6i7EVu4phX9VPHnAhzRZOxlKutPf92cohl5QNad
 oHi17mGiefeJQFUFrNh9QBBC/tSQcJPL/Q0bSeKqo2wPMhi0DBLNPbjmy
 W1964Kc67GEBpARPf6E86aZF/TXLBuHNXoC3BUdjQdFRH0wNilOxNHT4a
 XmvJ4fi7p9lFq8LvM+DId9fugDCDJSE9mgcFJAbMy4zHP3ySsfZUYKckw
 jr5Vkvk1cFZ3liIQGJgbsykLhvZPGy/SuFkpF+Iawja5ZyFiDOa+Ut0V/
 tgfymd4kTPlK7qxyLcbOBIdKhB8LG39UKt636I26Xywlyo1EqPsH39l7T w==;
X-CSE-ConnectionGUID: 77SqyR5kQuyMjSLbMMTc4A==
X-CSE-MsgGUID: jGd2ztE0TyissIwf8jtIBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="38462915"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="38462915"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2024 20:17:18 -0700
X-CSE-ConnectionGUID: qcHItXi6SpyLy1CNKqNyOg==
X-CSE-MsgGUID: SMwcn7ENQail1I8ZTVNHdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="35113141"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 May 2024 20:17:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 20:17:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 20:17:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 20:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCVNHMI30TgfVCpI/O2ybr1aQ1EbOti92zSrxdLqeJUzzHj+XsYt9lF2nbk03vPje8qPEgb6SevCy9ocDA+rXBpRNOW0gSoA3/bli3k9t594pSzE/hFNwedkGwm8eoBbFT0dcSNyRk4ClYL+T/rSdb0aU7NKpIC4Biht0VHc3C7BxIfwgD5pyXlPzZL+co3PMB+ahzlrBK356Q3FLeLSbV0S72Ta5QgQGPwX446jEaL4je8Ag1nDcimqsSdAWuk9FNiV23SA5pXFx2hzsmbjspbvxoYsCCvgHwd2ueYqVj8Z84UsBR2ye2LUAbRQD4epCFN8Uh/1odpqIp9QeuuxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frIkkTKDDbV5fkQJw6wfbu4o/r1HxFMEqj/VZ2p8Zw4=;
 b=KazUM761usQIl/qwyfXI9GwH/mI+zY5e0+cnz3vW0mWkAvrg+QvM6wJA7ImdrdwQK5y+giT12qa8ABGyI+rnmQtlHJoYe/4fL7LDzv0wddeqD3NuKahOyvl2gbcmZpfCZKjODdaRfOZDUTroaS5u7M4V9X42JUlq99grAVdvBtj+YWdf3b/dmjtUDRI4xaH3NqGfZvVLbr98kSUdBBpSJR3mehY9/gtHNNn/synXIOJu3AgQuc5tBv8q4FPri7srdO8J1B+mtHOowvaRnt6lVM3Gx8MPSBVB49HswMo5Q22gTEHIjfD8tpyi96AK32tDIVuyCuqe7NVyUfZL5DcKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 03:17:14 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 03:17:14 +0000
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
Subject: RE: [PATCH rfcv2 06/17] intel_iommu: Implement stage-1 translation
Thread-Topic: [PATCH rfcv2 06/17] intel_iommu: Implement stage-1 translation
Thread-Index: AQHarBEHnUre0h+i2k+CWOyO2uuin7GmbIuAgAP0hRA=
Date: Mon, 27 May 2024 03:17:14 +0000
Message-ID: <SJ0PR11MB67440C01EE6847B5312467B192F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
 <20240522062313.453317-7-zhenzhong.duan@intel.com>
 <b6260c3f-0710-44ad-90e3-eb7931e751fa@eviden.com>
In-Reply-To: <b6260c3f-0710-44ad-90e3-eb7931e751fa@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6754:EE_
x-ms-office365-filtering-correlation-id: fb53ac99-f11a-4e70-bd3b-08dc7dfb81d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|376005|1800799015|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?TTBldXduNHhNS1l1QXgwQ0EybXVjcjc3dTR3bFRwK0x2UnF3Vk1sNmVodHdB?=
 =?utf-8?B?RzB1YlF6UlprdHZqWmowQjJuVUpCQUQvRzJMUzVrOFhtckJDYkNSVHV4bTRK?=
 =?utf-8?B?OTFvZVJvbk9ubEkzNlBjT0FDaHVPMWlPcG1yNXAzTUFUR0UrUlJvWlhJSGhL?=
 =?utf-8?B?SjBkSzdNZlBSbHQ0OTdIMWJvanBlMUN4NEhVSlZodFJ4d3UwWjFNQjdPQ1FX?=
 =?utf-8?B?dDlSQ1RlNGJibGZZTnh4cWlwdVNNNHpuNTE4WEsyRTlXdHBVdFNKYXZHRUVq?=
 =?utf-8?B?Q1dtQmhWS08rdmZaZ202ZU0xQ0h5WEVkWlZJVDIyZGhmTkF0ZUxKbHlOVERU?=
 =?utf-8?B?UkxBOVRldTlDeWEvSUVpa3FjNGN1RE45ZHgvSzBJYU8wc0tCMzBOcTY0Nm1P?=
 =?utf-8?B?WnZtRTBtRXRISWxmYW15OW1lSTRCd2FwT2FlNXpKb0tpdGdXQ3NWb2JXVlRY?=
 =?utf-8?B?WFpIcThWYzJhNzExYXRrQ1B2U1ozdFAzZTJBM3RPaVBicHh0QzdCUDE0cVJ3?=
 =?utf-8?B?Sit4WTVPREJ3NG1pOXZQbnZiK2VBc1BGbHVHZ3NwQ0lIVk1vOXFSd1NHTjVJ?=
 =?utf-8?B?UDJuVTROd2NwVzVtTnhkNGJhQlNUMXpaNEsvY3Eva3V3T0toR013YjJjOUQ2?=
 =?utf-8?B?ZmZzSGFvUFBmaDBzRkJBQzBOWGQvRXJHZCsxeHRVaVBXZEkrOVIxN3pNemhU?=
 =?utf-8?B?Q0NGbGlQYThnME1MN3RKdnNKMXh4dUI0dmV3T082aGIra2xteVZpL1hIcXpU?=
 =?utf-8?B?TWlWNXc2MTN1RHRjcjBhcS9EcTVCejJVU3lrYUs0T0g4NFptT0lSYTUyeXFo?=
 =?utf-8?B?TGdhcXdNUTFLbjJLOFlXK1Q2cVJwQi9KblViTGdTSUQyUjR4Z0hrUXF6eGI3?=
 =?utf-8?B?ZDFGa3BOZ3NQS01xaXlPa0Z2L1hsNnN3Q2puQnJyMWcwNWlBNkJXdEdJTVkw?=
 =?utf-8?B?cEVNbXNSUk5xS0NpcFFHajhsZXM2NWg3T0d6akxQWE1qMUZSWHAzOVZ0ZWpm?=
 =?utf-8?B?dUM5bmZoREZEYy9UY3QveTY1WkZiMENNS1E2MEtkaEJHaVZtS05vRlN1ME4y?=
 =?utf-8?B?Y3kwK001cnpDYW00LzB2VjdZdWNkckVTNklCOWkremRyMHlZRnlaSUFSeHdG?=
 =?utf-8?B?VkdQT0tpNWJsOTZZdTZRSkJsZnRUQXZMclRlcWY1TlpnSkxuNkR4L2V1b3pX?=
 =?utf-8?B?TURaQkdlYVphU1VmSFUvS3FKNnBoQVV3OGovdktId3p0MmlVdE1mNFU4Q3d2?=
 =?utf-8?B?MnNXU2tiVUhmOC9pbG1iNlBaT21sYlg3TVp0MTl6TTVxWHdnaGZFdXBFWndj?=
 =?utf-8?B?Q3NFSGNld2xadDIyK3EwUmlPVW4rRWRwMVhIWGhkTFBSTU5RZm9zN3VKUVc3?=
 =?utf-8?B?OEs2OWtaLzIzMEZaTlF3Tno3dkJOTTNmUlBReVlCYkFMQzRmR2NoN2N6Rita?=
 =?utf-8?B?NS90RmlPQXZPS1BNVmV0aWJwenJoY1h4VTRmdmdXYnFOaDVtb3VrR1JpNE1k?=
 =?utf-8?B?NUVDTHdWQ2xFVytHSzdOSjJPVnI4bjB4aWEvRXVVcm1sQU0zejR6d1d0TXZ2?=
 =?utf-8?B?Sk1XWWdRTGd4anRuZXdoc2thVTNGOWpySmpsU3IxWVhpZU9TeWswR3hFKzZn?=
 =?utf-8?B?NHBMMWFSeU9HaDBmd1YwT1haSzdXcnhoNHBQeU15cjRVVnN3TW8xckFLS1hJ?=
 =?utf-8?B?N2hJU1cvS3pJbDVQNGloQ2IzU1R2dXhCTVZ0eExTa29uNUdxRkNmQWRSaERP?=
 =?utf-8?B?R0RvRFl2SnJPSWk4SHBrQW9nT1QxaVFMb3pTdDNKWk5SaDFYVnU4R1FDUjVQ?=
 =?utf-8?B?WE5lOGl0WHdyWXhDQWRDUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3JScjduY0VpWXpncEUxZi9VL0FpSE85WnhNalV0NmN1QmxEaTg2UkY0c2Nz?=
 =?utf-8?B?Q25WcmttYUFIUSthTkorOVNsNGR0VU1Hc20yZXdUSnV3MmQ4bDZKcXc2WkFT?=
 =?utf-8?B?dHAwZ2l5MUdEMC94cVgvRnVmUEVXaFJKRUhSSUhrNDhTZG1FSVUzWVBhMEpP?=
 =?utf-8?B?WnNtQUhpWHpRWUxMb2xVd1JxTEM4WlhkOE5WalA2aUxNaStLYjBCc0ZMMER1?=
 =?utf-8?B?dmVFV3pyNTI2REZuUm9VNno0Y0I3RlpDSDloZVB4b1ZBdVFHaGZPd3RnR1U1?=
 =?utf-8?B?eW91YnFHZHdVaDFVSkZtL05Wb05ZSWR6a25QZjFVUkhXTjVTWW9tbnpWVjNO?=
 =?utf-8?B?TEc2djBsWlRkdmJwR1EyYjFCNlV3bklCSm9EQzM2NDdrMmxPdUdGdnp0L3h2?=
 =?utf-8?B?dzFiSDFvSjRoM1R6bU1xRlBRK3JLRUhSUmxnVlFKcUsvcnI4eWY0eU1UbDJh?=
 =?utf-8?B?alM5R3k1ZnFkRFlId1RCbXBwV3BaY0hwL0lJcEgvREhGNFNXL1cyRUt6QUgr?=
 =?utf-8?B?OG1vMDNoWTlPWFI0bmZYMzVHMTYzaWtybzFLSGhvV2Mxa1p3bjhMaU5EVm93?=
 =?utf-8?B?VCtBV1BIRFlNc3h4bFlCdjJaUkdhbU5iWnpXQmF6eUk5aCtrWStubGp0NlBE?=
 =?utf-8?B?dXdISk02bXR1UG9mdWQ4ZmxoeG5YcHZ2YXZJdUFwbzNNMmRhb2xmTUJWaGly?=
 =?utf-8?B?SkRtMkNLeDlUTk1xMXE1aExXL2NHVFJBSFZKREZsZVZMNG93cUpQWHB3c2pE?=
 =?utf-8?B?ZDlPUWRhZnB3Q2s0ZUljZE9QSUVQMFVlcHFvcEV0Z215ZVpWNC9pYldxNzh3?=
 =?utf-8?B?ZFk2di9DZGx1eVlEdEhGOWxYM01wbm9TZkNFWnRaWlE3M0R6MUc2dWd1Slp3?=
 =?utf-8?B?UllTMndIbVFPc09mcWVQSUFnUG9GV2txWnhWQTlRL1hyeCtyUUZuUGZ2eVJ1?=
 =?utf-8?B?ZmJxRXhocCt6WVBkb2J6RHAxUW9ibU0ya0xKand1Q2Y2V0ZMb2pVdE9IaTdt?=
 =?utf-8?B?UmxIdDhuOG1EWElEdThoM3JuVkZva1ZleXFBbEN4REZMc3NMMXp2Lzk3YWhD?=
 =?utf-8?B?Q01wUnJiZ0RLWmZpU0hvNFkvTGVVdXhZZkREV0hQQS8zMWh3ZGswd3lSZXJ5?=
 =?utf-8?B?RlppMmVUNDFLQTNxU1B2MGVKeHpXV01RTFBGVWx4NnEwSXJndnRWa2lHT0Rm?=
 =?utf-8?B?YmU0OVJTL1VjVlpDRmQ3OXVqcFYvUENOVmdMZzdTMEJHWC91SHcwQUxpUEdS?=
 =?utf-8?B?RTlvd2lnNFdrOHFHeVVLQWtnenplRnBwQzdaZFYwVGhpNjc5Y1QxaVhYTWhl?=
 =?utf-8?B?UnpuUDJzV21zSFhMN3JNU0Y1VTF6ZlhFQkRHdzFKMFJ1S0czZ0VkVUhMK3RB?=
 =?utf-8?B?d01qOHZCS2VVcjZ4bWZnL2Z3UnVNWU82ZkNWMytmYTl6SmE5cDVXLzdONmM2?=
 =?utf-8?B?YUxZem9OTEwyKzcrdXM4cHhBQ3luMXBSZ3lDOXlHVHlGOGxHZFpsZzBCMTJC?=
 =?utf-8?B?bkc0L0wzY3pwN0M5YVA4M0ZiWUcyUU9QRjJvaExDejNzdlV6SGhGOG9NbWRs?=
 =?utf-8?B?WjA2dEpzSmNpWFE0ZnhGQlNtZkNmYldyc29aS0FPS1lkT1ltSm5BdnpONnNy?=
 =?utf-8?B?Q0VWcnpaOVZ0S2l3TGlYbUFEbnBiM0ZMa2dwQkpoRXlTR1FMS2ZBMjk0dm1a?=
 =?utf-8?B?Uk1xYStRVnVTbHk3ejg2ODFsWjhPd28zMGRjazBNRnRMa09CNDJBYldDNDBQ?=
 =?utf-8?B?R0I4bFlGTmMxK1BZNnpORXVVVXVlSmxQWm9uaUZia2gyWmxVS3JwcUluQmc3?=
 =?utf-8?B?UERBQ1FvcFVIaHhyTG1KTkNRU3QxVmJZc3BJcVJJbnNHTzIycUVScjk4dStp?=
 =?utf-8?B?UllTVHEvR3dFTGtiRUNXL1FEd2lFQloyK1NGMDAvQ3F5SGthNGJOajBFazR5?=
 =?utf-8?B?RXJscy9IcjU4MUl3dWtpWTJlOHNzQlZCQ3pINTVPT0VzLzVOc3ZXUUEyMnQz?=
 =?utf-8?B?UjJlemRtWk94VDNrWnNkTEVvSHZUVHYwY0lQTE5JU09zMktzYW40SFJUY0ZT?=
 =?utf-8?B?WGdqYmJtMHg0SEdFc1JHVGNINEh5TEgyQlpCVHRJWFNBY2ludFZzYUhoU1dn?=
 =?utf-8?Q?KCgJaYKO2KtvIVTOQMDBoPGgx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb53ac99-f11a-4e70-bd3b-08dc7dfb81d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 03:17:14.7505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDFnXNQWG27u12OgcUP/XsAvT2iBbT/FO9SMJPZhsq+nktdd3Nhk4Gd/JTg91uKhdrg33OqYSV3wIAs+Uxj7sXZqG8XpvKO3Mk20Z197wkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCByZmN2MiAwNi8xN10gaW50ZWxfaW9tbXU6IEltcGxlbWVudCBzdGFnZS0xDQo+dHJhbnNs
YXRpb24NCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+SSBhbHJlYWR5IHNlbnQgeW91IG15IGNvbW1l
bnRzIGFib3V0IHRoaXMgcGF0Y2ggZWFybGllciAocXVlc3Rpb24gYWJvdXQNCj5jaGVja2luZyBw
Z3R0KSBidXQgaGVyZSBpcyBhIHN0eWxlIHJldmlldw0KPg0KPk9uIDIyLzA1LzIwMjQgMDg6MjMs
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5v
dCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0KPmVtYWlsIGNv
bWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+Pg0KPj4NCj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4NCj4+IFRo
aXMgYWRkcyBzdGFnZS0xIHBhZ2UgdGFibGUgd2Fsa2luZyB0byBzdXBwb3J0IHN0YWdlLTEgb25s
eQ0KPj4gdHJhbnNsdGlvbiBpbiBzY2FsYWJsZSBtb2Rlcm4gbW9kZS4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlp
IFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpo
b25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2
L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgMTcgKysrKysNCj4+ICAgaHcvaTM4Ni9pbnRlbF9p
b21tdS5jICAgICAgICAgIHwgMTI4DQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
DQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTQxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBpbmRleCAwZTI0MGQ2ZDU0Li5hYmZk
YmQ1ZjY1IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+
PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IEBAIC01MzQsNiArNTM0
LDIzIEBAIHR5cGVkZWYgc3RydWN0IFZURFJvb3RFbnRyeSBWVERSb290RW50cnk7DQo+PiAgICNk
ZWZpbmUgVlREX1NNX1BBU0lEX0VOVFJZX0FXICAgICAgICAgIDdVTEwgLyogQWRqdXN0ZWQgZ3Vl
c3QtDQo+YWRkcmVzcy13aWR0aCAqLw0KPj4gICAjZGVmaW5lIFZURF9TTV9QQVNJRF9FTlRSWV9E
SUQodmFsKSAgICAoKHZhbCkgJg0KPlZURF9ET01BSU5fSURfTUFTSykNCj4+DQo+PiArI2RlZmlu
ZSBWVERfU01fUEFTSURfRU5UUllfRkxQTSAgICAgICAgICAzVUxMDQo+PiArI2RlZmluZSBWVERf
U01fUEFTSURfRU5UUllfRkxQVFBUUiAgICAgICAofjB4ZmZmVUxMKQ0KPj4gKw0KPj4gKy8qIFBh
Z2luZyBTdHJ1Y3R1cmUgY29tbW9uICovDQo+PiArI2RlZmluZSBWVERfRkxfUFRfUEFHRV9TSVpF
X01BU0sgICAgKDFVTEwgPDwgNykNCj4+ICsvKiBCaXRzIHRvIGRlY2lkZSB0aGUgb2Zmc2V0IGZv
ciBlYWNoIGxldmVsICovDQo+PiArI2RlZmluZSBWVERfRkxfTEVWRUxfQklUUyAgICAgICAgICAg
OQ0KPj4gKw0KPj4gKy8qIEZpcnN0IExldmVsIFBhZ2luZyBTdHJ1Y3R1cmUgKi8NCj4+ICsjZGVm
aW5lIFZURF9GTF9QVF9MRVZFTCAgICAgICAgICAgICAxDQo+PiArI2RlZmluZSBWVERfRkxfUFRf
RU5UUllfTlIgICAgICAgICAgNTEyDQo+PiArDQo+PiArLyogTWFza3MgZm9yIEZpcnN0IExldmVs
IFBhZ2luZyBFbnRyeSAqLw0KPj4gKyNkZWZpbmUgVlREX0ZMX1JXX01BU0sgICAgICAgICAgICAg
ICgxVUxMIDw8IDEpDQo+PiArI2RlZmluZSBWVERfRkxfUFRfQkFTRV9BRERSX01BU0soYXcpICh+
KFZURF9QQUdFX1NJWkUgLSAxKSAmDQo+VlREX0hBV19NQVNLKGF3KSkNCj4+ICsjZGVmaW5lIFZU
RF9QQVNJRF9FTlRSWV9GUEQgICAgICAgICAoMVVMTCA8PCAxKSAvKiBGYXVsdCBQcm9jZXNzaW5n
DQo+RGlzYWJsZSAqLw0KPj4gKw0KPj4gICAvKiBTZWNvbmQgTGV2ZWwgUGFnZSBUcmFuc2xhdGlv
biBQb2ludGVyKi8NCj4+ICAgI2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfU0xQVFBUUiAgICAg
KH4weGZmZlVMTCkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCA1NDRlOGYwZTQwLi5jZjI5ODA5YmMxIDEw
MDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+IEBAIC01MCw2ICs1MCw4IEBADQo+PiAgIC8qIHBlIG9wZXJhdGlvbnMg
Ki8NCj4+ICAgI2RlZmluZSBWVERfUEVfR0VUX1RZUEUocGUpICgocGUpLT52YWxbMF0gJg0KPlZU
RF9TTV9QQVNJRF9FTlRSWV9QR1RUKQ0KPj4gICAjZGVmaW5lIFZURF9QRV9HRVRfTEVWRUwocGUp
ICgyICsgKCgocGUpLT52YWxbMF0gPj4gMikgJg0KPlZURF9TTV9QQVNJRF9FTlRSWV9BVykpDQo+
PiArI2RlZmluZSBWVERfUEVfR0VUX0ZMUFRfTEVWRUwocGUpIFwNCj4+ICsgICAgKDQgKyAoKChw
ZSktPnZhbFsyXSA+PiAyKSAmIFZURF9TTV9QQVNJRF9FTlRSWV9GTFBNKSkNCj4+DQo+PiAgIC8q
DQo+PiAgICAqIFBDSSBidXMgbnVtYmVyIChvciBTSUQpIGlzIG5vdCByZWxpYWJsZSBzaW5jZSB0
aGUgZGV2aWNlIGlzIHVzYXVsbHkNCj4+IEBAIC04MjMsNiArODI1LDExIEBAIHN0YXRpYyBpbnQN
Cj52dGRfZ2V0X3BlX2luX3Bhc2lkX2xlYWZfdGFibGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4g
ICAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlY7DQo+PiAg
ICAgICB9DQo+Pg0KPj4gKyAgICBpZiAocGd0dCA9PSBWVERfU01fUEFTSURfRU5UUllfRkxUICYm
DQo+PiArICAgICAgICBWVERfUEVfR0VUX0ZMUFRfTEVWRUwocGUpICE9IDQpIHsNCj5NYXliZSB5
b3UgY291bGQgYWRkIGEgZnVuY3Rpb24gdG8gY2hlY2sgaWYgdGhlIGxldmVsIGlzIHN1cHBvcnRl
ZC4NCj5BbmQgaXQgd291bGQgYWxzbyBiZSBuaWNlIHRvIHJlbmFtZSB2dGRfaXNfbGV2ZWxfc3Vw
cG9ydGVkICh1c2VkIGp1c3QNCj5hYm92ZSB0aGVzZSBsaW5lcykgdG8gbWFrZSBpdCBjbGVhciB0
aGF0IGl0J3Mgb25seSByZWxldmFudCBmb3Igc2Vjb25kDQo+bGV2ZWwgdHJhbnNsYXRpb25zIGFu
ZCBhdm9pZCBtaXN0YWtlcw0KDQpTdXJlLCB3aWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0K
DQo+PiArICAgICAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfRU5UUllfSU5WOw0K
Pj4gKyAgICB9DQo+PiArDQo+PiAgICAgICByZXR1cm4gMDsNCj4+ICAgfQ0KPj4NCj4+IEBAIC05
NTgsNyArOTY1LDExIEBAIHN0YXRpYyB1aW50MzJfdA0KPnZ0ZF9nZXRfaW92YV9sZXZlbChJbnRl
bElPTU1VU3RhdGUgKnMsDQo+Pg0KPj4gICAgICAgaWYgKHMtPnJvb3Rfc2NhbGFibGUpIHsNCj4+
ICAgICAgICAgICB2dGRfY2VfZ2V0X3JpZDJwYXNpZF9lbnRyeShzLCBjZSwgJnBlLCBwYXNpZCk7
DQo+PiAtICAgICAgICByZXR1cm4gVlREX1BFX0dFVF9MRVZFTCgmcGUpOw0KPj4gKyAgICAgICAg
aWYgKHMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAgICAgICAgIHJldHVybiBWVERfUEVf
R0VUX0ZMUFRfTEVWRUwoJnBlKTsNCj4+ICsgICAgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAg
ICAgcmV0dXJuIFZURF9QRV9HRVRfTEVWRUwoJnBlKTsNCj5zYW1lLCBjb3VsZCBiZSByZW5hbWVk
DQo+PiArICAgICAgICB9DQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAgcmV0dXJuIHZ0ZF9jZV9n
ZXRfbGV2ZWwoY2UpOw0KPj4gQEAgLTEwNDUsNyArMTA1NiwxMSBAQCBzdGF0aWMgZG1hX2FkZHJf
dA0KPnZ0ZF9nZXRfaW92YV9wZ3RibF9iYXNlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+DQo+PiAg
ICAgICBpZiAocy0+cm9vdF9zY2FsYWJsZSkgew0KPj4gICAgICAgICAgIHZ0ZF9jZV9nZXRfcmlk
MnBhc2lkX2VudHJ5KHMsIGNlLCAmcGUsIHBhc2lkKTsNCj4+IC0gICAgICAgIHJldHVybiBwZS52
YWxbMF0gJiBWVERfU01fUEFTSURfRU5UUllfU0xQVFBUUjsNCj4+ICsgICAgICAgIGlmIChzLT5z
Y2FsYWJsZV9tb2Rlcm4pIHsNCj4+ICsgICAgICAgICAgICByZXR1cm4gcGUudmFsWzJdICYgVlRE
X1NNX1BBU0lEX0VOVFJZX0ZMUFRQVFI7DQo+PiArICAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAg
ICAgICAgIHJldHVybiBwZS52YWxbMF0gJiBWVERfU01fUEFTSURfRU5UUllfU0xQVFBUUjsNCj4+
ICsgICAgICAgIH0NCj4+ICAgICAgIH0NCj4+DQo+PiAgICAgICByZXR1cm4gdnRkX2NlX2dldF9z
bHB0X2Jhc2UoY2UpOw0KPj4gQEAgLTE4NDcsNiArMTg2MiwxMDYgQEAgb3V0Og0KPj4gICAgICAg
dHJhY2VfdnRkX3B0X2VuYWJsZV9mYXN0X3BhdGgoc291cmNlX2lkLCBzdWNjZXNzKTsNCj4+ICAg
fQ0KPj4NCj4+ICsvKiBUaGUgc2hpZnQgb2YgYW4gYWRkciBmb3IgYSBjZXJ0YWluIGxldmVsIG9m
IHBhZ2luZyBzdHJ1Y3R1cmUgKi8NCj4+ICtzdGF0aWMgaW5saW5lIHVpbnQzMl90IHZ0ZF9mbHB0
X2xldmVsX3NoaWZ0KHVpbnQzMl90IGxldmVsKQ0KPj4gK3sNCj4+ICsgICAgYXNzZXJ0KGxldmVs
ICE9IDApOw0KPj4gKyAgICByZXR1cm4gVlREX1BBR0VfU0hJRlRfNEsgKyAobGV2ZWwgLSAxKSAq
IFZURF9GTF9MRVZFTF9CSVRTOw0KPj4gK30NCj4+ICsNCj4+ICsvKg0KPj4gKyAqIEdpdmVuIGFu
IGlvdmEgYW5kIHRoZSBsZXZlbCBvZiBwYWdpbmcgc3RydWN0dXJlLCByZXR1cm4gdGhlIG9mZnNl
dA0KPj4gKyAqIG9mIGN1cnJlbnQgbGV2ZWwuDQo+PiArICovDQo+PiArc3RhdGljIGlubGluZSB1
aW50MzJfdCB2dGRfaW92YV9mbF9sZXZlbF9vZmZzZXQodWludDY0X3QgaW92YSwgdWludDMyX3QN
Cj5sZXZlbCkNCj4+ICt7DQo+PiArICAgIHJldHVybiAoaW92YSA+PiB2dGRfZmxwdF9sZXZlbF9z
aGlmdChsZXZlbCkpICYNCj4+ICsgICAgICAgICAgICAoKDFVTEwgPDwgVlREX0ZMX0xFVkVMX0JJ
VFMpIC0gMSk7DQo+PiArfQ0KPj4gKw0KPj4gKy8qIEdldCB0aGUgY29udGVudCBvZiBhIGZscHRl
IGxvY2F0ZWQgaW4gQGJhc2VfYWRkcltAaW5kZXhdICovDQo+PiArc3RhdGljIHVpbnQ2NF90IHZ0
ZF9nZXRfZmxwdGUoZG1hX2FkZHJfdCBiYXNlX2FkZHIsIHVpbnQzMl90IGluZGV4KQ0KPj4gK3sN
Cj4+ICsgICAgdWludDY0X3QgZmxwdGU7DQo+PiArDQo+PiArICAgIGFzc2VydChpbmRleCA8IFZU
RF9GTF9QVF9FTlRSWV9OUik7DQo+PiArDQo+PiArICAgIGlmIChkbWFfbWVtb3J5X3JlYWQoJmFk
ZHJlc3Nfc3BhY2VfbWVtb3J5LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIGJhc2VfYWRk
ciArIGluZGV4ICogc2l6ZW9mKGZscHRlKSwgJmZscHRlLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVvZihmbHB0ZSksIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpKSB7DQo+PiArICAg
ICAgICBmbHB0ZSA9ICh1aW50NjRfdCktMTsNCj4+ICsgICAgICAgIHJldHVybiBmbHB0ZTsNCj4+
ICsgICAgfQ0KPj4gKyAgICBmbHB0ZSA9IGxlNjRfdG9fY3B1KGZscHRlKTsNCj4+ICsgICAgcmV0
dXJuIGZscHRlOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgdnRkX2ZscHRl
X3ByZXNlbnQodWludDY0X3QgZmxwdGUpDQo+PiArew0KPj4gKyAgICByZXR1cm4gISEoZmxwdGUg
JiAweDEpOw0KPlNob3VsZG4ndCB3ZSB1c2UgYSAjZGVmaW5lIGluc3RlYWQgb2YgaGFyZGNvZGlu
ZyB0aGUgbWFzaz8NCj4+ICt9DQo+PiArDQo+PiArLyogV2hldGhlciB0aGUgcHRlIGluZGljYXRl
cyB0aGUgYWRkcmVzcyBvZiB0aGUgcGFnZSBmcmFtZSAqLw0KPj4gK3N0YXRpYyBpbmxpbmUgYm9v
bCB2dGRfaXNfbGFzdF9mbHB0ZSh1aW50NjRfdCBmbHB0ZSwgdWludDMyX3QgbGV2ZWwpDQo+PiAr
ew0KPj4gKyAgICByZXR1cm4gbGV2ZWwgPT0gVlREX0ZMX1BUX0xFVkVMIHx8IChmbHB0ZSAmDQo+
VlREX0ZMX1BUX1BBR0VfU0laRV9NQVNLKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGlubGlu
ZSB1aW50NjRfdCB2dGRfZ2V0X2ZscHRlX2FkZHIodWludDY0X3QgZmxwdGUsIHVpbnQ4X3QgYXcp
DQo+PiArew0KPj4gKyAgICByZXR1cm4gZmxwdGUgJiBWVERfRkxfUFRfQkFTRV9BRERSX01BU0so
YXcpOw0KPj4gK30NCj4+ICsNCj4+ICsvKg0KPj4gKyAqIEdpdmVuIHRoZSBAaW92YSwgZ2V0IHJl
bGV2YW50IEBmbHB0ZXAuIEBmbHB0ZV9sZXZlbCB3aWxsIGJlIHRoZSBsYXN0DQo+bGV2ZWwNCj4+
ICsgKiBvZiB0aGUgdHJhbnNsYXRpb24sIGNhbiBiZSB1c2VkIGZvciBkZWNpZGluZyB0aGUgc2l6
ZSBvZiBsYXJnZSBwYWdlLg0KPj4gKyAqLw0KPj4gK3N0YXRpYyBpbnQgdnRkX2lvdmFfdG9fZmxw
dGUoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgaW92YSwgYm9vbCBpc193cml0ZSwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90ICpmbHB0ZXAsIHVpbnQzMl90ICpm
bHB0ZV9sZXZlbCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgKnJlYWRz
LCBib29sICp3cml0ZXMsIHVpbnQ4X3QgYXdfYml0cywNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQzMl90IHBhc2lkKQ0KPj4gK3sNCj4+ICsgICAgZG1hX2FkZHJfdCBhZGRy
ID0gdnRkX2dldF9pb3ZhX3BndGJsX2Jhc2UocywgY2UsIHBhc2lkKTsNCj4+ICsgICAgdWludDMy
X3QgbGV2ZWwgPSB2dGRfZ2V0X2lvdmFfbGV2ZWwocywgY2UsIHBhc2lkKTsNCj4+ICsgICAgdWlu
dDMyX3Qgb2Zmc2V0Ow0KPj4gKyAgICB1aW50NjRfdCBmbHB0ZTsNCj4+ICsNCj4+ICsgICAgd2hp
bGUgKHRydWUpIHsNCj4+ICsgICAgICAgIG9mZnNldCA9IHZ0ZF9pb3ZhX2ZsX2xldmVsX29mZnNl
dChpb3ZhLCBsZXZlbCk7DQo+PiArICAgICAgICBmbHB0ZSA9IHZ0ZF9nZXRfZmxwdGUoYWRkciwg
b2Zmc2V0KTsNCj4+ICsgICAgICAgIGlmIChmbHB0ZSA9PSAodWludDY0X3QpLTEpIHsNCj4+ICsg
ICAgICAgICAgICBpZiAobGV2ZWwgPT0gdnRkX2dldF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCkp
IHsNCj4+ICsgICAgICAgICAgICAgICAgLyogSW52YWxpZCBwcm9ncmFtbWluZyBvZiBjb250ZXh0
LWVudHJ5ICovDQo+PiArICAgICAgICAgICAgICAgIHJldHVybiAtVlREX0ZSX0NPTlRFWFRfRU5U
UllfSU5WOw0KPj4gKyAgICAgICAgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgICAgIHJl
dHVybiAtVlREX0ZSX1BBR0lOR19FTlRSWV9JTlY7DQo+PiArICAgICAgICAgICAgfQ0KPj4gKyAg
ICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgaWYgKCF2dGRfZmxwdGVfcHJlc2VudChmbHB0ZSkp
IHsNCj4+ICsgICAgICAgICAgICAqcmVhZHMgPSBmYWxzZTsNCj4+ICsgICAgICAgICAgICAqd3Jp
dGVzID0gZmFsc2U7DQo+PiArICAgICAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFHSU5HX0VOVFJZ
X0lOVjsNCj4+ICsgICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgICpyZWFkcyA9IHRydWU7DQo+
PiArICAgICAgICAqd3JpdGVzID0gKCp3cml0ZXMpICYmIChmbHB0ZSAmIFZURF9GTF9SV19NQVNL
KTsNCj4+ICsgICAgICAgIGlmIChpc193cml0ZSAmJiAhKGZscHRlICYgVlREX0ZMX1JXX01BU0sp
KSB7DQo+PiArICAgICAgICAgICAgcmV0dXJuIC1WVERfRlJfV1JJVEU7DQo+PiArICAgICAgICB9
DQo+PiArDQo+PiArICAgICAgICBpZiAodnRkX2lzX2xhc3RfZmxwdGUoZmxwdGUsIGxldmVsKSkg
ew0KPj4gKyAgICAgICAgICAgICpmbHB0ZXAgPSBmbHB0ZTsNCj4+ICsgICAgICAgICAgICAqZmxw
dGVfbGV2ZWwgPSBsZXZlbDsNCj4+ICsgICAgICAgICAgICByZXR1cm4gMDsNCj4+ICsgICAgICAg
IH0NCj4+ICsNCj4+ICsgICAgICAgIGFkZHIgPSB2dGRfZ2V0X2ZscHRlX2FkZHIoZmxwdGUsIGF3
X2JpdHMpOw0KPj4gKyAgICAgICAgbGV2ZWwtLTsNCj4+ICsgICAgfQ0KPj4gK30NCj4+ICsNCj4+
ICAgc3RhdGljIHZvaWQgdnRkX3JlcG9ydF9mYXVsdChJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGVyciwgYm9vbCBpc19mcGRfc2V0LA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IHNvdXJjZV9pZCwNCj4+
IEBAIC0xOTk1LDggKzIxMTAsMTMgQEAgc3RhdGljIGJvb2wNCj52dGRfZG9faW9tbXVfdHJhbnNs
YXRlKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBQQ0lCdXMgKmJ1cywNCj4+ICAgICAgICAgICB9
DQo+PiAgICAgICB9DQo+Pg0KPj4gLSAgICByZXRfZnIgPSB2dGRfaW92YV90b19zbHB0ZShzLCAm
Y2UsIGFkZHIsIGlzX3dyaXRlLCAmcHRlLCAmbGV2ZWwsDQo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZyZWFkcywgJndyaXRlcywgcy0+YXdfYml0cywgcGFzaWQpOw0KPj4gKyAg
ICBpZiAocy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiArICAgICAgICByZXRfZnIgPSB2dGRfaW92
YV90b19mbHB0ZShzLCAmY2UsIGFkZHIsIGlzX3dyaXRlLCAmcHRlLCAmbGV2ZWwsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcmVhZHMsICZ3cml0ZXMsIHMtPmF3X2Jp
dHMsIHBhc2lkKTsNCj4+ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIHJldF9mciA9IHZ0ZF9p
b3ZhX3RvX3NscHRlKHMsICZjZSwgYWRkciwgaXNfd3JpdGUsICZwdGUsICZsZXZlbCwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZyZWFkcywgJndyaXRlcywgcy0+YXdf
Yml0cywgcGFzaWQpOw0KPj4gKyAgICB9DQo+Pg0KPj4gICAgICAgaWYgKHJldF9mcikgew0KPj4g
ICAgICAgICAgIHZ0ZF9yZXBvcnRfZmF1bHQocywgLXJldF9mciwgaXNfZnBkX3NldCwgc291cmNl
X2lkLA0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCj4jY21kDQo=

