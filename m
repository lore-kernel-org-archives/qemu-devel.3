Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C18C27C78
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 01:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHCoA-0004No-TW; Tue, 11 Jun 2024 21:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sHCoA-0004Ng-4Y
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 21:29:50 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sHCo7-0004Ts-Dl
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 21:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718155787; x=1749691787;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=974ljC+8Qn8f00mqvAS5kKYYKn02laoAX9+CcTsca6o=;
 b=TFRbIYQ+JOHgjVufd5C1Cmq01dLT87NWnO0rkWRYLtb1W2OuzJKhloIx
 E0bKHMwdDISAnUYfTE55se7M1infAgWZsldb9wglNekepn3WHWRUNIlT2
 /hI65nxboAa0Bm6+O/927J1pGVQUxxGpv9S75eiMmRw8DMGh4MYbXLLU5
 vMAFz7taapsDxt7l+eFnsGp/TD2WIH+vjb61eDID94zHvMdMHMOnwaUYv
 Qm5yvMhvZA9OtZewDRVFWos3v/vuQB3sXqgOv/NI6GDTXa1rqm7OGse1f
 EQ9s2HeOFIzd70r6irDvBb7I67/G0VsTKm5WjufAxSuo0ef74sF/BoxMa A==;
X-CSE-ConnectionGUID: PNk0T+ZkQeS0Rm4xl6Kecw==
X-CSE-MsgGUID: 2vhPUwmCSPGv3gzW+AxO6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="17823790"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; d="scan'208";a="17823790"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 18:29:44 -0700
X-CSE-ConnectionGUID: UDxPCIbIQ2GT4qokJuucjw==
X-CSE-MsgGUID: +/S6iRgdRi+63UWJUYq3SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; d="scan'208";a="39737492"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jun 2024 18:29:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 18:29:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 18:29:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 18:29:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 18:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSV6HvPkyyY6RqDYToZ309GQON9L0C8uWJCEcHQ7DgcbbIXGzfaIesqEdCai3lk8ys/0iMsh1PbsJ6hqxIsimeBKAp0HaCJ+ybHBi5kFODYRMC+FG2GKv1RsN9JUfu4wg49DDdcBEMWlIcMOHU4fBeUpxH781KHeUpOXCD313JRELomzmTkF8izmB+dRh6+duEKrElbHw5GzR7dKgLB0fNJkJQRivZq2M1asFxcZXFWbMdByTOzkjzhw0QY6151pXqgm4BPX2eaHyX5t1f1UFnJQR8q2cZVGNwV4GKv0Rjh9mFUwApCMjVd4gvxuPqlaCEihD3aZC/8eVA2jQCLKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=974ljC+8Qn8f00mqvAS5kKYYKn02laoAX9+CcTsca6o=;
 b=E1pnJJw1a9yVryBYDOdMrrxn/9bAdOL2Ykgx/7aL/l04YS/SqZmplgAqYllpa4dJ5d5R0bT1jZt9M9aLcckxrX5r0t4iqcBAnT80E/t6Q40Lwrke1kOckGVPs3e6D0Kyxka+5T8qTp5YFrdkMmTGExzKgOg7pI/oshbokk0ss9n0p9JWg8If7nBRoJKri7n2cZnFtpnZz4Lgjedql7AAaCM+Dn+TYEKFZ8oupeTcSBUTy2d+1CBtkRqwlYrRM6cu2a2gqJwEuiPiVA1ItGf4sMhd0vkq9NdprchXFp4dMWW6AVEbb15GxZNLfbRwJMTqm62y2y4hLRVANDicuiTCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by CH3PR11MB7179.namprd11.prod.outlook.com (2603:10b6:610:142::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 01:29:38 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 01:29:38 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu
 <peterx@redhat.com>
Subject: RE: [PATCH] ui/gtk: Wait until the current guest frame is rendered
 before switching to RUN_STATE_SAVE_VM
Thread-Topic: [PATCH] ui/gtk: Wait until the current guest frame is rendered
 before switching to RUN_STATE_SAVE_VM
Thread-Index: AQHashncM9KWDLphikK7mVE+FU5errG3fAMAgABu2QCAAOyIgIAKkQyw
Date: Wed, 12 Jun 2024 01:29:38 +0000
Message-ID: <PH8PR11MB68796CDE59AA75FD1D6089A1FAC02@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240529224252.80395-1-dongwon.kim@intel.com>
 <CAJ+F1CJFWRtyXvpCJuSVPssJcBx8ecP1HCkWCJ=HBWxXovj+Dw@mail.gmail.com>
 <ed6a1963-b079-4fdc-a6ca-6ba98b95c0de@intel.com>
 <CAJ+F1CJW3b9D4nU3x4XSjpG=KrBpJMLWqdR3tpdipObODZRvgQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJW3b9D4nU3x4XSjpG=KrBpJMLWqdR3tpdipObODZRvgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|CH3PR11MB7179:EE_
x-ms-office365-filtering-correlation-id: 8c1c4992-b8e8-40b2-b08c-08dc8a7f205a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230032|366008|1800799016|376006|38070700010;
x-microsoft-antispam-message-info: =?utf-8?B?cWlTQlRMTS9PZkJJUElGNG1qTTROWDJhZS9KYzZMSFFab3Zjd3RZM1d3NmE4?=
 =?utf-8?B?cHFHbjluQ3IyL2tCdVJVb0RpMjgxUlZCbkFicGlldnRUS2pkNS80MWhCZDRu?=
 =?utf-8?B?SmdBNWFSM0FlRFpTb0g2WnQrTUJUbnBsbXhUV1F5Ymc2RE4ybEF4azR0aHRx?=
 =?utf-8?B?UDRhWGJLK0JmbUN6dTNnUHIrUlRaNU9NSDdtSGlWSjBmZ0xXTnFWc0tTd0xt?=
 =?utf-8?B?cE92RmZuTms0eWtuQ2ZRc3Fva3ZsYkVWVyswZk1yYlZDMHNNSWJ1cm5mZzM3?=
 =?utf-8?B?SnBmWU5rZ0VFMWZ0Y1JRY2x2ZmxDUllNSVJ3NHNjNUlVYUllOXJMa2VkMEZC?=
 =?utf-8?B?cWRmTlI3UFZQUE52ZWZTR2pUOGZHT29sbDVUZXpCODUzUTZyMTErcnFkOWtO?=
 =?utf-8?B?M3JoWnFFaWQrM0xua1NnUGdVQm5EK1BjTFBJd05GdDN4dnFUOWc4c2hiU1R0?=
 =?utf-8?B?alB0Y21QbHd1d3pNRTlHWU9kaWpCOWV2OFlFUzJKam11ZG14MlhQQzFEQ092?=
 =?utf-8?B?RHI0QklYZG5FdFNJNVZteS82MjRRQm80Qk5hN09HSzlVa1VqZE1iNW9VNGN2?=
 =?utf-8?B?cjNYeW0rZS9NUDdtYWVsSWV4S2Z6VkpBekZnTHpMQXdYd0loNGtVdC9aOU05?=
 =?utf-8?B?eFVJcTNrR2diMGNscEtUdGlta0RmektwUndpWW42TG95ZzZmK0svSXY1QnVD?=
 =?utf-8?B?czAvM1dDWHpZcXFETFpLSHBEeHdMdFc3Y0wvRFdpWERzNUh4RWtKZE12VjhV?=
 =?utf-8?B?S0NtbmZGVUpIY0lBbDJkeTRzOEdHemd2MlNMTzN4WVNPS0tjN3FXN1Z2WldF?=
 =?utf-8?B?bms0cDI4RndNTlhveSsyeW5wTzlNdDdUUnhuNUxDemErVWtvNDJrNWRkVEh5?=
 =?utf-8?B?dFdyYmYyd2RyMDdRTldBalFGY3RGYzR1QU0wRW44THRlTGxuNEJYWmx0VWEr?=
 =?utf-8?B?bk03U3ZVN1o2NFVPUFg2R0hXeU9NRUc4VHF2YXZib3pxWnE4eDBTN0lTb1lq?=
 =?utf-8?B?RSsxRVlqTkpOTlN2K0lZTkl0dUljZGt5N1crdkFWeTdseEQvS2NyMzJ3Qkd6?=
 =?utf-8?B?MnZLOEpTV3dZa1EvdFNtZnhyMVRkTHNIeVVrUXRqeEtabG9xeTh0S2xyZFY0?=
 =?utf-8?B?V01RZ29QMDNUc2dEb0cxYTJYK2VFc3hyVVg2eGtRNFUyQXBkTGRzTHhZVGFK?=
 =?utf-8?B?SFp1blVMQys2UG5MSHprUjVTT0lSWjY5Uk8yOGpiZTBvZzNrUTF0a1pzd1I5?=
 =?utf-8?B?Y2RUYTBuaGlweUJjNkVQcEk5OHZYdXMvRTAyUTNkYUlQUmFVZHVzdUw1cTlt?=
 =?utf-8?B?ZVJWN3BRL3J2M05yOEVFTFl4ZTgzc0FJeS8zWklnMjRuK2lIWVhJZVdaYnpF?=
 =?utf-8?B?b253MlFNeWVKYkozYkdTSlo1dzBZU0M1aE5OSmYycy9ZRWVjbzAvaGFuZWxy?=
 =?utf-8?B?eXlYbkJsVDByQ1MzS2xhL2dYZHR1K2lqNWJ6c1Q4Njdka1kwTTlHZ25pYWpT?=
 =?utf-8?B?Q25xMHJGQWQ2bTE0cWc1N3pQQ0F3SE9VMERRNjBKSE5UOVZUYXFXKzF4NzFy?=
 =?utf-8?B?aStReDJ6dlo4YjhkbmNIVVVDOEVQcC9iZjhTanpLZ0tPa0hUbnRTS3VZVG9E?=
 =?utf-8?B?UmhWZ2pnWlNWdW5laC8yc1M1MHV4VnBPLzN6MU41aDNQNkhqQlhFWUFEazZm?=
 =?utf-8?B?VmpiUm93Wm9VcWJIUkU5eEFra3dEeTBmVVN2RmU3eVNKTGFmWHBMcGRMVVVC?=
 =?utf-8?B?blYvZ1ZaZk5TbG5yVE1GeGM4TDBSeHdLdktSTy9WYXhrd05qc0ZXTDZVL2RR?=
 =?utf-8?Q?fS6ATj90ojxC1xT/X/bV/lon/gwME+PBHyZ60=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230032)(366008)(1800799016)(376006)(38070700010); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDBaUGx6SjBad0Y2MUduMFYvVHY2cVpUa0QzM3V2R0tpdksvVzR1c01Nd2JJ?=
 =?utf-8?B?WFQ2ZXVpb1JxcG5Gcm9aZjRhT0EvdVNYbllkL3BGR2RBSU1kVi9jRHp0bjds?=
 =?utf-8?B?WTBRQUNnRDJSeCs2dUpqWm5JTVFBMmVJRXVBTTRpc0NXU1psVmdHNTY4TXJq?=
 =?utf-8?B?SVRtbk5pYXBxd1ZLNTNCWHVqdGJ6OG1BQnJNaXNoejVWZXlZdEtaWUhPeGZS?=
 =?utf-8?B?eHQzZ0xYVk53dkZ3T2pvb3Z5aDA4dFovME1FWWwzVmowMTlIVGR0ZjhHZFZB?=
 =?utf-8?B?U2JDdFVDRTAwLzhuQ09IL0ZsT2RlT2dPOUE4ZUl1dnJPSGhHakxidnhYRGlE?=
 =?utf-8?B?aFJ1N3JXeEd2Zlc4d2pKQkhXR0V1ZmZjWk85U296bjZocTFuL3liczl5NUNN?=
 =?utf-8?B?V0hQdlVYbkpjSXM1RGhjajZnZXJDVFFrK1RnRXE0SUEzYjVpRU5OMGdER0Vk?=
 =?utf-8?B?VGFVeFJpY2t2SHQybGdMSW9XaEhwbzZUbjJrUVBBbFAxeVcrVXNiWHVQSWcw?=
 =?utf-8?B?LzNsSkVOSHJHWDBjZWVpKzdrTzdzWlJydzFaMURmMWp3eWFDcEFVV2FyM2VC?=
 =?utf-8?B?b09jYUo2NU4rdWRiaHlXdG5RdnF1SHpmMS8wZVlBOUJxcXgvdmVkQ2ZnbHZ1?=
 =?utf-8?B?ZUFJM3EvMVJMSmxZbHY5eCtNLzRoL01qdzRPTVpXTkhxVlhrVXFLVkI4dVJa?=
 =?utf-8?B?S3FOK1plTDcyREkzNEg4bVVvcE1EbDRKWTlpKzJUMnNWTnNuRElYZzR4Q0dI?=
 =?utf-8?B?dmMxU1Q0V0llMlFYSWs2Tkw0Z2NOMmhXbGFVbzZNUThJUHRvakYzaVlMNXo5?=
 =?utf-8?B?RE9xcXNQditRRXhHNUs1ZkJvbEV6Y2RXd0xGMkFTVUJYazljOGFKRjJYVE15?=
 =?utf-8?B?S2p3MWVhWTA3aStHMXZnSEhjRnNvNVNhMkgyeGZJaHdKV1hTOGJxU0orc3lJ?=
 =?utf-8?B?bS9pT1RiV2V4bzRuUVcvczQ4S3NhL1dTRWxpTm5oN3ZSTHZsdVBQem14c09U?=
 =?utf-8?B?QlBKTjlOeXJIY3lVaURpbkwxZGlrR09oYm5DYng4VWhObWdnaXFzdmNKams4?=
 =?utf-8?B?UFNjNStyRldQVW5FdVRQRngxdzc0MFVFbmZYMmQwZ3RGVkFYU1lWY3BGb1RO?=
 =?utf-8?B?Q1JGeTlMTGJEYkxpVG83VjZwMG5USFRKM3FLcEcvREwvWHdIMU92Q2RRWWtk?=
 =?utf-8?B?VmNLall6NDhOdHR1ZkJOeUIrR2ZHcS9zcE9TNUFFMHRneGpXYnRSZ3A4SDdV?=
 =?utf-8?B?Y2IvSEVYY29sZ1RyM3Y3UHZFeUtCTGd5ZUdwR2phWHVKQzJMR2FjbjVEWDhW?=
 =?utf-8?B?WnFDN0Z0ZGZVZnZxeWtVQnhtbEQ1UEFRRmlXN29HMkNnVVVUajdIN1ZGdTJq?=
 =?utf-8?B?OFd4RzlCZG8zM1RzS2N5TVZ5RnBBb2p6UlM3d05FWEFTQTlmWlZhREJ6aWVI?=
 =?utf-8?B?SXRmd01MbkZlQ1Z0RUFyaTdRenE5ZWttVG1vQVU5Y0NqaXUwZHZXUHB6OFd2?=
 =?utf-8?B?TWlmRmdCS0tMdkorMysvQ2kySERkd3BaOUxVK3l1eERlMGRsdnNPM1VrOU5t?=
 =?utf-8?B?OU44OWMrR3p6UTFhdTBNMTN5SlVzam5iaHRJZEptdXd3dUIyUGhMaVJoLytI?=
 =?utf-8?B?U29oWEtYOHluajkvSUJYOW8xQjJ2eXhPdFlJZzRLTjRndGYyUWJ0a0trdTl6?=
 =?utf-8?B?eWdUcmhwZ3ZTYVNkRnphNlpsa1lLMGhwOCtIN25teEYvOFFtWmNPeThOaDlh?=
 =?utf-8?B?TXdoT0paa1ZsZ0ZQSVozczJtRFNLWTdmRlUzNFN1V2l4TXZvRWJBa1RhSWZH?=
 =?utf-8?B?TERQakNVNlQxVjBBUW82b3U3eFhBNVdNY0VuNXlUT2ZtTWwrME1MOXZveTFO?=
 =?utf-8?B?U00yNUFuVmo1WEdralp3aWtmUFN0VEdtc2hIQ2hxSWljR3VoS01hZmVkY1Q4?=
 =?utf-8?B?OUlqRWUrWlF0R1RmMVJ5cTgwWkVGWTY3RXpTZlp1akdwbU1BMWpBRjh2d3Js?=
 =?utf-8?B?K0pGU0RuZ1V6OXlpWTNVOFY4Z25MVXVGK3BBeGRqRldBWW9wTmRTWGdRa2hI?=
 =?utf-8?B?MkFmd0F6L2ZXb1RaQUJLNmJMYzZudnBCbXp6NTgzR1pUUm8xeVFoSjFad1Q2?=
 =?utf-8?Q?kdfgdkbCdoeRaiJRRYr9xhiS8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1c4992-b8e8-40b2-b08c-08dc8a7f205a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 01:29:38.7543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6WeB8DRoScHYghN0ihMJ6vHIGufmqgntPlqf2FIjs/W3zJwJPV5nCkHeo8kXQhgBP0dK3AUjkJyDtwxqBTJLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7179
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGksIA0KDQpGcm9tOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAZ21haWwu
Y29tPiANClNlbnQ6IFdlZG5lc2RheSwgSnVuZSA1LCAyMDI0IDEyOjU2IEFNDQpUbzogS2ltLCBE
b25nd29uIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQpDYzogcWVtdS1kZXZlbEBub25nbnUub3Jn
OyBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSB1aS9n
dGs6IFdhaXQgdW50aWwgdGhlIGN1cnJlbnQgZ3Vlc3QgZnJhbWUgaXMgcmVuZGVyZWQgYmVmb3Jl
IHN3aXRjaGluZyB0byBSVU5fU1RBVEVfU0FWRV9WTQ0KDQpIaQ0KDQpPbiBUdWUsIEp1biA0LCAy
MDI0IGF0IDk6NDnigK9QTSBLaW0sIERvbmd3b24gPG1haWx0bzpkb25nd29uLmtpbUBpbnRlbC5j
b20+IHdyb3RlOg0KT24gNi80LzIwMjQgNDoxMiBBTSwgTWFyYy1BbmRyw6kgTHVyZWF1IHdyb3Rl
Og0KPiBIaQ0KPiANCj4gT24gVGh1LCBNYXkgMzAsIDIwMjQgYXQgMjo0NOKAr0FNIDxtYWlsdG86
ZG9uZ3dvbi5raW1AaW50ZWwuY29tIA0KPiA8bWFpbHRvOm1haWx0bzpkb25nd29uLmtpbUBpbnRl
bC5jb20+PiB3cm90ZToNCj4gDQo+wqAgwqAgwqBGcm9tOiBEb25nd29uIDxtYWlsdG86ZG9uZ3dv
bi5raW1AaW50ZWwuY29tIDxtYWlsdG86bWFpbHRvOmRvbmd3b24ua2ltQGludGVsLmNvbT4+DQo+
IA0KPsKgIMKgIMKgTWFrZSBzdXJlIHJlbmRlcmluZyBvZiB0aGUgY3VycmVudCBmcmFtZSBpcyBm
aW5pc2hlZCBiZWZvcmUgc3dpdGNoaW5nDQo+wqAgwqAgwqB0aGUgcnVuIHN0YXRlIHRvIFJVTl9T
VEFURV9TQVZFX1ZNIGJ5IHdhaXRpbmcgZm9yIGVnbC1zeW5jIG9iamVjdCB0byBiZQ0KPsKgIMKg
IMKgc2lnbmFsZWQuDQo+IA0KPiANCj4gQ2FuIHlvdSBleHBhbmQgb24gd2hhdCB0aGlzIHNvbHZl
cz8NCg0KSW4gY3VycmVudCBzY2hlbWUsIGd1ZXN0IHdhaXRzIGZvciB0aGUgZmVuY2UgdG8gYmUg
c2lnbmFsZWQgZm9yIGVhY2ggDQpmcmFtZSBpdCBzdWJtaXRzIGJlZm9yZSBtb3ZpbmcgdG8gdGhl
IG5leHQgZnJhbWUuIElmIHRoZSBndWVzdOKAmXMgc3RhdGUgDQppcyBzYXZlZCB3aGlsZSBpdCBp
cyBzdGlsbCB3YWl0aW5nIGZvciB0aGUgZmVuY2UsIFRoZSBndWVzdCB3aWxsIA0KY29udGludWUg
dG/CoCB3YWl0IGZvciB0aGUgZmVuY2UgdGhhdCB3YXMgc2lnbmFsZWQgd2hpbGUgYWdvIHdoZW4g
aXQgaXMgDQpyZXN0b3JlZCB0byB0aGUgcG9pbnQuIE9uZSB3YXkgdG8gcHJldmVudCBpdCBpcyB0
byBnZXQgaXQgZmluaXNoIHRoZSANCmN1cnJlbnQgZnJhbWUgYmVmb3JlIGNoYW5naW5nIHRoZSBz
dGF0ZS4NCg0KQWZ0ZXIgdGhlIFVJIHNldHMgYSBmZW5jZSwgaHdfb3BzLT5nbF9ibG9jayh0cnVl
KSBnZXRzIGNhbGxlZCwgd2hpY2ggd2lsbCBibG9jayB2aXJ0aW8tZ3B1L3ZpcmdsIGZyb20gcHJv
Y2Vzc2luZyBjb21tYW5kcyAodW50aWwgdGhlIGZlbmNlIGlzIHNpZ25hbGVkIGFuZCBnbF9ibG9j
ay9mYWxzZSBjYWxsZWQgYWdhaW4pLg0KDQpCdXQgdGhpcyAiYmxvY2tpbmciIHN0YXRlIGlzIG5v
dCBzYXZlZC4gU28gaG93IGRvZXMgdGhpcyBhZmZlY3Qgc2F2ZS9yZXN0b3JlPyBQbGVhc2UgZ2l2
ZSBtb3JlIGRldGFpbHMsIHRoYW5rcw0KDQpZZWFoIHN1cmUuICJCbG9ja2luZyIgc3RhdGUgaXMg
bm90IHNhdmVkIGJ1dCBndWVzdCdzIHN0YXRlIGlzIHNhdmVkIHdoaWxlIGl0IHdhcyBzdGlsbCB3
YWl0aW5nIGZvciB0aGUgcmVzcG9uc2UgZm9yIGl0cyBsYXN0IHJlc291cmNlLWZsdXNoIHZpcnRp
byBtc2cuIFRoaXMgdmlydGlvIHJlc3BvbnNlLCBieSB0aGUgd2F5IGlzIHNldCB0byBiZSBzZW50
IHRvIHRoZSBndWVzdCB3aGVuIHRoZSBwaXBlbGluZSBpcyB1bmJsb2NrZWQgKGFuZCB3aGVuIHRo
ZSBmZW5jZSBpcyBzaWduYWxlZC4pLiBPbmNlIHRoZSBndWVzdCdzIHN0YXRlIGlzIHNhdmVkLCBj
dXJyZW50IGluc3RhbmNlIG9mIGd1ZXN0IHdpbGwgYmUgY29udGludWVkIGFuZCByZWNlaXZlcyB0
aGUgcmVzcG9uc2UgYXMgdXN1YWwuIFRoZSBwcm9ibGVtIGlzIGhhcHBlbmluZyB3aGVuIHdlIHJl
c3RvcmUgdGhlIHNhdmVkIGd1ZXN0J3Mgc3RhdGUgYWdhaW4gYmVjYXVzZSB3aGF0IGd1ZXN0IGRv
ZXMgd2lsbCBiZSB3YWl0aW5nIGZvciB0aGUgcmVzcG9uc2UgdGhhdCB3YXMgc2VudCBhIHdoaWxl
IGFnbyB0byB0aGUgb3JpZ2luYWwgaW5zdGFuY2UuDQoNCj4gDQo+IA0KPsKgIMKgIMKgQ2M6IE1h
cmMtQW5kcsOpIEx1cmVhdSA8bWFpbHRvOm1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbQ0KPsKg
IMKgIMKgPG1haWx0bzptYWlsdG86bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPj4NCj7CoCDC
oCDCoENjOiBWaXZlayBLYXNpcmVkZHkgPG1haWx0bzp2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29t
DQo+wqAgwqAgwqA8bWFpbHRvOm1haWx0bzp2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPj4NCj7C
oCDCoCDCoFNpZ25lZC1vZmYtYnk6IERvbmd3b24gS2ltIDxtYWlsdG86ZG9uZ3dvbi5raW1AaW50
ZWwuY29tDQo+wqAgwqAgwqA8bWFpbHRvOm1haWx0bzpkb25nd29uLmtpbUBpbnRlbC5jb20+Pg0K
PsKgIMKgIMKgLS0tDQo+wqAgwqAgwqAgwqB1aS9lZ2wtaGVscGVycy5jIHzCoCAyIC0tDQo+wqAg
wqAgwqAgwqB1aS9ndGsuY8KgIMKgIMKgIMKgIMKgfCAxOSArKysrKysrKysrKysrKysrKysrDQo+
wqAgwqAgwqAgwqAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPsKgIMKgIMKgZGlmZiAtLWdpdCBhL3VpL2VnbC1oZWxwZXJzLmMgYi91aS9lZ2wt
aGVscGVycy5jDQo+wqAgwqAgwqBpbmRleCA5OWIyZWJiZTIzLi5kYWZlYjM2MDc0IDEwMDY0NA0K
PsKgIMKgIMKgLS0tIGEvdWkvZWdsLWhlbHBlcnMuYw0KPsKgIMKgIMKgKysrIGIvdWkvZWdsLWhl
bHBlcnMuYw0KPsKgIMKgIMKgQEAgLTM5Niw4ICszOTYsNiBAQCB2b2lkIGVnbF9kbWFidWZfY3Jl
YXRlX2ZlbmNlKFFlbXVEbWFCdWYgKmRtYWJ1ZikNCj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZl
bmNlX2ZkID0gZWdsRHVwTmF0aXZlRmVuY2VGREFORFJPSUQocWVtdV9lZ2xfZGlzcGxheSwNCj7C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5bmMpOw0KPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcWVt
dV9kbWFidWZfc2V0X2ZlbmNlX2ZkKGRtYWJ1ZiwgZmVuY2VfZmQpOw0KPsKgIMKgIMKgLcKgIMKg
IMKgIMKgIGVnbERlc3Ryb3lTeW5jS0hSKHFlbXVfZWdsX2Rpc3BsYXksIHN5bmMpOw0KPsKgIMKg
IMKgLcKgIMKgIMKgIMKgIHFlbXVfZG1hYnVmX3NldF9zeW5jKGRtYWJ1ZiwgTlVMTCk7DQo+IA0K
PiANCj4gSWYgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgbXVsdGlwbGUgdGltZXMsIGl0IHdpbGwg
bm93IHNldCBhIG5ldyANCj4gZmVuY2VfZmQgZWFjaCB0aW1lLCBhbmQgcG90ZW50aWFsbHkgbGVh
ayBvbGRlciBmZC4gTWF5YmUgaXQgY291bGQgZmlyc3QgDQo+IGNoZWNrIGlmIGEgZmVuY2VfZmQg
ZXhpc3RzIGluc3RlYWQuDQoNCldlIGNhbiBtYWtlIHRoYXQgY2hhbmdlLg0KDQo+IA0KPsKgIMKg
IMKgIMKgIMKgIMKgfQ0KPsKgIMKgIMKgIMKgfQ0KPiANCj7CoCDCoCDCoGRpZmYgLS1naXQgYS91
aS9ndGsuYyBiL3VpL2d0ay5jDQo+wqAgwqAgwqBpbmRleCA5M2IxM2I3YTMwLi5jZjBkZDZhYmVk
IDEwMDY0NA0KPsKgIMKgIMKgLS0tIGEvdWkvZ3RrLmMNCj7CoCDCoCDCoCsrKyBiL3VpL2d0ay5j
DQo+wqAgwqAgwqBAQCAtNjAwLDkgKzYwMCwxMiBAQCB2b2lkIGdkX2h3X2dsX2ZsdXNoZWQodm9p
ZCAqdmNvbikNCj4gDQo+wqAgwqAgwqAgwqAgwqAgwqBmZW5jZV9mZCA9IHFlbXVfZG1hYnVmX2dl
dF9mZW5jZV9mZChkbWFidWYpOw0KPsKgIMKgIMKgIMKgIMKgIMKgaWYgKGZlbmNlX2ZkID49IDAp
IHsNCj7CoCDCoCDCoCvCoCDCoCDCoCDCoCB2b2lkICpzeW5jID0gcWVtdV9kbWFidWZfZ2V0X3N5
bmMoZG1hYnVmKTsNCj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHFlbXVfc2V0X2ZkX2hhbmRsZXIo
ZmVuY2VfZmQsIE5VTEwsIE5VTEwsIE5VTEwpOw0KPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2xv
c2UoZmVuY2VfZmQpOw0KPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcWVtdV9kbWFidWZfc2V0X2Zl
bmNlX2ZkKGRtYWJ1ZiwgLTEpOw0KPsKgIMKgIMKgK8KgIMKgIMKgIMKgIGVnbERlc3Ryb3lTeW5j
S0hSKHFlbXVfZWdsX2Rpc3BsYXksIHN5bmMpOw0KPsKgIMKgIMKgK8KgIMKgIMKgIMKgIHFlbXVf
ZG1hYnVmX3NldF9zeW5jKGRtYWJ1ZiwgTlVMTCk7DQo+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBn
cmFwaGljX2h3X2dsX2Jsb2NrKHZjLT5nZnguZGNsLmNvbiwgZmFsc2UpOw0KPsKgIMKgIMKgIMKg
IMKgIMKgfQ0KPsKgIMKgIMKgIMKgfQ0KPsKgIMKgIMKgQEAgLTY4Miw2ICs2ODUsMjIgQEAgc3Rh
dGljIGNvbnN0IERpc3BsYXlHTEN0eE9wcyBlZ2xfY3R4X29wcyA9IHsNCj7CoCDCoCDCoCDCoHN0
YXRpYyB2b2lkIGdkX2NoYW5nZV9ydW5zdGF0ZSh2b2lkICpvcGFxdWUsIGJvb2wgcnVubmluZywN
Cj7CoCDCoCDCoFJ1blN0YXRlIHN0YXRlKQ0KPsKgIMKgIMKgIMKgew0KPsKgIMKgIMKgIMKgIMKg
IMKgR3RrRGlzcGxheVN0YXRlICpzID0gb3BhcXVlOw0KPsKgIMKgIMKgK8KgIMKgIFFlbXVEbWFC
dWYgKmRtYWJ1ZjsNCj7CoCDCoCDCoCvCoCDCoCBpbnQgaTsNCj7CoCDCoCDCoCsNCj7CoCDCoCDC
oCvCoCDCoCBpZiAoc3RhdGUgPT0gUlVOX1NUQVRFX1NBVkVfVk0pIHsNCj7CoCDCoCDCoCvCoCDC
oCDCoCDCoCBmb3IgKGkgPSAwOyBpIDwgcy0+bmJfdmNzOyBpKyspIHsNCj7CoCDCoCDCoCvCoCDC
oCDCoCDCoCDCoCDCoCBWaXJ0dWFsQ29uc29sZSAqdmMgPSAmcy0+dmNbaV07DQo+wqAgwqAgwqAr
wqAgwqAgwqAgwqAgwqAgwqAgZG1hYnVmID0gdmMtPmdmeC5ndWVzdF9mYi5kbWFidWY7DQo+wqAg
wqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGRtYWJ1ZiAmJiBxZW11X2RtYWJ1Zl9nZXRfZmVu
Y2VfZmQoZG1hYnVmKSA+PSAwKSB7DQo+wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Lyogd2FpdCBmb3IgdGhlIHJlbmRlcmluZyB0byBiZSBjb21wbGV0ZWQgKi8NCj7CoCDCoCDCoCvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlZ2xDbGllbnRXYWl0U3luYyhxZW11X2VnbF9kaXNwbGF5
LA0KPsKgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHFlbXVfZG1hYnVmX2dldF9zeW5jKGRtYWJ1ZiksDQo+wqAgwqAgwqArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRUdMX1NZTkNfRkxVU0hf
Q09NTUFORFNfQklUX0tIUiwNCj7CoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxMDAwMDAwMDAwKTsNCj4gDQo+IA0KPsKgIMKgSSBkb24n
dCB0aGluayBhZGRpbmcgd2FpdGluZyBwb2ludHMgaW4gdGhlIG1pZ3JhdGlvbiBwYXRoIGlzIA0K
PiBhcHByb3ByaWF0ZS4gUGVyaGFwcyBvbmNlIHlvdSBleHBsYWluIHRoZSBhY3R1YWwgaXNzdWUs
IGl0IHdpbGwgYmUgDQo+IGVhc2llciB0byBoZWxwLg0KPiANCj7CoCDCoCDCoCvCoCDCoCDCoCDC
oCDCoCDCoCB9DQo+wqAgwqAgwqArwqAgwqAgwqAgwqAgfQ0KPsKgIMKgIMKgK8KgIMKgIH0NCj4g
DQo+wqAgwqAgwqAgwqAgwqAgwqBnZF91cGRhdGVfY2FwdGlvbihzKTsNCj7CoCDCoCDCoCDCoH0N
Cj7CoCDCoCDCoC0tIA0KPsKgIMKgIMKgMi4zNC4xDQo+IA0KPiANCj4gDQo+IA0KPiAtLSANCj4g
TWFyYy1BbmRyw6kgTHVyZWF1DQoNCg0KLS0gDQpNYXJjLUFuZHLDqSBMdXJlYXUNCg==

