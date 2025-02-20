Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694B4C021AA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 01:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkvGU-0004j2-Kg; Wed, 19 Feb 2025 20:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tkvGT-0004iu-BX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 20:22:09 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tkvGP-0003PV-De
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 20:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740014525; x=1771550525;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9ahOK+1RBe/cmhujPCfAkRAbiSQ8pzCu12jTtnYIfOY=;
 b=wQ4DBJ/azeWPwNpl1HRo5/O0DiXAyGCtAxkCwCYVN47QfMGCj7L5FU/+
 a+nAW1xsPdla3e8iB+ACq1AxS5QOvdlKjqXTKuPUBhYLn9ALRhCZ8wlAc
 Fv4tY7NyTDuj6R9TqPUU+kkrKbm3SqV11pVjJo5HZa/bwfecnchKNq9Ia
 vwt72mFiLL/Clu3tCpM2h2RhTVd56VRlmMJcVbhFfU5s+UdQVVOFXeOhi
 hBQMMVXLL821y9EHT6mRvG9qLm1HjxcyFTsIB8OtKNZDnQp6x/E6oRnN/
 NuZZQff0Tfp/jl7EIusuT92JDw5AdO9hk0imEPX7MroUsvUw1fpyM9Q5o A==;
X-CSE-ConnectionGUID: XML59WXqRl6YsCBNxMdT8A==
X-CSE-MsgGUID: nVky7Dl1Qp2N2b1MWvusSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="146534595"
X-IronPort-AV: E=Sophos;i="6.13,300,1732546800"; d="scan'208";a="146534595"
Received: from mail-japanwestazlp17011027.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.27])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 10:21:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7Iozba9yhb/7+u3SHv6xkF7cYpuMtDRXqaCjSCucYYpwKf250sgZTZVsFY/AlIvyW2IuTKpmPLYfBLS6oHMZZTJhdpeQvmvMavPy7BrPdTIcBso//i8x2yHJaL78LA+fRLXFL4fdoqgK+FuN+TYZVc4IQJ0gM5tmoMsWMtu82dfvtyPb2oHcCiv5R0pEwNnorwXS2FU+Cf/gbMtsGmzznNpAqRJVR72AGfLu6Rn53AemZhFOYi/OsyYj+XzRMViRCrTZl2el0zK7LcLUNbcdmk4N5OA4P6OyrNVF7BnxpWSyMHY7O9Trah1gBpCs1+frRcK1EAuxkKvFj5CY3KCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ahOK+1RBe/cmhujPCfAkRAbiSQ8pzCu12jTtnYIfOY=;
 b=rsQKP08I2CrJtUTIjJXvRRfnSeP0fHBZT3Hen1wSHZjXhDrtMa8kush/rR+o5yfjt05b8KZ2ySrin4f894RKwoBANFOnjQM+RIYY+isyvR+H0LZ70/dGT2BnfExRWzjhih2Y5qFJ1wV7aD5qAHXHxCXX5mfQ3S6+j8lKQ8QfezUMmAjW9ZYvcM+zFSmx0MMCQ6XhDkrtOVsA9vS7gVlqo+ErpLBIkEez2ZZvl0Wrtx3hqOAfdZMUCEEUeakyMdXEYdgk8aJeh+sdRvWxCI1rnoXVq65pDurN5lKAo6YVSo9+uMVdViuWetJnvDzwEl4QpsUF1qMLkrh6YWoNnDX+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB8418.jpnprd01.prod.outlook.com (2603:1096:604:16d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 01:21:55 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 01:21:54 +0000
To: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>, Li Zhijian via <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] migration: Prioritize RDMA in ram_save_target_page()
Thread-Topic: [PATCH 1/2] migration: Prioritize RDMA in ram_save_target_page()
Thread-Index: AQHbgdim3piD2OfeG0S7XSsfy2LyW7NNhEEAgAAZ9oCAAMJ5gIAAPqiAgADImYA=
Date: Thu, 20 Feb 2025 01:21:53 +0000
Message-ID: <067918bf-2a9e-4f82-83f5-21c32b67d40b@fujitsu.com>
References: <20250218074345.638203-1-lizhijian@fujitsu.com>
 <8734gb9erz.fsf@suse.de> <Z7UDtxdNSS-Jqm-y@x1.local>
 <0930f197-ae7f-4920-bac8-838733683883@fujitsu.com>
 <Z7XbaXI4-fiVHYE7@x1.local>
