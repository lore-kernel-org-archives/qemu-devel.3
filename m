Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A623ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 03:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v74Db-0001F3-GQ; Thu, 09 Oct 2025 23:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v74DY-0001Eu-OL
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:54:57 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v74DT-0000TU-UU
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760068492; x=1791604492;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=d4IBgK1hlXm/newtMKIcFkn/Ix8EauiFVL57BXXSGb0=;
 b=l0x7TnyhMqBg5JxH/hB7LEMXWX6ZYRiqaYurqnyZZybVeEwlE5bc8ZfY
 uMqS7G7kIiIoyRDNXGpksDqXhVdvwad7gHUJGbJtfS4kpvqIlmZSaDHR+
 lSyhyy43Eo5u9xmD0jNunzSwCR/Vr7gR7tFgXn+1BnaLIVW1++uB4gm1+
 yJuA1y74r1szDegK3giRBv2xFoKlUoYV6xIblcImGHWR421E1OO+q0RjK
 K67bhWvTQxCeonb2WYMZddGB4mZg9AOnH15mYoXlQ4AaC1j2CeV2ebVxz
 rzgKwyBdmE2hZad/JXCxAMi6MysPVIpnsDqxAgl9FRSftjr8IafwgL5T6 A==;
X-CSE-ConnectionGUID: 2k1sd5zxTFSEzXl7WqvImw==
X-CSE-MsgGUID: K/VY1qmLRBmchUqFlIT3AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="64909073"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208";a="64909073"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 20:54:46 -0700
X-CSE-ConnectionGUID: gYZwlawaSJSH5FacWDU1KA==
X-CSE-MsgGUID: 281aNoOBTNezToI6YjVE3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208";a="211834595"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 20:54:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 20:54:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 20:54:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 20:54:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjN7aOX25ktCx2v5/SxkdzqSk3JBgyL4deUx8s87Vk7gRrot+jfwfo7MR+hyxCOCBVJV0jRhJAKUWnYM/jHwsXBerpZJulIXOBjySN2WobmXHHmRi124ScNvNC3Dwzmd2q11pYu/UvOY25onssev4ehJSuylRvAm1+Afa1pClENDtzrX/+1rZXJG0FwQBBov1Om4gMeNBq73xEufFqf097nW8ZSqqwApLHCk7LMGMoW/5TxL1VnrzI3WGZdMqADW2ZqlBVyI+WzWMqNO5JHdEla3epP+YfibRw4BXao57SwGdeO3wC3a25lLugWXg6pD3GS6EWSgM9igOkUnbyImDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4IBgK1hlXm/newtMKIcFkn/Ix8EauiFVL57BXXSGb0=;
 b=nQ4HPom58kTJGxivC+y/jgEZIKJLiiOvjLE/mgCppJPR8RA98ZwdE6Ss0YapqjpG8N+/dH3v3LIldSqmmUfCfgU9uEDqe4Hem65XoQhKI5OOjSZhnBA1EOtqyX1Ssq3nNn77ev5XMDLdndaEnEv496+AYEi6Yj7VCVe0VJUfco9t9aTSD7EREH623ZhgkQSqnYPevQQeYqH4Uzk44LcpEfem09QIbsMRmQNF6IuMPRSAi3eVC0Lut9b2uRI2gwFOBsxjoXwEwxGJwah+fBySPAvUQkxtygcImuuvWZi3/3RVseAOYAxGVwqYVbCqCExRLhiMsEFJ1ujo1OdiEklYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB6820.namprd11.prod.outlook.com (2603:10b6:930:60::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 03:54:43 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Fri, 10 Oct 2025
 03:54:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Steven
 Sistare" <steven.sistare@oracle.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>
Subject: RE: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Thread-Topic: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Thread-Index: AQHcMFWngtFRdKHVOkWcXMje/gJxi7SqMJYAgADkn4CAAJxjAIAHrvKAgAaL8oCAAAJpAIAAA4oAgAABMoCAANcd0A==
Date: Fri, 10 Oct 2025 03:54:42 +0000
Message-ID: <IA3PR11MB9136738C2CE19566F4543DFE92EFA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
 <20250928085432.40107-7-zhenzhong.duan@intel.com>
 <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
 <IA3PR11MB913635F06F6522102D8FC15D921AA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <78df77e2-43a6-48d6-b09e-fcc61a662b6e@oracle.com>
 <IA3PR11MB9136EF2C01DAB2C2EA261CC092E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ab688cce-283d-4541-b7ca-be651085979e@oracle.com>
 <aOfEiogVQiAhBqMG@redhat.com>
 <2ac44a27-d4f2-4191-a9c3-513af25925b0@oracle.com>
 <aOfIgzCkwmtVXhvt@redhat.com>
In-Reply-To: <aOfIgzCkwmtVXhvt@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB6820:EE_
x-ms-office365-filtering-correlation-id: 44200cf1-a571-490e-2b02-08de07b0be88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Z1lPSHVJUHVkQmhkdTBGSFVTYTlDUTd4bDkxQ200WEpRemFSTEVRWEpGV3hr?=
 =?utf-8?B?N21kNitwNjNqR1AxRTBsa0dPeTNZVjFvTDZsSDY3T3ZhYkFrQjlPamZXRGdj?=
 =?utf-8?B?NE03Y1BMSUNZdktOL2RYOWZ5M1BidTM3YmswUWxoTHc0OWU4UTU1U1ppRlBD?=
 =?utf-8?B?WHEvMVIvV0dweHV5aURDNmRoUGd2d203cTVMUHFkanQ5Sm0wMFRXTzkyd2ky?=
 =?utf-8?B?ZFdIcXdqUWJKOElCZVdzc3hiN2hacXRQaTJmZDROM0hrSXlIZ3E0RDBlZW92?=
 =?utf-8?B?ei9OcjNZWFBhUUgzdlZUTlB2MXA0ekxIc0pFQ2t4VDV2Q0dnbnFmSnlGSXVY?=
 =?utf-8?B?YjBJYlFhY2NQVmRLQXdHZnZHTklNSlhjZUsvcVcvWm45TmF1TVVyUFFCcUx3?=
 =?utf-8?B?MHpPbmJxVjNQWHkzaTNYR3dTN1g3WlV3QzhScXAwV3lZZUpnZTc0UmNSakJY?=
 =?utf-8?B?cWp0Q2dienlBa3lUQkg1akNHMWNFNHlzVlJOQjBQYityeEt6TGkrNjRvTHRS?=
 =?utf-8?B?cmliVkdtdUJzWWh0SExBclpUazFaRVR5UnpMZS8ydkJzcnFPU1BJWDl3aWRO?=
 =?utf-8?B?RXQ3T1N2dHZlUThFOU5vUGg1SHRxSW5qSEtIcjlMMFl0cWM4OG1SdGo3Ri9T?=
 =?utf-8?B?YnREWXhoRXVIMkVYT1VzeGJXWXBwQUdneVFVTUFFdEsrV1FXZmVDbURHZ1BD?=
 =?utf-8?B?azdFMDRRZ3hockQrOVV6cjZ6eTdHV1VHcVJRWDQxdXg1NGljKzlGTGE0OTNu?=
 =?utf-8?B?UURxQTBwdXBqcFZiaE5JcUptZndKWXIwTmxJQXhseFgxcTNLWTdONTl1SzBy?=
 =?utf-8?B?SFR4MFBPYW9Hbnl3OHFsRWJ1NmdsTFc3NldZT0NlcGF4aDQ5cE1yWnZ5amlT?=
 =?utf-8?B?SzA5V3N4a2JmVjgyU2kxZTJJQVhMUkNveVJnYWhlV29ranQzem1qUkFRK3pj?=
 =?utf-8?B?ajI2d3RrM1JpejBXOWh1b1lTRHRkNDY2Z3hZejdLaEZLQTZwakdCVHFMamVo?=
 =?utf-8?B?bzk5RlZGR3hLcmZnMHhqNmVEaWJVM2pIdVhOOGVway9ZbE5RZ2lpMEdyanhB?=
 =?utf-8?B?cVBkb0dBWFN6LzBvNWxML3lPckpwYks0c3dyTVp2YWZqbERndjVWeEhqVjRl?=
 =?utf-8?B?NENCTGVpL0padFFEZkVjY3cwTGozSlVHTU92NzNpRnpQNlJhREFTNkNlbWw5?=
 =?utf-8?B?SDdCSWlHdytTbmRodnpVbnAyTEd2TG1aYThQY3c0cHh0eERpMksrMXhtYzMw?=
 =?utf-8?B?dGJtTlpxaCtadVBUbEtKSDh6VitQQlFSaS9DSmJsNkVPWVJqNEd6OXZCcGlU?=
 =?utf-8?B?Wkd5RnFvb0FnWVVGZy9LelV2QXVMV0lnd0IvUHZaSndvSzJyR3BQd21GaE5P?=
 =?utf-8?B?TUsxUjh4ZWduaGhyTllGRGVXc1RIclNYSHB4SXJ2bDgzQzl3NUMxRUdYMWNV?=
 =?utf-8?B?bUtnbk9vNG9ueS9vSG01eXp2RmlXZFZYQm10SWN3YklKc0lXQmRHVWMwMm5E?=
 =?utf-8?B?cmdQUVNWNTBVWmQvUlpwcFI4VjJsb3RXNlVQbkorY3ZFalR5L2hXUWdkV2l0?=
 =?utf-8?B?VVRhOWpQMlRlWEFWS0dXV0VZcmZZL2NESWVPODRPb3FJWmFUS2VXSXV1WXpw?=
 =?utf-8?B?Mkhxd2E5TmxlWnkyeG83L1IrQ0R4ZisyV29GeUo0N0VBck1neC9RY2NGZTZK?=
 =?utf-8?B?OUswN1RFSnJNM0JiZUlKMlpWZUxDeU1BL0pnWnRYMUxWY29PUWxOWWl5Z2Qw?=
 =?utf-8?B?NkdLN2V0YjNHdDBKTEoxMjdwdVF0cnhMUzhaVEhnRTJZUEgvRFdVM09Bbk5y?=
 =?utf-8?B?eCtRZHBhc2JqaC9XQ1Fxb0tmUHlJaXh6bTF0UXh2RlQvdmczcFhHNDBrV3Na?=
 =?utf-8?B?YTkzQXQ5MHVzeGtIMEdEMTlwenNZN1VxNm8zMWJMYXpiOVgvaUkxdHhJd24z?=
 =?utf-8?B?TGt2bGdvY1diclhjS0M0SHVuS3pYbXhBREhBRXVtUGFxT2FjNW0vVzdjK21I?=
 =?utf-8?B?MS9SS09xTWpKZGVLUUpQVCt6WE9ScHZxQWJmaXQ1Y3VYYysvVjNYWmN1N0Fv?=
 =?utf-8?Q?zJYqHh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFEyTmtwVU1Wc2VvR0NtZHdVQkdEZkpMUDR3L2R4dmk4WjZUeVc0QWt4QkhM?=
 =?utf-8?B?WUVobnBhSjJHM2tndW10Y20zOXd3TkdqS01UcXBNbytHdHRyUmNtS3ZUZHVD?=
 =?utf-8?B?VTROYlZpQk4rbHp6dGdaNXdSZHlRZUFKck9oTWdlMS96MS94Y2xKSzBtNTNS?=
 =?utf-8?B?MXR6TEkzUHZFdklFTjk0U3RJblplY2NlWEJzS3R2bEpOeWcxcWV3S0lyTjcr?=
 =?utf-8?B?YmlZbE5PRGtjNkVnV296Y3RFS2NaOEp0dVp5eWVlaHUwNHBOcC96UnJDM2Iv?=
 =?utf-8?B?ZWZnMVlBOFl5VUoxeDJWM3pqdXd4cUNhYzU3QmVVT2ViR0FzR293ZXY3aDdX?=
 =?utf-8?B?Mk9MNElvL2MyUXFoYmZtTklyRDRhK0p1Q3l0bUlPdnQxSHdGWm95WWQzelhO?=
 =?utf-8?B?TExBT3RSamRuU0plM2ppNElDVHJrMklPWENWcVROdUJKd1dERDRpVzVDZko2?=
 =?utf-8?B?L2FLci9qaFFXNVp4a2xraDBPNUFtTGgxdnk5RXBqRXpwc2lvYWVQdExNN2Nv?=
 =?utf-8?B?YzE0eDJVRmJxNy9xdkpSUDVwQUF6M3NCT1hSOEN1c0hvaGtDajV4MUcyRFVh?=
 =?utf-8?B?ZFFaeGtMTFFSc3hMTzhkbE1XSXhFeFVtZ01wRE5mWXVaRTVCZUpaejBTeGhQ?=
 =?utf-8?B?VmJWTGszR3JDNzIxZGE5T1gra1JaSVA4T1RwajhSczZpRGh5Qy8zK2RwN0RR?=
 =?utf-8?B?TWFHdkM2NFF1cDFZSVBvMEFOTktnTGxGVzM4WVBxc3VQM0p2MVJPYXhmbFVU?=
 =?utf-8?B?N3ROYlhXSlk5T0lWVU51Y3RqRjNzMW9WY2lIV0ZXSW1ZanVXM2p6NnA2TCtY?=
 =?utf-8?B?ZDJsQ1RRY293bzdwZW5hd1dKMUhmbWxYcVA0VGpRSG1TWENLS3NJd2E3cnFQ?=
 =?utf-8?B?ZmppRWhpSXV4Z05IRkFRUDgvdU5tT2p1RTd3QThmeHc3L3RCdUp2ZnEva2hM?=
 =?utf-8?B?YW1sYlN4TTFQOTVXb3o1NDJQNXhuZVBOd2MwNTZBcmdaSXhnRXJabG5nUDVN?=
 =?utf-8?B?RkQ1cUJWam9pcjViQU9aKzV5OTZYbUErM1FwUHllY1ZGaVdDdlp2akgyK0xm?=
 =?utf-8?B?U0VrRGVxYXIrL29wbmU2VUhQSXY0ZzlIbGsyY2c1NDFjMjhtak8xbDJCZjZi?=
 =?utf-8?B?MExXcU8rTzNlQ2tHcXk3ZkNMY3M3QzM0aGdVb0xVY0R0b0ZmZFEwQTlpRXMy?=
 =?utf-8?B?MnV5Tlo5ajYzVmZvdi9KTlZic1dkWmhkNksyMjJsTWVpdExsY0QwYzFJanl1?=
 =?utf-8?B?WU1NYUNsNEF0ZCtrTVIzVk05VEpvTjhTa3NTd0Y3TTc2cU9zSG1RdUZLWitO?=
 =?utf-8?B?bXRlb1kvd2NBdXdIRmh5TllGZmFJa09OTmpZOVdwd2JWci9WSkUrcjJBMkdO?=
 =?utf-8?B?dk1SVXUvK09iUFR1dlY0YU5FTm5WQ29OSmR2bzRxT1haWkdjNnBWTHRKc3J3?=
 =?utf-8?B?SCttZVpOaGxGR0RiZ2NnWDB2c0FJZ0lPZ09mU3NJVHRGWUxtOHh0M2FraUhZ?=
 =?utf-8?B?WVZRU3UwLy9sYlE4MTNkTXJZQXVjcFRiSnl3OEg0ekdhWDMrRWFsYzJUYStY?=
 =?utf-8?B?MW5FN3JtN0xOTXEvTVBMdEx3aWxUeDFydUJwTyt4L3g5c1ZiRXRhL2NpTjRs?=
 =?utf-8?B?dnh2MFZHMkIvWEVySmlEVFVhN3pGOU1lUGdiZ0tQZVkzTUZMaFFJOTVDaGxx?=
 =?utf-8?B?WU5ORWRQbDA0YXpDWUpWcUxzYUV2SW1kakEyZDZiMzhDUm8yaGpFem4vQ0xM?=
 =?utf-8?B?dlJWbXBUMDdsakltak5TMzdWN291Vlc0UEtTeEFicC9UTlpaTzFiOVlERzRQ?=
 =?utf-8?B?cU5zTHJFckZZOWR0R3hPRUJwL1F4aU9SeHNOT2FVSEZ3c0lhNDRlc2dKRHNG?=
 =?utf-8?B?eGhWY3IxZytTMkQ2MkVRRGRNYjZMUHZZbkptRFE1SU5YUFNJT0luV050UGdu?=
 =?utf-8?B?QVljM3B1MFRUbnl4ZWZmek4vZ1BESG4rUFR0WkhXdGd4UFZOV3ljY1hubTBG?=
 =?utf-8?B?ZStyQXFrUDFyRWhCVXY4KzB6VWJJL3ArSnFMRnd1WVlUODFFRGFyejhEMDkv?=
 =?utf-8?B?b2FyQkZkMHNKRnFYYmhlQnJCaStTbDNXT3kyNnRpVmpURVhENEFDNkw2VzZo?=
 =?utf-8?Q?eGbVrC6LtrnO6kFlDZzzdattK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44200cf1-a571-490e-2b02-08de07b0be88
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 03:54:42.4851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gu1fNmViG4OJBKbfgDeWfsOZaUed8DfF13Vy4VNfPnQKSgOHEm925+jxJmZ/Np/TDLsshTvX4PGCZzn21xfgEhRt6+qKx0daLAfAvR3+ZSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6820
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhbmllbCBQLiBCZXJyYW5n
w6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiA2LzZdIGFj
Y2VsL2t2bTogRml4IFNJR1NFR1Ygd2hlbiBleGVjdXRlDQo+InF1ZXJ5LWJhbGxvb24iIGFmdGVy
IENQUiB0cmFuc2Zlcg0KPg0KPk9uIFRodSwgT2N0IDA5LCAyMDI1IGF0IDEwOjMyOjM0QU0gLTA0
MDAsIFN0ZXZlbiBTaXN0YXJlIHdyb3RlOg0KPj4gT24gMTAvOS8yMDI1IDEwOjE5IEFNLCBEYW5p
ZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPj4gPiBPbiBUaHUsIE9jdCAwOSwgMjAyNSBhdCAxMDox
MToxN0FNIC0wNDAwLCBTdGV2ZW4gU2lzdGFyZSB3cm90ZToNCj4+ID4gPiBPbiAxMC84LzIwMjUg
NjoyMiBBTSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gPiA+ID4NCj4+ID4gPiA+DQo+PiA+
ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiA+ID4gPiA+IEZyb206IFN0ZXZl
biBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4gPiA+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyIDYvNl0gYWNjZWwva3ZtOiBGaXggU0lHU0VHViB3aGVuIGV4ZWN1dGUN
Cj4+ID4gPiA+ID4gInF1ZXJ5LWJhbGxvb24iIGFmdGVyIENQUiB0cmFuc2Zlcg0KPj4gPiA+ID4g
Pg0KPj4gPiA+ID4gPiBPbiA5LzMwLzIwMjUgMjowMCBBTSwgRHVhbiwgWmhlbnpob25nIHdyb3Rl
Og0KPj4gPiA+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4gPiA+ID4g
PiA+IEZyb206IFN0ZXZlbiBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4g
PiA+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA2LzZdIGFjY2VsL2t2bTogRml4IFNJ
R1NFR1Ygd2hlbg0KPmV4ZWN1dGUNCj4+ID4gPiA+ID4gPiA+ICJxdWVyeS1iYWxsb29uIiBhZnRl
ciBDUFIgdHJhbnNmZXINCj4+ID4gPiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4gPiBPbiA5LzI4LzIw
MjUgNDo1NCBBTSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiA+ID4gPiA+ID4gPiA+IEFmdGVy
IENQUiB0cmFuc2Zlciwgc291cmNlIFFFTVUgY2xvc2VzIGt2bSBmZCBhbmQgc2V0cw0KPmt2bV9z
dGF0ZSB0bw0KPj4gPiA+ID4gPiA+ID4gTlVMTCwNCj4+ID4gPiA+ID4gPiA+ID4gInF1ZXJ5LWJh
bGxvb24iIHdpbGwgY2hlY2sga3ZtX3N0YXRlLT5zeW5jX21tdSBhbmQgdHJpZ2dlcg0KPk5VTEwN
Cj4+ID4gPiA+ID4gcG9pbnRlcg0KPj4gPiA+ID4gPiA+ID4gPiByZWZlcmVuY2UuDQo+PiA+ID4g
PiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4gPiA+IFdlIGRvbid0IG5lZWQgdG8gTlVMTCBrdm1fc3Rh
dGUgYXMgYWxsIHN0YXRlcyBpbiBrdm1fc3RhdGUNCj5hcmVuJ3QNCj4+ID4gPiA+ID4gcmVsZWFz
ZWQNCj4+ID4gPiA+ID4gPiA+ID4gYWN0dWFsbHkuIEp1c3QgY2xvc2luZyBrdm0gZmQgaXMgZW5v
dWdoIHNvIHdlIGNvdWxkIHN0aWxsIHF1ZXJ5DQo+c3RhdGVzDQo+PiA+ID4gPiA+ID4gPiA+IHRo
cm91Z2ggInF1ZXJ5XyoiIHFtcCBjb21tYW5kLg0KPj4gPiA+ID4gPiA+ID4NCj4+ID4gPiA+ID4g
PiA+IElNTyB0aGlzIGRvZXMgbm90IG1ha2Ugc2Vuc2UuICBNdWNoIG9mIHRoZSBzdGF0ZSBpbiBr
dm1fc3RhdGUNCj53YXMNCj4+ID4gPiA+ID4gZGVyaXZlZA0KPj4gPiA+ID4gPiA+ID5mcm9tIGlv
Y3RsJ3Mgb24gdGhlIGRlc2NyaXB0b3JzLCBhbmQgY2xvc2luZyB0aGVtIGludmFsaWRhdGVzIGl0
Lg0KPkFza2luZw0KPj4gPiA+ID4gPiA+ID4gaGlzdG9yaWNhbCBxdWVzdGlvbnMgYWJvdXQgd2hh
dCB1c2VkIHRvIGJlIG1ha2VzIG5vIHNlbnNlLg0KPj4gPiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4g
WW91IGFsc28gaGF2ZSB5b3VyIHZhbGlkIHBvaW50Lg0KPj4gPiA+ID4gPiA+DQo+PiA+ID4gPiA+
ID4gPg0KPj4gPiA+ID4gPiA+ID4gQ2xlYXJpbmcga3ZtX3N0YXRlIGFuZCBzZXR0aW5nIGt2bV9h
bGxvd2VkPWZhbHNlIHdvdWxkIGJlIGENCj5zYWZlciBmaXguDQo+PiA+ID4gPiA+DQo+PiA+ID4g
PiA+IFNldHRpbmcga3ZtX2FsbG93ZWQ9ZmFsc2UgY2F1c2VzIGt2bV9lbmFibGVkKCkgdG8gcmV0
dXJuIGZhbHNlDQo+d2hpY2ggc2hvdWxkDQo+PiA+ID4gPiA+IHByZXZlbnQga3ZtX3N0YXRlIGZy
b20gYmVpbmcgZGVyZWZlcmVuY2VkIGFueXdoZXJlOg0KPj4gPiA+ID4gPg0KPj4gPiA+ID4gPiAg
ICAgICAjZGVmaW5lIGt2bV9lbmFibGVkKCkgICAgICAgICAgIChrdm1fYWxsb3dlZCkNCj4+ID4g
PiA+ID4NCj4+ID4gPiA+ID4gICAgIEVnIGZvciB0aGUgYmFsbG9vbjoNCj4+ID4gPiA+ID4NCj4+
ID4gPiA+ID4gICAgICAgc3RhdGljIGJvb2wgaGF2ZV9iYWxsb29uKEVycm9yICoqZXJycCkNCj4+
ID4gPiA+ID4gICAgICAgew0KPj4gPiA+ID4gPiAgICAgICAgICAgaWYgKGt2bV9lbmFibGVkKCkg
JiYgIWt2bV9oYXNfc3luY19tbXUoKSkgew0KPj4gPiA+ID4NCj4+ID4gPiA+IE9LLCB3aWxsIGRv
LCBjbGVhcmluZyBrdm1fYWxsb3dlZCBpcyBhIGdvb2QgaWRlYS4NCj4+ID4gPiA+DQo+PiA+ID4g
PiBDdXJyZW50bHkgdGhlcmUgYXJlIHR3byBxbXAgY29tbWFuZHMgInF1ZXJ5LWJhbGxvb24iIGFu
ZA0KPiJxdWVyeS1jcHUtZGVmaW5pdGlvbnMiDQo+PiA+ID4gPiBjYXVzaW5nIFNJR1NFR1YgYWZ0
ZXIgQ1BSLXRyYW5zZmVyLCBjbGVhcmluZyBrdm1fYWxsb3dlZCBoZWxwcyBmb3INCj5ib3RoLg0K
Pj4gPiA+ID4gQnV0IGNsZWFyaW5nIGJvdGgga3ZtX2FsbG93ZWQgYW5kIGt2bV9zdGF0ZSBjYXVz
ZSBTSUdTRUdWIG9uDQo+InF1ZXJ5LWNwdS1kZWZpbml0aW9ucyIuDQo+PiA+ID4gPg0KPj4gPiA+
ID4gSSdsbCBzZW5kIGEgcGF0Y2ggdG8gY2xlYXJpbmcgb25seSBrdm1fYWxsb3dlZCBpZiB5b3Ug
YXJlIGZpbmUgd2l0aCBpdC4NCj4+ID4gPg0KPj4gPiA+IEkgc3RpbGwgZG9uJ3QgbG92ZSB0aGUg
aWRlYS4gIGt2bV9zdGF0ZSBpcyBubyBsb25nZXIgdmFsaWQuDQo+PiA+ID4NCj4+ID4gPiBJdCBz
b3VuZHMgbGlrZSAicXVlcnktY3B1LWRlZmluaXRpb25zIiBpcyBtaXNzaW5nIGEgY2hlY2sgZm9y
DQo+a3ZtX2VuYWJsZWQoKS4NCj4+ID4NCj4+ID4gVGhpcyBwYXRjaCAgLyBidWcgZmVlbHMgbGlr
ZSBpdCBpcyBzaWRlLXN0ZXBwaW5nIGEgZ2VuZXJhbCBjb25jZXB0dWFsDQo+PiA+IHF1ZXN0aW9u
LiAgQWZ0ZXIgY3ByLXRyYW5zZmVyIGlzIGNvbXBsZXRlIHdoYXQgUU1QIGNvbW1hbmRzIGFyZSBz
dGlsbA0KPj4gPiB2YWxpZCB0byBjYWxsIGluIGdlbmVyYWwgPyBUaGlzIHRocmVhZCBtZW50aW9u
cyB0d28gd2hpY2ggaGF2ZSBjYXVzZWQNCj4+ID4gYnVncywgYnV0IGJleW9uZCB0aGF0IGl0IGZl
ZWxzIGxpa2UgYSBsYXJnZSBzdWJzZXQgb2YgUU1QIGNvbWFtbmRzDQo+PiA+IGFyZSBjb25jZXB0
dWFsbHkgaW52YWxpZCB0byB1c2UuDQo+Pg0KPj4gQWdyZWVkLiBJIGRvbid0IHNlZSB3aHkgdGhl
c2UgY29tbWFuZHMgc2hvdWxkIGJlIGlzc3VlZCB0byB0aGUgZGVhZA0KPmluc3RhbmNlLg0KPj4g
SG93IGFib3V0IG1pZ3JhdGlvbiBzdGF0dXMsIHF1aXQsIGFuZCBub3RoaW5nIGVsc2U/DQo+PiBI
YWxmIHNlcmlvdXMuDQo+DQo+SSB3YXMgaG9waW5nIHlvdSdkIHN1Z2dlc3Qgc3VjaCBhIHNob3J0
IGxpc3QgOi0pDQo+DQo+RXNzZW50aWFsbHkgYSBjYXNlIG9mIGNhbGxpbmcgcW1wX2Zvcl9lYWNo
X2NvbW1hbmQoKSwgYW5kIGluIHRoZSBjYWxsYmFjaw0KPnJ1biBxbXBfZGlzYWJsZV9jb21tYW5k
KCkgZm9yIGV2ZXJ5dGhpbmcgbm90IGluIHRoZSBhbGxvdy1saXN0Lg0KDQpUaGFua3MgZm9yIHlv
dXIgc3VnZ2VzdGlvbiwgSSBhZ3JlZSB0aGlzIGlzIGEgcGVyZmVjdCBzY2hlbWUsIGJ1dCBpcyBh
bHNvIGhlYXZ5IG9uIHRoaXMgY29ybmVyIGNhc2Xwn5iKDQpKdXN0IGN1cmlvdXMgaWYgd2UgbmVl
ZCB0byBkbyBzYW1lIGZvciBsaXZlIG1pZ3JhdGlvbi4gRS5nLiwgc2VuZCBxbXAgY29tbWFuZCBv
biBzb3VyY2UgcWVtdSBhZnRlciBsaXZlIG1pZ3JhdGlvbi4NCg0KVGhhbmtzDQpaaGVuemhvbmcN
Cg==