In-Reply-To: <Z7XbaXI4-fiVHYE7@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB8418:EE_
x-ms-office365-filtering-correlation-id: 95ba87bf-762f-4f52-1a4f-08dd514cf5ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VHpNeTdwV2tpLzhaV2wySGhHL0hid3BsNnJOSWIrOTBEQURoS3FYbkpaZGky?=
 =?utf-8?B?Qnc4UTUxU3NORlE0N2RlKzBSckd2RlBSSmpBV2czY0NqQmNKV3V0aWEyWTh4?=
 =?utf-8?B?MVduUW1aaDBQZXkra1FkSVoxUndCN0M3cDlKZWQwVkNOc1FwKzZFUnN1d1RD?=
 =?utf-8?B?MHUxRk1nU3Ftb1VhK2drNjVlcXlWYmRkMkpVVURvQUw2cTFjWkZ4dHRNcEhk?=
 =?utf-8?B?K2d2SU1hbVRkd3Y0Z3ZuN0VaV3RKZVNyend3UXpncHZxVkhrZXNITmpWWS9R?=
 =?utf-8?B?MnV5ODdmOHNRVlYwK1VvRlVyc2w1NmlmekYrcDdqWUNMdlZTOVd2SEpwY0xn?=
 =?utf-8?B?UitQdE54U0kvcCtlTW1HK1VQbnJ1RjJrK082RHI4aHVvQlhheFp0SEp1Q294?=
 =?utf-8?B?dGpZclU4dGFHazFzTThqL1Z5N2kzQzNLVEtpYjNLQ28yK3ZaWG1Fb0JqVmYx?=
 =?utf-8?B?cGdxVTNSV056WUFSOGRTVWtrc01DckJUcHpIWmNFd3JZNy9qVXdCRHNpSEp6?=
 =?utf-8?B?eG5lbmRsVjJHS0RqbDRrTVc3d3p2eXJ1aTMvNFFOUlFsajZjbXZ4ZmtyUDFu?=
 =?utf-8?B?aUhaNkx5YnduRzA2ZG91b3gwWmhoTDdHMXBTREN5NW5IeG1KNU9rYXN6NVdC?=
 =?utf-8?B?V3QrajJMZUJ1aVpSUzEydEx2T2psSHBweUI0T1kreFVMT0ljUmFPS2ZKZUZT?=
 =?utf-8?B?b2E2Q2tVMkFmUVRIbEY2TlZUZFlBMGpsL2JXYm1JUll1TUoyQ1pCcUtXamkr?=
 =?utf-8?B?MXl0UUVOQXdtWFpNdzBQRldMVm1ralNDZjJMSmlFUVFRSXAreUs2dmZiSVg2?=
 =?utf-8?B?QTFNRXpiTzV1Mi92bVVZa3Y4a1BOcTVVS3YwZjhGazZqZTdzekZidUlTcGtW?=
 =?utf-8?B?T3cyd1QwKzlPdmZiQ2tsUHFQUGtDMTljeGVoYnh4dEFlTWY5ZSszWmhXajIw?=
 =?utf-8?B?UjN6K0R2bzZ3cWJHUUZNU21sQlBrSTNqdTRhVHJsQmNLcDY0WHBHN1Q5UW5i?=
 =?utf-8?B?T2hxd1ppY0ZsRHNLRnBSaDVvRlZBbjRheTRWb1c3NEFsQXUyZFhjRkJEVkZn?=
 =?utf-8?B?by9OZy9iWEdheVdkT0h1S2h2dDg4Zk9NQXJGR3pvTzdmZ3dTQktQWHBGWGJJ?=
 =?utf-8?B?SUFuaFhrWlliaHpRUDlCem9oU3REemxPWDNwMmdMRTBLYWloMytOemFBN0hk?=
 =?utf-8?B?N3NIQ0JWMXo5T0FOcnZOTU5mSkFPcTNSRFBzMkNadHVCczJURzVZMFVKaWF6?=
 =?utf-8?B?TlFGQTVIaFR3THRVbXkxSW0vM1ZEN0dmemY3NWs5Z2pVZm1UODlhRS82bTBF?=
 =?utf-8?B?VmRGVitWYmNTNnp2RkExcGNPNGFmTHZoUk1DcXNHNmIvSitCRUVERGpkQ3hN?=
 =?utf-8?B?WHpnQVY0VGMxQ2RpVUsxSTVuaXROSktXWTJyQmwrNW5vY0RENDA2ODhXRm1T?=
 =?utf-8?B?YklMa3lIc3BYRWhBZGR4MDVMczlWb3ArR2UrQjRJT0xCem5jZHJkTVBEZmxv?=
 =?utf-8?B?L25BckpJWnNmQW9MVTFVMU40ODJlQXhjc2dremR3dklwTEw3Wlh3V2FWTFRG?=
 =?utf-8?B?akJydVorZE5VbDROb1E1b1QwdzZmSzk2SmZpNUdvU2RucG5PS2dFbDh0K1k0?=
 =?utf-8?B?eXBCRmlCWFhMN0IzdzVZWDYvNUkyVlFSZEVGWGs4dC92UEhpRFNFRVAyeDcx?=
 =?utf-8?B?TDhTTkRhREplN25wWVZmTXl3YURwUm54b2piWlZna05nY09pYml1Rkw2T1Mv?=
 =?utf-8?B?WkZkSUtkLzQ3OU1ZeGtia2FnOTNOOFVlYTVqM0FMa1FXQmg4ZkdMSUZQbFY3?=
 =?utf-8?B?cjZqempHZHo1ZGNqN2xYQTBpWFJlbW1WWGZXaytIVXpLY2lyekZmS3h1MlU5?=
 =?utf-8?B?b2VPcEx1d2ZPMUM5M0poeWlCME5WakNGQ1FjYVN2NmNtSVpJdDF0T2lPbjlP?=
 =?utf-8?B?SXVZZDYxNUZXd3FEdjVoL1BwaTdHU001dm1MVEhEaTJUbXhsUnN3ZTFqT2RI?=
 =?utf-8?B?aFltNmx5WlVBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OG9DYm5RajQ0Wi9COU1NVFdEVS9mQkpJUFRJVWNhVTB6WjJadVVwTHp4bVc3?=
 =?utf-8?B?UDNuQytDN1VoUzVXZ0FIbUh2WUxENDhqYjkwOS8ySGRQRUFmdyszVldYd3VX?=
 =?utf-8?B?QlB3VWlpQzUvNDVVNW1OVlRJdkZKWXJxRTYwMTJrV1VOR3ZsTUZhRzlxWUxx?=
 =?utf-8?B?T3YzQmQ1eGdqYSswNkpaSk1ZNjhESC8yN3lJWWMvdUVaWDkvaGRKeGdNaHZj?=
 =?utf-8?B?cXJZN0JPQ29TREtubnBEYkdOWGkwblEwcjZCVnFEY29WbGV4bFBZdUtSUUhR?=
 =?utf-8?B?OTlSeU92NVMxTStFR2E1bE5TUXdhNmppRmhDbGdEMkRNVmRqRmZTRUtXaE9p?=
 =?utf-8?B?bVpPZ3l1cVlNZjh5R2cvVldPd2hhenRzY3FBSWI4aUU2bGdKWE1WMTFRUnQv?=
 =?utf-8?B?TWdOWVdKQ2lGUFBiaWVQTnpFZHFVWUN3OWZ1MlBpZ3kzemkxSEFIT1ZxekZz?=
 =?utf-8?B?YnlwOUZianFHZlljY2RhTU9oaUNRRU94SE42YjFBaTRyRDFQQW53SlVWT2hj?=
 =?utf-8?B?TW4rZFgwRERZUExsZHVNaGdqU2M2RU9taW13dWorN3Z1cllIdWJXQUw5SXhF?=
 =?utf-8?B?MnBpMlcyc2hPRk95OXVtNllQRkpCZEU0cnVpR0lISTRPSktHRVZSTmhhUXlY?=
 =?utf-8?B?UWtGdi85TitUU0V4TjlPZnNZMVR4dkNHUHJqOUVRRWsxRXdkNlQvZEp2amVH?=
 =?utf-8?B?bWFlK0JkaW1KSGltYjFxTFVmTnltSWtYQkVHUlFFV2VRYnUrWWU2TklYMmo1?=
 =?utf-8?B?RVdad1BjODZESVZic3NIT2VOM1B2UTZDU1h1cWxIQnhQMDZyM05BY2g5Um9H?=
 =?utf-8?B?WTdBaW96dG14OU5XOEk1d0tYNVB1QjlzUkd4WFFiSi83ZWZRVnRYKyt3cUFL?=
 =?utf-8?B?VEQ0U1pwTEs0eTVzcHR4TnlsWnpZallUcnF0QzlTUTNxQlEyMERzTkR5WVpp?=
 =?utf-8?B?WmJyLzFvYW9sdkpic08zV2dPWmFnUUxwR3YzYm9YcC9ZOTRRb1FaNjlnOGRW?=
 =?utf-8?B?N0dwbndyWHIrUGRId3hlZ2svL2lWQkxsOG9DcysyTFBhcFhONHkvbWtad3VP?=
 =?utf-8?B?ZnJvK3lwRGlEdSszcit1VlhSaVJjZ0NCbzhpMGlBcVJTV21nd2dUZWdzakhR?=
 =?utf-8?B?dGx6d1poTkdzVlh4ckdYZkxncnhoVEhNQmorWWtsdlBaV1RGY2JiZ3FMN2h6?=
 =?utf-8?B?VnZFbW04cFdZZVJQeVZLcDZrWGJLZFUvWmFGR1JjL0pHN0dBTG5PRmJuQVVs?=
 =?utf-8?B?S09VckxWbEZRb3ZTdFphZElxNFZ3ampzVm1qTW56MU4xc1dXTjllUUk0Rm8v?=
 =?utf-8?B?ZVUvSjU0TXMwZXVDNWJJK0EzK2hSS0hsZU9qQW9PWGNCQXpPN1JzOXhhNkZM?=
 =?utf-8?B?T29EWWhaOG5UUUlHN3MrSk9hZTMyK3NadlBsTTlyWEIvZlBYU3lLVHJpdno3?=
 =?utf-8?B?RFNCOUxiQ1JkM3JIYmp4NDVmMi9UVGsvS0UrRU1kbmxzcHF5U0xjQlRjTmsv?=
 =?utf-8?B?L2hpTEt6M2t6RkUzZlBNNlZyWkUweWtXVG9nWGNWd291T292ZFZXVW10YllM?=
 =?utf-8?B?OFhxQXplbWVlY3hJamhjWk40NmVpQzJMQU5RY2liN2pkaklrMTdoelNoZ3J0?=
 =?utf-8?B?dmFPOXNCdHhkdTVGeHZKcndobzBFWkIzWHVFdmh1OXpJMm05bVhIU1REU3Ix?=
 =?utf-8?B?Y1Z2U2hUNFg1V3NqTzBtUGRVRjNxdEdQRUFUMXV4MjBxK0pGdnIwSWpTZVYv?=
 =?utf-8?B?K1NaWm1RNnQ2em5LeWZVakVBZUUxWlBKeGVPdU12cUJQeWVUUkZpMktxS0E1?=
 =?utf-8?B?b2JCdlVqTjVmM1VvNkdnME5yM3RNRUJVSzl0OURsR1JCWGJLakJORzNGSW93?=
 =?utf-8?B?YnFBbDMySlVaeDdJYmJLb2ZOdUFWVFR5QmpGeis4RWNXVE12YWpHTGhEWk0y?=
 =?utf-8?B?WU5BSjlJdTUzWW00c3pwNXQ1YkZiWVp3Vjg5NEQ5UjVkOGdMbm5KODJiSlJU?=
 =?utf-8?B?MmxLQld1d3Nhd01QUzhzWlRTdEZVZEllcVJxWnhzR3BXNStOVHIzNXNiczZt?=
 =?utf-8?B?QU5RRGZMMUhBYzM4WlBhMkxrODE2KzVGR1Z4SVAwa3JuZUlwN3JFSXQ4M0VY?=
 =?utf-8?B?dVppSjNrQzRYR3ZmVDU3ME1oRGJxdGxKbDB6cVdtbnhEM1d5UjFUU1kyRzBx?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71818FE685101D46B6CF9AA4875E69B9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tp85u9C6CFxBzXX4IkKWNp9+kze8cpJBlnR0MBe3Xeu9n6oyv3ut4oNKM0+cCQbQscOQE/oBrEGrOUYw2BSqiJVmkXuQ8fj2QFpIMRPW6Ddqs9993e8/uJDCesBDS1JAoewHHRROLZju+BeYg4+7hch7CXbx+SCiNMK9DChWD/h1FoAn3cTBEpakkH31VYuMrN8B7UTKyY5v0UsSdqGIcqHwFk4SfM51+jxJpDy/HtxTGnqqcWWB3ze+7KjDvk+vPbdyL7qmxiToO6f8uNtK2udDaD7qYYEjyHWXiJ5O20bEfgXIx76J2rOETbGiJ7iap3+fsCFqj8l9QQvtExf9WMKIT8umcCE3NFeOf/12LSBCxUMjUSppnkYr+ufcaP2k/enDAX6VlsdM6LOhVEV7xbH2z0WLxNZdGRGQRmQ6SHlfpDqfwiScDWJVlNh/3LzaEcreuBf0JWR86Q4wHvqvgPoFUlwKINh7ylah6x9uSuWeCu0MJ9AbrCq1U3HSNwT0T7269ZnQMyT/G6EJ4HRBp/cnvZkIOHgUVJt8mwgDu0LkIDch4GxMYeGrb2IgYFtx4/6kVy+fYrgNGeZm4TCmA4AzfyuTNmgybAjGGcVSAbvUZACmyWApd1fk23lrMsPn
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ba87bf-762f-4f52-1a4f-08dd514cf5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 01:21:53.8884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRLa5rBNziUStft/dj96ITLf1AfKVSNQsvXqapwIN6GZgulYSs5AlDThr8uLCK8ypvZwh5f53Uy5CUq2AgNg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8418
Received-SPF: pass client-ip=68.232.156.101;
 envelope-from=lizhijian@fujitsu.com; helo=esa14.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDE5LzAyLzIwMjUgMjE6MjMsIFBldGVyIFh1IHdyb3RlOg0KPj4gSSB0cmllZCB0byBr
aWxsIFJBTV9TQVZFX0NPTlRST0xfTk9UX1NVUFAsIGJ1dCBJdCBzZWVtcyBpdCBkb2Vzbid0IG5l
ZWQgdG8gdG91Y2ggYW55IHBvc3Rjb3B5IGxvZ2ljDQo+PiAiaW4gdGhlIFFNUCBtaWdyYXRlIC8g
bWlncmF0ZV9pbmNvbWluZyBjbWQsIGF0IG1pZ3JhdGlvbl9jaGFubmVsc19hbmRfdHJhbnNwb3J0
X2NvbXBhdGlibGUoKSINCj4+DQo+PiBJcyB0aGVyZSBzb21ldGhpbmcgSSBtaWdodCBoYXZlIG92
ZXJsb29rZWQ/DQo+IFllcyBpdCBsb29rcyBhbG1vc3QgZ29vZC4gIFdoYXQgSSBtZWFudCBpcyAo
cGxlYXNlIHNlZSBiZWxvdyk6DQo+IA0KPj4gQSB3aG9sZSBkcmFmdCBkaWZmIHdvdWxkIGJlIGxp
a2UgYmVsb3c6DQo+PiBJdCBpbmNsdWRlcyAzIHBhcnRzOg0KPj4NCj4+IG1pZ3JhdGlvbi9yZG1h
OiBSZW1vdmUgdW5uZWNlc3NhcnkgUkFNX1NBVkVfQ09OVFJPTF9OT1RfU1VQUCBjaGVjayBpbiBy
ZG1hX2NvbnRyb2xfc2F2ZV9wYWdlKCkNCj4+IG1pZ3JhdGlvbjoga2lsbCBSQU1fU0FWRV9DT05U
Uk9MX05PVF9TVVBQDQo+PiBtaWdyYXRpb246IG9wZW4gY29udHJvbF9zYXZlX3BhZ2UoKSB0byBy
YW1fc2F2ZV90YXJnZXRfcGFnZSgpDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yYW0u
YyBiL21pZ3JhdGlvbi9yYW0uYw0KPj4gaW5kZXggNTg5YjY1MDVlYjIuLmZjNmE5NjRmZDY0IDEw
MDY0NA0KPj4gLS0tIGEvbWlncmF0aW9uL3JhbS5jDQo+PiArKysgYi9taWdyYXRpb24vcmFtLmMN
Cj4+IEBAIC0xMTQzLDMyICsxMTQzLDYgQEAgc3RhdGljIGludCBzYXZlX3plcm9fcGFnZShSQU1T
dGF0ZSAqcnMsIFBhZ2VTZWFyY2hTdGF0dXMgKnBzcywNCj4+ICAgICAgICByZXR1cm4gbGVuOw0K
Pj4gICAgfQ0KPj4gICAgDQo+PiAtLyoNCj4+IC0gKiBAcGFnZXM6IHRoZSBudW1iZXIgb2YgcGFn
ZXMgd3JpdHRlbiBieSB0aGUgY29udHJvbCBwYXRoLA0KPj4gLSAqICAgICAgICA8IDAgLSBlcnJv
cg0KPj4gLSAqICAgICAgICA+IDAgLSBudW1iZXIgb2YgcGFnZXMgd3JpdHRlbg0KPj4gLSAqDQo+
PiAtICogUmV0dXJuIHRydWUgaWYgdGhlIHBhZ2VzIGhhcyBiZWVuIHNhdmVkLCBvdGhlcndpc2Ug
ZmFsc2UgaXMgcmV0dXJuZWQuDQo+PiAtICovDQo+PiAtc3RhdGljIGJvb2wgY29udHJvbF9zYXZl
X3BhZ2UoUGFnZVNlYXJjaFN0YXR1cyAqcHNzLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJhbV9hZGRyX3Qgb2Zmc2V0LCBpbnQgKnBhZ2VzKQ0KPj4gLXsNCj4+IC0gICAgaW50
IHJldDsNCj4+IC0NCj4+IC0gICAgcmV0ID0gcmRtYV9jb250cm9sX3NhdmVfcGFnZShwc3MtPnBz
c19jaGFubmVsLCBwc3MtPmJsb2NrLT5vZmZzZXQsIG9mZnNldCwNCj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBUQVJHRVRfUEFHRV9TSVpFKTsNCj4+IC0gICAgaWYgKHJldCA9
PSBSQU1fU0FWRV9DT05UUk9MX05PVF9TVVBQKSB7DQo+PiAtICAgICAgICByZXR1cm4gZmFsc2U7
DQo+PiAtICAgIH0NCj4+IC0NCj4+IC0gICAgaWYgKHJldCA9PSBSQU1fU0FWRV9DT05UUk9MX0RF
TEFZRUQpIHsNCj4+IC0gICAgICAgICpwYWdlcyA9IDE7DQo+PiAtICAgICAgICByZXR1cm4gdHJ1
ZTsNCj4+IC0gICAgfQ0KPj4gLSAgICAqcGFnZXMgPSByZXQ7DQo+PiAtICAgIHJldHVybiB0cnVl
Ow0KPj4gLX0NCj4+IC0NCj4+ICAgIC8qDQo+PiAgICAgKiBkaXJlY3RseSBzZW5kIHRoZSBwYWdl
IHRvIHRoZSBzdHJlYW0NCj4+ICAgICAqDQo+PiBAQCAtMTk2NCw2ICsxOTM4LDE2IEBAIHN0YXRp
YyBpbnQgcmFtX3NhdmVfdGFyZ2V0X3BhZ2UoUkFNU3RhdGUgKnJzLCBQYWdlU2VhcmNoU3RhdHVz
ICpwc3MpDQo+PiAgICAgICAgcmFtX2FkZHJfdCBvZmZzZXQgPSAoKHJhbV9hZGRyX3QpcHNzLT5w
YWdlKSA8PCBUQVJHRVRfUEFHRV9CSVRTOw0KPj4gICAgICAgIGludCByZXM7DQo+PiAgICANCj4+
ICsgICAgaWYgKG1pZ3JhdGVfcmRtYSgpICYmICFtaWdyYXRpb25faW5fcG9zdGNvcHkoKSkgew0K
PiBIZXJlIGluc3RlYWQgb2YgYnlwYXNzaW5nIHBvc3Rjb3B5LCB3ZSBzaG91bGQgZmFpbCB0aGUg
bWlncmF0ZSBjbWQgZWFybHkgaWYNCj4gcG9zdGNvcHkgZXZlciBlbmFibGVkOg0KPiANCj4gZGlm
ZiAtLWdpdCBhL21pZ3JhdGlvbi9taWdyYXRpb24uYyBiL21pZ3JhdGlvbi9taWdyYXRpb24uYw0K
PiBpbmRleCA4NjJmNDY5ZWE3Li4zYTgyZTcxNDM3IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24v
bWlncmF0aW9uLmMNCj4gKysrIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQo+IEBAIC0yNTcsNiAr
MjU3LDEyIEBAIG1pZ3JhdGlvbl9jaGFubmVsc19hbmRfdHJhbnNwb3J0X2NvbXBhdGlibGUoTWln
cmF0aW9uQWRkcmVzcyAqYWRkciwNCj4gICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICAg
fQ0KPiAgIA0KPiArICAgIGlmIChhZGRyLT50cmFuc3BvcnQgPT0gTUlHUkFUSU9OX0FERFJFU1Nf
VFlQRV9GSUxFICYmDQo+ICsgICAgICAgIG1pZ3JhdGVfcG9zdGNvcHlfcmFtKCkpIHsNCg0KSSB0
aGluayB0aGVyZSBpcyBhIHR5cG8NCnMvTUlHUkFUSU9OX0FERFJFU1NfVFlQRV9GSUxFL01JR1JB
VElPTl9BRERSRVNTX1RZUEVfUkRNQQ0KDQoNCj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAi
UkRNQSBtaWdyYXRpb24gZG9lc24ndCBzdXBwb3J0IHBvc3Rjb3B5Iik7DQoNCklJVUMsIHlvdXIg
Y2hhbmdlIG1lYW5zIFJETUEgKyBwb3N0Y29weSBpcyBubyBsb25nZXIgc3VwcG9ydGVkLiBJIGRp
ZG4ndCByZWFsaXplIHRoaXMgYmVmb3JlLg0KQWRkaXRpb25hbGx5LCB3ZSBtaWdodCBjb25zaWRl
ciBlbGltaW5hdGluZyBhbGwgcmVtYWluaW5nIGBtaWdyYXRpb25faW5fcG9zdGNvcHkoKWAgY29u
ZGl0aW9ucyBpbiB0aGUgY3VycmVudCBgcmRtYS5jYCBmaWxlLg0KDQpUaGFua3MNClpoaWppYW4N
Cg0KPiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgIHJldHVy
biB0cnVlOw0KPiAgIH0=

